Return-Path: <linux-kselftest+bounces-45699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE383C616BC
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Nov 2025 15:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21CB34E04BC
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Nov 2025 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA91A2D6E67;
	Sun, 16 Nov 2025 14:28:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAB21DE4CE;
	Sun, 16 Nov 2025 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763303315; cv=none; b=nEKEjhqwrPdQsfxPYww0gMnAJG5CKV6T54d4ElprtXFayGba7or3T83Nuz3d3uZ4gMFXKKsdFrOKiHCBr0FWyPGn0BzA9GoeUolCG5Swfh6IlKXIpgE+XG92QTA36xyjrrHgmQT/l6ZO8B1sM3dvfRSeLq2gDxJ6Q5AH8I5EzuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763303315; c=relaxed/simple;
	bh=kbfNZ6gK4F3AMX5MfezPONSToRU7w2owlAu5Wlmvbws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uMCYpbPtmhHtIi+MHyYg1KPlSd8Ty4M4NT+CN4JXcTD9CzFOcWic8XIzKVb9B3DoMVDBYWneSmlXm3eQMMCbUp9nTXmnqekukC8buLj2ijcQAwveZPIO6Yp/cJd7gPHOI89RB7/caWEJpO8MFnIGhCQe5++GuDc1dqAdb/erpYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 80733236c2f811f0a38c85956e01ac42-20251116
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI, GTI_FG_IT, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:14824acd-c57c-4625-97a3-7c9aac3d23e1,IP:20,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.6,REQID:14824acd-c57c-4625-97a3-7c9aac3d23e1,IP:20,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:a9d874c,CLOUDID:4024931863e062d73f091e3d9412cac2,BulkI
	D:251116222824Q3YKBKNY,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|850,TC:
	nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 80733236c2f811f0a38c85956e01ac42-20251116
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 965992263; Sun, 16 Nov 2025 22:28:21 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: llong@redhat.com
Cc: chenridong@huaweicloud.com,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	tj@kernel.org,
	Sun Shaojie <sunshaojie@kylinos.cn>
Subject: [PATCH v3 0/1] cpuset: relax the overlap check for cgroup-v2
Date: Sun, 16 Nov 2025 22:27:20 +0800
Message-Id: <20251116142721.959920-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cgroup v2, a mutual overlap check is required when at least one of
two
cpusets is exclusive. However, this check should be relaxed and limited
to
cases where both cpusets are exclusive.

This patch ensures that for sibling cpusets A1 (exclusive) and B1
(non-exclusive), change B1 cannot affect A1's exclusivity.

for example. Assume a machine has 4 CPUs (0-3).

   root cgroup
      /    \
    A1      B1

Case 1:
 Table 1.1: Before applying the patch
 Step                                       | A1's prstate | B1'sprstate |
 #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
 #2> echo "root" > A1/cpuset.cpus.partition | root         | member      |
 #3> echo "0" > B1/cpuset.cpus              | root invalid | member      |

After step #3, A1 changes from "root" to "root invalid" because its CPUs
(0-1) overlap with those requested by B1 (0-3). However, B1 can actually
use CPUs 2-3(from B1's parent), so it would be more reasonable for A1 to
remain as "root."

 Table 1.2: After applying the patch
 Step                                       | A1's prstate | B1'sprstate |
 #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
 #2> echo "root" > A1/cpuset.cpus.partition | root         | member      |
 #3> echo "0" > B1/cpuset.cpus              | root         | member      |

Case 2: (This situation remains unchanged from before)
 Table 2.1: Before applying the patch
 Step                                       | A1's prstate | B1'sprstate |
 #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
 #3> echo "1-2" > B1/cpuset.cpus            | member       | member      |
 #2> echo "root" > A1/cpuset.cpus.partition | root invalid | member      |

 Table 2.2: After applying the patch
 Step                                       | A1's prstate | B1'sprstate |
 #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
 #3> echo "1-2" > B1/cpuset.cpus            | member       | member      |
 #2> echo "root" > A1/cpuset.cpus.partition | root invalid | member      |

All other cases remain unaffected. For example, cgroup-v1, both A1 and
B1 are exclusive or non-exlusive.

---
v2 -> v3:
  - Ensure compliance with constraints such as cpuset.cpus.exclusive.
  - Link:
    https://lore.kernel.org/cgroups/20251113131434.606961-1-sunshaojie@kylinos.cn/

v1 -> v2:
  - Keeps the current cgroup v1 behavior unchanged
  - Link:
    https://lore.kernel.org/cgroups/c8e234f4-2c27-4753-8f39-8ae83197efd3@redhat.com


 kernel/cgroup/cpuset-internal.h               |  3 ++
 kernel/cgroup/cpuset-v1.c                     | 20 +++++++++
 kernel/cgroup/cpuset.c                        | 44 ++++++++++++++-----
 .../selftests/cgroup/test_cpuset_prs.sh       | 10 ++---
 4 files changed, 60 insertions(+), 17 deletions(-)

-- 
2.25.1


