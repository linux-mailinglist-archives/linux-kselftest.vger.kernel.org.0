Return-Path: <linux-kselftest+bounces-15201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D55C94FFCE
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 10:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091851F215AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 08:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CAC13A87C;
	Tue, 13 Aug 2024 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WvhpT+iP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D718E29
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537647; cv=none; b=umM1Ah893B/dQjmu9RpweUx6lB7VtfNbUG2g/5PK9Lra3qoE7C5Qq7qf0Q4gMqRrt93f+rrkA3vDHJeTxq8y9OOPwdnV8CPlsWjRBvExvue7xNeOkxM6YncpuzZRVyTKDBcr4UfKI6AMsL9J9K1fN91XXXWqW8xslizaKh/JkU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537647; c=relaxed/simple;
	bh=Di5W029mQbwAIiOztUJhZxig5qR3pk54Irui8gJHXqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rypeUkAL167NTHhTxOFYyUVxGtLOtX2paVkS99TptNmu8Ddp04kNWICsHghR0qNNHrUvDiAd4G8LJHoEwRp0kubLsWSSuqntv2nEHCzFGs2NSO0HLByZep3t/59nDKOsKxAt7l45Hcc38eEwsj4qtkTVturaPtXt8tYTcUoU9XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WvhpT+iP; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a12bb0665eso222684a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723537645; x=1724142445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yflrWJtJq/7VvAJgVaJf6jxLhnH8NAOkAempPFuuC+o=;
        b=WvhpT+iPp7t3daiyNSig58zuXPcttc0J3EbP+Dnu/1+Ul7+iHudxH+jHnAJeN824Mj
         ItHeOLxJJos4wDrH96tVSqlGy9qiSzAIPH59bcQHtm6+DbQMf1QQIc7oThw03mAzNSIk
         ygLs7bfEODBCoh4ae5ioTkJNOzaXyKwKgTT2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723537645; x=1724142445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yflrWJtJq/7VvAJgVaJf6jxLhnH8NAOkAempPFuuC+o=;
        b=Qi3lLHm5PRAkxIBgSOqDpnoWPgAsCypOvkQdScGosArdlL7riiZ8z2b8woIegQZvjC
         wcBSiil72xImf5jwlDrtfyATDwaslCljTHlwwSobrjHUa/j2LOLpcqW8HNi3wcp3ySzf
         yWDA49JemJ19/swZr+HSrbKWxROqy9PW9uADi0YNLUru3eh8horGW5CO3/vlPRABFQ7B
         Viwbq+RlhIu5OXgX63kNyYa7Fxvw8JxWa5OxrvsQwoPRiJvi4tq2U0Fk7XHAqZXusEBk
         3V59ecDAkESy7obW6cYcyCHos+dlKXdyXyehrEvkRvWpvd7yGzMqV33CZEmyu3n/GG8S
         a7dg==
X-Forwarded-Encrypted: i=1; AJvYcCViqPibOMsPH6CrTHjnAffz3HubVA/Bcynt+2mWprX4h1SkZDQFblP3tZiYYIHjqvTZ6nBbRrNuEyO+XdbupTrLzYYom7kon4PqtpZIaA2l
X-Gm-Message-State: AOJu0Yw417OAdnpjeNfTQSmK0Ed3ntPnJwiA13XgAQP0FmHXVl+fWdkF
	JnJJhfW5s6d4t+gXsWzh6cANbqIhyvD7cJ7NaLqBOvZx3EH65E/S68XhvChxiyw=
X-Google-Smtp-Source: AGHT+IG8ruoJJQXw5+ByShx5nsIIutx9uHj9SUINml/BPBKH1rSk9H24C+Sbql+iK+jSJiQAFJnLvQ==
X-Received: by 2002:a05:6a20:4326:b0:1c4:d11d:4916 with SMTP id adf61e73a8af0-1c8ddff83b9mr1160558637.7.1723537645062;
        Tue, 13 Aug 2024 01:27:25 -0700 (PDT)
Received: from [192.168.104.75] ([223.118.51.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d396a5b5a0sm449164a91.0.2024.08.13.01.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 01:27:24 -0700 (PDT)
Message-ID: <f23c3b11-5fd3-4c9e-8920-bdc43f4e5113@linuxfoundation.org>
Date: Tue, 13 Aug 2024 02:27:19 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: resctrl: ignore builds for unsupported
 architectures
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: Muhammad Usama Anjum <Usama.Anjum@collabora.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Shaopeng Tan
 <tan.shaopeng@jp.fujitsu.com>, kernel@collabora.com,
 LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240809071059.265914-1-usama.anjum@collabora.com>
 <d60cf782-9ab0-ed4a-0b3e-ba7a73ae8d51@linux.intel.com>
 <080c4692-c53c-417f-9975-0b4ced0b044c@collabora.com>
 <f7593344-203a-8e73-d53e-574ca511d003@linux.intel.com>
 <4072bf51-1d37-4595-a2fa-b72f83c8298b@linuxfoundation.org>
 <6dd1b5ce-2ce2-4d61-beff-a100da213528@intel.com>
 <da87fe73-c39d-8b60-753d-7735c9abf569@linux.intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <da87fe73-c39d-8b60-753d-7735c9abf569@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/24 01:39, Ilpo Järvinen wrote:
> On Mon, 12 Aug 2024, Reinette Chatre wrote:
>> On 8/12/24 3:49 PM, Shuah Khan wrote:
>>> On 8/9/24 02:45, Ilpo Järvinen wrote:
>>>> Adding Maciej.
>>>>
>>>> On Fri, 9 Aug 2024, Muhammad Usama Anjum wrote:
>>>>> On 8/9/24 12:23 PM, Ilpo Järvinen wrote:
>>>>>> On Fri, 9 Aug 2024, Muhammad Usama Anjum wrote:
>>>>>>
>>>>>>> This test doesn't have support for other architectures. Altough
>>>>>>> resctrl
>>>>>>> is supported on x86 and ARM, but arch_supports_noncont_cat() shows
>>>>>>> that
>>>>>>> only x86 for AMD and Intel are supported by the test.
>>>>>>
>>>>>> One does not follow from the other. arch_supports_noncont_cat() is
>>>>>> only
>>>>>> small part of the tests so saying "This test" based on a small subset
>>>>>> of
>>>>>> all tests is bogus. Also, I don't see any reason why ARCH_ARM could
>>>>>> not be
>>>>>> added and arch_supports_noncont_cat() adapted accordingly.
>>>>> I'm not familiar with resctrl and the architectural part of it. Feel
>>>>> free to fix it and ignore this patch.
>>>>>
>>>>> If more things are missing than just adjusting
>>>>> arch_supports_noncont_cat(), the test should be turned off until proper
>>>>> support is added to the test.
>>>>>
>>>>>>> We get build
>>>>>>> errors when built for ARM and ARM64.
>>>>>>
>>>>>> As this seems the real reason, please quote any errors when you use
>>>>>> them
>>>>>> as justification so it can be reviewed if the reasoning is sound or
>>>>>> not.
>>>>>
>>>>>     CC       resctrl_tests
>>>>> In file included from resctrl.h:24,
>>>>>                    from cat_test.c:11:
>>>>> In function 'arch_supports_noncont_cat',
>>>>>       inlined from 'noncont_cat_run_test' at cat_test.c:323:6:
>>>>> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>>>>>      74 |         __asm__ __volatile__ ("cpuid\n\t"
>>>>>          \
>>>>>         |         ^~~~~~~
>>>>> cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
>>>>>     301 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>>>>>         |                 ^~~~~~~~~~~~~
>>>>> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>>>>>      74 |         __asm__ __volatile__ ("cpuid\n\t"
>>>>>          \
>>>>>         |         ^~~~~~~
>>>>> cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
>>>>>     303 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>>>>>         |                 ^~~~~~~~~~~~~
>>>>
>>>> Okay, so it's specific to lack of CPUID. This seems a kselftest common
>>>> level problem to me, since __cpuid_count() is provided in kselftest.h.
>>>>
>>>> Shuah (or others), what is the intended mechanism for selftests to know if
>>>> it can be used or not since as is, it's always defined?
>>> _cpuid_count() gets defined in ksefltest.h if it can't find it.
>>>
>>> As the comment says both gcc and cland probide __cpuid_count()
>>>
>>>     gcc cpuid.h provides __cpuid_count() since v4.4.
>>>     Clang/LLVM cpuid.h provides  __cpuid_count() since v3.4.0.
>>>
>>>>
>>>> I see some Makefiles use compile testing a trivial program to decide
>>>> whether
>>>> they build some x86_64 tests or not. Is that what should be done here too,
>>>> test if __cpuid_count() compiles or not (and then build some #ifdeffery
>>>> based on the result of that compile testing)?
>>>>
>>>
>>> These build errors need to be fixed instead of restricting the build> In
>>> some cases when the test can't be supported on an architecture then it is
>>> okay
>>> to suppress build. This is not a general solution to suppress build warnings
>>
>> While there is an effort to support Arm in resctrl [1], this is not currently
>> the case and the resctrl selftests as a consequence only support x86 with
>> built-in assumptions that a test runs on either AMD or Intel. After the kernel
>> gains support
>> for Arm more changes will be needed for the resctrl tests to support another
>> architecture
>> so I do think the most appropriate change to address this build failure is to
>> restrict
>> resctrl tests to x86.
> 
> While ARM lacks resctrl support at the moment (the patch BTW claims
> otherwise), this problem is general-level problem in selftests. When
> somebody includes kselftest.h, the header provided __cpuid_count() which
> seems to not be compilable on ARMs (even if the test itself would never
> call it on other than when running on Intel). Some #ifdeffery is necessary
> either in kselftest.h or in the test code.
> 
>>> I would recommend against adding suppress build code when it can be fixed.
>>
>> I expect after resctrl fs obtains support for Arm the resctrl selftests can be
>> updated to support it with more fine grained architectural checks than a
>> global
>> enable/disable needed at this time.
> 
> That won't help to a build failure. The build would fail on ARM even if
> there's some resctrl specific test for arch done by the test itself.

I see.
   
> 
>>> Let's investigate this problem to fix it properly. I don't see any arm and
>>> arm64
>>> maintainers and developers on this thread. It would be good to investigate
>>> to
>>> see if this can be fixed.
> 
> Yes, I was hoping there would be a general level solution which would
> provide e.g. HAS_CPUID_COUNT or an empty stub for __cpuid_count() or
> something along those lines.
Can we try to make this change?

thanks,
-- Shuah



