Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742C8258E22
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Sep 2020 14:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgIAMYa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 08:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgIAMXz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 08:23:55 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7A5C061245
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Sep 2020 05:23:54 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k20so975990otr.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Sep 2020 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPd2nmAR99753SpbDqKjpwvWS3XeewS5doMRWJKeH9A=;
        b=HYiR7NQLL7CEXUgueqQCqhAJZCV7D8VssyLjabOiH7QvLkkMqb5S4MqoUwMIVY2nH+
         3oZBjNonmm76hFo/hGcqbqN2atgrBlcLSoeev9uZU+evK6Z1uGrZrqmFafj3lf9Gt5+f
         WpWi6NjmzaK3AhGjWfEtsU3zH7EJjUF4TuOpWKCEpT8LQdLdAjYGj0Y/b4ybPnHYeP54
         BlX6dMc2Rz7ECgvCdzDcZJC+m63W9gwiBp+aNcMyetP0ey/xhoTjE/xlrXmCNnlmVTmd
         gQvPdkww2y1Qn/AlXd3nG8oaMSlM25lujHnbFbKjggyeg08tAP2/GftoDTRbw1D3Du0z
         Hu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPd2nmAR99753SpbDqKjpwvWS3XeewS5doMRWJKeH9A=;
        b=PSX8csfhYutIraBpFeY2I9WTsmRF0yNN2rnrjriEHbj0oKdZ5T4hUfK+7xDB4mN5yS
         n8PaQvPuedSYX6fRN648mb0opMRolSxWB8DdQnUeZhw+aac4HK3ebRJaVKnU3Hc8YI/i
         uXJcxwGBlp2I2pEJNGqxHiutmibljTX02oJOIqbJwPq8a/hYEQZC8cGOGkm7yMZG9OV3
         AWkYOhz0JByFE2OU5iY+waa2KPqLamRzj0SHBc1fEG1owt2HAvu+LjzO8FGNh9qhrlCV
         KN7cB66RXFFGJtbUOb4nvSmaj2yXC9GL7DtMLzP7OX8P3C8axEV8PD2ST12BIZWqADUP
         5Ehw==
X-Gm-Message-State: AOAM532ZXqJx+1AMWnIlZ/VQ8iS2RJhHbSeIbNMQgGH5q5l55F1IuWpr
        V5BI6FpDOWYaSmqztljaHWJnjmy0tLQ/3BURQMoL5A==
X-Google-Smtp-Source: ABdhPJwGpWKpHqgW8rQrEqP56HzXCCuz6stG/v1IJ+lS1hroVcLGqxc6suTkMJ9vZGYidJfznp/cYf6EVKv4AsgmYIQ=
X-Received: by 2002:a9d:7446:: with SMTP id p6mr1257108otk.17.1598963033541;
 Tue, 01 Sep 2020 05:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200702071416.1780522-1-davidgow@google.com> <20200827131438.GA3597431@elver.google.com>
 <CABVgOSmoiFh5i8Ue14MtCLwq-LbGgQ1hf4MyRYLFWFQrkushjQ@mail.gmail.com>
 <202008311641.D10607D43@keescook> <CABVgOSmF93YVD=scGL5p0tjnm0XUwC2n8LPT9xFqGje9zXQ96Q@mail.gmail.com>
In-Reply-To: <CABVgOSmF93YVD=scGL5p0tjnm0XUwC2n8LPT9xFqGje9zXQ96Q@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 1 Sep 2020 14:23:41 +0200
Message-ID: <CANpmjNP9OD0ZULQbZKv2HtVyO4Nho46uu4h9gNO8i-XhOMzHVw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Add naming guidelines
To:     David Gow <davidgow@google.com>
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

On Tue, 1 Sep 2020 at 07:31, David Gow <davidgow@google.com> wrote:
> On Tue, Sep 1, 2020 at 7:47 AM Kees Cook <keescook@chromium.org> wrote:
> > On Fri, Aug 28, 2020 at 12:17:05AM +0800, David Gow wrote:
> > > On Thu, Aug 27, 2020 at 9:14 PM Marco Elver <elver@google.com> wrote:
[...]
>
> I guess there are two audiences to cater for:
> 1. Test authors, who may wish to have both unit-style and
> integration-style tests, and want to distinguish them. They probably
> have the best idea of where the line should be drawn for their
> subsystems, and may have some existing style/nomenclature.
> 2. People running "all tests", who want to broadly understand how the
> whole suite of tests will behave (e.g., how long they'll take to run,
> are they possibly nondeterministic, are there weird hardware/software
> dependencies). This is where some more standardisation probably makes
> sense.
>
> I'm not 100% the file/module name is the best place to make these
> distinctions (given that it's the Kconfig entries that are at least
> our current way of finding and running tests).

I agree -- as you note, it's very hard to make this distinction. Since
we're still discussing the best convention to use, one point I want to
make is that encoding a dependency ("kunit") or type of test (unit,
integration, etc.) in the name hurts scalability of our workflows.
Because as soon as the dependency changes, or the type, any
rename/move is very destructive to our workflow, because it
immediately causes conflict with any in-flight patches. Whereas
encoding this either in a comment, or via Kconfig would be less
destructive.

> An off-the-wall idea
> would be to have a flags field in the test suite structure to note
> things like "large/long-running test" or "nondeterministic", and have
> either a KUnit option to bypass them, note them in the output, or even
> something terrifying like parsing it out of a compiled module.

As a side-node, in the other very large codebase I have worked on, we
have such markers ("size = ..."):
https://docs.bazel.build/versions/master/be/common-definitions.html#common-attributes-tests
However, there is also incentive to get this distinction right,
because the test will be killed by the CI system if it exceeds the
specified size (ran too long, OOM). Not sure we have this incentive
yet.

[...]
> > > I guess the interesting thing to note is that we've to date not really
> > > made a distinction between KUnit the framework and the suite of all
> > > KUnit tests. Maybe having a separate file/module naming scheme could
> > > be a way of making that distinction, though it'd really only appear
> > > when loading tests as modules -- there'd be no indication in e.g.,
> > > suite names or test results. The more obvious solution to me (at
> > > least, based on the current proposal) would be to have "integration"
> > > or similar be part of the suite name (and hence the filename, so
> > > _integration_kunit.c or similar), though even I admit that that's much
> > > uglier. Maybe the idea of having the subsystem/suite distinction be
> > > represented in the code could pave the way to having different suites
> > > support different suffixes like that.
> >
> > Heh, yeah, let's not call them "_integration_kunit.c" ;) _behavior.c?
> > _integration.c?

If possible, I'd still prefer generic filenames, because it's easy to
get wrong as we noted. Changes will cause conflicts.

> I think we'd really like something that says more strongly that this
> is a test (which is I suspect one of the reasons why _kunit.c has its
> detractors: it doesn't have the word "test" in it).

^ Agreed.

> The other thing to
> consider is that if there are multiple tests for the same thing (e.g.,
> a unit test suite and an integration test suite), they'd still need
> separate, non-conflicting suite names if we wanted them to be able to
> be present in the same kernel.
>
> Maybe the right thing to do is to say that, for now, the _kunit.c
> naming guideline only applies to "unit-style" tests.
[...]
>
> So, putting together the various bits of feedback, how about something
> like this:
> Test filenames/modules should end in _kunit.c, unless they are either
> a) not unit-style tests -- i.e, test something other than correctness
> (e.g., performance), are non-deterministic, take a long time to run (>
> ~1--2 seconds), or are testing across multiple subsystems -- OR
> b) are ports of existing tests, which may keep their existing filename
> (at least for now), so as not to break existing workflows.
>
> This is a bit weaker than the existing guidelines, and will probably
> need tightening up once we have a better idea of what non-unit tests
> should be and/or the existing, inconsistently named tests are
> sufficiently outnumbered by the _kunit ones that people are used to it
> and the perceived ugliness fades away. What (if any) tooling we need
> around enumerating tests may end up influencing/being influenced by
> this a bit, too.
>
> Thoughts?

That could work, but it all still feels a little unsatisfying. Here's
what I think the requirements for all this are:

1. Clear, intuitive, descriptive filenames ("[...] something that says
more strongly that this is a test [...]").

2. Avoid renames if any of the following changes: test framework, test
type or scope. I worry the most about this point, because it affects
our workflows. We need to avoid unnecessary patch conflicts, keep
cherry-picks simple, etc.

3. Strive for consistently named tests, regardless of type (because
it's hard to get right).

4. Want to distinguish KUnit tests from non-KUnit tests. (Also
consider that tooling can assist with this.)

These are the 2 options under closer consideration:

A. Original choice of "*-test.c": Satisfies 1,2,3. It seems to fail 4,
per Kees's original concern.

B. "*_kunit.c": Satisfies 4, maybe 3.
  - Fails 1, because !strstr("_kunit.c", "test") and the resulting
indirection. It hints at "unit test", but this may be a problem for
(2).
  - Fails 2, because if the test for some reason decides to stop using
KUnit (or a unit test morphs into an integration test), the file needs
to be renamed.

And based on all this, why not:

C. "*-ktest.c" (or "*_ktest.c"):
  - Satisfies 1, because it's descriptive and clearly says it's a
test; the 'k' can suggest it's an "[in-]kernel test" vs. some other
hybrid test that requires a userspace component.
  - Satisfies 2, because neither test framework or test type need to
be encoded in the filename.
  - Satisfies 3, because every test (that wants to use KUnit) can just
use this without thinking too much about it.
  - Satisfies 4, because "git grep -- '[-_]ktest\.[co]'" returns nothing.

Thanks,
-- Marco
