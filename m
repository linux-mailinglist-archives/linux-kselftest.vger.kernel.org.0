Return-Path: <linux-kselftest+bounces-46785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6E9C96681
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 10:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CC7E341E01
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 09:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9385301038;
	Mon,  1 Dec 2025 09:38:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40542BE655;
	Mon,  1 Dec 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764581921; cv=none; b=PV911MrRh5GllSUPs74Fb1ty/4P8QoAul9p95n8VH1kQcgD1GGf7poBTXPwNC4SNFlxXnE0+Zc2Y7GKPyGKkhd4axLBr6xUahZdZq2xz778bIM/szx0CXEB+1QLwI8j9WbL7e/ER3gIU7f4ExhxEa/LDW4I6iO01L03a5QHSSi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764581921; c=relaxed/simple;
	bh=n1ysr87FIbiRCEqkFyB4H7ih4UQpPpKDjY0M9o3384g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LLw9NLOQgaYjff9rkNY1kENQtc1nm1UDyhx+KUScHtoySBFxtNRCiuv5NIBBNnnef3vjHwqmVgbgCktbity6TFwHe9XFITqcLDhoy4Nfaa+p9bQ+hTn+I/1QWJde5+c5beHagZeaGiSKJhgPtNVawdnt4PMfsDjH+t9OE7ZamgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7f3079ccce9911f0a38c85956e01ac42-20251201
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:703472d1-1ea2-4cb4-b119-d31639d6dcca,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:703472d1-1ea2-4cb4-b119-d31639d6dcca,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:4391ae8ae786646f38760a6e1b7f8365,BulkI
	D:251201173831BEYTCFUI,BulkQuantity:0,Recheck:0,SF:17|19|66|78|81|82|102|1
	27|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7f3079ccce9911f0a38c85956e01ac42-20251201
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1975305386; Mon, 01 Dec 2025 17:38:30 +0800
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
Subject: [PATCH v6] cpuset: Avoid invalidating sibling partitions on cpuset.cpus conflict.
Date: Mon,  1 Dec 2025 17:38:06 +0800
Message-Id: <20251201093806.107157-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cae7a3ef-9808-47ac-a061-ab40d3c61020@redhat.com>
References: <cae7a3ef-9808-47ac-a061-ab40d3c61020@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
with its sibling partition, the sibling's partition state becomes invalid.
However, this invalidation is often unnecessary.

For example: On a machine with 128 CPUs, there are m (m < 128) cpusets
under the root cgroup. Each cpuset is used by a single user(user-1 use
A1, ... , user-m use Am), and the partition states of these cpusets are
configured as follows:

                           root cgroup
        /             /                  \                 \
       A1            A2        ...       An                Am
     (root)        (root)      ...     (root) (root/root invalid/member)

Assume that A1 through Am have not set cpuset.cpus.exclusive. When
user-m modifies Am's cpuset.cpus to "0-127", it will cause all partition
states from A1 to An to change from root to root invalid, as shown
below.

                           root cgroup
        /              /                 \                 \
       A1             A2       ...       An                Am
 (root invalid) (root invalid) ... (root invalid) (root invalid/member)

This outcome is entirely undeserved for all users from A1 to An.

This patch prevents such outcomes by ensuring that modifications to
cpuset.cpus do not affect the partition state of other sibling cpusets.
Therefore, with this patch applied, when user-m configures Am's
cpuset.cpus to "0-127", the result will be as follows.

                           root cgroup
        /             /                  \                 \
       A1            A2        ...       An                Am
     (root)        (root)      ...     (root)     (root invalid/member)

It is worth noting that, since this patch enforces the exclusivity of
sibling cpusets, setting exclusivity now follows a "first-come,
first-served" principle.

For example, consider the following four steps: before applying this
patch, regardless of the order in which they are executed, the final
partition state of both A1 and B1 would always be "root invalid."

 Step                                       | A1's prstate | B1's prstate |
 #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
 #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
 #3> echo "1-2" > B1/cpuset.cpus            | root invalid | member       |
 #4> echo "root" > B1/cpuset.cpus.partition | root invalid | root invalid |

After applying this patch, the first party to set "root" will maintain
its exclusive validity. As follows:

 Step                                       | A1's prstate | B1's prstate |
 #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
 #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
 #3> echo "1-2" > B1/cpuset.cpus            | root         | member       |
 #4> echo "root" > B1/cpuset.cpus.partition | root         | root invalid |

 Step                                       | A1's prstate | B1's prstate |
 #1> echo "0-1" > B1/cpuset.cpus            | member       | member       |
 #2> echo "root" > B1/cpuset.cpus.partition | member       | root         |
 #3> echo "1-2" > A1/cpuset.cpus            | member       | root         |
 #4> echo "root" > A1/cpuset.cpus.partition | root invalid | root         |

In summary, if the current cpuset conflicts with its sibling cpusets on
exclusive CPUs (If a cpuset is exclusive and its exclusive CPUs are empty,
its allowed CPUs will be treated as exclusive CPUs), only the current
cpuset should bear the consequences.

Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
---
 kernel/cgroup/cpuset-internal.h               |  3 +
 kernel/cgroup/cpuset-v1.c                     | 19 ++++++
 kernel/cgroup/cpuset.c                        | 60 ++++++++++++-------
 .../selftests/cgroup/test_cpuset_prs.sh       | 12 ++--
 4 files changed, 65 insertions(+), 29 deletions(-)

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
index 12e76774c75b..5aa0ac092ef6 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -373,6 +373,25 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
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
+		return cpumask_intersects(cs1->cpus_allowed,
+					  cs2->cpus_allowed);
+
+	return false;
+}
+
 #ifdef CONFIG_PROC_PID_CPUSET
 /*
  * proc_cpuset_show()
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 52468d2c178a..e58dd26e074a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -586,14 +586,24 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
  * Returns: true if CPU exclusivity conflict exists, false otherwise
  *
  * Conflict detection rules:
- * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
+ * For cgroup-v1:
+ *     see cpuset1_cpus_excl_conflict()
+ * For cgroup-v2:
+ * 1. If both cs1 and cs2 are exclusive, cs1 and cs2 must be mutually exclusive
  * 2. exclusive_cpus masks cannot intersect between cpusets
  * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
+ * 4. If a cpuset is exclusive and its exclusive CPUs are empty, its allowed CPUs
+ *    will be treated as exclusive CPUs; therefore, its allowed CPUs must not
+ *    intersect with another's exclusive CPUs.
  */
 static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
 {
-	/* If either cpuset is exclusive, check if they are mutually exclusive */
-	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
+	/* For cgroup-v1 */
+	if (!cpuset_v2())
+		return cpuset1_cpus_excl_conflict(cs1, cs2);
+
+	/* If cpusets are exclusive, check if they are mutually exclusive*/
+	if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
 		return !cpusets_are_exclusive(cs1, cs2);
 
 	/* Exclusive_cpus cannot intersect */
@@ -609,6 +619,20 @@ static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
 	    cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
 		return true;
 
+	/*
+	 * When a cpuset is exclusive and its exclusive CPUs are empty,
+	 * its cpus_allowed cannot intersect with another cpuset's exclusive_cpus.
+	 */
+	if (is_cpu_exclusive(cs1) &&
+	    cpumask_empty(cs1->exclusive_cpus) &&
+	    cpumask_intersects(cs1->cpus_allowed, cs2->exclusive_cpus))
+		return true;
+
+	if (is_cpu_exclusive(cs2) &&
+	    cpumask_empty(cs2->exclusive_cpus) &&
+	    cpumask_intersects(cs2->cpus_allowed, cs1->exclusive_cpus))
+		return true;
+
 	return false;
 }
 
@@ -2411,34 +2435,17 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialc
 					struct tmpmasks *tmp)
 {
 	int retval;
-	struct cpuset *parent = parent_cs(cs);
 
 	retval = validate_change(cs, trialcs);
 
 	if ((retval == -EINVAL) && cpuset_v2()) {
-		struct cgroup_subsys_state *css;
-		struct cpuset *cp;
-
 		/*
 		 * The -EINVAL error code indicates that partition sibling
 		 * CPU exclusivity rule has been violated. We still allow
 		 * the cpumask change to proceed while invalidating the
-		 * partition. However, any conflicting sibling partitions
-		 * have to be marked as invalid too.
+		 * partition.
 		 */
 		trialcs->prs_err = PERR_NOTEXCL;
-		rcu_read_lock();
-		cpuset_for_each_child(cp, css, parent) {
-			struct cpumask *xcpus = user_xcpus(trialcs);
-
-			if (is_partition_valid(cp) &&
-			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
-				rcu_read_unlock();
-				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, tmp);
-				rcu_read_lock();
-			}
-		}
-		rcu_read_unlock();
 		retval = 0;
 	}
 	return retval;
@@ -2506,8 +2513,15 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (alloc_tmpmasks(&tmp))
 		return -ENOMEM;
 
-	compute_trialcs_excpus(trialcs, cs);
-	trialcs->prs_err = PERR_NONE;
+	/*
+	 * if there is exclusive CPUs conflict with the siblings,
+	 * we still allow the cpumask change to proceed while
+	 * invalidating the partition.
+	 */
+	if (compute_trialcs_excpus(trialcs, cs))
+		trialcs->prs_err = PERR_NOTEXCL;
+	else
+		trialcs->prs_err = PERR_NONE;
 
 	retval = cpus_allowed_validate_change(cs, trialcs, &tmp);
 	if (retval < 0)
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index a17256d9f88a..75154e22c702 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -269,7 +269,7 @@ TEST_MATRIX=(
 	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X3:P2    .      .     0 A1:0-2|A2:3|A3:3 A1:P0|A2:P2 3"
 	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3  X2-3:P2   .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
 	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:C3 .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
-	" C0-3:S+ C1-3:S+ C2-3   C2-3     .      .      .      P2    0 A1:0-3|A2:1-3|A3:2-3|B1:2-3 A1:P0|A3:P0|B1:P-2"
+	" C0-3:S+ C1-3:S+ C2-3   C2-3     .      .      .      P2    0 A1:0-1|A2:1|A3:1|B1:2-3 A1:P0|A3:P0|B1:P2"
 	" C0-3:S+ C1-3:S+ C2-3   C4-5     .      .      .      P2    0 B1:4-5 B1:P2 4-5"
 	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3  X2-3:P2   P2    0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
 	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3 X2-3:P2:C1-3 P2  0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
@@ -318,7 +318,7 @@ TEST_MATRIX=(
 	# Invalid to valid local partition direct transition tests
 	" C1-3:S+:P2 X4:P2  .      .      .      .      .      .     0 A1:1-3|XA1:1-3|A2:1-3:XA2: A1:P2|A2:P-2 1-3"
 	" C1-3:S+:P2 X4:P2  .      .      .    X3:P2    .      .     0 A1:1-2|XA1:1-3|A2:3:XA2:3 A1:P2|A2:P2 1-3"
-	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:4-6 A1:P-2|B1:P0"
+	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:5-6 A1:P2|B1:P0"
 	"  C0-3:P2   .      .    C4-6 C0-4:C0-3  .      .      .     0 A1:0-3|B1:4-6 A1:P2|B1:P0 0-3"
 
 	# Local partition invalidation tests
@@ -388,10 +388,10 @@ TEST_MATRIX=(
 	"  C0-1:S+  C1      .    C2-3     .      P2     .      .     0 A1:0-1|A2:1 A1:P0|A2:P-2"
 	"  C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0|A2:1 A1:P1|A2:P2 0-1|1"
 
-	# A non-exclusive cpuset.cpus change will invalidate partition and its siblings
-	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P0"
-	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P-1"
-	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P0|B1:P-1"
+	# A non-exclusive cpuset.cpus change will not invalidate its siblings partition.
+	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:3 A1:P1|B1:P0"
+	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-1|B1:2-3 A1:P-1|B1:P1"
+	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-1|B1:2-3 A1:P0|B1:P1"
 
 	# cpuset.cpus can overlap with sibling cpuset.cpus.exclusive but not subsumed by it
 	"   C0-3     .      .    C4-5     X5     .      .      .     0 A1:0-3|B1:4-5"
-- 
2.25.1


