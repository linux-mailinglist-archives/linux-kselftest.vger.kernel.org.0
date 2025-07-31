Return-Path: <linux-kselftest+bounces-38132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFA6B17805
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 23:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538451C80298
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B7126E6EE;
	Thu, 31 Jul 2025 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvgBqTOU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B08526A0C5
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996815; cv=none; b=Ug9EOn/3pC+/9CcuYe7Vb1Ua0zbShUP6/TX7HcJ25gqu5y7vFMHih/UPak+SBWwsOM7LXtLiNYaN4wMG5E9vBfPiyyf35FwUzRY6G+SxL20VVzqF9JtzgykdsRWeZwbTqBFxrewjTtXMty+4iJmj74onWctvYx3uaH6edUm//Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996815; c=relaxed/simple;
	bh=z88O2lrYkvcqZ1E563Jq76LF6hJrJnuWvQzFZiV3AzY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AJd0KnkN3Qc0WVhGmVGGqSwwIR4bZtlF8ISWhUFyVBkd7Ls10jD4EAT0M0eVtqqq22qnaR6tW5A1wofk5ICqQqe0VVECfFT3AOs954NEbJBZV6LlruWam8KjdCBRRz1bLeU8x7hvgP8pIw+xw31N2lZ8mKVNdKH0JQcBitRTOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lvgBqTOU; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b423aba05feso50732a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 14:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753996812; x=1754601612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S7whMSj4GW59YuO3bK58f0y4iIovKl3vCWboamrKQYI=;
        b=lvgBqTOUCMdvy5Tl1NV8tg+e8ALBvBvH7aJ4lbWi3fCh2tUC37xlQJrGrMftBRbOJL
         OOKrsNlFBiuX2AmSg/+7LuXXh/CnSkxqbNYRRJL7+RnOThCMGUKNDP5edjjyjD+rPo5D
         Irb8m9kOi1JxtKc678oKWoPL2tKEYYCdCeE0E3IT9fmsWp5/5pL5iPT34ZZuJzJYZaxX
         htHt9oPqIiWO8PFHrwnP3oP3VoENkIdQ/1FPKsPabs9v6p+8h3TyshWE6pYbxYejTc7R
         ryLp3RxvydEg+go2eFkf2kOrzzMpu8ba5qF90WxcU7+f8+ZHk+io5EO+2kGS58PGI6EM
         QzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753996812; x=1754601612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7whMSj4GW59YuO3bK58f0y4iIovKl3vCWboamrKQYI=;
        b=jlj9P/Gc73LUr/9/rz5scOubosAWrS0lo7iNnjiA86EOT07GH4LQ+6GZuZoaVEMHIq
         HqxPc/QGnvVVVp2xmpDh5R96lliFW4L/6A8d9CoMiBtnSFmAOZygUo5TbgjPrATG2hIX
         ktfo49/6jvMKLWcV5dNKZCK4qWrV4T0bFjFO6yjcwGeHzccZDel9eeh4Aw6aoG4hhbxC
         8k72msu9oySVSxPJ/UaE6VvpyiytF9Yd95emlW/sj3PPL3rv4Y3s8alB6bEtIDprRsk/
         nlx78URNQaxQZy/C3J/4ufR3CVqfUJ6S8DDklYQaa7FkTjbeULqBGQUr4Hu8V2u2jwmY
         eGnw==
X-Forwarded-Encrypted: i=1; AJvYcCU3wJThIJv3OTsIpvkfq40DoTYhZ+sDDv2S2p3MzB9iSSjM3XS2Que8j8ejwDro2mOSzHLgjauRNrWxoGWzNlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGqd+7nga3xjYV+65PiV4LH3eEqEemYjWVJNVFhETY7j0Nj27v
	DqWcj2TcK6coD5eqq3mL/irUrHlyZnGEcb61P+vQctASrxOHmQ0MWFtbf9ZrxLigcELCR0L56Nb
	GJLoq5HPAzT7INQ==
X-Google-Smtp-Source: AGHT+IG3d5WxcS5Lhh7Yi0TSfL5o13oztWxshjglDCP/OQyqEPXNyDBcj9eLVkgSsHcYZ16+/AhhWRYIXQGu9A==
X-Received: from pjbsr13.prod.google.com ([2002:a17:90b:4e8d:b0:311:d79d:e432])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:6c4:b0:31f:44a:229c with SMTP id 98e67ed59e1d1-31f5dde6ae1mr13618876a91.12.1753996812385;
 Thu, 31 Jul 2025 14:20:12 -0700 (PDT)
Date: Thu, 31 Jul 2025 21:20:03 +0000
In-Reply-To: <20250731212004.1437336-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731212004.1437336-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731212004.1437336-4-jiaqiyan@google.com>
Subject: [PATCH v1 3/4] KVM: selftests: Test injecting external abort with ISS
From: Jiaqi Yan <jiaqiyan@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	rananta@google.com, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Test userspace can use KVM_SET_VCPU_EVENTS to inject an external
instruction or data abort with customized ISS if provided.

The test injects fake external aborts without real instruction or
data abort happening to VCPU, and only certain ESR_EL1 bits are
expected and asserted.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 tools/arch/arm64/include/uapi/asm/kvm.h       |   7 +-
 .../selftests/kvm/arm64/external_aborts.c     | 191 +++++++++++++++---
 .../testing/selftests/kvm/arm64/inject_iabt.c |  98 +++++++++
 3 files changed, 264 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/arm64/inject_iabt.c

diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index ed5f3892674c7..406d6e67df822 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -184,11 +184,14 @@ struct kvm_vcpu_events {
 		__u8 serror_pending;
 		__u8 serror_has_esr;
 		__u8 ext_dabt_pending;
+		__u8 ext_iabt_pending;
+		__u8 ext_abt_has_esr;
 		/* Align it to 8 bytes */
-		__u8 pad[5];
+		__u8 pad[3];
 		__u64 serror_esr;
+		__u64 ext_abt_esr;
 	} exception;
-	__u32 reserved[12];
+	__u32 reserved[10];
 };
 
 struct kvm_arm_copy_mte_tags {
diff --git a/tools/testing/selftests/kvm/arm64/external_aborts.c b/tools/testing/selftests/kvm/arm64/external_aborts.c
index 062bf84cced13..a6396ff4f84da 100644
--- a/tools/testing/selftests/kvm/arm64/external_aborts.c
+++ b/tools/testing/selftests/kvm/arm64/external_aborts.c
@@ -9,10 +9,14 @@
 
 #define MMIO_ADDR		0x8000000ULL
 #define EXPECTED_SERROR_ISS	(ESR_ELx_ISV | 0x1d1ed)
+#define FAKE_DABT_ISS		(ESR_ELx_ISV | ESR_ELx_SAS | ESR_ELx_SF | \
+				 ESR_ELx_AR | ESR_ELx_CM | ESR_ELx_FnV | \
+				 ESR_ELx_EA)
+#define FAKE_IABT_ISS		(ESR_ELx_ISV | ESR_ELx_FnV | ESR_ELx_EA)
 
 static u64 expected_abort_pc;
 
-static void expect_sea_handler(struct ex_regs *regs)
+static void expect_dabt_handler(struct ex_regs *regs)
 {
 	u64 esr = read_sysreg(esr_el1);
 
@@ -23,19 +27,60 @@ static void expect_sea_handler(struct ex_regs *regs)
 	GUEST_DONE();
 }
 
+static void expect_dabt_esr_handler(struct ex_regs *regs)
+{
+	u64 esr = read_sysreg(esr_el1);
+
+	GUEST_PRINTF("Handling guest instruction abort\n");
+	GUEST_PRINTF("  ESR_EL1=%#lx\n", esr);
+
+	GUEST_ASSERT_EQ(ESR_ELx_EC(esr), ESR_ELx_EC_DABT_CUR);
+	GUEST_ASSERT_EQ(esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);
+	GUEST_ASSERT_EQ(esr & FAKE_DABT_ISS, FAKE_DABT_ISS);
+
+	GUEST_DONE();
+}
+
+static void expect_iabt_esr_handler(struct ex_regs *regs)
+{
+	u64 esr = read_sysreg(esr_el1);
+
+	GUEST_PRINTF("Handling guest instruction abort\n");
+	GUEST_PRINTF("  ESR_EL1=%#lx\n", esr);
+
+	GUEST_ASSERT_EQ(ESR_ELx_EC(esr), ESR_ELx_EC_IABT_CUR);
+	GUEST_ASSERT_EQ(esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);
+	GUEST_ASSERT_EQ(esr & FAKE_IABT_ISS, FAKE_IABT_ISS);
+
+	GUEST_DONE();
+}
+
 static void unexpected_dabt_handler(struct ex_regs *regs)
 {
 	GUEST_FAIL("Unexpected data abort at PC: %lx\n", regs->pc);
 }
 
-static struct kvm_vm *vm_create_with_dabt_handler(struct kvm_vcpu **vcpu, void *guest_code,
-						  handler_fn dabt_handler)
+static void unexpected_iabt_handler(struct ex_regs *regs)
+{
+	GUEST_FAIL("Unexpected instruction abort at PC: %lx\n", regs->pc);
+}
+
+static struct kvm_vm *vm_create_with_extabt_handler(struct kvm_vcpu **vcpu,
+						    void *guest_code,
+						    handler_fn dabt_handler,
+						    handler_fn iabt_handler)
 {
 	struct kvm_vm *vm = vm_create_with_one_vcpu(vcpu, guest_code);
 
 	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(*vcpu);
-	vm_install_sync_handler(vm, VECTOR_SYNC_CURRENT, ESR_ELx_EC_DABT_CUR, dabt_handler);
+
+	if (dabt_handler)
+		vm_install_sync_handler(vm, VECTOR_SYNC_CURRENT,
+					ESR_ELx_EC_DABT_CUR, dabt_handler);
+	if (iabt_handler)
+		vm_install_sync_handler(vm, VECTOR_SYNC_CURRENT,
+					ESR_ELx_EC_IABT_CUR, iabt_handler);
 
 	virt_map(vm, MMIO_ADDR, MMIO_ADDR, 1);
 
@@ -50,6 +95,26 @@ static void vcpu_inject_sea(struct kvm_vcpu *vcpu)
 	vcpu_events_set(vcpu, &events);
 }
 
+static void vcpu_inject_dabt_esr(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_events events = {};
+
+	events.exception.ext_dabt_pending = true;
+	events.exception.ext_abt_has_esr = true;
+	events.exception.ext_abt_esr = FAKE_DABT_ISS;
+	vcpu_events_set(vcpu, &events);
+}
+
+static void vcpu_inject_iabt_esr(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_events events = {};
+
+	events.exception.ext_iabt_pending = true;
+	events.exception.ext_abt_has_esr = true;
+	events.exception.ext_abt_esr = FAKE_IABT_ISS;
+	vcpu_events_set(vcpu, &events);
+}
+
 static bool vcpu_has_ras(struct kvm_vcpu *vcpu)
 {
 	u64 pfr0 = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_ID_AA64PFR0_EL1));
@@ -79,17 +144,24 @@ static void __vcpu_run_expect(struct kvm_vcpu *vcpu, unsigned int cmd)
 {
 	struct ucall uc;
 
-	vcpu_run(vcpu);
-	switch (get_ucall(vcpu, &uc)) {
-	case UCALL_ABORT:
-		REPORT_GUEST_ASSERT(uc);
-		break;
-	default:
-		if (uc.cmd == cmd)
-			return;
-
-		TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
-	}
+	do {
+		vcpu_run(vcpu);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		case UCALL_PRINTF:
+			ksft_print_msg("From guest: %s", uc.buffer);
+			break;
+		default:
+			if (uc.cmd == cmd) {
+				ksft_print_msg("Expect ucall: %lu\n", uc.cmd);
+				return;
+			}
+
+			TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
+		}
+	} while (true);
 }
 
 static void vcpu_run_expect_done(struct kvm_vcpu *vcpu)
@@ -122,8 +194,10 @@ static noinline void test_mmio_abort_guest(void)
 static void test_mmio_abort(void)
 {
 	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm = vm_create_with_dabt_handler(&vcpu, test_mmio_abort_guest,
-							expect_sea_handler);
+	struct kvm_vm *vm = vm_create_with_extabt_handler(&vcpu,
+							  test_mmio_abort_guest,
+							  expect_dabt_handler,
+							  unexpected_iabt_handler);
 	struct kvm_run *run = vcpu->run;
 
 	vcpu_run(vcpu);
@@ -157,8 +231,10 @@ static void test_mmio_nisv_guest(void)
 static void test_mmio_nisv(void)
 {
 	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm = vm_create_with_dabt_handler(&vcpu, test_mmio_nisv_guest,
-							unexpected_dabt_handler);
+	struct kvm_vm *vm = vm_create_with_extabt_handler(&vcpu,
+							  test_mmio_nisv_guest,
+							  unexpected_dabt_handler,
+							  unexpected_iabt_handler);
 
 	TEST_ASSERT(_vcpu_run(vcpu), "Expected nonzero return code from KVM_RUN");
 	TEST_ASSERT_EQ(errno, ENOSYS);
@@ -173,8 +249,10 @@ static void test_mmio_nisv(void)
 static void test_mmio_nisv_abort(void)
 {
 	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm = vm_create_with_dabt_handler(&vcpu, test_mmio_nisv_guest,
-							expect_sea_handler);
+	struct kvm_vm *vm = vm_create_with_extabt_handler(&vcpu,
+							  test_mmio_nisv_guest,
+							  expect_dabt_handler,
+							  unexpected_iabt_handler);
 	struct kvm_run *run = vcpu->run;
 
 	vm_enable_cap(vm, KVM_CAP_ARM_NISV_TO_USER, 1);
@@ -205,8 +283,10 @@ static void test_serror_masked_guest(void)
 static void test_serror_masked(void)
 {
 	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm = vm_create_with_dabt_handler(&vcpu, test_serror_masked_guest,
-							unexpected_dabt_handler);
+	struct kvm_vm *vm = vm_create_with_extabt_handler(&vcpu,
+							  test_serror_masked_guest,
+							  unexpected_dabt_handler,
+							  unexpected_iabt_handler);
 
 	vm_install_exception_handler(vm, VECTOR_ERROR_CURRENT, unexpected_serror_handler);
 
@@ -240,8 +320,10 @@ static void test_serror_guest(void)
 static void test_serror(void)
 {
 	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm = vm_create_with_dabt_handler(&vcpu, test_serror_guest,
-							unexpected_dabt_handler);
+	struct kvm_vm *vm = vm_create_with_extabt_handler(&vcpu,
+							  test_serror_guest,
+							  unexpected_dabt_handler,
+							  unexpected_iabt_handler);
 
 	vm_install_exception_handler(vm, VECTOR_ERROR_CURRENT, expect_serror_handler);
 
@@ -264,8 +346,10 @@ static void test_serror_emulated_guest(void)
 static void test_serror_emulated(void)
 {
 	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm = vm_create_with_dabt_handler(&vcpu, test_serror_emulated_guest,
-							unexpected_dabt_handler);
+	struct kvm_vm *vm = vm_create_with_extabt_handler(&vcpu,
+							  test_serror_emulated_guest,
+							  unexpected_dabt_handler,
+							  unexpected_iabt_handler);
 
 	vm_install_exception_handler(vm, VECTOR_ERROR_CURRENT, expect_serror_handler);
 
@@ -290,8 +374,10 @@ static void test_mmio_ease_guest(void)
 static void test_mmio_ease(void)
 {
 	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm = vm_create_with_dabt_handler(&vcpu, test_mmio_ease_guest,
-							unexpected_dabt_handler);
+	struct kvm_vm *vm = vm_create_with_extabt_handler(&vcpu,
+							  test_mmio_ease_guest,
+							  unexpected_dabt_handler,
+							  unexpected_iabt_handler);
 	struct kvm_run *run = vcpu->run;
 	u64 pfr1;
 
@@ -305,7 +391,7 @@ static void test_mmio_ease(void)
 	 * SCTLR2_ELx.EASE changes the exception vector to the SError vector but
 	 * doesn't further modify the exception context (e.g. ESR_ELx, FAR_ELx).
 	 */
-	vm_install_exception_handler(vm, VECTOR_ERROR_CURRENT, expect_sea_handler);
+	vm_install_exception_handler(vm, VECTOR_ERROR_CURRENT, expect_dabt_handler);
 
 	vcpu_run(vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_MMIO);
@@ -318,6 +404,49 @@ static void test_mmio_ease(void)
 	kvm_vm_free(vm);
 }
 
+static void test_ext_abt_guest(void)
+{
+	GUEST_FAIL("Guest should only run (I|D)ABT handler");
+}
+
+static void test_inject_data_abort(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm = vm_create_with_extabt_handler(&vcpu,
+							  test_ext_abt_guest,
+							  expect_dabt_esr_handler,
+							  unexpected_iabt_handler);
+	vcpu_inject_dabt_esr(vcpu);
+	vcpu_run_expect_done(vcpu);
+	kvm_vm_free(vm);
+}
+
+static void vcpu_inject_invalid_abt(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_events events = {};
+	int r;
+
+	events.exception.ext_iabt_pending = true;
+	events.exception.ext_dabt_pending = true;
+
+	r = __vcpu_ioctl(vcpu, KVM_SET_VCPU_EVENTS, &events);
+	TEST_ASSERT(r && errno == EINVAL,
+		    KVM_IOCTL_ERROR(KVM_SET_VCPU_EVENTS, r));
+}
+
+static void test_inject_instruction_abort(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm = vm_create_with_extabt_handler(&vcpu,
+							  test_ext_abt_guest,
+							  unexpected_dabt_handler,
+							  expect_iabt_esr_handler);
+	vcpu_inject_invalid_abt(vcpu);
+	vcpu_inject_iabt_esr(vcpu);
+	vcpu_run_expect_done(vcpu);
+	kvm_vm_free(vm);
+}
+
 int main(void)
 {
 	test_mmio_abort();
@@ -327,4 +456,6 @@ int main(void)
 	test_serror_masked();
 	test_serror_emulated();
 	test_mmio_ease();
+	test_inject_instruction_abort();
+	test_inject_data_abort();
 }
diff --git a/tools/testing/selftests/kvm/arm64/inject_iabt.c b/tools/testing/selftests/kvm/arm64/inject_iabt.c
new file mode 100644
index 0000000000000..0c7999e5ba5b3
--- /dev/null
+++ b/tools/testing/selftests/kvm/arm64/inject_iabt.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * inject_iabt.c - Tests for injecting instruction aborts into guest.
+ */
+
+#include "processor.h"
+#include "test_util.h"
+
+static void expect_iabt_handler(struct ex_regs *regs)
+{
+	u64 esr = read_sysreg(esr_el1);
+
+	GUEST_PRINTF("Handling Guest SEA\n");
+	GUEST_PRINTF("  ESR_EL1=%#lx\n", esr);
+
+	GUEST_ASSERT_EQ(ESR_ELx_EC(esr), ESR_ELx_EC_IABT_CUR);
+	GUEST_ASSERT_EQ(esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);
+
+	GUEST_DONE();
+}
+
+static void guest_code(void)
+{
+	GUEST_FAIL("Guest should only run SEA handler");
+}
+
+static void vcpu_run_expect_done(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+	bool guest_done = false;
+
+	do {
+		vcpu_run(vcpu);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		case UCALL_PRINTF:
+			ksft_print_msg("From guest: %s", uc.buffer);
+			break;
+		case UCALL_DONE:
+			ksft_print_msg("Guest done gracefully!\n");
+			guest_done = true;
+			break;
+		default:
+			TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
+		}
+	} while (!guest_done);
+}
+
+static void vcpu_inject_ext_iabt(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_events events = {};
+
+	events.exception.ext_iabt_pending = true;
+	vcpu_events_set(vcpu, &events);
+}
+
+static void vcpu_inject_invalid_abt(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_events events = {};
+	int r;
+
+	events.exception.ext_iabt_pending = true;
+	events.exception.ext_dabt_pending = true;
+
+	ksft_print_msg("Injecting invalid external abort events\n");
+	r = __vcpu_ioctl(vcpu, KVM_SET_VCPU_EVENTS, &events);
+	TEST_ASSERT(r && errno == EINVAL,
+		    KVM_IOCTL_ERROR(KVM_SET_VCPU_EVENTS, r));
+}
+
+static void test_inject_iabt(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	vm_init_descriptor_tables(vm);
+	vcpu_init_descriptor_tables(vcpu);
+
+	vm_install_sync_handler(vm, VECTOR_SYNC_CURRENT,
+				ESR_ELx_EC_IABT_CUR, expect_iabt_handler);
+
+	vcpu_inject_invalid_abt(vcpu);
+
+	vcpu_inject_ext_iabt(vcpu);
+	vcpu_run_expect_done(vcpu);
+
+	kvm_vm_free(vm);
+}
+
+int main(void)
+{
+	test_inject_iabt();
+	return 0;
+}
-- 
2.50.1.565.gc32cd1483b-goog


