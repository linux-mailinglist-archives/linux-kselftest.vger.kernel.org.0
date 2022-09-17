Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0985BB758
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Sep 2022 10:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIQI5p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Sep 2022 04:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIQI5p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Sep 2022 04:57:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C32357D5
        for <linux-kselftest@vger.kernel.org>; Sat, 17 Sep 2022 01:57:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D43AB80C85
        for <linux-kselftest@vger.kernel.org>; Sat, 17 Sep 2022 08:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0CCC43141
        for <linux-kselftest@vger.kernel.org>; Sat, 17 Sep 2022 08:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663405060;
        bh=f3slc4i9BYX5T9bjmWc1W8M30gcMk6SgVO5v7uCsOG4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qzrKZAxT8kjbjTev6ieIzRpxN0KnSYywMKsWjp7RW8ytVhamz8lmgIcWw2nvn4EX/
         LAf278dfGcctTT8fcV8eiAGgYsXD06LZG5nX6BJbeabyYVrI/fi5qQ9Vv1OFuXpn1V
         USq97a28C7QRdXaafDvNjQJXmR/k5e6tTDtolx7boaYJR1eh4+DONDiWyFUXRhdb6M
         KI0U4kJw8MxmM1XD1uzOiVBLOF1fTLicl64Fkm5bhyAJmFMONwdVmNrNT8cnL9V63L
         /ESi/aminhz93tVQt7H4ewvNrsKfJ7wrlpcPhdcs4sUYMjc5Cw60APMh7xoLljgyGn
         jJt6yR9cqFzpg==
Received: by mail-vs1-f41.google.com with SMTP id h1so24987350vsr.11
        for <linux-kselftest@vger.kernel.org>; Sat, 17 Sep 2022 01:57:40 -0700 (PDT)
X-Gm-Message-State: ACrzQf1nwjCG0j9ny339qsbzUQmMBZtpcapWzD66BwWUYcuEhmcCHQrZ
        RoftUKAnsdKhV2JJGup2xHpXzmS/eoMA9EnZRsI=
X-Google-Smtp-Source: AMsMyM6slZBp83XRzKzz4BqTO6KyzJF4vLne1cUbZg89vPxp4wwbRsOA/XqmgO14SVdYK6HbZWwYpV0SSYLUTwQu/ao=
X-Received: by 2002:a05:6102:1481:b0:39a:67f5:3096 with SMTP id
 d1-20020a056102148100b0039a67f53096mr3362686vsv.70.1663405059677; Sat, 17 Sep
 2022 01:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220903095507.3425208-1-chenhuacai@loongson.cn>
In-Reply-To: <20220903095507.3425208-1-chenhuacai@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 17 Sep 2022 16:57:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Rn0vQpD5PA8iGHPHLYw1tReNzQM4dps9YoK=u7YNY3Q@mail.gmail.com>
Message-ID: <CAAhV-H4Rn0vQpD5PA8iGHPHLYw1tReNzQM4dps9YoK=u7YNY3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools: Add LoongArch build infrastructure
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, loongarch@lists.linux.dev,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Ping?

On Sat, Sep 3, 2022 at 5:55 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> We will add tools support for LoongArch (bpf, perf, objtool, etc.), add
> build infrastructure and common headers for preparation.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  tools/arch/loongarch/include/uapi/asm/bitsperlong.h |  9 +++++++++
>  tools/scripts/Makefile.arch                         | 11 ++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
>  create mode 100644 tools/arch/loongarch/include/uapi/asm/bitsperlong.h
>
> diff --git a/tools/arch/loongarch/include/uapi/asm/bitsperlong.h b/tools/arch/loongarch/include/uapi/asm/bitsperlong.h
> new file mode 100644
> index 000000000000..d4e32b3d4843
> --- /dev/null
> +++ b/tools/arch/loongarch/include/uapi/asm/bitsperlong.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef __ASM_LOONGARCH_BITSPERLONG_H
> +#define __ASM_LOONGARCH_BITSPERLONG_H
> +
> +#define __BITS_PER_LONG (__SIZEOF_POINTER__ * 8)
> +
> +#include <asm-generic/bitsperlong.h>
> +
> +#endif /* __ASM_LOONGARCH_BITSPERLONG_H */
> diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
> index 0c6c7f456887..1c72d07cb9fe 100644
> --- a/tools/scripts/Makefile.arch
> +++ b/tools/scripts/Makefile.arch
> @@ -5,7 +5,7 @@ HOSTARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
>                                    -e s/s390x/s390/ -e s/parisc64/parisc/ \
>                                    -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
>                                    -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
> -                                  -e s/riscv.*/riscv/)
> +                                  -e s/riscv.*/riscv/ -e s/loongarch.*/loongarch/)
>
>  ifndef ARCH
>  ARCH := $(HOSTARCH)
> @@ -34,6 +34,15 @@ ifeq ($(ARCH),sh64)
>         SRCARCH := sh
>  endif
>
> +# Additional ARCH settings for loongarch
> +ifeq ($(ARCH),loongarch32)
> +       SRCARCH := loongarch
> +endif
> +
> +ifeq ($(ARCH),loongarch64)
> +       SRCARCH := loongarch
> +endif
> +
>  LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
>  ifeq ($(LP64), 1)
>    IS_64_BIT := 1
> --
> 2.31.1
>
>
