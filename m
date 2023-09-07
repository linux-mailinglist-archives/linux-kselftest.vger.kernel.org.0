Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45343797EF8
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 01:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbjIGXGD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 19:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbjIGXGA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 19:06:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06CF1BD3;
        Thu,  7 Sep 2023 16:05:56 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401da71b85eso15740245e9.1;
        Thu, 07 Sep 2023 16:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694127955; x=1694732755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEta5yw0VNcFxsmxiaHlsNWg9hJXxdVowlnC2nr+DR8=;
        b=Tgrlsaw8Rio6nPzVkZY3PzcK5+fIxjJ5nUegbEyp4IBHqzzYefoSiF81WkK8X5YY/f
         iAzxmCXPI1u3stgpZeVEp9Ki4ikxG30/3FNZ6Y6uIhyEQrmehMqsjPwVCf6VxBYQuG/y
         yitJhn2qmJOzFOIZTj8ze12uH4Tu9mTrbS1fXlgEMvOlNFGQ2WgG+F7zfOWZylShJXqV
         8nb8/I8xWV9GrvZ4Vee2JxOKVLsABktXAhK4s1jsoWvFsw4UWWHAvZraZ/A3yDNSYvYK
         oDc9/Miu1SV4gIJF/9bSUd4XYbEullUwCkxi5T4h9AHvijn+/nbd2eb7I16dbxOb9rvh
         z8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694127955; x=1694732755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEta5yw0VNcFxsmxiaHlsNWg9hJXxdVowlnC2nr+DR8=;
        b=wYv56JnrkbzIQZxDDbSLTkJzVOoIUpId1SOvy2Jk00D37Etl05JEjRCBl7XjMfojo4
         q8fsjzCvRq/DAkQ7cKXT28O/NsS+3CUrlcvV8Y6rl0rOGs4e9g3xlncw6/L2FdLbh1QT
         hO3J7e9fd5XQyXBfF9t70pN9UQ/H8l36RU0qxEiuxudzloTXeMak8/8feNzvpbwk3ven
         cVGNRqH5otB/2jyyTOcVL+2fcS0ukXSldHrlESDVepLbnCD7WpQnBQvCZwzvu5LlS9pv
         VINN/dQm2MdlAdO3ghCdgr+FzEysYCa2CjES8VBiuPrX9UH805NhkCpSY1uCqFuFR6cg
         xYQg==
X-Gm-Message-State: AOJu0YzCdpmrxjR0Z4BQ6Jk73/DpQtJs8gz+TqFN2jYFMSaCyYX63yV+
        D6bziCAdryfCztIikHldGPg=
X-Google-Smtp-Source: AGHT+IGLLU8OXshrTsz2mhPTdNyRjNfUjOeUCsbFGipx8GO8gC6MNYXMpc8MxRBhf2GtPC6qYe3fsQ==
X-Received: by 2002:a05:600c:3ba1:b0:3fe:5501:d293 with SMTP id n33-20020a05600c3ba100b003fe5501d293mr705361wms.30.1694127955244;
        Thu, 07 Sep 2023 16:05:55 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-3-249-32-32.eu-west-1.compute.amazonaws.com. [3.249.32.32])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d484d000000b0031f3b04e7cdsm491358wrs.109.2023.09.07.16.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 16:05:54 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/9] arm32, bpf: add support for sign-extension mov instruction
Date:   Thu,  7 Sep 2023 23:05:44 +0000
Message-Id: <20230907230550.1417590-4-puranjay12@gmail.com>
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
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 1b3bd05878ab..29a1ccf761fd 100644
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
@@ -1450,7 +1472,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
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

