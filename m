Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69247B9867
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2019 22:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbfITUYS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Sep 2019 16:24:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729813AbfITUYR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Sep 2019 16:24:17 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F25208C0;
        Fri, 20 Sep 2019 20:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569011056;
        bh=sFaOmPWJj56dw23yebZSt8SnxXqc2hBvrsUugoPL25Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UmZGcPEdScVMJng+U+b1z9/fAJWTq0QakOKggHWZdNgnn6gE4whIVhLDV5slrJZ5f
         lZhGNAoWzTJ8usrGfQNCKPBOhKYlVxxj8POQjOF3o9v/migT+y19hkwhgUJRlw0zE4
         Bh6ZOtjlo6/CY+ABv2d7VRONpOGZhnjFNyu+OWnE=
Subject: Re: [PATCH] selftests/kselftest/runner.sh: Add 45 second timeout per
 test
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <201909191102.97FA56072@keescook>
 <20190919185525.GD21254@piout.net>
 <4844c68f-603d-14f2-f976-5bd255268c0d@kernel.org>
 <201909191411.3FA57CBCF3@keescook>
From:   shuah <shuah@kernel.org>
Message-ID: <db388fa4-be5f-454f-7bab-2a837480ca8d@kernel.org>
Date:   Fri, 20 Sep 2019 14:24:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201909191411.3FA57CBCF3@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/19/19 3:17 PM, Kees Cook wrote:
> On Thu, Sep 19, 2019 at 02:09:37PM -0600, shuah wrote:
>> On 9/19/19 12:55 PM, Alexandre Belloni wrote:
>>> On 19/09/2019 11:06:44-0700, Kees Cook wrote:
>>>> Commit a745f7af3cbd ("selftests/harness: Add 30 second timeout per
>>>> test") solves the problem of kselftest_harness.h-using binary tests
>>>> possibly hanging forever. However, scripts and other binaries can still
>>>> hang forever. This adds a global timeout to each test script run.
>>>>
>>
>> Timeout is good, but really tests should not hang. So we have to somehow
>> indicate that the test needs to be fixed.
> 
> Totally agreed, which is why I changed the reporting to call out a
> "TIMEOUT" instead of just having it enter the general failure noise.
> 
>> This timeout is a band-aid and not real solution for the problem. This
>> arbitrary value doesn't take into account that the test(s) in that
>> particular directory (TARGET) could be running normally and working
>> through all the tests.
> 
> Even something that looks like it's making progress may still be hung or
> won't finish in a reasonable amount of time.
> 
>> We need some way to differentiate the two cases.
> 
> I don't think it's unreasonable to declare that no test should take
> longer than some default amount of time that can be tweaked via a
> "settings" file. It gives the framework the option of easily removing
> tests that take "too long", etc. If the "timeout=..." value was made
> mandatory for each test directory, then the framework could actually
> filter based on expected worst-case run time.
> 
>>>> To make this configurable (e.g. as needed in the "rtc" test case),
>>>> include a new per-test-directory "settings" file (similar to "config")
>>>> that can contain kselftest-specific settings. The first recognized field
>>>> is "timeout".
>>>>
>>>
>>> Seems good to me. I was also wondering whether this is actually
>>> reasonable to have tests running for so long. I wanted to discuss that
>>> at LPC but I missed the session.
>>>
>>
>> There is the individual test times and overall kselftest run time. We
>> have lots of tests now and it does take long.
> 
> This patch seeks to implement a "timeout for a single test from
> kselftest's perspective". Some "individual" tests have many subtests
> (e.g. anything built with kselftest_harness.h) giving us the whole
> subtest issue. I think my solution here is a good middle ground: we
> specify the max run time for each executed test binary/script.
> 
> It's not clear to me if a v2 is needed? Is this patch fine as-is?
> 
> Thanks!
> 

v1 is good. I will pull this in for testing. I do like the way it is
done.

thanks,
-- Shuah
