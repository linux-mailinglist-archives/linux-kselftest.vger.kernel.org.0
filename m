Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE6B22FA22
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jul 2020 22:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgG0Ud3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jul 2020 16:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0Ud3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jul 2020 16:33:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E8FC061794
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jul 2020 13:33:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w35so22121770ybi.16
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jul 2020 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8+GWCqToRsYuSGreGCapWzOVpnWd7snaZLCa1XNJr0I=;
        b=SGMEjLSsF+Ur+M/B7vxrNKGkbM9VGYJ4OL16bAu+jA4wlVRqUKmhkovlTjCvo5cwU9
         /GR6A4itCCVvgEwtK6ZdxnsEsFauXhRtDAeadxCpTuMTAFSYGn3km+Wp/WDZ5pV/gE4h
         5OPZoJf92JLkU7KvFmGXdg4/sOkHWtZBnadjwZtWWIw3EWWfeUUoEaQa7B/7pGV01SWb
         m1h0X+ZNhWSnCC/KQ7tVoclpMbFgTjvcOXkHZJ5eTjyTTCkc12F3Xg9ylL2tYHwxh9iF
         RMSKvHSOapmw+rwteyyXBBlypKDGCfdEQfDDkF+XzY69jwq96n38yxI8cUB000mfvGjj
         CEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8+GWCqToRsYuSGreGCapWzOVpnWd7snaZLCa1XNJr0I=;
        b=q0qwYg3gDzsqij/++6/TuYnQjLUIbE6OmeBRx5pN09861sIGGKT88Yzo17I4ZfwKL+
         c7K2MbPbmTbunRe0PibgvIxMP/dSGFb1fbjqIYMqohJS1rI7Du8MXf3zw6NeoOqOeF2Y
         3jKTrVAgBAAVACz504S6JY9OkilgNVPafWXkNqAxFKlh+uMopKST3X5l5r32q4iCz0PD
         DeVDFLAnP0kVs7+Isp70LVkFix7IN6oQP7VuUidolUTUUsz8L1oZfIs8PKFJquTkyzpX
         w2nzi4URWN0wUx6pOSV9ry3GQYogybM8XdkiZcX5Zd3raYqjON/JMqjHt4GBSYHP6diE
         QTaw==
X-Gm-Message-State: AOAM530vHhNUaOfqiXdRwjxkwwKSJtocI0HzEwdDwLbP636xJgCikMIh
        Dmcu31HVFmzSKOq8McAvu1mBjyunWPn9
X-Google-Smtp-Source: ABdhPJyJorpxq2jFPepAV9fDiih8wuRQXMoiV5SISAnOdfN1gBNWXGfdqI5rYs7ErSZFfzEXT7vNGuGHGtL8
X-Received: by 2002:a25:31d4:: with SMTP id x203mr37893178ybx.396.1595882008151;
 Mon, 27 Jul 2020 13:33:28 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:33:24 -0700
Message-Id: <20200727203324.2614917-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH 1/1] kvm: mmu: zap pages when zapping only parent
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When the KVM MMU zaps a page, it will recursively zap the unsynced child
pages, but not the synced ones. This can create problems over time when
running many nested guests because it leaves unlinked pages which will not
be freed until the page quota is hit. With the default page quota of 20
shadow pages per 1000 guest pages, this looks like a memory leak and can
degrade MMU performance.

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

If TDP is enabled, zap child shadow pages when zapping the only parent
shadow page.

Tested by running the kvm-unit-tests suite on an Intel Haswell machine.
No regressions versus
commit c34b26b98cac ("KVM: MIPS: clean up redundant 'kvm_run' parameters"),
or warnings.

Reviewed-by: Peter Shier <pshier@google.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 49 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index fa506aaaf0194..c550bc3831dcc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2626,13 +2626,52 @@ static bool mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 	return false;
 }
 
-static void kvm_mmu_page_unlink_children(struct kvm *kvm,
-					 struct kvm_mmu_page *sp)
+static int kvm_mmu_page_unlink_children(struct kvm *kvm,
+					struct kvm_mmu_page *sp,
+					struct list_head *invalid_list)
 {
 	unsigned i;
+	int zapped = 0;
+
+	for (i = 0; i < PT64_ENT_PER_PAGE; ++i) {
+		u64 *sptep = sp->spt + i;
+		u64 spte = *sptep;
+		struct kvm_mmu_page *child_sp;
+
+		/*
+		 * Zap the page table entry, unlinking any potential child
+		 * page
+		 */
+		mmu_page_zap_pte(kvm, sp, sptep);
+
+		/* If there is no child page for this spte, continue */
+		if (!is_shadow_present_pte(spte) ||
+		    is_last_spte(spte, sp->role.level))
+			continue;
+
+		/*
+		 * If TDP is enabled, then any shadow pages are part of either
+		 * the EPT01 or an EPT02. In either case, do not expect the
+		 * same pattern of page reuse seen in x86 PTs for
+		 * copy-on-write  and similar techniques. In this case, it is
+		 * unlikely that a parentless shadow PT will be used again in
+		 * the near future. Zap it to keep the rmaps and page hash
+		 * maps from filling up with stale EPT02 pages.
+		 */
+		if (!tdp_enabled)
+			continue;
+
+		child_sp = to_shadow_page(spte & PT64_BASE_ADDR_MASK);
+		if (WARN_ON_ONCE(!child_sp))
+			continue;
+
+		/* Zap the page if it has no remaining parent pages */
+		if (!child_sp->parent_ptes.val)
+			zapped += kvm_mmu_prepare_zap_page(kvm, child_sp,
+							   invalid_list);
+	}
 
-	for (i = 0; i < PT64_ENT_PER_PAGE; ++i)
-		mmu_page_zap_pte(kvm, sp, sp->spt + i);
+	return zapped;
 }
 
 static void kvm_mmu_unlink_parents(struct kvm *kvm, struct kvm_mmu_page *sp)
@@ -2678,7 +2717,7 @@ static bool __kvm_mmu_prepare_zap_page(struct kvm *kvm,
 	trace_kvm_mmu_prepare_zap_page(sp);
 	++kvm->stat.mmu_shadow_zapped;
 	*nr_zapped = mmu_zap_unsync_children(kvm, sp, invalid_list);
-	kvm_mmu_page_unlink_children(kvm, sp);
+	*nr_zapped += kvm_mmu_page_unlink_children(kvm, sp, invalid_list);
 	kvm_mmu_unlink_parents(kvm, sp);
 
 	/* Zapping children means active_mmu_pages has become unstable. */
-- 
2.28.0.rc0.142.g3c755180ce-goog

