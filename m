Return-Path: <linux-kselftest+bounces-48166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E01ACF1C5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 04:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03F8530056FD
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 03:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5470931987B;
	Mon,  5 Jan 2026 03:58:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D5523C516;
	Mon,  5 Jan 2026 03:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767585493; cv=none; b=HJpZXihaCXHqkK3YFJkyA6n2pyTUjv94Tf1/N0/lHosKtrvHdradnaYLk646yDx9qtB6ujybn1BwQwyZtUHilqqSPyV45OJF7gc6Lk9XlO2ihi6P5P8JHRSWRAatdIrryb0qBymARbyrnwifFdSy9aAPs6gANLzcWHqqsnFuBiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767585493; c=relaxed/simple;
	bh=1PYig3RrB+XOrvNpWkg/JjGLUEWTg0PqGSde/bmeRzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXUpCiWKigOBAm/ohAfv6hTljPAPt76kuiEmHoqUAdwfHcMcfVe4pzSolaRCOWJfdmpoediL7csNLdyQjnETuA3s+r3bNWfieV1XQAj6UWCPwcyRH3a2krenK93RnAoemxElvdLNIeHaQPtgr46nPYEqA3tu8HBueHdP0AyjOfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dl0qP2LD4zYQtv9;
	Mon,  5 Jan 2026 11:57:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8797D40573;
	Mon,  5 Jan 2026 11:58:03 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgB32PjKNltpHCG3Cg--.53641S2;
	Mon, 05 Jan 2026 11:58:03 +0800 (CST)
Message-ID: <d49cc8af-509b-44b8-ada4-f8bbdbd37f89@huaweicloud.com>
Date: Mon, 5 Jan 2026 11:58:01 +0800
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
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <ec6e1ee4-b52e-417f-9413-3dfca0ec8eb3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB32PjKNltpHCG3Cg--.53641S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AFy5Kw48KF18ArW3Gw4DArb_yoW7XF4Dpr
	y8JF4UXrW5Wr1rC3yjgF17XryrKw4Dt3WDXw1DtF4rXF9rKF1qgr1jvwn09r1UJr4kJr15
	Ar15Xr4SvF90ywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2026/1/5 11:50, Waiman Long wrote:
> On 1/4/26 8:15 PM, Chen Ridong wrote:
>>
>> On 2026/1/5 5:25, Waiman Long wrote:
>>> On 1/3/26 9:48 PM, Chen Ridong wrote:
>>>> On 2026/1/2 3:15, Waiman Long wrote:
>>>>> Since commit f62a5d39368e ("cgroup/cpuset: Remove remote_partition_check()
>>>>> & make update_cpumasks_hier() handle remote partition"), the
>>>>> compute_effective_exclusive_cpumask() helper was extended to
>>>>> strip exclusive CPUs from siblings when computing effective_xcpus
>>>>> (cpuset.cpus.exclusive.effective). This helper was later renamed to
>>>>> compute_excpus() in commit 86bbbd1f33ab ("cpuset: Refactor exclusive
>>>>> CPU mask computation logic").
>>>>>
>>>>> This helper is supposed to be used consistently to compute
>>>>> effective_xcpus. However, there is an exception within the callback
>>>>> critical section in update_cpumasks_hier() when exclusive_cpus of a
>>>>> valid partition root is empty. This can cause effective_xcpus value to
>>>>> differ depending on where exactly it is last computed. Fix this by using
>>>>> compute_excpus() in this case to give a consistent result.
>>>>>
>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>>> ---
>>>>>    kernel/cgroup/cpuset.c | 14 +++++---------
>>>>>    1 file changed, 5 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>>> index da2b3b51630e..37d118a9ad4d 100644
>>>>> --- a/kernel/cgroup/cpuset.c
>>>>> +++ b/kernel/cgroup/cpuset.c
>>>>> @@ -2168,17 +2168,13 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>>>>>            spin_lock_irq(&callback_lock);
>>>>>            cpumask_copy(cp->effective_cpus, tmp->new_cpus);
>>>>>            cp->partition_root_state = new_prs;
>>>>> -        if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
>>>>> -            compute_excpus(cp, cp->effective_xcpus);
>>>>> -
>>>>>            /*
>>>>> -         * Make sure effective_xcpus is properly set for a valid
>>>>> -         * partition root.
>>>>> +         * Need to compute effective_xcpus if either exclusive_cpus
>>>>> +         * is non-empty or it is a valid partition root.
>>>>>             */
>>>>> -        if ((new_prs > 0) && cpumask_empty(cp->exclusive_cpus))
>>>>> -            cpumask_and(cp->effective_xcpus,
>>>>> -                    cp->cpus_allowed, parent->effective_xcpus);
>>>>> -        else if (new_prs < 0)
>>>>> +        if ((new_prs > 0) || !cpumask_empty(cp->exclusive_cpus))
>>>>> +            compute_excpus(cp, cp->effective_xcpus);
>>>>> +        if (new_prs < 0)
>>>>>                reset_partition_data(cp);
>>>>>            spin_unlock_irq(&callback_lock);
>>>>>    
>>>> The code resets partition data only for new_prs < 0. My understanding is that a partition is
>>>> invalid
>>>> when new_prs <= 0. Shouldn't reset_partition_data() also be called when new_prs = 0? Is there a
>>>> specific reason to skip the reset in that case?
>>> update_cpumasks_hier() is called when changes in a cpuset or hotplug affects other cpusets in the
>>> hierarchy. With respect to changes in partition state, it is either from valid to invalid or vice
>>> versa. It will not change from a valid partition to member. The only way new_prs = 0 is when old_prs
>>> = 0. Even if the affected cpuset is processed again in update_cpumask_hier(), any state change from
>>> valid partition to member (update_prstate()), reset_partition_data() should have been called there.
>>> That is why we only care about when new_prs != 0.
>>>
>> Thank you for your patience.
>>
>>> The code isn't wrong here. However I can change the condition to (new_prs <= 0) if it makes it
>>> easier to understand.
>>>
>> I agree there's nothing wrong with the current logic. However, for clarity, I suggest changing the
>> condition to (new_prs <= 0). This allows the function's logic to be fully self-consistent and
>> focused on a single responsibility. This approach would allow us to simplify the code to:
>>
>>     if (new_prs > 0)
>>         compute_excpus(cp, cp->effective_xcpus);
>>     else
>>         reset_partition_data(cp);
>>
>> Since reset_partition_data() already handles cases whether cp->exclusive_cpus is empty or not, this
>> implementation would be more concise while correctly covering all scenarios.
> 
> effective_xcpus should be set when exclusive_cpus is not empty or when the cpuset is a valid
> partition root. So just checking new_prs for compute_excpus() is not enough.
> 

If we change the condition to (new_prs <= 0), it will reset the partition data even when we call
compute_excpus (for !cpumask_empty(cp->exclusive_cpus)), so we should still get the same result, right?

-- 
Best regards,
Ridong


