Return-Path: <linux-kselftest+bounces-38573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC79B1EB33
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D093B586ED3
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488BF281372;
	Fri,  8 Aug 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcfDw3rY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A7C283141
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665930; cv=none; b=nfY+bSrhM5Q5nnzdzhtpjE/MbKTV7YGe4TZns9/WJrBoOZvTTa94tACOI8e04VdOrnAyE/sw+f6F6puDSgNwQ6gjO8PxsSbzHkDGOW2wAVf1i5F7JQy7viBuSJO7bdMVAMiQ47A6iXTEdhfqhIQcOB4NcffMKPOa6wrB4+mupFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665930; c=relaxed/simple;
	bh=e8U0ERXlufPRd76pCbuEllcTV+lrPTD+VuR7FbUS0Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLoeYKr+GT1wuyf9Awi2U1QJW/LwmWwfQlOlFykwfTWfLy+kj0g0otgO+v2yPHkNW05zj59V/s67Ttc0VXmlzq4P9F0EmOWlgHsDM4SD9uqJFYGUa81CRbBTvgsaLKzxoUTtJ/OjGF2nm5XpqWxZQ7uT6QvVUxq/z42X7W6OzQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FcfDw3rY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754665927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rS6779GQkHlX78optXa72gUgfXe51djkmFLW5S8q5S8=;
	b=FcfDw3rYfuc6XkuLpJjMhr8iSr8ndVQLKR+bfTFzNpLKOCHSt6Yw4BvOTh0fZZD9n39Jzh
	oiNDcboORAqXbKh5O05f7h+4llOsMak52YSzHq3EuC9rLa+Qwu96UreGYKVazLJOsAnr/B
	yqQmYOakN637qpYOJ0T3QD9TDq1CgCY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-1dkO3sekPdasiBUNCW1yww-1; Fri,
 08 Aug 2025 11:12:05 -0400
X-MC-Unique: 1dkO3sekPdasiBUNCW1yww-1
X-Mimecast-MFC-AGG-ID: 1dkO3sekPdasiBUNCW1yww_1754665921
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7823E195608E;
	Fri,  8 Aug 2025 15:12:00 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88E301954196;
	Fri,  8 Aug 2025 15:11:53 +0000 (UTC)
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
Subject: [RFC PATCH 02/18] sched/isolation: Call sched_tick_offload_init() when HK_FLAG_KERNEL_NOISE is first set
Date: Fri,  8 Aug 2025 11:10:46 -0400
Message-ID: <20250808151053.19777-3-longman@redhat.com>
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

The sched_tick_offload_init() function is called at boot time whenever
"nohz_full" is set. Now housekeeping cpumasks can be updated at run
time without the corresponding "nohz_full" kernel parameter. So we have
to be able to call sched_tick_offload_init() at run time to allow tick
offloading. Remove the __init attribute from sched_tick_offload_init()
and call it when the HK_FLAG_KERNEL_NOISE flag is first set.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c      |  2 +-
 kernel/sched/isolation.c | 10 +++++++++-
 kernel/sched/sched.h     |  2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4..9f02c047e25b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5783,7 +5783,7 @@ static void sched_tick_stop(int cpu)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-int __init sched_tick_offload_init(void)
+int sched_tick_offload_init(void)
 {
 	tick_work_cpu = alloc_percpu(struct tick_work);
 	BUG_ON(!tick_work_cpu);
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 3fb0e8ccce26..ee396ae13719 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -33,6 +33,7 @@ struct housekeeping {
 };
 
 static struct housekeeping housekeeping;
+static bool sched_tick_offload_inited;
 
 bool housekeeping_enabled(enum hk_type type)
 {
@@ -103,8 +104,10 @@ void __init housekeeping_init(void)
 
 	static_branch_enable(&housekeeping_overridden);
 
-	if (housekeeping.flags & HK_FLAG_KERNEL_NOISE)
+	if (housekeeping.flags & HK_FLAG_KERNEL_NOISE) {
 		sched_tick_offload_init();
+		sched_tick_offload_inited = true;
+	}
 
 	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
 		/* We need at least one CPU to handle housekeeping work */
@@ -324,5 +327,10 @@ int housekeeping_exclude_cpumask(struct cpumask *cpumask, unsigned long hk_flags
 		static_key_disable(&housekeeping_overridden.key);
 	else if (housekeeping.flags && !static_key_enabled(&housekeeping_overridden))
 		static_key_enable(&housekeeping_overridden.key);
+
+	if ((housekeeping.flags & HK_FLAG_KERNEL_NOISE) && !sched_tick_offload_inited) {
+		sched_tick_offload_init();
+		sched_tick_offload_inited = true;
+	}
 	return 0;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d104f7..d4676305e099 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2671,7 +2671,7 @@ extern void post_init_entity_util_avg(struct task_struct *p);
 
 #ifdef CONFIG_NO_HZ_FULL
 extern bool sched_can_stop_tick(struct rq *rq);
-extern int __init sched_tick_offload_init(void);
+extern int sched_tick_offload_init(void);
 
 /*
  * Tick may be needed by tasks in the runqueue depending on their policy and
-- 
2.50.0


