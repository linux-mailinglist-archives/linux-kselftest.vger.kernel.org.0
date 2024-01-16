Return-Path: <linux-kselftest+bounces-3063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACA182E95F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 07:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9512284B5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 06:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4230F9CD;
	Tue, 16 Jan 2024 06:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvyKjjhH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2404B111BC
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jan 2024 06:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705384901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Qw6FiQjfkuQIwLM/Cd1XVofWUckSVDRH6rB1Jby9Xc=;
	b=KvyKjjhH9f6Qqz/dpMzn4nGMo8ggOjjTpoAz3ZNgnehyDjIq985WjNzUokVAsZ2OIjjttg
	PqtI7kMGXZJQ7OM3CowdsldsVn4cZHPzrBOzJuPyUsfVrEG8ssSUex9EZajAxYC/VL1/Gz
	sOsff1IAHzJQwobR/aMVhK6yMfJHJLw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-eny1oHpJPiGlyNf6cxFRLg-1; Tue,
 16 Jan 2024 01:01:37 -0500
X-MC-Unique: eny1oHpJPiGlyNf6cxFRLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FB9B1C05ABF;
	Tue, 16 Jan 2024 06:01:37 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 125332026D6F;
	Tue, 16 Jan 2024 06:01:37 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Eric Auger <eauger@redhat.com>,
	Shaoqin Huang <shahuang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/5] KVM: selftests: aarch64: Introduce pmu_event_filter_test
Date: Tue, 16 Jan 2024 01:01:22 -0500
Message-Id: <20240116060129.55473-5-shahuang@redhat.com>
In-Reply-To: <20240116060129.55473-1-shahuang@redhat.com>
References: <20240116060129.55473-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

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
 .../kvm/aarch64/pmu_event_filter_test.c       | 219 ++++++++++++++++++
 .../selftests/kvm/include/aarch64/vpmu.h      |   4 +
 .../testing/selftests/kvm/lib/aarch64/vpmu.c  |  14 +-
 4 files changed, 236 insertions(+), 2 deletions(-)
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
index 000000000000..d280382f362f
--- /dev/null
+++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
@@ -0,0 +1,219 @@
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
+struct pmce{
+	uint64_t pmceid0;
+	uint64_t pmceid1;
+} supported_pmce, guest_pmce;
+
+static struct vpmu_vm *vpmu_vm;
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
+#define EMPTY_FILTER	{ 0 }
+
+#define SW_INCR		0x0
+#define INST_RETIRED	0x8
+#define BR_RETIRED	0x21
+
+static void guest_code(void)
+{
+	uint64_t pmceid0 = read_sysreg(pmceid0_el0);
+	uint64_t pmceid1 = read_sysreg(pmceid1_el0);
+
+	GUEST_ASSERT_EQ(guest_pmce.pmceid0, pmceid0);
+	GUEST_ASSERT_EQ(guest_pmce.pmceid1, pmceid1);
+
+	GUEST_DONE();
+}
+
+static void guest_get_pmceid(void)
+{
+	supported_pmce.pmceid0 = read_sysreg(pmceid0_el0);
+	supported_pmce.pmceid1 = read_sysreg(pmceid1_el0);
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
+static void set_pmce(struct pmce *pmce, int action, int event)
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
+static void prepare_guest_pmce(struct kvm_pmu_event_filter *filter)
+{
+	struct pmce pmce_mask = { ~0, ~0 };
+	bool first_filter = true;
+
+	while (filter && filter->nevents != 0) {
+		if (first_filter) {
+			if (filter->action == KVM_PMU_EVENT_ALLOW)
+				memset(&pmce_mask, 0, sizeof(pmce_mask));
+			first_filter = false;
+		}
+
+		set_pmce(&pmce_mask, filter->action, filter->base_event);
+		filter++;
+	}
+
+	guest_pmce.pmceid0 = supported_pmce.pmceid0 & pmce_mask.pmceid0;
+	guest_pmce.pmceid1 = supported_pmce.pmceid1 & pmce_mask.pmceid1;
+}
+
+static void run_test(struct test_desc *t)
+{
+	pr_debug("Test: %s\n", t->name);
+
+	create_vpmu_vm_with_filter(guest_code, t->filter);
+	prepare_guest_pmce(t->filter);
+	sync_global_to_guest(vpmu_vm->vm, guest_pmce);
+
+	run_vcpu(vpmu_vm->vcpu);
+
+	destroy_vpmu_vm(vpmu_vm);
+}
+
+static struct test_desc tests[] = {
+	{"without_filter", { EMPTY_FILTER }},
+	{"member_allow_filter",
+	 {DEFINE_FILTER(SW_INCR, 0), DEFINE_FILTER(INST_RETIRED, 0),
+	  DEFINE_FILTER(BR_RETIRED, 0), EMPTY_FILTER}},
+	{"member_deny_filter",
+	 {DEFINE_FILTER(SW_INCR, 1), DEFINE_FILTER(INST_RETIRED, 1),
+	  DEFINE_FILTER(BR_RETIRED, 1), EMPTY_FILTER}},
+	{"not_member_deny_filter",
+	 {DEFINE_FILTER(SW_INCR, 1), EMPTY_FILTER}},
+	{"not_member_allow_filter",
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
+static bool kvm_supports_pmu_event_filter(void)
+{
+	int r;
+
+	vpmu_vm = create_vpmu_vm(guest_code);
+
+	r = __kvm_has_device_attr(vpmu_vm->vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
+				  KVM_ARM_VCPU_PMU_V3_FILTER);
+
+	destroy_vpmu_vm(vpmu_vm);
+	return !r;
+}
+
+static bool host_pmu_supports_events(void)
+{
+	vpmu_vm = create_vpmu_vm(guest_get_pmceid);
+
+	memset(&supported_pmce, 0, sizeof(supported_pmce));
+	sync_global_to_guest(vpmu_vm->vm, supported_pmce);
+	run_vcpu(vpmu_vm->vcpu);
+	sync_global_from_guest(vpmu_vm->vm, supported_pmce);
+	destroy_vpmu_vm(vpmu_vm);
+
+	return supported_pmce.pmceid0 & (BR_RETIRED | INST_RETIRED);
+}
+
+int main(void)
+{
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_PMU_V3));
+	TEST_REQUIRE(kvm_supports_pmu_event_filter());
+	TEST_REQUIRE(host_pmu_supports_events());
+
+	for_each_test();
+}
diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
index 644dae3814b5..f103d0824f8a 100644
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


