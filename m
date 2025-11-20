Return-Path: <linux-kselftest+bounces-46120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEE4C747C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 15:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC4F64ED018
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 14:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E7A3451AF;
	Thu, 20 Nov 2025 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="t5TtK+Dr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE0E33C1A2;
	Thu, 20 Nov 2025 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647571; cv=none; b=iJ9/4W13/XTLJYesI/D7IdkdpCLvJRDRqKCErQcY1jaF+p67fPansQxHjuXaFCR1OYJbbQHJOAUr0G9lu3VyB1ja3gh+LbowaWlynBVIaYG5mflKhJCvZ1YqulYdf4oYhV1K3K8G7UUdMlDDZTrevo/ozyRJkZbcFvPxFw7rnxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647571; c=relaxed/simple;
	bh=O57lVxD6E23tEN12351mNJi2L3hKTUNpMLxcJfdI4pU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNEHmm2Jagwrne3PGF1o6ZvZhffy9BC/WeRtmXFPwMI1qMtfXVdq3XlEhtFovIIk2eeiybqw7BjLPLasQUcOU2mbe0pzX6ZaJZlPGcjDIgMcqkL9/pJq+zfEGLlFDtgj9Qg0Ftgyyx4bEVXwe/YYeOnhGxV5FPk9C4YmhR5syrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=t5TtK+Dr; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1763647569; x=1795183569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hOYEUXbq/P3eNmO4MTKANd7oabWq13PZ2XL3+afH3WM=;
  b=t5TtK+DryytJA1E/4Q6Sqt0OKzGeiAkW24Zuz7H12s9839fVN8R296w+
   NRrdtR10c6hbt9HKmrce1X5xkI0qrxzT34TZK6OYPBHqAfgJDoqwGVFtA
   CTgl5n9z1NWbjtObVFqfpXgWZMKGstL+d5+mfeVusZud3r4S2gj/ihMda
   QcOlL8GBLMj1eWlFr+XQU+jZx+tryuw9AzfoXh1AgggRumTB4rJY9PNq/
   ufeparlCl77eQp0014hmmv4d6YVTRQKGMMVtBB3fCJlaGz92SFyKBzaa2
   P+fkE40tWVgw9tcae4wSiGXmDDoPEzOaVMUzPjJq0+KwraQ+8u8EXZwV8
   Q==;
X-CSE-ConnectionGUID: a1mK0HneSjOuePqoh0HOFA==
X-CSE-MsgGUID: hgxrk10SRWG0Rljxo+y4ng==
X-IronPort-AV: E=Sophos;i="6.20,213,1758585600"; 
   d="scan'208";a="7439097"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 14:06:06 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:3713]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.1:2525] with esmtp (Farcaster)
 id b13f35b6-e600-42b1-abb3-a386aa569b80; Thu, 20 Nov 2025 14:06:06 +0000 (UTC)
X-Farcaster-Flow-ID: b13f35b6-e600-42b1-abb3-a386aa569b80
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 20 Nov 2025 14:06:06 +0000
Received: from amazon.com (10.1.213.15) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Thu, 20 Nov 2025
 14:06:03 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>, <oliver.upton@linux.dev>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<mdittgen@amazon.de>, <lilitj@amazon.de>, <sauravsc@amazon.de>,
	<nh-open-source@amazon.com>
Subject: [RFC PATCH 11/13] KVM: Ioctl to set up userspace-injected MSIs as software-bypassing vLPIs
Date: Thu, 20 Nov 2025 15:03:00 +0100
Message-ID: <20251120140305.63515-12-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251120140305.63515-1-mdittgen@amazon.de>
References: <20251120140305.63515-1-mdittgen@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

At the moment, all MSIs injected from userspace using KVM_SIGNAL_MSI
are preempted by the hypervisor and handled by software. To properly
test GICv4 direct vLPI injection from KVM selftests, we write a
KVM_DEBUG_GIC_MSI_SETUP ioctl that manually creates an IRQ routing
table entry for the specified MSI, and populates ITS structures
(device, collection, and interrupt translation table entries) to map
the MSI to a vLPI. We then call GICv4 kvm_vgic_v4_set_forwarding to
let the vLPI bypass hypervisor traps and inject directly to the vCPU.

Signed-off-by: Maximilian Dittgen <mdittgen@amazon.de>
---
 arch/arm64/kvm/arm.c               |  34 +++++++
 arch/arm64/kvm/vgic/vgic-its.c     | 138 +++++++++++++++++++++++++++++
 arch/arm64/kvm/vgic/vgic.h         |   1 +
 include/linux/irqchip/arm-gic-v3.h |   1 +
 include/uapi/linux/kvm.h           |  15 ++++
 5 files changed, 189 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index c2224664f05e..ecc3c87889db 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -45,6 +45,8 @@
 #include <kvm/arm_pmu.h>
 #include <kvm/arm_psci.h>
 
+#include <vgic/vgic.h>
+
 #include "sys_regs.h"
 
 static enum kvm_mode kvm_mode = KVM_MODE_DEFAULT;
@@ -1992,6 +1994,38 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		guard(mutex)(&vcpu->arch.vgic_cpu.vlpi_toggle_mutex);
 		return kvm_vgic_query_vcpu_vlpi(vcpu);
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
+		vcpu = kvm_get_vcpu_by_id(kvm, params.vcpu_id);
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
index 5f3bbf24cc2f..a0d140ce35d1 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -2815,3 +2815,141 @@ int kvm_vgic_register_its_device(void)
 	return kvm_register_device_ops(&kvm_arm_vgic_its_ops,
 				       KVM_DEV_TYPE_ARM_VGIC_ITS);
 }
+
+static struct vgic_its *vgic_get_its(struct kvm *kvm,
+					struct kvm_kernel_irq_routing_entry *irq_entry)
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
+	/* Get target vCPU, validate it has a vPE for direct injection */
+	vcpu = kvm_get_vcpu(kvm, params->vcpu_id);
+	if (!vcpu)
+		return -EINVAL;
+	else if (!vcpu->arch.vgic_cpu.vgic_v3.its_vpe.its_vm)
+		return -ENXIO; /* vPE not currently enabled for this vCPU */
+
+	/*
+	 * Enable this vLPIs for this vCPU manually for testing, normally
+	 * done by guest writing GICR_CTLR
+	 */
+	atomic_set(&vcpu->arch.vgic_cpu.ctlr, GICR_CTLR_ENABLE_LPIS);
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
+	update_affinity_ite(kvm, ite);
+
+	/* Now that routing entry is initialized, call v4 forwarding setup */
+	ret = kvm_vgic_v4_set_forwarding_locked(kvm, host_irq, &entry, its);
+
+	mutex_unlock(&its->its_lock);
+	return ret;
+
+unlock:
+	mutex_unlock(&its->its_lock);
+	return ret;
+}
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index b16419eb9121..9f8be87e3294 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -475,5 +475,6 @@ bool kvm_per_vcpu_vlpi_supported(void);
 int kvm_vgic_enable_vcpu_vlpi(struct kvm_vcpu *vcpu);
 int kvm_vgic_disable_vcpu_vlpi(struct kvm_vcpu *vcpu);
 int kvm_vgic_query_vcpu_vlpi(struct kvm_vcpu *vcpu);
+int debug_gic_msi_setup_mock_msi(struct kvm *kvm, struct kvm_debug_gic_msi_setup *params);
 
 #endif
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 5031a4c25543..1ab1eb80e685 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -378,6 +378,7 @@
 #define GITS_CIDR3			0xfffc
 
 #define GITS_TRANSLATER			0x10040
+#define GITS_BASE_GPA           0x8000000ULL
 
 #define GITS_SGIR			0x20020
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 002fe0f4841d..057eb9e61ac8 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1457,6 +1457,21 @@ struct kvm_enc_region {
 #define KVM_DISABLE_VCPU_VLPI    _IOW(KVMIO, 0xf1, int)
 #define KVM_QUERY_VCPU_VLPI    _IOR(KVMIO, 0xf2, int)
 
+/*
+ * Generate an IRQ routing entry and vLPI tables for userspace-sourced
+ * MSI, enabling direct vLPI injection testing from selftests
+ */
+#define KVM_DEBUG_GIC_MSI_SETUP    _IOW(KVMIO, 0xf3, struct kvm_debug_gic_msi_setup)
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
 
-- 
2.50.1 (Apple Git-155)




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


