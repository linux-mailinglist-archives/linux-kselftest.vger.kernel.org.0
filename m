Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF1D39ACC2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jun 2021 23:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhFCV0p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Jun 2021 17:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230142AbhFCV0o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Jun 2021 17:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622755499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=GkmIg8bE7S1WoSNpL21X7dB+1Pyrh8layWzpnydtRXY=;
        b=EVTqL/9U/2aISjmClatmK6FG73xHRn5GDOzV2JBHl7646jdVXyaaOg4pI6KG2sAv6gNITY
        QB3kPAxIca9N34tTjhNFdne6nH3F0pLKVva0d5cVwvZwDCOIfpLANinVvqgGng1RpQ5exW
        t9Z79Tn7e3fM56UUgUO8SkNIx9nLab0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-G2u11jBtOtWcrcd370-b2A-1; Thu, 03 Jun 2021 17:24:58 -0400
X-MC-Unique: G2u11jBtOtWcrcd370-b2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C002110074A7;
        Thu,  3 Jun 2021 21:24:55 +0000 (UTC)
Received: from llong.com (ovpn-116-222.rdu2.redhat.com [10.10.116.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E12A50FA1;
        Thu,  3 Jun 2021 21:24:54 +0000 (UTC)
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
Subject: [PATCH 2/5] cgroup/cpuset: Add new cpus.partition type with no load balancing
Date:   Thu,  3 Jun 2021 17:24:13 -0400
Message-Id: <20210603212416.25934-3-longman@redhat.com>
In-Reply-To: <20210603212416.25934-1-longman@redhat.com>
References: <20210603212416.25934-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
"root-nolb" is added which allows the creation of a cpuset partition with
no load balancing. This will allow system administrators to dynamically
adjust the size of the no load balancing partition to the current need
of the workload without rebooting the system.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 64 ++++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 65ad6995ad77..78dd6c91dcd6 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -169,6 +169,8 @@ struct cpuset {
  *
  *   1 - partition root
  *
+ *   2 - partition root (no load balance)
+ *
  *  -1 - invalid partition root
  *       None of the cpus in cpus_allowed can be put into the parent's
  *       subparts_cpus. In this case, the cpuset is not a real partition
@@ -178,6 +180,7 @@ struct cpuset {
  */
 #define PRS_DISABLED		0
 #define PRS_ENABLED		1
+#define PRS_ENABLED_NOLB	2
 #define PRS_ERROR		-1
 
 /*
@@ -1246,6 +1249,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		 */
 		switch (cpuset->partition_root_state) {
 		case PRS_ENABLED:
+		case PRS_ENABLED_NOLB:
 			if (part_error)
 				cpuset->partition_root_state = PRS_ERROR;
 			break;
@@ -1943,30 +1947,29 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 
 /*
  * update_prstate - update partititon_root_state
- * cs:	the cpuset to update
- * val: 0 - disabled, 1 - enabled
+ * cs:	    the cpuset to update
+ * new_prs: new partition root state
  *
  * Call with cpuset_mutex held.
  */
-static int update_prstate(struct cpuset *cs, int val)
+static int update_prstate(struct cpuset *cs, int new_prs)
 {
 	int err;
 	struct cpuset *parent = parent_cs(cs);
-	struct tmpmasks tmp;
+	struct tmpmasks tmpmask;
+	bool sched_domain_rebuilt = false;
 
-	if ((val != 0) && (val != 1))
-		return -EINVAL;
-	if (val == cs->partition_root_state)
+	if (new_prs == cs->partition_root_state)
 		return 0;
 
 	/*
 	 * Cannot force a partial or invalid partition root to a full
 	 * partition root.
 	 */
-	if (val && cs->partition_root_state)
+	if (new_prs && (cs->partition_root_state < 0))
 		return -EINVAL;
 
-	if (alloc_cpumasks(NULL, &tmp))
+	if (alloc_cpumasks(NULL, &tmpmask))
 		return -ENOMEM;
 
 	err = -EINVAL;
@@ -1984,12 +1987,31 @@ static int update_prstate(struct cpuset *cs, int val)
 			goto out;
 
 		err = update_parent_subparts_cpumask(cs, partcmd_enable,
-						     NULL, &tmp);
+						     NULL, &tmpmask);
+
 		if (err) {
 			update_flag(CS_CPU_EXCLUSIVE, cs, 0);
 			goto out;
+		} else if (new_prs == PRS_ENABLED_NOLB) {
+			/*
+			 * Disable the load balance flag should not return an
+			 * error unless the system is running out of memory.
+			 */
+			update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
+			sched_domain_rebuilt = true;
 		}
-		cs->partition_root_state = PRS_ENABLED;
+
+		cs->partition_root_state = new_prs;
+	} else if (cs->partition_root_state && new_prs) {
+		/*
+		 * A change in load balance state only, no change in cpumasks.
+		 */
+		update_flag(CS_SCHED_LOAD_BALANCE, cs,
+			    (new_prs != PRS_ENABLED_NOLB));
+
+		cs->partition_root_state = new_prs;
+		err = 0;
+		goto out;	/* Sched domain is rebuilt in update_flag() */
 	} else {
 		/*
 		 * Turning off partition root will clear the
@@ -2003,7 +2025,7 @@ static int update_prstate(struct cpuset *cs, int val)
 		}
 
 		err = update_parent_subparts_cpumask(cs, partcmd_disable,
-						     NULL, &tmp);
+						     NULL, &tmpmask);
 		if (err)
 			goto out;
 
@@ -2011,6 +2033,12 @@ static int update_prstate(struct cpuset *cs, int val)
 
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
@@ -2021,11 +2049,12 @@ static int update_prstate(struct cpuset *cs, int val)
 		update_tasks_cpumask(parent);
 
 	if (parent->child_ecpus_count)
-		update_sibling_cpumasks(parent, cs, &tmp);
+		update_sibling_cpumasks(parent, cs, &tmpmask);
 
-	rebuild_sched_domains_locked();
+	if (!sched_domain_rebuilt)
+		rebuild_sched_domains_locked();
 out:
-	free_cpumasks(NULL, &tmp);
+	free_cpumasks(NULL, &tmpmask);
 	return err;
 }
 
@@ -2518,6 +2547,9 @@ static int sched_partition_show(struct seq_file *seq, void *v)
 	case PRS_ENABLED:
 		seq_puts(seq, "root\n");
 		break;
+	case PRS_ENABLED_NOLB:
+		seq_puts(seq, "root-nolb\n");
+		break;
 	case PRS_DISABLED:
 		seq_puts(seq, "member\n");
 		break;
@@ -2544,6 +2576,8 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 		val = PRS_ENABLED;
 	else if (!strcmp(buf, "member"))
 		val = PRS_DISABLED;
+	else if (!strcmp(buf, "root-nolb"))
+		val = PRS_ENABLED_NOLB;
 	else
 		return -EINVAL;
 
-- 
2.18.1

