Return-Path: <linux-kselftest+bounces-27379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD61A42E0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 21:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6873F1728A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 20:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CCF242928;
	Mon, 24 Feb 2025 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="CCETnaDX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E70A3B2A0;
	Mon, 24 Feb 2025 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429553; cv=none; b=t2OiXdOxIaaxmZ3n9vUCA4iL3MoBN1/PPBM9FPXhyDzbjOoiSp/UIztKRAKmF9ZYf+QEAuaHTmIR7DQoTtcxemBHbRLGmP7+EmnUmKoDZhZ3sLyIhULZOpYO53gziZk8A0rLpsRvhSA2f/zTvv1luNu2Am/TzS2dORO5H+PajwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429553; c=relaxed/simple;
	bh=xBpUNRlMv8eBh6Ewufjws5mDlLvcldeY/XtnPuLVo00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKizYEfozz/kIFCKF22xpXJCjmhnxLZAoYazQ+igvaMkd2KiA5pDWAyd14kPULRCuR6dwOtGZjlljXPIFJSa4icqz3y78FsbrtQXdg4Nvc3WKisyxkfCksDdgFBYT/pz1B+EtUPHiEZSTnFXH8Ci7OHUJiBTLzjTZexu96HvnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=CCETnaDX; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Z1sz03hGTz8sn7;
	Mon, 24 Feb 2025 21:39:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1740429548; bh=sbgxMaH5XzXmW8NTKLr89nxlobbcIHd5KiSJEUuIRMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=CCETnaDXmtV3R484tuuGrZybHtkWY+I7B1+/Z9i0xUediy+LFllFj1ocxtXZVwdJ1
	 6sK6jQhnbF2z5c8HEKbl4HHkX6T+F/dYd1CEYCr1l0foet7z9DG0gYH17ekfEfBstj
	 Y38D1zVuqaCzYFY+6OGjMBpVxRsTFZwM+KVW83GaBL9JwEmU0nLbEyKGHkzL+OK4nv
	 cqXsjYJuEoDGYXUSRtfm9Ok0TzRJYUpok5nAdmBOFwF6FzssTtx7nUd3fIpV4Fuf2o
	 BZSt0m1sshBqKiSKaQTjQh1dVd0L5jC7nxzAQd/FftoEM+ReFR66GW+8zfK37AUSFK
	 XnEMKdJtW0+cQ==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:362e:e00:55a6:11d5:2473:17a9
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:362e:e00:55a6:11d5:2473:17a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19szfa4AW79huHBe3OpklUC/58sHea5sSo=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Z1syw5m7Zz8sp9;
	Mon, 24 Feb 2025 21:39:04 +0100 (CET)
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
Subject: [RFC PATCH 2/9] bpf: Refactor do_check() if/else into do_check_insn()
Date: Mon, 24 Feb 2025 21:36:12 +0100
Message-ID: <20250224203619.594724-3-luis.gerhorst@fau.de>
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

This is required to catch the errors later and fall back to a nospec if
on a speculative path.

Move code into do_check_insn(), replace
"continue" with "return CHECK_NEXT_INSN",
"break" with "return ALL_PATHS_CHECKED",
"do_print_state = " with "*do_print_state = ",
and "goto process_bpf_exit" / fallthrough with "return process_bpf_exit()".

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 kernel/bpf/verifier.c | 528 +++++++++++++++++++++++-------------------
 1 file changed, 288 insertions(+), 240 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5be3bd38f540..42ff90bc81e6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18932,6 +18932,275 @@ static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type typ
 	return 0;
 }
 
+enum {
+	ALL_PATHS_CHECKED = 1,
+	CHECK_NEXT_INSN
+};
+
+static int process_bpf_exit(struct bpf_verifier_env *env, int *prev_insn_idx,
+			    bool pop_log, bool *do_print_state)
+{
+	int err;
+
+	mark_verifier_state_scratched(env);
+	update_branch_counts(env, env->cur_state);
+	err = pop_stack(env, prev_insn_idx,
+			&env->insn_idx, pop_log);
+	if (err < 0) {
+		if (err != -ENOENT)
+			return err;
+		return ALL_PATHS_CHECKED;
+	}
+
+	*do_print_state = true;
+	return CHECK_NEXT_INSN;
+}
+
+static int do_check_insn(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			 bool pop_log, bool *do_print_state,
+			 struct bpf_reg_state *regs,
+			 struct bpf_verifier_state *state, int *prev_insn_idx)
+{
+	int err;
+	u8 class = BPF_CLASS(insn->code);
+	bool exception_exit = false;
+
+	if (class == BPF_ALU || class == BPF_ALU64) {
+		err = check_alu_op(env, insn);
+		if (err)
+			return err;
+
+	} else if (class == BPF_LDX) {
+		enum bpf_reg_type src_reg_type;
+
+		/* check for reserved fields is already done */
+
+		/* check src operand */
+		err = check_reg_arg(env, insn->src_reg, SRC_OP);
+		if (err)
+			return err;
+
+		err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
+		if (err)
+			return err;
+
+		src_reg_type = regs[insn->src_reg].type;
+
+		/* check that memory (src_reg + off) is readable,
+		 * the state of dst_reg will be updated by this func
+		 */
+		err = check_mem_access(env, env->insn_idx, insn->src_reg,
+				       insn->off, BPF_SIZE(insn->code),
+				       BPF_READ, insn->dst_reg, false,
+				       BPF_MODE(insn->code) == BPF_MEMSX);
+		err = err ?: save_aux_ptr_type(env, src_reg_type, true);
+		err = err   ?:
+			      reg_bounds_sanity_check(env, &regs[insn->dst_reg],
+						      "ldx");
+		if (err)
+			return err;
+	} else if (class == BPF_STX) {
+		enum bpf_reg_type dst_reg_type;
+
+		if (BPF_MODE(insn->code) == BPF_ATOMIC) {
+			err = check_atomic(env, env->insn_idx, insn);
+			if (err)
+				return err;
+			env->insn_idx++;
+			return CHECK_NEXT_INSN;
+		}
+
+		if (BPF_MODE(insn->code) != BPF_MEM || insn->imm != 0) {
+			verbose(env, "BPF_STX uses reserved fields\n");
+			return -EINVAL;
+		}
+
+		/* check src1 operand */
+		err = check_reg_arg(env, insn->src_reg, SRC_OP);
+		if (err)
+			return err;
+		/* check src2 operand */
+		err = check_reg_arg(env, insn->dst_reg, SRC_OP);
+		if (err)
+			return err;
+
+		dst_reg_type = regs[insn->dst_reg].type;
+
+		/* check that memory (dst_reg + off) is writeable */
+		err = check_mem_access(env, env->insn_idx, insn->dst_reg,
+				       insn->off, BPF_SIZE(insn->code),
+				       BPF_WRITE, insn->src_reg, false, false);
+		if (err)
+			return err;
+
+		err = save_aux_ptr_type(env, dst_reg_type, false);
+		if (err)
+			return err;
+	} else if (class == BPF_ST) {
+		enum bpf_reg_type dst_reg_type;
+
+		if (BPF_MODE(insn->code) != BPF_MEM ||
+		    insn->src_reg != BPF_REG_0) {
+			verbose(env, "BPF_ST uses reserved fields\n");
+			return -EINVAL;
+		}
+		/* check src operand */
+		err = check_reg_arg(env, insn->dst_reg, SRC_OP);
+		if (err)
+			return err;
+
+		dst_reg_type = regs[insn->dst_reg].type;
+
+		/* check that memory (dst_reg + off) is writeable */
+		err = check_mem_access(env, env->insn_idx, insn->dst_reg,
+				       insn->off, BPF_SIZE(insn->code),
+				       BPF_WRITE, -1, false, false);
+		if (err)
+			return err;
+
+		err = save_aux_ptr_type(env, dst_reg_type, false);
+		if (err)
+			return err;
+	} else if (class == BPF_JMP || class == BPF_JMP32) {
+		u8 opcode = BPF_OP(insn->code);
+
+		env->jmps_processed++;
+		if (opcode == BPF_CALL) {
+			if (BPF_SRC(insn->code) != BPF_K ||
+			    (insn->src_reg != BPF_PSEUDO_KFUNC_CALL &&
+			     insn->off != 0) ||
+			    (insn->src_reg != BPF_REG_0 &&
+			     insn->src_reg != BPF_PSEUDO_CALL &&
+			     insn->src_reg != BPF_PSEUDO_KFUNC_CALL) ||
+			    insn->dst_reg != BPF_REG_0 || class == BPF_JMP32) {
+				verbose(env, "BPF_CALL uses reserved fields\n");
+				return -EINVAL;
+			}
+
+			if (env->cur_state->active_locks) {
+				if ((insn->src_reg == BPF_REG_0 &&
+				     insn->imm != BPF_FUNC_spin_unlock) ||
+				    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+				     (insn->off != 0 ||
+				      !kfunc_spin_allowed(insn->imm)))) {
+					verbose(env,
+						"function calls are not allowed while holding a lock\n");
+					return -EINVAL;
+				}
+			}
+			if (insn->src_reg == BPF_PSEUDO_CALL) {
+				err = check_func_call(env, insn,
+						      &env->insn_idx);
+			} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
+				err = check_kfunc_call(env, insn,
+						       &env->insn_idx);
+				if (!err && is_bpf_throw_kfunc(insn)) {
+					exception_exit = true;
+					goto process_bpf_exit_full;
+				}
+			} else {
+				err = check_helper_call(env, insn,
+							&env->insn_idx);
+			}
+			if (err)
+				return err;
+
+			mark_reg_scratched(env, BPF_REG_0);
+		} else if (opcode == BPF_JA) {
+			if (BPF_SRC(insn->code) != BPF_K ||
+			    insn->src_reg != BPF_REG_0 ||
+			    insn->dst_reg != BPF_REG_0 ||
+			    (class == BPF_JMP && insn->imm != 0) ||
+			    (class == BPF_JMP32 && insn->off != 0)) {
+				verbose(env, "BPF_JA uses reserved fields\n");
+				return -EINVAL;
+			}
+
+			if (class == BPF_JMP)
+				env->insn_idx += insn->off + 1;
+			else
+				env->insn_idx += insn->imm + 1;
+			return CHECK_NEXT_INSN;
+
+		} else if (opcode == BPF_EXIT) {
+			if (BPF_SRC(insn->code) != BPF_K || insn->imm != 0 ||
+			    insn->src_reg != BPF_REG_0 ||
+			    insn->dst_reg != BPF_REG_0 || class == BPF_JMP32) {
+				verbose(env, "BPF_EXIT uses reserved fields\n");
+				return -EINVAL;
+			}
+process_bpf_exit_full:
+			/* We must do check_reference_leak here before
+			 * prepare_func_exit to handle the case when
+			 * state->curframe > 0, it may be a callback function,
+			 * for which reference_state must match caller reference
+			 * state when it exits.
+			 */
+			err = check_resource_leak(env, exception_exit,
+						  !env->cur_state->curframe,
+						  "BPF_EXIT instruction in main prog");
+			if (err)
+				return err;
+
+			/* The side effect of the prepare_func_exit which is
+			 * being skipped is that it frees bpf_func_state.
+			 * Typically, process_bpf_exit will only be hit with
+			 * outermost exit. copy_verifier_state in pop_stack will
+			 * handle freeing of any extra bpf_func_state left over
+			 * from not processing all nested function exits. We
+			 * also skip return code checks as they are not needed
+			 * for exceptional exits.
+			 */
+			if (exception_exit)
+				goto process_bpf_exit;
+
+			if (state->curframe) {
+				/* exit from nested function */
+				err = prepare_func_exit(env, &env->insn_idx);
+				if (err)
+					return err;
+				*do_print_state = true;
+				return CHECK_NEXT_INSN;
+			}
+
+			err = check_return_code(env, BPF_REG_0, "R0");
+			if (err)
+				return err;
+process_bpf_exit:
+			return process_bpf_exit(env, prev_insn_idx, pop_log,
+						do_print_state);
+		} else {
+			err = check_cond_jmp_op(env, insn, &env->insn_idx);
+			if (err)
+				return err;
+		}
+	} else if (class == BPF_LD) {
+		u8 mode = BPF_MODE(insn->code);
+
+		if (mode == BPF_ABS || mode == BPF_IND) {
+			err = check_ld_abs(env, insn);
+			if (err)
+				return err;
+
+		} else if (mode == BPF_IMM) {
+			err = check_ld_imm(env, insn);
+			if (err)
+				return err;
+
+			env->insn_idx++;
+			sanitize_mark_insn_seen(env);
+		} else {
+			verbose(env, "invalid BPF_LD mode\n");
+			return -EINVAL;
+		}
+	} else {
+		verbose(env, "unknown insn class %d\n", class);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int do_check(struct bpf_verifier_env *env)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
@@ -18943,9 +19212,7 @@ static int do_check(struct bpf_verifier_env *env)
 	int prev_insn_idx = -1;
 
 	for (;;) {
-		bool exception_exit = false;
 		struct bpf_insn *insn;
-		u8 class;
 		int err;
 
 		/* reset current history entry on each new instruction */
@@ -18959,7 +19226,6 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		insn = &insns[env->insn_idx];
-		class = BPF_CLASS(insn->code);
 
 		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
 			verbose(env,
@@ -18985,7 +19251,16 @@ static int do_check(struct bpf_verifier_env *env)
 					else
 						verbose(env, "%d: safe\n", env->insn_idx);
 				}
-				goto process_bpf_exit;
+				err = process_bpf_exit(env, &prev_insn_idx, pop_log,
+						       &do_print_state);
+				if (err == CHECK_NEXT_INSN) {
+					continue;
+				} else if (err == ALL_PATHS_CHECKED) {
+					break;
+				} else if (err) {
+					WARN_ON_ONCE(err > 0);
+					return err;
+				}
 			}
 		}
 
@@ -19039,242 +19314,15 @@ static int do_check(struct bpf_verifier_env *env)
 		sanitize_mark_insn_seen(env);
 		prev_insn_idx = env->insn_idx;
 
-		if (class == BPF_ALU || class == BPF_ALU64) {
-			err = check_alu_op(env, insn);
-			if (err)
-				return err;
-
-		} else if (class == BPF_LDX) {
-			enum bpf_reg_type src_reg_type;
-
-			/* check for reserved fields is already done */
-
-			/* check src operand */
-			err = check_reg_arg(env, insn->src_reg, SRC_OP);
-			if (err)
-				return err;
-
-			err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
-			if (err)
-				return err;
-
-			src_reg_type = regs[insn->src_reg].type;
-
-			/* check that memory (src_reg + off) is readable,
-			 * the state of dst_reg will be updated by this func
-			 */
-			err = check_mem_access(env, env->insn_idx, insn->src_reg,
-					       insn->off, BPF_SIZE(insn->code),
-					       BPF_READ, insn->dst_reg, false,
-					       BPF_MODE(insn->code) == BPF_MEMSX);
-			err = err ?: save_aux_ptr_type(env, src_reg_type, true);
-			err = err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], "ldx");
-			if (err)
-				return err;
-		} else if (class == BPF_STX) {
-			enum bpf_reg_type dst_reg_type;
-
-			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
-				err = check_atomic(env, env->insn_idx, insn);
-				if (err)
-					return err;
-				env->insn_idx++;
-				continue;
-			}
-
-			if (BPF_MODE(insn->code) != BPF_MEM || insn->imm != 0) {
-				verbose(env, "BPF_STX uses reserved fields\n");
-				return -EINVAL;
-			}
-
-			/* check src1 operand */
-			err = check_reg_arg(env, insn->src_reg, SRC_OP);
-			if (err)
-				return err;
-			/* check src2 operand */
-			err = check_reg_arg(env, insn->dst_reg, SRC_OP);
-			if (err)
-				return err;
-
-			dst_reg_type = regs[insn->dst_reg].type;
-
-			/* check that memory (dst_reg + off) is writeable */
-			err = check_mem_access(env, env->insn_idx, insn->dst_reg,
-					       insn->off, BPF_SIZE(insn->code),
-					       BPF_WRITE, insn->src_reg, false, false);
-			if (err)
-				return err;
-
-			err = save_aux_ptr_type(env, dst_reg_type, false);
-			if (err)
-				return err;
-		} else if (class == BPF_ST) {
-			enum bpf_reg_type dst_reg_type;
-
-			if (BPF_MODE(insn->code) != BPF_MEM ||
-			    insn->src_reg != BPF_REG_0) {
-				verbose(env, "BPF_ST uses reserved fields\n");
-				return -EINVAL;
-			}
-			/* check src operand */
-			err = check_reg_arg(env, insn->dst_reg, SRC_OP);
-			if (err)
-				return err;
-
-			dst_reg_type = regs[insn->dst_reg].type;
-
-			/* check that memory (dst_reg + off) is writeable */
-			err = check_mem_access(env, env->insn_idx, insn->dst_reg,
-					       insn->off, BPF_SIZE(insn->code),
-					       BPF_WRITE, -1, false, false);
-			if (err)
-				return err;
-
-			err = save_aux_ptr_type(env, dst_reg_type, false);
-			if (err)
-				return err;
-		} else if (class == BPF_JMP || class == BPF_JMP32) {
-			u8 opcode = BPF_OP(insn->code);
-
-			env->jmps_processed++;
-			if (opcode == BPF_CALL) {
-				if (BPF_SRC(insn->code) != BPF_K ||
-				    (insn->src_reg != BPF_PSEUDO_KFUNC_CALL
-				     && insn->off != 0) ||
-				    (insn->src_reg != BPF_REG_0 &&
-				     insn->src_reg != BPF_PSEUDO_CALL &&
-				     insn->src_reg != BPF_PSEUDO_KFUNC_CALL) ||
-				    insn->dst_reg != BPF_REG_0 ||
-				    class == BPF_JMP32) {
-					verbose(env, "BPF_CALL uses reserved fields\n");
-					return -EINVAL;
-				}
-
-				if (env->cur_state->active_locks) {
-					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
-					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
-					     (insn->off != 0 || !kfunc_spin_allowed(insn->imm)))) {
-						verbose(env, "function calls are not allowed while holding a lock\n");
-						return -EINVAL;
-					}
-				}
-				if (insn->src_reg == BPF_PSEUDO_CALL) {
-					err = check_func_call(env, insn, &env->insn_idx);
-				} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
-					err = check_kfunc_call(env, insn, &env->insn_idx);
-					if (!err && is_bpf_throw_kfunc(insn)) {
-						exception_exit = true;
-						goto process_bpf_exit_full;
-					}
-				} else {
-					err = check_helper_call(env, insn, &env->insn_idx);
-				}
-				if (err)
-					return err;
-
-				mark_reg_scratched(env, BPF_REG_0);
-			} else if (opcode == BPF_JA) {
-				if (BPF_SRC(insn->code) != BPF_K ||
-				    insn->src_reg != BPF_REG_0 ||
-				    insn->dst_reg != BPF_REG_0 ||
-				    (class == BPF_JMP && insn->imm != 0) ||
-				    (class == BPF_JMP32 && insn->off != 0)) {
-					verbose(env, "BPF_JA uses reserved fields\n");
-					return -EINVAL;
-				}
-
-				if (class == BPF_JMP)
-					env->insn_idx += insn->off + 1;
-				else
-					env->insn_idx += insn->imm + 1;
-				continue;
-
-			} else if (opcode == BPF_EXIT) {
-				if (BPF_SRC(insn->code) != BPF_K ||
-				    insn->imm != 0 ||
-				    insn->src_reg != BPF_REG_0 ||
-				    insn->dst_reg != BPF_REG_0 ||
-				    class == BPF_JMP32) {
-					verbose(env, "BPF_EXIT uses reserved fields\n");
-					return -EINVAL;
-				}
-process_bpf_exit_full:
-				/* We must do check_reference_leak here before
-				 * prepare_func_exit to handle the case when
-				 * state->curframe > 0, it may be a callback
-				 * function, for which reference_state must
-				 * match caller reference state when it exits.
-				 */
-				err = check_resource_leak(env, exception_exit, !env->cur_state->curframe,
-							  "BPF_EXIT instruction in main prog");
-				if (err)
-					return err;
-
-				/* The side effect of the prepare_func_exit
-				 * which is being skipped is that it frees
-				 * bpf_func_state. Typically, process_bpf_exit
-				 * will only be hit with outermost exit.
-				 * copy_verifier_state in pop_stack will handle
-				 * freeing of any extra bpf_func_state left over
-				 * from not processing all nested function
-				 * exits. We also skip return code checks as
-				 * they are not needed for exceptional exits.
-				 */
-				if (exception_exit)
-					goto process_bpf_exit;
-
-				if (state->curframe) {
-					/* exit from nested function */
-					err = prepare_func_exit(env, &env->insn_idx);
-					if (err)
-						return err;
-					do_print_state = true;
-					continue;
-				}
-
-				err = check_return_code(env, BPF_REG_0, "R0");
-				if (err)
-					return err;
-process_bpf_exit:
-				mark_verifier_state_scratched(env);
-				update_branch_counts(env, env->cur_state);
-				err = pop_stack(env, &prev_insn_idx,
-						&env->insn_idx, pop_log);
-				if (err < 0) {
-					if (err != -ENOENT)
-						return err;
-					break;
-				} else {
-					do_print_state = true;
-					continue;
-				}
-			} else {
-				err = check_cond_jmp_op(env, insn, &env->insn_idx);
-				if (err)
-					return err;
-			}
-		} else if (class == BPF_LD) {
-			u8 mode = BPF_MODE(insn->code);
-
-			if (mode == BPF_ABS || mode == BPF_IND) {
-				err = check_ld_abs(env, insn);
-				if (err)
-					return err;
-
-			} else if (mode == BPF_IMM) {
-				err = check_ld_imm(env, insn);
-				if (err)
-					return err;
-
-				env->insn_idx++;
-				sanitize_mark_insn_seen(env);
-			} else {
-				verbose(env, "invalid BPF_LD mode\n");
-				return -EINVAL;
-			}
-		} else {
-			verbose(env, "unknown insn class %d\n", class);
-			return -EINVAL;
+		err = do_check_insn(env, insn, pop_log, &do_print_state, regs, state,
+				    &prev_insn_idx);
+		if (err == CHECK_NEXT_INSN) {
+			continue;
+		} else if (err == ALL_PATHS_CHECKED) {
+			break;
+		} else if (err) {
+			WARN_ON_ONCE(err > 0);
+			return err;
 		}
 
 		env->insn_idx++;
-- 
2.48.1


