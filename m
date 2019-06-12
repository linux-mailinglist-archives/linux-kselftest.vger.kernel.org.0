Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 705DB4206F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407487AbfFLJNl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 05:13:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32887 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407485AbfFLJNk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 05:13:40 -0400
Received: by mail-io1-f67.google.com with SMTP id u13so12370501iop.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4n+u746Zriu4Z5rwi7YzJ698jZV7r37p5nZkel+OThk=;
        b=fQjux/6WrRfMK82CLPimUz0pAkcUaPk9dLWyAI54UNobXLeIH1tle8kRm8tZsZQ5KW
         DPWQRVb5G+rLjfHc+HPWa4vmUdvzr3K4OF8d0FgNTto7/RjLD1muZa+yAOrTzIkPVM8O
         lj1vlzJhZQB/WXF4K9OkYBxcHDUrJVK3RvryRkOlW/uRGTGPfK+fjVXZXx5VI8mkZmGq
         f2YJDKB9z4QppSjabEsu5xvAR0tnU2SDPJjh/1w92aUwxtM1KmS1YNwYwKIvK52lVOXs
         MntQdyWSzwMFM2SkykLfMw7srlhAX24zDLS6komNsn3aoLRrobBxoWXI5ec2lNCD7PBx
         WeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4n+u746Zriu4Z5rwi7YzJ698jZV7r37p5nZkel+OThk=;
        b=Ief0UQQrT9HvoLO7yiedlEdK5uSHj5qHaaBiEYXJarkp2/ztvYXozATHtDbWB8P1FY
         Q/eGuBVTiS1iYz1GUyvd/j9YuOcpJRhA4fTHVLmz/fW1QF2X92cTbd47pAD2WSu4m2wu
         TWt3TXuWMIQXWDKkpFT2YAvhYBR6DBKKibjKP5IF9ZSFWv6z6iWJ7ge2csH6eGzmRN+0
         mDWVHhbGZZGjMKDBHd+hMBXxtMyyQjNWsQYfKmKbeDcBlYUCWFfZbiKhb4pA8JF2x8iW
         iicnYEXV+jvuzu1sNPbcdXeXfZIXC0EShy/THfOSwEmaNOixfkWMw+NSLgDuYqDbJVnq
         CAgg==
X-Gm-Message-State: APjAAAXtgTAht+LUZ8wjDmf4jZNqwW/PPk7dnNfyKmJmn4bo0m6iqPZq
        e5KmOKM1JZu9iRleTOJIBVvWgYOtIZy5FQkDN2KvLA==
X-Google-Smtp-Source: APXvYqyayHPX1MEaG9rx9PJfCcljyQSDnSHbyBdtpLYS/qKOBmDvAqpSAqkBzEI/IpcUsFfkyWC9RsQiMsN0O4qnP/w=
X-Received: by 2002:a6b:641a:: with SMTP id t26mr6906378iog.3.1560330819318;
 Wed, 12 Jun 2019 02:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Z4naaxx4N2B2t1hn4A99dfk=6yTY2yAZM=aJ05VCPLFQ@mail.gmail.com>
 <54bc80f8-71aa-1c04-5908-01923247832e@kernel.org> <CACT4Y+YUBw=t3CkbLeKLFAeAbzVZXoG09HARR+nsOTW4gkdLOw@mail.gmail.com>
 <6d5e0484-4dbc-d122-1ae4-9cce44c2d668@kernel.org> <CACT4Y+aE841JzvEVFmAevgmBO0eOssz0MFydWiuoAp18nr=_DA@mail.gmail.com>
 <CACT4Y+abfa9xVg+3S_tgpOA3cZ2bexe51d0FEZyBCGn0M-6DiA@mail.gmail.com>
In-Reply-To: <CACT4Y+abfa9xVg+3S_tgpOA3cZ2bexe51d0FEZyBCGn0M-6DiA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Jun 2019 11:13:28 +0200
Message-ID: <CACT4Y+aiDUV4_JrvKct98mKvPwEQXSZFXae3qweSmotpzCAGTw@mail.gmail.com>
Subject: Re: kselftest build broken?
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 12, 2019 at 11:09 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Tue, Jun 11, 2019 at 9:20 PM shuah <shuah@kernel.org> wrote:
> > >
> > > On 6/11/19 10:03 AM, Dmitry Vyukov wrote:
> > > > On Tue, Jun 11, 2019 at 5:16 PM shuah <shuah@kernel.org> wrote:
> > > >>
> > > >> Hi Dmitry,
> > > >>
> > > >> On 6/11/19 4:30 AM, Dmitry Vyukov wrote:
> > > >>> Hi,
> > > >>>
> > > >>> I've tried to build kselftests for several years now, but I alway=
s
> > > >>> find the build broken. Which makes me wonder if the instructions =
are
> > > >>> broken or something. I follow the instructions in
> > > >>> Documentation/dev-tools/kselftest.rst and start with "make -C
> > > >>> tools/testing/selftests". Here is the errors I get on the upstrea=
m
> > > >>> commit 16d72dd4891fecc1e1bf7ca193bb7d5b9804c038:
> > > >>>> error: unable to create target: 'No available targets are compat=
ible
> > > >>> with triple "bpf"'
> > > >>> 1 error generated.
> > > >>> Makefile:259: recipe for target 'elfdep' failed
> > > >>> Makefile:156: recipe for target 'all' failed
> > > >>> Makefile:106: recipe for target
> > > >>> '/linux/tools/testing/selftests/bpf/libbpf.a' failed
> > > >>> test_execve.c:4:10: fatal error: cap-ng.h: No such file or direct=
ory
> > > >>
> > > >> These errors are due to missing dependencies. You will need
> > > >>
> > > >> libmount-dev
> > > >> libcap-ng-dev
> > > >> libelf-dev
> > > >>
> > > >> for bpf to build and also clang
> > > >>
> > > >>> ../lib.mk:138: recipe for target
> > > >>> '/linux/tools/testing/selftests/capabilities/test_execve' failed
> > > >>> gpio-mockup-chardev.c:20:10: fatal error: libmount.h: No such fil=
e or directory > <builtin>: recipe for target 'gpio-mockup-chardev' failed
> > > >>> fuse_mnt.c:17:10: fatal error: fuse.h: No such file or directory
> > > >>
> > > >> libfuse-dev is missing.
> > > >>
> > > >>> ../lib.mk:138: recipe for target
> > > >>> '/linux/tools/testing/selftests/memfd/fuse_mnt' failed
> > > >>> collect2: error: ld returned 1 exit status
> > > >>> ../lib.mk:138: recipe for target
> > > >>> '/linux/tools/testing/selftests/mqueue/mq_open_tests' failed
> > > >>
> > > >> Needs libpopt-dev
> > > >>
> > > >>> reuseport_bpf_numa.c:24:10: fatal error: numa.h: No such file or =
directory
> > > >>
> > > >> Needs libnuma-dev
> > > >>
> > > >>> ../lib.mk:138: recipe for target
> > > >>> '/linux/tools/testing/selftests/net/reuseport_bpf_numa' failed
> > > >>> mlock-random-test.c:8:10: fatal error: sys/capability.h: No such =
file
> > > >>> or directory > ../lib.mk:138: recipe for target
> > > >>> '/linux/tools/testing/selftests/vm/mlock-random-test' failed
> > > >>>
> > > >>> Here is full log:
> > > >>>
> > > >>> https://gist.githubusercontent.com/dvyukov/47430636e160f297b657df=
5ba2efa82b/raw/7babc4db228b88f341a376c15e8bc9c4c3b02160/gistfile1.txt
> > > >>>
> > > >>> I have libelf-dev installed. Do I need to install something else?=
 Or
> > > >>> run some other command?
> > > >>
> > > >> ii  libelf-dev:amd 0.170-0.4ubu amd64        libelf1 development
> > > >> libraries and
> > > >> ii  libelf1:amd64  0.170-0.4ubu amd64        library to read and w=
rite
> > > >> ELF fil
> > > >>
> > > >>
> > > >> All of the above built for me on Linux 5.2-rc4. Try installing all=
 of
> > > >> these and let me know if you still see problems.
> > > >
> > > >
> > > > Hi Shuah,
> > > >
> > > > Thanks for quick reply!
> > > >
> > > > I've installed these: libmount-dev libcap-ng-dev libfuse-dev
> > > > libpopt-dev libnuma-dev.
> > > > libelf-dev I already had. And for clang I switched to distro-provid=
ed one.
> > > >
> > > > This reduced number of errors, but I still see some:
> > > >
> > > > clang: error: unable to execute command: Broken pipe
> > > > clang: error: clang frontend command failed due to signal (use -v t=
o
> > > > see invocation)
> > > > Makefile:259: recipe for target 'elfdep' failed
> > > > Makefile:156: recipe for target 'all' failed
> > > > Makefile:106: recipe for target
> > > > '/linux/tools/testing/selftests/bpf/libbpf.a' failed
> > >
> > > Getting bpf compile to work take a few steps. If I remember correctly=
,
> > > You will need llvm as well. Here is what I have on my system:
> > >
> > > ii  libllvm6.0:amd 1:6.0-1ubunt amd64        Modular compiler and
> > > toolchain te
> > > ii  llvm           1:6.0-41~exp amd64        Low-Level Virtual Machin=
e
> > > (LLVM)
> > > ii  llvm-6.0       1:6.0-1ubunt amd64        Modular compiler and
> > > toolchain te
> > > ii  llvm-6.0-dev   1:6.0-1ubunt amd64        Modular compiler and
> > > toolchain te
> > > un  llvm-6.0-doc   <none>       <none>       (no description availabl=
e)
> > > ii  llvm-6.0-runti 1:6.0-1ubunt amd64        Modular compiler and
> > > toolchain te
> > > ii  llvm-runtime   1:6.0-41~exp amd64        Low-Level Virtual Machin=
e
> > > (LLVM),
> > >
> > > > timestamping.c:249:19: error: =E2=80=98SIOCGSTAMP=E2=80=99 undeclar=
ed (first use in
> > > > this function); did you mean =E2=80=98SIOCGSTAMPNS=E2=80=99?
> > > > ../../lib.mk:138: recipe for target
> > > > '/linux/tools/testing/selftests/networking/timestamping/timestampin=
g'
> > > > failed
> > > > mlock-random-test.c:8:10: fatal error: sys/capability.h: No such fi=
le
> > > > or directory
> > >
> > > Do you have libcap-dev installed?
> > >
> > > ii  libcap-dev:amd 1:2.25-1.2   amd64        POSIX 1003.1e capabiliti=
es
> > > (devel
> > > ii  libcap-ng-dev  0.7.7-3.1    amd64        Development and header
> > > files for
> > > ii  libcap-ng0:amd 0.7.7-3.1    amd64        An alternate POSIX
> > > capabilities l
> > > ii  libcap2:amd64  1:2.25-1.2   amd64        POSIX 1003.1e capabiliti=
es
> > > (libra
> > > ii  libcap2-bin    1:2.25-1.2   amd64        POSIX 1003.1e capabiliti=
es
> > > (utili
> > > un  libcap2-dev    <none>       <none>       (no description availabl=
e)
> >
> > I've installed libcap-dev and resolved the missing header.
> >
> > I've also installed llvm llvm-6.0  llvm-6.0-dev  llvm-6.0-doc
> > libllvm6.0  llvm-6.0-runtime llvm-runtime and it fixed crashing
> > compiler.
> > But bpf tests build was still failing due to missing libelf. But I had
> > the library, so I went and removed some random files:
> > tools/testing/selftests/bpf/{feature,FEATURE-DUMP.libbpf}. Don't ask
> > me why these.
> >
> > I am now down to just 1 build error:
> >
> >   CC       /usr/local/google/home/dvyukov/src/linux/tools/testing/selft=
ests/bpf/str_error.o
> > timestamping.c:249:19: error: =E2=80=98SIOCGSTAMP=E2=80=99 undeclared (=
first use in
> > this function); did you mean =E2=80=98SIOCGSTAMPNS=E2=80=99?
>
>
> Is this a non-fatal error? Usually when make produces errors, one
> expects that nothing is done and it was aborted mid-way. But make
> seems to produce some test binaries by now.
>
>
> Reading the doc further, these command seem to implicitly assume that
> the tests will run right on my host machine:
>
>   $ make -C tools/testing/selftests run_tests
>   $ make kselftest
>
> Is it right? At least I don't see how it's configured to run them
> somewhere else? Or it uses something like qemu by default to run the
> kernel under test?
> If it runs the tests on the host, it can't work for me. I don't have
> the test kernel installed and there is no way I can do this. Policy
> rules aside, this is yet untested kernel, so by installing it I am
> risking losing my whole machine and all data...
>
> What am I missing?

Reading further. "Install selftests" and "Running installed selftests"
sections. Is it something I can use to copy the pre-built tests to the
test machine? The sections don't spell it, so I am just trying to
second guess. Or what's the purpose of installing?

The "Running installed selftests" section says:
"Kselftest install as well as the Kselftest tarball provide a script
named "run_kselftest.sh" to run the tests".

What is the "Kselftest tarball"? Where does one get one? I don't see
any mentions of "tarball" anywhere else in the doc.
