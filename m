Return-Path: <linux-kselftest+bounces-49207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3CDD3889E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 22:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6365130C8079
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 21:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ED43A0B0D;
	Fri, 16 Jan 2026 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZwkSOaH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B388C3090FB
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598956; cv=none; b=FKUZ95nlgycdnZggsbmrlP5HWv01sr8SYZiL6NGfymqfk1wiQrcvB3n192W1VC6itrDTUarAg5gCU3USXVzvva8gw7L9rsRPNQ+KZKSkK32PdBFAZ0iiWQfDTdi384E5Nxb4OG6o0MF0pgkhccxgNb2+XWT/AwjtTN1KDTQ0loY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598956; c=relaxed/simple;
	bh=P4erHizl27nbkGk13UaQgtaMcmfPrCQL8OW5nr9GtQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rcPmYG6SgKJdZbI6bDhHhR2LWY72NBeyBzUD1mXztttt3rs3hHQaG8T7gAniYKyUl9O7hGKI/RAIwJYzS+J9kjz1+A6B/Oc6vj+VC7qd66oqDF5n4/zGz/wX/2q4tV8MONbDrQkE4Jx7rxaNcUBU2MfrGFLFpcnbwyLKU9BuBtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZwkSOaH; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7927b1620ddso38027947b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 13:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598950; x=1769203750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=KZwkSOaH++WfAsT49gS6t09jAWBAhA1owZm4eUIbZ52rNMphxh4zJkKjRoPpCXrHw9
         ZQObJOt/c/5VwQN7p0orGkYUlA/SCKzMqYuRAu6HjXgP19Z8zWwQ4DlDHu46wqVCGx+i
         ydGgwgrmfKnv72aWDp0eDHC8i4t/jkIy4tIvKRa7vmTZfEGt045PtpaVBNQmT0VhnA4m
         HTfXawhEkjdQGoj9w3pBumXqeRSOxCwVWCoS45AL7uGhPwEEzxWNKzYVzfpC5RyRu/eW
         JpYAwZuGbPZshge3y01Q9NbRfCJuSJHQOwpkuEPzXy4WUrGsnW/gZdtgRid1ySQnyHr2
         Gdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598950; x=1769203750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=KcnJ0n1P2Y1D4XzKhxzalPp5piBBKz/ydZWWdq4EXMIjb5qVJ1MIXe2VHYIG/1UP9C
         TcEfapUaGJn33yvwFXlgCgNq0/JmlSL3ywHPce3ggvOyH1TJB13/6hSEmtU8V2Qd3QLt
         bSgqILnckWMDOV0W2BvTGwlFq2AMvusENhzD3rvJ8VUdAx7fa8kWxx6TvPpX17s6JwLX
         maSHs2pDPveG+TR4s7kiXLw68AZ7OqfYt5wRLvMhDVkjRuQh+EdvAP4ZYsCCFnjDxV+R
         jLKUtqp93mqONEqFb8alwPO44C3/JeF2mVaSETKPnL200DGIFusc3a1l2ffZ8ELYytdd
         EkAg==
X-Forwarded-Encrypted: i=1; AJvYcCX9A4aVo3aIPyQUaJFpqytzT83aeuNFWH8m9eQp+1rPOaCVIfsdMZLL1FrBgBjVr91hByhoLJ9VzptSxhQEJM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFdQP7DuFjTHaHokQcDqPbJrmWYMcMbAmosAxazN3BRbyXhcF7
	3VSJGa/ucv6vY/sbz6MrbifTgHmqyR/EEYLRv14Z84FN1PI4Jnq59FyR
X-Gm-Gg: AY/fxX4OenyL9HqkV4d2M/4qJkp2jQQhx3B0mhJY1EOrUOuevCAslF1QGTtTZY3zcAy
	r4PJOErsWLUqUlgBX76FKOpeQ/D/bORzwPtOHdgyXjU+N8SpSIIQJgEvzrYroOWxqxmxrS9Sjjs
	bdQP0TK7vEJp1G+3lIw7XlBD/KkmUTDMzYBbzqeMrdC3FYe1dvKTZcPBKmN0d/WIwYFAZHBGtNX
	xbaJ0CBKW2HEEd9EiA1vRsbSINhBDUCA7BtPaT5RrOBdM3H/AJpDHffnA4NQuK+K3RdF+itW8J/
	9kfeG9K00sajneAtD5y4UcU9VgV/VNltV3ao6NfCWvzHWor5Mfspy+FsNrHBbNYf8Nax5JAvkmQ
	eSQXVbb9bE4bdoARbFdckLLMiWf6AQjz9h6K3TQu7Hl7xFpG/rXzlXCUpHnxaGZzGg3KwI7hzF7
	Dli7dUZDyI
X-Received: by 2002:a05:690c:dd4:b0:793:baf5:ffcc with SMTP id 00721157ae682-793c57be153mr40080797b3.2.1768598949786;
        Fri, 16 Jan 2026 13:29:09 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66f6f97sm13467037b3.16.2026.01.16.13.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:09 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:48 -0800
Subject: [PATCH net-next v15 08/12] selftests/vsock: use ss to wait for
 listeners instead of /proc/net
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-8-bbfd1a668548@meta.com>
References: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
In-Reply-To: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Replace /proc/net parsing with ss(8) for detecting listening sockets in
wait_for_listener() functions and add support for TCP, VSOCK, and Unix
socket protocols.

The previous implementation parsed /proc/net/tcp using awk to detect
listening sockets, but this approach could not support vsock because
vsock does not export socket information to /proc/net/.

Instead, use ss so that we can detect listeners on tcp, vsock, and unix.

The protocol parameter is now required for all wait_for_listener family
functions (wait_for_listener, vm_wait_for_listener,
host_wait_for_listener) to explicitly specify which socket type to wait
for.

ss is added to the dependency check in check_deps().

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 47 +++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 4b5929ffc9eb..0e681d4c3a15 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -182,7 +182,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh; do
+	for dep in vng ${QEMU} busybox pkill ssh ss; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -337,21 +337,32 @@ wait_for_listener()
 	local port=$1
 	local interval=$2
 	local max_intervals=$3
-	local protocol=tcp
-	local pattern
+	local protocol=$4
 	local i
 
-	pattern=":$(printf "%04X" "${port}") "
-
-	# for tcp protocol additionally check the socket state
-	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
-
 	for i in $(seq "${max_intervals}"); do
-		if awk -v pattern="${pattern}" \
-			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
-			/proc/net/"${protocol}"*; then
+		case "${protocol}" in
+		tcp)
+			if ss --listening --tcp --numeric | grep -q ":${port} "; then
+				break
+			fi
+			;;
+		vsock)
+			if ss --listening --vsock --numeric | grep -q ":${port} "; then
+				break
+			fi
+			;;
+		unix)
+			# For unix sockets, port is actually the socket path
+			if ss --listening --unix | grep -q "${port}"; then
+				break
+			fi
+			;;
+		*)
+			echo "Unknown protocol: ${protocol}" >&2
 			break
-		fi
+			;;
+		esac
 		sleep "${interval}"
 	done
 }
@@ -359,23 +370,25 @@ wait_for_listener()
 vm_wait_for_listener() {
 	local ns=$1
 	local port=$2
+	local protocol=$3
 
 	vm_ssh "${ns}" <<EOF
 $(declare -f wait_for_listener)
-wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX} ${protocol}
 EOF
 }
 
 host_wait_for_listener() {
 	local ns=$1
 	local port=$2
+	local protocol=$3
 
 	if [[ "${ns}" == "init_ns" ]]; then
-		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}" "${protocol}"
 	else
 		ip netns exec "${ns}" bash <<-EOF
 			$(declare -f wait_for_listener)
-			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX} ${protocol}
 		EOF
 	fi
 }
@@ -422,7 +435,7 @@ vm_vsock_test() {
 			return $rc
 		fi
 
-		vm_wait_for_listener "${ns}" "${port}"
+		vm_wait_for_listener "${ns}" "${port}" "tcp"
 		rc=$?
 	fi
 	set +o pipefail
@@ -463,7 +476,7 @@ host_vsock_test() {
 			return $rc
 		fi
 
-		host_wait_for_listener "${ns}" "${port}"
+		host_wait_for_listener "${ns}" "${port}" "tcp"
 		rc=$?
 	fi
 	set +o pipefail

-- 
2.47.3


