Return-Path: <linux-kselftest+bounces-45515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 963C2C55F73
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 07:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51A6E34E93E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 06:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175D1320CDB;
	Thu, 13 Nov 2025 06:42:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6E6320A0B;
	Thu, 13 Nov 2025 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763016146; cv=none; b=OW9s2AxzRVjHzs/4L/7LShqpScSfF5AKc0gcpQ4T4cLIc+rckCvqG2me3JeOrxUap0IgaLuC7St/f2G2X986Oqji7nuBdHunt3zEXYw7jpvjOw0HcAOb1xuu+rq1Ib01lJPyEpiABt/6nvf1A9FsPdyZUpovLHiSrcMZ1cFbCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763016146; c=relaxed/simple;
	bh=+xPG4uC6KAuzhM7W/PX9xBrsT/qPUDv4VnVdnHuqSFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcOX1RpqNFzhR2OiQ9kA6ZLio/NOQkjiaDBFPJLMXTpScko5GJBQKKMiNP3TKO7qhUoZObdLNzZZhTD76fnTzLZQRUAQzBzgwPD7W7QahyeIWcTzwqO/CZnNhy1g3d8g5offZyWYBcUdC0aKF+DXIVlmIks25z0ixwfYoJqtVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e45ff0eec05b11f0a38c85956e01ac42-20251113
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED
	SA_LOWREP, SA_EXISTED, SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:fd1a5dd4-a870-4389-ad86-8bce00c2ede2,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:fd1a5dd4-a870-4389-ad86-8bce00c2ede2,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:4c82669886c03cb61ed280203a47079c,BulkI
	D:251112113325GOOOY919,BulkQuantity:12,Recheck:0,SF:17|19|64|66|78|80|81|8
	2|83|102|841|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil
	,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BR
	R:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_OBB,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e45ff0eec05b11f0a38c85956e01ac42-20251113
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 171834587; Thu, 13 Nov 2025 14:42:15 +0800
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
Subject: Re: [PATCH v1] cpuset: Avoid unnecessary partition invalidation
Date: Thu, 13 Nov 2025 14:42:04 +0800
Message-Id: <20251113064204.507472-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c8e234f4-2c27-4753-8f39-8ae83197efd3@redhat.com>
References: <c8e234f4-2c27-4753-8f39-8ae83197efd3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025/11/13 12:12, Waiman Long wrote:
>On 11/12/25 10:33 PM, Sun Shaojie wrote:
>> The reviewer mentioned they couldn't see my original patch, so I'm
>> re-quoting the key changes below for clarity:
>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 52468d2c178a..e0d27c9a101a 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -586,14 +586,14 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>>>   * Returns: true if CPU exclusivity conflict exists, false otherwise
>>>   *
>>>   * Conflict detection rules:
>>> - * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
>>> + * 1. If both cpusets are exclusive, they must be mutually exclusive
>>>   * 2. exclusive_cpus masks cannot intersect between cpusets
>>>   * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
>>>   */
>>> static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>>> {
>>> -	/* If either cpuset is exclusive, check if they are mutually exclusive */
>>> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>>> +	/* If both cpusets are exclusive, check if they are mutually exclusive */
>>> +	if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
>>> 		return !cpusets_are_exclusive(cs1, cs2);
>>>
>>> 	/* Exclusive_cpus cannot intersect */
>> Here are the main changes, where the conflict check for step #6 in Table 2
>> is performed. And these changes have no effect on cgroup v1.
>
>cpus_excl_conflict() is called by validate_change() which is used for 
>both v1 and v2.
>
>Cheers,
>Longman

Hi，Longman

Thanks for pointing this out. I will make the necessary updates.

Thanks,
Sun Shaojie

