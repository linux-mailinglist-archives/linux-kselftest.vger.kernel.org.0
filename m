Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C057279431A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 20:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbjIFSeC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 14:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbjIFSdv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 14:33:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CF2172E;
        Wed,  6 Sep 2023 11:33:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401ec23be82so2196515e9.0;
        Wed, 06 Sep 2023 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694025206; x=1694630006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kq3pXZpNJyYGAYAUopCV9gdOqNzHaZbuqwhwG2crWsI=;
        b=WuqAcQRbPO8UhaHEysWowUll6bopH7C7X8a6imJk8erBwdOgOLwJI5/HLvfiDrbANB
         ZmRPHGd4aKm3FVfd2EnFTau9b3LgZXUkJMtA8o7g2snHJ9dBXP/3DtjbGaT3EgIUXVyf
         hBGyDD8gXq065+hKYVmuL8sqMuRfLVcosWkr+ti94gEqGlijZGLJ8fHgHhuCTMt3c6Ae
         M/jWeDsN8FtXlVCPvsj+F43leZKrO0lJdfFLuqplJ8JYAk6WQXmCzfKGANxenoUrTrJh
         d91H0jY7Myq5zJX7aSH1Pr8YWywpUra0STirYQ7skziQQTgtYBfMAkV6RBO+dKwsAyR1
         SA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694025206; x=1694630006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kq3pXZpNJyYGAYAUopCV9gdOqNzHaZbuqwhwG2crWsI=;
        b=hlyr45YmpsEQxJxUKK87qgjhj3Ms42cQi424Elrw38gT3Xe/7fojCGEt87RRfPkMaH
         a3TFtuoj/QwkZujjc7UqfXqj1w42Izn1iUROGs0PrC0TbJrF040xEUoBVabkby6AvOIr
         ufcNxjQYVlmKvDA0PK+jpHGcbO0uXBecghhIWWmkQ9c64Hy8B9phgVBTu+gNMxwHJByF
         ew49ZGXSfhsu3v3oe7PlSNu9utVuzyRQNe28Wu+yhBRZ4YjidR1yBaNPYUOni8rty8dJ
         hbe+HqndJv9dLT8YX29xSnFaMeaKKb5z6ip6BzKO9Wt3HwFu5w5K0TfnhY3TaNGY5rdr
         B/Ow==
X-Gm-Message-State: AOJu0YzXAsTRsXMm3ldrIsvMpuas35Dcrg7OMXwlBXfppNb/6F5Ooyw7
        vXOuZRBzw/YbnkYYOzFMLbI=
X-Google-Smtp-Source: AGHT+IHPpd768AGpl3xNi8VxcpPkQvuVn8cQhmAVI1ewq9Ri6g8wz065Fk4L5UlELRJYV4BgCn7stQ==
X-Received: by 2002:a05:600c:2409:b0:401:bd2e:49fc with SMTP id 9-20020a05600c240900b00401bd2e49fcmr3017577wmp.24.1694025205748;
        Wed, 06 Sep 2023 11:33:25 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d4bca000000b003180155493esm21094891wrt.67.2023.09.06.11.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:33:25 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 5/8] arm32, bpf: add support for 32-bit signed division
Date:   Wed,  6 Sep 2023 18:33:17 +0000
Message-Id: <20230906183320.1959008-6-puranjay12@gmail.com>
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

The cpuv4 added a new BPF_SDIV instruction that does signed division.
The encoding is similar to BPF_DIV but BPF_SDIV sets offset=1.

ARM32 already supports 32-bit BPF_DIV which can be easily extended to
support BPF_SDIV as ARM32 has the SDIV instruction. When the CPU is not
ARM-v7, we implement that SDIV/SMOD with the function call similar to
the implementation of DIV/MOD.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 38 ++++++++++++++++++++++++++++++--------
 arch/arm/net/bpf_jit_32.h |  2 ++
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index f837db5c71b1..91b3294963bc 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -228,6 +228,16 @@ static u32 jit_mod32(u32 dividend, u32 divisor)
 	return dividend % divisor;
 }
 
+static s32 jit_sdiv32(s32 dividend, s32 divisor)
+{
+	return dividend / divisor;
+}
+
+static s32 jit_smod32(s32 dividend, s32 divisor)
+{
+	return dividend % divisor;
+}
+
 static inline void _emit(int cond, u32 inst, struct jit_ctx *ctx)
 {
 	inst |= (cond << 28);
@@ -477,17 +487,18 @@ static inline int epilogue_offset(const struct jit_ctx *ctx)
 	return to - from - 2;
 }
 
-static inline void emit_udivmod(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx, u8 op)
+static inline void emit_udivmod(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx, u8 op, u8 sign)
 {
 	const int exclude_mask = BIT(ARM_R0) | BIT(ARM_R1);
 	const s8 *tmp = bpf2a32[TMP_REG_1];
+	u32 dst;
 
 #if __LINUX_ARM_ARCH__ == 7
 	if (elf_hwcap & HWCAP_IDIVA) {
-		if (op == BPF_DIV)
-			emit(ARM_UDIV(rd, rm, rn), ctx);
-		else {
-			emit(ARM_UDIV(ARM_IP, rm, rn), ctx);
+		if (op == BPF_DIV) {
+			emit(sign ? ARM_SDIV(rd, rm, rn) : ARM_UDIV(rd, rm, rn), ctx);
+		} else {
+			emit(sign ? ARM_SDIV(ARM_IP, rm, rn) : ARM_UDIV(ARM_IP, rm, rn), ctx);
 			emit(ARM_MLS(rd, rn, ARM_IP, rm), ctx);
 		}
 		return;
@@ -515,8 +526,19 @@ static inline void emit_udivmod(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx, u8 op)
 	emit(ARM_PUSH(CALLER_MASK & ~exclude_mask), ctx);
 
 	/* Call appropriate function */
-	emit_mov_i(ARM_IP, op == BPF_DIV ?
-		   (u32)jit_udiv32 : (u32)jit_mod32, ctx);
+	if (sign) {
+		if (op == BPF_DIV)
+			dst = (u32)jit_sdiv32;
+		else
+			dst = (u32)jit_smod32;
+	} else {
+		if (op == BPF_DIV)
+			dst = (u32)jit_udiv32;
+		else
+			dst = (u32)jit_mod32;
+	}
+
+	emit_mov_i(ARM_IP, dst, ctx);
 	emit_blx_r(ARM_IP, ctx);
 
 	/* Restore caller-saved registers from stack */
@@ -1547,7 +1569,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			rt = src_lo;
 			break;
 		}
-		emit_udivmod(rd_lo, rd_lo, rt, ctx, BPF_OP(code));
+		emit_udivmod(rd_lo, rd_lo, rt, ctx, BPF_OP(code), off);
 		arm_bpf_put_reg32(dst_lo, rd_lo, ctx);
 		if (!ctx->prog->aux->verifier_zext)
 			emit_a32_mov_i(dst_hi, 0, ctx);
diff --git a/arch/arm/net/bpf_jit_32.h b/arch/arm/net/bpf_jit_32.h
index 79c7373fadce..438f0e1f91a0 100644
--- a/arch/arm/net/bpf_jit_32.h
+++ b/arch/arm/net/bpf_jit_32.h
@@ -139,6 +139,7 @@
 #define ARM_INST_TST_I		0x03100000
 
 #define ARM_INST_UDIV		0x0730f010
+#define ARM_INST_SDIV		0x0710f010
 
 #define ARM_INST_UMULL		0x00800090
 
@@ -267,6 +268,7 @@
 #define ARM_TST_I(rn, imm)	_AL3_I(ARM_INST_TST, 0, rn, imm)
 
 #define ARM_UDIV(rd, rn, rm)	(ARM_INST_UDIV | (rd) << 16 | (rn) | (rm) << 8)
+#define ARM_SDIV(rd, rn, rm)	(ARM_INST_SDIV | (rd) << 16 | (rn) | (rm) << 8)
 
 #define ARM_UMULL(rd_lo, rd_hi, rn, rm)	(ARM_INST_UMULL | (rd_hi) << 16 \
 					 | (rd_lo) << 12 | (rm) << 8 | rn)
-- 
2.39.2

