Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E73A51512B1
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2020 00:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgBCXJQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Feb 2020 18:09:16 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:49305 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgBCXJQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Feb 2020 18:09:16 -0500
Received: by mail-pl1-f201.google.com with SMTP id w12so6998068ply.16
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2020 15:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XnYm5qWPfb13s0wRqn1mpnrTwR4nnQJCgFQ13dO6/nI=;
        b=f+ltTeOsJAty6dDVNXR6x/fkgqbS34nwR1S7fb/S8MIWpfYYBm2fIZFz3goe8MISee
         vZNyGnXM0oagrrqp6Fg4kXeLKM5vejK8Dc++ZDSPRw3zcAuP/EWeQo162pVO6i3YCBPB
         IJVaGCVG899JjEbedJ4bTkVCvbsaALE7QpXtogmZOM9bqAKXcq9Wfb4RxnmSX2axlB3J
         tS5jEbcaL83lUi3DDOfWKbBZks/EzKOh7y5k/ZSW/MGgfvYnGquJBrtRfqN8XTs960K+
         3OLgUJSt7opqlAM9aSC0EC/2GQOtIEfpqcGXIo5fKkbt6L5Nowyj/GFJbQltCI7whG94
         A07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XnYm5qWPfb13s0wRqn1mpnrTwR4nnQJCgFQ13dO6/nI=;
        b=TGrzdwtelsVgt5QYnzryyt152gajlOFIYNDyV7Qk6oqsqYYFTbFnNYIWc+0ozyW5qs
         zzTJ+6dbnxfNWcA4diJ3pCiLHjSwUbpe7RciJdaTo4nIpB5IJAEGHkzZQmn6UrAfdn44
         Va9rHpD2jwI0ksEKq4TZenCXXu0kk4/vGuNgjCEpoUmsGtYev6BQSsZYPJBzuls53ovE
         pvnmvuQ/0tcUqTmZzMTKZRfwSJyfeDYlZHPH5mNZYOnnkfU5n1tzoxrZ2ivwqYP4MsAf
         laUEzPRqF6tCBbk25qLAxkfEtsXtkTaQUkvtS6BUDpZ2q9nlkNkDcaSUlKuU1KI4/G9C
         ZMew==
X-Gm-Message-State: APjAAAW4CJQ9a7lxZW32//Mvxz5vOgEvafr7tqfdg1WcsSRp0RjHOlCE
        0JT+z0ezeaL9BorhsrOssDZaNBkAJGiy
X-Google-Smtp-Source: APXvYqwIpUOKIGZE6NcawbIowukoMFpqRz5bIJROxtcwVDgJozQwJ0dNygWwt5RTsmOYDdDiweDP4j8XLV/K
X-Received: by 2002:a63:3c2:: with SMTP id 185mr11545877pgd.72.1580771355857;
 Mon, 03 Feb 2020 15:09:15 -0800 (PST)
Date:   Mon,  3 Feb 2020 15:09:09 -0800
Message-Id: <20200203230911.39755-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 1/3] kvm: mmu: Replace unsigned with unsigned int for PTE access
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

There are several functions which pass an access permission mask for
SPTEs as an unsigned. This works, but checkpatch complains about it.
Switch the occurrences of unsigned to unsigned int to satisfy checkpatch.

No functional change expected.

Tested by running kvm-unit-tests on an Intel Haswell machine. This
commit introduced no new failures.

This commit can be viewed in Gerrit at:
	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2358

Signed-off-by: Ben Gardon <bgardon@google.com>
Reviewed-by: Oliver Upton <oupton@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 84eeb61d06aa3..a9c593dec49bf 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -452,7 +452,7 @@ static u64 get_mmio_spte_generation(u64 spte)
 }
 
 static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
-			   unsigned access)
+			   unsigned int access)
 {
 	u64 gen = kvm_vcpu_memslots(vcpu)->generation & MMIO_SPTE_GEN_MASK;
 	u64 mask = generation_mmio_spte_mask(gen);
@@ -484,7 +484,7 @@ static unsigned get_mmio_spte_access(u64 spte)
 }
 
 static bool set_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
-			  kvm_pfn_t pfn, unsigned access)
+			  kvm_pfn_t pfn, unsigned int access)
 {
 	if (unlikely(is_noslot_pfn(pfn))) {
 		mark_mmio_spte(vcpu, sptep, gfn, access);
@@ -2475,7 +2475,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 					     gva_t gaddr,
 					     unsigned level,
 					     int direct,
-					     unsigned access)
+					     unsigned int access)
 {
 	union kvm_mmu_page_role role;
 	unsigned quadrant;
@@ -2990,7 +2990,7 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
 #define SET_SPTE_NEED_REMOTE_TLB_FLUSH	BIT(1)
 
 static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
-		    unsigned pte_access, int level,
+		    unsigned int pte_access, int level,
 		    gfn_t gfn, kvm_pfn_t pfn, bool speculative,
 		    bool can_unsync, bool host_writable)
 {
@@ -3081,9 +3081,10 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 	return ret;
 }
 
-static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep, unsigned pte_access,
-			int write_fault, int level, gfn_t gfn, kvm_pfn_t pfn,
-		       	bool speculative, bool host_writable)
+static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
+			unsigned int pte_access, int write_fault, int level,
+			gfn_t gfn, kvm_pfn_t pfn, bool speculative,
+			bool host_writable)
 {
 	int was_rmapped = 0;
 	int rmap_count;
@@ -3165,7 +3166,7 @@ static int direct_pte_prefetch_many(struct kvm_vcpu *vcpu,
 {
 	struct page *pages[PTE_PREFETCH_NUM];
 	struct kvm_memory_slot *slot;
-	unsigned access = sp->role.access;
+	unsigned int access = sp->role.access;
 	int i, ret;
 	gfn_t gfn;
 
@@ -3400,7 +3401,8 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 }
 
 static bool handle_abnormal_pfn(struct kvm_vcpu *vcpu, gva_t gva, gfn_t gfn,
-				kvm_pfn_t pfn, unsigned access, int *ret_val)
+				kvm_pfn_t pfn, unsigned int access,
+				int *ret_val)
 {
 	/* The pfn is invalid, report the error! */
 	if (unlikely(is_error_pfn(pfn))) {
@@ -4005,7 +4007,7 @@ static int handle_mmio_page_fault(struct kvm_vcpu *vcpu, u64 addr, bool direct)
 
 	if (is_mmio_spte(spte)) {
 		gfn_t gfn = get_mmio_spte_gfn(spte);
-		unsigned access = get_mmio_spte_access(spte);
+		unsigned int access = get_mmio_spte_access(spte);
 
 		if (!check_mmio_spte(vcpu, spte))
 			return RET_PF_INVALID;
@@ -4349,7 +4351,7 @@ static void inject_page_fault(struct kvm_vcpu *vcpu,
 }
 
 static bool sync_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
-			   unsigned access, int *nr_present)
+			   unsigned int access, int *nr_present)
 {
 	if (unlikely(is_mmio_spte(*sptep))) {
 		if (gfn != get_mmio_spte_gfn(*sptep)) {
-- 
2.25.0.341.g760bfbb309-goog

