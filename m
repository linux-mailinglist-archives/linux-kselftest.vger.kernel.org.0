Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64062794317
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 20:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243469AbjIFSd6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242232AbjIFSdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 14:33:52 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE911724;
        Wed,  6 Sep 2023 11:33:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-307d58b3efbso173533f8f.0;
        Wed, 06 Sep 2023 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694025204; x=1694630004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpPHnCbawH8HGxq3WXucSI65VKZBAcp+nA65BcypCyI=;
        b=ZOqaViz4UeXJQxOfyHGCDr9FoQhBCHkA5EyHb1Alb2BCQ8FA8jyQV4SkYdyAzxyYLn
         b+anBdTe4PwUnqvQZ0iMfN2TS4OUI0z2utwJjOfe2OKzrt+s4LSXdhS5UXVzxZQuXoSW
         OsRlv8jrEhYdu+/YVU9dqpfI3upwBTrVymfhdTeaAFNOKTGQeoPFj6gk+CshFykRIRsD
         mcHA2qSquDJpSTjk5KVIUSUfu9DD0bgZOPQX52/p79SNoRiWxqpkT+1eoIw/R2bwM+IP
         kt0ZYwf9Y0ImzOLm67c8VV4RnQs6fRewFyg0UdvbLtQfzo0y47DjzILotXKxHgs9eBl3
         QTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694025204; x=1694630004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpPHnCbawH8HGxq3WXucSI65VKZBAcp+nA65BcypCyI=;
        b=ena09D/jj79597ztWfjDh0pRVjNW143d/iWqGErKM0dJHUiKLS3pfSygCzA05dSLOd
         9jeDwHZBnsXbYUG2XZ+YiqrjX4lu+rQFUD6RfAyc5DN17PDvZF7aDRkd3fOJWCoXGsvk
         DIbhD/R90+y7j8VUnNrxxMO1Ms2yd7nBaUdyg7vZmTSj8odf+yv+x49/W1tgRthLUYmG
         RKXJPtjhJGwWv3Um/qz7mZthzZ8ufAMetIGr2jLps4YQXLEG5QPVdMs+c8aNVnliRpNd
         MH6B0oa1Uc4jEz7ASyfO2boR/+fqNdcczxswHCgcdebbhg7i/FAco+z8GRbXyavNxyTR
         Fv6w==
X-Gm-Message-State: AOJu0YzfROZvBnV9IX1IzxEo7VwrLk+QkQec/5u2t+s3mVkBf/u2u8Pv
        t8qQJTYby/XiBswpo3+cZ2sdrJOXo08QcNdn9Uc=
X-Google-Smtp-Source: AGHT+IEulztVzD7X1nLQgBA1OIwdrqWi5ZjxxO5Dlpa2UyE7g7salfPTaIETYncgU6bOzmhY25ZEoQ==
X-Received: by 2002:adf:f552:0:b0:31a:d773:51a5 with SMTP id j18-20020adff552000000b0031ad77351a5mr3076504wrp.27.1694025204093;
        Wed, 06 Sep 2023 11:33:24 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d4bca000000b003180155493esm21094891wrt.67.2023.09.06.11.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:33:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/8] arm32, bpf: add support for sign-extension mov instruction
Date:   Wed,  6 Sep 2023 18:33:15 +0000
Message-Id: <20230906183320.1959008-4-puranjay12@gmail.com>
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

The cpuv4 added a new BPF_MOVSX instruction that sign extends the src
before moving it to the destination.

BPF_ALU | BPF_MOVSX sign extends 8-bit and 16-bit operands into 32-bit
operands, and zeroes the remaining upper 32 bits.

BPF_ALU64 | BPF_MOVSX sign extends 8-bit, 16-bit, and 32-bit  operands
into 64-bit operands.

The offset field of the instruction is used to tell the number of bit to
use for sign-extension. BPF_MOV and BPF_MOVSX have the same code but the
former sets offset to 0 and the later one sets the offset to 8, 16 or 32

The behaviour of this instruction is dst = (s8,s16,s32)src

On ARM32 the implementation uses LSH and ARSH to extend the 8/16 bits to
a 32-bit register and then it is sign extended to the upper 32-bit
register using ARSH. For 32-bit we just move it to the destination
register and use ARSH to extend it to the upper 32-bit register.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 0a272a02959b..56ea8022e989 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -747,12 +747,16 @@ static inline void emit_a32_alu_r64(const bool is64, const s8 dst[],
 }
 
 /* dst = src (4 bytes)*/
-static inline void emit_a32_mov_r(const s8 dst, const s8 src,
+static inline void emit_a32_mov_r(const s8 dst, const s8 src, const u8 off,
 				  struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	s8 rt;
 
 	rt = arm_bpf_get_reg32(src, tmp[0], ctx);
+	if (off && off != 32) {
+		emit(ARM_LSL_I(rt, rt, 32 - off), ctx);
+		emit(ARM_ASR_I(rt, rt, 32 - off), ctx);
+	}
 	arm_bpf_put_reg32(dst, rt, ctx);
 }
 
@@ -761,15 +765,15 @@ static inline void emit_a32_mov_r64(const bool is64, const s8 dst[],
 				  const s8 src[],
 				  struct jit_ctx *ctx) {
 	if (!is64) {
-		emit_a32_mov_r(dst_lo, src_lo, ctx);
+		emit_a32_mov_r(dst_lo, src_lo, 0, ctx);
 		if (!ctx->prog->aux->verifier_zext)
 			/* Zero out high 4 bytes */
 			emit_a32_mov_i(dst_hi, 0, ctx);
 	} else if (__LINUX_ARM_ARCH__ < 6 &&
 		   ctx->cpu_architecture < CPU_ARCH_ARMv5TE) {
 		/* complete 8 byte move */
-		emit_a32_mov_r(dst_lo, src_lo, ctx);
-		emit_a32_mov_r(dst_hi, src_hi, ctx);
+		emit_a32_mov_r(dst_lo, src_lo, 0, ctx);
+		emit_a32_mov_r(dst_hi, src_hi, 0, ctx);
 	} else if (is_stacked(src_lo) && is_stacked(dst_lo)) {
 		const u8 *tmp = bpf2a32[TMP_REG_1];
 
@@ -785,6 +789,24 @@ static inline void emit_a32_mov_r64(const bool is64, const s8 dst[],
 	}
 }
 
+/* dst = (signed)src */
+static inline void emit_a32_movsx_r64(const bool is64, const u8 off, const s8 dst[], const s8 src[],
+				      struct jit_ctx *ctx) {
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *rt;
+
+	rt = arm_bpf_get_reg64(dst, tmp, ctx);
+
+	emit_a32_mov_r(dst_lo, src_lo, off, ctx);
+	if (!is64) {
+		if (!ctx->prog->aux->verifier_zext)
+			/* Zero out high 4 bytes */
+			emit_a32_mov_i(dst_hi, 0, ctx);
+	} else {
+		emit(ARM_ASR_I(rt[0], rt[1], 31), ctx);
+	}
+}
+
 /* Shift operations */
 static inline void emit_a32_alu_i(const s8 dst, const u32 val,
 				struct jit_ctx *ctx, const u8 op) {
@@ -1446,7 +1468,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 				emit_a32_mov_i(dst_hi, 0, ctx);
 				break;
 			}
-			emit_a32_mov_r64(is64, dst, src, ctx);
+			if (insn->off)
+				emit_a32_movsx_r64(is64, insn->off, dst, src, ctx);
+			else
+				emit_a32_mov_r64(is64, dst, src, ctx);
 			break;
 		case BPF_K:
 			/* Sign-extend immediate value to destination reg */
-- 
2.39.2

