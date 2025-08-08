Return-Path: <linux-kselftest+bounces-38574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890E1B1EB37
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC13586FB9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558F52836B0;
	Fri,  8 Aug 2025 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EamPtlCC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF412281525
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665937; cv=none; b=VBmNIu3BXQv0hbgnP8TbUlr0QELM0c1YoPLN+CRIVAk7Efe7xOl705LFbXIBpT1Z8IAgTkTRmve7fV3LPySMO7w80zOqH4IVHP5j644tVahgs7Io/iUWsRVzvT7Iob/YGZO6swqEsiFs5mxLvsJ6W/G6BTnt1mccC1JwJgXmBmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665937; c=relaxed/simple;
	bh=QRY16VAW4X4F0xXHp04SZrPFAFE5kMQLXklX4MXdJ+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9S4WXC4oJ50TLeJgiphXTeRSe6GRuGzDzzQunVYTZeUdS7Q0lAYlOSHOm61cjtAwsXAm1AI1mBYN+nxOn/48sNlxJDLH1JUjEgT+jzPrT+yCOXc5JD3w00xY5XPV8sThZ/8CvgLSIh5/ldPr8LQd6eppjT4UNtZ8tYbGnAmFwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EamPtlCC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754665933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u94p6gUaRQMoeY109WbKTEOrDCchNSj9vS9OMLPC8GY=;
	b=EamPtlCClVmtWNtdcCBPJYK2MfcRLiV5iYy3v8rq7XZ6+qwagAI0TCqkKONeYqb0yrIE4f
	rV1jvjzew2FEgUHBgY7UsqLZgF7lmN0xJ3ON5vPwocH5JPKuaz9Xu7XuF8dvBM9AUOWMpe
	CagdfrdrQt44YOjuv7XCMAthX5A0wh8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-g97BaJH6Pcm_bPkS05BaYw-1; Fri,
 08 Aug 2025 11:12:12 -0400
X-MC-Unique: g97BaJH6Pcm_bPkS05BaYw-1
X-Mimecast-MFC-AGG-ID: g97BaJH6Pcm_bPkS05BaYw_1754665928
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C8EC1800289;
	Fri,  8 Aug 2025 15:12:08 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDCEB1954199;
	Fri,  8 Aug 2025 15:12:00 +0000 (UTC)
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
Subject: [RFC PATCH 03/18] sched/isolation: Use RCU to delay successive housekeeping cpumask updates
Date: Fri,  8 Aug 2025 11:10:47 -0400
Message-ID: <20250808151053.19777-4-longman@redhat.com>
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

Even though there are 2 separate sets of housekeeping cpumasks for access
and update, it is possible that the set of cpumasks to be updated are
still being used by the callers of housekeeping functions resulting in
the use of an intermediate cpumask between the new and old ones.

To reduce the chance of this, we need to introduce delay between
successive housekeeping cpumask updates. One simple way is to make
use of the RCU grace period delay. The callers of the housekeeping APIs
can optionally hold rcu_read_lock to eliminate the chance of using
intermediate housekeeping cpumasks.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/isolation.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index ee396ae13719..f26708667754 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -23,6 +23,9 @@ EXPORT_SYMBOL_GPL(housekeeping_overridden);
  * The housekeeping cpumasks can now be dynamically updated at run time.
  * Two set of cpumasks are kept. One set can be used while the other set are
  * being updated concurrently.
+ *
+ * rcu_read_lock() can optionally be held by housekeeping API callers to
+ * ensure stability of the cpumasks.
  */
 static DEFINE_RAW_SPINLOCK(cpumask_lock);
 struct housekeeping {
@@ -34,6 +37,8 @@ struct housekeeping {
 
 static struct housekeeping housekeeping;
 static bool sched_tick_offload_inited;
+static struct rcu_head rcu_gp[HK_TYPE_MAX];
+static unsigned long update_flags;
 
 bool housekeeping_enabled(enum hk_type type)
 {
@@ -267,6 +272,18 @@ static int __init housekeeping_isolcpus_setup(char *str)
 }
 __setup("isolcpus=", housekeeping_isolcpus_setup);
 
+/*
+ * Bits in update_flags can only turned on with cpumask_lock held and
+ * cleared by this RCU callback function.
+ */
+static void rcu_gp_end(struct rcu_head *rcu)
+{
+	int type = rcu - rcu_gp;
+
+	/* Atomically clear the corresponding flag bit */
+	clear_bit(type, &update_flags);
+}
+
 /**
  * housekeeping_exclude_cpumask - Update housekeeping cpumasks to exclude only the given cpumask
  * @cpumask:  new cpumask to be excluded from housekeeping cpumasks
@@ -306,8 +323,21 @@ int housekeeping_exclude_cpumask(struct cpumask *cpumask, unsigned long hk_flags
 	}
 #endif
 
+retry:
+	/*
+	 * If the RCU grace period for the previous update with conflicting
+	 * flag bits hasn't been completed yet, we have to wait for it.
+	 */
+	while (READ_ONCE(update_flags) & hk_flags)
+		synchronize_rcu();
+
 	raw_spin_lock(&cpumask_lock);
 
+	if (READ_ONCE(update_flags) & hk_flags) {
+		raw_spin_unlock(&cpumask_lock);
+		goto retry;
+	}
+
 	for_each_set_bit(type, &hk_flags, HK_TYPE_MAX) {
 		int idx = ++housekeeping.seq_nrs[type] & 1;
 		struct cpumask *dst_cpumask = housekeeping.cpumasks[type][idx];
@@ -320,8 +350,11 @@ int housekeeping_exclude_cpumask(struct cpumask *cpumask, unsigned long hk_flags
 			housekeeping.flags |= BIT(type);
 		}
 		WRITE_ONCE(housekeeping.cpumask_ptrs[type], dst_cpumask);
+		set_bit(type, &update_flags);
 	}
 	raw_spin_unlock(&cpumask_lock);
+	for_each_set_bit(type, &hk_flags, HK_TYPE_MAX)
+		call_rcu(&rcu_gp[type], rcu_gp_end);
 
 	if (!housekeeping.flags && static_key_enabled(&housekeeping_overridden))
 		static_key_disable(&housekeeping_overridden.key);
-- 
2.50.0


