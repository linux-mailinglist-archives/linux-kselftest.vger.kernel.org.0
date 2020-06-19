Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F42F20191E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 19:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbgFSRNj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 13:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387563AbgFSRNi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 13:13:38 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E0BC06174E;
        Fri, 19 Jun 2020 10:13:37 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id l6so5992580qkc.6;
        Fri, 19 Jun 2020 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FHPVmXCjCJN0gFzLxo3jjpnT8jSEJ0FELbiMyFnOPt8=;
        b=mWPTg6OGYcntFaD0LELzXVfAouf6vzXr96UIaBbWK0kxwXG3F7B9JPiz4KwSjfqH+g
         y9tMuQ1TZL+aNQgTfwOb8yTg5OPRmJQ4OngkjQLJ7OMx2DQV3g6s7dP4bHwZez39AjOQ
         MdeyOTRfr0/8/ViFl+nv60kGSji+USxs1hMe8IAa5t6dFAwyAeThpW/aQya98mz+MgNN
         YCqj6ThW7j8bqae40w0YE0A/6+qvwFKGVRv6UuUIWNelyhPmRqYD9Z01134iV77dnPPo
         +P3iVDUth48JLvn+XfaBgqPegqHydZyi/R0bsy2g/7GYTxMuVHYnCibbKVbN5Fw/SOjH
         mcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FHPVmXCjCJN0gFzLxo3jjpnT8jSEJ0FELbiMyFnOPt8=;
        b=nG5kX73u9SILyRVnbO6NGew7rnGO6YKfy3+sXxltckr4jmaQQM4dHB7m7PnQImCdC7
         KJnc8ou0LFTjPiQsZW6SX7Dh8DNpD4hCXE2ULrI44XL7gCY7o+pTBHs4EdPN/6sUuDUa
         1BslpssgqBy+eAEKxwTiPWBn/BAzcoO94flp7eQXBWVB1akwRLXaYPHlRWdNRSQfnpx2
         UqXzPyRx6nRVjjj7mva6HWNPxtmPpBzFXuC9VDRVMvJWDUzYihWK6LKfOISU7zEMexHJ
         gvlYE8ccb76ZDrU+NGiiDXHdks0GaQ1Y4W1Dis8VMozrf6zQqaEKyNrRjd1lKRc1tzrM
         kUCg==
X-Gm-Message-State: AOAM533wxcOSjp0IB72BzqH/brXnZZ9zUC1Xbdqu0He/r1/eWHlvKhAO
        VTdFJD5wSXDC7aa4pLuSN/8=
X-Google-Smtp-Source: ABdhPJwE+pXkNWGe6K1Bk6aptseRi1pnMLj63Zl3YwYOapKgfLHuTaOSqDarEpUMjfbb5ky9t3s+EQ==
X-Received: by 2002:a37:6cd:: with SMTP id 196mr4410806qkg.393.1592586815984;
        Fri, 19 Jun 2020 10:13:35 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id 10sm6956933qkv.136.2020.06.19.10.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 10:13:35 -0700 (PDT)
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <edcd53f0-d931-17b9-9d29-e1797e50a646@gmail.com>
Date:   Fri, 19 Jun 2020 12:13:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020-06-10 13:11, Bird, Tim wrote:
> Some months ago I started work on a document to formalize how
> kselftest implements the TAP specification.  However, I didn't finish
> that work.  Maybe it's time to do so now.
> 
> kselftest has developed a few differences from the original
> TAP specification, and  some extensions that I believe are worth
> documenting.
> 
> Essentially, we have created our own KTAP (kernel TAP)
> format.  I think it is worth documenting our conventions, in order to
> keep everyone on the same page.
> 
> Below is a partially completed document on my understanding
> of KTAP, based on examination of some of the kselftest test
> output.  I have not reconciled this with the kunit output format,
> which I believe has some differences (which maybe we should
> resolve before we get too far into this).
> 
> I submit the document now, before it is finished, because a patch
> was recently introduced to alter one of the result conventions
> (from SKIP='not ok' to SKIP='ok').
> 
> See the document include inline below
> 
> ====== start of ktap-doc-rfc.txt ======
> Selftest preferred output format
> --------------------------------
> 
> The linux kernel selftest system uses TAP (Test Anything Protocol)
> output to make testing results consumable by automated systems.  A
> number of Continuous Integration (CI) systems test the kernel every
> day.  It is useful for these systems that output from selftest
> programs be consistent and machine-parsable.
> 
> At the same time, it is useful for test results to be human-readable
> as well.
> 
> The kernel test result format is based on a variation TAP
> TAP is a simple text-based format that is
> documented on the TAP home page (http://testanything.org/).  There
> is an official TAP13 specification here:
> http://testanything.org/tap-version-13-specification.html
> 
> The kernel test result format consists of 5 major elements,
> 4 of which are line-based:

This document should use the terminology used by the TAP spec,
if at all reasonable and possible.  It is very hard to go between
this document and the TAP specs (v13 and v14) when they use
different names for the same thing.  For example, the TAP spec
calls this "tests lines" instead of "test result".

-Frank

>  * the output version line
>  * the plan line
>  * one or more test result lines (also called test result lines)
>  * a possible "Bail out!" line
> 
> optional elements:
>  * diagnostic data
> 
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
> 
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
> 
> Test result lines
> -----------------
> The test output consists of one or more test result lines that indicate
> the actual results for the test.  These have the format:
> 
>   <result> <number> <description> [<directive>] [<diagnostic data>]
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
> except as part of a fully qualifed test case name (see below).
> 
> Finally, it is possible to use a test directive to indicate another
> possible outcome for a test: that it was skipped.  To report that
> a test case was skipped, the result line should start with the
> result "not ok", and the directive "# SKIP" should be placed after
> the test description. (Note that this deviates from the TAP13
> specification).
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
> 
> --- from here on is not-yet-organized material
> 
> Tip:
>  - don't change the test plan based on skipped tests.
>    - it is better to report that a test case was skipped, than to
>      not report it
>    - that is, don't adjust the number of test cases based on skipped
>      tests
> 
> Other things to mention:
> TAP13 elements not used:
>  - yaml for diagnostic messages
>    - reason: try to keep things line-based, since output from other things
>    may be interspersed with messages from the test itself
>  - TODO directive
> 
> KTAP Extensions beyond TAP13:
>  - nesting
>    - via indentation
>      - indentation makes it easier for humans to read
>  - test identifier
>     - multiple parts, separated by ':'
>  - summary lines
>    - can be skipped by CI systems that do their own calculations
> 
> Other notes:
>  - automatic assignment of result status based on exit code
> 
> Tips:
>  - do NOT describe the result in the test line
>    - the test case description should be the same whether the test
>      succeeds or fails
>    - use diagnostic lines to describe or explain results, if this is
>      desirable
>  - test numbers are considered harmful
>    - test harnesses should use the test description as the identifier
>    - test numbers change when testcases are added or removed
>      - which means that results can't be compared between different
>        versions of the test
>  - recommendations for diagnostic messages:
>    - reason for failure
>    - reason for skip
>    - diagnostic data should always preceding the result line
>      - problem: harness may emit result before test can do assessment
>        to determine reason for result
>      - this is what the kernel uses
> 
> Differences between kernel test result format and TAP13:
>  - in KTAP the "# SKIP" directive is placed after the description on
>    the test result line
> 
> ====== start of ktap-doc-rfc.txt ======
> OK - that's the end of the RFC doc.
> 
> Here are a few questions:
>  - is this document desired or not?
>     - is it too long or too short?
>  - if the document is desired, where should it be placed?
>    I assume somewhere under Documentation, and put into
>    .rst format. Suggestions for a name and location are welcome.
>  - is this document accurate?
>    I think KUNIT does a few things differently than this description.
>    - is the intent to have kunit and kselftest have the same output format?
>       if so, then these should be rationalized.
> 
> Finally,
>   - Should a SKIP result be 'ok' (TAP13 spec) or 'not ok' (current kselftest practice)?
> See https://testanything.org/tap-version-13-specification.html
> 
> Regards,
>  -- Tim
> 
>    
> 

