Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECA1446986
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Nov 2021 21:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhKEUUI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Nov 2021 16:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhKEUUH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Nov 2021 16:20:07 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA7C061714
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Nov 2021 13:17:27 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y8so16877151ljm.4
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Nov 2021 13:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vuayPgK0AFa+ecEYX+ZQ8vgmFv5JEOwxSTm6d2kZs78=;
        b=RnLKexsrCAjWUIWwBZJfog7vhfH5WjN0Y7/YF3zs2wOqmrQE9nWihazTTbqcXtgNEP
         RNPZtzuvVpldX7fSo1DnFucJJy1OYubefmnOlOt62AtxzoQyyuWnY71JVUAnromuH+6B
         N9fAHe3RZqI/7+KL0cN3xwUnWjmvCjq0uiXvBd01XwM5XDotom9RHn19Q3GfLb/Fz1Xj
         gOIBEpcBsM2uNBBCVwGUov8nM49RQuzGEFZDgDlRddmnis4ves7gWRZyct12HUIsbO5G
         OFgp9Opri3GuuIE9wu8qeSYA5SeB7XS7Q+62+kZaBUEXN8LB9OD9gHn5BtjBTXCkuwtx
         2/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vuayPgK0AFa+ecEYX+ZQ8vgmFv5JEOwxSTm6d2kZs78=;
        b=tWGhyzWlh+xw5KVpv7UY8n6kHftNSk1lgb8ImQcuxZLCBvcSCtwVIstzTIjOcZIUB7
         zj9o4qYUbKBCO8Y49dYhrq3CMGTL+RYTWdSNFpMlWKSSDdcR4ShZiahmB9h8x4HYwSBn
         HmzTTDoiIIg4jEyScOOOgSyKvzTkmVUs/rwhJN7LUvalJCcdYwf+3oLJeYokxKzHMQrm
         NnkQ/df7QZKPBXlU/ccYnqdlTmqvQ6+c06/oE7+9TYv4uqBNtNRXVkO6WtBumnkCyXXl
         Fhe8Qokq7A/SA78eWe2rAfqKfCAPB0YDCRSczrDGk63C9o/E4X5frptOP/+wdGfT85zX
         rg5g==
X-Gm-Message-State: AOAM530nMrq/oneRhWTXRI4Z+ICeQUXmALtR09aoK8cqRxrNhgV50Jad
        qtcVCXm5+vnAQNcfv875haKoRQPDKI5JXY/GPEgqJg==
X-Google-Smtp-Source: ABdhPJwZM39NYLp6cBlt7OdvlReYZCF5U9ViiH0CM54S+pnKkPT65t3gV5XP9lM1W9YaFAsOziYunWIWhRBIKNm1sZI=
X-Received: by 2002:a2e:9192:: with SMTP id f18mr5264789ljg.220.1636143445722;
 Fri, 05 Nov 2021 13:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211105162756.3314148-1-anders.roxell@linaro.org>
In-Reply-To: <20211105162756.3314148-1-anders.roxell@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Nov 2021 13:17:14 -0700
Message-ID: <CAKwvOd=dtb98Ue1xYz0gQmRGeQWdH6sBEkpXioevPQ94envK8A@mail.gmail.com>
Subject: Re: [PATCH] selftests: vDSO: parse: warning: fix assignment as a condition
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, nathan@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 5, 2021 at 9:28 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> When building selftests/vDSO with clang the following warning shows up:
>
> clang -std=gnu99 -Wno-pointer-sign    vdso_test_gettimeofday.c parse_vdso.c  -o /home/anders/.cache/tuxmake/builds/current/kselftest/vDSO/vdso_test_gettimeofday
> parse_vdso.c:65:9: warning: using the result of an assignment as a condition without parentheses [-Wparentheses]
>                 if (g = h & 0xf0000000)
>                     ~~^~~~~~~~~~~~~~~~
>
> Rework to a parentheses before doing the check.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  tools/testing/selftests/vDSO/parse_vdso.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
> index 413f75620a35..b47b721a4ea4 100644
> --- a/tools/testing/selftests/vDSO/parse_vdso.c
> +++ b/tools/testing/selftests/vDSO/parse_vdso.c
> @@ -62,7 +62,7 @@ static unsigned long elf_hash(const unsigned char *name)
>         while (*name)
>         {
>                 h = (h << 4) + *name++;
> -               if (g = h & 0xf0000000)
> +               if ((g = (h & 0xf0000000)))
>                         h ^= g >> 24;
>                 h &= ~g;
>         }
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
