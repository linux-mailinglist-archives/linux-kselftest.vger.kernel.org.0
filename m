Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D521A7ED7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 15:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbgDNNvZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732998AbgDNNvL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 09:51:11 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE0BC061A0C
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 06:51:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nu11so5228597pjb.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqFfkj/oSmruqF3cM8sR0s4wL8mmluh/5CuVwXsrTFM=;
        b=H3wKu80SG2jjOaRyvAbFQFlG7vW4MoTDkKKwj7efiRmUWHxQ8XOHgiLieMiGqCDBvN
         vpNjrWMMjqaM4Y+nr/fyG2XRPWbXrPd+/4dij9J/SW2d32dyUJxDC6KJczuURmhELTMN
         SRjejl8h2JVPaHsWaT4VULt41Ih+fH8BXVHQwiMXl4McNLHP6pDn3mlSM7loj5smeWMb
         W3N6XfgabiHSKetIYmfZ4Fv4HDPPCJKaZ0uV90dGQDkkgceQvEOz36J0MJXHVy+CcdfV
         gLafdq/bOl1PvvEVHR28Fs/W2n0ec6pdHraWnNIVta2KTZmZhiBtGcZrV1jkfCXyMx2K
         bB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqFfkj/oSmruqF3cM8sR0s4wL8mmluh/5CuVwXsrTFM=;
        b=j2q9PtE+23n1weg9FpaRU6E0jria5UXFlGAUjq1GAGmpkThAw2Q6DhdxzyMtKD4o/A
         2/wjoH9GbxYMqvqWTmoO3G/PoHnrnol4+M9YhYSz4Tzn3yODDV1CsseCjwU0GcWj9F2b
         ch35Us15ElyAy+FFUzYKL/ClpC/NOANwoKxQK4TgoeAp+TpMLX6YMgnWi3Up8nL2pZkr
         PXM4pSf1VTyADFxnCMLEBIJEK0M3ESFIGfgFNpHjREc6obW5LwE9YpOE6cGFw/Vi++9F
         ob0X3hcu+K8YDxp4TbBsCG6s/7CjT5Xmj7N8fxzpyVsgAjLoe+ZJxyO0jLgku0oIxg7z
         C9NQ==
X-Gm-Message-State: AGi0PubCw+Ftn7klDc4H5c7LuKAMnVAEHeY0VwOPXoM0TicRZCKvZn/E
        rk4BWYeoAy3O5a31sTfRKucoIH+jhL8GbuhqXvM1Pw==
X-Google-Smtp-Source: APiQypI7sge0JAOCb+8U6KLq2WhyrRr51kd7eWIqTU465ZyN2BI023Nuo4U41FdoJVmdEXR9/OUkwdBbfiIWJbuLKuI=
X-Received: by 2002:a17:90a:9af:: with SMTP id 44mr224966pjo.128.1586872269584;
 Tue, 14 Apr 2020 06:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200414031647.124664-1-davidgow@google.com> <20200414031647.124664-3-davidgow@google.com>
In-Reply-To: <20200414031647.124664-3-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 14 Apr 2020 15:50:58 +0200
Message-ID: <CAAeHK+z8AXQuTAPc20kmR0i7Ny1LU1ghWrUf6gOAMdSop+NjgA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] KUnit: KASAN Integration
To:     David Gow <davidgow@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
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

On Tue, Apr 14, 2020 at 5:17 AM 'David Gow' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> From: Patricia Alfonso <trishalfonso@google.com>
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
>         - Also make KASAN no-longer panic when panic_on_warn and
>         kasan_multi_shot are enabled (as multi-shot does nothing
>         otherwise)
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
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> ---
>  include/kunit/test.h  |  5 +++++
>  include/linux/kasan.h |  6 ++++++
>  lib/kunit/test.c      | 13 ++++++++-----
>  lib/test_kasan.c      | 44 +++++++++++++++++++++++++++++++++++++++----
>  mm/kasan/report.c     | 34 ++++++++++++++++++++++++++++++++-
>  5 files changed, 92 insertions(+), 10 deletions(-)
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
> index 3872d250ed2c..7b4cb107b387 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -23,12 +23,48 @@
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
> +
> +static int kasan_test_init(struct kunit *test)
> +{
> +       /*
> +        * Temporarily enable multi-shot mode and set panic_on_warn=0.
> +        * Otherwise, we'd only get a report for the first case.
> +        */
> +       multishot = kasan_save_enable_multi_shot();
> +
> +       return 0;
> +}
> +
> +static void kasan_test_exit(struct kunit *test)
> +{
> +       kasan_restore_multi_shot(multishot);
> +}
> +
> +/**
> + * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
> + * not cause a KASAN error. This uses a KUnit resource named "kasan_data." Do
> + * Do not use this name for a KUnit resource outside here.
> + *
>   */
> +#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do { \
> +       fail_data.report_expected = true; \
> +       fail_data.report_found = false; \
> +       kunit_add_named_resource(test, \
> +                               NULL, \
> +                               NULL, \
> +                               &resource, \
> +                               "kasan_data", &fail_data); \
> +       condition; \
> +       KUNIT_EXPECT_EQ(test, \
> +                       fail_data.report_expected, \
> +                       fail_data.report_found); \
> +} while (0)
>
> -static noinline void __init kmalloc_oob_right(void)
>  {
>         char *ptr;
>         size_t size = 123;
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 5ef9f24f566b..a58a9f3b7f2c 100644
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
> @@ -92,7 +94,7 @@ static void end_report(unsigned long *flags)
>         pr_err("==================================================================\n");
>         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>         spin_unlock_irqrestore(&report_lock, *flags);

[...]

> -       if (panic_on_warn)
> +       if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
>                 panic("panic_on_warn set ...\n");

Please move this change into a separate commit.

With that:

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

>         kasan_enable_current();
>  }
> @@ -455,12 +457,37 @@ static bool report_enabled(void)
>         return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
>  }
>
> +#if IS_ENABLED(CONFIG_KUNIT)
> +static void kasan_update_kunit_status(struct kunit *cur_test)
> +{
> +       struct kunit_resource *resource;
> +       struct kunit_kasan_expectation *kasan_data;
> +
> +       resource = kunit_find_named_resource(cur_test, "kasan_data");
> +
> +       if (!resource) {
> +               kunit_set_failure(cur_test);
> +               return;
> +       }
> +
> +       kasan_data = (struct kunit_kasan_expectation *)resource->data;
> +       kasan_data->report_found = true;
> +       kunit_put_resource(resource);
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
> @@ -481,6 +508,11 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
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
> 2.26.0.110.g2183baf09c-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200414031647.124664-3-davidgow%40google.com.
