Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4120431FF3
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 16:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhJROkJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 10:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232170AbhJROkH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 10:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634567875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DgD89ffo3d0V7AdPQW/l9aZ1vU22bPCLKKNskpIYKIQ=;
        b=YIKGfwXERN2cfosHSwN6ArTPoUO0n2jrxMYDZrcimBO7ohKVXyQ+SJ/LbqCEkFLaSBMfmt
        nfM4y8z5UPqTNddSA9qdRT78XE9WeYRGFRCoC50hIm0FydKislMZSAKJ2+NGCPBSU7ZFuV
        sE37QEa8emGugncdwi+V5zj/jiTQztM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-mSRi0j5uPRyzmj-MGHvn_g-1; Mon, 18 Oct 2021 10:37:50 -0400
X-MC-Unique: mSRi0j5uPRyzmj-MGHvn_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 179DD18414A0;
        Mon, 18 Oct 2021 14:37:48 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1742D62A44;
        Mon, 18 Oct 2021 14:37:46 +0000 (UTC)
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
Subject: [PATCH v8 3/6] cgroup/cpuset: Add a new isolated cpus.partition type
Date:   Mon, 18 Oct 2021 10:36:16 -0400
Message-Id: <20211018143619.205065-4-longman@redhat.com>
In-Reply-To: <20211018143619.205065-1-longman@redhat.com>
References: <20211018143619.205065-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
---
 kernel/cgroup/cpuset.c | 46 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e2c01345353c..fab31921728c 100644
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
@@ -1306,17 +1309,22 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 
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
@@ -1461,6 +1469,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 				break;
 
 			case PRS_ENABLED:
+			case PRS_ISOLATED:
 				update_parent = true;
 				break;
 
@@ -2028,6 +2037,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 static int update_prstate(struct cpuset *cs, int new_prs)
 {
 	int err, old_prs = cs->partition_root_state;
+	bool sched_domain_rebuilt = false;
 	struct cpuset *parent = parent_cs(cs);
 	struct tmpmasks tmpmask;
 
@@ -2064,6 +2074,22 @@ static int update_prstate(struct cpuset *cs, int new_prs)
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
 		 * Switch back to member is always allowed even if it
@@ -2085,6 +2111,12 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 
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
@@ -2097,7 +2129,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (parent->child_ecpus_count)
 		update_sibling_cpumasks(parent, cs, &tmpmask);
 
-	rebuild_sched_domains_locked();
+	if (!sched_domain_rebuilt)
+		rebuild_sched_domains_locked();
 out:
 	if (!err) {
 		spin_lock_irq(&callback_lock);
@@ -2609,6 +2642,9 @@ static int sched_partition_show(struct seq_file *seq, void *v)
 	case PRS_ENABLED:
 		seq_puts(seq, "root\n");
 		break;
+	case PRS_ISOLATED:
+		seq_puts(seq, "isolated\n");
+		break;
 	case PRS_DISABLED:
 		seq_puts(seq, "member\n");
 		break;
@@ -2635,6 +2671,8 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 		val = PRS_ENABLED;
 	else if (!strcmp(buf, "member"))
 		val = PRS_DISABLED;
+	else if (!strcmp(buf, "isolated"))
+		val = PRS_ISOLATED;
 	else
 		return -EINVAL;
 
-- 
2.27.0

