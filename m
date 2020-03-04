Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7DA178AA3
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 07:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgCDGfP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 01:35:15 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45137 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgCDGfP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 01:35:15 -0500
Received: by mail-qt1-f195.google.com with SMTP id a4so557419qto.12
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Mar 2020 22:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRV4q0RECloAIigH1EtXD7ojzqVokhP4l3P7T2qRJSc=;
        b=vHlVS1j783AEDx9vp9QAk6qirR5NrKJfcrCnKHY9716hTKVBuGENHJ14Y6hDFA4bGt
         L0tAKuz33Ryfvl4ZpwzrDoXROn+IikVwXuMOLgHPpiMJ8u2TCfF321HUj+ShcjgkfTVn
         MySpj96WSVvRzspSZu2MhTqlDDlHIIKuJPpFzcP/wz1oJsTPIV20H/eJfxyZTDMVaGzQ
         1vJ0BHr83tLkSwevxEZPqEIItbiRyPNTTYNi7D7PsbpWXQr8ghN3gqKkwf9eSgsBP0eR
         jCKC2Ccwa+0jtT7gjfyko9MJp91G2awKYC3zWZh1qdbVFYYRDpkeJruFqvXyc6HYjRo9
         Jong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRV4q0RECloAIigH1EtXD7ojzqVokhP4l3P7T2qRJSc=;
        b=M+6X9yrIdO/A8HR+MPdRenwt2/H4a/KK5dFZW+YdsL3QRaANIssZ486zxtNNf8alXa
         jX+R3XGYwlKuI4EXxwD9GwMPt28hN2sU9ZgX+7U+GPSDzq0rXFrKxzzaFIsLjzBz0Uq0
         NmM9sFYggB6IvFHsSxXdRuei3YTA9GdFs7k3F3WguKwXLG2Prx+nBvRMfiGgB9HvAlXZ
         XucARw4UTXcUZe3oLnKY+PubDQgvXaoOPl3A7qNHx9rrOenqp1kYbu5Xzo1q3kJl7bp6
         gWR/ABnv6UKLONdvgI1g9hYAAFP07XgmjpeRZHj0FT5xMGJmdXJq57P+aYu/gvCouM9R
         Zo7Q==
X-Gm-Message-State: ANhLgQ1VacMhiLssY3DBXs9FDbQIuPHt8gQeNSwI3nVDQJ2gDh1NHuC2
        E4+cde8Udv3c4CYGUsnOfrjiW8hRfEBk/jA1raAiew==
X-Google-Smtp-Source: ADFU+vsF14TrN/4+OIYQ5aK+sQ/D/SCWCJvMUWvwob5LzYyU3IfwXfowTvL5LDEUKUK72frvFveq2Q+z58B7AXXDz/8=
X-Received: by 2002:ac8:1846:: with SMTP id n6mr1102349qtk.257.1583303714054;
 Tue, 03 Mar 2020 22:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com> <20200227024301.217042-2-trishalfonso@google.com>
In-Reply-To: <20200227024301.217042-2-trishalfonso@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 4 Mar 2020 07:35:02 +0100
Message-ID: <CACT4Y+avZ5ZdTUPQy7as3PAvdYd0NcSsyUukiumHa_Ah9ZYCFA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
> + *
> + */
> +#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do {  \
> +       test->kasan_report_expected = true;     \
> +       test->kasan_report_found = false; \
> +       condition; \
> +       if (test->kasan_report_found == test->kasan_report_expected) { \
> +               pr_info("%d has passed", __LINE__); \
> +       } else { \
> +               kunit_set_failure(test); \
> +               pr_info("%d has failed", __LINE__); \
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

I think we need to continue and print KASAN report even in this case.
2 reasons:
 - tests don't check validity of printed reports, but at least human
can verify sanity of the report
 - report printing code also needs to be tested, at least that it does
not crash/hang
If we don't print reports, it may look nicer, but will be less useful.

> +               }
> +               kunit_set_failure(current->kasan_kunit_test);
> +       }
> +
