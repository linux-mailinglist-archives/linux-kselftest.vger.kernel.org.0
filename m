Return-Path: <linux-kselftest+bounces-8534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E84CF8ABA70
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175451C213EB
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 09:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EB5175A6;
	Sat, 20 Apr 2024 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imoP8E/E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61E1759E;
	Sat, 20 Apr 2024 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604167; cv=none; b=SsQz1jFf7cQ2y24Zh5GtysG4Gi06C775dvMoBjiDY7mkePLNxHmcIkaCg2krKq4HqZMn3CofUOUpjOG+hNiWtyniIZCynu3zl2ohfSonndb2uJPeV9sWnApkGvXRD+gF2w9yXknHDlecfA03bHknHkAAjg55XktYUB26cVTFVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604167; c=relaxed/simple;
	bh=yxCgXRHywWpHtLjQl4rX/HPtosrdf9fo2IBoilcauQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/aHTNT3e0rU6B6YXqATIm0fwskAqDdbor63r6zFpQQ2RC2/br5mXZy5D4kH132laUVI+1f+X2IQCTcAZmCPbb5INqUetJL4ranuM2l5NVh/Jmp/m5uAgmtizxS8pg0Tsrz4oBgJR82QPQ38S3EWnN3ozXTNUhreXzEMtUnNZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imoP8E/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54CAC32786;
	Sat, 20 Apr 2024 09:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604167;
	bh=yxCgXRHywWpHtLjQl4rX/HPtosrdf9fo2IBoilcauQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=imoP8E/EMZOWuyvv2LGT5jNzJaFKHSpVv5eM/+w/ZuYaCmiD2kQHUkp2w4jmkCF70
	 1iVj2vVz/I7AJFTQ5U4L8j9TDIOdfmkFKkDb+a6BYCZ0bxjQWal7w8FEjnQMmcf4c8
	 ZvKLhKUdQdE+D8b8o5r2uT0OE+uVu7D+Ix+/ovVkyJWoqAOgqgjqJdX4yfNPk/8nSw
	 hF/06cHYxdKMZuFBgBirpsz6EWxFbIe+O7WyhWtU/d03ElXpVjCzxppqykFIfgMmBs
	 /0D2nA7QsRLcJwHODp5NV2NMq4xPd+RgwXD7+pLQsVM2GgtmDa0s7AGBbpNmBknGmu
	 Tt1Za+6foQdUA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 20 Apr 2024 11:09:01 +0200
Subject: [PATCH bpf-next v2 01/16] bpf: make timer data struct more generic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-bpf_wq-v2-1-6c986a5a741f@kernel.org>
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
In-Reply-To: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713604159; l=8360;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=yxCgXRHywWpHtLjQl4rX/HPtosrdf9fo2IBoilcauQM=;
 b=oM9rRMszPWXSiVLD/K71giZRwJa3G+vEJsXtIzu3OOza+civX6uQFrJhXI7U/HJpaLdsyRyYK
 7ZTBh/R89vPAYcGUNt0vEYcvG5X/J0ONHyf1vF/208gszU/0peoSEap
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

To be able to add workqueues and reuse most of the timer code, we need
to make bpf_hrtimer more generic.

There is no code change except that the new struct gets a new u64 flags
attribute. We are still below 2 cache lines, so this shouldn't impact
the current running codes.

The ordering is also changed. Everything related to async callback
is now on top of bpf_hrtimer.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 kernel/bpf/helpers.c | 71 ++++++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8cde717137bd..5a069c70b5e6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1079,11 +1079,20 @@ const struct bpf_func_proto bpf_snprintf_proto = {
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
+struct bpf_async_cb {
+	struct bpf_map *map;
+	struct bpf_prog *prog;
+	void __rcu *callback_fn;
+	void *value;
+	struct rcu_head rcu;
+	u64 flags;
+};
+
 /* BPF map elements can contain 'struct bpf_timer'.
  * Such map owns all of its BPF timers.
  * 'struct bpf_timer' is allocated as part of map element allocation
  * and it's zero initialized.
- * That space is used to keep 'struct bpf_timer_kern'.
+ * That space is used to keep 'struct bpf_async_kern'.
  * bpf_timer_init() allocates 'struct bpf_hrtimer', inits hrtimer, and
  * remembers 'struct bpf_map *' pointer it's part of.
  * bpf_timer_set_callback() increments prog refcnt and assign bpf callback_fn.
@@ -1096,16 +1105,12 @@ const struct bpf_func_proto bpf_snprintf_proto = {
  * freeing the timers when inner map is replaced or deleted by user space.
  */
 struct bpf_hrtimer {
+	struct bpf_async_cb cb;
 	struct hrtimer timer;
-	struct bpf_map *map;
-	struct bpf_prog *prog;
-	void __rcu *callback_fn;
-	void *value;
-	struct rcu_head rcu;
 };
 
 /* the actual struct hidden inside uapi struct bpf_timer */
-struct bpf_timer_kern {
+struct bpf_async_kern {
 	struct bpf_hrtimer *timer;
 	/* bpf_spin_lock is used here instead of spinlock_t to make
 	 * sure that it always fits into space reserved by struct bpf_timer
@@ -1119,14 +1124,14 @@ static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 {
 	struct bpf_hrtimer *t = container_of(hrtimer, struct bpf_hrtimer, timer);
-	struct bpf_map *map = t->map;
-	void *value = t->value;
+	struct bpf_map *map = t->cb.map;
+	void *value = t->cb.value;
 	bpf_callback_t callback_fn;
 	void *key;
 	u32 idx;
 
 	BTF_TYPE_EMIT(struct bpf_timer);
-	callback_fn = rcu_dereference_check(t->callback_fn, rcu_read_lock_bh_held());
+	callback_fn = rcu_dereference_check(t->cb.callback_fn, rcu_read_lock_bh_held());
 	if (!callback_fn)
 		goto out;
 
@@ -1155,7 +1160,7 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 	return HRTIMER_NORESTART;
 }
 
-BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map,
+BPF_CALL_3(bpf_timer_init, struct bpf_async_kern *, timer, struct bpf_map *, map,
 	   u64, flags)
 {
 	clockid_t clockid = flags & (MAX_CLOCKS - 1);
@@ -1163,8 +1168,8 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 	int ret = 0;
 
 	BUILD_BUG_ON(MAX_CLOCKS != 16);
-	BUILD_BUG_ON(sizeof(struct bpf_timer_kern) > sizeof(struct bpf_timer));
-	BUILD_BUG_ON(__alignof__(struct bpf_timer_kern) != __alignof__(struct bpf_timer));
+	BUILD_BUG_ON(sizeof(struct bpf_async_kern) > sizeof(struct bpf_timer));
+	BUILD_BUG_ON(__alignof__(struct bpf_async_kern) != __alignof__(struct bpf_timer));
 
 	if (in_nmi())
 		return -EOPNOTSUPP;
@@ -1187,10 +1192,10 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 		ret = -ENOMEM;
 		goto out;
 	}
-	t->value = (void *)timer - map->record->timer_off;
-	t->map = map;
-	t->prog = NULL;
-	rcu_assign_pointer(t->callback_fn, NULL);
+	t->cb.value = (void *)timer - map->record->timer_off;
+	t->cb.map = map;
+	t->cb.prog = NULL;
+	rcu_assign_pointer(t->cb.callback_fn, NULL);
 	hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
 	t->timer.function = bpf_timer_cb;
 	WRITE_ONCE(timer->timer, t);
@@ -1222,7 +1227,7 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callback_fn,
+BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callback_fn,
 	   struct bpf_prog_aux *, aux)
 {
 	struct bpf_prog *prev, *prog = aux->prog;
@@ -1237,7 +1242,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
 		ret = -EINVAL;
 		goto out;
 	}
-	if (!atomic64_read(&t->map->usercnt)) {
+	if (!atomic64_read(&t->cb.map->usercnt)) {
 		/* maps with timers must be either held by user space
 		 * or pinned in bpffs. Otherwise timer might still be
 		 * running even when bpf prog is detached and user space
@@ -1246,7 +1251,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
 		ret = -EPERM;
 		goto out;
 	}
-	prev = t->prog;
+	prev = t->cb.prog;
 	if (prev != prog) {
 		/* Bump prog refcnt once. Every bpf_timer_set_callback()
 		 * can pick different callback_fn-s within the same prog.
@@ -1259,9 +1264,9 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
 		if (prev)
 			/* Drop prev prog refcnt when swapping with new prog */
 			bpf_prog_put(prev);
-		t->prog = prog;
+		t->cb.prog = prog;
 	}
-	rcu_assign_pointer(t->callback_fn, callback_fn);
+	rcu_assign_pointer(t->cb.callback_fn, callback_fn);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	return ret;
@@ -1275,7 +1280,7 @@ static const struct bpf_func_proto bpf_timer_set_callback_proto = {
 	.arg2_type	= ARG_PTR_TO_FUNC,
 };
 
-BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, flags)
+BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, flags)
 {
 	struct bpf_hrtimer *t;
 	int ret = 0;
@@ -1287,7 +1292,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
 		return -EINVAL;
 	__bpf_spin_lock_irqsave(&timer->lock);
 	t = timer->timer;
-	if (!t || !t->prog) {
+	if (!t || !t->cb.prog) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1315,18 +1320,18 @@ static const struct bpf_func_proto bpf_timer_start_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-static void drop_prog_refcnt(struct bpf_hrtimer *t)
+static void drop_prog_refcnt(struct bpf_async_cb *async)
 {
-	struct bpf_prog *prog = t->prog;
+	struct bpf_prog *prog = async->prog;
 
 	if (prog) {
 		bpf_prog_put(prog);
-		t->prog = NULL;
-		rcu_assign_pointer(t->callback_fn, NULL);
+		async->prog = NULL;
+		rcu_assign_pointer(async->callback_fn, NULL);
 	}
 }
 
-BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
+BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 {
 	struct bpf_hrtimer *t;
 	int ret = 0;
@@ -1348,7 +1353,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
 		ret = -EDEADLK;
 		goto out;
 	}
-	drop_prog_refcnt(t);
+	drop_prog_refcnt(&t->cb);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	/* Cancel the timer and wait for associated callback to finish
@@ -1371,7 +1376,7 @@ static const struct bpf_func_proto bpf_timer_cancel_proto = {
  */
 void bpf_timer_cancel_and_free(void *val)
 {
-	struct bpf_timer_kern *timer = val;
+	struct bpf_async_kern *timer = val;
 	struct bpf_hrtimer *t;
 
 	/* Performance optimization: read timer->timer without lock first. */
@@ -1383,7 +1388,7 @@ void bpf_timer_cancel_and_free(void *val)
 	t = timer->timer;
 	if (!t)
 		goto out;
-	drop_prog_refcnt(t);
+	drop_prog_refcnt(&t->cb);
 	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
 	 * this timer, since it won't be initialized.
 	 */
@@ -1410,7 +1415,7 @@ void bpf_timer_cancel_and_free(void *val)
 	 */
 	if (this_cpu_read(hrtimer_running) != t)
 		hrtimer_cancel(&t->timer);
-	kfree_rcu(t, rcu);
+	kfree_rcu(t, cb.rcu);
 }
 
 BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)

-- 
2.44.0


