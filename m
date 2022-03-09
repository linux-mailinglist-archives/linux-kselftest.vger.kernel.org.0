Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15FB4D2CC5
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 11:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiCIKGI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 05:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiCIKGH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 05:06:07 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903BB13CEF8
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 02:05:08 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2dbfe58670cso16975027b3.3
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Mar 2022 02:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ts1/JyZlYWr+VS9x1U6wWLuWTL/1XWXl7pSXJy75es=;
        b=kIGAA3FTHLFrsQLliUZIrXCp2oz6cMaC+RZr6kbuzu01pYu9j/egDapYHdtKN/eMIW
         yKtGP79Jn4tSKPSOZGepCO8j23Avps1mS7wlQbDtldTd+QEp9HSjCkDDD/PGltCQ+Lyf
         k37Hj9ij+c+yd4I0W+PKUNB6SUQDOjfyNUvEqa00Mj9C44r3R9qqlwuO7yku3jWn8r8x
         NXzGHWZY/ERFNs7RJ09dTs6S0fqVaOBqXgQylhhXH8jxJhOrPPWn4KImIHcC+7aeCEAJ
         EezurKqTXxUzCrAXEQIJ+J1ja3R/ZdwYcI3mBu5TP//S+ssopIFiavAhiJsgCacWZ5L8
         eKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ts1/JyZlYWr+VS9x1U6wWLuWTL/1XWXl7pSXJy75es=;
        b=RJsdQmJ+Pnek0w5kh9L5cp+ZSMxtLWC3+OT+hVf5fkp90baDBFq4hWSNXgPDu/ihbs
         1H0WbCAq7mAHJ5W5NA/dRan1sjRrMebeGJFhVchLL6HrmsZtzjO/uzsT9iC3TUO5/TaG
         00zED4RpQdD7ys+s0bsvKRi82i9YZEJtCKW2cDVrMpGA+oysCiMI3FdqoAcrswLO8ACY
         y5q8zGP6AiBD+wV9yQuqBGlk60FFcI17GFcevWQCKQef8B91YhcEG67DvfVdt5U/8Q2a
         sqa5bVSMbg3O8KqMOcNFsJiTFd2Vi8xMoIDiCMhW/BSp32A5n+56aL6L5Y4pdh08g20M
         WnYw==
X-Gm-Message-State: AOAM530SmxJxjmv6cWB6erXLEuBAB4h+ZrIkFrrWdy9N2Wx6kgIEC/Gh
        nATuayK/Gx85ol9dDDorUyZxHJObPvw39U0BhfEwXQ==
X-Google-Smtp-Source: ABdhPJw/YRwSs6AWy6LoOEWcJ9Qxv03XdqFgsSGGnQ1xzavlc4bTO/BMkKNAaNHIiAS/FckEFkjyNS+7ZIbwEI4LKek=
X-Received: by 2002:a81:9ad7:0:b0:2db:f000:32e7 with SMTP id
 r206-20020a819ad7000000b002dbf00032e7mr16235265ywg.412.1646820307524; Wed, 09
 Mar 2022 02:05:07 -0800 (PST)
MIME-Version: 1.0
References: <20220309083753.1561921-1-liupeng256@huawei.com> <20220309083753.1561921-3-liupeng256@huawei.com>
In-Reply-To: <20220309083753.1561921-3-liupeng256@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 9 Mar 2022 11:04:30 +0100
Message-ID: <CANpmjNP1gekyBke9x5EV_wWQd8j4aA4nTqh5bg2w3fkNfmvXJA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kunit: make kunit_test_timeout compatible with comment
To:     Peng Liu <liupeng256@huawei.com>
Cc:     brendanhiggins@google.com, glider@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        wangkefeng.wang@huawei.com, Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 9 Mar 2022 at 09:19, 'Peng Liu' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> In function kunit_test_timeout, it is declared "300 * MSEC_PER_SEC"
> represent 5min. However, it is wrong when dealing with arm64 whose
> default HZ = 250, or some other situations. Use msecs_to_jiffies to
> fix this, and kunit_test_timeout will work as desired.
>
> Fixes: 5f3e06208920 ("kunit: test: add support for test abort")
> Signed-off-by: Peng Liu <liupeng256@huawei.com>

Reviewed-by: Marco Elver <elver@google.com>

+Cc more KUnit folks.

> ---
>  lib/kunit/try-catch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index 6b3d4db94077..f7825991d576 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -52,7 +52,7 @@ static unsigned long kunit_test_timeout(void)
>          * If tests timeout due to exceeding sysctl_hung_task_timeout_secs,
>          * the task will be killed and an oops generated.
>          */
> -       return 300 * MSEC_PER_SEC; /* 5 min */
> +       return 300 * msecs_to_jiffies(MSEC_PER_SEC); /* 5 min */
>  }
>
>  void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
> --
> 2.18.0.huawei.25
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220309083753.1561921-3-liupeng256%40huawei.com.
