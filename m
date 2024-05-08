Return-Path: <linux-kselftest+bounces-9694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A428BF96C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 11:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A531F23AD2
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 09:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A28974404;
	Wed,  8 May 2024 09:14:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2B874C04;
	Wed,  8 May 2024 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715159650; cv=none; b=AcizFSOcfc4Y5WykACnPohUUrz045Crojl0CiX0MawZhprosvZ1bGMEoiLtYBbIOQMJfIqyBJNXd73mN0eJhLzJXKUeTz3S0t72Krvg9Hs9pNGpwsNR5ZP1kwbSusw/Wh4uit/kRumC/jE5tqbRBPYSurzbx5LNsRD00I4mWAWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715159650; c=relaxed/simple;
	bh=tF4iPughT/n6gbDG+mQ6IlbX52BIyWj5CwATxGx4kxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvMazrPrnEc4VRZ0SRev5MAZQFVovhI1W4kD4wpPsgdszSOOXgJRXvmVkR8eOcg1xCsDuLqNqlYEi0wd737Jy22Q87qYPju+Q7q5HXiK3IyImkyjJF9CCWUBNzxPC3BTd6kxAGyZyB6DvOylUGGhxgSRZlkGwwKEqK2BxYHXqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 606F81063;
	Wed,  8 May 2024 02:14:33 -0700 (PDT)
Received: from [10.57.67.194] (unknown [10.57.67.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A8C83F6A8;
	Wed,  8 May 2024 02:14:06 -0700 (PDT)
Message-ID: <c7a1fa3a-3e0a-4da4-8bdc-8d5b98d662c0@arm.com>
Date: Wed, 8 May 2024 10:14:05 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mqueue: fix 5 warnings about signed/unsigned
 mismatches
Content-Language: en-GB
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240505221359.65258-1-jhubbard@nvidia.com>
 <a340524c-15c1-4b8e-b7a9-1fad52e97f69@arm.com>
 <c8dd4b34-f49a-4929-9b14-d2cc17e0edd8@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <c8dd4b34-f49a-4929-9b14-d2cc17e0edd8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/05/2024 18:04, John Hubbard wrote:
> On 5/7/24 12:54 AM, Ryan Roberts wrote:
>> On 05/05/2024 23:13, John Hubbard wrote:
> ...
>>> diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c
>>> b/tools/testing/selftests/mqueue/mq_perf_tests.c
>>> index 5c16159d0bcd..fb898850867c 100644
>>> --- a/tools/testing/selftests/mqueue/mq_perf_tests.c
>>> +++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
>>> @@ -323,7 +323,8 @@ void *fake_cont_thread(void *arg)
>>>   void *cont_thread(void *arg)
>>>   {
>>>       char buff[MSG_SIZE];
>>> -    int i, priority;
>>> +    int i;
>>> +    unsigned int priority;
>>>         for (i = 0; i < num_cpus_to_pin; i++)
>>>           if (cpu_threads[i] == pthread_self())
>>> @@ -425,7 +426,8 @@ struct test test2[] = {
>>>   void *perf_test_thread(void *arg)
>>>   {
>>>       char buff[MSG_SIZE];
>>> -    int prio_out, prio_in;
>>> +    int prio_out;
>>
>> It feels a bit odd for prio_out and prio_in to have different types. I don't
>> have any prior familiararity with these tests but looks like they are ultimately
>> the parameters of mq_send() and mq_receive() which both define them as unsigned
>> ints. Perhaps both should be converted?
> 
> 
> This makes sense, and I recall wondering about it. Looking at it again,
> I see why didn't go that far: there is a mini-unit test manager inside,
> passing around priorities that are signed, throughout:
> 
>         struct test {
>             char *desc; void (*func)(int *);
>         };
> 
>         ...
> 
>         void inc_prio(int *prio) {
>             if (++*prio == mq_prio_max)
>                 *prio = 0;
>         }
> 
> However, I can probably fix up everything to match up. Given that you've
> called it out, I'll go ahead with that approach. Iit will be quite a few
> changes but they will all be trivial too.     

Ahh I see. It would certainly be an improvement, but if you don't think it's
worth the effort, then don't feel you need to do it on my account.

  
> 
> 
> thanks,


