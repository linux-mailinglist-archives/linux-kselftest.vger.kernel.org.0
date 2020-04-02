Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 322DA19BF48
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Apr 2020 12:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387937AbgDBKYK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Apr 2020 06:24:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42078 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387709AbgDBKYJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Apr 2020 06:24:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id t9so2721248qto.9
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Apr 2020 03:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0nNqe1kbgvwHQ8vMqd1sXLiQtqiwKluQ6SNG74jh9k=;
        b=snORBZByN/1PzKOcGHeB+Qq6yfL80xMnQisrSefBZKauNDRSths38a6N2ksXbfjN+g
         4AyFEjiDnKsJRJgHD64uXQc8hI3rKisaAvpQpFxEQvCurP+9HmUe8JSOKBjoUb32kbp+
         azR+8Gk2gnN4tp+t/uf9ENZq8rCby5rhRH3wX/a2t0DvOeH6rfbmE5Fxgu3J10JHvHq3
         ZoSqmAw6iiv3T8HsyR1WTWDIAeIH5+v8UPiR610dYUD9zYPdPVk/qrpWV3wmQDSmIxT5
         0HYcrMOXSlsU6UUFR9gPUvAVKWm6Md5UcX0nYqQBq/7oUALAtv9ohrkL0oqES3xCG4iz
         ujRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0nNqe1kbgvwHQ8vMqd1sXLiQtqiwKluQ6SNG74jh9k=;
        b=t/piowozi5Sh+L8m9VNN5/rtb2G/HwZGcg7ns1wjSj1GdyeZKzdzxMiHVtj7rYt4kn
         B/XzRrNcsQG56Bg/ZJPdqH90Nv5PoKRQYi55ZIa4wgjgcbVuj8sUsZP1EtG9IRKkkfFr
         QaZW69YhL526rN1kY1q0idIbB1gUmf0BLW0/exLER1NTB46ZLlCrDmb7noAxYn1OD7kg
         4ZtMGiY3eodJHsY3jwCQwFqKpoiHqUiqIoqBe+ae71M42VxLm/M/Bf1nmOO43waDzfRr
         onkJK7QAo+H0dgLqniUDDLuYIhAXsq10mdYEVjV/nZlNgU0WJ/9OkxpH2tjJuzEc0wox
         ao2w==
X-Gm-Message-State: AGi0PubzTrAQmhiYSajJNA4jX+imts6s+9Z4OyOoTgY6xsDYqlyZ5SPs
        5qaNimfb/CmZ1RmnJnSCEPkRkEgZpxhzMlrZtvvowg==
X-Google-Smtp-Source: APiQypL5RKri1TZ6h0Rr2PMnT1EO+XojT22MU9TFWrkRGKvaSZ+YLzb8fGekAKMlXld9bXTIlDwpV5DObWOCdK947/I=
X-Received: by 2002:aed:25f4:: with SMTP id y49mr2126724qtc.50.1585823047508;
 Thu, 02 Apr 2020 03:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200401180907.202604-1-trishalfonso@google.com> <20200401180907.202604-2-trishalfonso@google.com>
In-Reply-To: <20200401180907.202604-2-trishalfonso@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 2 Apr 2020 12:23:56 +0200
Message-ID: <CACT4Y+ZWQtAZb_D3MsAvO6fFJiH+eYid+ZuFYMRpWDr07Fxgkw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] KUnit: KASAN Integration
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

On Wed, Apr 1, 2020 at 8:09 PM Patricia Alfonso <trishalfonso@google.com> wrote:
>
> Integrate KASAN into KUnit testing framework.
>         - Fail tests when KASAN reports an error that is not expected
>         - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
>         - Expected KASAN reports pass tests and are still printed when run
>         without kunit_tool (kunit_tool still bypasses the report due to the
>         test passing)
>         - KUnit struct in current task used to keep track of the current test
>         from KASAN code
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

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  include/kunit/test.h  |  5 +++++
>  include/linux/kasan.h |  6 ++++++
>  lib/kunit/test.c      | 13 ++++++++-----
>  lib/test_kasan.c      | 37 +++++++++++++++++++++++++++++++++++++
>  mm/kasan/report.c     | 33 +++++++++++++++++++++++++++++++++
>  5 files changed, 89 insertions(+), 5 deletions(-)
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
> index 3872d250ed2c..cf73c6bee81b 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -23,6 +23,43 @@
>
>  #include <asm/page.h>
>
> +#include <kunit/test.h>
> +
> +struct kunit_resource resource;
> +struct kunit_kasan_expectation fail_data;
> +
> +#define KUNIT_SET_KASAN_DATA(test) do { \
> +       fail_data.report_expected = true; \
> +       fail_data.report_found = false; \
> +       kunit_add_named_resource(test, \
> +                               NULL, \
> +                               NULL, \
> +                               &resource, \
> +                               "kasan_data", &fail_data); \
> +} while (0)
> +
> +#define KUNIT_DO_EXPECT_KASAN_FAIL(test, condition) do { \
> +       struct kunit_resource *resource; \
> +       struct kunit_kasan_expectation *kasan_data; \
> +       condition; \
> +       resource = kunit_find_named_resource(test, "kasan_data"); \
> +       kasan_data = resource->data; \
> +       KUNIT_EXPECT_EQ(test, \
> +                       kasan_data->report_expected, \
> +                       kasan_data->report_found); \
> +       kunit_put_resource(resource); \
> +} while (0)
> +
> +/**
> + * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
> + * not cause a KASAN error.
> + *
> + */
> +#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do { \
> +       KUNIT_SET_KASAN_DATA(test); \
> +       KUNIT_DO_EXPECT_KASAN_FAIL(test, condition); \
> +} while (0)
> +
>  /*
>   * Note: test functions are marked noinline so that their names appear in
>   * reports.
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 5ef9f24f566b..87330ef3a99a 100644
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
> @@ -455,12 +457,38 @@ static bool report_enabled(void)
>         return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
>  }
>
> +#if IS_ENABLED(CONFIG_KUNIT)
> +void kasan_update_kunit_status(struct kunit *cur_test)
> +{
> +       struct kunit_resource *resource;
> +       struct kunit_kasan_expectation *kasan_data;
> +
> +       if (kunit_find_named_resource(cur_test, "kasan_data")) {
> +               resource = kunit_find_named_resource(cur_test, "kasan_data");
> +               kasan_data = resource->data;
> +               kasan_data->report_found = true;
> +
> +               if (!kasan_data->report_expected)
> +                       kunit_set_failure(current->kunit_test);
> +               else
> +                       return;
> +       } else
> +               kunit_set_failure(current->kunit_test);
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
> @@ -481,6 +509,11 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
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
> 2.26.0.rc2.310.g2932bb562d-goog
>
