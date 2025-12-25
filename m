Return-Path: <linux-kselftest+bounces-47952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15450CDD6EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Dec 2025 08:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D2943021759
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Dec 2025 07:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0142F3C0A;
	Thu, 25 Dec 2025 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBV/oXQ9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQiBoPu0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AAD2F3C13
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Dec 2025 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766647825; cv=none; b=cd8f5LvKkCTjgpYtSw/DvI5k8Npobdixr1EA5Ozn7GtqmphkJyJKQHppKc/xH8POJxreMvWtNN2H6FCGnwXx0spmf3Fq2mEYGcneZsYfNLSiHznj2jqmLeMuvZ4VsyAxTWfqu6qf5tm2/E/fEZwJzItKfegGAj7PFGcydFG6QyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766647825; c=relaxed/simple;
	bh=OtUvLQfKemV9fXYyYNYTElN1Y3nmS2CqDBw54m7MmwU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hIUfsqHpnZfXTn4kp6esRL96wNH57pOSrjb0EMsPwqce+ZOsriOSFpVu3GBg6t7NBcv9OyDZ6HXYKHDeWjBaagZugwJke/pJouI+QnMdiu24ZT2NJGmczvQsIpgqrXh8d6FSBmqZYL7mz9YHPDcJFAlmirjst4fVCndixEwIg9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBV/oXQ9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQiBoPu0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766647822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imUhEqRS0tgd3QlSgHpKa13LPAK1msZVIQ2TW0Ef7sM=;
	b=KBV/oXQ99Q0dmkgsWiKkCnjL4Hhq9ZyHY0ioYJ7FHjRJmaCSK+/uQR++mPW/ftqtAagBvY
	rA4278/cs68opS3m2hydmD+vuJ5IkI1U63lY59VtQcqvwQT74hujg8hrYH+MxBHQmh5Cu4
	4xN84VS/uoOc4nemmFjMgigfCI9oCRI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-rzrMmf9YPK2Wj89_bpEgWA-1; Thu, 25 Dec 2025 02:30:20 -0500
X-MC-Unique: rzrMmf9YPK2Wj89_bpEgWA-1
X-Mimecast-MFC-AGG-ID: rzrMmf9YPK2Wj89_bpEgWA_1766647820
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88a3356a310so178843736d6.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Dec 2025 23:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766647819; x=1767252619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=imUhEqRS0tgd3QlSgHpKa13LPAK1msZVIQ2TW0Ef7sM=;
        b=MQiBoPu00GdZyQMU8tfWeoeFOvZguvimB7+9dNLql02POnji4YqT3NkO/PEJcitmhU
         4fzM3a9oxVJ9nXxCyuRw5OetQq9RbdvNKmaVZCDnrtGyWj82ftwUR242S2GIpWkWCgpf
         PgpV7ZNZ3j1zCkJtbGkqpEPlthmyZxxyEgmBrZV9uvptYbYnt8WyOCNUDYlDgtCcDX66
         xXNDa8z7/pkIAXo6A+DgPB+IYZUqS9hsFNwXRJnmfAv7Gpjqk8eFXmQLldU7qhGNdAGz
         PAZdIOlO0BnuWQDGDbPpKb7blEE1e1EaVuUoKYROoL8WB83H/OGgMIgPMwpKRigpA0ki
         2bQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766647819; x=1767252619;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=imUhEqRS0tgd3QlSgHpKa13LPAK1msZVIQ2TW0Ef7sM=;
        b=DDnG37Y77dXWIPQR6ezbWTdkO6Ro/h74ApFtnCDsmLVEvHCnHhQ0NthS1qbqhgegAG
         NCRzSOjaSCaWQrM59ZZpg0d7VD+FkvWDNlfHnYuQl0idjhSnYmvOGlxYpZC2cvgXkEGO
         cENScsdacH1rrZXjJenkutm4/hPLPwCES9w2jKy+M0XCrSUYzmganQS/Sr2i6QHe+At+
         VlbvsY8WeAis8B6SO5QksgRm8lWJ5gM6zdQF2tu2zu+upvdTOKyqb5o47yo/39fCSwwZ
         s5YlcUYtyu1GpTPw6pZv0hp3HnE++dMZKb0/F657SuZ4KzCqpJGQS/epRtfIcMVhevIk
         ilgA==
X-Forwarded-Encrypted: i=1; AJvYcCVzm89zqApe/HmqNiHfwDc4NfXLYCWJAatbzbFm/IjYVTRMJEvRaL4Xvv/l2eL7WecwLKRhrs9h4wbXXmHZq4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHC/Y5znRKv4Iv6FBWyFA7EXlIa6VTKZ4/GG5iyvdX6k3Ie4qB
	rb0S65iZpVCV0F3HZDdfy6Sz7hACeBEds2E0TGEGc5SI9s/R/HmgB/Q+3TjnJI+srOp+mphvcXZ
	FipK5wz8IM5MH7+U5o+TDQnGgukUf9diNqj9Qrg+LGFItkkyrOvTEfvRs4M3kB74oyg5ZNNSU3z
	z3Dg==
X-Gm-Gg: AY/fxX5gpW6vsaiu82EnAJGLFjblWHTUiSfNXG7g08iAdqvGvd8bjcO0gMK1UDp+p+a
	yRiYPqTO7k6N6zSyACTUws98h68xmtsJ98WptWnHOMxg6BOfPHMK8n9Rel5f+4JAW5NZga6dMCI
	ZL2pbJ4MTFcDqkUoMLkbhj1m6aL1cpRO0b5AMaEfPheMwb0MvMClkzoe/n2JUJ8f6uBitBBH5Rf
	DW6kQmllM3/yewVLiiiebRlE88bQuzh3itrdphzjnKV4i5RmeE6M7MYKkLa2lkI97+lPMGr7AEy
	r8Sj2nJ/5Myvl+ZchDMMDwHCN4xp4a4MhHRIICMjgFTovFAM0v85E6QNT7ZkTrl5DTg8p4vsoIS
	b8+lp4qore6aA6gOw6vE6VqX9G1ssKyBI7MdfU3y8mRHJaD0Ke/VgvTFI
X-Received: by 2002:ad4:4488:0:b0:880:4eac:8689 with SMTP id 6a1803df08f44-88d84ffeddemr222707826d6.57.1766647818790;
        Wed, 24 Dec 2025 23:30:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGGuC4qQxfj44bogogwY6oBeKxogdsF88VDw5Hk/EXz94P9lzrp1aCJSQsjI2fXcultV0ufQ==
X-Received: by 2002:ad4:4488:0:b0:880:4eac:8689 with SMTP id 6a1803df08f44-88d84ffeddemr222707596d6.57.1766647818194;
        Wed, 24 Dec 2025 23:30:18 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d96bec1d3sm141066956d6.17.2025.12.24.23.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 23:30:17 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a188bfee-7420-4195-a813-2739f3689ba3@redhat.com>
Date: Thu, 25 Dec 2025 02:30:15 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
To: Sun Shaojie <sunshaojie@kylinos.cn>, llong@redhat.com
Cc: cgroups@vger.kernel.org, chenridong@huaweicloud.com, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mkoutny@suse.com, shuah@kernel.org, tj@kernel.org
References: <cae7a3ef-9808-47ac-a061-ab40d3c61020@redhat.com>
 <20251201093806.107157-1-sunshaojie@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20251201093806.107157-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 4:38 AM, Sun Shaojie wrote:
> Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
> with its sibling partition, the sibling's partition state becomes invalid.
> However, this invalidation is often unnecessary.
>
> For example: On a machine with 128 CPUs, there are m (m < 128) cpusets
> under the root cgroup. Each cpuset is used by a single user(user-1 use
> A1, ... , user-m use Am), and the partition states of these cpusets are
> configured as follows:
>
>                             root cgroup
>          /             /                  \                 \
>         A1            A2        ...       An                Am
>       (root)        (root)      ...     (root) (root/root invalid/member)
>
> Assume that A1 through Am have not set cpuset.cpus.exclusive. When
> user-m modifies Am's cpuset.cpus to "0-127", it will cause all partition
> states from A1 to An to change from root to root invalid, as shown
> below.
>
>                             root cgroup
>          /              /                 \                 \
>         A1             A2       ...       An                Am
>   (root invalid) (root invalid) ... (root invalid) (root invalid/member)
>
> This outcome is entirely undeserved for all users from A1 to An.
>
> This patch prevents such outcomes by ensuring that modifications to
> cpuset.cpus do not affect the partition state of other sibling cpusets.
> Therefore, with this patch applied, when user-m configures Am's
> cpuset.cpus to "0-127", the result will be as follows.
>
>                             root cgroup
>          /             /                  \                 \
>         A1            A2        ...       An                Am
>       (root)        (root)      ...     (root)     (root invalid/member)
>
> It is worth noting that, since this patch enforces the exclusivity of
> sibling cpusets, setting exclusivity now follows a "first-come,
> first-served" principle.
>
> For example, consider the following four steps: before applying this
> patch, regardless of the order in which they are executed, the final
> partition state of both A1 and B1 would always be "root invalid."
>
>   Step                                       | A1's prstate | B1's prstate |
>   #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>   #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>   #3> echo "1-2" > B1/cpuset.cpus            | root invalid | member       |
>   #4> echo "root" > B1/cpuset.cpus.partition | root invalid | root invalid |
>
> After applying this patch, the first party to set "root" will maintain
> its exclusive validity. As follows:
>
>   Step                                       | A1's prstate | B1's prstate |
>   #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>   #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>   #3> echo "1-2" > B1/cpuset.cpus            | root         | member       |
>   #4> echo "root" > B1/cpuset.cpus.partition | root         | root invalid |
>
>   Step                                       | A1's prstate | B1's prstate |
>   #1> echo "0-1" > B1/cpuset.cpus            | member       | member       |
>   #2> echo "root" > B1/cpuset.cpus.partition | member       | root         |
>   #3> echo "1-2" > A1/cpuset.cpus            | member       | root         |
>   #4> echo "root" > A1/cpuset.cpus.partition | root invalid | root         |
>
> In summary, if the current cpuset conflicts with its sibling cpusets on
> exclusive CPUs (If a cpuset is exclusive and its exclusive CPUs are empty,
> its allowed CPUs will be treated as exclusive CPUs), only the current
> cpuset should bear the consequences.
>
> Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>

I agree with you that it is probably not a good idea to invalidate 
partitions whenever there is a conflict. However, I have a different 
idea of how to do it. I am going to post another patch to show my idea. 
Let me know what you think about it and whether it can meet your need.

Cheers,
Longman

> ---
>   kernel/cgroup/cpuset-internal.h               |  3 +
>   kernel/cgroup/cpuset-v1.c                     | 19 ++++++
>   kernel/cgroup/cpuset.c                        | 60 ++++++++++++-------
>   .../selftests/cgroup/test_cpuset_prs.sh       | 12 ++--
>   4 files changed, 65 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 337608f408ce..c53111998432 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -292,6 +292,7 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>   			    struct cpumask *new_cpus, nodemask_t *new_mems,
>   			    bool cpus_updated, bool mems_updated);
>   int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
> +bool cpuset1_cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2);
>   #else
>   static inline void fmeter_init(struct fmeter *fmp) {}
>   static inline void cpuset1_update_task_spread_flags(struct cpuset *cs,
> @@ -302,6 +303,8 @@ static inline void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>   			    bool cpus_updated, bool mems_updated) {}
>   static inline int cpuset1_validate_change(struct cpuset *cur,
>   				struct cpuset *trial) { return 0; }
> +static inline bool cpuset1_cpus_excl_conflict(struct cpuset *cs1,
> +				struct cpuset *cs2) {return false; }
>   #endif /* CONFIG_CPUSETS_V1 */
>   
>   #endif /* __CPUSET_INTERNAL_H */
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 12e76774c75b..5aa0ac092ef6 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -373,6 +373,25 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
>   	return ret;
>   }
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
> +		return cpumask_intersects(cs1->cpus_allowed,
> +					  cs2->cpus_allowed);
> +
> +	return false;
> +}
> +
>   #ifdef CONFIG_PROC_PID_CPUSET
>   /*
>    * proc_cpuset_show()
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 52468d2c178a..e58dd26e074a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -586,14 +586,24 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>    * Returns: true if CPU exclusivity conflict exists, false otherwise
>    *
>    * Conflict detection rules:
> - * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
> + * For cgroup-v1:
> + *     see cpuset1_cpus_excl_conflict()
> + * For cgroup-v2:
> + * 1. If both cs1 and cs2 are exclusive, cs1 and cs2 must be mutually exclusive
>    * 2. exclusive_cpus masks cannot intersect between cpusets
>    * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
> + * 4. If a cpuset is exclusive and its exclusive CPUs are empty, its allowed CPUs
> + *    will be treated as exclusive CPUs; therefore, its allowed CPUs must not
> + *    intersect with another's exclusive CPUs.
>    */
>   static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>   {
> -	/* If either cpuset is exclusive, check if they are mutually exclusive */
> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
> +	/* For cgroup-v1 */
> +	if (!cpuset_v2())
> +		return cpuset1_cpus_excl_conflict(cs1, cs2);
> +
> +	/* If cpusets are exclusive, check if they are mutually exclusive*/
> +	if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
>   		return !cpusets_are_exclusive(cs1, cs2);
>   
>   	/* Exclusive_cpus cannot intersect */
> @@ -609,6 +619,20 @@ static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>   	    cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
>   		return true;
>   
> +	/*
> +	 * When a cpuset is exclusive and its exclusive CPUs are empty,
> +	 * its cpus_allowed cannot intersect with another cpuset's exclusive_cpus.
> +	 */
> +	if (is_cpu_exclusive(cs1) &&
> +	    cpumask_empty(cs1->exclusive_cpus) &&
> +	    cpumask_intersects(cs1->cpus_allowed, cs2->exclusive_cpus))
> +		return true;
> +
> +	if (is_cpu_exclusive(cs2) &&
> +	    cpumask_empty(cs2->exclusive_cpus) &&
> +	    cpumask_intersects(cs2->cpus_allowed, cs1->exclusive_cpus))
> +		return true;
> +
>   	return false;
>   }
>   
> @@ -2411,34 +2435,17 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialc
>   					struct tmpmasks *tmp)
>   {
>   	int retval;
> -	struct cpuset *parent = parent_cs(cs);
>   
>   	retval = validate_change(cs, trialcs);
>   
>   	if ((retval == -EINVAL) && cpuset_v2()) {
> -		struct cgroup_subsys_state *css;
> -		struct cpuset *cp;
> -
>   		/*
>   		 * The -EINVAL error code indicates that partition sibling
>   		 * CPU exclusivity rule has been violated. We still allow
>   		 * the cpumask change to proceed while invalidating the
> -		 * partition. However, any conflicting sibling partitions
> -		 * have to be marked as invalid too.
> +		 * partition.
>   		 */
>   		trialcs->prs_err = PERR_NOTEXCL;
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
>   		retval = 0;
>   	}
>   	return retval;
> @@ -2506,8 +2513,15 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (alloc_tmpmasks(&tmp))
>   		return -ENOMEM;
>   
> -	compute_trialcs_excpus(trialcs, cs);
> -	trialcs->prs_err = PERR_NONE;
> +	/*
> +	 * if there is exclusive CPUs conflict with the siblings,
> +	 * we still allow the cpumask change to proceed while
> +	 * invalidating the partition.
> +	 */
> +	if (compute_trialcs_excpus(trialcs, cs))
> +		trialcs->prs_err = PERR_NOTEXCL;
> +	else
> +		trialcs->prs_err = PERR_NONE;
>   
>   	retval = cpus_allowed_validate_change(cs, trialcs, &tmp);
>   	if (retval < 0)
> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> index a17256d9f88a..75154e22c702 100755
> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> @@ -269,7 +269,7 @@ TEST_MATRIX=(
>   	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X3:P2    .      .     0 A1:0-2|A2:3|A3:3 A1:P0|A2:P2 3"
>   	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3  X2-3:P2   .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
>   	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:C3 .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
> -	" C0-3:S+ C1-3:S+ C2-3   C2-3     .      .      .      P2    0 A1:0-3|A2:1-3|A3:2-3|B1:2-3 A1:P0|A3:P0|B1:P-2"
> +	" C0-3:S+ C1-3:S+ C2-3   C2-3     .      .      .      P2    0 A1:0-1|A2:1|A3:1|B1:2-3 A1:P0|A3:P0|B1:P2"
>   	" C0-3:S+ C1-3:S+ C2-3   C4-5     .      .      .      P2    0 B1:4-5 B1:P2 4-5"
>   	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3  X2-3:P2   P2    0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
>   	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3 X2-3:P2:C1-3 P2  0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
> @@ -318,7 +318,7 @@ TEST_MATRIX=(
>   	# Invalid to valid local partition direct transition tests
>   	" C1-3:S+:P2 X4:P2  .      .      .      .      .      .     0 A1:1-3|XA1:1-3|A2:1-3:XA2: A1:P2|A2:P-2 1-3"
>   	" C1-3:S+:P2 X4:P2  .      .      .    X3:P2    .      .     0 A1:1-2|XA1:1-3|A2:3:XA2:3 A1:P2|A2:P2 1-3"
> -	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:4-6 A1:P-2|B1:P0"
> +	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:5-6 A1:P2|B1:P0"
>   	"  C0-3:P2   .      .    C4-6 C0-4:C0-3  .      .      .     0 A1:0-3|B1:4-6 A1:P2|B1:P0 0-3"
>   
>   	# Local partition invalidation tests
> @@ -388,10 +388,10 @@ TEST_MATRIX=(
>   	"  C0-1:S+  C1      .    C2-3     .      P2     .      .     0 A1:0-1|A2:1 A1:P0|A2:P-2"
>   	"  C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0|A2:1 A1:P1|A2:P2 0-1|1"
>   
> -	# A non-exclusive cpuset.cpus change will invalidate partition and its siblings
> -	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P0"
> -	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P-1"
> -	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P0|B1:P-1"
> +	# A non-exclusive cpuset.cpus change will not invalidate its siblings partition.
> +	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:3 A1:P1|B1:P0"
> +	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-1|B1:2-3 A1:P-1|B1:P1"
> +	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-1|B1:2-3 A1:P0|B1:P1"
>   
>   	# cpuset.cpus can overlap with sibling cpuset.cpus.exclusive but not subsumed by it
>   	"   C0-3     .      .    C4-5     X5     .      .      .     0 A1:0-3|B1:4-5"


