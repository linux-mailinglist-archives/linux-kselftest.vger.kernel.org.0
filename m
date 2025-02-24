Return-Path: <linux-kselftest+bounces-27384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FA5A42E4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 21:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA226189760A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 20:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BCC24500F;
	Mon, 24 Feb 2025 20:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="q/KaE+t0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B91A5B8B;
	Mon, 24 Feb 2025 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430349; cv=none; b=eIPgud9A+IijrbIIO2bUx2hL+ZeQEGPubTpnsv5XpTzweYrBi1h6MqMHBkp/BxRLBw2R0nmaT2Gd4vlVpvh0H+iIxavLzpRQN4JGfiHsbEoHbe2r09prK9kWm+doL3ncBdA1IvOP2mhw3c7jO+bDHvN1YhxBn0a8FOu8AKfe/nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430349; c=relaxed/simple;
	bh=OXn3Uu+gQ9c3RLQAujMg7ZAmlHllThbNbBycDxf6u/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fteMkQ++27NHYbq2ReFrKTgBhCxIVVl8Tmle4VNm6DH594Rj8iC9M3fJlNrspWnerhfwM8+1OMNFezsdbRTS2HXdiOUHiDlpHrUWw7SxoUFIV5mIVDg+yh5X1JqakqgMmUOUNVwbLc26rlPllTyzMuKJiroJ3j+8fSa/AAnNZTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=q/KaE+t0; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Z1tGJ5njHzPk3T;
	Mon, 24 Feb 2025 21:52:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1740430344; bh=OiuNKiAS+hTR+fhJp6x108vWgctpUrLzfl7kMtExH6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=q/KaE+t00/Gft3eo2t/VfHs/88XfbCborQ4GQjPmsCuB50ItFoDnIPUOhT7RngcFt
	 T2FQfbyk0wHWXedfXb9bNRd7Kc7csnajBUD8DvOZw5rogaI/gKHQvOZxesCroABspt
	 5QHhD4VMYM86PUloy8UrAnTXcotN3UArdrzNOGwM226zVIic0+I9vQyFltpsWBgdnQ
	 qxCJwPJpD2cOxr9+SbEIXsd88OnHWVsgqDsZMcmcfzgi9YFII9Ia8rmjyriOfmsVAK
	 r0yyi/6f4TNQVSJ14BCirHbT8NQZUaP9zdi2VycxntDEn/3dDicZoB88DdWy0g0qpK
	 U0SOjfbGtZY5g==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:362e:e00:55a6:11d5:2473:17a9
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:362e:e00:55a6:11d5:2473:17a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+BBC75IbyzFS0BDN4tVWKxiHYwgF5BobA=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Z1tGF4LgJzPk3N;
	Mon, 24 Feb 2025 21:52:21 +0100 (CET)
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
	linux-kselftest@vger.kernel.org
Cc: Maximilian Ott <ott@cs.fau.de>,
	Milan Stephan <milan.stephan@fau.de>
Subject: [RFC PATCH 7/9] bpf: Refactor push_stack to return error code
Date: Mon, 24 Feb 2025 21:52:06 +0100
Message-ID: <20250224205206.607052-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224203619.594724-1-luis.gerhorst@fau.de>
References: <20250224203619.594724-1-luis.gerhorst@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Main reason is, that it will later allow us to fall back to a nospec for
certain errors in push_stack().

This has the side effect of changing the sanitization-case to returning
ENOMEM. However, I believe this is more fitting as I undestand EFAULT to
indicate a verifier-internal bug.

Downside is, that it requires us to introduce an output parameter for
the state.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 kernel/bpf/verifier.c | 71 +++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 06c2f929d602..406294bcd5ce 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1934,8 +1934,10 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
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
@@ -1945,12 +1947,18 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
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
+		/* Do not return -EINVAL to signal to the main loop that this
+		 * can likely not be recovered-from by inserting a nospec if we
+		 * are on a speculative path. If it was tried anyway, we would
+		 * encounter it again shortly anyway.
+		 */
+		err = -ENOMEM;
+		goto unrecoverable_err;
 	}
 	if (elem->st.parent) {
 		++elem->st.parent->branches;
@@ -1965,12 +1973,14 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
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
@@ -8630,8 +8640,8 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		prev_st = find_prev_entry(env, cur_st->parent, insn_idx);
 		/* branch out active iter state */
 		queued_st = push_stack(env, insn_idx + 1, insn_idx, false);
-		if (!queued_st)
-			return -ENOMEM;
+		if (IS_ERR(queued_st))
+			return PTR_ERR(queued_st);
 
 		queued_iter = get_iter_from_state(queued_st, meta);
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
@@ -10214,8 +10224,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 * proceed with next instruction within current frame.
 	 */
 	callback_state = push_stack(env, env->subprog_info[subprog].start, insn_idx, false);
-	if (!callback_state)
-		return -ENOMEM;
+	if (IS_ERR(callback_state))
+		return PTR_ERR(callback_state);
 
 	err = setup_func_entry(env, subprog, insn_idx, set_callee_state_cb,
 			       callback_state);
@@ -13654,7 +13664,7 @@ sanitize_speculative_path(struct bpf_verifier_env *env,
 	struct bpf_reg_state *regs;
 
 	branch = push_stack(env, next_idx, curr_idx, true);
-	if (branch && insn) {
+	if (!IS_ERR(branch) && insn) {
 		regs = branch->frame[branch->curframe]->regs;
 		if (BPF_SRC(insn->code) == BPF_K) {
 			mark_reg_unknown(env, regs, insn->dst_reg);
@@ -13682,7 +13692,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 	u8 opcode = BPF_OP(insn->code);
 	u32 alu_state, alu_limit;
 	struct bpf_reg_state tmp;
-	bool ret;
+	struct bpf_verifier_state *branch;
 	int err;
 
 	if (can_skip_alu_sanitation(env, insn))
@@ -13755,11 +13765,11 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
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
@@ -16008,8 +16018,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 		/* branch out 'fallthrough' insn as a new state to explore */
 		queued_st = push_stack(env, idx + 1, idx, false);
-		if (!queued_st)
-			return -ENOMEM;
+		if (IS_ERR(queued_st))
+			return PTR_ERR(queued_st);
 
 		queued_st->may_goto_depth++;
 		if (prev_st)
@@ -16073,10 +16083,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
@@ -16086,11 +16098,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
@@ -16113,8 +16126,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
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


