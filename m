Return-Path: <linux-kselftest+bounces-45165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3D6C42F23
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 17:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 687054E84E7
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 16:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B92C239591;
	Sat,  8 Nov 2025 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPCTxuIJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72C622CBC0
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617717; cv=none; b=TCor2y3qEfIIUc+8ABF8WoFX4qEGZ1KqVFUqMXEbnGD/wyquQcLqWw+eWnw4fSAKm6vlcPG26SwfvDhhZitAdUGXGDLEOZUU5BUiKNl6XI58ZH5ilE0WgrMl3AursFcyAwsMdDJMF9ar7Pl1PR3P1wLnfEUKujcMbkJJIeGuIoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617717; c=relaxed/simple;
	bh=eLu5JMiHu7of9BZggEGnla9HL0md05KgCo8UZ0w6Q1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/ftEZcyPt+BYLCCFIc/5YWt3yMcEY1suxqUHoUTSB/f5saC7gW6Q6P5t/F7VMZ2hEViViML+rzbasaRz8Ybs0fwKiaNQAr+xkkaoNuVdM24mEx9Ypa6OvJxhOEAIgC+rjoHbDJtcVdBgkM9apZRQEYpKc7wGKnbFmjycDiZYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPCTxuIJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297dc3e299bso8690515ad.1
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 08:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617714; x=1763222514; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ld63LQM/QM5aoQNbMBPk41vQtmCfRJO34YdHJwziNzk=;
        b=NPCTxuIJHabFaOwD2E4GVIOm4tOLkz+JO7jeDFu9psOHQjSKpxoEW5W1b80bihtYMs
         tlJ/e8vY+69SSVQWcPMVX0t8wDFTmfJdCYorNr/dPQ6s2J7lfSqoeNod/K+pNt2azs+2
         erHAPwGH+ZZotQNrfwoMkdOpc5RrpUwvVsTpRRGqMrrt3bfCJr+Hl8XI9P/KNmN1zhqh
         sI3g0hClh6MH1aQ6o+xMuuviw+4MjAWZMOwvD82vA+0GWaLTVPrvGeK79pFbYYIkexq1
         zmRGgWoYlVyjn7fr3+NaD6aRstT8l15i7JgTX1on/UvTiK1lr7wI4IqWPeEboN7AE97c
         VuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617714; x=1763222514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ld63LQM/QM5aoQNbMBPk41vQtmCfRJO34YdHJwziNzk=;
        b=I5bulHI4xMei2XkFRk+X2sR+06JUdF97Sstv1uHmgrNRzLohfH81o2ce86tDc/rt3g
         Ftqq2NeDDGkNabvH/N5JNpuBjz0ELtmU9Vr2ouP8I07HTZevbgd1CohIVDMRE/tgsSB6
         HR2iyGhlZCfDo9fX+o63nvy3h5DmtagzVft4e89EbY/IIWt53XIEg2ykQg8z4sW2ndbP
         jxyfMd+2v2OUlJaRiKQZV8f1py4hFJkbvfvAsynu3DeAqaHikAZVAc6Y4Gw46L1NePip
         Uz/OvyEeSqfDzGNlDWXVvNUL9dp/61M0veLI3JaROfz7+zzgGjBKVZ1+KAlfQPen14kh
         s9CA==
X-Forwarded-Encrypted: i=1; AJvYcCXZf9/LBKWB6pqvqKcfvEIjoPmC5YIcRzSvamrq9cxf012TIWQFpQoaNBE9DDKfvb+GoNzxXhHD0sAxq0deeWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysTUJ2VIHsZnSTRB3khxZgca7o7wXXw6BmdVwySg5NQ94skZ/7
	GP8GfGkIYtnm4IvaRTaNhlVCWrq+XgXfbxHtF0eYYUZ3G2Xv5AAnjLWl
X-Gm-Gg: ASbGncsONh2MD92NkbNkhy4luGttukuA28TPW4hhgo2y1j4KHqi1JChtRWOt4b20w52
	Va1HMl/+mVXkUoR9SERFSr7Gym4AoisXb1wIZKvpvRvYDbuLZ8M5oNZVKcN/vpeep5jwk3CkXWk
	lw5FHFpdTQJYD4edsMtlDxzN8JZQn5c8pK3sTGfvndAg/dGEVRbJUBrojJ4MtPlbpELFuwactJ5
	TK09wJLpC2sezdubprFlrxezGDUlFmk41IFLPJr7trVudy0FT8fhd9ZtcHZm0Hfq+xH/BzCriQH
	4vO2I3RjWAjm3suGkglE7VCV7lQrbSptYb7cZzp+iugj3FqH6vx07h4idzC0dyRl8o+jRZFmvDw
	R/NrI0y6OmKS79MBid6J2Zk8FwLuZgPzZXbflqHiWkgWjTyTDWsTQPhPVDeJ2mqhNFJHlJe/Zuw
	==
X-Google-Smtp-Source: AGHT+IGifjrTmGVD9wlbbooqM+v0wrdw8qePPIjfo/9CbYLQnx0+xdbZOZ5/Z/0HPHNkoo96/RnkPQ==
X-Received: by 2002:a17:902:ea0d:b0:288:5d07:8a8f with SMTP id d9443c01a7336-297e5665a51mr40532995ad.24.1762617713853;
        Sat, 08 Nov 2025 08:01:53 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5d66dsm93126765ad.37.2025.11.08.08.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:53 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:54 -0800
Subject: [PATCH net-next v4 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-3-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
the vsock_test binary. This encapsulates several items of repeat logic,
such as waiting for the server to reach listening state and
enabling/disabling the bash option pipefail to avoid pipe-style logging
from hiding failures.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- remember to disable pipefail before returning from host_vsock_test()

Changes in v3:
- Add port input parameter to host_wait_for_listener() to accept port
  from host_vsock_test() (Stefano)
- Change host_wait_for_listener() call-site to pass in parameter
---
 tools/testing/selftests/vsock/vmtest.sh | 135 ++++++++++++++++++++++----------
 1 file changed, 95 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 01ce16523afb..3bccd9b84e4a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -272,8 +272,81 @@ EOF
 }
 
 host_wait_for_listener() {
-	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+	local port=$1
 
+	wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+}
+
+vm_vsock_test() {
+	local host=$1
+	local cid=$2
+	local port=$3
+	local rc
+
+	# log output and use pipefail to respect vsock_test errors
+	set -o pipefail
+	if [[ "${host}" != server ]]; then
+		vm_ssh -- "${VSOCK_TEST}" \
+			--mode=client \
+			--control-host="${host}" \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest
+		rc=$?
+	else
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
+
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
+			set +o pipefail
+			return $rc
+		fi
+
+		host_wait_for_listener "${port}"
+		rc=$?
+	fi
+	set +o pipefail
+
+	return $rc
 }
 
 log() {
@@ -312,59 +385,41 @@ log_guest() {
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


