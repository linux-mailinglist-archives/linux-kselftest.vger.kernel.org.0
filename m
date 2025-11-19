Return-Path: <linux-kselftest+bounces-45971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A77D0C6E2CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 12:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 585D3355883
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA943538AA;
	Wed, 19 Nov 2025 11:06:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568E4350D46;
	Wed, 19 Nov 2025 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763550388; cv=none; b=s4BAaZQJMDTE8LYAdDOG4p5xGue6LBf3DQnygsvYkdw0NCOVV6OcKB09xq23wiRXg+4UdNpq7PPZLciovbAf0RDchyq6Vl2hbia4udb7hqFn3FYUadK+3TomlE84RKQcvSjCCDWxbutefoBeaflaMS81+zKlIgfamFIzGM9XMUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763550388; c=relaxed/simple;
	bh=BbYn8CqyP0+Hg9dyQYWnTfj+aqDyVNNHHeIsXidYinQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3Uz93Rw8/shyKtq/ZHUcVyG0tjOYzb9YvlT0SfL2v/NZ07S7l3QJ2ROp3o8NmMUO3XpxFhUOM3ls2BJEeyjK82pCmkL2GCziWL4lnhVVXOYpG8bB3lkHF3JtZ5Ef8qVT0eGV0Dp5ZcmwjACxfG5M5paHIRFue45OuW4ioXqLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c09cf5e0c53711f0a38c85956e01ac42-20251119
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_FG_IT, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:cc27802b-44c4-49f9-a9b0-58b2da6c2faf,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:cc27802b-44c4-49f9-a9b0-58b2da6c2faf,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:5802ba938666071d8c168d1e00a3a3b8,BulkI
	D:251117180100BIUI482W,BulkQuantity:6,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|841|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:n
	il,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,
	BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c09cf5e0c53711f0a38c85956e01ac42-20251119
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 687768682; Wed, 19 Nov 2025 19:06:09 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: llong@redhat.com
Cc: cgroups@vger.kernel.org,
	chenridong@huaweicloud.com,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	sunshaojie@kylinos.cn,
	tj@kernel.org
Subject: Re: [PATCH v4 1/1] cpuset: relax the overlap check for cgroup-v2
Date: Wed, 19 Nov 2025 19:05:46 +0800
Message-Id: <20251119110546.1387184-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <942d2b65-3c28-4f6d-aa6b-8365fa5cea2c@redhat.com>
References: <942d2b65-3c28-4f6d-aa6b-8365fa5cea2c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Longman,

On Tue, 18 Nov 2025 14:53:27 -0500, Longman wrote:
>On 11/16/25 8:57 PM, Sun Shaojie wrote:
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 52468d2c178a..0fd803612513 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -580,35 +580,56 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>>   
>>   /**
>>    * cpus_excl_conflict - Check if two cpusets have exclusive CPU conflicts
>> - * @cs1: first cpuset to check
>> - * @cs2: second cpuset to check
>> + * @cs1: current cpuset to check
>> + * @cs2: cpuset involved in the check
>>    *
>>    * Returns: true if CPU exclusivity conflict exists, false otherwise
>>    *
>>    * Conflict detection rules:
>> - * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
>> + * For cgroup-v1:
>> + *     see cpuset1_cpus_excl_conflict()
>> + * For cgroup-v2:
>> + * 1. If cs1 is exclusive, cs1 and cs2 must be mutually exclusive
>>    * 2. exclusive_cpus masks cannot intersect between cpusets
>> - * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
>> + * 3. If cs2 is exclusive, cs2's allowed CPUs cannot be a subset of cs1's exclusive CPUs
>> + * 4. if cs1 and cs2 are not exclusive, the allowed CPUs of one cpuset cannot be a subset
>> + *    of another's exclusive CPUs
>>    */
>>   static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>
>As cs1 and cs2 is going to be handled differently, their current naming 
>will make it hard to understand why they are treated differently. I will 
>recommended changing the parameter name to "trial, sibling" as the 
>caller call it with "cpus_excl_conflict(trial, c)" where trial is the 
>new cpuset data to be tested and sibling is one of its sibling cpusets. 
>It has to be clearly document what each parameter is for and the fact 
>that swapping the parameters will cause it to return incorrect result.
>
>
>>   {
>> -	/* If either cpuset is exclusive, check if they are mutually exclusive */
>> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>> +	/* For cgroup-v1 */
>> +	if (!cpuset_v2())
>> +		return cpuset1_cpus_excl_conflict(cs1, cs2);
>> +
>> +	/* If cs1 are exclusive, check if they are mutually exclusive */
>> +	if (is_cpu_exclusive(cs1))
>>   		return !cpusets_are_exclusive(cs1, cs2);
>
>Code change like the following can eliminate the need to introduce a new 
>cpuset1_cpus_excl_conflict() helper.
>
>diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>index ec8bebc66469..201c70fb7401 100644
>--- a/kernel/cgroup/cpuset.c
>+++ b/kernel/cgroup/cpuset.c
>@@ -599,9 +599,15 @@ static inline bool cpusets_are_exclusive(struct 
>cpuset *cs1, struct cpuset *cs2)
>   */
>  static inline bool cpus_excl_conflict(struct cpuset *cs1, struct 
>cpuset *cs2)
>  {
>-       /* If either cpuset is exclusive, check if they are mutually 
>exclusive */
>-       if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>-               return !cpusets_are_exclusive(cs1, cs2);
>+       /*
>+        * If trial is exclusive or sibling is exclusive & in v1,
>+        * check if they are mutually exclusive
>+        */
>+       if (is_cpu_exclusive(trial) || (!cpuset_v2() && 
>is_cpu_exclusive(sibling)))
>+               return !cpusets_are_exclusive(trial, sibling);
>+
>+       if (!cpuset_v2())
>+               return false;   /* The checking below is irrelevant to 
>cpuset v1 */
>
>         /* Exclusive_cpus cannot intersect */
>         if (cpumask_intersects(cs1->exclusive_cpus, cs2->exclusive_cpus))

Thank you very much for your guidance and suggestions on the code.

I've updated patch v5 with some new ideas and look forward to your feedback.

patch v5 : https://lore.kernel.org/cgroups/20251119105749.1385946-1-sunshaojie@kylinos.cn/

Thanks,
Sun Shaojie

