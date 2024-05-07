Return-Path: <linux-kselftest+bounces-9592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA92A8BE41C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 15:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB4928CEC2
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C26115F321;
	Tue,  7 May 2024 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QP86DZPw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00754156F20;
	Tue,  7 May 2024 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087992; cv=none; b=jeEO1aZ8rs0VMfBDYzsI/MMynYHdJWI72N4rBseDVd9hLmrb8sByn2QxQQK+eiF1sswcWv+mbjObTFNZt5Nhm9bApNgdRRaqPm9GWIH7AUU7ahe0s3HDD6+VR7wVzSDaqVnqU0lL036Hd8V6CtJbf8f9oD6RCQeoavQFl2rRL88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087992; c=relaxed/simple;
	bh=mdcaTx8cr4EuijO3f+G4VMa/INC+vC+0vs1NUy/G+t8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ayi+d8AIM4UwNX1EvxaYP94MDKMXfBxlEk9PdY+cfKc1fotkRl34xVhapj3a6e9qGAgp4YSIkYHfdlqnwPgo1KvL3z2B7ONehKFpXWab9gIkkiCYFtaICEyM+VxNTs4YhjB3mTjx8Ohf51jsaxtPXTTlWOcoy+xowRuffPGYmfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QP86DZPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501FEC2BBFC;
	Tue,  7 May 2024 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715087991;
	bh=mdcaTx8cr4EuijO3f+G4VMa/INC+vC+0vs1NUy/G+t8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QP86DZPwbNGpLP/IHwk/hD+pHWOwxkfMY+j24l9Nlc1+J/aJsU20LCEzGuHHDsDo3
	 RhiGP4IFGt9oNBtFWq05qHp9mwA2775Obrtb8yy2h900P/B4MJ1hZqwVR3hRirMFXE
	 /Ka3aIxdQg6fIv0DhPVxsr8Zl6MaP6yC8oexq0IKX3Ic5b7ljomH2QDWvvxtZ9JLzR
	 NnGWrmVni74xvdDnuaftOlXKwXcjAoLcHhorJ3Yh/EZ9Y1O/WADQuBHIdkNcIswiFG
	 AILgL8lFz6W5sBWf6x6iGPkqKNbXd902tHTTkYU+dlnMvC9YiF5zDh89e8yzMtMLRS
	 xw8zuZ/9vGEdQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 07 May 2024 15:19:30 +0200
Subject: [PATCH RFC bpf-next 2/8] bpf: add kfunc_meta parameter to
 push_callback_call()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-bpf_async-v1-2-b4df966096d8@kernel.org>
References: <20240507-bpf_async-v1-0-b4df966096d8@kernel.org>
In-Reply-To: <20240507-bpf_async-v1-0-b4df966096d8@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715087980; l=8241;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=mdcaTx8cr4EuijO3f+G4VMa/INC+vC+0vs1NUy/G+t8=;
 b=1aGaI5o+lluCosEjLMQWR4X1KGGi0U1ytDRio/8X9irdTXH0RUpFLDy1DY/NzAX1F8ZGSOUft
 vxj90jRUoWGBBf14Ds+M/u/44zvYS1eIg0UQlefxV9yI7fAZsdCNBGj
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

No code change but is a preparatory patch for being able to declare
async callbacks from bpf kfuncs.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

This is an RFC, and is not meant to be fully reviewed/applied as it is.
I'm posting this to show what I wanted to explain in
https://lore.kernel.org/bpf/mhkzkf4e23uvljtmwizwcxyuyat2tmfxn33xb4t7waafgmsa66@mcrzpj3b6ssx/
---
 kernel/bpf/verifier.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 856cb77d0f87..2b1e24c440c5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9339,11 +9339,13 @@ static void clear_caller_saved_regs(struct bpf_verifier_env *env,
 typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee,
-				   int insn_idx);
+				   int insn_idx,
+				   struct bpf_kfunc_call_arg_meta *meta);
 
 static int set_callee_state(struct bpf_verifier_env *env,
 			    struct bpf_func_state *caller,
-			    struct bpf_func_state *callee, int insn_idx);
+			    struct bpf_func_state *callee, int insn_idx,
+			    struct bpf_kfunc_call_arg_meta *meta);
 
 static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int callsite,
 			    set_callee_state_fn set_callee_state_cb,
@@ -9381,7 +9383,7 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 			subprog /* subprog number within this prog */);
 	/* Transfer references to the callee */
 	err = copy_reference_state(callee, caller);
-	err = err ?: set_callee_state_cb(env, caller, callee, callsite);
+	err = err ?: set_callee_state_cb(env, caller, callee, callsite, NULL);
 	if (err)
 		goto err_out;
 
@@ -9518,7 +9520,8 @@ static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
 
 static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			      int insn_idx, int subprog,
-			      set_callee_state_fn set_callee_state_cb)
+			      set_callee_state_fn set_callee_state_cb,
+			      struct bpf_kfunc_call_arg_meta *kfunc_meta)
 {
 	struct bpf_verifier_state *state = env->cur_state, *callback_state;
 	struct bpf_func_state *caller, *callee;
@@ -9560,7 +9563,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		callee->async_entry_cnt = caller->async_entry_cnt + 1;
 
 		/* Convert bpf_timer_set_callback() args into timer callback args */
-		err = set_callee_state_cb(env, caller, callee, insn_idx);
+		err = set_callee_state_cb(env, caller, callee, insn_idx, kfunc_meta);
 		if (err)
 			return err;
 
@@ -9691,7 +9694,8 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 
 static int set_callee_state(struct bpf_verifier_env *env,
 			    struct bpf_func_state *caller,
-			    struct bpf_func_state *callee, int insn_idx)
+			    struct bpf_func_state *callee, int insn_idx,
+			    struct bpf_kfunc_call_arg_meta *meta)
 {
 	int i;
 
@@ -9706,7 +9710,8 @@ static int set_callee_state(struct bpf_verifier_env *env,
 static int set_map_elem_callback_state(struct bpf_verifier_env *env,
 				       struct bpf_func_state *caller,
 				       struct bpf_func_state *callee,
-				       int insn_idx)
+				       int insn_idx,
+				       struct bpf_kfunc_call_arg_meta *meta)
 {
 	struct bpf_insn_aux_data *insn_aux = &env->insn_aux_data[insn_idx];
 	struct bpf_map *map;
@@ -9732,7 +9737,8 @@ static int set_map_elem_callback_state(struct bpf_verifier_env *env,
 static int set_loop_callback_state(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee,
-				   int insn_idx)
+				   int insn_idx,
+				   struct bpf_kfunc_call_arg_meta *meta)
 {
 	/* bpf_loop(u32 nr_loops, void *callback_fn, void *callback_ctx,
 	 *	    u64 flags);
@@ -9754,7 +9760,8 @@ static int set_loop_callback_state(struct bpf_verifier_env *env,
 static int set_timer_callback_state(struct bpf_verifier_env *env,
 				    struct bpf_func_state *caller,
 				    struct bpf_func_state *callee,
-				    int insn_idx)
+				    int insn_idx,
+				    struct bpf_kfunc_call_arg_meta *meta)
 {
 	struct bpf_map *map_ptr = caller->regs[BPF_REG_1].map_ptr;
 
@@ -9784,7 +9791,8 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 static int set_find_vma_callback_state(struct bpf_verifier_env *env,
 				       struct bpf_func_state *caller,
 				       struct bpf_func_state *callee,
-				       int insn_idx)
+				       int insn_idx,
+				       struct bpf_kfunc_call_arg_meta *meta)
 {
 	/* bpf_find_vma(struct task_struct *task, u64 addr,
 	 *               void *callback_fn, void *callback_ctx, u64 flags)
@@ -9812,7 +9820,8 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
 static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
 					   struct bpf_func_state *caller,
 					   struct bpf_func_state *callee,
-					   int insn_idx)
+					   int insn_idx,
+					   struct bpf_kfunc_call_arg_meta *meta)
 {
 	/* bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void
 	 *			  callback_ctx, u64 flags);
@@ -9835,7 +9844,8 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
 static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
 					 struct bpf_func_state *caller,
 					 struct bpf_func_state *callee,
-					 int insn_idx)
+					 int insn_idx,
+					 struct bpf_kfunc_call_arg_meta *meta)
 {
 	/* void bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
 	 *                     bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b));
@@ -10411,15 +10421,15 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		break;
 	case BPF_FUNC_for_each_map_elem:
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
-					 set_map_elem_callback_state);
+					 set_map_elem_callback_state, NULL);
 		break;
 	case BPF_FUNC_timer_set_callback:
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
-					 set_timer_callback_state);
+					 set_timer_callback_state, NULL);
 		break;
 	case BPF_FUNC_find_vma:
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
-					 set_find_vma_callback_state);
+					 set_find_vma_callback_state, NULL);
 		break;
 	case BPF_FUNC_snprintf:
 		err = check_bpf_snprintf_call(env, regs);
@@ -10434,7 +10444,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return err;
 		if (cur_func(env)->callback_depth < regs[BPF_REG_1].umax_value) {
 			err = push_callback_call(env, insn, insn_idx, meta.subprogno,
-						 set_loop_callback_state);
+						 set_loop_callback_state, NULL);
 		} else {
 			cur_func(env)->callback_depth = 0;
 			if (env->log.level & BPF_LOG_LEVEL2)
@@ -10537,7 +10547,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 	case BPF_FUNC_user_ringbuf_drain:
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
-					 set_user_ringbuf_callback_state);
+					 set_user_ringbuf_callback_state, NULL);
 		break;
 	}
 
@@ -12285,7 +12295,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
-					 set_rbtree_add_callback_state);
+					 set_rbtree_add_callback_state, &meta);
 		if (err) {
 			verbose(env, "kfunc %s#%d failed callback verification\n",
 				func_name, meta.func_id);
@@ -12295,7 +12305,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (is_bpf_wq_set_callback_impl_kfunc(meta.func_id)) {
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
-					 set_timer_callback_state);
+					 set_timer_callback_state, &meta);
 		if (err) {
 			verbose(env, "kfunc %s#%d failed callback verification\n",
 				func_name, meta.func_id);

-- 
2.44.0


