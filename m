Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA48C54704D
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jun 2022 01:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350318AbiFJXgV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jun 2022 19:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350236AbiFJXgJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jun 2022 19:36:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F583289F25;
        Fri, 10 Jun 2022 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654904142; x=1686440142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XfSsZjEZ1l0M6Je8ux0RlvZeHHKfZHKU8L8K8HX1yVc=;
  b=KLIDghy+2mwQ4ZQ1m6ILXDXs+ttds2s6KsWK39jGuLDWkNl2IjGrBWNu
   6or3H8zeWVHBcnrgo0J3OUcu8wObuDWE01Ms9E70jk6fTjkGgZ8nsJE5Z
   eziUBFuY6oc4Gm1Zhu8BFSJDdAH9Anz7A4pb41PCtBIWF8ztJjdGuxmvN
   BJbT7jIaAb+4JZquAsd+mSth/6HHZFBszgf/xbVcy+QYHoI8HxMBPf29k
   jQtAFb/wn7WmuTiGi/8Yivi6fY+JFv9awj6fzZadP2Hglo8dfXd1B6XCt
   UbF3q4Zw8ksqQ/nEsrA481oFn7Qcpp8hbqLwubT5bw8w1xcoOVhQa/dU5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="258214176"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="258214176"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:35:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="760716868"
Received: from pleung-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.33.34])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:35:41 -0700
From:   ira.weiny@intel.com
To:     linux-api@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 6/6] pkeys: Change mm_pkey_free() to void
Date:   Fri, 10 Jun 2022 16:35:33 -0700
Message-Id: <20220610233533.3649584-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610233533.3649584-1-ira.weiny@intel.com>
References: <20220610233533.3649584-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Now that the pkey arch support is no longer checked in mm_pkey_free()
there is no reason to have it return int.

Change the return value to void.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/powerpc/include/asm/pkeys.h | 4 +---
 arch/x86/include/asm/pkeys.h     | 4 +---
 include/linux/pkeys.h            | 5 +----
 mm/mprotect.c                    | 6 ++++--
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index e96aa91f817b..4d01a48ab941 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -105,11 +105,9 @@ static inline int mm_pkey_alloc(struct mm_struct *mm)
 	return ret;
 }
 
-static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
+static inline void mm_pkey_free(struct mm_struct *mm, int pkey)
 {
 	__mm_pkey_free(mm, pkey);
-
-	return 0;
 }
 
 /*
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index da02737cc4d1..1f408f46fa9a 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -105,11 +105,9 @@ int mm_pkey_alloc(struct mm_struct *mm)
 }
 
 static inline
-int mm_pkey_free(struct mm_struct *mm, int pkey)
+void mm_pkey_free(struct mm_struct *mm, int pkey)
 {
 	mm_set_pkey_free(mm, pkey);
-
-	return 0;
 }
 
 static inline int vma_pkey(struct vm_area_struct *vma)
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 86be8bf27b41..bf98c50a3437 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -30,10 +30,7 @@ static inline int mm_pkey_alloc(struct mm_struct *mm)
 	return -1;
 }
 
-static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
-{
-	return -EINVAL;
-}
+static inline void mm_pkey_free(struct mm_struct *mm, int pkey) { }
 
 static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 			unsigned long init_val)
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 41458e729c27..e872bdd2e228 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -809,8 +809,10 @@ SYSCALL_DEFINE1(pkey_free, int, pkey)
 		return ret;
 
 	mmap_write_lock(current->mm);
-	if (mm_pkey_is_allocated(current->mm, pkey))
-		ret = mm_pkey_free(current->mm, pkey);
+	if (mm_pkey_is_allocated(current->mm, pkey)) {
+		mm_pkey_free(current->mm, pkey);
+		ret = 0;
+	}
 	mmap_write_unlock(current->mm);
 
 	/*
-- 
2.35.1

