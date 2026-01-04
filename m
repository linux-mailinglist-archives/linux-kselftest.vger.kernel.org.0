Return-Path: <linux-kselftest+bounces-48120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E53CF07F5
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 02:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FDD33004CE7
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 01:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7547722D7B1;
	Sun,  4 Jan 2026 01:55:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AEE230BD9;
	Sun,  4 Jan 2026 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767491747; cv=none; b=V38v40HSGkvQHvaHIXD6dh4CLqth5QtsU5qo0AQO07fVh6I7buujzW96GEAgDhSmdYU86Lfn6rttUpXiOUxPe+VY6E+7XRWUQzjUxyS0BqzVNWl0W5A/I11Pbb/d8QBWkqFeYzi8K8yUp82CL2DJaIn3EXol2EMjNrFynM2rivY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767491747; c=relaxed/simple;
	bh=bDl0b4Wp9lUpU2hSZyo8fwLg/DPZP6ASvdmQ8m4uTv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqoDA6QkGKtMwP0UGz3ICPwB1jn6TmPi+MV+WoGdpr1gALNcVeeHr2koma+WrB6JjofXDhxf+nmcbpQGfOqojZ8mKk/VM26ETcBJeSeScJHkFeZG6ExkR4Rl4z6rTF4GCqoVqDyaazbjz+tS/NWgjEwEoyEBwV0dVLBUQiHghm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dkL8Z0x7ZzYQv0b;
	Sun,  4 Jan 2026 09:54:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 82D6D40574;
	Sun,  4 Jan 2026 09:55:34 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgB32PiVyFlptLQ1Cg--.8391S2;
	Sun, 04 Jan 2026 09:55:34 +0800 (CST)
Message-ID: <6e063b79-dfcf-4b5e-a39f-7647ad8f0405@huaweicloud.com>
Date: Sun, 4 Jan 2026 09:55:32 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH v2 1/4] cgroup/cpuset: Streamline
 rm_siblings_excl_cpus()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260101191558.434446-1-longman@redhat.com>
 <20260101191558.434446-2-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260101191558.434446-2-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB32PiVyFlptLQ1Cg--.8391S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW5WF1xWw4kJr1xtw1xAFb_yoW8Zry5pF
	1rGay7tFWUtFyUC343t3ZFgr9Ygw4kKrnIya1DJw1rXFy3G3Wjvr1kG3Z3XF1UG3yDG3W5
	JF9xtrWaga43Gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2026/1/2 3:15, Waiman Long wrote:
> If exclusive_cpus is set, effective_xcpus must be a subset of
> exclusive_cpus. Currently, rm_siblings_excl_cpus() checks both
> exclusive_cpus and effective_xcpus consecutively. It is simpler
> to check only exclusive_cpus if non-empty or just effective_xcpus
> otherwise.
> 
> No functional change is expected.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 221da921b4f9..da2b3b51630e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1355,23 +1355,29 @@ static int rm_siblings_excl_cpus(struct cpuset *parent, struct cpuset *cs,
>  	int retval = 0;
>  
>  	if (cpumask_empty(excpus))
> -		return retval;
> +		return 0;
>  
>  	/*
> -	 * Exclude exclusive CPUs from siblings
> +	 * Remove exclusive CPUs from siblings
>  	 */
>  	rcu_read_lock();
>  	cpuset_for_each_child(sibling, css, parent) {
> +		struct cpumask *sibling_xcpus;
> +
>  		if (sibling == cs)
>  			continue;
>  
> -		if (cpumask_intersects(excpus, sibling->exclusive_cpus)) {
> -			cpumask_andnot(excpus, excpus, sibling->exclusive_cpus);
> -			retval++;
> -			continue;
> -		}
> -		if (cpumask_intersects(excpus, sibling->effective_xcpus)) {
> -			cpumask_andnot(excpus, excpus, sibling->effective_xcpus);
> +		/*
> +		 * If exclusive_cpus is defined, effective_xcpus will always
> +		 * be a subset. Otherwise, effective_xcpus will only be set
> +		 * in a valid partition root.
> +		 */
> +		sibling_xcpus = cpumask_empty(sibling->exclusive_cpus)
> +			      ? sibling->effective_xcpus
> +			      : sibling->exclusive_cpus;
> +
> +		if (cpumask_intersects(excpus, sibling_xcpus)) {
> +			cpumask_andnot(excpus, excpus, sibling_xcpus);
>  			retval++;
>  		}
>  	}

LGTM

Reviewed-by: Chen Ridong<chenridong@huawei.com>

-- 
Best regards,
Ridong


