Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0B51F8A26
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jun 2020 20:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgFNSjs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 Jun 2020 14:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNSjr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 Jun 2020 14:39:47 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DAEC08C5C2
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Jun 2020 11:39:46 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id h185so6827663pfg.2
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Jun 2020 11:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=19HC7VZegAFMIrVuT1WO9vNsblblWVfvq+qakcPsIak=;
        b=F6H+BuG9wTvKTPAy8s8vLiyk2/w6yHtrCtpQTfexslP/WUr6JNSD1LCpm3rLd1kHrQ
         ScPgWtHpj/PzaEFTzFoxPOibgmJFJTGOeeGFbm58OGXX4cZm2kJuQi6bURpfOnuqN8iR
         5C9Arjkf7i8fORZjmmJguRBB4x+mMlQk64fqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=19HC7VZegAFMIrVuT1WO9vNsblblWVfvq+qakcPsIak=;
        b=DzDLdqFlpdw0MU2aCC1h5LZbj8zVEHA6FQ8sZkuR/8XzTJ/15YykJlY+StugXk9TbU
         xLPGVxiurp+/w5ABn2oC0qvTgt80PKQtaIi06qtI32D69pYhAddXUIts9doEgSY7I0n8
         2JF+SAvsQb5QfGLeHlvwRB1OLmBt42Ld7Wrd8NkgeNc8cEfxX98a0HKxHAeFRyfCm56M
         2c/uR4OUt2AMWb1V1hmdcSWveSI9WtZ0HKGFZneJPIAqsDdRz76Gv3+nBxZXID3oB+T1
         e4j5iYweYcwHIk1OfIh+HM1LhJ3v45fbP11C0rZw42B41KddxveZw2NStfGDd+MkS7yn
         lpeQ==
X-Gm-Message-State: AOAM530P3RnkCKccQ1h1KoCA4XVQg7tbkjovHIVTN/ZHbS8APpPXkyIg
        qP5IMJ0Hn97wUm7SjgPhdjHM7KJ00EqIRQ==
X-Google-Smtp-Source: ABdhPJxd3o+Zafq2+WNV78yg/XVCUpMrONSHsagkLDCLQQB6DK5Rs02u8CD1pIWebDWpd/Wlm4HIkQ==
X-Received: by 2002:a63:3384:: with SMTP id z126mr18464190pgz.7.1592159985837;
        Sun, 14 Jun 2020 11:39:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id hi19sm10281005pjb.49.2020.06.14.11.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 11:39:44 -0700 (PDT)
Date:   Sun, 14 Jun 2020 11:39:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
Message-ID: <202006141120.96FF8C5@keescook>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 10, 2020 at 06:11:06PM +0000, Bird, Tim wrote:
> The kernel test result format consists of 5 major elements,
> 4 of which are line-based:
>  * the output version line
>  * the plan line

Note: making the plan line required differs from TAP13 and TAP14. I
think it's the right choice, but we should be clear.

>  * one or more test result lines (also called test result lines)
>  * a possible "Bail out!" line

"Bail out!" to be moved to "optional" elements, since it may not appear.
And we should clarify TAP13 and TAP14's language to say it should only
appear when the test is aborting without running later tests -- for this
reason, I think the optional "description" following "Bail out!" should
be made required. I.e. it must be: "Bail out! $reason"

> optional elements:
>  * diagnostic data

nit: diagnostic lines (not data)

> The 5th element is diagnostic information, which is used to describe
> items running in the test, and possibly to explain test results.
> A sample test result is show below:
> 
> Some other lines may be placed the test harness, and are not emitted
> by individual test programs:
>  * one or more test identification lines
>  * a possible results summary line
> 
> Here is an example:
> 
> 	TAP version 13
> 	1..1
> 	# selftests: cpufreq: main.sh
> 	# pid 8101's current affinity mask: fff
> 	# pid 8101's new affinity mask: 1
> 	ok 1 selftests: cpufreq: main.sh

Nit: for examples, I this should should show more than one test.
(Preferably, it should show all the possible cases, ok, not ok, SKIP,
etc.)

> The output version line is: "TAP version 13"
> 
> The test plan is "1..1".
> 
> Element details
> ===============
> 
> Output version line
> -------------------
> The output version line is always "TAP version 13".
> 
> Although the kernel test result format has some additions
> to the TAP13 format, the version line reported by kselftest tests
> is (currently) always the exact string "TAP version 13"
> 
> This is always the first line of test output.
> 
> Test plan line
> --------------
> The test plan indicates the number of individual test cases intended to
> be executed by the test. It always starts with "1.." and is followed
> by the number of tests cases.  In the example above, 1..1", indicates
> that this test reports only 1 test case.
> 
> The test plan line can be placed in two locations:
>  * the second line of test output, when the number of test cases is known
>    in advance
>  * as the last line of test output, when the number of test cases is not
>    known in advance.
> 
> Most often, the number of test cases is known in advance, and the test plan
> line appears as the second line of test output, immediately following
> the output version line.  The number of test cases might not be known
> in advance if the number of tests is calculated from runtime data.
> In this case, the test plan line is emitted as the last line of test
> output.

"... must be ..." ?

> 
> Test result lines
> -----------------
> The test output consists of one or more test result lines that indicate
> the actual results for the test.  These have the format:
> 
>   <result> <number> <description> [<directive>] [<diagnostic data>]

This should be:

<result> <number> <description> [# [<directive> ][<diagnostic data>]]

> 
> The ''result'' must appear at the start of a line (except for when a
> test is nested, see below), and must consist of one of the following
> two phrases:
>   * ok
>   * not ok
> 
> If the test passed, then the result is reported as "ok".  If the test
> failed, then the result is reported as "not ok".  These must be in
> lower case, exactly as shown.
> 
> The ''number'' in the test result line represents the number of the
> test case being performed by the test program.  This is often used by
> test harnesses as a unique identifier for each test case.  The test
> number is a base-10 number, starting with 1.  It should increase by
> one for each new test result line emitted.  If possible the number
> for a test case should be kept the same over the lifetime of the test.
> 
> The ''description'' is a short description of the test case.
> This can be any string of words, but should avoid using colons (':')

Must also avoid "#".

> except as part of a fully qualifed test case name (see below).

TAP13/14 makes description optional, are we making it required (I think
we should). There seems to be a TAP13/14 "convention" of starting
<description> with "- ", which I'm on the fence about it. It does make
parsing maybe a little easier.

> Finally, it is possible to use a test directive to indicate another
> possible outcome for a test: that it was skipped.  To report that
> a test case was skipped, the result line should start with the
> result "not ok", and the directive "# SKIP" should be placed after
> the test description. (Note that this deviates from the TAP13
> specification).

This is what TAP14 changed, I think (i.e. directive follows description
now).

> 
> A test may be skipped for a variety of reasons, ranging for
> insufficient privileges to missing features or resources required
> to execute that test case.
> 
> It is usually helpful if a diagnostic message is emitted to explain
> the reasons for the skip.  If the message is a single line and is
> short, the diagnostic message may be placed after the '# SKIP'
> directive on the same line as the test result.  However, if it is
> not on the test result line, it should precede the test line (see
> diagnostic data, next).
> 
> Diagnostic data
> ---------------
> Diagnostic data is text that reports on test conditions or test
> operations, or that explains test results.  In the kernel test
> result format, diagnostic data is placed on lines that start with a
> hash sign, followed by a space ('# ').
> 
> One special format of diagnostic data is a test identification line,
> that has the fully qualified name of a test case.  Such a test
> identification line marks the start of test output for a test case.
> 
> In the example above, there are three lines that start with '#'
> which precede the test result line:
> 	# selftests: cpufreq: main.sh
> 	# pid 8101's current affinity mask: fff
> 	# pid 8101's new affinity mask: 1
> These are used to indicate diagnostic data for the test case
> 'selftests: cpufreq: main.sh'
> 
> Material in comments between the identification line and the test
> result line are diagnostic data that can help to interpret the
> results of the test.
> 
> The TAP specification indicates that automated test harnesses may
> ignore any line that is not one of the mandatory prescribed lines
> (that is, the output format version line, the plan line, a test
> result line, or a "Bail out!" line.) 
> 
> Bail out!
> ---------
> If a line in the test output starts with 'Bail out!', it indicates
> that the test was aborted for some reason.  It indicates that 
> the test is unable to proceed, and no additional tests will be
> performed.
> 
> This can be used at the very beginning of a test, or anywhere in the
> middle of the test, to indicate that the test can not continue.

I think the required syntax should be:

Bail out! <reason>

And to make it clear that this is optionally used to indicate an early
abort. (Though with a leading plan line, a parser should be able to
determine this on its own.)

> --- from here on is not-yet-organized material
> 
> Tip:
>  - don't change the test plan based on skipped tests.
>    - it is better to report that a test case was skipped, than to
>      not report it
>    - that is, don't adjust the number of test cases based on skipped
>      tests

Yes, totally.

> Other things to mention:
> TAP13 elements not used:
>  - yaml for diagnostic messages
>    - reason: try to keep things line-based, since output from other things
>    may be interspersed with messages from the test itself

Agreed: the yaml extension is not sensible for our use.

>  - TODO directive

Agreed: SKIP should cover everything TODO does.

> KTAP Extensions beyond TAP13:
>  - nesting

(I would call this 'subtests')

>    - via indentation
>      - indentation makes it easier for humans to read

And allows for separable parsing of subtests.

>  - test identifier
>     - multiple parts, separated by ':'

This is interesting... is the goal to be able to report test status over
time by name?

>  - summary lines
>    - can be skipped by CI systems that do their own calculations

Right -- I think per-test summary line should be included for the humans
reading a single test (which may scroll off the screen).

> Other notes:
>  - automatic assignment of result status based on exit code

This is, I think, a matter for the kselftest running infrastructure, not
the KTAP output?

> Tips:
>  - do NOT describe the result in the test line
>    - the test case description should be the same whether the test
>      succeeds or fails
>    - use diagnostic lines to describe or explain results, if this is
>      desirable

Right.

>  - test numbers are considered harmful
>    - test harnesses should use the test description as the identifier
>    - test numbers change when testcases are added or removed
>      - which means that results can't be compared between different
>        versions of the test

Right.

>  - recommendations for diagnostic messages:
>    - reason for failure
>    - reason for skip
>    - diagnostic data should always preceding the result line
>      - problem: harness may emit result before test can do assessment
>        to determine reason for result
>      - this is what the kernel uses

Right.

> Differences between kernel test result format and TAP13:
>  - in KTAP the "# SKIP" directive is placed after the description on
>    the test result line

Right, this is the same as TAP14, IIRC. KTAP's big deltas are the "#"
diagnostic lines and the subtest handling.

> ====== start of ktap-doc-rfc.txt ======
> OK - that's the end of the RFC doc.
> 
> Here are a few questions:
>  - is this document desired or not?

Yes.

>     - is it too long or too short?

Should be slightly longer: more examples.

>  - if the document is desired, where should it be placed?
>    I assume somewhere under Documentation, and put into
>    .rst format. Suggestions for a name and location are welcome.

Yes Documentation/*.rst Not sure on name yet, but where do kselftest
docs live? :)

>  - is this document accurate?
>    I think KUNIT does a few things differently than this description.

Let's fix it. :)

>    - is the intent to have kunit and kselftest have the same output format?
>       if so, then these should be rationalized.

Yes please.

> Finally,
>   - Should a SKIP result be 'ok' (TAP13 spec) or 'not ok' (current kselftest practice)?
> See https://testanything.org/tap-version-13-specification.html

Oh! I totally missed this. Uhm. I think "not ok" makes sense to me "it
did not run successfully". ... but ... Uhhh ... how do XFAIL and SKIP
relate? Neither SKIP nor XFAIL count toward failure, though, so both
should be "ok"? I guess we should change it to "ok".

-- 
Kees Cook
