Return-Path: <linux-kselftest+bounces-38587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DFCB1EB9B
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B953AF975
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9962828540E;
	Fri,  8 Aug 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Og+sELJ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB1028469B
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666490; cv=none; b=k2zN5ar0cE9FEySZBp+N1+DNPp80JPYCHrep+BK25w81UpH6lxrIjO1dcqykrcUJn4DZImVgWgZtwWeCTmtpM4JvNoQN+FXFOrxQSOrPc+S7BAIEv0GFtP/OKLBeHo3rRk/lGFn/9ky8Lr6jtf8ciBrAL1YPYdkb/Y3IsL8RKFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666490; c=relaxed/simple;
	bh=QFJWiaweEnjtZulZv+TQcP+SkZextOHNVPGHzdr08DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtjEa/cKPXbEX9a1uZRUaT+6EynwmVUmOCiAdBANPh0FZPRdhzj72I1dk2CEAtr2Gow7L92oShh2ji3boTt1m1dX45KLkvKGNgGThJLbKwg9PWyuA0qdrUA2UFo20QIyyRZyQVhB1aYquIZJNFjIKBbyVvovZeYw21L0ivR3/W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Og+sELJ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754666485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEWvc3gO1vjmutC6sTx4SpSS9DqW2Vo8SMK8dJwY8nw=;
	b=Og+sELJ6mBsj1oU/hR7Ny4R/GN35Z6zHLHQEri8rV4kfvmcQgu3IGIx4ocAgJuDSU0TlMz
	+6drbMA+WJ06i5kr3p6pXbfQXYVRTb0UJSFdB77Dj+aJ3Csu3suIAGlBl9rq8kIDqbZG/M
	nTrb2dTtSJK7kN70LJYyR9miPxEb3aY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-pKkLszEMMSyqCueLYuEvDg-1; Fri,
 08 Aug 2025 11:21:22 -0400
X-MC-Unique: pKkLszEMMSyqCueLYuEvDg-1
X-Mimecast-MFC-AGG-ID: pKkLszEMMSyqCueLYuEvDg_1754666455
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F319E180029D;
	Fri,  8 Aug 2025 15:20:54 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2AC23180029B;
	Fri,  8 Aug 2025 15:20:48 +0000 (UTC)
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
Subject: [RFC PATCH 15/18] cgroup/cpuset: Enable RCU NO-CB CPU offloading of newly isolated CPUs
Date: Fri,  8 Aug 2025 11:19:58 -0400
Message-ID: <20250808152001.20245-6-longman@redhat.com>
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

Make use of the provided rcu_nocb_cpu_offload()/rcu_nocb_cpu_deoffload()
APIs to enable RCU NO-CB CPU offloading of newly isolated CPUs and
deoffloading of de-isolated CPUs.

Also add a new rcu_nocbs_enabled() helper function to determine if RCU
NO-CB CPU offloading can be done.

As nohz_full can now be specified without any CPU list, drop the test
for cpumask_empty(tick_nohz_full_mask) in rcu_init_nohz().

The RCU NO-CB CPU offloading feature can only used if either "rcs_nocbs"
or the "nohz_full" boot command parameters are used so that the proper
RCU NO-CB resources are properly initialized at boot time.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/rcupdate.h |  2 ++
 kernel/cgroup/cpuset.c   | 14 ++++++++++++++
 kernel/rcu/tree_nocb.h   |  7 ++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 120536f4c6eb..642b80a4f071 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -140,6 +140,7 @@ void rcu_init_nohz(void);
 int rcu_nocb_cpu_offload(int cpu);
 int rcu_nocb_cpu_deoffload(int cpu);
 void rcu_nocb_flush_deferred_wakeup(void);
+bool rcu_nocbs_enabled(void);
 
 #define RCU_NOCB_LOCKDEP_WARN(c, s) RCU_LOCKDEP_WARN(c, s)
 
@@ -149,6 +150,7 @@ static inline void rcu_init_nohz(void) { }
 static inline int rcu_nocb_cpu_offload(int cpu) { return -EINVAL; }
 static inline int rcu_nocb_cpu_deoffload(int cpu) { return 0; }
 static inline void rcu_nocb_flush_deferred_wakeup(void) { }
+static inline bool rcu_nocbs_enabled(void) { return false; }
 
 #define RCU_NOCB_LOCKDEP_WARN(c, s)
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 45c82c18bec4..de9cb92a0fc7 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1416,6 +1416,20 @@ static int do_housekeeping_exclude_cpumask(void *arg __maybe_unused)
 	}
 #endif
 
+	if (rcu_nocbs_enabled()) {
+		/*
+		 * Enable RCU NO-CB CPU offloading/deoffloading for the affected CPUs
+		 */
+		for_each_cpu(cpu, isolcpus_update_state.cpus) {
+			if (cpumask_test_cpu(cpu, icpus))
+				ret = rcu_nocb_cpu_offload(cpu);
+			else
+				ret = rcu_nocb_cpu_deoffload(cpu);
+			if (WARN_ON_ONCE(ret))
+				break;
+		}
+	}
+
 	if (icpus != isolated_cpus)
 		kfree(icpus);
 	return ret;
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index e6cd56603cad..4d49a745b871 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1293,7 +1293,7 @@ void __init rcu_init_nohz(void)
 	struct shrinker * __maybe_unused lazy_rcu_shrinker;
 
 #if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
+	if (tick_nohz_full_running)
 		cpumask = tick_nohz_full_mask;
 #endif
 
@@ -1365,6 +1365,11 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 	mutex_init(&rdp->nocb_gp_kthread_mutex);
 }
 
+bool rcu_nocbs_enabled(void)
+{
+	return !!rcu_state.nocb_is_setup;
+}
+
 /*
  * If the specified CPU is a no-CBs CPU that does not already have its
  * rcuo CB kthread, spawn it.  Additionally, if the rcuo GP kthread
-- 
2.50.0


