Return-Path: <linux-kselftest+bounces-48695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3188D103CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 02:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C938300DC90
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 01:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585A6218AAD;
	Mon, 12 Jan 2026 01:13:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1AF158538;
	Mon, 12 Jan 2026 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768180404; cv=none; b=BpWSE9MGBlcBOok1rtdRqZqwYaWFfKUi03AYe4cuG4IF1ch8+UkNs7KcmCOpXQ6xn8IHLECat2/5BhWVyvsWH/WouVw1hDPsiBp8YICcKLZK1zG6FrpHBUblkGi1yLp0YA84YJMpkcdcGzb6ol2K1FY2xGpQf0wMLyvAuF441v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768180404; c=relaxed/simple;
	bh=HUfy8qYTgSm8Gnc9CbQXQlB0Tsvh+pVatzIRC9A0oEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHGsIKSCBQHmgs3ssO/PPJ+PDuB2I6bSr4pd7lbTaf8lMBM9e03pMdAy5YU7TGKF7pxiktCV5Kcq0zBlaS5jU+zOjiBzV7VWwoqbvxcx75lsv847D8HwvD+WidwAYzjPAYayJjr51hodcRTIHDPLtTuvYjExHDkcWgC/wYlmmsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dqDrG0Gh0zKHMMJ;
	Mon, 12 Jan 2026 09:12:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 438DA40539;
	Mon, 12 Jan 2026 09:13:18 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgAniPitSmRpGkvxDQ--.48898S2;
	Mon, 12 Jan 2026 09:13:18 +0800 (CST)
Message-ID: <d26ede5b-3e2a-4faf-a29f-45620fc1088e@huaweicloud.com>
Date: Mon, 12 Jan 2026 09:13:16 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-6.20 v3 2/5] cgroup/cpuset: Consistently
 compute effective_xcpus in update_cpumasks_hier()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260110013246.293889-1-longman@redhat.com>
 <20260110013246.293889-3-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260110013246.293889-3-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAniPitSmRpGkvxDQ--.48898S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KryxXrWrXryxuryrCFyUKFg_yoW8Kr1UpF
	18Cw4avayYqr1rC39rK3ZF9r1Fga1vqF4qyw1Dtr4fXFy3C3Wv9r1DZanxXr1UGa1kGr15
	AF98Zr4Sqas0y37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2026/1/10 9:32, Waiman Long wrote:
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
> index da2b3b51630e..894131f47f78 100644
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
> +		if (new_prs <= 0)
>  			reset_partition_data(cp);
>  		spin_unlock_irq(&callback_lock);
>  

Looks good to me.

Reviewed-by: chenridong<huawei@.com>

-- 
Best regards,
Ridong


