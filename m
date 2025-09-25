Return-Path: <linux-kselftest+bounces-42277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F41DB9E2CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 11:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1E71BC2A04
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 09:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD1127FB26;
	Thu, 25 Sep 2025 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="OjiMrsYR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D3226A0EB;
	Thu, 25 Sep 2025 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790905; cv=none; b=PQ5jg6dY1/gYK6xSU1XopTPZTu2FtRbKXibRJj7Dm0X3C3r8jCSlT5y4YiuVTqWykN/u83vhz4X2u4L280si/+8LP3m6gqoRCt0i6C/YjSGmzDO7s2J+qNSm7mNMt2dzXKphWGMI57sLbg8OiELAwjYDWX/Vr7uM3lpyIiGJkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790905; c=relaxed/simple;
	bh=wH0V9L4HTAytSlhGMf8/mWvHFkJs/uy3bUfR1VwxUaw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=puWQOX44/FW5xKZtyFCTxsWXFGk06UVsPcSMl6OkQt0xMZBmAx/FmxlxnVvVHyeoSQN1PYrlfZQz4mJrEWR+2CDJBjLay7dtpFgtT0KyJ9eZ/m8iWTWVOdpTbMF7I3hrZjL4AeV3W/YQU07Qj2lq/AWmwvq4gBE1Wq0mhMLURhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=OjiMrsYR; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1758790902; x=1790326902;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=arzVRhcfGNvrujNspcMcohO7D+1CiaSxpV1EYAPjoLY=;
  b=OjiMrsYRm19WHYi2WszO3bQtrdCJWnFnOFwrv4XGXFa4G6fQn3EMui6V
   YhxfgXceDge+rPZxmsGgx2k6apYjdXxqmYfCEMiVQbIu4TZJsbnMU7WS2
   SMo+Aeu5HsWsOMDd2DJdMj0NmuyTTu4EPYykzbnbhM6uenZF4DSFQrrM7
   eqCzInabSUnFuqC/4VU8row46gGVKoyAbf8yifuSUOCkouEI8qJ7B9Y0f
   u6qtIMjkGfnoFnTmonol40eMdNa9Qm4vae7Cc3WDZd3NqJ31hszktOfEL
   CAlyScl83w9gWGMdmuM4+tNZc2LCUnKyhmeUzfY4xjW4Qka6EdmRmNxwA
   A==;
X-CSE-ConnectionGUID: V0XLSrSDQwiAnaQDrrWKDQ==
X-CSE-MsgGUID: //mnf7PMQSGyzgjJ2HITug==
X-IronPort-AV: E=Sophos;i="6.18,292,1751241600"; 
   d="scan'208";a="2652043"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 09:01:31 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:31100]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.38.97:2525] with esmtp (Farcaster)
 id 42bcdf63-1af6-489b-b701-b4265b51e108; Thu, 25 Sep 2025 09:01:31 +0000 (UTC)
X-Farcaster-Flow-ID: 42bcdf63-1af6-489b-b701-b4265b51e108
Received: from EX19D016EUA001.ant.amazon.com (10.252.50.245) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 25 Sep 2025 09:01:29 +0000
Received: from amazon.com (10.1.213.21) by EX19D016EUA001.ant.amazon.com
 (10.252.50.245) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Thu, 25 Sep 2025
 09:01:26 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>, <oliver.upton@linux.dev>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<mdittgen@amazon.de>
Subject: [PATCH] kvm, selftests: ioctl to handle MSIs injected from userspace as software-bypassing vLPIs
Date: Thu, 25 Sep 2025 11:01:16 +0200
Message-ID: <20250925090116.27575-1-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D016EUA001.ant.amazon.com (10.252.50.245)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Maximilian Dittgen <mdittgen@amazon.de>

At the moment, all MSIs injected from userspace using KVM_SIGNAL_MSI are
processed as LPIs in software with a hypervisor trap and exit. To
properly test GICv4 direct vLPI injection from KVM selftests, we write a
KVM_DEBUG_GIC_MSI_SETUP ioctl that manually creates an IRQ routing table
entry for the specified MSI, and populates ITS structures (device,
collection, and interrupt translation table entries) to map the MSI to a
vLPI. We then call GICv4 kvm_vgic_v4_set_forwarding to let the vLPI bypass
hypervisor traps and inject directly to the vCPU.

To demonstrate the use of this ioctl, we implement a -D flag to the
vgic_lpi_stress.c selftest that runs the stress test using direct vLPI
injection rather than software-emulated LPI handling.

Signed-off-by: Maximilian Dittgen <mdittgen@amazon.de>
---
 arch/arm64/kvm/arm.c                          |  37 +++++
 arch/arm64/kvm/vgic/vgic-its.c                | 133 ++++++++++++++++++
 arch/arm64/kvm/vgic/vgic.h                    |   2 +
 include/linux/irqchip/arm-gic-v3.h            |   1 +
 include/uapi/linux/kvm.h                      |  15 ++
 .../selftests/kvm/arm64/vgic_lpi_stress.c     |  52 ++++++-
 6 files changed, 238 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 5bf101c869c9..e18f5ff68274 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -46,6 +46,8 @@
 #include <kvm/arm_pmu.h>
 #include <kvm/arm_psci.h>
 
+#include <vgic/vgic.h>
+
 #include "sys_regs.h"
 
 static enum kvm_mode kvm_mode = KVM_MODE_DEFAULT;
@@ -1927,6 +1929,41 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 			return -EFAULT;
 		return kvm_vm_ioctl_get_reg_writable_masks(kvm, &range);
 	}
+	case KVM_DEBUG_GIC_MSI_SETUP: {
+		/* Define interrupt ID boundaries for input validation */
+		#define GIC_LPI_OFFSET    8192
+		#define GIC_LPI_MAX       65535
+		#define SPI_INTID_MIN     32
+		#define SPI_INTID_MAX     1019
+
+		struct kvm_debug_gic_msi_setup params;
+		struct kvm_vcpu *vcpu;
+
+		if (copy_from_user(&params, argp, sizeof(params)))
+			return -EFAULT;
+
+		/* validate vcpu_id is in range and exists */
+		if (params.vcpu_id >= atomic_read(&kvm->online_vcpus))
+			return -EINVAL;
+
+		vcpu = kvm_get_vcpu(kvm, params.vcpu_id);
+		if (!vcpu)
+			return -EINVAL;
+
+		/* validate vintid is in LPI range */
+		if (params.vintid < GIC_LPI_OFFSET || params.vintid > GIC_LPI_MAX)
+			return -EINVAL;
+
+		/*
+		 * Validate host_irq is in safe range -- we use SPI range since
+		 * selftests guests will have no shared peripheral devices
+		 */
+		if (params.host_irq < SPI_INTID_MIN || params.host_irq > SPI_INTID_MAX)
+			return -EINVAL;
+
+		/* Mock single MSI for testing */
+		return debug_gic_msi_setup_mock_msi(kvm, &params);
+	}
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 7368c13f16b7..46153ef5efcb 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -2816,3 +2816,136 @@ int kvm_vgic_register_its_device(void)
 	return kvm_register_device_ops(&kvm_arm_vgic_its_ops,
 				       KVM_DEV_TYPE_ARM_VGIC_ITS);
 }
+
+static struct vgic_its *vgic_get_its(struct kvm *kvm,
+				     struct kvm_kernel_irq_routing_entry *irq_entry)
+{
+	struct kvm_msi msi  = (struct kvm_msi) {
+		.address_lo	= irq_entry->msi.address_lo,
+		.address_hi	= irq_entry->msi.address_hi,
+		.data		= irq_entry->msi.data,
+		.flags		= irq_entry->msi.flags,
+		.devid		= irq_entry->msi.devid,
+	};
+
+	return vgic_msi_to_its(kvm, &msi);
+}
+
+/*
+ * debug_gic_msi_setup_mock_msi - manually set up vLPI direct injection infrastructure
+ * for an MSI upon userspace request. Used for testing vLPIs from selftests.
+ *
+ * Creates an IRQ routing entry mapping the specified MSI signature to a mock
+ * host IRQ, then populates ITS structures (device, collection, ITE) to establish
+ * the DevID/EventID to LPI translation. Finally enables GICv4 vLPI forwarding
+ * to bypass software emulation and inject interrupts directly to the vCPU.
+ *
+ * This function is intended solely for KVM selftests via KVM_DEBUG_GIC_MSI_SETUP.
+ * It uses mock host IRQs in the SPI range assuming no real hardware devices are
+ * present on a selftest guest. Using this interface in production will corrupt the
+ * IRQ routing table.
+ */
+int debug_gic_msi_setup_mock_msi(struct kvm *kvm, struct kvm_debug_gic_msi_setup *params)
+{
+	struct kvm_irq_routing_entry user_entry;
+	struct kvm_kernel_irq_routing_entry entry;
+	struct vgic_its *its;
+	struct its_device *device;
+	struct its_collection *collection;
+	struct its_ite *ite;
+	struct vgic_irq *irq;
+	struct kvm_vcpu *vcpu;
+	u64 doorbell_addr = GITS_BASE_GPA + GITS_TRANSLATER;
+	u32 device_id = params->device_id;
+	u32 event_id = params->event_id;
+	u32 coll_id = params->vcpu_id;
+	u32 lpi_nr = params->vintid;
+	gpa_t itt_addr = params->itt_addr;
+	int ret;
+	int host_irq = params->host_irq;
+
+	// Unmap any existing vLPI on the mock host IRQ (remnants from prior mocks)
+	kvm_vgic_v4_unset_forwarding(kvm, host_irq);
+
+	/* Create mock user IRQ routing entry using kvm_set_routing_entry function */
+	memset(&user_entry, 0, sizeof(user_entry));
+	user_entry.gsi = host_irq;
+	user_entry.type = KVM_IRQ_ROUTING_MSI;
+	user_entry.u.msi.address_lo = doorbell_addr & 0xFFFFFFFF;
+	user_entry.u.msi.address_hi = doorbell_addr >> 32;
+	user_entry.u.msi.data = event_id;
+	user_entry.u.msi.devid = device_id;
+	user_entry.flags = KVM_MSI_VALID_DEVID;
+
+	/* Initialize kernel routing entry */
+	memset(&entry, 0, sizeof(entry));
+
+	/* Use vgic-irqfd.c function to create entry */
+	ret = kvm_set_routing_entry(kvm, &entry, &user_entry);
+	if (ret)
+		return ret;
+
+	/* Now that we created an MSI -> ITS mapping, we can populate the ITS for this MSI */
+
+	/* Get ITS instance */
+	its = vgic_get_its(kvm, &entry);
+	if (IS_ERR(its))
+		return PTR_ERR(its);
+
+	/* Enable ITS manually for testing, normally done by guest writing to GITS_CTLR register */
+	its->enabled = true;
+
+	/* Get target vCPU */
+	vcpu = kvm_get_vcpu(kvm, params->vcpu_id);
+	if (!vcpu)
+		return -EINVAL;
+
+	/*
+	 * Enable this vLPIs for this vCPU manually for testing, normally
+	 * done by guest writing GICR_CTLR
+	 */
+	atomic_set(&vcpu->arch.vgic_cpu.ctlr, GICR_CTLR_ENABLE_LPIS);
+
+	mutex_lock(&its->its_lock);
+
+	/* Create ITS device */
+	device = vgic_its_alloc_device(its, device_id, itt_addr, 8);
+	if (IS_ERR(device)) {
+		ret = PTR_ERR(device);
+		goto unlock;
+	}
+
+	/* Create collection mapped to inputted vcpu */
+	ret = vgic_its_alloc_collection(its, &collection, coll_id);
+	if (ret)
+		goto unlock;
+
+	collection->target_addr = params->vcpu_id;  // Map to specified vcpu
+
+	/* Create ITE */
+	ite = vgic_its_alloc_ite(device, collection, event_id);
+	if (IS_ERR(ite)) {
+		ret = PTR_ERR(ite);
+		vgic_its_free_collection(its, coll_id);
+		goto unlock;
+	}
+
+	/* Create LPI */
+	irq = vgic_add_lpi(kvm, lpi_nr, vcpu);
+	if (IS_ERR(irq)) {
+		ret = PTR_ERR(irq);
+		its_free_ite(kvm, ite);
+		vgic_its_free_collection(its, coll_id);
+		goto unlock;
+	}
+
+	ite->irq = irq;
+	mutex_unlock(&its->its_lock);
+
+	/* Now that routing entry is initialized, call v4 forwarding setup */
+	return kvm_vgic_v4_set_forwarding(kvm, host_irq, &entry);
+
+unlock:
+	mutex_unlock(&its->its_lock);
+	return ret;
+}
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index de1c1d3261c3..8c8f1e963884 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -432,4 +432,6 @@ static inline bool vgic_is_v3(struct kvm *kvm)
 int vgic_its_debug_init(struct kvm_device *dev);
 void vgic_its_debug_destroy(struct kvm_device *dev);
 
+int debug_gic_msi_setup_mock_msi(struct kvm *kvm, struct kvm_debug_gic_msi_setup *params);
+
 #endif
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 70c0948f978e..76beac55cb69 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -378,6 +378,7 @@
 #define GITS_CIDR3			0xfffc
 
 #define GITS_TRANSLATER			0x10040
+#define GITS_BASE_GPA           0x8000000ULL
 
 #define GITS_SGIR			0x20020
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index f0f0d49d2544..a655bbb70e99 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1440,6 +1440,21 @@ struct kvm_enc_region {
 #define KVM_GET_SREGS2             _IOR(KVMIO,  0xcc, struct kvm_sregs2)
 #define KVM_SET_SREGS2             _IOW(KVMIO,  0xcd, struct kvm_sregs2)
 
+/*
+ * Generate an IRQ routing entry and vLPI tables for userspace-sourced
+ * MSI, enabling direct vLPI injection testing from selftests
+ */
+#define KVM_DEBUG_GIC_MSI_SETUP    _IOW(KVMIO, 0xf0, struct kvm_debug_gic_msi_setup)
+
+struct kvm_debug_gic_msi_setup {
+	__u32 device_id;
+	__u32 event_id;
+	__u32 vcpu_id;
+	__u32 vintid;
+	__u32 host_irq;
+	__u64 itt_addr;
+};
+
 #define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE    (1 << 0)
 #define KVM_DIRTY_LOG_INITIALLY_SET            (1 << 1)
 
diff --git a/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c b/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
index fc4fe52fb6f8..8350665d9bdc 100644
--- a/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
+++ b/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
@@ -18,10 +18,14 @@
 #include "ucall.h"
 #include "vgic.h"
 
+#define KVM_DEBUG_GIC_MSI_SETUP    _IOW(KVMIO, 0xf0, struct kvm_debug_gic_msi_setup)
+
 #define TEST_MEMSLOT_INDEX	1
 
 #define GIC_LPI_OFFSET	8192
 
+static bool vlpi_enabled;
+
 static size_t nr_iterations = 1000;
 static vm_paddr_t gpa_base;
 
@@ -220,6 +224,21 @@ static void setup_gic(void)
 	its_fd = vgic_its_setup(vm);
 }
 
+static int enable_msi_vlpi_injection(u32 device_id, u32 event_id,
+		u32 vcpu_id, u32 vintid, u32 host_irq)
+{
+	struct kvm_debug_gic_msi_setup params = {
+		.device_id	= device_id,
+		.event_id	= event_id,
+		.vcpu_id	= vcpu_id,
+		.vintid		= vintid,
+		.host_irq	= host_irq,
+		.itt_addr	= test_data.itt_tables + (device_id * SZ_64K)
+	};
+
+	return __vm_ioctl(vm, KVM_DEBUG_GIC_MSI_SETUP, &params);
+}
+
 static void signal_lpi(u32 device_id, u32 event_id)
 {
 	vm_paddr_t db_addr = GITS_BASE_GPA + GITS_TRANSLATER;
@@ -267,6 +286,30 @@ static void *vcpu_worker_thread(void *data)
 
 		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_SYNC:
+			/* if flag is set, set direct injection mappings for MSIs */
+			if (vlpi_enabled) {
+				u32 intid = GIC_LPI_OFFSET;
+
+				for (u32 device_id = 0; device_id < test_data.nr_devices;
+						device_id++) {
+					for (u32 event_id = 0; event_id < test_data.nr_event_ids;
+							event_id++) {
+
+						/* we mock host_irqs in the SPI interrupt range of
+						 * 100-1020 since selftest guests have no hardware
+						 * devices
+						 */
+						int ret = enable_msi_vlpi_injection(device_id,
+								event_id, vcpu->id, intid,
+								intid - GIC_LPI_OFFSET + 100);
+						TEST_ASSERT(ret == 0, "KVM_DEBUG_GIC_MSI_SETUP failed: %d",
+								ret);
+
+						intid++;
+					}
+				}
+			}
+
 			pthread_barrier_wait(&test_setup_barrier);
 			continue;
 		case UCALL_DONE:
@@ -362,7 +405,9 @@ static void destroy_vm(void)
 
 static void pr_usage(const char *name)
 {
-	pr_info("%s [-v NR_VCPUS] [-d NR_DEVICES] [-e NR_EVENTS] [-i ITERS] -h\n", name);
+	pr_info("%s -D [-v NR_VCPUS] [-d NR_DEVICES] [-e NR_EVENTS] [-i ITERS] -h\n", name);
+	pr_info("  -D:\tenable direct vLPI injection (default: %s)\n",
+			vlpi_enabled ? "true" : "false");
 	pr_info("  -v:\tnumber of vCPUs (default: %u)\n", test_data.nr_cpus);
 	pr_info("  -d:\tnumber of devices (default: %u)\n", test_data.nr_devices);
 	pr_info("  -e:\tnumber of event IDs per device (default: %u)\n", test_data.nr_event_ids);
@@ -374,8 +419,11 @@ int main(int argc, char **argv)
 	u32 nr_threads;
 	int c;
 
-	while ((c = getopt(argc, argv, "hv:d:e:i:")) != -1) {
+	while ((c = getopt(argc, argv, "hDv:d:e:i:")) != -1) {
 		switch (c) {
+		case 'D':
+			vlpi_enabled = true;
+			break;
 		case 'v':
 			test_data.nr_cpus = atoi(optarg);
 			break;
-- 
2.50.1 (Apple Git-155)




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


