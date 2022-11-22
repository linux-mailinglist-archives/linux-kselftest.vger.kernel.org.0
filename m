Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E74D63333E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 03:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiKVC0E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 21:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbiKVCZp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 21:25:45 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D342F609E
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 18:21:55 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-37063f855e5so131641677b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 18:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DKbxaJtTyZO5Z9ZBbZTMOsOtk3yKuoTVReeAVGJ3Pdw=;
        b=th40tW4wJgE8ZiaU/N3/Vp/zUV3VRt5UMK0PdcOPvQHtQP2r/uyRVg0+OO5SlBIcQC
         jws9pp8MNuXe4Tdy0WIAs8zTg18CNBl9qIqzEuxRbUhiHcHEB1+BVhMCCq8zRb5l2NH7
         LI9dCeopLGYOyUDchySF3vlWK2NmFiSreav5Ti8C6PO9iry70Du6sNSWK+12+1638g/8
         iIy6Uylx15vNePLram5wH1FQjOjZFb382lZ5JQ8EbvOh9GFkaEL2x5MP+UIZui0LF4v/
         CJzHTw3pV5UULKOtO66iJpIzm5PjlLCMgVVg2xs7UWrmuBuA691D6TI71Pg2psEwuZwL
         kZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKbxaJtTyZO5Z9ZBbZTMOsOtk3yKuoTVReeAVGJ3Pdw=;
        b=HsKzWlcRjrgUITpJLURt+gxM3cBkOIPACOm71ODg9OAkv9eudtAa5McyFR5vHNRj7S
         5tpkBIN5ilaYSKQcmrzFXE6+5DgVieqjF7BcrfZK4cpG0Mpzs5723RhmnW8y3G3c7Jpi
         04yrvCSJ/NQeLBcOvNP17CWICUUOMNmcER+bT15AIab9HgBVyOxiOLPC9b3xB1Q07d5y
         INcrrc/tRSjMcnwmVuV48exKdaM1N2xMumiFCy+OQlQxTeH+JFVsJrirycPRHbclhDwT
         /Xxtqma5X6rtSBffxujoXF0RAz0yV5e+Hx09BBt9Lcdh20WvTfM7JUC+wvBI+J/Xam7p
         UuRA==
X-Gm-Message-State: ANoB5pnJycNgU4NBbcWQXE2dBmlYkoS/pWKVvtMSfei4fm5zOvTUv9u4
        EaozktBY7c1vXbmfVXkMhpQad3tKmyWjRNZmSSqFtg==
X-Google-Smtp-Source: AA0mqf6ObbGFOG0xl7JeJ2WAVW0SXydm9VOOQCDq40H+EH4fN1M84S3y4P3BkTpJTxJHwIE4iR7GZri9IbvoRetEYZE=
X-Received: by 2002:a81:7b89:0:b0:388:dd9b:f3ee with SMTP id
 w131-20020a817b89000000b00388dd9bf3eemr2279367ywc.164.1669083714099; Mon, 21
 Nov 2022 18:21:54 -0800 (PST)
MIME-Version: 1.0
References: <20221119081252.3864249-1-davidgow@google.com> <20221119081252.3864249-2-davidgow@google.com>
In-Reply-To: <20221119081252.3864249-2-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 21 Nov 2022 18:21:43 -0800
Message-ID: <CAGS_qxqAUiMfKe2ksnqQtyWv0BWYLA4_uGqpu76d=Oh42mAUgQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kunit: Use the static key when retrieving the
 current test
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        Sadiya Kazi <sadiyakazi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 19, 2022 at 12:13 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> In order to detect if a KUnit test is running, and to access its
> context, the 'kunit_test' member of the current task_struct is used.
> Usually, this is accessed directly or via the kunit_fail_current_task()
> function.
>
> In order to speed up the case where no test is running, add a wrapper,
> kunit_get_current_test(), which uses the static key to fail early.
> Equally, Speed up kunit_fail_current_test() by using the static key.
>
> This should make it convenient for code to call this
> unconditionally in fakes or error paths, without worrying that this will
> slow the code down significantly.
>
> If CONFIG_KUNIT=n (or m), this compiles away to nothing. If
> CONFIG_KUNIT=y, it will compile down to a NOP (on most architectures) if
> no KUnit test is currently running.
>
> Note that kunit_get_current_test() does not work if KUnit is built as a
> module. This mirrors the existing restriction on kunit_fail_current_test().
>
> Note that the definition of kunit_fail_current_test() still wraps an
> empty, inline function if KUnit is not built-in. This is to ensure that
> the printf format string __attribute__ will still work.
>
> Also update the documentation to suggest users use the new
> kunit_get_current_test() function, update the example, and to describe
> the behaviour when KUnit is disabled better.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Sadiya Kazi <sadiyakazi@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Looks good to me, but some small optional nits about the Documentation.

I'm a bit sad that the kunit_fail_current_test() macro is now a bit
more complicated (has two definitions).
Optional: perhaps it's long enough now that we should have a comment
after the #endif, i.e.
#endif   /* IS_BUILTIN(CONFIG_KUNIT) */

<snip>

>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 2737863ef365..e70014b82350 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -625,17 +625,21 @@ as shown in next section: *Accessing The Current Test*.
>  Accessing The Current Test
>  --------------------------
>
> -In some cases, we need to call test-only code from outside the test file.
> -For example, see example in section *Injecting Test-Only Code* or if
> -we are providing a fake implementation of an ops struct. Using
> -``kunit_test`` field in ``task_struct``, we can access it via
> -``current->kunit_test``.
> +In some cases, we need to call test-only code from outside the test file,
> +for example,  when providing a fake implementation of a function, or to fail

nit: there are two spaces after "for example, "

Personal preference: I'd rather keep "For example," as the start of a
new sentence.

> +any current test from within an error handler.
> +We can do this via the ``kunit_test`` field in ``task_struct``, which we can
> +access using the ``kunit_get_current_test`` function in ``kunit/test-bug.h``.

Personal preference: kunit_get_current_test()
IMO that would make it easier to pick up when the reader is quickly
scanning over.

>
> -The example below includes how to implement "mocking":
> +``kunit_get_current_test`` requires KUnit be built-in to the kernel, i.e.
> +``CONFIG_KUNIT=y``. It is safe to call even if KUnit is not enabled, is built as a module,
> +or no test is currently running, in which case it will quickly return ``NULL``.

I find this sentence a bit confusing.

I think it's trying to convey that
* it can be called no matter how the kernel is built or what cmdline
args are given
* but it doesn't work properly for CONFIG_KUNIT=m
* for CONFIG_KUNIT=n, it's a static inline func that just returns NULL
* when booting with `kunit.enabled=0`, it's fast (thanks to static keys)

But the current wording basically says "the func requires
CONFIG_KUNIT=y" then says it's safe to call it even if CONFIG_KUNIT=n.
It feels a bit whiplashy.

Should this be reworded to say the function can be used regardless of
whether KUnit is enabled but add a `note` block about how it doesn't
properly for CONFIG_KUNIT=m?

> +
> +The example below uses this to implement a "mock" implementation of a function, ``foo``:
>
>  .. code-block:: c
>
> -       #include <linux/sched.h> /* for current */
> +       #include <kunit/test-bug.h> /* for kunit_get_current_test */
>
>         struct test_data {
>                 int foo_result;
> @@ -644,7 +648,7 @@ The example below includes how to implement "mocking":
>
>         static int fake_foo(int arg)
>         {
> -               struct kunit *test = current->kunit_test;
> +               struct kunit *test = kunit_get_current_test();
>                 struct test_data *test_data = test->priv;
>
>                 KUNIT_EXPECT_EQ(test, test_data->want_foo_called_with, arg);
> @@ -675,7 +679,7 @@ Each test can have multiple resources which have string names providing the same
>  flexibility as a ``priv`` member, but also, for example, allowing helper
>  functions to create resources without conflicting with each other. It is also
>  possible to define a clean up function for each resource, making it easy to
> -avoid resource leaks. For more information, see Documentation/dev-tools/kunit/api/test.rst.
> +avoid resource leaks. For more information, see Documentation/dev-tools/kunit/api/resource.rst.

Oops, thanks for cleaning this up.
I guess I forgot to update this when splitting out resource.rst or my
change raced with the rewrite of this file.

>
>  Failing The Current Test
>  ------------------------
> @@ -703,3 +707,6 @@ structures as shown below:
>         static void my_debug_function(void) { }
>         #endif
>
> +Note that ``kunit_fail_current_test`` requires KUnit be built-in to the kernel, i.e.
> +``CONFIG_KUNIT=y``. It is safe to call even if KUnit is not enabled, is built as a module,
> +or no test is currently running, but will do nothing.

This is the same wording as above.
I think it's clearer since what it's trying to convey is simpler, so
it's probably fine.

But if we do end up thinking of a good way to reword the previous bit,
we might want to reword it here too.
