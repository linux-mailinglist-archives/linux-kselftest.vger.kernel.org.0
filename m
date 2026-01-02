Return-Path: <linux-kselftest+bounces-48067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FE7CEEC21
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 15:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FFFD30572D0
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 14:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB35313E26;
	Fri,  2 Jan 2026 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CguNQEhS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7183128B1
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Jan 2026 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767363890; cv=none; b=QGsgUs3yXIedkymz8sU+A8ypc50z2HKVmjXqtU/1Rin8YjlxENAuXyqvDlExvdmupndVhdHA11JSfAvfqiEzih/J9dOaQ9ngG4xUBBQ3w+L9N7vWaSFEvQAuIx4RVkEdrqYZTWrvMFEErxPtJzBS2Q12cbTLBySnUNf5SVSji8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767363890; c=relaxed/simple;
	bh=D94jT9uTm8I3ULBddPOodz+zdhEiw8HnHhGjKYuKSYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTCC6r3Bxm6G1azIMUDmVI8BLDBEwvUD+KGgmIKiGjeOP0v8bTHr+nTLfd7arXQlyeO81qcF7ct1QcOQ7W9FuJoZImB7JvyB572P6+3AFC2V8WvcbjUqB/xTo2+JBeoK6GOuoetqKp+lpdZ/GuUv3UF5TahZ3L887C9Cqjj2chE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CguNQEhS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so94218495e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 06:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767363885; x=1767968685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jaE1bgRs9kOJOlVmB3CY42RXx5GV/XzBhp8NJevaCI=;
        b=CguNQEhSuD2H4vLOzUn+g3Vlo25LYmTEFtmVBsg7a3XzacHuas0+gHhKI5bhyXYvqj
         f3KWV7DOkjYEuRUqEGDjYIuqgHsuQPQ5SmD3SaRUxs9yxDPKxIlXhILWgBvMxQhu9QmL
         AFG77pMmdTnoGGB4YRo81ITP1qrVIt46e/2NVV+w/l0ZmQb+/h5B7PF/AKbZjdZdZHtx
         LY19yIWVM1vMrycSRK+Q7md9x5qJxO1Tq/bChhhEUR4Vv/ZhCxESjk17l5LrFyj8LIbi
         UrS3NlGHGvud9NkJIrwhgMvEPUL4NPsjGC0LXnwL6upHCfBlYY5gUw3Ja/Wvdg7FqF+8
         W8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767363885; x=1767968685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9jaE1bgRs9kOJOlVmB3CY42RXx5GV/XzBhp8NJevaCI=;
        b=d4xdTg16Vm2HoCtwwop7Mh/h5aPSCzoxwjzlb8ChjTBFfhrWjXR5hQHBxhv6qI6758
         wChOWzXFmtAKhGM3zmiOWoVJMkwtTJKZz+WxNExSejx/ORejYP2iP+/Ac3gFDt4yDpP4
         hXnnK4+U0usg1W3bZ84O71+2VUQlI60+ceNxcTjQH44lsBpybQatafwvkVvCiMd72+2g
         fJa8KqmQw61y1oanAN3fu8zbZAGRTswamHIDpk5oyRA8NmF+yARQ93ekNOy/BfiTDHCx
         9Mnm2QaSIn1kErWS1YD4T+WC+s03QDwxJbDF8E5IEN+zb6g4wMMBhJkn2pTsPLGH7lwY
         iIfA==
X-Forwarded-Encrypted: i=1; AJvYcCUcedwmZLQtYmpTabLzIHlBTX/9AWCG92C5Bn7hHBFrTlm6TzbZzQlF203Rpu3PE7X+/yMFdgxrDpL5jgdUNBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmtoRZf7p5QdA4zxafwmbwUgvdKK4KWBVNftVh9SGD0yTfBZo3
	GrWqAHGIWcyD8gpS5Py/00zBZk3nT8gwEeOd7gtuIlUtfCIHZyBM088+
X-Gm-Gg: AY/fxX5VmbMVwPo/7n0hyvTjsy10UE/oOH9kcyO0CFWV+D8YXMHJpmzIR4DVOTMxnPJ
	lr6vQRcvWdLarDi3o9HC2B9H4g8ryiZkM8MB/X/FEhWx1lPwqL/26gVEWiIXzxcgvYwxEj9dvVq
	BhESYZiHmOcshMnZg9kDs4u2mMqCG0nZzcAnF1yuhtkcREDi8HBFbR/sjMuoUwwj18qDjmg3yyM
	ueETu4/dviFlgBTSrqtsEie2qWeRy6u/jRWkGQ6Fagq4giqGNJO7vu0S2popNWa2b110EQgOw7n
	RLuSNlQBlwAy/DtvAkyhev7GAUJwKGSgp2fbvosFULdH1Rpkq8UGu50yNN+98XNaqcD1EPJgRg1
	vKEJDeASHbDqGmFN9O16uThUnhX2J0VBsBxGyKj3/Qbf6YI4gN7aKLo+Hbcusa4uHvLixdPViMN
	EMTOijsk6Ep8kUk37ncCMcHGH4uzAlfo2mMBNbJcSjYKIN29oRPAc/+L3Lhc8qgLroUuo2/eYxi
	/guiac29B1+agKCUVUGsmenzIqtlenP
X-Google-Smtp-Source: AGHT+IFW6Z3xPO2fOOiFRTZIK8Q2oP3dmU3vuq/TX++bDC85o9uKEkfGVGrX2bmfeGzK52NrR0/zBA==
X-Received: by 2002:a05:600c:4446:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-47d1956f896mr532884015e9.16.1767363884415;
        Fri, 02 Jan 2026 06:24:44 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm806409235e9.13.2026.01.02.06.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 06:24:44 -0800 (PST)
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
Subject: [PATCH v4 07/10] KVM: nVMX: Replace evmcs kvm_host_map with pfncache
Date: Fri,  2 Jan 2026 14:24:26 +0000
Message-ID: <20260102142429.896101-8-griffoul@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102142429.896101-1-griffoul@gmail.com>
References: <20260102142429.896101-1-griffoul@gmail.com>
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
index 5790e1a26456..491472ca825b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -233,8 +233,6 @@ static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	kvm_vcpu_unmap(vcpu, &vmx->nested.hv_evmcs_map);
-	vmx->nested.hv_evmcs = NULL;
 	vmx->nested.hv_evmcs_vmptr = EVMPTR_INVALID;
 	vmx->nested.hv_clean_fields = 0;
 	vmx->nested.hv_msr_bitmap = false;
@@ -266,7 +264,7 @@ static bool nested_evmcs_handle_vmclear(struct kvm_vcpu *vcpu, gpa_t vmptr)
 	    !evmptr_is_valid(nested_get_evmptr(vcpu)))
 		return false;
 
-	if (nested_vmx_evmcs(vmx) && vmptr == vmx->nested.hv_evmcs_vmptr)
+	if (vmptr == vmx->nested.hv_evmcs_vmptr)
 		nested_release_evmcs(vcpu);
 
 	return true;
@@ -391,6 +389,18 @@ static void *nested_gpc_lock_if_active(struct gfn_to_pfn_cache *gpc)
 	return gpc->khva;
 }
 
+#ifdef CONFIG_KVM_HYPERV
+struct hv_enlightened_vmcs *nested_lock_evmcs(struct vcpu_vmx *vmx)
+{
+	return nested_gpc_lock_if_active(vmx->nested.hv_evmcs_cache);
+}
+
+void nested_unlock_evmcs(struct vcpu_vmx *vmx)
+{
+	nested_gpc_unlock(vmx->nested.hv_evmcs_cache);
+}
+#endif
+
 static struct pi_desc *nested_lock_pi_desc(struct vcpu_vmx *vmx)
 {
 	u8 *pi_desc_page;
@@ -441,6 +451,9 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	kvm_gpc_deactivate(&vmx->nested.virtual_apic_cache);
 	kvm_gpc_deactivate(&vmx->nested.apic_access_page_cache);
 	kvm_gpc_deactivate(&vmx->nested.msr_bitmap_cache);
+#ifdef CONFIG_KVM_HYPERV
+	kvm_gpc_deactivate(&vmx->nested.hv_evmcs_cache);
+#endif
 
 	free_vpid(vmx->nested.vpid02);
 	vmx->nested.posted_intr_nv = -1;
@@ -1786,11 +1799,12 @@ static void copy_vmcs12_to_shadow(struct vcpu_vmx *vmx)
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
@@ -2029,16 +2043,14 @@ static void copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx, u32 hv_clean_fields
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
@@ -2206,6 +2218,7 @@ static void copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
 
 	evmcs->guest_bndcfgs = vmcs12->guest_bndcfgs;
 
+	nested_unlock_evmcs(vmx);
 	return;
 #else /* CONFIG_KVM_HYPERV */
 	KVM_BUG_ON(1, vmx->vcpu.kvm);
@@ -2222,6 +2235,8 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
 #ifdef CONFIG_KVM_HYPERV
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct hv_enlightened_vmcs *evmcs;
+	struct gfn_to_pfn_cache *gpc;
+	enum nested_evmptrld_status status = EVMPTRLD_SUCCEEDED;
 	bool evmcs_gpa_changed = false;
 	u64 evmcs_gpa;
 
@@ -2234,17 +2249,19 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
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
@@ -2267,10 +2284,11 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
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
@@ -2295,14 +2313,11 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
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
@@ -2311,13 +2326,15 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
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
@@ -2813,7 +2830,6 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 			  enum vm_entry_failure_code *entry_failure_code)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	struct hv_enlightened_vmcs *evmcs;
 	bool load_guest_pdptrs_vmcs12 = false;
 
 	if (vmx->nested.dirty_vmcs12 || nested_vmx_is_evmptr12_valid(vmx)) {
@@ -2951,9 +2967,13 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
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
@@ -5595,6 +5615,9 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 	kvm_gpc_init_for_vcpu(&vmx->nested.virtual_apic_cache, vcpu);
 	kvm_gpc_init_for_vcpu(&vmx->nested.pi_desc_cache, vcpu);
 
+#ifdef CONFIG_KVM_HYPERV
+	kvm_gpc_init(&vmx->nested.hv_evmcs_cache, vcpu->kvm);
+#endif
 	vmx->nested.vmcs02_initialized = false;
 	vmx->nested.vmxon = true;
 
@@ -5846,6 +5869,8 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 		/* Read the field, zero-extended to a u64 value */
 		value = vmcs12_read_any(vmcs12, field, offset);
 	} else {
+		struct hv_enlightened_vmcs *evmcs;
+
 		/*
 		 * Hyper-V TLFS (as of 6.0b) explicitly states, that while an
 		 * enlightened VMCS is active VMREAD/VMWRITE instructions are
@@ -5864,7 +5889,9 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 			return nested_vmx_fail(vcpu, VMXERR_UNSUPPORTED_VMCS_COMPONENT);
 
 		/* Read the field, zero-extended to a u64 value */
-		value = evmcs_read_any(nested_vmx_evmcs(vmx), field, offset);
+		evmcs = nested_lock_evmcs(vmx);
+		value = evmcs_read_any(evmcs, field, offset);
+		nested_unlock_evmcs(vmx);
 	}
 
 	/*
@@ -6902,6 +6929,27 @@ bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
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
@@ -6992,14 +7040,7 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
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
index cda96196c56c..5517d68872f0 100644
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


