Return-Path: <linux-kselftest+bounces-48696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B1FD103F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 02:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 612C1301E98D
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 01:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE01222566;
	Mon, 12 Jan 2026 01:25:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD5047A6B;
	Mon, 12 Jan 2026 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768181114; cv=none; b=EZV6N/m40S8WumkNcg6a+0GIROuImrsZQf29uQ5MDCyZBnXTrvRn0U6+p2/cDG2wOpaZMibetT0BZc0NyldRmdF1cZUJAvC47hUuyO+n50QEmcANl4lXgUqrRNvzyEoO42sL2Ux1EZ4xW4z7I5SEsqOsrrryY7fwugBzoGvwuC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768181114; c=relaxed/simple;
	bh=FGLXoDTdmFGJ1JvVvQqVhxwUBH4Eeu33O2Oi0KYjms0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbPKrargYIuIEI7j+op39V0XxC0f5/FYkrPeiPnbQjJmBBoLhjOu/Dh3T8BCQcBZKEQazhP46LXmvkLc8DbdYn8U43Jj11HugjgGtCAcFIwIazy9lANvdX9db8adS9RRHFo/s8eE69jzxuuXWMLTS/xhP3WkDrEKpfuXIy10KHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dqF6f6sTDzYQtgh;
	Mon, 12 Jan 2026 09:24:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7C70F40539;
	Mon, 12 Jan 2026 09:25:08 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgD3pPVyTWRpYUfyDQ--.57454S2;
	Mon, 12 Jan 2026 09:25:08 +0800 (CST)
Message-ID: <d8f7d319-3b72-4531-ab25-a2505cdce828@huaweicloud.com>
Date: Mon, 12 Jan 2026 09:25:06 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-6.20 v3 3/5] cgroup/cpuset: Don't fail
 cpuset.cpus change in v2
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260110013246.293889-1-longman@redhat.com>
 <20260110013246.293889-4-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260110013246.293889-4-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgD3pPVyTWRpYUfyDQ--.57454S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr13WrWDXF48tr4rCrykZrb_yoW7Ar4fpF
	WDC3W3KayYgF1UC3y5Kwn7WrsYgw40v3ZFyw15Jw1rZr9xGF12yrs5JwnxAFy3G3yfGa15
	tFZay3yfW3Z0yrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
> The cgroup-v2.rst doc file is also updated to reflect this change.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  8 +++----
>  kernel/cgroup/cpuset.c                  | 30 ++++++++++++-------------
>  2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 7f5b59d95fce..510df2461aff 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2561,10 +2561,10 @@ Cpuset Interface Files
>  	Users can manually set it to a value that is different from
>  	"cpuset.cpus".	One constraint in setting it is that the list of
>  	CPUs must be exclusive with respect to "cpuset.cpus.exclusive"
> -	of its sibling.  If "cpuset.cpus.exclusive" of a sibling cgroup
> -	isn't set, its "cpuset.cpus" value, if set, cannot be a subset
> -	of it to leave at least one CPU available when the exclusive
> -	CPUs are taken away.
> +	and "cpuset.cpus.exclusive.effective" of its siblings.	Another
> +	constraint is that it cannot be a superset of "cpuset.cpus"
> +	of its sibling in order to leave at least one CPU available to
> +	that sibling when the exclusive CPUs are taken away.
>  
>  	For a parent cgroup, any one of its exclusive CPUs can only
>  	be distributed to at most one of its child cgroups.  Having an
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 894131f47f78..4819ab429771 100644
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
> + * @xcpus_changed: set if exclusive_cpus has been set
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
> +				      bool xcpus_changed)
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
> +	if (xcpus_changed && !cpumask_empty(sibling->cpus_allowed) &&
> +	    cpumask_subset(sibling->cpus_allowed, trial->exclusive_cpus))
>  		return true;
>  
>  	return false;
> @@ -672,6 +670,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>  {
>  	struct cgroup_subsys_state *css;
>  	struct cpuset *c, *par;
> +	bool xcpus_changed;
>  	int ret = 0;
>  
>  	rcu_read_lock();
> @@ -728,10 +727,11 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>  	 * overlap. exclusive_cpus cannot overlap with each other if set.
>  	 */
>  	ret = -EINVAL;
> +	xcpus_changed = !cpumask_equal(cur->exclusive_cpus, trial->exclusive_cpus);
>  	cpuset_for_each_child(c, css, par) {
>  		if (c == cur)
>  			continue;
> -		if (cpus_excl_conflict(trial, c))
> +		if (cpus_excl_conflict(trial, c, xcpus_changed))
>  			goto out;
>  		if (mems_excl_conflict(trial, c))
>  			goto out;

Reviewed-by: Chen Ridong <chenridong@huawei.com>

-- 
Best regards,
Ridong


