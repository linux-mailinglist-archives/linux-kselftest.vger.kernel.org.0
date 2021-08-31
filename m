Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B033FC3ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Aug 2021 10:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbhHaHrc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Aug 2021 03:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239641AbhHaHrb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Aug 2021 03:47:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054A8C061575
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Aug 2021 00:46:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m9so1727438wrb.1
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Aug 2021 00:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4Mf/IN4M5GnVh5t8C6PhxfGOdcNhS1qWOCXvbd41WI=;
        b=NKNyeFuNqK0lHQHjKZ374Ofi9rDbadD8LoKaCb1BW/ayzQlh6tbXP4TdP02gnF5aHn
         yhGBBCVk0ZcimoYHXJ0kfh3TnTEXzSKLWu/2Mucewwy2MOM6LfuQLe+ciIPZp9W5S3+T
         M42TppNhked3ac+nlVpBNoBq9l1xQfrvvsPh4LToZlBH7YqRoYcun6LAXaz49F1lKOL9
         hE+fO1eFScuXcggUKgjCM78SxLmhZoOBlNKSjCIJivYWl8Tr7c7AeuG4e4TISGxP2YjL
         E/gmHwnpuEPodbGPp/HBmX8LOXsB1j7BWp1hijTX5BQB/AqEUd0q9H2lljkmDnEngdWc
         fh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4Mf/IN4M5GnVh5t8C6PhxfGOdcNhS1qWOCXvbd41WI=;
        b=sT91uA1iaLIJhAABpgQLFgHMGU5m76CnSWTbdvc5kUTcyz7m7lJ3bYTYZVbedCA/JH
         cf9QPq+h0VLc1YJSF6w+uY1OeIrFgbGvz2soB+CJeJNlg1ewJrnzAwrEtZ78Yab6bFCC
         18HAPxFLraL5ykLdiThbpsrTtITuSGhCpapBk+PAcnSV2/SUTgr4mNdN6EDsr4DnlnUp
         UFrR5gjJ0Ku1/wTi7gIJX5h4LWcEvIuvTdjzjU0W78oDBV873uyeOyD//BM6UY9gtmWd
         OAKLW6QNfU7AiUQiuukI0eDG8+HyekyDDGqE9jHedb1TlM3M8muAaFAUDg1RNiwRaE+u
         vcvQ==
X-Gm-Message-State: AOAM530LPXT0tEDZye8xnKpMNsJLzfkW+wfTIGBM/Xa1ue9cMBgQgKF0
        blU+i/+G8J+GVGjMu2tLSVDPPUSmrsqiyfLT1m6LRBDAQKhSjB5V
X-Google-Smtp-Source: ABdhPJzH3xF5a6sLdm0bM/0NXWrS/zc+llMEgFoUt4Dj7D3eNEh4AndEVb+LAMKrZNIoekvlwgHZXSnjsEXNjMMyVzc=
X-Received: by 2002:adf:f08b:: with SMTP id n11mr28880167wro.176.1630395994078;
 Tue, 31 Aug 2021 00:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com>
 <202108272330.AE55FCD@keescook> <BYAPR13MB2503A4B79074D8ED5579345DFDCB9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <202108301226.800F3D6D4@keescook> <BYAPR13MB25037E7EE38DE8717DC7D254FDCB9@BYAPR13MB2503.namprd13.prod.outlook.com>
In-Reply-To: <BYAPR13MB25037E7EE38DE8717DC7D254FDCB9@BYAPR13MB2503.namprd13.prod.outlook.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 31 Aug 2021 15:46:22 +0800
Message-ID: <CABVgOSmH2VnHxH-eNdKKv2HuNZTVHbvKVkkCSXSPq6wEnF-JLg@mail.gmail.com>
Subject: Re: RFC - kernel test result specification (KTAP)
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelci@groups.io,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 31, 2021 at 6:04 AM <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Kees Cook <keescook@chromium.org>
> >
> > On Mon, Aug 30, 2021 at 05:48:07PM +0000, Tim.Bird@sony.com wrote:
> > > From: Kees Cook <keescook@chromium.org>
> > > > > Test case result lines
> > > > > ----------------------
> > > > >
> > > > > Test case result lines must have the format:
> > > > >
> > > > >     <result> <number> [-] [<description>] [<directive>] [<diagnostic data>]
> > > >
> > > > "[<diagnostic data>]" is not defined below. I think what you mean is
> > > > "directive details".
> > >
> > > IMHO it's useful to keep this called 'diagnostic data'.
> > >
> > > The directive is optional, and having this be diagnostic data means you can
> > > put explanatory text, or result details, that are independent of the description,
> > > on the same line as the result.  This is convenient in some cases.
> > >
> > > I think diagnostic data should always be prefixed by a hash sign.
> > > Or, in the case where diagnostic data appears on the result line,
> > > the hash serves as the delimiter.  This means that the description
> > > text must not include a hash character.
> > >
> > > For example:
> > > ok 5 - check return code # rcode=0
> > > or
> > > not ok 5 - check return code # rcode=17
> >
> > The directive is currently used to answer the question "why?" as in,
> > "why is this test not ok?" ("a timeout occurred") or "why is this test
> > ok?" ("a SKIP")
> >
> > The "supporting evidence" for the "why?" answer are specific details
> > about that: "the exit was was NNN" or "the timeout was YYY seconds".
> >
> > Test diagnostics are all the lines preceding that (currently prefixed
> > with a "#").
> >
> > > > Yes, though the optional "- " is strictly part of the optional
> > > > description.
> > >
> > > It's mildly annoying that "-" is optional.  It's trivial to deal with in the parser
> > > to just ignore it if it's present.  But it has no semantic meaning whatsoever.
> > > IMHO it would be nice to either mandate it or remove it, for consistency's sake.
> > > This could be based solely on the consensus for whether it added or detracted
> > > from human readability, since parsers don't care.
> >
> > I have no strong opinion on the "-". I was surprised to encounter it
> > as it's not part of the TAP 13 spec. I would prefer to drop it, if I had
> > to choose.
> >
> > > ERROR usually means that there was some kind of failure
> > > in the testing process that makes the testcase result indeterminate.
> > > (like loss of connection to a server, or crash of the program executing
> > > the testcase).  This can be due to a bug in the test or the test system.
> > > I'm, not sure if ERROR is used this way in kselftest.  It is, IMHO, a useful
> > > distinction to make.  TIMEOUT is a special case of ERROR, IMHO.
> >
> > Well, I think TIMEOUT is a "why not ok?" answer. "not ok" seems to be
> > the same as ERROR, but I guess it's really a catch-all, but must come
> > with the "evidence" portion:
>
> 'not ok' should not mean the same thing as ERROR.  'not ok' means the
> testcase was run successfully, and the result is that the test determined
> that the testcase failed.  ERROR means that the testcase was not
> run successfully, so no result can be assumed.
>
> But ERROR is confusing.  Maybe there's a better word for the concept
> that is less likely to be conflated with the result.
>

In KUnit, we've largely used ERROR to refer to test cases with
malformed or corrupted output (e.g. the test code crashed, or there
are missing results according to the test plan, etc). Otherwise, the
test fails (or is skipped, in some circumstances).
This means that it's not been something tests explicitly sets, it's
something the parser outputs. That's obviously less of a sensible
thing for kselftest, which doesn't provide its own TAP parser (though
the bits of test harness code could maybe try to output something if a
subprocess failed, or the like.)

> >
> > not ok 1 description goes here # TIMEOUT 45 seconds with no results
> > not ok 1 description goes here # ERROR lost connection to server
> > not ok 1 description goes here # ERROR non-zero exit code: NNN
> >
> > I might go so far as to say the directive is _required_ for the "not ok"
> > state.
> As I said above, I don't think they are the same.  I would reserve
> ERROR for the case where a test error occurred and the test case
> result could not be obtained.
>
> If we go to the trouble of making our own spec, maybe it would
> be better to support a third result value: 'unknown'.  This would
> break all the TAP parsers, but it's much clearer, IMHO.
>
> 'ok 1 description' = test case executed successfully, and the testcase condition passed
> 'not ok 1 description' = test case executed successfully, and the testcase condition failed
> 'unknown 1 description # SKIP # reason' = test case does not apply for some reason
> 'unknown 1 description # ERROR # reason' = test case could not be executed, for some reason
>
> In the case of SKIP and ERROR, the result should be ignored as it is either inapplicable
> or wasn't obtained.
>
> I remember we had a discussion about whether SKIP should have an "ok" or "not ok"
> result.  IMHO it doesn't matter, because the result has no meaning when a SKIP directive
> is used.  (Although it's useful for humans to see why something was skipped.)
>

My feeling is that if we deviate from TAP enough to add another result
value, let's just make "skip" (and maybe "error", "xfail", "xpass" if
they make sense) it's own value rather than writing "unknown".

> >
> > > As an aside, I've never liked XFAIL or XPASS.  Semantically, I believe they
> > > are quite confusing, and depend on the level of testcase execution.  XPASS is also
> > > redundant.  Isn't the default case always XPASS?
> >
> > Nothing currently uses XPASS, and we should remove it.
> >
> > XFAIL capture the condition of the test logic in that a test for
> > something arm64-specific on a non-arm64 machine is _not_ a "pass". It
> > will fail. But it's an expected failure. And, as a directive, must come
> > with the evidence bit:
> >
> > not ok 1 PAN catches bad accessg # XFAIL PAN CPU feature is arm64 only
> >
> > As a test author, I want to see this as distinct from failure and
> > success.
> I agree that this case is different from a normal failure.
>
> In the example you provide of a feature that applies to only specific
> architectures, I would use a SKIP instead.  It's not that the testcase failed.
)> It's that it does not even make sense for the device under test.
>
> Whether something is 1) a testcase failure or 2) a testcase that does not
> apply is a matter of perspective.  Is it the case that the feature should  exist
> on all architectures,  and it's just not been written yet?  I could call this a
> 'not ok' or an XFAIL. However, if it's a feature that is never intended to be
> written for arm32 or i386,  I would report that as a SKIP.
>
> But all of this differs from what I originally described, which is labs using
> XFAIL to annotate bugs that they knew about but didn't intend to fix.
>

IIRC, the TAP spec specifies a TODO which is basically the same thing
as this. We haven't implemented either it or XPASS/XFAIL in KUnit,
though.
(I tend to agree that this is a nicer thing to have in a separate
layer, rather than the tests themselves, but can see the argument for
not wanting another list somewhere.)

> >
> > > In the case of XFAIL, does it mean that an operation that was expected to fail
> > > all the time, failed, and so the test passed?  Or does it mean that this is a known
> > > bug that a particular developer or site has decided to ignore (as in "we know this
> > > is a bug, but we expected it to fail, so just ignore it for now).  The latter, I really
> > > don't think should be encoded in the tests themselves, but should be put
> > > into a layer above the test and parser, that is applied according to developer
> > > or testlab policy.
> >
> > I agree that "just ignore it for now" shouldn't be there.
> >
> > Other arguments are that xfail tests shouldn't be run at all, but I
> > don't think that's right because it makes it very hard to do large-scale
> > test result comparisons because random stuff is missing, depending on
> > various configs, archs, etc. It blocks a 1-to-1 comparison, and begs
> > questions like "why is the test here in one case and not in another?"
> I completely agree with this.  It really messes up tables of results when
> the list of testcases varies depending on some board
> or configuration attribute.  It's very hard for users to parse and compare
> results in that case.
>
> > where as an XFAIL will encode the reason it is an XFAIL in its output,
> > providing a self-documenting test result.
>
>
> >
> > > > I still think there should be a distinction between "diagnostic lines"
> > > > and "unknown lines". For example, if kselftest is running on a console,
> > > > the dmesg output may be intermixed, and possibly temporally offset. Such
> > > > lines may not be useful, and may not be strictly correlated, where-as
> > > > the output from kselftest is at least self-consistent.
> > >
> > > I think this would be a very good distinction to make.  You might have
> > > unknown lines that (inadvertently?) start with a hash, but trying to
> > > make sure that the test itself always outputs diagnostic data with a preceding
> > > hash gives a reader potentially more information about where the message
> > > came from, and could be useful.
> >
> > Right, so lines with a hash shouldn't be machine-parsed. (And this is a
> > mistake I made in the current kselftest output for the LAVA parser.) The
> > good news for the kernel, is that nothing else in dmesg leads with a
> > "#" currently. :)
>
> Oh. That's actually nice to know.  Interesting.
>

If this is the case, I'm tempted to want a "#" in front of all KTAP
lines, just so that we have an easy way to isolate test output in
general (including the machine-parsable bits).

> >
> > > > No; diagnostic lines must have no meaning: they are for humans and nothing
> > > > else. If other details are needed for machines, we should explicitly
> > > > create new format lines. I made a mistake when I used a diagnostic line
> > > > for embedding the test names. :( There is a need for parsers to discover
> > > > the name of a given test, though, so we do likely need something for this.
> > >
> > > I agree it is handy to have the test name for sub-tests.  However, I don't
> > > see any semantic difference whether we define sub-test declarations via
> > > diagnostic lines with special syntax or by creating a new syntax separate
> > > from diagnostic lines.  Either way, we have a new syntax for parsers to
> > > understand.
> >
> > Pragmatically, I agree, which is what lead me to my mistake. However, in
> > reconsidering it, I realize this leads to a slippery slope of just
> > dumping stuff into diagnostic lines and pretending nothing will read it.
>
> Good point.  Whether it starts with a hash or not, TAP 13 parsers should
> ignore anything that is not a result line (starts with 'ok' or 'not ok').
> So I guess we are free to make a new syntax without upsetting any existing
> parsers.
>

TAP 14 definitely parses a few things other than just the result line
(including some which start with '#'), but it does look like no-one
liked TAP 14 enough to finish the spec and use it (other than KUnit
stealing some ideas from it).

> >
> > I suspect what we need is an optional "starting test" line, like:
> >
> > test N DESC
> > # diag...
> > # diag...
> > # diag...
> > ok N
> >
> > The nesting looks like:
> >
> > TAP version 13
> > 1..3
> > test 1 seccomp
> > # TAP version 13
> > # 1..27
> > # test 1 prctl
> > # ok 1
> > # test 2 strict
> > # ok 2
> > # ...
> > # test 27 user_notif
> > # # eek missing CONFIG_....
> > # not ok 27 user_notif # ERROR can't use ioctl
> > not ok 1 seccomp # ERROR non-zero exit code 1
> > test 2 netfilter
> > ok 2 netfilter
> > test 3 bpf
> > # exciting things happen
> > ok 3 bpf
> >
> > This is what we have now except basically just replacing "# $name" with
> > "test $num $name"
> >
> Actually, I like this idea.  Including the number is a nice touch.
> I think that will help to distinguish such a line from other 'unknown line' output.
> I don't know if I'd leave the description off of the result line, though.
> A lot of parsers are looking for that.
>

Yeah, this is something I'd quite like, personally. If we're prepared
to deviate from TAP this much, having the name/description of the test
before getting the results makes it easier to read. I'd agree with
keeping the description on the result line, too: not only is it what
existing parsers are looking for, it makes reading the results
manually much nicer.

> > > >
> > > > > Diagnostic lines of the format "# Subtest:
> > > > > <test_name>" indicate the start of a test with subtests. Also,
> > > > > diagnostic lines of the format "# <test_name>: <description>" refer to
> > > > > a specific test and tend to occur before the test result line of that
> > > > > test but are optional.
> > > >
> > > > I don't think the above should be included in the spec -- diag lines
> > > > should have no parseable meaning.
> > > >
> > > > >
> > > > > Bail out line
> > > > > -------------
> > > > >
> > > > > A bail out line can occur anywhere in the KTAP output and will
> > > > > indicate that a test has crashed. The format of a bail out line is
> > > > > "Bail out! [<description>]",  where the description can give
> > > > > information on why the bail out occurred and can be any string.
> > > >
> > > > I'm not a fan of the Bail out line. It's not a problem, exactly, but I
> > > > find it redundant. If we want an "end of test" line, let's make one.
> > > > "Bail out" is a special case of exit. If we want to handle test exit,
> > > > let's define it. E.g. make kselftest's test summary lines not
> > > > diagnostic lines:
> > > >
> > > > # FAILED: 85 / 87 tests passed.
> > > > # Totals: pass:83 fail:2 xfail:0 xpass:0 skip:2 error:0
> > >
> > > How consistent is it for selftests to produce test summary lines?
> >
> > Any of the tools built with kselftest.h will spit it out. (Which is to
> > say several of the "subtests".) The bulk of kselftest output is from the
> > runner, which doesn't produce this summary.
> >
> > > > Please no. There is no reason to force a nested test to suddenly have
> > > > to know about its test execution depth/environment. A subtest is just a
> > > > nested TAP result. That it is nested is only meaningful to the parser, not
> > > > the executing test, and it must have the same output, nested or not. (e.g.
> > > > running the test alone or running the test under a full kselftest run,
> > > > the only difference is the indentation level.)
> > > I agree that the sub-test should not know about this line.  I thought
> > > the "parent" test wrote the line.
> >
> > The suggestion was that the subtest should _not_ emit the "TAP" line,
> > which is what I strongly disagree with: it should be a self-contained
> > TAP-emitting test.
>
> OK - agreed.  Yes.  The sub-test should not know whether they are running
> standalone or nested (with the exception of some line prefix opaquely conveyed
> to them)
>

Yeah, this all came from the TAP 14 spec. In KUnit it's not a problem,
as the harness does all of the printing of these headers, so the test
code itself never has to worry about it. It does make more sense for
kselftest to make tests more independent, though, so let's leave the
TAP header line in.

My only concern here is that this could complicate attempting to parse
multiple test suites in the same output slightly:
e.g., if we just grep the input naively for "TAP version blahdiblah",
then parse whatever we get, there's a possibility we could
double-parse nested results.

We don't hit this at the moment, though, and it could be worked around
pretty easily, so I don't think it's worth holding back something
which otherwise works.

> >
> > > > Again, I see only downsides to this. Nesting for the spec is simple
> > > > indentation-based recursion. Let's just keep what we already have:
> > > >
> > > > TAP version 13
> > > > 1..1
> > > > # TAP version 13
> > > > # 1..2
> > > > # ok 1 - test_1
> > > > # ok 2 - test_2
> > > > ok 1 - test_suite
> > >
> > > I prefer spaces, but whatever.  Is the prefix on the 'TAP version 13' line guaranteed
> > > to be the prefix on all lines for the (sub-)test?
> >
> > That's the current implementation, yes.
> >
> > As for tabs vs spaces, I think it's fine to swap "# " for "  ". We just
> > need to patch LAVA to deal with it.
> >
> > > Just as a side note, in some Fuego tests, it was very useful to include an identifier
> > > in thethe prefix nested tests.  The output looked like this:
> > >
> > > TAP version 13
> > > 1..2
> > > [batch_id 4] TAP version 13
> > > [batch_id 4] 1..2
> > > [batch_id 4] ok 1 - cyclictest with 1000 cycles
> > > [batch_id 4] # problem setting CLOCK_REALTIME
> > > [batch_id 4] not ok 2 - cyclictest with CLOCK_REALTIME
> > > not ok 1 - check realtime
> > > [batch_id 4] TAP version 13
> > > [batch_id 4] 1..1
> > > [batch_id 4] ok 1 - IOZone read/write 4k blocks
> > > ok 2 - check I/O performance
> > >
> > > Can I propose that the prefix not be fixed by the spec, but that the spec indicates that
> > > whatever the prefix is on the TAP version line, that prefix must be used with the output for
> > > all lines from the test (with the exception of unknown lines)?
> >
> > Oh, interesting. This would also allow parallel (unique) test execution
> > to be parsable. That sounds workable. (Again, this needs LAVA patching
> > again...)
> >
> > > > > Major differences between TAP 14 and KTAP specification
> > > > > -------------------------------------------------------
> > > > >
> > > > > Note that the major differences between TAP 14 and KTAP specification:
> > > > > - yaml and json are not allowed in diagnostic messages
> > > >
> > > > Agreed -- these are overkill (and very difficult to implement as they
> > > > _follow_ the test result line: anything generating them has already
> > > > finished running).
> > >
> > > I thought that some tests put the diagnostic data before the result line.
> > >
> > > I don't care whether it is before or after (and indeed Fuego's parser
> > > can handle either case).  But it can't handle it when some testcases
> > > put diagnostic data before the result line, and some testcases put
> > > it after, in the same test.  There's no delimiter for the separation
> > > between the two different testcases diagnostic data.
> >
> > Right. The current implementation puts it always before. TAP 13 (14?) has
> > the YAML _after_ the results line, but that's totally unworkable for
> > kselftest, which is designed to be first human readable and second machine
> > readable. Waiting to see diagnostics from a slow test is terrible --
> > we can't collect it and spit it out later. Also, a parser would have
> > no idea about when a test is finished if diagnostics follow the last
> > test result of a plan.
> >
> > Making it "always before" is fine by me, and the motivation for making
> > the "summary" lines be non-diagnostics because they technically followed
> > the last test result.
> >
> > > Could we possibly have a rule about diagnostic lines positioning relative
> > > to the testcase result line?  Maybe a rule like this:  For a single test,
> > > diagnostic lines should either always preceded the testcase they
> > > are related to, or follow the testcase they are related to.
> >
> > For the kernel, I would rather avoid anything after because that just
> > confuses things.
> >
> > > > Yes. (Though "exit=" is a mistake in runner.sh -- this should probably
> > > > be reported without the '#')
> > >
> > > Please No!  (Unless I'm misinterpreting that line).
> > >
> > > If you remove the '#', that makes the 'exit=127' part of the test description.
> > > The test description should be invariant between success and failure cases.
> > > The exit=127 (if I'm reading that line right) is part of data explaining or
> > > describing the failure. It would be 'exit=0' if the test succeeded.
> > >
> > > In order to correlate test cases (ie show results over time), the description
> > > should not change from one invocation of the test to the next.  At least Fuego
> > > uses the test description this way.  That is, the testcase description is used as
> > > a testcase identifier, and if it changes from run to run things get confusing.
> >
> > Agreed, I think it should be part of an ERROR directive:
> >
> > not ok 14 awesome test # ERROR exit=127
>
> As long as the line above means that testcase '14 awesome test' could not be
> run, and exit=127 helps diagnose that, then I agree.  If 'exit=127' means that
> testcase '14 awesome test' was run and exit=127 was a failing result, I would
> say that the result line should just be:
> not ok 14 awesome test # exit=127

I think this is fine, though I don't think it gives us that much more
over just making the last diagnostic line "# exit=127".
If we make "skip" and the like first-class results, that makes this
even simpler, of course.


-- David
