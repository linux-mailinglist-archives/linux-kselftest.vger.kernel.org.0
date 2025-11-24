Return-Path: <linux-kselftest+bounces-46373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F486C7FD7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 11:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51502342907
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 10:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA272701CF;
	Mon, 24 Nov 2025 10:20:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F352273D73;
	Mon, 24 Nov 2025 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763979655; cv=none; b=owOqqiG1Z2cx9VJ/piPH3QK/F+RwJx1mvy9BPQVbbs0pKKFz6JZkhjcH91nKxd0feu7zeuOxdNzDay/U4awUrcIiggIZIPkNbNryp5E6rcb/YgQomOKZzDVYIvdUn2TcOmCus7GCcKhN/XoFTjo+ce5pqA6o31wGntZ9uAVwYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763979655; c=relaxed/simple;
	bh=yBPbrc6yanNpRBRanmbCAqwAvYkBptUgMi6NPa2rBBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XlwkQmchXPcyNnTAm5VwyRMEkWS7x5FM/hINDcZvhsu/cBDW/2kP/mbz3p8IujUzDPipCkAYLKYJPMzSpmSoGKq/atyIINUml5MXmDZHqm3b6Z+xjmM75o/5XU/30nfn97Wv2mgui0d7d6QVCTiI7ageL7BdcEDZydPmd7zsoA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3c2c8b5ec91f11f0a38c85956e01ac42-20251124
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
X-CID-O-INFO: VERSION:1.3.6,REQID:2620ca22-1297-4fea-8aba-09cf96c01afc,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:2620ca22-1297-4fea-8aba-09cf96c01afc,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:e2764fefa5e5d9639c2f266fc6367977,BulkI
	D:251119212056S6LKT8LY,BulkQuantity:12,Recheck:0,SF:17|19|64|66|78|80|81|8
	2|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:ni
	l,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,
	DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3c2c8b5ec91f11f0a38c85956e01ac42-20251124
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 770263895; Mon, 24 Nov 2025 18:20:43 +0800
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
Date: Mon, 24 Nov 2025 18:20:24 +0800
Message-Id: <20251124102024.1768386-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0c409964-c4aa-4d41-aae5-cd0626015eeb@huaweicloud.com>
References: <0c409964-c4aa-4d41-aae5-cd0626015eeb@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Ridong,

On Sat, 22 Nov 2025 09:33:34, Chen Ridong wrote:
>On 2025/11/21 18:32, Sun Shaojie wrote:
>> Hi, Ridong,
>> 
>> On Thu, 20 Nov 2025 21:45:16, Chen Ridong wrote:
>>> On 2025/11/20 21:07, Sun Shaojie wrote:
>>>> I have carefully considered the scenario where parent effective CPUs are 
>>>> empty, which corresponds to the following two cases. (After apply this patch).
>>>>
>>>>    root cgroup
>>>>         |
>>>>        A1
>>>>       /  \
>>>>     A2    A3
>>>>
>>>> Case 1:
>>>>  Step:
>>>>  #1> echo "0-1" > A1/cpuset.cpus
>>>>  #2> echo "root" > A1/cpuset.cpus.partition
>>>>  #3> echo "0-1" > A2/cpuset.cpus
>>>>  #4> echo "root" > A2/cpuset.cpus.partition
>>>>
>>>>  After step #4, 
>>>>
>>>>                 |      A1      |      A2      |      A3      |
>>>>  cpus_allowed   | 0-1          | 0-1          |              |
>>>>  effective_cpus |              | 0-1          |              |
>>>>  prstate        | root         | root         | member       |
>>>>
>>>>  After step #4, A3's effective CPUs is empty.
>>>>
>>>
>>> That may be a corner case is unexpected.
>>>
>>>>  #5> echo "0-1" > A3/cpuset.cpus
>>>>
>>>
>>> If we create subdirectories (e.g., A4, A5, ...) under the A1 cpuset and then configure cpuset.cpus
>>> for A1 (a common usage scenario), processes can no longer be migrated into these subdirectories (A4,
>>> A5, ...) afterward. However, prior to your patch, this migration was allowed.
>> 
>> Are you referring to creating subdirectories (A4, A5, ...) after step #4? 
>> And what parameters should be configured for A1's cpuset.cpus?
>> Could you provide a specific example?
>> 
>
> #1> echo "0-1" > A1/cpuset.cpus
> #2> echo "root" > A1/cpuset.cpus.partition
> #3> echo "0-1" > A2/cpuset.cpus
> #4> echo "root" > A2/cpuset.cpus.partition
> mkdir A4
> mkdir A5
> echo "0" > A4/cpuset.cpus
> echo $$ > A4/cgroup.procs
> echo "1" > A5/cpuset.cpus
> echo $$ > A5/cgroup.procs
>
>You might be going to argue that we haven't set the cpus for A4/A5..., yeah, maybe a corner case.
>
>However, it’s common practice to configure a cpuset’s cpus first and then migrate processes—this is
>a typical usage scenario.
>

I'm sorry, I didn't quite understand the point you were trying to make with this example.

If that's the case

     root cgroup
          |
          A1
       / /  \ \
     A2 A3  A4 A5

 #1> echo "0-1" > A1/cpuset.cpus
 #2> echo "root" > A1/cpuset.cpus.partition
 #3> echo "0-1" > A2/cpuset.cpus
 #4> echo "root" > A2/cpuset.cpus.partition
 mkdir A4
 mkdir A5
 echo "0" > A4/cpuset.cpus
 echo $$ > A4/cgroup.procs  ->This will return an error because A4's effective CPUs are empty.
 echo "1" > A5/cpuset.cpus
 echo $$ > A5/cgroup.procs  ->This will return an error because A5's effective CPUs are empty.

Even with this patch applied, this result will not change.

>
>> Additionally, processes cannot be migrated into a cgroup whose 
>> cpuset.cpus.effective is empty. However, this patch does not modify this behavior.
>> 
>> So why does applying this patch enable such migration?

Thanks,
Sun Shaojie

