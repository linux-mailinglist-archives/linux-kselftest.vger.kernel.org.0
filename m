Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92518797EF9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 01:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjIGXGF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 19:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbjIGXGD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 19:06:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583161BD3;
        Thu,  7 Sep 2023 16:05:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-313e742a787so941995f8f.1;
        Thu, 07 Sep 2023 16:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694127958; x=1694732758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R+/JPrQIYT0UZqxCT3hi8uBcQZ+4D3iPyuJBEFiVFA=;
        b=jrGWQ5+XvKXvo5jymF37cF0ezgCZkZDpHRezJh8U4wMoSv+pAk+//iQLWR/8fwGOCy
         Htc9pz8xzQUyIPcohryvh1F/IsaKGsStRh4r3azN8rUAscwd2pGft63hKEXxhBH0NYH9
         8lnrcRWLGD6Y5kz+gHW92/39fjYpIfzIfpMOJvtcgSEcI/hI1qi/ABBITzkLBqItcVHu
         dcU4eK+khgdAVg375VkZ0lWT9xLPi5pX55LHFozMbXU3aWCCk/ELE4iyT7CZEqiVY7DH
         ax0XSdiw1dUK3/sP60auzmcvO0jaETVX9DpznIcEfvm/xJAUa1F/7IGMnmeqagaUcJ1v
         P01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694127958; x=1694732758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8R+/JPrQIYT0UZqxCT3hi8uBcQZ+4D3iPyuJBEFiVFA=;
        b=KqVcrTE8PoUFHo685FNcq/WutZEu1dxXs9e+fYgnlvlqKYpbf9N9eyeLmJQzQb15MF
         CDnCfy5Rj/R4NxdPsMqdt5ATI05V7h6Ynb3Vp1qYdJ+6oBOH+IGp9JBkDbdO2r3iVKyo
         fLWrEEIVZNRcx57w4Izub9FpTGbc1HhZeSP6QYxgVLLIvP3DPCmH4XFqMUyRtYVZM9Kb
         rEyuEylkVej4P28uiY7nDsMDkIQvyAxJnJyZjJcP4b5xhtLCWwn+l90VFc3YInclcUlJ
         bVORWcju3xYaLWgfnHh72wTC7NkSHKnpY8hhO+KdN5L8j9GHa9i9MZkld7XOisR7DIMc
         DJrg==
X-Gm-Message-State: AOJu0YzKQZeIgUMPK4zN7BCqQjTi5ATTgyJdUgEp8AGxDOTWtdWv2MIY
        5zJNtyADth+vegsZi3GXbxA=
X-Google-Smtp-Source: AGHT+IFGDmgqyYEQxX2Gc3TJDC71lQCUyPim5sKL+6O43938s5rZTryQI16jQUn1eFVWKB+ho933Lw==
X-Received: by 2002:a5d:50c5:0:b0:314:475:bc6b with SMTP id f5-20020a5d50c5000000b003140475bc6bmr506932wrt.18.1694127957543;
        Thu, 07 Sep 2023 16:05:57 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-3-249-32-32.eu-west-1.compute.amazonaws.com. [3.249.32.32])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d484d000000b0031f3b04e7cdsm491358wrs.109.2023.09.07.16.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 16:05:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 5/9] arm32, bpf: add support for 32-bit signed division
Date:   Thu,  7 Sep 2023 23:05:46 +0000
Message-Id: <20230907230550.1417590-6-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230907230550.1417590-1-puranjay12@gmail.com>
References: <20230907230550.1417590-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 38 ++++++++++++++++++++++++++++++--------
 arch/arm/net/bpf_jit_32.h |  2 ++
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index a08eba850ddf..6939546f4ddf 100644
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
@@ -1551,7 +1573,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
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

