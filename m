Return-Path: <linux-kselftest+bounces-31832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D31BA9FDE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 01:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525C4466F60
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 23:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A06F215059;
	Mon, 28 Apr 2025 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtL9z64s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882B1A072A;
	Mon, 28 Apr 2025 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745884100; cv=none; b=mEgv/ZZCKbRyTtiyS7vUe76BZ2YHHG14nxOOXyrY0XV+mArFG4+6mKY84oyAnuL3ZVsju/tu2I26RstuMDdzk2sxomxbucVU7FLlkWJJiuUvG4B3ayLImsul+BEiDwXOjkUKC3ZZLZn4sY7/IqvDmLx5Zol4ucld7wyvc9JmHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745884100; c=relaxed/simple;
	bh=49ROLzawylDGisDR4b5cQk2J2s2uS1rJZQCKXcndmTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jc1mFL6YoTIXWZpsjPpjuEObGp3i8edTiEcUe58bmosAykxGfxOmLU38i8VY7d+rfXTH7vEjcHazLAwn9jgWH0GLGGVgfSzyz2xFENnbLOAP/6tc8j56ICTEiLB+QWxXS6qQWa30lcaTfZH0yIe4erfDt0K+IF0nkc89Ai88mL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtL9z64s; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22c33677183so56660665ad.2;
        Mon, 28 Apr 2025 16:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745884097; x=1746488897; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ED3ibpC0qbQg/Ur3Nbal6fYS9/2lPwVHr8moAJPp128=;
        b=AtL9z64slawElC0YS/gv+sV/At+JaiGiubexuXbn7+Ur3alfp4fkzpwvd1enNH4BdG
         eNsa/caiCqyC1GkuBZy7SEVTNul17dDS9r/97fDZ/WCSflatOvd3tbBDRowMRQ4s8GQ3
         yEaESVygpLQ/vjTn/Zrhk3orbwV0sOZIYhJJZSwKtBVFL8lAct4GUAOW7W08IQtp+Gc/
         vVhzFDIIk0EVHC6wS4JbVTvUeamdcLHXUUv5qnsZ+e+UELcgCZEPNpMjLJ6mWYsbUJ0h
         Ihq2SZ8fiNwYsFpg1dkwUoehSxa7XAqep72xC4Clvxkx+aoIgMCZn/VvCqflPvwhd+92
         qsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745884097; x=1746488897;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ED3ibpC0qbQg/Ur3Nbal6fYS9/2lPwVHr8moAJPp128=;
        b=JvWhKLJsNIC+SqWA61M7DZzDAIk5BWOItmwztD+JqO21IltlIvDwwuNqy57zvrtWDw
         ZKrjMx3OMimaF+CH4p2u5BDoSWr/q9lD5Cmoq0fkIsBJlgGtb61HAFe0PC7G6PyoJZti
         4oItHMNhe9xSCrasR7eG6rYG5VHUWZ5SA/+aYCoWEzxyljJHM3/1pJ2DG2A8E1ZUEAeF
         cucfsIcbryQYto/w545gaUHVR7QKS6G4Dig7wt+R640cEH4uSH2TwbvJzhXbpLIcqd/C
         wiQNYhfApaajy2FhWt1UEpIxmfLwyMkCUGiZYyrav4qjsZ//V3zeC01lMgu4umr3gpsv
         pyQg==
X-Forwarded-Encrypted: i=1; AJvYcCXP9uRp/iaC2DbtrPx17o5kRFGdfz1ywOUWMHYL935iH66xlXOwhV1n1VmHuSkdMJd03fW4iOWlJwRkK2U=@vger.kernel.org, AJvYcCXTsclEsydSLUfnAZaSgZdwc6S/ANa+ZRMKsohBfmgOruYNCi81GSIR2bmnHhR13lW5hdE7YKmldYepX//uws0N@vger.kernel.org, AJvYcCXl9fui+oJNrgaoo6/aSxVtYS92sjDJfJfPgZvvmorn4ALtBgd0CblLpi26xXQ0RPokxC3Cylb5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4futyGNw8hIRgNtvZh9LDjKlNaKg/ZEtpAUlPC0z0jfC9yxXU
	MWPsQjNWnYHui2KKO+pt/DABNbEisXa8VGiU97Ta1z8DzLRg0+t1
X-Gm-Gg: ASbGnctFHKKDAbi7pgSI6ELH4e03HROX6C2oJaOaw0Mko7s7AK+64fA4VxcMxEaxj34
	7lbRAnMaWpYx8lPMaZ8qZE5wFE/T7RIcLZ3jxwzwG6Y8ZmGT2nWzQWAZqratwHgcRs3Vq7756x0
	UdPZux7Dj5ndhJyzdsJyRpIJ+vGm+ZYHn3CRlhHdzMxRSDFo0OOGL1S++y0P+Y0s/uKe8Hlcxnp
	yS4Lejhfn3zwba9q/AxIX8FXisdpc1KAPiB9x0BqPyzkVkPWUaNsRtPpsq8nsT3N5R8D6DWdWr+
	6g0MeIIJDpO3+amVFLrL5o2F1JBQggfwA9cM
X-Google-Smtp-Source: AGHT+IE6eQa76JeHbxm2jWCeRYajdfJlPsZ4LJppKsQLj9D38rBTr4y6lEtu//eW9aawttxlbsbaAQ==
X-Received: by 2002:a17:902:c412:b0:223:66bc:f1de with SMTP id d9443c01a7336-22dc6a04765mr174292815ad.21.1745884096398;
        Mon, 28 Apr 2025 16:48:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4db99b1sm89386535ad.54.2025.04.28.16.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 16:48:15 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 28 Apr 2025 16:48:11 -0700
Subject: [PATCH net-next v3] selftests/vsock: add initial vmtest.sh for
 vsock
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-vsock-vmtest-v3-1-181af6163f3e@gmail.com>
X-B4-Tracking: v=1; b=H4sIALoTEGgC/13NQQ6CMBCF4as0s2ZMZyoBWXkP46KUERuFGto0G
 MLdTbpS1y//9zaIsniJ0KkNFsk++jBDp0ylwN3tPAr6AToFrLnWhmvMMbgH5ilJTNgbyzQwaXY
 MlYLXIje/Fu4CsyScZU1wrRTcfUxheZefTGUv5JH0L5kJCW+mti0Ntj+17jxO1j8PLkwFyvwdN
 38xI6E5abLcGEPSfsf7vn8AaKfEZu8AAAA=
X-Change-ID: 20250325-vsock-vmtest-b3a21d2102c2
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
X-Mailer: b4 0.14.2

This commit introduces a new vmtest.sh runner for vsock.

It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
H2G, and loopback. The testing tools from tools/testing/vsock/ are
reused. Currently, only vsock_test is used.

VMCI and hyperv support is automatically built, though not used.

Only tested on x86.

To run:

  $ tools/testing/selftests/vsock/vmtest.sh

or

  $ make -C tools/testing/selftests TARGETS=vsock run_tests

Results:
	# linux/tools/testing/selftests/vsock/vmtest.log
	setup:  Building kernel and tests
	setup:  Booting up VM
	setup:  VM booted up
	test:vm_server_host_client:guest:       Control socket listening on 0.0.0.0:51000
	test:vm_server_host_client:guest:       Control socket connection accepted...
	[...]
	test:vm_loopback:guest: 30 - SOCK_STREAM retry failed connect()...ok
	test:vm_loopback:guest: 31 - SOCK_STREAM SO_LINGER null-ptr-deref...ok
	test:vm_loopback:guest: 31 - SOCK_STREAM SO_LINGER null-ptr-deref...ok

Future work can include vsock_diag_test.

vmtest.sh is loosely based off of tools/testing/selftests/net/pmtu.sh,
which was picked out of the bag of tests I knew to work with NIPA.

Because vsock requires a VM to test anything other than loopback, this
patch adds vmtest.sh as a kselftest itself. This is different than other
systems that have a "vmtest.sh", where it is used as a utility script to
spin up a VM to run the selftests as a guest (but isn't hooked into
kselftest). This aspect is worth review, as I'm not aware of all of the
enviroments where this would run.

Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
---
Changes in v3:
- use common conditional syntax for checking variables
- use return value instead of global rc
- fix typo TEST_HOST_LISTENER_PORT -> TEST_HOST_PORT_LISTENER
- use SIGTERM instead of SIGKILL on cleanup
- use peer-cid=1 for loopback
- change sleep delay times into globals
- fix test_vm_loopback logging
- add test selection in arguments
- make QEMU an argument
- check that vng binary is on path
- use QEMU variable
- change <tab><backslash> to <space><backslash>
- fix hardcoded file paths
- add comment in commit msg about script that vmtest.sh was based off of
- Add tools/testing/selftest/vsock/Makefile for kselftest
- Link to v2: https://lore.kernel.org/r/20250417-vsock-vmtest-v2-1-3901a27331e8@gmail.com

Changes in v2:
- add kernel oops and warnings checker
- change testname variable to use FUNCNAME
- fix spacing in test_vm_server_host_client
- add -s skip build option to vmtest.sh
- add test_vm_loopback
- pass port to vm_wait_for_listener
- fix indentation in vmtest.sh
- add vmci and hyperv to config
- changed whitespace from tabs to spaces in help string
- Link to v1: https://lore.kernel.org/r/20250410-vsock-vmtest-v1-1-f35a81dab98c@gmail.com
---
 MAINTAINERS                                |   1 +
 tools/testing/selftests/vsock/.gitignore   |   1 +
 tools/testing/selftests/vsock/Makefile     |   9 +
 tools/testing/selftests/vsock/config.vsock |  10 +
 tools/testing/selftests/vsock/settings     |   1 +
 tools/testing/selftests/vsock/vmtest.sh    | 354 +++++++++++++++++++++++++++++
 6 files changed, 376 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 657a67f9031ef7798c19ac63e6383d4cb18a9e1f..3fbdd7bbfce7196a3cc7db70203317c6bd0e51fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25751,6 +25751,7 @@ F:	include/uapi/linux/vm_sockets.h
 F:	include/uapi/linux/vm_sockets_diag.h
 F:	include/uapi/linux/vsockmon.h
 F:	net/vmw_vsock/
+F:	tools/testing/selftests/vsock/
 F:	tools/testing/vsock/
 
 VMALLOC
diff --git a/tools/testing/selftests/vsock/.gitignore b/tools/testing/selftests/vsock/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..1950aa8ac68c0831c12c1aaa429da45bbe41e60f
--- /dev/null
+++ b/tools/testing/selftests/vsock/.gitignore
@@ -0,0 +1 @@
+vsock_selftests.log
diff --git a/tools/testing/selftests/vsock/Makefile b/tools/testing/selftests/vsock/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..6fded8c4d593541a6f7462147bffcb719def378f
--- /dev/null
+++ b/tools/testing/selftests/vsock/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+.PHONY: all
+all:
+
+TEST_PROGS := vmtest.sh
+EXTRA_CLEAN := vmtest.log
+
+include ../lib.mk
+
diff --git a/tools/testing/selftests/vsock/config.vsock b/tools/testing/selftests/vsock/config.vsock
new file mode 100644
index 0000000000000000000000000000000000000000..9e0fb2270e6a2fc0beb5f0d9f0bc37158d0a9d23
--- /dev/null
+++ b/tools/testing/selftests/vsock/config.vsock
@@ -0,0 +1,10 @@
+CONFIG_VSOCKETS=y
+CONFIG_VSOCKETS_DIAG=y
+CONFIG_VSOCKETS_LOOPBACK=y
+CONFIG_VMWARE_VMCI_VSOCKETS=y
+CONFIG_VIRTIO_VSOCKETS=y
+CONFIG_VIRTIO_VSOCKETS_COMMON=y
+CONFIG_HYPERV_VSOCKETS=y
+CONFIG_VMWARE_VMCI=y
+CONFIG_VHOST_VSOCK=y
+CONFIG_HYPERV=y
diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
new file mode 100644
index 0000000000000000000000000000000000000000..e7b9417537fbc4626153b72e8f295ab4594c844b
--- /dev/null
+++ b/tools/testing/selftests/vsock/settings
@@ -0,0 +1 @@
+timeout=0
diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
new file mode 100755
index 0000000000000000000000000000000000000000..d70b9446e531d6d20beb24ddeda2cf0a9f7e9a39
--- /dev/null
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -0,0 +1,354 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Meta Platforms, Inc. and affiliates
+#
+# Dependencies:
+#		* virtme-ng
+#		* busybox-static (used by virtme-ng)
+#		* qemu	(used by virtme-ng)
+
+SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
+KERNEL_CHECKOUT=$(realpath ${SCRIPT_DIR}/../../../..)
+QEMU=$(command -v qemu-system-$(uname -m))
+VERBOSE=0
+SKIP_BUILD=0
+VSOCK_TEST=${KERNEL_CHECKOUT}/tools/testing/vsock/vsock_test
+
+TEST_GUEST_PORT=51000
+TEST_HOST_PORT=50000
+TEST_HOST_PORT_LISTENER=50001
+SSH_GUEST_PORT=22
+SSH_HOST_PORT=2222
+VSOCK_CID=1234
+WAIT_PERIOD=3
+WAIT_PERIOD_MAX=20
+
+QEMU_PIDFILE=/tmp/qemu.pid
+
+# virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
+# control port forwarded for vsock_test.  Because virtme-ng doesn't support
+# adding an additional port to forward to the device created from "--ssh" and
+# virtme-init mistakenly sets identical IPs to the ssh device and additional
+# devices, we instead opt out of using --ssh, add the device manually, and also
+# add the kernel cmdline options that virtme-init uses to setup the interface.
+QEMU_OPTS=""
+QEMU_OPTS="${QEMU_OPTS} -netdev user,id=n0,hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
+QEMU_OPTS="${QEMU_OPTS},hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
+QEMU_OPTS="${QEMU_OPTS} -device virtio-net-pci,netdev=n0"
+QEMU_OPTS="${QEMU_OPTS} -device vhost-vsock-pci,guest-cid=${VSOCK_CID}"
+QEMU_OPTS="${QEMU_OPTS} --pidfile ${QEMU_PIDFILE}"
+KERNEL_CMDLINE="virtme.dhcp net.ifnames=0 biosdevname=0 virtme.ssh virtme_ssh_user=$USER"
+
+LOG=${SCRIPT_DIR}/vmtest.log
+
+#		Name				Description
+avail_tests="
+	vm_server_host_client	Run vsock_test in server mode on the VM and in client mode on the host.	
+	vm_client_host_server	Run vsock_test in client mode on the VM and in server mode on the host.	
+	vm_loopback		Run vsock_test using the loopback transport in the VM.	
+"
+
+usage() {
+	echo
+	echo "$0 [OPTIONS] [TEST]..."
+	echo "If no TEST argument is given, all tests will be run."
+	echo
+	echo "Options"
+	echo "  -v: verbose output"
+	echo "  -s: skip build"
+	echo
+	echo "Available tests${avail_tests}"
+	exit 1
+}
+
+die() {
+	echo "$*" >&2
+	exit 1
+}
+
+vm_ssh() {
+	ssh -q -o UserKnownHostsFile=/dev/null -p 2222 localhost $*
+	return $?
+}
+
+cleanup() {
+	if [[ -f "${QEMU_PIDFILE}" ]]; then
+		pkill -SIGTERM -F ${QEMU_PIDFILE} 2>&1 >/dev/null
+	fi
+}
+
+build() {
+	log_setup "Building kernel and tests"
+
+	pushd ${KERNEL_CHECKOUT} >/dev/null
+	vng \
+		--kconfig \
+		--config ${KERNEL_CHECKOUT}/tools/testing/selftests/vsock/config.vsock
+	make -j$(nproc)
+	make -C ${KERNEL_CHECKOUT}/tools/testing/vsock
+	popd >/dev/null
+	echo
+}
+
+vm_setup() {
+	local VNG_OPTS=""
+	if [[ "${VERBOSE}" = 1 ]]; then
+		VNG_OPTS="--verbose"
+	fi
+	vng \
+		$VNG_OPTS \
+		--run ${KERNEL_CHECKOUT} \
+		--qemu-opts="${QEMU_OPTS}" \
+		--qemu="${QEMU}" \
+		--user root \
+		--append "${KERNEL_CMDLINE}" \
+		--rw  2>&1 >/dev/null &
+}
+
+vm_wait_for_ssh() {
+	i=0
+	while [[ true ]]; do
+		if [[ ${i} > ${WAIT_PERIOD_MAX} ]]; then
+			die "Timed out waiting for guest ssh"
+		fi
+		vm_ssh -- true
+		if [[ $? -eq 0 ]]; then
+			break
+		fi
+		i=$(( i + 1 ))
+		sleep ${WAIT_PERIOD}
+	done
+}
+
+wait_for_listener() {
+	local PORT=$1
+	local i=0
+	while ! ss -ltn | grep -q ":${PORT}"; do
+		if [[ ${i} > ${WAIT_PERIOD_MAX} ]]; then
+			die "Timed out waiting for listener on port ${PORT}"
+		fi
+		i=$(( i + 1 ))
+		sleep ${WAIT_PERIOD}
+	done
+}
+
+vm_wait_for_listener() {
+	local port=$1
+	vm_ssh -- "$(declare -f wait_for_listener); wait_for_listener ${port}"
+}
+
+host_wait_for_listener() {
+	wait_for_listener ${TEST_HOST_PORT_LISTENER}
+}
+
+log() {
+	local prefix="$1"
+	shift
+
+	if [[ "$#" -eq 0 ]]; then
+		cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }' | tee -a ${LOG}
+	else
+		echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }' | tee -a ${LOG}
+	fi
+}
+
+log_setup() {
+	log "setup" "$@"
+}
+
+log_host() {
+	testname=$1
+	shift
+	log "test:${testname}:host" "$@"
+}
+
+log_guest() {
+	testname=$1
+	shift
+	log "test:${testname}:guest" "$@"
+}
+
+test_vm_server_host_client() {
+	local testname="${FUNCNAME[0]#test_}"
+
+	vm_ssh -- "${VSOCK_TEST}" \
+		--mode=server \
+		--control-port="${TEST_GUEST_PORT}" \
+		--peer-cid=2 \
+		2>&1 | log_guest "${testname}" &
+
+	vm_wait_for_listener ${TEST_GUEST_PORT}
+
+	${VSOCK_TEST} \
+		--mode=client \
+		--control-host=127.0.0.1 \
+		--peer-cid="${VSOCK_CID}" \
+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
+
+	return $?
+}
+
+test_vm_client_host_server() {
+	local testname="${FUNCNAME[0]#test_}"
+
+	${VSOCK_TEST} \
+		--mode "server" \
+		--control-port "${TEST_HOST_PORT_LISTENER}" \
+		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
+
+	host_wait_for_listener
+
+	vm_ssh -- "${VSOCK_TEST}" \
+		--mode=client \
+		--control-host=10.0.2.2 \
+		--peer-cid=2 \
+		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
+
+	return $?
+}
+
+test_vm_loopback() {
+	local testname="${FUNCNAME[0]#test_}"
+	local port=60000 # non-forwarded local port
+
+	vm_ssh -- ${VSOCK_TEST} \
+		--mode=server \
+		--control-port="${port}" \
+		--peer-cid=1 2>&1 | log_guest "${testname}" &
+
+	vm_wait_for_listener ${port}
+
+	vm_ssh -- ${VSOCK_TEST} \
+		--mode=client \
+		--control-host="127.0.0.1" \
+		--control-port="${port}" \
+		--peer-cid=1 2>&1 | log_guest "${testname}"
+
+	return $?
+}
+
+run_test() {
+	unset IFS
+	local host_oops_cnt_before
+	local host_warn_cnt_before
+	local vm_oops_cnt_before
+	local vm_warn_cnt_before
+	local host_oops_cnt_after
+	local host_warn_cnt_after
+	local vm_oops_cnt_after
+	local vm_warn_cnt_after
+	local name
+	local rc
+
+	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
+	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
+	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
+	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
+
+	name=$(echo "${1}" | awk '{ print $1 }')
+	eval test_"${name}"
+
+	host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
+	if [[ ${host_oops_cnt_after} > ${host_oops_cnt_before} ]]; then
+		echo "${name}: kernel oops detected on host" | log_host ${name}
+		rc=1
+	fi
+
+	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
+	if [[ ${host_warn_cnt_after} > ${host_warn_cnt_before} ]]; then
+		echo "${name}: kernel warning detected on host" | log_host ${name}
+		rc=1
+	fi
+
+	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	if [[ ${vm_oops_cnt_after} > ${vm_oops_cnt_before} ]]; then
+		echo "${name}: kernel oops detected on vm" | log_host ${name}
+		rc=1
+	fi
+
+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
+	if [[ ${vm_warn_cnt_after} > ${vm_warn_cnt_before} ]]; then
+		echo "${name}: kernel warning detected on vm" | log_host ${name}
+		rc=1
+	fi
+
+	return ${rc}
+}
+
+while getopts :hvsq: o
+do
+	case $o in
+	v) VERBOSE=1;;
+	s) SKIP_BUILD=1;;
+	q) QEMU=$OPTARG;;
+	h|*) usage;;
+	esac
+done
+shift $((OPTIND-1))
+
+trap cleanup EXIT
+
+if [[ ! -x "$(command -v vng)" ]]; then
+	die "vng not found."
+fi
+
+if [[ ! -x "${QEMU}" ]]; then
+	die "${QEMU} not found."
+fi
+
+rm -f "${LOG}"
+if [[ "${SKIP_BUILD}" != 1 ]]; then
+	build
+fi
+log_setup "Booting up VM"
+vm_setup
+vm_wait_for_ssh
+log_setup "VM booted up"
+
+for arg in "$@"; do
+	if ! command -v > /dev/null "test_${arg}"; then
+		echo "Test ${arg} not found"
+		die "${usage}"
+	fi
+done
+
+IFS="	
+"
+cnt=0
+name=""
+desc=""
+for t in ${avail_tests}; do
+	[ "${name}" = "" ] && name="${t}" && continue
+	# desc is unused, but we need to eat it.
+	[ "${desc}" = "" ] && desc="${t}"
+
+	run_this=0
+	if [[ "${#}" -eq 0 ]]; then
+		run_this=1
+	else
+		for arg in "$@"; do
+			if [[ "${arg}" = "${name}" ]]; then
+				run_this=1
+			fi
+		done
+	fi
+
+	if [[ "${run_this}" = 1 ]]; then
+		run_test "${name}"
+		rc=$?
+		if [[ ${rc} != 0 ]]; then
+			cnt=$(( cnt + 1 ))
+		fi
+	fi
+	name=""
+	desc=""
+done
+
+if [[ ${cnt} = 0 ]]; then
+	echo OK
+else
+	echo FAILED: ${cnt}
+fi
+echo "Log: ${LOG}"
+exit ${cnt}

---
base-commit: 8066e388be48f1ad62b0449dc1d31a25489fa12a
change-id: 20250325-vsock-vmtest-b3a21d2102c2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@gmail.com>


