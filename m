Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCD87930A3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 23:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbjIEVGf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 17:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240708AbjIEVGd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 17:06:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCC6B3;
        Tue,  5 Sep 2023 14:06:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31c6cd238e0so181538f8f.0;
        Tue, 05 Sep 2023 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693947987; x=1694552787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58eTHaDYZzO5ySLrzOeJSkgTs9llcVOEi3kOQ2Fo+FM=;
        b=TOGMUJaq41otyBk1ntWFhoQGd7/93LcA9Q3LS07AhRLm815fhN0h7BsefovrUx8V7t
         exDTCODqTQj16a5/FYGmivD9w2C7widul/75+prpKBLo0Af+wmh2MB1ZpXmfGu3sJAMv
         N7hbHYvKOczTSerjSNpf9f2zP8C3hK9OvQ6gm3Synbb639h95g1VnahqzNM29Ez1L6r6
         6qnpEDp1HYqx+Bpk/bKKpcTPCI0z1mTeWbHHdTZIGEm1EIhbmjs2dtdrkGkTlg4/7crc
         zjsHChi23LZgvBr/ALBnVd1z1boYeDLzuC/MtJqlZITqfoF5hKjZkuT6MVx/S7fIbdaS
         dJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693947987; x=1694552787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58eTHaDYZzO5ySLrzOeJSkgTs9llcVOEi3kOQ2Fo+FM=;
        b=Q2YmTwLrqheNwV/ki1bvq5/7wb9HBlirhAcbGjaLdjct+nRT0KKc4kQ4oHlIWsTs+1
         xfV0HD5/Q1JciQwpYBADhUbxFB7HOk6XSyK8yh+bo5PKt9I9RtDw8eus0hMobM5ymWTf
         rk/mJjIcQU+Npi+C7HZ/bYHenOg9Lx00sA0+gB/rmF2kODZ65d3P+qrlMCVLpfa5TnnD
         cz4nr+g+9zpefdWnIYF+Y8Z53WMcUxRltcYHs6mD1Mdy5tBYBuFSaMCoa9MCivrnOmmB
         QElF/mLiJ3XLtq6+tq0Ki3fCOwQNzC776VvKZqt+hJkV+z4t73Cztn/D12w0jyT93mSX
         iK4Q==
X-Gm-Message-State: AOJu0Yz+1r3D36E1K5dU8Hh3VsnSH8HBPOIDZ8PplU+xJ+hLGebb0yAb
        5mH/ttD+dGcoZ1ofUEjxk00=
X-Google-Smtp-Source: AGHT+IFubmemnG3ZtDkEqPVHtWmumvX4j8Rtv4Uxe4mKV/fj31ZYJRG0xMAZx5AhbeR2cRt21X3Y6w==
X-Received: by 2002:adf:e94e:0:b0:319:70c8:6e90 with SMTP id m14-20020adfe94e000000b0031970c86e90mr794163wrn.24.1693947987474;
        Tue, 05 Sep 2023 14:06:27 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5012000000b00317b063590fsm18427672wrt.55.2023.09.05.14.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:06:26 -0700 (PDT)
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
Subject: [PATCH bpf-next 5/8] arm32, bpf: add support for 32-bit signed division
Date:   Tue,  5 Sep 2023 21:06:18 +0000
Message-Id: <20230905210621.1711859-6-puranjay12@gmail.com>
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

The cpuv4 added a new BPF_SDIV instruction that does signed division.
The encoding is similar to BPF_DIV but BPF_SDIV sets offset=1.

ARM32 already supports 32-bit BPF_DIV which can be easily extended to
support BPF_SDIV as ARM32 has the SDIV instruction. When the CPU is not
ARM-v7, we implement that SDIV/SMOD with the function call similar to
the implementation of DIV/MOD.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 26 ++++++++++++++++++++------
 arch/arm/net/bpf_jit_32.h |  2 ++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 09496203f13e..f580ecf75710 100644
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
@@ -477,7 +487,7 @@ static inline int epilogue_offset(const struct jit_ctx *ctx)
 	return to - from - 2;
 }
 
-static inline void emit_udivmod(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx, u8 op)
+static inline void emit_udivmod(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx, u8 op, u8 sign)
 {
 	const int exclude_mask = BIT(ARM_R0) | BIT(ARM_R1);
 	const s8 *tmp = bpf2a32[TMP_REG_1];
@@ -485,9 +495,10 @@ static inline void emit_udivmod(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx, u8 op)
 #if __LINUX_ARM_ARCH__ == 7
 	if (elf_hwcap & HWCAP_IDIVA) {
 		if (op == BPF_DIV)
-			emit(ARM_UDIV(rd, rm, rn), ctx);
+			sign ? emit(ARM_SDIV(rd, rm, rn), ctx) : emit(ARM_UDIV(rd, rm, rn), ctx);
 		else {
-			emit(ARM_UDIV(ARM_IP, rm, rn), ctx);
+			sign ? emit(ARM_SDIV(ARM_IP, rm, rn), ctx) :
+				emit(ARM_UDIV(ARM_IP, rm, rn), ctx);
 			emit(ARM_MLS(rd, rn, ARM_IP, rm), ctx);
 		}
 		return;
@@ -515,8 +526,11 @@ static inline void emit_udivmod(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx, u8 op)
 	emit(ARM_PUSH(CALLER_MASK & ~exclude_mask), ctx);
 
 	/* Call appropriate function */
-	emit_mov_i(ARM_IP, op == BPF_DIV ?
-		   (u32)jit_udiv32 : (u32)jit_mod32, ctx);
+	if (sign)
+		emit_mov_i(ARM_IP, op == BPF_DIV ? (u32)jit_sdiv32 : (u32)jit_smod32, ctx);
+	else
+		emit_mov_i(ARM_IP, op == BPF_DIV ? (u32)jit_udiv32 : (u32)jit_mod32, ctx);
+
 	emit_blx_r(ARM_IP, ctx);
 
 	/* Restore caller-saved registers from stack */
@@ -1546,7 +1560,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
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

