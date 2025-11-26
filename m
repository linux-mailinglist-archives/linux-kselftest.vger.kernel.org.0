Return-Path: <linux-kselftest+bounces-46499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2583C89C5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 13:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D92B4E5488
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 12:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C39328622;
	Wed, 26 Nov 2025 12:30:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C61E328630;
	Wed, 26 Nov 2025 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160226; cv=none; b=q2czArRodgw+0W6lxPW0//4jmrBeuh1pIKbQGGTBM+4y2LTsSuAxU76ZRcuF302T2Q6Hf7LUBmVrCdtNmJRCj1vg0qympzSwAgTQ4sYWRonudDVzHHucr0WfVPnxire1FBSEgV8YMTm9RaCLnbWkjsLwkyjLyLays+vWQ3l23UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160226; c=relaxed/simple;
	bh=1Sre50F21oLn1FjEK95ZUtitxg0ui00M3CZpiCURCUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cocixEd4EYEFnKmpNm8zK+g9NKnb5aMLvHHvEw4iiuhSvxskxlHhnE+Nr4mTQcL0mmFZUnIfkL7O1Y3xTEPUmfi7N6TZAY5T5+vpJywdTmY4Q0cMLU6Hfq2EF2YvWnNFONiDO84bH5fVBZpxLOzWeTw8sNpOdfIi8/suwUm6ol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a29ced8ecac311f0a38c85956e01ac42-20251126
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:9f01c5bd-bf4f-46e1-9776-6a69dbb72c33,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:9f01c5bd-bf4f-46e1-9776-6a69dbb72c33,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:a5521d8f0dc82f54d268926400f2d881,BulkI
	D:251119212056S6LKT8LY,BulkQuantity:16,Recheck:0,SF:17|19|64|66|78|80|81|8
	2|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:ni
	l,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,
	DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a29ced8ecac311f0a38c85956e01ac42-20251126
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 485430474; Wed, 26 Nov 2025 20:30:04 +0800
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
Date: Wed, 26 Nov 2025 20:29:43 +0800
Message-Id: <20251126122943.2099086-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <921ab4b4-0713-4c33-9c11-eac234ab9d39@huaweicloud.com>
References: <921ab4b4-0713-4c33-9c11-eac234ab9d39@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Ridong,

On Mon, 24 Nov 2025 19:33:54, Chen Ridong wrote:
>On 2025/11/24 18:20, Sun Shaojie wrote:
>> I'm sorry, I didn't quite understand the point you were trying to make with this example.
>> 
>> If that's the case
>> 
>>      root cgroup
>>           |
>>           A1
>>        / /  \ \
>>      A2 A3  A4 A5
>> 
>>  #1> echo "0-1" > A1/cpuset.cpus
>>  #2> echo "root" > A1/cpuset.cpus.partition
>>  #3> echo "0-1" > A2/cpuset.cpus
>>  #4> echo "root" > A2/cpuset.cpus.partition
>>  mkdir A4
>>  mkdir A5
>>  echo "0" > A4/cpuset.cpus
>
>If we don't apply your patch, A2 will be invalidated.
>
>>  echo $$ > A4/cgroup.procs  ->This will return an error because A4's effective CPUs are empty.
>>  echo "1" > A5/cpuset.cpus
>>  echo $$ > A5/cgroup.procs  ->This will return an error because A5's effective CPUs are empty.
>> 
>> Even with this patch applied, this result will not change.
>> 
>
>You can have a try, the result I got:
>
># mkdir A1
># echo "0-1" > A1/cpuset.cpus
># echo "root" > A1/cpuset.cpus.partition
># cd A1/
># mkdir A2
># mkdir A4
># mkdir A5
># echo "0-1" > A2/cpuset.cpus
># echo "root" > A2/cpuset.cpus.partition
>#
># echo "0" > A4/cpuset.cpus
># cat A2/cpuset.cpus
>0-1
># cat A2/cpuset.cpus.partition
>root invalid
># cat A4/cpuset.cpus.effective
>0

A4's cpuset.cpus.effective is 0 because A2 changed from root to root invalid. 
However, the purpose of this patch is precisely to keep A2 as "root".

Before 'echo "0" > A4/cpuset.cpus', A4 is aware that its cpuset.cpus.effective
is empty and that its parent's cpuset.cpus.effective is also empty. Therefore,
after executing 'echo "0" > A4/cpuset.cpus', A4 should anticipate the 
possibility that it may not be allocated any available CPUs.

Thanks,
Sun Shaojie

