Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCADC6D29A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 22:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjCaUuo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 16:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCaUun (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 16:50:43 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE2EA5FA;
        Fri, 31 Mar 2023 13:50:41 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-545e907790fso321797117b3.3;
        Fri, 31 Mar 2023 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680295841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wv6grfdZr27vRlAqWo1RaSWBJCwMVn4UjeQm8h0GguM=;
        b=oHrpF6lOujk/1pN9xuKgqGVteSqelzRJvBBum160Ozd0jNqr20GCzgeIESQCu/5uxf
         r1HRTcnLfY3aYw72HxmwrMGwRmtak/2ObC7OGW2Z12zg8C0AUPT+dE/BsaQlK+7lt7EN
         m57aGVga8r69khpAFuJdVeWjp+J7fBTXj1Bpkd846BxvhyilK6k/EwWBa7GWqEmJat4z
         lj1Q2l+uYbMpOkcQnSa/Iy8gFLDHPi64+nBHiFUwvlHGg4+gKLH8x/tOD916xitXs48T
         XwSDNely6779x9QVOk7IrFwrNnFO8rz8wh94rpsHwtv+JwAlvOe8s4D7nF48P+lwHehy
         +nJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680295841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv6grfdZr27vRlAqWo1RaSWBJCwMVn4UjeQm8h0GguM=;
        b=mIprZs0AESTnZjLJf3sPMNJvkyXlruXvNMcK9cQiVZ3bLRvWe/iqhe5KGEwzGlLp5X
         55no+hv9pHwfihIu3XiMN4Ls13scJ7ZHGCFwr9wRgfi55vQh6Bmxus6yunCNHVlkAWEf
         AHq9tb03ynuhdybYNm320406f/R/EDXOFmhXn0QB4jSGoARCi80wEROfAdbezjP7DcHt
         62Wmop8uhoR7HBpyO51rI/BfblftZcrLT3GTGkHOCkfNLMZTa2cFph/ebMuEQDq9fYCe
         of3VbbwQue9SQTo35/78VW+KvYsrefyJC2bNtUIEQaibB0OTfMeA50MKLGl2vodvjFB2
         xssQ==
X-Gm-Message-State: AAQBX9c33996DwBOpXgU0CTwISd9io7E8Gw9zLrcMBCwVWnmAwe9qP8c
        218bNz3/KaIydFgsabTcT4g=
X-Google-Smtp-Source: AKy350ZZ/MUThcNTcLgqKP/kikAABGw/v9j/eaPkoS5QajCmxSm+l02G5qGsCkEEeBDkPvtIr5MkmA==
X-Received: by 2002:a81:92d2:0:b0:546:209d:ee81 with SMTP id j201-20020a8192d2000000b00546209dee81mr9371153ywg.2.1680295840735;
        Fri, 31 Mar 2023 13:50:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:71ba:9450:b500:725c? ([2600:1700:2442:6db0:71ba:9450:b500:725c])
        by smtp.gmail.com with ESMTPSA id x7-20020a81e707000000b00545cb6adc16sm753646ywl.6.2023.03.31.13.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 13:50:40 -0700 (PDT)
Message-ID: <597ab347-0ba4-7c5f-99a6-4ead0b956330@gmail.com>
Date:   Fri, 31 Mar 2023 15:50:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [KTAP V2 PATCH] ktap_v2: allow prefix to KTAP lines
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>
Cc:     davidgow@google.com, skhan@linuxfoundation.org,
        keescook@chromium.org, Tim.Bird@sony.com,
        brendanhiggins@google.com, corbet@lwn.net,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@lists.linux.dev, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230316225926.494921-1-rmoar@google.com>
 <5626cd99-f44a-97db-334e-99f1d62112a1@gmail.com>
 <CA+GJov5B7Y8fqm7QtDuvx88m7QPEPF6bYqMqbEGf0cp=E=zGCg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CA+GJov5B7Y8fqm7QtDuvx88m7QPEPF6bYqMqbEGf0cp=E=zGCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/29/23 16:14, Rae Moar wrote:
> On Sun, Mar 26, 2023 at 10:12 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 3/16/23 17:59, Rae Moar wrote:
>>> Change the KTAP v2 spec to allow variable prefixes to KTAP lines,
>>> instead of fixed indentation of two spaces. However, the prefix must be
>>> constant on the same level of testing (besides unknown lines).
>>>
>>> This was proposed by Tim Bird in 2021 and then supported by Frank Rowand
>>> in 2022 (see link below).
>>>
>>> Link: https://lore.kernel.org/all/bc6e9ed7-d98b-c4da-2a59-ee0915c18f10@gmail.com/
>>
>> Another link to the same thread, but expanded to show all replies in one page is:
>>
>>   https://lore.kernel.org/all/bc6e9ed7-d98b-c4da-2a59-ee0915c18f10@gmail.com/T/#u
>>
>> Near the top of that thread I proposed alternative 1 (essentially what Tim
>> originally suggested, and what Rae proposes here) and alternative 2 (with
>> slight variant 2b).  The overall preference seemed to be alternative 1, but
>> if we wanted to provide a method to provide test or system metadata then
>> alternative 2 might provide both a test prefix and metadata.
>>
>> Alternate 1 provides the vast majority of what I need the prefix for, but
>> I think there has been a recent comment that it would be useful to be able
>> to report system metadata (sorry, I haven't found a reference for that yet).
>> In my case, it would be informative to use metadata to report which config
>> options that impact the DT unittests are enabled.
>>
> 
> Hi Frank,
> 
> Thanks for all of your ideas!
> 
> Thinking more on this topic, I do think we will want a specified way
> to report test metadata in KTAP. This can be partly covered with this
> idea for a prefix. However, it might not provide the flexibility or
> comprehensiveness we need. For example, reporting the file for input
> or output might be too verbose for a prefix.
> 

> I thought your idea on config info lines was compelling. However, I am
> not sure using a result line to communicate the metadata is the best
> solution. This would alter the function of a result line. And for
> parsers that count "ok" and "not ok", this might create problems.

Good point.  I agree that using "ok 0 <something>" to define the prefix
string or metadata is a terrible hack.  (This was alternative 2 above.)

> 
> I have an idea that derives from my other KTAP proposal to declare a
> test name with "# Subtest:". The idea is to declare the metadata as
> diagnostic lines in between the version line and the test plan in
> order to separate this information from subtest diagnostic output. We
> could do something similar to below:
> 
> KTAP version 2
> 1..1
>   KTAP version 2
>   # Name: test_1          // Or as proposed: "# Subtest: test_1"
>   # File: /sys/kernel/...
>   # Config: CONFIG_1=y CONFIG_PARAM=2048
>   1..1
>   # subtest_1 passed
>   ok 1 subtest_1
> # test_1 passed
> ok 1 test_1
> 
> This is just an idea. I would love to hear other ideas on the best way
> to report metadata. Alternatively, we could create a new line format
> all together specific to report test metadata.

Let's tag that as "alternative 3".  So far, I like alternative 3 the most.

Alternative 3 has some impact on diagnostic lines.  KTAP v1 allows diagnostic
lines to occur anywhere.  I we leave that unchanged, then I think that any
metadata tag (such as "Name: ", "File: ", "Config: " in the above example)
should be made illegal in other diagnostic lines.  I don't like the idea
of restricting diagnostic line format in that matter, so I would instead
propose instead restricting non-metadata diagnostic lines to not be allowed
between the version line and the test plan line.  I don't think that
restriction would be problematic.

Alternative 3 also provides a clean way of implementing test name.  Also,
changing from subtest name to test name is a good cleanup.  Since the
name could be for the top level test, using "subtest" adds a conceptual
mismatch for the main test name.

> 
>>>
>>> As cited in the original proposal, it is useful in some Fuego tests to
>>> include an identifier in the prefix. This is an example:
>>>
>>>  KTAP version 1
>>>  1..2
>>>  [batch_id 4] KTAP version 1
>>>  [batch_id 4] 1..2
>>>  [batch_id 4] ok 1 cyclictest with 1000 cycles
>>>  [batch_id 4] # problem setting CLOCK_REALTIME
>>>  [batch_id 4] not ok 2 cyclictest with CLOCK_REALTIME
>>>  not ok 1 check realtime
>>>  [batch_id 4] KTAP version 1
>>>  [batch_id 4] 1..1
>>>  [batch_id 4] ok 1 IOZone read/write 4k blocks
>>>  ok 2 check I/O performance
>>>
>>> Here is a link to a version of the KUnit parser that is able to parse
>>> variable length prefixes for KTAP version 2. Note that the prefix must
>>> be constant at the same level of testing.
>>>
>>> Link: https://kunit-review.googlesource.com/c/linux/+/5710
>>>
>>> Signed-off-by: Rae Moar <rmoar@google.com>
>>> ---
>>>
>>> This idea has already been proposed but I wanted to potentially
>>> restart the discussion by demonstrating this change can by
>>> implemented in the KUnit parser. Let me know what you think.
>>>
>>> Note: this patch is based on Frank's ktap_spec_version_2 branch.
>>>
>>>  Documentation/dev-tools/ktap.rst | 21 ++++++++++++++++++---
>>>  1 file changed, 18 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
>>> index ff77f4aaa6ef..ac61fdd97096 100644
>>> --- a/Documentation/dev-tools/ktap.rst
>>> +++ b/Documentation/dev-tools/ktap.rst
>>
>> Some additional lines of the Spec to be updated (from my alternate 1 email,
>> I haven't checked the current Spec to see if these are the exact changes
>> needed, but at least capture the intent:
>>
>> The "Version lines" format is changed from:
>>
>>    KTAP version 1
>>
>> to:
>>
>>    [<prefix string>] KTAP version 1
>>
>> The "Plan lines" format is changed from:
>>
>>    "1..N"
>>
>> to:
>>
>>    [<prefix string>] "1..N"
>>
>> The "Test case result lines" format is changed from:
>>
>>    <result> <number> [<description>][ # [<directive>] [<diagnostic data>]]
>>
>> to:
>>
>>    [<prefix string>] <result> <number> [<description>][ # [<directive>] [<diagnostic data>]]
>>
> 
> These are all great additions to the spec. Will add in version 2. I
> suppose we should add this detail to the diagnostic lines syntax as
> well.
> 
>>
>>    <prefix content is a constant string>
>>
>>
>> I wrote (with a bit of imprecision):
>>
>>   Indentation for "Nested tests" follows <prefix string>.  The indentation
>>   does NOT precede <prefix string>.
>>
>> which was meant to imply that the two space indentation would follow the
>> <prefix string>.
>>
>> The patch I am replying to instead replaces the two space indentation
>> entirely with the <prefix string>.  I think this patches' version of
>> indentation is superior to what I suggested.
>>
>>> @@ -192,9 +192,11 @@ starting with another KTAP version line and test plan, and end with the overall
>>>  result. If one of the subtests fail, for example, the parent test should also
>>>  fail.
>>>
>>> -Additionally, all lines in a subtest should be indented. One level of
>>> -indentation is two spaces: "  ". The indentation should begin at the version
>>> -line and should end before the parent test's result line.
>>> +Additionally, all lines in a subtest should be indented. The standard for one
>>> +level of indentation is two spaces: "  ". However, any prefix for indentation
>>> +is allowed as long as the prefix is consistent throughout that level of
>>> +testing. The indentation should begin at the version line and should end
>>> +before the parent test's result line.
>>>
>>>  "Unknown lines" are not considered to be lines in a subtest and thus are
>>>  allowed to be either indented or not indented.
>>
>> I was a little more verbose about "Unknown lines":
>>
>>    "Unknown lines" may optionally be prefixed with the <prefix string>, but
>>    are not required to be prefixed with the <prefix string>.  It is allowed
>>    for some "Unknown lines" to not be prefixed with the <prefix string>, even
>>    if one or more other "Unknown lines" are prefixed with the <prefix string>.
>>
>> I think combining the intent ("not considered to be lines in a subtest") with
>> the extra verbosity would be useful.
>>
> 
> I agree this seems like a useful addition. Will add for version 2.
> 
>>> @@ -229,6 +231,19 @@ An example format with multiple levels of nested testing:
>>>       not ok 1 example_test_1
>>>       ok 2 example_test_2
>>>
>>> +An example of a test with two nested subtests using prefixes:
>>> +
>>> +::
>>> +
>>> +     KTAP version 2
>>> +     1..1
>>> +     [prefix_1] KTAP version 2
>>> +     [prefix_1] 1..2
>>> +     [prefix_1] ok 1 test_1
>>> +     [prefix_1] ok 2 test_2
>>> +     # example passed
>>> +     ok 1 example
>>> +
>>
>> The "[" and "]" are meant to indicate an optional field, so the
>> example would be:
>>
>> +       KTAP version 2
>> +       1..1
>> +       prefix_1 KTAP version 2
>> +       prefix_1 1..2
>> +       prefix_1 ok 1 test_1
>> +       prefix_1 ok 2 test_2
>> +       # example passed
>> +       ok 1 example
>> +
>>
> 
> Thanks, this is better to exclude the square brackets. Will change
> this for version 2.
> 
>> Of course, "[" and "]" are valid characters within the prefix string, so
>> that an example of "[prefix_1]" could be mentioned as a valid example.
>>
>> I would suggest some additional more complex examples:
>>
>> +       prefix_0 KTAP version 2
>> +       prefix_0 1..1
>> +       prefix_0 prefix_1 KTAP version 2
>> +       prefix_0 prefix_1 1..2
>> +       prefix_0 prefix_1 ok 1 test_1
>> +       prefix_0 prefix_1 ok 2 test_2
>> +       # example passed
>> +       prefix_0 ok 1 example
>> +
> 
> Shouldn't the "# example passed" line include the prefix_0?

Yes, I goofed up on that.  The same applies to the following
examples.

> 
>>
>> +       KTAP version 2
>> +       1..2
>> +       prefix_1 KTAP version 2
>> +       prefix_1 1..2
>> +       prefix_1 ok 1 test_a_1
>> +       prefix_1 ok 2 test_a_2
>> +       # example passed
>> +       ok 1 example
>> +       prefix_2 KTAP version 2
>> +       prefix_2 1..2
>> +       prefix_2 ok 1 test_b_1
>> +       prefix_2 ok 2 test_b_2
>> +       # example passed
>> +       ok 2 example
>> +
>>
>> +       KTAP version 2
>> +       1..3
>> +       prefix_1 KTAP version 2
>> +       prefix_1 1..2
>> +       prefix_1 ok 1 test_a_1
>> +       prefix_1 ok 2 test_a_2
>> +       # example passed
>> +       ok 1 example
>> +         KTAP version 2
>> +         1..2
>> +         ok 1 test_b_1
>> +         ok 2 test_b_2
>> +       # example passed
>> +       ok 2 example
>> +       prefix_2 KTAP version 2
>> +       prefix_2 1..2
>> +       prefix_2 ok 1 test_c_1
>> +       prefix_2 ok 2 test_c_2
>> +       # example passed
>> +       ok 3 example
>> +
>>
>>
> 
> Otherwise, these all look very helpful. I will definitely be adding
> these more complex examples in version 2.
> 
> Thanks!
> 
> Rae
> 
>>
>>>
>>>  Major differences between TAP and KTAP
>>>  --------------------------------------
>>>
>>> base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5
>>

