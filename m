Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53A5141FB0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 10:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfFLIvf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 04:51:35 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35069 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbfFLIvf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 04:51:35 -0400
Received: by mail-it1-f196.google.com with SMTP id n189so9349384itd.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 01:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q/n/Yf4eHnOcF+AANg5IuzztHXFxTEuJ2izp2rxSYM4=;
        b=N4AFdglqMBxmdAh7ZEP2Cvrvbd8MQGibEjUG4gYrXBoWqu2pdpF5v1hvsYyqBZjr9h
         CHXKPnOrc38Onc9JjwTqtlWPdcRoZTIEquo1suHV4zT/PzBK20szltqCDhFiIceS4dXZ
         8+Wqim4fgJivOXB3Z+5uHF19p/Am407SM01BrJZTWUSf/uK1P2eJAOxl8/lQgFSn9kV+
         xcFwg3zwpe0TF8pjC7zWaTWWepBk7IOIhWPl+79yHfRKXDJWU35i5mCUNxRqOnYfOP5g
         Y/+VHQkzqgEf3P1Ad0oBTqu4TyAhuu9loGRmCh5D4nosbz6gMeAjTqVlooznKpnCCEAh
         wwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q/n/Yf4eHnOcF+AANg5IuzztHXFxTEuJ2izp2rxSYM4=;
        b=k4tdFchgzhb4xKcSAIEAfZK0loJMSINlO6UPPT7k8fxDslNAdTjIUIRnzTHxh1pR9g
         kH5OOjh/mdCbJ42/1oCI1ZOrJnsfNJMHUS7vdjdMyOJ19xq7SHdK+UeoMNvL264vGh/h
         kMniR3Z2ljHCEHfTQBMAIFo3hO1UH37kRfKlQOBPc3cbjIwdR6giIfiVmes50yMf+4kr
         z3dyJwbvDeMS3+SelN2m7FO+ocLr1KH3551XmhPEmWTxmJLihRBgSC9Vv1QCMjYBKu3/
         JAsVzhiRCiVWT1k8Vx1zt+QUosyMHemIZPFB/Ptx+h44S/gm/BQJ/WKBUPbsYfuY6kdz
         fDLw==
X-Gm-Message-State: APjAAAVrit+sbN5xTactBsX7Wm+g79AfOOSKAlo8JRECmdwzr3bp7wTW
        BO6t8l47CivwVHPzlTc2DYpkK2pBQ/xFn3JhHy14uzNRbPoF7A==
X-Google-Smtp-Source: APXvYqyS/gC7y7d9lCKFPRS82UZssS7h6hVN4eKJx/KromuWbbesGYF3G/zdaXnsiCFMHO0tFy82ScNcAqWP2DMbu38=
X-Received: by 2002:a02:1384:: with SMTP id 126mr49356533jaz.72.1560329494061;
 Wed, 12 Jun 2019 01:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Z4naaxx4N2B2t1hn4A99dfk=6yTY2yAZM=aJ05VCPLFQ@mail.gmail.com>
 <54bc80f8-71aa-1c04-5908-01923247832e@kernel.org> <CACT4Y+YUBw=t3CkbLeKLFAeAbzVZXoG09HARR+nsOTW4gkdLOw@mail.gmail.com>
 <6d5e0484-4dbc-d122-1ae4-9cce44c2d668@kernel.org>
In-Reply-To: <6d5e0484-4dbc-d122-1ae4-9cce44c2d668@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Jun 2019 10:51:23 +0200
Message-ID: <CACT4Y+aE841JzvEVFmAevgmBO0eOssz0MFydWiuoAp18nr=_DA@mail.gmail.com>
Subject: Re: kselftest build broken?
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 11, 2019 at 9:20 PM shuah <shuah@kernel.org> wrote:
>
> On 6/11/19 10:03 AM, Dmitry Vyukov wrote:
> > On Tue, Jun 11, 2019 at 5:16 PM shuah <shuah@kernel.org> wrote:
> >>
> >> Hi Dmitry,
> >>
> >> On 6/11/19 4:30 AM, Dmitry Vyukov wrote:
> >>> Hi,
> >>>
> >>> I've tried to build kselftests for several years now, but I always
> >>> find the build broken. Which makes me wonder if the instructions are
> >>> broken or something. I follow the instructions in
> >>> Documentation/dev-tools/kselftest.rst and start with "make -C
> >>> tools/testing/selftests". Here is the errors I get on the upstream
> >>> commit 16d72dd4891fecc1e1bf7ca193bb7d5b9804c038:
> >>>> error: unable to create target: 'No available targets are compatible
> >>> with triple "bpf"'
> >>> 1 error generated.
> >>> Makefile:259: recipe for target 'elfdep' failed
> >>> Makefile:156: recipe for target 'all' failed
> >>> Makefile:106: recipe for target
> >>> '/linux/tools/testing/selftests/bpf/libbpf.a' failed
> >>> test_execve.c:4:10: fatal error: cap-ng.h: No such file or directory
> >>
> >> These errors are due to missing dependencies. You will need
> >>
> >> libmount-dev
> >> libcap-ng-dev
> >> libelf-dev
> >>
> >> for bpf to build and also clang
> >>
> >>> ../lib.mk:138: recipe for target
> >>> '/linux/tools/testing/selftests/capabilities/test_execve' failed
> >>> gpio-mockup-chardev.c:20:10: fatal error: libmount.h: No such file or=
 directory > <builtin>: recipe for target 'gpio-mockup-chardev' failed
> >>> fuse_mnt.c:17:10: fatal error: fuse.h: No such file or directory
> >>
> >> libfuse-dev is missing.
> >>
> >>> ../lib.mk:138: recipe for target
> >>> '/linux/tools/testing/selftests/memfd/fuse_mnt' failed
> >>> collect2: error: ld returned 1 exit status
> >>> ../lib.mk:138: recipe for target
> >>> '/linux/tools/testing/selftests/mqueue/mq_open_tests' failed
> >>
> >> Needs libpopt-dev
> >>
> >>> reuseport_bpf_numa.c:24:10: fatal error: numa.h: No such file or dire=
ctory
> >>
> >> Needs libnuma-dev
> >>
> >>> ../lib.mk:138: recipe for target
> >>> '/linux/tools/testing/selftests/net/reuseport_bpf_numa' failed
> >>> mlock-random-test.c:8:10: fatal error: sys/capability.h: No such file
> >>> or directory > ../lib.mk:138: recipe for target
> >>> '/linux/tools/testing/selftests/vm/mlock-random-test' failed
> >>>
> >>> Here is full log:
> >>>
> >>> https://gist.githubusercontent.com/dvyukov/47430636e160f297b657df5ba2=
efa82b/raw/7babc4db228b88f341a376c15e8bc9c4c3b02160/gistfile1.txt
> >>>
> >>> I have libelf-dev installed. Do I need to install something else? Or
> >>> run some other command?
> >>
> >> ii  libelf-dev:amd 0.170-0.4ubu amd64        libelf1 development
> >> libraries and
> >> ii  libelf1:amd64  0.170-0.4ubu amd64        library to read and write
> >> ELF fil
> >>
> >>
> >> All of the above built for me on Linux 5.2-rc4. Try installing all of
> >> these and let me know if you still see problems.
> >
> >
> > Hi Shuah,
> >
> > Thanks for quick reply!
> >
> > I've installed these: libmount-dev libcap-ng-dev libfuse-dev
> > libpopt-dev libnuma-dev.
> > libelf-dev I already had. And for clang I switched to distro-provided o=
ne.
> >
> > This reduced number of errors, but I still see some:
> >
> > clang: error: unable to execute command: Broken pipe
> > clang: error: clang frontend command failed due to signal (use -v to
> > see invocation)
> > Makefile:259: recipe for target 'elfdep' failed
> > Makefile:156: recipe for target 'all' failed
> > Makefile:106: recipe for target
> > '/linux/tools/testing/selftests/bpf/libbpf.a' failed
>
> Getting bpf compile to work take a few steps. If I remember correctly,
> You will need llvm as well. Here is what I have on my system:
>
> ii  libllvm6.0:amd 1:6.0-1ubunt amd64        Modular compiler and
> toolchain te
> ii  llvm           1:6.0-41~exp amd64        Low-Level Virtual Machine
> (LLVM)
> ii  llvm-6.0       1:6.0-1ubunt amd64        Modular compiler and
> toolchain te
> ii  llvm-6.0-dev   1:6.0-1ubunt amd64        Modular compiler and
> toolchain te
> un  llvm-6.0-doc   <none>       <none>       (no description available)
> ii  llvm-6.0-runti 1:6.0-1ubunt amd64        Modular compiler and
> toolchain te
> ii  llvm-runtime   1:6.0-41~exp amd64        Low-Level Virtual Machine
> (LLVM),
>
> > timestamping.c:249:19: error: =E2=80=98SIOCGSTAMP=E2=80=99 undeclared (=
first use in
> > this function); did you mean =E2=80=98SIOCGSTAMPNS=E2=80=99?
> > ../../lib.mk:138: recipe for target
> > '/linux/tools/testing/selftests/networking/timestamping/timestamping'
> > failed
> > mlock-random-test.c:8:10: fatal error: sys/capability.h: No such file
> > or directory
>
> Do you have libcap-dev installed?
>
> ii  libcap-dev:amd 1:2.25-1.2   amd64        POSIX 1003.1e capabilities
> (devel
> ii  libcap-ng-dev  0.7.7-3.1    amd64        Development and header
> files for
> ii  libcap-ng0:amd 0.7.7-3.1    amd64        An alternate POSIX
> capabilities l
> ii  libcap2:amd64  1:2.25-1.2   amd64        POSIX 1003.1e capabilities
> (libra
> ii  libcap2-bin    1:2.25-1.2   amd64        POSIX 1003.1e capabilities
> (utili
> un  libcap2-dev    <none>       <none>       (no description available)



I've installed libcap-dev and resolved the missing header.

I've also installed llvm llvm-6.0  llvm-6.0-dev  llvm-6.0-doc
libllvm6.0  llvm-6.0-runtime llvm-runtime and it fixed crashing
compiler.
But bpf tests build was still failing due to missing libelf. But I had
the library, so I went and removed some random files:
tools/testing/selftests/bpf/{feature,FEATURE-DUMP.libbpf}. Don't ask
me why these.

I am now down to just 1 build error:

  CC       /usr/local/google/home/dvyukov/src/linux/tools/testing/selftests=
/bpf/str_error.o
timestamping.c:249:19: error: =E2=80=98SIOCGSTAMP=E2=80=99 undeclared (firs=
t use in
this function); did you mean =E2=80=98SIOCGSTAMPNS=E2=80=99?
