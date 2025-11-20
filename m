Return-Path: <linux-kselftest+bounces-46034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD471C719BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 01:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A0655296DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 00:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47795204F93;
	Thu, 20 Nov 2025 00:51:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3542B136E3F;
	Thu, 20 Nov 2025 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599904; cv=none; b=UrpZNomXs4+XFgyAjduDeF82eL2g5FnRp8pqje+A3iM4gJs9Cs+x/T3CoTd+yLyE1aM/mJFBF3ox9W/ZHhoqQYn+LsltTU56sJtR1tthoLtzaxMoL5pgnYRmZXNSh52IT7do3uT3TX67OwwJ4aXyjSQ4gb3BzE7fE/6epbrs8Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599904; c=relaxed/simple;
	bh=QESTvboA3oRHs+bjAnexYRgLKmE1EDJL5evsq3z39xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvKuFlIFMoc4BZIzDzCw7x+qH1ONiA2/wGMVI5RFsyQIquuiFdeoNd3yrQxmsBi8Dd/U5PISvtn1pgtGKAX7iZoppdPQOxGoRNxv4QFDXX90e8z1swt4FdiL18momJn6pi20gd1zFzjHiKtmKAGT8QKehTQ7ap4g85K+1N3c/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dBfsl2jHtzYQtjG;
	Thu, 20 Nov 2025 08:50:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5D3331A019B;
	Thu, 20 Nov 2025 08:51:32 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgC3XnUTZh5pcC9mBQ--.11563S2;
	Thu, 20 Nov 2025 08:51:32 +0800 (CST)
Message-ID: <5e690981-2921-4b9f-9771-8afaa15018c8@huaweicloud.com>
Date: Thu, 20 Nov 2025 08:51:30 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
To: Sun Shaojie <sunshaojie@kylinos.cn>, llong@redhat.com, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, tj@kernel.org
References: <f32d2f31-630f-450b-911f-b512bbeb380a@huaweicloud.com>
 <20251119105749.1385946-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251119105749.1385946-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3XnUTZh5pcC9mBQ--.11563S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr43WrW7uFy5XF1UJFy8AFb_yoWrCFyxpF
	y8Kr17JwsYqr1rCwnrJ3Z7ur1Sg3ZrXFnrAFn8Gw4rA3sFy3WqyF1qyr93WrW5J39xGw45
	Z3yavrWrZFyqqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/19 18:57, Sun Shaojie wrote:
> Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
> with its sibling partition, the sibling's partition state becomes invalid.
> However, this invalidation is often unnecessary. If the cpuset being
> modified is exclusive, it should invalidate itself upon conflict.
> 
> This patch applies only to the following two cases：
> 
> Assume the machine has 4 CPUs (0-3).
> 
>    root cgroup
>       /    \
>     A1      B1
> 
> Case 1: A1 is exclusive, B1 is non-exclusive, set B1's cpuset.cpus
> 
>  Table 1.1: Before applying this patch
>  Step                                       | A1's prstate | B1's prstate |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>  #3> echo "0" > B1/cpuset.cpus              | root invalid | member       |
> 
> After step #3, A1 changes from "root" to "root invalid" because its CPUs
> (0-1) overlap with those requested by B1 (0). However, B1 can actually
> use CPUs 2-3(from B1's parent), so it would be more reasonable for A1 to
> remain as "root."
> 
>  Table 1.2: After applying this patch
>  Step                                       | A1's prstate | B1's prstate |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>  #3> echo "0" > B1/cpuset.cpus              | root         | member       |
> 
> Case 2: Both A1 and B1 are exclusive, set B1's cpuset.cpus
> 
>  Table 2.1: Before applying this patch
>  Step                                       | A1's prstate | B1's prstate |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>  #3> echo "2" > B1/cpuset.cpus              | root         | member       |
>  #4> echo "root" > B1/cpuset.cpus.partition | root         | root         |
>  #5> echo "1-2" > B1/cpuset.cpus            | root invalid | root invalid |
> 
> After step #4, B1 can exclusively use CPU 2. Therefore, at step #5,
> regardless of what conflicting value B1 writes to cpuset.cpus, it will
> always have at least CPU 2 available. This makes it unnecessary to mark
> A1 as "root invalid".
> 
>  Table 2.2: After applying this patch
>  Step                                       | A1's prstate | B1's prstate |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>  #3> echo "2" > B1/cpuset.cpus              | root         | member       |
>  #4> echo "root" > B1/cpuset.cpus.partition | root         | root         |
>  #5> echo "1-2" > B1/cpuset.cpus            | root         | root invalid |
> 
> In summary, regardless of how B1 configures its cpuset.cpus, there will
> always be available CPUs in B1's cpuset.cpus.effective. Therefore, there
> is no need to change A1 from "root" to "root invalid".
> 
> All other cases remain unaffected. For example, cgroup-v1.
> 
> Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
> ---
>  kernel/cgroup/cpuset.c                        | 19 +------------------
>  .../selftests/cgroup/test_cpuset_prs.sh       |  7 ++++---
>  2 files changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 52468d2c178a..f6a834335ebf 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2411,34 +2411,17 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialc
>  					struct tmpmasks *tmp)
>  {
>  	int retval;
> -	struct cpuset *parent = parent_cs(cs);
>  
>  	retval = validate_change(cs, trialcs);
>  
>  	if ((retval == -EINVAL) && cpuset_v2()) {
> -		struct cgroup_subsys_state *css;
> -		struct cpuset *cp;
> -
>  		/*
>  		 * The -EINVAL error code indicates that partition sibling
>  		 * CPU exclusivity rule has been violated. We still allow
>  		 * the cpumask change to proceed while invalidating the
> -		 * partition. However, any conflicting sibling partitions
> -		 * have to be marked as invalid too.
> +		 * partition.
>  		 */
>  		trialcs->prs_err = PERR_NOTEXCL;
> -		rcu_read_lock();
> -		cpuset_for_each_child(cp, css, parent) {
> -			struct cpumask *xcpus = user_xcpus(trialcs);
> -
> -			if (is_partition_valid(cp) &&
> -			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
> -				rcu_read_unlock();
> -				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, tmp);
> -				rcu_read_lock();
> -			}
> -		}
> -		rcu_read_unlock();
>  		retval = 0;
>  	}
>  	return retval;

If we remove this logic, there is a scenario where the parent (a partition) could end up with empty
effective CPUs. This means the corresponding CS will also have empty effective CPUs and thus fail to
disable its siblings' partitions.

-- 
Best regards,
Ridong


