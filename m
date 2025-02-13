Return-Path: <linux-kselftest+bounces-26570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0484A34D26
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 19:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9565E18913E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 18:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420E12661BE;
	Thu, 13 Feb 2025 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IstzK9uA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A3324A064
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469924; cv=none; b=P73GRYdAENiJ6TNOxTs4HQ+MEX4kz7DoV6UlD84ggESuwrRNth6a4LGCgq+NLwr9KnaMCm6lJIaTycxoSVMDC0KwSwalxe+vh2WlaLzThht+NPJHxu4HWL+cT8W1PlXn3ZuR0iwAPD5RFtV2qjGjj81FwzbDAFNbZy5ojP0111I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469924; c=relaxed/simple;
	bh=iFb3vI6xg7ULYhoaGRt62WDBS1TA1FuG9OShl7kqlL8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aS/zLqkajX+IZaTtWOztWAIS0eIrr4rpzxfxkFjbpye6UogcfYyRiKc1IySyX8V0fVVCe+ea+zwH5kbEj/3VqCLRL7Bfd1WXCJSy7qlQF4DqjuaO+oJzP+P3XoPAUbQiMEhS3a4HfGkIFscDGh2hN8esQYLzhUNA/FSSfdq3PrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IstzK9uA; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3d0225c44e8so19114455ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 10:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739469919; x=1740074719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u6na+eCYg0NfIy6aKMDvVOaHNdp5PmbIPokYL0JsyU0=;
        b=IstzK9uAdTL/SeI6kJMjcOPYeSBPD8tFhEfayQjlkA/s/GPM79BY0dKXEskjvs1HvO
         Vbt5J/useWh/igdHVE7YEoV3toNfnZEamJPT2p90NRT+hQuwMhk5VFICpekTwdW5saH7
         MhfnjgzkG/SrSG/np84w5CdSk26F2fdKEERa52MtjgEMly6Fm51PKEfNvuwj51Hzs+co
         774pgalcBZDcalhctUNrDVTZlFMQH8Nl2HnJpg+1whIlhNRAIa6qgbrQB08fndFN/oPJ
         SOu7aohm+hI8aJZ32+alhMLler2AwF+O3yqyRe3x8IQYgBLH4DW1rtmHBV0E/eYsG7iD
         CMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469919; x=1740074719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6na+eCYg0NfIy6aKMDvVOaHNdp5PmbIPokYL0JsyU0=;
        b=EnfK+8C4E3o4qDr/K4RAxIcYHbEGzEu03ZTZ5BHxdI9NN7g1nV5p6Wb6UxmghNKUF3
         b9pDtQvbJKJFMVzQkG1U/qNYQVPfbzfoPGTPhODZjFekKzP6HqSLeCVx2o2LdVGBZyhH
         8F+ik3UV5kwgKTBCTbvzQ+S1fZwj8jYU3iCCJcJZhfdIjIQPk//Zf7Ff++YM+MoMHW7a
         /8HPsyZBuFQvmtlOWwUEZgP9sV7uQk8Zmcewh0isqviLm+kDLadhGNKJFo3Pg9bsSH23
         /tI6AKjKkaeu+mJnGMs+JaANJwMu73fzrDHfttBHNL68PMaC7iNW1M4EafFOmyV5Qe8s
         rSOg==
X-Forwarded-Encrypted: i=1; AJvYcCWgk6wQCp72mwBbVGMKoOImZpyY0wu/IAeD7WV22KpI/TcxLbe2FA13GoLgvLJku+9KBi9KAvJFNhVLsV2u8cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiHuVHFAOgU5Y9/PNjkWnlbInK9c644RayMfQN+TRTlhjzJwLu
	5EPFOoYRpucPL5EfaKvbc6sEiJ/9jMH6Z3t+ZMzdNHb14eU1nwdgS76eVWDnrNrJpM+EcbfvtTF
	iObAZpvICPKCHjj2iIseEbA==
X-Google-Smtp-Source: AGHT+IEGvMPNv9punkOtT5qLGj5LLSqe/+PtAvm9zNH0LcobbjbtEBjEaW8oMsWWW3Bw4goeK0R/WeUMIR1h2QWvjw==
X-Received: from ilbdb9.prod.google.com ([2002:a05:6e02:3d09:b0:3d1:79d2:7470])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:12c2:b0:3d0:25d0:8507 with SMTP id e9e14a558f8ab-3d18c22b0fbmr40676995ab.6.1739469919297;
 Thu, 13 Feb 2025 10:05:19 -0800 (PST)
Date: Thu, 13 Feb 2025 18:03:13 +0000
In-Reply-To: <20250213180317.3205285-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213180317.3205285-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213180317.3205285-5-coltonlewis@google.com>
Subject: [RFC PATCH v3 4/8] KVM: arm64: Reorganize PMU functions
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

A lot of functions in pmu-emul.c aren't specific to the emulated PMU
implementation. Move them to the more appropriate pmu.c file where
shared PMU functions should live.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/kvm_host.h |   1 +
 arch/arm64/kvm/pmu-emul.c         | 448 -----------------------------
 arch/arm64/kvm/pmu.c              | 450 ++++++++++++++++++++++++++++++
 3 files changed, 451 insertions(+), 448 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 80e5c09790b9..c419c1686418 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1623,6 +1623,7 @@ void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
 	} while (0)
 
 u8 kvm_arm_pmu_get_pmuver_limit(void);
+u32 kvm_pmu_event_mask(struct kvm *kvm);
 u64 kvm_pmu_evtyper_mask(struct kvm *kvm);
 int kvm_arm_set_default_pmu(struct kvm *kvm);
 u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm);
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 5bf9f582ca8d..faf69244d9ef 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -16,17 +16,10 @@
 
 #define PERF_ATTR_CFG1_COUNTER_64BIT	BIT(0)
 
-DEFINE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
-
-static LIST_HEAD(arm_pmus);
-static DEFINE_MUTEX(arm_pmus_lock);
-
 static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc);
 static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc);
 static bool kvm_pmu_counter_is_enabled(struct kvm_pmc *pmc);
 
-#define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >= VGIC_NR_SGIS)
-
 static struct kvm_vcpu *kvm_pmc_to_vcpu(const struct kvm_pmc *pmc)
 {
 	return container_of(pmc, struct kvm_vcpu, arch.pmu.pmc[pmc->idx]);
@@ -37,46 +30,6 @@ static struct kvm_pmc *kvm_vcpu_idx_to_pmc(struct kvm_vcpu *vcpu, int cnt_idx)
 	return &vcpu->arch.pmu.pmc[cnt_idx];
 }
 
-static u32 __kvm_pmu_event_mask(unsigned int pmuver)
-{
-	switch (pmuver) {
-	case ID_AA64DFR0_EL1_PMUVer_IMP:
-		return GENMASK(9, 0);
-	case ID_AA64DFR0_EL1_PMUVer_V3P1:
-	case ID_AA64DFR0_EL1_PMUVer_V3P4:
-	case ID_AA64DFR0_EL1_PMUVer_V3P5:
-	case ID_AA64DFR0_EL1_PMUVer_V3P7:
-		return GENMASK(15, 0);
-	default:		/* Shouldn't be here, just for sanity */
-		WARN_ONCE(1, "Unknown PMU version %d\n", pmuver);
-		return 0;
-	}
-}
-
-static u32 kvm_pmu_event_mask(struct kvm *kvm)
-{
-	u64 dfr0 = kvm_read_vm_id_reg(kvm, SYS_ID_AA64DFR0_EL1);
-	u8 pmuver = SYS_FIELD_GET(ID_AA64DFR0_EL1, PMUVer, dfr0);
-
-	return __kvm_pmu_event_mask(pmuver);
-}
-
-u64 kvm_pmu_evtyper_mask(struct kvm *kvm)
-{
-	u64 mask = ARMV8_PMU_EXCLUDE_EL1 | ARMV8_PMU_EXCLUDE_EL0 |
-		   kvm_pmu_event_mask(kvm);
-
-	if (kvm_has_feat(kvm, ID_AA64PFR0_EL1, EL2, IMP))
-		mask |= ARMV8_PMU_INCLUDE_EL2;
-
-	if (kvm_has_feat(kvm, ID_AA64PFR0_EL1, EL3, IMP))
-		mask |= ARMV8_PMU_EXCLUDE_NS_EL0 |
-			ARMV8_PMU_EXCLUDE_NS_EL1 |
-			ARMV8_PMU_EXCLUDE_EL3;
-
-	return mask;
-}
-
 /**
  * kvm_pmc_is_64bit - determine if counter is 64bit
  * @pmc: counter context
@@ -467,19 +420,6 @@ void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu)
 	kvm_pmu_update_state(vcpu);
 }
 
-/*
- * When perf interrupt is an NMI, we cannot safely notify the vcpu corresponding
- * to the event.
- * This is why we need a callback to do it once outside of the NMI context.
- */
-static void kvm_pmu_perf_overflow_notify_vcpu(struct irq_work *work)
-{
-	struct kvm_vcpu *vcpu;
-
-	vcpu = container_of(work, struct kvm_vcpu, arch.pmu.overflow_work);
-	kvm_vcpu_kick(vcpu);
-}
-
 /*
  * Perform an increment on any of the counters described in @mask,
  * generating the overflow if required, and propagate it as a chained
@@ -776,78 +716,6 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
 	kvm_pmu_create_perf_event(pmc);
 }
 
-struct arm_pmu_entry {
-	struct list_head entry;
-	struct arm_pmu *arm_pmu;
-};
-
-void kvm_host_pmu_init(struct arm_pmu *pmu)
-{
-	struct arm_pmu_entry *entry;
-
-	/*
-	 * Check the sanitised PMU version for the system, as KVM does not
-	 * support implementations where PMUv3 exists on a subset of CPUs.
-	 */
-	if (!pmuv3_implemented(kvm_arm_pmu_get_pmuver_limit()))
-		return;
-
-	mutex_lock(&arm_pmus_lock);
-
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		goto out_unlock;
-
-	entry->arm_pmu = pmu;
-	list_add_tail(&entry->entry, &arm_pmus);
-
-	if (list_is_singular(&arm_pmus))
-		static_branch_enable(&kvm_arm_pmu_available);
-
-out_unlock:
-	mutex_unlock(&arm_pmus_lock);
-}
-
-static struct arm_pmu *kvm_pmu_probe_armpmu(void)
-{
-	struct arm_pmu *tmp, *pmu = NULL;
-	struct arm_pmu_entry *entry;
-	int cpu;
-
-	mutex_lock(&arm_pmus_lock);
-
-	/*
-	 * It is safe to use a stale cpu to iterate the list of PMUs so long as
-	 * the same value is used for the entirety of the loop. Given this, and
-	 * the fact that no percpu data is used for the lookup there is no need
-	 * to disable preemption.
-	 *
-	 * It is still necessary to get a valid cpu, though, to probe for the
-	 * default PMU instance as userspace is not required to specify a PMU
-	 * type. In order to uphold the preexisting behavior KVM selects the
-	 * PMU instance for the core during vcpu init. A dependent use
-	 * case would be a user with disdain of all things big.LITTLE that
-	 * affines the VMM to a particular cluster of cores.
-	 *
-	 * In any case, userspace should just do the sane thing and use the UAPI
-	 * to select a PMU type directly. But, be wary of the baggage being
-	 * carried here.
-	 */
-	cpu = raw_smp_processor_id();
-	list_for_each_entry(entry, &arm_pmus, entry) {
-		tmp = entry->arm_pmu;
-
-		if (cpumask_test_cpu(cpu, &tmp->supported_cpus)) {
-			pmu = tmp;
-			break;
-		}
-	}
-
-	mutex_unlock(&arm_pmus_lock);
-
-	return pmu;
-}
-
 u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1)
 {
 	unsigned long *bmap = vcpu->kvm->arch.pmu_filter;
@@ -904,322 +772,6 @@ void kvm_vcpu_reload_pmu(struct kvm_vcpu *vcpu)
 	kvm_pmu_reprogram_counter_mask(vcpu, mask);
 }
 
-int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)
-{
-	if (!kvm_vcpu_has_pmu(vcpu))
-		return 0;
-
-	if (!vcpu->arch.pmu.created)
-		return -EINVAL;
-
-	/*
-	 * A valid interrupt configuration for the PMU is either to have a
-	 * properly configured interrupt number and using an in-kernel
-	 * irqchip, or to not have an in-kernel GIC and not set an IRQ.
-	 */
-	if (irqchip_in_kernel(vcpu->kvm)) {
-		int irq = vcpu->arch.pmu.irq_num;
-		/*
-		 * If we are using an in-kernel vgic, at this point we know
-		 * the vgic will be initialized, so we can check the PMU irq
-		 * number against the dimensions of the vgic and make sure
-		 * it's valid.
-		 */
-		if (!irq_is_ppi(irq) && !vgic_valid_spi(vcpu->kvm, irq))
-			return -EINVAL;
-	} else if (kvm_arm_pmu_irq_initialized(vcpu)) {
-		   return -EINVAL;
-	}
-
-	/* One-off reload of the PMU on first run */
-	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
-
-	return 0;
-}
-
-static int kvm_arm_pmu_v3_init(struct kvm_vcpu *vcpu)
-{
-	if (irqchip_in_kernel(vcpu->kvm)) {
-		int ret;
-
-		/*
-		 * If using the PMU with an in-kernel virtual GIC
-		 * implementation, we require the GIC to be already
-		 * initialized when initializing the PMU.
-		 */
-		if (!vgic_initialized(vcpu->kvm))
-			return -ENODEV;
-
-		if (!kvm_arm_pmu_irq_initialized(vcpu))
-			return -ENXIO;
-
-		ret = kvm_vgic_set_owner(vcpu, vcpu->arch.pmu.irq_num,
-					 &vcpu->arch.pmu);
-		if (ret)
-			return ret;
-	}
-
-	init_irq_work(&vcpu->arch.pmu.overflow_work,
-		      kvm_pmu_perf_overflow_notify_vcpu);
-
-	vcpu->arch.pmu.created = true;
-	return 0;
-}
-
-/*
- * For one VM the interrupt type must be same for each vcpu.
- * As a PPI, the interrupt number is the same for all vcpus,
- * while as an SPI it must be a separate number per vcpu.
- */
-static bool pmu_irq_is_valid(struct kvm *kvm, int irq)
-{
-	unsigned long i;
-	struct kvm_vcpu *vcpu;
-
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		if (!kvm_arm_pmu_irq_initialized(vcpu))
-			continue;
-
-		if (irq_is_ppi(irq)) {
-			if (vcpu->arch.pmu.irq_num != irq)
-				return false;
-		} else {
-			if (vcpu->arch.pmu.irq_num == irq)
-				return false;
-		}
-	}
-
-	return true;
-}
-
-/**
- * kvm_arm_pmu_get_max_counters - Return the max number of PMU counters.
- * @kvm: The kvm pointer
- */
-u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
-{
-	struct arm_pmu *arm_pmu = kvm->arch.arm_pmu;
-
-	/*
-	 * The arm_pmu->cntr_mask considers the fixed counter(s) as well.
-	 * Ignore those and return only the general-purpose counters.
-	 */
-	return bitmap_weight(arm_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS);
-}
-
-static void kvm_arm_set_pmu(struct kvm *kvm, struct arm_pmu *arm_pmu)
-{
-	lockdep_assert_held(&kvm->arch.config_lock);
-
-	kvm->arch.arm_pmu = arm_pmu;
-	kvm->arch.pmcr_n = kvm_arm_pmu_get_max_counters(kvm);
-}
-
-/**
- * kvm_arm_set_default_pmu - No PMU set, get the default one.
- * @kvm: The kvm pointer
- *
- * The observant among you will notice that the supported_cpus
- * mask does not get updated for the default PMU even though it
- * is quite possible the selected instance supports only a
- * subset of cores in the system. This is intentional, and
- * upholds the preexisting behavior on heterogeneous systems
- * where vCPUs can be scheduled on any core but the guest
- * counters could stop working.
- */
-int kvm_arm_set_default_pmu(struct kvm *kvm)
-{
-	struct arm_pmu *arm_pmu = kvm_pmu_probe_armpmu();
-
-	if (!arm_pmu)
-		return -ENODEV;
-
-	kvm_arm_set_pmu(kvm, arm_pmu);
-	return 0;
-}
-
-static int kvm_arm_pmu_v3_set_pmu(struct kvm_vcpu *vcpu, int pmu_id)
-{
-	struct kvm *kvm = vcpu->kvm;
-	struct arm_pmu_entry *entry;
-	struct arm_pmu *arm_pmu;
-	int ret = -ENXIO;
-
-	lockdep_assert_held(&kvm->arch.config_lock);
-	mutex_lock(&arm_pmus_lock);
-
-	list_for_each_entry(entry, &arm_pmus, entry) {
-		arm_pmu = entry->arm_pmu;
-		if (arm_pmu->pmu.type == pmu_id) {
-			if (kvm_vm_has_ran_once(kvm) ||
-			    (kvm->arch.pmu_filter && kvm->arch.arm_pmu != arm_pmu)) {
-				ret = -EBUSY;
-				break;
-			}
-
-			kvm_arm_set_pmu(kvm, arm_pmu);
-			cpumask_copy(kvm->arch.supported_cpus, &arm_pmu->supported_cpus);
-			ret = 0;
-			break;
-		}
-	}
-
-	mutex_unlock(&arm_pmus_lock);
-	return ret;
-}
-
-int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
-{
-	struct kvm *kvm = vcpu->kvm;
-
-	lockdep_assert_held(&kvm->arch.config_lock);
-
-	if (!kvm_vcpu_has_pmu(vcpu))
-		return -ENODEV;
-
-	if (vcpu->arch.pmu.created)
-		return -EBUSY;
-
-	switch (attr->attr) {
-	case KVM_ARM_VCPU_PMU_V3_IRQ: {
-		int __user *uaddr = (int __user *)(long)attr->addr;
-		int irq;
-
-		if (!irqchip_in_kernel(kvm))
-			return -EINVAL;
-
-		if (get_user(irq, uaddr))
-			return -EFAULT;
-
-		/* The PMU overflow interrupt can be a PPI or a valid SPI. */
-		if (!(irq_is_ppi(irq) || irq_is_spi(irq)))
-			return -EINVAL;
-
-		if (!pmu_irq_is_valid(kvm, irq))
-			return -EINVAL;
-
-		if (kvm_arm_pmu_irq_initialized(vcpu))
-			return -EBUSY;
-
-		kvm_debug("Set kvm ARM PMU irq: %d\n", irq);
-		vcpu->arch.pmu.irq_num = irq;
-		return 0;
-	}
-	case KVM_ARM_VCPU_PMU_V3_FILTER: {
-		u8 pmuver = kvm_arm_pmu_get_pmuver_limit();
-		struct kvm_pmu_event_filter __user *uaddr;
-		struct kvm_pmu_event_filter filter;
-		int nr_events;
-
-		/*
-		 * Allow userspace to specify an event filter for the entire
-		 * event range supported by PMUVer of the hardware, rather
-		 * than the guest's PMUVer for KVM backward compatibility.
-		 */
-		nr_events = __kvm_pmu_event_mask(pmuver) + 1;
-
-		uaddr = (struct kvm_pmu_event_filter __user *)(long)attr->addr;
-
-		if (copy_from_user(&filter, uaddr, sizeof(filter)))
-			return -EFAULT;
-
-		if (((u32)filter.base_event + filter.nevents) > nr_events ||
-		    (filter.action != KVM_PMU_EVENT_ALLOW &&
-		     filter.action != KVM_PMU_EVENT_DENY))
-			return -EINVAL;
-
-		if (kvm_vm_has_ran_once(kvm))
-			return -EBUSY;
-
-		if (!kvm->arch.pmu_filter) {
-			kvm->arch.pmu_filter = bitmap_alloc(nr_events, GFP_KERNEL_ACCOUNT);
-			if (!kvm->arch.pmu_filter)
-				return -ENOMEM;
-
-			/*
-			 * The default depends on the first applied filter.
-			 * If it allows events, the default is to deny.
-			 * Conversely, if the first filter denies a set of
-			 * events, the default is to allow.
-			 */
-			if (filter.action == KVM_PMU_EVENT_ALLOW)
-				bitmap_zero(kvm->arch.pmu_filter, nr_events);
-			else
-				bitmap_fill(kvm->arch.pmu_filter, nr_events);
-		}
-
-		if (filter.action == KVM_PMU_EVENT_ALLOW)
-			bitmap_set(kvm->arch.pmu_filter, filter.base_event, filter.nevents);
-		else
-			bitmap_clear(kvm->arch.pmu_filter, filter.base_event, filter.nevents);
-
-		return 0;
-	}
-	case KVM_ARM_VCPU_PMU_V3_SET_PMU: {
-		int __user *uaddr = (int __user *)(long)attr->addr;
-		int pmu_id;
-
-		if (get_user(pmu_id, uaddr))
-			return -EFAULT;
-
-		return kvm_arm_pmu_v3_set_pmu(vcpu, pmu_id);
-	}
-	case KVM_ARM_VCPU_PMU_V3_INIT:
-		return kvm_arm_pmu_v3_init(vcpu);
-	}
-
-	return -ENXIO;
-}
-
-int kvm_arm_pmu_v3_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
-{
-	switch (attr->attr) {
-	case KVM_ARM_VCPU_PMU_V3_IRQ: {
-		int __user *uaddr = (int __user *)(long)attr->addr;
-		int irq;
-
-		if (!irqchip_in_kernel(vcpu->kvm))
-			return -EINVAL;
-
-		if (!kvm_vcpu_has_pmu(vcpu))
-			return -ENODEV;
-
-		if (!kvm_arm_pmu_irq_initialized(vcpu))
-			return -ENXIO;
-
-		irq = vcpu->arch.pmu.irq_num;
-		return put_user(irq, uaddr);
-	}
-	}
-
-	return -ENXIO;
-}
-
-int kvm_arm_pmu_v3_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
-{
-	switch (attr->attr) {
-	case KVM_ARM_VCPU_PMU_V3_IRQ:
-	case KVM_ARM_VCPU_PMU_V3_INIT:
-	case KVM_ARM_VCPU_PMU_V3_FILTER:
-	case KVM_ARM_VCPU_PMU_V3_SET_PMU:
-		if (kvm_vcpu_has_pmu(vcpu))
-			return 0;
-	}
-
-	return -ENXIO;
-}
-
-u8 kvm_arm_pmu_get_pmuver_limit(void)
-{
-	u64 tmp;
-
-	tmp = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
-	tmp = cpuid_feature_cap_perfmon_field(tmp,
-					      ID_AA64DFR0_EL1_PMUVer_SHIFT,
-					      ID_AA64DFR0_EL1_PMUVer_V3P5);
-	return FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), tmp);
-}
-
 /**
  * kvm_vcpu_read_pmcr - Read PMCR_EL0 register for the vCPU
  * @vcpu: The vcpu pointer
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 3affc9074d71..85b5cb432c4f 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -10,6 +10,17 @@
 
 #include <asm/kvm_pmu.h>
 
+#define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >= VGIC_NR_SGIS)
+
+struct arm_pmu_entry {
+	struct list_head entry;
+	struct arm_pmu *arm_pmu;
+};
+
+DEFINE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
+
+static LIST_HEAD(arm_pmus);
+static DEFINE_MUTEX(arm_pmus_lock);
 static DEFINE_PER_CPU(struct kvm_pmu_events, kvm_pmu_events);
 
 /*
@@ -211,3 +222,442 @@ void kvm_vcpu_pmu_resync_el0(void)
 
 	kvm_make_request(KVM_REQ_RESYNC_PMU_EL0, vcpu);
 }
+
+void kvm_host_pmu_init(struct arm_pmu *pmu)
+{
+	struct arm_pmu_entry *entry;
+
+	/*
+	 * Check the sanitised PMU version for the system, as KVM does not
+	 * support implementations where PMUv3 exists on a subset of CPUs.
+	 */
+	if (!pmuv3_implemented(kvm_arm_pmu_get_pmuver_limit()))
+		return;
+
+	mutex_lock(&arm_pmus_lock);
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		goto out_unlock;
+
+	entry->arm_pmu = pmu;
+	list_add_tail(&entry->entry, &arm_pmus);
+
+	if (list_is_singular(&arm_pmus))
+		static_branch_enable(&kvm_arm_pmu_available);
+
+out_unlock:
+	mutex_unlock(&arm_pmus_lock);
+}
+
+static struct arm_pmu *kvm_pmu_probe_armpmu(void)
+{
+	struct arm_pmu *tmp, *pmu = NULL;
+	struct arm_pmu_entry *entry;
+	int cpu;
+
+	mutex_lock(&arm_pmus_lock);
+
+	/*
+	 * It is safe to use a stale cpu to iterate the list of PMUs so long as
+	 * the same value is used for the entirety of the loop. Given this, and
+	 * the fact that no percpu data is used for the lookup there is no need
+	 * to disable preemption.
+	 *
+	 * It is still necessary to get a valid cpu, though, to probe for the
+	 * default PMU instance as userspace is not required to specify a PMU
+	 * type. In order to uphold the preexisting behavior KVM selects the
+	 * PMU instance for the core during vcpu init. A dependent use
+	 * case would be a user with disdain of all things big.LITTLE that
+	 * affines the VMM to a particular cluster of cores.
+	 *
+	 * In any case, userspace should just do the sane thing and use the UAPI
+	 * to select a PMU type directly. But, be wary of the baggage being
+	 * carried here.
+	 */
+	cpu = raw_smp_processor_id();
+	list_for_each_entry(entry, &arm_pmus, entry) {
+		tmp = entry->arm_pmu;
+
+		if (cpumask_test_cpu(cpu, &tmp->supported_cpus)) {
+			pmu = tmp;
+			break;
+		}
+	}
+
+	mutex_unlock(&arm_pmus_lock);
+
+	return pmu;
+}
+
+
+/**
+ * kvm_arm_pmu_get_max_counters - Return the max number of PMU counters.
+ * @kvm: The kvm pointer
+ */
+u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
+{
+	struct arm_pmu *arm_pmu = kvm->arch.arm_pmu;
+
+	/*
+	 * The arm_pmu->cntr_mask considers the fixed counter(s) as well.
+	 * Ignore those and return only the general-purpose counters.
+	 */
+	return bitmap_weight(arm_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS);
+}
+
+static void kvm_arm_set_pmu(struct kvm *kvm, struct arm_pmu *arm_pmu)
+{
+	lockdep_assert_held(&kvm->arch.config_lock);
+
+	kvm->arch.arm_pmu = arm_pmu;
+	kvm->arch.pmcr_n = kvm_arm_pmu_get_max_counters(kvm);
+}
+
+/**
+ * kvm_arm_set_default_pmu - No PMU set, get the default one.
+ * @kvm: The kvm pointer
+ *
+ * The observant among you will notice that the supported_cpus
+ * mask does not get updated for the default PMU even though it
+ * is quite possible the selected instance supports only a
+ * subset of cores in the system. This is intentional, and
+ * upholds the preexisting behavior on heterogeneous systems
+ * where vCPUs can be scheduled on any core but the guest
+ * counters could stop working.
+ */
+int kvm_arm_set_default_pmu(struct kvm *kvm)
+{
+	struct arm_pmu *arm_pmu = kvm_pmu_probe_armpmu();
+
+	if (!arm_pmu)
+		return -ENODEV;
+
+	kvm_arm_set_pmu(kvm, arm_pmu);
+	return 0;
+}
+
+static int kvm_arm_pmu_v3_set_pmu(struct kvm_vcpu *vcpu, int pmu_id)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct arm_pmu_entry *entry;
+	struct arm_pmu *arm_pmu;
+	int ret = -ENXIO;
+
+	lockdep_assert_held(&kvm->arch.config_lock);
+	mutex_lock(&arm_pmus_lock);
+
+	list_for_each_entry(entry, &arm_pmus, entry) {
+		arm_pmu = entry->arm_pmu;
+		if (arm_pmu->pmu.type == pmu_id) {
+			if (kvm_vm_has_ran_once(kvm) ||
+			    (kvm->arch.pmu_filter && kvm->arch.arm_pmu != arm_pmu)) {
+				ret = -EBUSY;
+				break;
+			}
+
+			kvm_arm_set_pmu(kvm, arm_pmu);
+			cpumask_copy(kvm->arch.supported_cpus, &arm_pmu->supported_cpus);
+			ret = 0;
+			break;
+		}
+	}
+
+	mutex_unlock(&arm_pmus_lock);
+	return ret;
+}
+
+
+/*
+ * For one VM the interrupt type must be same for each vcpu.
+ * As a PPI, the interrupt number is the same for all vcpus,
+ * while as an SPI it must be a separate number per vcpu.
+ */
+static bool pmu_irq_is_valid(struct kvm *kvm, int irq)
+{
+	unsigned long i;
+	struct kvm_vcpu *vcpu;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!kvm_arm_pmu_irq_initialized(vcpu))
+			continue;
+
+		if (irq_is_ppi(irq)) {
+			if (vcpu->arch.pmu.irq_num != irq)
+				return false;
+		} else {
+			if (vcpu->arch.pmu.irq_num == irq)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+/*
+ * When perf interrupt is an NMI, we cannot safely notify the vcpu corresponding
+ * to the event.
+ * This is why we need a callback to do it once outside of the NMI context.
+ */
+static void kvm_pmu_perf_overflow_notify_vcpu(struct irq_work *work)
+{
+	struct kvm_vcpu *vcpu;
+
+	vcpu = container_of(work, struct kvm_vcpu, arch.pmu.overflow_work);
+	kvm_vcpu_kick(vcpu);
+}
+
+static int kvm_arm_pmu_v3_init(struct kvm_vcpu *vcpu)
+{
+	if (irqchip_in_kernel(vcpu->kvm)) {
+		int ret;
+
+		/*
+		 * If using the PMU with an in-kernel virtual GIC
+		 * implementation, we require the GIC to be already
+		 * initialized when initializing the PMU.
+		 */
+		if (!vgic_initialized(vcpu->kvm))
+			return -ENODEV;
+
+		if (!kvm_arm_pmu_irq_initialized(vcpu))
+			return -ENXIO;
+
+		ret = kvm_vgic_set_owner(vcpu, vcpu->arch.pmu.irq_num,
+					 &vcpu->arch.pmu);
+		if (ret)
+			return ret;
+	}
+
+	init_irq_work(&vcpu->arch.pmu.overflow_work,
+		      kvm_pmu_perf_overflow_notify_vcpu);
+
+	vcpu->arch.pmu.created = true;
+	return 0;
+}
+
+int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)
+{
+	if (!kvm_vcpu_has_pmu(vcpu))
+		return 0;
+
+	if (!vcpu->arch.pmu.created)
+		return -EINVAL;
+
+	/*
+	 * A valid interrupt configuration for the PMU is either to have a
+	 * properly configured interrupt number and using an in-kernel
+	 * irqchip, or to not have an in-kernel GIC and not set an IRQ.
+	 */
+	if (irqchip_in_kernel(vcpu->kvm)) {
+		int irq = vcpu->arch.pmu.irq_num;
+		/*
+		 * If we are using an in-kernel vgic, at this point we know
+		 * the vgic will be initialized, so we can check the PMU irq
+		 * number against the dimensions of the vgic and make sure
+		 * it's valid.
+		 */
+		if (!irq_is_ppi(irq) && !vgic_valid_spi(vcpu->kvm, irq))
+			return -EINVAL;
+	} else if (kvm_arm_pmu_irq_initialized(vcpu)) {
+		return -EINVAL;
+	}
+
+	/* One-off reload of the PMU on first run */
+	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
+
+	return 0;
+}
+
+static u32 __kvm_pmu_event_mask(unsigned int pmuver)
+{
+	switch (pmuver) {
+	case ID_AA64DFR0_EL1_PMUVer_IMP:
+		return GENMASK(9, 0);
+	case ID_AA64DFR0_EL1_PMUVer_V3P1:
+	case ID_AA64DFR0_EL1_PMUVer_V3P4:
+	case ID_AA64DFR0_EL1_PMUVer_V3P5:
+	case ID_AA64DFR0_EL1_PMUVer_V3P7:
+		return GENMASK(15, 0);
+	default:		/* Shouldn't be here, just for sanity */
+		WARN_ONCE(1, "Unknown PMU version %d\n", pmuver);
+		return 0;
+	}
+}
+
+u32 kvm_pmu_event_mask(struct kvm *kvm)
+{
+	u64 dfr0 = kvm_read_vm_id_reg(kvm, SYS_ID_AA64DFR0_EL1);
+	u8 pmuver = SYS_FIELD_GET(ID_AA64DFR0_EL1, PMUVer, dfr0);
+
+	return __kvm_pmu_event_mask(pmuver);
+}
+
+u64 kvm_pmu_evtyper_mask(struct kvm *kvm)
+{
+	u64 mask = ARMV8_PMU_EXCLUDE_EL1 | ARMV8_PMU_EXCLUDE_EL0 |
+		   kvm_pmu_event_mask(kvm);
+
+	if (kvm_has_feat(kvm, ID_AA64PFR0_EL1, EL2, IMP))
+		mask |= ARMV8_PMU_INCLUDE_EL2;
+
+	if (kvm_has_feat(kvm, ID_AA64PFR0_EL1, EL3, IMP))
+		mask |= ARMV8_PMU_EXCLUDE_NS_EL0 |
+			ARMV8_PMU_EXCLUDE_NS_EL1 |
+			ARMV8_PMU_EXCLUDE_EL3;
+
+	return mask;
+}
+
+int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+{
+	struct kvm *kvm = vcpu->kvm;
+
+	lockdep_assert_held(&kvm->arch.config_lock);
+
+	if (!kvm_vcpu_has_pmu(vcpu))
+		return -ENODEV;
+
+	if (vcpu->arch.pmu.created)
+		return -EBUSY;
+
+	switch (attr->attr) {
+	case KVM_ARM_VCPU_PMU_V3_IRQ: {
+		int __user *uaddr = (int __user *)(long)attr->addr;
+		int irq;
+
+		if (!irqchip_in_kernel(kvm))
+			return -EINVAL;
+
+		if (get_user(irq, uaddr))
+			return -EFAULT;
+
+		/* The PMU overflow interrupt can be a PPI or a valid SPI. */
+		if (!(irq_is_ppi(irq) || irq_is_spi(irq)))
+			return -EINVAL;
+
+		if (!pmu_irq_is_valid(kvm, irq))
+			return -EINVAL;
+
+		if (kvm_arm_pmu_irq_initialized(vcpu))
+			return -EBUSY;
+
+		kvm_debug("Set kvm ARM PMU irq: %d\n", irq);
+		vcpu->arch.pmu.irq_num = irq;
+		return 0;
+	}
+	case KVM_ARM_VCPU_PMU_V3_FILTER: {
+		u8 pmuver = kvm_arm_pmu_get_pmuver_limit();
+		struct kvm_pmu_event_filter __user *uaddr;
+		struct kvm_pmu_event_filter filter;
+		int nr_events;
+
+		/*
+		 * Allow userspace to specify an event filter for the entire
+		 * event range supported by PMUVer of the hardware, rather
+		 * than the guest's PMUVer for KVM backward compatibility.
+		 */
+		nr_events = __kvm_pmu_event_mask(pmuver) + 1;
+
+		uaddr = (struct kvm_pmu_event_filter __user *)(long)attr->addr;
+
+		if (copy_from_user(&filter, uaddr, sizeof(filter)))
+			return -EFAULT;
+
+		if (((u32)filter.base_event + filter.nevents) > nr_events ||
+		    (filter.action != KVM_PMU_EVENT_ALLOW &&
+		     filter.action != KVM_PMU_EVENT_DENY))
+			return -EINVAL;
+
+		if (kvm_vm_has_ran_once(kvm))
+			return -EBUSY;
+
+		if (!kvm->arch.pmu_filter) {
+			kvm->arch.pmu_filter = bitmap_alloc(nr_events, GFP_KERNEL_ACCOUNT);
+			if (!kvm->arch.pmu_filter)
+				return -ENOMEM;
+
+			/*
+			 * The default depends on the first applied filter.
+			 * If it allows events, the default is to deny.
+			 * Conversely, if the first filter denies a set of
+			 * events, the default is to allow.
+			 */
+			if (filter.action == KVM_PMU_EVENT_ALLOW)
+				bitmap_zero(kvm->arch.pmu_filter, nr_events);
+			else
+				bitmap_fill(kvm->arch.pmu_filter, nr_events);
+		}
+
+		if (filter.action == KVM_PMU_EVENT_ALLOW)
+			bitmap_set(kvm->arch.pmu_filter, filter.base_event, filter.nevents);
+		else
+			bitmap_clear(kvm->arch.pmu_filter, filter.base_event, filter.nevents);
+
+		return 0;
+	}
+	case KVM_ARM_VCPU_PMU_V3_SET_PMU: {
+		int __user *uaddr = (int __user *)(long)attr->addr;
+		int pmu_id;
+
+		if (get_user(pmu_id, uaddr))
+			return -EFAULT;
+
+		return kvm_arm_pmu_v3_set_pmu(vcpu, pmu_id);
+	}
+	case KVM_ARM_VCPU_PMU_V3_INIT:
+		return kvm_arm_pmu_v3_init(vcpu);
+	}
+
+	return -ENXIO;
+}
+
+int kvm_arm_pmu_v3_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+{
+	switch (attr->attr) {
+	case KVM_ARM_VCPU_PMU_V3_IRQ: {
+		int __user *uaddr = (int __user *)(long)attr->addr;
+		int irq;
+
+		if (!irqchip_in_kernel(vcpu->kvm))
+			return -EINVAL;
+
+		if (!kvm_vcpu_has_pmu(vcpu))
+			return -ENODEV;
+
+		if (!kvm_arm_pmu_irq_initialized(vcpu))
+			return -ENXIO;
+
+		irq = vcpu->arch.pmu.irq_num;
+		return put_user(irq, uaddr);
+	}
+	}
+
+	return -ENXIO;
+}
+
+
+int kvm_arm_pmu_v3_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+{
+	switch (attr->attr) {
+	case KVM_ARM_VCPU_PMU_V3_IRQ:
+	case KVM_ARM_VCPU_PMU_V3_INIT:
+	case KVM_ARM_VCPU_PMU_V3_FILTER:
+	case KVM_ARM_VCPU_PMU_V3_SET_PMU:
+		if (kvm_vcpu_has_pmu(vcpu))
+			return 0;
+	}
+
+	return -ENXIO;
+}
+
+u8 kvm_arm_pmu_get_pmuver_limit(void)
+{
+	u64 tmp;
+
+	tmp = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
+	tmp = cpuid_feature_cap_perfmon_field(tmp,
+					      ID_AA64DFR0_EL1_PMUVer_SHIFT,
+					      ID_AA64DFR0_EL1_PMUVer_V3P5);
+	return FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), tmp);
+}
-- 
2.48.1.601.g30ceb7b040-goog


