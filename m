Return-Path: <linux-kselftest+bounces-5187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D2E85E319
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55621C22E11
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7467E82D91;
	Wed, 21 Feb 2024 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2iBXTEW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CEF81AB3;
	Wed, 21 Feb 2024 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532742; cv=none; b=TZlESJiQS17q4CqWphqNT1A8CJ8vk4Lp7ssmj8KEj+7MZbdeux5cj9W+94hNjO7Fv2fiXUAlM+bOCz/O9EG86dnhxW8hVfIgMEnCQdgVFh4q2lCtzkvxeokt+pBOEXa/mazvrowitEVErV4L1e8iQK9cfjcJRpXIpFzwhGPDARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532742; c=relaxed/simple;
	bh=ZYNT6AaQhkuGvT8Z9dQUoI41EykqVHPK+5CqRnyQs3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mUm7JDUMx+5T+A+orbYjhug/xNh54d6zUcQr2uri3pi1+0jskGb7rbb/XYZoxlwuP1mRGP/3bW7CvLoWNCKxm401jOgUkqslHC6fUvycPgMEXMZ6U0EQGp8w1O7cc0Fsku1ZCPyNdOntzXcSz3ye5zWg2y50tGyM6CRV4Qmmb2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2iBXTEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE27EC433B2;
	Wed, 21 Feb 2024 16:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532741;
	bh=ZYNT6AaQhkuGvT8Z9dQUoI41EykqVHPK+5CqRnyQs3A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m2iBXTEWXgULxh3hvLUrKiSzHgnKmHSkFNNoAVbtLUy+WhGa3JBGLTRuKCYOUiLa0
	 3lyIlTI3YmfYd96dg6z3iHx35L7ZwgYPkqIdBPLqgWl39A8SRKupmQZ4CteLYppLyp
	 rUvitXx4/Zh2Io8PPd/8AXkk93J6mCHdmDwmYerxAKtEh5r+R82u5LjBJc9wzsIvRQ
	 tyhtvKu3lx5dka/z7gZZVQb0FuEcEEp+NGZn/N8NlQk6h4AXZkdjlBAZhpCJP4v3w4
	 kWxO4WYE2rqA72mC4S7QBDy5XNtCEGZyBNeBzkOPJmH/2d3Vabotg6cip4x66VlL7c
	 2jw6dkrAyHOzA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 21 Feb 2024 17:25:20 +0100
Subject: [PATCH RFC bpf-next v3 04/16] bpf/helpers: introduce sleepable
 bpf_timers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-hid-bpf-sleepable-v3-4-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
In-Reply-To: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708532719; l=7906;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=ZYNT6AaQhkuGvT8Z9dQUoI41EykqVHPK+5CqRnyQs3A=;
 b=NhATyVXLBVmiUhI3zNu7Frdb/5dMuW4X4D3dXM/NaBaAy0JRXEJNO0fjK1D7kD/h0+fckzBvg
 7iaiB1bNfDqDlBCwS7fo235/Sn9HYXfGYGh3WXOQ3gRFFBRjXGYA+yy
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

They are implemented as a workqueue, which means that there are no
guarantees of timing nor ordering.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

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
 kernel/bpf/helpers.c     | 92 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 82 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d96708380e52..1fc7ecbd9d33 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7421,10 +7421,14 @@ struct bpf_core_relo {
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
index 93edf730d288..f9add0abe40a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -23,6 +23,7 @@
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
+#include <linux/semaphore.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -1094,13 +1095,19 @@ const struct bpf_func_proto bpf_snprintf_proto = {
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
+	struct semaphore sleepable_lock;
 };
 
 /* the actual struct hidden inside uapi struct bpf_timer */
@@ -1113,6 +1120,55 @@ struct bpf_timer_kern {
 	struct bpf_spin_lock lock;
 } __attribute__((aligned(8)));
 
+static u32 __bpf_timer_compute_key(struct bpf_hrtimer *timer)
+{
+	struct bpf_map *map = timer->map;
+	void *value = timer->value;
+
+	if (map->map_type == BPF_MAP_TYPE_ARRAY) {
+		struct bpf_array *array = container_of(map, struct bpf_array, map);
+
+		/* compute the key */
+		return ((char *)value - array->value) / array->elem_size;
+	}
+
+	/* hash or lru */
+	return *(u32 *)(value - round_up(map->key_size, 8));
+}
+
+static void bpf_timer_work_cb(struct work_struct *work)
+{
+	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer, work);
+	struct bpf_map *map = t->map;
+	void *value = t->value;
+	bpf_callback_t callback_fn;
+	u32 key;
+
+	BTF_TYPE_EMIT(struct bpf_timer);
+
+	down(&t->sleepable_lock);
+
+	callback_fn = READ_ONCE(t->callback_fn);
+	if (!callback_fn) {
+		up(&t->sleepable_lock);
+		return;
+	}
+
+	key = __bpf_timer_compute_key(t);
+
+	/* prevent the callback to be freed by bpf_timer_cancel() while running
+	 * so we can release the semaphore
+	 */
+	bpf_prog_inc(t->prog);
+
+	up(&t->sleepable_lock);
+
+	callback_fn((u64)(long)map, (u64)(long)&key, (u64)(long)value, 0, 0);
+	/* The verifier checked that return value is zero. */
+
+	bpf_prog_put(t->prog);
+}
+
 static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
@@ -1121,8 +1177,7 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 	struct bpf_map *map = t->map;
 	void *value = t->value;
 	bpf_callback_t callback_fn;
-	void *key;
-	u32 idx;
+	u32 key;
 
 	BTF_TYPE_EMIT(struct bpf_timer);
 	callback_fn = rcu_dereference_check(t->callback_fn, rcu_read_lock_bh_held());
@@ -1136,17 +1191,9 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 	 * bpf_map_delete_elem() on the same timer.
 	 */
 	this_cpu_write(hrtimer_running, t);
-	if (map->map_type == BPF_MAP_TYPE_ARRAY) {
-		struct bpf_array *array = container_of(map, struct bpf_array, map);
-
-		/* compute the key */
-		idx = ((char *)value - array->value) / array->elem_size;
-		key = &idx;
-	} else { /* hash or lru */
-		key = value - round_up(map->key_size, 8);
-	}
+	key = __bpf_timer_compute_key(t);
 
-	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
+	callback_fn((u64)(long)map, (u64)(long)&key, (u64)(long)value, 0, 0);
 	/* The verifier checked that return value is zero. */
 
 	this_cpu_write(hrtimer_running, NULL);
@@ -1191,6 +1238,8 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 	t->prog = NULL;
 	rcu_assign_pointer(t->callback_fn, NULL);
 	hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
+	INIT_WORK(&t->work, bpf_timer_work_cb);
+	sema_init(&t->sleepable_lock, 1);
 	t->timer.function = bpf_timer_cb;
 	WRITE_ONCE(timer->timer, t);
 	/* Guarantee the order between timer->timer and map->usercnt. So
@@ -1245,6 +1294,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
 		ret = -EPERM;
 		goto out;
 	}
+	down(&t->sleepable_lock);
 	prev = t->prog;
 	if (prev != prog) {
 		/* Bump prog refcnt once. Every bpf_timer_set_callback()
@@ -1261,6 +1311,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
 		t->prog = prog;
 	}
 	rcu_assign_pointer(t->callback_fn, callback_fn);
+	up(&t->sleepable_lock);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	return ret;
@@ -1282,7 +1333,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
 
 	if (in_nmi())
 		return -EOPNOTSUPP;
-	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
+	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN | BPF_F_TIMER_SLEEPABLE))
 		return -EINVAL;
 	__bpf_spin_lock_irqsave(&timer->lock);
 	t = timer->timer;
@@ -1299,7 +1350,10 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
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
@@ -1346,13 +1400,21 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
 		ret = -EDEADLK;
 		goto out;
 	}
+	down(&t->sleepable_lock);
 	drop_prog_refcnt(t);
+	up(&t->sleepable_lock);
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
 	return ret;
 }
 
@@ -1407,6 +1469,8 @@ void bpf_timer_cancel_and_free(void *val)
 	 */
 	if (this_cpu_read(hrtimer_running) != t)
 		hrtimer_cancel(&t->timer);
+
+	cancel_work_sync(&t->work);
 	kfree(t);
 }
 

-- 
2.43.0


