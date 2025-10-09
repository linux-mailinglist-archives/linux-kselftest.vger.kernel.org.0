Return-Path: <linux-kselftest+bounces-42937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8551DBCA47F
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 18:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A48E3538F6
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Oct 2025 16:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37977235045;
	Thu,  9 Oct 2025 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF5iyd18"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68D22CBC0
	for <linux-kselftest@vger.kernel.org>; Thu,  9 Oct 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029185; cv=none; b=GJJ4dJWVqKC2HBMyKYu5mMbjG28pxJn7vjWYaVfqjZlbPB72+WL3OnVDTTgANJ94Bh5m7FWWlcptuE1qycROx4h3g7/bHoIZpp5jjzfJgeD6bCa/yl7atWm8y0yFgtUyCDTQlBQwDm5DWnkto0xDrLQ2fDV4QHuloQB0XLEm5QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029185; c=relaxed/simple;
	bh=s0pAKrHhCYacWUYIlOcIBdgkTDvnvcKnUuozGJ7CNIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZAYg4p/9ZHgR6X5shFXc6sAi14cFCWwgxG+0zXqa2MLZEy/EE2XuU77TiOCJi8amKAnyUt6cOkCYv8ySzOC0C9hROQNNt24fl4IHLnfywYyV1RK9WJ89+TkU6+bIZ583Bpa3M3GXESn7d/UblEJsgSWSTBJ6dnrggHO4VheGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JF5iyd18; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63b710f276fso1267942d50.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Oct 2025 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760029182; x=1760633982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L0nlv6lKy0ilQxl/LVyHSc5E6/NGf/YFQBH9SH9ZDRs=;
        b=JF5iyd18D1AnLdNx6u+VmoiaWgTVohYNpBIH+pFaE4SMjHxC51oorCd7R9tklolW37
         u/QT6nWgUb2dxSHm+yhlR31KF+kLSDvEPmjQ1ciol8iXM7ZzR3aBFebrjcW+omteMGjO
         +XLt85QAROa+McPab385eMDIN5jTplxdMPPm2zl8uNbH85PW2lNeqapHZEq+Ov+uSPOp
         NIFK21K6ITdu8eNYp/kZVUgWccYyPLx693vyjlyyDe12lErGqmGeE6sQbav8Jx/MjcpE
         LNuGjkI0evM1CPJw3GJ3XUO1H4Hqd93GQcr71PRNAJzhWS2k5JbkDftJfjguWPrYaGfF
         VtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760029182; x=1760633982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0nlv6lKy0ilQxl/LVyHSc5E6/NGf/YFQBH9SH9ZDRs=;
        b=mPyaOpHzwDNj8scgHhU8WaMomD3xfdxJXsdUnfn8ksHe0zMnfFLhcnDPWhwyPtcIny
         uok9tjvnOYEhDgVM1/y9qgS5NmH9DqW0C55vws2xViUv1bvskli/GB+HacoL5Xkip8Rd
         dXj+0pzJImeDrskQ/Nzn5fRJS/D7Qyy4ZUDlgZHkyEKSut+UNFYCI0dsUOoYik59sJDo
         5lP10xAT9ZmbUqFFHzx6aJI0IOY60tL8X7TKLE17WuZ2QCL7g0rLG+4LpYRD5M/D8aOj
         JZnmQQ1IbS+zKmS3aQcBytc0Bp7wXu9stNUX0bUVMrQH7nTPRa9JVE8SMTOP/k4iXviR
         Fwlg==
X-Forwarded-Encrypted: i=1; AJvYcCWuRo/af7wqRaTAk6uZk6KN6QGt9H5bog/40jOWrwDM99OrFmeMCNyW1d3HzXFqKCdRqPx+IAtnBdWNL1tP7ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyVPemlXm/6bL8LWouLcCjxMWfDnNdZYxGmHz/clSY5070UxjI
	4rLxLo648pQyyRl9TUDtQQpqNRy1AVKC5D/SuaOczLB2+ZPlBqJZ+RVw
X-Gm-Gg: ASbGncsXIJQu7WS+QT2QTeKINyDcF3G9vuYpxLmuEv7s3kszX3JckjuEtE85Nr7ot/8
	CV+T/Hluioc5pkopOfWauLFcBubYO4pvXnoyf6rFaf+uG0nifAsMCCfVLDgdkRyeeAXewT7uRzq
	n4dQ9pLq4vTewUCb+mxSCa3xfMyhPa/yyHixlIPQLc23cEd1TjcM46FYIzutfpm4wNXL93ahS8d
	h+0FDBezzzDUJ9z+cug3jfoA1JzjuRPUiqR5eJn0GM6n4fZvkBn//3s22/5EaudwXDYxaXKN3QS
	BH6LpfaghdBm4y4HdN6TcIIM10beyRw9ydgB6xV12EByccdWX2jeWuOoDCVABdtvTI5O+VO8/7S
	focSNAllwpoUGA1GLEsaQX0EQoPyB6DaBad8okS0DnmVf/DbduRjVyzkfaJhDT8WleubrvvPByw
	TE9DRAb3SPuX8/DyuKqQ2IYuqpRqg=
X-Google-Smtp-Source: AGHT+IGik4OXAJHYgBGqcMq+TOf8a7oRCVhJzxkOjsbQSsa+jY2kjFAt8lCRxoN3u6YKk4uQrYpn3w==
X-Received: by 2002:a05:690e:69c:b0:635:4ed0:5711 with SMTP id 956f58d0204a3-63ccb91b33bmr6113298d50.43.1760029181236;
        Thu, 09 Oct 2025 09:59:41 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:e::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63cd9516074sm1014156d50.4.2025.10.09.09.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:59:40 -0700 (PDT)
Date: Thu, 9 Oct 2025 09:59:34 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 9/9] selftests/vsock: add namespace tests
Message-ID: <aOfp6Ieds0n57POf@devvm11784.nha0.facebook.com>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250916-vsock-vmtest-v6-9-064d2eb0c89d@meta.com>
 <5kgnein4cq2ymeq3cozevld3ppbzbv62usavfigpi33krqjqde@k3sn3giizzvr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5kgnein4cq2ymeq3cozevld3ppbzbv62usavfigpi33krqjqde@k3sn3giizzvr>

On Tue, Sep 30, 2025 at 10:58:46AM +0200, Stefano Garzarella wrote:
> On Tue, Sep 16, 2025 at 04:43:53PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add tests for namespace support in vsock. Use socat for basic connection
> > failure tests and vsock_test for full functionality tests when
> > communication is expected to succeed. vsock_test is not used for failure
> > cases because in theory vsock_test could allow connection and some
> > traffic flow but fail on some other case (e.g., fail on MSG_ZEROCOPY).
> > 
> > Tests cover all cases of clients and servers being in all variants of
> > local ns, global ns, host process, and VM process.
> > 
> > Legacy tests are retained and executed in the init ns.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > ---
> > Changes in v6:
> > - check for namespace support in vmtest.sh
> > 
> > Changes in v5:
> > - use /proc/sys/net/vsock/ns_mode
> > - clarify logic of tests that reuse the same VM and tests that require
> >  netns setup
> > - fix unassigned BUILD bug
> > ---
> > tools/testing/selftests/vsock/vmtest.sh | 954 ++++++++++++++++++++++++++++----
> > 1 file changed, 849 insertions(+), 105 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index 5e36d1068f6f..59621b32cf1a 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -7,6 +7,7 @@
> > #		* virtme-ng
> > #		* busybox-static (used by virtme-ng)
> > #		* qemu	(used by virtme-ng)
> > +#		* socat
> > 
> > readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
> > readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
> > @@ -23,7 +24,7 @@ readonly VSOCK_CID=1234
> > readonly WAIT_PERIOD=3
> > readonly WAIT_PERIOD_MAX=60
> > readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
> > -readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
> > +readonly WAIT_QEMU=5
> > 
> > # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
> > # control port forwarded for vsock_test.  Because virtme-ng doesn't support
> > @@ -33,23 +34,146 @@ readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
> > # add the kernel cmdline options that virtme-init uses to setup the interface.
> > readonly QEMU_TEST_PORT_FWD="hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
> > readonly QEMU_SSH_PORT_FWD="hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
> > -readonly QEMU_OPTS="\
> > -	 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
> > -	 -device virtio-net-pci,netdev=n0 \
> > -	 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
> > -	 --pidfile ${QEMU_PIDFILE} \
> > -"
> 
> I expected this patch to only add new tests, but we are changing a few things.
> Are they related, or can they be moved to another preparation patch?
> 

Unfortunately they are related. For example, this pidfile change is
because this patch introduces testing two VMs up at once (to test if
their CIDs collide), so they each need unique pidfiles.

Definitely can be moved to a preparation patch, will do next rev.

> > readonly KERNEL_CMDLINE="\
> > 	virtme.dhcp net.ifnames=0 biosdevname=0 \
> > 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
> > "
> > readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
> > -readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
> > +readonly TEST_NAMES=(
> > +	vm_server_host_client
> > +	vm_client_host_server
> > +	vm_loopback
> > +	host_vsock_ns_mode_ok
> 
> can we use a `ns_` prefix for all ns related tests?
> 

Yep, np.

> > +	host_vsock_ns_mode_write_once_ok
> > +	global_same_cid_fails
> > +	local_same_cid_ok
> > +	global_local_same_cid_ok
> > +	local_global_same_cid_ok
> > +	diff_ns_global_host_connect_to_global_vm_ok
> > +	diff_ns_global_host_connect_to_local_vm_fails
> > +	diff_ns_global_vm_connect_to_global_host_ok
> > +	diff_ns_global_vm_connect_to_local_host_fails
> > +	diff_ns_local_host_connect_to_local_vm_fails
> > +	diff_ns_local_vm_connect_to_local_host_fails
> > +	diff_ns_global_to_local_loopback_local_fails
> > +	diff_ns_local_to_global_loopback_fails
> > +	diff_ns_local_to_local_loopback_fails
> > +	diff_ns_global_to_global_loopback_ok
> > +	same_ns_local_loopback_ok
> > +	same_ns_local_host_connect_to_local_vm_ok
> > +	same_ns_local_vm_connect_to_local_host_ok
> > +)
> > +
> > readonly TEST_DESCS=(
> > +	# vm_server_host_client
> > 	"Run vsock_test in server mode on the VM and in client mode on the host."
> > +
> > +	# vm_client_host_server
> > 	"Run vsock_test in client mode on the VM and in server mode on the host."
> > +
> > +	# vm_loopback
> > 	"Run vsock_test using the loopback transport in the VM."
> > +
> > +	# host_vsock_ns_mode_ok
> > +	"Check /proc/sys/net/vsock/ns_mode strings on the host."
> > +
> > +	# host_vsock_ns_mode_write_once_ok
> > +	"Check /proc/sys/net/vsock/ns_mode is write-once on the host."
> > +
> > +	# global_same_cid_fails
> > +	"Check QEMU fails to start two VMs with same CID in two different global namespaces."
> > +
> > +	# local_same_cid_ok
> > +	"Check QEMU successfully starts two VMs with same CID in two different local namespaces."
> > +
> > +	# global_local_same_cid_ok
> > +	"Check QEMU successfully starts one VM in a global ns and then another VM in a local ns with the same CID."
> > +
> > +	# local_global_same_cid_ok
> > +	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
> > +
> > +	# diff_ns_global_host_connect_to_global_vm_ok
> > +	"Run vsock_test client in global ns with server in VM in another global ns."
> > +
> > +	# diff_ns_global_host_connect_to_local_vm_fails
> > +	"Run socat to test a process in a global ns fails to connect to a VM in a local ns."
> > +
> > +	# diff_ns_global_vm_connect_to_global_host_ok
> > +	"Run vsock_test client in VM in a global ns with server in another global ns."
> > +
> > +	# diff_ns_global_vm_connect_to_local_host_fails
> > +	"Run socat to test a VM in a global ns fails to connect to a host process in a local ns."
> > +
> > +	# diff_ns_local_host_connect_to_local_vm_fails
> > +	"Run socat to test a host process in a local ns fails to connect to a VM in another local ns."
> > +
> > +	# diff_ns_local_vm_connect_to_local_host_fails
> > +	"Run socat to test a VM in a local ns fails to connect to a host process in another local ns."
> > +
> > +	# diff_ns_global_to_local_loopback_local_fails
> > +	"Run socat to test a loopback vsock in a global ns fails to connect to a vsock in a local ns."
> > +
> > +	# diff_ns_local_to_global_loopback_fails
> > +	"Run socat to test a loopback vsock in a local ns fails to connect to a vsock in a global ns."
> > +
> > +	# diff_ns_local_to_local_loopback_fails
> > +	"Run socat to test a loopback vsock in a local ns fails to connect to a vsock in another local ns."
> > +
> > +	# diff_ns_global_to_global_loopback_ok
> > +	"Run socat to test a loopback vsock in a global ns successfully connects to a vsock in another global ns."
> > +
> > +	# same_ns_local_loopback_ok
> > +	"Run socat to test a loopback vsock in a local ns successfully connects to a vsock in the same ns."
> > +
> > +	# same_ns_local_host_connect_to_local_vm_ok
> > +	"Run vsock_test client in a local ns with server in VM in same ns."
> > +
> > +	# same_ns_local_vm_connect_to_local_host_ok
> > +	"Run vsock_test client in VM in a local ns with server in same ns."
> 
> Should we run some test to check edge cases like namespace deletion
> during active connections or changing ns mode from global to local while
> running.
> 

Sgtm!

> > +)
> > +
> > +readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
> > +readonly USE_INIT_NETNS=(
> > +	global_same_cid_fails
> > +	local_same_cid_ok
> > +	global_local_same_cid_ok
> > +	local_global_same_cid_ok
> > +	diff_ns_global_host_connect_to_global_vm_ok
> > +	diff_ns_global_host_connect_to_local_vm_fails
> > +	diff_ns_global_vm_connect_to_global_host_ok
> > +	diff_ns_global_vm_connect_to_local_host_fails
> > +	diff_ns_local_host_connect_to_local_vm_fails
> > +	diff_ns_local_vm_connect_to_local_host_fails
> > +	diff_ns_global_to_local_loopback_local_fails
> > +	diff_ns_local_to_global_loopback_fails
> > +	diff_ns_local_to_local_loopback_fails
> > +	diff_ns_global_to_global_loopback_ok
> > +	same_ns_local_loopback_ok
> > +	same_ns_local_host_connect_to_local_vm_ok
> > +	same_ns_local_vm_connect_to_local_host_ok
> > +)
> > +readonly REQUIRES_NETNS=(
> > +	host_vsock_ns_mode_ok
> > +	host_vsock_ns_mode_write_once_ok
> > +	global_same_cid_fails
> > +	local_same_cid_ok
> > +	global_local_same_cid_ok
> > +	local_global_same_cid_ok
> > +	diff_ns_global_host_connect_to_global_vm_ok
> > +	diff_ns_global_host_connect_to_local_vm_fails
> > +	diff_ns_global_vm_connect_to_global_host_ok
> > +	diff_ns_global_vm_connect_to_local_host_fails
> > +	diff_ns_local_host_connect_to_local_vm_fails
> > +	diff_ns_local_vm_connect_to_local_host_fails
> > +	diff_ns_global_to_local_loopback_local_fails
> > +	diff_ns_local_to_global_loopback_fails
> > +	diff_ns_local_to_local_loopback_fails
> > +	diff_ns_global_to_global_loopback_ok
> > +	same_ns_local_loopback_ok
> > +	same_ns_local_host_connect_to_local_vm_ok
> > +	same_ns_local_vm_connect_to_local_host_ok
> > )
> > +readonly MODES=("local" "global")
> 
> What about NS_MODES ?
> 

Roger that.

> > 
> > readonly LOG_LEVEL_DEBUG=0
> > readonly LOG_LEVEL_INFO=1
> > @@ -58,6 +182,12 @@ readonly LOG_LEVEL_ERROR=3
> > 
> > VERBOSE="${LOG_LEVEL_WARN}"
> > 
> > +# Test pass/fail counters
> > +cnt_pass=0
> > +cnt_fail=0
> > +cnt_skip=0
> > +cnt_total=0
> > +
> > usage() {
> > 	local name
> > 	local desc
> > @@ -77,7 +207,7 @@ usage() {
> > 	for ((i = 0; i < ${#TEST_NAMES[@]}; i++)); do
> > 		name=${TEST_NAMES[${i}]}
> > 		desc=${TEST_DESCS[${i}]}
> > -		printf "\t%-35s%-35s\n" "${name}" "${desc}"
> > +		printf "\t%-55s%-35s\n" "${name}" "${desc}"
> > 	done
> > 	echo
> > 
> > @@ -89,21 +219,87 @@ die() {
> > 	exit "${KSFT_FAIL}"
> > }
> > 
> > +add_namespaces() {
> > +	# add namespaces local0, local1, global0, and global1
> > +	for mode in "${MODES[@]}"; do
> > +		ip netns add "${mode}0" 2>/dev/null
> > +		ip netns add "${mode}1" 2>/dev/null
> > +	done
> > +}
> > +
> > +init_namespaces() {
> > +	for mode in "${MODES[@]}"; do
> > +		ns_set_mode "${mode}0" "${mode}"
> > +		ns_set_mode "${mode}1" "${mode}"
> > +
> > +		log_host "set ns ${mode}0 to mode ${mode}"
> > +		log_host "set ns ${mode}1 to mode ${mode}"
> > +
> > +		# we need lo for qemu port forwarding
> > +		ip netns exec "${mode}0" ip link set dev lo up
> > +		ip netns exec "${mode}1" ip link set dev lo up
> > +	done
> > +}
> > +
> > +del_namespaces() {
> > +	for mode in "${MODES[@]}"; do
> > +		ip netns del "${mode}0"
> > +		ip netns del "${mode}1"
> > +		log_host "removed ns ${mode}0"
> > +		log_host "removed ns ${mode}1"
> > +	done &>/dev/null
> > +}
> > +
> > +ns_set_mode() {
> > +	local ns=$1
> > +	local mode=$2
> > +
> > +	echo "${mode}" | ip netns exec "${ns}" \
> > +		tee /proc/sys/net/vsock/ns_mode &>/dev/null
> > +}
> > +
> > vm_ssh() {
> > -	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> > +	local ns_exec
> > +
> > +	if [[ "${1}" == none ]]; then
> > +		local ns_exec=""
> > +	else
> > +		local ns_exec="ip netns exec ${1}"
> > +	fi
> > +
> > +	shift
> > +
> > +	${ns_exec} ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost $*
> > +
> > 	return $?
> > }
> > 
> > cleanup() {
> > -	if [[ -s "${QEMU_PIDFILE}" ]]; then
> > -		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
> > -	fi
> > +	del_namespaces
> > +}
> > 
> > -	# If failure occurred during or before qemu start up, then we need
> > -	# to clean this up ourselves.
> > -	if [[ -e "${QEMU_PIDFILE}" ]]; then
> > -		rm "${QEMU_PIDFILE}"
> > -	fi
> > +terminate_pidfiles() {
> > +	local pidfile
> > +
> > +	for pidfile in "$@"; do
> > +		if [[ -s "${pidfile}" ]]; then
> > +			pkill -SIGTERM -F "${pidfile}" 2>&1 > /dev/null
> > +		fi
> > +
> > +		# If failure occurred during or before qemu start up, then we need
> > +		# to clean this up ourselves.
> > +		if [[ -e "${pidfile}" ]]; then
> > +			rm -f "${pidfile}"
> > +		fi
> > +	done
> > +}
> > +
> > +terminate_pids() {
> > +	local pid
> > +
> > +	for pid in "$@"; do
> > +		kill -SIGTERM "${pid}" &>/dev/null || :
> > +	done
> > }
> > 
> > check_args() {
> > @@ -133,7 +329,7 @@ check_args() {
> > }
> > 
> > check_deps() {
> > -	for dep in vng ${QEMU} busybox pkill ssh; do
> > +	for dep in vng ${QEMU} busybox pkill ssh socat; do
> > 		if [[ ! -x $(command -v "${dep}") ]]; then
> > 			echo -e "skip:    dependency ${dep} not found!\n"
> > 			exit "${KSFT_SKIP}"
> > @@ -147,6 +343,20 @@ check_deps() {
> > 	fi
> > }
> > 
> > +check_test_deps() {
> > +	local tname=$1
> > +
> > +	# If the test requires NS support, check if NS support exists
> > +	# using /proc/self/ns
> > +	if [[ "${tname}" =~ "${REQUIRES_NETNS[@]}" ]] &&
> > +	   [[ ! -e /proc/self/ns ]]; then
> > +		log_host "No NS support detected for test ${tname}"
> > +		return 1
> > +	fi
> > +
> > +	return 0
> > +}
> > +
> > check_vng() {
> > 	local tested_versions
> > 	local version
> > @@ -170,6 +380,20 @@ check_vng() {
> > 	fi
> > }
> > 
> > +check_socat() {
> > +	local support_string
> > +
> > +	support_string="$(socat -V)"
> > +
> > +	if [[ "${support_string}" != *"WITH_VSOCK 1"* ]]; then
> > +		die "err: socat is missing vsock support"
> > +	fi
> > +
> > +	if [[ "${support_string}" != *"WITH_UNIX 1"* ]]; then
> > +		die "err: socat is missing unix support"
> > +	fi
> > +}
> > +
> > handle_build() {
> > 	if [[ ! "${BUILD}" -eq 1 ]]; then
> > 		return
> > @@ -194,9 +418,14 @@ handle_build() {
> > }
> > 
> > vm_start() {
> > +	local cid=$1
> > +	local ns=$2
> > +	local pidfile=$3
> > 	local logfile=/dev/null
> > 	local verbose_opt=""
> > +	local qemu_opts=""
> > 	local kernel_opt=""
> > +	local ns_exec=""
> > 	local qemu
> > 
> > 	qemu=$(command -v "${QEMU}")
> > @@ -206,27 +435,37 @@ vm_start() {
> > 		logfile=/dev/stdout
> > 	fi
> > 
> > +	qemu_opts="\
> > +		 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
> > +		 -device virtio-net-pci,netdev=n0 \
> > +		${QEMU_OPTS} -device vhost-vsock-pci,guest-cid=${cid} \
> 
> Have we removed QEMU_OPTS, right?
> 
> (I still prefer to have it defined on top, but maybe there is a reason
> to remove it)
> 
> > +		--pidfile ${pidfile}
> > +	"
> > +
> > 	if [[ "${BUILD}" -eq 1 ]]; then
> > 		kernel_opt="${KERNEL_CHECKOUT}"
> > 	fi
> > 
> > -	vng \
> > +	if [[ "${ns}" != "none" ]]; then
> > +		ns_exec="ip netns exec ${ns}"
> > +	fi
> > +
> > +	${ns_exec} vng \
> > 		--run \
> > 		${kernel_opt} \
> > 		${verbose_opt} \
> > -		--qemu-opts="${QEMU_OPTS}" \
> > +		--qemu-opts="${qemu_opts}" \
> > 		--qemu="${qemu}" \
> > 		--user root \
> > 		--append "${KERNEL_CMDLINE}" \
> > 		--rw  &> ${logfile} &
> > 
> > -	if ! timeout ${WAIT_TOTAL} \
> 
> So WAIT_TOTAL is now unused, right?
> 

Yes, its definition can be dropped.

> Can you explain better this change?
> 

It turned out that WAIT_TOTAL (three minutes) was very long wait time to
just see if qemu places the pidfile or not. It's a suitable wait time
for VM boot up, but qemu creates the pidfile far before that. Waiting
three minutes made the cases where we expect the VM to fail bootup to
take a a very long time. Waiting only 5 seconds to check the pidfile
offers a lot of savings.

Sounds like this should also be a different patch.

[..]

> 
> Sorry, there are too many changes and reviewing it is complicated. Can you
> at least divide it into patches to fix pre-existing bugs, patches to support
> namespaces (and use init_ns for the ones we already have), and patches to
> add tests?
> 
> Thanks,
> Stefano
> 

No problem, totally understandable looking at it in hindsight. I'll
break it up and send that out after the window opens.

Thanks again for your patient review!

Best,
Bobby

