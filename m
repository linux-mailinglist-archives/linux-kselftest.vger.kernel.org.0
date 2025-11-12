Return-Path: <linux-kselftest+bounces-45393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E322C5172E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 10:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B259C188222E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 09:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B4E2EBBA8;
	Wed, 12 Nov 2025 09:46:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30155280025;
	Wed, 12 Nov 2025 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940792; cv=none; b=kFHyCU61G94c4g6Rixxaq4ZYK9vyZiv9W7wVTxcNNcV98aZAkyCudkEzQst0fm7r9TllohIgl6GB9C/jckdd47Ew/JNYMGk0a12n3vcrSqawW/fo2x6StN3QAXfeRJFeR2kN488opYrRdc2XzM8VAfir7DEDte9bauhC8ksYDc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940792; c=relaxed/simple;
	bh=PGXH5ZNoFVU82DUBUYg+wC+o3Hx+ymercUt+UTpMI1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TISkpKhLdoPdnLs0EjMZRLAxRMloZ3qFBkEZ3OKeukZPvqw14kJL9ga5YiIEjiQSIEZisQ3OWhs6/JVdxsFGiAMNOi5IA+YpwMFln+csOd0HW1NLZFS4jrpd0+GcM6UnlV7/jRuQhxEPj5KedgjvEVqsR+gbtyuzj1YDESYKa7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 72334534bfac11f0a38c85956e01ac42-20251112
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:b558790b-f5d3-4cf6-8624-8aab05f4ddb0,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-INFO: VERSION:1.3.6,REQID:b558790b-f5d3-4cf6-8624-8aab05f4ddb0,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
	lease,TS:15
X-CID-META: VersionHash:a9d874c,CLOUDID:7b4bb5ea26bfdafd5716007837c7b4a6,BulkI
	D:251112113325GOOOY919,BulkQuantity:2,Recheck:0,SF:19|66|72|78|81|82|83|10
	2|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 72334534bfac11f0a38c85956e01ac42-20251112
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1424881545; Wed, 12 Nov 2025 17:46:21 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: chenridong@huaweicloud.com
Cc: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1] cpuset: Avoid unnecessary partition invalidation
Date: Wed, 12 Nov 2025 17:46:10 +0800
Message-Id: <20251112094610.386299-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b9dce00a-4728-4ac8-ae38-7f41114c7c81@redhat.com>
References: <b9dce00a-4728-4ac8-ae38-7f41114c7c81@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ridong,

Thank you for your response.

From your reply "in case 1, A1 can also be converted to a partition," I 
realize there might be a misunderstanding. The scenario I'm addressing 
involves two sibling cgroups where one is an effective partition root and 
the other is not, and both have empty cpuset.cpus.exclusive. Let me 
explain the intention behind case 1 in detail, which will also illustrate 
why this has negative impacts on our product.

In case 1, after #3 completes, A1 is already a valid partition root - this 
is correct.After #4, B1 was generated, and B1 is no-exclusive. After #5, 
A1 changes from "root" to "root invalid". But A1 becoming "root invalid" 
could be unnecessary because having A1 remain as "root" might be more 
acceptable. Here's the analysis:

As documented in cgroup-v2.rst regarding cpuset.cpus: "The actual list of 
CPUs to be granted, however, is subjected to constraints imposed by its 
parent and can differ from the requested CPUs". This means that although 
we're requesting CPUs 0-3 for B1, we can accept that the actual available 
CPUs in B1 might not be 0-3.

Based on this characteristic, in our product's implementation for case 1, 
before writing to B1's cpuset.cpus in #5, we check B1's parent 
cpuset.cpus.effective and know that the CPUs available for B1 don't include 
0-1 (since 0-1 are exclusively used by A1). However, we still want to set 
B1's cpuset.cpus to 0-3 because we hope that when 0-1 become available in 
the future, B1 can use them without affecting the normal operation of other 
cgroups.

The reality is that because B1's requested cpuset.cpus (0-3) conflicts with 
A1's exclusive CPUs (0-1) at that moment, it destroys the validity of A1's 
partition root. So why must the current rule sacrifice A1's validity to 
accommodate B1's CPU request? In this situation, B1 can clearly use 2-3 
while A1 exclusively uses 0-1 - they don't need to conflict.

This patch narrows the exclusivity conflict check scope to only between 
partitions. Moreover, user-specified CPUs (including cpuset.cpus and 
cpuset.cpus.exclusive) only have true exclusive meaning within effective 
partitions. So why should the current rule perform exclusivity conflict 
checks between an exclusive partition and a non-exclusive member? This is 
clearly unnecessary.

Thanks
Sun Shaojie

