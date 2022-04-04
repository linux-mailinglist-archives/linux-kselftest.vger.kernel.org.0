Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A464F1C9A
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Apr 2022 23:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378626AbiDDV2D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Apr 2022 17:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380491AbiDDUTn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Apr 2022 16:19:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3782933EB0
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Apr 2022 13:17:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n6so8302857ejc.13
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Apr 2022 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zsSUvsY9SzwJEYqdwBFeI4UwQOoO3Yq1eYmqteZX3dI=;
        b=BmfJ45/ORWXN0Qzasl32gkezjCQcfkxMY9Km93amhndzyhTRxrkYq0sR18guu0AtKv
         M7FqTP5jYyHd2F3ChUkxHXqiQ9iYbsfE/kKlQyaTVTO05U12XzCzBj/Js4/BBg9UXKsm
         Bw7i/7BF72XE0Lp9p5ElQKr/itwWtQW8i4VBwCZU0CjhCS1/CX3CvRVikbFwyn2RMqjb
         ABrp7YZlJGwY4HKRae8a/kZ+7i6ij7Bv/smV3LLtMVfrXwm+ztVCci1ndH8iKE6teDCf
         HQyDF/CXfTs292KEnS0h7GxZmdDQWQMUFtBMOgNcqq5T5tOfvHj5T0ri7MV7M3Yf/VWX
         m8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zsSUvsY9SzwJEYqdwBFeI4UwQOoO3Yq1eYmqteZX3dI=;
        b=hKul4mJckHZG/9PSbvDoO53kY3qMAEx2l7dpbNcYMPRPYpBQEUglqSGmDGE4id5jLX
         IExSW9r2i+2nyPpwuMslOch4OM4ioNpIkJiF6wsXU/xaVTA86hVRVY2TAfysHD+QpjDZ
         HrK35qUVvB3LtjH7jgx0vuu/OUx3lxrVGVO72zdKOffJIPNu9kDpiSrTCi9Vxs6jIpcW
         cMNGwWBVbx9E1vEnezxyaWze8AYBItBthgFYyyfmHfF0JRvJWyx7JEFvO99imSYrkcXY
         u4Fb8IeSwWughTeQngNF2ZLsAjsQMr4XQ3tNZjTfp0duypW03jqT/eihs9dKZMmEbQcU
         yN8A==
X-Gm-Message-State: AOAM531aMN5y373Eoe/V+bhurF2IkeHGzCia6h8XUFrBu0ObvzQPI8Qv
        2+C88O9pTwCmiyjgFqcMNf0jUdNOHHryO6ihdFiQPs3D0hg=
X-Google-Smtp-Source: ABdhPJxMYk+0yiY1+uAN+2mR0TjRGfTRWiGsjhIzJJS/53uf49SpN6sE5K220PSk+vYgi8cn8nGDEdIplUiTLUJ81Hw=
X-Received: by 2002:a17:906:37cd:b0:6e0:bdb6:f309 with SMTP id
 o13-20020a17090637cd00b006e0bdb6f309mr1842468ejc.394.1649103464328; Mon, 04
 Apr 2022 13:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220318021314.3225240-1-davidgow@google.com> <20220318021314.3225240-3-davidgow@google.com>
In-Reply-To: <20220318021314.3225240-3-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 4 Apr 2022 16:17:33 -0400
Message-ID: <CAFd5g47Fu5cyn_DzZJZQGLkrGqUO4FURdje0iw+efMt=z+aJZQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] kunit: expose ftrace-based API for stubbing out
 functions during tests
To:     David Gow <davidgow@google.com>, Steve Muckle <smuckle@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Steve Muckle

On Thu, Mar 17, 2022 at 10:13 PM David Gow <davidgow@google.com> wrote:
>
> From: Daniel Latypov <dlatypov@google.com>
>
> Allow function redirection using ftrace and kernel livepatch. This is
> basically equivalent to the static_stub support in the previous patch,
> but does not require the function being replaced to be modified (save
> for the addition of KUNIT_STUBBABLE/noinline).
>
> This is hidden behind the CONFIG_KUNIT_FTRACE_STUBS option, and has a
> number of dependencies, including ftrace, livepatch and
> CONFIG_KALLSYMS_ALL. As a result, it only works on architectures where
> these are available.
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
>   * this ensures we can actually stub all calls
> * KUNIT_STUBBABLE_TRAMPOLINE is a version that evaluates to
>   __always_inline when stubbing is not enabled
>   * This may need to be used with a wrapper function.
>   * See the doc comment for more details.
>
> Sharp-edges:
> * kernel livepatch only works on some arches (not UML)
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
>  include/kunit/ftrace_stub.h         |  84 +++++++++++++++++
>  lib/kunit/Kconfig                   |  11 +++
>  lib/kunit/Makefile                  |   4 +
>  lib/kunit/ftrace_stub.c             | 138 ++++++++++++++++++++++++++++
>  lib/kunit/kunit-example-test.c      |  27 +++++-
>  lib/kunit/stubs_example.kunitconfig |  11 +++
>  6 files changed, 274 insertions(+), 1 deletion(-)
>  create mode 100644 include/kunit/ftrace_stub.h
>  create mode 100644 lib/kunit/ftrace_stub.c
>  create mode 100644 lib/kunit/stubs_example.kunitconfig
>
> diff --git a/include/kunit/ftrace_stub.h b/include/kunit/ftrace_stub.h
> new file mode 100644
> index 000000000000..54c053b7e9c1
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
> + * are not inlined. This macro eavlautes to noinline when stubbing support is
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
> + *             kunit_active_ftrace_stub(test, real_func, replacement_func);
> + *             KUNIT_EXPECT_EQ(test, real_func(1), 42);
> + *     }
> + *
> + */
> +#define kunit_activate_ftrace_stub(test, func, replacement) do { \
> +       typecheck(typeof(func), replacement); \
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
> index 0b5dfb001bac..978e4f72bae0 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -59,4 +59,15 @@ config KUNIT_ALL_TESTS
>
>           If unsure, say N.
>
> +config KUNIT_FTRACE_STUBS
> +       bool "Support for stubbing out functions in KUnit tests with ftrace and kernel livepatch"
> +       depends on FTRACE=y && FUNCTION_TRACER=y && MODULES=y && DEBUG_KERNEL=y && KALLSYMS_ALL=y && LIVEPATCH=y
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
> index f9e929700782..75092c12c3d0 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -19,3 +19,7 @@ obj-$(CONFIG_KUNIT_TEST) +=           string-stream-test.o
>  endif
>
>  obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=    kunit-example-test.o
> +
> +ifeq ($(CONFIG_KUNIT_FTRACE_STUBS),y)
> +kunit-objs +=                          ftrace_stub.o
> +endif
> diff --git a/lib/kunit/ftrace_stub.c b/lib/kunit/ftrace_stub.c
> new file mode 100644
> index 000000000000..13207e1c7aff
> --- /dev/null
> +++ b/lib/kunit/ftrace_stub.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <kunit/test.h>
> +
> +#include <linux/typecheck.h>
> +
> +#include <linux/ftrace.h>
> +#include <linux/livepatch.h>
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
> +       klp_arch_set_pc(fregs, ctx->replacement_addr);
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
> +static bool __kunit_static_stub_resource_match(struct kunit *test,
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
> +                                 __kunit_static_stub_resource_match,
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
> index 670c21e74446..7f20b132343b 100644
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
> @@ -72,7 +73,7 @@ static void example_mark_skipped_test(struct kunit *test)
>  }
>
>  /* This is a function we'll replace with static stubs. */
> -static int add_one(int i)
> +static KUNIT_STUBBABLE int add_one(int i)
>  {
>         /* This will trigger the stub if active. */
>         KUNIT_STATIC_STUB_REDIRECT(add_one, i);
> @@ -107,6 +108,29 @@ static void example_static_stub_test(struct kunit *test)
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
> @@ -122,6 +146,7 @@ static struct kunit_case example_test_cases[] = {
>         KUNIT_CASE(example_skip_test),
>         KUNIT_CASE(example_mark_skipped_test),
>         KUNIT_CASE(example_static_stub_test),
> +       KUNIT_CASE(example_ftrace_stub_test),
>         {}
>  };
>
> diff --git a/lib/kunit/stubs_example.kunitconfig b/lib/kunit/stubs_example.kunitconfig
> new file mode 100644
> index 000000000000..a47369199fb9
> --- /dev/null
> +++ b/lib/kunit/stubs_example.kunitconfig
> @@ -0,0 +1,11 @@
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
> +CONFIG_LIVEPATCH=y
> --
> 2.35.1.894.gb6a874cedc-goog
>
