Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3298073FE15
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 16:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjF0Ohz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 10:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjF0Oh2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 10:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6552D69
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687876576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1aCXCO2KyOL2n9Hrr9rkIFvsodH267REOtUn/jOyQWs=;
        b=N0y/4XcoGcKk6DqWqOS3VtiSctRHEdGIDPLFwPom6XDuLWfvt8bp7T5J+K0satRnCGfHw9
        liK/3TQd3TJLFjQpgIZfaG0z8vSXfb47MCBI0mli+6WzFu6GTICRyuzOlnlTxUrbuMEQyB
        9Lt8eNOEyGM0DvbglLUqStWbrW7Mp8c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-ATvEByGoMgWRP9m0dCSyXA-1; Tue, 27 Jun 2023 10:36:11 -0400
X-MC-Unique: ATvEByGoMgWRP9m0dCSyXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 280D9854C35;
        Tue, 27 Jun 2023 14:35:36 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B71540C2063;
        Tue, 27 Jun 2023 14:35:35 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>, Phil Auld <pauld@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 5/9] cgroup/cpuset: Add cpuset.cpus.exclusive for v2
Date:   Tue, 27 Jun 2023 10:35:04 -0400
Message-Id: <20230627143508.1576882-6-longman@redhat.com>
In-Reply-To: <20230627143508.1576882-1-longman@redhat.com>
References: <20230627143508.1576882-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The creation of a cpuset partition means dedicating a set of exclusive
CPUs to be used by a particular partition only. These exclusive CPUs
will not be used by any cpusets outside of that partition.

To enable more flexibility in creating partitions, we need a way to
distribute exclusive CPUs that can be used in new partitions. Currently,
we have a subparts_cpus cpumask in struct cpuset that tracks only
the exclusive CPUs used by all the sub-partitions underneath a given
cpuset. This patch reworks the way we do exclusive CPUs tracking. The
subparts_cpus is now renamed to exclusive_cpus which tracks the exclusive
CPUs allocated to a partition root including those that are further
distributed down to sub-partitions underneath it. IOW, it also includes
the exclusive CPUs used by the current partition root.

The renamed exclusive_cpus is now exposed via a new read-only
"cpuset.cpus.exclusive" control file. The new exclusive_cpus cpumask
will be set to cpus_allowed when a cpuset becomes a partition root
and cleared if it is not a valid partition root.

In the next patch, we will enable write to this new control file and
allow it to differ from cpus_allowed. However, it must remains a subset
of cpus_allowed.

A parent cpuset can distribute an exclusive CPU to at most one of its
children only.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 733 ++++++++++++++++++++++++-----------------
 1 file changed, 428 insertions(+), 305 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 64f9e305b3ab..9f2ec8394736 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -78,7 +78,7 @@ enum prs_errcode {
 };
 
 static const char * const perr_strings[] = {
-	[PERR_INVCPUS]   = "Invalid cpu list in cpuset.cpus",
+	[PERR_INVCPUS]   = "Invalid cpu list in cpuset.cpus.exclusive",
 	[PERR_INVPARENT] = "Parent is an invalid partition root",
 	[PERR_NOTPART]   = "Parent is not a partition root",
 	[PERR_NOTEXCL]   = "Cpu list in cpuset.cpus not exclusive",
@@ -121,14 +121,18 @@ struct cpuset {
 	nodemask_t effective_mems;
 
 	/*
-	 * CPUs allocated to child sub-partitions (default hierarchy only)
-	 * - CPUs granted by the parent = effective_cpus U subparts_cpus
-	 * - effective_cpus and subparts_cpus are mutually exclusive.
+	 * Exclusive CPUs dedicated to current cgroup (default hierarchy only)
 	 *
-	 * effective_cpus contains only onlined CPUs, but subparts_cpus
-	 * may have offlined ones.
+	 * This exclusive CPUs must be a subset of cpus_allowed. A parent
+	 * cgroup can only grant exclusive CPUs to one of its children.
+	 *
+	 * When the cgroup becomes a valid partition root, exclusive_cpus
+	 * defaults to cpus_allowed if not set. The effective_cpus of a valid
+	 * partition root comes solely from its exclusive_cpus and some of the
+	 * exclusive_cpus may be distributed to sub-partitions below & hence
+	 * excluded from its effective_cpus.
 	 */
-	cpumask_var_t subparts_cpus;
+	cpumask_var_t exclusive_cpus;
 
 	/*
 	 * This is old Memory Nodes tasks took on.
@@ -156,8 +160,8 @@ struct cpuset {
 	/* for custom sched domain */
 	int relax_domain_level;
 
-	/* number of CPUs in subparts_cpus */
-	int nr_subparts_cpus;
+	/* number of valid sub-partitions */
+	int nr_subparts;
 
 	/* partition root state */
 	int partition_root_state;
@@ -185,6 +189,11 @@ struct cpuset {
 	struct cgroup_file partition_file;
 };
 
+/*
+ * Exclusive CPUs distributed out to sub-partitions of top_cpuset
+ */
+static cpumask_var_t	subpartitions_cpus;
+
 /*
  * Partition root states:
  *
@@ -312,7 +321,7 @@ static inline int is_partition_invalid(const struct cpuset *cs)
  */
 static inline void make_partition_invalid(struct cpuset *cs)
 {
-	if (is_partition_valid(cs))
+	if (cs->partition_root_state > 0)
 		cs->partition_root_state = -cs->partition_root_state;
 }
 
@@ -469,7 +478,7 @@ static inline bool partition_is_populated(struct cpuset *cs,
 
 	if (cs->css.cgroup->nr_populated_csets)
 		return true;
-	if (!excluded_child && !cs->nr_subparts_cpus)
+	if (!excluded_child && !cs->nr_subparts)
 		return cgroup_is_populated(cs->css.cgroup);
 
 	rcu_read_lock();
@@ -601,7 +610,7 @@ static inline int alloc_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
 	if (cs) {
 		pmask1 = &cs->cpus_allowed;
 		pmask2 = &cs->effective_cpus;
-		pmask3 = &cs->subparts_cpus;
+		pmask3 = &cs->exclusive_cpus;
 	} else {
 		pmask1 = &tmp->new_cpus;
 		pmask2 = &tmp->addmask;
@@ -636,7 +645,7 @@ static inline void free_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
 	if (cs) {
 		free_cpumask_var(cs->cpus_allowed);
 		free_cpumask_var(cs->effective_cpus);
-		free_cpumask_var(cs->subparts_cpus);
+		free_cpumask_var(cs->exclusive_cpus);
 	}
 	if (tmp) {
 		free_cpumask_var(tmp->new_cpus);
@@ -664,6 +673,7 @@ static struct cpuset *alloc_trial_cpuset(struct cpuset *cs)
 
 	cpumask_copy(trial->cpus_allowed, cs->cpus_allowed);
 	cpumask_copy(trial->effective_cpus, cs->effective_cpus);
+	cpumask_copy(trial->exclusive_cpus, cs->exclusive_cpus);
 	return trial;
 }
 
@@ -677,6 +687,25 @@ static inline void free_cpuset(struct cpuset *cs)
 	kfree(cs);
 }
 
+/*
+ * cpu_exclusive_check() - check if two cpusets are exclusive
+ *
+ * Return 0 if exclusive, -EINVAL if not
+ */
+static inline bool cpu_exclusive_check(struct cpuset *cs1, struct cpuset *cs2)
+{
+	struct cpumask *cpus1, *cpus2;
+
+	cpus1 = cpumask_empty(cs1->exclusive_cpus)
+		? cs1->cpus_allowed : cs1->exclusive_cpus;
+	cpus2 = cpumask_empty(cs2->exclusive_cpus)
+		? cs2->cpus_allowed : cs2->exclusive_cpus;
+
+	if (cpumask_intersects(cpus1, cpus2))
+		return -EINVAL;
+	return 0;
+}
+
 /*
  * validate_change_legacy() - Validate conditions specific to legacy (v1)
  *                            behavior.
@@ -776,9 +805,10 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	ret = -EINVAL;
 	cpuset_for_each_child(c, css, par) {
 		if ((is_cpu_exclusive(trial) || is_cpu_exclusive(c)) &&
-		    c != cur &&
-		    cpumask_intersects(trial->cpus_allowed, c->cpus_allowed))
-			goto out;
+		    c != cur) {
+			if (cpu_exclusive_check(trial, c))
+				goto out;
+		}
 		if ((is_mem_exclusive(trial) || is_mem_exclusive(c)) &&
 		    c != cur &&
 		    nodes_intersects(trial->mems_allowed, c->mems_allowed))
@@ -908,7 +938,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	csa = NULL;
 
 	/* Special case for the 99% of systems with one, full, sched domain */
-	if (root_load_balance && !top_cpuset.nr_subparts_cpus) {
+	if (root_load_balance && !top_cpuset.nr_subparts) {
 		ndoms = 1;
 		doms = alloc_sched_domains(ndoms);
 		if (!doms)
@@ -1159,7 +1189,7 @@ static void rebuild_sched_domains_locked(void)
 	 * should be the same as the active CPUs, so checking only top_cpuset
 	 * is enough to detect racing CPU offlines.
 	 */
-	if (!top_cpuset.nr_subparts_cpus &&
+	if (cpumask_empty(subpartitions_cpus) &&
 	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
 		return;
 
@@ -1168,7 +1198,7 @@ static void rebuild_sched_domains_locked(void)
 	 * root should be only a subset of the active CPUs.  Since a CPU in any
 	 * partition root could be offlined, all must be checked.
 	 */
-	if (top_cpuset.nr_subparts_cpus) {
+	if (top_cpuset.nr_subparts) {
 		rcu_read_lock();
 		cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
 			if (!is_partition_valid(cs)) {
@@ -1232,7 +1262,7 @@ static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 			 */
 			if ((task->flags & PF_KTHREAD) && kthread_is_per_cpu(task))
 				continue;
-			cpumask_andnot(new_cpus, possible_mask, cs->subparts_cpus);
+			cpumask_andnot(new_cpus, possible_mask, cs->exclusive_cpus);
 		} else {
 			cpumask_and(new_cpus, possible_mask, cs->effective_cpus);
 		}
@@ -1247,32 +1277,22 @@ static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
  * @cs: the cpuset the need to recompute the new effective_cpus mask
  * @parent: the parent cpuset
  *
- * If the parent has subpartition CPUs, include them in the list of
- * allowable CPUs in computing the new effective_cpus mask. Since offlined
- * CPUs are not removed from subparts_cpus, we have to use cpu_active_mask
- * to mask those out.
+ * The result is valid only if the given cpuset isn't a partition root.
  */
 static void compute_effective_cpumask(struct cpumask *new_cpus,
 				      struct cpuset *cs, struct cpuset *parent)
 {
-	if (parent->nr_subparts_cpus && is_partition_valid(cs)) {
-		cpumask_or(new_cpus, parent->effective_cpus,
-			   parent->subparts_cpus);
-		cpumask_and(new_cpus, new_cpus, cs->cpus_allowed);
-		cpumask_and(new_cpus, new_cpus, cpu_active_mask);
-	} else {
-		cpumask_and(new_cpus, cs->cpus_allowed, parent->effective_cpus);
-	}
+	cpumask_and(new_cpus, cs->cpus_allowed, parent->effective_cpus);
 }
 
 /*
- * Commands for update_parent_subparts_cpumask
+ * Commands for update_parent_effective_cpumask
  */
-enum subparts_cmd {
-	partcmd_enable,		/* Enable partition root	 */
-	partcmd_disable,	/* Disable partition root	 */
-	partcmd_update,		/* Update parent's subparts_cpus */
-	partcmd_invalidate,	/* Make partition invalid	 */
+enum partition_cmd {
+	partcmd_enable,		/* Enable partition root	  */
+	partcmd_disable,	/* Disable partition root	  */
+	partcmd_update,		/* Update parent's effective_cpus */
+	partcmd_invalidate,	/* Make partition invalid	  */
 };
 
 static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
@@ -1323,8 +1343,39 @@ static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
 		rebuild_sched_domains_locked();
 }
 
+/*
+ * tasks_nocpu_error - Return true if tasks will have no effective_cpus
+ */
+static bool tasks_nocpu_error(struct cpuset *parent, struct cpuset *cs,
+			      struct cpumask *xcpus)
+{
+	/*
+	 * A populated partition (cs or parent) can't have empty effective_cpus
+	 */
+	return (cpumask_subset(parent->effective_cpus, xcpus) &&
+		partition_is_populated(parent, cs)) ||
+	       (!cpumask_intersects(xcpus, cpu_active_mask) &&
+		partition_is_populated(cs, NULL));
+}
+
+/*
+ * setup_exclusive_cpus - setup exclusive_cpus if not set yet
+ */
+static void setup_exclusive_cpus(struct cpuset *cs, struct cpuset *parent)
+{
+	if (!cpumask_empty(cs->exclusive_cpus))
+		return;
+
+	if (!parent)
+		parent = parent_cs(cs);
+	spin_lock_irq(&callback_lock);
+	cpumask_and(cs->exclusive_cpus,
+		    cs->cpus_allowed, parent->exclusive_cpus);
+	spin_unlock_irq(&callback_lock);
+}
+
 /**
- * update_parent_subparts_cpumask - update subparts_cpus mask of parent cpuset
+ * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
  * @cmd:     Partition root state change command
  * @newmask: Optional new cpumask for partcmd_update
@@ -1332,21 +1383,20 @@ static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
  * Return:   0 or a partition root state error code
  *
  * For partcmd_enable, the cpuset is being transformed from a non-partition
- * root to a partition root. The cpus_allowed mask of the given cpuset will
- * be put into parent's subparts_cpus and taken away from parent's
+ * root to a partition root. The exclusive_cpus (cpus_allowed if exclusive_cpus
+ * not set) mask of the given cpuset will be taken away from parent's
  * effective_cpus. The function will return 0 if all the CPUs listed in
- * cpus_allowed can be granted or an error code will be returned.
+ * exclusive_cpus can be granted or an error code will be returned.
  *
  * For partcmd_disable, the cpuset is being transformed from a partition
- * root back to a non-partition root. Any CPUs in cpus_allowed that are in
- * parent's subparts_cpus will be taken away from that cpumask and put back
- * into parent's effective_cpus. 0 will always be returned.
+ * root back to a non-partition root. Any CPUs in exclusive_cpus will be
+ * given back to parent's effective_cpus. 0 will always be returned.
  *
  * For partcmd_update, if the optional newmask is specified, the cpu list is
- * to be changed from cpus_allowed to newmask. Otherwise, cpus_allowed is
+ * to be changed from exclusive_cpus to newmask. Otherwise, exclusive_cpus is
  * assumed to remain the same. The cpuset should either be a valid or invalid
  * partition root. The partition root state may change from valid to invalid
- * or vice versa. An error code will only be returned if transitioning from
+ * or vice versa. An error code will be returned if transitioning from
  * invalid to valid violates the exclusivity rule.
  *
  * For partcmd_invalidate, the current partition will be made invalid.
@@ -1361,18 +1411,47 @@ static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
  * check for error and so partition_root_state and prs_error will be updated
  * directly.
  */
-static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
-					  struct cpumask *newmask,
-					  struct tmpmasks *tmp)
+static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
+					   struct cpumask *newmask,
+					   struct tmpmasks *tmp)
 {
 	struct cpuset *parent = parent_cs(cs);
-	int adding;	/* Moving cpus from effective_cpus to subparts_cpus */
-	int deleting;	/* Moving cpus from subparts_cpus to effective_cpus */
+	int adding;	/* Adding cpus to parent's effective_cpus	*/
+	int deleting;	/* Deleting cpus from parent's effective_cpus	*/
 	int old_prs, new_prs;
 	int part_error = PERR_NONE;	/* Partition error? */
+	int subparts_delta = 0;
+	struct cpumask *xcpus;		/* cs exclusive_cpus */
+	bool nocpu;
 
 	lockdep_assert_held(&cpuset_mutex);
 
+	/*
+	 * new_prs will only be changed for the partcmd_update and
+	 * partcmd_invalidate commands.
+	 */
+	adding = deleting = false;
+	old_prs = new_prs = cs->partition_root_state;
+	xcpus = !cpumask_empty(cs->exclusive_cpus)
+		? cs->exclusive_cpus : cs->cpus_allowed;
+
+	if (cmd == partcmd_invalidate) {
+		if (is_prs_invalid(old_prs))
+			return 0;
+
+		/*
+		 * Make the current partition invalid.
+		 */
+		if (is_partition_valid(parent))
+			adding = cpumask_and(tmp->addmask,
+					     xcpus, parent->exclusive_cpus);
+		if (old_prs > 0) {
+			new_prs = -old_prs;
+			subparts_delta--;
+		}
+		goto write_error;
+	}
+
 	/*
 	 * The parent must be a partition root.
 	 * The new cpumask, if present, or the current cpus_allowed must
@@ -1385,124 +1464,122 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	if (!newmask && cpumask_empty(cs->cpus_allowed))
 		return PERR_CPUSEMPTY;
 
-	/*
-	 * new_prs will only be changed for the partcmd_update and
-	 * partcmd_invalidate commands.
-	 */
-	adding = deleting = false;
-	old_prs = new_prs = cs->partition_root_state;
+	nocpu = tasks_nocpu_error(parent, cs, xcpus);
+
 	if (cmd == partcmd_enable) {
 		/*
 		 * Enabling partition root is not allowed if cpus_allowed
 		 * doesn't overlap parent's cpus_allowed.
 		 */
-		if (!cpumask_intersects(cs->cpus_allowed, parent->cpus_allowed))
+		if (!cpumask_intersects(xcpus, parent->exclusive_cpus))
 			return PERR_INVCPUS;
 
 		/*
 		 * A parent can be left with no CPU as long as there is no
 		 * task directly associated with the parent partition.
 		 */
-		if (cpumask_subset(parent->effective_cpus, cs->cpus_allowed) &&
-		    partition_is_populated(parent, cs))
+		if (nocpu)
 			return PERR_NOCPUS;
 
-		cpumask_copy(tmp->addmask, cs->cpus_allowed);
-		adding = true;
+		cpumask_copy(tmp->delmask, xcpus);
+		deleting = true;
+		subparts_delta++;
 	} else if (cmd == partcmd_disable) {
 		/*
-		 * Need to remove cpus from parent's subparts_cpus for valid
-		 * partition root.
+		 n* May need to add cpus to parent's effective_cpus for
+		 * valid partition root.
 		 */
-		deleting = !is_prs_invalid(old_prs) &&
-			   cpumask_and(tmp->delmask, cs->cpus_allowed,
-				       parent->subparts_cpus);
-	} else if (cmd == partcmd_invalidate) {
-		if (is_prs_invalid(old_prs))
-			return 0;
-
+		adding = !is_prs_invalid(old_prs) &&
+			  cpumask_and(tmp->addmask, xcpus, parent->exclusive_cpus);
+		if (adding)
+			subparts_delta--;
+	} else if (newmask) {
 		/*
-		 * Make the current partition invalid. It is assumed that
-		 * invalidation is caused by violating cpu exclusivity rule.
+		 * Empty cpumask is not allowed
 		 */
-		deleting = cpumask_and(tmp->delmask, cs->cpus_allowed,
-				       parent->subparts_cpus);
-		if (old_prs > 0) {
-			new_prs = -old_prs;
-			part_error = PERR_NOTEXCL;
+		if (cpumask_empty(newmask)) {
+			part_error = PERR_CPUSEMPTY;
+			goto write_error;
 		}
-	} else if (newmask) {
+
 		/*
 		 * partcmd_update with newmask:
 		 *
-		 * Compute add/delete mask to/from subparts_cpus
+		 * Compute add/delete mask to/from effective_cpus
 		 *
-		 * delmask = cpus_allowed & ~newmask & parent->subparts_cpus
-		 * addmask = newmask & parent->cpus_allowed
-		 *		     & ~parent->subparts_cpus
+		 * addmask = exclusive_cpus & ~newmask & parent->exclusive_cpus
+		 * delmask = newmask & ~cs->exclusive_cpus
+		 *		     & parent->exclusive_cpus
 		 */
-		cpumask_andnot(tmp->delmask, cs->cpus_allowed, newmask);
-		deleting = cpumask_and(tmp->delmask, tmp->delmask,
-				       parent->subparts_cpus);
+		cpumask_andnot(tmp->addmask, xcpus, newmask);
+		adding = cpumask_and(tmp->addmask, tmp->addmask,
+				     parent->exclusive_cpus);
 
-		cpumask_and(tmp->addmask, newmask, parent->cpus_allowed);
-		adding = cpumask_andnot(tmp->addmask, tmp->addmask,
-					parent->subparts_cpus);
-		/*
-		 * Empty cpumask is not allowed
-		 */
-		if (cpumask_empty(newmask)) {
-			part_error = PERR_CPUSEMPTY;
+		cpumask_andnot(tmp->delmask, newmask, xcpus);
+		deleting = cpumask_and(tmp->delmask, tmp->delmask,
+				       parent->exclusive_cpus);
 		/*
 		 * Make partition invalid if parent's effective_cpus could
 		 * become empty and there are tasks in the parent.
 		 */
-		} else if (adding &&
-		    cpumask_subset(parent->effective_cpus, tmp->addmask) &&
-		    !cpumask_intersects(tmp->delmask, cpu_active_mask) &&
-		    partition_is_populated(parent, cs)) {
+		if (nocpu && (!adding ||
+		    !cpumask_intersects(tmp->addmask, cpu_active_mask))) {
 			part_error = PERR_NOCPUS;
-			adding = false;
-			deleting = cpumask_and(tmp->delmask, cs->cpus_allowed,
-					       parent->subparts_cpus);
+			deleting = false;
+			adding = cpumask_and(tmp->addmask,
+					     xcpus, parent->exclusive_cpus);
 		}
 	} else {
 		/*
-		 * partcmd_update w/o newmask:
+		 * partcmd_update w/o newmask
+		 *
+		 * delmask = exclusive_cpus & parent->effective_cpus
+		 *
+		 * This can be called from:
+		 * 1) update_cpumasks_hier()
+		 * 2) cpuset_hotplug_update_tasks()
 		 *
-		 * delmask = cpus_allowed & parent->subparts_cpus
-		 * addmask = cpus_allowed & parent->cpus_allowed
-		 *			  & ~parent->subparts_cpus
+		 * Check to see if it can be transitioned from valid to
+		 * invalid partition or vice versa.
 		 *
-		 * This gets invoked either due to a hotplug event or from
-		 * update_cpumasks_hier(). This can cause the state of a
-		 * partition root to transition from valid to invalid or vice
-		 * versa. So we still need to compute the addmask and delmask.
-
-		 * A partition error happens when:
-		 * 1) Cpuset is valid partition, but parent does not distribute
-		 *    out any CPUs.
-		 * 2) Parent has tasks and all its effective CPUs will have
-		 *    to be distributed out.
+		 * A partition error happens when parent has tasks and all
+		 * its effective CPUs will have to be distributed out.
 		 */
-		cpumask_and(tmp->addmask, cs->cpus_allowed,
-					  parent->cpus_allowed);
-		adding = cpumask_andnot(tmp->addmask, tmp->addmask,
-					parent->subparts_cpus);
-
-		if ((is_partition_valid(cs) && !parent->nr_subparts_cpus) ||
-		    (adding &&
-		     cpumask_subset(parent->effective_cpus, tmp->addmask) &&
-		     partition_is_populated(parent, cs))) {
+		WARN_ON_ONCE(!is_partition_valid(parent));
+		if (nocpu) {
 			part_error = PERR_NOCPUS;
-			adding = false;
-		}
+			if (is_partition_valid(cs))
+				adding = cpumask_and(tmp->addmask,
+						xcpus, parent->exclusive_cpus);
+		} else if (is_partition_invalid(cs) &&
+			   cpumask_subset(xcpus, parent->exclusive_cpus)) {
+			struct cgroup_subsys_state *css;
+			struct cpuset *child;
+			bool exclusive = true;
 
-		if (part_error && is_partition_valid(cs) &&
-		    parent->nr_subparts_cpus)
-			deleting = cpumask_and(tmp->delmask, cs->cpus_allowed,
-					       parent->subparts_cpus);
+			/*
+			 * Convert invalid partition to valid has to
+			 * pass the cpu exclusivity test.
+			 */
+			rcu_read_lock();
+			cpuset_for_each_child(child, css, parent) {
+				if (child == cs)
+					continue;
+				if (cpu_exclusive_check(cs, child)) {
+					exclusive = false;
+					break;
+				}
+			}
+			rcu_read_unlock();
+			if (exclusive)
+				deleting = cpumask_and(tmp->delmask,
+						xcpus, parent->effective_cpus);
+			else
+				part_error = PERR_NOTEXCL;
+		}
 	}
+
+write_error:
 	if (part_error)
 		WRITE_ONCE(cs->prs_err, part_error);
 
@@ -1514,13 +1591,17 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		switch (cs->partition_root_state) {
 		case PRS_ROOT:
 		case PRS_ISOLATED:
-			if (part_error)
+			if (part_error) {
 				new_prs = -old_prs;
+				subparts_delta--;
+			}
 			break;
 		case PRS_INVALID_ROOT:
 		case PRS_INVALID_ISOLATED:
-			if (!part_error)
+			if (!part_error) {
 				new_prs = -old_prs;
+				subparts_delta++;
+			}
 			break;
 		}
 	}
@@ -1540,32 +1621,43 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	}
 
 	/*
-	 * Change the parent's subparts_cpus.
+	 * Change the parent's effective_cpus & exclusive_cpus (top cpuset
+	 * only).
+	 *
 	 * Newly added CPUs will be removed from effective_cpus and
 	 * newly deleted ones will be added back to effective_cpus.
 	 */
 	spin_lock_irq(&callback_lock);
 	if (adding) {
-		cpumask_or(parent->subparts_cpus,
-			   parent->subparts_cpus, tmp->addmask);
-		cpumask_andnot(parent->effective_cpus,
-			       parent->effective_cpus, tmp->addmask);
-	}
-	if (deleting) {
-		cpumask_andnot(parent->subparts_cpus,
-			       parent->subparts_cpus, tmp->delmask);
+		if (parent == &top_cpuset)
+			cpumask_andnot(subpartitions_cpus,
+				       subpartitions_cpus, tmp->addmask);
 		/*
-		 * Some of the CPUs in subparts_cpus might have been offlined.
+		 * Some of the CPUs in exclusive_cpus might have been offlined.
 		 */
-		cpumask_and(tmp->delmask, tmp->delmask, cpu_active_mask);
 		cpumask_or(parent->effective_cpus,
-			   parent->effective_cpus, tmp->delmask);
+			   parent->effective_cpus, tmp->addmask);
+		cpumask_and(parent->effective_cpus,
+			    parent->effective_cpus, cpu_active_mask);
+	}
+	if (deleting) {
+		if (parent == &top_cpuset)
+			cpumask_or(subpartitions_cpus,
+				   subpartitions_cpus, tmp->delmask);
+		cpumask_andnot(parent->effective_cpus,
+			       parent->effective_cpus, tmp->delmask);
 	}
 
-	parent->nr_subparts_cpus = cpumask_weight(parent->subparts_cpus);
+	if (is_partition_valid(parent)) {
+		parent->nr_subparts += subparts_delta;
+		WARN_ON_ONCE(parent->nr_subparts < 0);
+	}
 
-	if (old_prs != new_prs)
+	if (old_prs != new_prs) {
 		cs->partition_root_state = new_prs;
+		if (new_prs <= 0)
+			cs->nr_subparts = 0;
+	}
 
 	spin_unlock_irq(&callback_lock);
 
@@ -1590,6 +1682,71 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	return 0;
 }
 
+/**
+ * compute_partition_effective_cpumask - compute effective_cpus for partition
+ * @cs: partition root cpuset
+ * @new_ecpus: previously computed effective_cpus to be updated
+ *
+ * Compute the effective_cpus of a partition root by scanning exclusive_cpus
+ * of child partition roots and exclusing their exclusive_cpus.
+ *
+ * This has the side effect of invalidating valid child partition roots,
+ * if necessary. Since it is called from either cpuset_hotplug_update_tasks()
+ * or update_cpumasks_hier() where parent and children are modified
+ * successively, we don't need to call update_parent_effective_cpumask()
+ * and the child's effective_cpus will be updated in later iterations.
+ *
+ * Note that rcu_read_lock() is assumed to be held.
+ */
+static void compute_partition_effective_cpumask(struct cpuset *cs,
+						struct cpumask *new_ecpus)
+{
+	struct cgroup_subsys_state *css;
+	struct cpuset *child;
+	bool populated = partition_is_populated(cs, NULL);
+
+	/*
+	 * Check child partition roots to see if they should be
+	 * invalidated when
+	 *  1) child exclusive_cpus not a subset of new
+	 *     excluisve_cpus
+	 *  2) All the effective_cpus will be used up and cp
+	 *     has tasks
+	 */
+	cpumask_and(new_ecpus, cs->exclusive_cpus, cpu_active_mask);
+	rcu_read_lock();
+	cpuset_for_each_child(child, css, cs) {
+		if (!is_partition_valid(child))
+			continue;
+
+		child->prs_err = 0;
+		if (!cpumask_subset(child->exclusive_cpus,
+				    cs->exclusive_cpus))
+			child->prs_err = PERR_INVCPUS;
+		else if (populated &&
+			 cpumask_subset(new_ecpus, child->exclusive_cpus))
+			child->prs_err = PERR_NOCPUS;
+
+		if (child->prs_err) {
+			int old_prs = child->partition_root_state;
+
+			/*
+			 * Invalidate child partition
+			 */
+			spin_lock_irq(&callback_lock);
+			make_partition_invalid(child);
+			cs->nr_subparts--;
+			child->nr_subparts = 0;
+			spin_unlock_irq(&callback_lock);
+			notify_partition_change(child, old_prs);
+			continue;
+		}
+		cpumask_andnot(new_ecpus, new_ecpus,
+			       child->exclusive_cpus);
+	}
+	rcu_read_unlock();
+}
+
 /*
  * update_cpumasks_hier() flags
  */
@@ -1624,6 +1781,19 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 
 		compute_effective_cpumask(tmp->new_cpus, cp, parent);
 
+		if (is_partition_valid(parent) && is_partition_valid(cp))
+			compute_partition_effective_cpumask(cp, tmp->new_cpus);
+
+		/*
+		 * A partition with no effective_cpus is allowed as long as
+		 * there is no task associated with it. Call
+		 * update_parent_effective_cpumask() to check it.
+		 */
+		if (is_partition_valid(cp) && cpumask_empty(tmp->new_cpus)) {
+			update_parent = true;
+			goto update_parent_effective;
+		}
+
 		/*
 		 * If it becomes empty, inherit the effective mask of the
 		 * parent, which is guaranteed to have some CPUs unless
@@ -1631,10 +1801,6 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * out all its CPUs.
 		 */
 		if (is_in_v2_mode() && cpumask_empty(tmp->new_cpus)) {
-			if (is_partition_valid(cp) &&
-			    cpumask_equal(cp->cpus_allowed, cp->subparts_cpus))
-				goto update_parent_subparts;
-
 			cpumask_copy(tmp->new_cpus, parent->effective_cpus);
 			if (!cp->use_parent_ecpus) {
 				cp->use_parent_ecpus = true;
@@ -1661,12 +1827,12 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 			continue;
 		}
 
-update_parent_subparts:
+update_parent_effective:
 		/*
-		 * update_parent_subparts_cpumask() should have been called
+		 * update_parent_effective_cpumask() should have been called
 		 * for cs already in update_cpumask(). We should also call
 		 * update_tasks_cpumask() again for tasks in the parent
-		 * cpuset if the parent's subparts_cpus changes.
+		 * cpuset if the parent's effective_cpus changes.
 		 */
 		old_prs = new_prs = cp->partition_root_state;
 		if ((cp != cs) && old_prs) {
@@ -1696,8 +1862,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		rcu_read_unlock();
 
 		if (update_parent) {
-			update_parent_subparts_cpumask(cp, partcmd_update, NULL,
-						       tmp);
+			update_parent_effective_cpumask(cp, partcmd_update, NULL, tmp);
 			/*
 			 * The cpuset partition_root_state may become
 			 * invalid. Capture it.
@@ -1706,30 +1871,18 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		}
 
 		spin_lock_irq(&callback_lock);
-
-		if (cp->nr_subparts_cpus && !is_partition_valid(cp)) {
-			/*
-			 * Put all active subparts_cpus back to effective_cpus.
-			 */
-			cpumask_or(tmp->new_cpus, tmp->new_cpus,
-				   cp->subparts_cpus);
-			cpumask_and(tmp->new_cpus, tmp->new_cpus,
-				   cpu_active_mask);
-			cp->nr_subparts_cpus = 0;
-			cpumask_clear(cp->subparts_cpus);
-		}
-
 		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
-		if (cp->nr_subparts_cpus) {
-			/*
-			 * Make sure that effective_cpus & subparts_cpus
-			 * are mutually exclusive.
-			 */
-			cpumask_andnot(cp->effective_cpus, cp->effective_cpus,
-				       cp->subparts_cpus);
-		}
-
 		cp->partition_root_state = new_prs;
+		if ((new_prs > 0) && cpumask_empty(cp->exclusive_cpus))
+			cpumask_and(cp->exclusive_cpus,
+				    cp->cpus_allowed, parent->exclusive_cpus);
+		if (new_prs < 0) {
+			/* Reset partition data */
+			cp->nr_subparts = 0;
+			cpumask_clear(cp->exclusive_cpus);
+			if (is_cpu_exclusive(cp))
+				clear_bit(CS_CPU_EXCLUSIVE, &cp->flags);
+		}
 		spin_unlock_irq(&callback_lock);
 
 		notify_partition_change(cp, old_prs);
@@ -1826,6 +1979,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 {
 	int retval;
 	struct tmpmasks tmp;
+	struct cpuset *parent = parent_cs(cs);
 	bool invalidate = false;
 	int old_prs = cs->partition_root_state;
 
@@ -1841,6 +1995,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	 */
 	if (!*buf) {
 		cpumask_clear(trialcs->cpus_allowed);
+		cpumask_clear(trialcs->exclusive_cpus);
 	} else {
 		retval = cpulist_parse(buf, trialcs->cpus_allowed);
 		if (retval < 0)
@@ -1849,6 +2004,13 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		if (!cpumask_subset(trialcs->cpus_allowed,
 				    top_cpuset.cpus_allowed))
 			return -EINVAL;
+
+		/*
+		 * When exclusive_cpus is set, make sure it is a subset of
+		 * cpus_allowed and parent's exclusive_cpus.
+		 */
+		cpumask_and(trialcs->exclusive_cpus,
+			    parent->exclusive_cpus, trialcs->cpus_allowed);
 	}
 
 	/* Nothing to do if the cpus didn't change */
@@ -1858,11 +2020,21 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (alloc_cpumasks(NULL, &tmp))
 		return -ENOMEM;
 
+	if (is_partition_valid(cs)) {
+		if (cpumask_empty(trialcs->exclusive_cpus)) {
+			invalidate = true;
+			cs->prs_err = PERR_INVCPUS;
+		} else if (tasks_nocpu_error(parent, cs, trialcs->exclusive_cpus)) {
+			invalidate = true;
+			cs->prs_err = PERR_NOCPUS;
+		}
+	}
+
 	retval = validate_change(cs, trialcs);
 
 	if ((retval == -EINVAL) && cgroup_subsys_on_dfl(cpuset_cgrp_subsys)) {
-		struct cpuset *cp, *parent;
 		struct cgroup_subsys_state *css;
+		struct cpuset *cp;
 
 		/*
 		 * The -EINVAL error code indicates that partition sibling
@@ -1873,69 +2045,44 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		 */
 		invalidate = true;
 		rcu_read_lock();
-		parent = parent_cs(cs);
 		cpuset_for_each_child(cp, css, parent)
 			if (is_partition_valid(cp) &&
-			    cpumask_intersects(trialcs->cpus_allowed, cp->cpus_allowed)) {
+			    cpumask_intersects(trialcs->exclusive_cpus, cp->exclusive_cpus)) {
 				rcu_read_unlock();
-				update_parent_subparts_cpumask(cp, partcmd_invalidate, NULL, &tmp);
+				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, &tmp);
 				rcu_read_lock();
 			}
 		rcu_read_unlock();
 		retval = 0;
 	}
+
 	if (retval < 0)
 		goto out_free;
 
 	if (cs->partition_root_state) {
 		if (invalidate)
-			update_parent_subparts_cpumask(cs, partcmd_invalidate,
-						       NULL, &tmp);
+			update_parent_effective_cpumask(cs, partcmd_invalidate,
+							NULL, &tmp);
 		else
-			update_parent_subparts_cpumask(cs, partcmd_update,
-						trialcs->cpus_allowed, &tmp);
+			update_parent_effective_cpumask(cs, partcmd_update,
+						trialcs->exclusive_cpus, &tmp);
 	}
 
-	compute_effective_cpumask(trialcs->effective_cpus, trialcs,
-				  parent_cs(cs));
 	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, trialcs->cpus_allowed);
+	if (!is_partition_valid(cs))
+		cpumask_clear(cs->exclusive_cpus);
+	else
+		cpumask_copy(cs->exclusive_cpus, trialcs->exclusive_cpus);
 
-	/*
-	 * Make sure that subparts_cpus, if not empty, is a subset of
-	 * cpus_allowed. Clear subparts_cpus if partition not valid or
-	 * empty effective cpus with tasks.
-	 */
-	if (cs->nr_subparts_cpus) {
-		if (!is_partition_valid(cs) ||
-		   (cpumask_subset(trialcs->effective_cpus, cs->subparts_cpus) &&
-		    partition_is_populated(cs, NULL))) {
-			cs->nr_subparts_cpus = 0;
-			cpumask_clear(cs->subparts_cpus);
-		} else {
-			cpumask_and(cs->subparts_cpus, cs->subparts_cpus,
-				    cs->cpus_allowed);
-			cs->nr_subparts_cpus = cpumask_weight(cs->subparts_cpus);
-		}
-	}
 	spin_unlock_irq(&callback_lock);
 
 	/* effective_cpus will be updated here */
 	update_cpumasks_hier(cs, &tmp, 0);
 
-	if (cs->partition_root_state) {
-		struct cpuset *parent = parent_cs(cs);
-
-		/*
-		 * For partition root, update the cpumasks of sibling
-		 * cpusets if they use parent's effective_cpus.
-		 */
-		if (parent->child_ecpus_count)
-			update_sibling_cpumasks(parent, cs, &tmp);
-
-		/* Update CS_SCHED_LOAD_BALANCE and/or sched_domains */
+	/* Update CS_SCHED_LOAD_BALANCE and/or sched_domains, if necessary */
+	if (cs->partition_root_state)
 		update_partition_sd_lb(cs, old_prs);
-	}
 out_free:
 	free_cpumasks(NULL, &tmp);
 	return 0;
@@ -2313,7 +2460,6 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 static int update_prstate(struct cpuset *cs, int new_prs)
 {
 	int err = PERR_NONE, old_prs = cs->partition_root_state;
-	struct cpuset *parent = parent_cs(cs);
 	struct tmpmasks tmpmask;
 
 	if (old_prs == new_prs)
@@ -2331,6 +2477,13 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (alloc_cpumasks(NULL, &tmpmask))
 		return -ENOMEM;
 
+	/*
+	 * Setup exclusive_cpus if not set yet, it will be cleared later
+	 * if partition becomes invalid.
+	 */
+	if (new_prs > 0)
+		setup_exclusive_cpus(cs, NULL);
+
 	err = update_partition_exclusive(cs, new_prs);
 	if (err)
 		goto out;
@@ -2344,8 +2497,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 			goto out;
 		}
 
-		err = update_parent_subparts_cpumask(cs, partcmd_enable,
-						     NULL, &tmpmask);
+		err = update_parent_effective_cpumask(cs, partcmd_enable,
+						      NULL, &tmpmask);
 	} else if (old_prs && new_prs) {
 		/*
 		 * A change in load balance state only, no change in cpumasks.
@@ -2356,19 +2509,13 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * Switching back to member is always allowed even if it
 		 * disables child partitions.
 		 */
-		update_parent_subparts_cpumask(cs, partcmd_disable, NULL,
-					       &tmpmask);
+		update_parent_effective_cpumask(cs, partcmd_disable, NULL,
+						&tmpmask);
 
 		/*
-		 * If there are child partitions, they will all become invalid.
+		 * Invalidation of child partitions will be done in
+		 * update_cpumasks_hier().
 		 */
-		if (unlikely(cs->nr_subparts_cpus)) {
-			spin_lock_irq(&callback_lock);
-			cs->nr_subparts_cpus = 0;
-			cpumask_clear(cs->subparts_cpus);
-			compute_effective_cpumask(cs->effective_cpus, cs, parent);
-			spin_unlock_irq(&callback_lock);
-		}
 	}
 out:
 	/*
@@ -2383,14 +2530,12 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	spin_lock_irq(&callback_lock);
 	cs->partition_root_state = new_prs;
 	WRITE_ONCE(cs->prs_err, err);
+	if (!is_partition_valid(cs))
+		cpumask_clear(cs->exclusive_cpus);
 	spin_unlock_irq(&callback_lock);
 
-	/*
-	 * Update child cpusets, if present.
-	 * Force update if switching back to member.
-	 */
-	if (!list_empty(&cs->css.children))
-		update_cpumasks_hier(cs, &tmpmask, !new_prs ? HIER_CHECKALL : 0);
+	/* Force update if switching back to member */
+	update_cpumasks_hier(cs, &tmpmask, !new_prs ? HIER_CHECKALL : 0);
 
 	/* Update sched domains and load balance flag */
 	update_partition_sd_lb(cs, old_prs);
@@ -2626,7 +2771,7 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 		guarantee_online_cpus(task, cpus_attach);
 	else
 		cpumask_andnot(cpus_attach, task_cpu_possible_mask(task),
-			       cs->subparts_cpus);
+			       subpartitions_cpus);
 	/*
 	 * can_attach beforehand should guarantee that this doesn't
 	 * fail.  TODO: have a better way to handle failure here
@@ -2729,6 +2874,7 @@ typedef enum {
 	FILE_EFFECTIVE_CPULIST,
 	FILE_EFFECTIVE_MEMLIST,
 	FILE_SUBPARTS_CPULIST,
+	FILE_EXCLUSIVE_CPULIST,
 	FILE_CPU_EXCLUSIVE,
 	FILE_MEM_EXCLUSIVE,
 	FILE_MEM_HARDWALL,
@@ -2913,8 +3059,11 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	case FILE_EFFECTIVE_MEMLIST:
 		seq_printf(sf, "%*pbl\n", nodemask_pr_args(&cs->effective_mems));
 		break;
+	case FILE_EXCLUSIVE_CPULIST:
+		seq_printf(sf, "%*pbl\n", cpumask_pr_args(cs->exclusive_cpus));
+		break;
 	case FILE_SUBPARTS_CPULIST:
-		seq_printf(sf, "%*pbl\n", cpumask_pr_args(cs->subparts_cpus));
+		seq_printf(sf, "%*pbl\n", cpumask_pr_args(subpartitions_cpus));
 		break;
 	default:
 		ret = -EINVAL;
@@ -3186,11 +3335,18 @@ static struct cftype dfl_files[] = {
 		.file_offset = offsetof(struct cpuset, partition_file),
 	},
 
+	{
+		.name = "cpus.exclusive",
+		.seq_show = cpuset_common_seq_show,
+		.private = FILE_EXCLUSIVE_CPULIST,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+
 	{
 		.name = "cpus.subpartitions",
 		.seq_show = cpuset_common_seq_show,
 		.private = FILE_SUBPARTS_CPULIST,
-		.flags = CFTYPE_DEBUG,
+		.flags = CFTYPE_ONLY_ON_ROOT | CFTYPE_DEBUG,
 	},
 
 	{ }	/* terminate */
@@ -3364,6 +3520,7 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
 
 	if (is_in_v2_mode()) {
 		cpumask_copy(top_cpuset.cpus_allowed, cpu_possible_mask);
+		cpumask_copy(top_cpuset.exclusive_cpus, cpu_possible_mask);
 		top_cpuset.mems_allowed = node_possible_map;
 	} else {
 		cpumask_copy(top_cpuset.cpus_allowed,
@@ -3502,11 +3659,13 @@ int __init cpuset_init(void)
 {
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.cpus_allowed, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_cpus, GFP_KERNEL));
-	BUG_ON(!zalloc_cpumask_var(&top_cpuset.subparts_cpus, GFP_KERNEL));
+	BUG_ON(!alloc_cpumask_var(&top_cpuset.exclusive_cpus, GFP_KERNEL));
+	BUG_ON(!zalloc_cpumask_var(&subpartitions_cpus, GFP_KERNEL));
 
 	cpumask_setall(top_cpuset.cpus_allowed);
 	nodes_setall(top_cpuset.mems_allowed);
 	cpumask_setall(top_cpuset.effective_cpus);
+	cpumask_setall(top_cpuset.exclusive_cpus);
 	nodes_setall(top_cpuset.effective_mems);
 
 	fmeter_init(&top_cpuset.fmeter);
@@ -3647,30 +3806,15 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	compute_effective_cpumask(&new_cpus, cs, parent);
 	nodes_and(new_mems, cs->mems_allowed, parent->effective_mems);
 
-	if (cs->nr_subparts_cpus)
-		/*
-		 * Make sure that CPUs allocated to child partitions
-		 * do not show up in effective_cpus.
-		 */
-		cpumask_andnot(&new_cpus, &new_cpus, cs->subparts_cpus);
-
 	if (!tmp || !cs->partition_root_state)
 		goto update_tasks;
 
 	/*
-	 * In the unlikely event that a partition root has empty
-	 * effective_cpus with tasks, we will have to invalidate child
-	 * partitions, if present, by setting nr_subparts_cpus to 0 to
-	 * reclaim their cpus.
+	 * Compute effective_cpus for valid partition root, may invalidate
+	 * child partition roots if necessary.
 	 */
-	if (cs->nr_subparts_cpus && is_partition_valid(cs) &&
-	    cpumask_empty(&new_cpus) && partition_is_populated(cs, NULL)) {
-		spin_lock_irq(&callback_lock);
-		cs->nr_subparts_cpus = 0;
-		cpumask_clear(cs->subparts_cpus);
-		spin_unlock_irq(&callback_lock);
-		compute_effective_cpumask(&new_cpus, cs, parent);
-	}
+	if (is_partition_valid(cs) && is_partition_valid(parent))
+		compute_partition_effective_cpumask(cs, &new_cpus);
 
 	/*
 	 * Force the partition to become invalid if either one of
@@ -3679,44 +3823,23 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 * 2) parent is invalid or doesn't grant any cpus to child
 	 *    partitions.
 	 */
-	if (is_partition_valid(cs) && (!parent->nr_subparts_cpus ||
-	   (cpumask_empty(&new_cpus) && partition_is_populated(cs, NULL)))) {
-		int old_prs, parent_prs;
-
-		update_parent_subparts_cpumask(cs, partcmd_disable, NULL, tmp);
-		if (cs->nr_subparts_cpus) {
-			spin_lock_irq(&callback_lock);
-			cs->nr_subparts_cpus = 0;
-			cpumask_clear(cs->subparts_cpus);
-			spin_unlock_irq(&callback_lock);
-			compute_effective_cpumask(&new_cpus, cs, parent);
-		}
-
-		old_prs = cs->partition_root_state;
-		parent_prs = parent->partition_root_state;
-		if (is_partition_valid(cs)) {
-			spin_lock_irq(&callback_lock);
-			make_partition_invalid(cs);
-			spin_unlock_irq(&callback_lock);
-			if (is_prs_invalid(parent_prs))
-				WRITE_ONCE(cs->prs_err, PERR_INVPARENT);
-			else if (!parent_prs)
-				WRITE_ONCE(cs->prs_err, PERR_NOTPART);
-			else
-				WRITE_ONCE(cs->prs_err, PERR_HOTPLUG);
-			notify_partition_change(cs, old_prs);
-		}
+	if (is_partition_valid(cs) && (!is_partition_valid(parent) ||
+				tasks_nocpu_error(parent, cs, &new_cpus))) {
+		update_parent_effective_cpumask(cs, partcmd_invalidate, NULL, tmp);
+		compute_effective_cpumask(&new_cpus, cs, parent);
 		cpuset_force_rebuild();
 	}
-
 	/*
 	 * On the other hand, an invalid partition root may be transitioned
 	 * back to a regular one.
 	 */
 	else if (is_partition_valid(parent) && is_partition_invalid(cs)) {
-		update_parent_subparts_cpumask(cs, partcmd_update, NULL, tmp);
-		if (is_partition_valid(cs))
+		update_parent_effective_cpumask(cs, partcmd_update, NULL, tmp);
+		if (is_partition_valid(cs)) {
+			setup_exclusive_cpus(cs, parent);
+			compute_partition_effective_cpumask(cs, &new_cpus);
 			cpuset_force_rebuild();
+		}
 	}
 
 update_tasks:
@@ -3773,21 +3896,22 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	new_mems = node_states[N_MEMORY];
 
 	/*
-	 * If subparts_cpus is populated, it is likely that the check below
-	 * will produce a false positive on cpus_updated when the cpu list
-	 * isn't changed. It is extra work, but it is better to be safe.
+	 * If subpartitions_cpus is populated, it is likely that the check
+	 * below will produce a false positive on cpus_updated when the cpu
+	 * list isn't changed. It is extra work, but it is better to be safe.
 	 */
-	cpus_updated = !cpumask_equal(top_cpuset.effective_cpus, &new_cpus);
+	cpus_updated = !cpumask_equal(top_cpuset.effective_cpus, &new_cpus) ||
+		       !cpumask_empty(subpartitions_cpus);
 	mems_updated = !nodes_equal(top_cpuset.effective_mems, new_mems);
 
 	/*
-	 * In the rare case that hotplug removes all the cpus in subparts_cpus,
-	 * we assumed that cpus are updated.
+	 * In the rare case that hotplug removes all the cpus in
+	 * subpartitions_cpus, we assumed that cpus are updated.
 	 */
-	if (!cpus_updated && top_cpuset.nr_subparts_cpus)
+	if (!cpus_updated && top_cpuset.nr_subparts)
 		cpus_updated = true;
 
-	/* synchronize cpus_allowed to cpu_active_mask */
+	/* For v1, synchronize cpus_allowed to cpu_active_mask */
 	if (cpus_updated) {
 		spin_lock_irq(&callback_lock);
 		if (!on_dfl)
@@ -3795,17 +3919,16 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 		/*
 		 * Make sure that CPUs allocated to child partitions
 		 * do not show up in effective_cpus. If no CPU is left,
-		 * we clear the subparts_cpus & let the child partitions
+		 * we clear the subpartitions_cpus & let the child partitions
 		 * fight for the CPUs again.
 		 */
-		if (top_cpuset.nr_subparts_cpus) {
-			if (cpumask_subset(&new_cpus,
-					   top_cpuset.subparts_cpus)) {
-				top_cpuset.nr_subparts_cpus = 0;
-				cpumask_clear(top_cpuset.subparts_cpus);
+		if (!cpumask_empty(subpartitions_cpus)) {
+			if (cpumask_subset(&new_cpus, subpartitions_cpus)) {
+				top_cpuset.nr_subparts = 0;
+				cpumask_clear(subpartitions_cpus);
 			} else {
 				cpumask_andnot(&new_cpus, &new_cpus,
-					       top_cpuset.subparts_cpus);
+					       subpartitions_cpus);
 			}
 		}
 		cpumask_copy(top_cpuset.effective_cpus, &new_cpus);
@@ -3937,7 +4060,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 		 * We first exclude cpus allocated to partitions. If there is no
 		 * allowable online cpu left, we fall back to all possible cpus.
 		 */
-		cpumask_andnot(pmask, possible_mask, top_cpuset.subparts_cpus);
+		cpumask_andnot(pmask, possible_mask, subpartitions_cpus);
 		if (!cpumask_intersects(pmask, cpu_online_mask))
 			cpumask_copy(pmask, possible_mask);
 	}
-- 
2.31.1

