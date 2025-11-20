Return-Path: <linux-kselftest+bounces-46110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25058C747E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 15:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 547344EC2AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4781D346A00;
	Thu, 20 Nov 2025 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="IJdkv13b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9E3469F6;
	Thu, 20 Nov 2025 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647432; cv=none; b=q0vLMHmZOrQMNl982tB1yoAYenEgCd0/oc61gkEbrHRL1fipqyaRFh89Ih/BJrYsRW8DdUqptsg0M3LqU4eTJd1H72G/a0xe8nCtqM1prkhnJEecBJAliOUSzfIJ/4Aeu4EiS1MCZYFFff/asPIFhIwj9kVtheMm86bVAUO293A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647432; c=relaxed/simple;
	bh=VRrDTNwlMDAPni1JKqLWNsh+TVOIBsDcGNwTufQ9FkY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KaLKoAmL1YavyzLMmBU7Cp80HSSfSS/AsVFyUMYJdLzV7dGXNUy4JIH4nDw3owICEsZS2dfluUQefyPqoITmoK9qmuDtQbsZcAiFKrMuTBPpXqJX1NihWFFkrVViwxVpVUKu3hjc2LcQJNWR7Sa2P1cdQxVadPEbzte5fyiojWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=IJdkv13b; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1763647430; x=1795183430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IgGVqWDaiFsLaVmBSmHNETcTk9tvvRTg96dWqNryNOM=;
  b=IJdkv13by9V/3hmTEwLN01vJ81UvtM/oUSeYaFLnGmoP+e6ZlGJhcH+6
   XXUluChGGpPCPAVTzHWaLSoVZb0XutcWV76sTrt/aiYytmGozZMSCrSpp
   jRt34r7F+P380ttdw07HYxlFzKLI7q5+BIUKxzpxFBaFLERWbDLS68YJh
   +yRXFwduHVVP/biAWcZ/sk2fqwfrcwsTJ1tmrFdzPvKtOoQrVmpO69X5R
   pGXpdrCzqIw7x1SXG/PTXvcGhP7AMcCDdjjoVTfZNAUkQmtOxVBUU4tEI
   y5ug2tuEwpxTs6Yh15psBzVl13oI+pmvOZowPLvPCz3IJcJIGctpEHu3w
   A==;
X-CSE-ConnectionGUID: bYjrAjY4Qb2r4ChUp8Uk4A==
X-CSE-MsgGUID: 1JH6fH9BTXiXpfyPoh37Jw==
X-IronPort-AV: E=Sophos;i="6.20,213,1758585600"; 
   d="scan'208";a="7442486"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 14:03:47 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:27411]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.1:2525] with esmtp (Farcaster)
 id 44d76809-b453-483f-8bcd-3638f5ce46f4; Thu, 20 Nov 2025 14:03:47 +0000 (UTC)
X-Farcaster-Flow-ID: 44d76809-b453-483f-8bcd-3638f5ce46f4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 20 Nov 2025 14:03:47 +0000
Received: from amazon.com (10.1.213.15) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Thu, 20 Nov 2025
 14:03:44 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>, <oliver.upton@linux.dev>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<mdittgen@amazon.de>, <lilitj@amazon.de>, <sauravsc@amazon.de>,
	<nh-open-source@amazon.com>
Subject: [RFC PATCH 02/13] KVM: arm64: Disable auto vCPU vPE assignment with per-vCPU vLPI config
Date: Thu, 20 Nov 2025 15:02:51 +0100
Message-ID: <20251120140305.63515-3-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251120140305.63515-1-mdittgen@amazon.de>
References: <20251120140305.63515-1-mdittgen@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The first step in implementing per-vCPU vLPI enablement ensuring
vCPUs are not automatically assigned vPEs upon GICv4 VM boot.
This is a) so that new VMs on a host do not selfishly grab all
available vPEs when existing VMs are resource sharing, and b) to not
crash hosts in which the number of launchable vCPUs can exceed the
number of vPEIDs available in hardware.

When CONFIG_ARM_GIC_V3_PER_VCPU_VLPI kconfig is enabled, skip vPE
initialization portion of vgic_v4_init routine. Note we continue to
allocate memory for an array of vPE pointers for future
initialization. This will allow us to easily track which vCPUs are
vLPI-enabled by simply null-checking the vpes[vcpu_id] entry.

Disable automatic kvm_vgic_v4_set_forwarding() upon PCI endpoint
configuration since vCPUs no longer have vPEs mapped by default.
Instead, store the host_irq mapping so set_forwarding() can be
called later upon per-vCPU vLPI enablement.

We must work towards modifying vPE allocation/freeing functions to
work on a vCPU rather than a VM level. This commit modifies vPE
unmap/map to function on a per-vCPU basis, and disables IRQ
allocation/freeing functionality for now since it is currently
implemented on a per-VM level. Per-vCPU IRQ allocation/freeing will
come in a later patch.

Signed-off-by: Maximilian Dittgen <mdittgen@amazon.de>
---
 arch/arm64/kvm/arm.c          |  6 ++++
 arch/arm64/kvm/vgic/vgic-v3.c | 12 ++++++--
 arch/arm64/kvm/vgic/vgic-v4.c | 55 ++++++++++++++++++++++++++++++++---
 include/kvm/arm_vgic.h        |  2 ++
 4 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 2839e11ba2c1..31db3ccb3296 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2798,8 +2798,14 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 	if (irq_entry->type != KVM_IRQ_ROUTING_MSI)
 		return 0;
 
+#ifndef CONFIG_ARM_GIC_V3_PER_VCPU_VLPI
 	return kvm_vgic_v4_set_forwarding(irqfd->kvm, prod->irq,
 					  &irqfd->irq_entry);
+#else
+	/* Set forwarding later, ad-hoc upon per-vCPU vLPI enable request */
+	return kvm_vgic_v4_map_irq_to_host(irqfd->kvm, prod->irq,
+					  &irqfd->irq_entry);
+#endif
 }
 
 void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 968aa9d89be6..842a3a50f3a2 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -566,8 +566,12 @@ static void unmap_all_vpes(struct kvm *kvm)
 	struct vgic_dist *dist = &kvm->arch.vgic;
 	int i;
 
-	for (i = 0; i < dist->its_vm.nr_vpes; i++)
+	for (i = 0; i < dist->its_vm.nr_vpes; i++) {
+		if (!dist->its_vm.vpes[i])  /* Skip uninitialized vPEs */
+			continue;
+
 		free_irq(dist->its_vm.vpes[i]->irq, kvm_get_vcpu(kvm, i));
+	}
 }
 
 static void map_all_vpes(struct kvm *kvm)
@@ -575,9 +579,13 @@ static void map_all_vpes(struct kvm *kvm)
 	struct vgic_dist *dist = &kvm->arch.vgic;
 	int i;
 
-	for (i = 0; i < dist->its_vm.nr_vpes; i++)
+	for (i = 0; i < dist->its_vm.nr_vpes; i++) {
+		if (!dist->its_vm.vpes[i])
+			continue;
+
 		WARN_ON(vgic_v4_request_vpe_irq(kvm_get_vcpu(kvm, i),
 						dist->its_vm.vpes[i]->irq));
+	}
 }
 
 /*
diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index 9ef12c33b3f7..fb2e6af96aa9 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -252,7 +252,7 @@ int vgic_v4_init(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
 	struct kvm_vcpu *vcpu;
-	int nr_vcpus, ret;
+	int nr_vcpus, ret = 0;
 	unsigned long i;
 
 	lockdep_assert_held(&kvm->arch.config_lock);
@@ -272,6 +272,7 @@ int vgic_v4_init(struct kvm *kvm)
 
 	dist->its_vm.nr_vpes = nr_vcpus;
 
+#ifndef CONFIG_ARM_GIC_V3_PER_VCPU_VLPI
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		dist->its_vm.vpes[i] = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
 
@@ -313,7 +314,12 @@ int vgic_v4_init(struct kvm *kvm)
 			break;
 		}
 	}
-
+#else
+	/*
+	 * TODO: Initialize the shared VM properties that remain necessary
+	 * in per-vCPU mode
+	 */
+#endif
 	if (ret)
 		vgic_v4_teardown(kvm);
 
@@ -335,6 +341,9 @@ void vgic_v4_teardown(struct kvm *kvm)
 		return;
 
 	for (i = 0; i < its_vm->nr_vpes; i++) {
+		if (!its_vm->vpes[i])  /* Skip NULL vPEs */
+			continue;
+
 		struct kvm_vcpu *vcpu = kvm_get_vcpu(kvm, i);
 		int irq = its_vm->vpes[i]->irq;
 
@@ -342,7 +351,15 @@ void vgic_v4_teardown(struct kvm *kvm)
 		free_irq(irq, vcpu);
 	}
 
+#ifdef CONFIG_ARM_GIC_V3_PER_VCPU_VLPI
+	/*
+	 * TODO: Free the shared VM properties that remain necessary
+	 * in per-vCPU mode. Create separate teardown function
+	 * that operates on a per-vCPU basis.
+	 */
+#else
 	its_free_vcpu_irqs(its_vm);
+#endif
 	kfree(its_vm->vpes);
 	its_vm->nr_vpes = 0;
 	its_vm->vpes = NULL;
@@ -368,7 +385,9 @@ int vgic_v4_put(struct kvm_vcpu *vcpu)
 {
 	struct its_vpe *vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
 
-	if (!vgic_supports_direct_irqs(vcpu->kvm) || !vpe->resident)
+	if (!vgic_supports_direct_irqs(vcpu->kvm) ||
+				!vpe->its_vm || /* check if vPE is initialized for vCPU */
+				!vpe->resident)
 		return 0;
 
 	return its_make_vpe_non_resident(vpe, vgic_v4_want_doorbell(vcpu));
@@ -379,7 +398,9 @@ int vgic_v4_load(struct kvm_vcpu *vcpu)
 	struct its_vpe *vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
 	int err;
 
-	if (!vgic_supports_direct_irqs(vcpu->kvm) || vpe->resident)
+	if (!vgic_supports_direct_irqs(vcpu->kvm) ||
+				!vpe->its_vm ||
+				vpe->resident)
 		return 0;
 
 	if (vcpu_get_flag(vcpu, IN_WFI))
@@ -414,6 +435,9 @@ void vgic_v4_commit(struct kvm_vcpu *vcpu)
 {
 	struct its_vpe *vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
 
+	if (!vpe->its_vm)
+		return;
+
 	/*
 	 * No need to wait for the vPE to be ready across a shallow guest
 	 * exit, as only a vcpu_put will invalidate it.
@@ -436,6 +460,29 @@ static struct vgic_its *vgic_get_its(struct kvm *kvm,
 	return vgic_msi_to_its(kvm, &msi);
 }
 
+/**
+ * Map an interrupt to a host IRQ without setting up hardware forwarding.
+ * Useful for defered vLPI enablement.
+ */
+int kvm_vgic_v4_map_irq_to_host(struct kvm *kvm, int virq,
+					struct kvm_kernel_irq_routing_entry *irq_entry)
+{
+	struct vgic_its *its;
+	struct vgic_irq *irq;
+
+	its = vgic_get_its(kvm, irq_entry);
+	if (IS_ERR(its))
+		return 0;
+
+	if (vgic_its_resolve_lpi(kvm, its, irq_entry->msi.devid,
+				 irq_entry->msi.data, &irq))
+		return 0;
+
+	irq->host_irq = virq;
+
+	return 0;
+}
+
 int kvm_vgic_v4_set_forwarding(struct kvm *kvm, int virq,
 			       struct kvm_kernel_irq_routing_entry *irq_entry)
 {
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index b261fb3968d0..02842754627f 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -450,6 +450,8 @@ int kvm_vgic_set_owner(struct kvm_vcpu *vcpu, unsigned int intid, void *owner);
 
 struct kvm_kernel_irq_routing_entry;
 
+int kvm_vgic_v4_map_irq_to_host(struct kvm *kvm, int virq,
+					struct kvm_kernel_irq_routing_entry *irq_entry);
 int kvm_vgic_v4_set_forwarding(struct kvm *kvm, int irq,
 			       struct kvm_kernel_irq_routing_entry *irq_entry);
 
-- 
2.50.1 (Apple Git-155)




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


