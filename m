Return-Path: <linux-kselftest+bounces-48066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB74CEEC12
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 15:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A73EA30422AB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2503313542;
	Fri,  2 Jan 2026 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXzY2cMc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A443128DF
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Jan 2026 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767363887; cv=none; b=lTD+1EctSIZMn7v6a/3mHzxAzj1z/RW6jVljmZY36c33tvHzd8uPSid2YAe1PUce+syq0pNOjWdft0Bbhhn6ntWtRZXgmMTOTTT9eGbl68lJD/flLAWI9BpwEjnCF1AffDwJAMcNzw2c8I1vFXc/GbECJrH4QLacGbp0vKZTr+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767363887; c=relaxed/simple;
	bh=lZbV/dX7h/19TG3DPx0fOuOKynnORRe51CdUHmfigQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYTELDWlO4tunfTMZ1alvZCdlr2QrrSRIxraFvOZXwBmJUQYnIXmm3Xs44qRP2OPdFwUo7L8f8qvQh4qcJhE1gPZjZzf+OeqBR0FLqsX7IBbyBAGZBkLx31pUFQKxk1gV9EqwqHIcKnIHKukgTSc+t0NhoDA6u/rbwSqGlOUpXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXzY2cMc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so79051665e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 06:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767363883; x=1767968683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sd6iKlP2TRxmMTsZhtPgZReyUb9SG2NSGR9QGJhmbWA=;
        b=ZXzY2cMcqpgTwZ0SAOeW6aIV6XGF5LTstPg7cOEven8HggoUXKZJZk80jKoANTUyJe
         Uy+eB+VaOOhKMEwuz5zolVk8ggmcfbYDfmSuJA9bTjuRAIsZTHyYJBGt5ttteN11w9Jh
         ZbdeNHyCmKoHONbnDnpiqH1VzPAW/3xD8xCB/3I6uxlVsUdQJ8H2snMM7BtqpDUzACGv
         E0qrTZ13reC9phj1/0zgFblIzRChmnhuC/eQPZnriqsg0+nyudkx5MJDxgRhyAwHFNe8
         nrmmK6s50RFEIjmLnmQPaUpBfl+lduPDAJcw3QPzEG/nGoRwV/fifLvE0YjWnhJHUgWB
         9Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767363883; x=1767968683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sd6iKlP2TRxmMTsZhtPgZReyUb9SG2NSGR9QGJhmbWA=;
        b=NIQXOpMjElqV3c/U0vYrehPx4T0+h3hWgZh7brmc/fbzTijAjh8orDY/eEbZQnXK8G
         nniRfxIivqZjCqVqCbIQg9UVu7FaFi1JYl0rrxr79F4rm8cwMcGSPEgsaXHZENWCoMaT
         IFppYHQD6+qvhtFr7YovYhIEyTEoPFGjfIGqR3do1LoEzFT7OylfcEW+9wuKhHrlGB9C
         sHoQ+UfrTjuTVnw3RiX/H6E9BthP3ADRgWXuvvI2grVz8rSb+E2OQfp7CfS1mcZYb/J8
         VDTA9KhWIliDoAI9YAXsqG/qHHHNiEMwdiIV/cLE3k/hXXma7TDaUzEXyTzXvRznxQeg
         CxDw==
X-Forwarded-Encrypted: i=1; AJvYcCV7l2Tk4hUdXo4F8Ac0ai/YZ9sS3daj0vLWoHQQMsEkCSgGvO5VC94hLmhfsKlitJlsII/5MfWFcxNbQdLzA8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1JN3DuS+1OSOUR1liDYlpkfmhG6YH694OxTZrM8ICMFJMWETR
	brVbN56CB71n94X7I/gUAfd+aSLDMTxz/NFSSvmnEdTRalunLBTwUjw0
X-Gm-Gg: AY/fxX6R7PqgKOzI9IkPhy/0YYA5455799FEsYgrZBnhw3EqMP7XNuk0ixiQ1tsYi4w
	uDkEEuzirhRSW7QwCsiCXEt4qs2GEtAXWFW2aGVA0RBNKZ9xFvIcoYE1wIniiTurNrB33cmRNVH
	vGwD2I98RRdD5ODpdgI6OGhb823p1hr6KmGwzq8ExDfvbj8RKi8XWkevm8I2wu0dL7mtACqLnhB
	1WQjK4NmLaG+PlVYSGzAebaDNOitLwq1pJeQmMwCoCoQMtYTuZs9DGuBYTTXCUGsyfp7hkmEFRD
	EF/WYRG4U/G47c2544GP8g6biKjL8Xhf8/8zzrm32HByMttVHoGCjXtsbiVkzoUEBwgp6lH6sbl
	stOI1RmvvATbnULB+Kn6D4WTbLAPO9SPjwS1Rp7x3BpYELuXH+9YXlBaENXKJQNw+vXV2sGwHKv
	JFxJM2UqEXZGrZOfw8RUewkxKrGIzedwskrqaeJZWLwrKXR2GYtP4OTA14ijwiaw2NC9hQZwl/7
	yIiWAVhcdwR42vseueB6BmG4HICe6oARZJfKeeUgyA=
X-Google-Smtp-Source: AGHT+IGkeilXHC6YOCnESo0TneoAV3b/5fWCjGUKZB6c0RQIHuD/gqkdCmBnl4EfHIDktl9LL05I9g==
X-Received: by 2002:a05:600c:19c8:b0:475:de68:3c30 with SMTP id 5b1f17b1804b1-47d1955797amr525448115e9.16.1767363883101;
        Fri, 02 Jan 2026 06:24:43 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm806409235e9.13.2026.01.02.06.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 06:24:42 -0800 (PST)
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
Subject: [PATCH v4 06/10] KVM: nVMX: Cache evmcs fields to ensure consistency during VM-entry
Date: Fri,  2 Jan 2026 14:24:25 +0000
Message-ID: <20260102142429.896101-7-griffoul@gmail.com>
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
index cb4b85edcb7a..5790e1a26456 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -236,6 +236,9 @@ static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
 	kvm_vcpu_unmap(vcpu, &vmx->nested.hv_evmcs_map);
 	vmx->nested.hv_evmcs = NULL;
 	vmx->nested.hv_evmcs_vmptr = EVMPTR_INVALID;
+	vmx->nested.hv_clean_fields = 0;
+	vmx->nested.hv_msr_bitmap = false;
+	vmx->nested.hv_flush_hypercall = false;
 
 	if (hv_vcpu) {
 		hv_vcpu->nested.pa_page_gpa = INVALID_GPA;
@@ -737,10 +740,10 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
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
 
@@ -2214,10 +2217,11 @@ static void copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
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
 
@@ -2297,6 +2301,22 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
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
@@ -2655,10 +2675,12 @@ static void vmcs_write_cet_state(struct kvm_vcpu *vcpu, u64 s_cet,
 
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
@@ -2700,8 +2722,7 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 		vmx_segment_cache_clear(vmx);
 	}
 
-	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
-			   HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1)) {
+	if (!(hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1)) {
 		vmcs_write32(GUEST_SYSENTER_CS, vmcs12->guest_sysenter_cs);
 		vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
 			    vmcs12->guest_pending_dbg_exceptions);
@@ -2792,7 +2813,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 			  enum vm_entry_failure_code *entry_failure_code)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	struct hv_enlightened_vmcs *evmcs = nested_vmx_evmcs(vmx);
+	struct hv_enlightened_vmcs *evmcs;
 	bool load_guest_pdptrs_vmcs12 = false;
 
 	if (vmx->nested.dirty_vmcs12 || nested_vmx_is_evmptr12_valid(vmx)) {
@@ -2800,7 +2821,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 		vmx->nested.dirty_vmcs12 = false;
 
 		load_guest_pdptrs_vmcs12 = !nested_vmx_is_evmptr12_valid(vmx) ||
-			!(evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1);
+			!(nested_evmcs_clean_fields(vmx)
+			  & HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1);
 	}
 
 	if (vmx->nested.nested_run_pending &&
@@ -2929,7 +2951,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	 * bits when it changes a field in eVMCS. Mark all fields as clean
 	 * here.
 	 */
-	if (nested_vmx_is_evmptr12_valid(vmx))
+	evmcs = nested_vmx_evmcs(vmx);
+	if (evmcs)
 		evmcs->hv_clean_fields |= HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
 
 	return 0;
@@ -3477,7 +3500,7 @@ static bool nested_get_evmcs_page(struct kvm_vcpu *vcpu)
 	if (guest_cpu_cap_has_evmcs(vcpu) &&
 	    vmx->nested.hv_evmcs_vmptr == EVMPTR_MAP_PENDING) {
 		enum nested_evmptrld_status evmptrld_status =
-			nested_vmx_handle_enlightened_vmptrld(vcpu, false);
+			nested_vmx_handle_enlightened_vmptrld(vcpu, false, false);
 
 		if (evmptrld_status == EVMPTRLD_VMFAIL ||
 		    evmptrld_status == EVMPTRLD_ERROR)
@@ -3867,7 +3890,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	evmptrld_status = nested_vmx_handle_enlightened_vmptrld(vcpu, launch);
+	evmptrld_status = nested_vmx_handle_enlightened_vmptrld(vcpu, launch, true);
 	if (evmptrld_status == EVMPTRLD_ERROR) {
 		kvm_queue_exception(vcpu, UD_VECTOR);
 		return 1;
@@ -3893,15 +3916,8 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
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
index 90fdf130fd85..cda96196c56c 100644
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


