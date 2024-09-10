Return-Path: <linux-kselftest+bounces-17607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D495973BB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44CFAB2596B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12F019DF58;
	Tue, 10 Sep 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="VAb69RGB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17E219D88C;
	Tue, 10 Sep 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981833; cv=none; b=XxoYi5BTFmzaEOypDPOeeXRXO1OSEDWTDlY8G+ViTrQP+viBZmGTilSa1J8IonTT+5tFNosOk7pssA7OEwB5zx4i23Pl2UoF6YA1bhkflfRrswCHTBK++lhiBA3xIcl4XeMnsK4HX4ckOjrDjEFgOz2nmqRY5mnkXWerXlE/LIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981833; c=relaxed/simple;
	bh=BVepAbkOeEU3slbtp/jqhBcz5M3ofT+FBHaVmTXzrPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVXWc1LH5P6w9BW1WkWvTFpXqZ2BT9agDzNqqEy8Mmy3SokPK2hRWmdw9XU9b83329QKboF8PSMQJ/5JK3aSWkQ/BJUPoqdtZ1OOW83MHwQ6MOrU+UwAbBibscPSYds4JR+NDxgbH6We8LkSCShgDppMkTG9qHWj5pQfkazDAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=VAb69RGB; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725981829; x=1757517829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eR/aj8npvoNsBgWmleE4bomhd/6jXremotPxYL2Sd6Y=;
  b=VAb69RGBgV8VUNYVnWkUuzwL2f7jAl+Mrvpq5UtBwy6n6U5oR88bnM+Z
   s3VRveyC1kmcZdthhBYH9qyHooorNvb94sRWzUjAqK4srtkUhVWtOQuLW
   Iy0pLZcuZoVDKNrGQTwwTaoZb26ew4s8LX2Mp4bQGw0MoH+e0yaUQvZRl
   U=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="758470499"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:23:47 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:2418]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.38.136:2525] with esmtp (Farcaster)
 id d4f45114-c17c-419b-9541-f2fc8de2c3fd; Tue, 10 Sep 2024 15:23:45 +0000 (UTC)
X-Farcaster-Flow-ID: d4f45114-c17c-419b-9541-f2fc8de2c3fd
Received: from EX19D014EUC002.ant.amazon.com (10.252.51.161) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:23:40 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D014EUC002.ant.amazon.com (10.252.51.161) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:23:40 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (10.253.74.52)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 10 Sep 2024 15:23:38 +0000
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
Subject: [PATCH 05/15] KVM: x86/mmu: Introduce flags parameter to page walker
Date: Tue, 10 Sep 2024 15:21:57 +0000
Message-ID: <20240910152207.38974-6-nikwip@amazon.de>
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

Introduce the flags parameter to walk_addr_generic() which is needed to
introduce fine grained control over the accessed/dirty bits. Also forward
the parameter to several of the page walker's helper functions, so it can
be used in an ioctl.

Setting both PWALK_SET_ACCESSED and PWALK_SET_DIRTY will continue to
maintain the previous behaviour, that is, both bits are only set after a
successful walk and the dirty bit is only set when write access is
enabled.

No functional change intended.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 arch/x86/include/asm/kvm_host.h | 10 +++++++++-
 arch/x86/kvm/hyperv.c           |  3 ++-
 arch/x86/kvm/mmu.h              |  6 +++---
 arch/x86/kvm/mmu/mmu.c          |  4 ++--
 arch/x86/kvm/mmu/paging_tmpl.h  | 25 ++++++++++++++-----------
 arch/x86/kvm/x86.c              | 33 ++++++++++++++++++++-------------
 6 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 46e0a466d7fb..3acf0b069693 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -281,6 +281,14 @@ enum x86_intercept_stage;
 #define PFERR_PRIVATE_ACCESS   BIT_ULL(49)
 #define PFERR_SYNTHETIC_MASK   (PFERR_IMPLICIT_ACCESS | PFERR_PRIVATE_ACCESS)
 
+#define PFERR_NESTED_GUEST_PAGE (PFERR_GUEST_PAGE_MASK |	\
+				 PFERR_WRITE_MASK |		\
+				 PFERR_PRESENT_MASK)
+
+#define PWALK_SET_ACCESSED	BIT(0)
+#define PWALK_SET_DIRTY	BIT(1)
+#define PWALK_SET_ALL	(PWALK_SET_ACCESSED | PWALK_SET_DIRTY)
+
 /* apic attention bits */
 #define KVM_APIC_CHECK_VAPIC	0
 /*
@@ -450,7 +458,7 @@ struct kvm_mmu {
 	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
 				  struct x86_exception *fault);
 	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-			    gpa_t gva_or_gpa, u64 access,
+			    gpa_t gva_or_gpa, u64 access, u64 flags,
 			    struct x86_exception *exception);
 	int (*sync_spte)(struct kvm_vcpu *vcpu,
 			 struct kvm_mmu_page *sp, int i);
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4f0a94346d00..b237231ace61 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2036,7 +2036,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * read with kvm_read_guest().
 	 */
 	if (!hc->fast && is_guest_mode(vcpu)) {
-		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa, 0, NULL);
+		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa, 0,
+						 PWALK_SET_ALL, NULL);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 9dc5dd43ae7f..35030f6466b5 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -275,15 +275,15 @@ static inline void kvm_update_page_stats(struct kvm *kvm, int level, int count)
 }
 
 gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 access,
-			   struct x86_exception *exception);
+			   u64 flags, struct x86_exception *exception);
 
 static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 				      struct kvm_mmu *mmu,
-				      gpa_t gpa, u64 access,
+				      gpa_t gpa, u64 access, u64 flags,
 				      struct x86_exception *exception)
 {
 	if (mmu != &vcpu->arch.nested_mmu)
 		return gpa;
-	return translate_nested_gpa(vcpu, gpa, access, exception);
+	return translate_nested_gpa(vcpu, gpa, access, flags, exception);
 }
 #endif
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0d94354bb2f8..50c635142bf7 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4102,12 +4102,12 @@ void kvm_mmu_sync_prev_roots(struct kvm_vcpu *vcpu)
 }
 
 static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-				  gpa_t vaddr, u64 access,
+				  gpa_t vaddr, u64 access, u64 flags,
 				  struct x86_exception *exception)
 {
 	if (exception)
 		exception->error_code = 0;
-	return kvm_translate_gpa(vcpu, mmu, vaddr, access, exception);
+	return kvm_translate_gpa(vcpu, mmu, vaddr, access, flags, exception);
 }
 
 static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, bool direct)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 74651b097fa0..c278b83b023f 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -301,7 +301,7 @@ static inline bool FNAME(is_last_gpte)(struct kvm_mmu *mmu,
  */
 static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 				    struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-				    gpa_t addr, u64 access)
+				    gpa_t addr, u64 access, u64 flags)
 {
 	int ret;
 	pt_element_t pte;
@@ -379,7 +379,8 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		walker->pte_gpa[walker->level - 1] = pte_gpa;
 
 		real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(table_gfn),
-					     nested_access, &walker->fault);
+					     nested_access, flags,
+					     &walker->fault);
 
 		/*
 		 * FIXME: This can happen if emulation (for of an INS/OUTS
@@ -449,7 +450,8 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		gfn += pse36_gfn_delta(pte);
 #endif
 
-	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn), access, &walker->fault);
+	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn), access,
+								 flags, &walker->fault);
 	if (real_gpa == INVALID_GPA)
 		return 0;
 
@@ -467,8 +469,8 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 			(PT_GUEST_DIRTY_SHIFT - PT_GUEST_ACCESSED_SHIFT);
 
 	if (unlikely(!accessed_dirty)) {
-		ret = FNAME(update_accessed_dirty_bits)(vcpu, mmu, walker,
-							addr, write_fault);
+		ret = FNAME(update_accessed_dirty_bits)(vcpu, mmu, walker, addr,
+							write_fault);
 		if (unlikely(ret < 0))
 			goto error;
 		else if (ret)
@@ -527,11 +529,11 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	return 0;
 }
 
-static int FNAME(walk_addr)(struct guest_walker *walker,
-			    struct kvm_vcpu *vcpu, gpa_t addr, u64 access)
+static int FNAME(walk_addr)(struct guest_walker *walker, struct kvm_vcpu *vcpu,
+			    gpa_t addr, u64 access, u64 flags)
 {
 	return FNAME(walk_addr_generic)(walker, vcpu, vcpu->arch.mmu, addr,
-					access);
+					access, flags);
 }
 
 static bool
@@ -793,7 +795,8 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * The bit needs to be cleared before walking guest page tables.
 	 */
 	r = FNAME(walk_addr)(&walker, vcpu, fault->addr,
-			     fault->error_code & ~PFERR_RSVD_MASK);
+			     fault->error_code & ~PFERR_RSVD_MASK,
+			     PWALK_SET_ALL);
 
 	/*
 	 * The page is not mapped by the guest.  Let the guest handle it.
@@ -872,7 +875,7 @@ static gpa_t FNAME(get_level1_sp_gpa)(struct kvm_mmu_page *sp)
 
 /* Note, @addr is a GPA when gva_to_gpa() translates an L2 GPA to an L1 GPA. */
 static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-			       gpa_t addr, u64 access,
+			       gpa_t addr, u64 access, u64 flags,
 			       struct x86_exception *exception)
 {
 	struct guest_walker walker;
@@ -884,7 +887,7 @@ static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	WARN_ON_ONCE((addr >> 32) && mmu == vcpu->arch.walk_mmu);
 #endif
 
-	r = FNAME(walk_addr_generic)(&walker, vcpu, mmu, addr, access);
+	r = FNAME(walk_addr_generic)(&walker, vcpu, mmu, addr, access, flags);
 
 	if (r) {
 		gpa = gfn_to_gpa(walker.gfn);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 15080385b8fe..32e81cd502ee 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1067,7 +1067,8 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	 * to an L1 GPA.
 	 */
 	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(pdpt_gfn),
-				     PFERR_USER_MASK | PFERR_WRITE_MASK, NULL);
+				     PFERR_USER_MASK | PFERR_WRITE_MASK,
+				     PWALK_SET_ALL, NULL);
 	if (real_gpa == INVALID_GPA)
 		return 0;
 
@@ -7560,7 +7561,7 @@ void kvm_get_segment(struct kvm_vcpu *vcpu,
 }
 
 gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 access,
-			   struct x86_exception *exception)
+			   u64 flags, struct x86_exception *exception)
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	gpa_t t_gpa;
@@ -7569,7 +7570,7 @@ gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 access,
 
 	/* NPT walks are always user-walks */
 	access |= PFERR_USER_MASK;
-	t_gpa  = mmu->gva_to_gpa(vcpu, mmu, gpa, access, exception);
+	t_gpa  = mmu->gva_to_gpa(vcpu, mmu, gpa, access, flags, exception);
 
 	return t_gpa;
 }
@@ -7580,7 +7581,8 @@ gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
-	return mmu->gva_to_gpa(vcpu, mmu, gva, access, exception);
+	return mmu->gva_to_gpa(vcpu, mmu, gva, access, PWALK_SET_ALL,
+			       exception);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_gva_to_gpa_read);
 
@@ -7591,7 +7593,8 @@ gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	access |= PFERR_WRITE_MASK;
-	return mmu->gva_to_gpa(vcpu, mmu, gva, access, exception);
+	return mmu->gva_to_gpa(vcpu, mmu, gva, access, PWALK_SET_ALL,
+			       exception);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_gva_to_gpa_write);
 
@@ -7601,7 +7604,7 @@ gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
 {
 	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
 
-	return mmu->gva_to_gpa(vcpu, mmu, gva, 0, exception);
+	return mmu->gva_to_gpa(vcpu, mmu, gva, 0, PWALK_SET_ALL, exception);
 }
 
 static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
@@ -7613,7 +7616,8 @@ static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 	int r = X86EMUL_CONTINUE;
 
 	while (bytes) {
-		gpa_t gpa = mmu->gva_to_gpa(vcpu, mmu, addr, access, exception);
+		gpa_t gpa = mmu->gva_to_gpa(vcpu, mmu, addr, access,
+					    PWALK_SET_ALL, exception);
 		unsigned offset = addr & (PAGE_SIZE-1);
 		unsigned toread = min(bytes, (unsigned)PAGE_SIZE - offset);
 		int ret;
@@ -7647,8 +7651,8 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 	int ret;
 
 	/* Inline kvm_read_guest_virt_helper for speed.  */
-	gpa_t gpa = mmu->gva_to_gpa(vcpu, mmu, addr, access|PFERR_FETCH_MASK,
-				    exception);
+	gpa_t gpa = mmu->gva_to_gpa(vcpu, mmu, addr, access | PFERR_FETCH_MASK,
+								PWALK_SET_ALL, exception);
 	if (unlikely(gpa == INVALID_GPA))
 		return X86EMUL_PROPAGATE_FAULT;
 
@@ -7705,7 +7709,8 @@ static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes
 	int r = X86EMUL_CONTINUE;
 
 	while (bytes) {
-		gpa_t gpa = mmu->gva_to_gpa(vcpu, mmu, addr, access, exception);
+		gpa_t gpa = mmu->gva_to_gpa(vcpu, mmu, addr, access,
+					    PWALK_SET_ALL, exception);
 		unsigned offset = addr & (PAGE_SIZE-1);
 		unsigned towrite = min(bytes, (unsigned)PAGE_SIZE - offset);
 		int ret;
@@ -7817,14 +7822,15 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 	 */
 	if (vcpu_match_mmio_gva(vcpu, gva) && (!is_paging(vcpu) ||
 	    !permission_fault(vcpu, vcpu->arch.walk_mmu,
-			      vcpu->arch.mmio_access, 0, access))) {
+			       vcpu->arch.mmio_access,
+			      PWALK_SET_ALL, access))) {
 		*gpa = vcpu->arch.mmio_gfn << PAGE_SHIFT |
 					(gva & (PAGE_SIZE - 1));
 		trace_vcpu_match_mmio(gva, *gpa, write, false);
 		return 1;
 	}
 
-	*gpa = mmu->gva_to_gpa(vcpu, mmu, gva, access, exception);
+	*gpa = mmu->gva_to_gpa(vcpu, mmu, gva, access, PWALK_SET_ALL, exception);
 
 	if (*gpa == INVALID_GPA)
 		return -1;
@@ -13644,7 +13650,8 @@ void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_c
 		(PFERR_WRITE_MASK | PFERR_FETCH_MASK | PFERR_USER_MASK);
 
 	if (!(error_code & PFERR_PRESENT_MASK) ||
-	    mmu->gva_to_gpa(vcpu, mmu, gva, access, &fault) != INVALID_GPA) {
+	    mmu->gva_to_gpa(vcpu, mmu, gva, access, PWALK_SET_ALL,
+			    &fault) != INVALID_GPA) {
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


