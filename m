Return-Path: <linux-kselftest+bounces-42823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E38DBC1499
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 13:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E9C3C3D39
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 11:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479362DEA73;
	Tue,  7 Oct 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnLh4ocE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D02DCF4B
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838334; cv=none; b=TadHEekaRqgSGannSsupPHICEex9An+Lx7rSUIurL3g6rJupOyXq/SDkM2hXsDmKsuqAAWejudE3w8zv6kX1WRSb7Pseq1/k5/WLNDquxQXMTtPsfKgSdSptaxjptyk2JAS+1emUbNex6VuXDW/eeFF75wmDmGUQnqXD+07fdmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838334; c=relaxed/simple;
	bh=zd5hjY5wrx8YKzPB1AK38z5RyQ2MEvFwF1ylhr4VaWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOJq8lheGif120yDjG4pbXiyzYAC1EPursMSrxHKXwXv/4Bdq1i9sRPYbiehBX6V/JyUMxiPJOp9jQxUOiSNPUBQJjkpj7MXtv76NOV7eFtO0KC40eT2VZJkc32LapKfBChEXesJy328yXdBxofO/IPtpn6x4hG8K9RNx7FKXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnLh4ocE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57992ba129eso7106939e87.3
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Oct 2025 04:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759838329; x=1760443129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bz5jQRJFoVK4+PdvzI4TMgPHFnuOpO8O5iQSmwwrcRs=;
        b=ZnLh4ocEsiWx9HnYpFno2Xrtw5XgS0zT+0zwbCC53FLz/tTJSfnHxsgqlqIv4egwua
         zOPV38Ls7RTiT2J888hmsjvx1D8HTuFSuueu04TLQM2KO27f2Hfch7s/RxLCUaMSashX
         YLPgye9VO4Y77JN7cNFXNYCWB7KhCK3ZswRdeUB1n6ni2bMJQkLQ0bbPTXpweAMnVrOV
         R6B63K0BsT2d7vSulQLNxhUrzwkcnoYc3RpariUDXab4fpiT2LZ42+CcAiMBieYs6tnn
         eLP575srDcrRiMpocO2iVf+vDYhvdLaE1tS2xMhv4dXzYgJ3c/uj1IWJjCDYRHO/+tSp
         uaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759838329; x=1760443129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bz5jQRJFoVK4+PdvzI4TMgPHFnuOpO8O5iQSmwwrcRs=;
        b=ePFf3gDm6dAVlU0NpKZ4dS7AGq9ETW99RB46EgHv00D4lNlwRp+o5Mn9WXKEsmhFFP
         Re2QIuD96iMLW+1GzXLP1TzoZakVSl3j91WSVkKiMxdyJy0thN6Yn7INgIb0uyhfAshT
         s9CimvwqwUUrmawjVIX8vxtxbObaaX1FJ2e/QpEV6kg5EZxGT/f6i2mnW6LREvFkUMNs
         neZhmeyuuV9NLfEJYSzPGMii+pItR4u+nI2qNeD35xxWsPbVDwowxiMcGL2ZcFi2nFTN
         TrJof4HM+0DyQ/lc3/O91vvYBNiXCKWzXBpy2wfZzV4yKEOI8+cscphUYErdFBGlPRLl
         abWw==
X-Forwarded-Encrypted: i=1; AJvYcCVZzCxOmEVm+AHxQnUpABVFtI/pufF/lgCDirYpuLziBa03Pc7iQPKZIuURuoc01SgV2wr5QdrOeDwI6raApGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbModMHIQ48M8JDuKy/WjHr+Z6NnyuJUcvhMuIefkg1jSWUnX
	Wjk36jgFi/tsn1so4k5r8QlF44zRp4SZxRz3te/VZsxlZj/lx9aNbA5Z
X-Gm-Gg: ASbGnct9tABxKfOcO1+37qtrSlYfa7w9K6f6+mQ8eaLMNv6GZND3FYVzjcTHolTL6y/
	J4gHL43sZepn1Vvn4PSO3FL7qhhNDydisyVIXTDuogGbOTCGH2v3dxGDT/qzyijXkJASo6URDs8
	ROrP7S8bEBQeMmxS5Xjwy0FTb63PvWwqoTYB6BnKa8ihCFzrXcok3NewhRb0FX0tbZ5iqZUeqKN
	Vr7ysSAdBJ9eoLXs8dn7Uo0YAN4TdIol0dHIjcGQpR4hbDmJyWsRF/Hjdff6Exr7ZmhxoZRysK4
	Sr6Ixqkg/waExz33qVRmJ97g24nBuTWRVlesx7rjwTorm2JyhAo0BdPSVwf2VKJOdOw0kW2Cetf
	nETk6B9IYxUHKxYX232hDvbkiFmFfLPJ0zWr0xA==
X-Google-Smtp-Source: AGHT+IHybbaDTUuq3OR2dTh3PRjAv16cf+ofk/HgCXjX/Glsz8ylZkJGopHKGG11y1fc7qEDafksGA==
X-Received: by 2002:ac2:5bcc:0:b0:590:6119:6b73 with SMTP id 2adb3069b0e04-59061196f21mr616166e87.48.1759838328903;
        Tue, 07 Oct 2025 04:58:48 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-58b011a8941sm6043339e87.114.2025.10.07.04.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:58:48 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nam Cao <namcao@linutronix.de>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2 3/6] selftests: riscv: set invalid vtype using ptrace
Date: Tue,  7 Oct 2025 14:58:19 +0300
Message-ID: <20251007115840.2320557-4-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007115840.2320557-1-geomatsi@gmail.com>
References: <20251007115840.2320557-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case that attempts to set invalid vtype value using ptrace
and verifies that the 'vill' bit is set as required by the RISC-V
Vector specification v1.0, Section 3.4.1.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 .../testing/selftests/riscv/vector/v_ptrace.c | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/v_ptrace.c b/tools/testing/selftests/riscv/vector/v_ptrace.c
index 6a8d56a5c4f4..ccda8a4dc49b 100644
--- a/tools/testing/selftests/riscv/vector/v_ptrace.c
+++ b/tools/testing/selftests/riscv/vector/v_ptrace.c
@@ -84,4 +84,116 @@ TEST(ptrace_rvv_not_enabled)
 	}
 }
 
+TEST(ptrace_rvv_invalid_vtype)
+{
+	static volatile unsigned long vtype;
+	unsigned long vlenb;
+	unsigned long reg;
+	pid_t pid;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
+
+	asm volatile("csrr %[vlenb], vlenb" : [vlenb] "=r"(vlenb));
+
+	if (vlenb > 16)
+		SKIP(return, "This test does not support VLEN > 128");
+
+	chld_lock = 1;
+
+	pid = fork();
+
+	ASSERT_LE(0, pid)
+		TH_LOG("fork: %m");
+
+	if (pid == 0) {
+		while (chld_lock == 1)
+			asm volatile("" : : "g"(chld_lock) : "memory");
+
+		asm(".option arch, +v\n");
+		asm(".option arch, +c\n");
+		asm volatile("vsetvli x0, x0, e8, m8, tu, mu\n");
+
+		while (1) {
+			asm volatile ("c.ebreak");
+			asm volatile("csrr %[vtype], vtype" : [vtype] "=r"(vtype) : :);
+			asm volatile ("c.ebreak");
+		}
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
+		/* resume and wait for the 1st c.ebreak */
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
+		/* set invalid vtype 0x1d = (5 | 3 << 3):
+		 * - LMUL: 1/8
+		 * - SEW:  64
+		 *   - invalid configuration for VLENB <= 128
+		 */
+		regset_data->vtype = 0x1d;
+		ASSERT_EQ(0, ptrace(PTRACE_SETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* skip 1st c.ebreak, then resume and wait for the 2nd c.ebreak */
+
+		iov.iov_base = &regs;
+		iov.iov_len = sizeof(regs);
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov));
+		regs.pc += 2;
+		ASSERT_EQ(0, ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov));
+
+		ASSERT_EQ(0, ptrace(PTRACE_CONT, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* read tracee vtype using ptrace GETREGSET */
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* read tracee vtype ptrace PEEKDATA */
+
+		errno = 0;
+		reg = ptrace(PTRACE_PEEKDATA, pid, &vtype, NULL);
+		ASSERT_FALSE((errno != 0) && (reg == -1));
+
+		/* verify that V state is illegal */
+
+		EXPECT_EQ(reg, regset_data->vtype);
+		EXPECT_EQ(1UL, (regset_data->vtype >> (__riscv_xlen - 1)));
+
+		/* cleanup */
+
+		ASSERT_EQ(0, kill(pid, SIGKILL));
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.51.0


