Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1693023C153
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Aug 2020 23:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHDVSt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Aug 2020 17:18:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:25527 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgHDVSs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Aug 2020 17:18:48 -0400
IronPort-SDR: 9LcTF7ZWoSA2TKv/tATLztz7IFmBoiUhQ6RzPtIIiYKPmLia+DN1ZDJzCLOzl2KslALLhtLn4P
 OArjT5pyYsJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="149856162"
X-IronPort-AV: E=Sophos;i="5.75,435,1589266800"; 
   d="scan'208,223";a="149856162"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 14:14:45 -0700
IronPort-SDR: s9YjZZBWjG5e6aJdDfVyX+cDOqgk/z2EpZKkEc28Xp7/3N+P0EUJTNbDS/VLAhp0CNPfpySdWY
 FvFoeZBQFuiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,435,1589266800"; 
   d="scan'208,223";a="324799402"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.160])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2020 14:14:45 -0700
Date:   Tue, 4 Aug 2020 14:14:45 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>
Subject: Re: [PATCH 1/1] kvm: mmu: zap pages when zapping only parent
Message-ID: <20200804211444.GA31916@linux.intel.com>
References: <20200727203324.2614917-1-bgardon@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20200727203324.2614917-1-bgardon@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 27, 2020 at 01:33:24PM -0700, Ben Gardon wrote:
> When the KVM MMU zaps a page, it will recursively zap the unsynced child
> pages, but not the synced ones. This can create problems over time when
> running many nested guests because it leaves unlinked pages which will not
> be freed until the page quota is hit. With the default page quota of 20
> shadow pages per 1000 guest pages, this looks like a memory leak and can
> degrade MMU performance.
> 
> In a recent benchmark, substantial performance degradation was observed:
> An L1 guest was booted with 64G memory.
> 2G nested Windows guests were booted, 10 at a time for 20
> iterations. (200 total boots)
> Windows was used in this benchmark because they touch all of their
> memory on startup.
> By the end of the benchmark, the nested guests were taking ~10% longer
> to boot. With this patch there is no degradation in boot time.
> Without this patch the benchmark ends with hundreds of thousands of
> stale EPT02 pages cluttering up rmaps and the page hash map. As a
> result, VM shutdown is also much slower: deleting memslot 0 was
> observed to take over a minute. With this patch it takes just a
> few miliseconds.
> 
> If TDP is enabled, zap child shadow pages when zapping the only parent
> shadow page.

Comments on the mechanics below.  For the approach itself, I wonder if we
could/should go even further, i.e. be even more aggressive in reaping nested
TDP shadow pages.

For this to work, KVM is effectively relying on the write flooding detection
in kvm_mmu_pte_write() to kick in, i.e. KVM needs the L1 VMM to overwrite
the TDP tables that L1 was using for L2.  In particular, L1 needs to write
the upper level TDP entries in order for L0 to effeciently reclaim memory.

For HyperV as L1, I believe that will happen sooner than later as HyperV
maintains a pool of zeroed pages, i.e. L1 will quickly zero out the old TDP
entries and trigger the zap.

For KVM as L1, that may not hold true for all scenarios due to lazy zeroing
of memory.  If L1 is creating and destroying VMs (as in the benchmark), then
it will work as expected.  But if L1 creates and destroys a large L2 without
reallocating all memory used for L2's TDP tables, the write flooding will
never happen and L0 will keep the stale SPs even though L2 is dead.

The above scenario may or may not be problematic in practice.  I would
assume any reasonably active L1 will quickly do something with the old TDP
memory and trigger write flooding, but at the same time it's plausible that
L1 could leave pages unused for a decent amount of time.

One thought would be to track nested TDP PGDs and periodically purge PGDs
that haven't been used in some arbitrary amount of time and/or an arbitrary
threshold for the number of nested TDP PGDs is reached.  That being said,
either of those is probably overkill without more analysis on the below
approach.

> Tested by running the kvm-unit-tests suite on an Intel Haswell machine.
> No regressions versus
> commit c34b26b98cac ("KVM: MIPS: clean up redundant 'kvm_run' parameters"),
> or warnings.
> 
> Reviewed-by: Peter Shier <pshier@google.com>
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 49 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index fa506aaaf0194..c550bc3831dcc 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2626,13 +2626,52 @@ static bool mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
>  	return false;
>  }
>  
> -static void kvm_mmu_page_unlink_children(struct kvm *kvm,
> -					 struct kvm_mmu_page *sp)
> +static int kvm_mmu_page_unlink_children(struct kvm *kvm,
> +					struct kvm_mmu_page *sp,
> +					struct list_head *invalid_list)
>  {
>  	unsigned i;
> +	int zapped = 0;
> +
> +	for (i = 0; i < PT64_ENT_PER_PAGE; ++i) {
> +		u64 *sptep = sp->spt + i;
> +		u64 spte = *sptep;
> +		struct kvm_mmu_page *child_sp;
> +
> +		/*
> +		 * Zap the page table entry, unlinking any potential child
> +		 * page
> +		 */
> +		mmu_page_zap_pte(kvm, sp, sptep);
> +
> +		/* If there is no child page for this spte, continue */
> +		if (!is_shadow_present_pte(spte) ||
> +		    is_last_spte(spte, sp->role.level))
> +			continue;
> +
> +		/*
> +		 * If TDP is enabled, then any shadow pages are part of either
> +		 * the EPT01 or an EPT02. In either case, do not expect the
> +		 * same pattern of page reuse seen in x86 PTs for
> +		 * copy-on-write  and similar techniques. In this case, it is
> +		 * unlikely that a parentless shadow PT will be used again in
> +		 * the near future. Zap it to keep the rmaps and page hash
> +		 * maps from filling up with stale EPT02 pages.
> +		 */
> +		if (!tdp_enabled)
> +			continue;

I haven't tested, but I believe this will have the unwanted side effect of
blasting large swaths of EPT01 if recycling is triggered.  Because the list
of active SPs is FIFO (and never reordered), the first entries are almost
always the root SP and then high level SPs.  If make_mmu_pages_available()
triggers kvm_mmu_zap_oldest_mmu_pages(), this is take out the high level SP
and all its children.

That may or may not be a problem in practice, but it's outside the scope of
what this patch is trying to accomplish.

TL;DR: what about further conditioning this on sp->role.guest_mode?

> +
> +		child_sp = to_shadow_page(spte & PT64_BASE_ADDR_MASK);
> +		if (WARN_ON_ONCE(!child_sp))

This WARN is pointless, mmu_page_zap_pte() above will already have dereferenced
the child shadow page, i.e. any null pointer will have exploded.

> +			continue;
> +
> +		/* Zap the page if it has no remaining parent pages */
> +		if (!child_sp->parent_ptes.val)

IMO it's easier to read if these checks are collapsed, e.g.:

		if (!tdp_enabled || !child_sp->role.guest_mode ||
		    child_sp->parent_ptes.val)
			continue;

		zapped += kvm_mmu_prepare_zap_page(kvm, child_sp, invalid_list);


Alternatively, what about moving this logic into mmu_page_zap_pte()?  That
can be done with a little massaging of FNAME(invlpg) and would avoid what is
effectively redundant checks on is_shadow_present_pte() and is_last_spte().
Patches attached and somewhat tested.

> +			zapped += kvm_mmu_prepare_zap_page(kvm, child_sp,
> +							   invalid_list);
> +	}
>  
> -	for (i = 0; i < PT64_ENT_PER_PAGE; ++i)
> -		mmu_page_zap_pte(kvm, sp, sp->spt + i);
> +	return zapped;
>  }
>  
>  static void kvm_mmu_unlink_parents(struct kvm *kvm, struct kvm_mmu_page *sp)
> @@ -2678,7 +2717,7 @@ static bool __kvm_mmu_prepare_zap_page(struct kvm *kvm,
>  	trace_kvm_mmu_prepare_zap_page(sp);
>  	++kvm->stat.mmu_shadow_zapped;
>  	*nr_zapped = mmu_zap_unsync_children(kvm, sp, invalid_list);
> -	kvm_mmu_page_unlink_children(kvm, sp);
> +	*nr_zapped += kvm_mmu_page_unlink_children(kvm, sp, invalid_list);
>  	kvm_mmu_unlink_parents(kvm, sp);
>  
>  	/* Zapping children means active_mmu_pages has become unstable. */
> -- 
> 2.28.0.rc0.142.g3c755180ce-goog
> 

--cNdxnHkX5QqsyA0e
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-KVM-x86-mmu-Move-flush-logic-from-mmu_page_zap_pte-t.patch"

From b1964178d9b6abadd33531a5dd7788368f89bc40 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <sean.j.christopherson@intel.com>
Date: Tue, 4 Aug 2020 09:14:21 -0700
Subject: [PATCH 1/2] KVM: x86/mmu: Move flush logic from mmu_page_zap_pte() to
 FNAME(invlpg)

Move the logic that controls whether or not FNAME(invlpg) needs to flush
fully into FNAME(invlpg) so that mmu_page_zap_pte() doesn't return a
value.  This allows a future patch to redefine the return semantics for
mmu_page_zap_pte() so that it can recursively zap orphaned child shadow
pages for nested TDP MMUs.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c         | 10 +++-------
 arch/x86/kvm/mmu/paging_tmpl.h |  7 +++++--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 862bf418214e2..bdc10a53cd6ad 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2614,7 +2614,7 @@ static void validate_direct_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 	}
 }
 
-static bool mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
+static void mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 			     u64 *spte)
 {
 	u64 pte;
@@ -2630,13 +2630,9 @@ static bool mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 			child = to_shadow_page(pte & PT64_BASE_ADDR_MASK);
 			drop_parent_pte(child, spte);
 		}
-		return true;
-	}
-
-	if (is_mmio_spte(pte))
+	} else if (is_mmio_spte(pte)) {
 		mmu_spte_clear_no_track(spte);
-
-	return false;
+	}
 }
 
 static void kvm_mmu_page_unlink_children(struct kvm *kvm,
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 0172a949f6a75..1fe7edc5732da 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -895,6 +895,7 @@ static void FNAME(invlpg)(struct kvm_vcpu *vcpu, gva_t gva, hpa_t root_hpa)
 {
 	struct kvm_shadow_walk_iterator iterator;
 	struct kvm_mmu_page *sp;
+	u64 old_spte;
 	int level;
 	u64 *sptep;
 
@@ -917,7 +918,8 @@ static void FNAME(invlpg)(struct kvm_vcpu *vcpu, gva_t gva, hpa_t root_hpa)
 		sptep = iterator.sptep;
 
 		sp = sptep_to_sp(sptep);
-		if (is_last_spte(*sptep, level)) {
+		old_spte = *sptep;
+		if (is_last_spte(old_spte, level)) {
 			pt_element_t gpte;
 			gpa_t pte_gpa;
 
@@ -927,7 +929,8 @@ static void FNAME(invlpg)(struct kvm_vcpu *vcpu, gva_t gva, hpa_t root_hpa)
 			pte_gpa = FNAME(get_level1_sp_gpa)(sp);
 			pte_gpa += (sptep - sp->spt) * sizeof(pt_element_t);
 
-			if (mmu_page_zap_pte(vcpu->kvm, sp, sptep))
+			mmu_page_zap_pte(vcpu->kvm, sp, sptep);
+			if (is_shadow_present_pte(old_spte))
 				kvm_flush_remote_tlbs_with_address(vcpu->kvm,
 					sp->gfn, KVM_PAGES_PER_HPAGE(sp->role.level));
 
-- 
2.28.0


--cNdxnHkX5QqsyA0e
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-KVM-x86-MMU-Recursively-zap-nested-TDP-SPs-when-zapp.patch"

From 848917abc9c928df254d77a6fa5a5d874461975e Mon Sep 17 00:00:00 2001
From: Ben Gardon <bgardon@google.com>
Date: Tue, 4 Aug 2020 10:02:17 -0700
Subject: [PATCH 2/2] KVM: x86/MMU: Recursively zap nested TDP SPs when zapping
 last/only parent

Recursively zap all to-be-orphaned children, unsynced or otherwise, when
zapping a shadow page for a nested TDP MMU.  KVM currently only zaps the
unsynced child pages, but not the synced ones.  This can create problems
over time when running many nested guests because it leaves unlinked
pages which will not be freed until the page quota is hit. With the
default page quota of 20 shadow pages per 1000 guest pages, this looks
like a memory leak and can degrade MMU performance.

In a recent benchmark, substantial performance degradation was observed:
An L1 guest was booted with 64G memory.
2G nested Windows guests were booted, 10 at a time for 20
iterations. (200 total boots)
Windows was used in this benchmark because they touch all of their
memory on startup.
By the end of the benchmark, the nested guests were taking ~10% longer
to boot. With this patch there is no degradation in boot time.
Without this patch the benchmark ends with hundreds of thousands of
stale EPT02 pages cluttering up rmaps and the page hash map. As a
result, VM shutdown is also much slower: deleting memslot 0 was
observed to take over a minute. With this patch it takes just a
few miliseconds.

Cc: Peter Shier <pshier@google.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c         | 30 +++++++++++++++++++++++-------
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index bdc10a53cd6ad..11d3c6ec608ef 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2614,8 +2614,9 @@ static void validate_direct_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 	}
 }
 
-static void mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
-			     u64 *spte)
+/* Returns the number of zapped non-leaf child shadow pages. */
+static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
+			    u64 *spte, struct list_head *invalid_list)
 {
 	u64 pte;
 	struct kvm_mmu_page *child;
@@ -2629,19 +2630,34 @@ static void mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 		} else {
 			child = to_shadow_page(pte & PT64_BASE_ADDR_MASK);
 			drop_parent_pte(child, spte);
+
+			/*
+			 * Recursively zap nested TDP SPs, parentless SPs are
+			 * unlikely to be used again in the near future.  This
+			 * avoids retaining a large number of stale nested SPs.
+			 */
+			if (tdp_enabled && invalid_list &&
+			    child->role.guest_mode && !child->parent_ptes.val)
+				return kvm_mmu_prepare_zap_page(kvm, child,
+								invalid_list);
 		}
 	} else if (is_mmio_spte(pte)) {
 		mmu_spte_clear_no_track(spte);
 	}
+	return 0;
 }
 
-static void kvm_mmu_page_unlink_children(struct kvm *kvm,
-					 struct kvm_mmu_page *sp)
+static int kvm_mmu_page_unlink_children(struct kvm *kvm,
+					struct kvm_mmu_page *sp,
+					struct list_head *invalid_list)
 {
+	int zapped = 0;
 	unsigned i;
 
 	for (i = 0; i < PT64_ENT_PER_PAGE; ++i)
-		mmu_page_zap_pte(kvm, sp, sp->spt + i);
+		zapped += mmu_page_zap_pte(kvm, sp, sp->spt + i, invalid_list);
+
+	return zapped;
 }
 
 static void kvm_mmu_unlink_parents(struct kvm *kvm, struct kvm_mmu_page *sp)
@@ -2687,7 +2703,7 @@ static bool __kvm_mmu_prepare_zap_page(struct kvm *kvm,
 	trace_kvm_mmu_prepare_zap_page(sp);
 	++kvm->stat.mmu_shadow_zapped;
 	*nr_zapped = mmu_zap_unsync_children(kvm, sp, invalid_list);
-	kvm_mmu_page_unlink_children(kvm, sp);
+	*nr_zapped += kvm_mmu_page_unlink_children(kvm, sp, invalid_list);
 	kvm_mmu_unlink_parents(kvm, sp);
 
 	/* Zapping children means active_mmu_pages has become unstable. */
@@ -5395,7 +5411,7 @@ static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
 			u32 base_role = vcpu->arch.mmu->mmu_role.base.word;
 
 			entry = *spte;
-			mmu_page_zap_pte(vcpu->kvm, sp, spte);
+			mmu_page_zap_pte(vcpu->kvm, sp, spte, NULL);
 			if (gentry &&
 			    !((sp->role.word ^ base_role) & ~role_ign.word) &&
 			    rmap_can_add(vcpu))
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 1fe7edc5732da..58ae852a9615b 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -929,7 +929,7 @@ static void FNAME(invlpg)(struct kvm_vcpu *vcpu, gva_t gva, hpa_t root_hpa)
 			pte_gpa = FNAME(get_level1_sp_gpa)(sp);
 			pte_gpa += (sptep - sp->spt) * sizeof(pt_element_t);
 
-			mmu_page_zap_pte(vcpu->kvm, sp, sptep);
+			mmu_page_zap_pte(vcpu->kvm, sp, sptep, NULL);
 			if (is_shadow_present_pte(old_spte))
 				kvm_flush_remote_tlbs_with_address(vcpu->kvm,
 					sp->gfn, KVM_PAGES_PER_HPAGE(sp->role.level));
-- 
2.28.0


--cNdxnHkX5QqsyA0e--
