Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364A8794319
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 20:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbjIFSd7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 14:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243292AbjIFSdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 14:33:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ECA1739;
        Wed,  6 Sep 2023 11:33:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401d80f4ef8so1889295e9.1;
        Wed, 06 Sep 2023 11:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694025208; x=1694630008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXVC/JwrfhCwCFZ9CTtjljVWM7ojc7dibWwdrN2Ohcw=;
        b=UNS1Gqo1DdXmAcd90wtLFNDoepfWSNlSNibeuhKwyWAR8B8x3inEcHXviPRzzcPlCg
         PO8sEn350Q/hG6T95IPXjulneRgC7neQTKyr++SSwEvfBuyLZytJ7L5tlESR25O/L6BH
         7CZnNuxagtDVdR7bTknT0iVkRX+fxOsCviohUVT9Pi/+HRp6YdKs+kjjzSHOREBKDecm
         NUHqdAfSOGyIV0nKWHFjqiZS2ehRI8NoUGBAuESOXy/2rr8AA5pnI0K/LufZBmNtE6RA
         cSh0/f2IRReGh51xCjQOtPMMidUOJCtrVOiqwnrrIdx2kK3GUQSYRCU+sWS/KRm9Pqyf
         2AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694025208; x=1694630008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXVC/JwrfhCwCFZ9CTtjljVWM7ojc7dibWwdrN2Ohcw=;
        b=Pd/Rn0GIE1rwfWaBCcTigAGUR5blAySVmpl+UMoD+R90qlOyFTPpVrfo2QWpUfyEdI
         o+eJJvBeOAjX05CZmlGUp6FDfdf/0up87J0GEVujZsQSXCWpIW1PbFd9QoYgOf+XmqQa
         paJKGpTHI2N3gI2attATXfF4mDSSsAAs05Edazdfp7w2VNSVdA8/wT4ddZA7A1WbeN4c
         iQSWzUbs0o7YHbKm4HAdusuwHGWA/H2JTY42pKOF03HyXDEUpOTXgQ7ZhdLVeeQm4T8T
         +eLlOqKvuu6/YUag4V7pAl8tIV+K8PrG1fYBnLmFkZ/zWkoJ7F9wg5ryIEWhXFN4JR7P
         inEg==
X-Gm-Message-State: AOJu0YzVnpqoGcNglQWqA5QM8JLQL46YN5SVvGZ26mKZbpDYUSxudTVH
        nyQiCmVOLisOiTk2zZS8sO4=
X-Google-Smtp-Source: AGHT+IEvuuyOhEYeYiFyTZwzLJs0tKvnAKREJ96x/oGjHaA5sh8RfpDvjoFLxBHJddv/67hEG+QLYA==
X-Received: by 2002:adf:e409:0:b0:31a:e772:ddf6 with SMTP id g9-20020adfe409000000b0031ae772ddf6mr3078630wrm.39.1694025208214;
        Wed, 06 Sep 2023 11:33:28 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d4bca000000b003180155493esm21094891wrt.67.2023.09.06.11.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:33:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 8/8] bpf/tests: add tests for cpuv4 instructions
Date:   Wed,  6 Sep 2023 18:33:20 +0000
Message-Id: <20230906183320.1959008-9-puranjay12@gmail.com>
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

The BPF JITs now support cpuv4 instructions. Add tests for these new
instructions to the test suite:

1. Sign extended Load
2. Sign extended Mov
3. Unconditional byte swap
4. Unconditional jump with 32-bit offset
5. Signed division and modulo

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 include/linux/filter.h |  50 +++++-
 lib/test_bpf.c         | 371 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 417 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 761af6b3cf2b..0138832ad571 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -117,21 +117,25 @@ struct ctl_table_header;
 
 /* ALU ops on immediates, bpf_add|sub|...: dst_reg += imm32 */
 
-#define BPF_ALU64_IMM(OP, DST, IMM)				\
+#define BPF_ALU64_IMM_OFF(OP, DST, IMM, OFF)			\
 	((struct bpf_insn) {					\
 		.code  = BPF_ALU64 | BPF_OP(OP) | BPF_K,	\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
-		.off   = 0,					\
+		.off   = OFF,					\
 		.imm   = IMM })
+#define BPF_ALU64_IMM(OP, DST, IMM)				\
+	BPF_ALU64_IMM_OFF(OP, DST, IMM, 0)
 
-#define BPF_ALU32_IMM(OP, DST, IMM)				\
+#define BPF_ALU32_IMM_OFF(OP, DST, IMM, OFF)			\
 	((struct bpf_insn) {					\
 		.code  = BPF_ALU | BPF_OP(OP) | BPF_K,		\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
-		.off   = 0,					\
+		.off   = OFF,					\
 		.imm   = IMM })
+#define BPF_ALU32_IMM(OP, DST, IMM)				\
+	BPF_ALU32_IMM_OFF(OP, DST, IMM, 0)
 
 /* Endianess conversion, cpu_to_{l,b}e(), {l,b}e_to_cpu() */
 
@@ -143,6 +147,16 @@ struct ctl_table_header;
 		.off   = 0,					\
 		.imm   = LEN })
 
+/* Byte Swap, bswap16/32/64 */
+
+#define BPF_BSWAP(DST, LEN)					\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU64 | BPF_END | BPF_SRC(BPF_TO_LE),	\
+		.dst_reg = DST,					\
+		.src_reg = 0,					\
+		.off   = 0,					\
+		.imm   = LEN })
+
 /* Short form of mov, dst_reg = src_reg */
 
 #define BPF_MOV64_REG(DST, SRC)					\
@@ -179,6 +193,24 @@ struct ctl_table_header;
 		.off   = 0,					\
 		.imm   = IMM })
 
+/* Short form of movsx, dst_reg = (s8,s16,s32)src_reg */
+
+#define BPF_MOVSX64_REG(DST, SRC, OFF)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU64 | BPF_MOV | BPF_X,		\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = 0 })
+
+#define BPF_MOVSX32_REG(DST, SRC, OFF)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU | BPF_MOV | BPF_X,		\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = 0 })
+
 /* Special form of mov32, used for doing explicit zero extension on dst. */
 #define BPF_ZEXT_REG(DST)					\
 	((struct bpf_insn) {					\
@@ -263,6 +295,16 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 		.off   = OFF,					\
 		.imm   = 0 })
 
+/* Memory load, dst_reg = *(signed size *) (src_reg + off16) */
+
+#define BPF_LDX_MEMSX(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_LDX | BPF_SIZE(SIZE) | BPF_MEMSX,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = 0 })
+
 /* Memory store, *(uint *) (dst_reg + off16) = src_reg */
 
 #define BPF_STX_MEM(SIZE, DST, SRC, OFF)			\
diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ecde4216201e..7916503e6a6a 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -5111,6 +5111,104 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0xffffffff } }
 	},
+	/* MOVSX32 */
+	{
+		"ALU_MOVSX | BPF_B",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x00000000ffffffefLL),
+			BPF_LD_IMM64(R3, 0xdeadbeefdeadbeefLL),
+			BPF_MOVSX32_REG(R1, R3, 8),
+			BPF_JMP_REG(BPF_JEQ, R2, R1, 2),
+			BPF_MOV32_IMM(R0, 2),
+			BPF_EXIT_INSN(),
+			BPF_MOV32_IMM(R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x1 } },
+	},
+	{
+		"ALU_MOVSX | BPF_H",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x00000000ffffbeefLL),
+			BPF_LD_IMM64(R3, 0xdeadbeefdeadbeefLL),
+			BPF_MOVSX32_REG(R1, R3, 16),
+			BPF_JMP_REG(BPF_JEQ, R2, R1, 2),
+			BPF_MOV32_IMM(R0, 2),
+			BPF_EXIT_INSN(),
+			BPF_MOV32_IMM(R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x1 } },
+	},
+	{
+		"ALU_MOVSX | BPF_W",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x00000000deadbeefLL),
+			BPF_LD_IMM64(R3, 0xdeadbeefdeadbeefLL),
+			BPF_MOVSX32_REG(R1, R3, 32),
+			BPF_JMP_REG(BPF_JEQ, R2, R1, 2),
+			BPF_MOV32_IMM(R0, 2),
+			BPF_EXIT_INSN(),
+			BPF_MOV32_IMM(R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x1 } },
+	},
+	/* MOVSX64 REG */
+	{
+		"ALU64_MOVSX | BPF_B",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0xffffffffffffffefLL),
+			BPF_LD_IMM64(R3, 0xdeadbeefdeadbeefLL),
+			BPF_MOVSX64_REG(R1, R3, 8),
+			BPF_JMP_REG(BPF_JEQ, R2, R1, 2),
+			BPF_MOV32_IMM(R0, 2),
+			BPF_EXIT_INSN(),
+			BPF_MOV32_IMM(R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x1 } },
+	},
+	{
+		"ALU64_MOVSX | BPF_H",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0xffffffffffffbeefLL),
+			BPF_LD_IMM64(R3, 0xdeadbeefdeadbeefLL),
+			BPF_MOVSX64_REG(R1, R3, 16),
+			BPF_JMP_REG(BPF_JEQ, R2, R1, 2),
+			BPF_MOV32_IMM(R0, 2),
+			BPF_EXIT_INSN(),
+			BPF_MOV32_IMM(R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x1 } },
+	},
+	{
+		"ALU64_MOVSX | BPF_W",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0xffffffffdeadbeefLL),
+			BPF_LD_IMM64(R3, 0xdeadbeefdeadbeefLL),
+			BPF_MOVSX64_REG(R1, R3, 32),
+			BPF_JMP_REG(BPF_JEQ, R2, R1, 2),
+			BPF_MOV32_IMM(R0, 2),
+			BPF_EXIT_INSN(),
+			BPF_MOV32_IMM(R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x1 } },
+	},
 	/* BPF_ALU | BPF_ADD | BPF_X */
 	{
 		"ALU_ADD_X: 1 + 2 = 3",
@@ -6105,6 +6203,106 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 2 } },
 	},
+	/* BPF_ALU | BPF_DIV | BPF_X off=1 (SDIV) */
+	{
+		"ALU_SDIV_X: -6 / 2 = -3",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, -6),
+			BPF_ALU32_IMM(BPF_MOV, R1, 2),
+			BPF_ALU32_REG_OFF(BPF_DIV, R0, R1, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -3 } },
+	},
+	/* BPF_ALU | BPF_DIV | BPF_K off=1 (SDIV) */
+	{
+		"ALU_SDIV_K: -6 / 2 = -3",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, -6),
+			BPF_ALU32_IMM_OFF(BPF_DIV, R0, 2, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -3 } },
+	},
+	/* BPF_ALU64 | BPF_DIV | BPF_X off=1 (SDIV64) */
+	{
+		"ALU64_SDIV_X: -6 / 2 = -3",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, -6),
+			BPF_ALU32_IMM(BPF_MOV, R1, 2),
+			BPF_ALU64_REG_OFF(BPF_DIV, R0, R1, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -3 } },
+	},
+	/* BPF_ALU64 | BPF_DIV | BPF_K off=1 (SDIV64) */
+	{
+		"ALU64_SDIV_K: -6 / 2 = -3",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, -6),
+			BPF_ALU64_IMM_OFF(BPF_DIV, R0, 2, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -3 } },
+	},
+	/* BPF_ALU | BPF_MOD | BPF_X off=1 (SMOD) */
+	{
+		"ALU_SMOD_X: -7 % 2 = -1",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, -7),
+			BPF_ALU32_IMM(BPF_MOV, R1, 2),
+			BPF_ALU32_REG_OFF(BPF_MOD, R0, R1, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -1 } },
+	},
+	/* BPF_ALU | BPF_MOD | BPF_K off=1 (SMOD) */
+	{
+		"ALU_SMOD_K: -7 % 2 = -1",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, -7),
+			BPF_ALU32_IMM_OFF(BPF_MOD, R0, 2, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -1 } },
+	},
+	/* BPF_ALU64 | BPF_MOD | BPF_X off=1 (SMOD64) */
+	{
+		"ALU64_SMOD_X: -7 % 2 = -1",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, -7),
+			BPF_ALU32_IMM(BPF_MOV, R1, 2),
+			BPF_ALU64_REG_OFF(BPF_MOD, R0, R1, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -1 } },
+	},
+	/* BPF_ALU64 | BPF_MOD | BPF_K off=1 (SMOD64) */
+	{
+		"ALU64_SMOD_X: -7 % 2 = -1",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, -7),
+			BPF_ALU64_IMM_OFF(BPF_MOD, R0, 2, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -1 } },
+	},
 	/* BPF_ALU | BPF_AND | BPF_X */
 	{
 		"ALU_AND_X: 3 & 2 = 2",
@@ -7837,6 +8035,104 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, (u32) (cpu_to_le64(0xfedcba9876543210ULL) >> 32) } },
 	},
+	/* BSWAP */
+	{
+		"BSWAP 16: 0x0123456789abcdef -> 0xefcd",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_BSWAP(R0, 16),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xefcd } },
+	},
+	{
+		"BSWAP 32: 0x0123456789abcdef -> 0xefcdab89",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_BSWAP(R0, 32),
+			BPF_ALU64_REG(BPF_MOV, R1, R0),
+			BPF_ALU64_IMM(BPF_RSH, R1, 32),
+			BPF_ALU32_REG(BPF_ADD, R0, R1), /* R1 = 0 */
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xefcdab89 } },
+	},
+	{
+		"BSWAP 64: 0x0123456789abcdef -> 0x67452301",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_BSWAP(R0, 64),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x67452301 } },
+	},
+	{
+		"BSWAP 64: 0x0123456789abcdef >> 32 -> 0xefcdab89",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_BSWAP(R0, 64),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xefcdab89 } },
+	},
+	/* BSWAP, reversed */
+	{
+		"BSWAP 16: 0xfedcba9876543210 -> 0x1032",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
+			BPF_BSWAP(R0, 16),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x1032 } },
+	},
+	{
+		"BSWAP 32: 0xfedcba9876543210 -> 0x10325476",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
+			BPF_BSWAP(R0, 32),
+			BPF_ALU64_REG(BPF_MOV, R1, R0),
+			BPF_ALU64_IMM(BPF_RSH, R1, 32),
+			BPF_ALU32_REG(BPF_ADD, R0, R1), /* R1 = 0 */
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x10325476 } },
+	},
+	{
+		"BSWAP 64: 0xfedcba9876543210 -> 0x98badcfe",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
+			BPF_BSWAP(R0, 64),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x98badcfe } },
+	},
+	{
+		"BSWAP 64: 0xfedcba9876543210 >> 32 -> 0x10325476",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
+			BPF_BSWAP(R0, 64),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x10325476 } },
+	},
 	/* BPF_LDX_MEM B/H/W/DW */
 	{
 		"BPF_LDX_MEM | BPF_B, base",
@@ -8228,6 +8524,67 @@ static struct bpf_test tests[] = {
 		{ { 32, 0 } },
 		.stack_depth = 0,
 	},
+	/* BPF_LDX_MEMSX B/H/W */
+	{
+		"BPF_LDX_MEMSX | BPF_B",
+		.u.insns_int = {
+			BPF_LD_IMM64(R1, 0xdead0000000000f0ULL),
+			BPF_LD_IMM64(R2, 0xfffffffffffffff0ULL),
+			BPF_STX_MEM(BPF_DW, R10, R1, -8),
+#ifdef __BIG_ENDIAN
+			BPF_LDX_MEMSX(BPF_B, R0, R10, -1),
+#else
+			BPF_LDX_MEMSX(BPF_B, R0, R10, -8),
+#endif
+			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0 } },
+		.stack_depth = 8,
+	},
+	{
+		"BPF_LDX_MEMSX | BPF_H",
+		.u.insns_int = {
+			BPF_LD_IMM64(R1, 0xdead00000000f123ULL),
+			BPF_LD_IMM64(R2, 0xfffffffffffff123ULL),
+			BPF_STX_MEM(BPF_DW, R10, R1, -8),
+#ifdef __BIG_ENDIAN
+			BPF_LDX_MEMSX(BPF_H, R0, R10, -2),
+#else
+			BPF_LDX_MEMSX(BPF_H, R0, R10, -8),
+#endif
+			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0 } },
+		.stack_depth = 8,
+	},
+	{
+		"BPF_LDX_MEMSX | BPF_W",
+		.u.insns_int = {
+			BPF_LD_IMM64(R1, 0x00000000deadbeefULL),
+			BPF_LD_IMM64(R2, 0xffffffffdeadbeefULL),
+			BPF_STX_MEM(BPF_DW, R10, R1, -8),
+#ifdef __BIG_ENDIAN
+			BPF_LDX_MEMSX(BPF_W, R0, R10, -4),
+#else
+			BPF_LDX_MEMSX(BPF_W, R0, R10, -8),
+#endif
+			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0 } },
+		.stack_depth = 8,
+	},
 	/* BPF_STX_MEM B/H/W/DW */
 	{
 		"BPF_STX_MEM | BPF_B",
@@ -9474,6 +9831,20 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
+	/* BPF_JMP32 | BPF_JA */
+	{
+		"JMP32_JA: Unconditional jump: if (true) return 1",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_JMP32_IMM(BPF_JA, 0, 1, 0),
+			BPF_EXIT_INSN(),
+			BPF_ALU32_IMM(BPF_MOV, R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 1 } },
+	},
 	/* BPF_JMP | BPF_JSLT | BPF_K */
 	{
 		"JMP_JSLT_K: Signed jump: if (-2 < -1) return 1",
-- 
2.39.2

