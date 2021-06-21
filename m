Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D063AF598
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jun 2021 20:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhFUSwM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Jun 2021 14:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231822AbhFUSwK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Jun 2021 14:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624301395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=DbRAbt176tzzAPvmL6EJFKHvZbyfzjJzu5p9Px+k+1U=;
        b=egl4NWDHqO8CdsbqKzGmgJGKIXSJoyADopypbEMapaG2Bu39IYJeOuEht7izSZ3vTn1w+7
        k5RKIScHWmKv6m4tn5n27t+yZoqemv1K04yr3B1zKlP7Z48Ze5K5kBSiZvcOHjTfsW1gQ8
        8zfob1hkKAwAKQkWzhoOKORCBUX9Yqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-Me0X6NnkPiauoPL9LJfamQ-1; Mon, 21 Jun 2021 14:49:53 -0400
X-MC-Unique: Me0X6NnkPiauoPL9LJfamQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD86C800D62;
        Mon, 21 Jun 2021 18:49:51 +0000 (UTC)
Received: from llong.com (ovpn-114-127.rdu2.redhat.com [10.10.114.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C4B25D9CA;
        Mon, 21 Jun 2021 18:49:50 +0000 (UTC)
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
Subject: [PATCH v2 4/6] cgroup/cpuset: Allow non-top parent partition root to distribute out all CPUs
Date:   Mon, 21 Jun 2021 14:49:22 -0400
Message-Id: <20210621184924.27493-5-longman@redhat.com>
In-Reply-To: <20210621184924.27493-1-longman@redhat.com>
References: <20210621184924.27493-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, a parent partition root cannot distribute all its CPUs to
child partition roots with no CPUs left. However in some use cases,
a management application may want to create a parent partition root as
a management unit with no task associated with it and has all its CPUs
distributed to various child partition roots dynamically according to
their needs. Leaving a cpu in the parent partition root in such a case is
now a waste.

To accommodate such use cases, a parent partition root can now have
all its CPUs distributed to its child partition roots as long as:
 1) it is not the top cpuset; and
 2) there is no task directly associated with the parent.

Once an empty parent partition root is formed, no new task can be moved
into it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 90 +++++++++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 27 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1a4b90e70e68..01b861b97a40 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -268,6 +268,11 @@ static inline int is_partition_root(const struct cpuset *cs)
 	return cs->partition_root_state > 0;
 }
 
+static inline int cpuset_has_tasks(const struct cpuset *cs)
+{
+	return cs->css.cgroup->nr_populated_csets;
+}
+
 static struct cpuset top_cpuset = {
 	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
 		  (1 << CS_MEM_EXCLUSIVE)),
@@ -1174,21 +1179,31 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	if ((cmd != partcmd_update) && css_has_online_children(&cpuset->css))
 		return -EBUSY;
 
-	/*
-	 * Enabling partition root is not allowed if not all the CPUs
-	 * can be granted from parent's effective_cpus or at least one
-	 * CPU will be left after that.
-	 */
-	if ((cmd == partcmd_enable) &&
-	   (!cpumask_subset(cpuset->cpus_allowed, parent->effective_cpus) ||
-	     cpumask_equal(cpuset->cpus_allowed, parent->effective_cpus)))
-		return -EINVAL;
-
 	/*
 	 * A cpumask update cannot make parent's effective_cpus become empty.
 	 */
 	adding = deleting = false;
 	if (cmd == partcmd_enable) {
+		bool parent_is_top_cpuset = !parent_cs(parent);
+		bool no_cpu_in_parent = cpumask_equal(cpuset->cpus_allowed,
+						      parent->effective_cpus);
+		/*
+		 * Enabling partition root is not allowed if not all the CPUs
+		 * can be granted from parent's effective_cpus. If the parent
+		 * is the top cpuset, at least one CPU must be left after that.
+		 */
+		if (!cpumask_subset(cpuset->cpus_allowed, parent->effective_cpus) ||
+		    (parent_is_top_cpuset && no_cpu_in_parent))
+			return -EINVAL;
+
+		/*
+		 * A non-top parent can be left with no CPU as long as there
+		 * is no task directly associated with the parent. For such
+		 * a parent, no new task can be moved into it.
+		 */
+		if (no_cpu_in_parent && cpuset_has_tasks(parent))
+			return -EINVAL;
+
 		cpumask_copy(tmp->addmask, cpuset->cpus_allowed);
 		adding = true;
 	} else if (cmd == partcmd_disable) {
@@ -1219,9 +1234,10 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		adding = cpumask_andnot(tmp->addmask, tmp->addmask,
 					parent->subparts_cpus);
 		/*
-		 * Return error if parent's effective_cpus could become empty.
+		 * Return error if parent's effective_cpus could become empty
+		 * and there are tasks in the parent.
 		 */
-		if (adding &&
+		if (adding && cpuset_has_tasks(parent) &&
 		    cpumask_equal(parent->effective_cpus, tmp->addmask)) {
 			if (!deleting)
 				return -EINVAL;
@@ -1237,12 +1253,13 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		}
 
 		/*
-		 * Return error if effective_cpus becomes empty or any CPU
-		 * distributed to child partitions is deleted.
+		 * Return error if effective_cpus becomes empty with tasks
+		 * or any CPU distributed to child partitions is deleted.
 		 */
 		if (deleting &&
 		   (cpumask_intersects(tmp->delmask, cpuset->subparts_cpus) ||
-		    cpumask_equal(tmp->delmask, cpuset->effective_cpus)))
+		   (cpumask_equal(tmp->delmask, cpuset->effective_cpus) &&
+		    cpuset_has_tasks(cpuset))))
 			return -EBUSY;
 	} else {
 		/*
@@ -1263,7 +1280,8 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 				     parent->effective_cpus);
 		part_error = (is_partition_root(cpuset) &&
 			      !parent->nr_subparts_cpus) ||
-			     cpumask_equal(tmp->addmask, parent->effective_cpus);
+			     (cpumask_equal(tmp->addmask, parent->effective_cpus) &&
+			      cpuset_has_tasks(parent));
 	}
 
 	if (cmd == partcmd_update) {
@@ -1364,9 +1382,15 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 
 		/*
 		 * If it becomes empty, inherit the effective mask of the
-		 * parent, which is guaranteed to have some CPUs.
+		 * parent, which is guaranteed to have some CPUs unless
+		 * it is a partition root that has explicitly distributed
+		 * out all its CPUs.
 		 */
 		if (is_in_v2_mode() && cpumask_empty(tmp->new_cpus)) {
+			if (is_partition_root(cp) &&
+			    cpumask_equal(cp->cpus_allowed, cp->subparts_cpus))
+				goto update_parent_subparts;
+
 			cpumask_copy(tmp->new_cpus, parent->effective_cpus);
 			if (!cp->use_parent_ecpus) {
 				cp->use_parent_ecpus = true;
@@ -1388,6 +1412,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 			continue;
 		}
 
+update_parent_subparts:
 		/*
 		 * update_parent_subparts_cpumask() should have been called
 		 * for cs already in update_cpumask(). We should also call
@@ -1458,7 +1483,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 			 */
 			cpumask_andnot(cp->effective_cpus, cp->effective_cpus,
 				       cp->subparts_cpus);
-			WARN_ON_ONCE(cpumask_empty(cp->effective_cpus));
+			WARN_ON_ONCE(cpumask_empty(cp->effective_cpus) &&
+				     cpuset_has_tasks(cp));
 		}
 		spin_unlock_irq(&callback_lock);
 
@@ -1787,7 +1813,7 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 		cp->effective_mems = *new_mems;
 		spin_unlock_irq(&callback_lock);
 
-		WARN_ON(!is_in_v2_mode() &&
+		WARN_ON_ONCE(!is_in_v2_mode() &&
 			!nodes_equal(cp->mems_allowed, cp->effective_mems));
 
 		update_tasks_nodemask(cp);
@@ -2201,6 +2227,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	    (cpumask_empty(cs->cpus_allowed) || nodes_empty(cs->mems_allowed)))
 		goto out_unlock;
 
+	/*
+	 * On default hierarchy, task cannot be moved to a cpuset with empty
+	 * effective cpus.
+	 */
+	if (is_in_v2_mode() && cpumask_empty(cs->effective_cpus))
+		goto out_unlock;
+
 	cgroup_taskset_for_each(task, css, tset) {
 		ret = task_can_attach(task, cs->cpus_allowed);
 		if (ret)
@@ -3067,7 +3100,8 @@ hotplug_update_tasks(struct cpuset *cs,
 		     struct cpumask *new_cpus, nodemask_t *new_mems,
 		     bool cpus_updated, bool mems_updated)
 {
-	if (cpumask_empty(new_cpus))
+	/* A partition root is allowed to have empty effective cpus */
+	if (cpumask_empty(new_cpus) && !is_partition_root(cs))
 		cpumask_copy(new_cpus, parent_cs(cs)->effective_cpus);
 	if (nodes_empty(*new_mems))
 		*new_mems = parent_cs(cs)->effective_mems;
@@ -3136,22 +3170,24 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 
 	/*
 	 * In the unlikely event that a partition root has empty
-	 * effective_cpus, we will have to force any child partitions,
-	 * if present, to become invalid by setting nr_subparts_cpus to 0
-	 * without causing itself to become invalid.
+	 * effective_cpus with tasks, we will have to force any child
+	 * partitions, if present, to become invalid by setting
+	 * nr_subparts_cpus to 0 without causing itself to become invalid.
 	 */
 	if (is_partition_root(cs) && cs->nr_subparts_cpus &&
-	    cpumask_empty(&new_cpus)) {
+	    cpumask_empty(&new_cpus) && cpuset_has_tasks(cs)) {
 		cs->nr_subparts_cpus = 0;
 		cpumask_clear(cs->subparts_cpus);
 		compute_effective_cpumask(&new_cpus, cs, parent);
 	}
 
 	/*
-	 * If empty effective_cpus or zero nr_subparts_cpus or its parent
-	 * becomes erroneous, we have to transition it to the erroneous state.
+	 * If empty effective_cpus with tasks or zero nr_subparts_cpus or
+	 * its parent becomes erroneous, we have to transition it to the
+	 * erroneous state.
 	 */
-	if (is_partition_root(cs) && (cpumask_empty(&new_cpus) ||
+	if (is_partition_root(cs) &&
+	   ((cpumask_empty(&new_cpus) && cpuset_has_tasks(cs)) ||
 	    (parent->partition_root_state == PRS_ERROR) ||
 	    !parent->nr_subparts_cpus)) {
 		update_parent_subparts_cpumask(cs, partcmd_disable,
-- 
2.18.1

