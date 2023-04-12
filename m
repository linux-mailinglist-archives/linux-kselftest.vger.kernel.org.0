Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEA46DFA73
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 17:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjDLPju (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 11:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjDLPjf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 11:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E827DA2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681313915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3Ia8eT4hnnOIWaojmGp8NnLGFrNjWnkgyMnD5LjPnXA=;
        b=GNdf1cidhz6zqGMXKwtt0c718G7Pbbe88hZNybdNCgCSuxZ5C5UUF6PHHfcnlE0jV1wliA
        icHYCDz7djoiz5V8oxoMfGXWV6QseYqhjXPQDQDyMyHNQCo3Cio7FcSpbs3EMqF5zZ0uSJ
        dhkr+DxWrSyKGjqOaV7uyg115UKTyxA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-HvoODgaEMMq6YAE_ZANmfw-1; Wed, 12 Apr 2023 11:38:30 -0400
X-MC-Unique: HvoODgaEMMq6YAE_ZANmfw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2FFF100DEC2;
        Wed, 12 Apr 2023 15:38:29 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20D9240C6E70;
        Wed, 12 Apr 2023 15:38:29 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 3/5] cgroup/cpuset: Make isolated partition pull CPUs from isolcpus partition
Date:   Wed, 12 Apr 2023 11:37:56 -0400
Message-Id: <20230412153758.3088111-4-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With the addition of a new "isolcpus" partition in a previous patch,
this patch adds the capability for a privileged user to pull isolated
CPUs from the "isolcpus" partition to an "isolated" partition if its
parent cannot satisfy its request directly.

The following conditions must be true for the pulling of isolated CPUs
from "isolcpus" partition to be successful.

 (1) The value of "cpuset.cpus" must still be a subset of its parent's
     "cpuset.cpus" to ensure proper inheritance even though these CPUs
     cannot be used until the cpuset becomes an "isolated" partition.
 (2) All the CPUs in "cpuset.cpus" are freely available in the
     "isolcpus" partition, i.e. in its "cpuset.cpus.effective" and not
     yet claimed by other isolated partitions.

With this change, the CPUs in an "isolated" partition can either
come from the "isolcpus" partition or from its direct parent, but not
both. Now the parent of an isolated partition does not need to be a
partition root anymore.

Because of the cpu exclusive nature of an "isolated" partition, these
isolated CPUs cannot be distributed to other siblings of that isolated
partition.

Changes to "cpuset.cpus" of such an isolated partition is allowed as
long as all the newly requested CPUs can be granted from the "isolcpus"
partition. Otherwise, the partition will become invalid.

This makes the management and distribution of isolated CPUs to those
applications that require them much easier.

An "isolated" partition that pulls CPUs from the special "isolcpus"
partition can now have 2 parents - the "isolcpus" partition where
it gets its isolated CPUs and its hierarchical parent where it gets
all the other resources. However, such an "isolated" partition cannot
have subpartitions as all the CPUs from "isolcpus" must be in the same
isolated state.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 282 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 264 insertions(+), 18 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 444eae3a9a6b..a5bbd43ed46e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -101,6 +101,7 @@ enum prs_errcode {
 	PERR_ISOLCPUS,
 	PERR_ISOLTASK,
 	PERR_ISOLCHILD,
+	PERR_ISOPARENT,
 };
 
 static const char * const perr_strings[] = {
@@ -114,6 +115,7 @@ static const char * const perr_strings[] = {
 	[PERR_ISOLCPUS]  = "An isolcpus partition is already present",
 	[PERR_ISOLTASK]  = "Isolcpus partition can't have tasks",
 	[PERR_ISOLCHILD] = "Isolcpus partition can't have children",
+	[PERR_ISOPARENT] = "Isolated/isolcpus parent can't have subpartition",
 };
 
 struct cpuset {
@@ -1333,6 +1335,195 @@ static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
 		rebuild_sched_domains_locked();
 }
 
+/*
+ * isolcpus_pull - Enable or disable pulling of isolated cpus from isolcpus
+ * @cs: the cpuset to update
+ * @cmd: the command code (only partcmd_enable or partcmd_disable)
+ * Return: 1 if successful, 0 if error
+ *
+ * Note that pulling isolated cpus from isolcpus or cpus from parent does
+ * not require rebuilding sched domains. So we can change the flags directly.
+ */
+static int isolcpus_pull(struct cpuset *cs, enum subparts_cmd cmd)
+{
+	struct cpuset *parent = parent_cs(cs);
+
+	if (!isolcpus_cs)
+		return 0;
+
+	/*
+	 * To enable pulling of isolated CPUs from isolcpus, cpus_allowed
+	 * must be a subset of both its parent's cpus_allowed and isolcpus_cs's
+	 * effective_cpus and the user has sysadmin privilege.
+	 */
+	if ((cmd == partcmd_enable) && capable(CAP_SYS_ADMIN) &&
+	    cpumask_subset(cs->cpus_allowed, isolcpus_cs->effective_cpus) &&
+	    cpumask_subset(cs->cpus_allowed, parent->cpus_allowed)) {
+		/*
+		 * Move cpus from effective_cpus to subparts_cpus & make
+		 * cs a child of isolcpus partition.
+		 */
+		spin_lock_irq(&callback_lock);
+		cpumask_andnot(isolcpus_cs->effective_cpus,
+			       isolcpus_cs->effective_cpus, cs->cpus_allowed);
+		cpumask_or(isolcpus_cs->subparts_cpus,
+			   isolcpus_cs->subparts_cpus, cs->cpus_allowed);
+		cpumask_copy(cs->effective_cpus, cs->cpus_allowed);
+		isolcpus_cs->nr_subparts_cpus
+			= cpumask_weight(isolcpus_cs->subparts_cpus);
+
+		if (cs->use_parent_ecpus) {
+			cs->use_parent_ecpus = false;
+			parent->child_ecpus_count--;
+		}
+		list_add(&cs->isol_sibling, &isol_children);
+		clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
+		spin_unlock_irq(&callback_lock);
+		return 1;
+	}
+
+	if ((cmd == partcmd_disable) && !list_empty(&cs->isol_sibling)) {
+		/*
+		 * This can be called after isolcpus shrinks its cpu list.
+		 * So not all the cpus should be returned back to isolcpus.
+		 */
+		WARN_ON_ONCE(cs->partition_root_state != PRS_ISOLATED);
+		spin_lock_irq(&callback_lock);
+		cpumask_andnot(isolcpus_cs->subparts_cpus,
+			       isolcpus_cs->subparts_cpus, cs->cpus_allowed);
+		cpumask_or(isolcpus_cs->effective_cpus,
+			   isolcpus_cs->effective_cpus, cs->effective_cpus);
+		cpumask_and(isolcpus_cs->effective_cpus,
+			    isolcpus_cs->effective_cpus,
+			    isolcpus_cs->cpus_allowed);
+		cpumask_and(isolcpus_cs->effective_cpus,
+			    isolcpus_cs->effective_cpus, cpu_active_mask);
+		isolcpus_cs->nr_subparts_cpus
+			= cpumask_weight(isolcpus_cs->subparts_cpus);
+
+		if (!cpumask_and(cs->effective_cpus, parent->effective_cpus,
+						     cs->cpus_allowed)) {
+			cs->use_parent_ecpus = true;
+			parent->child_ecpus_count++;
+			cpumask_copy(cs->effective_cpus,
+				     parent->effective_cpus);
+		}
+		list_del_init(&cs->isol_sibling);
+		cs->partition_root_state = PRS_INVALID_ISOLATED;
+		cs->prs_err = PERR_INVCPUS;
+
+		set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
+		clear_bit(CS_CPU_EXCLUSIVE, &cs->flags);
+		spin_unlock_irq(&callback_lock);
+		return 1;
+	}
+	return 0;
+}
+
+static void isolcpus_disable(void)
+{
+	struct cpuset *child, *next;
+
+	list_for_each_entry_safe(child, next, &isol_children, isol_sibling)
+		WARN_ON_ONCE(isolcpus_pull(child, partcmd_disable));
+
+	isolcpus_cs = NULL;
+}
+
+/*
+ * isolcpus_cpus_update - cpuset.cpus change in isolcpus partition
+ */
+static void isolcpus_cpus_update(struct cpuset *cs)
+{
+	struct cpuset *child, *next;
+
+	if (WARN_ON_ONCE(isolcpus_cs != cs))
+		return;
+
+	if (list_empty(&isol_children))
+		return;
+
+	/*
+	 * Remove child isolated partitions that are not fully covered by
+	 * subparts_cpus.
+	 */
+	list_for_each_entry_safe(child, next, &isol_children,
+				 isol_sibling) {
+		if (cpumask_subset(child->cpus_allowed,
+				   cs->subparts_cpus))
+			continue;
+
+		isolcpus_pull(child, partcmd_disable);
+	}
+}
+
+/*
+ * isolated_cpus_update - cpuset.cpus change in isolated partition
+ *
+ * Return: 1 if no further action needs, 0 otherwise
+ */
+static int isolated_cpus_update(struct cpuset *cs, struct cpumask *newmask,
+				struct tmpmasks *tmp)
+{
+	struct cpumask *addmask = tmp->addmask;
+	struct cpumask *delmask = tmp->delmask;
+
+	if (WARN_ON_ONCE(cs->partition_root_state != PRS_ISOLATED) ||
+	    list_empty(&cs->isol_sibling))
+		return 0;
+
+	if (WARN_ON_ONCE(!isolcpus_cs) || cpumask_empty(newmask)) {
+		isolcpus_pull(cs, partcmd_disable);
+		return 0;
+	}
+
+	if (cpumask_andnot(addmask, newmask, cs->cpus_allowed)) {
+		/*
+		 * Check if isolcpus partition can provide the new CPUs
+		 */
+		if (!cpumask_subset(addmask, isolcpus_cs->cpus_allowed) ||
+		     cpumask_intersects(addmask, isolcpus_cs->subparts_cpus)) {
+			isolcpus_pull(cs, partcmd_disable);
+			return 0;
+		}
+
+		/*
+		 * Pull addmask isolated CPUs from isolcpus partition
+		 */
+		spin_lock_irq(&callback_lock);
+		cpumask_andnot(isolcpus_cs->subparts_cpus,
+			       isolcpus_cs->subparts_cpus, addmask);
+		cpumask_andnot(isolcpus_cs->effective_cpus,
+			       isolcpus_cs->effective_cpus, addmask);
+		isolcpus_cs->nr_subparts_cpus
+			= cpumask_weight(isolcpus_cs->subparts_cpus);
+		spin_unlock_irq(&callback_lock);
+	}
+
+	if (cpumask_andnot(tmp->delmask, cs->cpus_allowed, newmask)) {
+		/*
+		 * Return isolated CPUs back to isolcpus partition
+		 */
+		spin_lock_irq(&callback_lock);
+		cpumask_or(isolcpus_cs->subparts_cpus,
+			   isolcpus_cs->subparts_cpus, delmask);
+		cpumask_or(isolcpus_cs->effective_cpus,
+			   isolcpus_cs->effective_cpus, delmask);
+		cpumask_and(isolcpus_cs->effective_cpus,
+			    isolcpus_cs->effective_cpus, cpu_active_mask);
+		isolcpus_cs->nr_subparts_cpus
+			= cpumask_weight(isolcpus_cs->subparts_cpus);
+		spin_unlock_irq(&callback_lock);
+	}
+
+	spin_lock_irq(&callback_lock);
+	cpumask_copy(cs->cpus_allowed, newmask);
+	cpumask_andnot(cs->effective_cpus, newmask, cs->subparts_cpus);
+	cpumask_and(cs->effective_cpus, cs->effective_cpus, cpu_active_mask);
+	spin_unlock_irq(&callback_lock);
+	return 1;
+}
+
 /**
  * update_parent_subparts_cpumask - update subparts_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -1579,7 +1770,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	spin_unlock_irq(&callback_lock);
 
 	if ((isolcpus_cs == cs) && (cs->partition_root_state != PRS_ISOLCPUS))
-		isolcpus_cs = NULL;
+		isolcpus_disable();
 
 	if (adding || deleting)
 		update_tasks_cpumask(parent, tmp->addmask);
@@ -1625,6 +1816,12 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		struct cpuset *parent = parent_cs(cp);
 		bool update_parent = false;
 
+		/*
+		 * Skip isolated cpuset that pull isolated CPUs from isolcpus
+		 */
+		if (!list_empty(&cp->isol_sibling))
+			continue;
+
 		compute_effective_cpumask(tmp->new_cpus, cp, parent);
 
 		/*
@@ -1742,7 +1939,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		WARN_ON(!is_in_v2_mode() &&
 			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
 
-		update_tasks_cpumask(cp, tmp->new_cpus);
+		update_tasks_cpumask(cp, cp->effective_cpus);
 
 		/*
 		 * On legacy hierarchy, if the effective cpumask of any non-
@@ -1888,6 +2085,10 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		return retval;
 
 	if (cs->partition_root_state) {
+		if (!list_empty(&cs->isol_sibling) &&
+		    isolated_cpus_update(cs, trialcs->cpus_allowed, &tmp))
+			goto update_hier;	/* CPUs update done */
+
 		if (invalidate)
 			update_parent_subparts_cpumask(cs, partcmd_invalidate,
 						       NULL, &tmp);
@@ -1920,6 +2121,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	}
 	spin_unlock_irq(&callback_lock);
 
+update_hier:
 #ifdef CONFIG_CPUMASK_OFFSTACK
 	/* Now trialcs->cpus_allowed is available */
 	tmp.new_cpus = trialcs->cpus_allowed;
@@ -1928,8 +2130,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	/* effective_cpus will be updated here */
 	update_cpumasks_hier(cs, &tmp, false);
 
-	if (cs->partition_root_state) {
-		bool force = (cs->partition_root_state == PRS_ISOLCPUS);
+	if (cs->partition_root_state && list_empty(&cs->isol_sibling)) {
 		struct cpuset *parent = parent_cs(cs);
 
 		/*
@@ -1937,8 +2138,12 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		 * cpusets if they use parent's effective_cpus or when
 		 * the current cpuset is an isolcpus partition.
 		 */
-		if (parent->child_ecpus_count || force)
-			update_sibling_cpumasks(parent, cs, &tmp, force);
+		if (cs->partition_root_state == PRS_ISOLCPUS) {
+			update_sibling_cpumasks(parent, cs, &tmp, true);
+			isolcpus_cpus_update(cs);
+		} else if (parent->child_ecpus_count) {
+			update_sibling_cpumasks(parent, cs, &tmp, false);
+		}
 
 		/* Update CS_SCHED_LOAD_BALANCE and/or sched_domains */
 		update_partition_sd_lb(cs, old_prs);
@@ -2307,7 +2512,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	return err;
 }
 
-/**
+/*
  * update_prstate - update partition_root_state
  * @cs: the cpuset to update
  * @new_prs: new partition root state
@@ -2325,13 +2530,10 @@ static int update_prstate(struct cpuset *cs, int new_prs)
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
@@ -2371,6 +2573,21 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		}
 	}
 
+	/*
+	 * A parent isolated partition that gets its isolated CPUs from
+	 * isolcpus cannot have subpartition.
+	 */
+	if (new_prs && !list_empty(&parent->isol_sibling)) {
+		err = PERR_ISOPARENT;
+		goto out;
+	}
+
+	if ((old_prs == PRS_ISOLATED) && !list_empty(&cs->isol_sibling)) {
+		isolcpus_pull(cs, partcmd_disable);
+		old_prs = 0;
+	}
+	WARN_ON_ONCE(!list_empty(&cs->isol_sibling));
+
 	err = update_partition_exclusive(cs, new_prs);
 	if (err)
 		goto out;
@@ -2386,6 +2603,10 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 
 		err = update_parent_subparts_cpumask(cs, partcmd_enable,
 						     NULL, &tmpmask);
+		if (err && (new_prs == PRS_ISOLATED) &&
+		    isolcpus_pull(cs, partcmd_enable))
+			err = 0;	/* Successful isolcpus pull */
+
 		if (err)
 			goto out;
 	} else if (old_prs && new_prs) {
@@ -2445,7 +2666,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (new_prs == PRS_ISOLCPUS)
 		isolcpus_cs = cs;
 	else if (cs == isolcpus_cs)
-		isolcpus_cs = NULL;
+		isolcpus_disable();
 
 	/*
 	 * Update child cpusets, if present.
@@ -3674,8 +3895,31 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	}
 
 	parent = parent_cs(cs);
-	compute_effective_cpumask(&new_cpus, cs, parent);
 	nodes_and(new_mems, cs->mems_allowed, parent->effective_mems);
+	/*
+	 * In the special case of a valid isolated cpuset pulling isolated
+	 * cpus from isolcpus. We just need to mask offline cpus from
+	 * cpus_allowed unless all the isolated cpus are gone.
+	 */
+	if (!list_empty(&cs->isol_sibling)) {
+		if (!cpumask_and(&new_cpus, cs->cpus_allowed, cpu_active_mask))
+			isolcpus_pull(cs, partcmd_disable);
+	} else if ((cs->partition_root_state == PRS_ISOLCPUS) &&
+		    cpumask_empty(cs->cpus_allowed)) {
+		/*
+		 * For isolcpus with empty cpus_allowed, just update
+		 * effective_mems and be done with it.
+		 */
+		spin_lock_irq(&callback_lock);
+		if (nodes_empty(new_mems))
+			cs->effective_mems = parent->effective_mems;
+		else
+			cs->effective_mems = new_mems;
+		spin_unlock_irq(&callback_lock);
+		goto unlock;
+	} else {
+		compute_effective_cpumask(&new_cpus, cs, parent);
+	}
 
 	if (cs->nr_subparts_cpus)
 		/*
@@ -3707,10 +3951,12 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 * the following conditions hold:
 	 * 1) empty effective cpus but not valid empty partition.
 	 * 2) parent is invalid or doesn't grant any cpus to child
-	 *    partitions.
+	 *    partitions and not an isolated cpuset pulling cpus from
+	 *    isolcpus.
 	 */
-	if (is_partition_valid(cs) && (!parent->nr_subparts_cpus ||
-	   (cpumask_empty(&new_cpus) && partition_is_populated(cs, NULL)))) {
+	if (is_partition_valid(cs) &&
+	   ((!parent->nr_subparts_cpus && list_empty(&cs->isol_sibling)) ||
+	    (cpumask_empty(&new_cpus) && partition_is_populated(cs, NULL)))) {
 		int old_prs, parent_prs;
 
 		update_parent_subparts_cpumask(cs, partcmd_disable, NULL, tmp);
-- 
2.31.1

