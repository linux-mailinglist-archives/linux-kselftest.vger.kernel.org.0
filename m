Return-Path: <linux-kselftest+bounces-47367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5EDCB2A41
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 11:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7034030C128B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFC22E1C57;
	Wed, 10 Dec 2025 10:11:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FCC26CE1A;
	Wed, 10 Dec 2025 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765361511; cv=none; b=px1ZJeH4ViPAx0qish4yj88tH4eXDCx2GX6yLUAm4GnJAxTMXKV85coxkNTge81fzV4CB+RIMjcRiTRu0mUAWmyivmD21eHaNcC+cnQPdJgLlSiVMHh34ssB1DhNPzY9iWnyzyvOZ2rXfRrGnnS6RVtWzzF5G7l3oUANQ/RrnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765361511; c=relaxed/simple;
	bh=ZBtvFohVFvAiGt4O+rZ2mM2htrgfgswa/EWbtSPe06M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ON521xCqSRmrnOUFLJ3GABMdsR9Z6uiTK6WzRPZnmuK+euQAx3E6hDHxPklJtHuHpNHeE7zxe1d8b55n9y0UyIFM+z+OmiayxT7qDyDm89sVyvJEgFyD071BHacJl/b8R5hP6RoQQpT5h5zNbof0JUr2iJBdjZH6kBpzLB2hN1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9d685946d5b011f0a38c85956e01ac42-20251210
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
X-CID-O-INFO: VERSION:1.3.6,REQID:11509ef8-c9ee-4467-bf1b-74652f356481,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:11509ef8-c9ee-4467-bf1b-74652f356481,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:ab4f8f7777ea0ac8244219888cc63d6f,BulkI
	D:251119212056S6LKT8LY,BulkQuantity:27,Recheck:0,SF:17|19|64|66|78|80|81|8
	2|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:ni
	l,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,
	DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9d685946d5b011f0a38c85956e01ac42-20251210
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1913206352; Wed, 10 Dec 2025 18:11:38 +0800
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
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on cpuset.cpus conflict.
Date: Wed, 10 Dec 2025 18:11:08 +0800
Message-Id: <20251210101108.969603-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b3umm7mcucmztqqnp6x4e6ichqcml2r2bg7d2xairxajyqrzbt@3nshatmt2evo>
References: <b3umm7mcucmztqqnp6x4e6ichqcml2r2bg7d2xairxajyqrzbt@3nshatmt2evo>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Michal,

On Mon, 8 Dec 2025 15:31:52 +0100, Michal Koutný wrote:
>>>   root cgroup
>>>        |
>>>       A1  //MK: A4 A5 here?
>>>      /  \
>>>    A2    A3... //MK: A4 A5 or here?
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
>>If A2...A5 all belong to the same user, and that user wants both A4 and A5 
>>to have effective CPUs, then the user should also understand that A2 needs
>>to be adjusted to "member" instead of "root".
>>
>>if A2...A5 belong to different users, must satisfying user A4’s requirement
>>come at the expense of user A2’s requirement? That is not fair.
>
>If A4 is a sibling at the level of A1, then A2 must be stripped of its
>CPUs to honor the hierarchy hence the apparent unfairness.
>
>If A4 is a sibling at the level of A2 and they have different owning
>users, their respective cpuset.cpus should only be writable by A1's user
>(the one who distributes the cpus) so that any arbitration between the
>siblings is avoided.

Regardless of whether A1 through A5 belong to the same user or different
users, arbitration conflicts between sibling nodes can still occur (e.g.,
due to user misconfiguration). The key question is: when such a conflict
arises, should all sibling nodes be invalidated, or only the node that
triggered the conflict?

Thanks,
Sun Shaojie

