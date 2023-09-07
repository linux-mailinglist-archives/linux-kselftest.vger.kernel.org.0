Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE0B797EF3
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 01:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbjIGXGC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 19:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbjIGXGA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 19:06:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E202C1BD2;
        Thu,  7 Sep 2023 16:05:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31f7400cb74so800042f8f.2;
        Thu, 07 Sep 2023 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694127954; x=1694732754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIayBM2IAR+PSKNnZizKOrKlw9zKq0elQhYgTRntyyY=;
        b=WEEPXC7WyZ7hkLmMbQYmYMgz51hAGqO4LbOuTAl4rv3ZbDQsI0+1rxDLVbuh0qjAg6
         iPBrVCCrV8pC8Cm4kIr2+JXXtKp1R4M5m0jzunUr0TQksWgh0SfaIWKg3rtqaSHJlS+B
         C0bVGJGGtQFNHqxO1pxYLz3+tcZAAE4e7HjKa/pmXRY/q1m+Ij86DS8cIEppElk6j1nn
         +Dza2GaJfbk8jB2pM29WZ6F0rrfYq4XYmS690L7bq/Q2JxueanVjKyUm1K2wB9jk4hdR
         rKjoIBvzEXsEstDLcJk51laj8fsAaqREJa4xpOvfmoFfn9Jh/KlQDZuI/kP3i4likWiF
         RucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694127954; x=1694732754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIayBM2IAR+PSKNnZizKOrKlw9zKq0elQhYgTRntyyY=;
        b=YqUfOXNE36Ai9JMpWMKeAXuZZX/dJgcazHYRBApub4MS8qZHtz80lzjQzzE1ukC1kG
         e//+SoiJRtoRGdvY83BB/dM/MyZmfXMHOHWZgW9ZvjIkpGQX8tZ1E4iHTShIuHdZqy3Z
         kHg7Uoxt47CMAXDgbgHJRvchdd3CSH09YXEXrn5sgy9za+HgVyukojCrPTfDuphTYcyL
         8T8WD3HrOJU1ZnmV9tNVVVv/XFonOCPQcjul1wA0I29cIUoQQn4Tv/+06ck4VFmRsAvD
         UUUX0GAXuE/d/FyEjcjcUA9ukHij4uevK79hTPkYXKWdquaBkNR1QfZ0s4l2AZq3a2Y2
         /69A==
X-Gm-Message-State: AOJu0YxR8bIIggU5g72rTvlBOt62trKgib52pZcE9oMmESXxLr4qv/lM
        FoFJbYnjdlGmD4iGELzaaNI=
X-Google-Smtp-Source: AGHT+IHlsQqml97umZs/Ep1BRIKG0z9voFzZ4BTUv9OWylXEj2KIfJnpGBx/ETmwSDgpEeUJvxVc9Q==
X-Received: by 2002:a05:6000:2:b0:317:636b:fcb1 with SMTP id h2-20020a056000000200b00317636bfcb1mr398483wrx.27.1694127954263;
        Thu, 07 Sep 2023 16:05:54 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-3-249-32-32.eu-west-1.compute.amazonaws.com. [3.249.32.32])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d484d000000b0031f3b04e7cdsm491358wrs.109.2023.09.07.16.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 16:05:53 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/9] arm32, bpf: add support for sign-extension load instruction
Date:   Thu,  7 Sep 2023 23:05:43 +0000
Message-Id: <20230907230550.1417590-3-puranjay12@gmail.com>
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

The cpuv4 added the support of an instruction that is similar to load
but also sign-extends the result after the load.

BPF_MEMSX | <size> | BPF_LDX means dst = *(signed size *) (src + offset)
here <size> can be one of BPF_B, BPF_H, BPF_W.

ARM32 has instructions to load a byte or a half word with sign
extension into a 32bit register. As the JIT uses two 32 bit registers
to simulate a 64-bit BPF register, an extra instruction is emitted to
sign-extent the result up to the second register.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 74 ++++++++++++++++++++++++++++++++++++++-
 arch/arm/net/bpf_jit_32.h |  2 ++
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index c03600fe86f6..1b3bd05878ab 100644
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
@@ -1105,6 +1126,50 @@ static inline void emit_ldx_r(const s8 dst[], const s8 src,
 	arm_bpf_put_reg64(dst, rd, ctx);
 }
 
+/* dst = *(signed size*)(src + off) */
+static inline void emit_ldsx_r(const s8 dst[], const s8 src,
+			       s16 off, struct jit_ctx *ctx, const u8 sz){
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *rd = is_stacked(dst_lo) ? tmp : dst;
+	s8 rm = src;
+	int add_off;
+
+	if (!is_ldst_imm8(off, sz)) {
+		/*
+		 * offset does not fit in the load/store immediate,
+		 * construct an ADD instruction to apply the offset.
+		 */
+		add_off = imm8m(off);
+		if (add_off > 0) {
+			emit(ARM_ADD_I(tmp[0], src, add_off), ctx);
+			rm = tmp[0];
+		} else {
+			emit_a32_mov_i(tmp[0], off, ctx);
+			emit(ARM_ADD_R(tmp[0], tmp[0], src), ctx);
+			rm = tmp[0];
+		}
+		off = 0;
+	}
+
+	switch (sz) {
+	case BPF_B:
+		/* Load a Byte with sign extension*/
+		emit(ARM_LDRSB_I(rd[1], rm, off), ctx);
+		break;
+	case BPF_H:
+		/* Load a HalfWord with sign extension*/
+		emit(ARM_LDRSH_I(rd[1], rm, off), ctx);
+		break;
+	case BPF_W:
+		/* Load a Word*/
+		emit(ARM_LDR_I(rd[1], rm, off), ctx);
+		break;
+	}
+	/* Carry the sign extension to upper 32 bits */
+	emit(ARM_ASR_I(rd[0], rd[1], 31), ctx);
+	arm_bpf_put_reg64(dst, rd, ctx);
+}
+
 /* Arithmatic Operation */
 static inline void emit_ar_r(const u8 rd, const u8 rt, const u8 rm,
 			     const u8 rn, struct jit_ctx *ctx, u8 op,
@@ -1603,8 +1668,15 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
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

