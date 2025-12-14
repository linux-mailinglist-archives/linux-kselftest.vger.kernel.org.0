Return-Path: <linux-kselftest+bounces-47572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7424FCBBDA2
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 17:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDBA2302ABBF
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E942E0902;
	Sun, 14 Dec 2025 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ32tbVo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2679A22CBC0
	for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765730164; cv=none; b=NHtQoCvB3B5XTIjSio5T931GpRZ4KhAyKOEK5AGbfTV7nEFx3Q/cES1g+1vaIICoPZg6+XSZ64bAqLG7feMMRpEXYe0EXf1Hk7iPd8cUUgEaKFG1wkHbHiYWjUBR2j6dA/aALNE/CYgFjrAPW9tp/Vm/FwHS7nOqj7MMUnr4vUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765730164; c=relaxed/simple;
	bh=uXBuV/Kp+/M1EvWrPQoks2W0wdPS5OvR+/7rNty1p0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFZCdHDOo0D3MRPrlk17EdUUaqJVwQH3BW46tHkgRmFv8XjFx+nU/luldLSAEsmWd2ARZeveFI7uSE3q8aXuCSbyGlOj52mpZaVCdIzF2zOSHuvEFr7fv/VEpm2sJ370l7KW/cRxxalV5ezuIihiPuye01lEkN82c5wJdpUwJpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ32tbVo; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5957c929a5eso3980221e87.1
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 08:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765730160; x=1766334960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQaSn0DLqOFOsA8M/K0su83gKd9Tn+v/MOGwCqXayKA=;
        b=QZ32tbVoRha+l52J30fqXRNw+iqvdU4NOyKrv98pV4cWgMgC2se4bdykDqDDesoWeI
         HDUTfpSMGOZ/pfvPgwu6eRVduNWd/rYhMBa0apA8gZIaL0VP8SFrKUoC2MsRAI/OzuOW
         TanWmTTOYSdAkmFoZZdyipQp5vhE7ZvBQKtCPHcfDHlZkKwUWmJb7dlNFNRu+BYJwULO
         NgSEpkfEjxPO27vJIY1DowASPKbJxZzMwKvznGaiAJSvgVlsWilkcHYOYWN0zlv4f1IU
         2sF1TjlWSnHuupCuZBL08p9PMK79cImqGoYEkeFE1nf7aEXWVYm5h8OCTu4LApB6lDbf
         4P/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765730160; x=1766334960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sQaSn0DLqOFOsA8M/K0su83gKd9Tn+v/MOGwCqXayKA=;
        b=LFE4Fnf2LYpPL7j2E+7Sr3RSsku7psquLFW50JebBHEQPBTJnDzoGooV94o6YQ7wNz
         2suh02nGK1zRzfnV1T/cmmsKyGFm6E8wcH80dSpaEEqxilBvqFLcYQZLRY1JlSOHcZgb
         OVXCVIT6OsoktlRig3iGY+LrnTFWklc+YNdEJWai5mtAzoS1OXqMKG2w+p++5oRlUzZ0
         nAHcTEitQpVuOhTMK1AnH8UOuJreaim7QMXCXE3R0WFbXm+eSD8nU9VFs1tb1IZi8Ari
         Tu7TmBClaWAaklaw3zK6MMN75HZfQ6T43afyoKY7UEDjY2yKj6rMEzv3wN2iBp98Kbhg
         YN7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6ydH9b8YlSJWoIrj7kwpAPowqxVNvpfRdnBYvTVpB16g15PAzrJi3Tsu/QVOpWKkt4AFu55UXaNWzFQXwews=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeTN0MBFh/5/aNyWPKQrUGlnQ7svcjJMWRQVuSB2jRB3lQexux
	DHNLws+IfCTkh9/6qCWBr3Zz2oN4WU5PsliwVV7wYOJdZgdMDNrSI2r2
X-Gm-Gg: AY/fxX44lK8kzMg/+YPKkM4TODa4+IAcN9JFiPOgZyEicJbPYR9KE08N4fW3gD65Q2T
	8zlDPMlNl13Cbg9XYgXecOqk0RFAK8+lBZAI8DdQEEFpDynexqisuql/uwjyLC8MPiMyjPFFZ5h
	MkzXWQrtl0OsBOeRl44Nzy4YU5hpzap0NMeE7TrlFxaN9S92l+79GQUrEGGh6RYru+C++V5W+ae
	JT2DsdI8c+JyHZw8zRR3NIiV5JcLY+D8oqnw6VcPF+679Li7QjavUK4hD6jzduyxeKEw1otq1IL
	djCrrOxSrXMqPHqdtdFfdbsjfyOyU1MEsIzOa7ZwO4U5E6ez2HcOqr9idyw2+J11X/DJnkW/Zst
	BXe/8zn7gfZCKfop4jnkcA1yuzdIedSbPw2LlTd2D70+G5agDIL2uTbdn0tXMih0NOMO1dqFdld
	D+vA==
X-Google-Smtp-Source: AGHT+IF2w7XngXI0Qr5uEUjrppLH+KRGrVaFiuWS6ITxuOpJgvkDn9nUFBqzNj2KkczyUIhqPar1hQ==
X-Received: by 2002:a05:6512:3c95:b0:594:2a0f:916f with SMTP id 2adb3069b0e04-598faa9299amr2673562e87.43.1765730159952;
        Sun, 14 Dec 2025 08:35:59 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-598f7717b79sm3789618e87.60.2025.12.14.08.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 08:35:59 -0800 (PST)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Joel Granados <joel.granados@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Guo Ren <guoren@kernel.org>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v5 8/9] selftests: riscv: verify ptrace rejects invalid vector csr inputs
Date: Sun, 14 Dec 2025 19:35:12 +0300
Message-ID: <20251214163537.1054292-9-geomatsi@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251214163537.1054292-1-geomatsi@gmail.com>
References: <20251214163537.1054292-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to v_ptrace test suite to verify that ptrace rejects the
invalid input combinations of vector csr registers. Use kselftest
fixture variants to create multiple invalid inputs for the test.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 .../riscv/vector/validate_v_ptrace.c          | 318 ++++++++++++++++++
 1 file changed, 318 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/validate_v_ptrace.c b/tools/testing/selftests/riscv/vector/validate_v_ptrace.c
index 2dd0c727e520..623b13e7582e 100644
--- a/tools/testing/selftests/riscv/vector/validate_v_ptrace.c
+++ b/tools/testing/selftests/riscv/vector/validate_v_ptrace.c
@@ -336,4 +336,322 @@ TEST(ptrace_v_syscall_clobbering)
 	}
 }
 
+FIXTURE(v_csr_invalid)
+{
+};
+
+FIXTURE_SETUP(v_csr_invalid)
+{
+}
+
+FIXTURE_TEARDOWN(v_csr_invalid)
+{
+}
+
+#define VECTOR_1_0		(1UL << 0)
+#define XTHEAD_VECTOR_0_7	(1UL << 1)
+
+#define vector_test(x)		((x) & VECTOR_1_0)
+#define xthead_test(x)		((x) & XTHEAD_VECTOR_0_7)
+
+/* modifications of the initial vsetvli settings */
+FIXTURE_VARIANT(v_csr_invalid)
+{
+	unsigned long vstart;
+	unsigned long vl;
+	unsigned long vtype;
+	unsigned long vcsr;
+	unsigned long vlenb_mul;
+	unsigned long vlenb_min;
+	unsigned long vlenb_max;
+	unsigned long spec;
+};
+
+/* unexpected vlenb value */
+FIXTURE_VARIANT_ADD(v_csr_invalid, new_vlenb)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x3,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x2,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x0,
+	.spec = VECTOR_1_0 | XTHEAD_VECTOR_0_7,
+};
+
+/* invalid reserved bits in vcsr */
+FIXTURE_VARIANT_ADD(v_csr_invalid, vcsr_invalid_reserved_bits)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x3,
+	.vcsr = 0x1UL << 8,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x0,
+	.spec = VECTOR_1_0 | XTHEAD_VECTOR_0_7,
+};
+
+/* invalid reserved bits in vtype */
+FIXTURE_VARIANT_ADD(v_csr_invalid, vtype_invalid_reserved_bits)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = (0x1UL << 8) | 0x3,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x0,
+	.spec = VECTOR_1_0 | XTHEAD_VECTOR_0_7,
+};
+
+/* set vill bit */
+FIXTURE_VARIANT_ADD(v_csr_invalid, invalid_vill_bit)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = (0x1UL << (__riscv_xlen - 1)) | 0x3,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x0,
+	.spec = VECTOR_1_0 | XTHEAD_VECTOR_0_7,
+};
+
+/* reserved vsew value: vsew > 3 */
+FIXTURE_VARIANT_ADD(v_csr_invalid, reserved_vsew)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x4UL << 3,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x0,
+	.spec = VECTOR_1_0,
+};
+
+/* XTheadVector: unsupported non-zero VEDIV value */
+FIXTURE_VARIANT_ADD(v_csr_invalid, reserved_vediv)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x3UL << 5,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x0,
+	.spec = XTHEAD_VECTOR_0_7,
+};
+
+/* reserved vlmul value: vlmul == 4 */
+FIXTURE_VARIANT_ADD(v_csr_invalid, reserved_vlmul)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x4,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x0,
+	.spec = VECTOR_1_0,
+};
+
+/* invalid fractional LMUL for VLEN <= 256: LMUL= 1/8, SEW = 64 */
+FIXTURE_VARIANT_ADD(v_csr_invalid, frac_lmul1)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x1d,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x20,
+	.spec = VECTOR_1_0,
+};
+
+/* invalid integral LMUL for VLEN <= 16: LMUL= 2, SEW = 64 */
+FIXTURE_VARIANT_ADD(v_csr_invalid, int_lmul1)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x19,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x2,
+	.spec = VECTOR_1_0,
+};
+
+/* XTheadVector: invalid integral LMUL for VLEN <= 16: LMUL= 2, SEW = 64 */
+FIXTURE_VARIANT_ADD(v_csr_invalid, int_lmul2)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0xd,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x2,
+	.spec = XTHEAD_VECTOR_0_7,
+};
+
+/* invalid VL for VLEN <= 128: LMUL= 2, SEW = 64, VL = 8 */
+FIXTURE_VARIANT_ADD(v_csr_invalid, vl1)
+{
+	.vstart = 0x0,
+	.vl = 0x8,
+	.vtype = 0x19,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x10,
+	.spec = VECTOR_1_0,
+};
+
+/* XTheadVector: invalid VL for VLEN <= 128: LMUL= 2, SEW = 64, VL = 8 */
+FIXTURE_VARIANT_ADD(v_csr_invalid, vl2)
+{
+	.vstart = 0x0,
+	.vl = 0x8,
+	.vtype = 0xd,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x10,
+	.spec = XTHEAD_VECTOR_0_7,
+};
+
+TEST_F(v_csr_invalid, ptrace_v_invalid_values)
+{
+	unsigned long vlenb;
+	pid_t pid;
+
+	if (!is_vector_supported() && !is_xtheadvector_supported())
+		SKIP(return, "Vectors not supported");
+
+	if (is_vector_supported() && !vector_test(variant->spec))
+		SKIP(return, "Test not supported for Vector");
+
+	if (is_xtheadvector_supported() && !xthead_test(variant->spec))
+		SKIP(return, "Test not supported for XTheadVector");
+
+	vlenb = get_vr_len();
+
+	if (variant->vlenb_min) {
+		if (vlenb < variant->vlenb_min)
+			SKIP(return, "This test does not support VLEN < %lu\n",
+			     variant->vlenb_min * 8);
+	}
+
+	if (variant->vlenb_max) {
+		if (vlenb > variant->vlenb_max)
+			SKIP(return, "This test does not support VLEN > %lu\n",
+			     variant->vlenb_max * 8);
+	}
+
+	chld_lock = 1;
+	pid = fork();
+	ASSERT_LE(0, pid)
+		TH_LOG("fork: %m");
+
+	if (pid == 0) {
+		unsigned long vl;
+
+		while (chld_lock == 1)
+			asm volatile("" : : "g"(chld_lock) : "memory");
+
+		if (is_xtheadvector_supported()) {
+			asm volatile (
+				// 0 | zimm[10:0] | rs1 | 1 1 1 | rd |1010111| vsetvli
+				// vsetvli	t4, x0, e16, m2, d1
+				".4byte		0b00000000010100000111111011010111\n"
+				"mv		%[new_vl], t4\n"
+				: [new_vl] "=r" (vl) : : "t4");
+		} else {
+			asm volatile (
+				".option push\n"
+				".option arch, +zve32x\n"
+				"vsetvli %[new_vl], x0, e16, m2, tu, mu\n"
+				".option pop\n"
+				: [new_vl] "=r"(vl) : : );
+		}
+
+		while (1) {
+			asm volatile (
+				".option push\n"
+				".option norvc\n"
+				"ebreak\n"
+				"nop\n"
+				".option pop\n");
+		}
+	} else {
+		struct __riscv_v_regset_state *regset_data;
+		size_t regset_size;
+		struct iovec iov;
+		int status;
+		int ret;
+
+		/* attach */
+
+		ASSERT_EQ(0, ptrace(PTRACE_ATTACH, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* unlock */
+
+		ASSERT_EQ(0, ptrace(PTRACE_POKEDATA, pid, &chld_lock, 0));
+
+		/* resume and wait for the 1st ebreak */
+
+		ASSERT_EQ(0, ptrace(PTRACE_CONT, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* read tracee vector csr regs using ptrace GETREGSET */
+
+		regset_size = sizeof(*regset_data) + vlenb * 32;
+		regset_data = calloc(1, regset_size);
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* verify initial vsetvli settings */
+
+		if (is_xtheadvector_supported()) {
+			EXPECT_EQ(5UL, regset_data->vtype);
+		} else {
+			EXPECT_EQ(9UL, regset_data->vtype);
+		}
+
+		EXPECT_EQ(regset_data->vlenb, regset_data->vl);
+		EXPECT_EQ(vlenb, regset_data->vlenb);
+		EXPECT_EQ(0UL, regset_data->vstart);
+		EXPECT_EQ(0UL, regset_data->vcsr);
+
+		/* apply invalid settings from fixture variants */
+
+		regset_data->vlenb *= variant->vlenb_mul;
+		regset_data->vstart = variant->vstart;
+		regset_data->vtype = variant->vtype;
+		regset_data->vcsr = variant->vcsr;
+		regset_data->vl = variant->vl;
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
+		errno = 0;
+		ret = ptrace(PTRACE_SETREGSET, pid, NT_RISCV_VECTOR, &iov);
+		ASSERT_EQ(errno, EINVAL);
+		ASSERT_EQ(ret, -1);
+
+		/* cleanup */
+
+		ASSERT_EQ(0, kill(pid, SIGKILL));
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.52.0


