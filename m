Return-Path: <linux-kselftest+bounces-48705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C34AD1082A
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 04:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FDD0302B538
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 03:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD3830BB8D;
	Mon, 12 Jan 2026 03:56:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DDBE573;
	Mon, 12 Jan 2026 03:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768190187; cv=none; b=XZR8bhMpILr21Et9brwRDZ2jCWORnguNhSpIxRU13anOTXJBJrHz3JS7vZZ7gypRMkR+wDyBu1KsuYd9c9JHI1XGU7TJk31RVC4f+wos0hkfTbFzvOKfwDCfy56pz1k+iUOD/An1neAutsuWkRNKEIdq9scHqmhLCyc86Jdk0nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768190187; c=relaxed/simple;
	bh=yfCAEPl/EOb9bZvd3Ej6AtdSmqijdjyS6MydL5S+CQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3+kmNUG1JXTL8YtovBsz/M9KDWPMtFP3K8MTdi2AYPl0aFQS9fKbOhElzE6Ed5kDexOVEc3VzYTBvXhd9k5pyIUQgm1i7LnnGy2yLbXpAvCRsNfJ1LS6bCqC5eq3nLYUk8rzGWIOxVQeVPwqP5QaKCXHgxSaO/NN8iCSPZ3yVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dqJT7653nzYQthm;
	Mon, 12 Jan 2026 11:56:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8B8084056B;
	Mon, 12 Jan 2026 11:56:21 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA3l_fhcGRpqvD+DQ--.59231S2;
	Mon, 12 Jan 2026 11:56:19 +0800 (CST)
Message-ID: <94d62350-c449-47b3-a423-9fa5ff5b984c@huaweicloud.com>
Date: Mon, 12 Jan 2026 11:56:17 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-6.20 v3 5/5] cgroup/cpuset: Move the v1 empty
 cpus/mems check to cpuset1_validate_change()
To: Waiman Long <llong@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260110013246.293889-1-longman@redhat.com>
 <20260110013246.293889-6-longman@redhat.com>
 <6812a73c-ace6-447a-9f92-4bc8783b3ed5@huaweicloud.com>
 <66132ea0-d096-4ac8-b6c0-eeef2833766b@huaweicloud.com>
 <624437fd-86c9-443d-b20f-edaaad869ea7@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <624437fd-86c9-443d-b20f-edaaad869ea7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3l_fhcGRpqvD+DQ--.59231S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr4DKFyUurWrKrW5WrWkXrb_yoWxKrWkpr
	1kJFWUGrW5Jr1rGw1jgw1UJFyUtw18J3WDJr1kXF18Jr47tF129r1UXrn0gr1UJr48Gr1U
	Jr45Xr47ur1DJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	URq2NUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2026/1/12 11:47, Waiman Long wrote:
> On 1/11/26 9:35 PM, Chen Ridong wrote:
>>
>> On 2026/1/12 10:29, Chen Ridong wrote:
>>>
>>> On 2026/1/10 9:32, Waiman Long wrote:
>>>> As stated in commit 1c09b195d37f ("cpuset: fix a regression in validating
>>>> config change"), it is not allowed to clear masks of a cpuset if
>>>> there're tasks in it. This is specific to v1 since empty "cpuset.cpus"
>>>> or "cpuset.mems" will cause the v2 cpuset to inherit the effective CPUs
>>>> or memory nodes from its parent. So it is OK to have empty cpus or mems
>>>> even if there are tasks in the cpuset.
>>>>
>>>> Move this empty cpus/mems check in validate_change() to
>>>> cpuset1_validate_change() to allow more flexibility in setting
>>>> cpus or mems in v2. cpuset_is_populated() needs to be moved into
>>>> cpuset-internal.h as it is needed by the empty cpus/mems checking code.
>>>>
>>>> Also add a test case to test_cpuset_prs.sh to verify that.
>>>>
>>>> Reported-by: Chen Ridong <chenridong@huaweicloud.com>
>>>> Closes: https://lore.kernel.org/lkml/7a3ec392-2e86-4693-aa9f-1e668a668b9c@huaweicloud.com/
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>>   kernel/cgroup/cpuset-internal.h               |  9 ++++++++
>>>>   kernel/cgroup/cpuset-v1.c                     | 14 +++++++++++
>>>>   kernel/cgroup/cpuset.c                        | 23 -------------------
>>>>   .../selftests/cgroup/test_cpuset_prs.sh       |  3 +++
>>>>   4 files changed, 26 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>>>> index e8e2683cb067..fd7d19842ded 100644
>>>> --- a/kernel/cgroup/cpuset-internal.h
>>>> +++ b/kernel/cgroup/cpuset-internal.h
>>>> @@ -260,6 +260,15 @@ static inline int nr_cpusets(void)
>>>>       return static_key_count(&cpusets_enabled_key.key) + 1;
>>>>   }
>>>>   +static inline bool cpuset_is_populated(struct cpuset *cs)
>>>> +{
>>>> +    lockdep_assert_cpuset_lock_held();
>>>> +
>>>> +    /* Cpusets in the process of attaching should be considered as populated */
>>>> +    return cgroup_is_populated(cs->css.cgroup) ||
>>>> +        cs->attach_in_progress;
>>>> +}
>>>> +
>>>>   /**
>>>>    * cpuset_for_each_child - traverse online children of a cpuset
>>>>    * @child_cs: loop cursor pointing to the current child
>>>> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
>>>> index 04124c38a774..7a23b9e8778f 100644
>>>> --- a/kernel/cgroup/cpuset-v1.c
>>>> +++ b/kernel/cgroup/cpuset-v1.c
>>>> @@ -368,6 +368,20 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
>>>>       if (par && !is_cpuset_subset(trial, par))
>>>>           goto out;
>>>>   +    /*
>>>> +     * Cpusets with tasks - existing or newly being attached - can't
>>>> +     * be changed to have empty cpus_allowed or mems_allowed.
>>>> +     */
>>>> +    ret = -ENOSPC;
>>>> +    if (cpuset_is_populated(cur)) {
>>>> +        if (!cpumask_empty(cur->cpus_allowed) &&
>>>> +            cpumask_empty(trial->cpus_allowed))
>>>> +            goto out;
>>>> +        if (!nodes_empty(cur->mems_allowed) &&
>>>> +            nodes_empty(trial->mems_allowed))
>>>> +            goto out;
>>>> +    }
>>>> +
>>>>       ret = 0;
>>>>   out:
>>>>       return ret;
>>> The current implementation is sufficient.
>>>
>>> However, I suggest we fully separate the validation logic for v1 and v2. While this may introduce
>>> some code duplication (likely minimal), it would allow us to modify the validate_change logic for v2
>>> in the future without needing to consider v1 compatibility. Given that v1 is unlikely to see further
>>> changes, this separation would be a practical long-term decision.
>>>
>>> @@ -368,6 +368,48 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
>>>          if (par && !is_cpuset_subset(trial, par))
>>>                  goto out;
>>>
>>> +       /*
>>> +        * Cpusets with tasks - existing or newly being attached - can't
>>> +        * be changed to have empty cpus_allowed or mems_allowed.
>>> +        */
>>> +       ret = -ENOSPC;
>>> +       if (cpuset_is_populated(cur)) {
>>> +               if (!cpumask_empty(cur->cpus_allowed) &&
>>> +                   cpumask_empty(trial->cpus_allowed))
>>> +                       goto out;
>>> +               if (!nodes_empty(cur->mems_allowed) &&
>>> +                   nodes_empty(trial->mems_allowed))
>>> +                       goto out;
>>> +       }
>>> +
>>> +       /*
>>> +        * We can't shrink if we won't have enough room for SCHED_DEADLINE
>>> +        * tasks. This check is not done when scheduling is disabled as the
>>> +        * users should know what they are doing.
>>> +        *
>>> +        * For v1, effective_cpus == cpus_allowed & user_xcpus() returns
>>> +        * cpus_allowed.
>>> +        *
>>> +        */
>>> +       ret = -EBUSY;
>>> +       if (is_cpu_exclusive(cur) && is_sched_load_balance(cur) &&
>>> +           !cpuset_cpumask_can_shrink(cur->effective_cpus, user_xcpus(trial)))
>>> +               goto out;
>>> +
>>> +       /*
>>> +        * If either I or some sibling (!= me) is exclusive, we can't
>>> +        * overlap. exclusive_cpus cannot overlap with each other if set.
>>> +        */
>>> +       ret = -EINVAL;
>>> +       cpuset_for_each_child(c, css, par) {
>>> +               if (c == cur)
>>> +                       continue;
>>> +               if (cpuset1_cpus_excl_conflict(trial, c))
>>> +                       goto out;
>>> +               if (mems_excl_conflict(trial, c))
>>> +                       goto out;
>>> +       }
>>> +
>>>          ret = 0;
>>>   out:
>>>          return ret;
>>>
>> A major redundancy is in the cpuset_cpumask_can_shrink check. By placing cpuset1_cpus_excl_conflict
>> within the v1 path, we could simplify the overall cpus_excl_conflict function as well.
> 
> This is additional cleanup work. It can be done as a follow-on patch later on.
> 

Okay, it looks good for me.

Since you are going to update patch 4, maybe you can just add a patch to clean up.

Reviewed-by: Chen Ridong <chenridong@huawei.com>

-- 
Best regards,
Ridong


