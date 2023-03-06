Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566816ACEF4
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 21:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCFUMB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 15:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCFULt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 15:11:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06AC4DE37
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 12:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678133371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPOLCRRq9h+M6y4H0byc+i6v9jsYVGqazZOEyY69QjU=;
        b=Y5+9M7ELitWzmrDc/TN2dbrXqgDpq4Yv1uTBgAKxB1l1ETvqX3GgYzUNy//reKguDenYLX
        OdLJS1SLiY8lnKYjcu6q3q9kWkScISCDfB+8iZSZKfVoXcAACV2Jf4GImRjeWLlC/g6s1N
        A+55NtkINZeGOulCBcSlnFSz5P8UCBo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-WJXboG_qNv6uRFmfnQGtTw-1; Mon, 06 Mar 2023 15:09:27 -0500
X-MC-Unique: WJXboG_qNv6uRFmfnQGtTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07FEE3C025B2;
        Mon,  6 Mar 2023 20:09:27 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B89C940C83B6;
        Mon,  6 Mar 2023 20:09:26 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 3/5] cgroup/cpuset: Find another usable CPU if none found in current cpuset
Date:   Mon,  6 Mar 2023 15:08:47 -0500
Message-Id: <20230306200849.376804-4-longman@redhat.com>
In-Reply-To: <20230306200849.376804-1-longman@redhat.com>
References: <20230306200849.376804-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On a system with asymmetric CPUs, a restricted task is one that can run
only a selected subset of available CPUs.  When a CPU goes offline or
when "cpuset.cpus" is changed, it is possible that a restricted task
may not have any runnable CPUs left in the current cpuset even if there
is still some CPUs in effective_cpus. In this case, the restricted task
cannot be run at all.

There are several ways we may be able to handle this situation. Treating
it like empty effective_cpus is probably too disruptive and is unfair to
the normal tasks. So it is better to have some special handling for these
restricted tasks. One possibility is to move the restricted tasks up the
cpuset hierarchy, but it is tricky to do it right. Another solution is
to assign other usable CPUs to these tasks. This patch implements the
later alternative by finding one usable CPU by walking up the cpuset
hierarchy and printing an informational message to let the users know
that these restricted tasks are running in a cpuset with no usable CPU.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 56 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index bbf57dcb2f68..aa8225daf1d3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1202,6 +1202,38 @@ void rebuild_sched_domains(void)
 	cpus_read_unlock();
 }
 
+/*
+ * Find a usable effective (online) CPU up the cpuset hierarchy and return it.
+ */
+static int find_usable_cpu(struct cpuset *cs, struct cpumask *new_cpus,
+			   const struct cpumask *possible_mask)
+{
+	struct cpuset *parent;
+	unsigned long flags;
+	int cpu;
+
+	/*
+	 * When offlining cpu, some effective_cpus may not be up to date.
+	 * So check cpu_online_mask to be sure.
+	 */
+	parent = parent_cs(cs);
+	while (parent &&
+	      (!cpumask_and(new_cpus, parent->effective_cpus, possible_mask) ||
+	       !cpumask_and(new_cpus, new_cpus, cpu_online_mask)))
+		parent = parent_cs(cs);
+
+	/* Fall back to all possible online cpus, if necessary */
+	if (!parent)
+		cpumask_and(new_cpus, possible_mask, cpu_online_mask);
+
+	/* cpumask_any_distribute() has to be called with preemption disabled */
+	local_irq_save(flags);
+	cpu = cpumask_any_distribute(new_cpus);
+	local_irq_restore(flags);
+
+	return cpu;
+}
+
 /**
  * update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
  * @cs: the cpuset in which each task's cpus_allowed mask needs to be changed
@@ -1218,6 +1250,7 @@ static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 	struct task_struct *task;
 	bool top_cs = cs == &top_cpuset;
 
+	percpu_rwsem_assert_held(&cpuset_rwsem);
 	css_task_iter_start(&cs->css, 0, &it);
 	while ((task = css_task_iter_next(&it))) {
 		const struct cpumask *possible_mask = task_cpu_possible_mask(task);
@@ -1232,7 +1265,28 @@ static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 		} else {
 			cpumask_and(new_cpus, cs->effective_cpus, possible_mask);
 		}
-		set_cpus_allowed_ptr(task, new_cpus);
+		/*
+		 * On systems with assymetric CPUs, it is possible that
+		 * cpumask will become empty or set_cpus_allowed_ptr() will
+		 * return an error even if we still have CPUs in
+		 * effective_cpus. In this case, we find a usable CPU walking
+		 * up the cpuset hierarchy and use that for this particular
+		 * task with an informational message about the change in the
+		 * hope that the users will adjust "cpuset.cpus" accordingly.
+		 */
+		if (cpumask_empty(new_cpus) ||
+		    set_cpus_allowed_ptr(task, new_cpus)) {
+			char name[80];
+			int cpu;
+
+			cpu = find_usable_cpu(cs, new_cpus, possible_mask);
+			cpumask_clear(new_cpus);
+			cpumask_set_cpu(cpu, new_cpus);
+			WARN_ON_ONCE(set_cpus_allowed_ptr(task, new_cpus));
+			cgroup_name(cs->css.cgroup, name, sizeof(name));
+			pr_info("cpuset: Restricted task %s(%d) in cpuset %s is forced to run on outside CPU %d\n",
+				task->comm, task->pid, name, cpu);
+		}
 	}
 	css_task_iter_end(&it);
 }
-- 
2.31.1

