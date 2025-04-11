Return-Path: <linux-kselftest+bounces-30496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EC2A850F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 03:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EEA1897F8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 01:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DABB26FA70;
	Fri, 11 Apr 2025 01:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkMpMzfL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DBB26FA5E;
	Fri, 11 Apr 2025 01:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333685; cv=none; b=MuDbhYPOKRVUft+MKEinRNpSHTBLTK7L5vOJegyJeEzDFVajBDASCx0kHgp5n/yWz+oZcQc6A0ny23XLaR6Pd1ZS4IUyI8iwEzmgFTauC8iIbA4QBYP7bKV+tZDJAn2GRyvFMvEPWpUEyT1CKhPKYQJCjSlJ9wq0C4DzuOP+x10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333685; c=relaxed/simple;
	bh=mrG0fIf92a5Tp/jYDe7PfqHpOhbSZIQ4fkZvzhIho/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z8Pry1XpMZ+h+lu4POE4xhgAvCD0+xstuKXfuRogQIXY5kgrt4x1B0MLY3npnEk7ggAgzM8xdFAevegGYOWACRqF8JfE1Eu0hXyGTV8/5g1B3lPGPb4HdcHzrXsK3F1JrfmEi2TjP4Hzfwsueb7hhkGwdsDcxC1T+U/WzuGgboI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkMpMzfL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-227aaa82fafso11968425ad.2;
        Thu, 10 Apr 2025 18:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744333683; x=1744938483; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JGskHW7seL/P/rvGWfICBJ6oMmfUPuzdCOaSxJuegB4=;
        b=EkMpMzfLEGbwsKPPw4DjDaUGkI06nO3nbwHs9sd9F9zmXvDk+OgPD8dR0BGcDWPJFB
         9Jrky23t8r3Wr9H29TvH8KmEOtonJpwnVEMNRz1MkAiSLVBvCOeS7CADI6ulvy93O31H
         Fkgp3atYBsceVUicmbKzv6UKsiEsqkHKf9q/sOucSh8+zgAcc7eLq8iZoLxyfcEemy9e
         qWr77B+7f3ypEk2MoFdaC8J8Um8wUqQePC/bRE2AC1gijFswsDi7am9uLewu2HRAoHqE
         sj+gqiAHLmQZXfwHNB6id5EADvgv3ngGYHNVLJoFktN5kcthl4wbjF1kJH6CVL3ihUvv
         E2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744333683; x=1744938483;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGskHW7seL/P/rvGWfICBJ6oMmfUPuzdCOaSxJuegB4=;
        b=FQOBX7tKFs4eJlaPL4eNHlAxKnwtDfGeAa9qbSqJVm+5xTDiljW5rOTJ857GTi9SI2
         6H5DDnvgRdTkgmAR+ISPm6fcTpj6zCIWvKKKqasVsCjHtS2lwMyoakCnPZz42r85HXsV
         BJ1ekSjl8ruJAwZPdurNm1GDPrrP3NOxgGYt7fWhq5FxGgYn0bqrbMI762YKHcs19HLh
         DdaYdbQFaWwNa2FI0z+/koD0V+X0O6yjEJrR8JqUv/WYSJLqUcuBI8ATpIDXnxKe3FFM
         dLzhAxXH/UyKpkfoNM/7NDCDJRyKs0Eh4yUTgcfh3rRkE/XbbsW2BirkWc7ej239kFrh
         hXSA==
X-Forwarded-Encrypted: i=1; AJvYcCUJsdJ8c4lGNbrsTMHJFaRtAZdALRLsUMOT8zu4aOH7TwiObAm0l1FjZM++VmWoDNP6od64qUdI+IcK9LfJfE1R@vger.kernel.org, AJvYcCX2TMvdAkG1cHF5ulLS2zmEJzcKNhveu0K8X/8tbN8L7QzNQhfldL9wYKqhGLA7S2Gf/U2teIP01Hh/0CU=@vger.kernel.org, AJvYcCX3UjeoWC5nSpAz3wNoZu7tBaoFgu2vKqOeLnXUiaIEAMSZtJ27qn4KkYh4TqJ+46qb/oO7Q4r2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu3Iikr/Cf9CTtKuQ6b1sR/onb/Ah5svSAFeBGC48y+3SllZ3X
	ymzxaE/m9GvqM5PtApfcRkGd7a5qu5Lg1sCYoYkmF4sHAqGiq7No
X-Gm-Gg: ASbGnctdch2izJfoV/WxZKuJUJwv/rQ4+vP5G7uwKXPi/tQks5GrqgOIxsBANVm4gdu
	LEEk36wdh9izIiVQ6QtOoQSwXT3Hgt7sS15YjEgmSQgph07KZG04/F9hJJDr9LfvhW3rOm6aVTO
	/br/a6iJbAdMvs0ZqAyYzr6+JMih2fnl6s1KStjFFdheBxwKju+JT1NBPjWPdfjjrftgsG4iylJ
	u8iGRPi8oZd3Y4XLgGoRpquFA90nQsI9WWCaXnHeug6kCBUfNE+KVtpV1d2AiHZ6G6PPhTz2YAo
	D+FMb4ZF3aTFiyNxm5GbeNrksWKOZ9VIoV6V0GvE0lC2c2Bi
X-Google-Smtp-Source: AGHT+IH/PJdoKYT0aClNeZ6cG3SrtolFbPxI7bcbU1N2WvGjdVh+AypnsqfR8vsaLdVrqlT/u61amQ==
X-Received: by 2002:a17:902:cccc:b0:224:6ee:ad with SMTP id d9443c01a7336-22bea4fdc13mr12842955ad.44.1744333682871;
        Thu, 10 Apr 2025 18:08:02 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8b2absm37564365ad.83.2025.04.10.18.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 18:08:01 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 10 Apr 2025 18:07:59 -0700
Subject: [PATCH net-next] selftests/vsock: add initial vmtest.sh for vsock
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-vsock-vmtest-v1-1-f35a81dab98c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAG5r+GcC/x3MQQqDMBAF0KsMf+1AMuImVyld2DjVoTSWTAiCe
 Heh7wDvhGs1dSQ6UbWb216QKA6EvM1lVbYFiSBBpjDKxN33/OH+beqNX+MscZEYJAsGwq/q245
 /90DRxkWPhud13ZZ2ustoAAAA
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

It uses virtme-ng/qemu to run tests in a VM. The tests are designed to
validate both G2H and H2G paths. The testing tools from tools from
tools/testing/vsock/ are reused. Currently, only vsock_test is used.

Only tested on x86.

To run:

  $ tools/testing/selftests/vsock/vmtest.sh

Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
---
 MAINTAINERS                                |   1 +
 tools/testing/selftests/vsock/.gitignore   |   1 +
 tools/testing/selftests/vsock/config.vsock |   6 +
 tools/testing/selftests/vsock/vmtest.sh    | 247 +++++++++++++++++++++++++++++
 4 files changed, 255 insertions(+)

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
index 0000000000000000000000000000000000000000..a229c329d44e4a0b650d073b74949b577da3dc64
--- /dev/null
+++ b/tools/testing/selftests/vsock/config.vsock
@@ -0,0 +1,6 @@
+CONFIG_VSOCKETS=y
+CONFIG_VSOCKETS_DIAG=y
+CONFIG_VSOCKETS_LOOPBACK=y
+CONFIG_VIRTIO_VSOCKETS=y
+CONFIG_VIRTIO_VSOCKETS_COMMON=y
+CONFIG_VHOST_VSOCK=y
diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
new file mode 100755
index 0000000000000000000000000000000000000000..f2dafcb893232f95ebb22104a62ce1e0312f4e89
--- /dev/null
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -0,0 +1,247 @@
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
+	vm_server_host_client			Run vsock_test in server mode on the VM and in client mode on the host.
+	vm_client_host_server			Run vsock_test in client mode on the VM and in server mode on the host.
+"
+
+usage() {
+	echo
+	echo "$0 [OPTIONS]"
+	echo
+	echo "Options"
+	echo "  -v: verbose output"
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
+	vm_ssh -- "$(declare -f wait_for_listener); wait_for_listener ${TEST_GUEST_PORT}"
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
+	local testname="vm_server_host_client"
+	vm_ssh -- "${VSOCK_TEST}" \
+							--mode=server \
+							--control-port="${TEST_GUEST_PORT}" \
+							--peer-cid=2 \
+							2>&1 | log_guest "${testname}" &
+
+	vm_wait_for_listener
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
+	local testname="vm_client_host_server"
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
+run_test() {
+	unset IFS
+	name=$(echo "${1}" | awk '{ print $1 }')
+	eval test_"${name}"
+}
+
+while getopts :hv o
+do
+	case $o in
+	v) VERBOSE=1;;
+	h|*) usage;;
+	esac
+done
+shift $((OPTIND-1))
+
+trap cleanup EXIT
+
+> ${LOG}
+build
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


