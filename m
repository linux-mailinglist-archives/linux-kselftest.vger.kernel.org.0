Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 896761635BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2020 23:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgBRWEH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Feb 2020 17:04:07 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38153 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgBRWEH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Feb 2020 17:04:07 -0500
Received: by mail-pj1-f66.google.com with SMTP id j17so1597798pjz.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2020 14:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KjiEVUVH3LhEUahEgPDeCz6/w7FXRv21B6oRozWFPDw=;
        b=VVKcd0AsCnqbiOA75vkfYLI8PR3c9gYothwuJHKWcW2POCaYfkrnile0l9cvw1DZso
         e34atdHIm1vZM6nQdkGZPjLyU5oKCoSyHDWlxq6zFeJRogIz5MXD4Pegzg0tLVa45NdM
         6fHMsvuRHjhL4q6xbb0r5JrMPyc6Sk6/CWzl6mG5jRwKT4c3uRa7pyahek4pdPf0DDg7
         p1a+SqSJDDpnFGPegCZYbyrKOZW/7nDyA5Si/GXPSfUaY3jNo9JZY3U2M1bWGANEPHIR
         F44OupWSSIp/AfgNBRZ8zzQkz2qRSOq2iKh4+BA0mjADleLHYS33X+NtAg0VGI6LIIze
         a6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KjiEVUVH3LhEUahEgPDeCz6/w7FXRv21B6oRozWFPDw=;
        b=ItnlwE2v2v9cFwlX3KGyCPsVQwg4uEmPCEJD//CkY/7eveGH8bq30v9PUFahbGkq6m
         iq2NHyVHxnmdwklsiT5Y/p+BmGOgb/mrU8HEIVvJAHuZHNb2B5xY9EMhJwFNZJ+KDGG1
         RGgAz7MA2Erk4wkQwDJ7GZzDmgkT6cGp4PW21/rIqqHxB0sNqpDlmzlnThR1CLoKY1Rz
         v0evBSwMSAI+hBTVlsrIj6mvdzNoS9W7QuGmkVooWOM/rxrHmOYRBhtbyMGr3oTeaUzV
         R5kELbJkx0yhD1S5P0qwcfjiz1eyCJM9Hq+e2xu5b8KZqG1sGS64nPL9bvKR4puXElAg
         QeoA==
X-Gm-Message-State: APjAAAUn3j88bFbQcqXP9EYPO4nybPpeo/cE6Zou3CLkLIAQDeSFSzrW
        QaLQ+rMI3AyIQCoHp4ujJYB1WD2zYR/3EOXL2VHi3Q==
X-Google-Smtp-Source: APXvYqzOs3hVD9imOllueUR+A3F1a+++GIZjcCfIXygMhJX1S7V5sZjKG9PFURgXzJqEh/OPsKcQAciddf1QhLTeH9g=
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr21844315plv.297.1582063446576;
 Tue, 18 Feb 2020 14:04:06 -0800 (PST)
MIME-Version: 1.0
References: <1581094694-6513-1-git-send-email-alan.maguire@oracle.com>
 <1581094694-6513-2-git-send-email-alan.maguire@oracle.com>
 <c42ac237-476a-526f-b445-61e7a63bc101@gmail.com> <CAFd5g47p9wnbz=HrNh0U2bbc=0ZaJ7n0U+_=E8yp8yPMrqwzaA@mail.gmail.com>
 <MWHPR13MB0895A9AC64475539ECF99987FD110@MWHPR13MB0895.namprd13.prod.outlook.com>
In-Reply-To: <MWHPR13MB0895A9AC64475539ECF99987FD110@MWHPR13MB0895.namprd13.prod.outlook.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 18 Feb 2020 14:03:55 -0800
Message-ID: <CAFd5g44BmpxS7RgxoNBywBOs3NjWdFp+A_aU5Ym0MrSn=O_RbA@mail.gmail.com>
Subject: Re: [PATCH v3 kunit-next 1/2] kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results
 display
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>, shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 18, 2020 at 12:49 PM Bird, Tim <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From:  Brendan Higgins
> >
> > On Wed, Feb 12, 2020 at 7:25 PM Frank Rowand <frowand.list@gmail.com> wrote:
> > >
> > > On 2/7/20 10:58 AM, Alan Maguire wrote:
>
> ...
>
> > > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > > index 9242f93..aec607f 100644
> > > > --- a/lib/kunit/test.c
> > > > +++ b/lib/kunit/test.c
> > > > @@ -10,6 +10,7 @@
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/sched/debug.h>
> > > >
> > > > +#include "debugfs.h"
> > > >  #include "string-stream.h"
> > > >  #include "try-catch-impl.h"
> > > >
> > > > @@ -28,73 +29,91 @@ static void kunit_print_tap_version(void)
> > > >       }
> > > >  }
> > > >
> > > > -static size_t kunit_test_cases_len(struct kunit_case *test_cases)
> > > > +size_t kunit_suite_num_test_cases(struct kunit_suite *suite)
> > > >  {
> > > >       struct kunit_case *test_case;
> > > >       size_t len = 0;
> > > >
> > > > -     for (test_case = test_cases; test_case->run_case; test_case++)
> > > > +     kunit_suite_for_each_test_case(suite, test_case)
> > > >               len++;
> > > >
> > > >       return len;
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
> > > >
> > > >  static void kunit_print_subtest_start(struct kunit_suite *suite)
> > > >  {
> > > >       kunit_print_tap_version();
> > > > -     pr_info("\t# Subtest: %s\n", suite->name);
> > > > -     pr_info("\t1..%zd\n", kunit_test_cases_len(suite->test_cases));
> > > > +     kunit_log(KERN_INFO, suite, "# Subtest: %s", suite->name);
> > > > +     kunit_log(KERN_INFO, suite, "1..%zd",
> > > > +               kunit_suite_num_test_cases(suite));
> > >
> > > The subtest 'is a TAP stream indented 4 spaces'.  (So the old code was
> > > also incorrect since it indented with a tab.)
> >
> > Whoops.
> >
> > I agree that fixing tabs to spaces is probably the easiest thing to do
> > here; nevertheless, I think this might be a good time to talk about
> > other deviations from the spec and what to do about it. This might
> > also be a good time to bring up Tim's comment at LPC last year about
> > forking TAP. Arguably I already have given that TAP14 is still under
> > review and is consequently subject to change.
> >
> > Additionally, the way I report expectation/assertion failures are my
> > own extension to the TAP spec. I did this because at the time I wasn't
> > ready to open the can of worms that was adding a YAML serializer to
> > the Linux kernel; I mentioned adding a YAML serializer at LPC and
> > people didn't seem super thrilled with the idea.
>
> I'm not sure I follow.  Are you talking about writing YAML or interpreting
> YAML.  You don't need a serializer to write YAML.  It can be done
> with straight text output.  I guess it depends on the scope of what you
> envision.  Even if you want to do more than trivial structured output,
> I don't think you'll need a full serializer.  (IOW, I think you could sneak
> something in and just call it a test output formatter.  Just don't call it YAML
> and most people won't notice. :-)

Yeah, for the first one or two things just printing things out
directly is probably fine, and yes, I could have just snuck it in, but
at the time it wasn't a hindrance for me to ask what people wanted: I
had already worked around it.

In any case, I was just explaining part of why I did expectations and
assertion failures the way that I did.

> >
> > Further both the TAP implementation here as well as what is in
> > kselftest have arbitrary kernel output mixed in with TAP output, which
> > seems to be a further deviation from the spec.
> Well that's a different kettle of worms, and really argues for staying
> with something that is strictly line-based.
>
> >
> > In an effort to do this, and so that at the very least I could
> > document what I have done here, I have been looking into getting a
> > copy of TAP into the kernel. Unfortunately, TAP appears to have some
> > licensing issues. TAP says that it can be used/modified "under the
> > same terms as Perl itself" and then provides a dead link. I filed a
> > pull request to update the licence to the Perl Artistic Licence 1.0
> > since I believe that is what they are referencing; however, I have not
> > heard back from them yet.
>
> When you say "getting a copy of TAP into the kernel", I presume you mean
> an existing implementation to produce TAP output?  Or are you talking about
> a TAP interpreter?  I'm not sure the former needs to use an existing implementation.

Sorry, that wasn't clear. I meant: get a copy of the TAP spec itself
into the kernel documentation. KUnit already has an implementation.

> I previously volunteered (in Lisbon) to write up the TAP deviations,
> and never got around to it.   Sorry about that. I can try to work on it now if
> people are still interested.

I think that would be useful. I would do it, but, as I mentioned,
there are licensing issues with the TAP spec. I am trying to resolve
those issues, and am currently waiting to hear back from somebody from
TAP.
