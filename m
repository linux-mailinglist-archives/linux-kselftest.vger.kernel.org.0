Return-Path: <linux-kselftest+bounces-46787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AF6C966E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 10:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2411E3A2558
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84F7301716;
	Mon,  1 Dec 2025 09:45:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CCB3016E3;
	Mon,  1 Dec 2025 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582305; cv=none; b=E6IIlcyY2EvMu7/awncxREAw3hI5eHSKkwgypNtYyIQRm8vy7rBj0cFqwvw0+8F0tWnywTCUnpoD447WF/UawncqJ2f+JT5gVVOKGoHvSEI23FDUtMMq/7t1/ul3pAr3b04aQtemWvDX7yQWLQfHNfoIQr/PmmPp+foiD6bm070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582305; c=relaxed/simple;
	bh=4XVEzB5zcXbD3mQxMCq3CKilOGlWuxPaM1ZHUOnCvUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtXp7PCsGyIHuvezPPdr2NOUKzIHBs18kvSHRRppg/jlmakwyqKP7znoE9ujGfyP2E1+06l5B2YYIJyv/3VD5Rx+QyDcM5pNZk3KUeVsPni0EC4O5iF6y55DQUB+zaZsE9F/AQezxSSEdHMp/vdqOZkZ0XzEK8kBQSwO62otl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6443bfbace9a11f0a38c85956e01ac42-20251201
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ca7bf2b2-3734-47b3-bf85-dcf155affa40,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:ca7bf2b2-3734-47b3-bf85-dcf155affa40,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:e7f97df87a10049f3beda36d7db7b00c,BulkI
	D:251119212056S6LKT8LY,BulkQuantity:24,Recheck:0,SF:17|19|64|66|78|80|81|8
	2|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:ni
	l,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,
	DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6443bfbace9a11f0a38c85956e01ac42-20251201
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 974515596; Mon, 01 Dec 2025 17:44:55 +0800
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
Date: Mon,  1 Dec 2025 17:44:47 +0800
Message-Id: <20251201094447.108278-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <45f5e2c6-42ec-4d77-9c2d-0e00472a05de@huaweicloud.com>
References: <45f5e2c6-42ec-4d77-9c2d-0e00472a05de@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Ridong,

On Thu, 27 Nov 2025 09:55:21, Chen Ridong wrote:
>I have to admit that I prefer the current implementation.
>
>At the very least, it ensures that all partitions are treated fairly[1]. Relaxing this rule would
>make it more difficult for users to understand why the cpuset.cpus they configured do not match the
>effective CPUs in use, and why different operation orders yield different results.

As for "different operation orders yield different results", Below is an
example that is not a corner case.

    root cgroup
      /    \
     A1    B1

 #1> echo "0" > A1/cpuset.cpus
 #2> echo "0-1" > B1/cpuset.cpus.exclusive --> return error

 #1> echo "0-1" > B1/cpuset.cpus.exclusive
 #2> echo "0" > A1/cpuset.cpus

>
>In another scenario, if we do not invalidate the siblings, new leaf cpusets (marked as member)
>created under A1 will end up with empty effective CPUs—and this is not a desired behavior.
>
>   root cgroup
>        |
>       A1
>      /  \
>    A2    A3...
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

If A2...A5 all belong to the same user, and that user wants both A4 and A5 
to have effective CPUs, then the user should also understand that A2 needs
to be adjusted to "member" instead of "root".

if A2...A5 belong to different users, must satisfying user A4’s requirement
come at the expense of user A2’s requirement? That is not fair.

>
>[1]: "B1 is a second-class partition only because it starts later or why is it OK to not fulfill its
>requirement?" --Michal.

Thanks,
Sun Shaojie

