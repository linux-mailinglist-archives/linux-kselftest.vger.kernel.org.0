Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6156F297ADE
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Oct 2020 07:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759539AbgJXFIr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 24 Oct 2020 01:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759537AbgJXFIr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Oct 2020 01:08:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24106C0613CE;
        Fri, 23 Oct 2020 22:08:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l2so317940pjt.5;
        Fri, 23 Oct 2020 22:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fjaSUVFJm1JVw244s2m2ztF0RKFCy/L3lODaApmqKEY=;
        b=Dy58VvAhl/znmltBfnj9Hzm/FtbhfUgpGMlvSE9xwJUaZ6cHFTvuh0f1w/FPla3/x2
         0vk06xgcUgtGOXwe75Z2e/qwmM8C471sRTWhsVM0CYnOtTiouDR3b6vLLhSXakvs8eFZ
         uymgg7KkFog5OiPgmJR1YbveRCYZQqR6S+SVXQxMLADixxhT0BM/kp8O0iBW5lMkT+6q
         pxbnPfrJ6Q37L9btErdzoo6az/LFq1Fe71F/wimmn5YzKR8t5DtV0L8N2xyleCqGEW+k
         abC89/M2KvFMKTgqA2N6E5Xx79TbTIB294hEeIGsfpLYaKbSorcSyl8s+ry1SI9/d0Nu
         FINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fjaSUVFJm1JVw244s2m2ztF0RKFCy/L3lODaApmqKEY=;
        b=q2xrNfqypzaUA0cCcKUuKOnNHz4otAQPeUaZYm9N6LjITXLehIv+IO/DXTYY1jUSFC
         7D8VzRIMRaWsRfEqIpxX+Twgv1PDwCcbydZC5q8zvfGTegaaqCB+tU+VKG97tY8OZZLM
         TO/V2iCk1FUrf2ZPpGkksLayoh6aZYINQzG9+oDNIzzD3/HGncp8XbgpoPT29pJquEK/
         1TyG74nBlVi9W5hHHUmi5wDCq2cBo833gPDBr8oRa6uevc2K9u/5IBXps0DiDkbVCNjk
         sKxV2tJJx3s1VtXzdm/2UIr3NMZN9uqRlOO/h1IvlZqWYsDFo92zsRsMU2hZ9Z9SJs/u
         P7Wg==
X-Gm-Message-State: AOAM531Wtrb5utbKf6G0wVy961mRDD1ZEbxduNA4FFGcTI7OsD6Cbmj3
        OyXUKxj8VGrhZ9YIVuqO/8YqJzVI6kofdrDt
X-Google-Smtp-Source: ABdhPJzMw4FH+jjCGG7bREV97DUiLKrfg+/6FY5v3qm03LrH3LqYN1flii67GCds7GtvWcc8RLMtww==
X-Received: by 2002:a17:902:7006:b029:d5:f56f:931a with SMTP id y6-20020a1709027006b02900d5f56f931amr2154454plk.8.1603516125765;
        Fri, 23 Oct 2020 22:08:45 -0700 (PDT)
Received: from [192.168.86.81] ([106.51.242.32])
        by smtp.gmail.com with ESMTPSA id c127sm3998591pfc.115.2020.10.23.22.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 22:08:44 -0700 (PDT)
Subject: Re: [PATCH v2] lib: Convert test_printf.c to KUnit
To:     Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, idryomov@gmail.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20201022151349.47436-1-98.arpi@gmail.com>
 <20201022191606.GQ4077@smile.fi.intel.com>
 <0ab618c7-8c5c-00ae-8e08-0c1b99f3bf5c@rasmusvillemoes.dk>
 <01f8ca45-60d1-ad67-f8eb-354dec411a78@gmail.com>
 <20201023180128.GB13609@alley>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <0a9e5183-b4aa-0a72-ca84-01e09b4b04c1@gmail.com>
Date:   Sat, 24 Oct 2020 10:38:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023180128.GB13609@alley>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/10/20 11:31 pm, Petr Mladek wrote:
> On Fri 2020-10-23 19:13:00, Arpitha Raghunandan wrote:
>> On 23/10/20 4:36 pm, Rasmus Villemoes wrote:
>>> On 22/10/2020 21.16, Andy Shevchenko wrote:
>>>> On Thu, Oct 22, 2020 at 08:43:49PM +0530, Arpitha Raghunandan wrote:
>>>>> Converted test failure:
>>>>>     # Subtest: printf-kunit-test
>>>>>     1..1
>>>>>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:82
>>>>> vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote
>>>>> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>>>>>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:82
>>>>> vsnprintf(buf, 5, "%pi4|%pI4", ...) wrote '127.', expected '127-'
>>>>>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:118
>>>>> kvasprintf(..., "%pi4|%pI4", ...) returned
>>>>> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>>>>>     not ok 1 - selftest
>>>>> not ok 1 - printf-kunit-test
>>>>
>>>> Not bad. Rasmus, what do you think?
>>>
>>> Much better, but that '1..1' and reporting the entire test suite as 1
>>> single (failing or passing) test is (also) a regression. Look at the
>>> original
>>>
>>>>> [    0.591409] test_printf: all 388 tests passed
>>>
>>> or
>>>
>>>>> [    0.619495] test_printf: failed 3 out of 388 tests
>>>
>>> That's far more informative, and I'd prefer if the summary information
>>> (whether in the all-good case or some-failing) included something like
>>> this. In particular, I have at some point spotted that I failed to
>>> properly hook up a new test case (or perhaps failed to re-compile, or
>>> somehow still ran the old kernel binary, don't remember which it was) by
>>> noticing that the total number of tests hadn't increased. The new output
>>> would not help catch such PEBKACs.
>>>
>>> Rasmus
>>>
>>
>> Splitting the test into multiple test cases in KUnit will display
>> the number and name of tests that pass or fail. This will be similar
>> to the lib/list-test.c test as can be seen here:
>> https://elixir.bootlin.com/linux/latest/source/lib/list-test.c.
>> I will work on this for the next version of this patch.
> 
> We should probably agree on the granularity first.
> 
> It looks like an overkill to split the tests into 388 functions
> and define KUNIT_CASE() lines. It might be possible to hide
> this into macros but macros are hell for debugging.
> 
> I suggest to split it by the current functions that do more test()
> call inside. I mean to define something like:
> 
> static struct kunit_case printf_test_cases[] = {
> 	KUNIT_CASE(basic),
> 	KUNIT_CASE(number),
> 	KUNIT_CASE(string),
> 	KUNIT_CASE(plain_pointer),
> 	KUNIT_CASE(null_poiter),
> 	KUNIT_CASE(error_pointer),
> 	KUNIT_CASE(addr),
> 	KUNIT_CASE(struct_resource),
> 	KUNIT_CASE(dentry),
> 	KUNIT_CASE(pointer_addr),
> 	 ...,
> 	{}
> };
> 
> Best Regards,
> Petr
> 

Okay, I will split it by the current functions that have more test() calls inside as suggested.
I will also make changes as per your other suggestions for the next version.
Thanks!
