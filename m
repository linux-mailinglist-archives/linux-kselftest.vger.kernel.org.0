Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB143870DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbhEREax (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 May 2021 00:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbhEREaw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 May 2021 00:30:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677BDC06175F
        for <linux-kselftest@vger.kernel.org>; Mon, 17 May 2021 21:29:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h4so8542869wrt.12
        for <linux-kselftest@vger.kernel.org>; Mon, 17 May 2021 21:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYivGhbkgN/0kOX9moGua2NF+G4pIWkoseKbkugbZk8=;
        b=b/QzFYlSCIrp2x7Ol1KR9fZeYmrh9fuQnORQMISfz94c4LGcCztOQE+joRIa/yDCvm
         S6KZQhefd9EsRZUSyi9v9GDwzs4U/UMjeFz1Q0xM9W3W8q6UAbre3ZSENZKRgKY0qf/L
         OHE6Isb5ZXUK8zDPXLpLv/nQSMqznz4rsAmnfR+ilt9ju4kumWfbm2KIa1+ug3Jm04S1
         cSmQTjvsI35Hauy72QZNRZJ8ZDh+KihfuTUtWWGhY3j4NUkOkh2mGY8J+zj99l6Fm/mg
         EfOQ93cGSGKpLzytWUn5d7vN8Y7xZTxBoV7lO6XHMbA4+vEEeOHinXYmk2nhWOiSkmb1
         /fkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYivGhbkgN/0kOX9moGua2NF+G4pIWkoseKbkugbZk8=;
        b=luNLZfrXseL3aaD7Cl97Par0b1eTgxvqiR+A2/KCdwk0cfSLcRgOIz9a8mJXlGE81M
         iIUmZocNC6kyRix2+/oNoJ4ZY7hGGGM5pkRdg6jHp12y0Z8dccEQiWp2eFGbLBicvBg4
         jSRiizhj2UehuGABpzM8bF8xCWCs6Br2P2tNuZg+09qtE4bUV569cHhymPWYrGzzur8M
         i8uOdirHsH41MjR/hrOKgvEehZppD7FYKInzRPGHZdOrHLAkO2qQHUUsfQtrrVuTkFR2
         EDmrvYU/gwAIxJf5Jyjp2FvNKz6BLmxCHBqL9zxpkdZQlP3Mr1CtcltKLottYVj9K5mH
         ixrw==
X-Gm-Message-State: AOAM5329O2fI24SgATUw0KgOELLSPAf8GkUpIuSNK9rmgjZIDrTkyAj5
        HDm8MnMqC42GX7YLLuNXKUaZo/MHdnqJ9X6chtGa5g==
X-Google-Smtp-Source: ABdhPJz73C/JeMEY7R3wJhYkQwIiUPW6qbsA6Exu7snYht6lCDkBlkpzGwS739hPzgZX0IvEs+sGHHVFeJ+yjoeM/7g=
X-Received: by 2002:a05:6000:1147:: with SMTP id d7mr4151974wrx.302.1621312173995;
 Mon, 17 May 2021 21:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com> <20210513193204.816681-6-davidgow@google.com>
 <CAPDyKFoEeRUjHLZ3iSvPT4_0X107G3Xw+ujxJ9zsDk06dTxo7w@mail.gmail.com>
In-Reply-To: <CAPDyKFoEeRUjHLZ3iSvPT4_0X107G3Xw+ujxJ9zsDk06dTxo7w@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 18 May 2021 12:29:22 +0800
Message-ID: <CABVgOSmv6axdgXLPAwb=q0_RRL44Kbd73SLf=UogEM-k7WMNLw@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] mmc: sdhci-of-aspeed: Remove some unnecessary
 casts from KUnit tests
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 17, 2021 at 5:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 13 May 2021 at 21:36, David Gow <davidgow@google.com> wrote:
> >
> > With KUnit's EXPECT macros no longer typechecking arguments as strictly,
> > get rid of a number of now unnecessary casts.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> I guess you will funnel this via another tree than the mmc?
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Kind regards
> Uffe
>

Yeah: the plan is to have this whole series go through the
kselftest/kunit tree so we don't have to worry about potentially
temporarily introducing a bunch of compiler warnings.

Cheers,
-- David

> > ---
> > This should be a no-op functionality wise, and while it depends on the
> > first couple of patches in this series, it's otherwise independent from
> > the others. I think this makes the test more readable, but if you
> > particularly dislike it, I'm happy to drop it.
> >
> >  drivers/mmc/host/sdhci-of-aspeed-test.c | 34 ++++++++++++-------------
> >  1 file changed, 17 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
> > index bb67d159b7d8..1ed4f86291f2 100644
> > --- a/drivers/mmc/host/sdhci-of-aspeed-test.c
> > +++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
> > @@ -26,23 +26,23 @@ static void aspeed_sdhci_phase_ddr52(struct kunit *test)
> >         KUNIT_EXPECT_EQ(test, 15,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 25));
> >
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 180));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 181));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 182));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 183));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 2,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 2,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 184));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 3,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 3,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 185));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 203));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 204));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 205));
> >  }
> >
> > @@ -67,21 +67,21 @@ static void aspeed_sdhci_phase_hs200(struct kunit *test)
> >         KUNIT_EXPECT_EQ(test, 15,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 96));
> >
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 180));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 185));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 186));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 187));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 269));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 270));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 271));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 276));
> >  }
> >
> > --
> > 2.31.1.751.gd2f1c929bd-goog
> >
