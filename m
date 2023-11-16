Return-Path: <linux-kselftest+bounces-199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6036D7EDA5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 04:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063092812A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 03:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8AABE5F;
	Thu, 16 Nov 2023 03:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZTWono+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7687D1AB
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 19:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700105681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ouWrca3bfYU74kGfYbYL+ROA/NzQPXMR8p7d4VOh00=;
	b=QZTWono+nAzhkRqbOmSf8i0q54E09r7PH+oEEqq9NZbZwvdsPyJyNnycouwK64gb96BR7u
	zZqlSBOgcLM6Uk1YgEHACwFYOAQXzX10Aew1QpyEnYgtQLl1IRrJNkHua/+W1SWxuwJz7b
	5Otb/X2akOaxM/inYRYvuMxGsqe04eA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-4XhlI4WwOxOxJiNUoVd5ow-1; Wed,
 15 Nov 2023 22:34:36 -0500
X-MC-Unique: 4XhlI4WwOxOxJiNUoVd5ow-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B17701C0432D;
	Thu, 16 Nov 2023 03:34:35 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 56F37492BFD;
	Thu, 16 Nov 2023 03:34:35 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Peter Hunt <pehunt@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4 4/5] cgroup/cpuset: Keep track of CPUs in isolated partitions
Date: Wed, 15 Nov 2023 22:34:04 -0500
Message-Id: <20231116033405.185166-5-longman@redhat.com>
In-Reply-To: <20231116033405.185166-1-longman@redhat.com>
References: <20231116033405.185166-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Add a new internal isolated_cpus mask to keep track of the CPUs that
are in isolated partitions. Expose that new cpumask as a new root-only
control file "cpuset.cpus.isolated".

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 190 +++++++++++++++++++++++++++--------------
 1 file changed, 127 insertions(+), 63 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 615daaf87f1f..a265e559f3fa 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -204,6 +204,11 @@ struct cpuset {
  */
 static cpumask_var_t	subpartitions_cpus;
 
+/*
+ * Exclusive CPUs in isolated partitions
+ */
+static cpumask_var_t	isolated_cpus;
+
 /* List of remote partition root children */
 static struct list_head remote_children;
 
@@ -1317,6 +1322,7 @@ static void compute_effective_cpumask(struct cpumask *new_cpus,
  */
 enum partition_cmd {
 	partcmd_enable,		/* Enable partition root	  */
+	partcmd_enablei,	/* Enable isolated partition root */
 	partcmd_disable,	/* Disable partition root	  */
 	partcmd_update,		/* Update parent's effective_cpus */
 	partcmd_invalidate,	/* Make partition invalid	  */
@@ -1418,6 +1424,74 @@ static void reset_partition_data(struct cpuset *cs)
 	}
 }
 
+/*
+ * partition_xcpus_newstate - Exclusive CPUs state change
+ * @old_prs: old partition_root_state
+ * @new_prs: new partition_root_state
+ * @xcpus: exclusive CPUs with state change
+ */
+static void partition_xcpus_newstate(int old_prs, int new_prs, struct cpumask *xcpus)
+{
+	WARN_ON_ONCE(old_prs == new_prs);
+	if (new_prs == PRS_ISOLATED)
+		cpumask_or(isolated_cpus, isolated_cpus, xcpus);
+	else
+		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
+}
+
+/*
+ * partition_xcpus_add - Add new exclusive CPUs to partition
+ * @new_prs: new partition_root_state
+ * @parent: parent cpuset
+ * @xcpus: exclusive CPUs to be added
+ *
+ * Remote partition if parent == NULL
+ */
+static void partition_xcpus_add(int new_prs, struct cpuset *parent,
+				struct cpumask *xcpus)
+{
+	WARN_ON_ONCE(new_prs < 0);
+	lockdep_assert_held(&callback_lock);
+	if (!parent)
+		parent = &top_cpuset;
+
+	if (parent == &top_cpuset)
+		cpumask_or(subpartitions_cpus, subpartitions_cpus, xcpus);
+
+	if (new_prs != parent->partition_root_state)
+		partition_xcpus_newstate(parent->partition_root_state, new_prs,
+					 xcpus);
+
+	cpumask_andnot(parent->effective_cpus, parent->effective_cpus, xcpus);
+}
+
+/*
+ * partition_xcpus_del - Remove exclusive CPUs from partition
+ * @old_prs: old partition_root_state
+ * @parent: parent cpuset
+ * @xcpus: exclusive CPUs to be removed
+ *
+ * Remote partition if parent == NULL
+ */
+static void partition_xcpus_del(int old_prs, struct cpuset *parent,
+				struct cpumask *xcpus)
+{
+	WARN_ON_ONCE(old_prs < 0);
+	lockdep_assert_held(&callback_lock);
+	if (!parent)
+		parent = &top_cpuset;
+
+	if (parent == &top_cpuset)
+		cpumask_andnot(subpartitions_cpus, subpartitions_cpus, xcpus);
+
+	if (old_prs != parent->partition_root_state)
+		partition_xcpus_newstate(old_prs, parent->partition_root_state,
+					 xcpus);
+
+	cpumask_and(xcpus, xcpus, cpu_active_mask);
+	cpumask_or(parent->effective_cpus, parent->effective_cpus, xcpus);
+}
+
 /*
  * compute_effective_exclusive_cpumask - compute effective exclusive CPUs
  * @cs: cpuset
@@ -1456,13 +1530,15 @@ static inline bool is_local_partition(struct cpuset *cs)
 /*
  * remote_partition_enable - Enable current cpuset as a remote partition root
  * @cs: the cpuset to update
+ * @new_prs: new partition_root_state
  * @tmp: temparary masks
  * Return: 1 if successful, 0 if error
  *
  * Enable the current cpuset to become a remote partition root taking CPUs
  * directly from the top cpuset. cpuset_mutex must be held by the caller.
  */
-static int remote_partition_enable(struct cpuset *cs, struct tmpmasks *tmp)
+static int remote_partition_enable(struct cpuset *cs, int new_prs,
+				   struct tmpmasks *tmp)
 {
 	/*
 	 * The user must have sysadmin privilege.
@@ -1485,18 +1561,14 @@ static int remote_partition_enable(struct cpuset *cs, struct tmpmasks *tmp)
 		return 0;
 
 	spin_lock_irq(&callback_lock);
-	cpumask_andnot(top_cpuset.effective_cpus,
-		       top_cpuset.effective_cpus, tmp->new_cpus);
-	cpumask_or(subpartitions_cpus,
-		   subpartitions_cpus, tmp->new_cpus);
-
+	partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
+	list_add(&cs->remote_sibling, &remote_children);
 	if (cs->use_parent_ecpus) {
 		struct cpuset *parent = parent_cs(cs);
 
 		cs->use_parent_ecpus = false;
 		parent->child_ecpus_count--;
 	}
-	list_add(&cs->remote_sibling, &remote_children);
 	spin_unlock_irq(&callback_lock);
 
 	/*
@@ -1524,13 +1596,8 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, subpartitions_cpus));
 
 	spin_lock_irq(&callback_lock);
-	cpumask_andnot(subpartitions_cpus,
-		       subpartitions_cpus, tmp->new_cpus);
-	cpumask_and(tmp->new_cpus,
-		    tmp->new_cpus, cpu_active_mask);
-	cpumask_or(top_cpuset.effective_cpus,
-		   top_cpuset.effective_cpus, tmp->new_cpus);
 	list_del_init(&cs->remote_sibling);
+	partition_xcpus_del(cs->partition_root_state, NULL, tmp->new_cpus);
 	cs->partition_root_state = -cs->partition_root_state;
 	if (!cs->prs_err)
 		cs->prs_err = PERR_INVCPUS;
@@ -1557,6 +1624,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 			       struct tmpmasks *tmp)
 {
 	bool adding, deleting;
+	int prs = cs->partition_root_state;
 
 	if (WARN_ON_ONCE(!is_remote_partition(cs)))
 		return;
@@ -1580,20 +1648,10 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 		goto invalidate;
 
 	spin_lock_irq(&callback_lock);
-	if (adding) {
-		cpumask_or(subpartitions_cpus,
-			   subpartitions_cpus, tmp->addmask);
-		cpumask_andnot(top_cpuset.effective_cpus,
-			       top_cpuset.effective_cpus, tmp->addmask);
-	}
-	if (deleting) {
-		cpumask_andnot(subpartitions_cpus,
-			       subpartitions_cpus, tmp->delmask);
-		cpumask_and(tmp->delmask,
-			    tmp->delmask, cpu_active_mask);
-		cpumask_or(top_cpuset.effective_cpus,
-			   top_cpuset.effective_cpus, tmp->delmask);
-	}
+	if (adding)
+		partition_xcpus_add(prs, NULL, tmp->addmask);
+	if (deleting)
+		partition_xcpus_del(prs, NULL, tmp->delmask);
 	spin_unlock_irq(&callback_lock);
 
 	/*
@@ -1676,11 +1734,11 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
  * @tmp:     Temporary addmask and delmask
  * Return:   0 or a partition root state error code
  *
- * For partcmd_enable, the cpuset is being transformed from a non-partition
- * root to a partition root. The effective_xcpus (cpus_allowed if effective_xcpus
- * not set) mask of the given cpuset will be taken away from parent's
- * effective_cpus. The function will return 0 if all the CPUs listed in
- * effective_xcpus can be granted or an error code will be returned.
+ * For partcmd_enable*, the cpuset is being transformed from a non-partition
+ * root to a partition root. The effective_xcpus (cpus_allowed if
+ * effective_xcpus not set) mask of the given cpuset will be taken away from
+ * parent's effective_cpus. The function will return 0 if all the CPUs listed
+ * in effective_xcpus can be granted or an error code will be returned.
  *
  * For partcmd_disable, the cpuset is being transformed from a partition
  * root back to a non-partition root. Any CPUs in effective_xcpus will be
@@ -1695,7 +1753,7 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
  *
  * For partcmd_invalidate, the current partition will be made invalid.
  *
- * The partcmd_enable and partcmd_disable commands are used by
+ * The partcmd_enable* and partcmd_disable commands are used by
  * update_prstate(). An error code may be returned and the caller will check
  * for error.
  *
@@ -1760,7 +1818,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 
 	nocpu = tasks_nocpu_error(parent, cs, xcpus);
 
-	if (cmd == partcmd_enable) {
+	if ((cmd == partcmd_enable) || (cmd == partcmd_enablei)) {
 		/*
 		 * Enabling partition root is not allowed if its
 		 * effective_xcpus is empty or doesn't overlap with
@@ -1783,6 +1841,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		cpumask_copy(tmp->delmask, xcpus);
 		deleting = true;
 		subparts_delta++;
+		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
 	} else if (cmd == partcmd_disable) {
 		/*
 		 * May need to add cpus to parent's effective_cpus for
@@ -1792,6 +1851,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			  cpumask_and(tmp->addmask, xcpus, parent->effective_xcpus);
 		if (adding)
 			subparts_delta--;
+		new_prs = PRS_MEMBER;
 	} else if (newmask) {
 		/*
 		 * Empty cpumask is not allowed
@@ -1940,37 +2000,24 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	 * newly deleted ones will be added back to effective_cpus.
 	 */
 	spin_lock_irq(&callback_lock);
-	if (adding) {
-		if (parent == &top_cpuset)
-			cpumask_andnot(subpartitions_cpus,
-				       subpartitions_cpus, tmp->addmask);
-		/*
-		 * Some of the CPUs in effective_xcpus might have been offlined.
-		 */
-		cpumask_or(parent->effective_cpus,
-			   parent->effective_cpus, tmp->addmask);
-		cpumask_and(parent->effective_cpus,
-			    parent->effective_cpus, cpu_active_mask);
-	}
-	if (deleting) {
-		if (parent == &top_cpuset)
-			cpumask_or(subpartitions_cpus,
-				   subpartitions_cpus, tmp->delmask);
-		cpumask_andnot(parent->effective_cpus,
-			       parent->effective_cpus, tmp->delmask);
-	}
-
-	if (is_partition_valid(parent)) {
-		parent->nr_subparts += subparts_delta;
-		WARN_ON_ONCE(parent->nr_subparts < 0);
-	}
-
 	if (old_prs != new_prs) {
 		cs->partition_root_state = new_prs;
 		if (new_prs <= 0)
 			cs->nr_subparts = 0;
 	}
+	/*
+	 * Adding to parent's effective_cpus means deletion CPUs from cs
+	 * and vice versa.
+	 */
+	if (adding)
+		partition_xcpus_del(old_prs, parent, tmp->addmask);
+	if (deleting)
+		partition_xcpus_add(new_prs, parent, tmp->delmask);
 
+	if (is_partition_valid(parent)) {
+		parent->nr_subparts += subparts_delta;
+		WARN_ON_ONCE(parent->nr_subparts < 0);
+	}
 	spin_unlock_irq(&callback_lock);
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
@@ -2948,6 +2995,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	int err = PERR_NONE, old_prs = cs->partition_root_state;
 	struct cpuset *parent = parent_cs(cs);
 	struct tmpmasks tmpmask;
+	bool new_xcpus_state = false;
 
 	if (old_prs == new_prs)
 		return 0;
@@ -2977,6 +3025,9 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		goto out;
 
 	if (!old_prs) {
+		enum partition_cmd cmd = (new_prs == PRS_ROOT)
+				       ? partcmd_enable : partcmd_enablei;
+
 		/*
 		 * cpus_allowed cannot be empty.
 		 */
@@ -2985,19 +3036,18 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 			goto out;
 		}
 
-		err = update_parent_effective_cpumask(cs, partcmd_enable,
-						      NULL, &tmpmask);
+		err = update_parent_effective_cpumask(cs, cmd, NULL, &tmpmask);
 		/*
 		 * If an attempt to become local partition root fails,
 		 * try to become a remote partition root instead.
 		 */
-		if (err && remote_partition_enable(cs, &tmpmask))
+		if (err && remote_partition_enable(cs, new_prs, &tmpmask))
 			err = 0;
 	} else if (old_prs && new_prs) {
 		/*
 		 * A change in load balance state only, no change in cpumasks.
 		 */
-		;
+		new_xcpus_state = true;
 	} else {
 		/*
 		 * Switching back to member is always allowed even if it
@@ -3029,6 +3079,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	WRITE_ONCE(cs->prs_err, err);
 	if (!is_partition_valid(cs))
 		reset_partition_data(cs);
+	else if (new_xcpus_state)
+		partition_xcpus_newstate(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
 
 	/* Force update if switching back to member */
@@ -3386,6 +3438,7 @@ typedef enum {
 	FILE_SUBPARTS_CPULIST,
 	FILE_EXCLUSIVE_CPULIST,
 	FILE_EFFECTIVE_XCPULIST,
+	FILE_ISOLATED_CPULIST,
 	FILE_CPU_EXCLUSIVE,
 	FILE_MEM_EXCLUSIVE,
 	FILE_MEM_HARDWALL,
@@ -3582,6 +3635,9 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	case FILE_SUBPARTS_CPULIST:
 		seq_printf(sf, "%*pbl\n", cpumask_pr_args(subpartitions_cpus));
 		break;
+	case FILE_ISOLATED_CPULIST:
+		seq_printf(sf, "%*pbl\n", cpumask_pr_args(isolated_cpus));
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -3875,6 +3931,13 @@ static struct cftype dfl_files[] = {
 		.flags = CFTYPE_ONLY_ON_ROOT | CFTYPE_DEBUG,
 	},
 
+	{
+		.name = "cpus.isolated",
+		.seq_show = cpuset_common_seq_show,
+		.private = FILE_ISOLATED_CPULIST,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+	},
+
 	{ }	/* terminate */
 };
 
@@ -4194,6 +4257,7 @@ int __init cpuset_init(void)
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_xcpus, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.exclusive_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&subpartitions_cpus, GFP_KERNEL));
+	BUG_ON(!zalloc_cpumask_var(&isolated_cpus, GFP_KERNEL));
 
 	cpumask_setall(top_cpuset.cpus_allowed);
 	nodes_setall(top_cpuset.mems_allowed);
-- 
2.39.3


