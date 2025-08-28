Return-Path: <linux-kselftest+bounces-40130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F269B3900F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 02:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060371C2243F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F7258EEB;
	Thu, 28 Aug 2025 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFQd4hfa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C73247DE1;
	Thu, 28 Aug 2025 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341112; cv=none; b=aadupSdj+Kz20/q16/DIMrFOw26krXm30sv5XPAP1KQUxezQW72zeJxMjpyAIvpW05Iu1UgwckbyCm+LjQxSiRClEtWNkstzgiM07s1ePbdphQeKX1BmrwAcCj/BsGL5Ajo8dIIFIbdZ1HmrsOsh10spW7pQBk3bgbS2KwwI+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341112; c=relaxed/simple;
	bh=XSuSDmrQjNV3qL9yGGRj1Q8lZlo1XU+mOED6UtxnpQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ntb9Pop4Sd+F9htgDwGV9MjjnWA3acXrL4QXwqtKyHNv7Ohp6T7NHCa+/uhc41+vu+rO1eR8MleGLFQ4+O60xVguVIiVkcsnuJssA5vLIxBTQweFPwtTSvuiB0PMkYMqFpZ2wgPo+O1k7c/3/R2AkKUcqwV/VqUK0VI+g6SF6II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFQd4hfa; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-321cfa7ad29so1129149a91.1;
        Wed, 27 Aug 2025 17:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341108; x=1756945908; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfpxmYb+AZOCfr2AnpYy9iPWtYGvnkyYzAlBopdEFyQ=;
        b=dFQd4hfapXtfItey9G+BcUl8zTJQxqzxdoiKtRmQBD6FLaTL35iSteW9gMxflm+lC0
         hM1r7gw9ii3mb1rg9q0Pn6r1bsPOBeNQAJ5GYLS9G7UYK10hXwxyy3oeqJfp1WUAiZ5R
         WqpPt78Bw1TYO8/6u7KD0HXkM90xcteZt5eCF8dtWLLoidbZqt6x0FrbQyG93Kz+PBTP
         VU3yleiurfq/zePzY/X2lrDIvXk+01cE23anZDjLVHFiLI1xEaTvGBB02O4fE2DmJyNm
         re9eeOPOng5Giio/xbpQv8Uf1qRHFHlTp/MN3SJqBuXefAzcUkwMztxKyfFoQ/vSe/Vh
         Jsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341108; x=1756945908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfpxmYb+AZOCfr2AnpYy9iPWtYGvnkyYzAlBopdEFyQ=;
        b=vXSIHeSndkIBA1Nbu8gQy3arPvMugWPigISOBMKvrgAZ4e87+4W1E61TryOGNDih+p
         Ar+HhnKxFkphs5RxjouBb9aNddreSJQYn14C97v4uuMSbHiiepkdGnZY5uZ5Tixw3TlK
         PX6ZYRZi3j9M3NljPKwCYPZYtyZYaLg1/amN/V81f9EGIo4TDrG0EucYVc9JUQrGUanl
         JulYtTV2+M+sF5tgTOtBiTCG2np3ifQF9i9lw2nc+n0TRugQAVkYPPzHq70nDvXQUIKi
         nYI934uHVo3iIVni9LeVZ6FdbjAhlAY6ooV0Q4CAMQpuEsR8Epq22TvSoSslz41BrlyF
         wyCg==
X-Forwarded-Encrypted: i=1; AJvYcCU3yxIfwDGkXusMkSPjrUvH5kr2kpJ+YHeZRLrSL2fRUmUP/8RgOw5uIUVrNIi2zUtGyIQEZfCh@vger.kernel.org, AJvYcCUSiMH+5pa7Lo0HEy0FoMjQOmYHqW4rIwRnLCMWJN9IMwg5zh+0k2wOpqsDLnXgM+3XXj3SbQyUy0Gal2Hz@vger.kernel.org, AJvYcCW4Ber8QHlP6HEkeSYQnMGX0WOmtup1KWNI4U7Uadrq6FPAi8Ejm9BJsb1vHc0kYLrJEXJiPvVOBesqb3GT@vger.kernel.org, AJvYcCWMJuU9b/9IUU3wA5d/72HVhqTqRL1+JK+7+aeHtFQCu/sgoTfdp9bt+fTEfrl2MI/7Apo=@vger.kernel.org, AJvYcCXocGM8vw9OyyR4NReqTWA6AI0kuIZ9pXYtyIlfNAS2xCpgtWEa9ZUhcKlsoOCZRxw9WaJOUsJzn/36J3mSAyQi@vger.kernel.org
X-Gm-Message-State: AOJu0YyDmnzHbMtAdl6xNFNy31dExoqbag7wrtKBUOqwi2Nhmg7LESV5
	ZczBIe3XX212CsjEc4kc3rj6OOu6bAc9MFwRNi+Zk9lWSd6727+jfZFLvQezs47Q
X-Gm-Gg: ASbGnct69F8LDVBfueM9wDdrHUFk/8chsi0nx6POacdBrkRBZXhG7JSAa8nGgS9ZQWJ
	Ew599ODGfNt+DLioSGrjImMV9BOMRe6RIlJVdgN53fs4to/a8UvZE+BEkgjBwpc0okIcdlN0fvR
	dErxptCrMhn0EvUGUc8Gl0Bdo8eomSyk9KvOumgY0Ckt5SnEbnPPA/POtgSY+ne+71enFgn3LhB
	nIMyM76K6Zr67rnBGXxb+FrNvJXxNQ+5P0Rat+cECiJJgMHxUTkX6bif1FLe1TRfeRpSn8Z/MDG
	d9teW2VvpVNNxYAcOzGqHgj/8inAqm/MaKsZfOZ8pupHSRTJkdcyWRLlaxSZgDh0IpLTgPJZ1AL
	OOqzCAIdFRFIlzshhWPkjUY84lo2FQrw=
X-Google-Smtp-Source: AGHT+IEg57QcmbrIQjwprTkgP68aNBsGFiAPXciHFu94NLgLuHIRfDkzSzDAptSD/xMXE9pPigNKJw==
X-Received: by 2002:a17:90b:390f:b0:327:8fb4:5140 with SMTP id 98e67ed59e1d1-3278fb452a6mr3554651a91.10.1756341108115;
        Wed, 27 Aug 2025 17:31:48 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e912e40csm8623200b3a.44.2025.08.27.17.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 17:31:47 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 27 Aug 2025 17:31:37 -0700
Subject: [PATCH net-next v5 9/9] selftests/vsock: add namespace tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-vsock-vmtest-v5-9-0ba580bede5b@meta.com>
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

Add tests for namespace support in vsock. Use socat for basic connection
failure tests and vsock_test for full functionality tests when
communication is expected to succeed. vsock_test is not used for failure
cases because in theory vsock_test could allow connection and some
traffic flow but fail on some other case (e.g., fail on MSG_ZEROCOPY).

Tests cover all cases of clients and servers being in all variants of
local ns, global ns, host process, and VM process.

Legacy tests are retained and executed in the init ns.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v5:
- use /proc/sys/net/vsock/ns_mode
- clarify logic of tests that reuse the same VM and tests that require
  netns setup
- fix unassigned BUILD bug
---
 tools/testing/selftests/vsock/vmtest.sh | 913 ++++++++++++++++++++++++++++----
 1 file changed, 808 insertions(+), 105 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 5e36d1068f6f..9d830eb7e829 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -7,6 +7,7 @@
 #		* virtme-ng
 #		* busybox-static (used by virtme-ng)
 #		* qemu	(used by virtme-ng)
+#		* socat
 
 readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
 readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
@@ -23,7 +24,7 @@ readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
 readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
-readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+readonly WAIT_QEMU=5
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
 # control port forwarded for vsock_test.  Because virtme-ng doesn't support
@@ -33,23 +34,125 @@ readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
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
 "
 readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
-readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly TEST_NAMES=(
+	vm_server_host_client
+	vm_client_host_server
+	vm_loopback
+	host_vsock_ns_mode_ok
+	host_vsock_ns_mode_write_once_ok
+	global_same_cid_fails
+	local_same_cid_ok
+	global_local_same_cid_ok
+	local_global_same_cid_ok
+	diff_ns_global_host_connect_to_global_vm_ok
+	diff_ns_global_host_connect_to_local_vm_fails
+	diff_ns_global_vm_connect_to_global_host_ok
+	diff_ns_global_vm_connect_to_local_host_fails
+	diff_ns_local_host_connect_to_local_vm_fails
+	diff_ns_local_vm_connect_to_local_host_fails
+	diff_ns_global_to_local_loopback_local_fails
+	diff_ns_local_to_global_loopback_fails
+	diff_ns_local_to_local_loopback_fails
+	diff_ns_global_to_global_loopback_ok
+	same_ns_local_loopback_ok
+	same_ns_local_host_connect_to_local_vm_ok
+	same_ns_local_vm_connect_to_local_host_ok
+)
+
 readonly TEST_DESCS=(
+	# vm_server_host_client
 	"Run vsock_test in server mode on the VM and in client mode on the host."
+
+	# vm_client_host_server
 	"Run vsock_test in client mode on the VM and in server mode on the host."
+
+	# vm_loopback
 	"Run vsock_test using the loopback transport in the VM."
+
+	# host_vsock_ns_mode_ok
+	"Check /proc/sys/net/vsock/ns_mode strings on the host."
+
+	# host_vsock_ns_mode_write_once_ok
+	"Check /proc/sys/net/vsock/ns_mode is write-once on the host."
+
+	# global_same_cid_fails
+	"Check QEMU fails to start two VMs with same CID in two different global namespaces."
+
+	# local_same_cid_ok
+	"Check QEMU successfully starts two VMs with same CID in two different local namespaces."
+
+	# global_local_same_cid_ok
+	"Check QEMU successfully starts one VM in a global ns and then another VM in a local ns with the same CID."
+
+	# local_global_same_cid_ok
+	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
+
+	# diff_ns_global_host_connect_to_global_vm_ok
+	"Run vsock_test client in global ns with server in VM in another global ns."
+
+	# diff_ns_global_host_connect_to_local_vm_fails
+	"Run socat to test a process in a global ns fails to connect to a VM in a local ns."
+
+	# diff_ns_global_vm_connect_to_global_host_ok
+	"Run vsock_test client in VM in a global ns with server in another global ns."
+
+	# diff_ns_global_vm_connect_to_local_host_fails
+	"Run socat to test a VM in a global ns fails to connect to a host process in a local ns."
+
+	# diff_ns_local_host_connect_to_local_vm_fails
+	"Run socat to test a host process in a local ns fails to connect to a VM in another local ns."
+
+	# diff_ns_local_vm_connect_to_local_host_fails
+	"Run socat to test a VM in a local ns fails to connect to a host process in another local ns."
+
+	# diff_ns_global_to_local_loopback_local_fails
+	"Run socat to test a loopback vsock in a global ns fails to connect to a vsock in a local ns."
+
+	# diff_ns_local_to_global_loopback_fails
+	"Run socat to test a loopback vsock in a local ns fails to connect to a vsock in a global ns."
+
+	# diff_ns_local_to_local_loopback_fails
+	"Run socat to test a loopback vsock in a local ns fails to connect to a vsock in another local ns."
+
+	# diff_ns_global_to_global_loopback_ok
+	"Run socat to test a loopback vsock in a global ns successfully connects to a vsock in another global ns."
+
+	# same_ns_local_loopback_ok
+	"Run socat to test a loopback vsock in a local ns successfully connects to a vsock in the same ns."
+
+	# same_ns_local_host_connect_to_local_vm_ok
+	"Run vsock_test client in a local ns with server in VM in same ns."
+
+	# same_ns_local_vm_connect_to_local_host_ok
+	"Run vsock_test client in VM in a local ns with server in same ns."
+)
+
+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly USE_INIT_NETNS=(
+	global_same_cid_fails
+	local_same_cid_ok
+	global_local_same_cid_ok
+	local_global_same_cid_ok
+	diff_ns_global_host_connect_to_global_vm_ok
+	diff_ns_global_host_connect_to_local_vm_fails
+	diff_ns_global_vm_connect_to_global_host_ok
+	diff_ns_global_vm_connect_to_local_host_fails
+	diff_ns_local_host_connect_to_local_vm_fails
+	diff_ns_local_vm_connect_to_local_host_fails
+	diff_ns_global_to_local_loopback_local_fails
+	diff_ns_local_to_global_loopback_fails
+	diff_ns_local_to_local_loopback_fails
+	diff_ns_global_to_global_loopback_ok
+	same_ns_local_loopback_ok
+	same_ns_local_host_connect_to_local_vm_ok
+	same_ns_local_vm_connect_to_local_host_ok
 )
+readonly MODES=("local" "global")
 
 readonly LOG_LEVEL_DEBUG=0
 readonly LOG_LEVEL_INFO=1
@@ -58,6 +161,12 @@ readonly LOG_LEVEL_ERROR=3
 
 VERBOSE="${LOG_LEVEL_WARN}"
 
+# Test pass/fail counters
+cnt_pass=0
+cnt_fail=0
+cnt_skip=0
+cnt_total=0
+
 usage() {
 	local name
 	local desc
@@ -77,7 +186,7 @@ usage() {
 	for ((i = 0; i < ${#TEST_NAMES[@]}; i++)); do
 		name=${TEST_NAMES[${i}]}
 		desc=${TEST_DESCS[${i}]}
-		printf "\t%-35s%-35s\n" "${name}" "${desc}"
+		printf "\t%-55s%-35s\n" "${name}" "${desc}"
 	done
 	echo
 
@@ -89,21 +198,87 @@ die() {
 	exit "${KSFT_FAIL}"
 }
 
+add_namespaces() {
+	# add namespaces local0, local1, global0, and global1
+	for mode in "${MODES[@]}"; do
+		ip netns add "${mode}0" 2>/dev/null
+		ip netns add "${mode}1" 2>/dev/null
+	done
+}
+
+init_namespaces() {
+	for mode in "${MODES[@]}"; do
+		ns_set_mode "${mode}0" "${mode}"
+		ns_set_mode "${mode}1" "${mode}"
+
+		log_host "set ns ${mode}0 to mode ${mode}"
+		log_host "set ns ${mode}1 to mode ${mode}"
+
+		# we need lo for qemu port forwarding
+		ip netns exec "${mode}0" ip link set dev lo up
+		ip netns exec "${mode}1" ip link set dev lo up
+	done
+}
+
+del_namespaces() {
+	for mode in "${MODES[@]}"; do
+		ip netns del "${mode}0"
+		ip netns del "${mode}1"
+		log_host "removed ns ${mode}0"
+		log_host "removed ns ${mode}1"
+	done &>/dev/null
+}
+
+ns_set_mode() {
+	local ns=$1
+	local mode=$2
+
+	echo "${mode}" | ip netns exec "${ns}" \
+		tee /proc/sys/net/vsock/ns_mode &>/dev/null
+}
+
 vm_ssh() {
-	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
+	local ns_exec
+
+	if [[ "${1}" == none ]]; then
+		local ns_exec=""
+	else
+		local ns_exec="ip netns exec ${1}"
+	fi
+
+	shift
+
+	${ns_exec} ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost $*
+
 	return $?
 }
 
 cleanup() {
-	if [[ -s "${QEMU_PIDFILE}" ]]; then
-		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
-	fi
+	del_namespaces
+}
 
-	# If failure occurred during or before qemu start up, then we need
-	# to clean this up ourselves.
-	if [[ -e "${QEMU_PIDFILE}" ]]; then
-		rm "${QEMU_PIDFILE}"
-	fi
+terminate_pidfiles() {
+	local pidfile
+
+	for pidfile in "$@"; do
+		if [[ -s "${pidfile}" ]]; then
+			pkill -SIGTERM -F "${pidfile}" 2>&1 > /dev/null
+		fi
+
+		# If failure occurred during or before qemu start up, then we need
+		# to clean this up ourselves.
+		if [[ -e "${pidfile}" ]]; then
+			rm -f "${pidfile}"
+		fi
+	done
+}
+
+terminate_pids() {
+	local pid
+
+	for pid in "$@"; do
+		kill -SIGTERM "${pid}" &>/dev/null || :
+	done
 }
 
 check_args() {
@@ -133,7 +308,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh; do
+	for dep in vng ${QEMU} busybox pkill ssh socat; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -170,6 +345,20 @@ check_vng() {
 	fi
 }
 
+check_socat() {
+	local support_string
+
+	support_string="$(socat -V)"
+
+	if [[ "${support_string}" != *"WITH_VSOCK 1"* ]]; then
+		die "err: socat is missing vsock support"
+	fi
+
+	if [[ "${support_string}" != *"WITH_UNIX 1"* ]]; then
+		die "err: socat is missing unix support"
+	fi
+}
+
 handle_build() {
 	if [[ ! "${BUILD}" -eq 1 ]]; then
 		return
@@ -194,9 +383,14 @@ handle_build() {
 }
 
 vm_start() {
+	local cid=$1
+	local ns=$2
+	local pidfile=$3
 	local logfile=/dev/null
 	local verbose_opt=""
+	local qemu_opts=""
 	local kernel_opt=""
+	local ns_exec=""
 	local qemu
 
 	qemu=$(command -v "${QEMU}")
@@ -206,27 +400,37 @@ vm_start() {
 		logfile=/dev/stdout
 	fi
 
+	qemu_opts="\
+		 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
+		 -device virtio-net-pci,netdev=n0 \
+		${QEMU_OPTS} -device vhost-vsock-pci,guest-cid=${cid} \
+		--pidfile ${pidfile}
+	"
+
 	if [[ "${BUILD}" -eq 1 ]]; then
 		kernel_opt="${KERNEL_CHECKOUT}"
 	fi
 
-	vng \
+	if [[ "${ns}" != "none" ]]; then
+		ns_exec="ip netns exec ${ns}"
+	fi
+
+	${ns_exec} vng \
 		--run \
 		${kernel_opt} \
 		${verbose_opt} \
-		--qemu-opts="${QEMU_OPTS}" \
+		--qemu-opts="${qemu_opts}" \
 		--qemu="${qemu}" \
 		--user root \
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	if ! timeout ${WAIT_TOTAL} \
-		bash -c 'while [[ ! -s '"${QEMU_PIDFILE}"' ]]; do sleep 1; done; exit 0'; then
-		die "failed to boot VM"
-	fi
+	timeout "${WAIT_QEMU}" \
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 
 vm_wait_for_ssh() {
+	local ns=$1
 	local i
 
 	i=0
@@ -234,7 +438,8 @@ vm_wait_for_ssh() {
 		if [[ ${i} -gt ${WAIT_PERIOD_MAX} ]]; then
 			die "Timed out waiting for guest ssh"
 		fi
-		if vm_ssh -- true; then
+
+		if vm_ssh "${ns}" -- true; then
 			break
 		fi
 		i=$(( i + 1 ))
@@ -269,6 +474,7 @@ wait_for_listener()
 		   grep -q "${pattern}"; then
 			break
 		fi
+
 		sleep "${interval}"
 	done
 
@@ -278,17 +484,29 @@ wait_for_listener()
 }
 
 vm_wait_for_listener() {
-	local port=$1
+	local ns=$1
+	local port=$2
+
+	log "Waiting for listener on port ${port} on vm"
 
-	vm_ssh <<EOF
+	vm_ssh "${ns}" <<EOF
 $(declare -f wait_for_listener)
 wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
 EOF
 }
 
 host_wait_for_listener() {
-	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+	local ns=$1
+	local port=$2
 
+	if [[ "${ns}" == none ]]; then
+		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+	else
+		ip netns exec "${ns}" bash <<-EOF
+			$(declare -f wait_for_listener)
+			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+		EOF
+	fi
 }
 
 log() {
@@ -427,51 +645,506 @@ test_vm_client_host_server() {
 }
 
 test_vm_loopback() {
+	vm_ssh "none" modprobe vsock_loopback || :
 	vm_vsock_test "none" "server" 1 "${TEST_HOST_PORT_LISTENER}"
 	vm_vsock_test "none" "client" "127.0.0.1" 1 "${TEST_HOST_PORT_LISTENER}"
 }
 
+test_host_vsock_ns_mode_ok() {
+	add_namespaces
+
+	for mode in "${MODES[@]}"; do
+		if ! ns_set_mode "${mode}0" "${mode}"; then
+			del_namespaces
+			return "${KSFT_FAIL}"
+		fi
+	done
 
+	del_namespaces
 }
 
-test_vm_client_host_server() {
+test_host_vsock_ns_mode_write_once_ok() {
+	add_namespaces
 
-	${VSOCK_TEST} \
-		--mode "server" \
-		--control-port "${TEST_HOST_PORT_LISTENER}" \
-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
+	for mode in "${MODES[@]}"; do
+		local ns="${mode}0"
+		if ! ns_set_mode "${ns}" "${mode}"; then
+			del_namespaces
+			return "${KSFT_FAIL}"
+		fi
 
-	host_wait_for_listener
+		# try writing again and expect failure
+		if ns_set_mode "${ns}" "${mode}"; then
+			del_namespaces
+			return "${KSFT_FAIL}"
+		fi
+	done
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=client \
-		--control-host=10.0.2.2 \
-		--peer-cid=2 \
-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
+	del_namespaces
 
-	return $?
+	return "${KSFT_PASS}"
 }
 
-test_vm_loopback() {
-	local port=60000 # non-forwarded local port
+namespaces_can_boot_same_cid() {
+	local ns0=$1
+	local ns1=$2
+	local pidfile1 pidfile2
+	local cid=20
+	readonly cid
+	local rc
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=server \
-		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest &
+	pidfile1=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+	vm_start "${cid}" "${ns0}" "${pidfile1}"
 
-	vm_wait_for_listener "${port}"
+	pidfile2=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+	vm_start "${cid}" "${ns1}" "${pidfile2}"
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=client \
-		--control-host="127.0.0.1" \
-		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest
+	rc=$?
+	terminate_pidfiles "${pidfile1}" "${pidfile2}"
 
-	return $?
+	return $rc
+}
+
+test_global_same_cid_fails() {
+	if namespaces_can_boot_same_cid "global0" "global1"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_local_global_same_cid_ok() {
+	if namespaces_can_boot_same_cid "local0" "global0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_global_local_same_cid_ok() {
+	if namespaces_can_boot_same_cid "global0" "local0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_local_same_cid_ok() {
+	if namespaces_can_boot_same_cid "local0" "local0"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_diff_ns_global_host_connect_to_global_vm_ok() {
+	local pids pid pidfile
+	local ns0 ns1 port
+	declare -a pids
+	local unixfile
+	ns0="global0"
+	ns1="global1"
+	port=1234
+	local rc
+
+	pidfile=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+
+	if ! vm_start "${VSOCK_CID}" "${ns0}" "${pidfile}"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	unixfile=$(mktemp -u /tmp/XXXX.sock)
+	ip netns exec "${ns1}" \
+		socat TCP-LISTEN:"${TEST_HOST_PORT}",fork \
+			UNIX-CONNECT:"${unixfile}" &
+	pids+=($!)
+	host_wait_for_listener "${ns1}" "${TEST_HOST_PORT}"
+
+	ip netns exec "${ns0}" socat UNIX-LISTEN:"${unixfile}",fork \
+		TCP-CONNECT:localhost:"${TEST_HOST_PORT}" &
+	pids+=($!)
+
+	vm_vsock_test "${ns0}" "server" 2 "${TEST_GUEST_PORT}"
+	vm_wait_for_listener "${ns0}" "${TEST_GUEST_PORT}"
+	host_vsock_test "${ns1}" "client" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+	rc=$?
+
+	for pid in "${pids[@]}"; do
+		if [[ "$(jobs -p)" = *"${pid}"* ]]; then
+			kill -SIGTERM "${pid}" &>/dev/null
+		fi
+	done
+
+	terminate_pidfiles "${pidfile}"
+
+	if [[ $rc -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_diff_ns_global_host_connect_to_local_vm_fails() {
+	local ns0="global0"
+	local ns1="local0"
+	local port=12345
+	local pidfile
+	local result
+	local pid
+
+	outfile=$(mktemp)
+
+	pidfile=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+	if ! vm_start "${VSOCK_CID}" "${ns1}" "${pidfile}"; then
+		log_host "failed to start vm (cid=${VSOCK_CID}, ns=${ns0})"
+		return $KSFT_FAIL
+	fi
+
+	vm_wait_for_ssh "${ns1}"
+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
+	echo TEST | ip netns exec "${ns0}" \
+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
+
+	terminate_pidfiles "${pidfile}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]]; then
+		return $KSFT_PASS
+	fi
+
+	return $KSFT_FAIL
+}
+
+test_diff_ns_global_vm_connect_to_global_host_ok() {
+	local ns0="global0"
+	local ns1="global1"
+	local port=12345
+	local unixfile
+	local pidfile
+	local pids
+
+	declare -a pids
+
+	log_host "Setup socat bridge from ns ${ns0} to ns ${ns1} over port ${port}"
+
+	unixfile=$(mktemp -u /tmp/XXXX.sock)
+
+	ip netns exec "${ns0}" \
+		socat TCP-LISTEN:"${port}" UNIX-CONNECT:"${unixfile}" &
+	pids+=($!)
+
+	ip netns exec "${ns1}" \
+		socat UNIX-LISTEN:"${unixfile}" TCP-CONNECT:127.0.0.1:"${port}" &
+	pids+=($!)
+
+	log_host "Launching ${VSOCK_TEST} in ns ${ns1}"
+	host_vsock_test "${ns1}" "server" "${VSOCK_CID}" "${port}"
+
+	pidfile=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+	if ! vm_start "${VSOCK_CID}" "${ns0}" "${pidfile}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		terminate_pids "${pids[@]}"
+		rm -f "${unixfile}"
+		return $KSFT_FAIL
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+	vm_vsock_test "${ns0}" "client" "10.0.2.2" 2 "${port}"
+	rc=$?
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pids[@]}"
+	rm -f "${unixfile}"
+
+	if [[ ! $rc -eq 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+
+}
+
+test_diff_ns_global_vm_connect_to_local_host_fails() {
+	local ns0="global0"
+	local ns1="local0"
+	local port=12345
+	local pidfile
+	local result
+	local pid
+
+	log_host "Launching socat in ns ${ns1}"
+	outfile=$(mktemp)
+	ip netns exec "${ns1}" socat VSOCK-LISTEN:${port} STDOUT &> "${outfile}" &
+	pid=$!
+
+	pidfile=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+	if ! vm_start "${VSOCK_CID}" "${ns0}" "${pidfile}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		terminate_pids "${pid}"
+		rm -f "${outfile}"
+		return $KSFT_FAIL
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+
+	vm_ssh "${ns0}" -- \
+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pid}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]]; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_diff_ns_local_host_connect_to_local_vm_fails() {
+	local ns0="local0"
+	local ns1="local1"
+	local port=12345
+	local pidfile
+	local result
+	local pid
+
+	outfile=$(mktemp)
+
+	pidfile=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+	if ! vm_start "${VSOCK_CID}" "${ns1}" "${pidfile}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		return $KSFT_FAIL
+	fi
+
+	vm_wait_for_ssh "${ns1}"
+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
+	echo TEST | ip netns exec "${ns0}" \
+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
+
+	terminate_pidfiles "${pidfile}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]]; then
+		return $KSFT_PASS
+	fi
+
+	return $KSFT_FAIL
+}
+
+test_diff_ns_local_vm_connect_to_local_host_fails() {
+	local ns0="local0"
+	local ns1="local1"
+	local port=12345
+	local pidfile
+	local result
+	local pid
+
+	log_host "Launching socat in ns ${ns1}"
+	outfile=$(mktemp)
+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT &> "${outfile}" &
+	pid=$!
+
+	pidfile=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+	if ! vm_start "${VSOCK_CID}" "${ns0}" "${pidfile}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		rm -f "${outfile}"
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+
+	vm_ssh "${ns0}" -- \
+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pid}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]]; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+__test_loopback_two_netns() {
+	local ns0=$1
+	local ns1=$2
+	local port=12345
+	local result
+	local pid
+
+	modprobe vsock_loopback &> /dev/null || :
+
+	log_host "Launching socat in ns ${ns1}"
+	outfile=$(mktemp)
+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" 2>/dev/null &
+	pid=$!
+
+	log_host "Launching socat in ns ${ns0}"
+	echo TEST | ip netns exec "${ns0}" socat STDIN VSOCK-CONNECT:1:"${port}" 2>/dev/null
+	terminate_pids "${pid}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" == TEST ]]; then
+		return 0
+	fi
+
+	return 1
+}
+
+test_diff_ns_global_to_local_loopback_local_fails() {
+	if ! __test_loopback_two_netns "global0" "local0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_diff_ns_local_to_global_loopback_fails() {
+	if ! __test_loopback_two_netns "local0" "global0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_diff_ns_local_to_local_loopback_fails() {
+	if ! __test_loopback_two_netns "local0" "local1"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_diff_ns_global_to_global_loopback_ok() {
+	if __test_loopback_two_netns "global0" "global1"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_same_ns_local_loopback_ok() {
+	if __test_loopback_two_netns "local0" "local0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_same_ns_local_host_connect_to_local_vm_ok() {
+	local ns="local0"
+	local port=1234
+	local pidfile
+	local rc
+
+	pidfile=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+
+	if ! vm_start "${VSOCK_CID}" "${ns}" "${pidfile}"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_vsock_test "${ns}" "server" 2 "${TEST_GUEST_PORT}"
+	host_vsock_test "${ns}" "client" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+	rc=$?
+
+	terminate_pidfiles "${pidfile}"
+
+	if [[ $rc -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_same_ns_local_vm_connect_to_local_host_ok() {
+	local ns="local0"
+	local port=1234
+	local pidfile
+	local rc
+
+	pidfile=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+
+	if ! vm_start "${VSOCK_CID}" "${ns}" "${pidfile}"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_vsock_test "${ns}" "server" 2 "${TEST_GUEST_PORT}"
+	host_vsock_test "${ns}" "client" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+	rc=$?
+
+	terminate_pidfiles "${pidfile}"
+
+	if [[ $rc -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+shared_vm_test() {
+	local tname
+
+	tname="${1}"
+
+	for testname in "${USE_SHARED_VM[@]}"; do
+		if [[ "${tname}" == "${testname}" ]]; then
+			return 0
+		fi
+	done
+
+	return 1
 }
 
-run_test() {
+
+init_netns_test() {
+	local tname
+
+	tname="${1}"
+
+	for testname in "${USE_INIT_NETNS[@]}"; do
+		if [[ "${tname}" == "${testname}" ]]; then
+			return 0
+		fi
+	done
+
+	return 1
+}
+
+check_result() {
+	local rc num
+
+	rc=$1
+	num=$(( cnt_total + 1 ))
+
+	if [[ ${rc} -eq $KSFT_PASS ]]; then
+		cnt_pass=$(( cnt_pass + 1 ))
+		echo "ok ${num} ${arg}"
+	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
+		cnt_skip=$(( cnt_skip + 1 ))
+		echo "ok ${num} ${arg} # SKIP"
+	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
+		cnt_fail=$(( cnt_fail + 1 ))
+		echo "not ok ${num} ${arg} # exit=$rc"
+	fi
+
+	cnt_total=$(( cnt_total + 1 ))
+}
+
+run_shared_vm_tests() {
+	local start_shared_vm pidfile
 	local host_oops_cnt_before
 	local host_warn_cnt_before
 	local vm_oops_cnt_before
@@ -483,42 +1156,93 @@ run_test() {
 	local name
 	local rc
 
-	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
-	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
+	start_shared_vm=0
 
-	name=$(echo "${1}" | awk '{ print $1 }')
-	eval test_"${name}"
-	rc=$?
+	for arg in "${ARGS[@]}"; do
+		if shared_vm_test "${arg}"; then
+			start_shared_vm=1
+			break
+		fi
+	done
 
-	host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
-	if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
-		echo "FAIL: kernel oops detected on host" | log_host "${name}"
-		rc=$KSFT_FAIL
+	pidfile=""
+	if [[ "${start_shared_vm}" == 1 ]]; then
+		pidfile=$(mktemp $PIDFILE_TEMPLATE)
+		log_host "Booting up VM"
+		vm_start "${VSOCK_CID}" "none" "${pidfile}"
+		vm_wait_for_ssh "none"
+		log_host "VM booted up"
 	fi
 
-	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
-	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
-		echo "FAIL: kernel warning detected on host" | log_host "${name}"
-		rc=$KSFT_FAIL
-	fi
+	for arg in "${ARGS[@]}"; do
+		if ! shared_vm_test "${arg}"; then
+			continue
+		fi
 
-	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
-	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
-		echo "FAIL: kernel oops detected on vm" | log_host "${name}"
-		rc=$KSFT_FAIL
-	fi
+		host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
+		host_warn_cnt_before=$(dmesg --level=warn | wc -l)
+		vm_oops_cnt_before=$(vm_ssh none -- dmesg | grep -c -i 'Oops')
+		vm_warn_cnt_before=$(vm_ssh none -- dmesg --level=warn | wc -l)
+
+		name=$(echo "${arg}" | awk '{ print $1 }')
+		log_host "Executing test_${name}"
+		eval test_"${name}"
+		rc=$?
+
+		host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
+		if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
+			echo "FAIL: kernel oops detected on host" | log_host "${name}"
+			rc=$KSFT_FAIL
+		fi
+
+		host_warn_cnt_after=$(dmesg --level=warn | wc -l)
+		if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
+			echo "FAIL: kernel warning detected on host" | log_host "${name}"
+			rc=$KSFT_FAIL
+		fi
+
+		vm_oops_cnt_after=$(vm_ssh none -- dmesg | grep -i 'Oops' | wc -l)
+		if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
+			echo "FAIL: kernel oops detected on vm" | log_host "${name}"
+			rc=$KSFT_FAIL
+		fi
+
+		vm_warn_cnt_after=$(vm_ssh none -- dmesg --level=warn | wc -l)
+		if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
+			echo "FAIL: kernel warning detected on vm" | log_host "${name}"
+			rc=$KSFT_FAIL
+		fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
-	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
-		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
-		rc=$KSFT_FAIL
+		check_result "${rc}"
+	done
+
+	if [[ -n "${pidfile}" ]]; then
+		log_host "VM terminate"
+		terminate_pidfiles "${pidfile}"
 	fi
+}
+
+run_isolated_vm_tests() {
+	for arg in "${ARGS[@]}"; do
+		if shared_vm_test "${arg}"; then
+			continue
+		fi
 
-	return "${rc}"
+		add_namespaces
+		if init_netns_test "${arg}"; then
+			init_namespaces
+		fi
+
+		name=$(echo "${arg}" | awk '{ print $1 }')
+		log_host "Executing test_${name}"
+		eval test_"${name}"
+		check_result $?
+
+		del_namespaces
+	done
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o
@@ -543,34 +1267,13 @@ fi
 check_args "${ARGS[@]}"
 check_deps
 check_vng
+check_socat
 handle_build
 
 echo "1..${#ARGS[@]}"
 
-log_host "Booting up VM"
-vm_start
-vm_wait_for_ssh
-log_host "VM booted up"
-
-cnt_pass=0
-cnt_fail=0
-cnt_skip=0
-cnt_total=0
-for arg in "${ARGS[@]}"; do
-	run_test "${arg}"
-	rc=$?
-	if [[ ${rc} -eq $KSFT_PASS ]]; then
-		cnt_pass=$(( cnt_pass + 1 ))
-		echo "ok ${cnt_total} ${arg}"
-	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
-		cnt_skip=$(( cnt_skip + 1 ))
-		echo "ok ${cnt_total} ${arg} # SKIP"
-	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
-		cnt_fail=$(( cnt_fail + 1 ))
-		echo "not ok ${cnt_total} ${arg} # exit=$rc"
-	fi
-	cnt_total=$(( cnt_total + 1 ))
-done
+run_shared_vm_tests
+run_isolated_vm_tests
 
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"

-- 
2.47.3


