Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A933AF58E
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jun 2021 20:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhFUSwH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Jun 2021 14:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231822AbhFUSwG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Jun 2021 14:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624301391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=NwEqpKwLjGv0BDqAKN1aQSBOGfYc5PcdXpPM+AMB9gY=;
        b=GbBg6MBE3Goxkg6t9HJm2wvA6MIINrJk7IJqAeA+OwdyleuGd4QqC3H7B0siWXFZhJ3Ahp
        y74CPesYlC8njwcq9HTUHrTaiVV85QK762sqqGhcDxnO+iLa9mwAOAz9YN4s+Z1QQ5UaLg
        Bz8TTKry1fxBc9g+j7qR25QZAPvf6Rw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-vFgwBW9jO4KPb2puP2j6iQ-1; Mon, 21 Jun 2021 14:49:50 -0400
X-MC-Unique: vFgwBW9jO4KPb2puP2j6iQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1C8519067E1;
        Mon, 21 Jun 2021 18:49:48 +0000 (UTC)
Received: from llong.com (ovpn-114-127.rdu2.redhat.com [10.10.114.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63B275D9CA;
        Mon, 21 Jun 2021 18:49:47 +0000 (UTC)
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
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/6] cgroup/cpuset: Clarify the use of invalid partition root
Date:   Mon, 21 Jun 2021 14:49:20 -0400
Message-Id: <20210621184924.27493-3-longman@redhat.com>
In-Reply-To: <20210621184924.27493-1-longman@redhat.com>
References: <20210621184924.27493-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For cpuset partition, the special state of PRS_ERROR (invalid partition
root) was originally designed to handle hotplug events. In this state,
CPUs allocated to the partition root is released back to the parent
but the cpuset flags remain unchanged.  However, certain manipulation
of cpuset control files could also cause a partition root to become
invalid though that was not the original intention.

Additional checks are now added to make sure that regular cpuset control
file manipulations are not allowed to make a partition root invalid. These
additional checks are:
 1) A partition root can't be changed to member if it has child partition
    roots.
 2) Removing CPUs from cpuset.cpus that causes it to become invalid is
    not allowed.

Comments are also added to clarify that a partition root becomes
invalid only when an external event like hotplug that causes all the
CPUs allocated to a partition root to become unavailable.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 136 ++++++++++++++++++++++++-----------------
 1 file changed, 79 insertions(+), 57 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d4164e07c61b..3fe68d0f593d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -174,7 +174,9 @@ struct cpuset {
  *       subparts_cpus. In this case, the cpuset is not a real partition
  *       root anymore.  However, the CPU_EXCLUSIVE bit will still be set
  *       and the cpuset can be restored back to a partition root if the
- *       parent cpuset can give more CPUs back to this child cpuset.
+ *       parent cpuset can give more CPUs back to this child cpuset. A
+ *       partition root becomes invalid when all its cpus become unavailable
+ *       like being offlined.
  */
 #define PRS_DISABLED		0
 #define PRS_ENABLED		1
@@ -1193,6 +1195,15 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		/*
 		 * partcmd_update with newmask:
 		 *
+		 * Return error if newmask isn't a subset of
+		 * (cpus_allowed | parent->effective_cpus).
+		 */
+		cpumask_or(tmp->addmask, cpuset->cpus_allowed,
+					 parent->effective_cpus);
+		if (!cpumask_subset(newmask, tmp->addmask))
+			return -EINVAL;
+
+		/*
 		 * delmask = cpus_allowed & ~newmask & parent->subparts_cpus
 		 * addmask = newmask & parent->effective_cpus
 		 *		     & ~parent->subparts_cpus
@@ -1205,7 +1216,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		adding = cpumask_andnot(tmp->addmask, tmp->addmask,
 					parent->subparts_cpus);
 		/*
-		 * Return error if the new effective_cpus could become empty.
+		 * Return error if parent's effective_cpus could become empty.
 		 */
 		if (adding &&
 		    cpumask_equal(parent->effective_cpus, tmp->addmask)) {
@@ -1221,20 +1232,35 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 				return -EINVAL;
 			cpumask_copy(tmp->addmask, parent->effective_cpus);
 		}
+
+		/*
+		 * Return error if effective_cpus becomes empty or any CPU
+		 * distributed to child partitions is deleted.
+		 */
+		if (deleting &&
+		   (cpumask_intersects(tmp->delmask, cpuset->subparts_cpus) ||
+		    cpumask_equal(tmp->delmask, cpuset->effective_cpus)))
+			return -EBUSY;
 	} else {
 		/*
 		 * partcmd_update w/o newmask:
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
@@ -1392,10 +1418,6 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 				 * When parent is invalid, it has to be too.
 				 */
 				cp->partition_root_state = PRS_ERROR;
-				if (cp->nr_subparts_cpus) {
-					cp->nr_subparts_cpus = 0;
-					cpumask_clear(cp->subparts_cpus);
-				}
 				break;
 			}
 		}
@@ -1406,38 +1428,32 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 
 		spin_lock_irq(&callback_lock);
 
-		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
 		if (cp->nr_subparts_cpus &&
 		   (cp->partition_root_state != PRS_ENABLED)) {
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
 		spin_unlock_irq(&callback_lock);
 
-		WARN_ON(!is_in_v2_mode() &&
+		WARN_ON_ONCE(!is_in_v2_mode() &&
 			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
 
 		update_tasks_cpumask(cp);
@@ -1560,8 +1576,8 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
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
@@ -1984,21 +2000,26 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		cs->partition_root_state = PRS_ENABLED;
 	} else {
 		/*
-		 * Turning off partition root will clear the
-		 * CS_CPU_EXCLUSIVE bit.
+		 * Switch back to member is always allowed if PRS_ERROR.
 		 */
 		if (cs->partition_root_state == PRS_ERROR) {
-			cs->partition_root_state = 0;
-			update_flag(CS_CPU_EXCLUSIVE, cs, 0);
 			err = 0;
-			goto out;
+			goto reset_flags;
 		}
 
+		/*
+		 * A partition root cannot be reverted to member if some
+		 * CPUs have been distributed to child partition roots.
+		 */
+		if (!cpumask_empty(cs->subparts_cpus))
+			return -EBUSY;
+
 		err = update_parent_subparts_cpumask(cs, partcmd_disable,
 						     NULL, &tmpmask);
 		if (err)
 			goto out;
 
+reset_flags:
 		cs->partition_root_state = 0;
 
 		/* Turning off CS_CPU_EXCLUSIVE will not return error */
@@ -3074,41 +3095,42 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 
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
+		update_parent_subparts_cpumask(cs, partcmd_disable,
+					       NULL, tmp);
 		if (cs->nr_subparts_cpus) {
 			cs->nr_subparts_cpus = 0;
 			cpumask_clear(cs->subparts_cpus);
 			compute_effective_cpumask(&new_cpus, cs, parent);
 		}
-
-		/*
-		 * If the effective_cpus is empty because the child
-		 * partitions take away all the CPUs, we can keep
-		 * the current partition and let the child partitions
-		 * fight for available CPUs.
-		 */
-		if ((parent->partition_root_state == PRS_ERROR) ||
-		     cpumask_empty(&new_cpus)) {
-			update_parent_subparts_cpumask(cs, partcmd_disable,
-						       NULL, tmp);
-			cs->partition_root_state = PRS_ERROR;
-		}
+		cs->partition_root_state = PRS_ERROR;
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

