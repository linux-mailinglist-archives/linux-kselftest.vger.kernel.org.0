Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6FF719D775
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Apr 2020 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgDCNUJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Apr 2020 09:20:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34239 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgDCNUI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Apr 2020 09:20:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id v23so566311pfm.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Apr 2020 06:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfmb+P5Q77bDNWXkgWIIUyRAWn0S17E7eS1KF2xpWtg=;
        b=I02BS8ClC+Eia6G259bfuRWMFnKoLF6V1So0D0SKGzE45j5xhj3zoH+g+M9f99kYv1
         LL+G8CP9d6WBlvzAQg3B9tiT1MGfpdEZQwQc0rMxnkvAF3GCl/ZiCAA9+OAjyeV1gVVo
         YdaMpOZeXbmNzNiRpSc7sx8AuQ19YWfGhRSupzk/EEwvptdRPMSsyF7BVAE3gHlznBPC
         28k9u42eOIOq4qGflt4UCy/L4dA7PG0KzcmTCdH7cuHNpLlKwhsX9GSYQUw+GdhFgDPX
         if66H+wlQvH2qGpaPedcvajEJ04bfL4V853afv+Ry952I+S8ZpYLhiBUHXsNzMWx9URm
         fcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfmb+P5Q77bDNWXkgWIIUyRAWn0S17E7eS1KF2xpWtg=;
        b=eN4Kr2ARs+XYMWz6w+bPFzWzlCCbdpvMT436aibpdIJO3LcslbQ8QFoHqHWP2r0OvZ
         DSm3JZt16YXapYYMUF83eKLzEHXUSBMELWhc/yO44hWV1OP/mjyt8AerfOBzMvGcbwh9
         OjUrrpP97qyAZlWXbkBIwr/LK3ZZ6N+8XANYhldHimK2YYQT4NpJJy9VrpNNTDYM47bl
         ggvIwujFlA6oasHpgeCrwAXupVvPdY7EzPrxYFHoaWpvTUpYj3t+apWXUmps6Kuspsjc
         FRAh7YodszbZW3dL8HArDXY9lA/42P495ciW7bUUXaEw9agUoicfypL3obqooQ3rTgfZ
         7jjQ==
X-Gm-Message-State: AGi0PubC2L/iKaQ7ABYLAdn+dTQ9+rc3RrYuBtdox3b9phCPvFT4sRin
        /5NXiQ69jLrzbzb04/J/Ru05dsJQbl39x3Z3L0WgEg==
X-Google-Smtp-Source: APiQypLGSoAl17xitib/olbAc8QI/jpNb7Bhz8gP06w2yk4EkYIgRlCr33mJqkSMxixpr5lbWv32Oi5uQCDpvZakXIU=
X-Received: by 2002:a63:b52:: with SMTP id a18mr8295803pgl.130.1585920006196;
 Fri, 03 Apr 2020 06:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200402204639.161637-1-trishalfonso@google.com> <20200402204639.161637-2-trishalfonso@google.com>
In-Reply-To: <20200402204639.161637-2-trishalfonso@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 3 Apr 2020 15:19:55 +0200
Message-ID: <CAAeHK+xFLmnAHPPCrmmqb1of7+cZmvKKPgAMACjArrLChG=xDw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] KUnit: KASAN Integration
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 2, 2020 at 10:46 PM 'Patricia Alfonso' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Integrate KASAN into KUnit testing framework.
>         - Fail tests when KASAN reports an error that is not expected
>         - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN
>         tests
>         - Expected KASAN reports pass tests and are still printed when run
>         without kunit_tool (kunit_tool still bypasses the report due to the
>         test passing)
>         - KUnit struct in current task used to keep track of the current
>         test from KASAN code
>
> Make use of "[PATCH v3 kunit-next 1/2] kunit: generalize
> kunit_resource API beyond allocated resources" and "[PATCH v3
> kunit-next 2/2] kunit: add support for named resources" from Alan
> Maguire [1]
>         - A named resource is added to a test when a KASAN report is
>          expected
>         - This resource contains a struct for kasan_data containing
>         booleans representing if a KASAN report is expected and if a
>         KASAN report is found
>
> [1] (https://lore.kernel.org/linux-kselftest/1583251361-12748-1-git-send-email-alan.maguire@oracle.com/T/#t)
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> ---
>  include/kunit/test.h  |  5 ++++
>  include/linux/kasan.h |  6 +++++
>  lib/kunit/test.c      | 13 ++++++----
>  lib/test_kasan.c      | 56 +++++++++++++++++++++++++++++++++++++++----
>  mm/kasan/report.c     | 30 +++++++++++++++++++++++
>  5 files changed, 101 insertions(+), 9 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index ac59d18e6bab..1dc3d118f64b 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -225,6 +225,11 @@ struct kunit {
>         struct list_head resources; /* Protected by lock. */
>  };
>
> +static inline void kunit_set_failure(struct kunit *test)
> +{
> +       WRITE_ONCE(test->success, false);
> +}
> +
>  void kunit_init_test(struct kunit *test, const char *name, char *log);
>
>  int kunit_run_tests(struct kunit_suite *suite);
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 5cde9e7c2664..148eaef3e003 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -14,6 +14,12 @@ struct task_struct;
>  #include <asm/kasan.h>
>  #include <asm/pgtable.h>
>
> +/* kasan_data struct is used in KUnit tests for KASAN expected failures */
> +struct kunit_kasan_expectation {
> +       bool report_expected;
> +       bool report_found;
> +};
> +
>  extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
>  extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
>  extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 2cb7c6220a00..030a3281591e 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -10,16 +10,12 @@
>  #include <linux/kernel.h>
>  #include <linux/kref.h>
>  #include <linux/sched/debug.h>
> +#include <linux/sched.h>
>
>  #include "debugfs.h"
>  #include "string-stream.h"
>  #include "try-catch-impl.h"
>
> -static void kunit_set_failure(struct kunit *test)
> -{
> -       WRITE_ONCE(test->success, false);
> -}
> -
>  static void kunit_print_tap_version(void)
>  {
>         static bool kunit_has_printed_tap_version;
> @@ -288,6 +284,10 @@ static void kunit_try_run_case(void *data)
>         struct kunit_suite *suite = ctx->suite;
>         struct kunit_case *test_case = ctx->test_case;
>
> +#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
> +       current->kunit_test = test;
> +#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
> +
>         /*
>          * kunit_run_case_internal may encounter a fatal error; if it does,
>          * abort will be called, this thread will exit, and finally the parent
> @@ -603,6 +603,9 @@ void kunit_cleanup(struct kunit *test)
>                 spin_unlock(&test->lock);
>                 kunit_remove_resource(test, res);
>         }
> +#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
> +       current->kunit_test = NULL;
> +#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
>  }
>  EXPORT_SYMBOL_GPL(kunit_cleanup);
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 3872d250ed2c..dbfa0875ee09 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -23,12 +23,60 @@
>
>  #include <asm/page.h>
>
> -/*
> - * Note: test functions are marked noinline so that their names appear in
> - * reports.
> +#include <kunit/test.h>
> +
> +static struct kunit_resource resource;
> +static struct kunit_kasan_expectation fail_data;
> +static bool multishot;
> +static int orig_panic_on_warn;
> +
> +static int kasan_test_init(struct kunit *test)
> +{
> +       /*
> +        * Temporarily enable multi-shot mode and set panic_on_warn=0.
> +        * Otherwise, we'd only get a report for the first case.
> +        */
> +       multishot = kasan_save_enable_multi_shot();
> +
> +       orig_panic_on_warn = panic_on_warn;
> +       panic_on_warn = 0;
> +
> +       return 0;
> +}
> +
> +static void kasan_test_exit(struct kunit *test)
> +{
> +       kasan_restore_multi_shot(multishot);
> +
> +       /* Restore panic_on_warn */

Nit: no need for this comment, I think it's clear that here we're
restoring stuff we saved in kasan_test_init().

> +       panic_on_warn = orig_panic_on_warn;
> +}
> +
> +/**
> + * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
> + * not cause a KASAN error. This uses a KUnit resource named "kasan_data." Do
> + * Do not use this name for a KUnit resource outside here.
> + *
>   */
> +#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do { \
> +       struct kunit_resource *res; \
> +       struct kunit_kasan_expectation *kasan_data; \
> +       fail_data.report_expected = true; \
> +       fail_data.report_found = false; \
> +       kunit_add_named_resource(test, \
> +                               NULL, \
> +                               NULL, \
> +                               &resource, \
> +                               "kasan_data", &fail_data); \
> +       condition; \
> +       res = kunit_find_named_resource(test, "kasan_data"); \

Is res going to be == &resource here? If so, no need to call
kunit_find_named_resource().

> +       kasan_data = res->data; \
> +       KUNIT_EXPECT_EQ(test, \
> +                       kasan_data->report_expected, \
> +                       kasan_data->report_found); \

Nit: no need to add kasan_data var, just use resource.data->report_expected.

> +       kunit_put_resource(res); \
> +} while (0)
>
> -static noinline void __init kmalloc_oob_right(void)
>  {
>         char *ptr;
>         size_t size = 123;
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 5ef9f24f566b..497477c4b679 100644
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
> @@ -455,12 +457,35 @@ static bool report_enabled(void)
>         return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
>  }
>
> +#if IS_ENABLED(CONFIG_KUNIT)
> +void kasan_update_kunit_status(struct kunit *cur_test)

This isn't used outside of report.c, right? Then _static_ void
kasan_update_kunit_status().

> +{
> +       struct kunit_resource *resource;
> +       struct kunit_kasan_expectation *kasan_data;
> +
> +       if (!kunit_find_named_resource(cur_test, "kasan_data")) {
> +               kunit_set_failure(cur_test);
> +               return;
> +       }
> +
> +       resource = kunit_find_named_resource(cur_test, "kasan_data");

Do this before the if above, and then check if (!resource), will save
you a call to kunit_find_named_resource().

> +       kasan_data = resource->data;
> +       kasan_data->report_found = true;

No need for kasan_data var (if it can't be NULL or something), just do:

resource->data->report_found = true;

> +}
> +#endif /* IS_ENABLED(CONFIG_KUNIT) */
> +
>  void kasan_report_invalid_free(void *object, unsigned long ip)
>  {
>         unsigned long flags;
>         u8 tag = get_tag(object);
>
>         object = reset_tag(object);
> +
> +#if IS_ENABLED(CONFIG_KUNIT)
> +       if (current->kunit_test)
> +               kasan_update_kunit_status(current->kunit_test);
> +#endif /* IS_ENABLED(CONFIG_KUNIT) */
> +
>         start_report(&flags);
>         pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
>         print_tags(tag, object);
> @@ -481,6 +506,11 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
>         if (likely(!report_enabled()))
>                 return;
>
> +#if IS_ENABLED(CONFIG_KUNIT)
> +       if (current->kunit_test)
> +               kasan_update_kunit_status(current->kunit_test);
> +#endif /* IS_ENABLED(CONFIG_KUNIT) */
> +
>         disable_trace_on_warning();
>
>         tagged_addr = (void *)addr;
> --
> 2.26.0.292.g33ef6b2f38-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200402204639.161637-2-trishalfonso%40google.com.
