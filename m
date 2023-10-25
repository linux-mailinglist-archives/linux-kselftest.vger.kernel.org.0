Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E17D733C
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 20:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjJYS07 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 14:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjJYS05 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 14:26:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2383D184
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Oct 2023 11:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698258369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pRorZ8hcoh1pEKuW43vQwucWeoNUJtoP08aWtDwrATU=;
        b=TEXuIzSoK2FJxwKk3+kPQlq8LMxcDHzcw2Zo6OuoegpLLWdzp9gvvX7eEwVMxbcK9K9cjM
        FcjirjDFbAznK8eUZvbPjFzZgzXe8kFNjQHVVVTmz8m4JblC0fJ496SRd/LqXjC5sQ+Gmq
        +k6SfgWXnObACAP/ssXESkUQDE+9SlI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-XC9aC5veMSyYxf35JkLWJQ-1; Wed, 25 Oct 2023 14:26:05 -0400
X-MC-Unique: XC9aC5veMSyYxf35JkLWJQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 536AD101A550;
        Wed, 25 Oct 2023 18:26:04 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A246E492BFA;
        Wed, 25 Oct 2023 18:26:03 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Hunt <pehunt@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 4/4] cgroup/cpuset: Take isolated CPUs out of workqueue unbound cpumask
Date:   Wed, 25 Oct 2023 14:25:55 -0400
Message-Id: <20231025182555.4155614-5-longman@redhat.com>
In-Reply-To: <20231025182555.4155614-1-longman@redhat.com>
References: <20231025182555.4155614-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To make CPUs in isolated cpuset partition closer in isolation to
the boot time isolated CPUs specified in the "isolcpus" boot command
line option, we need to take those CPUs out of the workqueue unbound
cpumask so that work functions from the unbound workqueues won't run
on those CPUs.  Otherwise, they will interfere the user tasks running
on those isolated CPUs.

With the introduction of the workqueue_unbound_exclude_cpumask() helper
function in an earlier commit, those isolated CPUs can now be taken
out from the workqueue unbound cpumask.

This patch also updates cgroup-v2.rst to mention that isolated
CPUs will be excluded from unbound workqueue cpumask as well as
updating test_cpuset_prs.sh to verify the correctness of the new
*cpuset.cpus.isolated file, if available via cgroup_debug option.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst       |  10 +-
 kernel/cgroup/cpuset.c                        | 116 +++++++++++++++---
 .../selftests/cgroup/test_cpuset_prs.sh       |  74 +++++++++--
 3 files changed, 166 insertions(+), 34 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index e440aee4fe94..9db311448a21 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2318,11 +2318,11 @@ Cpuset Interface Files
 	partition or scheduling domain.  The set of exclusive CPUs is
 	determined by the value of its "cpuset.cpus.exclusive.effective".
 
-	When set to "isolated", the CPUs in that partition will
-	be in an isolated state without any load balancing from the
-	scheduler.  Tasks placed in such a partition with multiple
-	CPUs should be carefully distributed and bound to each of the
-	individual CPUs for optimal performance.
+	When set to "isolated", the CPUs in that partition will be in
+	an isolated state without any load balancing from the scheduler
+	and excluded from the unbound workqueues.  Tasks placed in such
+	a partition with multiple CPUs should be carefully distributed
+	and bound to each of the individual CPUs for optimal performance.
 
 	A partition root ("root" or "isolated") can be in one of the
 	two possible states - valid or invalid.  An invalid partition
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 19c8779798fd..1bad4007ff4b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -25,6 +25,7 @@
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/cpuset.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -43,6 +44,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/cgroup.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 
 DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
 DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
@@ -1444,25 +1446,31 @@ static void partition_xcpus_newstate(int old_prs, int new_prs, struct cpumask *x
  * @new_prs: new partition_root_state
  * @parent: parent cpuset
  * @xcpus: exclusive CPUs to be added
+ * Return: true if isolated_cpus modified, false otherwise
  *
  * Remote partition if parent == NULL
  */
-static void partition_xcpus_add(int new_prs, struct cpuset *parent,
+static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
 				struct cpumask *xcpus)
 {
+	bool isolcpus_updated;
+
 	WARN_ON_ONCE(new_prs < 0);
 	lockdep_assert_held(&callback_lock);
 	if (!parent)
 		parent = &top_cpuset;
 
+
 	if (parent == &top_cpuset)
 		cpumask_or(subpartitions_cpus, subpartitions_cpus, xcpus);
 
-	if (new_prs != parent->partition_root_state)
+	isolcpus_updated = (new_prs != parent->partition_root_state);
+	if (isolcpus_updated)
 		partition_xcpus_newstate(parent->partition_root_state, new_prs,
 					 xcpus);
 
 	cpumask_andnot(parent->effective_cpus, parent->effective_cpus, xcpus);
+	return isolcpus_updated;
 }
 
 /*
@@ -1470,12 +1478,15 @@ static void partition_xcpus_add(int new_prs, struct cpuset *parent,
  * @old_prs: old partition_root_state
  * @parent: parent cpuset
  * @xcpus: exclusive CPUs to be removed
+ * Return: true if isolated_cpus modified, false otherwise
  *
  * Remote partition if parent == NULL
  */
-static void partition_xcpus_del(int old_prs, struct cpuset *parent,
+static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 				struct cpumask *xcpus)
 {
+	bool isolcpus_updated;
+
 	WARN_ON_ONCE(old_prs < 0);
 	lockdep_assert_held(&callback_lock);
 	if (!parent)
@@ -1484,12 +1495,27 @@ static void partition_xcpus_del(int old_prs, struct cpuset *parent,
 	if (parent == &top_cpuset)
 		cpumask_andnot(subpartitions_cpus, subpartitions_cpus, xcpus);
 
-	if (old_prs != parent->partition_root_state)
+	isolcpus_updated = (old_prs != parent->partition_root_state);
+	if (isolcpus_updated)
 		partition_xcpus_newstate(old_prs, parent->partition_root_state,
 					 xcpus);
 
 	cpumask_and(xcpus, xcpus, cpu_active_mask);
 	cpumask_or(parent->effective_cpus, parent->effective_cpus, xcpus);
+	return isolcpus_updated;
+}
+
+static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
+{
+	int ret;
+
+	lockdep_assert_cpus_held();
+
+	if (!isolcpus_updated)
+		return;
+
+	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
+	WARN_ON_ONCE(ret < 0);
 }
 
 /*
@@ -1540,6 +1566,8 @@ static inline bool is_local_partition(struct cpuset *cs)
 static int remote_partition_enable(struct cpuset *cs, int new_prs,
 				   struct tmpmasks *tmp)
 {
+	bool isolcpus_updated;
+
 	/*
 	 * The user must have sysadmin privilege.
 	 */
@@ -1561,7 +1589,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 		return 0;
 
 	spin_lock_irq(&callback_lock);
-	partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
+	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
 	list_add(&cs->remote_sibling, &remote_children);
 	if (cs->use_parent_ecpus) {
 		struct cpuset *parent = parent_cs(cs);
@@ -1570,13 +1598,13 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 		parent->child_ecpus_count--;
 	}
 	spin_unlock_irq(&callback_lock);
+	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	/*
 	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
 	 */
 	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
 	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
-
 	return 1;
 }
 
@@ -1591,18 +1619,22 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
  */
 static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 {
+	bool isolcpus_updated;
+
 	compute_effective_exclusive_cpumask(cs, tmp->new_cpus);
 	WARN_ON_ONCE(!is_remote_partition(cs));
 	WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, subpartitions_cpus));
 
 	spin_lock_irq(&callback_lock);
 	list_del_init(&cs->remote_sibling);
-	partition_xcpus_del(cs->partition_root_state, NULL, tmp->new_cpus);
+	isolcpus_updated = partition_xcpus_del(cs->partition_root_state,
+					       NULL, tmp->new_cpus);
 	cs->partition_root_state = -cs->partition_root_state;
 	if (!cs->prs_err)
 		cs->prs_err = PERR_INVCPUS;
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
+	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	/*
 	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
@@ -1625,6 +1657,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 {
 	bool adding, deleting;
 	int prs = cs->partition_root_state;
+	int isolcpus_updated = 0;
 
 	if (WARN_ON_ONCE(!is_remote_partition(cs)))
 		return;
@@ -1649,10 +1682,11 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 
 	spin_lock_irq(&callback_lock);
 	if (adding)
-		partition_xcpus_add(prs, NULL, tmp->addmask);
+		isolcpus_updated += partition_xcpus_add(prs, NULL, tmp->addmask);
 	if (deleting)
-		partition_xcpus_del(prs, NULL, tmp->delmask);
+		isolcpus_updated += partition_xcpus_del(prs, NULL, tmp->delmask);
 	spin_unlock_irq(&callback_lock);
+	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	/*
 	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
@@ -1774,6 +1808,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	int part_error = PERR_NONE;	/* Partition error? */
 	int subparts_delta = 0;
 	struct cpumask *xcpus;		/* cs effective_xcpus */
+	int isolcpus_updated = 0;
 	bool nocpu;
 
 	lockdep_assert_held(&cpuset_mutex);
@@ -2010,15 +2045,18 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	 * and vice versa.
 	 */
 	if (adding)
-		partition_xcpus_del(old_prs, parent, tmp->addmask);
+		isolcpus_updated += partition_xcpus_del(old_prs, parent,
+							tmp->addmask);
 	if (deleting)
-		partition_xcpus_add(new_prs, parent, tmp->delmask);
+		isolcpus_updated += partition_xcpus_add(new_prs, parent,
+							tmp->delmask);
 
 	if (is_partition_valid(parent)) {
 		parent->nr_subparts += subparts_delta;
 		WARN_ON_ONCE(parent->nr_subparts < 0);
 	}
 	spin_unlock_irq(&callback_lock);
+	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
 		update_partition_exclusive(cs, new_prs);
@@ -3082,6 +3120,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	else if (new_xcpus_state)
 		partition_xcpus_newstate(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
+	update_unbound_workqueue_cpumask(new_xcpus_state);
 
 	/* Force update if switching back to member */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs ? HIER_CHECKALL : 0);
@@ -4370,6 +4409,30 @@ void cpuset_force_rebuild(void)
 	force_rebuild = true;
 }
 
+/*
+ * Attempt to acquire a cpus_read_lock while a hotplug operation may be in
+ * progress.
+ * Return: true if successful, false otherwise
+ *
+ * To avoid circular lock dependency between cpuset_mutex and cpus_read_lock,
+ * cpus_read_trylock() is used here to acquire the lock.
+ */
+static bool cpuset_hotplug_cpus_read_trylock(void)
+{
+	int retries = 0;
+
+	while (!cpus_read_trylock()) {
+		/*
+		 * CPU hotplug still in progress. Retry 5 times
+		 * with a 10ms wait before bailing out.
+		 */
+		if (++retries > 5)
+			return false;
+		msleep(10);
+	}
+	return true;
+}
+
 /**
  * cpuset_hotplug_update_tasks - update tasks in a cpuset for hotunplug
  * @cs: cpuset in interest
@@ -4386,6 +4449,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	bool cpus_updated;
 	bool mems_updated;
 	bool remote;
+	int partcmd = -1;
 	struct cpuset *parent;
 retry:
 	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
@@ -4417,11 +4481,13 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		compute_partition_effective_cpumask(cs, &new_cpus);
 
 	if (remote && cpumask_empty(&new_cpus) &&
-	    partition_is_populated(cs, NULL)) {
+	    partition_is_populated(cs, NULL) &&
+	    cpuset_hotplug_cpus_read_trylock()) {
 		remote_partition_disable(cs, tmp);
 		compute_effective_cpumask(&new_cpus, cs, parent);
 		remote = false;
 		cpuset_force_rebuild();
+		cpus_read_unlock();
 	}
 
 	/*
@@ -4432,18 +4498,28 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 *    partitions.
 	 */
 	if (is_local_partition(cs) && (!is_partition_valid(parent) ||
-				tasks_nocpu_error(parent, cs, &new_cpus))) {
-		update_parent_effective_cpumask(cs, partcmd_invalidate, NULL, tmp);
-		compute_effective_cpumask(&new_cpus, cs, parent);
-		cpuset_force_rebuild();
-	}
+				tasks_nocpu_error(parent, cs, &new_cpus)))
+		partcmd = partcmd_invalidate;
 	/*
 	 * On the other hand, an invalid partition root may be transitioned
 	 * back to a regular one.
 	 */
-	else if (is_partition_valid(parent) && is_partition_invalid(cs)) {
-		update_parent_effective_cpumask(cs, partcmd_update, NULL, tmp);
-		if (is_partition_valid(cs)) {
+	else if (is_partition_valid(parent) && is_partition_invalid(cs))
+		partcmd = partcmd_update;
+
+	/*
+	 * cpus_read_lock needs to be held before calling
+	 * update_parent_effective_cpumask(). To avoid circular lock
+	 * dependency between cpuset_mutex and cpus_read_lock,
+	 * cpus_read_trylock() is used here to acquire the lock.
+	 */
+	if (partcmd >= 0) {
+		if (!cpuset_hotplug_cpus_read_trylock())
+			goto update_tasks;
+
+		update_parent_effective_cpumask(cs, partcmd, NULL, tmp);
+		cpus_read_unlock();
+		if ((partcmd == partcmd_invalidate) || is_partition_valid(cs)) {
 			compute_partition_effective_cpumask(cs, &new_cpus);
 			cpuset_force_rebuild();
 		}
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 2b825019f806..7b7c4c2b6d85 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -232,11 +232,11 @@ TEST_MATRIX=(
 	" C0-3:S+ C1-3:S+ C2-3   C4-5   X2-3  X2-3:P1   P2     P1    0 A1:0-1,A2:,A3:2-3,B1:4-5 \
 								       A1:P0,A2:P1,A3:P2,B1:P1 2-3"
 	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3  X2-3:P1   P2     P1    0 A1:0-1,A2:,A3:2-3,B1:4 \
-								       A1:P0,A2:P1,A3:P2,B1:P1 2-4"
+								       A1:P0,A2:P1,A3:P2,B1:P1 2-4,2-3"
 	" C0-3:S+ C1-3:S+  C3     C4    X2-3  X2-3:P1   P2     P1    0 A1:0-1,A2:2,A3:3,B1:4 \
-								       A1:P0,A2:P1,A3:P2,B1:P1 2-4"
+								       A1:P0,A2:P1,A3:P2,B1:P1 2-4,3"
 	" C0-4:S+ C1-4:S+ C2-4     .    X2-4  X2-4:P2  X4:P1    .    0 A1:0-1,A2:2-3,A3:4 \
-								       A1:P0,A2:P2,A3:P1 2-4"
+								       A1:P0,A2:P2,A3:P1 2-4,2-3"
 	" C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 \
 				   .      .      X5      .      .    0 A1:0-4,A2:1-4,A3:2-4 \
 								       A1:P0,A2:P-2,A3:P-1"
@@ -248,7 +248,7 @@ TEST_MATRIX=(
 	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 .   0 A1:0-1,A2:1,A3:3 A1:P0,A3:P2 2-3"
 	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 O2=1 0 A1:0-1,A2:1,A3:2-3 A1:P0,A3:P2 2-3"
 	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3    P2:O3=0   .   0 A1:0-2,A2:1-2,A3: A1:P0,A3:P2 3"
-	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3   T:P2:O3=0  .   0 A1:0-2,A2:1-2,A3:1-2 A1:P0,A3:P-2 3"
+	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3   T:P2:O3=0  .   0 A1:0-2,A2:1-2,A3:1-2 A1:P0,A3:P-2 3,"
 
 	# An invalidated remote partition cannot self-recover from hotplug
 	" C0-3:S+ C1-3:S+  C2      .    X2-3   X2-3   T:P2:O2=0 O2=1 0 A1:0-3,A2:1-3,A3:2 A1:P0,A3:P-2"
@@ -376,7 +376,7 @@ write_cpu_online()
 		}
 	fi
 	echo $VAL > $CPUFILE
-	pause 0.01
+	pause 0.05
 }
 
 #
@@ -508,12 +508,14 @@ dump_states()
 		XECPUS=$DIR/cpuset.cpus.exclusive.effective
 		PRS=$DIR/cpuset.cpus.partition
 		PCPUS=$DIR/.__DEBUG__.cpuset.cpus.subpartitions
+		ISCPUS=$DIR/.__DEBUG__.cpuset.cpus.isolated
 		[[ -e $CPUS   ]] && echo "$CPUS: $(cat $CPUS)"
 		[[ -e $XCPUS  ]] && echo "$XCPUS: $(cat $XCPUS)"
 		[[ -e $ECPUS  ]] && echo "$ECPUS: $(cat $ECPUS)"
 		[[ -e $XECPUS ]] && echo "$XECPUS: $(cat $XECPUS)"
 		[[ -e $PRS    ]] && echo "$PRS: $(cat $PRS)"
 		[[ -e $PCPUS  ]] && echo "$PCPUS: $(cat $PCPUS)"
+		[[ -e $ISCPUS ]] && echo "$ISCPUS: $(cat $ISCPUS)"
 	done
 }
 
@@ -591,11 +593,17 @@ check_cgroup_states()
 
 #
 # Get isolated (including offline) CPUs by looking at
-# /sys/kernel/debug/sched/domains and compare that with the expected value.
+# /sys/kernel/debug/sched/domains and *cpuset.cpus.isolated control file,
+# if available, and compare that with the expected value.
 #
-# Note that a sched domain of just 1 CPU will be considered isolated.
+# Note that isolated CPUs from the sched/domains context include offline
+# CPUs as well as CPUs in non-isolated 1-CPU partition. Those CPUs may
+# not be included in the *cpuset.cpus.isolated control file which contains
+# only CPUs in isolated partitions.
 #
-# $1 - expected isolated cpu list
+# $1 - expected isolated cpu list(s) <isolcpus1>{,<isolcpus2>}
+# <isolcpus1> - expected sched/domains value
+# <isolcpus2> - *cpuset.cpus.isolated value = <isolcpus1> if not defined
 #
 check_isolcpus()
 {
@@ -603,8 +611,38 @@ check_isolcpus()
 	ISOLCPUS=
 	LASTISOLCPU=
 	SCHED_DOMAINS=/sys/kernel/debug/sched/domains
+	ISCPUS=${CGROUP2}/.__DEBUG__.cpuset.cpus.isolated
+	if [[ $EXPECT_VAL = . ]]
+	then
+		EXPECT_VAL=
+		EXPECT_VAL2=
+	elif [[ $(expr $EXPECT_VAL : ".*,.*") > 0 ]]
+	then
+		set -- $(echo $EXPECT_VAL | sed -e "s/,/ /g")
+		EXPECT_VAL=$1
+		EXPECT_VAL2=$2
+	else
+		EXPECT_VAL2=$EXPECT_VAL
+	fi
+
+	#
+	# Check the debug isolated cpumask, if present
+	#
+	[[ -f $ISCPUS ]] && {
+		ISOLCPUS=$(cat $ISCPUS)
+		[[ "$EXPECT_VAL2" != "$ISOLCPUS" ]] && {
+			# Take a 50ms pause and try again
+			pause 0.05
+			ISOLCPUS=$(cat $ISCPUS)
+		}
+		[[ "$EXPECT_VAL2" != "$ISOLCPUS" ]] && return 1
+		ISOLCPUS=
+	}
+
+	#
+	# Use the sched domain in debugfs to check isolated CPUs, if available
+	#
 	[[ -d $SCHED_DOMAINS ]] || return 0
-	[[ $EXPECT_VAL = . ]] && EXPECT_VAL=
 
 	for ((CPU=0; CPU < $NR_CPUS; CPU++))
 	do
@@ -648,6 +686,22 @@ test_fail()
 	exit 1
 }
 
+#
+# Check to see if there are unexpected isolated CPUs left
+#
+null_isolcpus_check()
+{
+	[[ $VERBOSE -gt 0 ]] || return 0
+	pause 0.02
+	check_isolcpus "."
+	if [[ $? -ne 0 ]]
+	then
+		echo "Unexpected isolated CPUs: $ISOLCPUS"
+		dump_states
+		exit 1
+	fi
+}
+
 #
 # Run cpuset state transition test
 #  $1 - test matrix name
@@ -733,6 +787,7 @@ run_state_test()
 			echo "Effective cpus changed to $NEWLIST after test $I!"
 			exit 1
 		}
+		null_isolcpus_check
 		[[ $VERBOSE -gt 0 ]] && echo "Test $I done."
 		((I++))
 	done
@@ -802,6 +857,7 @@ test_isolated()
 	console_msg "Cleaning up"
 	echo $$ > $CGROUP2/cgroup.procs
 	[[ -d A1 ]] && rmdir A1
+	null_isolcpus_check
 }
 
 #
-- 
2.39.3

