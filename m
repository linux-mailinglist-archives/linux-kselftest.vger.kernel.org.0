Return-Path: <linux-kselftest+bounces-17202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC696CECD
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 07:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F131B2552C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 05:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC4915884D;
	Thu,  5 Sep 2024 05:56:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945F414F11E;
	Thu,  5 Sep 2024 05:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725515774; cv=none; b=lF4xh2C+6qgspmLgUmrCr+1gsPMtJiuOoWoHHLGww/ZYhOb1lS8kKIScKGpdvlmj8GpMJfw+GKn8MkPXkEF3FzSj/cs6S5AeH+BZFT2lfXkjnMZy9djNUNoMge5L1fqhH1KM4oePhTVkMry6xXUqACvsBUjY76Uip4ZJwdlvVyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725515774; c=relaxed/simple;
	bh=s573o035Y8vJxz/3lvfL3h7JspJd2/fPU+s90l7e8W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bn0Z1xLqa7qGUsu8fzmw/j4dBALmTSrEfLwcOgzweM0o0j7UGismpahpENOj3Shk7P08vUqN1ZfsG4EwoVZ4yBhnqbETiF4bQfxPHMyC2vo8PXIxEkP33sM/tkszCLrR3PYzfKht7UOGkvM97iktL0kDbn/0vSGkf+Ui1d6xzJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E49BFEC;
	Wed,  4 Sep 2024 22:56:37 -0700 (PDT)
Received: from [10.162.43.13] (e116581.arm.com [10.162.43.13])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC93B3F73F;
	Wed,  4 Sep 2024 22:56:05 -0700 (PDT)
Message-ID: <0b3af60f-0449-48a1-b228-f26618b9d50a@arm.com>
Date: Thu, 5 Sep 2024 11:26:02 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] selftests: Rename sigaltstack to generic signal
To: Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org, oleg@redhat.com
Cc: mingo@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
 ryan.roberts@arm.com, broonie@kernel.org, suzuki.poulose@arm.com,
 Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
 aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, sj@kernel.org
References: <20240822121415.3589190-1-dev.jain@arm.com>
 <20240822121415.3589190-2-dev.jain@arm.com>
 <714f8eb4-b226-48f6-ab0d-75bdfbf83364@linuxfoundation.org>
 <42d0fa4b-eb67-42fd-a8e1-05d159d0d52f@arm.com>
 <806e4be0-4b1f-4818-806f-a844d952d54e@arm.com>
 <fff2b685-a7a5-4260-a293-f2abf55d9ce4@linuxfoundation.org>
 <514713eb-235c-40ee-8c25-f1f3e1ca7f7a@arm.com>
 <d5dc1bd9-4473-405f-99fc-192691f41c4f@linuxfoundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <d5dc1bd9-4473-405f-99fc-192691f41c4f@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/4/24 22:35, Shuah Khan wrote:
> On 9/3/24 22:52, Dev Jain wrote:
>>
>> On 9/4/24 03:14, Shuah Khan wrote:
>>> On 8/30/24 10:29, Dev Jain wrote:
>>>>
>>>> On 8/27/24 17:16, Dev Jain wrote:
>>>>>
>>>>> On 8/27/24 17:14, Shuah Khan wrote:
>>>>>> On 8/22/24 06:14, Dev Jain wrote:
>>>>>>> Rename sigaltstack to generic signal directory, to allow adding 
>>>>>>> more
>>>>>>> signal tests in the future.
>>>>>>
>>>>>> Sorry - I think I mentioned I don't like this test renamed. Why 
>>>>>> are you sending
>>>>>> this rename still included in the patch series?
>>>>>
>>>>> I am not renaming the test, just the directory. The directory name
>>>>> is changed to signal, and I have retained the name of the test -
>>>>> sas.c.
>>>>
>>>> Gentle ping: I guess there was a misunderstanding; in v5, I was
>>>> also changing the name of the test, to which you objected, and
>>>> I agreed. But, we need to change the name of the directory since
>>>> the new test has no relation to the current directory name,
>>>> "sigaltstack". The patch description explains that the directory
>>>> should be generically named.
>>>>
>>>
>>> Right. You are no longer changing the test name. You are still
>>> changing the directory name. The problem I mentioned stays the
>>> same. Any fixes to the existing tests in this directory can no
>>> longer auto applied to stables releases.
>>
>> I understand your point, but commit baa489fabd01 (selftests/vm: rename
>> selftests/vm to selftests/mm) is also present. That was a lot bigger 
>> change;
>> sigaltstack contains just one test currently, whose fixes possibly 
>> would have
>> to be backported, so I guess it should not be that much of a big 
>> problem?
>>
>>>
>
> So who does the backports whenevenr something changes? You are adding
> work where as the automated process would just work without this
> change. It doesn't matter if there is another test that changed
> the name.
>
>>> Other than the desire to rename the directory to generic, what
>>> other value does this change bring?
>>
>> Do you have an alternative suggestion as to where I should put my new 
>> test then;
>> I do not see what is the value of creating another directory to just 
>> include
>> my test. This will unnecessarily clutter the selftests/ directory with
>> directories containing single tests. And, putting this in 
>> "sigaltstack" is just
>> wrong since this test has no relation with sigaltstack.
>>
>
> If this new test has no relation to sigaltstack, then why are you 
> changing
> and renaming the sigaltstack directory?

Because the functionality I am testing is of signals, and signals are a 
superset
of sigaltstack. Still, I can think of a compromise, if semantically you 
want to
consider the new test as not testing signals, but a specific syscall 
"sigaction"
and its interaction with blocking of signals, how about naming the new 
directory "sigaction"?
> Adding a new directory is much better
> than going down a path that is more confusing and adding backport 
> overhead.
>
> Two options:
> -- Add a new directory or add a note and keep it under sigaltstack
> -- Do you foresee this new growing?
>
> thanks,
> -- Shuah
>
>

