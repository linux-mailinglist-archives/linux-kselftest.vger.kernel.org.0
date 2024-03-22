Return-Path: <linux-kselftest+bounces-6494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE3C886F27
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 15:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA8EB228B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 14:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA1C4AEFA;
	Fri, 22 Mar 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpAez5Ca"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1022B4D595;
	Fri, 22 Mar 2024 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119402; cv=none; b=sTBuFGxc2C3FOJDLloz9vLE6MmF1bzZTZybGjCIWtnoU0Qe+Wf71ttjm2KItGJNE8gzjtYfYlUEYYW8VkqFpOr7tUegiKxkvv6hGOg4jM6t7WOALkkICD6WrLeocLBCcKIZIHbxWzx9vjOajEnW/itmNGgYcPNdbER18cQyxY7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119402; c=relaxed/simple;
	bh=uzeeMIA82Gs8Ds/icQVXmG5R3SHb6PK9Zf1JM6cUHio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qUAnIqObKwlqIYG/fjljUEuQJ4hJ6tHqCnh/8eMgHG3e0EvzcU559tQAWBMYmGchKPjbawYu9PMHPTp+KcMSSMV9Os9wo8kiFr+QfnOffqzc1i6x5CdFoI877mS9iEsYdRbpX0BJKS5w8ooiUwdATPlcFVpuSzpEeH6dpibjMVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpAez5Ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B26C43330;
	Fri, 22 Mar 2024 14:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711119400;
	bh=uzeeMIA82Gs8Ds/icQVXmG5R3SHb6PK9Zf1JM6cUHio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QpAez5CaQD/4nydhSAkRTtQ45CsT1V0jSuAoFbFtq2vfKKTygcK8PjEmdZ2eJp5H4
	 Mz9VMb1K1pfbW3gcysrJgdNlDhq3LGvJq6jFZLfvl7RqrGyWEqZWkIcApPNmo0z9xf
	 m7718rkyqpgNy0RLe95JNUakfV6HILY3kWOig9cw3R7djWgnr6PcymzMGSTigOISMM
	 G8sPTHaa7gMrtnIfn6uhUGe24GJLAI806vUxMno4GP9WhQgh7QkjJ0b3YQZZ9dk2tt
	 FM6u4LpK6Uvf2kel43LNzlpaw+AyhCSJnywK/EFsdFxhvn2mbo4L6nlB2i7/jWnByp
	 UDb2zHbnojZsA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 22 Mar 2024 15:56:21 +0100
Subject: [PATCH bpf-next v5 1/6] bpf/helpers: introduce sleepable
 bpf_timers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-hid-bpf-sleepable-v5-1-179c7b59eaaa@kernel.org>
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
In-Reply-To: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711119393; l=7912;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=uzeeMIA82Gs8Ds/icQVXmG5R3SHb6PK9Zf1JM6cUHio=;
 b=+8eSNx7ash73ltT9fJD1L7cL9y+pO1GhVUlVZDVn4n0/ZwkWHlWA+DcVGBj2sgJvHkPArtO69
 HkzqDfZxJ9kAWD09LO3RQTJgK09pQ3QLHlpinGKZ/292CG8Ip0f3TMC
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

They are implemented as a workqueue, which means that there are no
guarantees of timing nor ordering.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

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
 include/uapi/linux/bpf.h |  4 +++
 kernel/bpf/helpers.c     | 86 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3c42b9f1bada..b90def29d796 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7461,10 +7461,14 @@ struct bpf_core_relo {
  *     - BPF_F_TIMER_ABS: Timeout passed is absolute time, by default it is
  *       relative to current time.
  *     - BPF_F_TIMER_CPU_PIN: Timer will be pinned to the CPU of the caller.
+ *     - BPF_F_TIMER_SLEEPABLE: Timer will run in a sleepable context, with
+ *       no guarantees of ordering nor timing (consider this as being just
+ *       offloaded immediately).
  */
 enum {
 	BPF_F_TIMER_ABS = (1ULL << 0),
 	BPF_F_TIMER_CPU_PIN = (1ULL << 1),
+	BPF_F_TIMER_SLEEPABLE = (1ULL << 2),
 };
 
 /* BPF numbers iterator state */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a89587859571..38de73a9df83 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1094,14 +1094,20 @@ const struct bpf_func_proto bpf_snprintf_proto = {
  * bpf_timer_cancel() cancels the timer and decrements prog's refcnt.
  * Inner maps can contain bpf timers as well. ops->map_release_uref is
  * freeing the timers when inner map is replaced or deleted by user space.
+ *
+ * sleepable_lock protects only the setup of the workqueue, not the callback
+ * itself. This is done to ensure we don't run concurrently a free of the
+ * callback or the associated program.
  */
 struct bpf_hrtimer {
 	struct hrtimer timer;
+	struct work_struct work;
 	struct bpf_map *map;
 	struct bpf_prog *prog;
 	void __rcu *callback_fn;
 	void *value;
 	struct rcu_head rcu;
+	spinlock_t sleepable_lock;
 };
 
 /* the actual struct hidden inside uapi struct bpf_timer */
@@ -1114,6 +1120,49 @@ struct bpf_timer_kern {
 	struct bpf_spin_lock lock;
 } __attribute__((aligned(8)));
 
+static void bpf_timer_work_cb(struct work_struct *work)
+{
+	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer, work);
+	struct bpf_map *map = t->map;
+	bpf_callback_t callback_fn;
+	void *value = t->value;
+	unsigned long flags;
+	void *key;
+	u32 idx;
+
+	BTF_TYPE_EMIT(struct bpf_timer);
+
+	spin_lock_irqsave(&t->sleepable_lock, flags);
+
+	callback_fn = READ_ONCE(t->callback_fn);
+	if (!callback_fn) {
+		spin_unlock_irqrestore(&t->sleepable_lock, flags);
+		return;
+	}
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
+	/* prevent the callback to be freed by bpf_timer_cancel() while running
+	 * so we can release the sleepable lock
+	 */
+	bpf_prog_inc(t->prog);
+
+	spin_unlock_irqrestore(&t->sleepable_lock, flags);
+
+	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
+	/* The verifier checked that return value is zero. */
+
+	bpf_prog_put(t->prog);
+}
+
 static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
@@ -1192,6 +1241,8 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 	t->prog = NULL;
 	rcu_assign_pointer(t->callback_fn, NULL);
 	hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
+	INIT_WORK(&t->work, bpf_timer_work_cb);
+	spin_lock_init(&t->sleepable_lock);
 	t->timer.function = bpf_timer_cb;
 	WRITE_ONCE(timer->timer, t);
 	/* Guarantee the order between timer->timer and map->usercnt. So
@@ -1237,6 +1288,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
 		ret = -EINVAL;
 		goto out;
 	}
+	spin_lock(&t->sleepable_lock);
 	if (!atomic64_read(&t->map->usercnt)) {
 		/* maps with timers must be either held by user space
 		 * or pinned in bpffs. Otherwise timer might still be
@@ -1263,6 +1315,8 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
 	}
 	rcu_assign_pointer(t->callback_fn, callback_fn);
 out:
+	if (t)
+		spin_unlock(&t->sleepable_lock);
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	return ret;
 }
@@ -1283,8 +1337,12 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
 
 	if (in_nmi())
 		return -EOPNOTSUPP;
-	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
+	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN | BPF_F_TIMER_SLEEPABLE))
 		return -EINVAL;
+
+	if ((flags & BPF_F_TIMER_SLEEPABLE) && nsecs)
+		return -EINVAL;
+
 	__bpf_spin_lock_irqsave(&timer->lock);
 	t = timer->timer;
 	if (!t || !t->prog) {
@@ -1300,7 +1358,10 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
 	if (flags & BPF_F_TIMER_CPU_PIN)
 		mode |= HRTIMER_MODE_PINNED;
 
-	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
+	if (flags & BPF_F_TIMER_SLEEPABLE)
+		schedule_work(&t->work);
+	else
+		hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	return ret;
@@ -1348,13 +1409,22 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
 		ret = -EDEADLK;
 		goto out;
 	}
+	spin_lock(&t->sleepable_lock);
 	drop_prog_refcnt(t);
+	spin_unlock(&t->sleepable_lock);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	/* Cancel the timer and wait for associated callback to finish
 	 * if it was running.
 	 */
 	ret = ret ?: hrtimer_cancel(&t->timer);
+
+	/* also cancel the sleepable work, but *do not* wait for
+	 * it to finish if it was running as we might not be in a
+	 * sleepable context
+	 */
+	ret = ret ?: cancel_work(&t->work);
+
 	rcu_read_unlock();
 	return ret;
 }
@@ -1383,11 +1453,13 @@ void bpf_timer_cancel_and_free(void *val)
 	t = timer->timer;
 	if (!t)
 		goto out;
+	spin_lock(&t->sleepable_lock);
 	drop_prog_refcnt(t);
 	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
 	 * this timer, since it won't be initialized.
 	 */
 	WRITE_ONCE(timer->timer, NULL);
+	spin_unlock(&t->sleepable_lock);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	if (!t)
@@ -1410,6 +1482,16 @@ void bpf_timer_cancel_and_free(void *val)
 	 */
 	if (this_cpu_read(hrtimer_running) != t)
 		hrtimer_cancel(&t->timer);
+
+	/* also cancel the sleepable work, but *do not* wait for
+	 * it to finish if it was running as we might not be in a
+	 * sleepable context. Same reason as above, it's fine to
+	 * free 't': the subprog callback will never access it anymore
+	 * and can not reschedule itself since timer->timer = NULL was
+	 * already done.
+	 */
+	cancel_work(&t->work);
+
 	kfree_rcu(t, rcu);
 }
 

-- 
2.44.0


