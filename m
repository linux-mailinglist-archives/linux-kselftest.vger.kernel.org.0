Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3AF61EEC6
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 10:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiKGJYA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 04:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiKGJXw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 04:23:52 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DC5167CF;
        Mon,  7 Nov 2022 01:23:51 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5QlM1vJpzRp50;
        Mon,  7 Nov 2022 17:23:43 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 17:23:49 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 17:23:48 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>,
        <illusionist.neo@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <mykolal@fb.com>, <shuah@kernel.org>,
        <benjamin.tissoires@redhat.com>, <memxor@gmail.com>,
        <asavkov@redhat.com>, <delyank@fb.com>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH bpf v2 4/5] bpf: Add kernel function call support in 32-bit ARM for EABI
Date:   Mon, 7 Nov 2022 17:20:31 +0800
Message-ID: <20221107092032.178235-5-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20221107092032.178235-1-yangjihong1@huawei.com>
References: <20221107092032.178235-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch adds kernel function call support to 32-bit ARM bpf jit for
EABI.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 arch/arm/net/bpf_jit_32.c | 142 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 6a1c9fca5260..9c0e1c22dc37 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1337,6 +1337,130 @@ static void build_epilogue(struct jit_ctx *ctx)
 #endif
 }
 
+/*
+ * Input parameters of function in 32-bit ARM architecture:
+ * The first four word-sized parameters passed to a function will be
+ * transferred in registers R0-R3. Sub-word sized arguments, for example,
+ * char, will still use a whole register.
+ * Arguments larger than a word will be passed in multiple registers.
+ * If more arguments are passed, the fifth and subsequent words will be passed
+ * on the stack.
+ *
+ * The first for args of a function will be considered for
+ * putting into the 32bit register R1, R2, R3 and R4.
+ *
+ * Two 32bit registers are used to pass a 64bit arg.
+ *
+ * For example,
+ * void foo(u32 a, u32 b, u32 c, u32 d, u32 e):
+ *      u32 a: R0
+ *      u32 b: R1
+ *      u32 c: R2
+ *      u32 d: R3
+ *      u32 e: stack
+ *
+ * void foo(u64 a, u32 b, u32 c, u32 d):
+ *      u64 a: R0 (lo32) R1 (hi32)
+ *      u32 b: R2
+ *      u32 c: R3
+ *      u32 d: stack
+ *
+ * void foo(u32 a, u64 b, u32 c, u32 d):
+ *       u32 a: R0
+ *       u64 b: R2 (lo32) R3 (hi32)
+ *       u32 c: stack
+ *       u32 d: stack
+ *
+ * void foo(u32 a, u32 b, u64 c, u32 d):
+ *       u32 a: R0
+ *       u32 b: R1
+ *       u64 c: R2 (lo32) R3 (hi32)
+ *       u32 d: stack
+ *
+ * void foo(u64 a, u64 b):
+ *       u64 a: R0 (lo32) R1 (hi32)
+ *       u64 b: R2 (lo32) R3 (hi32)
+ *
+ * The return value will be stored in the R0 (and R1 for 64bit value).
+ *
+ * For example,
+ * u32 foo(u32 a, u32 b, u32 c):
+ *      return value: R0
+ *
+ * u64 foo(u32 a, u32 b, u32 c):
+ *      return value: R0 (lo32) R1 (hi32)
+ *
+ * The above is for AEABI only, OABI does not support this function.
+ */
+static int emit_kfunc_call(const struct bpf_insn *insn, struct jit_ctx *ctx, const u32 func)
+{
+	int i;
+	const struct btf_func_model *fm;
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	const u8 arg_regs[] = { ARM_R0, ARM_R1, ARM_R2, ARM_R3 };
+	int nr_arg_regs = ARRAY_SIZE(arg_regs);
+	int arg_regs_idx = 0, stack_off = 0;
+	const s8 *rd;
+	s8 rt;
+
+	if (!IS_ENABLED(CONFIG_AEABI)) {
+		pr_info_once("kfunc call only support for AEABI in 32-bit arm\n");
+		return -EINVAL;
+	}
+
+	fm = bpf_jit_find_kfunc_model(ctx->prog, insn);
+	if (!fm)
+		return -EINVAL;
+
+	for (i = 0; i < fm->nr_args; i++) {
+		if (fm->arg_size[i] > sizeof(u32)) {
+			rd = arm_bpf_get_reg64(bpf2a32[BPF_REG_1 + i], tmp, ctx);
+
+			if (arg_regs_idx + 1 < nr_arg_regs) {
+				/*
+				 * AAPCS states:
+				 * A double-word sized type is passed in two
+				 * consecutive registers (e.g., r0 and r1, or
+				 * r2 and r3). The content of the registers is
+				 * as if the value had been loaded from memory
+				 * representation with a single LDM instruction.
+				 */
+				if (arg_regs_idx & 1)
+					arg_regs_idx++;
+
+				emit(ARM_MOV_R(arg_regs[arg_regs_idx++], rd[1]), ctx);
+				emit(ARM_MOV_R(arg_regs[arg_regs_idx++], rd[0]), ctx);
+			} else {
+				stack_off = ALIGN(stack_off, STACK_ALIGNMENT);
+
+				if (__LINUX_ARM_ARCH__ >= 6 ||
+				    ctx->cpu_architecture >= CPU_ARCH_ARMv5TE) {
+					emit(ARM_STRD_I(rd[1], ARM_SP, stack_off), ctx);
+				} else {
+					emit(ARM_STR_I(rd[1], ARM_SP, stack_off), ctx);
+					emit(ARM_STR_I(rd[0], ARM_SP, stack_off), ctx);
+				}
+
+				stack_off += 8;
+			}
+		} else {
+			rt = arm_bpf_get_reg32(bpf2a32[BPF_REG_1 + i][1], tmp[1], ctx);
+
+			if (arg_regs_idx  < nr_arg_regs) {
+				emit(ARM_MOV_R(arg_regs[arg_regs_idx++], rt), ctx);
+			} else {
+				emit(ARM_STR_I(rt, ARM_SP, stack_off), ctx);
+				stack_off += 4;
+			}
+		}
+	}
+
+	emit_a32_mov_i(tmp[1], func, ctx);
+	emit_blx_r(tmp[1], ctx);
+
+	return 0;
+}
+
 /*
  * Convert an eBPF instruction to native instruction, i.e
  * JITs an eBPF instruction.
@@ -1603,6 +1727,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_LDX | BPF_MEM | BPF_H:
 	case BPF_LDX | BPF_MEM | BPF_B:
 	case BPF_LDX | BPF_MEM | BPF_DW:
+	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
+	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
+	case BPF_LDX | BPF_PROBE_MEM | BPF_B:
+	case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
 		rn = arm_bpf_get_reg32(src_lo, tmp2[1], ctx);
 		emit_ldx_r(dst, rn, off, ctx, BPF_SIZE(code));
 		break;
@@ -1785,6 +1913,16 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		const s8 *r5 = bpf2a32[BPF_REG_5];
 		const u32 func = (u32)__bpf_call_base + (u32)imm;
 
+		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
+			int err;
+
+			err = emit_kfunc_call(insn, ctx, func);
+
+			if (err)
+				return err;
+			break;
+		}
+
 		emit_a32_mov_r64(true, r0, r1, ctx);
 		emit_a32_mov_r64(true, r1, r2, ctx);
 		emit_push_r64(r5, ctx);
@@ -2022,3 +2160,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	return prog;
 }
 
+bool bpf_jit_supports_kfunc_call(void)
+{
+	return true;
+}
-- 
2.30.GIT

