Return-Path: <linux-kselftest+bounces-46216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 116F1C78B42
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 146C44EA711
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 11:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2217C34C806;
	Fri, 21 Nov 2025 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqNAKXZd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6998034B412
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723499; cv=none; b=YK/2qS/IHmrIBeVPuz6yn+jZyO+oFCHfK3k1v+w9PNaR6ywIYl+6/Y2il09sr+QDU/XZw66hD/k55b5zOY5Ri1jhDxVwnHddxr2ZoDkGz7IRQSgzB8mQzdZQoEm0WRnn7tSSWYK6Iz2OHel57yHu9g56bHIng5xnOfCz65RH/cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723499; c=relaxed/simple;
	bh=wgDc98t7P8ZNdoMQOLd5MxQvGkcfkUw91+1rgWMHI5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4BSoTUSH96c7wkj5qaYi8j7AHz6npQeHG/GdGiEOcPEa4cBFdKWCx7vIMJyZ9hXG2L8iSKuBmWd92lnQlGuGHUwuDeA9XcngXnGIuwbZ0vn7BtEsbMbRkb1SrFZ4hfVF+eHitGZKFVzu3eLp0jHEwJUaSQjU0G+fZXdwcla0zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqNAKXZd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b32a3e78bso1574408f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 03:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763723493; x=1764328293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AY8nf1WqUH91gBpTnhoe8Wrlir/GNvxmhkmTTXd2LOs=;
        b=TqNAKXZd++x7QtyQxoaA/Id0737RRq82F1ImqELpuveAAor+vfKc6KxbfdxOTQ4Zcy
         Ux+lDQbRUOzbNs1nKhdks+opTWk5ZwtgJj8iYeHRA2cQmGJDWb+gLpqEPPsMj/nbi3Q0
         pJxWaMqq3sb3tZ5r/C7h1yzlL4mDYzlcUG6h/Z3ZezgHhf0B2phb+aWF6QJrMtQI6brB
         yWu+385iy5875UiFfkUp+rC20rAFBEuLekM20+zWLPlA/awWSV8Ewz6vg9lpHyRPjvD7
         sObr6bBmn+XWEHPiT9uXgj853A44qhw/FRH4phSJ5cU+ZMTAncu8jnFsWWCjoF60wORE
         gA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763723493; x=1764328293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AY8nf1WqUH91gBpTnhoe8Wrlir/GNvxmhkmTTXd2LOs=;
        b=AvPbpu6BGF2rgIlkDHCt5ApRRTBKRKLbcBhW0GM/J0oA+8A5bopv3gtEwI2AvRBpjY
         6h/dYZcar9gize3YzORN3h0kZIpft/NCHg6yE7tMXahpmrxmpnMGUrD7zDcwy+tUZXuf
         xdR7tnyvN6Q584ifgihEtdOnLg35TVUi9OU0eTrJYx3NILfFELuhd602eLUWm1/EPKIW
         cqAFXjfw6Y1mmNoMingrmDRzXiWdHMUHRVlwwo2/7PiLXsnckzuckTsNkkOVk51Ee3dE
         ZmtjnKy5Ctg0O7BWwTqLO1J4xzQ5eYeHwrna7buNiB85iRsLP0MHtpCsDIAh//AoklAN
         eRMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjgr4kj8Jpg0KFM4pi0yPG+Aql4BG363JETY5YdVit5I5cNMTiYBZvkzlYHQPX0M8od/9jyZYV+QH1ivbAdM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXAquSHix/KP9gZQRN2J0+hCGjlmSW0wS2eNNkVSb1hDdca6Rb
	Vu4VsyWs/DWi83Jqe+vbodNIihfBZ+q9FEC9Ht4NsKbqAFn15if+DPznXXday6PyG6Ff7Q==
X-Gm-Gg: ASbGncsx7+FyEl/aEKP94f6qIvCFNtyUq9ih4D3wRevo63GocDlnmkXdl0SEQCVmCF1
	cMoia6DI2zEvaGvtwmys64p1GRcjaYAx2sEeOY+yw7qki8xGCAnTzFCi5MAwA2BvvwGyf0Jl9a9
	wj0cdms5gAhZX7wuTPLMIauNwRBNbmkXio9m4CMcDkBsf4H27Z30exW6moizlqvdwFJmpuV1LRL
	ePi7/FbqnljOayPiBoE9rKVq9Q5QdIRvsioZL/kBezWqIITbyOTrp6WkG33Mc4oT33Dr6l++iFu
	7O6/1e2jyJSQDGxDWGiqbWOgWWJTrZLEnP8J2krUfA6LlVVFPI0yTcx538fqdg+r/IYvZA6Ymr+
	3tjVGGhD9LVuDFpVKlCq5ppv9rCB6/EK4GGIGU4xwymxdwDzcX5lnBLMJvHhBKJh3tvDjXZktcz
	8dsWKexfVfeyGZ4I5U9DBku4cQ04W1DBA7mhPgI6eYRkuK3THeKQfrjS4/NDuVc8PhgnAjuhKWL
	rH05NUvIIDyrvSZ+aANTpnoHx01G1yI
X-Google-Smtp-Source: AGHT+IERzanYCk23RErBiQ6xR2Tl5MpVBZUpbfsKunpb725aVCZGbxpBtIO+KufNWCd0ibXD1qDWgw==
X-Received: by 2002:a05:6000:2689:b0:42b:2e65:655f with SMTP id ffacd0b85a97d-42cc1cbd2c0mr2002279f8f.19.1763723493221;
        Fri, 21 Nov 2025 03:11:33 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363e4sm10484180f8f.12.2025.11.21.03.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:11:32 -0800 (PST)
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
Subject: [PATCH v3 07/10] KVM: nVMX: Replace evmcs kvm_host_map with pfncache
Date: Fri, 21 Nov 2025 11:11:10 +0000
Message-ID: <20251121111113.456628-8-griffoul@gmail.com>
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

Replace the eVMCS kvm_host_map with a gfn_to_pfn_cache to properly
handle memslot changes and unify with other pfncaches in nVMX.

The change introduces proper locking/unlocking semantics for eVMCS
access through nested_lock_evmcs() and nested_unlock_evmcs() helpers.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 arch/x86/kvm/vmx/hyperv.h |  21 +++----
 arch/x86/kvm/vmx/nested.c | 115 ++++++++++++++++++++++++++------------
 arch/x86/kvm/vmx/vmx.h    |   3 +-
 3 files changed, 90 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kvm/vmx/hyperv.h b/arch/x86/kvm/vmx/hyperv.h
index 3c7fea501ca5..3b6fcf8dff64 100644
--- a/arch/x86/kvm/vmx/hyperv.h
+++ b/arch/x86/kvm/vmx/hyperv.h
@@ -37,11 +37,6 @@ static inline bool nested_vmx_is_evmptr12_set(struct vcpu_vmx *vmx)
 	return evmptr_is_set(vmx->nested.hv_evmcs_vmptr);
 }
 
-static inline struct hv_enlightened_vmcs *nested_vmx_evmcs(struct vcpu_vmx *vmx)
-{
-	return vmx->nested.hv_evmcs;
-}
-
 static inline bool guest_cpu_cap_has_evmcs(struct kvm_vcpu *vcpu)
 {
 	/*
@@ -70,6 +65,8 @@ void nested_evmcs_filter_control_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *
 int nested_evmcs_check_controls(struct vmcs12 *vmcs12);
 bool nested_evmcs_l2_tlb_flush_enabled(struct kvm_vcpu *vcpu);
 void vmx_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu);
+struct hv_enlightened_vmcs *nested_lock_evmcs(struct vcpu_vmx *vmx);
+void nested_unlock_evmcs(struct vcpu_vmx *vmx);
 #else
 static inline bool evmptr_is_valid(u64 evmptr)
 {
@@ -91,11 +88,6 @@ static inline bool nested_vmx_is_evmptr12_set(struct vcpu_vmx *vmx)
 	return false;
 }
 
-static inline struct hv_enlightened_vmcs *nested_vmx_evmcs(struct vcpu_vmx *vmx)
-{
-	return NULL;
-}
-
 static inline u32 nested_evmcs_clean_fields(struct vcpu_vmx *vmx)
 {
 	return 0;
@@ -105,6 +97,15 @@ static inline bool nested_evmcs_msr_bitmap(struct vcpu_vmx *vmx)
 {
 	return false;
 }
+
+static inline struct hv_enlightened_vmcs *nested_lock_evmcs(struct vcpu_vmx *vmx)
+{
+	return NULL;
+}
+
+static inline void nested_unlock_evmcs(struct vcpu_vmx *vmx)
+{
+}
 #endif
 
 #endif /* __KVM_X86_VMX_HYPERV_H */
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index aec150612818..207780ef0926 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -232,8 +232,6 @@ static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	kvm_vcpu_unmap(vcpu, &vmx->nested.hv_evmcs_map);
-	vmx->nested.hv_evmcs = NULL;
 	vmx->nested.hv_evmcs_vmptr = EVMPTR_INVALID;
 	vmx->nested.hv_clean_fields = 0;
 	vmx->nested.hv_msr_bitmap = false;
@@ -265,7 +263,7 @@ static bool nested_evmcs_handle_vmclear(struct kvm_vcpu *vcpu, gpa_t vmptr)
 	    !evmptr_is_valid(nested_get_evmptr(vcpu)))
 		return false;
 
-	if (nested_vmx_evmcs(vmx) && vmptr == vmx->nested.hv_evmcs_vmptr)
+	if (vmptr == vmx->nested.hv_evmcs_vmptr)
 		nested_release_evmcs(vcpu);
 
 	return true;
@@ -393,6 +391,9 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	kvm_gpc_deactivate(&vmx->nested.virtual_apic_cache);
 	kvm_gpc_deactivate(&vmx->nested.apic_access_page_cache);
 	kvm_gpc_deactivate(&vmx->nested.msr_bitmap_cache);
+#ifdef CONFIG_KVM_HYPERV
+	kvm_gpc_deactivate(&vmx->nested.hv_evmcs_cache);
+#endif
 
 	free_vpid(vmx->nested.vpid02);
 	vmx->nested.posted_intr_nv = -1;
@@ -1735,11 +1736,12 @@ static void copy_vmcs12_to_shadow(struct vcpu_vmx *vmx)
 	vmcs_load(vmx->loaded_vmcs->vmcs);
 }
 
-static void copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx, u32 hv_clean_fields)
-{
 #ifdef CONFIG_KVM_HYPERV
+static void copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx,
+				       struct hv_enlightened_vmcs *evmcs,
+				       u32 hv_clean_fields)
+{
 	struct vmcs12 *vmcs12 = vmx->nested.cached_vmcs12;
-	struct hv_enlightened_vmcs *evmcs = nested_vmx_evmcs(vmx);
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(&vmx->vcpu);
 
 	/* HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE */
@@ -1978,16 +1980,14 @@ static void copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx, u32 hv_clean_fields
 	 */
 
 	return;
-#else /* CONFIG_KVM_HYPERV */
-	KVM_BUG_ON(1, vmx->vcpu.kvm);
-#endif /* CONFIG_KVM_HYPERV */
 }
+#endif /* CONFIG_KVM_HYPERV */
 
 static void copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
 {
 #ifdef CONFIG_KVM_HYPERV
 	struct vmcs12 *vmcs12 = vmx->nested.cached_vmcs12;
-	struct hv_enlightened_vmcs *evmcs = nested_vmx_evmcs(vmx);
+	struct hv_enlightened_vmcs *evmcs = nested_lock_evmcs(vmx);
 
 	/*
 	 * Should not be changed by KVM:
@@ -2155,6 +2155,7 @@ static void copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
 
 	evmcs->guest_bndcfgs = vmcs12->guest_bndcfgs;
 
+	nested_unlock_evmcs(vmx);
 	return;
 #else /* CONFIG_KVM_HYPERV */
 	KVM_BUG_ON(1, vmx->vcpu.kvm);
@@ -2171,6 +2172,8 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
 #ifdef CONFIG_KVM_HYPERV
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct hv_enlightened_vmcs *evmcs;
+	struct gfn_to_pfn_cache *gpc;
+	enum nested_evmptrld_status status = EVMPTRLD_SUCCEEDED;
 	bool evmcs_gpa_changed = false;
 	u64 evmcs_gpa;
 
@@ -2183,17 +2186,19 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
 		return EVMPTRLD_DISABLED;
 	}
 
+	gpc = &vmx->nested.hv_evmcs_cache;
+	if (nested_gpc_lock(gpc, evmcs_gpa)) {
+		nested_release_evmcs(vcpu);
+		return EVMPTRLD_ERROR;
+	}
+
+	evmcs = gpc->khva;
+
 	if (unlikely(evmcs_gpa != vmx->nested.hv_evmcs_vmptr)) {
 		vmx->nested.current_vmptr = INVALID_GPA;
 
 		nested_release_evmcs(vcpu);
 
-		if (kvm_vcpu_map(vcpu, gpa_to_gfn(evmcs_gpa),
-				 &vmx->nested.hv_evmcs_map))
-			return EVMPTRLD_ERROR;
-
-		vmx->nested.hv_evmcs = vmx->nested.hv_evmcs_map.hva;
-
 		/*
 		 * Currently, KVM only supports eVMCS version 1
 		 * (== KVM_EVMCS_VERSION) and thus we expect guest to set this
@@ -2216,10 +2221,11 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
 		 * eVMCS version or VMCS12 revision_id as valid values for first
 		 * u32 field of eVMCS.
 		 */
-		if ((vmx->nested.hv_evmcs->revision_id != KVM_EVMCS_VERSION) &&
-		    (vmx->nested.hv_evmcs->revision_id != VMCS12_REVISION)) {
+		if ((evmcs->revision_id != KVM_EVMCS_VERSION) &&
+		    (evmcs->revision_id != VMCS12_REVISION)) {
 			nested_release_evmcs(vcpu);
-			return EVMPTRLD_VMFAIL;
+			status = EVMPTRLD_VMFAIL;
+			goto unlock;
 		}
 
 		vmx->nested.hv_evmcs_vmptr = evmcs_gpa;
@@ -2244,14 +2250,11 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
 	 * between different L2 guests as KVM keeps a single VMCS12 per L1.
 	 */
 	if (from_launch || evmcs_gpa_changed) {
-		vmx->nested.hv_evmcs->hv_clean_fields &=
-			~HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
-
+		evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
 		vmx->nested.force_msr_bitmap_recalc = true;
 	}
 
 	/* Cache evmcs fields to avoid reading evmcs after copy to vmcs12 */
-	evmcs = vmx->nested.hv_evmcs;
 	vmx->nested.hv_clean_fields = evmcs->hv_clean_fields;
 	vmx->nested.hv_flush_hypercall = evmcs->hv_enlightenments_control.nested_flush_hypercall;
 	vmx->nested.hv_msr_bitmap = evmcs->hv_enlightenments_control.msr_bitmap;
@@ -2260,13 +2263,15 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
 		struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 
 		if (likely(!vmcs12->hdr.shadow_vmcs)) {
-			copy_enlightened_to_vmcs12(vmx, vmx->nested.hv_clean_fields);
+			copy_enlightened_to_vmcs12(vmx, evmcs, vmx->nested.hv_clean_fields);
 			/* Enlightened VMCS doesn't have launch state */
 			vmcs12->launch_state = !from_launch;
 		}
 	}
 
-	return EVMPTRLD_SUCCEEDED;
+unlock:
+	nested_gpc_unlock(gpc);
+	return status;
 #else
 	return EVMPTRLD_DISABLED;
 #endif
@@ -2771,7 +2776,6 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 			  enum vm_entry_failure_code *entry_failure_code)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	struct hv_enlightened_vmcs *evmcs;
 	bool load_guest_pdptrs_vmcs12 = false;
 
 	if (vmx->nested.dirty_vmcs12 || nested_vmx_is_evmptr12_valid(vmx)) {
@@ -2909,9 +2913,13 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	 * bits when it changes a field in eVMCS. Mark all fields as clean
 	 * here.
 	 */
-	evmcs = nested_vmx_evmcs(vmx);
-	if (evmcs)
+	if (nested_vmx_is_evmptr12_valid(vmx)) {
+		struct hv_enlightened_vmcs *evmcs;
+
+		evmcs = nested_lock_evmcs(vmx);
 		evmcs->hv_clean_fields |= HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
+		nested_unlock_evmcs(vmx);
+	}
 
 	return 0;
 }
@@ -4147,6 +4155,18 @@ static void *nested_gpc_lock_if_active(struct gfn_to_pfn_cache *gpc)
 	return gpc->khva;
 }
 
+#ifdef CONFIG_KVM_HYPERV
+struct hv_enlightened_vmcs *nested_lock_evmcs(struct vcpu_vmx *vmx)
+{
+	return nested_gpc_lock_if_active(&vmx->nested.hv_evmcs_cache);
+}
+
+void nested_unlock_evmcs(struct vcpu_vmx *vmx)
+{
+	nested_gpc_unlock(&vmx->nested.hv_evmcs_cache);
+}
+#endif
+
 static struct pi_desc *nested_lock_pi_desc(struct vcpu_vmx *vmx)
 {
 	u8 *pi_desc_page;
@@ -5636,6 +5656,9 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 	kvm_gpc_init_for_vcpu(&vmx->nested.virtual_apic_cache, vcpu);
 	kvm_gpc_init_for_vcpu(&vmx->nested.pi_desc_cache, vcpu);
 
+#ifdef CONFIG_KVM_HYPERV
+	kvm_gpc_init(&vmx->nested.hv_evmcs_cache, vcpu->kvm);
+#endif
 	vmx->nested.vmcs02_initialized = false;
 	vmx->nested.vmxon = true;
 
@@ -5887,6 +5910,8 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 		/* Read the field, zero-extended to a u64 value */
 		value = vmcs12_read_any(vmcs12, field, offset);
 	} else {
+		struct hv_enlightened_vmcs *evmcs;
+
 		/*
 		 * Hyper-V TLFS (as of 6.0b) explicitly states, that while an
 		 * enlightened VMCS is active VMREAD/VMWRITE instructions are
@@ -5905,7 +5930,9 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 			return nested_vmx_fail(vcpu, VMXERR_UNSUPPORTED_VMCS_COMPONENT);
 
 		/* Read the field, zero-extended to a u64 value */
-		value = evmcs_read_any(nested_vmx_evmcs(vmx), field, offset);
+		evmcs = nested_lock_evmcs(vmx);
+		value = evmcs_read_any(evmcs, field, offset);
+		nested_unlock_evmcs(vmx);
 	}
 
 	/*
@@ -6935,6 +6962,27 @@ bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
 	return true;
 }
 
+static void vmx_get_enlightened_to_vmcs12(struct vcpu_vmx *vmx)
+{
+#ifdef CONFIG_KVM_HYPERV
+	struct hv_enlightened_vmcs *evmcs;
+	struct kvm_vcpu *vcpu = &vmx->vcpu;
+
+	kvm_vcpu_srcu_read_lock(vcpu);
+	evmcs = nested_lock_evmcs(vmx);
+	/*
+	 * L1 hypervisor is not obliged to keep eVMCS
+	 * clean fields data always up-to-date while
+	 * not in guest mode, 'hv_clean_fields' is only
+	 * supposed to be actual upon vmentry so we need
+	 * to ignore it here and do full copy.
+	 */
+	copy_enlightened_to_vmcs12(vmx, evmcs, 0);
+	nested_unlock_evmcs(vmx);
+	kvm_vcpu_srcu_read_unlock(vcpu);
+#endif /* CONFIG_KVM_HYPERV */
+}
+
 static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 				struct kvm_nested_state __user *user_kvm_nested_state,
 				u32 user_data_size)
@@ -7025,14 +7073,7 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 		copy_vmcs02_to_vmcs12_rare(vcpu, get_vmcs12(vcpu));
 		if (!vmx->nested.need_vmcs12_to_shadow_sync) {
 			if (nested_vmx_is_evmptr12_valid(vmx))
-				/*
-				 * L1 hypervisor is not obliged to keep eVMCS
-				 * clean fields data always up-to-date while
-				 * not in guest mode, 'hv_clean_fields' is only
-				 * supposed to be actual upon vmentry so we need
-				 * to ignore it here and do full copy.
-				 */
-				copy_enlightened_to_vmcs12(vmx, 0);
+				vmx_get_enlightened_to_vmcs12(vmx);
 			else if (enable_shadow_vmcs)
 				copy_shadow_to_vmcs12(vmx);
 		}
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 87708af502f3..4da5a42b0c60 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -208,8 +208,7 @@ struct nested_vmx {
 	u32 hv_clean_fields;
 	bool hv_msr_bitmap;
 	bool hv_flush_hypercall;
-	struct hv_enlightened_vmcs *hv_evmcs;
-	struct kvm_host_map hv_evmcs_map;
+	struct gfn_to_pfn_cache hv_evmcs_cache;
 #endif
 };
 
-- 
2.43.0


