Return-Path: <linux-kselftest+bounces-47976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC4ACDF78E
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Dec 2025 11:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA02A3003073
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Dec 2025 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA930257825;
	Sat, 27 Dec 2025 10:10:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63EB3A1E94;
	Sat, 27 Dec 2025 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766830254; cv=none; b=GSq6y7XXGRg1GW6iUo8WkZd36UUHXTvT5QkD4wXfk7SCfiI2tPs1rYP6OvEvu5DKX8xQOV7U5X7UK0bYkBZ6whsmorBPgBEN9dN06fP/9e0AosEdKxfeFmZd1CxUd7frF8AeVtngnMbg1eWeGdWgEbkdMQeXGTA8Bn0Dt14oCRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766830254; c=relaxed/simple;
	bh=IHB8j7Q3dZ3i4amSKfAho20GDzps/5KT66ij0BtHdKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUZv6vMZ3lHu0zglU6Xfzz4T433imEVx1uRBgbcZRWFWvfv5l4xV2FBFWZ++olrSHdflu2fwO7aDaI315xqo7b839p8H4ViyUvYU5tKVa6BJF9EARxt2VR4GigtN2/WlZEl/7VJxD3ChOR1o5a0aTqY8UCcOtCvdugLz1eJ/fBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dddX96SxCzKHMKG;
	Sat, 27 Dec 2025 18:10:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 240504056D;
	Sat, 27 Dec 2025 18:10:42 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgD3V_igsE9pyc+hBg--.49281S2;
	Sat, 27 Dec 2025 18:10:41 +0800 (CST)
Message-ID: <9a2e6d5b-9b42-4f32-a8d2-552c2585cf0f@huaweicloud.com>
Date: Sat, 27 Dec 2025 18:10:40 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH 2/4] cgroup/cpuset: Consistently compute
 effective_xcpus in update_cpumasks_hier()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Sun Shaojie <sunshaojie@kylinos.cn>
References: <20251225073056.30789-1-longman@redhat.com>
 <20251225073056.30789-3-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251225073056.30789-3-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgD3V_igsE9pyc+hBg--.49281S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW8Jry5uFy5JF1kZw17Awb_yoW5WF4fpF
	yrCw4aqFWYqr15C39rK3ZF9r1FganYqF1qy3srtr4rJFy3G3W09r1q9a9Iyr1UJayDWF43
	Zas0qr4Iv3Z0ywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/25 15:30, Waiman Long wrote:
> Since commit f62a5d39368e ("cgroup/cpuset: Remove remote_partition_check()
> & make update_cpumasks_hier() handle remote partition"), the
> compute_effective_exclusive_cpumask() helper was extended to
> strip exclusive CPUs from siblings when computing effective_xcpus
> (cpuset.cpus.exclusive.effective). This helper was later renamed to
> compute_excpus() in commit 86bbbd1f33ab ("cpuset: Refactor exclusive
> CPU mask computation logic").
> 
> This helper is supposed to be used consistently to compute
> effective_xcpus. However, there is an exception within the callback
> critical section in update_cpumasks_hier() when exclusive_cpus of a
> valid partition root is empty. This can cause effective_xcpus value to
> differ depending on where exactly it is last computed. Fix this by using
> compute_excpus() in this case to give a consistent result.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 3d2d28f0fd03..850334dbc36a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2050,6 +2050,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>  		struct cpuset *parent = parent_cs(cp);
>  		bool remote = is_remote_partition(cp);
>  		bool update_parent = false;
> +		bool empty_xcpus;
>  
>  		old_prs = new_prs = cp->partition_root_state;
>  
> @@ -2160,20 +2161,14 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>  			new_prs = cp->partition_root_state;
>  		}
>  
> +		empty_xcpus = cpumask_empty(cp->exclusive_cpus);
>  		spin_lock_irq(&callback_lock);
>  		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
>  		cp->partition_root_state = new_prs;
> -		if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
> +		if (((new_prs > 0) && empty_xcpus) ||
> +		    ((cp != cs) && !empty_xcpus))
>  			compute_excpus(cp, cp->effective_xcpus);

The current logic for determining when to recompute effective_xcpus is difficult to follow.
Can we simplify it as follows?

	if(new_prs > 0)
		compute_excpus(cp, cp->effective_xcpus);
	else
		reset_partition_data(cp);

This would make the intent clearer: if cp is a valid partition, we recompute its effective_xcpus;
otherwise, we reset the partition data.

> -
> -		/*
> -		 * Make sure effective_xcpus is properly set for a valid
> -		 * partition root.
> -		 */
> -		if ((new_prs > 0) && cpumask_empty(cp->exclusive_cpus))
> -			cpumask_and(cp->effective_xcpus,
> -				    cp->cpus_allowed, parent->effective_xcpus);
> -		else if (new_prs < 0)
> +		if (new_prs < 0)
>  			reset_partition_data(cp);
>  		spin_unlock_irq(&callback_lock);
>  

-- 
Best regards,
Ridong


