Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F19F519DC84
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Apr 2020 19:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgDCRRd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Apr 2020 13:17:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36604 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403976AbgDCRR3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Apr 2020 13:17:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id d202so8575967wmd.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Apr 2020 10:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fiyLiEQCjzFCZ/HdRdxYlu8TdBvUIdiFWSO5Ut+t7qk=;
        b=p8ulibXMca4Td1MRyVPlE10431BT1QNm4P/I2k2DIAewf0Ex0oII+Jf1JWC8RTLH9n
         a8oTjB3Pg4DiUDnzUzfm2OVSoY3e/T6UrwjPTTTgw85Sec5EU2mGizkI5+6Fqv+gLO3F
         xvuGlcomQOl4vm6eYydnFqMgSVXMZ69MOrt5ApbIaFremwguhcWjw66qqiDL1MieIysU
         aLHTfQKpf2jtJiCD5jil3+Vk0qxySEjm/Ip+EWbbmy8b/5RODfV/H0cJzbU317p6DmwP
         yoCHXgo+qVuTgEiniVJZIOwkNSE4i+76cmiAUQWcBCeVfSGnqlf+4mj5wcB/5fgCRpiZ
         b2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fiyLiEQCjzFCZ/HdRdxYlu8TdBvUIdiFWSO5Ut+t7qk=;
        b=d1igmepfFunglSQw9UCJUUhVoEn5BhaX9E1CPg+kpzUC2Qs9IfNUKGdDCvJxYDdmyA
         06ZHLIkWKBd23MrqC6OR8IakOx2+/LiSX6XhkVBxxz570KYce1tBVKJfRrZr0YoFxmKm
         sumMncmLW2206Js8HKQPMTv7GNNCAxpfAEmT+/EFA6lRndC2bGSp5KYlclwO9m/DxlM/
         ofwJiWHyR6No7Lg9n4Vqd4NlD2xdwXXox2KNCEI4AUus9QP9FocQdFguqiU60RrSMiKv
         lr4/xqlKfYtBUO+h0nAFrrbdX7gHvwV/5X67PQ+GNcvUy5jERuuVmHY138oz5/OgIuP3
         Zyag==
X-Gm-Message-State: AGi0PubTD+g+ePgYLOtU/1sM7Cb/+HoYsSn7iw+Q6tY5XKvnTASbVJ+J
        j/sEZ3GPHqcpBg5C3H4p4xMMGWL7MmTQSfyWCgU2eQ==
X-Google-Smtp-Source: APiQypI59kkjNC4NlwfUR28/V2xN/BhC9qJgFAy4BOdpyHK/hqH2SXTJLceymVY+krgQU9XJiLffPL1oLaAXOADSHTA=
X-Received: by 2002:a1c:750f:: with SMTP id o15mr10014390wmc.110.1585934245587;
 Fri, 03 Apr 2020 10:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200402204639.161637-1-trishalfonso@google.com>
 <20200402204639.161637-2-trishalfonso@google.com> <CAAeHK+xFLmnAHPPCrmmqb1of7+cZmvKKPgAMACjArrLChG=xDw@mail.gmail.com>
In-Reply-To: <CAAeHK+xFLmnAHPPCrmmqb1of7+cZmvKKPgAMACjArrLChG=xDw@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Fri, 3 Apr 2020 10:17:14 -0700
Message-ID: <CAKFsvUKZFiiLFGcFykLoXhK1ehc-T=c6EkHf1UNmQRJc=uBQXg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] KUnit: KASAN Integration
To:     Andrey Konovalov <andreyknvl@google.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 3, 2020 at 6:20 AM Andrey Konovalov <andreyknvl@google.com> wro=
te:
>
> On Thu, Apr 2, 2020 at 10:46 PM 'Patricia Alfonso' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > Integrate KASAN into KUnit testing framework.
> >         - Fail tests when KASAN reports an error that is not expected
> >         - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN
> >         tests
> >         - Expected KASAN reports pass tests and are still printed when =
run
> >         without kunit_tool (kunit_tool still bypasses the report due to=
 the
> >         test passing)
> >         - KUnit struct in current task used to keep track of the curren=
t
> >         test from KASAN code
> >
> > Make use of "[PATCH v3 kunit-next 1/2] kunit: generalize
> > kunit_resource API beyond allocated resources" and "[PATCH v3
> > kunit-next 2/2] kunit: add support for named resources" from Alan
> > Maguire [1]
> >         - A named resource is added to a test when a KASAN report is
> >          expected
> >         - This resource contains a struct for kasan_data containing
> >         booleans representing if a KASAN report is expected and if a
> >         KASAN report is found
> >
> > [1] (https://lore.kernel.org/linux-kselftest/1583251361-12748-1-git-sen=
d-email-alan.maguire@oracle.com/T/#t)
> >
> > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > ---
> >  include/kunit/test.h  |  5 ++++
> >  include/linux/kasan.h |  6 +++++
> >  lib/kunit/test.c      | 13 ++++++----
> >  lib/test_kasan.c      | 56 +++++++++++++++++++++++++++++++++++++++----
> >  mm/kasan/report.c     | 30 +++++++++++++++++++++++
> >  5 files changed, 101 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index ac59d18e6bab..1dc3d118f64b 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -225,6 +225,11 @@ struct kunit {
> >         struct list_head resources; /* Protected by lock. */
> >  };
> >
> > +static inline void kunit_set_failure(struct kunit *test)
> > +{
> > +       WRITE_ONCE(test->success, false);
> > +}
> > +
> >  void kunit_init_test(struct kunit *test, const char *name, char *log);
> >
> >  int kunit_run_tests(struct kunit_suite *suite);
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index 5cde9e7c2664..148eaef3e003 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -14,6 +14,12 @@ struct task_struct;
> >  #include <asm/kasan.h>
> >  #include <asm/pgtable.h>
> >
> > +/* kasan_data struct is used in KUnit tests for KASAN expected failure=
s */
> > +struct kunit_kasan_expectation {
> > +       bool report_expected;
> > +       bool report_found;
> > +};
> > +
> >  extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
> >  extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
> >  extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 2cb7c6220a00..030a3281591e 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -10,16 +10,12 @@
> >  #include <linux/kernel.h>
> >  #include <linux/kref.h>
> >  #include <linux/sched/debug.h>
> > +#include <linux/sched.h>
> >
> >  #include "debugfs.h"
> >  #include "string-stream.h"
> >  #include "try-catch-impl.h"
> >
> > -static void kunit_set_failure(struct kunit *test)
> > -{
> > -       WRITE_ONCE(test->success, false);
> > -}
> > -
> >  static void kunit_print_tap_version(void)
> >  {
> >         static bool kunit_has_printed_tap_version;
> > @@ -288,6 +284,10 @@ static void kunit_try_run_case(void *data)
> >         struct kunit_suite *suite =3D ctx->suite;
> >         struct kunit_case *test_case =3D ctx->test_case;
> >
> > +#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
> > +       current->kunit_test =3D test;
> > +#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
> > +
> >         /*
> >          * kunit_run_case_internal may encounter a fatal error; if it d=
oes,
> >          * abort will be called, this thread will exit, and finally the=
 parent
> > @@ -603,6 +603,9 @@ void kunit_cleanup(struct kunit *test)
> >                 spin_unlock(&test->lock);
> >                 kunit_remove_resource(test, res);
> >         }
> > +#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
> > +       current->kunit_test =3D NULL;
> > +#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_cleanup);
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index 3872d250ed2c..dbfa0875ee09 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -23,12 +23,60 @@
> >
> >  #include <asm/page.h>
> >
> > -/*
> > - * Note: test functions are marked noinline so that their names appear=
 in
> > - * reports.
> > +#include <kunit/test.h>
> > +
> > +static struct kunit_resource resource;
> > +static struct kunit_kasan_expectation fail_data;
> > +static bool multishot;
> > +static int orig_panic_on_warn;
> > +
> > +static int kasan_test_init(struct kunit *test)
> > +{
> > +       /*
> > +        * Temporarily enable multi-shot mode and set panic_on_warn=3D0=
.
> > +        * Otherwise, we'd only get a report for the first case.
> > +        */
> > +       multishot =3D kasan_save_enable_multi_shot();
> > +
> > +       orig_panic_on_warn =3D panic_on_warn;
> > +       panic_on_warn =3D 0;
> > +
> > +       return 0;
> > +}
> > +
> > +static void kasan_test_exit(struct kunit *test)
> > +{
> > +       kasan_restore_multi_shot(multishot);
> > +
> > +       /* Restore panic_on_warn */
>
> Nit: no need for this comment, I think it's clear that here we're
> restoring stuff we saved in kasan_test_init().
>
Okay!

> > +       panic_on_warn =3D orig_panic_on_warn;
> > +}
> > +
> > +/**
> > + * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expressi=
on does
> > + * not cause a KASAN error. This uses a KUnit resource named "kasan_da=
ta." Do
> > + * Do not use this name for a KUnit resource outside here.
> > + *
> >   */
> > +#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do { \
> > +       struct kunit_resource *res; \
> > +       struct kunit_kasan_expectation *kasan_data; \
> > +       fail_data.report_expected =3D true; \
> > +       fail_data.report_found =3D false; \
> > +       kunit_add_named_resource(test, \
> > +                               NULL, \
> > +                               NULL, \
> > +                               &resource, \
> > +                               "kasan_data", &fail_data); \
> > +       condition; \
> > +       res =3D kunit_find_named_resource(test, "kasan_data"); \
>
> Is res going to be =3D=3D &resource here? If so, no need to call
> kunit_find_named_resource().
>

You're right. Thanks for the suggestion!

> > +       kasan_data =3D res->data; \
> > +       KUNIT_EXPECT_EQ(test, \
> > +                       kasan_data->report_expected, \
> > +                       kasan_data->report_found); \
>
> Nit: no need to add kasan_data var, just use resource.data->report_expect=
ed.
>

I can probably just use fail_data->report_expected, actually.

> > +       kunit_put_resource(res); \
> > +} while (0)
> >
> > -static noinline void __init kmalloc_oob_right(void)
> >  {
> >         char *ptr;
> >         size_t size =3D 123;
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index 5ef9f24f566b..497477c4b679 100644
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
> > @@ -455,12 +457,35 @@ static bool report_enabled(void)
> >         return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
> >  }
> >
> > +#if IS_ENABLED(CONFIG_KUNIT)
> > +void kasan_update_kunit_status(struct kunit *cur_test)
>
> This isn't used outside of report.c, right? Then _static_ void
> kasan_update_kunit_status().
>

Correct.

> > +{
> > +       struct kunit_resource *resource;
> > +       struct kunit_kasan_expectation *kasan_data;
> > +
> > +       if (!kunit_find_named_resource(cur_test, "kasan_data")) {
> > +               kunit_set_failure(cur_test);
> > +               return;
> > +       }
> > +
> > +       resource =3D kunit_find_named_resource(cur_test, "kasan_data");
>
> Do this before the if above, and then check if (!resource), will save
> you a call to kunit_find_named_resource().
>
> > +       kasan_data =3D resource->data;
> > +       kasan_data->report_found =3D true;
>
> No need for kasan_data var (if it can't be NULL or something), just do:
>
> resource->data->report_found =3D true;
>

The compiler seems to really hate this...
mm/kasan/report.c: In function =E2=80=98kasan_update_kunit_status=E2=80=99:
mm/kasan/report.c:471:16: warning: dereferencing =E2=80=98void *=E2=80=99 p=
ointer
  471 |  resource->data->report_found =3D true;
      |                ^~
mm/kasan/report.c:471:16: error: request for member =E2=80=98report_found=
=E2=80=99 in
something not a structure or union

Do you know how to fix this? I don't think I fully understand the error.

> > +}
> > +#endif /* IS_ENABLED(CONFIG_KUNIT) */
> > +
> >  void kasan_report_invalid_free(void *object, unsigned long ip)
> >  {
> >         unsigned long flags;
> >         u8 tag =3D get_tag(object);
> >
> >         object =3D reset_tag(object);
> > +
> > +#if IS_ENABLED(CONFIG_KUNIT)
> > +       if (current->kunit_test)
> > +               kasan_update_kunit_status(current->kunit_test);
> > +#endif /* IS_ENABLED(CONFIG_KUNIT) */
> > +
> >         start_report(&flags);
> >         pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (voi=
d *)ip);
> >         print_tags(tag, object);
> > @@ -481,6 +506,11 @@ void __kasan_report(unsigned long addr, size_t siz=
e, bool is_write, unsigned lon
> >         if (likely(!report_enabled()))
> >                 return;
> >
> > +#if IS_ENABLED(CONFIG_KUNIT)
> > +       if (current->kunit_test)
> > +               kasan_update_kunit_status(current->kunit_test);
> > +#endif /* IS_ENABLED(CONFIG_KUNIT) */
> > +
> >         disable_trace_on_warning();
> >
> >         tagged_addr =3D (void *)addr;

--=20
Best,
Patricia
