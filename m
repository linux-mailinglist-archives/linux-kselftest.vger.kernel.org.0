Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8B848BC67
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jan 2022 02:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347709AbiALB12 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 20:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347704AbiALB11 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 20:27:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E984C061748
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 17:27:27 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t28so1432027wrb.4
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 17:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tj2pvYDv6Ipnrldy/N1q6PhVC/7W/hCwGex/zPraktk=;
        b=o3jJ2+e5hJrAN1DGFKBJn81jFwORNK6a+QbJmIlx+gXamt1ChCJGXNBi1lK9po0Ogl
         m1dTjf8EYASkNsYV54O0swKjlFo2bPfpYecAkLutmEwJdmuWXyVdpOe0ajpBSyKAWgZo
         dMaWtESTTjnhJ846vqIMBazHoF6rAkqQ0skfv8Ln1FXvefWQ2Ko9a1L+KdvhFBuNwYh+
         lOkOHtX4YcNrU2QVk5W0URUlQTAetVpTWA9jFeRgKkQu8cbljJKPcNgmHrX22Kps9Z7v
         0TefQtYWMwbSaqw1bgiesWmXV37LtHLhkOZ+LWJvynCFCdkh8ZOBaUcH2+RUsaKfI5EC
         XsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tj2pvYDv6Ipnrldy/N1q6PhVC/7W/hCwGex/zPraktk=;
        b=OBuOiU3AVb+9CSS5yGoMFFFWWKmSxaVV2cEAQhZPkMK0BhI7HxxSpmUaTA4fZRqBDr
         nG5nKyzqZ73kYXtsjqTbi+/bEhy88RBHM6qEu3gUSuwhi2DLW3jEBJWyHIHwLgJGIn7L
         hVGbRpFlvTsTxCd+B5mnp3D7ZJLK7JXd4XCLc3NJN7bFkQypCC0a5OR+H61kY24PElcW
         saMXgmmzIouP6CtsQEYA8QGFtc57vANeAa1IUE3ZkSy4fFs98m4nNYdUFjpaBMUDkuUx
         Q6GRcnaDRe6A4MPPJUxszrKAxAiIuUYr2WhsnXQqZT4/aLMoOL3I7wBU+S8Y47qgAR8g
         PmYA==
X-Gm-Message-State: AOAM532yUg4N3NS0ZINYTVmMnCoUfio67FJAQvuvEf7uRVmey+q5dUIv
        GQuMl4YjBewKFXBlTLVFnPgztc8ZL6F+kYt+txXiOg==
X-Google-Smtp-Source: ABdhPJyAZRep2+ICv+QETxvVv0pXaOckG5uppkj2uo5sB2zlApP3xXncehYz1Dj27z2GFj+GHkIkZTP4ll4UXoYrgjU=
X-Received: by 2002:a05:6000:154c:: with SMTP id 12mr5905274wry.447.1641950845305;
 Tue, 11 Jan 2022 17:27:25 -0800 (PST)
MIME-Version: 1.0
References: <20220111194231.1797841-1-dlatypov@google.com> <20220111194231.1797841-3-dlatypov@google.com>
In-Reply-To: <20220111194231.1797841-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 12 Jan 2022 09:27:13 +0800
Message-ID: <CABVgOSnpGBsm9nONGyKkNFOb8ycxnt4pe4P65R7Gp0eYBJW9pA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] kunit: move check if assertion passed into the macros
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 12, 2022 at 3:42 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently the code always calls kunit_do_assertion() even though it does
> nothing when `pass` is true.
>
> This change moves the `if(!(pass))` check into the macro instead
> and renames the function to kunit_do_failed_assertion().
> I feel this a  bit easier to read and understand.
>
> This has the potential upside of avoiding a function call that does
> nothing most of the time (assuming your tests are passing) but comes
> with the downside of generating a bit more code and branches. We try to
> mitigate the branches by tagging them with `unlikely()`.
>
> This also means we don't have to initialize structs that we don't need,
> which will become a tiny bit more expensive if we switch over to using
> static variables to try and reduce stack usage. (There's runtime code
> to check if the variable has been initialized yet or not).
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> ---

This looks good. I'm still not 100% sold that putting the if() outside
the function is significantly easier to read, but I don't think it's
harder to read either, and getting rid of the function call is
probably worth it.

Reviewed-by: David Gow <davidgow@google.com>

-- David

>  include/kunit/test.h | 21 +++++++++++----------
>  lib/kunit/test.c     | 13 ++++---------
>  2 files changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index b26400731c02..12cabd15449a 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -12,6 +12,7 @@
>  #include <kunit/assert.h>
>  #include <kunit/try-catch.h>
>
> +#include <linux/compiler.h>
>  #include <linux/container_of.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> @@ -770,18 +771,18 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
>   */
>  #define KUNIT_SUCCEED(test) do {} while (0)
>
> -void kunit_do_assertion(struct kunit *test,
> -                       struct kunit_assert *assert,
> -                       bool pass,
> -                       const char *fmt, ...);
> +void kunit_do_failed_assertion(struct kunit *test,
> +                              struct kunit_assert *assert,
> +                              const char *fmt, ...);
>
>  #define KUNIT_ASSERTION(test, pass, assert_class, INITIALIZER, fmt, ...) do {  \
> -       struct assert_class __assertion = INITIALIZER;                         \
> -       kunit_do_assertion(test,                                               \
> -                          &__assertion.assert,                                \
> -                          pass,                                               \
> -                          fmt,                                                \
> -                          ##__VA_ARGS__);                                     \
> +       if (unlikely(!(pass))) {                                               \
> +               struct assert_class __assertion = INITIALIZER;                 \
> +               kunit_do_failed_assertion(test,                                \
> +                                         &__assertion.assert,                 \
> +                                         fmt,                                 \
> +                                         ##__VA_ARGS__);                      \
> +       }                                                                      \
>  } while (0)
>
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c7ed4aabec04..3a52c321c280 100644
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
> +void kunit_do_failed_assertion(struct kunit *test,
> +                              struct kunit_assert *assert,
> +                              const char *fmt, ...)
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
> +EXPORT_SYMBOL_GPL(kunit_do_failed_assertion);
>
>  void kunit_init_test(struct kunit *test, const char *name, char *log)
>  {
> --
> 2.34.1.575.g55b058a8bb-goog
>
