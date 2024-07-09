Return-Path: <linux-kselftest+bounces-13344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA6F92AD7C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 03:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23342282C3D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 01:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1136242052;
	Tue,  9 Jul 2024 01:00:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA3D39856;
	Tue,  9 Jul 2024 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720486819; cv=none; b=VgOYvXv0nbAspZXakaPCVwCpHjlumruJpXkZKMpMX87GjPvFuhG0+hQBeVqqXa5R6nCxQsugf4yOIC/0+GGts8ecfcP5XKd93uUr/cWQdId2dK/R518z8trEdtE1/Vkfv+y0TsjCcGOHaCiafV9RiK07hSy78Hc0WoMI4R2x4Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720486819; c=relaxed/simple;
	bh=xLqdOSI1eEn13oz6ComTmDYh9EQN8Mh9yt72JKOjUs8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ErzsRSeDMwk2/N67v0LfFb4d5lkqT+7GI7PvvKjBx1RAqGLCz+K2V62jdgmvXqEFG9mXUvcyiZ21o1X0J+qcvrZ3eC7n3UcOUe3xLxVNwWuO0XfjVtEj6WWfjE9OUmJZ1UIYy1K8hYqL/WynFQYB6UeUAzeOqdTq8uKlsjpi8/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WJ2dz1gqSz1HF7Y;
	Tue,  9 Jul 2024 08:57:43 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 71A72180028;
	Tue,  9 Jul 2024 09:00:07 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 9 Jul
 2024 09:00:06 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <mykolal@fb.com>, <shuah@kernel.org>,
	<liaochang1@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH 1/2] uprobes: Optimize the return_instance related routines
Date: Tue, 9 Jul 2024 00:51:41 +0000
Message-ID: <20240709005142.4044530-2-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709005142.4044530-1-liaochang1@huawei.com>
References: <20240709005142.4044530-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Reduce the runtime overhead for struct return_instance data managed by
uretprobe. This patch replaces the dynamic allocation with statically
allocated array, leverage two facts that are limited nesting depth of
uretprobe (max 64) and the function call style of return_instance usage
(create at entry, free at exit).

This patch has been tested on Kunpeng916 (Hi1616), 4 NUMA nodes, 64
cores @ 2.4GHz. Redis benchmarks show a throughput gain by 2% for Redis
GET and SET commands:

------------------------------------------------------------------
Test case       | No uretprobes | uretprobes     | uretprobes
                |               | (current)      | (optimized)
==================================================================
Redis SET (RPS) | 47025         | 40619 (-13.6%) | 41529 (-11.6%)
------------------------------------------------------------------
Redis GET (RPS) | 46715         | 41426 (-11.3%) | 42306 (-9.4%)
------------------------------------------------------------------

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 include/linux/uprobes.h |  10 ++-
 kernel/events/uprobes.c | 162 ++++++++++++++++++++++++----------------
 2 files changed, 105 insertions(+), 67 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f46e0ca0169c..ec50ff010b1d 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -55,6 +55,12 @@ enum uprobe_task_state {
 	UTASK_SSTEP_TRAPPED,
 };
 
+struct return_frame {
+	/* the frames of return instances */
+	struct return_instance	*return_instance;
+	struct return_instance	*vaddr;
+};
+
 /*
  * uprobe_task: Metadata of a task while it singlesteps.
  */
@@ -76,7 +82,7 @@ struct uprobe_task {
 	struct uprobe			*active_uprobe;
 	unsigned long			xol_vaddr;
 
-	struct return_instance		*return_instances;
+	struct return_frame		frame;
 	unsigned int			depth;
 };
 
@@ -86,8 +92,6 @@ struct return_instance {
 	unsigned long		stack;		/* stack pointer */
 	unsigned long		orig_ret_vaddr; /* original return address */
 	bool			chained;	/* true, if instance is nested */
-
-	struct return_instance	*next;		/* keep as stack */
 };
 
 enum rp_check {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2c83ba776fc7..81c56fd2811c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1697,12 +1697,89 @@ unsigned long uprobe_get_trap_addr(struct pt_regs *regs)
 	return instruction_pointer(regs);
 }
 
-static struct return_instance *free_ret_instance(struct return_instance *ri)
+static inline
+struct return_instance *next_ret_instance(struct return_frame *frame,
+					  struct return_instance *ri)
+{
+	return ri == frame->vaddr ? NULL : ri - 1;
+}
+
+static inline
+struct return_instance *curr_ret_instance(struct uprobe_task *task)
+{
+	return task->frame.return_instance;
+}
+
+static struct return_instance *find_next_ret_chain(struct uprobe_task *utask,
+						   struct return_instance *ri)
+{
+	bool chained;
+
+	do {
+		chained = ri->chained;
+		ri = next_ret_instance(&utask->frame, ri);
+	} while (chained);
+
+	return ri;
+}
+
+static inline
+struct return_instance *free_ret_instance(struct uprobe_task *utask,
+					  struct return_instance *ri)
 {
-	struct return_instance *next = ri->next;
 	put_uprobe(ri->uprobe);
-	kfree(ri);
-	return next;
+	return next_ret_instance(&utask->frame, ri);
+}
+
+static void free_return_instances(struct uprobe_task *task)
+{
+	struct return_frame *frame = &task->frame;
+	struct return_instance *ri = frame->return_instance;
+
+	while (ri) {
+		put_uprobe(ri->uprobe);
+		ri = next_ret_instance(frame, ri);
+	}
+
+	kfree(frame->vaddr);
+}
+
+static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
+				     struct pt_regs *regs)
+{
+	struct return_frame *frame = &utask->frame;
+	struct return_instance *ri = frame->return_instance;
+	enum rp_check ctx = chained ? RP_CHECK_CHAIN_CALL : RP_CHECK_CALL;
+
+	while (ri && !arch_uretprobe_is_alive(ri, ctx, regs)) {
+		ri = next_ret_instance(frame, ri);
+		utask->depth--;
+	}
+	frame->return_instance = ri;
+}
+
+static struct return_instance *alloc_return_instance(struct uprobe_task *task)
+{
+	struct return_frame *frame = &task->frame;
+
+	if (!frame->vaddr) {
+		frame->vaddr = kcalloc(MAX_URETPROBE_DEPTH,
+				sizeof(struct return_instance), GFP_KERNEL);
+		if (!frame->vaddr)
+			return NULL;
+	}
+
+	if (!frame->return_instance) {
+		frame->return_instance = frame->vaddr;
+		return frame->return_instance;
+	}
+
+	return ++frame->return_instance;
+}
+
+static inline bool return_frame_empty(struct uprobe_task *task)
+{
+	return !task->frame.return_instance;
 }
 
 /*
@@ -1712,7 +1789,6 @@ static struct return_instance *free_ret_instance(struct return_instance *ri)
 void uprobe_free_utask(struct task_struct *t)
 {
 	struct uprobe_task *utask = t->utask;
-	struct return_instance *ri;
 
 	if (!utask)
 		return;
@@ -1720,10 +1796,7 @@ void uprobe_free_utask(struct task_struct *t)
 	if (utask->active_uprobe)
 		put_uprobe(utask->active_uprobe);
 
-	ri = utask->return_instances;
-	while (ri)
-		ri = free_ret_instance(ri);
-
+	free_return_instances(utask);
 	xol_free_insn_slot(t);
 	kfree(utask);
 	t->utask = NULL;
@@ -1747,26 +1820,20 @@ static struct uprobe_task *get_utask(void)
 static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 {
 	struct uprobe_task *n_utask;
-	struct return_instance **p, *o, *n;
+	struct return_instance *o, *n;
 
 	n_utask = kzalloc(sizeof(struct uprobe_task), GFP_KERNEL);
 	if (!n_utask)
 		return -ENOMEM;
 	t->utask = n_utask;
 
-	p = &n_utask->return_instances;
-	for (o = o_utask->return_instances; o; o = o->next) {
-		n = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
-		if (!n)
-			return -ENOMEM;
-
+	o = curr_ret_instance(o_utask);
+	while (o) {
+		n = alloc_return_instance(n_utask);
+		n_utask->depth++;
 		*n = *o;
 		get_uprobe(n->uprobe);
-		n->next = NULL;
-
-		*p = n;
-		p = &n->next;
-		n_utask->depth++;
+		o = next_ret_instance(&o_utask->frame, o);
 	}
 
 	return 0;
@@ -1799,7 +1866,7 @@ void uprobe_copy_process(struct task_struct *t, unsigned long flags)
 
 	t->utask = NULL;
 
-	if (!utask || !utask->return_instances)
+	if (!utask || return_frame_empty(utask))
 		return;
 
 	if (mm == t->mm && !(flags & CLONE_VFORK))
@@ -1840,19 +1907,6 @@ static unsigned long get_trampoline_vaddr(void)
 	return trampoline_vaddr;
 }
 
-static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
-					struct pt_regs *regs)
-{
-	struct return_instance *ri = utask->return_instances;
-	enum rp_check ctx = chained ? RP_CHECK_CHAIN_CALL : RP_CHECK_CALL;
-
-	while (ri && !arch_uretprobe_is_alive(ri, ctx, regs)) {
-		ri = free_ret_instance(ri);
-		utask->depth--;
-	}
-	utask->return_instances = ri;
-}
-
 static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 {
 	struct return_instance *ri;
@@ -1874,10 +1928,6 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 		return;
 	}
 
-	ri = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
-	if (!ri)
-		return;
-
 	trampoline_vaddr = get_trampoline_vaddr();
 	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
 	if (orig_ret_vaddr == -1)
@@ -1893,7 +1943,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 	 * instances. This also makes breakpoint unwrapping easier.
 	 */
 	if (chained) {
-		if (!utask->return_instances) {
+		if (return_frame_empty(utask)) {
 			/*
 			 * This situation is not possible. Likely we have an
 			 * attack from user-space.
@@ -1901,22 +1951,19 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 			uprobe_warn(current, "handle tail call");
 			goto fail;
 		}
-		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
+		orig_ret_vaddr = curr_ret_instance(utask)->orig_ret_vaddr;
 	}
 
+	ri = alloc_return_instance(utask);
 	ri->uprobe = get_uprobe(uprobe);
 	ri->func = instruction_pointer(regs);
 	ri->stack = user_stack_pointer(regs);
 	ri->orig_ret_vaddr = orig_ret_vaddr;
 	ri->chained = chained;
-
 	utask->depth++;
-	ri->next = utask->return_instances;
-	utask->return_instances = ri;
 
-	return;
  fail:
-	kfree(ri);
+	return;
 }
 
 /* Prepare to single-step probed instruction out of line. */
@@ -2111,18 +2158,6 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 	up_read(&uprobe->register_rwsem);
 }
 
-static struct return_instance *find_next_ret_chain(struct return_instance *ri)
-{
-	bool chained;
-
-	do {
-		chained = ri->chained;
-		ri = ri->next;	/* can't be NULL if chained */
-	} while (chained);
-
-	return ri;
-}
-
 static void handle_trampoline(struct pt_regs *regs)
 {
 	struct uprobe_task *utask;
@@ -2133,7 +2168,7 @@ static void handle_trampoline(struct pt_regs *regs)
 	if (!utask)
 		goto sigill;
 
-	ri = utask->return_instances;
+	ri = curr_ret_instance(utask);
 	if (!ri)
 		goto sigill;
 
@@ -2144,25 +2179,24 @@ static void handle_trampoline(struct pt_regs *regs)
 		 * or NULL; the latter case means that nobody but ri->func
 		 * could hit this trampoline on return. TODO: sigaltstack().
 		 */
-		next = find_next_ret_chain(ri);
+		next = find_next_ret_chain(utask, ri);
 		valid = !next || arch_uretprobe_is_alive(next, RP_CHECK_RET, regs);
 
 		instruction_pointer_set(regs, ri->orig_ret_vaddr);
 		do {
 			if (valid)
 				handle_uretprobe_chain(ri, regs);
-			ri = free_ret_instance(ri);
+			ri = free_ret_instance(utask, ri);
 			utask->depth--;
 		} while (ri != next);
 	} while (!valid);
 
-	utask->return_instances = ri;
+	utask->frame.return_instance = ri;
 	return;
 
  sigill:
 	uprobe_warn(current, "handle uretprobe, sending SIGILL.");
 	force_sig(SIGILL);
-
 }
 
 bool __weak arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs)
@@ -2315,7 +2349,7 @@ int uprobe_pre_sstep_notifier(struct pt_regs *regs)
 		return 0;
 
 	if (!test_bit(MMF_HAS_UPROBES, &current->mm->flags) &&
-	    (!current->utask || !current->utask->return_instances))
+	    (!current->utask || return_frame_empty(current->utask)))
 		return 0;
 
 	set_thread_flag(TIF_UPROBE);
-- 
2.34.1


