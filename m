Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F5F382835
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 May 2021 11:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhEQJYk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 May 2021 05:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbhEQJYk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 May 2021 05:24:40 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4682C06174A
        for <linux-kselftest@vger.kernel.org>; Mon, 17 May 2021 02:23:24 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id f11so2792495vst.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 May 2021 02:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kzYVzmT+Y8ce2flyvbSSPdmquvI+WpoScVhmf9xFNfc=;
        b=wZE8pBAqeARtQbwh+YWftfz+pAOAl52rdskfYBROlX2BYGzyiP8jIhVMX2ZLlI/5TN
         2h55vokvcNd9L9wocrsTfFNSZ7mvGTPvyT6ydg0YrjKHLTUBuhbjdOqBt6BcYgzbTu4z
         CJC7/JcgyYbA8qJyYy52Qlnrl5Ks8rBSWSII4TJUN/iauAg9QqBcUXZ3Uc46G84x0Wqi
         7EJaqNos/h447r9ZfuhH/fMb87/SWTIRaTqJufYy20AjL2e6KGye9jf84Rmi4O/7MYAE
         1JPV3hD1j6WJmF5EQD0WwU2Wke0Zt5Bbr1TPruhZr+U9SyoLJj18Xh+kzPIbsZqQnpMc
         7cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kzYVzmT+Y8ce2flyvbSSPdmquvI+WpoScVhmf9xFNfc=;
        b=Sh2P5uFlgapOUI3HdrygIbU6gyZ43ytD6EUvP7Rbp1oXR3CDzl1e/0N4+h3sqsqHK4
         OJQ2pzuJUUrPc4oGa0LELUpu4Zza3TPgXxEGde3SEpdSdTplxY3uAXLJ4LxdCpYo7toe
         YQIa7e5Tewl5cSLYolYXzrXx10ABMS5doPpJCBB3ZavJ3CyepDs11xE5VPPwLYg3lv04
         mIHyhsDYCoZs/yMLQ3DSeKLAC132bOqN47lVzp7BXJBz7EISTrm/YcjbbJnitpNnygh6
         Txbhec+THwWuYk0dqf23tmMKKs26VoIZctMZQixEbFY6got4ufAatP6lUZF7l3l2pK7Q
         0bwQ==
X-Gm-Message-State: AOAM533BsBfTR5BZcfKBkw21quZ5X4rYBjuxUupEJcU2tkMbnKWug+eD
        kFUvpUkxr3ZAdazSYwqcArd0Ub/YzBCvciy66tWPRsMmAmQ=
X-Google-Smtp-Source: ABdhPJyXKhN5EScVDwjR162oOK33ajPAKsDnGAYw4sYWr1DOTQym8W+LchIR8j6ixX6JvWzsFngChaUy9M79BpaoBus=
X-Received: by 2002:a05:6102:7b4:: with SMTP id x20mr3923640vsg.48.1621243403858;
 Mon, 17 May 2021 02:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com> <20210513193204.816681-6-davidgow@google.com>
In-Reply-To: <20210513193204.816681-6-davidgow@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 May 2021 11:22:47 +0200
Message-ID: <CAPDyKFoEeRUjHLZ3iSvPT4_0X107G3Xw+ujxJ9zsDk06dTxo7w@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] mmc: sdhci-of-aspeed: Remove some unnecessary
 casts from KUnit tests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Joel Stanley <joel@jms.id.au>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 13 May 2021 at 21:36, David Gow <davidgow@google.com> wrote:
>
> With KUnit's EXPECT macros no longer typechecking arguments as strictly,
> get rid of a number of now unnecessary casts.
>
> Signed-off-by: David Gow <davidgow@google.com>

I guess you will funnel this via another tree than the mmc?

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> This should be a no-op functionality wise, and while it depends on the
> first couple of patches in this series, it's otherwise independent from
> the others. I think this makes the test more readable, but if you
> particularly dislike it, I'm happy to drop it.
>
>  drivers/mmc/host/sdhci-of-aspeed-test.c | 34 ++++++++++++-------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
> index bb67d159b7d8..1ed4f86291f2 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed-test.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
> @@ -26,23 +26,23 @@ static void aspeed_sdhci_phase_ddr52(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, 15,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 25));
>
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 180));
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 181));
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 182));
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 183));
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 2,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 2,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 184));
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 3,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 3,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 185));
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 203));
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 204));
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 205));
>  }
>
> @@ -67,21 +67,21 @@ static void aspeed_sdhci_phase_hs200(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, 15,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 96));
>
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 180));
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 185));
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 186));
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 187));
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 269));
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 270));
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 271));
> -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
>                         aspeed_sdhci_phase_to_tap(NULL, rate, 276));
>  }
>
> --
> 2.31.1.751.gd2f1c929bd-goog
>
