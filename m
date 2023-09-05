Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC727930A2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 23:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243802AbjIEVGf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 17:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236553AbjIEVGc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 17:06:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FC51A2;
        Tue,  5 Sep 2023 14:06:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31977ace1c8so2630322f8f.1;
        Tue, 05 Sep 2023 14:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693947985; x=1694552785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYw2sBIqQ+y5a56KRhVpmKODqheJWAeWBRyQ0D2RtJk=;
        b=Ly4JFlYbm24kwl42YdGswau5kh6lkGXFqu9iTv+/s508FJEjbNqX5Jp1PYCIFEWrj5
         8HrhlTwHpYhu/pvcMZWqWZZgB3OIF7YQq2Gifrh9Ux2CnImi98vHVxamgjoYjkB8dhvX
         HvkWp3FSLvvwSrE5aEzWWjilce0fAiIDMmx4/TheYnZiaThvfcKA1w8R9vhsw2iTWI6l
         OxdaKA8SIgKKSBQGufzPOTC/fjg7d0FYjXgkywilhmHKOstxZaiOw/kfe7saCqJJygPU
         pjNQxspFAI66cUMWeEcF++k3Dvquin0XsHEjNJclvyFNvftACW8T8vt1aLx1umDbTusz
         LP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693947985; x=1694552785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYw2sBIqQ+y5a56KRhVpmKODqheJWAeWBRyQ0D2RtJk=;
        b=KgZCQnef+qqjLAmQOxoeKk6qJS8KcXZ01pvfPA1KuwmUzNwbUTY7t2KmiYwj6UuypH
         SI3rRlAMkhTgBJRuM+Z1qTjP5qItQUezNgA6TbUJwnJbo9HwRZsfC7MmlJ9NzIHhZ2/l
         0FjxHozNWLdGK2GGUYhTpBr0YELIMi4kfmzhDhULp5U7mwj+rmYc5Q3ZYSTcVradJirz
         o3Jw1gjoeh6Vjzrc34DSRyFRwhCxkbVw+itJa1bbbw52kW1Igx5HyLOdXdwAYPsN8Ab4
         EutN5S5o8FBT4LcxiPXPH5ymyGVSL6oyxsHCASwMjsdFeB80GzTMRx0c5g/zLt9BrClL
         HJMQ==
X-Gm-Message-State: AOJu0YzUyqkC52vBCNvzuibfCSLeun5/VlxvKczyCqOsPAgfok7NO4ws
        lqLa2LVuTbJDsbgWLfmyf4Y=
X-Google-Smtp-Source: AGHT+IF7OU/wHLI0hWBp0MjehOxhxDJzfWhI/L7w/T7gbyv/9j0KzXFV/0Mi7VTnZsRq1wWlgsz8NA==
X-Received: by 2002:a5d:508d:0:b0:317:6310:a616 with SMTP id a13-20020a5d508d000000b003176310a616mr734496wrt.36.1693947985047;
        Tue, 05 Sep 2023 14:06:25 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5012000000b00317b063590fsm18427672wrt.55.2023.09.05.14.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:06:24 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/8] arm32, bpf: add support for sign-extension mov instruction
Date:   Tue,  5 Sep 2023 21:06:16 +0000
Message-Id: <20230905210621.1711859-4-puranjay12@gmail.com>
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
index f7c162479cf2..0a30188de660 100644
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
@@ -1445,7 +1467,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
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

