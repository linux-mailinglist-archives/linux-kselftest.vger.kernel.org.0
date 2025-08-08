Return-Path: <linux-kselftest+bounces-38582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7A4B1EB8A
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1441D4E48DE
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511DA284B36;
	Fri,  8 Aug 2025 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlW9Tb84"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879028466E
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666445; cv=none; b=aeDvjjnGQhicf27dWFrlTjGZ2yfoEhFGdkDSnR14INGMyXNmZP30myNeexBkgyq0nwj01M0ResHMMXdy15dnHc57q+Q70hbSvS1kaIaSSludBDTZA4w33I1vXG0ozw4k5BuGCqjvrE/3kwpBXdbWv5tXmitcsJB5RhcS1VaILiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666445; c=relaxed/simple;
	bh=uZdXodG+xrgE4lj+usSCEwwAw/UOkFtAAv/696uixfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvjCHigk1PW0L+MQjLfz2xvoMo1InTZgLP2frwC+jzsLVEoFIMtkH0QyneSnk7P92Rv4SmsjZIzyEX6EpDEmScVAcn5cZDfIoxvwFyH1GJT3KPUldSyEIW+d4ODjacHcrtqZV8D5QnW8ZwT2aOjK5q1fnK/UF0n/JwJ+LnOssxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlW9Tb84; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754666442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b3KPC8rglAUpE8Wovp40kQFjRH7fp7qx30+4/FOiug=;
	b=QlW9Tb84cY4eZ0cDdBVtH5cSVYB6vcGYY8weG0Bt89whfdX+GVVKx0vBw0W8LeOEDcvVTa
	H6wUEARz8SDlfmSMKd2qSOwu1FL1DqpPa9NXcpkFP8PJYFZfW3hZPlw8R7/JP4ffrW32To
	Eqw1WyN28sXz8HR5v9F09gB1oWwmCTA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-tDyNSjeoOwSEhqrEZUcvrg-1; Fri,
 08 Aug 2025 11:20:36 -0400
X-MC-Unique: tDyNSjeoOwSEhqrEZUcvrg-1
X-Mimecast-MFC-AGG-ID: tDyNSjeoOwSEhqrEZUcvrg_1754666428
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02B9F18002EA;
	Fri,  8 Aug 2025 15:20:28 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACC00180029D;
	Fri,  8 Aug 2025 15:20:21 +0000 (UTC)
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
Subject: [RFC PATCH 11/18] tick/nohz: Make nohz_full parameter optional
Date: Fri,  8 Aug 2025 11:19:54 -0400
Message-ID: <20250808152001.20245-2-longman@redhat.com>
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

To provide nohz_full tick support, there is a set of tick dependency
masks that need to be evaluated on every IRQ and context switch.
Switching on nohz_full tick support at runtime will be problematic
as some of the tick dependency masks may not be properly set causing
problem down the road.

Allow nohz_full boot option to be specified without any
parameter to force enable nohz_full tick support without any
CPU in the tick_nohz_full_mask yet. The context_tracking_key and
tick_nohz_full_running flag will be enabled in this case to make
tick_nohz_full_enabled() return true.

There is still a small performance overhead by force enable nohz_full
this way. So it should only be used if there is a chance that some
CPUs may become isolated later via the cpuset isolated partition
functionality and better CPU isolation closed to nohz_full is desired.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         | 19 ++++++++++++-------
 include/linux/context_tracking.h              |  7 ++++++-
 kernel/context_tracking.c                     |  4 +++-
 kernel/sched/isolation.c                      | 13 ++++++++++++-
 kernel/time/tick-sched.c                      | 11 +++++++++--
 5 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf494..89a8161475b5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4260,15 +4260,20 @@
 			Valid arguments: on, off
 			Default: on
 
-	nohz_full=	[KNL,BOOT,SMP,ISOL]
-			The argument is a cpu list, as described above.
+	nohz_full[=cpu-list]
+			[KNL,BOOT,SMP,ISOL]
 			In kernels built with CONFIG_NO_HZ_FULL=y, set
-			the specified list of CPUs whose tick will be stopped
-			whenever possible. The boot CPU will be forced outside
-			the range to maintain the timekeeping.  Any CPUs
-			in this list will have their RCU callbacks offloaded,
+			the specified list of CPUs whose tick will be
+			stopped whenever possible.  If the argument is
+			not specified, nohz_full will be forced enabled
+			without any CPU in the nohz_full list yet.
+			The boot CPU will be forced outside the range
+			to maintain the timekeeping.  Any CPUs in this
+			list will have their RCU callbacks offloaded,
 			just as if they had also been called out in the
-			rcu_nocbs= boot parameter.
+			rcu_nocbs= boot parameter.  There is no need
+			to use rcu_nocbs= boot parameter if nohz_full
+			has been set which will override rcu_nocbs.
 
 			Note that this argument takes precedence over
 			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index af9fe87a0922..a3fea7f9fef6 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -9,8 +9,13 @@
 
 #include <asm/ptrace.h>
 
-
 #ifdef CONFIG_CONTEXT_TRACKING_USER
+/*
+ * Pass CONTEXT_TRACKING_FORCE_ENABLE to ct_cpu_track_user() to force enable
+ * user context tracking.
+ */
+#define CONTEXT_TRACKING_FORCE_ENABLE	(-1)
+
 extern void ct_cpu_track_user(int cpu);
 
 /* Called with interrupts disabled.  */
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index fb5be6e9b423..734354bbfdbb 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -698,7 +698,9 @@ void __init ct_cpu_track_user(int cpu)
 {
 	static __initdata bool initialized = false;
 
-	if (!per_cpu(context_tracking.active, cpu)) {
+	if (cpu == CONTEXT_TRACKING_FORCE_ENABLE) {
+		static_branch_inc(&context_tracking_key);
+	} else if (!per_cpu(context_tracking.active, cpu)) {
 		per_cpu(context_tracking.active, cpu) = true;
 		static_branch_inc(&context_tracking_key);
 	}
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index f26708667754..2bed4b2f9ec5 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -146,6 +146,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	}
 
 	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
+
 	if (cpulist_parse(str, non_housekeeping_mask) < 0) {
 		pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");
 		goto free_non_housekeeping_mask;
@@ -155,6 +156,13 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	cpumask_andnot(housekeeping_staging,
 		       cpu_possible_mask, non_housekeeping_mask);
 
+	/*
+	 * Allow "nohz_full" without parameter to force enable nohz_full
+	 * at boot time without any CPUs in the nohz_full list yet.
+	 */
+	if ((flags & HK_FLAG_KERNEL_NOISE) && !*str)
+		goto setup_housekeeping_staging;
+
 	first_cpu = cpumask_first_and(cpu_present_mask, housekeeping_staging);
 	if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {
 		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
@@ -168,6 +176,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	if (cpumask_empty(non_housekeeping_mask))
 		goto free_housekeeping_staging;
 
+setup_housekeeping_staging:
 	if (!housekeeping.flags) {
 		/* First setup call ("nohz_full=" or "isolcpus=") */
 		enum hk_type type;
@@ -212,10 +221,12 @@ static int __init housekeeping_nohz_full_setup(char *str)
 	unsigned long flags;
 
 	flags = HK_FLAG_KERNEL_NOISE;
+	if (*str == '=')
+		str++;
 
 	return housekeeping_setup(str, flags);
 }
-__setup("nohz_full=", housekeeping_nohz_full_setup);
+__setup("nohz_full", housekeeping_nohz_full_setup);
 
 static int __init housekeeping_isolcpus_setup(char *str)
 {
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c527b421c865..87b26a4471e7 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -651,8 +651,15 @@ void __init tick_nohz_init(void)
 		}
 	}
 
-	for_each_cpu(cpu, tick_nohz_full_mask)
-		ct_cpu_track_user(cpu);
+	/*
+	 * Force enable context_tracking_key if tick_nohz_full_mask empty
+	 */
+	if (cpumask_empty(tick_nohz_full_mask)) {
+		ct_cpu_track_user(CONTEXT_TRACKING_FORCE_ENABLE);
+	} else {
+		for_each_cpu(cpu, tick_nohz_full_mask)
+			ct_cpu_track_user(cpu);
+	}
 
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
 					"kernel/nohz:predown", NULL,
-- 
2.50.0


