Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA78719181F
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Mar 2020 18:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgCXRs4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Mar 2020 13:48:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33631 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgCXRs4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Mar 2020 13:48:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so22674526wrd.0
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Mar 2020 10:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzOHB9g3KOGeLI2ijxAL8EBdgHfC4lrNr/2ltbuc77Y=;
        b=UzoH2I2FTY/43x5y/+X27TaBy4MSRZk6YoxxSda9ZgsFSJJOavyd0PVOCwCFvLH2kf
         1lwZOyArtktkS38izq82lULyNjOEUb5pCzaGZi9jYz6Dkh/tWBdF/g6qTtUI2XxnuTyf
         iUe6lrpgdTpXcKKtWcpg+9BG5GV/WWpLAdCnCQWBKr75baAN+LE+kRIbYidhfHK8WeCJ
         41lcg4rSKPXSVU4OP2wXo/+jKQr098kKuTCdYlR/oZt3norpZYS0TtMex4ykrJt8cVGc
         hylCWZctBTRhgtBuZR8AJDE/EeEtlpAJeTNML1DH+USLxqkQUKu04gazc2WwrWHWkxl8
         Uzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzOHB9g3KOGeLI2ijxAL8EBdgHfC4lrNr/2ltbuc77Y=;
        b=BBtcooaclv7G+06LCg2hYzoMFB5XyJsNk6eHcRzt72qcNJRCMbgO/z4rtuKL6p0V2J
         llZPkGkMN8nzPzluCrGb/HKJOxpTJowk83XWcGPNXHtziZhRPdeOat8NT8xDrlu7zNtW
         s7do6ndn4YG3YyU+RWe14MB66Kkhc+cIOLofdeOVIkXtN3L7+a12KbpIrTRFXCJy9csz
         r5PPdT3SjJcfs0AgiGki5emCMx3BLwuOa9q2K75hi7ho+TV14VokPUnVB5lum0iAMcbp
         Ux8iPCqCOJ0pbv4JBZ1Oga0UctwhV9rNml8VTQZUJo9QNvVQlUwv+yVAi6ok8sDlnx2s
         d3eA==
X-Gm-Message-State: ANhLgQ3tia2yfh9C3HZfzR8RN+fjk0V0xrFLeactoWVeEXMb3kaAiJY5
        qdolLQLbf8xpxPxkZJNqQHgFY2UQ8FV4v3VFZCHuxw==
X-Google-Smtp-Source: ADFU+vv3p6YM06Db/TDNBgWIMF4qoiVsL3C4E4QOO5ns7h/8ij0/+G9aheTpeLDxHlakVbqiaj3sy5cV+cT1D6s5h/s=
X-Received: by 2002:adf:efc9:: with SMTP id i9mr17429674wrp.23.1585072133363;
 Tue, 24 Mar 2020 10:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com>
 <20200319164227.87419-3-trishalfonso@google.com> <alpine.LRH.2.21.2003241640150.30637@localhost>
In-Reply-To: <alpine.LRH.2.21.2003241640150.30637@localhost>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Tue, 24 Mar 2020 10:48:42 -0700
Message-ID: <CAKFsvUKog1m77u+Jx58OHCXuxNNmw=joDZ-0VZ93FT4H7s0zSQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] KUnit: KASAN Integration
To:     Alan Maguire <alan.maguire@oracle.com>
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

On Tue, Mar 24, 2020 at 9:45 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
>
> On Thu, 19 Mar 2020, Patricia Alfonso wrote:
>
> > Integrate KASAN into KUnit testing framework.
> >       - Fail tests when KASAN reports an error that is not expected
> >       - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
> >       - Expected KASAN reports pass tests and are still printed when run
> >       without kunit_tool (kunit_tool still bypasses the report due to the
> >       test passing)
> >       - KUnit struct in current task used to keep track of the current test
> >       from KASAN code
> >
> > Make use of "[RFC PATCH kunit-next 1/2] kunit: generalize
> > kunit_resource API beyond allocated resources" and "[RFC PATCH
> > kunit-next 2/2] kunit: add support for named resources" from Alan
> > Maguire [1]
> >       - A named resource is added to a test when a KASAN report is
> >        expected
> >         - This resource contains a struct for kasan_data containing
> >         booleans representing if a KASAN report is expected and if a
> >         KASAN report is found
> >
> > [1] (https://lore.kernel.org/linux-kselftest/1583251361-12748-1-git-send-email-alan.maguire@oracle.com/T/#t)
> >
> > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> > ---
> >  include/kunit/test.h | 10 ++++++++++
> >  lib/kunit/test.c     | 10 +++++++++-
> >  lib/test_kasan.c     | 37 +++++++++++++++++++++++++++++++++++++
> >  mm/kasan/report.c    | 33 +++++++++++++++++++++++++++++++++
> >  4 files changed, 89 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 70ee581b19cd..2ab265f4f76c 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -19,9 +19,19 @@
> >
> >  struct kunit_resource;
> >
> > +#ifdef CONFIG_KASAN
> > +/* kasan_data struct is used in KUnit tests for KASAN expected failures */
> > +struct kunit_kasan_expectation {
> > +     bool report_expected;
> > +     bool report_found;
> > +};
> > +#endif /* CONFIG_KASAN */
> > +
>
> Above should be moved to mm/kasan/kasan.h I think.
>
> >  typedef int (*kunit_resource_init_t)(struct kunit_resource *, void *);
> >  typedef void (*kunit_resource_free_t)(struct kunit_resource *);
> >
> > +void kunit_set_failure(struct kunit *test);
> > +
>
> Can you explain a bit more about why we need this exported?
> I see where it's used but I'd just like to make sure I
> understand what you're trying to do. Thanks!
>
I need the ability to set a KUnit test failure from outside the KUnit
code so that a test that does not expect a KASAN failure, but reaches
the point in the KASAN code where a report is printed will properly
fail due to this found KASAN failure.

> >  /**
> >   * struct kunit_resource - represents a *test managed resource*
> >   * @data: for the user to store arbitrary data.
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 86a4d9ca0a45..3f927ef45827 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -10,11 +10,12 @@
> >  #include <linux/kernel.h>
> >  #include <linux/kref.h>
> >  #include <linux/sched/debug.h>
> > +#include <linux/sched.h>
> >
> >  #include "string-stream.h"
> >  #include "try-catch-impl.h"
> >
> > -static void kunit_set_failure(struct kunit *test)
> > +void kunit_set_failure(struct kunit *test)
> >  {
> >       WRITE_ONCE(test->success, false);
> >  }
> > @@ -237,6 +238,10 @@ static void kunit_try_run_case(void *data)
> >       struct kunit_suite *suite = ctx->suite;
> >       struct kunit_case *test_case = ctx->test_case;
> >
> > +#if (IS_ENABLED(CONFIG_KASAN) && IS_BUILTIN(CONFIG_KUNIT))
> > +     current->kunit_test = test;
> > +#endif /* IS_ENABLED(CONFIG_KASAN) && IS_BUILTIN(CONFIG_KUNIT) */
> > +
> >       /*
> >        * kunit_run_case_internal may encounter a fatal error; if it does,
> >        * abort will be called, this thread will exit, and finally the parent
> > @@ -590,6 +595,9 @@ void kunit_cleanup(struct kunit *test)
> >               spin_unlock(&test->lock);
> >               kunit_remove_resource(test, res);
> >       }
> > +#if (IS_ENABLED(CONFIG_KASAN) && IS_BUILTIN(CONFIG_KUNIT))
> > +     current->kunit_test = NULL;
>
> As per patch 1, I'd suggest changing here and elsewhere to
> "IS_ENABLED(CONFIG_KUNIT)".
>
"IS_ENABLED(CONFIG_KUNIT)" does not work because KASAN is built-in so
it can't rely on modules so this patchset relies on KUnit being
built-in.

> > +#endif /* IS_ENABLED(CONFIG_KASAN) && IS_BUILTIN(CONFIG_KUNIT)*/
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_cleanup);
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index 3872d250ed2c..cf73c6bee81b 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -23,6 +23,43 @@
> >
> >  #include <asm/page.h>
> >
> > +#include <kunit/test.h>
> > +
> > +struct kunit_resource resource;
> > +struct kunit_kasan_expectation fail_data;
> > +
> > +#define KUNIT_SET_KASAN_DATA(test) do { \
> > +     fail_data.report_expected = true; \
> > +     fail_data.report_found = false; \
> > +     kunit_add_named_resource(test, \
> > +                             NULL, \
> > +                             NULL, \
> > +                             &resource, \
> > +                             "kasan_data", &fail_data); \
> > +} while (0)
> > +
> > +#define KUNIT_DO_EXPECT_KASAN_FAIL(test, condition) do { \
> > +     struct kunit_resource *resource; \
> > +     struct kunit_kasan_expectation *kasan_data; \
> > +     condition; \
> > +     resource = kunit_find_named_resource(test, "kasan_data"); \
> > +     kasan_data = resource->data; \
> > +     KUNIT_EXPECT_EQ(test, \
> > +                     kasan_data->report_expected, \
> > +                     kasan_data->report_found); \
> > +     kunit_put_resource(resource); \
> > +} while (0)
> > +
> > +/**
> > + * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
> > + * not cause a KASAN error.
> > + *
> > + */
> > +#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do { \
> > +     KUNIT_SET_KASAN_DATA(test); \
> > +     KUNIT_DO_EXPECT_KASAN_FAIL(test, condition); \
> > +} while (0)
> > +
> >  /*
> >   * Note: test functions are marked noinline so that their names appear in
> >   * reports.
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index 5ef9f24f566b..ef3d0f54097e 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -32,6 +32,8 @@
> >
> >  #include <asm/sections.h>
> >
> > +#include <kunit/test.h>
> > +
> >  #include "kasan.h"
> >  #include "../slab.h"
> >
> > @@ -455,12 +457,38 @@ static bool report_enabled(void)
> >       return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
> >  }
> >
> > +#if IS_BUILTIN(CONFIG_KUNIT)
>
> again we could tweak this to IS_ENABLED(CONFIG_KUNIT); BTW
> the reason we can compile kunit as a module for these tests
> is the KASAN tests are tristate themselves. If they were
> builtin only it wouldn't be possible to build kunit as
> a module.
>
> > +void kasan_update_kunit_status(struct kunit *cur_test)
> > +{
> > +     struct kunit_resource *resource;
> > +     struct kunit_kasan_expectation *kasan_data;
> > +
> > +     if (kunit_find_named_resource(cur_test, "kasan_data")) {
> > +             resource = kunit_find_named_resource(cur_test, "kasan_data");
> > +             kasan_data = resource->data;
> > +             kasan_data->report_found = true;
> > +
> > +             if (!kasan_data->report_expected)
> > +                     kunit_set_failure(current->kunit_test);
> > +             else
> > +                     return;
> > +     } else
> > +             kunit_set_failure(current->kunit_test);
> > +}
> > +#endif /* IS_BUILTIN(CONFIG_KUNIT) */
> > +
> >  void kasan_report_invalid_free(void *object, unsigned long ip)
> >  {
> >       unsigned long flags;
> >       u8 tag = get_tag(object);
> >
> >       object = reset_tag(object);
> > +
> > +#if IS_BUILTIN(CONFIG_KUNIT)
>
> same comment as above.
>
> > +     if (current->kunit_test)
> > +             kasan_update_kunit_status(current->kunit_test);
> > +#endif /* IS_BUILTIN(CONFIG_KUNIT) */
> > +
> >       start_report(&flags);
> >       pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
> >       print_tags(tag, object);
> > @@ -481,6 +509,11 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
> >       if (likely(!report_enabled()))
> >               return;
> >
> > +#if IS_BUILTIN(CONFIG_KUNIT)
>
> here too.
>
> > +     if (current->kunit_test)
> > +             kasan_update_kunit_status(current->kunit_test);
> > +#endif /* IS_BUILTIN(CONFIG_KUNIT) */
> > +
> >       disable_trace_on_warning();
> >
> >       tagged_addr = (void *)addr;
> > --
> > 2.25.1.696.g5e7596f4ac-goog
> >
> >

-- 
Best,
Patricia
