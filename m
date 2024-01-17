Return-Path: <linux-kselftest+bounces-3158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8825830B33
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 17:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D11528D0C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 16:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE61F2263A;
	Wed, 17 Jan 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELgqeB4A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA2225AF
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509378; cv=none; b=PfJKMGadb0AYUgCHMbcdZzst2H3xensZVJ7bwajisOYBbL9bCyqyTvGfU7Nac11GvgaFC0DSgDv8bSTbwDZXO7daO6NIkt6wt7WuzRSatgWvu7a2lm6p/xhJAKMUspIM8h9TukvQkEC5HMR1xfNC290SmDtDq54+P9FvK+7461I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509378; c=relaxed/simple;
	bh=5UEzyAawuulkn9wa4nP2VXfeCOs8DGc/KPmirNiRgUU=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By; b=MlUM4P8Tuxw0lGGGTNQZ1ccebfPIwU5TUa5b1dnUIoQH9rvT0MbH/EBiLvpTD1JOjr+ZKCGW+i3k6q0LV1ShIQDAP59txalW/6ijR96SnzhWlpKSsY53JlNApw8pjrHUa/naBlDBK/QaHGE4KL05PU8sAY3rvNSUIKo5ZL42HEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELgqeB4A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705509375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ssqmGGPuOAdNch15QLVD55rG/uP6CAKjxRipGrMtQM=;
	b=ELgqeB4Av28YVS29XnOEVFv4NvoGm2KVgueQHgubE68WVcftQ5DYN3DZOrn6CYjk730qV8
	tZvvPO1KMVf0Chg29bGJoxhDDzI8uGXovC2EFT325x2teoYHEulWbPoG9JqL6UaZELPwK7
	ceAnhqEnPQxgbNTA72PwkacGNyAm7Uk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-5gxLqypwMn2tdHIuj81JEQ-1; Wed, 17 Jan 2024 11:36:12 -0500
X-MC-Unique: 5gxLqypwMn2tdHIuj81JEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 672EE81DA88;
	Wed, 17 Jan 2024 16:36:11 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C42601121306;
	Wed, 17 Jan 2024 16:36:09 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mrunal Patel <mpatel@redhat.com>,
	Ryan Phillips <rphillips@redhat.com>,
	Brent Rowsell <browsell@redhat.com>,
	Peter Hunt <pehunt@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Alex Gladkov <agladkov@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 4/8] cgroup/cpuset: Better tracking of addition/deletion of isolated CPUs
Date: Wed, 17 Jan 2024 11:35:07 -0500
Message-Id: <20240117163511.88173-5-longman@redhat.com>
In-Reply-To: <20240117163511.88173-1-longman@redhat.com>
References: <20240117163511.88173-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The process of updating workqueue unbound cpumask to exclude isolated
CPUs in cpuset only requires the use of the aggregated isolated_cpus
cpumask.  Other types of CPU isolation, like the RCU no-callback CPU
mode, may require knowing more granular addition and deletion of isolated
CPUs. To enable these types of CPU isolation at run time, we need to
provide better tracking of the addition and deletion of isolated CPUs.

This patch adds a new isolated_cpus_modifier enum type for tracking
the addition and deletion of isolated CPUs as well as renaming
update_unbound_workqueue_cpumask() to update_isolation_cpumasks()
to accommodate additional CPU isolation modes in the future.

There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 113 +++++++++++++++++++++++++----------------
 1 file changed, 69 insertions(+), 44 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index dfbb16aca9f4..0479af76a5dc 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -206,6 +206,13 @@ struct cpuset {
  */
 static cpumask_var_t	subpartitions_cpus;
 
+/* Enum types for possible changes to the set of isolated CPUs */
+enum isolated_cpus_modifiers {
+	ISOL_CPUS_NONE = 0,
+	ISOL_CPUS_ADD,
+	ISOL_CPUS_DELETE,
+};
+
 /*
  * Exclusive CPUs in isolated partitions
  */
@@ -1446,14 +1453,14 @@ static void partition_xcpus_newstate(int old_prs, int new_prs, struct cpumask *x
  * @new_prs: new partition_root_state
  * @parent: parent cpuset
  * @xcpus: exclusive CPUs to be added
- * Return: true if isolated_cpus modified, false otherwise
+ * Return: isolated_cpus modifier
  *
  * Remote partition if parent == NULL
  */
-static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
-				struct cpumask *xcpus)
+static int partition_xcpus_add(int new_prs, struct cpuset *parent,
+			       struct cpumask *xcpus)
 {
-	bool isolcpus_updated;
+	int icpus_mod = ISOL_CPUS_NONE;
 
 	WARN_ON_ONCE(new_prs < 0);
 	lockdep_assert_held(&callback_lock);
@@ -1464,13 +1471,14 @@ static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
 	if (parent == &top_cpuset)
 		cpumask_or(subpartitions_cpus, subpartitions_cpus, xcpus);
 
-	isolcpus_updated = (new_prs != parent->partition_root_state);
-	if (isolcpus_updated)
+	if (new_prs != parent->partition_root_state) {
 		partition_xcpus_newstate(parent->partition_root_state, new_prs,
 					 xcpus);
-
+		icpus_mod = (new_prs == PRS_ISOLATED)
+			    ? ISOL_CPUS_ADD : ISOL_CPUS_DELETE;
+	}
 	cpumask_andnot(parent->effective_cpus, parent->effective_cpus, xcpus);
-	return isolcpus_updated;
+	return icpus_mod;
 }
 
 /*
@@ -1478,14 +1486,14 @@ static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
  * @old_prs: old partition_root_state
  * @parent: parent cpuset
  * @xcpus: exclusive CPUs to be removed
- * Return: true if isolated_cpus modified, false otherwise
+ * Return: isolated_cpus modifier
  *
  * Remote partition if parent == NULL
  */
-static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
+static int partition_xcpus_del(int old_prs, struct cpuset *parent,
 				struct cpumask *xcpus)
 {
-	bool isolcpus_updated;
+	int icpus_mod;
 
 	WARN_ON_ONCE(old_prs < 0);
 	lockdep_assert_held(&callback_lock);
@@ -1495,27 +1503,40 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 	if (parent == &top_cpuset)
 		cpumask_andnot(subpartitions_cpus, subpartitions_cpus, xcpus);
 
-	isolcpus_updated = (old_prs != parent->partition_root_state);
-	if (isolcpus_updated)
+	if (old_prs != parent->partition_root_state) {
 		partition_xcpus_newstate(old_prs, parent->partition_root_state,
 					 xcpus);
-
+		icpus_mod = (old_prs == PRS_ISOLATED)
+			    ? ISOL_CPUS_DELETE : ISOL_CPUS_ADD;
+	}
 	cpumask_and(xcpus, xcpus, cpu_active_mask);
 	cpumask_or(parent->effective_cpus, parent->effective_cpus, xcpus);
-	return isolcpus_updated;
+	return icpus_mod;
 }
 
-static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
+/**
+ * update_isolation_cpumasks - Add or remove CPUs to/from full isolation state
+ * @mask: cpumask of the CPUs to be added or removed
+ * @modifier: enum isolated_cpus_modifiers
+ * Return: 0 if successful, error code otherwise
+ *
+ * Workqueue unbound cpumask update is applied irrespective of isolation_full
+ * state and the whole isolated_cpus is passed. Repeated calls with the same
+ * isolated_cpus will not cause further action other than a wasted mutex
+ * lock/unlock.
+ */
+static int update_isolation_cpumasks(struct cpumask *mask, int modifier)
 {
-	int ret;
+	int err;
 
 	lockdep_assert_cpus_held();
 
-	if (!isolcpus_updated)
-		return;
+	if (!modifier)
+		return 0;	/* No change in isolated CPUs */
 
-	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
-	WARN_ON_ONCE(ret < 0);
+	err = workqueue_unbound_exclude_cpumask(isolated_cpus);
+	WARN_ON_ONCE(err);
+	return err;
 }
 
 /**
@@ -1577,7 +1598,7 @@ static inline bool is_local_partition(struct cpuset *cs)
 static int remote_partition_enable(struct cpuset *cs, int new_prs,
 				   struct tmpmasks *tmp)
 {
-	bool isolcpus_updated;
+	int icpus_mod;
 
 	/*
 	 * The user must have sysadmin privilege.
@@ -1600,7 +1621,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 		return 0;
 
 	spin_lock_irq(&callback_lock);
-	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
+	icpus_mod = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
 	list_add(&cs->remote_sibling, &remote_children);
 	if (cs->use_parent_ecpus) {
 		struct cpuset *parent = parent_cs(cs);
@@ -1609,7 +1630,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 		parent->child_ecpus_count--;
 	}
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(tmp->new_cpus, icpus_mod);
 
 	/*
 	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
@@ -1630,7 +1651,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
  */
 static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 {
-	bool isolcpus_updated;
+	int icpus_mod;
 
 	compute_effective_exclusive_cpumask(cs, tmp->new_cpus);
 	WARN_ON_ONCE(!is_remote_partition(cs));
@@ -1638,14 +1659,14 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 
 	spin_lock_irq(&callback_lock);
 	list_del_init(&cs->remote_sibling);
-	isolcpus_updated = partition_xcpus_del(cs->partition_root_state,
-					       NULL, tmp->new_cpus);
+	icpus_mod = partition_xcpus_del(cs->partition_root_state, NULL,
+					tmp->new_cpus);
 	cs->partition_root_state = -cs->partition_root_state;
 	if (!cs->prs_err)
 		cs->prs_err = PERR_INVCPUS;
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(tmp->new_cpus, icpus_mod);
 
 	/*
 	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
@@ -1668,7 +1689,8 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 {
 	bool adding, deleting;
 	int prs = cs->partition_root_state;
-	int isolcpus_updated = 0;
+	int icpus_add_mod = ISOL_CPUS_NONE;
+	int icpus_del_mod = ISOL_CPUS_NONE;
 
 	if (WARN_ON_ONCE(!is_remote_partition(cs)))
 		return;
@@ -1693,12 +1715,12 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 
 	spin_lock_irq(&callback_lock);
 	if (adding)
-		isolcpus_updated += partition_xcpus_add(prs, NULL, tmp->addmask);
+		icpus_add_mod = partition_xcpus_add(prs, NULL, tmp->addmask);
 	if (deleting)
-		isolcpus_updated += partition_xcpus_del(prs, NULL, tmp->delmask);
+		icpus_del_mod = partition_xcpus_del(prs, NULL, tmp->delmask);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
-
+	update_isolation_cpumasks(tmp->addmask, icpus_add_mod);
+	update_isolation_cpumasks(tmp->delmask, icpus_del_mod);
 	/*
 	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
 	 */
@@ -1819,7 +1841,8 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	int part_error = PERR_NONE;	/* Partition error? */
 	int subparts_delta = 0;
 	struct cpumask *xcpus;		/* cs effective_xcpus */
-	int isolcpus_updated = 0;
+	int icpus_add_mod = ISOL_CPUS_NONE;
+	int icpus_del_mod = ISOL_CPUS_NONE;
 	bool nocpu;
 
 	lockdep_assert_held(&cpuset_mutex);
@@ -2052,22 +2075,23 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			cs->nr_subparts = 0;
 	}
 	/*
-	 * Adding to parent's effective_cpus means deletion CPUs from cs
+	 * Adding to parent's effective_cpus means deleting CPUs from cs
 	 * and vice versa.
 	 */
 	if (adding)
-		isolcpus_updated += partition_xcpus_del(old_prs, parent,
-							tmp->addmask);
+		icpus_add_mod = partition_xcpus_del(old_prs, parent,
+						    tmp->addmask);
 	if (deleting)
-		isolcpus_updated += partition_xcpus_add(new_prs, parent,
-							tmp->delmask);
+		icpus_del_mod = partition_xcpus_add(new_prs, parent,
+						    tmp->delmask);
 
 	if (is_partition_valid(parent)) {
 		parent->nr_subparts += subparts_delta;
 		WARN_ON_ONCE(parent->nr_subparts < 0);
 	}
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(tmp->addmask, icpus_add_mod);
+	update_isolation_cpumasks(tmp->delmask, icpus_del_mod);
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
 		update_partition_exclusive(cs, new_prs);
@@ -3044,7 +3068,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	int err = PERR_NONE, old_prs = cs->partition_root_state;
 	struct cpuset *parent = parent_cs(cs);
 	struct tmpmasks tmpmask;
-	bool new_xcpus_state = false;
+	int icpus_mod = ISOL_CPUS_NONE;
 
 	if (old_prs == new_prs)
 		return 0;
@@ -3096,7 +3120,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		/*
 		 * A change in load balance state only, no change in cpumasks.
 		 */
-		new_xcpus_state = true;
+		icpus_mod = (new_prs == PRS_ISOLATED)
+			    ? ISOL_CPUS_ADD : ISOL_CPUS_DELETE;
 	} else {
 		/*
 		 * Switching back to member is always allowed even if it
@@ -3128,10 +3153,10 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	WRITE_ONCE(cs->prs_err, err);
 	if (!is_partition_valid(cs))
 		reset_partition_data(cs);
-	else if (new_xcpus_state)
+	else if (icpus_mod)
 		partition_xcpus_newstate(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(new_xcpus_state);
+	update_isolation_cpumasks(cs->effective_xcpus, icpus_mod);
 
 	/* Force update if switching back to member */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs ? HIER_CHECKALL : 0);
-- 
2.39.3


