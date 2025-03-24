Return-Path: <linux-kselftest+bounces-29680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFF6A6E1F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 19:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2B13BCCE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D4D26A1D4;
	Mon, 24 Mar 2025 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nVTXNBwp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63526A1A0
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837621; cv=none; b=J1ox0n3asljtgmbqWww36vB95IqWOXjHyn2q6nUcZ2SJGoqytloCpOsqZNqSYbe8ofT+IlBwzAKTDAwSd4ntO5xZSbUV5rpf3YOPiTgmr95h5huG241YwDlcvWIRiXsMAWZytcankxMl/5YVL9lmKHI+uQFOZq+Ack/ao0I5zgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837621; c=relaxed/simple;
	bh=OPw487ed2bKDiogk+R3usk/ZQ2/yI+2RyoUZkiY73s4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qSHBtgEQk6gppf03mPmd7YAPi16a10Nyh7slU2m2G4Pj0L+KKuyOwkVwjRQ5DnwRlMJRH5w+btJn7YRD7Uqp/jVZ1gkEKhvCJQb+k14GABR+smrC5ADEkGuCjon0AaX7tc5ujUZI6dYFv/OrCI8iZUkHGFUZs6F2DRmjzsW0Am8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nVTXNBwp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso13098694a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837619; x=1743442419; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kL+7KIqLv3Egxp6P/dAYOlfZUppvzqtnReXi+8P4zTQ=;
        b=nVTXNBwpd8F+Q4y+YWHPMakG0FUpheOZwxbm1oGRhzoCbDtIcN367qmFt4TaYW7ydj
         kSk6/tzlhk0sV08FtZdQcXxIsXQQp28Enenya2GTTsk8EVdMnJJMvMLde5Ocax63Nav8
         Z0+/4tAS5XyKRAdMqG/PkV9TSnDWAnSV/Lqdxy8JDKVL0HBQEDBWxLNlM4kWoxJOqS+M
         I3fN9v4ErgC4c5/fhWP20kvOBKZzBRwPq6Pmbc9x/QNvtEr9614aNtbRfhKnA/2OPzEX
         voD0Y946kBRRTfJgs6c1MDGw22FodzWNYvOX5OO+D0200K5dmFIPrpzb3vWIilTmJyVw
         0eIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837619; x=1743442419;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kL+7KIqLv3Egxp6P/dAYOlfZUppvzqtnReXi+8P4zTQ=;
        b=XoHS70h9pmZn4khM6nwVSKK16nIJ7QeCsBrmlEAYyatG7Jh5dXgeTuqnRyE6OtWhPs
         6JLJV+5aWMe0c2Y6C6oU4jdFJx9CipHNz4Zx5ZupwRVOyZW+izdnoCN90Vwh/Co3M9p1
         ByRc0azoDMvPtXNW8yNXluU74yLppbMIOpM9j+iMv2AHGZpQ4HK12X+Dxr3cqKcT+PVa
         yL2PtcS00UdZGa2z07R1O27+3GhPi5nyngxyBSPXwMkk3x6XQzowZE/BbjKvw0jZ4iCP
         v0R667m1ohbejjW201yjE9hiDHaMArN/Gg7YFKVR54+jAktG/Z8RB5pf8C+f8jSOVhND
         Stqw==
X-Forwarded-Encrypted: i=1; AJvYcCVkqDUqlkXI3JV7mEO4J8SfMHjK3VrnOt3xa0IgDXH9NjKVhD7FCAgOYC/CyAug8oeLBEmuuSFxLrTNcIZPBYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ShixExqtVUIA2KDK+kf2DiE6LyH1EzwCd2kzk8CBAbMSOWBW
	qu2OTS9sUvojpG03NwhE84BjzumDLcJUo0QNJUInkdSqBAkE1wSDIYPH4fywohbXpqKkm23pWz2
	DEa6iww==
X-Google-Smtp-Source: AGHT+IFFt7nQF2snrjJwm4EP6MjmF4BWDt2Y4Obr2OfxUtVCi5bni9hKwtrVfpwZsx9viFJ0IBLp18xdhROF
X-Received: from pjur15.prod.google.com ([2002:a17:90a:d40f:b0:2fa:210c:d068])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2805:b0:2ee:aed6:9ec2
 with SMTP id 98e67ed59e1d1-3030fe85a4amr26513298a91.14.1742837619053; Mon, 24
 Mar 2025 10:33:39 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:09 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-30-mizhang@google.com>
Subject: [PATCH v4 29/38] KVM: x86/pmu: Switch host/guest PMU context at vm-exit/vm-entry
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

This patch supports to switch host/guest PMU context at
vm-exit/vm-entry for mediated vPMU.

In details, kvm_pmu_put_guest_context() is called to save guest PMU
context and load host PMU context at VM-exits and
kvm_pmu_load_guest_context() is called to save host PMU context and
load guest PMU context at vm-entries.

A pair of pmu_ops callbacks *put_guest_context() and
*load_guest_context() are added to save/restore vendor specific PMU
MSRs.

Co-developed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Co-developed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  2 +
 arch/x86/include/asm/kvm_host.h        |  4 ++
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kvm/pmu.c                     | 96 ++++++++++++++++++++++++++
 arch/x86/kvm/pmu.h                     | 11 +++
 arch/x86/kvm/svm/pmu.c                 | 54 +++++++++++++++
 arch/x86/kvm/vmx/pmu_intel.c           | 59 ++++++++++++++++
 arch/x86/kvm/x86.c                     |  4 ++
 8 files changed, 231 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index 9159bf1a4730..35f27366c277 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -22,6 +22,8 @@ KVM_X86_PMU_OP(init)
 KVM_X86_PMU_OP_OPTIONAL(reset)
 KVM_X86_PMU_OP_OPTIONAL(deliver_pmi)
 KVM_X86_PMU_OP_OPTIONAL(cleanup)
+KVM_X86_PMU_OP(put_guest_context)
+KVM_X86_PMU_OP(load_guest_context)
 
 #undef KVM_X86_PMU_OP
 #undef KVM_X86_PMU_OP_OPTIONAL
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7ee74bbbb0aa..4117a382739a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -568,6 +568,10 @@ struct kvm_pmu {
 	u64 raw_event_mask;
 	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
 	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
+	u32 gp_eventsel_base;
+	u32 gp_counter_base;
+	u32 fixed_base;
+	u32 cntr_shift;
 
 	/*
 	 * Overlay the bitmap with a 64-bit atomic so that all bits can be
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a4d8356e9b53..df33a4f026a1 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1153,6 +1153,7 @@
 #define MSR_CORE_PERF_GLOBAL_STATUS	0x0000038e
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x00000390
+#define MSR_CORE_PERF_GLOBAL_STATUS_SET	0x00000391
 
 #define MSR_PERF_METRICS		0x00000329
 
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index e9100dc49fdc..68f203454bbc 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1127,3 +1127,99 @@ int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp)
 	kfree(filter);
 	return r;
 }
+
+void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
+	u32 eventsel_msr;
+	u32 counter_msr;
+	u32 i;
+
+	/*
+	 * Clear hardware selector MSR content and its counter to avoid
+	 * leakage and also avoid this guest GP counter get accidentally
+	 * enabled during host running when host enable global ctrl.
+	 */
+	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+		pmc = &pmu->gp_counters[i];
+		eventsel_msr = pmc_msr_addr(pmu, pmu->gp_eventsel_base, i);
+		counter_msr = pmc_msr_addr(pmu, pmu->gp_counter_base, i);
+
+		rdpmcl(i, pmc->counter);
+		rdmsrl(eventsel_msr, pmc->eventsel_hw);
+		if (pmc->counter)
+			wrmsrl(counter_msr, 0);
+		if (pmc->eventsel_hw)
+			wrmsrl(eventsel_msr, 0);
+	}
+
+	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
+		pmc = &pmu->fixed_counters[i];
+		counter_msr = pmc_msr_addr(pmu, pmu->fixed_base, i);
+
+		rdpmcl(INTEL_PMC_FIXED_RDPMC_BASE | i, pmc->counter);
+		if (pmc->counter)
+			wrmsrl(counter_msr, 0);
+	}
+
+}
+EXPORT_SYMBOL_GPL(kvm_pmu_put_guest_pmcs);
+
+void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
+	u32 eventsel_msr;
+	u32 counter_msr;
+	u32 i;
+
+	/*
+	 * No need to zero out unexposed GP/fixed counters/selectors since RDPMC
+	 * in this case will be intercepted. Accessing to these counters and
+	 * selectors will cause #GP in the guest.
+	 */
+	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+		pmc = &pmu->gp_counters[i];
+		eventsel_msr = pmc_msr_addr(pmu, pmu->gp_eventsel_base, i);
+		counter_msr = pmc_msr_addr(pmu, pmu->gp_counter_base, i);
+
+		wrmsrl(counter_msr, pmc->counter);
+		wrmsrl(eventsel_msr, pmc->eventsel_hw);
+	}
+	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
+		pmc = &pmu->fixed_counters[i];
+		counter_msr = pmc_msr_addr(pmu, pmu->fixed_base, i);
+
+		wrmsrl(counter_msr, pmc->counter);
+	}
+}
+EXPORT_SYMBOL_GPL(kvm_pmu_load_guest_pmcs);
+
+void kvm_pmu_put_guest_context(struct kvm_vcpu *vcpu)
+{
+	if (!kvm_mediated_pmu_enabled(vcpu))
+		return;
+
+	lockdep_assert_irqs_disabled();
+
+	kvm_pmu_call(put_guest_context)(vcpu);
+
+	perf_guest_exit();
+}
+
+void kvm_pmu_load_guest_context(struct kvm_vcpu *vcpu)
+{
+	u32 guest_lvtpc;
+
+	if (!kvm_mediated_pmu_enabled(vcpu))
+		return;
+
+	lockdep_assert_irqs_disabled();
+
+	guest_lvtpc = APIC_DM_FIXED | KVM_GUEST_PMI_VECTOR |
+		(kvm_lapic_get_reg(vcpu->arch.apic, APIC_LVTPC) & APIC_LVT_MASKED);
+	perf_guest_enter(guest_lvtpc);
+
+	kvm_pmu_call(load_guest_context)(vcpu);
+}
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 6289f523d893..d5da3a9a3bd5 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -41,6 +41,8 @@ struct kvm_pmu_ops {
 	void (*reset)(struct kvm_vcpu *vcpu);
 	void (*deliver_pmi)(struct kvm_vcpu *vcpu);
 	void (*cleanup)(struct kvm_vcpu *vcpu);
+	void (*put_guest_context)(struct kvm_vcpu *vcpu);
+	void (*load_guest_context)(struct kvm_vcpu *vcpu);
 
 	const u64 EVENTSEL_EVENT;
 	const int MAX_NR_GP_COUNTERS;
@@ -292,6 +294,11 @@ static inline bool kvm_host_has_perf_metrics(void)
 	return !!(kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS);
 }
 
+static inline u32 pmc_msr_addr(struct kvm_pmu *pmu, u32 base, int idx)
+{
+	return base + idx * pmu->cntr_shift;
+}
+
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
 void kvm_pmu_handle_event(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
@@ -306,6 +313,10 @@ void kvm_pmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp);
 void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel);
 bool vcpu_pmu_can_enable(struct kvm_vcpu *vcpu);
+void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu);
+void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu);
+void kvm_pmu_put_guest_context(struct kvm_vcpu *vcpu);
+void kvm_pmu_load_guest_context(struct kvm_vcpu *vcpu);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
 bool kvm_rdpmc_in_guest(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 1a7e3a897fdf..7e0d84d50b74 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -175,6 +175,22 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 1;
 }
 
+static inline void amd_update_msr_base(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	if (kvm_pmu_has_perf_global_ctrl(pmu) ||
+	    guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE)) {
+		pmu->gp_eventsel_base = MSR_F15H_PERF_CTL0;
+		pmu->gp_counter_base = MSR_F15H_PERF_CTR0;
+		pmu->cntr_shift = 2;
+	} else {
+		pmu->gp_eventsel_base = MSR_K7_EVNTSEL0;
+		pmu->gp_counter_base = MSR_K7_PERFCTR0;
+		pmu->cntr_shift = 1;
+	}
+}
+
 static void __amd_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -220,6 +236,8 @@ static void __amd_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
 	pmu->nr_arch_fixed_counters = 0;
 	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
+
+	amd_update_msr_base(vcpu);
 }
 
 static void amd_pmu_update_msr_intercepts(struct kvm_vcpu *vcpu)
@@ -312,6 +330,40 @@ static void amd_pmu_init(struct kvm_vcpu *vcpu)
 	}
 }
 
+
+static void amd_put_guest_context(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, pmu->global_ctrl);
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, pmu->global_status);
+
+	/* Clear global status bits if non-zero */
+	if (pmu->global_status)
+		wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, pmu->global_status);
+
+	kvm_pmu_put_guest_pmcs(vcpu);
+}
+
+static void amd_load_guest_context(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	u64 global_status;
+
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+
+	kvm_pmu_load_guest_pmcs(vcpu);
+
+	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, global_status);
+	/* Clear host global_status MSR if non-zero. */
+	if (global_status)
+		wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, global_status);
+
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET, pmu->global_status);
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, pmu->global_ctrl);
+}
+
 struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
@@ -321,6 +373,8 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.set_msr = amd_pmu_set_msr,
 	.refresh = amd_pmu_refresh,
 	.init = amd_pmu_init,
+	.put_guest_context = amd_put_guest_context,
+	.load_guest_context = amd_load_guest_context,
 	.EVENTSEL_EVENT = AMD64_EVENTSEL_EVENT,
 	.MAX_NR_GP_COUNTERS = KVM_MAX_NR_AMD_GP_COUNTERS,
 	.MIN_NR_GP_COUNTERS = AMD64_NUM_COUNTERS,
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 796b7bc4affe..ed17ab198dfb 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -460,6 +460,17 @@ static void intel_pmu_enable_fixed_counter_bits(struct kvm_pmu *pmu, u64 bits)
 		pmu->fixed_ctr_ctrl_rsvd &= ~intel_fixed_bits_by_idx(i, bits);
 }
 
+static inline void intel_update_msr_base(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	pmu->gp_eventsel_base = MSR_P6_EVNTSEL0;
+	pmu->gp_counter_base = fw_writes_is_enabled(vcpu) ?
+			       MSR_IA32_PMC0 : MSR_IA32_PERFCTR0;
+	pmu->fixed_base = MSR_CORE_PERF_FIXED_CTR0;
+	pmu->cntr_shift = 1;
+}
+
 static void __intel_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -567,6 +578,8 @@ static void __intel_pmu_refresh(struct kvm_vcpu *vcpu)
 			pmu->pebs_enable_rsvd = ~(BIT_ULL(pmu->nr_arch_gp_counters) - 1);
 		}
 	}
+
+	intel_update_msr_base(vcpu);
 }
 
 static void intel_pmu_update_msr_intercepts(struct kvm_vcpu *vcpu)
@@ -809,6 +822,50 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
 	}
 }
 
+static void intel_put_guest_context(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	/* Global ctrl register is already saved at VM-exit. */
+	rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, pmu->global_status);
+
+	/* Clear hardware MSR_CORE_PERF_GLOBAL_STATUS MSR, if non-zero. */
+	if (pmu->global_status)
+		wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, pmu->global_status);
+
+	rdmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl_hw);
+
+	/*
+	 * Clear hardware FIXED_CTR_CTRL MSR to avoid information leakage and
+	 * also avoid these guest fixed counters get accidentially enabled
+	 * during host running when host enable global ctrl.
+	 */
+	if (pmu->fixed_ctr_ctrl_hw)
+		wrmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
+
+	kvm_pmu_put_guest_pmcs(vcpu);
+}
+
+static void intel_load_guest_context(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	u64 global_status, toggle;
+
+	/* Clear host global_ctrl MSR if non-zero. */
+	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
+
+	rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
+	toggle = pmu->global_status ^ global_status;
+	if (global_status & toggle)
+		wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, global_status & toggle);
+	if (pmu->global_status & toggle)
+		wrmsrl(MSR_CORE_PERF_GLOBAL_STATUS_SET, pmu->global_status & toggle);
+
+	wrmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl_hw);
+
+	kvm_pmu_load_guest_pmcs(vcpu);
+}
+
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.rdpmc_ecx_to_pmc = intel_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
@@ -820,6 +877,8 @@ struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.reset = intel_pmu_reset,
 	.deliver_pmi = intel_pmu_deliver_pmi,
 	.cleanup = intel_pmu_cleanup,
+	.put_guest_context = intel_put_guest_context,
+	.load_guest_context = intel_load_guest_context,
 	.EVENTSEL_EVENT = ARCH_PERFMON_EVENTSEL_EVENT,
 	.MAX_NR_GP_COUNTERS = KVM_MAX_NR_INTEL_GP_COUNTERS,
 	.MIN_NR_GP_COUNTERS = 1,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 578e5f110b6c..d35afa8d9cbb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10998,6 +10998,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(0, 7);
 	}
 
+	kvm_pmu_load_guest_context(vcpu);
+
 	guest_timing_enter_irqoff();
 
 	for (;;) {
@@ -11027,6 +11029,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		++vcpu->stat.exits;
 	}
 
+	kvm_pmu_put_guest_context(vcpu);
+
 	/*
 	 * Do this here before restoring debug registers on the host.  And
 	 * since we do this before handling the vmexit, a DR access vmexit
-- 
2.49.0.395.g12beb8f557-goog


