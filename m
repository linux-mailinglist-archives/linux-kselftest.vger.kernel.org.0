Return-Path: <linux-kselftest+bounces-28976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF768A5FE88
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 18:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FAB3A7FE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 17:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2C21E5701;
	Thu, 13 Mar 2025 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="fnZGLrQ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AADB1DB54C;
	Thu, 13 Mar 2025 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888214; cv=none; b=nKSFdVmyLz0lJpy6gfuQ2Ku67cRBPw8eMQQK2AQrmG7P3Fn9v8bIsmB9huCXCCfzPaba9XrhcomnZszunjvk0vNWZpSFsoHeiKpdptB4AS3u/6tMyD5y13n/X+NDU/72O2IokQkFZfnT6Vax/Nv4zRjPYUZhfmMhzVlVepqHdrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888214; c=relaxed/simple;
	bh=srzMa/erRiuNqSAzAt4W75/Gmx7NvMrgiofA2JBL/HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1jEK+RVQ9iIOe1EYwXPRySbQd1dlgOF8dooNByyMIH1o3IzLOmfCLwYKlmPYLeyyUjvnelU6qFMcEMkuM8OYiw5QR+mpWGLQFvBmzhQnElOdy5dPdiVojmNlEr/OOCKlIRMCl6MsAJdCOb7HzpidmPAT9XU4WfLPfD4DzWiCrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=fnZGLrQ7; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1741888210; bh=0uXitbae6V581uWjrVMHNj7OGX7cHcNF+H00TPTK55g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=fnZGLrQ7Vi3LttrhctZMbJiPeDHFaZy5u8vbZKvOz8RIlQ7E+/oHDYLK7hXtqUqfL
	 kbQISb496iGQB2bANJ96nP4KeVKj1pDk1tJJa2uvtz5qJ2kqnIqhQ1N0ai0pPProJh
	 giThajl9SCo/J5UH6GGFGbAhof6smCAsmz5jGOriZ3OpGMV7nMTnhpimg3IKaFouH6
	 JIj73rRBKSIHU5H4Xy8e72xcCdG5WE8aWLefBi8icomUMe8wa0MYPYmNTpOegpy9Wo
	 E4PdYM55TT6acKMLzGgi4WQnoTKRwlZ9KoCVA0b0CZc13JfuR2ahF5M6QEIkfs6aYw
	 YwwtGNdl2bImw==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4ZDFQB1Nk1z8sZC;
	Thu, 13 Mar 2025 18:50:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3614:2b00:7ee6:68e5:4447:ba92
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3614:2b00:7ee6:68e5:4447:ba92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18qRqVufABMZXGakgrMybBRhw8+0eTup34=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4ZDFQ62JbTz8sYB;
	Thu, 13 Mar 2025 18:50:06 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Henriette Herzog <henriette.herzog@rub.de>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	Matan Shachnai <m.shachnai@gmail.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>,
	WANG Xuerui <git@xen0n.name>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Maximilian Ott <ott@cs.fau.de>,
	Milan Stephan <milan.stephan@fau.de>
Subject: [PATCH bpf-next 09/11] bpf: Return PTR_ERR from push_stack()
Date: Thu, 13 Mar 2025 18:41:47 +0100
Message-ID: <20250313174149.1113165-4-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313174149.1113165-1-luis.gerhorst@fau.de>
References: <20250313172127.1098195-1-luis.gerhorst@fau.de>
 <20250313174149.1113165-1-luis.gerhorst@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Main reason is, that it will later allow us to fall back to a nospec for
certain errors in push_stack().

This changes the sanitization-case to returning -ENOMEM. However, this
is more fitting as -EFAULT would indicate a verifier-internal bug.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 kernel/bpf/verifier.c | 72 ++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 683a76aceffa..610f9567af7c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2011,8 +2011,10 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	int err;
 
 	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL);
-	if (!elem)
-		goto err;
+	if (!elem) {
+		err = -ENOMEM;
+		goto unrecoverable_err;
+	}
 
 	elem->insn_idx = insn_idx;
 	elem->prev_insn_idx = prev_insn_idx;
@@ -2022,12 +2024,19 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	env->stack_size++;
 	err = copy_verifier_state(&elem->st, cur);
 	if (err)
-		goto err;
+		goto unrecoverable_err;
 	elem->st.speculative |= speculative;
 	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
 		verbose(env, "The sequence of %d jumps is too complex.\n",
 			env->stack_size);
-		goto err;
+		/* Do not return -EINVAL to prevent main loop from trying to
+		 * mitigate this using nospec if we are on a speculative path.
+		 * If it was tried anyway, we would encounter an -ENOMEM (from
+		 * which we can not recover) again shortly on the next
+		 * non-speculative path that has to be checked.
+		 */
+		err = -ENOMEM;
+		goto unrecoverable_err;
 	}
 	if (elem->st.parent) {
 		++elem->st.parent->branches;
@@ -2042,12 +2051,14 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 		 */
 	}
 	return &elem->st;
-err:
+unrecoverable_err:
 	free_verifier_state(env->cur_state, true);
 	env->cur_state = NULL;
 	/* pop all elements and return */
 	while (!pop_stack(env, NULL, NULL, false));
-	return NULL;
+	WARN_ON_ONCE(err >= 0);
+	WARN_ON_ONCE(error_recoverable_with_nospec(err));
+	return ERR_PTR(err);
 }
 
 #define CALLER_SAVED_REGS 6
@@ -8856,8 +8867,8 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		prev_st = find_prev_entry(env, cur_st->parent, insn_idx);
 		/* branch out active iter state */
 		queued_st = push_stack(env, insn_idx + 1, insn_idx, false);
-		if (!queued_st)
-			return -ENOMEM;
+		if (IS_ERR(queued_st))
+			return PTR_ERR(queued_st);
 
 		queued_iter = get_iter_from_state(queued_st, meta);
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
@@ -10440,8 +10451,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 * proceed with next instruction within current frame.
 	 */
 	callback_state = push_stack(env, env->subprog_info[subprog].start, insn_idx, false);
-	if (!callback_state)
-		return -ENOMEM;
+	if (IS_ERR(callback_state))
+		return PTR_ERR(callback_state);
 
 	err = setup_func_entry(env, subprog, insn_idx, set_callee_state_cb,
 			       callback_state);
@@ -13892,7 +13903,7 @@ sanitize_speculative_path(struct bpf_verifier_env *env,
 	struct bpf_reg_state *regs;
 
 	branch = push_stack(env, next_idx, curr_idx, true);
-	if (branch && insn) {
+	if (!IS_ERR(branch) && insn) {
 		regs = branch->frame[branch->curframe]->regs;
 		if (BPF_SRC(insn->code) == BPF_K) {
 			mark_reg_unknown(env, regs, insn->dst_reg);
@@ -13920,7 +13931,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 	u8 opcode = BPF_OP(insn->code);
 	u32 alu_state, alu_limit;
 	struct bpf_reg_state tmp;
-	bool ret;
+	struct bpf_verifier_state *branch;
 	int err;
 
 	if (can_skip_alu_sanitation(env, insn))
@@ -13993,11 +14004,11 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 		tmp = *dst_reg;
 		copy_register_state(dst_reg, ptr_reg);
 	}
-	ret = sanitize_speculative_path(env, NULL, env->insn_idx + 1,
-					env->insn_idx);
-	if (!ptr_is_dst_reg && ret)
+	branch = sanitize_speculative_path(env, NULL, env->insn_idx + 1,
+					   env->insn_idx);
+	if (!ptr_is_dst_reg && !IS_ERR(branch))
 		*dst_reg = tmp;
-	return !ret ? REASON_STACK : 0;
+	return IS_ERR(branch) ? REASON_STACK : 0;
 }
 
 static void sanitize_mark_insn_seen(struct bpf_verifier_env *env)
@@ -16246,8 +16257,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 		/* branch out 'fallthrough' insn as a new state to explore */
 		queued_st = push_stack(env, idx + 1, idx, false);
-		if (!queued_st)
-			return -ENOMEM;
+		if (IS_ERR(queued_st))
+			return PTR_ERR(queued_st);
 
 		queued_st->may_goto_depth++;
 		if (prev_st)
@@ -16311,10 +16322,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		 * the fall-through branch for simulation under speculative
 		 * execution.
 		 */
-		if (!env->bypass_spec_v1 &&
-		    !sanitize_speculative_path(env, insn, *insn_idx + 1,
-					       *insn_idx))
-			return -EFAULT;
+		if (!env->bypass_spec_v1) {
+			struct bpf_verifier_state *branch = sanitize_speculative_path(
+				env, insn, *insn_idx + 1, *insn_idx);
+			if (IS_ERR(branch))
+				return PTR_ERR(branch);
+		}
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
 		*insn_idx += insn->off;
@@ -16324,11 +16337,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		 * program will go. If needed, push the goto branch for
 		 * simulation under speculative execution.
 		 */
-		if (!env->bypass_spec_v1 &&
-		    !sanitize_speculative_path(env, insn,
-					       *insn_idx + insn->off + 1,
-					       *insn_idx))
-			return -EFAULT;
+		if (!env->bypass_spec_v1) {
+			struct bpf_verifier_state *branch = sanitize_speculative_path(
+				env, insn, *insn_idx + insn->off + 1, *insn_idx);
+			if (IS_ERR(branch))
+				return PTR_ERR(branch);
+		}
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
 		return 0;
@@ -16351,8 +16365,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 	other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx,
 				  false);
-	if (!other_branch)
-		return -EFAULT;
+	if (IS_ERR(other_branch))
+		return PTR_ERR(other_branch);
 	other_branch_regs = other_branch->frame[other_branch->curframe]->regs;
 
 	if (BPF_SRC(insn->code) == BPF_X) {
-- 
2.48.1


