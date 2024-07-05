Return-Path: <linux-kselftest+bounces-13234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0352928911
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 14:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9A3B20FEC
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 12:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940C214A09A;
	Fri,  5 Jul 2024 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8lbQvje"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6216D14C58A;
	Fri,  5 Jul 2024 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184044; cv=none; b=JCjGoqfmo+Y+LfN/rtDqzctMtz2INVyekr20NIx+OPb0oeCvKDJSCu8HpRtjzLQ5y5D05yun6tBuK4I8UvNVPcs0yTRdX2aTRY91scKCmJAp58hWN8PR0N5eX/bat/eKUqWtH7gv6AN1dlKaD4F0tdoNtYAqN904itukYObMIII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184044; c=relaxed/simple;
	bh=l3D9aXXfS+OYSz76Jh5LjpLoa9dPUothg4uhH9Ht+E4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=cA8qmIwJ48rHnVoHD8VY+G40IjFlFow3NakEgl+hTX/ZrqGIedafjkXo8iPfI6FhO9s8bKikTIQE3SC+ORZTzs0sjFrQmOH3qNS8dmLTWA/0+UJkUOWf3xyh3l0H+pF9J2eTSptFCJx99kqc8HEM0jA26Ro4vALtsocHuvHaN9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8lbQvje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885C1C116B1;
	Fri,  5 Jul 2024 12:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720184043;
	bh=l3D9aXXfS+OYSz76Jh5LjpLoa9dPUothg4uhH9Ht+E4=;
	h=From:To:Subject:Date:From;
	b=o8lbQvjeeryHd5wWaa2uoTiTnkU5cFoo/zS7FE1tHrh6HYvCVb+r3YDSGH1FJdaH8
	 fUqDLW6T/49hPLJrlhnCCYcuZO38zGbux+XBvUS55XxLmtIqfipiuCHtrz8D7yh3m2
	 jI6MmwEaJuJpYmTfM5/5/UUURcZcb4uP8olCMbNLesrOU6aBpmu02nNzQ/BCeGrC9G
	 O/OkEHZ49fN0U84Iz4V6NWcS6hdZTSXC0KXm3S+gNlKIhPRMZtYgb4XQDkw0bkbqno
	 UBlVQCpaeMkNJ7Dzf2693hEmB8uol+5OEySE17rWZLNZNFYQs72221p3Rwj68DKBGZ
	 +qbHQSFXQyYSg==
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
Subject: [PATCH bpf-next v2] arm64, bpf: Add 12-argument support for bpf trampoline
Date: Fri,  5 Jul 2024 12:53:36 +0000
Message-Id: <20240705125336.46820-1-puranjay@kernel.org>
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

If the 8th argument is a structure of size > 8B, then it is passed fully
on stack and r7 is not used for passing any argument. If there is a 9th
argument, it will be passed on the stack, even though r7 is available.

Add the support of storing and restoring arguments passed on the stack
to the arm64 bpf trampoline. This will allow attaching the trampoline to
functions that take up to 12 arguments.

[1] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#parameter-passing

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
Changes in V1 -> V2:
V1: https://lore.kernel.org/all/20240704173227.130491-1-puranjay@kernel.org/
- Fixed the argument handling for composite types (structs)
---
 arch/arm64/net/bpf_jit_comp.c                | 139 ++++++++++++++-----
 tools/testing/selftests/bpf/DENYLIST.aarch64 |   3 -
 2 files changed, 107 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 751331f5ba90..063bf5e11fc6 100644
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
+		      int nargs, int nreg_args)
 {
+	const u8 tmp = bpf2a64[TMP_REG_1];
+	int arg_pos;
 	int i;
 
-	for (i = 0; i < nregs; i++) {
-		emit(A64_STR64I(i, A64_SP, args_off), ctx);
+	for (i = 0; i < nargs; i++) {
+		if (i < nreg_args) {
+			emit(A64_STR64I(i, A64_SP, args_off), ctx);
+		} else {
+			arg_pos = orig_sp_off + (i - nreg_args) * 8;
+			emit(A64_LDR64I(tmp, A64_SP, arg_pos), ctx);
+			emit(A64_STR64I(tmp, A64_SP, args_off), ctx);
+		}
 		args_off += 8;
 	}
 }
 
-static void restore_args(struct jit_ctx *ctx, int args_off, int nregs)
+static void restore_args(struct jit_ctx *ctx, int args_off, int nreg_args)
 {
 	int i;
 
-	for (i = 0; i < nregs; i++) {
+	for (i = 0; i < nreg_args; i++) {
 		emit(A64_LDR64I(i, A64_SP, args_off), ctx);
 		args_off += 8;
 	}
 }
 
+static void restore_stack_args(struct jit_ctx *ctx, int args_off, int stk_arg_off,
+			       int nargs, int nreg_args)
+{
+	const u8 tmp = bpf2a64[TMP_REG_1];
+	int arg_pos;
+	int i;
+
+	for (i = nreg_args; i < nargs; i++) {
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
+			      int nargs, int nreg_args, u32 flags)
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
+	 * SP + orig_sp_off [ first stack arg   ] if nargs > 8
 	 *                  [ parent ip         ]
 	 *                  [ FP                ]
 	 * SP + retaddr_off [ self ip           ]
@@ -2069,14 +2099,24 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
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
+	if ((flags & BPF_TRAMP_F_CALL_ORIG) && (nargs - nreg_args > 0)) {
+		/* room for saving arguments passed on stack */
+		stack_size += (nargs - nreg_args) * 8;
+	}
+
 	run_ctx_off = stack_size;
 	/* room for bpf_tramp_run_ctx */
 	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
@@ -2086,13 +2126,13 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
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
@@ -2110,6 +2150,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
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
@@ -2135,12 +2180,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		emit(A64_STR64I(A64_R(10), A64_SP, ip_off), ctx);
 	}
 
-	/* save arg regs count*/
-	emit(A64_MOVZ(1, A64_R(10), nregs, 0), ctx);
-	emit(A64_STR64I(A64_R(10), A64_SP, nregs_off), ctx);
+	/* save argument count */
+	emit(A64_MOVZ(1, A64_R(10), nargs, 0), ctx);
+	emit(A64_STR64I(A64_R(10), A64_SP, nargs_off), ctx);
 
-	/* save arg regs */
-	save_args(ctx, args_off, nregs);
+	/* save arguments passed in regs and on the stack */
+	save_args(ctx, args_off, orig_sp_off, nargs, nreg_args);
 
 	/* save callee saved registers */
 	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
@@ -2167,7 +2212,10 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_args(ctx, args_off, nregs);
+		/* restore arguments that were passed in registers */
+		restore_args(ctx, args_off, nreg_args);
+		/* restore arguments that were passed on the stack */
+		restore_stack_args(ctx, args_off, stk_arg_off, nargs, nreg_args);
 		/* call original func */
 		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
 		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
@@ -2196,7 +2244,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(ctx, args_off, nregs);
+		restore_args(ctx, args_off, nreg_args);
 
 	/* restore callee saved register x19 and x20 */
 	emit(A64_LDR64I(A64_R(19), A64_SP, regs_off), ctx);
@@ -2228,19 +2276,42 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
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
+}
+
+/* get the count of the regs that are used to pass arguments */
+static int btf_func_model_nreg_args(const struct btf_func_model *m)
+{
+	int nargs = m->nr_args;
+	int nreg_args = 0;
+	int i;
+
+	for (i = 0; i < nargs; i++) {
+		/* The arg_size is at most 16 bytes, enforced by the verifier. */
+		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
+			/* struct members are all in the registers or all
+			 * on the stack.
+			 */
+			if (nreg_args + ((m->arg_size[i] + 7) / 8 - 1) > 7)
+				break;
+			nreg_args += (m->arg_size[i] + 7) / 8 - 1;
+		}
+		nreg_args++;
+	}
+
+	return (nreg_args > ARM64_MAX_REG_ARGS ? ARM64_MAX_REG_ARGS : nreg_args);
 }
 
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
@@ -2251,14 +2322,16 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 		.idx = 0,
 	};
 	struct bpf_tramp_image im;
-	int nregs, ret;
+	int nargs, nreg_args, ret;
 
-	nregs = btf_func_model_nregs(m);
-	/* the first 8 registers are used for arguments */
-	if (nregs > 8)
+	nargs = btf_func_model_nargs(m);
+	if (nargs > MAX_BPF_FUNC_ARGS)
 		return -ENOTSUPP;
 
-	ret = prepare_trampoline(&ctx, &im, tlinks, func_addr, nregs, flags);
+	nreg_args = btf_func_model_nreg_args(m);
+
+	ret = prepare_trampoline(&ctx, &im, tlinks, func_addr, nargs, nreg_args,
+				 flags);
 	if (ret < 0)
 		return ret;
 
@@ -2285,7 +2358,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 				u32 flags, struct bpf_tramp_links *tlinks,
 				void *func_addr)
 {
-	int ret, nregs;
+	int ret, nargs, nreg_args;
 	void *image, *tmp;
 	u32 size = ro_image_end - ro_image;
 
@@ -2302,13 +2375,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 		.idx = 0,
 	};
 
-	nregs = btf_func_model_nregs(m);
-	/* the first 8 registers are used for arguments */
-	if (nregs > 8)
+	nargs = btf_func_model_nargs(m);
+	if (nargs > MAX_BPF_FUNC_ARGS)
 		return -ENOTSUPP;
 
+	nreg_args = btf_func_model_nreg_args(m);
+
 	jit_fill_hole(image, (unsigned int)(ro_image_end - ro_image));
-	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
+	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nargs, nreg_args,
+				 flags);
 
 	if (ret > 0 && validate_code(&ctx) < 0) {
 		ret = -EINVAL;
diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 3c7c3e79aa93..e865451e90d2 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -4,9 +4,6 @@ fexit_sleep                                      # The test never returns. The r
 kprobe_multi_bench_attach                        # needs CONFIG_FPROBE
 kprobe_multi_test                                # needs CONFIG_FPROBE
 module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
-fentry_test/fentry_many_args                     # fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524
-fexit_test/fexit_many_args                       # fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524
-tracing_struct/struct_many_args                  # struct_many_args:FAIL:tracing_struct_many_args__attach unexpected error: -524
 fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
-- 
2.40.1


