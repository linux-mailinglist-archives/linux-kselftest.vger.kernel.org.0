Return-Path: <linux-kselftest+bounces-46116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D06C7480F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 15:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35B6E4F1F61
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334C62E92D0;
	Thu, 20 Nov 2025 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="CHm6LPSJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581A33321C8;
	Thu, 20 Nov 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647511; cv=none; b=MwYhpbjnyJiUAkhoiFFvso/cmfYrxB6cxLv+QL+YyovcEOCNI29SbcRIfsi6hJW1sbYeWh4l8o0q9KaLSn0D4zqAlMl9UmDFIuurfGLnChNxcbeYnni82XxSfrS6JQanRX/3YHUS8bNTOJ0PmKlR/Jm5+dg1AWiPvVLhiuulLSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647511; c=relaxed/simple;
	bh=cebWU+GEwdMEKL6CFiyaYdRvDay5Pv0gZG8/XRB3Q2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0lJ5eK98I6a3IENSfVoWPOb0HWyiccbikgWsFpSTUAJrcbp+BBiAps13RPX1w9Vc+uKlyEK7irKf95oSbajUFJvikmGtl4eW0C53Ghuu3ACXnLmQPq8aPOd2RS2VSeGf326grUn962j8HGYQr4kQLQiDE3ZXTzK+y9aUD6WOE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=CHm6LPSJ; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1763647508; x=1795183508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hz1ohn0RM5SsqB1Mr4dk8t6QnVmIi2dKkM7+OyizHFY=;
  b=CHm6LPSJwrQsv1uFCbmUkOXoOeIf23ZT2p2rriT2SWRzCOP3iEOReuBs
   wIuHeTHnAb2pPzUl0uT2ShoXrWk+5PNtkOkF1ZdUdQVCFkFFwDxOrurdu
   rcUV1vZOkzhKO/bl6/MhF7G+u/wzpq/i4oxXsqsObOFFwD8FMbWYF3v59
   R7I3O7UhTqgd1RTXnubkORyZ5VRUbgUMZ1N0KoRyUsq3hvTIUxgPi6EAQ
   jMbz3kfO32F5+usdaSdF6UJHu4mLh/fLgcbZ1uOHDyL/KuHrakeWEOS3q
   N0wT3p7Pc7cEDTRSqc21XMxSlLSlorFEf939HAIeWj5cf9YmPKQh/9PKP
   Q==;
X-CSE-ConnectionGUID: neARhyqwRqS3pyOms6MNSA==
X-CSE-MsgGUID: v7IU67G3T1KFvizQ5pMUvA==
X-IronPort-AV: E=Sophos;i="6.20,213,1758585600"; 
   d="scan'208";a="7431877"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 14:05:05 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:32160]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.156:2525] with esmtp (Farcaster)
 id a23fcc6d-c220-4c61-8375-4b4294981d52; Thu, 20 Nov 2025 14:05:05 +0000 (UTC)
X-Farcaster-Flow-ID: a23fcc6d-c220-4c61-8375-4b4294981d52
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 20 Nov 2025 14:05:04 +0000
Received: from amazon.com (10.1.213.15) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Thu, 20 Nov 2025
 14:05:02 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>, <oliver.upton@linux.dev>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<mdittgen@amazon.de>, <lilitj@amazon.de>, <sauravsc@amazon.de>,
	<nh-open-source@amazon.com>, Maximilian Dittgen <mdittgen@amazon.com>
Subject: [RFC PATCH 07/13] KVM: arm64: Implement vLPI DISABLE ioctl for per-vCPU vLPI Injection API
Date: Thu, 20 Nov 2025 15:02:56 +0100
Message-ID: <20251120140305.63515-8-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251120140305.63515-1-mdittgen@amazon.de>
References: <20251120140305.63515-1-mdittgen@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Implement kvm_vgic_disable_vcpu_vlpi(), which handles the
KVM_DISABLE_VCPU_VLPI ioctl to disable direct vLPI injection on a specific
vCPU. The function has two components: a call to vgic_v4_vcpu_teardown() and a
call to downgrade_existing_vlpis_to_lpis():

-   vgic_v4_vcpu_teardown() is the per-vCPU corrolary to vgic_v4_teardown()
    and frees all of the GIC structures a vCPU needs to handle LPI interrupts
    via direct injection. While vgic_v4_teardown operates on a per-VM basis,
    vgic_v4_vcpu_teardown() frees the IRQ, LPI domain, and fwnode of the single
    targeted vCPU. The domain free routine in this function frees the vPE
    table entry and virtual pending table fo the vCPU.

-   downgrade_existing_lpis_to_vlpis() iterates through all of the LPIs
    targeting the vCPU and tears down the hardware forwarding that
    processes them as vLPIs. Uses kvm_vgic_v4_unset_forwarding() to
    unmap direct injection.

Signed-off-by: Maximilian Dittgen <mdittgen@amazon.com>
---
 arch/arm64/kvm/arm.c               |  13 +++-
 arch/arm64/kvm/vgic/vgic-v4.c      | 105 ++++++++++++++++++++++++++---
 arch/arm64/kvm/vgic/vgic.h         |   2 +
 drivers/irqchip/irq-gic-v3-its.c   |   4 +-
 drivers/irqchip/irq-gic-v4.c       |  19 ++++++
 include/linux/irqchip/arm-gic-v4.h |   1 +
 6 files changed, 131 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 169860649bdd..180eaa4165e9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1964,8 +1964,17 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		return kvm_vgic_enable_vcpu_vlpi(vcpu);
 	}
 	case KVM_DISABLE_VCPU_VLPI: {
-		/* TODO: create ioctl handler function */
-		return -ENOSYS;
+		int vcpu_id;
+		struct kvm_vcpu *vcpu;
+
+		if (copy_from_user(&vcpu_id, argp, sizeof(vcpu_id)))
+			return -EFAULT;
+
+		vcpu = kvm_get_vcpu_by_id(kvm, vcpu_id);
+		if (!vcpu)
+			return -EINVAL;
+
+		return kvm_vgic_disable_vcpu_vlpi(vcpu);
 	}
 	case KVM_QUERY_VCPU_VLPI: {
 		int vcpu_id;
diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index 0affcfca17f0..39fababf2861 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -372,7 +372,7 @@ int vgic_v4_vcpu_init(struct kvm_vcpu *vcpu)
 		kvm_err("failed to allocate vcpu IRQ%d\n", irq);
 
 	if (ret)
-		vgic_v4_teardown(kvm);
+		vgic_v4_vcpu_teardown(vcpu);
 
 	return ret;
 }
@@ -384,7 +384,8 @@ int vgic_v4_vcpu_init(struct kvm_vcpu *vcpu)
 void vgic_v4_teardown(struct kvm *kvm)
 {
 	struct its_vm *its_vm = &kvm->arch.vgic.its_vm;
-	int i;
+	struct kvm_vcpu *vcpu;
+	unsigned long i;
 
 	lockdep_assert_held(&kvm->arch.config_lock);
 
@@ -395,7 +396,7 @@ void vgic_v4_teardown(struct kvm *kvm)
 		if (!its_vm->vpes[i])  /* Skip NULL vPEs */
 			continue;
 
-		struct kvm_vcpu *vcpu = kvm_get_vcpu(kvm, i);
+		vcpu = kvm_get_vcpu(kvm, i);
 		int irq = its_vm->vpes[i]->irq;
 
 		irq_clear_status_flags(irq, DB_IRQ_FLAGS);
@@ -403,14 +404,14 @@ void vgic_v4_teardown(struct kvm *kvm)
 	}
 
 #ifdef CONFIG_ARM_GIC_V3_PER_VCPU_VLPI
-	/*
-	 * TODO: Free the shared VM properties that remain necessary
-	 * in per-vCPU mode. Create separate teardown function
-	 * that operates on a per-vCPU basis.
-	 */
-
-	/* vPE properties table */
+	/* Free shared VM vPE properties table */
 	its_free_prop_table(its_vm->vprop_page);
+
+	/* Free remaining doorbell IRQs */
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (its_vm->vpes[i])
+			its_free_vcpu_irq(vcpu);
+	}
 #else
 	its_free_vcpu_irqs(its_vm);
 #endif
@@ -419,6 +420,41 @@ void vgic_v4_teardown(struct kvm *kvm)
 	its_vm->vpes = NULL;
 }
 
+/**
+ * vgic_v4_vcpu_teardown - teardown the GICv4 data structures for a
+ * specific vCPU
+ * @vcpu:	Pointer to the vcpu being torn down
+ *
+ * Called every time the KVM_DISABLE_VCPU_VLPI ioctl is called.
+ */
+int vgic_v4_vcpu_teardown(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	int i, irq;
+
+	/* Get vCPU index */
+	i = kvm_idx_from_vcpu(kvm, vcpu);
+	/* On userspace to validate that vcpu has vLPIs enabled before calling ioctl */
+	if (i == UINT_MAX || !dist->its_vm.vpes || !dist->its_vm.vpes[i])
+		return -EINVAL;
+
+	irq = dist->its_vm.vpes[i]->irq;
+
+	/* Free the vPE IRQ */
+	irq_clear_status_flags(irq, DB_IRQ_FLAGS);
+	free_irq(irq, vcpu);
+
+
+	/* Free vCPU IRQ resources */
+	its_free_vcpu_irq(vcpu);
+
+	/* Unlink distributor from vPE - this officially "disables" vLPIs on the vCPU */
+	dist->its_vm.vpes[i] = NULL;
+
+	return 0;
+}
+
 static inline bool vgic_v4_want_doorbell(struct kvm_vcpu *vcpu)
 {
 	if (vcpu_get_flag(vcpu, IN_WFI))
@@ -744,6 +780,41 @@ static int upgrade_existing_lpis_to_vlpis(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int downgrade_existing_vlpis_to_lpis(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_device *dev;
+	struct vgic_its *its;
+	struct its_device *device;
+	struct its_ite *ite;
+
+	list_for_each_entry(dev, &kvm->devices, vm_node) {
+		/* Ensure we only look at ITS devices */
+		if (dev->ops != &kvm_arm_vgic_its_ops)
+			continue;
+
+		its = dev->private;
+		mutex_lock(&its->its_lock);
+
+		list_for_each_entry(device, &its->device_list, dev_list) {
+			list_for_each_entry(ite, &device->itt_head, ite_list) {
+				/* Only downgrade vLPIs targeting this vCPU */
+				if (ite->collection &&
+					ite->collection->target_addr == vcpu->vcpu_id &&
+					ite->irq && ite->irq->hw) {
+
+					/* Unmap direct injection */
+					kvm_vgic_v4_unset_forwarding(kvm, ite->irq->host_irq);
+				}
+			}
+		}
+
+		mutex_unlock(&its->its_lock);
+	}
+
+	return 0;
+}
+
 /* Enable vLPI direct injection on a specific vCPU */
 int kvm_vgic_enable_vcpu_vlpi(struct kvm_vcpu *vcpu)
 {
@@ -772,6 +843,20 @@ int kvm_vgic_enable_vcpu_vlpi(struct kvm_vcpu *vcpu)
 	return upgrade_existing_lpis_to_vlpis(vcpu);
 }
 
+/* Disable vLPI direct injection on a specific vCPU */
+int kvm_vgic_disable_vcpu_vlpi(struct kvm_vcpu *vcpu)
+{
+	int vcpu_vlpi_status = kvm_vgic_query_vcpu_vlpi(vcpu);
+
+	/* vGIC not initialized for vCPU or vLPI already disabled */
+	if (vcpu_vlpi_status <= 0)
+		return vcpu_vlpi_status;
+
+	downgrade_existing_vlpis_to_lpis(vcpu);
+
+	return vgic_v4_vcpu_teardown(vcpu);
+}
+
 /* query whether vLPI direct injection is enabled on a specific vCPU.
  * return 0 if disabled, 1 if enabled, -EINVAL if vCPU non-existant or GIC
  * uninitialized
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index 60ae0d1f044d..b16419eb9121 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -438,6 +438,7 @@ static inline bool vgic_supports_direct_irqs(struct kvm *kvm)
 int vgic_v4_init(struct kvm *kvm);
 int vgic_v4_vcpu_init(struct kvm_vcpu *vcpu);
 void vgic_v4_teardown(struct kvm *kvm);
+int vgic_v4_vcpu_teardown(struct kvm_vcpu *vcpu);
 void vgic_v4_configure_vsgis(struct kvm *kvm);
 void vgic_v4_get_vlpi_state(struct vgic_irq *irq, bool *val);
 int vgic_v4_request_vpe_irq(struct kvm_vcpu *vcpu, int irq);
@@ -472,6 +473,7 @@ void vgic_its_debug_destroy(struct kvm_device *dev);
 
 bool kvm_per_vcpu_vlpi_supported(void);
 int kvm_vgic_enable_vcpu_vlpi(struct kvm_vcpu *vcpu);
+int kvm_vgic_disable_vcpu_vlpi(struct kvm_vcpu *vcpu);
 int kvm_vgic_query_vcpu_vlpi(struct kvm_vcpu *vcpu);
 
 #endif
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 67749578f973..0e0778d61df2 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4600,7 +4600,9 @@ static void its_vpe_irq_domain_free(struct irq_domain *domain,
 				    unsigned int virq,
 				    unsigned int nr_irqs)
 {
+#ifndef CONFIG_ARM_GIC_V3_PER_VCPU_VLPI
 	struct its_vm *vm = domain->host_data;
+#endif
 	int i;
 
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
@@ -4610,11 +4612,11 @@ static void its_vpe_irq_domain_free(struct irq_domain *domain,
 								virq + i);
 		struct its_vpe *vpe = irq_data_get_irq_chip_data(data);
 
-		BUG_ON(vm != vpe->its_vm);
 
 #ifdef CONFIG_ARM_GIC_V3_PER_VCPU_VLPI
 		free_lpi_range(vpe->vpe_db_lpi, 1);
 #else
+		BUG_ON(vm != vpe->its_vm);
 		clear_bit(data->hwirq, vm->db_bitmap);
 #endif
 		its_vpe_teardown(vpe);
diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index c8e324cd8911..6fa0edd19659 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -270,6 +270,25 @@ void its_free_vcpu_irqs(struct its_vm *vm)
 	irq_domain_free_fwnode(vm->fwnode);
 }
 
+void its_free_vcpu_irq(struct kvm_vcpu *vcpu)
+{
+	struct its_vpe *vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
+	unsigned int irq = irq_find_mapping(vpe->lpi_domain, 0);
+
+	if (WARN_ON(!irq))
+		return;
+
+	irq_domain_free_irqs(irq, 1);
+	irq_domain_remove(vpe->lpi_domain);
+	irq_domain_free_fwnode(vpe->lpi_fwnode);
+
+	/* Reset vPE fields to prevent stale references during re-enablement */
+	vpe->its_vm = NULL;
+	vpe->irq = 0;
+	vpe->lpi_domain = NULL;
+	vpe->lpi_fwnode = NULL;
+}
+
 static int its_send_vpe_cmd(struct its_vpe *vpe, struct its_cmd_info *info)
 {
 	return irq_set_vcpu_affinity(vpe->irq, info);
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index bc493fed75ab..bd3e8de35147 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -146,6 +146,7 @@ struct its_cmd_info {
 int its_alloc_vcpu_irqs(struct its_vm *vm);
 int its_alloc_vcpu_irq(struct kvm_vcpu *vcpu);
 void its_free_vcpu_irqs(struct its_vm *vm);
+void its_free_vcpu_irq(struct kvm_vcpu *vcpu);
 int its_make_vpe_resident(struct its_vpe *vpe, bool g0en, bool g1en);
 int its_make_vpe_non_resident(struct its_vpe *vpe, bool db);
 int its_commit_vpe(struct its_vpe *vpe);
-- 
2.50.1 (Apple Git-155)




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


