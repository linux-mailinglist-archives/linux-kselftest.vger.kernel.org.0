Return-Path: <linux-kselftest+bounces-48064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C85CEEC06
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 15:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ACA130389B7
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 14:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF394313290;
	Fri,  2 Jan 2026 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6lykhMx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA093128AA
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Jan 2026 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767363885; cv=none; b=h7iDzFbJlmLL4wgcchg/9qc8N4yF2A40iU/T0r23XJhu8/Vdhl3jorJ+HEeV8g9ggieXNvO2WBP+J96aZ1arcRifXVfDgurE+I11TpAO01QjuBl7d34o/ACoI0Eef7ef64yNGuXAhMsrBpZKoyJ9ClhRjgqKDca6leASDhEkCvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767363885; c=relaxed/simple;
	bh=TYz8hXTpjMUl1kbWZ/nivIoOSFpumvB1DgqA2JPRFtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBL05A/7P2BjhH1mTy+1TrmpfhT6/Svm7NndP3nVDIfBTiJe/NywrkpfuLRI5H0mBQuQlPiwFNH1DR5UVsa0qdvR4zBKz/oRvNG+ohqjX5+p295nBcpgvPT5FJswCJa744P+Yu8Qf/tmlmekDed+HohZ17vFNqLhjNuPkYCMDDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6lykhMx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4775ae77516so124840365e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 06:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767363880; x=1767968680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYJ+wpeMJD2Ga0Qq6eIDq/h5lx/VjzFN4G2jOTw6Ar8=;
        b=K6lykhMxB6j0p7mFulU5U2MeOeT8+j1ZjlUvu6FPDWF85NhwY4R+yEESfMN+KHmF4P
         XrBabALecCwS2DZ7+af8gRub0FwEVw+D29MNyRbpJE/lQKPupokcSHC2TW87WwRG25eI
         aGv8uyaXlY6EzWtcDxWmzeFB+wj6BEiMX8KdOGdJAtqTudjt4kDWpMXLF5VNpGSDCMCb
         o/FRZO9wkP/vGsT9pYilOzAUN/LDdgD8FtAIA1amKYxpPPRiFFpSdU0nwo8z8K5HTsv8
         NaligUyqyCzngPsgSAaWdhS1AksJ2/ISSZvowHPEFFf0/0ox/u9NAP7Dhr13qbQa4X+Z
         MwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767363880; x=1767968680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oYJ+wpeMJD2Ga0Qq6eIDq/h5lx/VjzFN4G2jOTw6Ar8=;
        b=P3suW0BGnSiyrbyuB6mbCXtBZ7UYEAmBn2MwRphOequDGK2zn0efur8oyMOvX9g2z6
         MRC/diWg2cDEOQUuh1uGTLWP3okiruxinvJlMeHr4g1Mgu0iTV+ZZccQCM1AbRlXTprW
         qKJS+jPXzgfH5HynlZOfOYndngat4fJCqSkGGKmgs6oAhX6PmC66UjIpdk5X98xw3y3e
         iGLx7Dv4CpqX5v2U0hZZqVGVQ+gvGvMLgOBvhZMspSD4+gXlPHb8XjHUSEHg9ya0ArKD
         j7eg8W9o7+Or4ib2O5a+cvLQLlKI/P8+p/IPienWTGVKaKCLO+T9DJtdTV56acX2U4xJ
         I2xA==
X-Forwarded-Encrypted: i=1; AJvYcCV8LkIU0YBREnY+K/EE4sJE12/+usoGFLPrRQwIfBLa07S+FbjackYUxMT5QQsKk++jzLJ1Ymw1iiAc6c8dJTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbAFsho7X1qdNIYKdxumOun+OUOMPOaFl4hB0JNwRZB3bdTPHS
	o0F7H+ZuTZsXKvsKyOZ3UwLbiRQ0LQDH/t3RBAYFHAO8f1TW7b+Qo8ro
X-Gm-Gg: AY/fxX52ThqzCNuGVhK7D35P2FIt15JuFyuSaCN1VMRYrpN43UklFajXIKVBzaF/0c1
	eP2Y5cxcsIrnb8BM07wm7Migxsl/1K3DXYJpjOBJUgViWcyjVPV8gsPaf0b/VrshKBKPdww45Mp
	jVXTBsFKIt4c7ACPOQ8oaACJ0Wnc2VyIP59j0uoZEp9QkODpLpPSGqFIOTLdqBxjj4w8wBpKI/N
	iGjYWC1w5u0av1HTbXn/dIKA8J+OlnOIkeSvOWUfyMPmkIXFxIIdaPQhAWQkltPw3SBoEId2ENj
	wZSw2oXFJJsICL3AeAjWH7bFsUzy1Cx3K8NDovP6tfx55Kabfn17tRN/1LKIdnu4/iCadpR0SFQ
	CoTufDTVq7hTagWSaHgYxIVhWJRam+uoQd6xY46KK6MIaBR8cwzmxUgyLNZQll5Q+KlOOSjvBmP
	0LF5GhsQSklf8R0NrE2mprVU79jcuO7Aavk58bPcHzSAnJdWPT/On/2pAx+C5yXEMDaRuiVJjPL
	90TOlQ8FVy68W+WfQ8l5WwQTK9NPHL8
X-Google-Smtp-Source: AGHT+IGCCfOzLWCpQQxMZ/5nd5y5awvPGxS0A7MzG8xAmk/e5isva12jtAoV0s/5y6inIoe1KJKhyw==
X-Received: by 2002:a05:600c:608e:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-47d1956ec9dmr519761095e9.5.1767363880393;
        Fri, 02 Jan 2026 06:24:40 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm806409235e9.13.2026.01.02.06.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 06:24:39 -0800 (PST)
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
Subject: [PATCH v4 04/10] KVM: nVMX: Implement cache for L1 APIC pages
Date: Fri,  2 Jan 2026 14:24:23 +0000
Message-ID: <20260102142429.896101-5-griffoul@gmail.com>
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

Replace kvm_host_map usage with gfn_to_pfn_cache for L1 APIC
virtualization pages (APIC access, virtual APIC, and posted interrupt
descriptor pages) to improve performance with unmanaged guest memory.

The conversion involves several changes:

- Page loading in nested_get_vmcs12_pages(): load vmcs02 fields with
  pfncache PFNs after each cache has been checked and possibly activated
  or refreshed, during OUTSIDE_GUEST_MODE vCPU mode.

- Invalidation window handling: since nested_get_vmcs12_pages() runs in
  OUTSIDE_GUEST_MODE, there's a window where caches can be invalidated
  by MMU notifications before entering IN_GUEST_MODE. implement
  is_nested_state_invalid() callback to monitor cache validity between
  OUTSIDE_GUEST_MODE and IN_GUEST_MODE transitions. This triggers
  KVM_REQ_GET_NESTED_STATE_PAGES when needed.

- Cache access in event callbacks: the virtual APIC and posted interrupt
  descriptor pages are accessed by KVM in has_events() and
  check_events() nested_ops callbacks. These use the kernel HVA following
  the pfncache pattern of check/refresh, with both callbacks able to sleep
  if cache refresh is required.

This eliminates expensive memremap/memunmap cycles for each L2 VM
entry/exit, providing substantial performance improvements when using
unmanaged memory.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 arch/x86/kvm/vmx/nested.c | 182 +++++++++++++++++++++++++++++---------
 arch/x86/kvm/vmx/vmx.h    |   8 +-
 include/linux/kvm_host.h  |   5 ++
 3 files changed, 150 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a97d02b08ab8..cb4b85edcb7a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -330,8 +330,18 @@ static int nested_gpc_lock(struct gfn_to_pfn_cache *gpc, gpa_t gpa)
 	if (!kvm_gpc_check(gpc, PAGE_SIZE) || (gpc->gpa != gpa)) {
 		read_unlock(&gpc->lock);
 		err = kvm_gpc_activate(gpc, gpa, PAGE_SIZE);
-		if (err)
+		if (err) {
+			/*
+			 * Deactivate nested state caches to prevent
+			 * kvm_gpc_invalid() from returning true in subsequent
+			 * is_nested_state_invalid() calls. This prevents an
+			 * infinite loop while entering guest mode.
+			 */
+			if (gpc->vcpu)
+				kvm_gpc_deactivate(gpc);
+
 			return err;
+		}
 
 		goto retry;
 	}
@@ -344,14 +354,64 @@ static void nested_gpc_unlock(struct gfn_to_pfn_cache *gpc)
 	read_unlock(&gpc->lock);
 }
 
-static void nested_put_vmcs12_pages(struct kvm_vcpu *vcpu)
+static int nested_gpc_hpa(struct gfn_to_pfn_cache *gpc, gpa_t gpa, hpa_t *hpa)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	int err;
+
+	err = nested_gpc_lock(gpc, gpa);
+	if (err)
+		return err;
+
+	*hpa = pfn_to_hpa(gpc->pfn);
+	nested_gpc_unlock(gpc);
+	return 0;
+}
+
+static void *nested_gpc_lock_if_active(struct gfn_to_pfn_cache *gpc)
+{
+	if (!gpc)
+		return NULL;
+retry:
+	read_lock(&gpc->lock);
+	if (!gpc->active) {
+		read_unlock(&gpc->lock);
+		return NULL;
+	}
+
+	if (!kvm_gpc_check(gpc, PAGE_SIZE)) {
+		read_unlock(&gpc->lock);
+		if (kvm_gpc_refresh(gpc, PAGE_SIZE))
+			return NULL;
+		goto retry;
+	}
+
+	return gpc->khva;
+}
+
+static struct pi_desc *nested_lock_pi_desc(struct vcpu_vmx *vmx)
+{
+	u8 *pi_desc_page;
+
+	pi_desc_page = nested_gpc_lock_if_active(vmx->nested.pi_desc_cache);
+	if (!pi_desc_page)
+		return NULL;
+
+	return (struct pi_desc *)(pi_desc_page + vmx->nested.pi_desc_offset);
+}
+
+static void nested_unlock_pi_desc(struct vcpu_vmx *vmx)
+{
+	nested_gpc_unlock(vmx->nested.pi_desc_cache);
+}
+
+static void *nested_lock_vapic(struct vcpu_vmx *vmx)
+{
+	return nested_gpc_lock_if_active(vmx->nested.virtual_apic_cache);
+}
 
-	kvm_vcpu_unmap(vcpu, &vmx->nested.apic_access_page_map);
-	kvm_vcpu_unmap(vcpu, &vmx->nested.virtual_apic_map);
-	kvm_vcpu_unmap(vcpu, &vmx->nested.pi_desc_map);
-	vmx->nested.pi_desc = NULL;
+static void nested_unlock_vapic(struct vcpu_vmx *vmx)
+{
+	nested_gpc_unlock(vmx->nested.virtual_apic_cache);
 }
 
 /*
@@ -374,6 +434,9 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	vmx->nested.smm.vmxon = false;
 	vmx->nested.vmxon_ptr = INVALID_GPA;
 
+	kvm_gpc_deactivate(&vmx->nested.pi_desc_cache);
+	kvm_gpc_deactivate(&vmx->nested.virtual_apic_cache);
+	kvm_gpc_deactivate(&vmx->nested.apic_access_page_cache);
 	kvm_gpc_deactivate(&vmx->nested.msr_bitmap_cache);
 
 	free_vpid(vmx->nested.vpid02);
@@ -390,8 +453,6 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	kfree(vmx->nested.cached_shadow_vmcs12);
 	vmx->nested.cached_shadow_vmcs12 = NULL;
 
-	nested_put_vmcs12_pages(vcpu);
-
 	kvm_mmu_free_roots(vcpu->kvm, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
 
 	nested_release_evmcs(vcpu);
@@ -3112,8 +3173,9 @@ static int nested_vmx_check_controls(struct kvm_vcpu *vcpu,
 static int nested_vmx_check_controls_late(struct kvm_vcpu *vcpu,
 					  struct vmcs12 *vmcs12)
 {
-	void *vapic = to_vmx(vcpu)->nested.virtual_apic_map.hva;
-	u32 vtpr = vapic ? (*(u32 *)(vapic + APIC_TASKPRI)) >> 4 : 0;
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	void *vapic;
+	u32 vtpr = 0;
 
 	/*
 	 * Don't bother with the consistency checks if KVM isn't configured to
@@ -3130,6 +3192,12 @@ static int nested_vmx_check_controls_late(struct kvm_vcpu *vcpu,
 	if (!warn_on_missed_cc)
 		return 0;
 
+	vapic = nested_lock_vapic(vmx);
+	if (vapic) {
+		vtpr = (*(u32 *)(vapic + APIC_TASKPRI)) >> 4;
+		nested_unlock_vapic(vmx);
+	}
+
 	if ((exec_controls_get(to_vmx(vcpu)) & CPU_BASED_TPR_SHADOW) &&
 	    nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW) &&
 	    !nested_cpu_has_vid(vmcs12) &&
@@ -3430,7 +3498,8 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	struct kvm_host_map *map;
+	struct gfn_to_pfn_cache *gpc;
+	hpa_t hpa;
 
 	if (!vcpu->arch.pdptrs_from_userspace &&
 	    !nested_cpu_has_ept(vmcs12) && is_pae_paging(vcpu)) {
@@ -3445,10 +3514,10 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 
 
 	if (nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
-		map = &vmx->nested.apic_access_page_map;
+		gpc = &vmx->nested.apic_access_page_cache;
 
-		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->apic_access_addr), map)) {
-			vmcs_write64(APIC_ACCESS_ADDR, pfn_to_hpa(map->pfn));
+		if (!nested_gpc_hpa(gpc, vmcs12->apic_access_addr, &hpa)) {
+			vmcs_write64(APIC_ACCESS_ADDR, hpa);
 		} else {
 			pr_debug_ratelimited("%s: no backing for APIC-access address in vmcs12\n",
 					     __func__);
@@ -3461,10 +3530,10 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 	}
 
 	if (nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW)) {
-		map = &vmx->nested.virtual_apic_map;
+		gpc = &vmx->nested.virtual_apic_cache;
 
-		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->virtual_apic_page_addr), map)) {
-			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, pfn_to_hpa(map->pfn));
+		if (!nested_gpc_hpa(gpc, vmcs12->virtual_apic_page_addr, &hpa)) {
+			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, hpa);
 		} else if (nested_cpu_has(vmcs12, CPU_BASED_CR8_LOAD_EXITING) &&
 		           nested_cpu_has(vmcs12, CPU_BASED_CR8_STORE_EXITING) &&
 			   !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
@@ -3487,14 +3556,12 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 	}
 
 	if (nested_cpu_has_posted_intr(vmcs12)) {
-		map = &vmx->nested.pi_desc_map;
+		gpc = &vmx->nested.pi_desc_cache;
 
-		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->posted_intr_desc_addr), map)) {
-			vmx->nested.pi_desc =
-				(struct pi_desc *)(((void *)map->hva) +
-				offset_in_page(vmcs12->posted_intr_desc_addr));
+		if (!nested_gpc_hpa(gpc, vmcs12->posted_intr_desc_addr & PAGE_MASK, &hpa)) {
+			vmx->nested.pi_desc_offset = offset_in_page(vmcs12->posted_intr_desc_addr);
 			vmcs_write64(POSTED_INTR_DESC_ADDR,
-				     pfn_to_hpa(map->pfn) + offset_in_page(vmcs12->posted_intr_desc_addr));
+				     hpa + offset_in_page(vmcs12->posted_intr_desc_addr));
 		} else {
 			/*
 			 * Defer the KVM_INTERNAL_EXIT until KVM tries to
@@ -3502,7 +3569,6 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 			 * descriptor. (Note that KVM may do this when it
 			 * should not, per the architectural specification.)
 			 */
-			vmx->nested.pi_desc = NULL;
 			pin_controls_clearbit(vmx, PIN_BASED_POSTED_INTR);
 		}
 	}
@@ -3543,7 +3609,16 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
 
 static bool vmx_is_nested_state_invalid(struct kvm_vcpu *vcpu)
 {
-	return false;
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
+	/*
+	 * @vcpu is in IN_GUEST_MODE, eliminating the need for individual gpc
+	 * locks. Since kvm_gpc_invalid() doesn't verify gpc memslot
+	 * generation, we can also skip acquiring the srcu lock.
+	 */
+	return kvm_gpc_invalid(&vmx->nested.apic_access_page_cache) ||
+		kvm_gpc_invalid(&vmx->nested.virtual_apic_cache) ||
+		kvm_gpc_invalid(&vmx->nested.pi_desc_cache);
 }
 
 static int nested_vmx_write_pml_buffer(struct kvm_vcpu *vcpu, gpa_t gpa)
@@ -4043,6 +4118,7 @@ void nested_mark_vmcs12_pages_dirty(struct kvm_vcpu *vcpu)
 static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct pi_desc *pi_desc;
 	int max_irr;
 	void *vapic_page;
 	u16 status;
@@ -4050,22 +4126,29 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 	if (!vmx->nested.pi_pending)
 		return 0;
 
-	if (!vmx->nested.pi_desc)
+	pi_desc = nested_lock_pi_desc(vmx);
+	if (!pi_desc)
 		goto mmio_needed;
 
 	vmx->nested.pi_pending = false;
 
-	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
+	if (!pi_test_and_clear_on(pi_desc)) {
+		nested_unlock_pi_desc(vmx);
 		return 0;
+	}
 
-	max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
+	max_irr = pi_find_highest_vector(pi_desc);
 	if (max_irr > 0) {
-		vapic_page = vmx->nested.virtual_apic_map.hva;
-		if (!vapic_page)
+		vapic_page = nested_lock_vapic(vmx);
+		if (!vapic_page) {
+			nested_unlock_pi_desc(vmx);
 			goto mmio_needed;
+		}
+
+		__kvm_apic_update_irr(pi_desc->pir, vapic_page, &max_irr);
+
+		nested_unlock_vapic(vmx);
 
-		__kvm_apic_update_irr(vmx->nested.pi_desc->pir,
-			vapic_page, &max_irr);
 		status = vmcs_read16(GUEST_INTR_STATUS);
 		if ((u8)max_irr > ((u8)status & 0xff)) {
 			status &= ~0xff;
@@ -4074,6 +4157,7 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 		}
 	}
 
+	nested_unlock_pi_desc(vmx);
 	nested_mark_vmcs12_pages_dirty(vcpu);
 	return 0;
 
@@ -4193,8 +4277,10 @@ static bool nested_vmx_preemption_timer_pending(struct kvm_vcpu *vcpu)
 static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	void *vapic = vmx->nested.virtual_apic_map.hva;
+	struct pi_desc *pi_desc;
 	int max_irr, vppr;
+	void *vapic;
+	bool res = false;
 
 	if (nested_vmx_preemption_timer_pending(vcpu) ||
 	    vmx->nested.mtf_pending)
@@ -4213,23 +4299,33 @@ static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 	    __vmx_interrupt_blocked(vcpu))
 		return false;
 
+	vapic = nested_lock_vapic(vmx);
 	if (!vapic)
 		return false;
 
 	vppr = *((u32 *)(vapic + APIC_PROCPRI));
 
+	nested_unlock_vapic(vmx);
+
 	max_irr = vmx_get_rvi();
 	if ((max_irr & 0xf0) > (vppr & 0xf0))
 		return true;
 
-	if (vmx->nested.pi_pending && vmx->nested.pi_desc &&
-	    pi_test_on(vmx->nested.pi_desc)) {
-		max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
-		if (max_irr > 0 && (max_irr & 0xf0) > (vppr & 0xf0))
-			return true;
+	if (vmx->nested.pi_pending) {
+		pi_desc = nested_lock_pi_desc(vmx);
+		if (!pi_desc)
+			return false;
+
+		if (pi_test_on(pi_desc)) {
+			max_irr = pi_find_highest_vector(pi_desc);
+			if (max_irr > 0 && (max_irr & 0xf0) > (vppr & 0xf0))
+				res = true;
+		}
+
+		nested_unlock_pi_desc(vmx);
 	}
 
-	return false;
+	return res;
 }
 
 /*
@@ -5194,7 +5290,7 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		vmx_update_cpu_dirty_logging(vcpu);
 	}
 
-	nested_put_vmcs12_pages(vcpu);
+	nested_mark_vmcs12_pages_dirty(vcpu);
 
 	if (vmx->nested.reload_vmcs01_apic_access_page) {
 		vmx->nested.reload_vmcs01_apic_access_page = false;
@@ -5479,6 +5575,10 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 
 	kvm_gpc_init(&vmx->nested.msr_bitmap_cache, vcpu->kvm);
 
+	kvm_gpc_init_for_vcpu(&vmx->nested.apic_access_page_cache, vcpu);
+	kvm_gpc_init_for_vcpu(&vmx->nested.virtual_apic_cache, vcpu);
+	kvm_gpc_init_for_vcpu(&vmx->nested.pi_desc_cache, vcpu);
+
 	vmx->nested.vmcs02_initialized = false;
 	vmx->nested.vmxon = true;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index a6268cddc937..90fdf130fd85 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -158,11 +158,11 @@ struct nested_vmx {
 	 * Guest pages referred to in the vmcs02 with host-physical
 	 * pointers, so we must keep them pinned while L2 runs.
 	 */
-	struct kvm_host_map apic_access_page_map;
-	struct kvm_host_map virtual_apic_map;
-	struct kvm_host_map pi_desc_map;
+	struct gfn_to_pfn_cache apic_access_page_cache;
+	struct gfn_to_pfn_cache virtual_apic_cache;
+	struct gfn_to_pfn_cache pi_desc_cache;
 
-	struct pi_desc *pi_desc;
+	u64 pi_desc_offset;
 	bool pi_pending;
 	u16 posted_intr_nv;
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 04b641d381b0..c0c0dcedb59c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1541,6 +1541,11 @@ static inline bool kvm_gpc_is_hva_active(struct gfn_to_pfn_cache *gpc)
 	return gpc->active && kvm_is_error_gpa(gpc->gpa);
 }
 
+static inline bool kvm_gpc_invalid(struct gfn_to_pfn_cache *gpc)
+{
+	return gpc->active && !gpc->valid;
+}
+
 void kvm_sigset_activate(struct kvm_vcpu *vcpu);
 void kvm_sigset_deactivate(struct kvm_vcpu *vcpu);
 
-- 
2.43.0


