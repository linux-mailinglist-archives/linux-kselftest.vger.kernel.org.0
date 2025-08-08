Return-Path: <linux-kselftest+bounces-38572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5D5B1EB2F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F12277AEEE6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2782820A5;
	Fri,  8 Aug 2025 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/POji4F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E16028153C
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665922; cv=none; b=aSPC6JlE8NMUnjM7hdAnFV6SuZc+pBc/Dy0mEYUze3e8doMl2BqDBHDiu8O63by9pL5WcqGSmxVhWl9EDmUrb79xEdci7s6dJ1Vp+sqa8ptEriTStF38/p4vNkd+R0GOpMtKW8oVXdXAsR5v6KbpnSggh5VKv4DlX/Ufh+HBCVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665922; c=relaxed/simple;
	bh=ExwA4B6/w/byNDynTP1ep7pkTcLw3I3plTh/hwS9eP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qv5BoiDfhuO2SqUJHvWkpAIxwFMt90YC0Jsvdn6jKNv9HVN1TczjU8s9pyHG61HtjhWyDmmUiKVwU3xDUdniRqchaypobxXEH3Pe3Kv+lpx7tzDeBhrxixSgV+jUd5rpStc/5DqjgY8Y/AE3UPn2O7wLWflbTYJ6PX9OzVSxnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/POji4F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754665920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CHk/tIYRW3Z9YJEul9RLyS51vrTNKx3o9jNmAMIsCq8=;
	b=R/POji4FPxye0fzNxCn/cz9AXqxGEwsC5d/dq8AjReYAtB8g8kfLPRrGu0LREbIBnwQHuo
	dWUzt9JzZnk/n8xLijGR3fLBzUDqZ3UaiWOm7yIkfwYo1INxA2p0N/A1OgUkg1yD+ilNt2
	WdenXYlLSoM9cZ2jgBuTh2G49oUKXqs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-O-pXsDE7PbWaeeLGCXHc0w-1; Fri,
 08 Aug 2025 11:11:56 -0400
X-MC-Unique: O-pXsDE7PbWaeeLGCXHc0w-1
X-Mimecast-MFC-AGG-ID: O-pXsDE7PbWaeeLGCXHc0w_1754665913
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43BBC19560B4;
	Fri,  8 Aug 2025 15:11:53 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E68C195419C;
	Fri,  8 Aug 2025 15:11:46 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 01/18] sched/isolation: Enable runtime update of housekeeping cpumasks
Date: Fri,  8 Aug 2025 11:10:45 -0400
Message-ID: <20250808151053.19777-2-longman@redhat.com>
In-Reply-To: <20250808151053.19777-1-longman@redhat.com>
References: <20250808151053.19777-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The housekeeping CPU masks, set up by the "isolcpus" and "nohz_full"
boot command line options, are used at boot time to exclude selected CPUs
from running some kernel background processes to minimize disturbance
to latency sensitive userspace applications. Some of housekeeping CPU
masks are also checked at run time to avoid using those isolated CPUs.

The cpuset subsystem is now able to dynamically create a set of isolated
CPUs to be used in isolated cpuset partitions. The long term goal is
to make the degree of isolation as close as possible to what can be
done statically using those boot command line options.

This patch is a step in that direction by providing a new
housekeep_exclude_cpumask() API to exclude only the given cpumask from
the housekeeping cpumasks. Existing boot time "isolcpus" and "nohz_full"
cpumask setup, if present, can be overwritten.

Two set of cpumasks are now kept internally. One set are used by the
callers while the other set are being updated before the new set are
atomically switched on.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched/isolation.h |  6 +++
 kernel/sched/isolation.c        | 95 +++++++++++++++++++++++++++++----
 2 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index d8501f4709b5..af38d21d0d00 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -32,6 +32,7 @@ extern bool housekeeping_enabled(enum hk_type type);
 extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
 extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
 extern void __init housekeeping_init(void);
+extern int housekeeping_exclude_cpumask(struct cpumask *cpumask, unsigned long flags);
 
 #else
 
@@ -59,6 +60,11 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
 }
 
 static inline void housekeeping_init(void) { }
+
+static inline housekeeping_exclude_cpumask(struct cpumask *cpumask, unsigned long flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_CPU_ISOLATION */
 
 static inline bool housekeeping_cpu(int cpu, enum hk_type type)
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index a4cf17b1fab0..3fb0e8ccce26 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -19,8 +19,16 @@ enum hk_flags {
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
 EXPORT_SYMBOL_GPL(housekeeping_overridden);
 
+/*
+ * The housekeeping cpumasks can now be dynamically updated at run time.
+ * Two set of cpumasks are kept. One set can be used while the other set are
+ * being updated concurrently.
+ */
+static DEFINE_RAW_SPINLOCK(cpumask_lock);
 struct housekeeping {
-	cpumask_var_t cpumasks[HK_TYPE_MAX];
+	struct cpumask *cpumask_ptrs[HK_TYPE_MAX];
+	cpumask_var_t cpumasks[HK_TYPE_MAX][2];
+	unsigned int seq_nrs[HK_TYPE_MAX];
 	unsigned long flags;
 };
 
@@ -38,11 +46,13 @@ int housekeeping_any_cpu(enum hk_type type)
 
 	if (static_branch_unlikely(&housekeeping_overridden)) {
 		if (housekeeping.flags & BIT(type)) {
-			cpu = sched_numa_find_closest(housekeeping.cpumasks[type], smp_processor_id());
+			struct cpumask *cpumask = READ_ONCE(housekeeping.cpumask_ptrs[type]);
+
+			cpu = sched_numa_find_closest(cpumask, smp_processor_id());
 			if (cpu < nr_cpu_ids)
 				return cpu;
 
-			cpu = cpumask_any_and_distribute(housekeeping.cpumasks[type], cpu_online_mask);
+			cpu = cpumask_any_and_distribute(cpumask, cpu_online_mask);
 			if (likely(cpu < nr_cpu_ids))
 				return cpu;
 			/*
@@ -62,7 +72,7 @@ const struct cpumask *housekeeping_cpumask(enum hk_type type)
 {
 	if (static_branch_unlikely(&housekeeping_overridden))
 		if (housekeeping.flags & BIT(type))
-			return housekeeping.cpumasks[type];
+			return READ_ONCE(housekeeping.cpumask_ptrs[type]);
 	return cpu_possible_mask;
 }
 EXPORT_SYMBOL_GPL(housekeeping_cpumask);
@@ -71,7 +81,7 @@ void housekeeping_affine(struct task_struct *t, enum hk_type type)
 {
 	if (static_branch_unlikely(&housekeeping_overridden))
 		if (housekeeping.flags & BIT(type))
-			set_cpus_allowed_ptr(t, housekeeping.cpumasks[type]);
+			set_cpus_allowed_ptr(t, READ_ONCE(housekeeping.cpumask_ptrs[type]));
 }
 EXPORT_SYMBOL_GPL(housekeeping_affine);
 
@@ -79,7 +89,7 @@ bool housekeeping_test_cpu(int cpu, enum hk_type type)
 {
 	if (static_branch_unlikely(&housekeeping_overridden))
 		if (housekeeping.flags & BIT(type))
-			return cpumask_test_cpu(cpu, housekeeping.cpumasks[type]);
+			return cpumask_test_cpu(cpu, READ_ONCE(housekeeping.cpumask_ptrs[type]));
 	return true;
 }
 EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
@@ -98,7 +108,7 @@ void __init housekeeping_init(void)
 
 	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
 		/* We need at least one CPU to handle housekeeping work */
-		WARN_ON_ONCE(cpumask_empty(housekeeping.cpumasks[type]));
+		WARN_ON_ONCE(cpumask_empty(housekeeping.cpumask_ptrs[type]));
 	}
 }
 
@@ -106,8 +116,10 @@ static void __init housekeeping_setup_type(enum hk_type type,
 					   cpumask_var_t housekeeping_staging)
 {
 
-	alloc_bootmem_cpumask_var(&housekeeping.cpumasks[type]);
-	cpumask_copy(housekeeping.cpumasks[type],
+	alloc_bootmem_cpumask_var(&housekeeping.cpumasks[type][0]);
+	alloc_bootmem_cpumask_var(&housekeeping.cpumasks[type][1]);
+	housekeeping.cpumask_ptrs[type] = housekeeping.cpumasks[type][0];
+	cpumask_copy(housekeeping.cpumask_ptrs[type],
 		     housekeeping_staging);
 }
 
@@ -161,7 +173,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 
 		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX) {
 			if (!cpumask_equal(housekeeping_staging,
-					   housekeeping.cpumasks[type])) {
+					   housekeeping.cpumask_ptrs[type])) {
 				pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
 				goto free_housekeeping_staging;
 			}
@@ -251,3 +263,66 @@ static int __init housekeeping_isolcpus_setup(char *str)
 	return housekeeping_setup(str, flags);
 }
 __setup("isolcpus=", housekeeping_isolcpus_setup);
+
+/**
+ * housekeeping_exclude_cpumask - Update housekeeping cpumasks to exclude only the given cpumask
+ * @cpumask:  new cpumask to be excluded from housekeeping cpumasks
+ * @hk_flags: bit mask of housekeeping types to be excluded
+ * Return: 0 if successful, error code if an error happens.
+ *
+ * Exclude the given cpumask from the housekeeping cpumasks associated with
+ * the given hk_flags. If the given cpumask is NULL, no CPU will need to be
+ * excluded.
+ */
+int housekeeping_exclude_cpumask(struct cpumask *cpumask, unsigned long hk_flags)
+{
+	unsigned long type;
+
+#ifdef CONFIG_CPUMASK_OFFSTACK
+	/*
+	 * Pre-allocate cpumasks, if needed
+	 */
+	for_each_set_bit(type, &hk_flags, HK_TYPE_MAX) {
+		cpumask_var_t mask0, mask1;
+
+		if (housekeeping.cpumask_ptrs[type])
+			continue;
+		if (!zalloc_cpumask_var(&mask0, GFP_KERNEL) ||
+		    !zalloc_cpumask_var(&mask1, GFP_KERNEL))
+			return -ENOMEM;
+
+		/*
+		 * cpumasks[type][] should be NULL, still do a swap & free
+		 * dance just in case the cpumasks are allocated but
+		 * cpumask_ptrs not setup somehow.
+		 */
+		mask0 = xchg(&housekeeping.cpumasks[type][0], mask0);
+		mask1 = xchg(&housekeeping.cpumasks[type][1], mask1);
+		free_cpumask_var(mask0);
+		free_cpumask_var(mask1);
+	}
+#endif
+
+	raw_spin_lock(&cpumask_lock);
+
+	for_each_set_bit(type, &hk_flags, HK_TYPE_MAX) {
+		int idx = ++housekeeping.seq_nrs[type] & 1;
+		struct cpumask *dst_cpumask = housekeeping.cpumasks[type][idx];
+
+		if (!cpumask) {
+			cpumask_copy(dst_cpumask, cpu_possible_mask);
+			housekeeping.flags &= ~BIT(type);
+		} else {
+			cpumask_andnot(dst_cpumask, cpu_possible_mask, cpumask);
+			housekeeping.flags |= BIT(type);
+		}
+		WRITE_ONCE(housekeeping.cpumask_ptrs[type], dst_cpumask);
+	}
+	raw_spin_unlock(&cpumask_lock);
+
+	if (!housekeeping.flags && static_key_enabled(&housekeeping_overridden))
+		static_key_disable(&housekeeping_overridden.key);
+	else if (housekeeping.flags && !static_key_enabled(&housekeeping_overridden))
+		static_key_enable(&housekeeping_overridden.key);
+	return 0;
+}
-- 
2.50.0


