Return-Path: <linux-kselftest+bounces-45970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CBFC6E265
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 12:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 165FD4F244F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDEB2E6CB6;
	Wed, 19 Nov 2025 11:05:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531334E75A;
	Wed, 19 Nov 2025 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763550305; cv=none; b=G2y9kRu5nodmdzSQ6UhSuyu26VQn7YKfO/yE1kL1tDk7v+uzMm8PadvmvcNwLm2+1UdiXfPBNyGSxceHIdTUq0mLXtGPS9m5yTATUO62kxRDcGi95oiam6OksdcBEeQayBntX4wXB5E28bIoUsG6tpLeJi7Fqchz7oYHC0KmrsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763550305; c=relaxed/simple;
	bh=DowB7Bu+Be5hdLdLY9hNNyub8IZrw7Y4+2+cQBG4qjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmIS2kp3GIlQz4un6mbfcs6YzJhX9bjTLWyU8w7QeAT3/That4rs5KH0wvbAcD6MtnxIhYvB8aSUTEmMLl4a478LJRLmzqM0rfI2b8uBCH5oFOJlBojGs8llHmx5hNRAlbgEpcnpowJnqyKmvCG++E83I+Y6P5VXjdSWq/ZD/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 93cc65aac53711f0a38c85956e01ac42-20251119
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_FG_IT, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:12424509-c462-48e1-8ad0-95396a709c9e,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:12424509-c462-48e1-8ad0-95396a709c9e,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:5f25ec8ca44b0e112c6ea7e5d70e176a,BulkI
	D:251117180100BIUI482W,BulkQuantity:5,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|841|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:n
	il,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,
	BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 93cc65aac53711f0a38c85956e01ac42-20251119
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1555944802; Wed, 19 Nov 2025 19:04:54 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	chenridong@huaweicloud.com,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llong@redhat.com,
	shuah@kernel.org,
	sunshaojie@kylinos.cn,
	tj@kernel.org
Subject: Re: [PATCH v4 1/1] cpuset: relax the overlap check for cgroup-v2
Date: Wed, 19 Nov 2025 19:04:43 +0800
Message-Id: <20251119110443.1386951-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <mcpsxwjouoxfgdoqbysxlvjrgx7m2475y75fhssz4uoryb3jqj@lnigmwq7nage>
References: <mcpsxwjouoxfgdoqbysxlvjrgx7m2475y75fhssz4uoryb3jqj@lnigmwq7nage>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Michal,

On Tue, 18 Nov 2025 18:52:24 +0100, Michal Koutný wrote:
>On Mon, Nov 17, 2025 at 09:57:08AM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
>> This patch ensures that for sibling cpusets A1 (exclusive) and B1
>> (non-exclusive), change B1 cannot affect A1's exclusivity.
>> 
>> for example. Assume a machine has 4 CPUs (0-3).
>> 
>>    root cgroup
>>       /    \
>>     A1      B1
>> 
>> Case 1:
>>  Table 1.1: Before applying the patch
>>  Step                                       | A1's prstate | B1'sprstate |
>>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
>>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      |
>>  #3> echo "0" > B1/cpuset.cpus              | root invalid | member      |
>> 
>> After step #3, A1 changes from "root" to "root invalid" because its CPUs
>> (0-1) overlap with those requested by B1 (0-3). However, B1 can actually
>> use CPUs 2-3(from B1's parent), so it would be more reasonable for A1 to
>> remain as "root."
>> 
>>  Table 1.2: After applying the patch
>>  Step                                       | A1's prstate | B1'sprstate |
>>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
>>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      |
>>  #3> echo "0" > B1/cpuset.cpus              | root         | member      |
>
>OK, this looks fine to me, based on this statement from the docs about
>cpuset.cpus.effective:
>
>>  subset of "cpuset.cpus" unless none of the CPUs listed in "cpuset.cpus"
>>  can be granted.  In this case, it will be treated just like an empty
>>  "cpuset.cpus".
>
>I was likely confused by the eventual switch of B1 to root in your
>previous example.
>(Because if you continue, it should result in (after patch too):
>  #4> echo "root" > B1/cpuset.partition       | root invalid  | root invalid |
>and end state should be invariant wrt A1,B1 or B1,A1 config order.)

This patch is based on a version after v6.18.0-rc5.
Whether or not this patch is applied, modifications to cpuset.partition do not
affect the state of sibling partitions.

If continue, the result should be as follows:
 #4> echo "root" > B1/cpuset.partition       | root         | root invalid |

I've updated patch v5 with some new ideas and look forward to your feedback.

patch v5 : https://lore.kernel.org/cgroups/20251119105749.1385946-1-sunshaojie@kylinos.cn/

Thanks,
Sun Shaojie

