Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F175B2AB169
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Nov 2020 07:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgKIGtc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Nov 2020 01:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKIGtc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Nov 2020 01:49:32 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72B5C0613CF;
        Sun,  8 Nov 2020 22:49:31 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f38so6318108pgm.2;
        Sun, 08 Nov 2020 22:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wyGY1r0td00p5C4NS8c4M57jRtSLCdR+5tu7AC1KQTY=;
        b=OTdjcLn8iendZ3IJAfWEoU1BuhYUlFKoeZ0wxUH+TgURiGFyd/6+IvGhDtcBHbiujh
         gxZjtLLRqsV0fObpt5/nEgYga185dz11C/ooLTLKDFY70nSzGt3VIyYv8MuQIu/+R4Rn
         Gqbno6hjmd58LK5MhOKQ3dLMfnUAUvBXq+JPZP4uqE7A2HD3AQSEkLntue1skmuhvjm0
         znJX9U0GYiMGZHnmwP2McL6gMY/yOPMjs9phx8fGO+MYVf3kSi54zXraya5gNYvjmdpj
         chgkJNHxYuOnTS4billMOuDLvv/hqVpJx0xEvf1JpOX55iS49OKNYlLvk4dzhk9D4l4P
         D6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wyGY1r0td00p5C4NS8c4M57jRtSLCdR+5tu7AC1KQTY=;
        b=k6eWjilkwkarrAdI0nBfrKYTHCMvZV2CB8MijpWAtv1Oddo6JTF4etagxotz4DaOXZ
         RIyQATTTPxo2phprnzvHU4Eq560CUy8IcVumOszRT0Mv5nlFsr3bIcY944PcjX6WXMkw
         mrv9DO/EAhFsTwqNOeR1Z06NqvBMudr1vbfkevVSZLHFeF2XOlHWnyng4Zvl8A5RIZFD
         8bSRwbflK06+lWjw0FniNQzcddm8uPBE95f+VNJ88/u7/sZ2BtlSxqCuEiYoH0/CJZBK
         6JzZJ3uT2/KILnS0EozWS/PXF7huS3sEqimiG6lYLF1XcZbUo4GKK5W8WDaizToaW6Bj
         3S+A==
X-Gm-Message-State: AOAM533fQD8/osjbpNtguHTtsK9qOOQLJJhPAqE256foMurNUjRJFVmv
        LwO4phBewDIiP6NRt4E6C9bFTHqTySw9KDDH
X-Google-Smtp-Source: ABdhPJx6mLu/wejEC3V4tBx+EhCMViGlq1Tl7ztKLAAgSMePDS8QxWCD08W4jkR0obduGAY92FupZg==
X-Received: by 2002:a63:db18:: with SMTP id e24mr11559943pgg.155.1604904570692;
        Sun, 08 Nov 2020 22:49:30 -0800 (PST)
Received: from [192.168.86.81] ([106.51.240.240])
        by smtp.gmail.com with ESMTPSA id u5sm9194292pgj.28.2020.11.08.22.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 22:49:29 -0800 (PST)
Subject: Re: [PATCH v6 1/2] kunit: Support for Parameterized Testing
To:     Marco Elver <elver@google.com>, David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
References: <20201106192154.51514-1-98.arpi@gmail.com>
 <CABVgOSkQ6+y7OGw2494cJa2b60EkSjncLNAgc9cJDbS=X9J3WA@mail.gmail.com>
 <CANpmjNNp2RUCE_ypp2R4MznikTYRYeCDuF7VMp+Hbh=55KWa3A@mail.gmail.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <47a05c5a-485d-026b-c1c3-476ed1a97856@gmail.com>
Date:   Mon, 9 Nov 2020 12:19:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNNp2RUCE_ypp2R4MznikTYRYeCDuF7VMp+Hbh=55KWa3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 07/11/20 3:36 pm, Marco Elver wrote:
> On Sat, 7 Nov 2020 at 05:58, David Gow <davidgow@google.com> wrote:
>> On Sat, Nov 7, 2020 at 3:22 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>>>
>>> Implementation of support for parameterized testing in KUnit.
>>> This approach requires the creation of a test case using the
>>> KUNIT_CASE_PARAM macro that accepts a generator function as input.
>>> This generator function should return the next parameter given the
>>> previous parameter in parameterized tests. It also provides
>>> a macro to generate common-case generators.
>>>
>>> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
>>> Co-developed-by: Marco Elver <elver@google.com>
>>> Signed-off-by: Marco Elver <elver@google.com>
>>> ---
>>
>> This looks good to me! A couple of minor thoughts about the output
>> format below, but I'm quite happy to have this as-is regardless.
>>
>> Reviewed-by: David Gow <davidgow@google.com>
>>
>> Cheers,
>> -- David
>>
>>> Changes v5->v6:
>>> - Fix alignment to maintain consistency
>>> Changes v4->v5:
>>> - Update kernel-doc comments.
>>> - Use const void* for generator return and prev value types.
>>> - Add kernel-doc comment for KUNIT_ARRAY_PARAM.
>>> - Rework parameterized test case execution strategy: each parameter is executed
>>>   as if it was its own test case, with its own test initialization and cleanup
>>>   (init and exit are called, etc.). However, we cannot add new test cases per TAP
>>>   protocol once we have already started execution. Instead, log the result of
>>>   each parameter run as a diagnostic comment.
>>> Changes v3->v4:
>>> - Rename kunit variables
>>> - Rename generator function helper macro
>>> - Add documentation for generator approach
>>> - Display test case name in case of failure along with param index
>>> Changes v2->v3:
>>> - Modifictaion of generator macro and method
>>> Changes v1->v2:
>>> - Use of a generator method to access test case parameters
>>>
>>>  include/kunit/test.h | 36 ++++++++++++++++++++++++++++++++++
>>>  lib/kunit/test.c     | 46 +++++++++++++++++++++++++++++++-------------
>>>  2 files changed, 69 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>>> index db1b0ae666c4..16616d3974f9 100644
>>> --- a/include/kunit/test.h
>>> +++ b/include/kunit/test.h
>>> @@ -107,6 +107,7 @@ struct kunit;
> [...]
>>> -       kunit_suite_for_each_test_case(suite, test_case)
>>> -               kunit_run_case_catch_errors(suite, test_case);
>>> +       kunit_suite_for_each_test_case(suite, test_case) {
>>> +               struct kunit test = { .param_value = NULL, .param_index = 0 };
>>> +               bool test_success = true;
>>> +
>>> +               if (test_case->generate_params)
>>> +                       test.param_value = test_case->generate_params(NULL);
>>> +
>>> +               do {
>>> +                       kunit_run_case_catch_errors(suite, test_case, &test);
>>> +                       test_success &= test_case->success;
>>> +
>>> +                       if (test_case->generate_params) {
>>> +                               kunit_log(KERN_INFO, &test,
>>> +                                         KUNIT_SUBTEST_INDENT
>>> +                                         "# %s: param-%d %s",
>>
>> Would it make sense to have this imitate the TAP format a bit more?
>> So, have "# [ok|not ok] - [name]" as the format? [name] could be
>> something like "[test_case->name]:param-[index]" or similar.
>> If we keep it commented out and don't indent it further, it won't
>> formally be a nested test (though if we wanted to support those later,
>> it'd be easy to add), but I think it would be nicer to be consistent
>> here.
> 
> The previous attempt [1] at something similar failed because it seems
> we'd need to teach kunit-tool new tricks [2], too.
> [1] https://lkml.kernel.org/r/20201105195503.GA2399621@elver.google.com
> [2] https://lkml.kernel.org/r/20201106123433.GA3563235@elver.google.com
> 
> So if we go with a different format, we might need a patch before this
> one to make kunit-tool compatible with that type of diagnostic.
> 
> Currently I think we have the following proposals for a format:
> 
> 1. The current "# [test_case->name]: param-[index] [ok|not ok]" --
> this works well, because no changes to kunit-tool are required, and it
> also picks up the diagnostic context for the case and displays that on
> test failure.
> 
> 2. Your proposed "# [ok|not ok] - [test_case->name]:param-[index]".
> As-is, this needs a patch for kunit-tool as well. I just checked, and
> if we change it to "# [ok|not ok] - [test_case->name]: param-[index]"
> (note the space after ':') it works without changing kunit-tool. ;-)
> 
> 3. Something like "# [ok|not ok] param-[index] - [test_case->name]",
> which I had played with earlier but kunit-tool is definitely not yet
> happy with.
> 
> So my current preference is (2) with the extra space (no change to
> kunit-tool required). WDYT?
> 

Which format do we finally go with?

>> My other suggestion -- albeit one outside the scope of this initial
>> version -- would be to allow the "param-%d" name to be overridden
>> somehow by a test. For example, the ext4 inode test has names for all
>> its test cases: it'd be nice to be able to display those instead (even
>> if they're not formatted as identifiers as-is).
> 
> Right, I was thinking about this, but it'd need a way to optionally
> pass another function that converts const void* params to readable
> strings. But as you say, we should do that as a follow-up patch later
> because it might require a few more iterations.
> 
> [...]
> 
> Thanks,
> -- Marco
> 

