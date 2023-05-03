Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907936F5069
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 May 2023 08:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjECGx6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 May 2023 02:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjECGx4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 May 2023 02:53:56 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A1840F0;
        Tue,  2 May 2023 23:53:46 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-55a20a56a01so62623187b3.3;
        Tue, 02 May 2023 23:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683096826; x=1685688826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycoy11ds1uuECa7nLWAsDmiVFu/7yLRJRdJ8VPxevb0=;
        b=HtUWWMMwJh/4gi7Yba4vIP8reQHnoUHaYjOe7jY6AWg69L6xjz/dH6lt7ibh6qC+kZ
         PCYgjudwKIe2SgyFjrznGkVCVtTcV38GgewO+4sQWijwF2NAuxLjL8k2CLKgQXUD6eX7
         3Jqfnwcu4DVuF3YbTChy0rqOWtNLnv6FElz6/UZioKU4WdN8j2t51zJJVs+MheGzaHzr
         fNYfbhSFQ+7+SjscJ7MTFq1xNXTdYxSM3BTogkmWeWR/HN0tiR0B07nC/qp9yMXXa836
         r7DLZB6xzWknmr/AQCKTznYIIxqJ6jMmLj4oLPmKAQ57HpwsLS96v5/Mk/MsSrVyG1+c
         2Ijg==
X-Gm-Message-State: AC+VfDwa6yXV/siGPfvNin492aZrpl34caSa5KyZWaIoJg8nyhLsCquA
        mYR4dfsrzFiBXU+MrOX13zUTyPPcZ6AlLA==
X-Google-Smtp-Source: ACHHUZ7tOq8GcY/KFL9NYrN/t/tzhwf1stUB9PTf1oiToxjxkb7abiStAKiPDTjLT4mrfoEuUTmkZw==
X-Received: by 2002:a0d:ef42:0:b0:539:1b13:3d64 with SMTP id y63-20020a0def42000000b005391b133d64mr18387832ywe.48.1683096825826;
        Tue, 02 May 2023 23:53:45 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id g140-20020a0ddd92000000b00545a081849esm2986295ywe.46.2023.05.02.23.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 23:53:45 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-b9dcd91a389so6020405276.2;
        Tue, 02 May 2023 23:53:44 -0700 (PDT)
X-Received: by 2002:a25:d84c:0:b0:b9d:5691:3ef6 with SMTP id
 p73-20020a25d84c000000b00b9d56913ef6mr16412844ybg.27.1683096824680; Tue, 02
 May 2023 23:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683022164.git.geert+renesas@glider.be> <CAMuHMdVmfj8L24QbMGn54jW96rYkvX1gizmvgvEB7T3Jwevd+g@mail.gmail.com>
 <878re6y9s8.fsf@minerva.mail-host-address-is-not-set> <ZFFCzHwJqyeXB52w@google.com>
In-Reply-To: <ZFFCzHwJqyeXB52w@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 May 2023 08:53:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW_K9R7L9M_=M+HyWKivK6S2_Bhb5jvwdGv_oqZ06-NxA@mail.gmail.com>
Message-ID: <CAMuHMdW_K9R7L9M_=M+HyWKivK6S2_Bhb5jvwdGv_oqZ06-NxA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Input: tests - miscellaneous fixes
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, linux-input@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dmitry,

On Tue, May 2, 2023 at 7:05 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, May 02, 2023 at 06:31:51PM +0200, Javier Martinez Canillas wrote:
> > Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > > On Tue, May 2, 2023 at 12:17 PM Geert Uytterhoeven
> > > <geert+renesas@glider.be> wrote:
> > >> This patch series fixes a crash in the new input selftest, and makes the
> > >> test available when the KUnit framework is modular.
> > >>
> > >> Unfortunately test 3 still fails for me (tested on Koelsch (R-Car M2-W)
> > >> and ARAnyM):
> > >>
> > >>         KTAP version 1
> > >>         # Subtest: input_core
> > >>         1..3
> > >>     input: Test input device as /devices/virtual/input/input1
> > >>         ok 1 input_test_polling
> > >>     input: Test input device as /devices/virtual/input/input2
> > >>         ok 2 input_test_timestamp
> > >>     input: Test input device as /devices/virtual/input/input3
> > >>         # input_test_match_device_id: ASSERTION FAILED at # drivers/input/tests/input_test.c:99
> > >>         Expected input_match_device_id(input_dev, &id) to be true, but is false
> > >>         not ok 3 input_test_match_device_id
> > >>     # input_core: pass:2 fail:1 skip:0 total:3
> > >>     # Totals: pass:2 fail:1 skip:0 total:3
> > >>     not ok 1 input_core
> > >
> > > Adding more debug code shows that it's the test on evbit [1] in
> > > input_match_device_id() that fails.
> > > Looking at your input_test_match_device_id(), I think you expect
> > > the checks for the various bitmaps to be gated by
> > > "if (id->flags & INPUT_DEVICE_ID_MATCH_EVBIT)", like is done for the
> > > other checks?
> > >
> > > [1] https://elixir.bootlin.com/linux/latest/source/drivers/input/input.c#L1021
> > >
> >
> > That's correct. In input_test_init(), the input dev is marked as capable
> > of emitting EV_KEY BTN_LEFT and BTN_RIGHT. The goal of that test was to
> > check this.
> >
> > That is, check if matches by the input dev capabilities in which case the
> > __set_bit(EV_KEY, ...) would make the match true and __set_bit(EV_ABS, ..)
> > would make the condition false.
> >
> > But maybe I misunderstood how the input_set_capability() and __set_bit()
> > functions work ?
> >
> > I'll take a look to this tomorrow, thanks a lot for your report!
>
> Unfortunately (?) INPUT_DEVICE_ID_MATCH_*BIT have never had any effect,
> the kernel always used bitmaps when matching (with the assumption that
> if one does not care about given bitmap they can simply pass empty one),
> so I think what we need to change is:
>
> diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input_test.c
> index 8b8ac3412a70..0540225f0288 100644
> --- a/drivers/input/tests/input_test.c
> +++ b/drivers/input/tests/input_test.c
> @@ -87,7 +87,7 @@ static void input_test_timestamp(struct kunit *test)
>  static void input_test_match_device_id(struct kunit *test)
>  {
>         struct input_dev *input_dev = test->priv;
> -       struct input_device_id id;
> +       struct input_device_id id = { 0 };
>
>         /*
>          * Must match when the input device bus, vendor, product, version
>
> to avoid having garbage in the match data.

Thanks, that did the trick! 3/3 tests pass.


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
