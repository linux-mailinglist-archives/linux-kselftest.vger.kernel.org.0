Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21AA57956B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 10:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbiGSImM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbiGSImK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 04:42:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25EB2CDE0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 01:42:07 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z25so23609728lfr.2
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 01:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wnu/3vIy/EyKk8Ed8D6cTFH8iy5jebDSZ/AanZy9t/s=;
        b=do2BHwMsu7F2Z1rq1MpWG2gqnQ1DcjmoS4NUR8B6n3WDVOaTCFynyNxyt7SrK/HPcF
         eAb5C+TWX4ITxCWjvZyUEut0VRjv/liUxMP9/uqWFoPiH51O9kqVxqdyCF1SKGqwRRYN
         T75oPSUR8mkUZG6aiELNof7Cki7xb4PA43XK3eDIw/ZyPZQ6PdJtVOWsvNDuOFYcudfv
         wE3Yw9zDe2wjbyycIDp/TT4XdalYKTI4MVRyYiJB31jqelmjAXki91jHV2sW8AmSfxvS
         IPYv180w7UDXDdWD/sbn6oD/hRfzAk/2CdPpZMP2QLJcmB0Qc1KD24/VnM7zt68lgAuI
         Caig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wnu/3vIy/EyKk8Ed8D6cTFH8iy5jebDSZ/AanZy9t/s=;
        b=ekU/npxSFyadA7AWRWUocrAysZZfCkULNpGC2C1fTWW2l8ygCsWm390JG4jJ2TW4ka
         WNf/BitwrYnnBCaIX5t26ZwkVI/lvU4YJ0TGH9cYV4AzrmxVjeXnj7yaj5Qu+3pbl6F/
         l/J4ks7Uf9lKBqCXZuDwQ7GXzJG8HFrsaTEjHjDe8nmD76wCTrAL/cRBZv+j8nc29aop
         Iv160+BWgVSgdsMR1NpCKAvD8PJSv8erfcCQ91WprtYFgnjG3WNcANZCDxwj+4pFs+By
         dqLCgID4RsBqimKYnhcawkGp/lZ9J3GSFt5+WgAWVLtfpYawOjZlRoAdSPrul3yHZ46Y
         NLKQ==
X-Gm-Message-State: AJIora8M9FWxpfvw7ffq0gDYq992s33p64zlPINnQhtAMctxNdZErWBW
        9zu0djQPrEjOROiWhD9ehBGjUWuTsRJIk81gkdG+/w==
X-Google-Smtp-Source: AGRyM1tIw/nL1JsDz+rLmh9KoRcKXbYbJHhm6a4Q9+Si0H00rIVXplg0s5C+t128uWGdB1HIEC93R143WyiOpvIzb54=
X-Received: by 2002:a05:6512:2522:b0:489:daa9:467 with SMTP id
 be34-20020a056512252200b00489daa90467mr17375016lfb.71.1658220126191; Tue, 19
 Jul 2022 01:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220715040354.2629856-1-davidgow@google.com>
In-Reply-To: <20220715040354.2629856-1-davidgow@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jul 2022 10:41:28 +0200
Message-ID: <CAPDyKFo0AcNayzJa3SZOS4HX3tSBPT57Z+h8cJ9i56uz5ympRw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-aspeed: test: Fix dependencies when KUNIT=m
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, Sadiya Kazi <sadiyakazi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 15 Jul 2022 at 06:04, David Gow <davidgow@google.com> wrote:
>
> While the sdhci-of-aspeed KUnit tests do work when builtin, and do work
> when KUnit itself is being built as a module, the two together break.
>
> This is because the KUnit tests (understandably) depend on KUnit, so a
> built-in test cannot build if KUnit is a module.
>
> Fix this by adding a dependency on (MMC_SDHCI_OF_ASPEED=m || KUNIT=y),
> which only excludes this one problematic configuration.
>
> This was reported on a nasty openrisc-randconfig run by the kernel test
> robot, though for some reason (compiler optimisations removing the test
> code?) I wasn't able to reproduce it locally on x86:
> https://lore.kernel.org/linux-mm/202207140122.fzhlf60k-lkp@intel.com/T/
>
> Fixes: 291cd54e5b05 ("mmc: sdhci-of-aspeed: test: Use kunit_test_suite() macro")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: David Gow <davidgow@google.com>

I assume this should go together with the other recent kunit patches,
so please add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 10c563999d3d..e63608834411 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -171,6 +171,7 @@ config MMC_SDHCI_OF_ASPEED
>  config MMC_SDHCI_OF_ASPEED_TEST
>         bool "Tests for the ASPEED SDHCI driver" if !KUNIT_ALL_TESTS
>         depends on MMC_SDHCI_OF_ASPEED && KUNIT
> +       depends on (MMC_SDHCI_OF_ASPEED=m || KUNIT=y)
>         default KUNIT_ALL_TESTS
>         help
>           Enable KUnit tests for the ASPEED SDHCI driver. Select this
> --
> 2.37.0.170.g444d1eabd0-goog
>
