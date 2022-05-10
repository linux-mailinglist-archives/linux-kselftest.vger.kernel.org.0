Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA802521EFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 17:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346097AbiEJPjj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346039AbiEJPjQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 11:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 722BE227079
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652196877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LdXD9yJFaOeo2pHNThXvtRNDE3czSMc0peQhxLvTF7o=;
        b=hI7aazmXSaUYvBavlmr5Ow90PMrKYJEA0+nmGPClW7bQdDN8DyHxfC2tPE/6I+vb0lXfHy
        6JPgGBY1R+5XA83OlhveUBT0qJCzNECUiG0oBUaQK+uywq2Vz0eE6LuxYGe33T7XzzU7G5
        Hobk+S8iwI9bApg0lcRMs2gUXPgSTGM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-6wYEIJahNQONbCaTUon1cg-1; Tue, 10 May 2022 11:34:34 -0400
X-MC-Unique: 6wYEIJahNQONbCaTUon1cg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E13210665A7;
        Tue, 10 May 2022 15:34:33 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B597B401E31;
        Tue, 10 May 2022 15:34:32 +0000 (UTC)
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
Subject: [PATCH v11 1/8] cgroup/cpuset: Add top_cpuset check in update_tasks_cpumask()
Date:   Tue, 10 May 2022 11:34:06 -0400
Message-Id: <20220510153413.400020-2-longman@redhat.com>
In-Reply-To: <20220510153413.400020-1-longman@redhat.com>
References: <20220510153413.400020-1-longman@redhat.com>
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

Right now, update_tasks_cpumask() is not supposed to be called with top
cpuset.  With cpuset partition that takes CPUs away from the top cpuset,
we may want to consider adjusting the cpu_allows mask of the tasks in
the top cpuset as well. However, we need more investigation to figure
out a way to do that without breaking non-cgroup aware applications in
the top cpuset. So move the top_cpuset check into update_tasks_cpumask()
and add a comment about possible future work.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9390bfd9f1cd..d90f33b068a3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1128,6 +1128,14 @@ static void update_tasks_cpumask(struct cpuset *cs)
 	struct css_task_iter it;
 	struct task_struct *task;
 
+	/*
+	 * TODO: With cpuset partition that takes CPUs away from the top
+	 * cpuset, we may want to properly adjust the cpus_allowed mask of
+	 * tasks in the top cpuset as well.
+	 */
+	if (cs == &top_cpuset)
+		return;
+
 	css_task_iter_start(&cs->css, 0, &it);
 	while ((task = css_task_iter_next(&it)))
 		set_cpus_allowed_ptr(task, cs->effective_cpus);
@@ -2092,12 +2100,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
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
2.27.0

