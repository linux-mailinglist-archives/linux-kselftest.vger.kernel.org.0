Return-Path: <linux-kselftest+bounces-37312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38776B04B6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 01:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F9B1AA1787
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 23:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE9C29AB1A;
	Mon, 14 Jul 2025 22:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4PMfGP09"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87386294A10
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533994; cv=none; b=CQSXu8BWoIHMWP+uK6ssPj5ecwLL0BvZuJvNJYAzWR/cwadMmteN5zEuYz76pteJhSy8sjSWhJD7xCwJ+/sgAK/vakTkQZGcyb0EL1eq80gzq4vnC0F2afDnfMBi9fJOk7gr6jXoy/l8/Z/tUtR+tgznchkLCfz0mZM7216Ovnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533994; c=relaxed/simple;
	bh=LIfK+ThAHCSsdbqh1RpuOzFz2Lg3zSekVpnvx+MJmgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MeAxhYXYgWc5z0q5Kt+xtpXCIVDCjr9bYkPMqnF/gRbemwa+GIaXnFXYB69DpmZy/ddiXen+PsoWL+N84WXHIGg0pQ83+Ey2Y/FM0OxPgwyEDmAa6GeSl5CNDnfVq7WmH6vVcJb8PjHd3kylci9LFF8ALdlVyY5K5opzRJGjK20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4PMfGP09; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-40ab2c50f7cso4305337b6e.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 15:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752533990; x=1753138790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7mScXH/6+pdXYQkInC9PtowohFYZMkWYozKee5Fshw=;
        b=4PMfGP09g2t7319v1Mca3s0awvVK6vL6Q5MiMfJtDeqd9/BfC1LHqQFSR7pJPIgg1t
         7wz2BWlnLaOoqSW5doIxNa1tCxZIaT2DaCsa6Kh/70nBg1sxgNqTlKsmQk/ObLALNk54
         ph528Y/EZK36BJ+KJxs2ZIIeNYxE1jE/U9D9Zn9NKaLF9SBM9DIFIZHGWrsFFC3R9ngb
         tHzAQRd4Env7FZnJQgeFYW/qeaa2sa1wzT3C3xtkHOYoBsIpUBHgWqr2Q/30WC4xUaFa
         oYqsSK4+JexmuBQdb4GBy+oohLA1RdBTj01bnEOOe7WovuKZQakno3jxYnMQv9+BjFTL
         1igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752533990; x=1753138790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7mScXH/6+pdXYQkInC9PtowohFYZMkWYozKee5Fshw=;
        b=LpkMOUxeKjaRG5RkmPEKm7mUXiXeciAF1z1WMyJBt6kvN0cUSVTN8jkQOnV6/AuIv6
         HuUtTgFgxzB9C7zznP/jJ9EMDNtXckOdSkjJyBIe99ywAEyzmDChdCUFYoXg7/aSmKLF
         xOcz0rgDR+yUkvFV/o28jDO/fEDYe7PeyFmb8Ep/pU1cFnDnNTE8evscrca+SLujbtVl
         gUXGoW6LOV//g6w8hViZbdhiybkZYoenhkKXMSjmB0uQQMkMT7KoWcbTaW/8Q20tx2T9
         xacCI0ZKi2fT73Gtiv72H8g5PGO62ac2OX2pPzNkIRAunbYCjUL4H3GblrH6K1CxG0tZ
         ULOg==
X-Forwarded-Encrypted: i=1; AJvYcCXHz3kVdGUbY/vlBAcSMrT7Y3pwJ1sCc0Qo1QR9WBfVlItaQ/zrfICv3T0KjfT4B3GF6JlHw285fT23SnRS/HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKr1AcMbze0um80eiFW+R0263udYFMfadugzQBpz7a6PfTgkhM
	2sg/lhRlPPOhWy8704syY2O74RRhErLWb2ivfXTF3p2TKEKXIkl5uVtohLfGZzdvSoc//vJfXV9
	D/pkjj6zuSs+hupUPO56ox0DuQQ==
X-Google-Smtp-Source: AGHT+IHeWycWc8V6KlcE3+nXaI8c1NOdk6N2RoQO/4A7VVje0Wg9HvCVPFl3hQhC7Im+5mMnPvUFMFuuatCQ6TJ/Gg==
X-Received: from oigd17.prod.google.com ([2002:a05:6808:4a11:b0:41b:4c26:7a64])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:14ce:b0:40b:a4ca:f7cb with SMTP id 5614622812f47-41b7cafb187mr830089b6e.15.1752533990127;
 Mon, 14 Jul 2025 15:59:50 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:59:13 +0000
In-Reply-To: <20250714225917.1396543-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714225917.1396543-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714225917.1396543-20-coltonlewis@google.com>
Subject: [PATCH v4 19/23] KVM: arm64: Implement lazy PMU context swaps
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Since many guests will never touch the PMU, they need not pay the cost
of context swapping those registers.

Use the ownership enum from the previous commit to implement a simple
state machine for PMU ownership. The PMU is always in one of three
states: host owned, guest owned, or free.

A host owned state means all PMU registers are trapped coarsely by
MDCR_EL2.TPM. In host owned state PMU partitioning is disabled and the
PMU may not transition to a different state without intervention from
the host.

A guest owned state means some PMU registers are untrapped under FGT
controls. This is the only state in which context swaps take place.

A free state is the default partitioned state. It means no context
swaps take place and KVM keeps the registers trapped. If a guest
accesses the PMU registers in a free state, the PMU transitions to a
guest owned state and KVM recalculates MDCR_EL2 to unset TPM.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/include/asm/kvm_pmu.h  | 18 ++++++++++++++++++
 arch/arm64/kvm/debug.c            |  2 +-
 arch/arm64/kvm/pmu-direct.c       |  4 +++-
 arch/arm64/kvm/pmu.c              | 24 ++++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.c         | 24 ++++++++++++++++++++++--
 6 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 21e32d7fa19b..f6803b57b648 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1453,6 +1453,7 @@ static inline bool kvm_system_needs_idmapped_vectors(void)
 	return cpus_have_final_cap(ARM64_SPECTRE_V3A);
 }
 
+void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu);
 void kvm_init_host_debug_data(void);
 void kvm_vcpu_load_debug(struct kvm_vcpu *vcpu);
 void kvm_vcpu_put_debug(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index 58c1219adf54..47cfff7ebc26 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -97,6 +97,11 @@ u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);
 void kvm_pmu_host_counters_enable(void);
 void kvm_pmu_host_counters_disable(void);
 
+bool kvm_pmu_regs_free(struct kvm_vcpu *vcpu);
+bool kvm_pmu_regs_host_owned(struct kvm_vcpu *vcpu);
+bool kvm_pmu_regs_guest_owned(struct kvm_vcpu *vcpu);
+void kvm_pmu_regs_set_guest_owned(struct kvm_vcpu *vcpu);
+
 u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu);
 u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu);
 void kvm_pmu_load(struct kvm_vcpu *vcpu);
@@ -168,6 +173,19 @@ static inline u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu)
 {
 	return 0;
 }
+static inline bool kvm_pmu_regs_free(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+static inline bool kvm_pmu_regs_host_owned(struct kvm_vcpu *vcpu)
+{
+	return true;
+}
+static inline bool kvm_pmu_regs_guest_owned(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+static inline void kvm_pmu_regs_set_guest_owned(struct kvm_vcpu *vcpu) {}
 static inline u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
 {
 	return 0;
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index fa8b4f846b68..128fa17b7a35 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -28,7 +28,7 @@
  *  - Self-hosted Trace Filter controls (MDCR_EL2_TTRF)
  *  - Self-hosted Trace (MDCR_EL2_TTRF/MDCR_EL2_E2TB)
  */
-static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
+void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 {
 	preempt_disable();
 
diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index e21fdd274c2e..28d8540c5ed2 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -52,7 +52,8 @@ bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
  */
 bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)
 {
-	return kvm_pmu_is_partitioned(vcpu->kvm->arch.arm_pmu);
+	return kvm_pmu_is_partitioned(vcpu->kvm->arch.arm_pmu) &&
+		!kvm_pmu_regs_host_owned(vcpu);
 }
 
 /**
@@ -69,6 +70,7 @@ bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
 	u8 hpmn = vcpu->kvm->arch.nr_pmu_counters;
 
 	return kvm_vcpu_pmu_is_partitioned(vcpu) &&
+		kvm_pmu_regs_guest_owned(vcpu) &&
 		cpus_have_final_cap(ARM64_HAS_FGT) &&
 		(hpmn != 0 || cpus_have_final_cap(ARM64_HAS_HPMN0));
 }
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 1e5f46c1346c..db11a3e9c4b7 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -496,6 +496,7 @@ static int kvm_arm_pmu_v3_init(struct kvm_vcpu *vcpu)
 	init_irq_work(&vcpu->arch.pmu.overflow_work,
 		      kvm_pmu_perf_overflow_notify_vcpu);
 
+	vcpu->arch.pmu.owner = VCPU_REGISTER_HOST_OWNED;
 	vcpu->arch.pmu.created = true;
 	return 0;
 }
@@ -906,3 +907,26 @@ bool pmu_access_el0_disabled(struct kvm_vcpu *vcpu)
 {
 	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_EN);
 }
+
+bool kvm_pmu_regs_free(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.pmu.owner == VCPU_REGISTER_FREE;
+}
+
+bool kvm_pmu_regs_host_owned(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.pmu.owner == VCPU_REGISTER_HOST_OWNED;
+}
+
+bool kvm_pmu_regs_guest_owned(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.pmu.owner == VCPU_REGISTER_GUEST_OWNED;
+}
+
+void kvm_pmu_regs_set_guest_owned(struct kvm_vcpu *vcpu)
+{
+	if (kvm_pmu_regs_free(vcpu)) {
+		vcpu->arch.pmu.owner = VCPU_REGISTER_GUEST_OWNED;
+		kvm_arm_setup_mdcr_el2(vcpu);
+	}
+}
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index e3d4ca167881..7d4b194bfa0a 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -860,6 +860,8 @@ static bool access_pmcr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 {
 	u64 val;
 
+	kvm_pmu_regs_set_guest_owned(vcpu);
+
 	if (pmu_access_el0_disabled(vcpu))
 		return false;
 
@@ -887,6 +889,8 @@ static bool access_pmcr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 static bool access_pmselr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			  const struct sys_reg_desc *r)
 {
+	kvm_pmu_regs_set_guest_owned(vcpu);
+
 	if (pmu_access_event_counter_el0_disabled(vcpu))
 		return false;
 
@@ -905,6 +909,8 @@ static bool access_pmceid(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 {
 	u64 pmceid, mask, shift;
 
+	kvm_pmu_regs_set_guest_owned(vcpu);
+
 	BUG_ON(p->is_write);
 
 	if (pmu_access_el0_disabled(vcpu))
@@ -973,6 +979,8 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 {
 	u64 idx = ~0UL;
 
+	kvm_pmu_regs_set_guest_owned(vcpu);
+
 	if (r->CRn == 9 && r->CRm == 13) {
 		if (r->Op2 == 2) {
 			/* PMXEVCNTR_EL0 */
@@ -1049,6 +1057,8 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 {
 	u64 idx, reg, pmselr;
 
+	kvm_pmu_regs_set_guest_owned(vcpu);
+
 	if (pmu_access_el0_disabled(vcpu))
 		return false;
 
@@ -1110,6 +1120,8 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 {
 	u64 val, mask;
 
+	kvm_pmu_regs_set_guest_owned(vcpu);
+
 	if (pmu_access_el0_disabled(vcpu))
 		return false;
 
@@ -1134,7 +1146,10 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 static bool access_pminten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			   const struct sys_reg_desc *r)
 {
-	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
+	u64 mask;
+
+	kvm_pmu_regs_set_guest_owned(vcpu);
+	mask = kvm_pmu_accessible_counter_mask(vcpu);
 
 	if (check_pmu_access_disabled(vcpu, 0))
 		return false;
@@ -1171,7 +1186,10 @@ static void writethrough_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 static bool access_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			 const struct sys_reg_desc *r)
 {
-	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
+	u64 mask;
+
+	kvm_pmu_regs_set_guest_owned(vcpu);
+	mask = kvm_pmu_accessible_counter_mask(vcpu);
 
 	if (pmu_access_el0_disabled(vcpu))
 		return false;
@@ -1211,6 +1229,8 @@ static bool access_pmswinc(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			     const struct sys_reg_desc *r)
 {
+	kvm_pmu_regs_set_guest_owned(vcpu);
+
 	if (p->is_write) {
 		if (!vcpu_mode_priv(vcpu))
 			return undef_access(vcpu, p, r);
-- 
2.50.0.727.gbf7dc18ff4-goog


