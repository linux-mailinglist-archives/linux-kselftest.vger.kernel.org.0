Return-Path: <linux-kselftest+bounces-45692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D90C603CD
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 12:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46EE3BBD87
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 11:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BACD258ECA;
	Sat, 15 Nov 2025 11:25:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66880257843;
	Sat, 15 Nov 2025 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763205920; cv=none; b=DNT1SPlWsz/m5P/HOGC6OImfOhDEAo3VCQM9Vzd46FfXJy7raiG6SDMb5/V+QunIS1Z43HWieaCxcEGUfTucw1Tcfalo42QJYtVxGN/qQfEZpWsBClIrhl/EXDfRADqd5qqvIQBlE64TyzSn18PGde3Rw9siGgLS3VZxwR8QBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763205920; c=relaxed/simple;
	bh=HOAgnmwlweNEvVPrLsxOwlt1uM4M/KjHmrkM5QAuZpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRCT+3lSnFaL9naI5//lkBHTNkkWn80YzcguPAB7FZ6Zir0/qSXlBQyB4TpB5bztYYS7iB1TdjrhK/w8dzNvyiVdr60uy10kWsrPNcvd75qaUEm9U0Ry1xX0JLOPqsdbjmbfqFecEhCVQkQhHqPlUlW5bukWG/2Eirc+VJ37d7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bc208b32c21511f0a38c85956e01ac42-20251115
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:43b85a57-5df2-4ff9-9aa0-30fa6e54850d,IP:20,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.6,REQID:43b85a57-5df2-4ff9-9aa0-30fa6e54850d,IP:20,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:a9d874c,CLOUDID:1cbb6708e1e82d7bc667778fc4d70487,BulkI
	D:251113225812EYOJ6GI2,BulkQuantity:15,Recheck:0,SF:17|19|64|66|78|80|81|8
	2|83|102|841|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil
	,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BR
	R:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bc208b32c21511f0a38c85956e01ac42-20251115
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 63388585; Sat, 15 Nov 2025 19:25:05 +0800
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
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
Date: Sat, 15 Nov 2025 19:24:53 +0800
Message-Id: <20251115112453.875799-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4b7znoqq6sdtutcn3jafyrucpqe5jylryvoeooz5ah54vbei4f@wxhsd7gkj3tp>
References: <4b7znoqq6sdtutcn3jafyrucpqe5jylryvoeooz5ah54vbei4f@wxhsd7gkj3tp>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025/11/15 0:15, Michal Koutný wrote:
>On Fri, Nov 14, 2025 at 02:24:48PM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
>> The desired outcome is that after step #5, although B1 writes "0-3" to 
>> cpuset.cpus, A1 can still remain as "root", and B1 ends up with effective 
>> CPUs of 2-3. In summary, We want to avoid A1's invalidation when B1 
>> changes its cpuset.cpus. Because cgroup v2 allows the effective CPU mask 
>> of a cpuset to differ from its requested mask.
>
>So the new list of reasons why configured cpuset's cpus change are:
>- hotplug,
>- ancestor's config change,
>- stealing by a sibling (new).
>
>IIUC, the patch proposes this behavior:
>
>  echo root >A1.cpuset.partition
>  echo 0-1 >A1.cpuset.cpus
>  
>  echo root >B1.cpuset.partition
>  echo 1-2 >B1.cpuset.cpus	# invalidates A1
>  
>  echo 0-1 >A1.cpuset.cpus	# invalidates B1
>  
>  ping-pong over CPU 1 ad libitum
>
>I think the right (tm) behavior would be not to depend on the order in
>which config is applied to siblings, i.e.
>
>  echo root >A1.cpuset.partition
>  echo 0-1 >A1.cpuset.cpus
>  
>  echo root >B1.cpuset.partition
>  echo 1-2 >B1.cpuset.cpus	# invalidates both A1 and B1
>
>  echo 0-1 >A1.cpuset.cpus	# no change anymore
>
>(I hope my example sheds some light on my understanding of the situation
>and desired behavior.)

Hi, Michal

The current patch is flawed and will be fixed in patch v3. However, the 
example you provided also has issues. Below, I’ll explain your example.

Table 1: current result for your example 1.
 Step                                | A1's prstate | B1's prstate |
 #1> echo root > A1.cpuset.partition | root invalid |              |
 #2> echo 0-1 > A1.cpuset.cpus       | root         |              |
 #3> echo root > B1.cpuset.partition | root         | root invalid |
 #4> echo 1-2 > B1.cpuset.cpus       | root invalid | root invalid |
 #5> echo 0-1 >A1.cpuset.cpus        | root invalid | root invalid |

After step #4, both A1 and B1 are already in the "root invalid" state.
Therefore, B1 becoming "root invalid" is not caused by step #5, but was 
already in the "root invalid" state from the beginning.

Table 2: this is my expected result 
 Step                                | A1's prstate | B1's prstate |
 #1> echo root > A1.cpuset.partition | root invalid |              |
 #2> echo 0-1 > A1.cpuset.cpus       | root         |              |
 #3> echo root > B1.cpuset.partition | root         | root invalid |
 #4> echo 1-2 > B1.cpuset.cpus       | root         | root invalid |
 #5> echo 0-1 >A1.cpuset.cpus        | root         | root invalid |

If A1 is "root", and B1 is not "root", Our goal is to ensure that B1's 
behavior does not affect the "root" state of A1. Similarly, when B1's 
"cpuset.cpus.effective" is non-empty, we strive to ensure A1's own behavior
does not affect its "root" state as much as possible.

In summary, the purpose of submitting this patch is to ensure that, when 
only one of A1 and B1 is "root", the actions of one party do not affect the
"root" state of the other.

Thanks,
Sun Shaojie


