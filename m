Return-Path: <linux-kselftest+bounces-9593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FA08BE41E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 15:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A171F214C9
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 13:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91F61C65EB;
	Tue,  7 May 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMZU4K3x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B121C1C65E2;
	Tue,  7 May 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087995; cv=none; b=tgaLM8ToHNG/97FM4i3ZzwjA8JNPQD5bgIFn8A98M8ZNekf9Nfj5kWphVQEsTPpruGvCxVCVq2cZUAYHU+8MfUB/Xhkf8hcHDqaknWRlBOd4Oc+ObmzECL7BLPlRCtHEKJp2CKwNYLEJV84J8Iwxm1tftoaxkx94cBojQtpl15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087995; c=relaxed/simple;
	bh=SLNZxKQweYv3yP5iFQGwSZpSSxqoUn6F/nU0+QfT/tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s+PsECflp2Q78p+A07RJ4s9inY0562/Je28Q1ZKVcLjplYkc3byJdmp0qV7nqr4s9Ml89K6xeqXbCDR6J7pSAcRs1brkhm2peAQiqfCori5VbI5s44D2QIswxq8dLOYKAx7GwGHfNxaH/0jsyEeVzG3OLaeaTIZbRTCatVtTJ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMZU4K3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06438C4AF63;
	Tue,  7 May 2024 13:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715087995;
	bh=SLNZxKQweYv3yP5iFQGwSZpSSxqoUn6F/nU0+QfT/tc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nMZU4K3xeBwKduF0f4WUNc0+hzkmp+jLa30EJuMdzFfdwWKPdI6oBbB4SIf3juFjg
	 LGVJsRrmaYQP8SZmkfukcO+w+z8euYmPB02gmNQSqUXYLei42TvLV0ZC9wgvxrcY30
	 RnDZoGL5tGi3EQDh4Zi6G5JJ7FjYHa22nsoqFWOmOvj7FrsFWWoq2i4hWU9B2FxhtV
	 mnSkyq7pM6kS0f7Rpkbim3cedUpJcYw7HhCuKORmcKs5Zk7Nl0+EhFwWcsNthlTOko
	 JMTPFfJuI9uMGmllbe0gIpFPVURqhBzYMNEL5FibQ0f2MoDDE5dydV+AqBgFJooYvV
	 e/FE/tHfzCaCQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 07 May 2024 15:19:31 +0200
Subject: [PATCH RFC bpf-next 3/8] bpf: implement __async and __s_async
 kfunc suffixes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-bpf_async-v1-3-b4df966096d8@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715087980; l=11562;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=SLNZxKQweYv3yP5iFQGwSZpSSxqoUn6F/nU0+QfT/tc=;
 b=Wtmr6N4TDq2xf7r2wVjNOUPp5VYD2+9PVDqYdsfsCvJajcYup4BDU8c4qjtIt2RRn1h8TfJhv
 SgMRKdvX17ZAFFT6OWmX1IYV6BzBxl0pJG3ESr5TAWryj2h0hNr20IL
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

still mostly a WIP, but it seems to be working for the couple of tests.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

This is an RFC, and is not meant to be fully reviewed/applied as it is.
I'm posting this to show what I wanted to explain in
https://lore.kernel.org/bpf/mhkzkf4e23uvljtmwizwcxyuyat2tmfxn33xb4t7waafgmsa66@mcrzpj3b6ssx/
---
 kernel/bpf/verifier.c | 223 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 206 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2b1e24c440c5..cc4dab81b306 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -336,6 +336,16 @@ struct bpf_kfunc_call_arg_meta {
 		struct bpf_map *ptr;
 		int uid;
 	} map;
+	struct {
+		bool enabled;
+		bool sleepable;
+		u32 nr_args;
+		struct {
+			// FIXME: should be enum kfunc_ptr_arg_type type;
+			int type;
+			u32 btf_id;
+		} args[5];
+	} async_cb;
 	u64 mem_size;
 };
 
@@ -9538,7 +9548,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 */
 	env->subprog_info[subprog].is_cb = true;
 	if (bpf_pseudo_kfunc_call(insn) &&
-	    !is_callback_calling_kfunc(insn->imm)) {
+	    !is_callback_calling_kfunc(insn->imm) &&
+	    !(kfunc_meta && kfunc_meta->async_cb.enabled)) {
 		verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
 			func_id_name(insn->imm), insn->imm);
 		return -EFAULT;
@@ -9549,14 +9560,15 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		return -EFAULT;
 	}
 
-	if (is_async_callback_calling_insn(insn)) {
+	if (is_async_callback_calling_insn(insn) || (kfunc_meta && kfunc_meta->async_cb.enabled)) {
 		struct bpf_verifier_state *async_cb;
 
 		/* there is no real recursion here. timer and workqueue callbacks are async */
 		env->subprog_info[subprog].is_async_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
 					 insn_idx, subprog,
-					 is_bpf_wq_set_callback_impl_kfunc(insn->imm));
+					 (is_bpf_wq_set_callback_impl_kfunc(insn->imm) ||
+					  (kfunc_meta && kfunc_meta->async_cb.sleepable)));
 		if (!async_cb)
 			return -EFAULT;
 		callee = async_cb->frame[0];
@@ -10890,6 +10902,16 @@ static bool is_kfunc_arg_const_str(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__str");
 }
 
+static bool is_kfunc_arg_async_cb(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__async");
+}
+
+static bool is_kfunc_arg_sleepable_async_cb(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__s_async");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -11045,6 +11067,48 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_WORKQUEUE,
 };
 
+static const char *__kfunc_ptr_arg_type_str(enum kfunc_ptr_arg_type value)
+{
+	switch (value) {
+	case KF_ARG_PTR_TO_CTX:
+		return "KF_ARG_PTR_TO_CTX";
+	case KF_ARG_PTR_TO_ALLOC_BTF_ID:
+		return "KF_ARG_PTR_TO_ALLOC_BTF_ID";
+	case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
+		return "KF_ARG_PTR_TO_REFCOUNTED_KPTR";
+	case KF_ARG_PTR_TO_DYNPTR:
+		return "KF_ARG_PTR_TO_DYNPTR";
+	case KF_ARG_PTR_TO_ITER:
+		return "KF_ARG_PTR_TO_ITER";
+	case KF_ARG_PTR_TO_LIST_HEAD:
+		return "KF_ARG_PTR_TO_LIST_HEAD";
+	case KF_ARG_PTR_TO_LIST_NODE:
+		return "KF_ARG_PTR_TO_LIST_NODE";
+	case KF_ARG_PTR_TO_BTF_ID:
+		return "KF_ARG_PTR_TO_BTF_ID";
+	case KF_ARG_PTR_TO_MEM:
+		return "KF_ARG_PTR_TO_MEM";
+	case KF_ARG_PTR_TO_MEM_SIZE:
+		return "KF_ARG_PTR_TO_MEM_SIZE";
+	case KF_ARG_PTR_TO_CALLBACK:
+		return "KF_ARG_PTR_TO_CALLBACK";
+	case KF_ARG_PTR_TO_RB_ROOT:
+		return "KF_ARG_PTR_TO_RB_ROOT";
+	case KF_ARG_PTR_TO_RB_NODE:
+		return "KF_ARG_PTR_TO_RB_NODE";
+	case KF_ARG_PTR_TO_NULL:
+		return "KF_ARG_PTR_TO_NULL";
+	case KF_ARG_PTR_TO_CONST_STR:
+		return "KF_ARG_PTR_TO_CONST_STR";
+	case KF_ARG_PTR_TO_MAP:
+		return "KF_ARG_PTR_TO_MAP";
+	case KF_ARG_PTR_TO_WORKQUEUE:
+		return "KF_ARG_PTR_TO_WORKQUEUE";
+	}
+
+	return "UNKNOWN";
+}
+
 enum special_kfunc_type {
 	KF_bpf_obj_new_impl,
 	KF_bpf_obj_drop_impl,
@@ -12151,6 +12215,39 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return -EINVAL;
 			}
 			meta->subprogno = reg->subprogno;
+			meta->async_cb.sleepable = is_kfunc_arg_sleepable_async_cb(meta->btf, &args[i]);
+			meta->async_cb.enabled = meta->async_cb.sleepable ||
+						 is_kfunc_arg_async_cb(meta->btf, &args[i]);
+			if (meta->async_cb.enabled) {
+				const struct btf_type *cb_proto;
+				const struct btf_param *cb_args;
+				u32 cb_type = args[i].type;
+				int i;
+
+				cb_proto = btf_type_resolve_func_ptr(btf, cb_type, NULL);
+				if (cb_proto) {
+					meta->async_cb.nr_args = btf_type_vlen(cb_proto);
+					cb_args = btf_params(cb_proto);
+					for (i = 0; i < meta->async_cb.nr_args; i++) {
+						const struct btf_type *t, *ref_t;
+						const char *ref_tname;
+						u32 ref_id, t_id;
+
+						t = btf_type_skip_modifiers(btf, cb_args[i].type, &t_id);
+						ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
+						ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+						meta->async_cb.args[i].type = get_kfunc_ptr_arg_type(env, meta,
+							t, ref_t, ref_tname, cb_args, i, meta->async_cb.nr_args);
+
+						/* FIXME: we should not get an error from get_kfunc_ptr_arg_type() */
+						if (meta->async_cb.args[i].type < 0)
+							meta->async_cb.args[i].type = KF_ARG_PTR_TO_BTF_ID;
+						meta->async_cb.args[i].btf_id = ref_id;
+					}
+				} else {
+					meta->async_cb.nr_args = 0;
+				}
+			}
 			break;
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 			if (!type_is_ptr_alloc_obj(reg->type)) {
@@ -12248,6 +12345,71 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 
 static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name);
 
+static int set_generic_callback_state(struct bpf_verifier_env *env,
+				      struct bpf_func_state *caller,
+				      struct bpf_func_state *callee,
+				      int insn_idx,
+				      struct bpf_kfunc_call_arg_meta *meta)
+{
+	int i;
+
+	for (i = 0; i < 5; i++) {
+		if (i < meta->async_cb.nr_args) {
+			u32 type = meta->async_cb.args[i].type;
+
+			switch (type) {
+			case KF_ARG_PTR_TO_CTX:
+			case KF_ARG_PTR_TO_ALLOC_BTF_ID:
+			case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
+			case KF_ARG_PTR_TO_DYNPTR:
+			case KF_ARG_PTR_TO_ITER:
+			case KF_ARG_PTR_TO_LIST_HEAD:
+			case KF_ARG_PTR_TO_LIST_NODE:
+			case KF_ARG_PTR_TO_CALLBACK:
+			case KF_ARG_PTR_TO_RB_ROOT:
+			case KF_ARG_PTR_TO_RB_NODE:
+			case KF_ARG_PTR_TO_NULL:
+			case KF_ARG_PTR_TO_CONST_STR:
+				verbose(env, "argument #%d of type %s is not supported in async callbacks\n",
+					i, __kfunc_ptr_arg_type_str(meta->async_cb.args[i].type));
+				return -EINVAL;
+			case KF_ARG_PTR_TO_MEM:
+			case KF_ARG_PTR_TO_MEM_SIZE:
+				callee->regs[BPF_REG_1 + i].type = PTR_TO_MEM;
+				__mark_reg_known_zero(&callee->regs[BPF_REG_1 + i]);
+				callee->regs[BPF_REG_1 + i].mem_size = 8; // FIXME: should store the size while walking the arguments
+				break;
+			case KF_ARG_PTR_TO_MAP:
+				callee->regs[BPF_REG_1 + i].type = CONST_PTR_TO_MAP;
+				__mark_reg_known_zero(&callee->regs[BPF_REG_1 + i]);
+				callee->regs[BPF_REG_1 + i].map_ptr = meta->map.ptr;
+				break;
+			case KF_ARG_PTR_TO_WORKQUEUE:
+				callee->regs[BPF_REG_1 + i].type = PTR_TO_MAP_VALUE;
+				__mark_reg_known_zero(&callee->regs[BPF_REG_1 + i]);
+				callee->regs[BPF_REG_1 + i].map_ptr = meta->map.ptr;
+				break;
+			case KF_ARG_PTR_TO_BTF_ID:
+				callee->regs[BPF_REG_1 + i].type = PTR_TO_BTF_ID;
+				__mark_reg_known_zero(&callee->regs[BPF_REG_1 + i]);
+				callee->regs[BPF_REG_1 + i].btf =  meta->btf;
+				callee->regs[BPF_REG_1 + i].btf_id = meta->async_cb.args[i].btf_id;
+				break;
+			default:
+				verbose(env, "verifier bug: unexpected arg#%d type (%d) in async callback\n",
+					i, type);
+				return -EFAULT;
+			}
+		} else {
+			__mark_reg_not_init(env, &callee->regs[BPF_REG_1 + i]);
+		}
+	}
+	callee->in_callback_fn = true;
+	// callee->callback_ret_range = retval_range(-MAX_ERRNO, );
+	return 0;
+}
+
+
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
@@ -12313,6 +12475,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (meta.async_cb.enabled) {
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_generic_callback_state, &meta);
+		if (err) {
+			verbose(env, "kfunc %s#%d failed callback verification\n",
+				func_name, meta.func_id);
+			return err;
+		}
+	}
+
 	rcu_lock = is_kfunc_bpf_rcu_read_lock(&meta);
 	rcu_unlock = is_kfunc_bpf_rcu_read_unlock(&meta);
 
@@ -15918,22 +16090,39 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		}
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_kfunc_call_arg_meta meta;
+			const struct btf_param *args;
+			u32 i, nargs;
 
 			ret = fetch_kfunc_meta(env, insn, &meta, NULL);
-			if (ret == 0 && is_iter_next_kfunc(&meta)) {
-				mark_prune_point(env, t);
-				/* Checking and saving state checkpoints at iter_next() call
-				 * is crucial for fast convergence of open-coded iterator loop
-				 * logic, so we need to force it. If we don't do that,
-				 * is_state_visited() might skip saving a checkpoint, causing
-				 * unnecessarily long sequence of not checkpointed
-				 * instructions and jumps, leading to exhaustion of jump
-				 * history buffer, and potentially other undesired outcomes.
-				 * It is expected that with correct open-coded iterators
-				 * convergence will happen quickly, so we don't run a risk of
-				 * exhausting memory.
-				 */
-				mark_force_checkpoint(env, t);
+			if (ret == 0) {
+				args = (const struct btf_param *)(meta.func_proto + 1);
+				nargs = btf_type_vlen(meta.func_proto);
+
+				for (i = 0; i < nargs; i++) {
+					if (is_kfunc_arg_sleepable_async_cb(meta.btf, &args[i]) ||
+					    is_kfunc_arg_async_cb(meta.btf, &args[i]))
+						/* Mark this call insn as a prune point to trigger
+						 * is_state_visited() check before call itself is
+						 * processed by __check_func_call(). Otherwise new
+						 * async state will be pushed for further exploration.
+						 */
+						mark_prune_point(env, t);
+				}
+				if (is_iter_next_kfunc(&meta)) {
+					mark_prune_point(env, t);
+					/* Checking and saving state checkpoints at iter_next() call
+					 * is crucial for fast convergence of open-coded iterator loop
+					 * logic, so we need to force it. If we don't do that,
+					 * is_state_visited() might skip saving a checkpoint, causing
+					 * unnecessarily long sequence of not checkpointed
+					 * instructions and jumps, leading to exhaustion of jump
+					 * history buffer, and potentially other undesired outcomes.
+					 * It is expected that with correct open-coded iterators
+					 * convergence will happen quickly, so we don't run a risk of
+					 * exhausting memory.
+					 */
+					mark_force_checkpoint(env, t);
+				}
 			}
 		}
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);

-- 
2.44.0


