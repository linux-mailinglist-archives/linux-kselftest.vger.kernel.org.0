Return-Path: <linux-kselftest+bounces-45968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A49DC6E262
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 12:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE923351063
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 11:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29CB3502BB;
	Wed, 19 Nov 2025 11:04:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FEA34EF0D;
	Wed, 19 Nov 2025 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763550251; cv=none; b=H7oksHBDa/KIOJULVzMR+uGszkrtaK7F1P+9OS8YGIHkOCVzYy8coDHpdo11V5UCMI/4ncaR1awdBoplzDfl0OW62PfM6S46EiDa77IiSvGsLHvfavAungSG8MDMs+95aXLZHy6Zzla2FsFUg4tqkK80e8zV8RzuiWopvwvju/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763550251; c=relaxed/simple;
	bh=fUrPZr+QXq3iOsIuyiGYcvLHDRJttoBJ5uy+zjEET1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pKDMl1WFb4SWNWoa+STlPolgDLt2JTgW2gWJqaB3utUgptOYIL/eXrSM9L2SF1jIylvTh2+D3aiLUyqQxfTCKxE1KfU4xpek6o+c1nqScX8qC5tfkTWvQ5T8D4C6woMH9NKXKb9+ccWE2uZluJOUrtbaSA5Br1tGW40YTCLtTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 70af56b8c53711f0a38c85956e01ac42-20251119
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:20ab5d73-8e89-4b39-951b-d608d0a4070b,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:20ab5d73-8e89-4b39-951b-d608d0a4070b,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:f5ff99cc9e6519c21c8f1650a7f9b928,BulkI
	D:251117180100BIUI482W,BulkQuantity:4,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|841|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:n
	il,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,
	BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 70af56b8c53711f0a38c85956e01ac42-20251119
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2049923391; Wed, 19 Nov 2025 19:03:55 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: chenridong@huaweicloud.com
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llong@redhat.com,
	mkoutny@suse.com,
	shuah@kernel.org,
	sunshaojie@kylinos.cn,
	tj@kernel.org
Subject: Re: [PATCH v4 1/1] cpuset: relax the overlap check for cgroup-v2
Date: Wed, 19 Nov 2025 19:03:40 +0800
Message-Id: <20251119110340.1386752-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f32d2f31-630f-450b-911f-b512bbeb380a@huaweicloud.com>
References: <f32d2f31-630f-450b-911f-b512bbeb380a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Ridong,

On 2025/11/17 19:37, Chen Ridong wrote:
>On 2025/11/17 18:00, Sun Shaojie wrote:
>> Certainly, this rule applies regardless of whether cs1 or cs2 is exclusive,
>> and the current implementation already handles it this way.
>> The following two cases cover this rule. 
>> "1. If cs1 is exclusive, cs1 and cs2 must be mutually exclusive"
>> "3. If cs2 is exclusive, cs2's allowed CPUs cannot be a subset of cs1's exclusive CPUs"
>> 
>
>I believe this function should return the same result regardless of whether it is called as
>cpus_excl_conflict(A1, B1) or cpus_excl_conflict(B1, A1), which means cs1 and cs2 should be treated
>symmetrically. However, since cs1 and cs2 are handled differently, it is difficult to convince me
>that this implementation is correct.

In patch v5, modifications to the cpus_excl_conflict interface have been 
avoided, along with preventing the following ineffective scenario.

Both A1 and B1 are exclusive, change B1's cpuset.cpus, avoid A1 becoming 
non-exclusive.

Looking forward to your feedback on patch v5.
patch v5 : https://lore.kernel.org/cgroups/20251119105749.1385946-1-sunshaojie@kylinos.cn/

Thanks,
Sun Shaojie

