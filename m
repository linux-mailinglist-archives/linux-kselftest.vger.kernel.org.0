Return-Path: <linux-kselftest+bounces-31120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4C6A9315C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 07:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E4F8A78F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 05:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09C0267F42;
	Fri, 18 Apr 2025 05:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0kraM3H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AD71DE8B0;
	Fri, 18 Apr 2025 05:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744952782; cv=none; b=EA29yCrHW72+8z7lUDG5U/dLwnyJi8cDbuL3QYzkNsANUs6w1XoP4AoGuuDh/AyYPt8HmVmOcQBVmedMqr7IqKpEK0fAmAcJSaasE2Z4PhQ5FauqeZajt05aYxtLQER0MjkRBJGSLXzjwMXVdhUT7N+Wk+Gz7d0LcUVSjJJwA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744952782; c=relaxed/simple;
	bh=FcDsxO8PuWpeXpi+j/1c2opSjLUZpj4uBwXlxK3vFw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XFKYMmuPZEgPP8rlYzVFEfoDa6IgMXgc1MsnN5Nnqpq72YO6iF7kW8h4+IjmeaYKUpspGhz1mg3KnnhNMZ73YMnGhYdklahV9s69jGaw7Up2qObRegcKs1mpIVcIG1ynwQIw2EcEiyLVyhISuscciovGQ5A6PdrDEK3pf6+Vp7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0kraM3H; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2240b4de12bso23080575ad.2;
        Thu, 17 Apr 2025 22:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744952777; x=1745557577; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xex5AEcGJGWj6dOdpaDDAlctwWeRYrvWdmFV2CE5qXU=;
        b=h0kraM3HjBDwHlFScnFpYC2BGmH1HCeLXy2vwuTM7q8eSh2dyxfsE7Vpuo50IT10UO
         4jtsH+ifeg1bhVnqu1ycx0Ag8Q39gPqYJ+YUST2GcL7ELMG85uX6wiAWn0H6+M5F1a1K
         76bGseqSBbkHESW7MjTaVy4fL0/aFODg3HF5pH99dSnibWtvMokxEeOCI+NP7Qxvcw75
         N+D3mu3szARvN1LRRhTS1a/l5FHQi+GNtGkOhl+dwJI1RbyzTLWWPUPlRhn8Dut8WdeT
         tz+48Lg2qbzFTt1t8a0npq7ouHfvokRLd6yzvuP8LckIZNicwVsmxI5VIDuTyDzbJhNU
         bsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744952777; x=1745557577;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xex5AEcGJGWj6dOdpaDDAlctwWeRYrvWdmFV2CE5qXU=;
        b=dmfko2o/CmxOl7nbypBRocV6vN+0lZdwJiqDFJ1eCSlI8Bg21BZAux6SUM6ogaseu6
         66VjcFAFv/mA4Qby8XLHS5xY22sybhQLqWjepwmjM1Cwbs0M0ylE6XFYbB4k/KDG7Bhn
         ViBbbZD3Q5pRhsXSlTHAEBVgfc98BI+qYzM41glEQmqdQmEwElSZco8so/PrWLSM5jXs
         uPlNjb4x50P+X8VkXJeW0DCYfNzr4VDNG+x/TE+GxCWNAI6ZFrK6ioeWCNdjHzKKu/sX
         r6xhCUIaYackG9qWBAXJSNXHWULs/D2sXnbR72QlYkrW8gALOt5ng7w9LGmHXnuuDACj
         o6yQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7EYvZzAQ6Bgh9ttGZiPxSXnSK3/pRlbNtPYXsWjP+WwuNTeHS/T8mahJLX3XJ/X9gq49SIdbwizTk90BR/Bfj@vger.kernel.org, AJvYcCW8YrEZM9JD7JIfoEUUD3UAL/iXNEQ/ovSlA7uQf4M9IVkVVrz9DpJPyr7QxqodHt4hLYCxNcEIOYtZqPk=@vger.kernel.org, AJvYcCX36GYlIrldzLYj5INWwQk5EfnGle1UqGRNo1S5VZD/UtHJZ02NKA3qN31ClWmQTgvLizF1ZxgY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ey04Hxi8TImqSLkBaUDt6Pcx+9BLqzII6u6SU1hmTP06He1N
	YwowDCQDzwIRZV+XcEVREPiwbTipeqj6Qb5o10FWzH2+PQxWtQS0uPO89z7I
X-Gm-Gg: ASbGnctQ3/5gGHVBfJ1LeZpxPMDN2g6vktx29xRcRcnZQJKKOi9jCIX/WBXAVIBRX4w
	0V3JiP8Fb4d2nT6zANXlgBdBpW4gIfNythtzy7MdYBsya1i9xaZh6yciyktwCXwdje11DpQ7qCR
	WX/+QWlG26mZssFYenvkZWIOT5ylyUYmXkEg2q1HnNmv6O0BgQKDcwY1C171C6rZPCuy/PYAUPV
	sVumpHpvOmsXar1RM72Jn1AxBTEOIqvaczBlt/mH/cfUEBHRj6vB0CWHqWnWzeOMehgvGyp05GY
	GM6dKXqePuA+O6ay9k2hgqHiEm0WOo3NhFAzMg==
X-Google-Smtp-Source: AGHT+IHAbGhLfu84PEeqZdHsJ6K1Yq3WN2mVSNF4v8KsZRzMJjaeXTUFivP3lVE1bhgaZByvGHaJLQ==
X-Received: by 2002:a17:902:f68a:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-22c532857admr16973855ad.8.1744952772906;
        Thu, 17 Apr 2025 22:06:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fda391sm8947985ad.214.2025.04.17.22.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 22:06:12 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 17 Apr 2025 22:05:53 -0700
Subject: [PATCH net-next v2] selftests/vsock: add initial vmtest.sh for
 vsock
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-vsock-vmtest-v2-1-3901a27331e8@gmail.com>
X-B4-Tracking: v=1; b=H4sIALDdAWgC/1XNQQqDMBBA0auEWTslM1ZoXfUexUWMo4bWpCQhW
 MS7F7Lr+sP7BySJThL06oAoxSUXPPSKGwV2NX4RdBP0Clhzp1vusKRgX1i2LCnj2BqmiUmzZWg
 UfKLMbq/cE7xk9LJnGBoFq0s5xG/9FKq9klfS/2QhJJzbztxoMuP9Zh/LZtz7YsMGw3meP++6A
 j+yAAAA
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

Future work can include vsock_diag_test.

Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
---
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
 tools/testing/selftests/vsock/config.vsock |  10 +
 tools/testing/selftests/vsock/vmtest.sh    | 306 +++++++++++++++++++++++++++++
 4 files changed, 318 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3fce441672349f7850c57d788bc1a29b203fba5..f214cf7c4fb59ec67885ee6c81daa44e17c80f5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25323,6 +25323,7 @@ F:	include/uapi/linux/vm_sockets.h
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
diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
new file mode 100755
index 0000000000000000000000000000000000000000..61dfcc06223fa7a30cb575cb3f2d01121b3ed3ce
--- /dev/null
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -0,0 +1,306 @@
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
+PLATFORM=${PLATFORM:-$(uname -m)}
+
+if [[ -z "${QEMU:-}" ]]; then
+	QEMU=$(which qemu-system-${PLATFORM})
+fi
+
+SKIP_BUILD=0
+
+VSOCK_TEST=${KERNEL_CHECKOUT}/tools/testing/vsock/vsock_test
+
+TEST_GUEST_PORT=51000
+TEST_HOST_PORT=50000
+TEST_HOST_PORT_LISTENER=50001
+SSH_GUEST_PORT=22
+SSH_HOST_PORT=2222
+VSOCK_CID=1234
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
+LOG=${SCRIPT_DIR}/vsock_selftests.log
+
+#		Name				Description
+tests="
+	vm_server_host_client     Run vsock_test in server mode on the VM and in client mode on the host.
+	vm_client_host_server     Run vsock_test in client mode on the VM and in server mode on the host.
+	vm_loopback               Run vsock_test using the loopback transport in the VM.
+"
+
+usage() {
+	echo
+	echo "$0 [OPTIONS]"
+	echo
+	echo "Options"
+	echo "  -v: verbose output"
+	echo "  -s: skip build"
+	echo
+	echo "Available tests${tests}"
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
+		pkill -9 -F ${QEMU_PIDFILE} 2>&1 >/dev/null
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
+		$VNG_OPTS	\
+		--run ~/local/linux \
+		--qemu /bin/qemu-system-x86_64 \
+		--qemu-opts="${QEMU_OPTS}" \
+		--user root \
+		--append "${KERNEL_CMDLINE}" \
+		--rw  2>&1 >/dev/null &
+}
+
+vm_wait_for_ssh() {
+	i=0
+	while [[ true ]]; do
+		if (( i > 20 )); then
+			die "Timed out waiting for guest ssh"
+		fi
+		vm_ssh -- true
+		if [[ $? -eq 0 ]]; then
+			break
+		fi
+		i=$(( i + 1 ))
+		sleep 5
+	done
+}
+
+wait_for_listener() {
+	local PORT=$1
+	local i=0
+	while ! ss -ltn | grep -q ":${PORT}"; do
+		if (( i > 30 )); then
+			die "Timed out waiting for listener on port ${PORT}"
+		fi
+		sleep 3
+		i=$(( i + 1 ))
+	done
+}
+
+vm_wait_for_listener() {
+	local port=$1
+	vm_ssh -- "$(declare -f wait_for_listener); wait_for_listener ${port}"
+}
+
+host_wait_for_listener() {
+	wait_for_listener ${TEST_HOST_LISTENER_PORT}
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
+	${VSOCK_TEST}	\
+		--mode=client	\
+		--control-host=127.0.0.1	\
+		--peer-cid="${VSOCK_CID}"	\
+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
+
+	rc=$?
+}
+
+test_vm_client_host_server() {
+	local testname="${FUNCNAME[0]#test_}"
+
+	${VSOCK_TEST}	\
+		--mode "server" \
+		--control-port "${TEST_HOST_PORT_LISTENER}" \
+		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
+
+	host_wait_for_listener
+
+	vm_ssh -- "${VSOCK_TEST}"	\
+		--mode=client	\
+		--control-host=10.0.2.2	\
+		--peer-cid=2	\
+		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
+
+	rc=$?
+}
+
+test_vm_loopback() {
+	local testname="${FUNCNAME[0]#test_}"
+	local port=60000 # non-forwarded local port
+
+	vm_ssh -- ${VSOCK_TEST}	\
+		--mode=server \
+		--control-port="${port}" \
+		--peer-cid="${VSOCK_CID}" &
+
+	vm_wait_for_listener ${port}
+
+	vm_ssh -- ${VSOCK_TEST}	\
+		--mode=client	\
+		--control-host="127.0.0.1" \
+		--control-port="${port}" \
+		--peer-cid="${VSOCK_CID}"
+
+	rc=$?
+}
+
+run_test() {
+	unset IFS
+	local host_oops_cnt_before=$(dmesg | grep -i 'Oops' | wc -l)
+	local host_warn_cnt_before=$(dmesg --level=warn | wc -l)
+	local vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	local vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
+
+	name=$(echo "${1}" | awk '{ print $1 }')
+	eval test_"${name}"
+
+	local host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
+	if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
+		echo "${name}: kernel oops detected on host" | log_host ${name}
+		rc=1
+	fi
+
+	local host_warn_cnt_after=$(dmesg --level=warn | wc -l)
+	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
+		echo "${name}: kernel warning detected on host" | log_host ${name}
+		rc=1
+	fi
+
+	local vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
+		echo "${name}: kernel oops detected on vm" | log_host ${name}
+		rc=1
+	fi
+
+	local vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
+	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
+		echo "${name}: kernel warning detected on vm" | log_host ${name}
+		rc=1
+	fi
+}
+
+while getopts :hvs o
+do
+	case $o in
+	v) VERBOSE=1;;
+	s) SKIP_BUILD=1;;
+	h|*) usage;;
+	esac
+done
+shift $((OPTIND-1))
+
+trap cleanup EXIT
+
+> ${LOG}
+if (( SKIP_BUILD != 1 )); then
+	build
+fi
+log_setup "Booting up VM"
+vm_setup
+vm_wait_for_ssh
+log_setup "VM booted up"
+
+IFS="
+"
+cnt=0
+for t in ${tests}; do
+	rc=0
+	run_test "${t}"
+	if [[ ${rc} != 0 ]]; then
+		cnt=$(( cnt + 1 ))
+	fi
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
base-commit: cc04ed502457412960d215b9cd55f0d966fda255
change-id: 20250325-vsock-vmtest-b3a21d2102c2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@gmail.com>


