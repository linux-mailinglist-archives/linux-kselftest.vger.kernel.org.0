Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B636C98B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 01:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCZXgK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Mar 2023 19:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCZXgJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Mar 2023 19:36:09 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134D04EC4;
        Sun, 26 Mar 2023 16:36:06 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id f17so5096461oiw.10;
        Sun, 26 Mar 2023 16:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679873765;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0IJGLM6qczRLZLKYS/PLKvdKaXI6TCFz4YdGjJKWQE=;
        b=A9VRz1bNbhYrvQbiZ6xOwJ3GSzwpCOZ7cxuJXtlJ0w5gpyda2moVimg6hG78ibEURG
         T8x6PiiUFk9A5XtZHkpPeYSATmXyr7BE1CpLwaWRZY0uVulqFfQGbC2MY0IxcQaRS0Mg
         8OBTVknpREPJaSr+zLEmB3SOmjnmqCjcdjp9HAYaIsThjzFxe3vYeEf2kxXIBYkyia07
         VrPtpofNyPjt38j34ZAiGNrnhhj1DnhCJ0xz2gapTCsj2QdUhY+fpN6oV0CLCeLmMtnO
         OvJobC3yJ4wiq4q2ZCROJbMPDl9O2AHpaCq0/mbK3MP6Gp6rOldLUEv1wSdrjznmblOH
         d4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679873765;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0IJGLM6qczRLZLKYS/PLKvdKaXI6TCFz4YdGjJKWQE=;
        b=w7n2UOdPrKXlAGcYalw7bUPZaGH7IRFTzhKWXrod+P5yWiUxTB5+C2YH+RLyMmvcEl
         sFOxAz3IL2JQ9SahfgnIWjLkvhYLUQd1Z9Z4jkeKn0pbieM4KhX5/5YChJSYIxKS+v1q
         D4gz+HLzYKm+Za6hbrCTgioAJEA+33ARdiSUf42NLAeDX19NfohfGQNdlYlKITR5y/E4
         mTgcYfpDH+AqtEbNXNZtHxa7bduO1PqTm29gdhCkU/G1PKUJLJZ1aAlqRVrVMCOxWTDZ
         y3+r06eRSjEKgSAqWT53vOaiI0vh+m/mpTqzZKCU9B5zY10DUxyqo0Dxy5llB00ktmI8
         HvSw==
X-Gm-Message-State: AO0yUKVUJMkg8/qcPYWwZ71CRRxCMC/phncebI4rbzUfndjopX196IIg
        pPGRExgVEL+47DhXofrljvc=
X-Google-Smtp-Source: AK7set8DwQC+wewJW0vTAlKKNTNRHXbbgHO4kqCD83pEcjaRjfusQdSxnnHnEXxiEwSrOQ6Gj47m1g==
X-Received: by 2002:a05:6808:a92:b0:387:6c61:d44e with SMTP id q18-20020a0568080a9200b003876c61d44emr3598779oij.55.1679873765128;
        Sun, 26 Mar 2023 16:36:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:988b:7dda:764e:c744? ([2600:1700:2442:6db0:988b:7dda:764e:c744])
        by smtp.gmail.com with ESMTPSA id y45-20020a4a9830000000b0053bb063121asm2771045ooi.9.2023.03.26.16.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 16:36:04 -0700 (PDT)
Message-ID: <dd3372a2-98f0-dcbd-1e04-7d1e19bdd231@gmail.com>
Date:   Sun, 26 Mar 2023 18:36:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [KTAP V2 PATCH] ktap_v2: add skip test result
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rae Moar <rmoar@google.com>, davidgow@google.com,
        skhan@linuxfoundation.org, keescook@chromium.org,
        Tim.Bird@sony.com, brendanhiggins@google.com
Cc:     corbet@lwn.net, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310222002.3633162-1-rmoar@google.com>
 <490271eb-1429-2217-6e38-837c6e5e328b@gmail.com>
 <93e35a77-c00b-5c66-a460-6018dab98175@gmail.com>
In-Reply-To: <93e35a77-c00b-5c66-a460-6018dab98175@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/13/23 09:41, Frank Rowand wrote:
> On 3/11/23 21:52, Frank Rowand wrote:
>> On 3/10/23 16:20, Rae Moar wrote:
>>> Add the test result "skip" to KTAP version 2 as an alternative way to
>>> indicate a test was skipped.
>>>
>>> The current spec uses the "#SKIP" directive to indicate that a test was
>>> skipped. However, the "#SKIP" directive is not always evident when quickly
>>> skimming through KTAP results.
>>>
>>> The "skip" result would provide an alternative that could make it clearer
>>> that a test has not successfully passed because it was skipped.
>>>
>>> Before:
>>>
>>>  KTAP version 1
>>>  1..1
>>>    KTAP version 1
>>>    1..2
>>>    ok 1 case_1
>>>    ok 2 case_2 #SKIP
>>>  ok 1 suite
>>>
>>> After:
>>>
>>>  KTAP version 2
>>>  1..1
>>>    KTAP version 2
>>>    1..2
>>>    ok 1 case_1
>>>    skip 2 case_2
>>>  ok 1 suite
>>>
>>> Here is a link to a version of the KUnit parser that is able to parse
>>> the skip test result for KTAP version 2. Note this parser is still able
>>> to parse the "#SKIP" directive.
>>>
>>> Link: https://kunit-review.googlesource.com/c/linux/+/5689
>>>
>>> Signed-off-by: Rae Moar <rmoar@google.com>
>>> ---> 
>>> Note: this patch is based on Frank's ktap_spec_version_2 branch.
>>>
>>>  Documentation/dev-tools/ktap.rst | 27 ++++++++++++++++++---------
>>>  1 file changed, 18 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
>>> index ff77f4aaa6ef..f48aa00db8f0 100644
>>> --- a/Documentation/dev-tools/ktap.rst
>>> +++ b/Documentation/dev-tools/ktap.rst
>>> @@ -74,7 +74,8 @@ They are required and must have the format:
>>>  	<result> <number> [<description>][ # [<directive>] [<diagnostic data>]]
>>>  
>>>  The result can be either "ok", which indicates the test case passed,
>>> -or "not ok", which indicates that the test case failed.
>>> +"not ok", which indicates that the test case failed, or "skip", which indicates
>>> +the test case did not run.
>>>  
>>>  <number> represents the number of the test being performed. The first test must
>>>  have the number 1 and the number then must increase by 1 for each additional
>>> @@ -91,12 +92,13 @@ A directive is a keyword that indicates a different outcome for a test other
>>>  than passed and failed. The directive is optional, and consists of a single
>>>  keyword preceding the diagnostic data. In the event that a parser encounters
>>>  a directive it doesn't support, it should fall back to the "ok" / "not ok"
>>> -result.
>>> +/ "skip" result.
>>>  
>>>  Currently accepted directives are:
>>>  
>>> -- "SKIP", which indicates a test was skipped (note the result of the test case
>>> -  result line can be either "ok" or "not ok" if the SKIP directive is used)
>>
>>> +- "SKIP", which indicates a test was skipped (note this is an alternative to
>>> +  the "skip" result type and if the SKIP directive is used, the
>>> +  result can be any type - "ok", "not ok", or "skip")
>>
>> For the "SKIP" directive, result type of either "ok", or "not ok" reflects the
>> current real world usage, which is mixed.  I agree is makes sense to also
>> allow the result type of "skip" with the "SKIP directive.
>>
> 
>> I think it would be good to deprecate the "SKIP" directive, with a scheduled
>> removal in the V3 specification - that would allow plenty of time for test
>> parsers to process both V1 and V2 data, before removing processing of V1 data.
> 
> Since I wrote that paragraph, I have pondered the process of transition from
> V1 to V2, to possibly V3.  It seems to be a complex enough issue that I will
> start a different email thread to gather thoughts, issues, and possible
> directions.

The new thread is now started at:

  https://lore.kernel.org/all/6d4afb49-3cb9-f176-61a2-5bbaab698644@gmail.com/T/#u

-Frank

> 
> -Frank
> 
>>
>> If so, the deprecation plan should be documented.
>>
>>>  - "TODO", which indicates that a test is not expected to pass at the moment,
>>>    e.g. because the feature it is testing is known to be broken. While this>    directive is inherited from TAP, its use in the kernel is discouraged.
>>> @@ -110,7 +112,7 @@ Currently accepted directives are:
>>>  
>>>  The diagnostic data is a plain-text field which contains any additional details
>>>  about why this result was produced. This is typically an error message for ERROR
>>> -or failed tests, or a description of missing dependencies for a SKIP result.
>>> +or failed tests, or a description of missing dependencies for a skipped test.
>>>  
>>>  The diagnostic data field is optional, and results which have neither a
>>>  directive nor any diagnostic data do not need to include the "#" field
>>> @@ -130,11 +132,18 @@ The test "test_case_name" failed.
>>>  
>>>  ::
>>>  
>>> -	ok 1 test # SKIP necessary dependency unavailable
>>> +	skip 1 test # necessary dependency unavailable
>>
>> Maybe add a note that the "skip" result method is preferred over the below
>> "ok ... # SKIP..." example below.
>>
>>>  
>>> -The test "test" was SKIPPED with the diagnostic message "necessary dependency
>>> +The test "test" was skipped with the diagnostic message "necessary dependency
>>>  unavailable".
>>>  
>>> +::
>>> +
>>> +	ok 1 test_2 # SKIP this test should not run
>>> +
>>> +The test "test_2" was skipped with the diagnostic message "this test
>>> +should not run".
>>
>> Maybe add a deprecation note here.
>>
>>> +
>>>  ::
>>>  
>>>  	not ok 1 test # TIMEOUT 30 seconds
>>> @@ -225,7 +234,7 @@ An example format with multiple levels of nested testing:
>>>  	    not ok 1 test_1
>>>  	    ok 2 test_2
>>>  	  not ok 1 test_3
>>> -	  ok 2 test_4 # SKIP
>>> +	  skip 2 test_4
>>>  	not ok 1 example_test_1
>>>  	ok 2 example_test_2
>>>  
>>> @@ -262,7 +271,7 @@ Example KTAP output
>>>  	  ok 1 example_test_1
>>>  	    KTAP version 2
>>>  	    1..2
>>> -	    ok 1 test_1 # SKIP test_1 skipped
>>> +	    skip 1 test_1 # test_1 skipped
>>>  	    ok 2 test_2
>>>  	  ok 2 example_test_2
>>>  	    KTAP version 2
>>>
>>> base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5
>>
> 

