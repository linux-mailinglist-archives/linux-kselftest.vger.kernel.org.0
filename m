Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7014C42373
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 13:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406553AbfFLLGO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 07:06:14 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55436 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406124AbfFLLGN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 07:06:13 -0400
Received: by mail-it1-f194.google.com with SMTP id i21so10029490ita.5
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 04:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=245sbe97DJBsHS5QZeEzItApb6nyy7TGmsy4HI5TgKA=;
        b=l8Cw6SPU6LAL1idPZ0w17oA8G5bfYF0NPzOtot3Lcy/l7BrpryfumL2JmxeWdoSUfd
         W1dEz4XVWTvnLbU7A5nzx9F/CXZXvg5gtsM4zNSV934VDurtp9PzHp/fEc4JWOWLkUEN
         lcaBWimc+1iqz055QT5B/YceNUNDXBnXaXPMXmBExdvU5z20cFjKhINeVVPgulzLPs8h
         PDqfYvYY1/5KCAK2SIoJSC/1V+hL0v2YzBap90q6yZum4Qhsl8l5QkJ78yPADbD4F9Cx
         iddK1VOBo4oCB2O0PW4pTgqd8pTI4bkW2+f/Nfwr56TJJfEas529MKqUIrKOZ9EUhZdL
         twZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=245sbe97DJBsHS5QZeEzItApb6nyy7TGmsy4HI5TgKA=;
        b=Oi5TRrryHP9MPDSKbvye+LALcjINKBGEolQaJcBS5+GM80LyMi7Iihdf8QlDjb4SMK
         PuhX8697ueuYMId6Nqgi5anS4LU5GdQs2ZVVflvHNLLYx+tajBMt8RpkrWybCuQrb3MF
         EY5njgZC+3FN463dYwD4Fio9lkIufnFHo09WxXjGnayQGFSYK60HGbsaJCCHqOR2T7BM
         ddKpwwEpEJGYfEbe2k9gPYM36iTdPT7rlU7zsTfsOEJ7+CvAO31n6iM/f6sLHyBMpMnu
         H6YgPKvhKeeUcDgy9WQJtdikA6eNQ7WfmzxKMbXmk+6eq/PR5uJ36dh0IYm3pEbxZ51Z
         ++UA==
X-Gm-Message-State: APjAAAWvoCce156Dlsv6HYyAfKHopFVRMKJOj0LfJHaFEkFseKC/RdC2
        8DTTZO70JwGuMH2kTrOpzq92SYtjQ2yE1TZaOnG1eA==
X-Google-Smtp-Source: APXvYqxNVlBGXiBQBLoX511uwrY7VW1iz8PLKdgFBXq035X9UwaKGSADgSu2436jGFIecNUgqxwiVQlixySUABKVxNM=
X-Received: by 2002:a24:4417:: with SMTP id o23mr22915283ita.88.1560337572179;
 Wed, 12 Jun 2019 04:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Z4naaxx4N2B2t1hn4A99dfk=6yTY2yAZM=aJ05VCPLFQ@mail.gmail.com>
 <54bc80f8-71aa-1c04-5908-01923247832e@kernel.org> <CACT4Y+YUBw=t3CkbLeKLFAeAbzVZXoG09HARR+nsOTW4gkdLOw@mail.gmail.com>
 <6d5e0484-4dbc-d122-1ae4-9cce44c2d668@kernel.org> <CACT4Y+aE841JzvEVFmAevgmBO0eOssz0MFydWiuoAp18nr=_DA@mail.gmail.com>
 <CACT4Y+abfa9xVg+3S_tgpOA3cZ2bexe51d0FEZyBCGn0M-6DiA@mail.gmail.com>
 <CACT4Y+aiDUV4_JrvKct98mKvPwEQXSZFXae3qweSmotpzCAGTw@mail.gmail.com> <CACT4Y+a8zK7st7LUTkD=AaUBZGsn5hqLt5NXHHvJ0dg1Jds6Nw@mail.gmail.com>
In-Reply-To: <CACT4Y+a8zK7st7LUTkD=AaUBZGsn5hqLt5NXHHvJ0dg1Jds6Nw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Jun 2019 13:05:59 +0200
Message-ID: <CACT4Y+YKf3BFi-9J7Ag0yPtEWYrsPZXY1qUw21yRkNYu51wBWg@mail.gmail.com>
Subject: Re: kselftest build broken?
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 12, 2019 at 11:19 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > On Tue, Jun 11, 2019 at 9:20 PM shuah <shuah@kernel.org> wrote:
> > > > >
> > > > > On 6/11/19 10:03 AM, Dmitry Vyukov wrote:
> > > > > > On Tue, Jun 11, 2019 at 5:16 PM shuah <shuah@kernel.org> wrote:
> > > > > >>
> > > > > >> Hi Dmitry,
> > > > > >>
> > > > > >> On 6/11/19 4:30 AM, Dmitry Vyukov wrote:
> > > > > >>> Hi,
> > > > > >>>
> > > > > >>> I've tried to build kselftests for several years now, but I a=
lways
> > > > > >>> find the build broken. Which makes me wonder if the instructi=
ons are
> > > > > >>> broken or something. I follow the instructions in
> > > > > >>> Documentation/dev-tools/kselftest.rst and start with "make -C
> > > > > >>> tools/testing/selftests". Here is the errors I get on the ups=
tream
> > > > > >>> commit 16d72dd4891fecc1e1bf7ca193bb7d5b9804c038:
> > > > > >>>> error: unable to create target: 'No available targets are co=
mpatible
> > > > > >>> with triple "bpf"'
> > > > > >>> 1 error generated.
> > > > > >>> Makefile:259: recipe for target 'elfdep' failed
> > > > > >>> Makefile:156: recipe for target 'all' failed
> > > > > >>> Makefile:106: recipe for target
> > > > > >>> '/linux/tools/testing/selftests/bpf/libbpf.a' failed
> > > > > >>> test_execve.c:4:10: fatal error: cap-ng.h: No such file or di=
rectory
> > > > > >>
> > > > > >> These errors are due to missing dependencies. You will need
> > > > > >>
> > > > > >> libmount-dev
> > > > > >> libcap-ng-dev
> > > > > >> libelf-dev
> > > > > >>
> > > > > >> for bpf to build and also clang
> > > > > >>
> > > > > >>> ../lib.mk:138: recipe for target
> > > > > >>> '/linux/tools/testing/selftests/capabilities/test_execve' fai=
led
> > > > > >>> gpio-mockup-chardev.c:20:10: fatal error: libmount.h: No such=
 file or directory > <builtin>: recipe for target 'gpio-mockup-chardev' fai=
led
> > > > > >>> fuse_mnt.c:17:10: fatal error: fuse.h: No such file or direct=
ory
> > > > > >>
> > > > > >> libfuse-dev is missing.
> > > > > >>
> > > > > >>> ../lib.mk:138: recipe for target
> > > > > >>> '/linux/tools/testing/selftests/memfd/fuse_mnt' failed
> > > > > >>> collect2: error: ld returned 1 exit status
> > > > > >>> ../lib.mk:138: recipe for target
> > > > > >>> '/linux/tools/testing/selftests/mqueue/mq_open_tests' failed
> > > > > >>
> > > > > >> Needs libpopt-dev
> > > > > >>
> > > > > >>> reuseport_bpf_numa.c:24:10: fatal error: numa.h: No such file=
 or directory
> > > > > >>
> > > > > >> Needs libnuma-dev
> > > > > >>
> > > > > >>> ../lib.mk:138: recipe for target
> > > > > >>> '/linux/tools/testing/selftests/net/reuseport_bpf_numa' faile=
d
> > > > > >>> mlock-random-test.c:8:10: fatal error: sys/capability.h: No s=
uch file
> > > > > >>> or directory > ../lib.mk:138: recipe for target
> > > > > >>> '/linux/tools/testing/selftests/vm/mlock-random-test' failed
> > > > > >>>
> > > > > >>> Here is full log:
> > > > > >>>
> > > > > >>> https://gist.githubusercontent.com/dvyukov/47430636e160f297b6=
57df5ba2efa82b/raw/7babc4db228b88f341a376c15e8bc9c4c3b02160/gistfile1.txt
> > > > > >>>
> > > > > >>> I have libelf-dev installed. Do I need to install something e=
lse? Or
> > > > > >>> run some other command?
> > > > > >>
> > > > > >> ii  libelf-dev:amd 0.170-0.4ubu amd64        libelf1 developme=
nt
> > > > > >> libraries and
> > > > > >> ii  libelf1:amd64  0.170-0.4ubu amd64        library to read a=
nd write
> > > > > >> ELF fil
> > > > > >>
> > > > > >>
> > > > > >> All of the above built for me on Linux 5.2-rc4. Try installing=
 all of
> > > > > >> these and let me know if you still see problems.
> > > > > >
> > > > > >
> > > > > > Hi Shuah,
> > > > > >
> > > > > > Thanks for quick reply!
> > > > > >
> > > > > > I've installed these: libmount-dev libcap-ng-dev libfuse-dev
> > > > > > libpopt-dev libnuma-dev.
> > > > > > libelf-dev I already had. And for clang I switched to distro-pr=
ovided one.
> > > > > >
> > > > > > This reduced number of errors, but I still see some:
> > > > > >
> > > > > > clang: error: unable to execute command: Broken pipe
> > > > > > clang: error: clang frontend command failed due to signal (use =
-v to
> > > > > > see invocation)
> > > > > > Makefile:259: recipe for target 'elfdep' failed
> > > > > > Makefile:156: recipe for target 'all' failed
> > > > > > Makefile:106: recipe for target
> > > > > > '/linux/tools/testing/selftests/bpf/libbpf.a' failed
> > > > >
> > > > > Getting bpf compile to work take a few steps. If I remember corre=
ctly,
> > > > > You will need llvm as well. Here is what I have on my system:
> > > > >
> > > > > ii  libllvm6.0:amd 1:6.0-1ubunt amd64        Modular compiler and
> > > > > toolchain te
> > > > > ii  llvm           1:6.0-41~exp amd64        Low-Level Virtual Ma=
chine
> > > > > (LLVM)
> > > > > ii  llvm-6.0       1:6.0-1ubunt amd64        Modular compiler and
> > > > > toolchain te
> > > > > ii  llvm-6.0-dev   1:6.0-1ubunt amd64        Modular compiler and
> > > > > toolchain te
> > > > > un  llvm-6.0-doc   <none>       <none>       (no description avai=
lable)
> > > > > ii  llvm-6.0-runti 1:6.0-1ubunt amd64        Modular compiler and
> > > > > toolchain te
> > > > > ii  llvm-runtime   1:6.0-41~exp amd64        Low-Level Virtual Ma=
chine
> > > > > (LLVM),
> > > > >
> > > > > > timestamping.c:249:19: error: =E2=80=98SIOCGSTAMP=E2=80=99 unde=
clared (first use in
> > > > > > this function); did you mean =E2=80=98SIOCGSTAMPNS=E2=80=99?
> > > > > > ../../lib.mk:138: recipe for target
> > > > > > '/linux/tools/testing/selftests/networking/timestamping/timesta=
mping'
> > > > > > failed
> > > > > > mlock-random-test.c:8:10: fatal error: sys/capability.h: No suc=
h file
> > > > > > or directory
> > > > >
> > > > > Do you have libcap-dev installed?
> > > > >
> > > > > ii  libcap-dev:amd 1:2.25-1.2   amd64        POSIX 1003.1e capabi=
lities
> > > > > (devel
> > > > > ii  libcap-ng-dev  0.7.7-3.1    amd64        Development and head=
er
> > > > > files for
> > > > > ii  libcap-ng0:amd 0.7.7-3.1    amd64        An alternate POSIX
> > > > > capabilities l
> > > > > ii  libcap2:amd64  1:2.25-1.2   amd64        POSIX 1003.1e capabi=
lities
> > > > > (libra
> > > > > ii  libcap2-bin    1:2.25-1.2   amd64        POSIX 1003.1e capabi=
lities
> > > > > (utili
> > > > > un  libcap2-dev    <none>       <none>       (no description avai=
lable)
> > > >
> > > > I've installed libcap-dev and resolved the missing header.
> > > >
> > > > I've also installed llvm llvm-6.0  llvm-6.0-dev  llvm-6.0-doc
> > > > libllvm6.0  llvm-6.0-runtime llvm-runtime and it fixed crashing
> > > > compiler.
> > > > But bpf tests build was still failing due to missing libelf. But I =
had
> > > > the library, so I went and removed some random files:
> > > > tools/testing/selftests/bpf/{feature,FEATURE-DUMP.libbpf}. Don't as=
k
> > > > me why these.
> > > >
> > > > I am now down to just 1 build error:
> > > >
> > > >   CC       /usr/local/google/home/dvyukov/src/linux/tools/testing/s=
elftests/bpf/str_error.o
> > > > timestamping.c:249:19: error: =E2=80=98SIOCGSTAMP=E2=80=99 undeclar=
ed (first use in
> > > > this function); did you mean =E2=80=98SIOCGSTAMPNS=E2=80=99?
> > >
> > >
> > > Is this a non-fatal error? Usually when make produces errors, one
> > > expects that nothing is done and it was aborted mid-way. But make
> > > seems to produce some test binaries by now.
> > >
> > >
> > > Reading the doc further, these command seem to implicitly assume that
> > > the tests will run right on my host machine:
> > >
> > >   $ make -C tools/testing/selftests run_tests
> > >   $ make kselftest
> > >
> > > Is it right? At least I don't see how it's configured to run them
> > > somewhere else? Or it uses something like qemu by default to run the
> > > kernel under test?
> > > If it runs the tests on the host, it can't work for me. I don't have
> > > the test kernel installed and there is no way I can do this. Policy
> > > rules aside, this is yet untested kernel, so by installing it I am
> > > risking losing my whole machine and all data...
> > >
> > > What am I missing?
> >
> > Reading further. "Install selftests" and "Running installed selftests"
> > sections. Is it something I can use to copy the pre-built tests to the
> > test machine? The sections don't spell it, so I am just trying to
> > second guess. Or what's the purpose of installing?
> >
> > The "Running installed selftests" section says:
> > "Kselftest install as well as the Kselftest tarball provide a script
> > named "run_kselftest.sh" to run the tests".
> >
> > What is the "Kselftest tarball"? Where does one get one? I don't see
> > any mentions of "tarball" anywhere else in the doc.
>
>
>
> Running ./kselftest_install.sh I am getting:
>
> /bin/sh: llvm-readelf: command not found
>
> I can't find any package that would provide this. I happened to have a
> custom llvm build that has that binary, but I am interested how I was
> supposed to get this for the purposes of documentation and reuse of
> instructions by others.
>
> After adding my llvm-readelf to PATH, I am then getting:
>
> make[1]: *** No rule to make target 'emit_tests'.  Stop.
>
> Looks like an error, or is it?
>
> It produced something in the output dir, so copied that to the test
> machine and tried to run run_kselftest.sh there, but it failed too:
>
> ~/kselftest# ./run_kselftest.sh
> ./run_kselftest.sh: 2: ./run_kselftest.sh: realpath: not found
> ./run_kselftest.sh: 4: .: Can't open ./kselftest/runner.sh
>
> Is there some kind of prerequisites that I am supposed to install there?
> Since the target may have non-x86 arch and a custom distro, any
> additional dependency there may be very painful to get...


Hi Shuah,

I am asking lots of questions, but I did not provide my motivation and end =
goal.
I am trying to understand overall state of the kernel testing better
and understand (1) if there are working instructions to run kernel
testing that I can give to a new team member or a new external kernel
developer, (2) if/how I can ask a kernel developer fixing a bug to add
a regression test and ensure that it works. Note in these cases a user
may not have lots of specific expertise (e.g. any unsaid/implicit
thing may be a showstopper) and/or don't have infinite motivation/time
(may give up given a single excuse to do so) and/or don't have
specific interest/expertise in the tested subsystem (e.g. a drive-by
fix).
So now I am trying to follow this route myself, documenting steps here.


Back to:
./run_kselftest.sh: 2: ./run_kselftest.sh: realpath: not found

dpkg on my host says that this binary comes from coreutils:

$ dpkg -S realpath
coreutils: /usr/bin/realpath

but installing coreutils does not help. Seems that I need to install
realpath itself. But this package happens to be broken on my test
distro:

# apt-get install realpath
Reading package lists... Done
Building dependency tree... Done
The following NEW packages will be installed:
  realpath
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 16.7 kB of archives.
After this operation, 115 kB of additional disk space will be used.
Err http://deb.debian.org/debian/ wheezy/main realpath amd64 1.18
  404  Not Found [IP: 151.101.120.204 80]
Failed to fetch
http://deb.debian.org/debian/pool/main/r/realpath/realpath_1.18_amd64.deb
 404  Not Found [IP: 151.101.120.204 80]
E: Unable to fetch some archives, maybe run apt-get update or try with
--fix-missing?


I've switched to another distro (fortunately I had another one
pre-built), and run_kselftest.sh started running tests.
But now I have even more questions :)

1. Meta-question: "Running a subset of selftests" section talks about
"subsystems". How can I map a source file I changed in a drive-by fix
to a subsystem? Say, I changed net/ipv6/netfilter/nft_redir_ipv6.c or
drivers/usb/c67x00/c67x00-drv.c, what subsystems do I need to run?

2. All C tests seem to fail with:
# ./test_maps: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.26'
not found (required by ./test_maps)
Which means that my image is still unsuitable. How can I get an image
that is suitable to run the tests?

3. Lots of tests that do run (probably shell tests), fail/skipped with
some cryptic for me errors like:

# Cannot find device "ip6gre11"

# selftests: [SKIP] Could not run test without the ip xdpgeneric support

# modprobe: ERROR: ../libkmod/libkmod.c:586 kmod_search_moddep() could
not open moddep file '/lib/modules/5.1.0+/modules.dep.bin'

# selftests: bpf: test_tc_edt.sh
# nc is not available
not ok 40 selftests: bpf: test_tc_edt.sh

Say, I either want to run tests for a specific subsystem because I am
doing a drive-by fix (a typical newcomer/good Samaritan scenario), or
I want to run as many tests as possible (a typical CI scenario). Is
there a way to bulk satisfy all these prerequisite (configs, binaries
and whatever they are asking for)?

4. There is a test that consistently reboots my machine:

# selftests: breakpoints: step_after_suspend_test
[  514.024889] PM: suspend entry (deep)
[  514.025959] PM: Syncing filesystems ... done.
[  514.051573] Freezing user space processes ... (elapsed 0.001 seconds) do=
ne.
[  514.054140] OOM killer disabled.
[  514.054764] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[  514.057695] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
early console in extract_kernel
input_data: 0x0000000007ddc2e9
input_len: 0x0000000002c26bf0
output: 0x0000000001000000
output_len: 0x0000000008492a48
kernel_total_size: 0x0000000009a26000
trampoline_32bit: 0x000000000009d000
Decompressing Linux... Parsing ELF... done.
Booting the kernel.
[    0.000000] Linux version 5.0.0 (gcc version 7.3.0 (Debian
7.3.0-18)) #7 SMP PREEMPT Wed Jun 12 11:38:12 CEST 2019

Is it a bug in the test? in the kernel? Or how is this supposed to
work/what am I supposed to do with this?


5. There is a test that triggers a use-after-free:

[  262.639848][    C1] BUG: KASAN: use-after-free in
ip6gre_tunnel_lookup+0x1a27/0x1ae0

I went back to v5.0 (3+ months ago), and I see that it's also the case ther=
e.
Do you know if anybody running these tests? With KMEMLEAK, LOCKDEP, etc?

6. Do we know what's the current code coverage achieved by these
tests? What's covered? What's not? Overall percent/per-subsystem/etc?

Thanks
