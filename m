Return-Path: <linux-kselftest+bounces-47961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B72CDDB84
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Dec 2025 12:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5D4530173A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Dec 2025 11:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C094931AAA2;
	Thu, 25 Dec 2025 11:54:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057FB3A1E90;
	Thu, 25 Dec 2025 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766663673; cv=none; b=S37GGDFm/MeVCtp8mjX4tv8eWnv/D2O3/E1gEHZDW1jPW+HMw5rzHfZfLwDItgZPWoNCqV/+d6pw8/z94OYkBe1k6jRx7Mmzw2SU30Aej6KCef/jZ1PkJ4SKvStCkyHgR+dAouXiJvsKKLx8GQV6WgKts5BsFyVRf9LFbBpDpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766663673; c=relaxed/simple;
	bh=7HAILs49WdrnS4WcuMD9G6mH9eTAI9yDMxe0W5n7zX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhEMeuFVFFUCFFe+3bLJqLuhDcHC0WCYK0+3P1D1o6DFfrlhZSaqkNEo+1anwGW969HOT3bU7KRYE/4Ybk/OnL/xvX0+gJ+iGoWihIK2E5hL/Gkn97bWAT4JklUO/npFJg6UvfwWz3UDvkC6haHrwensBQWBohwSD0oytz5Qu0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dcRwt1DPkzKHMd6;
	Thu, 25 Dec 2025 19:54:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 721274058C;
	Thu, 25 Dec 2025 19:54:27 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgC3F_jyJU1piXu7BQ--.52259S2;
	Thu, 25 Dec 2025 19:54:27 +0800 (CST)
Message-ID: <4792e3f5-11ea-4b1c-90fe-f7f202271dae@huaweicloud.com>
Date: Thu, 25 Dec 2025 19:54:25 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH 3/4] cgroup/cpuset: Don't fail cpuset.cpus
 change in v2
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Sun Shaojie <sunshaojie@kylinos.cn>
References: <20251225073056.30789-1-longman@redhat.com>
 <20251225073056.30789-4-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251225073056.30789-4-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3F_jyJU1piXu7BQ--.52259S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4fCw1Utr1DGr1Utr1fZwb_yoWrtr4fpF
	WUCF17KayjgF1UCw45Kwn7WrsYgw40qFnrtwn8Jr1rAry3JF1IyFn5JwnxAFy3G395Gw45
	JFZIy393WFn8ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/25 15:30, Waiman Long wrote:
> Commit fe8cd2736e75 ("cgroup/cpuset: Delay setting of CS_CPU_EXCLUSIVE
> until valid partition") introduced a new check to disallow the setting
> of a new cpuset.cpus.exclusive value that is a superset of a sibling's
> cpuset.cpus value so that there will at least be one CPU left in the
> sibling in case the cpuset becomes a valid partition root. This new
> check does have the side effect of failing a cpuset.cpus change that
> make it a subset of a sibling's cpuset.cpus.exclusive value.
> 
> With v2, users are supposed to be allowed to set whatever value they
> want in cpuset.cpus without failure. To maintain this rule, the check
> is now restricted to only when cpuset.cpus.exclusive is being changed
> not when cpuset.cpus is changed.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 850334dbc36a..83bf6b588e5f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -609,33 +609,31 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>  
>  /**
>   * cpus_excl_conflict - Check if two cpusets have exclusive CPU conflicts
> - * @cs1: first cpuset to check
> - * @cs2: second cpuset to check
> + * @trial:	the trial cpuset to be checked
> + * @sibling:	a sibling cpuset to be checked against
> + * @new_xcpus:	new exclusive_cpus in trial cpuset
>   *
>   * Returns: true if CPU exclusivity conflict exists, false otherwise
>   *
>   * Conflict detection rules:
>   * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
>   * 2. exclusive_cpus masks cannot intersect between cpusets
> - * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
> + * 3. The allowed CPUs of a sibling cpuset cannot be a subset of the new exclusive CPUs
>   */
> -static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
> +static inline bool cpus_excl_conflict(struct cpuset *trial, struct cpuset *sibling,
> +				      bool new_xcpus)
>  {
>  	/* If either cpuset is exclusive, check if they are mutually exclusive */
> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
> -		return !cpusets_are_exclusive(cs1, cs2);
> +	if (is_cpu_exclusive(trial) || is_cpu_exclusive(sibling))
> +		return !cpusets_are_exclusive(trial, sibling);
>  
>  	/* Exclusive_cpus cannot intersect */
> -	if (cpumask_intersects(cs1->exclusive_cpus, cs2->exclusive_cpus))
> +	if (cpumask_intersects(trial->exclusive_cpus, sibling->exclusive_cpus))
>  		return true;
>  
> -	/* The cpus_allowed of one cpuset cannot be a subset of another cpuset's exclusive_cpus */
> -	if (!cpumask_empty(cs1->cpus_allowed) &&
> -	    cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
> -		return true;
> -
> -	if (!cpumask_empty(cs2->cpus_allowed) &&
> -	    cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
> +	/* The cpus_allowed of a sibling cpuset cannot be a subset of the new exclusive_cpus */
> +	if (new_xcpus && !cpumask_empty(sibling->cpus_allowed) &&
> +	    cpumask_subset(sibling->cpus_allowed, trial->exclusive_cpus))
>  		return true;
>  
>  	return false;
> @@ -672,6 +670,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>  {
>  	struct cgroup_subsys_state *css;
>  	struct cpuset *c, *par;
> +	bool new_xcpus;
>  	int ret = 0;
>  
>  	rcu_read_lock();
> @@ -728,10 +727,11 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>  	 * overlap. exclusive_cpus cannot overlap with each other if set.
>  	 */
>  	ret = -EINVAL;
> +	new_xcpus = !cpumask_equal(cur->exclusive_cpus, trial->exclusive_cpus);
>  	cpuset_for_each_child(c, css, par) {
>  		if (c == cur)
>  			continue;
> -		if (cpus_excl_conflict(trial, c))
> +		if (cpus_excl_conflict(trial, c, new_xcpus))
>  			goto out;
>  		if (mems_excl_conflict(trial, c))
>  			goto out;

validate_change() is also called from cpuset_update_flag(), which may not change any cpus_allowed or
exclusive_cpus. This could lead to incorrect checks.

i.e,

# cd /sys/fs/cgroup/
# mkdir a
# mkdir b
# echo 1-2 > b/cpuset.cpus.exclusive  -- no conflict with a
# echo 1 > a/cpuset.cpus
# echo root > b/cpuset.cpus.partition  -- b becomes root partition, conflict with a, but
exclusive_cpus unchanged
# cat b/cpuset.cpus.partition
root

As a result, cpuset a (as a member) contains CPU 1, which is a subset of partition b's exclusive
CPUs — a conflict that might be missed.

-- 
Best regards,
Ridong


