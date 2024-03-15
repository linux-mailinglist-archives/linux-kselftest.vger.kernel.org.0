Return-Path: <linux-kselftest+bounces-6350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DA787CEE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 15:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CE7283F87
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 14:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1D23D571;
	Fri, 15 Mar 2024 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+M/Lpr6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025303D568;
	Fri, 15 Mar 2024 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512994; cv=none; b=hSWQanHIWipcM0z1W0VpZWNgMA77tx8cf8eD2Z1bEb1HwS3A+UhNO10lBXZnmTV91WQZbkFEyoBSUk6RtLRqrV0son/gpKLBxcnIQoVYeCOZ6z/XwqeUbxTflVfM+F0TqRclY19NYQlw1aahgT7JujTo4rQ3tA2v+tRAijzgxW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512994; c=relaxed/simple;
	bh=It8QhO/TJYMs3p45CGdPHhS/LCw5f+FRkEolyZh0LiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tLb3hpATTPplGhyCTd5F3lokGHx3Fefbm0VNaKbjh5GezH6y6tAeMyGOQ7QL4pFti4zVn6wUik5LyFTRJUXLHKhpS05e3O5MYhYI/jNtS73LLbubasC0LWkasVtMu7lk42Bs0hSLmHLUyhFidmgYCLCi9CONSBjJWqsvsKpmfPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+M/Lpr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1D7C433C7;
	Fri, 15 Mar 2024 14:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710512993;
	bh=It8QhO/TJYMs3p45CGdPHhS/LCw5f+FRkEolyZh0LiE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C+M/Lpr6aQ0rhBrvS6BEe/OTqXK+nICVH7BYMGl9VlpDPFKnaOXjdEyCz7ISYwqhU
	 G5KoB2sDm5RVJ0ujiM8Kff9YPojuqe4e5vISJXRbAse8kNX1j+ISBFE2pJ+gjfiYw8
	 tNkvcuYYjUsX582i5asTZz1oKZRKJT0r+orejPLdehVfjPvZ/zcdkww5d6TnCRVB2W
	 3qWzC+g/LutOBmb//LIkBkYGVGZcTS8efRs56L1JmAp/sK7BLxdDXpgsKocu7EKryu
	 2auIWNOTy1eMb+ZcZJYEoo5bL5FGdwYbZowH+DNU81QvRJit1YJuNjN6cdxPkKsDEJ
	 H5gIKfa62CS/g==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 15 Mar 2024 15:29:28 +0100
Subject: [PATCH bpf-next v4 4/6] bpf/helpers: mark the callback of
 bpf_timer_set_sleepable_cb() as sleepable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-hid-bpf-sleepable-v4-4-5658f2540564@kernel.org>
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
In-Reply-To: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710512973; l=3385;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=It8QhO/TJYMs3p45CGdPHhS/LCw5f+FRkEolyZh0LiE=;
 b=MNhR/0WSjqOhu+ACtxDboy3ArThXXxuZ4atR5UYxJbcjKCgyV0j9RKaqwO1UL8W5T7v6ZHl7p
 LKR/gSQ1M8FA4QON57mub1MaoC2Ig8GvpVCn2y/y1MLi1VYAWeadVUD
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Now that we have bpf_timer_set_sleepable_cb() available and working, we
can tag the attached callback as sleepable, and let the verifier check
in the correct context the calls and kfuncs.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

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
index 53f85e114a33..0be07da38f8a 100644
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
@@ -9493,7 +9496,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		/* there is no real recursion here. timer callbacks are async */
 		env->subprog_info[subprog].is_async_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
-					 insn_idx, subprog);
+					 insn_idx, subprog,
+					 is_bpf_timer_set_sleepable_cb_impl_kfunc(insn->imm));
 		if (!async_cb)
 			return -EFAULT;
 		callee = async_cb->frame[0];
@@ -16937,6 +16941,9 @@ static bool states_equal(struct bpf_verifier_env *env,
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


