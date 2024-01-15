Return-Path: <linux-kselftest+bounces-2984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F090B82D9BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 14:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF781C21826
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 13:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A543218C03;
	Mon, 15 Jan 2024 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="fMdOW6y8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716E817C69;
	Mon, 15 Jan 2024 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=G1MUmXqcUNbndfoB441ogomDIdc1jFzjEaJbDsyBneM=; b=fMdOW6y8mLDlhil3ydDLY0Yg5B
	7nXngyRdTXYnL8FwuVifLBcVIGr5fZ0Jg/uuWK0v2Rx+pyMfPcPKR1XRtFhKZgn0Ay3T2hGh33jE3
	CANrdtp3/yiQzphOC1uYK38NdrSCtTMzb8HFO5x2g8XfNJ5ehDSQZFUQfLpJ9SYHzHJU=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rPMiZ-00035m-1u; Mon, 15 Jan 2024 13:09:31 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rPMXk-0002kM-Fg; Mon, 15 Jan 2024 12:58:20 +0000
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
Subject: [PATCH v12 20/20] KVM: pfncache: rework __kvm_gpc_refresh() to fix locking issues
Date: Mon, 15 Jan 2024 12:57:07 +0000
Message-Id: <20240115125707.1183-21-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115125707.1183-1-paul@xen.org>
References: <20240115125707.1183-1-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: David Woodhouse <dwmw@amazon.co.uk>

This function can race with kvm_gpc_deactivate(), which does not take
the ->refresh_lock. This means kvm_gpc_deactivate() can wipe the ->pfn
and ->khva fields, and unmap the latter, while hva_to_pfn_retry() has
temporarily dropped its write lock on gpc->lock.

Then if hva_to_pfn_retry() determines that the PFN hasn't changed and
that the original pfn and khva can be reused, they get assigned back to
gpc->pfn and gpc->khva even though the khva was already unmapped by
kvm_gpc_deactivate(). This leaves the cache in an apparently valid state
but with ->khva pointing to an address which has been unmapped. Which in
turn leads to oopses in e.g. __kvm_xen_has_interrupt() and
set_shinfo_evtchn_pending() when they dereference said khva.

It may be possible to fix this just by making kvm_gpc_deactivate() take
the ->refresh_lock, but that still leaves ->refresh_lock being basically
redundant with the write lock on ->lock, which frankly makes my skin
itch, with the way that pfn_to_hva_retry() operates on fields in the gpc
without holding a write lock on ->lock.

Instead, fix it by cleaning up the semantics of hva_to_pfn_retry(). It
now no longer does locking gymnastics because it no longer operates on
the gpc object at all. I's called with a uhva and simply returns the
corresponding pfn (pinned), and a mapped khva for it.

Its caller __kvm_gpc_refresh() now sets gpc->uhva and clears gpc->valid
before dropping ->lock, calling hva_to_pfn_retry() and retaking ->lock
for write.

If hva_to_pfn_retry() fails, *or* if the ->uhva or ->active fields in
the gpc changed while the lock was dropped, the new mapping is discarded
and the gpc is not modified. On success with an unchanged gpc, the new
mapping is installed and the current ->pfn and ->uhva are taken into the
local old_pfn and old_khva variables to be unmapped once the locks are
all released.

This simplification means that ->refresh_lock is no longer needed for
correctness, but it does still provide a minor optimisation because it
will prevent two concurrent __kvm_gpc_refresh() calls from mapping a
given PFN, only for one of them to lose the race and discard its
mapping.

The optimisation in hva_to_pfn_retry() where it attempts to use the old
mapping if the pfn doesn't change is dropped, since it makes the pinning
more complex. It's a pointless optimisation anyway, since the odds of
the pfn ending up the same when the uhva has changed (i.e. the odds of
the two userspace addresses both pointing to the same underlying
physical page) are negligible,

The 'hva_changed' local variable in __kvm_gpc_refresh() is also removed,
since it's simpler just to clear gpc->valid if the uhva changed.
Likewise the unmap_old variable is dropped because it's just as easy to
check the old_pfn variable for KVM_PFN_ERR_FAULT.

I remain slightly confused because although this is clearly a race in
the gfn_to_pfn_cache code, I don't quite know how the Xen support code
actually managed to trigger it. We've seen oopses from dereferencing a
valid-looking ->khva in both __kvm_xen_has_interrupt() (the vcpu_info)
and in set_shinfo_evtchn_pending() (the shared_info). But surely the
race shouldn't happen for the vcpu_info gpc because all calls to both
refresh and deactivate hold the vcpu mutex, and it shouldn't happen
for the shared_info gpc because all calls to both will hold the
kvm->arch.xen.xen_lock mutex.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

v12:
 - New in this version.
---
 virt/kvm/pfncache.c | 184 +++++++++++++++++++++-----------------------
 1 file changed, 88 insertions(+), 96 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 70394d7c9a38..4863f9f3d369 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -135,110 +135,67 @@ static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_s
 	return kvm->mmu_invalidate_seq != mmu_seq;
 }
 
-static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
+/*
+ * Given a user virtual address, obtain a pinned host PFN and kernel mapping
+ * for it. The caller will release the PFN after installing it into the GPC
+ * so that the MMU notifier invalidation mechanism is active.
+ */
+static kvm_pfn_t hva_to_pfn_retry(struct kvm *kvm, unsigned long uhva,
+				  kvm_pfn_t *pfn, void **khva)
 {
 	/* Note, the new page offset may be different than the old! */
-	void *old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
 	kvm_pfn_t new_pfn = KVM_PFN_ERR_FAULT;
 	void *new_khva = NULL;
 	unsigned long mmu_seq;
 
-	lockdep_assert_held(&gpc->refresh_lock);
-
-	lockdep_assert_held_write(&gpc->lock);
-
-	/*
-	 * Invalidate the cache prior to dropping gpc->lock, the gpa=>uhva
-	 * assets have already been updated and so a concurrent check() from a
-	 * different task may not fail the gpa/uhva/generation checks.
-	 */
-	gpc->valid = false;
-
-	do {
-		mmu_seq = gpc->kvm->mmu_invalidate_seq;
+	for (;;) {
+		mmu_seq = kvm->mmu_invalidate_seq;
 		smp_rmb();
 
-		write_unlock_irq(&gpc->lock);
-
-		/*
-		 * If the previous iteration "failed" due to an mmu_notifier
-		 * event, release the pfn and unmap the kernel virtual address
-		 * from the previous attempt.  Unmapping might sleep, so this
-		 * needs to be done after dropping the lock.  Opportunistically
-		 * check for resched while the lock isn't held.
-		 */
-		if (new_pfn != KVM_PFN_ERR_FAULT) {
-			/*
-			 * Keep the mapping if the previous iteration reused
-			 * the existing mapping and didn't create a new one.
-			 */
-			if (new_khva != old_khva)
-				gpc_unmap(new_pfn, new_khva);
-
-			kvm_release_pfn_clean(new_pfn);
-
-			cond_resched();
-		}
-
 		/* We always request a writeable mapping */
-		new_pfn = hva_to_pfn(gpc->uhva, false, false, NULL, true, NULL);
+		new_pfn = hva_to_pfn(uhva, false, false, NULL, true, NULL);
 		if (is_error_noslot_pfn(new_pfn))
-			goto out_error;
+			return -EFAULT;
 
 		/*
-		 * Obtain a new kernel mapping if KVM itself will access the
-		 * pfn.  Note, kmap() and memremap() can both sleep, so this
-		 * too must be done outside of gpc->lock!
+		 * Always obtain a new kernel mapping. Trying to reuse an
+		 * existing one is more complex than it's worth.
 		 */
-		if (new_pfn == gpc->pfn)
-			new_khva = old_khva;
-		else
-			new_khva = gpc_map(new_pfn);
-
+		new_khva = gpc_map(new_pfn);
 		if (!new_khva) {
 			kvm_release_pfn_clean(new_pfn);
-			goto out_error;
+			return -EFAULT;
 		}
 
-		write_lock_irq(&gpc->lock);
+		if (!mmu_notifier_retry_cache(kvm, mmu_seq))
+			break;
 
 		/*
-		 * Other tasks must wait for _this_ refresh to complete before
-		 * attempting to refresh.
+		 * If this iteration "failed" due to an mmu_notifier event,
+		 * release the pfn and unmap the kernel virtual address, and
+		 * loop around again.
 		 */
-		WARN_ON_ONCE(gpc->valid);
-	} while (mmu_notifier_retry_cache(gpc->kvm, mmu_seq));
-
-	gpc->valid = true;
-	gpc->pfn = new_pfn;
-	gpc->khva = new_khva + offset_in_page(gpc->uhva);
+		if (new_pfn != KVM_PFN_ERR_FAULT) {
+			gpc_unmap(new_pfn, new_khva);
+			kvm_release_pfn_clean(new_pfn);
+		}
+	}
 
-	/*
-	 * Put the reference to the _new_ pfn.  The pfn is now tracked by the
-	 * cache and can be safely migrated, swapped, etc... as the cache will
-	 * invalidate any mappings in response to relevant mmu_notifier events.
-	 */
-	kvm_release_pfn_clean(new_pfn);
+	*pfn = new_pfn;
+	*khva = new_khva;
 
 	return 0;
-
-out_error:
-	write_lock_irq(&gpc->lock);
-
-	return -EFAULT;
 }
 
-static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
-			     unsigned long len)
+static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
+			     unsigned long uhva, unsigned long len)
 {
 	struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
 	unsigned long page_offset = (gpa != KVM_XEN_INVALID_GPA) ?
 		offset_in_page(gpa) :
 		offset_in_page(uhva);
-	bool unmap_old = false;
 	unsigned long old_uhva;
-	kvm_pfn_t old_pfn;
-	bool hva_change = false;
+	kvm_pfn_t old_pfn = KVM_PFN_ERR_FAULT;
 	void *old_khva;
 	int ret;
 
@@ -251,8 +208,9 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 
 	/*
 	 * If another task is refreshing the cache, wait for it to complete.
-	 * There is no guarantee that concurrent refreshes will see the same
-	 * gpa, memslots generation, etc..., so they must be fully serialized.
+	 * This is purely an optimisation, to avoid concurrent mappings from
+	 * hva_to_pfn_retry(), all but one of which will be discarded after
+	 * losing a race to install them in the GPC.
 	 */
 	mutex_lock(&gpc->refresh_lock);
 
@@ -272,7 +230,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 		gpc->uhva = PAGE_ALIGN_DOWN(uhva);
 
 		if (gpc->uhva != old_uhva)
-			hva_change = true;
+			gpc->valid = false;
 	} else if (gpc->gpa != gpa ||
 		   gpc->generation != slots->generation ||
 		   kvm_is_error_hva(gpc->uhva)) {
@@ -285,7 +243,11 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 
 		if (kvm_is_error_hva(gpc->uhva)) {
 			ret = -EFAULT;
-			goto out;
+
+			gpc->valid = false;
+			gpc->pfn = KVM_PFN_ERR_FAULT;
+			gpc->khva = NULL;
+			goto out_unlock;
 		}
 
 		/*
@@ -293,7 +255,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 		 * HVA may still be the same.
 		 */
 		if (gpc->uhva != old_uhva)
-			hva_change = true;
+			gpc->valid = false;
 	} else {
 		gpc->uhva = old_uhva;
 	}
@@ -305,9 +267,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 	 * If the userspace HVA changed or the PFN was already invalid,
 	 * drop the lock and do the HVA to PFN lookup again.
 	 */
-	if (!gpc->valid || hva_change) {
-		ret = hva_to_pfn_retry(gpc);
-	} else {
+	if (gpc->valid) {
 		/*
 		 * If the HVA→PFN mapping was already valid, don't unmap it.
 		 * But do update gpc->khva because the offset within the page
@@ -315,30 +275,62 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 		 */
 		gpc->khva = old_khva + page_offset;
 		ret = 0;
-		goto out_unlock;
-	}
 
- out:
-	/*
-	 * Invalidate the cache and purge the pfn/khva if the refresh failed.
-	 * Some/all of the uhva, gpa, and memslot generation info may still be
-	 * valid, leave it as is.
-	 */
-	if (ret) {
+		/* old_pfn must not be unmapped because it was reused. */
+		old_pfn = KVM_PFN_ERR_FAULT;
+	} else {
+		kvm_pfn_t new_pfn = KVM_PFN_ERR_FAULT;
+		unsigned long new_uhva = gpc->uhva;
+		void *new_khva = NULL;
+
+		/*
+		 * Invalidate the cache prior to dropping gpc->lock; the
+		 * gpa=>uhva assets have already been updated and so a
+		 * concurrent check() from a different task may not fail
+		 * the gpa/uhva/generation checks as it should.
+		 */
 		gpc->valid = false;
-		gpc->pfn = KVM_PFN_ERR_FAULT;
-		gpc->khva = NULL;
-	}
 
-	/* Detect a pfn change before dropping the lock! */
-	unmap_old = (old_pfn != gpc->pfn);
+		write_unlock_irq(&gpc->lock);
+
+		ret = hva_to_pfn_retry(gpc->kvm, new_uhva, &new_pfn, &new_khva);
+
+		write_lock_irq(&gpc->lock);
+
+		WARN_ON_ONCE(gpc->valid);
+
+		if (ret || !gpc->active || gpc->uhva != new_uhva) {
+			/*
+			 * On failure or if another change occurred while the
+			 * lock was dropped, just purge the new mapping.
+			 */
+			old_pfn = new_pfn;
+			old_khva = new_khva;
+		} else {
+			old_pfn = gpc->pfn;
+			old_khva = gpc->khva;
+
+			gpc->pfn = new_pfn;
+			gpc->khva = new_khva + offset_in_page(gpc->uhva);
+			gpc->valid = true;
+		}
+
+		/*
+		 * Put the reference to the _new_ pfn. On success, the
+		 * pfn is now tracked by the cache and can safely be
+		 * migrated, swapped, etc. as the cache will invalidate
+		 * any mappings in response to relevant mmu_notifier
+		 * events.
+		 */
+		kvm_release_pfn_clean(new_pfn);
+	}
 
 out_unlock:
 	write_unlock_irq(&gpc->lock);
 
 	mutex_unlock(&gpc->refresh_lock);
 
-	if (unmap_old)
+	if (old_pfn != KVM_PFN_ERR_FAULT)
 		gpc_unmap(old_pfn, old_khva);
 
 	return ret;
-- 
2.39.2


