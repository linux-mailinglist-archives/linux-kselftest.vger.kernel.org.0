Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC08564223D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Dec 2022 05:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiLEE13 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Dec 2022 23:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiLEE10 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Dec 2022 23:27:26 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5671115C
        for <linux-kselftest@vger.kernel.org>; Sun,  4 Dec 2022 20:27:24 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id a14so6160154pfa.1
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Dec 2022 20:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2r1Ei9Rq+Q7TrA7bT1bxXLueCKoVPQlRD8D3iXufRkg=;
        b=bAAn+zlfT5xTI/PL0xMY3tAEDYvFLbc+Ht708ZM8uVnoDOiH868h+Hx0a81j+5k3ng
         qi6sbj+/rJ9wCkjo8xK0acI91mTawXwf5HYctgBjHenIVT+zOB5IXBw5kBDLGdfs2khp
         XLBbgUAfQ3gRCJAll/5R7brL//BclwNh8BOc1MLUcngxrw4YHjXNMKbR8g4tFIm562I3
         EXtp9MiT5sf1TjvKkkb0IJPwe2ywTtmAT0MXK+xl9y/XP/ybLPX2qG5iNxnYH+5o9Ua+
         /mXN4qaU9RH1kKJTXFkCm3UavJ408UJ4Bh5SA2sQbHzpGI4zyU7tn30W2C03lapkBcyt
         JU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2r1Ei9Rq+Q7TrA7bT1bxXLueCKoVPQlRD8D3iXufRkg=;
        b=GLWBIBhxssjpnQnRrdR40B8RDN7C368+Hq4PQ0eh+Ri0FgsUrD98HlG0uFM6Gtnw5P
         SnvEtI5DNmEK7bwWHoMw9xV/5oHiHQOt8YiCVQbAmy4uRGiTuNfIF11KfkySnnAdqLMA
         UTVxKp77fPpGvFurwZ0tzO+aIVd/a7800enUn8W+Wtmw0ZEHi5rnPSce2WkT1rOKwEOf
         tLyHFoUaPIol0B8oMDeoP1PvURM17l2MTjSJi+5UNZ27D6e+NhwvNElKj6rnpaUWZC8o
         AEHajRdPj/aUpkYiPIg6BLbMsDJN5lUYospuerMTg3znW2tatTKyr5vkY+1w1wxq9B5c
         rq0w==
X-Gm-Message-State: ANoB5plynaFPB5VjbFlJZ5AS/2AjidSFSLoATr08Gp3UNO8OzQnt5wLF
        D9lqQaNky0bXYDpy0F0eRuwOoyXzpx2aysu8cO+5PA==
X-Google-Smtp-Source: AA0mqf75EOuooQoQNvnD15mj/Nu4X8c9ckjAkSPYrU/SE7RCW4qlz08psq99ZWJrN1V9nNNH4wJClYQhOrAzGie6Mec=
X-Received: by 2002:a63:4d4c:0:b0:478:ba69:9ce3 with SMTP id
 n12-20020a634d4c000000b00478ba699ce3mr3240085pgl.393.1670214443505; Sun, 04
 Dec 2022 20:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20221125084306.1063074-1-davidgow@google.com> <20221125084306.1063074-2-davidgow@google.com>
In-Reply-To: <20221125084306.1063074-2-davidgow@google.com>
From:   Sadiya Kazi <sadiyakazi@google.com>
Date:   Mon, 5 Dec 2022 09:57:12 +0530
Message-ID: <CAO2JNKUsBx6sro87vbhbUqmMa0ZupG=92qK-2bXAAn-r5Huetw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] kunit: Use the static key when retrieving the
 current test
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>
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

On Fri, Nov 25, 2022 at 2:13 PM 'David Gow' via KUnit Development
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
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> ---
Thank you, David. This looks great to me.
Reviewed-by: Sadiya Kazi <sadiyakazi@google.com>

Best Regards,
Sadiya Kazi
>
> As-is, the only code which will be directly affected by this (via the
> kunit_fail_current_test() change) will be UBSAN's KUnit integration.
>
> Patches to port other tests to use kunit_get_current_test() will be sent
> separately (other than the SLUB one in patch 3/3). KASAN in particular
> are reworking their KUnit tests and integration, so we'll use this in a
> follow up to avoid introducing a conflict.
>
> Changes since v3:
> https://lore.kernel.org/linux-kselftest/20221119081252.3864249-2-davidgow@google.com/
> - Use DECLARE_STATIC_KEY_FALSE() -- Thanks Daniel.
> - Some documentation rewording to make the behaviour a bit clearer.
>   - Thanks Daniel and Sadiya
>
> Changes since v2:
> https://lore.kernel.org/all/20221025071907.1251820-2-davidgow@google.com/
> - Only add kunit_get_current_test() when KUnit is built-in, as the
>   static key isn't available otherwise.
>   - I'm going to try to put together some patches to make things like
>     this available when CONFIG_KUNIT=m in the future.
>   - Also update the documentation to note this.
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20221021072854.333010-2-davidgow@google.com/
> - Fix a missing '}' which broke everything. Thanks Kees, kernel test
>   robot.
> - Add the new kunit_get_current_test() function, as most of the cases
>   where we retrieve the current test (even to fail it) were accessing
>   current->kunit_test directly, not using kunit_fail_current_test().
> - Add some documentation comments.
> - Update the documentation in usage.rst.
>   - The version in tips.rst was not updated, and will be removed:
>   https://lore.kernel.org/linux-kselftest/20221025055844.1231592-1-davidgow@google.com/
>
> ---
>  Documentation/dev-tools/kunit/usage.rst | 30 +++++++++-----
>  include/kunit/test-bug.h                | 53 +++++++++++++++++++++++--
>  2 files changed, 71 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 22416ebb94ab..48f8196d5aad 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -641,17 +641,23 @@ as shown in next section: *Accessing The Current Test*.
>  Accessing The Current Test
>  --------------------------
>
> -In some cases, we need to call test-only code from outside the test file.
> -For example, see example in section *Injecting Test-Only Code* or if
> -we are providing a fake implementation of an ops struct. Using
> -``kunit_test`` field in ``task_struct``, we can access it via
> -``current->kunit_test``.
> +In some cases, we need to call test-only code from outside the test file.  This
> +is helpful, for example, when providing a fake implementation of a function, or
> +to fail any current test from within an error handler.
> +We can do this via the ``kunit_test`` field in ``task_struct``, which we can
> +access using the ``kunit_get_current_test()`` function in ``kunit/test-bug.h``.
>
> -The example below includes how to implement "mocking":
> +``kunit_get_current_test()`` is safe to call even if KUnit is not enabled. If
> +KUnit is not enabled, was built as a module (``CONFIG_KUNIT=m``), or no test is
> +running in the current task, it will return ``NULL``. This compiles down to
> +either a no-op or a static key check, so will have a negligible performance
> +impact when no test is running.
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
> @@ -660,7 +666,7 @@ The example below includes how to implement "mocking":
>
>         static int fake_foo(int arg)
>         {
> -               struct kunit *test = current->kunit_test;
> +               struct kunit *test = kunit_get_current_test();
>                 struct test_data *test_data = test->priv;
>
>                 KUNIT_EXPECT_EQ(test, test_data->want_foo_called_with, arg);
> @@ -691,7 +697,7 @@ Each test can have multiple resources which have string names providing the same
>  flexibility as a ``priv`` member, but also, for example, allowing helper
>  functions to create resources without conflicting with each other. It is also
>  possible to define a clean up function for each resource, making it easy to
> -avoid resource leaks. For more information, see Documentation/dev-tools/kunit/api/test.rst.
> +avoid resource leaks. For more information, see Documentation/dev-tools/kunit/api/resource.rst.
>
>  Failing The Current Test
>  ------------------------
> @@ -719,3 +725,9 @@ structures as shown below:
>         static void my_debug_function(void) { }
>         #endif
>
> +``kunit_fail_current_test()`` is safe to call even if KUnit is not enabled. If
> +KUnit is not enabled, was built as a module (``CONFIG_KUNIT=m``), or no test is
> +running in the current task, it will do nothing. This compiles down to either a
> +no-op or a static key check, so will have a negligible performance impact when
> +no test is running.
> +
> diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> index 5fc58081d511..c1b2e14eab64 100644
> --- a/include/kunit/test-bug.h
> +++ b/include/kunit/test-bug.h
> @@ -9,16 +9,63 @@
>  #ifndef _KUNIT_TEST_BUG_H
>  #define _KUNIT_TEST_BUG_H
>
> -#define kunit_fail_current_test(fmt, ...) \
> -       __kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
> -
>  #if IS_BUILTIN(CONFIG_KUNIT)
>
> +#include <linux/jump_label.h> /* For static branch */
> +#include <linux/sched.h>
> +
> +/* Static key if KUnit is running any tests. */
> +DECLARE_STATIC_KEY_FALSE(kunit_running);
> +
> +/**
> + * kunit_get_current_test() - Return a pointer to the currently running
> + *                           KUnit test.
> + *
> + * If a KUnit test is running in the current task, returns a pointer to its
> + * associated struct kunit. This pointer can then be passed to any KUnit
> + * function or assertion. If no test is running (or a test is running in a
> + * different task), returns NULL.
> + *
> + * This function is safe to call even when KUnit is disabled. If CONFIG_KUNIT
> + * is not enabled, it will compile down to nothing and will return quickly no
> + * test is running.
> + */
> +static inline struct kunit *kunit_get_current_test(void)
> +{
> +       if (!static_branch_unlikely(&kunit_running))
> +               return NULL;
> +
> +       return current->kunit_test;
> +}
> +
> +
> +/**
> + * kunit_fail_current_test() - If a KUnit test is running, fail it.
> + *
> + * If a KUnit test is running in the current task, mark that test as failed.
> + *
> + * This macro will only work if KUnit is built-in (though the tests
> + * themselves can be modules). Otherwise, it compiles down to nothing.
> + */
> +#define kunit_fail_current_test(fmt, ...) do {                                 \
> +               if (static_branch_unlikely(&kunit_running)) {                   \
> +                       __kunit_fail_current_test(__FILE__, __LINE__,           \
> +                                                 fmt, ##__VA_ARGS__);          \
> +               }                                                               \
> +       } while (0)
> +
> +
>  extern __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
>                                                     const char *fmt, ...);
>
>  #else
>
> +static inline struct kunit *kunit_get_current_test(void) { return NULL; }
> +
> +/* We define this with an empty helper function so format string warnings work */
> +#define kunit_fail_current_test(fmt, ...) \
> +               __kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
> +
>  static inline __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
>                                                             const char *fmt, ...)
>  {
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20221125084306.1063074-2-davidgow%40google.com.
