Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22955189AC
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 May 2022 18:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbiECQ0j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 12:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239396AbiECQ0a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 12:26:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C7F73A5C2
        for <linux-kselftest@vger.kernel.org>; Tue,  3 May 2022 09:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651594975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PNnKWWk7Jmb907Uh0WEG8kZc964QPOGA4FR9wyuTc4M=;
        b=Pwn0g133awaewiEpcTGLpQsajnGi9T7wD+46pTlXKRQixODVQFAAl0jPy0LIiljk3c3zb3
        FAkPXnloJvhgSwwvdA5P8oUwmLH7cJ2qxMhpudLAFGQtAy2CmgwaPLi9WFgQIVT4MP5z9G
        NwB3r46O9N/5xs9ozqQO3kA8T7JKxI4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-pmewUMi5OqeBl9KZ8-rD-A-1; Tue, 03 May 2022 12:22:38 -0400
X-MC-Unique: pmewUMi5OqeBl9KZ8-rD-A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E3433C025B2;
        Tue,  3 May 2022 16:22:38 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F310403373;
        Tue,  3 May 2022 16:22:37 +0000 (UTC)
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
Subject: [PATCH v10 2/8] cgroup/cpuset: Miscellaneous cleanups & add helper functions
Date:   Tue,  3 May 2022 12:21:43 -0400
Message-Id: <20220503162149.1764245-3-longman@redhat.com>
In-Reply-To: <20220503162149.1764245-1-longman@redhat.com>
References: <20220503162149.1764245-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The partition root state (PRS) macro names do not currently match the
external names. Change them to match the external names and add helper
functions to read or change the state.

Shorten the cpuset argument of update_parent_subparts_cpumask() to cs
to match other cpuset functions.

Remove the new_prs argument from notify_partition_change() as the
cs->partition_root_state has already been set to new_prs before it
is called.

There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 165 +++++++++++++++++++++--------------------
 1 file changed, 86 insertions(+), 79 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d90f33b068a3..d156a39d7a08 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -175,20 +175,18 @@ struct cpuset {
 /*
  * Partition root states:
  *
- *   0 - not a partition root
- *
+ *   0 - member (not a partition root)
  *   1 - partition root
- *
  *  -1 - invalid partition root
- *       None of the cpus in cpus_allowed can be put into the parent's
- *       subparts_cpus. In this case, the cpuset is not a real partition
- *       root anymore.  However, the CPU_EXCLUSIVE bit will still be set
- *       and the cpuset can be restored back to a partition root if the
- *       parent cpuset can give more CPUs back to this child cpuset.
  */
-#define PRS_DISABLED		0
-#define PRS_ENABLED		1
-#define PRS_ERROR		-1
+#define PRS_MEMBER		0
+#define PRS_ROOT		1
+#define PRS_INVALID_ROOT	-1
+
+static inline bool is_prs_invalid(int prs_state)
+{
+	return prs_state < 0;
+}
 
 /*
  * Temporary cpumasks for working with partitions that are passed among
@@ -268,25 +266,35 @@ static inline int is_spread_slab(const struct cpuset *cs)
 	return test_bit(CS_SPREAD_SLAB, &cs->flags);
 }
 
-static inline int is_partition_root(const struct cpuset *cs)
+static inline int is_partition_valid(const struct cpuset *cs)
 {
 	return cs->partition_root_state > 0;
 }
 
+static inline int is_partition_invalid(const struct cpuset *cs)
+{
+	return cs->partition_root_state < 0;
+}
+
+static inline void set_partition_invalid(struct cpuset *cs)
+{
+	cs->partition_root_state = PRS_INVALID_ROOT;
+}
+
 /*
  * Send notification event of whenever partition_root_state changes.
  */
-static inline void notify_partition_change(struct cpuset *cs,
-					   int old_prs, int new_prs)
+static inline void notify_partition_change(struct cpuset *cs, int old_prs)
 {
-	if (old_prs != new_prs)
-		cgroup_file_notify(&cs->partition_file);
+	if (old_prs == cs->partition_root_state)
+		return;
+	cgroup_file_notify(&cs->partition_file);
 }
 
 static struct cpuset top_cpuset = {
 	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
 		  (1 << CS_MEM_EXCLUSIVE)),
-	.partition_root_state = PRS_ENABLED,
+	.partition_root_state = PRS_ROOT,
 };
 
 /**
@@ -875,7 +883,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 			csa[csn++] = cp;
 
 		/* skip @cp's subtree if not a partition root */
-		if (!is_partition_root(cp))
+		if (!is_partition_valid(cp))
 			pos_css = css_rightmost_descendant(pos_css);
 	}
 	rcu_read_unlock();
@@ -1081,7 +1089,7 @@ static void rebuild_sched_domains_locked(void)
 	if (top_cpuset.nr_subparts_cpus) {
 		rcu_read_lock();
 		cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
-			if (!is_partition_root(cs)) {
+			if (!is_partition_valid(cs)) {
 				pos_css = css_rightmost_descendant(pos_css);
 				continue;
 			}
@@ -1215,11 +1223,11 @@ enum subparts_cmd {
  * cpumask changes that violates the cpu exclusivity rule will not be
  * permitted when checked by validate_change().
  */
-static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
+static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 					  struct cpumask *newmask,
 					  struct tmpmasks *tmp)
 {
-	struct cpuset *parent = parent_cs(cpuset);
+	struct cpuset *parent = parent_cs(cs);
 	int adding;	/* Moving cpus from effective_cpus to subparts_cpus */
 	int deleting;	/* Moving cpus from subparts_cpus to effective_cpus */
 	int old_prs, new_prs;
@@ -1232,16 +1240,16 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	 * The new cpumask, if present, or the current cpus_allowed must
 	 * not be empty.
 	 */
-	if (!is_partition_root(parent) ||
+	if (!is_partition_valid(parent) ||
 	   (newmask && cpumask_empty(newmask)) ||
-	   (!newmask && cpumask_empty(cpuset->cpus_allowed)))
+	   (!newmask && cpumask_empty(cs->cpus_allowed)))
 		return -EINVAL;
 
 	/*
 	 * Enabling/disabling partition root is not allowed if there are
 	 * online children.
 	 */
-	if ((cmd != partcmd_update) && css_has_online_children(&cpuset->css))
+	if ((cmd != partcmd_update) && css_has_online_children(&cs->css))
 		return -EBUSY;
 
 	/*
@@ -1250,20 +1258,20 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	 * CPU will be left after that.
 	 */
 	if ((cmd == partcmd_enable) &&
-	   (!cpumask_subset(cpuset->cpus_allowed, parent->effective_cpus) ||
-	     cpumask_equal(cpuset->cpus_allowed, parent->effective_cpus)))
+	   (!cpumask_subset(cs->cpus_allowed, parent->effective_cpus) ||
+	     cpumask_equal(cs->cpus_allowed, parent->effective_cpus)))
 		return -EINVAL;
 
 	/*
 	 * A cpumask update cannot make parent's effective_cpus become empty.
 	 */
 	adding = deleting = false;
-	old_prs = new_prs = cpuset->partition_root_state;
+	old_prs = new_prs = cs->partition_root_state;
 	if (cmd == partcmd_enable) {
-		cpumask_copy(tmp->addmask, cpuset->cpus_allowed);
+		cpumask_copy(tmp->addmask, cs->cpus_allowed);
 		adding = true;
 	} else if (cmd == partcmd_disable) {
-		deleting = cpumask_and(tmp->delmask, cpuset->cpus_allowed,
+		deleting = cpumask_and(tmp->delmask, cs->cpus_allowed,
 				       parent->subparts_cpus);
 	} else if (newmask) {
 		/*
@@ -1273,7 +1281,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		 * addmask = newmask & parent->effective_cpus
 		 *		     & ~parent->subparts_cpus
 		 */
-		cpumask_andnot(tmp->delmask, cpuset->cpus_allowed, newmask);
+		cpumask_andnot(tmp->delmask, cs->cpus_allowed, newmask);
 		deleting = cpumask_and(tmp->delmask, tmp->delmask,
 				       parent->subparts_cpus);
 
@@ -1307,44 +1315,44 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		 * pre-shrunk in case there is a change in the cpu list.
 		 * So no deletion is needed.
 		 */
-		adding = cpumask_and(tmp->addmask, cpuset->cpus_allowed,
+		adding = cpumask_and(tmp->addmask, cs->cpus_allowed,
 				     parent->effective_cpus);
 		part_error = cpumask_equal(tmp->addmask,
 					   parent->effective_cpus);
 	}
 
 	if (cmd == partcmd_update) {
-		int prev_prs = cpuset->partition_root_state;
+		int prev_prs = cs->partition_root_state;
 
 		/*
-		 * Check for possible transition between PRS_ENABLED
-		 * and PRS_ERROR.
+		 * Check for possible transition between PRS_ROOT
+		 * and PRS_INVALID_ROOT.
 		 */
-		switch (cpuset->partition_root_state) {
-		case PRS_ENABLED:
+		switch (cs->partition_root_state) {
+		case PRS_ROOT:
 			if (part_error)
-				new_prs = PRS_ERROR;
+				new_prs = PRS_INVALID_ROOT;
 			break;
-		case PRS_ERROR:
+		case PRS_INVALID_ROOT:
 			if (!part_error)
-				new_prs = PRS_ENABLED;
+				new_prs = PRS_ROOT;
 			break;
 		}
 		/*
 		 * Set part_error if previously in invalid state.
 		 */
-		part_error = (prev_prs == PRS_ERROR);
+		part_error = is_prs_invalid(prev_prs);
 	}
 
-	if (!part_error && (new_prs == PRS_ERROR))
+	if (!part_error && is_prs_invalid(new_prs))
 		return 0;	/* Nothing need to be done */
 
-	if (new_prs == PRS_ERROR) {
+	if (is_prs_invalid(new_prs)) {
 		/*
 		 * Remove all its cpus from parent's subparts_cpus.
 		 */
 		adding = false;
-		deleting = cpumask_and(tmp->delmask, cpuset->cpus_allowed,
+		deleting = cpumask_and(tmp->delmask, cs->cpus_allowed,
 				       parent->subparts_cpus);
 	}
 
@@ -1377,10 +1385,10 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	parent->nr_subparts_cpus = cpumask_weight(parent->subparts_cpus);
 
 	if (old_prs != new_prs)
-		cpuset->partition_root_state = new_prs;
+		cs->partition_root_state = new_prs;
 
 	spin_unlock_irq(&callback_lock);
-	notify_partition_change(cpuset, old_prs, new_prs);
+	notify_partition_change(cs, old_prs);
 
 	return cmd == partcmd_update;
 }
@@ -1445,15 +1453,14 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 		old_prs = new_prs = cp->partition_root_state;
 		if ((cp != cs) && old_prs) {
 			switch (parent->partition_root_state) {
-			case PRS_DISABLED:
+			case PRS_MEMBER:
 				/*
 				 * If parent is not a partition root or an
 				 * invalid partition root, clear its state
 				 * and its CS_CPU_EXCLUSIVE flag.
 				 */
-				WARN_ON_ONCE(cp->partition_root_state
-					     != PRS_ERROR);
-				new_prs = PRS_DISABLED;
+				WARN_ON_ONCE(!is_partition_invalid(cp));
+				new_prs = PRS_MEMBER;
 
 				/*
 				 * clear_bit() is an atomic operation and
@@ -1465,16 +1472,16 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 				clear_bit(CS_CPU_EXCLUSIVE, &cp->flags);
 				break;
 
-			case PRS_ENABLED:
+			case PRS_ROOT:
 				if (update_parent_subparts_cpumask(cp, partcmd_update, NULL, tmp))
 					update_tasks_cpumask(parent);
 				break;
 
-			case PRS_ERROR:
+			case PRS_INVALID_ROOT:
 				/*
 				 * When parent is invalid, it has to be too.
 				 */
-				new_prs = PRS_ERROR;
+				new_prs = PRS_INVALID_ROOT;
 				break;
 			}
 		}
@@ -1486,7 +1493,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 		spin_lock_irq(&callback_lock);
 
 		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
-		if (cp->nr_subparts_cpus && (new_prs != PRS_ENABLED)) {
+		if (cp->nr_subparts_cpus && !is_partition_valid(cp)) {
 			cp->nr_subparts_cpus = 0;
 			cpumask_clear(cp->subparts_cpus);
 		} else if (cp->nr_subparts_cpus) {
@@ -1518,7 +1525,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 			cp->partition_root_state = new_prs;
 
 		spin_unlock_irq(&callback_lock);
-		notify_partition_change(cp, old_prs, new_prs);
+		notify_partition_change(cp, old_prs);
 
 		WARN_ON(!is_in_v2_mode() &&
 			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
@@ -1534,7 +1541,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 		if (!cpumask_empty(cp->cpus_allowed) &&
 		    is_sched_load_balance(cp) &&
 		   (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
-		    is_partition_root(cp)))
+		    is_partition_valid(cp)))
 			need_rebuild_sched_domains = true;
 
 		rcu_read_lock();
@@ -2034,10 +2041,11 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	return err;
 }
 
-/*
+/**
  * update_prstate - update partition_root_state
- * cs: the cpuset to update
- * new_prs: new partition root state
+ * @cs: the cpuset to update
+ * @new_prs: new partition root state
+ * Return: 0 if successful, < 0 if error
  *
  * Call with cpuset_rwsem held.
  */
@@ -2054,7 +2062,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	 * Cannot force a partial or invalid partition root to a full
 	 * partition root.
 	 */
-	if (new_prs && (old_prs == PRS_ERROR))
+	if (new_prs && is_prs_invalid(old_prs))
 		return -EINVAL;
 
 	if (alloc_cpumasks(NULL, &tmpmask))
@@ -2085,7 +2093,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * Turning off partition root will clear the
 		 * CS_CPU_EXCLUSIVE bit.
 		 */
-		if (old_prs == PRS_ERROR) {
+		if (is_prs_invalid(old_prs)) {
 			update_flag(CS_CPU_EXCLUSIVE, cs, 0);
 			err = 0;
 			goto out;
@@ -2111,7 +2119,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		spin_lock_irq(&callback_lock);
 		cs->partition_root_state = new_prs;
 		spin_unlock_irq(&callback_lock);
-		notify_partition_change(cs, old_prs, new_prs);
+		notify_partition_change(cs, old_prs);
 	}
 
 	free_cpumasks(NULL, &tmpmask);
@@ -2604,13 +2612,13 @@ static int sched_partition_show(struct seq_file *seq, void *v)
 	struct cpuset *cs = css_cs(seq_css(seq));
 
 	switch (cs->partition_root_state) {
-	case PRS_ENABLED:
+	case PRS_ROOT:
 		seq_puts(seq, "root\n");
 		break;
-	case PRS_DISABLED:
+	case PRS_MEMBER:
 		seq_puts(seq, "member\n");
 		break;
-	case PRS_ERROR:
+	case PRS_INVALID_ROOT:
 		seq_puts(seq, "root invalid\n");
 		break;
 	}
@@ -2630,9 +2638,9 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 	 * Convert "root" to ENABLED, and convert "member" to DISABLED.
 	 */
 	if (!strcmp(buf, "root"))
-		val = PRS_ENABLED;
+		val = PRS_ROOT;
 	else if (!strcmp(buf, "member"))
-		val = PRS_DISABLED;
+		val = PRS_MEMBER;
 	else
 		return -EINVAL;
 
@@ -2931,7 +2939,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	cpus_read_lock();
 	percpu_down_write(&cpuset_rwsem);
 
-	if (is_partition_root(cs))
+	if (is_partition_valid(cs))
 		update_prstate(cs, 0);
 
 	if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
@@ -3176,11 +3184,11 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 
 	/*
 	 * In the unlikely event that a partition root has empty
-	 * effective_cpus or its parent becomes erroneous, we have to
-	 * transition it to the erroneous state.
+	 * effective_cpus or its parent becomes invalid, we have to
+	 * transition it to the invalid state.
 	 */
-	if (is_partition_root(cs) && (cpumask_empty(&new_cpus) ||
-	   (parent->partition_root_state == PRS_ERROR))) {
+	if (is_partition_valid(cs) && (cpumask_empty(&new_cpus) ||
+	    is_partition_invalid(parent))) {
 		if (cs->nr_subparts_cpus) {
 			spin_lock_irq(&callback_lock);
 			cs->nr_subparts_cpus = 0;
@@ -3195,30 +3203,29 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		 * the current partition and let the child partitions
 		 * fight for available CPUs.
 		 */
-		if ((parent->partition_root_state == PRS_ERROR) ||
+		if (is_partition_invalid(parent) ||
 		     cpumask_empty(&new_cpus)) {
 			int old_prs;
 
 			update_parent_subparts_cpumask(cs, partcmd_disable,
 						       NULL, tmp);
 			old_prs = cs->partition_root_state;
-			if (old_prs != PRS_ERROR) {
+			if (!is_prs_invalid(old_prs)) {
 				spin_lock_irq(&callback_lock);
-				cs->partition_root_state = PRS_ERROR;
+				set_partition_invalid(cs);
 				spin_unlock_irq(&callback_lock);
-				notify_partition_change(cs, old_prs, PRS_ERROR);
+				notify_partition_change(cs, old_prs);
 			}
 		}
 		cpuset_force_rebuild();
 	}
 
 	/*
-	 * On the other hand, an erroneous partition root may be transitioned
+	 * On the other hand, an invalid partition root may be transitioned
 	 * back to a regular one or a partition root with no CPU allocated
-	 * from the parent may change to erroneous.
+	 * from the parent may change to invalid.
 	 */
-	if (is_partition_root(parent) &&
-	   ((cs->partition_root_state == PRS_ERROR) ||
+	if (is_partition_valid(parent) && (is_partition_invalid(cs) ||
 	    !cpumask_intersects(&new_cpus, parent->subparts_cpus)) &&
 	     update_parent_subparts_cpumask(cs, partcmd_update, NULL, tmp))
 		cpuset_force_rebuild();
-- 
2.27.0

