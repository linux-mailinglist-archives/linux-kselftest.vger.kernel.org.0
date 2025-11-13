Return-Path: <linux-kselftest+bounces-45507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C2BC55900
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 04:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D8B3B858F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 03:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC40C2F7ADC;
	Thu, 13 Nov 2025 03:34:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F226A1C4;
	Thu, 13 Nov 2025 03:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004840; cv=none; b=kmzm6Xcy7ofMBeFFzQ8X+n9jrSDxA+PYgkRWwMbfQE7ULVNOOEYU1xCnRNtq0RvuxPLQuXWUGfPyGfLKQNal2epgeoVLQvijL1ChUGYnljkssIxgGyx0BWe1ZpszzsxywGYkUsUPsG1hyvQnRuZOtgTgWempInanXzfX2hG85f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004840; c=relaxed/simple;
	bh=1lz50uhiAgQq3i2dzjHKoezuauuoFa923Yl7yx8RnH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SW3WJ2qOqZ3ZNXSmch5zGaY1hMc3Sda3W4j8oA2BbCK4UhaGumUOUZ71EbsCqT6BXoOra20C89MuG7PzOU/wDoSV2OPmxFL/kScmVW3dKqvH5D2ufArudSDtrBlEyyi830uYJK55iwGTxnoGgGgu/qAsY8scQIrjDB29CNTtzpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8c017c84c04111f0a38c85956e01ac42-20251113
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:6e3acb6c-6b76-4c86-9752-9a0490c8b2a6,IP:20,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.6,REQID:6e3acb6c-6b76-4c86-9752-9a0490c8b2a6,IP:20,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:a9d874c,CLOUDID:bb1ed2f2e0d1bfd4aac28d672924011c,BulkI
	D:251112113325GOOOY919,BulkQuantity:9,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|102|841|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:n
	il,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,
	BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8c017c84c04111f0a38c85956e01ac42-20251113
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 622887929; Thu, 13 Nov 2025 11:33:40 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: chenridong@huaweicloud.com,
	longman@redhat.com
Cc: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1] cpuset: Avoid unnecessary partition invalidation
Date: Thu, 13 Nov 2025 11:33:22 +0800
Message-Id: <20251113033322.431859-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b9dce00a-4728-4ac8-ae38-7f41114c7c81@redhat.com>
References: <b9dce00a-4728-4ac8-ae38-7f41114c7c81@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025/11/13 09:21, Chen Ridong wrote:
>
>Hi, Longman.
>
>It did not fail to set cupset.cpus, but invalidated the sibling cpuset partition.
>
>If we relax this rule, we should consider:
>
>  What I want to note is this: what if we run echo root > /sys/fs/cgroup/B1/cpuset.cpus.partition
>after step #5? There’s no conflict check when enabling the partition.
>
>-- 
>Best regards,
>Ridong

Hi, Ridong.

I understand your concern, and there is a conflict check when enabling 
partitions. Below, I will use two tables to show the partition states of A1
and B1 before applying this patch and after applying it.(All the steps in 
the table are by default under the path /sys/fs/cgroup)

Table 1: Before applying the patch
                                            | A1's prstate | B1's prstate |
 #1> mkdir -p A1                            | member       |              |
 #2> echo "0-1" > A1/cpuset.cpus            | member       |              |
 #3> echo "root" > A1/cpuset.cpus.partition | root         |              |
 #4> mkdir -p B1                            | root         | member       |
 #5> echo "0-3" > B1/cpuset.cpus            | root invalid | member       |
 #6> echo "root" > B1/cpuset.cpus.partition | root invalid | root invalid |

Table 2: After applying the patch
                                            | A1's prstate | B1's prstate |
 #1> mkdir -p A1                            | member       |              |
 #2> echo "0-1" > A1/cpuset.cpus            | member       |              |
 #3> echo "root" > A1/cpuset.cpus.partition | root         |              |
 #4> mkdir -p B1                            | root         | member       |
 #5> echo "0-3" > B1/cpuset.cpus            | root         | member       |
 #6> echo "root" > B1/cpuset.cpus.partition | root         | root invalid |

As shown in Table 2, after step #6, B1's partition state becomes "root 
invalid". This confirms that conflict checks are performed when enabling 
partitions, and clearly, the check did not pass in this case. This is the 
expected result, since the CPUs (0-3) that B1 attempts to use exclusively 
conflict with those used by A1 (0-1).

The reviewer mentioned they couldn't see my original patch, so I'm 
re-quoting the key changes below for clarity:

>diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>index 52468d2c178a..e0d27c9a101a 100644
>--- a/kernel/cgroup/cpuset.c
>+++ b/kernel/cgroup/cpuset.c
>@@ -586,14 +586,14 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>  * Returns: true if CPU exclusivity conflict exists, false otherwise
>  *
>  * Conflict detection rules:
>- * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
>+ * 1. If both cpusets are exclusive, they must be mutually exclusive
>  * 2. exclusive_cpus masks cannot intersect between cpusets
>  * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
>  */
> static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
> {
>-	/* If either cpuset is exclusive, check if they are mutually exclusive */
>-	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>+	/* If both cpusets are exclusive, check if they are mutually exclusive */
>+	if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
> 		return !cpusets_are_exclusive(cs1, cs2);
> 
> 	/* Exclusive_cpus cannot intersect */

Here are the main changes, where the conflict check for step #6 in Table 2 
is performed. And these changes have no effect on cgroup v1.

Thanks,
Sun Shaojie

