Return-Path: <linux-kselftest+bounces-29672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF83A6E132
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C2316A21B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAD5268FE8;
	Mon, 24 Mar 2025 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JItFKbQ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29016268C51
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837609; cv=none; b=g6zng99tkzzjQ8lTMoFI9lmBCeqR5XcjghUI8Qu3P61MHn1qsK0NRoegCyOriySRKW19hM7/kTKvtpGe3vxehY5cA8kA2FTLnzb+H6EPARqfvwUTvuO7jQ8X2G82Yy5o8im84Vwq6f/Ovq+zcQ1uz4AJSpK8A12QdSm1wV9iNJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837609; c=relaxed/simple;
	bh=eG4BKBSOeyB/+BHXOdngXFZetx+df4JdcLSILPP88y4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bXJ5qhcbhrr1KkPBkNGddaFqgYgk1H1JneP9eeoCjYwQj02vBSTeLXNglsTvGwSPXDzgtIn+f/o8DSsW4cL1s+5rGYa9CN53DFzD8lmdpcOooWEbVW7FWVlmrZa146awqXvgLE/qKjJErba9ZygIqq5CeFUmAwpcqGMcvLL8kOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JItFKbQ2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2242ade807fso132558435ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837606; x=1743442406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uxkoYLdOZ8QTOf9r3R5M+fKRbYC5VCo3sjiKsIcDxbc=;
        b=JItFKbQ2193WjnubYaIxbUv20zNYASlv1JYIBOSUQHksGO84yFsu/87ae8lOgKiDUH
         bP0VvB3gpty6Uji6ZWaZp81SKh3ZTVnT4cFS3QVyZzJfjKZPkYhMAM8Npbxpx1yoUG8V
         e0AcRYYBz2zSjg9EbYiXcM1HjWTNPz77NEROo24ovhMX3Jv+lFiTTubuNMTAf5M0xVGJ
         N8m7Q/HD8hy+Mu9uLDUDcFbTsLtiaU16/62WQNCD0LlwIlia6w0PIVvrobsDtC9Qmtb+
         HNSGM9qtJ/WJT5nk5a8JAZ2xPvVBJVTxnpoFIawPBgoKOI4GNlbj1fuKdL1BhyDoPoh0
         1p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837606; x=1743442406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxkoYLdOZ8QTOf9r3R5M+fKRbYC5VCo3sjiKsIcDxbc=;
        b=cANfneY3jq+pg1IGNFODSyT7nsdt0aFRI56aPTT6Uo9Ew6UixGszt2Eky4NUWpD3il
         +fMFtRsLg1qwWyzbZxCyggPtwFn3+N3uKGj1/2WZAkrMgTv5TLWE/0cDXAvDbUt7F+7g
         DX9CBOwbtCThR14QVzxu09IL2cUeCHQHeeDa53CKBjAGwRVNeM0ye/W7LuzqEqoUv4NH
         fn+dkgPnFuy7D5o8Q4lLHS9OenADY5og/ES8ni5pY7JZpok0vmCQLRTa2y32B1YKUZmS
         Noa+pp/hIsS/1Ylh0f4s3bNfqmP6A0VjEuqc4rIZj8usexnA9IDd/HfNYQCJPgij2eoh
         GhUw==
X-Forwarded-Encrypted: i=1; AJvYcCWRa8FPnJiWHpF4ShJ/cI0Y+m/vVhzdkQPr6o8tHcL69OK9MZ6huzvR4ihm87V5uO1JaxuuQFwek8+ghEDgazk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQyWTXHBhTBylj4B+2ey4mxLbaVVp80yfOwRu8UhH1OODloVa
	vRXHDSEQCirDuY3nmKuXwsE6zVQ1UTMo5S7sMVLsB2Z+BJ6YvcyjRwAC6IaDY1KJMq1n9ib1tgG
	iK4fttA==
X-Google-Smtp-Source: AGHT+IF7lDlCFVGQKi2+Rq+79r7jy+w20n0zBki1L4iPeSQKWAv1w9nC9E7vAoD4ZGW1DAswyQPwFE6zZfen
X-Received: from pjh3.prod.google.com ([2002:a17:90b:3f83:b0:2fe:7f7a:74b2])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc45:b0:21d:dfae:300c
 with SMTP id d9443c01a7336-22780c546a8mr217885605ad.3.1742837606600; Mon, 24
 Mar 2025 10:33:26 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:01 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-22-mizhang@google.com>
Subject: [PATCH v4 21/38] KVM: x86/pmu/vmx: Save/load guest
 IA32_PERF_GLOBAL_CTRL with vm_exit/entry_ctrl
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

Intel processor (vmx) provides capability to save/load guest
IA32_PERF_GLOBAL_CTRL at vm-exit/vm-entry by setting
VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL bit in VM-exit-ctrl or
VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL bit in VM-entry-ctrl.

Mediated vPMU leverages both capabilities to save/load guest
IA32_PERF_GLOBAL_CTRL automatically at vm-exit/vm-entry. Note that the
former was introduced in SapphireRapids and later Intel CPUs.

If VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL is unavailable, mediated PMU will be
disabled. Note that mediated PMU can be enabled by falling back to atomic
msr save/retore list. However, that would cause extra overhead per
VM-enter/exit.

Since these VMX capability bits perform automatic saving/restoring of the
PMU global ctrl between VMCS and the HW MSR. No synchronization was
performed betwen HW MSR and pmu->global_ctrli, the KVM cached value .
Therefore, whenever KVM needs to use this variable, it will need to
explicitly read the value from MSR to pmu->global_ctrl. This is especially
so when guest doesn't own all PMU counters, i.e., when
IA32_PERF_GLOBAL_CTRL is interceped by mediated PMU.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/include/asm/kvm_host.h |  4 ++++
 arch/x86/include/asm/vmx.h      |  1 +
 arch/x86/kvm/pmu.c              | 30 ++++++++++++++++++++++++-
 arch/x86/kvm/vmx/capabilities.h |  5 +++++
 arch/x86/kvm/vmx/nested.c       |  3 ++-
 arch/x86/kvm/vmx/pmu_intel.c    | 39 ++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/vmx.c          | 22 ++++++++++++++++++-
 arch/x86/kvm/vmx/vmx.h          |  3 ++-
 8 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0b7af5902ff7..4b3bfefc2d05 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -553,6 +553,10 @@ struct kvm_pmu {
 	unsigned available_event_types;
 	u64 fixed_ctr_ctrl;
 	u64 fixed_ctr_ctrl_rsvd;
+	/*
+	 * kvm_pmu_sync_global_ctrl_from_vmcs() must be called to update
+	 * this SW-maintained global_ctrl for mediated vPMU before accessing it.
+	 */
 	u64 global_ctrl;
 	u64 global_status;
 	u64 counter_bitmask[2];
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index f7fd4369b821..48e137560f17 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -106,6 +106,7 @@
 #define VM_EXIT_CLEAR_BNDCFGS                   0x00800000
 #define VM_EXIT_PT_CONCEAL_PIP			0x01000000
 #define VM_EXIT_CLEAR_IA32_RTIT_CTL		0x02000000
+#define VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL	0x40000000
 
 #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
 
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 6ad71752be4b..4e8cefcce7ab 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -646,6 +646,30 @@ void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void kvm_pmu_sync_global_ctrl_from_vmcs(struct kvm_vcpu *vcpu)
+{
+	struct msr_data msr_info = { .index = MSR_CORE_PERF_GLOBAL_CTRL };
+
+	if (!kvm_mediated_pmu_enabled(vcpu))
+		return;
+
+	/* Sync pmu->global_ctrl from GUEST_IA32_PERF_GLOBAL_CTRL. */
+	kvm_pmu_call(get_msr)(vcpu, &msr_info);
+}
+
+static void kvm_pmu_sync_global_ctrl_to_vmcs(struct kvm_vcpu *vcpu, u64 global_ctrl)
+{
+	struct msr_data msr_info = {
+		.index = MSR_CORE_PERF_GLOBAL_CTRL,
+		.data = global_ctrl };
+
+	if (!kvm_mediated_pmu_enabled(vcpu))
+		return;
+
+	/* Sync pmu->global_ctrl to GUEST_IA32_PERF_GLOBAL_CTRL. */
+	kvm_pmu_call(set_msr)(vcpu, &msr_info);
+}
+
 bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 {
 	switch (msr) {
@@ -680,7 +704,6 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = pmu->global_status;
 		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
-	case MSR_CORE_PERF_GLOBAL_CTRL:
 		msr_info->data = pmu->global_ctrl;
 		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
@@ -731,6 +754,9 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			diff = pmu->global_ctrl ^ data;
 			pmu->global_ctrl = data;
 			reprogram_counters(pmu, diff);
+
+			/* Propagate guest global_ctrl to GUEST_IA32_PERF_GLOBAL_CTRL. */
+			kvm_pmu_sync_global_ctrl_to_vmcs(vcpu, data);
 		}
 		break;
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
@@ -907,6 +933,8 @@ void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel)
 
 	BUILD_BUG_ON(sizeof(pmu->global_ctrl) * BITS_PER_BYTE != X86_PMC_IDX_MAX);
 
+	kvm_pmu_sync_global_ctrl_from_vmcs(vcpu);
+
 	if (!kvm_pmu_has_perf_global_ctrl(pmu))
 		bitmap_copy(bitmap, pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
 	else if (!bitmap_and(bitmap, pmu->all_valid_pmc_idx,
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 013536fde10b..cc63bd4ab87c 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -101,6 +101,11 @@ static inline bool cpu_has_load_perf_global_ctrl(void)
 	return vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
 }
 
+static inline bool cpu_has_save_perf_global_ctrl(void)
+{
+	return vmcs_config.vmexit_ctrl & VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL;
+}
+
 static inline bool cpu_has_vmx_mpx(void)
 {
 	return vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_BNDCFGS;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8a7af02d466e..ecf72394684d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7004,7 +7004,8 @@ static void nested_vmx_setup_exit_ctls(struct vmcs_config *vmcs_conf,
 		VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |
 		VM_EXIT_LOAD_IA32_EFER | VM_EXIT_SAVE_IA32_EFER |
 		VM_EXIT_SAVE_VMX_PREEMPTION_TIMER | VM_EXIT_ACK_INTR_ON_EXIT |
-		VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
+		VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+		VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL;
 
 	/* We support free control of debug control saving. */
 	msrs->exit_ctls_low &= ~VM_EXIT_SAVE_DEBUG_CONTROLS;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 2a5f79206b02..04a893e56135 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -294,6 +294,11 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	u32 msr = msr_info->index;
 
 	switch (msr) {
+	case MSR_CORE_PERF_GLOBAL_CTRL:
+		if (kvm_mediated_pmu_enabled(vcpu))
+			pmu->global_ctrl = vmcs_read64(GUEST_IA32_PERF_GLOBAL_CTRL);
+		msr_info->data = pmu->global_ctrl;
+		break;
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		msr_info->data = pmu->fixed_ctr_ctrl;
 		break;
@@ -339,6 +344,11 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	u64 reserved_bits, diff;
 
 	switch (msr) {
+	case MSR_CORE_PERF_GLOBAL_CTRL:
+		if (kvm_mediated_pmu_enabled(vcpu))
+			vmcs_write64(GUEST_IA32_PERF_GLOBAL_CTRL,
+				     pmu->global_ctrl);
+		break;
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		if (data & pmu->fixed_ctr_ctrl_rsvd)
 			return 1;
@@ -558,10 +568,37 @@ static void __intel_pmu_refresh(struct kvm_vcpu *vcpu)
 
 static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 {
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	bool mediated;
+
 	__intel_pmu_refresh(vcpu);
 
-	exec_controls_changebit(to_vmx(vcpu), CPU_BASED_RDPMC_EXITING,
+	exec_controls_changebit(vmx, CPU_BASED_RDPMC_EXITING,
 				!kvm_rdpmc_in_guest(vcpu));
+
+	mediated = kvm_mediated_pmu_enabled(vcpu);
+	if (cpu_has_load_perf_global_ctrl()) {
+		vm_entry_controls_changebit(vmx,
+			VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL, mediated);
+		/*
+		 * Initialize guest PERF_GLOBAL_CTRL to reset value as SDM rules.
+		 *
+		 * Note: GUEST_IA32_PERF_GLOBAL_CTRL must be initialized to
+		 * "BIT_ULL(pmu->nr_arch_gp_counters) - 1" instead of pmu->global_ctrl
+		 * since pmu->global_ctrl is only be initialized when guest
+		 * pmu->version > 1. Otherwise if pmu->version is 1, pmu->global_ctrl
+		 * is 0 and guest counters are never really enabled.
+		 */
+		if (mediated)
+			vmcs_write64(GUEST_IA32_PERF_GLOBAL_CTRL,
+				     BIT_ULL(pmu->nr_arch_gp_counters) - 1);
+	}
+
+	if (cpu_has_save_perf_global_ctrl())
+		vm_exit_controls_changebit(vmx,
+			VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+			VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL, mediated);
 }
 
 static void intel_pmu_init(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ff66f17d6358..38ecf3c116bd 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4390,6 +4390,13 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 
 	if (cpu_has_load_ia32_efer())
 		vmcs_write64(HOST_IA32_EFER, kvm_host.efer);
+
+	/*
+	 * Initialize host PERF_GLOBAL_CTRL to 0 to disable all counters
+	 * immediately once VM exits. Mediated vPMU then call perf_guest_exit()
+	 * to re-enable host perf events.
+	 */
+	vmcs_write64(HOST_IA32_PERF_GLOBAL_CTRL, 0);
 }
 
 void set_cr4_guest_host_mask(struct vcpu_vmx *vmx)
@@ -4457,7 +4464,8 @@ static u32 vmx_get_initial_vmexit_ctrl(void)
 				 VM_EXIT_CLEAR_IA32_RTIT_CTL);
 	/* Loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically */
 	return vmexit_ctrl &
-		~(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | VM_EXIT_LOAD_IA32_EFER);
+		~(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | VM_EXIT_LOAD_IA32_EFER |
+		  VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL);
 }
 
 void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
@@ -7196,6 +7204,9 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
 	struct perf_guest_switch_msr *msrs;
 	struct kvm_pmu *pmu = vcpu_to_pmu(&vmx->vcpu);
 
+	if (kvm_mediated_pmu_enabled(&vmx->vcpu))
+		return;
+
 	pmu->host_cross_mapped_mask = 0;
 	if (pmu->pebs_enable & pmu->global_ctrl)
 		intel_pmu_cross_mapped_check(pmu);
@@ -8451,6 +8462,15 @@ __init int vmx_hardware_setup(void)
 		enable_sgx = false;
 #endif
 
+	/*
+	 * All CPUs that support a mediated PMU are expected to support loading
+	 * and saving PERF_GLOBAL_CTRL via dedicated VMCS fields.
+	 */
+	if (enable_mediated_pmu &&
+	    (WARN_ON_ONCE(!cpu_has_load_perf_global_ctrl() ||
+			  !cpu_has_save_perf_global_ctrl())))
+		enable_mediated_pmu = false;
+
 	/*
 	 * set_apic_access_page_addr() is used to reload apic access
 	 * page upon invalidation.  No need to do anything if not
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 5c505af553c8..b282165f98a6 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -510,7 +510,8 @@ static inline u8 vmx_get_rvi(void)
 	       VM_EXIT_LOAD_IA32_EFER |					\
 	       VM_EXIT_CLEAR_BNDCFGS |					\
 	       VM_EXIT_PT_CONCEAL_PIP |					\
-	       VM_EXIT_CLEAR_IA32_RTIT_CTL)
+	       VM_EXIT_CLEAR_IA32_RTIT_CTL |				\
+	       VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL)
 
 #define KVM_REQUIRED_VMX_PIN_BASED_VM_EXEC_CONTROL			\
 	(PIN_BASED_EXT_INTR_MASK |					\
-- 
2.49.0.395.g12beb8f557-goog


