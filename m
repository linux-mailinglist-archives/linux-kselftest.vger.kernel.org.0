Return-Path: <linux-kselftest+bounces-5591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B961086BDFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 02:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72041C20A33
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 01:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E37C535B6;
	Thu, 29 Feb 2024 01:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FBk/vMsR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9EA54FA5
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 01:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168528; cv=none; b=YHYqRCOufEYhh/Fr9VaHGck92Ta2up0EMupJZfJH5+YBx7hRBVxfL2nPkklvmGU/5AEPrLfNeuYJBZjRk841DpM/5qWMmnZl6elbfcn/3b34CHJ2NAY48Ipb+h0T5/VNPtcS54y93S7K1CLA/DF9HGIE/k17U/UQ2YBhN00ixJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168528; c=relaxed/simple;
	bh=u8heZt94ZIjz45lTp7rnWJ+NQSJPonSYFhnPcX/4/CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FYoMhJypLjbDUv1xjn9G1UWldxyTfOtAXKR1Qio2N9eMEp4kdCQac/VHHuVhpeHOVrKBdhpiO+/bsmYFDzOi3YotfdHdaYmyTFAvTO5aNSl049KHA1NIAj1JUzT8HrUyAfW2M8xxuUl1b3r4tZwcRuQ5LWkBcMJ70UB91CVOn+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FBk/vMsR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dcafff3c50so3581855ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 17:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709168525; x=1709773325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qc8/YsnWZLtzQVcnf6euk9w8bwSYLeSpKUiQ52ang8=;
        b=FBk/vMsRjK8pxcNu+tQftoZtkwdgnZDPJiI13JS9xxhTBN/5GnNYSIw0TFLaXcOy6o
         IBvY5o2hPolJbFXAkIbTUhRonnKm+NvQzirljLmufW/awIitbGgNVc/vBnpgeEcopPeV
         3XaKrHLkiMqArEda9bcW6gjuKh9TsAAHeTTeEBZn0jCiTo18uHKsTqiqpRrkXhDpsjlD
         nzg1uUVJ+lj5Cld+ylqDC2R3Np0I3eSAFuFDkpOtz8ToFaVlX28v1nJihv94J6WPBpMs
         okeOJfMZ2V+v3fE0NuxV2ehzWR7BLuy+3OFHEA/5STPXsN7sm4pnJOhQwhxNRF1593C5
         45Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168525; x=1709773325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qc8/YsnWZLtzQVcnf6euk9w8bwSYLeSpKUiQ52ang8=;
        b=rFPnWpSbSFGKUkupxEdwoHAG+lbWfcsmLHKA/63wuDakGrBtj6K5jki3EFs2LgEAoD
         rUJMrg+7TN+zIFOVs2XDw0KHNP1k0DSvW9Va510dn4er4ShR99Rztk0/fzbudewh0uGW
         7bXSyvbFWm9gP9zr/rUaA/xgagsQHo0PQEmYMmTdsGB8C6eqIjibdJ8IyIXZ9enymPb4
         M71DJqdNB7mJQYi1AqxrOgw9o6jXlXBqXkSI9s09R2beEDQZaSTXb1eN3zzOQ+7gEV9K
         Ovk4Srofeb2UB3lmSyyTBXulxcq9wuybejCFq6ga0w49J09Lv0PD1C3iocH1akzHWxDO
         ClWw==
X-Forwarded-Encrypted: i=1; AJvYcCVdtxHLDNKaYMjQpymKTR1AoGmYV8XSWhbyPTWzErfGGpDBjevnXbsTM5MuovLInxQ5ile96qULiJZUZscyaKJypTlZK9tiP6ufYSg0O5Jk
X-Gm-Message-State: AOJu0Yx8mxWTK+N9fGkkUNkNmDl/KLvd0jpzSBBb+wFXB0zz5CwOC8+V
	JkyYmlMfpo5MH3eC40tHe9monoAZVezWQKBOuVcLymeJU4t2Wqpk1QXBahPwH2c=
X-Google-Smtp-Source: AGHT+IE+6zkbqEfxrFsGgHeVaj3fDKJqNlgYGDvcDCj1su/jbaCelp928OgUnJ+avO8FLYt/A5miDA==
X-Received: by 2002:a17:902:d2d1:b0:1db:f033:9f9b with SMTP id n17-20020a170902d2d100b001dbf0339f9bmr793352plc.9.1709168523952;
        Wed, 28 Feb 2024 17:02:03 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b001dc8d6a9d40sm78043plx.144.2024.02.28.17.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:02:03 -0800 (PST)
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
Subject: [PATCH v4 13/15] KVM: riscv: selftests: Add SBI PMU selftest
Date: Wed, 28 Feb 2024 17:01:28 -0800
Message-Id: <20240229010130.1380926-14-atishp@rivosinc.com>
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

This test implements basic sanity test and cycle/instret event
counting tests.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/Makefile        |   1 +
 tools/testing/selftests/kvm/riscv/sbi_pmu.c | 340 ++++++++++++++++++++
 2 files changed, 341 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/riscv/sbi_pmu.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 426f85798aea..b2dce6843b9e 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -195,6 +195,7 @@ TEST_GEN_PROGS_riscv += kvm_create_max_vcpus
 TEST_GEN_PROGS_riscv += kvm_page_table_test
 TEST_GEN_PROGS_riscv += set_memory_region_test
 TEST_GEN_PROGS_riscv += steal_time
+TEST_GEN_PROGS_riscv += riscv/sbi_pmu
 
 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu.c b/tools/testing/selftests/kvm/riscv/sbi_pmu.c
new file mode 100644
index 000000000000..fc1fc5eea99e
--- /dev/null
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * arch_timer.c - Tests the riscv64 sstc timer IRQ functionality
+ *
+ * The test validates the sstc timer IRQs using vstimecmp registers.
+ * It's ported from the aarch64 arch_timer test.
+ *
+ * Copyright (c) 2024, Rivos Inc.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include "kvm_util.h"
+#include "test_util.h"
+#include "processor.h"
+
+/* Maximum counters (firmware + hardware)*/
+#define RISCV_MAX_PMU_COUNTERS 64
+union sbi_pmu_ctr_info ctrinfo_arr[RISCV_MAX_PMU_COUNTERS];
+
+/* Cache the available counters in a bitmask */
+static unsigned long counter_mask_available;
+
+unsigned long pmu_csr_read_num(int csr_num)
+{
+#define switchcase_csr_read(__csr_num, __val)		{\
+	case __csr_num:					\
+		__val = csr_read(__csr_num);		\
+		break; }
+#define switchcase_csr_read_2(__csr_num, __val)		{\
+	switchcase_csr_read(__csr_num + 0, __val)	 \
+	switchcase_csr_read(__csr_num + 1, __val)}
+#define switchcase_csr_read_4(__csr_num, __val)		{\
+	switchcase_csr_read_2(__csr_num + 0, __val)	 \
+	switchcase_csr_read_2(__csr_num + 2, __val)}
+#define switchcase_csr_read_8(__csr_num, __val)		{\
+	switchcase_csr_read_4(__csr_num + 0, __val)	 \
+	switchcase_csr_read_4(__csr_num + 4, __val)}
+#define switchcase_csr_read_16(__csr_num, __val)	{\
+	switchcase_csr_read_8(__csr_num + 0, __val)	 \
+	switchcase_csr_read_8(__csr_num + 8, __val)}
+#define switchcase_csr_read_32(__csr_num, __val)	{\
+	switchcase_csr_read_16(__csr_num + 0, __val)	 \
+	switchcase_csr_read_16(__csr_num + 16, __val)}
+
+	unsigned long ret = 0;
+
+	switch (csr_num) {
+	switchcase_csr_read_32(CSR_CYCLE, ret)
+	switchcase_csr_read_32(CSR_CYCLEH, ret)
+	default :
+		break;
+	}
+
+	return ret;
+#undef switchcase_csr_read_32
+#undef switchcase_csr_read_16
+#undef switchcase_csr_read_8
+#undef switchcase_csr_read_4
+#undef switchcase_csr_read_2
+#undef switchcase_csr_read
+}
+
+static inline void dummy_func_loop(int iter)
+{
+	int i = 0;
+
+	while (i < iter) {
+		asm volatile("nop");
+		i++;
+	}
+}
+
+static void guest_illegal_exception_handler(struct ex_regs *regs)
+{
+	__GUEST_ASSERT(regs->cause == EXC_INST_ILLEGAL,
+		       "Unexpected exception handler %lx\n", regs->cause);
+
+	/* skip the trapping instruction */
+	regs->epc += 4;
+}
+
+static unsigned long get_counter_index(unsigned long cbase, unsigned long cmask,
+				       unsigned long cflags,
+				       unsigned long event)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase, cmask,
+			cflags, event, 0, 0);
+	__GUEST_ASSERT(ret.error == 0, "config matching failed %ld\n", ret.error);
+	GUEST_ASSERT((ret.value < RISCV_MAX_PMU_COUNTERS) &&
+		    ((1UL << ret.value) & counter_mask_available));
+
+	return ret.value;
+}
+
+static unsigned long get_num_counters(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_NUM_COUNTERS, 0, 0, 0, 0, 0, 0);
+
+	__GUEST_ASSERT(ret.error == 0, "Unable to retrieve number of counters from SBI PMU");
+
+	__GUEST_ASSERT(ret.value < RISCV_MAX_PMU_COUNTERS,
+		       "Invalid number of counters %ld\n", ret.value);
+
+	return ret.value;
+}
+
+static void update_counter_info(int num_counters)
+{
+	int i = 0;
+	struct sbiret ret;
+
+	for (i = 0; i < num_counters; i++) {
+		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i, 0, 0, 0, 0, 0);
+
+		/* There can be gaps in logical counter indicies*/
+		if (!ret.error)
+			GUEST_ASSERT_NE(ret.value, 0);
+
+		ctrinfo_arr[i].value = ret.value;
+		counter_mask_available |= BIT(i);
+	}
+
+	GUEST_ASSERT(counter_mask_available > 0);
+}
+
+static unsigned long read_counter(int idx, union sbi_pmu_ctr_info ctrinfo)
+{
+	unsigned long counter_val = 0;
+	struct sbiret ret;
+
+	__GUEST_ASSERT(ctrinfo.type < 2, "Invalid counter type %d", ctrinfo.type);
+
+	if (ctrinfo.type == SBI_PMU_CTR_TYPE_HW) {
+		counter_val = pmu_csr_read_num(ctrinfo.csr);
+	} else if (ctrinfo.type == SBI_PMU_CTR_TYPE_FW) {
+		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ, idx, 0, 0, 0, 0, 0);
+		GUEST_ASSERT(ret.error == 0);
+		counter_val = ret.value;
+	}
+
+	return counter_val;
+}
+
+static void start_counter(unsigned long counter, unsigned long start_flags,
+			  unsigned long ival)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, counter, 1, start_flags,
+			ival, 0, 0);
+	__GUEST_ASSERT(ret.error == 0, "Unable to start counter %ld\n", counter);
+}
+
+static void stop_counter(unsigned long counter, unsigned long stop_flags)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, counter, 1, stop_flags,
+			0, 0, 0);
+	if (stop_flags & SBI_PMU_STOP_FLAG_RESET)
+		__GUEST_ASSERT(ret.error == SBI_ERR_ALREADY_STOPPED,
+			       "Unable to stop counter %ld\n", counter);
+	else
+		__GUEST_ASSERT(ret.error == 0, "Unable to stop counter %ld error %ld\n",
+			       counter, ret.error);
+}
+
+static void test_pmu_event(unsigned long event)
+{
+	unsigned long counter;
+	unsigned long counter_value_pre, counter_value_post;
+	unsigned long counter_init_value = 100;
+
+	counter = get_counter_index(0, counter_mask_available, 0, event);
+	counter_value_pre = read_counter(counter, ctrinfo_arr[counter]);
+
+	/* Do not set the initial value */
+	start_counter(counter, 0, counter_init_value);
+	dummy_func_loop(10000);
+
+	stop_counter(counter, 0);
+
+	counter_value_post = read_counter(counter, ctrinfo_arr[counter]);
+	__GUEST_ASSERT(counter_value_post > counter_value_pre,
+		       "counter_value_post %lx counter_value_pre %lx\n",
+		       counter_value_post, counter_value_pre);
+
+	/* Now set the initial value and compare */
+	start_counter(counter, SBI_PMU_START_FLAG_SET_INIT_VALUE, counter_init_value);
+	dummy_func_loop(10000);
+
+	stop_counter(counter, 0);
+
+	counter_value_post = read_counter(counter, ctrinfo_arr[counter]);
+	__GUEST_ASSERT(counter_value_post > counter_init_value,
+		       "counter_value_post %lx counter_init_value %lx\n",
+		       counter_value_post, counter_init_value);
+
+	stop_counter(counter, SBI_PMU_STOP_FLAG_RESET);
+}
+
+static void test_invalid_event(void)
+{
+	struct sbiret ret;
+	unsigned long event = 0x1234; /* A random event */
+
+	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, 0,
+			counter_mask_available, 0, event, 0, 0);
+	GUEST_ASSERT_EQ(ret.error, SBI_ERR_NOT_SUPPORTED);
+}
+
+static void test_pmu_events(int cpu)
+{
+	int num_counters = 0;
+
+	/* Get the counter details */
+	num_counters = get_num_counters();
+	update_counter_info(num_counters);
+
+	/* Sanity testing for any random invalid event */
+	test_invalid_event();
+
+	/* Only these two events are guranteed to be present */
+	test_pmu_event(SBI_PMU_HW_CPU_CYCLES);
+	test_pmu_event(SBI_PMU_HW_INSTRUCTIONS);
+
+	GUEST_DONE();
+}
+
+static void test_pmu_basic_sanity(int cpu)
+{
+	long out_val = 0;
+	bool probe;
+	struct sbiret ret;
+	int num_counters = 0, i;
+	unsigned long counter_val = -1;
+	union sbi_pmu_ctr_info ctrinfo;
+
+	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
+	GUEST_ASSERT(probe && out_val == 1);
+
+	num_counters = get_num_counters();
+
+	for (i = 0; i < num_counters; i++) {
+		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i,
+				0, 0, 0, 0, 0);
+
+		/* There can be gaps in logical counter indicies*/
+		if (!ret.error)
+			GUEST_ASSERT_NE(ret.value, 0);
+		else
+			continue;
+
+		ctrinfo.value = ret.value;
+
+		/* Accesibility check of hardware and read capability of firmware counters */
+		counter_val = read_counter(i, ctrinfo);
+		/* The spec doesn't mandate any initial value. Verify if a sane value */
+		GUEST_ASSERT_NE(counter_val, -1);
+	}
+
+	GUEST_DONE();
+}
+
+static void run_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	case UCALL_DONE:
+	case UCALL_SYNC:
+		break;
+	default:
+		TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		break;
+	}
+}
+
+void test_vm_destroy(struct kvm_vm *vm)
+{
+	memset(ctrinfo_arr, 0, sizeof(union sbi_pmu_ctr_info) * RISCV_MAX_PMU_COUNTERS);
+	counter_mask_available = 0;
+	kvm_vm_free(vm);
+}
+
+static void test_vm_basic_test(void *guest_code)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	__TEST_REQUIRE(__vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV_SBI_EXT_PMU)),
+				   "SBI PMU not available, skipping test");
+	vm_init_vector_tables(vm);
+	/* Illegal instruction handler is required to verify read access without configuration */
+	vm_install_exception_handler(vm, EXC_INST_ILLEGAL, guest_illegal_exception_handler);
+
+	vcpu_init_vector_tables(vcpu);
+	vcpu_args_set(vcpu, 1, 0);
+	run_vcpu(vcpu);
+
+	test_vm_destroy(vm);
+}
+
+static void test_vm_events_test(void *guest_code)
+{
+	struct kvm_vm *vm = NULL;
+	struct kvm_vcpu *vcpu = NULL;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	__TEST_REQUIRE(__vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV_SBI_EXT_PMU)),
+				   "SBI PMU not available, skipping test");
+	vcpu_args_set(vcpu, 1, 0);
+	run_vcpu(vcpu);
+
+	test_vm_destroy(vm);
+}
+
+int main(void)
+{
+	test_vm_basic_test(test_pmu_basic_sanity);
+	pr_info("SBI PMU basic test : PASS\n");
+
+	test_vm_events_test(test_pmu_events);
+	pr_info("SBI PMU event verification test : PASS\n");
+
+	return 0;
+}
-- 
2.34.1


