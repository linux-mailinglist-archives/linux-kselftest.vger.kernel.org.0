Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2056DFA61
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 17:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjDLPj1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 11:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjDLPj0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 11:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7C9E5A
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681313911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Usy+tTMXVgyLNSQ+gvGQG+KVUDCWEo3fDi/oBZlnoOo=;
        b=D/Qgy/cdmAI9TvdWBFjBugHxI6S0syJ8YiAg8FSUy42k814UOCK5VAHWAOysK2+KoD42rv
        tl/XGiJ9dHloWZj/S6f6O1ro4FiYYU+AyBEvh+Xe/7EdLHHH4VCt+XKm9hzDptWhKZmnCz
        8HaYYvuzsOtyZeNQaJ3ApT3BoLTee7c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-h39wjL-qPGi-kCoZX6R5GQ-1; Wed, 12 Apr 2023 11:38:29 -0400
X-MC-Unique: h39wjL-qPGi-kCoZX6R5GQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13559100F7E1;
        Wed, 12 Apr 2023 15:38:29 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8289640C6E20;
        Wed, 12 Apr 2023 15:38:28 +0000 (UTC)
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
Subject: [RFC PATCH 2/5] cgroup/cpuset: Add a new "isolcpus" paritition root state
Date:   Wed, 12 Apr 2023 11:37:55 -0400
Message-Id: <20230412153758.3088111-3-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
be hard to manage.

This patch introduces a new special partition root state called
"isolcpus" that serves as a pool of isolated CPUs to be pulled into other
"isolated" partitions. At most one instance of the "isolcpus" partition
is allowed in a system preferrably as a child of the top cpuset.

In a valid "isolcpus" partition, "cpuset.cpus" contains the set of
isolated CPUs and "cpuset.cpus.effective" contains the set of freely
available isolated CPUs that have not yet been pulled into other
"isolated" cpusets.

The special "isolcpus" partition cannot have normal cpuset children. So
we are not allowed to enable child cpuset in its "cgroup.subtree_control"
file if it has children. Tasks are also not allowed in the "cgroup.procs"
of the "isolcpus" partition. Unlike other partition roots, empty
"cpuset.cpus" is allowed in the "isolcpus" partition as this special
cpuset is not designed to hold tasks.

The CPUs in the "isolcpus" partition are not exclusive so that those
isolated CPUs can be distributed down sibling hierarchies as usual even
though they will not show up in their "cpuset.cpus.effective".

Right now, an "isolcpus" partition only disable load balancing of
the isolated CPUs. In the near future, it may be extended to support
additional isolation attributes like those currently supported by the
"isolcpus" or related kernel boot command line options.

In a subsequent patch, a privileged user can change a "member" cpuset
to an "isolated" partition root by pulling isolated CPUs from the
"isolcpus" partition if its parent is not a partition root that can
directly satisfy the request.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 158 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 133 insertions(+), 25 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 83a7193e0f2c..444eae3a9a6b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -98,6 +98,9 @@ enum prs_errcode {
 	PERR_NOCPUS,
 	PERR_HOTPLUG,
 	PERR_CPUSEMPTY,
+	PERR_ISOLCPUS,
+	PERR_ISOLTASK,
+	PERR_ISOLCHILD,
 };
 
 static const char * const perr_strings[] = {
@@ -108,6 +111,9 @@ static const char * const perr_strings[] = {
 	[PERR_NOCPUS]    = "Parent unable to distribute cpu downstream",
 	[PERR_HOTPLUG]   = "No cpu available due to hotplug",
 	[PERR_CPUSEMPTY] = "cpuset.cpus is empty",
+	[PERR_ISOLCPUS]  = "An isolcpus partition is already present",
+	[PERR_ISOLTASK]  = "Isolcpus partition can't have tasks",
+	[PERR_ISOLCHILD] = "Isolcpus partition can't have children",
 };
 
 struct cpuset {
@@ -198,6 +204,9 @@ struct cpuset {
 
 	/* Handle for cpuset.cpus.partition */
 	struct cgroup_file partition_file;
+
+	/* siblings list anchored at isol_children */
+	struct list_head isol_sibling;
 };
 
 /*
@@ -206,14 +215,26 @@ struct cpuset {
  *   0 - member (not a partition root)
  *   1 - partition root
  *   2 - partition root without load balancing (isolated)
+ *   3 - isolated cpu pool (isolcpus)
  *  -1 - invalid partition root
  *  -2 - invalid isolated partition root
+ *  -3 - invalid isolated cpu pool
+ *
+ * An isolated cpu pool is a special isolated partition root. At most one
+ * instance of it is allowed in a system. It provides a pool of isolated
+ * cpus that a normal isolated partition root can pull from, if privileged,
+ * in case its parent cannot fulfill its request.
  */
 #define PRS_MEMBER		0
 #define PRS_ROOT		1
 #define PRS_ISOLATED		2
+#define PRS_ISOLCPUS		3
 #define PRS_INVALID_ROOT	-1
 #define PRS_INVALID_ISOLATED	-2
+#define PRS_INVALID_ISOLCPUS	-3
+
+static struct cpuset *isolcpus_cs;	/* System isolcpus partition root */
+static struct list_head isol_children;	/* Children that pull isolated cpus */
 
 static inline bool is_prs_invalid(int prs_state)
 {
@@ -335,6 +356,7 @@ static struct cpuset top_cpuset = {
 	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
 		  (1 << CS_MEM_EXCLUSIVE)),
 	.partition_root_state = PRS_ROOT,
+	.isol_sibling = LIST_HEAD_INIT(top_cpuset.isol_sibling),
 };
 
 /**
@@ -1282,7 +1304,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
  */
 static int update_partition_exclusive(struct cpuset *cs, int new_prs)
 {
-	bool exclusive = (new_prs > 0);
+	bool exclusive = (new_prs == PRS_ROOT) || (new_prs == PRS_ISOLATED);
 
 	if (exclusive && !is_cpu_exclusive(cs)) {
 		if (update_flag(CS_CPU_EXCLUSIVE, cs, 1))
@@ -1303,7 +1325,7 @@ static int update_partition_exclusive(struct cpuset *cs, int new_prs)
 static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
 {
 	int new_prs = cs->partition_root_state;
-	bool new_lb = (new_prs != PRS_ISOLATED);
+	bool new_lb = (new_prs != PRS_ISOLATED) && (new_prs != PRS_ISOLCPUS);
 
 	if (new_lb != !!is_sched_load_balance(cs))
 		update_flag(CS_SCHED_LOAD_BALANCE, cs, new_lb);
@@ -1360,18 +1382,20 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	int part_error = PERR_NONE;	/* Partition error? */
 
 	percpu_rwsem_assert_held(&cpuset_rwsem);
+	old_prs = new_prs = cs->partition_root_state;
 
 	/*
 	 * The parent must be a partition root.
 	 * The new cpumask, if present, or the current cpus_allowed must
-	 * not be empty.
+	 * not be empty except for isolcpus partition.
 	 */
 	if (!is_partition_valid(parent)) {
 		return is_partition_invalid(parent)
 		       ? PERR_INVPARENT : PERR_NOTPART;
 	}
-	if ((newmask && cpumask_empty(newmask)) ||
-	   (!newmask && cpumask_empty(cs->cpus_allowed)))
+	if ((new_prs != PRS_ISOLCPUS) &&
+	   ((newmask && cpumask_empty(newmask)) ||
+	    (!newmask && cpumask_empty(cs->cpus_allowed))))
 		return PERR_CPUSEMPTY;
 
 	/*
@@ -1379,7 +1403,6 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	 * partcmd_invalidate commands.
 	 */
 	adding = deleting = false;
-	old_prs = new_prs = cs->partition_root_state;
 	if (cmd == partcmd_enable) {
 		/*
 		 * Enabling partition root is not allowed if cpus_allowed
@@ -1498,11 +1521,13 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		switch (cs->partition_root_state) {
 		case PRS_ROOT:
 		case PRS_ISOLATED:
+		case PRS_ISOLCPUS:
 			if (part_error)
 				new_prs = -old_prs;
 			break;
 		case PRS_INVALID_ROOT:
 		case PRS_INVALID_ISOLATED:
+		case PRS_INVALID_ISOLCPUS:
 			if (!part_error)
 				new_prs = -old_prs;
 			break;
@@ -1553,6 +1578,9 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 
 	spin_unlock_irq(&callback_lock);
 
+	if ((isolcpus_cs == cs) && (cs->partition_root_state != PRS_ISOLCPUS))
+		isolcpus_cs = NULL;
+
 	if (adding || deleting)
 		update_tasks_cpumask(parent, tmp->addmask);
 
@@ -1640,7 +1668,14 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 */
 		old_prs = new_prs = cp->partition_root_state;
 		if ((cp != cs) && old_prs) {
-			switch (parent->partition_root_state) {
+			int parent_prs = parent->partition_root_state;
+
+			/*
+			 * isolcpus partition parent can't have children
+			 */
+			WARN_ON_ONCE(parent_prs == PRS_ISOLCPUS);
+
+			switch (parent_prs) {
 			case PRS_ROOT:
 			case PRS_ISOLATED:
 				update_parent = true;
@@ -1735,9 +1770,10 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
  * @parent:  Parent cpuset
  * @cs:      Current cpuset
  * @tmp:     Temp variables
+ * @force:   Force update if set
  */
 static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
-				    struct tmpmasks *tmp)
+				    struct tmpmasks *tmp, bool force)
 {
 	struct cpuset *sibling;
 	struct cgroup_subsys_state *pos_css;
@@ -1756,7 +1792,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	cpuset_for_each_child(sibling, pos_css, parent) {
 		if (sibling == cs)
 			continue;
-		if (!sibling->use_parent_ecpus)
+		if (!sibling->use_parent_ecpus && !force)
 			continue;
 		if (!css_tryget_online(&sibling->css))
 			continue;
@@ -1893,14 +1929,16 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	update_cpumasks_hier(cs, &tmp, false);
 
 	if (cs->partition_root_state) {
+		bool force = (cs->partition_root_state == PRS_ISOLCPUS);
 		struct cpuset *parent = parent_cs(cs);
 
 		/*
 		 * For partition root, update the cpumasks of sibling
-		 * cpusets if they use parent's effective_cpus.
+		 * cpusets if they use parent's effective_cpus or when
+		 * the current cpuset is an isolcpus partition.
 		 */
-		if (parent->child_ecpus_count)
-			update_sibling_cpumasks(parent, cs, &tmp);
+		if (parent->child_ecpus_count || force)
+			update_sibling_cpumasks(parent, cs, &tmp, force);
 
 		/* Update CS_SCHED_LOAD_BALANCE and/or sched_domains */
 		update_partition_sd_lb(cs, old_prs);
@@ -2298,6 +2336,41 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (alloc_cpumasks(NULL, &tmpmask))
 		return -ENOMEM;
 
+	/*
+	 * Only one isolcpus partition is allowed and it can't have children
+	 * or tasks in it. The isolcpus partition is also not exclusive so
+	 * that the isolated but unused cpus can be distributed down the
+	 * hierarchy.
+	 */
+	if (new_prs == PRS_ISOLCPUS) {
+		if (isolcpus_cs)
+			err = PERR_ISOLCPUS;
+		else if (!list_empty(&cs->css.children))
+			err = PERR_ISOLCHILD;
+		else if (cs->css.cgroup->nr_populated_csets)
+			err = PERR_ISOLTASK;
+
+		if (err && old_prs) {
+			/*
+			 * A previous valid partition root is now invalid
+			 */
+			goto disable_partition;
+		} else if (err) {
+			goto out;
+		}
+
+		/*
+		 * Unlike other partition types, an isolated cpu pool can
+		 * be empty as it is essentially a place holder for isolated
+		 * CPUs.
+		 */
+		if (!old_prs && cpumask_empty(cs->cpus_allowed)) {
+			/* Force effective_cpus to be empty too */
+			cpumask_clear(cs->effective_cpus);
+			goto out;
+		}
+	}
+
 	err = update_partition_exclusive(cs, new_prs);
 	if (err)
 		goto out;
@@ -2316,11 +2389,9 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		if (err)
 			goto out;
 	} else if (old_prs && new_prs) {
-		/*
-		 * A change in load balance state only, no change in cpumasks.
-		 */
-		goto out;
+		goto out;	/* Skip cpuset and sibling task update */
 	} else {
+disable_partition:
 		/*
 		 * Switching back to member is always allowed even if it
 		 * disables child partitions.
@@ -2342,8 +2413,13 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 
 	update_tasks_cpumask(parent, tmpmask.new_cpus);
 
-	if (parent->child_ecpus_count)
-		update_sibling_cpumasks(parent, cs, &tmpmask);
+	/*
+	 * Since isolcpus partition is not exclusive, we have to update
+	 * sibling hierarchies as well.
+	 */
+	if ((new_prs == PRS_ISOLCPUS) || parent->child_ecpus_count)
+		update_sibling_cpumasks(parent, cs, &tmpmask,
+					new_prs == PRS_ISOLCPUS);
 
 out:
 	/*
@@ -2363,6 +2439,14 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	/* Update sched domains and load balance flag */
 	update_partition_sd_lb(cs, old_prs);
 
+	/*
+	 * Check isolcpus_cs state
+	 */
+	if (new_prs == PRS_ISOLCPUS)
+		isolcpus_cs = cs;
+	else if (cs == isolcpus_cs)
+		isolcpus_cs = NULL;
+
 	/*
 	 * Update child cpusets, if present.
 	 * Force update if switching back to member.
@@ -2486,7 +2570,12 @@ static struct cpuset *cpuset_attach_old_cs;
  */
 static int cpuset_can_attach_check(struct cpuset *cs)
 {
+	/*
+	 * Task cannot be moved to a cpuset with empty effective cpus or
+	 * is an isolcpus partition.
+	 */
 	if (cpumask_empty(cs->effective_cpus) ||
+	   (cs->partition_root_state == PRS_ISOLCPUS) ||
 	   (!is_in_v2_mode() && nodes_empty(cs->mems_allowed)))
 		return -ENOSPC;
 	return 0;
@@ -2902,24 +2991,30 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 static int sched_partition_show(struct seq_file *seq, void *v)
 {
 	struct cpuset *cs = css_cs(seq_css(seq));
+	int prs = cs->partition_root_state;
 	const char *err, *type = NULL;
 
-	switch (cs->partition_root_state) {
+	switch (prs) {
 	case PRS_ROOT:
 		seq_puts(seq, "root\n");
 		break;
 	case PRS_ISOLATED:
 		seq_puts(seq, "isolated\n");
 		break;
+	case PRS_ISOLCPUS:
+		seq_puts(seq, "isolcpus\n");
+		break;
 	case PRS_MEMBER:
 		seq_puts(seq, "member\n");
 		break;
-	case PRS_INVALID_ROOT:
-		type = "root";
-		fallthrough;
-	case PRS_INVALID_ISOLATED:
-		if (!type)
+	default:
+		if (prs == PRS_INVALID_ROOT)
+			type = "root";
+		else if (prs == PRS_INVALID_ISOLATED)
 			type = "isolated";
+		else
+			type = "isolcpus";
+
 		err = perr_strings[READ_ONCE(cs->prs_err)];
 		if (err)
 			seq_printf(seq, "%s invalid (%s)\n", type, err);
@@ -2948,6 +3043,8 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 		val = PRS_MEMBER;
 	else if (!strcmp(buf, "isolated"))
 		val = PRS_ISOLATED;
+	else if (!strcmp(buf, "isolcpus"))
+		val = PRS_ISOLCPUS;
 	else
 		return -EINVAL;
 
@@ -3157,6 +3254,7 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 	nodes_clear(cs->effective_mems);
 	fmeter_init(&cs->fmeter);
 	cs->relax_domain_level = -1;
+	INIT_LIST_HEAD(&cs->isol_sibling);
 
 	/* Set CS_MEMORY_MIGRATE for default hierarchy */
 	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
@@ -3171,6 +3269,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	struct cpuset *parent = parent_cs(cs);
 	struct cpuset *tmp_cs;
 	struct cgroup_subsys_state *pos_css;
+	int err = 0;
 
 	if (!parent)
 		return 0;
@@ -3178,6 +3277,14 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	cpus_read_lock();
 	percpu_down_write(&cpuset_rwsem);
 
+	/*
+	 * An isolcpus partition cannot have direct children.
+	 */
+	if (parent->partition_root_state == PRS_ISOLCPUS) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
 	set_bit(CS_ONLINE, &cs->flags);
 	if (is_spread_page(parent))
 		set_bit(CS_SPREAD_PAGE, &cs->flags);
@@ -3229,7 +3336,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
 	cpus_read_unlock();
-	return 0;
+	return err;
 }
 
 /*
@@ -3434,6 +3541,7 @@ int __init cpuset_init(void)
 	fmeter_init(&top_cpuset.fmeter);
 	set_bit(CS_SCHED_LOAD_BALANCE, &top_cpuset.flags);
 	top_cpuset.relax_domain_level = -1;
+	INIT_LIST_HEAD(&isol_children);
 
 	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
 
-- 
2.31.1

