Return-Path: <linux-kselftest+bounces-46122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1F4C74766
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 15:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D39FF357B3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE75346E76;
	Thu, 20 Nov 2025 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="TuVGjvoA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from iad-out-013.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-013.esa.us-east-1.outbound.mail-perimeter.amazon.com [34.198.218.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D887E3451CB;
	Thu, 20 Nov 2025 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.198.218.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647604; cv=none; b=OrDyrTmF7hLKDZtI1/0bTkGoboCn240tm1gJQJPunqLqtXa1kRIiVkpRzCKefowtEV8hyTkuOcYbOwS5A5lLGW0/q3Ldla5w33OfUvP0kumNOOkHLVE7QLSpfhHCvMBjo91cXNeO2mkfB2zvCQ0j59kwd5v/H+q0N4wYbONfunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647604; c=relaxed/simple;
	bh=DtqmoiVLaBdJeNm3YJqME1M8KvGR+m5inZtCXIkz7xI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTZScWePKbcS1hu2BytQ0hU/HoGgiwNpsNemekIUUKcKxoTBQxi/J6G+Wge0lzRv9sthc6Eulm5hNYMK2gojcGx9N7t/Ln1cnujzJbFZCE4Jn7JO1vSHwfWWttIbxSYQD65yos9CYdsGkkavtZ1paUD4c2jyeZx4wstBmegglKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=TuVGjvoA; arc=none smtp.client-ip=34.198.218.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1763647602; x=1795183602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r17NPabB3Mb9A+ei+bmQTwfaoKUDCzKk3n5O7OHsMPU=;
  b=TuVGjvoAtQYd45Ni2A10gbCKB8/Qu4mzURPyUy2jT9SRQobEf4Oduk/A
   bTtJxssK1/EaykCcssA7cLiIoMLzFO+QaG9vmnqpnl/5pr0YdYtU4iafv
   xe/UyLXCmRRqPShrPr0CsSIbqZ8vZvTh3b3b39S8PYvzmoVsGJvednkHW
   Yn5mJtocqrIfBn5Td7HbaNry9WNHoSdSsKecU9E7fPYAn/Elv5jM8BH2g
   0KnSeS8d/f0zpsv0aC6C9mz/TNQ3R8i2f3hFKpu7dcBfiEjDMaAD1ZcAa
   oojvCPIJUk9s8PhDFnihwZykCV2rOaJO9iT736koMMGgAzjMrnvXzl1a2
   w==;
X-CSE-ConnectionGUID: 1DyTEg71QzS09rj7cU4tlw==
X-CSE-MsgGUID: lZfweM6lRouJX0QvMgQYMg==
X-IronPort-AV: E=Sophos;i="6.20,213,1758585600"; 
   d="scan'208";a="6295532"
Received: from ip-10-4-13-79.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.13.79])
  by internal-iad-out-013.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 14:06:37 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:13000]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.192:2525] with esmtp (Farcaster)
 id 6fdd39a5-b79b-4fab-bbaf-cdade7fef510; Thu, 20 Nov 2025 14:06:37 +0000 (UTC)
X-Farcaster-Flow-ID: 6fdd39a5-b79b-4fab-bbaf-cdade7fef510
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 20 Nov 2025 14:06:36 +0000
Received: from amazon.com (10.1.213.15) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Thu, 20 Nov 2025
 14:06:34 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>, <oliver.upton@linux.dev>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<mdittgen@amazon.de>, <lilitj@amazon.de>, <sauravsc@amazon.de>,
	<nh-open-source@amazon.com>
Subject: [RFC PATCH 13/13] KVM: arm64: selftests: Add test for per-vCPU vLPI control API
Date: Thu, 20 Nov 2025 15:03:02 +0100
Message-ID: <20251120140305.63515-14-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251120140305.63515-1-mdittgen@amazon.de>
References: <20251120140305.63515-1-mdittgen@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a selftest for KVM API ioctls for enabling, disabling, and
querying direct vLPI injection capability on a per-vCPU basis.
Ensure that ITS data structures remain correct, vPEIDs can
be reused by different vCPUs, and ioctl behavior works as
intended in corner cases (idempotent behavior, vGIC uninitialized).

Signed-off-by: Maximilian Dittgen <mdittgen@amazon.de>
---
 arch/arm64/kvm/arm.c                          |   4 +
 drivers/irqchip/irq-gic-v3-its.c              |   6 +
 include/linux/irqchip/arm-gic-v4.h            |   1 +
 include/uapi/linux/kvm.h                      |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/arm64/per_vcpu_vlpi.c       | 274 ++++++++++++++++++
 6 files changed, 287 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/arm64/per_vcpu_vlpi.c

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index ecc3c87889db..eea0d77508a2 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -21,6 +21,7 @@
 #include <linux/sched/stat.h>
 #include <linux/psci.h>
 #include <trace/events/kvm.h>
+#include <linux/irqchip/arm-gic-v4.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace_arm.h"
@@ -429,6 +430,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_PER_VCPU_VLPI:
 		r = kvm_per_vcpu_vlpi_supported();
 		break;
+	case KVM_CAP_ARM_MAX_VPEID:
+		r = its_get_max_vpeid();
+		break;
 
 	default:
 		r = 0;
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0e0778d61df2..078a9cafaf17 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4546,6 +4546,12 @@ static const struct irq_domain_ops its_sgi_domain_ops = {
 	.deactivate	= its_sgi_irq_domain_deactivate,
 };
 
+int its_get_max_vpeid(void)
+{
+	return ITS_MAX_VPEID;
+}
+EXPORT_SYMBOL_GPL(its_get_max_vpeid);
+
 static int its_vpe_id_alloc(void)
 {
 	return ida_alloc_max(&its_vpeid_ida, ITS_MAX_VPEID - 1, GFP_KERNEL);
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index bd3e8de35147..3a42cccb72af 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -147,6 +147,7 @@ int its_alloc_vcpu_irqs(struct its_vm *vm);
 int its_alloc_vcpu_irq(struct kvm_vcpu *vcpu);
 void its_free_vcpu_irqs(struct its_vm *vm);
 void its_free_vcpu_irq(struct kvm_vcpu *vcpu);
+int its_get_max_vpeid(void);
 int its_make_vpe_resident(struct its_vpe *vpe, bool g0en, bool g1en);
 int its_make_vpe_non_resident(struct its_vpe *vpe, bool db);
 int its_commit_vpe(struct its_vpe *vpe);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 057eb9e61ac8..9f0ae2096e58 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -974,6 +974,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_GUEST_MEMFD_FLAGS 244
 #define KVM_CAP_ARM_SEA_TO_USER 245
 #define KVM_CAP_ARM_PER_VCPU_VLPI 246
+#define KVM_CAP_ARM_MAX_VPEID 247
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 02a7663c097b..71a929ef7e5d 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -162,6 +162,7 @@ TEST_GEN_PROGS_arm64 += arm64/host_sve
 TEST_GEN_PROGS_arm64 += arm64/hypercalls
 TEST_GEN_PROGS_arm64 += arm64/external_aborts
 TEST_GEN_PROGS_arm64 += arm64/page_fault_test
+TEST_GEN_PROGS_arm64 += arm64/per_vcpu_vlpi
 TEST_GEN_PROGS_arm64 += arm64/psci_test
 TEST_GEN_PROGS_arm64 += arm64/sea_to_user
 TEST_GEN_PROGS_arm64 += arm64/set_id_regs
diff --git a/tools/testing/selftests/kvm/arm64/per_vcpu_vlpi.c b/tools/testing/selftests/kvm/arm64/per_vcpu_vlpi.c
new file mode 100644
index 000000000000..9a5b1b40ff10
--- /dev/null
+++ b/tools/testing/selftests/kvm/arm64/per_vcpu_vlpi.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test per-vCPU vLPI enable/disable/query correctness
+ */
+
+#include <linux/kvm.h>
+#include <pthread.h>
+#include <sys/resource.h>
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "gic.h"
+#include "vgic.h"
+#include "../kselftest_harness.h"
+
+static int MAX_VCPUS;
+static int ITS_MAX_VPEID;
+
+/* Dynamically fetch MAX_VCPUS and ITS_MAX_VPEID values */
+__attribute__((constructor))
+static void init_test_limits(void)
+{
+	int kvm_fd = open("/dev/kvm", O_RDWR);
+	int max_vcpus, max_vpeids;
+
+	if (kvm_fd >= 0) {
+		max_vcpus = ioctl(kvm_fd, KVM_CHECK_EXTENSION, KVM_CAP_MAX_VCPUS);
+		if (max_vcpus > 0)
+			MAX_VCPUS = max_vcpus;
+
+		max_vpeids = ioctl(kvm_fd, KVM_CHECK_EXTENSION, KVM_CAP_ARM_MAX_VPEID);
+		if (max_vpeids > 0)
+			ITS_MAX_VPEID = max_vpeids;
+
+		close(kvm_fd);
+	}
+}
+
+static void guest_code(void)
+{
+	GUEST_SYNC(0);
+	GUEST_DONE();
+}
+
+static void setup_vm_with_gic(struct kvm_vm **vm, struct kvm_vcpu **vcpu, int nr_vcpus)
+{
+	struct kvm_vcpu **vcpus;
+
+	TEST_REQUIRE(kvm_supports_vgic_v3());
+
+	if (nr_vcpus == 1) {
+		*vm = vm_create_with_one_vcpu(vcpu, guest_code);
+	} else {
+		vcpus = calloc(nr_vcpus, sizeof(*vcpus));
+		TEST_ASSERT(vcpus, "Failed to allocate vcpu array");
+		*vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
+		*vcpu = vcpus[0];
+		free(vcpus);
+	}
+}
+
+static void cleanup_vm(struct kvm_vm *vm, int its_fd)
+{
+	if (its_fd >= 0)
+		close(its_fd);
+	kvm_vm_free(vm);
+}
+
+TEST(basic_vlpi_toggle)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	int its_fd, ret;
+	int vcpu_id = 0;
+
+	setup_vm_with_gic(&vm, &vcpu, 1);
+	its_fd = vgic_its_setup(vm);
+
+	ret = ioctl(vm->fd, KVM_QUERY_VCPU_VLPI, &vcpu_id);
+	EXPECT_GE(ret, 0);
+
+	ret = ioctl(vm->fd, KVM_ENABLE_VCPU_VLPI, &vcpu_id);
+	EXPECT_EQ(ret, 0);
+
+	ret = ioctl(vm->fd, KVM_QUERY_VCPU_VLPI, &vcpu_id);
+	EXPECT_GT(ret, 0);
+
+	ret = ioctl(vm->fd, KVM_DISABLE_VCPU_VLPI, &vcpu_id);
+	EXPECT_EQ(ret, 0);
+
+	ret = ioctl(vm->fd, KVM_QUERY_VCPU_VLPI, &vcpu_id);
+	EXPECT_EQ(ret, 0);
+
+	cleanup_vm(vm, its_fd);
+}
+
+/* recycle test */
+struct thread_data {
+	struct kvm_vm *vm;
+	int vcpu_id;
+	int ret;
+};
+
+static void *vlpi_thread(void *arg)
+{
+	struct thread_data *data = arg;
+
+	data->ret = ioctl(data->vm->fd, KVM_ENABLE_VCPU_VLPI, &data->vcpu_id);
+	if (data->ret == 0)
+		data->ret = ioctl(data->vm->fd, KVM_DISABLE_VCPU_VLPI, &data->vcpu_id);
+
+	return NULL;
+}
+
+TEST(vpeid_recycling)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	int its_fd;
+	int vcpu_id, i;
+	int cycles = (ITS_MAX_VPEID * 2) / MAX_VCPUS;
+	pthread_t threads[MAX_VCPUS];
+	struct thread_data data[MAX_VCPUS];
+
+	setup_vm_with_gic(&vm, &vcpu, MAX_VCPUS);
+	its_fd = vgic_its_setup(vm);
+
+	for (i = 0; i < cycles; i++) {
+		for (vcpu_id = 0; vcpu_id < MAX_VCPUS; vcpu_id++) {
+			data[vcpu_id].vm = vm;
+			data[vcpu_id].vcpu_id = vcpu_id;
+			pthread_create(&threads[vcpu_id], NULL, vlpi_thread, &data[vcpu_id]);
+		}
+
+		for (vcpu_id = 0; vcpu_id < MAX_VCPUS; vcpu_id++) {
+			pthread_join(threads[vcpu_id], NULL);
+			EXPECT_EQ(data[vcpu_id].ret, 0);
+		}
+	}
+
+	cleanup_vm(vm, its_fd);
+}
+
+TEST(double_enable_disable)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	int its_fd, ret;
+	int vcpu_id = 0;
+
+	setup_vm_with_gic(&vm, &vcpu, 1);
+	its_fd = vgic_its_setup(vm);
+
+	ret = ioctl(vm->fd, KVM_ENABLE_VCPU_VLPI, &vcpu_id);
+	EXPECT_EQ(ret, 0);
+
+	ret = ioctl(vm->fd, KVM_ENABLE_VCPU_VLPI, &vcpu_id);
+	EXPECT_EQ(ret, 0);
+
+	ret = ioctl(vm->fd, KVM_QUERY_VCPU_VLPI, &vcpu_id);
+	EXPECT_GT(ret, 0);
+
+	ret = ioctl(vm->fd, KVM_DISABLE_VCPU_VLPI, &vcpu_id);
+	EXPECT_EQ(ret, 0);
+
+	ret = ioctl(vm->fd, KVM_DISABLE_VCPU_VLPI, &vcpu_id);
+	EXPECT_EQ(ret, 0);
+
+	ret = ioctl(vm->fd, KVM_QUERY_VCPU_VLPI, &vcpu_id);
+	EXPECT_EQ(ret, 0);
+
+	cleanup_vm(vm, its_fd);
+}
+
+TEST(uninitialized_vcpu)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	int its_fd, ret;
+	int invalid_vcpu_id = 999;
+
+	setup_vm_with_gic(&vm, &vcpu, 1);
+	its_fd = vgic_its_setup(vm);
+
+	ret = ioctl(vm->fd, KVM_QUERY_VCPU_VLPI, &invalid_vcpu_id);
+	EXPECT_LT(ret, 0);
+
+	ret = ioctl(vm->fd, KVM_ENABLE_VCPU_VLPI, &invalid_vcpu_id);
+	EXPECT_LT(ret, 0);
+
+	ret = ioctl(vm->fd, KVM_DISABLE_VCPU_VLPI, &invalid_vcpu_id);
+	EXPECT_LT(ret, 0);
+
+	cleanup_vm(vm, its_fd);
+}
+
+TEST(vpeid_exhaustion)
+{
+	struct rlimit rlim;
+	struct kvm_vm **vms;
+	struct kvm_vcpu **vcpus;
+	int *its_fds;
+	/* Allocate enough VMs to exhaust vPEs, plus one */
+	int num_vms = ITS_MAX_VPEID / MAX_VCPUS + 1;
+	int remainder_vcpus = ITS_MAX_VPEID % MAX_VCPUS;
+	int vm_idx, vcpu_id, ret;
+	int successful_enables = 0;
+
+	/* Raise fd limit if below vPE limit, as we can't allocate enough vCPUs */
+	if (getrlimit(RLIMIT_NOFILE, &rlim) == 0) {
+		struct rlimit new_rlim = rlim;
+		/*
+		 * Require [num_vms * (vcpus_per_vm + VM_fd + ITS_fd) + KVM] file
+		 * descriptors, tripled for safety.
+		 */
+		int required_fds = (num_vms * (MAX_VCPUS + 2) + 1) * 3;
+
+		if (rlim.rlim_cur < required_fds) {
+			new_rlim.rlim_cur = min_t(rlim_t, required_fds, rlim.rlim_max);
+			if (setrlimit(RLIMIT_NOFILE, &new_rlim) != 0) {
+				SKIP(return, "Need %d FDs, have %ld, cannot increase limit",
+					required_fds, rlim.rlim_cur);
+			}
+		}
+	}
+
+	vms = calloc(num_vms, sizeof(*vms));
+	vcpus = calloc(num_vms, sizeof(*vcpus));
+	its_fds = calloc(num_vms, sizeof(*its_fds));
+	TEST_ASSERT(vms && vcpus && its_fds, "Failed to allocate VM arrays");
+
+	/* Create all VMs */
+	for (vm_idx = 0; vm_idx < num_vms; vm_idx++) {
+		setup_vm_with_gic(&vms[vm_idx], &vcpus[vm_idx], MAX_VCPUS);
+		its_fds[vm_idx] = vgic_its_setup(vms[vm_idx]);
+	}
+
+	/* Exhaust all vPEs */
+	for (vm_idx = 0; vm_idx < num_vms - 1; vm_idx++) {
+		for (vcpu_id = 0; vcpu_id < MAX_VCPUS; vcpu_id++) {
+			ret = ioctl(vms[vm_idx]->fd, KVM_ENABLE_VCPU_VLPI, &vcpu_id);
+			if (ret == 0)
+				successful_enables++;
+		}
+	}
+
+	for (vcpu_id = 0; vcpu_id < remainder_vcpus; vcpu_id++) {
+		ret = ioctl(vms[num_vms - 1]->fd, KVM_ENABLE_VCPU_VLPI, &vcpu_id);
+		if (ret == 0)
+			successful_enables++;
+	}
+
+	/* Should have exhausted vPEID limit */
+	TEST_ASSERT(successful_enables == ITS_MAX_VPEID,
+		"Failed to allocate all existing vPEIDs");
+
+	/* Try assigning one more vPEID past exhaustion*/
+	vcpu_id = remainder_vcpus;
+	ret = ioctl(vms[num_vms - 1]->fd, KVM_ENABLE_VCPU_VLPI, &vcpu_id);
+
+	/* Verify failure to allocate additional vPEID */
+	TEST_ASSERT(ret < 0, "Failed to detect vPEID exhaustion");
+
+	/* Cleanup all VMs */
+	for (vm_idx = 0; vm_idx < num_vms; vm_idx++)
+		cleanup_vm(vms[vm_idx], its_fds[vm_idx]);
+
+	free(vms);
+	free(vcpus);
+	free(its_fds);
+	setrlimit(RLIMIT_NOFILE, &rlim); /* Restore fd limit */
+}
+
+TEST_HARNESS_MAIN
-- 
2.50.1 (Apple Git-155)




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


