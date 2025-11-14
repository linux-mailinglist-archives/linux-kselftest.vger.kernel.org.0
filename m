Return-Path: <linux-kselftest+bounces-45609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C745EC5B966
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A4274ED103
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 06:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E802EB5D5;
	Fri, 14 Nov 2025 06:33:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC2721C167;
	Fri, 14 Nov 2025 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763102014; cv=none; b=ddTEKGcjJ7cipiP/8DuEhlw26waBgpiq0h2aUWUXHw2HBF3fgHHNkiOVBf00/abubl6EIhuaDwT6Ekh74sVJkkBQGSDqBeFBvZpVY7Ug3OxQtgUbvz2u/tvXB2PwKzqVNgPqlhbUc1BMxD40hjDUlbI0pJ2JO2cd3E3dTsionsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763102014; c=relaxed/simple;
	bh=kOLIfuwDBnzC4Nw5fSwJalPzvmYv8Ngr5boYV0I9cro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZTlwzml/sRMwovUnKwAmvxOnFRwy42Uq9nel1tY3V+UFB+IxbWScETnRxHq3wV9XsB8ZIxo6GgFfVTSLoH73CLjWgbiMEM4oeGhRxDc+TT0bg5VE6JpSTi0Lkc+HFewiH0OMcYhDHvV1O8aceGEDRnYFvYY76BjBH9JfEeDR4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d2a478dec12311f0a38c85956e01ac42-20251114
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:721bfb98-055e-40cb-9676-e5e6598af3d3,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:721bfb98-055e-40cb-9676-e5e6598af3d3,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:40adba3f29d6939bed13e26cc8ece0f6,BulkI
	D:251113225812EYOJ6GI2,BulkQuantity:6,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|841|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,
	Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d2a478dec12311f0a38c85956e01ac42-20251114
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1053057390; Fri, 14 Nov 2025 14:33:25 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: chenridong@huaweicloud.com
Cc: mkoutny@suse.com,
	llong@redhat.com,
	cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	tj@kernel.org
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
Date: Fri, 14 Nov 2025 14:33:12 +0800
Message-Id: <20251114063312.687950-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <19fa5a93-4cc9-4f84-891c-b3b096a68799@huaweicloud.com>
References: <19fa5a93-4cc9-4f84-891c-b3b096a68799@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2025/11/14 08:50, Chen Ridong Wrote:
>On 2025/11/13 21:14, Sun Shaojie wrote:
>> ...
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 52468d2c178a..3240b3ab5998 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -592,8 +592,13 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>>   */
>>  static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>>  {
>> -	/* If either cpuset is exclusive, check if they are mutually exclusive */
>> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>> +	/* If both cpusets are exclusive, check if they are mutually exclusive */
>> +	if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
>> +		return !cpusets_are_exclusive(cs1, cs2);
>> +
>> +	/* In cgroup-v1, if either cpuset is exclusive, check if they are mutually exclusive */
>> +	if (!is_in_v2_mode() &&
>> +	    (is_cpu_exclusive(cs1) != is_cpu_exclusive(cs2)))
>>  		return !cpusets_are_exclusive(cs1, cs2);
>>  
>
>I prefer adding a helper function in the cpuset-v1.c file, similar to cpus_excl_conflict_legacy().
>
>For cpuset v1, it can simply return cpus_excl_conflict_legacy(). It seems that other rules are not
>relevant to v1.
>
>>  	/* Exclusive_cpus cannot intersect */

Hi, Ridong,

Thank you for the suggestion.I will update the patch accordingly.

Thanks,
Sunshaojie

