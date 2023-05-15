Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D234F702D84
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242031AbjEONG5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 09:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242090AbjEONGm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 09:06:42 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189F26B6
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 06:06:15 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaea43def7so87349455ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684155965; x=1686747965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhTOrV9Ep9418v/k9QWjv1EjLbKrSL2Q0hL/MSOj6fE=;
        b=AE5TPYdJKh+upwVCJh3G8m4CCCGvl07nH8DA+I/nklujQ9YNY+5+hrzRPCyiIGbHCd
         /G3dlUxrCo3tGgXlYHwHpAnY3srtCMkn2jHsUMg6pylapAZdL3XF43Ekl+CjStZbtfNz
         qtYa8TABInHSPUkJf4aHK+0vNIdvP6UNEHHos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155965; x=1686747965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhTOrV9Ep9418v/k9QWjv1EjLbKrSL2Q0hL/MSOj6fE=;
        b=TsS+A1XI1cxXDP2LMgC1vfn+4vG4pjG1vrE8g9/L/e54pty52vFSeRo8d0nwe2Soga
         3p4nxo3AryxG/rURcnQYfR89I1sIr2Qea/cbeJlfF0YtdASF3g2H2bg+9hveFvP29n+d
         M/2nB7C4OvVCNL2C87K61HPe0shQr0usHNFlREFv6kWgXCzsIKRgU+eUfNjtyC5A6A5a
         0jcWd5epKTYHciQBrfWgdyNQ3D2Qoaw+FhdSOnJTIBz/GWuwd/QnGZ/vI8XeIfYf+XXy
         MLD+yK3QkPBRMdpHgNRkNnCaBY910RYgaUtXLG/ztKjN2P+0y9JWBNM6YJULfvtJxfAR
         usHg==
X-Gm-Message-State: AC+VfDyNOnmtIkm2oe6KRrdD3Jpu8OlisTfpvpvPCk+mOh/TzGOxbqgg
        1573L7L9d8dTBw+xciJuLpBkkw==
X-Google-Smtp-Source: ACHHUZ4pDHGfCKYoQ6o3ND+tn3Cpa2PwKLfI3Rj7SdWtOItCYzvZZqHrfIDR9pXglq7oDkkVfGKQ/Q==
X-Received: by 2002:a17:902:da84:b0:1ac:a28e:4b29 with SMTP id j4-20020a170902da8400b001aca28e4b29mr29799652plx.26.1684155965066;
        Mon, 15 May 2023 06:06:05 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id z6-20020a170902834600b001a980a23802sm13465239pln.111.2023.05.15.06.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 06:06:04 -0700 (PDT)
From:   jeffxu@chromium.org
To:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH 5/6] KEY: Apply PKEY_ENFORCE_API to munmap
Date:   Mon, 15 May 2023 13:05:51 +0000
Message-ID: <20230515130553.2311248-6-jeffxu@chromium.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230515130553.2311248-1-jeffxu@chromium.org>
References: <20230515130553.2311248-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 include/linux/mm.h |  2 +-
 mm/mmap.c          | 34 ++++++++++++++++++++++++++--------
 mm/mremap.c        |  6 ++++--
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..48076e845d53 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3136,7 +3136,7 @@ extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
 extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
-			 bool downgrade);
+			 bool downgrade, bool syscall);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
diff --git a/mm/mmap.c b/mm/mmap.c
index 13678edaa22c..29329aa794a6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2498,6 +2498,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * @uf: The userfaultfd list_head
  * @downgrade: set to true if the user wants to attempt to write_downgrade the
  * mmap_lock
+ * @syscall: set to true if this is called from syscall entry
  *
  * This function takes a @mas that is either pointing to the previous VMA or set
  * to MA_START and sets it up to remove the mapping(s).  The @len will be
@@ -2507,7 +2508,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
  */
 int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
-		  bool downgrade)
+		  bool downgrade, bool syscall)
 {
 	unsigned long end;
 	struct vm_area_struct *vma;
@@ -2519,6 +2520,19 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (end == start)
 		return -EINVAL;
 
+	/*
+	 * When called by syscall from userspace, check if the calling
+	 * thread has the PKEY permission to modify the memory mapping.
+	 */
+	if (syscall && arch_check_pkey_enforce_api(mm, start, end) < 0) {
+		char comm[TASK_COMM_LEN];
+
+		pr_warn_ratelimited(
+			"munmap was denied on PKEY_ENFORCE_API memory, pid=%d '%s'\n",
+			task_pid_nr(current), get_task_comm(comm, current));
+		return -EACCES;
+	}
+
 	 /* arch_unmap() might do unmaps itself.  */
 	arch_unmap(mm, start, end);
 
@@ -2541,7 +2555,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 {
 	VMA_ITERATOR(vmi, mm, start);
 
-	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
+	return do_vmi_munmap(&vmi, mm, start, len, uf, false, false);
 }
 
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2575,7 +2589,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	/* Unmap any existing mapping in the area */
-	if (do_vmi_munmap(&vmi, mm, addr, len, uf, false))
+	if (do_vmi_munmap(&vmi, mm, addr, len, uf, false, false))
 		return -ENOMEM;
 
 	/*
@@ -2792,7 +2806,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return error;
 }
 
-static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
+/*
+ * @syscall: set to true if this is called from syscall entry
+ */
+static int __vm_munmap(unsigned long start, size_t len, bool downgrade,
+		       bool syscall)
 {
 	int ret;
 	struct mm_struct *mm = current->mm;
@@ -2802,7 +2820,7 @@ static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	ret = do_vmi_munmap(&vmi, mm, start, len, &uf, downgrade);
+	ret = do_vmi_munmap(&vmi, mm, start, len, &uf, downgrade, syscall);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -2820,14 +2838,14 @@ static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 
 int vm_munmap(unsigned long start, size_t len)
 {
-	return __vm_munmap(start, len, false);
+	return __vm_munmap(start, len, false, false);
 }
 EXPORT_SYMBOL(vm_munmap);
 
 SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
 {
 	addr = untagged_addr(addr);
-	return __vm_munmap(addr, len, true);
+	return __vm_munmap(addr, len, true, true);
 }
 
 
@@ -3055,7 +3073,7 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 	if (ret)
 		goto limits_failed;
 
-	ret = do_vmi_munmap(&vmi, mm, addr, len, &uf, 0);
+	ret = do_vmi_munmap(&vmi, mm, addr, len, &uf, 0, false);
 	if (ret)
 		goto munmap_failed;
 
diff --git a/mm/mremap.c b/mm/mremap.c
index b11ce6c92099..768e5bd4e8b5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -703,7 +703,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	vma_iter_init(&vmi, mm, old_addr);
-	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false) < 0) {
+	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false, false) <
+	    0) {
 		/* OOM: unable to split vma, just get accounts right */
 		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
 			vm_acct_memory(old_len >> PAGE_SHIFT);
@@ -993,7 +994,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		VMA_ITERATOR(vmi, mm, addr + new_len);
 
 		retval = do_vmi_munmap(&vmi, mm, addr + new_len,
-				       old_len - new_len, &uf_unmap, true);
+				       old_len - new_len, &uf_unmap, true,
+				       false);
 		/* Returning 1 indicates mmap_lock is downgraded to read. */
 		if (retval == 1) {
 			downgraded = true;
-- 
2.40.1.606.ga4b1b128d6-goog

