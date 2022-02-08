Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E874ACD77
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 02:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbiBHBG1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 20:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343953AbiBHAPz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 19:15:55 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F058C061355
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 16:15:55 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id s13so46969315ejy.3
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 16:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KAhtgPEL1/b/o+qskfhoxIg0uA7IhIyD/T0+zZPOZiM=;
        b=rbqKbdD3i3EmTrfHLDx7sMpIJH/bLNQglBgvWsmQgKQ9ytML40I/BKCZoR3XYchCQu
         +QxnvhvnRFwgO7b8tJsdhB0nPneEUTYL1FDTDCTIci0zLfqgUWPyO259vJgRyT8jvmHK
         vFlRmx98HYsdGEwi5KSUDC+kzAm6b5s9ykeJr/iRpK6aiQweGJ0JqhxbqvAaghOpNGhu
         OxmBw6s1OR9UGt+8GWCbAIQZZDtVRMr62+aqjkS88B0Yg8Q0D+JIA7W+0jRQPc00pNLQ
         P2B54Vit+dfQE6Ih2YL6x6CQMbsABm2d5IOh+jo669KVfrVHqwaWTvusZvlxTLa7gT/T
         v5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KAhtgPEL1/b/o+qskfhoxIg0uA7IhIyD/T0+zZPOZiM=;
        b=Topz8U4xAH4lP4koQ4t7XmrmtOcHDliO8rUgHQIkqAkKCL9vKWj+JfSFDB0a1FTuSE
         xM9fcb9k0Y9fLovefZOgfAkeC+Q+Ho1VyLUuzxcPSjqWA0XkeIx42xv1OE56lh8FYn2T
         ZUzg8eZ/4O11INLlpgLyronXiV78/DyCRH4h0ME1m3gR0Lvv140DMsINpHLBw70gUCJn
         HToJYpi4jhDeA1qMB/vjqx09IUsZ0obgYMS0iJAVcW0I9LthNus4lUKZz5iXK+yMYySz
         QJELU/Isl8OI6p0AOnRHDJBUgWMsO5WVJwmyQ0DXG2A9aMHWdL1Xeade8wCM/nBlrYeZ
         vsHw==
X-Gm-Message-State: AOAM531Dr1YR6m4TRpjEC08aD9MnKbBoxfq/D0s5QWYedE2NCgXbvund
        YF/6SLF5IL3ziMx+KMyer08dIcUHDGkIiTvb4CK2XQ==
X-Google-Smtp-Source: ABdhPJyZsYIHhwzBouA9deqE+mInKXPHL6dCI8OTur7vXfstI/Vmaj95ieogR49ktVz1YtdvvAPgbiXrGsN2Qa9XvJc=
X-Received: by 2002:a17:906:782:: with SMTP id l2mr1602822ejc.631.1644279353562;
 Mon, 07 Feb 2022 16:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20220207211144.1948690-1-ribalda@chromium.org> <20220207211144.1948690-4-ribalda@chromium.org>
In-Reply-To: <20220207211144.1948690-4-ribalda@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 7 Feb 2022 16:15:42 -0800
Message-ID: <CAGS_qxpjTf=PLxh2ucE23_hW4f2ub10fJ5bbw2Qy_10vWUXrCA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] kasan: test: Use NULL macros
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
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

On Mon, Feb 7, 2022 at 1:11 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Replace PTR_EQ checks with the more idiomatic and specific NULL macros.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Acked-by: Daniel Latypov <dlatypov@google.com>

> ---
>  lib/test_kasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 847cdbefab46..d680f46740b8 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -385,7 +385,7 @@ static void krealloc_uaf(struct kunit *test)
>         kfree(ptr1);
>
>         KUNIT_EXPECT_KASAN_FAIL(test, ptr2 = krealloc(ptr1, size2, GFP_KERNEL));
> -       KUNIT_ASSERT_PTR_EQ(test, (void *)ptr2, NULL);
> +       KUNIT_ASSERT_NULL(test, ptr2);
>         KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)ptr1);
>  }
>
> --
> 2.35.0.263.gb82422642f-goog
>
