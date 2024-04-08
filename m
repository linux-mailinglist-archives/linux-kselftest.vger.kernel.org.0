Return-Path: <linux-kselftest+bounces-7379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B628E89B9CB
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 10:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0152825B7
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 08:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D49B3FBBE;
	Mon,  8 Apr 2024 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Trto9DYG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B622E400;
	Mon,  8 Apr 2024 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563803; cv=none; b=o4Dcp7Y1Kqau+zrPog1BFm1N6oC04IKHqGGmgOue8QUW+1EqxsJc8EyiXPDB+JHiwP2RVtDdeuiqxRq2CO79K28AQRs9/LKuBsqakcp89Otin9piDy20H5u5d8hEuGYU2q/y6yYNL8OrGbt0ZFeFV5ustFbnolSWDs7hthlVPtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563803; c=relaxed/simple;
	bh=pO/fOe12LlMwxLdSxFu7PL1Eaf6knBl1c2DD4TVRdco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMyeFoCVAQ2Qu1QovoPjN9Ev/7m+p5opWfr/yxzJdPXHTIyPatyIn5TE5JmZPIUfaM4hwcz/UeYjrUi9jC5xMHAjgcveWTTG5lQmwaFgfsDfJHPaMSjtdagFmyd0CnM4y6xqHye8Q+1ZZZ/JE1JE+OcyYVkD5BO/2jUDcu2IGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Trto9DYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625DCC433A6;
	Mon,  8 Apr 2024 08:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712563802;
	bh=pO/fOe12LlMwxLdSxFu7PL1Eaf6knBl1c2DD4TVRdco=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Trto9DYGhWXG/JLpCFHG6TGltcB581TEuGaOYPozPaJCgLyAlPkG2OLzTW2vw0Pbt
	 oBKv13C1sb1m8iWJTZ/Blhzcm3db+4R1lbKA77mmFtAb+QkoPPbFnWFGlyTvap2gVS
	 Z4JmGFsVLVL7Xio3G+91EvnSEzIcYQYrOh4u3Ha/Yr6gCsutRE/p0kI5NukP5zCS0s
	 eEjRNBoqBgKCPboe2d1ckrIkIPNFqr41iJR9HORUTvd7xKlcBhF1GN2GienMgDy2tR
	 fCcYL/3z9wfFahnQU8S/oudKn9twbtMfH7HNZPAJyIWmNDt+zMAS1/GK7P414PXIkT
	 94cT+xWC/Gxpg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 08 Apr 2024 10:09:28 +0200
Subject: [PATCH RFC bpf-next v6 3/6] bpf/helpers: introduce
 bpf_timer_set_sleepable_cb() kfunc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-hid-bpf-sleepable-v6-3-0499ddd91b94@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712563787; l=9197;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=pO/fOe12LlMwxLdSxFu7PL1Eaf6knBl1c2DD4TVRdco=;
 b=IXPAZPz6EQvhVIknWcnLDykM+Cc6wqGHJ6/L1lG2uPZeG23G0tNmwC/AGXyqTiOcFSwug7SQY
 vMFkj+BmaGFBh+yhGLM/VMALme0OsxII3/d7/2CYoVTKph2yP0jE22M
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

In this patch, bpf_timer_set_sleepable_cb() is functionally equivalent
to bpf_timer_set_callback(), to the exception that it enforces
the timer to be started with BPF_F_TIMER_SLEEPABLE.

But given that bpf_timer_set_callback() is a helper when
bpf_timer_set_sleepable_cb() is a kfunc, we need to teach the verifier
about its attached callback.
Marking that callback as sleepable will be done in a separate patch

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v6:
- adapted for flags being set during timer_init

changes in v5:
- enforced sleepable timers to only have BPF_F_TIMER_SLEEPABLE
- use is_bpf_timer_set_sleepable_cb_impl_kfunc() instead of generic
  is_async_cb()

changes in v4:
- added a new (ignored) argument to the kfunc so that we do not
  need to wlak the stack

new in v3 (split from v2 02/10)
---
 kernel/bpf/helpers.c  | 43 ++++++++++++++++++++++++++++++++++--
 kernel/bpf/verifier.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index fd05d4358b31..d6528359b3f4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1291,8 +1291,8 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callback_fn,
-	   struct bpf_prog_aux *, aux)
+static int __bpf_timer_set_callback(struct bpf_timer_kern *timer, void *callback_fn,
+				    struct bpf_prog_aux *aux, bool is_sleepable)
 {
 	struct bpf_prog *prev, *prog = aux->prog;
 	struct bpf_hrtimer *t;
@@ -1306,6 +1306,10 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
 		ret = -EINVAL;
 		goto out;
 	}
+	if (!!(t->flags & BPF_F_TIMER_SLEEPABLE) != is_sleepable) {
+		ret = -EINVAL;
+		goto out;
+	}
 	if (!atomic64_read(&t->map->usercnt)) {
 		/* maps with timers must be either held by user space
 		 * or pinned in bpffs. Otherwise timer might still be
@@ -1336,6 +1340,12 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
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
@@ -2650,6 +2660,34 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
 
+/**
+ * bpf_timer_set_sleepable_cb_impl() - Configure the timer to call %callback_fn
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
+__bpf_kfunc int bpf_timer_set_sleepable_cb_impl(struct bpf_timer_kern *timer,
+						int (callback_fn)(void *map, int *key, struct bpf_timer *timer),
+						void *aux__ign)
+{
+	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)aux__ign;
+
+	if (!aux)
+		return -EINVAL;
+
+	return __bpf_timer_set_callback(timer, (void *)callback_fn, aux, true);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -2726,6 +2764,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
+BTF_ID_FLAGS(func, bpf_timer_set_sleepable_cb_impl)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ccfe9057d8dc..00ac3a3a5f01 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -501,8 +501,12 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
 }
 
 static bool is_sync_callback_calling_kfunc(u32 btf_id);
+static bool is_async_callback_calling_kfunc(u32 btf_id);
+static bool is_callback_calling_kfunc(u32 btf_id);
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
 
+static bool is_bpf_timer_set_sleepable_cb_impl_kfunc(u32 btf_id);
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
@@ -9475,7 +9480,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 */
 	env->subprog_info[subprog].is_cb = true;
 	if (bpf_pseudo_kfunc_call(insn) &&
-	    !is_sync_callback_calling_kfunc(insn->imm)) {
+	    !is_callback_calling_kfunc(insn->imm)) {
 		verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
 			func_id_name(insn->imm), insn->imm);
 		return -EFAULT;
@@ -10984,6 +10989,7 @@ enum special_kfunc_type {
 	KF_bpf_percpu_obj_drop_impl,
 	KF_bpf_throw,
 	KF_bpf_iter_css_task_new,
+	KF_bpf_timer_set_sleepable_cb_impl,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11010,6 +11016,7 @@ BTF_ID(func, bpf_throw)
 #ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
 #endif
+BTF_ID(func, bpf_timer_set_sleepable_cb_impl)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -11040,6 +11047,7 @@ BTF_ID(func, bpf_iter_css_task_new)
 #else
 BTF_ID_UNUSED
 #endif
+BTF_ID(func, bpf_timer_set_sleepable_cb_impl)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -11368,12 +11376,28 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id)
 	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
 }
 
+static bool is_async_callback_calling_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_timer_set_sleepable_cb_impl];
+}
+
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
 {
 	return bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
 	       insn->imm == special_kfunc_list[KF_bpf_throw];
 }
 
+static bool is_bpf_timer_set_sleepable_cb_impl_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_timer_set_sleepable_cb_impl];
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
@@ -12157,6 +12181,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (is_bpf_timer_set_sleepable_cb_impl_kfunc(meta.func_id)) {
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
 
@@ -19559,6 +19593,28 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (is_bpf_timer_set_sleepable_cb_impl_kfunc(desc->func_id)) {
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
+			BPF_LD_IMM64(BPF_REG_3, (long)env->prog->aux),
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


