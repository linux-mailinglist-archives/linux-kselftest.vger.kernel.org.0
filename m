Return-Path: <linux-kselftest+bounces-46218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6628FC78B39
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 115102D85E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 11:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8660333B963;
	Fri, 21 Nov 2025 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcrMfjw1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2A534BA59
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723502; cv=none; b=XagQcQjsg9ixYK3mqEaXqNxQEKYXkot9xCGxEptswmVeHgX+Fhkp4igc5qaX8pJVytkVrRdDE13UbfP6s6QomIyD+OsgdCayZ9KOoXnAKEEGFdbIM+zKjFW56jrdqB0sL5xqPwqp10JlhbNAjvDq/FPsLmGxLAKVYOCXFvhT2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723502; c=relaxed/simple;
	bh=Dm+BEBrm/Ll97dS33rHM/QTSbCa8yrcmrrSYYLlbkL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDViSWxDfLhDBEKY2loj48lYei/gzGtOb7+8E6toGdaw6B6NgX9GsJvT3dThtygWxrSTJAYUvLCGlG8Gyv5Mx4gX6mcMkQykbZDZd4win+tRWJN3SqnYkBUhXK1ctBGGtLcViiSHjBf0LI3lHhEkZuQP8rxtD2XRX7GjJC7Ggvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcrMfjw1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429c4c65485so1551784f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 03:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763723496; x=1764328296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOXJSf/3ZicK6X9zkJJPFnaHL2wXDXQgFML1HXxSOA0=;
        b=CcrMfjw1T1ztlzc3LgAZjU0G1IDWW8sYXTTWQRIseKGjatAlS7ZMqZJdso9w34eGJS
         kv4paceZvgX3iE20Y2dvUFjyl3TiXYNPE2LBqgJsUnF9XyV5VX5GkyxGB0GnjAdmO5jt
         tcaodewIB3tJtukjc1cP2GnDtbBQwLtCchI/roiKEfHW52giBkSftCF4ETE9tLF/HyCA
         5KCRwJ6wVNYQmE99+SGP44G/D4gRsXBWEltFiz3r1ot1Hd6/66di7JcBOBgCQJgLCbVI
         ZfHaxWGYI9SsdcNCeDfTjHq1P/U5CTnvMPfj20PVLOegPmKefa+kYdUrvgTfE8zRWRlj
         CPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763723496; x=1764328296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VOXJSf/3ZicK6X9zkJJPFnaHL2wXDXQgFML1HXxSOA0=;
        b=gs4ZPVZtynMMPByTZ5guEy29CKTrz8bz9ZtCnQcIjyt3ohFafMWK/QLrNjt0QPhWTy
         j1l0y8Lboyh1S2Qkx5lZC2Mc5YpaPoG0zdVA+MwCnBvXgxc4qixkPcSWsrxeMwepBdW/
         Q4mvsrrgLI0bARYx43JWnBd7GWBPhDWZMCw0v1aT8Sfyk2tSVDH/SPop3L7ledHILLOz
         LuBeFBXf4XxHFY/CRMLl/3tyQkysjBoPAZ4Dwtex2DqmacsPBj6yihH4ZJf60sgrFkls
         gFL2sRteHdaeFFDOv2WNFb/s9iA7VijlGYUTqihrqmHdVwoR9/x3hHhdMfbXjZqc0haV
         DfGA==
X-Forwarded-Encrypted: i=1; AJvYcCUwDl4E5YID8Y2a2sQedTt19hxKKiF4FyxkroCoFF4xyuo3RUwuGBp8fQjPeSFxX8N2inbw4Z2Rdjpg8+DVkaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxkt5MINLMByXMgHwSAC8Y7R0gDicWCAdorh2+e0OCfLtU1TIy
	WYmbpEOCLTU0VGPrR+gxGN0l4RxTVGUMePXH0iNRNsOFdO1oMHT124Ys
X-Gm-Gg: ASbGnctH3i1nYJzna0F6sZgoGkmHRsqf/f4vSoGa+L8UF3DxRnYcgH46Mm+hy67/mhl
	WnUK/Wt6/HChCDGRCjkBZuVpWAavu6o/HmzNX1iEQxD1BYUKqOnntdURgEHacIq3qXOnrMJHh7l
	ltQ5HtbZAgafJFAlat3q7KS4fTa0TgCOKkaSj4S2DLHnxsYITq7i/O9q/+OgGuUON8++Gjn4Nj2
	Ic7x0cRspA2e5hJodMKnQnIM077d0fGr4uRcM8Labfrel0Te3yIyao6jpEIRbpV3UyhsQt/tMxj
	S+fz957SkMdIVmYsmyrKslK4wyY2K/UagagC5uK2lFUd0tCVtiBMIOCJRqw0OGU9nAP+anJDyLA
	R713+FwYDQpdFFGSuP4m1ekrYDQSXTf1ipOOyOz1zrl6+f9177LHV3dXehkS8dIyQE643FDoowW
	v4M01IVF3tbPZb2JUR5RNzbMm+4e3XXGWz5I0q1samAxihmTsBWdge0pGaaY/5PTjFKVFZn3+a9
	BpX5E/8OpgXk3MJjCybbqL+zdGY6v4l31g9E3MEcKU=
X-Google-Smtp-Source: AGHT+IEIAoneRkmmi+OfaqjE525Aae3+kzixRpE0ECciHfimaKXtH3N4PTs7XwRIiOOi7OKuLNVHKg==
X-Received: by 2002:a05:6000:2084:b0:42b:3b62:cd9b with SMTP id ffacd0b85a97d-42cc1d2d52amr1935469f8f.37.1763723496404;
        Fri, 21 Nov 2025 03:11:36 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363e4sm10484180f8f.12.2025.11.21.03.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:11:36 -0800 (PST)
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
Subject: [PATCH v3 09/10] KVM: nVMX: Use nested context for pfncache persistence
Date: Fri, 21 Nov 2025 11:11:12 +0000
Message-ID: <20251121111113.456628-10-griffoul@gmail.com>
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

Extend the nested context infrastructure to preserve gfn_to_pfn_cache
objects for nested VMX using kvm_nested_context_load() and
kvm_nested_context_clear() functions.

The VMX nested context stores gfn_to_pfn_cache structs for:
- MSR permission bitmaps
- APIC access page
- Virtual APIC page
- Posted interrupt descriptor
- Enlightened VMCS

For traditional nested VMX, those pfn caches are loaded upon 'vmptrld'
instruction emulation and the context is cleared upon 'vmclear'. This
follows the normal L2 vCPU migration sequence of
'vmclear/vmptrld/vmlaunch'.

For enlightened VMCS (eVMCS) support, both functions are called when
detecting a change in the eVMCS GPA, ensuring proper context management
for Hyper-V nested scenarios.

By preserving the gfn_to_pfn_cache objects across L2 context switches,
we avoid costly cache refresh operations, significantly improving nested
virtualization performance for workloads with frequent L2 vCPU
multiplexing on an L1 vCPU or L2 vCPUs migrations between L1 vCPUs.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 arch/x86/kvm/vmx/nested.c | 155 +++++++++++++++++++++++++++++---------
 arch/x86/kvm/vmx/vmx.c    |   8 ++
 arch/x86/kvm/vmx/vmx.h    |  10 +--
 include/linux/kvm_host.h  |   2 +-
 4 files changed, 134 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 207780ef0926..bd600de29031 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -226,6 +226,93 @@ static void vmx_disable_shadow_vmcs(struct vcpu_vmx *vmx)
 	vmx->nested.need_vmcs12_to_shadow_sync = false;
 }
 
+struct vmx_nested_context {
+	struct kvm_nested_context base;
+	struct gfn_to_pfn_cache msr_bitmap_cache;
+	struct gfn_to_pfn_cache apic_access_page_cache;
+	struct gfn_to_pfn_cache virtual_apic_cache;
+	struct gfn_to_pfn_cache pi_desc_cache;
+#ifdef CONFIG_KVM_HYPERV
+	struct gfn_to_pfn_cache evmcs_cache;
+#endif
+};
+
+static inline struct vmx_nested_context *to_vmx_nested_context(
+		struct kvm_nested_context *base)
+{
+	return base ? container_of(base, struct vmx_nested_context, base) : NULL;
+}
+
+static struct kvm_nested_context *vmx_nested_context_alloc(struct kvm_vcpu *vcpu)
+{
+	struct vmx_nested_context *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
+	if (!ctx)
+		return NULL;
+
+	kvm_gpc_init(&ctx->msr_bitmap_cache, vcpu->kvm);
+	kvm_gpc_init_for_vcpu(&ctx->apic_access_page_cache, vcpu);
+	kvm_gpc_init_for_vcpu(&ctx->virtual_apic_cache, vcpu);
+	kvm_gpc_init_for_vcpu(&ctx->pi_desc_cache, vcpu);
+#ifdef CONFIG_KVM_HYPERV
+	kvm_gpc_init(&ctx->evmcs_cache, vcpu->kvm);
+#endif
+	return &ctx->base;
+}
+
+static void vmx_nested_context_reset(struct kvm_nested_context *base)
+{
+	/*
+	 * Skip pfncache reinitialization: active ones will be refreshed on
+	 * access.
+	 */
+}
+
+static void vmx_nested_context_free(struct kvm_nested_context *base)
+{
+	struct vmx_nested_context *ctx = to_vmx_nested_context(base);
+
+	kvm_gpc_deactivate(&ctx->pi_desc_cache);
+	kvm_gpc_deactivate(&ctx->virtual_apic_cache);
+	kvm_gpc_deactivate(&ctx->apic_access_page_cache);
+	kvm_gpc_deactivate(&ctx->msr_bitmap_cache);
+#ifdef CONFIG_KVM_HYPERV
+	kvm_gpc_deactivate(&ctx->evmcs_cache);
+#endif
+	kfree(ctx);
+}
+
+static void vmx_nested_context_load(struct vcpu_vmx *vmx, gpa_t vmptr)
+{
+	struct vmx_nested_context *ctx;
+
+	ctx = to_vmx_nested_context(kvm_nested_context_load(&vmx->vcpu, vmptr));
+	if (!ctx) {
+		/*
+		 * The cache could not be allocated. In the unlikely case of no
+		 * available memory, an error will be returned to L1 when
+		 * mapping the vmcs12 pages. More likely the current pfncaches
+		 * will be reused (and refreshed since their GPAs do not
+		 * match).
+		 */
+		return;
+	}
+
+	vmx->nested.msr_bitmap_cache = &ctx->msr_bitmap_cache;
+	vmx->nested.apic_access_page_cache = &ctx->apic_access_page_cache;
+	vmx->nested.virtual_apic_cache = &ctx->virtual_apic_cache;
+	vmx->nested.pi_desc_cache = &ctx->pi_desc_cache;
+#ifdef CONFIG_KVM_HYPERV
+	vmx->nested.hv_evmcs_cache = &ctx->evmcs_cache;
+#endif
+}
+
+static void vmx_nested_context_clear(struct vcpu_vmx *vmx, gpa_t vmptr)
+{
+	kvm_nested_context_clear(&vmx->vcpu, vmptr);
+}
+
 static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_KVM_HYPERV
@@ -325,6 +412,9 @@ static int nested_gpc_lock(struct gfn_to_pfn_cache *gpc, gpa_t gpa)
 
 	if (!PAGE_ALIGNED(gpa))
 		return -EINVAL;
+
+	if (WARN_ON_ONCE(!gpc))
+		return -ENOENT;
 retry:
 	read_lock(&gpc->lock);
 	if (!kvm_gpc_check(gpc, PAGE_SIZE) || (gpc->gpa != gpa)) {
@@ -387,14 +477,6 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	vmx->nested.smm.vmxon = false;
 	vmx->nested.vmxon_ptr = INVALID_GPA;
 
-	kvm_gpc_deactivate(&vmx->nested.pi_desc_cache);
-	kvm_gpc_deactivate(&vmx->nested.virtual_apic_cache);
-	kvm_gpc_deactivate(&vmx->nested.apic_access_page_cache);
-	kvm_gpc_deactivate(&vmx->nested.msr_bitmap_cache);
-#ifdef CONFIG_KVM_HYPERV
-	kvm_gpc_deactivate(&vmx->nested.hv_evmcs_cache);
-#endif
-
 	free_vpid(vmx->nested.vpid02);
 	vmx->nested.posted_intr_nv = -1;
 	vmx->nested.current_vmptr = INVALID_GPA;
@@ -697,7 +779,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 			return true;
 	}
 
-	gpc = &vmx->nested.msr_bitmap_cache;
+	gpc = vmx->nested.msr_bitmap_cache;
 	if (nested_gpc_lock(gpc, vmcs12->msr_bitmap))
 		return false;
 
@@ -2186,7 +2268,13 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
 		return EVMPTRLD_DISABLED;
 	}
 
-	gpc = &vmx->nested.hv_evmcs_cache;
+	if (evmcs_gpa != vmx->nested.hv_evmcs_vmptr) {
+		vmx_nested_context_clear(vmx, vmx->nested.hv_evmcs_vmptr);
+		vmx_nested_context_load(vmx, evmcs_gpa);
+		evmcs_gpa_changed = true;
+	}
+
+	gpc = vmx->nested.hv_evmcs_cache;
 	if (nested_gpc_lock(gpc, evmcs_gpa)) {
 		nested_release_evmcs(vcpu);
 		return EVMPTRLD_ERROR;
@@ -2194,9 +2282,8 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
 
 	evmcs = gpc->khva;
 
-	if (unlikely(evmcs_gpa != vmx->nested.hv_evmcs_vmptr)) {
+	if (evmcs_gpa_changed) {
 		vmx->nested.current_vmptr = INVALID_GPA;
-
 		nested_release_evmcs(vcpu);
 
 		/*
@@ -2230,7 +2317,6 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
 
 		vmx->nested.hv_evmcs_vmptr = evmcs_gpa;
 
-		evmcs_gpa_changed = true;
 		/*
 		 * Unlike normal vmcs12, enlightened vmcs12 is not fully
 		 * reloaded from guest's memory (read only fields, fields not
@@ -3538,7 +3624,7 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 
 
 	if (nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
-		gpc = &vmx->nested.apic_access_page_cache;
+		gpc = vmx->nested.apic_access_page_cache;
 
 		if (!nested_gpc_hpa(gpc, vmcs12->apic_access_addr, &hpa)) {
 			vmcs_write64(APIC_ACCESS_ADDR, hpa);
@@ -3554,7 +3640,7 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 	}
 
 	if (nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW)) {
-		gpc = &vmx->nested.virtual_apic_cache;
+		gpc = vmx->nested.virtual_apic_cache;
 
 		if (!nested_gpc_hpa(gpc, vmcs12->virtual_apic_page_addr, &hpa)) {
 			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, hpa);
@@ -3580,7 +3666,7 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 	}
 
 	if (nested_cpu_has_posted_intr(vmcs12)) {
-		gpc = &vmx->nested.pi_desc_cache;
+		gpc = vmx->nested.pi_desc_cache;
 
 		if (!nested_gpc_hpa(gpc, vmcs12->posted_intr_desc_addr & PAGE_MASK, &hpa)) {
 			vmx->nested.pi_desc_offset = offset_in_page(vmcs12->posted_intr_desc_addr);
@@ -3640,9 +3726,9 @@ static bool vmx_is_nested_state_invalid(struct kvm_vcpu *vcpu)
 	 * locks. Since kvm_gpc_invalid() doesn't verify gpc memslot
 	 * generation, we can also skip acquiring the srcu lock.
 	 */
-	return kvm_gpc_invalid(&vmx->nested.apic_access_page_cache) ||
-		kvm_gpc_invalid(&vmx->nested.virtual_apic_cache) ||
-		kvm_gpc_invalid(&vmx->nested.pi_desc_cache);
+	return kvm_gpc_invalid(vmx->nested.apic_access_page_cache) ||
+		kvm_gpc_invalid(vmx->nested.virtual_apic_cache) ||
+		kvm_gpc_invalid(vmx->nested.pi_desc_cache);
 }
 
 static int nested_vmx_write_pml_buffer(struct kvm_vcpu *vcpu, gpa_t gpa)
@@ -4138,6 +4224,8 @@ void nested_mark_vmcs12_pages_dirty(struct kvm_vcpu *vcpu)
 
 static void *nested_gpc_lock_if_active(struct gfn_to_pfn_cache *gpc)
 {
+	if (!gpc)
+		return NULL;
 retry:
 	read_lock(&gpc->lock);
 	if (!gpc->active) {
@@ -4158,12 +4246,12 @@ static void *nested_gpc_lock_if_active(struct gfn_to_pfn_cache *gpc)
 #ifdef CONFIG_KVM_HYPERV
 struct hv_enlightened_vmcs *nested_lock_evmcs(struct vcpu_vmx *vmx)
 {
-	return nested_gpc_lock_if_active(&vmx->nested.hv_evmcs_cache);
+	return nested_gpc_lock_if_active(vmx->nested.hv_evmcs_cache);
 }
 
 void nested_unlock_evmcs(struct vcpu_vmx *vmx)
 {
-	nested_gpc_unlock(&vmx->nested.hv_evmcs_cache);
+	nested_gpc_unlock(vmx->nested.hv_evmcs_cache);
 }
 #endif
 
@@ -4171,7 +4259,7 @@ static struct pi_desc *nested_lock_pi_desc(struct vcpu_vmx *vmx)
 {
 	u8 *pi_desc_page;
 
-	pi_desc_page = nested_gpc_lock_if_active(&vmx->nested.pi_desc_cache);
+	pi_desc_page = nested_gpc_lock_if_active(vmx->nested.pi_desc_cache);
 	if (!pi_desc_page)
 		return NULL;
 
@@ -4180,17 +4268,17 @@ static struct pi_desc *nested_lock_pi_desc(struct vcpu_vmx *vmx)
 
 static void nested_unlock_pi_desc(struct vcpu_vmx *vmx)
 {
-	nested_gpc_unlock(&vmx->nested.pi_desc_cache);
+	nested_gpc_unlock(vmx->nested.pi_desc_cache);
 }
 
 static void *nested_lock_vapic(struct vcpu_vmx *vmx)
 {
-	return nested_gpc_lock_if_active(&vmx->nested.virtual_apic_cache);
+	return nested_gpc_lock_if_active(vmx->nested.virtual_apic_cache);
 }
 
 static void nested_unlock_vapic(struct vcpu_vmx *vmx)
 {
-	nested_gpc_unlock(&vmx->nested.virtual_apic_cache);
+	nested_gpc_unlock(vmx->nested.virtual_apic_cache);
 }
 
 static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
@@ -5649,16 +5737,6 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 		      HRTIMER_MODE_ABS_PINNED);
 
 	vmx->nested.vpid02 = allocate_vpid();
-
-	kvm_gpc_init(&vmx->nested.msr_bitmap_cache, vcpu->kvm);
-
-	kvm_gpc_init_for_vcpu(&vmx->nested.apic_access_page_cache, vcpu);
-	kvm_gpc_init_for_vcpu(&vmx->nested.virtual_apic_cache, vcpu);
-	kvm_gpc_init_for_vcpu(&vmx->nested.pi_desc_cache, vcpu);
-
-#ifdef CONFIG_KVM_HYPERV
-	kvm_gpc_init(&vmx->nested.hv_evmcs_cache, vcpu->kvm);
-#endif
 	vmx->nested.vmcs02_initialized = false;
 	vmx->nested.vmxon = true;
 
@@ -5854,6 +5932,8 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
 					   &zero, sizeof(zero));
 	}
 
+	vmx_nested_context_clear(vmx, vmptr);
+
 	return nested_vmx_succeed(vcpu);
 }
 
@@ -6098,6 +6178,8 @@ static void set_current_vmptr(struct vcpu_vmx *vmx, gpa_t vmptr)
 	}
 	vmx->nested.dirty_vmcs12 = true;
 	vmx->nested.force_msr_bitmap_recalc = true;
+
+	vmx_nested_context_load(vmx, vmptr);
 }
 
 /* Emulate the VMPTRLD instruction */
@@ -7687,4 +7769,7 @@ struct kvm_x86_nested_ops vmx_nested_ops = {
 	.get_evmcs_version = nested_get_evmcs_version,
 	.hv_inject_synthetic_vmexit_post_tlb_flush = vmx_hv_inject_synthetic_vmexit_post_tlb_flush,
 #endif
+	.alloc_context = vmx_nested_context_alloc,
+	.free_context = vmx_nested_context_free,
+	.reset_context = vmx_nested_context_reset,
 };
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 546272a5d34d..30b13241ae45 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7666,6 +7666,14 @@ int vmx_vm_init(struct kvm *kvm)
 
 	if (enable_pml)
 		kvm->arch.cpu_dirty_log_size = PML_LOG_NR_ENTRIES;
+
+	if (nested) {
+		int err;
+
+		err = kvm_nested_context_table_init(kvm);
+		if (err)
+			return err;
+	}
 	return 0;
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 4da5a42b0c60..56b96e50290f 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -152,15 +152,15 @@ struct nested_vmx {
 
 	struct loaded_vmcs vmcs02;
 
-	struct gfn_to_pfn_cache msr_bitmap_cache;
+	struct gfn_to_pfn_cache *msr_bitmap_cache;
 
 	/*
 	 * Guest pages referred to in the vmcs02 with host-physical
 	 * pointers, so we must keep them pinned while L2 runs.
 	 */
-	struct gfn_to_pfn_cache apic_access_page_cache;
-	struct gfn_to_pfn_cache virtual_apic_cache;
-	struct gfn_to_pfn_cache pi_desc_cache;
+	struct gfn_to_pfn_cache *apic_access_page_cache;
+	struct gfn_to_pfn_cache *virtual_apic_cache;
+	struct gfn_to_pfn_cache *pi_desc_cache;
 
 	u64 pi_desc_offset;
 	bool pi_pending;
@@ -208,7 +208,7 @@ struct nested_vmx {
 	u32 hv_clean_fields;
 	bool hv_msr_bitmap;
 	bool hv_flush_hypercall;
-	struct gfn_to_pfn_cache hv_evmcs_cache;
+	struct gfn_to_pfn_cache *hv_evmcs_cache;
 #endif
 };
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b05aace9e295..97e0b949e412 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1533,7 +1533,7 @@ static inline bool kvm_gpc_is_hva_active(struct gfn_to_pfn_cache *gpc)
 
 static inline bool kvm_gpc_invalid(struct gfn_to_pfn_cache *gpc)
 {
-	return gpc->active && !gpc->valid;
+	return gpc && gpc->active && !gpc->valid;
 }
 
 void kvm_sigset_activate(struct kvm_vcpu *vcpu);
-- 
2.43.0


