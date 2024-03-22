Return-Path: <linux-kselftest+bounces-6496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF44886F2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 15:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3513EB223AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7ED4CDF9;
	Fri, 22 Mar 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfP5bzK0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53699535B5;
	Fri, 22 Mar 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119408; cv=none; b=TTgAJf44T1YywF3+dtNtPisNXnmz5b88zvweZ0s8TAIdGB4y7ZKp/xDc3c8xv6vtM2XZYExtH9pnc4d0dYuOp2fzREa/EhQi1ap7+mUoOFSnrQfe+rCYd/kx0u7jv2//zGv/OvFdhIGAhgJaj+FmMj2txpC7rEKZUuHPHf1bQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119408; c=relaxed/simple;
	bh=WMmjnsruGZSS4LvSc6qTVwlc6CTlpvFbgWqlddzZdJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QP/zt1XB9jHEXCTSHJKBxiRf9SxMPAUYEiP8VbVZTum3671SN9gF0MLb7UJSFWR6sej1AtuthTDNIjbzWcjoVVs8Rx9583hMCE03jIeQoWYwKOF/nwSWqIK04/apCZzPeYrlBo11ewNf03N9LaxYeQsaIrBmHtuGhiphCxHwZ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfP5bzK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45BEC43399;
	Fri, 22 Mar 2024 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711119408;
	bh=WMmjnsruGZSS4LvSc6qTVwlc6CTlpvFbgWqlddzZdJA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GfP5bzK000xnI6eYejktN/ycC0pTGVfTxUeATYdtc1rgJYssrvHp8PTU3elVl3M5I
	 CaO3LZvL5TFk2QTOLJXMzAWGvpvDTGo13cv32k9xazlLBKkZLA2cvRlsc3vqcpRr2k
	 hMNS7CrSp7cd2vo9Zjx/qX+Hxfu3OUqFnzkWmaxyvqWowPNK8+fYmGzMK4KBk+vNMO
	 1A+fLD2pp26dUsBGyDqivEF7We1wXVPB3CkOZIrGi8S0hdZ9DGQfR6NM5dK25DRqmj
	 kfyS/1zw1RFdgjaiW2Lcyf+R8dv5yUfjfeP+8WZTq2KFuG2gufy0gGlQSR/uZ92idv
	 CjN3zFJYqAwrw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 22 Mar 2024 15:56:23 +0100
Subject: [PATCH bpf-next v5 3/6] bpf/helpers: introduce
 bpf_timer_set_sleepable_cb() kfunc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-hid-bpf-sleepable-v5-3-179c7b59eaaa@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711119393; l=9509;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=WMmjnsruGZSS4LvSc6qTVwlc6CTlpvFbgWqlddzZdJA=;
 b=C5vAcWvb2RKoMDK9Qdq5EUqyVljQ8cWzFVa3QlxC3X/e4XPb2osQZ16HFUtwdSImz2e1FC3qY
 mtJ9Uv5SXfKANpv+p6VNuKkFALWdBl8yUNbJS9gXJ5PPFYW2iZ1/7cH
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

changes in v5:
- enforced sleepable timers to only have BPF_F_TIMER_SLEEPABLE
- use is_bpf_timer_set_sleepable_cb_impl_kfunc() instead of generic
  is_async_cb()

changes in v4:
- added a new (ignored) argument to the kfunc so that we do not
  need to wlak the stack

new in v3 (split from v2 02/10)
---
 kernel/bpf/helpers.c  | 46 +++++++++++++++++++++++++++++++++++++--
 kernel/bpf/verifier.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 38de73a9df83..04f5a9b2c723 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1108,6 +1108,7 @@ struct bpf_hrtimer {
 	void *value;
 	struct rcu_head rcu;
 	spinlock_t sleepable_lock;
+	bool is_sleepable;
 };
 
 /* the actual struct hidden inside uapi struct bpf_timer */
@@ -1273,8 +1274,8 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callback_fn,
-	   struct bpf_prog_aux *, aux)
+static int __bpf_timer_set_callback(struct bpf_timer_kern *timer, void *callback_fn,
+				    struct bpf_prog_aux *aux, bool is_sleepable)
 {
 	struct bpf_prog *prev, *prog = aux->prog;
 	struct bpf_hrtimer *t;
@@ -1314,6 +1315,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
 		t->prog = prog;
 	}
 	rcu_assign_pointer(t->callback_fn, callback_fn);
+	t->is_sleepable = is_sleepable;
 out:
 	if (t)
 		spin_unlock(&t->sleepable_lock);
@@ -1321,6 +1323,12 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
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
@@ -1350,6 +1358,11 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
 		goto out;
 	}
 
+	if (t->is_sleepable && flags != BPF_F_TIMER_SLEEPABLE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (flags & BPF_F_TIMER_ABS)
 		mode = HRTIMER_MODE_ABS_SOFT;
 	else
@@ -2627,6 +2640,34 @@ __bpf_kfunc void bpf_throw(u64 cookie)
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
@@ -2703,6 +2744,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
+BTF_ID_FLAGS(func, bpf_timer_set_sleepable_cb_impl)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 24a604e26ec7..458765d881f3 100644
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
@@ -9471,7 +9476,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 */
 	env->subprog_info[subprog].is_cb = true;
 	if (bpf_pseudo_kfunc_call(insn) &&
-	    !is_sync_callback_calling_kfunc(insn->imm)) {
+	    !is_callback_calling_kfunc(insn->imm)) {
 		verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
 			func_id_name(insn->imm), insn->imm);
 		return -EFAULT;
@@ -10981,6 +10986,7 @@ enum special_kfunc_type {
 	KF_bpf_percpu_obj_drop_impl,
 	KF_bpf_throw,
 	KF_bpf_iter_css_task_new,
+	KF_bpf_timer_set_sleepable_cb_impl,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11007,6 +11013,7 @@ BTF_ID(func, bpf_throw)
 #ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
 #endif
+BTF_ID(func, bpf_timer_set_sleepable_cb_impl)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -11037,6 +11044,7 @@ BTF_ID(func, bpf_iter_css_task_new)
 #else
 BTF_ID_UNUSED
 #endif
+BTF_ID(func, bpf_timer_set_sleepable_cb_impl)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -11365,12 +11373,28 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id)
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
@@ -12155,6 +12179,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
 
@@ -19548,6 +19582,28 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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


