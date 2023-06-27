Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27AD73FE21
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 16:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjF0OiN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 10:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjF0Ohj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 10:37:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBC33A9D
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 07:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687876591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPhp6M85RYtJ1OdHBAv4hPr3cT4UKKt6nbqDvx5A+ks=;
        b=P0gNoazrLnqjACHEdiMvfYPjYWi9dcYIvEsE1bP/6ZfiM1jBxyLrVr3K5BLNp5An+wb9XA
        p9KdHbhXx23vSH3infRCbe7fD/kIPDfBGTYZwfC0hsZVgast3jSHPqF4sBUGJgy8cfKItV
        WZQ1nQxXy0jCit70kNPYEzoA6M3Xzas=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-Vev_qGdZOKez7MZmmuh2sg-1; Tue, 27 Jun 2023 10:36:18 -0400
X-MC-Unique: Vev_qGdZOKez7MZmmuh2sg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CDD1185A7B3;
        Tue, 27 Jun 2023 14:35:34 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 955C240C2063;
        Tue, 27 Jun 2023 14:35:33 +0000 (UTC)
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
Subject: [PATCH v4 3/9] cgroup/cpuset: Improve temporary cpumasks handling
Date:   Tue, 27 Jun 2023 10:35:02 -0400
Message-Id: <20230627143508.1576882-4-longman@redhat.com>
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

The limitation that update_parent_subparts_cpumask() can only use
addmask & delmask in the given tmp cpumasks is fragile and may lead to
unexpected error.

Fix this problem by allocating/freeing a struct tmpmasks in
update_cpumask() to avoid reusing the cpumasks in trial_cs.

With this change, we can move the update_tasks_cpumask() for the
parent and update_sibling_cpumasks() for the sibling to inside
update_parent_subparts_cpumask().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ade33e50ffe2..b8ccc1be7bde 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1277,6 +1277,8 @@ enum subparts_cmd {
 
 static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 		       int turning_on);
+static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
+				    struct tmpmasks *tmp);
 
 /*
  * Update partition exclusive flag
@@ -1447,7 +1449,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		adding = cpumask_andnot(tmp->addmask, tmp->addmask,
 					parent->subparts_cpus);
 		/*
-		 * Empty cpumask is not allewed
+		 * Empty cpumask is not allowed
 		 */
 		if (cpumask_empty(newmask)) {
 			part_error = PERR_CPUSEMPTY;
@@ -1567,8 +1569,11 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 
 	spin_unlock_irq(&callback_lock);
 
-	if (adding || deleting)
+	if (adding || deleting) {
 		update_tasks_cpumask(parent, tmp->addmask);
+		if (parent->child_ecpus_count)
+			update_sibling_cpumasks(parent, cs, tmp);
+	}
 
 	/*
 	 * For partcmd_update without newmask, it is being called from
@@ -1842,18 +1847,8 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (cpumask_equal(cs->cpus_allowed, trialcs->cpus_allowed))
 		return 0;
 
-#ifdef CONFIG_CPUMASK_OFFSTACK
-	/*
-	 * Use the cpumasks in trialcs for tmpmasks when they are pointers
-	 * to allocated cpumasks.
-	 *
-	 * Note that update_parent_subparts_cpumask() uses only addmask &
-	 * delmask, but not new_cpus.
-	 */
-	tmp.addmask  = trialcs->subparts_cpus;
-	tmp.delmask  = trialcs->effective_cpus;
-	tmp.new_cpus = NULL;
-#endif
+	if (alloc_cpumasks(NULL, &tmp))
+		return -ENOMEM;
 
 	retval = validate_change(cs, trialcs);
 
@@ -1882,7 +1877,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		retval = 0;
 	}
 	if (retval < 0)
-		return retval;
+		goto out_free;
 
 	if (cs->partition_root_state) {
 		if (invalidate)
@@ -1917,11 +1912,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	}
 	spin_unlock_irq(&callback_lock);
 
-#ifdef CONFIG_CPUMASK_OFFSTACK
-	/* Now trialcs->cpus_allowed is available */
-	tmp.new_cpus = trialcs->cpus_allowed;
-#endif
-
 	/* effective_cpus will be updated here */
 	update_cpumasks_hier(cs, &tmp, false);
 
@@ -1938,6 +1928,8 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		/* Update CS_SCHED_LOAD_BALANCE and/or sched_domains */
 		update_partition_sd_lb(cs, old_prs);
 	}
+out_free:
+	free_cpumasks(NULL, &tmp);
 	return 0;
 }
 
@@ -2346,13 +2338,11 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 
 		err = update_parent_subparts_cpumask(cs, partcmd_enable,
 						     NULL, &tmpmask);
-		if (err)
-			goto out;
 	} else if (old_prs && new_prs) {
 		/*
 		 * A change in load balance state only, no change in cpumasks.
 		 */
-		goto out;
+		;
 	} else {
 		/*
 		 * Switching back to member is always allowed even if it
@@ -2372,12 +2362,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 			spin_unlock_irq(&callback_lock);
 		}
 	}
-
-	update_tasks_cpumask(parent, tmpmask.new_cpus);
-
-	if (parent->child_ecpus_count)
-		update_sibling_cpumasks(parent, cs, &tmpmask);
-
 out:
 	/*
 	 * Make partition invalid & disable CS_CPU_EXCLUSIVE if an error
-- 
2.31.1

