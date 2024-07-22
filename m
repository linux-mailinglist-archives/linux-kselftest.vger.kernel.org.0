Return-Path: <linux-kselftest+bounces-13996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD4A93932C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 19:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12EF1F216C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 17:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A55816F0FE;
	Mon, 22 Jul 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e7Uk2kg6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C2516EC1A
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668842; cv=none; b=pFB6i9ekVtbDJc2frXCzf2X394paWY2L8V6q4Qqstsh5HCUAKkym0DTTWsN+TK5y4AKBeVrvQl6n4t2/74WifX4YNr4y6/7syfKzOgYZGbP+m+OKiNaqvQt97GGBP/B3G5rXGqFW8C0eUj4eQFh39TsXRc0fjEcja040dcGwKfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668842; c=relaxed/simple;
	bh=YaYVr5FEG0ukrEdmfqROtjn5kyvr+2FjDHKXLZ+mSeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQ+TJxHjFPxeqq2MhqvtllvC51Qjv17Yxg23Vk0stwrY7SsSiythOU0s5cu0RC3HsX+5KbmLqw9P8x24UbPGDapv5+sU+Jo9oxe0PDTGsog9SI/GiIgIylxt+74QIJlrp5KN9Lv0OA2She3pheBSLxyukv7/ISU28ght/l2Bb4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e7Uk2kg6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d26cb8f71so62677b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 10:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721668839; x=1722273639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LY4sH/LbuVESp5q/QWtYd1/52TmysVKBXBzov5EpRk8=;
        b=e7Uk2kg6VaqZMREuXvFk76DSUzPHwy1vYb67R54QGnhMf6tl7R7YaLPqL87hdJAFNo
         bVP4tG58zcjTMeH/pAhcXCj1e9TWjJRA2FmwJawNV/lBq9/TU0sIHeo7umNr3F9t1lN8
         yrGHNBrVSyF5d55h0s/sgMST366ZA8UEElLPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721668839; x=1722273639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LY4sH/LbuVESp5q/QWtYd1/52TmysVKBXBzov5EpRk8=;
        b=sBYlbyLThb1F1w7/91lNpqsI4IkktEsDpYOUaDEpWOy3gxy3vDGvKKf/F6q3QZCac2
         gOUNancmI4zRZUqPfOcwZV5rfTMu48NH/Wo3xpMfyW1OKs9pcbRtjzS2UBDCGQCsUGl/
         VPtKcS0DcP10PWXLvGB7fOpFfF6YUUSIk9FwDdfU1RjQha25hHgz1PoprM3wlorn5G6e
         Y4smAB28MJkKy1pQ/l5AZWLgTZu88QHdf4pe653Ukzs45eUKr983irD1PaISEsj/pB6M
         N3gBOfzEuA1NZ9YABH3cRfVBkpsteE/Rdllq3dMmHDnE49h2QWGUnmLrlQ/BDHXXDD+D
         aR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfqIv2gsRPk9BTJYaOMFIZF6lI/9jeRpUQFxCFt59EcVIQqoB3mmJK6u9/tU8YGRmh1T9mb24IPcE2nIDd33k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWZRk/G5JR94NkXRABNu5FEEapwQgGZQPHfXmj9UFSg2kx+HPV
	W1/Wls3FWMnI/bHMlBInQxhtaNVAy/YmtD2DgzSPlFdB+Fs7JcJc/fnKrIquuc6FFXh7pK6z21g
	G
X-Google-Smtp-Source: AGHT+IGm32gXR6X5r6y5GA2q/mGRB7+fSU8f71TNTs4ydJgPXvsr3Ng15mmawxW99+HX5deiZQJ8tg==
X-Received: by 2002:a05:6a21:2fc7:b0:1c3:c1d0:226 with SMTP id adf61e73a8af0-1c42298f233mr6914098637.7.1721668839344;
        Mon, 22 Jul 2024 10:20:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77307630sm8437570a91.21.2024.07.22.10.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 10:20:38 -0700 (PDT)
Message-ID: <1f29019c-c30b-48df-80e1-e412b0c7add0@linuxfoundation.org>
Date: Mon, 22 Jul 2024 11:20:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: x86: vdso_restorer: remove manual counting
 of pass/fail tests
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com, "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240712073045.110014-1-usama.anjum@collabora.com>
 <9cf7f693-bc6a-415b-99c3-f6c59b871c4f@linuxfoundation.org>
 <77a66e39-7f34-4b3c-ac8d-e48d8c5a2830@collabora.com>
 <87fbfba4-8d4d-44ff-9fe5-e101cce3d6cb@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <87fbfba4-8d4d-44ff-9fe5-e101cce3d6cb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/21/24 10:37, Muhammad Usama Anjum wrote:
> On 7/21/24 9:24 PM, Muhammad Usama Anjum wrote:
>> On 7/19/24 9:40 PM, Shuah Khan wrote:
>>> On 7/12/24 01:30, Muhammad Usama Anjum wrote:
>>>> Use kselftest wrapper to mark tests pass/fail instead of manually
>>>> counting.
>>>
>>> You care combining two changes in the patch.
>>>
>>> This is needed to return correct exit status. This also
>>>> improves readability and mainability.
>>>
>>> Spelling - "mainability" - checkpatch would have helped you
>>> catch this.
>> Sorry I'll fix it after following discussion. I use checkpatch with
>> spelling checker. I may have missed it for this patch.
>>
>>>
>>> The change to return the correct error fine and but not the
>>> change thaT ADDS DUPLICATE tap header.
>>>
>>>>
>>>
>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>>    tools/testing/selftests/x86/vdso_restorer.c | 20 +++++++-------------
>>>>    1 file changed, 7 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/x86/vdso_restorer.c
>>>> b/tools/testing/selftests/x86/vdso_restorer.c
>>>> index fe99f24341554..8e173d71291f6 100644
>>>> --- a/tools/testing/selftests/x86/vdso_restorer.c
>>>> +++ b/tools/testing/selftests/x86/vdso_restorer.c
>>>> @@ -21,6 +21,7 @@
>>>>    #include <unistd.h>
>>>>    #include <syscall.h>
>>>>    #include <sys/syscall.h>
>>>> +#include "../kselftest.h"
>>>>      /* Open-code this -- the headers are too messy to easily use them. */
>>>>    struct real_sigaction {
>>>> @@ -44,9 +45,10 @@ static void handler_without_siginfo(int sig)
>>>>      int main()
>>>>    {
>>>> -    int nerrs = 0;
>>>>        struct real_sigaction sa;
>>>>    +    ksft_print_header();
>>>
>>> The problem with adding this header here is when
>>> make kselftest TARGETS=vDSO is run there will be
>>> duplicate TAP 13 headers.
>> Usually all TAP compliant tests print TAP 13 header at the start. These
>> tests when run from make run_tests have duplicate TAP 13 headers. I don't
>> think that this is the issue. Why do you think it is wrong?
>>
>> For example, I've attached the logs of vDSO test suite. TAP header is
>> printed at the start. Then it is printed again at the start of the test if
>> it is TAP compliant e.g., vdso_test_abi and vdso_test_getrandom. These
>> tests are already TAP compliant. Other tests in this suite aren't TAP
>> compliant.
> On CIs (make runtests or make kselftest) is used to run the tests. I'm not
> aware of the ancient history. AFAIU following is the format of messages
> (make kselftests). The TAP header mention that a new test has started. One
> test may have multiple sub-tests. For example:
> 
> TAP version 13
> 1..4
> # selftests: vDSO: test1
> # TAP version 13
> 1..5
> ok 1
> ok 2
> ok 3
> ok 4
> ok 5
> # # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
> ok 1 selftests: vDSO: test1
> # selftests: vDSO: test2
> # TAP version 13
> 1..5
> ok 1
> ok 2
> not ok 3
> # # Totals: pass:2 fail:1 xfail:0 xpass:0 skip:0 error:0
> not ok 2 selftests: vDSO: test2 # exit=1
> # selftests: vDSO: test3
> ok 1
> ok 2
> ok 3
> not ok 3 selftests: vDSO: test3
> # selftests: vDSO: test4
> ok 1
> not ok 3 selftests: vDSO: test4
> 
> 
> The test1 and test2 are TAP compliant and print header and footer of the
> tests mentioning total number of tests. The test3 and test4 don't print TAP
> header and footer. The boundary between test3 and test4 isn't that clear,
> but seems fine. Overall I would say TAP compliant tests have better boundry
> when they print header/footer and total number of tests.
> 
> Do you agree with above layout's current state because we have both TAP
> compliant and non-compliant tests.
> 

Usama,

There is a reason for not using nested TAP headers - this is what the outcome
would be with the changes you are making. The reason went with the direction
of adding TAP headers once for each test suite is to avoid nested TAP headers.

Unless that changes and we can stay backwards compatible with TAP 13, I am
not going accept TAP headers for individual patches.

You can take it as a nack from me for all such patches.

thanks,
-- Shuah



