Return-Path: <linux-kselftest+bounces-4565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2918538DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 18:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D58283680
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 17:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9188C5FF07;
	Tue, 13 Feb 2024 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNP8/pNm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE48C0A;
	Tue, 13 Feb 2024 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846377; cv=none; b=ARrZy4RLvhLy7YEl9GqiHa9Z6Bw+BklieIOPzn/ZTB6bTrIF0b2yJjj5nj8lYO07EQKQnhpo9rxyVIHwprjuKK325Ch59qKLygprgHzZ/gb45ag/+tzAkC5SS+DAs2nzbObVOqFvGRV6pOQqoJwzFTv2T09gTwsH/dL9GhKPQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846377; c=relaxed/simple;
	bh=AVSXJeMD8NMzaOCebzmgDUBvECAgBumsSpW90nbp8nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lvymrw5xvHrkrNVtXoRD0SP4OfWGTGlk5xhZG2dCBqaRlXEcVzWM9RC6q4bxchV610eR3e1pcdk7k9Jw49CPwKelE3fHfwgTetIRsn9MnnYVa1a0wscS4RZLQdw7kFLdiaQlJfU/XqohpS+FdloGHcBkjKLl31X0gOKDBqqPurs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNP8/pNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D321C433C7;
	Tue, 13 Feb 2024 17:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707846376;
	bh=AVSXJeMD8NMzaOCebzmgDUBvECAgBumsSpW90nbp8nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jNP8/pNmDSRSpssOu0s+Dy4OJmCqL9e0TIaaBU4JFMFgZnxhf0IFy8K48jVsbtSos
	 PjaTJOyud5FkG8tuWgcqKcGipwvWkxePULMG177ZnXfQ6ZSq8tIB+7IFiJARU/XE65
	 7sntG/ZVG457BryVF7UiQKP2ut4DPEGhwhuvN1pJTH4UEw8FOf2+e/L0yTRdyF7D4L
	 MWWrVDAJHdz8d7RM2FEUjLm+AU5AAaj4WObRWf/zoIBDyWm+D9BO2Af/K6oCx8BTmM
	 ER6f8bcgIaL06wbFOveLWQHcLbF8fdQWroyyuyptaArtWRUjnlk8cMOaTgBSkZtJvt
	 uiM/dm3jbtdJg==
Date: Tue, 13 Feb 2024 18:46:09 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC bpf-next 0/9] allow HID-BPF to do device IOs
Message-ID: <zybv26nmqtmyghakbebwxanzgzsfm6brvi7qw3ljoh4dijbjki@ub7atnumzuhy>
References: <20240209-hid-bpf-sleepable-v1-0-4cc895b5adbd@kernel.org>
 <87bk8pve2z.fsf@toke.dk>
 <CAO-hwJ+UeaBydN9deA8KBbgBiC_UCt6oXX-wGnNuSr8fhUrkXw@mail.gmail.com>
 <875xyxva9u.fsf@toke.dk>
 <CAO-hwJLvEGNRXc8G2PR+AQ6kJg+k5YqSt3F7LCSc0zWnmFfe5g@mail.gmail.com>
 <87r0hhfudh.fsf@toke.dk>
 <CAO-hwJLxkt=THKBjxDA6KZsC5h52rCXZ-2RNKPCiYMHNjhQJNg@mail.gmail.com>
 <CAADnVQKt7zu2OY0xHCkTb=KSXO33Xj8H4vVYMqP51ZJ_Kj1sZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKt7zu2OY0xHCkTb=KSXO33Xj8H4vVYMqP51ZJ_Kj1sZA@mail.gmail.com>

On Feb 12 2024, Alexei Starovoitov wrote:
> On Mon, Feb 12, 2024 at 10:21 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > On Mon, Feb 12, 2024 at 6:46 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> > >
> > > Benjamin Tissoires <benjamin.tissoires@redhat.com> writes:
> > >
[...]
> I agree that workqueue delegation fits into the bpf_timer concept and
> a lot of code can and should be shared.

Thanks Alexei for the detailed answer. I've given it an attempt but still can not
figure it out entirely.

> All the lessons(bugs) learned with bpf_timer don't need to be re-discovered :)
> Too bad, bpf_timer_set_callback() doesn't have a flag argument,
> so we need a new kfunc to set a sleepable callback.
> Maybe
> bpf_timer_set_sleepable_cb() ?

OK. So I guess I should drop Toke's suggestion with the bpf_timer_ini() flag?

> The verifier will set is_async_cb = true for it (like it does for regular cb-s).
> And since prog->aux->sleepable is kinda "global" we need another
> per subprog flag:
> bool is_sleepable: 1;

done (in push_callback_call())

> 
> We can factor out a check "if (prog->aux->sleepable)" into a helper
> that will check that "global" flag and another env->cur_state->in_sleepable
> flag that will work similar to active_rcu_lock.

done (I think), cf patch 2 below

> Once the verifier starts processing subprog->is_sleepable
> it will set cur_state->in_sleepable = true;
> to make all subprogs called from that cb to be recognized as sleepable too.

That's the point I don't know where to put the new code.

It seems the best place would be in do_check(), but I am under the impression
that the code of the callback is added at the end of the instruction list, meaning
that I do not know where it starts, and which subprog index it corresponds to.

> 
> A bit of a challenge is what to do with global subprogs,
> since they're verified lazily. They can be called from
> sleepable and non-sleepable contex. Should be solvable.

I must confess this is way over me (and given that I didn't even managed to make
the "easy" case working, that might explain things a little :-P )

> 
> Overall I think this feature is needed urgently,
> so if you don't have cycles to work on this soon,
> I can prioritize it right after bpf_arena work.

I can try to spare a few cycles on it. Even if your instructions were on
spot, I still can't make the subprogs recognized as sleepable.

For reference, this is where I am (probably bogus, but seems to be
working when timer_set_sleepable_cb() is called from a sleepable context
as mentioned by Toke):

---
From d4aa3d969fa9a89c6447d843dad338fde2ac0155 Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 13 Feb 2024 18:40:01 +0100
Subject: [PATCH RFC bpf-next v2 01/11] Sleepable timers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-hid-bpf-sleepable-v2-1-6c2d6b49865c@kernel.org>

---
 include/linux/bpf_verifier.h   |  2 +
 include/uapi/linux/bpf.h       | 13 ++++++
 kernel/bpf/helpers.c           | 91 +++++++++++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c          | 20 ++++++++--
 tools/include/uapi/linux/bpf.h | 13 ++++++
 5 files changed, 130 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 84365e6dd85d..789ef5fec547 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -426,6 +426,7 @@ struct bpf_verifier_state {
 	 * while they are still in use.
 	 */
 	bool used_as_loop_entry;
+	bool in_sleepable;
 
 	/* first and last insn idx of this verifier state */
 	u32 first_insn_idx;
@@ -626,6 +627,7 @@ struct bpf_subprog_info {
 	bool is_async_cb: 1;
 	bool is_exception_cb: 1;
 	bool args_cached: 1;
+	bool is_sleepable: 1;
 
 	u8 arg_cnt;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d96708380e52..ef1f2be4cfef 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5742,6 +5742,18 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_timer_set_sleepable_cb(struct bpf_timer *timer, void *callback_fn)
+ *	Description
+ *		Configure the timer to call *callback_fn* static function in a
+ *		sleepable context.
+ *	Return
+ *		0 on success.
+ *		**-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier.
+ *		**-EPERM** if *timer* is in a map that doesn't have any user references.
+ *		The user space should either hold a file descriptor to a map with timers
+ *		or pin such map in bpffs. When map is unpinned or file descriptor is
+ *		closed all timers in the map will be cancelled and freed.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5956,6 +5968,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(timer_set_sleepable_cb, 212, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4db1c658254c..e3b83d27b1b6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1097,9 +1097,11 @@ const struct bpf_func_proto bpf_snprintf_proto = {
  */
 struct bpf_hrtimer {
 	struct hrtimer timer;
+	struct work_struct work;
 	struct bpf_map *map;
 	struct bpf_prog *prog;
 	void __rcu *callback_fn;
+	void __rcu *sleepable_cb_fn;
 	void *value;
 };
 
@@ -1113,18 +1115,64 @@ struct bpf_timer_kern {
 	struct bpf_spin_lock lock;
 } __attribute__((aligned(8)));
 
+static void bpf_timer_work_cb(struct work_struct *work)
+{
+	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer, work);
+	struct bpf_map *map = t->map;
+	void *value = t->value;
+	bpf_callback_t callback_fn;
+	void *key;
+	u32 idx;
+
+	BTF_TYPE_EMIT(struct bpf_timer);
+
+	rcu_read_lock();
+	callback_fn = rcu_dereference(t->sleepable_cb_fn);
+	rcu_read_unlock();
+	if (!callback_fn)
+		return;
+
+	// /* bpf_timer_work_cb() runs in hrtimer_run_softirq. It doesn't migrate and
+	//  * cannot be preempted by another bpf_timer_cb() on the same cpu.
+	//  * Remember the timer this callback is servicing to prevent
+	//  * deadlock if callback_fn() calls bpf_timer_cancel() or
+	//  * bpf_map_delete_elem() on the same timer.
+	//  */
+	// this_cpu_write(hrtimer_running, t);
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
+	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
+	/* The verifier checked that return value is zero. */
+
+	// this_cpu_write(hrtimer_running, NULL);
+}
+
 static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 {
 	struct bpf_hrtimer *t = container_of(hrtimer, struct bpf_hrtimer, timer);
+	bpf_callback_t callback_fn, sleepable_cb_fn;
 	struct bpf_map *map = t->map;
 	void *value = t->value;
-	bpf_callback_t callback_fn;
 	void *key;
 	u32 idx;
 
 	BTF_TYPE_EMIT(struct bpf_timer);
+	sleepable_cb_fn = rcu_dereference_check(t->sleepable_cb_fn, rcu_read_lock_bh_held());
+	if (sleepable_cb_fn) {
+		schedule_work(&t->work);
+		goto out;
+	}
+
 	callback_fn = rcu_dereference_check(t->callback_fn, rcu_read_lock_bh_held());
 	if (!callback_fn)
 		goto out;
@@ -1190,7 +1238,9 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 	t->map = map;
 	t->prog = NULL;
 	rcu_assign_pointer(t->callback_fn, NULL);
+	rcu_assign_pointer(t->sleepable_cb_fn, NULL);
 	hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
+	INIT_WORK(&t->work, bpf_timer_work_cb);
 	t->timer.function = bpf_timer_cb;
 	WRITE_ONCE(timer->timer, t);
 	/* Guarantee the order between timer->timer and map->usercnt. So
@@ -1221,8 +1271,8 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callback_fn,
-	   struct bpf_prog_aux *, aux)
+static int __bpf_timer_set_callback(struct bpf_timer_kern *timer, void *callback_fn,
+				    struct bpf_prog_aux *aux, bool is_sleepable)
 {
 	struct bpf_prog *prev, *prog = aux->prog;
 	struct bpf_hrtimer *t;
@@ -1260,12 +1310,24 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
 			bpf_prog_put(prev);
 		t->prog = prog;
 	}
-	rcu_assign_pointer(t->callback_fn, callback_fn);
+	if (is_sleepable) {
+		rcu_assign_pointer(t->sleepable_cb_fn, callback_fn);
+		rcu_assign_pointer(t->callback_fn, NULL);
+	} else {
+		rcu_assign_pointer(t->callback_fn, callback_fn);
+		rcu_assign_pointer(t->sleepable_cb_fn, NULL);
+	}
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	return ret;
 }
 
+BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callback_fn,
+	   struct bpf_prog_aux *, aux)
+{
+	return __bpf_timer_set_callback(timer, callback_fn, aux, false);
+}
+
 static const struct bpf_func_proto bpf_timer_set_callback_proto = {
 	.func		= bpf_timer_set_callback,
 	.gpl_only	= true,
@@ -1274,6 +1336,20 @@ static const struct bpf_func_proto bpf_timer_set_callback_proto = {
 	.arg2_type	= ARG_PTR_TO_FUNC,
 };
 
+BPF_CALL_3(bpf_timer_set_sleepable_cb, struct bpf_timer_kern *, timer, void *, callback_fn,
+	   struct bpf_prog_aux *, aux)
+{
+	return __bpf_timer_set_callback(timer, callback_fn, aux, true);
+}
+
+static const struct bpf_func_proto bpf_timer_set_sleepable_cb_proto = {
+	.func		= bpf_timer_set_sleepable_cb,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_TIMER,
+	.arg2_type	= ARG_PTR_TO_FUNC,
+};
+
 BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, flags)
 {
 	struct bpf_hrtimer *t;
@@ -1353,6 +1429,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
 	 * if it was running.
 	 */
 	ret = ret ?: hrtimer_cancel(&t->timer);
+	ret = ret ?: cancel_work_sync(&t->work);
 	return ret;
 }
 
@@ -1405,8 +1482,10 @@ void bpf_timer_cancel_and_free(void *val)
 	 * effectively cancelled because bpf_timer_cb() will return
 	 * HRTIMER_NORESTART.
 	 */
-	if (this_cpu_read(hrtimer_running) != t)
+	if (this_cpu_read(hrtimer_running) != t) {
 		hrtimer_cancel(&t->timer);
+	}
+	cancel_work_sync(&t->work);
 	kfree(t);
 }
 
@@ -1749,6 +1828,8 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_timer_init_proto;
 	case BPF_FUNC_timer_set_callback:
 		return &bpf_timer_set_callback_proto;
+	case BPF_FUNC_timer_set_sleepable_cb:
+		return &bpf_timer_set_sleepable_cb_proto;
 	case BPF_FUNC_timer_start:
 		return &bpf_timer_start_proto;
 	case BPF_FUNC_timer_cancel:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 64fa188d00ad..400c625efe22 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -513,7 +513,8 @@ static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
 
 static bool is_async_callback_calling_function(enum bpf_func_id func_id)
 {
-	return func_id == BPF_FUNC_timer_set_callback;
+	return func_id == BPF_FUNC_timer_set_callback ||
+	       func_id == BPF_FUNC_timer_set_sleepable_cb;
 }
 
 static bool is_callback_calling_function(enum bpf_func_id func_id)
@@ -1414,6 +1415,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	}
 	dst_state->speculative = src->speculative;
 	dst_state->active_rcu_lock = src->active_rcu_lock;
+	dst_state->in_sleepable = src->in_sleepable;
 	dst_state->curframe = src->curframe;
 	dst_state->active_lock.ptr = src->active_lock.ptr;
 	dst_state->active_lock.id = src->active_lock.id;
@@ -9434,11 +9436,13 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 
 	if (insn->code == (BPF_JMP | BPF_CALL) &&
 	    insn->src_reg == 0 &&
-	    insn->imm == BPF_FUNC_timer_set_callback) {
+	    (insn->imm == BPF_FUNC_timer_set_callback ||
+	     insn->imm == BPF_FUNC_timer_set_sleepable_cb)) {
 		struct bpf_verifier_state *async_cb;
 
 		/* there is no real recursion here. timer callbacks are async */
 		env->subprog_info[subprog].is_async_cb = true;
+		env->subprog_info[subprog].is_sleepable = insn->imm == BPF_FUNC_timer_set_sleepable_cb;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
 					 insn_idx, subprog);
 		if (!async_cb)
@@ -10280,6 +10284,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 					 set_map_elem_callback_state);
 		break;
 	case BPF_FUNC_timer_set_callback:
+		fallthrough;
+	case BPF_FUNC_timer_set_sleepable_cb:
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 					 set_timer_callback_state);
 		break;
@@ -15586,7 +15592,9 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		return DONE_EXPLORING;
 
 	case BPF_CALL:
-		if (insn->src_reg == 0 && insn->imm == BPF_FUNC_timer_set_callback)
+		if (insn->src_reg == 0 &&
+		    (insn->imm == BPF_FUNC_timer_set_callback ||
+		     insn->imm == BPF_FUNC_timer_set_sleepable_cb))
 			/* Mark this call insn as a prune point to trigger
 			 * is_state_visited() check before call itself is
 			 * processed by __check_func_call(). Otherwise new
@@ -16762,6 +16770,9 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->active_rcu_lock != cur->active_rcu_lock)
 		return false;
 
+	if (old->in_sleepable != cur->in_sleepable)
+		return false;
+
 	/* for states to be equal callsites have to be the same
 	 * and all frame states need to be equivalent
 	 */
@@ -19639,7 +19650,8 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			continue;
 		}
 
-		if (insn->imm == BPF_FUNC_timer_set_callback) {
+		if (insn->imm == BPF_FUNC_timer_set_callback ||
+		    insn->imm == BPF_FUNC_timer_set_sleepable_cb) {
 			/* The verifier will process callback_fn as many times as necessary
 			 * with different maps and the register states prepared by
 			 * set_timer_callback_state will be accurate.
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d96708380e52..ef1f2be4cfef 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5742,6 +5742,18 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_timer_set_sleepable_cb(struct bpf_timer *timer, void *callback_fn)
+ *	Description
+ *		Configure the timer to call *callback_fn* static function in a
+ *		sleepable context.
+ *	Return
+ *		0 on success.
+ *		**-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier.
+ *		**-EPERM** if *timer* is in a map that doesn't have any user references.
+ *		The user space should either hold a file descriptor to a map with timers
+ *		or pin such map in bpffs. When map is unpinned or file descriptor is
+ *		closed all timers in the map will be cancelled and freed.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5956,6 +5968,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(timer_set_sleepable_cb, 212, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't

-- 
2.43.0

---
From 6c654010a4660fd26ffce44406dba308ded3b465 Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 13 Feb 2024 18:40:02 +0100
Subject: [PATCH RFC bpf-next v2 02/11] bpf/verifier: introduce in_sleepable() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-hid-bpf-sleepable-v2-2-6c2d6b49865c@kernel.org>

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 kernel/bpf/verifier.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 400c625efe22..8c3707d27c02 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5257,6 +5257,12 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	return -EINVAL;
 }
 
+static bool in_sleepable(struct bpf_verifier_env *env)
+{
+	return env->prog->aux->sleepable ||
+	       (env->cur_state && env->cur_state->in_sleepable);
+}
+
 /* The non-sleepable programs and sleepable programs with explicit bpf_rcu_read_lock()
  * can dereference RCU protected pointers and result is PTR_TRUSTED.
  */
@@ -5264,7 +5270,7 @@ static bool in_rcu_cs(struct bpf_verifier_env *env)
 {
 	return env->cur_state->active_rcu_lock ||
 	       env->cur_state->active_lock.ptr ||
-	       !env->prog->aux->sleepable;
+	       !in_sleepable(env);
 }
 
 /* Once GCC supports btf_type_tag the following mechanism will be replaced with tag check */
@@ -10153,7 +10159,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return -EINVAL;
 	}
 
-	if (!env->prog->aux->sleepable && fn->might_sleep) {
+	if (!in_sleepable(env) && fn->might_sleep) {
 		verbose(env, "helper call might sleep in a non-sleepable prog\n");
 		return -EINVAL;
 	}
@@ -10183,7 +10189,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return -EINVAL;
 		}
 
-		if (env->prog->aux->sleepable && is_storage_get_function(func_id))
+		if (in_sleepable(env) && is_storage_get_function(func_id))
 			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
@@ -11544,7 +11550,7 @@ static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
 			return true;
 		fallthrough;
 	default:
-		return env->prog->aux->sleepable;
+		return in_sleepable(env);
 	}
 }
 
@@ -12065,7 +12071,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	sleepable = is_kfunc_sleepable(&meta);
-	if (sleepable && !env->prog->aux->sleepable) {
+	if (sleepable && !in_sleepable(env)) {
 		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
 		return -EACCES;
 	}
@@ -18208,7 +18214,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				return -E2BIG;
 			}
 
-			if (env->prog->aux->sleepable)
+			if (in_sleepable(env))
 				atomic64_inc(&map->sleepable_refcnt);
 			/* hold the map. If the program is rejected by verifier,
 			 * the map will be released by release_maps() or it
@@ -19685,7 +19691,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 
 		if (is_storage_get_function(insn->imm)) {
-			if (!env->prog->aux->sleepable ||
+			if (!in_sleepable(env) ||
 			    env->insn_aux_data[i + delta].storage_get_func_atomic)
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
 			else

-- 
2.43.0
---

Cheers,
Benjamin

