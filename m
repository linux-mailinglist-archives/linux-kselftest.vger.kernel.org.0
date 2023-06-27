Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCAE73FDF8
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 16:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjF0Og4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 10:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjF0Ogz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 10:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEA530EE
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687876565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1/GI0DN/l36YNRdQUEP56Qh0Q1HrifFn5e4yBEgTec=;
        b=g7NoqCvev+lxIChha9NYqvCm1GaY624/0YNi4nsNO1My3NoVbhzNQJFgF8KjpgIhY2RYI9
        C7hzRa4APMgrDgHuTyRIQyI4Ssz2j7+a5BR7KFDmBYVR2/jsF1tmYrN73NsQKGKG4rOL9B
        hIjhnNFYuPOWIHpEPJIZ+XITjSEVnxA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-Wp4Ew9xSP4CUljkjzPLvUg-1; Tue, 27 Jun 2023 10:36:00 -0400
X-MC-Unique: Wp4Ew9xSP4CUljkjzPLvUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B52D8E2D58;
        Tue, 27 Jun 2023 14:35:35 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B80540C2063;
        Tue, 27 Jun 2023 14:35:34 +0000 (UTC)
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
Subject: [PATCH v4 4/9] cgroup/cpuset: Allow suppression of sched domain rebuild in update_cpumasks_hier()
Date:   Tue, 27 Jun 2023 10:35:03 -0400
Message-Id: <20230627143508.1576882-5-longman@redhat.com>
In-Reply-To: <20230627143508.1576882-1-longman@redhat.com>
References: <20230627143508.1576882-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

A single partition setup and tear-down operation can lead to
multiple rebuild_sched_domains_locked() calls which is a waste of
effort. This can partly be mitigated by adding a flag to suppress the
rebuild_sched_domains_locked() call in update_cpumasks_hier(). Since
a Boolean flag has already been passed as the 3rd argument to
update_cpumasks_hier(), we can extend that to a full flag word.

The sched domain rebuild suppression is now enabled in
update_sibling_cpumasks() as all it callers will do the sched domain
rebuild after its return later on anyway.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b8ccc1be7bde..64f9e305b3ab 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1590,6 +1590,12 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	return 0;
 }
 
+/*
+ * update_cpumasks_hier() flags
+ */
+#define HIER_CHECKALL		0x01	/* Check all cpusets with no skipping */
+#define HIER_NO_SD_REBUILD	0x02	/* Don't rebuild sched domains */
+
 /*
  * update_cpumasks_hier - Update effective cpumasks and tasks in the subtree
  * @cs:  the cpuset to consider
@@ -1604,7 +1610,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
  * Called with cpuset_mutex held
  */
 static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
-				 bool force)
+				 int flags)
 {
 	struct cpuset *cp;
 	struct cgroup_subsys_state *pos_css;
@@ -1644,10 +1650,10 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * Skip the whole subtree if
 		 * 1) the cpumask remains the same,
 		 * 2) has no partition root state,
-		 * 3) force flag not set, and
+		 * 3) HIER_CHECKALL flag not set, and
 		 * 4) for v2 load balance state same as its parent.
 		 */
-		if (!cp->partition_root_state && !force &&
+		if (!cp->partition_root_state && !(flags & HIER_CHECKALL) &&
 		    cpumask_equal(tmp->new_cpus, cp->effective_cpus) &&
 		    (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
 		    (is_sched_load_balance(parent) == is_sched_load_balance(cp)))) {
@@ -1764,7 +1770,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 	}
 	rcu_read_unlock();
 
-	if (need_rebuild_sched_domains)
+	if (need_rebuild_sched_domains && !(flags & HIER_NO_SD_REBUILD))
 		rebuild_sched_domains_locked();
 }
 
@@ -1788,7 +1794,9 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	 * to use the right effective_cpus value.
 	 *
 	 * The update_cpumasks_hier() function may sleep. So we have to
-	 * release the RCU read lock before calling it.
+	 * release the RCU read lock before calling it. HIER_NO_SD_REBUILD
+	 * flag is used to suppress rebuild of sched domains as the callers
+	 * will take care of that.
 	 */
 	rcu_read_lock();
 	cpuset_for_each_child(sibling, pos_css, parent) {
@@ -1800,7 +1808,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 			continue;
 
 		rcu_read_unlock();
-		update_cpumasks_hier(sibling, tmp, false);
+		update_cpumasks_hier(sibling, tmp, HIER_NO_SD_REBUILD);
 		rcu_read_lock();
 		css_put(&sibling->css);
 	}
@@ -1913,7 +1921,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	spin_unlock_irq(&callback_lock);
 
 	/* effective_cpus will be updated here */
-	update_cpumasks_hier(cs, &tmp, false);
+	update_cpumasks_hier(cs, &tmp, 0);
 
 	if (cs->partition_root_state) {
 		struct cpuset *parent = parent_cs(cs);
@@ -2382,7 +2390,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	 * Force update if switching back to member.
 	 */
 	if (!list_empty(&cs->css.children))
-		update_cpumasks_hier(cs, &tmpmask, !new_prs);
+		update_cpumasks_hier(cs, &tmpmask, !new_prs ? HIER_CHECKALL : 0);
 
 	/* Update sched domains and load balance flag */
 	update_partition_sd_lb(cs, old_prs);
-- 
2.31.1

