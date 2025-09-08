Return-Path: <linux-kselftest+bounces-41002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C3AB49C3A
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 23:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB623A329D
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 21:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5582ECEB4;
	Mon,  8 Sep 2025 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CBnBVU0O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2063B2EB872;
	Mon,  8 Sep 2025 21:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367225; cv=none; b=YDFGHsRxDswqTS3+KmmYrwKI2rxL9csYOUJQuJEtcwccrMoscaHlRWhhM7e9iLUwFNAOT0EteBnUbiea4L+OCkCFxScJ1L46fBBfdZBeRg1aKQcHuHq33adN6GJxkVOY4pMGjeOH4bIF9HggoBVl1F/hrbOe+fxDfN2Agf/jDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367225; c=relaxed/simple;
	bh=ZyzxJOrXeCBvSkvn4Zaisq4Q66kVSSuiU0l3bqax8/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kH57KPRiYTJaKHpOzM0rq1l2/8wX3Py20GsZ7baaytiUHtq7APWjDVEVfWhyy4dq609eacB9CxRvv9vWlmLlcR+NNOl5nVYSVy+bJ3k4Gj6r1v6Rt+13LUJeQ6kp/CMj/mcF91FQr5itHGUKXzfXb5e6pn8CV9ll376i5C/l5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CBnBVU0O; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xSSCIKHnBwG12TAiPC1gTDS36uFxF6aCGWNSnSCy+HY=; b=CBnBVU0Oras+fwNAhm+aS/6eUD
	a2YGs3uY2H7085Y2Nh/sGOoVnnRmKk7sH20n1CMyYv5+RQJ0xKWbSBDpl4LhxFaTNvdm1nJhUo8f/
	JIWo5AUClXDTBVRismVK9IX2pT0oUknLyuAfXr/jb65ySEjs92FZ+6lyZVwCUOZVSBXohYlI+tG0B
	VfU3k3S1MuH+8gWBhvKn2VdxBwOBWRj98Gu3//Q1px8/AynTy8St4kfVhA1r7od1PCN2favih0rx8
	lMOartX1pLhQotiVvPBYS1qbBmLs2i2pvud5uj8mBQWASjEBkL3P0ie0mnd82oRaxFs2psQggcGOM
	07ei6Pgw==;
Received: from griffoul by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvjUa-0000000DOC3-1sYu;
	Mon, 08 Sep 2025 21:33:40 +0000
From: Fred Griffoul <griffoul@infradead.org>
To: kvm@vger.kernel.org
Cc: griffoul@gmail.com,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 4/5] KVM: nVMX: Implement cache for L1 APIC pages
Date: Mon,  8 Sep 2025 22:32:29 +0100
Message-ID: <20250908213241.3189113-5-griffoul@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908213241.3189113-1-griffoul@infradead.org>
References: <20250908213241.3189113-1-griffoul@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

Replace kvm_host_map usage with persistent gfn_to_pfn_cache for L1 APIC
virtualization pages (APIC access, virtual APIC, and posted interrupt
descriptor pages) to improve performance with unmanaged guest memory.

The conversion involves several key changes:

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
unmanaged memory such as guest_memfd or memory passed with mem= kernel
parameter.

The persistent caching approach maintains correctness through proper
invalidation detection while avoiding the overhead of repeated mapping
operations.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 arch/x86/kvm/vmx/nested.c | 169 +++++++++++++++++++++++++++++---------
 arch/x86/kvm/vmx/vmx.h    |   8 +-
 include/linux/kvm_host.h  |   5 ++
 3 files changed, 139 insertions(+), 43 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 06187b8baa19..0cb66314d58b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -329,8 +329,18 @@ static int nested_gpc_lock(struct gfn_to_pfn_cache *gpc, gpa_t gpa)
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
@@ -343,14 +353,17 @@ static void nested_gpc_unlock(struct gfn_to_pfn_cache *gpc)
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
 
-	kvm_vcpu_unmap(vcpu, &vmx->nested.apic_access_page_map);
-	kvm_vcpu_unmap(vcpu, &vmx->nested.virtual_apic_map);
-	kvm_vcpu_unmap(vcpu, &vmx->nested.pi_desc_map);
-	vmx->nested.pi_desc = NULL;
+	*hpa = pfn_to_hpa(gpc->pfn);
+	nested_gpc_unlock(gpc);
+	return 0;
 }
 
 /*
@@ -373,6 +386,9 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	vmx->nested.smm.vmxon = false;
 	vmx->nested.vmxon_ptr = INVALID_GPA;
 
+	kvm_gpc_deactivate(&vmx->nested.pi_desc_cache);
+	kvm_gpc_deactivate(&vmx->nested.virtual_apic_cache);
+	kvm_gpc_deactivate(&vmx->nested.apic_access_page_cache);
 	kvm_gpc_deactivate(&vmx->nested.msr_bitmap_cache);
 
 	free_vpid(vmx->nested.vpid02);
@@ -389,8 +405,6 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	kfree(vmx->nested.cached_shadow_vmcs12);
 	vmx->nested.cached_shadow_vmcs12 = NULL;
 
-	nested_put_vmcs12_pages(vcpu);
-
 	kvm_mmu_free_roots(vcpu->kvm, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
 
 	nested_release_evmcs(vcpu);
@@ -3361,7 +3375,8 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	struct kvm_host_map *map;
+	struct gfn_to_pfn_cache *gpc;
+	hpa_t hpa;
 
 	if (!vcpu->arch.pdptrs_from_userspace &&
 	    !nested_cpu_has_ept(vmcs12) && is_pae_paging(vcpu)) {
@@ -3376,10 +3391,10 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 
 
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
@@ -3392,10 +3407,10 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
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
@@ -3418,14 +3433,12 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
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
@@ -3433,7 +3446,6 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 			 * descriptor. (Note that KVM may do this when it
 			 * should not, per the architectural specification.)
 			 */
-			vmx->nested.pi_desc = NULL;
 			pin_controls_clearbit(vmx, PIN_BASED_POSTED_INTR);
 		}
 	}
@@ -3474,7 +3486,16 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
 
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
@@ -3969,9 +3990,55 @@ void nested_mark_vmcs12_pages_dirty(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void *nested_gpc_lock_if_active(struct gfn_to_pfn_cache *gpc)
+{
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
+	pi_desc_page = nested_gpc_lock_if_active(&vmx->nested.pi_desc_cache);
+	if (!pi_desc_page)
+		return NULL;
+
+	return (struct pi_desc *)(pi_desc_page + vmx->nested.pi_desc_offset);
+}
+
+static void nested_unlock_pi_desc(struct vcpu_vmx *vmx)
+{
+	nested_gpc_unlock(&vmx->nested.pi_desc_cache);
+}
+
+static void *nested_lock_vapic(struct vcpu_vmx *vmx)
+{
+	return nested_gpc_lock_if_active(&vmx->nested.virtual_apic_cache);
+}
+
+static void nested_unlock_vapic(struct vcpu_vmx *vmx)
+{
+	nested_gpc_unlock(&vmx->nested.virtual_apic_cache);
+}
+
 static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct pi_desc *pi_desc;
 	int max_irr;
 	void *vapic_page;
 	u16 status;
@@ -3979,22 +4046,29 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
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
@@ -4003,6 +4077,7 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 		}
 	}
 
+	nested_unlock_pi_desc(vmx);
 	nested_mark_vmcs12_pages_dirty(vcpu);
 	return 0;
 
@@ -4122,8 +4197,10 @@ static bool nested_vmx_preemption_timer_pending(struct kvm_vcpu *vcpu)
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
@@ -4142,23 +4219,33 @@ static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
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
@@ -5106,7 +5193,7 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		vmx_update_cpu_dirty_logging(vcpu);
 	}
 
-	nested_put_vmcs12_pages(vcpu);
+	nested_mark_vmcs12_pages_dirty(vcpu);
 
 	if (vmx->nested.reload_vmcs01_apic_access_page) {
 		vmx->nested.reload_vmcs01_apic_access_page = false;
@@ -5391,6 +5478,10 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 
 	kvm_gpc_init(&vmx->nested.msr_bitmap_cache, vcpu->kvm);
 
+	kvm_gpc_init_for_vcpu(&vmx->nested.apic_access_page_cache, vcpu);
+	kvm_gpc_init_for_vcpu(&vmx->nested.virtual_apic_cache, vcpu);
+	kvm_gpc_init_for_vcpu(&vmx->nested.pi_desc_cache, vcpu);
+
 	vmx->nested.vmcs02_initialized = false;
 	vmx->nested.vmxon = true;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 3a6983222841..2c74c65d3383 100644
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
index 2eb551a11818..dc622adb561f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1526,6 +1526,11 @@ static inline bool kvm_gpc_is_hva_active(struct gfn_to_pfn_cache *gpc)
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
2.51.0


