Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB1125D055
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Sep 2020 06:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgIDEWg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Sep 2020 00:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgIDEWc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Sep 2020 00:22:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AF7C061246
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Sep 2020 21:22:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e11so6652445wme.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Sep 2020 21:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJNootjbgI1yqKE1hshu70n//JA6RH+qTwDjuT7fs/U=;
        b=eeLpY+Dz8LGHQenp7nC3ZXa9uMS32u98WxUmvvSvnTrQLcZEK2ouBySGqHmHsCrqhW
         mTFBJzgGOEHCG0YLsQvG97TxB1Qy3yGhn1KEskth+ReojuNTPpEVYfQYa4Fspy+qvN48
         CSpcW1sIKKGfMlQTxhGTFEG/ErD8p4MZi7qkCPzFUCosJyIEEz06tTzFvec7H107LFf6
         7d6GVeraFU6FmM7l7Tu2sb1yJpEzSaQ+msbNafkRfgjbJv84UJkIKHPzL8GDWW4Diuim
         0tbFzlFfdoS8gaJUfjabqb/5jIFbL7Ba8SaTNZhBphv16SDSMa546M1x19U0VSmjGemb
         Obcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJNootjbgI1yqKE1hshu70n//JA6RH+qTwDjuT7fs/U=;
        b=Ga9fZqV5tCtdeYIBLfuZCVZgbDFcfSF6AI6gThS90l9CdVjmGte3CxQUO6A3saMupI
         9jnuVq626JPczqRYvXp0Z0jsKJU4lONNeiF2WJaKKNx8b71njzoKQ6xBEJvUtNWk8W9E
         dqB9DRheyLwJC44lAl2nv2rRnlHUbvn469kro4njWl7mkl8bKfVbEA48Skb1lqVijQ5E
         Ct+t3Cuwo93IEi75Xd7dMe7yxgIuTmxKfz0iJ0R94pWlNvFCv8d7pijAJeCo3DDEYQn3
         2A/hLdMAN5ykEsL0fdPNjWiLnhs9t3G+cBM3FqL6gH3mfSg86zXYIbhVJnoLcLEvBOD+
         Hctg==
X-Gm-Message-State: AOAM532B6QFENxZ8BvFWFX/p6O6JCBVQUZCZw97wod2ZOGZOGqdwkj72
        TybTrcq/HNrELI9qxgrw2h621teNsTuhREcyfLBZpw==
X-Google-Smtp-Source: ABdhPJyR3dCQXTEZer3IkFNsPERlVAdJMzlp1+MdP/tnbbgOf1106eDG7rfHH/99KUFFxBZHF7Oh/wIdrtnT/tQmqoE=
X-Received: by 2002:a7b:c384:: with SMTP id s4mr5362800wmj.138.1599193349790;
 Thu, 03 Sep 2020 21:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200702071416.1780522-1-davidgow@google.com> <20200827131438.GA3597431@elver.google.com>
 <CABVgOSmoiFh5i8Ue14MtCLwq-LbGgQ1hf4MyRYLFWFQrkushjQ@mail.gmail.com>
 <202008311641.D10607D43@keescook> <CABVgOSmF93YVD=scGL5p0tjnm0XUwC2n8LPT9xFqGje9zXQ96Q@mail.gmail.com>
 <CANpmjNP9OD0ZULQbZKv2HtVyO4Nho46uu4h9gNO8i-XhOMzHVw@mail.gmail.com>
In-Reply-To: <CANpmjNP9OD0ZULQbZKv2HtVyO4Nho46uu4h9gNO8i-XhOMzHVw@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 4 Sep 2020 12:22:17 +0800
Message-ID: <CABVgOSmvcToydrGzPGdTkRkKq62Gh4vtc+ZazGMfnsXw0FdRWQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Add naming guidelines
To:     Marco Elver <elver@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tim Bird <Tim.Bird@sony.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 1, 2020 at 8:23 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, 1 Sep 2020 at 07:31, David Gow <davidgow@google.com> wrote:
> > On Tue, Sep 1, 2020 at 7:47 AM Kees Cook <keescook@chromium.org> wrote:
> > > On Fri, Aug 28, 2020 at 12:17:05AM +0800, David Gow wrote:
> > > > On Thu, Aug 27, 2020 at 9:14 PM Marco Elver <elver@google.com> wrote:
> [...]
> >
> > I guess there are two audiences to cater for:
> > 1. Test authors, who may wish to have both unit-style and
> > integration-style tests, and want to distinguish them. They probably
> > have the best idea of where the line should be drawn for their
> > subsystems, and may have some existing style/nomenclature.
> > 2. People running "all tests", who want to broadly understand how the
> > whole suite of tests will behave (e.g., how long they'll take to run,
> > are they possibly nondeterministic, are there weird hardware/software
> > dependencies). This is where some more standardisation probably makes
> > sense.
> >
> > I'm not 100% the file/module name is the best place to make these
> > distinctions (given that it's the Kconfig entries that are at least
> > our current way of finding and running tests).
>
> I agree -- as you note, it's very hard to make this distinction. Since
> we're still discussing the best convention to use, one point I want to
> make is that encoding a dependency ("kunit") or type of test (unit,
> integration, etc.) in the name hurts scalability of our workflows.
> Because as soon as the dependency changes, or the type, any
> rename/move is very destructive to our workflow, because it
> immediately causes conflict with any in-flight patches. Whereas
> encoding this either in a comment, or via Kconfig would be less
> destructive.
>

This is a good point -- renaming files is definitely a pain. It's
obviously my hope that KUnit sticks around long enough that it's not
being added/removed as a dependency too often, particularly for the
unit tests, so "_kunit" as a name doesn't worry me that much
otherwise.

> > An off-the-wall idea
> > would be to have a flags field in the test suite structure to note
> > things like "large/long-running test" or "nondeterministic", and have
> > either a KUnit option to bypass them, note them in the output, or even
> > something terrifying like parsing it out of a compiled module.
>
> As a side-node, in the other very large codebase I have worked on, we
> have such markers ("size = ..."):
> https://docs.bazel.build/versions/master/be/common-definitions.html#common-attributes-tests
> However, there is also incentive to get this distinction right,
> because the test will be killed by the CI system if it exceeds the
> specified size (ran too long, OOM). Not sure we have this incentive
> yet.
>

KUnit does have test timeouts, but they're generous (30 seconds), and
not configurable per-test or per-suite. Fixing that's probably a
separate feature request which, as you point out, probably isn't worth
doing until we're actually seeing a problem. Maybe it's something
that'll become more apparent as KUnit is integrated into KernelCI and
the like, so we see more (and more varied) test runs/configs.

> [...]
> > > > I guess the interesting thing to note is that we've to date not really
> > > > made a distinction between KUnit the framework and the suite of all
> > > > KUnit tests. Maybe having a separate file/module naming scheme could
> > > > be a way of making that distinction, though it'd really only appear
> > > > when loading tests as modules -- there'd be no indication in e.g.,
> > > > suite names or test results. The more obvious solution to me (at
> > > > least, based on the current proposal) would be to have "integration"
> > > > or similar be part of the suite name (and hence the filename, so
> > > > _integration_kunit.c or similar), though even I admit that that's much
> > > > uglier. Maybe the idea of having the subsystem/suite distinction be
> > > > represented in the code could pave the way to having different suites
> > > > support different suffixes like that.
> > >
> > > Heh, yeah, let's not call them "_integration_kunit.c" ;) _behavior.c?
> > > _integration.c?
>
> If possible, I'd still prefer generic filenames, because it's easy to
> get wrong as we noted. Changes will cause conflicts.
>
> > I think we'd really like something that says more strongly that this
> > is a test (which is I suspect one of the reasons why _kunit.c has its
> > detractors: it doesn't have the word "test" in it).
>
> ^ Agreed.
>

I'm not personally convinced that "kunit" isn't something people could
associate with tests, particularly as it becomes more popular, but if
people really dislike it, we could have"_unittest.c" or similar.
There's a balancing act between being generic (and not distinguishing
between unit/integration/etc tests) and being consistent or avoiding
renames. Take the case where there's a set of unit tests in a
"-test.c" file, and an integration test is written as well: it
probably should go in a speparate file, so now you'd either have a
"-test.c" and a separate "-integration-test.c" (or the other way
around if the integration test was written first), or the "-test.c"
file would be renamed.

> > The other thing to
> > consider is that if there are multiple tests for the same thing (e.g.,
> > a unit test suite and an integration test suite), they'd still need
> > separate, non-conflicting suite names if we wanted them to be able to
> > be present in the same kernel.
> >
> > Maybe the right thing to do is to say that, for now, the _kunit.c
> > naming guideline only applies to "unit-style" tests.
> [...]
> >
> > So, putting together the various bits of feedback, how about something
> > like this:
> > Test filenames/modules should end in _kunit.c, unless they are either
> > a) not unit-style tests -- i.e, test something other than correctness
> > (e.g., performance), are non-deterministic, take a long time to run (>
> > ~1--2 seconds), or are testing across multiple subsystems -- OR
> > b) are ports of existing tests, which may keep their existing filename
> > (at least for now), so as not to break existing workflows.
> >
> > This is a bit weaker than the existing guidelines, and will probably
> > need tightening up once we have a better idea of what non-unit tests
> > should be and/or the existing, inconsistently named tests are
> > sufficiently outnumbered by the _kunit ones that people are used to it
> > and the perceived ugliness fades away. What (if any) tooling we need
> > around enumerating tests may end up influencing/being influenced by
> > this a bit, too.
> >
> > Thoughts?
>
> That could work, but it all still feels a little unsatisfying. Here's
> what I think the requirements for all this are:
>
> 1. Clear, intuitive, descriptive filenames ("[...] something that says
> more strongly that this is a test [...]").
>
> 2. Avoid renames if any of the following changes: test framework, test
> type or scope. I worry the most about this point, because it affects
> our workflows. We need to avoid unnecessary patch conflicts, keep
> cherry-picks simple, etc.
>
> 3. Strive for consistently named tests, regardless of type (because
> it's hard to get right).
>
> 4. Want to distinguish KUnit tests from non-KUnit tests. (Also
> consider that tooling can assist with this.)
>

I think that these are somewhat in conflict with each other, which is
what makes this complicated. Particularly, it's going to be difficult
to both avoid renames if the test framework changes and to distinguish
between KUnit and non-KUnit tests by filename.

I personally think that of these requirements, 2 is probably the one
that would cause people the most real-world pain. I'm not sure how
often test type or scope changes enough to be worth the rename, and I
hope KUnit survives long enough and is useful enough that test
framework changes are kept to a minimum, but this has already
irritated enough people porting tests to KUnit to be a noticeable
issue. One possibility is to focus on module names, which are probably
more important and can be renamed without changing the filename,
though that's pretty ugly.

I actually think "_kunit.c" probably is descriptive/intuitive enough
to meet (1) -- or at least will be once KUnit is more widely used --
but it does conflict a bit with 2.

It'd be nice to have consistently named tests, but we're not there at
the moment, so fixing it will require a lot of renaming things. It's
looking increasingly unlikely that we'll be able to do that for
everything, so making this a recommendation for new test suites is
probably the best we're likely to get.

> These are the 2 options under closer consideration:
>
> A. Original choice of "*-test.c": Satisfies 1,2,3. It seems to fail 4,
> per Kees's original concern.
>

Kees also brings up that using hyphens instead of underscores causes
some inconsistency with module names, which is a bit of a pain.

> B. "*_kunit.c": Satisfies 4, maybe 3.
>   - Fails 1, because !strstr("_kunit.c", "test") and the resulting
> indirection. It hints at "unit test", but this may be a problem for
> (2).
>   - Fails 2, because if the test for some reason decides to stop using
> KUnit (or a unit test morphs into an integration test), the file needs
> to be renamed.
>
> And based on all this, why not:
>
> C. "*-ktest.c" (or "*_ktest.c"):
>   - Satisfies 1, because it's descriptive and clearly says it's a
> test; the 'k' can suggest it's an "[in-]kernel test" vs. some other
> hybrid test that requires a userspace component.
>   - Satisfies 2, because neither test framework or test type need to
> be encoded in the filename.
>   - Satisfies 3, because every test (that wants to use KUnit) can just
> use this without thinking too much about it.
>   - Satisfies 4, because "git grep -- '[-_]ktest\.[co]'" returns nothing.
>

My concern with this is that we're introducing new jargon either way:
does having "test" in the name outweigh the potential confusion from
having "ktest" be in the filename only for "KUnit tests". So my
feeling is that this would've been really useful if we'd named KUnit
KTest (which, ironically, I think Brendan had considered) instead, but
as-is is probably more confusing.

> Thanks,
> -- Marco

At the risk of just chickening out at calling this "too hard", I'm
leaning towards a variant of (A) here, and going for _test, but making
it a weaker recommendation:
- Specifying that the module name should end in _test, rather than the
source filename. Module names are easier to change without causing
merge conflicts (though they're a pain to change for the user).
- Only applies to new test suites, and another suffix may be used if
it conflicts with an existing non-kunit test (if it conflicts with a
kunit test, they should be disambiguated in the suite name).
- Test types (unit, integration, some subsystem-specific thing, etc)
may be disambiguated in the suite name, at the discretion of the test
author. (e.g., "driver_integration" as a suite name, with
"driver_integration_test" as the module name, and either
"driver_integration_test.c" or "integration_test.c" as recommended
test filenames, depending on if "driver" is in its own directory.)

This should satisfy 1 & 2, and go some way towards satisfying 3. We
can try to come up with some other technical solution to 4 if we need
to.

Unless the objections are particularly earth-shattering, I'll do a new
version of the patch that matches this next week. The other option is
to drop the filename stuff from the document altogether, and sort it
out in another patch, so we at least get some of the consistency in
suite and Kconfig names.

Cheers,
-- David
