Return-Path: <linux-kselftest+bounces-7380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465C489B9CE
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 10:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BE42826F3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 08:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56EE44C93;
	Mon,  8 Apr 2024 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCjsAwN5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B779644C71;
	Mon,  8 Apr 2024 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563806; cv=none; b=j/bn6K2b1hpOrnifKkysof6lV3sep8ASb1TGs+aKFdDHcomPV/kFr9jHjJwQJVnjBj+jEW6AI2dFOkbHCRIdOkf4cExwKI5T5qLwr6JDKZOGaJrPHgVKyIdNNU7uG7pb5MVyDigSM1HGxc4T9Umr2/eHMEepnwY/q6UlqNPJ+0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563806; c=relaxed/simple;
	bh=F6xXyYbfZDX1T1rGuNQBL+pHxwN2Kf/niVJyhWfdoQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m6I7j8P5Jp1rcWqu9F0X5w5qOgHA5z53hEIhuFGcK/YRnruYQerqpixDOS2VW5ydncRgmYssR7JX3IPD/RpZZAAohUS1sENfmPFkbIB9/5VSuSlQo5T7i37yViakpkeImFZmZ4GmdRPN2Hfz2PDh3wROfiG7Z6Im4IDHHXxcnHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCjsAwN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364F8C433C7;
	Mon,  8 Apr 2024 08:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712563806;
	bh=F6xXyYbfZDX1T1rGuNQBL+pHxwN2Kf/niVJyhWfdoQU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aCjsAwN5fiGJQ66awNc9vEq9aXNcRHSp8sO5tM2TRsvsyLVwhsxAT9N82VNcy02Ja
	 VgY17UNED+3hgLMj7M8i1qCK96KuA6dW3ryz9ssOi6JqKTIogKtmTAMtn6B/KxZA7e
	 ucE2eVewBtuYhigcL949wiHKgPYcCNISbOeYklyvOUWYUpVptj3BGpmzmG64w4SYaU
	 WbAFO4DmMWEuDi5NVFNz8qrQq9sSrLifLJKFkfRXoZlrwo9KuVN5D1BGeM9XGsqzM8
	 K2J+70xJ8NdEPvw4wO1oCp99glFytyDsFTIyywmqP2cl3qr1w3CohaELUPEgSmfEtc
	 bOeLFvepiJ6GA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 08 Apr 2024 10:09:29 +0200
Subject: [PATCH RFC bpf-next v6 4/6] bpf/helpers: mark the callback of
 bpf_timer_set_sleepable_cb() as sleepable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-hid-bpf-sleepable-v6-4-0499ddd91b94@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712563787; l=3425;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=F6xXyYbfZDX1T1rGuNQBL+pHxwN2Kf/niVJyhWfdoQU=;
 b=r5nlEnLIcuh7ege37WQb6PvbynSZjHTTOu1bMBt4RMC5kwYK0dCnCNKZF/rGk7SLnVvuz4gTH
 FlWCkTvU3IXA/m+YrkTpbYYyIJVmVn3Dw/np1qSvmAHxM7Hjdx/v1re
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Now that we have bpf_timer_set_sleepable_cb() available and working, we
can tag the attached callback as sleepable, and let the verifier check
in the correct context the calls and kfuncs.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v6

no changes in v5

changes in v4:
- use a function parameter to forward the sleepable information

new in v3 (split from v2 02/10)
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7cb1b75eee38..14e4ee67b694 100644
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
index 00ac3a3a5f01..b75a8aca6ec9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1434,6 +1434,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	}
 	dst_state->speculative = src->speculative;
 	dst_state->active_rcu_lock = src->active_rcu_lock;
+	dst_state->in_sleepable = src->in_sleepable;
 	dst_state->curframe = src->curframe;
 	dst_state->active_lock.ptr = src->active_lock.ptr;
 	dst_state->active_lock.id = src->active_lock.id;
@@ -2407,7 +2408,7 @@ static void init_func_state(struct bpf_verifier_env *env,
 /* Similar to push_stack(), but for async callbacks */
 static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 						int insn_idx, int prev_insn_idx,
-						int subprog)
+						int subprog, bool is_sleepable)
 {
 	struct bpf_verifier_stack_elem *elem;
 	struct bpf_func_state *frame;
@@ -2434,6 +2435,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	 * Initialize it similar to do_check_common().
 	 */
 	elem->st.branches = 1;
+	elem->st.in_sleepable = is_sleepable;
 	frame = kzalloc(sizeof(*frame), GFP_KERNEL);
 	if (!frame)
 		goto err;
@@ -5279,7 +5281,8 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 
 static bool in_sleepable(struct bpf_verifier_env *env)
 {
-	return env->prog->sleepable;
+	return env->prog->sleepable ||
+	       (env->cur_state && env->cur_state->in_sleepable);
 }
 
 /* The non-sleepable programs and sleepable programs with explicit bpf_rcu_read_lock()
@@ -9497,7 +9500,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		/* there is no real recursion here. timer callbacks are async */
 		env->subprog_info[subprog].is_async_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
-					 insn_idx, subprog);
+					 insn_idx, subprog,
+					 is_bpf_timer_set_sleepable_cb_impl_kfunc(insn->imm));
 		if (!async_cb)
 			return -EFAULT;
 		callee = async_cb->frame[0];
@@ -16947,6 +16951,9 @@ static bool states_equal(struct bpf_verifier_env *env,
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


