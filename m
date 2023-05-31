Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB8718795
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 18:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjEaQgs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 12:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjEaQgY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 12:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA958E67
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 09:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685550864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MunOFJWMe7tgW+XM6Of/HoGxuH83AnN8mCmfMnOlUl8=;
        b=KBaAfdqCS5RwPEyeqcY1RMsORNHzZsGPqIsrS///+NUpmI0mkms1YOAWOACbpg1A8LcGEy
        cPNeoQxlcAZe/7yBPvGYBEGiNu8Zma4RaJVqNVRLY6vO6hpNPY+nuhbeGdT0PcoggJOAIa
        3LXfkil+K8tSkojpfAZznN2SKSL2APo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-hyO3eOWBMMSUW9Ab4Zwq2A-1; Wed, 31 May 2023 12:34:13 -0400
X-MC-Unique: hyO3eOWBMMSUW9Ab4Zwq2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 388F1381D1ED;
        Wed, 31 May 2023 16:34:13 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD43D2166B25;
        Wed, 31 May 2023 16:34:12 +0000 (UTC)
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
Subject: [PATCH v2 3/6] cgroup/cpuset: Add cpuset.cpus.reserve for top cpuset
Date:   Wed, 31 May 2023 12:34:02 -0400
Message-Id: <20230531163405.2200292-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

A cpuset partition is a collection of cpusets with a partition root
and its descendants from that root downward excluding any cpusets that
are part of other partitions. A partition has exclusive access to a set
of CPUs granted to it. Other cpusets outside of a partition cannot use
any CPUs in that set.

Currently, creation of partitions requires a hierarchical CPUs
distribution model where the parent of a partition root has to be
a partition root itself. Hence all the partition roots have to be
clustered around the cgroup root.

To enable the creation of a remote partition down in the hierarchy
without a parental partition root, we need a way to reserve the CPUs
that will be used in a remote partition. Introduce a new root-only
"cpuset.cpus.reserve" control file in the top cpuset for this particular
purpose.

By default, the new "cpuset.cpus.reserve" control file will track
the subparts_cpus cpumask in the top cpuset. By writing into this new
control file, however, we can reserve additional CPUs that can be used
in a remote partition. Any CPUs that are in "cpuset.cpus.reserve" will
have to be removed from the effective_cpus of all the cpusets that are
not part of that valid partitions.

The prefix "+" and "-" can be used to indicate the addition to or the
subtraction from the existing CPUs in "cpuset.cpus.reserve".  A single
"-" character indicate the deletion of all the free reserve CPUs not
allocated to any existing partition.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 253 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 239 insertions(+), 14 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 8604c919e1e4..69abe95a9969 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -208,7 +208,33 @@ struct cpuset {
 	struct cgroup_file partition_file;
 };
 
-static cpumask_var_t	cs_tmp_cpus;	/* Temp cpumask for partition */
+/*
+ * Reserved CPUs for partitions.
+ *
+ * By default, CPUs used in partitions are tracked in the parent's
+ * subparts_cpus mask following a hierarchical CPUs distribution model.
+ * To enable the creation of a remote partition down in the hierarchy
+ * without a parental partition root, one can write directly to
+ * cpuset.cpus.reserve in the root cgroup to allocate more CPUs that can
+ * be used by remote partitions. Removal of existing reserved CPUs may
+ * also cause some existing partitions to become invalid.
+ *
+ * All the cpumasks below should only be used with cpuset_mutex held.
+ * Modification of cs_reserve_cpus & cs_free_reserve_cpus also requires
+ * holding the callback_lock.
+ *
+ * Relationship among cs_reserve_cpus, cs_free_reserve_cpus and
+ * top_cpuset.subparts_cpus are:
+ *
+ *   top_cpuset.subparts_cpus ⊆ cs_reserve_cpus
+ *   cs_free_reserve_cpus     ⊆ cs_reserve_cpus
+ *   top_cpuset.subparts_cpus ∩ cs_free_reserve_cpus = ∅
+ *   cs_reserve_cpus - cs_free_reserve_cpus - top_cpuset.subparts_cpus
+ *	= CPUs dedicated to remote partitions
+ */
+static cpumask_var_t	cs_reserve_cpus;	/* Reserved CPUs */
+static cpumask_var_t	cs_free_reserve_cpus;	/* Unallocated reserved CPUs */
+static cpumask_var_t	cs_tmp_cpus;		/* Temp cpumask for partition */
 
 /*
  * Partition root states:
@@ -1202,13 +1228,13 @@ static void rebuild_sched_domains_locked(void)
 	 * should be the same as the active CPUs, so checking only top_cpuset
 	 * is enough to detect racing CPU offlines.
 	 */
-	if (!top_cpuset.nr_subparts_cpus &&
+	if (cpumask_empty(cs_reserve_cpus) &&
 	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
 		return;
 
 	/*
 	 * With subpartition CPUs, however, the effective CPUs of a partition
-	 * root should be only a subset of the active CPUs.  Since a CPU in any
+	 * root should only be a subset of the active CPUs.  Since a CPU in any
 	 * partition root could be offlined, all must be checked.
 	 */
 	if (top_cpuset.nr_subparts_cpus) {
@@ -1275,7 +1301,7 @@ static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 			 */
 			if ((task->flags & PF_KTHREAD) && kthread_is_per_cpu(task))
 				continue;
-			cpumask_andnot(new_cpus, possible_mask, cs->subparts_cpus);
+			cpumask_andnot(new_cpus, possible_mask, cs_reserve_cpus);
 		} else {
 			cpumask_and(new_cpus, possible_mask, cs->effective_cpus);
 		}
@@ -1406,6 +1432,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	int deleting;	/* Moving cpus from subparts_cpus to effective_cpus */
 	int old_prs, new_prs;
 	int part_error = PERR_NONE;	/* Partition error? */
+	bool update_reserve = (parent == &top_cpuset);
 
 	lockdep_assert_held(&cpuset_mutex);
 
@@ -1576,7 +1603,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	}
 
 	/*
-	 * Change the parent's subparts_cpus.
+	 * Change the parent's subparts_cpus and maybe cs_reserve_cpus.
 	 * Newly added CPUs will be removed from effective_cpus and
 	 * newly deleted ones will be added back to effective_cpus.
 	 */
@@ -1586,10 +1613,25 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 			   parent->subparts_cpus, tmp->addmask);
 		cpumask_andnot(parent->effective_cpus,
 			       parent->effective_cpus, tmp->addmask);
+		if (update_reserve) {
+			cpumask_or(cs_reserve_cpus,
+				   cs_reserve_cpus, tmp->addmask);
+			cpumask_andnot(cs_free_reserve_cpus,
+				       cs_free_reserve_cpus, tmp->addmask);
+		}
 	}
 	if (deleting) {
 		cpumask_andnot(parent->subparts_cpus,
 			       parent->subparts_cpus, tmp->delmask);
+		/*
+		 * The automatic cpu reservation of adjacent partition
+		 * won't add back the deleted CPUs to cs_free_reserve_cpus.
+		 * Instead, they are returned back to effective_cpus of top
+		 * cpuset.
+		 */
+		if (update_reserve)
+			cpumask_andnot(cs_reserve_cpus,
+				       cs_reserve_cpus, tmp->delmask);
 		/*
 		 * Some of the CPUs in subparts_cpus might have been offlined.
 		 */
@@ -1783,6 +1825,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 
 	if (need_rebuild_sched_domains)
 		rebuild_sched_domains_locked();
+
+	return;
 }
 
 /**
@@ -1955,6 +1999,167 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	return 0;
 }
 
+/**
+ * update_reserve_cpumask - update cs_reserve_cpus
+ * @trialcs: trial cpuset
+ * @buf: buffer of cpu numbers written to this cpuset
+ * Return: 0 if successful, < 0 if error
+ */
+static int update_reserve_cpumask(struct cpuset *trialcs, const char *buf)
+{
+	struct cgroup_subsys_state *css;
+	struct cpuset *cs;
+	bool adding, deleting;
+	struct tmpmasks tmp;
+
+	adding = deleting = false;
+	if (*buf == '+') {
+		adding = true;
+		buf++;
+	} else if (*buf == '-') {
+		deleting = true;
+		buf++;
+	}
+
+	if (!*buf) {
+		if (adding)
+			return -EINVAL;
+
+		if (deleting) {
+			if (cpumask_empty(cs_free_reserve_cpus))
+				return 0;
+			cpumask_copy(trialcs->cpus_allowed, cs_free_reserve_cpus);
+		} else {
+			cpumask_clear(trialcs->cpus_allowed);
+		}
+	} else {
+		int retval = cpulist_parse(buf, trialcs->cpus_allowed);
+
+		if (retval < 0)
+			return retval;
+	}
+
+	if (!adding && !deleting &&
+	    cpumask_equal(trialcs->cpus_allowed, cs_reserve_cpus))
+		return 0;
+
+	/* Preserve trialcs->cpus_allowed for now */
+	init_tmpmasks(&tmp, NULL, trialcs->subparts_cpus,
+		      trialcs->effective_cpus);
+
+	/*
+	 * Compute the addition and removal of CPUs to/from cs_reserve_cpus
+	 */
+	if (!adding && !deleting) {
+		adding = cpumask_andnot(tmp.addmask, trialcs->cpus_allowed,
+					cs_reserve_cpus);
+		deleting = cpumask_andnot(tmp.delmask, cs_reserve_cpus,
+					  trialcs->cpus_allowed);
+	} else if (adding) {
+		adding = cpumask_andnot(tmp.addmask,
+					trialcs->cpus_allowed, cs_reserve_cpus);
+		cpumask_or(trialcs->cpus_allowed, cs_reserve_cpus, tmp.addmask);
+	} else {	/* deleting */
+		deleting = cpumask_and(tmp.delmask,
+				       trialcs->cpus_allowed, cs_reserve_cpus);
+		cpumask_andnot(trialcs->cpus_allowed, cs_reserve_cpus, tmp.delmask);
+	}
+
+	if (!adding && !deleting)
+		return 0;
+
+	/*
+	 * Invalidate remote partitions if necessary
+	 */
+	if (deleting) {
+		/* TODO */
+	}
+
+	/*
+	 * Cannot use up all the CPUs in top_cpuset.effective_cpus
+	 */
+	if (!deleting && adding &&
+	    cpumask_subset(top_cpuset.effective_cpus, tmp.addmask))
+		return -EINVAL;
+
+	spin_lock_irq(&callback_lock);
+	/*
+	 * Update top_cpuset.effective_cpus, cs_reserve_cpus &
+	 * cs_free_reserve_cpus.
+	 */
+	if (adding)
+		cpumask_or(cs_free_reserve_cpus, cs_free_reserve_cpus,
+			   tmp.addmask);
+	cpumask_copy(cs_reserve_cpus, trialcs->cpus_allowed);
+	cpumask_andnot(top_cpuset.effective_cpus,
+		       cpu_active_mask, cs_reserve_cpus);
+
+	/*
+	 * Remove CPUs from cs_free_reserve_cpus first. Anything left
+	 * means some partitions has to be made invalid.
+	 */
+	if (deleting & cpumask_and(cs_tmp_cpus, cs_free_reserve_cpus,
+				   tmp.delmask)) {
+		cpumask_andnot(cs_free_reserve_cpus, cs_free_reserve_cpus,
+			       cs_tmp_cpus);
+		deleting = cpumask_andnot(tmp.delmask, tmp.delmask,
+					  cs_tmp_cpus);
+	}
+	spin_unlock_irq(&callback_lock);
+
+	/*
+	 * Invalidate some adjacent partitions under top cpuset, if necessary
+	 */
+	if (deleting && cpumask_and(cs_tmp_cpus, tmp.delmask,
+				    top_cpuset.subparts_cpus)) {
+		struct cgroup_subsys_state *css;
+		struct cpuset *cp;
+
+		/*
+		 * Temporarily save the remaining CPUs to be deleted in
+		 * trialcs->cpus_allowed to be restored back to tmp.delmask
+		 * later.
+		 */
+		deleting = cpumask_andnot(trialcs->cpus_allowed, tmp.delmask,
+					  cs_tmp_cpus);
+		rcu_read_lock();
+		cpuset_for_each_child(cp, css, &top_cpuset)
+			if (is_partition_valid(cp) &&
+			    cpumask_intersects(cs_tmp_cpus, cp->cpus_allowed)) {
+				rcu_read_unlock();
+				update_parent_subparts_cpumask(cp, partcmd_invalidate, NULL, &tmp);
+				rcu_read_lock();
+			}
+		rcu_read_unlock();
+		if (deleting)
+			cpumask_copy(tmp.delmask, trialcs->cpus_allowed);
+	}
+
+	/* Can now use all of trialcs */
+	init_tmpmasks(&tmp, trialcs->cpus_allowed, trialcs->subparts_cpus,
+		      trialcs->effective_cpus);
+
+	/*
+	 * Update effective_cpus of all descendants that are not in
+	 * partitions and rebuild sched domaiins.
+	 */
+	rcu_read_lock();
+	cpuset_for_each_child(cs, css, &top_cpuset) {
+		compute_effective_cpumask(tmp.new_cpus, cs, &top_cpuset);
+		if (cpumask_equal(tmp.new_cpus, cs->effective_cpus))
+			continue;
+		if (!css_tryget_online(&cs->css))
+			continue;
+		rcu_read_unlock();
+		update_cpumasks_hier(cs, &tmp, false);
+		rcu_read_lock();
+		css_put(&cs->css);
+	}
+	rcu_read_unlock();
+	rebuild_sched_domains_locked();
+	return 0;
+}
+
 /*
  * Migrate memory region from one set of nodes to another.  This is
  * performed asynchronously as it can be called from process migration path
@@ -2743,6 +2948,7 @@ typedef enum {
 	FILE_EFFECTIVE_CPULIST,
 	FILE_EFFECTIVE_MEMLIST,
 	FILE_SUBPARTS_CPULIST,
+	FILE_RESERVE_CPULIST,
 	FILE_CPU_EXCLUSIVE,
 	FILE_MEM_EXCLUSIVE,
 	FILE_MEM_HARDWALL,
@@ -2880,6 +3086,9 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	case FILE_CPULIST:
 		retval = update_cpumask(cs, trialcs, buf);
 		break;
+	case FILE_RESERVE_CPULIST:
+		retval = update_reserve_cpumask(trialcs, buf);
+		break;
 	case FILE_MEMLIST:
 		retval = update_nodemask(cs, trialcs, buf);
 		break;
@@ -2927,6 +3136,9 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	case FILE_EFFECTIVE_MEMLIST:
 		seq_printf(sf, "%*pbl\n", nodemask_pr_args(&cs->effective_mems));
 		break;
+	case FILE_RESERVE_CPULIST:
+		seq_printf(sf, "%*pbl\n", cpumask_pr_args(cs_reserve_cpus));
+		break;
 	case FILE_SUBPARTS_CPULIST:
 		seq_printf(sf, "%*pbl\n", cpumask_pr_args(cs->subparts_cpus));
 		break;
@@ -3200,6 +3412,14 @@ static struct cftype dfl_files[] = {
 		.file_offset = offsetof(struct cpuset, partition_file),
 	},
 
+	{
+		.name = "cpus.reserve",
+		.seq_show = cpuset_common_seq_show,
+		.write = cpuset_write_resmask,
+		.private = FILE_RESERVE_CPULIST,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+	},
+
 	{
 		.name = "cpus.subpartitions",
 		.seq_show = cpuset_common_seq_show,
@@ -3510,6 +3730,8 @@ int __init cpuset_init(void)
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&top_cpuset.subparts_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&cs_tmp_cpus, GFP_KERNEL));
+	BUG_ON(!zalloc_cpumask_var(&cs_reserve_cpus, GFP_KERNEL));
+	BUG_ON(!zalloc_cpumask_var(&cs_free_reserve_cpus, GFP_KERNEL));
 
 	cpumask_setall(top_cpuset.cpus_allowed);
 	nodes_setall(top_cpuset.mems_allowed);
@@ -3788,10 +4010,10 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	mems_updated = !nodes_equal(top_cpuset.effective_mems, new_mems);
 
 	/*
-	 * In the rare case that hotplug removes all the cpus in subparts_cpus,
+	 * In the rare case that hotplug removes all the reserve cpus,
 	 * we assumed that cpus are updated.
 	 */
-	if (!cpus_updated && top_cpuset.nr_subparts_cpus)
+	if (!cpus_updated && !cpumask_empty(cs_reserve_cpus))
 		cpus_updated = true;
 
 	/* synchronize cpus_allowed to cpu_active_mask */
@@ -3801,18 +4023,21 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 			cpumask_copy(top_cpuset.cpus_allowed, &new_cpus);
 		/*
 		 * Make sure that CPUs allocated to child partitions
-		 * do not show up in effective_cpus. If no CPU is left,
-		 * we clear the subparts_cpus & let the child partitions
-		 * fight for the CPUs again.
+		 * do not show up in top_cpuset's effective_cpus. In the
+		 * unlikely event tht no effective CPU is left in top_cpuset,
+		 * we clear all the reserve cpus and let the non-remote child
+		 * partitions fight for the CPUs again.
 		 */
-		if (top_cpuset.nr_subparts_cpus) {
-			if (cpumask_subset(&new_cpus,
-					   top_cpuset.subparts_cpus)) {
+		if (!cpumask_empty(cs_reserve_cpus)) {
+
+			if (cpumask_subset(&new_cpus, cs_reserve_cpus)) {
 				top_cpuset.nr_subparts_cpus = 0;
 				cpumask_clear(top_cpuset.subparts_cpus);
+				cpumask_clear(cs_free_reserve_cpus);
+				cpumask_clear(cs_reserve_cpus);
 			} else {
 				cpumask_andnot(&new_cpus, &new_cpus,
-					       top_cpuset.subparts_cpus);
+					       cs_reserve_cpus);
 			}
 		}
 		cpumask_copy(top_cpuset.effective_cpus, &new_cpus);
-- 
2.31.1

