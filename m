Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D023C19C687
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Apr 2020 17:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389598AbgDBPyy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Apr 2020 11:54:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41633 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388677AbgDBPyy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Apr 2020 11:54:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id b1so2022886pgm.8
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Apr 2020 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/lxIYMh8c2UvHtmzN4mf0MmO/F42Wr/0+uCtOsBhVg=;
        b=n3aMvS+Dbbjgr/V8ZSWIKxcQcHLavxm0hYTOmMs/kJiv4h7ND3LlHxsB3DMfmI1D4E
         ToZx2BCwSDrFB6Su5A5hemSaLSgEnMA/kA/qdHPrSJQ3LGoEFp/456vPNcTE4chIaVWf
         yM3/suVdg0PHSY4zsgG4YAJbitHaBcEGgQESKCTD8H0tXpGZha2m5wUMIoV1kh5Y7kx4
         VonNTMQv9PpK9tMAzvNd8A9O1x/F4emQN0K4cvYmxBpSI80PBwV1uP77ulNElJj0nFEx
         nVfkiEFm8tbBZdNRSF22a3esE4vTkOU4yuC3eIRERLU6LwgpzHwAIrH9VEvy/lROc3Oj
         Oxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/lxIYMh8c2UvHtmzN4mf0MmO/F42Wr/0+uCtOsBhVg=;
        b=JEewvaAVp2wzVf9AgwUGPN5OF4LkHX/QrjKfTueUt3/Hx9cauVDz8R/uEtU/ebgT4p
         ph1gnZUd9XgKCfHUWKw91ve8Hv+9MED7nSNAn+3DihP8qKv+KMvoxOGH5kYTFPslQvUM
         +e4uwGVf504sX3ON4K4szcV4rw8RNjPYDHQokO/W9a0XM0eRTz5dDm0DQ8RIGOTxHE3w
         gqD06NEPj0eUTew+8Gkgu8w7h3iLMIEkjSAhOe4M62X39D7byR+1xOL1fRirdYygF3Hu
         eDGKfjeZm9+ppMyBWjgOZLxsHl08XpOleSm/5ZFk2caAUvFe0iFiBs/ZXSkBgsBNkwL2
         BRfg==
X-Gm-Message-State: AGi0Pub/ZDEZph0zi4POFTDtvz4gdxnHZpITNyufWSslR4sevcjWx3ny
        x2JP5aMA6qXR/j5505CTHixP5o+dgF1XpTxDXJTMyA==
X-Google-Smtp-Source: APiQypIK1Y8ru9qo8UR+N5UoAKQMDiYZQnUQ6L59mEIf6WXe9oN4/p+8/zGD2JgdZwGgZYDzNs9lqZw/5j5MiYG/ST8=
X-Received: by 2002:a63:b52:: with SMTP id a18mr3992928pgl.130.1585842892630;
 Thu, 02 Apr 2020 08:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200401180907.202604-1-trishalfonso@google.com> <20200401180907.202604-2-trishalfonso@google.com>
In-Reply-To: <20200401180907.202604-2-trishalfonso@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 2 Apr 2020 17:54:41 +0200
Message-ID: <CAAeHK+zwshOOfnS3QNRcysF+KbTVK6=9yavj18GFkGF1tw0X4g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] KUnit: KASAN Integration
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
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

On Wed, Apr 1, 2020 at 8:09 PM 'Patricia Alfonso' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
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

Any reason to split this macro into two parts? Do we call any of them
separately?

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

Hm, we only call KUNIT_SET_KASAN_DATA() for KASAN tests that we expect
to fail AFAICS. Then we end up calling kunit_set_failure twice, once
here and the other time when we do KUNIT_EXPECT_EQ() in
KUNIT_DO_EXPECT_KASAN_FAIL(). Or maybe there's something I
misunderstand.

> +               else
> +                       return;

Nit: "else return;" can be dropped.

You can actually reorder the code a bit to make it easier to read:

if (!kunit_find_named_resource(cur_test, "kasan_data")) {
  kunit_set_failure(current->kunit_test);
  return;
}
// here comes kasan tests checks





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
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200401180907.202604-2-trishalfonso%40google.com.
