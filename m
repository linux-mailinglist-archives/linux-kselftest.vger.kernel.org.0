Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D292411C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Aug 2020 22:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHJUft (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Aug 2020 16:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgHJUfs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Aug 2020 16:35:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E58C061756
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 13:35:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p8so5580378pgn.13
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 13:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bIRISkDDGTFXADmzCt8aRPLFkz3fsf+ngNbn9o21Dg=;
        b=gxn7awJT9+Np4VgP/fswxqwEnVeGmRiyFa3TO18lRa9adR0yPu62PZvlMG3XNvtQwq
         Mkwc1ciKjRqd2sj8jPtyTxcGIUrBr3zdjZMTqVA8n01OTZwofFP5uIr+ln8r8cpy+fou
         2ObEl8jiC0/c29dV2mKFFAVcqNESxUSMyqdudzCSfDT/2xIKbmYMsOx9piZKf4+zICS9
         MJDWAI0xzzeFTn7KKE18RY9Um0AOpWuod7fEkW6uMGLv4rgFzMiV1YDSeL88Vu4DpCsE
         oscChhZyhfFyd1qSD27ql80hQ8Gzl1Di002f59SRbEfHXLIdF1YPLqnjcFCmxK/6/kpF
         rTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bIRISkDDGTFXADmzCt8aRPLFkz3fsf+ngNbn9o21Dg=;
        b=MJ8viqicGXaDmZl6bSeram4c9YrVNCoYyFx86OpM3fCTN8gAUnXF1nrY35AYD48iQp
         P8hjH02cFAyvzkK5nmjEN3cIre/z6rkx8ZxtIOzV2EFiTllXv55YnXS9dWoue1UQ0s5Q
         MtJxLuil22+qw6HlMUfd9f1WZZNx87/TOHK2DCBwNPVcrwKQjvVzOBYxwJODHAweUeeE
         9JDnoC1338s+81LqlnVdv225JiuEfaudkqrtmAWyGBx4uAEPOfZ9jIflaNnM5Ced7R3L
         rPSO6OXIBiJ9VqXQamtr6ujBd3pil1vSX+vy/a1k2gNCYnSR5TfXhq2Gg0nR0EnaHIfn
         J/9g==
X-Gm-Message-State: AOAM532oYXumoKgSUCrmjYC6Ouzyw6eOJ4KZNL4iVFhUi9Dj+mlKQvQX
        XlenVVJnVXrj/XWQN9XNS0sRa9KndpImrd1Tbk3RBg==
X-Google-Smtp-Source: ABdhPJxC2n4rFDhW9fIP7FdW5+L3038lUQLc/+oZMwG9o9fyQysucEzH8szpO8WTNuf6WmOt3EG7Igm7xxmhYHoh9hU=
X-Received: by 2002:a63:5022:: with SMTP id e34mr2477990pgb.384.1597091746854;
 Mon, 10 Aug 2020 13:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200806203737.3636830-1-urielguajardojr@gmail.com> <CAG30EedgwNJMCXX6Eo3b8heMa228N4=RLd=BgAQhS8AZ51bU0A@mail.gmail.com>
In-Reply-To: <CAG30EedgwNJMCXX6Eo3b8heMa228N4=RLd=BgAQhS8AZ51bU0A@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 10 Aug 2020 13:35:35 -0700
Message-ID: <CAFd5g46=zgY_+jawXMS+yTx6MhRGa_4-WVmer-BwoL_c2QPcrg@mail.gmail.com>
Subject: Re: [PATCH] kunit: added lockdep support
To:     Uriel Guajardo <urielguajardo@google.com>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 6, 2020 at 1:43 PM Uriel Guajardo <urielguajardo@google.com> wrote:
>
> On Thu, Aug 6, 2020 at 3:37 PM Uriel Guajardo <urielguajardojr@gmail.com> wrote:
> >
> > From: Uriel Guajardo <urielguajardo@google.com>
> >
> > KUnit tests will now fail if lockdep detects an error during a test
> > case.
> >
> > The idea comes from how lib/locking-selftest [1] checks for lock errors: we
> > first if lock debugging is turned on. If not, an error must have
> > occurred, so we fail the test and restart lockdep for the next test case.
> >
> > Like the locking selftests, we also fix possible preemption count
> > corruption from lock bugs.

Sorry, just noticed: You probably want to send this to some of the
lockdep maintainers or the maintainers of the kselftest for lockdep.

> > Depends on kunit: support failure from dynamic analysis tools [2]
> >
> > [1] https://elixir.bootlin.com/linux/v5.7.12/source/lib/locking-selftest.c#L1137
> >
> > [2] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/
> >
> > Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> > ---
> >  lib/kunit/test.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index d8189d827368..0838ececa005 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -11,6 +11,8 @@
> >  #include <linux/kref.h>
> >  #include <linux/sched/debug.h>
> >  #include <linux/sched.h>
> > +#include <linux/lockdep.h>
> > +#include <linux/debug_locks.h>
> >
> >  #include "debugfs.h"
> >  #include "string-stream.h"
> > @@ -22,6 +24,26 @@ void kunit_fail_current_test(void)
> >                 kunit_set_failure(current->kunit_test);
> >  }
> >
> > +static inline void kunit_check_locking_bugs(struct kunit *test,
> > +                                           unsigned long saved_preempt_count)
> > +{
> > +       preempt_count_set(saved_preempt_count);
> > +#ifdef CONFIG_TRACE_IRQFLAGS
> > +       if (softirq_count())
> > +               current->softirqs_enabled = 0;
> > +       else
> > +               current->softirqs_enabled = 1;
> > +#endif
>
> I am not entirely sure why lib/locking-selftests enables/disables
> softirqs, but I suspect it has to do with the fact that preempt_count
> became corrupted, and somehow softirqs became incorrectly
> enabled/disabled as a result. The resetting of the preemption count
> will undo the enabling/disabling accordingly. Any insight on this
> would be appreciated!
>
> > +#if IS_ENABLED(CONFIG_LOCKDEP)
> > +       local_irq_disable();
> > +       if (!debug_locks) {
> > +               kunit_set_failure(test);
> > +               lockdep_reset();
> > +       }
> > +       local_irq_enable();
> > +#endif
> > +}
> > +
> >  static void kunit_print_tap_version(void)
> >  {
> >         static bool kunit_has_printed_tap_version;
> > @@ -289,6 +311,7 @@ static void kunit_try_run_case(void *data)
> >         struct kunit *test = ctx->test;
> >         struct kunit_suite *suite = ctx->suite;
> >         struct kunit_case *test_case = ctx->test_case;
> > +       unsigned long saved_preempt_count = preempt_count();
> >
> >         current->kunit_test = test;
> >
> > @@ -298,7 +321,8 @@ static void kunit_try_run_case(void *data)
> >          * thread will resume control and handle any necessary clean up.
> >          */
> >         kunit_run_case_internal(test, suite, test_case);
> > -       /* This line may never be reached. */
> > +       /* These lines may never be reached. */
> > +       kunit_check_locking_bugs(test, saved_preempt_count);
> >         kunit_run_case_cleanup(test, suite);
> >  }
> >
> > --
> > 2.28.0.236.gb10cc79966-goog
> >
