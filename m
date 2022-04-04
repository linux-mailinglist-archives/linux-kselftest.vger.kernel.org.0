Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB994F1C84
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Apr 2022 23:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379713AbiDDV1d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Apr 2022 17:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380487AbiDDUS0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Apr 2022 16:18:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ED7DF20
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Apr 2022 13:16:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r13so22346452ejd.5
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Apr 2022 13:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1ib/jDfUzihK9xuV8zGLa9FEMAJ9vNd2XvqvSY7jCE=;
        b=j38KLjBxu1pupDwsC/mbWCdECKlaVGMKhL1i41JSSG6ZrUFDUKA3GltQMqZacy4t0k
         /U7uTiFEaGK42UuwQi/3X6do/M1eQ+MlHk+qfpTFa4OtvYxrrSWcCP5U2y+8XljQ2Z1T
         LcWurBs64cH5LNTZGAOLOBMzHbI0rRGV6DmkpVbzbdfFhN0u6dHe5Xts2ab/37DmIXad
         gfjRJ6BpfP/z6prpckr5NioRvmwQVmDXR1XEM1/9ai6c0+r9Qa3udmxSVeRgNc9zfHrn
         9MW3KgPEOEya8Q+Kz/pYe2J6OWpFxdGp0y+BAbzDhUqgRsqCtSrD7AS8EI4JfmzJlSLd
         Oqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1ib/jDfUzihK9xuV8zGLa9FEMAJ9vNd2XvqvSY7jCE=;
        b=DGi7q1K1On/LQy+s8UwZ8E6zjJZ10Bq34EN7vHL0PmSZ0NgDD8nTa5aMtbV0ktUKgE
         s7korgxDFMfHsE2T/RE4f52X3WXKaU1Dmym3Q8qrTckqiAP1GQhrHm/RuToKaZsFvSeg
         KQAW2uPonrcBdlsaozFeojTmMPLMiAfxLxdxjncvLaL9xHfVtatKNqTT1K8lDi8C8zil
         UNbvzPfiz0YJfKpp6sZ+HmbWEHCVxLMMV8Dbazf0t6nKjKmaMyfOA3agim4pJKtgXCxK
         7BMJiV4ZFF9Wn0u/3sFFQt4vQetk4Rb8oMU6Mo8aFH+awoRAzrz1PSMYfvJa+jAt5M/T
         G4Dg==
X-Gm-Message-State: AOAM532hNEKSTkD8bE5dZvrwVQfa5J9y9pV1xKM4iU9G5S95N2/hJaft
        /oWjgO6/MAqcHnZkDWgbwYwPKDats04VX1Lkez+mwA==
X-Google-Smtp-Source: ABdhPJwTx2uwIoWqKwtsiv5Bmz10IcP07QVLaWGsoicKIHBRcTSyTyE/tU0Ds3z+vqDeg3cGpJbdqfr8bZwrFhDd/sw=
X-Received: by 2002:a17:907:c018:b0:6df:e31b:d912 with SMTP id
 ss24-20020a170907c01800b006dfe31bd912mr1864013ejc.196.1649103386602; Mon, 04
 Apr 2022 13:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220318021314.3225240-1-davidgow@google.com> <20220318021314.3225240-2-davidgow@google.com>
In-Reply-To: <20220318021314.3225240-2-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 4 Apr 2022 16:16:15 -0400
Message-ID: <CAFd5g46zjsrz16mYmu1Q57dYkch6J2FO1XkM9XwS=cWiUidz6g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] kunit: Expose 'static stub' API to redirect functions
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
> Add a simple way of redirecting calls to functions by including a
> special prologue in the "real" function which checks to see if the
> replacement function should be called (and, if so, calls it).
>
> To redirect calls to a function, make the first (non-declaration) line
> of the function:
>
>         KUNIT_STATIC_STUB_REDIRECT(function_name, [function arguments]);
>
> (This will compile away to nothing if KUnit is not enabled, otherwise it
> will check if a redirection is active, call the replacement function,
> and return.)
>
> Calls to the real function can be redirected to a replacement using:
>
>         kunit_activate_static_stub(test, real_fn, replacement_fn);
>
> The redirection will only affect calls made from within the kthread of
> the current test, and will be automatically disabled when the test
> completes. It can also be manually disabled with
> kunit_deactivate_static_stub().
>
> The 'example' KUnit test suite has a more complete example.
>
> This is intended to be an alternative to ftrace-based stubbing (see the
> next patch), with different tradeoffs.
>
> In particular:
> - 'static stubs' work on all architectures, and don't have any
>   dependencies.
>   - There's no separate Kconfig option to enable them, they always
>     exist.
> - They must be explicitly opted-into by the function being replaced
>   (which can be good or bad depending on your POV)
> - They have a greater performance penalty when not in active use (as
>   every call to the real function must check to see if the stub is
>   enabled)
> - They could more easily be extended to pass additional context to
>   replacement functions.
>
> Co-developed-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  include/kunit/static_stub.h    | 106 ++++++++++++++++++++++++++++
>  lib/kunit/Makefile             |   1 +
>  lib/kunit/kunit-example-test.c |  39 ++++++++++
>  lib/kunit/static_stub.c        | 125 +++++++++++++++++++++++++++++++++
>  4 files changed, 271 insertions(+)
>  create mode 100644 include/kunit/static_stub.h
>  create mode 100644 lib/kunit/static_stub.c
>
> diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
> new file mode 100644
> index 000000000000..020e0e9110f2
> --- /dev/null
> +++ b/include/kunit/static_stub.h
> @@ -0,0 +1,106 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KUnit function redirection (static stubbing) API.
> + *
> + * Copyright (C) 2022, Google LLC.
> + * Author: David Gow <davidgow@google.com>
> + */
> +#ifndef _KUNIT_STATIC_STUB_H
> +#define _KUNIT_STATIC_STUB_H
> +
> +#if !IS_REACHABLE(CONFIG_KUNIT)
> +
> +/* If CONFIG_KUNIT is not enabled, these stubs quietly disappear. */
> +#define KUNIT_TRIGGER_STATIC_STUB(real_fn_name, args...) do {} while (0)
> +
> +#else
> +
> +#include <kunit/test.h>
> +
> +#include <linux/compiler.h> /* for {un,}likely() */
> +#include <linux/sched.h> /* for task_struct */
> +
> +/* Returns the address of the replacement function. */
> +void *__kunit_get_static_stub_address(struct kunit *test, void *real_fn_addr);
> +
> +/**
> + * KUNIT_STATIC_STUB_REDIRECT() - call a replacement 'static stub' if one exists
> + * @real_fn_name: The name of this function (as an identifier, not a string)
> + * @args: All of the arguments passed to this function
> + *
> + * This is a function prologue which is used to allow calls to the current
> + * function to be redirected by a KUnit test. KUnit tests can call
> + * kunit_activate_static_stub() to pass a replacement function in. The
> + * replacement function will be called by KUNIT_TRIGGER_STATIC_STUB(), which
> + * will then return from the function. If the caller is not in a KUnit context,
> + * the function will continue execution as normal.
> + *
> + * Example:
> + *
> + * .. code-block:: c
> + *     int real_func(int n)
> + *     {
> + *             KUNIT_STATIC_STUB_REDIRECT(real_func, n);
> + *             return 0;
> + *     }
> + *
> + *     void replacement_func(int n)
> + *     {
> + *             return 42;
> + *     }
> + *
> + *     void example_test(struct kunit *test)
> + *     {
> + *             kunit_activate_static_stub(test, real_func, replacement_func);
> + *             KUNIT_EXPECT_EQ(test, real_func(1), 42);
> + *     }
> + *
> + */
> +#define KUNIT_STATIC_STUB_REDIRECT(real_fn_name, args...)              \
> +do {                                                                   \
> +       typeof(&real_fn_name) replacement;                              \
> +       struct kunit *current_test = current->kunit_test;               \
> +                                                                       \
> +       if (likely(!current_test))                                      \
> +               break;                                                  \
> +                                                                       \
> +       KUNIT_ASSERT_STREQ_MSG(current_test, __func__, #real_fn_name,   \
> +                              "Static stub function name mismatch");   \
> +                                                                       \
> +       replacement = __kunit_get_static_stub_address(current_test,     \
> +                                                       &real_fn_name); \
> +                                                                       \
> +       if (unlikely(replacement))                                      \
> +               return replacement(args);                               \
> +} while (0)
> +
> +/* Helper function for kunit_activate_static_stub(). The macro does
> + * typechecking, so use it instead.
> + */
> +void __kunit_activate_static_stub(struct kunit *test,
> +                                 void *real_fn_addr,
> +                                 void *replacement_addr);
> +
> +/**
> + * kunit_activate_static_stub() - replace a function using static stubs.
> + * @test: A pointer to the 'struct kunit' test context for the current test.
> + * @real_fn_addr: The address of the function to replace.
> + * @replacement_addr: The address of the function to replace it with.
> + *
> + * When activated, calls to real_fn_addr from within this test (even if called
> + * indirectly) will instead call replacement_addr. The function pointed to by
> + * real_fn_addr must begin with the static stub prologue in
> + * KUNIT_TRIGGER_STATIC_STUB() for this to work. real_fn_addr and
> + * replacement_addr must have the same type.
> + *
> + * The redirection can be disabled again with kunit_deactivate_static_stub().
> + */
> +#define kunit_activate_static_stub(test, real_fn_addr, replacement_addr) do {  \
> +       typecheck(typeof(real_fn_addr), replacement_addr);                      \
> +       __kunit_activate_static_stub(test, real_fn_addr, replacement_addr);     \
> +} while (0)
> +
> +void kunit_deactivate_static_stub(struct kunit *test, void *real_fn_addr);
> +
> +#endif
> +#endif
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index c49f4ffb6273..f9e929700782 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -1,6 +1,7 @@
>  obj-$(CONFIG_KUNIT) +=                 kunit.o
>
>  kunit-objs +=                          test.o \
> +                                       static_stub.o \
>                                         string-stream.o \
>                                         assert.o \
>                                         try-catch.o \
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index 51099b0ca29c..670c21e74446 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <kunit/test.h>
> +#include <kunit/static_stub.h>
>
>  /*
>   * This is the most fundamental element of KUnit, the test case. A test case
> @@ -69,6 +70,43 @@ static void example_mark_skipped_test(struct kunit *test)
>         /* This line should run */
>         kunit_info(test, "You should see this line.");
>  }
> +
> +/* This is a function we'll replace with static stubs. */
> +static int add_one(int i)
> +{
> +       /* This will trigger the stub if active. */
> +       KUNIT_STATIC_STUB_REDIRECT(add_one, i);
> +
> +       return i + 1;
> +}
> +
> +/* This is used as a replacement for the above function. */
> +static int subtract_one(int i)
> +{
> +       /* We don't need to trigger the stub from the replacement. */
> +
> +       return i - 1;
> +}
> +
> +/*
> + * This test shows the use of static stubs.
> + */
> +static void example_static_stub_test(struct kunit *test)
> +{
> +       /* By default, function is not stubbed. */
> +       KUNIT_EXPECT_EQ(test, add_one(1), 2);
> +
> +       /* Replace add_one() with subtract_one(). */
> +       kunit_activate_static_stub(test, add_one, subtract_one);
> +
> +       /* add_one() is now replaced. */
> +       KUNIT_EXPECT_EQ(test, add_one(1), 0);
> +
> +       /* Return add_one() to normal. */
> +       kunit_deactivate_static_stub(test, add_one);
> +       KUNIT_EXPECT_EQ(test, add_one(1), 2);
> +}
> +
>  /*
>   * Here we make a list of all the test cases we want to add to the test suite
>   * below.
> @@ -83,6 +121,7 @@ static struct kunit_case example_test_cases[] = {
>         KUNIT_CASE(example_simple_test),
>         KUNIT_CASE(example_skip_test),
>         KUNIT_CASE(example_mark_skipped_test),
> +       KUNIT_CASE(example_static_stub_test),
>         {}
>  };
>
> diff --git a/lib/kunit/static_stub.c b/lib/kunit/static_stub.c
> new file mode 100644
> index 000000000000..b06b88f82dd7
> --- /dev/null
> +++ b/lib/kunit/static_stub.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit function redirection (static stubbing) API.
> + *
> + * Copyright (C) 2022, Google LLC.
> + * Author: David Gow <davidgow@google.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <kunit/static_stub.h>
> +
> +
> +/* Context for a static stub. This is stored in the resource data. */
> +struct kunit_static_stub_ctx {
> +       void *real_fn_addr;
> +       void *replacement_addr;
> +};
> +
> +static void __kunit_static_stub_resource_free(struct kunit_resource *res)
> +{
> +       kfree(res->data);
> +}
> +
> +/* Matching function for kunit_find_resource(). match_data is real_fn_addr. */
> +static bool __kunit_static_stub_resource_match(struct kunit *test,
> +                                               struct kunit_resource *res,
> +                                               void *match_real_fn_addr)
> +{
> +       /* This pointer is only valid if res is a static stub resource. */
> +       struct kunit_static_stub_ctx *ctx = res->data;
> +
> +       /* Make sure the resource is a static stub resource. */
> +       if (res->free != &__kunit_static_stub_resource_free)
> +               return false;
> +
> +       return ctx->real_fn_addr == match_real_fn_addr;
> +}
> +
> +/* Returns the address of the replacement function. */
> +void *__kunit_get_static_stub_address(struct kunit *test, void *real_fn_addr)
> +{
> +       struct kunit_resource *res;
> +       struct kunit_static_stub_ctx *ctx;
> +       void *replacement_addr;
> +
> +       res = kunit_find_resource(test,
> +                                 __kunit_static_stub_resource_match,
> +                                 real_fn_addr);
> +
> +       if (!res)
> +               return NULL;
> +
> +       ctx = res->data;
> +       replacement_addr = ctx->replacement_addr;
> +       kunit_put_resource(res);
> +       return replacement_addr;
> +}
> +EXPORT_SYMBOL_GPL(__kunit_get_static_stub_address);
> +
> +void kunit_deactivate_static_stub(struct kunit *test, void *real_fn_addr)
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
> +        * from kunit_find_resource()
> +        */
> +       kunit_remove_resource(test, res);
> +       kunit_put_resource(res);
> +}
> +EXPORT_SYMBOL_GPL(kunit_deactivate_static_stub);
> +
> +/* Helper function for kunit_activate_static_stub(). The macro does
> + * typechecking, so use it instead.
> + */
> +void __kunit_activate_static_stub(struct kunit *test,
> +                                 void *real_fn_addr,
> +                                 void *replacement_addr)
> +{
> +       struct kunit_static_stub_ctx *ctx;
> +       struct kunit_resource *res;
> +
> +       KUNIT_ASSERT_PTR_NE_MSG(test, real_fn_addr, NULL,
> +                               "Tried to activate a stub for function NULL");
> +
> +       /* If the replacement address is NULL, deactivate the stub. */
> +       if (!replacement_addr) {
> +               kunit_deactivate_static_stub(test, replacement_addr);
> +               return;
> +       }
> +
> +       /* Look up any existing stubs for this function, and replace them. */
> +       res = kunit_find_resource(test,
> +                                 __kunit_static_stub_resource_match,
> +                                 real_fn_addr);
> +       if (res) {
> +               ctx = res->data;
> +               ctx->replacement_addr = replacement_addr;
> +
> +               /* We got an extra reference from find_resource(), so put it. */
> +               kunit_put_resource(res);
> +       } else {
> +               ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
> +               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +               ctx->real_fn_addr = real_fn_addr;
> +               ctx->replacement_addr = replacement_addr;
> +               res = kunit_alloc_resource(test, NULL,
> +                                    &__kunit_static_stub_resource_free,
> +                                    GFP_KERNEL, ctx);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(__kunit_activate_static_stub);
> +
> +
> --
> 2.35.1.894.gb6a874cedc-goog
>
