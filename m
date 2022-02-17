Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57AE4B97FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 06:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiBQFD6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 00:03:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiBQFD5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 00:03:57 -0500
X-Greylist: delayed 276 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 21:03:41 PST
Received: from condef-04.nifty.com (condef-04.nifty.com [202.248.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B16618C2DF;
        Wed, 16 Feb 2022 21:03:40 -0800 (PST)
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-04.nifty.com with ESMTP id 21H4txCj031587;
        Thu, 17 Feb 2022 13:55:59 +0900
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 21H4tb7b030427;
        Thu, 17 Feb 2022 13:55:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 21H4tb7b030427
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645073738;
        bh=XT+hixO3OHzRLvB8+uXJ8rcVlX1aTroBtBRh2n+1zQY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y7dYjnFd4wsC3TTZW1BdEoNjB4sXAHPx0oJ8ABx+P0g3nx4tKIj8RHnGp5PTqxZxP
         F/NwszPL7gcDNXn8C95gahpJKOuhawN36TQNiyqpII8iJ7j1obZhq9H1Jm8mU4AoDo
         tYEsoc19rtHNgG0UMiUzgfJi6rdU5DmfXuNc6rgFuhRYpHfhA52pBSeYa4fofhQDYN
         ARoDDn05/6oJ8613UFpkQwaDNAV3QbUGSNTBVmLB+VEJ/3eyMmAXbAvyCJOZ4ZvD2i
         sKEiwUEm3utUkypeph7bZ8SWyRkIahSFZHZrsY4kepFKduHoMAgcYGBF7Vz4YdhaHP
         qCnjo7q5wYCSQ==
X-Nifty-SrcIP: [209.85.216.43]
Received: by mail-pj1-f43.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso5284343pjb.1;
        Wed, 16 Feb 2022 20:55:37 -0800 (PST)
X-Gm-Message-State: AOAM533LyphR5LuoChSI1L6v+i1cwCPDBAuuII6YV7H09qcfrQ7TkJV3
        ShZ+OC17RNuDYpHam+P0DZCUBnvvY/L5IuGNDW4=
X-Google-Smtp-Source: ABdhPJxFswrX5ZhULOVqkkTeNUddZz5GKFlBSh38FlNOFO45DNJA/a61t3Ziez+i+J+9QUNCxhaseXwszlPu87Vxsso=
X-Received: by 2002:a17:902:e8d7:b0:149:3b5d:2b8b with SMTP id
 v23-20020a170902e8d700b001493b5d2b8bmr1173473plg.162.1645073737215; Wed, 16
 Feb 2022 20:55:37 -0800 (PST)
MIME-Version: 1.0
References: <20220217002843.2312603-1-keescook@chromium.org>
In-Reply-To: <20220217002843.2312603-1-keescook@chromium.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 17 Feb 2022 13:54:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNASMobjuAen+_O4eFOgkOoUwf5ANk6_TjL4SdtT47Jge-w@mail.gmail.com>
Message-ID: <CAK7LNASMobjuAen+_O4eFOgkOoUwf5ANk6_TjL4SdtT47Jge-w@mail.gmail.com>
Subject: Re: [PATCH] um: Allow builds with Clang
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

On Thu, Feb 17, 2022 at 9:28 AM Kees Cook <keescook@chromium.org> wrote:
>
> Add x86-64 target for Clang+um and update user-offsets.c to use
> Clang-friendly assembler, similar to the fix from commit cf0c3e68aa81
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
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/um/user-offsets.c | 4 ++--
>  scripts/Makefile.clang     | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
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
>
>  #define DEFINE_LONGS(sym, val) \
> -       asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
> +       asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val/sizeof(unsigned long)))
>
>  void foo(void)
>  {
> diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> index 51fc23e2e9e5..857b23de51c6 100644
> --- a/scripts/Makefile.clang
> +++ b/scripts/Makefile.clang
> @@ -10,6 +10,7 @@ CLANG_TARGET_FLAGS_powerpc    := powerpc64le-linux-gnu
>  CLANG_TARGET_FLAGS_riscv       := riscv64-linux-gnu
>  CLANG_TARGET_FLAGS_s390                := s390x-linux-gnu
>  CLANG_TARGET_FLAGS_x86         := x86_64-linux-gnu
> +CLANG_TARGET_FLAGS_um          := x86_64-linux-gnu


Does this work for the i386 host?

UML supports i386 and x86_64 as the host architecture as of now,
but this always compiles UML for x86_64?







>  CLANG_TARGET_FLAGS             := $(CLANG_TARGET_FLAGS_$(SRCARCH))
>
>  ifeq ($(CROSS_COMPILE),)
> --
> 2.30.2
>


-- 
Best Regards
Masahiro Yamada
