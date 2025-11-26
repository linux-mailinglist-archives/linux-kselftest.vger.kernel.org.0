Return-Path: <linux-kselftest+bounces-46500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4880C89C97
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 13:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A68A4E945E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC4A327201;
	Wed, 26 Nov 2025 12:32:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1217A31195B;
	Wed, 26 Nov 2025 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160339; cv=none; b=oy+Cy6OO4lvwjTGIV9WVVQKxw8K8fah3cfvmQExAuxRZojEIjXIzf1XUZ4w08JZ/t9H7Nx8D+n0qm1Fjp3SRg0ftm7O9dKFPDF4PnrJ8ynussixmWtl2jSf0FdefFGPdwWjxLwSiLiQAhL/O7l27Jr3XWEbIZOQ76qNeDvxz3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160339; c=relaxed/simple;
	bh=2xN0tnH5etLLt9o/9UwjbfbIL0M4c3ckMa6b/dOmc2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmyJ86PX+RM4SRuajdbfIkvUwzvuzkUzTc6p2b+MTebpyzhzNvZhA7G9sEIYvpiyb19E35hQCSuzYhyqPg6z+m0SAdxnqGSycsHbyUSrBvzaA2P6iKSbI2WycdXCcfgkaM+d8cGryctdIbXg7beI2lBZO4Jab2PJlw3aF8Cj2fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e5c670e4cac311f0a38c85956e01ac42-20251126
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:7f8e9cbe-4306-430b-836e-822cef1f20dc,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:7f8e9cbe-4306-430b-836e-822cef1f20dc,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:ce7912747b359430f9df89fb45b22d39,BulkI
	D:251119212056S6LKT8LY,BulkQuantity:17,Recheck:0,SF:17|19|64|66|78|80|81|8
	2|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:ni
	l,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,
	DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e5c670e4cac311f0a38c85956e01ac42-20251126
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 659765964; Wed, 26 Nov 2025 20:31:57 +0800
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
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on cpuset.cpus conflict.
Date: Wed, 26 Nov 2025 20:31:13 +0800
Message-Id: <20251126123113.2099516-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cae7a3ef-9808-47ac-a061-ab40d3c61020@redhat.com>
References: <cae7a3ef-9808-47ac-a061-ab40d3c61020@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Longman,

On Mon, 24 Nov 2025 17:30:47, Waiman Long wrote:
>On 11/19/25 5:57 AM, Sun Shaojie wrote:
>> Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
>> with its sibling partition, the sibling's partition state becomes invalid.
>> However, this invalidation is often unnecessary. If the cpuset being
>> modified is exclusive, it should invalidate itself upon conflict.
>>
>> This patch applies only to the following two cases：
>>
>> Assume the machine has 4 CPUs (0-3).
>>
>>     root cgroup
>>        /    \
>>      A1      B1
>>
>> Case 1: A1 is exclusive, B1 is non-exclusive, set B1's cpuset.cpus
>>
>>   Table 1.1: Before applying this patch
>>   Step                                       | A1's prstate | B1's prstate |
>>   #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>   #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>   #3> echo "0" > B1/cpuset.cpus              | root invalid | member       |
>>
>> After step #3, A1 changes from "root" to "root invalid" because its CPUs
>> (0-1) overlap with those requested by B1 (0). However, B1 can actually
>> use CPUs 2-3(from B1's parent), so it would be more reasonable for A1 to
>> remain as "root."
>>
>>   Table 1.2: After applying this patch
>>   Step                                       | A1's prstate | B1's prstate |
>>   #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>   #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>   #3> echo "0" > B1/cpuset.cpus              | root         | member       |
>>
>> Case 2: Both A1 and B1 are exclusive, set B1's cpuset.cpus
>>
>>   Table 2.1: Before applying this patch
>>   Step                                       | A1's prstate | B1's prstate |
>>   #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>   #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>   #3> echo "2" > B1/cpuset.cpus              | root         | member       |
>>   #4> echo "root" > B1/cpuset.cpus.partition | root         | root         |
>>   #5> echo "1-2" > B1/cpuset.cpus            | root invalid | root invalid |
>>
>> After step #4, B1 can exclusively use CPU 2. Therefore, at step #5,
>> regardless of what conflicting value B1 writes to cpuset.cpus, it will
>> always have at least CPU 2 available. This makes it unnecessary to mark
>> A1 as "root invalid".
>>
>>   Table 2.2: After applying this patch
>>   Step                                       | A1's prstate | B1's prstate |
>>   #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>   #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>   #3> echo "2" > B1/cpuset.cpus              | root         | member       |
>>   #4> echo "root" > B1/cpuset.cpus.partition | root         | root         |
>>   #5> echo "1-2" > B1/cpuset.cpus            | root         | root invalid |
>>
>> In summary, regardless of how B1 configures its cpuset.cpus, there will
>> always be available CPUs in B1's cpuset.cpus.effective. Therefore, there
>> is no need to change A1 from "root" to "root invalid".
>>
>> All other cases remain unaffected. For example, cgroup-v1.
>
>This patch is relatively simple. As others have pointed out, there are 
>inconsistency depending on the operation ordering.
>
>In the example above, the final configuration is A1:0-1 & B1:1-2. As the 
>cpu lists overlap, we can't have both of them as valid partition roots. 
>So either one of A1 or B1 is valid or they are both invalid. The current 
>code makes them both invalid no matter the operation ordering.  This 
>patch will make one of them valid given the operation ordering above. To 
>minimize partition invalidation, we will have to live with the fact that 
>it will be first-come first-serve as noted by Michal. I am not against 
>this, we just have to document it. However, the following operation 
>order will still make both of them invalid:
>
># echo "0-1" >A1/cpuset.cpus # echo "2" > B1/cpuset.cpus # echo "1-2" > 
>B1/cpuset.cpus # echo "root" > A1/cpuset.cpus.partition # echo "root" > 
>B1/cpuset.cpus.partition
>
>To follow the "first-come first-serve" rule, A1 should be valid and B1 
>invalid. That is the inconsistency with your current patch. To fix that, 
>we still need to relax the overlap checking rule similar to your v4 patch.

Thank you for your suggestion! Will update.

Thanks,
Sun Shaojie

