Return-Path: <linux-kselftest+bounces-46207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADAFC78892
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 11:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3DD9E3422CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE64633468E;
	Fri, 21 Nov 2025 10:33:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE46343D84;
	Fri, 21 Nov 2025 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763721214; cv=none; b=HLILToOnBxg/6VXalBevSe46x46hzVpTinnYXsglen2i9Nr7oxZ3B9N9q+57+MhIU633qUYO7k+ZpWusgxISjFm3bL39kO1XFc4+CadQCNDYQ/QL3rlIdNQs7bNrEcV9yjPW0aFchF/BZE0nMfdFLDpB6d/avWreTegfCcE7sH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763721214; c=relaxed/simple;
	bh=fMDFiMyccWuhI925bLZAudlsIkbm/097exlMgJqk29E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RBrZzc7rUoqFDszeuo+YKw3v+t6P2YDtpBlL3lnknq+ILDG1+aAhaYP/X6ooU4fWdZoPV5hmd+1CEw2BQC8O7IRXWS1RBwjzXsGR/hSzd8m6P0lWAoaHLEbNpDrZ4/w8D0XjkorMYfelHWJ5s1PtQ8QqSST5A2OKzVvbJ+36K2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 824bc1cec6c511f0a38c85956e01ac42-20251121
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
X-CID-O-INFO: VERSION:1.3.6,REQID:ca83a6ca-31e0-4cb0-806f-d91fc2ff5ded,IP:20,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.6,REQID:ca83a6ca-31e0-4cb0-806f-d91fc2ff5ded,IP:20,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:a9d874c,CLOUDID:5ab46968e88c4ec638994fe16a6179a2,BulkI
	D:251119212056S6LKT8LY,BulkQuantity:9,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 824bc1cec6c511f0a38c85956e01ac42-20251121
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 62174813; Fri, 21 Nov 2025 18:33:24 +0800
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
Date: Fri, 21 Nov 2025 18:33:08 +0800
Message-Id: <20251121103308.1661628-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <37f4b54d-609c-4754-bfa2-51b1ddf43df0@huaweicloud.com>
References: <37f4b54d-609c-4754-bfa2-51b1ddf43df0@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Ridong,

Thu, 20 Nov 2025 21:25:12, Chen Ridong wrote:
>On 2025/11/20 21:07, Sun Shaojie wrote:
>> I don't understand the "order of operations" mentioned here. After reviewing
>> the previous email content, are you referring to this?
>> 
>> On Sat, 15 Nov 2025 15:41:03, Chen Ridong wrote:
>>> With the result you expect, would we observe the following behaviors:
>>>
>>> #1> mkdir -p A1
>>> #2> mkdir -p B1
>>> #3> echo "0-1"  > A1/cpuset.cpus
>>> #4> echo "1-2"  > B1/cpuset.cpus
>>> #5> echo "root" > A1/cpuset.cpus.partition
>>> #6> echo "root" > B1/cpuset.cpus.partition # A1:root;B1:root invalid
>>>
>>> #1> mkdir -p A1
>>> #2> mkdir -p B1
>>> #3> echo "0-1"  > A1/cpuset.cpus
>>> #4> echo "1-2"  > B1/cpuset.cpus
>>> #5> echo "root" > B1/cpuset.cpus.partition
>>> #6> echo "root" > A1/cpuset.cpus.partition # A1:root invalid;B1:root
>>>
>>> Do different operation orders yield different results? If so, this is not what we expect.
>> 
>> However, after applying this patch, the outcomes of these two examples are 
>> as follows:
>>  
>>  #1> mkdir -p A1
>>  #2> mkdir -p B1
>>  #3> echo "0-1"  > A1/cpuset.cpus           | member       | member      |
>>  #4> echo "1-2"  > B1/cpuset.cpus           | member       | member      |
>>  #5> echo "root" > A1/cpuset.cpus.partition | root invalid | root        |
>>  #6> echo "root" > B1/cpuset.cpus.partition | root invalid | root invalid|
>> 
>>  #1> mkdir -p A1
>>  #2> mkdir -p B1
>>  #3> echo "0-1"  > A1/cpuset.cpus           | member       | member      |
>>  #4> echo "1-2"  > B1/cpuset.cpus           | member       | member      |
>>  #5> echo "root" > B1/cpuset.cpus.partition | root         | root invalid|
>>  #6> echo "root" > A1/cpuset.cpus.partition | root invalid | root invalid|
>> 
>
>How about the following two sequences of operations:
>
>#1> mkdir -p A1
>#2> mkdir -p B1
>#3> echo "0-1"  > A1/cpuset.cpus
>#4> echo "root" > A1/cpuset.cpus.partition
>#5> echo "1-2"  > B1/cpuset.cpus
>#6> echo "root" > B1/cpuset.cpus.partition
>
>
>#1> mkdir -p A1
>#2> mkdir -p B1
>#5> echo "1-2"  > B1/cpuset.cpus
>#6> echo "root" > B1/cpuset.cpus.partition
>#3> echo "0-1"  > A1/cpuset.cpus
>#4> echo "root" > A1/cpuset.cpus.partition
>
>Will these two sequences yield the same result?

>As a key requirement: Regardless of the order in which we apply the configurations, identical final
>settings should always result in identical system states. We need to confirm if this holds true here.

Is this truly a key requirement? It appears this requirement wasn't met even
before applying my patch.

The example below, which does not use this patch, demonstrates how different
sequences with identical configurations can still lead to different system
states.

 #1> mkdir -p A1
 #2> mkdir -p B1                            | A1's prstate | B1's prstate |
 #3> echo "0-1"  > A1/cpuset.cpus           | member       | member       |
 #4> echo "0-1"  > A1/cpuset.cpus.exclusive | member       | member       |
 #5> echo "root" > A1/cpuset.cpus.partition | root         | member       |
 #6> echo "1-2"  > B1/cpuset.cpus           | root invalid | member       |
 #7> echo "2-3"  > B1/cpuset.cpus.exclusive | root invalid | member       |
 #8> echo "root" > B1/cpuset.cpus.partition | root invalid | root         |

 #1> mkdir -p A1
 #2> mkdir -p B1                            | A1's prstate | B1's prstate |
 #3> echo "0-1"  > A1/cpuset.cpus           | member       | member       |
 #4> echo "0-1"  > A1/cpuset.cpus.exclusive | member       | member       |
 #5> echo "2-3"  > B1/cpuset.cpus.exclusive | member       | member       |
 #6> echo "root" > A1/cpuset.cpus.partition | root         | member       |
 #7> echo "1-2"  > B1/cpuset.cpus           | root         | member       |
 #8> echo "root" > B1/cpuset.cpus.partition | root         | root         |

Even without this patch, the result can still differ.


Thanks,
Sun Shaojie

