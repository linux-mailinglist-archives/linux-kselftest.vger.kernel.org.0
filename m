Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8773C1731AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2020 08:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgB1HWn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Feb 2020 02:22:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36838 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgB1HWn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Feb 2020 02:22:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so903187plm.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2020 23:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3S+hpLp5sIHa629tQ1zsw+Nl29dkCf3S5rCd+p6od0=;
        b=DqCPFLqaEV3M2s53qW4elKNy8mZ/LySa/GTkoXsaZ38GB0BNEZFMAuIuyfxvFtj/fV
         1g3uI/JWkqGyNoLF4Jt3NsTHuDB+RMx/j7XseHQMBe/Fo4TDmtC3fAXKshQbQFlO4I6m
         cfAb+BHfSIpKCiRExZ/REITPXUg8Ahf6KlY7hUZxYCbDUAGHkv2zb27FSz1461MYHIde
         Wq8p2AhQjWWTUZiXgUSLT2DwWlAOjA4gGIOkWQmdNpR/flJG4LDdvW+y9oOf02bqCy7e
         u7AnfPxh6Lw4KW1xH4BwHLfqkTQUps9lJ6oIgi+BkaAHfCRgVIu3ZC9L0DtHvm+sZdef
         AsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3S+hpLp5sIHa629tQ1zsw+Nl29dkCf3S5rCd+p6od0=;
        b=jjdGIFrtEjnBIwkgxKyxXTOyu1xpUsqcOsNqQwNb7fhQBova6CaMPiyxBVT/9pEFzt
         712l/eFTpL+qCuH6iwOhhBs/SjDxsuiaS3f0Iyj/f5d4j7Xt/vG+P/JoFmMQIUQKgoyM
         D7w0ewljY0tBfbtucZOCjp5PZNlt+da/uTia4r/VQhaa6dmLhd7FAe1hzuoGONGIcnOy
         m5B41ztftMzIe6aZ4zSUOxC3EgLbYnADWDt2YXnN9rnPHBviibxawhnIXTfcnPxI3Y7w
         2oHty2sT0AC+gZa+MWwQ6NTL7GClwOE4r1a6eFtb3LMRuL/v1nfoQxx1FPtKlo7u5Wqx
         2q7g==
X-Gm-Message-State: APjAAAUnJILqSIUu+8DrhHoPGkTPEnlwRB/nofBg/Y7RrJ4RQtdBtYjj
        OGX46x+MrQF0z68tBvClz+dZr7vja3SUeJSml+rnEA==
X-Google-Smtp-Source: APXvYqzfHO2LjscgalGnPNvJuZJRHFvR5JKj+K4ArJrMoTSjQKwCXbbVKSMib1WlxPMb5cTcx8UR195T8BgeHwMobFY=
X-Received: by 2002:a17:902:8ec1:: with SMTP id x1mr2808157plo.325.1582874562327;
 Thu, 27 Feb 2020 23:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20200228012036.15682-1-brendanhiggins@google.com> <20200228012036.15682-2-brendanhiggins@google.com>
In-Reply-To: <20200228012036.15682-2-brendanhiggins@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 27 Feb 2020 23:22:31 -0800
Message-ID: <CAFd5g46dVaV18=5mPLTHh06KQ6nDh4Xw4r8PAZDfSXASi=Qpmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] vmlinux.lds.h: add linker section for KUnit test suites
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 27, 2020 at 5:20 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Add a linker section where KUnit can put references to its test suites.
> This patch is the first step in transitioning to dispatching all KUnit
> tests from a centralized executor rather than having each as its own
> separate late_initcall.
>
> Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e00f41aa8ec4f..99a866f49cb3d 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -856,6 +856,13 @@
>                 KEEP(*(.con_initcall.init))                             \
>                 __con_initcall_end = .;
>
> +/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
> +#define KUNIT_TEST_SUITES                                              \
> +               . = ALIGN(8);                                           \

After posting this, I saw I had gotten an email from 0day[1]. After
some investigation, I discovered that this 8 byte alignment works for
x86 64 bit fine, but only *sometimes* for 32 bit. 4 byte alignment
seems to work in all cases (so far). I am not sure why we went with
such a large alignment in hindsight. In any case, I should have a
fixed revision out pretty soon.

> +               __kunit_suites_start = .;                               \
> +               KEEP(*(.kunit_test_suites))                             \
> +               __kunit_suites_end = .;
> +
>  #ifdef CONFIG_BLK_DEV_INITRD
>  #define INIT_RAM_FS                                                    \
>         . = ALIGN(4);                                                   \
> @@ -1024,6 +1031,7 @@
>                 INIT_CALLS                                              \
>                 CON_INITCALL                                            \
>                 INIT_RAM_FS                                             \
> +               KUNIT_TEST_SUITES                                       \
>         }
>
>  #define BSS_SECTION(sbss_align, bss_align, stop_align)                 \
> --

[1] https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/4I4UW4OAT63ETMIEUJQTOF3BFTMO6ROD/
