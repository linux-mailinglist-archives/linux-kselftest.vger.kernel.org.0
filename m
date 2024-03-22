Return-Path: <linux-kselftest+bounces-6497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3011D886F32
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 15:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29291F21787
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 14:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF6554FB7;
	Fri, 22 Mar 2024 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFpwMVAe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A03154BD3;
	Fri, 22 Mar 2024 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119412; cv=none; b=el1icNNJV9kGnR3tG18eYI3zpKSBrT4ThoKg9/mj9szpby9bswUqrEsBm3rTP7VSRih20anVVzGLk+gidjMSMArCppzr2L7byZYOcZb+v0KtM+4ldZdWmyUbefLGamWKjCPdOi0GmuZqNLxJnYuszUKERljVorJAAiF5UiO1YCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119412; c=relaxed/simple;
	bh=EMT8wfuCy0Cp4lpZJqhJjr7yWdRMYe8cHkGyjxIkFXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j9hIdgILXXZ2QrdR3bxC4HFWk8kWnBXgnUjz/TRoDfUDAxCQ1oNab9gFsk58WaziTXmVWRJayms9l8/OYjL8aHSbS3jRwKObL8ka0RdGY6gA3OEnfzEGVJGgFsND70hv6gbcxSr2BqJrSbkhPXJb6NnPzRMOcFfL8ifZIWDWNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFpwMVAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF48C43390;
	Fri, 22 Mar 2024 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711119412;
	bh=EMT8wfuCy0Cp4lpZJqhJjr7yWdRMYe8cHkGyjxIkFXk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YFpwMVAew3WlNd6H2QjWYmmR8gst1Bz8D8Jrqo5gJPb1WjXbrz1QuUXpkSfR0iqrC
	 sFiXM1qdlOnPBeYZyxOsKSv71bACWOKjo5MIGAuwfQjHo7eRVA95ee3Gd5TT9t1wu+
	 KRZgj2piC9sQPirRXTjn76oq/4DWLcVcaFfQtMTXQw2dIr7JAUbktzCyFGSnaIv9OQ
	 Fc8rjuNV1ccK5233yJWi7Xg14HGKizGFc4q/DeXfxmaYY+uxGYKE+e1RfJwZTNi6NN
	 055tFwWJRMY6kP3wiIM5BP8OzBqXj/KxsIFSZNDGf/eoYMdWmUxay06Jl75w9puTHi
	 hCAYNfj30xkTA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 22 Mar 2024 15:56:24 +0100
Subject: [PATCH bpf-next v5 4/6] bpf/helpers: mark the callback of
 bpf_timer_set_sleepable_cb() as sleepable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-hid-bpf-sleepable-v5-4-179c7b59eaaa@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711119393; l=3405;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=EMT8wfuCy0Cp4lpZJqhJjr7yWdRMYe8cHkGyjxIkFXk=;
 b=Q+pAww1hd7Mzs/I8jhGQbY1HTSjHxg0Qq6hqZdKtxhVaoDBziuR8DmlJ3GXIcGbCtfye7Y9Ng
 tkhNdr9YjY7D5RZsWowHfEAE+kOsbgtjQGg1qT7UmWbj2ZtO8QZoqS1
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Now that we have bpf_timer_set_sleepable_cb() available and working, we
can tag the attached callback as sleepable, and let the verifier check
in the correct context the calls and kfuncs.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

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
index 458765d881f3..39a16184c0d8 100644
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
@@ -16941,6 +16945,9 @@ static bool states_equal(struct bpf_verifier_env *env,
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


