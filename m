Return-Path: <linux-kselftest+bounces-47974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A70CDF514
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Dec 2025 08:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 870B53005FD8
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Dec 2025 07:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2991254AFF;
	Sat, 27 Dec 2025 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaAjIWQs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYrtqxP+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC98B1F4C8C
	for <linux-kselftest@vger.kernel.org>; Sat, 27 Dec 2025 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766821359; cv=none; b=lHFTxEQvBFqdtCiynGIQg0zH0D6NaeNB0V0eFiV1ZBEh6kewt3VXUZVbS6z0pK6O726cnFeKauZgzbJZYROlHeIMT2ukluf3OzPAFQmtuHIAuS1gbKUoAySVpLZDt6wpqZzL/sqWyZ6qaBL4qte3vD84XE5r/6884rioqWPJ23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766821359; c=relaxed/simple;
	bh=BocZbYRq6z/au+ST87u3K7kwQZG0Z/SXAcjr75/GKmo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LU5jLWsbY/f7hrgdBjkb+rFkIEkylV9AaybarRX+udAH0EWNZt8P7u0jmUzMUpklwqeaTIhOO67QnOO2QNsdnOoTd1WnD034EXrODMocC2J9cD1jkXiC7RpR+AF3bZ0Q/m1H/UqowvlrBybCER6KBfTq2OhdPP4Dc46bY4ongPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaAjIWQs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYrtqxP+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766821356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ai5QZoNo9dRmzRpnYcu62kdxHtsGiqg1pjhwu4q+YNg=;
	b=OaAjIWQsnXzmvjA7Bg6RSqdCpH2zT9YH2bWSbG7o61oa59ZCFTur8kaycZED2MRuOjLIJu
	OFEwZ67Cr7CH7XlK34OVboEUotNLQ9pi+AjxZxyBlF0PFnAb0vtID6rtu4cBoCHzhXt7el
	3rUgS9GTm0eltspoXi5pEWUHR6UPlDg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-AIoGWoAGN52qVQ-mINnd_A-1; Sat, 27 Dec 2025 02:42:35 -0500
X-MC-Unique: AIoGWoAGN52qVQ-mINnd_A-1
X-Mimecast-MFC-AGG-ID: AIoGWoAGN52qVQ-mINnd_A_1766821355
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b51db8ebd9so2503804885a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Dec 2025 23:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766821354; x=1767426154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ai5QZoNo9dRmzRpnYcu62kdxHtsGiqg1pjhwu4q+YNg=;
        b=JYrtqxP+8wdxIO9/SuJH8Cc19I11qqcJZtgGD1o39T3Kkp8sBTelg5gZYjNnpZ6Qms
         Non0IAwZTs7h+4mbsjyaiodm8Af2JArBjNlSh5zUTsrkmNZUV6mmO4lP5DqU7hMZcI3r
         n3P/YRsyzvJIxe3GiFPbZBLZ3qgI5tu3kzfbu44Tiejwpjl7A9lm6vkfh4+yNAnZnKSm
         wUT5C84slqgX+TQK5N6dTHheSdPd3A+eOZRShg0Yy9PmMH/p34uvWIlVFINYDuVYYzA2
         5I6GbyvhBVmksUaNc9apDKuVtx0Iw2kzi8oPWdSYcn4fgWjAlAAEL+DBDBvxwgodqZ2z
         vuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766821354; x=1767426154;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ai5QZoNo9dRmzRpnYcu62kdxHtsGiqg1pjhwu4q+YNg=;
        b=jE71RLj8x44XCl0shTbm7zfifDUMGzGw4AOb1whMon7fF06ssuZ6amF/Zr0TolgmQg
         5V2e9uc7+2m3PZDF+op2yDwNNxJ1kw7X7EDTxSwRbwnWkxqm0o7A0et8CabByunT3YFX
         y5zigfUJOv6l9l6RRn6DcBHuS2jt8K46jgm9xA8RhTDqxrnCh2BKYqwNBqpTn/3Cv3aa
         vktZzjoq7HOmL0Gd8cL7tFeik6R2o1VnoOzab2tbmQmQX2Yw2VaeczE2VcdhLqG7uYzL
         doI+AhdWbW3ClEgsq0DNFVoIJS2EXp/+Jwd+1yDKYprC7zGJecomUZe1A7bNY+f5qSdg
         kjqw==
X-Forwarded-Encrypted: i=1; AJvYcCVaM4qdHCt4KyU034cza8xsF/ZsOmU32S+tbWCPn0vAL+HmYSbRMzlqJLL6KJEo6/yTPzJC73nSh6sww0GLeOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1aAF0IraikG5HlipjNCxqr3EIXEIDF5yklOYNhicgip71SBEX
	3EUQ4tzdjZbK0wpBsVNCED4VBNl7+0HelNISIUImZ46Y528HHscdhBMyPBZEPjNIA/Hyv1z+rVk
	O+172hQWPdMsTGccCm93aRRjSkIxiS4BbtiKYid1liRu/B1IG0kJybdAV/Z4Mo1T0nevNKw==
X-Gm-Gg: AY/fxX43oe11ykviepOG7wt8rBXgC1rDoGNBXu3MsaosZmeQerRwGorB1obaDkI5VOP
	3IGEWmoHJgd6y/UE3Geg2c8220j7py8CruEYyz9eUtyu82RrtP0ONwrZs7laylfuVvzZv0Zbyok
	wHZhcd5NR0J0hnv4P2rxozqKtQPK9ECV9c8phOLZbI4SLlevTnsdRFdZ/EL0EXvtpHBVJkFz58E
	kv2/KdFhKzbViNFE73necwO80qmV+L7a7mBkt0puZf0nNuAAqR1Eo6ZiB1RnPo9yPuA6JnU96sM
	SW1E72dpTxUxcuJEOfLuYo47730/jwgwtQY0QYhO/5APmHzwIH9gHYwMmfEGI1hoIBS0IIoTux6
	fL0ExTEzp9+dke6nqsYGMuBN3uZw5rin53SQxiX/dX+btF8dimb+5K5NB
X-Received: by 2002:a05:620a:691a:b0:8a3:22d7:6ca3 with SMTP id af79cd13be357-8c08f66c311mr4100430185a.31.1766821354673;
        Fri, 26 Dec 2025 23:42:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgUkS9lhL5RJ5RrznVdm76aY6GDLmzlCdRQHSFG0i9N6BzjWpT0CJfzF++onNseQeBYwVs1A==
X-Received: by 2002:a05:620a:691a:b0:8a3:22d7:6ca3 with SMTP id af79cd13be357-8c08f66c311mr4100428585a.31.1766821354210;
        Fri, 26 Dec 2025 23:42:34 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f08fcsm1897016385a.40.2025.12.26.23.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 23:42:33 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <471d1be6-db23-42b2-a5e8-5207fb4dcaeb@redhat.com>
Date: Sat, 27 Dec 2025 02:42:32 -0500
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
 <dc9cd447-6431-46f6-b93d-fd2e317aa630@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <dc9cd447-6431-46f6-b93d-fd2e317aa630@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/25/25 4:30 AM, Chen Ridong wrote:
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
> Can we rename it to xcpus_changed?
>
> The current name new_xcpus gives me the impression that CPUs are being added.
> For example: if exclusive_cpus is 1, and it changes to 1-7, then new_xcpus would be 2-7.

Sure. I will make the change in the next version.

Cheers,
Longman

>
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


