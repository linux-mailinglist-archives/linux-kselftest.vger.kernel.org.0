Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AD8681DFC
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 23:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjA3WYP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 17:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjA3WYN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 17:24:13 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE42030B06
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 14:23:59 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1442977d77dso17079961fac.6
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 14:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tXb9lvW5X7NWsG9M58MdqipsqLwf3v/o3KhBWeyPvbA=;
        b=h4KUFKM/xgytQYfw3zzsdwe4Jv3KJwc0oqHnAELluL7+XBs5KszjviHid/IkVLh3ie
         3gSUhUtuvM+POpFpV2ygEISmaVeqhlbdi491ritu3Ob+0VpqfQRu5MH7XqErNC96ILbd
         0126K6Bhh2yETVHf/bpNrTH4wIv6VAULmvDqz7FnHO1LEeW4zQYyTh8ftSlYB8oBTT1J
         j1b25gRBJm8KauTlpKkrmIQg/g8e8yiAENvp2srUBf0YnnwU3BzaToNlY21crFOCP8dQ
         j+QlufFkNobMNHuz425eqV1Nxvl6lMz/vhseAC0HNo2HoJFrGXZ5b605+CM2jIiYSC2d
         voAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXb9lvW5X7NWsG9M58MdqipsqLwf3v/o3KhBWeyPvbA=;
        b=3H6ivu14UIcGQelSQwt/u0opCLWFLB6vhaiOGs8RBgzRnjn6T/Z3LghOGrx6pGIfT+
         1mNXdhWOsUzF+nXnm60dWqrproyDEbCrPGUqQddY7r732u1dr1W7zc7jA2JaxiaKKY3f
         f1BEbaw+PEeH6dRz6YQmN/WFB4XFcSBbICpRx646I6oC+NskejbeCtxqSegvIew4gnhN
         IY0NG37ro0DaD8ZDTDKpeQtraVsy3iRGFZgXV3XlhOnYbpsCOjQo3vGwKo0QPirEDUud
         wz2mjiaHsnrElH4HIMWq2LaN8Oc4bIm71Alp6CwKIqu/nkGCeEHpSMqOAV6INnVrnUfl
         Kxyg==
X-Gm-Message-State: AO0yUKX6zQljTK/Cd0PlwiuPY1CNXtlbdLYz+YLIOwv9qdCtbDNbi6fI
        Y7kU0vEPCpXeSAWEvFB/FBqcaMbENibcIcGj+u3xug==
X-Google-Smtp-Source: AK7set9Xds2F+USjO+ho06Da7R6oq3md9EdG3/BBEJlTlgy58k8R5l7rEJoAlwt/CV6ByGT2+wfIMvAx0d0YdoV3Hho=
X-Received: by 2002:a05:6870:a792:b0:163:16a3:de51 with SMTP id
 x18-20020a056870a79200b0016316a3de51mr2897650oao.122.1675117438148; Mon, 30
 Jan 2023 14:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20230128071007.1134942-1-davidgow@google.com>
In-Reply-To: <20230128071007.1134942-1-davidgow@google.com>
From:   Rae Moar <rmoar@google.com>
Date:   Mon, 30 Jan 2023 17:23:45 -0500
Message-ID: <CA+GJov7KfwSRCyiAMO8tOxDkMZX39Hk_yu2mJHBzj5joAM932Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: Add "hooks" to call into KUnit when it's built as
 a module
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
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

On Sat, Jan 28, 2023 at 2:10 AM David Gow <davidgow@google.com> wrote:
>
> KUnit has several macros and functions intended for use from non-test
> code. These hooks, currently the kunit_get_current_test() and
> kunit_fail_current_test() macros, didn't work when CONFIG_KUNIT=m.
>
> In order to support this case, the required functions and static data
> need to be available unconditionally, even when KUnit itself is not
> built-in. The new 'hooks.c' file is therefore always included, and has
> both the static key required for kunit_get_current_test(), and a table
> of function pointers in struct kunit_hooks_table. This is filled in with
> the real implementations by kunit_install_hooks(), which is kept in
> hooks-impl.h and called when the kunit module is loaded.
>
> This can  be extended for future features which require similar
> "hook" behaviour, such as static stubs, by simply adding new entries to
> the struct, and the appropriate code to set them.
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> This is basically a prerequisite for the stub features working when
> KUnit is built as a module, and should nicely make a few other tests
> work, too.
>
> This version uses a struct, rather than a bunch of separate function
> pointers, to define the list of hooks in one place. It also doesn't use
> the macro magic from RFC v2 (which we could reintroduce later if we end
> up with enough hooks that it'd make sense). It does get rid of all of

Hi David!

I have reviewed and tested the patch and it looks great to me! I think
this is the cleanest of the versions discussed in the previous
patches. The "macro magic" from the previous version was very neat and
I can see that working well with more hooks as you said above.
Something to keep in the back of our minds in the future. However,
this seems a bit tidier for the moment.

Thanks!

Reviewed-by: Rae Moar <rmoar@google.com>

> the nasty checkpatch.pl warnings, though, save for:
>
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> #230: FILE: lib/kunit/hooks.c:16:
> +EXPORT_SYMBOL(kunit_running);
>
> This is a false-positive, as the EXPORT_SYMBOL() immediately follows the
> DEFINE_STATIC_KEY_FALSE() macro, which checkpatch doesn't recognise as a
> definition.
>

Great that we don't need to deal with most of the checkpatch warnings
from the previous version! This warning seems difficult to avoid in
this case, so this seems alright to me.

> Cheers,
> -- David
>
> Changes since RFC v2:
> https://lore.kernel.org/linux-kselftest/20230124080350.2275652-1-davidgow@google.com/
> - Get rid of the macro magic, and keep the function pointers in a
>   struct.
>   - Also, reset them to NULL using memset, so we don't need to loop
>     through all of them manually.
>   - Thanks Daniel!
> - Properly forward-declare all of the implementations, now in
>   "hooks-impl.h", so they can easily be split across different files.
>   (Needed for the stubs implementation.)
> - Extract the stub installation into a separate function,
>   kunit_install_hooks().
>   - Thanks Daniel!
>
> Changes since RFC v1:
> https://lore.kernel.org/all/20230117142737.246446-1-davidgow@google.com/
> - Major refit to auto-generate the hook code using macros.
> - (Note that previous Reviewed-by tags have not been added, as this is a
>   big enough change it probably needs a re-reviews. Thanks Rae for
>   reviewing RFC v1 previously, though!)
>
> ---
>  Documentation/dev-tools/kunit/usage.rst | 14 ++++++-------
>  include/kunit/test-bug.h                | 28 +++++++++----------------
>  lib/Makefile                            |  8 +++++++
>  lib/kunit/Makefile                      |  3 +++
>  lib/kunit/hooks-impl.h                  | 27 ++++++++++++++++++++++++
>  lib/kunit/hooks.c                       | 21 +++++++++++++++++++
>  lib/kunit/test.c                        | 14 ++++++-------
>  7 files changed, 82 insertions(+), 33 deletions(-)
>  create mode 100644 lib/kunit/hooks-impl.h
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
> diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> index c1b2e14eab64..2b505a95b641 100644
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
> @@ -17,6 +17,11 @@
>  /* Static key if KUnit is running any tests. */
>  DECLARE_STATIC_KEY_FALSE(kunit_running);
>
> +/* Hooks table: a table of function pointers filled in when kunit loads */
> +extern struct kunit_hooks_table {
> +       __printf(3, 4) void (*fail_current_test)(const char*, int, const char*, ...);
> +} kunit_hooks;
> +
>  /**
>   * kunit_get_current_test() - Return a pointer to the currently running
>   *                           KUnit test.
> @@ -43,33 +48,20 @@ static inline struct kunit *kunit_get_current_test(void)
>   * kunit_fail_current_test() - If a KUnit test is running, fail it.
>   *
>   * If a KUnit test is running in the current task, mark that test as failed.
> - *
> - * This macro will only work if KUnit is built-in (though the tests
> - * themselves can be modules). Otherwise, it compiles down to nothing.
>   */
>  #define kunit_fail_current_test(fmt, ...) do {                                 \
>                 if (static_branch_unlikely(&kunit_running)) {                   \
> -                       __kunit_fail_current_test(__FILE__, __LINE__,           \
> +                       /* Guaranteed to be non-NULL when kunit_running true*/  \
> +                       kunit_hooks.fail_current_test(__FILE__, __LINE__,       \
>                                                   fmt, ##__VA_ARGS__);          \
>                 }                                                               \
>         } while (0)
>
> -
> -extern __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
> -                                                   const char *fmt, ...);
> -
>  #else
>
>  static inline struct kunit *kunit_get_current_test(void) { return NULL; }
>
> -/* We define this with an empty helper function so format string warnings work */
> -#define kunit_fail_current_test(fmt, ...) \
> -               __kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
> -
> -static inline __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
> -                                                           const char *fmt, ...)
> -{
> -}
> +#define kunit_fail_current_test(fmt, ...) do {} while (0)
>
>  #endif
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 4d9461bfea42..55fd04a7d0fb 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -126,6 +126,14 @@ CFLAGS_test_fpu.o += $(FPU_CFLAGS)
>  obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
>
>  obj-$(CONFIG_KUNIT) += kunit/
> +# Include the KUnit hooks unconditionally. They'll compile to nothing if
> +# CONFIG_KUNIT=n, otherwise will be a small table of static data (static key,
> +# function pointers) which need to be built-in even when KUnit is a module.
> +ifeq ($(CONFIG_KUNIT), m)
> +obj-y += kunit/hooks.o
> +else
> +obj-$(CONFIG_KUNIT) += kunit/hooks.o
> +endif
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
> diff --git a/lib/kunit/hooks-impl.h b/lib/kunit/hooks-impl.h
> new file mode 100644
> index 000000000000..d911f40f76db
> --- /dev/null
> +++ b/lib/kunit/hooks-impl.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Declarations for hook implementations.
> + *
> + * These will be set as the function pointers in struct kunit_hook_table,
> + * found in include/kunit/test-bug.h.
> + *
> + * Copyright (C) 2023, Google LLC.
> + * Author: David Gow <davidgow@google.com>
> + */
> +
> +#ifndef _KUNIT_HOOKS_IMPL_H
> +#define _KUNIT_HOOKS_IMPL_H
> +
> +#include <kunit/test-bug.h>
> +
> +/* List of declarations. */
> +void __kunit_fail_current_test_impl(const char *file, int line, const char *fmt, ...);
> +
> +/* Code to set all of the function pointers. */
> +static inline void kunit_install_hooks(void)
> +{
> +       /* Install the KUnit hook functions. */
> +       kunit_hooks.fail_current_test = __kunit_fail_current_test_impl;
> +}
> +
> +#endif /* _KUNIT_HOOKS_IMPL_H */

I slightly question adding a new file to set the function pointer.
However, as more hooks are added, I understand this will help remove
clutter from test.c, so this looks good to me.

> diff --git a/lib/kunit/hooks.c b/lib/kunit/hooks.c
> new file mode 100644
> index 000000000000..365d98d4953c
> --- /dev/null
> +++ b/lib/kunit/hooks.c
> @@ -0,0 +1,21 @@
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
> +
> +#include <kunit/test-bug.h>
> +
> +DEFINE_STATIC_KEY_FALSE(kunit_running);
> +EXPORT_SYMBOL(kunit_running);
> +
> +/* Function pointers for hooks. */
> +struct kunit_hooks_table kunit_hooks;
> +EXPORT_SYMBOL(kunit_hooks);
> +
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c9ebf975e56b..51cae59d8aae 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -17,16 +17,14 @@
>  #include <linux/sched.h>
>
>  #include "debugfs.h"
> +#include "hooks-impl.h"
>  #include "string-stream.h"
>  #include "try-catch-impl.h"
>
> -DEFINE_STATIC_KEY_FALSE(kunit_running);
> -
> -#if IS_BUILTIN(CONFIG_KUNIT)
>  /*
> - * Fail the current test and print an error message to the log.
> + * Hook to fail the current test and print an error message to the log.
>   */
> -void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
> +void __kunit_fail_current_test_impl(const char *file, int line, const char *fmt, ...)
>  {
>         va_list args;
>         int len;
> @@ -53,8 +51,6 @@ void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
>         kunit_err(current->kunit_test, "%s:%d: %s", file, line, buffer);
>         kunit_kfree(current->kunit_test, buffer);
>  }
> -EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
> -#endif
>
>  /*
>   * Enable KUnit tests to run.
> @@ -777,6 +773,9 @@ EXPORT_SYMBOL_GPL(kunit_cleanup);
>
>  static int __init kunit_init(void)
>  {
> +       /* Install the KUnit hook functions. */
> +       kunit_install_hooks();
> +
>         kunit_debugfs_init();
>  #ifdef CONFIG_MODULES
>         return register_module_notifier(&kunit_mod_nb);
> @@ -788,6 +787,7 @@ late_initcall(kunit_init);
>
>  static void __exit kunit_exit(void)
>  {
> +       memset(&kunit_hooks, 0, sizeof(kunit_hooks));
>  #ifdef CONFIG_MODULES
>         unregister_module_notifier(&kunit_mod_nb);
>  #endif
> --
> 2.39.1.456.gfc5497dd1b-goog
>
