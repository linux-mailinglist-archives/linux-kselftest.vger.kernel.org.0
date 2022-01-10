Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A8E48A2D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jan 2022 23:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbiAJWcK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jan 2022 17:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241297AbiAJWcK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jan 2022 17:32:10 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0935C06173F
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 14:32:09 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so1230186pjf.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 14:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DbbsQWjyXtZdlOn4Dc6o7hTt4Ddd2iucIvvroUkrD6w=;
        b=ka2FvWLMfFsTIz3WuYux3yNx3kQvAAlxmSOLJVot5jlnH57wRyrYAvxT8s7wnIWTEL
         2DeN5J0u+FcJLXpLjnC/SXfX6pLzLKP/YHMGViiORk+Rj8UQSKgNMloGmkEu6UgvVkJe
         vCCuouP6I52AqQPQqbRsMDt6JS7yZUlXv0uLsq0vIVAUPhbDML3+N5Wphgc7EVFMlOio
         RiXY9neN+oDZrzZdfQMw5NzwdbbX4h5HP4tI5WgceQ+m/9MXplBM+ahaG4A+L+zmTFws
         6h3R/LTEZnJ/j3VdaeDT0wyjabJE8Y9FivVMKhfyEcQ3UWSxOkabYgBm0P0ttxkgEz+o
         35Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DbbsQWjyXtZdlOn4Dc6o7hTt4Ddd2iucIvvroUkrD6w=;
        b=Ppc0PqaAcy3wkC2S637qn69jpyMgqxUkY/iFbcMgwpL1EOqhK47M5QTTx/gYDybxM4
         FTvxAV5YqXswbYvO63lgKUqxKigTmdVVnriWv7uvUo1LLGt9dyizvzDDvWAp6mVdO2Df
         3/gdaMygSokwRGEjBhUMoXuJze9huYiY6U0jmP5kD5v0o8YqDU4U3UIuCnTvmEcS2SSi
         T1Qg60CCKYnEJtUuXglE9SsHVhuxEuzDlruS92UuGa42n0Nys+QIbj2geNUNJhbgFxal
         xxe9qpQSpql56rSoJNjuI7QCyMl+O7albewBmDuDhsGztpzTXq0A1+T6JnD3GbypBXBu
         hEyA==
X-Gm-Message-State: AOAM530amPSAYVSCQBLAoCNXm+xJdvL+L7gytQQZguMfgq9my4c8/hZ/
        SWJrJj8sveyh1MTq8POFh/AlgdhAXtQ91bRwvscsxA==
X-Google-Smtp-Source: ABdhPJwW79BM2QnjJ1OTqgs3/C3n5ydKSFjahOECAE+mVb59xdfD4fkQIXU9WBI4ZfZoIimggMU02KCTeEkgXNq12f4=
X-Received: by 2002:a17:90a:e018:: with SMTP id u24mr1919206pjy.95.1641853929130;
 Mon, 10 Jan 2022 14:32:09 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-5-dlatypov@google.com>
In-Reply-To: <20220108012304.1049587-5-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 10 Jan 2022 17:31:58 -0500
Message-ID: <CAFd5g47r8aQBWPtt6ffHokqqN2sMi10p1Q5QA3xGVLTVDQh98Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] kunit: factor out kunit_base_assert_format() call
 into kunit_fail()
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
> We call this function first thing for all the assertion `format()`
> functions.
> This is the part that prints the file and line number and assertion type
> (EXPECTATION, ASSERTION).
>
> Having it as part of the format functions lets us have the flexibility
> to not print that information (or print it differently) for new
> assertion types, but I think this we don't need that.

nit: drop the "this".

> And in the future, we'd like to consider factoring that data (file,
> line#, type) out of the kunit_assert struct and into a `static`
> variable, as Linus suggested [1], so we'd need to extract it anyways.
>
> [1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
>  lib/kunit/assert.c | 6 ------
>  lib/kunit/test.c   | 1 +
>  2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index b972bda61c0c..4d9a1295efc7 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -40,7 +40,6 @@ EXPORT_SYMBOL_GPL(kunit_assert_print_msg);
>  void kunit_fail_assert_format(const struct kunit_assert *assert,
>                               struct string_stream *stream)
>  {
> -       kunit_base_assert_format(assert, stream);
>         string_stream_add(stream, "%pV", &assert->message);
>  }
>  EXPORT_SYMBOL_GPL(kunit_fail_assert_format);
> @@ -52,7 +51,6 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
>
>         unary_assert = container_of(assert, struct kunit_unary_assert, assert);
>
> -       kunit_base_assert_format(assert, stream);
>         if (unary_assert->expected_true)
>                 string_stream_add(stream,
>                                   KUNIT_SUBTEST_INDENT "Expected %s to be true, but is false\n",
> @@ -73,7 +71,6 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
>         ptr_assert = container_of(assert, struct kunit_ptr_not_err_assert,
>                                   assert);
>
> -       kunit_base_assert_format(assert, stream);
>         if (!ptr_assert->value) {
>                 string_stream_add(stream,
>                                   KUNIT_SUBTEST_INDENT "Expected %s is not null, but is\n",
> @@ -119,7 +116,6 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>         binary_assert = container_of(assert, struct kunit_binary_assert,
>                                      assert);
>
> -       kunit_base_assert_format(assert, stream);
>         string_stream_add(stream,
>                           KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
>                           binary_assert->left_text,
> @@ -147,7 +143,6 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
>         binary_assert = container_of(assert, struct kunit_binary_ptr_assert,
>                                      assert);
>
> -       kunit_base_assert_format(assert, stream);
>         string_stream_add(stream,
>                           KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
>                           binary_assert->left_text,
> @@ -187,7 +182,6 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>         binary_assert = container_of(assert, struct kunit_binary_str_assert,
>                                      assert);
>
> -       kunit_base_assert_format(assert, stream);
>         string_stream_add(stream,
>                           KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
>                           binary_assert->left_text,
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 5ad671745483..735c1b67d843 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -255,6 +255,7 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
>                 return;
>         }
>
> +       kunit_base_assert_format(assert, stream);

I think my thinking in having this function called by the other assert
functions was to take advantage of inheritance. I was treating
kunit_base_assert_format as the parent method that other methods were
inheriting from, so I wanted to have them inherit some of the common
behavior by calling the original function.

If you decide to make this change, I think it would be a good idea to
change the name of kunit_base_assert_format to not mislead to this
effect.

>         assert->format(assert, stream);
>
>         kunit_print_string_stream(test, stream);
> --
> 2.34.1.575.g55b058a8bb-goog
>
