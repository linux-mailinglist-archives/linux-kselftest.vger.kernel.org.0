Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341C92CBCDA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 13:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgLBMWM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 07:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgLBMWL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 07:22:11 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEFEC0613CF;
        Wed,  2 Dec 2020 04:21:31 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t37so977260pga.7;
        Wed, 02 Dec 2020 04:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X7vg7wOATI8swNnN5Fz23jvJnq806ch7HKM6VeRWjEw=;
        b=temuNJKlIFyJaTFYFbBj/gyia+9N5OdIzyR3R3MhZm47Znr9IfA3qX2+53lt+dKJER
         V5DlWd1jr55pgbAPMvXF/us1TD9JKqVQCL1Ukfxw6WZbu/2413wBvsMpZauh+1LEt6Fu
         JOza4FJXxaOelTHKZQG5hBGDeWTJ/2h0gPtSYrOOUJNHqz/EOfVKuJsFg0zm5EVAqHsU
         fDmISQAxiBTHgD/AW9OesOn17y7+KqWE0UvKxojxGKohNIWY3hPeWbZ/j6P5oUjA5VIT
         1lpSFnHw+oc5nIjn65Uig3ZmN/HgxytIwHcktzAdZQJ0/DLh+RAi023jG439GFCkPFWt
         mmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X7vg7wOATI8swNnN5Fz23jvJnq806ch7HKM6VeRWjEw=;
        b=PZEWzn+qJTEXzqKMKsOfc/bMNk243eQLh00ys17f7ZzXB1TJYfyXzqGu1sjpIDpub8
         fj3KvEzVr3vTp5yvhQ/wZJqVnBHyid20UceAgcwhu0NhOh1H+0AJUBmUbkcPJ3I9C63S
         71yJTiZbkLyQTDY+9AKWUSc5kJ0iX7g2ezeFFIqj7Hu1afQnl0cRP35IxXhCzoelNeyL
         zvvUEFl/PJavqxGHMKdyn+zbIeBCZKzu0j2Z6XUkswffSsW24qYQkdP2bQ/aWG7CMKyU
         X2Siow3rj9LBLvHi16ROlANE31/BnAuTrK8j5SB917py3Xex/Hu9njE2+6Vt6+UNTviu
         cN3A==
X-Gm-Message-State: AOAM533D1X8DaaaxAOPBNpsH1F1ztvSMvo4W2HAy55gPvf8LscZXKcwD
        vsMASmTwelzQlu1ysq+wCTVDCdziQUvmnou6LH4=
X-Google-Smtp-Source: ABdhPJwt9Hk6qTjPy/YhgdDqb83v2pS6RnL7J+5lmDMvVQHbXRi0IYRuv+vjBrDa52Kb3aqQ+BC3wvuhSb4CjLkc2OM=
X-Received: by 2002:a62:ae0e:0:b029:198:11b4:6b6b with SMTP id
 q14-20020a62ae0e0000b029019811b46b6bmr2332412pff.73.1606911691119; Wed, 02
 Dec 2020 04:21:31 -0800 (PST)
MIME-Version: 1.0
References: <20201201071632.68471-1-98.arpi@gmail.com> <CAHp75VfV60sRAKkzvbEKW7UEZSiDmNVfd_kB-OOKZRk5MNMeDQ@mail.gmail.com>
 <e10ef8d3-f22b-db10-3784-c94ee425af46@gmail.com> <20201202094408.GW4077@smile.fi.intel.com>
 <CABVgOS=hrfma2Yq=h2vqOoH1Mz4xSyfDbgkM9EHvMFk=HJkcnQ@mail.gmail.com>
In-Reply-To: <CABVgOS=hrfma2Yq=h2vqOoH1Mz4xSyfDbgkM9EHvMFk=HJkcnQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Dec 2020 14:22:19 +0200
Message-ID: <CAHp75VcSGJ-qVQf9SRj2rTME-_MZ2vM-HB_+LiRVgnkwn1TO=g@mail.gmail.com>
Subject: Re: [PATCH v3] lib: Convert test_hexdump.c to KUnit
To:     David Gow <davidgow@google.com>
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

On Wed, Dec 2, 2020 at 1:57 PM David Gow <davidgow@google.com> wrote:
> On Wed, Dec 2, 2020 at 6:06 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Dec 02, 2020 at 09:51:19AM +0530, Arpitha Raghunandan wrote:

...

> > What I;m talking about is the output. How it will be implemented (using the
> > same variable or differently) is up to you. So the point is I want to see the
> > statistics of success/total at the end.
> >
> > I think this should be done in KUNIT rather than in the individual test cases.
>
> I tend to agree here that this really is something for KUnit. At the
> moment, the tools/testing/kunit/kunit.py script will parse the kernel
> log and generate these sorts of statistics. I know that needing to run
> it through a script might seem like a step backwards, but there's no
> formal place for statistics in the KTAP specification[1] being worked
> on to standardise kselftest/kunit output formats.

Then it sucks. Fix specification (in a long term) and does it have a
comment style of messages that we can have this statistics printed
(but maybe not parsed)?

> Note that there are
> other parsers for TAP-like formats which are being used with KUnit
> results, so systems like LAVA could also sum up these statistics. It's
> also possible, as Arpitha alluded to, to have the test dump them out
> as a comment.

Fine to me.

> This won't actually work for this test as-is, though, as the KUnit
> version is running as a single giant test case (so KUnit believes that
> 1/1 tests have passed, rather than having any more-detailed
> statistics). It looks like there are a few ways to split it up a bit
> which would make it neater (a test each for the for() loops in
> test_hexdump_init() seems sensible to me), but at the moment, there's
> not really a way of programmatically generating test cases which KUnit
> then counts

Fix it, please. We rely on this statistics pretty much.

> The "Parameterised Tests"[2] work Arpitha has been working on ought to
> go some way to helping here, though it won't solve this completely in
> this initial version. The problem there is that parameterised tests
> are not reported individually in a way the kunit.py parser can report
> cleanly, yet, so it'll still only be counted as one test until that's
> changed (though, at least, that shouldn't require any test-specific
> work).
>
> My suggestion for the ultimate state of the test would be:
> - Split up the test into separate KUnit tests for the different
> "categories" of tests: (e.g., test_hexdump_set,
> test_hexdump_overflow_set_ascii, etc)
> - Replace the for loops in test_hexdump_init() with parameters, so
> that KUnit is aware of the original runs.
> - Once KUnit and the tooling supports it, these will be reported as
> subtests. (In the meantime, the results will be listed individually,
> commented out)

I'm fine as long as we have this information printed to the user.

> Of course, it'll take a while before all of those KUnit pieces are in
> place. I personally think that a good compromise would be to just do
> the first of these for now, which would make kunit_tool give at least
> a 4/4 rather than 1/1 result. Then, once the parameterised testing
> work is merged (and perhaps the tooling fixes are finished), the tests
> could be updated to take advantage of that.

How can we guarantee it will be not forgotten?

> [1]: https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/T/
> [2]: https://lore.kernel.org/linux-kselftest/20201116054035.211498-1-98.arpi@gmail.com/

-- 
With Best Regards,
Andy Shevchenko
