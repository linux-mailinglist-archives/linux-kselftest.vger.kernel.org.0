Return-Path: <linux-kselftest+bounces-45541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05915C57AD0
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 14:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7483A4AFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 13:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5429350293;
	Thu, 13 Nov 2025 13:15:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E73502B0;
	Thu, 13 Nov 2025 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039711; cv=none; b=pqybhtYrhGB99wm1Q/Cj2NWZi391uFIzi7sirf9tn9N/e+rCzEFyUr/ccET0vy+O7Hm7yiHpM9T/Q7up7lMKf9hoeqBO7LQFWFMasDwOJ1Qj+zAJePsPcY6ilXoUeAcMoJmrGeOZ70N+59anYFruT1L/2PHbVZxNyFU2Ltz/b8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039711; c=relaxed/simple;
	bh=6dMW8bMwTxb4FkBK6bLthIdV3ilHyTf/DTu0YvWev8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J+SWi/f4aY15Ye1rcH+EiNs2Hp/4mVRp40LZ524gVoaPxe2K1pZrGAmRyydyAcRPenq4K2+yVF4sRoHy5q/nqdUdUkXOoHw9u4tp7PMZbfb2w5pnT3L3nNk2FMVFm1Ba7Hu0xN4skCRnvpMOIBOZfVnIalc2NX/B7MW2NedDXS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c0b2be10c09211f0a38c85956e01ac42-20251113
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP
	SA_EXISTED, SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:84fc251b-f117-4269-a976-58cc5b6f035c,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:84fc251b-f117-4269-a976-58cc5b6f035c,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:900a97af88ae7b7aff42089cce452c64,BulkI
	D:251113211501BVFKTKG3,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|850,TC:
	nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c0b2be10c09211f0a38c85956e01ac42-20251113
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1220712474; Thu, 13 Nov 2025 21:14:57 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: llong@redhat.com
Cc: cgroups@vger.kernel.org,
	chenridong@huaweicloud.com,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	sunshaojie@kylinos.cn,
	tj@kernel.org
Subject: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
Date: Thu, 13 Nov 2025 21:14:34 +0800
Message-Id: <20251113131434.606961-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cgroup v2, a mutual overlap check is required when at least one of two
cpusets is exclusive. However, this check should be relaxed and limited to
cases where both cpusets are exclusive.

The table 1 shows the partition states of A1 and B1 after each step before
applying this patch.

Table 1: Before applying the patch
 Step                                       | A1's prstate | B1's prstate |
 #1> mkdir -p A1                            | member       |              |
 #2> echo "0-1" > A1/cpuset.cpus            | member       |              |
 #3> echo "root" > A1/cpuset.cpus.partition | root         |              |
 #4> mkdir -p B1                            | root         | member       |
 #5> echo "0-3" > B1/cpuset.cpus            | root invalid | member       |
 #6> echo "root" > B1/cpuset.cpus.partition | root invalid | root invalid |

After step #5, A1 changes from "root" to "root invalid" because its CPUs
(0-1) overlap with those requested by B1 (0-3). However, B1 can actually
use CPUs 2-3, so it would be more reasonable for A1 to remain as "root."

This patch relaxes the exclusive cpuset check for cgroup v2 while
preserving the current cgroup v1 behavior.

Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>

---
v1 -> v2:
  - Keeps the current cgroup v1 behavior unchanged
  - Link: https://lore.kernel.org/cgroups/c8e234f4-2c27-4753-8f39-8ae83197efd3@redhat.com
---
 kernel/cgroup/cpuset.c                            |  9 +++++++--
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 10 +++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 52468d2c178a..3240b3ab5998 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -592,8 +592,13 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
  */
 static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
 {
-	/* If either cpuset is exclusive, check if they are mutually exclusive */
-	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
+	/* If both cpusets are exclusive, check if they are mutually exclusive */
+	if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
+		return !cpusets_are_exclusive(cs1, cs2);
+
+	/* In cgroup-v1, if either cpuset is exclusive, check if they are mutually exclusive */
+	if (!is_in_v2_mode() &&
+	    (is_cpu_exclusive(cs1) != is_cpu_exclusive(cs2)))
 		return !cpusets_are_exclusive(cs1, cs2);
 
 	/* Exclusive_cpus cannot intersect */
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


