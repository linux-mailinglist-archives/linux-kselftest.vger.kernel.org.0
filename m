Return-Path: <linux-kselftest+bounces-47975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8C0CDF52F
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Dec 2025 09:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D54A930062D9
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Dec 2025 08:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8A519E99F;
	Sat, 27 Dec 2025 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQYywsrd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTUB6Yzj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A17D27E
	for <linux-kselftest@vger.kernel.org>; Sat, 27 Dec 2025 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766822592; cv=none; b=rK4MY+eJdI0twEZnJl96oR4WQ043QwMaL95mK3e5cgGOAGH8CvUcBJV1Ql6yt+1vIRUheFphdgBeAK9gRiYsf+wzwt4FLeymvv73pMy/HVNB7PdfqGfUc7jEmr8ZQWriMD9go5xwMGAaiVbZdF2ZxCp6hMklw2gSO5kC36aIYLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766822592; c=relaxed/simple;
	bh=DZaTTRmGwMkx0AKhyFDdVnwST5FPOK+XvG/ZNMqeJfk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TkLpju0iZ80oMZ6+AU/spmHP0xabdWsQiH1aC7nXj1wuaH6B0UsenSDAtIMCQl0B18rcWIeNeX1IJ1ax8M7QdR5peU2AK+nCohndupM6Up22Gn+VjCYyiV+jQ7F37Hzh8P4iiExDU9tgxXP5/2WIe5CT7rv6wOG9H/Ghsgutji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQYywsrd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTUB6Yzj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766822590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIHmpJmeFgG2jYdve53ilaK5jPeHA0qfQ9MchC6O8U0=;
	b=UQYywsrdEncN9b+Xo3MXYd6j/Bl7DF07LJWqUNBupiy8lwdraal2rCCCvHthpLgQ8DYWEn
	y01ZPl7+O0vx0mNw4Xl6VaM4kH+rGfY6W8DC8Wla+vTsAvsl+UjsruaOUdETMd31p/gSyv
	A7DyEJUym7JZFxW4QRL3f4M+Q1UYxFk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-Jh6foHEpOKmDspMu1zqGuA-1; Sat, 27 Dec 2025 03:03:08 -0500
X-MC-Unique: Jh6foHEpOKmDspMu1zqGuA-1
X-Mimecast-MFC-AGG-ID: Jh6foHEpOKmDspMu1zqGuA_1766822588
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88a366fa140so378094746d6.1
        for <linux-kselftest@vger.kernel.org>; Sat, 27 Dec 2025 00:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766822588; x=1767427388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vIHmpJmeFgG2jYdve53ilaK5jPeHA0qfQ9MchC6O8U0=;
        b=RTUB6YzjgtfndGSbrcu6g7ZfkjmNm7VpNGDE5L8Q8CwMF7WK1hfFk3/qTEReGLn7Pa
         7qH7CuzrC2UxPWwcNCQcF4GDYqmCPT2VXp3LxrqR46XF6B+zKQy06+7w0O/snFH4tWuE
         Z8VPl1G+pVTDiuRJDLOUTFa8qiRj3W8h7O27OTaLs3oaXjnsrZVqtejgtl5sVOL8z8c4
         g7cGhp9urGK4Rwv03N3LMmJjcOh5oy7BjEjgLYMWgOohdWj4MjpllMuufzRd4sLVw7RK
         hx1IO+1GnLL36E+suyNXl2gpnxWotKejy24PmLdJIvwxbjM6bHV1sbczN1+X48yNv/gR
         6f/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766822588; x=1767427388;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIHmpJmeFgG2jYdve53ilaK5jPeHA0qfQ9MchC6O8U0=;
        b=lF5ExneXIEFEgpqAv9QNaq9cwLdZpicAx2rVCMsyP+CM+0wdTEJmEO7aithP3yM9hm
         BkglhlT5TLimc59D1Wm1ZKOq0wTRccQmTsN44myGprpSUPKT3LoAcM0JWQ+/VJFHl0Qy
         mqWxypjep/IV76niMzmt9fKM571K4AOxATR3YpgZqAAZ6gm2JZL3YqSK/GDvWuzg8rE1
         SCOVCDbZYpgp8btLeGbMYF0fvyVURh0xfH1BI3DEk78f9M4Em/9GQeEyMLiJSqJz54SY
         YtOLhBC/OYhRal3d9FniCGv77vldlFcg0EnT6idDlDRVe/6z/Q9yrqYymj/Iy+Z/vrms
         +q1w==
X-Forwarded-Encrypted: i=1; AJvYcCVwcfnK3VArGkuZ40DapRK7V+l0OrLzjDyarj/0TfXD6vIniIqcuwr8vvIFeSLe4eN9ymU0IVMIuSltjaGzLWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj5Hb7+N4xgXl0H+i3r2S7J2taNRDq5odCEDnd+GvR0OPzWQ7L
	gmyicm9rKzH6EkDSJteAeHtmUL95DL4gLpO039ibzwwoDD7TfPb+AlVXJFC65qqo2f88YbBjnOQ
	reADfTiASt9inDo+x0AU7NpAZSnHNXdB8VLW7+xovO8fYpbkufb6/UlW+nDgbUnOPszzVtg==
X-Gm-Gg: AY/fxX62DQnWqq4TDXr8PaJJCv5bZK8XL5/pcBx1K0IHvdly/EBkO36vXqOyefcqXSA
	guwhpXQzoyRiIhUzxM9yOqOy924lRDppnNs8hsUUnSgw2vigGRxLngF49X4YBa8OImqCCr6a8Ar
	LkTGADyJ09mEs7V5VfwhEgEFUZu5McMozxa8u4dRIyklXGt1G4mEaKUC2Hjf4xDFgf+orQeetYL
	wi8vshA6xaEsI93t8rcQ00RN6NM9xM7BZ+hYwwl5F55mDPF5n2UTlowr8yDtJhEEvbvy6/uWr92
	4NS3BmNURWk+A0s4B64Itl+f7OyjCvYO9fw8VcpjahwT+uNSxcVsmZngBfzI3+tS5INAEoGBcMC
	dJUdAKHg/hDThB59iuc8nAp6IE91WBY+0xkjmnDa9sLR1Wzgsx4AfXJFa
X-Received: by 2002:a05:6214:4e85:b0:880:47e0:19e8 with SMTP id 6a1803df08f44-88d83792f32mr371787956d6.42.1766822587828;
        Sat, 27 Dec 2025 00:03:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHamzXDFR/0zyuAtNekwk7kwOlfxWU5yMK7+RGGo0p7KaE6gkY0t7BsbZldMTNW/XuhT0ag7Q==
X-Received: by 2002:a05:6214:4e85:b0:880:47e0:19e8 with SMTP id 6a1803df08f44-88d83792f32mr371787786d6.42.1766822587419;
        Sat, 27 Dec 2025 00:03:07 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623fdd8sm181516566d6.4.2025.12.27.00.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 00:03:06 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <02239162-b42c-43f0-82eb-9f4af8e96639@redhat.com>
Date: Sat, 27 Dec 2025 03:03:05 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH 3/4] cgroup/cpuset: Don't fail cpuset.cpus
 change in v2
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Sun Shaojie <sunshaojie@kylinos.cn>
References: <20251225073056.30789-1-longman@redhat.com>
 <20251225073056.30789-4-longman@redhat.com>
 <4792e3f5-11ea-4b1c-90fe-f7f202271dae@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <4792e3f5-11ea-4b1c-90fe-f7f202271dae@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/25/25 6:54 AM, Chen Ridong wrote:
>
> On 2025/12/25 15:30, Waiman Long wrote:
>> Commit fe8cd2736e75 ("cgroup/cpuset: Delay setting of CS_CPU_EXCLUSIVE
>> until valid partition") introduced a new check to disallow the setting
>> of a new cpuset.cpus.exclusive value that is a superset of a sibling's
>> cpuset.cpus value so that there will at least be one CPU left in the
>> sibling in case the cpuset becomes a valid partition root. This new
>> check does have the side effect of failing a cpuset.cpus change that
>> make it a subset of a sibling's cpuset.cpus.exclusive value.
>>
>> With v2, users are supposed to be allowed to set whatever value they
>> want in cpuset.cpus without failure. To maintain this rule, the check
>> is now restricted to only when cpuset.cpus.exclusive is being changed
>> not when cpuset.cpus is changed.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 30 +++++++++++++++---------------
>>   1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 850334dbc36a..83bf6b588e5f 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -609,33 +609,31 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>>   
>>   /**
>>    * cpus_excl_conflict - Check if two cpusets have exclusive CPU conflicts
>> - * @cs1: first cpuset to check
>> - * @cs2: second cpuset to check
>> + * @trial:	the trial cpuset to be checked
>> + * @sibling:	a sibling cpuset to be checked against
>> + * @new_xcpus:	new exclusive_cpus in trial cpuset
>>    *
>>    * Returns: true if CPU exclusivity conflict exists, false otherwise
>>    *
>>    * Conflict detection rules:
>>    * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
>>    * 2. exclusive_cpus masks cannot intersect between cpusets
>> - * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
>> + * 3. The allowed CPUs of a sibling cpuset cannot be a subset of the new exclusive CPUs
>>    */
>> -static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>> +static inline bool cpus_excl_conflict(struct cpuset *trial, struct cpuset *sibling,
>> +				      bool new_xcpus)
>>   {
>>   	/* If either cpuset is exclusive, check if they are mutually exclusive */
>> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>> -		return !cpusets_are_exclusive(cs1, cs2);
>> +	if (is_cpu_exclusive(trial) || is_cpu_exclusive(sibling))
>> +		return !cpusets_are_exclusive(trial, sibling);
>>   
>>   	/* Exclusive_cpus cannot intersect */
>> -	if (cpumask_intersects(cs1->exclusive_cpus, cs2->exclusive_cpus))
>> +	if (cpumask_intersects(trial->exclusive_cpus, sibling->exclusive_cpus))
>>   		return true;
>>   
>> -	/* The cpus_allowed of one cpuset cannot be a subset of another cpuset's exclusive_cpus */
>> -	if (!cpumask_empty(cs1->cpus_allowed) &&
>> -	    cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
>> -		return true;
>> -
>> -	if (!cpumask_empty(cs2->cpus_allowed) &&
>> -	    cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
>> +	/* The cpus_allowed of a sibling cpuset cannot be a subset of the new exclusive_cpus */
>> +	if (new_xcpus && !cpumask_empty(sibling->cpus_allowed) &&
>> +	    cpumask_subset(sibling->cpus_allowed, trial->exclusive_cpus))
>>   		return true;
>>   
>>   	return false;
>> @@ -672,6 +670,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>>   {
>>   	struct cgroup_subsys_state *css;
>>   	struct cpuset *c, *par;
>> +	bool new_xcpus;
>>   	int ret = 0;
>>   
>>   	rcu_read_lock();
>> @@ -728,10 +727,11 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>>   	 * overlap. exclusive_cpus cannot overlap with each other if set.
>>   	 */
>>   	ret = -EINVAL;
>> +	new_xcpus = !cpumask_equal(cur->exclusive_cpus, trial->exclusive_cpus);
>>   	cpuset_for_each_child(c, css, par) {
>>   		if (c == cur)
>>   			continue;
>> -		if (cpus_excl_conflict(trial, c))
>> +		if (cpus_excl_conflict(trial, c, new_xcpus))
>>   			goto out;
>>   		if (mems_excl_conflict(trial, c))
>>   			goto out;
> validate_change() is also called from cpuset_update_flag(), which may not change any cpus_allowed or
> exclusive_cpus. This could lead to incorrect checks.
>
> i.e,
>
> # cd /sys/fs/cgroup/
> # mkdir a
> # mkdir b
> # echo 1-2 > b/cpuset.cpus.exclusive  -- no conflict with a
> # echo 1 > a/cpuset.cpus
> # echo root > b/cpuset.cpus.partition  -- b becomes root partition, conflict with a, but
> exclusive_cpus unchanged
> # cat b/cpuset.cpus.partition
> root
>
> As a result, cpuset a (as a member) contains CPU 1, which is a subset of partition b's exclusive
> CPUs — a conflict that might be missed.

Yes, cpuset a has cpuset.cpus set to 1. In v2, cpuset.cpus can be set to 
any value but it doesn't mean that the parent will be able to give it to 
cpuset a. If you look at cpuset.cpus.effective, it will be the same as 
parent cpuset.cpus.effective, i.e. CPUs 1-2 will be absent. This is an 
expected behavior and there is nothing wrong.

Cheers,
Longman


