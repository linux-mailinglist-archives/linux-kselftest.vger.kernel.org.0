Return-Path: <linux-kselftest+bounces-29669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEF1A6E12B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0353B4746
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64DC267F5F;
	Mon, 24 Mar 2025 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b9PutlaE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E855D267B7E
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837603; cv=none; b=nJkEPUklRn0vFgV7Ir7/J1qpiRyaNa9lCtzBuy7b8f2+00zR6Qll0CQCMEHZZ8M6aKg0XLnAJ5FwDWGBG3zvFXOIT+RkHURdt/nQdsv3UpDFCxD88c/HbEYyRYMspN4GmsTFbWlqBWqLl75cz87bu+HIBMRhR7eMLYunxTRVcXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837603; c=relaxed/simple;
	bh=H5dpimzCkTLaGElT4g2IUO6VSSp4QnkSLT93PRKHBOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hsaMSAWExHMKvXAxI+ce1TV7WuGpJkunJHXH8boWPQVFh2L1uakzTqdr/0sUI1AOu5wZpta/lzEynrRT+x6JBxB4Tnw8p17n1cbAx+0FCAnkMBso6zHvfvQIcSmdWNJJP1aElVIOMzG8bK2b7jZlznCzAz4VceeQ1a+tL+f6RqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b9PutlaE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff8a2c7912so7739811a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837601; x=1743442401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4s4fj12+7LYXYBlMzf4tcSXF30o33nLdQg99nDxRYP4=;
        b=b9PutlaEQ9XT396KBS5OuPYvvYN0WVVeZX/LNwa85upj9K0u0ZAWOdo08KPCvyT0Gh
         8yptVP6LUROFUyxQEAAiINE+IytoffXL1nJvPiWFcuW2I4VJi8n4+s2HD6Mbx04tEfyI
         XuifVd1jZIEHdX5curGtrQfF4Gu5Fv2v0TvKPawveyg+gfHEqU/x65fNkjBrTEJelA1u
         T1VLYzeB5oWu3omP/hkRbsgUSf/+2kdJ+m7gZduQfDiqsqLyY4GSsGqtD9JVfE80I0cB
         mguvJ4/G0dU9+qEm6D6A/jIsiKr597VsDoxHiyvNCJXhRZJseseWh5WTf2mXRz1rwqX4
         x/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837601; x=1743442401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4s4fj12+7LYXYBlMzf4tcSXF30o33nLdQg99nDxRYP4=;
        b=QFMoJStaISvUpOVSAfWph/K/tkjM3NWc9yWFiiohNLtj5uhulKfOvLgKScDWpMM51d
         tWH/ANFnXJDP35Sc8JDTs3/rTYTrbLv2vwBbxg63T56PpYPw4ELLNo32o2e5g7YFvlaP
         8qCvoYGePFHkfqTVQs5HuD4O279WhcQLacLQ5oRKL1Vl+11J2GqmEeSmDbl501GlgwBZ
         76K20Gh2J5nqhIpFENfRBCmvM/GU6FC38giPqF4+fREv5QXBm8Yyhf5wMuh/lhUkSsFn
         b/XBA80SYMjIdIpE6OtFP2Za0iNfWSnR7SXfjnORPLTJX+jd8pexhLYnf4Rlz58XLmC3
         SQDg==
X-Forwarded-Encrypted: i=1; AJvYcCUKFdpuPWWmsT+LHrWTShjTM2ZWmxTfu9pFl4dPqX3EGqeIOgONjCDMu2Jm3GENXBHvLGKPUGOVnUQctLwxOxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsv+cANgXXzyTfSRoHrfidNnqPuX1xzAh5CqIEC8z4IuXZgi1O
	Zro7N+KzCT/wOF8tQSrsrcVxKs7+PnEJe0NWDpSXjeuwJrhZWomeHCiP2JWgsUZkPt7aWKSS9VF
	kJ9Yqjg==
X-Google-Smtp-Source: AGHT+IF3eAhtbr/aKZMsOSHh6EvPm40FhM3S3reS/zODf44Xe9H+4QBhRWOx5GA3LttXrkzjAl5B1PQqv1BM
X-Received: from pjbmf11.prod.google.com ([2002:a17:90b:184b:b0:2ef:d283:5089])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d2cb:b0:2fa:42f3:e3e4
 with SMTP id 98e67ed59e1d1-301d426aa83mr27441767a91.3.1742837601440; Mon, 24
 Mar 2025 10:33:21 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:58 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-19-mizhang@google.com>
Subject: [PATCH v4 18/38] KVM: x86/pmu: Move PMU_CAP_{FW_WRITES,LBR_FMT} into
 msr-index.h header
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

Move PMU_CAP_{FW_WRITES,LBR_FMT} into msr-index.h and rename them with
PERF_CAP prefix to keep consistent with other perf capabilities macros.

No functional change intended.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/include/asm/msr-index.h | 15 +++++++++------
 arch/x86/kvm/vmx/capabilities.h  |  3 ---
 arch/x86/kvm/vmx/pmu_intel.c     |  4 ++--
 arch/x86/kvm/vmx/vmx.c           | 12 ++++++------
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 72765b2fe0d8..ca70846ffd55 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -305,12 +305,15 @@
 #define PERF_CAP_PT_IDX			16
 
 #define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
-#define PERF_CAP_PEBS_TRAP             BIT_ULL(6)
-#define PERF_CAP_ARCH_REG              BIT_ULL(7)
-#define PERF_CAP_PEBS_FORMAT           0xf00
-#define PERF_CAP_PEBS_BASELINE         BIT_ULL(14)
-#define PERF_CAP_PEBS_MASK	(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
-				 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE)
+
+#define PERF_CAP_LBR_FMT		0x3f
+#define PERF_CAP_PEBS_TRAP		BIT_ULL(6)
+#define PERF_CAP_ARCH_REG		BIT_ULL(7)
+#define PERF_CAP_PEBS_FORMAT		0xf00
+#define PERF_CAP_FW_WRITES		BIT_ULL(13)
+#define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
+#define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
+					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE)
 
 #define MSR_IA32_RTIT_CTL		0x00000570
 #define RTIT_CTL_TRACEEN		BIT(0)
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index fac2c80ddbab..013536fde10b 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -21,9 +21,6 @@ extern int __read_mostly pt_mode;
 #define PT_MODE_SYSTEM		0
 #define PT_MODE_HOST_GUEST	1
 
-#define PMU_CAP_FW_WRITES	(1ULL << 13)
-#define PMU_CAP_LBR_FMT		0x3f
-
 struct nested_vmx_msrs {
 	/*
 	 * We only store the "true" versions of the VMX capability MSRs. We
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 425e93d4b1c6..fc017e9a6a0c 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -118,7 +118,7 @@ static inline u64 vcpu_get_perf_capabilities(struct kvm_vcpu *vcpu)
 
 static inline bool fw_writes_is_enabled(struct kvm_vcpu *vcpu)
 {
-	return (vcpu_get_perf_capabilities(vcpu) & PMU_CAP_FW_WRITES) != 0;
+	return (vcpu_get_perf_capabilities(vcpu) & PERF_CAP_FW_WRITES) != 0;
 }
 
 static inline struct kvm_pmc *get_fw_gp_pmc(struct kvm_pmu *pmu, u32 msr)
@@ -543,7 +543,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 
 	perf_capabilities = vcpu_get_perf_capabilities(vcpu);
 	if (cpuid_model_is_consistent(vcpu) &&
-	    (perf_capabilities & PMU_CAP_LBR_FMT))
+	    (perf_capabilities & PERF_CAP_LBR_FMT))
 		memcpy(&lbr_desc->records, &vmx_lbr_caps, sizeof(vmx_lbr_caps));
 	else
 		lbr_desc->records.nr = 0;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ca1c53f855e0..9c4b3c2b1d65 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2188,7 +2188,7 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
 	    (host_initiated || guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT)))
 		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
 
-	if ((kvm_caps.supported_perf_cap & PMU_CAP_LBR_FMT) &&
+	if ((kvm_caps.supported_perf_cap & PERF_CAP_LBR_FMT) &&
 	    (host_initiated || intel_pmu_lbr_is_enabled(vcpu)))
 		debugctl |= DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
 
@@ -2464,9 +2464,9 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			vmx->pt_desc.guest.addr_a[index / 2] = data;
 		break;
 	case MSR_IA32_PERF_CAPABILITIES:
-		if (data & PMU_CAP_LBR_FMT) {
-			if ((data & PMU_CAP_LBR_FMT) !=
-			    (kvm_caps.supported_perf_cap & PMU_CAP_LBR_FMT))
+		if (data & PERF_CAP_LBR_FMT) {
+			if ((data & PERF_CAP_LBR_FMT) !=
+			    (kvm_caps.supported_perf_cap & PERF_CAP_LBR_FMT))
 				return 1;
 			if (!cpuid_model_is_consistent(vcpu))
 				return 1;
@@ -7907,7 +7907,7 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 static __init u64 vmx_get_perf_capabilities(void)
 {
-	u64 perf_cap = PMU_CAP_FW_WRITES;
+	u64 perf_cap = PERF_CAP_FW_WRITES;
 
 	if (!enable_pmu)
 		return 0;
@@ -7924,7 +7924,7 @@ static __init u64 vmx_get_perf_capabilities(void)
 		if (!vmx_lbr_caps.has_callstack)
 			memset(&vmx_lbr_caps, 0, sizeof(vmx_lbr_caps));
 		else if (vmx_lbr_caps.nr)
-			perf_cap |= kvm_host.perf_capabilities & PMU_CAP_LBR_FMT;
+			perf_cap |= kvm_host.perf_capabilities & PERF_CAP_LBR_FMT;
 	}
 
 	if (vmx_pebs_supported()) {
-- 
2.49.0.395.g12beb8f557-goog


