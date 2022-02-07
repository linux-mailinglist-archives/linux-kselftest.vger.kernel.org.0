Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988D74AC76C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 18:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiBGR2B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 12:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiBGRUY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 12:20:24 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74735C0401D5;
        Mon,  7 Feb 2022 09:20:23 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id s1so12469260qtw.9;
        Mon, 07 Feb 2022 09:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ofLr7xgJOwmNqV+xpm4e32E/gWqWONDoogrRX8Vy3v4=;
        b=mFuOkzKgqG/UsSjvcscwBCH9cNhslGRD/gHVDuTkPkzcBBypjsOtVtwa/vu5vSnGbS
         f/bcFRxRBogY+hCVsegawAoVGGQ9Ve3GwrGd6QUsMAGRvJVKar8s8imK+7cj+HjkWLiY
         +9HRge1w+a3/o7EzsSZrS3PZlHb0pe0dLAFu7a/FVGCSzZEUrD9vF1QPADe+F/wkU0/P
         eE+yxC7xK/vmaZznJKOo/kvRDDh/gkCbh5U3bwnG9Mjavft4616PpGEf59dzrlDLVDOJ
         EncocaWSOACeEQlWRd5vK9q8urD1cqeuYqQZRThhaT10Gq5cvSqXe3ues9zCFCEvf4I8
         Te/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ofLr7xgJOwmNqV+xpm4e32E/gWqWONDoogrRX8Vy3v4=;
        b=RAGrLvywU8KDmUN4iXFjB+L9GmeEax6n8uxqZGoScBuXjGEEMIHWx2O5ihkQxAJTK1
         gE7F9rsriOse7BK7PtW7BpbqrsRw1HtAz40hoXcDGhocUjZg26oxL+Nb1Jhl0iIBjNDc
         OskfKNzDhAPdD9fzDmA0r6V1OXzsRV+6ZD5aWtdrPtRJylJtkuP37opQaQ6ODy2Vlrid
         90rMBoroBMyHATIli07qEoSMMFjcl6AdfQvmCTXUSGUQ6/hSMIN0qLluo+IMEkcWBJkc
         gJhY4aC1vqoY8uTB2cypTtTppiLQU7hEtgbxRGn0M7azo2s78VYQC+iEBfZO+19/bd4V
         GCgQ==
X-Gm-Message-State: AOAM530X5+cRNuptaRzjLF+tCnkYXLyTAA4w4gEJBvsCSbHb+G+DVkeX
        h3RS6sVF/jT2uVvMB9qvydc=
X-Google-Smtp-Source: ABdhPJyh1NvBOA1lfkroUisPzqNxnTvIXa6w1W6aZ2QGg0Pcj3ha5MuRMsBTBib7ZCCXIXpRTSyiFQ==
X-Received: by 2002:a05:622a:1042:: with SMTP id f2mr363798qte.231.1644254422610;
        Mon, 07 Feb 2022 09:20:22 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id j15sm6044755qta.83.2022.02.07.09.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 09:20:22 -0800 (PST)
Subject: Re: [PATCH 1/1] Documentation: dev-tools: clarify KTAP specification
 wording
To:     David Gow <davidgow@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Daniel Latypov <dlatypov@google.com>, kernelci@groups.io,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220204203248.2981902-1-frowand.list@gmail.com>
 <CABVgOS=JUxV6PRUZvTQhisSP+p34+K9Z6yT7HkXu6qeqtak1tw@mail.gmail.com>
 <f4317040-df10-02cb-90bb-59f993de1e41@gmail.com>
 <CABVgOSm5A8TEa65H-D+LAF2Dm-J+T49FpAzgKP3Zxd7PQbfsLw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <adad3348-3f9e-9969-d434-24164c9932e0@gmail.com>
Date:   Mon, 7 Feb 2022 11:20:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABVgOSm5A8TEa65H-D+LAF2Dm-J+T49FpAzgKP3Zxd7PQbfsLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/4/22 6:50 PM, David Gow wrote:
> On Sat, Feb 5, 2022 at 8:18 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 2/4/22 5:13 PM, David Gow wrote:
>>> On Sat, Feb 5, 2022 at 4:32 AM <frowand.list@gmail.com> wrote:
>>>>
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> Clarify some confusing phrasing.
>>>
>>> Thanks for this! A few comments below:
>>>
>>>>
>>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>>> ---
>>>>
>>>> One item that may result in bikeshedding is that I added the spec
>>>> version to the title line.
>>>
>>> This is fine by me.
>>>
>>>>
>>>>  Documentation/dev-tools/ktap.rst | 12 ++++++------
>>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
>>>> index 878530cb9c27..3b7a26816930 100644
>>>> --- a/Documentation/dev-tools/ktap.rst
>>>> +++ b/Documentation/dev-tools/ktap.rst
>>>> @@ -1,8 +1,8 @@
>>>>  .. SPDX-License-Identifier: GPL-2.0
>>>>
>>>> -========================================
>>>> -The Kernel Test Anything Protocol (KTAP)
>>>> -========================================
>>>> +===================================================
>>>> +The Kernel Test Anything Protocol (KTAP), version 1
>>>> +===================================================
>>>>
>>>>  TAP, or the Test Anything Protocol is a format for specifying test results used
>>>>  by a number of projects. It's website and specification are found at this `link
>>>> @@ -186,7 +186,7 @@ starting with another KTAP version line and test plan, and end with the overall
>>>>  result. If one of the subtests fail, for example, the parent test should also
>>>>  fail.
>>>>
>>>> -Additionally, all result lines in a subtest should be indented. One level of
>>>> +Additionally, all lines in a subtest should be indented. One level of
>>>
>>> The original reason for this is to accommodate "unknown" lines which
>>> were not generated by the test itself (e.g, a KASAN report or BUG or
>>> something). These are awkward, as sometimes they're a useful thing to
>>> have as part of the test result, and sometimes they're unrelated spam.
>>> (Additionally, I think kselftest will indent these, as it indents the
>>> full results in a separate pass afterwards, but KUnit won't, as the
>>> level of nesting is done during printing.)
>>>
>>> Personally, I'd rather leave this as is, or perhaps call out "unknown"
>>> lines explicitly, e.g:
>>> Additionally, all lines in a subtest (except for 'unknown' lines)
>>> should be indented...
>>
>> Only listing result lines as being indented is not consistent with
>> the "Example KTAP output" section.  The example shows:
>>
>>    Version line           - indented
>>    Plan line              - indented
>>    Test case result lines - indented
>>    Diagnostic lines       - indented
>>    Unknown lines          - not shown in the example
>>
>> So there seem to be at least 4 types of lines that are indented for a
>> nested test.
> 
> Agreed.
> 
>>
>> The TAP standard (I'll use version 14 for my examples) does not allow
>> unknown lines (TAP 14 calls them "Anything else").  It says "is
>> incorrect", and "When the `pragma +strict` is enabled, incorrect test
>> lines SHOULD result in the test set being a failure, ...".  TAP 14
>> calls for the opposite behavior if `pragma -strict` is set.
> 
> Are you reading the same version 14 spec as me?
> 
> https://github.com/TestAnything/Specification/blob/tap-14-specification/specification.md

Thanks for the link.

I wasn't even aware of that repo.  A hint for anyone else that wants to look at the
spec in that repo, it is in a branch (tap-14-specfication).  I was using
https://github.com/isaacs/testanything.github.io.git which has slightly more
recent activity (Sept 6, 2015 vs Jan 19, 2015).

-Frank

> 
> I can find these lines in the version 13 spec, but not TAP14, which
> doesn't mention "Anything else" lines at all...
> 
> Not that it matters... I'll just follow along with version 13.
> 
>>
>> TAP 14 goes on to say "`Test::Harness` silently ignores incorrect lines,
>> but will become more stringent in the futures.
>>
>> It seems to me that KTAP "Unknown lines" are fundamentally different
>> than TAP 14 "Anything else" lines.  Tests that generate KTAP output
>> may print their results to the system console (or log), in which
>> case kernel messages (or for the system log the messages may even
>> come from non-kernel sources) either directly triggered by a test or
>> from a task that is totally unrelated to the test may exist in the KTAP
>> data stream.  So I would agree that "Unknown lines" are not indented.
>> Even if the "Unknown line" is directly triggered by the test.
> 
> I do think that KTAP "unknown lines" and TAP "anything else" lines
> cover similar ground, the big difference being that in KTAP they're
> explicitly permitted, rather than "incorrect".  I guess how similar
> they are is as much a matter of perspective as anything...
> 
> I'd agree that "unknown lines" don't _need_ to be indented, but I
> wouldn't call it an error to indent them if that's something a test
> harness does.
> 
>>
>> But I think the KTAP specification should say that "Diagnostic lines"
>> are emitted by the test (or the test harness), and thus must be
>> indented when related to a nested test.
>>
>> And as you suggest, "Unknown lines" should be explicitly called out
>> as not being part of "lines in a subtest", thus do not need to be
>> indented.
>>
>> Does that sound good?
>>
> 
> Agreed on both counts. Sounds great, thanks!
> 
> Cheers,
> -- David
> 
>>>
>>> Thoughts?
>>>
>>>>  indentation is two spaces: "  ". The indentation should begin at the version
>>>>  line and should end before the parent test's result line.
>>>>
>>>> @@ -225,8 +225,8 @@ Major differences between TAP and KTAP
>>>>  --------------------------------------
>>>>
>>>>  Note the major differences between the TAP and KTAP specification:
>>>> -- yaml and json are not recommended in diagnostic messages
>>>> -- TODO directive not recognized
>>>> +- yaml and json are not recommended in KTAP diagnostic messages
>>>> +- TODO directive not recognized in KTAP
>>>>  - KTAP allows for an arbitrary number of tests to be nested
>>>>
>>>
>>> Looks good here, cheers.
>>>
>>>
>>>>  The TAP14 specification does permit nested tests, but instead of using another
>>>> --
>>>> Frank Rowand <frank.rowand@sony.com>
>>>>
>>

