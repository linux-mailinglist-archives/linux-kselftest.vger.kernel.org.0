Return-Path: <linux-kselftest+bounces-17611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AB8973BC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9006C2895C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AAF1A2C32;
	Tue, 10 Sep 2024 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="pRCWkV56"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC641A2551;
	Tue, 10 Sep 2024 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981897; cv=none; b=Mc7GeDe0FAqLOE7po5aAl4G05hNy8yahtmN/QwUEHWeYGTbLa6xORVx0m+6ZwUTbfpkNYuU8zO1Q44UVsF+rynIEso1feMn7GPBSgtJHehzXW7iwC9IiVQ2CAZAxRBeuS+B5yAcx164tC+RSoj73sHPZ8kJ6pLHmtWZTmd64w98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981897; c=relaxed/simple;
	bh=DKOkjI+c3qUYMLTmRQMPPaIYgXbxgKRzFDlLxE4acjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nh3DlUJuEvRuhpHjNXk9ikFbr45MLor2WUJh4lrZtLBYkjAMUzDhKtwYYTwLBZs1E3LvnWKe88n+6Mm3NiVybjNcRYvGVguNctySoEm32ORCrRbkS7sTnBO84JqlRjsrAf3KDqf1lByTTNnMxfCBi+i39fqEVBr5TPbWviIz6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=pRCWkV56; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725981896; x=1757517896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8a5R4qdiyvNyIJoumEfbzn9XD7EbuO1bJFlMEMd4SNM=;
  b=pRCWkV56kCmDsRJsTsbHl4dtrHE++IqdY/ac5yNNtDxpwkDdlkj3b0N9
   Ry5FvDOuE2nkMhOqglV0Jxvil0Cm36qKUQpump/k6jFwbfPSfNPFX3sIJ
   JMKNDT/LG2mfZMX19OFGgZuHR6l7j7Tv6/4WwfKinKz5Q6crV8uBHq08Y
   o=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="758470951"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:24:54 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:12094]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.13.80:2525] with esmtp (Farcaster)
 id 38291df8-0ba6-4211-80b0-303256e1086f; Tue, 10 Sep 2024 15:24:52 +0000 (UTC)
X-Farcaster-Flow-ID: 38291df8-0ba6-4211-80b0-303256e1086f
Received: from EX19D004EUA001.ant.amazon.com (10.252.50.27) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:24:52 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D004EUA001.ant.amazon.com (10.252.50.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:24:52 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (10.253.74.52)
 by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 10 Sep 2024 15:24:50 +0000
From: Nikolas Wipper <nikwip@amazon.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
CC: Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf
	<graf@amazon.de>, James Gowans <jgowans@amazon.com>,
	<nh-open-source@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kvmarm@lists.linux.dev>,
	<kvm-riscv@lists.infradead.org>, Nikolas Wipper <nikwip@amazon.de>
Subject: [PATCH 09/15] KVM: x86/mmu: Introduce status parameter to page walker
Date: Tue, 10 Sep 2024 15:22:01 +0000
Message-ID: <20240910152207.38974-10-nikwip@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240910152207.38974-1-nikwip@amazon.de>
References: <20240910152207.38974-1-nikwip@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Introduce the status parameter to walk_addr_generic() which is used in
later patches to provide the caller with information on whether setting
the accessed/dirty bits succeeded.

No functional change intended.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/hyperv.c           |  2 +-
 arch/x86/kvm/mmu.h              |  8 +++++---
 arch/x86/kvm/mmu/mmu.c          |  5 +++--
 arch/x86/kvm/mmu/paging_tmpl.h  | 26 ++++++++++++++++----------
 arch/x86/kvm/x86.c              | 25 ++++++++++++++-----------
 6 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cd2c391d6a24..1c5aaf55c683 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -460,7 +460,7 @@ struct kvm_mmu {
 				  struct x86_exception *fault);
 	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 			    gpa_t gva_or_gpa, u64 access, u64 flags,
-			    struct x86_exception *exception);
+			    struct x86_exception *exception, u16 *status);
 	int (*sync_spte)(struct kvm_vcpu *vcpu,
 			 struct kvm_mmu_page *sp, int i);
 	struct kvm_mmu_root_info root;
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index b237231ace61..30d5b86bc306 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2037,7 +2037,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 */
 	if (!hc->fast && is_guest_mode(vcpu)) {
 		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa, 0,
-						 PWALK_SET_ALL, NULL);
+						 PWALK_SET_ALL, NULL, NULL);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 35030f6466b5..272ce93f855f 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -275,15 +275,17 @@ static inline void kvm_update_page_stats(struct kvm *kvm, int level, int count)
 }
 
 gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 access,
-			   u64 flags, struct x86_exception *exception);
+			   u64 flags, struct x86_exception *exception,
+			   u16 *status);
 
 static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 				      struct kvm_mmu *mmu,
 				      gpa_t gpa, u64 access, u64 flags,
-				      struct x86_exception *exception)
+				      struct x86_exception *exception,
+				      u16 *status)
 {
 	if (mmu != &vcpu->arch.nested_mmu)
 		return gpa;
-	return translate_nested_gpa(vcpu, gpa, access, flags, exception);
+	return translate_nested_gpa(vcpu, gpa, access, flags, exception, status);
 }
 #endif
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 50c635142bf7..2ab0437edf54 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4103,11 +4103,12 @@ void kvm_mmu_sync_prev_roots(struct kvm_vcpu *vcpu)
 
 static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 				  gpa_t vaddr, u64 access, u64 flags,
-				  struct x86_exception *exception)
+				  struct x86_exception *exception, u16 *status)
 {
 	if (exception)
 		exception->error_code = 0;
-	return kvm_translate_gpa(vcpu, mmu, vaddr, access, flags, exception);
+	return kvm_translate_gpa(vcpu, mmu, vaddr, access, flags, exception,
+				 status);
 }
 
 static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, bool direct)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 2cc40fd17f53..985a19dda603 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -197,7 +197,8 @@ static inline unsigned FNAME(gpte_access)(u64 gpte)
 static int FNAME(update_accessed_dirty_bits)(struct kvm_vcpu *vcpu,
 					     struct kvm_mmu *mmu,
 					     struct guest_walker *walker,
-					     gpa_t addr, int write_fault)
+					     gpa_t addr, int write_fault,
+					     u16 *status)
 {
 	unsigned level, index;
 	pt_element_t pte, orig_pte;
@@ -301,7 +302,8 @@ static inline bool FNAME(is_last_gpte)(struct kvm_mmu *mmu,
  */
 static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 				    struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-				    gpa_t addr, u64 access, u64 flags)
+				    gpa_t addr, u64 access, u64 flags,
+				    u16 *status)
 {
 	int ret;
 	pt_element_t pte;
@@ -344,6 +346,9 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 	walker->fault.flags = 0;
 
+	if (status)
+		*status = 0;
+
 	/*
 	 * FIXME: on Intel processors, loads of the PDPTE registers for PAE paging
 	 * by the MOV to CR instruction are treated as reads and do not cause the
@@ -383,7 +388,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 		real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(table_gfn),
 					     nested_access, flags,
-					     &walker->fault);
+					     &walker->fault, status);
 
 		/*
 		 * FIXME: This can happen if emulation (for of an INS/OUTS
@@ -453,8 +458,8 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		gfn += pse36_gfn_delta(pte);
 #endif
 
-	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn), access,
-								 flags, &walker->fault);
+	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn), access, flags,
+				     &walker->fault, status);
 	if (real_gpa == INVALID_GPA)
 		goto late_exit;
 
@@ -473,7 +478,8 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 	if (unlikely(set_accessed && !accessed_dirty)) {
 		ret = FNAME(update_accessed_dirty_bits)(vcpu, mmu, walker, addr,
-							write_fault && set_dirty);
+							write_fault && set_dirty,
+							status);
 		if (unlikely(ret < 0))
 			goto error;
 		else if (ret)
@@ -538,7 +544,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		 */
 		++walker->level;
 		FNAME(update_accessed_dirty_bits)(vcpu, mmu, walker, addr,
-		 false);
+		 false, status);
 		--walker->level;
 	}
 	return 0;
@@ -548,7 +554,7 @@ static int FNAME(walk_addr)(struct guest_walker *walker, struct kvm_vcpu *vcpu,
 			    gpa_t addr, u64 access, u64 flags)
 {
 	return FNAME(walk_addr_generic)(walker, vcpu, vcpu->arch.mmu, addr,
-					access, flags);
+					access, flags, NULL);
 }
 
 static bool
@@ -891,7 +897,7 @@ static gpa_t FNAME(get_level1_sp_gpa)(struct kvm_mmu_page *sp)
 /* Note, @addr is a GPA when gva_to_gpa() translates an L2 GPA to an L1 GPA. */
 static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 			       gpa_t addr, u64 access, u64 flags,
-			       struct x86_exception *exception)
+			       struct x86_exception *exception, u16 *status)
 {
 	struct guest_walker walker;
 	gpa_t gpa = INVALID_GPA;
@@ -902,7 +908,7 @@ static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	WARN_ON_ONCE((addr >> 32) && mmu == vcpu->arch.walk_mmu);
 #endif
 
-	r = FNAME(walk_addr_generic)(&walker, vcpu, mmu, addr, access, flags);
+	r = FNAME(walk_addr_generic)(&walker, vcpu, mmu, addr, access, flags, status);
 
 	if (r) {
 		gpa = gfn_to_gpa(walker.gfn);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32e81cd502ee..be696b60aba6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1068,7 +1068,7 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	 */
 	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(pdpt_gfn),
 				     PFERR_USER_MASK | PFERR_WRITE_MASK,
-				     PWALK_SET_ALL, NULL);
+				     PWALK_SET_ALL, NULL, NULL);
 	if (real_gpa == INVALID_GPA)
 		return 0;
 
@@ -7561,7 +7561,8 @@ void kvm_get_segment(struct kvm_vcpu *vcpu,
 }
 
 gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 access,
-			   u64 flags, struct x86_exception *exception)
+			   u64 flags, struct x86_exception *exception,
+			   u16 *status)
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	gpa_t t_gpa;
@@ -7570,7 +7571,8 @@ gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 access,
 
 	/* NPT walks are always user-walks */
 	access |= PFERR_USER_MASK;
-	t_gpa  = mmu->gva_to_gpa(vcpu, mmu, gpa, access, flags, exception);
+	t_gpa  = mmu->gva_to_gpa(vcpu, mmu, gpa, access, flags, exception,
+				status);
 
 	return t_gpa;
 }
@@ -7582,7 +7584,7 @@ gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	return mmu->gva_to_gpa(vcpu, mmu, gva, access, PWALK_SET_ALL,
-			       exception);
+			       exception, NULL);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_gva_to_gpa_read);
 
@@ -7594,7 +7596,7 @@ gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	access |= PFERR_WRITE_MASK;
 	return mmu->gva_to_gpa(vcpu, mmu, gva, access, PWALK_SET_ALL,
-			       exception);
+			       exception, NULL);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_gva_to_gpa_write);
 
@@ -7604,7 +7606,7 @@ gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
 {
 	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
 
-	return mmu->gva_to_gpa(vcpu, mmu, gva, 0, PWALK_SET_ALL, exception);
+	return mmu->gva_to_gpa(vcpu, mmu, gva, 0, PWALK_SET_ALL, exception, NULL);
 }
 
 static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
@@ -7617,7 +7619,7 @@ static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 
 	while (bytes) {
 		gpa_t gpa = mmu->gva_to_gpa(vcpu, mmu, addr, access,
-					    PWALK_SET_ALL, exception);
+					    PWALK_SET_ALL, exception, NULL);
 		unsigned offset = addr & (PAGE_SIZE-1);
 		unsigned toread = min(bytes, (unsigned)PAGE_SIZE - offset);
 		int ret;
@@ -7652,7 +7654,8 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 
 	/* Inline kvm_read_guest_virt_helper for speed.  */
 	gpa_t gpa = mmu->gva_to_gpa(vcpu, mmu, addr, access | PFERR_FETCH_MASK,
-								PWALK_SET_ALL, exception);
+								PWALK_SET_ALL,
+				    exception, NULL);
 	if (unlikely(gpa == INVALID_GPA))
 		return X86EMUL_PROPAGATE_FAULT;
 
@@ -7710,7 +7713,7 @@ static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes
 
 	while (bytes) {
 		gpa_t gpa = mmu->gva_to_gpa(vcpu, mmu, addr, access,
-					    PWALK_SET_ALL, exception);
+					    PWALK_SET_ALL, exception, NULL);
 		unsigned offset = addr & (PAGE_SIZE-1);
 		unsigned towrite = min(bytes, (unsigned)PAGE_SIZE - offset);
 		int ret;
@@ -7830,7 +7833,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 		return 1;
 	}
 
-	*gpa = mmu->gva_to_gpa(vcpu, mmu, gva, access, PWALK_SET_ALL, exception);
+	*gpa = mmu->gva_to_gpa(vcpu, mmu, gva, access, PWALK_SET_ALL, exception, NULL);
 
 	if (*gpa == INVALID_GPA)
 		return -1;
@@ -13651,7 +13654,7 @@ void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_c
 
 	if (!(error_code & PFERR_PRESENT_MASK) ||
 	    mmu->gva_to_gpa(vcpu, mmu, gva, access, PWALK_SET_ALL,
-			    &fault) != INVALID_GPA) {
+			    &fault, NULL) != INVALID_GPA) {
 		/*
 		 * If vcpu->arch.walk_mmu->gva_to_gpa succeeded, the page
 		 * tables probably do not match the TLB.  Just proceed
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


