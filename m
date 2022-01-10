Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF2448A2A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jan 2022 23:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbiAJWVy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jan 2022 17:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241447AbiAJWVx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jan 2022 17:21:53 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F2BC061748
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 14:21:53 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso1279841pje.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 14:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpEgaA7tQQxRTXpViippoUOAKxED1oc92U+eN95LNGs=;
        b=Hn++l73OqhxLfme2ErG2NqRu9ncAa+tUVLdIKUfHhZxaidp4c7iue3e8A5v7PyIFIG
         QmO+PYhfi5xJoqAWLdAvi3zyIXYfDeLbcd2v8rWPgHzM0Gkk5OjEkoKCiCJCUiCorRmJ
         c9CCKtbz4SERrhgz1qeXtCFRuQVC9YbVKmqNu1SnfNWoLFSo4BTJGzP99+iNa1NJfvTn
         3g7MwaTneEG1gIRuUaF+CbS8VTj0/L2LkNgVSy6ILJhHv7EPCX8ITbeOh3BWo+nuIXmP
         zEhsFaVwFTD0zo2zi39CbHch1gVGB47ATJVfKbdItybJZnCPl2hB6hK55QIIM76/OEWf
         A1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpEgaA7tQQxRTXpViippoUOAKxED1oc92U+eN95LNGs=;
        b=1/uyOVuLIgHpmO0MsoiWXwklm8VpqT7zJ81Ilfk6qdWAHhExOHAmTa4T//sHhYKRZn
         Vy1b8GOrv3BixGfnvOw83ayA32bRqfb/D/cBjj9uitK8J+EmIZriCtUcHUINYHzEbQnK
         SkYqNb05A+NcEwjbnzSuKkA17F1IXi/f3jA2nnRPFlr5ho6w+LlG3uwACUygyI05e2Xt
         L9SFgnCZlNeN4Ob7oav9URUQu+OrRzE3IcrIrIlZ8pBxF5uNdEknJO4ayeB+/ThdO54v
         3uQ8Zu07n3UBN48lgJBRrPPweYV7sZntF6se+FMtzJBZ/1MG9h/irAcjbpqKn4CoDJ1W
         1POg==
X-Gm-Message-State: AOAM531Rz/yJyhN06WI7vsj0T0K60MePjGCAW/W/DD9kcZb6B+wEJTeU
        3P3upsa6KVaCnDamDmdD3/sEhfmFXfcEt2eY8wPylw==
X-Google-Smtp-Source: ABdhPJzU68WaUrCxAJr0XWxbBe2huF8ZD7GWtX8Nh04kLOHZS3nCqLkZsig9aqAB5u3s7goLMXyUd0Ng5bYukv2mPdM=
X-Received: by 2002:a62:80c2:0:b0:4bb:47a:6983 with SMTP id
 j185-20020a6280c2000000b004bb047a6983mr1823271pfd.24.1641853312838; Mon, 10
 Jan 2022 14:21:52 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-3-dlatypov@google.com>
In-Reply-To: <20220108012304.1049587-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 10 Jan 2022 17:21:41 -0500
Message-ID: <CAFd5g45HcdzB_CTNRRpH8BFbBvG0nDS4_6VUj3Tqx8XOuVTNOQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] kunit: move check if assertion passed into the macros
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 7, 2022 at 8:23 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently the code always calls kunit_do_assertion() even though it does
> nothing when `pass` is true.
>
> This change moves the `if(!(pass))` check into the macro instead
> and renames the function to kunit_failed_assertion().
> I feel this a  bit easier to read and understand.
>
> This has the potential upside of avoiding a function call that does
> nothing most of the time (assuming your tests are passing) but comes
> with the downside of generating a bit more code and branches.
>
> This also means we don't have to initialize structs that we don't need,
> which will become a tiny bit more expensive if we switch over to using
> static variables to try and reduce stack usage. (There's runtime code
> to check if the variable has been initialized yet or not).
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Tiny nit, see below. Otherwise:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  include/kunit/test.h | 20 ++++++++++----------
>  lib/kunit/test.c     | 13 ++++---------
>  2 files changed, 14 insertions(+), 19 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index b26400731c02..690a28dfc795 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -770,18 +770,18 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
>   */
>  #define KUNIT_SUCCEED(test) do {} while (0)
>
> -void kunit_do_assertion(struct kunit *test,
> -                       struct kunit_assert *assert,
> -                       bool pass,
> -                       const char *fmt, ...);
> +void kunit_failed_assertion(struct kunit *test,
> +                           struct kunit_assert *assert,
> +                           const char *fmt, ...);

Tiny nit: I think this should be kunit_fail_assertion. I think
functions should be in the active tense, imperative mood since when
you call a function you are telling it to do something.

Also, do we need to worry about this getting confused with KUNIT_FAIL,
or KUNIT_FAIL_ASSERTION:

https://elixir.bootlin.com/linux/v5.16/source/include/kunit/test.h#L788

?

>  #define KUNIT_ASSERTION(test, pass, assert_class, INITIALIZER, fmt, ...) do {  \
> -       struct assert_class __assertion = INITIALIZER;                         \
> -       kunit_do_assertion(test,                                               \
> -                          &__assertion.assert,                                \
> -                          pass,                                               \
> -                          fmt,                                                \
> -                          ##__VA_ARGS__);                                     \
> +       if (!(pass)) {                                                         \
> +               struct assert_class __assertion = INITIALIZER;                 \
> +               kunit_failed_assertion(test,                                   \
> +                                      &__assertion.assert,                    \
> +                                      fmt,                                    \
> +                                      ##__VA_ARGS__);                         \
> +       }                                                                      \
>  } while (0)
>
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c7ed4aabec04..5ad671745483 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -275,16 +275,11 @@ static void __noreturn kunit_abort(struct kunit *test)
>         WARN_ONCE(true, "Throw could not abort from test!\n");
>  }
>
> -void kunit_do_assertion(struct kunit *test,
> -                       struct kunit_assert *assert,
> -                       bool pass,
> -                       const char *fmt, ...)
> +void kunit_failed_assertion(struct kunit *test,
> +                           struct kunit_assert *assert,
> +                           const char *fmt, ...)
>  {
>         va_list args;
> -
> -       if (pass)
> -               return;
> -
>         va_start(args, fmt);
>
>         assert->message.fmt = fmt;
> @@ -297,7 +292,7 @@ void kunit_do_assertion(struct kunit *test,
>         if (assert->type == KUNIT_ASSERTION)
>                 kunit_abort(test);
>  }
> -EXPORT_SYMBOL_GPL(kunit_do_assertion);
> +EXPORT_SYMBOL_GPL(kunit_failed_assertion);
>
>  void kunit_init_test(struct kunit *test, const char *name, char *log)
>  {
> --
> 2.34.1.575.g55b058a8bb-goog
>
