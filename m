Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F2C4ACAC3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 21:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiBGUwB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 15:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbiBGUv1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 15:51:27 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CDDC0401D1
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 12:51:25 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l25so12428465eda.12
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 12:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNlSwKrPwSead3UlRii3n77Lkm90XPxm3oVtpWfrGKc=;
        b=mS6jSDKYIhakEkDr4CG7f6fqvgucCPeKuqZOt1j2klKp0Svy5Vsza5m+UFOD7FYCzE
         uWYqud8X6VOxt+97xirc/NvW8/77FTRZ4xh5fq6DZIzj9It00itjEphY+CXPJd/+0Vnn
         pfThl+v2H2nxOalU8dN2PTSRLiwDFCktDJ7mOhe4D8CD96G+ZJH5DZ8iIujwrKqG848X
         49k1JL9h60YwC+sp2LYeWNUPcUpqxhErWbPpB1az3CFapA5UKJnO5tLAMInXb8G2irN5
         9Poy93s2qBu9DjvxoojED7IJZwiO3WErarmE2GbFAeCLSqVsXQ4XlvMYpehi1CG7lfwb
         nGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNlSwKrPwSead3UlRii3n77Lkm90XPxm3oVtpWfrGKc=;
        b=j0hqgENC+SuM6nIcM4TKhM8HbNPYBsXizPWyoXB4OmOY0pWIicfNeCM8RgAdAwwfBf
         Zyi+CBxFRdSFy7gVNF/rce30Xh1S79cMZ6xpAm9XkVU1Rs+Srk5061qEp0XsT0e6LGCV
         oMJ1IlvbQ/ATEdgBswBaBPOot0HvY25Jy3Bw+GhPlKdLQK1AX2OONpIyD0DTRTrxBPxk
         RTTzswrWST67i68s8E7xHIWDXamGXsSRzd4EMICVsa19PHBv4xd+6iX5b02O2e6kJbw0
         q9aaKiAldtD+o1KKOpqS/V1gH3vQu3nRlqUr7+odKPzpxm0vkd/cfxslB3a+F1HIV5QT
         6H7w==
X-Gm-Message-State: AOAM532VADcjC3YgfV+6BIq7TuXrYD8LXUxE3WuHrABhFhqV4P0eeaTS
        djhO7lBJFt8fHDW5Xllw/8L3xnLolKfNmTMiSWmWlg==
X-Google-Smtp-Source: ABdhPJzFb3lI6lRz0KL+g71DaTE9kY//KH+eix0ltoL5/vgqZKweHEcm6w/V9Gz1TMNddwjEgnoTRy1Vx427FFzBPp0=
X-Received: by 2002:aa7:c155:: with SMTP id r21mr1254502edp.327.1644267083805;
 Mon, 07 Feb 2022 12:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20220207202714.1890024-1-ribalda@chromium.org>
In-Reply-To: <20220207202714.1890024-1-ribalda@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 7 Feb 2022 12:51:12 -0800
Message-ID: <CAGS_qxoMTqpGW9EwSbgTafKRbTdG+kaTw+Ea6BfbzMHRiCN=FA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] kunit: Introduce _NULL and _NOT_NULL macros
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

On Mon, Feb 7, 2022 at 12:27 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Today, when we want to check if a pointer is NULL and not ERR we have
> two options:
>
> EXPECT_TRUE(test, ptr == NULL);
>
> or
>
> EXPECT_PTR_NE(test, ptr, (struct mystruct *)NULL);

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Sorry, some minor nits I forgot to include in my previous mail:

minor nit: perhaps KUNIT_EXPECT_TRUE(...)
I don't think most people would be confused by this, but if we send a
v3, might be good to be more precise.

>
> Create a new set of macros that take care of NULL checks.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  include/kunit/test.h | 88 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 00b9ff7783ab..5970d3a0e4af 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1218,6 +1218,50 @@ do {                                                                            \
>                                    fmt,                                        \
>                                    ##__VA_ARGS__)
>
> +/**
> + * KUNIT_EXPECT_NULL() - Expects that @ptr is null.
> + * @test: The test context object.
> + * @ptr: an arbitrary pointer.
> + *
> + * Sets an expectation that the value that @ptr evaluates to is null. This is
> + * semantically equivalent to KUNIT_EXPECT_PTR_EQ(@test, NULL, ptr).
> + * See KUNIT_EXPECT_TRUE() for more information.
> + */
> +#define KUNIT_EXPECT_NULL(test, ptr)                                          \
> +       KUNIT_EXPECT_PTR_EQ_MSG(test,                                          \
> +                               (typeof(ptr))NULL,                             \

First point: hmm, I dropped the (typeof(ptr)) casting and didn't have
any build warnings.
So I don't think the cast is strictly necessary.
We use this value in the comparison (left == right) and when we store
them in the assert struct.
The former is fine since `myptr == NULL` is valid, and the latter is
fine since we store both left/right as `void *` in the end.

It does have the benefit of making the comparison operand more
distinct from the NULL `msg` parameter, however.
I personally would lean towards dropping it still.
A bit less to read, and it also generates less code after the
preprocessing step.

Second point: I think it might be more natural to have the NULL be the
`right` parameter.

Right now we get
      Expected ((void *)0) == test, but
        ((void *)0) == 0000000000000000
        test == 00000000a1803d18

I think it's a bit more natural for the user to see the expression
they provided first, i.e.
    Expected test == ((void *)0), but
        test == 00000000a1003d18
        ((void *)0) == 0000000000000000

If we do flip the order, let's remember to update the comments as
well, the "semantically equivalent to" bit.
