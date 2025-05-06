Return-Path: <linux-kselftest+bounces-32516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 376B0AACAF9
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 18:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE1C1BA1B0A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 16:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0617284B4E;
	Tue,  6 May 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbOWMO8V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E06284B35;
	Tue,  6 May 2025 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746548859; cv=none; b=Ege1KSeJAfFVdmpuWnLqhp9eLayh5uT8HITf/1nDMyO0l4rhd10ZsgNVZWZFG9WFo01vb05XqhGipcbVQ6nU35p/vVZYzx7sfC1K3Y5IZrZq2fbIc0HyhWV5Ni7QJi447fP2tXd6xIhuR5ndDxQ2j/dzwP8CBdySASma+nu29XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746548859; c=relaxed/simple;
	bh=t77JjOWF983S2yo+S8BpF99d6mDZ6QTQoysmlKYRh1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQ1jcoZZQ/ylZDYQwkPKqEt4xb3HANm6JFytt5u3ScSPeuBRvqNAOyNg6snSU14nOoKuJ0he/TkexDM70y2qRz5v4rjOHuAgDfWHtVK+7txC8g+a0Dy/OlyQvcIki5lqoSZFGejwKdaTN72jqNPqlt3ZqhMQsUwDMKSfxMqo2gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbOWMO8V; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so5649445b3a.1;
        Tue, 06 May 2025 09:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746548857; x=1747153657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4+aHBG7Ux1e18DCnuuxjWF5KTqADzL62NiKzmfieec=;
        b=XbOWMO8VqRtOD37SeSyOOgzbA39v8U1OvzQYjzK2htxOoPnObeP2VfzfWEs7IgNLor
         Uj4v8CQTDyh5ZeBDq6w2UNAUaTLrDdO/xyrOGdjd0B+S4xP2WFbe6hpeMvAAmnfMxcql
         VufPMR5QAsZ93qwNCSVl8SZ8zwUr6nB5gmOk+g7qI+E3C/XB2z81J0ZUCWPuTnB2GFbh
         4Mw6X1QIc0clYPk1/9VdgMdFtl9Vw1RT0qRWwnf2zq+Mxw9ZtJ0RCXrrgvDA0rhlX/4Z
         dTrYV3Eoso0JExe0N3pswZ55Ov6mOU46A+MRZp6TjGQn6GZJ1DQERrRBuPOuE6nOjrra
         Z7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746548857; x=1747153657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4+aHBG7Ux1e18DCnuuxjWF5KTqADzL62NiKzmfieec=;
        b=iRwXx92iOpWr/u9GkF5pOttwSFRVs4r2AOtdd7twtI60fYq6B9+m+1HfBbweQFUTpk
         e7hYlwgVwxPwL+1BIfhdzjxcjSuAF7SgF4FvPnMqacwIR4iYQnwzNHt3G8dfPnQ4Z13j
         UeLeP3VlRhhOmJqYi4M4KQLaNciDE9Zj2AA265HI28I5yYTWcgpxYGweugAQ9LCjVlv2
         Yz2oQ/8ScqsWxOh4cU6vnFP5nu8BvzhQQJLeBirIUgEck7bcdehJPHlutG48RYWiqIX6
         h1FglMMmwNi9+Xm2a0f0y8sc4Bjgt5MOzXiWeClAsaHZ2N6tT/3MBdHJsKZh+YK/WBXt
         NCLw==
X-Forwarded-Encrypted: i=1; AJvYcCU42cGTgdNToaqJOB2o2+FMGdoAC6ue6rhy9qqIYiEB2PorBnLnX0H013HhKXc8RgzBXOEKQW52AbgA8+Cvqqn9@vger.kernel.org, AJvYcCUJECdANx2+tkmUz4Js0ImmVOBmCyzmi34v6ESKxHMnyJ4Y3uqV/HOFNLhYmAK+UvmJ4tSVsPBNRHSUvY9o@vger.kernel.org, AJvYcCXSkhDtqA7TmiZS6EqTIhdBNAryDjIBpbC0hf1RspVYrBlcpJZBbLHCnAlu3v0u3kIqXPXqURHN@vger.kernel.org, AJvYcCXhpAEfrnkAo/G1mAoJOQcxz739I0u07MRzqzvcRND3Ah46N8FcYH/izL2kRdJ3EinYz4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXKEqxyVCzhXv3cIK86ENNApnecUax9jCSjVUGfevQ3puUbhiT
	8dSvEdJaqMZeLYGZYcW32yYbab7H/Ae4FyhrfmBvFKe49lVmg5yp
X-Gm-Gg: ASbGnctmK/QwFUtfkXU1dPEM2XMhu06iQLdX+u51HN+9t3XC+vaDae0MPkgWe9w5EIo
	OWPqhFBxpWHMs5p/ycKV0NpXHueWDtFzwaVn0YEVpbTKvVS9uTVK3ktw1Fp7OekWfnyw9l1ZM3T
	fyDpMGyJ8hzOFXeGkLEbSyfZctvVHNBXvauG4w3x50gilUx8L+dpYXBppIJdpazS14tQCweXPmP
	xDuEyujAB2v487Prs5s7/VEfdgvJwypJXBU942mBPbkJe1A3TPWimWHMTQzc9jXo8XKa96PdPxC
	rNFZophd1Fb5OY3YTPSDeNTtpyfk8UDllPFI17phYUMebwby8GcQG2JiNKJ7
X-Google-Smtp-Source: AGHT+IEzs0bjLB5zkw9j/S1/ceDqOSJy2CsPvvNJ4wRJWTHVZg0AVYcMnjXylpOZE8J6qEnvZtIuyQ==
X-Received: by 2002:a05:6a00:4c0e:b0:736:2a73:675b with SMTP id d2e1a72fcca58-7406f17a282mr16246702b3a.19.1746548856927;
        Tue, 06 May 2025 09:27:36 -0700 (PDT)
Received: from devbig793.prn5.facebook.com ([2a03:2880:ff:c::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405905d16asm9083656b3a.127.2025.05.06.09.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 09:27:36 -0700 (PDT)
Date: Tue, 6 May 2025 09:27:34 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <aBo4dievUeVxP7dk@devbig793.prn5.facebook.com>
References: <20250428-vsock-vmtest-v3-1-181af6163f3e@gmail.com>
 <3e3eea6b-10a6-4a32-aa12-ef6fdf2eeeb8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e3eea6b-10a6-4a32-aa12-ef6fdf2eeeb8@redhat.com>

On Fri, May 02, 2025 at 12:22:46PM +0200, Paolo Abeni wrote:
> On 4/29/25 1:48 AM, Bobby Eshleman wrote:
> > This commit introduces a new vmtest.sh runner for vsock.
> > 
> > It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
> > H2G, and loopback. The testing tools from tools/testing/vsock/ are
> > reused. Currently, only vsock_test is used.
> > 
> > VMCI and hyperv support is automatically built, though not used.
> > 
> > Only tested on x86.
> > 
> > To run:
> > 
> >   $ tools/testing/selftests/vsock/vmtest.sh
> > 
> > or
> > 
> >   $ make -C tools/testing/selftests TARGETS=vsock run_tests
> > 
> > Results:
> > 	# linux/tools/testing/selftests/vsock/vmtest.log
> > 	setup:  Building kernel and tests
> > 	setup:  Booting up VM
> > 	setup:  VM booted up
> > 	test:vm_server_host_client:guest:       Control socket listening on 0.0.0.0:51000
> > 	test:vm_server_host_client:guest:       Control socket connection accepted...
> > 	[...]
> > 	test:vm_loopback:guest: 30 - SOCK_STREAM retry failed connect()...ok
> > 	test:vm_loopback:guest: 31 - SOCK_STREAM SO_LINGER null-ptr-deref...ok
> > 	test:vm_loopback:guest: 31 - SOCK_STREAM SO_LINGER null-ptr-deref...ok
> > 
> > Future work can include vsock_diag_test.
> > 
> > vmtest.sh is loosely based off of tools/testing/selftests/net/pmtu.sh,
> > which was picked out of the bag of tests I knew to work with NIPA.
> > 
> > Because vsock requires a VM to test anything other than loopback, this
> > patch adds vmtest.sh as a kselftest itself. This is different than other
> > systems that have a "vmtest.sh", where it is used as a utility script to
> > spin up a VM to run the selftests as a guest (but isn't hooked into
> > kselftest). This aspect is worth review, as I'm not aware of all of the
> > enviroments where this would run.
> 
> I think this approach is interesting, but I think it will need some
> additional more work, see below...
> 
> [...]
> 
> > diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..e7b9417537fbc4626153b72e8f295ab4594c844b
> > --- /dev/null
> > +++ b/tools/testing/selftests/vsock/settings
> > @@ -0,0 +1 @@
> > +timeout=0
> 
> We need a reasonable, bounded runtime for nipa integration.
> 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > new file mode 100755
> > index 0000000000000000000000000000000000000000..d70b9446e531d6d20beb24ddeda2cf0a9f7e9a39
> > --- /dev/null
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -0,0 +1,354 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright (c) 2025 Meta Platforms, Inc. and affiliates
> > +#
> > +# Dependencies:
> > +#		* virtme-ng
> > +#		* busybox-static (used by virtme-ng)
> > +#		* qemu	(used by virtme-ng)
> 
> You should probably check for such tools presence and bail out with skip
> otherwise.
> 
> > +
> > +SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
> > +KERNEL_CHECKOUT=$(realpath ${SCRIPT_DIR}/../../../..)
> 
> This is not going to work if/when the self-tests are installed in their
> own directory via `make install` in the tools/testing/selftests/
> directory, and that use case is supposed to work.
> 
> At very least you should check for the expected layout and skip otherwise.
> 
> > +QEMU=$(command -v qemu-system-$(uname -m))
> > +VERBOSE=0
> > +SKIP_BUILD=0
> > +VSOCK_TEST=${KERNEL_CHECKOUT}/tools/testing/vsock/vsock_test
> > +
> > +TEST_GUEST_PORT=51000
> > +TEST_HOST_PORT=50000
> > +TEST_HOST_PORT_LISTENER=50001
> > +SSH_GUEST_PORT=22
> > +SSH_HOST_PORT=2222
> > +VSOCK_CID=1234
> > +WAIT_PERIOD=3
> > +WAIT_PERIOD_MAX=20
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
> > +LOG=${SCRIPT_DIR}/vmtest.log
> > +
> > +#		Name				Description
> > +avail_tests="
> > +	vm_server_host_client	Run vsock_test in server mode on the VM and in client mode on the host.	
> > +	vm_client_host_server	Run vsock_test in client mode on the VM and in server mode on the host.	
> > +	vm_loopback		Run vsock_test using the loopback transport in the VM.	
> > +"
> > +
> > +usage() {
> > +	echo
> > +	echo "$0 [OPTIONS] [TEST]..."
> > +	echo "If no TEST argument is given, all tests will be run."
> > +	echo
> > +	echo "Options"
> > +	echo "  -v: verbose output"
> > +	echo "  -s: skip build"
> > +	echo
> > +	echo "Available tests${avail_tests}"
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
> > +		pkill -SIGTERM -F ${QEMU_PIDFILE} 2>&1 >/dev/null
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
> 
> I think it would be better to avoid the kernel rebuild. A possible
> alternative could be including in 'config' the needed knobs for vng's
> sake and re-use the running kernel.
> 
> Cheers,
> 
> Paolo
> 

Thanks Paolo, I'll incorporate your feedback in the next rev!

Best,
Bobby

