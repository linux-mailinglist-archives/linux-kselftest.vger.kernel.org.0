Return-Path: <linux-kselftest+bounces-39705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA40B321B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 19:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09205C1069
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 17:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8535128B3EB;
	Fri, 22 Aug 2025 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Db8PlhDM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5327F732
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884844; cv=none; b=C/K3dladCx6MvHtLyJF9AYuXRzWY+iGqH96mf9VvYoTK8SHStFJYxlSVkTZaBHZgYLiw3wyia7t6gH6FWRSWpvb7H5dWQKNwPBcuo5F2wwoZGBErqnGAgy93bFi63JNyP4SEfCGiPXbuSn7sKoVBI523OQfvJgpEGrahM/ufUZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884844; c=relaxed/simple;
	bh=BV0hel6ZwTRfLcWIhyLCzYLrNPPpUC5DDGdvvs3aWKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuYhiHtUmBPSzVThAym4YYC+cR9RkoSvAooibcdpSFJhU5BmoUgazJg0uIfIt8OYdDRmb9iuM5+VQ9J82bQWL+HoraU21tif7EHa+QJ4//X24slCvhIgyWUEmuBUKdto8sLuuv5M1ISk8qEEkus4IVVUH/la2O0R2WGvo4ameNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Db8PlhDM; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b109c6532fso27386441cf.3
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 10:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755884841; x=1756489641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDpjZc97n4U0egjgFALLU1N3dP/taaCunEfrlMVFon0=;
        b=Db8PlhDMf/Ud6jD21bZpDuyvBglluHsdXzOHzTOM2tLS85uVmtxMQjB9nvM/AXNs4s
         I2sBGewpHgz7d+QshgTVNpSLwlmP8Di7pzLC/0TCX1jkDVANo2DNiKmJqU4p6hE8oJ4y
         AUZRWESR5Dgxz2S1/zc1wxSmI/k2rkm2Pc24lJZOqZcfk7HHsf3gLeo+vzuZHmRFZpAZ
         T3nuCRRiKCvAAAN92Bh0p3/QeCkW4ntKW4TObUyYYKECWtgJLWOEtjA2OURjrqHF5u5y
         etiIlcaIUUgyq4/tAGyxJRggjmkWtF2J6Zjfquw9P5iBYd4uYYvgVgxx6KpTlQwirFoN
         4tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755884841; x=1756489641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDpjZc97n4U0egjgFALLU1N3dP/taaCunEfrlMVFon0=;
        b=KGPcI5xGfQpYrr2EaFo8KrdJByX6YSZe6zCWJIk4NPt7u3+VsPlFgwZygnwe4XubKm
         NW4tDni0QbV5UI5691EAEYfokPtuBOUsJ/pImjiqR3XVxwLa+OEQH+oSNIbu0mj4N1Ij
         H9nEvJ1v6XVTgAUzRny560Ve7w/Ve7fC5oMoKj5rL/LApjlnTeyXZ+T7gDlSCM34VoHD
         kXYzJtVSApgbZHg5ygkb7O8QvqgptKReQJmB02KF96Zewz7XcFzX5kacEhxNqsNkulwH
         Ulmb8570BhAh5/RCVaGtFEibBFnIXP4+VtaCE2DjlGE1Sx9XwcisY5JXiqffGT08EN5c
         2A1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEAMlaxa/fOfZpGIQgk3yE4fN67GbtX4XTZrJfmA8E3Xu3xEuLQOKgcLxmUC8XuPSRBvh6wlG2+jma6sMlqp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxD3bPAA2xIqc7F7/kHWoLtKNMnieqXBCdW+fi7ILrEWqhHLN
	XXthfHbgTCB9k8iWbie2SY4mPf0qbDbIT8aNUJuHsI/6EYKTeMy2k74R4JIxayrtj0c=
X-Gm-Gg: ASbGnct3F04L3Neo5/O7nJHfiTAEMIYm2qHiBo4MfeInbsRtkZtrSJKnfteGJp0Z5RJ
	rJPqcwfP9Y7QVOIrFNakfa38pc7E0RqTCZCdupmbA9w2htOR4ezcbgFDmAcDD1I1fMursvF3e7q
	AUC7EPxr0Dqty32gSXmnsFSB3u54lIXdsbCMgGRUoWO67jwDaX0QBmqeb5rTKFrwb2bNa7G7Xy8
	6dgAAmXFLKxrNXLPMuPnX3mVD1jfgyesPIauj0EqXT9BUdYc/RXafIMbk+QYE1XKo5SW4HN3/wv
	QMOSWYfKj6D2mEbn9cTX+TbIa6bYru84UKxSGUewF5ZouXgkruxv+dtN6qn5+x+qKJtvLdCIJE4
	BhQECDsFWMdb/6I7xsG7ao8k57B/tToLy0eUQoo86ungqOYT01zIV3uwTE7rRHxpQL0Wi7Sowtl
	iw8UkNOvOnjX0jTman
X-Google-Smtp-Source: AGHT+IHNrCDOw6FL6pCo4DbPw+v/tihYCiWlLKD99o6wPnSaszr779gTketdS2R8nKaudoSSWZudpQ==
X-Received: by 2002:a05:622a:4007:b0:4b0:89c2:68e0 with SMTP id d75a77b69052e-4b2aab5d1f6mr45761641cf.60.1755884840514;
        Fri, 22 Aug 2025 10:47:20 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e6023asm3121361cf.53.2025.08.22.10.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:47:19 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Evan Green <evan@rivosinc.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Nylon Chen <nylon.chen@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH 1/8] riscv: Add insn.c, consolidate instruction decoding
Date: Fri, 22 Aug 2025 10:47:08 -0700
Message-ID: <20250822174715.1269138-2-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822174715.1269138-1-jesse@rivosinc.com>
References: <20250822174715.1269138-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Various parts of the kernel decode and read instruction from memory.
Functions like get_insn, GET_INSN_LENGTH and riscv_insn_is_c are defined
in multiple places. Consolidate these functions into the insn.h and the
newly added insn.c.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
RFC -> V1:
 - No change
V2 -> V1:
 - No change
---
 arch/riscv/include/asm/bug.h         |  12 ---
 arch/riscv/include/asm/insn.h        | 131 ++++++++++++++++++++++-
 arch/riscv/kernel/Makefile           |   1 +
 arch/riscv/kernel/insn.c             | 151 +++++++++++++++++++++++++++
 arch/riscv/kernel/kgdb.c             | 102 +-----------------
 arch/riscv/kernel/probes/kprobes.c   |   1 +
 arch/riscv/kernel/traps.c            |   5 +-
 arch/riscv/kernel/traps_misaligned.c |  93 ++++-------------
 8 files changed, 309 insertions(+), 187 deletions(-)
 create mode 100644 arch/riscv/kernel/insn.c

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 1aaea81fb141..a2777eb67ad1 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -12,21 +12,9 @@
 
 #include <asm/asm.h>
 
-#define __INSN_LENGTH_MASK  _UL(0x3)
-#define __INSN_LENGTH_32    _UL(0x3)
-#define __COMPRESSED_INSN_MASK	_UL(0xffff)
-
 #define __BUG_INSN_32	_UL(0x00100073) /* ebreak */
 #define __BUG_INSN_16	_UL(0x9002) /* c.ebreak */
 
-#define GET_INSN_LENGTH(insn)						\
-({									\
-	unsigned long __len;						\
-	__len = ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) ?	\
-		4UL : 2UL;						\
-	__len;								\
-})
-
 typedef u32 bug_insn_t;
 
 #ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index 09fde95a5e8f..ba74e5b8262c 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -64,6 +64,7 @@
 #define RVG_RS2_OPOFF		20
 #define RVG_RD_OPOFF		7
 #define RVG_RS1_MASK		GENMASK(4, 0)
+#define RVG_RS2_MASK		GENMASK(4, 0)
 #define RVG_RD_MASK		GENMASK(4, 0)
 
 /* The bit field of immediate value in RVC J instruction */
@@ -121,17 +122,27 @@
 #define RVC_C0_RS1_OPOFF	7
 #define RVC_C0_RS2_OPOFF	2
 #define RVC_C0_RD_OPOFF		2
+#define RVC_C0_RS1_MASK		GENMASK(2, 0)
+#define RVC_C0_RS2_MASK		GENMASK(2, 0)
+#define RVC_C0_RD_MASK		GENMASK(2, 0)
+#define RVC_C0_REG_OFFSET	8
 
 /* The register offset in RVC op=C1 instruction */
 #define RVC_C1_RS1_OPOFF	7
 #define RVC_C1_RS2_OPOFF	2
 #define RVC_C1_RD_OPOFF		7
+#define RVC_C1_RS1_MASK		GENMASK(2, 0)
+#define RVC_C1_RS2_MASK		GENMASK(2, 0)
+#define RVC_C1_RD_MASK		GENMASK(2, 0)
+#define RVC_C1_REG_OFFSET	8
 
 /* The register offset in RVC op=C2 instruction */
 #define RVC_C2_RS1_OPOFF	7
 #define RVC_C2_RS2_OPOFF	2
 #define RVC_C2_RD_OPOFF		7
 #define RVC_C2_RS1_MASK		GENMASK(4, 0)
+#define RVC_C2_RS2_MASK		GENMASK(4, 0)
+#define RVC_C2_RD_MASK		GENMASK(4, 0)
 
 /* parts of opcode for RVG*/
 #define RVG_OPCODE_FENCE	0x0f
@@ -226,12 +237,26 @@
 #define RVC_MASK_C_EBREAK	0xffff
 #define RVG_MASK_EBREAK		0xffffffff
 #define RVG_MASK_SRET		0xffffffff
+#define RVC_MASK_C		GENMASK(15, 0)
 
 #define __INSN_LENGTH_MASK	_UL(0x3)
 #define __INSN_LENGTH_GE_32	_UL(0x3)
 #define __INSN_OPCODE_MASK	_UL(0x7F)
 #define __INSN_BRANCH_OPCODE	_UL(RVG_OPCODE_BRANCH)
 
+#define GET_INSN_LENGTH(insn)						\
+({									\
+	unsigned long __len;						\
+	__len = ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_GE_32) ?	\
+		4UL : 2UL;						\
+	__len;								\
+})
+
+static __always_inline bool riscv_insn_is_c(u32 code)
+{
+	return (code & (__INSN_LENGTH_MASK)) != (__INSN_LENGTH_GE_32);
+}
+
 #define __RISCV_INSN_FUNCS(name, mask, val)				\
 static __always_inline bool riscv_insn_is_##name(u32 code)		\
 {									\
@@ -260,7 +285,7 @@ __RISCV_INSN_FUNCS(c_bnez, RVC_MASK_C_BNEZ, RVC_MATCH_C_BNEZ)
 __RISCV_INSN_FUNCS(c_ebreak, RVC_MASK_C_EBREAK, RVC_MATCH_C_EBREAK)
 __RISCV_INSN_FUNCS(ebreak, RVG_MASK_EBREAK, RVG_MATCH_EBREAK)
 __RISCV_INSN_FUNCS(sret, RVG_MASK_SRET, RVG_MATCH_SRET)
-__RISCV_INSN_FUNCS(fence, RVG_MASK_FENCE, RVG_MATCH_FENCE);
+__RISCV_INSN_FUNCS(fence, RVG_MASK_FENCE, RVG_MATCH_FENCE)
 
 /* special case to catch _any_ system instruction */
 static __always_inline bool riscv_insn_is_system(u32 code)
@@ -295,6 +320,10 @@ static __always_inline bool riscv_insn_is_c_jalr(u32 code)
 	({typeof(x) x_ = (x); \
 	(RV_X(x_, RVG_RS1_OPOFF, RVG_RS1_MASK)); })
 
+#define RV_EXTRACT_RS2_REG(x) \
+	({typeof(x) x_ = (x); \
+	(RV_X(x_, RVG_RS2_OPOFF, RVG_RS2_MASK)); })
+
 #define RV_EXTRACT_RD_REG(x) \
 	({typeof(x) x_ = (x); \
 	(RV_X(x_, RVG_RD_OPOFF, RVG_RD_MASK)); })
@@ -322,9 +351,41 @@ static __always_inline bool riscv_insn_is_c_jalr(u32 code)
 	(RV_X(x_, RV_B_IMM_11_OPOFF, RV_B_IMM_11_MASK) << RV_B_IMM_11_OFF) | \
 	(RV_IMM_SIGN(x_) << RV_B_IMM_SIGN_OFF); })
 
+#define RVC_EXTRACT_C0_RS1_REG(x) \
+	({typeof(x) x_ = (x); \
+	(RVC_X(x_, RVC_C0_RS1_OPOFF, RVC_C0_RS1_MASK)); })
+
+#define RVC_EXTRACT_C0_RS2_REG(x) \
+	({typeof(x) x_ = (x); \
+	(RVC_X(x_, RVC_C0_RS2_OPOFF, RVC_C0_RS2_MASK)); })
+
+#define RVC_EXTRACT_C0_RD_REG(x) \
+	({typeof(x) x_ = (x); \
+	(RVC_X(x_, RVC_C0_RD_OPOFF, RVC_C0_RD_MASK)); })
+
+#define RVC_EXTRACT_C1_RS1_REG(x) \
+	({typeof(x) x_ = (x); \
+	(RVC_X(x_, RVC_C1_RS1_OPOFF, RVC_C1_RS1_MASK)); })
+
+#define RVC_EXTRACT_C1_RS2_REG(x) \
+	({typeof(x) x_ = (x); \
+	(RVC_X(x_, RVC_C1_RS2_OPOFF, RVC_C1_RS2_MASK)); })
+
+#define RVC_EXTRACT_C1_RD_REG(x) \
+	({typeof(x) x_ = (x); \
+	(RVC_X(x_, RVC_C1_RD_OPOFF, RVC_C1_RD_MASK)); })
+
 #define RVC_EXTRACT_C2_RS1_REG(x) \
 	({typeof(x) x_ = (x); \
-	(RV_X(x_, RVC_C2_RS1_OPOFF, RVC_C2_RS1_MASK)); })
+	(RVC_X(x_, RVC_C2_RS1_OPOFF, RVC_C2_RS1_MASK)); })
+
+#define RVC_EXTRACT_C2_RS2_REG(x) \
+	({typeof(x) x_ = (x); \
+	(RVC_X(x_, RVC_C2_RS2_OPOFF, RVC_C2_RS2_MASK)); })
+
+#define RVC_EXTRACT_C2_RD_REG(x) \
+	({typeof(x) x_ = (x); \
+	(RVC_X(x_, RVC_C2_RD_OPOFF, RVC_C2_RD_MASK)); })
 
 #define RVC_EXTRACT_JTYPE_IMM(x) \
 	({typeof(x) x_ = (x); \
@@ -354,6 +415,66 @@ static __always_inline bool riscv_insn_is_c_jalr(u32 code)
 
 #define RVV_EXRACT_VL_VS_WIDTH(x) RVFDQ_EXTRACT_FL_FS_WIDTH(x)
 
+/*
+ * Get the rs1 register number from RV or RVC instruction.
+ *
+ * @insn: instruction to process
+ * Return: rs1 register
+ */
+static inline unsigned int riscv_insn_extract_rs1_reg(u32 insn)
+{
+	switch (RVC_INSN_OPCODE_MASK & insn) {
+	case RVC_OPCODE_C0:
+		return RVC_EXTRACT_C0_RS1_REG(insn) + RVC_C0_REG_OFFSET;
+	case RVC_OPCODE_C1:
+		return RVC_EXTRACT_C1_RS1_REG(insn) + RVC_C1_REG_OFFSET;
+	case RVC_OPCODE_C2:
+		return RVC_EXTRACT_C2_RS1_REG(insn);
+	default:
+		return RV_EXTRACT_RS1_REG(insn);
+	}
+}
+
+/*
+ * Get the rs2 register number from RV or RVC instruction.
+ *
+ * @insn: instruction to process
+ * Return: rs2 register
+ */
+static inline unsigned int riscv_insn_extract_rs2_reg(u32 insn)
+{
+	switch (RVC_INSN_OPCODE_MASK & insn) {
+	case RVC_OPCODE_C0:
+		return RVC_EXTRACT_C0_RS2_REG(insn) + RVC_C0_REG_OFFSET;
+	case RVC_OPCODE_C1:
+		return RVC_EXTRACT_C1_RS2_REG(insn) + RVC_C1_REG_OFFSET;
+	case RVC_OPCODE_C2:
+		return RVC_EXTRACT_C2_RS2_REG(insn);
+	default:
+		return RV_EXTRACT_RS2_REG(insn);
+	}
+}
+
+/*
+ * Get the rd register number from RV or RVC instruction.
+ *
+ * @insn: instruction to process
+ * Return: rd register
+ */
+static inline unsigned int riscv_insn_extract_rd_reg(u32 insn)
+{
+	switch (RVC_INSN_OPCODE_MASK & insn) {
+	case RVC_OPCODE_C0:
+		return RVC_EXTRACT_C0_RD_REG(insn) + RVC_C0_REG_OFFSET;
+	case RVC_OPCODE_C1:
+		return RVC_EXTRACT_C1_RD_REG(insn) + RVC_C1_REG_OFFSET;
+	case RVC_OPCODE_C2:
+		return RVC_EXTRACT_C2_RD_REG(insn);
+	default:
+		return RV_EXTRACT_RD_REG(insn);
+	}
+}
+
 /*
  * Get the immediate from a J-type instruction.
  *
@@ -428,4 +549,10 @@ static inline void riscv_insn_insert_utype_itype_imm(u32 *utype_insn, u32 *itype
 	*utype_insn |= (imm & RV_U_IMM_31_12_MASK) + ((imm & BIT(11)) << 1);
 	*itype_insn |= ((imm & RV_I_IMM_11_0_MASK) << RV_I_IMM_11_0_OPOFF);
 }
+
+#include <asm/ptrace.h>
+
+int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn);
+unsigned long get_step_address(struct pt_regs *regs, u32 code);
+
 #endif /* _ASM_RISCV_INSN_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f7480c9c6f8d..4f719b09e5ad 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_RISCV_ALTERNATIVE) += alternative.o
 obj-y	+= cpu.o
 obj-y	+= cpufeature.o
 obj-y	+= entry.o
+obj-y	+= insn.o
 obj-y	+= irq.o
 obj-y	+= process.o
 obj-y	+= ptrace.o
diff --git a/arch/riscv/kernel/insn.c b/arch/riscv/kernel/insn.c
new file mode 100644
index 000000000000..dd2a6ef9fd25
--- /dev/null
+++ b/arch/riscv/kernel/insn.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Rivos, Inc
+ */
+#include <asm/insn.h>
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
+
+#define __read_insn(regs, insn, insn_addr, type)	\
+({							\
+	int __ret;					\
+							\
+	if (user_mode(regs)) {				\
+		__ret = get_user(insn, (type __user *) insn_addr); \
+	} else {					\
+		insn = *(type *)insn_addr;		\
+		__ret = 0;				\
+	}						\
+							\
+	__ret;						\
+})
+
+/*
+ * Update a set of two instructions (U-type + I-type) with an immediate value.
+ *
+ * Used for example in auipc+jalrs pairs the U-type instructions contains
+ * a 20bit upper immediate representing bits[31:12], while the I-type
+ * instruction contains a 12bit immediate representing bits[11:0].
+ *
+ * This also takes into account that both separate immediates are
+ * considered as signed values, so if the I-type immediate becomes
+ * negative (BIT(11) set) the U-type part gets adjusted.
+ *
+ * @regs: pointer to the utype instruction of the pair
+ * @epc: pointer to the itype instruction of the pair
+ * @r_insn: the immediate to insert into the two instructions
+ * Return: combined immediate
+ */
+int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
+{
+	ulong insn = 0;
+
+	if (epc & 0x2) {
+		ulong tmp = 0;
+
+		if (__read_insn(regs, insn, epc, u16))
+			return -EFAULT;
+		/* __get_user() uses regular "lw" which sign extend the loaded
+		 * value make sure to clear higher order bits in case we "or" it
+		 * below with the upper 16 bits half.
+		 */
+		insn &= RVC_MASK_C;
+		if (riscv_insn_is_c(insn)) {
+			*r_insn = insn;
+			return 0;
+		}
+		epc += sizeof(u16);
+		if (__read_insn(regs, tmp, epc, u16))
+			return -EFAULT;
+		*r_insn = (tmp << 16) | insn;
+
+		return 0;
+	} else {
+		if (__read_insn(regs, insn, epc, u32))
+			return -EFAULT;
+		if (!riscv_insn_is_c(insn)) {
+			*r_insn = insn;
+			return 0;
+		}
+		insn &= RVC_MASK_C;
+		*r_insn = insn;
+
+		return 0;
+	}
+}
+
+/* Calculate the new address for after a step */
+unsigned long get_step_address(struct pt_regs *regs, u32 code)
+{
+	unsigned long pc = regs->epc;
+	unsigned int rs1_num, rs2_num;
+
+	if ((code & __INSN_LENGTH_MASK) != __INSN_LENGTH_GE_32) {
+		if (riscv_insn_is_c_jalr(code) ||
+		    riscv_insn_is_c_jr(code)) {
+			rs1_num = riscv_insn_extract_rs1_reg(code);
+			return regs_get_register(regs, rs1_num);
+		} else if (riscv_insn_is_c_j(code) ||
+			   riscv_insn_is_c_jal(code)) {
+			return RVC_EXTRACT_JTYPE_IMM(code) + pc;
+		} else if (riscv_insn_is_c_beqz(code)) {
+			rs1_num = riscv_insn_extract_rs1_reg(code);
+			if (!rs1_num || regs_get_register(regs, rs1_num) == 0)
+				return RVC_EXTRACT_BTYPE_IMM(code) + pc;
+			else
+				return pc + 2;
+		} else if (riscv_insn_is_c_bnez(code)) {
+			rs1_num = riscv_insn_extract_rs1_reg(RVC_C1_RS1_OPOFF);
+			if (rs1_num && regs_get_register(regs, rs1_num) != 0)
+				return RVC_EXTRACT_BTYPE_IMM(code) + pc;
+			else
+				return pc + 2;
+		} else {
+			return pc + 2;
+		}
+	} else {
+		if ((code & __INSN_OPCODE_MASK) == __INSN_BRANCH_OPCODE) {
+			bool result = false;
+			long imm = RV_EXTRACT_BTYPE_IMM(code);
+			unsigned long rs1_val = 0, rs2_val = 0;
+
+			rs1_num = riscv_insn_extract_rs1_reg(code);
+			rs2_num = riscv_insn_extract_rs2_reg(code);
+			if (rs1_num)
+				rs1_val = regs_get_register(regs, rs1_num);
+			if (rs2_num)
+				rs2_val = regs_get_register(regs, rs2_num);
+
+			if (riscv_insn_is_beq(code))
+				result = (rs1_val == rs2_val) ? true : false;
+			else if (riscv_insn_is_bne(code))
+				result = (rs1_val != rs2_val) ? true : false;
+			else if (riscv_insn_is_blt(code))
+				result =
+				    ((long)rs1_val <
+				     (long)rs2_val) ? true : false;
+			else if (riscv_insn_is_bge(code))
+				result =
+				    ((long)rs1_val >=
+				     (long)rs2_val) ? true : false;
+			else if (riscv_insn_is_bltu(code))
+				result = (rs1_val < rs2_val) ? true : false;
+			else if (riscv_insn_is_bgeu(code))
+				result = (rs1_val >= rs2_val) ? true : false;
+			if (result)
+				return imm + pc;
+			else
+				return pc + 4;
+		} else if (riscv_insn_is_jal(code)) {
+			return RV_EXTRACT_JTYPE_IMM(code) + pc;
+		} else if (riscv_insn_is_jalr(code)) {
+			rs1_num = riscv_insn_extract_rs1_reg(code);
+			return RV_EXTRACT_ITYPE_IMM(code) +
+			       (rs1_num ? regs_get_register(regs, rs1_num) : 0);
+		} else if (riscv_insn_is_sret(code)) {
+			return pc;
+		} else {
+			return pc + 4;
+		}
+	}
+}
diff --git a/arch/riscv/kernel/kgdb.c b/arch/riscv/kernel/kgdb.c
index 9f3db3503dab..aafc1424fc81 100644
--- a/arch/riscv/kernel/kgdb.c
+++ b/arch/riscv/kernel/kgdb.c
@@ -23,111 +23,19 @@ enum {
 static unsigned long stepped_address;
 static unsigned int stepped_opcode;
 
-static int decode_register_index(unsigned long opcode, int offset)
-{
-	return (opcode >> offset) & 0x1F;
-}
-
-static int decode_register_index_short(unsigned long opcode, int offset)
-{
-	return ((opcode >> offset) & 0x7) + 8;
-}
-
-/* Calculate the new address for after a step */
-static int get_step_address(struct pt_regs *regs, unsigned long *next_addr)
-{
-	unsigned long pc = regs->epc;
-	unsigned long *regs_ptr = (unsigned long *)regs;
-	unsigned int rs1_num, rs2_num;
-	int op_code;
-
-	if (get_kernel_nofault(op_code, (void *)pc))
-		return -EINVAL;
-	if ((op_code & __INSN_LENGTH_MASK) != __INSN_LENGTH_GE_32) {
-		if (riscv_insn_is_c_jalr(op_code) ||
-		    riscv_insn_is_c_jr(op_code)) {
-			rs1_num = decode_register_index(op_code, RVC_C2_RS1_OPOFF);
-			*next_addr = regs_ptr[rs1_num];
-		} else if (riscv_insn_is_c_j(op_code) ||
-			   riscv_insn_is_c_jal(op_code)) {
-			*next_addr = RVC_EXTRACT_JTYPE_IMM(op_code) + pc;
-		} else if (riscv_insn_is_c_beqz(op_code)) {
-			rs1_num = decode_register_index_short(op_code,
-							      RVC_C1_RS1_OPOFF);
-			if (!rs1_num || regs_ptr[rs1_num] == 0)
-				*next_addr = RVC_EXTRACT_BTYPE_IMM(op_code) + pc;
-			else
-				*next_addr = pc + 2;
-		} else if (riscv_insn_is_c_bnez(op_code)) {
-			rs1_num =
-			    decode_register_index_short(op_code, RVC_C1_RS1_OPOFF);
-			if (rs1_num && regs_ptr[rs1_num] != 0)
-				*next_addr = RVC_EXTRACT_BTYPE_IMM(op_code) + pc;
-			else
-				*next_addr = pc + 2;
-		} else {
-			*next_addr = pc + 2;
-		}
-	} else {
-		if ((op_code & __INSN_OPCODE_MASK) == __INSN_BRANCH_OPCODE) {
-			bool result = false;
-			long imm = RV_EXTRACT_BTYPE_IMM(op_code);
-			unsigned long rs1_val = 0, rs2_val = 0;
-
-			rs1_num = decode_register_index(op_code, RVG_RS1_OPOFF);
-			rs2_num = decode_register_index(op_code, RVG_RS2_OPOFF);
-			if (rs1_num)
-				rs1_val = regs_ptr[rs1_num];
-			if (rs2_num)
-				rs2_val = regs_ptr[rs2_num];
-
-			if (riscv_insn_is_beq(op_code))
-				result = (rs1_val == rs2_val) ? true : false;
-			else if (riscv_insn_is_bne(op_code))
-				result = (rs1_val != rs2_val) ? true : false;
-			else if (riscv_insn_is_blt(op_code))
-				result =
-				    ((long)rs1_val <
-				     (long)rs2_val) ? true : false;
-			else if (riscv_insn_is_bge(op_code))
-				result =
-				    ((long)rs1_val >=
-				     (long)rs2_val) ? true : false;
-			else if (riscv_insn_is_bltu(op_code))
-				result = (rs1_val < rs2_val) ? true : false;
-			else if (riscv_insn_is_bgeu(op_code))
-				result = (rs1_val >= rs2_val) ? true : false;
-			if (result)
-				*next_addr = imm + pc;
-			else
-				*next_addr = pc + 4;
-		} else if (riscv_insn_is_jal(op_code)) {
-			*next_addr = RV_EXTRACT_JTYPE_IMM(op_code) + pc;
-		} else if (riscv_insn_is_jalr(op_code)) {
-			rs1_num = decode_register_index(op_code, RVG_RS1_OPOFF);
-			if (rs1_num)
-				*next_addr = ((unsigned long *)regs)[rs1_num];
-			*next_addr += RV_EXTRACT_ITYPE_IMM(op_code);
-		} else if (riscv_insn_is_sret(op_code)) {
-			*next_addr = pc;
-		} else {
-			*next_addr = pc + 4;
-		}
-	}
-	return 0;
-}
-
 static int do_single_step(struct pt_regs *regs)
 {
 	/* Determine where the target instruction will send us to */
-	unsigned long addr = 0;
-	int error = get_step_address(regs, &addr);
+	unsigned long addr, insn;
+	int error = get_insn(regs, regs->epc, &insn);
 
 	if (error)
 		return error;
 
+	addr = get_step_address(regs, insn);
+
 	/* Store the op code in the stepped address */
-	error = get_kernel_nofault(stepped_opcode, (void *)addr);
+	error = get_insn(regs, addr, stepped_opcode);
 	if (error)
 		return error;
 
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index c0738d6c6498..6a9cfb0b664a 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -12,6 +12,7 @@
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
 #include <asm/bug.h>
+#include <asm/insn.h>
 #include <asm/text-patching.h>
 
 #include "decode-insn.h"
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 9c83848797a7..938a8b841f94 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -26,6 +26,7 @@
 #include <asm/bug.h>
 #include <asm/cfi.h>
 #include <asm/csr.h>
+#include <asm/insn.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/syscall.h>
@@ -409,10 +410,10 @@ int is_valid_bugaddr(unsigned long pc)
 		return 0;
 	if (get_kernel_nofault(insn, (bug_insn_t *)pc))
 		return 0;
-	if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32)
+	if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_GE_32)
 		return (insn == __BUG_INSN_32);
 	else
-		return ((insn & __COMPRESSED_INSN_MASK) == __BUG_INSN_16);
+		return ((insn & RVC_MASK_C) == __BUG_INSN_16);
 }
 #endif /* CONFIG_GENERIC_BUG */
 
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 77c788660223..42a50e21b1d2 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -10,12 +10,13 @@
 #include <linux/irq.h>
 #include <linux/stringify.h>
 
-#include <asm/processor.h>
-#include <asm/ptrace.h>
+#include <asm/cpufeature.h>
 #include <asm/csr.h>
 #include <asm/entry-common.h>
 #include <asm/hwprobe.h>
-#include <asm/cpufeature.h>
+#include <asm/insn.h>
+#include <asm/processor.h>
+#include <asm/ptrace.h>
 #include <asm/vector.h>
 
 #define INSN_MATCH_LB			0x3
@@ -112,25 +113,22 @@
 #define SH_RS2				20
 #define SH_RS2C				2
 
-#define RV_X(x, s, n)			(((x) >> (s)) & ((1 << (n)) - 1))
-#define RVC_LW_IMM(x)			((RV_X(x, 6, 1) << 2) | \
-					 (RV_X(x, 10, 3) << 3) | \
-					 (RV_X(x, 5, 1) << 6))
-#define RVC_LD_IMM(x)			((RV_X(x, 10, 3) << 3) | \
-					 (RV_X(x, 5, 2) << 6))
-#define RVC_LWSP_IMM(x)			((RV_X(x, 4, 3) << 2) | \
+#define RVC_LW_IMM(x)			((RV_X(x, 6, 0x1) << 2) | \
+					 (RV_X(x, 10, 0x7) << 3) | \
+					 (RV_X(x, 5, 0x1) << 6))
+#define RVC_LD_IMM(x)			((RV_X(x, 10, 0x7) << 3) | \
+					 (RV_X(x, 5, 0x3) << 6))
+#define RVC_LWSP_IMM(x)			((RV_X(x, 4, 0x7) << 2) | \
+					 (RV_X(x, 12, 0x1) << 5) | \
+					 (RV_X(x, 2, 0x3) << 6))
+#define RVC_LDSP_IMM(x)			((RV_X(x, 5, 0x3) << 3) | \
 					 (RV_X(x, 12, 1) << 5) | \
-					 (RV_X(x, 2, 2) << 6))
-#define RVC_LDSP_IMM(x)			((RV_X(x, 5, 2) << 3) | \
-					 (RV_X(x, 12, 1) << 5) | \
-					 (RV_X(x, 2, 3) << 6))
-#define RVC_SWSP_IMM(x)			((RV_X(x, 9, 4) << 2) | \
-					 (RV_X(x, 7, 2) << 6))
-#define RVC_SDSP_IMM(x)			((RV_X(x, 10, 3) << 3) | \
-					 (RV_X(x, 7, 3) << 6))
-#define RVC_RS1S(insn)			(8 + RV_X(insn, SH_RD, 3))
-#define RVC_RS2S(insn)			(8 + RV_X(insn, SH_RS2C, 3))
-#define RVC_RS2(insn)			RV_X(insn, SH_RS2C, 5)
+					 (RV_X(x, 2, 0x7) << 6))
+#define RVC_SWSP_IMM(x)			((RV_X(x, 9, 0xf) << 2) | \
+					 (RV_X(x, 7, 0x3) << 6))
+#define RVC_SDSP_IMM(x)			((RV_X(x, 10, 0x7) << 3) | \
+					 (RV_X(x, 7, 0x7) << 6))
+#define RVC_RS2S(insn)			(8 + RV_X(insn, SH_RS2C, 0x7))
 
 #define SHIFT_RIGHT(x, y)		\
 	((y) < 0 ? ((x) << -(y)) : ((x) >> (y)))
@@ -146,7 +144,6 @@
 
 #define GET_RS1(insn, regs)		(*REG_PTR(insn, SH_RS1, regs))
 #define GET_RS2(insn, regs)		(*REG_PTR(insn, SH_RS2, regs))
-#define GET_RS1S(insn, regs)		(*REG_PTR(RVC_RS1S(insn), 0, regs))
 #define GET_RS2S(insn, regs)		(*REG_PTR(RVC_RS2S(insn), 0, regs))
 #define GET_RS2C(insn, regs)		(*REG_PTR(insn, SH_RS2C, regs))
 #define GET_SP(regs)			(*REG_PTR(2, 0, regs))
@@ -270,58 +267,6 @@ static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
 #define GET_F32_RS2C(insn, regs) (get_f32_rs(insn, 2, regs))
 #define GET_F32_RS2S(insn, regs) (get_f32_rs(RVC_RS2S(insn), 0, regs))
 
-#define __read_insn(regs, insn, insn_addr, type)	\
-({							\
-	int __ret;					\
-							\
-	if (user_mode(regs)) {				\
-		__ret = get_user(insn, (type __user *) insn_addr); \
-	} else {					\
-		insn = *(type *)insn_addr;		\
-		__ret = 0;				\
-	}						\
-							\
-	__ret;						\
-})
-
-static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
-{
-	ulong insn = 0;
-
-	if (epc & 0x2) {
-		ulong tmp = 0;
-
-		if (__read_insn(regs, insn, epc, u16))
-			return -EFAULT;
-		/* __get_user() uses regular "lw" which sign extend the loaded
-		 * value make sure to clear higher order bits in case we "or" it
-		 * below with the upper 16 bits half.
-		 */
-		insn &= GENMASK(15, 0);
-		if ((insn & __INSN_LENGTH_MASK) != __INSN_LENGTH_32) {
-			*r_insn = insn;
-			return 0;
-		}
-		epc += sizeof(u16);
-		if (__read_insn(regs, tmp, epc, u16))
-			return -EFAULT;
-		*r_insn = (tmp << 16) | insn;
-
-		return 0;
-	} else {
-		if (__read_insn(regs, insn, epc, u32))
-			return -EFAULT;
-		if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) {
-			*r_insn = insn;
-			return 0;
-		}
-		insn &= GENMASK(15, 0);
-		*r_insn = insn;
-
-		return 0;
-	}
-}
-
 union reg_data {
 	u8 data_bytes[8];
 	ulong data_ulong;
-- 
2.43.0


