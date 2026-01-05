Return-Path: <linux-kselftest+bounces-48172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7435ECF21C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 08:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 903453010AAD
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 07:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D16229B18;
	Mon,  5 Jan 2026 07:00:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DB191F94;
	Mon,  5 Jan 2026 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767596452; cv=none; b=Rn4CuWEnIgxBtAfah5Ut31HLatLQ2kWzJFDjCBqNZrBc8hDwlthD6c/fy39Rg+kDdG4E0vA5P7aZByHcPWMnzAGguL4D+MJI1aITR4mnGFlskChSCTSGDBtdqsrW23fmnFYRSMWsD/l4M+ieCh2P9NwaW+88uSRuHmp/TqLotjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767596452; c=relaxed/simple;
	bh=6/o8N7wQPGK8BCmUOHYK6IQL+9v4BV8JPfOheD1LOHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnZbFUZsdENhQ/LjqtdlX54MW1PnQ10bXmKucFbHMjgt7QNCd9QqxfEkvTnYkLxjWMwg/p2ufiS+6Qt0uNh267BAF4I1Uu6hj8lg2N5JaW8PTCiv/kSo58EVtGp8YIglG/bKNTNJXjAQei1CLrQJcKPEi2HI3IUSXFzcWsY6A88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dl4tD1TZDzYQts0;
	Mon,  5 Jan 2026 14:59:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9E08C417F3;
	Mon,  5 Jan 2026 15:00:46 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCnB_idYVtpfUbGCg--.47880S2;
	Mon, 05 Jan 2026 15:00:46 +0800 (CST)
Message-ID: <38ab0503-3176-43a0-b6b5-09de0fd9eb75@huaweicloud.com>
Date: Mon, 5 Jan 2026 15:00:44 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH v2 3/4] cgroup/cpuset: Don't fail
 cpuset.cpus change in v2
To: Waiman Long <llong@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260101191558.434446-1-longman@redhat.com>
 <20260101191558.434446-4-longman@redhat.com>
 <efdcd90c-95ed-4cfc-af9a-3dc0e8f0a488@huaweicloud.com>
 <6eedf67b-3538-4fd1-903b-b7d8db4ff43d@redhat.com>
 <7a3ec392-2e86-4693-aa9f-1e668a668b9c@huaweicloud.com>
 <85f4bca2-e355-49ce-81e9-3b8080082545@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <85f4bca2-e355-49ce-81e9-3b8080082545@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCnB_idYVtpfUbGCg--.47880S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWrAw15Zr1fCr1rGr1kGrg_yoW5Zr1fpF
	yUK3W5trs5KFW7Cwn2q3WxXF1Fq3W2yF1UZFn8Jw1xA390gFnIyF4IyFs8u347Gw4fCa4j
	v3yavryfXF1qv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2026/1/5 11:59, Waiman Long wrote:
> On 1/4/26 8:35 PM, Chen Ridong wrote:
>>
>> On 2026/1/5 5:48, Waiman Long wrote:
>>> On 1/4/26 2:09 AM, Chen Ridong wrote:
>>>> On 2026/1/2 3:15, Waiman Long wrote:
>>>>> Commit fe8cd2736e75 ("cgroup/cpuset: Delay setting of CS_CPU_EXCLUSIVE
>>>>> until valid partition") introduced a new check to disallow the setting
>>>>> of a new cpuset.cpus.exclusive value that is a superset of a sibling's
>>>>> cpuset.cpus value so that there will at least be one CPU left in the
>>>>> sibling in case the cpuset becomes a valid partition root. This new
>>>>> check does have the side effect of failing a cpuset.cpus change that
>>>>> make it a subset of a sibling's cpuset.cpus.exclusive value.
>>>>>
>>>>> With v2, users are supposed to be allowed to set whatever value they
>>>>> want in cpuset.cpus without failure. To maintain this rule, the check
>>>>> is now restricted to only when cpuset.cpus.exclusive is being changed
>>>>> not when cpuset.cpus is changed.
>>>>>
>>>> Hi, Longman,
>>>>
>>>> You've emphasized that modifying cpuset.cpus should never fail. While I haven't found this
>>>> explicitly documented. Should we add it?
>>>>
>>>> More importantly, does this mean the "never fail" rule has higher priority than the exclusive CPU
>>>> constraints? This seems to be the underlying assumption in this patch.
>>> Before the introduction of cpuset partition, writing to cpuset.cpus will only fail if the cpu list
>>> is invalid like containing CPUs outside of the valid cpu range. What I mean by "never-fail" is that
>>> if the cpu list is valid, the write action should not fail. The rule is not explicitly stated in the
>>> documentation, but it is a pre-existing behavior which we should try to keep to avoid breaking
>>> existing applications.
>>>
>> There are two conditions that can cause a cpuset.cpus write operation to fail: ENOSPC (No space left
>> on device) and EBUSY.
>>
>> I just want to ensure the behavior aligns with our design intent.
>>
>> Consider this example:
>>
>> # cd /sys/fs/cgroup/
>> # mkdir test
>> # echo 1 > test/cpuset.cpus
>> # echo $$ > test/cgroup.procs
>> # echo 0 > /sys/devices/system/cpu/cpu1/online
>> # echo > test/cpuset.cpus
>> -bash: echo: write error: No space left on device
>>
>> In cgroups v2, if the test cgroup becomes empty, it could inherit the parent's effective CPUs. My
>> question is: Should we still fail to clear cpuset.cpus (returning an error) when the cgroup is
>> populated?
> 
> Good catch. This error is for v1. It shouldn't apply for v2. Yes, I think we should fix that for v2.
> 

The EBUSY check (through cpuset_cpumask_can_shrink) is necessary, correct?

Since the subsequent patch modifies exclusive checking for v1, should we consolidate all v1-related
code into a separate function like cpuset1_validate_change() (maybe come duplicate code)?, it would
allow us to isolate v1 logic and avoid having to account for v1 implementation details in future
features.

In other words:

validate_change(...)
{
    if (!is_in_v2_mode())
        return cpuset1_validate_change(cur, trial);
    ...
    // only v2 code here
}

-- 
Best regards,
Ridong


