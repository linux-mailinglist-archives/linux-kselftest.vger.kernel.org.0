Return-Path: <linux-kselftest+bounces-41640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE86B7E5BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793393ACF41
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 23:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC872FB975;
	Tue, 16 Sep 2025 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3JuU30k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A511A2FA0F6
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066249; cv=none; b=p/1gQ9LMzYN3qQZ6lK9epQQIvjtv3FrgipgZ5mSAuVzFHBakxhjoquuqsXNUZHEuwBrg0VExiOg620Or85Z0XdWnAhV9sojWayjuK5zaJTnkN81QvzKmWpykeIzGmkelXpDWuRGzp2PWlh3timLJSuSElSkXoQ8pdZ1chpmYj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066249; c=relaxed/simple;
	bh=9m4cWG4BpkgT72TcRgDZ7iYYFF7UIJ8xpfr38T+6gzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dzjGJqj6qa36LKXwielpCVjGatiqaNX07dQLhMdSYC5/eKaMrSvft38JS37IgbaVjB+1wDh5RdWaI4MrJlrJ5kSSoABfoGgIdN9GuxRj/qNapSP+ZBxN+X2OiAC3vB9Uv4KVzpg9uezyZ8AbyYxe2ey3Sb+acxT3HMJW7oqviJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3JuU30k; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so8087202a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 16:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066246; x=1758671046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Td1ZAyn4msZcwjT2il97ffZ1NfsG6+V/WWfXT5WF56k=;
        b=O3JuU30ke2+jYMbIoeNkRjflg+2bftuFjSCVYaFilXEFng0X29ituxT3nP/eX9HubJ
         Y8yovVW91AUY+dKY2qyufCuns8uPDqJYCXhfX/gCm4G8OtXR/Xq20bfZ62raXgx//y5a
         8im1WSsTwo3Bp6uprbc3doEakVySJtSIuu88U/B8zhk5yrlYFG6PzMHHLLuRNkb18GXF
         1UfPrJEOTZUUzTEXs9RnkZrp5VLtgWZqIrE0g0cuJiQUo8hcd9mF8+M3W6mvh2/tCBk4
         XCHsf+cUIv8qck6NWvJ5yXo8t5IHhIQ5/4lJiKM5x09ca+mgja91bhCaaodDFhO+x0Pf
         OwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066246; x=1758671046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Td1ZAyn4msZcwjT2il97ffZ1NfsG6+V/WWfXT5WF56k=;
        b=fgvlcnMq1U3wwgWol+peDcThQDgqXxo02E+xfqAAj7nIbP0i/wllLXcLbqJvjmsIcW
         v4Psn1ubhDu8ygrti7SxUS+D4VRN8dS0iQL8eLhc+3V7cuy4Rm68PkAoS7Z++mF77gAT
         Pz/wn7MKLIxN5naKPoPGDGXr+5BjZdD3dXT/bQLVB1YZ03elFms0933QaO28ll4Oia26
         2jy9tpfNpt7rfg8OQK46uZSNFdviT9arXmvrfOqw8eUnWp4ytC5K5bQFql0sI+WwH5aE
         ANxEx8efBUILXN2FqmsEloS+55qQFrxPhOjmTL1vW6qc/9cW1cX/8WY57j/gx/St869C
         fYlA==
X-Forwarded-Encrypted: i=1; AJvYcCUinWCBRUn69FajBgOBpAEbKpvGmGYsVDtdftEEqipDf5fIHoGSCNcoGNYT11298EMWIsnlS6a7DQXJ+5YosEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ00K783MGC/t2zAfAW44PdbLpmWmSokq0j+seABssQJob/Z4o
	s175Wtyyme+WwzSSR5enL4BVLdq4nLsQ2GDh3q3UdzVK1HGmU5+KEIYH
X-Gm-Gg: ASbGnctcLU4dap8pRJ5sYqpOexD10eqkrZfjpIZhCFTXRL9AllqaWsTHH1MacTXZajY
	dpnSEzBQtVG3AmlNK4M0QebeUg+oacT2uvtP2S/vj7lmVQMB+fwVTtmHXbnkUviE2MK0nu8nmvI
	lu89GDZ7PuUYNS8q9FOIJhrWmn/fnB5TDtuxc/aNV31IKUKkK0LwHxTUqz5eGghhn40nDA3MaoR
	WbofoPmk8kuSmDnPyWTvEmzSt3D7WIV/q+HUEN+HFwOrEdsDYZR54MzwoRi0PM4dMj7sncNAnEJ
	6DlTp69PUbcsAgaj/8nCNohPPvzErzAbM/UxZk41SRR0D+7UiGUl2lg3ZMakVivcyZPYBUrFH+Z
	tqifZaCfkKOzT2PnmGsFlgAz/0wQwig==
X-Google-Smtp-Source: AGHT+IGxopyi0LrKmIsjPR0jM0XuFbdXHCSEPfpcqv1nkQcZnI4hlSriBi029oyZ0ZKsW9nZNb+WxQ==
X-Received: by 2002:a17:90b:2d86:b0:329:e729:b2a1 with SMTP id 98e67ed59e1d1-32ee3f8cc13mr173457a91.35.1758066245594;
        Tue, 16 Sep 2025 16:44:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54de4c1c41sm3012422a12.24.2025.09.16.16.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:44:04 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 16 Sep 2025 16:43:53 -0700
Subject: [PATCH net-next v6 9/9] selftests/vsock: add namespace tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-vsock-vmtest-v6-9-064d2eb0c89d@meta.com>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
In-Reply-To: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
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
Changes in v6:
- check for namespace support in vmtest.sh

Changes in v5:
- use /proc/sys/net/vsock/ns_mode
- clarify logic of tests that reuse the same VM and tests that require
  netns setup
- fix unassigned BUILD bug
---
 tools/testing/selftests/vsock/vmtest.sh | 954 ++++++++++++++++++++++++++++----
 1 file changed, 849 insertions(+), 105 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 5e36d1068f6f..59621b32cf1a 100755
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
@@ -33,23 +34,146 @@ readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
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
+)
+readonly REQUIRES_NETNS=(
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
 )
+readonly MODES=("local" "global")
 
 readonly LOG_LEVEL_DEBUG=0
 readonly LOG_LEVEL_INFO=1
@@ -58,6 +182,12 @@ readonly LOG_LEVEL_ERROR=3
 
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
@@ -77,7 +207,7 @@ usage() {
 	for ((i = 0; i < ${#TEST_NAMES[@]}; i++)); do
 		name=${TEST_NAMES[${i}]}
 		desc=${TEST_DESCS[${i}]}
-		printf "\t%-35s%-35s\n" "${name}" "${desc}"
+		printf "\t%-55s%-35s\n" "${name}" "${desc}"
 	done
 	echo
 
@@ -89,21 +219,87 @@ die() {
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
@@ -133,7 +329,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh; do
+	for dep in vng ${QEMU} busybox pkill ssh socat; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -147,6 +343,20 @@ check_deps() {
 	fi
 }
 
+check_test_deps() {
+	local tname=$1
+
+	# If the test requires NS support, check if NS support exists
+	# using /proc/self/ns
+	if [[ "${tname}" =~ "${REQUIRES_NETNS[@]}" ]] &&
+	   [[ ! -e /proc/self/ns ]]; then
+		log_host "No NS support detected for test ${tname}"
+		return 1
+	fi
+
+	return 0
+}
+
 check_vng() {
 	local tested_versions
 	local version
@@ -170,6 +380,20 @@ check_vng() {
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
@@ -194,9 +418,14 @@ handle_build() {
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
@@ -206,27 +435,37 @@ vm_start() {
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
@@ -234,7 +473,8 @@ vm_wait_for_ssh() {
 		if [[ ${i} -gt ${WAIT_PERIOD_MAX} ]]; then
 			die "Timed out waiting for guest ssh"
 		fi
-		if vm_ssh -- true; then
+
+		if vm_ssh "${ns}" -- true; then
 			break
 		fi
 		i=$(( i + 1 ))
@@ -269,6 +509,7 @@ wait_for_listener()
 		   grep -q "${pattern}"; then
 			break
 		fi
+
 		sleep "${interval}"
 	done
 
@@ -278,17 +519,29 @@ wait_for_listener()
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
@@ -427,51 +680,506 @@ test_vm_client_host_server() {
 }
 
 test_vm_loopback() {
+	vm_ssh "none" modprobe vsock_loopback || :
 	vm_vsock_test "none" "server" 1 "${TEST_HOST_PORT_LISTENER}"
 	vm_vsock_test "none" "client" "127.0.0.1" 1 "${TEST_HOST_PORT_LISTENER}"
 }
 
+test_host_vsock_ns_mode_ok() {
+	add_namespaces
 
+	for mode in "${MODES[@]}"; do
+		if ! ns_set_mode "${mode}0" "${mode}"; then
+			del_namespaces
+			return "${KSFT_FAIL}"
+		fi
+	done
+
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
+}
+
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
 }
 
-run_test() {
+run_shared_vm_tests() {
+	local start_shared_vm pidfile
 	local host_oops_cnt_before
 	local host_warn_cnt_before
 	local vm_oops_cnt_before
@@ -483,42 +1191,99 @@ run_test() {
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
+		if ! check_test_deps "${arg}"; then
+			log_host "Skipping ${arg}"
+			check_result "${KSFT_SKIP}"
+			continue
+		fi
+
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
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
-	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
-		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
-		rc=$KSFT_FAIL
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
+
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
+
+		add_namespaces
+		if init_netns_test "${arg}"; then
+			init_namespaces
+		fi
 
-	return "${rc}"
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
@@ -543,34 +1308,13 @@ fi
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


