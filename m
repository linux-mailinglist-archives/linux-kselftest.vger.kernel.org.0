Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52705241232
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Aug 2020 23:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgHJVRz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Aug 2020 17:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgHJVRz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Aug 2020 17:17:55 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA2BC061756
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 14:17:55 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id p137so2188919oop.4
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 14:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GBCeeTPIAs1vqUkzRTPXsfrx2cgCSPgccIBR3gAYiM=;
        b=YwVxAf9ERd4NAgz/iv74mmhNe+RAXg6chRDIyAeaYYRlCmWNGbR8BirN0ldW84u1U6
         cSpF2BdqRyuFhjeWnuigySpcmnXkJianTvoEnYFvC92ziAo86ZXbrzlpUvdIiEXFo8wp
         N6bOwOepauIwC6qjZs0bjOeCNDZV+0wCbn+R+OifZSNds/eh0KSUgNYpKXcYqhd/82Mn
         iNoethuJvVwm86k/hPDhnY2blkQcN5HL+q3qfjpK/AWaYuKQfo8ZTCrP/QqLpmYYZISQ
         e93nJEL83o8hEd6G4P24Rz4sRWb5R1u2yEdmL5R/qLnFl1ewOuabrlFqD0T2rzWMOagi
         habg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GBCeeTPIAs1vqUkzRTPXsfrx2cgCSPgccIBR3gAYiM=;
        b=aP5P/m75HLS4qGSggH91k8iVpDqXuWoyGUQ0FjgOl5lJKKOv8mxWLsXcX4p5SduhFn
         JN9Nka52Frcdw0EI+r2TFW0J5UlsehqPwfn/NPCzBI5kG040TyiuGBu5CkTbC0g2fzE7
         zZ6bNCDwOBK0nMd1cj1cCapTLO/FeEJoONO3aMlGg3hIJQjQY8nurH9CnZoB1zkLNFe8
         QsLpgYgRwwOHlX5shY4ByLyuFaUOMmLXKV3qWsUPVPYaqLXdRBISxR6nqBwAv+I+JvfN
         P/XZw36pq2e/9NTpyHFIEjRDnJd7v2DW4YuXAtdz8BzoefgHko2k8el9Q8II4OJMACtF
         HYwg==
X-Gm-Message-State: AOAM530RVulMhJKn/zJEoat1L3fbTHwS4Y2uyvwWFliABkcCxLuwTbMw
        c0eocZYJULGI1Cc4po/F3mT9fTrNoByXBfoQh7hM8Q==
X-Google-Smtp-Source: ABdhPJxXkpHFF2U46lA8Sr5XEnEOEijV7VeFTbAVhQpK/iA4yeeZSPUsJWxQ2yqfY0fvcMn3EmXFJA8V16fFe5EBNQM=
X-Received: by 2002:a4a:2f4b:: with SMTP id p72mr2448256oop.39.1597094273806;
 Mon, 10 Aug 2020 14:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200806203737.3636830-1-urielguajardojr@gmail.com>
 <CAG30EedgwNJMCXX6Eo3b8heMa228N4=RLd=BgAQhS8AZ51bU0A@mail.gmail.com> <CAFd5g46=zgY_+jawXMS+yTx6MhRGa_4-WVmer-BwoL_c2QPcrg@mail.gmail.com>
In-Reply-To: <CAFd5g46=zgY_+jawXMS+yTx6MhRGa_4-WVmer-BwoL_c2QPcrg@mail.gmail.com>
From:   Uriel Guajardo <urielguajardo@google.com>
Date:   Mon, 10 Aug 2020 16:17:42 -0500
Message-ID: <CAG30EefjgzOMePHA2tQ-UmAw5_mnLDoS2hJH6z3nidNC8n8+Lg@mail.gmail.com>
Subject: Re: [PATCH] kunit: added lockdep support
To:     Brendan Higgins <brendanhiggins@google.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 10, 2020 at 3:35 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Thu, Aug 6, 2020 at 1:43 PM Uriel Guajardo <urielguajardo@google.com> wrote:
> >
> > On Thu, Aug 6, 2020 at 3:37 PM Uriel Guajardo <urielguajardojr@gmail.com> wrote:
> > >
> > > From: Uriel Guajardo <urielguajardo@google.com>
> > >
> > > KUnit tests will now fail if lockdep detects an error during a test
> > > case.
> > >
> > > The idea comes from how lib/locking-selftest [1] checks for lock errors: we
> > > first if lock debugging is turned on. If not, an error must have
> > > occurred, so we fail the test and restart lockdep for the next test case.
> > >
> > > Like the locking selftests, we also fix possible preemption count
> > > corruption from lock bugs.
>
> Sorry, just noticed: You probably want to send this to some of the
> lockdep maintainers or the maintainers of the kselftest for lockdep.
>

Thanks for the reminder. CC'ed lockdep maintainers.


> > > Depends on kunit: support failure from dynamic analysis tools [2]
> > >
> > > [1] https://elixir.bootlin.com/linux/v5.7.12/source/lib/locking-selftest.c#L1137
> > >
> > > [2] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/
> > >
> > > Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> > > ---
> > >  lib/kunit/test.c | 26 +++++++++++++++++++++++++-
> > >  1 file changed, 25 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > index d8189d827368..0838ececa005 100644
> > > --- a/lib/kunit/test.c
> > > +++ b/lib/kunit/test.c
> > > @@ -11,6 +11,8 @@
> > >  #include <linux/kref.h>
> > >  #include <linux/sched/debug.h>
> > >  #include <linux/sched.h>
> > > +#include <linux/lockdep.h>
> > > +#include <linux/debug_locks.h>
> > >
> > >  #include "debugfs.h"
> > >  #include "string-stream.h"
> > > @@ -22,6 +24,26 @@ void kunit_fail_current_test(void)
> > >                 kunit_set_failure(current->kunit_test);
> > >  }
> > >
> > > +static inline void kunit_check_locking_bugs(struct kunit *test,
> > > +                                           unsigned long saved_preempt_count)
> > > +{
> > > +       preempt_count_set(saved_preempt_count);
> > > +#ifdef CONFIG_TRACE_IRQFLAGS
> > > +       if (softirq_count())
> > > +               current->softirqs_enabled = 0;
> > > +       else
> > > +               current->softirqs_enabled = 1;
> > > +#endif
> >
> > I am not entirely sure why lib/locking-selftests enables/disables
> > softirqs, but I suspect it has to do with the fact that preempt_count
> > became corrupted, and somehow softirqs became incorrectly
> > enabled/disabled as a result. The resetting of the preemption count
> > will undo the enabling/disabling accordingly. Any insight on this
> > would be appreciated!
> >
> > > +#if IS_ENABLED(CONFIG_LOCKDEP)
> > > +       local_irq_disable();
> > > +       if (!debug_locks) {
> > > +               kunit_set_failure(test);
> > > +               lockdep_reset();
> > > +       }
> > > +       local_irq_enable();
> > > +#endif
> > > +}
> > > +
> > >  static void kunit_print_tap_version(void)
> > >  {
> > >         static bool kunit_has_printed_tap_version;
> > > @@ -289,6 +311,7 @@ static void kunit_try_run_case(void *data)
> > >         struct kunit *test = ctx->test;
> > >         struct kunit_suite *suite = ctx->suite;
> > >         struct kunit_case *test_case = ctx->test_case;
> > > +       unsigned long saved_preempt_count = preempt_count();
> > >
> > >         current->kunit_test = test;
> > >
> > > @@ -298,7 +321,8 @@ static void kunit_try_run_case(void *data)
> > >          * thread will resume control and handle any necessary clean up.
> > >          */
> > >         kunit_run_case_internal(test, suite, test_case);
> > > -       /* This line may never be reached. */
> > > +       /* These lines may never be reached. */
> > > +       kunit_check_locking_bugs(test, saved_preempt_count);
> > >         kunit_run_case_cleanup(test, suite);
> > >  }
> > >
> > > --
> > > 2.28.0.236.gb10cc79966-goog
> > >
