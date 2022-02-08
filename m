Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3894ACEBF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 03:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbiBHCQd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 21:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345653AbiBHCQa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 21:16:30 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E865C061A73
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 18:16:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f17so17156470edd.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 18:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pO7I7nK4McHm1CFdvaegV9HUAp48DVdwilqK64U5UCE=;
        b=QDVZNEaiTPpXxf7VGgIGS3fGbZwiAZmlB3zTjwtR0aq/bqKa0EsnRu+MqQmHFwl+6h
         Vkjb6pfY1B7grUEYEPXdJ4mjhwAexXB/GmLmLtJk5s4nzWJup8E5ZxI6fvyJ1XkkJX5h
         DsKyWLx54xI0dQBngDEhUY0BsWANO9GyTltOMCAlnxet11XYS91R1ShsiahBJc2g3PZt
         nVoe9BnqUS5Jpu59d6tRj50PgcKpwEHT94fyTvvp4n31vcQM/cgNTt5juWXRKAQJatnK
         RAXTTgKi0kBb6syDrM3HnAXG2SuSJuA9v5LftZN2oIqT6PoVcf2mszWxAWHzfmkoi/Y2
         NEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pO7I7nK4McHm1CFdvaegV9HUAp48DVdwilqK64U5UCE=;
        b=RiPvas7oKTNRQXEl/eG9j0eWpyjADMM2KmcTW+ybcJGV6NHcqhWWTl7bylZtIO36BQ
         qNK571rDhRAR9aKq9XiTVv2bBqKRA3UIdf+aX1TYOvZkJG5FqsKeV6CFDsinm3Vyevjk
         eKSvdPHCzi8Rdh+JkkUTDYDnsdIr6Bnh/lm1P3gd5X+c3A5k41dZpLFromfK6jmPFUsK
         lsn/lzgJd9wYMdKkBXlakv3v93ssbJKBUqrcD9QpapQoTOagzJhZOxC97utnL5zoeQyq
         WJImtMevjtrGnaayX2Af6nXoBrdrdleVO5N51/7DscVoaTmMk30BDbFGuLsXPbAu/w3a
         Focw==
X-Gm-Message-State: AOAM530QfS67PnQGuL1tDXMv2yV9Tn+Ef/9ot+lJZSY+v0Xz6IqUcJN7
        Nx34A/ac6jryXcTo43bLrHw3rgWyOrAJjv/U19d8sA==
X-Google-Smtp-Source: ABdhPJxDsBTIMui7By5utI7Osig4RsJqPUlVVlkgWlgOargyastrGvgx2fSuQHasco6ACBemjE2ovtUqjFk+II/rm9o=
X-Received: by 2002:aa7:d297:: with SMTP id w23mr2211700edq.313.1644286587831;
 Mon, 07 Feb 2022 18:16:27 -0800 (PST)
MIME-Version: 1.0
References: <20220207211144.1948690-1-ribalda@chromium.org>
In-Reply-To: <20220207211144.1948690-1-ribalda@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 7 Feb 2022 18:16:16 -0800
Message-ID: <CAGS_qxoO6HFXZjpm689gfHVwFj=ViWya=opY0FLMf7FDQOoS5Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] kunit: Introduce _NULL and _NOT_NULL macros
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
> Today, when we want to check if a pointer is NULL and not ERR we have
> two options:
>
> KUNIT_EXPECT_TRUE(test, ptr == NULL);
>
> or
>
> KUNIT_EXPECT_PTR_NE(test, ptr, (struct mystruct *)NULL);
>
> Create a new set of macros that take care of NULL checks.
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  include/kunit/test.h | 88 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 00b9ff7783ab..340169723669 100644
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
> + * semantically equivalent to KUNIT_EXPECT_PTR_EQ(@test, ptr, NULL).
> + * See KUNIT_EXPECT_TRUE() for more information.
> + */
> +#define KUNIT_EXPECT_NULL(test, ptr)                                          \
> +       KUNIT_EXPECT_PTR_EQ_MSG(test,                                          \
> +                               ptr,                                           \
> +                               NULL,                                  \
> +                               NULL)
> +
> +#define KUNIT_EXPECT_NULL_MSG(test, ptr, fmt, ...)                            \
> +       KUNIT_BINARY_PTR_ASSERTION(test,                                       \
> +                                  KUNIT_EXPECTATION,                          \
> +                                  ptr, ==, NULL,                              \
> +                                  fmt,                                        \
> +                                  ##__VA_ARGS__)

Sorry, I mentally skipped over this even while reading over it several times.
Not sure how. My brain just mentally rewrote it to what I was expecting.

I see you copy-pasted KUNIT_EXPECT_PTR_EQ() and then did s/right/NULL.
It works, but...

These macros would be more in line with their counterparts if we instead did

#define KUNIT_EXPECT_NULL(test, ptr) \
  KUNIT_EXPECT_NULL_MSG(test, ptr, NULL)

instead of having it go through *PTR_EQ_MSG()

> +
> +/**
> + * KUNIT_EXPECT_NOT_NULL() - Expects that @ptr is not null.
> + * @test: The test context object.
> + * @ptr: an arbitrary pointer.
> + *
> + * Sets an expectation that the value that @ptr evaluates to is not null. This
> + * is semantically equivalent to KUNIT_EXPECT_PTR_NE(@test, ptr, NULL).
> + * See KUNIT_EXPECT_TRUE() for more information.
> + */
> +#define KUNIT_EXPECT_NOT_NULL(test, ptr)                                      \
> +       KUNIT_EXPECT_PTR_NE_MSG(test,                                          \
> +                               ptr,                                           \
> +                               NULL,                                          \
> +                               NULL)

ditto here, KUNIT_EXPECT_NOT_NULL_MSG(test, ptr, NULL) would be more consistent.

> +
> +#define KUNIT_EXPECT_NOT_NULL_MSG(test, ptr, fmt, ...)                        \
> +       KUNIT_BINARY_PTR_ASSERTION(test,                                       \
> +                                  KUNIT_EXPECTATION,                          \
> +                                  ptr, !=, NULL,                              \
> +                                  fmt,                                        \
> +                                  ##__VA_ARGS__)
> +
>  /**
>   * KUNIT_EXPECT_NOT_ERR_OR_NULL() - Expects that @ptr is not null and not err.
>   * @test: The test context object.
> @@ -1485,6 +1529,50 @@ do {                                                                            \
>                                    fmt,                                        \
>                                    ##__VA_ARGS__)
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
> +       KUNIT_ASSERT_PTR_EQ_MSG(test,                                          \
> +                               ptr,                                           \
> +                               NULL,                                          \
> +                               NULL)
> +
> +#define KUNIT_ASSERT_NULL_MSG(test, ptr, fmt, ...) \
> +       KUNIT_BINARY_PTR_ASSERTION(test,                                       \
> +                                  KUNIT_ASSERTION,                            \
> +                                  ptr, ==, NULL,                              \
> +                                  fmt,                                        \
> +                                  ##__VA_ARGS__)
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
> +       KUNIT_ASSERT_PTR_NE_MSG(test,                                          \
> +                               ptr,                                           \
> +                               NULL,                                          \
> +                               NULL)
> +
> +#define KUNIT_ASSERT_NOT_NULL_MSG(test, ptr, fmt, ...) \
> +       KUNIT_BINARY_PTR_ASSERTION(test,                                       \
> +                                  KUNIT_ASSERTION,                            \
> +                                  ptr, !=, NULL,                              \
> +                                  fmt,                                        \
> +                                  ##__VA_ARGS__)
> +
>  /**
>   * KUNIT_ASSERT_NOT_ERR_OR_NULL() - Assertion that @ptr is not null and not err.
>   * @test: The test context object.
> --
> 2.35.0.263.gb82422642f-goog
>
