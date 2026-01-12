Return-Path: <linux-kselftest+bounces-48711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAB0D108A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 05:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D4D730A32DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 04:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4930BBAC;
	Mon, 12 Jan 2026 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEy6N3T6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5762630C603
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 04:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768191006; cv=none; b=CxDsEO9ns1026s2PwmNKb5HZaxJMuemsoi20+fcR4PKfM/XXiw1KlaNhZTAwPk7tj9H0yI0mn1zbHJMNo3wskV2Rusj7xW9Ln+0gdS91rIHQfmgTA/Ym0OzjStjc60AfLmd0XUR3ZR2QlzpABqhJOLUmW3NxLfop54mkRfr//eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768191006; c=relaxed/simple;
	bh=EoUzG0QrLJ12BaZn/YT/vbMSaZRHZCzXkgT27eg8dis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibv7OntTs5aq5t5SVDj19sOZD3wtPGGctRkboAMmOOQgQhRnV/bHESdnb3yT1K+de2HF2PsO4BbWXkZH1pR3xEz49sHU6jdX6wIJKRA5UL6PHsmvEE7+NzqwiP+szTIaC4u34MdnasoxfffeVYfgoqTvkXgBqN4XZD/3z9LX1x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEy6N3T6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768190997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTMxotDm7B6Djv072qx4FuNVi2BtQEi5QSdN75QERMg=;
	b=fEy6N3T6weFQkwmxHYcIrNUn82KMlMVx2EHKCpF1E31iDs04/N35m5IA+j4WTSZ5/eKGx/
	JTKuRugkOti/YqSb97KIsS6by4l2xxfjBPI8IjPJUljau02/DPXW8tdTqAUtybwPUajnEp
	JXnc52m6pJ2HccFu3K8uc34afLYCoy8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-AMFyuQBBOSKcaidJl8TueQ-1; Sun,
 11 Jan 2026 23:09:52 -0500
X-MC-Unique: AMFyuQBBOSKcaidJl8TueQ-1
X-Mimecast-MFC-AGG-ID: AMFyuQBBOSKcaidJl8TueQ_1768190990
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AED1318003FC;
	Mon, 12 Jan 2026 04:09:49 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.71])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B13A31800665;
	Mon, 12 Jan 2026 04:09:47 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Sun Shaojie <sunshaojie@kylinos.cn>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huawei.com>
Subject: [PATCH cgroup/for-6.20 v4 4/5] cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus conflict
Date: Sun, 11 Jan 2026 23:08:55 -0500
Message-ID: <20260112040856.460904-5-longman@redhat.com>
In-Reply-To: <20260112040856.460904-1-longman@redhat.com>
References: <20260112040856.460904-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
with the cpuset.cpus/cpuset.cpus.exclusive of a sibling partition,
the sibling's partition state becomes invalid. This is overly harsh and
is probably not necessary.

The cpuset.cpus.exclusive control file, if set, will override the
cpuset.cpus of the same cpuset when creating a cpuset partition.
So cpuset.cpus has less priority than cpuset.cpus.exclusive in setting up
a partition.  However, it cannot override a conflicting cpuset.cpus file
in a sibling cpuset and the partition creation process will fail. This
is inconsistent.  That will also make using cpuset.cpus.exclusive less
valuable as a tool to set up cpuset partitions as the users have to
check if such a cpuset.cpus conflict exists or not.

Fix these problems by making sure that once a cpuset.cpus.exclusive
is set without failure, it will always be allowed to form a valid
partition as long as at least one CPU can be granted from its parent
irrespective of the state of the siblings' cpuset.cpus values. Of
course, setting cpuset.cpus.exclusive will fail if it conflicts with
the cpuset.cpus.exclusive or the cpuset.cpus.exclusive.effective value
of a sibling.

Partition can still be created by setting only cpuset.cpus without
setting cpuset.cpus.exclusive. However, any conflicting CPUs in sibling's
cpuset.cpus.exclusive.effective and cpuset.cpus.exclusive values will
be removed from its cpuset.cpus.exclusive.effective as long as there
is still one or more CPUs left and can be granted from its parent. This
CPU stripping is currently done in rm_siblings_excl_cpus().

The new code will now try its best to enable the creation of new
partitions with only cpuset.cpus set without invalidating existing ones.
However it is not guaranteed that all the CPUs requested in cpuset.cpus
will be used in the new partition even when all these CPUs can be
granted from the parent.

This is similar to the fact that cpuset.cpus.effective may not be
able to include all the CPUs requested in cpuset.cpus. In this case,
the parent may not able to grant all the exclusive CPUs requested in
cpuset.cpus to cpuset.cpus.exclusive.effective if some of them have
already been granted to other partitions earlier.

With the creation of multiple sibling partitions by setting
only cpuset.cpus, this does have the side effect that their exact
cpuset.cpus.exclusive.effective settings will depend on the order of
partition creation if there are conflicts. Due to the exclusive nature
of the CPUs in a partition, it is not easy to make it fair other than
the old behavior of invalidating all the conflicting partitions.

For example,
  # echo "0-2" > A1/cpuset.cpus
  # echo "root" > A1/cpuset.cpus.partition
  # cat A1/cpuset.cpus.partition
  root
  # cat A1/cpuset.cpus.exclusive.effective
  0-2
  # echo "2-4" > B1/cpuset.cpus
  # echo "root" > B1/cpuset.cpus.partition
  # cat B1/cpuset.cpus.partition
  root
  # cat B1/cpuset.cpus.exclusive.effective
  3-4
  # cat B1/cpuset.cpus.effective
  3-4

For users who want to be sure that they can get most of the CPUs they
want, cpuset.cpus.exclusive should be used instead if they can set
it successfully without failure. Setting cpuset.cpus.exclusive will
guarantee that sibling conflicts from then onward is no longer possible.

To make this change, we have to separate out the is_cpu_exclusive()
check in cpus_excl_conflict() into a cgroup v1 only
cpuset1_cpus_excl_conflict() helper. The cpus_allowed_validate_change()
helper is now no longer needed and can be removed.

Some existing tests in test_cpuset_prs.sh are updated and new ones are
added to reflect the new behavior. The cgroup-v2.rst doc file is also
updated the clarify what exclusive CPUs will be used when a partition
is created.

Reported-by: Sun Shaojie <sunshaojie@kylinos.cn>
Closes: https://lore.kernel.org/lkml/20251117015708.977585-1-sunshaojie@kylinos.cn/
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Chen Ridong <chenridong@huawei.com>
---
 Documentation/admin-guide/cgroup-v2.rst       | 32 +++++---
 kernel/cgroup/cpuset-internal.h               |  3 +
 kernel/cgroup/cpuset-v1.c                     | 19 +++++
 kernel/cgroup/cpuset.c                        | 80 ++++++-------------
 .../selftests/cgroup/test_cpuset_prs.sh       | 26 ++++--
 5 files changed, 89 insertions(+), 71 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 510df2461aff..a3446db96cea 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2584,9 +2584,9 @@ Cpuset Interface Files
 	of this file will always be a subset of its parent's
 	"cpuset.cpus.exclusive.effective" if its parent is not the root
 	cgroup.  It will also be a subset of "cpuset.cpus.exclusive"
-	if it is set.  If "cpuset.cpus.exclusive" is not set, it is
-	treated to have an implicit value of "cpuset.cpus" in the
-	formation of local partition.
+	if it is set.  This file should only be non-empty if either
+	"cpuset.cpus.exclusive" is set or when the current cpuset is
+	a valid partition root.
 
   cpuset.cpus.isolated
 	A read-only and root cgroup only multiple values file.
@@ -2618,13 +2618,22 @@ Cpuset Interface Files
 	There are two types of partitions - local and remote.  A local
 	partition is one whose parent cgroup is also a valid partition
 	root.  A remote partition is one whose parent cgroup is not a
-	valid partition root itself.  Writing to "cpuset.cpus.exclusive"
-	is optional for the creation of a local partition as its
-	"cpuset.cpus.exclusive" file will assume an implicit value that
-	is the same as "cpuset.cpus" if it is not set.	Writing the
-	proper "cpuset.cpus.exclusive" values down the cgroup hierarchy
-	before the target partition root is mandatory for the creation
-	of a remote partition.
+	valid partition root itself.
+
+	Writing to "cpuset.cpus.exclusive" is optional for the creation
+	of a local partition as its "cpuset.cpus.exclusive" file will
+	assume an implicit value that is the same as "cpuset.cpus" if it
+	is not set.  Writing the proper "cpuset.cpus.exclusive" values
+	down the cgroup hierarchy before the target partition root is
+	mandatory for the creation of a remote partition.
+
+	Not all the CPUs requested in "cpuset.cpus.exclusive" can be
+	used to form a new partition.  Only those that were present
+	in its parent's "cpuset.cpus.exclusive.effective" control
+	file can be used.  For partitions created without setting
+	"cpuset.cpus.exclusive", exclusive CPUs specified in sibling's
+	"cpuset.cpus.exclusive" or "cpuset.cpus.exclusive.effective"
+	also cannot be used.
 
 	Currently, a remote partition cannot be created under a local
 	partition.  All the ancestors of a remote partition root except
@@ -2632,6 +2641,9 @@ Cpuset Interface Files
 
 	The root cgroup is always a partition root and its state cannot
 	be changed.  All other non-root cgroups start out as "member".
+	Even though the "cpuset.cpus.exclusive*" control files are not
+	present in the root cgroup, they are implicitly the same as
+	"cpuset.cpus".
 
 	When set to "root", the current cgroup is the root of a new
 	partition or scheduling domain.  The set of exclusive CPUs is
diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index e718a4f54360..e8e2683cb067 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -312,6 +312,7 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 			    struct cpumask *new_cpus, nodemask_t *new_mems,
 			    bool cpus_updated, bool mems_updated);
 int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
+bool cpuset1_cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2);
 void cpuset1_init(struct cpuset *cs);
 void cpuset1_online_css(struct cgroup_subsys_state *css);
 int cpuset1_generate_sched_domains(cpumask_var_t **domains,
@@ -326,6 +327,8 @@ static inline void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 			    bool cpus_updated, bool mems_updated) {}
 static inline int cpuset1_validate_change(struct cpuset *cur,
 				struct cpuset *trial) { return 0; }
+static inline bool cpuset1_cpus_excl_conflict(struct cpuset *cs1,
+					struct cpuset *cs2) { return false; }
 static inline void cpuset1_init(struct cpuset *cs) {}
 static inline void cpuset1_online_css(struct cgroup_subsys_state *css) {}
 static inline int cpuset1_generate_sched_domains(cpumask_var_t **domains,
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index ecfea7800f0d..04124c38a774 100644
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
index 4819ab429771..83fb83a86b4b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -129,6 +129,17 @@ static bool force_sd_rebuild;
  *  For simplicity, a local partition can be created under a local or remote
  *  partition but a remote partition cannot have any partition root in its
  *  ancestor chain except the cgroup root.
+ *
+ *  A valid partition can be formed by setting exclusive_cpus or cpus_allowed
+ *  if exclusive_cpus is not set. In the case of partition with empty
+ *  exclusive_cpus, all the conflicting exclusive CPUs specified in the
+ *  following cpumasks of sibling cpusets will be removed from its
+ *  cpus_allowed in determining its effective_xcpus.
+ *  - effective_xcpus
+ *  - exclusive_cpus
+ *
+ *  The "cpuset.cpus.exclusive" control file should be used for setting up
+ *  partition if the users want to get as many CPUs as possible.
  */
 #define PRS_MEMBER		0
 #define PRS_ROOT		1
@@ -616,27 +627,25 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
  * Returns: true if CPU exclusivity conflict exists, false otherwise
  *
  * Conflict detection rules:
- * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
- * 2. exclusive_cpus masks cannot intersect between cpusets
- * 3. The allowed CPUs of a sibling cpuset cannot be a subset of the new exclusive CPUs
+ *  o cgroup v1
+ *    See cpuset1_cpus_excl_conflict()
+ *  o cgroup v2
+ *    - The exclusive_cpus values cannot overlap.
+ *    - New exclusive_cpus cannot be a superset of a sibling's cpus_allowed.
  */
 static inline bool cpus_excl_conflict(struct cpuset *trial, struct cpuset *sibling,
 				      bool xcpus_changed)
 {
-	/* If either cpuset is exclusive, check if they are mutually exclusive */
-	if (is_cpu_exclusive(trial) || is_cpu_exclusive(sibling))
-		return !cpusets_are_exclusive(trial, sibling);
-
-	/* Exclusive_cpus cannot intersect */
-	if (cpumask_intersects(trial->exclusive_cpus, sibling->exclusive_cpus))
-		return true;
+	if (!cpuset_v2())
+		return cpuset1_cpus_excl_conflict(trial, sibling);
 
 	/* The cpus_allowed of a sibling cpuset cannot be a subset of the new exclusive_cpus */
 	if (xcpus_changed && !cpumask_empty(sibling->cpus_allowed) &&
 	    cpumask_subset(sibling->cpus_allowed, trial->exclusive_cpus))
 		return true;
 
-	return false;
+	/* Exclusive_cpus cannot intersect */
+	return cpumask_intersects(trial->exclusive_cpus, sibling->exclusive_cpus);
 }
 
 static inline bool mems_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
@@ -2312,43 +2321,6 @@ static enum prs_errcode validate_partition(struct cpuset *cs, struct cpuset *tri
 	return PERR_NONE;
 }
 
-static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialcs,
-					struct tmpmasks *tmp)
-{
-	int retval;
-	struct cpuset *parent = parent_cs(cs);
-
-	retval = validate_change(cs, trialcs);
-
-	if ((retval == -EINVAL) && cpuset_v2()) {
-		struct cgroup_subsys_state *css;
-		struct cpuset *cp;
-
-		/*
-		 * The -EINVAL error code indicates that partition sibling
-		 * CPU exclusivity rule has been violated. We still allow
-		 * the cpumask change to proceed while invalidating the
-		 * partition. However, any conflicting sibling partitions
-		 * have to be marked as invalid too.
-		 */
-		trialcs->prs_err = PERR_NOTEXCL;
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
-		retval = 0;
-	}
-	return retval;
-}
-
 /**
  * partition_cpus_change - Handle partition state changes due to CPU mask updates
  * @cs: The target cpuset being modified
@@ -2408,15 +2380,15 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (cpumask_equal(cs->cpus_allowed, trialcs->cpus_allowed))
 		return 0;
 
-	if (alloc_tmpmasks(&tmp))
-		return -ENOMEM;
-
 	compute_trialcs_excpus(trialcs, cs);
 	trialcs->prs_err = PERR_NONE;
 
-	retval = cpus_allowed_validate_change(cs, trialcs, &tmp);
+	retval = validate_change(cs, trialcs);
 	if (retval < 0)
-		goto out_free;
+		return retval;
+
+	if (alloc_tmpmasks(&tmp))
+		return -ENOMEM;
 
 	/*
 	 * Check all the descendants in update_cpumasks_hier() if
@@ -2439,7 +2411,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	/* Update CS_SCHED_LOAD_BALANCE and/or sched_domains, if necessary */
 	if (cs->partition_root_state)
 		update_partition_sd_lb(cs, old_prs);
-out_free:
+
 	free_tmpmasks(&tmp);
 	return retval;
 }
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index a17256d9f88a..ff4540b0490e 100755
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
+	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-1|XA1:0-1|B1:2-3 A1:P1|B1:P1"
+	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-1|B1:2-3 A1:P0|B1:P1"
 
 	# cpuset.cpus can overlap with sibling cpuset.cpus.exclusive but not subsumed by it
 	"   C0-3     .      .    C4-5     X5     .      .      .     0 A1:0-3|B1:4-5"
@@ -417,6 +417,14 @@ TEST_MATRIX=(
 	" CX1-4:S+ CX2-4:P2 .    C5-6      .     .      .   P1:C3-6  0 A1:1|A2:2-4|B1:5-6 \
 								       A1:P0|A2:P2:B1:P-1 2-4"
 
+	# When multiple partitions with conflicting cpuset.cpus are created, the
+	# latter created ones will only get what are left of the available exclusive
+	# CPUs.
+	"  C1-3:P1   .      .      .       .     .      .   C3-5:P1  0 A1:1-3|B1:4-5:XB1:4-5 A1:P1|B1:P1"
+
+	# cpuset.cpus can be set to a subset of sibling's cpuset.cpus.exclusive
+	" C1-3:X1-3  .      .    C4-5      .     .      .     C1-2   0 A1:1-3|B1:1-2"
+
 	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
 	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
 	# Failure cases:
@@ -427,7 +435,7 @@ TEST_MATRIX=(
 	# Changes to cpuset.cpus.exclusive that violate exclusivity rule is rejected
 	"   C0-3     .      .    C4-5   X0-3     .      .     X3-5   1 A1:0-3|B1:4-5"
 
-	# cpuset.cpus cannot be a subset of sibling cpuset.cpus.exclusive
+	# cpuset.cpus.exclusive cannot be set to a superset of sibling's cpuset.cpus
 	"   C0-3     .      .    C4-5   X3-5     .      .      .     1 A1:0-3|B1:4-5"
 )
 
@@ -477,6 +485,10 @@ REMOTE_TEST_MATRIX=(
 	      .      .   X1-2:P2  X4-5:P1  .     X1-7:P2 p1:3|c11:1-2|c12:4:c22:5-6 \
 							 p1:P0|p2:P1|c11:P2|c12:P1|c22:P2 \
 							 1-2,4-6|1-2,5-6"
+	# c12 whose cpuset.cpus CPUs are all granted to c11 will become invalid partition
+	" C1-5:P1:S+ .  C1-4:P1   C2-3     .       .  \
+	      .      .     .       P1      .       .     p1:5|c11:1-4|c12:5 \
+							 p1:P1|c11:P1|c12:P-1"
 )
 
 #
-- 
2.52.0


