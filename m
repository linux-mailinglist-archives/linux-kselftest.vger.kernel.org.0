Return-Path: <linux-kselftest+bounces-23310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F959F08CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 10:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4CA168F58
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4961B87C6;
	Fri, 13 Dec 2024 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bezX9l1R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B722D1B85FD
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 09:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083718; cv=none; b=TdatBkYzMwrn6Kbetc2u1X0VrdoTqbMveMJx+7rv/5CYNyeP7ujPlCZnZzV5WC/ggxuySgW6zj0ZNGrZhcv4lJBI77zCZUR0QvjhLeNzm3I+GZNBF8VJxxfWtPemk2L3UF79HnMH7omwG+/r3t9gyZxmVnScoU+WcqXZPmUDkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083718; c=relaxed/simple;
	bh=sfx40/i3U3wd88FlMvV1TSE1IsMZMv4mbjRWXp87fKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lObmFGBbf3Tfm1Nx75mwVNuoIh8iK8SbKUjzGVjEFY/gbCoDAtq0V9kQ2NhNln+oC+LtrVfubR3ssH6KVQ1n2TJO14wH2oZLSjqk5/b65OhXNSi+9POqrdTVW09IsK3Clwu2vy4BQ6Y1zVSiJ+9GcWOtVCD9KqgcbwJfgmKKGvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bezX9l1R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734083715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAzbIE5lEihVL5VaG4JjJ0SMlqmrPzzCPdmb4qvN7Uk=;
	b=bezX9l1RYTx+idoI8n0okDLR/EvJnFjyFoC+p/ryv7c42HswkOwIKPvwc/8Tb4FjrMVc2U
	6vZVitb9k2IzOb5TQZBAyxQ5HMwEJBKSTKBD1DCagKWBG5jEuSoDyiLlD4qs+awlF3xYk0
	pMH4GFxAn5gJHns17WHfAoYfyp0TWS4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-bqgCsWERMqW_tJfsr6ogGA-1; Fri,
 13 Dec 2024 04:55:11 -0500
X-MC-Unique: bqgCsWERMqW_tJfsr6ogGA-1
X-Mimecast-MFC-AGG-ID: bqgCsWERMqW_tJfsr6ogGA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C734C195605E;
	Fri, 13 Dec 2024 09:55:09 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.192.43])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A17E195395A;
	Fri, 13 Dec 2024 09:55:05 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Mel Gorman <mgorman@suse.de>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v2 1/4] sched: Move task_mm_cid_work to mm delayed work
Date: Fri, 13 Dec 2024 10:54:04 +0100
Message-ID: <20241213095407.271357-2-gmonaco@redhat.com>
In-Reply-To: <20241213095407.271357-1-gmonaco@redhat.com>
References: <20241213095407.271357-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Currently, the task_mm_cid_work function is called in a task work
triggered by a scheduler tick. This can delay the execution of the task
for the entire duration of the function, negatively affecting the
response of real time tasks.

This patch runs the task_mm_cid_work in a new delayed work connected to
the mm_struct rather than in the task context before returning to
userspace.

This delayed work is initialised while allocating the mm and disabled
before freeing it, its execution is no longer triggered by scheduler
ticks but run periodically based on the defined MM_CID_SCAN_DELAY.

The main advantage of this change is that the function can be offloaded
to a different CPU and even preempted by RT tasks.

Moreover, this new behaviour could be more predictable in some
situations since the delayed work is always scheduled with the same
periodicity for each mm.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/mm_types.h | 11 +++++++++
 include/linux/sched.h    |  1 -
 kernel/sched/core.c      | 51 ++++++----------------------------------
 kernel/sched/sched.h     |  7 ------
 4 files changed, 18 insertions(+), 52 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7361a8f3ab68..92acb827fee4 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -856,6 +856,7 @@ struct mm_struct {
 		 * mm nr_cpus_allowed updates.
 		 */
 		raw_spinlock_t cpus_allowed_lock;
+		struct delayed_work mm_cid_work;
 #endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
@@ -1144,11 +1145,16 @@ static inline void vma_iter_init(struct vma_iterator *vmi,
 
 #ifdef CONFIG_SCHED_MM_CID
 
+#define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
+#define MM_CID_SCAN_DELAY	100			/* 100ms */
+
 enum mm_cid_state {
 	MM_CID_UNSET = -1U,		/* Unset state has lazy_put flag set. */
 	MM_CID_LAZY_PUT = (1U << 31),
 };
 
+extern void task_mm_cid_work(struct work_struct *work);
+
 static inline bool mm_cid_is_unset(int cid)
 {
 	return cid == MM_CID_UNSET;
@@ -1221,12 +1227,17 @@ static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *
 	if (!mm->pcpu_cid)
 		return -ENOMEM;
 	mm_init_cid(mm, p);
+	INIT_DELAYED_WORK(&mm->mm_cid_work, task_mm_cid_work);
+	mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
+	schedule_delayed_work(&mm->mm_cid_work,
+			      msecs_to_jiffies(MM_CID_SCAN_DELAY));
 	return 0;
 }
 #define mm_alloc_cid(...)	alloc_hooks(mm_alloc_cid_noprof(__VA_ARGS__))
 
 static inline void mm_destroy_cid(struct mm_struct *mm)
 {
+	disable_delayed_work_sync(&mm->mm_cid_work);
 	free_percpu(mm->pcpu_cid);
 	mm->pcpu_cid = NULL;
 }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d380bffee2ef..5d141c310917 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1374,7 +1374,6 @@ struct task_struct {
 	int				last_mm_cid;	/* Most recent cid in mm */
 	int				migrate_from_cpu;
 	int				mm_cid_active;	/* Whether cid bitmap is active */
-	struct callback_head		cid_work;
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c6d8232ad9ee..e3b27b73301c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4516,7 +4516,6 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
 #endif
-	init_sched_mm_cid(p);
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -5654,7 +5653,6 @@ void sched_tick(void)
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
 	sched_core_tick(rq);
-	task_tick_mm_cid(rq, donor);
 	scx_tick(rq);
 
 	rq_unlock(rq, &rf);
@@ -10520,22 +10518,14 @@ static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
 	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
 }
 
-static void task_mm_cid_work(struct callback_head *work)
+void task_mm_cid_work(struct work_struct *work)
 {
 	unsigned long now = jiffies, old_scan, next_scan;
-	struct task_struct *t = current;
 	struct cpumask *cidmask;
-	struct mm_struct *mm;
+	struct delayed_work *delayed_work = container_of(work, struct delayed_work, work);
+	struct mm_struct *mm = container_of(delayed_work, struct mm_struct, mm_cid_work);
 	int weight, cpu;
 
-	SCHED_WARN_ON(t != container_of(work, struct task_struct, cid_work));
-
-	work->next = work;	/* Prevent double-add */
-	if (t->flags & PF_EXITING)
-		return;
-	mm = t->mm;
-	if (!mm)
-		return;
 	old_scan = READ_ONCE(mm->mm_cid_next_scan);
 	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
 	if (!old_scan) {
@@ -10548,9 +10538,9 @@ static void task_mm_cid_work(struct callback_head *work)
 			old_scan = next_scan;
 	}
 	if (time_before(now, old_scan))
-		return;
+		goto out;
 	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
-		return;
+		goto out;
 	cidmask = mm_cidmask(mm);
 	/* Clear cids that were not recently used. */
 	for_each_possible_cpu(cpu)
@@ -10562,35 +10552,8 @@ static void task_mm_cid_work(struct callback_head *work)
 	 */
 	for_each_possible_cpu(cpu)
 		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
-}
-
-void init_sched_mm_cid(struct task_struct *t)
-{
-	struct mm_struct *mm = t->mm;
-	int mm_users = 0;
-
-	if (mm) {
-		mm_users = atomic_read(&mm->mm_users);
-		if (mm_users == 1)
-			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
-	}
-	t->cid_work.next = &t->cid_work;	/* Protect against double add */
-	init_task_work(&t->cid_work, task_mm_cid_work);
-}
-
-void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
-{
-	struct callback_head *work = &curr->cid_work;
-	unsigned long now = jiffies;
-
-	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
-	    work->next != work)
-		return;
-	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
-		return;
-
-	/* No page allocation under rq lock */
-	task_work_add(curr, work, TWA_RESUME | TWAF_NO_ALLOC);
+out:
+	schedule_delayed_work(delayed_work, msecs_to_jiffies(MM_CID_SCAN_DELAY));
 }
 
 void sched_mm_cid_exit_signals(struct task_struct *t)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 76f5f53a645f..21be461ff913 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3581,16 +3581,11 @@ extern void sched_dynamic_update(int mode);
 
 #ifdef CONFIG_SCHED_MM_CID
 
-#define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
-#define MM_CID_SCAN_DELAY	100			/* 100ms */
-
 extern raw_spinlock_t cid_lock;
 extern int use_cid_lock;
 
 extern void sched_mm_cid_migrate_from(struct task_struct *t);
 extern void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t);
-extern void task_tick_mm_cid(struct rq *rq, struct task_struct *curr);
-extern void init_sched_mm_cid(struct task_struct *t);
 
 static inline void __mm_cid_put(struct mm_struct *mm, int cid)
 {
@@ -3839,8 +3834,6 @@ static inline void switch_mm_cid(struct rq *rq,
 static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev, struct task_struct *next) { }
 static inline void sched_mm_cid_migrate_from(struct task_struct *t) { }
 static inline void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t) { }
-static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
-static inline void init_sched_mm_cid(struct task_struct *t) { }
 #endif /* !CONFIG_SCHED_MM_CID */
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
-- 
2.47.1


