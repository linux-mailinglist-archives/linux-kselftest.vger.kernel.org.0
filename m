Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F12E34208A
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 11:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbfFLJTj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 05:19:39 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40420 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfFLJTj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 05:19:39 -0400
Received: by mail-it1-f195.google.com with SMTP id q14so9426190itc.5
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 02:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/4U8DKSdzFPpaUI0qe7jLo9ogJlcDo1kMH4hi+9z9K4=;
        b=iw53C1C2G5x4tIVgK94ZNeyx/ZG2KZWI6TKAFeVCqr3vPWYh2vXuAuVk23tx6JHPWr
         XD6L7qFHiGD/jF3rr7Doh43/5olur5VG2NBzHtAglPq/dH5RJKMspmdpzJ2PGilBE4ng
         DfMNXDzvlsi1asNBYV8qoAnilaeE5mayYaKPuDG62oD/GYkXvOwM6+RVRl1pBeV6SkLm
         yxKm5Rd58IOOMhU0sOTghLnPGW8IcqF1iRuvsimgzxeBW+6JQWyO1FdjaY+q86OGAbqW
         krbtxMXNPW01dDj06x0By8JENYhHBYkGj8h0fMD9+OczQC6zLMuduvQ0v33HqT3YaN6L
         NISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/4U8DKSdzFPpaUI0qe7jLo9ogJlcDo1kMH4hi+9z9K4=;
        b=DypoPVSlZU9ZIlxFMqdbU8h2LqCBpJI5gaEGgnjBPsnr126XwAgRwrppLByK8m0oQV
         Y3Zu31hqXymI9SaZpXILeN9PAu1CT4TZHahYJZzMZP4vlhO1MkDHW/8764yG6PWMz+DB
         0HQKd0S+JWszTyjqfk74S8Loy39HngF6haaKPfvghBgMXErkP4Eo15PMEdZMreHOStrr
         cZR3pR5k1X0atLV+yEWOxRj3GaKpBb/dYNMpMrkhX0fbJYycaEX+d1Cd92xB1tILWB5C
         GQoTsiASG1i1b1yeCzbSh7H8YUwqGgQeg8id4+srQKXMcI6Dz1YlpXeTxGDj+lGmVe/x
         a62w==
X-Gm-Message-State: APjAAAX5aHjb5hATWbf/BWYqhxuw6GMVU8ep2wddC7VqQG6pqOskynDH
        1/klRc238XL3C7w43WGf7tennmH9MSaWYxgYsS7/iA==
X-Google-Smtp-Source: APXvYqxtVouY93dRaJaZONJmxDKQxcKOME07NbwQ0bYhmDGKTKv688jEWxwyAf45B5a3nIc81K2nYWwu5YJbAsJidFk=
X-Received: by 2002:a02:22c6:: with SMTP id o189mr40306646jao.35.1560331177504;
 Wed, 12 Jun 2019 02:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Z4naaxx4N2B2t1hn4A99dfk=6yTY2yAZM=aJ05VCPLFQ@mail.gmail.com>
 <54bc80f8-71aa-1c04-5908-01923247832e@kernel.org> <CACT4Y+YUBw=t3CkbLeKLFAeAbzVZXoG09HARR+nsOTW4gkdLOw@mail.gmail.com>
 <6d5e0484-4dbc-d122-1ae4-9cce44c2d668@kernel.org> <CACT4Y+aE841JzvEVFmAevgmBO0eOssz0MFydWiuoAp18nr=_DA@mail.gmail.com>
 <CACT4Y+abfa9xVg+3S_tgpOA3cZ2bexe51d0FEZyBCGn0M-6DiA@mail.gmail.com> <CACT4Y+aiDUV4_JrvKct98mKvPwEQXSZFXae3qweSmotpzCAGTw@mail.gmail.com>
In-Reply-To: <CACT4Y+aiDUV4_JrvKct98mKvPwEQXSZFXae3qweSmotpzCAGTw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Jun 2019 11:19:26 +0200
Message-ID: <CACT4Y+a8zK7st7LUTkD=AaUBZGsn5hqLt5NXHHvJ0dg1Jds6Nw@mail.gmail.com>
Subject: Re: kselftest build broken?
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 12, 2019 at 11:13 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Jun 12, 2019 at 11:09 AM Dmitry Vyukov <dvyukov@google.com> wrote=
:
> > > On Tue, Jun 11, 2019 at 9:20 PM shuah <shuah@kernel.org> wrote:
> > > >
> > > > On 6/11/19 10:03 AM, Dmitry Vyukov wrote:
> > > > > On Tue, Jun 11, 2019 at 5:16 PM shuah <shuah@kernel.org> wrote:
> > > > >>
> > > > >> Hi Dmitry,
> > > > >>
> > > > >> On 6/11/19 4:30 AM, Dmitry Vyukov wrote:
> > > > >>> Hi,
> > > > >>>
> > > > >>> I've tried to build kselftests for several years now, but I alw=
ays
> > > > >>> find the build broken. Which makes me wonder if the instruction=
s are
> > > > >>> broken or something. I follow the instructions in
> > > > >>> Documentation/dev-tools/kselftest.rst and start with "make -C
> > > > >>> tools/testing/selftests". Here is the errors I get on the upstr=
eam
> > > > >>> commit 16d72dd4891fecc1e1bf7ca193bb7d5b9804c038:
> > > > >>>> error: unable to create target: 'No available targets are comp=
atible
> > > > >>> with triple "bpf"'
> > > > >>> 1 error generated.
> > > > >>> Makefile:259: recipe for target 'elfdep' failed
> > > > >>> Makefile:156: recipe for target 'all' failed
> > > > >>> Makefile:106: recipe for target
> > > > >>> '/linux/tools/testing/selftests/bpf/libbpf.a' failed
> > > > >>> test_execve.c:4:10: fatal error: cap-ng.h: No such file or dire=
ctory
> > > > >>
> > > > >> These errors are due to missing dependencies. You will need
> > > > >>
> > > > >> libmount-dev
> > > > >> libcap-ng-dev
> > > > >> libelf-dev
> > > > >>
> > > > >> for bpf to build and also clang
> > > > >>
> > > > >>> ../lib.mk:138: recipe for target
> > > > >>> '/linux/tools/testing/selftests/capabilities/test_execve' faile=
d
> > > > >>> gpio-mockup-chardev.c:20:10: fatal error: libmount.h: No such f=
ile or directory > <builtin>: recipe for target 'gpio-mockup-chardev' faile=
d
> > > > >>> fuse_mnt.c:17:10: fatal error: fuse.h: No such file or director=
y
> > > > >>
> > > > >> libfuse-dev is missing.
> > > > >>
> > > > >>> ../lib.mk:138: recipe for target
> > > > >>> '/linux/tools/testing/selftests/memfd/fuse_mnt' failed
> > > > >>> collect2: error: ld returned 1 exit status
> > > > >>> ../lib.mk:138: recipe for target
> > > > >>> '/linux/tools/testing/selftests/mqueue/mq_open_tests' failed
> > > > >>
> > > > >> Needs libpopt-dev
> > > > >>
> > > > >>> reuseport_bpf_numa.c:24:10: fatal error: numa.h: No such file o=
r directory
> > > > >>
> > > > >> Needs libnuma-dev
> > > > >>
> > > > >>> ../lib.mk:138: recipe for target
> > > > >>> '/linux/tools/testing/selftests/net/reuseport_bpf_numa' failed
> > > > >>> mlock-random-test.c:8:10: fatal error: sys/capability.h: No suc=
h file
> > > > >>> or directory > ../lib.mk:138: recipe for target
> > > > >>> '/linux/tools/testing/selftests/vm/mlock-random-test' failed
> > > > >>>
> > > > >>> Here is full log:
> > > > >>>
> > > > >>> https://gist.githubusercontent.com/dvyukov/47430636e160f297b657=
df5ba2efa82b/raw/7babc4db228b88f341a376c15e8bc9c4c3b02160/gistfile1.txt
> > > > >>>
> > > > >>> I have libelf-dev installed. Do I need to install something els=
e? Or
> > > > >>> run some other command?
> > > > >>
> > > > >> ii  libelf-dev:amd 0.170-0.4ubu amd64        libelf1 development
> > > > >> libraries and
> > > > >> ii  libelf1:amd64  0.170-0.4ubu amd64        library to read and=
 write
> > > > >> ELF fil
> > > > >>
> > > > >>
> > > > >> All of the above built for me on Linux 5.2-rc4. Try installing a=
ll of
> > > > >> these and let me know if you still see problems.
> > > > >
> > > > >
> > > > > Hi Shuah,
> > > > >
> > > > > Thanks for quick reply!
> > > > >
> > > > > I've installed these: libmount-dev libcap-ng-dev libfuse-dev
> > > > > libpopt-dev libnuma-dev.
> > > > > libelf-dev I already had. And for clang I switched to distro-prov=
ided one.
> > > > >
> > > > > This reduced number of errors, but I still see some:
> > > > >
> > > > > clang: error: unable to execute command: Broken pipe
> > > > > clang: error: clang frontend command failed due to signal (use -v=
 to
> > > > > see invocation)
> > > > > Makefile:259: recipe for target 'elfdep' failed
> > > > > Makefile:156: recipe for target 'all' failed
> > > > > Makefile:106: recipe for target
> > > > > '/linux/tools/testing/selftests/bpf/libbpf.a' failed
> > > >
> > > > Getting bpf compile to work take a few steps. If I remember correct=
ly,
> > > > You will need llvm as well. Here is what I have on my system:
> > > >
> > > > ii  libllvm6.0:amd 1:6.0-1ubunt amd64        Modular compiler and
> > > > toolchain te
> > > > ii  llvm           1:6.0-41~exp amd64        Low-Level Virtual Mach=
ine
> > > > (LLVM)
> > > > ii  llvm-6.0       1:6.0-1ubunt amd64        Modular compiler and
> > > > toolchain te
> > > > ii  llvm-6.0-dev   1:6.0-1ubunt amd64        Modular compiler and
> > > > toolchain te
> > > > un  llvm-6.0-doc   <none>       <none>       (no description availa=
ble)
> > > > ii  llvm-6.0-runti 1:6.0-1ubunt amd64        Modular compiler and
> > > > toolchain te
> > > > ii  llvm-runtime   1:6.0-41~exp amd64        Low-Level Virtual Mach=
ine
> > > > (LLVM),
> > > >
> > > > > timestamping.c:249:19: error: =E2=80=98SIOCGSTAMP=E2=80=99 undecl=
ared (first use in
> > > > > this function); did you mean =E2=80=98SIOCGSTAMPNS=E2=80=99?
> > > > > ../../lib.mk:138: recipe for target
> > > > > '/linux/tools/testing/selftests/networking/timestamping/timestamp=
ing'
> > > > > failed
> > > > > mlock-random-test.c:8:10: fatal error: sys/capability.h: No such =
file
> > > > > or directory
> > > >
> > > > Do you have libcap-dev installed?
> > > >
> > > > ii  libcap-dev:amd 1:2.25-1.2   amd64        POSIX 1003.1e capabili=
ties
> > > > (devel
> > > > ii  libcap-ng-dev  0.7.7-3.1    amd64        Development and header
> > > > files for
> > > > ii  libcap-ng0:amd 0.7.7-3.1    amd64        An alternate POSIX
> > > > capabilities l
> > > > ii  libcap2:amd64  1:2.25-1.2   amd64        POSIX 1003.1e capabili=
ties
> > > > (libra
> > > > ii  libcap2-bin    1:2.25-1.2   amd64        POSIX 1003.1e capabili=
ties
> > > > (utili
> > > > un  libcap2-dev    <none>       <none>       (no description availa=
ble)
> > >
> > > I've installed libcap-dev and resolved the missing header.
> > >
> > > I've also installed llvm llvm-6.0  llvm-6.0-dev  llvm-6.0-doc
> > > libllvm6.0  llvm-6.0-runtime llvm-runtime and it fixed crashing
> > > compiler.
> > > But bpf tests build was still failing due to missing libelf. But I ha=
d
> > > the library, so I went and removed some random files:
> > > tools/testing/selftests/bpf/{feature,FEATURE-DUMP.libbpf}. Don't ask
> > > me why these.
> > >
> > > I am now down to just 1 build error:
> > >
> > >   CC       /usr/local/google/home/dvyukov/src/linux/tools/testing/sel=
ftests/bpf/str_error.o
> > > timestamping.c:249:19: error: =E2=80=98SIOCGSTAMP=E2=80=99 undeclared=
 (first use in
> > > this function); did you mean =E2=80=98SIOCGSTAMPNS=E2=80=99?
> >
> >
> > Is this a non-fatal error? Usually when make produces errors, one
> > expects that nothing is done and it was aborted mid-way. But make
> > seems to produce some test binaries by now.
> >
> >
> > Reading the doc further, these command seem to implicitly assume that
> > the tests will run right on my host machine:
> >
> >   $ make -C tools/testing/selftests run_tests
> >   $ make kselftest
> >
> > Is it right? At least I don't see how it's configured to run them
> > somewhere else? Or it uses something like qemu by default to run the
> > kernel under test?
> > If it runs the tests on the host, it can't work for me. I don't have
> > the test kernel installed and there is no way I can do this. Policy
> > rules aside, this is yet untested kernel, so by installing it I am
> > risking losing my whole machine and all data...
> >
> > What am I missing?
>
> Reading further. "Install selftests" and "Running installed selftests"
> sections. Is it something I can use to copy the pre-built tests to the
> test machine? The sections don't spell it, so I am just trying to
> second guess. Or what's the purpose of installing?
>
> The "Running installed selftests" section says:
> "Kselftest install as well as the Kselftest tarball provide a script
> named "run_kselftest.sh" to run the tests".
>
> What is the "Kselftest tarball"? Where does one get one? I don't see
> any mentions of "tarball" anywhere else in the doc.



Running ./kselftest_install.sh I am getting:

/bin/sh: llvm-readelf: command not found

I can't find any package that would provide this. I happened to have a
custom llvm build that has that binary, but I am interested how I was
supposed to get this for the purposes of documentation and reuse of
instructions by others.

After adding my llvm-readelf to PATH, I am then getting:

make[1]: *** No rule to make target 'emit_tests'.  Stop.

Looks like an error, or is it?

It produced something in the output dir, so copied that to the test
machine and tried to run run_kselftest.sh there, but it failed too:

~/kselftest# ./run_kselftest.sh
./run_kselftest.sh: 2: ./run_kselftest.sh: realpath: not found
./run_kselftest.sh: 4: .: Can't open ./kselftest/runner.sh

Is there some kind of prerequisites that I am supposed to install there?
Since the target may have non-x86 arch and a custom distro, any
additional dependency there may be very painful to get...
