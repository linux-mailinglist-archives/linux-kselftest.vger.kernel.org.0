Return-Path: <linux-kselftest+bounces-29671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A525A6E12E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800D517313F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896DA2641F4;
	Mon, 24 Mar 2025 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1/Uw2FH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9713E26868A
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837607; cv=none; b=qIdrjKWwLSkdciSSiRQVmjAv8I1bZyu2ENum9HD7Z3He5ysDg1fZlBZj6WV/lYuOVBOaXvhbKMkz+cdSwb906ASfhcc05MhfLYau6HPIPbu/oNMABQUY5KfbFl8flWGkt5kJ4m1lV4hAi4OujQX2ATgeqSPry3KBH8L2M+r4icU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837607; c=relaxed/simple;
	bh=emJID9XX/emVac8xSMbNVk6xY1SY9CZZ7m+C7kd5oSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kEx9EcUvRpB3YQ4b0B+/2jHuuvxhP7UtBSSliVCkOVTpqHz0Up93PY1KYWt5gDTzxZJqIMLyGvG0SnvfDspQSPow1L0SSVAFt2/oWBNzut39m4+mPVBs/WO4WtENfXcwv+jxyfKRgflt+htX6mbxFNITxoMFOn3R/L2JBSzAx6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z1/Uw2FH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff8340d547so8785335a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837605; x=1743442405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sw4JUssCmzWmsW/5UbAE8xBYLkC17nTe5sdEWfUAlzM=;
        b=Z1/Uw2FHJ85pG5weLiVCQY63n6qzW5ohcplgjb4sUNZ9JZUx4mJe3ARVFFNTRN5nxP
         ICbDH/moAwVtEWRF5mHMnO+X/c2eV1VUBEmgSBMxM459ZPOXhPVSLno9sds6RCC7Y2GM
         KSwTE24IA3Xg9kkpwe+52P86n8mb7H63PhRWyeSCZ2TGN5ODxzAnv+HTW13fIQhGjQNa
         4KUVwTermYoLOCcffGo19V3Uy7rjgJ+ZXzH6rv+Dz7OIBDQnOSkFyMntNiZ0yyqz21Wd
         884/i16yhbxdO520M3b9IwextC7fDG94+e8yF7vZ+xDzy/e3C+nbjA394+0w1xXrZh/A
         sptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837605; x=1743442405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sw4JUssCmzWmsW/5UbAE8xBYLkC17nTe5sdEWfUAlzM=;
        b=ahv5igy7B8Aq6xGLwwq3Oe6iyrM22uwoBxtJcbgmOdyj4YYdgz2aB+FeZC78+ge8e3
         lnrEmhtfVVh+HT5/vmo9TMwkS9YQr6JmNUeSvrBGP9C8FnC8v8VuftAhXYgkLEvfEubU
         G66cZGg0aEYqdVZxQa3DBjE2LY83fteo+ECNnbWgfnPH0a4FPdgwWusxseGyK0l82ZR5
         SILrmp69cBJfqmSCm7Bl8QUWGqZHfUSJNzo+dUtwGLBdAet6P0IIOB0TvAMogNmE/hqv
         qtoSEFMm6xUjSbIX8L10KcDdiXYCrOAEgNuPE5mtYy7TpPWYRFnCbwsI7MluKQKoi4+V
         psLA==
X-Forwarded-Encrypted: i=1; AJvYcCVYtwPEocONyf0XOsjFu0sWMw9I+sYDWXFMW1dPui5u72F0vjvDTenSEs89lx45XPfB4p5qZdziMLiUE4Nu/6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLHM38z76MfrA09YVm2LXHsOo/bi6dKXOavVNVRNoazPuhLCk
	kzXJIogWlxxs/7NkP9W8JHbM/QTpDleG4Hs/lkchCmFR1xgcRPEzqNdSeGn1JpUFHz96bcVp6XR
	s1pEejQ==
X-Google-Smtp-Source: AGHT+IEkmnOY6fpnDhzWr8K9H40U6Qpwh/FYlgWiXfKWlM5pYqW2YEqLpPv1uhdG73giN+aDE0bsUDcUH/vd
X-Received: from pjbsj16.prod.google.com ([2002:a17:90b:2d90:b0:301:a339:b558])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7c4:b0:2ee:f440:53ed
 with SMTP id 98e67ed59e1d1-3030ff06d11mr20578622a91.31.1742837605001; Mon, 24
 Mar 2025 10:33:25 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:00 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-21-mizhang@google.com>
Subject: [PATCH v4 20/38] KVM: x86/pmu: Check if mediated vPMU can intercept rdpmc
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

Check if rdpmc can be intercepted for mediated vPMU. Simply speaking,
if guest own all PMU counters in mediated vPMU, then rdpmc interception
should be disabled to mitigate the performance impact, otherwise rdpmc
has to be intercepted to avoid guest obtain host counter's data via
rdpmc instruction.

Co-developed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Co-developed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/kvm/pmu.c               | 34 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/pmu.h               | 19 ++++++++++++++++++
 arch/x86/kvm/svm/pmu.c           | 14 ++++++++++++-
 arch/x86/kvm/vmx/pmu_intel.c     | 18 ++++++++---------
 5 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ca70846ffd55..337f4b0a2998 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -312,6 +312,7 @@
 #define PERF_CAP_PEBS_FORMAT		0xf00
 #define PERF_CAP_FW_WRITES		BIT_ULL(13)
 #define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
+#define PERF_CAP_PERF_METRICS		BIT_ULL(15)
 #define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
 					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE)
 
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 92c742ead663..6ad71752be4b 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -604,6 +604,40 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	return 0;
 }
 
+inline bool kvm_rdpmc_in_guest(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	if (!kvm_mediated_pmu_enabled(vcpu))
+		return false;
+
+	/*
+	 * VMware allows access to these Pseduo-PMCs even when read via RDPMC
+	 * in Ring3 when CR4.PCE=0.
+	 */
+	if (enable_vmware_backdoor)
+		return false;
+
+	/*
+	 * FIXME: In theory, perf metrics is always combined with fixed
+	 *	  counter 3. it's fair enough to compare the guest and host
+	 *	  fixed counter number and don't need to check perf metrics
+	 *	  explicitly. However kvm_pmu_cap.num_counters_fixed is limited
+	 *	  KVM_MAX_NR_FIXED_COUNTERS (3) as fixed counter 3 is not
+	 *	  supported now. perf metrics is still needed to be checked
+	 *	  explicitly here. Once fixed counter 3 is supported, the perf
+	 *	  metrics checking can be removed.
+	 */
+	return pmu->nr_arch_gp_counters == kvm_pmu_cap.num_counters_gp &&
+	       pmu->nr_arch_fixed_counters == kvm_pmu_cap.num_counters_fixed &&
+	       vcpu_has_perf_metrics(vcpu) == kvm_host_has_perf_metrics() &&
+	       pmu->counter_bitmask[KVM_PMC_GP] ==
+				(BIT_ULL(kvm_pmu_cap.bit_width_gp) - 1) &&
+	       pmu->counter_bitmask[KVM_PMC_FIXED] ==
+				(BIT_ULL(kvm_pmu_cap.bit_width_fixed) - 1);
+}
+EXPORT_SYMBOL_GPL(kvm_rdpmc_in_guest);
+
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu)
 {
 	if (lapic_in_kernel(vcpu)) {
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index e1d0096f249b..509c995b7871 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -271,6 +271,24 @@ static inline bool pmc_is_globally_enabled(struct kvm_pmc *pmc)
 	return test_bit(pmc->idx, (unsigned long *)&pmu->global_ctrl);
 }
 
+static inline u64 vcpu_get_perf_capabilities(struct kvm_vcpu *vcpu)
+{
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
+		return 0;
+
+	return vcpu->arch.perf_capabilities;
+}
+
+static inline bool vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
+{
+	return !!(vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PERF_METRICS);
+}
+
+static inline bool kvm_host_has_perf_metrics(void)
+{
+	return !!(kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS);
+}
+
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
 void kvm_pmu_handle_event(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
@@ -287,6 +305,7 @@ void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel);
 bool vcpu_pmu_can_enable(struct kvm_vcpu *vcpu);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
+bool kvm_rdpmc_in_guest(struct kvm_vcpu *vcpu);
 
 extern struct kvm_pmu_ops intel_pmu_ops;
 extern struct kvm_pmu_ops amd_pmu_ops;
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index c8b9fd9b5350..153972e944eb 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -173,7 +173,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 1;
 }
 
-static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
+static void __amd_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	union cpuid_0x80000022_ebx ebx;
@@ -212,6 +212,18 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
 }
 
+static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	__amd_pmu_refresh(vcpu);
+
+	if (kvm_rdpmc_in_guest(vcpu))
+		svm_clr_intercept(svm, INTERCEPT_RDPMC);
+	else
+		svm_set_intercept(svm, INTERCEPT_RDPMC);
+}
+
 static void amd_pmu_init(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index fc017e9a6a0c..2a5f79206b02 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -108,14 +108,6 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 	return &counters[array_index_nospec(idx, num_counters)];
 }
 
-static inline u64 vcpu_get_perf_capabilities(struct kvm_vcpu *vcpu)
-{
-	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
-		return 0;
-
-	return vcpu->arch.perf_capabilities;
-}
-
 static inline bool fw_writes_is_enabled(struct kvm_vcpu *vcpu)
 {
 	return (vcpu_get_perf_capabilities(vcpu) & PERF_CAP_FW_WRITES) != 0;
@@ -456,7 +448,7 @@ static void intel_pmu_enable_fixed_counter_bits(struct kvm_pmu *pmu, u64 bits)
 		pmu->fixed_ctr_ctrl_rsvd &= ~intel_fixed_bits_by_idx(i, bits);
 }
 
-static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
+static void __intel_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct lbr_desc *lbr_desc = vcpu_to_lbr_desc(vcpu);
@@ -564,6 +556,14 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
+{
+	__intel_pmu_refresh(vcpu);
+
+	exec_controls_changebit(to_vmx(vcpu), CPU_BASED_RDPMC_EXITING,
+				!kvm_rdpmc_in_guest(vcpu));
+}
+
 static void intel_pmu_init(struct kvm_vcpu *vcpu)
 {
 	int i;
-- 
2.49.0.395.g12beb8f557-goog


