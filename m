Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B1E2CC892
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 22:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgLBVEW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 16:04:22 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:44310 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729373AbgLBVEW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 16:04:22 -0500
X-Greylist: delayed 1671 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Dec 2020 16:04:20 EST
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.93.0.4)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1kkYqj-0004aI-SE; Wed, 02 Dec 2020 21:35:41 +0100
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: kvm/set_memory_region_test: Fix race in move region test
Date:   Wed,  2 Dec 2020 21:35:36 +0100
Message-Id: <0fdddb94bb0e31b7da129a809a308d91c10c0b5e.1606941224.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

The current memory region move test correctly handles the situation that
the second (realigning) memslot move operation would temporarily trigger
MMIO until it completes, however it does not handle the case in which the
first (misaligning) move operation does this, too.
This results in false test assertions in case it does so.

Fix this by handling temporary MMIO from the first memslot move operation
in the test guest code, too.

Fixes: 8a0639fe9201 ("KVM: sefltests: Add explicit synchronization to move mem region test")
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
    The race is pretty hard to trigger on the current KVM memslot code,
    to trigger it reliably an extra delay in memslot move op is needed:
    --- a/virt/kvm/kvm_main.c
    +++ b/virt/kvm/kvm_main.c
    @@ -1173,7 +1173,7 @@ static struct kvm_memslots *kvm_dup_memslots(struct kvm_memslots *old,
    
            return slots;
     }
    -
    +#include <linux/delay.h>
     static int kvm_set_memslot(struct kvm *kvm,
                               const struct kvm_userspace_memory_region *mem,
                               struct kvm_memory_slot *old,
    @@ -1212,6 +1212,8 @@ static int kvm_set_memslot(struct kvm *kvm,
                     *      - kvm_is_visible_gfn (mmu_check_root)
                     */
                    kvm_arch_flush_shadow_memslot(kvm, slot);
    +
    +               if (change == KVM_MR_MOVE) mdelay(100);
            }
    
            r = kvm_arch_prepare_memory_region(kvm, new, mem, change);

 .../selftests/kvm/set_memory_region_test.c      | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index b3ece55a2da6..6f441dd9f33c 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -156,14 +156,23 @@ static void guest_code_move_memory_region(void)
 	GUEST_SYNC(0);
 
 	/*
-	 * Spin until the memory region is moved to a misaligned address.  This
-	 * may or may not trigger MMIO, as the window where the memslot is
-	 * invalid is quite small.
+	 * Spin until the memory region starts getting moved to a
+	 * misaligned address.
+	 * Every region move may or may not trigger MMIO, as the
+	 * window where the memslot is invalid is usually quite small.
 	 */
 	val = guest_spin_on_val(0);
 	GUEST_ASSERT_1(val == 1 || val == MMIO_VAL, val);
 
-	/* Spin until the memory region is realigned. */
+	/* Spin until the misaligning memory region move completes. */
+	val = guest_spin_on_val(MMIO_VAL);
+	GUEST_ASSERT_1(val == 1 || val == 0, val);
+
+	/* Spin until the memory region starts to get re-aligned. */
+	val = guest_spin_on_val(0);
+	GUEST_ASSERT_1(val == 1 || val == MMIO_VAL, val);
+
+	/* Spin until the re-aligning memory region move completes. */
 	val = guest_spin_on_val(MMIO_VAL);
 	GUEST_ASSERT_1(val == 1, val);
 
