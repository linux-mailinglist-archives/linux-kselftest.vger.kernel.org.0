Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED11E2D6C60
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 01:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393368AbgLKALE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 19:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393393AbgLKAK4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 19:10:56 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953CAC0613D6
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 16:10:16 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f14so5235236qto.12
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 16:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eyaO3qiwDzgknL6h/ChrfPpZ+ZJEw+xlx9cER6qscjU=;
        b=GzScmKyYZRZP/+D0nUD971xuvmlFp+D2JAAZL6Fy/NUNd3w8eTuX7DFiIjslM+WB6o
         Tzwcrmr1wbB3o2KMrslvoXSgLMfmjaAkCPw3F41seH5Na/mwnWiHH2ov/TbYwdYg+SQD
         DusYUXDTQ2XUA1Imklk2Ad7RGVSL4iCPCabySnT4inLk1HOLzIBp+6VDeMr4hCdg7T/r
         q0YrPIb7p20XttAi/LbF9u40jlAMG8cCahhLicV0TdYFq/gOJgE2cwRtV/2z2z0whZrt
         BEMRPfsqgaVk7KpfVw19RCGMkkFWyVDBPRB6O5EjgjiH1tXZXFe+Pikww9eAcdUxRVUz
         elzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eyaO3qiwDzgknL6h/ChrfPpZ+ZJEw+xlx9cER6qscjU=;
        b=RhJNN0pIFkmLkvWlOGvvwAzm2OCOYdb9oqavRHh2zSM+n1bM7/O+L78Qw/A8d5tHu7
         D+RTn3xzbfy8Jy/I7zMf4q+VWe/qP8mCsVutOD0AUaO7TzGpsbbyFMBMwwcFNzzMml52
         9oe7SnlnsS/xTZ0hbTm9nPZW2SGKmzYYHT0Uk/tHIM9lR0ASKgVAahoWFBbJjD6O9kRf
         ZQktTteYxvWqcTFX6kO6xdpJoarwanlwEkFm7sj1YNAYN6czHM6iKe04X473mGUu+lc3
         FHvl1JArFyCORPN7gOYfs1cZYcsSbDtY+z4kkgxh83Q67CQdHTK1/20K3JGnbEfj54YX
         C7pw==
X-Gm-Message-State: AOAM532tShUXKOfOgxC05q5yLTkNFqSZVmiKrn6jMfyho7wrnkIVukeZ
        uMcMY6iXXeCRy1KmYVCrccmPqZSoJR6wrhQFngWOzw==
X-Google-Smtp-Source: ABdhPJy2QdoiMBFRAJqRP04HNOKnfqsMbef1AE/gelG8yr8bqjpz4Zv8MFmMPBdYhTypzhdWP0qktS0fpzuRFCiRXLA=
X-Received: by 2002:aed:23c8:: with SMTP id k8mr12527987qtc.362.1607645415476;
 Thu, 10 Dec 2020 16:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20201203221005.2813159-1-adelg@google.com> <CAKwvOdk6=TgL+f2-WvE7tsK0rN1XQ+NdXmeJfDkLsa8xPmgipA@mail.gmail.com>
In-Reply-To: <CAKwvOdk6=TgL+f2-WvE7tsK0rN1XQ+NdXmeJfDkLsa8xPmgipA@mail.gmail.com>
From:   Andrew Delgadillo <adelg@google.com>
Date:   Thu, 10 Dec 2020 16:10:04 -0800
Message-ID: <CAEHm+vHtMQtMThgE_BwpiBS5v0a61L_TW9vgKLaFTtcgg9HSgA@mail.gmail.com>
Subject: Re: [PATCH] selftests: propagate CC to selftest submakes
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10, 2020 at 3:08 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Dec 3, 2020 at 2:10 PM Andrew Delgadillo <adelg@google.com> wrote:
> >
> > lib.mk defaults to gcc when CC is not set. When building selftests
> > as part of a kernel compilation, MAKEFLAGS is cleared to allow implicit
> > build rules to be used. This has the side-effect of clearing the CC
> > variable, which will cause selftests to be built with gcc regardless of
> > if we are using gcc or clang. To remedy this, propagate the CC variable
> > when clearing makeflags to ensure the correct compiler is used.
> >
> > Signed-off-by: Andrew Delgadillo <adelg@google.com>
>
> Hi Andrew, thanks for the patch. Can you walk me through how to build
> the selftests?
>
> Documentation/dev-tools/kselftest.rst says:
> $ make -C tools/testing/selftests
>
> And if I do:
> $ make CC=clang defconfig
> $ make CC=clang -C tools/testing/selftests -j
>
> I observe a spew of errors.  If I apply your patch and rerun the
> above, I see what looks like the same spew of errors.  Am I "holding
> it wrong" or could the docs use a refresh?
>

Hi Nick, sure thing!

I also see a slew of errors when building with make -C
tools/testing/selftests. However, that is not the problem I am trying
to solve. I believe we are seeing errors building that way because it
is missing some make variables that are normally set up when building
from the kernel's top level makefile.

From https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html:
    To build and run tests with a single command, use:
        $ make kselftest

To illustrate what I am to fix, one can follow these steps:

Without patch:
$ cd kernel_root
$ make mrproper # Start fresh
$ make defconfig
$ make kselftest V=1 |& tee out1

At this point inspecting out1 will show that gcc is being used as the compiler.
Let's try to set it to clang.

$ make mrproper
$ make defconfig
$ make kselftest V=1 CC=clang |& tee out2

Inspecting out2 shows that clang is not used, but rather gcc. You will
get a similar result if you substitute CC=clang for LLVM=1.
We can verify that the CC variable is not properly propagated to the
submakes with the following addition to
tools/testing/selftests/android/Makefile's all recipe (this is the
first submake run):
...
all:
        echo "My CC compiler is $(CC)" && false
...

Following the above steps again will echo "My CC compiler is gcc" both
times, despite setting CC=clang in the second run. After applying my
patch, the CC variable will be properly propagated. The reason it was
not propagated properly in the first place is that we clear MAKEFLAGS
if implicit build rules are disabled (top level Makefile disables
them, but selftests need), which has the side effect of unsetting the
CC variable. Selftest's lib.mk defaults to gcc when CC is not set,
which is why we see CC=gcc even when we set CC=clang on the
commandline.

While this is not a problem if building with make -C
tools/testing/selftests/Makefile, it does present a problem for those
who build with the top level makefile like "make kselftest" or "make
vmlinux kselftest". One reason for doing it the second way is that
using the top level Makefile allows one to use flags like "LLVM=1".

> > ---
> >  tools/testing/selftests/Makefile | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> > index d9c283503159..a4dd6d7e8276 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -90,10 +90,12 @@ FORCE_TARGETS ?=
> >
> >  # Clear LDFLAGS and MAKEFLAGS when implicit rules are missing.  This provides
> >  # implicit rules to sub-test Makefiles which avoids build failures in test
> > -# Makefile that don't have explicit build rules.
> > +# Makefile that don't have explicit build rules. Since lib.mk defaults to
> > +# using gcc for compilation when the CC variable is not set, we propagate the
> > +# CC variable so if clang is being used, selftests will build with clang.
> >  ifeq (,$(LINK.c))
> >  override LDFLAGS =
> > -override MAKEFLAGS =
> > +override MAKEFLAGS = CC=$(CC)
> >  endif
> >
> >  # Append kselftest to KBUILD_OUTPUT and O to avoid cluttering
> > --
> > 2.29.2.576.ga3fc446d84-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
