Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85632019DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 20:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbgFSR6g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 13:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgFSR6f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 13:58:35 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17594C06174E;
        Fri, 19 Jun 2020 10:58:35 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id k22so7832949qtm.6;
        Fri, 19 Jun 2020 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x/sMGWEA8l82wWpK7COY8NR8pPBUcue/ZjJaxSphmPg=;
        b=iK5A8s99p1Q0aELouHPhkxOn4oPcjhbDf6N6T0uoyyDM6kVx0TLcKJr1FybugKZd8E
         E5reSl0Tlb9i32j4AEBmmcDN7irndc8r3JnBGYmEO0/iUl4CLfIvk+7HjE0OYK50ENRL
         fpJsRbrvRlAsYuxYgxdIZ1b6bnNE9YXj+0FqStIo1ULYJuzRVKzY3ZkkrJfCpMHIr7eE
         Y7ESiP81pv1YUMpIebnvPQc3idDHxDRUVsxUuO4hHrVRogj1c+h3crufOJ9lk1znHnxT
         zPtSbbd114KxFk1TeN+pnIwzGqMboffQWOxJyFcuDTm/xdIfpoTMnTnjsR7kSYEl6YrS
         HO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x/sMGWEA8l82wWpK7COY8NR8pPBUcue/ZjJaxSphmPg=;
        b=XNj3pGinflEgIt67CTPV/cuxlZ0+d+RWmoXQwhnWMfCT6L7QUeIDyS+BBKhnnPRxjP
         Dj6gPffb4R4tC1T4ATeZZjws+gfriEvaOnxWcGSNhFweS5T4GuxVNa3b7fTrsaRuHl+0
         NmQcKp1FsdBELdCjsoqG9xFHLmauUd80z3Bx/MEIfNGZ1ElKUx1rKJQyTgI2SDQFLdfG
         eg6Ju6w3lbloqbUqjtpCuZA1tR0Y5gojv8z9XsdJ7ZoJWIwnb42wPZ700z1oPLW4Heh9
         A9TdBsmxogZ1p4adeOwuSIrZ89w/HKbQ9X43d7SxT5ypdCHTrSRDNvMHmpopxGCh2rbn
         +a6w==
X-Gm-Message-State: AOAM530q9CSyFLw4c/ZpImj73PErHXoLRjsSjd5eE0mjv4GDoOBoskke
        1BkQXdxBD4EVUfHTEKC9/uSb4GyhKWE=
X-Google-Smtp-Source: ABdhPJyrOn0pRtttIWmq8obPfFDMwO8IVKcy+69Kmvdhyv62fEfk/c0EEVIlJVDRZ1pZp73VGTrC2w==
X-Received: by 2002:ac8:2db1:: with SMTP id p46mr4526199qta.337.1592589514049;
        Fri, 19 Jun 2020 10:58:34 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id p22sm7462979qtc.7.2020.06.19.10.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 10:58:33 -0700 (PDT)
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>, Kees Cook <keescook@chromium.org>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook>
 <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <7161fadb-45ba-c4c0-8bbb-cb47d2dd0265@redhat.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <dc853d83-649e-b652-819f-4766ea294d78@gmail.com>
Date:   Fri, 19 Jun 2020 12:58:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7161fadb-45ba-c4c0-8bbb-cb47d2dd0265@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020-06-16 07:08, Paolo Bonzini wrote:
> On 15/06/20 21:07, Bird, Tim wrote:
>>> Note: making the plan line required differs from TAP13 and TAP14. I
>>> think it's the right choice, but we should be clear.
> 
> As an aside, where is TAP14?
> 
>> With regards to making it optional or not, I don't have a strong
>> preference.  The extra info seems helpful in some circumstances.
>> I don't know if it's too onerous to make it a requirement or not.
>> I'd prefer if it was always there (either at the beginning or the end),
>> but if there is some situation where it's quite difficult to calculate,
>> then it would be best not to mandate it. I can't think of any impossible
>> situations at the moment.
> 
> I think making the plan mandatory is a good idea.  "Late plans" work
> very well for cases where you cannot know in advance the number of tests
> (for example in filters that produce TAP from other output), and provide
> an additional safety net.
> 
>>> "Bail out!" to be moved to "optional" elements, since it may not appear.
>>> And we should clarify TAP13 and TAP14's language to say it should only
>>> appear when the test is aborting without running later tests -- for this
>>> reason, I think the optional "description" following "Bail out!" should
>>> be made required. I.e. it must be: "Bail out! $reason"
>>
>> I'll make sure this is listed as optional.
>> I like adding a mandatory reason.
> 
> +1.
> 
>>> TAP13/14 makes description optional, are we making it required (I think
>>> we should). There seems to be a TAP13/14 "convention" of starting
>>> <description> with "- ", which I'm on the fence about it. It does make
>>> parsing maybe a little easier.
>>
>> I would like the description to be required.
>> I don't have a strong opinion on the dash.  I'm OK with either one (dash
>> or no dash), but we should make kselftest and KUnit consistent.
> 
> I think no mandatory dash is better (or even mandatory no-dash!).  We
> can suggest removing it when formatting TAP output.
> 
>>>> Finally, it is possible to use a test directive to indicate another
>>>> possible outcome for a test: that it was skipped.  To report that
>>>> a test case was skipped, the result line should start with the
>>>> result "not ok", and the directive "# SKIP" should be placed after
>>>> the test description. (Note that this deviates from the TAP13
>>>> specification).
> 
> How so?  The description comes first, but there can be a description of
> the directive.
> 
>      not ok 4 - Summarized correctly # TODO Not written yet
> 
>>>> It is usually helpful if a diagnostic message is emitted to explain
>>>> the reasons for the skip.  If the message is a single line and is
>>>> short, the diagnostic message may be placed after the '# SKIP'
>>>> directive on the same line as the test result.  However, if it is
>>>> not on the test result line, it should precede the test line (see
>>>> diagnostic data, next).
>>>>
>>>> Bail out!
>>>> ---------
>>>> If a line in the test output starts with 'Bail out!', it indicates
>>>> that the test was aborted for some reason.  It indicates that
>>>> the test is unable to proceed, and no additional tests will be
>>>> performed.
>>>>
>>>> This can be used at the very beginning of a test, or anywhere in the
>>>> middle of the test, to indicate that the test can not continue.
>>>
>>> I think the required syntax should be:
>>>
>>> Bail out! <reason>
>>>
>>> And to make it clear that this is optionally used to indicate an early
>>> abort. (Though with a leading plan line, a parser should be able to
>>> determine this on its own.)
> 
> True.  However, "Bail out!" allow to distinguish issues with the harness
> (such as ENOSPC) from test aborts.
> 
>>>>  - TODO directive
>>>
>>> Agreed: SKIP should cover everything TODO does.
> 
> XFAIL/XPASS are different from SKIP.  I personally don't have a need for
> them, but kselftests includes XFAIL/XPASS exit codes and they aren't
> reflected into selftests/kselftest/runner.sh.
> 
> Likewise, kselftest.h has ksft_inc_xfail_cnt but not
> ksft_test_result_xfail/ksft_test_result_xpass.

It has ksft_exit_xfail() and ksft_exit_xpass().  But at 5.8-rc1 I do not
see any callers of those two functions.

> 
> It's important to notice in the spec that the TODO directive inverts the
> direction of ok/not-ok (i.e. XFAIL, the "good" result, is represented by
> "not ok # TODO").

For a slightly more verbose explanation, the mindset behind pytest "xfail"
and TAP "not ok # TODO explanation" is different, though they both provide
essentially the same information.

  pytest "xfail" (if I understand correctly) means the test is expected to
  fail, and it does indeed fail.

  pytest "xpass" means the test is expected to fail, but it does not fail.

  TAP "not ok # TODO explanation" means the test is expected to fail, and
  it does indeed fail.

  TAP "ok # TODO explanation" means the test is expected to fail, but it does not fail.

It does not seem to be a good idea to have two different ways of reporting
the same thing.

The TAP method seems cleaner to me.  It is consistently reported whether or
not the test passed, no matter what the expectation of pass/fail is.  "# TODO ..."
is a way for the code maintainer to convey information to the test community
that the test is expected to fail due to a known bug.  If the output of
the test changes to "ok # TODO explanation", then the tester can report
that as an issue to the code maintainer, and the code maintainer can then
determine whether the bug got fixed (and thus the "# TODO explanation"
should be removed from the test code).

Can we just remove ksft_exit_xfail() and ksft_exit_xpass() since no one is
using it, and there is an equivalent way to express the same information
in TAP?

> 
>>>>  - test identifier
>>>>     - multiple parts, separated by ':'
>>>
>>> This is interesting... is the goal to be able to report test status over
>>> time by name?
> 
> What about "/" instead?
> 
>>>> Finally,
>>>>   - Should a SKIP result be 'ok' (TAP13 spec) or 'not ok' (current kselftest practice)?
>>>> See https://testanything.org/tap-version-13-specification.html
>>>
>>> Oh! I totally missed this. Uhm. I think "not ok" makes sense to me "it
>>> did not run successfully". ... but ... Uhhh ... how do XFAIL and SKIP
>>> relate? Neither SKIP nor XFAIL count toward failure, though, so both
>>> should be "ok"? I guess we should change it to "ok".
> 
> See above for XFAIL.
> 
> I initially raised the issue with "SKIP" because I have a lot of tests
> that depend on hardware availability---for example, a test that does not
> run on some processor kinds (e.g. on AMD, or old Intel)---and for those
> SKIP should be considered a success.

No, SKIP should not be considered a success.  It should also not be considered
a failure.  Please do not blur the lines between success, failure, and
skipped.

-Frank

> 
> Paolo
> 
>> I have the same initial impression.  In my mind, a skip is "not ok", since
>> the test didn't run. However, a SKIP and should be treated differently
>> from either "ok" or "not ok" by the results interpreter, so I don't think it
>> matters.  Originally I was averse to changing the SKIP result to "ok"
>> (as suggested by Paulo Bonzini [1]), but I checked and it's pretty trivial to
>> change the parser in Fuego, and it would make the kernel results format
>> match the TAP13 spec.  I don't see a strong reason for us to be different
>> from TAP13 here.
>>
>> I raised this issue on our automated testing conference call last week
>> (which includes people from the CKI, Fuego, KernelCI and LKFT projects), and
>> so people should be chiming in if their parser will have a problem with this change.)
>>
>> [1]  https://lkml.kernel.org/lkml/20200610154447.15826-1-pbonzini@redhat.com/T/
>>
>> Thanks very much for the feedback.
>>  -- Tim
>>
> 
> .
> 

