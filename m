Return-Path: <linux-kselftest+bounces-45712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D434FC62097
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 02:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2BD535F5B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 01:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D3E24DCEB;
	Mon, 17 Nov 2025 01:57:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1775813A244;
	Mon, 17 Nov 2025 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763344653; cv=none; b=IyPjvKRjjNtJOxQWksBwYEEaixwti+OsLHPi4rsoBRBlajlY7wB49UOCUKd3TUv4AE+KpA6k0tcG73lZJt0/PfClq50klF031I3p71Nr6g+w/ufQ4zCMqQ+30nnqcIxQedBicUI08FG87nVCw/S6vFUf9KtfE231JhFK7Fhdkds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763344653; c=relaxed/simple;
	bh=j8qckSH0DdQEhcEYbGTH0EdctZZW2iNGiNhZ7yNom5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJV9DM3gsMSr8ul25iImCBUk1MWYXnkr+uLNxodjAo2uyR7cxO1AW3rEDHLfxe+4uZ4KQdTXolJT/PbmAJL8j5aHDoYVdY7VNnwVEeDpcdrbbq1vteqJ/+JEzf5ysF1KaeCzQIEbXn8IihAFfXjkLzYv6gF5pFzyCQ5YqfbL1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c358e16cc35811f0a38c85956e01ac42-20251117
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:3b7e332d-df33-4c3a-98a2-0713a0c1976f,IP:20,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.6,REQID:3b7e332d-df33-4c3a-98a2-0713a0c1976f,IP:20,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:a9d874c,CLOUDID:3fc0f543ee78172a81c15415ac016ca0,BulkI
	D:251117095725SPDKQGD4,BulkQuantity:0,Recheck:0,SF:17|19|66|78|81|82|102|8
	50,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c358e16cc35811f0a38c85956e01ac42-20251117
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1110326806; Mon, 17 Nov 2025 09:57:25 +0800
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
Subject: [PATCH v4 1/1] cpuset: relax the overlap check for cgroup-v2
Date: Mon, 17 Nov 2025 09:57:08 +0800
Message-Id: <20251117015708.977585-2-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251117015708.977585-1-sunshaojie@kylinos.cn>
References: <20251117015708.977585-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In cgroup v2, a mutual overlap check is required when at least one of two
cpusets is exclusive. However, this check should be relaxed and limited to
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

All other cases remain unaffected. For example, cgroup-v1, both A1 and B1
are exclusive or non-exlusive.

Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
---
 kernel/cgroup/cpuset-internal.h               |  3 ++
 kernel/cgroup/cpuset-v1.c                     | 20 +++++++++
 kernel/cgroup/cpuset.c                        | 43 ++++++++++++++-----
 .../selftests/cgroup/test_cpuset_prs.sh       |  5 ++-
 4 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 337608f408ce..c53111998432 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -292,6 +292,7 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 			    struct cpumask *new_cpus, nodemask_t *new_mems,
 			    bool cpus_updated, bool mems_updated);
 int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
+bool cpuset1_cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2);
 #else
 static inline void fmeter_init(struct fmeter *fmp) {}
 static inline void cpuset1_update_task_spread_flags(struct cpuset *cs,
@@ -302,6 +303,8 @@ static inline void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 			    bool cpus_updated, bool mems_updated) {}
 static inline int cpuset1_validate_change(struct cpuset *cur,
 				struct cpuset *trial) { return 0; }
+static inline bool cpuset1_cpus_excl_conflict(struct cpuset *cs1,
+				struct cpuset *cs2) {return false; }
 #endif /* CONFIG_CPUSETS_V1 */
 
 #endif /* __CPUSET_INTERNAL_H */
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 12e76774c75b..5c1296bf6a34 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -373,6 +373,26 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
 	return ret;
 }
 
+/*
+ * cpuset1_cpus_excl_conflict() - Check if two cpusets have exclusive CPU conflicts
+ *                                to legacy (v1)
+ * @cs1: first cpuset to check
+ * @cs2: second cpuset to check
+ *
+ * Returns: true if CPU exclusivity conflict exists, false otherwise
+ *
+ * If either cpuset is CPU exclusive, their allowed CPUs cannot intersect.
+ */
+bool cpuset1_cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
+{
+	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
+		if (cpumask_intersects(cs1->cpus_allowed,
+				       cs2->cpus_allowed))
+			return true;
+
+	return false;
+}
+
 #ifdef CONFIG_PROC_PID_CPUSET
 /*
  * proc_cpuset_show()
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 52468d2c178a..0fd803612513 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -580,35 +580,56 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
 
 /**
  * cpus_excl_conflict - Check if two cpusets have exclusive CPU conflicts
- * @cs1: first cpuset to check
- * @cs2: second cpuset to check
+ * @cs1: current cpuset to check
+ * @cs2: cpuset involved in the check
  *
  * Returns: true if CPU exclusivity conflict exists, false otherwise
  *
  * Conflict detection rules:
- * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
+ * For cgroup-v1:
+ *     see cpuset1_cpus_excl_conflict()
+ * For cgroup-v2:
+ * 1. If cs1 is exclusive, cs1 and cs2 must be mutually exclusive
  * 2. exclusive_cpus masks cannot intersect between cpusets
- * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
+ * 3. If cs2 is exclusive, cs2's allowed CPUs cannot be a subset of cs1's exclusive CPUs
+ * 4. if cs1 and cs2 are not exclusive, the allowed CPUs of one cpuset cannot be a subset
+ *    of another's exclusive CPUs
  */
 static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
 {
-	/* If either cpuset is exclusive, check if they are mutually exclusive */
-	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
+	/* For cgroup-v1 */
+	if (!cpuset_v2())
+		return cpuset1_cpus_excl_conflict(cs1, cs2);
+
+	/* If cs1 are exclusive, check if they are mutually exclusive */
+	if (is_cpu_exclusive(cs1))
 		return !cpusets_are_exclusive(cs1, cs2);
 
+	/* The following check applies when either
+	 * both cs1 and cs2 are non-exclusive，or
+	 * only cs2 is exclusive.
+	 */
+
 	/* Exclusive_cpus cannot intersect */
 	if (cpumask_intersects(cs1->exclusive_cpus, cs2->exclusive_cpus))
 		return true;
 
-	/* The cpus_allowed of one cpuset cannot be a subset of another cpuset's exclusive_cpus */
-	if (!cpumask_empty(cs1->cpus_allowed) &&
-	    cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
-		return true;
-
+	/* cs2's allowed CPUs cannot be a subset of cs1's exclusive CPUs */
 	if (!cpumask_empty(cs2->cpus_allowed) &&
 	    cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
 		return true;
 
+	/* If cs2 is exclusive, check finished here */
+	if (is_cpu_exclusive(cs2))
+		return false;
+
+	/* The following check applies only if both cs1 and cs2 are non-exclusive. */
+
+	/* cs1's allowed CPUs cannot be a subset of cs1's exclusive CPUs */
+	if (!cpumask_empty(cs1->cpus_allowed) &&
+	    cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
+		return true;
+
 	return false;
 }
 
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index a17256d9f88a..b848bc0729cf 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -388,10 +388,11 @@ TEST_MATRIX=(
 	"  C0-1:S+  C1      .    C2-3     .      P2     .      .     0 A1:0-1|A2:1 A1:P0|A2:P-2"
 	"  C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0|A2:1 A1:P1|A2:P2 0-1|1"
 
-	# A non-exclusive cpuset.cpus change will invalidate partition and its siblings
+	# A non-exclusive cpuset.cpus change will not invalidate its siblings partition.
+	# But a exclusive cpuset.cpus change will invalidate itself.
 	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P0"
 	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P-1"
-	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P0|B1:P-1"
+	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-1|B1:2-3 A1:P0|B1:P1"
 
 	# cpuset.cpus can overlap with sibling cpuset.cpus.exclusive but not subsumed by it
 	"   C0-3     .      .    C4-5     X5     .      .      .     0 A1:0-3|B1:4-5"
-- 
2.25.1


