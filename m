Return-Path: <linux-kselftest+bounces-48121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79841CF08F7
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 03:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D7AB300EA12
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 02:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EA12BE05B;
	Sun,  4 Jan 2026 02:48:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A629992A;
	Sun,  4 Jan 2026 02:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767494905; cv=none; b=CJlUezPd0YUetzfsig94arDB6aBRWqgPcJteIDexssZiMDH185FIci7wrbPtIv3RKAyb9yv8PVYAMy0joOyJoy7fEgkt/FICeJbshT5cMKd2FihDO3G4c4rDJCIacfRLzCIlIy9Luk9gJh0Lm4bznirZbHWyMR7t6VZXjLIyCvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767494905; c=relaxed/simple;
	bh=xLeIV1JsLSXR0Et0G5gFuUcVoEi9AZmb27l+J+Y+k8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWnR8kb2o9/dehUxizAMisqMKnNZ+Pc5y1ishb1Rt5oWWuYVVQAYzEAzUPtcXRX/H8KjDWaMpoiMfvITtyxlD/Z5R669qy4kjCQhtaDiO7zY7gELzbst5SIIO/eOWV3j5ZoEBDZalsd3HN15bjmAN+LQQLwWnYVuBdBQ2w1OEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dkMKj2qCczKHMKM;
	Sun,  4 Jan 2026 10:47:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6BAB840576;
	Sun,  4 Jan 2026 10:48:13 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCHNvfs1FlpShA6Cg--.24337S2;
	Sun, 04 Jan 2026 10:48:13 +0800 (CST)
Message-ID: <758f42df-52c2-4660-8ef7-1cbacb9323d2@huaweicloud.com>
Date: Sun, 4 Jan 2026 10:48:11 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH v2 2/4] cgroup/cpuset: Consistently
 compute effective_xcpus in update_cpumasks_hier()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260101191558.434446-1-longman@redhat.com>
 <20260101191558.434446-3-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260101191558.434446-3-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHNvfs1FlpShA6Cg--.24337S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4xtF18ur17GF1DJF17trb_yoW5JF48pF
	ySkw4avayYqr1rC39xK3Z29r1Fga1vqF4qywn8Kr4fXFy3G3Wv9r1q9anIvr1UJF4DGw45
	ZF98Xr4SqasIy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2026/1/2 3:15, Waiman Long wrote:
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
>  kernel/cgroup/cpuset.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index da2b3b51630e..37d118a9ad4d 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2168,17 +2168,13 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>  		spin_lock_irq(&callback_lock);
>  		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
>  		cp->partition_root_state = new_prs;
> -		if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
> -			compute_excpus(cp, cp->effective_xcpus);
> -
>  		/*
> -		 * Make sure effective_xcpus is properly set for a valid
> -		 * partition root.
> +		 * Need to compute effective_xcpus if either exclusive_cpus
> +		 * is non-empty or it is a valid partition root.
>  		 */
> -		if ((new_prs > 0) && cpumask_empty(cp->exclusive_cpus))
> -			cpumask_and(cp->effective_xcpus,
> -				    cp->cpus_allowed, parent->effective_xcpus);
> -		else if (new_prs < 0)
> +		if ((new_prs > 0) || !cpumask_empty(cp->exclusive_cpus))
> +			compute_excpus(cp, cp->effective_xcpus);
> +		if (new_prs < 0)
>  			reset_partition_data(cp);
>  		spin_unlock_irq(&callback_lock);
>  

The code resets partition data only for new_prs < 0. My understanding is that a partition is invalid
when new_prs <= 0. Shouldn't reset_partition_data() also be called when new_prs = 0? Is there a
specific reason to skip the reset in that case?

-- 
Best regards,
Ridong


