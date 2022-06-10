Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC69E54702D
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jun 2022 01:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350958AbiFJXgT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jun 2022 19:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349246AbiFJXgG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jun 2022 19:36:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B0E289F32;
        Fri, 10 Jun 2022 16:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654904140; x=1686440140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MchtFdici9/LHAAi4sFR4mcD0phAyK+8tBE2Ictb0Iw=;
  b=LAVN7jzZmV8y5vys/6gnjpgRUjgbcdB4MR7cY+a5VQjXop4LoAe3I9S6
   0qLyW5IC/SCRz2hkfwGk0VIirRASK2AtKuTUXvJkkC//NLb1A8ByQsY4g
   b+ea22el4CILsydLWeUOvoRJzcf5XdLVAR5fJYgDHGOTZ+nvAUNyKR5D3
   YD0IxbhEFR2U45+en8BdVWw9/cCVGVLeMRRKaHkNslBjlVaddKy7eBc2j
   67NAMCAfN8gV9qkGSGihGpnONbBBymATQXXKdP+wH8M4hifpUVf7ZcPOd
   pLvx9NfUaUSD4a9xH4haHf2RFRUxxIAzH+isfbTs7loeY9O87Mb2KQLTz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="275311579"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="275311579"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:35:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="581302597"
Received: from pleung-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.33.34])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:35:38 -0700
From:   ira.weiny@intel.com
To:     linux-api@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, ahaas@chromium.org,
        clemensb@chromium.org, gdeepti@chromium.org,
        jkummerow@chromium.org, manoskouk@chromium.org,
        thibaudm@chromium.org, Florian Weimer <fweimer@redhat.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 4/6] pkeys: Lift pkey hardware check for pkey_alloc()
Date:   Fri, 10 Jun 2022 16:35:31 -0700
Message-Id: <20220610233533.3649584-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610233533.3649584-1-ira.weiny@intel.com>
References: <20220610233533.3649584-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

pkey_alloc() is documented to return ENOSPC when the hardware does not
support pkeys.  On x86, pkey_alloc() incorrectly returns EINVAL.

This is because mm_pkey_alloc() does not check for pkey support before
returning a key.  Therefore, if the keys are not exhausted pkey_alloc()
continues on to call arch_set_user_pkey_access().  Unfortunately, when
arch_set_user_pkey_access() detects the failed support it overwrites the
ENOSPC return value with EINVAL.

Ensure consistent behavior across architectures by lifting this check to
the core mm code.

Remove a couple of 'we' references in code comments as well.

Cc: ahaas@chromium.org
Cc: clemensb@chromium.org
Cc: gdeepti@chromium.org
Cc: jkummerow@chromium.org
Cc: manoskouk@chromium.org
Cc: thibaudm@chromium.org
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: linux-api@vger.kernel.org
Fixes: e8c24d3a23a4 ("x86/pkeys: Allocation/free syscalls")
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Thanks to Sohil for pointing out that the commit message could be more
clear WRT how EINVAL is returned incorrectly.
---
 arch/powerpc/include/asm/pkeys.h | 8 +++-----
 mm/mprotect.c                    | 3 +++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 59a2c7dbc78f..2c8351248793 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -85,18 +85,16 @@ static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 static inline int mm_pkey_alloc(struct mm_struct *mm)
 {
 	/*
-	 * Note: this is the one and only place we make sure that the pkey is
+	 * Note: this is the one and only place to make sure that the pkey is
 	 * valid as far as the hardware is concerned. The rest of the kernel
 	 * trusts that only good, valid pkeys come out of here.
 	 */
 	u32 all_pkeys_mask = (u32)(~(0x0));
 	int ret;
 
-	if (!mmu_has_feature(MMU_FTR_PKEY))
-		return -1;
 	/*
-	 * Are we out of pkeys? We must handle this specially because ffz()
-	 * behavior is undefined if there are no zeros.
+	 * Out of pkeys?  Handle this specially because ffz() behavior is
+	 * undefined if there are no zeros.
 	 */
 	if (mm_pkey_allocation_map(mm) == all_pkeys_mask)
 		return -1;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ba5592655ee3..56d35de33725 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -773,6 +773,9 @@ SYSCALL_DEFINE2(pkey_alloc, unsigned long, flags, unsigned long, init_val)
 	int pkey;
 	int ret;
 
+	if (!arch_pkeys_enabled())
+		return -ENOSPC;
+
 	/* No flags supported yet. */
 	if (flags)
 		return -EINVAL;
-- 
2.35.1

