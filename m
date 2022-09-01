Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18405AA11F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 22:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiIAU61 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 16:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbiIAU6Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 16:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE879A993
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Sep 2022 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662065901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gMnIc1DxJTwqCxueqMFDO4d5MiXT6iHBs4E8HuDXzH8=;
        b=IohHwPnidkhdePdEvaFJS7cqP62duTX77kjWU0wv075zoQWjQ0ppgeXrJr9E2wT0K2z0CJ
        PoZO1a6K9uArD7dqM0K3z/xtnUFCjgiW1mzOjULlOklSQ5ldlGZGeVc3zGwai62k2yHvp3
        z1IUjDFTj8dErpszHtiXuqoORCddqdA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-DhB8kyp8MhyiSJbF9iqVeg-1; Thu, 01 Sep 2022 16:58:17 -0400
X-MC-Unique: DhB8kyp8MhyiSJbF9iqVeg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E7D18037AF;
        Thu,  1 Sep 2022 20:58:16 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5CE91410DD5;
        Thu,  1 Sep 2022 20:58:15 +0000 (UTC)
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
Subject: [PATCH v12 01/10] cgroup/cpuset: Enable update_tasks_cpumask() on top_cpuset
Date:   Thu,  1 Sep 2022 16:57:36 -0400
Message-Id: <20220901205745.323326-2-longman@redhat.com>
In-Reply-To: <20220901205745.323326-1-longman@redhat.com>
References: <20220901205745.323326-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Previously, update_tasks_cpumask() is not supposed to be called with
top cpuset. With cpuset partition that takes CPUs away from the top
cpuset, adjusting the cpus_mask of the tasks in the top cpuset is
necessary. Percpu kthreads, however, are ignored.

Fixes: ee8dde0cd2ce ("cpuset: Add new v2 cpuset.sched.partition flag")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1f3a55297f39..50bf837571ac 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -33,6 +33,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/kmod.h>
+#include <linux/kthread.h>
 #include <linux/list.h>
 #include <linux/mempolicy.h>
 #include <linux/mm.h>
@@ -1127,10 +1128,18 @@ static void update_tasks_cpumask(struct cpuset *cs)
 {
 	struct css_task_iter it;
 	struct task_struct *task;
+	bool top_cs = cs == &top_cpuset;
 
 	css_task_iter_start(&cs->css, 0, &it);
-	while ((task = css_task_iter_next(&it)))
+	while ((task = css_task_iter_next(&it))) {
+		/*
+		 * Percpu kthreads in top_cpuset are ignored
+		 */
+		if (top_cs && (task->flags & PF_KTHREAD) &&
+		    kthread_is_per_cpu(task))
+			continue;
 		set_cpus_allowed_ptr(task, cs->effective_cpus);
+	}
 	css_task_iter_end(&it);
 }
 
@@ -2092,12 +2101,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		update_flag(CS_CPU_EXCLUSIVE, cs, 0);
 	}
 
-	/*
-	 * Update cpumask of parent's tasks except when it is the top
-	 * cpuset as some system daemons cannot be mapped to other CPUs.
-	 */
-	if (parent != &top_cpuset)
-		update_tasks_cpumask(parent);
+	update_tasks_cpumask(parent);
 
 	if (parent->child_ecpus_count)
 		update_sibling_cpumasks(parent, cs, &tmpmask);
-- 
2.31.1

