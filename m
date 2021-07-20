Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7833CFC2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jul 2021 16:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbhGTNqI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jul 2021 09:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239963AbhGTNjZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jul 2021 09:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626790803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=OSD1ueZb/8AiWAEOmohDX/0RCpwXdDXZ8clzlRhUsiQ=;
        b=QuVHR451Ket+QFl+wWHXkBiRdokasp9F0fl2iX9myJsbFAyZAjtv93bwhaxJF9phb2P1XU
        rVd3ZLq/FUtPV7ZTulCMAkPzZrsAB5+5IuxJyYUOzww9xtWNd7dSlhfKdiLG0DBgNArTdz
        S9h2Ye/xdGKW7FkUc2e6yYqc2X+++8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-AsULK73wOU-E_MuqCx3YSg-1; Tue, 20 Jul 2021 10:19:59 -0400
X-MC-Unique: AsULK73wOU-E_MuqCx3YSg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6BDA1005E6A;
        Tue, 20 Jul 2021 14:19:56 +0000 (UTC)
Received: from llong.com (ovpn-116-153.rdu2.redhat.com [10.10.116.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E44219C87;
        Tue, 20 Jul 2021 14:19:51 +0000 (UTC)
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
Subject: [PATCH v3 4/9] cgroup/cpuset: Enable event notification when partition become invalid
Date:   Tue, 20 Jul 2021 10:18:29 -0400
Message-Id: <20210720141834.10624-5-longman@redhat.com>
In-Reply-To: <20210720141834.10624-1-longman@redhat.com>
References: <20210720141834.10624-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A valid cpuset partition can become invalid if all its CPUs are offlined
or somehow removed. This can happen through external events without
"cpuset.cpus.partition" being touched at all.

Users that rely on the property of a partition being present do not
currently have a simple way to get such an event notified other than
constant periodic polling which is both inefficient and cumbersome.

To make life easier for those users, event notification is now enabled
for "cpuset.cpus.partition" when it goes into or out of an invalid
partition state.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 49 ++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 04a6951abe2a..2e34fc5b76f0 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -160,6 +160,9 @@ struct cpuset {
 	 */
 	int use_parent_ecpus;
 	int child_ecpus_count;
+
+	/* Handle for cpuset.cpus.partition */
+	struct cgroup_file partition_file;
 };
 
 /*
@@ -263,6 +266,19 @@ static inline int is_partition_root(const struct cpuset *cs)
 	return cs->partition_root_state > 0;
 }
 
+/*
+ * Send notification event of partition_root_state change when going into
+ * or out of PRS_ERROR which may be due to an external event like hotplug.
+ */
+static inline void notify_partition_change(struct cpuset *cs,
+					   int old_prs, int new_prs)
+{
+	if ((old_prs == new_prs) ||
+	   ((old_prs != PRS_ERROR) && (new_prs != PRS_ERROR)))
+		return;
+	cgroup_file_notify(&cs->partition_file);
+}
+
 static struct cpuset top_cpuset = {
 	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
 		  (1 << CS_MEM_EXCLUSIVE)),
@@ -1148,7 +1164,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	struct cpuset *parent = parent_cs(cpuset);
 	int adding;	/* Moving cpus from effective_cpus to subparts_cpus */
 	int deleting;	/* Moving cpus from subparts_cpus to effective_cpus */
-	int new_prs;
+	int old_prs, new_prs;
 	bool part_error = false;	/* Partition error? */
 
 	percpu_rwsem_assert_held(&cpuset_rwsem);
@@ -1184,7 +1200,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	 * A cpumask update cannot make parent's effective_cpus become empty.
 	 */
 	adding = deleting = false;
-	new_prs = cpuset->partition_root_state;
+	old_prs = new_prs = cpuset->partition_root_state;
 	if (cmd == partcmd_enable) {
 		cpumask_copy(tmp->addmask, cpuset->cpus_allowed);
 		adding = true;
@@ -1274,7 +1290,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 				       parent->subparts_cpus);
 	}
 
-	if (!adding && !deleting && (new_prs == cpuset->partition_root_state))
+	if (!adding && !deleting && (new_prs == old_prs))
 		return 0;
 
 	/*
@@ -1302,9 +1318,11 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 
 	parent->nr_subparts_cpus = cpumask_weight(parent->subparts_cpus);
 
-	if (cpuset->partition_root_state != new_prs)
+	if (old_prs != new_prs)
 		cpuset->partition_root_state = new_prs;
+
 	spin_unlock_irq(&callback_lock);
+	notify_partition_change(cpuset, old_prs, new_prs);
 
 	return cmd == partcmd_update;
 }
@@ -1326,7 +1344,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 	struct cpuset *cp;
 	struct cgroup_subsys_state *pos_css;
 	bool need_rebuild_sched_domains = false;
-	int new_prs;
+	int old_prs, new_prs;
 
 	rcu_read_lock();
 	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
@@ -1366,8 +1384,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 		 * update_tasks_cpumask() again for tasks in the parent
 		 * cpuset if the parent's subparts_cpus changes.
 		 */
-		new_prs = cp->partition_root_state;
-		if ((cp != cs) && new_prs) {
+		old_prs = new_prs = cp->partition_root_state;
+		if ((cp != cs) && old_prs) {
 			switch (parent->partition_root_state) {
 			case PRS_DISABLED:
 				/*
@@ -1438,10 +1456,11 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 			}
 		}
 
-		if (new_prs != cp->partition_root_state)
+		if (new_prs != old_prs)
 			cp->partition_root_state = new_prs;
 
 		spin_unlock_irq(&callback_lock);
+		notify_partition_change(cp, old_prs, new_prs);
 
 		WARN_ON(!is_in_v2_mode() &&
 			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
@@ -2023,6 +2042,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		spin_lock_irq(&callback_lock);
 		cs->partition_root_state = new_prs;
 		spin_unlock_irq(&callback_lock);
+		notify_partition_change(cs, old_prs, new_prs);
 	}
 
 	free_cpumasks(NULL, &tmpmask);
@@ -2708,6 +2728,7 @@ static struct cftype dfl_files[] = {
 		.write = sched_partition_write,
 		.private = FILE_PARTITION_ROOT,
 		.flags = CFTYPE_NOT_ON_ROOT,
+		.file_offset = offsetof(struct cpuset, partition_file),
 	},
 
 	{
@@ -3103,11 +3124,17 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		 */
 		if ((parent->partition_root_state == PRS_ERROR) ||
 		     cpumask_empty(&new_cpus)) {
+			int old_prs;
+
 			update_parent_subparts_cpumask(cs, partcmd_disable,
 						       NULL, tmp);
-			spin_lock_irq(&callback_lock);
-			cs->partition_root_state = PRS_ERROR;
-			spin_unlock_irq(&callback_lock);
+			old_prs = cs->partition_root_state;
+			if (old_prs != PRS_ERROR) {
+				spin_lock_irq(&callback_lock);
+				cs->partition_root_state = PRS_ERROR;
+				spin_unlock_irq(&callback_lock);
+				notify_partition_change(cs, old_prs, PRS_ERROR);
+			}
 		}
 		cpuset_force_rebuild();
 	}
-- 
2.18.1

