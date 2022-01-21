Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B850495A96
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 08:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349075AbiAUHWJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 02:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378948AbiAUHWD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 02:22:03 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7BBC061401
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 23:22:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso26985139wmj.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 23:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VmI6L81UjLNgtF9bRaFGyCBanbzTKfgaJgajqJamXbM=;
        b=MAPvnqvS0FN162XpHjydAEv7oI4nPr3iw8GTYMFPlhT5IOFrDt/PPf5wMaewk8Q8a7
         DIheeIMMABjYqLfVMiWspKfSiyEypwxfyCU4ewf5kmaaPHtrxgtBhB88fCrRFoOUspSa
         uKBsJlJpqI+RgbJ3NpFDbgWNdsvN8QqJ6TcuzaaqFTnD+dRMhqoMAWmstBdss4503lNo
         Nd8yikxY2iTG1vvhvlbk5H4bndFtu4jJtD3txPAIfORgYWMKkTt4ALzie5K0oSEMLrC1
         LW+bmaPLUZlqBYwd1+vfc9ODHvFGxHqcb9QbsbJV3kF+6B/K3F4C7b5Tfn5qX3GmF42V
         m52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmI6L81UjLNgtF9bRaFGyCBanbzTKfgaJgajqJamXbM=;
        b=yxvWIf2COexkok6lpDpQyAI6vwv7I/eQG54SkXuI5K5mSPBtrg3LzSFmD6OdNnfsOm
         lq+qaPsFl92O2WnH/qJbCubE/K+VVotU+EcnfYbOzdYBdE/pSRgrH2ZWxK3QNu6ZcfE5
         AHMwInEPlM7880Zm+O7jksjoIFimJUJABlzgyG3Mukbe9DIHoqHLcqYWWhqOUDk3BIAE
         t8LejyaXpSjEaTgy1Y0/xdRtiLP0iHExXMCkTpwfmz8JCwqlNgs4ubKcTzFoeEaD/o2M
         Wiz+j+K/uI7IyrjfkYrAxcaT8sMxor6MK/J6BSdkSGNTx7w8fcUQIxxeiTpZCeE2zRRY
         0eOA==
X-Gm-Message-State: AOAM532JZpVlXYPu5xFDp1mmT4+HP59zgv0Elz540LTqv2h7Ztrb9l7h
        bTwpX3anMVF2LTuCS2hwZbLlaf6QL4Z9I/kxPPOUiw==
X-Google-Smtp-Source: ABdhPJz9sd+4Ev7yMRFJUnGKa5fROPuoLTcIRi8BEUyBG3qrdVOvLv3Qj6SpGQGPvuR4j84+tQX/gDKLSs2kzxrq4MI=
X-Received: by 2002:a05:600c:4154:: with SMTP id h20mr1191759wmm.18.1642749720935;
 Thu, 20 Jan 2022 23:22:00 -0800 (PST)
MIME-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com> <20220118223506.1701553-4-dlatypov@google.com>
In-Reply-To: <20220118223506.1701553-4-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 21 Jan 2022 15:21:49 +0800
Message-ID: <CABVgOSkm349TgYProFFghSrRomU4ZLCAqKzPSufRewtsxUJMVg@mail.gmail.com>
Subject: Re: [PATCH 3/5] kunit: reduce layering in string assertion macros
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
> The current macro chain looks like:
> KUNIT_EXPECT_STREQ => KUNIT_EXPECT_STREQ_MSG => KUNIT_BINARY_STR_EQ_MSG_ASSERTION => KUNIT_BINARY_STR_ASSERTION.
> KUNIT_ASSERT_STREQ => KUNIT_ASSERT_STREQ_MSG => KUNIT_BINARY_STR_EQ_MSG_ASSERTION => KUNIT_BINARY_STR_ASSERTION.
> <ditto for STR_NE>
>
> After this change:
> KUNIT_EXPECT_STREQ => KUNIT_EXPECT_STREQ_MSG => KUNIT_BINARY_STR_ASSERTION.
> KUNIT_ASSERT_STREQ => KUNIT_ASSERT_STREQ_MSG => KUNIT_BINARY_STR_ASSERTION.
> <ditto for STR_NE>
>
> All the intermediate macro did was pass in "==" or "!=", so it seems
> better to just drop them at the cost of a bit more copy-paste.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Agreed, I don't think the copy-paste here is significant enough to
have any real chance of causing problems. This is clearly an
improvement.

Reviewed-by: David Gow <davidgow@google.com>


-- David

>  include/kunit/test.h | 68 +++++++++++++-------------------------------
>  1 file changed, 20 insertions(+), 48 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index c021945a75e3..d5dc1ef68bfe 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1098,30 +1098,6 @@ do {                                                                            \
>                         ##__VA_ARGS__);                                        \
>  } while (0)
>
> -#define KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,                                       \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ...)                                 \
> -       KUNIT_BINARY_STR_ASSERTION(test,                                       \
> -                                  assert_type,                                \
> -                                  left, ==, right,                            \
> -                                  fmt,                                        \
> -                                  ##__VA_ARGS__)
> -
> -#define KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,                                       \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ...)                                 \
> -       KUNIT_BINARY_STR_ASSERTION(test,                                       \
> -                                  assert_type,                                \
> -                                  left, !=, right,                            \
> -                                  fmt,                                        \
> -                                  ##__VA_ARGS__)
> -
>  #define KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                         \
>                                                 assert_type,                   \
>                                                 ptr,                           \
> @@ -1371,12 +1347,11 @@ do {                                                                           \
>         KUNIT_EXPECT_STREQ_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_STREQ_MSG(test, left, right, fmt, ...)                   \
> -       KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,                                \
> -                                         KUNIT_EXPECTATION,                   \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ##__VA_ARGS__)
> +       KUNIT_BINARY_STR_ASSERTION(test,                                       \
> +                                  KUNIT_EXPECTATION,                          \
> +                                  left, ==, right,                            \
> +                                  fmt,                                        \
> +                                  ##__VA_ARGS__)
>
>  /**
>   * KUNIT_EXPECT_STRNEQ() - Expects that strings @left and @right are not equal.
> @@ -1393,12 +1368,11 @@ do {                                                                           \
>         KUNIT_EXPECT_STRNEQ_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_STRNEQ_MSG(test, left, right, fmt, ...)                  \
> -       KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,                                \
> -                                         KUNIT_EXPECTATION,                   \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ##__VA_ARGS__)
> +       KUNIT_BINARY_STR_ASSERTION(test,                                       \
> +                                  KUNIT_EXPECTATION,                          \
> +                                  left, !=, right,                            \
> +                                  fmt,                                        \
> +                                  ##__VA_ARGS__)
>
>  /**
>   * KUNIT_EXPECT_NOT_ERR_OR_NULL() - Expects that @ptr is not null and not err.
> @@ -1648,12 +1622,11 @@ do {                                                                           \
>         KUNIT_ASSERT_STREQ_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_STREQ_MSG(test, left, right, fmt, ...)                   \
> -       KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,                                \
> -                                         KUNIT_ASSERTION,                     \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ##__VA_ARGS__)
> +       KUNIT_BINARY_STR_ASSERTION(test,                                       \
> +                                  KUNIT_ASSERTION,                            \
> +                                  left, ==, right,                            \
> +                                  fmt,                                        \
> +                                  ##__VA_ARGS__)
>
>  /**
>   * KUNIT_ASSERT_STRNEQ() - Expects that strings @left and @right are not equal.
> @@ -1670,12 +1643,11 @@ do {                                                                           \
>         KUNIT_ASSERT_STRNEQ_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...)                  \
> -       KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,                                \
> -                                         KUNIT_ASSERTION,                     \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ##__VA_ARGS__)
> +       KUNIT_BINARY_STR_ASSERTION(test,                                       \
> +                                  KUNIT_ASSERTION,                            \
> +                                  left, !=, right,                            \
> +                                  fmt,                                        \
> +                                  ##__VA_ARGS__)
>
>  /**
>   * KUNIT_ASSERT_NOT_ERR_OR_NULL() - Assertion that @ptr is not null and not err.
> --
> 2.34.1.703.g22d0c6ccf7-goog
>
