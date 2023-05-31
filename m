Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6A471878F
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 18:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjEaQgh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEaQgX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 12:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC77E5A
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685550859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=huxOXSUowwd1tXGrlrpMLvoq5FwRvlfTWIg18UA81GE=;
        b=EmmS0P989dA0lQS2PwZAnBzZM76JwoNd3dXmzaZHmDLsJzZTYunTmZ/bz8Ehdh6JOx9/x/
        Q9IkU0CEWlONHyp4pMkrrd9AqDcpLF91raUzl06Iq7m3kqRZpS3MjgLRtG1OeRg7sts25r
        goC00rhS8AgoDRm5aKV1MfYTpmJhI/8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-QXO1xQS0PnGOFuuYU1_Ktw-1; Wed, 31 May 2023 12:34:14 -0400
X-MC-Unique: QXO1xQS0PnGOFuuYU1_Ktw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCA14802A55;
        Wed, 31 May 2023 16:34:13 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42D992166B25;
        Wed, 31 May 2023 16:34:13 +0000 (UTC)
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
Subject: [PATCH v2 4/6] cgroup/cpuset: Introduce remote isolated partition
Date:   Wed, 31 May 2023 12:34:03 -0400
Message-Id: <20230531163405.2200292-5-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
top cpuset's cpuset.cpus.reserve. For contrast, the existing type of
partitions where their parents have to be valid partition roots are
referred to as adjacent partitions as they have to be clustered around
the cgroup root.

This patch enables only the creation of remote isolated partitions
for now.

The creation of a remote isolated partition is a 2-step process.

 1) Reserve the CPUs needed by the remote partition by adding CPUs to
    cpuset.cpus.reserve of the top cpuset.

 2) Enable an isolated partition by
	# echo isolated > cpuset.cpus.partition

Such a remote isolated partition P will only be valid if the following
conditions are true.

 1) P/cpuset.cpus is a subset of top cpuset's cpuset.cpus.reserve.
 2) All the CPUs in P/cpuset.cpus are present in the cpuset.cpus of
    all its ancestors to ensure that those CPUs are properly granted
    to P in a hierarchical manner.
 3) None of the CPUs in P/cpuset.cpus have been acquired by other valid
    partitions.

Like adjacent partitions, a remote partition has exclusive access to the
CPUs allocated to that partition. Because of the exclusive nature, none
of the cpuset.cpus of its sibling cpusets can contain any CPUs allocated
to the remote partition or the partition creation process will fail.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 306 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 291 insertions(+), 15 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 69abe95a9969..280018cddaba 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -98,6 +98,7 @@ enum prs_errcode {
 	PERR_NOCPUS,
 	PERR_HOTPLUG,
 	PERR_CPUSEMPTY,
+	PERR_RMTPARENT,
 };
 
 static const char * const perr_strings[] = {
@@ -108,6 +109,7 @@ static const char * const perr_strings[] = {
 	[PERR_NOCPUS]    = "Parent unable to distribute cpu downstream",
 	[PERR_HOTPLUG]   = "No cpu available due to hotplug",
 	[PERR_CPUSEMPTY] = "cpuset.cpus is empty",
+	[PERR_RMTPARENT] = "New partition not allowed under remote partition",
 };
 
 struct cpuset {
@@ -206,6 +208,9 @@ struct cpuset {
 
 	/* Handle for cpuset.cpus.partition */
 	struct cgroup_file partition_file;
+
+	/* Remote partition silbling list anchored at remote_children */
+	struct list_head remote_sibling;
 };
 
 /*
@@ -236,6 +241,9 @@ static cpumask_var_t	cs_reserve_cpus;	/* Reserved CPUs */
 static cpumask_var_t	cs_free_reserve_cpus;	/* Unallocated reserved CPUs */
 static cpumask_var_t	cs_tmp_cpus;		/* Temp cpumask for partition */
 
+/* List of remote partition root children */
+static struct list_head remote_children;
+
 /*
  * Partition root states:
  *
@@ -385,6 +393,8 @@ static struct cpuset top_cpuset = {
 	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
 		  (1 << CS_MEM_EXCLUSIVE)),
 	.partition_root_state = PRS_ROOT,
+	.remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
+
 };
 
 /**
@@ -1385,6 +1395,209 @@ static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
 		rebuild_sched_domains_locked();
 }
 
+static inline bool is_remote_partition(struct cpuset *cs)
+{
+	return !list_empty(&cs->remote_sibling);
+}
+
+/*
+ * update_isolated_cpumasks_hier - Update effective cpumasks and tasks
+ * @cs: the cpuset to consider
+ * @lb: load balance flag
+ *
+ * This is called for descendant cpusets when a cpuset switches to or
+ * from an isolated remote partition. There can't be any remote partitions
+ * underneath it.
+ */
+static void update_isolated_cpumasks_hier(struct cpuset *cs, bool lb)
+{
+	struct cpuset *cp;
+	struct cgroup_subsys_state *pos_css;
+
+	rcu_read_lock();
+	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
+		struct cpuset *parent = parent_cs(cp);
+
+		if (cp == cs)
+			continue;	/* Skip partition root */
+
+		WARN_ON_ONCE(is_partition_valid(cp));
+		spin_lock_irq(&callback_lock);
+
+		if (cpumask_and(cp->effective_cpus, cp->cpus_allowed,
+				parent->effective_cpus)) {
+			if (cp->use_parent_ecpus) {
+				WARN_ON_ONCE(--parent->child_ecpus_count < 0);
+				cp->use_parent_ecpus = false;
+			}
+		} else {
+			cpumask_copy(cp->effective_cpus, parent->effective_cpus);
+			if (!cp->use_parent_ecpus) {
+				parent->child_ecpus_count++;
+				cp->use_parent_ecpus = true;
+			}
+		}
+		if (lb)
+			set_bit(CS_SCHED_LOAD_BALANCE, &cp->flags);
+		else
+			clear_bit(CS_SCHED_LOAD_BALANCE, &cp->flags);
+
+		spin_unlock_irq(&callback_lock);
+	}
+	rcu_read_unlock();
+}
+
+/*
+ * isolated_cpus_acquire - Acquire isolated CPUs from cpuset.cpus.reserve
+ * @cs: the cpuset to update
+ * Return: 1 if successful, 0 if error
+ *
+ * Acquire isolated CPUs from cpuset.cpus.reserve and become an isolated
+ * partition root. cpuset_mutex must be held by the caller.
+ *
+ * Note that freely available reserve CPUs have already been isolated, so
+ * we don't need to rebuild sched domains. Since the cpuset is likely
+ * using effective_cpus from its parent before the conversion, we have to
+ * update parent's child_ecpus_count accordingly.
+ */
+static int isolated_cpus_acquire(struct cpuset *cs)
+{
+	struct cpuset *ancestor, *parent;
+
+	ancestor = parent = parent_cs(cs);
+
+	/*
+	 * To enable acquiring of isolated CPUs from cpuset.cpus.reserve,
+	 * cpus_allowed must be a subset of both its ancestor's cpus_allowed
+	 * and cs_free_reserve_cpus and the user must have sysadmin privilege.
+	 */
+	if (!capable(CAP_SYS_ADMIN) ||
+	    !cpumask_subset(cs->cpus_allowed, cs_free_reserve_cpus))
+		return 0;
+
+	/*
+	 * Check cpus_allowed of all its ancestors, except top_cpuset.
+	 */
+	while (ancestor != &top_cpuset) {
+		if (!cpumask_subset(cs->cpus_allowed, ancestor->cpus_allowed))
+			return 0;
+		ancestor = parent_cs(ancestor);
+	}
+
+	spin_lock_irq(&callback_lock);
+	cpumask_andnot(cs_free_reserve_cpus,
+		       cs_free_reserve_cpus, cs->cpus_allowed);
+	cpumask_and(cs->effective_cpus, cs->cpus_allowed, cpu_active_mask);
+
+	if (cs->use_parent_ecpus) {
+		cs->use_parent_ecpus = false;
+		parent->child_ecpus_count--;
+	}
+	list_add(&cs->remote_sibling, &remote_children);
+	clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
+	spin_unlock_irq(&callback_lock);
+
+	if (!list_empty(&cs->css.children))
+		update_isolated_cpumasks_hier(cs, false);
+
+	return 1;
+}
+
+/*
+ * isolated_cpus_release - Release isolated CPUs back to cpuset.cpus.reserve
+ * @cs: the cpuset to update
+ *
+ * Release isolated CPUs back to cpuset.cpus.reserve.
+ * cpuset_mutex must be held by the caller.
+ */
+static void isolated_cpus_release(struct cpuset *cs)
+{
+	struct cpuset *parent = parent_cs(cs);
+
+	if (!is_remote_partition(cs))
+		return;
+
+	/*
+	 * This can be called when the cpu list in cs_reserve_cpus
+	 * is reduced. So not all the cpus should be returned back to
+	 * cs_free_reserve_cpus.
+	 */
+	WARN_ON_ONCE(cs->partition_root_state != PRS_ISOLATED);
+	WARN_ON_ONCE(!cpumask_subset(cs->cpus_allowed, cs_reserve_cpus));
+	spin_lock_irq(&callback_lock);
+	if (!cpumask_and(cs->effective_cpus,
+			 parent->effective_cpus, cs->cpus_allowed)) {
+		cs->use_parent_ecpus = true;
+		parent->child_ecpus_count++;
+		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
+	}
+	list_del_init(&cs->remote_sibling);
+	cs->partition_root_state = PRS_INVALID_ISOLATED;
+	if (!cs->prs_err)
+		cs->prs_err = PERR_INVCPUS;
+
+	/* Add the CPUs back to cs_free_reserve_cpus */
+	cpumask_or(cs_free_reserve_cpus,
+		   cs_free_reserve_cpus, cs->cpus_allowed);
+
+	/*
+	 * There is no change in the CPU load balance state that requires
+	 * rebuilding sched domains. So the flags bits can be set directly.
+	 */
+	set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
+	clear_bit(CS_CPU_EXCLUSIVE, &cs->flags);
+	spin_unlock_irq(&callback_lock);
+
+	if (!list_empty(&cs->css.children))
+		update_isolated_cpumasks_hier(cs, true);
+}
+
+/*
+ * isolated_cpus_update - cpuset.cpus change in a remote isolated partition
+ *
+ * Return: 1 if successful, 0 if it needs to become invalid.
+ */
+static int isolated_cpus_update(struct cpuset *cs, struct cpumask *newmask,
+				struct tmpmasks *tmp)
+{
+	bool adding, deleting;
+
+	if (WARN_ON_ONCE((cs->partition_root_state != PRS_ISOLATED) ||
+			  !is_remote_partition(cs)))
+		return 0;
+
+	if (cpumask_empty(newmask))
+		goto invalidate;
+
+	adding   = cpumask_andnot(tmp->addmask, newmask, cs->cpus_allowed);
+	deleting = cpumask_andnot(tmp->delmask, cs->cpus_allowed, newmask);
+
+	/*
+	 * Additions of isolation CPUs is only allowed if those CPUs are
+	 * in cs_free_reserve_cpus and the caller has sysadmin privilege.
+	 */
+	if (adding && (!capable(CAP_SYS_ADMIN) ||
+		       !cpumask_subset(tmp->addmask, cs_free_reserve_cpus)))
+		goto invalidate;
+
+	spin_lock_irq(&callback_lock);
+	if (adding)
+		cpumask_andnot(cs_free_reserve_cpus,
+			       cs_free_reserve_cpus, tmp->addmask);
+	if (deleting)
+		cpumask_or(cs_free_reserve_cpus,
+			   cs_free_reserve_cpus, tmp->delmask);
+	cpumask_copy(cs->cpus_allowed, newmask);
+	cpumask_andnot(cs->effective_cpus, newmask, cs->subparts_cpus);
+	cpumask_and(cs->effective_cpus, cs->effective_cpus, cpu_active_mask);
+	spin_unlock_irq(&callback_lock);
+	return 1;
+
+invalidate:
+	isolated_cpus_release(cs);
+	return 0;
+}
+
 /**
  * update_parent_subparts_cpumask - update subparts_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -1457,9 +1670,12 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	if (cmd == partcmd_enable) {
 		/*
 		 * Enabling partition root is not allowed if cpus_allowed
-		 * doesn't overlap parent's cpus_allowed.
+		 * doesn't overlap parent's cpus_allowed or if it intersects
+		 * cs_free_reserve_cpus since it needs to be a remote partition
+		 * in this case.
 		 */
-		if (!cpumask_intersects(cs->cpus_allowed, parent->cpus_allowed))
+		if (!cpumask_intersects(cs->cpus_allowed, parent->cpus_allowed) ||
+		     cpumask_intersects(cs->cpus_allowed, cs_free_reserve_cpus))
 			return PERR_INVCPUS;
 
 		/*
@@ -1694,6 +1910,15 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		struct cpuset *parent = parent_cs(cp);
 		bool update_parent = false;
 
+		/*
+		 * Skip remote partition that acquires isolated CPUs directly
+		 * from cs_reserve_cpus.
+		 */
+		if (is_remote_partition(cp)) {
+			pos_css = css_rightmost_descendant(pos_css);
+			continue;
+		}
+
 		compute_effective_cpumask(tmp->new_cpus, cp, parent);
 
 		/*
@@ -1804,7 +2029,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		WARN_ON(!is_in_v2_mode() &&
 			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
 
-		update_tasks_cpumask(cp, tmp->new_cpus);
+		update_tasks_cpumask(cp, cp->effective_cpus);
 
 		/*
 		 * On legacy hierarchy, if the effective cpumask of any non-
@@ -1946,6 +2171,14 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		return retval;
 
 	if (cs->partition_root_state) {
+		/*
+		 * Call isolated_cpus_update() to handle valid remote partition
+		 */
+		if (is_remote_partition(cs)) {
+			isolated_cpus_update(cs, cs_tmp_cpus, &tmp);
+			goto update_hier;
+		}
+
 		if (invalidate)
 			update_parent_subparts_cpumask(cs, partcmd_invalidate,
 						       NULL, &tmp);
@@ -1980,10 +2213,11 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	}
 	spin_unlock_irq(&callback_lock);
 
+update_hier:
 	/* effective_cpus will be updated here */
 	update_cpumasks_hier(cs, &tmp, false);
 
-	if (cs->partition_root_state) {
+	if (cs->partition_root_state && !is_remote_partition(cs)) {
 		struct cpuset *parent = parent_cs(cs);
 
 		/*
@@ -2072,7 +2306,13 @@ static int update_reserve_cpumask(struct cpuset *trialcs, const char *buf)
 	 * Invalidate remote partitions if necessary
 	 */
 	if (deleting) {
-		/* TODO */
+		struct cpuset *child, *next;
+
+		list_for_each_entry_safe(child, next, &remote_children,
+					 remote_sibling) {
+			if (cpumask_intersects(child->cpus_allowed, tmp.delmask))
+				isolated_cpus_release(child);
+		}
 	}
 
 	/*
@@ -2539,21 +2779,32 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		return 0;
 
 	/*
-	 * For a previously invalid partition root, leave it at being
-	 * invalid if new_prs is not "member".
+	 * For a previously invalid partition root, treat it like a "member".
 	 */
-	if (new_prs && is_prs_invalid(old_prs)) {
-		cs->partition_root_state = -new_prs;
-		return 0;
-	}
+	if (new_prs && is_prs_invalid(old_prs))
+		old_prs = PRS_MEMBER;
 
 	if (alloc_cpumasks(NULL, &tmpmask))
 		return -ENOMEM;
 
+	if ((old_prs == PRS_ISOLATED) && is_remote_partition(cs)) {
+		/* Pre-invalidate a remote isolated partition */
+		isolated_cpus_release(cs);
+		old_prs = PRS_MEMBER;
+	}
+
 	err = update_partition_exclusive(cs, new_prs);
 	if (err)
 		goto out;
 
+	/*
+	 * New partition is not allowed under a remote partition
+	 */
+	if (new_prs && is_remote_partition(parent)) {
+		err = PERR_RMTPARENT;
+		goto out;
+	}
+
 	if (!old_prs) {
 		/*
 		 * cpus_allowed cannot be empty.
@@ -2565,6 +2816,12 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 
 		err = update_parent_subparts_cpumask(cs, partcmd_enable,
 						     NULL, &tmpmask);
+		/*
+		 * If an attempt to become adjacent isolated partition fails,
+		 * try to become a remote isolated partition instead.
+		 */
+		if (err && (new_prs == PRS_ISOLATED) && isolated_cpus_acquire(cs))
+			err = 0;	/* Become remote isolated partition */
 	} else if (old_prs && new_prs) {
 		/*
 		 * A change in load balance state only, no change in cpumasks.
@@ -3462,6 +3719,7 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 	nodes_clear(cs->effective_mems);
 	fmeter_init(&cs->fmeter);
 	cs->relax_domain_level = -1;
+	INIT_LIST_HEAD(&cs->remote_sibling);
 
 	/* Set CS_MEMORY_MIGRATE for default hierarchy */
 	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
@@ -3497,6 +3755,11 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		cs->effective_mems = parent->effective_mems;
 		cs->use_parent_ecpus = true;
 		parent->child_ecpus_count++;
+		/*
+		 * Clear CS_SCHED_LOAD_BALANCE if parent is isolated
+		 */
+		if (!is_sched_load_balance(parent))
+			clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 	}
 	spin_unlock_irq(&callback_lock);
 
@@ -3741,6 +4004,7 @@ int __init cpuset_init(void)
 	fmeter_init(&top_cpuset.fmeter);
 	set_bit(CS_SCHED_LOAD_BALANCE, &top_cpuset.flags);
 	top_cpuset.relax_domain_level = -1;
+	INIT_LIST_HEAD(&remote_children);
 
 	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
 
@@ -3873,9 +4137,20 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	}
 
 	parent = parent_cs(cs);
-	compute_effective_cpumask(&new_cpus, cs, parent);
 	nodes_and(new_mems, cs->mems_allowed, parent->effective_mems);
 
+	/*
+	 * In the special case of a valid remote isolated partition.
+	 * We just need to mask offline cpus from cpus_allowed unless
+	 * all the isolated cpus are gone.
+	 */
+	if (is_remote_partition(cs)) {
+		if (!cpumask_and(&new_cpus, cs->cpus_allowed, cpu_active_mask))
+			isolated_cpus_release(cs);
+	} else {
+		compute_effective_cpumask(&new_cpus, cs, parent);
+	}
+
 	if (cs->nr_subparts_cpus)
 		/*
 		 * Make sure that CPUs allocated to child partitions
@@ -3906,10 +4181,11 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 * the following conditions hold:
 	 * 1) empty effective cpus but not valid empty partition.
 	 * 2) parent is invalid or doesn't grant any cpus to child
-	 *    partitions.
+	 *    partitions and not a remote partition.
 	 */
-	if (is_partition_valid(cs) && (!parent->nr_subparts_cpus ||
-	   (cpumask_empty(&new_cpus) && partition_is_populated(cs, NULL)))) {
+	if (is_partition_valid(cs) &&
+	   ((!parent->nr_subparts_cpus && !is_remote_partition(cs)) ||
+	    (cpumask_empty(&new_cpus) && partition_is_populated(cs, NULL)))) {
 		int old_prs, parent_prs;
 
 		update_parent_subparts_cpumask(cs, partcmd_disable, NULL, tmp);
-- 
2.31.1

