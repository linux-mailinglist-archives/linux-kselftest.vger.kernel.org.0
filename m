Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53F9D8E06
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 12:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbfJPKfO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 06:35:14 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36598 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390135AbfJPKfO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 06:35:14 -0400
Received: by mail-il1-f194.google.com with SMTP id z2so2070944ilb.3
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 03:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=HExf7zZXZjaXxRe6dlGMMO7falpnayEFeFOW1L9t/SY=;
        b=SJvcXkvWPqdlU8Ky+HWrx0O+7KfuZ4Hn0L+hBCaQH3ncD3wD9s9+d6GPPYuUp7yx8l
         lTp3R4Ie5LUltt+2PbY9eggFjRARmJxj5gcSZKrsPi4JphZV9VPkQfJTxQPEtmFT4fQp
         kot6LdN2953JdjxmkvYrd2vK503zuGtdeCLylHy/THoj8l1+fT21vHWAROy6o9vxYSnn
         UtOoQ+tICzatgeYZ4jqrnL7yF3AqUOl+kUxXng6OTrFS8N5gk+pBGOQEUWh4pXxsGIyF
         8gbdhkjF5qw/7QIeSUrbZEhwL6mFDucX3XB+VwsbloVmwqOqMhLimJxne4FXnxgUQHi3
         0hVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=HExf7zZXZjaXxRe6dlGMMO7falpnayEFeFOW1L9t/SY=;
        b=gCmBeskDeop99WIbecPpcmAh1Y31Mz5CS/lVJbDL7K41RM00DTRG0Lam1jniBbdROv
         EYKCquLA308I84r1cFyUi9+2Ml8mV6UBMvsBMfBrFHNM1ptjPCC2vjWhTRcHA2s3OV5c
         sGT8RVOQOPXFyYBo0q+DM8XXxHjQH4HveDCzNx7gof1LKlwQ9yDAglHwk+XQMdOF2lN8
         bbxjvp5rw5Qsb1km3ZdqMMZve59b1cYpr+mDj5k+Wl+0uWduEa3ARQw+ZO3lOopK3iB2
         PljXYeKyUaNAatOKfJLhwiYzIwPaRQPjOucTxawQeW4c9Q+tuHVigJILIWlRFUY/ltHX
         PbKg==
X-Gm-Message-State: APjAAAUSRdpw3VdofLsO/rZwaF2UnizmRigNxAWZTGdiZESyBzewnuhx
        +RmMmAsv1d6YfuPeEadM6Tu/E96ay9zmIqx+5nnzSRfC
X-Google-Smtp-Source: APXvYqxPL9/J3lcbbceE7sO5lXGjCAq3JM83cJWt4SKoCYlP+NBPNzEBu8pXpnHw1aYTZRGkLRL20TSKfN8/kx+srVU=
X-Received: by 2002:a92:5f06:: with SMTP id t6mr11748441ilb.203.1571222112774;
 Wed, 16 Oct 2019 03:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ2QiJKZjc=rjx9CJigp9EuZ2f-2RV=_SBxV7S5g9q2zx-D+UQ@mail.gmail.com>
In-Reply-To: <CAJ2QiJKZjc=rjx9CJigp9EuZ2f-2RV=_SBxV7S5g9q2zx-D+UQ@mail.gmail.com>
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date:   Wed, 16 Oct 2019 16:05:01 +0530
Message-ID: <CAJ2QiJKsTYaWQHBzt8LxvGesOPNeOPAjibF-=acOPu=TBGp4eg@mail.gmail.com>
Subject: Re: Linux 5.4 - bpf test build fails
To:     daniel@iogearbox.net, skhan@linuxfoundation.org, yhs@fb.com,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

"
On Wed, Oct 16, 2019 at 3:59 PM Prabhakar Kushwaha
<prabhakar.pkin@gmail.com> wrote:
>
> On Tue, Sep 24, 2019 at 12:56:53PM -0600, Shuah Khan wrote:
> > On 9/24/19 12:49 PM, Daniel Borkmann wrote:
> > > On Tue, Sep 24, 2019 at 09:48:35AM -0600, Shuah Khan wrote:
> > > > On 9/24/19 9:43 AM, Yonghong Song wrote:
> > > > > On 9/24/19 8:26 AM, Shuah Khan wrote:
> > > > > > Hi Alexei and Daniel,
> > > > > >
> > > > > > bpf test doesn't build on Linux 5.4 mainline. Do you know what's
> > > > > > happening here.
> > > > > >
> > > > > > make -C tools/testing/selftests/bpf/
> > > > > >
> > > > > > -c progs/test_core_reloc_ptr_as_arr.c -o - || echo "clang failed") | \
> > > > > > llc -march=bpf -mcpu=generic  -filetype=obj -o
> > > > > > /mnt/data/lkml/linux_5.4/tools/testing/selftests/bpf/test_core_reloc_ptr_as_arr.o
> > > > > >
> > > > > > progs/test_core_reloc_ptr_as_arr.c:25:6: error: use of unknown builtin
> > > > > >          '__builtin_preserve_access_index'
> > > > > > [-Wimplicit-function-declaration]
> > > > > >            if (BPF_CORE_READ(&out->a, &in[2].a))
> > > > > >                ^
> > > > > > ./bpf_helpers.h:533:10: note: expanded from macro 'BPF_CORE_READ'
> > > > > >                           __builtin_preserve_access_index(src))
> > > > > >                           ^
> > > > > > progs/test_core_reloc_ptr_as_arr.c:25:6: warning: incompatible
> > > > > > integer to
> > > > > >          pointer conversion passing 'int' to parameter of type 'const
> > > > > > void *'
> > > > > >          [-Wint-conversion]
> > > > > >            if (BPF_CORE_READ(&out->a, &in[2].a))
> > > > > >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > ./bpf_helpers.h:533:10: note: expanded from macro 'BPF_CORE_READ'
> > > > > >                           __builtin_preserve_access_index(src))
> > > > > >                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > 1 warning and 1 error generated.
> > > > > > llc: error: llc: <stdin>:1:1: error: expected top-level entity
> > > > > > clang failed
> > > > > >
> > > > > > Also
> > > > > >
> > > > > > make TARGETS=bpf kselftest fails as well. Dependency between
> > > > > > tools/lib/bpf and the test. How can we avoid this type of
> > > > > > dependency or resolve it in a way it doesn't result in build
> > > > > > failures?
> > > > >
> > > > > Thanks, Shuah.
> > > > >
> > > > > The clang __builtin_preserve_access_index() intrinsic is
> > > > > introduced in LLVM9 (which just released last week) and
> > > > > the builtin and other CO-RE features are only supported
> > > > > in LLVM10 (current development branch) with more bug fixes
> > > > > and added features.
> > > > >
> > > > > I think we should do a feature test for llvm version and only
> > > > > enable these tests when llvm version >= 10.
> > > >
> > > > Yes. If new tests depend on a particular llvm revision, the failing
> > > > the build is a regression. I would like to see older tests that don't
> > > > have dependency build and run.
> > >
> > > So far we haven't made it a requirement as majority of BPF contributors
> > > that would run/add tests in here are also on bleeding edge LLVM anyway
> > > and other CIs like 0-day bot have simply upgraded their LLVM version
> > > from git whenever there was a failure similar to the one here so its
> > > ensured that really /all/ test cases are running and nothing would be
> > > skipped. There is worry to some degree that CIs just keep sticking to
> > > an old compiler since tests "just" pass and regressions wouldn't be
> > > caught on new releases for those that are skipped. >
> >
> > Sure. Bleeding edge is developer mode. We still have to be concerned
> > about users that might not upgrade quickly.
> >
> > > That said, for the C based tests, it should actually be straight forward
> > > to categorize them based on built-in macros like ...
> > >
> > > $ echo | clang -dM -E -
> > > [...]
> > > #define __clang_major__ 10
> > > #define __clang_minor__ 0
> > > [...]
> >
> > What would nice running the tests you can run and then say some tests
> > aren't going to run. Is this something you can support?
>
> Once there is such infra in place, should be possible.
>
> > > ... given there is now also bpf-gcc, the test matrix gets bigger anyway,
> > > so it might be worth rethinking to run the suite multiple times with
> > > different major llvm{,gcc} versions at some point to make sure their
> > > generated BPF bytecode keeps passing the verifier, and yell loudly if
> > > newer features had to be skipped due to lack of recent compiler version.
> > > This would be a super set of /just/ skipping tests and improve coverage
> > > at the same time.
> >
> > Probably. Reality is most users will just quit and add bpf to "hard to
> > run category" of tests.
>
> I don't really worry too much about such users at this point, more important
> is that we have a way to test bpf-gcc and llvm behavior side by side to
> make sure behavior is consistent and to have some sort of automated CI
> integration that runs BPF kselftests before we even stare at a patch for
> review. These are right now the two highest prio items from BPF testing
> side where we need to get to.
>

I am also facing same issue with Linux-5.4 for ARM64 platforms.
I am using ubuntu-18.04 which has LLVM version 6.0.0.   Looks like
there is no LLVM of version 9.0 or 10.0 available for ARM64.
https://apt.llvm.org/

I also tried "sudo ./llvm.sh 9". But it does not install llvm version.

root@ubuntu$ sudo ./llvm.sh 9
+ LLVM_VERSION=9
+ '[' 1 -eq 1 ']'
+ LLVM_VERSION=9
++ lsb_release -is
+ DISTRO=Ubuntu
++ lsb_release -sr
+ VERSION=18.04
+ DIST_VERSION=Ubuntu_18.04
+ [[ 0 -ne 0 ]]
+ declare -A LLVM_VERSION_PATTERNS
+ LLVM_VERSION_PATTERNS[8]=-8
+ LLVM_VERSION_PATTERNS[9]=-9
+ LLVM_VERSION_PATTERNS[10]=
+ '[' '!' _ ']'
+ LLVM_VERSION_STRING=-9
+ case "$DIST_VERSION" in
+ REPO_NAME='deb http://apt.llvm.org/bionic/   llvm-toolchain-bionic-9  main'
+ wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key
+ apt-key add -
--2019-10-16 03:33:34--  https://apt.llvm.org/llvm-snapshot.gpg.key
Resolving apt.llvm.org (apt.llvm.org)... 151.101.190.49, 2a04:4e42:a::561
Connecting to apt.llvm.org (apt.llvm.org)|151.101.190.49|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 3145 (3.1K) [application/octet-stream]
Saving to: ?STDOUT?

-
100%[====================================================================================================>]
  3.07K  --.-KB/s    in 0s

2019-10-16 03:33:35 (74.8 MB/s) - written to stdout [3145/3145]

OK
+ add-apt-repository 'deb http://apt.llvm.org/bionic/
llvm-toolchain-bionic-9  main'
Hit:1 http://apt.llvm.org/bionic llvm-toolchain-bionic InRelease
Hit:2 http://apt.llvm.org/bionic llvm-toolchain-bionic-9 InRelease
Hit:3 http://apt.llvm.org/bionic llvm-toolchain-bionic-8 InRelease
Hit:4 http://us.ports.ubuntu.com/ubuntu-ports bionic InRelease
Hit:5 http://us.ports.ubuntu.com/ubuntu-ports bionic-updates InRelease
Hit:6 http://ports.ubuntu.com/ubuntu-ports bionic-security InRelease
Hit:7 http://us.ports.ubuntu.com/ubuntu-ports bionic-backports InRelease
Reading package lists... Done
N: Skipping acquire of configured file 'main/binary-arm64/Packages' as
repository 'http://apt.llvm.org/bionic llvm-toolchain-bionic
InRelease' doesn't support architecture 'arm64'
N: Skipping acquire of configured file 'main/binary-arm64/Packages' as
repository 'http://apt.llvm.org/bionic llvm-toolchain-bionic-9
InRelease' doesn't support architecture 'arm64'
N: Skipping acquire of configured file 'main/binary-arm64/Packages' as
repository 'http://apt.llvm.org/bionic llvm-toolchain-bionic-8
InRelease' doesn't support architecture 'arm64'
+ apt-get update
Hit:1 http://apt.llvm.org/bionic llvm-toolchain-bionic InRelease
Hit:2 http://apt.llvm.org/bionic llvm-toolchain-bionic-9 InRelease
Hit:3 http://apt.llvm.org/bionic llvm-toolchain-bionic-8 InRelease
Hit:4 http://us.ports.ubuntu.com/ubuntu-ports bionic InRelease
Hit:5 http://us.ports.ubuntu.com/ubuntu-ports bionic-updates InRelease
Hit:6 http://ports.ubuntu.com/ubuntu-ports bionic-security InRelease
Hit:7 http://us.ports.ubuntu.com/ubuntu-ports bionic-backports InRelease
Reading package lists... Done
N: Skipping acquire of configured file 'main/binary-arm64/Packages' as
repository 'http://apt.llvm.org/bionic llvm-toolchain-bionic
InRelease' doesn't support architecture 'arm64'
N: Skipping acquire of configured file 'main/binary-arm64/Packages' as
repository 'http://apt.llvm.org/bionic llvm-toolchain-bionic-9
InRelease' doesn't support architecture 'arm64'
N: Skipping acquire of configured file 'main/binary-arm64/Packages' as
repository 'http://apt.llvm.org/bionic llvm-toolchain-bionic-8
InRelease' doesn't support architecture 'arm64'
+ apt-get install -y clang-9 lldb-9 lld-9 clangd-9
Reading package lists... Done
Building dependency tree
Reading state information... Done
E: Unable to locate package clang-9
E: Unable to locate package lldb-9
E: Unable to locate package lld-9
E: Unable to locate package clangd-9

--prabhakar(pk)
