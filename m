Return-Path: <linux-kselftest+bounces-5189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA88885E322
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095111C22B47
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218AF83CA9;
	Wed, 21 Feb 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK9/4QRA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E3C823DF;
	Wed, 21 Feb 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532751; cv=none; b=DnYMNey9BtyIPLggB1IvJ0Xsw6I5QTW+NFfLc5cFXeWolxGrtSsavYc07By90J9GnVUkHa3XPPr8xHdjfmPZfG5fhrvDtDRQSA8V3qOwB3xsVpxBUjMfzdI6spJE/jTQ9ETNO8d7FqiQc3h+LLMQ4WEByi4DkAZzJswJ2cdFz2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532751; c=relaxed/simple;
	bh=mPB13lwDyMmrcL43OZduPdt7XlyPzMPfxJk3wSQi6i0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oftbbu/8ox7DEXFoBloQm8ubXDIOE9aq63qNTHGQcwz3KUlVMJZFnjxtiJJm2rmwBDx7dZu8NeSV8xJTtYsH+7AP0jET/C/bKLkMSdt2nBfX9NkJWAtVSPH3RdQdUZmGy/z0i7UsHS1NGlFxUsuA9Z2FxFTlvwEk+SOOlgr1Onc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lK9/4QRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC97FC43394;
	Wed, 21 Feb 2024 16:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532750;
	bh=mPB13lwDyMmrcL43OZduPdt7XlyPzMPfxJk3wSQi6i0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lK9/4QRANbD1ikbby/u0uvG3pn30oMZMO7T/xeFCDV9WRQwCRm6rEZJuhX4fJ0UNb
	 ew6N0AztOnXVz38LOtF+7SfdmVhNNND6BTPvevlw4CBuPrpcDYcloh0u7v/Fa1CpPS
	 89yR3b5t2PUloP30P851IFD3Yq5L2mO9Ovw/ez1wz3i/4hVoYarm1rsjkXeAMEvnNQ
	 UVv6Y2CH1JNETFNXrS9n/3lvDvS2Bjep51D9D7OJwCJDPUXHW3UeTUflHY5Axm2YDG
	 UZSjDEeLJFR8S5IEwCs7d72NRVWHPFJS+x0lB94Wvr1Ium5WbO/Yir0RZS9edBV57Q
	 PQ2ETCkOqFDlw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 21 Feb 2024 17:25:22 +0100
Subject: [PATCH RFC bpf-next v3 06/16] bpf/helpers: introduce
 bpf_timer_set_sleepable_cb() kfunc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-hid-bpf-sleepable-v3-6-1fb378ca6301@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708532719; l=7632;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=mPB13lwDyMmrcL43OZduPdt7XlyPzMPfxJk3wSQi6i0=;
 b=B+nS9++S8JmQb74JEXeGhA+6cIAUKNJ+sqzNSBI47ZNlqXnNUN21KpkprCmTmKXWhLg9LpMLu
 1MZFXPpPuMTDvZlZhGhDZb2jV20Ba+XsRdmHsoNJRxySklYsp7IIIbC
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

In this patch, bpf_timer_set_sleepable_cb() is functionally equivalent
to bpf_timer_set_callback(), to the exception that it enforces
the timer to be started with BPF_F_TIMER_SLEEPABLE.

But given that bpf_timer_set_callback() is a helper when
bpf_timer_set_sleepable_cb() is a kfunc, we need to teach the verifier
about its attached callback.
Marking that callback as sleepable will be done in a separate patch

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v3 (split from v2 02/10)
---
 kernel/bpf/helpers.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++++++--
 2 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f9add0abe40a..2c6dc3d0ffff 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1108,6 +1108,7 @@ struct bpf_hrtimer {
 	void __rcu *callback_fn;
 	void *value;
 	struct semaphore sleepable_lock;
+	bool is_sleepable;
 };
 
 /* the actual struct hidden inside uapi struct bpf_timer */
@@ -1270,8 +1271,8 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callback_fn,
-	   struct bpf_prog_aux *, aux)
+static int __bpf_timer_set_callback(struct bpf_timer_kern *timer, void *callback_fn,
+				    struct bpf_prog_aux *aux, bool is_sleepable)
 {
 	struct bpf_prog *prev, *prog = aux->prog;
 	struct bpf_hrtimer *t;
@@ -1311,12 +1312,19 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
 		t->prog = prog;
 	}
 	rcu_assign_pointer(t->callback_fn, callback_fn);
+	t->is_sleepable = is_sleepable;
 	up(&t->sleepable_lock);
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
@@ -1342,6 +1350,11 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
 		goto out;
 	}
 
+	if (t->is_sleepable && !(flags & BPF_F_TIMER_SLEEPABLE)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (flags & BPF_F_TIMER_ABS)
 		mode = HRTIMER_MODE_ABS_SOFT;
 	else
@@ -2606,6 +2619,36 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
 
+/**
+ * bpf_timer_set_sleepable_cb() - Configure the timer to call %callback_fn
+ * static function in a sleepable context.
+ * @timer: The bpf_timer that needs to be configured
+ * @callback_fn: a static bpf function
+ *
+ * @returns %0 on success. %-EINVAL if %timer was not initialized with
+ * bpf_timer_init() earlier. %-EPERM if %timer is in a map that doesn't
+ * have any user references.
+ * The user space should either hold a file descriptor to a map with timers
+ * or pin such map in bpffs. When map is unpinned or file descriptor is
+ * closed all timers in the map will be cancelled and freed.
+ *
+ * This kfunc is equivalent to %bpf_timer_set_callback except that it tells
+ * the verifier that the target callback is run in a sleepable context.
+ */
+__bpf_kfunc int bpf_timer_set_sleepable_cb(struct bpf_timer_kern *timer,
+					   int (callback_fn)(void *map, int *key, struct bpf_timer *timer))
+{
+	struct bpf_throw_ctx ctx = {};
+
+	arch_bpf_stack_walk(bpf_stack_walker, &ctx);
+	WARN_ON_ONCE(!ctx.aux);
+
+	if (!ctx.aux)
+		return -EINVAL;
+
+	return __bpf_timer_set_callback(timer, (void *)callback_fn, ctx.aux, true);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -2682,6 +2725,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
+BTF_ID_FLAGS(func, bpf_timer_set_sleepable_cb)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2b11687063ff..91e583c6feba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -501,6 +501,8 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
 }
 
 static bool is_sync_callback_calling_kfunc(u32 btf_id);
+static bool is_async_callback_calling_kfunc(u32 btf_id);
+static bool is_callback_calling_kfunc(u32 btf_id);
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
 
 static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
@@ -530,7 +532,8 @@ static bool is_sync_callback_calling_insn(struct bpf_insn *insn)
 
 static bool is_async_callback_calling_insn(struct bpf_insn *insn)
 {
-	return (bpf_helper_call(insn) && is_async_callback_calling_function(insn->imm));
+	return (bpf_helper_call(insn) && is_async_callback_calling_function(insn->imm)) ||
+	       (bpf_pseudo_kfunc_call(insn) && is_async_callback_calling_kfunc(insn->imm));
 }
 
 static bool is_storage_get_function(enum bpf_func_id func_id)
@@ -9459,7 +9462,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 */
 	env->subprog_info[subprog].is_cb = true;
 	if (bpf_pseudo_kfunc_call(insn) &&
-	    !is_sync_callback_calling_kfunc(insn->imm)) {
+	    !is_callback_calling_kfunc(insn->imm)) {
 		verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
 			func_id_name(insn->imm), insn->imm);
 		return -EFAULT;
@@ -10963,6 +10966,7 @@ enum special_kfunc_type {
 	KF_bpf_percpu_obj_drop_impl,
 	KF_bpf_throw,
 	KF_bpf_iter_css_task_new,
+	KF_bpf_timer_set_sleepable_cb,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -10989,6 +10993,7 @@ BTF_ID(func, bpf_throw)
 #ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
 #endif
+BTF_ID(func, bpf_timer_set_sleepable_cb)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -11019,6 +11024,7 @@ BTF_ID(func, bpf_iter_css_task_new)
 #else
 BTF_ID_UNUSED
 #endif
+BTF_ID(func, bpf_timer_set_sleepable_cb)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -11344,12 +11350,23 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id)
 	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
 }
 
+static bool is_async_callback_calling_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_timer_set_sleepable_cb];
+}
+
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
 {
 	return bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
 	       insn->imm == special_kfunc_list[KF_bpf_throw];
 }
 
+static bool is_callback_calling_kfunc(u32 btf_id)
+{
+	return is_sync_callback_calling_kfunc(btf_id) ||
+	       is_async_callback_calling_kfunc(btf_id);
+}
+
 static bool is_rbtree_lock_required_kfunc(u32 btf_id)
 {
 	return is_bpf_rbtree_api_kfunc(btf_id);
@@ -12120,6 +12137,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (is_async_callback_calling_kfunc(meta.func_id)) {
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_timer_callback_state);
+		if (err) {
+			verbose(env, "kfunc %s#%d failed callback verification\n",
+				func_name, meta.func_id);
+			return err;
+		}
+	}
+
 	rcu_lock = is_kfunc_bpf_rcu_read_lock(&meta);
 	rcu_unlock = is_kfunc_bpf_rcu_read_unlock(&meta);
 

-- 
2.43.0


