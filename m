Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4EA201B71
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 21:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389745AbgFSTkI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 15:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389005AbgFSTkI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 15:40:08 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44F1C0613EE
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 12:40:06 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l24so4921237pgb.5
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 12:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sX1c9FKybz5ArwGZsmczF2qzdLUq4rRk/oQnybs6nAA=;
        b=Zyhih7gCW1Rw5b2dY839uPGQNBaD8BZ/7M30FwYAbVf7zxQ38XLRJrw7wQzQ6q627B
         HHlYY4cKIoMgxOsRISu101Gba9Djfr5m7SDoxHltoCPw99Knu6jmrki8FaKuRxfcjDhK
         yCTNxuh1Swd4l9bV0IClEPRNt4WQA2kz1NMvJO/L8RfIOHtX+oJtp/BAoj3twu58LdMN
         +3hN5mPICWMPRzmgHNUFA9pA4/f7V+U7IyVPHMD3p2kvCTZXh+JEk+KHkT8OHE3veNbY
         fADC6kNRhruXT3z3xT64FthvqeoqMcyBoSn69aFBypDP2Etsorlfpi6C5uVOcVIQfXFa
         St0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sX1c9FKybz5ArwGZsmczF2qzdLUq4rRk/oQnybs6nAA=;
        b=CynplzvKPyag0ZwW/O7m5w6cW8OwPgCQIChOdTRv2BtfqeVVU4ltcJ28h0LOAmSlnv
         zp4i02s/IzuIxPN6IkxD5zrYp3s3a9N5yIpzXqbIFQUi4SnPeUAg6IabOaUfkMgByOzF
         Jyg1nYG4M8iB2yMXPXJXGLohU0dYirkHNhYE69tcRxcMUArGoTx9c6QGGbktC8VJo7h4
         b2/qRj+OCrTF604OyPVpITdhmKNzuNo+v1dFlhjOb6Hhr9HP4p7Gbx64vkj3sr2jpQ3M
         aCr2TDFILkKKHJTVG4ayEm/dczkpwsspG9rp41lV6FELLHdApzjCUwGxt0WDn4GLEPki
         yVlA==
X-Gm-Message-State: AOAM532n5snsw2N8M72+okBOZQYD0eKX+xWR78qDGhFI1enKmhIsvYCL
        ahENUPu/kQdyjq9VMwiQUFdilj4CgTS9PtkWJA/fcQ==
X-Google-Smtp-Source: ABdhPJyJnniJbG3habLLAfMpUidGHy8a1ZGt/i1Hk+hJyhz9BpuOxYBBz/0l4p7chYrmHj00hvuw3ZrKBUsIqj4seoo=
X-Received: by 2002:a62:216:: with SMTP id 22mr9339339pfc.106.1592595604611;
 Fri, 19 Jun 2020 12:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200616204817.GA212825@google.com> <CY4PR13MB1175A71AE3937C0786721ABFFD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
In-Reply-To: <CY4PR13MB1175A71AE3937C0786721ABFFD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 19 Jun 2020 12:39:53 -0700
Message-ID: <CAFd5g44fueJUMYxWoEa6YEW_9+LjZ7XWQQB17e1cQtZ911KBWg@mail.gmail.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 16, 2020 at 2:16 PM Bird, Tim <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Brendan Higgins
> >
> > On Wed, Jun 10, 2020 at 06:11:06PM +0000, Bird, Tim wrote:
> > > Some months ago I started work on a document to formalize how
> > > kselftest implements the TAP specification.  However, I didn't finish
> > > that work.  Maybe it's time to do so now.
> > >
> > > kselftest has developed a few differences from the original
> > > TAP specification, and  some extensions that I believe are worth
> > > documenting.
> > >
> > > Essentially, we have created our own KTAP (kernel TAP)
> > > format.  I think it is worth documenting our conventions, in order to
> > > keep everyone on the same page.
> > >
> > > Below is a partially completed document on my understanding
> > > of KTAP, based on examination of some of the kselftest test
> > > output.  I have not reconciled this with the kunit output format,
> > > which I believe has some differences (which maybe we should
> > > resolve before we get too far into this).
> > >
> > > I submit the document now, before it is finished, because a patch
> > > was recently introduced to alter one of the result conventions
> > > (from SKIP='not ok' to SKIP='ok').
> > >
> > > See the document include inline below
> > >
> > > ====== start of ktap-doc-rfc.txt ======
> >
> > [...]
> >
> > > --- from here on is not-yet-organized material
> > >
> > > Tip:
> > >  - don't change the test plan based on skipped tests.
> > >    - it is better to report that a test case was skipped, than to
> > >      not report it
> > >    - that is, don't adjust the number of test cases based on skipped
> > >      tests
> > >
> > > Other things to mention:
> > > TAP13 elements not used:
> > >  - yaml for diagnostic messages
> >
> > We talked about this before, but I would like some way to get failed
> > expectation/assertion information in the test in a consistent machine
> > parsible way. Currently we do the following:
> >
> >     # Subtest: example
> >     1..1
> >     # example_simple_test: initializing
> >     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
> >     Expected 1 + 1 == 3, but
> >         1 + 1 == 2
> >         3 == 3
> >     not ok 1 - example_simple_test
> > not ok 5 - example
> >
> > Technically not TAP compliant, but no one seems to mind. I am okay with
> > keeping it the way it is, but if we don't want it in the KTAP spec, we
> > will need some kind of recourse.
>
> So far, most of the CI systems don't parse out diagnostic data, so it doesn't
> really matter what the format is.  If it's useful for humans, it's valuable as is.
> However, it would be nice if that could change.  But without some formalization
> of the format of the diagnostic data, it's an intractable problem for CI systems
> to parse it.  So it's really a chicken and egg problem.  To solve it, we would have
> to determine what exactly needs to be provided on a consistent basis for diagnostic
> data across many tests.  I think that it's too big a problem to handle right now.
> I'm not opposed to migrating to some structure with yaml in the future, but free
> form text output seems OK for now.

Well as long as everyone is cool with it for now we can put the
problem for later.

> > >    - reason: try to keep things line-based, since output from other things
> > >    may be interspersed with messages from the test itself
> > >  - TODO directive
> >
> > Is this more of stating a fact or desire? We don't use TODO either, but
> > it looks like it could be useful.
> Just stating a fact.  I didn't find TODO in either KUnit or selftest in
> November when I initially wrote this up.  If TODO serves as a kind
> of XFAIL, it could be useful.  I have nothing against it.

Fair enough.

> > > KTAP Extensions beyond TAP13:
> > >  - nesting
> > >    - via indentation
> > >      - indentation makes it easier for humans to read
> > >  - test identifier
> > >     - multiple parts, separated by ':'
> >
> > Can you elabroate on this more? I am not sure what you mean.
> An individual test case can have a name that is scoped by a containing
> test or test suite.  For example: selftests: cpufreq: main.sh
> This test identifier consists of the test system (selftests), the test
> area (cpufreq), and the test case name (main.sh).  This one's a bit
> weird because the test case name is just the name of the program
> in that test area.  The program itself doesn't output data in TAP format,
> and the harness uses it's exit code to detect PASS/FAIL.  if main.sh had
> multiple test cases, it might produce test identifiers like this:
> selftests: cpufreq: main: check_change_afinity_mask
> selftests: cpufreq: main: check_permissions_for_mask_operation
> (Or it might just produce the last part of these strings, the
> testcase names, and the testcase id might be something generated
> by the harness or CI system.)

+Alan Maguire

Aha, that is something we (Alan, David, Kees, and myself) were talking
about on another thread:

https://lore.kernel.org/linux-kselftest/CABVgOSnjrzfFOMF0VE1-5Ks-e40fc0XZsNZ92jE60ZOhYmZWog@mail.gmail.com/T/#m682be9f9103f7b363b702e49c137d83a4833fcae

I think that makes a lot of sense if it isn't too hard in practice.

> The value of having a single string to identify the testcase (like a
> uniform resource locator), is that it's easier to use the string to
> correlate results produced from different CI system that are executing
> the same test.

Makes sense.

> > >  - summary lines
> > >    - can be skipped by CI systems that do their own calculations
> > >
> > > Other notes:
> > >  - automatic assignment of result status based on exit code
> > >
> > > Tips:
> > >  - do NOT describe the result in the test line
> > >    - the test case description should be the same whether the test
> > >      succeeds or fails
> > >    - use diagnostic lines to describe or explain results, if this is
> > >      desirable
> > >  - test numbers are considered harmful
> > >    - test harnesses should use the test description as the identifier
> > >    - test numbers change when testcases are added or removed
> > >      - which means that results can't be compared between different
> > >        versions of the test
> > >  - recommendations for diagnostic messages:
> > >    - reason for failure
> > >    - reason for skip
> > >    - diagnostic data should always preceding the result line
> > >      - problem: harness may emit result before test can do assessment
> > >        to determine reason for result
> > >      - this is what the kernel uses
> > >
> > > Differences between kernel test result format and TAP13:
> > >  - in KTAP the "# SKIP" directive is placed after the description on
> > >    the test result line
> > >
> > > ====== start of ktap-doc-rfc.txt ======
> > > OK - that's the end of the RFC doc.
> > >
> > > Here are a few questions:
> > >  - is this document desired or not?
> > >     - is it too long or too short?
> > >  - if the document is desired, where should it be placed?
> >
> > I like it. I don't think we can rely on the TAP people updating their
> > stuff based on my interactions with them. So having a spec which is
> > actually maintained would be nice.
> >
> > Maybe in Documentation/dev-tools/ ?
> I'm leaning towards Documentation/dev-tools/test-results_format.rst

SGTM.

> > >    I assume somewhere under Documentation, and put into
> > >    .rst format. Suggestions for a name and location are welcome.
> > >  - is this document accurate?
> > >    I think KUNIT does a few things differently than this description.
> > >    - is the intent to have kunit and kselftest have the same output format?
> > >       if so, then these should be rationalized.
> >
> > Yeah, I think it would be nice if all test frameworks/libraries for the
> > kernel output tests in the same language.
> Agreed.

Cheers
