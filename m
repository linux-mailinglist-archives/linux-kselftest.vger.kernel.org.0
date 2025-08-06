Return-Path: <linux-kselftest+bounces-38362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1409B1C2F5
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 11:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176583A77D1
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 09:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AA928A415;
	Wed,  6 Aug 2025 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="lYQxS4IP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148C62853E9;
	Wed,  6 Aug 2025 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471478; cv=none; b=kMSISN79cB2ipllTCO6NgzG6+6kBMdM+Ydjg3V1GrNHMTb/OMFV/vtrMost5RTWZqmOnHzSKlmMjcVJB6QPm7FxQV1hZDZWlol8hv18ex7HUfAdbaRoGffAYggZOeZcFLDY6FjzrcIxxMsl1C4rfGS17U1+NMVRJGjG4viCw/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471478; c=relaxed/simple;
	bh=G9UnFnn6+N1dFhLmiqPujmp1vzCibeE+X65eGqXAjt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cJoR0gwVS3FvWJRhNLPLVnvKIW3tuPLHzolnBv6JOtUBzqF/3nu5upPcfaq9u4hkVDSJG+PNwU+BKdgc2K+3i5faSdtcGiMD/A8xpiQ0KQ1K76NBaVL9dKAU6e9WWIVhYgEpXXvWdIpcKM+W2g7BWghx9GPJ0+bzQQylwcqk1eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=lYQxS4IP reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5769A4Q4005818
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 6 Aug 2025 18:10:13 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=jp6X+VxMoEMmAuAS5cLVdqNBm2h3FpdSS1Z1PmhXMSY=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Date:Subject:Message-Id:To;
        s=rs20250326; t=1754471413; v=1;
        b=lYQxS4IPyexUi/gVxt1nDt9bRenjZ5At1ZO43zhwAMaKVs3gOCEsIMY3HJVSS7L5
         RojRSvj5wDv+XcSoj3znQOJgJmE9hK3WzdAy/qV8eWupHu5Y6HqMZhaz1rT/22CM
         odFJlcRtES7u1unQJEVHNK/rwEe1HtFm5Ba/iqd7nZBx000CyJ6phWz6e9IjC2iJ
         PTexV0R8s+l8O/OGsVFaJ1nclpdi2of2dUO4MfHKW11l9YxIyot/hUUCmIWWVSvi
         mRe8RkgOeZvxS6UpE/gL4/Jl7wawFOr/hBXUWE+3/Ku9V899d+fU91ccZOyZdNhq
         Yw6Q1G7NT441tv9wNoHbxQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 06 Aug 2025 18:09:54 +0900
Subject: [PATCH RFC v2 1/2] KVM: arm64: PMU: Introduce
 KVM_ARM_VCPU_PMU_V3_COMPOSITION
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-hybrid-v2-1-0661aec3af8c@rsg.ci.i.u-tokyo.ac.jp>
References: <20250806-hybrid-v2-0-0661aec3af8c@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250806-hybrid-v2-0-0661aec3af8c@rsg.ci.i.u-tokyo.ac.jp>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
        Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devel@daynix.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2

On heterogeneous arm64 systems, KVM's PMU emulation is based on the
features of a single host PMU instance. When a vCPU is migrated to a
pCPU with an incompatible PMU, counters such as PMCCNTR_EL0 stop
incrementing.

Although this behavior is permitted by the architecture, Windows does
not handle it gracefully and may crash with a division-by-zero error.

The current workaround requires VMMs to pin vCPUs to a set of pCPUs
that share a compatible PMU. This is difficult to implement correctly in
QEMU/libvirt, where pinning occurs after vCPU initialization, and it
also restricts the guest to a subset of available pCPUs.

This patch introduces the KVM_ARM_VCPU_PMU_V3_COMPOSITION attribute to
create a "composite" PMU. When set, KVM exposes a PMU that is compatible
with all pCPUs by advertising only a single cycle counter, a feature
common to all PMUs.

This allows Windows guests to run reliably on heterogeneous systems
without crashing, even without vCPU pinning, and enables VMMs to
schedule vCPUs across all available pCPUs, making full use of the host
hardware.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 Documentation/virt/kvm/devices/vcpu.rst |  30 ++
 arch/arm64/include/asm/kvm_host.h       |   2 +
 arch/arm64/include/uapi/asm/kvm.h       |   1 +
 arch/arm64/kvm/arm.c                    |   5 +-
 arch/arm64/kvm/pmu-emul.c               | 495 +++++++++++++++++++-------------
 arch/arm64/kvm/sys_regs.c               |   2 +-
 include/kvm/arm_pmu.h                   |  12 +-
 7 files changed, 343 insertions(+), 204 deletions(-)

diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index 60bf205cb3730c9d1c27f5cb72c920d1d886c9d9..f9f2a747cc2835954415af95f4b461c7d8c9d6e0 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -161,6 +161,36 @@ explicitly selected, or the number of counters is out of range for the
 selected PMU. Selecting a new PMU cancels the effect of setting this
 attribute.
 
+1.6 ATTRIBUTE: KVM_ARM_VCPU_PMU_V3_COMPOSITION
+----------------------------------------------
+
+:Parameters: no additional parameter in kvm_device_attr.addr
+
+:Returns:
+
+	 =======  =====================================================
+	 -EBUSY   Attempted to set after initializing PMUv3 or running
+		  VCPU, or attempted to set for the first time after
+		  setting an event filter
+	 -ENXIO   PMUv3 composition not supported or attempted to get
+		  before setting
+	 -ENODEV  Attempted to set while PMUv3 not supported
+	 =======  =========================================================
+
+If set, PMUv3 will be emulated by composing all the physical PMUs. This
+attribute is particularly useful on heterogeneous systems where there are at
+least two CPU PMUs on the system. The composite PMU will work on any physical
+CPUs but it only exposes one cycle counter. All VCPUs in a VM share this
+attribute. It isn't possible to set it for the first time if a PMU event filter
+is already present.
+
+Note that KVM will not make any attempts to run the VCPU on the physical CPUs
+with PMUs. This is entirely left to userspace. However, attempting to run the
+VCPU on a physical CPU without a PMU will fail and KVM_RUN will return with
+exit_reason = KVM_EXIT_FAIL_ENTRY and populate the fail_entry struct by setting
+hardare_entry_failure_reason field to KVM_EXIT_FAIL_ENTRY_CPU_UNSUPPORTED and
+the cpu field to the processor id.
+
 2. GROUP: KVM_ARM_VCPU_TIMER_CTRL
 =================================
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3e41a880b062396b03c5dc8ce53f12163862aee3..551c8718971324f07c4dac1632317e4eab40112f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -366,6 +366,8 @@ struct kvm_arch {
 
 	cpumask_var_t supported_cpus;
 
+	unsigned int nr_composed_host_pmus;
+
 	/* Maximum number of counters for the guest */
 	u8 nr_pmu_counters;
 
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index ed5f3892674c7df421265514ebdb1b23e12f3e14..b0516740fc9c5a88924bd598fec1b2c2dae4720b 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -436,6 +436,7 @@ enum {
 #define   KVM_ARM_VCPU_PMU_V3_FILTER		2
 #define   KVM_ARM_VCPU_PMU_V3_SET_PMU		3
 #define   KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS	4
+#define   KVM_ARM_VCPU_PMU_V3_COMPOSITION	5
 #define KVM_ARM_VCPU_TIMER_CTRL		1
 #define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
 #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 23dd3f3fc3ebf5cb8c03292aa28a373dc8f7478f..5e685c1f094dacb7fc5b532e2da094e84a482177 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -464,8 +464,6 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	/* Set up the timer */
 	kvm_timer_vcpu_init(vcpu);
 
-	kvm_pmu_vcpu_init(vcpu);
-
 	kvm_arm_pvtime_vcpu_init(&vcpu->arch);
 
 	vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
@@ -615,6 +613,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (has_vhe())
 		kvm_vcpu_load_vhe(vcpu);
 	kvm_arch_vcpu_load_fp(vcpu);
+	kvm_pmu_vcpu_load(vcpu);
 	kvm_vcpu_pmu_restore_guest(vcpu);
 	if (kvm_arm_is_pvtime_enabled(&vcpu->arch))
 		kvm_make_request(KVM_REQ_RECORD_STEAL, vcpu);
@@ -1498,7 +1497,7 @@ static int kvm_setup_vcpu(struct kvm_vcpu *vcpu)
 	 * When the vCPU has a PMU, but no PMU is set for the guest
 	 * yet, set the default one.
 	 */
-	if (kvm_vcpu_has_pmu(vcpu) && !kvm->arch.arm_pmu)
+	if (kvm_vcpu_has_pmu(vcpu) && !kvm->arch.arm_pmu && !kvm->arch.nr_composed_host_pmus)
 		ret = kvm_arm_set_default_pmu(kvm);
 
 	/* Prepare for nested if required */
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index b03dbda7f1ab995894c49b5cd37892c73dae819d..f825bbb2353f3b7a7d6a5c1511043b53f33db90c 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -20,9 +20,9 @@
 static LIST_HEAD(arm_pmus);
 static DEFINE_MUTEX(arm_pmus_lock);
 
-static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc);
-static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc);
-static bool kvm_pmu_counter_is_enabled(struct kvm_pmc *pmc);
+static void kvm_pmu_create_pmc(struct kvm_vcpu *vcpu, u8 idx);
+static void kvm_pmu_release_pmc(struct kvm_vcpu *vcpu, u8 idx);
+static bool kvm_pmu_counter_is_enabled(struct kvm_vcpu *vcpu, u8 idx);
 
 bool kvm_supports_guest_pmuv3(void)
 {
@@ -30,12 +30,12 @@ bool kvm_supports_guest_pmuv3(void)
 	return !list_empty(&arm_pmus);
 }
 
-static struct kvm_vcpu *kvm_pmc_to_vcpu(const struct kvm_pmc *pmc)
+static struct kvm_vcpu *kvm_pmc_to_vcpu(struct kvm_pmc * const *pmc)
 {
-	return container_of(pmc, struct kvm_vcpu, arch.pmu.pmc[pmc->idx]);
+	return container_of(pmc, struct kvm_vcpu, arch.pmu.pmc[(*pmc)->idx]);
 }
 
-static struct kvm_pmc *kvm_vcpu_idx_to_pmc(struct kvm_vcpu *vcpu, int cnt_idx)
+static struct kvm_pmc **kvm_vcpu_idx_to_pmc(struct kvm_vcpu *vcpu, int cnt_idx)
 {
 	return &vcpu->arch.pmu.pmc[cnt_idx];
 }
@@ -84,30 +84,27 @@ u64 kvm_pmu_evtyper_mask(struct kvm *kvm)
  * kvm_pmc_is_64bit - determine if counter is 64bit
  * @pmc: counter context
  */
-static bool kvm_pmc_is_64bit(struct kvm_pmc *pmc)
+static bool kvm_pmc_is_64bit(struct kvm_vcpu *vcpu, u8 idx)
 {
-	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
-
-	return (pmc->idx == ARMV8_PMU_CYCLE_IDX ||
+	return (idx == ARMV8_PMU_CYCLE_IDX ||
 		kvm_has_feat(vcpu->kvm, ID_AA64DFR0_EL1, PMUVer, V3P5));
 }
 
-static bool kvm_pmc_has_64bit_overflow(struct kvm_pmc *pmc)
+static bool kvm_pmc_has_64bit_overflow(struct kvm_vcpu *vcpu, u8 idx)
 {
-	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
 	u64 val = kvm_vcpu_read_pmcr(vcpu);
 
-	if (kvm_pmu_counter_is_hyp(vcpu, pmc->idx))
+	if (kvm_pmu_counter_is_hyp(vcpu, idx))
 		return __vcpu_sys_reg(vcpu, MDCR_EL2) & MDCR_EL2_HLP;
 
-	return (pmc->idx < ARMV8_PMU_CYCLE_IDX && (val & ARMV8_PMU_PMCR_LP)) ||
-	       (pmc->idx == ARMV8_PMU_CYCLE_IDX && (val & ARMV8_PMU_PMCR_LC));
+	return (idx < ARMV8_PMU_CYCLE_IDX && (val & ARMV8_PMU_PMCR_LP)) ||
+	       (idx == ARMV8_PMU_CYCLE_IDX && (val & ARMV8_PMU_PMCR_LC));
 }
 
-static bool kvm_pmu_counter_can_chain(struct kvm_pmc *pmc)
+static bool kvm_pmu_counter_can_chain(struct kvm_vcpu *vcpu, u8 idx)
 {
-	return (!(pmc->idx & 1) && (pmc->idx + 1) < ARMV8_PMU_CYCLE_IDX &&
-		!kvm_pmc_has_64bit_overflow(pmc));
+	return (!(idx & 1) && (idx + 1) < ARMV8_PMU_CYCLE_IDX &&
+		!kvm_pmc_has_64bit_overflow(vcpu, idx));
 }
 
 static u32 counter_index_to_reg(u64 idx)
@@ -120,28 +117,30 @@ static u32 counter_index_to_evtreg(u64 idx)
 	return (idx == ARMV8_PMU_CYCLE_IDX) ? PMCCFILTR_EL0 : PMEVTYPER0_EL0 + idx;
 }
 
-static u64 kvm_pmc_read_evtreg(const struct kvm_pmc *pmc)
+static u64 kvm_pmc_read_evtreg(const struct kvm_vcpu *vcpu, u8 idx)
 {
-	return __vcpu_sys_reg(kvm_pmc_to_vcpu(pmc), counter_index_to_evtreg(pmc->idx));
+	return __vcpu_sys_reg(vcpu, counter_index_to_evtreg(idx));
 }
 
-static u64 kvm_pmu_get_pmc_value(struct kvm_pmc *pmc)
+static u64 kvm_pmu_get_pmc_value(struct kvm_vcpu *vcpu, u8 idx)
 {
-	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
+	struct kvm_pmc *pmc = *kvm_vcpu_idx_to_pmc(vcpu, idx);
 	u64 counter, reg, enabled, running;
+	unsigned int i;
 
-	reg = counter_index_to_reg(pmc->idx);
+	reg = counter_index_to_reg(idx);
 	counter = __vcpu_sys_reg(vcpu, reg);
 
 	/*
 	 * The real counter value is equal to the value of counter register plus
 	 * the value perf event counts.
 	 */
-	if (pmc->perf_event)
-		counter += perf_event_read_value(pmc->perf_event, &enabled,
-						 &running);
+	if (pmc)
+		for (i = 0; i < pmc->nr_perf_events; i++)
+			counter += perf_event_read_value(pmc->perf_events[i],
+							 &enabled, &running);
 
-	if (!kvm_pmc_is_64bit(pmc))
+	if (!kvm_pmc_is_64bit(vcpu, idx))
 		counter = lower_32_bits(counter);
 
 	return counter;
@@ -154,20 +153,16 @@ static u64 kvm_pmu_get_pmc_value(struct kvm_pmc *pmc)
  */
 u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
 {
-	return kvm_pmu_get_pmc_value(kvm_vcpu_idx_to_pmc(vcpu, select_idx));
+	return kvm_pmu_get_pmc_value(vcpu, select_idx);
 }
 
-static void kvm_pmu_set_pmc_value(struct kvm_pmc *pmc, u64 val, bool force)
+static void kvm_pmu_set_pmc_value(struct kvm_vcpu *vcpu, u8 idx, u64 val, bool force)
 {
-	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
 	u64 reg;
 
-	kvm_pmu_release_perf_event(pmc);
-
-	reg = counter_index_to_reg(pmc->idx);
+	reg = counter_index_to_reg(idx);
 
-	if (vcpu_mode_is_32bit(vcpu) && pmc->idx != ARMV8_PMU_CYCLE_IDX &&
-	    !force) {
+	if (vcpu_mode_is_32bit(vcpu) && idx != ARMV8_PMU_CYCLE_IDX && !force) {
 		/*
 		 * Even with PMUv3p5, AArch32 cannot write to the top
 		 * 32bit of the counters. The only possible course of
@@ -178,10 +173,10 @@ static void kvm_pmu_set_pmc_value(struct kvm_pmc *pmc, u64 val, bool force)
 		val |= lower_32_bits(val);
 	}
 
+	val -= kvm_pmu_get_pmc_value(vcpu, idx) - __vcpu_sys_reg(vcpu, reg);
 	__vcpu_assign_sys_reg(vcpu, reg, val);
 
-	/* Recreate the perf event to reflect the updated sample_period */
-	kvm_pmu_create_perf_event(pmc);
+	vcpu->arch.pmu.reset_sample_period = true;
 }
 
 /**
@@ -192,32 +187,26 @@ static void kvm_pmu_set_pmc_value(struct kvm_pmc *pmc, u64 val, bool force)
  */
 void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
 {
-	kvm_pmu_set_pmc_value(kvm_vcpu_idx_to_pmc(vcpu, select_idx), val, false);
-}
-
-/**
- * kvm_pmu_set_counter_value_user - set PMU counter value from user
- * @vcpu: The vcpu pointer
- * @select_idx: The counter index
- * @val: The counter value
- */
-void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
-{
-	kvm_pmu_release_perf_event(kvm_vcpu_idx_to_pmc(vcpu, select_idx));
-	__vcpu_assign_sys_reg(vcpu, counter_index_to_reg(select_idx), val);
-	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
+	kvm_pmu_set_pmc_value(vcpu, select_idx, val, false);
 }
 
 /**
- * kvm_pmu_release_perf_event - remove the perf event
+ * kvm_pmu_release_pmc - remove the pmc
  * @pmc: The PMU counter pointer
  */
-static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc)
+static void kvm_pmu_release_pmc(struct kvm_vcpu *vcpu, u8 idx)
 {
-	if (pmc->perf_event) {
-		perf_event_disable(pmc->perf_event);
-		perf_event_release_kernel(pmc->perf_event);
-		pmc->perf_event = NULL;
+	struct kvm_pmc **pmc = kvm_vcpu_idx_to_pmc(vcpu, idx);
+	unsigned int i;
+
+	if (*pmc) {
+		for (i = 0; i < (*pmc)->nr_perf_events; i++) {
+			perf_event_disable((*pmc)->perf_events[i]);
+			perf_event_release_kernel((*pmc)->perf_events[i]);
+		}
+
+		kfree(*pmc);
+		*pmc = NULL;
 	}
 }
 
@@ -227,35 +216,27 @@ static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc)
  *
  * If this counter has been configured to monitor some event, release it here.
  */
-static void kvm_pmu_stop_counter(struct kvm_pmc *pmc)
+static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, u8 idx)
 {
-	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
 	u64 reg, val;
 
-	if (!pmc->perf_event)
-		return;
-
-	val = kvm_pmu_get_pmc_value(pmc);
+	val = kvm_pmu_get_pmc_value(vcpu, idx);
 
-	reg = counter_index_to_reg(pmc->idx);
+	reg = counter_index_to_reg(idx);
 
 	__vcpu_assign_sys_reg(vcpu, reg, val);
 
-	kvm_pmu_release_perf_event(pmc);
+	kvm_pmu_release_pmc(vcpu, idx);
 }
 
 /**
- * kvm_pmu_vcpu_init - assign pmu counter idx for cpu
+ * kvm_pmu_vcpu_load - Request loading PMU state for cpu
  * @vcpu: The vcpu pointer
- *
  */
-void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu)
+void kvm_pmu_vcpu_load(struct kvm_vcpu *vcpu)
 {
-	int i;
-	struct kvm_pmu *pmu = &vcpu->arch.pmu;
-
-	for (i = 0; i < KVM_ARMV8_PMU_MAX_COUNTERS; i++)
-		pmu->pmc[i].idx = i;
+	if (unlikely(vcpu->kvm->arch.nr_composed_host_pmus))
+		vcpu->arch.pmu.reset_sample_period = true;
 }
 
 /**
@@ -268,7 +249,7 @@ void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu)
 	int i;
 
 	for (i = 0; i < KVM_ARMV8_PMU_MAX_COUNTERS; i++)
-		kvm_pmu_release_perf_event(kvm_vcpu_idx_to_pmc(vcpu, i));
+		kvm_pmu_release_pmc(vcpu, i);
 	irq_work_sync(&vcpu->arch.pmu.overflow_work);
 }
 
@@ -325,22 +306,45 @@ u64 kvm_pmu_implemented_counter_mask(struct kvm_vcpu *vcpu)
 		return GENMASK(val - 1, 0) | BIT(ARMV8_PMU_CYCLE_IDX);
 }
 
-static void kvm_pmc_enable_perf_event(struct kvm_pmc *pmc)
+static u64 kvm_pmu_enabled_counter_mask(struct kvm_vcpu *vcpu)
 {
-	if (!pmc->perf_event) {
-		kvm_pmu_create_perf_event(pmc);
+	u64 mask = 0;
+
+	if (__vcpu_sys_reg(vcpu, MDCR_EL2) & MDCR_EL2_HPME)
+		mask |= kvm_pmu_hyp_counter_mask(vcpu);
+
+	if (kvm_vcpu_read_pmcr(vcpu) & ARMV8_PMU_PMCR_E)
+		mask |= ~kvm_pmu_hyp_counter_mask(vcpu);
+
+	return kvm_pmu_implemented_counter_mask(vcpu) &
+	       __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask;
+}
+
+static void kvm_pmc_enable_perf_event(struct kvm_vcpu *vcpu, u8 idx)
+{
+	struct kvm_pmc *pmc = *kvm_vcpu_idx_to_pmc(vcpu, idx);
+	unsigned int i;
+
+	if (!pmc) {
+		kvm_pmu_create_pmc(vcpu, idx);
 		return;
 	}
 
-	perf_event_enable(pmc->perf_event);
-	if (pmc->perf_event->state != PERF_EVENT_STATE_ACTIVE)
-		kvm_debug("fail to enable perf event\n");
+	for (i = 0; i < pmc->nr_perf_events; i++) {
+		perf_event_enable(pmc->perf_events[i]);
+		if (pmc->perf_events[i]->state != PERF_EVENT_STATE_ACTIVE)
+			kvm_debug("fail to enable perf event\n");
+	}
 }
 
-static void kvm_pmc_disable_perf_event(struct kvm_pmc *pmc)
+static void kvm_pmc_disable_perf_event(struct kvm_vcpu *vcpu, u8 idx)
 {
-	if (pmc->perf_event)
-		perf_event_disable(pmc->perf_event);
+	struct kvm_pmc *pmc = *kvm_vcpu_idx_to_pmc(vcpu, idx);
+	unsigned int i;
+
+	if (pmc)
+		for (i = 0; i < pmc->nr_perf_events; i++)
+			perf_event_disable(pmc->perf_events[i]);
 }
 
 void kvm_pmu_reprogram_counter_mask(struct kvm_vcpu *vcpu, u64 val)
@@ -351,17 +355,16 @@ void kvm_pmu_reprogram_counter_mask(struct kvm_vcpu *vcpu, u64 val)
 		return;
 
 	for (i = 0; i < KVM_ARMV8_PMU_MAX_COUNTERS; i++) {
-		struct kvm_pmc *pmc = kvm_vcpu_idx_to_pmc(vcpu, i);
-
 		if (!(val & BIT(i)))
 			continue;
 
-		if (kvm_pmu_counter_is_enabled(pmc))
-			kvm_pmc_enable_perf_event(pmc);
+		if (kvm_pmu_counter_is_enabled(vcpu, i))
+			kvm_pmc_enable_perf_event(vcpu, i);
 		else
-			kvm_pmc_disable_perf_event(pmc);
+			kvm_pmc_disable_perf_event(vcpu, i);
 	}
 
+	vcpu->arch.pmu.reset_sample_period = true;
 	kvm_vcpu_pmu_restore_guest(vcpu);
 }
 
@@ -393,6 +396,42 @@ static bool kvm_pmu_overflow_status(struct kvm_vcpu *vcpu)
 	return reg;
 }
 
+/* Compute the sample period for a given counter value */
+static u64 compute_period(struct kvm_pmc **pmc, u64 counter)
+{
+	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
+	u64 val;
+
+	if (kvm_pmc_is_64bit(vcpu, (*pmc)->idx) && kvm_pmc_has_64bit_overflow(vcpu, (*pmc)->idx))
+		val = (-counter) & GENMASK(63, 0);
+	else
+		val = (-counter) & GENMASK(31, 0);
+
+	return val;
+}
+
+static void reset_sample_period(struct perf_event *perf_event)
+{
+	struct kvm_pmc **pmc = perf_event->overflow_handler_context;
+	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
+	struct arm_pmu *cpu_pmu = to_arm_pmu(perf_event->pmu);
+	u64 period;
+
+	cpu_pmu->pmu.stop(perf_event, PERF_EF_UPDATE);
+
+	/*
+	 * Reset the sample period to the architectural limit,
+	 * i.e. the point where the counter overflows.
+	 */
+	period = compute_period(pmc, kvm_pmu_get_pmc_value(vcpu, (*pmc)->idx));
+
+	local64_set(&perf_event->hw.period_left, 0);
+	perf_event->attr.sample_period = period;
+	perf_event->hw.sample_period = period;
+
+	cpu_pmu->pmu.start(perf_event, PERF_EF_RELOAD);
+}
+
 static void kvm_pmu_update_state(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = &vcpu->arch.pmu;
@@ -445,6 +484,31 @@ void kvm_pmu_update_run(struct kvm_vcpu *vcpu)
  */
 void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu)
 {
+	if (unlikely(vcpu->arch.pmu.reset_sample_period)) {
+		unsigned long mask = kvm_pmu_enabled_counter_mask(vcpu);
+		int i;
+
+		for_each_set_bit(i, &mask, KVM_ARMV8_PMU_MAX_COUNTERS) {
+			struct kvm_pmc *pmc = *kvm_vcpu_idx_to_pmc(vcpu, i);
+
+			if (!pmc)
+				continue;
+
+			for (unsigned int j = 0; j < pmc->nr_perf_events; j++) {
+				struct perf_event *perf_event = pmc->perf_events[j];
+				struct arm_pmu *cpu_pmu = to_arm_pmu(perf_event->pmu);
+
+				if (cpumask_test_cpu(smp_processor_id(),
+						     &cpu_pmu->supported_cpus)) {
+					reset_sample_period(perf_event);
+					break;
+				}
+			}
+		}
+
+		vcpu->arch.pmu.reset_sample_period = false;
+	}
+
 	kvm_pmu_update_state(vcpu);
 }
 
@@ -490,7 +554,6 @@ static void kvm_pmu_counter_increment(struct kvm_vcpu *vcpu,
 	mask &= __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
 
 	for_each_set_bit(i, &mask, ARMV8_PMU_CYCLE_IDX) {
-		struct kvm_pmc *pmc = kvm_vcpu_idx_to_pmc(vcpu, i);
 		u64 type, reg;
 
 		/* Filter on event type */
@@ -501,36 +564,23 @@ static void kvm_pmu_counter_increment(struct kvm_vcpu *vcpu,
 
 		/* Increment this counter */
 		reg = __vcpu_sys_reg(vcpu, counter_index_to_reg(i)) + 1;
-		if (!kvm_pmc_is_64bit(pmc))
+		if (!kvm_pmc_is_64bit(vcpu, i))
 			reg = lower_32_bits(reg);
 		__vcpu_assign_sys_reg(vcpu, counter_index_to_reg(i), reg);
 
 		/* No overflow? move on */
-		if (kvm_pmc_has_64bit_overflow(pmc) ? reg : lower_32_bits(reg))
+		if (kvm_pmc_has_64bit_overflow(vcpu, i) ? reg : lower_32_bits(reg))
 			continue;
 
 		/* Mark overflow */
 		__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, BIT(i));
 
-		if (kvm_pmu_counter_can_chain(pmc))
+		if (kvm_pmu_counter_can_chain(vcpu, i))
 			kvm_pmu_counter_increment(vcpu, BIT(i + 1),
 						  ARMV8_PMUV3_PERFCTR_CHAIN);
 	}
 }
 
-/* Compute the sample period for a given counter value */
-static u64 compute_period(struct kvm_pmc *pmc, u64 counter)
-{
-	u64 val;
-
-	if (kvm_pmc_is_64bit(pmc) && kvm_pmc_has_64bit_overflow(pmc))
-		val = (-counter) & GENMASK(63, 0);
-	else
-		val = (-counter) & GENMASK(31, 0);
-
-	return val;
-}
-
 /*
  * When the perf event overflows, set the overflow status and inform the vcpu.
  */
@@ -538,27 +588,13 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,
 				  struct perf_sample_data *data,
 				  struct pt_regs *regs)
 {
-	struct kvm_pmc *pmc = perf_event->overflow_handler_context;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(perf_event->pmu);
+	struct kvm_pmc **pmc = perf_event->overflow_handler_context;
 	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
-	int idx = pmc->idx;
-	u64 period;
-
-	cpu_pmu->pmu.stop(perf_event, PERF_EF_UPDATE);
-
-	/*
-	 * Reset the sample period to the architectural limit,
-	 * i.e. the point where the counter overflows.
-	 */
-	period = compute_period(pmc, local64_read(&perf_event->count));
-
-	local64_set(&perf_event->hw.period_left, 0);
-	perf_event->attr.sample_period = period;
-	perf_event->hw.sample_period = period;
+	int idx = (*pmc)->idx;
 
 	__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, BIT(idx));
 
-	if (kvm_pmu_counter_can_chain(pmc))
+	if (kvm_pmu_counter_can_chain(vcpu, idx))
 		kvm_pmu_counter_increment(vcpu, BIT(idx + 1),
 					  ARMV8_PMUV3_PERFCTR_CHAIN);
 
@@ -571,7 +607,7 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,
 			irq_work_queue(&vcpu->arch.pmu.overflow_work);
 	}
 
-	cpu_pmu->pmu.start(perf_event, PERF_EF_RELOAD);
+	reset_sample_period(perf_event);
 }
 
 /**
@@ -615,57 +651,45 @@ void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val)
 			mask &= ~kvm_pmu_hyp_counter_mask(vcpu);
 
 		for_each_set_bit(i, &mask, 32)
-			kvm_pmu_set_pmc_value(kvm_vcpu_idx_to_pmc(vcpu, i), 0, true);
+			kvm_pmu_set_pmc_value(vcpu, i, 0, true);
 	}
 }
 
-static bool kvm_pmu_counter_is_enabled(struct kvm_pmc *pmc)
+static bool kvm_pmu_counter_is_enabled(struct kvm_vcpu *vcpu, u8 idx)
 {
-	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
-	unsigned int mdcr = __vcpu_sys_reg(vcpu, MDCR_EL2);
-
-	if (!(__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & BIT(pmc->idx)))
-		return false;
-
-	if (kvm_pmu_counter_is_hyp(vcpu, pmc->idx))
-		return mdcr & MDCR_EL2_HPME;
-
-	return kvm_vcpu_read_pmcr(vcpu) & ARMV8_PMU_PMCR_E;
+	return kvm_pmu_enabled_counter_mask(vcpu) & BIT(idx);
 }
 
-static bool kvm_pmc_counts_at_el0(struct kvm_pmc *pmc)
+static bool kvm_pmc_counts_at_el0(struct kvm_vcpu *vcpu, u8 idx)
 {
-	u64 evtreg = kvm_pmc_read_evtreg(pmc);
+	u64 evtreg = kvm_pmc_read_evtreg(vcpu, idx);
 	bool nsu = evtreg & ARMV8_PMU_EXCLUDE_NS_EL0;
 	bool u = evtreg & ARMV8_PMU_EXCLUDE_EL0;
 
 	return u == nsu;
 }
 
-static bool kvm_pmc_counts_at_el1(struct kvm_pmc *pmc)
+static bool kvm_pmc_counts_at_el1(struct kvm_vcpu *vcpu, u8 idx)
 {
-	u64 evtreg = kvm_pmc_read_evtreg(pmc);
+	u64 evtreg = kvm_pmc_read_evtreg(vcpu, idx);
 	bool nsk = evtreg & ARMV8_PMU_EXCLUDE_NS_EL1;
 	bool p = evtreg & ARMV8_PMU_EXCLUDE_EL1;
 
 	return p == nsk;
 }
 
-static bool kvm_pmc_counts_at_el2(struct kvm_pmc *pmc)
+static bool kvm_pmc_counts_at_el2(struct kvm_vcpu *vcpu, u8 idx)
 {
-	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
 	u64 mdcr = __vcpu_sys_reg(vcpu, MDCR_EL2);
 
-	if (!kvm_pmu_counter_is_hyp(vcpu, pmc->idx) && (mdcr & MDCR_EL2_HPMD))
+	if (!kvm_pmu_counter_is_hyp(vcpu, idx) && (mdcr & MDCR_EL2_HPMD))
 		return false;
 
-	return kvm_pmc_read_evtreg(pmc) & ARMV8_PMU_INCLUDE_EL2;
+	return kvm_pmc_read_evtreg(vcpu, idx) & ARMV8_PMU_INCLUDE_EL2;
 }
 
-static int kvm_map_pmu_event(struct kvm *kvm, unsigned int eventsel)
+static int kvm_map_pmu_event(struct arm_pmu *pmu, unsigned int eventsel)
 {
-	struct arm_pmu *pmu = kvm->arch.arm_pmu;
-
 	/*
 	 * The CPU PMU likely isn't PMUv3; let the driver provide a mapping
 	 * for the guest's PMUv3 event ID.
@@ -676,48 +700,28 @@ static int kvm_map_pmu_event(struct kvm *kvm, unsigned int eventsel)
 	return eventsel;
 }
 
-/**
- * kvm_pmu_create_perf_event - create a perf event for a counter
- * @pmc: Counter context
- */
-static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc)
+static struct kvm_pmc *kvm_pmu_alloc_pmc(u8 idx, unsigned int capacity)
 {
-	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
-	struct arm_pmu *arm_pmu = vcpu->kvm->arch.arm_pmu;
-	struct perf_event *event;
-	struct perf_event_attr attr;
-	int eventsel;
-	u64 evtreg;
+	struct kvm_pmc *pmc = kzalloc(struct_size(pmc, perf_events, capacity), GFP_KERNEL_ACCOUNT);
 
-	evtreg = kvm_pmc_read_evtreg(pmc);
+	if (pmc)
+		pmc->idx = idx;
 
-	kvm_pmu_stop_counter(pmc);
-	if (pmc->idx == ARMV8_PMU_CYCLE_IDX)
-		eventsel = ARMV8_PMUV3_PERFCTR_CPU_CYCLES;
-	else
-		eventsel = evtreg & kvm_pmu_event_mask(vcpu->kvm);
-
-	/*
-	 * Neither SW increment nor chained events need to be backed
-	 * by a perf event.
-	 */
-	if (eventsel == ARMV8_PMUV3_PERFCTR_SW_INCR ||
-	    eventsel == ARMV8_PMUV3_PERFCTR_CHAIN)
-		return;
+	return pmc;
+}
 
-	/*
-	 * If we have a filter in place and that the event isn't allowed, do
-	 * not install a perf event either.
-	 */
-	if (vcpu->kvm->arch.pmu_filter &&
-	    !test_bit(eventsel, vcpu->kvm->arch.pmu_filter))
-		return;
+static void kvm_pmu_create_perf_event(struct kvm_pmc **pmc,
+				      struct arm_pmu *arm_pmu, int eventsel)
+{
+	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
+	struct perf_event *event;
+	struct perf_event_attr attr;
 
 	/*
 	 * Don't create an event if we're running on hardware that requires
 	 * PMUv3 event translation and we couldn't find a valid mapping.
 	 */
-	eventsel = kvm_map_pmu_event(vcpu->kvm, eventsel);
+	eventsel = kvm_map_pmu_event(arm_pmu, eventsel);
 	if (eventsel < 0)
 		return;
 
@@ -725,8 +729,8 @@ static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc)
 	attr.type = arm_pmu->pmu.type;
 	attr.size = sizeof(attr);
 	attr.pinned = 1;
-	attr.disabled = !kvm_pmu_counter_is_enabled(pmc);
-	attr.exclude_user = !kvm_pmc_counts_at_el0(pmc);
+	attr.disabled = !kvm_pmu_counter_is_enabled(vcpu, (*pmc)->idx);
+	attr.exclude_user = !kvm_pmc_counts_at_el0(vcpu, (*pmc)->idx);
 	attr.exclude_hv = 1; /* Don't count EL2 events */
 	attr.exclude_host = 1; /* Don't count host events */
 	attr.config = eventsel;
@@ -736,19 +740,19 @@ static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc)
 	 * guest's EL2 filter.
 	 */
 	if (unlikely(is_hyp_ctxt(vcpu)))
-		attr.exclude_kernel = !kvm_pmc_counts_at_el2(pmc);
+		attr.exclude_kernel = !kvm_pmc_counts_at_el2(vcpu, (*pmc)->idx);
 	else
-		attr.exclude_kernel = !kvm_pmc_counts_at_el1(pmc);
+		attr.exclude_kernel = !kvm_pmc_counts_at_el1(vcpu, (*pmc)->idx);
 
 	/*
 	 * If counting with a 64bit counter, advertise it to the perf
 	 * code, carefully dealing with the initial sample period
 	 * which also depends on the overflow.
 	 */
-	if (kvm_pmc_is_64bit(pmc))
+	if (kvm_pmc_is_64bit(vcpu, (*pmc)->idx))
 		attr.config1 |= PERF_ATTR_CFG1_COUNTER_64BIT;
 
-	attr.sample_period = compute_period(pmc, kvm_pmu_get_pmc_value(pmc));
+	attr.sample_period = compute_period(pmc, kvm_pmu_get_pmc_value(vcpu, (*pmc)->idx));
 
 	event = perf_event_create_kernel_counter(&attr, -1, current,
 						 kvm_pmu_perf_overflow, pmc);
@@ -756,10 +760,77 @@ static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc)
 	if (IS_ERR(event)) {
 		pr_err_once("kvm: pmu event creation failed %ld\n",
 			    PTR_ERR(event));
+	}
+
+	(*pmc)->nr_perf_events++;
+	(*pmc)->perf_events[(*pmc)->nr_perf_events - 1] = event;
+}
+
+/**
+ * kvm_pmu_create_pmc - create a pmc
+ * @pmc: Counter context
+ */
+static void kvm_pmu_create_pmc(struct kvm_vcpu *vcpu, u8 idx)
+{
+	struct arm_pmu *arm_pmu = vcpu->kvm->arch.arm_pmu;
+	struct arm_pmu_entry *entry;
+	struct kvm_pmc **pmc = kvm_vcpu_idx_to_pmc(vcpu, idx);
+	u64 eventsel, evtreg;
+	unsigned int nr;
+
+
+	evtreg = kvm_pmc_read_evtreg(vcpu, idx);
+
+	kvm_pmu_stop_counter(vcpu, idx);
+	if (idx == ARMV8_PMU_CYCLE_IDX)
+		eventsel = ARMV8_PMUV3_PERFCTR_CPU_CYCLES;
+	else
+		eventsel = evtreg & kvm_pmu_event_mask(vcpu->kvm);
+
+	/*
+	 * Neither SW increment nor chained events need to be backed
+	 * by a perf event.
+	 */
+	if (eventsel == ARMV8_PMUV3_PERFCTR_SW_INCR ||
+	    eventsel == ARMV8_PMUV3_PERFCTR_CHAIN)
 		return;
+
+	/*
+	 * If we have a filter in place and that the event isn't allowed, do
+	 * not install a perf event either.
+	 */
+	if (vcpu->kvm->arch.pmu_filter &&
+	    !test_bit(eventsel, vcpu->kvm->arch.pmu_filter))
+		return;
+
+	if (arm_pmu) {
+		*pmc = kvm_pmu_alloc_pmc(idx, 1);
+		if (!*pmc)
+			goto err;
+
+		kvm_pmu_create_perf_event(pmc, arm_pmu, eventsel);
+	} else {
+		guard(mutex)(&arm_pmus_lock);
+
+		nr = vcpu->kvm->arch.nr_composed_host_pmus;
+		*pmc = kvm_pmu_alloc_pmc(idx, nr);
+		if (!*pmc)
+			goto err;
+
+		list_for_each_entry(entry, &arm_pmus, entry) {
+			if (!nr)
+				break;
+
+			arm_pmu = entry->arm_pmu;
+			kvm_pmu_create_perf_event(pmc, arm_pmu, eventsel);
+			nr--;
+		}
 	}
 
-	pmc->perf_event = event;
+	return;
+
+err:
+	pr_err_once("kvm: pmc allocation failed\n");
 }
 
 /**
@@ -775,13 +846,12 @@ static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc)
 void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
 				    u64 select_idx)
 {
-	struct kvm_pmc *pmc = kvm_vcpu_idx_to_pmc(vcpu, select_idx);
 	u64 reg;
 
-	reg = counter_index_to_evtreg(pmc->idx);
+	reg = counter_index_to_evtreg(select_idx);
 	__vcpu_assign_sys_reg(vcpu, reg, (data & kvm_pmu_evtyper_mask(vcpu->kvm)));
 
-	kvm_pmu_create_perf_event(pmc);
+	kvm_pmu_create_pmc(vcpu, select_idx);
 }
 
 void kvm_host_pmu_init(struct arm_pmu *pmu)
@@ -883,6 +953,9 @@ u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1)
 	u64 val, mask = 0;
 	int base, i, nr_events;
 
+	if (!cpu_pmu)
+		return 0;
+
 	if (!pmceid1) {
 		val = compute_pmceid0(cpu_pmu);
 		base = 0;
@@ -1011,6 +1084,9 @@ u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
 {
 	struct arm_pmu *arm_pmu = kvm->arch.arm_pmu;
 
+	if (!arm_pmu)
+		return 0;
+
 	/*
 	 * PMUv3 requires that all event counters are capable of counting any
 	 * event, though the same may not be true of non-PMUv3 hardware.
@@ -1094,6 +1170,7 @@ static int kvm_arm_pmu_v3_set_pmu(struct kvm_vcpu *vcpu, int pmu_id)
 			}
 
 			kvm_arm_set_pmu(kvm, arm_pmu);
+			kvm->arch.nr_composed_host_pmus = 0;
 			cpumask_copy(kvm->arch.supported_cpus, &arm_pmu->supported_cpus);
 			ret = 0;
 			break;
@@ -1104,6 +1181,34 @@ static int kvm_arm_pmu_v3_set_pmu(struct kvm_vcpu *vcpu, int pmu_id)
 	return ret;
 }
 
+static int kvm_arm_pmu_v3_set_pmu_composition(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct arm_pmu_entry *entry;
+	struct arm_pmu *arm_pmu;
+
+	lockdep_assert_held(&kvm->arch.config_lock);
+
+	if (kvm_vm_has_ran_once(kvm) ||
+	    (kvm->arch.pmu_filter && !kvm->arch.nr_composed_host_pmus))
+		return -EBUSY;
+
+	kvm->arch.arm_pmu = NULL;
+	kvm_arm_set_nr_counters(kvm, 0);
+	kvm->arch.nr_composed_host_pmus = 0;
+	cpumask_clear(kvm->arch.supported_cpus);
+
+	guard(mutex)(&arm_pmus_lock);
+	list_for_each_entry(entry, &arm_pmus, entry) {
+		arm_pmu = entry->arm_pmu;
+		kvm->arch.nr_composed_host_pmus++;
+		cpumask_or(kvm->arch.supported_cpus, kvm->arch.supported_cpus,
+			   &arm_pmu->supported_cpus);
+	}
+
+	return 0;
+}
+
 static int kvm_arm_pmu_v3_set_nr_counters(struct kvm_vcpu *vcpu, unsigned int n)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -1223,6 +1328,8 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 
 		return kvm_arm_pmu_v3_set_nr_counters(vcpu, n);
 	}
+	case KVM_ARM_VCPU_PMU_V3_COMPOSITION:
+		return kvm_arm_pmu_v3_set_pmu_composition(vcpu);
 	case KVM_ARM_VCPU_PMU_V3_INIT:
 		return kvm_arm_pmu_v3_init(vcpu);
 	}
@@ -1249,6 +1356,9 @@ int kvm_arm_pmu_v3_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 		irq = vcpu->arch.pmu.irq_num;
 		return put_user(irq, uaddr);
 	}
+	case KVM_ARM_VCPU_PMU_V3_COMPOSITION:
+		if (vcpu->kvm->arch.nr_composed_host_pmus)
+			return 0;
 	}
 
 	return -ENXIO;
@@ -1262,6 +1372,7 @@ int kvm_arm_pmu_v3_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 	case KVM_ARM_VCPU_PMU_V3_FILTER:
 	case KVM_ARM_VCPU_PMU_V3_SET_PMU:
 	case KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS:
+	case KVM_ARM_VCPU_PMU_V3_COMPOSITION:
 		if (kvm_vcpu_has_pmu(vcpu))
 			return 0;
 	}
@@ -1316,17 +1427,15 @@ void kvm_pmu_nested_transition(struct kvm_vcpu *vcpu)
 
 	mask = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
 	for_each_set_bit(i, &mask, 32) {
-		struct kvm_pmc *pmc = kvm_vcpu_idx_to_pmc(vcpu, i);
-
 		/*
 		 * We only need to reconfigure events where the filter is
 		 * different at EL1 vs. EL2, as we're multiplexing the true EL1
 		 * event filter bit for nested.
 		 */
-		if (kvm_pmc_counts_at_el1(pmc) == kvm_pmc_counts_at_el2(pmc))
+		if (kvm_pmc_counts_at_el1(vcpu, i) == kvm_pmc_counts_at_el2(vcpu, i))
 			continue;
 
-		kvm_pmu_create_perf_event(pmc);
+		kvm_pmu_create_pmc(vcpu, i);
 		reprogrammed = true;
 	}
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c20bd6f21e608af0cefee6cffe3d17bbf5af5b2a..8a5d88eeb3a557b85dced98fd7db9306c36d181a 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -979,7 +979,7 @@ static int set_pmu_evcntr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 		/* PMEVCNTRn_EL0 */
 		idx = ((r->CRm & 3) << 3) | (r->Op2 & 7);
 
-	kvm_pmu_set_counter_value_user(vcpu, idx, val);
+	kvm_pmu_set_counter_value(vcpu, idx, val);
 	return 0;
 }
 
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 96754b51b411662cd7bcf35fd1c21688caa4d8e8..d918a3ef24568235028737eb02c980fc69032ad5 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -15,7 +15,8 @@
 #if IS_ENABLED(CONFIG_HW_PERF_EVENTS) && IS_ENABLED(CONFIG_KVM)
 struct kvm_pmc {
 	u8 idx;	/* index into the pmu->pmc array */
-	struct perf_event *perf_event;
+	unsigned int nr_perf_events;
+	struct perf_event *perf_events[] __counted_by(nr_perf_events);
 };
 
 struct kvm_pmu_events {
@@ -26,10 +27,11 @@ struct kvm_pmu_events {
 struct kvm_pmu {
 	struct irq_work overflow_work;
 	struct kvm_pmu_events events;
-	struct kvm_pmc pmc[KVM_ARMV8_PMU_MAX_COUNTERS];
+	struct kvm_pmc *pmc[KVM_ARMV8_PMU_MAX_COUNTERS];
 	int irq_num;
 	bool created;
 	bool irq_level;
+	bool reset_sample_period;
 };
 
 struct arm_pmu_entry {
@@ -41,12 +43,11 @@ bool kvm_supports_guest_pmuv3(void);
 #define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >= VGIC_NR_SGIS)
 u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
 void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
-void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
 u64 kvm_pmu_implemented_counter_mask(struct kvm_vcpu *vcpu);
 u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu);
 u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1);
-void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu);
 void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu);
+void kvm_pmu_vcpu_load(struct kvm_vcpu *vcpu);
 void kvm_pmu_reprogram_counter_mask(struct kvm_vcpu *vcpu, u64 val);
 void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu);
 void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu);
@@ -109,8 +110,6 @@ static inline u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
 }
 static inline void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu,
 					     u64 select_idx, u64 val) {}
-static inline void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu,
-						  u64 select_idx, u64 val) {}
 static inline u64 kvm_pmu_implemented_counter_mask(struct kvm_vcpu *vcpu)
 {
 	return 0;
@@ -119,7 +118,6 @@ static inline u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
 {
 	return 0;
 }
-static inline void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_reprogram_counter_mask(struct kvm_vcpu *vcpu, u64 val) {}
 static inline void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu) {}

-- 
2.50.1


