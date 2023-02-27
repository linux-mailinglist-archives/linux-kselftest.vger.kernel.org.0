Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614496A4CF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 22:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjB0VQr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 16:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjB0VQq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 16:16:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4317326CE9;
        Mon, 27 Feb 2023 13:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677532605; x=1709068605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=sclNcLaMWRVL+dtt0esI+nvc2/fJ8Evi5Feh00cpz/4=;
  b=f4D8URr9BRG6Eq97bUhHjkDF5EQcDwRevt10hB689w6CCwo5N+HjfGro
   wdVCvUaZ7RJCD792ncr/8xgL2yFx2RKxJ4o9YTcmvH4PyJd1ecubdL+82
   cbJaPqkvXgHe8Fg7+PiEaO1tDOxp2/PUSNvI+lg2Ra3LrTW4hMn5v/xBU
   J4J0BDleUUQjtA94NT2z30umugBe7X/FonZSEmRnaK7k/T/6SHcp2PVTj
   Z6WruuVMt8KXgQZ4SQtiOvTwEjXgwVZXGbKRu9nvs9CpWPaQMC70Qt7dd
   eDPmmH17Btn1wkZ8AaIA1dQNqEIHkNzXH+G6mSI1WHRL0Vr9rHNK054vQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="322216373"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="322216373"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 13:16:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="651372910"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="651372910"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga006.jf.intel.com with ESMTP; 27 Feb 2023 13:16:42 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
        linux-kselftest@vger.kernel.org, mizhang@google.com,
        chang.seok.bae@intel.com
Subject: [PATCH 1/2] x86/fpu/xstate: Prevent false-positive warning in __copy_xstate_uabi_buf()
Date:   Mon, 27 Feb 2023 13:05:03 -0800
Message-Id: <20230227210504.18520-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227210504.18520-1-chang.seok.bae@intel.com>
References: <20221018221349.4196-1-chang.seok.bae@intel.com>
 <20230227210504.18520-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

__copy_xstate_to_uabi_buf() copies either from the tasks XSAVE buffer
or from init_fpstate into the ptrace buffer. Dynamic features, like
XTILEDATA, have an all zeroes init state and are not saved in
init_fpstate, which means the corresponding bit is not set in the
xfeatures bitmap of the init_fpstate header.

But __copy_xstate_to_uabi_buf() retrieves addresses for both the tasks
xstate and init_fpstate unconditionally via __raw_xsave_addr().

So if the tasks XSAVE buffer has a dynamic feature set, then the
address retrieval for init_fpstate triggers the warning in
__raw_xsave_addr() which checks the feature bit in the init_fpstate
header.

Remove the address retrieval from init_fpstate for extended features.
They have an all zeroes init state so init_fpstate has zeros for them.
Then zeroing the user buffer for the init state is the same as copying
them from init_fpstate.

Fixes: 2308ee57d93d ("x86/fpu/amx: Enable the AMX feature in 64-bit mode")
Reported-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Mingwei Zhang <mizhang@google.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/kvm/20230221163655.920289-2-mizhang@google.com/
---
Thanks, Mingwei for detecting the issue and Thomas for explaining the
problem with the well-written description. The background and problem
sections in this changelog came from his write-up.

I acknowledge that Mingwei's patch (in the link above) can solve the
problem. But, I would rather propose this approach as it simplifies
the code which is considered good in this sensitive copy function.

This mostly zeroed init_fpstate is still useful, e.g., when copying
the init state between buffers with the same format -- like in
fpu_clone(). But, this case between different XSAVE formats looks a
bit different than that.
---
 arch/x86/kernel/fpu/xstate.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 714166cc25f2..0bab497c9436 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1118,21 +1118,20 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 	zerofrom = offsetof(struct xregs_state, extended_state_area);
 
 	/*
-	 * The ptrace buffer is in non-compacted XSAVE format.  In
-	 * non-compacted format disabled features still occupy state space,
-	 * but there is no state to copy from in the compacted
-	 * init_fpstate. The gap tracking will zero these states.
-	 */
-	mask = fpstate->user_xfeatures;
-
-	/*
-	 * Dynamic features are not present in init_fpstate. When they are
-	 * in an all zeros init state, remove those from 'mask' to zero
-	 * those features in the user buffer instead of retrieving them
-	 * from init_fpstate.
+	 * This 'mask' indicates which states to copy from fpstate.
+	 * Those extended states that are not present in fpstate are
+	 * either disabled or initialized:
+	 *
+	 * In non-compacted format, disabled features still occupy
+	 * state space but there is no state to copy from in the
+	 * compacted init_fpstate. The gap tracking will zero these
+	 * states.
+	 *
+	 * The extended features have an all zeroes init state. Thus,
+	 * remove them from 'mask' to zero those features in the user
+	 * buffer instead of retrieving them from init_fpstate.
 	 */
-	if (fpu_state_size_dynamic())
-		mask &= (header.xfeatures | xinit->header.xcomp_bv);
+	mask = header.xfeatures;
 
 	for_each_extended_xfeature(i, mask) {
 		/*
@@ -1151,9 +1150,8 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 			pkru.pkru = pkru_val;
 			membuf_write(&to, &pkru, sizeof(pkru));
 		} else {
-			copy_feature(header.xfeatures & BIT_ULL(i), &to,
+			membuf_write(&to,
 				     __raw_xsave_addr(xsave, i),
-				     __raw_xsave_addr(xinit, i),
 				     xstate_sizes[i]);
 		}
 		/*
-- 
2.17.1

