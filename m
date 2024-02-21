Return-Path: <linux-kselftest+bounces-5190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E19A85E329
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3350B28773D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9416D83CCB;
	Wed, 21 Feb 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7oMkj0B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF78286E;
	Wed, 21 Feb 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532755; cv=none; b=bftGGeuByj2BOMsewJJLl6ZCN5R/pOVFBiBISXzBD8GAkfjnLBLsbvXjGkJrsu+i7GqztrZcIWVDE3M1Fn+WkxiWy+bmavR43KcYxpaBggs4PVJT14FaKSc7iOKn9UnvJE0h3ggz9v6vzaeS8fzXsSityd8LMibwga8moAPi+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532755; c=relaxed/simple;
	bh=BfdDE26WfSDQtzFiSKilP3VZNPmAkXOrXBWoKEcfTV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cf0X30+fhQPXXYzDUW6hgDfJ5f22VgK8PDwMarSimnOb73qgaU0UKtpWCitNhMMSz0QwhNs++8iy7Sr7hzFEFu1ChcKmJ4igH+xcRnWGIu0Qis71scgMeAGCWhvUSt5V74l6oyTcbUkx20xcXq4MGkuQYFSeX6AMCbUV6rIrAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7oMkj0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A502C43394;
	Wed, 21 Feb 2024 16:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532755;
	bh=BfdDE26WfSDQtzFiSKilP3VZNPmAkXOrXBWoKEcfTV8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r7oMkj0B7d78kBRvozcUBQAjhj7uiAGqH+NshKHkhZtbzsD8VNfiGohqCy4+CanWK
	 HySRrxjQM9TVw7KJbfxV8HvGO75sZBgYb+hybxq03jRsKOcRXL+Nsb81yspMqo9hsc
	 sWafiP3BhwKUAsRV7cOJ0mcHVN4Vh4KHAZmtIogOW0uzm7pfcXGwHBGZZBi5AVB0z9
	 nZTMg3jIaCczXwIoUMB3ObF8AOWthxBR0b372g4xJPXWd8u7/KjCWB77suf2phisAm
	 DJ4uM+GCuMzOxKQ71+agabp8aMRZnxlUfBzGvVn6RvW4o17uGtsYRv6YDKELbIXdZR
	 onb5ef6mr94oA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 21 Feb 2024 17:25:23 +0100
Subject: [PATCH RFC bpf-next v3 07/16] bpf/helpers: mark the callback of
 bpf_timer_set_sleepable_cb() as sleepable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-hid-bpf-sleepable-v3-7-1fb378ca6301@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708532719; l=3906;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=BfdDE26WfSDQtzFiSKilP3VZNPmAkXOrXBWoKEcfTV8=;
 b=pNiiAx214IycXAS4yumeCfPJPdLGXqFyYpJxw2eFqF8jcawBNeTNAESSwrDtQ0URfqs5N5V9y
 5q+MHYlzNH8C3XH0pOPRP5TKIb+/ou5EOG4+l+bmXU0NQNev6+E+GZD
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Now that we have bpf_timer_set_sleepable_cb() available and working, we
can tag the attached callback as sleepable, and let the verifier check
in the correct context the calls and kfuncs.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v3 (split from v2 02/10)
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 91e583c6feba..4766c43606c4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -505,6 +505,8 @@ static bool is_async_callback_calling_kfunc(u32 btf_id);
 static bool is_callback_calling_kfunc(u32 btf_id);
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
 
+static bool is_bpf_timer_set_sleepable_cb_kfunc(u32 btf_id);
+
 static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
 {
 	return func_id == BPF_FUNC_for_each_map_elem ||
@@ -1422,6 +1424,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	}
 	dst_state->speculative = src->speculative;
 	dst_state->active_rcu_lock = src->active_rcu_lock;
+	dst_state->in_sleepable = src->in_sleepable;
 	dst_state->curframe = src->curframe;
 	dst_state->active_lock.ptr = src->active_lock.ptr;
 	dst_state->active_lock.id = src->active_lock.id;
@@ -2421,6 +2424,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	 * Initialize it similar to do_check_common().
 	 */
 	elem->st.branches = 1;
+	elem->st.in_sleepable = env->subprog_info[subprog].is_sleepable;
 	frame = kzalloc(sizeof(*frame), GFP_KERNEL);
 	if (!frame)
 		goto err;
@@ -5265,7 +5269,8 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 
 static bool in_sleepable(struct bpf_verifier_env *env)
 {
-	return env->prog->aux->sleepable;
+	return env->prog->aux->sleepable ||
+	       (env->cur_state && env->cur_state->in_sleepable);
 }
 
 /* The non-sleepable programs and sleepable programs with explicit bpf_rcu_read_lock()
@@ -9478,6 +9483,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 
 		/* there is no real recursion here. timer callbacks are async */
 		env->subprog_info[subprog].is_async_cb = true;
+		env->subprog_info[subprog].is_sleepable = is_bpf_timer_set_sleepable_cb_kfunc(insn->imm);
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
 					 insn_idx, subprog);
 		if (!async_cb)
@@ -11361,6 +11367,11 @@ static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
 	       insn->imm == special_kfunc_list[KF_bpf_throw];
 }
 
+static bool is_bpf_timer_set_sleepable_cb_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_timer_set_sleepable_cb];
+}
+
 static bool is_callback_calling_kfunc(u32 btf_id)
 {
 	return is_sync_callback_calling_kfunc(btf_id) ||
@@ -16830,6 +16841,9 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->active_rcu_lock != cur->active_rcu_lock)
 		return false;
 
+	if (old->in_sleepable != cur->in_sleepable)
+		return false;
+
 	/* for states to be equal callsites have to be the same
 	 * and all frame states need to be equivalent
 	 */

-- 
2.43.0


