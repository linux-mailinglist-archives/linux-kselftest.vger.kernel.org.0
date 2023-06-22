Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACF673A4BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 17:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjFVPZM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 11:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjFVPZI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 11:25:08 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DB1E4B;
        Thu, 22 Jun 2023 08:25:06 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b466744368so87924901fa.0;
        Thu, 22 Jun 2023 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687447505; x=1690039505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SjsA/7tyFv89Q7vqoWS3fCDaU/nprVOmJqaSjQuAOqg=;
        b=TYxa8tHVYlEUCFbBzgL+0zOQZfWnFr5QC7tE5sBd2LYXESWmMf4UK8ybPcS7MyIbmQ
         a9gpafCyhF8I9p6YlUhbMSnQSkvRDeWa0zeAjldz3hKBr+XQL0ZsiqJjjVSP8U28rfEn
         Yoe87tH/CuEX694L9UF4A9MVqVmvmFskHQIqftCsagRBLn2D+4ugzBuQMwnn5LzWOj2u
         eEOqqN/4J9kIDFEByZQIMcHlZgz1t49X1orLHX9FA+bW2GYrw3WZY1xGBWY727QgH1ak
         4UIo93pM3Bujr3kQ/Y/yjxsHSmEwjcfrJCAP57ICgPkEr2pxyICbHRiUmiHtAHlFo3Ut
         eX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687447505; x=1690039505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjsA/7tyFv89Q7vqoWS3fCDaU/nprVOmJqaSjQuAOqg=;
        b=Cy3K7K4JA0n2H2Y2BmJ8vmBhfkHaF8BUG3LhGpSI3CF+iKu2d3QWQoCcaYPcblzN4g
         PfyqexRa5DKJZ9s4/+k4gKiO7qbGZu2Y3iuNWRPxKPsHbIhctvZ7Rt+sjHQrmc1UDPmD
         MCF8VvPwFitFpp4X24r210GZAdqgq0bDOfGtbECCMBsF3C65i7IAMHrP6c0jFhc0EzgY
         PpZp4ZZn65gTX6m0bi87xIGCXs7X46szPIlkaR7m3/hbEc17aXPpF6pPe+3lT7Ej9fX1
         VqMSo/c25bYTincBwuUsQ8MsKwuzIqAn8rKNv/7PxJwu5ZHc8qKlK78zRBP8I3c7V2Ap
         m4PA==
X-Gm-Message-State: AC+VfDyq4wx6je8AnbCnSTRtpaLqhh1b4Tz+gRNOpN8RMFkNuQL47moM
        cpfCxzO7nRQSwiNs7FN3y8IIaTR4SQM5NICEhTQ=
X-Google-Smtp-Source: ACHHUZ7acI2ddNRYoEO7wAPL/z36z1L6Em6dHlMqcmSKSw0NT0wvBT/tAk1+GGR4aFP0tiOETUig9aVpFSi8qSU82tQ=
X-Received: by 2002:a19:7b02:0:b0:4f8:83f:babe with SMTP id
 w2-20020a197b02000000b004f8083fbabemr11348149lfc.62.1687447504655; Thu, 22
 Jun 2023 08:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230622143438.139187-1-dangel101@gmail.com>
In-Reply-To: <20230622143438.139187-1-dangel101@gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 22 Jun 2023 17:24:52 +0200
Message-ID: <CAFqH_51dNwHmEHfZ4Pyi_7YoW+T-L5jCNx2XgHPaPyhMoe68Wg@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/input: introduce a test for the EVIOCGLED ioctl
To:     Dana Elfassy <delfassy@redhat.com>
Cc:     shuah@kernel.org, eballetbo@kernel.org, usama.anjum@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dana Elfassy <dangel101@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dana,

Thanks for taking my comments into consideration.

Missatge de Dana Elfassy <delfassy@redhat.com> del dia dj., 22 de juny
2023 a les 16:35:
>
> This patch introduces a specific test case for the EVIOCGLED ioctl.
> The test covers the case where len > maxlen in the
> EVIOCGLED(sizeof(all_leds)), all_leds) ioctl.
>

If I understand correctly this covers the same code path in the kernel
as the EVIOCGKEY test [1] that you sent before. The only difference is
that from the userspace point of view, the entry point is different,
here you use EVIOCGLED as a trigerr and before you used EVIOCGKEY. But
once in the kernel, the code path is the same. I am not sure if it
makes really sense to repeat this test, but it is up to maintainers to
decide. In any case, it looks good to me, so

> Signed-off-by: Dana Elfassy <dangel101@gmail.com>

Reviewed-by: Enric Balletbo i Serra <eballetbo@kernel.org>

[1] https://patchwork.kernel.org/project/linux-kselftest/patch/20230622141802.135723-1-dangel101@gmail.com/

> ---
> Changes in v2:
> - Changed variable leds from an array to an int
>
> This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
> [1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/
>
>  tools/testing/selftests/input/evioc-test.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
> index ad7b93fe39cf..378db2b4dd56 100644
> --- a/tools/testing/selftests/input/evioc-test.c
> +++ b/tools/testing/selftests/input/evioc-test.c
> @@ -234,4 +234,21 @@ TEST(eviocsrep_set_repeat_settings)
>         selftest_uinput_destroy(uidev);
>  }
>
> +TEST(eviocgled_get_all_leds)
> +{
> +       struct selftest_uinput *uidev;
> +       int leds = 0;
> +       int rc;
> +
> +       rc = selftest_uinput_create_device(&uidev, -1);
> +       ASSERT_EQ(0, rc);
> +       ASSERT_NE(NULL, uidev);
> +
> +       /* ioctl to set the maxlen = 0 */
> +       rc = ioctl(uidev->evdev_fd, EVIOCGLED(0), leds);
> +       ASSERT_EQ(0, rc);
> +
> +       selftest_uinput_destroy(uidev);
> +}
> +
>  TEST_HARNESS_MAIN
> --
> 2.41.0
>
