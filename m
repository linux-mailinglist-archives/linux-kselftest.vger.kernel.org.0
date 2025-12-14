Return-Path: <linux-kselftest+bounces-47573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6515BCBBDA8
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 17:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3DD9302E042
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 16:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172B82DF6F4;
	Sun, 14 Dec 2025 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6szi1Mj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07CE2DAFA2
	for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765730166; cv=none; b=Ic0wlreKVKiB1Os9GojoefaAFEqM9g1eCY3mUf7mAWAEePbXdVpt6QstZ7vACxiG938J6wb0A87yuGwi3SxXinPzMqARbFjzqjjtF2k7y5GkGgYImjl1HP/eIu3J+0Ea7dgxj0atEqdx36vJLJ5KcFa39t5w7oQidwDiF4LBdYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765730166; c=relaxed/simple;
	bh=Gydlh+iup8jO/aNYR3QKidyq5TZb43ybY4tjHG68HtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFJHWrvXh1D78qRWAhdbUFCfgKO4cLiv48SijYwK49WxKdxggC07JZOzS398v8A5EsWUYPiOeak0lJOOP/4IS7xGgbxt9taVVzSHvM+PBuSLMvBo6z//gYvJxJk5N57EAMe3woWvZsLxfFHpXp7rWwiPPMTsr0qM6wExTM7NhlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6szi1Mj; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5942b58ac81so2183979e87.2
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 08:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765730162; x=1766334962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH0zKZXb/Y5gUEGiokm3nZsvrljXzf5GckdYzZU3nLY=;
        b=R6szi1MjV1OHBCFh+l3noe1dFrVD+/r0+d80RXsLZsTdRqRDIXFSYsXUVt15UAfpCm
         jze/coo3wuviDGa4R9FNQIYF5jpn0a7BdpHC0h2Yp1MjQYWzzVtSjYyd+jrphklGvkIY
         tzzAyUh8PhjF4t4Oyq+HIss12WJWXdMC04m2sq+n7b5DzTarYGQTUNSXX/I6ffRlNTIT
         TqxAFCJYNMv+CUuTNZnVgy0R+THvW+2ZnOmPWrjfZVXPzxM6j6GwNAEe+6A7H0GCqwqA
         vDr8d1ZLNGx4mGsBkV9cnLg+DqfSmwru0MVzf20lK3Gt0FpotFAN6rHkkzUEmnlGzMpe
         Vzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765730162; x=1766334962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aH0zKZXb/Y5gUEGiokm3nZsvrljXzf5GckdYzZU3nLY=;
        b=UXLC6VrGnMmvAVzp40a3OQmBSEVDuuFIz2QE5Rvsv82H99jFyvU4S2YrnUoWqGZvUt
         F/F86QWOix/pC7q9b2xtHCRzUiWEWSw8gSgSMCxr33vTfEpo5poS9XWCn0NgE6slKW7m
         Nm94ied2guRxHLrqHe7mIu1zViiJe2PR8Y+a9Wc/1x8TXF3t707vCFfLz8SXzGuh1JCc
         vhg8bHVSXc5JkMrLAunkXxvZrgDQYwPl7HACHHTPyl3IXmi282+zvU8F0WL65D0QLqTG
         KrmZyVH0dJHdoMywTzpxT+n+T6BTX579vGtg7RB54bA+abQmwqcZU9nOM5ftb4lamO1p
         z3kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbRf4VjujANCfXrUzHfO78o84/0cVhGOtF/sn0kWe6rR5JQr4oI0NBz2sKlLsOhMstyM0cf1tPPl+ZEi/+BaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCzTk5CvHyeF01XkFBsYsVtKunQ4M3t4dYhDSZkBnBr6lh2NsE
	DiD49uQSFw79odtjGe4qvG167hS0jUaPSWfSY3+LIP7EKvlXn9tIC4+N
X-Gm-Gg: AY/fxX4G7j1mzbmCn93CAlmsT+lf/TC+CP437ytROhlVeZ2wekQiHPJDnIPqTraaikg
	y0mqtnfrGg1jFmNX9X1Zx39vwaW/97Ox9ML9+HtTT5drvnZchyavqs1KtaVouoyFowIvku/ln3G
	CZGwct10otyEIvT5gPG4Ye5YFDXq1kL+G3Y9ZTsOGXAiX+e0hnFE6+ZWtdmYuSpomf31zyq64Y3
	5XQmgim74uzq3O3UEi1daKjj/SZ2/sG4ufDvgAuJ9bdaohOYjh4p55gwK9spBXy2ZEnd607ls/z
	eSjGiXEJTThH8I//vGMChVpyhHFAVixolAu6OIrc4NL2Q+8BgIuedYvC3A4E+IwReGXXWqjJBkU
	9v+VwhMK5s4DQLvghM9jmYdbE20xBu1fmk/0Ne3c9sOJeCNj0EHLZg/heq2ympfJrGUjz4xcn54
	GAQ/QJ5tD3Z82J
X-Google-Smtp-Source: AGHT+IGg2O6UbEA1J9//+XT5+Hs1atMO2Qc+sN+YnLd8rt1bcW3PK1V2c1Ri3kEauyeryHCL6gCzRg==
X-Received: by 2002:a05:6512:3d05:b0:597:d5dc:b3e0 with SMTP id 2adb3069b0e04-598faa223bfmr2694122e87.10.1765730161456;
        Sun, 14 Dec 2025 08:36:01 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-598f7717b79sm3789618e87.60.2025.12.14.08.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 08:36:00 -0800 (PST)
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
Subject: [PATCH v5 9/9] selftests: riscv: verify ptrace accepts valid vector csr values
Date: Sun, 14 Dec 2025 19:35:13 +0300
Message-ID: <20251214163537.1054292-10-geomatsi@gmail.com>
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

Add a test to v_ptrace test suite to verify that ptrace accepts the
valid input combinations of vector csr registers. Use kselftest
fixture variants to create multiple inputs for the test.

The test simulates a debug scenario with three breakpoints:
0. init: let the tracee set up its initial vector configuration
1. 1st bp:  modify the tracee's vector csr registers from the debugger
  - resume the tracee to execute a block without vector instructions
2. 2nd bp: read back the tracees's vector csr registers from the debugger
  - compare with values set by the debugger
  - resume the tracee to execute a block with vector instructions
3. 3rd bp: read back the tracess's vector csr registers again
  - compare with values set by the debugger

The last check helps to confirm that ptrace validation check for vector
csr registers input values works properly and maintains an accurate view
of the tracee's vector context in debugger.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 .../riscv/vector/validate_v_ptrace.c          | 262 ++++++++++++++++++
 1 file changed, 262 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/validate_v_ptrace.c b/tools/testing/selftests/riscv/vector/validate_v_ptrace.c
index 623b13e7582e..c72533a331de 100644
--- a/tools/testing/selftests/riscv/vector/validate_v_ptrace.c
+++ b/tools/testing/selftests/riscv/vector/validate_v_ptrace.c
@@ -654,4 +654,266 @@ TEST_F(v_csr_invalid, ptrace_v_invalid_values)
 	}
 }
 
+FIXTURE(v_csr_valid)
+{
+};
+
+FIXTURE_SETUP(v_csr_valid)
+{
+}
+
+FIXTURE_TEARDOWN(v_csr_valid)
+{
+}
+
+/* modifications of the initial vsetvli settings */
+FIXTURE_VARIANT(v_csr_valid)
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
+/* valid for VLEN >= 128: LMUL= 1/4, SEW = 32 */
+FIXTURE_VARIANT_ADD(v_csr_valid, frac_lmul1)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x16,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x10,
+	.vlenb_max = 0x0,
+	.spec = VECTOR_1_0,
+};
+
+/* valid for VLEN >= 16: LMUL= 2, SEW = 32 */
+FIXTURE_VARIANT_ADD(v_csr_valid, int_lmul1)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x11,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x2,
+	.vlenb_max = 0x0,
+	.spec = VECTOR_1_0,
+};
+
+/* valid for XTheadVector VLEN >= 16: LMUL= 2, SEW = 32 */
+FIXTURE_VARIANT_ADD(v_csr_valid, int_lmul2)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x9,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x2,
+	.vlenb_max = 0x0,
+	.spec = XTHEAD_VECTOR_0_7,
+};
+
+/* valid for VLEN >= 32: LMUL= 2, SEW = 32, VL = 2 */
+FIXTURE_VARIANT_ADD(v_csr_valid, int_lmul3)
+{
+	.vstart = 0x0,
+	.vl = 0x2,
+	.vtype = 0x11,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x4,
+	.vlenb_max = 0x0,
+	.spec = VECTOR_1_0,
+};
+
+TEST_F(v_csr_valid, ptrace_v_valid_values)
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
+		asm volatile (
+			".option push\n"
+			".option norvc\n"
+			".option arch, +zve32x\n"
+			"ebreak\n" /* breakpoint 1: apply new V state using ptrace */
+			"nop\n"
+			"ebreak\n" /* breakpoint 2: V state clean - context will not be saved */
+			"vmv.v.i v0, -1\n"
+			"ebreak\n" /* breakpoint 3: V state dirty - context will be saved */
+			".option pop\n");
+	} else {
+		struct __riscv_v_regset_state *regset_data;
+		struct user_regs_struct regs;
+		size_t regset_size;
+		struct iovec iov;
+		int status;
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
+		/* apply valid settings from fixture variants */
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
+		ASSERT_EQ(0, ptrace(PTRACE_SETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* skip 1st ebreak, then resume and wait for the 2nd ebreak */
+
+		iov.iov_base = &regs;
+		iov.iov_len = sizeof(regs);
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov));
+		regs.pc += 4;
+		ASSERT_EQ(0, ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov));
+
+		ASSERT_EQ(0, ptrace(PTRACE_CONT, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* read tracee vector csr regs using ptrace GETREGSET */
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* verify vector csr regs from tracee context */
+
+		EXPECT_EQ(regset_data->vstart, variant->vstart);
+		EXPECT_EQ(regset_data->vtype, variant->vtype);
+		EXPECT_EQ(regset_data->vcsr, variant->vcsr);
+		EXPECT_EQ(regset_data->vl, variant->vl);
+		EXPECT_EQ(regset_data->vlenb, vlenb);
+
+		/* skip 2nd ebreak, then resume and wait for the 3rd ebreak */
+
+		iov.iov_base = &regs;
+		iov.iov_len = sizeof(regs);
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov));
+		regs.pc += 4;
+		ASSERT_EQ(0, ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov));
+
+		ASSERT_EQ(0, ptrace(PTRACE_CONT, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* read tracee vector csr regs using ptrace GETREGSET */
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* verify vector csr regs from tracee context */
+
+		EXPECT_EQ(regset_data->vstart, variant->vstart);
+		EXPECT_EQ(regset_data->vtype, variant->vtype);
+		EXPECT_EQ(regset_data->vcsr, variant->vcsr);
+		EXPECT_EQ(regset_data->vl, variant->vl);
+		EXPECT_EQ(regset_data->vlenb, vlenb);
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


