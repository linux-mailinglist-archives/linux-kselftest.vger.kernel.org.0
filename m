Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2F3194CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 22:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhBKU7Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 15:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBKU7X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 15:59:23 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB24C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 12:58:43 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id m17so7167713ioy.4
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 12:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=elQYs+CRXIUFdDZB9CGMtfOprXMD+hm3lRs8yHOI0LA=;
        b=okWuQ3wA1SEGnMAhPUpBmEag/3+8gkpbLKpSw3cSONQDEP5aFC3EA1MOtaaZ/THUyt
         IjUZuniBofMCvYCpy9tCzsdHNmQ2rw1/9k9sZhsslkY8yDXwnBSxKF1nfE41WG0/zQIn
         WIh5UHW+XyvpFwPkL/3YYnoV6N/oukqmrFStpIK4Ox2MH8A49WtEpI3FiEnYC+gxyL25
         ADpYrB35N37xQKXfGywu3vGqObItzfthVNkIanlugZYXxMJsAbbnRdA5G+CNYtdOrJNT
         HSf/VTBvTKp2As62gfR1z9qR6qicPg5dGDwSHvQnC7wYSuxz7blL6rsqRlOSxxj0e5bm
         sG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=elQYs+CRXIUFdDZB9CGMtfOprXMD+hm3lRs8yHOI0LA=;
        b=JB/suJKJrpBSjsdKNVOt68cQme7NOJWfnldpkIDF1mocqx6gCG88cJDgPEZT23Dvw3
         /0WI/L3AhKs9amcebRHsrheIEFq+upX+IJV4NpXhEln1Dkts0D7JGTA/25BsBP/jn5LX
         49CblpgvbW7xuIKoNMDj1vjF386SrqG4oNtyPDEp6CoGVbFZvnp+qn/InfrbHPezLft5
         +D8VcN7urkiS4D0twO+Jn1KxCcAHNkOgMmjbCdKdLfrlSWv8wM253U6Q4RqPhwqrufTC
         SkMfuzSeiIjpSgmvMmC3E7AVZbbo/WvTICeGmy8O/ZZj+4+2QXaUiIeeywDJMODORSgZ
         3D9w==
X-Gm-Message-State: AOAM533M3k6vzrJ8z/u4jdMxBfv7qozD1mupEtdW4QT7TZ5U2FdHVLJI
        mJX1RAOpySfKhX83q2CCkKdSYAA6MjKoBnVuqrLO4w==
X-Google-Smtp-Source: ABdhPJytUcaehM/1YkNREeQ0c+ExZL1f5iry/sBr3PPsfl+gsjnHXfn6v9eY7u4X+W18f+/4WkfYKgwat5ww2gBaPPw=
X-Received: by 2002:a6b:f112:: with SMTP id e18mr6772051iog.57.1613077122916;
 Thu, 11 Feb 2021 12:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20210209221443.78812-1-dlatypov@google.com> <20210209221443.78812-2-dlatypov@google.com>
 <CABVgOS=j=23J55jqT=84AhzvBxwZSR-POMOndZxAo1JCyvBLtA@mail.gmail.com> <alpine.LRH.2.23.451.2102111524210.10553@localhost>
In-Reply-To: <alpine.LRH.2.23.451.2102111524210.10553@localhost>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 11 Feb 2021 12:58:31 -0800
Message-ID: <CAGS_qxpwLbeYiFxL58aKbrU0sgjMq1HCnmoZMhFhXETRSrhV7g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: support failure from dynamic analysis tools
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
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

On Thu, Feb 11, 2021 at 7:40 AM Alan Maguire <alan.maguire@oracle.com> wrot=
e:
>
> On Thu, 11 Feb 2021, David Gow wrote:
>
> > On Wed, Feb 10, 2021 at 6:14 AM Daniel Latypov <dlatypov@google.com> wr=
ote:
> > >
> > > From: Uriel Guajardo <urielguajardo@google.com>
> > >
> > > Add a kunit_fail_current_test() function to fail the currently runnin=
g
> > > test, if any, with an error message.
> > >
> > > This is largely intended for dynamic analysis tools like UBSAN and fo=
r
> > > fakes.
> > > E.g. say I had a fake ops struct for testing and I wanted my `free`
> > > function to complain if it was called with an invalid argument, or
> > > caught a double-free. Most return void and have no normal means of
> > > signalling failure (e.g. super_operations, iommu_ops, etc.).
> > >
> > > Key points:
> > > * Always update current->kunit_test so anyone can use it.
> > >   * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated it =
for
> > >   CONFIG_KASAN=3Dy
> > >
> > > * Create a new header <kunit/test-bug.h> so non-test code doesn't hav=
e
> > > to include all of <kunit/test.h> (e.g. lib/ubsan.c)
> > >
> > > * Forward the file and line number to make it easier to track down
> > > failures
> > >
> > > * Declare the helper function for nice __printf() warnings about mism=
atched
> > > format strings even when KUnit is not enabled.
> > >
> > > Example output from kunit_fail_current_test("message"):
> > > [15:19:34] [FAILED] example_simple_test
> > > [15:19:34]     # example_simple_test: initializing
> > > [15:19:34]     # example_simple_test: lib/kunit/kunit-example-test.c:=
24: message
> > > [15:19:34]     not ok 1 - example_simple_test
> > >
> > > Co-developed-by: Daniel Latypov <dlatypov@google.com>
> > > Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > ---
> > >  include/kunit/test-bug.h | 30 ++++++++++++++++++++++++++++++
> > >  lib/kunit/test.c         | 37 +++++++++++++++++++++++++++++++++----
> > >  2 files changed, 63 insertions(+), 4 deletions(-)
> > >  create mode 100644 include/kunit/test-bug.h
> > >
> > > diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> > > new file mode 100644
> > > index 000000000000..18b1034ec43a
> > > --- /dev/null
> > > +++ b/include/kunit/test-bug.h
> > > @@ -0,0 +1,30 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * KUnit API allowing dynamic analysis tools to interact with KUnit =
tests
> > > + *
> > > + * Copyright (C) 2020, Google LLC.
> > > + * Author: Uriel Guajardo <urielguajardo@google.com>
> > > + */
> > > +
> > > +#ifndef _KUNIT_TEST_BUG_H
> > > +#define _KUNIT_TEST_BUG_H
> > > +
> > > +#define kunit_fail_current_test(fmt, ...) \
> > > +       __kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARG=
S__)
> > > +
> > > +#if IS_ENABLED(CONFIG_KUNIT)
> >
> > As the kernel test robot has pointed out on the second patch, this
> > probably should be IS_BUILTIN(), otherwise this won't build if KUnit
> > is a module, and the code calling it isn't.
> >
> > This does mean that things like UBSAN integration won't work if KUnit
> > is a module, which is a shame.
> >
> > (It's worth noting that the KASAN integration worked around this by
> > only calling inline functions, which would therefore be built-in even
> > if the rest of KUnit was built as a module. I don't think it's quite
> > as convenient to do that here, though.)
> >
>
> Right, static inline'ing __kunit_fail_current_test() seems problematic
> because it calls other exported functions; more below....
>
> > > +
> > > +extern __printf(3, 4) void __kunit_fail_current_test(const char *fil=
e, int line,
> > > +                                                   const char *fmt, =
...);
> > > +
> > > +#else
> > > +
> > > +static __printf(3, 4) void __kunit_fail_current_test(const char *fil=
e, int line,
> > > +                                                   const char *fmt, =
...)
> > > +{
> > > +}
> > > +
> > > +#endif
> > > +
> > > +
> > > +#endif /* _KUNIT_TEST_BUG_H */
> > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > index ec9494e914ef..5794059505cf 100644
> > > --- a/lib/kunit/test.c
> > > +++ b/lib/kunit/test.c
> > > @@ -7,6 +7,7 @@
> > >   */
> > >
> > >  #include <kunit/test.h>
> > > +#include <kunit/test-bug.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/kref.h>
> > >  #include <linux/sched/debug.h>
> > > @@ -16,6 +17,38 @@
> > >  #include "string-stream.h"
> > >  #include "try-catch-impl.h"
> > >
> > > +/*
> > > + * Fail the current test and print an error message to the log.
> > > + */
> > > +void __kunit_fail_current_test(const char *file, int line, const cha=
r *fmt, ...)
> > > +{
> > > +       va_list args;
> > > +       int len;
> > > +       char *buffer;
> > > +
> > > +       if (!current->kunit_test)
> > > +               return;
> > > +
> > > +       kunit_set_failure(current->kunit_test);
> > > +
>
> currently kunit_set_failure() is static, but it could be inlined I
> suspect.
>
> > > +       /* kunit_err() only accepts literals, so evaluate the args fi=
rst. */
> > > +       va_start(args, fmt);
> > > +       len =3D vsnprintf(NULL, 0, fmt, args) + 1;
> > > +       va_end(args);
> > > +
> > > +       buffer =3D kunit_kmalloc(current->kunit_test, len, GFP_KERNEL=
);
>
> kunit_kmalloc()/kunit_kfree() are exported also, but we could probably
> dodge allocation with a static buffer.  In fact since we end up
> using an on-stack buffer for logging in kunit_log_append(), it might make

Ah, right there's those as well.

I originally had it on the stack, but the fact we use an on-stack
buffer is why I switched over.

I originally had it as a macro as you do now but liked the __printf()
annotation to be closer* to the user's code and now down through
several layers of macros (kunit_fail_current_test =3D> kunit_err =3D>
kunit_printk =3D> kunit_log =3D> printk).
And then having it on the stack and then calling into
kunit_log_append() would (naively) use up 2 *KUNIT_LOG_SIZE stack
space.

So only a minor concern, and so I like the simpler def using a macro
given the messiness.
(But we'd give up the __printf checking when compiling w/o KUnit,
which is a bit sad)

*E.g. if one misuses kunit_err(), we get this message which is
understandable, but a bit more noisy than I'd prefer.
../include/linux/kern_levels.h:5:18: warning: format =E2=80=98%d=E2=80=99 e=
xpects
argument of type =E2=80=98int=E2=80=99, but argument 3 has type =E2=80=98ch=
ar *=E2=80=99 [-Wformat=3D]
    5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
      |                  ^~~~~~
../include/kunit/test.h:621:10: note: in definition of macro =E2=80=98kunit=
_log=E2=80=99
  621 |   printk(lvl fmt, ##__VA_ARGS__);    \
      |          ^~~
../include/kunit/test.h:662:2: note: in expansion of macro =E2=80=98kunit_p=
rintk=E2=80=99
  662 |  kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~
../include/linux/kern_levels.h:11:18: note: in expansion of macro =E2=80=98=
KERN_SOH=E2=80=99
   11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
      |                  ^~~~~~~~
../include/kunit/test.h:662:15: note: in expansion of macro =E2=80=98KERN_E=
RR=E2=80=99
  662 |  kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
      |               ^~~~~~~~
../lib/kunit/kunit-example-test.c:30:2: note: in expansion of macro =E2=80=
=98kunit_err=E2=80=99
   30 |  kunit_err(test, "invalid format string: %d", "hi");
      |  ^~~~~~~~~


> sense to #define __kunit_fail_current_test() instead, i.e.
>
> #define __kunit_fail_current_test(file, line, fmt, ...)         \
>         do {                                                    \
>                 kunit_set_failure(current->kunit_test);         \
>                 kunit_err(current->kunit_test, "%s:%d: " fmt,   \
>                           ##__VA_ARGS__);                       \
>         } while (0)
>
> > > +       if (!buffer)
> > > +               return;
> > > +
> > > +       va_start(args, fmt);
> > > +       vsnprintf(buffer, len, fmt, args);
> > > +       va_end(args);
> > > +
> > > +       kunit_err(current->kunit_test, "%s:%d: %s", file, line, buffe=
r);
>
> To get kunit_err() to work, we'd need to "static inline"
> kunit_log_append().  It's not a trivial function, but on the plus
> side it doesn't call any other exported kunit functions AFAICT.
>
> So while any of the above suggestions aren't intended to block
> Daniel's work, does the above seem reasonable for a follow-up
> series to get UBSAN working with module-based KUnit? Thanks!

Ack, so sounds like we'd want to go ahead with making it only work w/
CONFIG_KUNIT=3Dy?

I can simplify it down into a macro since the __printf() bit isn't too
big of a deal.
And then it'd let us only depend on kunit_log_append(), making it
easier to get CONFIG_KUNIT=3Dm working.

Thanks both for digging into this!
I saw KTR's email and was dreading having to dig into what the
smallest needed change would be.

>
> Alan
