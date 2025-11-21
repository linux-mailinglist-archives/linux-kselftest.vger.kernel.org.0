Return-Path: <linux-kselftest+bounces-46213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36058C78B1B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E1D7A2D903
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 11:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FC334B1B4;
	Fri, 21 Nov 2025 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iApafypM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEA634889C
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723494; cv=none; b=rogcJRSxrNqaG0+62HVO+8lcCPVoiZ6k549CJLQHeU4Rsb/rfEtHmJkYBB1XLj1W7PZRvegmnTsfjj5MjbcB2FssMqUaFvYJEyF3cMkjrtwpoeGOzB08P1huzsDZMNEP52SUzPbl/N/4yT4BnU+JxNAoTElSNlpUKgIYO/LB8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723494; c=relaxed/simple;
	bh=HrafMklrqoTEF4Rn4QhVKLuftPBVxnPN6Lx5eLic2JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UstX1W19QyqqL08I/G4Yo5a7De+do+E1JS6XUOJICGTeVcgs1vR6Zqc8sBWhyUg50dn4JyVzWnxNyBnXdULwO8+N2IxHWyDY/deGzuwCaKjWDbYw4LNlSuaFPWdiCovAsau0Q7FM9lAL6FYL74eVJ35sXvvmMbCkWjZ7GPcjTqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iApafypM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4775895d69cso8276185e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 03:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763723489; x=1764328289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/xIHpiQQ/Lo5XB08/US8R5a2GUT8/PzNY3ETA2TAw0=;
        b=iApafypMo/20VGVXEPaMgfh9k8/m0Ks2U7VPZmjS7LIfvTcwEu5trpjAvOSPhoDD77
         35qFJxMRxGwkb0FCKLQjbaFL5vshARQ+djFbIl1bEJCSM1tMRlCHjbZXsGSWWl9OxIpU
         EhvLlCRST7qzszHZ5FDbo/C5NhiEcVMr2vNM7C8kW+5BWyVAgIg8VY3JCV4XbIxhRYpO
         3yTrs/RZIqJI65EeAsuGerfMBS7MlBlAkvhsItEVgI23SOxbv7S6eRWpOYhWr2VhAKWR
         0bIhqzryTNIDGAF9pKujnl7VGcHRbBkbC2Y/kznD7DxsMOHWOgwMGYA2xCpdfbJfRaEW
         WyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763723489; x=1764328289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q/xIHpiQQ/Lo5XB08/US8R5a2GUT8/PzNY3ETA2TAw0=;
        b=H1fPp4dfpw1A6WMJ98lmD0WxLyNFq0qoYpt1BR68plfPXNdTNq0Jvc3AwODPMXSE1z
         Ncp6TRq19zeLSNpDLyiyF0loNffEcj4vL3YFXvskG4uCJQo0YNyKqrwdzye5IpXTEoTt
         X8n8+N8O5TYMi2EZOImCA0SaMa16qddsJ/p2wCNxLdnkhWc/9NZ8yhMDh6mJVdb98Vhn
         RwvUCIaxxD70PUHNTZK/LQsf5HEu7DkXTvu5sUGgn/oKQ1j6afgFVH/p4VBW2HT/VcY4
         r971d90MdEWMngQC9n6tTQwbdnp70j2HqRVkXeEPAjAft8ey6kxGTS6lFXJhoxV2RVFA
         B5dA==
X-Forwarded-Encrypted: i=1; AJvYcCWXTKvMcrH5SwH3SjGrbBUEaTJl4hBf7hYdO1Df1xBQFaoX6HGSpppxJWj8XPNlFy3aDczF+1xDVFK4UUlTydA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9lu6YQAcvIEZyMdy4Cd4yJBkcQQzUBrjlOpKf08lq/KjVIYwx
	kkpDQG6yw/MlGuR4vJdZWqjGpbghHA+3PY4nRl8B+S0S9f2FkDoOt/uR
X-Gm-Gg: ASbGncv1VvVUnl42OB3TtQWfkq2NCq0/geZkpELgubEMBIdoIo0CTgf4x8zTSri9VK2
	rzghGRkQjshlMW9FcLstzdqcG7+M5yXvRGF/YIT0Rn/yNbun8SAgYMGtir5JdZkYO1YZBxre2ui
	uA/wj3fHUJY0OuKoqn9eihbkKShYGDneg4A1RWCeX1kv0BgL/racTYosQ3Y2iMrBl+uBOIXiytg
	808Kh/tGRzoi61VZfjYl9NIrP8kmmmEGNXQoNz+wKvqbG6nEU4wszphlsbuNXemspkW5M4tgGQT
	RdFqYOHbK70mYORgp7YcC/o1UKpxzXJ5z0vYTHOdYpluB3YvSXkalxaSsSdIamUxD4cSYbV1oZ+
	nT9ppBvgDCsss1fuC2z5ZXkybYB88+uWho4xvDJ5EbP5pZJsNi3QHXTVYHJuOt9VLs3vkL7fn0R
	eNb9As2hQx7L3ZHDBhp+epIVDlqVGgLqnyZO/X/9miMJdLbyGEjp2ySlTUPHLSP5r2zY82gOr4A
	UAVfYWDCN0lIb6TdF/IvajkEKIU8Rc4C7khIoG1T54=
X-Google-Smtp-Source: AGHT+IH7H4FBA7WjAQ3UUabqbpl85RgzYy0DRe3lSwmH152nPHYQoDzfP63UrssZaXr+/XP+NNReLg==
X-Received: by 2002:a05:600c:470e:b0:477:79f8:da9d with SMTP id 5b1f17b1804b1-477c01e9dbemr23954225e9.24.1763723488520;
        Fri, 21 Nov 2025 03:11:28 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363e4sm10484180f8f.12.2025.11.21.03.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:11:28 -0800 (PST)
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
Subject: [PATCH v3 04/10] KVM: nVMX: Implement cache for L1 APIC pages
Date: Fri, 21 Nov 2025 11:11:07 +0000
Message-ID: <20251121111113.456628-5-griffoul@gmail.com>
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
 arch/x86/kvm/vmx/nested.c | 169 +++++++++++++++++++++++++++++---------
 arch/x86/kvm/vmx/vmx.h    |   8 +-
 include/linux/kvm_host.h  |   5 ++
 3 files changed, 139 insertions(+), 43 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 627a6c24625d..1f58b380585b 100644
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
@@ -3477,7 +3491,8 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	struct kvm_host_map *map;
+	struct gfn_to_pfn_cache *gpc;
+	hpa_t hpa;
 
 	if (!vcpu->arch.pdptrs_from_userspace &&
 	    !nested_cpu_has_ept(vmcs12) && is_pae_paging(vcpu)) {
@@ -3492,10 +3507,10 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 
 
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
@@ -3508,10 +3523,10 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
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
@@ -3534,14 +3549,12 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
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
@@ -3549,7 +3562,6 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 			 * descriptor. (Note that KVM may do this when it
 			 * should not, per the architectural specification.)
 			 */
-			vmx->nested.pi_desc = NULL;
 			pin_controls_clearbit(vmx, PIN_BASED_POSTED_INTR);
 		}
 	}
@@ -3590,7 +3602,16 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
 
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
@@ -4091,9 +4112,55 @@ void nested_mark_vmcs12_pages_dirty(struct kvm_vcpu *vcpu)
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
@@ -4101,22 +4168,29 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
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
@@ -4125,6 +4199,7 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 		}
 	}
 
+	nested_unlock_pi_desc(vmx);
 	nested_mark_vmcs12_pages_dirty(vcpu);
 	return 0;
 
@@ -4244,8 +4319,10 @@ static bool nested_vmx_preemption_timer_pending(struct kvm_vcpu *vcpu)
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
@@ -4264,23 +4341,33 @@ static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
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
@@ -5244,7 +5331,7 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		vmx_update_cpu_dirty_logging(vcpu);
 	}
 
-	nested_put_vmcs12_pages(vcpu);
+	nested_mark_vmcs12_pages_dirty(vcpu);
 
 	if (vmx->nested.reload_vmcs01_apic_access_page) {
 		vmx->nested.reload_vmcs01_apic_access_page = false;
@@ -5529,6 +5616,10 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 
 	kvm_gpc_init(&vmx->nested.msr_bitmap_cache, vcpu->kvm);
 
+	kvm_gpc_init_for_vcpu(&vmx->nested.apic_access_page_cache, vcpu);
+	kvm_gpc_init_for_vcpu(&vmx->nested.virtual_apic_cache, vcpu);
+	kvm_gpc_init_for_vcpu(&vmx->nested.pi_desc_cache, vcpu);
+
 	vmx->nested.vmcs02_initialized = false;
 	vmx->nested.vmxon = true;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index d76621403c28..9a285834ccda 100644
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
index 6253cf1c38c1..b05aace9e295 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1531,6 +1531,11 @@ static inline bool kvm_gpc_is_hva_active(struct gfn_to_pfn_cache *gpc)
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


