Return-Path: <linux-kselftest+bounces-8546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E59F8ABA95
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67D31F224B5
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 09:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93CD4F21D;
	Sat, 20 Apr 2024 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAtsmP1C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5EC4E1CE;
	Sat, 20 Apr 2024 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604212; cv=none; b=EnN//1an8ZhbzeGoNtLCkeiIPgEMyKOeJv5ljuLdga2oeLlcODzs56Y669JxpmUqtptaBpryTjPoMBNDKgzK6HoUXX87zyhTCeLFovDvkl4bx3eON9+AoHZe7kPV/ECNvVjq8+XazbxOrJqBSHTkAhOvJgBOmuOwqtjO37oBRrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604212; c=relaxed/simple;
	bh=745QHzeYZKja5+WqbnVkjgUCagHdLB9t4ESzK/zGB/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CZ2QmkkDIaLr1FRUrG0PT5mLkCs4ZBFUTyt7wN1j5hOuC0TYuDmeBJ/Dq77SuNXh7Go9Y+80T1kUsnahkinp00vaD/tiFyxXmuhgqoXPvxtXcP8aDDWJLOhRs+uDXHYj//bpiQwwifRSw2CxLWo0BJZ+hRD4FytnzTh3OLO9kaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAtsmP1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42253C3277B;
	Sat, 20 Apr 2024 09:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604212;
	bh=745QHzeYZKja5+WqbnVkjgUCagHdLB9t4ESzK/zGB/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PAtsmP1C14pNmSnyjtnHNGhUoTUyxuW/RpqLvD2mha7+m9oeaUKn+vut5VYEjZUJC
	 Tids+yEAcSZ0Q/oW9IRFvFO/45Di5B96KcJPhALu0+0wjH9tMie9vS4V6ZPNWZHstt
	 be2+w4+slqjtIiB3oAI6UZYKiNywJws8QcyupgqCUXZQsZX/xmGDIN7ncw8vxnJXxQ
	 nTXIOYvx/bH2c16HyeqFZuOwQdPD/a+P4aAGC2yzEcmlllV8a3o+cGKEkgYWenpgaF
	 95KITCRKYvhSZBk+kRKZx5fnECJK9pVHWTjZq71yNFXN9tuNn0oS+gRZV/IXVtUeRl
	 tgnxSo5iJp+AA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 20 Apr 2024 11:09:13 +0200
Subject: [PATCH bpf-next v2 13/16] bpf: wq: add bpf_wq_set_callback_impl
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-bpf_wq-v2-13-6c986a5a741f@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713604159; l=9513;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=745QHzeYZKja5+WqbnVkjgUCagHdLB9t4ESzK/zGB/Y=;
 b=PoJUN6Vk3yvwjPCwD+/MDAfOLcW5Gf4HU6xT8zn9H8wqdYgDdpy6nOTP44TeR4ShNUp8b9Vtb
 5EDDcj2j19eCtmEmebA41wvsIGbWlIodXv6O9hyYlCw/HgK3cyc6wLD
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

To support sleepable async callbacks, we need to tell push_async_cb()
whether the cb is sleepable or not.

The verifier now detects that we are in bpf_wq_set_callback_impl and
can allow a sleepable callback to happen.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- dropped flags check for sleepable
- squashed with v1 14/18 as there is no point in having it separated now
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/helpers.c         | 15 +++++++++
 kernel/bpf/verifier.c        | 75 ++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 36d19cd32eb5..9db35530c878 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -426,6 +426,7 @@ struct bpf_verifier_state {
 	 * while they are still in use.
 	 */
 	bool used_as_loop_entry;
+	bool in_sleepable;
 
 	/* first and last insn idx of this verifier state */
 	u32 first_insn_idx;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b12486adc47a..85d3f483f27f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2711,6 +2711,20 @@ __bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags)
 	return __bpf_async_init(async, map, flags, BPF_ASYNC_TYPE_WQ);
 }
 
+__bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
+					 int (callback_fn)(void *map, int *key, struct bpf_wq *wq),
+					 unsigned int flags,
+					 void *aux__ign)
+{
+	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)aux__ign;
+	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
+
+	if (flags)
+		return -EINVAL;
+
+	return __bpf_async_set_callback(async, callback_fn, aux, flags, BPF_ASYNC_TYPE_WQ);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -2789,6 +2803,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 BTF_ID_FLAGS(func, bpf_wq_init)
+BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5ff7b52d9032..e8603cff395b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -501,8 +501,12 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
 }
 
 static bool is_sync_callback_calling_kfunc(u32 btf_id);
+static bool is_async_callback_calling_kfunc(u32 btf_id);
+static bool is_callback_calling_kfunc(u32 btf_id);
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
 
+static bool is_bpf_wq_set_callback_impl_kfunc(u32 btf_id);
+
 static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
 {
 	return func_id == BPF_FUNC_for_each_map_elem ||
@@ -530,7 +534,8 @@ static bool is_sync_callback_calling_insn(struct bpf_insn *insn)
 
 static bool is_async_callback_calling_insn(struct bpf_insn *insn)
 {
-	return bpf_helper_call(insn) && is_async_callback_calling_function(insn->imm);
+	return (bpf_helper_call(insn) && is_async_callback_calling_function(insn->imm)) ||
+	       (bpf_pseudo_kfunc_call(insn) && is_async_callback_calling_kfunc(insn->imm));
 }
 
 static bool is_may_goto_insn(struct bpf_insn *insn)
@@ -1429,6 +1434,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	}
 	dst_state->speculative = src->speculative;
 	dst_state->active_rcu_lock = src->active_rcu_lock;
+	dst_state->in_sleepable = src->in_sleepable;
 	dst_state->curframe = src->curframe;
 	dst_state->active_lock.ptr = src->active_lock.ptr;
 	dst_state->active_lock.id = src->active_lock.id;
@@ -2404,7 +2410,7 @@ static void init_func_state(struct bpf_verifier_env *env,
 /* Similar to push_stack(), but for async callbacks */
 static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 						int insn_idx, int prev_insn_idx,
-						int subprog)
+						int subprog, bool is_sleepable)
 {
 	struct bpf_verifier_stack_elem *elem;
 	struct bpf_func_state *frame;
@@ -2431,6 +2437,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	 * Initialize it similar to do_check_common().
 	 */
 	elem->st.branches = 1;
+	elem->st.in_sleepable = is_sleepable;
 	frame = kzalloc(sizeof(*frame), GFP_KERNEL);
 	if (!frame)
 		goto err;
@@ -5278,7 +5285,8 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 
 static bool in_sleepable(struct bpf_verifier_env *env)
 {
-	return env->prog->sleepable;
+	return env->prog->sleepable ||
+	       (env->cur_state && env->cur_state->in_sleepable);
 }
 
 /* The non-sleepable programs and sleepable programs with explicit bpf_rcu_read_lock()
@@ -9513,7 +9521,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 */
 	env->subprog_info[subprog].is_cb = true;
 	if (bpf_pseudo_kfunc_call(insn) &&
-	    !is_sync_callback_calling_kfunc(insn->imm)) {
+	    !is_callback_calling_kfunc(insn->imm)) {
 		verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
 			func_id_name(insn->imm), insn->imm);
 		return -EFAULT;
@@ -9527,10 +9535,11 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	if (is_async_callback_calling_insn(insn)) {
 		struct bpf_verifier_state *async_cb;
 
-		/* there is no real recursion here. timer callbacks are async */
+		/* there is no real recursion here. timer and workqueue callbacks are async */
 		env->subprog_info[subprog].is_async_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
-					 insn_idx, subprog);
+					 insn_idx, subprog,
+					 is_bpf_wq_set_callback_impl_kfunc(insn->imm));
 		if (!async_cb)
 			return -EFAULT;
 		callee = async_cb->frame[0];
@@ -11018,6 +11027,7 @@ enum special_kfunc_type {
 	KF_bpf_percpu_obj_drop_impl,
 	KF_bpf_throw,
 	KF_bpf_iter_css_task_new,
+	KF_bpf_wq_set_callback_impl,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11044,6 +11054,7 @@ BTF_ID(func, bpf_throw)
 #ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
 #endif
+BTF_ID(func, bpf_wq_set_callback_impl)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -11074,6 +11085,7 @@ BTF_ID(func, bpf_iter_css_task_new)
 #else
 BTF_ID_UNUSED
 #endif
+BTF_ID(func, bpf_wq_set_callback_impl)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -11402,12 +11414,28 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id)
 	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
 }
 
+static bool is_async_callback_calling_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback_impl];
+}
+
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
 {
 	return bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
 	       insn->imm == special_kfunc_list[KF_bpf_throw];
 }
 
+static bool is_bpf_wq_set_callback_impl_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback_impl];
+}
+
+static bool is_callback_calling_kfunc(u32 btf_id)
+{
+	return is_sync_callback_calling_kfunc(btf_id) ||
+	       is_async_callback_calling_kfunc(btf_id);
+}
+
 static bool is_rbtree_lock_required_kfunc(u32 btf_id)
 {
 	return is_bpf_rbtree_api_kfunc(btf_id);
@@ -12219,6 +12247,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (is_bpf_wq_set_callback_impl_kfunc(meta.func_id)) {
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
 
@@ -16982,6 +17020,9 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->active_rcu_lock != cur->active_rcu_lock)
 		return false;
 
+	if (old->in_sleepable != cur->in_sleepable)
+		return false;
+
 	/* for states to be equal callsites have to be the same
 	 * and all frame states need to be equivalent
 	 */
@@ -19653,6 +19694,28 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (is_bpf_wq_set_callback_impl_kfunc(desc->func_id)) {
+		/* The verifier will process callback_fn as many times as necessary
+		 * with different maps and the register states prepared by
+		 * set_timer_callback_state will be accurate.
+		 *
+		 * The following use case is valid:
+		 *   map1 is shared by prog1, prog2, prog3.
+		 *   prog1 calls bpf_timer_init for some map1 elements
+		 *   prog2 calls bpf_timer_set_callback for some map1 elements.
+		 *     Those that were not bpf_timer_init-ed will return -EINVAL.
+		 *   prog3 calls bpf_timer_start for some map1 elements.
+		 *     Those that were not both bpf_timer_init-ed and
+		 *     bpf_timer_set_callback-ed will return -EINVAL.
+		 */
+		struct bpf_insn ld_addrs[2] = {
+			BPF_LD_IMM64(BPF_REG_4, (long)env->prog->aux),
+		};
+
+		insn_buf[0] = ld_addrs[0];
+		insn_buf[1] = ld_addrs[1];
+		insn_buf[2] = *insn;
+		*cnt = 3;
 	}
 	return 0;
 }

-- 
2.44.0


