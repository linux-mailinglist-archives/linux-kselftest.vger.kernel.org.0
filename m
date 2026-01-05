Return-Path: <linux-kselftest+bounces-48168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B0CF1C94
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 05:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D270B3010981
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 04:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C2826ED5D;
	Mon,  5 Jan 2026 04:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Evot1JJQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VR/MY8PJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CBB211A09
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 04:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767585986; cv=none; b=rNnkb8bcwkfoZQW7rw+pGUn8qfbCMSvNxAX8hu3LJ7hmZsBcUXGiS2YXT6CfdAM+yVQ0y10lFPk8+Z+gMMkuEiCHaB6zYlu1vO+HxWbZM8PJBJ7LS5ADS3IZ9dwFda3GFC/P2uetpJmBfBHpNwXGQ0toiv1Qj2Szhy1DEPumUDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767585986; c=relaxed/simple;
	bh=2Ign9LzXnCZy9ShLfB1eXWY6kD08zIYXpywwJRNYm1w=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AvubxBF7a5857t3u4yyyNdR0wPcXEqVk6zlDkC9HwuTODNAd4xclyrTH8Q/WW583BIsQdlBt/wHYCXN0P6rv2eRJVa+gIZgb1XM/LizhhR7yTQYLLkYGAndPskYsIxR3kKG0J87uTQQVqjDYkT8j08DQHP2CUuwRKUTB2Jfks4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Evot1JJQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VR/MY8PJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767585984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2Ay0P6oqFz3kKz9b4RMbn0EQKm2M2v4BWX6Fzz7A2A=;
	b=Evot1JJQLdQmDoP04HBGNU7OoVTN8ajzhxYRxhktIGzED50dxG5apRBfSkc1mbXonhhoxE
	dejkAumH3KCRhlkBanRTIRdDTcbeRXyTW6o0h47m8KHhvKcwsMpGpD8qY6VbzhoFBymMds
	BGjd+rRqV8QQLjEkzgAzyOs3E50EwX0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-_fRtibLcP6GaszVx6jS9Tg-1; Sun, 04 Jan 2026 23:06:23 -0500
X-MC-Unique: _fRtibLcP6GaszVx6jS9Tg-1
X-Mimecast-MFC-AGG-ID: _fRtibLcP6GaszVx6jS9Tg_1767585982
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b24a25cff5so3999449885a.2
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jan 2026 20:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767585982; x=1768190782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F2Ay0P6oqFz3kKz9b4RMbn0EQKm2M2v4BWX6Fzz7A2A=;
        b=VR/MY8PJNpFne0kYp9v+X1Pwom2sjaq8GZGQPQ5jzlTMUFqbnD1W+vCq1Vo5L2zyKU
         J1/Bx8NbrS8Ste2tNN+vLr+5YCwE8lRmifcX+kO7g8EEVuxYkPQQ2aAP1tWz2QQDiZ23
         eJjQrZJnLJuVqis2J7+0MQEIQ/YPWTHUNUBqW9HeI8vSXlmPCEz2OX8bwHF6J8uAqCp7
         XK9un4LpcVkBOkJTpmx2Pc19/8uBx/kaB16XJtQ2wRiaoQk7+lTpMMWz9/fUdWRfNa1J
         /9tDtG0qncxq3iK9U1upilg9nOPNWxcTe/5sO/Fui9fhycXLiFB5Yb43agQy0ihFd59m
         bivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767585982; x=1768190782;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2Ay0P6oqFz3kKz9b4RMbn0EQKm2M2v4BWX6Fzz7A2A=;
        b=jEilKCh8+tMwTDhETzV8yXzcbeSgWQia6SVGd1aKHI4wm37TN99F5EFPIYtc80fSIv
         DTQwsJoQfGp9Va8oOd0FY1b6bxeqMll6LEgWv2u0WyThdoDFFtDFRYUX3CQX5jhbQBgr
         qVt0bxxMEcnlzeY9qFjo4FdFo2wWoOmSmEF+9E1qaTqLwTTqF8wP/iy66REySffgSHuu
         ugZJN9KbMixBSYRSDnQK5xkVQ3YusxFtY4qRQjrDxj7RXfAYfxVzUztw4aom/Aud/ZOR
         JJkOOVTxwKcOHvGWjk5gJGAu6w7v/ZQX15WMBPINhyKqU4XoZkjeHawizO58yD00wNUu
         cVWg==
X-Forwarded-Encrypted: i=1; AJvYcCX2zO096Keac9vUx+SALML4xnag4wADr3fdqIFVGQuA/MSbPa1jT67M9/6LTop9IvnLCZWgsNsPTscmQmsAZvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQA3omYwmAIRHoaCvhObU8ujVveA1xpVcfogzRd4UzbowWCsQy
	5pM60txefzxxuACeCDdq+chAzJ7dLMOprBtdCQNitEsDjh5yNzBlffEKa/hpfsK5mpvB9y0Ciaf
	WVVDTTg0pbXy6D6kEwbLOVaGEX2Rx1+FZMwxL784eD+24Rc2dMs6xy8/jwoGGGZd5aqJhGQ==
X-Gm-Gg: AY/fxX7UyFXvpqGtXx4smUWo/HoWm1KgMIVRFKZAn8DDV9g0uEDivKuM8QDvza1pqNz
	pXU/eN/7rOlp3MXFqpVZfeei9TtL0mlb4UHFfGMbR9auqM1KsoxtwGksjtGc3/D11j7RsvZdiU3
	U4cXGWD+iCNbgxJPzcLYPgqLMpGP+Moocfb/EYQ+XAXwN/U07liL033l979PbmlOwCOXWNSN6es
	UIL6KtFpY/luuUtL3ASv3df4o58vzKR+k4TkskClM6Bxhw5jslIQCfkFQY1wN+cXzDLSUUF7AQm
	35cT+8L5jByvzCYQZn7W84Dg5YCWdcQbZF297nuJwiZvJZ3NQ0WDhznwP5Y4DtrkccYfwLCtyA7
	TW+pOXFCYYIa7+n5sLnyQhWDFcVIK6stcqnaZhTM+xQdlOR3Q78Lwbi9E
X-Received: by 2002:a05:620a:4116:b0:8b5:5a03:36df with SMTP id af79cd13be357-8c08f657be8mr7018375685a.3.1767585982498;
        Sun, 04 Jan 2026 20:06:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZZcFdmlbUnig7+iVAJ2yL8eFlW7ffXYP0YAZ/rTdZzKW80JYYsX60b8bsdOJbWu6XqL3dCw==
X-Received: by 2002:a05:620a:4116:b0:8b5:5a03:36df with SMTP id af79cd13be357-8c08f657be8mr7018373585a.3.1767585982067;
        Sun, 04 Jan 2026 20:06:22 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9a44e314sm337005146d6.49.2026.01.04.20.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 20:06:21 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f541b93b-7bbf-4530-bca6-dc5b5b1f481c@redhat.com>
Date: Sun, 4 Jan 2026 23:06:20 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH v2 2/4] cgroup/cpuset: Consistently
 compute effective_xcpus in update_cpumasks_hier()
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260101191558.434446-1-longman@redhat.com>
 <20260101191558.434446-3-longman@redhat.com>
 <758f42df-52c2-4660-8ef7-1cbacb9323d2@huaweicloud.com>
 <f8539426-92b0-42f3-99c4-70962c2db96d@redhat.com>
 <c17051c3-82ac-4ca5-8823-33327cadd073@huaweicloud.com>
 <ec6e1ee4-b52e-417f-9413-3dfca0ec8eb3@redhat.com>
 <d49cc8af-509b-44b8-ada4-f8bbdbd37f89@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <d49cc8af-509b-44b8-ada4-f8bbdbd37f89@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/4/26 10:58 PM, Chen Ridong wrote:
>
> On 2026/1/5 11:50, Waiman Long wrote:
>> On 1/4/26 8:15 PM, Chen Ridong wrote:
>>> On 2026/1/5 5:25, Waiman Long wrote:
>>>> On 1/3/26 9:48 PM, Chen Ridong wrote:
>>>>> On 2026/1/2 3:15, Waiman Long wrote:
>>>>>> Since commit f62a5d39368e ("cgroup/cpuset: Remove remote_partition_check()
>>>>>> & make update_cpumasks_hier() handle remote partition"), the
>>>>>> compute_effective_exclusive_cpumask() helper was extended to
>>>>>> strip exclusive CPUs from siblings when computing effective_xcpus
>>>>>> (cpuset.cpus.exclusive.effective). This helper was later renamed to
>>>>>> compute_excpus() in commit 86bbbd1f33ab ("cpuset: Refactor exclusive
>>>>>> CPU mask computation logic").
>>>>>>
>>>>>> This helper is supposed to be used consistently to compute
>>>>>> effective_xcpus. However, there is an exception within the callback
>>>>>> critical section in update_cpumasks_hier() when exclusive_cpus of a
>>>>>> valid partition root is empty. This can cause effective_xcpus value to
>>>>>> differ depending on where exactly it is last computed. Fix this by using
>>>>>> compute_excpus() in this case to give a consistent result.
>>>>>>
>>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>>>> ---
>>>>>>     kernel/cgroup/cpuset.c | 14 +++++---------
>>>>>>     1 file changed, 5 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>>>> index da2b3b51630e..37d118a9ad4d 100644
>>>>>> --- a/kernel/cgroup/cpuset.c
>>>>>> +++ b/kernel/cgroup/cpuset.c
>>>>>> @@ -2168,17 +2168,13 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>>>>>>             spin_lock_irq(&callback_lock);
>>>>>>             cpumask_copy(cp->effective_cpus, tmp->new_cpus);
>>>>>>             cp->partition_root_state = new_prs;
>>>>>> -        if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
>>>>>> -            compute_excpus(cp, cp->effective_xcpus);
>>>>>> -
>>>>>>             /*
>>>>>> -         * Make sure effective_xcpus is properly set for a valid
>>>>>> -         * partition root.
>>>>>> +         * Need to compute effective_xcpus if either exclusive_cpus
>>>>>> +         * is non-empty or it is a valid partition root.
>>>>>>              */
>>>>>> -        if ((new_prs > 0) && cpumask_empty(cp->exclusive_cpus))
>>>>>> -            cpumask_and(cp->effective_xcpus,
>>>>>> -                    cp->cpus_allowed, parent->effective_xcpus);
>>>>>> -        else if (new_prs < 0)
>>>>>> +        if ((new_prs > 0) || !cpumask_empty(cp->exclusive_cpus))
>>>>>> +            compute_excpus(cp, cp->effective_xcpus);
>>>>>> +        if (new_prs < 0)
>>>>>>                 reset_partition_data(cp);
>>>>>>             spin_unlock_irq(&callback_lock);
>>>>>>     
>>>>> The code resets partition data only for new_prs < 0. My understanding is that a partition is
>>>>> invalid
>>>>> when new_prs <= 0. Shouldn't reset_partition_data() also be called when new_prs = 0? Is there a
>>>>> specific reason to skip the reset in that case?
>>>> update_cpumasks_hier() is called when changes in a cpuset or hotplug affects other cpusets in the
>>>> hierarchy. With respect to changes in partition state, it is either from valid to invalid or vice
>>>> versa. It will not change from a valid partition to member. The only way new_prs = 0 is when old_prs
>>>> = 0. Even if the affected cpuset is processed again in update_cpumask_hier(), any state change from
>>>> valid partition to member (update_prstate()), reset_partition_data() should have been called there.
>>>> That is why we only care about when new_prs != 0.
>>>>
>>> Thank you for your patience.
>>>
>>>> The code isn't wrong here. However I can change the condition to (new_prs <= 0) if it makes it
>>>> easier to understand.
>>>>
>>> I agree there's nothing wrong with the current logic. However, for clarity, I suggest changing the
>>> condition to (new_prs <= 0). This allows the function's logic to be fully self-consistent and
>>> focused on a single responsibility. This approach would allow us to simplify the code to:
>>>
>>>      if (new_prs > 0)
>>>          compute_excpus(cp, cp->effective_xcpus);
>>>      else
>>>          reset_partition_data(cp);
>>>
>>> Since reset_partition_data() already handles cases whether cp->exclusive_cpus is empty or not, this
>>> implementation would be more concise while correctly covering all scenarios.
>> effective_xcpus should be set when exclusive_cpus is not empty or when the cpuset is a valid
>> partition root. So just checking new_prs for compute_excpus() is not enough.
>>
> If we change the condition to (new_prs <= 0), it will reset the partition data even when we call
> compute_excpus (for !cpumask_empty(cp->exclusive_cpus)), so we should still get the same result, right?

Changing the condition to (new_prs <= 0) won't affect the result except 
for a bit of wasted cpu cycles. That is why I am planning to make the 
change in the next version to make it easier to understand.

Cheers,
Longman


