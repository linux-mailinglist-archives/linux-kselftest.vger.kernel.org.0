Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4771673FCE
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jan 2023 18:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjASRW2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Jan 2023 12:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjASRW1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Jan 2023 12:22:27 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E488F7C8
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jan 2023 09:22:19 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-15f83e0fc63so3271477fac.11
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jan 2023 09:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWB1si6F6xMECX8WoiHnq+DdFixzDMJ9BMk51tgeuKM=;
        b=YDaL81rEC8+1ArcaILiiXU1GyTyPLiavlpvNKYcNOhu+UnhroPUf0nFs5xs6vXvkm5
         N2dj5Dl0C/+roIbrBT/8PrI5gs7q5d/DfEgpzgzjmfli34fErVrnnG0wh3ADeizNdQXx
         2H8QMhVhCmIyq43ET85C1fLdWypBYbz7y83wPHk1EJuNHAsUp/4pChly/FKzH76xclUa
         G3+oz/tyfzsRqiVej7sbnDooqTqolu20h8AHl4lSFCJyj2cX5ZPlG9nOuCwqDGwz7uTh
         jqRQ7DbJVI/mSy4qPIBYL+6Z3d2FwyVvUg/4ZztkbsurSUJrDoBDo0SyA1v0cZZAQYbr
         dvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWB1si6F6xMECX8WoiHnq+DdFixzDMJ9BMk51tgeuKM=;
        b=oYrtMlBKyDWuw/RHBUXJcNMjEiNjbRULVrd0qVMS/F6ScB0RSblUNsp/ETzMWuh8ug
         DaI4Oemg9CvtoD8xwJII9QLinp44TInGkwmz/VWtbQgnN8HRb9dl3ajz67eA7o1+rZUh
         x49Fvyn4pcrrcduzMEPLUMCHZ0ewziGeMoK+obbRwyeZr1Vh9v2DNfTOSv46e8UeP2iy
         xIBlG40ZgEWbOAsvN7nJ3bxVuRIURF1E/pL/tAuV8eb1wagwBO+HAVjXvFqhIVT+uE7O
         zLUi5Wfq4U0k7H0HLproHY8Iwd8wLRZNTM/yX3FaXsWYIygkUD9r73IopS+VYNMNvXgX
         Eatg==
X-Gm-Message-State: AFqh2ko856qL4oXvKDexi7AJAvLTUS4s+XwVD3FeV69LKdF1ZF/4DCuw
        Wcw9wNi5eIHBGzr5Q3pfY0dLrvKI/EHxYFw3ZJ4Mmw==
X-Google-Smtp-Source: AMrXdXv8OpPgg+9rc0GG2PDOSHODZOEJk+ev0Sv9kJOBDoYtor1L9DImOGhJytm8QC9boykntWL7HC+yZ3vy40j2ouw=
X-Received: by 2002:a05:6870:6699:b0:15b:b80c:e3bd with SMTP id
 ge25-20020a056870669900b0015bb80ce3bdmr845431oab.273.1674148938162; Thu, 19
 Jan 2023 09:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20230117142737.246446-1-davidgow@google.com>
In-Reply-To: <20230117142737.246446-1-davidgow@google.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 19 Jan 2023 12:22:06 -0500
Message-ID: <CA+GJov5K_3xw3jiu0PzMjRaNn2zzjLvBNZsCjFKKspiH6ty6Ew@mail.gmail.com>
Subject: Re: [RFC PATCH] kunit: Add "hooks" to call into KUnit when it's built
 as a module
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Sadiya Kazi <sadiyakazi@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jan 17, 2023 at 9:27 AM David Gow <davidgow@google.com> wrote:
>
> KUnit has several macros and functions intended for use from non-test
> code. These hooks, currently the kunit_get_current_test() and
> kunit_fail_current_test() macros, didn't work when CONFIG_KUNIT=3Dm.
>
> In order to support this case, the required functions and static data
> need to be available unconditionally, even when KUnit itself is not
> built-in. The new 'hooks.c' file is therefore always included, and has
> both the static key required for kunit_get_current_test(), and a
> function pointer to the real implementation of
> __kunit_fail_current_test(), which is populated when the KUnit module is
> loaded.
>
> This can then be extended for future features which require similar
> "hook" behaviour, such as static stubs:
> https://lore.kernel.org/all/20221208061841.2186447-1-davidgow@google.com/
>
> Signed-off-by: David Gow <davidgow@google.com>

Hi David!

After testing and reviewing, this all looks good. Thanks for doing
this. This will certainly be useful when dealing with static stubbing
and fixing up some issues with building KUnit as a module. Just a few
points below.

Otherwise,
Reviewed-by: Rae Moar <rmoar@google.com>

> ---
>
> This is basically a prerequisite for the stub features working when
> KUnit is built as a module, and should nicely make a few other tests
> work then, too.
>
> I'm not 100% sold on the whole "fill in a table of function pointers
> when kunit.ko is loaded" trick: it is basically just working around the
> sensible limitations on depending on modules. I think it should be safe
> here, as the functions/macros all have fallback behaviour when no test
> is running, and this is just another case of that.
>
> Similarly, I'm sure there must be a better way to compile hooks.o in
> when KUNIT=3Dy or KUNIT=3Dm, but the trick of adding it separately as an
> obj-y in the lib/ Makefile, then having an #if IS_ENABLED() check in the
> file is the only one I've been able to come up with using my meagre
> knowledge of Kbuild. Better suggestions welcome!
> ---
>  Documentation/dev-tools/kunit/usage.rst | 14 ++++++--------
>  include/kunit/test-bug.h                | 15 ++++++++-------
>  lib/Makefile                            |  4 ++++
>  lib/kunit/Makefile                      |  3 +++
>  lib/kunit/hooks.c                       | 23 +++++++++++++++++++++++
>  lib/kunit/test.c                        | 10 ++++------
>  6 files changed, 48 insertions(+), 21 deletions(-)
>  create mode 100644 lib/kunit/hooks.c
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-=
tools/kunit/usage.rst
> index 48f8196d5aad..6424493b93cb 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -648,10 +648,9 @@ We can do this via the ``kunit_test`` field in ``tas=
k_struct``, which we can
>  access using the ``kunit_get_current_test()`` function in ``kunit/test-b=
ug.h``.
>
>  ``kunit_get_current_test()`` is safe to call even if KUnit is not enable=
d. If
> -KUnit is not enabled, was built as a module (``CONFIG_KUNIT=3Dm``), or n=
o test is
> -running in the current task, it will return ``NULL``. This compiles down=
 to
> -either a no-op or a static key check, so will have a negligible performa=
nce
> -impact when no test is running.
> +KUnit is not enabled, or if no test is running in the current task, it w=
ill
> +return ``NULL``. This compiles down to either a no-op or a static key ch=
eck,
> +so will have a negligible performance impact when no test is running.
>
>  The example below uses this to implement a "mock" implementation of a fu=
nction, ``foo``:
>
> @@ -726,8 +725,7 @@ structures as shown below:
>         #endif
>
>  ``kunit_fail_current_test()`` is safe to call even if KUnit is not enabl=
ed. If
> -KUnit is not enabled, was built as a module (``CONFIG_KUNIT=3Dm``), or n=
o test is
> -running in the current task, it will do nothing. This compiles down to e=
ither a
> -no-op or a static key check, so will have a negligible performance impac=
t when
> -no test is running.
> +KUnit is not enabled, or if no test is running in the current task, it w=
ill do
> +nothing. This compiles down to either a no-op or a static key check, so =
will
> +have a negligible performance impact when no test is running.
>

Nit: This is unrelated to your changes, but I personally find the
wording of =E2=80=9Cso will have a negligible performance impact when no te=
st
is running=E2=80=9D to be odd. This issue should likely be addressed in a
different patch but could we change this to be =E2=80=9Cso there will be
negligible performance impact when no test is running=E2=80=9D, =E2=80=9Cwh=
ich will
have a negligible performance impact when no test is running", or
something similar.

> diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> index c1b2e14eab64..122f50198903 100644
> --- a/include/kunit/test-bug.h
> +++ b/include/kunit/test-bug.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * KUnit API allowing dynamic analysis tools to interact with KUnit test=
s
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
> @@ -43,20 +43,21 @@ static inline struct kunit *kunit_get_current_test(vo=
id)
>   * kunit_fail_current_test() - If a KUnit test is running, fail it.
>   *
>   * If a KUnit test is running in the current task, mark that test as fai=
led.
> - *
> - * This macro will only work if KUnit is built-in (though the tests
> - * themselves can be modules). Otherwise, it compiles down to nothing.
>   */
>  #define kunit_fail_current_test(fmt, ...) do {                          =
       \
>                 if (static_branch_unlikely(&kunit_running)) {            =
       \
> +                       /* Guaranteed to be non-NULL when kunit_running t=
rue*/  \
>                         __kunit_fail_current_test(__FILE__, __LINE__,    =
       \
>                                                   fmt, ##__VA_ARGS__);   =
       \
>                 }                                                        =
       \
>         } while (0)
>
>
> -extern __printf(3, 4) void __kunit_fail_current_test(const char *file, i=
nt line,
> -                                                   const char *fmt, ...)=
;
> +/* Function pointer defined as a hook in hooks.c, and implemented in tes=
t.c */
> +typedef __printf(3, 4) void kunit_hook_fn_fail_current_test(const char *=
file,
> +                                                           int line,
> +                                                           const char *f=
mt, ...);
> +extern kunit_hook_fn_fail_current_test *__kunit_fail_current_test;
>

At first I was unsure if using typedef is necessary here. However,
after more consideration and inspection. I believe this is likely the
cleanest solution to creating a type for the pointer.

>  #else
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 4d9461bfea42..9031de6ca73c 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -126,6 +126,10 @@ CFLAGS_test_fpu.o +=3D $(FPU_CFLAGS)
>  obj-$(CONFIG_TEST_LIVEPATCH) +=3D livepatch/
>
>  obj-$(CONFIG_KUNIT) +=3D kunit/
> +# Include the KUnit hooks unconditionally. They'll compile to nothing if
> +# CONFIG_KUNIT=3Dn, otherwise will be a small table of static data (stat=
ic key,
> +# function pointers) which need to be built-in even when KUnit is a modu=
le.
> +obj-y +=3D kunit/hooks.o
>

I have to admit I also have limited Kbuild knowledge. However, I found
this to work as an alternative to the above addition:

ifeq ($(CONFIG_KUNIT), m)
obj-y +=3D kunit/hooks.o
else
obj-$(CONFIG_KUNIT) +=3D kunit/hooks.o
endif

To my understanding, this would allow the kunit/hooks file to not be
built-in in the case of CONFIG_KUNIT=3Dn, while ensuring it is built-in
in the case of CONFIG_KUNIT=3Dy or m.

With that said, I would still approve this patch if this wasn=E2=80=99t
changed. There are plenty of other files included in the Makefile
unconditionally. Let me know what you think of the suggestion above.

>  ifeq ($(CONFIG_DEBUG_KOBJECT),y)
>  CFLAGS_kobject.o +=3D -DDEBUG
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 29aff6562b42..deeb46cc879b 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -11,6 +11,9 @@ ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
>  kunit-objs +=3D                          debugfs.o
>  endif
>
> +# KUnit 'hooks' are built-in even when KUnit is built as a module.
> +lib-y +=3D                               hooks.o
> +
>  obj-$(CONFIG_KUNIT_TEST) +=3D            kunit-test.o
>
>  # string-stream-test compiles built-in only.
> diff --git a/lib/kunit/hooks.c b/lib/kunit/hooks.c
> new file mode 100644
> index 000000000000..48189567a774
> --- /dev/null
> +++ b/lib/kunit/hooks.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit 'Hooks' implementation.
> + *
> + * This file contains code / structures which should be built-in even wh=
en
> + * KUnit itself is built as a module.
> + *
> + * Copyright (C) 2022, Google LLC.
> + * Author: David Gow <davidgow@google.com>
> + */
> +
> +/* This file is always built-in, so make sure it's empty if CONFIG_KUNIT=
=3Dn */
> +#if IS_ENABLED(CONFIG_KUNIT)
> +
> +#include <kunit/test-bug.h>
> +
> +DEFINE_STATIC_KEY_FALSE(kunit_running);
> +EXPORT_SYMBOL(kunit_running);
> +
> +/* Function pointers for hooks. */
> +kunit_hook_fn_fail_current_test *__kunit_fail_current_test;
> +EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
> +#endif
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c9ebf975e56b..711fdcce6de8 100644
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
> -void __kunit_fail_current_test(const char *file, int line, const char *f=
mt, ...)
> +void __kunit_fail_current_test_impl(const char *file, int line, const ch=
ar *fmt, ...)
>  {
>         va_list args;
>         int len;
> @@ -53,8 +50,6 @@ void __kunit_fail_current_test(const char *file, int li=
ne, const char *fmt, ...)
>         kunit_err(current->kunit_test, "%s:%d: %s", file, line, buffer);
>         kunit_kfree(current->kunit_test, buffer);
>  }
> -EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
> -#endif
>
>  /*
>   * Enable KUnit tests to run.
> @@ -777,6 +772,9 @@ EXPORT_SYMBOL_GPL(kunit_cleanup);
>
>  static int __init kunit_init(void)
>  {
> +       /* Install the KUnit hook functions. */
> +       __kunit_fail_current_test =3D __kunit_fail_current_test_impl;
> +
>         kunit_debugfs_init();
>  #ifdef CONFIG_MODULES
>         return register_module_notifier(&kunit_mod_nb);
> --
> 2.39.0.314.g84b9a713c41-goog
>

As an aside, I wonder if we could add test coverage for the use of
current->kunit_test.

Now that it works when KUnit is built as a module thanks to this
patch, we could add some tests for the uses of current->kunit_test as
well as kunit_get_current_test() and maybe kunit_fail_current_test()
(although there may be limitations for the latter).

These changes should likely be added in a separate patch.

Thanks again David!

Rae
