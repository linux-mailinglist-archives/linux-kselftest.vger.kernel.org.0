Return-Path: <linux-kselftest+bounces-35484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6578AAE253D
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03B418961F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813F42586EF;
	Fri, 20 Jun 2025 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dod4uq0G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6925522B
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457937; cv=none; b=W0bq3l71RKh1dkAKjIi03cnMh5DWSlaSwiOJ3cKpGU2HQqHvpG/jDXcgV63FFCeQ3Qc+DwZLBbjnb32GlBvpBV9OZkuekypM0kBLopXeGs6+Q7k9znD4Xpap3FEXhv0VPTqLQysUTCdLKugegm93Iw9p26ELfnRXnzfMUF8I5d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457937; c=relaxed/simple;
	bh=Fgy9N61EGbaW+2jj77gOoaKWPvYvkLRmPo8eHGIeOZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ax9TvVsG94TwVZF2I5vK6LPzIHo9McPkJhjUrOn/2/bCdv/dS99yFjUBgdIpmdOb7ApVxrZYuUqIXXMybSwCqok1Igz0K/uRSprtcOUklP0u+DEKs9RvNkHh5jWTPiFaykhQwBBYGsgk91GAx38Pj+yFb4+gqWtG681yyypFis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dod4uq0G; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-8730ca8143eso191270739f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457933; x=1751062733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5lFo8UoLWpKLNujXhqrIEmnLXEDG4SKwogS8dxIvDeU=;
        b=dod4uq0Gvrb/5HoDU6C6iu0/rIOgaAcpGwo1qkG9N6y+96czRObnWihYlVFUf9HRwn
         1SqA5nxu+/wcdkAfS6WBYBl+DV6jSQsuU7DsDzdMmlcqT0R0Bgi4KzL6zT6CfOYV15nZ
         Fn3v6lhcirJFCQdQRaEzKMDGgeoBKJ0hAd6RSaLOZQxV1PlL0jgKvtqFydew58nZXuXz
         1BJh90nMoCp7RW19vzz/RVd+CmAVm28yJ9yGOUb7ZVYV67hQ7Uf6aSxrY1DGjBizS3a/
         rdUugNzTSPnDOFWhVUlKYdhRYV+M/WNOmjoV5SGsO/To7d/8NYKACKpR70GNF0LI3gN2
         +wGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457933; x=1751062733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5lFo8UoLWpKLNujXhqrIEmnLXEDG4SKwogS8dxIvDeU=;
        b=bitARe5xaExAHeupqwRazvM8szbxj1cOZ2voCnJ7AYahXJfgRj4e2/79vz7HIwVAz0
         SiU4GU2l95wXmab+DHS30j5BDW88WMWIUWt0zunqQgd+Sg4NjtL4kh9AA4zYCPlo9tmD
         u7GNpADPShDvDlrxkukSkxeUm7c3HEil11r5FROCsOuv5wmTpDqUo04nf58dkh/7wTuN
         FMD3LplIoDvZPMz7OBKsP+GBvAiNJUdM+BZrvyjQ+7C3JzJGWPdkH6nRGQdFkCvq8g1m
         4DgVr6sZUAJ/MJzmGTRYiU0ouTelj+X8rM+KW/7+0l0Aig/XAZeoL58exEPiCKzUCutv
         KRlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj3qJeQ386p4TwjdXOSQ3HnJemD9ba/vEHnGXNQ96/uLRyg5KVOibdxgx4NCjK1rqUB3X6npu1SuUwGO+pw8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrt1eY95iyWdcqKM3NhOICEnuMA3WdSMtmgbn6Fmx9DcHYUk9I
	YSIQVhYc+4CYUNyAU/AbNwG8zFZMzyZ/jviH+R8MNEq1FpPnJi2il80Vel/FfP7b3Dfy6XBAkvc
	ZhdlIboS2rIcFPfPqpJzWpDmthw==
X-Google-Smtp-Source: AGHT+IGAbHdbdz1QS9prM+U7BA3VvdkmpAqUwikGNLGBai/ylX3I975t5q0qFV+Kxl3tRuCG/iIvJmE+cZNaYmg53A==
X-Received: from ilbbs18.prod.google.com ([2002:a05:6e02:2412:b0:3de:deaf:795f])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1447:b0:3dd:bf91:23f7 with SMTP id e9e14a558f8ab-3de39593521mr41196005ab.7.1750457933102;
 Fri, 20 Jun 2025 15:18:53 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:16 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-17-coltonlewis@google.com>
Subject: [PATCH v2 15/23] KVM: arm64: Write fast path PMU register handlers
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

We may want a partitioned PMU but not have FEAT_FGT to untrap the
specific registers that would normally be. Add a handler for those
registers in the fast path so we can still get a performance boost
from partitioning.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/arm_pmuv3.h      |  37 ++++-
 arch/arm64/include/asm/kvm_pmu.h        |   1 +
 arch/arm64/kvm/hyp/include/hyp/switch.h | 174 ++++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.c               |   4 +-
 4 files changed, 213 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 3bddde5f4ebb..12004fd04018 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -41,6 +41,16 @@ static inline unsigned long read_pmevtypern(int n)
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
@@ -107,21 +117,41 @@ static inline void write_pmcntenset(u64 val)
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
@@ -162,11 +192,16 @@ static inline u64 read_pmovsclr(void)
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
index 02984cfeb446..4e205327b94e 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -79,6 +79,7 @@ struct kvm_pmu_events *kvm_get_pmu_events(void);
 void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr);
 void kvm_clr_pmu_events(u64 clr);
 bool kvm_set_pmuserenr(u64 val);
+bool pmu_access_el0_disabled(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_resync_el0(void);
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 47d2db8446df..4920b7da9ce8 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -25,12 +25,14 @@
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
@@ -782,6 +784,175 @@ static bool handle_ampere1_tcr(struct kvm_vcpu *vcpu)
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
+		val &= ARMV8_PMU_PMCR_MASK;
+
+		if (p.is_write) {
+			write_pmcr(val);
+			__vcpu_assign_sys_reg(vcpu, PMCR_EL0, read_pmcr());
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
+		val &= ARMV8_PMU_USERENR_MASK;
+		ret = handle_pmu_reg(vcpu, &p, PMUSERENR_EL0, rt, val,
+				     &read_pmuserenr, &write_pmuserenr);
+		break;
+	case SYS_PMSELR_EL0:
+		val &= PMSELR_EL0_SEL_MASK;
+		ret = handle_pmu_reg(vcpu, &p, PMSELR_EL0, rt, val,
+				     &read_pmselr, &write_pmselr);
+		break;
+	case SYS_PMINTENCLR_EL1:
+		val &= kvm_pmu_accessible_counter_mask(vcpu);
+		if (p.is_write) {
+			__vcpu_rmw_sys_reg(vcpu, PMINTENSET_EL1, &=, ~val);
+			write_pmintenclr(val);
+		} else {
+			vcpu_set_reg(vcpu, rt, read_pmintenclr());
+		}
+		ret = true;
+		break;
+	case SYS_PMINTENSET_EL1:
+		val &= kvm_pmu_accessible_counter_mask(vcpu);
+		if (p.is_write) {
+			__vcpu_rmw_sys_reg(vcpu, PMINTENSET_EL1, |=, val);
+			write_pmintenset(val);
+		} else {
+			vcpu_set_reg(vcpu, rt, read_pmintenset());
+		}
+		ret = true;
+		break;
+	case SYS_PMCNTENCLR_EL0:
+		val &= kvm_pmu_accessible_counter_mask(vcpu);
+		if (p.is_write) {
+			__vcpu_rmw_sys_reg(vcpu, PMCNTENSET_EL0, &=, ~val);
+			write_pmcntenclr(val);
+		} else {
+			vcpu_set_reg(vcpu, rt, read_pmcntenclr());
+		}
+		ret = true;
+		break;
+	case SYS_PMCNTENSET_EL0:
+		val &= kvm_pmu_accessible_counter_mask(vcpu);
+		if (p.is_write) {
+			__vcpu_rmw_sys_reg(vcpu, PMCNTENSET_EL0, |=, val);
+			write_pmcntenset(val);
+		} else {
+			vcpu_set_reg(vcpu, rt, read_pmcntenset());
+		}
+		ret = true;
+		break;
+	case SYS_PMCCNTR_EL0:
+		ret = handle_pmu_reg(vcpu, &p, PMCCNTR_EL0, rt, val,
+				     &read_pmccntr, &write_pmccntr);
+		break;
+	case SYS_PMXEVCNTR_EL0:
+		idx = FIELD_GET(PMSELR_EL0_SEL, read_pmselr());
+
+		if (idx >= vcpu->kvm->arch.nr_pmu_counters)
+			return false;
+
+		ret = handle_pmu_reg(vcpu, &p, PMEVCNTR0_EL0 + idx, rt, val,
+				     &read_pmxevcntr, &write_pmxevcntr);
+		break;
+	case SYS_PMEVCNTRn_EL0(0) ... SYS_PMEVCNTRn_EL0(30):
+		idx = ((p.CRm & 3) << 3) | (p.Op2 & 7);
+
+		if (idx >= vcpu->kvm->arch.nr_pmu_counters)
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
@@ -799,6 +970,9 @@ static inline bool kvm_hyp_handle_sysreg(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (kvm_handle_cntxct(vcpu))
 		return true;
 
+	if (kvm_hyp_handle_pmu_regs(vcpu))
+		return true;
+
 	return false;
 }
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 627c31db84d2..1ea7d092ec59 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -853,7 +853,7 @@ static bool check_pmu_access_disabled(struct kvm_vcpu *vcpu, u64 flags)
 	return !enabled;
 }
 
-static bool pmu_access_el0_disabled(struct kvm_vcpu *vcpu)
+bool pmu_access_el0_disabled(struct kvm_vcpu *vcpu)
 {
 	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_EN);
 }
@@ -1053,7 +1053,7 @@ static bool writethrough_pmevtyper(struct kvm_vcpu *vcpu, struct sys_reg_params
 	    !test_bit(eventsel, vcpu->kvm->arch.pmu_filter))
 		return false;
 
-	__vcpu_sys_reg(vcpu, reg) = eventsel;
+	__vcpu_assign_sys_reg(vcpu, reg, eventsel);
 
 	if (idx == ARMV8_PMU_CYCLE_IDX)
 		write_pmccfiltr(eventsel);
-- 
2.50.0.714.g196bf9f422-goog


