Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1B4342362
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 18:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhCSR3t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 13:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhCSR3o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 13:29:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A720C06174A
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Mar 2021 10:29:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q29so11088678lfb.4
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Mar 2021 10:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tvHhezgm6LLrHkw6LiFzJkS2cxMTL9fEuJKrvKkiKUQ=;
        b=qxS40zfHoppJ4w1lAzxDUZz14akR+3ew9ZSSFoJXHxNFw1LVt1bz/DmDYKQBrI35Te
         eaRTyqZWelaZH0wZgpff2VPb4Ed6mjOVVxc14NXlZbFkTQpp94o+dmwpB6228UBHBwBh
         kL+TsgwdDnlkZR1RwFOI/uytBecNjPKS8SPVK1UytrDqn7F3FVpuEMb15EIvTucYDQqy
         8gpvccbxZ9p8+YrBPogXC4G/zmqng4gzbyT78DcjLlqk/UJwfusuijmbneZywzX81xq+
         WxPKJQWO4dr6l0gDDrdf9e0uJ21NvIuYU9sZLHRJdAfUSzL/A9ExU8DyvTvq1Fk0ttMj
         Iblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvHhezgm6LLrHkw6LiFzJkS2cxMTL9fEuJKrvKkiKUQ=;
        b=NesYthyiWY5lyELesXfKm9ZLaWY+VFgmc9WlH9xEJuxJ8TYV9GGcmfpld1bGNwRr1q
         0ptgqFdfbHmffabPh3arhrKE9bOTyAmpKmjgVtnp5ZYzYj7qJykIN3LSQ63SgOKJGeh0
         EJ4d3QhWVz4lPvZz8H2ogFIIzU1N/g0Ob4IcB0AxQUO7QnJP6NNB++pWeIRZNwfn7JqZ
         Q+ZfQoBSDOnIrMu+vja63FVTKoXu19JEmi3zvkdE3IxYKmGPpqNZUuT1ZW7c7q5GBe0E
         sLrG2zXpDTuEgezK4yWbXA4CNV3zmKkyNMiql0Q5L6kSKWKqgUMyFRY2rLq6k5xRVcyk
         kMuA==
X-Gm-Message-State: AOAM532ynQxwUmeO8h6oyXSda1Kd2opSHpEUfXHBJTsQW57I2OVA9vie
        mVLEkYwAizJNOybpEwaFsfSydVA5Jec1ybFdV3tJhg==
X-Google-Smtp-Source: ABdhPJzRz1nB+l60pFJwjW9wIy+NAzMWNbWYz5dq7MRdQPPqZStIy1/duwYDcBooz6oxJMlvPl/ekDQJiugt+eiH3Iw=
X-Received: by 2002:ac2:538e:: with SMTP id g14mr1375802lfh.543.1616174982034;
 Fri, 19 Mar 2021 10:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210319165334.29213-1-andre.przywara@arm.com> <20210319165334.29213-2-andre.przywara@arm.com>
In-Reply-To: <20210319165334.29213-2-andre.przywara@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 19 Mar 2021 10:29:30 -0700
Message-ID: <CAKwvOd=GT=dFUS4ihZ3X5_Vne2ZGqag=9zHaW6+wBLEj3jx-GA@mail.gmail.com>
Subject: Re: [PATCH 01/11] kselftest/arm64: mte: Fix compilation with native compiler
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 19, 2021 at 9:53 AM Andre Przywara <andre.przywara@arm.com> wrote:
>
> The mte selftest Makefile contains a check for GCC, to add the memtag
> -march flag to the compiler options. This check fails if the compiler
> is not explicitly specified, so reverts to the standard "cc", in which
> case --version doesn't mention the "gcc" string we match against:
> $ cc --version | head -n 1
> cc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
>
> This will not add the -march switch to the command line, so compilation
> fails:
> mte_helper.S: Assembler messages:
> mte_helper.S:25: Error: selected processor does not support `irg x0,x0,xzr'
> mte_helper.S:38: Error: selected processor does not support `gmi x1,x0,xzr'
> ...
>
> Actually clang accepts the same -march option as well, so we can just
> drop this check and add this unconditionally to the command line, to avoid
> any future issues with this check altogether (gcc actually prints
> basename(argv[0]) when called with --version).
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  tools/testing/selftests/arm64/mte/Makefile | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/testing/selftests/arm64/mte/Makefile b/tools/testing/selftests/arm64/mte/Makefile
> index 0b3af552632a..df15d44aeb8d 100644
> --- a/tools/testing/selftests/arm64/mte/Makefile
> +++ b/tools/testing/selftests/arm64/mte/Makefile
> @@ -6,9 +6,7 @@ SRCS := $(filter-out mte_common_util.c,$(wildcard *.c))
>  PROGS := $(patsubst %.c,%,$(SRCS))
>
>  #Add mte compiler option
> -ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep gcc),)
>  CFLAGS += -march=armv8.5-a+memtag
> -endif
>
>  #check if the compiler works well
>  mte_cc_support := $(shell if ($(CC) $(CFLAGS) -E -x c /dev/null -o /dev/null 2>&1) then echo "1"; fi)
> --
> 2.17.5
>


-- 
Thanks,
~Nick Desaulniers
