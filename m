Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A978B73FDFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 16:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjF0Og7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 10:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjF0Og6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 10:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A33330F4
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687876566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UX2Fp+D0urB/VW9aCOtFzkSRR1R8cgucSvMdsOv+zvU=;
        b=JBHOwB5HFKV4O3YystdkivUqgNXao0Gjwt/zACi05jLNYO14qn3sX7BTq+FRWPOjWHCsQ1
        +jYMfcWPCLNgOLIeihdvFQv6Flohggxa3YknwzW/WqvbzvIS+2WpGP8Qp8mOx+F0dVHaFF
        QldjMiCjSLKerx7vXobfI4K+B0/3HJA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-k73gLARBNf-DecFJV5ZQHA-1; Tue, 27 Jun 2023 10:36:02 -0400
X-MC-Unique: k73gLARBNf-DecFJV5ZQHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0421D3C11CE4;
        Tue, 27 Jun 2023 14:35:37 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BDAF40C2063;
        Tue, 27 Jun 2023 14:35:36 +0000 (UTC)
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
Subject: [PATCH v4 6/9] cgroup/cpuset: Introduce remote partition
Date:   Tue, 27 Jun 2023 10:35:05 -0400
Message-Id: <20230627143508.1576882-7-longman@redhat.com>
In-Reply-To: <20230627143508.1576882-1-longman@redhat.com>
References: <20230627143508.1576882-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

One can use "cpuset.cpus.partition" to create multiple scheduling domains
or to produce a set of isolated CPUs where load balancing is disabled.
The former use case is less common but the latter one can be frequently
used especially for the Telco use cases like DPDK.

The existing "isolated" partition can be used to produce isolated
CPUs if the applications have full control of a system. However, in a
containerized environment where all the apps are run in a container,
it is hard to distribute out isolated CPUs from the root down given
the unified hierarchy nature of cgroup v2.

The container running on isolated CPUs can be several layers down from
the root. The current partition feature requires that all the ancestors
of a leaf partition root must be parititon roots themselves. This can
be hard to configure.

This patch introduces a new type of partition called remote partition.
A remote partition is a partition whose parent is not a partition root
itself and its CPUs are acquired directly from available CPUs in the
top cpuset through a hierachical distribution of exclusive_cpus down
from the it.

For contrast, the existing type of partitions where their parents have
to be valid partition roots are referred to as local partitions as they
have to be clustered around the cgroup root.

Child local partitons can be created under a remote partition, but
a remote partition cannot be created under a local partition. We may
relax this limitation in the future if there are use cases for such
configuration.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 429 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 397 insertions(+), 32 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9f2ec8394736..56aa7b4f213c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -166,6 +166,9 @@ struct cpuset {
 	/* partition root state */
 	int partition_root_state;
 
+	/* Set to true if exclusive_cpus manually set */
+	int exclusive_cpus_set;
+
 	/*
 	 * Default hierarchy only:
 	 * use_parent_ecpus - set if using parent's effective_cpus
@@ -187,12 +190,19 @@ struct cpuset {
 
 	/* Handle for cpuset.cpus.partition */
 	struct cgroup_file partition_file;
+
+	/* Remote partition silbling list anchored at remote_children */
+	struct list_head remote_sibling;
 };
 
 /*
  * Exclusive CPUs distributed out to sub-partitions of top_cpuset
  */
 static cpumask_var_t	subpartitions_cpus;
+static cpumask_var_t	cs_tmp_cpus;
+
+/* List of remote partition root children */
+static struct list_head remote_children;
 
 /*
  * Partition root states:
@@ -343,6 +353,8 @@ static struct cpuset top_cpuset = {
 	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
 		  (1 << CS_MEM_EXCLUSIVE)),
 	.partition_root_state = PRS_ROOT,
+	.remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
+
 };
 
 /**
@@ -1352,7 +1364,7 @@ static bool tasks_nocpu_error(struct cpuset *parent, struct cpuset *cs,
 	/*
 	 * A populated partition (cs or parent) can't have empty effective_cpus
 	 */
-	return (cpumask_subset(parent->effective_cpus, xcpus) &&
+	return (parent && cpumask_subset(parent->effective_cpus, xcpus) &&
 		partition_is_populated(parent, cs)) ||
 	       (!cpumask_intersects(xcpus, cpu_active_mask) &&
 		partition_is_populated(cs, NULL));
@@ -1366,6 +1378,8 @@ static void setup_exclusive_cpus(struct cpuset *cs, struct cpuset *parent)
 	if (!cpumask_empty(cs->exclusive_cpus))
 		return;
 
+	WARN_ON_ONCE(cs->exclusive_cpus_set);
+
 	if (!parent)
 		parent = parent_cs(cs);
 	spin_lock_irq(&callback_lock);
@@ -1374,6 +1388,192 @@ static void setup_exclusive_cpus(struct cpuset *cs, struct cpuset *parent)
 	spin_unlock_irq(&callback_lock);
 }
 
+static inline bool is_remote_partition(struct cpuset *cs)
+{
+	return !list_empty(&cs->remote_sibling);
+}
+
+static inline bool is_local_partition(struct cpuset *cs)
+{
+	return is_partition_valid(cs) && !is_remote_partition(cs);
+}
+
+static void reset_partition_data(struct cpuset *cs)
+{
+	struct cpuset *parent = parent_cs(cs);
+
+	if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
+		return;
+
+	lockdep_assert_held(&callback_lock);
+
+	cs->nr_subparts = 0;
+	if (!cs->exclusive_cpus_set) {
+		cpumask_clear(cs->exclusive_cpus);
+		if (is_cpu_exclusive(cs))
+			clear_bit(CS_CPU_EXCLUSIVE, &cs->flags);
+	}
+	if (!cpumask_and(cs->effective_cpus,
+			 parent->effective_cpus, cs->cpus_allowed)) {
+		cs->use_parent_ecpus = true;
+		parent->child_ecpus_count++;
+		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
+	}
+}
+
+/*
+ * remote_partition_enable - Enable current cpuset as a remote partition root
+ * @cs: the cpuset to update
+ * @tmp: temparary masks
+ * Return: 1 if successful, 0 if error
+ *
+ * Enable the current cpuset to become a remote partition root taking CPUs
+ * directly from the top cpuset. cpuset_mutex must be held by the caller.
+ */
+static int remote_partition_enable(struct cpuset *cs, struct tmpmasks *tmp)
+{
+	/*
+	 * The user must have sysadmin privilege.
+	 */
+	if (!capable(CAP_SYS_ADMIN))
+		return 0;
+
+	/*
+	 * The requested exclusive_cpus must not be allocated to other
+	 * partitions and it can't use up all the root's effective_cpus.
+	 *
+	 * Note that if there is any local partition root above it or
+	 * remote partition root underneath it, its exclusive_cpus must
+	 * have overlapped with subpartitions_cpus.
+	 */
+	if (cpumask_empty(cs->exclusive_cpus) ||
+	    cpumask_intersects(cs->exclusive_cpus, subpartitions_cpus) ||
+	    cpumask_subset(top_cpuset.effective_cpus, cs->exclusive_cpus))
+		return 0;
+
+	spin_lock_irq(&callback_lock);
+	cpumask_andnot(top_cpuset.effective_cpus,
+		       top_cpuset.effective_cpus, cs->exclusive_cpus);
+	cpumask_or(subpartitions_cpus,
+		   subpartitions_cpus, cs->exclusive_cpus);
+
+	if (cs->use_parent_ecpus) {
+		struct cpuset *parent = parent_cs(cs);
+
+		cs->use_parent_ecpus = false;
+		parent->child_ecpus_count--;
+	}
+	list_add(&cs->remote_sibling, &remote_children);
+	spin_unlock_irq(&callback_lock);
+
+	/*
+	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
+	 */
+	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
+	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
+
+	return 1;
+}
+
+/*
+ * remote_partition_disable - Remove current cpuset from remote partition list
+ * @cs: the cpuset to update
+ * @tmp: temparary masks
+ *
+ * The effective_cpus is also updated.
+ *
+ * cpuset_mutex must be held by the caller.
+ */
+static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
+{
+	WARN_ON_ONCE(!is_remote_partition(cs));
+	WARN_ON_ONCE(!cpumask_subset(cs->exclusive_cpus, subpartitions_cpus));
+	spin_lock_irq(&callback_lock);
+	cpumask_andnot(subpartitions_cpus,
+		       subpartitions_cpus, cs->exclusive_cpus);
+	cpumask_and(tmp->new_cpus,
+		    cs->exclusive_cpus, cpu_active_mask);
+	cpumask_or(top_cpuset.effective_cpus,
+		   top_cpuset.effective_cpus, tmp->new_cpus);
+	list_del_init(&cs->remote_sibling);
+	cs->partition_root_state = -cs->partition_root_state;
+	if (!cs->prs_err)
+		cs->prs_err = PERR_INVCPUS;
+	reset_partition_data(cs);
+	spin_unlock_irq(&callback_lock);
+
+	/*
+	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
+	 */
+	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
+	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
+}
+
+/*
+ * remote_cpus_update - cpus_exclusive change of remote partition
+ * @cs: the cpuset to update
+ * @newmask: the new exclusive_cpus mask
+ * @tmp: temparary masks
+ *
+ * top_cpuset and subpartitions_cpus will be updated.
+ *
+ * Return: 1 if change is allowed, 0 if it needs to become invalid.
+ */
+static int remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
+			      struct tmpmasks *tmp)
+{
+	bool adding, deleting;
+
+	if (WARN_ON_ONCE(!is_remote_partition(cs)))
+		return 0;
+
+	WARN_ON_ONCE(!cpumask_subset(cs->exclusive_cpus, subpartitions_cpus));
+
+	if (cpumask_empty(newmask))
+		goto invalidate;
+
+	adding   = cpumask_andnot(tmp->addmask, newmask, cs->exclusive_cpus);
+	deleting = cpumask_andnot(tmp->delmask, cs->exclusive_cpus, newmask);
+
+	/*
+	 * Additions of remote CPUs is only allowed if those CPUs are
+	 * not allocated to other partitions and there are effective_cpus
+	 * left in the top cpuset.
+	 */
+	if (adding && (!capable(CAP_SYS_ADMIN) ||
+		       cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
+		       cpumask_subset(top_cpuset.effective_cpus, tmp->addmask)))
+		goto invalidate;
+
+	spin_lock_irq(&callback_lock);
+	if (adding) {
+		cpumask_or(subpartitions_cpus,
+			   subpartitions_cpus, tmp->addmask);
+		cpumask_andnot(top_cpuset.effective_cpus,
+			       top_cpuset.effective_cpus, tmp->addmask);
+	}
+	if (deleting) {
+		cpumask_andnot(subpartitions_cpus,
+			       subpartitions_cpus, tmp->delmask);
+		cpumask_and(tmp->delmask,
+			    tmp->delmask, cpu_active_mask);
+		cpumask_or(top_cpuset.effective_cpus,
+			   top_cpuset.effective_cpus, tmp->delmask);
+	}
+	spin_unlock_irq(&callback_lock);
+
+	/*
+	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
+	 */
+	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
+	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
+	return 1;
+
+invalidate:
+	remote_partition_disable(cs, tmp);
+	return 0;
+}
+
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -1663,8 +1863,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 
 	if (adding || deleting) {
 		update_tasks_cpumask(parent, tmp->addmask);
-		if (parent->child_ecpus_count)
-			update_sibling_cpumasks(parent, cs, tmp);
+		update_sibling_cpumasks(parent, cs, tmp);
 	}
 
 	/*
@@ -1777,12 +1976,24 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 	rcu_read_lock();
 	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
 		struct cpuset *parent = parent_cs(cp);
+		bool remote = is_remote_partition(cp);
 		bool update_parent = false;
 
-		compute_effective_cpumask(tmp->new_cpus, cp, parent);
+		/*
+		 * Skip remote partition that acquires CPUs directly from
+		 * top_cpuset unless it is cs.
+		 */
+		if (remote && (cp != cs)) {
+			pos_css = css_rightmost_descendant(pos_css);
+			continue;
+		}
 
-		if (is_partition_valid(parent) && is_partition_valid(cp))
+		old_prs = new_prs = cp->partition_root_state;
+		if (remote || (is_partition_valid(parent) &&
+			       is_partition_valid(cp)))
 			compute_partition_effective_cpumask(cp, tmp->new_cpus);
+		else
+			compute_effective_cpumask(tmp->new_cpus, cp, parent);
 
 		/*
 		 * A partition with no effective_cpus is allowed as long as
@@ -1790,6 +2001,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * update_parent_effective_cpumask() to check it.
 		 */
 		if (is_partition_valid(cp) && cpumask_empty(tmp->new_cpus)) {
+			WARN_ON_ONCE(remote);
 			update_parent = true;
 			goto update_parent_effective;
 		}
@@ -1800,7 +2012,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * it is a partition root that has explicitly distributed
 		 * out all its CPUs.
 		 */
-		if (is_in_v2_mode() && cpumask_empty(tmp->new_cpus)) {
+		if (is_in_v2_mode() && !remote && cpumask_empty(tmp->new_cpus)) {
 			cpumask_copy(tmp->new_cpus, parent->effective_cpus);
 			if (!cp->use_parent_ecpus) {
 				cp->use_parent_ecpus = true;
@@ -1812,6 +2024,9 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 			parent->child_ecpus_count--;
 		}
 
+		if (remote)
+			goto get_css;
+
 		/*
 		 * Skip the whole subtree if
 		 * 1) the cpumask remains the same,
@@ -1834,7 +2049,6 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * update_tasks_cpumask() again for tasks in the parent
 		 * cpuset if the parent's effective_cpus changes.
 		 */
-		old_prs = new_prs = cp->partition_root_state;
 		if ((cp != cs) && old_prs) {
 			switch (parent->partition_root_state) {
 			case PRS_ROOT:
@@ -1857,6 +2071,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 			}
 		}
 
+get_css:
 		if (!css_tryget_online(&cp->css))
 			continue;
 		rcu_read_unlock();
@@ -1876,13 +2091,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		if ((new_prs > 0) && cpumask_empty(cp->exclusive_cpus))
 			cpumask_and(cp->exclusive_cpus,
 				    cp->cpus_allowed, parent->exclusive_cpus);
-		if (new_prs < 0) {
-			/* Reset partition data */
-			cp->nr_subparts = 0;
-			cpumask_clear(cp->exclusive_cpus);
-			if (is_cpu_exclusive(cp))
-				clear_bit(CS_CPU_EXCLUSIVE, &cp->flags);
-		}
+		if (new_prs < 0)
+			reset_partition_data(cp);
 		spin_unlock_irq(&callback_lock);
 
 		notify_partition_change(cp, old_prs);
@@ -1890,7 +2100,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		WARN_ON(!is_in_v2_mode() &&
 			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
 
-		update_tasks_cpumask(cp, tmp->new_cpus);
+		update_tasks_cpumask(cp, cp->effective_cpus);
 
 		/*
 		 * On default hierarchy, inherit the CS_SCHED_LOAD_BALANCE
@@ -1943,8 +2153,13 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 
 	/*
 	 * Check all its siblings and call update_cpumasks_hier()
-	 * if their use_parent_ecpus flag is set in order for them
-	 * to use the right effective_cpus value.
+	 * if their effective_cpus will need to be changed.
+	 *
+	 * With the addition of exclusive_cpus which is a subset of
+	 * cpus_allowed. It is possible a change in parent's effective_cpus
+	 * due to a change in a child partition's exclusive_cpus will impact
+	 * its siblings even if they do not inherit parent's effective_cpus
+	 * directly.
 	 *
 	 * The update_cpumasks_hier() function may sleep. So we have to
 	 * release the RCU read lock before calling it. HIER_NO_SD_REBUILD
@@ -1955,8 +2170,13 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	cpuset_for_each_child(sibling, pos_css, parent) {
 		if (sibling == cs)
 			continue;
-		if (!sibling->use_parent_ecpus)
-			continue;
+		if (!sibling->use_parent_ecpus &&
+		    !is_partition_valid(sibling)) {
+			compute_effective_cpumask(tmp->new_cpus, sibling,
+						  parent);
+			if (cpumask_equal(tmp->new_cpus, sibling->effective_cpus))
+				continue;
+		}
 		if (!css_tryget_online(&sibling->css))
 			continue;
 
@@ -2006,11 +2226,16 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 			return -EINVAL;
 
 		/*
-		 * When exclusive_cpus is set, make sure it is a subset of
-		 * cpus_allowed and parent's exclusive_cpus.
+		 * When exclusive_cpus has previously been set, CPUs no longer
+		 * in cpus_allowed are removed. Otherwise, it is constrainted
+		 * by cpus_allowed and parent's exclusive_cpus.
 		 */
-		cpumask_and(trialcs->exclusive_cpus,
-			    parent->exclusive_cpus, trialcs->cpus_allowed);
+		if (cs->exclusive_cpus_set)
+			cpumask_and(trialcs->exclusive_cpus,
+				    trialcs->exclusive_cpus, trialcs->cpus_allowed);
+		else if (is_partition_valid(cs))
+			cpumask_and(trialcs->exclusive_cpus,
+				    parent->exclusive_cpus, trialcs->cpus_allowed);
 	}
 
 	/* Nothing to do if the cpus didn't change */
@@ -2059,7 +2284,15 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (retval < 0)
 		goto out_free;
 
-	if (cs->partition_root_state) {
+	if (is_partition_valid(cs)) {
+		/*
+		 * Call remote_cpus_update() to handle valid remote partition
+		 */
+		if (is_remote_partition(cs)) {
+			remote_cpus_update(cs, trialcs->exclusive_cpus, &tmp);
+			goto update_cpus;
+		}
+
 		if (invalidate)
 			update_parent_effective_cpumask(cs, partcmd_invalidate,
 							NULL, &tmp);
@@ -2068,13 +2301,16 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 						trialcs->exclusive_cpus, &tmp);
 	}
 
+update_cpus:
 	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, trialcs->cpus_allowed);
-	if (!is_partition_valid(cs))
-		cpumask_clear(cs->exclusive_cpus);
-	else
+	if (cpumask_empty(trialcs->exclusive_cpus))
+		cs->exclusive_cpus_set = false;
+	else if (is_partition_valid(cs))
 		cpumask_copy(cs->exclusive_cpus, trialcs->exclusive_cpus);
 
+	if ((old_prs > 0) && !is_partition_valid(cs))
+		reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
 
 	/* effective_cpus will be updated here */
@@ -2088,6 +2324,104 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	return 0;
 }
 
+/**
+ * update_exclusive_cpumask - update the exclusive_cpus mask of a cpuset
+ * @cs: the cpuset to consider
+ * @trialcs: trial cpuset
+ * @buf: buffer of cpu numbers written to this cpuset
+ *
+ * The tasks' cpumask will be updated if cs is a valid partition root.
+ */
+static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
+				    const char *buf)
+{
+	int retval;
+	struct tmpmasks tmp;
+	struct cpuset *parent = parent_cs(cs);
+	bool invalidate = false;
+	bool freemasks = false;
+	int old_prs = cs->partition_root_state;
+
+	if (!*buf) {
+		cpumask_clear(trialcs->exclusive_cpus);
+		trialcs->exclusive_cpus_set = false;
+	} else {
+		retval = cpulist_parse(buf, trialcs->exclusive_cpus);
+		if (retval < 0)
+			return retval;
+
+		/*
+		 * exclusive_cpus must be a subset of its cpus_allowed and
+		 * parent's exclusive_cpus or the write will fail.
+		 */
+		if (!cpumask_subset(trialcs->exclusive_cpus, trialcs->cpus_allowed) ||
+		    !cpumask_subset(trialcs->exclusive_cpus, parent->exclusive_cpus))
+			return -EINVAL;
+
+		trialcs->exclusive_cpus_set = true;
+		if (!is_cpu_exclusive(cs))
+			set_bit(CS_CPU_EXCLUSIVE, &trialcs->flags);
+	}
+
+	/* Nothing to do if the cpus didn't change */
+	if (cpumask_equal(cs->exclusive_cpus, trialcs->exclusive_cpus)) {
+		WRITE_ONCE(cs->exclusive_cpus_set, trialcs->exclusive_cpus_set);
+		return 0;
+	}
+
+	retval = validate_change(cs, trialcs);
+	if (retval)
+		return retval;
+
+	if (is_partition_valid(cs)) {
+		freemasks = true;
+		if (alloc_cpumasks(NULL, &tmp))
+			return -ENOMEM;
+
+		if (cpumask_empty(trialcs->exclusive_cpus)) {
+			invalidate = true;
+			cs->prs_err = PERR_INVCPUS;
+		} else if (tasks_nocpu_error(parent, cs, trialcs->exclusive_cpus)) {
+			invalidate = true;
+			cs->prs_err = PERR_NOCPUS;
+		}
+
+		if (is_remote_partition(cs)) {
+			if (invalidate)
+				remote_partition_disable(cs, &tmp);
+			else
+				remote_cpus_update(cs, trialcs->exclusive_cpus, &tmp);
+			goto update_xcpus;
+		}
+
+		if (invalidate)
+			update_parent_effective_cpumask(cs, partcmd_invalidate,
+							NULL, &tmp);
+		else
+			update_parent_effective_cpumask(cs, partcmd_update,
+						trialcs->exclusive_cpus, &tmp);
+	}
+
+update_xcpus:
+	spin_lock_irq(&callback_lock);
+	cpumask_copy(cs->exclusive_cpus, trialcs->exclusive_cpus);
+	cs->exclusive_cpus_set = trialcs->exclusive_cpus_set;
+	if ((old_prs > 0) && !is_partition_valid(cs))
+		reset_partition_data(cs);
+	spin_unlock_irq(&callback_lock);
+
+	/* effective_cpus will be updated here */
+	update_cpumasks_hier(cs, &tmp, 0);
+
+	/* Update CS_SCHED_LOAD_BALANCE and/or sched_domains, if necessary */
+	if (cs->partition_root_state)
+		update_partition_sd_lb(cs, old_prs);
+
+	if (freemasks)
+		free_cpumasks(NULL, &tmp);
+	return 0;
+}
+
 /*
  * Migrate memory region from one set of nodes to another.  This is
  * performed asynchronously as it can be called from process migration path
@@ -2499,6 +2833,13 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 
 		err = update_parent_effective_cpumask(cs, partcmd_enable,
 						      NULL, &tmpmask);
+
+		/*
+		 * If an attempt to become local partition root fails,
+		 * try to become a remote partition root instead.
+		 */
+		if (err && remote_partition_enable(cs, &tmpmask))
+			err = 0;
 	} else if (old_prs && new_prs) {
 		/*
 		 * A change in load balance state only, no change in cpumasks.
@@ -2509,8 +2850,11 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * Switching back to member is always allowed even if it
 		 * disables child partitions.
 		 */
-		update_parent_effective_cpumask(cs, partcmd_disable, NULL,
-						&tmpmask);
+		if (is_remote_partition(cs))
+			remote_partition_disable(cs, &tmpmask);
+		else
+			update_parent_effective_cpumask(cs, partcmd_disable,
+							NULL, &tmpmask);
 
 		/*
 		 * Invalidation of child partitions will be done in
@@ -2531,7 +2875,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	cs->partition_root_state = new_prs;
 	WRITE_ONCE(cs->prs_err, err);
 	if (!is_partition_valid(cs))
-		cpumask_clear(cs->exclusive_cpus);
+		reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
 
 	/* Force update if switching back to member */
@@ -3012,6 +3356,9 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	case FILE_CPULIST:
 		retval = update_cpumask(cs, trialcs, buf);
 		break;
+	case FILE_EXCLUSIVE_CPULIST:
+		retval = update_exclusive_cpumask(cs, trialcs, buf);
+		break;
 	case FILE_MEMLIST:
 		retval = update_nodemask(cs, trialcs, buf);
 		break;
@@ -3338,6 +3685,7 @@ static struct cftype dfl_files[] = {
 	{
 		.name = "cpus.exclusive",
 		.seq_show = cpuset_common_seq_show,
+		.write = cpuset_write_resmask,
 		.private = FILE_EXCLUSIVE_CPULIST,
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
@@ -3384,6 +3732,7 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 	nodes_clear(cs->effective_mems);
 	fmeter_init(&cs->fmeter);
 	cs->relax_domain_level = -1;
+	INIT_LIST_HEAD(&cs->remote_sibling);
 
 	/* Set CS_MEMORY_MIGRATE for default hierarchy */
 	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
@@ -3419,6 +3768,11 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		cs->effective_mems = parent->effective_mems;
 		cs->use_parent_ecpus = true;
 		parent->child_ecpus_count++;
+		/*
+		 * Clear CS_SCHED_LOAD_BALANCE if parent is isolated
+		 */
+		if (!is_sched_load_balance(parent))
+			clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 	}
 
 	/*
@@ -3661,6 +4015,7 @@ int __init cpuset_init(void)
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_cpus, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.exclusive_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&subpartitions_cpus, GFP_KERNEL));
+	BUG_ON(!alloc_cpumask_var(&cs_tmp_cpus, GFP_KERNEL));
 
 	cpumask_setall(top_cpuset.cpus_allowed);
 	nodes_setall(top_cpuset.mems_allowed);
@@ -3671,6 +4026,7 @@ int __init cpuset_init(void)
 	fmeter_init(&top_cpuset.fmeter);
 	set_bit(CS_SCHED_LOAD_BALANCE, &top_cpuset.flags);
 	top_cpuset.relax_domain_level = -1;
+	INIT_LIST_HEAD(&remote_children);
 
 	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
 
@@ -3787,6 +4143,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	static nodemask_t new_mems;
 	bool cpus_updated;
 	bool mems_updated;
+	bool remote;
 	struct cpuset *parent;
 retry:
 	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
@@ -3813,9 +4170,17 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 * Compute effective_cpus for valid partition root, may invalidate
 	 * child partition roots if necessary.
 	 */
-	if (is_partition_valid(cs) && is_partition_valid(parent))
+	remote = is_remote_partition(cs);
+	if (remote || (is_partition_valid(cs) && is_partition_valid(parent)))
 		compute_partition_effective_cpumask(cs, &new_cpus);
 
+	if (remote && cpumask_empty(&new_cpus) &&
+	    partition_is_populated(cs, NULL)) {
+		remote_partition_disable(cs, tmp);
+		compute_effective_cpumask(&new_cpus, cs, parent);
+		remote = false;
+		cpuset_force_rebuild();
+	}
 	/*
 	 * Force the partition to become invalid if either one of
 	 * the following conditions hold:
@@ -3823,7 +4188,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 * 2) parent is invalid or doesn't grant any cpus to child
 	 *    partitions.
 	 */
-	if (is_partition_valid(cs) && (!is_partition_valid(parent) ||
+	if (is_local_partition(cs) && (!is_partition_valid(parent) ||
 				tasks_nocpu_error(parent, cs, &new_cpus))) {
 		update_parent_effective_cpumask(cs, partcmd_invalidate, NULL, tmp);
 		compute_effective_cpumask(&new_cpus, cs, parent);
-- 
2.31.1

