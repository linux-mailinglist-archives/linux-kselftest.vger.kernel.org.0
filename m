Return-Path: <linux-kselftest+bounces-7643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF20F8A04B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 02:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393C31F24B5C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 00:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA4C46521;
	Thu, 11 Apr 2024 00:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="H5TXU7p1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA55146436
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794152; cv=none; b=D6PPMPoMwsl5dqNgwKdZnBdg/lRlb+ViiVwuR8vkHPzQ7IVWRczL4YgGWCiuGpjNw+vOTig/AaYfTcgT4ycH9StRraV1FstkobbbgZD8RLvrB2g5IErWCGcbguBivGnpCo28cgwDZ3eIKb2rTH/r4aWvUOZyMyg9QBmYDdlWjJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794152; c=relaxed/simple;
	bh=DVVKHwdcHrCghLd6183X+gLlpU8rpkQ6oT0PWsvM5Es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r7PEiw1ygs3AUE8lxRD9yRityt1VKojpL/duN042PF+/mOiRIDn7Bx0wGe9kDaFh86p7m0gfLXrRee7PUFYDnZCHY775dptG4n+LTvmC4jDh4qC8HtHaPLGkeUgDjDXxLXkbznFzN5ZOUbHh0tEv+wjaLxgqVVCZRzf57ZPTcrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=H5TXU7p1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e455b630acso19150505ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 17:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794150; x=1713398950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZBNm8t7pxnzWGv6YWxjC/xF/4KZ8ewn0ohXTfxHTTg=;
        b=H5TXU7p1lFpPU8o7tXr9wlittRbWcYCIp1JH60MCGIxtIhl/D/tGT48yYyRB9JHH7M
         LV1CpLhuZ4U9YtglRkLSrEdnLWSdkatI/nwcUisqZEVhtqzmT63G8DA7ZOOj539mwQkT
         e1Xvgv+iGOUi23frrjIOlrDuEjUaqqeI2iiAnPB8MLKRGz9gqlOc4cepISx57YnwTGX/
         V7a6pLLhDK3K4kLk0XwAbF4goHYTtcWgsAxBo8wx1MoaXjxm64+lTodCUz78GJZrFxTO
         sTHb/svVbA5ORrqaZcqZzC2B74aLXQpnKO7af851q+fxvz9ADs/r+gnrkENnn0IpGBpb
         JNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794150; x=1713398950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZBNm8t7pxnzWGv6YWxjC/xF/4KZ8ewn0ohXTfxHTTg=;
        b=NZjYs3dovtJ4Rq0swcKj39AhKsqd+vuvs9VVHP3y/bIaDknX40zxo+99IU9VkqILmq
         b/ypPFXjbAzUgetV860z1F97J/6UKk8Qjm/PDjvOpGxMGFCy7Wn9xYK4aNJvB1AITk1v
         MDawZbU3Zf2p6q8rZNpYZfRpfixInWLKXLX9Nh7RCgxaWSk9NHSPC2GgNFdwJQUUvmDi
         hxhZBLce9rZdrZadA0GdtPQM42cA6NZxup3oTuV4sgmA5lF1FUaGgSCS1wQV5BlZQfFF
         bJhTwVSctfwW8zAM5gNhNHRYm1N5Z9FodtT8KJ7/Ups3qkG2olM6t9ZJQtWnCCN8zTsA
         0/bA==
X-Forwarded-Encrypted: i=1; AJvYcCUX+fKrPnu6kquyv0n9AfH+XUugkEHzXLWqpaiTaLaa53A2qON5yE5YjfziWc/pBawD9wcuKTvgEhUC9uodB7Yi1zJklgn3CUi8zO9KhVas
X-Gm-Message-State: AOJu0YyZPh7AIV5NyN0OwnhxrojYT2g33riKh/IL8aAp2QnzWlEypCbC
	D1xFL67ZZeUDUQTzSEj7YtASew6Ax/dwk4Ad8GmfTdbgeOotFKAI/3ktaRzWr1vmclCKcpPteMa
	i
X-Google-Smtp-Source: AGHT+IGF+0pc7WIdJ5uqgHNYU7xfAN9s2k4bHPqxknQRhvJLHc0wEUe2nz8i7tfEh3o8jXT2hJLsbg==
X-Received: by 2002:a17:903:41cf:b0:1e2:b13f:bd67 with SMTP id u15-20020a17090341cf00b001e2b13fbd67mr5263304ple.14.1712794149915;
        Wed, 10 Apr 2024 17:09:09 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:09:08 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH v6 23/24] KVM: riscv: selftests: Add a test for counter overflow
Date: Wed, 10 Apr 2024 17:07:51 -0700
Message-Id: <20240411000752.955910-24-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
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


