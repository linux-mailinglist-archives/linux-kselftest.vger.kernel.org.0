Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C60315961
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 23:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhBIWYC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 17:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbhBIWJD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 17:09:03 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F504C08EC31
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Feb 2021 14:08:06 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id y15so4864ilj.11
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Feb 2021 14:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0pHLlu/e9Ji08EtxhI+DoyRZvZ2qnwkgDOAZruINtU=;
        b=pILTqTfPpv+v1vpw08F9CXsSgqLpVJi20yTHeD+DQ/+M+3iw3u3o644wc8NiOs2208
         A3hi8Ec3q/nCg3Cqc1byayrLJ+g/5eqn9WxBqiqAw+moO99Dqwa4SkJk9+1aJeZSNAog
         FJ1sQmWv93mJzMHCWpVa75MvuH0VohrEsLSWj7IhDXZQsQoDHI6uZcLfsK1RJ1rukds3
         ZPbzP1k5by3ejqt1ecKjWZn9Xe8StmzdpMFkkiF2YkRwZS5gbJx2Jr2YSiKLrelhBR5W
         ntahirvEVjqQBv6HYFyJYr1VTwEaDSY6yeGMPOKgeZyJZmjtWr/1EKPo0IZKpqrb1ktU
         /XzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0pHLlu/e9Ji08EtxhI+DoyRZvZ2qnwkgDOAZruINtU=;
        b=Ny76Lem03WcEAkKyyZfDsn+BWAFQkwyWr/Kg18LFu2nGr6MbTs1RuVcd5oHGxxTqEm
         /yMepmCms/3fi50WCkYnlXp85DJJQwcihJojVASerhmBYRFqi8jStE1ELQ9+xpVLz6iH
         oADhMiK1UQZF3UHBhzD/usLfQIfPozwHBjHYNeNFI1WglQN8WKJ5sOhn/9ZhgUVn7loH
         i5j/M9lJzn/dMS7HxaNo7t47ItWIlz9/0jVqNPjSFcXUheItIezx5kMGpLRCXzBeYTKf
         LH60WHAl+m+2jCE0bA3daiduE5AXEKbnhefQAgwg++iH78LyeJPyHGp3miAjBkFMDQOS
         3QJw==
X-Gm-Message-State: AOAM530RPdPJq2h57+Ng36RDiFEgLxi9Bok41+d2O0hCKZIv6F/HWTZp
        Tx2XhYMJJM2SIJ/dnC3y/nUhWN+zbhzXadsP6fLlZA==
X-Google-Smtp-Source: ABdhPJx1Kip0arZ1nRiflMu1rj0oPZ1UXoscVOPm/qCxIiBdZCDKHLxsyL+vJm2sPpZevvBpcYwKguMHBOSfaT1Op3Y=
X-Received: by 2002:a05:6e02:5c6:: with SMTP id l6mr152127ils.136.1612908485751;
 Tue, 09 Feb 2021 14:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20210205235302.2022784-1-dlatypov@google.com> <20210205235302.2022784-2-dlatypov@google.com>
 <alpine.LRH.2.23.451.2102091717001.1783@localhost>
In-Reply-To: <alpine.LRH.2.23.451.2102091717001.1783@localhost>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 9 Feb 2021 14:07:53 -0800
Message-ID: <CAGS_qxoRt+yibVgVBoMGp+GpVt9TSKuyyk08vfcSyQeTyAgN+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: support failure from dynamic analysis tools
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Uriel Guajardo <urielguajardo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 9, 2021 at 9:26 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Fri, 5 Feb 2021, Daniel Latypov wrote:
>
> > From: Uriel Guajardo <urielguajardo@google.com>
> >
> > Add a kunit_fail_current_test() function to fail the currently running
> > test, if any, with an error message.
> >
> > This is largely intended for dynamic analysis tools like UBSAN and for
> > fakes.
> > E.g. say I had a fake ops struct for testing and I wanted my `free`
> > function to complain if it was called with an invalid argument, or
> > caught a double-free. Most return void and have no normal means of
> > signalling failure (e.g. super_operations, iommu_ops, etc.).
> >
> > Key points:
> > * Always update current->kunit_test so anyone can use it.
> >   * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated it for
> >   CONFIG_KASAN=y
> >
> > * Create a new header <kunit/test-bug.h> so non-test code doesn't have
> > to include all of <kunit/test.h> (e.g. lib/ubsan.c)
> >
> > * Forward the file and line number to make it easier to track down
> > failures
> >
>
> Thanks for doing this!
>
> > * Declare it as a function for nice __printf() warnings about mismatched
> > format strings even when KUnit is not enabled.
> >
>
> One thing I _think_ this assumes is that KUnit is builtin;
> don't we need an

Ah, you're correct.
Also going to rename it to have two _ to match other functions used in
macros like __kunit_test_suites_init.

I had been having some recent issues with getting QEMU to work on my
machine so I hadn't tested it before.
Somehow I've finally fixed it and can now say that it works w/
CONFIG_KUNIT=m after making the change

# modprobe kunit
# modprobe kunit-example-test
[   27.689840]     # Subtest: example
[   27.689994]     1..1
[   27.692337]     # example_simple_test: initializing
[   27.692862]     # example_simple_test:
lib/kunit/kunit-example-test.c:31: example failure message: 42
[   27.693158]     not ok 1 - example_simple_test
[   27.693654] not ok 1 - example



>
> EXPORT_SYMBOL_GPL(_kunit_fail_current_test);
>
> ?
>
> Without it, if an analysis tool (or indeed if KUnit) is built
> as a module, it won't be possible to use this functionality.
>
> > Example output from kunit_fail_current_test("message"):
> > [15:19:34] [FAILED] example_simple_test
> > [15:19:34]     # example_simple_test: initializing
> > [15:19:34]     # example_simple_test: lib/kunit/kunit-example-test.c:24: message
> > [15:19:34]     not ok 1 - example_simple_test
> >
> > Co-developed-by: Daniel Latypov <dlatypov@google.com>
> > Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
> >  include/kunit/test-bug.h | 30 ++++++++++++++++++++++++++++++
> >  lib/kunit/test.c         | 36 ++++++++++++++++++++++++++++++++----
> >  2 files changed, 62 insertions(+), 4 deletions(-)
> >  create mode 100644 include/kunit/test-bug.h
> >
> > diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> > new file mode 100644
> > index 000000000000..4963ed52c2df
> > --- /dev/null
> > +++ b/include/kunit/test-bug.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * KUnit API allowing dynamic analysis tools to interact with KUnit tests
> > + *
> > + * Copyright (C) 2020, Google LLC.
>
> nit; might want to update copyright year.
>
> > + * Author: Uriel Guajardo <urielguajardo@google.com>
> > + */
> > +
> > +#ifndef _KUNIT_TEST_BUG_H
> > +#define _KUNIT_TEST_BUG_H
> > +
> > +#define kunit_fail_current_test(fmt, ...) \
> > +     _kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
> > +
> > +#if IS_ENABLED(CONFIG_KUNIT)
> > +
> > +extern __printf(3, 4) void _kunit_fail_current_test(const char *file, int line,
> > +                                                 const char *fmt, ...);
> > +
> > +#else
> > +
> > +static __printf(3, 4) void _kunit_fail_current_test(const char *file, int line,
> > +                                                 const char *fmt, ...)
> > +{
> > +}
> > +
> > +#endif
> > +
> > +
> > +#endif /* _KUNIT_TEST_BUG_H */
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index ec9494e914ef..7b16aae0ccae 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -7,6 +7,7 @@
> >   */
> >
> >  #include <kunit/test.h>
> > +#include <kunit/test-bug.h>
> >  #include <linux/kernel.h>
> >  #include <linux/kref.h>
> >  #include <linux/sched/debug.h>
> > @@ -16,6 +17,37 @@
> >  #include "string-stream.h"
> >  #include "try-catch-impl.h"
> >
> > +/*
> > + * Fail the current test and print an error message to the log.
> > + */
> > +void _kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
> > +{
> > +     va_list args;
> > +     int len;
> > +     char *buffer;
> > +
> > +     if (!current->kunit_test)
> > +             return;
> > +
> > +     kunit_set_failure(current->kunit_test);
> > +
> > +     /* kunit_err() only accepts literals, so evaluate the args first. */
> > +     va_start(args, fmt);
> > +     len = vsnprintf(NULL, 0, fmt, args) + 1;
> > +     va_end(args);
> > +
> > +     buffer = kunit_kmalloc(current->kunit_test, len, GFP_KERNEL);
> > +     if (!buffer)
> > +             return;
> > +
> > +     va_start(args, fmt);
> > +     vsnprintf(buffer, len, fmt, args);
> > +     va_end(args);
> > +
> > +     kunit_err(current->kunit_test, "%s:%d: %s", file, line, buffer);
> > +     kunit_kfree(current->kunit_test, buffer);
> > +}
> > +
> >  /*
> >   * Append formatted message to log, size of which is limited to
> >   * KUNIT_LOG_SIZE bytes (including null terminating byte).
> > @@ -273,9 +305,7 @@ static void kunit_try_run_case(void *data)
> >       struct kunit_suite *suite = ctx->suite;
> >       struct kunit_case *test_case = ctx->test_case;
> >
> > -#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
> >       current->kunit_test = test;
> > -#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
> >
> >       /*
> >        * kunit_run_case_internal may encounter a fatal error; if it does,
> > @@ -624,9 +654,7 @@ void kunit_cleanup(struct kunit *test)
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
> > 2.30.0.478.g8a0d178c01-goog
> >
> >
