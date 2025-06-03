Return-Path: <linux-kselftest+bounces-34253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E6CACCEA9
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 23:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39CD57A1AFC
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D9B224247;
	Tue,  3 Jun 2025 21:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="nTEM85N1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C754918;
	Tue,  3 Jun 2025 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748984937; cv=none; b=Qpdxl8t4Gi7MRvyjFpwQrMeGuMR7DuhiuyiodJ+ksCImtCieZ99AJFUTaej0zuBJQpPJvEvcB0G72oLt65AnjtcYOBFJDDYTJr+ohVxccPDvBLlP0ek5lXgEegZQi/2k54tjbqdb85Sh6AaNrz7GX+w5V3VxTIH9f6+YnsYuFvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748984937; c=relaxed/simple;
	bh=aWBgCi3B1Scf1zMtzS8uMObJlL/HdGNSPVktksO3kbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfkukSIpLDrpIZCd3gimBDgYzGwv1HyGLEFQ+HstdY7mHyy0KDLXNU6g09E1KEhNJtCzHlgJijZsShMO3yp1lLb78LQS3iaKUBOTC/9MkrxmfQYcKFxyagy/jT5RgWcrx1EH9e9nkTtZWdnMafbu3lymmIN307C8N6YNheDMhC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=nTEM85N1; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1748984470; bh=2Lf9tfZYrOpzCpGiAeazFx+eYcO3ZXEjViLfHjoKxvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=nTEM85N1SHQYBShr1GceFe4QgYoYiCtWda0eqtuwoWSdUj007/bn3nxjsDnPS7Zqg
	 itwtev5rBKG3nXIQD1m8IOiYHFMtBqIhtlvPtLuwXLtS9xG9MeqeMYOz+X8inKIOoA
	 XM2TpZJM1mxD6E9UF3nbrLJflQo1D2xoSKHkxegJY5jaq/Z7l7r+ymcwadTm0vKkIC
	 fyYucJTtduSuE0d9hA5sLk0NFQ7z39iMA4z0tRLpT0HGjeDB6aG+eo8TFn8TjD7lEX
	 H3/wlqGmWqxU8ss6IHu4WPNGwGxPJg1S8PWxLqBWNFB/Z3kKUqrd53LfLdVQV/LYvK
	 GMU5GeGq5Q0UQ==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bBjmk3hHVz1yNg;
	Tue,  3 Jun 2025 23:01:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3639:fe00:a21f:4ce4:8495:5578
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3639:fe00:a21f:4ce4:8495:5578])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/NbMnGaXYiRuu9sySXs39BAyREF6WAvO0=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bBjmd5NPMz1xxq;
	Tue,  3 Jun 2025 23:01:05 +0200 (CEST)
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
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	Jiayuan Chen <mrpre@163.com>,
	Matan Shachnai <m.shachnai@gmail.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Maximilian Ott <ott@cs.fau.de>,
	Milan Stephan <milan.stephan@fau.de>
Subject: [PATCH bpf-next v4 1/9] bpf: Move insn if/else into do_check_insn()
Date: Tue,  3 Jun 2025 22:57:52 +0200
Message-ID: <20250603205800.334980-2-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603205800.334980-1-luis.gerhorst@fau.de>
References: <20250603205800.334980-1-luis.gerhorst@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is required to catch the errors later and fall back to a nospec if
on a speculative path.

Eliminate the regs variable as it is only used once and insn_idx is not
modified in-between the definition and usage.

Do not pass insn but compute it in the function itself. As Eduard points
out [1], insn is assumed to correspond to env->insn_idx in many places
(e.g, __check_reg_arg()).

Move code into do_check_insn(), replace
* "continue" with "return 0" after modifying insn_idx
* "goto process_bpf_exit" with "return PROCESS_BPF_EXIT"
* "goto process_bpf_exit_full" with "return process_bpf_exit_full()"
* "do_print_state = " with "*do_print_state = "

[1] https://lore.kernel.org/all/293dbe3950a782b8eb3b87b71d7a967e120191fd.camel@gmail.com/

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
---
 kernel/bpf/verifier.c | 428 ++++++++++++++++++++++--------------------
 1 file changed, 223 insertions(+), 205 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7d6e0c5928b..2e70be0cad49 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19421,20 +19421,223 @@ static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type typ
 	return 0;
 }
 
+enum {
+	PROCESS_BPF_EXIT = 1
+};
+
+static int process_bpf_exit_full(struct bpf_verifier_env *env,
+				 bool *do_print_state,
+				 bool exception_exit)
+{
+	/* We must do check_reference_leak here before
+	 * prepare_func_exit to handle the case when
+	 * state->curframe > 0, it may be a callback function,
+	 * for which reference_state must match caller reference
+	 * state when it exits.
+	 */
+	int err = check_resource_leak(env, exception_exit,
+				      !env->cur_state->curframe,
+				      "BPF_EXIT instruction in main prog");
+	if (err)
+		return err;
+
+	/* The side effect of the prepare_func_exit which is
+	 * being skipped is that it frees bpf_func_state.
+	 * Typically, process_bpf_exit will only be hit with
+	 * outermost exit. copy_verifier_state in pop_stack will
+	 * handle freeing of any extra bpf_func_state left over
+	 * from not processing all nested function exits. We
+	 * also skip return code checks as they are not needed
+	 * for exceptional exits.
+	 */
+	if (exception_exit)
+		return PROCESS_BPF_EXIT;
+
+	if (env->cur_state->curframe) {
+		/* exit from nested function */
+		err = prepare_func_exit(env, &env->insn_idx);
+		if (err)
+			return err;
+		*do_print_state = true;
+		return 0;
+	}
+
+	err = check_return_code(env, BPF_REG_0, "R0");
+	if (err)
+		return err;
+	return PROCESS_BPF_EXIT;
+}
+
+static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
+{
+	int err;
+	struct bpf_insn *insn = &env->prog->insnsi[env->insn_idx];
+	u8 class = BPF_CLASS(insn->code);
+
+	if (class == BPF_ALU || class == BPF_ALU64) {
+		err = check_alu_op(env, insn);
+		if (err)
+			return err;
+
+	} else if (class == BPF_LDX) {
+		bool is_ldsx = BPF_MODE(insn->code) == BPF_MEMSX;
+
+		/* Check for reserved fields is already done in
+		 * resolve_pseudo_ldimm64().
+		 */
+		err = check_load_mem(env, insn, false, is_ldsx, true, "ldx");
+		if (err)
+			return err;
+	} else if (class == BPF_STX) {
+		if (BPF_MODE(insn->code) == BPF_ATOMIC) {
+			err = check_atomic(env, insn);
+			if (err)
+				return err;
+			env->insn_idx++;
+			return 0;
+		}
+
+		if (BPF_MODE(insn->code) != BPF_MEM || insn->imm != 0) {
+			verbose(env, "BPF_STX uses reserved fields\n");
+			return -EINVAL;
+		}
+
+		err = check_store_reg(env, insn, false);
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
+		dst_reg_type = cur_regs(env)[insn->dst_reg].type;
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
+				     (insn->off != 0 || !kfunc_spin_allowed(insn->imm)))) {
+					verbose(env,
+						"function calls are not allowed while holding a lock\n");
+					return -EINVAL;
+				}
+			}
+			if (insn->src_reg == BPF_PSEUDO_CALL) {
+				err = check_func_call(env, insn, &env->insn_idx);
+			} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
+				err = check_kfunc_call(env, insn, &env->insn_idx);
+				if (!err && is_bpf_throw_kfunc(insn))
+					return process_bpf_exit_full(env, do_print_state, true);
+			} else {
+				err = check_helper_call(env, insn, &env->insn_idx);
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
+			return 0;
+		} else if (opcode == BPF_EXIT) {
+			if (BPF_SRC(insn->code) != BPF_K ||
+			    insn->imm != 0 ||
+			    insn->src_reg != BPF_REG_0 ||
+			    insn->dst_reg != BPF_REG_0 ||
+			    class == BPF_JMP32) {
+				verbose(env, "BPF_EXIT uses reserved fields\n");
+				return -EINVAL;
+			}
+			return process_bpf_exit_full(env, do_print_state, false);
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
+	env->insn_idx++;
+	return 0;
+}
+
 static int do_check(struct bpf_verifier_env *env)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_verifier_state *state = env->cur_state;
 	struct bpf_insn *insns = env->prog->insnsi;
-	struct bpf_reg_state *regs;
 	int insn_cnt = env->prog->len;
 	bool do_print_state = false;
 	int prev_insn_idx = -1;
 
 	for (;;) {
-		bool exception_exit = false;
 		struct bpf_insn *insn;
-		u8 class;
 		int err;
 
 		/* reset current history entry on each new instruction */
@@ -19448,7 +19651,6 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		insn = &insns[env->insn_idx];
-		class = BPF_CLASS(insn->code);
 
 		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
 			verbose(env,
@@ -19518,215 +19720,31 @@ static int do_check(struct bpf_verifier_env *env)
 				return err;
 		}
 
-		regs = cur_regs(env);
 		sanitize_mark_insn_seen(env);
 		prev_insn_idx = env->insn_idx;
 
-		if (class == BPF_ALU || class == BPF_ALU64) {
-			err = check_alu_op(env, insn);
-			if (err)
-				return err;
-
-		} else if (class == BPF_LDX) {
-			bool is_ldsx = BPF_MODE(insn->code) == BPF_MEMSX;
-
-			/* Check for reserved fields is already done in
-			 * resolve_pseudo_ldimm64().
-			 */
-			err = check_load_mem(env, insn, false, is_ldsx, true,
-					     "ldx");
-			if (err)
-				return err;
-		} else if (class == BPF_STX) {
-			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
-				err = check_atomic(env, insn);
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
-			err = check_store_reg(env, insn, false);
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
+		err = do_check_insn(env, &do_print_state);
+		if (err < 0) {
+			return err;
+		} else if (err == PROCESS_BPF_EXIT) {
 process_bpf_exit:
-				mark_verifier_state_scratched(env);
-				update_branch_counts(env, env->cur_state);
-				err = pop_stack(env, &prev_insn_idx,
-						&env->insn_idx, pop_log);
-				if (err < 0) {
-					if (err != -ENOENT)
-						return err;
-					break;
-				} else {
-					if (verifier_bug_if(env->cur_state->loop_entry, env,
-							    "broken loop detection"))
-						return -EFAULT;
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
+			mark_verifier_state_scratched(env);
+			update_branch_counts(env, env->cur_state);
+			err = pop_stack(env, &prev_insn_idx, &env->insn_idx,
+					pop_log);
+			if (err < 0) {
+				if (err != -ENOENT)
 					return err;
-
-				env->insn_idx++;
-				sanitize_mark_insn_seen(env);
+				break;
 			} else {
-				verbose(env, "invalid BPF_LD mode\n");
-				return -EINVAL;
+				if (verifier_bug_if(env->cur_state->loop_entry, env,
+						    "broken loop detection"))
+					return -EFAULT;
+				do_print_state = true;
+				continue;
 			}
-		} else {
-			verbose(env, "unknown insn class %d\n", class);
-			return -EINVAL;
 		}
-
-		env->insn_idx++;
+		WARN_ON_ONCE(err);
 	}
 
 	return 0;
-- 
2.49.0


