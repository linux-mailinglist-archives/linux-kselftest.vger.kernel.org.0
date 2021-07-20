Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B3D3CFC23
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jul 2021 16:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbhGTNqG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jul 2021 09:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36463 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239844AbhGTNjR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jul 2021 09:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626790794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=kydm/WGOt7L+xqgLRjO/qrii4XIoUJyUJ2jQIcmKKhI=;
        b=JbWA3MWHm/4hFmqaFQ7K60N2PdZOEI0srDrSL7p3yVOK3BC3BMhjGjT75Pl6dnFqMGJwgo
        G/QK5l2nqa2AJRztR6opTqMkpAugQpOSgEFkrWhb65YLzefV9PWjgGaoRmt03c7KkmXZRO
        Gt+7mqglzk0+wRHf5HxTk+JWmyvyTC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-ASqZChOtMaub8Yl4V92dKA-1; Tue, 20 Jul 2021 10:19:53 -0400
X-MC-Unique: ASqZChOtMaub8Yl4V92dKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5894B100C662;
        Tue, 20 Jul 2021 14:19:51 +0000 (UTC)
Received: from llong.com (ovpn-116-153.rdu2.redhat.com [10.10.116.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1369369A;
        Tue, 20 Jul 2021 14:19:45 +0000 (UTC)
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
Subject: [PATCH v3 3/9] cgroup/cpuset: Fix violation of cpuset locking rule
Date:   Tue, 20 Jul 2021 10:18:28 -0400
Message-Id: <20210720141834.10624-4-longman@redhat.com>
In-Reply-To: <20210720141834.10624-1-longman@redhat.com>
References: <20210720141834.10624-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The cpuset fields that manage partition root state do not strictly
follow the cpuset locking rule that update to cpuset has to be done
with both the callback_lock and cpuset_mutex held. This is now fixed
by making sure that the locking rule is upheld.

Fixes: 3881b86128d0 ("cpuset: Add an error state to cpuset.sched.partition")
Fixes: 4b842da276a8 ("cpuset: Make CPU hotplug work with partition)
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 58 +++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b00982e6f6d8..04a6951abe2a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1148,6 +1148,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	struct cpuset *parent = parent_cs(cpuset);
 	int adding;	/* Moving cpus from effective_cpus to subparts_cpus */
 	int deleting;	/* Moving cpus from subparts_cpus to effective_cpus */
+	int new_prs;
 	bool part_error = false;	/* Partition error? */
 
 	percpu_rwsem_assert_held(&cpuset_rwsem);
@@ -1183,6 +1184,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	 * A cpumask update cannot make parent's effective_cpus become empty.
 	 */
 	adding = deleting = false;
+	new_prs = cpuset->partition_root_state;
 	if (cmd == partcmd_enable) {
 		cpumask_copy(tmp->addmask, cpuset->cpus_allowed);
 		adding = true;
@@ -1247,11 +1249,11 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		switch (cpuset->partition_root_state) {
 		case PRS_ENABLED:
 			if (part_error)
-				cpuset->partition_root_state = PRS_ERROR;
+				new_prs = PRS_ERROR;
 			break;
 		case PRS_ERROR:
 			if (!part_error)
-				cpuset->partition_root_state = PRS_ENABLED;
+				new_prs = PRS_ENABLED;
 			break;
 		}
 		/*
@@ -1260,10 +1262,10 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		part_error = (prev_prs == PRS_ERROR);
 	}
 
-	if (!part_error && (cpuset->partition_root_state == PRS_ERROR))
+	if (!part_error && (new_prs == PRS_ERROR))
 		return 0;	/* Nothing need to be done */
 
-	if (cpuset->partition_root_state == PRS_ERROR) {
+	if (new_prs == PRS_ERROR) {
 		/*
 		 * Remove all its cpus from parent's subparts_cpus.
 		 */
@@ -1272,7 +1274,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 				       parent->subparts_cpus);
 	}
 
-	if (!adding && !deleting)
+	if (!adding && !deleting && (new_prs == cpuset->partition_root_state))
 		return 0;
 
 	/*
@@ -1299,6 +1301,9 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	}
 
 	parent->nr_subparts_cpus = cpumask_weight(parent->subparts_cpus);
+
+	if (cpuset->partition_root_state != new_prs)
+		cpuset->partition_root_state = new_prs;
 	spin_unlock_irq(&callback_lock);
 
 	return cmd == partcmd_update;
@@ -1321,6 +1326,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 	struct cpuset *cp;
 	struct cgroup_subsys_state *pos_css;
 	bool need_rebuild_sched_domains = false;
+	int new_prs;
 
 	rcu_read_lock();
 	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
@@ -1360,7 +1366,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 		 * update_tasks_cpumask() again for tasks in the parent
 		 * cpuset if the parent's subparts_cpus changes.
 		 */
-		if ((cp != cs) && cp->partition_root_state) {
+		new_prs = cp->partition_root_state;
+		if ((cp != cs) && new_prs) {
 			switch (parent->partition_root_state) {
 			case PRS_DISABLED:
 				/*
@@ -1370,7 +1377,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 				 */
 				WARN_ON_ONCE(cp->partition_root_state
 					     != PRS_ERROR);
-				cp->partition_root_state = PRS_DISABLED;
+				new_prs = PRS_DISABLED;
 
 				/*
 				 * clear_bit() is an atomic operation and
@@ -1391,11 +1398,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 				/*
 				 * When parent is invalid, it has to be too.
 				 */
-				cp->partition_root_state = PRS_ERROR;
-				if (cp->nr_subparts_cpus) {
-					cp->nr_subparts_cpus = 0;
-					cpumask_clear(cp->subparts_cpus);
-				}
+				new_prs = PRS_ERROR;
 				break;
 			}
 		}
@@ -1407,8 +1410,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 		spin_lock_irq(&callback_lock);
 
 		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
-		if (cp->nr_subparts_cpus &&
-		   (cp->partition_root_state != PRS_ENABLED)) {
+		if (cp->nr_subparts_cpus && (new_prs != PRS_ENABLED)) {
 			cp->nr_subparts_cpus = 0;
 			cpumask_clear(cp->subparts_cpus);
 		} else if (cp->nr_subparts_cpus) {
@@ -1435,6 +1437,10 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 					= cpumask_weight(cp->subparts_cpus);
 			}
 		}
+
+		if (new_prs != cp->partition_root_state)
+			cp->partition_root_state = new_prs;
+
 		spin_unlock_irq(&callback_lock);
 
 		WARN_ON(!is_in_v2_mode() &&
@@ -1944,25 +1950,25 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
  */
 static int update_prstate(struct cpuset *cs, int new_prs)
 {
-	int err;
+	int err, old_prs = cs->partition_root_state;
 	struct cpuset *parent = parent_cs(cs);
 	struct tmpmasks tmpmask;
 
-	if (new_prs == cs->partition_root_state)
+	if (old_prs == new_prs)
 		return 0;
 
 	/*
 	 * Cannot force a partial or invalid partition root to a full
 	 * partition root.
 	 */
-	if (new_prs && (cs->partition_root_state < 0))
+	if (new_prs && (old_prs == PRS_ERROR))
 		return -EINVAL;
 
 	if (alloc_cpumasks(NULL, &tmpmask))
 		return -ENOMEM;
 
 	err = -EINVAL;
-	if (!cs->partition_root_state) {
+	if (!old_prs) {
 		/*
 		 * Turning on partition root requires setting the
 		 * CS_CPU_EXCLUSIVE bit implicitly as well and cpus_allowed
@@ -1981,14 +1987,12 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 			update_flag(CS_CPU_EXCLUSIVE, cs, 0);
 			goto out;
 		}
-		cs->partition_root_state = PRS_ENABLED;
 	} else {
 		/*
 		 * Turning off partition root will clear the
 		 * CS_CPU_EXCLUSIVE bit.
 		 */
-		if (cs->partition_root_state == PRS_ERROR) {
-			cs->partition_root_state = PRS_DISABLED;
+		if (old_prs == PRS_ERROR) {
 			update_flag(CS_CPU_EXCLUSIVE, cs, 0);
 			err = 0;
 			goto out;
@@ -1999,8 +2003,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		if (err)
 			goto out;
 
-		cs->partition_root_state = PRS_DISABLED;
-
 		/* Turning off CS_CPU_EXCLUSIVE will not return error */
 		update_flag(CS_CPU_EXCLUSIVE, cs, 0);
 	}
@@ -2017,6 +2019,12 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 
 	rebuild_sched_domains_locked();
 out:
+	if (!err) {
+		spin_lock_irq(&callback_lock);
+		cs->partition_root_state = new_prs;
+		spin_unlock_irq(&callback_lock);
+	}
+
 	free_cpumasks(NULL, &tmpmask);
 	return err;
 }
@@ -3080,8 +3088,10 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	if (is_partition_root(cs) && (cpumask_empty(&new_cpus) ||
 	   (parent->partition_root_state == PRS_ERROR))) {
 		if (cs->nr_subparts_cpus) {
+			spin_lock_irq(&callback_lock);
 			cs->nr_subparts_cpus = 0;
 			cpumask_clear(cs->subparts_cpus);
+			spin_unlock_irq(&callback_lock);
 			compute_effective_cpumask(&new_cpus, cs, parent);
 		}
 
@@ -3095,7 +3105,9 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		     cpumask_empty(&new_cpus)) {
 			update_parent_subparts_cpumask(cs, partcmd_disable,
 						       NULL, tmp);
+			spin_lock_irq(&callback_lock);
 			cs->partition_root_state = PRS_ERROR;
+			spin_unlock_irq(&callback_lock);
 		}
 		cpuset_force_rebuild();
 	}
-- 
2.18.1

