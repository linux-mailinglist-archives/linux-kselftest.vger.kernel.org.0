Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFCA2CBC2D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 12:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgLBL5o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 06:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbgLBL5o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 06:57:44 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3975CC0613D6
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Dec 2020 03:57:04 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id z5so1565451iob.11
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Dec 2020 03:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCeY5T30/ZjfSVbte8zrwF6m9bsYxmhw2op2/i/S+hk=;
        b=Vww9jv/7xYol0/yx+O5GXuPAjYE2ZK/2iu17yCICQIn377EmVBPj8bX5D9plVX/P83
         rgNm91r0jdTwNPhnp8hedFn8xMrxOiSg/wqN0k7NPUUQzwNfgG6nn7KqGB6v4cs4GEhV
         xJRqXiPl3uvHdHab7AoVGaLmctWo3hLJ5UXNkmvYvC9QN9JC9qKKM8zZn8pr/8Kwrav3
         1PkWHopunycNfFqxbgpViqHN4L2ik82TvdZiKsPFSmkbmR9in2KJmVt+GmJLrj+078QJ
         KYZP84XuQ/Uiold75a7RaZN9i47OWwNjXyzyKwYpjMwR+VgDXTiwu/GpCNdf1mHfq/yU
         A2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCeY5T30/ZjfSVbte8zrwF6m9bsYxmhw2op2/i/S+hk=;
        b=dknhh1ve56XJBP99VGtZASMwqfN71ap3WWRbfPxAAUegh9mim3uxMaZC/YeDpyW36/
         1iTQuT60eW7s8md3/VEzFIYb8aw3+C5CMgLhxxRbswy+mgSPQToDQ49S3thnExW35cvw
         kGrWJ2tzLDssHDehqc2C1ML17DKKx/tJ+TYJHmR2S9XGO6EO/i1X2obNQ/x4cTly8lwf
         tZPXDRmA5gLpdyMnd1wy6f2/PrcsqgxVrnkPkC686So0wEUvQBFEiYFAzSPZnbEQYziz
         CuS0qg0iCjmztJyQwdDp0UBvn6lWqdbaCiQA4MraSoVrmYyF6NeBeUKMSrBgU0HNveK3
         tnog==
X-Gm-Message-State: AOAM532sxT8g5lHL1MfWfOL/5c8iBjJMptOLm5mscKovQUpvt9p3IGYf
        W8s/pO/cSsrjyf4V2aIabVBGTakMndmL2np77n+qjA==
X-Google-Smtp-Source: ABdhPJxwGXgWYmXQR1g64OoUroc8Iz4Bfn87HawyehbTd3kJCuBl+zB57hM5RAFqyDTtU6bYsCzS5wufzk2x4I8L0UY=
X-Received: by 2002:a02:354a:: with SMTP id y10mr1818092jae.126.1606910223366;
 Wed, 02 Dec 2020 03:57:03 -0800 (PST)
MIME-Version: 1.0
References: <20201201071632.68471-1-98.arpi@gmail.com> <CAHp75VfV60sRAKkzvbEKW7UEZSiDmNVfd_kB-OOKZRk5MNMeDQ@mail.gmail.com>
 <e10ef8d3-f22b-db10-3784-c94ee425af46@gmail.com> <20201202094408.GW4077@smile.fi.intel.com>
In-Reply-To: <20201202094408.GW4077@smile.fi.intel.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 2 Dec 2020 19:56:51 +0800
Message-ID: <CABVgOS=hrfma2Yq=h2vqOoH1Mz4xSyfDbgkM9EHvMFk=HJkcnQ@mail.gmail.com>
Subject: Re: [PATCH v3] lib: Convert test_hexdump.c to KUnit
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 2, 2020 at 6:06 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Dec 02, 2020 at 09:51:19AM +0530, Arpitha Raghunandan wrote:
> > On 01/12/20 4:36 pm, Andy Shevchenko wrote:
> > > On Tue, Dec 1, 2020 at 9:21 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> ...
>
> > >> I ran both the original and converted tests as is to produce the
> > >> output for success of the test in the two cases. I also ran these
> > >> tests with a small modification to show the difference in the output
> > >> for failure of the test in both cases. The modification I made is:
> > >>  static const char * const test_data_4_le[] __initconst = {
> > >> -       "7bdb32be", "b293180a", "24c4ba70", "9b34837d",
> > >> +       "7bdb32be", "b293180a", "24c4ba70", "9b3483d",
> > >>
> > >> The difference in outputs can be seen here:
> > >> https://gist.github.com/arpi-r/38f53a3c65692bf684a6bf3453884b6e
> > >
> > > Looks pretty much good, what I'm sad to see is the absence of the test
> > > statistics. Any ideas if we can get it back?
> > >
> >
> > I could again include variable total_tests as was in the original test.
> > Would that be fine?
>
> What I;m talking about is the output. How it will be implemented (using the
> same variable or differently) is up to you. So the point is I want to see the
> statistics of success/total at the end.
>
> I think this should be done in KUNIT rather than in the individual test cases.

I tend to agree here that this really is something for KUnit. At the
moment, the tools/testing/kunit/kunit.py script will parse the kernel
log and generate these sorts of statistics. I know that needing to run
it through a script might seem like a step backwards, but there's no
formal place for statistics in the KTAP specification[1] being worked
on to standardise kselftest/kunit output formats. Note that there are
other parsers for TAP-like formats which are being used with KUnit
results, so systems like LAVA could also sum up these statistics. It's
also possible, as Arpitha alluded to, to have the test dump them out
as a comment.

This won't actually work for this test as-is, though, as the KUnit
version is running as a single giant test case (so KUnit believes that
1/1 tests have passed, rather than having any more-detailed
statistics). It looks like there are a few ways to split it up a bit
which would make it neater (a test each for the for() loops in
test_hexdump_init() seems sensible to me), but at the moment, there's
not really a way of programmatically generating test cases which KUnit
then counts

The "Parameterised Tests"[2] work Arpitha has been working on ought to
go some way to helping here, though it won't solve this completely in
this initial version. The problem there is that parameterised tests
are not reported individually in a way the kunit.py parser can report
cleanly, yet, so it'll still only be counted as one test until that's
changed (though, at least, that shouldn't require any test-specific
work).

My suggestion for the ultimate state of the test would be:
- Split up the test into separate KUnit tests for the different
"categories" of tests: (e.g., test_hexdump_set,
test_hexdump_overflow_set_ascii, etc)
- Replace the for loops in test_hexdump_init() with parameters, so
that KUnit is aware of the original runs.
- Once KUnit and the tooling supports it, these will be reported as
subtests. (In the meantime, the results will be listed individually,
commented out)

Of course, it'll take a while before all of those KUnit pieces are in
place. I personally think that a good compromise would be to just do
the first of these for now, which would make kunit_tool give at least
a 4/4 rather than 1/1 result. Then, once the parameterised testing
work is merged (and perhaps the tooling fixes are finished), the tests
could be updated to take advantage of that.

Cheres,
-- David

[1]: https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/T/
[2]: https://lore.kernel.org/linux-kselftest/20201116054035.211498-1-98.arpi@gmail.com/
