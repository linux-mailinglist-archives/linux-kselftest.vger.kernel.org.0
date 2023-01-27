Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E991067DAE5
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 01:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjA0AtN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 19:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjA0AtM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 19:49:12 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D319C470B5
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 16:49:09 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id j1so1287127iob.6
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 16:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JPAR9qbPBT98lToPY9XdhPXClo5wa/Nb1sY8DyZ/V/o=;
        b=fj7ywk5pgP6dncAx/4AOpiiw3UZZRoVqUO0TMnvU2HPTs5D5hCBt6YGsimt/V+tezo
         r6vOdxTGYmYVtfMpO9XGMbpLJ2NWxc24laJRNz/hrF5DrsYazFV3hM8RiTIBERlqvqjI
         5HxMMkwxh4pQ8Hn4whwqZKzqosOqGjWYtnOAtR6CQzjLpVRg5cupK70FPGpWHUVHDzvn
         2kpBstutVKvfYskdt6VfoP7AUWuTF1iTfn4JJTaLEAu1henGHWKm5/gPPOiqldPI2Bqw
         jjKil74fu69T627ZAT5iKUgPIM9J8RWNGXsrgnf73Yd08GdU8ezNNFaXk7O5dghofmmv
         1wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPAR9qbPBT98lToPY9XdhPXClo5wa/Nb1sY8DyZ/V/o=;
        b=s+bLpIKW9W2pjos55NfNIKgPQYzqTt22aalpP9Do9s/R4eSI1EsXO4CKyOCu4f5Qil
         oqGv4D5gv3UgWm98KerdZKQL+EEuMv84eEGw8KzqIcRJCgl7DsgsZCFNg8fgk1T1WKor
         0Z/U2J4IAKz9KdotiOjBRdFfH6sskuYgIuJq2bH40fB/rb8H7yMYlKHliiUNtK3sEdbo
         aQi/PwIRt5vB5s/+aKXCZdVWRto2eC+wG/SaOQ0KW+2GXTAn600TGpvm3UtQ3PRtP8tv
         Q0z5Yl6etzAgEx2HQKL9p7THeKkirYqk6c3OeFA8ynUeuM5bMA0dTd+5ouX1ovo+EpbU
         lJNg==
X-Gm-Message-State: AFqh2kpwYn1BzBVzAel/U28w+XGgbNYhPGJg7MIH0GMTZ+p5IzWfj1nh
        nCXTPLVsMuC3SuhdopTAMClNH0MkFS8gsLX0VTGjJQ==
X-Google-Smtp-Source: AMrXdXue2+v+Ipdq1UTxYRWri9/cvLqRzIMRwNlNiFqI7sRhVuhk75VgM8v/MeghKnAtlL03Vcmzuncw5QTySg2cQs0=
X-Received: by 2002:a05:6602:2741:b0:704:dab9:edea with SMTP id
 b1-20020a056602274100b00704dab9edeamr3119333ioe.125.1674780548924; Thu, 26
 Jan 2023 16:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20230124080350.2275652-1-davidgow@google.com>
In-Reply-To: <20230124080350.2275652-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 26 Jan 2023 19:48:57 -0500
Message-ID: <CAFd5g47_fXBfmmiE93OGj65Lw6NNt5HPYq1Pz7x6f6nSzXsZfA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] kunit: Add "hooks" to call into KUnit when it's
 built as a module
To:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Kees Cook <keescook@chromium.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>,
        Sadiya Kazi <sadiyakazi@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Jan 24, 2023 at 3:04 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> KUnit has several macros and functions intended for use from non-test
> code. These hooks, currently the kunit_get_current_test() and
> kunit_fail_current_test() macros, didn't work when CONFIG_KUNIT=m.
>
> In order to support this case, the required functions and static data
> need to be available unconditionally, even when KUnit itself is not
> built-in. The new 'hooks.c' file is therefore always included, and has
> both the static key required for kunit_get_current_test(), and a
> function pointer to the real implementation of
> __kunit_fail_current_test(), which is populated when the KUnit module is
> loaded.
>
> A new header, kunit/hooks-table.h, contains a table of all hooks, and is
> repeatedly included with different definitions of the KUNIT_HOOK() in
> order to automatically generate the needed function pointer tables. When
> KUnit is disabled, or the module is not loaded, these function pointers
> are all NULL. This shouldn't be a problem, as they're all used behind
> wrappers which check kunit_running and/or that the pointer is non-NULL.
>
> This can then be extended for future features which require similar
> "hook" behaviour, such as static stubs:
> https://lore.kernel.org/all/20221208061841.2186447-1-davidgow@google.com/

Devilishly clever. Maybe too clever, but I don't have any better ideas, so:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Nevertheless, see my comments below:

> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> This is basically a prerequisite for the stub features working when
> KUnit is built as a module, and should nicely make a few other tests
> work then, too.
>
> v2 adds a slightly-excessive macro-based system for defining hooks. This
> made adding the static stub hooks absolutely trivial, and the complexity
> is totally hidden from the user (being an internal KUnit implementation
> detail), so I'm more comfortable with this than some other macro magic.
>
> It does however result in a huge number of checkpatch.pl errors, as
> we're using macros in unconventional ways, and checkpatch just can't
> work out the syntax. These are mostly "Macros with complex values should
> be enclosed in parentheses", "Macros with multiple statements should be
> enclosed in a do - while loop", and similar, which don't apply due to
> the macros not being expressions: they are mostly declarations or
> assignment statements. There are a few others where checkpatch thinks
> that the return value is the function name and similar, so complains
> about the style.

Shuah, what are your thoughts here? I think it's OK, but I don't want
to go any further down this path unless you are OK with it too.

> Open questions:
> - Is this macro-based system worth it, or was v1 better?

I think this is definitely better if we had more than one function to
hook. With just one function - I am less confident, but I like having
a set way to do it.

> - Should we rename test-bug.h to hooks.h or similar.
>   (I think so, but would rather do it in a separate patch, to make it
>   easier to review. There are a few includes of it scattered about.)

Agreed, that confused me at first.

> - Is making these NULL when KUnit isn't around sensible, or should we
>   auto-generate a "default" implementation. This is a pretty easy
>   extension to the macros here.
>   (I think NULL is good for now, as we have wrappers for these anyway.
>   If we want to change our minds later as we add more hooks, it's easy.)

Yeah, I'm fine with either.

> - Any other thoughts?

My primary concern was with the naming of test-bug.h, but you said
you'd handle that in another patch, which makes sense to me.

I also want to make sure Shuah is OK with the checkpatch warnings.

I did find two nits below:

> Cheers,
> -- David
>
> Changes since RFC v1:
> https://lore.kernel.org/all/20230117142737.246446-1-davidgow@google.com/
> - Major refit to auto-generate the hook code using macros.
> - (Note that previous Reviewed-by tags have not been added, as this is a
>   big enough change it probably needs a re-reviews. Thanks Rae for
>   reviewing RFC v1 previously, though!)
> ---
>  Documentation/dev-tools/kunit/usage.rst | 14 +++++-----
>  include/kunit/hooks-table.h             | 34 +++++++++++++++++++++++++
>  include/kunit/test-bug.h                | 24 +++++++++--------
>  lib/Makefile                            |  4 +++
>  lib/kunit/Makefile                      |  3 +++
>  lib/kunit/hooks.c                       | 27 ++++++++++++++++++++
>  lib/kunit/test.c                        | 22 +++++++++++-----
>  7 files changed, 103 insertions(+), 25 deletions(-)
>  create mode 100644 include/kunit/hooks-table.h
>  create mode 100644 lib/kunit/hooks.c
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 48f8196d5aad..6424493b93cb 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -648,10 +648,9 @@ We can do this via the ``kunit_test`` field in ``task_struct``, which we can
>  access using the ``kunit_get_current_test()`` function in ``kunit/test-bug.h``.
>
>  ``kunit_get_current_test()`` is safe to call even if KUnit is not enabled. If
> -KUnit is not enabled, was built as a module (``CONFIG_KUNIT=m``), or no test is
> -running in the current task, it will return ``NULL``. This compiles down to
> -either a no-op or a static key check, so will have a negligible performance
> -impact when no test is running.
> +KUnit is not enabled, or if no test is running in the current task, it will
> +return ``NULL``. This compiles down to either a no-op or a static key check,
> +so will have a negligible performance impact when no test is running.
>
>  The example below uses this to implement a "mock" implementation of a function, ``foo``:
>
> @@ -726,8 +725,7 @@ structures as shown below:
>         #endif
>
>  ``kunit_fail_current_test()`` is safe to call even if KUnit is not enabled. If
> -KUnit is not enabled, was built as a module (``CONFIG_KUNIT=m``), or no test is
> -running in the current task, it will do nothing. This compiles down to either a
> -no-op or a static key check, so will have a negligible performance impact when
> -no test is running.
> +KUnit is not enabled, or if no test is running in the current task, it will do
> +nothing. This compiles down to either a no-op or a static key check, so will
> +have a negligible performance impact when no test is running.
>
> diff --git a/include/kunit/hooks-table.h b/include/kunit/hooks-table.h
> new file mode 100644
> index 000000000000..0b5eafd199ed
> --- /dev/null
> +++ b/include/kunit/hooks-table.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KUnit 'Hooks' function pointer table
> + *
> + * This file is included multiple times, each time with a different definition
> + * of KUNIT_HOOK. This provides one place where all of the hooks can be listed
> + * which can then be converted into function / implementation declarations, or
> + * code to set function pointers.
> + *
> + * Copyright (C) 2023, Google LLC.
> + * Author: David Gow <davidgow@google.com>
> + */
> +
> +/*
> + * To declare a hook, use:
> + * KUNIT_HOOK(name, retval, args), where:
> + * - name: the function name of the exported hook
> + * - retval: the type of the return value of the hook
> + * - args: the arguments to the hook, of the form (int a, int b)
> + *
> + * Note that the argument list should be contained within the brackets (),
> + * and that the implementation of the hook should be in a <name>_impl
> + * function, which should not be declared static, but need not be exported.
> + */
> +
> +#ifndef KUNIT_HOOK
> +#error KUNIT_HOOK must be defined before including the hooks table
> +#endif
> +
> +KUNIT_HOOK(__kunit_fail_current_test, __printf(3, 4) void,
> +          (const char *file, int line, const char *fmt, ...));
> +
> +/* Undefine KUNIT_HOOK at the end, ready for the next use. */
> +#undef KUNIT_HOOK
> diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> index c1b2e14eab64..3203ffc0a08b 100644
> --- a/include/kunit/test-bug.h
> +++ b/include/kunit/test-bug.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * KUnit API allowing dynamic analysis tools to interact with KUnit tests
> + * KUnit API providing hooks for non-test code to interact with tests.
>   *
>   * Copyright (C) 2020, Google LLC.
>   * Author: Uriel Guajardo <urielguajardo@google.com>
> @@ -9,7 +9,7 @@
>  #ifndef _KUNIT_TEST_BUG_H
>  #define _KUNIT_TEST_BUG_H
>
> -#if IS_BUILTIN(CONFIG_KUNIT)
> +#if IS_ENABLED(CONFIG_KUNIT)
>
>  #include <linux/jump_label.h> /* For static branch */
>  #include <linux/sched.h>
> @@ -43,20 +43,21 @@ static inline struct kunit *kunit_get_current_test(void)
>   * kunit_fail_current_test() - If a KUnit test is running, fail it.
>   *
>   * If a KUnit test is running in the current task, mark that test as failed.
> - *
> - * This macro will only work if KUnit is built-in (though the tests
> - * themselves can be modules). Otherwise, it compiles down to nothing.
>   */
>  #define kunit_fail_current_test(fmt, ...) do {                                 \
>                 if (static_branch_unlikely(&kunit_running)) {                   \
> +                       /* Guaranteed to be non-NULL when kunit_running true*/  \
>                         __kunit_fail_current_test(__FILE__, __LINE__,           \
>                                                   fmt, ##__VA_ARGS__);          \
>                 }                                                               \
>         } while (0)
>
>
> -extern __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
> -                                                   const char *fmt, ...);
> +/* Declare all of the available hooks. */
> +#define KUNIT_HOOK(name, retval, args) \
> +       extern retval (*name)args
> +
> +#include "kunit/hooks-table.h"
>
>  #else
>
> @@ -66,10 +67,11 @@ static inline struct kunit *kunit_get_current_test(void) { return NULL; }
>  #define kunit_fail_current_test(fmt, ...) \
>                 __kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
>
> -static inline __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
> -                                                           const char *fmt, ...)
> -{
> -}
> +/* No-op stubs if KUnit is not enabled. */
> +#define KUNIT_HOOK(name, retval, args) \
> +       static retval (*name)args = NULL
> +
> +#include "kunit/hooks-table.h"
>
>  #endif
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 4d9461bfea42..9031de6ca73c 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -126,6 +126,10 @@ CFLAGS_test_fpu.o += $(FPU_CFLAGS)
>  obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
>
>  obj-$(CONFIG_KUNIT) += kunit/
> +# Include the KUnit hooks unconditionally. They'll compile to nothing if
> +# CONFIG_KUNIT=n, otherwise will be a small table of static data (static key,
> +# function pointers) which need to be built-in even when KUnit is a module.
> +obj-y += kunit/hooks.o
>
>  ifeq ($(CONFIG_DEBUG_KOBJECT),y)
>  CFLAGS_kobject.o += -DDEBUG
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 29aff6562b42..deeb46cc879b 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -11,6 +11,9 @@ ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
>  kunit-objs +=                          debugfs.o
>  endif
>
> +# KUnit 'hooks' are built-in even when KUnit is built as a module.
> +lib-y +=                               hooks.o
> +
>  obj-$(CONFIG_KUNIT_TEST) +=            kunit-test.o
>
>  # string-stream-test compiles built-in only.
> diff --git a/lib/kunit/hooks.c b/lib/kunit/hooks.c
> new file mode 100644
> index 000000000000..29e81614f486
> --- /dev/null
> +++ b/lib/kunit/hooks.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit 'Hooks' implementation.
> + *
> + * This file contains code / structures which should be built-in even when
> + * KUnit itself is built as a module.
> + *
> + * Copyright (C) 2022, Google LLC.
> + * Author: David Gow <davidgow@google.com>
> + */
> +
> +/* This file is always built-in, so make sure it's empty if CONFIG_KUNIT=n */
> +#if IS_ENABLED(CONFIG_KUNIT)
> +
> +#include <kunit/test-bug.h>
> +
> +DEFINE_STATIC_KEY_FALSE(kunit_running);
> +EXPORT_SYMBOL(kunit_running);
> +
> +/* Function pointers for hooks. */
> +#define KUNIT_HOOK(name, retval, args) \
> +       retval (*name)args; \
> +       EXPORT_SYMBOL(name)
> +
> +#include "kunit/hooks-table.h"
> +
> +#endif
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c9ebf975e56b..b6c88f722b68 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -20,13 +20,10 @@
>  #include "string-stream.h"
>  #include "try-catch-impl.h"
>
> -DEFINE_STATIC_KEY_FALSE(kunit_running);
> -
> -#if IS_BUILTIN(CONFIG_KUNIT)
>  /*
>   * Fail the current test and print an error message to the log.
>   */
> -void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)

nit: I think it would be good to add a comment here about this being a
hooked function or something.

> +void __kunit_fail_current_test_impl(const char *file, int line, const char *fmt, ...)
>  {
>         va_list args;
>         int len;
> @@ -53,8 +50,6 @@ void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
>         kunit_err(current->kunit_test, "%s:%d: %s", file, line, buffer);
>         kunit_kfree(current->kunit_test, buffer);
>  }
> -EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
> -#endif
>
>  /*
>   * Enable KUnit tests to run.
> @@ -775,8 +770,18 @@ void kunit_cleanup(struct kunit *test)
>  }
>  EXPORT_SYMBOL_GPL(kunit_cleanup);
>
> +/* Declarations for the hook implemetnations */

nit: spelling

> +#define KUNIT_HOOK(name, retval, args) \
> +       extern retval name##_impl args
> +#include "kunit/hooks-table.h"
> +
>  static int __init kunit_init(void)
>  {
> +       /* Install the KUnit hook functions. */
> +#define KUNIT_HOOK(name, retval, args) \
> +       name = name##_impl
> +#include "kunit/hooks-table.h"
> +
>         kunit_debugfs_init();
>  #ifdef CONFIG_MODULES
>         return register_module_notifier(&kunit_mod_nb);
> @@ -788,6 +793,11 @@ late_initcall(kunit_init);
>
>  static void __exit kunit_exit(void)
>  {
> +       /* Remove the KUnit hook functions. */
> +#define KUNIT_HOOK(name, retval, args) \
> +       name = NULL
> +#include "kunit/hooks-table.h"
> +
>  #ifdef CONFIG_MODULES
>         unregister_module_notifier(&kunit_mod_nb);
>  #endif
> --
> 2.39.0.246.g2a6d74b583-goog
