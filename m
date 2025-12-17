Return-Path: <linux-kselftest+bounces-47656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EBACC6C2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 10:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2B2A30F1FAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BDD25C80D;
	Wed, 17 Dec 2025 09:10:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C321E6DC5;
	Wed, 17 Dec 2025 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765962630; cv=none; b=QhXAgCERkKLqvFa36w+DsAGgoFVCZmxpN9soWd8kAe4MMK/EYJu7pznl9LjyDwqky+0z+IYP7w1JYz9VObYvs7o6BIwtU0xNBN0BHobrctkrcHjp9XDVjHHoMOTgpqmesoZrkV9YVwrt4TNyJyCjyJPCBQyOLh14DJTFcaM+l9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765962630; c=relaxed/simple;
	bh=qvl2s/WfXStAyc5oWK7q8S8knivL6lAQyWdFo9dqnu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikAt6xpg1pTiYt3apuhhxwOvg0W0/3Mi9Ae+XkcHsTSooLrdBmcDuzF+nxW/0WzmHjRUYh+60i/Bm80dPmcFM93pspE5Qj8M2MvwkIgfd1KSjw06nNblPxx485wJr/Tq3Oim6iCMvSnB4n21zatnrJBowiD5KEmueK4QLBn6Ch8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 35ac91e6db2811f0a38c85956e01ac42-20251217
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:9649531c-7707-4c04-a7a2-9d90eee6663e,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:9649531c-7707-4c04-a7a2-9d90eee6663e,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:c459e8b512f21403d802322b9ba122cb,BulkI
	D:251217171021JN0GV8BQ,BulkQuantity:0,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:
	nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR
	:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 35ac91e6db2811f0a38c85956e01ac42-20251217
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(183.242.174.23)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2056059356; Wed, 17 Dec 2025 17:10:19 +0800
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
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on cpuset.cpus conflict
Date: Wed, 17 Dec 2025 17:09:51 +0800
Message-Id: <20251217090951.1444326-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4ab8a086-4200-45c0-9583-abf6e52a354a@huaweicloud.com>
References: <4ab8a086-4200-45c0-9583-abf6e52a354a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Ridong

On Sat, 13 Dec 2025 08:52:11 +0800, Chen Ridong wrote:
>On 2025/12/1 17:44, Sun Shaojie wrote:
>> Hi, Ridong,
>> 
>> On Thu, 27 Nov 2025 09:55:21, Chen Ridong wrote:
>>> I have to admit that I prefer the current implementation.
>>>
>>> At the very least, it ensures that all partitions are treated fairly[1]. Relaxing this rule would
>>> make it more difficult for users to understand why the cpuset.cpus they configured do not match the
>>> effective CPUs in use, and why different operation orders yield different results.
>> 
>> As for "different operation orders yield different results", Below is an
>> example that is not a corner case.
>> 
>>     root cgroup
>>       /    \
>>      A1    B1
>> 
>>  #1> echo "0" > A1/cpuset.cpus
>>  #2> echo "0-1" > B1/cpuset.cpus.exclusive --> return error
>> 
>>  #1> echo "0-1" > B1/cpuset.cpus.exclusive
>>  #2> echo "0" > A1/cpuset.cpus
>> 
>
>You're looking at one rule, but there's another one—Longman pointed out that setting cpuset.cpu
>should never fail.

Precisely because I know that setting cpuset.cpus should never fail,
I provided this example, which is why it demonstrates that "different
operation orders yield different results."

>>>
>>> In another scenario, if we do not invalidate the siblings, new leaf cpusets (marked as member)
>>> created under A1 will end up with empty effective CPUs—and this is not a desired behavior.
>>>
>>>   root cgroup
>>>        |
>>>       A1
>>>      /  \
>>>    A2    A3...
>>>
>>> #1> echo "0-1" > A1/cpuset.cpus
>>> #2> echo "root" > A1/cpuset.cpus.partition
>>> #3> echo "0-1" > A2/cpuset.cpus
>>> #4> echo "root" > A2/cpuset.cpus.partition
>>> mkdir A4
>>> mkdir A5
>>> echo "0" > A4/cpuset.cpus
>>> echo $$ > A4/cgroup.procs
>>> echo "1" > A5/cpuset.cpus
>>> echo $$ > A5/cgroup.procs
>>>
>> 
>> If A2...A5 all belong to the same user, and that user wants both A4 and A5 
>> to have effective CPUs, then the user should also understand that A2 needs
>> to be adjusted to "member" instead of "root".
>> 
>> if A2...A5 belong to different users, must satisfying user A4’s requirement
>> come at the expense of user A2’s requirement? That is not fair.
>> 
>
>Regarding cpuset usage with Docker: when binding CPUs at container startup, do you check the sibling
>CPUs in use? Without this check, A2 will not be invalidated.
>
>Your patch has been discussed for a while. It seems to make the rules more complex.

My aim is to safeguard the independence of sibling nodes while adhering to
existing rules. I continuously update the patch to uphold these rules, as
seen in the recently updated patch v6
(https://lore.kernel.org/cgroups/20251201093806.107157-1-sunshaojie@kylinos.cn/).

Thanks,
Sun Shaojie

