Return-Path: <linux-kselftest+bounces-48153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A377FCF1919
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 02:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56FD9300B917
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 01:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F092D73B9;
	Mon,  5 Jan 2026 01:35:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A82C237E;
	Mon,  5 Jan 2026 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767576918; cv=none; b=rKHPVNs8SGOtsUkE83CO6l0JJ77q1F0RM6mpnxWEHn4xMqRQ9KrBMgW62ug/PVf5GEU+PnJZhgOeg0K1b9LUvpWY6F9t9db1la0wbgkiKL4X72FfZBTR2c2qwc0se1AM+nB39n3sosTHwlos4dJOaps88y6pplkHTpcHO5RYWtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767576918; c=relaxed/simple;
	bh=RLCWgAT7OoqppGQPFm3yCg9ZTTzgCn3HJ1W/8IuTx2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qD+gTc7J9/yCyGX+nSArbHkxNe5kQJLR6hWDsqYYC3kODjZfwUP2PeflViqKrNgiVE/gjTYfrHs/KSHySiUJRrCwPHcOTGk8yxtijFLID6a6uwSt9o6E89vNHH7D7oSEMRFLteHi4MEVuTm8yTkrjvtiW+M+b7gUJm22ZticBb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dkxfx4zvBzKHMYH;
	Mon,  5 Jan 2026 09:34:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3254B40574;
	Mon,  5 Jan 2026 09:35:11 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgAn1vZNFVtp7T+rCg--.60656S2;
	Mon, 05 Jan 2026 09:35:11 +0800 (CST)
Message-ID: <7a3ec392-2e86-4693-aa9f-1e668a668b9c@huaweicloud.com>
Date: Mon, 5 Jan 2026 09:35:09 +0800
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
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <6eedf67b-3538-4fd1-903b-b7d8db4ff43d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAn1vZNFVtp7T+rCg--.60656S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4fCFW3ZrWUJr43tF15XFb_yoW5GrWxpF
	WUKFy3tan0gFy2kws2q3Z7Xr1Fqa1Iy3WDArs8Jrn7C390gFnYyF4vyFn8u347Gw4rua1Y
	yrW3ZrW5XF1DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2026/1/5 5:48, Waiman Long wrote:
> On 1/4/26 2:09 AM, Chen Ridong wrote:
>>
>> On 2026/1/2 3:15, Waiman Long wrote:
>>> Commit fe8cd2736e75 ("cgroup/cpuset: Delay setting of CS_CPU_EXCLUSIVE
>>> until valid partition") introduced a new check to disallow the setting
>>> of a new cpuset.cpus.exclusive value that is a superset of a sibling's
>>> cpuset.cpus value so that there will at least be one CPU left in the
>>> sibling in case the cpuset becomes a valid partition root. This new
>>> check does have the side effect of failing a cpuset.cpus change that
>>> make it a subset of a sibling's cpuset.cpus.exclusive value.
>>>
>>> With v2, users are supposed to be allowed to set whatever value they
>>> want in cpuset.cpus without failure. To maintain this rule, the check
>>> is now restricted to only when cpuset.cpus.exclusive is being changed
>>> not when cpuset.cpus is changed.
>>>
>> Hi, Longman,
>>
>> You've emphasized that modifying cpuset.cpus should never fail. While I haven't found this
>> explicitly documented. Should we add it?
>>
>> More importantly, does this mean the "never fail" rule has higher priority than the exclusive CPU
>> constraints? This seems to be the underlying assumption in this patch.
> 
> Before the introduction of cpuset partition, writing to cpuset.cpus will only fail if the cpu list
> is invalid like containing CPUs outside of the valid cpu range. What I mean by "never-fail" is that
> if the cpu list is valid, the write action should not fail. The rule is not explicitly stated in the
> documentation, but it is a pre-existing behavior which we should try to keep to avoid breaking
> existing applications.
> 

There are two conditions that can cause a cpuset.cpus write operation to fail: ENOSPC (No space left
on device) and EBUSY.

I just want to ensure the behavior aligns with our design intent.

Consider this example:

# cd /sys/fs/cgroup/
# mkdir test
# echo 1 > test/cpuset.cpus
# echo $$ > test/cgroup.procs
# echo 0 > /sys/devices/system/cpu/cpu1/online
# echo > test/cpuset.cpus
-bash: echo: write error: No space left on device

In cgroups v2, if the test cgroup becomes empty, it could inherit the parent's effective CPUs. My
question is: Should we still fail to clear cpuset.cpus (returning an error) when the cgroup is
populated?

> The exclusive CPU constraint does not apply to cpuset.cpus. It only applies when setting
> cpuset.cpus.exclusive wrt to other cpuset.cpus.exclusive* in sibling cpusets. So I will not say one
> has higher priority than the other.
> 
> Cheers,
> Longman
> 

-- 
Best regards,
Ridong


