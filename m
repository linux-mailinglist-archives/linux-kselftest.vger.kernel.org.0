Return-Path: <linux-kselftest+bounces-30675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE3BA88081
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B28B16DAC6
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED612C376B;
	Mon, 14 Apr 2025 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dVse3xQw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3B02BF3E5
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634163; cv=none; b=MvLvCJ/Ex9CfG8V7nkgd9pIfTth3nD2SxOmnNLmJwFzGYaCsKm3jHIPfDED1/UhPVbY0BKQXxBeBB+tz37kmsP7QJK8WRcq6U5f6yiFG1OXkVQAn9+Ey2+9GdNy4sCoMVta8zU8RQlHsa+Bkl2214v0nsPDFBIgNXHa3XfHDVNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634163; c=relaxed/simple;
	bh=0g+Edh6USTpd5ihh7LZYyx43fibTQ4c1N1dVq2+90nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQlkCSmox3HjzY5fqeycm4ifex95jFVtR11hA/j56tnKmqlrt7iDUHg7zNjAfuw3pWQL6D0Qyxj5txhll80yc8wuRVBMy5Doya3M82ThvzFvOJ7j/lDQoX0h8fEFYmQAYEdWDtWtq19QjZv2IaS49K79E+7e6pW8/uI4eIVFdAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dVse3xQw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so3634354f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 05:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744634159; x=1745238959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIpUsARUWkMqbtxQjxYky+3G1SaiCnjwvQ5qtBxu/rw=;
        b=dVse3xQworjjEpOBMRbvuKOqiEspYavZZDr2lIhIyn1Lc43OdSo0hrHEFpEmX03+tY
         Nev4ilU0vb3Uf8xwI13CSE8NaF+suTEL1XkJF4z9+Z/ZRJi/9fpJg64ipujhiCFsWtwd
         RkGB0xurPq5WXAirreMJdLuJANYo0zUUb+fIoUdYE6DavJg1zub2v74Nl1GvuNU967Mc
         W4ftiAjeDAfaaeNfDvC5kDnPJaSl8JyPOnTB9tgGIhK8FHLbPPeM467ZnsBmCzpDjJRM
         7lsWnlkKrpaDbDcHq+U2270fUy3O6rk4v9NoYyg2r9YuzfPLTrD9J0cTwllxtRXSPILy
         lAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744634159; x=1745238959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIpUsARUWkMqbtxQjxYky+3G1SaiCnjwvQ5qtBxu/rw=;
        b=MKAqV4Z6zy+8E9CaQn/Vf8H1H94vjuLVTYJDjcR8oW/KjqIBvpn2m3a74wgnEsZTNP
         gXJWZf0RY2QiFe6+c+JhkKyoNIe/S3kKg3z/R+LHEtMYDnK/jdYViUJdAEbCL2nUscVY
         Jh/Ng38u5uUBEBKk4f0wqjX8P3Vy1iKJOi93FeKz1wPDnO9KU+TV7S8ZKnbVdI1YXMHo
         HfE7KsqRY8uX5vMCIh2yQj9jNsbuVAxiBxm57VtpCIwbhy2ktF+o2WxPDVaj0FTUO1Yw
         sUucmYd9zt/ROlAeFAilMQrIkjzdsZpiFffT3fWujCbnr17KNnnAu0y+00K4RJiKLJtN
         bihg==
X-Forwarded-Encrypted: i=1; AJvYcCVhJ3e7NYcspvaF2Mk0Z8t/efHrqiTgKjKWAAmI8r4ZXG7q3HesW3hZJs9af2BrQV7fHsdMZb8txpYWh+43w/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsyhFK7MPLVnh/xtZAF4Y6ZEFiU84V24QVnENXnapdxoNwmcMi
	DsGMG3vOALqGtpxTHDOXgjvEkqPsyLcbF2JanvB52quPo/waYWoEHL1V9rgBdYk=
X-Gm-Gg: ASbGncs4W4PxbIk9v3SpCiUpa4PUMW47GgJPe/xAjeK7seNlHpJHf6YU/euwT0yZRRs
	ie/ZO8oXjU88vqbOuczLAAyqDfps99VxdvHGys31QKnDk2Dr7KOgxfEu20fVtc0BVfAB3M4t5m9
	y0yECSsrsERfd6k9dOU3pewYhTJ+sGntYeDTm144p82rDNx918e4VM9BdAvWE3PEELaT0Rtvh0q
	6r6ce6FtSM8l66lk4T2plr+0RNTYreeU8qJW3Z1gHwz24maNEPOPpQjIMK8LO8yBxa2WwMUIunU
	F+f4zr9lA51wtkCQeafDLFQC41PwdXJrLoLCQs4TFg==
X-Google-Smtp-Source: AGHT+IFDrZh+YjPFaqHf3F80j84MiX129xFRCZAGOcnrY6+GsAVEMqW9fElhgEaiVeryasKbjN28+Q==
X-Received: by 2002:a5d:584d:0:b0:391:1923:5a91 with SMTP id ffacd0b85a97d-39eaaecd7b8mr9549110f8f.55.1744634158732;
        Mon, 14 Apr 2025 05:35:58 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9780a0sm11003166f8f.50.2025.04.14.05.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 05:35:58 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 5/5] selftests: riscv: add misaligned access testing
Date: Mon, 14 Apr 2025 14:34:45 +0200
Message-ID: <20250414123543.1615478-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414123543.1615478-1-cleger@rivosinc.com>
References: <20250414123543.1615478-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This selftest tests (almost) all the currently emulated instruction
(except for the RV32 compressed ones which are left as a future
exercise for a RV32 user). For the FPU instructions, all the FPU
registers are tested.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 .../selftests/riscv/misaligned/.gitignore     |   1 +
 .../selftests/riscv/misaligned/Makefile       |  12 +
 .../selftests/riscv/misaligned/common.S       |  33 +++
 .../testing/selftests/riscv/misaligned/fpu.S  | 180 +++++++++++++
 tools/testing/selftests/riscv/misaligned/gp.S | 103 +++++++
 .../selftests/riscv/misaligned/misaligned.c   | 254 ++++++++++++++++++
 6 files changed, 583 insertions(+)
 create mode 100644 tools/testing/selftests/riscv/misaligned/.gitignore
 create mode 100644 tools/testing/selftests/riscv/misaligned/Makefile
 create mode 100644 tools/testing/selftests/riscv/misaligned/common.S
 create mode 100644 tools/testing/selftests/riscv/misaligned/fpu.S
 create mode 100644 tools/testing/selftests/riscv/misaligned/gp.S
 create mode 100644 tools/testing/selftests/riscv/misaligned/misaligned.c

diff --git a/tools/testing/selftests/riscv/misaligned/.gitignore b/tools/testing/selftests/riscv/misaligned/.gitignore
new file mode 100644
index 000000000000..5eff15a1f981
--- /dev/null
+++ b/tools/testing/selftests/riscv/misaligned/.gitignore
@@ -0,0 +1 @@
+misaligned
diff --git a/tools/testing/selftests/riscv/misaligned/Makefile b/tools/testing/selftests/riscv/misaligned/Makefile
new file mode 100644
index 000000000000..1aa40110c50d
--- /dev/null
+++ b/tools/testing/selftests/riscv/misaligned/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 ARM Limited
+# Originally tools/testing/arm64/abi/Makefile
+
+CFLAGS += -I$(top_srcdir)/tools/include
+
+TEST_GEN_PROGS := misaligned
+
+include ../../lib.mk
+
+$(OUTPUT)/misaligned: misaligned.c fpu.S gp.S
+	$(CC) -g3 -static -o$@ -march=rv64imafdc $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/misaligned/common.S b/tools/testing/selftests/riscv/misaligned/common.S
new file mode 100644
index 000000000000..8fa00035bd5d
--- /dev/null
+++ b/tools/testing/selftests/riscv/misaligned/common.S
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 Rivos Inc.
+ *
+ * Authors:
+ *     Clément Léger <cleger@rivosinc.com>
+ */
+
+.macro lb_sb temp, offset, src, dst
+	lb \temp, \offset(\src)
+	sb \temp, \offset(\dst)
+.endm
+
+.macro copy_long_to temp, src, dst
+	lb_sb \temp, 0, \src, \dst,
+	lb_sb \temp, 1, \src, \dst,
+	lb_sb \temp, 2, \src, \dst,
+	lb_sb \temp, 3, \src, \dst,
+	lb_sb \temp, 4, \src, \dst,
+	lb_sb \temp, 5, \src, \dst,
+	lb_sb \temp, 6, \src, \dst,
+	lb_sb \temp, 7, \src, \dst,
+.endm
+
+.macro sp_stack_prologue offset
+	addi sp, sp, -8
+	sub sp, sp, \offset
+.endm
+
+.macro sp_stack_epilogue offset
+	add sp, sp, \offset
+	addi sp, sp, 8
+.endm
diff --git a/tools/testing/selftests/riscv/misaligned/fpu.S b/tools/testing/selftests/riscv/misaligned/fpu.S
new file mode 100644
index 000000000000..d008bff58310
--- /dev/null
+++ b/tools/testing/selftests/riscv/misaligned/fpu.S
@@ -0,0 +1,180 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 Rivos Inc.
+ *
+ * Authors:
+ *     Clément Léger <cleger@rivosinc.com>
+ */
+
+#include "common.S"
+
+#define CASE_ALIGN		4
+
+.macro fpu_load_inst fpreg, inst, precision, load_reg
+.align CASE_ALIGN
+	\inst \fpreg, 0(\load_reg)
+	fmv.\precision fa0, \fpreg
+	j 2f
+.endm
+
+#define flw(__fpreg) fpu_load_inst __fpreg, flw, s, s1
+#define fld(__fpreg) fpu_load_inst __fpreg, fld, d, s1
+#define c_flw(__fpreg) fpu_load_inst __fpreg, c.flw, s, s1
+#define c_fld(__fpreg) fpu_load_inst __fpreg, c.fld, d, s1
+#define c_fldsp(__fpreg) fpu_load_inst __fpreg, c.fldsp, d, sp
+
+.macro fpu_store_inst fpreg, inst, precision, store_reg
+.align CASE_ALIGN
+	fmv.\precision \fpreg, fa0
+	\inst \fpreg, 0(\store_reg)
+	j 2f
+.endm
+
+#define fsw(__fpreg) fpu_store_inst __fpreg, fsw, s, s1
+#define fsd(__fpreg) fpu_store_inst __fpreg, fsd, d, s1
+#define c_fsw(__fpreg) fpu_store_inst __fpreg, c.fsw, s, s1
+#define c_fsd(__fpreg) fpu_store_inst __fpreg, c.fsd, d, s1
+#define c_fsdsp(__fpreg) fpu_store_inst __fpreg, c.fsdsp, d, sp
+
+.macro fp_test_prologue
+	move s1, a1
+	/*
+	 * Compute jump offset to store the correct FP register since we don't
+	 * have indirect FP register access (or at least we don't use this
+	 * extension so that works on all archs)
+	 */
+	sll t0, a0, CASE_ALIGN
+	la t2, 1f
+	add t0, t0, t2
+	jr t0
+.align	CASE_ALIGN
+1:
+.endm
+
+.macro fp_test_prologue_compressed
+	/* FP registers for compressed instructions starts from 8 to 16 */
+	addi a0, a0, -8
+	fp_test_prologue
+.endm
+
+#define fp_test_body_compressed(__inst_func) \
+	__inst_func(f8); \
+	__inst_func(f9); \
+	__inst_func(f10); \
+	__inst_func(f11); \
+	__inst_func(f12); \
+	__inst_func(f13); \
+	__inst_func(f14); \
+	__inst_func(f15); \
+2:
+
+#define fp_test_body(__inst_func) \
+	__inst_func(f0); \
+	__inst_func(f1); \
+	__inst_func(f2); \
+	__inst_func(f3); \
+	__inst_func(f4); \
+	__inst_func(f5); \
+	__inst_func(f6); \
+	__inst_func(f7); \
+	__inst_func(f8); \
+	__inst_func(f9); \
+	__inst_func(f10); \
+	__inst_func(f11); \
+	__inst_func(f12); \
+	__inst_func(f13); \
+	__inst_func(f14); \
+	__inst_func(f15); \
+	__inst_func(f16); \
+	__inst_func(f17); \
+	__inst_func(f18); \
+	__inst_func(f19); \
+	__inst_func(f20); \
+	__inst_func(f21); \
+	__inst_func(f22); \
+	__inst_func(f23); \
+	__inst_func(f24); \
+	__inst_func(f25); \
+	__inst_func(f26); \
+	__inst_func(f27); \
+	__inst_func(f28); \
+	__inst_func(f29); \
+	__inst_func(f30); \
+	__inst_func(f31); \
+2:
+.text
+
+#define __gen_test_inst(__inst, __suffix) \
+.global test_ ## __inst; \
+test_ ## __inst:; \
+	fp_test_prologue ## __suffix; \
+	fp_test_body ## __suffix(__inst); \
+	ret
+
+#define gen_test_inst_compressed(__inst) \
+	.option arch,+c; \
+	__gen_test_inst(c_ ## __inst, _compressed)
+
+#define gen_test_inst(__inst) \
+	.balign 16; \
+	.option push; \
+	.option arch,-c; \
+	__gen_test_inst(__inst, ); \
+	.option pop
+
+.macro fp_test_prologue_load_compressed_sp
+	copy_long_to t0, a1, sp
+.endm
+
+.macro fp_test_epilogue_load_compressed_sp
+.endm
+
+.macro fp_test_prologue_store_compressed_sp
+.endm
+
+.macro fp_test_epilogue_store_compressed_sp
+	copy_long_to t0, sp, a1
+.endm
+
+#define gen_inst_compressed_sp(__inst, __type) \
+	.global test_c_ ## __inst ## sp; \
+	test_c_ ## __inst ## sp:; \
+		sp_stack_prologue a2; \
+		fp_test_prologue_## __type ## _compressed_sp; \
+		fp_test_prologue_compressed; \
+		fp_test_body_compressed(c_ ## __inst ## sp); \
+		fp_test_epilogue_## __type ## _compressed_sp; \
+		sp_stack_epilogue a2; \
+		ret
+
+#define gen_test_load_compressed_sp(__inst) gen_inst_compressed_sp(__inst, load)
+#define gen_test_store_compressed_sp(__inst) gen_inst_compressed_sp(__inst, store)
+
+/*
+ * float_fsw_reg - Set a FP register from a register containing the value
+ * a0 = FP register index to be set
+ * a1 = addr where to store register value
+ * a2 = address offset
+ * a3 = value to be store
+ */
+gen_test_inst(fsw)
+
+/*
+ * float_flw_reg - Get a FP register value and return it
+ * a0 = FP register index to be retrieved
+ * a1 = addr to load register from
+ * a2 = address offset
+ */
+gen_test_inst(flw)
+
+gen_test_inst(fsd)
+#ifdef __riscv_compressed
+gen_test_inst_compressed(fsd)
+gen_test_store_compressed_sp(fsd)
+#endif
+
+gen_test_inst(fld)
+#ifdef __riscv_compressed
+gen_test_inst_compressed(fld)
+gen_test_load_compressed_sp(fld)
+#endif
diff --git a/tools/testing/selftests/riscv/misaligned/gp.S b/tools/testing/selftests/riscv/misaligned/gp.S
new file mode 100644
index 000000000000..f53f4c6d81dd
--- /dev/null
+++ b/tools/testing/selftests/riscv/misaligned/gp.S
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 Rivos Inc.
+ *
+ * Authors:
+ *     Clément Léger <cleger@rivosinc.com>
+ */
+
+#include "common.S"
+
+.text
+
+.macro __gen_test_inst inst, src_reg
+	\inst a2, 0(\src_reg)
+	move a0, a2
+.endm
+
+.macro gen_func_header func_name, rvc
+	.option arch,\rvc
+	.global test_\func_name
+	test_\func_name:
+.endm
+
+.macro gen_test_inst inst
+	.option push
+	gen_func_header \inst, -c
+	__gen_test_inst \inst, a0
+	.option pop
+	ret
+.endm
+
+.macro __gen_test_inst_c name, src_reg
+	.option push
+	gen_func_header c_\name, +c
+	 __gen_test_inst c.\name, \src_reg
+	.option pop
+	ret
+.endm
+
+.macro gen_test_inst_c name
+ 	__gen_test_inst_c \name, a0
+.endm
+
+
+.macro gen_test_inst_load_c_sp name
+	.option push
+	gen_func_header c_\name\()sp, +c
+	sp_stack_prologue a1
+	copy_long_to t0, a0, sp
+	c.ldsp a0, 0(sp)
+	sp_stack_epilogue a1
+	.option pop
+	ret
+.endm
+
+.macro lb_sp_sb_a0 reg, offset
+	lb_sb \reg, \offset, sp, a0
+.endm
+
+.macro gen_test_inst_store_c_sp inst_name
+	.option push
+	gen_func_header c_\inst_name\()sp, +c
+	/* Misalign stack pointer */
+	sp_stack_prologue a1
+	/* Misalign access */
+	c.sdsp a2, 0(sp)
+	copy_long_to t0, sp, a0
+	sp_stack_epilogue a1
+	.option pop
+	ret
+.endm
+
+
+ /*
+ * a0 = addr to load from
+ * a1 = address offset
+ * a2 = value to be loaded
+ */
+gen_test_inst lh
+gen_test_inst lhu
+gen_test_inst lw
+gen_test_inst lwu
+gen_test_inst ld
+#ifdef __riscv_compressed
+gen_test_inst_c lw
+gen_test_inst_c ld
+gen_test_inst_load_c_sp ld
+#endif
+
+/*
+ * a0 = addr where to store value
+ * a1 = address offset
+ * a2 = value to be stored
+ */
+gen_test_inst sh
+gen_test_inst sw
+gen_test_inst sd
+#ifdef __riscv_compressed
+gen_test_inst_c sw
+gen_test_inst_c sd
+gen_test_inst_store_c_sp sd
+#endif
+
diff --git a/tools/testing/selftests/riscv/misaligned/misaligned.c b/tools/testing/selftests/riscv/misaligned/misaligned.c
new file mode 100644
index 000000000000..c66aa87ec03e
--- /dev/null
+++ b/tools/testing/selftests/riscv/misaligned/misaligned.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Rivos Inc.
+ *
+ * Authors:
+ *     Clément Léger <cleger@rivosinc.com>
+ */
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/ptrace.h>
+#include "../../kselftest_harness.h"
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <float.h>
+#include <errno.h>
+#include <math.h>
+#include <string.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <inttypes.h>
+#include <ucontext.h>
+
+#include <sys/prctl.h>
+
+#define stringify(s) __stringify(s)
+#define __stringify(s) #s
+
+#define VAL16	0x1234
+#define VAL32	0xDEADBEEF
+#define VAL64	0x45674321D00DF789
+
+#define VAL_float	78951.234375
+#define VAL_double	567890.512396965789589290
+
+static bool float_equal(float a, float b)
+{
+	float scaled_epsilon;
+	float difference = fabsf(a - b);
+
+	// Scale to the largest value.
+	a = fabsf(a);
+	b = fabsf(b);
+	if (a > b)
+		scaled_epsilon = FLT_EPSILON * a;
+	else
+		scaled_epsilon = FLT_EPSILON * b;
+
+	return difference <= scaled_epsilon;
+}
+
+static bool double_equal(double a, double b)
+{
+	double scaled_epsilon;
+	double difference = fabsf(a - b);
+
+	// Scale to the largest value.
+	a = fabs(a);
+	b = fabs(b);
+	if (a > b)
+		scaled_epsilon = DBL_EPSILON * a;
+	else
+		scaled_epsilon = DBL_EPSILON * b;
+
+	return difference <= scaled_epsilon;
+}
+
+#define fpu_load_proto(__inst, __type) \
+extern __type test_ ## __inst(unsigned long fp_reg, void *addr, unsigned long offset, __type value)
+
+fpu_load_proto(flw, float);
+fpu_load_proto(fld, double);
+fpu_load_proto(c_flw, float);
+fpu_load_proto(c_fld, double);
+fpu_load_proto(c_fldsp, double);
+
+#define fpu_store_proto(__inst, __type) \
+extern void test_ ## __inst(unsigned long fp_reg, void *addr, unsigned long offset, __type value)
+
+fpu_store_proto(fsw, float);
+fpu_store_proto(fsd, double);
+fpu_store_proto(c_fsw, float);
+fpu_store_proto(c_fsd, double);
+fpu_store_proto(c_fsdsp, double);
+
+#define gp_load_proto(__inst, __type) \
+extern __type test_ ## __inst(void *addr, unsigned long offset, __type value)
+
+gp_load_proto(lh, uint16_t);
+gp_load_proto(lhu, uint16_t);
+gp_load_proto(lw, uint32_t);
+gp_load_proto(lwu, uint32_t);
+gp_load_proto(ld, uint64_t);
+gp_load_proto(c_lw, uint32_t);
+gp_load_proto(c_ld, uint64_t);
+gp_load_proto(c_ldsp, uint64_t);
+
+#define gp_store_proto(__inst, __type) \
+extern void test_ ## __inst(void *addr, unsigned long offset, __type value)
+
+gp_store_proto(sh, uint16_t);
+gp_store_proto(sw, uint32_t);
+gp_store_proto(sd, uint64_t);
+gp_store_proto(c_sw, uint32_t);
+gp_store_proto(c_sd, uint64_t);
+gp_store_proto(c_sdsp, uint64_t);
+
+#define TEST_GP_LOAD(__inst, __type_size)					\
+TEST(gp_load_ ## __inst)							\
+{										\
+	int offset, ret;							\
+	uint8_t buf[16] __attribute__((aligned(16)));				\
+										\
+	ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_NOPRINT);			\
+	ASSERT_EQ(ret, 0);							\
+										\
+	for (offset = 1; offset < __type_size / 8; offset++) {			\
+		uint ## __type_size ## _t val = VAL ## __type_size;		\
+		uint ## __type_size ## _t *ptr = (uint ## __type_size ## _t *) (buf + offset); \
+		memcpy(ptr, &val, sizeof(val));					\
+		val = test_ ## __inst(ptr, offset, val);			\
+		EXPECT_EQ(VAL ## __type_size, val);				\
+	}									\
+}
+
+TEST_GP_LOAD(lh, 16);
+TEST_GP_LOAD(lhu, 16);
+TEST_GP_LOAD(lw, 32);
+TEST_GP_LOAD(lwu, 32);
+TEST_GP_LOAD(ld, 64);
+#ifdef __riscv_compressed
+TEST_GP_LOAD(c_lw, 32);
+TEST_GP_LOAD(c_ld, 64);
+TEST_GP_LOAD(c_ldsp, 64);
+#endif
+
+#define TEST_GP_STORE(__inst, __type_size)					\
+TEST(gp_load_ ## __inst)							\
+{										\
+	int offset, ret;							\
+	uint8_t buf[16] __attribute__((aligned(16)));				\
+										\
+	ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_NOPRINT);			\
+	ASSERT_EQ(ret, 0);							\
+										\
+	for (offset = 1; offset < __type_size / 8; offset++) {			\
+		uint ## __type_size ## _t val = VAL ## __type_size;		\
+		uint ## __type_size ## _t *ptr = (uint ## __type_size ## _t *) (buf + offset); \
+		memset(ptr, 0, sizeof(val));					\
+		test_ ## __inst(ptr, offset, val);				\
+		memcpy(&val, ptr, sizeof(val));					\
+		EXPECT_EQ(VAL ## __type_size, val);				\
+	}									\
+}
+TEST_GP_STORE(sh, 16);
+TEST_GP_STORE(sw, 32);
+TEST_GP_STORE(sd, 64);
+#ifdef __riscv_compressed
+TEST_GP_STORE(c_sw, 32);
+TEST_GP_STORE(c_sd, 64);
+TEST_GP_STORE(c_sdsp, 64);
+#endif
+
+#define __TEST_FPU_LOAD(__type, __inst, __reg_start, __reg_end)			\
+TEST(fpu_load_ ## __inst)							\
+{										\
+	int i, ret, offset, fp_reg;						\
+	uint8_t buf[16] __attribute__((aligned(16)));				\
+										\
+	ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_NOPRINT);			\
+	ASSERT_EQ(ret, 0);							\
+										\
+	for (fp_reg = __reg_start; fp_reg < __reg_end; fp_reg++) {		\
+		for (offset = 1; offset < 4; offset++) {			\
+			void *load_addr = (buf + offset);			\
+			__type val = VAL_ ## __type ;				\
+										\
+			memcpy(load_addr, &val, sizeof(val));			\
+			val = test_ ## __inst(fp_reg, load_addr, offset, val);	\
+			EXPECT_TRUE(__type ##_equal(val, VAL_## __type));	\
+		}								\
+	}									\
+}
+#define TEST_FPU_LOAD(__type, __inst) \
+	__TEST_FPU_LOAD(__type, __inst, 0, 32)
+#define TEST_FPU_LOAD_COMPRESSED(__type, __inst) \
+	__TEST_FPU_LOAD(__type, __inst, 8, 16)
+
+TEST_FPU_LOAD(float, flw)
+TEST_FPU_LOAD(double, fld)
+#ifdef __riscv_compressed
+TEST_FPU_LOAD_COMPRESSED(double, c_fld)
+TEST_FPU_LOAD_COMPRESSED(double, c_fldsp)
+#endif
+
+#define __TEST_FPU_STORE(__type, __inst, __reg_start, __reg_end)		\
+TEST(fpu_store_ ## __inst)							\
+{										\
+	int i, ret, offset, fp_reg;						\
+	uint8_t buf[16] __attribute__((aligned(16)));				\
+										\
+	ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_NOPRINT);			\
+	ASSERT_EQ(ret, 0);							\
+										\
+	for (fp_reg = __reg_start; fp_reg < __reg_end; fp_reg++) {		\
+		for (offset = 1; offset < 4; offset++) {			\
+										\
+			void *store_addr = (buf + offset);			\
+			__type val = VAL_ ## __type ;				\
+										\
+			test_ ## __inst(fp_reg, store_addr, offset, val);	\
+			memcpy(&val, store_addr, sizeof(val));			\
+			EXPECT_TRUE(__type ## _equal(val, VAL_## __type));	\
+		}								\
+	}									\
+}
+#define TEST_FPU_STORE(__type, __inst) \
+	__TEST_FPU_STORE(__type, __inst, 0, 32)
+#define TEST_FPU_STORE_COMPRESSED(__type, __inst) \
+	__TEST_FPU_STORE(__type, __inst, 8, 16)
+
+TEST_FPU_STORE(float, fsw)
+TEST_FPU_STORE(double, fsd)
+#ifdef __riscv_compressed
+TEST_FPU_STORE_COMPRESSED(double, c_fsd)
+TEST_FPU_STORE_COMPRESSED(double, c_fsdsp)
+#endif
+
+TEST_SIGNAL(gen_sigbus, SIGBUS)
+{
+	uint32_t *ptr;
+	uint8_t buf[16] __attribute__((aligned(16)));
+	int ret;
+
+	ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_SIGBUS);
+	ASSERT_EQ(ret, 0);
+
+	ptr = (uint32_t *)(buf + 1);
+	*ptr = 0xDEADBEEFULL;
+}
+
+int main(int argc, char **argv)
+{
+	int ret, val;
+
+	ret = prctl(PR_GET_UNALIGN, &val);
+	if (ret == -1 && errno == EINVAL)
+		ksft_exit_skip("SKIP GET_UNALIGN_CTL not supported\n");
+
+	exit(test_harness_run(argc, argv));
+}
-- 
2.49.0


