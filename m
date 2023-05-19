Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9BF708D3F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 03:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjESBTh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 21:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjESBTe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 21:19:34 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DD710DD
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 18:19:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d15660784so1032165b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 18:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684459171; x=1687051171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UP7PrspRcAj60L7H0nNNXk2sIZvcVn8Hzlm0pHNc5DI=;
        b=KyUoiw4ElMe/LNfLauu3mRsWtl6tLzsjFFWTg2362wmgmg2Ddqu/eccJT5ajd/WVCK
         u1l0ug+0cIrf8bFw6zRHAri7y+MBhpSJTKovSJLlNyH0CjoNHHPa7W+0dgGBS04gOyOU
         DCYEDZN/Ib9Kcmnqo4b0yFdJ8ouzcRriQUlWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684459171; x=1687051171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UP7PrspRcAj60L7H0nNNXk2sIZvcVn8Hzlm0pHNc5DI=;
        b=kBauG4pj47iVH8SF+nweAY1fZt6TOjQHJeTXNxh79vngyxDO8Sv+JQOIFUzTgcyt7v
         6wR/DipU01na3XenHDmxhZA42ICM6ruZBGCa3U+bP+ed/59u5WfWC7oZ06E0yE8XG8oW
         PBt/wmk7baVo7fw7GpkXi5CAIPYuN+UZxvTCQ0461XM87GUsjIHxGcxaAEVK4vhZtbBU
         uLgo251567ri0KADtf9IJ8MDZLyEABdfNFCtmkEWQ0jnb6a61pWEfigAyTBzzGtO97qb
         58+qMrMHmjx4GkR1tewv0QWz3g7K1imkG2Og9rUyE4L05U5qQjGygeKI3hH8Y+KauvOL
         m4Qg==
X-Gm-Message-State: AC+VfDyPQjRzjre4Yvlff9B9nuw9MsPZLLLWbWlbFAH03STeYD7dhVPJ
        sQeFW6Vu0q7M9p1WnSGMDVMHgg==
X-Google-Smtp-Source: ACHHUZ68oo3FWI/wrCU6PluVlfGvpW5h8fWIl8HSfv8KKt7tiRrAfmCm24UxHEFUgu6q95GiIgMiZw==
X-Received: by 2002:a17:902:dac7:b0:1ac:7e95:74be with SMTP id q7-20020a170902dac700b001ac7e9574bemr1183574plx.28.1684459171540;
        Thu, 18 May 2023 18:19:31 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id ji17-20020a170903325100b001960706141fsm2102839plb.149.2023.05.18.18.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 18:19:31 -0700 (PDT)
From:   jeffxu@chromium.org
To:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH v1 5/6] PKEY: Apply PKEY_ENFORCE_API to munmap
Date:   Fri, 19 May 2023 01:19:13 +0000
Message-ID: <20230519011915.846407-6-jeffxu@chromium.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519011915.846407-1-jeffxu@chromium.org>
References: <20230519011915.846407-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

This patch enables PKEY_ENFORCE_API for the munmap
syscall.

Signed-off-by: Jeff Xu<jeffxu@google.com>
---
 include/linux/mm.h |  8 +++++++-
 mm/mmap.c          | 31 +++++++++++++++++++++++--------
 mm/mremap.c        |  6 ++++--
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..795cdeee2ea7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -429,6 +429,12 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
 
+/* The current call stack is originated from user space or kernel */
+enum caller_origin {
+	ON_BEHALF_OF_KERNEL = 0,
+	ON_BEHALF_OF_USERSPACE,
+};
+
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
@@ -3136,7 +3142,7 @@ extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
 extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
-			 bool downgrade);
+			 bool downgrade, enum caller_origin called);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
diff --git a/mm/mmap.c b/mm/mmap.c
index 13678edaa22c..3de95a6a4397 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2498,6 +2498,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * @uf: The userfaultfd list_head
  * @downgrade: set to true if the user wants to attempt to write_downgrade the
  * mmap_lock
+ * @called: originated from user space or kernel
  *
  * This function takes a @mas that is either pointing to the previous VMA or set
  * to MA_START and sets it up to remove the mapping(s).  The @len will be
@@ -2507,7 +2508,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
  */
 int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
-		  bool downgrade)
+		  bool downgrade, enum caller_origin called)
 {
 	unsigned long end;
 	struct vm_area_struct *vma;
@@ -2519,6 +2520,15 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (end == start)
 		return -EINVAL;
 
+	/*
+	 * When called by syscall from userspace, check if the calling
+	 * thread has the PKEY permission to modify the memory mapping.
+	 */
+	if (called == ON_BEHALF_OF_USERSPACE &&
+		arch_check_pkey_enforce_api(mm, start, end) < 0) {
+		return -EACCES;
+	}
+
 	 /* arch_unmap() might do unmaps itself.  */
 	arch_unmap(mm, start, end);
 
@@ -2541,7 +2551,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 {
 	VMA_ITERATOR(vmi, mm, start);
 
-	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
+	return do_vmi_munmap(&vmi, mm, start, len, uf, false, ON_BEHALF_OF_KERNEL);
 }
 
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2575,7 +2585,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	/* Unmap any existing mapping in the area */
-	if (do_vmi_munmap(&vmi, mm, addr, len, uf, false))
+	if (do_vmi_munmap(&vmi, mm, addr, len, uf, false,
+			ON_BEHALF_OF_KERNEL))
 		return -ENOMEM;
 
 	/*
@@ -2792,7 +2803,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return error;
 }
 
-static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
+/*
+ * @called: originated from user space or kernel
+ */
+static int __vm_munmap(unsigned long start, size_t len, bool downgrade,
+			enum caller_origin called)
 {
 	int ret;
 	struct mm_struct *mm = current->mm;
@@ -2802,7 +2817,7 @@ static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	ret = do_vmi_munmap(&vmi, mm, start, len, &uf, downgrade);
+	ret = do_vmi_munmap(&vmi, mm, start, len, &uf, downgrade, called);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -2820,14 +2835,14 @@ static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 
 int vm_munmap(unsigned long start, size_t len)
 {
-	return __vm_munmap(start, len, false);
+	return __vm_munmap(start, len, false, ON_BEHALF_OF_KERNEL);
 }
 EXPORT_SYMBOL(vm_munmap);
 
 SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
 {
 	addr = untagged_addr(addr);
-	return __vm_munmap(addr, len, true);
+	return __vm_munmap(addr, len, true, ON_BEHALF_OF_USERSPACE);
 }
 
 
@@ -3055,7 +3070,7 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 	if (ret)
 		goto limits_failed;
 
-	ret = do_vmi_munmap(&vmi, mm, addr, len, &uf, 0);
+	ret = do_vmi_munmap(&vmi, mm, addr, len, &uf, 0, ON_BEHALF_OF_KERNEL);
 	if (ret)
 		goto munmap_failed;
 
diff --git a/mm/mremap.c b/mm/mremap.c
index b11ce6c92099..a3f576effbb1 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -703,7 +703,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	vma_iter_init(&vmi, mm, old_addr);
-	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false) < 0) {
+	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false,
+				ON_BEHALF_OF_KERNEL) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
 		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
 			vm_acct_memory(old_len >> PAGE_SHIFT);
@@ -993,7 +994,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		VMA_ITERATOR(vmi, mm, addr + new_len);
 
 		retval = do_vmi_munmap(&vmi, mm, addr + new_len,
-				       old_len - new_len, &uf_unmap, true);
+				       old_len - new_len, &uf_unmap, true,
+				       ON_BEHALF_OF_KERNEL);
 		/* Returning 1 indicates mmap_lock is downgraded to read. */
 		if (retval == 1) {
 			downgraded = true;
-- 
2.40.1.606.ga4b1b128d6-goog

