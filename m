Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEB223E34F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Aug 2020 22:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgHFUny (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Aug 2020 16:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFUnx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Aug 2020 16:43:53 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82796C061574
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Aug 2020 13:43:53 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id y30so2105764ooj.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Aug 2020 13:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T6Ysoq0U1zVmxOP6risM52XyEbhlxIpm08Hb7kCGz70=;
        b=Auy2akYzBH3AZup7SZnPiLijTH+mPW/zHHW0rr1XxDtwoGUS4L4D4xMhT+VV/NP2kK
         okYdK6X5WRe3jPL2HdYTKlMkVWwgbI7njMZTuAs/tkzEByjP0yHdXW2kNAutO4PY0cIK
         qN+u8mRlPwOl/KwI7CSnjSkXHrWGDPGjNXe003V2G7Vgf+js9Lz5iqT70sFcbREyAOg9
         MpiGZUwBzC9bXMbfgGpJ7giwkDrI2fpqzx6RMxVRTTE9DZ6aRQMBiAWjijqqaCOQLYwV
         SNeKbHjpQjgF6v21u4yvAVsiIElYCgaV25xyuUjLK01QTy8aIaZTIFyMVy7YfpQhj9pO
         L5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6Ysoq0U1zVmxOP6risM52XyEbhlxIpm08Hb7kCGz70=;
        b=f51jX5l+BrIcSVyL9Uws1V+xJa9fs+IqGKVYf+gxc6goVsRZk7UK300LapyA6odJsD
         I0FYj+2GfeotM+iV1h6WQ8vZ65366kxE45DpHE8oG2UNp4vmh2g8tdZRSUeyXj2ncPc5
         1Vhjvib5N+EuCBbVfR1I1DeJloHrzZm7X/mY0wfmIPttxGJm6DDm4UR2p5fZSNKgvful
         lshu6/xpI5LKJFbROxrzjavbXfvlwwTLD7lh4w4O+e2s/G5yvZmQEjqRmh5LTDn98FPA
         K2MW7yS/NQ9ZWty4fgEqnLoeHMGbRRW+mmFLYpMFxhCYCl88L4qwm4vLo/liXJscPdPw
         3iLg==
X-Gm-Message-State: AOAM530R35tFkhbK/UqifC5LunL/mwL4BKwXb2cni8cEsJJRKvBFHwwb
        2W6mYBERYk/S1QKtHoRCqS9s4BXSlWj0P6p3iiPFMQ==
X-Google-Smtp-Source: ABdhPJye2wLcbFAcX97AxwywoWC014e53L4CA/hfLv/hQn7FiMsxUdVou4ZNW/bOCBr12ua4G88pdrxiroFaHmpmP6I=
X-Received: by 2002:a4a:d04f:: with SMTP id x15mr9627153oor.87.1596746631868;
 Thu, 06 Aug 2020 13:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200806203737.3636830-1-urielguajardojr@gmail.com>
In-Reply-To: <20200806203737.3636830-1-urielguajardojr@gmail.com>
From:   Uriel Guajardo <urielguajardo@google.com>
Date:   Thu, 6 Aug 2020 15:43:39 -0500
Message-ID: <CAG30EedgwNJMCXX6Eo3b8heMa228N4=RLd=BgAQhS8AZ51bU0A@mail.gmail.com>
Subject: Re: [PATCH] kunit: added lockdep support
To:     Uriel Guajardo <urielguajardojr@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 6, 2020 at 3:37 PM Uriel Guajardo <urielguajardojr@gmail.com> wrote:
>
> From: Uriel Guajardo <urielguajardo@google.com>
>
> KUnit tests will now fail if lockdep detects an error during a test
> case.
>
> The idea comes from how lib/locking-selftest [1] checks for lock errors: we
> first if lock debugging is turned on. If not, an error must have
> occurred, so we fail the test and restart lockdep for the next test case.
>
> Like the locking selftests, we also fix possible preemption count
> corruption from lock bugs.
>
> Depends on kunit: support failure from dynamic analysis tools [2]
>
> [1] https://elixir.bootlin.com/linux/v5.7.12/source/lib/locking-selftest.c#L1137
>
> [2] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/
>
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> ---
>  lib/kunit/test.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index d8189d827368..0838ececa005 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -11,6 +11,8 @@
>  #include <linux/kref.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched.h>
> +#include <linux/lockdep.h>
> +#include <linux/debug_locks.h>
>
>  #include "debugfs.h"
>  #include "string-stream.h"
> @@ -22,6 +24,26 @@ void kunit_fail_current_test(void)
>                 kunit_set_failure(current->kunit_test);
>  }
>
> +static inline void kunit_check_locking_bugs(struct kunit *test,
> +                                           unsigned long saved_preempt_count)
> +{
> +       preempt_count_set(saved_preempt_count);
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +       if (softirq_count())
> +               current->softirqs_enabled = 0;
> +       else
> +               current->softirqs_enabled = 1;
> +#endif

I am not entirely sure why lib/locking-selftests enables/disables
softirqs, but I suspect it has to do with the fact that preempt_count
became corrupted, and somehow softirqs became incorrectly
enabled/disabled as a result. The resetting of the preemption count
will undo the enabling/disabling accordingly. Any insight on this
would be appreciated!

> +#if IS_ENABLED(CONFIG_LOCKDEP)
> +       local_irq_disable();
> +       if (!debug_locks) {
> +               kunit_set_failure(test);
> +               lockdep_reset();
> +       }
> +       local_irq_enable();
> +#endif
> +}
> +
>  static void kunit_print_tap_version(void)
>  {
>         static bool kunit_has_printed_tap_version;
> @@ -289,6 +311,7 @@ static void kunit_try_run_case(void *data)
>         struct kunit *test = ctx->test;
>         struct kunit_suite *suite = ctx->suite;
>         struct kunit_case *test_case = ctx->test_case;
> +       unsigned long saved_preempt_count = preempt_count();
>
>         current->kunit_test = test;
>
> @@ -298,7 +321,8 @@ static void kunit_try_run_case(void *data)
>          * thread will resume control and handle any necessary clean up.
>          */
>         kunit_run_case_internal(test, suite, test_case);
> -       /* This line may never be reached. */
> +       /* These lines may never be reached. */
> +       kunit_check_locking_bugs(test, saved_preempt_count);
>         kunit_run_case_cleanup(test, suite);
>  }
>
> --
> 2.28.0.236.gb10cc79966-goog
>
