Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD364BAF90
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 03:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiBRCU4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 21:20:56 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiBRCU4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 21:20:56 -0500
X-Greylist: delayed 77082 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 18:20:39 PST
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7579B7DF;
        Thu, 17 Feb 2022 18:20:39 -0800 (PST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 21I2KCNZ023307;
        Fri, 18 Feb 2022 11:20:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 21I2KCNZ023307
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645150813;
        bh=oTkWcaEf9jnFVKJN3p9Suk7c1bsGL0A3lknSj12v+7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VDAcoaHNdUsbQLowZjruNwVk9mblUqzQo6ITBxcrlZY8Ma44uNYNxVO5bNPVUCt+s
         1teshno3NGiIKYkFuxIqTE0lp2tDvcQM2/1aF7ViyKuPrSAJFg+YOvDu+3AbP9ieD4
         yNqvtGdNJ8EtKFAKV9jJBMfgfVWBSsjS7I1WlME1f48bRfvOd4wHHbwn01MtauNIUD
         FtWmkSBFYZpHKMZrFB3LjAfxv+RVB03iP0e6bV53GYDMLjTxlNEG32ibk4c0THVeFp
         T8pWE/bPL4ppW9+sbjsdjMlTrKurERvsQgFE80ws1vcqbHBT5DiN3vR1SAn3g47+qu
         wVt93TczYyScQ==
X-Nifty-SrcIP: [209.85.216.54]
Received: by mail-pj1-f54.google.com with SMTP id m7so7385863pjk.0;
        Thu, 17 Feb 2022 18:20:12 -0800 (PST)
X-Gm-Message-State: AOAM532xze/2D0u2/mAzCrqinu/8uz3wvXcanIZcpWiSKN03YT5fLUkz
        MS6ObeFWqAusMwQEJtY/UdgQ6n2UkntUsjj/Gz8=
X-Google-Smtp-Source: ABdhPJy36VTNx/GOTLfwWDr/Q6D5q1UHnWRQBNMl4BqD+jlNw2u9WpWNKjA00Rdwo2aBqEiQuiXaVDyH9pWT8wCO1AY=
X-Received: by 2002:a17:90a:ab17:b0:1b9:b61a:aadb with SMTP id
 m23-20020a17090aab1700b001b9b61aaadbmr6008892pjq.77.1645150811855; Thu, 17
 Feb 2022 18:20:11 -0800 (PST)
MIME-Version: 1.0
References: <20220217002843.2312603-1-keescook@chromium.org>
 <CAK7LNASMobjuAen+_O4eFOgkOoUwf5ANk6_TjL4SdtT47Jge-w@mail.gmail.com> <Yg6I0YZAh5yWYpT2@dev-arch.archlinux-ax161>
In-Reply-To: <Yg6I0YZAh5yWYpT2@dev-arch.archlinux-ax161>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 18 Feb 2022 11:19:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNARbP_xxc21N4VO95RQNn5MzGW2HpKxS_vxNWy4mqP+GxA@mail.gmail.com>
Message-ID: <CAK7LNARbP_xxc21N4VO95RQNn5MzGW2HpKxS_vxNWy4mqP+GxA@mail.gmail.com>
Subject: Re: [PATCH] um: Allow builds with Clang
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        llvm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 18, 2022 at 2:41 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Feb 17, 2022 at 01:54:58PM +0900, Masahiro Yamada wrote:
> > On Thu, Feb 17, 2022 at 9:28 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Add x86-64 target for Clang+um and update user-offsets.c to use
> > > Clang-friendly assembler, similar to the fix from commit cf0c3e68aa81
> > > ("kbuild: fix asm-offset generation to work with clang").
> > >
> > > This lets me run KUnit tests with Clang:
> > >
> > > $ ./tools/testing/kunit/kunit.py config --make_options LLVM=1
> > > ...
> > > $ ./tools/testing/kunit/kunit.py run --make_options LLVM=1
> > > ...
> > >
> > > Cc: Jeff Dike <jdike@addtoit.com>
> > > Cc: Richard Weinberger <richard@nod.at>
> > > Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > Cc: David Gow <davidgow@google.com>
> > > Cc: linux-um@lists.infradead.org
> > > Cc: linux-kbuild@vger.kernel.org
> > > Cc: linux-kselftest@vger.kernel.org
> > > Cc: kunit-dev@googlegroups.com
> > > Cc: llvm@lists.linux.dev
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  arch/x86/um/user-offsets.c | 4 ++--
> > >  scripts/Makefile.clang     | 1 +
> > >  2 files changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
> > > index bae61554abcc..d9071827b515 100644
> > > --- a/arch/x86/um/user-offsets.c
> > > +++ b/arch/x86/um/user-offsets.c
> > > @@ -10,10 +10,10 @@
> > >  #include <asm/types.h>
> > >
> > >  #define DEFINE(sym, val) \
> > > -       asm volatile("\n->" #sym " %0 " #val : : "i" (val))
> > > +       asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val))
> > >
> > >  #define DEFINE_LONGS(sym, val) \
> > > -       asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
> > > +       asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val/sizeof(unsigned long)))
> > >
> > >  void foo(void)
> > >  {
> > > diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> > > index 51fc23e2e9e5..857b23de51c6 100644
> > > --- a/scripts/Makefile.clang
> > > +++ b/scripts/Makefile.clang
> > > @@ -10,6 +10,7 @@ CLANG_TARGET_FLAGS_powerpc    := powerpc64le-linux-gnu
> > >  CLANG_TARGET_FLAGS_riscv       := riscv64-linux-gnu
> > >  CLANG_TARGET_FLAGS_s390                := s390x-linux-gnu
> > >  CLANG_TARGET_FLAGS_x86         := x86_64-linux-gnu
> > > +CLANG_TARGET_FLAGS_um          := x86_64-linux-gnu
> >
> >
> > Does this work for the i386 host?
> >
> > UML supports i386 and x86_64 as the host architecture as of now,
> > but this always compiles UML for x86_64?
>
> I think the current code will work because arch/x86/Makefile.um includes
> -m32 for CONFIG_X86_32, which will implicitly change x86_64-linux-gnu
> into a 32-bit target triple:

Ah, you are right!


>
> $ echo | clang --target=x86_64-linux-gnu -x c -c -o test.o -
>
> $ file test.o
> test.o: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), not stripped
>
> $ echo | clang --target=x86_64-linux-gnu -m32 -x c -c -o test.o -
>
> $ file test.o
> test.o: ELF 32-bit LSB relocatable, Intel 80386, version 1 (SYSV), not stripped
>
> In fact, we rely on this for ARCH=i386 LLVM=1 right now, as it uses
> x86_64-linux-gnu for the target flag.
>
> While UML only supports x86, maybe it is worth using SUBARCH instead of
> hardcoding the triple? No strong opinion around that though.
>
> diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> index 51fc23e2e9e5..87285b76adb2 100644
> --- a/scripts/Makefile.clang
> +++ b/scripts/Makefile.clang
> @@ -10,6 +10,7 @@ CLANG_TARGET_FLAGS_powerpc    := powerpc64le-linux-gnu
>  CLANG_TARGET_FLAGS_riscv       := riscv64-linux-gnu
>  CLANG_TARGET_FLAGS_s390                := s390x-linux-gnu
>  CLANG_TARGET_FLAGS_x86         := x86_64-linux-gnu
> +CLANG_TARGET_FLAGS_um          := $(CLANG_TARGET_FLAGS_$(SUBARCH))


LGTM.

I also thought of not passing --target at all for ARCH=um, but
we decided to override --target all the time (for reproducibility?).
Anyway, Nathan's way is clean, and looks OK to me.







>  CLANG_TARGET_FLAGS             := $(CLANG_TARGET_FLAGS_$(SRCARCH))
>
>  ifeq ($(CROSS_COMPILE),)
>
> > >  CLANG_TARGET_FLAGS             := $(CLANG_TARGET_FLAGS_$(SRCARCH))
> > >
> > >  ifeq ($(CROSS_COMPILE),)
> > > --
> > > 2.30.2
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada



--
Best Regards
Masahiro Yamada
