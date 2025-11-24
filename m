Return-Path: <linux-kselftest+bounces-46383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6E9C80806
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 13:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C69CD346B47
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DBE3002A3;
	Mon, 24 Nov 2025 12:39:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210422FFF9B;
	Mon, 24 Nov 2025 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763987955; cv=none; b=qeuid57HE8FlNFM3/EVOJKwxdafsK++OnXe3WZrcaEgz7/pGceSjYTijH6Qy7yIQBYJIsM49wsRDjH7mfkYl5onPLSb4Ru2wxJJwhSBPpbHVRnQhKWVJddt/fhquMc6wVaG1w1KENcuvbK12VR2PTcyatbQnwZi+qyBHRBOqNqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763987955; c=relaxed/simple;
	bh=qEr2DqVLm997fwnebwKo0kZTl4owy6CqxsFl54z0r+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ukkfw8q+13ZIskfAi+hlfAObPX9rHyXhUlj2Pa0N+o+Ew9rM4jrU9RCgUTSJwcnHPVVi6kSL/hSWtN1vfHgLQ+8fKI6k9q8KCF69h1uphRZYUBmuzkvzRXy+IAZuMipoluH8YsD798O9wGeQ63d3S27KPqyV0RD9AmFh8AXaehk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8b4ad87cc93211f0a38c85956e01ac42-20251124
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:88bebdd3-d934-44fa-8b73-642896c7f9ab,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:88bebdd3-d934-44fa-8b73-642896c7f9ab,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:f8a3e4e67c69aabc7ababf260f050834,BulkI
	D:251124203903YDS2QYJG,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8b4ad87cc93211f0a38c85956e01ac42-20251124
X-User: zhangguopeng@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 368504848; Mon, 24 Nov 2025 20:38:57 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	mkoutny@suse.com,
	muchun.song@linux.dev
Cc: lance.yang@linux.dev,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH v4 0/3] selftests: cgroup: Enhance robustness with polling helpers
Date: Mon, 24 Nov 2025 20:38:13 +0800
Message-Id: <20251124123816.486164-1-zhangguopeng@kylinos.cn>
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

This patch series introduces improvements to the cgroup selftests by adding helper functions to better handle 
asynchronous updates in cgroup statistics. These changes are especially useful for managing cgroup stats like 
memory.stat and cgroup.stat, which can be affected by delays (e.g., RCPU callbacks and asynchronous rstat flushing).

v4:
 - Patch 1/3: Adds the `cg_read_key_long_poll()` helper to poll cgroup keys with retries and configurable intervals.
 - Patch 2/3: Updates `test_memcg_sock()` to use `cg_read_key_long_poll()` for handling delayed "sock" counter updates in memory.stat.
 - Patch 3/3: Replaces `sleep` and retry logic in `test_kmem_dead_cgroups()` with `cg_read_key_long_poll()` for waiting on `nr_dying_descendants`.

v3:
 - Move `MEMCG_SOCKSTAT_WAIT_*` defines after the `#include` block as suggested.

v2:
 - Clarify the rationale for the 3s timeout and mention the periodic rstat flush interval (FLUSH_TIME = 2*HZ) in the comment.
 - Replace hardcoded retry count and wait interval with macros to avoid magic numbers and make the timeout calculation explicit.

Thanks to Michal Koutný for the suggestion to introduce the polling helper, and to Lance Yang for the review.

Guopeng Zhang (3):
  selftests: cgroup: Add cg_read_key_long_poll() to poll a cgroup key
    with retries
  selftests: cgroup: make test_memcg_sock robust against delayed sock
    stats
  selftests: cgroup: Replace sleep with cg_read_key_long_poll() for
    waiting on nr_dying_descendants

 .../selftests/cgroup/lib/cgroup_util.c        | 21 +++++++++++++
 .../cgroup/lib/include/cgroup_util.h          |  5 +++
 tools/testing/selftests/cgroup/test_kmem.c    | 31 ++++++++-----------
 .../selftests/cgroup/test_memcontrol.c        | 20 +++++++++++-
 4 files changed, 58 insertions(+), 19 deletions(-)

-- 
2.25.1


