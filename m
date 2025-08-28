Return-Path: <linux-kselftest+bounces-40129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F6CB39006
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 02:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FE01B28D36
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E94424E4B4;
	Thu, 28 Aug 2025 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kthf9cLr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228A123E356;
	Thu, 28 Aug 2025 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341109; cv=none; b=O4tZ9SjgiGvIZ1ZhwMdz9ckiO32lf5Bjp2NpbXj2f+dd8Tfnv9K6lW2KbPMZheiEleyiRs4g7wPo2h0I29Fi/CQg90zEEOiQF1Ba/Bm7/Z0LDHNJX77g+uReJGpsslH+nGrgIPUhmktzer19Sy+tENmniEjP4WNLgxk7+lSOm4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341109; c=relaxed/simple;
	bh=BquwX6HjvEBxZ0NOdjFPMl3JAQrw/BuuZkbNRV5kNDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lhp5s/CkPjAcevKyv2QH0Bt4DWm5eD1ZrgNRlGp0ZcfE8eRLPRMucU0BoJA0Nd857Qa/yZatQ0z86mYmcsHXrF+KF/D8MVLFBAEeNDQjqoJaqc4lWfOqTB5oaqlTghDUewMIAde2ZNHaJ2oZ4tOQ8ILYWY4rwbi4QDmA4vR/66A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kthf9cLr; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-324e6daaa39so425056a91.0;
        Wed, 27 Aug 2025 17:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341106; x=1756945906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YyzkIGkPcN4s/5n8XbmWu5wXR7Mhh7fBZ/cTvP3v7E=;
        b=kthf9cLrvUlHRl9ZgHdjkxQG2mJ6vw3loypCyE2wMBYlAO9oBEqWRV4wOD8Bk8yuWi
         b1QSRTcWTehK6HP3PWle3ne2kLKGCD+uT3WStJomK6r9Nf7gq+b9TQlOBbZdTlXLfIxP
         +OEWb3dDvulkXVhTq+Dgw4ycLWNlOaNjV6ZzlZlI49KqNbcwD8Pdb2BLRbx11Cgv4GJZ
         pKyNJj2SIaUPOZE71HYnvuylEMx5dBAXewCW3MFqrFQRGYD+p95cZZhuo6E1TMqkjUSh
         vRn3OSR3hE4medbPE7LUHhISFEF2UeVjN1FHMxlZN5EtAyD85tqGM8P8Q86U40IPJfVt
         0Flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341106; x=1756945906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YyzkIGkPcN4s/5n8XbmWu5wXR7Mhh7fBZ/cTvP3v7E=;
        b=WzQXRQCVv6SpV9JXox4zKAtcmi+pGk1Za13qxP9E1qHMklWBOgGbCjbbqVI3+CeSB1
         LxLOKRfOQZ3nYmjix1w3C04A8QiPjhqCEK+4SUUHUe+W4Q4FOmnYfiqa/lC8+Dl79wza
         yQSTCdAVwNDiSF1kCD5ajP4rRupGlGjhfOWMf2MsaqC9nVhMJ3u9IdFDSlsrlKHnbXUx
         tzCGP9ttkIM9ofcokkviXf4T/34TWm3wpHCyiZDy0utGXpJocOEhXJORe1U8i6iIxlWq
         EsrCZ5OicpHQZ2gt4JaS3PJ3m9dUHFTpGttH+35k+yxGv1XRGYYb+yxPb+MmcMhEezvC
         22lg==
X-Forwarded-Encrypted: i=1; AJvYcCVlJw6wasckE2W/OILGZGW/Tcjn9WWITg7CutLl5ENzeJ5NFgRuheamYPbaVsjHA2EGfSw=@vger.kernel.org, AJvYcCWAyvUpNAGwhL2pJAPP5bD+XzlDvJZa0FC4H8RqrAPdnhHS1iBqh176LXwuBjfCkacpXyUPclNR@vger.kernel.org, AJvYcCWE9DrMFIluZ7efBmGz043BTAzvORiIOe9Yl9yOmrfbR/nCso9wZViJj0egtMej7Rzb8IzsgCbUW2ookcPb@vger.kernel.org, AJvYcCWHvNxUXAdJjb4/RUYzTwwFPQkpJ4gGyugMzxq2kFl1tMxdtCHdqo95bOkmQzUgM+kxukiJ4IvurVPi1gwG@vger.kernel.org, AJvYcCXCDDgH/iB8QcVXuw4WzGdqFuFkAvp+5f62fI+FinQCtGW878JIXXoFZSAVSKay0hFN0YgG0ETxNnQai/SoPtIi@vger.kernel.org
X-Gm-Message-State: AOJu0YyhzruxUSsYuuWJYQPuDHTvrL+G97g0u0XmOEHUTZJ0lXiwty7t
	cV34jyEr5xItnsxWy3/z9iF84sYUGUDfCvWxbnVhUDWXoQ1C4pV1deoJ
X-Gm-Gg: ASbGncvYTpSXfM3Z/hKPWbYHVPicZPaQWW1SXrJrUs3mGStJX0ZaB9lNvdChg+DLkGm
	d9knlgafIsYnTwYXKXcZBk4ARz/I6TmzVJxVmhcdR+51U00OUWPiZkqfqqVlci/a94pxE6pk3+X
	RNJynNTiropF1b9yD7wFFaB8+w8wEEwq7KsbiX1EsEuISADPqs0wEmDj1tlIhHRpjhJNtVKqGSJ
	9TxBp6FlS5xdEwRkH3GZVWQbB4BKY0rMr8uMVwKrINgRXPxRWf9XjdxqoMxppF9BzyPclekN9rj
	5/3E/5XT3egA+316GrRIZcTEa2mWXZy35u45SV/4sS8RdI2HuHYI/7Pm9QtZpYlJC8eUwMhKZEB
	edUisQpG3f+6FGl5QLP8i
X-Google-Smtp-Source: AGHT+IH0iX22i5zp4tqvi0cHsT4JxA9i1Dra/FRoxR4Vn+2NrRWAtx9wzlm5+GyzO17IIEvA0poyuQ==
X-Received: by 2002:a17:90b:53cc:b0:327:aaeb:e805 with SMTP id 98e67ed59e1d1-327aaebf070mr1055603a91.21.1756341106213;
        Wed, 27 Aug 2025 17:31:46 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffb9d3bsm14220480b3a.23.2025.08.27.17.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 17:31:45 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 27 Aug 2025 17:31:36 -0700
Subject: [PATCH net-next v5 8/9] selftests/vsock: invoke vsock_test through
 helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-vsock-vmtest-v5-8-0ba580bede5b@meta.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
In-Reply-To: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add helper calls vm_vsock_test() and host_vsock_test() to invoke the
vsock_test binary. This encapsulates several items of repeat logic, such
as waiting for the server to reach listening state and
enabling/disabling the bash option pipefail to avoid pipe-style logging
from hiding failures.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 120 ++++++++++++++++++++++++++++----
 1 file changed, 108 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 183647a86c8a..5e36d1068f6f 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -248,6 +248,7 @@ wait_for_listener()
 	local port=$1
 	local interval=$2
 	local max_intervals=$3
+	local old_pipefail
 	local protocol=tcp
 	local pattern
 	local i
@@ -256,6 +257,13 @@ wait_for_listener()
 
 	# for tcp protocol additionally check the socket state
 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+
+	# 'grep -q' exits on match, sending SIGPIPE to 'awk', which exits with
+	# an error, causing the if-condition to fail when pipefail is set.
+	# Instead, temporarily disable pipefail and restore it later.
+	old_pipefail=$(set -o | awk '/^pipefail[[:space:]]+(on|off)$/{print $2}')
+	set +o pipefail
+
 	for i in $(seq "${max_intervals}"); do
 		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
 		   grep -q "${pattern}"; then
@@ -263,6 +271,10 @@ wait_for_listener()
 		fi
 		sleep "${interval}"
 	done
+
+	if [[ "${old_pipefail}" == on ]]; then
+		set -o pipefail
+	fi
 }
 
 vm_wait_for_listener() {
@@ -314,28 +326,112 @@ log_guest() {
 	LOG_PREFIX=guest log $@
 }
 
+vm_vsock_test() {
+	local ns=$1
+	local mode=$2
+	local rc
+
+	set -o pipefail
+	if [[ "${mode}" == client ]]; then
+		local host=$3
+		local cid=$4
+		local port=$5
+
+		# log output and use pipefail to respect vsock_test errors
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
+			--mode=client \
+			--control-host="${host}" \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest
+		rc=$?
+	else
+		local cid=$3
+		local port=$4
+
+		# log output and use pipefail to respect vsock_test errors
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
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
+		vm_wait_for_listener "${ns}" "${port}"
+		rc=$?
+	fi
+	set +o pipefail
+
+	return $rc
 }
 
+host_vsock_test() {
+	local ns=$1
+	local mode=$2
+	local cmd
+
+	if [[ "${ns}" == none ]]; then
+		cmd="${VSOCK_TEST}"
+	else
+		cmd="ip netns exec ${ns} ${VSOCK_TEST}"
+	fi
+
+	# log output and use pipefail to respect vsock_test errors
+	set -o pipefail
+	if [[ "${mode}" == client ]]; then
+		local host=$3
+		local cid=$4
+		local port=$5
+
+		${cmd} \
+			--mode="${mode}" \
+			--peer-cid="${cid}" \
+			--control-host="${host}" \
+			--control-port="${port}" 2>&1 | log_host
+		rc=$?
+	else
+		local cid=$3
+		local port=$4
+
+		${cmd} \
+			--mode="${mode}" \
+			--peer-cid="${cid}" \
+			--control-port="${port}" 2>&1 | log_host &
+		rc=$?
+
+		if [[ $rc -ne 0 ]]; then
+			return $rc
+		fi
+
+		host_wait_for_listener "${ns}" "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+		rc=$?
+	fi
+	set +o pipefail
 
+	return $rc
 }
 
 test_vm_server_host_client() {
+	vm_vsock_test "none" "server" 2 "${TEST_GUEST_PORT}"
+	host_vsock_test "none" "client" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+}
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=server \
-		--control-port="${TEST_GUEST_PORT}" \
-		--peer-cid=2 \
-		2>&1 | log_guest &
+test_vm_client_host_server() {
+	host_vsock_test "none" "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"
+	vm_vsock_test "none" "client" "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"
+}
 
-	vm_wait_for_listener "${TEST_GUEST_PORT}"
+test_vm_loopback() {
+	vm_vsock_test "none" "server" 1 "${TEST_HOST_PORT_LISTENER}"
+	vm_vsock_test "none" "client" "127.0.0.1" 1 "${TEST_HOST_PORT_LISTENER}"
+}
 
-	${VSOCK_TEST} \
-		--mode=client \
-		--control-host=127.0.0.1 \
-		--peer-cid="${VSOCK_CID}" \
-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
 
-	return $?
 }
 
 test_vm_client_host_server() {

-- 
2.47.3


