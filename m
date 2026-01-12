Return-Path: <linux-kselftest+bounces-48699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF27FD10565
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 03:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67F41300ACF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 02:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E8F302CAB;
	Mon, 12 Jan 2026 02:29:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2933009C3;
	Mon, 12 Jan 2026 02:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768184978; cv=none; b=J5icWncdHuehcP3q5qCl7CAbxhaja8w08r6L7wZt4xOQfRTwHUeu3Wu4PxuWXTtLmt628keDkVEfv3GdIhZ2alYEky+UgILL3q9yuiu6BEcCC8hgPPxs1QgyY3Z/NeNXEAXPF/Gi1cTB3sKTP7VaVFqPrFQGAeLy3Le6j6oWkLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768184978; c=relaxed/simple;
	bh=sYn8eYXIpmLVv7cPbMev6/1TZyFtVlpC6ZwR2Q9zxVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ab8xNzD0i2wrpC3c8qg+OeOof69yuEN3cg5av+7Anm5FjKaKMEq7U2Ql/l2cRuTpMjlqjiZG7mDv/msrnYliy0sn8AjrSZDSrcXCP00N5EeDt3w+ORnmd2GkfEvRZK1TTGrs2e/50JJWzdW7vUGUbJ/JBBCMl3aNX3JvPltbDrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dqGXB3SqMzKHMcm;
	Mon, 12 Jan 2026 10:28:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C27BD40577;
	Mon, 12 Jan 2026 10:29:30 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA3l_eHXGRp_6D3DQ--.42057S2;
	Mon, 12 Jan 2026 10:29:28 +0800 (CST)
Message-ID: <6812a73c-ace6-447a-9f92-4bc8783b3ed5@huaweicloud.com>
Date: Mon, 12 Jan 2026 10:29:26 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-6.20 v3 5/5] cgroup/cpuset: Move the v1 empty
 cpus/mems check to cpuset1_validate_change()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260110013246.293889-1-longman@redhat.com>
 <20260110013246.293889-6-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260110013246.293889-6-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3l_eHXGRp_6D3DQ--.42057S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr43KF4kZryrKFW8urWxJFb_yoWxCw1fpF
	W3G347ArWUtF1xCw4agasrWFWFgw18XF17KFn8Xwn5ZF1ayF1jyr1vq3Z3Jry7GryxCrWY
	qFsIvr4F9ayDt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2026/1/10 9:32, Waiman Long wrote:
> As stated in commit 1c09b195d37f ("cpuset: fix a regression in validating
> config change"), it is not allowed to clear masks of a cpuset if
> there're tasks in it. This is specific to v1 since empty "cpuset.cpus"
> or "cpuset.mems" will cause the v2 cpuset to inherit the effective CPUs
> or memory nodes from its parent. So it is OK to have empty cpus or mems
> even if there are tasks in the cpuset.
> 
> Move this empty cpus/mems check in validate_change() to
> cpuset1_validate_change() to allow more flexibility in setting
> cpus or mems in v2. cpuset_is_populated() needs to be moved into
> cpuset-internal.h as it is needed by the empty cpus/mems checking code.
> 
> Also add a test case to test_cpuset_prs.sh to verify that.
> 
> Reported-by: Chen Ridong <chenridong@huaweicloud.com>
> Closes: https://lore.kernel.org/lkml/7a3ec392-2e86-4693-aa9f-1e668a668b9c@huaweicloud.com/
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset-internal.h               |  9 ++++++++
>  kernel/cgroup/cpuset-v1.c                     | 14 +++++++++++
>  kernel/cgroup/cpuset.c                        | 23 -------------------
>  .../selftests/cgroup/test_cpuset_prs.sh       |  3 +++
>  4 files changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index e8e2683cb067..fd7d19842ded 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -260,6 +260,15 @@ static inline int nr_cpusets(void)
>  	return static_key_count(&cpusets_enabled_key.key) + 1;
>  }
>  
> +static inline bool cpuset_is_populated(struct cpuset *cs)
> +{
> +	lockdep_assert_cpuset_lock_held();
> +
> +	/* Cpusets in the process of attaching should be considered as populated */
> +	return cgroup_is_populated(cs->css.cgroup) ||
> +		cs->attach_in_progress;
> +}
> +
>  /**
>   * cpuset_for_each_child - traverse online children of a cpuset
>   * @child_cs: loop cursor pointing to the current child
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 04124c38a774..7a23b9e8778f 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -368,6 +368,20 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
>  	if (par && !is_cpuset_subset(trial, par))
>  		goto out;
>  
> +	/*
> +	 * Cpusets with tasks - existing or newly being attached - can't
> +	 * be changed to have empty cpus_allowed or mems_allowed.
> +	 */
> +	ret = -ENOSPC;
> +	if (cpuset_is_populated(cur)) {
> +		if (!cpumask_empty(cur->cpus_allowed) &&
> +		    cpumask_empty(trial->cpus_allowed))
> +			goto out;
> +		if (!nodes_empty(cur->mems_allowed) &&
> +		    nodes_empty(trial->mems_allowed))
> +			goto out;
> +	}
> +
>  	ret = 0;
>  out:
>  	return ret;

The current implementation is sufficient.

However, I suggest we fully separate the validation logic for v1 and v2. While this may introduce
some code duplication (likely minimal), it would allow us to modify the validate_change logic for v2
in the future without needing to consider v1 compatibility. Given that v1 is unlikely to see further
changes, this separation would be a practical long-term decision.

@@ -368,6 +368,48 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
        if (par && !is_cpuset_subset(trial, par))
                goto out;

+       /*
+        * Cpusets with tasks - existing or newly being attached - can't
+        * be changed to have empty cpus_allowed or mems_allowed.
+        */
+       ret = -ENOSPC;
+       if (cpuset_is_populated(cur)) {
+               if (!cpumask_empty(cur->cpus_allowed) &&
+                   cpumask_empty(trial->cpus_allowed))
+                       goto out;
+               if (!nodes_empty(cur->mems_allowed) &&
+                   nodes_empty(trial->mems_allowed))
+                       goto out;
+       }
+
+       /*
+        * We can't shrink if we won't have enough room for SCHED_DEADLINE
+        * tasks. This check is not done when scheduling is disabled as the
+        * users should know what they are doing.
+        *
+        * For v1, effective_cpus == cpus_allowed & user_xcpus() returns
+        * cpus_allowed.
+        *
+        */
+       ret = -EBUSY;
+       if (is_cpu_exclusive(cur) && is_sched_load_balance(cur) &&
+           !cpuset_cpumask_can_shrink(cur->effective_cpus, user_xcpus(trial)))
+               goto out;
+
+       /*
+        * If either I or some sibling (!= me) is exclusive, we can't
+        * overlap. exclusive_cpus cannot overlap with each other if set.
+        */
+       ret = -EINVAL;
+       cpuset_for_each_child(c, css, par) {
+               if (c == cur)
+                       continue;
+               if (cpuset1_cpus_excl_conflict(trial, c))
+                       goto out;
+               if (mems_excl_conflict(trial, c))
+                       goto out;
+       }
+
        ret = 0;
 out:
        return ret;

> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 83fb83a86b4b..a3dbca125588 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -370,15 +370,6 @@ static inline bool is_in_v2_mode(void)
>  	      (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
>  }
>  
> -static inline bool cpuset_is_populated(struct cpuset *cs)
> -{
> -	lockdep_assert_held(&cpuset_mutex);
> -
> -	/* Cpusets in the process of attaching should be considered as populated */
> -	return cgroup_is_populated(cs->css.cgroup) ||
> -		cs->attach_in_progress;
> -}
> -
>  /**
>   * partition_is_populated - check if partition has tasks
>   * @cs: partition root to be checked
> @@ -695,20 +686,6 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>  
>  	par = parent_cs(cur);
>  
> -	/*
> -	 * Cpusets with tasks - existing or newly being attached - can't
> -	 * be changed to have empty cpus_allowed or mems_allowed.
> -	 */
> -	ret = -ENOSPC;
> -	if (cpuset_is_populated(cur)) {
> -		if (!cpumask_empty(cur->cpus_allowed) &&
> -		    cpumask_empty(trial->cpus_allowed))
> -			goto out;
> -		if (!nodes_empty(cur->mems_allowed) &&
> -		    nodes_empty(trial->mems_allowed))
> -			goto out;
> -	}
> -
>  	/*
>  	 * We can't shrink if we won't have enough room for SCHED_DEADLINE
>  	 * tasks. This check is not done when scheduling is disabled as the
> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> index ff4540b0490e..5dff3ad53867 100755
> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> @@ -425,6 +425,9 @@ TEST_MATRIX=(
>  	# cpuset.cpus can be set to a subset of sibling's cpuset.cpus.exclusive
>  	" C1-3:X1-3  .      .    C4-5      .     .      .     C1-2   0 A1:1-3|B1:1-2"
>  
> +	# cpuset.cpus can become empty with task in it as it inherits parent's effective CPUs
> +	" C1-3:S+   C2      .      .       .    T:C     .      .     0 A1:1-3|A2:1-3"
> +
>  	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
>  	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
>  	# Failure cases:

-- 
Best regards,
Ridong


