Return-Path: <linux-kselftest+bounces-48694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4782D103B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 02:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D9D7303ADDF
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 01:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2777215F7D;
	Mon, 12 Jan 2026 01:10:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EE842A96;
	Mon, 12 Jan 2026 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768180249; cv=none; b=Qtmrw37xn50yKgccrEoKtrZM1gMd0mXhjkImWqR67050YOLokUgKxwlAvH7jXbgMzSj/kk+hMeCB1oZDJIpVGXK0O2b6Cs+s6FZjc+VnexOKExoPfhyVeodHvm0jjXc2OUzAJrou0FkC2nZk7fEjuDcRg+tgD4QSvgt/cod/Jyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768180249; c=relaxed/simple;
	bh=1pQzOTwfMQIfuYIUNtNElPe+4MjbbYSkjiBUwA7Kbvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixvd1+tT97NkuVUHkN9aDabc50uZNwzk/VppSk216Gx6WJ/MAWKP0CoPmTpzIbChdTbgaHQkGmrZF4T+5h215+0UU3HpawjuDxG2p2edrpVe2NAx6qXl1Hl+c033WttR9JUxsqhx+Y0u/r6G1/TytoZ6eTe5VumAk4jOwlG3IYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dqDnx1blDzYQtjy;
	Mon, 12 Jan 2026 09:10:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B6FBD40574;
	Mon, 12 Jan 2026 09:10:38 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgDHKPkNSmRp7hHxDQ--.1037S2;
	Mon, 12 Jan 2026 09:10:38 +0800 (CST)
Message-ID: <a3ad07c1-1b15-48f4-b81e-a459504558f9@huaweicloud.com>
Date: Mon, 12 Jan 2026 09:10:36 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH v2 2/4] cgroup/cpuset: Consistently
 compute effective_xcpus in update_cpumasks_hier()
To: Waiman Long <llong@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
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
 <f541b93b-7bbf-4530-bca6-dc5b5b1f481c@redhat.com>
 <556672f7-b9b9-46a2-8a67-54ac615383d4@huaweicloud.com>
 <0384dc28-bfff-4a74-9153-66d287888ce7@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <0384dc28-bfff-4a74-9153-66d287888ce7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKPkNSmRp7hHxDQ--.1037S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFy8KFyxCFy3CF4kGryfJFb_yoWxKFWfpr
	y8JF4UJrWUtr1rC3yUKF17Xry8tr4Dtw1DXw1DJF1rXFyDKF1jqr1jqws09r1UJr4kJr15
	Ar1UXr47ZF1DArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2026/1/10 4:15, Waiman Long wrote:
> On 1/5/26 1:29 AM, Chen Ridong wrote:
>>
>> On 2026/1/5 12:06, Waiman Long wrote:
>>> On 1/4/26 10:58 PM, Chen Ridong wrote:
>>>> On 2026/1/5 11:50, Waiman Long wrote:
>>>>> On 1/4/26 8:15 PM, Chen Ridong wrote:
>>>>>> On 2026/1/5 5:25, Waiman Long wrote:
>>>>>>> On 1/3/26 9:48 PM, Chen Ridong wrote:
>>>>>>>> On 2026/1/2 3:15, Waiman Long wrote:
>>>>>>>>> Since commit f62a5d39368e ("cgroup/cpuset: Remove remote_partition_check()
>>>>>>>>> & make update_cpumasks_hier() handle remote partition"), the
>>>>>>>>> compute_effective_exclusive_cpumask() helper was extended to
>>>>>>>>> strip exclusive CPUs from siblings when computing effective_xcpus
>>>>>>>>> (cpuset.cpus.exclusive.effective). This helper was later renamed to
>>>>>>>>> compute_excpus() in commit 86bbbd1f33ab ("cpuset: Refactor exclusive
>>>>>>>>> CPU mask computation logic").
>>>>>>>>>
>>>>>>>>> This helper is supposed to be used consistently to compute
>>>>>>>>> effective_xcpus. However, there is an exception within the callback
>>>>>>>>> critical section in update_cpumasks_hier() when exclusive_cpus of a
>>>>>>>>> valid partition root is empty. This can cause effective_xcpus value to
>>>>>>>>> differ depending on where exactly it is last computed. Fix this by using
>>>>>>>>> compute_excpus() in this case to give a consistent result.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>>>>>>> ---
>>>>>>>>>      kernel/cgroup/cpuset.c | 14 +++++---------
>>>>>>>>>      1 file changed, 5 insertions(+), 9 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>>>>>>> index da2b3b51630e..37d118a9ad4d 100644
>>>>>>>>> --- a/kernel/cgroup/cpuset.c
>>>>>>>>> +++ b/kernel/cgroup/cpuset.c
>>>>>>>>> @@ -2168,17 +2168,13 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks
>>>>>>>>> *tmp,
>>>>>>>>>              spin_lock_irq(&callback_lock);
>>>>>>>>>              cpumask_copy(cp->effective_cpus, tmp->new_cpus);
>>>>>>>>>              cp->partition_root_state = new_prs;
>>>>>>>>> -        if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
>>>>>>>>> -            compute_excpus(cp, cp->effective_xcpus);
>>>>>>>>> -
>>>>>>>>>              /*
>>>>>>>>> -         * Make sure effective_xcpus is properly set for a valid
>>>>>>>>> -         * partition root.
>>>>>>>>> +         * Need to compute effective_xcpus if either exclusive_cpus
>>>>>>>>> +         * is non-empty or it is a valid partition root.
>>>>>>>>>               */
>>>>>>>>> -        if ((new_prs > 0) && cpumask_empty(cp->exclusive_cpus))
>>>>>>>>> -            cpumask_and(cp->effective_xcpus,
>>>>>>>>> -                    cp->cpus_allowed, parent->effective_xcpus);
>>>>>>>>> -        else if (new_prs < 0)
>>>>>>>>> +        if ((new_prs > 0) || !cpumask_empty(cp->exclusive_cpus))
>>>>>>>>> +            compute_excpus(cp, cp->effective_xcpus);
>>>>>>>>> +        if (new_prs < 0)
>>>>>>>>>                  reset_partition_data(cp);
>>>>>>>>>              spin_unlock_irq(&callback_lock);
>>>>>>>>>      
>>>>>>>> The code resets partition data only for new_prs < 0. My understanding is that a partition is
>>>>>>>> invalid
>>>>>>>> when new_prs <= 0. Shouldn't reset_partition_data() also be called when new_prs = 0? Is there a
>>>>>>>> specific reason to skip the reset in that case?
>>>>>>> update_cpumasks_hier() is called when changes in a cpuset or hotplug affects other cpusets in
>>>>>>> the
>>>>>>> hierarchy. With respect to changes in partition state, it is either from valid to invalid or
>>>>>>> vice
>>>>>>> versa. It will not change from a valid partition to member. The only way new_prs = 0 is when
>>>>>>> old_prs
>>>>>>> = 0. Even if the affected cpuset is processed again in update_cpumask_hier(), any state change
>>>>>>> from
>>>>>>> valid partition to member (update_prstate()), reset_partition_data() should have been called
>>>>>>> there.
>>>>>>> That is why we only care about when new_prs != 0.
>>>>>>>
>>>>>> Thank you for your patience.
>>>>>>
>>>>>>> The code isn't wrong here. However I can change the condition to (new_prs <= 0) if it makes it
>>>>>>> easier to understand.
>>>>>>>
>>>>>> I agree there's nothing wrong with the current logic. However, for clarity, I suggest changing
>>>>>> the
>>>>>> condition to (new_prs <= 0). This allows the function's logic to be fully self-consistent and
>>>>>> focused on a single responsibility. This approach would allow us to simplify the code to:
>>>>>>
>>>>>>       if (new_prs > 0)
>>>>>>           compute_excpus(cp, cp->effective_xcpus);
>>>>>>       else
>>>>>>           reset_partition_data(cp);
>>>>>>
>>>>>> Since reset_partition_data() already handles cases whether cp->exclusive_cpus is empty or not,
>>>>>> this
>>>>>> implementation would be more concise while correctly covering all scenarios.
>>>>> effective_xcpus should be set when exclusive_cpus is not empty or when the cpuset is a valid
>>>>> partition root. So just checking new_prs for compute_excpus() is not enough.
>>>>>
>>>> If we change the condition to (new_prs <= 0), it will reset the partition data even when we call
>>>> compute_excpus (for !cpumask_empty(cp->exclusive_cpus)), so we should still get the same result,
>>>> right?
>>> Changing the condition to (new_prs <= 0) won't affect the result except for a bit of wasted cpu
>>> cycles. That is why I am planning to make the change in the next version to make it easier to
>>> understand.
>>>
>> Sorry, I should have been clearer. If we change the condition, the code would essentially be:
>>
>>     if ((new_prs > 0) || !cpumask_empty(cp->exclusive_cpus))
>>         compute_excpus(cp, cp->effective_xcpus);
>>          if (new_prs <= 0)
>>         reset_partition_data(cp);
>>
>> For cases where new_prs <= 0 && !cpumask_empty(cp->exclusive_cpus), both compute_excpus() and
>> reset_partition_data() would be called.
>>
>> Is this functionally equivalent to:
>>
>>     if (new_prs > 0)
>>         compute_excpus(cp, cp->effective_xcpus);
>>          else (new_prs <= 0)
>>         reset_partition_data(cp);
> 
> They are not equivalent because reset_partition_data() won't do a compute_excpus(). In fact, one of
> the tests in test_cpuset_prs.sh will fail if we make this change.
> 

Understood. If exclusive_cpus is non-empty, the effective_exclusive_cpus of a cpuset may remain
non-empty even when the cpuset itself is not a valid root. reset_partition_data will only reset this
effective list if the exclusive_cpus set is empty.

Thank you very much.

-- 
Best regards,
Ridong


