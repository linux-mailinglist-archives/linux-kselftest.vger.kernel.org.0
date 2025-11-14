Return-Path: <linux-kselftest+bounces-45607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86340C5B6C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 06:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713FF3B4384
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 05:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10CF286412;
	Fri, 14 Nov 2025 05:54:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1755C275864;
	Fri, 14 Nov 2025 05:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763099654; cv=none; b=tOttUnsVSV403PXx2rkWrfWJABntp6DqNRn6e43uH1vlQnH8pevB/hMvzgwdGAsy9wen6YFE+fVo0Yl82+R147CUomL0Pks1ZlxtSHDdeifC5tYrUhDrxLY8vVTvdS8OewqGfTiCFMw9Lw/s4u2GNIKflzfWvNN1Ydh7WGQK3hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763099654; c=relaxed/simple;
	bh=cKxA4idn3iEMgFJy4uoQYT+WN1BHvDb9y/h3x65nyeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G3os3Ip92j33tV4obHBvHek6QRNf9x9+S3eL1g1RQTMJ90DplkJ6CTrACO3XS5vNvWnXL2kr0MQawMSWuHtO9PUQLNLJWTIkQS/LNaJPdhTVY6IHzsctbx3bvhxdIddlKkkctjSaOK+Le4SNal7Sin3jTd4jnyCY962Kkuzi37M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 51026c46c11e11f0a38c85956e01ac42-20251114
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:8be70387-f121-4c35-8f31-518ccdf59b1c,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:8be70387-f121-4c35-8f31-518ccdf59b1c,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:5a8dfb844e9c6362ae542e59a4cb2761,BulkI
	D:251113225812EYOJ6GI2,BulkQuantity:4,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|841|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,
	Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 51026c46c11e11f0a38c85956e01ac42-20251114
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1806651116; Fri, 14 Nov 2025 13:54:00 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: llong@redhat.com
Cc: chenridong@huaweicloud.com,
	cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	tj@kernel.org
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
Date: Fri, 14 Nov 2025 13:53:48 +0800
Message-Id: <20251114055348.679854-1-sunshaojie@kylinos.cn>
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

On 2025/11/13 22:57, Waiman Long wrote:
>On 11/13/25 8:14 AM, Sun Shaojie wrote:
>> ...
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 52468d2c178a..3240b3ab5998 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -592,8 +592,13 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>>    */
>>   static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>>   {
>> -	/* If either cpuset is exclusive, check if they are mutually exclusive */
>> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>> +	/* If both cpusets are exclusive, check if they are mutually exclusive */
>> +	if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
>> +		return !cpusets_are_exclusive(cs1, cs2);
>> +
>> +	/* In cgroup-v1, if either cpuset is exclusive, check if they are mutually exclusive */
>> +	if (!is_in_v2_mode() &&
>
>You should just use cpuset_v2() here as is_in_v2_mode() checks an 
>additional v1 specific mode that is irrelevant wrt to exclusive bit 
>handling. Also please update the functional comment about difference in 
>v1 vs. v2 behavior.
>
>Note that we may have to update other conflict checking code in cpuset.c 
>to make this new behavior more consistent.
>
>Thanks,
>Longman
>
>> +	    (is_cpu_exclusive(cs1) != is_cpu_exclusive(cs2)))
>>   		return !cpusets_are_exclusive(cs1, cs2);
>>   
>>   	/* Exclusive_cpus cannot intersect */

Thank you for the correction.I will update the patch accordingly.

Tnanks,
Sun Shaojie

