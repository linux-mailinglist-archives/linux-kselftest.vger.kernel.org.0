Return-Path: <linux-kselftest+bounces-8146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45798A6DA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCAE286D6E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF1E134404;
	Tue, 16 Apr 2024 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNT5AKZX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CCE1339A5;
	Tue, 16 Apr 2024 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276651; cv=none; b=HH3hnifyg4FysqcPZor2JDP+56c+ZHhXbo1qJfA8S19kmr00DSA9OyiamF0DL6KN2nlQnLtcVVTDdLvw4WYOi7zfIjPULWJbbntf1stYjwua7pnwHkQKEXRV6QDeJoy1J7jgzsTdFsz5DKas93WZGgtdQOzJ3efviPtQeGum4eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276651; c=relaxed/simple;
	bh=PseaAsRe0UQgLtMjT0SGl7UnaF8PrYknBxggC5vUVrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CoEuf++WZJl0RYHxx4hfdjVdC4auFXmG0A4G+tzVLeM/uBvc0M5Oima8G78b+Qyc56ht8zdCvW8kha9E24bFekeogAlsetAVCjl7pmuiRx0URKxJixQCVD92BSxvyBdcG2N803whx4FWAYJJQA1sizmbOO+KpUtLkfEHnY2uguE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNT5AKZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADDAC113CE;
	Tue, 16 Apr 2024 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276651;
	bh=PseaAsRe0UQgLtMjT0SGl7UnaF8PrYknBxggC5vUVrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jNT5AKZXe9raa0hcklIyPMICum30AslIk4X57nihBFUwLghvPU7vA4DkQrP/whpwV
	 N5tbq8p4D+em6zZ6mObXV1Zha+oWEnRZCrphNXZJMHRL7qkxn12WhI4o1NU0Ejagbx
	 bquZbvg26nqsf7X+tbQAqbX9olZBjxQHdX/ElF4HParMFiNhlOjVW9UpK48gYyd8D2
	 nOkzwrIc/mwmalCu9gIFPSZSIvpw8lvBgWfprZoG3Pr5Usni7RNPXgjieeVo9cCc6+
	 57qgYUZTapOuByoNnDzQBv+mOxgXaE3UFkTHDsWMLSEUaSK91+lLMAUxGTh/Xe1ZR6
	 1QL3P2vceTzaQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 16 Apr 2024 16:08:27 +0200
Subject: [PATCH bpf-next 14/18] bpf/verifier: add is_sleepable argument to
 push_callback_call
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-bpf_wq-v1-14-c9e66092f842@kernel.org>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
In-Reply-To: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713276593; l=5920;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=PseaAsRe0UQgLtMjT0SGl7UnaF8PrYknBxggC5vUVrU=;
 b=SoWxMt1mk464DpWnaOlnqSg4DfOq8FtKLR75n5jkaMxB72wkkzSi+uM6qqeLgiXPxyr6yfu2h
 jkVAzdCBgZTBoY+bCNT3sfrXCgzY6RAqyPGDiDTNozgRwOHtTj6yCzw
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

To support sleepable async callbacks, we need to tell push_callback_call()
whether the cb is sleepable or not.
Doing so while checking for the kfunc arguments (when we call
push_callback_call()) is simpler than adding a check for a function
while inside push_callback_call().

When a callback is tagged as sleepable, the verifier now knows that it is
the case and can allow a sleepable callback to happen.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 26 ++++++++++++++++----------
 2 files changed, 17 insertions(+), 10 deletions(-)

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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5e8c1e65fe8c..6a45d88244c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1429,6 +1429,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	}
 	dst_state->speculative = src->speculative;
 	dst_state->active_rcu_lock = src->active_rcu_lock;
+	dst_state->in_sleepable = src->in_sleepable;
 	dst_state->curframe = src->curframe;
 	dst_state->active_lock.ptr = src->active_lock.ptr;
 	dst_state->active_lock.id = src->active_lock.id;
@@ -2404,7 +2405,7 @@ static void init_func_state(struct bpf_verifier_env *env,
 /* Similar to push_stack(), but for async callbacks */
 static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 						int insn_idx, int prev_insn_idx,
-						int subprog)
+						int subprog, bool is_sleepable)
 {
 	struct bpf_verifier_stack_elem *elem;
 	struct bpf_func_state *frame;
@@ -2431,6 +2432,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	 * Initialize it similar to do_check_common().
 	 */
 	elem->st.branches = 1;
+	elem->st.in_sleepable = is_sleepable;
 	frame = kzalloc(sizeof(*frame), GFP_KERNEL);
 	if (!frame)
 		goto err;
@@ -5278,7 +5280,8 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 
 static bool in_sleepable(struct bpf_verifier_env *env)
 {
-	return env->prog->sleepable;
+	return env->prog->sleepable ||
+	       (env->cur_state && env->cur_state->in_sleepable);
 }
 
 /* The non-sleepable programs and sleepable programs with explicit bpf_rcu_read_lock()
@@ -9515,7 +9518,7 @@ static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
 }
 
 static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			      int insn_idx, int subprog,
+			      int insn_idx, int subprog, bool is_sleepable,
 			      set_callee_state_fn set_callee_state_cb)
 {
 	struct bpf_verifier_state *state = env->cur_state, *callback_state;
@@ -9550,7 +9553,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		/* there is no real recursion here. timer callbacks are async */
 		env->subprog_info[subprog].is_async_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
-					 insn_idx, subprog);
+					 insn_idx, subprog, is_sleepable);
 		if (!async_cb)
 			return -EFAULT;
 		callee = async_cb->frame[0];
@@ -10389,15 +10392,15 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 		break;
 	case BPF_FUNC_for_each_map_elem:
-		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno, false,
 					 set_map_elem_callback_state);
 		break;
 	case BPF_FUNC_timer_set_callback:
-		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno, false,
 					 set_timer_callback_state);
 		break;
 	case BPF_FUNC_find_vma:
-		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno, false,
 					 set_find_vma_callback_state);
 		break;
 	case BPF_FUNC_snprintf:
@@ -10412,7 +10415,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		if (err)
 			return err;
 		if (cur_func(env)->callback_depth < regs[BPF_REG_1].umax_value) {
-			err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+			err = push_callback_call(env, insn, insn_idx, meta.subprogno, false,
 						 set_loop_callback_state);
 		} else {
 			cur_func(env)->callback_depth = 0;
@@ -10515,7 +10518,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		break;
 	}
 	case BPF_FUNC_user_ringbuf_drain:
-		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno, false,
 					 set_user_ringbuf_callback_state);
 		break;
 	}
@@ -12232,7 +12235,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return err;
 
 	if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
-		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno, false,
 					 set_rbtree_add_callback_state);
 		if (err) {
 			verbose(env, "kfunc %s#%d failed callback verification\n",
@@ -17004,6 +17007,9 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->active_rcu_lock != cur->active_rcu_lock)
 		return false;
 
+	if (old->in_sleepable != cur->in_sleepable)
+		return false;
+
 	/* for states to be equal callsites have to be the same
 	 * and all frame states need to be equivalent
 	 */

-- 
2.44.0


