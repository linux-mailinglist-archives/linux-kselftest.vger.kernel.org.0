Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA070468CBA
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Dec 2021 19:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbhLESgb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Dec 2021 13:36:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237284AbhLESga (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Dec 2021 13:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638729182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8+8+iCujMArddSROZhQzh3V70AUJDahmZr/fRjBKK0U=;
        b=JbC+jUODfRuYgTnXlpgJhVw3kvNpnknqGCj9qGKlZSD13fF3aR4WLrOpdCJqW0wZFsDDzr
        PNmol5ANl5jx5Am0u6z2zodoJPt1gYtHGNdBqUExsyBMl+sAatqEda+/rdMQtHCWZ016HC
        yrkrDkcMgY1/HCbF7iwHzYJ8NzhaTzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-Jsle5WMRM0q4NxId20jzSw-1; Sun, 05 Dec 2021 13:32:59 -0500
X-MC-Unique: Jsle5WMRM0q4NxId20jzSw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65B9E2F24;
        Sun,  5 Dec 2021 18:32:56 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCA02694D7;
        Sun,  5 Dec 2021 18:32:54 +0000 (UTC)
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
Subject: [PATCH v9 2/7] cgroup/cpuset: Allow no-task partition to have empty cpuset.cpus.effective
Date:   Sun,  5 Dec 2021 13:32:15 -0500
Message-Id: <20211205183220.818872-3-longman@redhat.com>
In-Reply-To: <20211205183220.818872-1-longman@redhat.com>
References: <20211205183220.818872-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, a partition root cannot have empty "cpuset.cpus.effective".
As a result, a parent partition root cannot distribute out all its CPUs
 to child partitions with no CPUs left. However in most cases, there
shouldn't be any tasks associated with intermediate nodes of the default
 hierarchy. So the current rule is too restrictive and can waste valuable
 CPU resource.

To address this issue, we are now allowing a partition to have empty
"cpuset.cpus.effective" as long as it has no task. Therefore, a parent
partition with no task can now have all its CPUs distributed out to its
child partitions. The top cpuset always have some house-keeping tasks
running and so its list of effective cpu can't never be empty.

Once a partition with empty "cpuset.cpus.effective" is formed, no
new task can be moved into it until "cpuset.cpus.effective" becomes
non-empty.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 113 +++++++++++++++++++++++++++++++----------
 1 file changed, 85 insertions(+), 28 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0dd7d853ed17..dfa15677845e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -404,6 +404,41 @@ static inline bool is_in_v2_mode(void)
 	      (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
 }
 
+/**
+ * partition_is_populated - check if partition has tasks
+ * @cs: partition root to be checked
+ * @excluded_child: a child cpuset to be excluded in task checking
+ * Return: true if there are tasks, false otherwise
+ *
+ * It is assumed that @cs is a valid partition root. @excluded_child should
+ * be non-NULL when this cpuset is going to become a partition itself.
+ */
+static inline bool partition_is_populated(struct cpuset *cs,
+					  struct cpuset *excluded_child)
+{
+	struct cgroup_subsys_state *css;
+	struct cpuset *child;
+
+	if (cs->css.cgroup->nr_populated_csets)
+		return true;
+	if (!excluded_child && !cs->nr_subparts_cpus)
+		return cgroup_is_populated(cs->css.cgroup);
+
+	rcu_read_lock();
+	cpuset_for_each_child(child, css, cs) {
+		if (child == excluded_child)
+			continue;
+		if (is_partition_root(child))
+			continue;
+		if (cgroup_is_populated(child->css.cgroup)) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+	return false;
+}
+
 /*
  * Return in pmask the portion of a task's cpusets's cpus_allowed that
  * are online and are capable of running the task.  If none are found,
@@ -1208,22 +1243,25 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
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
-	/*
-	 * A cpumask update cannot make parent's effective_cpus become empty.
-	 */
 	adding = deleting = false;
 	old_prs = new_prs = cpuset->partition_root_state;
 	if (cmd == partcmd_enable) {
+		/*
+		 * Enabling partition root is not allowed if not all the CPUs
+		 * can be granted from parent's effective_cpus.
+		 */
+		if (!cpumask_subset(cpuset->cpus_allowed, parent->effective_cpus))
+			return -EINVAL;
+
+		/*
+		 * A parent can be left with no CPU as long as there is no
+		 * task directly associated with the parent partition. For
+		 * such a parent, no new task can be moved into it.
+		 */
+		if (partition_is_populated(parent, cpuset) &&
+		    cpumask_equal(cpuset->cpus_allowed, parent->effective_cpus))
+			return -EINVAL;
+
 		cpumask_copy(tmp->addmask, cpuset->cpus_allowed);
 		adding = true;
 	} else if (cmd == partcmd_disable) {
@@ -1245,9 +1283,10 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		adding = cpumask_andnot(tmp->addmask, tmp->addmask,
 					parent->subparts_cpus);
 		/*
-		 * Return error if the new effective_cpus could become empty.
+		 * Return error if the new effective_cpus could become empty
+		 * and there are tasks in the parent.
 		 */
-		if (adding &&
+		if (adding && partition_is_populated(parent, cpuset) &&
 		    cpumask_equal(parent->effective_cpus, tmp->addmask)) {
 			if (!deleting)
 				return -EINVAL;
@@ -1273,8 +1312,8 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		 */
 		adding = cpumask_and(tmp->addmask, cpuset->cpus_allowed,
 				     parent->effective_cpus);
-		part_error = cpumask_equal(tmp->addmask,
-					   parent->effective_cpus);
+		part_error = cpumask_equal(tmp->addmask, parent->effective_cpus) &&
+			     partition_is_populated(parent, cpuset);
 	}
 
 	if (cmd == partcmd_update) {
@@ -1376,9 +1415,15 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 
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
@@ -1400,6 +1445,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 			continue;
 		}
 
+update_parent_subparts:
 		/*
 		 * update_parent_subparts_cpumask() should have been called
 		 * for cs already in update_cpumask(). We should also call
@@ -2201,6 +2247,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
@@ -3065,7 +3118,8 @@ hotplug_update_tasks(struct cpuset *cs,
 		     struct cpumask *new_cpus, nodemask_t *new_mems,
 		     bool cpus_updated, bool mems_updated)
 {
-	if (cpumask_empty(new_cpus))
+	/* A partition root is allowed to have empty effective cpus */
+	if (cpumask_empty(new_cpus) && !is_partition_root(cs))
 		cpumask_copy(new_cpus, parent_cs(cs)->effective_cpus);
 	if (nodes_empty(*new_mems))
 		*new_mems = parent_cs(cs)->effective_mems;
@@ -3134,11 +3188,12 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 
 	/*
 	 * In the unlikely event that a partition root has empty
-	 * effective_cpus or its parent becomes erroneous, we have to
-	 * transition it to the erroneous state.
+	 * effective_cpus with tasks or its parent becomes erroneous, we
+	 * have to transition it to the erroneous state.
 	 */
-	if (is_partition_root(cs) && (cpumask_empty(&new_cpus) ||
-	   (parent->partition_root_state == PRS_ERROR))) {
+	if (is_partition_root(cs) &&
+	   ((cpumask_empty(&new_cpus) && partition_is_populated(cs, NULL)) ||
+	    (parent->partition_root_state == PRS_ERROR))) {
 		if (cs->nr_subparts_cpus) {
 			spin_lock_irq(&callback_lock);
 			cs->nr_subparts_cpus = 0;
@@ -3148,13 +3203,15 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		}
 
 		/*
-		 * If the effective_cpus is empty because the child
-		 * partitions take away all the CPUs, we can keep
-		 * the current partition and let the child partitions
-		 * fight for available CPUs.
+		 * Force the partition to become invalid if either one of
+		 * the following conditions hold:
+		 * 1) empty effective cpus but not valid empty partition.
+		 * 2) parent is invalid or doesn't grant any cpus to child
+		 *    partitions.
 		 */
 		if ((parent->partition_root_state == PRS_ERROR) ||
-		     cpumask_empty(&new_cpus)) {
+		    (cpumask_empty(&new_cpus) &&
+		     partition_is_populated(cs, NULL))) {
 			int old_prs;
 
 			update_parent_subparts_cpumask(cs, partcmd_disable,
-- 
2.27.0

