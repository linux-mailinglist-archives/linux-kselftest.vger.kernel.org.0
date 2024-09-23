Return-Path: <linux-kselftest+bounces-18218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6363997ECED
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8646B1C211A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A511946AA;
	Mon, 23 Sep 2024 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SSEG0YbM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5B82AD25;
	Mon, 23 Sep 2024 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101106; cv=none; b=C1erhxA3Gf57xF8NhDpm3H5RDcyg1SUdxHFje9AH8PlQXsNEx4rZZhbz+juvZvlV8X+Hba+eEOK13A7hHtB+OcDzRU9ViDEpMZDVy9MmkbE/YElPWB/CbIGpA7rjpJrObH/vkfk6Zxm+HAVGwrsleptss4PeIXCY1hEbpGAOvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101106; c=relaxed/simple;
	bh=Q0+zGVorf/SYsEEVITpX9CbnXwZ3TbJnOh0nFiHhWbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMAsH/vx862sysd6S0MIZXg/RDNAtvP4ETPIT3KZPmTYGYbEO4hcNQWAbV8u6Y8IBw2VxXDynzxEQgPv97eWzSKsgqfL/Or+RIXH+79RDk3n1oEou/FJr+gQK9aSm6upZVhxnMabkiKZdFfR1avDiXRc/5wdxlxqB4WT87AHeIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SSEG0YbM; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727101105; x=1758637105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9TOd+JE+xnybFGFEgMSEmA3pS8vQOq0t0XBQSs/NfVc=;
  b=SSEG0YbMTu56Nfb6aZgjRHGaZ/T2z2oZzOmmQ8ACIRvQ2pNYVEri45BK
   9VA5yNjlxPkhc1Db+G5FxTeOYa65ofeV/1LoNHI2OUAamm3sHmFHWSWAB
   WKOysJJOo9kBjcLrZ0SWV3BDZ264xcupkq6CX42gzaw63xqkxL0DdyEoY
   g=;
X-IronPort-AV: E=Sophos;i="6.10,251,1719878400"; 
   d="scan'208";a="27657133"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 14:18:22 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:20965]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.16.194:2525] with esmtp (Farcaster)
 id ced0b64f-5efc-4ec1-8f59-47278231eddd; Mon, 23 Sep 2024 14:18:21 +0000 (UTC)
X-Farcaster-Flow-ID: ced0b64f-5efc-4ec1-8f59-47278231eddd
Received: from EX19D031EUC001.ant.amazon.com (10.252.61.162) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 23 Sep 2024 14:18:20 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D031EUC001.ant.amazon.com (10.252.61.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 23 Sep 2024 14:18:20 +0000
Received: from email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 23 Sep 2024 14:18:20 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com (Postfix) with ESMTPS id 0D8D440596;
	Mon, 23 Sep 2024 14:18:18 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <hpa@zytor.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<mingo@redhat.com>, <pbonzini@redhat.com>, <seanjc@google.com>,
	<shuah@kernel.org>, <tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <jalliste@amazon.com>,
	<nh-open-source@amazon.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>
Subject: [PATCH 4/4] selftests: KVM: Add new test for faulty mmio usage
Date: Mon, 23 Sep 2024 14:18:10 +0000
Message-ID: <20240923141810.76331-5-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240923141810.76331-1-iorlov@amazon.com>
References: <20240923141810.76331-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Implement the test which covers "weird" mmio usage. The test has 4 test
cases:

1) Guest sets IDT/GDT base to point to an MMIO region. Triple fault and
shutdown are expected there.
2) Guest jumps to MMIO address. Fetches from MMIO are not permitted, so
UD is expected there.
3) Guest sets an IDT entry to point to MMIO range. MMIO here happens
after event delivery, so UD is expected.
4) Guest points the UD IDT entry to MMIO range and causes UD after that.
We should not go into infinite loop here, as we are constantly putting
exception info onto the stack and it will eventually overflow.

These test cases depend on previous patches in this patch series.

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/faulty_mmio.c        | 199 ++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/faulty_mmio.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 0c4b254ab56b..d9928c54e851 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -129,6 +129,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/amx_test
 TEST_GEN_PROGS_x86_64 += x86_64/max_vcpuid_cap_test
 TEST_GEN_PROGS_x86_64 += x86_64/triple_fault_event_test
 TEST_GEN_PROGS_x86_64 += x86_64/recalc_apic_map_test
+TEST_GEN_PROGS_x86_64 += x86_64/faulty_mmio
 TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
diff --git a/tools/testing/selftests/kvm/x86_64/faulty_mmio.c b/tools/testing/selftests/kvm/x86_64/faulty_mmio.c
new file mode 100644
index 000000000000..b83c1d646696
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/faulty_mmio.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This test covers error processing when doing weird things with MMIO addresses,
+ * i.e. jumping into MMIO range or specifying it as IDT / GDT descriptor base.
+ */
+#include <stdio.h>
+#include "kvm_util.h"
+#include "processor.h"
+#include <stdint.h>
+
+#define MMIO_ADDR 0xDEADBEE000UL
+/* This address is not canonical, so any reference will result in #GP */
+#define GP_ADDR 0xDEADBEEFDEADBEEFULL
+
+enum test_desc_type {
+	TEST_DESC_IDT,
+	TEST_DESC_GDT,
+};
+
+static const struct desc_ptr faulty_desc = {
+	.address = MMIO_ADDR,
+	.size = 0xFFF,
+};
+
+static void faulty_desc_guest_code(enum test_desc_type dtype)
+{
+	if (dtype == TEST_DESC_IDT)
+		__asm__ __volatile__("lidt %0"::"m"(faulty_desc));
+	else
+		__asm__ __volatile__("lgdt %0"::"m"(faulty_desc));
+
+	/* Generate a #GP */
+	*((uint8_t *)GP_ADDR) = 0x1;
+
+	/* We should never reach this point */
+	GUEST_ASSERT(0);
+}
+
+/*
+ * This test tries to point the IDT / GDT descriptor to an MMIO range.
+ * This action should cause a triple fault in guest, as it happens when
+ * your descriptors are messed up on the actual hardware.
+ */
+static void test_faulty_desc(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	enum test_desc_type dtype_tests[] = { TEST_DESC_IDT, TEST_DESC_GDT };
+
+	for (i = 0; i < ARRAY_SIZE(dtype_tests); i++) {
+		vm = vm_create_with_one_vcpu(&vcpu, faulty_desc_guest_code);
+		vcpu_args_set(vcpu, 1, dtype_tests[i]);
+		virt_map(vm, MMIO_ADDR, MMIO_ADDR, 1);
+
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_SHUTDOWN);
+		kvm_vm_free(vm);
+	}
+}
+
+static void jump_to_mmio_guest_code(bool write_first)
+{
+	void (*f)(void) = (void *)(MMIO_ADDR);
+
+	if (write_first) {
+		/*
+		 * We get different vmexit codes when accessing the MMIO address for the second
+		 * time with VMX. For the first time it is an EPT violation, for the second -
+		 * EPT misconfig. We need to check that we get #UD in both cases.
+		 */
+		*((char *)MMIO_ADDR) = 0x1;
+	}
+
+	f();
+
+	/* We should never reach this point */
+	GUEST_ASSERT(0);
+}
+
+static void guest_ud_handler(struct ex_regs *regs)
+{
+	GUEST_DONE();
+}
+
+/*
+ * This test tries to jump to an MMIO address. As fetching the instructions
+ * from MMIO is not supported by KVM and doesn't make any practical sense,
+ * KVM should handle it gracefully and inject #UD into guest.
+ */
+static void test_jump_to_mmio(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct kvm_run *run;
+	struct ucall uc;
+	int i;
+
+	bool test_cases_write_first[] = { false, true };
+
+	for (i = 0; i < ARRAY_SIZE(test_cases_write_first); i++) {
+		vm = vm_create_with_one_vcpu(&vcpu, jump_to_mmio_guest_code);
+		virt_map(vm, MMIO_ADDR, MMIO_ADDR, 1);
+		vcpu_args_set(vcpu, 1, test_cases_write_first[i]);
+		vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
+
+		run = vcpu->run;
+
+		vcpu_run(vcpu);
+		if (test_cases_write_first[i] && run->exit_reason == KVM_EXIT_MMIO) {
+			/* Process first MMIO access if required */
+			vcpu_run(vcpu);
+		}
+
+		/* If #UD was injected correctly, our #UD handler will issue UCALL_DONE */
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, UCALL_EXIT_REASON);
+		TEST_ASSERT(get_ucall(vcpu, &uc) == UCALL_DONE,
+			    "Guest should have gone into #UD handler when jumping to MMIO address, however it didn't happen");
+		kvm_vm_free(vm);
+	}
+}
+
+static void faulty_idte_guest_code(void)
+{
+	/*
+	 * We are triggering #GP here, and as it's IDT entry points to an MMIO range,
+	 * we should get an #UD as instruction fetching from MMIO address is prohibited
+	 */
+	*((uint8_t *)GP_ADDR) = 0x1;
+
+	/* We should never reach this point */
+	GUEST_ASSERT(0);
+}
+
+/*
+ * When IDT entry points to an MMIO address, it should be handled as a jump to MMIO address
+ * and should cause #UD in the guest, as fetches from MMIO are not supported. It should not
+ * cause a triple fault in such a case, so we don't expect KVM_EXIT_SHUTDOWN here.
+ */
+static void test_faulty_idte(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct ucall uc;
+
+	vm = vm_create_with_one_vcpu(&vcpu, faulty_idte_guest_code);
+	virt_map(vm, MMIO_ADDR, MMIO_ADDR, 1);
+
+	/* GP vector points to MMIO range, jumping to it will trigger an #UD */
+	vm_install_exception_handler(vm, GP_VECTOR, (void *)MMIO_ADDR);
+	vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
+
+	vcpu_run(vcpu);
+	/* If we reach #UD handler it will issue UCALL_DONE */
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, UCALL_EXIT_REASON);
+	TEST_ASSERT(get_ucall(vcpu, &uc) == UCALL_DONE,
+		    "Guest should have gone into #UD handler when jumping to MMIO address, however it didn't happen");
+	kvm_vm_free(vm);
+}
+
+static void faulty_ud_idte_guest_code(void)
+{
+	asm("ud2");
+
+	/* We should never reach this point */
+	GUEST_ASSERT(0);
+}
+
+/*
+ * This test checks that we won't hang in the infinite loop if the #UD handler
+ * also causes #UD (as it points to an MMIO address). In this situation, we will
+ * run out of stack eventually, which will cause a triple fault
+ */
+static void test_faulty_ud_handler(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm = vm_create_with_one_vcpu(&vcpu, faulty_ud_idte_guest_code);
+	virt_map(vm, MMIO_ADDR, MMIO_ADDR, 1);
+
+	vm_install_exception_handler(vm, UD_VECTOR, (void *)MMIO_ADDR);
+
+	vcpu_run(vcpu);
+	/* #UD caused when jumping to #UD handler should overflow stack causing a triple fault */
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_SHUTDOWN);
+	kvm_vm_free(vm);
+}
+
+int main(void)
+{
+	test_faulty_desc();
+	test_jump_to_mmio();
+	test_faulty_idte();
+	test_faulty_ud_handler();
+
+	return EXIT_SUCCESS;
+}
-- 
2.43.0


