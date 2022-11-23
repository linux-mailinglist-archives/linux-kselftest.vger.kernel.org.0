Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183CB636471
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 16:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbiKWPsq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Nov 2022 10:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbiKWPsa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Nov 2022 10:48:30 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852033FBAF
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Nov 2022 07:48:27 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q1so17068729pgl.11
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Nov 2022 07:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CogaOYhU5rJYKcosZZYpH+BPGYo5v/qCbF8p4NIZlQk=;
        b=QCh1P3qKGCWXWNFLoqB+/VFvpe244cW86jbJrqavwhTOIwJ/l8HhgMCxsR1h95yKnW
         WhoAYG4p/+mg/DFiNdUKsBiYqWvjsH5pD4UWruB7EjBSwtsZflpyvhLbAgfgRLZFVV5Q
         Fhn1w/djy4SpbNsiWqxnWCVDgREhFMx0bCzDLhfAJQGIxg5WMvm4cPeLaa3LrWpMRpde
         1oYoEjiiC4hXHBODrc+/2TnUS3rT0jhOH/PpYLsl32IuuSLIvfgHeNUv1krv4K5Jga2y
         hNkiE2UDPNO45BM1W5zIesrUpwU09BiTawjLJPiALyaLDTgu8gp+q7UMovCAh9600kzb
         x6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CogaOYhU5rJYKcosZZYpH+BPGYo5v/qCbF8p4NIZlQk=;
        b=baOTy6OBc1kI3h7dIYzAKXYBEJErLyzaNbICstCPSrp7+TSz+4+aqwavXC9/Fb3jLz
         hvXVnUKrGSztZIcXM5jCfIV4/rp5CACkS4ZHvG07tgw8PRUdGASwCVyPXzV5hRvpN0jj
         lIf4QBjz3q1GhhAyBT9/PKvxylok3hSmbnMqxXYTp2wIyTObu47oLuIjAUNjdxJRH0ie
         SMSEm51c2sZ4GH5e++ODZPwEJHZBm7cKjTEaOYGQmq2BABwp68/BWcF2jQ70n1+vjf/V
         Dcrjd4DKKKQ/AJyrYu5fMyf2yVzbqz1pcOezjOm0HLmFbt0Ss3O7syHRt5OZu8lK2/+u
         VeEg==
X-Gm-Message-State: ANoB5pleHGsRf+zlvruJOjfTb5aekYzrbvg5vHxlJSP7tsv19EGrC4EP
        AgaTr+eXfHPMbi70DgRge75ZUp7XJItsnf+IggLh4Q==
X-Google-Smtp-Source: AA0mqf7Grm5pcLT0zZvlUsRZ3/VqLKGx+80LWNt2LwDFZdqdAdmKL4oeqSbo9WQm0QQoGpWAHgVTmPgK8G+gQ14qRtU=
X-Received: by 2002:a65:4586:0:b0:476:f119:40b2 with SMTP id
 o6-20020a654586000000b00476f11940b2mr26182155pgq.330.1669218506684; Wed, 23
 Nov 2022 07:48:26 -0800 (PST)
MIME-Version: 1.0
References: <20221119081252.3864249-1-davidgow@google.com> <20221119081252.3864249-2-davidgow@google.com>
In-Reply-To: <20221119081252.3864249-2-davidgow@google.com>
From:   Sadiya Kazi <sadiyakazi@google.com>
Date:   Wed, 23 Nov 2022 21:18:15 +0530
Message-ID: <CAO2JNKXnePO7Azhsa5+pPpn7+cv862P=VryCX7SmpcnWbZ8xog@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kunit: Use the static key when retrieving the
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thank you, David. This looks fine to me but I do have a few comments
for the documentation. Please see my comments inline below.
Additionally, it would be great to use second person, but we can
reserve that change for another time.

Best Regards,
Sadiya




On Sat, Nov 19, 2022 at 1:43 PM 'David Gow' via KUnit Development
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
> ---
>
> As-is, the only code which will be directly affected by this (via the
> kunit_fail_current_test() change) will be UBSAN's KUnit integration.
>
> Patches to port other tests to use kunit_get_current_test() will be sent
> separately (other than the SLUB one in patch 3/3). KASAN in particular
> are reworking their KUnit tests and integration, so we'll use this in a
> follow up to avoid introducing a conflict.
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
>  Documentation/dev-tools/kunit/usage.rst | 25 +++++++-----
>  include/kunit/test-bug.h                | 53 +++++++++++++++++++++++--
>  2 files changed, 66 insertions(+), 12 deletions(-)
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
> +any current test from within an error handler.
> +We can do this via the ``kunit_test`` field in ``task_struct``, which we can
> +access using the ``kunit_get_current_test`` function in ``kunit/test-bug.h``.
>
How about this:
In some cases, we need to call test-only code from outside the test
file. This is helpful, for instance, when providing a fake implementation
of a function, or if we wish to fail the current test from within an
error handler.

> -The example below includes how to implement "mocking":
> +``kunit_get_current_test`` requires KUnit be built-in to the kernel, i.e.
> +``CONFIG_KUNIT=y``. It is safe to call even if KUnit is not enabled, is built as a module,
> +or no test is currently running, in which case it will quickly return ``NULL``.

Suggestion:
Although the function ``kunit get current test()`` is always
available, it will only
produce a test if the kernel includes KUnit (i.e., if CONFIG KUNIT=y). It will
return NULL in all other circumstances.
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

same as above

> diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> index 5fc58081d511..87a953dceeaa 100644
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
> +extern struct static_key_false kunit_running;
> +
> +/**
> + * kunit_get_current_test() - Return a pointer to the currently-running
> + *                           KUnit test.
Suggestion: You can use "currently running KUnit test" or just say
"current KUnit test".
> + *
> + * If a KUnit test is running in the current task, returns a pointer to
> + * its associated struct kunit, which can then be passed to any KUnit function
> + * or assertion. If no test is running (or a test is running in a different
> + * task), returns NULL.

How about this:
Returns a pointer to the associated struct kunit if a KUnit test is
currently running
in the task. This pointer can then be passed to any KUnit function or assertion.
Returns NULL if no tests are running (or tests are running in a different task).

> + *
> + * This function is safe to call even when KUnit is disabled: it will compile
> + * down to nothing if CONFIG_KUNIT is not enabled, and will be very fast if
> + * no test is running.
> + */

How about this: You can safely call this function even when KUnit is disabled.
If CONFIG_KUNIT is not enabled, it will compile to nothing and will
run quickly if no tests are running.



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
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20221119081252.3864249-2-davidgow%40google.com.
