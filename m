Return-Path: <linux-kselftest+bounces-30735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7A3A88969
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 19:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2299A1780F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 17:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AC5288CAD;
	Mon, 14 Apr 2025 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lzw1m4Y+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5597C19D06A;
	Mon, 14 Apr 2025 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650770; cv=none; b=moJNvkptAHuGHGDr0dqNqaAm/Roqh9o8vbENuPp0YnPRTo87tSCxkAExf9dntGBsULCqulfMb4m4vimEEyz3RO88ZJItr7gFCgWA+WmEJk1fHxtN5WPslb9CooCdLkY2o2gP/AzWqzC5HRwrgL9vUaj7pWVZ2iV2FHqc2uF1kYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650770; c=relaxed/simple;
	bh=3Twvz8D7+vcV4nizaHeGRyouh94n34oFtgOLbtwIt+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4FTUo4+iT0k+mQaazYRfH+sV+qs07wsG3NOa01O7bFWoKt1AyAc/DeCKEsZvu09GZ8VdO03e00RCPaJsr7FfwnRytg3zTqP73Dw2mVf/82ELYqpbBsqPwJs+xpv7ayHQ2ZuEfnPCDaHAUMsVWSsXXFEwj5jxWak4mZcrT2Kodg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lzw1m4Y+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3081fe5987eso3764979a91.3;
        Mon, 14 Apr 2025 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744650767; x=1745255567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YcJnxnzCZagdVCzB7vm0T/6/uAvij+r8ppSPAeDHH40=;
        b=Lzw1m4Y+pZv/1+3N6BOFGD/mE76lhwqAtoxPN+hMd5w1K+8SOrj50Pk3ci9Bz3zfRA
         bF2OP0MxQDKPzffSv4dcrSwWOU4m/ukFUUXIlHIzEWAMkYb7+Wb+mhi6OlDiNIxWQblD
         dQUmphBa/jVeZUAL2LbPkwVMwKNSUrrxxRDn225weHa31TH3R+RyawCF3N66E6ePDyCO
         qmjGBUqCp4uOztJUBymYnAvmcgQozCzrU//QPm+MYaLyP+Aj6xZfMVGvf5CEQvMY1Joj
         cLDV7xnn+VTfp1DqPTvQYMBhf2Sg2CXhpv7ICiczHMq1A/0H8yvSS0NR1XokcO/Zxq7O
         OtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744650767; x=1745255567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcJnxnzCZagdVCzB7vm0T/6/uAvij+r8ppSPAeDHH40=;
        b=n706P+n9cUPYN3KAVqEtVeTHeV5OyzXdNeYn7OowQBgjraqM5bCTXq7BAZGZBveM4x
         xPZ01Iw/rZvpZaTjF1/PGDO+bLKoMFadYlOZuZ3dBuPzD3pt7aO4HUIw+w2dLElOlVjx
         tjPTNsavwnvWhR7k2JzhJNrm3R9CvlRT84BmFSsyMlKym+7Q4Oe4VTC8Pcr8eSg61L1b
         TOuJqN+yJ8MK1qkiMvqM4DBAHEtiDTnXX9U7fmx8rOqFLZ/vHZuaadPyX2puKPzFeHfZ
         u3IDmezqHEDt5x45gq6Jp7Kpd/ANDz0l27PI7Js/8wsAjGc+qNcH0lvPgBahyfLIwYJs
         eJvg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ2O7LrNzR/5ggf60lCSHpwmSpC8an6Er5oexE/4SKfhdJIkxpW7WlfNignrh4O345M7A=@vger.kernel.org, AJvYcCVsCnoxXRvW8qM8zRfL7YUwop2q296LD23jsAgG5wFrCavplIqrOZtCxhMoNhlXEP+LKF06DHZOgUBLbiBxnffl@vger.kernel.org, AJvYcCWKnufuxtCUAaRt3RGyAMue5xM8TrsVswATy9k0vxJrOL4DHdIRri36bkbfczdQ9VzrK5njy541@vger.kernel.org, AJvYcCWV33qnMdxPoYWfswqShE7dc5NoZ4BcTa4IROfW40cVnhQaqlbZJPHIMZzzJmTa9hCdEN0tej7ESivlZo4+@vger.kernel.org
X-Gm-Message-State: AOJu0YzloVU5OsnCR1JbUN/uCfFH9lzF60oV7cDh+coI0WethLQJlrWb
	6ii/YUHsAYNsWsHG4Dg8vEAQ/fpkr8AoWkXu2YL4dSVD/nsbhFau
X-Gm-Gg: ASbGncuA5VkgBtZ497Y433tfE6l1RsZzmBlyxzQ15ACwIlpDONosPgWT5xayVP7lSu2
	QeMOt7GaiXxtkD8yUGeP8QblLLJnbVP0ERJciQ5O1PT8Zx3hfrsURMjADndch0QROt/qyXFF4SM
	QOiZaVkcu6eWVUePO6I3X3RV8LbVOAZYCFacs/c8+dQyhA666spZxVSfNMOKo7uvOnMS9X5r+XC
	eVNVo53pO/CA1lLunoST8PsbWp+b0fD7GeZ2eKPz4YcnNnpgPLz2QpB1B0jaXsMLgEn3ug8zR2d
	ROhUKi5Kv2g0WAhFAsJZsdpvTo0qev8x7KZn1NVy2H8AA1Bpk5YqNY9qh2HNdWQ=
X-Google-Smtp-Source: AGHT+IFLxh6pO0oFjNBiAFAAIGnY4ukF3N/RGT93aiCYWOxdC3LzA3X7dZ0FxNOaGu88mbNYCyQifg==
X-Received: by 2002:a17:90b:3b82:b0:2fa:13d9:39c with SMTP id 98e67ed59e1d1-30823634a47mr21940459a91.14.1744650767255;
        Mon, 14 Apr 2025 10:12:47 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:4c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df403d40sm11316049a91.49.2025.04.14.10.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 10:12:46 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:12:44 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests/vsock: add initial vmtest.sh for vsock
Message-ID: <Z/1CDIje5SSE0N3D@devvm6277.cco0.facebook.com>
References: <20250410-vsock-vmtest-v1-1-f35a81dab98c@gmail.com>
 <36wtdlekqx7hii6s7uydxeyrwwj7x5dmx5k5g474eseds6lshk@yrefm7laynyp>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36wtdlekqx7hii6s7uydxeyrwwj7x5dmx5k5g474eseds6lshk@yrefm7laynyp>

On Fri, Apr 11, 2025 at 10:32:45AM +0200, Stefano Garzarella wrote:
> On Thu, Apr 10, 2025 at 06:07:59PM -0700, Bobby Eshleman wrote:
> > This commit introduces a new vmtest.sh runner for vsock.
> > 
> > It uses virtme-ng/qemu to run tests in a VM. The tests are designed to
> > validate both G2H and H2G paths. The testing tools from tools from
> > tools/testing/vsock/ are reused. Currently, only vsock_test is used.
> 
> Coool, thanks for that.
> I'll leave some comments, but I'll try this next week since today I'm a bit
> busy.
> 
> > 
> > Only tested on x86.
> > 
> > To run:
> > 
> >  $ tools/testing/selftests/vsock/vmtest.sh
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
> > ---
> > MAINTAINERS                                |   1 +
> > tools/testing/selftests/vsock/.gitignore   |   1 +
> > tools/testing/selftests/vsock/config.vsock |   6 +
> > tools/testing/selftests/vsock/vmtest.sh    | 247 +++++++++++++++++++++++++++++
> > 4 files changed, 255 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c3fce441672349f7850c57d788bc1a29b203fba5..f214cf7c4fb59ec67885ee6c81daa44e17c80f5f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -25323,6 +25323,7 @@ F:	include/uapi/linux/vm_sockets.h
> > F:	include/uapi/linux/vm_sockets_diag.h
> > F:	include/uapi/linux/vsockmon.h
> > F:	net/vmw_vsock/
> > +F:	tools/testing/selftests/vsock/
> > F:	tools/testing/vsock/
> > 
> > VMALLOC
> > diff --git a/tools/testing/selftests/vsock/.gitignore b/tools/testing/selftests/vsock/.gitignore
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..1950aa8ac68c0831c12c1aaa429da45bbe41e60f
> > --- /dev/null
> > +++ b/tools/testing/selftests/vsock/.gitignore
> > @@ -0,0 +1 @@
> > +vsock_selftests.log
> > diff --git a/tools/testing/selftests/vsock/config.vsock b/tools/testing/selftests/vsock/config.vsock
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..a229c329d44e4a0b650d073b74949b577da3dc64
> > --- /dev/null
> > +++ b/tools/testing/selftests/vsock/config.vsock
> > @@ -0,0 +1,6 @@
> > +CONFIG_VSOCKETS=y
> > +CONFIG_VSOCKETS_DIAG=y
> > +CONFIG_VSOCKETS_LOOPBACK=y
> > +CONFIG_VIRTIO_VSOCKETS=y
> > +CONFIG_VIRTIO_VSOCKETS_COMMON=y
> > +CONFIG_VHOST_VSOCK=y
> 
> Should we enabled also other transports?
> 
> (I'm not sure since we don't test it)
> 

Probably for the best to catch things that break the build?

> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > new file mode 100755
> > index 0000000000000000000000000000000000000000..f2dafcb893232f95ebb22104a62ce1e0312f4e89
> > --- /dev/null
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -0,0 +1,247 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright (c) 2025 Meta Platforms, Inc. and affiliates
> > +#
> > +# Dependencies:
> > +#		* virtme-ng
> > +#		* busybox-static (used by virtme-ng)
> > +#		* qemu	(used by virtme-ng)
> > +
> > +SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
> > +KERNEL_CHECKOUT=$(realpath ${SCRIPT_DIR}/../../../..)
> > +PLATFORM=${PLATFORM:-$(uname -m)}
> > +
> > +if [[ -z "${QEMU:-}" ]]; then
> > +	QEMU=$(which qemu-system-${PLATFORM})
> > +fi
> > +
> > +VSOCK_TEST=${KERNEL_CHECKOUT}/tools/testing/vsock/vsock_test
> > +
> > +TEST_GUEST_PORT=51000
> > +TEST_HOST_PORT=50000
> > +TEST_HOST_PORT_LISTENER=50001
> > +SSH_GUEST_PORT=22
> > +SSH_HOST_PORT=2222
> > +VSOCK_CID=1234
> > +
> > +QEMU_PIDFILE=/tmp/qemu.pid
> > +
> > +# virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
> > +# control port forwarded for vsock_test.  Because virtme-ng doesn't support
> > +# adding an additional port to forward to the device created from "--ssh" and
> > +# virtme-init mistakenly sets identical IPs to the ssh device and additional
> > +# devices, we instead opt out of using --ssh, add the device manually, and also
> > +# add the kernel cmdline options that virtme-init uses to setup the interface.
> > +QEMU_OPTS=""
> > +QEMU_OPTS="${QEMU_OPTS} -netdev user,id=n0,hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
> > +QEMU_OPTS="${QEMU_OPTS},hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
> > +QEMU_OPTS="${QEMU_OPTS} -device virtio-net-pci,netdev=n0"
> > +QEMU_OPTS="${QEMU_OPTS} -device vhost-vsock-pci,guest-cid=${VSOCK_CID}"
> > +QEMU_OPTS="${QEMU_OPTS} --pidfile ${QEMU_PIDFILE}"
> > +KERNEL_CMDLINE="virtme.dhcp net.ifnames=0 biosdevname=0 virtme.ssh virtme_ssh_user=$USER"
> > +
> > +LOG=${SCRIPT_DIR}/vsock_selftests.log
> > +
> > +#		Name				Description
> > +tests="
> > +	vm_server_host_client			Run vsock_test in server mode on the VM and in client mode on the host.
> > +	vm_client_host_server			Run vsock_test in client mode on the VM and in server mode on the host.
> 
> What about adding tests also with loopback in the VM?
> 

Can do!

> > +"
> > +
> > +usage() {
> > +	echo
> > +	echo "$0 [OPTIONS]"
> > +	echo
> > +	echo "Options"
> > +	echo "  -v: verbose output"
> > +	echo
> > +	echo "Available tests${tests}"
> > +	exit 1
> > +}
> > +
> > +die() {
> > +	echo "$*" >&2
> > +	exit 1
> > +}
> > +
> > +vm_ssh() {
> > +	ssh -q -o UserKnownHostsFile=/dev/null -p 2222 localhost $*
> > +	return $?
> > +}
> > +
> > +cleanup() {
> > +	if [[ -f "${QEMU_PIDFILE}" ]]; then
> > +		pkill -9 -F ${QEMU_PIDFILE} 2>&1 >/dev/null
> > +	fi
> > +}
> > +
> > +build() {
> > +	log_setup "Building kernel and tests"
> > +
> > +	pushd ${KERNEL_CHECKOUT} >/dev/null
> > +	vng \
> > +		--kconfig \
> > +		--config ${KERNEL_CHECKOUT}/tools/testing/selftests/vsock/config.vsock
> > +	make -j$(nproc)
> > +	make -C ${KERNEL_CHECKOUT}/tools/testing/vsock
> > +	popd >/dev/null
> > +	echo
> > +}
> > +
> > +vm_setup() {
> > +	local VNG_OPTS=""
> > +	if [[ "${VERBOSE}" = 1 ]]; then
> > +		VNG_OPTS="--verbose"
> > +	fi
> > +	vng \
> > +		$VNG_OPTS	\
> > +		--run ~/local/linux \
> > +		--qemu /bin/qemu-system-x86_64 \
> > +		--qemu-opts="${QEMU_OPTS}" \
> > +		--user root \
> > +		--append "${KERNEL_CMDLINE}" \
> > +		--rw  2>&1 >/dev/null &
> > +}
> > +
> > +vm_wait_for_ssh() {
> > +	i=0
> > +	while [[ true ]]; do
> > +		if (( i > 20 )); then
> > +			die "Timed out waiting for guest ssh"
> > +		fi
> > +		vm_ssh -- true
> > +		if [[ $? -eq 0 ]]; then
> > +			break
> > +		fi
> > +		i=$(( i + 1 ))
> > +		sleep 5
> > +	done
> > +}
> > +
> > +wait_for_listener() {
> > +	local PORT=$1
> > +	local i=0
> > +	while ! ss -ltn | grep -q ":${PORT}"; do
> > +		if (( i > 30 )); then
> > +			die "Timed out waiting for listener on port ${PORT}"
> > +		fi
> > +		sleep 3
> > +		i=$(( i + 1 ))
> > +	done
> > +}
> > +
> > +vm_wait_for_listener() {
> > +	vm_ssh -- "$(declare -f wait)for_listener); wait_for_listener
> > ${TEST_GUEST_PORT}"
> > +}
> > +
> > +host_wait_for_listener() {
> > +	wait_for_listener ${TEST_HOST_LISTENER_PORT}
> > +}
> > +
> > +log() {
> > +	local prefix="$1"
> > +	shift
> > +
> > +	if [[ "$#" -eq 0 ]]; then
> > +		cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }' | tee -a ${LOG}
> > +	else
> > +		echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }' | tee -a ${LOG}
> > +	fi
> > +}
> > +
> > +log_setup() {
> > +	log "setup" "$@"
> > +}
> > +
> > +log_host() {
> > +	testname=$1
> > +	shift
> > +	log "test:${testname}:host" "$@"
> > +}
> > +
> > +log_guest() {
> > +	testname=$1
> > +	shift
> > +	log "test:${testname}:guest" "$@"
> > +}
> > +
> > +test_vm_server_host_client() {
> > +	local testname="vm_server_host_client"
> > +	vm_ssh -- "${VSOCK_TEST}" \
> > +							--mode=server \
> > +							--control-port="${TEST_GUEST_PORT}" \
> > +							--peer-cid=2 \
> > +							2>&1 | log_guest "${testname}" &
> 
> Strange indentation here.
> 

Got it.

> > +
> > +	vm_wait_for_listener
> > +	${VSOCK_TEST}	\
> > +		--mode=client	\
> > +		--control-host=127.0.0.1	\
> > +		--peer-cid="${VSOCK_CID}"	\
> > +		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
> > +
> > +	rc=$?
> > +}
> > +
> > +test_vm_client_host_server() {
> > +	local testname="vm_client_host_server"
> > +
> > +	${VSOCK_TEST}	\
> > +		--mode "server" \
> > +		--control-port "${TEST_HOST_PORT_LISTENER}" \
> > +		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
> > +
> > +	host_wait_for_listener
> > +
> > +	vm_ssh -- "${VSOCK_TEST}"	\
> > +		--mode=client	\
> > +		--control-host=10.0.2.2	\
> > +		--peer-cid=2	\
> > +		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
> > +
> > +	rc=$?
> > +}
> > +
> > +run_test() {
> > +	unset IFS
> > +	name=$(echo "${1}" | awk '{ print $1 }')
> > +	eval test_"${name}"
> > +}
> > +
> > +while getopts :hv o
> > +do
> > +	case $o in
> > +	v) VERBOSE=1;;
> > +	h|*) usage;;
> > +	esac
> > +done
> > +shift $((OPTIND-1))
> > +
> > +trap cleanup EXIT
> > +
> > +> ${LOG}
> > +build
> > +log_setup "Booting up VM"
> > +vm_setup
> > +vm_wait_for_ssh
> > +log_setup "VM booted up"
> > +
> > +IFS="
> > +"
> > +cnt=0
> > +for t in ${tests}; do
> > +	rc=0
> > +	run_test "${t}"
> > +	if [[ ${rc} != 0 ]]; then
> > +		cnt=$(( cnt + 1 ))
> > +	fi
> > +done
> > +
> > +if [[ ${cnt} = 0 ]]; then
> > +	echo OK
> 
> In my suite I also check if we have some kernel warnings or oops.
> Should we add something similar or does the infrastructure already
> handle that?
> 

I think we'll need to add that, AFAIK infra like NIPA depends entirely
on the exit code of the test script.

BTW, I'm planning on integrating with NIPA, but that is still TODO.

> Thanks,
> Stefano
> 

Thanks!

-Bobby

