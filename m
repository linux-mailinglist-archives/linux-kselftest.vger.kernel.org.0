Return-Path: <linux-kselftest+bounces-8507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DCE8AB7E8
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C9E1C2113A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1151152E14;
	Fri, 19 Apr 2024 23:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ETskscgY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29517152DE4
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570508; cv=none; b=A8XLKP8Ojqc7YnKehWReE/F7Zd9r3hFcewNcPuXrrwGlsb7hDFLZf2akBTUmrUVPp9YmwBrx8ioZE/BmqFb31N2xsL6en3KvsSPCgnRpzf+/4t7+hDxwX4folVyE59KWTDbEeDTZ6Q+Kkotz+94w5uuWVNtL7MCuT78r1+Lx+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570508; c=relaxed/simple;
	bh=65rhAcwCILUb42nVmZohYDmQAcxJzl/q2lZjypsWOFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sRlwYFWIjGSKQPwPqwEXT4D62FwgUuCt9HqozSkFiB9eJ/DescKGp5G1lz+NTnUBm3h+UmFQVH5ZEtTNFS2JfWWdPVjgd1sgU/N6V4gkKptx0JC5WNHscsARkgDIla9jJYfyH1kAFSh+8I1jvnzqqqvLeSe5QoCVwh+fdl6Bw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ETskscgY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0bec01232so21670235ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570506; x=1714175306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdAbjdLX31vZDITT2BD/zRGEaHkPavc56BKt6Swumik=;
        b=ETskscgYWqirMIdgJWxQ+OjgPkfaKtDOxxF/kwQacuUyPFwVnwzvSBsL7RKn+MzC+I
         vNcJAhgWzwva6AA5apK0uGViYUAzHnCGHHWjSYi5+M0qQpQ3JjKVeLMkIQqTs7OzSncY
         OLjwiHuehM8sKpKOGqNSbPAJ7eZ6Kz2MuBBViW+A3NAcUcpgkPpZ7qHpQsgf0FUYEHdU
         pUG6if520AZbNmDJFGx8SEAEaYlvIXsjpC65qheT37I0fzobXBe9/moPspB2uKn+stSN
         iaSzvuKvyBC0qn5Uc4VITKZdNlLIc4YmuqYOaItA8bttwJMINNTjG2dqWa8ottDi3AXF
         yeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570506; x=1714175306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdAbjdLX31vZDITT2BD/zRGEaHkPavc56BKt6Swumik=;
        b=QosoSJmWdqS4dXswFXWC8z7YHywsYxGTccpLBMceKG8PUVyz4tLYZMCZbxdWxBCc7F
         J9Zw5Qra+rJ+OIJxj2AninKwSRCBM7/lWGjE9AlKIK4LXzKxz2G9EvIgFIMgxSha8auy
         fRagcoOfwZiBdYIpnPvenakqI0Y3gJaHdKSQ3gM43np0nIHlXr8IelBJ+JW/UJZJIRT8
         xG0LrpUurJBFQytwAMO8xbvy/WqyHOAMroWcZNLmmDj8kbO0dyVwgRuhnzNASe+5GQUa
         KdBFH8M4zNUwAgK4jJ7+kJCwI2HNukfhGiMLwY8WBWm81jBliZOSGRUr7uKkUL9NTTir
         DlNg==
X-Forwarded-Encrypted: i=1; AJvYcCW5bnFY/fX1u8I1FU0mX4CA4neRynHamEq6zw4PsiymMvjU40avPDiMYoTYBXUiXzFoBlFsvsoOZJZNSFLMxKcjtL3dn73go3VNt4eIuakY
X-Gm-Message-State: AOJu0YzwdwRaRC0axXbucdkYT3Bqmq5s1N4VM2aAq60PKDV05OBEOZCP
	N7zECIr1uhNaPotY+5YvEwQVrltpYyGirTNtKSzZWpj0nhgK9N8W+4KBenk+C3M=
X-Google-Smtp-Source: AGHT+IGUisPuhIoBB2uewGVgryhPiVPTNbYszuONanZutchrRkp+W8Aws+SoxCWo0EP8xVF9kNEMSw==
X-Received: by 2002:a17:902:db02:b0:1e0:a4c9:84cd with SMTP id m2-20020a170902db0200b001e0a4c984cdmr4751809plx.60.1713570506483;
        Fri, 19 Apr 2024 16:48:26 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:48:26 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	samuel.holland@sifive.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v8 23/24] KVM: riscv: selftests: Add a test for counter overflow
Date: Sat, 20 Apr 2024 08:17:39 -0700
Message-Id: <20240420151741.962500-24-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
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

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../selftests/kvm/riscv/sbi_pmu_test.c        | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index 9002ff451abf..0fd9b76ae838 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -14,6 +14,7 @@
 #include "test_util.h"
 #include "processor.h"
 #include "sbi.h"
+#include "arch_timer.h"
 
 /* Maximum counters(firmware + hardware) */
 #define RISCV_MAX_PMU_COUNTERS 64
@@ -24,6 +25,9 @@ union sbi_pmu_ctr_info ctrinfo_arr[RISCV_MAX_PMU_COUNTERS];
 static void *snapshot_gva;
 static vm_paddr_t snapshot_gpa;
 
+static int vcpu_shared_irq_count;
+static int counter_in_use;
+
 /* Cache the available counters in a bitmask */
 static unsigned long counter_mask_available;
 
@@ -120,6 +124,31 @@ static void guest_illegal_exception_handler(struct ex_regs *regs)
 	regs->epc += 4;
 }
 
+static void guest_irq_handler(struct ex_regs *regs)
+{
+	unsigned int irq_num = regs->cause & ~CAUSE_IRQ_FLAG;
+	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
+	unsigned long overflown_mask;
+	unsigned long counter_val = 0;
+
+	/* Validate that we are in the correct irq handler */
+	GUEST_ASSERT_EQ(irq_num, IRQ_PMU_OVF);
+
+	/* Stop all counters first to avoid further interrupts */
+	stop_counter(counter_in_use, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
+
+	csr_clear(CSR_SIP, BIT(IRQ_PMU_OVF));
+
+	overflown_mask = READ_ONCE(snapshot_data->ctr_overflow_mask);
+	GUEST_ASSERT(overflown_mask & 0x01);
+
+	WRITE_ONCE(vcpu_shared_irq_count, vcpu_shared_irq_count+1);
+
+	counter_val = READ_ONCE(snapshot_data->ctr_values[0]);
+	/* Now start the counter to mimick the real driver behavior */
+	start_counter(counter_in_use, SBI_PMU_START_FLAG_SET_INIT_VALUE, counter_val);
+}
+
 static unsigned long get_counter_index(unsigned long cbase, unsigned long cmask,
 				       unsigned long cflags,
 				       unsigned long event)
@@ -318,6 +347,33 @@ static void test_pmu_event_snapshot(unsigned long event)
 	stop_reset_counter(counter, 0);
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
+	start_counter(counter, SBI_PMU_START_FLAG_INIT_SNAPSHOT, 0);
+	dummy_func_loop(10000);
+	udelay(msecs_to_usecs(2000));
+	/* irq handler should have stopped the counter */
+	stop_counter(counter, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
+
+	counter_value_post = READ_ONCE(snapshot_data->ctr_values[0]);
+	/* The counter value after stopping should be less the init value due to overflow */
+	__GUEST_ASSERT(counter_value_post < counter_init_value,
+		       "counter_value_post %lx counter_init_value %lx for counter\n",
+		       counter_value_post, counter_init_value);
+
+	stop_reset_counter(counter, 0);
+}
+
 static void test_invalid_event(void)
 {
 	struct sbiret ret;
@@ -413,6 +469,34 @@ static void test_pmu_events_snaphost(void)
 	GUEST_DONE();
 }
 
+static void test_pmu_events_overflow(void)
+{
+	int num_counters = 0;
+
+	/* Verify presence of SBI PMU and minimum requrired SBI version */
+	verify_sbi_requirement_assert();
+
+	snapshot_set_shmem(snapshot_gpa, 0);
+	csr_set(CSR_IE, BIT(IRQ_PMU_OVF));
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
+	test_pmu_event_overflow(SBI_PMU_HW_INSTRUCTIONS);
+	GUEST_ASSERT_EQ(vcpu_shared_irq_count, 2);
+
+	GUEST_DONE();
+}
+
 static void run_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct ucall uc;
@@ -498,6 +582,32 @@ static void test_vm_events_snapshot_test(void *guest_code)
 	test_vm_destroy(vm);
 }
 
+static void test_vm_events_overflow(void *guest_code)
+{
+	struct kvm_vm *vm = NULL;
+	struct kvm_vcpu *vcpu;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	__TEST_REQUIRE(__vcpu_has_sbi_ext(vcpu, KVM_RISCV_SBI_EXT_PMU),
+				   "SBI PMU not available, skipping test");
+
+	__TEST_REQUIRE(__vcpu_has_isa_ext(vcpu, KVM_RISCV_ISA_EXT_SSCOFPMF),
+				   "Sscofpmf is not available, skipping overflow test");
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
+	run_vcpu(vcpu);
+
+	test_vm_destroy(vm);
+}
+
 int main(void)
 {
 	test_vm_basic_test(test_pmu_basic_sanity);
@@ -509,5 +619,8 @@ int main(void)
 	test_vm_events_snapshot_test(test_pmu_events_snaphost);
 	pr_info("SBI PMU event verification with snapshot test : PASS\n");
 
+	test_vm_events_overflow(test_pmu_events_overflow);
+	pr_info("SBI PMU event verification with overflow test : PASS\n");
+
 	return 0;
 }
-- 
2.34.1


