Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A44B4A9263
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Feb 2022 03:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356668AbiBDCpD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Feb 2022 21:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiBDCpC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Feb 2022 21:45:02 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CE8C061714;
        Thu,  3 Feb 2022 18:45:02 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id g13so4321335qvw.4;
        Thu, 03 Feb 2022 18:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MhMUznq+gOdPSMdQ1UhrCoNxZbzBeSzkBtn+Tu6ryGM=;
        b=BfyE8vWXfTt+pUI226vLcue8gpEBLhHXI5BhUBwwoti+zww/DmsieLqiMDyKj1nnHS
         2m6rZScCTyKT2gwLYz/NN1uMJK5WLV5hTM8CH+eiEJdxphEce79QDgqbIFXpKJErOzgX
         hMaPl61yW7A0P/h1bTHm2rQvNjBO7zp7kXX3CJ1Wz3v/cAseNbAVaQllTIYUio6AZqTn
         kx6FaUsHFnESiIqy1GraqtL+mSY4kCR3xSGT0MnY6JAb448a00o7pvKtrMGt0ejv36La
         KFZ2V/wiCZawqa8p34cqjJDH2z9Fh4iwrRNO5VNyUR3fxBG3cWJOxMKyniN8JapIah36
         5bTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MhMUznq+gOdPSMdQ1UhrCoNxZbzBeSzkBtn+Tu6ryGM=;
        b=3+c7YaPgKGpAgeNnMG7rfWg9oYE/l5Uu2QI4ts3dTed5TRASNvQk0TdsuHFsqlSQvV
         eu6BnAieAxkOL3968qDVAqIf/Zf1+/qtKm7OoVCbtl1+w/1JMMQKD194utfqi1bDuR+5
         o0SqLCgeWuRkjdEbm2RIg9NyrBTqegGL/oK0s0qf8Y93Y93Gohefv2MuZtnYcY5qjMvi
         EFe1VqXk7rmmkp6HKgy6MQoO6e7tZQK9Dwy0nYmOGZVKklqDqbcRI7Tb3JqwvTQQncA6
         tI9hIGnOcjdAy8/ZyRmh8nQikG97DA7/UJGfKlacI8lJoFRTBIxG8TdPDKxWt6dC4XXr
         KXmw==
X-Gm-Message-State: AOAM53250nfvvwwewvAtfoGCxaV22HKi3DaiN0ly9vT+GhdogVl7N2GX
        Ocy5jDnLCy8exu+6oDy4ScY=
X-Google-Smtp-Source: ABdhPJx4ab31EvE1cZngXItQsoOoqQd20Z7YCcLEJ1WPAZtRZ0kekwTL59dMgcnHC1yxStlybaqHuA==
X-Received: by 2002:ad4:5fc9:: with SMTP id jq9mr521121qvb.107.1643942701077;
        Thu, 03 Feb 2022 18:45:01 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id o3sm461018qtw.3.2022.02.03.18.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 18:45:00 -0800 (PST)
Subject: Re: RFC - kernel test result specification (KTAP)
To:     Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com
Cc:     rmoar@google.com, brendanhiggins@google.com, davidgow@google.com,
        shuah@kernel.org, dlatypov@google.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernelci@groups.io, guillaume.tucker@collabora.com
References: <CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com>
 <202108272330.AE55FCD@keescook>
 <BYAPR13MB2503A4B79074D8ED5579345DFDCB9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <202108301226.800F3D6D4@keescook>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <929aac3b-e52c-45c2-e449-fadd469cf68d@gmail.com>
Date:   Thu, 3 Feb 2022 20:44:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <202108301226.800F3D6D4@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/30/21 2:58 PM, Kees Cook wrote:
> On Mon, Aug 30, 2021 at 05:48:07PM +0000, Tim.Bird@sony.com wrote:
>> From: Kees Cook <keescook@chromium.org>
>>>> Test case result lines
>>>> ----------------------
>>>>
>>>> Test case result lines must have the format:
>>>>
>>>>     <result> <number> [-] [<description>] [<directive>] [<diagnostic data>]
>>>
>>> "[<diagnostic data>]" is not defined below. I think what you mean is
>>> "directive details".
>>
>> IMHO it's useful to keep this called 'diagnostic data'.
>>
>> The directive is optional, and having this be diagnostic data means you can
>> put explanatory text, or result details, that are independent of the description,
>> on the same line as the result.  This is convenient in some cases.
>>
>> I think diagnostic data should always be prefixed by a hash sign.
>> Or, in the case where diagnostic data appears on the result line,
>> the hash serves as the delimiter.  This means that the description
>> text must not include a hash character.
>>
>> For example:
>> ok 5 - check return code # rcode=0
>> or
>> not ok 5 - check return code # rcode=17
> 
> The directive is currently used to answer the question "why?" as in,
> "why is this test not ok?" ("a timeout occurred") or "why is this test
> ok?" ("a SKIP")
> 
> The "supporting evidence" for the "why?" answer are specific details
> about that: "the exit was was NNN" or "the timeout was YYY seconds".
> 
> Test diagnostics are all the lines preceding that (currently prefixed
> with a "#").
> 
>>> Yes, though the optional "- " is strictly part of the optional
>>> description.
>>
>> It's mildly annoying that "-" is optional.  It's trivial to deal with in the parser
>> to just ignore it if it's present.  But it has no semantic meaning whatsoever.
>> IMHO it would be nice to either mandate it or remove it, for consistency's sake.
>> This could be based solely on the consensus for whether it added or detracted
>> from human readability, since parsers don't care.
> 
> I have no strong opinion on the "-". I was surprised to encounter it
> as it's not part of the TAP 13 spec. I would prefer to drop it, if I had
> to choose.
> 
>> ERROR usually means that there was some kind of failure
>> in the testing process that makes the testcase result indeterminate.
>> (like loss of connection to a server, or crash of the program executing
>> the testcase).  This can be due to a bug in the test or the test system.
>> I'm, not sure if ERROR is used this way in kselftest.  It is, IMHO, a useful
>> distinction to make.  TIMEOUT is a special case of ERROR, IMHO.
> 
> Well, I think TIMEOUT is a "why not ok?" answer. "not ok" seems to be
> the same as ERROR, but I guess it's really a catch-all, but must come
> with the "evidence" portion:
> 
> not ok 1 description goes here # TIMEOUT 45 seconds with no results
> not ok 1 description goes here # ERROR lost connection to server
> not ok 1 description goes here # ERROR non-zero exit code: NNN
> 
> I might go so far as to say the directive is _required_ for the "not ok"
> state.
> 
>> As an aside, I've never liked XFAIL or XPASS.  Semantically, I believe they
>> are quite confusing, and depend on the level of testcase execution.  XPASS is also
>> redundant.  Isn't the default case always XPASS?
> 
> Nothing currently uses XPASS, and we should remove it.
> 
> XFAIL capture the condition of the test logic in that a test for
> something arm64-specific on a non-arm64 machine is _not_ a "pass". It
> will fail. But it's an expected failure. And, as a directive, must come
> with the evidence bit:
> 
> not ok 1 PAN catches bad accessg # XFAIL PAN CPU feature is arm64 only
> 
> As a test author, I want to see this as distinct from failure and
> success.
> 
>> In the case of XFAIL, does it mean that an operation that was expected to fail
>> all the time, failed, and so the test passed?  Or does it mean that this is a known
>> bug that a particular developer or site has decided to ignore (as in "we know this
>> is a bug, but we expected it to fail, so just ignore it for now).  The latter, I really
>> don't think should be encoded in the tests themselves, but should be put
>> into a layer above the test and parser, that is applied according to developer
>> or testlab policy.
> 
> I agree that "just ignore it for now" shouldn't be there.
> 
> Other arguments are that xfail tests shouldn't be run at all, but I
> don't think that's right because it makes it very hard to do large-scale
> test result comparisons because random stuff is missing, depending on
> various configs, archs, etc. It blocks a 1-to-1 comparison, and begs
> questions like "why is the test here in one case and not in another?"
> where as an XFAIL will encode the reason it is an XFAIL in its output,
> providing a self-documenting test result.
> 
>>> I still think there should be a distinction between "diagnostic lines"
>>> and "unknown lines". For example, if kselftest is running on a console,
>>> the dmesg output may be intermixed, and possibly temporally offset. Such
>>> lines may not be useful, and may not be strictly correlated, where-as
>>> the output from kselftest is at least self-consistent.
>>
>> I think this would be a very good distinction to make.  You might have
>> unknown lines that (inadvertently?) start with a hash, but trying to 
>> make sure that the test itself always outputs diagnostic data with a preceding
>> hash gives a reader potentially more information about where the message
>> came from, and could be useful.
> 
> Right, so lines with a hash shouldn't be machine-parsed. (And this is a
> mistake I made in the current kselftest output for the LAVA parser.) The
> good news for the kernel, is that nothing else in dmesg leads with a
> "#" currently. :)

Actually, not correct.  Devicetree unittest (drivers/of/unittest.c) leads
messages with "### dt-test ### ".  But the good news is that this is
easily changeable.

-Frank

> 
>>> No; diagnostic lines must have no meaning: they are for humans and nothing
>>> else. If other details are needed for machines, we should explicitly
>>> create new format lines. I made a mistake when I used a diagnostic line
>>> for embedding the test names. :( There is a need for parsers to discover
>>> the name of a given test, though, so we do likely need something for this.
>>
>> I agree it is handy to have the test name for sub-tests.  However, I don't
>> see any semantic difference whether we define sub-test declarations via
>> diagnostic lines with special syntax or by creating a new syntax separate
>> from diagnostic lines.  Either way, we have a new syntax for parsers to
>> understand.
> 
> Pragmatically, I agree, which is what lead me to my mistake. However, in
> reconsidering it, I realize this leads to a slippery slope of just
> dumping stuff into diagnostic lines and pretending nothing will read it.
> 
> I suspect what we need is an optional "starting test" line, like:
> 
> test N DESC
> # diag...
> # diag...
> # diag...
> ok N
> 
> The nesting looks like:
> 
> TAP version 13
> 1..3
> test 1 seccomp
> # TAP version 13
> # 1..27
> # test 1 prctl
> # ok 1
> # test 2 strict
> # ok 2
> # ...
> # test 27 user_notif
> # # eek missing CONFIG_....
> # not ok 27 user_notif # ERROR can't use ioctl
> not ok 1 seccomp # ERROR non-zero exit code 1
> test 2 netfilter
> ok 2 netfilter
> test 3 bpf
> # exciting things happen
> ok 3 bpf
> 
> This is what we have now except basically just replacing "# $name" with
> "test $num $name"
> 
>>>
>>>> Diagnostic lines of the format "# Subtest:
>>>> <test_name>" indicate the start of a test with subtests. Also,
>>>> diagnostic lines of the format "# <test_name>: <description>" refer to
>>>> a specific test and tend to occur before the test result line of that
>>>> test but are optional.
>>>
>>> I don't think the above should be included in the spec -- diag lines
>>> should have no parseable meaning.
>>>
>>>>
>>>> Bail out line
>>>> -------------
>>>>
>>>> A bail out line can occur anywhere in the KTAP output and will
>>>> indicate that a test has crashed. The format of a bail out line is
>>>> "Bail out! [<description>]",  where the description can give
>>>> information on why the bail out occurred and can be any string.
>>>
>>> I'm not a fan of the Bail out line. It's not a problem, exactly, but I
>>> find it redundant. If we want an "end of test" line, let's make one.
>>> "Bail out" is a special case of exit. If we want to handle test exit,
>>> let's define it. E.g. make kselftest's test summary lines not
>>> diagnostic lines:
>>>
>>> # FAILED: 85 / 87 tests passed.
>>> # Totals: pass:83 fail:2 xfail:0 xpass:0 skip:2 error:0
>>
>> How consistent is it for selftests to produce test summary lines?
> 
> Any of the tools built with kselftest.h will spit it out. (Which is to
> say several of the "subtests".) The bulk of kselftest output is from the
> runner, which doesn't produce this summary.
> 
>>> Please no. There is no reason to force a nested test to suddenly have
>>> to know about its test execution depth/environment. A subtest is just a
>>> nested TAP result. That it is nested is only meaningful to the parser, not
>>> the executing test, and it must have the same output, nested or not. (e.g.
>>> running the test alone or running the test under a full kselftest run,
>>> the only difference is the indentation level.)
>> I agree that the sub-test should not know about this line.  I thought
>> the "parent" test wrote the line.
> 
> The suggestion was that the subtest should _not_ emit the "TAP" line,
> which is what I strongly disagree with: it should be a self-contained
> TAP-emitting test.
> 
>>> Again, I see only downsides to this. Nesting for the spec is simple
>>> indentation-based recursion. Let's just keep what we already have:
>>>
>>> TAP version 13
>>> 1..1
>>> # TAP version 13
>>> # 1..2
>>> # ok 1 - test_1
>>> # ok 2 - test_2
>>> ok 1 - test_suite
>>
>> I prefer spaces, but whatever.  Is the prefix on the 'TAP version 13' line guaranteed
>> to be the prefix on all lines for the (sub-)test?
> 
> That's the current implementation, yes.
> 
> As for tabs vs spaces, I think it's fine to swap "# " for "  ". We just
> need to patch LAVA to deal with it.
> 
>> Just as a side note, in some Fuego tests, it was very useful to include an identifier
>> in thethe prefix nested tests.  The output looked like this:
>>
>> TAP version 13
>> 1..2
>> [batch_id 4] TAP version 13
>> [batch_id 4] 1..2
>> [batch_id 4] ok 1 - cyclictest with 1000 cycles
>> [batch_id 4] # problem setting CLOCK_REALTIME
>> [batch_id 4] not ok 2 - cyclictest with CLOCK_REALTIME
>> not ok 1 - check realtime
>> [batch_id 4] TAP version 13
>> [batch_id 4] 1..1
>> [batch_id 4] ok 1 - IOZone read/write 4k blocks
>> ok 2 - check I/O performance
>>
>> Can I propose that the prefix not be fixed by the spec, but that the spec indicates that
>> whatever the prefix is on the TAP version line, that prefix must be used with the output for
>> all lines from the test (with the exception of unknown lines)?
> 
> Oh, interesting. This would also allow parallel (unique) test execution
> to be parsable. That sounds workable. (Again, this needs LAVA patching
> again...)
> 
>>>> Major differences between TAP 14 and KTAP specification
>>>> -------------------------------------------------------
>>>>
>>>> Note that the major differences between TAP 14 and KTAP specification:
>>>> - yaml and json are not allowed in diagnostic messages
>>>
>>> Agreed -- these are overkill (and very difficult to implement as they
>>> _follow_ the test result line: anything generating them has already
>>> finished running).
>>
>> I thought that some tests put the diagnostic data before the result line.
>>
>> I don't care whether it is before or after (and indeed Fuego's parser
>> can handle either case).  But it can't handle it when some testcases
>> put diagnostic data before the result line, and some testcases put
>> it after, in the same test.  There's no delimiter for the separation
>> between the two different testcases diagnostic data.
> 
> Right. The current implementation puts it always before. TAP 13 (14?) has
> the YAML _after_ the results line, but that's totally unworkable for
> kselftest, which is designed to be first human readable and second machine
> readable. Waiting to see diagnostics from a slow test is terrible --
> we can't collect it and spit it out later. Also, a parser would have
> no idea about when a test is finished if diagnostics follow the last
> test result of a plan.
> 
> Making it "always before" is fine by me, and the motivation for making
> the "summary" lines be non-diagnostics because they technically followed
> the last test result.
> 
>> Could we possibly have a rule about diagnostic lines positioning relative
>> to the testcase result line?  Maybe a rule like this:  For a single test,
>> diagnostic lines should either always preceded the testcase they
>> are related to, or follow the testcase they are related to.
> 
> For the kernel, I would rather avoid anything after because that just
> confuses things.
> 
>>> Yes. (Though "exit=" is a mistake in runner.sh -- this should probably
>>> be reported without the '#')
>>
>> Please No!  (Unless I'm misinterpreting that line).
>>
>> If you remove the '#', that makes the 'exit=127' part of the test description.
>> The test description should be invariant between success and failure cases.
>> The exit=127 (if I'm reading that line right) is part of data explaining or
>> describing the failure. It would be 'exit=0' if the test succeeded.
>>
>> In order to correlate test cases (ie show results over time), the description
>> should not change from one invocation of the test to the next.  At least Fuego
>> uses the test description this way.  That is, the testcase description is used as
>> a testcase identifier, and if it changes from run to run things get confusing.
> 
> Agreed, I think it should be part of an ERROR directive:
> 
> not ok 14 awesome test # ERROR exit=127
> 
> 

