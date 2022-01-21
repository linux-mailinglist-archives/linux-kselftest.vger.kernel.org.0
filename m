Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC5A495A98
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 08:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378943AbiAUHWO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 02:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378987AbiAUHWN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 02:22:13 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A789BC06173F
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 23:22:12 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c2so16197494wml.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 23:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7GP4uMAcLNl7pURZeIJt40AyHKDnAeoqAf66YkNa0k=;
        b=L8oPvbg3Et5VlbpMavY6KB2v2zRluWxQ0E8N/f+T2h05k4etjIf43Z1/hMDA+g4OeG
         hKl6Y1fqvGdZrQ6WI2fEZ/iVk/ayLZ2PStF86iDvJ8uV+Mur840AG4Q5yy9LPuHjeqNy
         eQdcLDB8cGtzas6s5PajxjPGgyt5IKVqTRqe8F/cYvwRampvFTFlmTYk+dC8iU14CAhB
         sCQg0/NygXaCewfIlLxT/7hklnUbEvM0yZR8+KRb9T1iq9m0XRQ78piod8cro1cizutR
         ggLSIM+H+bwjvxMrSoGlm4DFKDblWCcmNm+3ucvpcMJ8rCo6R7F6axlcKCvkSukd7zuq
         iRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7GP4uMAcLNl7pURZeIJt40AyHKDnAeoqAf66YkNa0k=;
        b=Sne16BUe12u0yTyfJCFkcD0XI0YHEShmhGKvpPpyaTIj4Lg40OcFBSGyCe+xTnz62v
         NDHtcEromQZZwgA21CQptZfYadoNukfOv86qp5hmWZhslJTZVbmH/5h0+D0pj0qm4HOE
         pWt/Ao0kZxn0UHmCDQCiNOlZbgxCs1zYbNKLLDugEFUdrwvrJS34rpXeWZh2ls83is7u
         KSXvsmgcRPohhLfQFpb2zoKFxIFdxIHMyxXA09MczQ8V6NsJu09NXt9YuIHfYHlKUpKz
         wredJg+j9e1nr/sXeDQqFl7KOSuf6TY37467pDWJOJRORVSe0ua+iCUnruvbwEXizcbx
         vXiA==
X-Gm-Message-State: AOAM530UYfGt9fl+qIqlvEybHGIRtNDPJpMZKfAM/CNnfFONNmRQ7/m+
        jeHCvXwDbie43ff/OaUG34lFIMLSk0VYyMxnA9+12g==
X-Google-Smtp-Source: ABdhPJzxn3+PjyEfbZRNLKJMso3RImeHGUIpX9xgTENA7RO6025lm2pR05cvxKMqEavhBBLpZimpvkuoyqRMZ38fUvo=
X-Received: by 2002:a05:600c:1e19:: with SMTP id ay25mr12611201wmb.131.1642749731158;
 Thu, 20 Jan 2022 23:22:11 -0800 (PST)
MIME-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com> <20220118223506.1701553-6-dlatypov@google.com>
In-Reply-To: <20220118223506.1701553-6-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 21 Jan 2022 15:21:59 +0800
Message-ID: <CABVgOSkwk2a96b6-5jpwsqSVsc8jm72KKodsG3YpZaV9N78Rsw@mail.gmail.com>
Subject: Re: [PATCH 5/5] kunit: decrease macro layering for EQ/NE asserts
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 19, 2022 at 6:35 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Introduce KUNIT_BINARY_PTR_ASSERTION to match KUNIT_BINARY_INT_ASSERTION
> and make KUNIT_EXPECT_EQ and KUNIT_EXPECT_PTREQ use these instead of
> shared intermediate macros that only remove the need to type "==" or
> "!=".
>
> The current macro chain looks like:
> KUNIT_EXPECT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION => KUNIT_BASE_EQ_MSG_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> KUNIT_EXPECT_PTR_EQ_MSG => KUNIT_BINARY_PTR_EQ_MSG_ASSERTION => KUNIT_BASE_EQ_MSG_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> <ditto for NE and ASSERT>
>
> After this change:
> KUNIT_EXPECT_EQ_MSG => KUNIT_BINARY_INT_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> KUNIT_EXPECT_PTR_EQ_MSG => KUNIT_BINARY_PTR_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This is great: the macros are much simpler and nicer now. In fact,
this whole series is one of the nicest I've seen for a while: I can't
think of any serious downsides to any of it.

Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David


>  include/kunit/test.h | 173 ++++++++++++-------------------------------
>  1 file changed, 49 insertions(+), 124 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 48cf520b69ce..bf82c313223b 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -888,48 +888,6 @@ do {                                                                              \
>                         ##__VA_ARGS__);                                        \
>  } while (0)
>
> -#define KUNIT_BASE_EQ_MSG_ASSERTION(test,                                     \
> -                                   assert_class,                              \
> -                                   ASSERT_CLASS_INIT,                         \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ...)                                       \
> -       KUNIT_BASE_BINARY_ASSERTION(test,                                      \
> -                                   assert_class,                              \
> -                                   ASSERT_CLASS_INIT,                         \
> -                                   assert_type,                               \
> -                                   left, ==, right,                           \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
> -#define KUNIT_BASE_NE_MSG_ASSERTION(test,                                     \
> -                                   assert_class,                              \
> -                                   ASSERT_CLASS_INIT,                         \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ...)                                       \
> -       KUNIT_BASE_BINARY_ASSERTION(test,                                      \
> -                                   assert_class,                              \
> -                                   ASSERT_CLASS_INIT,                         \
> -                                   assert_type,                               \
> -                                   left, !=, right,                           \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
> -#define KUNIT_BINARY_EQ_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
> -       KUNIT_BASE_EQ_MSG_ASSERTION(test,                                      \
> -                                   kunit_binary_assert,                       \
> -                                   KUNIT_INIT_BINARY_ASSERT_STRUCT,           \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
>  #define KUNIT_BINARY_INT_ASSERTION(test,                                      \
>                                    assert_type,                                \
>                                    left,                                       \
> @@ -945,43 +903,18 @@ do {                                                                             \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,                                       \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ...)                                 \
> -       KUNIT_BASE_EQ_MSG_ASSERTION(test,                                      \
> -                                   kunit_binary_ptr_assert,                   \
> -                                   KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
> -#define KUNIT_BINARY_NE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
> -       KUNIT_BASE_NE_MSG_ASSERTION(test,                                      \
> -                                   kunit_binary_assert,                       \
> -                                   KUNIT_INIT_BINARY_ASSERT_STRUCT,           \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
> -#define KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,                                       \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ...)                                 \
> -       KUNIT_BASE_NE_MSG_ASSERTION(test,                                      \
> +#define KUNIT_BINARY_PTR_ASSERTION(test,                                      \
> +                                  assert_type,                                \
> +                                  left,                                       \
> +                                  op,                                         \
> +                                  right,                                      \
> +                                  fmt,                                        \
> +                                   ...)                                       \
> +       KUNIT_BASE_BINARY_ASSERTION(test,                                      \
>                                     kunit_binary_ptr_assert,                   \
>                                     KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
>                                     assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> +                                   left, op, right,                           \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> @@ -1082,12 +1015,11 @@ do {                                                                           \
>         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_EQ_MSG(test, left, right, fmt, ...)                      \
> -       KUNIT_BINARY_EQ_MSG_ASSERTION(test,                                    \
> -                                     KUNIT_EXPECTATION,                       \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     fmt,                                     \
> -                                     ##__VA_ARGS__)
> +       KUNIT_BINARY_INT_ASSERTION(test,                                       \
> +                                  KUNIT_EXPECTATION,                          \
> +                                  left, ==, right,                            \
> +                                  fmt,                                        \
> +                                   ##__VA_ARGS__)
>
>  /**
>   * KUNIT_EXPECT_PTR_EQ() - Expects that pointers @left and @right are equal.
> @@ -1104,12 +1036,11 @@ do {                                                                           \
>         KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, fmt, ...)                  \
> -       KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,                                \
> -                                         KUNIT_EXPECTATION,                   \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ##__VA_ARGS__)
> +       KUNIT_BINARY_PTR_ASSERTION(test,                                       \
> +                                  KUNIT_EXPECTATION,                          \
> +                                  left, ==, right,                            \
> +                                  fmt,                                        \
> +                                  ##__VA_ARGS__)
>
>  /**
>   * KUNIT_EXPECT_NE() - An expectation that @left and @right are not equal.
> @@ -1126,12 +1057,11 @@ do {                                                                           \
>         KUNIT_EXPECT_NE_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_NE_MSG(test, left, right, fmt, ...)                      \
> -       KUNIT_BINARY_NE_MSG_ASSERTION(test,                                    \
> -                                     KUNIT_EXPECTATION,                       \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     fmt,                                     \
> -                                     ##__VA_ARGS__)
> +       KUNIT_BINARY_INT_ASSERTION(test,                                       \
> +                                  KUNIT_EXPECTATION,                          \
> +                                  left, !=, right,                            \
> +                                  fmt,                                        \
> +                                   ##__VA_ARGS__)
>
>  /**
>   * KUNIT_EXPECT_PTR_NE() - Expects that pointers @left and @right are not equal.
> @@ -1148,12 +1078,11 @@ do {                                                                           \
>         KUNIT_EXPECT_PTR_NE_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_PTR_NE_MSG(test, left, right, fmt, ...)                  \
> -       KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,                                \
> -                                         KUNIT_EXPECTATION,                   \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ##__VA_ARGS__)
> +       KUNIT_BINARY_PTR_ASSERTION(test,                                       \
> +                                  KUNIT_EXPECTATION,                          \
> +                                  left, !=, right,                            \
> +                                  fmt,                                        \
> +                                  ##__VA_ARGS__)
>
>  /**
>   * KUNIT_EXPECT_LT() - An expectation that @left is less than @right.
> @@ -1358,12 +1287,11 @@ do {                                                                           \
>         KUNIT_ASSERT_EQ_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)                      \
> -       KUNIT_BINARY_EQ_MSG_ASSERTION(test,                                    \
> -                                     KUNIT_ASSERTION,                         \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     fmt,                                     \
> -                                     ##__VA_ARGS__)
> +       KUNIT_BINARY_INT_ASSERTION(test,                                       \
> +                                  KUNIT_ASSERTION,                            \
> +                                  left, ==, right,                            \
> +                                  fmt,                                        \
> +                                   ##__VA_ARGS__)
>
>  /**
>   * KUNIT_ASSERT_PTR_EQ() - Asserts that pointers @left and @right are equal.
> @@ -1379,12 +1307,11 @@ do {                                                                           \
>         KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, fmt, ...)                  \
> -       KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,                                \
> -                                         KUNIT_ASSERTION,                     \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ##__VA_ARGS__)
> +       KUNIT_BINARY_PTR_ASSERTION(test,                                       \
> +                                  KUNIT_ASSERTION,                            \
> +                                  left, ==, right,                            \
> +                                  fmt,                                        \
> +                                  ##__VA_ARGS__)
>
>  /**
>   * KUNIT_ASSERT_NE() - An assertion that @left and @right are not equal.
> @@ -1400,12 +1327,11 @@ do {                                                                           \
>         KUNIT_ASSERT_NE_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_NE_MSG(test, left, right, fmt, ...)                      \
> -       KUNIT_BINARY_NE_MSG_ASSERTION(test,                                    \
> -                                     KUNIT_ASSERTION,                         \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     fmt,                                     \
> -                                     ##__VA_ARGS__)
> +       KUNIT_BINARY_INT_ASSERTION(test,                                       \
> +                                  KUNIT_ASSERTION,                            \
> +                                  left, !=, right,                            \
> +                                  fmt,                                        \
> +                                   ##__VA_ARGS__)
>
>  /**
>   * KUNIT_ASSERT_PTR_NE() - Asserts that pointers @left and @right are not equal.
> @@ -1422,12 +1348,11 @@ do {                                                                           \
>         KUNIT_ASSERT_PTR_NE_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_PTR_NE_MSG(test, left, right, fmt, ...)                  \
> -       KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,                                \
> -                                         KUNIT_ASSERTION,                     \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ##__VA_ARGS__)
> +       KUNIT_BINARY_PTR_ASSERTION(test,                                       \
> +                                  KUNIT_ASSERTION,                            \
> +                                  left, !=, right,                            \
> +                                  fmt,                                        \
> +                                  ##__VA_ARGS__)
>  /**
>   * KUNIT_ASSERT_LT() - An assertion that @left is less than @right.
>   * @test: The test context object.
> --
> 2.34.1.703.g22d0c6ccf7-goog
>
