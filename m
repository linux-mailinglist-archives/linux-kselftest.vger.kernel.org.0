Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFD7794318
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 20:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243598AbjIFSd6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243336AbjIFSdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 14:33:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC8A1732;
        Wed,  6 Sep 2023 11:33:28 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c6cd238e0so888015f8f.0;
        Wed, 06 Sep 2023 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694025207; x=1694630007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUt+dyxz40exkjK9taO3HDdxqeOqcwLVkDTATrnPFLo=;
        b=GI71Z96si3hO1Ew1di7rNz8EJwT8z9//dGuig6WOle3J+Od6GGQBIm/yk1vdmHSCmD
         gYpZXkWqYHCsrzNRmTAw/oB1B+zr0yZqZJYu3v0oCJjHCTtFrEkwnmhtzXkw89h8FG6k
         rJz8C3ZbCApCnLixS5zGu2LWTXEecNd0jxWStt1zY0Vyb4WG68590WxOpBTffsZjGV/g
         N/fI/9dqqkoCFsaDuVrp1/1+9q1SRVfa7bEKrfVa1XzCJw4hVcp8dbGi5kkWAzMe09ot
         BBbUzoCjFoN1GcaEFkOpuJ73igyLTNPfpp+Uqh2m+BVe6F38tRlro8Ke6W4eeD4u2hZI
         uUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694025207; x=1694630007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUt+dyxz40exkjK9taO3HDdxqeOqcwLVkDTATrnPFLo=;
        b=E8sWEA38McI0bJxUgaQpigfvwRAukR7IZUAnab+g8ViFLJ4r2uNDlpPrmRB6bKGDmY
         gdTD0GCtx62CMO9oLVNqC2XGFlplz/Gs0xgPng9p9Ypd2x96AssMNMF5rcdDRu9WgsJZ
         lVUQ+M4QfFeFg/hZo0MJguwH3CFPSsLJp476HywVN4nEYEZuu26AZkCgimZ0Edv9l3mE
         jRmQuo4D3eyQONmRaw875lg9kCtzBTxueKCR6YHFyE58181/6KXX9lR2u+021GTRKJ5O
         6BinMiX3OX9EW4sK1n4RnR7f6u5E6T8JYUwTRdM+R1DO/LV1SO9Gc01M3o8JLC+QaRH5
         keqQ==
X-Gm-Message-State: AOJu0Yx2IX+o9zUhVxDIFT8YJibyIjEumhZRSHmk9abqJZ8Rnard5K5b
        RhYqS/fWmkHxdZo7fr8JFPU=
X-Google-Smtp-Source: AGHT+IFrO5jwdurbEz3PKbgmlCluOb/v9aDMZxmZf4IJcL8LgSRB+3e9NzLDRMKG5Dn7RHUkSuyB1w==
X-Received: by 2002:adf:d4c9:0:b0:313:f38d:555f with SMTP id w9-20020adfd4c9000000b00313f38d555fmr280174wrk.24.1694025206551;
        Wed, 06 Sep 2023 11:33:26 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d4bca000000b003180155493esm21094891wrt.67.2023.09.06.11.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:33:26 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 6/8] arm32, bpf: add support for 64 bit division instruction
Date:   Wed,  6 Sep 2023 18:33:18 +0000
Message-Id: <20230906183320.1959008-7-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230906183320.1959008-1-puranjay12@gmail.com>
References: <20230906183320.1959008-1-puranjay12@gmail.com>
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
 arch/arm/net/bpf_jit_32.c | 119 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 1 deletion(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 91b3294963bc..ff4cd749c2f8 100644
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
@@ -555,6 +585,81 @@ static inline void emit_udivmod(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx, u8 op,
 		emit(ARM_MOV_R(ARM_R0, tmp[1]), ctx);
 }
 
+static inline void emit_udivmod64(const s8 *rd, const s8 *rm, const s8 *rn, struct jit_ctx *ctx,
+				  u8 op, u8 sign)
+{
+	u32 dst;
+
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
+	if (sign) {
+		if (op == BPF_DIV)
+			dst = (u32)jit_sdiv64;
+		else
+			dst = (u32)jit_smod64;
+	} else {
+		if (op == BPF_DIV)
+			dst = (u32)jit_udiv64;
+		else
+			dst = (u32)jit_mod64;
+	}
+
+	emit_mov_i(ARM_IP, dst, ctx);
+	emit_blx_r(ARM_IP, ctx);
+
+	/* Save return value */
+	if (rd[1] != ARM_R0) {
+		emit(ARM_MOV_R(rd[0], ARM_R1), ctx);
+		emit(ARM_MOV_R(rd[1], ARM_R0), ctx);
+	}
+
+	/* Recover {R3, R2} and {R1, R0} from stack if they are not Rd */
+	if (rd[1] != ARM_R0 && rd[1] != ARM_R2) {
+		emit(ARM_POP(BIT(ARM_R0) | BIT(ARM_R1)), ctx);
+		emit(ARM_POP(BIT(ARM_R2) | BIT(ARM_R3)), ctx);
+	} else if (rd[1] != ARM_R0) {
+		emit(ARM_POP(BIT(ARM_R0) | BIT(ARM_R1)), ctx);
+		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
+	} else if (rd[1] != ARM_R2) {
+		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
+		emit(ARM_POP(BIT(ARM_R2) | BIT(ARM_R3)), ctx);
+	} else {
+		emit(ARM_ADD_I(ARM_SP, ARM_SP, 16), ctx);
+	}
+}
+
 /* Is the translated BPF register on stack? */
 static bool is_stacked(s8 reg)
 {
@@ -1578,7 +1683,19 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
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

