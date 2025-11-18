Return-Path: <linux-kselftest+bounces-45915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9E2C6B7E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 20:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66AFA4E2C00
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 19:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EF92DC79F;
	Tue, 18 Nov 2025 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwZQhGjs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFj1DMfM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422323507C
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763495615; cv=none; b=mRDFoAZ7UgDd8AyqIKML24/fJC/C+QwmKXCVJczES2ufcjdAuKOqCw16YTBwAgZIl8az0c6EzElJ5tfHEBhuwG/SnrkgvPqmq38LPHPX1RAfuTOXUd7RLRh+0KFudehZmUnQQXNMuqh63iYyZrypfSXR+6ybBW9HOjURJLuKWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763495615; c=relaxed/simple;
	bh=qXFgI3qKojE1YW3SDNEREX2qLcUPd1lD0cibq1uveCQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SNNeZCJjJPvKMH2v+nt3TMkcDyy+SwMEa0mH+P52Jo+RlK2UnvY5l+gadVntufHM18ZKXzlhsaeHR8T/OOhtVM2fyKG/8N2H1y61VH8K3GP/XRF8iUzoWblmzLpRwpC+BgcauzoqKH9rJ8iqKZ54QlGp1z+MVpUiKfvtL2+y7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UwZQhGjs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFj1DMfM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763495612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtisD4HnKFV6BLauDswvQVW8uS6raEN7PaYY44AASso=;
	b=UwZQhGjsVg7qa7UT4tLgSoLK6R6n1xU3U+SZ7upBJi58lqUC+lrBjXW4J5ret/oDFnT5sT
	zW/xoBSZbr7ZZQ6AKO6Wm90y8r7quDeswwBGbbYyCxMtpBhwAuYEQk1WqIdkRYHCA8DYJD
	yd/HNfeOQeTXYFSgnyuS+3iGneerDAc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-ebzlQIeaNN-x3eLJDCW8jw-1; Tue, 18 Nov 2025 14:53:31 -0500
X-MC-Unique: ebzlQIeaNN-x3eLJDCW8jw-1
X-Mimecast-MFC-AGG-ID: ebzlQIeaNN-x3eLJDCW8jw_1763495610
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b234bae2a7so1758162685a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 11:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763495610; x=1764100410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WtisD4HnKFV6BLauDswvQVW8uS6raEN7PaYY44AASso=;
        b=IFj1DMfMAHo0Sjsv206l1mQmtgBqVjCnUO0RDxlTaNKLLxA6u4GfvExsgTActk6Deh
         4V7wbMgcpOIKAhzUqKfDEnTeVwmsc0vqJuwmQCxMDiT04d9qT/xytP3AipY/Yfoz7oHP
         NYSYydFOZ9X9+5y+/3NmtCknityAddfo1W1awJ6rd7CyTpaSQH4blt9C2ac5qT+XFqlq
         BMZ5y8E+ygLQefqmnTl1ROm4J5Qa6L2Ar+R0TLdhTLa08Vrbm2xORlaO8ywkEXZr6VE/
         8J8gnNO2QVBaeaC4G/n89QZHDcZK3NNxELpNJKh+TpzBSmRYcrWKr3FPQY+jg57W2Aw3
         /VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763495610; x=1764100410;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtisD4HnKFV6BLauDswvQVW8uS6raEN7PaYY44AASso=;
        b=j3UAxpOWudzPQCYoNVuWj430C2rAsGOY+VQ4SRHVrCshwaKQOq1llsvWBmY4d4tCed
         07KE+XGyQmM27W1iN62l4dXW8Afr9dBy1LZQkgpVmN1TLqgCOZVEzret23mOfPwgkj6/
         u5m1Jx8HWEt6WauJVzem49uUGUZZDW5S0zSkYp8R0H8rtuG9zBIGAFyrxlp/FwsoZdr/
         8seZ+LPyIbN5ezaKqsudAoljV+lBALO2Y+eMfcWAj5X7gajANHmSw36nTcPMteuUX+sr
         Xo9y6vOHILcDXYU/nBQ8h3G0pmOfTWzevQ2OODIesWlqnEI3AyltpurimEFFiq10NXEg
         Liyw==
X-Forwarded-Encrypted: i=1; AJvYcCVeBET/XsCvsaBOMSUPYJ+/B8TYwRBvJ7SjT2w1kUGYbrxin2mmPfnYSWFnGzfxqOt36wl5gjzlMqVw/De4GFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwztnwacL/oChMjZG7uLFiWU1DnsYPKRR2OPBZR8rYoVD4ijJ3W
	nK7PFakjb5r1MrLdkZQrgHpaMBdz8mXBFCHepEjrrlKcuGYh9xLvUQYiaKsD6+tfAD1nkvNeeJt
	RgODCJhGa66UHNedAUB99m95TW6ZZWi6S3DaFOAk5Q8n7A1lVqJuVuCXZWVeqB2ttfjtz8eWYsT
	NMoQ==
X-Gm-Gg: ASbGncvrULggcTXpLi6kKXZJmKV9AzdrGML4Gz69giIuQPWqMaahYRHOchgz4G6PNmm
	DLw6PmQLFF33nvBVW6SqlJkNJiv6oZEtsB7InGBv2r9y9ujOLvfvze5BQBMiN6JG7npckwWaicj
	rQWL2CvB80VPEywR4/2GE3s5masSlYHb6iKY0jDDykS3AYm6ZeB7ZSvSAYLTjqVCpvcKmWOns6N
	7RFwFvnwb1elU1nnxWTMQ3lpzP+v6B33lhdIDG20LNuamyZGB8ShBlouFVy/IdYfHmD4m5ZVWEr
	T6sQ/NyLERM+OauTZu/ClH+z2onu3IzMTcBiV8AYGylDl2XPFfCC3N7YE4v8wqH37jo37ucZ9Ng
	1siAHKE/mzgaK3oNVdOVM61CzoLDl6wyjSRlgJriXjeTdnfISt1QezOkB
X-Received: by 2002:a05:620a:4052:b0:7fd:50bd:193b with SMTP id af79cd13be357-8b316f00ec4mr45644685a.14.1763495609822;
        Tue, 18 Nov 2025 11:53:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxz2UI33696KG6+FTP1B1jFldUykRHwqvk+bH1o+FYx+sXz2DhZLgjahMUGZEU4DuUWPhLFg==
X-Received: by 2002:a05:620a:4052:b0:7fd:50bd:193b with SMTP id af79cd13be357-8b316f00ec4mr45641085a.14.1763495609246;
        Tue, 18 Nov 2025 11:53:29 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aeeb4afbsm1242544185a.14.2025.11.18.11.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 11:53:28 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <942d2b65-3c28-4f6d-aa6b-8365fa5cea2c@redhat.com>
Date: Tue, 18 Nov 2025 14:53:27 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] cpuset: relax the overlap check for cgroup-v2
To: Sun Shaojie <sunshaojie@kylinos.cn>, llong@redhat.com
Cc: chenridong@huaweicloud.com, mkoutny@suse.com, cgroups@vger.kernel.org,
 hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, tj@kernel.org
References: <20251117015708.977585-1-sunshaojie@kylinos.cn>
 <20251117015708.977585-2-sunshaojie@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20251117015708.977585-2-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/16/25 8:57 PM, Sun Shaojie wrote:
> In cgroup v2, a mutual overlap check is required when at least one of two
> cpusets is exclusive. However, this check should be relaxed and limited to
> cases where both cpusets are exclusive.
>
> This patch ensures that for sibling cpusets A1 (exclusive) and B1
> (non-exclusive), change B1 cannot affect A1's exclusivity.
>
> for example. Assume a machine has 4 CPUs (0-3).
>
>     root cgroup
>        /    \
>      A1      B1
>
> Case 1:
>   Table 1.1: Before applying the patch
>   Step                                       | A1's prstate | B1'sprstate |
>   #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
>   #2> echo "root" > A1/cpuset.cpus.partition | root         | member      |
>   #3> echo "0" > B1/cpuset.cpus              | root invalid | member      |
>
> After step #3, A1 changes from "root" to "root invalid" because its CPUs
> (0-1) overlap with those requested by B1 (0-3). However, B1 can actually
> use CPUs 2-3(from B1's parent), so it would be more reasonable for A1 to
> remain as "root."
>
>   Table 1.2: After applying the patch
>   Step                                       | A1's prstate | B1'sprstate |
>   #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
>   #2> echo "root" > A1/cpuset.cpus.partition | root         | member      |
>   #3> echo "0" > B1/cpuset.cpus              | root         | member      |
>
> All other cases remain unaffected. For example, cgroup-v1, both A1 and B1
> are exclusive or non-exlusive.
>
> Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
> ---
>   kernel/cgroup/cpuset-internal.h               |  3 ++
>   kernel/cgroup/cpuset-v1.c                     | 20 +++++++++
>   kernel/cgroup/cpuset.c                        | 43 ++++++++++++++-----
>   .../selftests/cgroup/test_cpuset_prs.sh       |  5 ++-
>   4 files changed, 58 insertions(+), 13 deletions(-)
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
> index 12e76774c75b..5c1296bf6a34 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -373,6 +373,26 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
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
> +		if (cpumask_intersects(cs1->cpus_allowed,
> +				       cs2->cpus_allowed))
> +			return true;
> +
> +	return false;
> +}
> +
>   #ifdef CONFIG_PROC_PID_CPUSET
>   /*
>    * proc_cpuset_show()
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 52468d2c178a..0fd803612513 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -580,35 +580,56 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>   
>   /**
>    * cpus_excl_conflict - Check if two cpusets have exclusive CPU conflicts
> - * @cs1: first cpuset to check
> - * @cs2: second cpuset to check
> + * @cs1: current cpuset to check
> + * @cs2: cpuset involved in the check
>    *
>    * Returns: true if CPU exclusivity conflict exists, false otherwise
>    *
>    * Conflict detection rules:
> - * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
> + * For cgroup-v1:
> + *     see cpuset1_cpus_excl_conflict()
> + * For cgroup-v2:
> + * 1. If cs1 is exclusive, cs1 and cs2 must be mutually exclusive
>    * 2. exclusive_cpus masks cannot intersect between cpusets
> - * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
> + * 3. If cs2 is exclusive, cs2's allowed CPUs cannot be a subset of cs1's exclusive CPUs
> + * 4. if cs1 and cs2 are not exclusive, the allowed CPUs of one cpuset cannot be a subset
> + *    of another's exclusive CPUs
>    */
>   static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)

As cs1 and cs2 is going to be handled differently, their current naming 
will make it hard to understand why they are treated differently. I will 
recommended changing the parameter name to "trial, sibling" as the 
caller call it with "cpus_excl_conflict(trial, c)" where trial is the 
new cpuset data to be tested and sibling is one of its sibling cpusets. 
It has to be clearly document what each parameter is for and the fact 
that swapping the parameters will cause it to return incorrect result.


>   {
> -	/* If either cpuset is exclusive, check if they are mutually exclusive */
> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
> +	/* For cgroup-v1 */
> +	if (!cpuset_v2())
> +		return cpuset1_cpus_excl_conflict(cs1, cs2);
> +
> +	/* If cs1 are exclusive, check if they are mutually exclusive */
> +	if (is_cpu_exclusive(cs1))
>   		return !cpusets_are_exclusive(cs1, cs2);

Code change like the following can eliminate the need to introduce a new 
cpuset1_cpus_excl_conflict() helper.

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ec8bebc66469..201c70fb7401 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -599,9 +599,15 @@ static inline bool cpusets_are_exclusive(struct 
cpuset *cs1, struct cpuset *cs2)
   */
  static inline bool cpus_excl_conflict(struct cpuset *cs1, struct 
cpuset *cs2)
  {
-       /* If either cpuset is exclusive, check if they are mutually 
exclusive */
-       if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
-               return !cpusets_are_exclusive(cs1, cs2);
+       /*
+        * If trial is exclusive or sibling is exclusive & in v1,
+        * check if they are mutually exclusive
+        */
+       if (is_cpu_exclusive(trial) || (!cpuset_v2() && 
is_cpu_exclusive(sibling)))
+               return !cpusets_are_exclusive(trial, sibling);
+
+       if (!cpuset_v2())
+               return false;   /* The checking below is irrelevant to 
cpuset v1 */

         /* Exclusive_cpus cannot intersect */
         if (cpumask_intersects(cs1->exclusive_cpus, cs2->exclusive_cpus))

>   
> +	/* The following check applies when either
> +	 * both cs1 and cs2 are non-exclusive，or
> +	 * only cs2 is exclusive.
> +	 */
> +
>   	/* Exclusive_cpus cannot intersect */
>   	if (cpumask_intersects(cs1->exclusive_cpus, cs2->exclusive_cpus))
>   		return true;
>   
> -	/* The cpus_allowed of one cpuset cannot be a subset of another cpuset's exclusive_cpus */
> -	if (!cpumask_empty(cs1->cpus_allowed) &&
> -	    cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
> -		return true;
> -
> +	/* cs2's allowed CPUs cannot be a subset of cs1's exclusive CPUs */
>   	if (!cpumask_empty(cs2->cpus_allowed) &&
>   	    cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
>   		return true;
>   
> +	/* If cs2 is exclusive, check finished here */
> +	if (is_cpu_exclusive(cs2))
> +		return false;
> +
> +	/* The following check applies only if both cs1 and cs2 are non-exclusive. */
> +
> +	/* cs1's allowed CPUs cannot be a subset of cs1's exclusive CPUs */
"sibling's exclusive CPUs"
> +	if (!cpumask_empty(cs1->cpus_allowed) &&
> +	    cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
> +		return true;
> +

As said before, we can't fail change to cpuset.cpus by default, but we 
can fail change to cpuset.cpus.exclusive. So this additional check isn't 
OK unless this check is under a special mode that is opted in via other 
means like an additional cgroup control file or a boot command line 
option and so on.

Cheers,
Longman


