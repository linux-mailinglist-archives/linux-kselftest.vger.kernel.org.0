Return-Path: <linux-kselftest+bounces-46936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 709A0C9EE9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 12:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4366034AA22
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 11:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B2E2F6170;
	Wed,  3 Dec 2025 11:57:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DEE2DCC06;
	Wed,  3 Dec 2025 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764763045; cv=none; b=kI2ATWSHrsHqc6sca3Yk8b08ZMPkxsks0G2Ippw5N3E2/75uy0KSqMUTxfjiMO+yH7lGvmbLA6T4D/+UcPmX+wiG39f+4lPCVXSqoPQaMBhSoceJWnAUDG+LbmqqSkIwLkApruUQ/0f7n1lc4+DH1hFyH1WbYaf5d8c4MPerXwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764763045; c=relaxed/simple;
	bh=SQQ7b4hMKz35yJjZthTVAH7r0aAdlzv6Bd2RZJF0kLY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=N405Tzr07FM3rT7v43/I2kkkH/tAxSSKCxgw5cFWN3VsL076Tr7TAls/4xF2t7m0bDH/bOpb1QxiIIYwVpLtBpLWGIBIOSyKNa0O9VY59qoV75jJXVmq+wyJzfN1A4kfQPuIyw2WKauq0cZcByjLIqyZ/3sguOTlPJX1CIXpeHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2e8cd32ed03f11f0a38c85956e01ac42-20251203
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:1f63d534-3ad7-4486-b2a6-722f38e3e2ba,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:1f63d534-3ad7-4486-b2a6-722f38e3e2ba,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:0ae958454a45d2f48fefce17dc0a4c5d,BulkI
	D:2512031957094HW49S03,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2e8cd32ed03f11f0a38c85956e01ac42-20251203
X-User: zhangguopeng@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1478738078; Wed, 03 Dec 2025 19:57:03 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	roman.gushchin@linux.dev,
	lance.yang@linux.dev,
	shakeel.butt@linux.dev
Cc: muchun.song@linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH v5 0/3] selftests: cgroup: Enhance robustness with polling helpers
Date: Wed,  3 Dec 2025 19:56:28 +0800
Message-Id: <20251203115631.947908-1-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This patch series introduces improvements to the cgroup selftests by adding
a helper function to better handle asynchronous updates in cgroup statistics.
These changes are especially useful for managing cgroup stats like
memory.stat and cgroup.stat, which can be affected by delays (e.g., RCU
callbacks and asynchronous rstat flushing).

Patch 1/3 adds cg_read_key_long_poll(), a generic helper to poll a numeric
key in a cgroup file until it reaches an expected value or a retry limit is
hit. Patches 2/3 and 3/3 convert existing tests to use this helper, making
them more robust on busy systems.

v5:
 - Drop the "/* 3s total */" comment from MEMCG_SOCKSTAT_WAIT_RETRIES as
   suggested by Shakeel, so it does not become stale if the wait interval
   changes.
 - Elaborate in the commit message of patch 3/3 on the rationale behind the
   8s timeout in test_kmem_dead_cgroups(), and add a comment next to
   KMEM_DEAD_WAIT_RETRIES explaining that it is a generous upper bound
   derived from stress testing and not tied to a specific kernel constant.
 - Add Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev> to this series.
 - Link to v4: https://lore.kernel.org/all/20251124123816.486164-1-zhangguopeng@kylinos.cn/

v4:
 - Patch 1/3: Add the cg_read_key_long_poll() helper to poll cgroup keys
   with retries and configurable intervals.
 - Patch 2/3: Update test_memcg_sock() to use cg_read_key_long_poll() for
   handling delayed "sock " counter updates in memory.stat.
 - Patch 3/3: Replace the sleep-and-retry logic in test_kmem_dead_cgroups()
   with cg_read_key_long_poll() for waiting on nr_dying_descendants.
 - Link to v3: https://lore.kernel.org/all/p655qedqjaakrnqpytc6dltejfluxo6jrffcltfz2ivonmk6lb@bxf5xlgo4iw2/

v3:
 - Move MEMCG_SOCKSTAT_WAIT_* defines after the #include block as suggested.
 - Link to v2: https://lore.kernel.org/all/5ad2b75f-748a-4e93-8d11-63295bda0cbf@linux.dev/

v2:
 - Clarify the rationale for the 3s timeout and mention the periodic rstat
   flush interval (FLUSH_TIME = 2 * HZ) in the comment.
 - Replace hardcoded retry count and wait interval with macros to avoid
   magic numbers and make the timeout calculation explicit.
 - Link to v1: https://lore.kernel.org/all/20251119122758.85610-1-ioworker0@gmail.com/

Thanks to Michal Koutný for the suggestion, and to Lance Yang and Shakeel Butt for their reviews and feedback.

Guopeng Zhang (3):
  selftests: cgroup: Add cg_read_key_long_poll() to poll a cgroup key
    with retries
  selftests: cgroup: make test_memcg_sock robust against delayed sock
    stats
  selftests: cgroup: Replace sleep with cg_read_key_long_poll() for
    waiting on nr_dying_descendants

 .../selftests/cgroup/lib/cgroup_util.c        | 21 ++++++++++++
 .../cgroup/lib/include/cgroup_util.h          |  5 +++
 tools/testing/selftests/cgroup/test_kmem.c    | 33 +++++++++----------
 .../selftests/cgroup/test_memcontrol.c        | 20 ++++++++++-
 4 files changed, 60 insertions(+), 19 deletions(-)

-- 
2.25.1


