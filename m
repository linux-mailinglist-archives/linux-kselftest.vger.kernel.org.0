Return-Path: <linux-kselftest+bounces-45720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C02C62C9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 08:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A8E74E2DD4
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 07:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25B831A810;
	Mon, 17 Nov 2025 07:45:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBDD2D877B;
	Mon, 17 Nov 2025 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763365555; cv=none; b=EJWzYmYzbYZs805qvsUrE+iqM6AKuEVfQOEKAv18esUPh1cCOoUcHyifMHwJFCOY/jfC8Er1YnOTZb5BmQzP/CjZJvTKZofHcC1TPFT+6C8qnZF6mQrkp7uK3MfAFoKoT7UXU4fBR74l6T6pVIeBUfjxUFhlyJxttm/h6+h3SmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763365555; c=relaxed/simple;
	bh=EbNxfSdIJxkkYRxf8iJ7gn0LKWwTw9Xv1/OhMGTP6rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5UfuHc6uTPsNzOEWdNAD8Wck+ezzOf567dRht0mB0SBiFb92SoagMknBOnDgySOjbgUykyw8JF/5S5FhsukOysVq4A+e7wq15O0RlGrYTiQnb64LHPFWmaU6xwsZWdKduv1MUoYNLvAEBeRK0+QPs6pvfxu/A6k4Bht9OB4z3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d90CD43ZYzYQv57;
	Mon, 17 Nov 2025 15:45:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0A2431A1A48;
	Mon, 17 Nov 2025 15:45:49 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBnj1yr0hppanUoBA--.12700S2;
	Mon, 17 Nov 2025 15:45:48 +0800 (CST)
Message-ID: <fe8046d7-1f21-4b23-92f2-6be24ef9f58b@huaweicloud.com>
Date: Mon, 17 Nov 2025 15:45:47 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] cpuset: relax the overlap check for cgroup-v2
To: Sun Shaojie <sunshaojie@kylinos.cn>, llong@redhat.com
Cc: mkoutny@suse.com, cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, tj@kernel.org
References: <20251117015708.977585-1-sunshaojie@kylinos.cn>
 <20251117015708.977585-2-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251117015708.977585-2-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnj1yr0hppanUoBA--.12700S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar15CFWUCw4rCF4rKFyUKFg_yoW3uF48pF
	W8GF4jy3yjgF1UCw13Kr1kWrsYgw40qFnrtrn5Jr1rAF9rJF1xArn8JwnxtFy5XrZ8Ww13
	ZFZIy3yfuFs8trUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/17 9:57, Sun Shaojie wrote:
> In cgroup v2, a mutual overlap check is required when at least one of two
> cpusets is exclusive. However, this check should be relaxed and limited to
> cases where both cpusets are exclusive.
> 
> This patch ensures that for sibling cpusets A1 (exclusive) and B1
> (non-exclusive), change B1 cannot affect A1's exclusivity.
> 
> for example. Assume a machine has 4 CPUs (0-3).
> 
>    root cgroup
>       /    \
>     A1      B1
> 
> Case 1:
>  Table 1.1: Before applying the patch
>  Step                                       | A1's prstate | B1'sprstate |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      |
>  #3> echo "0" > B1/cpuset.cpus              | root invalid | member      |
> 
> After step #3, A1 changes from "root" to "root invalid" because its CPUs
> (0-1) overlap with those requested by B1 (0-3). However, B1 can actually

B1 (0-3) --> B1(0) ?

> use CPUs 2-3(from B1's parent), so it would be more reasonable for A1 to
> remain as "root."
> 
>  Table 1.2: After applying the patch
>  Step                                       | A1's prstate | B1'sprstate |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      |
>  #3> echo "0" > B1/cpuset.cpus              | root         | member      |
> 
> All other cases remain unaffected. For example, cgroup-v1, both A1 and B1
> are exclusive or non-exlusive.
> 
> Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
> ---
>  kernel/cgroup/cpuset-internal.h               |  3 ++
>  kernel/cgroup/cpuset-v1.c                     | 20 +++++++++
>  kernel/cgroup/cpuset.c                        | 43 ++++++++++++++-----
>  .../selftests/cgroup/test_cpuset_prs.sh       |  5 ++-
>  4 files changed, 58 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 337608f408ce..c53111998432 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -292,6 +292,7 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>  			    struct cpumask *new_cpus, nodemask_t *new_mems,
>  			    bool cpus_updated, bool mems_updated);
>  int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
> +bool cpuset1_cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2);
>  #else
>  static inline void fmeter_init(struct fmeter *fmp) {}
>  static inline void cpuset1_update_task_spread_flags(struct cpuset *cs,
> @@ -302,6 +303,8 @@ static inline void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>  			    bool cpus_updated, bool mems_updated) {}
>  static inline int cpuset1_validate_change(struct cpuset *cur,
>  				struct cpuset *trial) { return 0; }
> +static inline bool cpuset1_cpus_excl_conflict(struct cpuset *cs1,
> +				struct cpuset *cs2) {return false; }
>  #endif /* CONFIG_CPUSETS_V1 */
>  
>  #endif /* __CPUSET_INTERNAL_H */
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 12e76774c75b..5c1296bf6a34 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -373,6 +373,26 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
>  	return ret;
>  }
>  
> +/*
> + * cpuset1_cpus_excl_conflict() - Check if two cpusets have exclusive CPU conflicts
> + *                                to legacy (v1)
> + * @cs1: first cpuset to check
> + * @cs2: second cpuset to check
> + *
> + * Returns: true if CPU exclusivity conflict exists, false otherwise
> + *
> + * If either cpuset is CPU exclusive, their allowed CPUs cannot intersect.
> + */
> +bool cpuset1_cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
> +{
> +	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
> +		if (cpumask_intersects(cs1->cpus_allowed,
> +				       cs2->cpus_allowed))
> +			return true;
> +
> +	return false;
> +}
> +
>  #ifdef CONFIG_PROC_PID_CPUSET
>  /*
>   * proc_cpuset_show()
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 52468d2c178a..0fd803612513 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -580,35 +580,56 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>  
>  /**
>   * cpus_excl_conflict - Check if two cpusets have exclusive CPU conflicts
> - * @cs1: first cpuset to check
> - * @cs2: second cpuset to check
> + * @cs1: current cpuset to check
> + * @cs2: cpuset involved in the check
>   *
>   * Returns: true if CPU exclusivity conflict exists, false otherwise
>   *
>   * Conflict detection rules:
> - * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
> + * For cgroup-v1:
> + *     see cpuset1_cpus_excl_conflict()
> + * For cgroup-v2:
> + * 1. If cs1 is exclusive, cs1 and cs2 must be mutually exclusive
>   * 2. exclusive_cpus masks cannot intersect between cpusets
> - * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
> + * 3. If cs2 is exclusive, cs2's allowed CPUs cannot be a subset of cs1's exclusive CPUs
> + * 4. if cs1 and cs2 are not exclusive, the allowed CPUs of one cpuset cannot be a subset
> + *    of another's exclusive CPUs
>   */

The revised conflict detection rules are confusing to me. I thought cs1 and cs2 should be treated
symmetrically, but that doesn’t seem to be the case here.

Shouldn’t the following rule apply regardless of whether cs1 or cs2 is exclusive: "The allowed CPUs
of one cpuset cannot be a subset of another's exclusive CPUs"?

>  static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>  {
> -	/* If either cpuset is exclusive, check if they are mutually exclusive */
> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
> +	/* For cgroup-v1 */
> +	if (!cpuset_v2())
> +		return cpuset1_cpus_excl_conflict(cs1, cs2);
> +
> +	/* If cs1 are exclusive, check if they are mutually exclusive */
> +	if (is_cpu_exclusive(cs1))
>  		return !cpusets_are_exclusive(cs1, cs2);
>  
> +	/* The following check applies when either
> +	 * both cs1 and cs2 are non-exclusive，or
> +	 * only cs2 is exclusive.
> +	 */
> +
>  	/* Exclusive_cpus cannot intersect */
>  	if (cpumask_intersects(cs1->exclusive_cpus, cs2->exclusive_cpus))
>  		return true;
>  
> -	/* The cpus_allowed of one cpuset cannot be a subset of another cpuset's exclusive_cpus */
> -	if (!cpumask_empty(cs1->cpus_allowed) &&
> -	    cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
> -		return true;
> -
> +	/* cs2's allowed CPUs cannot be a subset of cs1's exclusive CPUs */
>  	if (!cpumask_empty(cs2->cpus_allowed) &&
>  	    cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
>  		return true;
>  
> +	/* If cs2 is exclusive, check finished here */
> +	if (is_cpu_exclusive(cs2))
> +		return false;
> +
> +	/* The following check applies only if both cs1 and cs2 are non-exclusive. */
> +
> +	/* cs1's allowed CPUs cannot be a subset of cs1's exclusive CPUs */
> +	if (!cpumask_empty(cs1->cpus_allowed) &&
> +	    cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
> +		return true;
> +
>  	return false;
>  }
>  

From your commit message, it appears you intend to modify "if (is_cpu_exclusive(cs1) ||
is_cpu_exclusive(cs2))" to "if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))".

However, I’m having trouble following the change.

> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> index a17256d9f88a..b848bc0729cf 100755
> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> @@ -388,10 +388,11 @@ TEST_MATRIX=(
>  	"  C0-1:S+  C1      .    C2-3     .      P2     .      .     0 A1:0-1|A2:1 A1:P0|A2:P-2"
>  	"  C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0|A2:1 A1:P1|A2:P2 0-1|1"
>  
> -	# A non-exclusive cpuset.cpus change will invalidate partition and its siblings
> +	# A non-exclusive cpuset.cpus change will not invalidate its siblings partition.
> +	# But a exclusive cpuset.cpus change will invalidate itself.
>  	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P0"
>  	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P-1"
> -	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P0|B1:P-1"
> +	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-1|B1:2-3 A1:P0|B1:P1"
>  
>  	# cpuset.cpus can overlap with sibling cpuset.cpus.exclusive but not subsumed by it
>  	"   C0-3     .      .    C4-5     X5     .      .      .     0 A1:0-3|B1:4-5"

-- 
Best regards,
Ridong


