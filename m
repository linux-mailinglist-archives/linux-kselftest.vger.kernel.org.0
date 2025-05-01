Return-Path: <linux-kselftest+bounces-32058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87C7AA59BC
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 04:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA72465438
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 02:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19412144C9;
	Thu,  1 May 2025 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8AKrM5h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779241CD0C;
	Thu,  1 May 2025 02:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746067079; cv=none; b=u3Lpea+IwsOpj+dMqnI1ofA9LZulHusZ0ecms2hcWLI6bdAgpdOudssPshE1Ee6UL8dJBiJWidF55Xkg/Vxfijgw+qezH/UTlvlC4b+lfEEqqaWasBsLM9kZCd44ubZeNYhxkHPQXuhtlUDCUmYdiNFt+8Zoae9mXuvqgXEm1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746067079; c=relaxed/simple;
	bh=kaGKadSipMjkOxe0UWpsondzGYM4Gzs5D64A1rgZPvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2WTdK2FIy2L7mtqIQ2t4GKMQoDs1QruaFDDKQqjuciL+yaprAtJDXjGnZL1938UeKL4sj+PglKkA4n8L4T+I+ckFqGPSRWcwVpKtF5sWPDXqG+FEW0cN1d/u3Y6tXsIx4S4ZxSi7xi0U93Cw1YX13s19wZnWiSkbTJVLon3cIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8AKrM5h; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso4714921fa.0;
        Wed, 30 Apr 2025 19:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746067075; x=1746671875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3w+Z99sex7Ni2LgQQ+OducHadVY0Ao4TEVcRPZFwJ4=;
        b=S8AKrM5hqFoOOQZaCuUNtUtlQL6kS3AyaNghc4NwKNCeJY3GXNqy2HFJUkgirY4sLf
         2IrSc1IZwKnhsNV1gHatCXMwAKazDS1k69xvAjILq6A43KxFjLiajYwb20AcYcnV2WMr
         BncohpuFy6KI11kJ+by8YQZMCOt6NTq1neuau85tVjAp2h4CXGLAWfwhUvlzY2QGUkBv
         cTifxmXiLSbkXZMl5Z4CAuMdi3ggf3YStYk1AhSxbBWQDExLaQDoW8PejrHuiYrKiNPf
         gx8/uIuxYtsum+xF9WiV+GUur+os8c8k3gqmyHki4kbAcThCVNCVjQc613GEYDA3LsD0
         780A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746067075; x=1746671875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3w+Z99sex7Ni2LgQQ+OducHadVY0Ao4TEVcRPZFwJ4=;
        b=XH/nWbjq0FkzcZM0cVybVvsUb8+yARdbk193WrRxnWB1Yu2tVpharjuPQjdmgKX0u0
         bMqwxCwZsuBEShdP8v9RvcYtWJ+trxXeArasq/VDv+VwOC2+Xp51pXJTGFCb/a3sovVH
         Z3x2BtIZ5fifmpYd8LriyTLGH34ArxIWHqU+BhhI6797P3Lk7dJipYb5U2Rx1whd1ggJ
         Ccm1f6ig3kClWaMphWDS77aSkVq8pHDRIGfzlVSG2eOAP3mj4mnyrS6PahcloOIiaIHU
         9DnOzNSdsIEHBEgbrJ7+BzcVwwIJ00fjD1zcF2H8OHqTnbX6msYZr6VRb9iMu4XTYzJ+
         jfIA==
X-Forwarded-Encrypted: i=1; AJvYcCUINLjTC/Wg2fq0HMs4xncj+VSadjKZ3tQNI02oEjtdg2QbZ0DfclRhrKQ3Jjb6GFuvZHU+seWudx9XAU4Y@vger.kernel.org, AJvYcCUib0WD3PszMO68EdGZZiS+ZwRzO6x0wiwpcIRxhsBDAPJhXoyhLvEwx+CUioskOrhGD2shnvrtpRtei0CjlG+B@vger.kernel.org, AJvYcCWg8atYpySTiR7hT2BG5jCzlmo2/qWowANAVOrT4WoRvBe1m18zFgEdxhs48W92eh2Sm6k=@vger.kernel.org, AJvYcCXevJ+r40dcsEN+yiSlzF8ThlS/hxpcl+9Czp3d9JqrUgtHvGrm4Wso2ILDtj9bCTztAsqAvvBo@vger.kernel.org
X-Gm-Message-State: AOJu0YxkTN96j5WzvdnI1BrXQ9QECQD1Jz0hmYN9vEey7YN7BV4dz5of
	wg6M1VnKf1zCpEYeEt2+v5TP0NPrjPmFspDl6sGN23p4U2nn4tUMyh8t35gDvScxWvn32oO9vv5
	V8JIz7pzkY0ncUJi5hkgtGU57LPY=
X-Gm-Gg: ASbGncv4n9FR9BdS1d/+YtNLglCRZCHkoSZllHyMGCHJSBwjUzoIgl6cO1H6pUsa7As
	H788KzN10HMjk1fctOJ7d+CZCn8+u3/YPWzLnBq1pbRprYIJoNamIAD+bMNGhVjJQhBlvVlaAVN
	r6O5MMZxPrsUKbEZ1cbWUj8vhKNgtfng==
X-Google-Smtp-Source: AGHT+IGr8K0QKoeX/DRDo5lbY3tKzJAxx64L6SAHJUEP8kVJUmCILE2pbbaoAxRnvBn/YyHIDfPf1TgvL1DY2x81x5Q=
X-Received: by 2002:a2e:ad93:0:b0:31a:6644:25c with SMTP id
 38308e7fff4ca-31ea2da9e32mr15765931fa.12.1746067075209; Wed, 30 Apr 2025
 19:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428-vsock-vmtest-v3-1-181af6163f3e@gmail.com> <a57wg5kmprrpk2dm3zlzvegb3gzj73ubs5lxeukyinc4edlcsw@itkgfcm44qu2>
In-Reply-To: <a57wg5kmprrpk2dm3zlzvegb3gzj73ubs5lxeukyinc4edlcsw@itkgfcm44qu2>
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 30 Apr 2025 19:37:42 -0700
X-Gm-Features: ATxdqUFExi5mAUA3_K_BOnza8T3UmjEygvcghGvKSijB9no_-t7o0YFhm-ZnYS4
Message-ID: <CAKB00G2pEJAFzFBMbCGW4gBNB4UqBpEw22a2Cs4oOdSXUWfsuQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] selftests/vsock: add initial vmtest.sh for vsock
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 6:06=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Mon, Apr 28, 2025 at 04:48:11PM -0700, Bobby Eshleman wrote:
> >This commit introduces a new vmtest.sh runner for vsock.
> >
> >It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
> >H2G, and loopback. The testing tools from tools/testing/vsock/ are
> >reused. Currently, only vsock_test is used.
> >
> >VMCI and hyperv support is automatically built, though not used.
> >
> >Only tested on x86.
> >
> >To run:
> >
> >  $ tools/testing/selftests/vsock/vmtest.sh
>
> I tried and it's working, but I have a lot of these messages in the
> output:
>      dmesg: read kernel buffer failed: Operation not permitted
>
> I'm on Fedora 41:
>
> $ uname -r
> 6.14.4-200.fc41.x86_64
>
> >
> >or
> >
> >  $ make -C tools/testing/selftests TARGETS=3Dvsock run_tests
> >
> >Results:
> >       # linux/tools/testing/selftests/vsock/vmtest.log
> >       setup:  Building kernel and tests
> >       setup:  Booting up VM
> >       setup:  VM booted up
> >       test:vm_server_host_client:guest:       Control socket listening =
on 0.0.0.0:51000
> >       test:vm_server_host_client:guest:       Control socket connection=
 accepted...
> >       [...]
> >       test:vm_loopback:guest: 30 - SOCK_STREAM retry failed connect()..=
.ok
> >       test:vm_loopback:guest: 31 - SOCK_STREAM SO_LINGER null-ptr-deref=
...ok
> >       test:vm_loopback:guest: 31 - SOCK_STREAM SO_LINGER null-ptr-deref=
...ok
> >
> >Future work can include vsock_diag_test.
> >
> >vmtest.sh is loosely based off of tools/testing/selftests/net/pmtu.sh,
> >which was picked out of the bag of tests I knew to work with NIPA.
> >
> >Because vsock requires a VM to test anything other than loopback, this
> >patch adds vmtest.sh as a kselftest itself. This is different than other
> >systems that have a "vmtest.sh", where it is used as a utility script to
> >spin up a VM to run the selftests as a guest (but isn't hooked into
> >kselftest). This aspect is worth review, as I'm not aware of all of the
> >enviroments where this would run.
>
> Yeah, an opinion from net maintainers on this would be great.
>
> >
> >Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
> >---
> >Changes in v3:
> >- use common conditional syntax for checking variables
> >- use return value instead of global rc
> >- fix typo TEST_HOST_LISTENER_PORT -> TEST_HOST_PORT_LISTENER
> >- use SIGTERM instead of SIGKILL on cleanup
> >- use peer-cid=3D1 for loopback
> >- change sleep delay times into globals
> >- fix test_vm_loopback logging
> >- add test selection in arguments
> >- make QEMU an argument
> >- check that vng binary is on path
> >- use QEMU variable
> >- change <tab><backslash> to <space><backslash>
> >- fix hardcoded file paths
> >- add comment in commit msg about script that vmtest.sh was based off of
> >- Add tools/testing/selftest/vsock/Makefile for kselftest
> >- Link to v2: https://lore.kernel.org/r/20250417-vsock-vmtest-v2-1-3901a=
27331e8@gmail.com
> >
> >Changes in v2:
> >- add kernel oops and warnings checker
> >- change testname variable to use FUNCNAME
> >- fix spacing in test_vm_server_host_client
> >- add -s skip build option to vmtest.sh
> >- add test_vm_loopback
> >- pass port to vm_wait_for_listener
> >- fix indentation in vmtest.sh
> >- add vmci and hyperv to config
> >- changed whitespace from tabs to spaces in help string
> >- Link to v1: https://lore.kernel.org/r/20250410-vsock-vmtest-v1-1-f35a8=
1dab98c@gmail.com
> >---
> > MAINTAINERS                                |   1 +
> > tools/testing/selftests/vsock/.gitignore   |   1 +
> > tools/testing/selftests/vsock/Makefile     |   9 +
> > tools/testing/selftests/vsock/config.vsock |  10 +
> > tools/testing/selftests/vsock/settings     |   1 +
> > tools/testing/selftests/vsock/vmtest.sh    | 354 ++++++++++++++++++++++=
+++++++
> > 6 files changed, 376 insertions(+)
>
> While applying git warned about trailing spaces, but also checkpatch is
> warning about them, please can you fix at least the errors (and maybe
> the misspelling):
>
> $ ./scripts/checkpatch.pl --strict -g master..HEAD --codespell
> WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit
> description?)
> #31:
>         test:vm_server_host_client:guest:       Control socket listening =
on 0.0.0.0:51000
>
> WARNING: 'enviroments' may be misspelled - perhaps 'environments'?
> #48:
> enviroments where this would run.
> ^^^^^^^^^^^
>
> ERROR: trailing whitespace
> #174: FILE: tools/testing/selftests/vsock/vmtest.sh:47:
> +^Ivm_server_host_client^IRun vsock_test in server mode on the VM and in =
client mode on the host.^I$
>
> WARNING: line length of 104 exceeds 100 columns
> #174: FILE: tools/testing/selftests/vsock/vmtest.sh:47:
> +       vm_server_host_client   Run vsock_test in server mode on the VM a=
nd in client mode on the host.
>
> ERROR: trailing whitespace
> #175: FILE: tools/testing/selftests/vsock/vmtest.sh:48:
> +^Ivm_client_host_server^IRun vsock_test in client mode on the VM and in =
server mode on the host.^I$
>
> WARNING: line length of 104 exceeds 100 columns
> #175: FILE: tools/testing/selftests/vsock/vmtest.sh:48:
> +       vm_client_host_server   Run vsock_test in client mode on the VM a=
nd in server mode on the host.
>
> ERROR: trailing whitespace
> #176: FILE: tools/testing/selftests/vsock/vmtest.sh:49:
> +^Ivm_loopback^I^IRun vsock_test using the loopback transport in the VM.^=
I$
>
> ERROR: trailing whitespace
> #443: FILE: tools/testing/selftests/vsock/vmtest.sh:316:
> +IFS=3D"^I$
>
> total: 4 errors, 4 warnings, 0 checks, 382 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>        mechanically convert to the typical style using --fix or --fix-inp=
lace.
>
> NOTE: Whitespace errors detected.
>        You may wish to use scripts/cleanpatch or scripts/cleanfile
>
> Commit ffa17d673263 ("selftests/vsock: add initial vmtest.sh for vsock") =
has style problems, please review.
>
> NOTE: If any of the errors are false positives, please report
>        them to the maintainer, see CHECKPATCH in MAINTAINERS.
>

This might not have been the right choice, but I adopted the technique
from the pmtu selftest of
using a tab at the end of the help text lines and then splitting with
"IFS=3D\t\n". I guess the win is that
running the script has the side effect of checking that the help text
has been updated, and the tab
is not visible?

I think we could do something similar with bash arrays though and have
no checkpatch complaints, and
not having to do "git commit --no-verify" to bypass the checks.

> >
> >diff --git a/MAINTAINERS b/MAINTAINERS
> >index 657a67f9031ef7798c19ac63e6383d4cb18a9e1f..3fbdd7bbfce7196a3cc7db70=
203317c6bd0e51fd 100644
> >--- a/MAINTAINERS
> >+++ b/MAINTAINERS
> >@@ -25751,6 +25751,7 @@ F:     include/uapi/linux/vm_sockets.h
> > F:    include/uapi/linux/vm_sockets_diag.h
> > F:    include/uapi/linux/vsockmon.h
> > F:    net/vmw_vsock/
> >+F:    tools/testing/selftests/vsock/
> > F:    tools/testing/vsock/
> >
> > VMALLOC
> >diff --git a/tools/testing/selftests/vsock/.gitignore b/tools/testing/se=
lftests/vsock/.gitignore
> >new file mode 100644
> >index 0000000000000000000000000000000000000000..1950aa8ac68c0831c12c1aaa=
429da45bbe41e60f
> >--- /dev/null
> >+++ b/tools/testing/selftests/vsock/.gitignore
> >@@ -0,0 +1 @@
> >+vsock_selftests.log
> >diff --git a/tools/testing/selftests/vsock/Makefile b/tools/testing/self=
tests/vsock/Makefile
> >new file mode 100644
> >index 0000000000000000000000000000000000000000..6fded8c4d593541a6f746214=
7bffcb719def378f
> >--- /dev/null
> >+++ b/tools/testing/selftests/vsock/Makefile
> >@@ -0,0 +1,9 @@
> >+# SPDX-License-Identifier: GPL-2.0
> >+.PHONY: all
> >+all:
> >+
> >+TEST_PROGS :=3D vmtest.sh
> >+EXTRA_CLEAN :=3D vmtest.log
> >+
> >+include ../lib.mk
> >+
> >diff --git a/tools/testing/selftests/vsock/config.vsock b/tools/testing/=
selftests/vsock/config.vsock
> >new file mode 100644
> >index 0000000000000000000000000000000000000000..9e0fb2270e6a2fc0beb5f0d9=
f0bc37158d0a9d23
> >--- /dev/null
> >+++ b/tools/testing/selftests/vsock/config.vsock
> >@@ -0,0 +1,10 @@
> >+CONFIG_VSOCKETS=3Dy
> >+CONFIG_VSOCKETS_DIAG=3Dy
> >+CONFIG_VSOCKETS_LOOPBACK=3Dy
> >+CONFIG_VMWARE_VMCI_VSOCKETS=3Dy
> >+CONFIG_VIRTIO_VSOCKETS=3Dy
> >+CONFIG_VIRTIO_VSOCKETS_COMMON=3Dy
> >+CONFIG_HYPERV_VSOCKETS=3Dy
> >+CONFIG_VMWARE_VMCI=3Dy
> >+CONFIG_VHOST_VSOCK=3Dy
> >+CONFIG_HYPERV=3Dy
> >diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/self=
tests/vsock/settings
> >new file mode 100644
> >index 0000000000000000000000000000000000000000..e7b9417537fbc4626153b72e=
8f295ab4594c844b
> >--- /dev/null
> >+++ b/tools/testing/selftests/vsock/settings
> >@@ -0,0 +1 @@
> >+timeout=3D0
> >diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/sel=
ftests/vsock/vmtest.sh
> >new file mode 100755
> >index 0000000000000000000000000000000000000000..d70b9446e531d6d20beb24dd=
eda2cf0a9f7e9a39
> >--- /dev/null
> >+++ b/tools/testing/selftests/vsock/vmtest.sh
> >@@ -0,0 +1,354 @@
> >+#!/bin/bash
> >+# SPDX-License-Identifier: GPL-2.0
> >+#
> >+# Copyright (c) 2025 Meta Platforms, Inc. and affiliates
> >+#
> >+# Dependencies:
> >+#             * virtme-ng
> >+#             * busybox-static (used by virtme-ng)
> >+#             * qemu  (used by virtme-ng)
> >+
> >+SCRIPT_DIR=3D"$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)=
"
> >+KERNEL_CHECKOUT=3D$(realpath ${SCRIPT_DIR}/../../../..)
> >+QEMU=3D$(command -v qemu-system-$(uname -m))
> >+VERBOSE=3D0
> >+SKIP_BUILD=3D0
> >+VSOCK_TEST=3D${KERNEL_CHECKOUT}/tools/testing/vsock/vsock_test
> >+
> >+TEST_GUEST_PORT=3D51000
> >+TEST_HOST_PORT=3D50000
> >+TEST_HOST_PORT_LISTENER=3D50001
> >+SSH_GUEST_PORT=3D22
> >+SSH_HOST_PORT=3D2222
> >+VSOCK_CID=3D1234
> >+WAIT_PERIOD=3D3
> >+WAIT_PERIOD_MAX=3D20
> >+
> >+QEMU_PIDFILE=3D/tmp/qemu.pid
> >+
> >+# virtme-ng offers a netdev for ssh when using "--ssh", but we also nee=
d a
> >+# control port forwarded for vsock_test.  Because virtme-ng doesn't sup=
port
> >+# adding an additional port to forward to the device created from "--ss=
h" and
> >+# virtme-init mistakenly sets identical IPs to the ssh device and addit=
ional
> >+# devices, we instead opt out of using --ssh, add the device manually, =
and also
> >+# add the kernel cmdline options that virtme-init uses to setup the int=
erface.
> >+QEMU_OPTS=3D""
> >+QEMU_OPTS=3D"${QEMU_OPTS} -netdev user,id=3Dn0,hostfwd=3Dtcp::${TEST_HO=
ST_PORT}-:${TEST_GUEST_PORT}"
> >+QEMU_OPTS=3D"${QEMU_OPTS},hostfwd=3Dtcp::${SSH_HOST_PORT}-:${SSH_GUEST_=
PORT}"
> >+QEMU_OPTS=3D"${QEMU_OPTS} -device virtio-net-pci,netdev=3Dn0"
> >+QEMU_OPTS=3D"${QEMU_OPTS} -device vhost-vsock-pci,guest-cid=3D${VSOCK_C=
ID}"
> >+QEMU_OPTS=3D"${QEMU_OPTS} --pidfile ${QEMU_PIDFILE}"
>
> What about:
>
> QEMU_OPTS=3D" \
>      -netdev user,id=3Dn0,hostfwd=3Dtcp::${TEST_HOST_PORT}-:${TEST_GUEST_=
PORT},hostfwd=3Dtcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT} \
>      -device virtio-net-pci,netdev=3Dn0 \
>      -device vhost-vsock-pci,guest-cid=3D${VSOCK_CID} \
>      --pidfile ${QEMU_PIDFILE}
> "
>
> Not a strong opinion, just I see too much "QEMU_OPTS=3D"${QEMU_OPTS}" xD
> You can leave it in that way if you prefer.
>

That's totally fine by me, no strong opinion on my side. I tend to do
the string-building thing
across the board because for some reason multiline strings look odd to
me when inside
function scope, and string-building looks like the same pattern
everywhere. Definitely not
a preference I hold tightly though.

> >+KERNEL_CMDLINE=3D"virtme.dhcp net.ifnames=3D0 biosdevname=3D0 virtme.ss=
h virtme_ssh_user=3D$USER"
> >+
> >+LOG=3D${SCRIPT_DIR}/vmtest.log
> >+
> >+#             Name                            Description
> >+avail_tests=3D"
> >+      vm_server_host_client   Run vsock_test in server mode on the VM a=
nd in client mode on the host.
> >+      vm_client_host_server   Run vsock_test in client mode on the VM a=
nd in server mode on the host.
> >+      vm_loopback             Run vsock_test using the loopback transpo=
rt in the VM.
> >+"
> >+
> >+usage() {
> >+      echo
> >+      echo "$0 [OPTIONS] [TEST]..."
> >+      echo "If no TEST argument is given, all tests will be run."
> >+      echo
> >+      echo "Options"
> >+      echo "  -v: verbose output"
> >+      echo "  -s: skip build"
> >+      echo
> >+      echo "Available tests${avail_tests}"
> >+      exit 1
> >+}
> >+
> >+die() {
> >+      echo "$*" >&2
> >+      exit 1
> >+}
> >+
> >+vm_ssh() {
> >+      ssh -q -o UserKnownHostsFile=3D/dev/null -p 2222 localhost $*
>
> ${SSH_HOST_PORT} instead of 2222, right?
>

Oops. Yep, will fix.

> The rest LGTM!
>
> Thanks,
> Stefano
>

Thanks for the review!

Best,
Bobby

