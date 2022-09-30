Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687AD5F0F78
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 18:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiI3QCF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 12:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiI3QB2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 12:01:28 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C07813DD9D
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 09:01:24 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id h10so1344182qvq.7
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nN5PJ9SH/oWRUUOx1EoVRDs3Xq3fxAQ6y6mXiPQEyik=;
        b=Df7TfKOprazwh1bk2WGMsuCtD0UrGsBhzWzl8/5keXCWkIvnu/60/q+BvmW+/+T58u
         BzyEOykHRCSCwm8rSoYXm1piUyU0cfioFsQVqlwcfZBXqy0+xntCKq3UVzJ5ckpD+2Ib
         Wnov2VmpwrrHOTl6RXXZmGir1hcqYS/YHHWKlaTsLZCR7eeSyblxXAVi/6GRCMGGY7CZ
         cNAcq0GhJX11mPXYetM4sjMvM5NoYeBz05NNguP4cGQYf+WS9wIwsAeXxVEk7qTO5ItS
         K5jsr7x5FcWaztjyDAejc+caMAWMoqYgFSyqJy7rt4VPoVySqddsgZw+zxk5ZjhJjzJh
         FG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nN5PJ9SH/oWRUUOx1EoVRDs3Xq3fxAQ6y6mXiPQEyik=;
        b=5/SL173XrRbd85B/ZrMNW+TPG95IwC3UI4Z2Dj7yrrd49HMRlZwYvB1WiRvEikDL27
         66af3ZxOY0D5g9aWBHSzuhM0JOFeVXh6vxGIs/3BqwDc+EoJQR+GGdQfxtFSdiWvW13O
         mC11HK7QEvrkvEj899m1553wqc6EPQuWIad9NQLqz9Dsn0Gk1VKcvW5VrGYjbxy2luug
         dvaI/n4+9qL1AZbPWc+VzbEz4Z4SOXkQ+703u9P1ZtnJ5iZ0NJwNDO3/EuZBLVEevggv
         qPjLVcIpWjw8jXzGPAWWjdkBbqx6adcxVg7orbeJNQ45kDAI/PsygAo6ry1mkUsacU5i
         C7Tg==
X-Gm-Message-State: ACrzQf0Wo0291e7Ty+JKbBh0rKlmf5hw8XkJhw0JDwmvNMWXvhj4ljrR
        7Lbfa8oBHANR4dQUuqhS+N4rtUmXeoINBN63Xct8
X-Google-Smtp-Source: AMsMyM7Ah/bkxlB6/cFaOuHMN+THp9m0g53VJtdwiY641ZkcbcdWxcJQ1FFsoHAB76PtK/9MeIavJ5bgoYzjvCNfZVU=
X-Received: by 2002:a0c:c442:0:b0:4ac:b6b2:a4bf with SMTP id
 t2-20020a0cc442000000b004acb6b2a4bfmr7331732qvi.21.1664553682999; Fri, 30 Sep
 2022 09:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220910212804.670622-1-davidgow@google.com> <20220910212804.670622-3-davidgow@google.com>
In-Reply-To: <20220910212804.670622-3-davidgow@google.com>
From:   Joe Fradley <joefradley@google.com>
Date:   Fri, 30 Sep 2022 09:01:12 -0700
Message-ID: <CAF-60z1BB1-rpJA1HbXHKksSdknb-49Ja+vVAuyJt9yK-ACofw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] kunit: expose ftrace-based API for stubbing
 out functions during tests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steve Muckle <smuckle@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Sep 10, 2022 at 2:28 PM David Gow <davidgow@google.com> wrote:
>
> From: Daniel Latypov <dlatypov@google.com>
>
> Allow function redirection using ftrace. This is basically equivalent to
> the static_stub support in the previous patch, but does not require the
> function being replaced to be modified (save for the addition of
> KUNIT_STUBBABLE/noinline).
>
> This is hidden behind the CONFIG_KUNIT_FTRACE_STUBS option, and has a
> number of dependencies, including ftrace and CONFIG_KALLSYMS_ALL. As a
> result, it only works on architectures where these are available.
>
> You can run the KUnit example tests with the following:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig lib/kunit/stubs_example.kunitconfig --arch=x86_64
>
> To the end user, replacing a function is very simple, e.g.
>   KUNIT_STUBBABLE void real_func(int n);
>   void replacement_func(int n);
>
>   /* in tests */
>   kunit_activate_ftrace_stub(test, real_func, replacement_func);
>
> The implementation is inspired by Steven's snippet here [1].
>
> Some more details:
> * stubbing is automatically undone at the end of tests
> * it can also be manually undone with kunit_deactive_ftrace_stub()
> * stubbing only applies when current->kunit_test == test
>   * note: currently can't have more than one test running at a time
> * KUNIT_STUBBABLE marks tests as noinline when CONFIG_KUNIT_STUBS is set

I believe you meant CONFIG_KUNIT_FTRACE_STUBS here.

>   * this ensures we can actually stub all calls
> * KUNIT_STUBBABLE_TRAMPOLINE is a version that evaluates to
>   __always_inline when stubbing is not enabled
>   * This may need to be used with a wrapper function.
>   * See the doc comment for more details.
>
> Sharp-edges:
> * kernel ftrace only works on some arches (not UML)
>   * and (this use of it) seems broken on others (e.g, arm64)
> * if you don't use noinline/KUNIT_STUBBABLE, functions might be inlined
>   and thus none of this works:
>   * if it's always inlined, at least the attempt to stub will fail
>   * if it's sometimes inlined, then the stub silently won't work
>
> [1] https://lore.kernel.org/lkml/20220224091550.2b7e8784@gandalf.local.home
>
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
>
> Changes since RFC v1:
> https://lore.kernel.org/lkml/20220318021314.3225240-3-davidgow@google.com/
> - Fix some typos (thanks Daniel)
> - Use typecheck_fn() to fix typechecking in some cases (thanks Brendan)
> - Use ftrace_instruction_pointer_set() in place of kernel livepatch,
>   which seems to have disappeared:
>   https://lore.kernel.org/lkml/0a76550d-008d-0364-8244-4dae2981ea05@csgroup.eu/T/
> - Fix a copy-paste name error in the resource finding function.
> - Rebase on top of torvalds/master, as it wasn't applying cleanly.
>
> ---
>  include/kunit/ftrace_stub.h         |  84 +++++++++++++++++
>  lib/kunit/Kconfig                   |  11 +++
>  lib/kunit/Makefile                  |   4 +
>  lib/kunit/ftrace_stub.c             | 137 ++++++++++++++++++++++++++++
>  lib/kunit/kunit-example-test.c      |  27 +++++-
>  lib/kunit/stubs_example.kunitconfig |  10 ++
>  6 files changed, 272 insertions(+), 1 deletion(-)
>  create mode 100644 include/kunit/ftrace_stub.h
>  create mode 100644 lib/kunit/ftrace_stub.c
>  create mode 100644 lib/kunit/stubs_example.kunitconfig
>
> diff --git a/include/kunit/ftrace_stub.h b/include/kunit/ftrace_stub.h
> new file mode 100644
> index 000000000000..82d33267f49f
> --- /dev/null
> +++ b/include/kunit/ftrace_stub.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _KUNIT_FTRACE_STUB_H
> +#define _KUNIT_FTRACE_STUB_H
> +
> +/** KUNIT_STUBBABLE - marks a function as stubbable when stubbing support is
> + * enabled.
> + *
> + * Stubbing uses ftrace internally, so we can only stub out functions when they
> + * are not inlined. This macro evalautes to noinline when stubbing support is
> + * enabled to thus make it safe.
> + *
> + * If you cannot add this annotation to the function, you can instead use
> + * KUNIT_STUBBABLE_TRAMPOLINE, which is the same, but evaluates to
> + * __always_inline when stubbing is not enabled.
> + *
> + * Consider copy_to_user, which is marked as __always_inline:
> + *
> + * .. code-block:: c
> + *     static KUNIT_STUBBABLE_TRAMPOLINE unsigned long
> + *     copy_to_user_trampoline(void __user *to, const void *from, unsigned long n)
> + *     {
> + *             return copy_to_user(to, from, n);
> + *     }
> + *
> + * Then we simply need to update our code to go through this function instead
> + * (in the places where we want to stub it out).
> + */
> +#if IS_ENABLED(CONFIG_KUNIT_FTRACE_STUBS)
> +#define KUNIT_STUBBABLE noinline
> +#define KUNIT_STUBBABLE_TRAMPOLINE noinline
> +#else
> +#define KUNIT_STUBBABLE
> +#define KUNIT_STUBBABLE_TRAMPOLINE __always_inline
> +#endif
> +
> +struct kunit;
> +
> +/**
> + * kunit_activate_ftrace_stub() - makes all calls to @func go to @replacement during @test.
> + * @test: The test context object.
> + * @func: The function to stub out, must be annotated with KUNIT_STUBBABLE.
> + * @replacement: The function to replace @func with.
> + *
> + * All calls to @func will instead call @replacement for the duration of the
> + * current test. If called from outside the test's thread, the function will
> + * not be redirected.
> + *
> + * The redirection can be disabled again with kunit_deactivate_ftrace_stub().
> + *
> + * Example:
> + *
> + * .. code-block:: c
> + *     KUNIT_STUBBABLE int real_func(int n)
> + *     {
> + *             pr_info("real_func() called with %d", n);
> + *             return 0;
> + *     }
> + *
> + *     void replacement_func(int n)
> + *     {
> + *             pr_info("replacement_func() called with %d", n);
> + *             return 42;
> + *     }
> + *
> + *     void example_test(struct kunit *test)
> + *     {
> + *             kunit_activate_ftrace_stub(test, real_func, replacement_func);
> + *             KUNIT_EXPECT_EQ(test, real_func(1), 42);
> + *     }
> + *
> + */
> +#define kunit_activate_ftrace_stub(test, func, replacement) do { \
> +       typecheck_fn(typeof(&func), replacement); \
> +       __kunit_activate_ftrace_stub(test, #func, func, replacement); \
> +} while (0)
> +
> +void __kunit_activate_ftrace_stub(struct kunit *test,
> +                                 const char *name,
> +                                 void *real_fn_addr,
> +                                 void *replacement_addr);
> +
> +
> +void kunit_deactivate_ftrace_stub(struct kunit *test, void *real_fn_addr);
> +#endif  /* _KUNIT_STUB_H */
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 0b5dfb001bac..35462529dd30 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -59,4 +59,15 @@ config KUNIT_ALL_TESTS
>
>           If unsure, say N.
>
> +config KUNIT_FTRACE_STUBS
> +       bool "Support for stubbing out functions in KUnit tests with ftrace and kernel livepatch"
> +       depends on FTRACE=y && FUNCTION_TRACER=y && MODULES=y && DEBUG_KERNEL=y && KALLSYMS_ALL=y
> +       help
> +         Builds support for stubbing out functions for the duration of KUnit
> +         test cases or suites using ftrace and kernel livepatch.
> +         See KUNIT_EXAMPLE_TEST for an example.
> +
> +         NOTE: this does not work on all architectures (like UML, arm64) and
> +         relies on a lot of magic (see the dependencies list).
> +
>  endif # KUNIT
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 78d9d3414b67..f2421b388108 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -20,3 +20,7 @@ obj-$(CONFIG_KUNIT_TEST) +=           string-stream-test.o
>  endif
>
>  obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=    kunit-example-test.o
> +
> +ifeq ($(CONFIG_KUNIT_FTRACE_STUBS),y)
> +kunit-objs +=                          ftrace_stub.o
> +endif
> diff --git a/lib/kunit/ftrace_stub.c b/lib/kunit/ftrace_stub.c
> new file mode 100644
> index 000000000000..7386340e8dd7
> --- /dev/null
> +++ b/lib/kunit/ftrace_stub.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <kunit/test.h>
> +
> +#include <linux/typecheck.h>
> +
> +#include <linux/ftrace.h>
> +#include <linux/sched.h>
> +
> +struct kunit_ftrace_stub_ctx {
> +       struct kunit *test;
> +       unsigned long real_fn_addr; /* used as a key to lookup the stub */
> +       unsigned long replacement_addr;
> +       struct ftrace_ops ops; /* a copy of kunit_stub_base_ops with .private set */
> +};
> +
> +static void kunit_stub_trampoline(unsigned long ip, unsigned long parent_ip,
> +                                 struct ftrace_ops *ops,
> +                                 struct ftrace_regs *fregs)
> +{
> +       struct kunit_ftrace_stub_ctx *ctx = ops->private;
> +       int lock_bit;
> +
> +       if (current->kunit_test != ctx->test)
> +               return;
> +
> +       lock_bit = ftrace_test_recursion_trylock(ip, parent_ip);
> +       KUNIT_ASSERT_GE(ctx->test, lock_bit, 0);
> +
> +       ftrace_instruction_pointer_set(fregs, ctx->replacement_addr);
> +
> +       ftrace_test_recursion_unlock(lock_bit);
> +}
> +
> +static struct ftrace_ops kunit_stub_base_ops = {
> +       .func = &kunit_stub_trampoline,
> +       .flags = FTRACE_OPS_FL_IPMODIFY |
> +#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +               FTRACE_OPS_FL_SAVE_REGS |
> +#endif
> +               FTRACE_OPS_FL_DYNAMIC
> +};
> +
> +static void __kunit_ftrace_stub_resource_free(struct kunit_resource *res)
> +{
> +       struct kunit_ftrace_stub_ctx *ctx = res->data;
> +
> +       unregister_ftrace_function(&ctx->ops);
> +       kfree(ctx);
> +}
> +
> +/* Matching function for kunit_find_resource(). match_data is real_fn_addr. */
> +static bool __kunit_ftrace_stub_resource_match(struct kunit *test,
> +                                               struct kunit_resource *res,
> +                                               void *match_real_fn_addr)
> +{
> +       /* This pointer is only valid if res is a static stub resource. */
> +       struct kunit_ftrace_stub_ctx *ctx = res->data;
> +
> +       /* Make sure the resource is a static stub resource. */
> +       if (res->free != &__kunit_ftrace_stub_resource_free)
> +               return false;
> +
> +       return ctx->real_fn_addr == (unsigned long)match_real_fn_addr;
> +}
> +
> +void kunit_deactivate_ftrace_stub(struct kunit *test, void *real_fn_addr)
> +{
> +       struct kunit_resource *res;
> +
> +       KUNIT_ASSERT_PTR_NE_MSG(test, real_fn_addr, NULL,
> +                               "Tried to deactivate a NULL stub.");
> +
> +       /* Look up the existing stub for this function. */
> +       res = kunit_find_resource(test,
> +                                 __kunit_ftrace_stub_resource_match,
> +                                 real_fn_addr);
> +
> +       /* Error out if the stub doesn't exist. */
> +       KUNIT_ASSERT_PTR_NE_MSG(test, res, NULL,
> +                               "Tried to deactivate a nonexistent stub.");
> +
> +       /* Free the stub. We 'put' twice, as we got a reference
> +        * from kunit_find_resource(). The free function will deactivate the
> +        * ftrace stub.
> +        */
> +       kunit_remove_resource(test, res);
> +       kunit_put_resource(res);
> +}
> +EXPORT_SYMBOL_GPL(kunit_deactivate_ftrace_stub);
> +
> +void __kunit_activate_ftrace_stub(struct kunit *test,
> +                                 const char *name,
> +                                 void *real_fn_addr,
> +                                 void *replacement_addr)
> +{
> +       unsigned long ftrace_ip;
> +       struct kunit_ftrace_stub_ctx *ctx;
> +       int ret;
> +
> +       ftrace_ip = ftrace_location((unsigned long)real_fn_addr);
> +       if (!ftrace_ip)
> +               KUNIT_ASSERT_FAILURE(test, "%s ip is invalid: not a function, or is marked notrace or inline", name);
> +
> +       /* Allocate the stub context, which contains pointers to the replacement
> +        * function and the test object. It's also registered as a KUnit
> +        * resource which can be looked up by address (to deactivate manually)
> +        * and is destroyed automatically on test exit.
> +        */
> +       ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ctx, "failed to allocate kunit stub for %s", name);
> +
> +       ctx->test = test;
> +       ctx->ops = kunit_stub_base_ops;
> +       ctx->ops.private = ctx;
> +       ctx->real_fn_addr = (unsigned long)real_fn_addr;
> +       ctx->replacement_addr = (unsigned long)replacement_addr;
> +
> +       ret = ftrace_set_filter_ip(&ctx->ops, ftrace_ip, 0, 0);
> +       if (ret) {
> +               kfree(ctx);
> +               KUNIT_ASSERT_FAILURE(test, "failed to set filter ip for %s: %d", name, ret);
> +       }
> +
> +       ret = register_ftrace_function(&ctx->ops);
> +       if (ret) {
> +               kfree(ctx);
> +               if (ret == -EBUSY)
> +                       KUNIT_ASSERT_FAILURE(test, "failed to register stub (-EBUSY) for %s, likely due to already stubbing it?", name);
> +               KUNIT_ASSERT_FAILURE(test, "failed to register stub for %s: %d", name, ret);
> +       }
> +
> +       /* Register the stub as a resource with a cleanup function */
> +       kunit_alloc_resource(test, NULL,
> +                            __kunit_ftrace_stub_resource_free,
> +                            GFP_KERNEL, ctx);
> +}
> +EXPORT_SYMBOL_GPL(__kunit_activate_ftrace_stub);
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index a065dd0ae332..c61d366192d8 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -8,6 +8,7 @@
>
>  #include <kunit/test.h>
>  #include <kunit/static_stub.h>
> +#include <kunit/ftrace_stub.h>
>
>  /*
>   * This is the most fundamental element of KUnit, the test case. A test case
> @@ -125,7 +126,7 @@ static void example_all_expect_macros_test(struct kunit *test)
>  }
>
>  /* This is a function we'll replace with static stubs. */
> -static int add_one(int i)
> +static KUNIT_STUBBABLE int add_one(int i)
>  {
>         /* This will trigger the stub if active. */
>         KUNIT_STATIC_STUB_REDIRECT(add_one, i);
> @@ -160,6 +161,29 @@ static void example_static_stub_test(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, add_one(1), 2);
>  }
>
> +/*
> + * This test shows the use of static stubs.
> + */
> +static void example_ftrace_stub_test(struct kunit *test)
> +{
> +#if !IS_ENABLED(CONFIG_KUNIT_FTRACE_STUBS)
> +       kunit_skip(test, "KUNIT_FTRACE_STUBS not enabled");
> +#else
> +       /* By default, function is not stubbed. */
> +       KUNIT_EXPECT_EQ(test, add_one(1), 2);
> +
> +       /* Replace add_one() with subtract_one(). */
> +       kunit_activate_ftrace_stub(test, add_one, subtract_one);
> +
> +       /* add_one() is now replaced. */
> +       KUNIT_EXPECT_EQ(test, add_one(1), 0);
> +
> +       /* Return add_one() to normal. */
> +       kunit_deactivate_ftrace_stub(test, add_one);
> +       KUNIT_EXPECT_EQ(test, add_one(1), 2);
> +#endif
> +}
> +
>  /*
>   * Here we make a list of all the test cases we want to add to the test suite
>   * below.
> @@ -176,6 +200,7 @@ static struct kunit_case example_test_cases[] = {
>         KUNIT_CASE(example_mark_skipped_test),
>         KUNIT_CASE(example_all_expect_macros_test),
>         KUNIT_CASE(example_static_stub_test),
> +       KUNIT_CASE(example_ftrace_stub_test),
>         {}
>  };
>
> diff --git a/lib/kunit/stubs_example.kunitconfig b/lib/kunit/stubs_example.kunitconfig
> new file mode 100644
> index 000000000000..20af4da9bc75
> --- /dev/null
> +++ b/lib/kunit/stubs_example.kunitconfig
> @@ -0,0 +1,10 @@
> +CONFIG_KUNIT=y
> +CONFIG_KUNIT_FTRACE_STUBS=y
> +CONFIG_KUNIT_EXAMPLE_TEST=y
> +
> +# Depedencies
> +CONFIG_FTRACE=y
> +CONFIG_FUNCTION_TRACER=y
> +CONFIG_MODULES=y
> +CONFIG_DEBUG_KERNEL=y
> +CONFIG_KALLSYMS_ALL=y
> --
> 2.37.2.789.g6183377224-goog
>
