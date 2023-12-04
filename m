Return-Path: <linux-kselftest+bounces-1061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7759B803829
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 16:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6FDDB20DEE
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 15:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B236828E35;
	Mon,  4 Dec 2023 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="gksb0EUd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37431990
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Dec 2023 07:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=5x2o4y2wF7A9xIIu87sGlw6cVVEirMcZGgIuh8cn9bw=; b=gksb0EUdPFsVXcbr06JSI4RNst
	5Qq4IopzB+LMuVN7k52+Sv7GbVq5sn78RyqSZGQ52vkgsgJ4oohTzVtAYorwUjm/QX+eraruT1KBo
	DL3wY1yBX5ZrgAg9tlwwgARcC6GRfNwNJxhIUEP50cy2JfPnfeRkV5+z/AagHJnh0g0k=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rAAB4-0003ec-5o; Mon, 04 Dec 2023 14:44:06 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rAAB3-00088g-Sr; Mon, 04 Dec 2023 14:44:06 +0000
From: Paul Durrant <paul@xen.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v10 05/19] KVM: pfncache: remove KVM_GUEST_USES_PFN usage
Date: Mon,  4 Dec 2023 14:43:20 +0000
Message-Id: <20231204144334.910-6-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204144334.910-1-paul@xen.org>
References: <20231204144334.910-1-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Durrant <pdurrant@amazon.com>

As noted in [1] the KVM_GUEST_USES_PFN usage flag is never set by any
callers of kvm_gpc_init(), which also makes the 'vcpu' argument redundant.
Moreover, all existing callers specify KVM_HOST_USES_PFN so the usage
check in hva_to_pfn_retry() and hence the 'usage' argument to
kvm_gpc_init() are also redundant.
Remove the pfn_cache_usage enumeration and remove the redundant arguments,
fields of struct gfn_to_hva_cache, and all the related code.

[1] https://lore.kernel.org/all/ZQiR8IpqOZrOpzHC@google.com/

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: x86@kernel.org

v8:
 - New in this version.
---
 arch/x86/kvm/x86.c        |  2 +-
 arch/x86/kvm/xen.c        | 14 ++++-----
 include/linux/kvm_host.h  | 11 +------
 include/linux/kvm_types.h |  8 -----
 virt/kvm/pfncache.c       | 61 ++++++---------------------------------
 5 files changed, 16 insertions(+), 80 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 09827c07be61..d2958b27872a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12003,7 +12003,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.regs_avail = ~0;
 	vcpu->arch.regs_dirty = ~0;
 
-	kvm_gpc_init(&vcpu->arch.pv_time, vcpu->kvm, vcpu, KVM_HOST_USES_PFN);
+	kvm_gpc_init(&vcpu->arch.pv_time, vcpu->kvm);
 
 	if (!irqchip_in_kernel(vcpu->kvm) || kvm_vcpu_is_reset_bsp(vcpu))
 		vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 41a7c03f7204..e1967f970f54 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2101,14 +2101,10 @@ void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 
 	timer_setup(&vcpu->arch.xen.poll_timer, cancel_evtchn_poll, 0);
 
-	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm, NULL,
-		     KVM_HOST_USES_PFN);
-	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm, NULL,
-		     KVM_HOST_USES_PFN);
-	kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm, NULL,
-		     KVM_HOST_USES_PFN);
-	kvm_gpc_init(&vcpu->arch.xen.vcpu_time_info_cache, vcpu->kvm, NULL,
-		     KVM_HOST_USES_PFN);
+	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm);
+	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm);
+	kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm);
+	kvm_gpc_init(&vcpu->arch.xen.vcpu_time_info_cache, vcpu->kvm);
 }
 
 void kvm_xen_destroy_vcpu(struct kvm_vcpu *vcpu)
@@ -2151,7 +2147,7 @@ void kvm_xen_init_vm(struct kvm *kvm)
 {
 	mutex_init(&kvm->arch.xen.xen_lock);
 	idr_init(&kvm->arch.xen.evtchn_ports);
-	kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm, NULL, KVM_HOST_USES_PFN);
+	kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm);
 }
 
 void kvm_xen_destroy_vm(struct kvm *kvm)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 64dd616612ed..6097f076a7b0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1320,21 +1320,12 @@ void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn);
  *
  * @gpc:	   struct gfn_to_pfn_cache object.
  * @kvm:	   pointer to kvm instance.
- * @vcpu:	   vCPU to be used for marking pages dirty and to be woken on
- *		   invalidation.
- * @usage:	   indicates if the resulting host physical PFN is used while
- *		   the @vcpu is IN_GUEST_MODE (in which case invalidation of 
- *		   the cache from MMU notifiers---but not for KVM memslot
- *		   changes!---will also force @vcpu to exit the guest and
- *		   refresh the cache); and/or if the PFN used directly
- *		   by KVM (and thus needs a kernel virtual mapping).
  *
  * This sets up a gfn_to_pfn_cache by initializing locks and assigning the
  * immutable attributes.  Note, the cache must be zero-allocated (or zeroed by
  * the caller before init).
  */
-void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
-		  struct kvm_vcpu *vcpu, enum pfn_cache_usage usage);
+void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm);
 
 /**
  * kvm_gpc_activate - prepare a cached kernel mapping and HPA for a given guest
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index 9d1f7835d8c1..d93f6522b2c3 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -49,12 +49,6 @@ typedef u64            hfn_t;
 
 typedef hfn_t kvm_pfn_t;
 
-enum pfn_cache_usage {
-	KVM_GUEST_USES_PFN = BIT(0),
-	KVM_HOST_USES_PFN  = BIT(1),
-	KVM_GUEST_AND_HOST_USE_PFN = KVM_GUEST_USES_PFN | KVM_HOST_USES_PFN,
-};
-
 struct gfn_to_hva_cache {
 	u64 generation;
 	gpa_t gpa;
@@ -69,13 +63,11 @@ struct gfn_to_pfn_cache {
 	unsigned long uhva;
 	struct kvm_memory_slot *memslot;
 	struct kvm *kvm;
-	struct kvm_vcpu *vcpu;
 	struct list_head list;
 	rwlock_t lock;
 	struct mutex refresh_lock;
 	void *khva;
 	kvm_pfn_t pfn;
-	enum pfn_cache_usage usage;
 	bool active;
 	bool valid;
 };
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index f3571f44d9af..6f4b537eb25b 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -25,9 +25,7 @@
 void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 				       unsigned long end, bool may_block)
 {
-	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
 	struct gfn_to_pfn_cache *gpc;
-	bool evict_vcpus = false;
 
 	spin_lock(&kvm->gpc_lock);
 	list_for_each_entry(gpc, &kvm->gpc_list, list) {
@@ -37,43 +35,10 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 		if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
 		    gpc->uhva >= start && gpc->uhva < end) {
 			gpc->valid = false;
-
-			/*
-			 * If a guest vCPU could be using the physical address,
-			 * it needs to be forced out of guest mode.
-			 */
-			if (gpc->usage & KVM_GUEST_USES_PFN) {
-				if (!evict_vcpus) {
-					evict_vcpus = true;
-					bitmap_zero(vcpu_bitmap, KVM_MAX_VCPUS);
-				}
-				__set_bit(gpc->vcpu->vcpu_idx, vcpu_bitmap);
-			}
 		}
 		write_unlock_irq(&gpc->lock);
 	}
 	spin_unlock(&kvm->gpc_lock);
-
-	if (evict_vcpus) {
-		/*
-		 * KVM needs to ensure the vCPU is fully out of guest context
-		 * before allowing the invalidation to continue.
-		 */
-		unsigned int req = KVM_REQ_OUTSIDE_GUEST_MODE;
-		bool called;
-
-		/*
-		 * If the OOM reaper is active, then all vCPUs should have
-		 * been stopped already, so perform the request without
-		 * KVM_REQUEST_WAIT and be sad if any needed to be IPI'd.
-		 */
-		if (!may_block)
-			req &= ~KVM_REQUEST_WAIT;
-
-		called = kvm_make_vcpus_request_mask(kvm, req, vcpu_bitmap);
-
-		WARN_ON_ONCE(called && !may_block);
-	}
 }
 
 bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
@@ -206,16 +171,14 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 		 * pfn.  Note, kmap() and memremap() can both sleep, so this
 		 * too must be done outside of gpc->lock!
 		 */
-		if (gpc->usage & KVM_HOST_USES_PFN) {
-			if (new_pfn == gpc->pfn)
-				new_khva = old_khva;
-			else
-				new_khva = gpc_map(new_pfn);
-
-			if (!new_khva) {
-				kvm_release_pfn_clean(new_pfn);
-				goto out_error;
-			}
+		if (new_pfn == gpc->pfn)
+			new_khva = old_khva;
+		else
+			new_khva = gpc_map(new_pfn);
+
+		if (!new_khva) {
+			kvm_release_pfn_clean(new_pfn);
+			goto out_error;
 		}
 
 		write_lock_irq(&gpc->lock);
@@ -346,18 +309,12 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	return __kvm_gpc_refresh(gpc, gpc->gpa, len);
 }
 
-void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
-		  struct kvm_vcpu *vcpu, enum pfn_cache_usage usage)
+void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
 {
-	WARN_ON_ONCE(!usage || (usage & KVM_GUEST_AND_HOST_USE_PFN) != usage);
-	WARN_ON_ONCE((usage & KVM_GUEST_USES_PFN) && !vcpu);
-
 	rwlock_init(&gpc->lock);
 	mutex_init(&gpc->refresh_lock);
 
 	gpc->kvm = kvm;
-	gpc->vcpu = vcpu;
-	gpc->usage = usage;
 	gpc->pfn = KVM_PFN_ERR_FAULT;
 	gpc->uhva = KVM_HVA_ERR_BAD;
 }
-- 
2.39.2


