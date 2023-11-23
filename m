Return-Path: <linux-kselftest+bounces-470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ACA7F5865
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 07:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894E8281826
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 06:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9337811CAD;
	Thu, 23 Nov 2023 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXEnUDdS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D771A5
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 22:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700721494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUEQD5MfVaqhpzv7dhMTbTAwn2srimSeAW0TyOyP80I=;
	b=GXEnUDdSlbI1mlKKQom5IB43FhzRfawoU5JLcFdDrtR7UoG2r827uoZAnweBj/j4vmAtMB
	HkWGmtg/No+pPrNgd7HAYQblvSX4Kpu7Bpo1MgjxKH93+Hv07b709fjbwF6/643Y277Rnu
	SNm6fB6FJb87pgNp1SAMbf9AvZRjdz4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-jWCAy0frMkSZiAgPkCwIKg-1; Thu, 23 Nov 2023 01:38:11 -0500
X-MC-Unique: jWCAy0frMkSZiAgPkCwIKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2D0D101D25D;
	Thu, 23 Nov 2023 06:38:10 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D5E461C060AE;
	Thu, 23 Nov 2023 06:38:10 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Shaoqin Huang <shahuang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 3/3] KVM: selftests: aarch64: Introduce pmu_event_filter_test
Date: Thu, 23 Nov 2023 01:37:45 -0500
Message-Id: <20231123063750.2176250-4-shahuang@redhat.com>
In-Reply-To: <20231123063750.2176250-1-shahuang@redhat.com>
References: <20231123063750.2176250-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Introduce pmu_event_filter_test for arm64 platforms. The test configures
PMUv3 for a vCPU, and sets different pmu event filter for the vCPU, and
check if the guest can use those events which user allow and can't use
those events which use deny.

This test refactor the create_vpmu_vm() and make it a wrapper for
__create_vpmu_vm(), which can let we do some extra init before
KVM_ARM_VCPU_PMU_V3_INIT.

This test choose the branches_retired and the instructions_retired
event, and let guest use the two events in pmu. And check if the result
is expected.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/aarch64/pmu_event_filter_test.c       | 227 ++++++++++++++++++
 .../selftests/kvm/include/aarch64/vpmu.h      |   4 +
 .../testing/selftests/kvm/lib/aarch64/vpmu.c  |  14 +-
 4 files changed, 244 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index b60852c222ac..5f126e1a1dbf 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -155,6 +155,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
 TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
 TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
 TEST_GEN_PROGS_aarch64 += aarch64/page_fault_test
+TEST_GEN_PROGS_aarch64 += aarch64/pmu_event_filter_test
 TEST_GEN_PROGS_aarch64 += aarch64/psci_test
 TEST_GEN_PROGS_aarch64 += aarch64/set_id_regs
 TEST_GEN_PROGS_aarch64 += aarch64/smccc_filter
diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
new file mode 100644
index 000000000000..a876f5c2033b
--- /dev/null
+++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pmu_event_filter_test - Test user limit pmu event for guest.
+ *
+ * Copyright (c) 2023 Red Hat, Inc.
+ *
+ * This test checks if the guest only see the limited pmu event that userspace
+ * sets, if the gust can use those events which user allow, and if the guest
+ * can't use those events which user deny.
+ * It also checks set invalid filter return the expected error.
+ * This test runs only when KVM_CAP_ARM_PMU_V3 is supported on the host.
+ */
+#include <kvm_util.h>
+#include <processor.h>
+#include <vgic.h>
+#include <vpmu.h>
+#include <test_util.h>
+#include <perf/arm_pmuv3.h>
+
+struct {
+	uint64_t branches_retired;
+	uint64_t instructions_retired;
+} pmc_results;
+
+static struct vpmu_vm *vpmu_vm;
+
+#define FILTER_NR 10
+
+struct test_desc {
+	const char *name;
+	void (*check_result)(void);
+	struct kvm_pmu_event_filter filter[FILTER_NR];
+};
+
+#define __DEFINE_FILTER(base, num, act)		\
+	((struct kvm_pmu_event_filter) {	\
+		.base_event	= base,		\
+		.nevents	= num,		\
+		.action		= act,		\
+	})
+
+#define DEFINE_FILTER(base, act) __DEFINE_FILTER(base, 1, act)
+
+#define EMPTY_FILTER	{ 0 }
+
+#define SW_INCR		0x0
+#define INST_RETIRED	0x8
+#define BR_RETIERD	0x21
+
+#define NUM_BRANCHES	10
+
+static void run_and_measure_loop(void)
+{
+	asm volatile(
+		"	mov	x10, %[loop]\n"
+		"1:	sub	x10, x10, #1\n"
+		"	cmp	x10, #0x0\n"
+		"	b.gt	1b\n"
+		:
+		: [loop] "r" (NUM_BRANCHES)
+		: "x10", "cc");
+}
+
+static void guest_code(void)
+{
+	uint64_t pmcr = read_sysreg(pmcr_el0);
+
+	pmu_disable_reset();
+
+	write_pmevtypern(0, BR_RETIERD);
+	write_pmevtypern(1, INST_RETIRED);
+	enable_counter(0);
+	enable_counter(1);
+	write_sysreg(pmcr | ARMV8_PMU_PMCR_E, pmcr_el0);
+
+	run_and_measure_loop();
+
+	write_sysreg(pmcr, pmcr_el0);
+
+	pmc_results.branches_retired = read_sysreg(pmevcntr0_el0);
+	pmc_results.instructions_retired = read_sysreg(pmevcntr1_el0);
+
+	GUEST_DONE();
+}
+
+static void pmu_event_filter_init(struct vpmu_vm *vm, void *arg)
+{
+	struct kvm_device_attr attr = {
+		.group	= KVM_ARM_VCPU_PMU_V3_CTRL,
+		.attr	= KVM_ARM_VCPU_PMU_V3_FILTER,
+	};
+	struct kvm_pmu_event_filter *filter = (struct kvm_pmu_event_filter *)arg;
+
+	while (filter && filter->nevents != 0) {
+		attr.addr = (uint64_t)filter;
+		vcpu_ioctl(vm->vcpu, KVM_SET_DEVICE_ATTR, &attr);
+		filter++;
+	}
+}
+
+static void create_vpmu_vm_with_filter(void *guest_code,
+				       struct kvm_pmu_event_filter *filter)
+{
+	vpmu_vm = __create_vpmu_vm(guest_code, pmu_event_filter_init, filter);
+}
+
+static void run_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	while (1) {
+		vcpu_run(vcpu);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_DONE:
+			return;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+}
+
+static void check_pmc_counting(void)
+{
+	uint64_t br = pmc_results.branches_retired;
+	uint64_t ir = pmc_results.instructions_retired;
+
+	TEST_ASSERT(br && br == NUM_BRANCHES, "Branch instructions retired = "
+		    "%lu (expected %u)", br, NUM_BRANCHES);
+	TEST_ASSERT(ir, "Instructions retired = %lu (expected > 0)", ir);
+}
+
+static void check_pmc_not_counting(void)
+{
+	uint64_t br = pmc_results.branches_retired;
+	uint64_t ir = pmc_results.instructions_retired;
+
+	TEST_ASSERT(!br, "Branch instructions retired = %lu (expected 0)", br);
+	TEST_ASSERT(!ir, "Instructions retired = %lu (expected 0)", ir);
+}
+
+static void run_vcpu_and_sync_pmc_results(void)
+{
+	memset(&pmc_results, 0, sizeof(pmc_results));
+	sync_global_to_guest(vpmu_vm->vm, pmc_results);
+
+	run_vcpu(vpmu_vm->vcpu);
+
+	sync_global_from_guest(vpmu_vm->vm, pmc_results);
+}
+
+static void run_test(struct test_desc *t)
+{
+	pr_debug("Test: %s\n", t->name);
+
+	create_vpmu_vm_with_filter(guest_code, t->filter);
+
+	run_vcpu_and_sync_pmc_results();
+
+	t->check_result();
+
+	destroy_vpmu_vm(vpmu_vm);
+}
+
+static struct test_desc tests[] = {
+	{"without_filter", check_pmc_counting, { EMPTY_FILTER }},
+	{"member_allow_filter", check_pmc_counting,
+	 {DEFINE_FILTER(SW_INCR, 0), DEFINE_FILTER(INST_RETIRED, 0),
+	  DEFINE_FILTER(BR_RETIERD, 0), EMPTY_FILTER}},
+	{"member_deny_filter", check_pmc_not_counting,
+	 {DEFINE_FILTER(SW_INCR, 1), DEFINE_FILTER(INST_RETIRED, 1),
+	  DEFINE_FILTER(BR_RETIERD, 1), EMPTY_FILTER}},
+	{"not_member_deny_filter", check_pmc_counting,
+	 {DEFINE_FILTER(SW_INCR, 1), EMPTY_FILTER}},
+	{"not_member_allow_filter", check_pmc_not_counting,
+	 {DEFINE_FILTER(SW_INCR, 0), EMPTY_FILTER}},
+	{ 0 }
+};
+
+static void for_each_test(void)
+{
+	struct test_desc *t;
+
+	for (t = &tests[0]; t->name; t++)
+		run_test(t);
+}
+
+static void set_invalid_filter(struct vpmu_vm *vm, void *arg)
+{
+	struct kvm_pmu_event_filter invalid;
+	struct kvm_device_attr attr = {
+		.group	= KVM_ARM_VCPU_PMU_V3_CTRL,
+		.attr	= KVM_ARM_VCPU_PMU_V3_FILTER,
+		.addr	= (uint64_t)&invalid,
+	};
+	int ret = 0;
+
+	/* The max event number is (1 << 16), set a range large than it. */
+	invalid = __DEFINE_FILTER(BIT(15), BIT(15)+1, 0);
+	ret = __vcpu_ioctl(vm->vcpu, KVM_SET_DEVICE_ATTR, &attr);
+	TEST_ASSERT(ret && errno == EINVAL, "Set Invalid filter range "
+		    "ret = %d, errno = %d (expected ret = -1, errno = EINVAL)",
+		    ret, errno);
+
+	ret = 0;
+
+	/* Set the Invalid action. */
+	invalid = __DEFINE_FILTER(0, 1, 3);
+	ret = __vcpu_ioctl(vm->vcpu, KVM_SET_DEVICE_ATTR, &attr);
+	TEST_ASSERT(ret && errno == EINVAL, "Set Invalid filter action "
+		    "ret = %d, errno = %d (expected ret = -1, errno = EINVAL)",
+		    ret, errno);
+}
+
+static void test_invalid_filter(void)
+{
+	vpmu_vm = __create_vpmu_vm(guest_code, set_invalid_filter, NULL);
+	destroy_vpmu_vm(vpmu_vm);
+}
+
+int main(void)
+{
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_PMU_V3));
+
+	for_each_test();
+
+	test_invalid_filter();
+}
diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
index e0cc1ca1c4b7..db97bfb07996 100644
--- a/tools/testing/selftests/kvm/include/aarch64/vpmu.h
+++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
@@ -18,6 +18,10 @@ struct vpmu_vm {
 	int gic_fd;
 };
 
+struct vpmu_vm *__create_vpmu_vm(void *guest_code,
+				 void (*init_pmu)(struct vpmu_vm *vm, void *arg),
+				 void *arg);
+
 struct vpmu_vm *create_vpmu_vm(void *guest_code);
 
 void destroy_vpmu_vm(struct vpmu_vm *vpmu_vm);
diff --git a/tools/testing/selftests/kvm/lib/aarch64/vpmu.c b/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
index b3de8fdc555e..76ea03d607f1 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
@@ -7,8 +7,9 @@
 #include <vpmu.h>
 #include <perf/arm_pmuv3.h>
 
-/* Create a VM that has one vCPU with PMUv3 configured. */
-struct vpmu_vm *create_vpmu_vm(void *guest_code)
+struct vpmu_vm *__create_vpmu_vm(void *guest_code,
+				 void (*init_pmu)(struct vpmu_vm *vm, void *arg),
+				 void *arg)
 {
 	struct kvm_vcpu_init init;
 	uint8_t pmuver;
@@ -50,12 +51,21 @@ struct vpmu_vm *create_vpmu_vm(void *guest_code)
 		    "Unexpected PMUVER (0x%x) on the vCPU with PMUv3", pmuver);
 
 	/* Initialize vPMU */
+	if (init_pmu)
+		init_pmu(vpmu_vm, arg);
+
 	vcpu_ioctl(vpmu_vm->vcpu, KVM_SET_DEVICE_ATTR, &irq_attr);
 	vcpu_ioctl(vpmu_vm->vcpu, KVM_SET_DEVICE_ATTR, &init_attr);
 
 	return vpmu_vm;
 }
 
+/* Create a VM that has one vCPU with PMUv3 configured. */
+struct vpmu_vm *create_vpmu_vm(void *guest_code)
+{
+	return __create_vpmu_vm(guest_code, NULL, NULL);
+}
+
 void destroy_vpmu_vm(struct vpmu_vm *vpmu_vm)
 {
 	close(vpmu_vm->gic_fd);
-- 
2.40.1


