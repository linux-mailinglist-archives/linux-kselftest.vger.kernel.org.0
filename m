Return-Path: <linux-kselftest+bounces-40999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E35B9B49C2B
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 23:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835BC1C2044A
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 21:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC032EB5C8;
	Mon,  8 Sep 2025 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZmbsH5/D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B32E9EB7;
	Mon,  8 Sep 2025 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367198; cv=none; b=UTSADrgJhqzep5EszY8x3d8JS4Lgp0rznX8ixysGBd9xP7rcUdxczHOBRGLPRNIPQIfTWnLpGTyI9A8Nb9ahiaEBH25XEzz6X/SPMu/VXvnzdK72a8w1WNUh3oNojG1UaPzwAaYxIe9zaf6GRfGKhf0gA6X4EkQPrHccFoUI/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367198; c=relaxed/simple;
	bh=phyHjqCS9uGKYCLf30hLTJeN8xw1q6nVFvs+aihC6Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAzJIrdSizqjiqA6S04FlwG/rJsm9uE2fhjn8Rtx8eniPEWZ6WswdJplv7fVihWrFbJX5+SH//6M4m6CZr4/MwaAHoXPNbWd0dTapH8me/62LRl7H5sfgt4Jq4Kicg7sPogWy7/zi5lEUSDGQWlhib3mPMVSwJyaGi3eTQ8gdCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZmbsH5/D; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=AJRiZoVFyTJIE0rFVOLfgm4TnIZJeCki13dbxXUIFdA=; b=ZmbsH5/DWZ9tLnp1JDG2Kna9HU
	p7uiOVDvJxe2a89hoPzH9i1pVL5IiOkKQpQOAQOmPwTHKa1mOd9f/45fQdNNCBXhKjnUN5qoHL9qw
	ee/AKEHNEvbe3iaRlGDG1P8hAzu3P4Ct5fsXlNTUGRUQtDfJMYCigoT0Glz+VcFhyJZJT+IXrUbev
	spFby46unZtN+cXdHg2qcRB9SkbXqGSTUmIKJfY5z+3zef9/85JsCuioVBf3B5x7YnrxniviI7FA+
	sOaSQG2UALOipZl6FmW03GgtkWCkbZWI28HGoA2ahbeq0aH8mM80Y3xKpXy3Bkr9PkNzG4rWBE/PV
	omoTX91g==;
Received: from griffoul by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvjUA-0000000DNug-1ht0;
	Mon, 08 Sep 2025 21:33:14 +0000
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
Subject: [PATCH 1/5] KVM: nVMX: Implement cache for L1 MSR bitmap
Date: Mon,  8 Sep 2025 22:32:26 +0100
Message-ID: <20250908213241.3189113-2-griffoul@infradead.org>
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

Optimize L1 MSR bitmap access by replacing map/unmap operations with a
persistent gfn_to_pfn_cache. This optimization reduces overhead during
L2 VM-entry where nested_vmx_prepare_msr_bitmap() merges L1's MSR
intercepts with L0's requirements.

Current implementation using kvm_vcpu_map_readonly() and
kvm_vcpu_unmap() creates significant performance impact, particularly
with unmanaged guest memory.

New implementation:
- Initializes a pfn cache when entering VMX operation.
- Maintains persistent access throughout operation.
- Deactivates cache when VMX operation ends.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 arch/x86/kvm/vmx/nested.c | 42 +++++++++++++++++++++++++++++++++++----
 arch/x86/kvm/vmx/vmx.h    |  2 ++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b8ea1969113d..aa4fe1fe571d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -315,6 +315,34 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
 	vcpu->arch.regs_dirty = 0;
 }
 
+/*
+ * Maps a single guest page starting at @gpa and lock the cache for access.
+ */
+static int nested_gpc_lock(struct gfn_to_pfn_cache *gpc, gpa_t gpa)
+{
+	int err;
+
+	if (WARN_ON_ONCE(!PAGE_ALIGNED(gpa)))
+		return -EINVAL;
+retry:
+	read_lock(&gpc->lock);
+	if (!kvm_gpc_check(gpc, PAGE_SIZE) || (gpc->gpa != gpa)) {
+		read_unlock(&gpc->lock);
+		err = kvm_gpc_activate(gpc, gpa, PAGE_SIZE);
+		if (err)
+			return err;
+
+		goto retry;
+	}
+
+	return 0;
+}
+
+static void nested_gpc_unlock(struct gfn_to_pfn_cache *gpc)
+{
+	read_unlock(&gpc->lock);
+}
+
 static void nested_put_vmcs12_pages(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -344,6 +372,9 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;
 	vmx->nested.vmxon_ptr = INVALID_GPA;
+
+	kvm_gpc_deactivate(&vmx->nested.msr_bitmap_cache);
+
 	free_vpid(vmx->nested.vpid02);
 	vmx->nested.posted_intr_nv = -1;
 	vmx->nested.current_vmptr = INVALID_GPA;
@@ -625,7 +656,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	int msr;
 	unsigned long *msr_bitmap_l1;
 	unsigned long *msr_bitmap_l0 = vmx->nested.vmcs02.msr_bitmap;
-	struct kvm_host_map map;
+	struct gfn_to_pfn_cache *gpc;
 
 	/* Nothing to do if the MSR bitmap is not in use.  */
 	if (!cpu_has_vmx_msr_bitmap() ||
@@ -648,10 +679,11 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 			return true;
 	}
 
-	if (kvm_vcpu_map_readonly(vcpu, gpa_to_gfn(vmcs12->msr_bitmap), &map))
+	gpc = &vmx->nested.msr_bitmap_cache;
+	if (nested_gpc_lock(gpc, vmcs12->msr_bitmap))
 		return false;
 
-	msr_bitmap_l1 = (unsigned long *)map.hva;
+	msr_bitmap_l1 = (unsigned long *)gpc->khva;
 
 	/*
 	 * To keep the control flow simple, pay eight 8-byte writes (sixteen
@@ -721,7 +753,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
 					 MSR_IA32_MPERF, MSR_TYPE_R);
 
-	kvm_vcpu_unmap(vcpu, &map);
+	nested_gpc_unlock(gpc);
 
 	vmx->nested.force_msr_bitmap_recalc = false;
 
@@ -5352,6 +5384,8 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 
 	vmx->nested.vpid02 = allocate_vpid();
 
+	kvm_gpc_init(&vmx->nested.msr_bitmap_cache, vcpu->kvm);
+
 	vmx->nested.vmcs02_initialized = false;
 	vmx->nested.vmxon = true;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index d3389baf3ab3..3a6983222841 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -152,6 +152,8 @@ struct nested_vmx {
 
 	struct loaded_vmcs vmcs02;
 
+	struct gfn_to_pfn_cache msr_bitmap_cache;
+
 	/*
 	 * Guest pages referred to in the vmcs02 with host-physical
 	 * pointers, so we must keep them pinned while L2 runs.
-- 
2.51.0


