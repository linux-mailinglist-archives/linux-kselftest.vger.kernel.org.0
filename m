Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530163F7DCC
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Aug 2021 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhHYVk6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 17:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232844AbhHYVk5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 17:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629927611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=OGHOa0kZMjqxkrpym13f6OXtfzhe5zs6nSz2VwJyipQ=;
        b=TgnwFBJ0OEr3QxC65c8H6ESlKqPxzFZFbPWEF/Q618r+OgHYe6mN3pj6nHzjLecs7BFKZL
        gWVm28Iwn6g/nWdJOCeVlgWg8RDdQjLwLf8QCWnWMyn34WFSP2M7qCrgXEZcAOti3am8ch
        5aNSVAQvQ5UmUtuRjEGtAmrXG4Ij3Mk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-xcZ0XEbGOAuE5FeOikx-Lw-1; Wed, 25 Aug 2021 17:40:09 -0400
X-MC-Unique: xcZ0XEbGOAuE5FeOikx-Lw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90DEC8015C7;
        Wed, 25 Aug 2021 21:40:07 +0000 (UTC)
Received: from llong.com (unknown [10.22.18.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 412DB6A056;
        Wed, 25 Aug 2021 21:40:03 +0000 (UTC)
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
Subject: [PATCH v7 1/6] cgroup/cpuset: Properly transition to invalid partition
Date:   Wed, 25 Aug 2021 17:37:45 -0400
Message-Id: <20210825213750.6933-2-longman@redhat.com>
In-Reply-To: <20210825213750.6933-1-longman@redhat.com>
References: <20210825213750.6933-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For cpuset partition, the special state of PRS_ERROR (invalid partition
root) was originally designed to handle hotplug events.  In this state,
CPUs allocated to the partition root is released back to the parent
but the cpuset exclusive flags remain unchanged.

Changing a cpuset into a partition root is strictly controlled. The
following constraints must be satisfied in order to make the transition
possible:

 - The "cpuset.cpus" is not empty and the list of CPUs are exclusive,
   i.e. they are not shared by any of its siblings.
 - The parent cgroup is a partition root.
 - The "cpuset.cpus" is a subset of the parent's "cpuset.cpus.effective".
 - There is no child cgroups with cpuset enabled.

Changing a partition root back to a member is always allowed, though care
must be taken to make sure that this change won't break child cpusets,
if present.

Since partition root sets the CPU_EXCLUSIVE flag, cpuset.cpus changes
that break the cpu exclusivity rule will not be allowed. However,
other changes to cpuset.cpus on a partition root may still cause it to
become invalid. So users must always check the partition root state of
"cpuset.cpus.partition" after making changes to cpuset.cpus to make sure
that the partition root is still valid.

For a partition root tree with parent and child partition roots, there
are two cases where the child partitions can become invalid. Firstly,
changing partition state to "member" will force the child partitions
to become invalid.

Secondly, if some cpus are taken away from the parent partition root
so that its cpuset.cpus.effective becomes empty, it will try to pull
cpus away from the child partitions and force them to become invalid
which may allow the parent partition to remain valid.

This patch makes sure that partitions are properly changed to invalid
when some of the valid partition constraints are violated.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 167 ++++++++++++++++++++++-------------------
 1 file changed, 90 insertions(+), 77 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d497a65c4f04..ddea05e4d1f0 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1177,10 +1177,9 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		return -EINVAL;
 
 	/*
-	 * Enabling/disabling partition root is not allowed if there are
-	 * online children.
+	 * Enabling partition root is not allowed if there are online children.
 	 */
-	if ((cmd != partcmd_update) && css_has_online_children(&cpuset->css))
+	if ((cmd == partcmd_enable) && css_has_online_children(&cpuset->css))
 		return -EBUSY;
 
 	/*
@@ -1208,6 +1207,14 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		/*
 		 * partcmd_update with newmask:
 		 *
+		 * Make partition invalid if newmask isn't a subset of
+		 * (cpus_allowed | parent->effective_cpus).
+		 */
+		cpumask_or(tmp->addmask, cpuset->cpus_allowed,
+					 parent->effective_cpus);
+		part_error = !cpumask_subset(newmask, tmp->addmask);
+
+		/*
 		 * delmask = cpus_allowed & ~newmask & parent->subparts_cpus
 		 * addmask = newmask & parent->effective_cpus
 		 *		     & ~parent->subparts_cpus
@@ -1220,20 +1227,21 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		adding = cpumask_andnot(tmp->addmask, tmp->addmask,
 					parent->subparts_cpus);
 		/*
-		 * Return error if the new effective_cpus could become empty.
+		 * Make partition invalid if parent's effective_cpus could
+		 * become empty.
 		 */
 		if (adding &&
 		    cpumask_equal(parent->effective_cpus, tmp->addmask)) {
 			if (!deleting)
-				return -EINVAL;
+				part_error = true;
 			/*
 			 * As some of the CPUs in subparts_cpus might have
 			 * been offlined, we need to compute the real delmask
 			 * to confirm that.
 			 */
-			if (!cpumask_and(tmp->addmask, tmp->delmask,
-					 cpu_active_mask))
-				return -EINVAL;
+			else if (!cpumask_and(tmp->addmask, tmp->delmask,
+					      cpu_active_mask))
+				part_error = true;
 			cpumask_copy(tmp->addmask, parent->effective_cpus);
 		}
 	} else {
@@ -1242,19 +1250,23 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		 *
 		 * addmask = cpus_allowed & parent->effective_cpus
 		 *
+		 * This gets invoked either due to a hotplug event or
+		 * from update_cpumasks_hier() where we can't return an
+		 * error. This can cause a partition root to become invalid
+		 * in the case of a hotplug.
+		 *
 		 * Note that parent's subparts_cpus may have been
 		 * pre-shrunk in case there is a change in the cpu list.
 		 * So no deletion is needed.
 		 */
 		adding = cpumask_and(tmp->addmask, cpuset->cpus_allowed,
 				     parent->effective_cpus);
-		part_error = cpumask_equal(tmp->addmask,
-					   parent->effective_cpus);
+		part_error = (is_partition_root(cpuset) &&
+			      !parent->nr_subparts_cpus) ||
+			     cpumask_equal(tmp->addmask, parent->effective_cpus);
 	}
 
 	if (cmd == partcmd_update) {
-		int prev_prs = cpuset->partition_root_state;
-
 		/*
 		 * Check for possible transition between PRS_ENABLED
 		 * and PRS_ERROR.
@@ -1269,13 +1281,9 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
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
@@ -1407,6 +1415,11 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 			case PRS_ENABLED:
 				if (update_parent_subparts_cpumask(cp, partcmd_update, NULL, tmp))
 					update_tasks_cpumask(parent);
+				/*
+				 * The cpuset partition_root_state may be
+				 * changed to PRS_ERROR. Capture it.
+				 */
+				new_prs = cp->partition_root_state;
 				break;
 
 			case PRS_ERROR:
@@ -1424,33 +1437,27 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 
 		spin_lock_irq(&callback_lock);
 
-		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
 		if (cp->nr_subparts_cpus && (new_prs != PRS_ENABLED)) {
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
-			 * are mutually exclusive.
-			 *
-			 * In the unlikely event that effective_cpus
-			 * becomes empty. we clear cp->nr_subparts_cpus and
-			 * let its child partition roots to compete for
-			 * CPUs again.
+			 * of a partition root are mutually exclusive.
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
+			WARN_ON_ONCE(cpumask_empty(cp->effective_cpus));
 		}
 
 		if (new_prs != old_prs)
@@ -1582,8 +1589,8 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
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
@@ -2010,20 +2017,24 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		}
 	} else {
 		/*
-		 * Turning off partition root will clear the
-		 * CS_CPU_EXCLUSIVE bit.
+		 * Switch back to member is always allowed even if it
+		 * causes child partitions to become invalid.
 		 */
-		if (old_prs == PRS_ERROR) {
-			update_flag(CS_CPU_EXCLUSIVE, cs, 0);
-			err = 0;
-			goto out;
+		err = 0;
+		update_parent_subparts_cpumask(cs, partcmd_disable, NULL,
+					       &tmpmask);
+		/*
+		 * If there are child partitions, we have to make them invalid.
+		 */
+		if (unlikely(cs->nr_subparts_cpus)) {
+			spin_lock_irq(&callback_lock);
+			cs->nr_subparts_cpus = 0;
+			cpumask_clear(cs->subparts_cpus);
+			compute_effective_cpumask(cs->effective_cpus, cs, parent);
+			spin_unlock_irq(&callback_lock);
+			update_cpumasks_hier(cs, &tmpmask);
 		}
 
-		err = update_parent_subparts_cpumask(cs, partcmd_disable,
-						     NULL, &tmpmask);
-		if (err)
-			goto out;
-
 		/* Turning off CS_CPU_EXCLUSIVE will not return error */
 		update_flag(CS_CPU_EXCLUSIVE, cs, 0);
 	}
@@ -3109,11 +3120,28 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 
 	/*
 	 * In the unlikely event that a partition root has empty
-	 * effective_cpus or its parent becomes erroneous, we have to
-	 * transition it to the erroneous state.
+	 * effective_cpus, we will have to force any child partitions,
+	 * if present, to become invalid by setting nr_subparts_cpus to 0
+	 * without causing itself to become invalid.
+	 */
+	if (is_partition_root(cs) && cs->nr_subparts_cpus &&
+	    cpumask_empty(&new_cpus)) {
+		cs->nr_subparts_cpus = 0;
+		cpumask_clear(cs->subparts_cpus);
+		compute_effective_cpumask(&new_cpus, cs, parent);
+	}
+
+	/*
+	 * If empty effective_cpus or zero nr_subparts_cpus or its parent
+	 * becomes erroneous, we have to transition it to the erroneous state.
 	 */
 	if (is_partition_root(cs) && (cpumask_empty(&new_cpus) ||
-	   (parent->partition_root_state == PRS_ERROR))) {
+	    (parent->partition_root_state == PRS_ERROR) ||
+	    !parent->nr_subparts_cpus)) {
+		int old_prs;
+
+		update_parent_subparts_cpumask(cs, partcmd_disable,
+					       NULL, tmp);
 		if (cs->nr_subparts_cpus) {
 			spin_lock_irq(&callback_lock);
 			cs->nr_subparts_cpus = 0;
@@ -3122,38 +3150,23 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 			compute_effective_cpumask(&new_cpus, cs, parent);
 		}
 
-		/*
-		 * If the effective_cpus is empty because the child
-		 * partitions take away all the CPUs, we can keep
-		 * the current partition and let the child partitions
-		 * fight for available CPUs.
-		 */
-		if ((parent->partition_root_state == PRS_ERROR) ||
-		     cpumask_empty(&new_cpus)) {
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
2.18.1

