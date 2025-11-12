Return-Path: <linux-kselftest+bounces-45371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 797AFC50501
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 03:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 594144E1DE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 02:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EDF29BD90;
	Wed, 12 Nov 2025 02:14:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DEA299AAC;
	Wed, 12 Nov 2025 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762913654; cv=none; b=qwcjtcr9o0pHNEpVfXR1ZT8R+U1IMJV5Jh63r8McYpUZPYz4wkHjZ/ujnDE3Pf/inra7m4qu1MFFj22NLf31trSM//r62cKgmWToKzLWEWyrgcKpQ9xoZAEbn+G+6NRGeEjQG4hPs7w919Sr2tpLiGphwdRK1vkHvzngjDcyuUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762913654; c=relaxed/simple;
	bh=+EVal716qGzAn0CzKjGD5B5F08wc4sjxGE0eoLp4SE8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KV8U8Nq6f8WODjIy4cS/l3A1eiNzuBeQU5kjO7VOWwV7qn1G+2I9DCRNHdfN9tM2FequBTpkCN4whzpUSc/jLtIGuDToZOGeYFA8YPHrMi9eZggrx+MRbOLlECXYLvf3WBPv5QsgzWduCra4Awm/INesgioVt5fX+RGrgL5R8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3ce0d764bf6d11f0a38c85956e01ac42-20251112
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED
	SA_UNFAMILIAR, SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:1d481d92-dc9e-4306-8a81-f16ef82f1896,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-INFO: VERSION:1.3.6,REQID:1d481d92-dc9e-4306-8a81-f16ef82f1896,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
	lease,TS:15
X-CID-META: VersionHash:a9d874c,CLOUDID:60b87a7d78fa585f0569a02cddf450d5,BulkI
	D:251112100717OSVPKDLB,BulkQuantity:1,Recheck:0,SF:19|66|72|78|102|850,TC:
	nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3ce0d764bf6d11f0a38c85956e01ac42-20251112
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 907620271; Wed, 12 Nov 2025 10:13:54 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: longman@redhat.com
Cc: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Shaojie <sunshaojie@kylinos.cn>
Subject: [PATCH v1] cpuset: Avoid unnecessary partition invalidation
Date: Wed, 12 Nov 2025 10:11:20 +0800
Message-Id: <20251112021120.248778-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when a non-exclusive cpuset's "cpuset.cpus" overlaps with a
partitioned sibling, the sibling's partition state becomes invalid.
However, this invalidation is often unnecessary.

This can be observed in specific configuration sequences:

Case 1: Partition created first, then non-exclusive cpuset overlaps
 #1> mkdir -p /sys/fs/cgroup/A1
 #2> echo "0-1" > /sys/fs/cgroup/A1/cpuset.cpus
 #3> echo "root" > /sys/fs/cgroup/A1/cpuset.cpus.partition
 #4> mkdir -p /sys/fs/cgroup/B1
 #5> echo "0-3" > /sys/fs/cgroup/B1/cpuset.cpus
 // A1's partition becomes "root invalid" - this is unnecessary

Case 2: Non-exclusive cpuset exists first, then partition created
 #1> mkdir -p /sys/fs/cgroup/B1
 #2> echo "0-1" > /sys/fs/cgroup/B1/cpuset.cpus
 #3> mkdir -p /sys/fs/cgroup/A1
 #4> echo "0-1" > /sys/fs/cgroup/A1/cpuset.cpus
 #5> echo "root" > /sys/fs/cgroup/A1/cpuset.cpus.partition
 // A1's partition becomes "root invalid" - this is unnecessary

In Case 1, the effective CPU mask of B1 can differ from its requested
mask. B1 can use CPUs 2-3 which don't overlap with A1's exclusive
CPUs (0-1), thus not violating A1's exclusivity requirement.

In Case 2, B1 can inherit the effective CPUs from its parent, so there
is no need to invalidate A1's partition state.

This patch relaxes the overlap check to only consider conflicts between
partitioned siblings, not between a partitioned cpuset and a regular
non-exclusive one.

Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
---
 kernel/cgroup/cpuset.c                            |  8 ++++----
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 52468d2c178a..e0d27c9a101a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -586,14 +586,14 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
  * Returns: true if CPU exclusivity conflict exists, false otherwise
  *
  * Conflict detection rules:
- * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
+ * 1. If both cpusets are exclusive, they must be mutually exclusive
  * 2. exclusive_cpus masks cannot intersect between cpusets
  * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
  */
 static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
 {
-	/* If either cpuset is exclusive, check if they are mutually exclusive */
-	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
+	/* If both cpusets are exclusive, check if they are mutually exclusive */
+	if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
 		return !cpusets_are_exclusive(cs1, cs2);
 
 	/* Exclusive_cpus cannot intersect */
@@ -695,7 +695,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 		goto out;
 
 	/*
-	 * If either I or some sibling (!= me) is exclusive, we can't
+	 * If both I and some sibling (!= me) are exclusive, we can't
 	 * overlap. exclusive_cpus cannot overlap with each other if set.
 	 */
 	ret = -EINVAL;
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index a17256d9f88a..903dddfe88d7 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -269,7 +269,7 @@ TEST_MATRIX=(
 	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X3:P2    .      .     0 A1:0-2|A2:3|A3:3 A1:P0|A2:P2 3"
 	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3  X2-3:P2   .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
 	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:C3 .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
-	" C0-3:S+ C1-3:S+ C2-3   C2-3     .      .      .      P2    0 A1:0-3|A2:1-3|A3:2-3|B1:2-3 A1:P0|A3:P0|B1:P-2"
+	" C0-3:S+ C1-3:S+ C2-3   C2-3     .      .      .      P2    0 A1:0-1|A2:1|A3:1|B1:2-3 A1:P0|A3:P0|B1:P2 2-3"
 	" C0-3:S+ C1-3:S+ C2-3   C4-5     .      .      .      P2    0 B1:4-5 B1:P2 4-5"
 	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3  X2-3:P2   P2    0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
 	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3 X2-3:P2:C1-3 P2  0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
@@ -318,7 +318,7 @@ TEST_MATRIX=(
 	# Invalid to valid local partition direct transition tests
 	" C1-3:S+:P2 X4:P2  .      .      .      .      .      .     0 A1:1-3|XA1:1-3|A2:1-3:XA2: A1:P2|A2:P-2 1-3"
 	" C1-3:S+:P2 X4:P2  .      .      .    X3:P2    .      .     0 A1:1-2|XA1:1-3|A2:3:XA2:3 A1:P2|A2:P2 1-3"
-	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:4-6 A1:P-2|B1:P0"
+	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:5-6 A1:P2|B1:P0 0-4"
 	"  C0-3:P2   .      .    C4-6 C0-4:C0-3  .      .      .     0 A1:0-3|B1:4-6 A1:P2|B1:P0 0-3"
 
 	# Local partition invalidation tests
@@ -388,10 +388,10 @@ TEST_MATRIX=(
 	"  C0-1:S+  C1      .    C2-3     .      P2     .      .     0 A1:0-1|A2:1 A1:P0|A2:P-2"
 	"  C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0|A2:1 A1:P1|A2:P2 0-1|1"
 
-	# A non-exclusive cpuset.cpus change will invalidate partition and its siblings
-	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P0"
+	# A non-exclusive cpuset.cpus change will not invalidate partition and its siblings
+	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:3 A1:P1|B1:P0"
 	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P-1"
-	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P0|B1:P-1"
+	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-1|B1:2-3 A1:P0|B1:P1"
 
 	# cpuset.cpus can overlap with sibling cpuset.cpus.exclusive but not subsumed by it
 	"   C0-3     .      .    C4-5     X5     .      .      .     0 A1:0-3|B1:4-5"
-- 
2.25.1


