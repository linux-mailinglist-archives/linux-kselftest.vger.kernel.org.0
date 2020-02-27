Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E0C172001
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2020 15:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgB0Oj4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 09:39:56 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39609 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731863AbgB0Ojz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 09:39:55 -0500
Received: by mail-vk1-f193.google.com with SMTP id t129so790199vkg.6
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2020 06:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bk5HqSpXBd3ouVZHOHridtfmdB0hMUKbQEQgHMhA+40=;
        b=M9lph58wjCx1dwrMErMqHNBgowGbI85oxcHBJvFUQWqthGku305whpzRrhyi5rS3LE
         MrsMobgoo3kzjt4YnrNAL7TUtHt9SIJUPelQLc/tNeoOGZE9l7U8QJ29JJnTXWKUImBz
         6lsxpLNBfJsVeRyK+heFSETLQtrvFIrZVkfgT7gSZjs+Y0LavcaIBSAkAB+0IY1AeeV2
         2KWLXDql/0PV+Yc/rwdHrEDFkuX0Pns5VmaWE0w0vfJs/W6RlStxqYc9WtVrfMH1wdJb
         ir49/YD/b5r7kqiTIGvvVvBlpnAYOrT/wskIl1XKS8KAAsu9r7sGMDv0aRPv8L0jD6t6
         nDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bk5HqSpXBd3ouVZHOHridtfmdB0hMUKbQEQgHMhA+40=;
        b=cd3OaUY4HG7SIwbpjSUDtXJofE6eLXjtaDs3dwcZlO6OTnZJKYiLHtTkHejopvK1wJ
         P/hXqMczjFoEQnhrgr6UyT13B8xKoN36JiY1pTc59UGT80HZ07x5AfsI1Gwn8MZ8lp//
         mj096nGzEWNPoSgebmncCLbYb2Hm7/vqbIU7otNYc+riTzkJvt9rRONjNRm91Cy4eUAT
         nsAZA5VSJeLThiBq7JPvM6QCvm9r1V6Mm8hy0bwDjsBrUaYSELdDslWQ3v/da/T0MYBX
         SmjLqMheLPAI3tEyzWJrn3IHD14JvQ9Txym4snTGqhjMqSwz0cDq/Ljtp3vOX+MP0S9z
         gLOQ==
X-Gm-Message-State: APjAAAWDfFGtZyyjIlg+scbiA2gTYNN4OUIcLu19FtVZvfOkIqk/Ia68
        QgvC/vrVIrrM3EQ2vAlRGGJaK42v9oTNTz2hGHT2PQ==
X-Google-Smtp-Source: APXvYqwSWXGiTuBSvX4tXowLgXxIvAHC+JGFNgoKTKIYkfvMFurs2isIDVBhgy/KDwnYu8ZhnXxdcGNUWhRGVEaOP5Q=
X-Received: by 2002:a05:6122:1185:: with SMTP id x5mr2810329vkn.38.1582814393627;
 Thu, 27 Feb 2020 06:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com> <20200227024301.217042-2-trishalfonso@google.com>
In-Reply-To: <20200227024301.217042-2-trishalfonso@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Feb 2020 15:39:41 +0100
Message-ID: <CACT4Y+bO7N_80N7NkjOstp=dxGnV1GZUoH3sh6XU90ro0_7M0A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, vincent.guittot@linaro.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 27, 2020 at 3:44 AM 'Patricia Alfonso' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Integrate KASAN into KUnit testing framework.
>  - Fail tests when KASAN reports an error that is not expected
>  - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
>  - KUnit struct added to current task to keep track of the current test
> from KASAN code
>  - Booleans representing if a KASAN report is expected and if a KASAN
>  report is found added to kunit struct
>  - This prints "line# has passed" or "line# has failed"
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> ---
> If anyone has any suggestions on how best to print the failure
> messages, please share!
>
> One issue I have found while testing this is the allocation fails in
> kmalloc_pagealloc_oob_right() sometimes, but not consistently. This
> does cause the test to fail on the KUnit side, as expected, but it
> seems to skip all the tests before this one because the output starts
> with this failure instead of with the first test, kmalloc_oob_right().
>
>  include/kunit/test.h                | 24 ++++++++++++++++++++++++
>  include/linux/sched.h               |  7 ++++++-
>  lib/kunit/test.c                    |  7 ++++++-
>  mm/kasan/report.c                   | 19 +++++++++++++++++++
>  tools/testing/kunit/kunit_kernel.py |  2 +-
>  5 files changed, 56 insertions(+), 3 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 2dfb550c6723..2e388f8937f3 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -21,6 +21,8 @@ struct kunit_resource;
>  typedef int (*kunit_resource_init_t)(struct kunit_resource *, void *);
>  typedef void (*kunit_resource_free_t)(struct kunit_resource *);
>
> +void kunit_set_failure(struct kunit *test);
> +
>  /**
>   * struct kunit_resource - represents a *test managed resource*
>   * @allocation: for the user to store arbitrary data.
> @@ -191,6 +193,9 @@ struct kunit {
>          * protect it with some type of lock.
>          */
>         struct list_head resources; /* Protected by lock. */
> +
> +       bool kasan_report_expected;
> +       bool kasan_report_found;
>  };
>
>  void kunit_init_test(struct kunit *test, const char *name);
> @@ -941,6 +946,25 @@ do {                                                                              \
>                                                 ptr,                           \
>                                                 NULL)
>
> +/**
> + * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
> + * not cause a KASAN error.

Oh, I see, this is not a test, but rather an ASSERT-like macro.
Then maybe we should use it for actual expressions that are supposed
to trigger KASAN errors?

E.g. KUNIT_EXPECT_KASAN_FAIL(test, *(volatile int*)p);


> + *
> + */
> +#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do {  \

s/condition/expression/

> +       test->kasan_report_expected = true;     \

Check that kasan_report_expected is unset. If these are nested things
will break in confusing ways.
Or otherwise we need to restore the previous value at the end.

> +       test->kasan_report_found = false; \
> +       condition; \
> +       if (test->kasan_report_found == test->kasan_report_expected) { \

We know that kasan_report_expected is true here, so we could just said:

if (!test->kasan_report_found)

> +               pr_info("%d has passed", __LINE__); \
> +       } else { \
> +               kunit_set_failure(test); \
> +               pr_info("%d has failed", __LINE__); \

This needs a more readable error.

> +       } \
> +       test->kasan_report_expected = false;    \
> +       test->kasan_report_found = false;       \
> +} while (0)
> +
>  /**
>   * KUNIT_EXPECT_TRUE() - Causes a test failure when the expression is not true.
>   * @test: The test context object.
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 04278493bf15..db23d56061e7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -32,6 +32,8 @@
>  #include <linux/posix-timers.h>
>  #include <linux/rseq.h>
>
> +#include <kunit/test.h>
> +
>  /* task_struct member predeclarations (sorted alphabetically): */
>  struct audit_context;
>  struct backing_dev_info;
> @@ -1178,7 +1180,10 @@ struct task_struct {
>
>  #ifdef CONFIG_KASAN
>         unsigned int                    kasan_depth;
> -#endif
> +#ifdef CONFIG_KUNIT
> +       struct kunit *kasan_kunit_test;

I would assume we will use this for other things as well (failing
tests on LOCKDEP errors, WARNINGs, etc).
So I would call this just kunit_test and make non-dependent on KASAN right away.


> +#endif /* CONFIG_KUNIT */
> +#endif /* CONFIG_KASAN */
>
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>         /* Index of current stored address in ret_stack: */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 9242f932896c..d266b9495c67 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -9,11 +9,12 @@
>  #include <kunit/test.h>
>  #include <linux/kernel.h>
>  #include <linux/sched/debug.h>
> +#include <linux/sched.h>
>
>  #include "string-stream.h"
>  #include "try-catch-impl.h"
>
> -static void kunit_set_failure(struct kunit *test)
> +void kunit_set_failure(struct kunit *test)
>  {
>         WRITE_ONCE(test->success, false);
>  }
> @@ -236,6 +237,10 @@ static void kunit_try_run_case(void *data)
>         struct kunit_suite *suite = ctx->suite;
>         struct kunit_case *test_case = ctx->test_case;
>
> +#ifdef CONFIG_KASAN
> +       current->kasan_kunit_test = test;
> +#endif
> +
>         /*
>          * kunit_run_case_internal may encounter a fatal error; if it does,
>          * abort will be called, this thread will exit, and finally the parent
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 5ef9f24f566b..5554d23799a5 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -32,6 +32,8 @@
>
>  #include <asm/sections.h>
>
> +#include <kunit/test.h>
> +
>  #include "kasan.h"
>  #include "../slab.h"
>
> @@ -461,6 +463,15 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>         u8 tag = get_tag(object);
>
>         object = reset_tag(object);
> +
> +       if (current->kasan_kunit_test) {
> +               if (current->kasan_kunit_test->kasan_report_expected) {
> +                       current->kasan_kunit_test->kasan_report_found = true;
> +                       return;
> +               }
> +               kunit_set_failure(current->kasan_kunit_test);
> +       }
> +
>         start_report(&flags);
>         pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
>         print_tags(tag, object);
> @@ -481,6 +492,14 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
>         if (likely(!report_enabled()))
>                 return;
>
> +       if (current->kasan_kunit_test) {

Strictly saying, this also needs to check in_task().

> +               if (current->kasan_kunit_test->kasan_report_expected) {
> +                       current->kasan_kunit_test->kasan_report_found = true;
> +                       return;
> +               }
> +               kunit_set_failure(current->kasan_kunit_test);
> +       }

This chunk is duplicated 2 times. I think it will be more reasonable
for KASAN code to just notify KUNIT that the error has happened, and
then KUNIT will figure out what it means and what to do.


> +
>         disable_trace_on_warning();
>
>         tagged_addr = (void *)addr;
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index cc5d844ecca1..63eab18a8c34 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -141,7 +141,7 @@ class LinuxSourceTree(object):
>                 return True
>
>         def run_kernel(self, args=[], timeout=None, build_dir=''):
> -               args.extend(['mem=256M'])
> +               args.extend(['mem=256M', 'kasan_multi_shot'])
>                 process = self._ops.linux_bin(args, timeout, build_dir)
>                 with open(os.path.join(build_dir, 'test.log'), 'w') as f:
>                         for line in process.stdout:
> --
> 2.25.0.265.gbab2e86ba0-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200227024301.217042-2-trishalfonso%40google.com.
