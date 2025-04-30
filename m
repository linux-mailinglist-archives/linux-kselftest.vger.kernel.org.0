Return-Path: <linux-kselftest+bounces-32020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16569AA44F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 10:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9D61BA01E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 08:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B321507C;
	Wed, 30 Apr 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZQoUu/bJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27420E33D
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000997; cv=none; b=EZclKpxftfI0knvl0NvLIpDkc6IHm9kx6rA1vJ+JuRBcrpUBlW864EOBBpzWiPHUszZd/KlmhTwhSQwXaNka1lph/VidO9ymAWTyNNMYj6gUnXO9+8rXLX6S1RQ/5jxDdiQ2wn/bH7zQZcGDIhnhOT/pBz9LAWCLgIwmEptwAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000997; c=relaxed/simple;
	bh=vxtT9/3d3+RsfsN/8F9NhokA4ex2hx300P/B78SmG8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUEl/GjKn50k21nKX0/hZ5/Fp9IaSrHOOsLNrbFvWN74W8sa9QuNUC4MWUg61i2vcG3DAbuWibVIKeqtuPNBXmOymjIRblZjkr+1lrHOi07Hvp4pBzBXlJmp7oFHbcT+kIiCseiaCrgPGaz1jfLAaNqi+NZfkbmWA4AB/gMR1xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZQoUu/bJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso8658646b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1746000995; x=1746605795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMR7LQ4EcuISRMn9uVkeFVkgbpXUkyH5s1ul4wVziJk=;
        b=ZQoUu/bJHr6YglVeveIm6EMM6K3sCqbuMpcdHjg6HqMhFdKoVi/7VRnP3LRlazBrLF
         lJWf5pc/3z820r0t1Nx04bKdhkPySBXo6M+A/BOxsMRQ1A3nrQ+RIAhLC8ISy7UT7SKD
         LR3d1AP8uvU3698aNDb9/2Y6Em8XjwCB/blEVHuKqdthF3arhqmhMtQTRVTOCDrFLz0y
         HiyziCR+NGNQL+EhRH+qIKnGgV03Sq9gFtgl1M/nnXsqAosWLxL/pfgPK0up3pa1oFve
         boFIElu6zBM32vwccaUNcajD4Ur1AfBFz0eTLWwY7yGxn23U+LBcXdCCP2VdTgLMHXd+
         ZGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746000995; x=1746605795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMR7LQ4EcuISRMn9uVkeFVkgbpXUkyH5s1ul4wVziJk=;
        b=pEG+iMB3sFn0t45r3mMCno+viFY3gKXxPenNbG6rK+nA72FOxpZQWVRmLEhb2aV2aY
         VC4hDhc5wL65qbz/L77Gkdm3bmwKJKomP3XLw2uc/Q75Q/v8lVsLr5uPMeaiWY4OfIsh
         L81fW1TTPHxGqNO/6/2nwlGb6c90ZGk0OKWSgcOqJVo366s+8CRheDhINbVET9kqbGSZ
         wv13Z2KBAOTj6d7WcJGaoaSstOrvNXi4OmN22sgybHJAcZ8ALb+lJVjYjZjrTHDZPJc/
         PDc66z5HNYg/bF8g9/SpzWUBtgUPqHlYHuMQiQB+dAnT0xVNP5cZRy31+EcISadQQdpB
         ex2w==
X-Forwarded-Encrypted: i=1; AJvYcCV92BKSPMxBkayrRJnX4VCZ6ZHuTAd7XoYgxkb3d7W4V8XyVicaKqXcohFhfmQ4JVUM+1fMI+weyROrnYtiJNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmCDAApyxQiBtzOKPn1oiO+xpZkhmyIHySj/TNPgoZj0D//EZi
	r2dKMBMY00VJhyajRCXp4LQJ9aXQ90QeMDFgar94j24rcvRDOf/pUN9YZR1jxjY=
X-Gm-Gg: ASbGnctKOPkD8zDnzjn61bcqdopoO6iDoShYAi2pfu3Gi5yS6QIphwzT4r/TixXn/32
	NrfWFTExnhDXYOuC/EfDlCN0WlkcLZ/gbDLnJEaF8AOenRF+1BjAAyk+XSQbtWmoJJZgAEiSLJy
	h4ve7BGUdQ2P2SyzyUZ/RvrlGzb2fGXrm78O0ynU/Rai1UXp1lY8+m8QYAYMHH3y+D8G1n7XEbS
	NoEEeG2RwEc5BN5vSJAauQVzxS4SeqTGU33qHDJaDHXbos5Q4qx3L21d3y8qHp3hXtbqqBEM4K5
	tDptiHKagE9EYSCTrEE2nUmAC2DqTXtnAEIeZHZcazPW5h+C8GHW7Q==
X-Google-Smtp-Source: AGHT+IEszTsV/BUeZBkL4ZpuZ0SkL3h2U9eOwaQLGRPB51BWwKG2aiOQfovURMFi8gr43T+5AaK3Cg==
X-Received: by 2002:a05:6a00:139b:b0:736:bfc4:ef2c with SMTP id d2e1a72fcca58-74038793f8dmr3272406b3a.0.1746000995136;
        Wed, 30 Apr 2025 01:16:35 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a309edsm1073084b3a.91.2025.04.30.01.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:16:34 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 30 Apr 2025 01:16:28 -0700
Subject: [PATCH v3 1/3] KVM: riscv: selftests: Align the trap information
 wiht pt_regs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-kvm_selftest_improve-v3-1-eea270ff080b@rivosinc.com>
References: <20250430-kvm_selftest_improve-v3-0-eea270ff080b@rivosinc.com>
In-Reply-To: <20250430-kvm_selftest_improve-v3-0-eea270ff080b@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

The current exeception register structure in selftests are missing
few registers (e.g stval). Instead of adding it manually, change
the ex_regs to align with pt_regs to make it future proof.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../selftests/kvm/include/riscv/processor.h        |  10 +-
 tools/testing/selftests/kvm/lib/riscv/handlers.S   | 139 +++++++++++----------
 tools/testing/selftests/kvm/lib/riscv/processor.c  |   2 +-
 tools/testing/selftests/kvm/riscv/arch_timer.c     |   2 +-
 tools/testing/selftests/kvm/riscv/ebreak_test.c    |   2 +-
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c   |   4 +-
 6 files changed, 83 insertions(+), 76 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 5f389166338c..1b5aef87de0f 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -60,7 +60,8 @@ static inline bool __vcpu_has_sbi_ext(struct kvm_vcpu *vcpu, uint64_t sbi_ext)
 	return __vcpu_has_ext(vcpu, RISCV_SBI_EXT_REG(sbi_ext));
 }
 
-struct ex_regs {
+struct pt_regs {
+	unsigned long epc;
 	unsigned long ra;
 	unsigned long sp;
 	unsigned long gp;
@@ -92,16 +93,19 @@ struct ex_regs {
 	unsigned long t4;
 	unsigned long t5;
 	unsigned long t6;
-	unsigned long epc;
+	/* Supervisor/Machine CSRs */
 	unsigned long status;
+	unsigned long badaddr;
 	unsigned long cause;
+	/* a0 value before the syscall */
+	unsigned long orig_a0;
 };
 
 #define NR_VECTORS  2
 #define NR_EXCEPTIONS  32
 #define EC_MASK  (NR_EXCEPTIONS - 1)
 
-typedef void(*exception_handler_fn)(struct ex_regs *);
+typedef void(*exception_handler_fn)(struct pt_regs *);
 
 void vm_init_vector_tables(struct kvm_vm *vm);
 void vcpu_init_vector_tables(struct kvm_vcpu *vcpu);
diff --git a/tools/testing/selftests/kvm/lib/riscv/handlers.S b/tools/testing/selftests/kvm/lib/riscv/handlers.S
index aa0abd3f35bb..b787b982e922 100644
--- a/tools/testing/selftests/kvm/lib/riscv/handlers.S
+++ b/tools/testing/selftests/kvm/lib/riscv/handlers.S
@@ -10,85 +10,88 @@
 #include <asm/csr.h>
 
 .macro save_context
-	addi  sp, sp, (-8*34)
-	sd    x1, 0(sp)
-	sd    x2, 8(sp)
-	sd    x3, 16(sp)
-	sd    x4, 24(sp)
-	sd    x5, 32(sp)
-	sd    x6, 40(sp)
-	sd    x7, 48(sp)
-	sd    x8, 56(sp)
-	sd    x9, 64(sp)
-	sd    x10, 72(sp)
-	sd    x11, 80(sp)
-	sd    x12, 88(sp)
-	sd    x13, 96(sp)
-	sd    x14, 104(sp)
-	sd    x15, 112(sp)
-	sd    x16, 120(sp)
-	sd    x17, 128(sp)
-	sd    x18, 136(sp)
-	sd    x19, 144(sp)
-	sd    x20, 152(sp)
-	sd    x21, 160(sp)
-	sd    x22, 168(sp)
-	sd    x23, 176(sp)
-	sd    x24, 184(sp)
-	sd    x25, 192(sp)
-	sd    x26, 200(sp)
-	sd    x27, 208(sp)
-	sd    x28, 216(sp)
-	sd    x29, 224(sp)
-	sd    x30, 232(sp)
-	sd    x31, 240(sp)
+	addi  sp, sp, (-8*36)
+	sd    x1, 8(sp)
+	sd    x2, 16(sp)
+	sd    x3, 24(sp)
+	sd    x4, 32(sp)
+	sd    x5, 40(sp)
+	sd    x6, 48(sp)
+	sd    x7, 56(sp)
+	sd    x8, 64(sp)
+	sd    x9, 72(sp)
+	sd    x10, 80(sp)
+	sd    x11, 88(sp)
+	sd    x12, 96(sp)
+	sd    x13, 104(sp)
+	sd    x14, 112(sp)
+	sd    x15, 120(sp)
+	sd    x16, 128(sp)
+	sd    x17, 136(sp)
+	sd    x18, 144(sp)
+	sd    x19, 152(sp)
+	sd    x20, 160(sp)
+	sd    x21, 168(sp)
+	sd    x22, 176(sp)
+	sd    x23, 184(sp)
+	sd    x24, 192(sp)
+	sd    x25, 200(sp)
+	sd    x26, 208(sp)
+	sd    x27, 216(sp)
+	sd    x28, 224(sp)
+	sd    x29, 232(sp)
+	sd    x30, 240(sp)
+	sd    x31, 248(sp)
 	csrr  s0, CSR_SEPC
 	csrr  s1, CSR_SSTATUS
-	csrr  s2, CSR_SCAUSE
-	sd    s0, 248(sp)
+	csrr  s2, CSR_STVAL
+	csrr  s3, CSR_SCAUSE
+	sd    s0, 0(sp)
 	sd    s1, 256(sp)
 	sd    s2, 264(sp)
+	sd    s3, 272(sp)
 .endm
 
 .macro restore_context
+	ld    s3, 272(sp)
 	ld    s2, 264(sp)
 	ld    s1, 256(sp)
-	ld    s0, 248(sp)
-	csrw  CSR_SCAUSE, s2
+	ld    s0, 0(sp)
+	csrw  CSR_SCAUSE, s3
 	csrw  CSR_SSTATUS, s1
 	csrw  CSR_SEPC, s0
-	ld    x31, 240(sp)
-	ld    x30, 232(sp)
-	ld    x29, 224(sp)
-	ld    x28, 216(sp)
-	ld    x27, 208(sp)
-	ld    x26, 200(sp)
-	ld    x25, 192(sp)
-	ld    x24, 184(sp)
-	ld    x23, 176(sp)
-	ld    x22, 168(sp)
-	ld    x21, 160(sp)
-	ld    x20, 152(sp)
-	ld    x19, 144(sp)
-	ld    x18, 136(sp)
-	ld    x17, 128(sp)
-	ld    x16, 120(sp)
-	ld    x15, 112(sp)
-	ld    x14, 104(sp)
-	ld    x13, 96(sp)
-	ld    x12, 88(sp)
-	ld    x11, 80(sp)
-	ld    x10, 72(sp)
-	ld    x9, 64(sp)
-	ld    x8, 56(sp)
-	ld    x7, 48(sp)
-	ld    x6, 40(sp)
-	ld    x5, 32(sp)
-	ld    x4, 24(sp)
-	ld    x3, 16(sp)
-	ld    x2, 8(sp)
-	ld    x1, 0(sp)
-	addi  sp, sp, (8*34)
+	ld    x31, 248(sp)
+	ld    x30, 240(sp)
+	ld    x29, 232(sp)
+	ld    x28, 224(sp)
+	ld    x27, 216(sp)
+	ld    x26, 208(sp)
+	ld    x25, 200(sp)
+	ld    x24, 192(sp)
+	ld    x23, 184(sp)
+	ld    x22, 176(sp)
+	ld    x21, 168(sp)
+	ld    x20, 160(sp)
+	ld    x19, 152(sp)
+	ld    x18, 144(sp)
+	ld    x17, 136(sp)
+	ld    x16, 128(sp)
+	ld    x15, 120(sp)
+	ld    x14, 112(sp)
+	ld    x13, 104(sp)
+	ld    x12, 96(sp)
+	ld    x11, 88(sp)
+	ld    x10, 80(sp)
+	ld    x9, 72(sp)
+	ld    x8, 64(sp)
+	ld    x7, 56(sp)
+	ld    x6, 48(sp)
+	ld    x5, 40(sp)
+	ld    x4, 32(sp)
+	ld    x3, 24(sp)
+	ld    x2, 16(sp)
+	ld    x1, 8(sp)
+	addi  sp, sp, (8*36)
 .endm
 
 .balign 4
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index dd663bcf0cc0..2eac7d4b59e9 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -402,7 +402,7 @@ struct handlers {
 	exception_handler_fn exception_handlers[NR_VECTORS][NR_EXCEPTIONS];
 };
 
-void route_exception(struct ex_regs *regs)
+void route_exception(struct pt_regs *regs)
 {
 	struct handlers *handlers = (struct handlers *)exception_handlers;
 	int vector = 0, ec;
diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
index 9e370800a6a2..f962fefc48fa 100644
--- a/tools/testing/selftests/kvm/riscv/arch_timer.c
+++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
@@ -15,7 +15,7 @@
 
 static int timer_irq = IRQ_S_TIMER;
 
-static void guest_irq_handler(struct ex_regs *regs)
+static void guest_irq_handler(struct pt_regs *regs)
 {
 	uint64_t xcnt, xcnt_diff_us, cmp;
 	unsigned int intid = regs->cause & ~CAUSE_IRQ_FLAG;
diff --git a/tools/testing/selftests/kvm/riscv/ebreak_test.c b/tools/testing/selftests/kvm/riscv/ebreak_test.c
index cfed6c727bfc..739d17befb5a 100644
--- a/tools/testing/selftests/kvm/riscv/ebreak_test.c
+++ b/tools/testing/selftests/kvm/riscv/ebreak_test.c
@@ -27,7 +27,7 @@ static void guest_code(void)
 	GUEST_DONE();
 }
 
-static void guest_breakpoint_handler(struct ex_regs *regs)
+static void guest_breakpoint_handler(struct pt_regs *regs)
 {
 	WRITE_ONCE(sw_bp_addr, regs->epc);
 	regs->epc += 4;
diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index 03406de4989d..6e66833e5941 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -128,7 +128,7 @@ static void stop_counter(unsigned long counter, unsigned long stop_flags)
 		       "Unable to stop counter %ld error %ld\n", counter, ret.error);
 }
 
-static void guest_illegal_exception_handler(struct ex_regs *regs)
+static void guest_illegal_exception_handler(struct pt_regs *regs)
 {
 	__GUEST_ASSERT(regs->cause == EXC_INST_ILLEGAL,
 		       "Unexpected exception handler %lx\n", regs->cause);
@@ -138,7 +138,7 @@ static void guest_illegal_exception_handler(struct ex_regs *regs)
 	regs->epc += 4;
 }
 
-static void guest_irq_handler(struct ex_regs *regs)
+static void guest_irq_handler(struct pt_regs *regs)
 {
 	unsigned int irq_num = regs->cause & ~CAUSE_IRQ_FLAG;
 	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;

-- 
2.43.0


