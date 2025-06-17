Return-Path: <linux-kselftest+bounces-35165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F4074ADC0A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 06:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4BB53B6EF0
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F2423B623;
	Tue, 17 Jun 2025 04:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7dZ2ezG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C4233727;
	Tue, 17 Jun 2025 04:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134777; cv=none; b=RACEvoerbi//Tr7y8S9xJyyOxEwlOyTRBSd5jL62KL++/AgoO8olvcWwkHN6UCJnc9AGp5PVaE9nqwLeeeCV/SmT0FfllspC2e9XiOFWuB0erawwqtkFOpo3M6g7D0ENIomz3klT0rL1if5mic5utuSKHdA80t99X3XpcpWhKxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134777; c=relaxed/simple;
	bh=M6kehEHY7OwsO30C3T5dyH4gOVxvswy/eOIw/pHWvGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z2vsOqC1xEHSniPNz6EKL6myMEzl52YSDqEP1LkhAQ0BRaRLRrm2MtCFkI3X02/loTNBWK7N/MVgDKNTp5UFs4d4kSxZ6wP/3AVsaA7ZOr2tRsIEPcpHh4fRJWnZsELOix/+Rk7KPdvcdKOc1DFFRr7hXpaeTMAixyIr+4sWF7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7dZ2ezG; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so4344295a91.3;
        Mon, 16 Jun 2025 21:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134774; x=1750739574; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tK3AwFkrbSBAfvCtmqP3DGRgf/aabwLUhpvOzpe/4SQ=;
        b=Z7dZ2ezGSmd5xdUkbYVaMWoEWPba1c+5wzfc4h6gbckJUkEk126MVsuKdWjkMf+XrY
         BeuON+BFGeAh13joHO4MbijUEkVNQo576qGsoQWJQfrjRna2lykMIRIdRv3EHNMrOVOD
         qTPMvSBYVcEenROX5wzJaLT2OrT2GvgaEByjQQRa1+o4v7mr4xv1ukxymIWPHnFVxonN
         UbheS593CROHQaow7GTwnJF6kjG4YmWqMQFHs09zvXIp3oYmhdSQCosvDl2hnCu/G0Ae
         MLMpy/xmNnBPlXAz9lO6ACmrNMSDtEtnIkUkyPwPftf/k8la3BK1e0f6VGr7LoFlmcaD
         SHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134774; x=1750739574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tK3AwFkrbSBAfvCtmqP3DGRgf/aabwLUhpvOzpe/4SQ=;
        b=pEsE1K3YKuVSfwPQo56v8+CUejXzCE/eS7sEfPTPsDdzCobSbG00JfmVMDsIhl1LOK
         BBJTAsRNSbL7Ecw6ldu2KWBvzQoUfofGaWBX7wQq2zZKFATbXsNfslii0sSK/r5ZWrEe
         53MIhK0nnB+Ri06NOikgqKWUs+eagIlCIIUXYcdqyXrhYBNdahqb99Fyufy5R2EKzKrL
         ioeCcM5+c0/ERXAke39ZaTLSe8dcc9btkK3ONBgbQeAsdAT9hvQEfGSqjXUeJsRDEJXv
         SfjbbpzaTWsSXkG/DkatLlNXPWsjN5ehvk7XtMXjBi01EQc/j7uuKw55L7v1WsNwdGHx
         5WhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmocU1XJymETsYq04Ujr82RN3xmSSamyhA8i0a7fA/7eKVot+YOppZpZ0FDZIbkD8KAYOyfb8G84CVQJ8tOR0V@vger.kernel.org, AJvYcCWwM/ikXSzvAfHhwfmDigzM7yzSSEVgRxYJd91Dt2pAXX3GpvOgSx1lsQ6WFx6IM+nfW8b2vPKc@vger.kernel.org, AJvYcCXtScnjdon6BvA8XYWT9S+EPsfYZQTa7Td+BVwKSvmx7O9i+ZBgHWGMXD0VWsaXxU1cskkZKdZfyujPw4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbjz3lcpobFmYMacdUYZe02sYfrz75xFC3rT5RJiO/jRXWv2sQ
	Ix0PqMxCER4mXFQCeA1zAJJrKV398P5qHvKXmk/O/PMFBOhZF/+Wj/rzfS5VelNG
X-Gm-Gg: ASbGncutY1OMkPN1fFkVZMVdoS6fSSY5O1EpueQW8GJwcFIaHsHHo2GuEvn6vyY45V3
	Cr1ZrZPsuHDGunXheibcTk570n7/tVhPeFeUiDcwxNc8uIpwqBItZH0WB9tic81sf4HL8gLVpvN
	/1EnZSGIlgEe+R6ZQPLVkht9gs00fnmBxgKK5DRmz42EWVZEljEDQ9ieS45+U9An3+AkKYeGatM
	ptjnxHZOULPA9Y5Aov6rzyrW1v4+OpxhTdZCQrTCfCNKU8yYciIWx0iXuD3IA1otMwgy05QaR6N
	1R2Qs3PoVdem4lNoz1Qfj60ETzEGhGiY59L6OLleF/L7N/P7HGbYYOgdiJM=
X-Google-Smtp-Source: AGHT+IHSfb1B9OqWCmo1j9XP1ine02uUWCOqD7+7PRIocnf/lDDULUBftytAvdSsR4guD5nUqSLd4g==
X-Received: by 2002:a17:90b:2745:b0:312:e9bd:5d37 with SMTP id 98e67ed59e1d1-313f1c7b54dmr16681132a91.6.1750134773541;
        Mon, 16 Jun 2025 21:32:53 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b5efa2sm9560585a91.41.2025.06.16.21.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:32:52 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:50 -0700
Subject: [PATCH RFC net-next v4 01/11] selftests/vsock: add NS tests to
 vmtest.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-1-bdd1659c33fb@meta.com>
References: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
In-Reply-To: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
X-Mailer: b4 0.13.0

This patch has not been tested since rebasing onto upstream vmtest.sh.
It is probably very broken, but here to show the direction the testing
is going in...

vsock_test uses tcp for the control socket. TCP itself responds to
namespaces. In order to test vsock but not break TCP, vmtest.sh sets up
a bridge with socat (perhaps ip tables would be better, because it can
reduce an out-of-tree tool dependency). Another option is to not use
vsock_test for the NS tests, but it seems more robust to test all of
vsock instead of just (for example) connectibility...

Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 555 +++++++++++++++++++++++++++++---
 1 file changed, 510 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index edacebfc1632..8f627f60cc11 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -7,6 +7,48 @@
 #		* virtme-ng
 #		* busybox-static (used by virtme-ng)
 #		* qemu	(used by virtme-ng)
+#
+# Namespace tests require to test the functionality of VSOCK under different
+# namespace configurations. Ideally, we can use vsock_test and friends under
+# the different configurations to ensure that all functionality works
+# regardless of namespace setup. vsock_test also requires TCP for its control
+# plane, which is also impacted by namespacing. For this reason, these tests
+# build a bridge between the namespaces so that the TCP control traffic can
+# flow between namespaces. The bridge setup looks as follows:
+#
+#
+#                                  |
+#     +------------------+         |
+#     | VM               |         |
+#     |                  |     NS0 | NS1
+#     |  +------------+  |         |
+#     |  |            |  | --------+--------------------+
+#     |  | vsock_test |  |         |                    |
+#     |  |            |  | <-------+-----------------+  |
+#     |  +------------+  |         |  VSOCK_TEST_PORT|  |
+#     |                  |         |                 |  | VSOCK
+#     +------------------+         |                 |  |
+#              ^  |                |                 |  |
+#  CONTROL_PORT|  |                |                 |  |
+#              |  |                |                 |  |
+#              |  |                |                 |  v
+#              |  |                |             +------------+
+#              |  | TCP            |             |            |
+#              |  |                |             | vsock_test |
+#              |  |                |             |            |
+#              |  |                |             +------------+
+# CONTROL_PORT |  |                |   CONTROL_PORT  ^  |
+#              |  |                |                 |  |
+#              |  v                |   CONTROL_PORT  |  v
+#           +-------+              |              +-------+
+#           |       |veth0         |         veth1|       |
+#           | socat |<-------------+------------- | socat |
+#           |       | -------------+------------> |       |
+#           +-------+              |              +-------+
+#              NS_BRIDGE_PORT      |       NS_BRIDGE_PORT
+#                                  |
+
+set -u
 
 readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
 readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
@@ -19,11 +61,11 @@ readonly TEST_HOST_PORT=50000
 readonly TEST_HOST_PORT_LISTENER=50001
 readonly SSH_GUEST_PORT=22
 readonly SSH_HOST_PORT=2222
-readonly VSOCK_CID=1234
+readonly BRIDGE_PORT=5678
+readonly DEFAULT_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
-readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
 # control port forwarded for vsock_test.  Because virtme-ng doesn't support
@@ -33,23 +75,48 @@ readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
 # add the kernel cmdline options that virtme-init uses to setup the interface.
 readonly QEMU_TEST_PORT_FWD="hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
 readonly QEMU_SSH_PORT_FWD="hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
-readonly QEMU_OPTS="\
+readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
+readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
+QEMU_OPTS="\
 	 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
 	 -device virtio-net-pci,netdev=n0 \
-	 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
-	 --pidfile ${QEMU_PIDFILE} \
 "
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
+	host_vsock_ns_mode
+	host_vsock_ns_mode_write_once
+	global_same_cid
+	local_same_cid
+	global_local_same_cid
+	local_global_same_cid
+	global_host_connect_global_vm
+	global_vm_connect_global_host
+	global_vm_connect_mixed_host
+)
+
 readonly TEST_DESCS=(
 	"Run vsock_test in server mode on the VM and in client mode on the host."
 	"Run vsock_test in client mode on the VM and in server mode on the host."
 	"Run vsock_test using the loopback transport in the VM."
+	"Check /proc/net/vsock_ns_mode strings on the host."
+	"Check /proc/net/vsock_ns_mode is write-once on the host."
+	"Test that CID allocation fails with the same CID, one global NS and another global NS."
+	"Test that CID allocation succeeds with the same CID, one local NS and another local NS."
+	"Test that CID allocation succeeds with the same CID, one global NS and one local NS, global allocates first."
+	"Test that CID allocation succeeds with the same CID, one global NS and one local NS, local allocates first."
 )
+readonly NEEDS_SETUP=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly MODES=("local" "global" "mixed")
+readonly PIDFILE_TEMPLATE="/tmp/qemu_vsock_vmtest_XXXX.pid"
+
+declare -a PIDFILES
 
 VERBOSE=0
 
@@ -84,21 +151,40 @@ die() {
 	exit "${KSFT_FAIL}"
 }
 
+cleanup() {
+	terminate_pidfiles ${PIDFILES[@]}
+	del_namespaces
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
 }
 
-cleanup() {
-	if [[ -s "${QEMU_PIDFILE}" ]]; then
-		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
-	fi
+vm_ssh_ns() {
+	local ns="${1}"
+	local NS_EXEC="ip netns exec ${ns}"
+	shift
 
-	# If failure occurred during or before qemu start up, then we need
-	# to clean this up ourselves.
-	if [[ -e "${QEMU_PIDFILE}" ]]; then
-		rm "${QEMU_PIDFILE}"
-	fi
+	${NS_EXEC} ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost $*
+
+	return $?
+}
+
+terminate_pidfiles() {
+	local pidfile
+
+	for pidfile in $@; do
+		if [[ -s "${pidfile}" ]]; then
+			pkill -SIGTERM -F ${pidfile} 2>&1 > /dev/null
+		fi
+
+		# If failure occurred during or before qemu start up, then we need
+		# to clean this up ourselves.
+		if [[ -e "${pidfile}" ]]; then
+			rm "${pidfile}"
+		fi
+	done
 }
 
 check_args() {
@@ -189,7 +275,13 @@ handle_build() {
 }
 
 vm_start() {
+	local cid=$1
+	local ns=$2
+	local verify_boot=${3:-1}
+	local pidfile=${4:-}
+
 	local logfile=/dev/null
+	local qemu_opts=""
 	local verbose_opt=""
 	local kernel_opt=""
 	local qemu
@@ -201,35 +293,53 @@ vm_start() {
 		logfile=/dev/stdout
 	fi
 
+	qemu_opts="\
+		${QEMU_OPTS} -device vhost-vsock-pci,guest-cid=${cid} \
+		--pidfile ${pidfile}
+	"
+
 	if [[ "${BUILD}" -eq 1 ]]; then
 		kernel_opt="${KERNEL_CHECKOUT}"
 	fi
 
-	vng \
+	if [[ ! -z "${ns}" ]]; then
+		NS_EXEC="ip netns exec ${ns}"
+	fi
+
+	if [[ -z "${pidfile}" ]]; then
+		pidfile=$(mktemp $PIDFILE_TEMPLATE)
+		PIDFILES+=("${pidfile}")
+	fi
+
+	${NS_EXEC} vng \
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
+	timeout ${WAIT_TOTAL} \
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 
 vm_wait_for_ssh() {
+	local ns="${1}"
 	local i
 
 	i=0
-	while true; do
+	while [[ true ]]; do
 		if [[ ${i} -gt ${WAIT_PERIOD_MAX} ]]; then
 			die "Timed out waiting for guest ssh"
 		fi
-		if vm_ssh -- true; then
+		if [[ ! -z "${ns}" ]]; then
+			vm_ssh_ns "${ns}" -- true
+		else
+			vm_ssh -- true
+		fi
+		if [[ $? -eq 0 ]]; then
 			break
 		fi
 		i=$(( i + 1 ))
@@ -262,8 +372,9 @@ wait_for_listener()
 
 vm_wait_for_listener() {
 	local port=$1
+	local host_ns=$2
 
-	vm_ssh <<EOF
+	vm_ssh_ns "${host_ns}" <<EOF
 $(declare -f wait_for_listener)
 wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
 EOF
@@ -271,6 +382,17 @@ EOF
 
 host_wait_for_listener() {
 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+	wait_for_listener ${TEST_HOST_PORT_LISTENER} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+}
+
+host_ns_wait_for_listener() {
+	local ns="${1}"
+	local port="${2}"
+
+	ip netns exec "${ns}" bash <<-EOF
+		$(declare -f wait_for_listener)
+		wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+	EOF
 }
 
 __log_stdin() {
@@ -331,7 +453,7 @@ test_vm_server_host_client() {
 	${VSOCK_TEST} \
 		--mode=client \
 		--control-host=127.0.0.1 \
-		--peer-cid="${VSOCK_CID}" \
+		--peer-cid="${DEFAULT_CID}" \
 		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
 
 	return $?
@@ -343,7 +465,7 @@ test_vm_client_host_server() {
 	${VSOCK_TEST} \
 		--mode "server" \
 		--control-port "${TEST_HOST_PORT_LISTENER}" \
-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
+		--peer-cid "${DEFAULT_CID}" 2>&1 | log_host "${testname}" &
 
 	host_wait_for_listener
 
@@ -376,6 +498,309 @@ test_vm_loopback() {
 	return $?
 }
 
+add_namespaces() {
+	local init=${1:-0}
+
+	for mode in "${MODES[@]}"; do
+		if ! ip netns add "${mode}"; then
+			return ${KSFT_FAIL}
+		fi
+
+		# e.g., global-2, local-2, mixed-2
+		if ! ip netns add "${mode}-2"; then
+			return ${KSFT_FAIL}
+		fi
+
+		if [[ ${init} -eq 1 ]]; then
+			ns_set_mode "${mode}" "${mode}"
+			ns_set_mode "${mode}-2" "${mode}"
+
+			# we need lo for qemu port forwarding
+			ip netns exec "${mode}" ip link set dev lo up
+			ip netns exec "${mode}-2" ip link set dev lo up
+		fi
+	done
+	return 0
+}
+
+del_namespaces() {
+	for mode in "${MODES[@]}"; do
+		ip netns del "${mode}"
+		ip netns del "${mode}-2"
+	done &>/dev/null
+}
+
+ns_set_mode() {
+	local ns=$1
+	local mode=$2
+
+	echo "${mode}" \
+		| ip netns exec "${ns}" \
+			tee /proc/net/vsock_ns_mode &>/dev/null
+}
+
+setup_bridge() {
+	local ns0
+	local ns1
+	local addr1
+
+	ns0=$1
+	ns1=$2
+
+	ip link add veth0 type veth peer name veth1
+	ip link set veth0 netns "${ns0}"
+	ip link set veth1 netns "${ns1}"
+	ip netns exec "${ns0}" ip addr add 10.0.0.1/24 dev veth0
+	ip netns exec "${ns1}" ip addr add 10.0.0.2/24 dev veth1
+	ip netns exec "${ns0}" ip link set veth0 up
+	ip netns exec "${ns1}" ip link set veth1 up
+}
+
+teardown_bridge() {
+	local ns0="${1}"
+
+	# veth1 is implicitly destroyed with veth0
+	ip netns exec "${ns0}" ip link delete veth0
+}
+
+test_host_vsock_ns_mode() {
+	if ! add_namespaces; then
+		return ${KSFT_FAIL}
+	fi
+
+	for mode in "${MODES[@]}"; do
+		if ! ns_set_mode "${mode}" "${mode}"; then
+			del_namespaces
+			return ${KSFT_FAIL}
+		fi
+	done
+
+	if ! del_namespaces; then
+		return ${KSFT_FAIL}
+	fi
+}
+
+test_host_vsock_ns_mode_write_once() {
+	if ! add_namespaces; then
+		return ${KSFT_FAIL}
+	fi
+
+	for mode in "${MODES[@]}"; do
+		if ! ns_set_mode "${mode}" "${mode}"; then
+			del_namespaces
+			return ${KSFT_FAIL}
+		fi
+
+		# try setting back to global, should fail
+		if ns_set_mode "${mode}" "global"; then
+			del_namespaces
+			return ${KSFT_FAIL}
+		fi
+	done
+
+	if ! del_namespaces; then
+		return ${KSFT_FAIL}
+	fi
+}
+
+namespaces_can_boot_same_cid() {
+	local ns1=$1
+	local ns2=$2
+	local cid=20
+	local pidfile1
+	local pidfile2
+	local msg
+
+	if ! add_namespaces 1; then
+		return 1
+	fi
+
+	if [[ ${VERBOSE} -gt 0 ]]; then
+		echo "booting vm 1" | tap_prefix
+	fi
+
+	pidfile1=$(mktemp $PIDFILE_TEMPLATE)
+	PIDFILES+=("${pidfile1}")
+	vm_start ${cid} ${ns1} ${pidfile1}
+
+	if [[ ${VERBOSE} -gt 0 ]]; then
+		echo "booting vm 2" | tap_prefix
+	fi
+
+	pidfile2=$(mktemp $PIDFILE_TEMPLATE)
+	PIDFILES+=("${pidfile2}")
+	WAIT_TOTAL=30 vm_start ${cid} ${ns2} ${pidfile2}
+
+	rc=$?
+	if [[ $rc -eq 0 ]]; then
+		msg="successfully booted"
+		rc=0
+	else
+		msg="failed to boot"
+		rc=1
+	fi
+
+	if [[ ${VERBOSE} -gt 0 ]]; then
+		echo "vm 2 ${msg}" | tap_prefix
+	fi
+	if ! del_namespaces; then
+		echo "failed to delete namespaces" | tap_prefix
+	fi
+
+	terminate_pidfiles ${pidfile1} ${pidfile2}
+	return $rc
+}
+
+test_global_same_cid() {
+	if namespaces_can_boot_same_cid "global" "global-2"; then
+		return $KSFT_FAIL
+	fi
+
+	return $KSFT_PASS
+}
+
+test_local_global_same_cid() {
+	if namespaces_can_boot_same_cid "local" "global"; then
+		return $KSFT_PASS
+	fi
+
+	return $KSFT_FAIL
+}
+
+test_global_local_same_cid() {
+	if namespaces_can_boot_same_cid "global" "local"; then
+		return $KSFT_PASS
+	fi
+
+	return $KSFT_FAIL
+}
+
+test_local_same_cid() {
+	if namespaces_can_boot_same_cid "local" "local"; then
+		return $KSFT_FAIL
+	fi
+
+	return $KSFT_PASS
+}
+
+test_global_host_connect_global_vm() {
+	local testname="${FUNCNAME[0]#test_}"
+	local cid=${DEFAULT_CID}
+	local port=1234
+	local host_ns="global"
+	local host_ns2="global-2"
+
+	add_namespaces 1
+	setup_bridge "${host_ns}" "${host_ns2}"
+
+	# Start server in VM in namespace
+	if ! vm_start ${cid} "${host_ns}"; then
+		teardown_bridge "${host_ns}"
+		return $KSFT_FAIL
+	fi
+
+	vm_ssh_ns "${host_ns}" \
+		-- "${VSOCK_TEST}" \
+		--mode=server \
+		--control-port="${TEST_GUEST_PORT}" \
+		--peer-cid=2 \
+		2>&1 | log_guest "${testname}" &
+	vm_wait_for_listener ${TEST_GUEST_PORT} "${host_ns}"
+
+	# Setup NS-to-NS "bridge" 
+	ip netns exec "${host_ns}" socat TCP-LISTEN:${BRIDGE_PORT},fork \
+		TCP-CONNECT:localhost:${TEST_HOST_PORT} &
+	host_ns_wait_for_listener "${host_ns}" "${BRIDGE_PORT}"
+
+	ip netns exec "${host_ns2}" \
+		socat TCP:10.0.0.1:${BRIDGE_PORT} TCP-LISTEN:${TEST_HOST_PORT},fork &
+	host_ns_wait_for_listener "${host_ns2}" "${TEST_HOST_PORT}"
+
+	# Start client in other namespace
+	ip netns exec "${host_ns2}" ${VSOCK_TEST} \
+		--mode=client \
+		--control-host=127.0.0.1 \
+		--peer-cid="${cid}" \
+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
+	rc=$?
+
+	if [[ ! $rc -eq 0 ]]; then
+		return $KSFT_FAIL
+	fi
+
+	del_namespaces
+
+	return $KSFT_PASS
+}
+
+do_ns_vm_client_host_server_test() {
+	local testname="$1"
+	local host_ns="$2"
+	local host_ns2="$3"
+	local cid=${DEFAULT_CID}
+
+	# must not be same as qemu hostfwd port
+	local port=12345
+
+	add_namespaces 1
+	setup_bridge "${host_ns}" "${host_ns2}"
+
+	if ! vm_start ${cid} "${host_ns}"; then
+		teardown_bridge "${host_ns}"
+		return $KSFT_FAIL
+	fi
+
+	ip netns exec "${host_ns2}" ${VSOCK_TEST} \
+		--mode=server \
+		--peer-cid="${cid}" \
+		--control-port="${port}" 2>&1 | log_host "${testname}" &
+
+	host_ns_wait_for_listener "${host_ns2}" "${port}"
+
+	ip netns exec "${host_ns2}" \
+		socat TCP-LISTEN:${BRIDGE_PORT},bind=10.0.0.2,fork \
+			TCP:localhost:${port} &
+
+	host_ns_wait_for_listener "${host_ns2}" "${BRIDGE_PORT}"
+
+	ip netns exec "${host_ns}" socat TCP-LISTEN:${port},fork \
+		TCP-CONNECT:10.0.0.2:${BRIDGE_PORT} &
+
+	host_ns_wait_for_listener "${host_ns}" "${port}"
+
+	vm_ssh_ns "${host_ns}" \
+		-- "${VSOCK_TEST}" \
+		--mode=client \
+		--control-host=10.0.2.2 \
+		--control-port="${port}" \
+		--peer-cid=2 \
+		2>&1 | log_guest "${testname}"
+
+	if [[ ! $? -eq 0 ]]; then
+		return $KSFT_FAIL
+	fi
+
+	del_namespaces
+
+	return $KSFT_PASS
+}
+
+test_global_vm_connect_global_host() {
+	local testname="${FUNCNAME[0]#test_}"
+	local host_ns="global"
+	local host_ns2="global-2"
+
+	do_ns_vm_client_host_server_test ${testname} ${host_ns} ${host_ns2}
+}
+
+test_global_vm_connect_mixed_host() {
+	local testname="${FUNCNAME[0]#test_}"
+	local host_ns="global"
+	local host_ns2="mixed"
+
+	do_ns_vm_client_host_server_test ${testname} ${host_ns} ${host_ns2}
+}
+
 run_test() {
 	local host_oops_cnt_before
 	local host_warn_cnt_before
@@ -421,7 +846,40 @@ run_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	return "${rc}"
+	check_result "${rc}"
+}
+
+needs_setup() {
+	local tname
+
+	tname="$1"
+
+	for testname in ${NEEDS_SETUP[@]}; do
+		if [[ "${tname}" == "${testname}" ]]; then
+			return 1
+		fi
+	done
+
+	return 0
+}
+
+check_result() {
+	local rc
+
+	rc=$1
+
+	if [[ ${rc} -eq $KSFT_PASS ]]; then
+		cnt_pass=$(( cnt_pass + 1 ))
+		echo "ok ${cnt_total} ${arg}"
+	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
+		cnt_skip=$(( cnt_skip + 1 ))
+		echo "ok ${cnt_total} ${arg} # SKIP"
+	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
+		cnt_fail=$(( cnt_fail + 1 ))
+		echo "not ok ${cnt_total} ${arg} # exit=$rc"
+	fi
+
+	cnt_total=$(( cnt_total + 1 ))
 }
 
 QEMU="qemu-system-$(uname -m)"
@@ -452,29 +910,36 @@ handle_build
 
 echo "1..${#ARGS[@]}"
 
-log_setup "Booting up VM"
-vm_start
-vm_wait_for_ssh
-log_setup "VM booted up"
-
 cnt_pass=0
 cnt_fail=0
 cnt_skip=0
 cnt_total=0
+setup_done=0
+
+pidfile=""
+for arg in ${ARGS[@]}; do
+	if needs_setup "${arg}"; then
+		if [[ -z "${pidfile}" ]]; then
+			pidfile=$(mktemp $PIDFILE_TEMPLATE)
+			log_setup "Booting up VM"
+			vm_start "${DEFAULT_CID}" "" "${pidfile}"
+			vm_wait_for_ssh
+			log_setup "VM booted up"
+		fi
+
+		run_test "${arg}"
+	fi
+done
+
+if [[ ! -z "${pidfile}" ]]; then
+	log_setup "VM terminate"
+	terminate_pidfiles "${pidfile}"
+fi
+
 for arg in "${ARGS[@]}"; do
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
+	if ! needs_setup "${arg}"; then
+		run_test "${arg}"
 	fi
-	cnt_total=$(( cnt_total + 1 ))
 done
 
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"

-- 
2.47.1


