Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6B4FA8D46
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2019 21:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbfIDQm6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Sep 2019 12:42:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40523 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731909AbfIDQm5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Sep 2019 12:42:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so904987pfb.7
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2019 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k/oSgBJoI5i7CG44m8oeHuWL1TxHBP3PuiLD3GqEJMs=;
        b=nwB/hLSn8C9Fkj9mb1gL3IZdiu1myDs/hI9yOnbYVwPMQzq/+T5kRyXBBJu+pVilfL
         7IRiEtjBA/24FhzA3AmKhmd/sXJUIn0xXj+X/OcSYB247wOsL2jjiUMzMS3Si9jSLz3p
         iNpkS3Y26SHcoE9ke8ZItIXfdzQIHvSvxcg1/CLwEPZwJg59YiMNG4DpVskuIl97C1kF
         aw6aVY6TIGl+2KqCYIg4WiMgl8e2amGB6/4D0G14vgZzjGWzEaEnsKr53cvPyVKtIcTx
         KqFvOn2rofspFPjswyZusr7qO1AlM4WAqNtiuH3vHf5g0nSeN3Iu8s9fKTNm6g4kQGnK
         gSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k/oSgBJoI5i7CG44m8oeHuWL1TxHBP3PuiLD3GqEJMs=;
        b=fXIfOQq9Ch4kH0dGUSMi6hkUhrunD6L9SWaWX7fYsZgfDb5AC8crHE0z8DoiO1Ofjr
         kB+QLndxtODgh3uFmJaVDmXvTrMBk9u8zvWqbcrODXLVbjFyJWgtV9TLgtdgNZs9Xz8s
         yZWQz8/MiRzygMCXdcnOnQd/D+ngtDZflWrVeAsLRJMjKLuLWpxqNsPtAvtjfF2aWG2c
         L0OUUsfMya2rtuBru8UBN2pTCBMlvvO4e1vE36id3ggdjvessq4JD45q0QzahKihAaGy
         MpS6R0agm72pjtVmVcnO0WvOeWv1LnV5kfv+WBJ5j3oB/CNqrvbEE1dMa8TuMdZm0rRk
         HdnA==
X-Gm-Message-State: APjAAAUJkIDiRgIr7osuJrlAxmw90cPlYjkBOAIrrXQMTDuM8Wi3KOnz
        ZPqSbI/dQvj7DfQ9qEY5a0vCArfLco5gnmUfp7nYzQ==
X-Google-Smtp-Source: APXvYqw9ghhpbkJW620d4F/i5xnGBSYo4okqbHY5PpWEgkRysrp4BZlxOoeP81KxTXsXeG8r2lv3BozPz89snZ14Gcg=
X-Received: by 2002:aa7:8bcc:: with SMTP id s12mr31960729pfd.93.1567615376516;
 Wed, 04 Sep 2019 09:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com> <0999c80cd639b78ae27c0674069d552833227564.1561386715.git.andreyknvl@google.com>
 <6af3f619-4356-2f67-ed76-92beceb1e0a0@arm.com> <CAAeHK+yhbUcuLhoetjGUbqM4j9fX84hbwmxzNPF+e1zXj6nKNw@mail.gmail.com>
 <d6bc5c4b-68b5-0a58-0f52-8bce20986dcf@arm.com> <CAAeHK+xXN_oHt0rAcWdTs0XhkYRhWqf3iv-n+dYmY075xosJnw@mail.gmail.com>
 <92ca7fd1-2aa7-3bec-384d-52033b6496c1@arm.com>
In-Reply-To: <92ca7fd1-2aa7-3bec-384d-52033b6496c1@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 4 Sep 2019 18:42:45 +0200
Message-ID: <CAAeHK+ybMvTNB8_fQxNqhb0s0Swr61XPHu3CvEUQxi2vHW6anw@mail.gmail.com>
Subject: Re: [PATCH v18 15/15] selftests, arm64: add a selftest for passing
 tagged pointers to kernel
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 4, 2019 at 6:22 PM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> Hi Andrey !
>
> On 04/09/2019 15:52, Andrey Konovalov wrote:
> > On Fri, Aug 23, 2019 at 7:49 PM Cristian Marussi
> > <cristian.marussi@arm.com> wrote:
> >>
> >>
> >> Hi
> >>
> >> On 23/08/2019 18:16, Andrey Konovalov wrote:
> >>> On Fri, Aug 23, 2019 at 3:56 PM Cristian Marussi
> >>> <cristian.marussi@arm.com> wrote:
> >>>>
> >>>> Hi Andrey
> >>>>
> >>>> On 24/06/2019 15:33, Andrey Konovalov wrote:
> >>>>> This patch is a part of a series that extends kernel ABI to allow t=
o pass
> >>>>> tagged user pointers (with the top byte set to something else other=
 than
> >>>>> 0x00) as syscall arguments.
> >>>>>
> >>>>> This patch adds a simple test, that calls the uname syscall with a
> >>>>> tagged user pointer as an argument. Without the kernel accepting ta=
gged
> >>>>> user pointers the test fails with EFAULT.
> >>>>>
> >>>>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >>>>> ---
> >>>>>  tools/testing/selftests/arm64/.gitignore      |  1 +
> >>>>>  tools/testing/selftests/arm64/Makefile        | 11 +++++++
> >>>>>  .../testing/selftests/arm64/run_tags_test.sh  | 12 ++++++++
> >>>>>  tools/testing/selftests/arm64/tags_test.c     | 29 +++++++++++++++=
++++
> >>>>>  4 files changed, 53 insertions(+)
> >>>>>  create mode 100644 tools/testing/selftests/arm64/.gitignore
> >>>>>  create mode 100644 tools/testing/selftests/arm64/Makefile
> >>>>>  create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
> >>>>>  create mode 100644 tools/testing/selftests/arm64/tags_test.c
> >>>>
> >>>> After building a fresh Kernel from arm64/for-next-core from scratch =
at:
> >>>>
> >>>> commit 239ab658bea3b387424501e7c416640d6752dc0c
> >>>> Merge: 6bfa3134bd3a 42d038c4fb00 1243cb6a676f d55c5f28afaf d06fa5a11=
8f1 34b5560db40d
> >>>> Author: Will Deacon <will@kernel.org>
> >>>> Date:   Thu Aug 22 18:23:53 2019 +0100
> >>>>
> >>>>     Merge branches 'for-next/error-injection', 'for-next/tbi', 'for-=
next/psci-cpuidle', 'for-next/cpu-topology' and 'for-next/52-bit-kva' into =
for-next/core
> >>>>
> >>>>
> >>>> KSFT arm64 tests build is broken for me, both setting or not KBUILD_=
OUTPUT=3D
> >>>>
> >>>> 13:30 $ make TARGETS=3Darm64 kselftest-clean
> >>>> make[1]: Entering directory '/home/crimar01/ARM/dev/src/pdsw/out_lin=
ux'
> >>>> rm -f -r /home/crimar01/ARM/dev/src/pdsw/out_linux//kselftest/arm64/=
tags_test
> >>>> make[1]: Leaving directory '/home/crimar01/ARM/dev/src/pdsw/out_linu=
x'
> >>>>
> >>>> =E2=9C=94 ~/ARM/dev/src/pdsw/linux [arm64_for_next_core|=E2=80=A68=
=E2=9A=91 23]
> >>>>
> >>>> 13:30 $ make TARGETS=3Darm64 kselftest
> >>>> make[1]: Entering directory '/home/crimar01/ARM/dev/src/pdsw/out_lin=
ux'
> >>>> arch/arm64/Makefile:56: CROSS_COMPILE_COMPAT not defined or empty, t=
he compat vDSO will not be built
> >>>> make --no-builtin-rules INSTALL_HDR_PATH=3D$BUILD/usr \
> >>>>         ARCH=3Darm64 -C ../../.. headers_install
> >>>>   HOSTCC  scripts/basic/fixdep
> >>>>   HOSTCC  scripts/unifdef
> >>>> ...
> >>>> ...
> >>>>   HDRINST usr/include/asm/msgbuf.h
> >>>>   HDRINST usr/include/asm/shmbuf.h
> >>>>   INSTALL /home/crimar01/ARM/dev/src/pdsw/out_linux//kselftest/usr/i=
nclude
> >>>> /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aar=
ch64-linux-gnu-gcc     tags_test.c  -o /home/crimar01/ARM/dev/src/pdsw/out_=
linux//kselftest/arm64/tags_test
> >>>> tags_test.c: In function =E2=80=98main=E2=80=99:
> >>>> tags_test.c:21:12: error: =E2=80=98PR_SET_TAGGED_ADDR_CTRL=E2=80=99 =
undeclared (first use in this function); did you mean =E2=80=98PR_GET_TID_A=
DDRESS=E2=80=99?
> >>>>   if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0)=
 =3D=3D 0)
> >>>>             ^~~~~~~~~~~~~~~~~~~~~~~
> >>>>             PR_GET_TID_ADDRESS
> >>>> tags_test.c:21:12: note: each undeclared identifier is reported only=
 once for each function it appears in
> >>>> tags_test.c:21:37: error: =E2=80=98PR_TAGGED_ADDR_ENABLE=E2=80=99 un=
declared (first use in this function); did you mean =E2=80=98PR_GET_DUMPABL=
E=E2=80=99?
> >>>>   if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0)=
 =3D=3D 0)
> >>>>                                      ^~~~~~~~~~~~~~~~~~~~~
> >>>>                                      PR_GET_DUMPABLE
> >>>> ../lib.mk:138: recipe for target '/home/crimar01/ARM/dev/src/pdsw/ou=
t_linux//kselftest/arm64/tags_test' failed
> >>>> make[3]: *** [/home/crimar01/ARM/dev/src/pdsw/out_linux//kselftest/a=
rm64/tags_test] Error 1
> >>>> Makefile:136: recipe for target 'all' failed
> >>>> make[2]: *** [all] Error 2
> >>>> /home/crimar01/ARM/dev/src/pdsw/linux/Makefile:1237: recipe for targ=
et 'kselftest' failed
> >>>> make[1]: *** [kselftest] Error 2
> >>>> make[1]: Leaving directory '/home/crimar01/ARM/dev/src/pdsw/out_linu=
x'
> >>>> Makefile:179: recipe for target 'sub-make' failed
> >>>> make: *** [sub-make] Error 2
> >>>>
> >>>> Despite seeing KSFT installing Kernel Headers, they cannot be found.
> >>>>
> >>>> Fixing this patch like this make it work for me:
> >>>>
> >>>> diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/=
selftests/arm64/Makefile
> >>>> index a61b2e743e99..f9f79fb272f0 100644
> >>>> --- a/tools/testing/selftests/arm64/Makefile
> >>>> +++ b/tools/testing/selftests/arm64/Makefile
> >>>> @@ -4,6 +4,7 @@
> >>>>  ARCH ?=3D $(shell uname -m 2>/dev/null || echo not)
> >>>>
> >>>>  ifneq (,$(filter $(ARCH),aarch64 arm64))
> >>>> +CFLAGS +=3D -I../../../../usr/include/
> >>>>  TEST_GEN_PROGS :=3D tags_test
> >>>>  TEST_PROGS :=3D run_tags_test.sh
> >>>>  endif
> >>>>
> >>>> but is not really a proper fix since it does NOT account for case in=
 which you have
> >>>> installed the Kernel Headers in a non standard location like when yo=
u use KBUILD_OUTPUT.
> >>>>
> >>>> Am I missing something ?
> >>>
> >>> Hm, PR_SET_TAGGED_ADDR_CTRL is defined in include/uapi/linux/prctl.h,
> >>> and the test has #include <sys/prctl.h> so as long as you've updated
> >>> your kernel headers this should work.
> >>>
> >>> (I'm OOO next week, I'll see if I can reproduce this once I'm back).
> >>
> >> Ok. Thanks for the reply.
> >>
> >> I think I've got it in my local tree having cloned arm64/for-next-core=
:
> >>
> >> 18:32 $ egrep -A 10 PR_SET_TAG ./include/uapi/linux/prctl.h
> >> #define PR_SET_TAGGED_ADDR_CTRL         55
> >> #define PR_GET_TAGGED_ADDR_CTRL         56
> >> # define PR_TAGGED_ADDR_ENABLE          (1UL << 0)
> >>
> >> #endif /* _LINUX_PRCTL_H */
> >>
> >> and Kernel header are locally installed in my kernel src dir (by KSFT =
indeed)
> >>
> >> 18:34 $ egrep -RA 10 PR_SET_TAG usr/include/
> >> usr/include/linux/prctl.h:#define PR_SET_TAGGED_ADDR_CTRL             =
  55
> >> usr/include/linux/prctl.h-#define PR_GET_TAGGED_ADDR_CTRL             =
  56
> >> usr/include/linux/prctl.h-# define PR_TAGGED_ADDR_ENABLE              =
  (1UL << 0)
> >> usr/include/linux/prctl.h-
> >> usr/include/linux/prctl.h-#endif /* _LINUX_PRCTL_H */
> >>
> >> but how are they supposed to be found if nor the test Makefile
> >> neither the KSFT Makefile who installs them pass any -I options to the
> >> compiler ?
> >> I suppose <sys/prctl.h> tries to include arch specific headers from th=
e regular system path,
> >> but when you are cross-compiling ?
> >>
> >> 18:34 $ make TARGETS=3Darm64 kselftest
> >> make[1]: Entering directory '/home/crimar01/ARM/dev/src/pdsw/out_linux=
'
> >> arch/arm64/Makefile:56: CROSS_COMPILE_COMPAT not defined or empty, the=
 compat vDSO will not be built
> >> make --no-builtin-rules INSTALL_HDR_PATH=3D$BUILD/usr \
> >>         ARCH=3Darm64 -C ../../.. headers_install
> >>   INSTALL /home/crimar01/ARM/dev/src/pdsw/out_linux/kselftest/usr/incl=
ude
> >> /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch=
64-linux-gnu-gcc -Wall -O2 -g    tags_test.c  -o /home/crimar01/ARM/dev/src=
/pdsw/out_linux/kselftest/arm64/tags/tags_test
> >> tags_test.c: In function =E2=80=98main=E2=80=99:
> >> tags_test.c:20:12: error: =E2=80=98PR_SET_TAGGED_ADDR_CTRL=E2=80=99 un=
declared (first use in this function); did you mean =E2=80=98PR_GET_TID_ADD=
RESS=E2=80=99?
> >>   if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) =
=3D=3D 0)
> >>             ^~~~~~~~~~~~~~~~~~~~~~~
> >>             PR_GET_TID_ADDRESS
> >> tags_test.c:20:12: note: each undeclared identifier is reported only o=
nce for each function it appears in
> >> tags_test.c:20:37: error: =E2=80=98PR_TAGGED_ADDR_ENABLE=E2=80=99 unde=
clared (first use in this function); did you mean =E2=80=98PR_GET_DUMPABLE=
=E2=80=99?
> >>   if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) =
=3D=3D 0)
> >>                                      ^~~~~~~~~~~~~~~~~~~~~
> >>                                      PR_GET_DUMPABLE
> >> ../../lib.mk:138: recipe for target '/home/crimar01/ARM/dev/src/pdsw/o=
ut_linux/kselftest/arm64/tags/tags_test' failed
> >> make[4]: *** [/home/crimar01/ARM/dev/src/pdsw/out_linux/kselftest/arm6=
4/tags/tags_test] Error 1
> >> Makefile:19: recipe for target 'all' failed
> >> make[3]: *** [all] Error 2
> >> Makefile:137: recipe for target 'all' failed
> >> make[2]: *** [all] Error 2
> >> /home/crimar01/ARM/dev/src/pdsw/linux/Makefile:1236: recipe for target=
 'kselftest' failed
> >> make[1]: *** [kselftest] Error 2
> >> make[1]: Leaving directory '/home/crimar01/ARM/dev/src/pdsw/out_linux'
> >> Makefile:179: recipe for target 'sub-make' failed
> >> make: *** [sub-make] Error 2
> >>
> >>
> >> In fact many KSFT testcases seems to brutally add default headers path=
:
> >>
> >> tools/testing/selftests/memfd/Makefile:CFLAGS +=3D -I../../../../inclu=
de/uapi/
> >> tools/testing/selftests/memfd/Makefile:CFLAGS +=3D -I../../../../inclu=
de/
> >> tools/testing/selftests/memfd/Makefile:CFLAGS +=3D -I../../../../usr/i=
nclude/
> >> tools/testing/selftests/net/Makefile:CFLAGS +=3D -I../../../../usr/inc=
lude/
> >> tools/testing/selftests/membarrier/Makefile:CFLAGS +=3D -g -I../../../=
../usr/include/
> >> ...
> >
> > Hi Cristian!
> >
> > Indeed, I can reproduce the issue. I don't know what's the proper way
> > to resolve this. Adding "CFLAGS +=3D -I../../../../usr/include/" looks
> > good to me. AFAICS your series resolves this issue in a similar way,
> > but I think we should fix this before the current rc is released. Do
> > you want to submit a patch that adds this simple fix or should I do
> > that?
> >
>
> Please feel free to post the single line patch above to quickly fix this =
before
> release, so we don't have a broken build straight away. (our CI is alread=
y beating me...:D)

Done.

>
> On my side (01/11) in the meantime I'll fix the top level KSFT arm64 make=
file so as to calculate
> and propagate once for all the headers search path down to all KSFT arm64=
/ in one go,
> trying to guess where they are; this is needed because the above fix work=
s fine as long
> as you don't have KBUILD_OUTPUT set, once you set it, KSFT installs khead=
ers in a different
> place and the  above -I fix is fooled again....but this is a general prob=
lem also in other
> KSFT tests as I can see now so I think this fix is good enough for now
> (and the fix on my side, even if trivial, is not going to go into this re=
lease for sure)

Ah, I see.

Thanks for the report!

>
> Thanks !
>
> Cheers
>
> Cristian
>
> > Thanks!
> >
> >>
> >> Cheers
> >>
> >> Cristian
> >>>
> >>>
> >>>
> >>>>
> >>>> Thanks
> >>>>
> >>>> Cristian
> >>>>
> >>>>>
> >>>>> diff --git a/tools/testing/selftests/arm64/.gitignore b/tools/testi=
ng/selftests/arm64/.gitignore
> >>>>> new file mode 100644
> >>>>> index 000000000000..e8fae8d61ed6
> >>>>> --- /dev/null
> >>>>> +++ b/tools/testing/selftests/arm64/.gitignore
> >>>>> @@ -0,0 +1 @@
> >>>>> +tags_test
> >>>>> diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing=
/selftests/arm64/Makefile
> >>>>> new file mode 100644
> >>>>> index 000000000000..a61b2e743e99
> >>>>> --- /dev/null
> >>>>> +++ b/tools/testing/selftests/arm64/Makefile
> >>>>> @@ -0,0 +1,11 @@
> >>>>> +# SPDX-License-Identifier: GPL-2.0
> >>>>> +
> >>>>> +# ARCH can be overridden by the user for cross compiling
> >>>>> +ARCH ?=3D $(shell uname -m 2>/dev/null || echo not)
> >>>>> +
> >>>>> +ifneq (,$(filter $(ARCH),aarch64 arm64))
> >>>>> +TEST_GEN_PROGS :=3D tags_test
> >>>>> +TEST_PROGS :=3D run_tags_test.sh
> >>>>> +endif
> >>>>> +
> >>>>> +include ../lib.mk
> >>>>> diff --git a/tools/testing/selftests/arm64/run_tags_test.sh b/tools=
/testing/selftests/arm64/run_tags_test.sh
> >>>>> new file mode 100755
> >>>>> index 000000000000..745f11379930
> >>>>> --- /dev/null
> >>>>> +++ b/tools/testing/selftests/arm64/run_tags_test.sh
> >>>>> @@ -0,0 +1,12 @@
> >>>>> +#!/bin/sh
> >>>>> +# SPDX-License-Identifier: GPL-2.0
> >>>>> +
> >>>>> +echo "--------------------"
> >>>>> +echo "running tags test"
> >>>>> +echo "--------------------"
> >>>>> +./tags_test
> >>>>> +if [ $? -ne 0 ]; then
> >>>>> +     echo "[FAIL]"
> >>>>> +else
> >>>>> +     echo "[PASS]"
> >>>>> +fi
> >>>>> diff --git a/tools/testing/selftests/arm64/tags_test.c b/tools/test=
ing/selftests/arm64/tags_test.c
> >>>>> new file mode 100644
> >>>>> index 000000000000..22a1b266e373
> >>>>> --- /dev/null
> >>>>> +++ b/tools/testing/selftests/arm64/tags_test.c
> >>>>> @@ -0,0 +1,29 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>> +
> >>>>> +#include <stdio.h>
> >>>>> +#include <stdlib.h>
> >>>>> +#include <unistd.h>
> >>>>> +#include <stdint.h>
> >>>>> +#include <sys/prctl.h>
> >>>>> +#include <sys/utsname.h>
> >>>>> +
> >>>>> +#define SHIFT_TAG(tag)               ((uint64_t)(tag) << 56)
> >>>>> +#define SET_TAG(ptr, tag)    (((uint64_t)(ptr) & ~SHIFT_TAG(0xff))=
 | \
> >>>>> +                                     SHIFT_TAG(tag))
> >>>>> +
> >>>>> +int main(void)
> >>>>> +{
> >>>>> +     static int tbi_enabled =3D 0;
> >>>>> +     struct utsname *ptr, *tagged_ptr;
> >>>>> +     int err;
> >>>>> +
> >>>>> +     if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, =
0, 0) =3D=3D 0)
> >>>>> +             tbi_enabled =3D 1;
> >>>>> +     ptr =3D (struct utsname *)malloc(sizeof(*ptr));
> >>>>> +     if (tbi_enabled)
> >>>>> +             tagged_ptr =3D (struct utsname *)SET_TAG(ptr, 0x42);
> >>>>> +     err =3D uname(tagged_ptr);
> >>>>> +     free(ptr);
> >>>>> +
> >>>>> +     return err;
> >>>>> +}
> >>>>>
> >>>>
> >>
>
