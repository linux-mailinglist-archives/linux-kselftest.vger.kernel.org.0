Return-Path: <linux-kselftest+bounces-47327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C13DCB1172
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 22:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C53BC3049911
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 21:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CD930DEB0;
	Tue,  9 Dec 2025 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oVLwhgHO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733C630C343
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313570; cv=none; b=oGHO5T/azfd9LHVyi/KPd0WZHa5eGa0KmpEakrt4W0XuaEBM6yqqD1IHKufYHxEDcquefu720rjb7OLRIe1/e09OJXx/G18NwhiLaYfYn9ZM5AYUxlOCOAc4T8EGHzg1MCCdRTSmO9bprxuakoQaOFzwXRmphMa6JakCXNLiWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313570; c=relaxed/simple;
	bh=8cRNgmZhNmgIt8apJ3I52IH8YRtz95hzV+y0zYEsqYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rBlS5sIHLm4PqUk6zhOe1l37C3WZdiIyA2+qMjhhtDGAV+2GN6nWh/xqvwz4e0mywAGSQ/iSxMvf0hTv9HDpvGueTUxYfqEUw7VIjTjAFJnpeEVHk+2bqWImMp9f5b68yb7FilyHKnVVUvAbrYDQq0jUQt6sH19k3hMHxRirpjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oVLwhgHO; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-6574f3b6ec1so8530382eaf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Dec 2025 12:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765313560; x=1765918360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kUP/0ib7NzaQ10lNwrazeH9U5sdGAZQbx8k0mwKac3A=;
        b=oVLwhgHOS0gBg1RsbmcJ5RJSEa3C12tWfQiDaemkDFRsdfcEzcGessfXTg4/JojnQJ
         xLEpm9ciGxUogY96sUdZP1Wu8SUcgdOnTAn4zyomT1yoAjWjYEC1o7QQ47V4sNjt/1KJ
         sHVUkm4Frw8h9dSaDzUbL12/iNFNDwfKhV1rW2R+rtuBQFxF8BGlwwyN1yMAo9iZYjfk
         PbZDPKda5bK5l35a+6mh5lckAnG1J6u8cX+eIg+h6q/3/bKF8keRRu5+qMRJ02zrXFyH
         +lnjVrVrQfYHFNGOdFLLSDfrLAhROfGW79Y39e9JroyM9lB41yCusppobchA/9Ej+CwP
         9L+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313560; x=1765918360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUP/0ib7NzaQ10lNwrazeH9U5sdGAZQbx8k0mwKac3A=;
        b=C2KRpRAND5T5BLfRfFkmJ2wEOk8PeMT+CNdxgJrOEBY+gN3Obco/dZDFiHGM7wOU58
         2wlU19c4uYLg9awPiNhLKGRVsayS/DfEQfH2xD0cxfSNbW8OJ0dxXNnuxug3OxZ5ROCa
         6YpF+swrQhk3iYfn/kvk0i0+rr+ooqFmW1kO6yMrjSmuRLHCkhd6AhVO1RlebD6kKM6H
         QPK6hVcPsBmHB+qPWU6khVbKwqDOo7Zm39zduov1cv//2bJQmjAtPnQMnad2pUoC80sF
         JxYlN8QMUvDa7SWy4lLLPUUCpLSjcuQ7jT6KnE4Zyg8ulM/PzI0ojxAl2/MQuecrkLke
         SvCg==
X-Forwarded-Encrypted: i=1; AJvYcCUC9CKIUVFv8U7vI3FXPl30NvAtnTAk1PxkTABq82ZaS4ta00FoVMY31Q/1VQDeFLbkEnm6MKTntOLppxGLpC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3cCdI6LO9UMxtsuvDP73q/IE+TOW828UAZiK9eKKdPSe3Y8Y4
	lRRTr84rRByHFlTFcQuhW7qrXhCgQ07tRFKKcgIhOVPqZPOz2Mfm9lT+iy7WGzmVwRUzMWvt+6X
	HTgbLNet2+3Fr2OrJ3E71AToPVA==
X-Google-Smtp-Source: AGHT+IHv8RQaXDHSivPTTeXk+3zR5MzJWrGN3A5PRODa9gDMtjaBK34a4o7xl6Y/q37pYaHLo9SGb0iM2yaoKrXonQ==
X-Received: from ilbck11.prod.google.com ([2002:a05:6e02:370b:b0:430:c380:c567])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a4a:edc9:0:b0:659:9a49:8eb9 with SMTP id 006d021491bc7-65b2ad5ba6emr124789eaf.61.1765313560115;
 Tue, 09 Dec 2025 12:52:40 -0800 (PST)
Date: Tue,  9 Dec 2025 20:51:11 +0000
In-Reply-To: <20251209205121.1871534-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251209205121.1871534-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251209205121.1871534-15-coltonlewis@google.com>
Subject: [PATCH v5 14/24] KVM: arm64: Write fast path PMU register handlers
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

We may want a partitioned PMU but not have FEAT_FGT to untrap the
specific registers that would normally be untrapped. Add a handler for
those registers in the fast path so we can still get a performance
boost from partitioning.

The idea is to handle traps for all the PMU registers quickly by
writing through to the hardware as possible instead of hooking into
the emulated vPMU as the standard handlers in sys_regs.c do. Since
context switching will not happen without FGT, make sure to write both
physical and virtual registers so they stay in sync.

To assist with that, fill of the gaps in arm_pmuv3.h for helper
functions to read and write PMU registers and lift some of the access
checking functions from sys_regs.c to pmu.c

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/arm_pmuv3.h      |  37 ++++-
 arch/arm64/include/asm/kvm_pmu.h        |  25 +++
 arch/arm64/kvm/hyp/include/hyp/switch.h | 201 ++++++++++++++++++++++++
 arch/arm64/kvm/pmu.c                    |  40 +++++
 arch/arm64/kvm/sys_regs.c               |  41 +----
 5 files changed, 303 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 3e25c0313263c..41ec6730ebc62 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -39,6 +39,16 @@ static inline unsigned long read_pmevtypern(int n)
 	return 0;
 }
 
+static inline void write_pmxevcntr(u64 val)
+{
+	write_sysreg(val, pmxevcntr_el0);
+}
+
+static inline u64 read_pmxevcntr(void)
+{
+	return read_sysreg(pmxevcntr_el0);
+}
+
 static inline unsigned long read_pmmir(void)
 {
 	return read_cpuid(PMMIR_EL1);
@@ -105,21 +115,41 @@ static inline void write_pmcntenset(u64 val)
 	write_sysreg(val, pmcntenset_el0);
 }
 
+static inline u64 read_pmcntenset(void)
+{
+	return read_sysreg(pmcntenset_el0);
+}
+
 static inline void write_pmcntenclr(u64 val)
 {
 	write_sysreg(val, pmcntenclr_el0);
 }
 
+static inline u64 read_pmcntenclr(void)
+{
+	return read_sysreg(pmcntenclr_el0);
+}
+
 static inline void write_pmintenset(u64 val)
 {
 	write_sysreg(val, pmintenset_el1);
 }
 
+static inline u64 read_pmintenset(void)
+{
+	return read_sysreg(pmintenset_el1);
+}
+
 static inline void write_pmintenclr(u64 val)
 {
 	write_sysreg(val, pmintenclr_el1);
 }
 
+static inline u64 read_pmintenclr(void)
+{
+	return read_sysreg(pmintenclr_el1);
+}
+
 static inline void write_pmccfiltr(u64 val)
 {
 	write_sysreg(val, pmccfiltr_el0);
@@ -160,11 +190,16 @@ static inline u64 read_pmovsclr(void)
 	return read_sysreg(pmovsclr_el0);
 }
 
-static inline void write_pmuserenr(u32 val)
+static inline void write_pmuserenr(u64 val)
 {
 	write_sysreg(val, pmuserenr_el0);
 }
 
+static inline u64 read_pmuserenr(void)
+{
+	return read_sysreg(pmuserenr_el0);
+}
+
 static inline void write_pmuacr(u64 val)
 {
 	write_sysreg_s(val, SYS_PMUACR_EL1);
diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index 7297a697a4a62..60b8a48cad456 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -83,6 +83,11 @@ struct kvm_pmu_events *kvm_get_pmu_events(void);
 void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr);
 void kvm_clr_pmu_events(u64 clr);
 bool kvm_set_pmuserenr(u64 val);
+bool check_pmu_access_disabled(struct kvm_vcpu *vcpu, u64 flags);
+bool pmu_access_el0_disabled(struct kvm_vcpu *vcpu);
+bool pmu_access_event_counter_el0_disabled(struct kvm_vcpu *vcpu);
+bool pmu_access_cycle_counter_el0_disabled(struct kvm_vcpu *vcpu);
+bool pmu_counter_idx_valid(struct kvm_vcpu *vcpu, u64 idx);
 void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_resync_el0(void);
@@ -226,6 +231,26 @@ static inline bool kvm_set_pmuserenr(u64 val)
 {
 	return false;
 }
+static inline bool check_pmu_access_disabled(struct kvm_vcpu *vcpu, u64 flags)
+{
+	return false;
+}
+static inline bool pmu_access_el0_disabled(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+static inline bool pmu_access_event_counter_el0_disabled(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+static inline bool pmu_access_cycle_counter_el0_disabled(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+static inline bool pmu_counter_idx_valid(struct kvm_vcpu *vcpu, u64 idx)
+{
+	return false;
+}
 static inline void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu) {}
 static inline void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu) {}
 static inline void kvm_vcpu_reload_pmu(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 6e8050f260f34..40bd00df6c58f 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -24,12 +24,14 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_pmu.h>
 #include <asm/kvm_nested.h>
 #include <asm/fpsimd.h>
 #include <asm/debug-monitors.h>
 #include <asm/processor.h>
 #include <asm/traps.h>
 
+#include <../../sys_regs.h>
 #include "arm_psci.h"
 
 struct kvm_exception_table_entry {
@@ -768,6 +770,202 @@ static bool handle_ampere1_tcr(struct kvm_vcpu *vcpu)
 	return true;
 }
 
+/**
+ * handle_pmu_reg() - Handle fast access to most PMU regs
+ * @vcpu: Ponter to kvm_vcpu struct
+ * @p: System register parameters (read/write, Op0, Op1, CRm, CRn, Op2)
+ * @reg: VCPU register identifier
+ * @rt: Target general register
+ * @val: Value to write
+ * @readfn: Sysreg read function
+ * @writefn: Sysreg write function
+ *
+ * Handle fast access to most PMU regs. Writethrough to the physical
+ * register. This function is a wrapper for the simplest case, but
+ * sadly there aren't many of those.
+ *
+ * Always return true. The boolean makes usage more consistent with
+ * similar functions.
+ *
+ * Return: True
+ */
+static bool handle_pmu_reg(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+			   enum vcpu_sysreg reg, u8 rt, u64 val,
+			   u64 (*readfn)(void), void (*writefn)(u64))
+{
+	if (p->is_write) {
+		__vcpu_assign_sys_reg(vcpu, reg, val);
+		writefn(val);
+	} else {
+		vcpu_set_reg(vcpu, rt, readfn());
+	}
+
+	return true;
+}
+
+/**
+ * kvm_hyp_handle_pmu_regs() - Fast handler for PMU registers
+ * @vcpu: Pointer to vcpu struct
+ *
+ * This handler immediately writes through certain PMU registers when
+ * we have a partitioned PMU (that is, MDCR_EL2.HPMN is set to reserve
+ * a range of counters for the guest) but the machine does not have
+ * FEAT_FGT to selectively untrap the registers we want.
+ *
+ * Return: True if the exception was successfully handled, false otherwise
+ */
+static bool kvm_hyp_handle_pmu_regs(struct kvm_vcpu *vcpu)
+{
+	struct sys_reg_params p;
+	u64 esr;
+	u32 sysreg;
+	u8 rt;
+	u64 val;
+	u64 mask;
+	u8 idx;
+	bool ret;
+
+	if (!kvm_vcpu_pmu_is_partitioned(vcpu)
+	    || pmu_access_el0_disabled(vcpu))
+		return false;
+
+	esr = kvm_vcpu_get_esr(vcpu);
+	p = esr_sys64_to_params(esr);
+	sysreg = esr_sys64_to_sysreg(esr);
+	rt = kvm_vcpu_sys_get_rt(vcpu);
+	val = vcpu_get_reg(vcpu, rt);
+
+	switch (sysreg) {
+	case SYS_PMCR_EL0:
+		mask = ARMV8_PMU_PMCR_MASK;
+
+		if (p.is_write) {
+			write_pmcr(val);
+			mask &= ~(ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C);
+			__vcpu_assign_sys_reg(vcpu, PMCR_EL0, val & mask);
+		} else {
+			val = u64_replace_bits(
+				read_pmcr(),
+				vcpu->kvm->arch.nr_pmu_counters,
+				ARMV8_PMU_PMCR_N);
+			vcpu_set_reg(vcpu, rt, val);
+		}
+
+		ret = true;
+		break;
+	case SYS_PMUSERENR_EL0:
+		mask = ARMV8_PMU_USERENR_MASK;
+		ret = handle_pmu_reg(vcpu, &p, PMUSERENR_EL0, rt, val & mask,
+				     &read_pmuserenr, &write_pmuserenr);
+		break;
+	case SYS_PMSELR_EL0:
+		mask = PMSELR_EL0_SEL_MASK;
+
+		if (pmu_access_event_counter_el0_disabled(vcpu))
+			return false;
+
+		ret = handle_pmu_reg(vcpu, &p, PMSELR_EL0, rt, val & mask,
+				     &read_pmselr, &write_pmselr);
+		break;
+	case SYS_PMINTENCLR_EL1:
+		mask = kvm_pmu_accessible_counter_mask(vcpu);
+
+		if (p.is_write) {
+			__vcpu_rmw_sys_reg(vcpu, PMINTENSET_EL1, &=, ~(val & mask));
+			write_pmintenclr(val);
+		} else {
+			val = read_pmintenclr();
+			vcpu_set_reg(vcpu, rt, val & mask);
+		}
+		ret = true;
+
+		break;
+	case SYS_PMINTENSET_EL1:
+		mask = kvm_pmu_accessible_counter_mask(vcpu);
+
+		if (p.is_write) {
+			__vcpu_rmw_sys_reg(vcpu, PMINTENSET_EL1, |=, val & mask);
+			write_pmintenset(val);
+		} else {
+			val = read_pmintenset();
+			vcpu_set_reg(vcpu, rt, val & mask);
+		}
+
+		ret = true;
+		break;
+	case SYS_PMCNTENCLR_EL0:
+		mask = kvm_pmu_accessible_counter_mask(vcpu);
+
+		if (p.is_write) {
+			__vcpu_rmw_sys_reg(vcpu, PMCNTENSET_EL0, &=, ~(val & mask));
+			write_pmcntenclr(val);
+		} else {
+			val = read_pmcntenclr();
+			vcpu_set_reg(vcpu, rt, val & mask);
+		}
+
+		ret = true;
+		break;
+	case SYS_PMCNTENSET_EL0:
+		mask = kvm_pmu_accessible_counter_mask(vcpu);
+
+		if (p.is_write) {
+			__vcpu_rmw_sys_reg(vcpu, PMCNTENSET_EL0, |=, val & mask);
+			write_pmcntenset(val);
+		} else {
+			val = read_pmcntenset();
+			vcpu_set_reg(vcpu, rt, val & mask);
+		}
+
+		ret = true;
+		break;
+	case SYS_PMCCNTR_EL0:
+		if (pmu_access_cycle_counter_el0_disabled(vcpu))
+			return false;
+
+		ret = handle_pmu_reg(vcpu, &p, PMCCNTR_EL0, rt, val,
+				     &read_pmccntr, &write_pmccntr);
+		break;
+	case SYS_PMXEVCNTR_EL0:
+		idx = FIELD_GET(PMSELR_EL0_SEL, read_pmselr());
+
+		if (pmu_access_event_counter_el0_disabled(vcpu))
+			return false;
+
+		if (!pmu_counter_idx_valid(vcpu, idx))
+			return false;
+
+		ret = handle_pmu_reg(vcpu, &p, PMEVCNTR0_EL0 + idx, rt, val,
+				     &read_pmxevcntr, &write_pmxevcntr);
+		break;
+	case SYS_PMEVCNTRn_EL0(0) ... SYS_PMEVCNTRn_EL0(30):
+		idx = ((p.CRm & 3) << 3) | (p.Op2 & 7);
+
+		if (pmu_access_event_counter_el0_disabled(vcpu))
+			return false;
+
+		if (!pmu_counter_idx_valid(vcpu, idx))
+			return false;
+
+		if (p.is_write) {
+			write_pmevcntrn(idx, val);
+			__vcpu_assign_sys_reg(vcpu, PMEVCNTR0_EL0 + idx, val);
+		} else {
+			vcpu_set_reg(vcpu, rt, read_pmevcntrn(idx));
+		}
+
+		ret = true;
+		break;
+	default:
+		ret = false;
+	}
+
+	if (ret)
+		__kvm_skip_instr(vcpu);
+
+	return ret;
+}
+
 static inline bool kvm_hyp_handle_sysreg(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	if (cpus_have_final_cap(ARM64_WORKAROUND_CAVIUM_TX2_219_TVM) &&
@@ -785,6 +983,9 @@ static inline bool kvm_hyp_handle_sysreg(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (kvm_handle_cntxct(vcpu))
 		return true;
 
+	if (kvm_hyp_handle_pmu_regs(vcpu))
+		return true;
+
 	return false;
 }
 
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 79b7ea037153a..1fd012f8ff4a9 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -884,3 +884,43 @@ u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
 
 	return u64_replace_bits(pmcr, n, ARMV8_PMU_PMCR_N);
 }
+
+bool check_pmu_access_disabled(struct kvm_vcpu *vcpu, u64 flags)
+{
+	u64 reg = __vcpu_sys_reg(vcpu, PMUSERENR_EL0);
+	bool enabled = (reg & flags) || vcpu_mode_priv(vcpu);
+
+	if (!enabled)
+		kvm_inject_undefined(vcpu);
+
+	return !enabled;
+}
+
+bool pmu_access_el0_disabled(struct kvm_vcpu *vcpu)
+{
+	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_EN);
+}
+
+bool pmu_counter_idx_valid(struct kvm_vcpu *vcpu, u64 idx)
+{
+	u64 pmcr, val;
+
+	pmcr = kvm_vcpu_read_pmcr(vcpu);
+	val = FIELD_GET(ARMV8_PMU_PMCR_N, pmcr);
+	if (idx >= val && idx != ARMV8_PMU_CYCLE_IDX) {
+		kvm_inject_undefined(vcpu);
+		return false;
+	}
+
+	return true;
+}
+
+bool pmu_access_cycle_counter_el0_disabled(struct kvm_vcpu *vcpu)
+{
+	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_CR | ARMV8_PMU_USERENR_EN);
+}
+
+bool pmu_access_event_counter_el0_disabled(struct kvm_vcpu *vcpu)
+{
+	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_EN);
+}
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index bee892db9ca8b..70104087b6c7b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -29,6 +29,7 @@
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nested.h>
+#include <asm/kvm_pmu.h>
 #include <asm/perf_event.h>
 #include <asm/sysreg.h>
 
@@ -970,37 +971,11 @@ static u64 reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	return __vcpu_sys_reg(vcpu, r->reg);
 }
 
-static bool check_pmu_access_disabled(struct kvm_vcpu *vcpu, u64 flags)
-{
-	u64 reg = __vcpu_sys_reg(vcpu, PMUSERENR_EL0);
-	bool enabled = (reg & flags) || vcpu_mode_priv(vcpu);
-
-	if (!enabled)
-		kvm_inject_undefined(vcpu);
-
-	return !enabled;
-}
-
-static bool pmu_access_el0_disabled(struct kvm_vcpu *vcpu)
-{
-	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_EN);
-}
-
 static bool pmu_write_swinc_el0_disabled(struct kvm_vcpu *vcpu)
 {
 	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_SW | ARMV8_PMU_USERENR_EN);
 }
 
-static bool pmu_access_cycle_counter_el0_disabled(struct kvm_vcpu *vcpu)
-{
-	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_CR | ARMV8_PMU_USERENR_EN);
-}
-
-static bool pmu_access_event_counter_el0_disabled(struct kvm_vcpu *vcpu)
-{
-	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_EN);
-}
-
 static bool access_pmcr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			const struct sys_reg_desc *r)
 {
@@ -1067,20 +1042,6 @@ static bool access_pmceid(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	return true;
 }
 
-static bool pmu_counter_idx_valid(struct kvm_vcpu *vcpu, u64 idx)
-{
-	u64 pmcr, val;
-
-	pmcr = kvm_vcpu_read_pmcr(vcpu);
-	val = FIELD_GET(ARMV8_PMU_PMCR_N, pmcr);
-	if (idx >= val && idx != ARMV8_PMU_CYCLE_IDX) {
-		kvm_inject_undefined(vcpu);
-		return false;
-	}
-
-	return true;
-}
-
 static int get_pmu_evcntr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 			  u64 *val)
 {
-- 
2.52.0.239.gd5f0c6e74e-goog


