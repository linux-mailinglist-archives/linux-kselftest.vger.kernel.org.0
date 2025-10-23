Return-Path: <linux-kselftest+bounces-43827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 509CDBFEC63
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 825A34E8046
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F0B212572;
	Thu, 23 Oct 2025 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flCqHk1m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148381DFDA1
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181230; cv=none; b=sbp8j6fEKTpkarj94jY7+JjgmnKv2/ZxwMJ+0lBAyC4bHluw3kNXSXNIJDVVCUxmlJUfy57u4g6kSF317hb31Sz2G68XiJOrH9CR5mHZ8hKQPWntjR3iXJtXNAUUxEJN/D5DJ8gBdhWLUtdCmZu0S+vFdQWKv/xcOgCijf/dhwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181230; c=relaxed/simple;
	bh=bLgJRj0B3l4I9LRxTwg4ipTz6i5xRpftUXJZZBIn7VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ldQbm2trp/oon/7BDsRV3BkQ5Bf9CgblOpv639wI5R0v/JbnioqTBa++ZpHbCd7LMsZp+BZPcQh49W9h3S8E2fxC332wN2PC41hyDDpKRYaqgIUBtNzPDMRYgRM5PBCj7UlW9dzMpD2ExuUAVfaE+OMmEJHE5DZopMd6/7UM+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flCqHk1m; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a27053843bso350748b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181227; x=1761786027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysnAf5Q6/F37oVxnktahtq8MWGwMsYn3elO8YpXbx58=;
        b=flCqHk1mDLdG9p/ErVgof8Zm1i7YjDT5YgjAFh3ysADTpr8bR5SXu4xYq1AHEBi3Vc
         3p/19KGyH1ABCaoQHxQMeZjEWLgylM5wNjVJv0/dJEyYQpayiz+fLd275/kq99Gan46n
         8KkQ41Ny9HrlivebrJuY5a0BARWuYbmm0MvoO7Hn529x8SCHYvmaK5RFV5qkOq/satQx
         OxdRSOduuVDIat+TDTJA1Ne0byneZCYPyGaGuOLpphlOoKu3152D/SJjDcPiQh5dC5Ap
         eDmx9Hz4Honp21eveZbxYi4XU0vuo7jRaJAVRYSpZ/BqlI/mHKFqwzs7XmQfs7qTB5/S
         bkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181227; x=1761786027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysnAf5Q6/F37oVxnktahtq8MWGwMsYn3elO8YpXbx58=;
        b=EYSf0bIUKulf4zZVYamWKY63rwBrQCAGRTw5xqaPlW7doGIrhZfKXUl8v4KgWWFIJk
         BTtelxfQHqXmrz6Pk5thCV4EJdYPPg4hLScvWFs/hv5aQ6UpxEoJ9TNUvppOGHyF3T1M
         kZusek6DG0ajyCw8r19MN2rSR4i2Ev56u/4NjJcbewh1VR1qFCTP1W6tqY8+QpZAuXjR
         mHPNGhVYEMmc6UnO4R590dnsCPO2kNNGscQiHSf5Bp1XL3owKPThhOizbJ1zWMSpEUjf
         wm8u5EyAMN9SzC7DYwz+oSuQbNuinIFag1wEIbd8hvOh5/jWGxAJ/d+Nnr+IPniwdK2p
         XWQg==
X-Forwarded-Encrypted: i=1; AJvYcCXR1TPFDnL8H2TG9JjIbCukCpqetGLH6jRA3JKLKn7DZqKMcCy6DYFuGetBs/CCmu0ocSaSqAZ3xmzxjts9IIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl5Hu6KNC9XjTTj+zeNCKTtL9X0l1rODmU52OCGMhIbZ0BxfXt
	hzdRqAUvwFKPt4lDCLc5tqnVJNrYJ3PyZrn05mQ2Xgc3ZNE8/8VPoPnd
X-Gm-Gg: ASbGncvPw6Mcs7rnIONpS8OFq1RgTahWvDdOl2ZjzWQeeurICJOFBDyXj+k45MNLbuh
	cWaCfqWTrE44GMslxI5l41BNAQsmNGeoHtZHZz6dy2eSlfwkCvVfiTw8GXo1HFp9e5aHT792a1L
	Ueo2NuMdGMNKmDuinq3AYyUWJCKQx+xz5blza+dYad68rB3E+08kr9e2SlNYJyiGlkHquAB5Ufs
	nyGsxuhJRHyG1pvv5B/X97SpHrgGLaAljrbWTM23Lz5jODjMIXNxBT+GU84muENKtacj2pDaabP
	dVmG9kY7gO77g8/RJu/spyCi+ZawYvrxJiccC1O5ShSOUaDPUem9hzpdEWZmPsyAn1pCvOw3ca/
	tT/3y13GqoxMqXI7/zJnC5sNRkI6fFPzDkm7s02R3TzxjZo09M4pCpdetpSrmymT8b9B7KCDoQx
	TnK5Uu7VNS
X-Google-Smtp-Source: AGHT+IHOazPmZapnzVoec11my1SEQGOMvfwZs/K9HZJGzOPAxbA0ZzCZ6eN45sS9QYFtvW0q4Wovgw==
X-Received: by 2002:a05:6a00:4652:b0:77f:11bd:749a with SMTP id d2e1a72fcca58-7a220d2330amr21377015b3a.20.1761181227244;
        Wed, 22 Oct 2025 18:00:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274abf6d5sm563573b3a.33.2025.10.22.18.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:26 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:07 -0700
Subject: [PATCH net-next 03/12] selftests/vsock: reuse logic for vsock_test
 through wrapper functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
the vsock_test binary. This encapsulates several items of repeat logic,
such as waiting for the server to reach listening state and
enabling/disabling the bash option pipefail to avoid pipe-style logging
from hiding failures.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 131 ++++++++++++++++++++++----------
 1 file changed, 92 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index ec3ff443f49a..29b36b4d301d 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -283,7 +283,78 @@ EOF
 
 host_wait_for_listener() {
 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+}
+
+vm_vsock_test() {
+	local host=$1
+	local cid=$2
+	local port=$3
+	local rc
+
+	set -o pipefail
+	if [[ "${host}" != server ]]; then
+		# log output and use pipefail to respect vsock_test errors
+		vm_ssh -- "${VSOCK_TEST}" \
+			--mode=client \
+			--control-host="${host}" \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest
+		rc=$?
+	else
+		# log output and use pipefail to respect vsock_test errors
+		vm_ssh -- "${VSOCK_TEST}" \
+			--mode=server \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest &
+		rc=$?
+
+		if [[ $rc -ne 0 ]]; then
+			set +o pipefail
+			return $rc
+		fi
+
+		vm_wait_for_listener "${port}"
+		rc=$?
+	fi
+	set +o pipefail
 
+	return $rc
+}
+
+host_vsock_test() {
+	local host=$1
+	local cid=$2
+	local port=$3
+	local rc
+
+	# log output and use pipefail to respect vsock_test errors
+	set -o pipefail
+	if [[ "${host}" != server ]]; then
+		${VSOCK_TEST} \
+			--mode=client \
+			--peer-cid="${cid}" \
+			--control-host="${host}" \
+			--control-port="${port}" 2>&1 | log_host
+		rc=$?
+	else
+		${VSOCK_TEST} \
+			--mode=server \
+			--peer-cid="${cid}" \
+			--control-port="${port}" 2>&1 | log_host &
+		rc=$?
+
+		if [[ $rc -ne 0 ]]; then
+			return $rc
+		fi
+
+		host_wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+		rc=$?
+	fi
+	set +o pipefail
+
+	return $rc
 }
 
 log() {
@@ -322,59 +393,41 @@ log_guest() {
 }
 
 test_vm_server_host_client() {
+	if ! vm_vsock_test "server" 2 "${TEST_GUEST_PORT}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=server \
-		--control-port="${TEST_GUEST_PORT}" \
-		--peer-cid=2 \
-		2>&1 | log_guest &
-
-	vm_wait_for_listener "${TEST_GUEST_PORT}"
-
-	${VSOCK_TEST} \
-		--mode=client \
-		--control-host=127.0.0.1 \
-		--peer-cid="${VSOCK_CID}" \
-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
+	if ! host_vsock_test "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	return $?
+	return "${KSFT_PASS}"
 }
 
 test_vm_client_host_server() {
+	if ! host_vsock_test "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	${VSOCK_TEST} \
-		--mode "server" \
-		--control-port "${TEST_HOST_PORT_LISTENER}" \
-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
-
-	host_wait_for_listener
-
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=client \
-		--control-host=10.0.2.2 \
-		--peer-cid=2 \
-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
+	if ! vm_vsock_test "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	return $?
+	return "${KSFT_PASS}"
 }
 
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=server \
-		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest &
-
-	vm_wait_for_listener "${port}"
+	if ! vm_vsock_test "server" 1 "${port}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=client \
-		--control-host="127.0.0.1" \
-		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest
+	if ! vm_vsock_test "127.0.0.1" 1 "${port}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	return $?
+	return "${KSFT_PASS}"
 }
 
 run_test() {

-- 
2.47.3


