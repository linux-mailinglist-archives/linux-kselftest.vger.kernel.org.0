Return-Path: <linux-kselftest+bounces-43708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F16CBF9547
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89A3235424D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D522F0C69;
	Tue, 21 Oct 2025 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/25T2Bd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A12E7BA5
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090437; cv=none; b=SOLgdcRbqxj6CY+EePvyxxncdglwKQD8CxTH9E0ID5nK+ZztSRDcDd//PdT2BKjrUzHNNlz1pj4opDtXCzP36ymeBYQY+7PyF8rWdQioLM7YBEoZmAb+oNdBwCcmsDhwKqFRtCCl5hAe9mE/wbmCdfg9OPaZ7S1XpBiJ3DEA/0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090437; c=relaxed/simple;
	bh=1TJpetkZxtBQiB7nUe4Rc6HDEslWsfWsLeGiK/zQyW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pufy7aY2XPwIsT2oXiYqeguw0wDu/M0Y4WXJTW/5dlDbI++2njyXvNt2EosftvGi5uMLSF62apN5LY/9x+mO9HqIOcThYZW9vtqSIU+nOd+YKKxVdQRLVomdklCtU8gHvqHYgRV95C/Btz5mRJAbNy8rqndQ1zx2ZGlwXK5c+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/25T2Bd; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso5710063b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090429; x=1761695229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bp4Nw6yXc3Wo3rOJsEv9cE/uO6VvL+09gH92ff2ezzc=;
        b=T/25T2Bdj+e1EgSp8QyZaPBc6GRNHzdwS8hilo/vEDQREmT84YiYUYxl4K9+WjY4rS
         ZsoElTzdHbxvUMcIi+boXwJqGqzpqTaop95hmNc7uSXn9h/QJBw/MnvRqoXiF5rCkXsn
         /hG1Jixn+Axlett/YZcVSVz4+IdktVd7h10FBFEdozP6BlBsnKmrGqmJ1Z4VXO+JH/Os
         hBkKCvN4wOCEM++6PMIy62lhVrRcxdSQ5td3+47692sK4T3lNkmOEisJFK2paNLDuUcr
         me42/3zOs4jwDSe8/pACiPmpS0ZzBYCNJLoCHJbUqe5Bm6FGhVIC3rDXbqbRHjCWrQfv
         Lskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090429; x=1761695229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bp4Nw6yXc3Wo3rOJsEv9cE/uO6VvL+09gH92ff2ezzc=;
        b=NPTIp3F98iXFENCzs/Qm2W2ZK/YS6audNzm0X+o+E1JtUDL8mgsZvd8YSc37x9CEsZ
         i5kAws/rOS27I0d+OQtgy+tX11fEWD8nOmjK7g2RCMd6+nd8xvqWhSpuozCIa5uYYSb3
         sIwJqNcU8khPnQToWicrjPfCUFrUiWHTzyh5WXOtXq0jA3BvnyRxhnzGjeQ+P6PtPf/T
         WxMfla2pL99WTn2nPc+8FwhBPsxRT2tjxYlQ1/zJKqQtQVM8BYat6dUo0DyZ1twcmj38
         pCV7UDh0IxNVv4fYdoS9Xsa/L4z5H1qU+tmJYHxNYphvugFLPkzXUvPN5RQ2/ULzjLvZ
         CBtg==
X-Forwarded-Encrypted: i=1; AJvYcCVDWvNvXsRwOMtym/7ws89C39GdcSDe90G9I8NKJNLf4h5uB+YI7Q2Dui4IDGeIzQNyA8YroryRMKHw/tovluI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5aegPofrd5fHzrO3jmGAjJWz1K4MX1TPZLKtRcSpjPdeGdYaJ
	mpXefSlE/y1+vmpnvd+9JB2FScvURO4Zpya2TdLaQHPfs4rHxrNLo/GK
X-Gm-Gg: ASbGncsKmGK+iFTmbsO94uGIjiL6ONqEf/+GlIzOya/HNNfuIHsUexYEU082+zrghgE
	fjh2yPTMAfG1pesrJFKUOVsQc8cSPNoxZ+9SUWZ+qJmve1axpyPxUgUNz5y9p/dyKEbd8jYhzkZ
	2lesJH4UIBp8UzPwZeJkrK8bB/gcQe95u1FPE8l84+APg5AzUpbwWPrRyTjf+nd+Q2o3Ep3ww8z
	cMlhl3ltleRE11tznmf3n0EZgQ4/aVSGHKBwVLG2qOVnhykAmd5Rj7j+TLfDv1wr7bNdylBx7lc
	fXi9sP+FqybquNNsjD0kZsW/4hR/6ihsprNrw5t9hYEtAAyDOG63swIRxzW/D8YqE3WGXSywKCK
	qQb8IGljYsQkznn0Nki1INIKQ5OeS5BjlI8pH8J5OxqcMsdLrZOAx421zeVAcEanvrTj7f1kE3K
	Er9jVTD9Y=
X-Google-Smtp-Source: AGHT+IFtE7kUaxGGBCIPvCA5xq+X+CjTxjkLXDamZJvTdeDWKXgLXL+jJ+B0+JzhKzpp/1MhbmJcug==
X-Received: by 2002:a05:6a21:7e8a:b0:338:614f:aac4 with SMTP id adf61e73a8af0-338614fab5amr6788012637.29.1761090429512;
        Tue, 21 Oct 2025 16:47:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a25f41ad15sm2272286b3a.41.2025.10.21.16.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:09 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:54 -0700
Subject: [PATCH net-next v7 11/26] selftests/vsock: avoid multi-VM pidfile
 collisions with QEMU
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-11-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
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
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Change QEMU to use generated pidfile names instead of just a single
globally-defined pidfile. This allows multiple QEMU instances to
co-exist with different pidfiles. This is required for future tests that
use multiple VMs to check for CID collissions.

Additionally, this also places the burden of killing the QEMU process
and cleaning up the pidfile on the caller of vm_start(). To help with
this, a function terminate_pidfiles() is introduced that callers use to
perform the cleanup. The terminate_pidfiles() function supports multiple
pidfile removals because future patches will need to process two
pidfiles at a time.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 51 +++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 29b36b4d301d..9958b3250520 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -23,7 +23,7 @@ readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
 readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
-readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
 # control port forwarded for vsock_test.  Because virtme-ng doesn't support
@@ -33,12 +33,6 @@ readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
 # add the kernel cmdline options that virtme-init uses to setup the interface.
 readonly QEMU_TEST_PORT_FWD="hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
 readonly QEMU_SSH_PORT_FWD="hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
-readonly QEMU_OPTS="\
-	 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
-	 -device virtio-net-pci,netdev=n0 \
-	 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
-	 --pidfile ${QEMU_PIDFILE} \
-"
 readonly KERNEL_CMDLINE="\
 	virtme.dhcp net.ifnames=0 biosdevname=0 \
 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
@@ -89,17 +83,6 @@ vm_ssh() {
 	return $?
 }
 
-cleanup() {
-	if [[ -s "${QEMU_PIDFILE}" ]]; then
-		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
-	fi
-
-	# If failure occurred during or before qemu start up, then we need
-	# to clean this up ourselves.
-	if [[ -e "${QEMU_PIDFILE}" ]]; then
-		rm "${QEMU_PIDFILE}"
-	fi
-}
 
 check_args() {
 	local found
@@ -188,10 +171,26 @@ handle_build() {
 	popd &>/dev/null
 }
 
+terminate_pidfiles() {
+	local pidfile
+
+	for pidfile in "$@"; do
+		if [[ -s "${pidfile}" ]]; then
+			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
+		fi
+
+		if [[ -e "${pidfile}" ]]; then
+			rm -f "${pidfile}"
+		fi
+	done
+}
+
 vm_start() {
+	local pidfile=$1
 	local logfile=/dev/null
 	local verbose_opt=""
 	local kernel_opt=""
+	local qemu_opts=""
 	local qemu
 
 	qemu=$(command -v "${QEMU}")
@@ -201,6 +200,13 @@ vm_start() {
 		logfile=/dev/stdout
 	fi
 
+	qemu_opts="\
+		 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
+		 -device virtio-net-pci,netdev=n0 \
+		 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
+		--pidfile ${pidfile}
+	"
+
 	if [[ "${BUILD}" -eq 1 ]]; then
 		kernel_opt="${KERNEL_CHECKOUT}"
 	fi
@@ -209,14 +215,14 @@ vm_start() {
 		--run \
 		${kernel_opt} \
 		${verbose_opt} \
-		--qemu-opts="${QEMU_OPTS}" \
+		--qemu-opts="${qemu_opts}" \
 		--qemu="${qemu}" \
 		--user root \
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
 	if ! timeout ${WAIT_TOTAL} \
-		bash -c 'while [[ ! -s '"${QEMU_PIDFILE}"' ]]; do sleep 1; done; exit 0'; then
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
 		die "failed to boot VM"
 	fi
 }
@@ -507,7 +513,8 @@ handle_build
 echo "1..${#ARGS[@]}"
 
 log_host "Booting up VM"
-vm_start
+pidfile="$(mktemp -u $PIDFILE_TEMPLATE)"
+vm_start "${pidfile}"
 vm_wait_for_ssh
 log_host "VM booted up"
 
@@ -531,6 +538,8 @@ for arg in "${ARGS[@]}"; do
 	cnt_total=$(( cnt_total + 1 ))
 done
 
+terminate_pidfiles "${pidfile}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3


