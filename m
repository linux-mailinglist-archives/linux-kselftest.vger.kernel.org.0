Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E589D23F4ED
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Aug 2020 00:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHGWk5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Aug 2020 18:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgHGWk4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Aug 2020 18:40:56 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43521C061757
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Aug 2020 15:40:56 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h16so2825142oti.7
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Aug 2020 15:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6hoLzC3a/GCKNCcphDjG0464om/VNNdDtUdrarqISg=;
        b=XWqmuEOsFgQl/KW1XFg0sh1mkcTZV+lCf9Km2jxbUnibk7lWts4NReaGkR/UvTRGQs
         00p62VfebsT6n/g9aykuVo7Ol+1xtiR2X3LIjW6IrZAwQS1iotmX711XuK0F+QfE33x5
         RsRRNX27kjK7iMwcjyKYiD9OFtxAiHkVmRzGAiUeIB859Z6ClGPUd9TCdM3YzcJ5hTJP
         7z+JtIvoDfHWjZxzIY25FQ4DJSLptHCO/VYQtA+5JG/Y2D+7uRX+W7sYH/YH4qWnDPeN
         /Fh385x9FZpPDPB8B8NO+vdHzncxlyooK5Bk0B0tKLw5qXkvOT+lNEbeqndiijbRcZ0Y
         i3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6hoLzC3a/GCKNCcphDjG0464om/VNNdDtUdrarqISg=;
        b=jjBXSMYOoMtMbKqID0ZnUDwNZRiSQeNKpGiMc8HSft4uZsEKSxorDu5ILZDnEM065a
         wW+wC/0+bkdqpocR9PYgEXvnC4tXcUlg8dCPgKa0r2nVhWgtoh8v1fya7R/Uz+cF7JsE
         HLHatyRywtBrz7SYkKMy3pZNsG1Qh1A1JVQXoov4Wd+Sez3jctMq2X4sbFjA1dLd5CLd
         kR60uIXbCfAvJkHfpzFEE0UuY6wLk4Hs9fyawzGH21W2CARqkM0ozN9EqDq0H6LRAbef
         0xiinVen9AzPdeFjvghO9DlzJlPlSgS8m7W/9VS5HDaJNV+87R2kLJFsMwgASXX9ptBp
         22qA==
X-Gm-Message-State: AOAM5319aY2tnIOk0wAzorGV/NW4bq+TO3VwPNylHVP7OY+C2IiuA1oO
        oNxpyf3WNyyF/TPpVBhOb+0uZMdcTM0LtCgJ2JgMVw==
X-Google-Smtp-Source: ABdhPJxQGhwjuSCAEdjys+3p243krsAjWwtf+0bUT9mMHCQnL2xnaw1KMNO8fbXGJ4JR7p8Xmduk27uytRPHM1UVh6M=
X-Received: by 2002:a05:6830:614:: with SMTP id w20mr2624613oti.283.1596840055222;
 Fri, 07 Aug 2020 15:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200806174326.3577537-1-urielguajardojr@gmail.com> <alpine.LRH.2.21.2008071510580.10525@localhost>
In-Reply-To: <alpine.LRH.2.21.2008071510580.10525@localhost>
From:   Uriel Guajardo <urielguajardo@google.com>
Date:   Fri, 7 Aug 2020 17:40:43 -0500
Message-ID: <CAG30EecJZeBZ-rbZNCGN1o=g6WkrmJv+PCp-JUr-zjMOzndg8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: support failure from dynamic analysis tools
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 7, 2020 at 9:16 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Thu, 6 Aug 2020, Uriel Guajardo wrote:
>
> > Adds an API to allow dynamic analysis tools to fail the currently
> > running KUnit test case.
> >
> > - Always places the kunit test in the task_struct to allow other tools
> > to access the currently running KUnit test.
> >
> > - Creates a new header file to avoid circular dependencies that could be
> > created from the test.h file.
> >
> > Requires KASAN-KUnit integration patch to access the kunit test from
> > task_struct:
> > https://lore.kernel.org/linux-kselftest/20200606040349.246780-2-davidgow@google.com/
> >
> > Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> > ---
> >  include/kunit/test-bug.h | 24 ++++++++++++++++++++++++
> >  include/kunit/test.h     |  1 +
> >  lib/kunit/test.c         | 10 ++++++----
> >  3 files changed, 31 insertions(+), 4 deletions(-)
> >  create mode 100644 include/kunit/test-bug.h
> >
> > diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> > new file mode 100644
> > index 000000000000..283c19ec328f
> > --- /dev/null
> > +++ b/include/kunit/test-bug.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * KUnit API allowing dynamic analysis tools to interact with KUnit tests
> > + *
> > + * Copyright (C) 2020, Google LLC.
> > + * Author: Uriel Guajardo <urielguajardo@google.com>
> > + */
> > +
> > +#ifndef _KUNIT_TEST_BUG_H
> > +#define _KUNIT_TEST_BUG_H
> > +
> > +#if IS_ENABLED(CONFIG_KUNIT)
> > +
> > +extern void kunit_fail_current_test(void);
> > +
> > +#else
> > +
> > +static inline void kunit_fail_current_test(void)
> > +{
> > +}
> > +
> > +#endif
> > +
> > +#endif /* _KUNIT_TEST_BUG_H */
>
> This is great stuff!
>
> One thing I wonder though; how obvious will it be to someone
> running a KUnit test that the cause of the test failure
> is a dynamic analysis tool?  Yes we'll see the dmesg logging
> from that tool but I don't think there's any context _within_
> KUnit that could clarify the source of the failure.  What about
> changing the above API to include a string message that KUnit can
> log, so it can at least identify the source of the failure
> (ubsan, kasan etc).  That would alert anyone looking at KUnit
> output only that there's an external context to examine.
>

Good point! You're right: as it stands, there is no context within
KUnit indicating the source of the failure, and the tool itself is
responsible for logging. This patch is mainly focused on just failing
test cases from outside KUnit.

I'm actually working on sending a follow-up patch soon that supports
the expectation of failures from specific tools. It will introduce
something similar to what you are suggesting, so that KUnit can
properly distinguish between different failures and log them
appropriately. Thanks for the suggestion!




> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 3391f38389f8..81bf43a1abda 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -11,6 +11,7 @@
> >
> >  #include <kunit/assert.h>
> >  #include <kunit/try-catch.h>
> > +#include <kunit/test-bug.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index dcc35fd30d95..d8189d827368 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -16,6 +16,12 @@
> >  #include "string-stream.h"
> >  #include "try-catch-impl.h"
> >
> > +void kunit_fail_current_test(void)
> > +{
> > +     if (current->kunit_test)
> > +             kunit_set_failure(current->kunit_test);
> > +}
> > +
> >  static void kunit_print_tap_version(void)
> >  {
> >       static bool kunit_has_printed_tap_version;
> > @@ -284,9 +290,7 @@ static void kunit_try_run_case(void *data)
> >       struct kunit_suite *suite = ctx->suite;
> >       struct kunit_case *test_case = ctx->test_case;
> >
> > -#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
> >       current->kunit_test = test;
> > -#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
> >
> >       /*
> >        * kunit_run_case_internal may encounter a fatal error; if it does,
> > @@ -602,9 +606,7 @@ void kunit_cleanup(struct kunit *test)
> >               spin_unlock(&test->lock);
> >               kunit_remove_resource(test, res);
> >       }
> > -#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
> >       current->kunit_test = NULL;
> > -#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_cleanup);
> >
> > --
> > 2.28.0.163.g6104cc2f0b6-goog
> >
> >
