Return-Path: <linux-kselftest+bounces-13203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD205927C4F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 19:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA201F243A5
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 17:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE7949635;
	Thu,  4 Jul 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyCUZz8N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33672481CE;
	Thu,  4 Jul 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114393; cv=none; b=Wslgjj9AtWoIPv3ZUCb+36lPbl3jmKdDDyxP7IMETBdI85pcWdZ2xI3qdiTh5hqGgGIiIr7B/eBEfhMkjqEr2qGNBCC/KiwLH/0QBldSqe+PSRhyR5gv4O947vB6JYoUdnmPWW5MWZY6YLfJrlwIkkxgAWMmxd/GSS1YEAsjkVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114393; c=relaxed/simple;
	bh=Segdk090mGftt1pYyroxjdKfPQEmywUaMaTwyyVMAYc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=JPyD4pvJVTCjTaptQvUG0yHx0eCrshkR3uXR/Q9fO/Q4HYglZIEYnJ6qsDb8HcsaWtuw76pKg3kwPeIOWwQlXqKQiVMaCS0AtUNR39Koi1pTnTbqznXHfIWlwxVoqbemUXKN03X/xoTIuNu1Xfrv+nNFwcwXZYPMREAuLrbzpJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyCUZz8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B397FC32781;
	Thu,  4 Jul 2024 17:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720114393;
	bh=Segdk090mGftt1pYyroxjdKfPQEmywUaMaTwyyVMAYc=;
	h=From:To:Subject:Date:From;
	b=UyCUZz8NwlWUj+6qxcP+ICAP+TNJJArskXX3BC+E8ZB9ZPVDh2UIxEd+MziEszkFM
	 qUyvZpQHrGVp1BpN20/v+hoLHtXlWDl5paMmomKmDjx8E6GKaTxvO1+2lxElHYv0g1
	 Zi+lJny+SjPq8HPhCZvfOMFM9KFY3Hglp7U85QkdmXZw4h0upbXpkLqe5w/kbpvpt7
	 We0WWPtF7gK+imuxZLtjhWFi2RaszLVKrBD+CwfAvGi7WezdAwVlOrsDrvBl9dXpa7
	 qlDtlNFkQ50wjqd2SwUcg7G1MSN45D0gijmeE/k9SoqWmDMuZbjYd0TuEb0VjgsJbS
	 bUV/4qrCH6rFw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next] arm64, bpf: Add 12-argument support for bpf trampoline
Date: Thu,  4 Jul 2024 17:32:27 +0000
Message-Id: <20240704173227.130491-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arm64 bpf JIT currently supports attaching the trampoline to
functions with <= 8 arguments. This is because up to 8 arguments can be
passed in registers r0-r7. If there are more than 8 arguments then the
9th and later arguments are passed on the stack, with SP pointing to the
first stacked argument. See aapcs64[1] for more details.

Add the support of storing and restoring arguments passed on the stack
to the arm64 bpf trampoline. This will allow attaching the trampoline to
functions that take 12 arguments.

[1] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#parameter-passing

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c                | 113 +++++++++++++------
 tools/testing/selftests/bpf/DENYLIST.aarch64 |   2 -
 2 files changed, 81 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 751331f5ba90..ebc148596e59 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -30,6 +30,8 @@
 #define TMP_REG_3 (MAX_BPF_JIT_REG + 3)
 #define FP_BOTTOM (MAX_BPF_JIT_REG + 4)
 #define ARENA_VM_START (MAX_BPF_JIT_REG + 5)
+/* Up to eight function arguments are passed in registers r0-r7 */
+#define ARM64_MAX_REG_ARGS 8
 
 #define check_imm(bits, imm) do {				\
 	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
@@ -2001,26 +2003,51 @@ static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
 	}
 }
 
-static void save_args(struct jit_ctx *ctx, int args_off, int nregs)
+static void save_args(struct jit_ctx *ctx, int args_off, int orig_sp_off,
+		      int nargs)
 {
+	const u8 tmp = bpf2a64[TMP_REG_1];
+	int arg_pos;
 	int i;
 
-	for (i = 0; i < nregs; i++) {
-		emit(A64_STR64I(i, A64_SP, args_off), ctx);
+	for (i = 0; i < nargs; i++) {
+		if (i < ARM64_MAX_REG_ARGS) {
+			emit(A64_STR64I(i, A64_SP, args_off), ctx);
+		} else {
+			arg_pos = orig_sp_off + (i - ARM64_MAX_REG_ARGS) * 8;
+			emit(A64_LDR64I(tmp, A64_SP, arg_pos), ctx);
+			emit(A64_STR64I(tmp, A64_SP, args_off), ctx);
+		}
 		args_off += 8;
 	}
 }
 
-static void restore_args(struct jit_ctx *ctx, int args_off, int nregs)
+static void restore_args(struct jit_ctx *ctx, int args_off, int nargs)
 {
 	int i;
 
-	for (i = 0; i < nregs; i++) {
+	for (i = 0; i < nargs; i++) {
 		emit(A64_LDR64I(i, A64_SP, args_off), ctx);
 		args_off += 8;
 	}
 }
 
+static void restore_stack_args(struct jit_ctx *ctx, int args_off, int stk_arg_off,
+			       int nr_stack_args)
+{
+	const u8 tmp = bpf2a64[TMP_REG_1];
+	int arg_pos;
+	int i;
+
+	for (i = ARM64_MAX_REG_ARGS; i < nr_stack_args; i++) {
+		arg_pos = args_off + i * 8;
+		emit(A64_LDR64I(tmp, A64_SP, arg_pos), ctx);
+		emit(A64_STR64I(tmp, A64_SP, stk_arg_off), ctx);
+
+		stk_arg_off += 8;
+	}
+}
+
 /* Based on the x86's implementation of arch_prepare_bpf_trampoline().
  *
  * bpf prog and function entry before bpf trampoline hooked:
@@ -2034,15 +2061,17 @@ static void restore_args(struct jit_ctx *ctx, int args_off, int nregs)
  */
 static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 			      struct bpf_tramp_links *tlinks, void *func_addr,
-			      int nregs, u32 flags)
+			      int nargs, u32 flags)
 {
 	int i;
 	int stack_size;
+	int stk_arg_off;
+	int orig_sp_off;
 	int retaddr_off;
 	int regs_off;
 	int retval_off;
 	int args_off;
-	int nregs_off;
+	int nargs_off;
 	int ip_off;
 	int run_ctx_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
@@ -2052,6 +2081,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	__le32 **branches = NULL;
 
 	/* trampoline stack layout:
+	 * SP + orig_sp_off [ first stack arg   ] if nargs > ARM64_MAX_REG_ARGS
 	 *                  [ parent ip         ]
 	 *                  [ FP                ]
 	 * SP + retaddr_off [ self ip           ]
@@ -2069,14 +2099,23 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	 *                  [ ...               ]
 	 * SP + args_off    [ arg reg 1         ]
 	 *
-	 * SP + nregs_off   [ arg regs count    ]
+	 * SP + nargs_off   [ arg count         ]
 	 *
 	 * SP + ip_off      [ traced function   ] BPF_TRAMP_F_IP_ARG flag
 	 *
 	 * SP + run_ctx_off [ bpf_tramp_run_ctx ]
+	 *
+	 *		    [ stack_argN	]
+	 *		    [ ...		]
+	 * SP + stk_arg_off [ stack_arg1	] BPF_TRAMP_F_CALL_ORIG
 	 */
 
 	stack_size = 0;
+	stk_arg_off = stack_size;
+	/* room for saving arguments passed on stack */
+	if (nargs - ARM64_MAX_REG_ARGS > 0)
+		stack_size += (nargs - ARM64_MAX_REG_ARGS) * 8;
+
 	run_ctx_off = stack_size;
 	/* room for bpf_tramp_run_ctx */
 	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
@@ -2086,13 +2125,13 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		stack_size += 8;
 
-	nregs_off = stack_size;
+	nargs_off = stack_size;
 	/* room for args count */
 	stack_size += 8;
 
 	args_off = stack_size;
 	/* room for args */
-	stack_size += nregs * 8;
+	stack_size += nargs * 8;
 
 	/* room for return value */
 	retval_off = stack_size;
@@ -2110,6 +2149,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	/* return address locates above FP */
 	retaddr_off = stack_size + 8;
 
+	/* original SP position
+	 * stack_size + parent function frame + patched function frame
+	 */
+	orig_sp_off = stack_size + 32;
+
 	/* bpf trampoline may be invoked by 3 instruction types:
 	 * 1. bl, attached to bpf prog or kernel function via short jump
 	 * 2. br, attached to bpf prog or kernel function via long jump
@@ -2135,12 +2179,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		emit(A64_STR64I(A64_R(10), A64_SP, ip_off), ctx);
 	}
 
-	/* save arg regs count*/
-	emit(A64_MOVZ(1, A64_R(10), nregs, 0), ctx);
-	emit(A64_STR64I(A64_R(10), A64_SP, nregs_off), ctx);
+	/* save arg count */
+	emit(A64_MOVZ(1, A64_R(10), nargs, 0), ctx);
+	emit(A64_STR64I(A64_R(10), A64_SP, nargs_off), ctx);
 
-	/* save arg regs */
-	save_args(ctx, args_off, nregs);
+	/* save arguments passed in regs and on the stack */
+	save_args(ctx, args_off, orig_sp_off, nargs);
 
 	/* save callee saved registers */
 	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
@@ -2167,7 +2211,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_args(ctx, args_off, nregs);
+		/* restore arguments that were passed in registers */
+		restore_args(ctx, args_off,
+			     min_t(int, nargs, ARM64_MAX_REG_ARGS));
+		/* restore arguments that were passed on the stack */
+		restore_stack_args(ctx, args_off, stk_arg_off, nargs);
 		/* call original func */
 		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
 		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
@@ -2196,7 +2244,8 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(ctx, args_off, nregs);
+		restore_args(ctx, args_off,
+			     min_t(int, nargs, ARM64_MAX_REG_ARGS));
 
 	/* restore callee saved register x19 and x20 */
 	emit(A64_LDR64I(A64_R(19), A64_SP, regs_off), ctx);
@@ -2228,19 +2277,19 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	return ctx->idx;
 }
 
-static int btf_func_model_nregs(const struct btf_func_model *m)
+static int btf_func_model_nargs(const struct btf_func_model *m)
 {
-	int nregs = m->nr_args;
+	int nargs = m->nr_args;
 	int i;
 
-	/* extra registers needed for struct argument */
+	/* extra registers or stack slots needed for struct argument */
 	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
 		/* The arg_size is at most 16 bytes, enforced by the verifier. */
 		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			nregs += (m->arg_size[i] + 7) / 8 - 1;
+			nargs += (m->arg_size[i] + 7) / 8 - 1;
 	}
 
-	return nregs;
+	return nargs;
 }
 
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
@@ -2251,14 +2300,14 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 		.idx = 0,
 	};
 	struct bpf_tramp_image im;
-	int nregs, ret;
+	int nargs, ret;
 
-	nregs = btf_func_model_nregs(m);
-	/* the first 8 registers are used for arguments */
-	if (nregs > 8)
+	nargs = btf_func_model_nargs(m);
+	/* the first 8 arguments are in registers and others are on stack */
+	if (nargs > MAX_BPF_FUNC_ARGS)
 		return -ENOTSUPP;
 
-	ret = prepare_trampoline(&ctx, &im, tlinks, func_addr, nregs, flags);
+	ret = prepare_trampoline(&ctx, &im, tlinks, func_addr, nargs, flags);
 	if (ret < 0)
 		return ret;
 
@@ -2285,7 +2334,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 				u32 flags, struct bpf_tramp_links *tlinks,
 				void *func_addr)
 {
-	int ret, nregs;
+	int ret, nargs;
 	void *image, *tmp;
 	u32 size = ro_image_end - ro_image;
 
@@ -2302,13 +2351,13 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 		.idx = 0,
 	};
 
-	nregs = btf_func_model_nregs(m);
-	/* the first 8 registers are used for arguments */
-	if (nregs > 8)
+	nargs = btf_func_model_nargs(m);
+	/* the first 8 arguments are in registers and others are on stack */
+	if (nargs > MAX_BPF_FUNC_ARGS)
 		return -ENOTSUPP;
 
 	jit_fill_hole(image, (unsigned int)(ro_image_end - ro_image));
-	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
+	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nargs, flags);
 
 	if (ret > 0 && validate_code(&ctx) < 0) {
 		ret = -EINVAL;
diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 3c7c3e79aa93..0b17bc0dea7a 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -4,8 +4,6 @@ fexit_sleep                                      # The test never returns. The r
 kprobe_multi_bench_attach                        # needs CONFIG_FPROBE
 kprobe_multi_test                                # needs CONFIG_FPROBE
 module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
-fentry_test/fentry_many_args                     # fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524
-fexit_test/fexit_many_args                       # fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524
 tracing_struct/struct_many_args                  # struct_many_args:FAIL:tracing_struct_many_args__attach unexpected error: -524
 fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
-- 
2.40.1


