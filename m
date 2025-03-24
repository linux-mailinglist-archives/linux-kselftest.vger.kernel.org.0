Return-Path: <linux-kselftest+bounces-29674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7C2A6E139
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90A5173FCD
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A253269832;
	Mon, 24 Mar 2025 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gB1KNBkj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369A268FC2
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837612; cv=none; b=bqcqoNm6AiMrWVf6ItGPiOqmozyhXuI/ONAPgaS+qXcoHk83Vajy2t/W3gLA4oyoh+5DV6J3QitvyvFVNsqJ2H9JgbQ9u1EaVY682uXVGrLW9DMzFo20fbhD8G0RsHZTnfCskheZWs2/OpBUrE09eQSDB/0UnlfYOCo4oI689Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837612; c=relaxed/simple;
	bh=XasFjCIuahndhb/faa1LOJ8dTCArQb7+Q2eC27OUBis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QVMT+EjgxbopkRw+R5IOhgXqUV4vf3fOtpSseaPfsbNtgc4CdDvKgqRr2uMAqAf4MXPJPKR/Rn2lAuTD7gRgMIzcQDh4x/cNB1vhor8hXUyGKa9qltB8e2SQ5ZeWKagxPgkrgcpTKxBbDI1JN2/OD3MRgRGz00hnJyMQ24TPRQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gB1KNBkj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff6af1e264so13313337a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837610; x=1743442410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=b2n1VcrwFWvpmJrE8tpONgvu6Ll9zEcizkSJHjtbwr8=;
        b=gB1KNBkjwgy3qjTlR3laYf5INLQyWMMk53hgoE9u4+g0Q3RDrKiuJGkequVp/MlI4n
         Ba7zvQ7KTg8RgFI5NymONkLF0sU/+R+TXn2jRKJhaJrEkZxcHTM0EatRGsJqi03mep2t
         pRxlvO7wRg7pMQcQ6fr2nmkE1jDdJI+iAcPrWc95j7zcxhBmOYVGNDyh9SxJ8D1Yrae8
         Nt5Rapi8L9LjUOgVLVxq4QvUg5FEmFnD5HC8ULloxe4AicPEmTdfpMtAnCie8AsfHUbb
         8P2FX6Km5hi6mJVBVcJs+AdhYS9XHgMZSVkCvsHZ0K2BwPMzMNFYFjAsD5sT8tGH3bEN
         QbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837610; x=1743442410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2n1VcrwFWvpmJrE8tpONgvu6Ll9zEcizkSJHjtbwr8=;
        b=qjYjORe5F6lnAlhDuIZI7XW21YlMJxqn1+3nc4B+8SqEmPiGje+14mSi5wREb4t8XA
         8ArqhqD84YPHlRm00ntAnjzkEeiQyKXl9O2W3CjWVK/XtLDsZlS7y80S2Obyoe70bXGi
         oZ1tCH+78NCNaO4Pa99qFVrCQKwV4i5IN2jTo+I21TrmUnS9Sfw4mGc90M03zuz7zwDb
         j9t/HXpnlt56lBCwdXcqKY3exd8+uWo9XcaSUq1YQU+aWsZU6ovWqtaUoiJ2AIqFlSi9
         9ToIz6qLvnF/+MNDJYTre00ROUoCNmnYV9VMEEJ/tVzG2+9sqfOeku+o3AIuZOweKvjp
         KU2w==
X-Forwarded-Encrypted: i=1; AJvYcCXJbc6kNd7L8nkLqo2YB6iicQHapq0oIGzVmzoWZ1o+xC9RiutdscKkoiGxj1JwgtenFC2i2kNQgbJ1IxedS3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjyvZzAkHDvy60TY1w9arcnCLUf81wRGWllSKIJo+fpEDkzNTz
	rRb1TFDRTQEtT95MJ3xNGP2M+F+WWJa7ZaHnK+KtUNi3SQ4HcynMroB5W6Xacm25rcnGOSRR8Ol
	kjxTtSg==
X-Google-Smtp-Source: AGHT+IH3WMcuBrRZ/MQ5kDTO8s97PR3oLVS4GF20epZGZVaSDyEwzXc5MbNUgvClxFCiR+vMgC9hoD3d1qxd
X-Received: from pjh13.prod.google.com ([2002:a17:90b:3f8d:b0:2ea:9d23:79a0])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a44:b0:2f4:4003:f3d4
 with SMTP id 98e67ed59e1d1-3030ff08e4amr20813258a91.30.1742837609884; Mon, 24
 Mar 2025 10:33:29 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:03 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-24-mizhang@google.com>
Subject: [PATCH v4 23/38] KVM: x86/pmu: Configure the interception of PMU MSRs
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

Add helper intel_pmu_update_msr_intercepts() to configure the interception
of PMU MSRs.

For mediated vPMU, intercept all the guest owned GP counters EVENTSELx MSRs
and fixed counters FIX_CTR_CTRL MSR (Intel only). This is because KVM needs
to intercept the event configuration and filter out malicious guest events
and events that might cause CPU glitches.

In addition, pass through all the guest owned perf counter MSRs to reduce
the performance impact. Note that PMU MSRs that not owned by guest are
always intercepted. Accessing them always cause #GP

As for the global shared MSRs, pass through them to guest only if guest
own all PMU resources. Otherwise, intercept them all to avoid guest to
access host owned counters.

Suggested-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Co-developed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/kvm/svm/pmu.c           | 63 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/pmu_intel.c     | 44 ++++++++++++++++++++++
 3 files changed, 108 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 337f4b0a2998..a4d8356e9b53 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -719,6 +719,7 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET	0xc0000303
 
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index eba086ef5eca..4fc809c74ba8 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -220,6 +220,67 @@ static void __amd_pmu_refresh(struct kvm_vcpu *vcpu)
 	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
 }
 
+static void amd_pmu_update_msr_intercepts(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct vcpu_svm *svm = to_svm(vcpu);
+	int msr_clear = !!(kvm_mediated_pmu_enabled(vcpu));
+	int i;
+
+	for (i = 0; i < min(pmu->nr_arch_gp_counters, AMD64_NUM_COUNTERS); i++) {
+		/*
+		 * Legacy counters are always available irrespective of any
+		 * CPUID feature bits and when X86_FEATURE_PERFCTR_CORE is set,
+		 * PERF_LEGACY_CTLx and PERF_LEGACY_CTRx registers are mirrored
+		 * with PERF_CTLx and PERF_CTRx respectively.
+		 */
+		set_msr_interception(vcpu, svm->msrpm, MSR_K7_EVNTSEL0 + i, 0, 0);
+		set_msr_interception(vcpu, svm->msrpm, MSR_K7_PERFCTR0 + i,
+				     msr_clear, msr_clear);
+	}
+
+	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+		/*
+		 * PERF_CTLx registers require interception in order to clear
+		 * HostOnly bit and set GuestOnly bit. This is to prevent the
+		 * PERF_CTRx registers from counting before VM entry and after
+		 * VM exit.
+		 */
+		set_msr_interception(vcpu, svm->msrpm, MSR_F15H_PERF_CTL + 2 * i, 0, 0);
+		/*
+		 * Pass through counters exposed to the guest and intercept
+		 * counters that are unexposed. Do this explicitly since this
+		 * function may be set multiple times before vcpu runs.
+		 */
+		set_msr_interception(vcpu, svm->msrpm, MSR_F15H_PERF_CTR + 2 * i,
+				     msr_clear, msr_clear);
+	}
+
+	for ( ; i < kvm_pmu_cap.num_counters_gp; i++) {
+		set_msr_interception(vcpu, svm->msrpm, MSR_F15H_PERF_CTL + 2 * i, 0, 0);
+		set_msr_interception(vcpu, svm->msrpm, MSR_F15H_PERF_CTR + 2 * i, 0, 0);
+	}
+
+	/*
+	 * In mediated vPMU, intercept global PMU MSRs when guest PMU only owns
+	 * a subset of counters provided in HW or its version is less than 2.
+	 */
+	if (kvm_mediated_pmu_enabled(vcpu) && kvm_pmu_has_perf_global_ctrl(pmu) &&
+	    pmu->nr_arch_gp_counters == kvm_pmu_cap.num_counters_gp)
+		msr_clear = 1;
+	else
+		msr_clear = 0;
+
+	set_msr_interception(vcpu, svm->msrpm, MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
+			     msr_clear, msr_clear);
+	set_msr_interception(vcpu, svm->msrpm, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
+			     msr_clear, msr_clear);
+	set_msr_interception(vcpu, svm->msrpm, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+			     msr_clear, msr_clear);
+	set_msr_interception(vcpu, svm->msrpm, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
+			     msr_clear, msr_clear);
+}
+
 static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -230,6 +291,8 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 		svm_clr_intercept(svm, INTERCEPT_RDPMC);
 	else
 		svm_set_intercept(svm, INTERCEPT_RDPMC);
+
+	amd_pmu_update_msr_intercepts(vcpu);
 }
 
 static void amd_pmu_init(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index c30c6c5e36c8..450f9e5b9e40 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -567,6 +567,48 @@ static void __intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void intel_pmu_update_msr_intercepts(struct kvm_vcpu *vcpu)
+{
+	bool intercept = !kvm_mediated_pmu_enabled(vcpu);
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	int i;
+
+	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
+					  MSR_TYPE_RW, intercept);
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PMC0 + i, MSR_TYPE_RW,
+					  intercept || !fw_writes_is_enabled(vcpu));
+	}
+	for ( ; i < kvm_pmu_cap.num_counters_gp; i++) {
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
+					  MSR_TYPE_RW, true);
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PMC0 + i,
+					  MSR_TYPE_RW, true);
+	}
+
+	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
+		vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 + i,
+					  MSR_TYPE_RW, intercept);
+	for ( ; i < kvm_pmu_cap.num_counters_fixed; i++)
+		vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 + i,
+					  MSR_TYPE_RW, true);
+
+	if (kvm_mediated_pmu_enabled(vcpu) && kvm_pmu_has_perf_global_ctrl(pmu) &&
+	    vcpu_has_perf_metrics(vcpu) == kvm_host_has_perf_metrics() &&
+	    pmu->nr_arch_gp_counters == kvm_pmu_cap.num_counters_gp &&
+	    pmu->nr_arch_fixed_counters == kvm_pmu_cap.num_counters_fixed)
+		intercept = false;
+	else
+		intercept = true;
+
+	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_STATUS,
+				  MSR_TYPE_RW, intercept);
+	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_CTRL,
+				  MSR_TYPE_RW, intercept);
+	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
+				  MSR_TYPE_RW, intercept);
+}
+
 static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -578,6 +620,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	exec_controls_changebit(vmx, CPU_BASED_RDPMC_EXITING,
 				!kvm_rdpmc_in_guest(vcpu));
 
+	intel_pmu_update_msr_intercepts(vcpu);
+
 	mediated = kvm_mediated_pmu_enabled(vcpu);
 	if (cpu_has_load_perf_global_ctrl()) {
 		vm_entry_controls_changebit(vmx,
-- 
2.49.0.395.g12beb8f557-goog


