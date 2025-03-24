Return-Path: <linux-kselftest+bounces-29673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFC3A6E13E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18D91892A77
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA8C2690F4;
	Mon, 24 Mar 2025 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G9xW6DL1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87E268FDE
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837610; cv=none; b=qjCy8WNoWstIAjSkWhJA2Q2G6s5zMYnsHccnpjpcgeaasXFvY9GWgVyUbFlyj0k89/n85ZLtOvdZ55z/2y12vJsmuKe/+VqNXp7eNi7IJE1uZxSroH00zek5jiyhoXsaPVj6N9RWoczPv6jUalQWHXnMgp9xwW+0WmNJf6aeiaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837610; c=relaxed/simple;
	bh=DjiR7EBVDFq578TagmWuP100RH26sgH1+9KmgyBWQKo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SzAk+LdTXAEjjUAYsd4kYcs0obUjdUm9FAGkrnL49fjM6yGPHuj+hi74kZ+o+rR3waX+Qz0aVy6Tz8R2CaDgVy5vaian88UGiJCx1x2eXsyQg1umDQCKq60Nv9V5F0o2azE5cwFW5d7yTwII4H30tjmxvWM398/m+myibMJnzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G9xW6DL1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22406ee0243so57913615ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837608; x=1743442408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Hwx4wIJAsVYnLOl0ZG9MpTbW4pE4+Px1sfUV91deBgo=;
        b=G9xW6DL1fWTFSGLj51Glgh8C5uOilfLx8s24WCIqSuSbI3aN2dePzGZY9lYZqdXPTi
         0KUGLO0nJEADH1bPZOFK8bWxC+4e1ml+QGLmp+VgFho1Tp/upMWYLFoP+UKeJTG1oPqe
         Xv1AZQ796nxF9+BxjA9GkOvWteoehbTjRhkfgKPHlATNoG4Smo8hbgrN7IinNnSa338I
         4APUsNeiXxvGLwoJJZHc9EG8ImK1F9lGjh+uQRS+0qWbI5ixAxYM1s959H0K+QrTH3U5
         F40Ekg8U9f8bFULbAG+PW3iWZLhyZcEKOdsDXfE2j++pwRWWcUOnSY9B6aZMf7leXaym
         i4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837608; x=1743442408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hwx4wIJAsVYnLOl0ZG9MpTbW4pE4+Px1sfUV91deBgo=;
        b=p+MWjTlqvneIK/PGwmY9qTtwCC2vhOXg4evasJbzrA4CAItiisgCqvCrDBTz+AySK7
         EhwSvOHqDK246kSduBhXQAK8FwKlpdN7Lto4lfbT4cNjUWWgvOA6ylARRAY36cF4vO13
         qzpvgTtUd38uw/8iSVvKpe9tCV5sWku7oZoTObzwrdRdAxjMsjTvTjax579A2vi0Mxh/
         sWa4nm9BOcs3+G68LjXrEcpCmIbPYdhpBxHVomTv6nAYJXH88kiZh5o8ncnTY6gZe6xr
         H42e96DSgA2RGsDSvTT4QJGaJP/WTn2W2PjO9rQJFreLLLsNJESMfPLSD3FCQ3keE/Mh
         4WlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW56iZz+XAacDKQfm+wwMTXc6bgDhyM4B3Hhum2tJGyLboAOUNIJMu/ori7QwEOlXZIVU7flhe+mJZW1Tv855o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzahNJdW8TujK/vwv9vNKELc51C6/alRb/oN2wFJYzWllFHnTF
	kaSeuT8RmdPSHHXk1yB1bAJyew0qtXkcI0ZnOHRWqgpnoTHL01ltvbbEIE/Tf7xMNJIBvAY9iOH
	bK0xpHA==
X-Google-Smtp-Source: AGHT+IHae5K7FPmx18RLeEA+8VGb68vcd8TH4zBslmk2ZQBRzo2nlTxrSA84khWHVrr7EZzdVzoUVppDS/cV
X-Received: from pfez7.prod.google.com ([2002:aa7:8887:0:b0:736:39fa:2251])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:23cb:b0:736:64b7:f104
 with SMTP id d2e1a72fcca58-739059457c8mr16758180b3a.5.1742837608210; Mon, 24
 Mar 2025 10:33:28 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:02 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-23-mizhang@google.com>
Subject: [PATCH v4 22/38] KVM: x86/pmu: Optimize intel/amd_pmu_refresh() helpers
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

Currently pmu->global_ctrl is initialized in the common kvm_pmu_refresh()
helper since both Intel and AMD CPUs set enable bits for all GP counters
for PERF_GLOBAL_CTRL MSR. But it may be not the best place to initialize
pmu->global_ctrl. Strictly speaking, pmu->global_ctrl is vendor specific
and there are lots of global_ctrl related processing in
intel/amd_pmu_refresh() helpers, so better handle them in same place.
Thus move pmu->global_ctrl initialization into intel/amd_pmu_refresh()
helpers.

Besides, intel_pmu_refresh() doesn't handle global_ctrl_rsvd and
global_status_rsvd properly and fix it.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/pmu.c           | 10 -------
 arch/x86/kvm/svm/pmu.c       | 14 +++++++--
 arch/x86/kvm/vmx/pmu_intel.c | 55 ++++++++++++++++++------------------
 3 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 4e8cefcce7ab..2ac4c039de8b 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -843,16 +843,6 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 		return;
 
 	kvm_pmu_call(refresh)(vcpu);
-
-	/*
-	 * At RESET, both Intel and AMD CPUs set all enable bits for general
-	 * purpose counters in IA32_PERF_GLOBAL_CTRL (so that software that
-	 * was written for v1 PMUs don't unknowingly leave GP counters disabled
-	 * in the global controls).  Emulate that behavior when refreshing the
-	 * PMU so that userspace doesn't need to manually set PERF_GLOBAL_CTRL.
-	 */
-	if (kvm_pmu_has_perf_global_ctrl(pmu) && pmu->nr_arch_gp_counters)
-		pmu->global_ctrl = GENMASK_ULL(pmu->nr_arch_gp_counters - 1, 0);
 }
 
 void kvm_pmu_init(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 153972e944eb..eba086ef5eca 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -198,12 +198,20 @@ static void __amd_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->nr_arch_gp_counters = min_t(unsigned int, pmu->nr_arch_gp_counters,
 					 kvm_pmu_cap.num_counters_gp);
 
-	if (pmu->version > 1) {
-		pmu->global_ctrl_rsvd = ~((1ull << pmu->nr_arch_gp_counters) - 1);
+	if (kvm_pmu_cap.version > 1) {
+		/*
+		 * At RESET, AMD CPUs set all enable bits for general purpose counters in
+		 * IA32_PERF_GLOBAL_CTRL (so that software that was written for v1 PMUs
+		 * don't unknowingly leave GP counters disabled in the global controls).
+		 * Emulate that behavior when refreshing the PMU so that userspace doesn't
+		 * need to manually set PERF_GLOBAL_CTRL.
+		 */
+		pmu->global_ctrl = BIT_ULL(pmu->nr_arch_gp_counters) - 1;
+		pmu->global_ctrl_rsvd = ~pmu->global_ctrl;
 		pmu->global_status_rsvd = pmu->global_ctrl_rsvd;
 	}
 
-	pmu->counter_bitmask[KVM_PMC_GP] = ((u64)1 << 48) - 1;
+	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
 	pmu->reserved_bits = 0xfffffff000280000ull;
 	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
 	/* not applicable to AMD; but clean them to prevent any fall out */
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 04a893e56135..c30c6c5e36c8 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -466,7 +466,6 @@ static void __intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	union cpuid10_eax eax;
 	union cpuid10_edx edx;
 	u64 perf_capabilities;
-	u64 counter_rsvd;
 
 	memset(&lbr_desc->records, 0, sizeof(lbr_desc->records));
 
@@ -493,11 +492,10 @@ static void __intel_pmu_refresh(struct kvm_vcpu *vcpu)
 					 kvm_pmu_cap.num_counters_gp);
 	eax.split.bit_width = min_t(int, eax.split.bit_width,
 				    kvm_pmu_cap.bit_width_gp);
-	pmu->counter_bitmask[KVM_PMC_GP] = ((u64)1 << eax.split.bit_width) - 1;
+	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(eax.split.bit_width) - 1;
 	eax.split.mask_length = min_t(int, eax.split.mask_length,
 				      kvm_pmu_cap.events_mask_len);
-	pmu->available_event_types = ~entry->ebx &
-					((1ull << eax.split.mask_length) - 1);
+	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
 
 	if (pmu->version == 1) {
 		pmu->nr_arch_fixed_counters = 0;
@@ -506,29 +504,34 @@ static void __intel_pmu_refresh(struct kvm_vcpu *vcpu)
 						    kvm_pmu_cap.num_counters_fixed);
 		edx.split.bit_width_fixed = min_t(int, edx.split.bit_width_fixed,
 						  kvm_pmu_cap.bit_width_fixed);
-		pmu->counter_bitmask[KVM_PMC_FIXED] =
-			((u64)1 << edx.split.bit_width_fixed) - 1;
+		pmu->counter_bitmask[KVM_PMC_FIXED] = BIT_ULL(edx.split.bit_width_fixed) - 1;
 	}
 
 	intel_pmu_enable_fixed_counter_bits(pmu, INTEL_FIXED_0_KERNEL |
 						 INTEL_FIXED_0_USER |
 						 INTEL_FIXED_0_ENABLE_PMI);
 
-	counter_rsvd = ~(((1ull << pmu->nr_arch_gp_counters) - 1) |
-		(((1ull << pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
-	pmu->global_ctrl_rsvd = counter_rsvd;
+	if (kvm_pmu_has_perf_global_ctrl(pmu)) {
+		/*
+		 * At RESET, Intel CPUs set all enable bits for general purpose counters
+		 * in IA32_PERF_GLOBAL_CTRL. Emulate this behavior.
+		 */
+		pmu->global_ctrl = BIT_ULL(pmu->nr_arch_gp_counters) - 1;
+		pmu->global_ctrl_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
+					  ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) <<
+					   KVM_FIXED_PMC_BASE_IDX));
 
-	/*
-	 * GLOBAL_STATUS and GLOBAL_OVF_CONTROL (a.k.a. GLOBAL_STATUS_RESET)
-	 * share reserved bit definitions.  The kernel just happens to use
-	 * OVF_CTRL for the names.
-	 */
-	pmu->global_status_rsvd = pmu->global_ctrl_rsvd
-			& ~(MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF |
-			    MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD);
-	if (vmx_pt_mode_is_host_guest())
-		pmu->global_status_rsvd &=
-				~MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI;
+		/*
+		 * GLOBAL_STATUS and GLOBAL_OVF_CONTROL (a.k.a. GLOBAL_STATUS_RESET)
+		 * share reserved bit definitions.  The kernel just happens to use
+		 * OVF_CTRL for the names.
+		 */
+		pmu->global_status_rsvd = pmu->global_ctrl_rsvd &
+					  ~(MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF |
+					    MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD);
+		if (vmx_pt_mode_is_host_guest())
+			pmu->global_status_rsvd &= ~MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI;
+	}
 
 	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
 	if (entry &&
@@ -538,10 +541,9 @@ static void __intel_pmu_refresh(struct kvm_vcpu *vcpu)
 		pmu->raw_event_mask |= (HSW_IN_TX|HSW_IN_TX_CHECKPOINTED);
 	}
 
-	bitmap_set(pmu->all_valid_pmc_idx,
-		0, pmu->nr_arch_gp_counters);
-	bitmap_set(pmu->all_valid_pmc_idx,
-		INTEL_PMC_MAX_GENERIC, pmu->nr_arch_fixed_counters);
+	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
+	bitmap_set(pmu->all_valid_pmc_idx, INTEL_PMC_MAX_GENERIC,
+		   pmu->nr_arch_fixed_counters);
 
 	perf_capabilities = vcpu_get_perf_capabilities(vcpu);
 	if (cpuid_model_is_consistent(vcpu) &&
@@ -555,13 +557,12 @@ static void __intel_pmu_refresh(struct kvm_vcpu *vcpu)
 
 	if (perf_capabilities & PERF_CAP_PEBS_FORMAT) {
 		if (perf_capabilities & PERF_CAP_PEBS_BASELINE) {
-			pmu->pebs_enable_rsvd = counter_rsvd;
+			pmu->pebs_enable_rsvd = pmu->global_ctrl_rsvd;
 			pmu->reserved_bits &= ~ICL_EVENTSEL_ADAPTIVE;
 			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
 			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
 		} else {
-			pmu->pebs_enable_rsvd =
-				~((1ull << pmu->nr_arch_gp_counters) - 1);
+			pmu->pebs_enable_rsvd = ~(BIT_ULL(pmu->nr_arch_gp_counters) - 1);
 		}
 	}
 }
-- 
2.49.0.395.g12beb8f557-goog


