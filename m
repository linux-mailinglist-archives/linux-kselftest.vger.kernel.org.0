Return-Path: <linux-kselftest+bounces-8147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0088A6DAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6BF1C21B9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB90135418;
	Tue, 16 Apr 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYfPuUOi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DCB1353F9;
	Tue, 16 Apr 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276655; cv=none; b=L1m/bW+fzSvMfOhBkmIQx//BkCaea80LPWZBmv5Lz5s6SDYkqOiW+36M/oE6aOK/xfuwGwKKnwf39Vx0c29gZpB7Uk05Sf649ISAmARYHwK99umcBwq2wTNMlOFtJT9mDeGyknZWdAKo7nhLbbhxnydC8g2dUwY2ogpx1XyN9eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276655; c=relaxed/simple;
	bh=PPXK46VhuHV4LHvO9/F2U+mh0gqt3BI4LddQFjAfCcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OGPpgsDibmWyKBnu6Cf90dMsqcG8ebdoUhyctaHUfm8eyZ33vOeScYGmb/NlHpjEPwohZE3boVdacoGtcCedhJCpmqREkbeEbnJGJ9fUu4EQ4xksdo6C1BMsV3WRMcSkrGQuHvU04ig9oXoh1FJ2sain8Yfs2ZGy/y04PJ3J5HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYfPuUOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0F2C4AF4D;
	Tue, 16 Apr 2024 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276655;
	bh=PPXK46VhuHV4LHvO9/F2U+mh0gqt3BI4LddQFjAfCcI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PYfPuUOiPYH+zBB1jAahr4hRLjQ2z792X+k9Z1/8kfEwqoooWDCW/2Gs0EVJQH2K+
	 O5bFY9lBhiSQKwbdCkBOh7SePT4sKACP/gJKifr6/YlU3rGe8V00LFnw+s79Uanyxg
	 +5QpAHkHzs5kVpLKyI5E2tMDwjpbeT+qssPW4KH6d7L23888I9jZR7OHZSqqUaXHNZ
	 cUlPmqroYZJwdR54vSQzgaXUyF4er4/rdbuZzop+m+h/TAQCpyJsGdOxEb5j8gbJFa
	 OdEm8kR9v5pWG2IGlMi97QDPjw/NAEpVV0BtMyZvlxOntRCLSq4uzixikaHy8tV5VC
	 OAW3YC5bnsdnA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 16 Apr 2024 16:08:28 +0200
Subject: [PATCH bpf-next 15/18] bpf: wq: add bpf_wq_set_callback_impl
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-bpf_wq-v1-15-c9e66092f842@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713276593; l=7703;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=PPXK46VhuHV4LHvO9/F2U+mh0gqt3BI4LddQFjAfCcI=;
 b=RSyFLk/zlbBQyIZ8BLnNNTu7HjvoidQ1Ic4eaTp/8ry4ZigR7hwKkRmYcGeNKAO4wZSx0mO4m
 yvpMFsvDgWmCDxCQ7HjFjP6ksfusw6wwj219GTvDpgQl9wCLJBGqWx4
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

In the verifier, we need to teach it that the mentioned callback is
is an async call.
We look at the provided flags and set the callback to be sleepable if
BPF_F_WQ_SLEEPABLE is set.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 kernel/bpf/helpers.c  | 22 +++++++++++++++++
 kernel/bpf/verifier.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9ac1b8bb3a01..e5c8adc44619 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1362,6 +1362,13 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 		ret = -EINVAL;
 		goto out;
 	}
+	if (type == BPF_ASYNC_TYPE_WQ) {
+		/* check that flags_k is consistent with work->flags */
+		if ((flags ^ cb->flags) & BPF_F_WQ_SLEEPABLE) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
 	if (!atomic64_read(&cb->map->usercnt)) {
 		/* maps with timers must be either held by user space
 		 * or pinned in bpffs. Otherwise timer might still be
@@ -2721,6 +2728,20 @@ __bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *map, unsigned int flags)
 	return __bpf_async_init(async, map, flags, BPF_ASYNC_TYPE_WQ);
 }
 
+__bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
+					 int (callback_fn)(void *map, int *key, struct bpf_wq *wq),
+					 unsigned int flags__k,
+					 void *aux__ign)
+{
+	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)aux__ign;
+	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
+
+	if (flags__k & ~BPF_F_WQ_SLEEPABLE)
+		return -EINVAL;
+
+	return __bpf_async_set_callback(async, callback_fn, aux, flags__k, BPF_ASYNC_TYPE_WQ);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -2799,6 +2820,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 BTF_ID_FLAGS(func, bpf_wq_init)
+BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6a45d88244c6..947cd544ffab 100644
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
@@ -9536,7 +9541,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 */
 	env->subprog_info[subprog].is_cb = true;
 	if (bpf_pseudo_kfunc_call(insn) &&
-	    !is_sync_callback_calling_kfunc(insn->imm)) {
+	    !is_callback_calling_kfunc(insn->imm)) {
 		verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
 			func_id_name(insn->imm), insn->imm);
 		return -EFAULT;
@@ -9550,7 +9555,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	if (is_async_callback_calling_insn(insn)) {
 		struct bpf_verifier_state *async_cb;
 
-		/* there is no real recursion here. timer callbacks are async */
+		/* there is no real recursion here. timer and workqueue callbacks are async */
 		env->subprog_info[subprog].is_async_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
 					 insn_idx, subprog, is_sleepable);
@@ -11042,6 +11047,7 @@ enum special_kfunc_type {
 	KF_bpf_throw,
 	KF_bpf_iter_css_task_new,
 	KF_bpf_wq_init,
+	KF_bpf_wq_set_callback_impl,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11069,6 +11075,7 @@ BTF_ID(func, bpf_throw)
 BTF_ID(func, bpf_iter_css_task_new)
 #endif
 BTF_ID(func, bpf_wq_init)
+BTF_ID(func, bpf_wq_set_callback_impl)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -11100,6 +11107,7 @@ BTF_ID(func, bpf_iter_css_task_new)
 BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_wq_init)
+BTF_ID(func, bpf_wq_set_callback_impl)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -11431,12 +11439,28 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id)
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
@@ -12244,6 +12268,22 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (is_bpf_wq_set_callback_impl_kfunc(meta.func_id)) {
+		if (!meta.arg_constant.found) {
+			verbose(env, "kfunc %s#%d failed flags verification\n",
+				func_name, meta.func_id);
+			return -EINVAL;
+		}
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 !!(meta.arg_constant.value & BPF_F_WQ_SLEEPABLE),
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
 
@@ -19681,6 +19721,28 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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


