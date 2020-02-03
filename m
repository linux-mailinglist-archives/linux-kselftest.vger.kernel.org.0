Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7341512B5
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2020 00:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgBCXJV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Feb 2020 18:09:21 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43156 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgBCXJV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Feb 2020 18:09:21 -0500
Received: by mail-pf1-f202.google.com with SMTP id x199so10281176pfc.10
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2020 15:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RjINtf+1IbJq55a0Ed6ZN6M3Wb8hRnnefI63Cx3MO7Q=;
        b=QUCkYlSNVhLhOTJ0mmNYyS24kEWPAb3E8yra1v2H8umaNEH2T+QeCUD2qC+IUDMxqX
         37fRa7vI4Fsr31SXnZvsMb4kutN/Coz+zQzU7M6EaAdzJzo2qiIRUyZLpu8wj4svKaVe
         VbvBJr/TvUwYhTewt4d+jJRXpQKR7XDLTTj/KZ5g9UB6eid/2yHU+gjLAsItWkaZ8aY0
         eHZAsqvA8kRo7hh+RQVYcrjHYzderaxahHKIbgqFqufzjYChQ+He9+BLxnn6TZtFTTqN
         36R7GTcPxPdMWo8n+y3atn/Wigamg36uD/ptLBxySNx9mF+yEXWhRroPvu02i0xfHKZZ
         D6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RjINtf+1IbJq55a0Ed6ZN6M3Wb8hRnnefI63Cx3MO7Q=;
        b=Y1lz/MIu3+h7+7XY0O8+JwGeH0s4VZTTpIWTlUfyAoxPKKGXsRwqY8Sf/yz2dpe3Of
         fGvVhkMEq51ODfholcy71c/4OiW4InbA1Afxw7tSaf/k6bTYXhj1UdU06AHW7+dPVfN8
         vQ8bopNzshbmiW7rzohXcfY1niXnD08OCWcl9K48uXbytuZKu1FqCYC1JCY/lTkveaEc
         9HRURSXWYU5c9aZeUdSoZrUi7hpCxODet1zWOK4YBZSKnpXPvxNPf6R/me7WDeU0Vinv
         LXwVwVD2S+ynrADCz5bQJuN23kw6+aLZLFRBPoJwe1lODXK5jNy7umCzHu32aHXWKbnR
         Vs0Q==
X-Gm-Message-State: APjAAAUSYF5AK4GFytd5sFZWXrZzlkkbZrtz4cvldTgJIDG3iQPOvyxI
        pEH6mupuKwE7u6TbNv8+yJWgwchmlZAI
X-Google-Smtp-Source: APXvYqwB8CnUgcoaQEPeq8AOsAR7CQC2zvfiaZ9Mq/eDGhQUW4hp4wi0EUJhhdwa3V8/FBqTPUrf3IjlDIxK
X-Received: by 2002:a63:cd15:: with SMTP id i21mr22156938pgg.453.1580771359996;
 Mon, 03 Feb 2020 15:09:19 -0800 (PST)
Date:   Mon,  3 Feb 2020 15:09:11 -0800
In-Reply-To: <20200203230911.39755-1-bgardon@google.com>
Message-Id: <20200203230911.39755-3-bgardon@google.com>
Mime-Version: 1.0
References: <20200203230911.39755-1-bgardon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 3/3] kvm: mmu: Separate pte generation from set_spte
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Separate the functions for generating leaf page table entries from the
function that inserts them into the paging structure. This refactoring
will facilitate changes to the MMU sychronization model to use atomic
compare / exchanges (which are not guaranteed to succeed) instead of a
monolithic MMU lock.

No functional change expected.

Tested by running kvm-unit-tests on an Intel Haswell machine. This
commit introduced no new failures.

This commit can be viewed in Gerrit at:
	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2360

Signed-off-by: Ben Gardon <bgardon@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 52 +++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b81010d0edae1..9239ad5265dc6 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3000,20 +3000,14 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
 #define SET_SPTE_WRITE_PROTECTED_PT	BIT(0)
 #define SET_SPTE_NEED_REMOTE_TLB_FLUSH	BIT(1)
 
-static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
-		    unsigned int pte_access, int level,
-		    gfn_t gfn, kvm_pfn_t pfn, bool speculative,
-		    bool can_unsync, bool host_writable)
+static u64 make_spte(struct kvm_vcpu *vcpu, unsigned int pte_access, int level,
+		     gfn_t gfn, kvm_pfn_t pfn, u64 old_spte, bool speculative,
+		     bool can_unsync, bool host_writable, bool ad_disabled,
+		     int *ret)
 {
 	u64 spte = 0;
-	int ret = 0;
-	struct kvm_mmu_page *sp;
-
-	if (set_mmio_spte(vcpu, sptep, gfn, pfn, pte_access))
-		return 0;
 
-	sp = page_header(__pa(sptep));
-	if (sp_ad_disabled(sp))
+	if (ad_disabled)
 		spte |= SPTE_AD_DISABLED_MASK;
 	else if (kvm_vcpu_ad_need_write_protect(vcpu))
 		spte |= SPTE_AD_WRPROT_ONLY_MASK;
@@ -3066,27 +3060,49 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 		 * is responsibility of mmu_get_page / kvm_sync_page.
 		 * Same reasoning can be applied to dirty page accounting.
 		 */
-		if (!can_unsync && is_writable_pte(*sptep))
-			goto set_pte;
+		if (!can_unsync && is_writable_pte(old_spte))
+			return spte;
 
 		if (mmu_need_write_protect(vcpu, gfn, can_unsync)) {
 			pgprintk("%s: found shadow page for %llx, marking ro\n",
 				 __func__, gfn);
-			ret |= SET_SPTE_WRITE_PROTECTED_PT;
+			*ret |= SET_SPTE_WRITE_PROTECTED_PT;
 			pte_access &= ~ACC_WRITE_MASK;
 			spte &= ~(PT_WRITABLE_MASK | SPTE_MMU_WRITEABLE);
 		}
 	}
 
-	if (pte_access & ACC_WRITE_MASK) {
-		kvm_vcpu_mark_page_dirty(vcpu, gfn);
+	if (pte_access & ACC_WRITE_MASK)
 		spte |= spte_shadow_dirty_mask(spte);
-	}
 
 	if (speculative)
 		spte = mark_spte_for_access_track(spte);
 
-set_pte:
+	return spte;
+}
+
+static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
+		    unsigned int pte_access, int level,
+		    gfn_t gfn, kvm_pfn_t pfn, bool speculative,
+		    bool can_unsync, bool host_writable)
+{
+	u64 spte = 0;
+	struct kvm_mmu_page *sp;
+	int ret = 0;
+
+	if (set_mmio_spte(vcpu, sptep, gfn, pfn, pte_access))
+		return 0;
+
+	sp = page_header(__pa(sptep));
+
+	spte = make_spte(vcpu, pte_access, level, gfn, pfn, *sptep, speculative,
+			 can_unsync, host_writable, sp_ad_disabled(sp), &ret);
+	if (!spte)
+		return 0;
+
+	if (spte & PT_WRITABLE_MASK)
+		kvm_vcpu_mark_page_dirty(vcpu, gfn);
+
 	if (mmu_spte_update(sptep, spte))
 		ret |= SET_SPTE_NEED_REMOTE_TLB_FLUSH;
 	return ret;
-- 
2.25.0.341.g760bfbb309-goog

