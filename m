Return-Path: <linux-kselftest+bounces-19138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9D09923A6
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 06:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1951F21063
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 04:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A15A61FCE;
	Mon,  7 Oct 2024 04:37:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A40810A1C;
	Mon,  7 Oct 2024 04:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728275859; cv=none; b=hJiDhXUs9XpBjRPE89r0vmchflabQ1agtdkEokmwBkUd0swghMcEchDvmB822B5+n27ypCWSvnO1VHHdMhXj86z1/jmAIl50nXptDyH355El7L4bro/iztwVERQpX85kf1ZcEpyBH9IlZtoMToN7qziACQMjdYX48O4ZPo3Lk+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728275859; c=relaxed/simple;
	bh=T35S/DgpRJqqEin38uykAt6yEO3kleccsAZmlNz1yEU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JNYRstluJh5Y2AlkCtcpBjEGyVdXL2bv48N3SApNtLy2W034mUDtBc/ItTqY83nX7f4Fd2iQWcYkRZ1TDZxPTlF8M/kG7UmVsnXlpBi6PZ4FOaDaDbSmYa9sziMVrh/Y1se1MTuuFyszidlTm/wHu0fU9vUiKayK77oh2L2NWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B51FAFEC;
	Sun,  6 Oct 2024 21:38:05 -0700 (PDT)
Received: from [10.162.40.20] (e116581.arm.com [10.162.40.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 503E23F640;
	Sun,  6 Oct 2024 21:37:30 -0700 (PDT)
Message-ID: <5400ac3c-f730-4ede-a35a-7d9cc79bf997@arm.com>
Date: Mon, 7 Oct 2024 10:07:24 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH v6 1/2] selftests: Rename sigaltstack to generic signal
To: Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org, oleg@redhat.com
Cc: mingo@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
 ryan.roberts@arm.com, broonie@kernel.org, suzuki.poulose@arm.com,
 Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
 aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, sj@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
References: <20240822121415.3589190-1-dev.jain@arm.com>
 <20240822121415.3589190-2-dev.jain@arm.com>
 <714f8eb4-b226-48f6-ab0d-75bdfbf83364@linuxfoundation.org>
 <42d0fa4b-eb67-42fd-a8e1-05d159d0d52f@arm.com>
 <806e4be0-4b1f-4818-806f-a844d952d54e@arm.com>
 <fff2b685-a7a5-4260-a293-f2abf55d9ce4@linuxfoundation.org>
 <514713eb-235c-40ee-8c25-f1f3e1ca7f7a@arm.com>
 <d5dc1bd9-4473-405f-99fc-192691f41c4f@linuxfoundation.org>
 <0b3af60f-0449-48a1-b228-f26618b9d50a@arm.com>
 <fcdbd8bc-9986-497e-8de4-86d3e619ca73@linuxfoundation.org>
 <03c5b10d-b81c-4074-9c27-8ffc8c7fc84a@arm.com>
 <cb2f88e0-8e31-43a0-a5ea-03f0ab05417e@linuxfoundation.org>
 <e497c022-549f-4adf-83f8-8f8c54d7c998@arm.com>
Content-Language: en-US
In-Reply-To: <e497c022-549f-4adf-83f8-8f8c54d7c998@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/16/24 09:28, Dev Jain wrote:
>
> On 9/9/24 23:24, Shuah Khan wrote:
>> On 9/8/24 23:16, Dev Jain wrote:
>>>
>>> On 9/7/24 01:29, Shuah Khan wrote:
>>>> On 9/4/24 23:56, Dev Jain wrote:
>>>>>
>>>>> On 9/4/24 22:35, Shuah Khan wrote:
>>>>>> On 9/3/24 22:52, Dev Jain wrote:
>>>>>>>
>>>>>>> On 9/4/24 03:14, Shuah Khan wrote:
>>>>>>>> On 8/30/24 10:29, Dev Jain wrote:
>>>>>>>>>
>>>>>>>>> On 8/27/24 17:16, Dev Jain wrote:
>>>>>>>>>>
>>>>>>>>>> On 8/27/24 17:14, Shuah Khan wrote:
>>>>>>>>>>> On 8/22/24 06:14, Dev Jain wrote:
>>>>>>>>>>>> Rename sigaltstack to generic signal directory, to allow 
>>>>>>>>>>>> adding more
>>>>>>>>>>>> signal tests in the future.
>>>>>>>>>>>
>>>>>>>>>>> Sorry - I think I mentioned I don't like this test renamed. 
>>>>>>>>>>> Why are you sending
>>>>>>>>>>> this rename still included in the patch series?
>>>>>>>>>>
>>>>>>>>>> I am not renaming the test, just the directory. The directory 
>>>>>>>>>> name
>>>>>>>>>> is changed to signal, and I have retained the name of the test -
>>>>>>>>>> sas.c.
>>>>>>>>>
>>>>>>>>> Gentle ping: I guess there was a misunderstanding; in v5, I was
>>>>>>>>> also changing the name of the test, to which you objected, and
>>>>>>>>> I agreed. But, we need to change the name of the directory since
>>>>>>>>> the new test has no relation to the current directory name,
>>>>>>>>> "sigaltstack". The patch description explains that the directory
>>>>>>>>> should be generically named.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Right. You are no longer changing the test name. You are still
>>>>>>>> changing the directory name. The problem I mentioned stays the
>>>>>>>> same. Any fixes to the existing tests in this directory can no
>>>>>>>> longer auto applied to stables releases.
>>>>>>>
>>>>>>> I understand your point, but commit baa489fabd01 (selftests/vm: 
>>>>>>> rename
>>>>>>> selftests/vm to selftests/mm) is also present. That was a lot 
>>>>>>> bigger change;
>>>>>>> sigaltstack contains just one test currently, whose fixes 
>>>>>>> possibly would have
>>>>>>> to be backported, so I guess it should not be that much of a big 
>>>>>>> problem?
>>>>>>>
>>>>>>>>
>>>>>>
>>>>>> So who does the backports whenevenr something changes? You are 
>>>>>> adding
>>>>>> work where as the automated process would just work without this
>>>>>> change. It doesn't matter if there is another test that changed
>>>>>> the name.
>>>>>>
>>>>>>>> Other than the desire to rename the directory to generic, what
>>>>>>>> other value does this change bring?
>>>>>>>
>>>>>>> Do you have an alternative suggestion as to where I should put 
>>>>>>> my new test then;
>>>>>>> I do not see what is the value of creating another directory to 
>>>>>>> just include
>>>>>>> my test. This will unnecessarily clutter the selftests/ 
>>>>>>> directory with
>>>>>>> directories containing single tests. And, putting this in 
>>>>>>> "sigaltstack" is just
>>>>>>> wrong since this test has no relation with sigaltstack.
>>>>>>>
>>>>>>
>>>>>> If this new test has no relation to sigaltstack, then why are you 
>>>>>> changing
>>>>>> and renaming the sigaltstack directory?
>>>>>
>>>>> Because the functionality I am testing is of signals, and signals 
>>>>> are a superset
>>>>> of sigaltstack. Still, I can think of a compromise, if 
>>>>> semantically you want to
>>>>> consider the new test as not testing signals, but a specific 
>>>>> syscall "sigaction"
>>>>> and its interaction with blocking of signals, how about naming the 
>>>>> new directory "sigaction"?
>>>>>> Adding a new directory is much better
>>>>>> than going down a path that is more confusing and adding backport 
>>>>>> overhead.
>>>>>>
>>>>
>>>> Okay - they are related except that you view signalstack as a subset
>>>> of signals. I saw Mark's response as well saying sigaction isn't
>>>> a good name for this.
>>>>
>>>> Rename usually wipe out git history as well based on what have seen
>>>> in the past.
>>>>
>>>> My main concern is backports. Considering sigstack hasn't changed
>>>> 2021 (as Mark's email), let's rename it.
>>>>
>>>> I am reluctantly agreeing to the rename as it seems to make sense
>>>> in this case.
>>>
>>> Thanks! I guess there is no update required from my side, and you can
>>> pull this series?
>>>>
>>
>> I can pull this with x86v maintainer ack.
>>
>> Or to go through x86 tree:
>>
>> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>>
> Gentle ping, adding all x86 maintainers and the x86 list, in case they 
> missed.

Gentle ping

