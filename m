Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF124D0746
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Mar 2022 20:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbiCGTJk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Mar 2022 14:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbiCGTJj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Mar 2022 14:09:39 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C65419C37
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Mar 2022 11:08:44 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id r20so21937142ljj.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Mar 2022 11:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqdFcj/W3ROtaaLGNZJbzsf9vyM2NVPkSBm3INx+BLs=;
        b=rfR0JcG6nuRaVIkXXgGAegektp5HSFDVUF91VlM0HcyOauIq6tLbs7wauxENXC0btb
         p8y1dXe10FP3m4bn7GIwnpvC6FX6LCWi8n0s3OsVBh5zR2vtqauwBqooPEyXFXPwsIXI
         62bdrmK25fNTgDZg8wJzs40LnOGNLG1en3+O2YHwTaLzbIVSg/0cJQFsDDU6mwqDgdRq
         8VIfwpxBj8u6NEY7gT9YpRSH4XlxawGUuOk2T4WsVMqRa405CTVD4rzPmUfb9jJIWnOH
         v5czkolhWUGk6Kk7sv9Vye1CuebzWG4LHHYshIxfssyFSMc2MP+BlO+5ww1BiNEr34zx
         gkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqdFcj/W3ROtaaLGNZJbzsf9vyM2NVPkSBm3INx+BLs=;
        b=V3OvRdfy35vSWX5pOpYmyEkiGClNkmRv9hjw89XJY0QyKoEBO9h27gRipIVudIf0di
         DWAMAaBYik6EGYrOlHXbA4KaDT45InpDHt7vTiwI7aqrdc4gnVYeSi6zlWnPjmGI+PRw
         daO6Y+9+3rUxiU0RXVmlHXZWwOWvtsZQjyrB4oqgzf/K8e51VpeJOUf+bB5DVXeMtPol
         pADrWKEGVBLOK3V/Gi8gEIJlsxvAyrTEY7zUeGa8uq2mQAJ2NDD7p9Y6pYBvf1ih3WmX
         yZTZGquQVXB2XCuKSwoqh0+30+ypnuM8JhhHclZiR9Z4GjA4MxfiRCQugemWrifINvd6
         iJqA==
X-Gm-Message-State: AOAM531M462am/p7eUgRkCu2fpkzxOCTXxlAQdcrwAg8mL+Gq2NBp/2X
        fH3H7KZJq++6NMYXqnEMI3W7a2EjNEbM4yJP33prDQ==
X-Google-Smtp-Source: ABdhPJxUEH+WXE4ZEDL3yAUMLDOBvQpg4ljCyCYbedmFgU3xFcH283DgaImI8yUXP7kHpdQV2ZWAnn0IBgfQDPiwNxM=
X-Received: by 2002:a05:651c:1542:b0:233:8ff5:eb80 with SMTP id
 y2-20020a05651c154200b002338ff5eb80mr8416360ljp.352.1646680120998; Mon, 07
 Mar 2022 11:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20220304170813.1689186-1-nathan@kernel.org>
In-Reply-To: <20220304170813.1689186-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Mar 2022 11:08:29 -0800
Message-ID: <CAKwvOd=Q-7vPaRPj1wQagFsY3txcAKzrqU_D2UAX3h4ym91uUA@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Make $(LLVM) more flexible
To:     Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        llvm@lists.linux.dev, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 4, 2022 at 9:14 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
> index d32616891dcf..68b74416ec48 100644
> --- a/Documentation/kbuild/llvm.rst
> +++ b/Documentation/kbuild/llvm.rst
> @@ -49,17 +49,36 @@ example: ::
>  LLVM Utilities
>  --------------
>
> -LLVM has substitutes for GNU binutils utilities. Kbuild supports ``LLVM=1``
> -to enable them. ::
> -
> -       make LLVM=1
> -
> -They can be enabled individually. The full list of the parameters: ::
> +LLVM has substitutes for GNU binutils utilities. They can be enabled individually.
> +The full list of supported make variables: ::
>
>         make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
>           OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
>           HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld
>
> +To simplify the above command, Kbuild supports the ``LLVM`` variable: ::
> +
> +       make LLVM=1
> +
> +If your LLVM tools are not available in your PATH, you can supply their
> +location using the LLVM variable with a trailing slash: ::
> +
> +       make LLVM=/path/to/llvm/
> +
> +which will use ``/path/to/llvm/clang``, ``/path/to/llvm/ld.lld``, etc.

I don't think we should do this; `PATH=/path/to/llvm/ make LLVM=1`
works and (my interpretation of what) Masahiro said "if anyone asks
for this, here's how we could do that."  I don't think I've seen an
explicit ask for that. I'd rather LLVM= have 2 behaviors than 3, but I
won't hold this patch up over that.  Either way:

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> +
> +If your LLVM tools have a version suffix and you want to test with that
> +explicit version rather than the unsuffixed executables like ``LLVM=1``, you
> +can pass the suffix using the ``LLVM`` variable: ::
> +
> +       make LLVM=-14
> +
> +which will use ``clang-14``, ``ld.lld-14``, etc.
> +
> +``LLVM=0`` is not the same as omitting ``LLVM`` altogether, it will behave like
> +``LLVM=1``.

Hmm... I can see someone's build wrappers setting LLVM=1, then them
being surprised that appending LLVM=0 doesn't disable LLVM=1 as they
might expect.  But Masahiro says let's fix this later which is fine.

--
Thanks,
~Nick Desaulniers
