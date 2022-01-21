Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8391D495A91
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 08:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343781AbiAUHVw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 02:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiAUHVu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 02:21:50 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4534C06173F
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 23:21:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso20149848wms.4
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 23:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qambV4D1fzSoCrInjkGhTSgESM0jYX/AWgJ65yt09k8=;
        b=Hl1nsAC54+XQTR5AA9Jh4DdpagXVYi1AR3aFFnEGqgKtBR3RLbSg4keQ4MFkWvWNov
         FGsM7pgJb/bXYIOeIhRvE/1zVGHtIxoF2V/6GBHXVR6x+boIIUBfT14Yd3Cli1IX5s6d
         enB1sWaMcM3tvwulUmjYU+PQB5vKuDnDeRAqriu9ruoi8Do4bu5qxjc599+OEqD26BwV
         uzu3vOFUIk5/YyjodVInWxH3+DaTMzAZoS2Kk9opgv5JZNJq3i9a2Yk8iezTFTjDmBdO
         qNSVSrfEI1yhwmxR9qvj09Dfc/IuRqJwg53pjS29WcjXaCanSZ7Q/QXEejcUSvvfpaKv
         yy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qambV4D1fzSoCrInjkGhTSgESM0jYX/AWgJ65yt09k8=;
        b=YSRsBymbezhPyfwHZn45gZ0s0eXNsRrunytwLU00wxHaGdaJ0xaFfUBn+OFJkwCccD
         dEaSa5fMDAR719rN5f0ZNBb/1QcWAJaHexFY4Xiq0ytrjIdeH59Jhwmq2x6rY8IBYS/Y
         3LdpRXGTvEA2zcZOa+geCCwoW/nPMngbBK6vQdN1+qdineH9Dbw6g0H1jteb2xnKzIvd
         zzYwL2jsNwK+LZxC2LgAv4mlSFrCo18KlgSfj0TGA/nBHGZz35pESU+IvXjQlRM0xD0p
         OB3BxLGDrg6z4EwPcfYEjBu3pnWS9NTBZb8T+pGA/9gJ34hRWqMXFAwv0f6d5oX39vwc
         +sgw==
X-Gm-Message-State: AOAM531RrqWnxmuVhhZw6gPPuIFqSlcAGLSTTAaYkSfv9NNlAbIXTE2j
        YupBwecxrGj1wN22K3Wp+SGE2RAOvGsJubtd7dW7FA==
X-Google-Smtp-Source: ABdhPJzhb6YsxLlC4EzWDBoE8qMNnnjdutQxpcBaonRaCsw82ZHfcIAAMkgVviyx/0rln4290gGUgrR9OUr7Z7zcO1E=
X-Received: by 2002:adf:f48a:: with SMTP id l10mr2535592wro.220.1642749707998;
 Thu, 20 Jan 2022 23:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com> <20220118223506.1701553-2-dlatypov@google.com>
In-Reply-To: <20220118223506.1701553-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 21 Jan 2022 15:21:36 +0800
Message-ID: <CABVgOSnxUqJhVW8sm4HFOyRmHocej6i-52HxD0xXcxXx+Z5qzQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] kunit: make KUNIT_EXPECT_EQ() use KUNIT_EXPECT_EQ_MSG(),
 etc.
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
> There's quite a few macros in play for KUnit assertions.
>
> The current macro chain looks like:
>   KUNIT_EXPECT_EQ => KUNIT_BINARY_EQ_ASSERTION => KUNIT_BINARY_EQ_MSG_ASSERTION
>   KUNIT_EXPECT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION
>   KUNIT_ASSERT_EQ => KUNIT_BINARY_EQ_ASSERTION => KUNIT_BINARY_EQ_MSG_ASSERTION
>   KUNIT_ASSERT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION
>
> After this change:
>   KUNIT_EXPECT_EQ => KUNIT_EXPECT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION
>   KUNIT_ASSERT_EQ => KUNIT_ASSERT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION
> and we can drop the intermediate KUNIT_BINARY_EQ_ASSERTION.
>
> This change does this for all the other macros as well.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

The sheer number of macros here was always a bit headache-inducing for
me, so this is a great improvement in my book. Thanks!

Reviewed-by: David Gow <davidgow@google.com>

>  include/kunit/test.h | 168 +++++++------------------------------------
>  1 file changed, 26 insertions(+), 142 deletions(-)

(It's great to see 116 fewer lines here!)


-- David

>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 5964af750d93..b032dd6816d2 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -840,9 +840,6 @@ void kunit_do_failed_assertion(struct kunit *test,
>                               fmt,                                             \
>                               ##__VA_ARGS__)
>
> -#define KUNIT_TRUE_ASSERTION(test, assert_type, condition) \
> -       KUNIT_TRUE_MSG_ASSERTION(test, assert_type, condition, NULL)
> -
>  #define KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, fmt, ...)      \
>         KUNIT_UNARY_ASSERTION(test,                                            \
>                               assert_type,                                     \
> @@ -851,9 +848,6 @@ void kunit_do_failed_assertion(struct kunit *test,
>                               fmt,                                             \
>                               ##__VA_ARGS__)
>
> -#define KUNIT_FALSE_ASSERTION(test, assert_type, condition) \
> -       KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, NULL)
> -
>  /*
>   * A factory macro for defining the assertions and expectations for the basic
>   * comparisons defined for the built in types.
> @@ -1000,13 +994,6 @@ do {                                                                             \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_EQ_ASSERTION(test, assert_type, left, right)             \
> -       KUNIT_BINARY_EQ_MSG_ASSERTION(test,                                    \
> -                                     assert_type,                             \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     NULL)
> -
>  #define KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,                                       \
>                                           assert_type,                         \
>                                           left,                                \
> @@ -1022,13 +1009,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_PTR_EQ_ASSERTION(test, assert_type, left, right)         \
> -       KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,                                \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         NULL)
> -
>  #define KUNIT_BINARY_NE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
>         KUNIT_BASE_NE_MSG_ASSERTION(test,                                      \
>                                     kunit_binary_assert,                       \
> @@ -1039,13 +1019,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_NE_ASSERTION(test, assert_type, left, right)             \
> -       KUNIT_BINARY_NE_MSG_ASSERTION(test,                                    \
> -                                     assert_type,                             \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     NULL)
> -
>  #define KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,                                       \
>                                           assert_type,                         \
>                                           left,                                \
> @@ -1061,13 +1034,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_PTR_NE_ASSERTION(test, assert_type, left, right)         \
> -       KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,                                \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         NULL)
> -
>  #define KUNIT_BINARY_LT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
>         KUNIT_BASE_LT_MSG_ASSERTION(test,                                      \
>                                     kunit_binary_assert,                       \
> @@ -1078,13 +1044,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_LT_ASSERTION(test, assert_type, left, right)             \
> -       KUNIT_BINARY_LT_MSG_ASSERTION(test,                                    \
> -                                     assert_type,                             \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     NULL)
> -
>  #define KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,                                       \
>                                           assert_type,                         \
>                                           left,                                \
> @@ -1100,13 +1059,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_PTR_LT_ASSERTION(test, assert_type, left, right)         \
> -       KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,                                \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         NULL)
> -
>  #define KUNIT_BINARY_LE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
>         KUNIT_BASE_LE_MSG_ASSERTION(test,                                      \
>                                     kunit_binary_assert,                       \
> @@ -1117,13 +1069,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_LE_ASSERTION(test, assert_type, left, right)             \
> -       KUNIT_BINARY_LE_MSG_ASSERTION(test,                                    \
> -                                     assert_type,                             \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     NULL)
> -
>  #define KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,                                       \
>                                           assert_type,                         \
>                                           left,                                \
> @@ -1139,13 +1084,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_PTR_LE_ASSERTION(test, assert_type, left, right)         \
> -       KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,                                \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         NULL)
> -
>  #define KUNIT_BINARY_GT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
>         KUNIT_BASE_GT_MSG_ASSERTION(test,                                      \
>                                     kunit_binary_assert,                       \
> @@ -1156,13 +1094,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_GT_ASSERTION(test, assert_type, left, right)             \
> -       KUNIT_BINARY_GT_MSG_ASSERTION(test,                                    \
> -                                     assert_type,                             \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     NULL)
> -
>  #define KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,                                       \
>                                           assert_type,                         \
>                                           left,                                \
> @@ -1178,13 +1109,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_PTR_GT_ASSERTION(test, assert_type, left, right)         \
> -       KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,                                \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         NULL)
> -
>  #define KUNIT_BINARY_GE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
>         KUNIT_BASE_GE_MSG_ASSERTION(test,                                      \
>                                     kunit_binary_assert,                       \
> @@ -1195,13 +1119,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_GE_ASSERTION(test, assert_type, left, right)             \
> -       KUNIT_BINARY_GE_MSG_ASSERTION(test,                                    \
> -                                     assert_type,                             \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     NULL)
> -
>  #define KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,                                       \
>                                           assert_type,                         \
>                                           left,                                \
> @@ -1217,13 +1134,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_PTR_GE_ASSERTION(test, assert_type, left, right)         \
> -       KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,                                \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         NULL)
> -
>  #define KUNIT_BINARY_STR_ASSERTION(test,                                      \
>                                    assert_type,                                \
>                                    left,                                       \
> @@ -1260,13 +1170,6 @@ do {                                                                            \
>                                    fmt,                                        \
>                                    ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_STR_EQ_ASSERTION(test, assert_type, left, right)         \
> -       KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,                                \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         NULL)
> -
>  #define KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,                                       \
>                                           assert_type,                         \
>                                           left,                                \
> @@ -1279,13 +1182,6 @@ do {                                                                            \
>                                    fmt,                                        \
>                                    ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_STR_NE_ASSERTION(test, assert_type, left, right)         \
> -       KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,                                \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         NULL)
> -
>  #define KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                         \
>                                                 assert_type,                   \
>                                                 ptr,                           \
> @@ -1304,12 +1200,6 @@ do {                                                                            \
>                         ##__VA_ARGS__);                                        \
>  } while (0)
>
> -#define KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, assert_type, ptr)           \
> -       KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
> -                                               assert_type,                   \
> -                                               ptr,                           \
> -                                               NULL)
> -
>  /**
>   * KUNIT_EXPECT_TRUE() - Causes a test failure when the expression is not true.
>   * @test: The test context object.
> @@ -1322,7 +1212,7 @@ do {                                                                             \
>   * *expectation failure*.
>   */
>  #define KUNIT_EXPECT_TRUE(test, condition) \
> -       KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)
> +       KUNIT_EXPECT_TRUE_MSG(test, condition, NULL)
>
>  #define KUNIT_EXPECT_TRUE_MSG(test, condition, fmt, ...)                      \
>         KUNIT_TRUE_MSG_ASSERTION(test,                                         \
> @@ -1341,7 +1231,7 @@ do {                                                                             \
>   * KUNIT_EXPECT_TRUE() for more information.
>   */
>  #define KUNIT_EXPECT_FALSE(test, condition) \
> -       KUNIT_FALSE_ASSERTION(test, KUNIT_EXPECTATION, condition)
> +       KUNIT_EXPECT_FALSE_MSG(test, condition, NULL)
>
>  #define KUNIT_EXPECT_FALSE_MSG(test, condition, fmt, ...)                     \
>         KUNIT_FALSE_MSG_ASSERTION(test,                                        \
> @@ -1362,7 +1252,7 @@ do {                                                                             \
>   * more information.
>   */
>  #define KUNIT_EXPECT_EQ(test, left, right) \
> -       KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
> +       KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_EQ_MSG(test, left, right, fmt, ...)                      \
>         KUNIT_BINARY_EQ_MSG_ASSERTION(test,                                    \
> @@ -1384,10 +1274,7 @@ do {                                                                            \
>   * more information.
>   */
>  #define KUNIT_EXPECT_PTR_EQ(test, left, right)                                \
> -       KUNIT_BINARY_PTR_EQ_ASSERTION(test,                                    \
> -                                     KUNIT_EXPECTATION,                       \
> -                                     left,                                    \
> -                                     right)
> +       KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, fmt, ...)                  \
>         KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,                                \
> @@ -1409,7 +1296,7 @@ do {                                                                             \
>   * more information.
>   */
>  #define KUNIT_EXPECT_NE(test, left, right) \
> -       KUNIT_BINARY_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
> +       KUNIT_EXPECT_NE_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_NE_MSG(test, left, right, fmt, ...)                      \
>         KUNIT_BINARY_NE_MSG_ASSERTION(test,                                    \
> @@ -1431,10 +1318,7 @@ do {                                                                            \
>   * more information.
>   */
>  #define KUNIT_EXPECT_PTR_NE(test, left, right)                                \
> -       KUNIT_BINARY_PTR_NE_ASSERTION(test,                                    \
> -                                     KUNIT_EXPECTATION,                       \
> -                                     left,                                    \
> -                                     right)
> +       KUNIT_EXPECT_PTR_NE_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_PTR_NE_MSG(test, left, right, fmt, ...)                  \
>         KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,                                \
> @@ -1456,7 +1340,7 @@ do {                                                                             \
>   * more information.
>   */
>  #define KUNIT_EXPECT_LT(test, left, right) \
> -       KUNIT_BINARY_LT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
> +       KUNIT_EXPECT_LT_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_LT_MSG(test, left, right, fmt, ...)                      \
>         KUNIT_BINARY_LT_MSG_ASSERTION(test,                                    \
> @@ -1478,7 +1362,7 @@ do {                                                                             \
>   * more information.
>   */
>  #define KUNIT_EXPECT_LE(test, left, right) \
> -       KUNIT_BINARY_LE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
> +       KUNIT_EXPECT_LE_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_LE_MSG(test, left, right, fmt, ...)                      \
>         KUNIT_BINARY_LE_MSG_ASSERTION(test,                                    \
> @@ -1500,7 +1384,7 @@ do {                                                                             \
>   * more information.
>   */
>  #define KUNIT_EXPECT_GT(test, left, right) \
> -       KUNIT_BINARY_GT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
> +       KUNIT_EXPECT_GT_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_GT_MSG(test, left, right, fmt, ...)                      \
>         KUNIT_BINARY_GT_MSG_ASSERTION(test,                                    \
> @@ -1522,7 +1406,7 @@ do {                                                                             \
>   * more information.
>   */
>  #define KUNIT_EXPECT_GE(test, left, right) \
> -       KUNIT_BINARY_GE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
> +       KUNIT_EXPECT_GE_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_GE_MSG(test, left, right, fmt, ...)                      \
>         KUNIT_BINARY_GE_MSG_ASSERTION(test,                                    \
> @@ -1544,7 +1428,7 @@ do {                                                                             \
>   * for more information.
>   */
>  #define KUNIT_EXPECT_STREQ(test, left, right) \
> -       KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
> +       KUNIT_EXPECT_STREQ_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_STREQ_MSG(test, left, right, fmt, ...)                   \
>         KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,                                \
> @@ -1566,7 +1450,7 @@ do {                                                                             \
>   * for more information.
>   */
>  #define KUNIT_EXPECT_STRNEQ(test, left, right) \
> -       KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
> +       KUNIT_EXPECT_STRNEQ_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_STRNEQ_MSG(test, left, right, fmt, ...)                  \
>         KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,                                \
> @@ -1587,7 +1471,7 @@ do {                                                                             \
>   * more information.
>   */
>  #define KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ptr) \
> -       KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_EXPECTATION, ptr)
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
>
>  #define KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)                 \
>         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
> @@ -1611,7 +1495,7 @@ do {                                                                             \
>   * this is otherwise known as an *assertion failure*.
>   */
>  #define KUNIT_ASSERT_TRUE(test, condition) \
> -       KUNIT_TRUE_ASSERTION(test, KUNIT_ASSERTION, condition)
> +       KUNIT_ASSERT_TRUE_MSG(test, condition, NULL)
>
>  #define KUNIT_ASSERT_TRUE_MSG(test, condition, fmt, ...)                      \
>         KUNIT_TRUE_MSG_ASSERTION(test,                                         \
> @@ -1630,7 +1514,7 @@ do {                                                                             \
>   * (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
>   */
>  #define KUNIT_ASSERT_FALSE(test, condition) \
> -       KUNIT_FALSE_ASSERTION(test, KUNIT_ASSERTION, condition)
> +       KUNIT_ASSERT_FALSE_MSG(test, condition, NULL)
>
>  #define KUNIT_ASSERT_FALSE_MSG(test, condition, fmt, ...)                     \
>         KUNIT_FALSE_MSG_ASSERTION(test,                                        \
> @@ -1650,7 +1534,7 @@ do {                                                                             \
>   * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
>   */
>  #define KUNIT_ASSERT_EQ(test, left, right) \
> -       KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
> +       KUNIT_ASSERT_EQ_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)                      \
>         KUNIT_BINARY_EQ_MSG_ASSERTION(test,                                    \
> @@ -1671,7 +1555,7 @@ do {                                                                             \
>   * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
>   */
>  #define KUNIT_ASSERT_PTR_EQ(test, left, right) \
> -       KUNIT_BINARY_PTR_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
> +       KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, fmt, ...)                  \
>         KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,                                \
> @@ -1692,7 +1576,7 @@ do {                                                                             \
>   * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
>   */
>  #define KUNIT_ASSERT_NE(test, left, right) \
> -       KUNIT_BINARY_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
> +       KUNIT_ASSERT_NE_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_NE_MSG(test, left, right, fmt, ...)                      \
>         KUNIT_BINARY_NE_MSG_ASSERTION(test,                                    \
> @@ -1714,7 +1598,7 @@ do {                                                                             \
>   * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
>   */
>  #define KUNIT_ASSERT_PTR_NE(test, left, right) \
> -       KUNIT_BINARY_PTR_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
> +       KUNIT_ASSERT_PTR_NE_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_PTR_NE_MSG(test, left, right, fmt, ...)                  \
>         KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,                                \
> @@ -1735,7 +1619,7 @@ do {                                                                             \
>   * is not met.
>   */
>  #define KUNIT_ASSERT_LT(test, left, right) \
> -       KUNIT_BINARY_LT_ASSERTION(test, KUNIT_ASSERTION, left, right)
> +       KUNIT_ASSERT_LT_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_LT_MSG(test, left, right, fmt, ...)                      \
>         KUNIT_BINARY_LT_MSG_ASSERTION(test,                                    \
> @@ -1756,7 +1640,7 @@ do {                                                                             \
>   * KUNIT_ASSERT_TRUE()) when the assertion is not met.
>   */
>  #define KUNIT_ASSERT_LE(test, left, right) \
> -       KUNIT_BINARY_LE_ASSERTION(test, KUNIT_ASSERTION, left, right)
> +       KUNIT_ASSERT_LE_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_LE_MSG(test, left, right, fmt, ...)                      \
>         KUNIT_BINARY_LE_MSG_ASSERTION(test,                                    \
> @@ -1778,7 +1662,7 @@ do {                                                                             \
>   * is not met.
>   */
>  #define KUNIT_ASSERT_GT(test, left, right) \
> -       KUNIT_BINARY_GT_ASSERTION(test, KUNIT_ASSERTION, left, right)
> +       KUNIT_ASSERT_GT_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_GT_MSG(test, left, right, fmt, ...)                      \
>         KUNIT_BINARY_GT_MSG_ASSERTION(test,                                    \
> @@ -1800,7 +1684,7 @@ do {                                                                             \
>   * is not met.
>   */
>  #define KUNIT_ASSERT_GE(test, left, right) \
> -       KUNIT_BINARY_GE_ASSERTION(test, KUNIT_ASSERTION, left, right)
> +       KUNIT_ASSERT_GE_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_GE_MSG(test, left, right, fmt, ...)                      \
>         KUNIT_BINARY_GE_MSG_ASSERTION(test,                                    \
> @@ -1821,7 +1705,7 @@ do {                                                                             \
>   * assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
>   */
>  #define KUNIT_ASSERT_STREQ(test, left, right) \
> -       KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
> +       KUNIT_ASSERT_STREQ_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_STREQ_MSG(test, left, right, fmt, ...)                   \
>         KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,                                \
> @@ -1843,7 +1727,7 @@ do {                                                                             \
>   * for more information.
>   */
>  #define KUNIT_ASSERT_STRNEQ(test, left, right) \
> -       KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
> +       KUNIT_ASSERT_STRNEQ_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...)                  \
>         KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,                                \
> @@ -1864,7 +1748,7 @@ do {                                                                             \
>   * KUNIT_ASSERT_TRUE()) when the assertion is not met.
>   */
>  #define KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr) \
> -       KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_ASSERTION, ptr)
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
>
>  #define KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)                 \
>         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
> --
> 2.34.1.703.g22d0c6ccf7-goog
>
