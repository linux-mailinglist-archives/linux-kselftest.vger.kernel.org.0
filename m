Return-Path: <linux-kselftest+bounces-29932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9500BA75CDA
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 23:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA886188A828
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 21:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDE31E1C22;
	Sun, 30 Mar 2025 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjItifQ+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A471DFE20
	for <linux-kselftest@vger.kernel.org>; Sun, 30 Mar 2025 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743371637; cv=none; b=Madp26j3Rw0oEopXyK+eRTimZnUTn6FAOIKBTSvUZV8xkifwQebJgZ2g33KJDG0QfK8ml6wNSVtaU9tuZRAFqkpzRRtQt0ytsE7H97x6CiBt7+xjMXLpbhyIBmn8Ogu20G7m22y9wvmvsJUVU9op+16FlhV8nbNC8NWJiULQB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743371637; c=relaxed/simple;
	bh=7joIjpORfzSw3mVw/thtzi0t+cMfR2dHBTW3ZZw4IjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrcmWCTPjpVhsXc0Cm+pYWfILK0K7bztz5oAvUVUks2dMfWz5P3m59ccSQ0fEIvskD6iVNHs/dTjcNXVNk9qIH7nbJv2cLIJ6gQ0XT6QUAwUPiuWOKrcIdo+Cs4cPbAomOc4o9KpDduYx+JrSRQ5RPZSKWk3f0dBFOU/KppGEbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjItifQ+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743371634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uo36KXp8L+TEKtoEnugaRSRjEW0Cq6TG5xkblxfQSuc=;
	b=CjItifQ+UzZ+rP5PS1+iL5gn6npxnbhXWou9QT91+Aq/AGO1tyJra8pNDr0MDonl1Rends
	r1Wx7Y+I8DD/2KqshetHq/H2IoAd5tPfUyUBjJo8OhsuaHjSyK6dEB1IxE9AkShrB2g88o
	FLvGI5+k7mlSHSgOxVyFusRehfkxIKg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-Dp5QgUA2Nverz0NjcwDfyg-1; Sun,
 30 Mar 2025 17:53:50 -0400
X-MC-Unique: Dp5QgUA2Nverz0NjcwDfyg-1
X-Mimecast-MFC-AGG-ID: Dp5QgUA2Nverz0NjcwDfyg_1743371629
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6F811945103;
	Sun, 30 Mar 2025 21:53:48 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E61451801750;
	Sun, 30 Mar 2025 21:53:46 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 04/10] cgroup/cpuset: Remove remote_partition_check() & make update_cpumasks_hier() handle remote partition
Date: Sun, 30 Mar 2025 17:52:42 -0400
Message-ID: <20250330215248.3620801-5-longman@redhat.com>
In-Reply-To: <20250330215248.3620801-1-longman@redhat.com>
References: <20250330215248.3620801-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently, changes in exclusive CPUs are being handled in
remote_partition_check() by disabling conflicting remote partitions.
However, that may lead to results unexpected by the users. Fix
this problem by removing remote_partition_check() and making
update_cpumasks_hier() handle changes in descendant remote partitions
properly.

The compute_effective_exclusive_cpumask() function is enhanced to check
the exclusive_cpus and effective_xcpus from siblings and excluded them
in its effective exclusive CPUs computation and return a value to show if
there is any sibling conflicts.  This is somewhat like the cpu_exclusive
flag check in validate_change(). This is the initial step to enable us
to retire the use of cpu_exclusive flag in cgroup v2 in the future.

One of the tests in the TEST_MATRIX of the test_cpuset_prs.sh
script has to be updated due to changes in the way a child remote
partition root is being handled (updated instead of invalidation)
in update_cpumasks_hier().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c                        | 258 ++++++++++--------
 .../selftests/cgroup/test_cpuset_prs.sh       |   4 +-
 2 files changed, 143 insertions(+), 119 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2c5b25609c56..ffa85d34ba51 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -86,7 +86,6 @@ static struct list_head remote_children;
  * A flag to force sched domain rebuild at the end of an operation.
  * It can be set in
  *  - update_partition_sd_lb()
- *  - remote_partition_check()
  *  - update_cpumasks_hier()
  *  - cpuset_update_flag()
  *  - cpuset_hotplug_update_tasks()
@@ -1340,20 +1339,57 @@ EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);
  * compute_effective_exclusive_cpumask - compute effective exclusive CPUs
  * @cs: cpuset
  * @xcpus: effective exclusive CPUs value to be set
- * Return: true if xcpus is not empty, false otherwise.
+ * @real_cs: the real cpuset (can be NULL)
+ * Return: 0 if there is no sibling conflict, > 0 otherwise
  *
- * Starting with exclusive_cpus (cpus_allowed if exclusive_cpus is not set),
- * it must be a subset of parent's effective_xcpus.
+ * If exclusive_cpus isn't explicitly set or a real_cs is provided, we have to
+ * scan the sibling cpusets and exclude their exclusive_cpus or effective_xcpus
+ * as well. The provision of real_cs means that a cpumask is being changed and
+ * the given cs is a trial one.
  */
-static bool compute_effective_exclusive_cpumask(struct cpuset *cs,
-						struct cpumask *xcpus)
+static int compute_effective_exclusive_cpumask(struct cpuset *cs,
+					       struct cpumask *xcpus,
+					       struct cpuset *real_cs)
 {
+	struct cgroup_subsys_state *css;
 	struct cpuset *parent = parent_cs(cs);
+	struct cpuset *sibling;
+	int retval = 0;
 
 	if (!xcpus)
 		xcpus = cs->effective_xcpus;
 
-	return cpumask_and(xcpus, user_xcpus(cs), parent->effective_xcpus);
+	cpumask_and(xcpus, user_xcpus(cs), parent->effective_xcpus);
+
+	if (!real_cs) {
+		if (!cpumask_empty(cs->exclusive_cpus))
+			return 0;
+	} else {
+		cs = real_cs;
+	}
+
+	/*
+	 * Exclude exclusive CPUs from siblings
+	 */
+	rcu_read_lock();
+	cpuset_for_each_child(sibling, css, parent) {
+		if (sibling == cs)
+			continue;
+
+		if (!cpumask_empty(sibling->exclusive_cpus) &&
+		    cpumask_intersects(xcpus, sibling->exclusive_cpus)) {
+			cpumask_andnot(xcpus, xcpus, sibling->exclusive_cpus);
+			retval++;
+			continue;
+		}
+		if (!cpumask_empty(sibling->effective_xcpus) &&
+		    cpumask_intersects(xcpus, sibling->effective_xcpus)) {
+			cpumask_andnot(xcpus, xcpus, sibling->effective_xcpus);
+			retval++;
+		}
+	}
+	rcu_read_unlock();
+	return retval;
 }
 
 static inline bool is_remote_partition(struct cpuset *cs)
@@ -1395,7 +1431,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	 * remote partition root underneath it, its exclusive_cpus must
 	 * have overlapped with subpartitions_cpus.
 	 */
-	compute_effective_exclusive_cpumask(cs, tmp->new_cpus);
+	compute_effective_exclusive_cpumask(cs, tmp->new_cpus, NULL);
 	if (cpumask_empty(tmp->new_cpus) ||
 	    cpumask_intersects(tmp->new_cpus, subpartitions_cpus) ||
 	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
@@ -1404,8 +1440,10 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	spin_lock_irq(&callback_lock);
 	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
 	list_add(&cs->remote_sibling, &remote_children);
+	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
 	spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
+	cpuset_force_rebuild();
 	cs->prs_err = 0;
 
 	/*
@@ -1429,22 +1467,24 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 {
 	bool isolcpus_updated;
 
-	compute_effective_exclusive_cpumask(cs, tmp->new_cpus);
 	WARN_ON_ONCE(!is_remote_partition(cs));
-	WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, subpartitions_cpus));
+	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
 
 	spin_lock_irq(&callback_lock);
 	list_del_init(&cs->remote_sibling);
 	isolcpus_updated = partition_xcpus_del(cs->partition_root_state,
-					       NULL, tmp->new_cpus);
+					       NULL, cs->effective_xcpus);
 	if (cs->prs_err)
 		cs->partition_root_state = -cs->partition_root_state;
 	else
 		cs->partition_root_state = PRS_MEMBER;
 
+	/* effective_xcpus may need to be changed */
+	compute_effective_exclusive_cpumask(cs, NULL, NULL);
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
+	cpuset_force_rebuild();
 
 	/*
 	 * Propagate changes in top_cpuset's effective_cpus down the hierarchy.
@@ -1456,14 +1496,15 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 /*
  * remote_cpus_update - cpus_exclusive change of remote partition
  * @cs: the cpuset to be updated
- * @newmask: the new effective_xcpus mask
+ * @xcpus: the new exclusive_cpus mask, if non-NULL
+ * @excpus: the new effective_xcpus mask
  * @tmp: temporary masks
  *
  * top_cpuset and subpartitions_cpus will be updated or partition can be
  * invalidated.
  */
-static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
-			       struct tmpmasks *tmp)
+static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
+			       struct cpumask *excpus, struct tmpmasks *tmp)
 {
 	bool adding, deleting;
 	int prs = cs->partition_root_state;
@@ -1474,13 +1515,13 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 
 	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
 
-	if (cpumask_empty(newmask)) {
+	if (cpumask_empty(excpus)) {
 		cs->prs_err = PERR_CPUSEMPTY;
 		goto invalidate;
 	}
 
-	adding   = cpumask_andnot(tmp->addmask, newmask, cs->effective_xcpus);
-	deleting = cpumask_andnot(tmp->delmask, cs->effective_xcpus, newmask);
+	adding   = cpumask_andnot(tmp->addmask, excpus, cs->effective_xcpus);
+	deleting = cpumask_andnot(tmp->delmask, cs->effective_xcpus, excpus);
 
 	/*
 	 * Additions of remote CPUs is only allowed if those CPUs are
@@ -1502,8 +1543,17 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 		isolcpus_updated += partition_xcpus_add(prs, NULL, tmp->addmask);
 	if (deleting)
 		isolcpus_updated += partition_xcpus_del(prs, NULL, tmp->delmask);
+	/*
+	 * Need to update effective_xcpus and exclusive_cpus now as
+	 * update_sibling_cpumasks() below may iterate back to the same cs.
+	 */
+	cpumask_copy(cs->effective_xcpus, excpus);
+	if (xcpus)
+		cpumask_copy(cs->exclusive_cpus, xcpus);
 	spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
+	if (adding || deleting)
+		cpuset_force_rebuild();
 
 	/*
 	 * Propagate changes in top_cpuset's effective_cpus down the hierarchy.
@@ -1516,47 +1566,6 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 	remote_partition_disable(cs, tmp);
 }
 
-/*
- * remote_partition_check - check if a child remote partition needs update
- * @cs: the cpuset to be updated
- * @newmask: the new effective_xcpus mask
- * @delmask: temporary mask for deletion (not in tmp)
- * @tmp: temporary masks
- *
- * This should be called before the given cs has updated its cpus_allowed
- * and/or effective_xcpus.
- */
-static void remote_partition_check(struct cpuset *cs, struct cpumask *newmask,
-				   struct cpumask *delmask, struct tmpmasks *tmp)
-{
-	struct cpuset *child, *next;
-	int disable_cnt = 0;
-
-	/*
-	 * Compute the effective exclusive CPUs that will be deleted.
-	 */
-	if (!cpumask_andnot(delmask, cs->effective_xcpus, newmask) ||
-	    !cpumask_intersects(delmask, subpartitions_cpus))
-		return;	/* No deletion of exclusive CPUs in partitions */
-
-	/*
-	 * Searching the remote children list to look for those that will
-	 * be impacted by the deletion of exclusive CPUs.
-	 *
-	 * Since a cpuset must be removed from the remote children list
-	 * before it can go offline and holding cpuset_mutex will prevent
-	 * any change in cpuset status. RCU read lock isn't needed.
-	 */
-	lockdep_assert_held(&cpuset_mutex);
-	list_for_each_entry_safe(child, next, &remote_children, remote_sibling)
-		if (cpumask_intersects(child->effective_cpus, delmask)) {
-			remote_partition_disable(child, tmp);
-			disable_cnt++;
-		}
-	if (disable_cnt)
-		cpuset_force_rebuild();
-}
-
 /*
  * prstate_housekeeping_conflict - check for partition & housekeeping conflicts
  * @prstate: partition root state to be checked
@@ -1629,6 +1638,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	bool nocpu;
 
 	lockdep_assert_held(&cpuset_mutex);
+	WARN_ON_ONCE(is_remote_partition(cs));
 
 	/*
 	 * new_prs will only be changed for the partcmd_update and
@@ -1670,13 +1680,20 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	nocpu = tasks_nocpu_error(parent, cs, xcpus);
 
 	if ((cmd == partcmd_enable) || (cmd == partcmd_enablei)) {
+		/*
+		 * Need to call compute_effective_exclusive_cpumask() in case
+		 * exclusive_cpus not set. Sibling conflict should only happen
+		 * if exclusive_cpus isn't set.
+		 */
+		xcpus = tmp->new_cpus;
+		if (compute_effective_exclusive_cpumask(cs, xcpus, NULL))
+			WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
+
 		/*
 		 * Enabling partition root is not allowed if its
-		 * effective_xcpus is empty or doesn't overlap with
-		 * parent's effective_xcpus.
+		 * effective_xcpus is empty.
 		 */
-		if (cpumask_empty(xcpus) ||
-		    !cpumask_intersects(xcpus, parent->effective_xcpus))
+		if (cpumask_empty(xcpus))
 			return PERR_INVCPUS;
 
 		if (prstate_housekeeping_conflict(new_prs, xcpus))
@@ -1695,13 +1712,16 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
 	} else if (cmd == partcmd_disable) {
 		/*
-		 * May need to add cpus to parent's effective_cpus for
-		 * valid partition root.
+		 * May need to add cpus back to parent's effective_cpus
+		 * (and maybe removed from subpartitions_cpus/isolated_cpus)
+		 * for valid partition root. xcpus may contain CPUs that
+		 * shouldn't be removed from the two global cpumasks.
 		 */
-		adding = !is_prs_invalid(old_prs) &&
-			  cpumask_and(tmp->addmask, xcpus, parent->effective_xcpus);
-		if (adding)
+		if (is_partition_valid(cs)) {
+			cpumask_copy(tmp->addmask, cs->effective_xcpus);
+			adding = true;
 			subparts_delta--;
+		}
 		new_prs = PRS_MEMBER;
 	} else if (newmask) {
 		/*
@@ -1711,6 +1731,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			part_error = PERR_CPUSEMPTY;
 			goto write_error;
 		}
+
 		/* Check newmask again, whether cpus are available for parent/cs */
 		nocpu |= tasks_nocpu_error(parent, cs, newmask);
 
@@ -1927,7 +1948,7 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
 	 *  2) All the effective_cpus will be used up and cp
 	 *     has tasks
 	 */
-	compute_effective_exclusive_cpumask(cs, new_ecpus);
+	compute_effective_exclusive_cpumask(cs, new_ecpus, NULL);
 	cpumask_and(new_ecpus, new_ecpus, cpu_active_mask);
 
 	rcu_read_lock();
@@ -1935,6 +1956,11 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
 		if (!is_partition_valid(child))
 			continue;
 
+		/*
+		 * There shouldn't be a remote partition underneath another
+		 * partition root.
+		 */
+		WARN_ON_ONCE(is_remote_partition(child));
 		child->prs_err = 0;
 		if (!cpumask_subset(child->effective_xcpus,
 				    cs->effective_xcpus))
@@ -1990,32 +2016,39 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		bool remote = is_remote_partition(cp);
 		bool update_parent = false;
 
+		old_prs = new_prs = cp->partition_root_state;
+
 		/*
-		 * Skip descendent remote partition that acquires CPUs
-		 * directly from top cpuset unless it is cs.
+		 * For child remote partition root (!= cs), we need to call
+		 * remote_cpus_update() if effective_xcpus will be changed.
+		 * Otherwise, we can skip the whole subtree.
+		 *
+		 * remote_cpus_update() will reuse tmp->new_cpus only after
+		 * its value is being processed.
 		 */
 		if (remote && (cp != cs)) {
-			pos_css = css_rightmost_descendant(pos_css);
-			continue;
-		}
+			compute_effective_exclusive_cpumask(cp, tmp->new_cpus, NULL);
+			if (cpumask_equal(cp->effective_xcpus, tmp->new_cpus)) {
+				pos_css = css_rightmost_descendant(pos_css);
+				continue;
+			}
+			rcu_read_unlock();
+			remote_cpus_update(cp, NULL, tmp->new_cpus, tmp);
+			rcu_read_lock();
 
-		/*
-		 * Update effective_xcpus if exclusive_cpus set.
-		 * The case when exclusive_cpus isn't set is handled later.
-		 */
-		if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs)) {
-			spin_lock_irq(&callback_lock);
-			compute_effective_exclusive_cpumask(cp, NULL);
-			spin_unlock_irq(&callback_lock);
+			/* Remote partition may be invalidated */
+			new_prs = cp->partition_root_state;
+			remote = (new_prs == old_prs);
 		}
 
-		old_prs = new_prs = cp->partition_root_state;
-		if (remote || (is_partition_valid(parent) &&
-			       is_partition_valid(cp)))
+		if (remote || (is_partition_valid(parent) && is_partition_valid(cp)))
 			compute_partition_effective_cpumask(cp, tmp->new_cpus);
 		else
 			compute_effective_cpumask(tmp->new_cpus, cp, parent);
 
+		if (remote)
+			goto get_css;	/* Ready to update cpuset data */
+
 		/*
 		 * A partition with no effective_cpus is allowed as long as
 		 * there is no task associated with it. Call
@@ -2035,9 +2068,6 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		if (is_in_v2_mode() && !remote && cpumask_empty(tmp->new_cpus))
 			cpumask_copy(tmp->new_cpus, parent->effective_cpus);
 
-		if (remote)
-			goto get_css;
-
 		/*
 		 * Skip the whole subtree if
 		 * 1) the cpumask remains the same,
@@ -2098,6 +2128,9 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		spin_lock_irq(&callback_lock);
 		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
 		cp->partition_root_state = new_prs;
+		if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
+			compute_effective_exclusive_cpumask(cp, NULL, NULL);
+
 		/*
 		 * Make sure effective_xcpus is properly set for a valid
 		 * partition root.
@@ -2184,7 +2217,14 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 						  parent);
 			if (cpumask_equal(tmp->new_cpus, sibling->effective_cpus))
 				continue;
+		} else if (is_remote_partition(sibling)) {
+			/*
+			 * Change in a sibling cpuset won't affect a remote
+			 * partition root.
+			 */
+			continue;
 		}
+
 		if (!css_tryget_online(&sibling->css))
 			continue;
 
@@ -2241,8 +2281,9 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		 * trialcs->effective_xcpus is used as a temporary cpumask
 		 * for checking validity of the partition root.
 		 */
+		trialcs->partition_root_state = PRS_MEMBER;
 		if (!cpumask_empty(trialcs->exclusive_cpus) || is_partition_valid(cs))
-			compute_effective_exclusive_cpumask(trialcs, NULL);
+			compute_effective_exclusive_cpumask(trialcs, NULL, cs);
 	}
 
 	/* Nothing to do if the cpus didn't change */
@@ -2315,19 +2356,13 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		 * Call remote_cpus_update() to handle valid remote partition
 		 */
 		if (is_remote_partition(cs))
-			remote_cpus_update(cs, xcpus, &tmp);
+			remote_cpus_update(cs, NULL, xcpus, &tmp);
 		else if (invalidate)
 			update_parent_effective_cpumask(cs, partcmd_invalidate,
 							NULL, &tmp);
 		else
 			update_parent_effective_cpumask(cs, partcmd_update,
 							xcpus, &tmp);
-	} else if (!cpumask_empty(cs->exclusive_cpus)) {
-		/*
-		 * Use trialcs->effective_cpus as a temp cpumask
-		 */
-		remote_partition_check(cs, trialcs->effective_xcpus,
-				       trialcs->effective_cpus, &tmp);
 	}
 
 	spin_lock_irq(&callback_lock);
@@ -2379,8 +2414,15 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (cpumask_equal(cs->exclusive_cpus, trialcs->exclusive_cpus))
 		return 0;
 
-	if (*buf)
-		compute_effective_exclusive_cpumask(trialcs, NULL);
+	if (*buf) {
+		trialcs->partition_root_state = PRS_MEMBER;
+		/*
+		 * Reject the change if there is exclusive CPUs conflict with
+		 * the siblings.
+		 */
+		if (compute_effective_exclusive_cpumask(trialcs, NULL, cs))
+			return -EINVAL;
+	}
 
 	/*
 	 * Check all the descendants in update_cpumasks_hier() if
@@ -2411,8 +2453,8 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 			if (invalidate)
 				remote_partition_disable(cs, &tmp);
 			else
-				remote_cpus_update(cs, trialcs->effective_xcpus,
-						   &tmp);
+				remote_cpus_update(cs, trialcs->exclusive_cpus,
+						   trialcs->effective_xcpus, &tmp);
 		} else if (invalidate) {
 			update_parent_effective_cpumask(cs, partcmd_invalidate,
 							NULL, &tmp);
@@ -2420,12 +2462,6 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 			update_parent_effective_cpumask(cs, partcmd_update,
 						trialcs->effective_xcpus, &tmp);
 		}
-	} else if (!cpumask_empty(trialcs->exclusive_cpus)) {
-		/*
-		 * Use trialcs->effective_cpus as a temp cpumask
-		 */
-		remote_partition_check(cs, trialcs->effective_xcpus,
-				       trialcs->effective_cpus, &tmp);
 	}
 	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->exclusive_cpus, trialcs->exclusive_cpus);
@@ -2806,17 +2842,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (alloc_cpumasks(NULL, &tmpmask))
 		return -ENOMEM;
 
-	/*
-	 * Setup effective_xcpus if not properly set yet, it will be cleared
-	 * later if partition becomes invalid.
-	 */
-	if ((new_prs > 0) && cpumask_empty(cs->exclusive_cpus)) {
-		spin_lock_irq(&callback_lock);
-		cpumask_and(cs->effective_xcpus,
-			    cs->cpus_allowed, parent->effective_xcpus);
-		spin_unlock_irq(&callback_lock);
-	}
-
 	err = update_partition_exclusive(cs, new_prs);
 	if (err)
 		goto out;
@@ -3767,7 +3792,6 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		remote_partition_disable(cs, tmp);
 		compute_effective_cpumask(&new_cpus, cs, parent);
 		remote = false;
-		cpuset_force_rebuild();
 	}
 
 	/*
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 400a696a0d21..4e3fabed52da 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -326,8 +326,8 @@ TEST_MATRIX=(
 				   .      .     X3      P2     .     0 A1:0-2,A2:1-2,XA2:3,XA3:3,A3:3 \
 								       A1:P0,A3:P2 3"
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3:P2 \
-				   .      .     X3      .      .     0 A1:0-3,A2:1-3,XA2:3,XA3:3,A3:2-3 \
-								       A1:P0,A3:P-2"
+				   .      .     X3      .      .     0 A1:0-2,A2:1-2,XA2:3,XA3:3,A3:3,XA3:3 \
+								       A1:P0,A3:P2 3"
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3:P2 \
 				   .     X4      .      .      .     0 A1:0-3,A2:1-3,A3:2-3,XA1:4,XA2:,XA3 \
 								       A1:P0,A3:P-2"
-- 
2.48.1


