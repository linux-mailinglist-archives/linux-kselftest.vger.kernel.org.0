Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAC87930A5
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 23:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbjIEVGg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 17:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjIEVGd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 17:06:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC11BE;
        Tue,  5 Sep 2023 14:06:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-313e742a787so171609f8f.1;
        Tue, 05 Sep 2023 14:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693947988; x=1694552788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWKUesTF+BrNjh0dTh/L0DSFooJ4GIvBP6Q2JRy2+Xg=;
        b=bJmxoI9Hs/dg8+ypLEPWY63XeQ1OTzjCYQwC6OuTL6hfJc+duIL6z915vt3yBp5pwj
         QnbKzu51bww1Dpn5sKhr7oDaMRWA4Itu3KajZg/5X0pUjIi2GYGMMmswkcgfBhY3CSlM
         0u07PsmW7oinOCsa0WyCX9ZLUcCQda9QZQ627BXyLaJCL2xD652b6AIfkSpUpB1QoMca
         2dDThrPBX7ilx+nR1bHe8+Uv989PxaABm5Y90GEjinQnOytKvDIiJ/JiNuy57hRHhTvA
         vb57d8WJYF1xSLEV4KAUOgPsodyvOCUmmh8HAn08s4n6y1IBo2PxTA+tPzRPAx3bJhij
         80uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693947988; x=1694552788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWKUesTF+BrNjh0dTh/L0DSFooJ4GIvBP6Q2JRy2+Xg=;
        b=dOz9AHOOFAvPaPqkzEC5mRWViuIX1fOa4r+fcatQ5lNFgCELR+mBaSMIgGj/jobwkJ
         aesNw+xa9rCWV/6T/iNhVquHLNo5e6iLKChZlcpczxhnvFYIVHi8eQEgCr+XHXFtOYur
         tvU+a+wqn87UhsxARulpm+tQ/j0zarIpyqG2LFmsB1CQqdulFBetqJ1fRjwQGBRvf3VK
         8pQWEiI7XsDWMfw13NSAfkx4KJUcm/ue3lAnRxs+Q4cAI77hRkZxWoLjsTuKmgKIbhFp
         j7Y7xFst91SiBaxiyp60awqU3AJxwSMV+6ykRd8n/ZHRTEfBAeTNPYhG25UJ/WtGR49m
         7d7Q==
X-Gm-Message-State: AOJu0Yw/BjYcPIDJZm1czCQWb9o6SoE8IB62d60sce4uSKnB0VKNnSXY
        PHvNeTxeaGrnjNjpwBe5r4k=
X-Google-Smtp-Source: AGHT+IESSA+3HygCa80TX41lXZO/2NNhxU6oMx6XtNVkhCvcpemyEsoQFuo+IZ6mMef2bFGCKwZ+2A==
X-Received: by 2002:adf:e7c7:0:b0:319:789f:fcda with SMTP id e7-20020adfe7c7000000b00319789ffcdamr801612wrn.9.1693947988287;
        Tue, 05 Sep 2023 14:06:28 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5012000000b00317b063590fsm18427672wrt.55.2023.09.05.14.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:06:28 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     puranjay12@gmail.com
Subject: [PATCH bpf-next 6/8] arm32, bpf: add support for 64 bit division instruction
Date:   Tue,  5 Sep 2023 21:06:19 +0000
Message-Id: <20230905210621.1711859-7-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230905210621.1711859-1-puranjay12@gmail.com>
References: <20230905210621.1711859-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ARM32 doesn't have instructions to do 64-bit/64-bit divisions. So, to
implement the following instructions:
BPF_ALU64 | BPF_DIV
BPF_ALU64 | BPF_MOD
BPF_ALU64 | BPF_SDIV
BPF_ALU64 | BPF_SMOD

We implement the above instructions by doing function calls to div64_u64()
and div64_u64_rem() for unsigned division/mod and calls to div64_s64()
for signed division/mod.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 107 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index f580ecf75710..761056db964f 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -2,6 +2,7 @@
 /*
  * Just-In-Time compiler for eBPF filters on 32bit ARM
  *
+ * Copyright (c) 2023 Puranjay Mohan <puranjay12@gmail.com>
  * Copyright (c) 2017 Shubham Bansal <illusionist.neo@gmail.com>
  * Copyright (c) 2011 Mircea Gherzan <mgherzan@gmail.com>
  */
@@ -15,6 +16,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/if_vlan.h>
+#include <linux/math64.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hwcap.h>
@@ -238,6 +240,34 @@ static s32 jit_smod32(s32 dividend, s32 divisor)
 	return dividend % divisor;
 }
 
+/* Wrappers for 64-bit div/mod */
+static u64 jit_udiv64(u64 dividend, u64 divisor)
+{
+	return div64_u64(dividend, divisor);
+}
+
+static u64 jit_mod64(u64 dividend, u64 divisor)
+{
+	u64 rem;
+
+	div64_u64_rem(dividend, divisor, &rem);
+	return rem;
+}
+
+static s64 jit_sdiv64(s64 dividend, s64 divisor)
+{
+	return div64_s64(dividend, divisor);
+}
+
+static s64 jit_smod64(s64 dividend, s64 divisor)
+{
+	u64 q;
+
+	q = div64_s64(dividend, divisor);
+
+	return dividend - q * divisor;
+}
+
 static inline void _emit(int cond, u32 inst, struct jit_ctx *ctx)
 {
 	inst |= (cond << 28);
@@ -547,6 +577,69 @@ static inline void emit_udivmod(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx, u8 op,
 		emit(ARM_MOV_R(ARM_R0, tmp[1]), ctx);
 }
 
+static inline void emit_udivmod64(const s8 *rd, const s8 *rm, const s8 *rn, struct jit_ctx *ctx,
+				  u8 op, u8 sign)
+{
+	/* Push caller-saved registers on stack */
+	emit(ARM_PUSH(CALLER_MASK), ctx);
+
+	/*
+	 * As we are implementing 64-bit div/mod as function calls, We need to put the dividend in
+	 * R0-R1 and the divisor in R2-R3. As we have already pushed these registers on the stack,
+	 * we can recover them later after returning from the function call.
+	 */
+	if (rm[1] != ARM_R0 || rn[1] != ARM_R2) {
+		/*
+		 * Move Rm to {R1, R0} if it is not already there.
+		 */
+		if (rm[1] != ARM_R0) {
+			if (rn[1] == ARM_R0)
+				emit(ARM_PUSH(BIT(ARM_R0) | BIT(ARM_R1)), ctx);
+			emit(ARM_MOV_R(ARM_R1, rm[0]), ctx);
+			emit(ARM_MOV_R(ARM_R0, rm[1]), ctx);
+			if (rn[1] == ARM_R0) {
+				emit(ARM_POP(BIT(ARM_R2) | BIT(ARM_R3)), ctx);
+				goto cont;
+			}
+		}
+		/*
+		 * Move Rn to {R3, R2} if it is not already there.
+		 */
+		if (rn[1] != ARM_R2) {
+			emit(ARM_MOV_R(ARM_R3, rn[0]), ctx);
+			emit(ARM_MOV_R(ARM_R2, rn[1]), ctx);
+		}
+	}
+
+cont:
+
+	/* Call appropriate function */
+	if (sign)
+		emit_mov_i(ARM_IP, op == BPF_DIV ? (u32)jit_sdiv64 : (u32)jit_smod64, ctx);
+	else
+		emit_mov_i(ARM_IP, op == BPF_DIV ? (u32)jit_udiv64 : (u32)jit_mod64, ctx);
+
+	emit_blx_r(ARM_IP, ctx);
+
+	/* Save return value */
+	if (rd[1] != ARM_R0) {
+		emit(ARM_MOV_R(rd[0], ARM_R1), ctx);
+		emit(ARM_MOV_R(rd[1], ARM_R0), ctx);
+	}
+
+	/* Recover {R1, R0} from stack if it is not Rd */
+	if (rd[1] != ARM_R0)
+		emit(ARM_POP(BIT(ARM_R0) | BIT(ARM_R1)), ctx);
+	else
+		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
+
+	/* Recover {R3, R2} from stack if it is not Rd */
+	if (rd[1] != ARM_R2)
+		emit(ARM_POP(BIT(ARM_R2) | BIT(ARM_R3)), ctx);
+	else
+		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
+}
+
 /* Is the translated BPF register on stack? */
 static bool is_stacked(s8 reg)
 {
@@ -1569,7 +1662,19 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU64 | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
-		goto notyet;
+		rd = arm_bpf_get_reg64(dst, tmp2, ctx);
+		switch (BPF_SRC(code)) {
+		case BPF_X:
+			rs = arm_bpf_get_reg64(src, tmp, ctx);
+			break;
+		case BPF_K:
+			rs = tmp;
+			emit_a32_mov_se_i64(is64, rs, imm, ctx);
+			break;
+		}
+		emit_udivmod64(rd, rd, rs, ctx, BPF_OP(code), off);
+		arm_bpf_put_reg64(dst, rd, ctx);
+		break;
 	/* dst = dst << imm */
 	/* dst = dst >> imm */
 	/* dst = dst >> imm (signed) */
-- 
2.39.2

