Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272B4724C31
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 21:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbjFFTFG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 15:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239225AbjFFTEg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 15:04:36 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ADD10F0
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 12:04:30 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5428d1915acso2871644a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jun 2023 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078270; x=1688670270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QY81mipd5eg6c/BuU1bdNHCWJQ+u0Nbd1U9TPL2kLvI=;
        b=KOWrQMhz2uWLqPOLL/0JQqPmlrC3dCiI9oJNy8GCgLIowS+OzS7WKaPGY9vPm3PtAT
         fUuRJYwgpjWgfKigP2vr98VC/4aqX3GYpvsp4hPnsGOFwNN2fFFSeRFXL9FC8QZZeOsv
         TXZBuwWg2rM6bvxVXZ2UCQuJ6ff8v2+LFRqOgjtb865dVZ2l7fY2f7Z/OtzPXYHKjbfN
         ZRjrOmzbbZGa3KF/56lwJLd6R/hiuFa+vyvCC7nno3amrl0TRMEIewtSKtG/z8kueDPR
         Li+slKiOskei/vBhvsQJtHNmBIeIcarnb3mQ6zRjd56sBUc1JOzEZw6pSH3bcClc+mm/
         tubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078270; x=1688670270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QY81mipd5eg6c/BuU1bdNHCWJQ+u0Nbd1U9TPL2kLvI=;
        b=P3iADOTzT3QMy6rM4i3wI3wuUEY6yOt6APobolYuzoQ2APQmkjbbCyXZoX+Ikr4qhv
         MQ2bJhkeb3I5RVJBmZUNqcXOxWaEFauZTOl6zP/dsiOeJE1gi+XqVs92gEOjLL1s1htl
         kOVdoJnqFteLm+jPpcwzY7kCA312mlB+INi7pYxkK/9pgttUTI8cZEd9dAQO8ThKfRTK
         JsKd/vimRArkSmSKAkvtc5d3fHUKRBYC19rfS0UL6hJTwUwihcp/TKi2PdC60aOP0o0C
         34ReldgPI8/ZmNkUfgOGa2g0+BcGKu1QmCSCOGx6sOG4wMlHgCXQneif4uaL8twzsCC3
         J88w==
X-Gm-Message-State: AC+VfDy82691TW4i9QZd1cRPq7BiLyl7Xi/Xtyq10p4/KQjUw+z/IDtX
        4dlDTVori06jS+tOAwAnV/cL3SEEcgGqYsn78A==
X-Google-Smtp-Source: ACHHUZ7uGZgeuxGQjEekaNfEPd3cHpOSpYga7qIjxZtHDS9vRTE59C+39iUxIiNEiIcn3iYrIGeQIhYQVNbQFyY1wQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a63:4848:0:b0:534:7672:433e with SMTP
 id x8-20020a634848000000b005347672433emr763304pgk.3.1686078269556; Tue, 06
 Jun 2023 12:04:29 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:03:54 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <7937abfd3f2d071820a1bcb84e05bf48e38e2e5b.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 09/19] mm: hugetlb: Use restore_reserve_on_error directly
 in filesystems
From:   Ackerley Tng <ackerleytng@google.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, pbonzini@redhat.com, seanjc@google.com,
        shuah@kernel.org, willy@infradead.org
Cc:     brauner@kernel.org, chao.p.peng@linux.intel.com,
        coltonlewis@google.com, david@redhat.com, dhildenb@redhat.com,
        dmatlack@google.com, erdemaktas@google.com, hughd@google.com,
        isaku.yamahata@gmail.com, jarkko@kernel.org, jmattson@google.com,
        joro@8bytes.org, jthoughton@google.com, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, liam.merwick@oracle.com,
        mail@maciej.szmigiero.name, mhocko@suse.com, michael.roth@amd.com,
        qperret@google.com, rientjes@google.com, rppt@kernel.org,
        steven.price@arm.com, tabba@google.com, vannapurve@google.com,
        vbabka@suse.cz, vipinsh@google.com, vkuznets@redhat.com,
        wei.w.wang@intel.com, yu.c.zhang@linux.intel.com,
        kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, x86@kernel.org,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Expose inode_resv_map() so that hugetlbfs can access its own resv_map.

Hide restore_reserve_on_error_vma(), that function is now only used
within mm/hugetlb.c.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/hugetlbfs/inode.c    |  2 +-
 include/linux/hugetlb.h | 21 +++++++++++++++++++--
 mm/hugetlb.c            | 13 -------------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 44e6ee9a856d..53f6a421499d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -868,7 +868,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		__folio_mark_uptodate(folio);
 		error = hugetlb_add_to_page_cache(folio, mapping, index);
 		if (unlikely(error)) {
-			restore_reserve_on_error_vma(h, &pseudo_vma, addr, folio);
+			restore_reserve_on_error(inode_resv_map(inode), index, true, folio);
 			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 02a2766d89a4..5fe9643826d7 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -568,6 +568,20 @@ static inline struct hugepage_subpool *subpool_inode(struct inode *inode)
 	return HUGETLBFS_SB(inode->i_sb)->spool;
 }
 
+static inline struct resv_map *inode_resv_map(struct inode *inode)
+{
+	/*
+	 * At inode evict time, i_mapping may not point to the original
+	 * address space within the inode.  This original address space
+	 * contains the pointer to the resv_map.  So, always use the
+	 * address space embedded within the inode.
+	 * The VERY common case is inode->mapping == &inode->i_data but,
+	 * this may not be true for device special inodes.
+	 */
+	return (struct resv_map *)(&inode->i_data)->private_data;
+}
+
+
 #else /* !CONFIG_HUGETLBFS */
 
 #define is_file_hugepages(file)			false
@@ -588,6 +602,11 @@ static inline struct hugepage_subpool *subpool_inode(struct inode *inode)
 	return NULL;
 }
 
+static inline struct resv_map *inode_resv_map(struct inode *inode)
+{
+	return NULL;
+}
+
 #endif /* !CONFIG_HUGETLBFS */
 
 #ifdef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
@@ -762,8 +781,6 @@ int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping
 			pgoff_t idx);
 void restore_reserve_on_error(struct resv_map *resv, pgoff_t resv_index,
 			      bool may_share, struct folio *folio);
-void restore_reserve_on_error_vma(struct hstate *h, struct vm_area_struct *vma,
-				  unsigned long address, struct folio *folio);
 
 /* arch callback */
 int __init __alloc_bootmem_huge_page(struct hstate *h, int nid);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4675f9efeba4..540634aec181 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1091,19 +1091,6 @@ void resv_map_release(struct kref *ref)
 	kfree(resv_map);
 }
 
-static inline struct resv_map *inode_resv_map(struct inode *inode)
-{
-	/*
-	 * At inode evict time, i_mapping may not point to the original
-	 * address space within the inode.  This original address space
-	 * contains the pointer to the resv_map.  So, always use the
-	 * address space embedded within the inode.
-	 * The VERY common case is inode->mapping == &inode->i_data but,
-	 * this may not be true for device special inodes.
-	 */
-	return (struct resv_map *)(&inode->i_data)->private_data;
-}
-
 static struct resv_map *vma_resv_map(struct vm_area_struct *vma)
 {
 	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
-- 
2.41.0.rc0.172.g3f132b7071-goog

