Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199D4431FED
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 16:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhJROkE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 10:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232085AbhJROkD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 10:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634567871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+eM4Zdlfz183Ohg51FBPD/XoJZrhXylT7f3NCJvHwU=;
        b=N1jl6ftMos5MgnjzYN0UKv5ygJK71adJEYn8+Eanq1sxyi8U10Ap1t6782onISsoAR24GZ
        g9WqFjTNhwSyJNvsEAXQ5WZzpIr8qLRNziYbSZxrPVcOibNMtsjwdPr0tdODe0GU920UPe
        YICFWmys8k5sgAEv18RYhsq73zq9PDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-5mjYeHwPNnWdLkzimpdHmw-1; Mon, 18 Oct 2021 10:37:48 -0400
X-MC-Unique: 5mjYeHwPNnWdLkzimpdHmw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5B4918414A1;
        Mon, 18 Oct 2021 14:37:45 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDBEB6A914;
        Mon, 18 Oct 2021 14:37:43 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v8 2/6] cgroup/cpuset: Refining features and constraints of a partition
Date:   Mon, 18 Oct 2021 10:36:15 -0400
Message-Id: <20211018143619.205065-3-longman@redhat.com>
In-Reply-To: <20211018143619.205065-1-longman@redhat.com>
References: <20211018143619.205065-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to plan for proper partitioning of a system, a valid partition
must be using only CPUs designated in "cpuset.cpus" of the partition
root. It can be a subset, but it can't use CPUs outside of its designed
list. If none of the CPUs in the desginated list can be granted to the
partition, its "cpuset.cpus.effective" becomes empty. This is allowed
as long as there is no task in the partition.

To ease implementation, there are additional contraints in enabling a
partition root.

 1) The "cpuset.cpus" is non-empty and exclusive.
 2) The parent cgroup is a valid partition root.
 3) The "cpuset.cpus" is a subset of parent's "cpuset.cpus".
 4) There is no child cgroups with cpuset enabled.

This allows offlined cpus in parent's "cpuset.cpus" to be granted to
a child partition which can have empty "cpuset.cpus.effective" when it
has no task.

The cpuset's subparts_cpus keeps track of CPUs (including offline CPUs)
that are allocated to child partitions. It does not change during
hotplug operations.

Once a partition root has been enabled, changes to "cpuset.cpus" is
generally allowed as long as the cpu list is exclusive, non-empty and
is a superset of children's cpu lists. These existing rules are enforced
by validate_change().

A partition will become invalid when one or more of the following
constraints are violated:

 1) The parent cgroup is a valid partition root.
 2) "cpuset.cpus.effective" is a subset of "cpuset.cpus"
 3) "cpuset.cpus.effective" is non-empty when there are tasks
    in the partition.

Disabling a partition root is always allowed even if there are child
partitions underneath it. In this case, all the child partitions are
also disabled (switch to "member"). So care must be taken to double check
if there are child partitions underneath it before disabling a partition.

This patch makes the necessary change to support the above features
and constraints.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 228 +++++++++++++++++++++--------------------
 1 file changed, 117 insertions(+), 111 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e3a6609bc919..e2c01345353c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1227,29 +1227,27 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		return -EINVAL;
 
 	/*
-	 * Enabling/disabling partition root is not allowed if there are
-	 * online children.
+	 * Enabling partition root is not allowed if there are online children.
 	 */
-	if ((cmd != partcmd_update) && css_has_online_children(&cpuset->css))
+	if ((cmd == partcmd_enable) && css_has_online_children(&cpuset->css))
 		return -EBUSY;
 
 	adding = deleting = false;
 	old_prs = new_prs = cpuset->partition_root_state;
 	if (cmd == partcmd_enable) {
 		/*
-		 * Enabling partition root is not allowed if not all the CPUs
-		 * can be granted from parent's effective_cpus.
+		 * Enabling partition root is not allowed if cpus_allowed isn't
+		 * a subset of parent's cpus_allowed.
 		 */
-		if (!cpumask_subset(cpuset->cpus_allowed, parent->effective_cpus))
+		if (!cpumask_subset(cpuset->cpus_allowed, parent->cpus_allowed))
 			return -EINVAL;
 
 		/*
 		 * A parent can be left with no CPU as long as there is no
-		 * task directly associated with the parent partition. For
-		 * such a parent, no new task can be moved into it.
+		 * task directly associated with the parent partition.
 		 */
 		if (partition_is_populated(parent, cpuset) &&
-		    cpumask_equal(cpuset->cpus_allowed, parent->effective_cpus))
+		    cpumask_subset(parent->effective_cpus, cpuset->cpus_allowed))
 			return -EINVAL;
 
 		cpumask_copy(tmp->addmask, cpuset->cpus_allowed);
@@ -1261,54 +1259,52 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		/*
 		 * partcmd_update with newmask:
 		 *
+		 * Compute add/delete mask to/from subparts_cpus
+		 *
 		 * delmask = cpus_allowed & ~newmask & parent->subparts_cpus
-		 * addmask = newmask & parent->effective_cpus
+		 * addmask = newmask & parent->cpus_allowed
 		 *		     & ~parent->subparts_cpus
 		 */
 		cpumask_andnot(tmp->delmask, cpuset->cpus_allowed, newmask);
 		deleting = cpumask_and(tmp->delmask, tmp->delmask,
 				       parent->subparts_cpus);
 
-		cpumask_and(tmp->addmask, newmask, parent->effective_cpus);
+		cpumask_and(tmp->addmask, newmask, parent->cpus_allowed);
 		adding = cpumask_andnot(tmp->addmask, tmp->addmask,
 					parent->subparts_cpus);
 		/*
-		 * Return error if the new effective_cpus could become empty
-		 * and there are tasks in the parent.
+		 * Make partition invalid if parent's effective_cpus could
+                 * become empty and there are tasks in the parent.
 		 */
-		if (adding && partition_is_populated(parent, cpuset) &&
-		    cpumask_equal(parent->effective_cpus, tmp->addmask)) {
-			if (!deleting)
-				return -EINVAL;
-			/*
-			 * As some of the CPUs in subparts_cpus might have
-			 * been offlined, we need to compute the real delmask
-			 * to confirm that.
-			 */
-			if (!cpumask_and(tmp->addmask, tmp->delmask,
-					 cpu_active_mask))
-				return -EINVAL;
-			cpumask_copy(tmp->addmask, parent->effective_cpus);
-		}
+		part_error = partition_is_populated(parent, cpuset) &&
+			cpumask_subset(parent->effective_cpus, tmp->addmask) &&
+			!cpumask_intersects(tmp->delmask, cpu_active_mask);
 	} else {
 		/*
 		 * partcmd_update w/o newmask:
 		 *
 		 * addmask = cpus_allowed & parent->effective_cpus
 		 *
-		 * Note that parent's subparts_cpus may have been
-		 * pre-shrunk in case there is a change in the cpu list.
-		 * So no deletion is needed.
+		 * This gets invoked either due to a hotplug event or
+                 * from update_cpumasks_hier() where we can't return an
+                 * error. This can cause a partition root to become invalid
+                 * in the case of a hotplug.
+		 *
+		 * A partition error happens when:
+		 * 1) Cpuset is valid partition, but parent does not distribute
+		 *    out any CPUs.
+		 * 2) Parent has tasks and all its effective CPUs will have
+		 *    to be distributed out.
 		 */
 		adding = cpumask_and(tmp->addmask, cpuset->cpus_allowed,
 				     parent->effective_cpus);
-		part_error = cpumask_equal(tmp->addmask, parent->effective_cpus) &&
-			     partition_is_populated(parent, cpuset);
+		part_error = (is_partition_root(cpuset) &&
+			      !parent->nr_subparts_cpus) ||
+			     (cpumask_equal(parent->effective_cpus, tmp->addmask) &&
+			      partition_is_populated(parent, cpuset));
 	}
 
 	if (cmd == partcmd_update) {
-		int prev_prs = cpuset->partition_root_state;
-
 		/*
 		 * Check for possible transition between PRS_ENABLED
 		 * and PRS_ERROR.
@@ -1323,13 +1319,9 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 				new_prs = PRS_ENABLED;
 			break;
 		}
-		/*
-		 * Set part_error if previously in invalid state.
-		 */
-		part_error = (prev_prs == PRS_ERROR);
 	}
 
-	if (!part_error && (new_prs == PRS_ERROR))
+	if ((old_prs == PRS_ERROR) && (new_prs == PRS_ERROR))
 		return 0;	/* Nothing need to be done */
 
 	if (new_prs == PRS_ERROR) {
@@ -1382,6 +1374,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
  * update_cpumasks_hier - Update effective cpumasks and tasks in the subtree
  * @cs:  the cpuset to consider
  * @tmp: temp variables for calculating effective_cpus & partition setup
+ * @force: don't skip any descendant cpusets if set
  *
  * When configured cpumask is changed, the effective cpumasks of this cpuset
  * and all its descendants need to be updated.
@@ -1390,7 +1383,8 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
  *
  * Called with cpuset_rwsem held
  */
-static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
+static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
+				 bool force)
 {
 	struct cpuset *cp;
 	struct cgroup_subsys_state *pos_css;
@@ -1400,6 +1394,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 	rcu_read_lock();
 	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
 		struct cpuset *parent = parent_cs(cp);
+		bool update_parent = false;
 
 		compute_effective_cpumask(tmp->new_cpus, cp, parent);
 
@@ -1427,9 +1422,9 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 
 		/*
 		 * Skip the whole subtree if the cpumask remains the same
-		 * and has no partition root state.
+		 * with no partition root state and force flag not set.
 		 */
-		if (!cp->partition_root_state &&
+		if (!cp->partition_root_state && !force &&
 		    cpumask_equal(tmp->new_cpus, cp->effective_cpus)) {
 			pos_css = css_rightmost_descendant(pos_css);
 			continue;
@@ -1466,8 +1461,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 				break;
 
 			case PRS_ENABLED:
-				if (update_parent_subparts_cpumask(cp, partcmd_update, NULL, tmp))
-					update_tasks_cpumask(parent);
+				update_parent = true;
 				break;
 
 			case PRS_ERROR:
@@ -1483,40 +1477,41 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 			continue;
 		rcu_read_unlock();
 
+		if (update_parent) {
+			if (update_parent_subparts_cpumask(cp, partcmd_update, NULL, tmp))
+				update_tasks_cpumask(parent);
+			/*
+			 * The cpuset partition_root_state may be changed
+			 * to PRS_ERROR. Capture it.
+			 */
+			new_prs = cp->partition_root_state;
+		}
+
 		spin_lock_irq(&callback_lock);
 
-		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
-		if (cp->nr_subparts_cpus && (new_prs != PRS_ENABLED)) {
+		if (cp->nr_subparts_cpus && (new_prs <= 0)) {
+			/*
+			 * Put all active subparts_cpus back to effective_cpus.
+			 */
+			cpumask_or(tmp->new_cpus, tmp->new_cpus,
+				   cp->subparts_cpus);
+			cpumask_and(tmp->new_cpus, tmp->new_cpus,
+				    cpu_active_mask);
 			cp->nr_subparts_cpus = 0;
 			cpumask_clear(cp->subparts_cpus);
-		} else if (cp->nr_subparts_cpus) {
+		}
+
+		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
+		if (cp->nr_subparts_cpus) {
 			/*
 			 * Make sure that effective_cpus & subparts_cpus
 			 * are mutually exclusive.
-			 *
-			 * In the unlikely event that effective_cpus
-			 * becomes empty. we clear cp->nr_subparts_cpus and
-			 * let its child partition roots to compete for
-			 * CPUs again.
 			 */
 			cpumask_andnot(cp->effective_cpus, cp->effective_cpus,
 				       cp->subparts_cpus);
-			if (cpumask_empty(cp->effective_cpus)) {
-				cpumask_copy(cp->effective_cpus, tmp->new_cpus);
-				cpumask_clear(cp->subparts_cpus);
-				cp->nr_subparts_cpus = 0;
-			} else if (!cpumask_subset(cp->subparts_cpus,
-						   tmp->new_cpus)) {
-				cpumask_andnot(cp->subparts_cpus,
-					cp->subparts_cpus, tmp->new_cpus);
-				cp->nr_subparts_cpus
-					= cpumask_weight(cp->subparts_cpus);
-			}
 		}
 
-		if (new_prs != old_prs)
-			cp->partition_root_state = new_prs;
-
+		cp->partition_root_state = new_prs;
 		spin_unlock_irq(&callback_lock);
 		notify_partition_change(cp, old_prs, new_prs);
 
@@ -1570,7 +1565,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 		if (!sibling->use_parent_ecpus)
 			continue;
 
-		update_cpumasks_hier(sibling, tmp);
+		update_cpumasks_hier(sibling, tmp, false);
 	}
 	rcu_read_unlock();
 }
@@ -1643,13 +1638,13 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	 * Make sure that subparts_cpus is a subset of cpus_allowed.
 	 */
 	if (cs->nr_subparts_cpus) {
-		cpumask_andnot(cs->subparts_cpus, cs->subparts_cpus,
-			       cs->cpus_allowed);
+		cpumask_and(cs->subparts_cpus, cs->subparts_cpus,
+			    cs->cpus_allowed);
 		cs->nr_subparts_cpus = cpumask_weight(cs->subparts_cpus);
 	}
 	spin_unlock_irq(&callback_lock);
 
-	update_cpumasks_hier(cs, &tmp);
+	update_cpumasks_hier(cs, &tmp, false);
 
 	if (cs->partition_root_state) {
 		struct cpuset *parent = parent_cs(cs);
@@ -2071,20 +2066,23 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		}
 	} else {
 		/*
-		 * Turning off partition root will clear the
-		 * CS_CPU_EXCLUSIVE bit.
+		 * Switch back to member is always allowed even if it
+                 * disables child partitions.
 		 */
-		if (old_prs == PRS_ERROR) {
-			update_flag(CS_CPU_EXCLUSIVE, cs, 0);
-			err = 0;
-			goto out;
+		err = 0;
+		update_parent_subparts_cpumask(cs, partcmd_disable, NULL,
+					       &tmpmask);
+		/*
+		 * If there are child partitions, we have to disable them.
+		 */
+		if (unlikely(cs->nr_subparts_cpus)) {
+			spin_lock_irq(&callback_lock);
+			cs->nr_subparts_cpus = 0;
+			cpumask_clear(cs->subparts_cpus);
+			compute_effective_cpumask(cs->effective_cpus, cs, parent);
+			spin_unlock_irq(&callback_lock);
 		}
 
-		err = update_parent_subparts_cpumask(cs, partcmd_disable,
-						     NULL, &tmpmask);
-		if (err)
-			goto out;
-
 		/* Turning off CS_CPU_EXCLUSIVE will not return error */
 		update_flag(CS_CPU_EXCLUSIVE, cs, 0);
 	}
@@ -2105,6 +2103,11 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		spin_lock_irq(&callback_lock);
 		cs->partition_root_state = new_prs;
 		spin_unlock_irq(&callback_lock);
+		/*
+		 * Update child cpusets when disabling partition.
+		 */
+		if (new_prs == PRS_DISABLED && !list_empty(&cs->css.children))
+			update_cpumasks_hier(cs, &tmpmask, true);
 		notify_partition_change(cs, old_prs, new_prs);
 	}
 
@@ -3176,12 +3179,32 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 
 	/*
 	 * In the unlikely event that a partition root has empty
-	 * effective_cpus with tasks or its parent becomes erroneous, we
-	 * have to transition it to the erroneous state.
+	 * effective_cpus with tasks, we will have to invalidate child
+	 * partitions, if present, by setting nr_subparts_cpus to 0 to
+	 * reclaim their cpus.
+	 */
+	if (is_partition_root(cs) && cpumask_empty(&new_cpus) &&
+	    cs->nr_subparts_cpus && partition_is_populated(cs, NULL)) {
+		spin_lock_irq(&callback_lock);
+		cs->nr_subparts_cpus = 0;
+		cpumask_clear(cs->subparts_cpus);
+		spin_unlock_irq(&callback_lock);
+		compute_effective_cpumask(&new_cpus, cs, parent);
+	}
+
+	/*
+	 * Force the partition to become invalid if either one of
+	 * the following conditions hold:
+	 * 1) empty effective cpus with tasks in partition
+	 * 2) parent is invalid or doesn't grant any cpus to child partitions.
 	 */
 	if (is_partition_root(cs) &&
 	   ((cpumask_empty(&new_cpus) && partition_is_populated(cs, NULL)) ||
-	    (parent->partition_root_state == PRS_ERROR))) {
+	    !parent->nr_subparts_cpus)) {
+		int old_prs;
+
+		update_parent_subparts_cpumask(cs, partcmd_disable,
+					       NULL, tmp);
 		if (cs->nr_subparts_cpus) {
 			spin_lock_irq(&callback_lock);
 			cs->nr_subparts_cpus = 0;
@@ -3190,40 +3213,23 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 			compute_effective_cpumask(&new_cpus, cs, parent);
 		}
 
-		/*
-		 * Force the partition to become invalid if either one of
-		 * the following conditions hold:
-		 * 1) empty effective cpus but not valid empty partition.
-		 * 2) parent is invalid or doesn't grant any cpus to child
-		 *    partitions.
-		 */
-		if ((parent->partition_root_state == PRS_ERROR) ||
-		    (cpumask_empty(&new_cpus) &&
-		     partition_is_populated(cs, NULL))) {
-			int old_prs;
-
-			update_parent_subparts_cpumask(cs, partcmd_disable,
-						       NULL, tmp);
-			old_prs = cs->partition_root_state;
-			if (old_prs != PRS_ERROR) {
-				spin_lock_irq(&callback_lock);
-				cs->partition_root_state = PRS_ERROR;
-				spin_unlock_irq(&callback_lock);
-				notify_partition_change(cs, old_prs, PRS_ERROR);
-			}
+		old_prs = cs->partition_root_state;
+		if (old_prs != PRS_ERROR) {
+			spin_lock_irq(&callback_lock);
+			cs->partition_root_state = PRS_ERROR;
+			spin_unlock_irq(&callback_lock);
+			notify_partition_change(cs, old_prs, PRS_ERROR);
 		}
 		cpuset_force_rebuild();
 	}
 
 	/*
 	 * On the other hand, an erroneous partition root may be transitioned
-	 * back to a regular one or a partition root with no CPU allocated
-	 * from the parent may change to erroneous.
+	 * back to a regular one.
 	 */
-	if (is_partition_root(parent) &&
-	   ((cs->partition_root_state == PRS_ERROR) ||
-	    !cpumask_intersects(&new_cpus, parent->subparts_cpus)) &&
-	     update_parent_subparts_cpumask(cs, partcmd_update, NULL, tmp))
+	else if (is_partition_root(parent) &&
+		(cs->partition_root_state == PRS_ERROR) &&
+		 update_parent_subparts_cpumask(cs, partcmd_update, NULL, tmp))
 		cpuset_force_rebuild();
 
 update_tasks:
-- 
2.27.0

