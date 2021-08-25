Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D43F3F7DDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Aug 2021 23:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhHYVlZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 17:41:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234655AbhHYVlY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 17:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629927638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=wMA7PWnY1h3372d3wE9fc5ozoKuN9F8xXaIWjkQLbKM=;
        b=f2bgSiNeYtY884Uai1PvcPyAnc+WCRvRGVCN9ztSytz2lzJCxabqykY8UPYuDmgXvSyzsL
        IAC+tlFNCGmN5CbfCH1Wz6SaN1EY+CYgdS0dXfQeD0XJ+lgsfjYvyUEUuPQPqIW1gClO9d
        Qr13rSrIEMCRBc3UBcLfGuOngVklpt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-SSMgYd8qPamWat4W-XV_lg-1; Wed, 25 Aug 2021 17:40:34 -0400
X-MC-Unique: SSMgYd8qPamWat4W-XV_lg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8613801A92;
        Wed, 25 Aug 2021 21:40:32 +0000 (UTC)
Received: from llong.com (unknown [10.22.18.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 756051B472;
        Wed, 25 Aug 2021 21:40:30 +0000 (UTC)
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
Subject: [PATCH v7 4/6] cgroup/cpuset: Allow non-top parent partition to distribute out all CPUs
Date:   Wed, 25 Aug 2021 17:37:48 -0400
Message-Id: <20210825213750.6933-5-longman@redhat.com>
In-Reply-To: <20210825213750.6933-1-longman@redhat.com>
References: <20210825213750.6933-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, a parent partition cannot distribute all its CPUs to child
partitions with no CPUs left. However in some use cases, a management
application may want to create a parent partition as a management unit
with no task associated with it and has all its CPUs distributed to
various child partitions dynamically according to their needs. Leaving
a cpu in the parent partition in such a case is now a waste.

To accommodate such use cases, a parent partition can now have all its
CPUs distributed to its child partitions with 0 effective cpu left as
long as it is not the top cpuset and it has no task at the time the
child partition is being created. A terminal partition with no child
partition underlying it, however, cannot have 0 effective cpu which
will make the partition invalid.

Once an empty parent partition is formed, no new task can be moved
into it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 96 ++++++++++++++++++++++++++++++------------
 1 file changed, 69 insertions(+), 27 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index de770a3781c2..3658270d694c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -305,6 +305,21 @@ static inline void notify_partition_change(struct cpuset *cs,
 		WRITE_ONCE(cs->prs_err, PERR_NONE);
 }
 
+static inline int cpuset_has_tasks(const struct cpuset *cs)
+{
+	return cs->css.cgroup->nr_populated_csets;
+}
+
+/*
+ * A empty partition (one with no effective cpu) is valid if it has no
+ * associated task and all its cpus have been distributed out to child
+ * partitions.
+ */
+static inline bool valid_empty_partition(const struct cpuset *cs)
+{
+	return !cpuset_has_tasks(cs) && cs->nr_subparts_cpus;
+}
+
 static struct cpuset top_cpuset = {
 	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
 		  (1 << CS_MEM_EXCLUSIVE)),
@@ -1211,22 +1226,32 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	if ((cmd == partcmd_enable) && css_has_online_children(&cpuset->css))
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
 	old_prs = new_prs = cpuset->partition_root_state;
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
@@ -1257,9 +1282,9 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 					parent->subparts_cpus);
 		/*
 		 * Make partition invalid if parent's effective_cpus could
-		 * become empty.
+		 * become empty and there are tasks in the parent.
 		 */
-		if (adding &&
+		if (adding && cpuset_has_tasks(parent) &&
 		    cpumask_equal(parent->effective_cpus, tmp->addmask)) {
 			if (!deleting)
 				part_error = true;
@@ -1294,7 +1319,9 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 				     parent->effective_cpus);
 		part_error = (is_partition_root(cpuset) &&
 			      !parent->nr_subparts_cpus) ||
-			     cpumask_equal(tmp->addmask, parent->effective_cpus);
+			     (cpumask_equal(tmp->addmask, parent->effective_cpus) &&
+			      cpuset_has_tasks(parent));
+
 		if (is_partition_root(cpuset) && part_error)
 			WRITE_ONCE(cpuset->prs_err, PERR_NOCPUS);
 	}
@@ -1397,9 +1424,15 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 
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
@@ -1421,6 +1454,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 			continue;
 		}
 
+update_parent_subparts:
 		/*
 		 * update_parent_subparts_cpumask() should have been called
 		 * for cs already in update_cpumask(). We should also call
@@ -1497,12 +1531,9 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 			 */
 			cpumask_andnot(cp->effective_cpus, cp->effective_cpus,
 				       cp->subparts_cpus);
-			WARN_ON_ONCE(cpumask_empty(cp->effective_cpus));
 		}
 
-		if (new_prs != old_prs)
-			cp->partition_root_state = new_prs;
-
+		cp->partition_root_state = new_prs;
 		spin_unlock_irq(&callback_lock);
 		notify_partition_change(cp, old_prs, new_prs);
 
@@ -2249,6 +2280,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
@@ -3125,7 +3163,8 @@ hotplug_update_tasks(struct cpuset *cs,
 		     struct cpumask *new_cpus, nodemask_t *new_mems,
 		     bool cpus_updated, bool mems_updated)
 {
-	if (cpumask_empty(new_cpus))
+	/* A partition root is allowed to have empty effective cpus */
+	if (cpumask_empty(new_cpus) && !is_partition_root(cs))
 		cpumask_copy(new_cpus, parent_cs(cs)->effective_cpus);
 	if (nodes_empty(*new_mems))
 		*new_mems = parent_cs(cs)->effective_mems;
@@ -3194,22 +3233,25 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 
 	/*
 	 * In the unlikely event that a partition root has empty
-	 * effective_cpus, we will have to force any child partitions,
-	 * if present, to become invalid by setting nr_subparts_cpus to 0
-	 * without causing itself to become invalid.
+	 * effective_cpus with tasks, we will have to force any child
+	 * partitions, if present, to become invalid by setting
+	 * nr_subparts_cpus to 0 without causing itself to become invalid.
 	 */
-	if (is_partition_root(cs) && cs->nr_subparts_cpus &&
-	    cpumask_empty(&new_cpus)) {
+	if (is_partition_root(cs) && cpumask_empty(&new_cpus) &&
+	    !valid_empty_partition(cs)) {
 		cs->nr_subparts_cpus = 0;
 		cpumask_clear(cs->subparts_cpus);
 		compute_effective_cpumask(&new_cpus, cs, parent);
 	}
 
 	/*
-	 * If empty effective_cpus or zero nr_subparts_cpus or its parent
-	 * becomes erroneous, we have to transition it to the erroneous state.
+	 * Force the partition to become invalid if either one of
+	 * the following conditions hold:
+	 * 1) empty effective cpus but not valid empty partition.
+	 * 2) parent is invalid or doesn't grant any cpus to child partitions.
 	 */
-	if (is_partition_root(cs) && (cpumask_empty(&new_cpus) ||
+	if (is_partition_root(cs) &&
+	   ((cpumask_empty(&new_cpus) && !valid_empty_partition(cs)) ||
 	    (parent->partition_root_state == PRS_ERROR) ||
 	    !parent->nr_subparts_cpus)) {
 		int old_prs;
-- 
2.18.1

