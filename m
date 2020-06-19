Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A171E201A27
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 20:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394200AbgFSSRi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 14:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389232AbgFSSRf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 14:17:35 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB8BC06174E;
        Fri, 19 Jun 2020 11:17:35 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id p15so4891810qvr.9;
        Fri, 19 Jun 2020 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3uZCoM2AWA6/XtPvpJamTOlHYSrROKfn1hw8fNerrOg=;
        b=f1MTzq5px1ZySmzMqwu8CBDsMcxnBOYGuyxhP7gnhUomFLUDKg0ESORk9IVOIyvxMV
         6CAuFtQa/yKhdEZwRrwn9VgZfDyHPq01i8x+574sPCEbXnyKbH/SJ5NF5E36EvtnfMKz
         eNGL8G7uZ/nCucgPYOpmJpeejDtvzyiyaRD+MmIb6LWZAavDBnE/J16UjPL5TB/rxVUQ
         DVIbMgEubdkd1b4/km22idxq9bWhB+uwCEuVBoNlirINAfXmsn3rPUZsHMS7IIgt7FCx
         eDe9r+JB9c5Q8N2Fxzeenlyl8PIfTZGy9UrluWwVlm/MoJHZHtqjLBvfNSOaoCQCPE8H
         vRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3uZCoM2AWA6/XtPvpJamTOlHYSrROKfn1hw8fNerrOg=;
        b=KT3nLm1YKD3SrikmRyzkyZja7A6cPvfN48c+bRMl40CYLxBsxhrdANodntC1Jre1Ol
         6wIMUZNKa5zVl2c7vgxlZ7Dd8rLGXSoO3UTwKmtCl8pt/7SMssvGNcIrX+GB3xYK53Qb
         JeoWbzSKqTUixr351qKyLtxxCXgZ6GUvi21Ti6wej9+kQTJEHbnfcy3zgjAFP3/DO0ox
         +naX7hvB9VUGPRj3uVRSdeOat8WZ2hY7e2bu16wtTZZBVGboYNaxusoDdGCwxOqpr4Xk
         t/KXX4flexWRnDpLVyUXVksHyX6/BdTlL7AO/V49ncN0dW4B35/q68+qOFjys+OrySfi
         /6lg==
X-Gm-Message-State: AOAM533HY3wbAzt0zLAGS10E7tiBgnjOcLbGdIOABrOx9pXiu0ND+TBI
        PvFb+jZctg1s3P0aMMuJXftN0xQcQAo=
X-Google-Smtp-Source: ABdhPJypDjUGC4ELUXzah3KfvqRPnDFmNebIAcKuobBGd0JRNhy9gTlVawM4bflVC2fHItXQAqIoaw==
X-Received: by 2002:ad4:4d04:: with SMTP id l4mr10316591qvl.88.1592590654677;
        Fri, 19 Jun 2020 11:17:34 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id u14sm6467749qkj.18.2020.06.19.11.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 11:17:34 -0700 (PDT)
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     Brendan Higgins <brendanhiggins@google.com>,
        "Bird, Tim" <Tim.Bird@sony.com>
Cc:     David Gow <davidgow@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CABVgOSkrKHs_uWLZ++_fBC_mfe3RgDxmCvnkcyn1P_wjXTV9Og@mail.gmail.com>
 <CY4PR13MB11756803217A9D20456E826FFD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CAFd5g458XTDftQAOm-K4Squ5-ZuZnZcFdVUG0JtUWF56cODOVg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <f5554a01-0862-f7c3-5c6d-f77c9ee8c8f9@gmail.com>
Date:   Fri, 19 Jun 2020 13:17:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g458XTDftQAOm-K4Squ5-ZuZnZcFdVUG0JtUWF56cODOVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020-06-16 15:03, Brendan Higgins wrote:
> On Mon, Jun 15, 2020 at 10:34 AM Bird, Tim <Tim.Bird@sony.com> wrote:
>>
>>> -----Original Message-----
>>> From: David Gow <davidgow@google.com>
>>>
>>> On Thu, Jun 11, 2020 at 2:11 AM Bird, Tim <Tim.Bird@sony.com> wrote:
> [...]
>>> KUnit is currently outputting "TAP version 14", as we were hoping some
>>> of our changes would get into the TAP14 spec. (Any comments, Brendan?)
>>> Maybe this should end up saying "KTAP version 1" or something?
>>
>> I don't know if this will break any existing results parsers or not.
>> I hesitate to use "TAP version 14", as TAP appears to be a dormant
>> initiative at the moment, and there's no guarantee that the kernel's
>> changes will get adopted into an official spec.
> 
> We were using "TAP version 14" since the "extensions" we are using
> were all proposed among the TAP people to go into the next version of
> TAP. Based on discussions among them they seem to like the subtest
> stuff:
> 
> https://github.com/TestAnything/testanything.github.io/pull/36
> 
> Anyway, I can still appreciate that they might change their minds.
> 
>> If we are a strict super-set of TAP, then I suppose we could just
>> start using TAP version 14, and unilaterally declare that our changes
>> make a new spec.  But since we don't control the web site this feels
>> like a hostile takeover.
> 
> I just thought it was okay because it was already in their proposed
> TAP14 spec, but yeah, if we just decide amongst ourselves to use it,
> we should probably do something else.
> 
>> I'm most comfortable with calling our thing KTAP, and just
>> referencing TAP as inspiration.  I don't have a strong opinion on
> 
> I am cool with that.

I like a KTAP specification, based on the proposed TAP 14, but with a
good edit, and with the extensions and changes that are coming out
of this conversation.

It would be great if we could just have a finished TAP 14, but my
understanding is that efforts to move that forward are not making
any progress.  And if we fork to make KTAP, maybe that will be
the incentive for TAP to move forward, and maybe KTAP could be
merged back into TAP.

-Frank

> 
>> KTAP vs TAP, but I do feel strongly that kselftest and kunit should use the
>> same version line (if we can get them to use the same conventions).
> 
> Yeah, I agree: it would be better if there was just one version of
> (K)TAP in the kernel.
> 
>>>> Test plan line
>>>> --------------
>>>> The test plan indicates the number of individual test cases intended to
>>>> be executed by the test. It always starts with "1.." and is followed
>>>> by the number of tests cases.  In the example above, 1..1", indicates
>>>> that this test reports only 1 test case.
>>>>
>>>> The test plan line can be placed in two locations:
>>>>  * the second line of test output, when the number of test cases is known
>>>>    in advance
>>>>  * as the last line of test output, when the number of test cases is not
>>>>    known in advance.
>>>>
>>>> Most often, the number of test cases is known in advance, and the test plan
>>>> line appears as the second line of test output, immediately following
>>>> the output version line.  The number of test cases might not be known
>>>> in advance if the number of tests is calculated from runtime data.
>>>> In this case, the test plan line is emitted as the last line of test
>>>> output.
>>>
>>> KUnit is currently including the test plan line only for subtests, as
>>> the current version doesn't actually know how many test suites will
>>> run in advance.
>>> This is something there's work underway to fix, though.
>> Sounds good.  You can just put the line at the bottom if it's
>> obnoxious to calculate ahead of time.
> 
> I thought that is not in the TAP spec?
> 
> I kind of like printing out ahead of time how many tests we expect to
> run, so if we crash we know how many tests weren't run.
> 
> In any case, until we get the change in that David is referencing, we
> cannot print out the test plan for the "super test" before or after
> because KUnit doesn't know when it is "done". So moving it to the
> bottom doesn't really help us.
> 
>> Does this mean that KUnit treats each sub-test as an individual test case
>> of the "super-test"?
> 
> Yes.
> 
> At the top level, we have all test suites. Each subtest in TAP is a
> test suite in KUnit. Each case in each subtest in TAP is a test case
> in KUnit.
> 
>> In results summaries for a super-test, are all sub-test cases counted,
>> or just the list of sub-tests?
> 
> Just the sub-tests. Each subtest is responsible for counting it's own cases:
> 
> https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#subtests
> 
> Cheers
> 

