Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D803E88A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 05:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhHKDHY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Aug 2021 23:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233349AbhHKDHP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Aug 2021 23:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628651212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=RjgTxrrVHpNmA5xrafpTlwExFvDWEzdgM6g+RhUC4dM=;
        b=HNCGrl4EZ9+VaEBM+c9dvJuH3bm0Gu4uv8VcQxL0T56e6ThNafdAYToFI4odFd3X8Vwqqa
        UjBu6ltCLjKOSGmhz9HLiymVhTfaEv0VkdcTjW+aepN2lRPfn5u9y2fgTQt6j3WoTcqZK/
        6OdKaFPxpTcgW3TW3yG+c/W8bNf3fIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-tXkHPAqBPI250L7WNdtcvw-1; Tue, 10 Aug 2021 23:06:49 -0400
X-MC-Unique: tXkHPAqBPI250L7WNdtcvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BBC087146F;
        Wed, 11 Aug 2021 03:06:47 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DD485D6CF;
        Wed, 11 Aug 2021 03:06:45 +0000 (UTC)
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
Subject: [PATCH v4 4/6] cgroup/cpuset: Allow non-top parent partition root to distribute out all CPUs
Date:   Tue, 10 Aug 2021 23:06:05 -0400
Message-Id: <20210811030607.13824-5-longman@redhat.com>
In-Reply-To: <20210811030607.13824-1-longman@redhat.com>
References: <20210811030607.13824-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 kernel/cgroup/cpuset.c | 91 ++++++++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 30 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 498fd418fd30..d8c1d01bdd81 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -279,6 +279,11 @@ static inline void notify_partition_change(struct cpuset *cs,
 		cgroup_file_notify(&cs->partition_file);
 }
 
+static inline int cpuset_has_tasks(const struct cpuset *cs)
+{
+	return cs->css.cgroup->nr_populated_csets;
+}
+
 static struct cpuset top_cpuset = {
 	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
 		  (1 << CS_MEM_EXCLUSIVE)),
@@ -1186,22 +1191,32 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
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
@@ -1231,20 +1246,21 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		adding = cpumask_andnot(tmp->addmask, tmp->addmask,
 					parent->subparts_cpus);
 		/*
-		 * Return error if parent's effective_cpus could become empty.
+		 * Make partition invalid if parent's effective_cpus could
+		 * become empty and there are tasks in the parent.
 		 */
-		if (adding &&
+		if (adding && cpuset_has_tasks(parent) &&
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
@@ -1266,7 +1282,8 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 				     parent->effective_cpus);
 		part_error = (is_partition_root(cpuset) &&
 			      !parent->nr_subparts_cpus) ||
-			     cpumask_equal(tmp->addmask, parent->effective_cpus);
+			     (cpumask_equal(tmp->addmask, parent->effective_cpus) &&
+			      cpuset_has_tasks(parent));
 	}
 
 	if (cmd == partcmd_update) {
@@ -1367,9 +1384,15 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 
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
@@ -1391,6 +1414,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 			continue;
 		}
 
+update_parent_subparts:
 		/*
 		 * update_parent_subparts_cpumask() should have been called
 		 * for cs already in update_cpumask(). We should also call
@@ -1466,12 +1490,9 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
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
 
@@ -2215,6 +2236,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
@@ -3082,7 +3110,8 @@ hotplug_update_tasks(struct cpuset *cs,
 		     struct cpumask *new_cpus, nodemask_t *new_mems,
 		     bool cpus_updated, bool mems_updated)
 {
-	if (cpumask_empty(new_cpus))
+	/* A partition root is allowed to have empty effective cpus */
+	if (cpumask_empty(new_cpus) && !is_partition_root(cs))
 		cpumask_copy(new_cpus, parent_cs(cs)->effective_cpus);
 	if (nodes_empty(*new_mems))
 		*new_mems = parent_cs(cs)->effective_mems;
@@ -3151,22 +3180,24 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 
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
 		int old_prs;
-- 
2.18.1

