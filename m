Return-Path: <linux-kselftest+bounces-38585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AD6B1EBB2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79CFC5A117B
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1074284B57;
	Fri,  8 Aug 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwNk3poZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D02285053
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666488; cv=none; b=RZ3cY2YIKm35K+hNZenq0k0KH6Lr/llGB5gcHaJJFcWC03PHZGnWmqY1XPQBn9F3izhD0onS0k3ZHLgFZNah99Pnj9K77z5XTR3nMWzwtXnHzQOWuPmPtHjY4Cw5Ov8ok8rYCbvDC2//JNZLWemZ+ODEaL0UJvwh6HIyVDUQLbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666488; c=relaxed/simple;
	bh=G+SuqHYYBtyqlrzLWONaD/8ACPafYoU76CpsPRv+ZDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9D7/JDk/ZRM5ZvZQnmFb8kzP/n2kNptv/gyFADn33aG2NFxD2dUHkG0eBe4ZIkRHFh5SxR6i2LTJQWUp18xk0Vc0s1bpG4Kqx2NKaqYq+xe84dTGWGBfG8lK2VRmDd+jrkdERVGvfOm8OKHtS/OVt38eU0m65HzcwH+dnjTvVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UwNk3poZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754666484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3IrWf1FQMKxHSbm6lytMXnYB7oM2ZZ+ln1x5eRMpdA=;
	b=UwNk3poZdQ9qLlkAxxLZ4FoX9G4CJg3nL9kT8bLETWBxMRf8dN3y4Gm9hTRIjR+BOLXQpH
	6htZeJ23hxJH2FVWVfuMBYclUfd7NPalEVRAS6ukU/yjlk7s0mUuNyENAYGqi4sWOaSAgB
	lHbSB8sa3WP6A6EKacx2slzCLdEN328=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-sptsYpEoMveUvnkJBZ77Hw-1; Fri,
 08 Aug 2025 11:21:20 -0400
X-MC-Unique: sptsYpEoMveUvnkJBZ77Hw-1
X-Mimecast-MFC-AGG-ID: sptsYpEoMveUvnkJBZ77Hw_1754666442
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91B6F180034A;
	Fri,  8 Aug 2025 15:20:41 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB7921800294;
	Fri,  8 Aug 2025 15:20:34 +0000 (UTC)
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
Subject: [RFC PATCH 13/18] tick/nohz: Allow runtime changes in full dynticks CPUs
Date: Fri,  8 Aug 2025 11:19:56 -0400
Message-ID: <20250808152001.20245-4-longman@redhat.com>
In-Reply-To: <20250808151053.19777-1-longman@redhat.com>
References: <20250808151053.19777-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Full dynticks can only be enabled if "nohz_full" boot option has been
been specified with or without parameter. Any change in the list of
nohz_full CPUs have to be reflected in tick_nohz_full_mask. So the newly
introduced tick_nohz_full_update_cpus() will be called to update the
mask.

We also need to enable CPU context tracking for those CPUs that
are in tick_nohz_full_mask. So remove __init from tick_nohz_init()
and ct_cpu_track_user() so that they be called later when an isolated
cpuset partition is being created. The __ro_after_init attribute is
taken away from context_tracking_key as well.

Also add a new ct_cpu_untrack_user() function to reverse the action of
ct_cpu_track_user() in case we need to disable the nohz_full mode of
a CPU.

With nohz_full enabled, the boot CPU (typically CPU 0) will be the
tick CPU which cannot be shut down easily. So the boot CPU should not
be used in an isolated cpuset partition.

With runtime modification of nohz_full CPUs, tick_do_timer_cpu can become
TICK_DO_TIMER_NONE. So remove the two TICK_DO_TIMER_NONE WARN_ON_ONCE()
calls in tick-sched.c to avoid unnecessary warnings.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/context_tracking.h |  1 +
 kernel/cgroup/cpuset.c           | 23 ++++++++++++++++++++++-
 kernel/context_tracking.c        | 17 ++++++++++++++---
 kernel/time/tick-sched.c         |  7 -------
 4 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index a3fea7f9fef6..1a6b816f1ad6 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -17,6 +17,7 @@
 #define CONTEXT_TRACKING_FORCE_ENABLE	(-1)
 
 extern void ct_cpu_track_user(int cpu);
+extern void ct_cpu_untrack_user(int cpu);
 
 /* Called with interrupts disabled.  */
 extern void __ct_user_enter(enum ctx_state state);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6308bb14e018..45c82c18bec4 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -23,6 +23,7 @@
  */
 #include "cpuset-internal.h"
 
+#include <linux/context_tracking.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -1361,7 +1362,7 @@ static void partition_xcpus_del(int old_prs, struct cpuset *parent,
  */
 static int do_housekeeping_exclude_cpumask(void *arg __maybe_unused)
 {
-	int ret;
+	int cpu, ret;
 	struct cpumask *icpus = isolated_cpus;
 	unsigned long flags = BIT(HK_TYPE_DOMAIN) | BIT(HK_TYPE_KERNEL_NOISE);
 
@@ -1395,6 +1396,26 @@ static int do_housekeeping_exclude_cpumask(void *arg __maybe_unused)
 	ret = housekeeping_exclude_cpumask(icpus, flags);
 	WARN_ON_ONCE((ret < 0) && (ret != -EOPNOTSUPP));
 
+#ifdef CONFIG_NO_HZ_FULL
+	/*
+	 * To properly enable/disable nohz_full dynticks for the affected CPUs,
+	 * the new nohz_full CPUs have to be copied to tick_nohz_full_mask and
+	 * ct_cpu_track_user/ct_cpu_untrack_user() will have to be called
+	 * for those CPUs that have their states changed.
+	 */
+	if (tick_nohz_full_enabled()) {
+		tick_nohz_full_update_cpus(icpus);
+		for_each_cpu(cpu, isolcpus_update_state.cpus) {
+			if (cpumask_test_cpu(cpu, icpus))
+				ct_cpu_track_user(cpu);
+			else
+				ct_cpu_untrack_user(cpu);
+		}
+	} else {
+		pr_warn_once("Full dynticks cannot be enabled without the nohz_full kernel boot parameter!\n");
+	}
+#endif
+
 	if (icpus != isolated_cpus)
 		kfree(icpus);
 	return ret;
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 734354bbfdbb..ed5653a3d6f7 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -431,7 +431,7 @@ static __always_inline void ct_kernel_enter(bool user, int offset) { }
 #define CREATE_TRACE_POINTS
 #include <trace/events/context_tracking.h>
 
-DEFINE_STATIC_KEY_FALSE_RO(context_tracking_key);
+DEFINE_STATIC_KEY_FALSE(context_tracking_key);
 EXPORT_SYMBOL_GPL(context_tracking_key);
 
 static noinstr bool context_tracking_recursion_enter(void)
@@ -694,9 +694,9 @@ void user_exit_callable(void)
 }
 NOKPROBE_SYMBOL(user_exit_callable);
 
-void __init ct_cpu_track_user(int cpu)
+void ct_cpu_track_user(int cpu)
 {
-	static __initdata bool initialized = false;
+	static bool initialized;
 
 	if (cpu == CONTEXT_TRACKING_FORCE_ENABLE) {
 		static_branch_inc(&context_tracking_key);
@@ -720,6 +720,17 @@ void __init ct_cpu_track_user(int cpu)
 	initialized = true;
 }
 
+void ct_cpu_untrack_user(int cpu)
+{
+#ifndef CONFIG_CONTEXT_TRACKING_USER_FORCE
+	if (!per_cpu(context_tracking.active, cpu))
+		return;
+
+	per_cpu(context_tracking.active, cpu) = false;
+	static_branch_dec(&context_tracking_key);
+#endif
+}
+
 #ifdef CONFIG_CONTEXT_TRACKING_USER_FORCE
 void __init context_tracking_init(void)
 {
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9204808b7a55..c16250c6a79f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -220,9 +220,6 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	tick_cpu = READ_ONCE(tick_do_timer_cpu);
 
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && unlikely(tick_cpu == TICK_DO_TIMER_NONE)) {
-#ifdef CONFIG_NO_HZ_FULL
-		WARN_ON_ONCE(tick_nohz_full_running);
-#endif
 		WRITE_ONCE(tick_do_timer_cpu, cpu);
 		tick_cpu = cpu;
 	}
@@ -1201,10 +1198,6 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 		 */
 		if (tick_cpu == cpu)
 			return false;
-
-		/* Should not happen for nohz-full */
-		if (WARN_ON_ONCE(tick_cpu == TICK_DO_TIMER_NONE))
-			return false;
 	}
 
 	return true;
-- 
2.50.0


