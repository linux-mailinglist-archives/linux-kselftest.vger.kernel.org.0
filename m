Return-Path: <linux-kselftest+bounces-15200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B5F94FFC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 10:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D433E1F216D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 08:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4324813A244;
	Tue, 13 Aug 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gaXl6EyJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3A2139D19
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537518; cv=none; b=ImomNttpBw4FZNPSP+UGsXyZH4thPHRh02zIEyDQPGayO2mzpD+DZepwCSe/7ewk7UlzGVXOI1u7PFvTvvC8r7GH8eanZD9hukaCv7iRP8cDhdWIa5vtgDkQoi5UkrNtgf5+jNmdfRQOkQf1P1pnShEVNZNR/YK9f++xD1E4u6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537518; c=relaxed/simple;
	bh=ticLzo1D1Z1sjZgeDlR6Zve8BS6KFbGk+IUK2ukCi0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAlnyPpItk+mo0NYXn3hIaVSIGaQ9PlDzVzXYKGPuD9IGa/cBYQ94feimz+RliINrjM0aq0iuFbNIwPEOdjcfHxOBWg5yKKgrWUKudpkOIRQEDcbSDEMg+UEcKQ0mXcWFGIK9qSB2EB6s8ZbMkZYZPGVuCQe2D308SHksYIqn4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gaXl6EyJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fdb28b1c16so2079955ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 01:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723537516; x=1724142316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BEVQUoupjy6wk58i7p/fsO85d4SvbuK+rKeOG6aigEM=;
        b=gaXl6EyJO+y8Y718fexPjOc7v7fiLfQhIoi9yFUjimF2oCiX03m+qHka+ngqLrpup/
         AFpf6RzI3k1vujQcgz+JUdkv/HVg4IguyWZ/T55QE5rUu2xmCe5xLkWBaF00z28D2NWX
         iTYglWMjKQfLREG6ewUk5R0u8weUwTVy+UtwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723537516; x=1724142316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BEVQUoupjy6wk58i7p/fsO85d4SvbuK+rKeOG6aigEM=;
        b=O0g+KjP7Ecvoy2sapBdr1X9C3vGk3qADjOuX0Q+OQJj+pr29VIO9dLbBQwuyHevdQR
         6mT2OgeaRPOtSVg2LkCklDNJta44bMkaZsccUaOLM4M2Kxb9WbslAjqQf4zpjxE9bOn0
         /ZExYAdJipoGil3IxWQls84A+xlZMbCDTiDdqWL29jLJ3nPdUWgX4nKhPn7ZfUH6i7pi
         4n3P8OWwMVEseUMNz0G10tW1cIkB1ZcNqsMxITXMTLP0m93CtkZFR2IeDYrwhjP7LlPz
         Nbx8ffGkX3XPi6K7WbS1nWZ/+yCCaXsLigtC/0ckLeWkEN6NE54Ma20p1X2CUGavQj/w
         KyXA==
X-Forwarded-Encrypted: i=1; AJvYcCVr4leLq3nk2cBZUELYOOW8pEyaczOa/1c3Rksa9l/e+ebxyhh+TMeRReoPtGb3GosFe2GeMh5XmqdGkTnfZq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNNTqq5XBEwYRGIf12uhk/lA+JVZDjCa3cofiS9qRoonOPNs16
	ZsuydmnjEmItDQiKs6wr7r+lu9h6omLwUOJLBKX7Tp5oMg7C/8iZor6pfkmr2hM=
X-Google-Smtp-Source: AGHT+IEzerHMMnSocDJNSeStQIOJD4TADhd5o4PWjCgbclTFtVtQtLu0V2Mdoxxa/g9NHeXq3eD+Ag==
X-Received: by 2002:a17:902:dac3:b0:1fc:52f4:1802 with SMTP id d9443c01a7336-201cdb4e08dmr9870845ad.10.1723537515728;
        Tue, 13 Aug 2024 01:25:15 -0700 (PDT)
Received: from [192.168.104.75] ([223.118.51.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1aa017sm8496045ad.143.2024.08.13.01.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 01:25:15 -0700 (PDT)
Message-ID: <98d8f119-02f7-49af-a891-cb13bd9f9a2d@linuxfoundation.org>
Date: Tue, 13 Aug 2024 02:25:10 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: resctrl: ignore builds for unsupported
 architectures
To: Reinette Chatre <reinette.chatre@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, kernel@collabora.com,
 LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240809071059.265914-1-usama.anjum@collabora.com>
 <d60cf782-9ab0-ed4a-0b3e-ba7a73ae8d51@linux.intel.com>
 <080c4692-c53c-417f-9975-0b4ced0b044c@collabora.com>
 <f7593344-203a-8e73-d53e-574ca511d003@linux.intel.com>
 <4072bf51-1d37-4595-a2fa-b72f83c8298b@linuxfoundation.org>
 <6dd1b5ce-2ce2-4d61-beff-a100da213528@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <6dd1b5ce-2ce2-4d61-beff-a100da213528@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/12/24 18:05, Reinette Chatre wrote:
> Hi Shuah,
> 
> On 8/12/24 3:49 PM, Shuah Khan wrote:
>> On 8/9/24 02:45, Ilpo Järvinen wrote:
>>> Adding Maciej.
>>>
>>> On Fri, 9 Aug 2024, Muhammad Usama Anjum wrote:
>>>> On 8/9/24 12:23 PM, Ilpo Järvinen wrote:
>>>>> On Fri, 9 Aug 2024, Muhammad Usama Anjum wrote:
>>>>>
>>>>>> This test doesn't have support for other architectures. Altough resctrl
>>>>>> is supported on x86 and ARM, but arch_supports_noncont_cat() shows that
>>>>>> only x86 for AMD and Intel are supported by the test.
>>>>>
>>>>> One does not follow from the other. arch_supports_noncont_cat() is only
>>>>> small part of the tests so saying "This test" based on a small subset of
>>>>> all tests is bogus. Also, I don't see any reason why ARCH_ARM could not be
>>>>> added and arch_supports_noncont_cat() adapted accordingly.
>>>> I'm not familiar with resctrl and the architectural part of it. Feel
>>>> free to fix it and ignore this patch.
>>>>
>>>> If more things are missing than just adjusting
>>>> arch_supports_noncont_cat(), the test should be turned off until proper
>>>> support is added to the test.
>>>>
>>>>>> We get build
>>>>>> errors when built for ARM and ARM64.
>>>>>
>>>>> As this seems the real reason, please quote any errors when you use them
>>>>> as justification so it can be reviewed if the reasoning is sound or not.
>>>>
>>>>    CC       resctrl_tests
>>>> In file included from resctrl.h:24,
>>>>                   from cat_test.c:11:
>>>> In function 'arch_supports_noncont_cat',
>>>>      inlined from 'noncont_cat_run_test' at cat_test.c:323:6:
>>>> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>>>>     74 |         __asm__ __volatile__ ("cpuid\n\t"
>>>>         \
>>>>        |         ^~~~~~~
>>>> cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
>>>>    301 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>>>>        |                 ^~~~~~~~~~~~~
>>>> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>>>>     74 |         __asm__ __volatile__ ("cpuid\n\t"
>>>>         \
>>>>        |         ^~~~~~~
>>>> cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
>>>>    303 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>>>>        |                 ^~~~~~~~~~~~~
>>>
>>> Okay, so it's specific to lack of CPUID. This seems a kselftest common
>>> level problem to me, since __cpuid_count() is provided in kselftest.h.
>>>
>>> Shuah (or others), what is the intended mechanism for selftests to know if
>>> it can be used or not since as is, it's always defined?
>> _cpuid_count() gets defined in ksefltest.h if it can't find it.
>>
>> As the comment says both gcc and cland probide __cpuid_count()
>>
>>    gcc cpuid.h provides __cpuid_count() since v4.4.
>>    Clang/LLVM cpuid.h provides  __cpuid_count() since v3.4.0.
>>
>>>
>>> I see some Makefiles use compile testing a trivial program to decide whether
>>> they build some x86_64 tests or not. Is that what should be done here too,
>>> test if __cpuid_count() compiles or not (and then build some #ifdeffery
>>> based on the result of that compile testing)?
>>>
>>
>> These build errors need to be fixed instead of restricting the build> In some cases when the test can't be supported on an architecture then it is okay
>> to suppress build. This is not a general solution to suppress build warnings
> 
> While there is an effort to support Arm in resctrl [1], this is not currently
> the case and the resctrl selftests as a consequence only support x86 with
> built-in assumptions that a test runs on either AMD or Intel. After the kernel gains support
> for Arm more changes will be needed for the resctrl tests to support another architecture
> so I do think the most appropriate change to address this build failure is to restrict
> resctrl tests to x86.
> 

Sounds good to me. This would be good case for suppressing test build.

>>
>> I would recommend against adding suppress build code when it can be fixed.
> 
> I expect after resctrl fs obtains support for Arm the resctrl selftests can be
> updated to support it with more fine grained architectural checks than a global
> enable/disable needed at this time.
> 
>>
>> Let's investigate this problem to fix it properly. I don't see any arm and arm64
>> maintainers and developers on this thread. It would be good to investigate to
>> see if this can be fixed.

thanks,
-- Shuah

