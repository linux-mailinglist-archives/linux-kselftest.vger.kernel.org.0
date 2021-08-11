Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE503E88A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 05:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhHKDHU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Aug 2021 23:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36772 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233301AbhHKDHN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Aug 2021 23:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628651210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Svn/Bcwp8huCI7CPn3mMAsSAHCQwNYqlFj/xnuaFvnc=;
        b=DL2Fb3DLU+8fp0EcQDlIxdwZHtEvtx2g4orw08jYyK1LpxxKzhUl79iTwvtNg5wTfkQmKC
        HhdP+mAZIPkA1wk5D39ghlsjSMaTrHIC7WpBrXfVd2vQRsyo79S9COUutrKJpJy3hcrrLv
        0jpdzg26j6qAiYfjV9Slb/PxaS/2FvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-eBhVoxclOv2hQILcar3kHA-1; Tue, 10 Aug 2021 23:06:47 -0400
X-MC-Unique: eBhVoxclOv2hQILcar3kHA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0FD91008060;
        Wed, 11 Aug 2021 03:06:44 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBCBE5D6CF;
        Wed, 11 Aug 2021 03:06:42 +0000 (UTC)
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
Subject: [PATCH v4 3/6] cgroup/cpuset: Add a new isolated cpus.partition type
Date:   Tue, 10 Aug 2021 23:06:04 -0400
Message-Id: <20210811030607.13824-4-longman@redhat.com>
In-Reply-To: <20210811030607.13824-1-longman@redhat.com>
References: <20210811030607.13824-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cpuset v1 uses the sched_load_balance control file to determine if load
balancing should be enabled.  Cpuset v2 gets rid of sched_load_balance
as its use may require disabling load balancing at cgroup root.

For workloads that require very low latency like DPDK, the latency
jitters caused by periodic load balancing may exceed the desired
latency limit.

When cpuset v2 is in use, the only way to avoid this latency cost is to
use the "isolcpus=" kernel boot option to isolate a set of CPUs. After
the kernel boot, however, there is no way to add or remove CPUs from
this isolated set. For workloads that are more dynamic in nature, that
means users have to provision enough CPUs for the worst case situation
resulting in excess idle CPUs.

To address this issue for cpuset v2, a new cpuset.cpus.partition type
"isolated" is added which allows the creation of a cpuset partition
without load balancing. This will allow system administrators to
dynamically adjust the size of isolated partition to the current need
of the workload without rebooting the system.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 48 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 04db3c84c24b..498fd418fd30 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -172,6 +172,8 @@ struct cpuset {
  *
  *   1 - partition root
  *
+ *   2 - partition root without load balancing (isolated)
+ *
  *  -1 - invalid partition root
  *       None of the cpus in cpus_allowed can be put into the parent's
  *       subparts_cpus. In this case, the cpuset is not a real partition
@@ -181,6 +183,7 @@ struct cpuset {
  */
 #define PRS_DISABLED		0
 #define PRS_ENABLED		1
+#define PRS_ISOLATED		2
 #define PRS_ERROR		-1
 
 /*
@@ -1268,17 +1271,22 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 
 	if (cmd == partcmd_update) {
 		/*
-		 * Check for possible transition between PRS_ENABLED
-		 * and PRS_ERROR.
+		 * Check for possible transition between PRS_ERROR and
+		 * PRS_ENABLED/PRS_ISOLATED.
 		 */
 		switch (cpuset->partition_root_state) {
 		case PRS_ENABLED:
+		case PRS_ISOLATED:
 			if (part_error)
 				new_prs = PRS_ERROR;
 			break;
 		case PRS_ERROR:
-			if (!part_error)
+			if (part_error)
+				break;
+			if (is_sched_load_balance(cpuset))
 				new_prs = PRS_ENABLED;
+			else
+				new_prs = PRS_ISOLATED;
 			break;
 		}
 	}
@@ -1413,6 +1421,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 				break;
 
 			case PRS_ENABLED:
+			case PRS_ISOLATED:
 				if (update_parent_subparts_cpumask(cp, partcmd_update, NULL, tmp))
 					update_tasks_cpumask(parent);
 				/*
@@ -1437,7 +1446,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 
 		spin_lock_irq(&callback_lock);
 
-		if (cp->nr_subparts_cpus && (new_prs != PRS_ENABLED)) {
+		if (cp->nr_subparts_cpus && (new_prs <= 0)) {
 			/*
 			 * Put all active subparts_cpus back to effective_cpus.
 			 */
@@ -1976,6 +1985,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	int err, old_prs = cs->partition_root_state;
 	struct cpuset *parent = parent_cs(cs);
 	struct tmpmasks tmpmask;
+	bool sched_domain_rebuilt = false;
 
 	if (old_prs == new_prs)
 		return 0;
@@ -2010,6 +2020,22 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 			update_flag(CS_CPU_EXCLUSIVE, cs, 0);
 			goto out;
 		}
+
+		if (new_prs == PRS_ISOLATED) {
+			/*
+			 * Disable the load balance flag should not return an
+			 * error unless the system is running out of memory.
+			 */
+			update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
+			sched_domain_rebuilt = true;
+		}
+	} else if (old_prs && new_prs) {
+		/*
+		 * A change in load balance state only, no change in cpumasks.
+		 */
+		update_flag(CS_SCHED_LOAD_BALANCE, cs, (new_prs != PRS_ISOLATED));
+		err = 0;
+		goto out;	/* Sched domain is rebuilt in update_flag() */
 	} else {
 		/*
 		 * Switch back to member is always allowed if PRS_ERROR.
@@ -2034,6 +2060,12 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 reset_flag:
 		/* Turning off CS_CPU_EXCLUSIVE will not return error */
 		update_flag(CS_CPU_EXCLUSIVE, cs, 0);
+
+		if (!is_sched_load_balance(cs)) {
+			/* Make sure load balance is on */
+			update_flag(CS_SCHED_LOAD_BALANCE, cs, 1);
+			sched_domain_rebuilt = true;
+		}
 	}
 
 	/*
@@ -2046,7 +2078,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (parent->child_ecpus_count)
 		update_sibling_cpumasks(parent, cs, &tmpmask);
 
-	rebuild_sched_domains_locked();
+	if (!sched_domain_rebuilt)
+		rebuild_sched_domains_locked();
 out:
 	if (!err) {
 		spin_lock_irq(&callback_lock);
@@ -2548,6 +2581,9 @@ static int sched_partition_show(struct seq_file *seq, void *v)
 	case PRS_ENABLED:
 		seq_puts(seq, "root\n");
 		break;
+	case PRS_ISOLATED:
+		seq_puts(seq, "isolated\n");
+		break;
 	case PRS_DISABLED:
 		seq_puts(seq, "member\n");
 		break;
@@ -2574,6 +2610,8 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 		val = PRS_ENABLED;
 	else if (!strcmp(buf, "member"))
 		val = PRS_DISABLED;
+	else if (!strcmp(buf, "isolated"))
+		val = PRS_ISOLATED;
 	else
 		return -EINVAL;
 
-- 
2.18.1

