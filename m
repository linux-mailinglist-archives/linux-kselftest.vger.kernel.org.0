Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93EE547023
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jun 2022 01:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350981AbiFJXg3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jun 2022 19:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350281AbiFJXgJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jun 2022 19:36:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192DF289F3B;
        Fri, 10 Jun 2022 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654904142; x=1686440142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E0S7lAVxIGr1gPnTIVSUeXKWXCH1YKeQN7klBTJ1vLE=;
  b=SLkQeM+pzRu2w6WHLXLIPXUyfpd/IZBNY8zP+UUugK5G2QgOb6HXm463
   /zO0Kb1raDEMVliWzx2FKTNhkXDJtLs+FxMtwpjA3RTENpS/lamKWZbSS
   d3PySVvG/KICqkQv4hip0mJ8MxJvmHeNNqCq4jOAqRsVn/ZXPVL4QU99i
   HTAZ8CQSQOZhu48IJwqiA9HtVLP3KGDUaAsUcNY51qLoWY/L6V73dTgBj
   GxIc6oujwAf7URbM5lEhIOWiEaAEM1bc87vEfIMc2Iei79PvOC2bU5F0p
   SNDn2/2xmSg/Z/JNPSVpKa2gkVr1QsXosjJ2TNL+FwFzahfmNn916XytE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="260896457"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="260896457"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:35:40 -0700
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="909166943"
Received: from pleung-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.33.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:35:40 -0700
From:   ira.weiny@intel.com
To:     linux-api@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, ahaas@chromium.org,
        clemensb@chromium.org, gdeepti@chromium.org,
        jkummerow@chromium.org, manoskouk@chromium.org,
        thibaudm@chromium.org, Florian Weimer <fweimer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 5/6] pkeys: Up level pkey_free() checks
Date:   Fri, 10 Jun 2022 16:35:32 -0700
Message-Id: <20220610233533.3649584-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610233533.3649584-1-ira.weiny@intel.com>
References: <20220610233533.3649584-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

x86 is missing a hardware check for pkey support in pkey_free().  While
the net result is the same (-EINVAL returned), pkey_free() has well
defined behavior which will be easier to maintain in one place.

For powerpc the return code is -1 rather than -EINVAL.  This changes
that behavior slightly but this is very unlikely to break any user
space.

Lift the checks for pkey_free() to the core mm code and ensure
consistency with returning -EINVAL.

Cc: ahaas@chromium.org
Cc: clemensb@chromium.org
Cc: gdeepti@chromium.org
Cc: jkummerow@chromium.org
Cc: manoskouk@chromium.org
Cc: thibaudm@chromium.org
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-api@vger.kernel.org
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Thanks to Sohil for suggesting I mention the powerpc return value in the
commit message.

Also Sohil suggested changing mm_pkey_free() from int to void.  This is
added as a separate patch with his suggested by.
---
 arch/powerpc/include/asm/pkeys.h | 6 ------
 arch/x86/include/asm/pkeys.h     | 3 ---
 mm/mprotect.c                    | 8 ++++++--
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 2c8351248793..e96aa91f817b 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -107,12 +107,6 @@ static inline int mm_pkey_alloc(struct mm_struct *mm)
 
 static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
 {
-	if (!mmu_has_feature(MMU_FTR_PKEY))
-		return -1;
-
-	if (!mm_pkey_is_allocated(mm, pkey))
-		return -EINVAL;
-
 	__mm_pkey_free(mm, pkey);
 
 	return 0;
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 2e6c04d8a45b..da02737cc4d1 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -107,9 +107,6 @@ int mm_pkey_alloc(struct mm_struct *mm)
 static inline
 int mm_pkey_free(struct mm_struct *mm, int pkey)
 {
-	if (!mm_pkey_is_allocated(mm, pkey))
-		return -EINVAL;
-
 	mm_set_pkey_free(mm, pkey);
 
 	return 0;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 56d35de33725..41458e729c27 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -803,10 +803,14 @@ SYSCALL_DEFINE2(pkey_alloc, unsigned long, flags, unsigned long, init_val)
 
 SYSCALL_DEFINE1(pkey_free, int, pkey)
 {
-	int ret;
+	int ret = -EINVAL;
+
+	if (!arch_pkeys_enabled())
+		return ret;
 
 	mmap_write_lock(current->mm);
-	ret = mm_pkey_free(current->mm, pkey);
+	if (mm_pkey_is_allocated(current->mm, pkey))
+		ret = mm_pkey_free(current->mm, pkey);
 	mmap_write_unlock(current->mm);
 
 	/*
-- 
2.35.1

