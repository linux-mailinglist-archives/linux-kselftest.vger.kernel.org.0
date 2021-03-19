Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF81342377
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 18:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCSRhE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 13:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhCSRgl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 13:36:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D2C06174A
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Mar 2021 10:36:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b83so11210361lfd.11
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Mar 2021 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWvA/48XFK9LthHD8XWNH2G9h2Q/D7pf8r0WoDKA8qA=;
        b=IGuDs/Zr+b25y0bNBTt89tfNke9eRddRNMewy7U95g7th9S/Ube+V8HeS7HRH1ssHd
         24gsXGfOkoWUvKX2nRHLDmcf9pUiRp67t7sYgjJrDgL5rX8vpgtamYN7JL897KrPOU2e
         S+YoTFQbs8oISzLPA04LSmnZn92bfv9+ArloQEk2jrn8Ix7YUst/4IXRB+fnc/LHmIIn
         UFZlJgxZ+D/tS5bdU8q7WKMJzKbN6uggdAF/Koke0Oz81WzurlTbLOD2aXPmPQL1HI2G
         16wNwGZ2gOsN2gogJnU4GM6+yy+8hyyojtypkOcDdaqxC8cQjTQPT7Nf6OSsyjW4PDHK
         Ir4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWvA/48XFK9LthHD8XWNH2G9h2Q/D7pf8r0WoDKA8qA=;
        b=GfPA2FnSENSd6o2UgfA9GIE8go8sEAA5lrSgJSPRFzvnz3YTjLjTlbLfgQMK1pk0tQ
         EwgF75fdlfLnh8mugxYEB3Pxyf9msHO2O5D/bfmlM8L+9Fxr2AZRsmmSzxAkhOlKrxnb
         kLU9H22UbEazsUVFQ2QwGil83rc4Jcf8DvvbZCiBaNyL1cPbx/Kdtwj1lTj5cRvvMQnI
         4B/isynGFa5raqAkNqwV1D+aqY9QlTRVHQ1snjhaeNecOrpHCxCHapLt29u7XuBPeLJs
         0cSDDPke3ZR+RZL4e+AZEftcsP3o5J6E7iBnRflZr0Ug18yrox/Or55xVd0lHQsoQMFt
         Pdsg==
X-Gm-Message-State: AOAM532ihxxI+42njXOJVFpnn9xbYa8UOoLKgm5MeSRH0CBJ64PJhJyw
        YCs5D8Q4AQN8O7u3tt+4mBC5TcYvvVZkY52evTNRcA==
X-Google-Smtp-Source: ABdhPJx3zEb7CeYeuyhxiQ8AWXAXc1DgEz/3FDITjeBbOZCgrgRsghMkf77Us76TwoHGRVhhHThXcK6TQampN2HhJ10=
X-Received: by 2002:a19:430e:: with SMTP id q14mr1533339lfa.374.1616175399402;
 Fri, 19 Mar 2021 10:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210319165334.29213-1-andre.przywara@arm.com> <20210319165334.29213-11-andre.przywara@arm.com>
In-Reply-To: <20210319165334.29213-11-andre.przywara@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 19 Mar 2021 10:36:28 -0700
Message-ID: <CAKwvOdkuvUPezqZWDE=zvCKMZ_b+mevu-gsh-oJT1SPv7xUZOQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] kselftest/arm64: mte: Fix clang warning
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
> if (!prctl(...) == 0) is not only cumbersome to read, it also upsets
> clang and triggers a warning:
> ------------
> mte_common_util.c:287:6: warning: logical not is only applied to the
> left hand side of this comparison [-Wlogical-not-parentheses]
> ....
>
> Fix that by just comparing against "not 0" instead.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  tools/testing/selftests/arm64/mte/mte_common_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
> index aa8a8a6b8b6d..040abdca079d 100644
> --- a/tools/testing/selftests/arm64/mte/mte_common_util.c
> +++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
> @@ -284,7 +284,7 @@ int mte_switch_mode(int mte_option, unsigned long incl_mask)
>
>         en |= (incl_mask << PR_MTE_TAG_SHIFT);
>         /* Enable address tagging ABI, mte error reporting mode and tag inclusion mask. */
> -       if (!prctl(PR_SET_TAGGED_ADDR_CTRL, en, 0, 0, 0) == 0) {
> +       if (prctl(PR_SET_TAGGED_ADDR_CTRL, en, 0, 0, 0) != 0) {

How about `if (prctl(...)) {`?

>                 ksft_print_msg("FAIL:prctl PR_SET_TAGGED_ADDR_CTRL for mte mode\n");
>                 return -EINVAL;
>         }
> --
> 2.17.5
>


-- 
Thanks,
~Nick Desaulniers
