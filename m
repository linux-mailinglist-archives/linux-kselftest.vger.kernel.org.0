Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8E8553E68
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jun 2022 00:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiFUWT0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jun 2022 18:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiFUWTZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jun 2022 18:19:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B347731356
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 15:19:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id o7so30395686eja.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5TxB5mhSxXbS5+BgbfWYorbl1xw2wo/iBLR21P4z7SQ=;
        b=D4OeYr5DObfkZ5SxU78+21kychVQSbaYxc23HIiBZL/HdobOEgoPwRKlVkqu1qxzwz
         OMerWfBiqhPqNfus9CMllIQSBRuu8B0VSmqLAsRaVcsaJrJJuGEgFuQc3DonJ/KE+aLR
         iLQdIyL/eb6AaFyiD53AvNC7yxOApi+ZRt5U2foiWaMwt0nuJZ+L81yHFaWh5xPh5n/0
         aiU025tdZv1lG2fC0/5QfmsBWN+BZ2R4Q2xd7tyXdDCxKX4vUnvB8uLqyFudoI0U0u6C
         25Mz9INEgtxhNkLP8DYKCeIzC0BrjXWVVeo3stEgIF35rQhqOLf6uwKpnMAvnoEaMeQs
         h+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TxB5mhSxXbS5+BgbfWYorbl1xw2wo/iBLR21P4z7SQ=;
        b=d9i5bPWBaHdhhDKQfsXjopjkCvBzM8JC1H/4G1Fwc5LR1YFEzy7/PMsNtNgYM2CAL+
         u1EWYrd+LTb+Z47t5naWCvvtKIVoCZoLdlN2y7wBwJghbYUCNXOo9ld1oXqdeKi3J6sr
         ATbhNtXTFwKVtrntKleUnRuhl/brzjMMJ7/AYfr3ypYmUu150GW/cwo5HVZiJOValBVI
         WVZv2TfkTe54pv8QdfDm6ZdhYLokgTL1Mp5mGYxFOOz/BjaykLruH4LImTs2zIh1oGwY
         yMAEQqx4h3QfW7RRgqDDbmovtOh9EaowKZRwvqZgfgKGd4Fr0QUUObnV73QqgHEfVPhh
         eM1A==
X-Gm-Message-State: AJIora/KnNkkJ1WEwsBXSRmQ0NicS1tIFUUbAyoDHBzx2Hmd+fI3vdpt
        R8sPWaB+c7rfD7PNb0UtgjUpErvadR+2pO0d0vC6nA==
X-Google-Smtp-Source: AGRyM1vVeJpl5YmahMIBRWKENGAY/5q7qFCUrgPBVWAl++5JmH2yrju9aDpjPk6EPGCreQdfMELmoUi+rubgGYVlS7Q=
X-Received: by 2002:a17:906:728a:b0:715:2fb5:19f9 with SMTP id
 b10-20020a170906728a00b007152fb519f9mr270868ejl.170.1655849962024; Tue, 21
 Jun 2022 15:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220621085345.603820-1-davidgow@google.com> <20220621085345.603820-6-davidgow@google.com>
In-Reply-To: <20220621085345.603820-6-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 21 Jun 2022 15:19:10 -0700
Message-ID: <CAGS_qxp6ZK9K0Sy1JcuU-SGqChOyr6-+5HDxgesOpxjxvDkiXQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mmc: sdhci-of-aspeed: test: Use kunit_test_suite() macro
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>, Paraschiv@google.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
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

 On Tue, Jun 21, 2022 at 1:54 AM David Gow <davidgow@google.com> wrote:
>
> The kunit_test_suite() macro is no-longer incompatible with module_add,
> so its use can be reinstated.
>
> Since this fixes parsing with builtins and kunit_tool, also enable the
> test by default when KUNIT_ALL_TESTS is enabled.
>
> The test can now be run via kunit_tool with:
>         ./tools/testing/kunit/kunit.py run --arch=x86_64 \
>         --kconfig_add CONFIG_OF=y --kconfig_add CONFIG_OF_ADDRESS=y \
>         --kconfig_add CONFIG_MMC=y --kconfig_add CONFIG_MMC_SDHCI=y \
>         --kconfig_add CONFIG_MMC_SDHCI_PLTFM=y \
>         --kconfig_add CONFIG_MMC_SDHCI_OF_ASPEED=y \
>         'sdhci-of-aspeed'
>
> (It may be worth adding a .kunitconfig at some point, as there are
> enough dependencies to make that command scarily long.)
>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Daniel Latypov <dlatypov@google.com>

Minor, optional suggestion below.

>  static int __init aspeed_sdc_init(void)
> @@ -639,12 +620,6 @@ static int __init aspeed_sdc_init(void)
>         if (rc < 0)
>                 goto cleanup_sdhci;
>
> -       rc = aspeed_sdc_tests_init();
> -       if (rc < 0) {
> -               platform_driver_unregister(&aspeed_sdc_driver);
> -               goto cleanup_sdhci;
> -       }
> -
>         return 0;
>
>  cleanup_sdhci:

This goto was added in 4af307f57426 ("mmc: sdhci-of-aspeed: Fix
kunit-related build error") to allow for this extra call to
aspeed_sdc_tests_init().

This could now be reverted back to what is
        rc = platform_driver_register(&aspeed_sdc_driver);
        if (rc < 0)
               platform_driver_unregister(&aspeed_sdhci_driver);

        return rc;

but let's see what the maintainers think.
