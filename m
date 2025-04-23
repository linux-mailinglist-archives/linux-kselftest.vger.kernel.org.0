Return-Path: <linux-kselftest+bounces-31387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF46CA9867B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 11:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1FB3A73D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 09:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB42262FDD;
	Wed, 23 Apr 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/4rlgCh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E16D262FC2
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401989; cv=none; b=o2p8H6L/ZJdyHZAwu6/VLzWfBbfEUzEoRW9+ZAseR7X82nN+AS+OJFkXvBEzy44gShEQ1rvYDCbdVA9zeZJVoC7kIREeBM/38/8Js2rV5K/W7JNSqJo9+ecNTYuc+8Or+aTz5QpqfoViJMDTuyK8l8g5Uv6vvKsd21k5ABC0U9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401989; c=relaxed/simple;
	bh=U5yXw26sa3szgBEB4LzfURQCw32HcHb31OM/JpInzAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kmtfj1j2FNOpV+jadiWYqqn6I8SEXTWYbmsSxMBg0wHoXubCzXPWk8spb8O5OcLiuTl8Sq4ITSYiXConCSTFmDhGM2lC4kbQSgo0f3v/gz/tAJnIHs+RpvQfIX9Dw0e84h4zujkB7Pzp8Q+j1WScxoVTVhhLJgo4Mypv6CMXKzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/4rlgCh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745401986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dj2sAoXNr+Ixy1q2pKFX2yBLtrU4B8tUlBpM53gKSfA=;
	b=I/4rlgChzi1AbXEX6dD31bPCB20VP0UJn5FxcyTgYwXrfNe9jUkyqBpwtrvqIJ1ybQHYeK
	moV+sHMI/lfKmsshQ30usuRznviZcD1xV2IN+IPjc4CucMVktrjea0O9GFVQpFUeuWz3do
	FJcctMs3gHEwsNOhO541zTdJ4F/4Nto=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-mAVT8LdRNjuHuN59lnvIsg-1; Wed, 23 Apr 2025 05:53:04 -0400
X-MC-Unique: mAVT8LdRNjuHuN59lnvIsg-1
X-Mimecast-MFC-AGG-ID: mAVT8LdRNjuHuN59lnvIsg_1745401984
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e90b13f5c3so141045896d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 02:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745401984; x=1746006784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dj2sAoXNr+Ixy1q2pKFX2yBLtrU4B8tUlBpM53gKSfA=;
        b=eyTaeMt0j52zpB6eGfUOb1VPIqmU2jUgdLDPC8krUnjyfvIo3cbi/25wxIngHMAKP5
         J7ZDQpTrmOEcjs4vtyYsHjcAeZcw4v09Wb36MnK4Q3+9jGZRkLKGEa1kK3RmpoFEil2r
         4DPAZk5fKYrkSMHPeFNVtwa9FdUAxCfzJx4KGG90N+IhGErQH26BB0TPjN6X94XEC1ij
         5gMemvLMNWzjKVpmwp9935+kJvS8yc119z63dTAdLk+CEqO5izbidwv/a6xMQIFB6yXb
         Qbw2wqT8qnN35DKZEz7/VObvs4UVg+wRqi1RnOVg1y0SDOyYohXfRXPJnL97Ba1qlsBj
         aWbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKxnHQocErJWIHlO6HuvmjjXVX9xlSiSE1kqVsTsu9ICgm3uEyxu7h59yhAf0oxwihNbpC/0DvbLLDYp8MrZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz9GezW2QiQYX/ixuVkjNRj8rYsdht0qVgMnrNkEgUifqArTzB
	AORHuFs0ZxdUJFPR/hbUKEiKcWlX2rirzPN9CdFyQg1ZW0PULeQH4/YHrpX8qB14ciXJ3XmpH1M
	sTP7z357y/Wi1xR0VDHEthtsMtDbc2SYJGz5zkKIH5zkcCn4Zq6c9j7j2SsJTEjX60w==
X-Gm-Gg: ASbGnctL4rjMAqVEhIQsCv2jIGN0Q7F1THzhhTeWUtfBY+igbLBi9IpyHrKJOzkWOx3
	kTTMrCjEiEbQetsQY8j3CeZNb2gkQqTL0KQTqjJurRQwbf3ONBefEbZ8FeMsuC9srmb8cmWwLBV
	PrxSzVeLJAE+CdrH8tlImAbRqwyWctcgguBLC88GNO4f3uDQTL5nulmeZod8BKsuRNzUQ+6gLSa
	+vbbMOSot6yQdIynPtCGcxIZUShRWix4qJvCA5KLWwa1LSf4ZEMrX/i135quc6vZ+R4x3JJ5l1Y
	7s4MZw0EhAPhNJKdJA==
X-Received: by 2002:a05:6214:29cd:b0:6e8:9e9c:d20f with SMTP id 6a1803df08f44-6f2c4576b1amr350122556d6.21.1745401983903;
        Wed, 23 Apr 2025 02:53:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmgp2JwRrNMK/q74s595Od7UgPj2YU5GS4W3JOW29wbPRRb1P3CCPoBNzovYyqRKwPt+8evQ==
X-Received: by 2002:a05:6214:29cd:b0:6e8:9e9c:d20f with SMTP id 6a1803df08f44-6f2c4576b1amr350122286d6.21.1745401983459;
        Wed, 23 Apr 2025 02:53:03 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.217.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af1c27sm68897826d6.2.2025.04.23.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 02:53:02 -0700 (PDT)
Date: Wed, 23 Apr 2025 11:52:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <lgqapvbfvfzkbe3xzuytba4zct7zryomgqfnc4k7ejhxxzanyj@n7i5jawceipr>
References: <20250417-vsock-vmtest-v2-1-3901a27331e8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250417-vsock-vmtest-v2-1-3901a27331e8@gmail.com>

Hi Bobby,
I had couple of more comments below:

On Thu, Apr 17, 2025 at 10:05:53PM -0700, Bobby Eshleman wrote:
>This commit introduces a new vmtest.sh runner for vsock.
>
>It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
>H2G, and loopback. The testing tools from tools/testing/vsock/ are
>reused. Currently, only vsock_test is used.
>
>VMCI and hyperv support is automatically built, though not used.
>
>Only tested on x86.
>
>To run:
>
>  $ tools/testing/selftests/vsock/vmtest.sh
>
>Future work can include vsock_diag_test.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
>---
>Changes in v2:
>- add kernel oops and warnings checker
>- change testname variable to use FUNCNAME
>- fix spacing in test_vm_server_host_client
>- add -s skip build option to vmtest.sh
>- add test_vm_loopback
>- pass port to vm_wait_for_listener
>- fix indentation in vmtest.sh
>- add vmci and hyperv to config
>- changed whitespace from tabs to spaces in help string
>- Link to v1: https://lore.kernel.org/r/20250410-vsock-vmtest-v1-1-f35a81dab98c@gmail.com
>---
> MAINTAINERS                                |   1 +
> tools/testing/selftests/vsock/.gitignore   |   1 +
> tools/testing/selftests/vsock/config.vsock |  10 +
> tools/testing/selftests/vsock/vmtest.sh    | 306 +++++++++++++++++++++++++++++
> 4 files changed, 318 insertions(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index c3fce441672349f7850c57d788bc1a29b203fba5..f214cf7c4fb59ec67885ee6c81daa44e17c80f5f 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -25323,6 +25323,7 @@ F:	include/uapi/linux/vm_sockets.h
> F:	include/uapi/linux/vm_sockets_diag.h
> F:	include/uapi/linux/vsockmon.h
> F:	net/vmw_vsock/
>+F:	tools/testing/selftests/vsock/
> F:	tools/testing/vsock/
>
> VMALLOC
>diff --git a/tools/testing/selftests/vsock/.gitignore b/tools/testing/selftests/vsock/.gitignore
>new file mode 100644
>index 0000000000000000000000000000000000000000..1950aa8ac68c0831c12c1aaa429da45bbe41e60f
>--- /dev/null
>+++ b/tools/testing/selftests/vsock/.gitignore
>@@ -0,0 +1 @@
>+vsock_selftests.log
>diff --git a/tools/testing/selftests/vsock/config.vsock b/tools/testing/selftests/vsock/config.vsock
>new file mode 100644
>index 0000000000000000000000000000000000000000..9e0fb2270e6a2fc0beb5f0d9f0bc37158d0a9d23
>--- /dev/null
>+++ b/tools/testing/selftests/vsock/config.vsock
>@@ -0,0 +1,10 @@
>+CONFIG_VSOCKETS=y
>+CONFIG_VSOCKETS_DIAG=y
>+CONFIG_VSOCKETS_LOOPBACK=y
>+CONFIG_VMWARE_VMCI_VSOCKETS=y
>+CONFIG_VIRTIO_VSOCKETS=y
>+CONFIG_VIRTIO_VSOCKETS_COMMON=y
>+CONFIG_HYPERV_VSOCKETS=y
>+CONFIG_VMWARE_VMCI=y
>+CONFIG_VHOST_VSOCK=y
>+CONFIG_HYPERV=y
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>new file mode 100755
>index 0000000000000000000000000000000000000000..61dfcc06223fa7a30cb575cb3f2d01121b3ed3ce
>--- /dev/null
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -0,0 +1,306 @@
>+#!/bin/bash
>+# SPDX-License-Identifier: GPL-2.0
>+#
>+# Copyright (c) 2025 Meta Platforms, Inc. and affiliates
>+#
>+# Dependencies:
>+#		* virtme-ng
>+#		* busybox-static (used by virtme-ng)
>+#		* qemu	(used by virtme-ng)
>+
>+SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
>+KERNEL_CHECKOUT=$(realpath ${SCRIPT_DIR}/../../../..)
>+PLATFORM=${PLATFORM:-$(uname -m)}
>+
>+if [[ -z "${QEMU:-}" ]]; then
>+	QEMU=$(which qemu-system-${PLATFORM})
>+fi
>+
>+SKIP_BUILD=0
>+
>+VSOCK_TEST=${KERNEL_CHECKOUT}/tools/testing/vsock/vsock_test
>+
>+TEST_GUEST_PORT=51000
>+TEST_HOST_PORT=50000
>+TEST_HOST_PORT_LISTENER=50001
>+SSH_GUEST_PORT=22
>+SSH_HOST_PORT=2222
>+VSOCK_CID=1234
>+
>+QEMU_PIDFILE=/tmp/qemu.pid
>+
>+# virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
>+# control port forwarded for vsock_test.  Because virtme-ng doesn't support
>+# adding an additional port to forward to the device created from "--ssh" and
>+# virtme-init mistakenly sets identical IPs to the ssh device and additional
>+# devices, we instead opt out of using --ssh, add the device manually, and also
>+# add the kernel cmdline options that virtme-init uses to setup the interface.
>+QEMU_OPTS=""
>+QEMU_OPTS="${QEMU_OPTS} -netdev user,id=n0,hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
>+QEMU_OPTS="${QEMU_OPTS},hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
>+QEMU_OPTS="${QEMU_OPTS} -device virtio-net-pci,netdev=n0"
>+QEMU_OPTS="${QEMU_OPTS} -device vhost-vsock-pci,guest-cid=${VSOCK_CID}"
>+QEMU_OPTS="${QEMU_OPTS} --pidfile ${QEMU_PIDFILE}"
>+KERNEL_CMDLINE="virtme.dhcp net.ifnames=0 biosdevname=0 virtme.ssh virtme_ssh_user=$USER"
>+
>+LOG=${SCRIPT_DIR}/vsock_selftests.log
>+
>+#		Name				Description
>+tests="
>+	vm_server_host_client     Run vsock_test in server mode on the VM and in client mode on the host.
>+	vm_client_host_server     Run vsock_test in client mode on the VM and in server mode on the host.
>+	vm_loopback               Run vsock_test using the loopback transport in the VM.
>+"
>+
>+usage() {
>+	echo
>+	echo "$0 [OPTIONS]"
>+	echo
>+	echo "Options"
>+	echo "  -v: verbose output"
>+	echo "  -s: skip build"
>+	echo
>+	echo "Available tests${tests}"
>+	exit 1
>+}
>+
>+die() {
>+	echo "$*" >&2
>+	exit 1
>+}
>+
>+vm_ssh() {
>+	ssh -q -o UserKnownHostsFile=/dev/null -p 2222 localhost $*
>+	return $?
>+}
>+
>+cleanup() {
>+	if [[ -f "${QEMU_PIDFILE}" ]]; then
>+		pkill -9 -F ${QEMU_PIDFILE} 2>&1 >/dev/null

Why SIGKILL ? can we be more graceful (e.g. SIGTERM) ?

>+	fi
>+}
>+
>+build() {
>+	log_setup "Building kernel and tests"
>+
>+	pushd ${KERNEL_CHECKOUT} >/dev/null
>+	vng \
>+		--kconfig \
>+		--config ${KERNEL_CHECKOUT}/tools/testing/selftests/vsock/config.vsock
>+	make -j$(nproc)
>+	make -C ${KERNEL_CHECKOUT}/tools/testing/vsock
>+	popd >/dev/null
>+	echo
>+}
>+
>+vm_setup() {
>+	local VNG_OPTS=""
>+	if [[ "${VERBOSE}" = 1 ]]; then
>+		VNG_OPTS="--verbose"
>+	fi
>+	vng \
>+		$VNG_OPTS	\
>+		--run ~/local/linux \
>+		--qemu /bin/qemu-system-x86_64 \
>+		--qemu-opts="${QEMU_OPTS}" \
>+		--user root \
>+		--append "${KERNEL_CMDLINE}" \
>+		--rw  2>&1 >/dev/null &
>+}
>+
>+vm_wait_for_ssh() {
>+	i=0
>+	while [[ true ]]; do
>+		if (( i > 20 )); then
>+			die "Timed out waiting for guest ssh"
>+		fi
>+		vm_ssh -- true
>+		if [[ $? -eq 0 ]]; then
>+			break
>+		fi
>+		i=$(( i + 1 ))
>+		sleep 5
>+	done
>+}
>+
>+wait_for_listener() {
>+	local PORT=$1
>+	local i=0
>+	while ! ss -ltn | grep -q ":${PORT}"; do
>+		if (( i > 30 )); then
>+			die "Timed out waiting for listener on port ${PORT}"
>+		fi
>+		sleep 3
>+		i=$(( i + 1 ))
>+	done
>+}
>+
>+vm_wait_for_listener() {
>+	local port=$1
>+	vm_ssh -- "$(declare -f wait_for_listener); wait_for_listener ${port}"
>+}
>+
>+host_wait_for_listener() {
>+	wait_for_listener ${TEST_HOST_LISTENER_PORT}

Typo here: s/TEST_HOST_LISTENER_PORT/TEST_HOST_PORT_LISTENER

>+}
>+
>+log() {
>+	local prefix="$1"
>+	shift
>+
>+	if [[ "$#" -eq 0 ]]; then
>+		cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }' | tee -a ${LOG}
>+	else
>+		echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }' | tee -a ${LOG}
>+	fi
>+}
>+
>+log_setup() {
>+	log "setup" "$@"
>+}
>+
>+log_host() {
>+	testname=$1
>+	shift
>+	log "test:${testname}:host" "$@"
>+}
>+
>+log_guest() {
>+	testname=$1
>+	shift
>+	log "test:${testname}:guest" "$@"
>+}
>+
>+test_vm_server_host_client() {
>+	local testname="${FUNCNAME[0]#test_}"
>+
>+	vm_ssh -- "${VSOCK_TEST}" \
>+		--mode=server \
>+		--control-port="${TEST_GUEST_PORT}" \
>+		--peer-cid=2 \
>+		2>&1 | log_guest "${testname}" &
>+
>+	vm_wait_for_listener ${TEST_GUEST_PORT}
>+
>+	${VSOCK_TEST}	\
>+		--mode=client	\
>+		--control-host=127.0.0.1	\
>+		--peer-cid="${VSOCK_CID}"	\
>+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
>+
>+	rc=$?

Why using a global variable instead of a return value?

>+}
>+
>+test_vm_client_host_server() {
>+	local testname="${FUNCNAME[0]#test_}"
>+
>+	${VSOCK_TEST}	\
>+		--mode "server" \
>+		--control-port "${TEST_HOST_PORT_LISTENER}" \
>+		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
>+
>+	host_wait_for_listener
>+
>+	vm_ssh -- "${VSOCK_TEST}"	\
>+		--mode=client	\
>+		--control-host=10.0.2.2	\
>+		--peer-cid=2	\
>+		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
>+
>+	rc=$?
>+}
>+
>+test_vm_loopback() {
>+	local testname="${FUNCNAME[0]#test_}"
>+	local port=60000 # non-forwarded local port
>+
>+	vm_ssh -- ${VSOCK_TEST}	\
>+		--mode=server \
>+		--control-port="${port}" \
>+		--peer-cid="${VSOCK_CID}" &
>+
>+	vm_wait_for_listener ${port}
>+
>+	vm_ssh -- ${VSOCK_TEST}	\
>+		--mode=client	\
>+		--control-host="127.0.0.1" \
>+		--control-port="${port}" \
>+		--peer-cid="${VSOCK_CID}"
>+
>+	rc=$?
>+}
>+
>+run_test() {
>+	unset IFS
>+	local host_oops_cnt_before=$(dmesg | grep -i 'Oops' | wc -l)
>+	local host_warn_cnt_before=$(dmesg --level=warn | wc -l)
>+	local vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
>+	local vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
>+
>+	name=$(echo "${1}" | awk '{ print $1 }')
>+	eval test_"${name}"
>+
>+	local host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
>+	if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
>+		echo "${name}: kernel oops detected on host" | log_host ${name}
>+		rc=1
>+	fi
>+
>+	local host_warn_cnt_after=$(dmesg --level=warn | wc -l)
>+	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
>+		echo "${name}: kernel warning detected on host" | log_host ${name}
>+		rc=1
>+	fi
>+
>+	local vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
>+	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
>+		echo "${name}: kernel oops detected on vm" | log_host ${name}
>+		rc=1
>+	fi
>+
>+	local vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
>+	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
>+		echo "${name}: kernel warning detected on vm" | log_host ${name}
>+		rc=1
>+	fi
>+}
>+
>+while getopts :hvs o
>+do
>+	case $o in
>+	v) VERBOSE=1;;

Should we set VERBOSE=0 on top as default like we do for SKIP_BUILD ?

>+	s) SKIP_BUILD=1;;
>+	h|*) usage;;
>+	esac
>+done
>+shift $((OPTIND-1))
>+
>+trap cleanup EXIT
>+
>+> ${LOG}
>+if (( SKIP_BUILD != 1 )); then

I recommend using the same syntax in this file to check variables
(I mean for example when we check SKIP_BUILD and VERBOSE), I don't
have a preference.

>+	build
>+fi
>+log_setup "Booting up VM"
>+vm_setup
>+vm_wait_for_ssh
>+log_setup "VM booted up"
>+
>+IFS="
>+"
>+cnt=0
>+for t in ${tests}; do
>+	rc=0
>+	run_test "${t}"
>+	if [[ ${rc} != 0 ]]; then
>+		cnt=$(( cnt + 1 ))
>+	fi
>+done
>+
>+if [[ ${cnt} = 0 ]]; then
>+	echo OK
>+else
>+	echo FAILED: ${cnt}
>+fi
>+echo "Log: ${LOG}"
>+exit ${cnt}
>
>---
>base-commit: cc04ed502457412960d215b9cd55f0d966fda255
>change-id: 20250325-vsock-vmtest-b3a21d2102c2
>
>Best regards,
>-- 
>Bobby Eshleman <bobbyeshleman@gmail.com>
>


