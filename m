Return-Path: <linux-kselftest+bounces-32059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A34AA59C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 04:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4940F4666F5
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 02:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C026322FAF8;
	Thu,  1 May 2025 02:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSizcCYc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690FB4C79;
	Thu,  1 May 2025 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746067250; cv=none; b=dLccIJA5Qrao52h+lUX7jNNa57857qzT9XsmDbVrkRpDnDp5LiJHau3wGXbxCByqD2FZp5rF+emZ4e0d7MRxFG+CYXo2Y0Q5cPIB7xkN8lAlfmLk6xpipJYBWACKFG0rRj8aDvlVDJQNj/B9mWSdcw6yY8s95VRW3oyb55c+mSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746067250; c=relaxed/simple;
	bh=0f2ABZR1ZiXiDdikDT0p8GMJannb3f+0TquTPXn5088=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOhhtDgv1sOo/+pI6O7/VT4wlOO93c0hIEGHqIjI7K0VyGj7VvrgeMIj3KyipLQtWKwGa6DZDbxK18OXUAEIBlE/lIfeoTIe9cb7n4PAYVAyf+qx81POiFz7tGdR2FkxCJ8aujH25aB1p0JPwNqz1oNKXDrbv2j4B3FiHNOtpxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSizcCYc; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3105ef2a071so5005011fa.1;
        Wed, 30 Apr 2025 19:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746067245; x=1746672045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBGKE2uFS/ZiWpz8mgMaFhX+HMiILDZu9TSBZamaLho=;
        b=cSizcCYcQWMYoUbx9cPwqF/LUmlc2eYyRyn8ODNcdgBxbwz4+blIBP6bdkFw7kHuJ3
         MgWafCr2fCYPcqw8crvgL3rE5II5ehx0EyN9vFQYTgccm6cMDPzFZK95hzuhg4Q78qJn
         0Lxb/de2a0KOBnjin5dErg7r0r96HxaOPrzUHF+cAk8Z4Jr4u3JCkQajzqD0qRX/Qkfw
         eIAt/UU2CoX30VKk23VBWUOVYuhDUmHqjc+C8J3DNwYRnwzKhV6NMMti0A6pgxpITutO
         /OJcHCpcbWJTPOb4xg18MvzEgwfj9a22MBLtcf02KN6eEn/i1LUKd4mvUGJ2Fla5syy9
         7bTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746067245; x=1746672045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBGKE2uFS/ZiWpz8mgMaFhX+HMiILDZu9TSBZamaLho=;
        b=kQrvEWVsxTct7CJdkssuLf5HkWOt68RiGwrxW39DtEkKyP9r/mxDyEfS425n1Pzd2w
         oKdv+K5W+Kh0hVu6ovJUuuQ7Yh+6Wpl5RjMz+U1juwp1pW0tw+Y5CtybuJ2sidAf/Y+O
         eH0oFKnfG4ltW52NfRPBjvFpf2W5G7ayEM1Q2o/BFurrfMpalwSPaCI/DRXPIErrDByD
         olxjRg2latpatVC2lBoay0nDHw+PdlUqM7Sd5YlZRImj3EadvDeb/SPraYxge5xoqJH/
         dOH3GdXgwF/qpeAnAXeaiiPf6U/RuQ3TWurSTro5g6Gpzc85IEZ+JMA62ljOESXpZ8A5
         yk5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFMlm3K+0n3i8SR5DmdmZWfZsFL6SO1q4JH6kYwUOA4joFK9S9QxzOsjwDa+fF+4mNuci/ZDFRn4khavhReDyy@vger.kernel.org, AJvYcCVth2j9niSLRKbxUh1vLvnvsbhMRz5nHp7tyJm5lgT6g7/HKIUGi+M57Or0oaITQGt1cTe2T6Xt@vger.kernel.org, AJvYcCWgQcNWxe/xXWX61FfokhkzxB+I4htCPizSLz8pmwSoBnIElJrS1oSBqSr1DKvItpOuqFM=@vger.kernel.org, AJvYcCXzt9oFcfIiJTrL6/JM5puJY8+MaByogQ+IAngX9svggXTsauBcCqpd899f3sJ8ZFFB6VEWuWyM0pHUQ6m2@vger.kernel.org
X-Gm-Message-State: AOJu0YzIsXwxEGw70WMz0Co4rgaF+mvcYaOWHoqVDhpXDRMISrs4O37m
	IL1aeTb2e/CxjEG++eoSEcYWFFMNdG0N3sZ/h8rRoZB4bdGw2+rPsqNP5ujz61/ByO4AkmEDrEm
	LwpqefjbemMqc63DjzVYzIPWQ75I+B+H2
X-Gm-Gg: ASbGncvomHlhwWFiLC9HMadbjL4iD+1Sxfrp0Xc9vqZ6Q09OgKjGk73zQ71IVHN4Mbd
	dJoQ9Y9Nnt5sav+ptkfrHWOOOUQoYpYG4h5AHChXvOucyvhWLPrdHf2a0D3jW6SCsQg02KoUcKm
	2oflN1VjjQBSxxCwU6fb4=
X-Google-Smtp-Source: AGHT+IEVbbTN0avOWVyYxl9UVbzCTJvmIiERY33N0cQ8M5QgWxZh6WHtvIk02SvDckSF9vSHyk1qHTXRTkfH0LdxDhI=
X-Received: by 2002:a05:651c:550:b0:308:f4cc:9519 with SMTP id
 38308e7fff4ca-31ea28d41bcmr13590891fa.5.1746067245147; Wed, 30 Apr 2025
 19:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428-vsock-vmtest-v3-1-181af6163f3e@gmail.com>
 <a57wg5kmprrpk2dm3zlzvegb3gzj73ubs5lxeukyinc4edlcsw@itkgfcm44qu2> <CAKB00G2pEJAFzFBMbCGW4gBNB4UqBpEw22a2Cs4oOdSXUWfsuQ@mail.gmail.com>
In-Reply-To: <CAKB00G2pEJAFzFBMbCGW4gBNB4UqBpEw22a2Cs4oOdSXUWfsuQ@mail.gmail.com>
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 30 Apr 2025 19:40:32 -0700
X-Gm-Features: ATxdqUHOu-_kIRtq_tRSqr1wY81n2W-0jSZ6iQgbZNXSH_64K-nKPo6p1Hg2rTU
Message-ID: <CAKB00G0wVi+w8aSrimUWO7jo-GYW02X-dB9fXkfDgTbRqknedg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] selftests/vsock: add initial vmtest.sh for vsock
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

PS. sorry for weird formatting, writing from the gmail web UI instead of mu=
tt.
Tried to limit line lengths manually. Looks weird after hitting "send"... l=
ol.

Best,
Bobby

On Wed, Apr 30, 2025 at 7:37=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> On Wed, Apr 30, 2025 at 6:06=E2=80=AFAM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >
> > On Mon, Apr 28, 2025 at 04:48:11PM -0700, Bobby Eshleman wrote:
> > >This commit introduces a new vmtest.sh runner for vsock.
> > >
> > >It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
> > >H2G, and loopback. The testing tools from tools/testing/vsock/ are
> > >reused. Currently, only vsock_test is used.
> > >
> > >VMCI and hyperv support is automatically built, though not used.
> > >
> > >Only tested on x86.
> > >
> > >To run:
> > >
> > >  $ tools/testing/selftests/vsock/vmtest.sh
> >
> > I tried and it's working, but I have a lot of these messages in the
> > output:
> >      dmesg: read kernel buffer failed: Operation not permitted
> >
> > I'm on Fedora 41:
> >
> > $ uname -r
> > 6.14.4-200.fc41.x86_64
> >
> > >
> > >or
> > >
> > >  $ make -C tools/testing/selftests TARGETS=3Dvsock run_tests
> > >
> > >Results:
> > >       # linux/tools/testing/selftests/vsock/vmtest.log
> > >       setup:  Building kernel and tests
> > >       setup:  Booting up VM
> > >       setup:  VM booted up
> > >       test:vm_server_host_client:guest:       Control socket listenin=
g on 0.0.0.0:51000
> > >       test:vm_server_host_client:guest:       Control socket connecti=
on accepted...
> > >       [...]
> > >       test:vm_loopback:guest: 30 - SOCK_STREAM retry failed connect()=
...ok
> > >       test:vm_loopback:guest: 31 - SOCK_STREAM SO_LINGER null-ptr-der=
ef...ok
> > >       test:vm_loopback:guest: 31 - SOCK_STREAM SO_LINGER null-ptr-der=
ef...ok
> > >
> > >Future work can include vsock_diag_test.
> > >
> > >vmtest.sh is loosely based off of tools/testing/selftests/net/pmtu.sh,
> > >which was picked out of the bag of tests I knew to work with NIPA.
> > >
> > >Because vsock requires a VM to test anything other than loopback, this
> > >patch adds vmtest.sh as a kselftest itself. This is different than oth=
er
> > >systems that have a "vmtest.sh", where it is used as a utility script =
to
> > >spin up a VM to run the selftests as a guest (but isn't hooked into
> > >kselftest). This aspect is worth review, as I'm not aware of all of th=
e
> > >enviroments where this would run.
> >
> > Yeah, an opinion from net maintainers on this would be great.
> >
> > >
> > >Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
> > >---
> > >Changes in v3:
> > >- use common conditional syntax for checking variables
> > >- use return value instead of global rc
> > >- fix typo TEST_HOST_LISTENER_PORT -> TEST_HOST_PORT_LISTENER
> > >- use SIGTERM instead of SIGKILL on cleanup
> > >- use peer-cid=3D1 for loopback
> > >- change sleep delay times into globals
> > >- fix test_vm_loopback logging
> > >- add test selection in arguments
> > >- make QEMU an argument
> > >- check that vng binary is on path
> > >- use QEMU variable
> > >- change <tab><backslash> to <space><backslash>
> > >- fix hardcoded file paths
> > >- add comment in commit msg about script that vmtest.sh was based off =
of
> > >- Add tools/testing/selftest/vsock/Makefile for kselftest
> > >- Link to v2: https://lore.kernel.org/r/20250417-vsock-vmtest-v2-1-390=
1a27331e8@gmail.com
> > >
> > >Changes in v2:
> > >- add kernel oops and warnings checker
> > >- change testname variable to use FUNCNAME
> > >- fix spacing in test_vm_server_host_client
> > >- add -s skip build option to vmtest.sh
> > >- add test_vm_loopback
> > >- pass port to vm_wait_for_listener
> > >- fix indentation in vmtest.sh
> > >- add vmci and hyperv to config
> > >- changed whitespace from tabs to spaces in help string
> > >- Link to v1: https://lore.kernel.org/r/20250410-vsock-vmtest-v1-1-f35=
a81dab98c@gmail.com
> > >---
> > > MAINTAINERS                                |   1 +
> > > tools/testing/selftests/vsock/.gitignore   |   1 +
> > > tools/testing/selftests/vsock/Makefile     |   9 +
> > > tools/testing/selftests/vsock/config.vsock |  10 +
> > > tools/testing/selftests/vsock/settings     |   1 +
> > > tools/testing/selftests/vsock/vmtest.sh    | 354 ++++++++++++++++++++=
+++++++++
> > > 6 files changed, 376 insertions(+)
> >
> > While applying git warned about trailing spaces, but also checkpatch is
> > warning about them, please can you fix at least the errors (and maybe
> > the misspelling):
> >
> > $ ./scripts/checkpatch.pl --strict -g master..HEAD --codespell
> > WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit
> > description?)
> > #31:
> >         test:vm_server_host_client:guest:       Control socket listenin=
g on 0.0.0.0:51000
> >
> > WARNING: 'enviroments' may be misspelled - perhaps 'environments'?
> > #48:
> > enviroments where this would run.
> > ^^^^^^^^^^^
> >
> > ERROR: trailing whitespace
> > #174: FILE: tools/testing/selftests/vsock/vmtest.sh:47:
> > +^Ivm_server_host_client^IRun vsock_test in server mode on the VM and i=
n client mode on the host.^I$
> >
> > WARNING: line length of 104 exceeds 100 columns
> > #174: FILE: tools/testing/selftests/vsock/vmtest.sh:47:
> > +       vm_server_host_client   Run vsock_test in server mode on the VM=
 and in client mode on the host.
> >
> > ERROR: trailing whitespace
> > #175: FILE: tools/testing/selftests/vsock/vmtest.sh:48:
> > +^Ivm_client_host_server^IRun vsock_test in client mode on the VM and i=
n server mode on the host.^I$
> >
> > WARNING: line length of 104 exceeds 100 columns
> > #175: FILE: tools/testing/selftests/vsock/vmtest.sh:48:
> > +       vm_client_host_server   Run vsock_test in client mode on the VM=
 and in server mode on the host.
> >
> > ERROR: trailing whitespace
> > #176: FILE: tools/testing/selftests/vsock/vmtest.sh:49:
> > +^Ivm_loopback^I^IRun vsock_test using the loopback transport in the VM=
.^I$
> >
> > ERROR: trailing whitespace
> > #443: FILE: tools/testing/selftests/vsock/vmtest.sh:316:
> > +IFS=3D"^I$
> >
> > total: 4 errors, 4 warnings, 0 checks, 382 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >        mechanically convert to the typical style using --fix or --fix-i=
nplace.
> >
> > NOTE: Whitespace errors detected.
> >        You may wish to use scripts/cleanpatch or scripts/cleanfile
> >
> > Commit ffa17d673263 ("selftests/vsock: add initial vmtest.sh for vsock"=
) has style problems, please review.
> >
> > NOTE: If any of the errors are false positives, please report
> >        them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
>
> This might not have been the right choice, but I adopted the technique
> from the pmtu selftest of
> using a tab at the end of the help text lines and then splitting with
> "IFS=3D\t\n". I guess the win is that
> running the script has the side effect of checking that the help text
> has been updated, and the tab
> is not visible?
>
> I think we could do something similar with bash arrays though and have
> no checkpatch complaints, and
> not having to do "git commit --no-verify" to bypass the checks.
>
> > >
> > >diff --git a/MAINTAINERS b/MAINTAINERS
> > >index 657a67f9031ef7798c19ac63e6383d4cb18a9e1f..3fbdd7bbfce7196a3cc7db=
70203317c6bd0e51fd 100644
> > >--- a/MAINTAINERS
> > >+++ b/MAINTAINERS
> > >@@ -25751,6 +25751,7 @@ F:     include/uapi/linux/vm_sockets.h
> > > F:    include/uapi/linux/vm_sockets_diag.h
> > > F:    include/uapi/linux/vsockmon.h
> > > F:    net/vmw_vsock/
> > >+F:    tools/testing/selftests/vsock/
> > > F:    tools/testing/vsock/
> > >
> > > VMALLOC
> > >diff --git a/tools/testing/selftests/vsock/.gitignore b/tools/testing/=
selftests/vsock/.gitignore
> > >new file mode 100644
> > >index 0000000000000000000000000000000000000000..1950aa8ac68c0831c12c1a=
aa429da45bbe41e60f
> > >--- /dev/null
> > >+++ b/tools/testing/selftests/vsock/.gitignore
> > >@@ -0,0 +1 @@
> > >+vsock_selftests.log
> > >diff --git a/tools/testing/selftests/vsock/Makefile b/tools/testing/se=
lftests/vsock/Makefile
> > >new file mode 100644
> > >index 0000000000000000000000000000000000000000..6fded8c4d593541a6f7462=
147bffcb719def378f
> > >--- /dev/null
> > >+++ b/tools/testing/selftests/vsock/Makefile
> > >@@ -0,0 +1,9 @@
> > >+# SPDX-License-Identifier: GPL-2.0
> > >+.PHONY: all
> > >+all:
> > >+
> > >+TEST_PROGS :=3D vmtest.sh
> > >+EXTRA_CLEAN :=3D vmtest.log
> > >+
> > >+include ../lib.mk
> > >+
> > >diff --git a/tools/testing/selftests/vsock/config.vsock b/tools/testin=
g/selftests/vsock/config.vsock
> > >new file mode 100644
> > >index 0000000000000000000000000000000000000000..9e0fb2270e6a2fc0beb5f0=
d9f0bc37158d0a9d23
> > >--- /dev/null
> > >+++ b/tools/testing/selftests/vsock/config.vsock
> > >@@ -0,0 +1,10 @@
> > >+CONFIG_VSOCKETS=3Dy
> > >+CONFIG_VSOCKETS_DIAG=3Dy
> > >+CONFIG_VSOCKETS_LOOPBACK=3Dy
> > >+CONFIG_VMWARE_VMCI_VSOCKETS=3Dy
> > >+CONFIG_VIRTIO_VSOCKETS=3Dy
> > >+CONFIG_VIRTIO_VSOCKETS_COMMON=3Dy
> > >+CONFIG_HYPERV_VSOCKETS=3Dy
> > >+CONFIG_VMWARE_VMCI=3Dy
> > >+CONFIG_VHOST_VSOCK=3Dy
> > >+CONFIG_HYPERV=3Dy
> > >diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/se=
lftests/vsock/settings
> > >new file mode 100644
> > >index 0000000000000000000000000000000000000000..e7b9417537fbc4626153b7=
2e8f295ab4594c844b
> > >--- /dev/null
> > >+++ b/tools/testing/selftests/vsock/settings
> > >@@ -0,0 +1 @@
> > >+timeout=3D0
> > >diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/s=
elftests/vsock/vmtest.sh
> > >new file mode 100755
> > >index 0000000000000000000000000000000000000000..d70b9446e531d6d20beb24=
ddeda2cf0a9f7e9a39
> > >--- /dev/null
> > >+++ b/tools/testing/selftests/vsock/vmtest.sh
> > >@@ -0,0 +1,354 @@
> > >+#!/bin/bash
> > >+# SPDX-License-Identifier: GPL-2.0
> > >+#
> > >+# Copyright (c) 2025 Meta Platforms, Inc. and affiliates
> > >+#
> > >+# Dependencies:
> > >+#             * virtme-ng
> > >+#             * busybox-static (used by virtme-ng)
> > >+#             * qemu  (used by virtme-ng)
> > >+
> > >+SCRIPT_DIR=3D"$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -=
P)"
> > >+KERNEL_CHECKOUT=3D$(realpath ${SCRIPT_DIR}/../../../..)
> > >+QEMU=3D$(command -v qemu-system-$(uname -m))
> > >+VERBOSE=3D0
> > >+SKIP_BUILD=3D0
> > >+VSOCK_TEST=3D${KERNEL_CHECKOUT}/tools/testing/vsock/vsock_test
> > >+
> > >+TEST_GUEST_PORT=3D51000
> > >+TEST_HOST_PORT=3D50000
> > >+TEST_HOST_PORT_LISTENER=3D50001
> > >+SSH_GUEST_PORT=3D22
> > >+SSH_HOST_PORT=3D2222
> > >+VSOCK_CID=3D1234
> > >+WAIT_PERIOD=3D3
> > >+WAIT_PERIOD_MAX=3D20
> > >+
> > >+QEMU_PIDFILE=3D/tmp/qemu.pid
> > >+
> > >+# virtme-ng offers a netdev for ssh when using "--ssh", but we also n=
eed a
> > >+# control port forwarded for vsock_test.  Because virtme-ng doesn't s=
upport
> > >+# adding an additional port to forward to the device created from "--=
ssh" and
> > >+# virtme-init mistakenly sets identical IPs to the ssh device and add=
itional
> > >+# devices, we instead opt out of using --ssh, add the device manually=
, and also
> > >+# add the kernel cmdline options that virtme-init uses to setup the i=
nterface.
> > >+QEMU_OPTS=3D""
> > >+QEMU_OPTS=3D"${QEMU_OPTS} -netdev user,id=3Dn0,hostfwd=3Dtcp::${TEST_=
HOST_PORT}-:${TEST_GUEST_PORT}"
> > >+QEMU_OPTS=3D"${QEMU_OPTS},hostfwd=3Dtcp::${SSH_HOST_PORT}-:${SSH_GUES=
T_PORT}"
> > >+QEMU_OPTS=3D"${QEMU_OPTS} -device virtio-net-pci,netdev=3Dn0"
> > >+QEMU_OPTS=3D"${QEMU_OPTS} -device vhost-vsock-pci,guest-cid=3D${VSOCK=
_CID}"
> > >+QEMU_OPTS=3D"${QEMU_OPTS} --pidfile ${QEMU_PIDFILE}"
> >
> > What about:
> >
> > QEMU_OPTS=3D" \
> >      -netdev user,id=3Dn0,hostfwd=3Dtcp::${TEST_HOST_PORT}-:${TEST_GUES=
T_PORT},hostfwd=3Dtcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT} \
> >      -device virtio-net-pci,netdev=3Dn0 \
> >      -device vhost-vsock-pci,guest-cid=3D${VSOCK_CID} \
> >      --pidfile ${QEMU_PIDFILE}
> > "
> >
> > Not a strong opinion, just I see too much "QEMU_OPTS=3D"${QEMU_OPTS}" x=
D
> > You can leave it in that way if you prefer.
> >
>
> That's totally fine by me, no strong opinion on my side. I tend to do
> the string-building thing
> across the board because for some reason multiline strings look odd to
> me when inside
> function scope, and string-building looks like the same pattern
> everywhere. Definitely not
> a preference I hold tightly though.
>
> > >+KERNEL_CMDLINE=3D"virtme.dhcp net.ifnames=3D0 biosdevname=3D0 virtme.=
ssh virtme_ssh_user=3D$USER"
> > >+
> > >+LOG=3D${SCRIPT_DIR}/vmtest.log
> > >+
> > >+#             Name                            Description
> > >+avail_tests=3D"
> > >+      vm_server_host_client   Run vsock_test in server mode on the VM=
 and in client mode on the host.
> > >+      vm_client_host_server   Run vsock_test in client mode on the VM=
 and in server mode on the host.
> > >+      vm_loopback             Run vsock_test using the loopback trans=
port in the VM.
> > >+"
> > >+
> > >+usage() {
> > >+      echo
> > >+      echo "$0 [OPTIONS] [TEST]..."
> > >+      echo "If no TEST argument is given, all tests will be run."
> > >+      echo
> > >+      echo "Options"
> > >+      echo "  -v: verbose output"
> > >+      echo "  -s: skip build"
> > >+      echo
> > >+      echo "Available tests${avail_tests}"
> > >+      exit 1
> > >+}
> > >+
> > >+die() {
> > >+      echo "$*" >&2
> > >+      exit 1
> > >+}
> > >+
> > >+vm_ssh() {
> > >+      ssh -q -o UserKnownHostsFile=3D/dev/null -p 2222 localhost $*
> >
> > ${SSH_HOST_PORT} instead of 2222, right?
> >
>
> Oops. Yep, will fix.
>
> > The rest LGTM!
> >
> > Thanks,
> > Stefano
> >
>
> Thanks for the review!
>
> Best,
> Bobby

