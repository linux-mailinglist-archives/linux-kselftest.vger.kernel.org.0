Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CB76ACEDF
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 21:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjCFUKR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 15:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjCFUKQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 15:10:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C214C497F3
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 12:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678133368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMpGzFxDVrhKLpAq2mb4oo3DA00+S6OlDRBjGlenDeM=;
        b=HB6Yo4iRo4xY9Lh/ZKtrxfmY3hVZPCBdeV9clOdmW5pg0o0KopD8zJJ0AHkZCJhrr3T5NR
        qGd1M2pqsXadddu+DLiPPGbhgyNS8iwuzGgoWkXghs03AHV3rAeN4fm2ic5ebasI0R9zJk
        g46qOO6nEUQ0cTsE+1rzqDpIkRibPXw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-qTnL-CUCNN6x3dhM75SdCw-1; Mon, 06 Mar 2023 15:09:27 -0500
X-MC-Unique: qTnL-CUCNN6x3dhM75SdCw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1C51857A89;
        Mon,  6 Mar 2023 20:09:26 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DA934010E7B;
        Mon,  6 Mar 2023 20:09:26 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/5] cgroup/cpuset: Include offline CPUs when tasks' cpumasks in top_cpuset are updated
Date:   Mon,  6 Mar 2023 15:08:46 -0500
Message-Id: <20230306200849.376804-3-longman@redhat.com>
In-Reply-To: <20230306200849.376804-1-longman@redhat.com>
References: <20230306200849.376804-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Similar to commit 3fb906e7fabb ("group/cpuset: Don't filter offline
CPUs in cpuset_cpus_allowed() for top cpuset tasks"), the whole set of
possible CPUs including offline ones should be used for setting cpumasks
for tasks in the top cpuset when a cpuset partition is modified.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a801abad3bac..bbf57dcb2f68 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1209,7 +1209,8 @@ void rebuild_sched_domains(void)
  *
  * Iterate through each task of @cs updating its cpus_allowed to the
  * effective cpuset's.  As this function is called with cpuset_rwsem held,
- * cpuset membership stays stable.
+ * cpuset membership stays stable. For top_cpuset, task_cpu_possible_mask()
+ * is used instead of effective_cpus.
  */
 static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 {
@@ -1219,15 +1220,18 @@ static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 
 	css_task_iter_start(&cs->css, 0, &it);
 	while ((task = css_task_iter_next(&it))) {
-		/*
-		 * Percpu kthreads in top_cpuset are ignored
-		 */
-		if (top_cs && (task->flags & PF_KTHREAD) &&
-		    kthread_is_per_cpu(task))
-			continue;
+		const struct cpumask *possible_mask = task_cpu_possible_mask(task);
 
-		cpumask_and(new_cpus, cs->effective_cpus,
-			    task_cpu_possible_mask(task));
+		if (top_cs) {
+			/*
+			 * Percpu kthreads in top_cpuset are ignored
+			 */
+			if ((task->flags & PF_KTHREAD) && kthread_is_per_cpu(task))
+				continue;
+			cpumask_andnot(new_cpus, possible_mask, cs->subparts_cpus);
+		} else {
+			cpumask_and(new_cpus, cs->effective_cpus, possible_mask);
+		}
 		set_cpus_allowed_ptr(task, new_cpus);
 	}
 	css_task_iter_end(&it);
-- 
2.31.1

