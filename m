Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD854ACA2F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 21:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbiBGULh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 15:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240453AbiBGUIk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 15:08:40 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07568C0401E1
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 12:08:40 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id y9so6387051pjf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 12:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LNwds3cgV6uMX28QySXkXVMQplA0HsKCenltQ/gMoBA=;
        b=j258jgaQuSFCKLNbLuL3hr6Uk1FCHwaxDyBxLgVGgZ0arJ4S/Ms8LrI5m+TzWnxBP7
         AYJe7XCXhyLOOE2e1/5DQnqv5jTOvSXHRSC34HtUW4xAPd5IRwPCivVKJZDfXlVoOnV5
         sYGZ36Ev6Q1mJM6vb45h5142vJzEhYN0aGLqMn+Y8LUIZovnNTuwduSJzqa4TTvF9LvI
         8XDwnaqm6MSAved76vNOh0StXkD66tT3gAUYso022ea2JISSaI5PFtw4mhdK0klkaEtf
         F6rcqby0qSTws2cPiX4xFVG12aR+ZNTJDmsISE4vgH8w4Py6RyI27wd5Xx0uco5kCin8
         XqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LNwds3cgV6uMX28QySXkXVMQplA0HsKCenltQ/gMoBA=;
        b=YFZAkHDOTJGPZ91YY1JJ2EGiBWoZkBguLhSU7x4rase2oLV322S2UiQgIh4iETYYDg
         focmQ3DH4lWZX6Tk5mL0+cspK0WO84L4KLf1qgrcySSsskGsOJAGJJo9ws+iVP8zF4Vu
         R+uvaZz39LCDTZ2lj63BmPvJgsLKeL55UgSLjtGAm7E7o0chT0Pg65GHkGD2ejWJV13t
         YbiIvftzoDZ4XFdWg2nXIaoOJvPKWVH8JK6V5GkZTL2xeija9+yaXuaxHlt5pevXtZna
         AkI9RQR5bErMyMZxC0VxvRsRkT6e9hqCQUvckFiPOgAW3cbbXDz/v5udPmU/Q8P69+tB
         M2hg==
X-Gm-Message-State: AOAM532RN1ZaziA+hEAd/gPeDNYRN1nj5Xme05f4OClRZs4u/AIQmedN
        r9u7TTbmTkwm50ZuQmL10Kb/XhmkGrxEGJG/508HOg==
X-Google-Smtp-Source: ABdhPJyCyMcvR+grYQyc1blHWaBUPNliRVb5L5Dbb4GWBaCaP0ktKX+iEoVK88cuZrP4dHVThhJlUPBfLOVL/BsHw8E=
X-Received: by 2002:a17:902:b682:: with SMTP id c2mr1313446pls.126.1644264519213;
 Mon, 07 Feb 2022 12:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20220207183308.1829495-1-ribalda@chromium.org>
In-Reply-To: <20220207183308.1829495-1-ribalda@chromium.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 7 Feb 2022 15:08:30 -0500
Message-ID: <CAFd5g46X_jptwL5UsebR2Ooq7ubneSZ5p-Qp4BOL9dt2gFhMAw@mail.gmail.com>
Subject: Re: [PATCH 1/6] kunit: Introduce _NULL and _NOT_NULL macros
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
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

On Mon, Feb 7, 2022 at 1:33 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Today, when we want to check if a pointer is NULL and not ERR we have
> two options:
>
> EXPECT_TRUE(test, ptr == NULL);
>
> or
>
> EXPECT_PTR_NE(test, ptr, (struct mystruct *)NULL);
>
> Create a new set of macros that take care of NULL checks.

Also worth mentioning that we have a KUNIT_EXPECT_NOT_ERR_OR_NULL()
(as well as an ASSERT flavor); however, I can imagine circumstances
where you don't want to check if a pointer is potentially an err_ptr:

https://elixir.bootlin.com/linux/v5.17-rc3/source/include/kunit/test.h#L1586

Otherwise - aside from a minor nit below - this looks good. Send me
the rebased version that Daniel mentioned, and I'll give it a
reviewed-by.

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  include/kunit/test.h | 91 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index b26400731c02..a84bf065e64b 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1395,6 +1395,51 @@ do {                                                                            \
>                                           ##__VA_ARGS__)
>
>  /**
> + * KUNIT_EXPECT_NULL() - Expects that @ptr is null.
> + * @test: The test context object.
> + * @ptr: an arbitrary pointer.
> + *
> + * Sets an expectation that the value that @ptr evaluates to is null. This is
> + * semantically equivalent to KUNIT_EXPECT_PTR_EQ(@test, NULL, ptr).
> + * See KUNIT_EXPECT_TRUE() for more information.
> + */
> +#define KUNIT_EXPECT_NULL(test, ptr)                                          \
> +       KUNIT_BINARY_PTR_EQ_ASSERTION(test,                                    \
> +                                     KUNIT_EXPECTATION,                       \
> +                                     (typeof(ptr))NULL,                       \
> +                                     ptr)

Minor nit: can you put these new declarations just ahead of the
existing KUNIT_{EXPECT|ASSERT}_NOT_ERR_OR_NULL() macros that I
mentioned above respectively?

> +#define KUNIT_EXPECT_NULL_MSG(test, ptr, fmt, ...)                            \
> +       KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,                                \
> +                                         KUNIT_EXPECTATION,                   \
> +                                         (typeof(ptr))NULL,                   \
> +                                         ptr,                                 \
> +                                         fmt,                                 \
> +                                         ##__VA_ARGS__)
> +/**
> + * KUNIT_EXPECT_NOT_NULL() - Expects that @ptr is not null.
> + * @test: The test context object.
> + * @ptr: an arbitrary pointer.
> + *
> + * Sets an expectation that the value that @ptr evaluates to is not null. This
> + * is semantically equivalent to KUNIT_EXPECT_PTR_NE(@test, NULL, ptr).
> + * See KUNIT_EXPECT_TRUE() for more information.
> + */
> +#define KUNIT_EXPECT_NOT_NULL(test, ptr)                                      \
> +       KUNIT_BINARY_PTR_NE_ASSERTION(test,                                    \
> +                                     KUNIT_EXPECTATION,                       \
> +                                     (typeof(ptr))NULL,                       \
> +                                     ptr)
> +
> +#define KUNIT_EXPECT_NOT_NULL_MSG(test, ptr, fmt, ...)                        \
> +       KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,                                \
> +                                         KUNIT_EXPECTATION,                   \
> +                                         (typeof(ptr))NULL,                   \
> +                                         ptr,                                 \
> +                                         fmt,                                 \
> +                                         ##__VA_ARGS__)
> +
> +                          /**
>   * KUNIT_EXPECT_NE() - An expectation that @left and @right are not equal.
>   * @test: The test context object.
>   * @left: an arbitrary expression that evaluates to a primitive C type.
> @@ -1678,6 +1723,52 @@ do {                                                                            \
>                                           fmt,                                 \
>                                           ##__VA_ARGS__)
>
> +/**
> + * KUNIT_ASSERT_NULL() - Asserts that pointers @ptr is null.
> + * @test: The test context object.
> + * @ptr: an arbitrary pointer.
> + *
> + * Sets an assertion that the values that @ptr evaluates to is null. This is
> + * the same as KUNIT_EXPECT_NULL(), except it causes an assertion
> + * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
> + */
> +#define KUNIT_ASSERT_NULL(test, ptr) \
> +       KUNIT_BINARY_PTR_EQ_ASSERTION(test,                                    \
> +                                     KUNIT_ASSERTION,                         \
> +                                     (typeof(ptr))NULL,                       \
> +                                     ptr)
> +
> +#define KUNIT_ASSERT_NULL_MSG(test, ptr, fmt, ...) \
> +       KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,                                \
> +                                         KUNIT_ASSERTION,                     \
> +                                         (typeof(ptr))NULL,                   \
> +                                         ptr,                                 \
> +                                         fmt,                                 \
> +                                         ##__VA_ARGS__)
> +
> +/**
> + * KUNIT_ASSERT_NOT_NULL() - Asserts that pointers @ptr is not null.
> + * @test: The test context object.
> + * @ptr: an arbitrary pointer.
> + *
> + * Sets an assertion that the values that @ptr evaluates to is not null. This
> + * is the same as KUNIT_EXPECT_NOT_NULL(), except it causes an assertion
> + * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
> + */
> +#define KUNIT_ASSERT_NOT_NULL(test, ptr) \
> +       KUNIT_BINARY_PTR_NE_ASSERTION(test,                                    \
> +                                     KUNIT_ASSERTION,                         \
> +                                     (typeof(ptr))NULL,                       \
> +                                     ptr)
> +
> +#define KUNIT_ASSERT_NOT_NULL_MSG(test, ptr, fmt, ...)                        \
> +       KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,                                \
> +                                         KUNIT_ASSERTION,                     \
> +                                         (typeof(ptr))NULL,                   \
> +                                         ptr,                                 \
> +                                         fmt,                                 \
> +                                         ##__VA_ARGS__)
> +
>  /**
>   * KUNIT_ASSERT_NE() - An assertion that @left and @right are not equal.
>   * @test: The test context object.

Cheers!
