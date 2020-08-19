Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2CE24A82C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Aug 2020 23:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgHSVIE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 17:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgHSVIC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 17:08:02 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75751C061757
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 14:08:02 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id g3so14101173ybc.3
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 14:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p1h0o70heWIyDfW4WJLhr1C00M5SdMyJMwYyJJrQ7Vs=;
        b=m+b/CR0IOh/JwBLKSCJLtVSX9ATMicrNmGJWSi4OuhpDjrEiAsBSZMjmXRwXWWAYlK
         qoyjMPSRCmNnuV4BUvNreNFwith189w30QLZguYDXdW/ibHsJyCfanoeJrDjDPFSlpPT
         9wVsSf2+Eyaqudw0VJW4P5AR6pE3SsSylUbNDj8cAHlfFwu2KkZchI+qj2oLz67YSw7Z
         3U8kRcAC4LVwivqs8jwJAE6PyYSZumibj/2CjC1LhOHFuJEd0P88R560YGT73gxCJjY0
         bRqczll/6S+vJtE0j8VDkzQzv18aYlwJ+10+OrVFUs0R5MOgYQ5ZXThQ1PWL0B3hP657
         SMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1h0o70heWIyDfW4WJLhr1C00M5SdMyJMwYyJJrQ7Vs=;
        b=K+suZW7eS8egTeaI5kro86BCrqXIdqOhFj7dgN0gdpm4icJ07j0KH4bYN6kpwNMA7d
         15n+Ek6M0ue+6nNyD1jo1wqNtVS8g+i8fHnAlN2FTd37qSC3XeZbYX/MAg1EX9J+LEoT
         CmUyywpFW7VvybswFnzshDXA9jwe9X30gTWcf6PKOnNQlPHVTTbGpgP+Z7roabhNoB9L
         MvlClfmiq13kwn2wEKcHEIEVGIQfTbXL9jGkTtB5BQkrswtDvexxwi2zdkPPIKTjIq2n
         0wc8DRAIapT1M0wGm+jc/B2vozB8BPBt0/tXRnQ9or9SFCMpxerwHYVhTnHs1BLjE8LL
         kerw==
X-Gm-Message-State: AOAM5306JrLEXZTk70U1HoIhbcejbFwKKz6nZnLRX0/BAOQM/Z9iV+MS
        Y0p12EIsN3ZbRV0Y5qYLlO0wZRi/MQd7R8uGvAog/w==
X-Google-Smtp-Source: ABdhPJyMKeg+OZ2QgXsG3vO1p6LdzsP20vRAYZijhzPUIQ3EwAshymohxxa8F6FjoDp+KcJfUT2bV8600kmlrz3xvmc=
X-Received: by 2002:a25:ca50:: with SMTP id a77mr447316ybg.286.1597871281654;
 Wed, 19 Aug 2020 14:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200718005025.440320-1-vitor@massaru.org> <CAFd5g44pr4z4X_E7sFYvYQnKQ22Lqz1a7Oy7Y_yXvJnqGQo9KQ@mail.gmail.com>
In-Reply-To: <CAFd5g44pr4z4X_E7sFYvYQnKQ22Lqz1a7Oy7Y_yXvJnqGQo9KQ@mail.gmail.com>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Wed, 19 Aug 2020 18:07:25 -0300
Message-ID: <CADQ6JjUOaU0e4WXz8Wv06o-3Scev7qNnj73Vsyen5+vJL9F7XA@mail.gmail.com>
Subject: Re: [PATCH v2] lib: kunit: Provides a userspace memory context when
 tests are compiled as module
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 19, 2020 at 6:05 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Jul 17, 2020 at 5:50 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
> >
> > KUnit test cases run on kthreads, and kthreads don't have an
> > adddress space (current->mm is NULL), but processes have mm.
> >
> > The purpose of this patch is to allow to borrow mm to KUnit kthread
> > after userspace is brought up, because we know that there are processes
> > running, at least the process that loaded the module to borrow mm.
> >
> > This allows, for example, tests such as user_copy_kunit, which uses
> > vm_mmap, which needs current->mm.
> >
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
>
> Can you put these together in the same patch series as you had before?
> When I asked you to split the patch up, I was just asking about that
> specific patch within the series. I still think all the patches go
> together.

Sure, I'll do that.

> As for this specific patch, I see one minor issue below; other than
> that, this looks good to me, so:
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>
> > ---
> > v2:
> >     * splitted patch in 3:
> >         - Allows to install and load modules in root filesystem;
> >         - Provides an userspace memory context when tests are compiled
> >           as module;
> >         - Convert test_user_copy to KUnit test;
> >     * added documentation;
> >     * added more explanation;
> >     * tested a pointer;
> >     * released mput();
> > ---
> >  Documentation/dev-tools/kunit/usage.rst | 14 ++++++++++++++
> >  include/kunit/test.h                    | 12 ++++++++++++
> >  lib/kunit/try-catch.c                   | 15 ++++++++++++++-
> >  3 files changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> > index 3c3fe8b5fecc..9f909157be34 100644
> > --- a/Documentation/dev-tools/kunit/usage.rst
> > +++ b/Documentation/dev-tools/kunit/usage.rst
> > @@ -448,6 +448,20 @@ We can now use it to test ``struct eeprom_buffer``:
> >
> >  .. _kunit-on-non-uml:
> >
> > +User-space context
> > +------------------
> > +
> > +I case you need a user-space context, for now this is only possible through
> > +tests compiled as a module. And it will be necessary to use a root filesystem
> > +and uml_utilities.
> > +
> > +Example:
> > +
> > +.. code-block:: bash
> > +
> > +   ./tools/testing/kunit/kunit.py run --timeout=60 --uml_rootfs_dir=.uml_rootfs
> > +
> > +
> >  KUnit on non-UML architectures
> >  ==============================
>
> I think the above documentation change belongs in the other related
> patch where you introduce the --uml_rootfs_dir flag.
>
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 59f3144f009a..ae3337139c65 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -222,6 +222,18 @@ struct kunit {
> >          * protect it with some type of lock.
> >          */
> >         struct list_head resources; /* Protected by lock. */
> > +       /*
> > +        * KUnit test cases run on kthreads, and kthreads don't have an
> > +        * adddress space (current->mm is NULL), but processes have mm.
> > +        *
> > +        * The purpose of this mm_struct is to allow to borrow mm to KUnit kthread
> > +        * after userspace is brought up, because we know that there are processes
> > +        * running, at least the process that loaded the module to borrow mm.
> > +        *
> > +        * This allows, for example, tests such as user_copy_kunit, which uses
> > +        * vm_mmap, which needs current->mm.
> > +        */
> > +       struct mm_struct *mm;
> >  };
> >
> >  void kunit_init_test(struct kunit *test, const char *name, char *log);
> > diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> > index 0dd434e40487..d03e2093985b 100644
> > --- a/lib/kunit/try-catch.c
> > +++ b/lib/kunit/try-catch.c
> > @@ -11,7 +11,8 @@
> >  #include <linux/completion.h>
> >  #include <linux/kernel.h>
> >  #include <linux/kthread.h>
> > -
> > +#include <linux/sched/mm.h>
> > +#include <linux/sched/task.h>
> >  #include "try-catch-impl.h"
> >
> >  void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
> > @@ -24,8 +25,17 @@ EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
> >  static int kunit_generic_run_threadfn_adapter(void *data)
> >  {
> >         struct kunit_try_catch *try_catch = data;
> > +       struct kunit *test = try_catch->test;
> > +
> > +       if (test != NULL && test->mm != NULL)
> > +               kthread_use_mm(test->mm);
> >
> >         try_catch->try(try_catch->context);
> > +       if (test != NULL && test->mm != NULL) {
> > +               kthread_unuse_mm(test->mm);
> > +               mmput(test->mm);
> > +               test->mm = NULL;
> > +       }
> >
> >         complete_and_exit(try_catch->try_completion, 0);
> >  }
> > @@ -65,6 +75,9 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
> >         try_catch->context = context;
> >         try_catch->try_completion = &try_completion;
> >         try_catch->try_result = 0;
> > +
> > +       test->mm = get_task_mm(current);
> > +
> >         task_struct = kthread_run(kunit_generic_run_threadfn_adapter,
> >                                   try_catch,
> >                                   "kunit_try_catch_thread");
> >
> > base-commit: 725aca9585956676687c4cb803e88f770b0df2b2
> > prerequisite-patch-id: 5e5f9a8a05c5680fda1b04c9ab1b95ce91dc88b2
> > prerequisite-patch-id: 4d997940f4a9f303424af9bac412de1af861f9d9
> > prerequisite-patch-id: 582b6d9d28ce4b71628890ec832df6522ca68de0
> > --
> > 2.26.2
> >
