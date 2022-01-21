Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37924967D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 23:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiAUW0N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 17:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbiAUW0M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 17:26:12 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80272C06173D
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jan 2022 14:26:11 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g2so9248914pgo.9
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jan 2022 14:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yJdfXSqmBMRf7VSxOdNbi3LCubMR+icphODMR51kXU=;
        b=amF40r/0URe/YKOgmIMi8zys6bqsi6LWuWJh0LKtkZc4QfPXNbt/gZrPbcdz6Qig0F
         DxbXzUDE/f0CZkTSm/K9lBNcSgkcFIuxWEl0WJsGpohkZVmL5Agz6pqmW9vHw9dxmNDx
         6shMgSCG03KsGjID/gcidwdJabbSKpL9dan/o915NgX2MlzL+KdO2i3aUQumiR/sUADK
         qjXOcICyzFixTfx3Oqjhb9y5E37fJoKVaR+n4ZH40y2yhe8wKUCr43egiVEdjkQYYrgJ
         4jgNWenEcY9h1s3vdJ6RTa3IJmqv2yJURrSW8o6EecQMm4tAFwkkByEz695qW2yTeRoA
         DqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yJdfXSqmBMRf7VSxOdNbi3LCubMR+icphODMR51kXU=;
        b=ne3jhReVztN1wNc2gmBMoT4Fl+RmlGZbP4x+98hmhSHAIM7vAn3Ue4LjOw7E3arbPC
         qXoA0YeR+ObguHLIaD3nMzcZ0Z017TupLzysqacuD2m1p/tEFVH+IUzh06Hh389GdU4k
         idjwf8OJQRABnUE1vAODOJYRKdeI/xgYqaliAdKq9ZbYMVIUuNaQc1xspF52ZxYPn+Ib
         wrotZ9VRyGkQTSYL6QESfnlTBHVpd8F+SFSH3N+noBLJdbuktSaZZu/QgcTVnhrLqD6E
         71Ke7zp4nbyYdroAAnbmLAyzQJ87IOA46kJpNwAeeevkKDKTqYjs0ib6+qPpkEz2WIU2
         yRcQ==
X-Gm-Message-State: AOAM530KrlMg5rnYLyAInkrE2TAh1Ty0mo/y2u5bSx65rra69zvZsHeF
        JS8tHDsoe9xndzM/dzgBCC77ycA5x35DKYOuJ0OK4w==
X-Google-Smtp-Source: ABdhPJy9mhDfphA2zPj0r4xbiWlOGf+ZKiIQi/j4z77dTEzar3n1/OPVD6lrqoxsJesAqERn62z4DsmRi5EvvAN3Ews=
X-Received: by 2002:a63:1157:: with SMTP id 23mr4257011pgr.12.1642803970603;
 Fri, 21 Jan 2022 14:26:10 -0800 (PST)
MIME-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com> <20220118223506.1701553-6-dlatypov@google.com>
 <CABVgOSkwk2a96b6-5jpwsqSVsc8jm72KKodsG3YpZaV9N78Rsw@mail.gmail.com>
In-Reply-To: <CABVgOSkwk2a96b6-5jpwsqSVsc8jm72KKodsG3YpZaV9N78Rsw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 21 Jan 2022 17:25:58 -0500
Message-ID: <CAFd5g45qj6gA8u0qb8YYAHF9zpjJ-vFOMFTVP-WWHrUvKnUaXQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] kunit: decrease macro layering for EQ/NE asserts
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 21, 2022 at 2:22 AM David Gow <davidgow@google.com> wrote:
>
> On Wed, Jan 19, 2022 at 6:35 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Introduce KUNIT_BINARY_PTR_ASSERTION to match KUNIT_BINARY_INT_ASSERTION
> > and make KUNIT_EXPECT_EQ and KUNIT_EXPECT_PTREQ use these instead of
> > shared intermediate macros that only remove the need to type "==" or
> > "!=".
> >
> > The current macro chain looks like:
> > KUNIT_EXPECT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION => KUNIT_BASE_EQ_MSG_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> > KUNIT_EXPECT_PTR_EQ_MSG => KUNIT_BINARY_PTR_EQ_MSG_ASSERTION => KUNIT_BASE_EQ_MSG_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> > <ditto for NE and ASSERT>
> >
> > After this change:
> > KUNIT_EXPECT_EQ_MSG => KUNIT_BINARY_INT_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> > KUNIT_EXPECT_PTR_EQ_MSG => KUNIT_BINARY_PTR_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> This is great: the macros are much simpler and nicer now. In fact,
> this whole series is one of the nicest I've seen for a while: I can't
> think of any serious downsides to any of it.

I agree. I am a fan.

> Reviewed-by: David Gow <davidgow@google.com>
>
> Thanks,
> -- David
>
>
> >  include/kunit/test.h | 173 ++++++++++++-------------------------------
> >  1 file changed, 49 insertions(+), 124 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 48cf520b69ce..bf82c313223b 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -888,48 +888,6 @@ do {                                                                              \
> >                         ##__VA_ARGS__);                                        \
> >  } while (0)
> >
> > -#define KUNIT_BASE_EQ_MSG_ASSERTION(test,                                     \
> > -                                   assert_class,                              \
> > -                                   ASSERT_CLASS_INIT,                         \
> > -                                   assert_type,                               \
> > -                                   left,                                      \
> > -                                   right,                                     \
> > -                                   fmt,                                       \
> > -                                   ...)                                       \
> > -       KUNIT_BASE_BINARY_ASSERTION(test,                                      \
> > -                                   assert_class,                              \
> > -                                   ASSERT_CLASS_INIT,                         \
> > -                                   assert_type,                               \
> > -                                   left, ==, right,                           \
> > -                                   fmt,                                       \
> > -                                   ##__VA_ARGS__)
> > -
> > -#define KUNIT_BASE_NE_MSG_ASSERTION(test,                                     \
> > -                                   assert_class,                              \
> > -                                   ASSERT_CLASS_INIT,                         \
> > -                                   assert_type,                               \
> > -                                   left,                                      \
> > -                                   right,                                     \
> > -                                   fmt,                                       \
> > -                                   ...)                                       \
> > -       KUNIT_BASE_BINARY_ASSERTION(test,                                      \
> > -                                   assert_class,                              \
> > -                                   ASSERT_CLASS_INIT,                         \
> > -                                   assert_type,                               \
> > -                                   left, !=, right,                           \
> > -                                   fmt,                                       \
> > -                                   ##__VA_ARGS__)
> > -
> > -#define KUNIT_BINARY_EQ_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
> > -       KUNIT_BASE_EQ_MSG_ASSERTION(test,                                      \
> > -                                   kunit_binary_assert,                       \
> > -                                   KUNIT_INIT_BINARY_ASSERT_STRUCT,           \
> > -                                   assert_type,                               \
> > -                                   left,                                      \
> > -                                   right,                                     \
> > -                                   fmt,                                       \
> > -                                   ##__VA_ARGS__)
> > -
> >  #define KUNIT_BINARY_INT_ASSERTION(test,                                      \
> >                                    assert_type,                                \
> >                                    left,                                       \
> > @@ -945,43 +903,18 @@ do {                                                                             \
> >                                     fmt,                                       \
> >                                     ##__VA_ARGS__)
> >
> > -#define KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,                                       \
> > -                                         assert_type,                         \
> > -                                         left,                                \
> > -                                         right,                               \
> > -                                         fmt,                                 \
> > -                                         ...)                                 \
> > -       KUNIT_BASE_EQ_MSG_ASSERTION(test,                                      \
> > -                                   kunit_binary_ptr_assert,                   \
> > -                                   KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
> > -                                   assert_type,                               \
> > -                                   left,                                      \
> > -                                   right,                                     \
> > -                                   fmt,                                       \
> > -                                   ##__VA_ARGS__)
> > -
> > -#define KUNIT_BINARY_NE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
> > -       KUNIT_BASE_NE_MSG_ASSERTION(test,                                      \
> > -                                   kunit_binary_assert,                       \
> > -                                   KUNIT_INIT_BINARY_ASSERT_STRUCT,           \
> > -                                   assert_type,                               \
> > -                                   left,                                      \
> > -                                   right,                                     \
> > -                                   fmt,                                       \
> > -                                   ##__VA_ARGS__)
> > -
> > -#define KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,                                       \
> > -                                         assert_type,                         \
> > -                                         left,                                \
> > -                                         right,                               \
> > -                                         fmt,                                 \
> > -                                         ...)                                 \
> > -       KUNIT_BASE_NE_MSG_ASSERTION(test,                                      \
> > +#define KUNIT_BINARY_PTR_ASSERTION(test,                                      \
> > +                                  assert_type,                                \
> > +                                  left,                                       \
> > +                                  op,                                         \
> > +                                  right,                                      \
> > +                                  fmt,                                        \
> > +                                   ...)                                       \
> > +       KUNIT_BASE_BINARY_ASSERTION(test,                                      \
> >                                     kunit_binary_ptr_assert,                   \
> >                                     KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
> >                                     assert_type,                               \
> > -                                   left,                                      \
> > -                                   right,                                     \
> > +                                   left, op, right,                           \
> >                                     fmt,                                       \
> >                                     ##__VA_ARGS__)
> >
> > @@ -1082,12 +1015,11 @@ do {                                                                           \
> >         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
> >
> >  #define KUNIT_EXPECT_EQ_MSG(test, left, right, fmt, ...)                      \
> > -       KUNIT_BINARY_EQ_MSG_ASSERTION(test,                                    \
> > -                                     KUNIT_EXPECTATION,                       \
> > -                                     left,                                    \
> > -                                     right,                                   \
> > -                                     fmt,                                     \
> > -                                     ##__VA_ARGS__)
> > +       KUNIT_BINARY_INT_ASSERTION(test,                                       \
> > +                                  KUNIT_EXPECTATION,                          \
> > +                                  left, ==, right,                            \
> > +                                  fmt,                                        \
> > +                                   ##__VA_ARGS__)
> >
> >  /**
> >   * KUNIT_EXPECT_PTR_EQ() - Expects that pointers @left and @right are equal.
> > @@ -1104,12 +1036,11 @@ do {                                                                           \
> >         KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, NULL)
> >
> >  #define KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, fmt, ...)                  \
> > -       KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,                                \
> > -                                         KUNIT_EXPECTATION,                   \
> > -                                         left,                                \
> > -                                         right,                               \
> > -                                         fmt,                                 \
> > -                                         ##__VA_ARGS__)
> > +       KUNIT_BINARY_PTR_ASSERTION(test,                                       \
> > +                                  KUNIT_EXPECTATION,                          \
> > +                                  left, ==, right,                            \
> > +                                  fmt,                                        \
> > +                                  ##__VA_ARGS__)
> >
> >  /**
> >   * KUNIT_EXPECT_NE() - An expectation that @left and @right are not equal.
> > @@ -1126,12 +1057,11 @@ do {                                                                           \
> >         KUNIT_EXPECT_NE_MSG(test, left, right, NULL)
> >
> >  #define KUNIT_EXPECT_NE_MSG(test, left, right, fmt, ...)                      \
> > -       KUNIT_BINARY_NE_MSG_ASSERTION(test,                                    \
> > -                                     KUNIT_EXPECTATION,                       \
> > -                                     left,                                    \
> > -                                     right,                                   \
> > -                                     fmt,                                     \
> > -                                     ##__VA_ARGS__)
> > +       KUNIT_BINARY_INT_ASSERTION(test,                                       \
> > +                                  KUNIT_EXPECTATION,                          \
> > +                                  left, !=, right,                            \
> > +                                  fmt,                                        \
> > +                                   ##__VA_ARGS__)
> >
> >  /**
> >   * KUNIT_EXPECT_PTR_NE() - Expects that pointers @left and @right are not equal.
> > @@ -1148,12 +1078,11 @@ do {                                                                           \
> >         KUNIT_EXPECT_PTR_NE_MSG(test, left, right, NULL)
> >
> >  #define KUNIT_EXPECT_PTR_NE_MSG(test, left, right, fmt, ...)                  \
> > -       KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,                                \
> > -                                         KUNIT_EXPECTATION,                   \
> > -                                         left,                                \
> > -                                         right,                               \
> > -                                         fmt,                                 \
> > -                                         ##__VA_ARGS__)
> > +       KUNIT_BINARY_PTR_ASSERTION(test,                                       \
> > +                                  KUNIT_EXPECTATION,                          \
> > +                                  left, !=, right,                            \
> > +                                  fmt,                                        \
> > +                                  ##__VA_ARGS__)
> >
> >  /**
> >   * KUNIT_EXPECT_LT() - An expectation that @left is less than @right.
> > @@ -1358,12 +1287,11 @@ do {                                                                           \
> >         KUNIT_ASSERT_EQ_MSG(test, left, right, NULL)
> >
> >  #define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)                      \
> > -       KUNIT_BINARY_EQ_MSG_ASSERTION(test,                                    \
> > -                                     KUNIT_ASSERTION,                         \
> > -                                     left,                                    \
> > -                                     right,                                   \
> > -                                     fmt,                                     \
> > -                                     ##__VA_ARGS__)
> > +       KUNIT_BINARY_INT_ASSERTION(test,                                       \
> > +                                  KUNIT_ASSERTION,                            \
> > +                                  left, ==, right,                            \
> > +                                  fmt,                                        \
> > +                                   ##__VA_ARGS__)
> >
> >  /**
> >   * KUNIT_ASSERT_PTR_EQ() - Asserts that pointers @left and @right are equal.
> > @@ -1379,12 +1307,11 @@ do {                                                                           \
> >         KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, NULL)
> >
> >  #define KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, fmt, ...)                  \
> > -       KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,                                \
> > -                                         KUNIT_ASSERTION,                     \
> > -                                         left,                                \
> > -                                         right,                               \
> > -                                         fmt,                                 \
> > -                                         ##__VA_ARGS__)
> > +       KUNIT_BINARY_PTR_ASSERTION(test,                                       \
> > +                                  KUNIT_ASSERTION,                            \
> > +                                  left, ==, right,                            \
> > +                                  fmt,                                        \
> > +                                  ##__VA_ARGS__)
> >
> >  /**
> >   * KUNIT_ASSERT_NE() - An assertion that @left and @right are not equal.
> > @@ -1400,12 +1327,11 @@ do {                                                                           \
> >         KUNIT_ASSERT_NE_MSG(test, left, right, NULL)
> >
> >  #define KUNIT_ASSERT_NE_MSG(test, left, right, fmt, ...)                      \
> > -       KUNIT_BINARY_NE_MSG_ASSERTION(test,                                    \
> > -                                     KUNIT_ASSERTION,                         \
> > -                                     left,                                    \
> > -                                     right,                                   \
> > -                                     fmt,                                     \
> > -                                     ##__VA_ARGS__)
> > +       KUNIT_BINARY_INT_ASSERTION(test,                                       \
> > +                                  KUNIT_ASSERTION,                            \
> > +                                  left, !=, right,                            \
> > +                                  fmt,                                        \
> > +                                   ##__VA_ARGS__)
> >
> >  /**
> >   * KUNIT_ASSERT_PTR_NE() - Asserts that pointers @left and @right are not equal.
> > @@ -1422,12 +1348,11 @@ do {                                                                           \
> >         KUNIT_ASSERT_PTR_NE_MSG(test, left, right, NULL)
> >
> >  #define KUNIT_ASSERT_PTR_NE_MSG(test, left, right, fmt, ...)                  \
> > -       KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,                                \
> > -                                         KUNIT_ASSERTION,                     \
> > -                                         left,                                \
> > -                                         right,                               \
> > -                                         fmt,                                 \
> > -                                         ##__VA_ARGS__)
> > +       KUNIT_BINARY_PTR_ASSERTION(test,                                       \
> > +                                  KUNIT_ASSERTION,                            \
> > +                                  left, !=, right,                            \
> > +                                  fmt,                                        \
> > +                                  ##__VA_ARGS__)
> >  /**
> >   * KUNIT_ASSERT_LT() - An assertion that @left is less than @right.
> >   * @test: The test context object.
> > --
> > 2.34.1.703.g22d0c6ccf7-goog
> >
