Return-Path: <linux-kselftest+bounces-46374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2231C7FDAB
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 11:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11F11342D2B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 10:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA61726ED49;
	Mon, 24 Nov 2025 10:21:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B8726ED3B;
	Mon, 24 Nov 2025 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763979709; cv=none; b=IwEJsCQvd6v+C3f/02S/ifJB5XbFf4qMBUIZV33PaPSEAc8YYHeQzfIk+pJlTZ+Ek4+CSBYVUWMs4KekfyC0x9iPPBYM7+z66MvENiiRa90ssRKqU8T6wyd123Xv01gXEQZi3tFJYveWTzdKGBaJPhfWs3DOie3mBUqpZAxZ0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763979709; c=relaxed/simple;
	bh=XrFKLUKUjtSPgpZzyKLT3EqJxePDx9TjKw+thzkIGKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RqTOJngGSlk+HBF78nAnBbQYNlETKznmPEO2yyKazq01uSJFWp9R5lXV9WnOUoLFQhu/p2K2sezyGMvLwb74Zxc6bs+JSiusJVzl3YLv6mTLbM1yrc4BOiSIKx1UHqgMLYW5IT5qDR2X33JBN20YYG0KZtdPGEDcX0h7j0m8dD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5dc29a9cc91f11f0a38c85956e01ac42-20251124
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:18866438-7ed6-4343-9c97-5c055447fde9,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:18866438-7ed6-4343-9c97-5c055447fde9,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:cae3d1fd6dba7c9907052eb12c9b7d3b,BulkI
	D:251119212056S6LKT8LY,BulkQuantity:13,Recheck:0,SF:17|19|64|66|78|80|81|8
	2|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:ni
	l,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,
	DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5dc29a9cc91f11f0a38c85956e01ac42-20251124
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 92028634; Mon, 24 Nov 2025 18:21:40 +0800
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
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on cpuset.cpus conflict.
Date: Mon, 24 Nov 2025 18:21:18 +0800
Message-Id: <20251124102118.1768596-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a2c5266a-60af-4a1a-8a99-a0b0c596aee6@huaweicloud.com>
References: <a2c5266a-60af-4a1a-8a99-a0b0c596aee6@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Ridong,

On Sat, 22 Nov 2025 09:19:39, Chen Ridong wrote:
>On 2025/11/21 18:33, Sun Shaojie wrote:
>> Is this truly a key requirement? It appears this requirement wasn't met even
>> before applying my patch.
>> 
>
>I believe it requires, it may some corner cases we should fix.
>
>> The example below, which does not use this patch, demonstrates how different
>> sequences with identical configurations can still lead to different system
>> states.
>> 
>>  #1> mkdir -p A1
>>  #2> mkdir -p B1                            | A1's prstate | B1's prstate |
>>  #3> echo "0-1"  > A1/cpuset.cpus           | member       | member       |
>>  #4> echo "0-1"  > A1/cpuset.cpus.exclusive | member       | member       |
>>  #5> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>  #6> echo "1-2"  > B1/cpuset.cpus           | root invalid | member       |
>>  #7> echo "2-3"  > B1/cpuset.cpus.exclusive | root invalid | member       |
>>  #8> echo "root" > B1/cpuset.cpus.partition | root invalid | root         |
>> 
>
>IIUC, you've created this example with the expectation that both A1 and B1 should serve as root
>partitions. However, we currently lack a mechanism where modifying a cpuset's state (e.g., cpus,
>cpus.exclusive, or cpus.partition) can transition its sibling from an invalid to a valid partition.
>
>The behavior observed before step #6 is acceptable. Proactively setting B1 as a partition in step #8
>is permitted, given that B1 does not conflict with A1. However, we do not have a mechanism to
>passively and automatically transition A1 to a valid partition state.
>

So, was the original behavior of invalidating sibling partitions driven by this key requirement?
(As a key requirement: Regardless of the order in which we apply the configurations, identical final
settings should always result in identical system states.)

>>  #1> mkdir -p A1
>>  #2> mkdir -p B1                            | A1's prstate | B1's prstate |
>>  #3> echo "0-1"  > A1/cpuset.cpus           | member       | member       |
>>  #4> echo "0-1"  > A1/cpuset.cpus.exclusive | member       | member       |
>>  #5> echo "2-3"  > B1/cpuset.cpus.exclusive | member       | member       |
>>  #6> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>  #7> echo "1-2"  > B1/cpuset.cpus           | root         | member       |
>>  #8> echo "root" > B1/cpuset.cpus.partition | root         | root         |
>> 
>> Even without this patch, the result can still differ.
>> 

Thanks,
Sun Shaojie

