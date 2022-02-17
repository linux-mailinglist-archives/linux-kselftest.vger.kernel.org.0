Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070724B9631
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 03:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiBQC7z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Feb 2022 21:59:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiBQC7z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Feb 2022 21:59:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA69C1FFF5F
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Feb 2022 18:59:41 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so2964280wmq.3
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Feb 2022 18:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kn/LDmM7Giwjd+26mVkordTjd0rTELciFT9tMQUQryk=;
        b=dWYR8YZqLKZ1D9hrocyg1i5E9iNSh/XcwYZebZxs9WfuI9Sl7AygXFIFYUMFUXqIJh
         pPbd8D/CkRFc8HH/K545+Tbh/NYjfFaULbpvsJE+48r5suK21FhMQr600kF6cpiEOcEZ
         hIq/U2UIY81GUxg6sSz98GnrqGo+D6i0eHGQCce1Fw5LHFFvWaF0i7THTe8T7j5pukIU
         wx150gJpCocGcbtZ+MKWyC4ROneXRgDrLmnESdpsdJEV6BnA2CCco2PnLFTqEeB7Tzxt
         ynRfxGJ0bhcYRWmGKDxdm0AvrAOVx0wdS8lF/7V/pL6d/3usyVZpzwUd9RQwMzZvOZS9
         5AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kn/LDmM7Giwjd+26mVkordTjd0rTELciFT9tMQUQryk=;
        b=2ysAJou5E3V4Ws7mjcwVcQ7+5F+MiIE1mUtisfFoL0aG6As6WQjW0wXfYT4x+XQXBb
         h54oMBsXTlhHzUeDWadM00GwhZn4BFVbwujY3MISXO41nfPry2rQzxe9KcnigeP9sE6P
         D91DjXUOZHaFYTqz7Vl2JhTLO1AUm5dqi8nJqDfmu9076U4hai7b+Zq4JpPb0y/8s6RS
         1OC8pnSd2bIM1gKvV8GSB0vdNtEJZ/8fgpT0qMr+MnFdik1tmPxsOxccdNG7I4GyvJPd
         79LZsEQbPEwZt4oejdK/4yKpICiBl/SeG9D/o3nltbdIJuCwUZZs4HmfO84RZ5x/12xI
         ncww==
X-Gm-Message-State: AOAM532pdHpiSs4FhgPlN3ONRkDmwWjupxsNLZMZ8p9Fyrig4EzPHSCO
        jYNh/UmFDlwsH6uGyfwBLeRbyHMYszG4Ab3H82TYww==
X-Google-Smtp-Source: ABdhPJxsqZZCrzn79f6VaiQDnruwqgTNUuolyn2u2fWhw0sOJzG8OE9y9rTC7L0UD/I193BapB+nkoPAnfmCl744MM0=
X-Received: by 2002:a05:600c:1da4:b0:37c:729:f84d with SMTP id
 p36-20020a05600c1da400b0037c0729f84dmr4139433wms.131.1645066779319; Wed, 16
 Feb 2022 18:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20220217002843.2312603-1-keescook@chromium.org>
In-Reply-To: <20220217002843.2312603-1-keescook@chromium.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 17 Feb 2022 10:59:27 +0800
Message-ID: <CABVgOSk=oFxsbSbQE-v65VwR2+mXeGXDDjzq8t7FShwjJ3+kUg@mail.gmail.com>
Subject: Re: [PATCH] um: Allow builds with Clang
To:     Kees Cook <keescook@chromium.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kbuild@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        llvm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 17, 2022 at 8:28 AM Kees Cook <keescook@chromium.org> wrote:
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

Thanks, this worked fine for me, with one small note:

I get the following warning with clang (13.0.1) under UML (but not
under x86_64):
clang: warning: argument unused during compilation:
'-mno-global-merge' [-Wunused-command-line-argument]

It's not really a problem unless -Werror is enabled, though, so this
is still definitely an improvement over clang not working at all.

With that caveat, this is:
Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David

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
>  CLANG_TARGET_FLAGS             := $(CLANG_TARGET_FLAGS_$(SRCARCH))
>
>  ifeq ($(CROSS_COMPILE),)
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220217002843.2312603-1-keescook%40chromium.org.
