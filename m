Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7924C3AF593
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jun 2021 20:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhFUSwJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Jun 2021 14:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231837AbhFUSwI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Jun 2021 14:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624301393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=zfbfrPHMuH9BhoShKSNl8HpvN2zY1oB+GFWyMLBrSS4=;
        b=DgIuEOrxE9abY4m2ZGr8Tv7L6tU4DlzzwTqEe6NHrOHm8BbzdW7oIGMZZgDNMENSEQitRy
        V8ONbXkD29GMCsfRl0BB1zm16oueJAvqZaK8w1ryse617mz6L6inBDRTODyx+yHykaKeWL
        rHGXdq1mimsoVACuIRJRrKoIW6NNOmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-9JVMbVOpMdC7U1EYTU8tzw-1; Mon, 21 Jun 2021 14:49:52 -0400
X-MC-Unique: 9JVMbVOpMdC7U1EYTU8tzw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A4DF19067E0;
        Mon, 21 Jun 2021 18:49:50 +0000 (UTC)
Received: from llong.com (ovpn-114-127.rdu2.redhat.com [10.10.114.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D301E5D9CA;
        Mon, 21 Jun 2021 18:49:48 +0000 (UTC)
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
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 3/6] cgroup/cpuset: Add a new isolated cpus.partition type
Date:   Mon, 21 Jun 2021 14:49:21 -0400
Message-Id: <20210621184924.27493-4-longman@redhat.com>
In-Reply-To: <20210621184924.27493-1-longman@redhat.com>
References: <20210621184924.27493-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=TBD

commit 994fb794cb252edd124a46ca0994e37a4726a100
Author: Waiman Long <longman@redhat.com>
Date:   Sat, 19 Jun 2021 13:28:19 -0400

    cgroup/cpuset: Add a new isolated cpus.partition type

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

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 53 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3fe68d0f593d..1a4b90e70e68 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -169,6 +169,8 @@ struct cpuset {
  *
  *   1 - partition root
  *
+ *   2 - partition root without load balancing (isolated)
+ *
  *  -1 - invalid partition root
  *       None of the cpus in cpus_allowed can be put into the parent's
  *       subparts_cpus. In this case, the cpuset is not a real partition
@@ -180,6 +182,7 @@ struct cpuset {
  */
 #define PRS_DISABLED		0
 #define PRS_ENABLED		1
+#define PRS_ISOLATED		2
 #define PRS_ERROR		-1
 
 /*
@@ -1267,17 +1270,22 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		int prev_prs = cpuset->partition_root_state;
 
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
 				cpuset->partition_root_state = PRS_ERROR;
 			break;
 		case PRS_ERROR:
-			if (!part_error)
+			if (part_error)
+				break;
+			if (is_sched_load_balance(cpuset))
 				cpuset->partition_root_state = PRS_ENABLED;
+			else
+				cpuset->partition_root_state = PRS_ISOLATED;
 			break;
 		}
 		/*
@@ -1409,6 +1417,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 				break;
 
 			case PRS_ENABLED:
+			case PRS_ISOLATED:
 				if (update_parent_subparts_cpumask(cp, partcmd_update, NULL, tmp))
 					update_tasks_cpumask(parent);
 				break;
@@ -1429,7 +1438,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 		spin_lock_irq(&callback_lock);
 
 		if (cp->nr_subparts_cpus &&
-		   (cp->partition_root_state != PRS_ENABLED)) {
+		   (cp->partition_root_state <= 0)) {
 			/*
 			 * Put all active subparts_cpus back to effective_cpus.
 			 */
@@ -1963,6 +1972,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	int err;
 	struct cpuset *parent = parent_cs(cs);
 	struct tmpmasks tmpmask;
+	bool sched_domain_rebuilt = false;
 
 	if (new_prs == cs->partition_root_state)
 		return 0;
@@ -1993,11 +2003,30 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 
 		err = update_parent_subparts_cpumask(cs, partcmd_enable,
 						     NULL, &tmpmask);
+
 		if (err) {
 			update_flag(CS_CPU_EXCLUSIVE, cs, 0);
 			goto out;
 		}
-		cs->partition_root_state = PRS_ENABLED;
+		if (new_prs == PRS_ISOLATED) {
+			/*
+			 * Disable the load balance flag should not return an
+			 * error unless the system is running out of memory.
+			 */
+			update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
+			sched_domain_rebuilt = true;
+		}
+
+		cs->partition_root_state = new_prs;
+	} else if (cs->partition_root_state && new_prs) {
+		/*
+		 * A change in load balance state only, no change in cpumasks.
+		 */
+		update_flag(CS_SCHED_LOAD_BALANCE, cs, (new_prs != PRS_ISOLATED));
+
+		cs->partition_root_state = new_prs;
+		err = 0;
+		goto out;	/* Sched domain is rebuilt in update_flag() */
 	} else {
 		/*
 		 * Switch back to member is always allowed if PRS_ERROR.
@@ -2024,6 +2053,12 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 
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
@@ -2036,7 +2071,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (parent->child_ecpus_count)
 		update_sibling_cpumasks(parent, cs, &tmpmask);
 
-	rebuild_sched_domains_locked();
+	if (!sched_domain_rebuilt)
+		rebuild_sched_domains_locked();
 out:
 	free_cpumasks(NULL, &tmpmask);
 	return err;
@@ -2531,6 +2567,9 @@ static int sched_partition_show(struct seq_file *seq, void *v)
 	case PRS_ENABLED:
 		seq_puts(seq, "root\n");
 		break;
+	case PRS_ISOLATED:
+		seq_puts(seq, "isolated\n");
+		break;
 	case PRS_DISABLED:
 		seq_puts(seq, "member\n");
 		break;
@@ -2557,6 +2596,8 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 		val = PRS_ENABLED;
 	else if (!strcmp(buf, "member"))
 		val = PRS_DISABLED;
+	else if (!strcmp(buf, "isolated"))
+		val = PRS_ISOLATED;
 	else
 		return -EINVAL;
 
-- 
2.18.1

