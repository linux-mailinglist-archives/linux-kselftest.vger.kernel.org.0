Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2583E889C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 05:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhHKDHJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Aug 2021 23:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232994AbhHKDHI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Aug 2021 23:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628651205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=rxmUDgi/eSAWBp+aX5tEZpY9hepwTSXrcnetuW0lBu8=;
        b=TcGoTsS+EMliZJRf4cQkAnhvOB97Z5AQTFPH/prk7Q374QYVfKvs/iMPPFX/22yAuzHgaR
        Bonq+69fmr+JMp2sg6FnWrvhdZcbHvnw+qfVH61rbXD+Z6tRgofjyflK/XXUWvloH/NubE
        +2HTWZ86YpiUqn2Im6JZiAs+KJ049yI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-iVwq80K7Nh6Y_EPgqaPVQQ-1; Tue, 10 Aug 2021 23:06:42 -0400
X-MC-Unique: iVwq80K7Nh6Y_EPgqaPVQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7563A107ACF5;
        Wed, 11 Aug 2021 03:06:40 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04ACB669ED;
        Wed, 11 Aug 2021 03:06:37 +0000 (UTC)
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
Subject: [PATCH v4 1/6] cgroup/cpuset: Enable event notification when partition state changes
Date:   Tue, 10 Aug 2021 23:06:02 -0400
Message-Id: <20210811030607.13824-2-longman@redhat.com>
In-Reply-To: <20210811030607.13824-1-longman@redhat.com>
References: <20210811030607.13824-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
for "cpuset.cpus.partition" whenever its state changes.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 46 ++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 65258102e030..fcc11f2d3b5b 100644
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
@@ -263,6 +266,16 @@ static inline int is_partition_root(const struct cpuset *cs)
 	return cs->partition_root_state > 0;
 }
 
+/*
+ * Send notification event of whenever partition_root_state changes.
+ */
+static inline void notify_partition_change(struct cpuset *cs,
+					   int old_prs, int new_prs)
+{
+	if (old_prs != new_prs)
+		cgroup_file_notify(&cs->partition_file);
+}
+
 static struct cpuset top_cpuset = {
 	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
 		  (1 << CS_MEM_EXCLUSIVE)),
@@ -1148,7 +1161,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	struct cpuset *parent = parent_cs(cpuset);
 	int adding;	/* Moving cpus from effective_cpus to subparts_cpus */
 	int deleting;	/* Moving cpus from subparts_cpus to effective_cpus */
-	int new_prs;
+	int old_prs, new_prs;
 	bool part_error = false;	/* Partition error? */
 
 	percpu_rwsem_assert_held(&cpuset_rwsem);
@@ -1184,7 +1197,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	 * A cpumask update cannot make parent's effective_cpus become empty.
 	 */
 	adding = deleting = false;
-	new_prs = cpuset->partition_root_state;
+	old_prs = new_prs = cpuset->partition_root_state;
 	if (cmd == partcmd_enable) {
 		cpumask_copy(tmp->addmask, cpuset->cpus_allowed);
 		adding = true;
@@ -1274,7 +1287,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 				       parent->subparts_cpus);
 	}
 
-	if (!adding && !deleting && (new_prs == cpuset->partition_root_state))
+	if (!adding && !deleting && (new_prs == old_prs))
 		return 0;
 
 	/*
@@ -1302,9 +1315,11 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 
 	parent->nr_subparts_cpus = cpumask_weight(parent->subparts_cpus);
 
-	if (cpuset->partition_root_state != new_prs)
+	if (old_prs != new_prs)
 		cpuset->partition_root_state = new_prs;
+
 	spin_unlock_irq(&callback_lock);
+	notify_partition_change(cpuset, old_prs, new_prs);
 
 	return cmd == partcmd_update;
 }
@@ -1326,7 +1341,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 	struct cpuset *cp;
 	struct cgroup_subsys_state *pos_css;
 	bool need_rebuild_sched_domains = false;
-	int new_prs;
+	int old_prs, new_prs;
 
 	rcu_read_lock();
 	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
@@ -1366,8 +1381,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
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
@@ -1438,10 +1453,11 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 			}
 		}
 
-		if (new_prs != cp->partition_root_state)
+		if (new_prs != old_prs)
 			cp->partition_root_state = new_prs;
 
 		spin_unlock_irq(&callback_lock);
+		notify_partition_change(cp, old_prs, new_prs);
 
 		WARN_ON(!is_in_v2_mode() &&
 			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
@@ -2023,6 +2039,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		spin_lock_irq(&callback_lock);
 		cs->partition_root_state = new_prs;
 		spin_unlock_irq(&callback_lock);
+		notify_partition_change(cs, old_prs, new_prs);
 	}
 
 	free_cpumasks(NULL, &tmpmask);
@@ -2708,6 +2725,7 @@ static struct cftype dfl_files[] = {
 		.write = sched_partition_write,
 		.private = FILE_PARTITION_ROOT,
 		.flags = CFTYPE_NOT_ON_ROOT,
+		.file_offset = offsetof(struct cpuset, partition_file),
 	},
 
 	{
@@ -3103,11 +3121,17 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
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

