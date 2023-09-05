Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CD279309F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 23:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbjIEVGd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 17:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbjIEVGb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 17:06:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD4E13E;
        Tue,  5 Sep 2023 14:06:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fef56f7248so29092625e9.3;
        Tue, 05 Sep 2023 14:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693947984; x=1694552784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwquC/nnDI7T/ZG1VkEe4vm26r8Eh5aZWTrEcG67A7A=;
        b=ogzWoEoCwZZX0FD0DLSju5DPTLU9khObOdupZlj/uhVoSAmfZD9xEvxMEQYVXSGTlH
         q7/oWAbb8hyJtp5OFvp9Rfm9001ogO9zpJYpPYKx9Cyjx6N30IqFUPt1SVU7xpRWRx7C
         erkolG24bNyjsKE+hT6F6f8FT0LSAy6Wf6Lsej3Eedb2k3AQRF/D1lDHvs2OIt0HAR26
         RheJxoaZ+9mbScP5ZYOROTAWvI9xsg7mEndTgB2vlny4ZfSCElRwp/ZVTzDSdRk61VZj
         N76UXiYukM+rCrbwzSWn9TeMXd6rZacUa9DfVFh0WMYwRvFcReb8xVaoLQdQ6mSMKtuY
         N1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693947984; x=1694552784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwquC/nnDI7T/ZG1VkEe4vm26r8Eh5aZWTrEcG67A7A=;
        b=ibtM9EQWZgm7KDblWQ6bLaOuTHKY3j4eQoChk8pFcmeaLKN9dbMncmTyq5ra30zRX9
         u/PzxTGGNzFeS2bN3yEfXJKGoz+qf2/pbrKONgUW17siNcK+/CnN5npAlSyN+uApGLXR
         Elhakq7zdboiW/sbmMlaoSzmBxS3GtzoZ+SpUZ5kFNWsf3+bNhkhEk7/XsxYJkaUpK1W
         vW3hsw4Ojy3GT4p85fxjIjsUAMiNnzGvZgZMnz9da8QNCaCy34ge/fSiBquA5R4yUG3c
         GBGe7gYCGVL0ZadKABAWCmvdV+i/GM/fgA5gHqnIR1G0Q4Js8RLn+eE7SdCdywWDkRD/
         2HTA==
X-Gm-Message-State: AOJu0YygJY+j+F6L+DaedsdD2p1Oz/kKE7sdGk6Hycj1U9mFiA7zipn9
        Kng57BrPrZ99hSlKaiJxs8w=
X-Google-Smtp-Source: AGHT+IHKpJIXt9w3hLunKRC4nLADCMpDxptUOsD0paIfnpBLl10KUBID17zOR4PNE74VCPb0Vle71A==
X-Received: by 2002:a7b:cd96:0:b0:3fb:a0fc:1ba1 with SMTP id y22-20020a7bcd96000000b003fba0fc1ba1mr636373wmj.35.1693947983968;
        Tue, 05 Sep 2023 14:06:23 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5012000000b00317b063590fsm18427672wrt.55.2023.09.05.14.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:06:23 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/8] arm32, bpf: add support for sign-extension load instruction
Date:   Tue,  5 Sep 2023 21:06:15 +0000
Message-Id: <20230905210621.1711859-3-puranjay12@gmail.com>
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

The cpuv4 added the support of an instruction that is similar to load
but also sign-extends the result after the load.

BPF_MEMSX | <size> | BPF_LDX means dst = *(signed size *) (src + offset)
here <size> can be one of BPF_B, BPF_H, BPF_W.

ARM32 has instructions to load a byte or a half word with sign
extension into a 32bit register. As the JIT uses two 32 bit registers
to simulate a 64-bit BPF register, an extra instruction is emitted to
sign-extent the result up to the second register.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 69 ++++++++++++++++++++++++++++++++++++++-
 arch/arm/net/bpf_jit_32.h |  2 ++
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index b26579da770e..f7c162479cf2 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -333,6 +333,9 @@ static u32 arm_bpf_ldst_imm8(u32 op, u8 rt, u8 rn, s16 imm8)
 #define ARM_LDRD_I(rt, rn, off)	arm_bpf_ldst_imm8(ARM_INST_LDRD_I, rt, rn, off)
 #define ARM_LDRH_I(rt, rn, off)	arm_bpf_ldst_imm8(ARM_INST_LDRH_I, rt, rn, off)
 
+#define ARM_LDRSH_I(rt, rn, off) arm_bpf_ldst_imm8(ARM_INST_LDRSH_I, rt, rn, off)
+#define ARM_LDRSB_I(rt, rn, off) arm_bpf_ldst_imm8(ARM_INST_LDRSB_I, rt, rn, off)
+
 #define ARM_STR_I(rt, rn, off)	arm_bpf_ldst_imm12(ARM_INST_STR_I, rt, rn, off)
 #define ARM_STRB_I(rt, rn, off)	arm_bpf_ldst_imm12(ARM_INST_STRB_I, rt, rn, off)
 #define ARM_STRD_I(rt, rn, off)	arm_bpf_ldst_imm8(ARM_INST_STRD_I, rt, rn, off)
@@ -1026,6 +1029,24 @@ static bool is_ldst_imm(s16 off, const u8 size)
 	return -off_max <= off && off <= off_max;
 }
 
+static bool is_ldst_imm8(s16 off, const u8 size)
+{
+	s16 off_max = 0;
+
+	switch (size) {
+	case BPF_B:
+		off_max = 0xff;
+		break;
+	case BPF_W:
+		off_max = 0xfff;
+		break;
+	case BPF_H:
+		off_max = 0xff;
+		break;
+	}
+	return -off_max <= off && off <= off_max;
+}
+
 /* *(size *)(dst + off) = src */
 static inline void emit_str_r(const s8 dst, const s8 src[],
 			      s16 off, struct jit_ctx *ctx, const u8 sz){
@@ -1105,6 +1126,45 @@ static inline void emit_ldx_r(const s8 dst[], const s8 src,
 	arm_bpf_put_reg64(dst, rd, ctx);
 }
 
+/* dst = *(signed size*)(src + off) */
+static inline void emit_ldsx_r(const s8 dst[], const s8 src,
+			       s16 off, struct jit_ctx *ctx, const u8 sz){
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *rd = is_stacked(dst_lo) ? tmp : dst;
+	s8 rm = src;
+
+	if (!is_ldst_imm8(off, sz)) {
+		emit_a32_mov_i(tmp[0], off, ctx);
+		emit(ARM_ADD_R(tmp[0], tmp[0], src), ctx);
+		rm = tmp[0];
+		off = 0;
+	} else if (rd[1] == rm) {
+		emit(ARM_MOV_R(tmp[0], rm), ctx);
+		rm = tmp[0];
+	}
+	switch (sz) {
+	case BPF_B:
+		/* Load a Byte with sign extension*/
+		emit(ARM_LDRSB_I(rd[1], rm, off), ctx);
+		/* Carry the sign extension to upper 32 bits */
+		emit(ARM_ASR_I(rd[0], rd[1], 31), ctx);
+		break;
+	case BPF_H:
+		/* Load a HalfWord with sign extension*/
+		emit(ARM_LDRSH_I(rd[1], rm, off), ctx);
+		/* Carry the sign extension to upper 32 bits */
+		emit(ARM_ASR_I(rd[0], rd[1], 31), ctx);
+		break;
+	case BPF_W:
+		/* Load a Word*/
+		emit(ARM_LDR_I(rd[1], rm, off), ctx);
+		/* Carry the sign extension to upper 32 bits */
+		emit(ARM_ASR_I(rd[0], rd[1], 31), ctx);
+		break;
+	}
+	arm_bpf_put_reg64(dst, rd, ctx);
+}
+
 /* Arithmatic Operation */
 static inline void emit_ar_r(const u8 rd, const u8 rt, const u8 rm,
 			     const u8 rn, struct jit_ctx *ctx, u8 op,
@@ -1603,8 +1663,15 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_LDX | BPF_MEM | BPF_H:
 	case BPF_LDX | BPF_MEM | BPF_B:
 	case BPF_LDX | BPF_MEM | BPF_DW:
+	/* LDSX: dst = *(signed size *)(src + off) */
+	case BPF_LDX | BPF_MEMSX | BPF_B:
+	case BPF_LDX | BPF_MEMSX | BPF_H:
+	case BPF_LDX | BPF_MEMSX | BPF_W:
 		rn = arm_bpf_get_reg32(src_lo, tmp2[1], ctx);
-		emit_ldx_r(dst, rn, off, ctx, BPF_SIZE(code));
+		if (BPF_MODE(insn->code) == BPF_MEMSX)
+			emit_ldsx_r(dst, rn, off, ctx, BPF_SIZE(code));
+		else
+			emit_ldx_r(dst, rn, off, ctx, BPF_SIZE(code));
 		break;
 	/* speculation barrier */
 	case BPF_ST | BPF_NOSPEC:
diff --git a/arch/arm/net/bpf_jit_32.h b/arch/arm/net/bpf_jit_32.h
index e0b593a1498d..79c7373fadce 100644
--- a/arch/arm/net/bpf_jit_32.h
+++ b/arch/arm/net/bpf_jit_32.h
@@ -79,9 +79,11 @@
 #define ARM_INST_LDST__IMM12	0x00000fff
 #define ARM_INST_LDRB_I		0x05500000
 #define ARM_INST_LDRB_R		0x07d00000
+#define ARM_INST_LDRSB_I	0x015000d0
 #define ARM_INST_LDRD_I		0x014000d0
 #define ARM_INST_LDRH_I		0x015000b0
 #define ARM_INST_LDRH_R		0x019000b0
+#define ARM_INST_LDRSH_I	0x015000f0
 #define ARM_INST_LDR_I		0x05100000
 #define ARM_INST_LDR_R		0x07900000
 
-- 
2.39.2

