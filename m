Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4028F180AAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Mar 2020 22:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgCJVm6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Mar 2020 17:42:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37207 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgCJVm5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Mar 2020 17:42:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id p14so93297pfn.4
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Mar 2020 14:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8S0xt9zGk63HhTITzK6CBJ11aBQXn7zIA733l18/vY=;
        b=okzgk5iR0Ngu9YfAwSgoczbpRrjU11JC2c0oOGP4m8ZZ7BheeCcgPo+jjOSoInWkyH
         sgjrb7UAE1jhF/3DbeKNSlD6DXlddZpNz4w/TvQcf8pNp6h6hmPBS6yM/VQTYD6JFChe
         bo9t7VxlT5HM7L9eEwZYiCxxO+a5dh6O2DET1j5FIrqd2li/rz2xuTh9NKIgfRRIgenU
         VOW+NkGwoidDgX/tWmNhww+WyxknFoSSz6tADLvkCunP7KTVV8SD8eHG5JNccEUV9q9d
         tjZpJQjKoMYF9428sAnfroAOcPvb67/GJr3H5teLHuRw0mzF0acIULuvCAbncOFKlq42
         +YEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8S0xt9zGk63HhTITzK6CBJ11aBQXn7zIA733l18/vY=;
        b=nnXDY17I9gvrlO90mU+CvTRSUA3ReHGV2Ycoc/b9FS7Iona3mn07U28pMiRac325tz
         DV5IaylsLSKwL4k10nas/1Rw7edwBxYs+aB4OpTbKJeFxIFAG8HrZuym4Xig4PR1Q+h7
         sfhLnEiRF7cFQOsiamP1/VPCG12f69zvWPuYdrEoju1XXvNM6QChhfwFtfP4iwtHCM2b
         1UQi5e54KJdjVpB467RujMy2lrcSSPbKkulqUCoRVXu5nSkTweLsxx82bGyjkRVENe9G
         1E8UR1jS29n+ArprBwLEBTyAesGTk/H4pZyLbE2fZIfCsJ5BJI7AnHezxnPX6CyPAod9
         wPvw==
X-Gm-Message-State: ANhLgQ2BOvpD1eL+LWYhMQatls2n2FcjGhHVo6JHmGSFNhC6PrXnRCX6
        FCt/gyeONm1TpdgEGLLK+tvCrJAvoQqiRbzns+eEjQ==
X-Google-Smtp-Source: ADFU+vsqTzbRFxBhJwU+7zg1aBIJwNmzJYba1DWApx+Cn+UV1QTcs5ugzhxFTPaxJaevR94W14XVjl3cFIfCimo8i4U=
X-Received: by 2002:a62:1b51:: with SMTP id b78mr17127409pfb.23.1583876574800;
 Tue, 10 Mar 2020 14:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <20200227024301.217042-2-trishalfonso@google.com> <alpine.LRH.2.20.2002271136160.12417@dhcp-10-175-190-15.vpn.oracle.com>
 <CAKFsvUK2hFV3LePxwBXO_ubrgYoOk7fuKMOy+vSAH5Tf3SrMOA@mail.gmail.com>
 <alpine.LRH.2.20.2003031617400.13146@dhcp-10-175-165-222.vpn.oracle.com>
 <CAKFsvUKk=ggYsRcaDrrtRuW3-A5cQh1Q5uA3NBMsnAL1nEUsLg@mail.gmail.com> <alpine.LRH.2.20.2003050736090.2979@dhcp-10-175-220-65.vpn.oracle.com>
In-Reply-To: <alpine.LRH.2.20.2003050736090.2979@dhcp-10-175-220-65.vpn.oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 10 Mar 2020 14:42:43 -0700
Message-ID: <CAFd5g47hRetvP3Y262MXbnExcsQ_BXi9RYRPObAVvjJPVKCKDw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 4, 2020 at 11:47 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Wed, 4 Mar 2020, Patricia Alfonso wrote:
>
> > On Tue, Mar 3, 2020 at 8:40 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > >
> > > On Fri, 28 Feb 2020, Patricia Alfonso wrote:
> > >
> > > > On Thu, Feb 27, 2020 at 6:04 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > > >
> > > > > On Wed, 26 Feb 2020, Patricia Alfonso wrote:
> > > > >
> > > > > > Integrate KASAN into KUnit testing framework.
> > > > >
> > > > > This is a great idea! Some comments/suggestions below...
> > > > >
> > > >
> > > > Thank you so much for your suggestions!
> > > >
> > >
> > > No problem! Extending KUnit to test things like KASAN
> > > is really valuable, as it shows us ways we can improve
> > > the framework. More below...
> > >
> > > > > >  - Fail tests when KASAN reports an error that is not expected
> > > > > >  - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
> > > > > >  - KUnit struct added to current task to keep track of the current test
> > > > > > from KASAN code
> > > > > >  - Booleans representing if a KASAN report is expected and if a KASAN
> > > > > >  report is found added to kunit struct
> > > > > >  - This prints "line# has passed" or "line# has failed"
> > > > > >
> > > > > > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> > > > > > ---
> > > > > > If anyone has any suggestions on how best to print the failure
> > > > > > messages, please share!
> > > > > >
> > > > > > One issue I have found while testing this is the allocation fails in
> > > > > > kmalloc_pagealloc_oob_right() sometimes, but not consistently. This
> > > > > > does cause the test to fail on the KUnit side, as expected, but it
> > > > > > seems to skip all the tests before this one because the output starts
> > > > > > with this failure instead of with the first test, kmalloc_oob_right().
> > > > > >
> > > > > >  include/kunit/test.h                | 24 ++++++++++++++++++++++++
> > > > > >  include/linux/sched.h               |  7 ++++++-
> > > > > >  lib/kunit/test.c                    |  7 ++++++-
> > > > > >  mm/kasan/report.c                   | 19 +++++++++++++++++++
> > > > > >  tools/testing/kunit/kunit_kernel.py |  2 +-
> > > > > >  5 files changed, 56 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > > > > index 2dfb550c6723..2e388f8937f3 100644
> > > > > > --- a/include/kunit/test.h
> > > > > > +++ b/include/kunit/test.h
> > > > > > @@ -21,6 +21,8 @@ struct kunit_resource;
> > > > > >  typedef int (*kunit_resource_init_t)(struct kunit_resource *, void *);
> > > > > >  typedef void (*kunit_resource_free_t)(struct kunit_resource *);
> > > > > >
> > > > > > +void kunit_set_failure(struct kunit *test);
> > > > > > +
> > > > > >  /**
> > > > > >   * struct kunit_resource - represents a *test managed resource*
> > > > > >   * @allocation: for the user to store arbitrary data.
> > > > > > @@ -191,6 +193,9 @@ struct kunit {
> > > > > >        * protect it with some type of lock.
> > > > > >        */
> > > > > >       struct list_head resources; /* Protected by lock. */
> > > > > > +
> > > > > > +     bool kasan_report_expected;
> > > > > > +     bool kasan_report_found;
> > > > > >  };
> > > > > >
> > > > >
> > > > > Is this needed here? You're testing something pretty
> > > > > specific so it seems wrong to add to the generic
> > > > > kunit resource unless there's a good reason. I see the
> > > > > code around setting these values in mm/kasan/report.c,
> > > > > but I wonder if we could do something more generic.
> > > > >
> > > > > How about the concept of a static resource (assuming a
> > > > > dynamically allocated one is out because it messes
> > > > > with memory allocation tests)? Something like this:
> > > > >
> > > > > #define kunit_add_static_resource(test, resource_ptr, resource_field)   \
> > > > >         do {                                                            \
> > > > >                 spin_lock(&test->lock);                                 \
> > > > >                 (resource_ptr)->resource_field.init = NULL;             \
> > > > >                 (resource_ptr)->resource_field.free = NULL;             \
> > > > >                 list_add_tail(&(resource_ptr)->resource_field,          \
> > > > >                               &test->resources);                        \
> > > > >                 spin_unlock(&test->lock);                               \
> > > > >         } while (0)
> > > > >
> > > > >
> > > > > Within your kasan code you could then create a kasan-specific
> > > > > structure that embends a kunit_resource, and contains the
> > > > > values you need:
> > > > >
> > > > > struct kasan_report_resource {
> > > > >         struct kunit_resource res;
> > > > >         bool kasan_report_expected;
> > > > >         bool kasan_report_found;
> > > > > };
> > > > >
> > > > > (One thing we'd need to do for such static resources is fix
> > > > > kunit_resource_free() to check if there's a free() function,
> > > > > and if not assume a static resource)
> > > > >
> > > > > If you then create an init() function associated with your
> > > > > kunit suite (which will be run for every case) it can do this:
> > > > >
> > > > > int kunit_kasan_test_init(struct kunit *test)
> > > > > {
> > > > >         kunit_add_static_resource(test, &my_kasan_report_resource, res);
> > > > >         ...
> > > > > }
> > > > >
> > > > > The above should also be used to initialize current->kasan_unit_test
> > > > > instead of doing that in kunit_try_run_case().  With those
> > > > > changes, you don't (I think) need to change anything in core
> > > > > kunit (assuming support for static resources).
> > > > >
> > > > > To retrieve the resource during tests or in kasan context, the
> > > > > method seems to be to use kunit_resource_find(). However, that
> > > > > requires a match function which seems a bit heavyweight for the
> > > > > static case.  We should probably have a default "find by name"
> > > > > or similar function here, and add an optional "name" field
> > > > > to kunit resources to simplify things.  Anyway here you'd
> > > > > use something like:
> > > > >
> > > > >         kasan_report_resource = kunit_resource_find(test, matchfn,
> > > > >                                                     NULL, matchdata);
> > > > >
> > > > >
> > > > > Are there any barriers to taking this sort of approach (apart
> > > > > from the support for static resources not being there yet)?
> > > > >
> > > >
> > > > I'm not sure. I don't have any experience with kunit resources so I
> > > > would have to put some more effort into understanding how this would
> > > > work for myself. I wonder if this might be a bit of an over
> > > > complicated way of eliminating an extraneous boolean... maybe we can
> > > > find a simpler solution for the first version of this patch and add
> > > > the notion of a static resource for generic use later.
> > > >
> > >
> > > My personal preference would be to try and learn what's needed
> > > by KASAN and improve the KUnit APIs so the next developer finds
> > > life a bit easier. More hassle for you I know, but actual use cases
> > > like this are invaluable for improving the API.  I've sent
> > > out an RFC patchset which has the functionality I _think_ you
> > > need but I may be missing something:
> > >
> > > https://lore.kernel.org/linux-kselftest/1583251361-12748-1-git-send-email-alan.maguire@oracle.com/T/#t
> > >
> > > The idea is your test can do something like this:
> > >
> > > struct kasan_data {
> > >         bool report_expected;
> > >         bool report_found;
> > > };
> > >
> > >
> > > my_kasan_test(struct kunit *test)
> > > {
> > >         struct kunit_resource resource;
> > >         struct kasan_data kasan_data;
> > >
> > > ...
> > >         // add our named resource using static resource/data
> > >         kunit_add_named_resource(test, NULL, NULL, &resource,
> > >                                  "kasan_data", &kasan_data);
> > > ...
> > >
> > > }
> > Does this require the user to set up this kasan_data resource in each
> > KASAN test? Or can we set up the resource on the KUnit side whenever a
> > user writes a test that expects a KASAN failure? I've been playing
> > around with it and I can only seem to get it to work when I add the
> > resource within the test, but I could be missing something.
> >
>
> The current model of resources is they are associated with
> the running state of a test for the lifetime of that test.
> If it's a resource common to many/most tests, I'd suggest
> creating an init() function for the associated suite; this
> will get run prior to executing each test, and in it you
> could initialize your resource. If the resource isn't
> used in the test, it doesn't really matter so this might be
> the simplest way to handle things:
>
> struct kasan_data {
>          bool report_expected;
>          bool report_found;
> };
>
> struct kasan_data kasan_data;
> struct kunit_resource resource;
>
> kasan_init(struct kunit *test)
> {
>
>          // add our named resource using static resource/data
>          kunit_add_named_resource(test, NULL, NULL, &resource,
>                                   "kasan_data", &kasan_data);
>
>         return 0;
> }
>
> static struct kunit_suite kasan_suite = {
>         .name = "kasan",
>         .init = kasan_init,
>         ...
> };
>
>
> This all presumes however that KASAN will only need access to the
> resource during the lifetime of each test.  There's currently
> no concept of free-floating resources outside of test execution
> context.

So we do have some patches lying around that add support for resources
associated with a suite of tests that I can send out if anyone is
interested; nevertheless, I think it makes sense for KASAN to only
care about tests cases; you still get the KASAN report either way and
KUnit isn't really supposed to care what happens outside of KUnit.

Cheers
