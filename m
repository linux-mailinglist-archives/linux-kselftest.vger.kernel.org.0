Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA70625341
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 06:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiKKF6c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 00:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiKKF63 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 00:58:29 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8E829B
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 21:58:23 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id io19so3449665plb.8
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 21:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G1TAJjdVC8UZvG2+F/4tZbO6Msw6eLui2PETDimeck0=;
        b=H08XHASl4y2YZqkkpXJN9KBWMKIxq3QhdfMIaoW3HS6Ek39Ofoge3rO1NZ/i+/WnsH
         Jhjuy2xh3ckiImoyikiwNlNJSJEssB238WCtZLiI/iy0IHCh9qzA99Vvy2Ik8rjx9/v9
         iGuttQGVBoI6VjJnUQt/GGf6s+HIOoyGFx4VJef+yvLymyCCwYogPo+M2ZITF0Jy09Cl
         Y9rnp+IlXpMF/AcNPP0cex5RmCvVTApVm1GqV3V4mDZLly1Ta8yLVOmjk3h0mqSWJxI6
         mxbysIOo+uFPG+yf+rs1kXzR4KGPtfARARGIwwB+drQzsTyFCkv4wUZc+WSw3l1MrHVo
         gyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1TAJjdVC8UZvG2+F/4tZbO6Msw6eLui2PETDimeck0=;
        b=Nfuiwe5xTaamdbDxXsiEvrT3ONHkBFGs7wMzPIEo6Lp9kL+eZO4anhLm0QzpVWU2/a
         ahL/k/VyELTtbXloR2gnTwc7GUANqrN6MkDQs7QUgtY4anwtEQjoAIBpn6jQae6q2tUH
         /FuZsTNoJAPfTAhdHz82eQqOfMzLWCAxa7uWCIYOviK7iBGWhhX8nCc1ylmFPTM+1mOP
         kRWPV85TVnYDMy3a/1znpc2+crUjo8UTCGqdI7JKpH/MCNin+13F3VZgBLQxjDlakAcE
         BvRHSYECaFNB1kXSIMAcyTgd9PDCNMPe4LkEcnUT3Ebzk+snMdVwqq/YGT19aUac5Rjg
         DMkg==
X-Gm-Message-State: ANoB5plNc28hCK68jR8+YZg4tgJvqTPhohApc09NfF1ARpCBUn0gARdb
        v1KJCAhqmA+XMtn3hTqdfnSA+2Y+hoAmaI6DZ4cC6w==
X-Google-Smtp-Source: AA0mqf4w7ssW+0ivaafk/m/X7S4mmD66huZPxXs7nFDBq9EftvjWMpTT3FMxq5DeZp1sumRQq6aJLgGz3qum8RAl3L8=
X-Received: by 2002:a17:90a:50f:b0:213:2704:1d1 with SMTP id
 h15-20020a17090a050f00b00213270401d1mr309605pjh.45.1668146302402; Thu, 10 Nov
 2022 21:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20221109003618.3784591-1-dlatypov@google.com> <20221109003618.3784591-3-dlatypov@google.com>
In-Reply-To: <20221109003618.3784591-3-dlatypov@google.com>
From:   Sadiya Kazi <sadiyakazi@google.com>
Date:   Fri, 11 Nov 2022 11:28:11 +0530
Message-ID: <CAO2JNKUUX+4=VCWxUXLrqSeX1YXOd=nqFM8Rj6AQhZEBkvcynQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Documentation: kunit: Remove redundant 'tips.rst' page
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 9, 2022 at 6:06 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> From: David Gow <davidgow@google.com>
>
> The contents of 'tips.rst' was mostly included in 'usage.rst' way back in
> commit 953574390634 ("Documentation: KUnit: Rework writing page to focus on writing tests"),
> but the tips page remained behind as well.
>
> The parent patches in this series fill in the gaps, so now 'tips.rst' is
> redundant.
> Therefore, delete 'tips.rst'.
>
> While I regret breaking any links to 'tips' which might exist
> externally, it's confusing to have two subtly different versions of the
> same content around.
>
> Signed-off-by: David Gow <davidgow@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
> v1 -> v2: rebased onto some parent patches to fix the missing sections
> in usage.rst and tweaked the commit message to reflect that.
> ---

Thank you. This looks fine to me.
Reviewed-by: Sadiya Kazi <sadiyakazi@google.com>


>  Documentation/dev-tools/kunit/index.rst |   1 -
>  Documentation/dev-tools/kunit/tips.rst  | 190 ------------------------
>  2 files changed, 191 deletions(-)
>  delete mode 100644 Documentation/dev-tools/kunit/tips.rst
>
> diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> index f5d13f1d37be..d5629817cd72 100644
> --- a/Documentation/dev-tools/kunit/index.rst
> +++ b/Documentation/dev-tools/kunit/index.rst
> @@ -16,7 +16,6 @@ KUnit - Linux Kernel Unit Testing
>         api/index
>         style
>         faq
> -       tips
>         running_tips
>
>  This section details the kernel unit testing framework.
> diff --git a/Documentation/dev-tools/kunit/tips.rst b/Documentation/dev-tools/kunit/tips.rst
> deleted file mode 100644
> index 492d2ded2f5a..000000000000
> --- a/Documentation/dev-tools/kunit/tips.rst
> +++ /dev/null
> @@ -1,190 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0
> -
> -============================
> -Tips For Writing KUnit Tests
> -============================
> -
> -Exiting early on failed expectations
> -------------------------------------
> -
> -``KUNIT_EXPECT_EQ`` and friends will mark the test as failed and continue
> -execution.  In some cases, it's unsafe to continue and you can use the
> -``KUNIT_ASSERT`` variant to exit on failure.
> -
> -.. code-block:: c
> -
> -       void example_test_user_alloc_function(struct kunit *test)
> -       {
> -               void *object = alloc_some_object_for_me();
> -
> -               /* Make sure we got a valid pointer back. */
> -               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, object);
> -               do_something_with_object(object);
> -       }
> -
> -Allocating memory
> ------------------
> -
> -Where you would use ``kzalloc``, you should prefer ``kunit_kzalloc`` instead.
> -KUnit will ensure the memory is freed once the test completes.
> -
> -This is particularly useful since it lets you use the ``KUNIT_ASSERT_EQ``
> -macros to exit early from a test without having to worry about remembering to
> -call ``kfree``.
> -
> -Example:
> -
> -.. code-block:: c
> -
> -       void example_test_allocation(struct kunit *test)
> -       {
> -               char *buffer = kunit_kzalloc(test, 16, GFP_KERNEL);
> -               /* Ensure allocation succeeded. */
> -               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
> -
> -               KUNIT_ASSERT_STREQ(test, buffer, "");
> -       }
> -
> -
> -Testing static functions
> -------------------------
> -
> -If you don't want to expose functions or variables just for testing, one option
> -is to conditionally ``#include`` the test file at the end of your .c file, e.g.
> -
> -.. code-block:: c
> -
> -       /* In my_file.c */
> -
> -       static int do_interesting_thing();
> -
> -       #ifdef CONFIG_MY_KUNIT_TEST
> -       #include "my_kunit_test.c"
> -       #endif
> -
> -Injecting test-only code
> -------------------------
> -
> -Similarly to the above, it can be useful to add test-specific logic.
> -
> -.. code-block:: c
> -
> -       /* In my_file.h */
> -
> -       #ifdef CONFIG_MY_KUNIT_TEST
> -       /* Defined in my_kunit_test.c */
> -       void test_only_hook(void);
> -       #else
> -       void test_only_hook(void) { }
> -       #endif
> -
> -This test-only code can be made more useful by accessing the current kunit
> -test, see below.
> -
> -Accessing the current test
> ---------------------------
> -
> -In some cases, you need to call test-only code from outside the test file, e.g.
> -like in the example above or if you're providing a fake implementation of an
> -ops struct.
> -There is a ``kunit_test`` field in ``task_struct``, so you can access it via
> -``current->kunit_test``.
> -
> -Here's a slightly in-depth example of how one could implement "mocking":
> -
> -.. code-block:: c
> -
> -       #include <linux/sched.h> /* for current */
> -
> -       struct test_data {
> -               int foo_result;
> -               int want_foo_called_with;
> -       };
> -
> -       static int fake_foo(int arg)
> -       {
> -               struct kunit *test = current->kunit_test;
> -               struct test_data *test_data = test->priv;
> -
> -               KUNIT_EXPECT_EQ(test, test_data->want_foo_called_with, arg);
> -               return test_data->foo_result;
> -       }
> -
> -       static void example_simple_test(struct kunit *test)
> -       {
> -               /* Assume priv is allocated in the suite's .init */
> -               struct test_data *test_data = test->priv;
> -
> -               test_data->foo_result = 42;
> -               test_data->want_foo_called_with = 1;
> -
> -               /* In a real test, we'd probably pass a pointer to fake_foo somewhere
> -                * like an ops struct, etc. instead of calling it directly. */
> -               KUNIT_EXPECT_EQ(test, fake_foo(1), 42);
> -       }
> -
> -
> -Note: here we're able to get away with using ``test->priv``, but if you wanted
> -something more flexible you could use a named ``kunit_resource``, see
> -Documentation/dev-tools/kunit/api/test.rst.
> -
> -Failing the current test
> -------------------------
> -
> -But sometimes, you might just want to fail the current test. In that case, we
> -have ``kunit_fail_current_test(fmt, args...)`` which is defined in ``<kunit/test-bug.h>`` and
> -doesn't require pulling in ``<kunit/test.h>``.
> -
> -E.g. say we had an option to enable some extra debug checks on some data structure:
> -
> -.. code-block:: c
> -
> -       #include <kunit/test-bug.h>
> -
> -       #ifdef CONFIG_EXTRA_DEBUG_CHECKS
> -       static void validate_my_data(struct data *data)
> -       {
> -               if (is_valid(data))
> -                       return;
> -
> -               kunit_fail_current_test("data %p is invalid", data);
> -
> -               /* Normal, non-KUnit, error reporting code here. */
> -       }
> -       #else
> -       static void my_debug_function(void) { }
> -       #endif
> -
> -
> -Customizing error messages
> ---------------------------
> -
> -Each of the ``KUNIT_EXPECT`` and ``KUNIT_ASSERT`` macros have a ``_MSG`` variant.
> -These take a format string and arguments to provide additional context to the automatically generated error messages.
> -
> -.. code-block:: c
> -
> -       char some_str[41];
> -       generate_sha1_hex_string(some_str);
> -
> -       /* Before. Not easy to tell why the test failed. */
> -       KUNIT_EXPECT_EQ(test, strlen(some_str), 40);
> -
> -       /* After. Now we see the offending string. */
> -       KUNIT_EXPECT_EQ_MSG(test, strlen(some_str), 40, "some_str='%s'", some_str);
> -
> -Alternatively, one can take full control over the error message by using ``KUNIT_FAIL()``, e.g.
> -
> -.. code-block:: c
> -
> -       /* Before */
> -       KUNIT_EXPECT_EQ(test, some_setup_function(), 0);
> -
> -       /* After: full control over the failure message. */
> -       if (some_setup_function())
> -               KUNIT_FAIL(test, "Failed to setup thing for testing");
> -
> -Next Steps
> -==========
> -*   Optional: see the Documentation/dev-tools/kunit/usage.rst page for a more
> -    in-depth explanation of KUnit.
> --
> 2.38.1.431.g37b22c650d-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20221109003618.3784591-3-dlatypov%40google.com.
