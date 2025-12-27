Return-Path: <linux-kselftest+bounces-47977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE6CCDF797
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Dec 2025 11:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 644903005E8A
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Dec 2025 10:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D76E26B2DA;
	Sat, 27 Dec 2025 10:14:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4E25A2CF;
	Sat, 27 Dec 2025 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766830497; cv=none; b=lJVTPD3r6SyWzqcvI0uQOdPv/NZvi1SUKoW6vDB8DlwtmLiP3BWLoWjpUDOQqvxTZugZeSTCCdsnzLKpAI7Pd4KpfHXvoSfiryh5wM8B5lZ1bfZqleY3UM7eEGXpsEccdj99TTE4skJ3kzGqfv2j24tCN0UUiQPLSU9r9KgM5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766830497; c=relaxed/simple;
	bh=dl/roo0i2xyt/iOyKTKybnbd+5Mmd/DxmCh+Fdod6wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJrVsVNxmldA6GVy9s8rO9JUei4DYos4kaYvSIIjCGSsVtTw+Ozboh1VVnYi62sBDRnfR1kxCmhVzrFkYmU/RT44Kl93jmXCmHl5t09slk50OQ1lfEqwPT64902nZX0EWv3Ggv4KDKUlKhoxnX4nkj9ANOML2RgiNuccRLMTJjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dddcc140xzYQtjk;
	Sat, 27 Dec 2025 18:14:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A64114056F;
	Sat, 27 Dec 2025 18:14:51 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCnB_ibsU9pNSmiBg--.63721S2;
	Sat, 27 Dec 2025 18:14:51 +0800 (CST)
Message-ID: <11f4e2ca-955e-45a6-adc5-d1d8c85e4579@huaweicloud.com>
Date: Sat, 27 Dec 2025 18:14:50 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH 1/4] cgroup/cpuset: Streamline
 rm_siblings_excl_cpus()
To: Waiman Long <llong@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Sun Shaojie <sunshaojie@kylinos.cn>
References: <20251225073056.30789-1-longman@redhat.com>
 <20251225073056.30789-2-longman@redhat.com>
 <c75025d3-17cd-47bb-a222-bde3a156bbbb@huaweicloud.com>
 <2988a9d5-fe25-4668-93e3-8335360fcbec@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <2988a9d5-fe25-4668-93e3-8335360fcbec@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnB_ibsU9pNSmiBg--.63721S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyrGr4fZF1rtFW7Cw1DGFg_yoW5Cr4fpF
	1kJFWUJFWUKFy8G34Yqr1qgryrKw4UX3WDJw4DJF1rJFy7GF1jgr1DXwn0gr1UGw4kGr15
	JryaqrZIvFy5Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbmii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/27 15:40, Waiman Long wrote:
> On 12/25/25 4:27 AM, Chen Ridong wrote:
>>
>> On 2025/12/25 15:30, Waiman Long wrote:
>>> If exclusive_cpus is set, effective_xcpus must be a subset of
>>> exclusive_cpus. Currently, rm_siblings_excl_cpus() checks both
>>> exclusive_cpus and effective_xcpus connectively. It is simpler
>>> to check only exclusive_cpus if non-empty or just effective_xcpus
>>> otherwise.
>>>
>>> No functional change is expected.
>>>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>   kernel/cgroup/cpuset.c | 17 +++++++++--------
>>>   1 file changed, 9 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 221da921b4f9..3d2d28f0fd03 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -1355,23 +1355,24 @@ static int rm_siblings_excl_cpus(struct cpuset *parent, struct cpuset *cs,
>>>       int retval = 0;
>>>         if (cpumask_empty(excpus))
>>> -        return retval;
>>> +        return 0;
>>>         /*
>>>        * Exclude exclusive CPUs from siblings
>>>        */
>>>       rcu_read_lock();
>>>       cpuset_for_each_child(sibling, css, parent) {
>>> +        struct cpumask *sibling_xcpus;
>>> +
>>>           if (sibling == cs)
>>>               continue;
>>>   -        if (cpumask_intersects(excpus, sibling->exclusive_cpus)) {
>>> -            cpumask_andnot(excpus, excpus, sibling->exclusive_cpus);
>>> -            retval++;
>>> -            continue;
>>> -        }
>>> -        if (cpumask_intersects(excpus, sibling->effective_xcpus)) {
>>> -            cpumask_andnot(excpus, excpus, sibling->effective_xcpus);
>>> +        sibling_xcpus = cpumask_empty(sibling->exclusive_cpus)
>>> +                  ? sibling->effective_xcpus
>>> +                  : sibling->exclusive_cpus;
>>> +
>> I'm wondering if this is sufficient?
>>
>> sibling_xcpus = sibling->effective_xcpus
>>
>>        p(exclusive_cpus = 1)
>>     /      \
>>   a    b(root, exclusive_cpus=1-7, effective_xcpus=1)
>>
>> What the sibling's effective exclusive CPUs actually should be is not CPUs 1-7 but CPU 1. So, do we
>> need to remove CPUs 2-7?
> 
> By definition, exclusive_cpus have to be exclusive within the same child cpuset level even if some
> of the CPUs cannot be granted from the parent. So other siblings cannot use any of the CPUs 1-7 in
> its exclusive_cpus list or the writing will fail. In the case of cpuset.cpus defined partitions,
> those CPUs will be removed from its effective_xcpus list.
> 
> Cheers,
> Longman
> 

Thank you for the clarification.

Looks good to me.

Reviewed-by: Chen Ridong <chenridong@huawei.com>

-- 
Best regards,
Ridong


