Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03C8201A6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 20:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbgFSSdV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 14:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgFSSdV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 14:33:21 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9509C06174E;
        Fri, 19 Jun 2020 11:33:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g28so9920218qkl.0;
        Fri, 19 Jun 2020 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xampKwCeqjXqsH4E2n+nvafbeZ3t6N+1Pr1eeefvz9U=;
        b=E50Ajly+heyCQ1MqEf1w1U30NTYLAUCcL4nl9Nm61/59NU8MEdS9YUoB+BmuEQnzRr
         5DYnCvCkAfTGwTQ7wX0NxjpmqPvTlaXyrX3xdkpwXyoAo1+obXsFNBVMEFlUaZmp5RkW
         hZGmFlgMZ+ExZ34iSGdCwKud52mfZXBcIrGq9djf8zpn/pVVyIe/ITVHhaz+V5PH5Sx5
         3GGffdcXLyMyWMEiNU0Xn0ZuKatgDeQNaU/u5JWFFNuavm9Sexp1i03o8P1y0UjT3wMG
         ZYw+omDAr9pgpnKf0idp8IvPAyTybpYfetnEaWlyDHJ1Yys16u1GAMSQrxlodUwnyZcr
         TlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xampKwCeqjXqsH4E2n+nvafbeZ3t6N+1Pr1eeefvz9U=;
        b=KtoXiYNGtPIeoKO67xpoEhjBokUkGJuNQwunLkcytx9nrQ6RKCqXtpZCviOsmYwxJZ
         uCo/T2V6Be2eR3FK/jVL4wzq5kXL/kumrsRmz1/44tKJVIlaxE+b55LksJDqvzXCmnEc
         WQ25W5e8U1Ir+2ImkQqd5j1UHonxT33ZHOnOTgzxSEEm4zdeiXAP+IuZURhZfrpFptRQ
         NChEZUJLh7HS0Lm2EUJieQT33wObCwE6h8K7slNS9VtU4BpkvLkzUlmLBCLpqJ5Z4Blj
         vv52+aUPL/MFHzkxefr5BQVHcoY5r2t6WYp4588yuZlXqoyHGfqdFRzQOMON5ov4P9nZ
         0Mdg==
X-Gm-Message-State: AOAM531VHNmr0WGQWvMwldp3ZsH23XsZJIeFidDxLe2vzvsZwKYKtG4c
        B/VNBIFYiKqH2XWlsyY6bHg=
X-Google-Smtp-Source: ABdhPJzv/dhosAjOqR7rwoECQIQMAGqbyiwJ36XGH4ugaKIlLnC/JUEwQQLb6YLgosALy1VrELJWKQ==
X-Received: by 2002:a05:620a:2494:: with SMTP id i20mr1372011qkn.123.1592591599425;
        Fri, 19 Jun 2020 11:33:19 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id c6sm6829919qkg.93.2020.06.19.11.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 11:33:17 -0700 (PDT)
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook>
 <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <7161fadb-45ba-c4c0-8bbb-cb47d2dd0265@redhat.com>
 <CY4PR13MB11755F5A6879CA3FFD005426FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <ac33fef5-7a1d-ee18-3eeb-c4437901cda5@gmail.com>
Date:   Fri, 19 Jun 2020 13:33:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CY4PR13MB11755F5A6879CA3FFD005426FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020-06-16 11:42, Bird, Tim wrote:
> 
> 
>> -----Original Message-----
>> From: Paolo Bonzini <pbonzini@redhat.com>
>>
>> On 15/06/20 21:07, Bird, Tim wrote:
>>>> Note: making the plan line required differs from TAP13 and TAP14. I
>>>> think it's the right choice, but we should be clear.
>>
>> As an aside, where is TAP14?
> By TAP14, I was referring to the current, undocumented, KUnit
> conventions.

When "TAP14" is used in this discussion, let's please use the current
proposed TAP14 spec which Brendan has provided a link to.  If you
want to describe current KUnit conventions, please say current
KUnit conventions.

> 
>>
>>> With regards to making it optional or not, I don't have a strong
>>> preference.  The extra info seems helpful in some circumstances.
>>> I don't know if it's too onerous to make it a requirement or not.
>>> I'd prefer if it was always there (either at the beginning or the end),
>>> but if there is some situation where it's quite difficult to calculate,
>>> then it would be best not to mandate it. I can't think of any impossible
>>> situations at the moment.
>>
>> I think making the plan mandatory is a good idea.  "Late plans" work
>> very well for cases where you cannot know in advance the number of tests
>> (for example in filters that produce TAP from other output), and provide
>> an additional safety net.
>>
>>>> "Bail out!" to be moved to "optional" elements, since it may not appear.
>>>> And we should clarify TAP13 and TAP14's language to say it should only
>>>> appear when the test is aborting without running later tests -- for this
>>>> reason, I think the optional "description" following "Bail out!" should
>>>> be made required. I.e. it must be: "Bail out! $reason"
>>>
>>> I'll make sure this is listed as optional.
>>> I like adding a mandatory reason.
>>
>> +1.
>>
>>>> TAP13/14 makes description optional, are we making it required (I think
>>>> we should). There seems to be a TAP13/14 "convention" of starting
>>>> <description> with "- ", which I'm on the fence about it. It does make
>>>> parsing maybe a little easier.
>>>
>>> I would like the description to be required.
>>> I don't have a strong opinion on the dash.  I'm OK with either one (dash
>>> or no dash), but we should make kselftest and KUnit consistent.
>>
>> I think no mandatory dash is better (or even mandatory no-dash!).  We
>> can suggest removing it when formatting TAP output.
> 
> My personal preference is to have the dash.  I think it's more human readable.
> I note that the TAP spec has examples of result lines both with and without
> the dash, so even the spec is ambiguous on this.   I think not mandating it
> either way is probably best.  For regex parsers, it's easy to ignore with '[-]?'
> outside the pattern groups that grab the number and description.
> 
>>
>>>>> Finally, it is possible to use a test directive to indicate another
>>>>> possible outcome for a test: that it was skipped.  To report that
>>>>> a test case was skipped, the result line should start with the
>>>>> result "not ok", and the directive "# SKIP" should be placed after
>>>>> the test description. (Note that this deviates from the TAP13
>>>>> specification).
>>
>> How so?  The description comes first, but there can be a description of
>> the directive.
> None of the examples of skips in the TAP13 spec have a test descriptions before
> the '# SKIP' directive.  But maybe I read too much into the examples. There is a
> format example, and a list of items in a result line that both have the test description
> before the directive.  So maybe I read this wrong.

Yes, I think you read too much into the examples.  I think the TAP spec
is very hard to read in the current form (v13 and proposed v14).  If
we create a KTAP spec, I can do editing to clean up some of the issues
or give review comments on what issues about clarity that I see and how
to fix them.

I read the spec as saying that the description is optional, but if the
description exists in a test line that contains "# TODO explanation"
then the description will precede the "#".

(Yes, you are seeing "I volunteer" because the current spec is so
frustrating to me.)

> 
>>
>>      not ok 4 - Summarized correctly # TODO Not written yet
>>
>>>>> It is usually helpful if a diagnostic message is emitted to explain
>>>>> the reasons for the skip.  If the message is a single line and is
>>>>> short, the diagnostic message may be placed after the '# SKIP'
>>>>> directive on the same line as the test result.  However, if it is
>>>>> not on the test result line, it should precede the test line (see
>>>>> diagnostic data, next).
>>>>>
>>>>> Bail out!
>>>>> ---------
>>>>> If a line in the test output starts with 'Bail out!', it indicates
>>>>> that the test was aborted for some reason.  It indicates that
>>>>> the test is unable to proceed, and no additional tests will be
>>>>> performed.
>>>>>
>>>>> This can be used at the very beginning of a test, or anywhere in the
>>>>> middle of the test, to indicate that the test can not continue.
>>>>
>>>> I think the required syntax should be:
>>>>
>>>> Bail out! <reason>
>>>>
>>>> And to make it clear that this is optionally used to indicate an early
>>>> abort. (Though with a leading plan line, a parser should be able to
>>>> determine this on its own.)
>>
>> True.  However, "Bail out!" allow to distinguish issues with the harness
>> (such as ENOSPC) from test aborts.
>>
>>>>>  - TODO directive
>>>>
>>>> Agreed: SKIP should cover everything TODO does.
>>
>> XFAIL/XPASS are different from SKIP.  I personally don't have a need for
>> them, but kselftests includes XFAIL/XPASS exit codes and they aren't
>> reflected into selftests/kselftest/runner.sh.
>>
>> Likewise, kselftest.h has ksft_inc_xfail_cnt but not
>> ksft_test_result_xfail/ksft_test_result_xpass.
>>
>> It's important to notice in the spec that the TODO directive inverts the
>> direction of ok/not-ok (i.e. XFAIL, the "good" result, is represented by
>> "not ok # TODO").
> 
> The TAP13 spec is not explicit about the result for TODO (and only provides
> one example), but the text *does* say a TODO can represent a bug to be fixed.
> This makes it the equivalent of XFAIL.  I hadn't noticed this before.  Thanks.

TAP 13 spec:

  "Note that if the TODO has an explanation it must be separated from TODO by a
  space. These tests represent a feature to be implemented or a bug to be fixed
  and act as something of an executable “things to do” list. They are not expected
  to succeed. Should a todo test point begin succeeding, the harness should report
  it as a bonus. This indicates that whatever you were supposed to do has been done 
  and you should promote this to a normal test point."

That seems very clear and explicit to me about what the intent and usage of TODO is.


> 
>>
>>>>>  - test identifier
>>>>>     - multiple parts, separated by ':'

I don't find "identifier" when I grep for it in KUnit related places.  And
it has been a while since I've read through the KUnit code.  So I am a
little lost about what a "test identifier" is.  Is this part of the test
line "Description"?  Any pointers to what this is?

-Frank


>>>>
>>>> This is interesting... is the goal to be able to report test status over
>>>> time by name?
>>
>> What about "/" instead?
> In my experience, / is used in a lot of test descriptions (when quoting
> file paths) (not in kselftest, but in lots of other tests).  Both Fuego
> and KernelCI use colons, and that's what kselftest already uses,
> so it seems like a good choice.
> 
>>
>>>>> Finally,
>>>>>   - Should a SKIP result be 'ok' (TAP13 spec) or 'not ok' (current kselftest practice)?
>>>>> See https://testanything.org/tap-version-13-specification.html
>>>>
>>>> Oh! I totally missed this. Uhm. I think "not ok" makes sense to me "it
>>>> did not run successfully". ... but ... Uhhh ... how do XFAIL and SKIP
>>>> relate? Neither SKIP nor XFAIL count toward failure, though, so both
>>>> should be "ok"? I guess we should change it to "ok".
>>
>> See above for XFAIL.
>>
>> I initially raised the issue with "SKIP" because I have a lot of tests
>> that depend on hardware availability---for example, a test that does not
>> run on some processor kinds (e.g. on AMD, or old Intel)---and for those
>> SKIP should be considered a success.
>>
>> Paolo
>>
>>> I have the same initial impression.  In my mind, a skip is "not ok", since
>>> the test didn't run. However, a SKIP and should be treated differently
>>> from either "ok" or "not ok" by the results interpreter, so I don't think it
>>> matters.  Originally I was averse to changing the SKIP result to "ok"
>>> (as suggested by Paulo Bonzini [1]), but I checked and it's pretty trivial to
>>> change the parser in Fuego, and it would make the kernel results format
>>> match the TAP13 spec.  I don't see a strong reason for us to be different
>>> from TAP13 here.
>>>
>>> I raised this issue on our automated testing conference call last week
>>> (which includes people from the CKI, Fuego, KernelCI and LKFT projects), and
>>> so people should be chiming in if their parser will have a problem with this change.)
>>>
>>> [1]  https://lkml.kernel.org/lkml/20200610154447.15826-1-pbonzini@redhat.com/T/
>>>
>>> Thanks very much for the feedback.
>>>  -- Tim
>>>
> 

