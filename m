Return-Path: <linux-kselftest+bounces-46215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FDFC78B24
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 004B52D784
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0B234B68F;
	Fri, 21 Nov 2025 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+J0/t5J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB19034AB14
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723496; cv=none; b=aFuoXYhIHWtm6LsajKJDtyW505z2jd59D60dVeaJTbknxT8XYcy9i2CUFrOX+5QiBdhkPMiQzaxaNrbRX3+BMeZ4WKEIX29wBNADAsBjauza469zIcu+GBHfjBVgTOWB0KFn6JMfaumg3xDNEOitTFnisr2GdENUDOFwKX//81s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723496; c=relaxed/simple;
	bh=dS2tU290nqAox27OC6Jajp3FZHZfPUPTd5QGznGhFbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyQS//4frH4xXCvjkDhcWq1JzL724NPN6UjtENaPFnf/qNsrJG53M/UTOexmU9fEqsYyokmwqNW+XLr7RCgaWCcNlyk7bJTwVdJPekUdo6mLn9UbdBB2zgtOfSPaNmvN8N0NETjpvvwCabuhuOjLdCrd/J//cuWh/C3R0Nc3GVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+J0/t5J; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso1056024f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 03:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763723492; x=1764328292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9lfbyfUipLlDYUmoPFufZ/w0ZJAQG/DQOcG0klnz4U=;
        b=F+J0/t5JXTAI9fZCB1LVmXpGbh3RoXZs+yRZxhE7FZMc8ei2csLj57fpcVVHslNsEJ
         kV4s6Qv5SZUD2FoGEjXpKQZv6roo2paMIOJsl4PCyM5ErriIkPSO54+TbZlJQII4JG1g
         MT5P3Yb/xzbEy4Q8EIvleoEpVAa3GLd1mRUK7On4y8Vs+qyl7Wb3cqIf52fF+He9sk7i
         hSqgl0n6FzGhcvJ97npqRwVb0Vbdt+dOgfsGWoBeX915g+GMrqUh555ET2QZOLyTqedK
         nU6oZcU5jK8txI8W8nU5G2pJF4Qx1CGZqoUriVGj90DcWhzkkDwFCs6LqEgr5kIL5L1c
         qqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763723492; x=1764328292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z9lfbyfUipLlDYUmoPFufZ/w0ZJAQG/DQOcG0klnz4U=;
        b=WFAOLPKGOx8BvQVF4ZTlU6GTY2Fx6+eyXZmYGnH5ncs8dAk1ft3UMqi7x+vJSqRGH3
         EHiK8mOnw55NKwj71FLnpzZI9wVmpZqmWV/He+DhsxOkv+SwfmkPc/FJEzRoWHkclzPO
         bzHz6fM1mAcyZo40OGZsYtuuE8qwpXXy8lfH7yNRkVg8GtHHm4tLwiIIieWLQubnQt/2
         En/Ke+lj0dBC2xjMPGW5YHqPlNV133GxnLFWK1V+Uq1esMOtgljA0OHCxLTQov+hR+eC
         lJKkvkl0WZ41i1BLvORQIvR3UaXfZ/t1UjskvQsVrwNoBfy0+CBMVmp1oLaU6JkducmR
         aMiA==
X-Forwarded-Encrypted: i=1; AJvYcCXne1Z0X1EtM+9taAQOGwYRyTVG9wqFErGD9GkA1Ey0x8KKbEZGBS2ly/ffknSlvfS8a1mhbdaKIfPUunKI4hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCmhithRfGF5QB5uVM0ITY6unlZQT5LLHdNbDBeFRZ49r3amzo
	F28BgULr2qtYRQpAwqDLdDGIG+Qbtm1fIVruXHTG7PcZytgowpg9ND0Y
X-Gm-Gg: ASbGncvVyPCTAIbmG2NbTzHm4QKKxueoNEgZVjR6vFOxsJsKla0JqQK2YWKksDgAlr0
	7Ag3BBJI3jIh9G3MdUIxd5fKLCWjdA3WRuF95GjhAYQvfmGxjFBhjVaHwQLxpZvCZEp0DrVWHp9
	RPLQBdjE4eYnrDuDan+E0ERNxb7pqcycJEiXbvDzOAT2CKj2qx4nqCzDL8cfElcB/ClFtlz51FP
	1Ishqb71LPdCCiLV7GWJpFpir7KKyaCMC0mIm5kwkVDkMiODVqajTC98cQ7rZi0m/MElehEBtii
	wyJGUQkgxuK7EMSjNqOI/rZuj599jtiBNFbr3bg7zQfTt4K32mWwGWscvfLrHQmiXqhP4NhntQY
	mwvwPkw9W5NkusezJopKRgvWSLDwuzwY53lJMjWIAjBMphSLhQhUCJDX6n5afuAoLfpU64yzoEJ
	DazD0Dipp4RtBkA1XYvUzc76vxoFQQrktMnkdbvjOGx6sjClv8Q20aQavhk7kGqb9HeAO+58CAK
	M0YKOlgFEJocl+6WjjWMiyGpXqe/zO1
X-Google-Smtp-Source: AGHT+IFS5CVJxsaWzVOowDMAJtzWZgjU5STn25EdkLeEdQN+ZxFOgyISk8523u0BUvpkT7Am/KjKYQ==
X-Received: by 2002:a5d:64e5:0:b0:427:809:eff5 with SMTP id ffacd0b85a97d-42cc1d51ee7mr1872421f8f.53.1763723491607;
        Fri, 21 Nov 2025 03:11:31 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363e4sm10484180f8f.12.2025.11.21.03.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:11:31 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	vkuznets@redhat.com,
	shuah@kernel.org,
	dwmw@amazon.co.uk,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fred Griffoul <fgriffo@amazon.co.uk>
Subject: [PATCH v3 06/10] KVM: nVMX: Cache evmcs fields to ensure consistency during VM-entry
Date: Fri, 21 Nov 2025 11:11:09 +0000
Message-ID: <20251121111113.456628-7-griffoul@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121111113.456628-1-griffoul@gmail.com>
References: <20251121111113.456628-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

Cache enlightened VMCS control fields to prevent TOCTOU races where the
guest could modify hv_clean_fields or hv_enlightenments_control between
multiple accesses during nested VM-entry.

The cached values ensure consistent behavior across:
- The evmcs-to-vmcs12 copy operations
- MSR bitmap validation
- Clean field checks in prepare_vmcs02_rare()

This eliminates potential guest-induced inconsistencies in nested
virtualization state management.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 arch/x86/kvm/vmx/hyperv.c |  5 ++--
 arch/x86/kvm/vmx/hyperv.h | 20 +++++++++++++
 arch/x86/kvm/vmx/nested.c | 62 ++++++++++++++++++++++++---------------
 arch/x86/kvm/vmx/vmx.h    |  5 +++-
 4 files changed, 65 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
index fa41d036acd4..961b91b9bd64 100644
--- a/arch/x86/kvm/vmx/hyperv.c
+++ b/arch/x86/kvm/vmx/hyperv.c
@@ -213,12 +213,11 @@ bool nested_evmcs_l2_tlb_flush_enabled(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	struct hv_enlightened_vmcs *evmcs = vmx->nested.hv_evmcs;
 
-	if (!hv_vcpu || !evmcs)
+	if (!hv_vcpu || !nested_vmx_is_evmptr12_valid(vmx))
 		return false;
 
-	if (!evmcs->hv_enlightenments_control.nested_flush_hypercall)
+	if (!vmx->nested.hv_flush_hypercall)
 		return false;
 
 	return hv_vcpu->vp_assist_page.nested_control.features.directhypercall;
diff --git a/arch/x86/kvm/vmx/hyperv.h b/arch/x86/kvm/vmx/hyperv.h
index 11a339009781..3c7fea501ca5 100644
--- a/arch/x86/kvm/vmx/hyperv.h
+++ b/arch/x86/kvm/vmx/hyperv.h
@@ -52,6 +52,16 @@ static inline bool guest_cpu_cap_has_evmcs(struct kvm_vcpu *vcpu)
 	       to_vmx(vcpu)->nested.enlightened_vmcs_enabled;
 }
 
+static inline u32 nested_evmcs_clean_fields(struct vcpu_vmx *vmx)
+{
+	return vmx->nested.hv_clean_fields;
+}
+
+static inline bool nested_evmcs_msr_bitmap(struct vcpu_vmx *vmx)
+{
+	return vmx->nested.hv_msr_bitmap;
+}
+
 u64 nested_get_evmptr(struct kvm_vcpu *vcpu);
 uint16_t nested_get_evmcs_version(struct kvm_vcpu *vcpu);
 int nested_enable_evmcs(struct kvm_vcpu *vcpu,
@@ -85,6 +95,16 @@ static inline struct hv_enlightened_vmcs *nested_vmx_evmcs(struct vcpu_vmx *vmx)
 {
 	return NULL;
 }
+
+static inline u32 nested_evmcs_clean_fields(struct vcpu_vmx *vmx)
+{
+	return 0;
+}
+
+static inline bool nested_evmcs_msr_bitmap(struct vcpu_vmx *vmx)
+{
+	return false;
+}
 #endif
 
 #endif /* __KVM_X86_VMX_HYPERV_H */
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1f58b380585b..aec150612818 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -235,6 +235,9 @@ static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
 	kvm_vcpu_unmap(vcpu, &vmx->nested.hv_evmcs_map);
 	vmx->nested.hv_evmcs = NULL;
 	vmx->nested.hv_evmcs_vmptr = EVMPTR_INVALID;
+	vmx->nested.hv_clean_fields = 0;
+	vmx->nested.hv_msr_bitmap = false;
+	vmx->nested.hv_flush_hypercall = false;
 
 	if (hv_vcpu) {
 		hv_vcpu->nested.pa_page_gpa = INVALID_GPA;
@@ -686,10 +689,10 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	 *   and tells KVM (L0) there were no changes in MSR bitmap for L2.
 	 */
 	if (!vmx->nested.force_msr_bitmap_recalc) {
-		struct hv_enlightened_vmcs *evmcs = nested_vmx_evmcs(vmx);
-
-		if (evmcs && evmcs->hv_enlightenments_control.msr_bitmap &&
-		    evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP)
+		if (nested_vmx_is_evmptr12_valid(vmx) &&
+		    nested_evmcs_msr_bitmap(vmx) &&
+		    (nested_evmcs_clean_fields(vmx)
+		     & HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP))
 			return true;
 	}
 
@@ -2163,10 +2166,11 @@ static void copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
  * instruction.
  */
 static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
-	struct kvm_vcpu *vcpu, bool from_launch)
+	struct kvm_vcpu *vcpu, bool from_launch, bool copy)
 {
 #ifdef CONFIG_KVM_HYPERV
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct hv_enlightened_vmcs *evmcs;
 	bool evmcs_gpa_changed = false;
 	u64 evmcs_gpa;
 
@@ -2246,6 +2250,22 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
 		vmx->nested.force_msr_bitmap_recalc = true;
 	}
 
+	/* Cache evmcs fields to avoid reading evmcs after copy to vmcs12 */
+	evmcs = vmx->nested.hv_evmcs;
+	vmx->nested.hv_clean_fields = evmcs->hv_clean_fields;
+	vmx->nested.hv_flush_hypercall = evmcs->hv_enlightenments_control.nested_flush_hypercall;
+	vmx->nested.hv_msr_bitmap = evmcs->hv_enlightenments_control.msr_bitmap;
+
+	if (copy) {
+		struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+
+		if (likely(!vmcs12->hdr.shadow_vmcs)) {
+			copy_enlightened_to_vmcs12(vmx, vmx->nested.hv_clean_fields);
+			/* Enlightened VMCS doesn't have launch state */
+			vmcs12->launch_state = !from_launch;
+		}
+	}
+
 	return EVMPTRLD_SUCCEEDED;
 #else
 	return EVMPTRLD_DISABLED;
@@ -2613,10 +2633,12 @@ static void vmcs_write_cet_state(struct kvm_vcpu *vcpu, u64 s_cet,
 
 static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 {
-	struct hv_enlightened_vmcs *hv_evmcs = nested_vmx_evmcs(vmx);
+	u32 hv_clean_fields = 0;
 
-	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
-			   HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
+	if (nested_vmx_is_evmptr12_valid(vmx))
+		hv_clean_fields = nested_evmcs_clean_fields(vmx);
+
+	if (!(hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
 
 		vmcs_write16(GUEST_ES_SELECTOR, vmcs12->guest_es_selector);
 		vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
@@ -2658,8 +2680,7 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 		vmx_segment_cache_clear(vmx);
 	}
 
-	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
-			   HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1)) {
+	if (!(hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1)) {
 		vmcs_write32(GUEST_SYSENTER_CS, vmcs12->guest_sysenter_cs);
 		vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
 			    vmcs12->guest_pending_dbg_exceptions);
@@ -2750,7 +2771,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 			  enum vm_entry_failure_code *entry_failure_code)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	struct hv_enlightened_vmcs *evmcs = nested_vmx_evmcs(vmx);
+	struct hv_enlightened_vmcs *evmcs;
 	bool load_guest_pdptrs_vmcs12 = false;
 
 	if (vmx->nested.dirty_vmcs12 || nested_vmx_is_evmptr12_valid(vmx)) {
@@ -2758,7 +2779,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 		vmx->nested.dirty_vmcs12 = false;
 
 		load_guest_pdptrs_vmcs12 = !nested_vmx_is_evmptr12_valid(vmx) ||
-			!(evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1);
+			!(nested_evmcs_clean_fields(vmx)
+			  & HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1);
 	}
 
 	if (vmx->nested.nested_run_pending &&
@@ -2887,7 +2909,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	 * bits when it changes a field in eVMCS. Mark all fields as clean
 	 * here.
 	 */
-	if (nested_vmx_is_evmptr12_valid(vmx))
+	evmcs = nested_vmx_evmcs(vmx);
+	if (evmcs)
 		evmcs->hv_clean_fields |= HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
 
 	return 0;
@@ -3470,7 +3493,7 @@ static bool nested_get_evmcs_page(struct kvm_vcpu *vcpu)
 	if (guest_cpu_cap_has_evmcs(vcpu) &&
 	    vmx->nested.hv_evmcs_vmptr == EVMPTR_MAP_PENDING) {
 		enum nested_evmptrld_status evmptrld_status =
-			nested_vmx_handle_enlightened_vmptrld(vcpu, false);
+			nested_vmx_handle_enlightened_vmptrld(vcpu, false, false);
 
 		if (evmptrld_status == EVMPTRLD_VMFAIL ||
 		    evmptrld_status == EVMPTRLD_ERROR)
@@ -3864,7 +3887,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	evmptrld_status = nested_vmx_handle_enlightened_vmptrld(vcpu, launch);
+	evmptrld_status = nested_vmx_handle_enlightened_vmptrld(vcpu, launch, true);
 	if (evmptrld_status == EVMPTRLD_ERROR) {
 		kvm_queue_exception(vcpu, UD_VECTOR);
 		return 1;
@@ -3890,15 +3913,8 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	if (CC(vmcs12->hdr.shadow_vmcs))
 		return nested_vmx_failInvalid(vcpu);
 
-	if (nested_vmx_is_evmptr12_valid(vmx)) {
-		struct hv_enlightened_vmcs *evmcs = nested_vmx_evmcs(vmx);
-
-		copy_enlightened_to_vmcs12(vmx, evmcs->hv_clean_fields);
-		/* Enlightened VMCS doesn't have launch state */
-		vmcs12->launch_state = !launch;
-	} else if (enable_shadow_vmcs) {
+	if (!nested_vmx_is_evmptr12_valid(vmx) && enable_shadow_vmcs)
 		copy_shadow_to_vmcs12(vmx);
-	}
 
 	/*
 	 * The nested entry process starts with enforcing various prerequisites
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 9a285834ccda..87708af502f3 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -205,8 +205,11 @@ struct nested_vmx {
 
 #ifdef CONFIG_KVM_HYPERV
 	gpa_t hv_evmcs_vmptr;
-	struct kvm_host_map hv_evmcs_map;
+	u32 hv_clean_fields;
+	bool hv_msr_bitmap;
+	bool hv_flush_hypercall;
 	struct hv_enlightened_vmcs *hv_evmcs;
+	struct kvm_host_map hv_evmcs_map;
 #endif
 };
 
-- 
2.43.0


