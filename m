Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0754C592F
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Feb 2022 04:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiB0D6q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Feb 2022 22:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiB0D6p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Feb 2022 22:58:45 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8FD7938B;
        Sat, 26 Feb 2022 19:58:07 -0800 (PST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 21R3viK9010135;
        Sun, 27 Feb 2022 12:57:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 21R3viK9010135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645934265;
        bh=8vul5cjxHnllEZ9R6kEDpmi+BU/2oY7ZUKtmPcOAiP4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ylAlrzaYHOIz+P1Py/lElRr8Oin5oBV0vItOMGnS7uuc3zxQON2WIpHwNtxYl4fmd
         vVGDSBcQa74Hwki4/sPqgfV/LevdM7JNwTSTrwnTwk7jnMC12I0HA77ucBiz9tqL6L
         DzW/2jrxEDj1RTC0g8HyZuDl0bYkONGuTDuAtvolWGMrq6pMEHeOBaRQMXVDAcoleM
         OHO1pMVcmjXDq6tIKAuK1cP8djpZANPMjXOZTlMnlk2FMwhAeo5Md8qVCa9hBOjMnl
         WISvXpcyCCYqbotUuqb0Ja57LohhiZCAHFK8uicuKJRbIB5ch8B7v2tOe3f3h1IwTP
         GkhlIx9EgqeBQ==
X-Nifty-SrcIP: [209.85.210.175]
Received: by mail-pf1-f175.google.com with SMTP id a5so7260423pfv.9;
        Sat, 26 Feb 2022 19:57:44 -0800 (PST)
X-Gm-Message-State: AOAM533P8cXwi1Jf9vERMrw00EWet5tRjPnZ6xhYL73Bekn8lYM6+mrS
        N4tddRUU+t4CVhpycbENa7/aY1yRnN8Of/QhtCo=
X-Google-Smtp-Source: ABdhPJxjVjGM+x2ubvRA5AcuT0fdFuqGSyU4IS6P8OuiKJceoIpY9wcwxuBtYN0eK7eF+0vaytCJWw4mPryhGf+UpR8=
X-Received: by 2002:a63:1d44:0:b0:373:5612:629b with SMTP id
 d4-20020a631d44000000b003735612629bmr12512970pgm.352.1645934264084; Sat, 26
 Feb 2022 19:57:44 -0800 (PST)
MIME-Version: 1.0
References: <20220224055831.1854786-1-keescook@chromium.org>
In-Reply-To: <20220224055831.1854786-1-keescook@chromium.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 27 Feb 2022 12:57:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQewgWYhioL-kWvgpQCnLeg6vgULbAotU-qi46NDoFw2w@mail.gmail.com>
Message-ID: <CAK7LNAQewgWYhioL-kWvgpQCnLeg6vgULbAotU-qi46NDoFw2w@mail.gmail.com>
Subject: Re: [PATCH v2] um: Allow builds with Clang
To:     Kees Cook <keescook@chromium.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
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

On Thu, Feb 24, 2022 at 2:58 PM Kees Cook <keescook@chromium.org> wrote:
>
> Add x86-64 target for Clang+um and update user-offsets.c to use
> Clang-friendly assembly, similar to the fix from commit cf0c3e68aa81
> ("kbuild: fix asm-offset generation to work with clang").
>
> This lets me run KUnit tests with Clang:
>
> $ ./tools/testing/kunit/kunit.py config --make_options LLVM=1
> ...
> $ ./tools/testing/kunit/kunit.py run --make_options LLVM=1
> ...
>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: David Gow <davidgow@google.com>
> Cc: linux-um@lists.infradead.org
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: llvm@lists.linux.dev
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/lkml/Yg2YubZxvYvx7%2Fnm@dev-arch.archlinux-ax161/
> Tested-by: David Gow <davidgow@google.com>
> Link: https://lore.kernel.org/lkml/CABVgOSk=oFxsbSbQE-v65VwR2+mXeGXDDjzq8t7FShwjJ3+kUg@mail.gmail.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://lore.kernel.org/lkml/20220217002843.2312603-1-keescook@chromium.org/
> v2:
>  - tweak commit log phrasing and alphabetize targets (nathan)
>  - fix a missing implicit fallthrough under 32-bit builds
>  - add review tags
> ---
>  arch/um/os-Linux/execvp.c  | 1 +
>  arch/x86/um/user-offsets.c | 4 ++--
>  scripts/Makefile.clang     | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/um/os-Linux/execvp.c b/arch/um/os-Linux/execvp.c
> index 84a0777c2a45..c09a5fd5e225 100644
> --- a/arch/um/os-Linux/execvp.c
> +++ b/arch/um/os-Linux/execvp.c
> @@ -93,6 +93,7 @@ int execvp_noalloc(char *buf, const char *file, char *const argv[])
>                                            up finding no executable we can use, we want to diagnose
>                                            that we did find one but were denied access.  */
>                                         got_eacces = 1;
> +                                       break;
>                                 case ENOENT:
>                                 case ESTALE:
>                                 case ENOTDIR:
> diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
> index bae61554abcc..d9071827b515 100644
> --- a/arch/x86/um/user-offsets.c
> +++ b/arch/x86/um/user-offsets.c
> @@ -10,10 +10,10 @@
>  #include <asm/types.h>
>
>  #define DEFINE(sym, val) \
> -       asm volatile("\n->" #sym " %0 " #val : : "i" (val))
> +       asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val))


Another way might be  #include <linux/kbuild.h> and delete this macro
definition.


>  #define DEFINE_LONGS(sym, val) \
> -       asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
> +       asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val/sizeof(unsigned long)))


This generates wrong comments.

In include/generated/user_constants.h,
I see this:

   #define HOST_BX 5 /* RBX */

(Here, the value of RBX is 40.)



  #define DEFINE_LONGS(sym, val)     asm volatile("\n.ascii \"->" #sym
" %0 " #val "/sizeof(unsigned long)\"": : "i" (val/sizeof(unsigned
long)))

creates valid comments:

   #define HOST_BX 5 /* RBX/sizeof(unsigned long) */



Another way might be to do this indirectly.

     #define DEFINE_LONGS(sym, val)     DEFINE(sym, val / sizeof(unsigned long))

The comments in include/generated/user_constans.h do not retain
the original macro names, though...







>  void foo(void)
>  {
> diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> index 51fc23e2e9e5..6e49344c6db2 100644
> --- a/scripts/Makefile.clang
> +++ b/scripts/Makefile.clang
> @@ -9,6 +9,7 @@ CLANG_TARGET_FLAGS_mips         := mipsel-linux-gnu
>  CLANG_TARGET_FLAGS_powerpc     := powerpc64le-linux-gnu
>  CLANG_TARGET_FLAGS_riscv       := riscv64-linux-gnu
>  CLANG_TARGET_FLAGS_s390                := s390x-linux-gnu
> +CLANG_TARGET_FLAGS_um          := x86_64-linux-gnu


Personally, I like Nathan's idea, but we can live with the hard-coding
since we see no efforts for UML on other host arch.




>  CLANG_TARGET_FLAGS_x86         := x86_64-linux-gnu
>  CLANG_TARGET_FLAGS             := $(CLANG_TARGET_FLAGS_$(SRCARCH))
>
> --
> 2.30.2
>


-- 
Best Regards
Masahiro Yamada
