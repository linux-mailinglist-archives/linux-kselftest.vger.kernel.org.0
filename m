Return-Path: <linux-kselftest+bounces-5593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F6B86BE02
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 02:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933C31F2A14C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 01:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF1455E4B;
	Thu, 29 Feb 2024 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1sJF8yRi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9575646F
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 01:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168529; cv=none; b=VeGR6FTWmcO95ZjMeJ45dPfmWdJ0RPZdUMmWu9ViOG85aY+GRC15ME3X8W/t8jiHkZyaOkZiYKHKqaRNQ7ub4ddKNxpFIARlaw0ijzZxTqKSNhPsIK4AtKuZpBqL0FZkvgo5MlCS4fKFcNcwhgsdfQVsfOMiKYMy2X+VHyaM3AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168529; c=relaxed/simple;
	bh=FEztEBCEzO6lDa0FQzdTcssEBL+8qXM364RAZfcEOuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SpK+nDIAl0iAvXP/NWbZa6eOJ8zWi7rvDVKUR9ewdB1SGIrCyoGk5lPpeBPFGPlcvTh+MNUrO37auqxRECDeTCyfz1q0m9k46Olpe5g0961U2O7Hh0EYPEFWoQ91GxnxTHj/Rhifo851Iw08FgZ/RvPWERqDg9dhvKPRDQOFOsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1sJF8yRi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d94b222a3aso4448415ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 17:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709168527; x=1709773327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ2VUtbLaQ9lOdd37SBu/yCmKnVIsQUEbE5aRuu2Z70=;
        b=1sJF8yRibJMHWHMJzNTwLudeidb8tdQc/9KYRuoK9FhrgK1PvXlggWuGtgCtY2VKMQ
         Min5bp5quGvTbS0FXacH3gH+ExRVo+fYXwCuYZrXPYb27PPlbajwhrp8XYDvwQQiUhwe
         M2vRslpdaDazALws+VcJFKnjLv7BJIyZspGjdsT05loe0cIOV3vQg3XSXUMuQKGwRs0F
         1b6m+b3bFQSTVfy/B1h0O47KqbpKl/Xz6BTsTMYGNHVuA8gLB+TVschX7JsXSBn7Bu2v
         mdSgl7pbEEBydxYJICqWZrXy5V5ONvWXLJQHYMuAMegRXZX5lRJKudPsrQLqFco9OmZu
         ejLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168527; x=1709773327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJ2VUtbLaQ9lOdd37SBu/yCmKnVIsQUEbE5aRuu2Z70=;
        b=i1qumGS+nlmS9BSq71Zs1GfEk5ID9Y5IuPXuIDjYMvcJPDRJ0nB+B95z0WsdTGdmXJ
         O71wDxoW2aHwKpviXiCLMR9XKMNIhFVpPX9Jy+ciXDkXPRkXj40p0nuuyFK+EnYNBurW
         UwBlIs+1Gye5IRAiL7Ql8SObGmUYDHOi/ZAMcqLa0d3W7yCx9qnEf/xMZT9B7XLQ7KhO
         2oBvRDMQ30pu/6sADJXEcmJIt6UpE/Xi2j5Dq2gGiP9zmf66qlPdFBG0PaIG3aCT0jpE
         MVjw65hWyeGzNjPq/C/rvu3kJ9zs+eaRWOyJCcMJu/yqX7OXDHhF0+h6czgTavbWdZK/
         QLYw==
X-Forwarded-Encrypted: i=1; AJvYcCW3heL7Hty9UfJsig/qdfn763iU0MMD9YZT66Ku1RRUkqHMOWDz9ZMwykvrR01bt/el/yNQjnnwK6qN2kXMP+RYgcSeOjlOLhjx7NZBKI4q
X-Gm-Message-State: AOJu0YzImwVayNQspRqpp/PLIS8HEQt6YFvOwgoEcIUpQDNEII4g0MA0
	R7q2YZ8dEMJMTCeN4ptWT8Qb2D9lhgAJRjVxiZuFQGa60dOeGUwaqGwYvvNCMh56MBghVNO1DxQ
	N
X-Google-Smtp-Source: AGHT+IGeJ2TX2e1/AVgQrlWwwewtQU0Iq+EdlhkTaVKmJ8/GQ0YRQzdBq1EA4Qgv9EWmM7B9wA2nQg==
X-Received: by 2002:a17:902:d386:b0:1dc:5d2e:c18c with SMTP id e6-20020a170902d38600b001dc5d2ec18cmr595324pld.67.1709168527350;
        Wed, 28 Feb 2024 17:02:07 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b001dc8d6a9d40sm78043plx.144.2024.02.28.17.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:02:07 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Icenowy Zheng <uwu@icenowy.me>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v4 15/15] KVM: riscv: selftests: Add a test for counter overflow
Date: Wed, 28 Feb 2024 17:01:30 -0800
Message-Id: <20240229010130.1380926-16-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229010130.1380926-1-atishp@rivosinc.com>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for verifying overflow interrupt. Currently, it relies on
overflow support on cycle/instret events. This test works for cycle/
instret events which support sampling via hpmcounters on the platform.
There are no ISA extensions to detect if a platform supports that. Thus,
this test will fail on platform with virtualization but doesn't
support overflow on these two events.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/riscv/sbi_pmu.c | 126 +++++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu.c b/tools/testing/selftests/kvm/riscv/sbi_pmu.c
index 8ea2a6db6610..c0264c636054 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu.c
@@ -8,6 +8,7 @@
  * Copyright (c) 2024, Rivos Inc.
  */
 
+#include "asm/csr.h"
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -16,6 +17,7 @@
 #include "kvm_util.h"
 #include "test_util.h"
 #include "processor.h"
+#include "arch_timer.h"
 
 /* Maximum counters (firmware + hardware)*/
 #define RISCV_MAX_PMU_COUNTERS 64
@@ -26,6 +28,11 @@ union sbi_pmu_ctr_info ctrinfo_arr[RISCV_MAX_PMU_COUNTERS];
 static void *snapshot_gva;
 static vm_paddr_t snapshot_gpa;
 
+static int pmu_irq = IRQ_PMU_OVF;
+
+static int vcpu_shared_irq_count;
+static int counter_in_use;
+
 /* Cache the available counters in a bitmask */
 static unsigned long counter_mask_available;
 
@@ -69,7 +76,9 @@ unsigned long pmu_csr_read_num(int csr_num)
 #undef switchcase_csr_read
 }
 
-static inline void dummy_func_loop(int iter)
+static void stop_counter(unsigned long counter, unsigned long stop_flags);
+
+static inline void dummy_func_loop(uint64_t iter)
 {
 	int i = 0;
 
@@ -88,6 +97,26 @@ static void guest_illegal_exception_handler(struct ex_regs *regs)
 	regs->epc += 4;
 }
 
+static void guest_irq_handler(struct ex_regs *regs)
+{
+	unsigned int irq_num = regs->cause & ~CAUSE_IRQ_FLAG;
+	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
+	unsigned long overflown_mask;
+
+	/* Stop all counters first to avoid further interrupts */
+	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0, 1UL << counter_in_use,
+		  SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT, 0, 0, 0);
+
+	csr_clear(CSR_SIP, BIT(pmu_irq));
+
+	overflown_mask = READ_ONCE(snapshot_data->ctr_overflow_mask);
+	GUEST_ASSERT(overflown_mask & (1UL << counter_in_use));
+
+	/* Validate that we are in the correct irq handler */
+	GUEST_ASSERT_EQ(irq_num, pmu_irq);
+	WRITE_ONCE(vcpu_shared_irq_count, vcpu_shared_irq_count+1);
+}
+
 static unsigned long get_counter_index(unsigned long cbase, unsigned long cmask,
 				       unsigned long cflags,
 				       unsigned long event)
@@ -263,6 +292,32 @@ static void test_pmu_event_snapshot(unsigned long event)
 	stop_counter(counter, SBI_PMU_STOP_FLAG_RESET);
 }
 
+static void test_pmu_event_overflow(unsigned long event)
+{
+	unsigned long counter;
+	unsigned long counter_value_post;
+	unsigned long counter_init_value = ULONG_MAX - 10000;
+	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
+
+	counter = get_counter_index(0, counter_mask_available, 0, event);
+	counter_in_use = counter;
+
+	/* The counter value is updated w.r.t relative index of cbase passed to start/stop */
+	WRITE_ONCE(snapshot_data->ctr_values[0], counter_init_value);
+	start_counter(counter, SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT, 0);
+	dummy_func_loop(10000);
+	udelay(msecs_to_usecs(2000));
+	/* irq handler should have stopped the counter */
+
+	counter_value_post = READ_ONCE(snapshot_data->ctr_values[counter_in_use]);
+	/* The counter value after stopping should be less the init value due to overflow */
+	__GUEST_ASSERT(counter_value_post < counter_init_value,
+		       "counter_value_post %lx counter_init_value %lx for counter\n",
+		       counter_value_post, counter_init_value);
+
+	stop_counter(counter, SBI_PMU_STOP_FLAG_RESET);
+}
+
 static void test_invalid_event(void)
 {
 	struct sbiret ret;
@@ -361,6 +416,43 @@ static void test_pmu_events_snaphost(int cpu)
 	GUEST_DONE();
 }
 
+static void test_pmu_events_overflow(int cpu)
+{
+	long out_val = 0;
+	bool probe;
+	int num_counters = 0;
+	unsigned long sbi_impl_version;
+
+	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
+	GUEST_ASSERT(probe && out_val == 1);
+
+	sbi_impl_version = get_host_sbi_impl_version();
+	if (sbi_impl_version >= sbi_mk_version(2, 0))
+		__GUEST_ASSERT(0, "SBI implementation version doesn't support PMU Snapshot");
+
+	snapshot_set_shmem(snapshot_gpa, 0);
+	csr_set(CSR_IE, BIT(pmu_irq));
+	local_irq_enable();
+
+	/* Get the counter details */
+	num_counters = get_num_counters();
+	update_counter_info(num_counters);
+
+	/*
+	 * Qemu supports overflow for cycle/instruction.
+	 * This test may fail on any platform that do not support overflow for these two events.
+	 */
+	test_pmu_event_overflow(SBI_PMU_HW_CPU_CYCLES);
+	GUEST_ASSERT_EQ(vcpu_shared_irq_count, 1);
+
+	/* Renable the interrupt again for another event */
+	csr_set(CSR_IE, BIT(pmu_irq));
+	test_pmu_event_overflow(SBI_PMU_HW_INSTRUCTIONS);
+	GUEST_ASSERT_EQ(vcpu_shared_irq_count, 2);
+
+	GUEST_DONE();
+}
+
 static void run_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct ucall uc;
@@ -449,6 +541,35 @@ static void test_vm_events_snapshot_test(void *guest_code)
 	test_vm_destroy(vm);
 }
 
+static void test_vm_events_overflow(void *guest_code)
+{
+	struct kvm_vm *vm = NULL;
+	struct kvm_vcpu *vcpu = NULL;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	__TEST_REQUIRE(__vcpu_has_ext(vcpu, RISCV_SBI_EXT_REG(KVM_RISCV_SBI_EXT_PMU)),
+				   "SBI PMU not available, skipping test");
+
+	__TEST_REQUIRE(__vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_SSCOFPMF)),
+				   "Sscofpmf is not available, skipping overflow test");
+
+
+	test_vm_setup_snapshot_mem(vm, vcpu);
+	vm_init_vector_tables(vm);
+	vm_install_interrupt_handler(vm, guest_irq_handler);
+
+	vcpu_init_vector_tables(vcpu);
+	/* Initialize guest timer frequency. */
+	vcpu_get_reg(vcpu, RISCV_TIMER_REG(frequency), &timer_freq);
+	sync_global_to_guest(vm, timer_freq);
+
+	vcpu_args_set(vcpu, 1, 0);
+
+	run_vcpu(vcpu);
+
+	test_vm_destroy(vm);
+}
+
 int main(void)
 {
 	test_vm_basic_test(test_pmu_basic_sanity);
@@ -460,5 +581,8 @@ int main(void)
 	test_vm_events_snapshot_test(test_pmu_events_snaphost);
 	pr_info("SBI PMU event verification with snapshot test : PASS\n");
 
+	test_vm_events_overflow(test_pmu_events_overflow);
+	pr_info("SBI PMU event verification with overflow test : PASS\n");
+
 	return 0;
 }
-- 
2.34.1


