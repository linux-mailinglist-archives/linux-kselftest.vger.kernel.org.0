Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8687573EFE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 02:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjF0A5d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 20:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjF0A5c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 20:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92561984
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 17:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687827364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uQnA8KxcgOFozupPVsTAvj62Jsq+O+jMrE7LgQghL4U=;
        b=XWVBtxfF4wsw9B9541J9ROE/lgUMWUj864Bm73RcAafbKRsB4SZyoWYvFD7VFc+h3AFC3h
        ee7C3ooCj7GlikbyDT/tcqyAFL6CxrN822sR5Ez/+A6DVG6yMx8fi0Hdn7RUYXu6bpA8B8
        DQ9cGtzhEeEHNCeakJ4iG86BDr3TvxY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-w32WjwIHNY-cYgNOrPC69w-1; Mon, 26 Jun 2023 20:56:00 -0400
X-MC-Unique: w32WjwIHNY-cYgNOrPC69w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 199E93802AD9;
        Tue, 27 Jun 2023 00:56:00 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 463BB2166B25;
        Tue, 27 Jun 2023 00:55:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>, Phil Auld <pauld@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 2/9] cgroup/cpuset: Extract out CS_CPU_EXCLUSIVE & CS_SCHED_LOAD_BALANCE handling
Date:   Mon, 26 Jun 2023 20:55:22 -0400
Message-Id: <20230627005529.1564984-3-longman@redhat.com>
In-Reply-To: <20230627005529.1564984-1-longman@redhat.com>
References: <20230627005529.1564984-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extract out the setting of CS_CPU_EXCLUSIVE and CS_SCHED_LOAD_BALANCE
flags as well as the rebuilding of scheduling domains into the new
update_partition_exclusive() and update_partition_sd_lb() helper
functions to simplify the logic. The update_partition_exclusive()
helper is called mainly at the beginning of the caller, but it may be
called at the end too. The update_partition_sd_lb() helper is called
at the end of the caller.

This patch should reduce the chance that cpuset partition will end up
in an incorrect state.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 141 +++++++++++++++++++++++++----------------
 1 file changed, 86 insertions(+), 55 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 170e342b07e3..ade33e50ffe2 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1255,7 +1255,7 @@ static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 static void compute_effective_cpumask(struct cpumask *new_cpus,
 				      struct cpuset *cs, struct cpuset *parent)
 {
-	if (parent->nr_subparts_cpus) {
+	if (parent->nr_subparts_cpus && is_partition_valid(cs)) {
 		cpumask_or(new_cpus, parent->effective_cpus,
 			   parent->subparts_cpus);
 		cpumask_and(new_cpus, new_cpus, cs->cpus_allowed);
@@ -1277,6 +1277,50 @@ enum subparts_cmd {
 
 static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 		       int turning_on);
+
+/*
+ * Update partition exclusive flag
+ *
+ * Return: 0 if successful, an error code otherwise
+ */
+static int update_partition_exclusive(struct cpuset *cs, int new_prs)
+{
+	bool exclusive = (new_prs > 0);
+
+	if (exclusive && !is_cpu_exclusive(cs)) {
+		if (update_flag(CS_CPU_EXCLUSIVE, cs, 1))
+			return PERR_NOTEXCL;
+	} else if (!exclusive && is_cpu_exclusive(cs)) {
+		/* Turning off CS_CPU_EXCLUSIVE will not return error */
+		update_flag(CS_CPU_EXCLUSIVE, cs, 0);
+	}
+	return 0;
+}
+
+/*
+ * Update partition load balance flag and/or rebuild sched domain
+ *
+ * Changing load balance flag will automatically call
+ * rebuild_sched_domains_locked().
+ */
+static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
+{
+	int new_prs = cs->partition_root_state;
+	bool new_lb = (new_prs != PRS_ISOLATED);
+	bool rebuild_domains = (new_prs > 0) || (old_prs > 0);
+
+	if (new_lb != !!is_sched_load_balance(cs)) {
+		rebuild_domains = true;
+		if (new_lb)
+			set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
+		else
+			clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
+	}
+
+	if (rebuild_domains)
+		rebuild_sched_domains_locked();
+}
+
 /**
  * update_parent_subparts_cpumask - update subparts_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -1336,8 +1380,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		return is_partition_invalid(parent)
 		       ? PERR_INVPARENT : PERR_NOTPART;
 	}
-	if ((newmask && cpumask_empty(newmask)) ||
-	   (!newmask && cpumask_empty(cs->cpus_allowed)))
+	if (!newmask && cpumask_empty(cs->cpus_allowed))
 		return PERR_CPUSEMPTY;
 
 	/*
@@ -1403,11 +1446,16 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		cpumask_and(tmp->addmask, newmask, parent->cpus_allowed);
 		adding = cpumask_andnot(tmp->addmask, tmp->addmask,
 					parent->subparts_cpus);
+		/*
+		 * Empty cpumask is not allewed
+		 */
+		if (cpumask_empty(newmask)) {
+			part_error = PERR_CPUSEMPTY;
 		/*
 		 * Make partition invalid if parent's effective_cpus could
 		 * become empty and there are tasks in the parent.
 		 */
-		if (adding &&
+		} else if (adding &&
 		    cpumask_subset(parent->effective_cpus, tmp->addmask) &&
 		    !cpumask_intersects(tmp->delmask, cpu_active_mask) &&
 		    partition_is_populated(parent, cs)) {
@@ -1480,14 +1528,13 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 
 	/*
 	 * Transitioning between invalid to valid or vice versa may require
-	 * changing CS_CPU_EXCLUSIVE and CS_SCHED_LOAD_BALANCE.
+	 * changing CS_CPU_EXCLUSIVE.
 	 */
 	if (old_prs != new_prs) {
-		if (is_prs_invalid(old_prs) && !is_cpu_exclusive(cs) &&
-		    (update_flag(CS_CPU_EXCLUSIVE, cs, 1) < 0))
-			return PERR_NOTEXCL;
-		if (is_prs_invalid(new_prs) && is_cpu_exclusive(cs))
-			update_flag(CS_CPU_EXCLUSIVE, cs, 0);
+		int err = update_partition_exclusive(cs, new_prs);
+
+		if (err)
+			return err;
 	}
 
 	/*
@@ -1524,15 +1571,16 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		update_tasks_cpumask(parent, tmp->addmask);
 
 	/*
-	 * Set or clear CS_SCHED_LOAD_BALANCE when partcmd_update, if necessary.
-	 * rebuild_sched_domains_locked() may be called.
+	 * For partcmd_update without newmask, it is being called from
+	 * cpuset_hotplug_workfn() where cpus_read_lock() wasn't taken.
+	 * Update the load balance flag and scheduling domain if
+	 * cpus_read_trylock() is successful.
 	 */
-	if (old_prs != new_prs) {
-		if (old_prs == PRS_ISOLATED)
-			update_flag(CS_SCHED_LOAD_BALANCE, cs, 1);
-		else if (new_prs == PRS_ISOLATED)
-			update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
+	if ((cmd == partcmd_update) && !newmask && cpus_read_trylock()) {
+		update_partition_sd_lb(cs, old_prs);
+		cpus_read_unlock();
 	}
+
 	notify_partition_change(cs, old_prs);
 	return 0;
 }
@@ -1766,6 +1814,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	int retval;
 	struct tmpmasks tmp;
 	bool invalidate = false;
+	int old_prs = cs->partition_root_state;
 
 	/* top_cpuset.cpus_allowed tracks cpu_online_mask; it's read-only */
 	if (cs == &top_cpuset)
@@ -1885,6 +1934,9 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		 */
 		if (parent->child_ecpus_count)
 			update_sibling_cpumasks(parent, cs, &tmp);
+
+		/* Update CS_SCHED_LOAD_BALANCE and/or sched_domains */
+		update_partition_sd_lb(cs, old_prs);
 	}
 	return 0;
 }
@@ -2261,7 +2313,6 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 static int update_prstate(struct cpuset *cs, int new_prs)
 {
 	int err = PERR_NONE, old_prs = cs->partition_root_state;
-	bool sched_domain_rebuilt = false;
 	struct cpuset *parent = parent_cs(cs);
 	struct tmpmasks tmpmask;
 
@@ -2280,45 +2331,28 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (alloc_cpumasks(NULL, &tmpmask))
 		return -ENOMEM;
 
+	err = update_partition_exclusive(cs, new_prs);
+	if (err)
+		goto out;
+
 	if (!old_prs) {
 		/*
-		 * Turning on partition root requires setting the
-		 * CS_CPU_EXCLUSIVE bit implicitly as well and cpus_allowed
-		 * cannot be empty.
+		 * cpus_allowed cannot be empty.
 		 */
 		if (cpumask_empty(cs->cpus_allowed)) {
 			err = PERR_CPUSEMPTY;
 			goto out;
 		}
 
-		err = update_flag(CS_CPU_EXCLUSIVE, cs, 1);
-		if (err) {
-			err = PERR_NOTEXCL;
-			goto out;
-		}
-
 		err = update_parent_subparts_cpumask(cs, partcmd_enable,
 						     NULL, &tmpmask);
-		if (err) {
-			update_flag(CS_CPU_EXCLUSIVE, cs, 0);
+		if (err)
 			goto out;
-		}
-
-		if (new_prs == PRS_ISOLATED) {
-			/*
-			 * Disable the load balance flag should not return an
-			 * error unless the system is running out of memory.
-			 */
-			update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
-			sched_domain_rebuilt = true;
-		}
 	} else if (old_prs && new_prs) {
 		/*
 		 * A change in load balance state only, no change in cpumasks.
 		 */
-		update_flag(CS_SCHED_LOAD_BALANCE, cs, (new_prs != PRS_ISOLATED));
-		sched_domain_rebuilt = true;
-		goto out;	/* Sched domain is rebuilt in update_flag() */
+		goto out;
 	} else {
 		/*
 		 * Switching back to member is always allowed even if it
@@ -2337,15 +2371,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 			compute_effective_cpumask(cs->effective_cpus, cs, parent);
 			spin_unlock_irq(&callback_lock);
 		}
-
-		/* Turning off CS_CPU_EXCLUSIVE will not return error */
-		update_flag(CS_CPU_EXCLUSIVE, cs, 0);
-
-		if (!is_sched_load_balance(cs)) {
-			/* Make sure load balance is on */
-			update_flag(CS_SCHED_LOAD_BALANCE, cs, 1);
-			sched_domain_rebuilt = true;
-		}
 	}
 
 	update_tasks_cpumask(parent, tmpmask.new_cpus);
@@ -2353,18 +2378,21 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (parent->child_ecpus_count)
 		update_sibling_cpumasks(parent, cs, &tmpmask);
 
-	if (!sched_domain_rebuilt)
-		rebuild_sched_domains_locked();
 out:
 	/*
-	 * Make partition invalid if an error happen
+	 * Make partition invalid & disable CS_CPU_EXCLUSIVE if an error
+	 * happens.
 	 */
-	if (err)
+	if (err) {
 		new_prs = -new_prs;
+		update_partition_exclusive(cs, new_prs);
+	}
+
 	spin_lock_irq(&callback_lock);
 	cs->partition_root_state = new_prs;
 	WRITE_ONCE(cs->prs_err, err);
 	spin_unlock_irq(&callback_lock);
+
 	/*
 	 * Update child cpusets, if present.
 	 * Force update if switching back to member.
@@ -2372,6 +2400,9 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (!list_empty(&cs->css.children))
 		update_cpumasks_hier(cs, &tmpmask, !new_prs);
 
+	/* Update sched domains and load balance flag */
+	update_partition_sd_lb(cs, old_prs);
+
 	notify_partition_change(cs, old_prs);
 	free_cpumasks(NULL, &tmpmask);
 	return 0;
-- 
2.31.1

