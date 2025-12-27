Return-Path: <linux-kselftest+bounces-47973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A10F4CDF50E
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Dec 2025 08:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF3B3300C6C9
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Dec 2025 07:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043B1257859;
	Sat, 27 Dec 2025 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOA0kVOn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyuhzFc4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1088E1E885A
	for <linux-kselftest@vger.kernel.org>; Sat, 27 Dec 2025 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766821262; cv=none; b=g0aWj2W4aEjOCrdMTMwtKn1zpXbog9ELw0qCrKmioSxXD1lJO79v11UfrBg30HmvLyE/5iBZqGMxq1SY5Am3f6TjT9ZdXVdFtPeGeJJ0aNn3tLlht4Iba9V4tUIGUOY7If1jRBV1Zep3TDc2Z7FTKRZSrTDm+PBbGDfouUE9DNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766821262; c=relaxed/simple;
	bh=GWtzsTSxe+yrXs4I8eYcoSILdQU19ahQAnlt20TmvIU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=f8prXN5BoS6/7UHujYzrJG2ZjpDLWymxVN7NvvO6vQZDJBczxp1lrp9ORfjuRFtrjGSKA94ORpRFO+6gA6PISx0ThRsuvMByB53tRVMWzlJQ2JQJHO9rkLjYMmtld7XX+BSvAnGpmoQr/QNfZWzrxPhAN+zbY6zI7nBv4EyFIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOA0kVOn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyuhzFc4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766821259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0DwNcOke2gK/ioxlvj0fBOzstfubMNacxjBocotOUEI=;
	b=EOA0kVOnRVlxiKzWU4GbfmrG+3rPCSIOH062L7opM1vGgzzGfZ7XouFZVQ6zISsLLjvXno
	OyNOa73sco9dwqfyyy0noua2xoW+1kwg3DiAxAi4MMJYry7yvIm5K0YXPCVOHfjtsFX1px
	WgrP9Ijj6AyfLLOQLJaS39HrF1KCicw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-OHXDD-izNrSqzZWWj0pOew-1; Sat, 27 Dec 2025 02:40:57 -0500
X-MC-Unique: OHXDD-izNrSqzZWWj0pOew-1
X-Mimecast-MFC-AGG-ID: OHXDD-izNrSqzZWWj0pOew_1766821257
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b286006ffaso2087767385a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Dec 2025 23:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766821257; x=1767426057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0DwNcOke2gK/ioxlvj0fBOzstfubMNacxjBocotOUEI=;
        b=MyuhzFc4fntWToVuQsDdzWApd7/KpZPHzgecCcbsgIgRHK2dVzRccePxQm0NMbvqxB
         xfT6/UA1Zrnr9UCBs/HSuzfYREnfJvpyRHDIZktucsc4J/g7P32EuWLUXU+607GhLlBb
         WfW5Fvi0ViLcTEO7hVpQlzoqC3k/2fJc+ivhG6B9XpuwD95XUAVhhFg+n9TfO8a+RdD3
         khfBugP7HTQwQJBKDI9M+K3u5V7N102IDU6M1UvQtM7K8ttw9ZaWy41hId4K/xQ3eBe5
         Wq2hjuCnbtvW8PUP8ZP09pFr8omxTVnIngzA54vPesbpbh6tzNMLHy4qx1ALyFRZAIRQ
         i1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766821257; x=1767426057;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DwNcOke2gK/ioxlvj0fBOzstfubMNacxjBocotOUEI=;
        b=EIxgnGmt9WkrXVELlWGU91OKT2eHd/r24JslOi8ZsHCeQwUlRCyPky8G8wz3Npf0Me
         sByrICQri9aq+ZyAXBm0SVeFMRskYDdlK16O34RCxB/XOM6AEZkpQ8u/snqM+Z3Mgy8c
         eJBG8ruZWTnBmSW3HMvONfjgAHtgjHC3Ge3Q2YTHQAp0uUYytA8d6rDc6YvAzJoKdZEH
         yz6LYppaQFDc6X8rRCSjxsvfD9w2DmC5JCl15RVdtcF7eBw4/RoWyG9iic09r/Uuy0jQ
         9VYsYL3C9SZv0H5Pw2qk492SU7ywLcaRx28maeMmwIqyg8IIKnyWkQobcjovz4bOJMui
         cG0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4XRzLhP4H9DG8JVswXKcIYccuRejLnmebBQ2LX8sC/Jvf3npzlgqd1wFiGdm5QRx0WnRPPSlbu63EUHOcOho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFdcB9Ivk7544MyyfvxxTvNTgfbv6vpZGw2wmSBm38WFmALMhD
	EirJDVXFltWrZ/5vHcQhIaC1OeV479QbtUH0GD7jyX/BeacPP1Rjs5SHLwauHrjY+GdJH7rLqRX
	sZydYSI4PNpAaPFVhU+l4tta1Cngb2Uy3ZrbxicoyA4YV/6utrg7zCRlksjbtsojcFTA48Q==
X-Gm-Gg: AY/fxX5tUgzz5eeXCCCrZcEmsBZBikSGL+3aJahsJjfuiUBok+xTWGB+YC4FV1h8NVB
	d/KIY5A9nfWe/b2ydXOjFDGOy6+gSp+gzXfHeKmYbdmwUHp9qdZnHNV3Zsra2X67164wMig9LI+
	PvzLJij7YHr9wIg4iyTzt1UwIgr6KhznrQjveXG/8lqS+VkSbb3qIPn/e2oCrzsTwy5yRumUy8V
	jd3x1tWWmteZ048xRXquFpsSyTN1Rk9IPDj8rsuGvklw888s6pCmUROYSRptIVb6f9pTYaO5ky2
	BVew54SLx3VVTtaomE3Fj5Cokc7k+1HcqqnXuG6YzfePdkrPea1KOB+tzk8NtoAzsrshXZcn3KJ
	euPbwQ6liQF5v9pN31FWK5EnGaJ0jBLYH4QqEgkXw3ga6F30Wf5SnGQlU
X-Received: by 2002:a05:620a:4054:b0:89e:67a9:fced with SMTP id af79cd13be357-8c08fabf2damr3557710285a.66.1766821256910;
        Fri, 26 Dec 2025 23:40:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxd8EoY1n2eid3yg9nQXs4eblN/ICVLhfJ8sEY7sdfxSLJXXU/pJM9ooykELoGhas/1nicTA==
X-Received: by 2002:a05:620a:4054:b0:89e:67a9:fced with SMTP id af79cd13be357-8c08fabf2damr3557709085a.66.1766821256489;
        Fri, 26 Dec 2025 23:40:56 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0975ee7d5sm1887454885a.49.2025.12.26.23.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 23:40:55 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2988a9d5-fe25-4668-93e3-8335360fcbec@redhat.com>
Date: Sat, 27 Dec 2025 02:40:53 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH 1/4] cgroup/cpuset: Streamline
 rm_siblings_excl_cpus()
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Sun Shaojie <sunshaojie@kylinos.cn>
References: <20251225073056.30789-1-longman@redhat.com>
 <20251225073056.30789-2-longman@redhat.com>
 <c75025d3-17cd-47bb-a222-bde3a156bbbb@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <c75025d3-17cd-47bb-a222-bde3a156bbbb@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/25/25 4:27 AM, Chen Ridong wrote:
>
> On 2025/12/25 15:30, Waiman Long wrote:
>> If exclusive_cpus is set, effective_xcpus must be a subset of
>> exclusive_cpus. Currently, rm_siblings_excl_cpus() checks both
>> exclusive_cpus and effective_xcpus connectively. It is simpler
>> to check only exclusive_cpus if non-empty or just effective_xcpus
>> otherwise.
>>
>> No functional change is expected.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 17 +++++++++--------
>>   1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 221da921b4f9..3d2d28f0fd03 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1355,23 +1355,24 @@ static int rm_siblings_excl_cpus(struct cpuset *parent, struct cpuset *cs,
>>   	int retval = 0;
>>   
>>   	if (cpumask_empty(excpus))
>> -		return retval;
>> +		return 0;
>>   
>>   	/*
>>   	 * Exclude exclusive CPUs from siblings
>>   	 */
>>   	rcu_read_lock();
>>   	cpuset_for_each_child(sibling, css, parent) {
>> +		struct cpumask *sibling_xcpus;
>> +
>>   		if (sibling == cs)
>>   			continue;
>>   
>> -		if (cpumask_intersects(excpus, sibling->exclusive_cpus)) {
>> -			cpumask_andnot(excpus, excpus, sibling->exclusive_cpus);
>> -			retval++;
>> -			continue;
>> -		}
>> -		if (cpumask_intersects(excpus, sibling->effective_xcpus)) {
>> -			cpumask_andnot(excpus, excpus, sibling->effective_xcpus);
>> +		sibling_xcpus = cpumask_empty(sibling->exclusive_cpus)
>> +			      ? sibling->effective_xcpus
>> +			      : sibling->exclusive_cpus;
>> +
> I'm wondering if this is sufficient?
>
> sibling_xcpus = sibling->effective_xcpus
>
>        p(exclusive_cpus = 1)
>     /	  \
>   a	b(root, exclusive_cpus=1-7, effective_xcpus=1)
>
> What the sibling's effective exclusive CPUs actually should be is not CPUs 1-7 but CPU 1. So, do we
> need to remove CPUs 2-7?

By definition, exclusive_cpus have to be exclusive within the same child 
cpuset level even if some of the CPUs cannot be granted from the parent. 
So other siblings cannot use any of the CPUs 1-7 in its exclusive_cpus 
list or the writing will fail. In the case of cpuset.cpus defined 
partitions, those CPUs will be removed from its effective_xcpus list.

Cheers,
Longman


