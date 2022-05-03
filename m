Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7252751899D
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 May 2022 18:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239301AbiECQ0W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239359AbiECQ0S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 12:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 979F439B9F
        for <linux-kselftest@vger.kernel.org>; Tue,  3 May 2022 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651594964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rVia1pQrXLAijSVfWAWpBEkZYOPuySuFEwnkNUZOK4=;
        b=NhM44CI3lCIo1Xl3pMrLJOzuiT3JhvQ2y2TdXyF3jsBrirhqlLkXyJmPhe/MTrnUWgHiSp
        wjROcoZkrYRiBBQ4GxCbZOGbMgTlYVMwDzWd5Ig94QVhfTZqZLoWw17dhOwIwcm5+wUwQZ
        zrJq9Bpx8eTooOyKu7cSaUZsOkzXs5A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-KuRXog86OYG_rKIEwm-Shg-1; Tue, 03 May 2022 12:22:40 -0400
X-MC-Unique: KuRXog86OYG_rKIEwm-Shg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5A8AC77B43;
        Tue,  3 May 2022 16:22:39 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 576E8463E0B;
        Tue,  3 May 2022 16:22:39 +0000 (UTC)
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
Subject: [PATCH v10 5/8] cgroup/cpuset: Add a new isolated cpus.partition type
Date:   Tue,  3 May 2022 12:21:46 -0400
Message-Id: <20220503162149.1764245-6-longman@redhat.com>
In-Reply-To: <20220503162149.1764245-1-longman@redhat.com>
References: <20220503162149.1764245-1-longman@redhat.com>
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
 kernel/cgroup/cpuset.c | 74 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1f1d76013046..073db69ac8fc 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -177,11 +177,15 @@ struct cpuset {
  *
  *   0 - member (not a partition root)
  *   1 - partition root
+ *   2 - partition root without load balancing (isolated)
  *  -1 - invalid partition root
+ *  -2 - invalid isolated partition root
  */
 #define PRS_MEMBER		0
 #define PRS_ROOT		1
+#define PRS_ISOLATED		2
 #define PRS_INVALID_ROOT	-1
+#define PRS_INVALID_ISOLATED	-2
 
 static inline bool is_prs_invalid(int prs_state)
 {
@@ -278,7 +282,8 @@ static inline int is_partition_invalid(const struct cpuset *cs)
 
 static inline void set_partition_invalid(struct cpuset *cs)
 {
-	cs->partition_root_state = PRS_INVALID_ROOT;
+	if (is_partition_valid(cs))
+		cs->partition_root_state = -cs->partition_root_state;
 }
 
 /*
@@ -1369,17 +1374,19 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 
 	if (cmd == partcmd_update) {
 		/*
-		 * Check for possible transition between PRS_ROOT
-		 * and PRS_INVALID_ROOT.
+		 * Check for possible transition between valid and invalid
+		 * partition root.
 		 */
 		switch (cs->partition_root_state) {
 		case PRS_ROOT:
+		case PRS_ISOLATED:
 			if (part_error)
-				new_prs = PRS_INVALID_ROOT;
+				new_prs = -old_prs;
 			break;
 		case PRS_INVALID_ROOT:
+		case PRS_INVALID_ISOLATED:
 			if (!part_error)
-				new_prs = PRS_ROOT;
+				new_prs = -old_prs;
 			break;
 		}
 	}
@@ -1389,7 +1396,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 
 	/*
 	 * Transitioning from invalid to valid (partcmd_update) may require
-	 * setting CS_CPU_EXCLUSIVE.
+	 * setting CS_CPU_EXCLUSIVE and clearing CS_SCHED_LOAD_BALANCE later.
 	 */
 	if ((old_prs != new_prs) && is_prs_invalid(old_prs)) {
 		if (!is_cpu_exclusive(cs) &&
@@ -1430,8 +1437,17 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	if (adding || deleting)
 		update_tasks_cpumask(parent);
 
+	/*
+	 * Set or clear CS_SCHED_LOAD_BALANCE when partcmd_update, if necessary.
+	 * rebuild_sched_domains_locked() may be called.
+	 */
+	if ((old_prs != new_prs) && (cmd == partcmd_update)) {
+		if (old_prs == PRS_ISOLATED)
+			update_flag(CS_SCHED_LOAD_BALANCE, cs, 1);
+		else if (new_prs == PRS_ISOLATED)
+			update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
+	}
 	notify_partition_change(cs, old_prs);
-
 	return 0;
 }
 
@@ -1506,6 +1522,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		if ((cp != cs) && old_prs) {
 			switch (parent->partition_root_state) {
 			case PRS_ROOT:
+			case PRS_ISOLATED:
 				update_parent = true;
 				break;
 
@@ -1515,7 +1532,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 				 * invalid, child partition roots become
 				 * invalid too.
 				 */
-				new_prs = PRS_INVALID_ROOT;
+				if (is_partition_valid(cp))
+					new_prs = -cp->partition_root_state;
 				break;
 			}
 		}
@@ -2097,6 +2115,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 static int update_prstate(struct cpuset *cs, int new_prs)
 {
 	int err = 0, old_prs = cs->partition_root_state;
+	bool sched_domain_rebuilt = false;
 	struct cpuset *parent = parent_cs(cs);
 	struct tmpmasks tmpmask;
 
@@ -2107,8 +2126,10 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	 * For a previously invalid partition root, leave it at being
 	 * invalid if new_prs is not "member".
 	 */
-	if (new_prs && is_prs_invalid(old_prs))
+	if (new_prs && is_prs_invalid(old_prs)) {
+		cs->partition_root_state = -new_prs;
 		return 0;
+	}
 
 	if (alloc_cpumasks(NULL, &tmpmask))
 		return -ENOMEM;
@@ -2134,6 +2155,22 @@ static int update_prstate(struct cpuset *cs, int new_prs)
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
+		sched_domain_rebuilt = true;
+		goto out;	/* Sched domain is rebuilt in update_flag() */
 	} else {
 		/*
 		 * Switching back to member is always allowed even if it
@@ -2155,6 +2192,12 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 
 		/* Turning off CS_CPU_EXCLUSIVE will not return error */
 		update_flag(CS_CPU_EXCLUSIVE, cs, 0);
+
+		if (!is_sched_load_balance(cs)) {
+			/* Make sure load balance is on */
+			update_flag(CS_SCHED_LOAD_BALANCE, cs, 1);
+			sched_domain_rebuilt = true;
+		}
 	}
 
 	update_tasks_cpumask(parent);
@@ -2162,13 +2205,14 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (parent->child_ecpus_count)
 		update_sibling_cpumasks(parent, cs, &tmpmask);
 
-	rebuild_sched_domains_locked();
+	if (!sched_domain_rebuilt)
+		rebuild_sched_domains_locked();
 out:
 	/*
 	 * Make partition invalid if an error happen
 	 */
 	if (err)
-		new_prs = PRS_INVALID_ROOT;
+		new_prs = -new_prs;
 	spin_lock_irq(&callback_lock);
 	cs->partition_root_state = new_prs;
 	spin_unlock_irq(&callback_lock);
@@ -2680,12 +2724,18 @@ static int sched_partition_show(struct seq_file *seq, void *v)
 	case PRS_ROOT:
 		seq_puts(seq, "root\n");
 		break;
+	case PRS_ISOLATED:
+		seq_puts(seq, "isolated\n");
+		break;
 	case PRS_MEMBER:
 		seq_puts(seq, "member\n");
 		break;
 	case PRS_INVALID_ROOT:
 		seq_puts(seq, "root invalid\n");
 		break;
+	case PRS_INVALID_ISOLATED:
+		seq_puts(seq, "isolated invalid\n");
+		break;
 	}
 	return 0;
 }
@@ -2706,6 +2756,8 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 		val = PRS_ROOT;
 	else if (!strcmp(buf, "member"))
 		val = PRS_MEMBER;
+	else if (!strcmp(buf, "isolated"))
+		val = PRS_ISOLATED;
 	else
 		return -EINVAL;
 
-- 
2.27.0

