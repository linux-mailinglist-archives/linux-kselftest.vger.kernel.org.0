Return-Path: <linux-kselftest+bounces-7377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8BD89B9BD
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 10:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174B21F218E1
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 08:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9824D36AF2;
	Mon,  8 Apr 2024 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXN4idVV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF6364AE;
	Mon,  8 Apr 2024 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563795; cv=none; b=r5Yrv01FElTRzh5uId4BNdqifhp3s+i4XAcTNijIo36yJ5FFkh2UOdaHW4RMIQqXZdK9Of0f94zGtDSM5BJMiKLtmjDPkcSffH3KbJAlnNWYR0hTs5zDCQHzHFVy+EkYN77ZOXFTJ84RJOXSuh4tRKKtE4qhkU/ZPEsvtp2OxEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563795; c=relaxed/simple;
	bh=VANyjQaTmLoOHEbU+/Mh4TaRphGOd6knnqKxEaiLGlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R1c+e/xOiQVBXMX2J4am/cYRDIaAA7+McnfGXJAZybs0X/W2liKEvotTaXF2FUg/ckV6PvwNlYJ0bNolG85R3ysPBp5jWA8AMN1Okey8aR+F/K50++N+Vv5/gD3AKQ5zDMYQR9uC3Z2WLlIDTy08B7LxX2IsULHqaVMPe+KPDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXN4idVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919B4C43394;
	Mon,  8 Apr 2024 08:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712563795;
	bh=VANyjQaTmLoOHEbU+/Mh4TaRphGOd6knnqKxEaiLGlY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nXN4idVVWrGZEqVjAkBeTdPSC8UDXppwvJeOb/Jk6xRpE1aiyX100zJ9O3Fdn1JOi
	 Lw+UJQELHkW8XtSjcIU51q1h4+wyxgHh6mmmfFM94rURIlC9Dvv9qPFFPvUtTtNKw/
	 EeBq6iYnoh00nFEITY23Vdt8eNumzsiAKByTd3nO8lGe5tyw62R5TyuvJrh+1pgL24
	 RnbPypE5HdnoM0pv1DegvB0m7xCZ/k2BC+zb4HdrozcJ5+VxUIXYT9vnh6mHlE2LeG
	 9YsjVt4WG/aktoSn+6SFqMjWNiIzRNiSQ2ippDZblwGZLM+rzgjyFaotBNNi01v5un
	 pPbGtqH3H1rwQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 08 Apr 2024 10:09:26 +0200
Subject: [PATCH RFC bpf-next v6 1/6] bpf/helpers: introduce sleepable
 bpf_timers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-hid-bpf-sleepable-v6-1-0499ddd91b94@kernel.org>
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
In-Reply-To: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712563787; l=11246;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=VANyjQaTmLoOHEbU+/Mh4TaRphGOd6knnqKxEaiLGlY=;
 b=oKchrtdzCzSgjD8vA4yeXn7tF/hEtaKKVB6pHPh403b6YHLWPBSMQTFvwW6KHrEsGOEFaHHsK
 CbT+bAZHGKTDa+FiSZPXXbFZ6nA1MKuNfRAL0PgpUnxovi4l1R/ohL+
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

They are implemented as a workqueue, which means that there are no
guarantees of timing nor ordering.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v6:
- dropped extra spinlock
- implement cancel_and_free of a sleepable timer through
  a dedicated workqueue

no changes in v5

changes in v4:
- dropped __bpf_timer_compute_key()
- use a spin_lock instead of a semaphore
- ensure bpf_timer_cancel_and_free is not complaining about
  non sleepable context and use cancel_work() instead of
  cancel_work_sync()
- return -EINVAL if a delay is given to bpf_timer_start() with
  BPF_F_TIMER_SLEEPABLE

changes in v3:
- extracted the implementation in bpf_timer only, without
  bpf_timer_set_sleepable_cb()
- rely on schedule_work() only, from bpf_timer_start()
- add semaphore to ensure bpf_timer_work_cb() is accessing
  consistent data

changes in v2 (compared to the one attaches to v1 0/9):
- make use of a kfunc
- add a (non-used) BPF_F_TIMER_SLEEPABLE
- the callback is *not* called, it makes the kernel crashes
---
 include/uapi/linux/bpf.h |  13 ++++
 kernel/bpf/helpers.c     | 159 ++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 143 insertions(+), 29 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9585f5345353..f1890eed213a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7469,6 +7469,19 @@ enum {
 	BPF_F_TIMER_CPU_PIN = (1ULL << 1),
 };
 
+/* Extra flags to control bpf_timer_init() behaviour, in addition to CLOCK_*.
+ *     - BPF_F_TIMER_SLEEPABLE: Timer will run in a workqueue in a sleepable
+ *       context, with no guarantees of ordering nor timing (consider this as
+ *       being just offloaded immediately).
+ */
+enum {
+	/* CLOCK_* are using bits 0 to 3 */
+	BPF_F_TIMER_SLEEPABLE = (1ULL << 4),
+	__MAX_BPF_F_TIMER_INIT,
+};
+
+#define MAX_BPF_F_TIMER_INIT __MAX_BPF_F_TIMER_INIT
+
 /* BPF numbers iterator state */
 struct bpf_iter_num {
 	/* opaque iterator state; having __u64 here allows to preserve correct
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9234174ccb21..fd05d4358b31 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1096,12 +1096,19 @@ const struct bpf_func_proto bpf_snprintf_proto = {
  * freeing the timers when inner map is replaced or deleted by user space.
  */
 struct bpf_hrtimer {
-	struct hrtimer timer;
+	union {
+		struct hrtimer timer;
+		struct work_struct work;
+	};
 	struct bpf_map *map;
 	struct bpf_prog *prog;
 	void __rcu *callback_fn;
 	void *value;
-	struct rcu_head rcu;
+	union {
+		struct rcu_head rcu;
+		struct work_struct sync_work;
+	};
+	u64 flags;
 };
 
 /* the actual struct hidden inside uapi struct bpf_timer */
@@ -1114,6 +1121,58 @@ struct bpf_timer_kern {
 	struct bpf_spin_lock lock;
 } __attribute__((aligned(8)));
 
+static void bpf_timer_work_cb(struct work_struct *work)
+{
+	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer, work);
+	struct bpf_tramp_run_ctx __maybe_unused run_ctx;
+	struct bpf_prog *prog = t->prog;
+	struct bpf_map *map = t->map;
+	bpf_callback_t callback_fn;
+	void *value = t->value;
+	unsigned long flags;
+	void *key;
+	u32 idx;
+
+	BTF_TYPE_EMIT(struct bpf_timer);
+
+	callback_fn = READ_ONCE(t->callback_fn);
+	if (!callback_fn || !prog)
+		return;
+
+	if (map->map_type == BPF_MAP_TYPE_ARRAY) {
+		struct bpf_array *array = container_of(map, struct bpf_array, map);
+
+		/* compute the key */
+		idx = ((char *)value - array->value) / array->elem_size;
+		key = &idx;
+	} else { /* hash or lru */
+		key = value - round_up(map->key_size, 8);
+	}
+
+	run_ctx.bpf_cookie = 0;
+
+	if (!__bpf_prog_enter_sleepable_recur(prog, &run_ctx)) {
+		/* recursion detected */
+		__bpf_prog_exit_sleepable_recur(prog, 0, &run_ctx);
+		return;
+	}
+
+	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
+	/* The verifier checked that return value is zero. */
+
+	__bpf_prog_exit_sleepable_recur(prog, 0 /* bpf_prog_run does runtime stats */,
+					&run_ctx);
+}
+
+static void bpf_timer_sync_work_cb(struct work_struct *work)
+{
+	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer, sync_work);
+
+	cancel_work_sync(&t->work);
+
+	kfree_rcu(t, rcu);
+}
+
 static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
@@ -1155,10 +1214,14 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 	return HRTIMER_NORESTART;
 }
 
+#define BPF_TIMER_CLOCK_MASK (MAX_CLOCKS - 1)  /* 0xf */
+#define BPF_TIMER_FLAGS_MASK GENMASK_ULL(63, 4)
+
 BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map,
 	   u64, flags)
 {
-	clockid_t clockid = flags & (MAX_CLOCKS - 1);
+	clockid_t clockid = flags & BPF_TIMER_CLOCK_MASK;
+	u64 bpf_timer_flags = flags & BPF_TIMER_FLAGS_MASK;
 	struct bpf_hrtimer *t;
 	int ret = 0;
 
@@ -1169,7 +1232,7 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 	if (in_nmi())
 		return -EOPNOTSUPP;
 
-	if (flags >= MAX_CLOCKS ||
+	if (bpf_timer_flags & ~(BPF_F_TIMER_SLEEPABLE) ||
 	    /* similar to timerfd except _ALARM variants are not supported */
 	    (clockid != CLOCK_MONOTONIC &&
 	     clockid != CLOCK_REALTIME &&
@@ -1190,8 +1253,14 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 	t->value = (void *)timer - map->record->timer_off;
 	t->map = map;
 	t->prog = NULL;
+	t->flags = flags;
 	rcu_assign_pointer(t->callback_fn, NULL);
-	hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
+	if (flags & BPF_F_TIMER_SLEEPABLE) {
+		INIT_WORK(&t->work, bpf_timer_work_cb);
+		INIT_WORK(&t->sync_work, bpf_timer_sync_work_cb);
+	} else {
+		hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
+	}
 	t->timer.function = bpf_timer_cb;
 	WRITE_ONCE(timer->timer, t);
 	/* Guarantee the order between timer->timer and map->usercnt. So
@@ -1292,6 +1361,11 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
 		goto out;
 	}
 
+	if ((t->flags & BPF_F_TIMER_SLEEPABLE) && nsecs) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (flags & BPF_F_TIMER_ABS)
 		mode = HRTIMER_MODE_ABS_SOFT;
 	else
@@ -1300,7 +1374,10 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
 	if (flags & BPF_F_TIMER_CPU_PIN)
 		mode |= HRTIMER_MODE_PINNED;
 
-	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
+	if (t->flags & BPF_F_TIMER_SLEEPABLE)
+		schedule_work(&t->work);
+	else
+		hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	return ret;
@@ -1329,6 +1406,7 @@ static void drop_prog_refcnt(struct bpf_hrtimer *t)
 BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
 {
 	struct bpf_hrtimer *t;
+	u64 flags = 0;
 	int ret = 0;
 
 	if (in_nmi())
@@ -1340,6 +1418,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
 		ret = -EINVAL;
 		goto out;
 	}
+	flags = t->flags;
 	if (this_cpu_read(hrtimer_running) == t) {
 		/* If bpf callback_fn is trying to bpf_timer_cancel()
 		 * its own timer the hrtimer_cancel() will deadlock
@@ -1351,10 +1430,20 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
 	drop_prog_refcnt(t);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
-	/* Cancel the timer and wait for associated callback to finish
-	 * if it was running.
-	 */
-	ret = ret ?: hrtimer_cancel(&t->timer);
+
+	if (flags & BPF_F_TIMER_SLEEPABLE) {
+		/* Cancel the sleepable work, but *do not* wait for
+		 * it to finish if it was running as we might not be in a
+		 * sleepable context
+		 */
+		ret = ret ?: cancel_work(&t->work);
+	} else {
+		/* Cancel the timer and wait for associated callback to finish
+		 * if it was running.
+		 */
+		ret = ret ?: hrtimer_cancel(&t->timer);
+	}
+
 	rcu_read_unlock();
 	return ret;
 }
@@ -1373,6 +1462,7 @@ void bpf_timer_cancel_and_free(void *val)
 {
 	struct bpf_timer_kern *timer = val;
 	struct bpf_hrtimer *t;
+	u64 flags;
 
 	/* Performance optimization: read timer->timer without lock first. */
 	if (!READ_ONCE(timer->timer))
@@ -1383,6 +1473,7 @@ void bpf_timer_cancel_and_free(void *val)
 	t = timer->timer;
 	if (!t)
 		goto out;
+	flags = t->flags;
 	drop_prog_refcnt(t);
 	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
 	 * this timer, since it won't be initialized.
@@ -1392,25 +1483,35 @@ void bpf_timer_cancel_and_free(void *val)
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	if (!t)
 		return;
-	/* Cancel the timer and wait for callback to complete if it was running.
-	 * If hrtimer_cancel() can be safely called it's safe to call kfree(t)
-	 * right after for both preallocated and non-preallocated maps.
-	 * The timer->timer = NULL was already done and no code path can
-	 * see address 't' anymore.
-	 *
-	 * Check that bpf_map_delete/update_elem() wasn't called from timer
-	 * callback_fn. In such case don't call hrtimer_cancel() (since it will
-	 * deadlock) and don't call hrtimer_try_to_cancel() (since it will just
-	 * return -1). Though callback_fn is still running on this cpu it's
-	 * safe to do kfree(t) because bpf_timer_cb() read everything it needed
-	 * from 't'. The bpf subprog callback_fn won't be able to access 't',
-	 * since timer->timer = NULL was already done. The timer will be
-	 * effectively cancelled because bpf_timer_cb() will return
-	 * HRTIMER_NORESTART.
-	 */
-	if (this_cpu_read(hrtimer_running) != t)
-		hrtimer_cancel(&t->timer);
-	kfree_rcu(t, rcu);
+
+	if (flags & BPF_F_TIMER_SLEEPABLE) {
+		/* Trigger cancel of the sleepable work, but *do not* wait for
+		 * it to finish if it was running as we might not be in a
+		 * sleepable context.
+		 * kfree will be called once the work has finished.
+		 */
+		schedule_work(&t->sync_work);
+	} else {
+		/* Cancel the timer and wait for callback to complete if it was running.
+		 * If hrtimer_cancel() can be safely called it's safe to call kfree(t)
+		 * right after for both preallocated and non-preallocated maps.
+		 * The timer->timer = NULL was already done and no code path can
+		 * see address 't' anymore.
+		 *
+		 * Check that bpf_map_delete/update_elem() wasn't called from timer
+		 * callback_fn. In such case don't call hrtimer_cancel() (since it will
+		 * deadlock) and don't call hrtimer_try_to_cancel() (since it will just
+		 * return -1). Though callback_fn is still running on this cpu it's
+		 * safe to do kfree(t) because bpf_timer_cb() read everything it needed
+		 * from 't'. The bpf subprog callback_fn won't be able to access 't',
+		 * since timer->timer = NULL was already done. The timer will be
+		 * effectively cancelled because bpf_timer_cb() will return
+		 * HRTIMER_NORESTART.
+		 */
+		if (this_cpu_read(hrtimer_running) != t)
+			hrtimer_cancel(&t->timer);
+		kfree_rcu(t, rcu);
+	}
 }
 
 BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)

-- 
2.44.0


