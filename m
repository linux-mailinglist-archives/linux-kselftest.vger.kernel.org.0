Return-Path: <linux-kselftest+bounces-9782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295A08C0D14
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 11:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3254283178
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 09:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DC314B081;
	Thu,  9 May 2024 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZA09fraj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CD714AD03
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245562; cv=none; b=TnxcKI34XmzplDiUd49nGaSNK+wkPiQ1g1rdBR//YoTIGToYK04YdE4vcn34Qqm2VQQHa5w22DupExaWNyLOxXh92BXg/p9LFtzm6VLfnrJyBRCA7LHau3AcbexiMRrf1wBn8db57LNcvdq2qaXmhEzo3OaN12eE2i8ddS0fobU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245562; c=relaxed/simple;
	bh=OFH17WrVzwX/MXoE2GaSMOO560zidpmx0RE36uVrj1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XMnjVec50OMrQ3P6nMlttIYMCxJJsU1stGDd+0qR0Whc1zWPekqFMSepVUZM3h3rg159KwXf258Q0j6ccUC4si6AbS5aVo9kKRM5epqAPGDR6I107rUAWNxrWWp7JXM6xyzNM2/YDOfj8gv0ciMYYIGKRuID6gnpamw09pkv3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZA09fraj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715245559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gv9KSYkm1B2yQrSW3Vp2Cj13w+VeZkMij45pxdKg3N4=;
	b=ZA09fraj8U6tMgs7+LVtHOEFTtf2MKMThruVf7GvluRkph9JgWMphW70mkzlN4CV8FwJ01
	kE53rSU1wK3HM/Vz3ImxbquckaDR0Hg6jO+o+1mNjvf8w1ItajREMwNE4OsXZZ80L7ikwv
	7R+BwsZao8Bq40RmwkA68W3U8Nk1Qi8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-e1X46GC_PUOK7sO3RPiO-w-1; Thu, 09 May 2024 05:05:56 -0400
X-MC-Unique: e1X46GC_PUOK7sO3RPiO-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3582885A58C;
	Thu,  9 May 2024 09:05:55 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 255F0105480A;
	Thu,  9 May 2024 09:05:55 +0000 (UTC)
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
Subject: [PATCH v8 2/3] KVM: selftests: aarch64: Introduce pmu_event_filter_test
Date: Thu,  9 May 2024 05:05:39 -0400
Message-Id: <20240509090544.2063429-3-shahuang@redhat.com>
In-Reply-To: <20240509090544.2063429-1-shahuang@redhat.com>
References: <20240509090544.2063429-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Introduce pmu_event_filter_test for arm64 platforms. The test configures
PMUv3 for a vCPU, and sets different pmu event filters for the vCPU, and
check if the guest can see those events which user allow and can't use
those events which use deny.

This test refactor the create_vpmu_vm() and make it a wrapper for
__create_vpmu_vm(), which allows some extra init code before
KVM_ARM_VCPU_PMU_V3_INIT.

And this test use the KVM_ARM_VCPU_PMU_V3_FILTER attribute to set the
pmu event filter in KVM. And choose to filter two common event
branches_retired and instructions_retired, and let the guest to check if
it see the right pmceid register.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/aarch64/pmu_event_filter_test.c       | 303 ++++++++++++++++++
 2 files changed, 304 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index e78cac712229..964443e1a603 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -152,6 +152,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/aarch32_id_regs
 TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
 TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
 TEST_GEN_PROGS_aarch64 += aarch64/page_fault_test
+TEST_GEN_PROGS_aarch64 += aarch64/pmu_event_filter_test
 TEST_GEN_PROGS_aarch64 += aarch64/psci_test
 TEST_GEN_PROGS_aarch64 += aarch64/set_id_regs
 TEST_GEN_PROGS_aarch64 += aarch64/smccc_filter
diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
new file mode 100644
index 000000000000..fb0fde1ed436
--- /dev/null
+++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
@@ -0,0 +1,303 @@
+
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pmu_event_filter_test - Test user limit pmu event for guest.
+ *
+ * Copyright (c) 2023 Red Hat, Inc.
+ *
+ * This test checks if the guest only see the limited pmu event that userspace
+ * sets, if the guest can use those events which user allow, and if the guest
+ * can't use those events which user deny.
+ * This test runs only when KVM_CAP_ARM_PMU_V3, KVM_ARM_VCPU_PMU_V3_FILTER
+ * is supported on the host.
+ */
+#include <kvm_util.h>
+#include <processor.h>
+#include <vgic.h>
+#include <vpmu.h>
+#include <test_util.h>
+#include <perf/arm_pmuv3.h>
+
+struct pmu_common_event_ids {
+	uint64_t pmceid0;
+	uint64_t pmceid1;
+} max_pmce, expected_pmce;
+
+struct vpmu_vm {
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	int gic_fd;
+};
+
+static struct vpmu_vm vpmu_vm;
+
+#define FILTER_NR 10
+
+struct test_desc {
+	const char *name;
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
+static void guest_code(void)
+{
+	uint64_t pmceid0 = read_sysreg(pmceid0_el0);
+	uint64_t pmceid1 = read_sysreg(pmceid1_el0);
+
+	GUEST_ASSERT_EQ(expected_pmce.pmceid0, pmceid0);
+	GUEST_ASSERT_EQ(expected_pmce.pmceid1, pmceid1);
+
+	GUEST_DONE();
+}
+
+static void guest_get_pmceid(void)
+{
+	max_pmce.pmceid0 = read_sysreg(pmceid0_el0);
+	max_pmce.pmceid1 = read_sysreg(pmceid1_el0);
+
+	GUEST_DONE();
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
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+}
+
+static void set_pmce(struct pmu_common_event_ids *pmce, int action, int event)
+{
+	int base = 0;
+	uint64_t *pmceid = NULL;
+
+	if (event >= 0x4000) {
+		event -= 0x4000;
+		base = 32;
+	}
+
+	if (event >= 0 && event <= 0x1F) {
+		pmceid = &pmce->pmceid0;
+	} else if (event >= 0x20 && event <= 0x3F) {
+		event -= 0x20;
+		pmceid = &pmce->pmceid1;
+	} else {
+		return;
+	}
+
+	event += base;
+	if (action == KVM_PMU_EVENT_ALLOW)
+		*pmceid |= BIT(event);
+	else
+		*pmceid &= ~BIT(event);
+}
+
+static void prepare_expected_pmce(struct kvm_pmu_event_filter *filter)
+{
+	struct pmu_common_event_ids pmce_mask = { ~0, ~0 };
+	bool first_filter = true;
+	int i;
+
+	while (filter && filter->nevents != 0) {
+		if (first_filter) {
+			if (filter->action == KVM_PMU_EVENT_ALLOW)
+				memset(&pmce_mask, 0, sizeof(pmce_mask));
+			first_filter = false;
+		}
+
+		for (i = 0; i < filter->nevents; i++)
+			set_pmce(&pmce_mask, filter->action,
+				 filter->base_event + i);
+
+		filter++;
+	}
+
+	expected_pmce.pmceid0 = max_pmce.pmceid0 & pmce_mask.pmceid0;
+	expected_pmce.pmceid1 = max_pmce.pmceid1 & pmce_mask.pmceid1;
+}
+
+static void pmu_event_filter_init(struct kvm_pmu_event_filter *filter)
+{
+	while (filter && filter->nevents != 0) {
+		kvm_device_attr_set(vpmu_vm.vcpu->fd,
+				    KVM_ARM_VCPU_PMU_V3_CTRL,
+				    KVM_ARM_VCPU_PMU_V3_FILTER,
+				    filter);
+		filter++;
+	}
+}
+
+/* Create a VM that has one vCPU with PMUv3 configured. */
+static void create_vpmu_vm_with_filter(void *guest_code,
+				       struct kvm_pmu_event_filter *filter)
+{
+	uint64_t irq = 23;
+
+	/* The test creates the vpmu_vm multiple times. Ensure a clean state */
+	memset(&vpmu_vm, 0, sizeof(vpmu_vm));
+
+	vpmu_vm.vm = vm_create(1);
+	vpmu_vm.vcpu = vm_vcpu_add_with_vpmu(vpmu_vm.vm, 0, guest_code);
+	vpmu_vm.gic_fd = vgic_v3_setup(vpmu_vm.vm, 1, 64);
+	__TEST_REQUIRE(vpmu_vm.gic_fd >= 0,
+		       "Failed to create vgic-v3, skipping");
+
+	pmu_event_filter_init(filter);
+
+	/* Initialize vPMU */
+	vpmu_set_irq(vpmu_vm.vcpu, irq);
+	vpmu_init(vpmu_vm.vcpu);
+}
+
+static void create_vpmu_vm(void *guest_code)
+{
+	create_vpmu_vm_with_filter(guest_code, NULL);
+}
+
+static void destroy_vpmu_vm(void)
+{
+	close(vpmu_vm.gic_fd);
+	kvm_vm_free(vpmu_vm.vm);
+}
+
+static void run_test(struct test_desc *t)
+{
+	pr_info("Test: %s\n", t->name);
+
+	create_vpmu_vm_with_filter(guest_code, t->filter);
+	prepare_expected_pmce(t->filter);
+	sync_global_to_guest(vpmu_vm.vm, expected_pmce);
+
+	run_vcpu(vpmu_vm.vcpu);
+
+	destroy_vpmu_vm();
+}
+
+static struct test_desc tests[] = {
+	{
+		.name = "without_filter",
+		.filter = {
+			{ 0 }
+		},
+	},
+	{
+		.name = "member_allow_filter",
+		.filter = {
+			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_SW_INCR, 0),
+			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_INST_RETIRED, 0),
+			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_BR_RETIRED, 0),
+			{ 0 },
+		},
+	},
+	{
+		.name = "member_deny_filter",
+		.filter = {
+			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_SW_INCR, 1),
+			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_INST_RETIRED, 1),
+			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_BR_RETIRED, 1),
+			{ 0 },
+		},
+	},
+	{
+		.name = "not_member_deny_filter",
+		.filter = {
+			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_SW_INCR, 1),
+			{ 0 },
+		},
+	},
+	{
+		.name = "not_member_allow_filter",
+		.filter = {
+			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_SW_INCR, 0),
+			{ 0 },
+		},
+	},
+	{
+		.name = "deny_chain_filter",
+		.filter = {
+			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CHAIN, 1),
+			{ 0 },
+		},
+	},
+	{
+		.name = "deny_cpu_cycles_filter",
+		.filter = {
+			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, 1),
+			{ 0 },
+		},
+	},
+	{
+		.name = "cancel_filter",
+		.filter = {
+			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, 0),
+			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, 1),
+		},
+	},
+	{
+		.name = "multiple_filter",
+		.filter = {
+			__DEFINE_FILTER(0x0, 0x10, 0),
+			__DEFINE_FILTER(0x6, 0x3, 1),
+		},
+	},
+	{ 0 }
+};
+
+static void run_tests(void)
+{
+	struct test_desc *t;
+
+	for (t = &tests[0]; t->name; t++)
+		run_test(t);
+}
+
+int used_pmu_events[] = {
+       ARMV8_PMUV3_PERFCTR_BR_RETIRED,
+       ARMV8_PMUV3_PERFCTR_INST_RETIRED,
+       ARMV8_PMUV3_PERFCTR_CHAIN,
+};
+
+static bool kvm_pmu_support_events(void)
+{
+	struct pmu_common_event_ids used_pmce = { 0, 0 };
+
+	create_vpmu_vm(guest_get_pmceid);
+
+	memset(&max_pmce, 0, sizeof(max_pmce));
+	sync_global_to_guest(vpmu_vm.vm, max_pmce);
+	run_vcpu(vpmu_vm.vcpu);
+	sync_global_from_guest(vpmu_vm.vm, max_pmce);
+	destroy_vpmu_vm();
+
+	for (int i = 0; i < ARRAY_SIZE(used_pmu_events); i++)
+		set_pmce(&used_pmce, KVM_PMU_EVENT_ALLOW, used_pmu_events[i]);
+
+	return ((max_pmce.pmceid0 & used_pmce.pmceid0) == used_pmce.pmceid0) &&
+	       ((max_pmce.pmceid1 & used_pmce.pmceid1) == used_pmce.pmceid1);
+}
+
+int main(void)
+{
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_PMU_V3));
+	TEST_REQUIRE(kvm_pmu_support_events());
+
+	run_tests();
+}
-- 
2.40.1


