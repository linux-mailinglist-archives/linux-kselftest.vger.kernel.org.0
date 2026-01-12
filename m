Return-Path: <linux-kselftest+bounces-48703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33913D10800
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 04:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E98D43037504
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 03:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E9C30BBA0;
	Mon, 12 Jan 2026 03:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7Wr5gqB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nz1qks/Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8299B303C93
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 03:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768189417; cv=none; b=A/IsOeQF5cikgbcUOfIqYw0/j4r1tKu4RoTVTUMckZ5npFLKOa3NOVw2AH5h8vbmubI/rHAwLr4ZQiE1CmaKT+1ycSr8sxMSvjZtIYOF600wR/HDlXGHBkPjNH50KDFhV3jzlXbbyT/p1PrxHVRCutsRUFZ4d7d6gJdkEdLU4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768189417; c=relaxed/simple;
	bh=xf98c6ZsMa10g3XfU4rtK4D/VaHEtfSRDXonB7TTfHk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lIvrq3xQO31PQZsP0vgA5Q7YTNm92eYJSw6E7xY53uT6hMwCLX6E9avxtQ6sRKfdfxrZF4OZ9bk5shLVYYyXDtlqQajo99twptTlyfprVXR3RqtZZmLcRFOeueKEv1049QdYvH1QWsj3LQV84YIxOJpShO7oda4lWT/8GebtoFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K7Wr5gqB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nz1qks/Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768189413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ImkjVut6R3yQGKjNwZN9Ru5xM0v0pBO1Ci5ZPE/eExM=;
	b=K7Wr5gqB4Yv/PhcBEUvfbZ4cN1LwTV61oxIfzCw8jYjSunrHWDknX9m/f5Zkampi2ydeQZ
	SrQttnecFIaZMdee5Pfttal2waSv+R/Veg+Nvjeoln2FyMyfdPxgsH9orX3+YekaEF1a/S
	flZIp9OI/fDjDeSo7KHRYOSvy8BEn/U=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-XAt0H9XXPPWJxkIfZphzQg-1; Sun, 11 Jan 2026 22:43:32 -0500
X-MC-Unique: XAt0H9XXPPWJxkIfZphzQg-1
X-Mimecast-MFC-AGG-ID: XAt0H9XXPPWJxkIfZphzQg_1768189412
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-93f62c9ab4aso8276115241.2
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 19:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768189412; x=1768794212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ImkjVut6R3yQGKjNwZN9Ru5xM0v0pBO1Ci5ZPE/eExM=;
        b=Nz1qks/YgBi/5fxDfVhPq4tbMx2sCr+j2hVcda/3OYkDeNZ+OOVIC6cuSNA93MHV7c
         HwJi8ZKrnytVN5etnJ99wtq34dQ0GHj4u3O9ViQEn0XQg+waApVrrSqWxC3QLBdrjNEW
         Fv/dD16cMEQQEmCEHx4Oo4bhFLP6SXkmUPniPG3B+2jUfVgDm/F8WGE8JLCwiX/FwFFJ
         OovEO6KHuHpui86fX25Bms5G2WOkwrWr1gFb37yLcQsQGoWhKdqeaM5wdLyJkGNDSwmh
         yC9JcVoPzddK+Xs/5dvtcaI9Hk7+niLndV6osf5TWIDC/HRGZqKe25MfHn4pIRcUWN7+
         DfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768189412; x=1768794212;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImkjVut6R3yQGKjNwZN9Ru5xM0v0pBO1Ci5ZPE/eExM=;
        b=bg1twdrvQkiR7lROexRPbsXEzrgZVYpqdzz2fZUV92kl2a4Djqb+V0gSN8B6F2pSpV
         SZ7wg2zQyZJEvXKVb5Bkd+JgbopIIGc+HLmQP5f2xRSfY5FRYnKBBx298eoLbQoftTK4
         tODAhA521i6F0V4gYJMDjhaaWY8K91TvEI8yFHcdDHhvRjWlkaPO5TrThLG0Dp1ciVdx
         ebTwmbEhQ+7Px4t+cRG/5IxPUp6+0McCsCpsyRKc5AmFGUuEHtPMqInJG0B59ym3ebpx
         g3aYAs+KaeaGP5qwkOO4DS2vJxo02kFiIe0TaENyDy9yDmdywBouErHMSsvDiqw/KrZq
         FCfg==
X-Forwarded-Encrypted: i=1; AJvYcCUvmYOpFnp9WPJvrX8ETfuVKtCDP2vBw4mRJAe3/juBiDTo46JzxufSrGEnKhI9s1emVuaDtJB3i0gMVJPe2do=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJfF3xJYuxFPQi2yeKJXIuDih7asxi/GbpqpTa961CWmjoWlve
	L1xsUv5K/A45kLDHk6pcu1cVgP01yG/CtxHijYJ0cZpOeRecSFPMeVtESiVrfVvX/D16XxbNczu
	pTxxY2ALxbupLhb3Xkndl3gpSkGwqrSbBabyIuOMxv6Ui7y/4o83lJF7g3IVudTiH2jDVLw==
X-Gm-Gg: AY/fxX5gzqCzxYdPfltQMioBTZvc5rWSLxGzJJDA2ZFZbOidKWgbMR1nwZVthWAgHI3
	C6ex4iFiIScKrzxQDaw1sYVOJ/zhetZl2HxyuaoNMhIx9khyXR0rmGhUVS16KoVGW0Rv8GLOupm
	WwwS1BVt0oIUhNXOeBT97Pj/xdKSD4lEVEpEXTgUV/S2lFUUOK8BmI+LUx1EaoBUeopjfBkNimN
	KAy9SJ/vSR7VhOjiCtRC7+KyX0Xw1jxrJLTg63CjxWdcSZFoMnomJeY47SZvVruLpudUtyV0hZ5
	fhZxWRaXRWUMuFpHd70KSdDTxMX+MiMriaHOKOcp/+E3HR/RgBvb+GSkBlKeXXH0IKTOEHonY3J
	ollOwoHRkB4bJF2f29WJ+s3n6dDElD15tDjc7KzF77Kt2fbuZaoXjMHvU
X-Received: by 2002:a05:6102:3e86:b0:5db:eeb6:812c with SMTP id ada2fe7eead31-5ecbb161af3mr5324120137.43.1768189411394;
        Sun, 11 Jan 2026 19:43:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP1gx8OZVfINReOh+fC2U8xAf4OHoN4pctQYDB3Nh86fpqOEuGH22riCmtFVYlRCeUA8H2Mg==
X-Received: by 2002:a05:6102:3e86:b0:5db:eeb6:812c with SMTP id ada2fe7eead31-5ecbb161af3mr5324110137.43.1768189410776;
        Sun, 11 Jan 2026 19:43:30 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124e906esm15086756241.14.2026.01.11.19.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 19:43:30 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <38f3eff8-a1ef-40aa-b548-c3834a68946a@redhat.com>
Date: Sun, 11 Jan 2026 22:43:23 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-6.20 v3 4/5] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260110013246.293889-1-longman@redhat.com>
 <20260110013246.293889-5-longman@redhat.com>
 <783b4780-72d5-43cf-9193-d26efb61ce0c@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <783b4780-72d5-43cf-9193-d26efb61ce0c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/11/26 9:10 PM, Chen Ridong wrote:
>
> On 2026/1/10 9:32, Waiman Long wrote:
>> Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
>> with the cpuset.cpus/cpuset.cpus.exclusive of a sibling partition,
>> the sibling's partition state becomes invalid. This is overly harsh and
>> is probably not necessary.
>>
>> The cpuset.cpus.exclusive control file, if set, will override the
>> cpuset.cpus of the same cpuset when creating a cpuset partition.
>> So cpuset.cpus has less priority than cpuset.cpus.exclusive in setting up
>> a partition.  However, it cannot override a conflicting cpuset.cpus file
>> in a sibling cpuset and the partition creation process will fail. This
>> is inconsistent.  That will also make using cpuset.cpus.exclusive less
>> valuable as a tool to set up cpuset partitions as the users have to
>> check if such a cpuset.cpus conflict exists or not.
>>
>> Fix these problems by making sure that once a cpuset.cpus.exclusive
>> is set without failure, it will always be allowed to form a valid
>> partition as long as at least one CPU can be granted from its parent
>> irrespective of the state of the siblings' cpuset.cpus values. Of
>> course, setting cpuset.cpus.exclusive will fail if it conflicts with
>> the cpuset.cpus.exclusive or the cpuset.cpus.exclusive.effective value
>> of a sibling.
>>
>> Partition can still be created by setting only cpuset.cpus without
>> setting cpuset.cpus.exclusive. However, any conflicting CPUs in sibling's
>> cpuset.cpus.exclusive.effective and cpuset.cpus.exclusive values will
>> be removed from its cpuset.cpus.exclusive.effective as long as there
>> is still one or more CPUs left and can be granted from its parent. This
>> CPU stripping is currently done in rm_siblings_excl_cpus().
>>
>> The new code will now try its best to enable the creation of new
>> partitions with only cpuset.cpus set without invalidating existing ones.
>> However it is not guaranteed that all the CPUs requested in cpuset.cpus
>> will be used in the new partition even when all these CPUs can be
>> granted from the parent.
>>
>> This is similar to the fact that cpuset.cpus.effective may not be
>> able to include all the CPUs requested in cpuset.cpus. In this case,
>> the parent may not able to grant all the exclusive CPUs requested in
>> cpuset.cpus to cpuset.cpus.exclusive.effective if some of them have
>> already been granted to other partitions earlier.
>>
>> With the creation of multiple sibling partitions by setting
>> only cpuset.cpus, this does have the side effect that their exact
>> cpuset.cpus.exclusive.effective settings will depend on the order of
>> partition creation if there are conflicts. Due to the exclusive nature
>> of the CPUs in a partition, it is not easy to make it fair other than
>> the old behavior of invalidating all the conflicting partitions.
>>
>> For example,
>>    # echo "0-2" > A1/cpuset.cpus
>>    # echo "root" > A1/cpuset.cpus.partition
>>    # echo A1/cpuset.cpus.partition
>>    root
>>    # echo A1/cpuset.cpus.exclusive.effective
>>    0-2
>>    # echo "2-4" > B1/cpuset.cpus
>>    # echo "root" > B1/cpuset.cpus.partition
>>    # echo B1/cpuset.cpus.partition
>>    root
>>    # echo B1/cpuset.cpus.exclusive.effective
>>    3-4
>>    # echo B1/cpuset.cpus.effective
>>    3-4
>>
> Shouldn't the interface use cat rather than echo for reading?
>
> Other than that, it looks good to me.

You are right. It is an cut & paste error.

Will fix that.

Cheers,
Longman

> Reviewed-by: Chen Ridong <chenridong@huawei.com>
>
>> For users who want to be sure that they can get most of the CPUs they
>> want, cpuset.cpus.exclusive should be used instead if they can set
>> it successfully without failure. Setting cpuset.cpus.exclusive will
>> guarantee that sibling conflicts from then onward is no longer possible.
>>
>> To make this change, we have to separate out the is_cpu_exclusive()
>> check in cpus_excl_conflict() into a cgroup v1 only
>> cpuset1_cpus_excl_conflict() helper. The cpus_allowed_validate_change()
>> helper is now no longer needed and can be removed.
>>
>> Some existing tests in test_cpuset_prs.sh are updated and new ones are
>> added to reflect the new behavior. The cgroup-v2.rst doc file is also
>> updated the clarify what exclusive CPUs will be used when a partition
>> is created.
>>
>> Reported-by: Sun Shaojie <sunshaojie@kylinos.cn>
>> Closes: https://lore.kernel.org/lkml/20251117015708.977585-1-sunshaojie@kylinos.cn/
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst       | 32 +++++---
>>   kernel/cgroup/cpuset-internal.h               |  3 +
>>   kernel/cgroup/cpuset-v1.c                     | 19 +++++
>>   kernel/cgroup/cpuset.c                        | 80 ++++++-------------
>>   .../selftests/cgroup/test_cpuset_prs.sh       | 26 ++++--
>>   5 files changed, 89 insertions(+), 71 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 510df2461aff..a3446db96cea 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -2584,9 +2584,9 @@ Cpuset Interface Files
>>   	of this file will always be a subset of its parent's
>>   	"cpuset.cpus.exclusive.effective" if its parent is not the root
>>   	cgroup.  It will also be a subset of "cpuset.cpus.exclusive"
>> -	if it is set.  If "cpuset.cpus.exclusive" is not set, it is
>> -	treated to have an implicit value of "cpuset.cpus" in the
>> -	formation of local partition.
>> +	if it is set.  This file should only be non-empty if either
>> +	"cpuset.cpus.exclusive" is set or when the current cpuset is
>> +	a valid partition root.
>>   
>>     cpuset.cpus.isolated
>>   	A read-only and root cgroup only multiple values file.
>> @@ -2618,13 +2618,22 @@ Cpuset Interface Files
>>   	There are two types of partitions - local and remote.  A local
>>   	partition is one whose parent cgroup is also a valid partition
>>   	root.  A remote partition is one whose parent cgroup is not a
>> -	valid partition root itself.  Writing to "cpuset.cpus.exclusive"
>> -	is optional for the creation of a local partition as its
>> -	"cpuset.cpus.exclusive" file will assume an implicit value that
>> -	is the same as "cpuset.cpus" if it is not set.	Writing the
>> -	proper "cpuset.cpus.exclusive" values down the cgroup hierarchy
>> -	before the target partition root is mandatory for the creation
>> -	of a remote partition.
>> +	valid partition root itself.
>> +
>> +	Writing to "cpuset.cpus.exclusive" is optional for the creation
>> +	of a local partition as its "cpuset.cpus.exclusive" file will
>> +	assume an implicit value that is the same as "cpuset.cpus" if it
>> +	is not set.  Writing the proper "cpuset.cpus.exclusive" values
>> +	down the cgroup hierarchy before the target partition root is
>> +	mandatory for the creation of a remote partition.
>> +
>> +	Not all the CPUs requested in "cpuset.cpus.exclusive" can be
>> +	used to form a new partition.  Only those that were present
>> +	in its parent's "cpuset.cpus.exclusive.effective" control
>> +	file can be used.  For partitions created without setting
>> +	"cpuset.cpus.exclusive", exclusive CPUs specified in sibling's
>> +	"cpuset.cpus.exclusive" or "cpuset.cpus.exclusive.effective"
>> +	also cannot be used.
>>   
>>   	Currently, a remote partition cannot be created under a local
>>   	partition.  All the ancestors of a remote partition root except
>> @@ -2632,6 +2641,9 @@ Cpuset Interface Files
>>   
>>   	The root cgroup is always a partition root and its state cannot
>>   	be changed.  All other non-root cgroups start out as "member".
>> +	Even though the "cpuset.cpus.exclusive*" control files are not
>> +	present in the root cgroup, they are implicitly the same as
>> +	"cpuset.cpus".
>>   
>>   	When set to "root", the current cgroup is the root of a new
>>   	partition or scheduling domain.  The set of exclusive CPUs is
>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>> index e718a4f54360..e8e2683cb067 100644
>> --- a/kernel/cgroup/cpuset-internal.h
>> +++ b/kernel/cgroup/cpuset-internal.h
>> @@ -312,6 +312,7 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>>   			    struct cpumask *new_cpus, nodemask_t *new_mems,
>>   			    bool cpus_updated, bool mems_updated);
>>   int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
>> +bool cpuset1_cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2);
>>   void cpuset1_init(struct cpuset *cs);
>>   void cpuset1_online_css(struct cgroup_subsys_state *css);
>>   int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>> @@ -326,6 +327,8 @@ static inline void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>>   			    bool cpus_updated, bool mems_updated) {}
>>   static inline int cpuset1_validate_change(struct cpuset *cur,
>>   				struct cpuset *trial) { return 0; }
>> +static inline bool cpuset1_cpus_excl_conflict(struct cpuset *cs1,
>> +					struct cpuset *cs2) { return false; }
>>   static inline void cpuset1_init(struct cpuset *cs) {}
>>   static inline void cpuset1_online_css(struct cgroup_subsys_state *css) {}
>>   static inline int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
>> index ecfea7800f0d..04124c38a774 100644
>> --- a/kernel/cgroup/cpuset-v1.c
>> +++ b/kernel/cgroup/cpuset-v1.c
>> @@ -373,6 +373,25 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
>>   	return ret;
>>   }
>>   
>> +/*
>> + * cpuset1_cpus_excl_conflict() - Check if two cpusets have exclusive CPU conflicts
>> + *                                to legacy (v1)
>> + * @cs1: first cpuset to check
>> + * @cs2: second cpuset to check
>> + *
>> + * Returns: true if CPU exclusivity conflict exists, false otherwise
>> + *
>> + * If either cpuset is CPU exclusive, their allowed CPUs cannot intersect.
>> + */
>> +bool cpuset1_cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>> +{
>> +	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>> +		return cpumask_intersects(cs1->cpus_allowed,
>> +					  cs2->cpus_allowed);
>> +
>> +	return false;
>> +}
>> +
>>   #ifdef CONFIG_PROC_PID_CPUSET
>>   /*
>>    * proc_cpuset_show()
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 4819ab429771..83fb83a86b4b 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -129,6 +129,17 @@ static bool force_sd_rebuild;
>>    *  For simplicity, a local partition can be created under a local or remote
>>    *  partition but a remote partition cannot have any partition root in its
>>    *  ancestor chain except the cgroup root.
>> + *
>> + *  A valid partition can be formed by setting exclusive_cpus or cpus_allowed
>> + *  if exclusive_cpus is not set. In the case of partition with empty
>> + *  exclusive_cpus, all the conflicting exclusive CPUs specified in the
>> + *  following cpumasks of sibling cpusets will be removed from its
>> + *  cpus_allowed in determining its effective_xcpus.
>> + *  - effective_xcpus
>> + *  - exclusive_cpus
>> + *
>> + *  The "cpuset.cpus.exclusive" control file should be used for setting up
>> + *  partition if the users want to get as many CPUs as possible.
>>    */
>>   #define PRS_MEMBER		0
>>   #define PRS_ROOT		1
>> @@ -616,27 +627,25 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>>    * Returns: true if CPU exclusivity conflict exists, false otherwise
>>    *
>>    * Conflict detection rules:
>> - * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
>> - * 2. exclusive_cpus masks cannot intersect between cpusets
>> - * 3. The allowed CPUs of a sibling cpuset cannot be a subset of the new exclusive CPUs
>> + *  o cgroup v1
>> + *    See cpuset1_cpus_excl_conflict()
>> + *  o cgroup v2
>> + *    - The exclusive_cpus values cannot overlap.
>> + *    - New exclusive_cpus cannot be a superset of a sibling's cpus_allowed.
>>    */
>>   static inline bool cpus_excl_conflict(struct cpuset *trial, struct cpuset *sibling,
>>   				      bool xcpus_changed)
>>   {
>> -	/* If either cpuset is exclusive, check if they are mutually exclusive */
>> -	if (is_cpu_exclusive(trial) || is_cpu_exclusive(sibling))
>> -		return !cpusets_are_exclusive(trial, sibling);
>> -
>> -	/* Exclusive_cpus cannot intersect */
>> -	if (cpumask_intersects(trial->exclusive_cpus, sibling->exclusive_cpus))
>> -		return true;
>> +	if (!cpuset_v2())
>> +		return cpuset1_cpus_excl_conflict(trial, sibling);
>>   
>>   	/* The cpus_allowed of a sibling cpuset cannot be a subset of the new exclusive_cpus */
>>   	if (xcpus_changed && !cpumask_empty(sibling->cpus_allowed) &&
>>   	    cpumask_subset(sibling->cpus_allowed, trial->exclusive_cpus))
>>   		return true;
>>   
>> -	return false;
>> +	/* Exclusive_cpus cannot intersect */
>> +	return cpumask_intersects(trial->exclusive_cpus, sibling->exclusive_cpus);
>>   }
>>   
>>   static inline bool mems_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>> @@ -2312,43 +2321,6 @@ static enum prs_errcode validate_partition(struct cpuset *cs, struct cpuset *tri
>>   	return PERR_NONE;
>>   }
>>   
>> -static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialcs,
>> -					struct tmpmasks *tmp)
>> -{
>> -	int retval;
>> -	struct cpuset *parent = parent_cs(cs);
>> -
>> -	retval = validate_change(cs, trialcs);
>> -
>> -	if ((retval == -EINVAL) && cpuset_v2()) {
>> -		struct cgroup_subsys_state *css;
>> -		struct cpuset *cp;
>> -
>> -		/*
>> -		 * The -EINVAL error code indicates that partition sibling
>> -		 * CPU exclusivity rule has been violated. We still allow
>> -		 * the cpumask change to proceed while invalidating the
>> -		 * partition. However, any conflicting sibling partitions
>> -		 * have to be marked as invalid too.
>> -		 */
>> -		trialcs->prs_err = PERR_NOTEXCL;
>> -		rcu_read_lock();
>> -		cpuset_for_each_child(cp, css, parent) {
>> -			struct cpumask *xcpus = user_xcpus(trialcs);
>> -
>> -			if (is_partition_valid(cp) &&
>> -			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
>> -				rcu_read_unlock();
>> -				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, tmp);
>> -				rcu_read_lock();
>> -			}
>> -		}
>> -		rcu_read_unlock();
>> -		retval = 0;
>> -	}
>> -	return retval;
>> -}
>> -
>>   /**
>>    * partition_cpus_change - Handle partition state changes due to CPU mask updates
>>    * @cs: The target cpuset being modified
>> @@ -2408,15 +2380,15 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>>   	if (cpumask_equal(cs->cpus_allowed, trialcs->cpus_allowed))
>>   		return 0;
>>   
>> -	if (alloc_tmpmasks(&tmp))
>> -		return -ENOMEM;
>> -
>>   	compute_trialcs_excpus(trialcs, cs);
>>   	trialcs->prs_err = PERR_NONE;
>>   
>> -	retval = cpus_allowed_validate_change(cs, trialcs, &tmp);
>> +	retval = validate_change(cs, trialcs);
>>   	if (retval < 0)
>> -		goto out_free;
>> +		return retval;
>> +
>> +	if (alloc_tmpmasks(&tmp))
>> +		return -ENOMEM;
>>   
>>   	/*
>>   	 * Check all the descendants in update_cpumasks_hier() if
>> @@ -2439,7 +2411,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>>   	/* Update CS_SCHED_LOAD_BALANCE and/or sched_domains, if necessary */
>>   	if (cs->partition_root_state)
>>   		update_partition_sd_lb(cs, old_prs);
>> -out_free:
>> +
>>   	free_tmpmasks(&tmp);
>>   	return retval;
>>   }
>> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
>> index a17256d9f88a..ff4540b0490e 100755
>> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
>> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
>> @@ -269,7 +269,7 @@ TEST_MATRIX=(
>>   	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X3:P2    .      .     0 A1:0-2|A2:3|A3:3 A1:P0|A2:P2 3"
>>   	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3  X2-3:P2   .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
>>   	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:C3 .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
>> -	" C0-3:S+ C1-3:S+ C2-3   C2-3     .      .      .      P2    0 A1:0-3|A2:1-3|A3:2-3|B1:2-3 A1:P0|A3:P0|B1:P-2"
>> +	" C0-3:S+ C1-3:S+ C2-3   C2-3     .      .      .      P2    0 A1:0-1|A2:1|A3:1|B1:2-3 A1:P0|A3:P0|B1:P2"
>>   	" C0-3:S+ C1-3:S+ C2-3   C4-5     .      .      .      P2    0 B1:4-5 B1:P2 4-5"
>>   	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3  X2-3:P2   P2    0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
>>   	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3 X2-3:P2:C1-3 P2  0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
>> @@ -318,7 +318,7 @@ TEST_MATRIX=(
>>   	# Invalid to valid local partition direct transition tests
>>   	" C1-3:S+:P2 X4:P2  .      .      .      .      .      .     0 A1:1-3|XA1:1-3|A2:1-3:XA2: A1:P2|A2:P-2 1-3"
>>   	" C1-3:S+:P2 X4:P2  .      .      .    X3:P2    .      .     0 A1:1-2|XA1:1-3|A2:3:XA2:3 A1:P2|A2:P2 1-3"
>> -	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:4-6 A1:P-2|B1:P0"
>> +	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:5-6 A1:P2|B1:P0"
>>   	"  C0-3:P2   .      .    C4-6 C0-4:C0-3  .      .      .     0 A1:0-3|B1:4-6 A1:P2|B1:P0 0-3"
>>   
>>   	# Local partition invalidation tests
>> @@ -388,10 +388,10 @@ TEST_MATRIX=(
>>   	"  C0-1:S+  C1      .    C2-3     .      P2     .      .     0 A1:0-1|A2:1 A1:P0|A2:P-2"
>>   	"  C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0|A2:1 A1:P1|A2:P2 0-1|1"
>>   
>> -	# A non-exclusive cpuset.cpus change will invalidate partition and its siblings
>> -	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P0"
>> -	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P-1"
>> -	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P0|B1:P-1"
>> +	# A non-exclusive cpuset.cpus change will not invalidate its siblings partition.
>> +	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:3 A1:P1|B1:P0"
>> +	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-1|XA1:0-1|B1:2-3 A1:P1|B1:P1"
>> +	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-1|B1:2-3 A1:P0|B1:P1"
>>   
>>   	# cpuset.cpus can overlap with sibling cpuset.cpus.exclusive but not subsumed by it
>>   	"   C0-3     .      .    C4-5     X5     .      .      .     0 A1:0-3|B1:4-5"
>> @@ -417,6 +417,14 @@ TEST_MATRIX=(
>>   	" CX1-4:S+ CX2-4:P2 .    C5-6      .     .      .   P1:C3-6  0 A1:1|A2:2-4|B1:5-6 \
>>   								       A1:P0|A2:P2:B1:P-1 2-4"
>>   
>> +	# When multiple partitions with conflicting cpuset.cpus are created, the
>> +	# latter created ones will only get what are left of the available exclusive
>> +	# CPUs.
>> +	"  C1-3:P1   .      .      .       .     .      .   C3-5:P1  0 A1:1-3|B1:4-5:XB1:4-5 A1:P1|B1:P1"
>> +
>> +	# cpuset.cpus can be set to a subset of sibling's cpuset.cpus.exclusive
>> +	" C1-3:X1-3  .      .    C4-5      .     .      .     C1-2   0 A1:1-3|B1:1-2"
>> +
>>   	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
>>   	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
>>   	# Failure cases:
>> @@ -427,7 +435,7 @@ TEST_MATRIX=(
>>   	# Changes to cpuset.cpus.exclusive that violate exclusivity rule is rejected
>>   	"   C0-3     .      .    C4-5   X0-3     .      .     X3-5   1 A1:0-3|B1:4-5"
>>   
>> -	# cpuset.cpus cannot be a subset of sibling cpuset.cpus.exclusive
>> +	# cpuset.cpus.exclusive cannot be set to a superset of sibling's cpuset.cpus
>>   	"   C0-3     .      .    C4-5   X3-5     .      .      .     1 A1:0-3|B1:4-5"
>>   )
>>   
>> @@ -477,6 +485,10 @@ REMOTE_TEST_MATRIX=(
>>   	      .      .   X1-2:P2  X4-5:P1  .     X1-7:P2 p1:3|c11:1-2|c12:4:c22:5-6 \
>>   							 p1:P0|p2:P1|c11:P2|c12:P1|c22:P2 \
>>   							 1-2,4-6|1-2,5-6"
>> +	# c12 whose cpuset.cpus CPUs are all granted to c11 will become invalid partition
>> +	" C1-5:P1:S+ .  C1-4:P1   C2-3     .       .  \
>> +	      .      .     .       P1      .       .     p1:5|c11:1-4|c12:5 \
>> +							 p1:P1|c11:P1|c12:P-1"
>>   )
>>   
>>   #


