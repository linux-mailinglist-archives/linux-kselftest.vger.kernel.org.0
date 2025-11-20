Return-Path: <linux-kselftest+bounces-46107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2977DC74694
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 15:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 058584F7561
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 13:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D17F346799;
	Thu, 20 Nov 2025 13:45:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05B342C99;
	Thu, 20 Nov 2025 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646323; cv=none; b=cVNSqejl8B61tMCZIQslWH0HKHZoO+PkOWo+o7QZGApP4IaO8Yq9CwvRAFSvfTBB9wmGYwiyHF6zjVNBf+pL8VivuqcUz2qcGBM84gV3EUGGesLiLrMOCu0+0oHTJXLPMhQXXpGQ8P0Yk9Xq5vlI3WhEUweXqlRONque/kSQdWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646323; c=relaxed/simple;
	bh=+jiC7CZHOFjw2Ag8OX/h9tCN/ZPLE0V2bCBBgmCAam0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCHGHCU4DGCpfnwDm3ycIdQWdb8mklmYMWSQZSEBPQXc/OH1jk4rNM9RuD+QlMviy4GlCd34HCwYRAjqZevTzDPYtMJVCwpEBI2lrwJA+zXwt1vID9dUMCxXUGDVDZ7lWYgAyOvi0ri6L29pDCG0AYl6ZvA2LjZn/1CuVutAgtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dC02X0wTBzYQtkt;
	Thu, 20 Nov 2025 21:44:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 09D861A1A0B;
	Thu, 20 Nov 2025 21:45:18 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgDHbnVsGx9pmvekBQ--.9802S2;
	Thu, 20 Nov 2025 21:45:17 +0800 (CST)
Message-ID: <8d38b4ea-6b55-4319-b330-2dc33ac5cd77@huaweicloud.com>
Date: Thu, 20 Nov 2025 21:45:16 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llong@redhat.com, mkoutny@suse.com, shuah@kernel.org, tj@kernel.org
References: <5e690981-2921-4b9f-9771-8afaa15018c8@huaweicloud.com>
 <20251120130704.1554368-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251120130704.1554368-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDHbnVsGx9pmvekBQ--.9802S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4ruFWUXFyxWryDZry7ZFb_yoWrCr15pF
	yxKa17Xw4kXr15C3srX3Wvgryav3ZrZF47Arn8Jw1fAF9IyFnFv3WqkrZIvr15Ar9xGr4U
	ZayjkrZxZF9rAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/20 21:07, Sun Shaojie wrote:
> Hi, Ridong,
> 
> On Thu, 20 Nov 2025 08:51:30, Chen Ridong wrote:
>> On 2025/11/19 18:57, Sun Shaojie wrote:
>>>  kernel/cgroup/cpuset.c                        | 19 +------------------
>>>  .../selftests/cgroup/test_cpuset_prs.sh       |  7 ++++---
>>>  2 files changed, 5 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 52468d2c178a..f6a834335ebf 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -2411,34 +2411,17 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialc
>>>  					struct tmpmasks *tmp)
>>>  {
>>>  	int retval;
>>> -	struct cpuset *parent = parent_cs(cs);
>>>  
>>>  	retval = validate_change(cs, trialcs);
>>>  
>>>  	if ((retval == -EINVAL) && cpuset_v2()) {
>>> -		struct cgroup_subsys_state *css;
>>> -		struct cpuset *cp;
>>> -
>>>  		/*
>>>  		 * The -EINVAL error code indicates that partition sibling
>>>  		 * CPU exclusivity rule has been violated. We still allow
>>>  		 * the cpumask change to proceed while invalidating the
>>> -		 * partition. However, any conflicting sibling partitions
>>> -		 * have to be marked as invalid too.
>>> +		 * partition.
>>>  		 */
>>>  		trialcs->prs_err = PERR_NOTEXCL;
>>> -		rcu_read_lock();
>>> -		cpuset_for_each_child(cp, css, parent) {
>>> -			struct cpumask *xcpus = user_xcpus(trialcs);
>>> -
>>> -			if (is_partition_valid(cp) &&
>>> -			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
>>> -				rcu_read_unlock();
>>> -				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, tmp);
>>> -				rcu_read_lock();
>>> -			}
>>> -		}
>>> -		rcu_read_unlock();
>>>  		retval = 0;
>>>  	}
>>>  	return retval;
>>
>> If we remove this logic, there is a scenario where the parent (a partition) could end up with empty
>> effective CPUs. This means the corresponding CS will also have empty effective CPUs and thus fail to
>> disable its siblings' partitions.
> 
> I have carefully considered the scenario where parent effective CPUs are 
> empty, which corresponds to the following two cases. (After apply this patch).
> 
>    root cgroup
>         |
>        A1
>       /  \
>     A2    A3
> 
> Case 1:
>  Step:
>  #1> echo "0-1" > A1/cpuset.cpus
>  #2> echo "root" > A1/cpuset.cpus.partition
>  #3> echo "0-1" > A2/cpuset.cpus
>  #4> echo "root" > A2/cpuset.cpus.partition
> 
>  After step #4, 
> 
>                 |      A1      |      A2      |      A3      |
>  cpus_allowed   | 0-1          | 0-1          |              |
>  effective_cpus |              | 0-1          |              |
>  prstate        | root         | root         | member       |
> 
>  After step #4, A3's effective CPUs is empty.
> 

That may be a corner case is unexpected.

>  #5> echo "0-1" > A3/cpuset.cpus
> 

If we create subdirectories (e.g., A4, A5, ...) under the A1 cpuset and then configure cpuset.cpus
for A1 (a common usage scenario), processes can no longer be migrated into these subdirectories (A4,
A5, ...) afterward. However, prior to your patch, this migration was allowed.

>  After step #5,
> 
>                 |      A1      |      A2      |      A3      |
>  cpus_allowed   | 0-1          | 0-1          | 0-1          |
>  effective_cpus |              | 0-1          |              |
>  prstate        | root         | root         | member       |
> 
> This patch affects step #5. After step #5, A3's effective CPUs is also empty.
> Since A3's effective CPUs can be empty before step #5 (setting cpuset.cpus),
> it is acceptable for them to remain empty after step #5. Moreover, if A3 is
> aware that its parent's effective CPUs are empty, it should understand that
> the CPUs it requests may not be granted.
> 
> Case 2:
>  Step:
>  #1> echo "0-1" > A1/cpuset.cpus
>  #2> echo "root" > A1/cpuset.cpus.partition
>  #3> echo "0" > A2/cpuset.cpus
>  #4> echo "root" > A2/cpuset.cpus.partition
>  #5> echo "1" > A3/cpuset.cpus
>  #6> echo "root" > A3/cpuset.cpus.partition
> 
>  After step #6,
> 
>                 |      A1      |      A2      |      A3      |
>  cpus_allowed   | 0-1          | 0            | 1            |
>  effective_cpus |              | 0            | 1            |
>  prstate        | root         | root         | root         |
> 
>  #7> echo "0-1" > A3/cpuset.cpus
> 
>  After step #7,
> 
>                 |      A1      |      A2      |      A3      |
>  cpus_allowed   | 0-1          | 0            | 0-1          |
>  effective_cpus | 1            | 0            | 1            |
>  prstate        | root         | root         | root invalid |
> 
> This patch affects step #7. After step #7, A3 only affects itself, changing
> from "root" to "root invalid". However, since its effective CPUs remain 1 
> both before and after step #7, it doesn't matter even if A2 is not invalidated.
> 
> The purpose of this patch is to ensure that modifying cpuset.cpus does not 
> disable its siblings' partitions.
> 
> 
> Thanks,
> Sun Shaojie

-- 
Best regards,
Ridong


