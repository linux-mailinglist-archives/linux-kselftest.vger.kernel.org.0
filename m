Return-Path: <linux-kselftest+bounces-38577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6CAB1EB4D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF31818C5934
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867CD28150A;
	Fri,  8 Aug 2025 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZp4KO3+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919CF283FEF
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665959; cv=none; b=pZaq60kpthknFm2nuckeyMsQGVVNiuJYI38LO6usaEtPhXrcnYV+sDwQfpWwlPIo2o6DmZA7IvLJIoGl94f8mRQeMVZLk3jdXc74NLxsEnVDf0Ozg0yJjenIqriHH9oXXKoTB5wOC+pHcd/rlF05+XNSQTTlXTY5qXAm4zaKGTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665959; c=relaxed/simple;
	bh=bKGzmCs04LfQYlOkM2mmW14HoIY6BlJGh+5yZVS1gqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZF4hNDuP646YvPCDYyFSL9zLjdWx9boknDth456tHr7D7o3ysDk53GOq7qwWuBPjMqxi4cs7vKglyynnedlsNeEWuKpux1VYAuV0DND9hZf5SwdgPCOFyj8TF1XNda3OCNJpVaa+qQewyhS/4LGVutMSyjdSTnFxQQ0Kgo89vDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZp4KO3+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754665955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azQU8QVYfgv/z/JeThAegMECgITB7qX+pmu/A49K2aI=;
	b=dZp4KO3+1nxYno0wtCXdUzUsIXmUfx6l0z95mzsgZPA3wQz9/gB0pS2GLLzEDEqRygxakU
	Fa1rMRirJ3jNtMvjSkvX1FOjm4dh1vjhCBGbQWHwwVbgYPYh6SRR61EF72XePPCuWHRivR
	wrBs7inlYGkcYgPqbE456s7HsZDUkNU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-DY2KxiU2MFKqn7LUev5NUA-1; Fri,
 08 Aug 2025 11:12:32 -0400
X-MC-Unique: DY2KxiU2MFKqn7LUev5NUA-1
X-Mimecast-MFC-AGG-ID: DY2KxiU2MFKqn7LUev5NUA_1754665949
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DED271956048;
	Fri,  8 Aug 2025 15:12:28 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EEF91954196;
	Fri,  8 Aug 2025 15:12:22 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 06/18] cgroup/cpuset: Introduce a new top level isolcpus_update_mutex
Date: Fri,  8 Aug 2025 11:10:50 -0400
Message-ID: <20250808151053.19777-7-longman@redhat.com>
In-Reply-To: <20250808151053.19777-1-longman@redhat.com>
References: <20250808151053.19777-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The current cpuset partition code is able to dynamically update the
sched domains of a running system to perform what is essentally the
"isolcpus=domain,..." boot command line feature at run time.

To enable runtime modification of nohz_full, we will have to make use
of the CPU hotplug functionality to facilitate the proper addition
or subtraction of nohz_full CPUs. In other word, we can't hold the
cpu_hotplug_lock while doing so. Given the current lock ordering, we
will need to introduce a new top level mutex to ensure proper mutual
exclusion in case there is a need to update the cpuset states that
may require the use of CPU hotplug. This patch introduces a new top
level isolcpus_update_mutex for such purpose. This new mutex will be
acquired in case the cpuset partition states or the set of isolated
CPUs may have to be changed.

The update_unbound_workqueue_cpumask() is now renamed to
update_isolation_cpumasks() and moved outside of cpu_hotplug_lock
critical regions to enable its future extension to invoke CPU hotplug.

A new global isolcpus_update_state structure is added to track if
update_isolation_cpumasks() will need to be invoked. So the existing
partition_xcpus_add/del() functions and their callers can now be
simplified.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 149 ++++++++++++++++++++++++-----------------
 1 file changed, 86 insertions(+), 63 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 27adb04df675..2190efd33efb 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -215,29 +215,39 @@ static struct cpuset top_cpuset = {
 };
 
 /*
- * There are two global locks guarding cpuset structures - cpuset_mutex and
- * callback_lock. The cpuset code uses only cpuset_mutex. Other kernel
- * subsystems can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
- * structures. Note that cpuset_mutex needs to be a mutex as it is used in
- * paths that rely on priority inheritance (e.g. scheduler - on RT) for
- * correctness.
+ * CPUSET Locking Convention
+ * -------------------------
  *
- * A task must hold both locks to modify cpusets.  If a task holds
- * cpuset_mutex, it blocks others, ensuring that it is the only task able to
- * also acquire callback_lock and be able to modify cpusets.  It can perform
- * various checks on the cpuset structure first, knowing nothing will change.
- * It can also allocate memory while just holding cpuset_mutex.  While it is
- * performing these checks, various callback routines can briefly acquire
- * callback_lock to query cpusets.  Once it is ready to make the changes, it
- * takes callback_lock, blocking everyone else.
+ * Below are the three global locks guarding cpuset structures in lock
+ * acquisition order:
+ *  - isolcpus_update_mutex
+ *  - cpu_hotplug_lock (cpus_read_lock/cpus_write_lock)
+ *  - cpuset_mutex
+ *  - callback_lock (raw spinlock)
  *
- * Calls to the kernel memory allocator can not be made while holding
- * callback_lock, as that would risk double tripping on callback_lock
- * from one of the callbacks into the cpuset code from within
- * __alloc_pages().
+ * The first isolcpus_update_mutex should only be held if the existing set of
+ * isolated CPUs (in isolated partition) or any of the partition states may be
+ * changed. Otherwise, it can be skipped. This is used to prevent concurrent
+ * updates to the set of isolated CPUs.
  *
- * If a task is only holding callback_lock, then it has read-only
- * access to cpusets.
+ * A task must hold all the remaining three locks to modify externally visible
+ * or used fields of cpusets, though some of the internally used cpuset fields
+ * can be modified by holding cpu_hotplug_lock and cpuset_mutex only. If only
+ * reliable read access of the externally used fields are needed, a task can
+ * hold either cpuset_mutex or callback_lock.
+ *
+ * If a task holds cpu_hotplug_lock and cpuset_mutex, it blocks others,
+ * ensuring that it is the only task able to also acquire callback_lock and
+ * be able to modify cpusets.  It can perform various checks on the cpuset
+ * structure first, knowing nothing will change. It can also allocate memory
+ * without holding callback_lock. While it is performing these checks, various
+ * callback routines can briefly acquire callback_lock to query cpusets.  Once
+ * it is ready to make the changes, it takes callback_lock, blocking everyone
+ * else.
+ *
+ * Calls to the kernel memory allocator cannot be made while holding
+ * callback_lock which is a spinlock, as the memory allocator may sleep or
+ * call back into cpuset code and acquire callback_lock.
  *
  * Now, the task_struct fields mems_allowed and mempolicy may be changed
  * by other task, we use alloc_lock in the task_struct fields to protect
@@ -248,6 +258,7 @@ static struct cpuset top_cpuset = {
  * cpumasks and nodemasks.
  */
 
+static DEFINE_MUTEX(isolcpus_update_mutex);
 static DEFINE_MUTEX(cpuset_mutex);
 
 void cpuset_lock(void)
@@ -272,6 +283,17 @@ void cpuset_callback_unlock_irq(void)
 	spin_unlock_irq(&callback_lock);
 }
 
+/*
+ * Isolcpus update state (protected by isolcpus_update_mutex mutex)
+ *
+ * It contains data related to updating the isolated CPUs configuration in
+ * isolated partitions.
+ */
+static struct {
+	bool updating;		/* Isolcpus updating in progress */
+	cpumask_var_t cpus;	/* CPUs to be updated */
+} isolcpus_update_state;
+
 static struct workqueue_struct *cpuset_migrate_mm_wq;
 
 static DECLARE_WAIT_QUEUE_HEAD(cpuset_attach_wq);
@@ -1273,6 +1295,9 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
 		cpumask_or(isolated_cpus, isolated_cpus, xcpus);
 	else
 		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
+
+	isolcpus_update_state.updating = true;
+	cpumask_or(isolcpus_update_state.cpus, isolcpus_update_state.cpus, xcpus);
 }
 
 /*
@@ -1280,31 +1305,26 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
  * @new_prs: new partition_root_state
  * @parent: parent cpuset
  * @xcpus: exclusive CPUs to be added
- * Return: true if isolated_cpus modified, false otherwise
  *
  * Remote partition if parent == NULL
  */
-static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
+static void partition_xcpus_add(int new_prs, struct cpuset *parent,
 				struct cpumask *xcpus)
 {
-	bool isolcpus_updated;
-
 	WARN_ON_ONCE(new_prs < 0);
 	lockdep_assert_held(&callback_lock);
 	if (!parent)
 		parent = &top_cpuset;
 
-
 	if (parent == &top_cpuset)
 		cpumask_or(subpartitions_cpus, subpartitions_cpus, xcpus);
 
-	isolcpus_updated = (new_prs != parent->partition_root_state);
-	if (isolcpus_updated)
+	if (new_prs != parent->partition_root_state)
 		isolated_cpus_update(parent->partition_root_state, new_prs,
 				     xcpus);
 
 	cpumask_andnot(parent->effective_cpus, parent->effective_cpus, xcpus);
-	return isolcpus_updated;
+	return;
 }
 
 /*
@@ -1312,15 +1332,12 @@ static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
  * @old_prs: old partition_root_state
  * @parent: parent cpuset
  * @xcpus: exclusive CPUs to be removed
- * Return: true if isolated_cpus modified, false otherwise
  *
  * Remote partition if parent == NULL
  */
-static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
+static void partition_xcpus_del(int old_prs, struct cpuset *parent,
 				struct cpumask *xcpus)
 {
-	bool isolcpus_updated;
-
 	WARN_ON_ONCE(old_prs < 0);
 	lockdep_assert_held(&callback_lock);
 	if (!parent)
@@ -1329,27 +1346,33 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 	if (parent == &top_cpuset)
 		cpumask_andnot(subpartitions_cpus, subpartitions_cpus, xcpus);
 
-	isolcpus_updated = (old_prs != parent->partition_root_state);
-	if (isolcpus_updated)
+	if (old_prs != parent->partition_root_state)
 		isolated_cpus_update(old_prs, parent->partition_root_state,
 				     xcpus);
 
 	cpumask_and(xcpus, xcpus, cpu_active_mask);
 	cpumask_or(parent->effective_cpus, parent->effective_cpus, xcpus);
-	return isolcpus_updated;
+	return;
 }
 
-static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
+/**
+ * update_isolation_cpumasks - Update external isolation CPU masks
+ *
+ * The following external CPU masks will be updated if necessary:
+ * - workqueue unbound cpumask
+ */
+static void update_isolation_cpumasks(void)
 {
 	int ret;
 
-	lockdep_assert_cpus_held();
-
-	if (!isolcpus_updated)
+	if (!isolcpus_update_state.updating)
 		return;
 
 	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
 	WARN_ON_ONCE(ret < 0);
+
+	cpumask_clear(isolcpus_update_state.cpus);
+	isolcpus_update_state.updating = false;
 }
 
 /**
@@ -1441,8 +1464,6 @@ static inline bool is_local_partition(struct cpuset *cs)
 static int remote_partition_enable(struct cpuset *cs, int new_prs,
 				   struct tmpmasks *tmp)
 {
-	bool isolcpus_updated;
-
 	/*
 	 * The user must have sysadmin privilege.
 	 */
@@ -1466,11 +1487,10 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 		return PERR_INVCPUS;
 
 	spin_lock_irq(&callback_lock);
-	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
+	partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
 	list_add(&cs->remote_sibling, &remote_children);
 	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
 	cpuset_force_rebuild();
 	cs->prs_err = 0;
 
@@ -1493,15 +1513,12 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
  */
 static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 {
-	bool isolcpus_updated;
-
 	WARN_ON_ONCE(!is_remote_partition(cs));
 	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
 
 	spin_lock_irq(&callback_lock);
 	list_del_init(&cs->remote_sibling);
-	isolcpus_updated = partition_xcpus_del(cs->partition_root_state,
-					       NULL, cs->effective_xcpus);
+	partition_xcpus_del(cs->partition_root_state, NULL, cs->effective_xcpus);
 	if (cs->prs_err)
 		cs->partition_root_state = -cs->partition_root_state;
 	else
@@ -1511,7 +1528,6 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	compute_effective_exclusive_cpumask(cs, NULL, NULL);
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
 	cpuset_force_rebuild();
 
 	/*
@@ -1536,7 +1552,6 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 {
 	bool adding, deleting;
 	int prs = cs->partition_root_state;
-	int isolcpus_updated = 0;
 
 	if (WARN_ON_ONCE(!is_remote_partition(cs)))
 		return;
@@ -1569,9 +1584,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 
 	spin_lock_irq(&callback_lock);
 	if (adding)
-		isolcpus_updated += partition_xcpus_add(prs, NULL, tmp->addmask);
+		partition_xcpus_add(prs, NULL, tmp->addmask);
 	if (deleting)
-		isolcpus_updated += partition_xcpus_del(prs, NULL, tmp->delmask);
+		partition_xcpus_del(prs, NULL, tmp->delmask);
 	/*
 	 * Need to update effective_xcpus and exclusive_cpus now as
 	 * update_sibling_cpumasks() below may iterate back to the same cs.
@@ -1580,7 +1595,6 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	if (xcpus)
 		cpumask_copy(cs->exclusive_cpus, xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
 	if (adding || deleting)
 		cpuset_force_rebuild();
 
@@ -1662,7 +1676,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	int old_prs, new_prs;
 	int part_error = PERR_NONE;	/* Partition error? */
 	int subparts_delta = 0;
-	int isolcpus_updated = 0;
 	struct cpumask *xcpus = user_xcpus(cs);
 	bool nocpu;
 
@@ -1932,18 +1945,15 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	 * and vice versa.
 	 */
 	if (adding)
-		isolcpus_updated += partition_xcpus_del(old_prs, parent,
-							tmp->addmask);
+		partition_xcpus_del(old_prs, parent, tmp->addmask);
 	if (deleting)
-		isolcpus_updated += partition_xcpus_add(new_prs, parent,
-							tmp->delmask);
+		partition_xcpus_add(new_prs, parent, tmp->delmask);
 
 	if (is_partition_valid(parent)) {
 		parent->nr_subparts += subparts_delta;
 		WARN_ON_ONCE(parent->nr_subparts < 0);
 	}
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
 		update_partition_exclusive_flag(cs, new_prs);
@@ -2968,7 +2978,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	else if (isolcpus_updated)
 		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	/* Force update if switching back to member & update effective_xcpus */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs);
@@ -3224,6 +3233,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	int retval = -ENODEV;
 
 	buf = strstrip(buf);
+	mutex_lock(&isolcpus_update_mutex);
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs))
@@ -3256,6 +3266,8 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 out_unlock:
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
+	update_isolation_cpumasks();
+	mutex_unlock(&isolcpus_update_mutex);
 	flush_workqueue(cpuset_migrate_mm_wq);
 	return retval ?: nbytes;
 }
@@ -3358,12 +3370,15 @@ static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
 	else
 		return -EINVAL;
 
+	mutex_lock(&isolcpus_update_mutex);
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
 	if (is_cpuset_online(cs))
 		retval = update_prstate(cs, val);
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
+	update_isolation_cpumasks();
+	mutex_unlock(&isolcpus_update_mutex);
 	return retval ?: nbytes;
 }
 
@@ -3586,15 +3601,22 @@ static void cpuset_css_killed(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
 
+	mutex_lock(&isolcpus_update_mutex);
+	/*
+	 * Here the partition root state can't be changed by user again.
+	 */
+	if (!is_partition_valid(cs))
+		goto out;
+
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
-
 	/* Reset valid partition back to member */
-	if (is_partition_valid(cs))
-		update_prstate(cs, PRS_MEMBER);
-
+	update_prstate(cs, PRS_MEMBER);
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
+	update_isolation_cpumasks();
+out:
+	mutex_unlock(&isolcpus_update_mutex);
 
 }
 
@@ -3751,6 +3773,7 @@ int __init cpuset_init(void)
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.exclusive_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&subpartitions_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&isolated_cpus, GFP_KERNEL));
+	BUG_ON(!zalloc_cpumask_var(&isolcpus_update_state.cpus, GFP_KERNEL));
 
 	cpumask_setall(top_cpuset.cpus_allowed);
 	nodes_setall(top_cpuset.mems_allowed);
-- 
2.50.0


