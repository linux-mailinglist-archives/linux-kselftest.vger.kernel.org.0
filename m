Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421B5521F00
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 17:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346104AbiEJPjj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345931AbiEJPjR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 11:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 267D7227B52
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652196878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nVXNyIRV2oen/9XPUcme0qMuRQMlYQhINpp0nE03d8=;
        b=TLe4wpY7Pe2gKAx5PDl+0B6MhdD96F32ewE1ZFLn6GJTsrnJV4vsfKqSWEYbWIH+UKmLUD
        MhMNE0oHQyAhXIIYEFmBVXET9EhMoRo8ewujvkD2IL1wkv7IvJfee1QWmL3wnzWSjkb4u2
        Tbm7O7rAg+vxDgE9scZJYFv9rAj53FE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-UoWAwQNqMuioQKLE6UORRA-1; Tue, 10 May 2022 11:34:35 -0400
X-MC-Unique: UoWAwQNqMuioQKLE6UORRA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27948811E84;
        Tue, 10 May 2022 15:34:34 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE0FE401E31;
        Tue, 10 May 2022 15:34:33 +0000 (UTC)
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
Subject: [PATCH v11 3/8] cgroup/cpuset: Allow no-task partition to have empty cpuset.cpus.effective
Date:   Tue, 10 May 2022 11:34:08 -0400
Message-Id: <20220510153413.400020-4-longman@redhat.com>
In-Reply-To: <20220510153413.400020-1-longman@redhat.com>
References: <20220510153413.400020-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, a partition root cannot have empty "cpuset.cpus.effective".
As a result, a parent partition root cannot distribute out all its
CPUs to child partitions with no CPUs left. However in most cases,
there shouldn't be any tasks associated with intermediate nodes of the
default hierarchy. So the current rule is too restrictive and can waste
valuable CPU resource.

To address this issue, we are now allowing a partition to have empty
"cpuset.cpus.effective" as long as it has no task. Therefore, a parent
partition with no task can now have all its CPUs distributed out to its
child partitions. The top cpuset always have some house-keeping tasks
running and so its list of effective cpu can't be empty.

Once a partition with empty "cpuset.cpus.effective" is formed, no
new task can be moved into it until "cpuset.cpus.effective" becomes
non-empty.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 112 +++++++++++++++++++++++++++++++----------
 1 file changed, 85 insertions(+), 27 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d156a39d7a08..6c65bcf278cb 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -412,6 +412,41 @@ static inline bool is_in_v2_mode(void)
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
+		if (is_partition_valid(child))
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
@@ -1252,22 +1287,25 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	if ((cmd != partcmd_update) && css_has_online_children(&cs->css))
 		return -EBUSY;
 
-	/*
-	 * Enabling partition root is not allowed if not all the CPUs
-	 * can be granted from parent's effective_cpus or at least one
-	 * CPU will be left after that.
-	 */
-	if ((cmd == partcmd_enable) &&
-	   (!cpumask_subset(cs->cpus_allowed, parent->effective_cpus) ||
-	     cpumask_equal(cs->cpus_allowed, parent->effective_cpus)))
-		return -EINVAL;
-
-	/*
-	 * A cpumask update cannot make parent's effective_cpus become empty.
-	 */
 	adding = deleting = false;
 	old_prs = new_prs = cs->partition_root_state;
 	if (cmd == partcmd_enable) {
+		/*
+		 * Enabling partition root is not allowed if not all the CPUs
+		 * can be granted from parent's effective_cpus.
+		 */
+		if (!cpumask_subset(cs->cpus_allowed, parent->effective_cpus))
+			return -EINVAL;
+
+		/*
+		 * A parent can be left with no CPU as long as there is no
+		 * task directly associated with the parent partition. For
+		 * such a parent, no new task can be moved into it.
+		 */
+		if (cpumask_equal(cs->cpus_allowed, parent->effective_cpus) &&
+		    partition_is_populated(parent, cs))
+			return -EINVAL;
+
 		cpumask_copy(tmp->addmask, cs->cpus_allowed);
 		adding = true;
 	} else if (cmd == partcmd_disable) {
@@ -1289,10 +1327,12 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		adding = cpumask_andnot(tmp->addmask, tmp->addmask,
 					parent->subparts_cpus);
 		/*
-		 * Return error if the new effective_cpus could become empty.
+		 * Return error if the new effective_cpus could become empty
+		 * and there are tasks in the parent.
 		 */
 		if (adding &&
-		    cpumask_equal(parent->effective_cpus, tmp->addmask)) {
+		    cpumask_equal(parent->effective_cpus, tmp->addmask) &&
+		    partition_is_populated(parent, cs)) {
 			if (!deleting)
 				return -EINVAL;
 			/*
@@ -1317,8 +1357,8 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		 */
 		adding = cpumask_and(tmp->addmask, cs->cpus_allowed,
 				     parent->effective_cpus);
-		part_error = cpumask_equal(tmp->addmask,
-					   parent->effective_cpus);
+		part_error = cpumask_equal(tmp->addmask, parent->effective_cpus) &&
+			     partition_is_populated(parent, cs);
 	}
 
 	if (cmd == partcmd_update) {
@@ -1420,9 +1460,15 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 
 		/*
 		 * If it becomes empty, inherit the effective mask of the
-		 * parent, which is guaranteed to have some CPUs.
+		 * parent, which is guaranteed to have some CPUs unless
+		 * it is a partition root that has explicitly distributed
+		 * out all its CPUs.
 		 */
 		if (is_in_v2_mode() && cpumask_empty(tmp->new_cpus)) {
+			if (is_partition_valid(cp) &&
+			    cpumask_equal(cp->cpus_allowed, cp->subparts_cpus))
+				goto update_parent_subparts;
+
 			cpumask_copy(tmp->new_cpus, parent->effective_cpus);
 			if (!cp->use_parent_ecpus) {
 				cp->use_parent_ecpus = true;
@@ -1444,6 +1490,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 			continue;
 		}
 
+update_parent_subparts:
 		/*
 		 * update_parent_subparts_cpumask() should have been called
 		 * for cs already in update_cpumask(). We should also call
@@ -2249,6 +2296,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
@@ -3115,7 +3169,8 @@ hotplug_update_tasks(struct cpuset *cs,
 		     struct cpumask *new_cpus, nodemask_t *new_mems,
 		     bool cpus_updated, bool mems_updated)
 {
-	if (cpumask_empty(new_cpus))
+	/* A partition root is allowed to have empty effective cpus */
+	if (cpumask_empty(new_cpus) && !is_partition_valid(cs))
 		cpumask_copy(new_cpus, parent_cs(cs)->effective_cpus);
 	if (nodes_empty(*new_mems))
 		*new_mems = parent_cs(cs)->effective_mems;
@@ -3184,10 +3239,11 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 
 	/*
 	 * In the unlikely event that a partition root has empty
-	 * effective_cpus or its parent becomes invalid, we have to
-	 * transition it to the invalid state.
+	 * effective_cpus with tasks or its parent becomes invalid, we
+	 * have to transition it to the invalid state.
 	 */
-	if (is_partition_valid(cs) && (cpumask_empty(&new_cpus) ||
+	if (is_partition_valid(cs) &&
+	   ((cpumask_empty(&new_cpus) && partition_is_populated(cs, NULL)) ||
 	    is_partition_invalid(parent))) {
 		if (cs->nr_subparts_cpus) {
 			spin_lock_irq(&callback_lock);
@@ -3198,13 +3254,15 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
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
 		if (is_partition_invalid(parent) ||
-		     cpumask_empty(&new_cpus)) {
+		    (cpumask_empty(&new_cpus) &&
+		     partition_is_populated(cs, NULL))) {
 			int old_prs;
 
 			update_parent_subparts_cpumask(cs, partcmd_disable,
-- 
2.27.0

