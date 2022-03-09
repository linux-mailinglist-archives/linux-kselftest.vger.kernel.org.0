Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183974D3097
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 14:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiCINzF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 08:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiCINzE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 08:55:04 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90BFB3E70
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 05:54:05 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g3so2979643edu.1
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Mar 2022 05:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=58ItMAXsny1L+anxiMU9T6c9Palwcv7/9rI4u4RF93Y=;
        b=LYmpyqEhPpVCocyivY6GecOg7VdFQVfvuY/trXXPIDCWFXVealEM2nKhk5VMPe0EMK
         m6qP02dLPOJq6r4nOvTFvnwOUclUvGGqDzMsMJhrsPyxHmvD4GjCd1i+QSV/mnNeT8j6
         O+23IpoeL1BMxMPL6/6Ym/d7C6qeAoVTAG0ncKVyVYpczZbzqVdLcin2+mEWIbDNWNBQ
         AaXb6/JF0JgdXpI/qhxbqBsA6BdIb24KNnS+/lMuNYvjJlwSKY2krkdmsj848HxCHIe1
         D0LyHRSHEr5iAGL/SdaVKi3XAvGcTWayQRWV6UwePmTyYn3wOk0Q99oO4aHes4yL5X0U
         qjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=58ItMAXsny1L+anxiMU9T6c9Palwcv7/9rI4u4RF93Y=;
        b=cwQKNGJcSPeWqnVr3stluQV6oxhqwRXklk12123B8UYiZngSVh0F5nbRcnkQzEFduc
         aa+Xecq47mmim6Z2p6AfeO/1kXlOM+de2h0Lt477JGZ3ZIDFMimb43cOia4kJxzzmziR
         tLyFICIil4XZSNJGu5MV6+Xepl6Qvcawm6UYJDTtSaAoakoMAROrGOjG8K0kSgY+JKC/
         4BQKefvIxkC/wh5o9OFbdKZaroIIRonLB6ihrDoTeTU7f/6PifuTiVYKTzK5hD332iQF
         qKl1aYWM/b3fEw370PybLniJmCQpnbWDdrgVprNBpat44ZZ6Iq5PXpRNDiWWyGP4O3Jf
         RsUg==
X-Gm-Message-State: AOAM532baKZMVNK6XPVaMTpyuCazGU8wquxiz1rLYKCrXPaYAFShAW2c
        KyIls7vyT8gEZrzQhMyRpdTEZLuglvILB1r23dsZiw==
X-Google-Smtp-Source: ABdhPJyIqqjIhDdsKFYeGKRq2VBngVbOH/FmX+MjBEvKAOVvgdA9H+3Kga13rb0K5Vbd78rsqsqnasGn7vBfUfzwWng=
X-Received: by 2002:a05:6402:1747:b0:415:ee04:47e1 with SMTP id
 v7-20020a056402174700b00415ee0447e1mr21018226edx.229.1646834044075; Wed, 09
 Mar 2022 05:54:04 -0800 (PST)
MIME-Version: 1.0
References: <20220309083753.1561921-1-liupeng256@huawei.com> <20220309083753.1561921-3-liupeng256@huawei.com>
In-Reply-To: <20220309083753.1561921-3-liupeng256@huawei.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 9 Mar 2022 07:53:52 -0600
Message-ID: <CAGS_qxp_aaWEhuKQ9P897HHndRqbNpdS-vUsJooikQiOXrqL7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kunit: make kunit_test_timeout compatible with comment
To:     Peng Liu <liupeng256@huawei.com>
Cc:     brendanhiggins@google.com, glider@google.com, elver@google.com,
        dvyukov@google.com, akpm@linux-foundation.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, wangkefeng.wang@huawei.com
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

On Wed, Mar 9, 2022 at 2:19 AM 'Peng Liu' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> In function kunit_test_timeout, it is declared "300 * MSEC_PER_SEC"
> represent 5min. However, it is wrong when dealing with arm64 whose
> default HZ = 250, or some other situations. Use msecs_to_jiffies to
> fix this, and kunit_test_timeout will work as desired.
>
> Fixes: 5f3e06208920 ("kunit: test: add support for test abort")
> Signed-off-by: Peng Liu <liupeng256@huawei.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Thanks for catching this!

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
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220309083753.1561921-3-liupeng256%40huawei.com.
