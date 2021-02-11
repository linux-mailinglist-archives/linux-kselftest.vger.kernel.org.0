Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CE1319534
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 22:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBKVeD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 16:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBKVd4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 16:33:56 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2853C0613D6
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 13:33:15 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id t11so4839087pgu.8
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 13:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FXPqEqbnKvLhd+YyHdFIabxatUSTm6MdwrROXvt+SFA=;
        b=EoVs4dvNb4AyeNz5GajovjX3YFuGZANYyKx5f+AeaDxMSSmuZLrGfjx+6XWfT3el3n
         1ZNT/wGQhXPeaFzx0G/u9Ln0ZMr7hJJcvfIQO53gN2VhfSw+RrO4Ka776/3H11/zG9em
         PNjHaMcJU6fa2sNqlZ9tUmySeqC5q3IhMEKUEsdl8R2HIay0ZqGGBoTyCa7hS0mOaTeb
         KbA3pcw/nxL1qA7L7an1g1MzfiibbFvSvKcUztXVD6KtrefIh5NNzVLpSUUvFZZ9sWWo
         iyN9r+zZysZOlNS+7RqE07fwhZHssriTK1qUoMCvPVSxVrjJfr6Lt3FQW8Z2ngHJmdJp
         D9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FXPqEqbnKvLhd+YyHdFIabxatUSTm6MdwrROXvt+SFA=;
        b=Ex0xGacViC/ElH5XI75y1GsSOgaIfyExpEfrwPmzLqLBmlZuD84CnnVv4rsj+MFDNI
         afBcBf2Pgeh2rvITpSlpvTDHXtbYYodcNX4w9nHCb06wj9JtdjHIzDEohzJUPU0FJnqB
         iAXvh+JZzdOagaq+btNg7kW0AXQbzF3H4Uxdiw26CcFDpub6kSGh0zTvSxy27ZBdYnA7
         j0v5BimxydAE8ZGB2ojWaXboygz32mAaZCFMKhwg6J5bqPXtp5sxRFhcvRMFfSlTwxnt
         dcK+8EGX8eP5e9TAOhA70iDRu/Xc9bVHIIuL2RWjbXbUUwwy2UXphhpxrJ5iZA0fVlr2
         Du8A==
X-Gm-Message-State: AOAM532ZkWHzjgV86Civ0qDKH4FZB0/HNZe9fpK2mr88RM7rMReRtk0S
        riR28DX36aAkVGAcXdyZi5ZPlHmnWpVpunhWlRYw5A==
X-Google-Smtp-Source: ABdhPJyfR01aW+qn2BC+2I45hSZN+TXwP5uI/j4Y2GvdizcFRrfykz7B2NpovUkg458Ma030LoCM10pyLNlHi3JDbOg=
X-Received: by 2002:aa7:88c7:0:b029:1d1:4f1f:5fb6 with SMTP id
 k7-20020aa788c70000b02901d14f1f5fb6mr135259pff.14.1613079195119; Thu, 11 Feb
 2021 13:33:15 -0800 (PST)
MIME-Version: 1.0
References: <20210209221443.78812-1-dlatypov@google.com> <20210209221443.78812-2-dlatypov@google.com>
 <CABVgOS=j=23J55jqT=84AhzvBxwZSR-POMOndZxAo1JCyvBLtA@mail.gmail.com>
 <alpine.LRH.2.23.451.2102111524210.10553@localhost> <CAGS_qxpwLbeYiFxL58aKbrU0sgjMq1HCnmoZMhFhXETRSrhV7g@mail.gmail.com>
In-Reply-To: <CAGS_qxpwLbeYiFxL58aKbrU0sgjMq1HCnmoZMhFhXETRSrhV7g@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 11 Feb 2021 13:33:03 -0800
Message-ID: <CAFd5g45kPdrKz-UnMagx1JdcRmLK0uG31m5OELvJKe=pTaND+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: support failure from dynamic analysis tools
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Uriel Guajardo <urielguajardo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 11, 2021 at 12:58 PM Daniel Latypov <dlatypov@google.com> wrote=
:
>
> On Thu, Feb 11, 2021 at 7:40 AM Alan Maguire <alan.maguire@oracle.com> wr=
ote:
> >
> > On Thu, 11 Feb 2021, David Gow wrote:
> >
> > > On Wed, Feb 10, 2021 at 6:14 AM Daniel Latypov <dlatypov@google.com> =
wrote:
> > > >
> > > > From: Uriel Guajardo <urielguajardo@google.com>
> > > >
> > > > Add a kunit_fail_current_test() function to fail the currently runn=
ing
> > > > test, if any, with an error message.
> > > >
> > > > This is largely intended for dynamic analysis tools like UBSAN and =
for
> > > > fakes.
> > > > E.g. say I had a fake ops struct for testing and I wanted my `free`
> > > > function to complain if it was called with an invalid argument, or
> > > > caught a double-free. Most return void and have no normal means of
> > > > signalling failure (e.g. super_operations, iommu_ops, etc.).
> > > >
> > > > Key points:
> > > > * Always update current->kunit_test so anyone can use it.
> > > >   * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated i=
t for
> > > >   CONFIG_KASAN=3Dy
> > > >
> > > > * Create a new header <kunit/test-bug.h> so non-test code doesn't h=
ave
> > > > to include all of <kunit/test.h> (e.g. lib/ubsan.c)
> > > >
> > > > * Forward the file and line number to make it easier to track down
> > > > failures
> > > >
> > > > * Declare the helper function for nice __printf() warnings about mi=
smatched
> > > > format strings even when KUnit is not enabled.
> > > >
> > > > Example output from kunit_fail_current_test("message"):
> > > > [15:19:34] [FAILED] example_simple_test
> > > > [15:19:34]     # example_simple_test: initializing
> > > > [15:19:34]     # example_simple_test: lib/kunit/kunit-example-test.=
c:24: message
> > > > [15:19:34]     not ok 1 - example_simple_test
> > > >
> > > > Co-developed-by: Daniel Latypov <dlatypov@google.com>
> > > > Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> > > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > > ---
> > > >  include/kunit/test-bug.h | 30 ++++++++++++++++++++++++++++++
> > > >  lib/kunit/test.c         | 37 +++++++++++++++++++++++++++++++++---=
-
> > > >  2 files changed, 63 insertions(+), 4 deletions(-)
> > > >  create mode 100644 include/kunit/test-bug.h
> > > >
> > > > diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> > > > new file mode 100644
> > > > index 000000000000..18b1034ec43a
> > > > --- /dev/null
> > > > +++ b/include/kunit/test-bug.h
> > > > @@ -0,0 +1,30 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +/*
> > > > + * KUnit API allowing dynamic analysis tools to interact with KUni=
t tests
> > > > + *
> > > > + * Copyright (C) 2020, Google LLC.
> > > > + * Author: Uriel Guajardo <urielguajardo@google.com>
> > > > + */
> > > > +
> > > > +#ifndef _KUNIT_TEST_BUG_H
> > > > +#define _KUNIT_TEST_BUG_H
> > > > +
> > > > +#define kunit_fail_current_test(fmt, ...) \
> > > > +       __kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_A=
RGS__)
> > > > +
> > > > +#if IS_ENABLED(CONFIG_KUNIT)
> > >
> > > As the kernel test robot has pointed out on the second patch, this
> > > probably should be IS_BUILTIN(), otherwise this won't build if KUnit
> > > is a module, and the code calling it isn't.
> > >
> > > This does mean that things like UBSAN integration won't work if KUnit
> > > is a module, which is a shame.
> > >
> > > (It's worth noting that the KASAN integration worked around this by
> > > only calling inline functions, which would therefore be built-in even
> > > if the rest of KUnit was built as a module. I don't think it's quite
> > > as convenient to do that here, though.)
> > >
> >
> > Right, static inline'ing __kunit_fail_current_test() seems problematic
> > because it calls other exported functions; more below....
> >
> > > > +
> > > > +extern __printf(3, 4) void __kunit_fail_current_test(const char *f=
ile, int line,
> > > > +                                                   const char *fmt=
, ...);
> > > > +
> > > > +#else
> > > > +
> > > > +static __printf(3, 4) void __kunit_fail_current_test(const char *f=
ile, int line,
> > > > +                                                   const char *fmt=
, ...)
> > > > +{
> > > > +}
> > > > +
> > > > +#endif
> > > > +
> > > > +
> > > > +#endif /* _KUNIT_TEST_BUG_H */
> > > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > > index ec9494e914ef..5794059505cf 100644
> > > > --- a/lib/kunit/test.c
> > > > +++ b/lib/kunit/test.c
> > > > @@ -7,6 +7,7 @@
> > > >   */
> > > >
> > > >  #include <kunit/test.h>
> > > > +#include <kunit/test-bug.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/kref.h>
> > > >  #include <linux/sched/debug.h>
> > > > @@ -16,6 +17,38 @@
> > > >  #include "string-stream.h"
> > > >  #include "try-catch-impl.h"
> > > >
> > > > +/*
> > > > + * Fail the current test and print an error message to the log.
> > > > + */
> > > > +void __kunit_fail_current_test(const char *file, int line, const c=
har *fmt, ...)
> > > > +{
> > > > +       va_list args;
> > > > +       int len;
> > > > +       char *buffer;
> > > > +
> > > > +       if (!current->kunit_test)
> > > > +               return;
> > > > +
> > > > +       kunit_set_failure(current->kunit_test);
> > > > +
> >
> > currently kunit_set_failure() is static, but it could be inlined I
> > suspect.
> >
> > > > +       /* kunit_err() only accepts literals, so evaluate the args =
first. */
> > > > +       va_start(args, fmt);
> > > > +       len =3D vsnprintf(NULL, 0, fmt, args) + 1;
> > > > +       va_end(args);
> > > > +
> > > > +       buffer =3D kunit_kmalloc(current->kunit_test, len, GFP_KERN=
EL);
> >
> > kunit_kmalloc()/kunit_kfree() are exported also, but we could probably
> > dodge allocation with a static buffer.  In fact since we end up
> > using an on-stack buffer for logging in kunit_log_append(), it might ma=
ke
>
> Ah, right there's those as well.
>
> I originally had it on the stack, but the fact we use an on-stack
> buffer is why I switched over.
>
> I originally had it as a macro as you do now but liked the __printf()
> annotation to be closer* to the user's code and now down through
> several layers of macros (kunit_fail_current_test =3D> kunit_err =3D>
> kunit_printk =3D> kunit_log =3D> printk).
> And then having it on the stack and then calling into
> kunit_log_append() would (naively) use up 2 *KUNIT_LOG_SIZE stack
> space.
>
> So only a minor concern, and so I like the simpler def using a macro
> given the messiness.
> (But we'd give up the __printf checking when compiling w/o KUnit,
> which is a bit sad)
>
> *E.g. if one misuses kunit_err(), we get this message which is
> understandable, but a bit more noisy than I'd prefer.
> ../include/linux/kern_levels.h:5:18: warning: format =E2=80=98%d=E2=80=99=
 expects
> argument of type =E2=80=98int=E2=80=99, but argument 3 has type =E2=80=98=
char *=E2=80=99 [-Wformat=3D]
>     5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
>       |                  ^~~~~~
> ../include/kunit/test.h:621:10: note: in definition of macro =E2=80=98kun=
it_log=E2=80=99
>   621 |   printk(lvl fmt, ##__VA_ARGS__);    \
>       |          ^~~
> ../include/kunit/test.h:662:2: note: in expansion of macro =E2=80=98kunit=
_printk=E2=80=99
>   662 |  kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~
> ../include/linux/kern_levels.h:11:18: note: in expansion of macro =E2=80=
=98KERN_SOH=E2=80=99
>    11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
>       |                  ^~~~~~~~
> ../include/kunit/test.h:662:15: note: in expansion of macro =E2=80=98KERN=
_ERR=E2=80=99
>   662 |  kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
>       |               ^~~~~~~~
> ../lib/kunit/kunit-example-test.c:30:2: note: in expansion of macro =E2=
=80=98kunit_err=E2=80=99
>    30 |  kunit_err(test, "invalid format string: %d", "hi");
>       |  ^~~~~~~~~
>
>
> > sense to #define __kunit_fail_current_test() instead, i.e.
> >
> > #define __kunit_fail_current_test(file, line, fmt, ...)         \
> >         do {                                                    \
> >                 kunit_set_failure(current->kunit_test);         \
> >                 kunit_err(current->kunit_test, "%s:%d: " fmt,   \
> >                           ##__VA_ARGS__);                       \
> >         } while (0)
> >
> > > > +       if (!buffer)
> > > > +               return;
> > > > +
> > > > +       va_start(args, fmt);
> > > > +       vsnprintf(buffer, len, fmt, args);
> > > > +       va_end(args);
> > > > +
> > > > +       kunit_err(current->kunit_test, "%s:%d: %s", file, line, buf=
fer);
> >
> > To get kunit_err() to work, we'd need to "static inline"
> > kunit_log_append().  It's not a trivial function, but on the plus
> > side it doesn't call any other exported kunit functions AFAICT.
> >
> > So while any of the above suggestions aren't intended to block
> > Daniel's work, does the above seem reasonable for a follow-up
> > series to get UBSAN working with module-based KUnit? Thanks!
>
> Ack, so sounds like we'd want to go ahead with making it only work w/
> CONFIG_KUNIT=3Dy?

I also think this is probably only useful when KUnit is built in.
Although it would be certainly neat to be able to support utilizing
`current->kunit_test` after the fact when KUnit is built as a module,
the problem is that `kunit_test` is only a member of the task_struct
when KUnit is enabled anyway:

https://elixir.bootlin.com/linux/v5.10.15/source/include/linux/sched.h#L123=
4

I think that making `kunit_test` always present in task_struct is
undesirable for many users, and so you then have to be sure that your
kernel you want to load the KUnit module into was built with
CONFIG_KUNIT=3Dm.

Overall, I think it is safer and easier to just require KUnit to be
built in if you want to use `current->kunit_test`. In any case, that
does not take away the ability to use KUnit test modules with it, just
not KUnit itself as a module (CONFIG_KUNIT=3Dy is compatible with tests
built as modules).

> I can simplify it down into a macro since the __printf() bit isn't too
> big of a deal.
> And then it'd let us only depend on kunit_log_append(), making it
> easier to get CONFIG_KUNIT=3Dm working.
>
> Thanks both for digging into this!
> I saw KTR's email and was dreading having to dig into what the
> smallest needed change would be.
>
> >
> > Alan
