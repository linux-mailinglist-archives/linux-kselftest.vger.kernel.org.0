Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E793FBCDE
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Aug 2021 21:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhH3T1R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Aug 2021 15:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhH3T1Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Aug 2021 15:27:16 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D205DC061575
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Aug 2021 12:26:21 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m26so13045399pff.3
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Aug 2021 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CzEhYJq+BzCGpMkL/w6vmaw2zrmbtZ3zO44MgFg9Xn0=;
        b=kQx2AhfWTuaUu7sPp14tXg3hhNLd0h7hbusSJCmEI7fhzIWWdTEqOUZHlDJj0sl0jO
         ZMHGFRXjGviyG31jfxvILD+UvptDYHzrUWz3vud2wvafvteNOhKOgI5HszjXMA2t5L4Q
         BBR514zqpr1m6Ok1RZrKYZOUY/X6ppT2c9OD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CzEhYJq+BzCGpMkL/w6vmaw2zrmbtZ3zO44MgFg9Xn0=;
        b=liuBbhe78LBaUZO+CcwE7lkFzitSeYqVjddebt1bUxAxMmnhqFDppvW7Oxs4OL8Ey4
         oQBwDLrjVt4tQdlHUidcXk1YSlXE4RpYHurnz/QzRAzMBMecbKVyppctXGdH0rB+atBd
         Yn1EDv9ra9V0lSrk9fS11EaWOu8+RCvZBMizdj3vygciB0Zr/ihgBnGn3dEWW2zHEmYD
         6Xol+w9Iv+3OJUidXW4Ej9K4Q/8XkuBCA4UTnuFlV5zaM5bs/Xd8qMzi1E8KomD21vCE
         XVs8duj4Qfw5WoDsHe4ItwvnWvMgrRuupECwjFyUQXYuEGn4svejhx064Z8pXpUa3V+q
         mmbQ==
X-Gm-Message-State: AOAM533qsbGb/vv0/tLOWTKCaNVBMD5Fvek1lKV6/Fhbel89umsW4rY4
        UkQuWr+tEdVh4WDZfqx5Dan7Lg==
X-Google-Smtp-Source: ABdhPJzKirDhNxHPr/QyTkIdSv33BD090H9y9ZjpeGQ1HuIx6l9Aeva5X5RjqbW+SAPbDbVyGuTxww==
X-Received: by 2002:a63:ed03:: with SMTP id d3mr22686343pgi.24.1630351581085;
        Mon, 30 Aug 2021 12:26:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c11sm12229128pfm.55.2021.08.30.12.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 12:26:20 -0700 (PDT)
Date:   Mon, 30 Aug 2021 12:26:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>,
        Tim.Bird@sony.com, Shuah Khan <shuah@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernelci@groups.io,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Subject: Re: RFC - kernel test result specification (KTAP)
Message-ID: <202108301138.1354DA6AE@keescook>
References: <CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com>
 <202108272330.AE55FCD@keescook>
 <CAFd5g46etU+AZxUrRxkwb8eiauG2BxTrLSHByOv195A+Afr1iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g46etU+AZxUrRxkwb8eiauG2BxTrLSHByOv195A+Afr1iQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 30, 2021 at 10:34:14AM -0700, Brendan Higgins wrote:
> On Sat, Aug 28, 2021 at 1:20 AM Kees Cook <keescook@chromium.org> wrote:
> > Please keep me in CC for these kinds of proposals. And thanks for looking
> 
> Oh sorry, we will make sure to do that in the future. I figured most
> people who were interested who weren't directly CC'ed were on the
> kselftest list.

I mainly use mailing list member as a way to have thread history
available. I have too many subscriptions to read them all. :)

> > is that we already _have_ a specification, and it's already being parsed
> 
> We do?! Where is it? Can you link it here?

I am, perhaps, too glib. What I mean is that we have an
_implementation_, and we cannot create a specification that doesn't
match the existing implementation without very good reason.

> > by machines, so making changes without strong justification is going to
> > be met with resistance. :) So, with that in mind, on to my reply...
> 
> Of course, but if there is no specification or it is not being
> universally followed, then changes will need to be made, no?

Sure, but I'm being pragmatic: the implementation is already operating.
We can't pretend it doesn't exist. :)

> > The fundamental purpose of the kernel's TAP is to have many independent
> > tests runnable and parseable, specifically without any embedded framework
> > knowledge (or, even, any knowledge of TAP).
> >
> > The tests run by kselftest come from 2 different TAP-producing harnesses
> > (kselftest.h for C, kselftest/runner.sh for TAP-agnostic tests) as well
> > as several hand-rolled instances in Shell, Python, and C. There used to
> > be more, but I have been steadily fixing their syntax[2] and merging[3]
> > separate implementations for a while now.
> 
> Yep! And I believe there are still some inconsistencies - hence part
> of the motivation.

Agreed -- I'm happy to create a specification around what we _have_ (and
fix any existing mistakes). But the proposed spec very much did not
match what exists.

> > Maybe "TAP version Linux.1" ? I don't want to needlessly break existing
> > parsers.
> 
> "TAP version Linux.1" would not break existing parsers? If so, that
> would be great, I just expect that it would break them too.

https://metacpan.org/dist/Test-Harness/source/lib/TAP/Parser.pm
and
https://github.com/python-tap/tappy/blob/master/tap/parser.py
won't like anything non-numeric.

But neither have any idea about "#" nor nested tests either. (Those
considerations are entirely from the ability to construct automated
parsing of test-separated logs.)

LAVA doesn't parse the TAP line at all, as it chunks by known test
names, doing a simple mapping of name to outcome for the LAVA results:
https://github.com/Linaro/test-definitions/blob/master/automated/linux/kselftest/kselftest.sh

So, to that end, I guess "KTAP version 1" is fine.

> > >
> > > Plan lines
> > > ----------
> > >
> > > Plan lines must follow the format of "1..N" where N is the number of
> > > subtests. The second line of KTAP output must be a plan line, which
> > > indicates the number of tests at the highest level, such that the
> > > tests do not have a parent. Also, in the instance of a test having
> > > subtests, the second line of the test after the subtest header must be
> > > a plan line which indicates the number of subtests within that test.
> >
> > I do not want "subtests" as a specification concept, only "nested
> > tests".
> 
> Why not? I got the impression on the previous thread that everyone was
> amenable to this?

Because it breaks kselftests's agnosticism. More details on this
below...

> > The directive is a single word -- currently only "SKIP" is recognized
> > by TAP 14(?), but kselftest uses also XFAIL, XPASS, TIMEOUT, and
> > error. (Though I would love to hear what "error" is intended to be used
> > for, if different from regular "not ok".)
> 
> Can you explain (or link to documentation) on what these other directives mean?

I can link to code. :)

SKIP:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/kselftest.h?h=v5.14#n181
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/kselftest/runner.sh?h=v5.14#n84
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/arm64/bti/test.c?h=v5.14#n118

TIMEOUT:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/kselftest/runner.sh?h=v5.14#n87

XFAIL:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/kselftest.h?h=v5.14#n167

error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/kselftest.h?h=v5.14#n195

xpass (not actually a directive, and nothing uses it, I say we remove
it):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/kselftest.h?h=v5.14#n255

"exit=..." (improperly formed directive -- this should probably be
changed into a preceding diagnostic line)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/kselftest/runner.sh?h=v5.14#n89

Besides the two kselftest TAP harnesses, there are a few open-coded
TAP producers:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/arm64/bti/test.c?h=v5.14#n170
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/exec/binfmt_script?h=v5.14#n105
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/size/get_size.c?h=v5.14#n91
(This last one has a very confused idea about where to put the plan line.)

> > >
> > > Diagnostic lines
> > > ----------------
> > >
> > > Diagnostic lines are used for description of testing operations.
> > > Diagnostic lines are generally formatted as "#
> > > <diagnostic_description>", where the description can be any string.
> > > However, in practice, diagnostic lines are all lines that don't follow
> > > the format of any other KTAP line format.
> >
> > I still think there should be a distinction between "diagnostic lines"
> > and "unknown lines". For example, if kselftest is running on a console,
> > the dmesg output may be intermixed, and possibly temporally offset. Such
> > lines may not be useful, and may not be strictly correlated, where-as
> > the output from kselftest is at least self-consistent.
> 
> Interesting. I think David probably would have some thoughts here.

The intention with the current implementation is to be as robust as
possible against other lines of output existing, since kselftest output
ends up in weird places fairly regularly.

> > # FAILED: 85 / 87 tests passed.
> > # Totals: pass:83 fail:2 xfail:0 xpass:0 skip:2 error:0
> 
> Cool, any ideas on what we should do then? I personally don't have
> strong feelings on it.

For this? I say leave it diagnostic. These are mainly for humans to see
the results of a specific (usually long high-output) test run.

> > Also, parsers should treat a new "TAP version..." line at the same
> > nesting level as indication that the prior test has ended (and any tests
> > without result lines should be considered failed).
> 
> OK, that is definitely different. I think this will require some
> further discussion.

This is mostly about making good parsers. Parsers should be able to
understand enough context to gracefully recover from unexpected output.

> > Please no. There is no reason to force a nested test to suddenly have
> > to know about its test execution depth/environment. A subtest is just a
> > nested TAP result. That it is nested is only meaningful to the parser, not
> > the executing test, and it must have the same output, nested or not. (e.g.
> > running the test alone or running the test under a full kselftest run,
> > the only difference is the indentation level.)
> 
> Well it doesn't have to, right? The parent test can include the
> directive. In anycase, something has to know enough to print a test
> plan.

What happens in kselftest is that the kselftest harness has no idea
what is or isn't going to produce TAP output. That is an intentional
design goal of kselftest: authors should be able to drop a tool into
the tree that returns 0 for "success", and 1 for "failure". (The full
set of return codes is actually: "0" for "success", "4" for "skip",
"124" for "timeout", and anything else for failure.)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/kselftest/runner.sh?h=v5.14#n83

The runner can see how many binaries it expects to run in a given
directory, so it can build TAP output (with a plan line), for a
given directory. However, some of those tests have tons of output and
effectively have subtests -- but those binaries are _standalone_, in
the sense that they produce TAP output without any knowledge of their
surroundings. As such, the kselftest runner must indent them to make
the results parsable.

Having different output when in one harness or another has and will lead
to pain in comparing the results. So, a test run outside of kselftest
will be (should be) identical to running inside kselftest, but with
indentation.

We can _call_ this a subtest, but it's just nested. A subtest should not
need to know it is a subtest.

> > If nesting level is lost, a parser will understand the nested test to
> > have ended, but probably so did the test runner:
> >
> > TAP version 13
> > 1..1
> >     TAP version 13
> >     1..2
> >         TAP version 13
> >         1..3
> >         ok 1 - test_1
> >         ok 2 test_2
> >     not ok 1 - sub test unfinished plan
> >     ok 2 - test
> > not ok 1 - test_suite
> >
> > > Lastly, indentation is also recommended for improved readability.
> >
> > Indentation is _required_. :)
> 
> KUnit cannot support indentation being required. We print test results
> to dmesg. At anytime something could get printed to dmesg that could
> potentially mess up indentation.

Can you explain this? KUnit controls what it prints, yes? Anything
outside of the TAP output is an "unknown line". This is why I used "#"
for indentation: it is distinguishable from "unknown (dmesg) lines".

> The problem that was recognized, as I understand, was that there are
> multiple "interpretations" of TAP floating around the kernel and that
> goes against the original point of trying to standardize around TAP.

Right -- this is the part I disagree with. There is 1 interpretation,
and a couple mistakes in the various kernel implementations. Let's get
that documented first.

> I know KUnit's usage is pretty minor in comparison to kselftest, but
> people do use it and there is no point in us, KUnit, purporting to use
> TAP and remain compatible with any particular version of it if it is
> incompatible with kselftest's TAP.

I have tried to keep the kernel's TAP output parsable by TAP 13
consumers. I don't think we have much of a fork currently (the
diagnostic lines are a simple addition, and the nesting is trivially
extractable with no additional knowledge beyond recognizing the "TAP"
line within diagnostic lines).

> Additionally, there is no way that we are going to be able to stay on
> a compatible implementation of TAP unless we specify what TAP is
> separate from the implementation.

My goals are:

- have kernel test output (and nest test output) parsable by existing
  tools, with a strong desire to not break LAVA (though arguably LAVA
  isn't a TAP parser).

- have kernel test output distinguishable from unrelated dmesg output
  since kselftest is very frequently collected from the console.

- not needlessly break existing tooling without showing a meaningful
  benefit. (i.e. flag days in parsing under LAVA has been difficult,
  and I want to minimize those.)

- be able to map meaningful test execution state to a common set of
  states ("ok" and "not ok" are rarely sufficient), which includes
  timeouts, expected failures (e.g. missing CONFIG_*s, wrong arch,
  etc).

- be able to include diagnostic runtime output _in the test result_,
  because too frequently the binary yes/no of a test is way to far away
  from the actual test details, which make debugging extremely
  difficult.

-- 
Kees Cook
