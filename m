Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C768A7CBE82
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 11:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjJQJIa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 05:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbjJQJI0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 05:08:26 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98460B0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:08:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9bca1d96cso35812335ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697533704; x=1698138504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgKgE+zT4qoDlXNN6kCnypBqiPQ8What3ncvSi+XOyU=;
        b=n1mo1aJuGTLRP9LqdXT5JaqP7Ux8onQMy/2kn0hSVfY4o77wCT0KthiY+6Crj4OlD1
         HBSgBcmrimtMJzoQ4E1jhAPX1ahsq5lL47+B4JdwmXA23OUPstkaFiWrlv5vn9k0FvWG
         p5eISgISH8F/Q3/Crv2QAhmxaqHzeVjhyDSjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533704; x=1698138504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgKgE+zT4qoDlXNN6kCnypBqiPQ8What3ncvSi+XOyU=;
        b=pEWGVv2lkN/ItXYnSdA+YpK8LM56MIZdqZ1SW+zfEEB41kgqdbo1y+vUn4yKC4X7LP
         TA26j7y6SD1EC0zYjMzpSflRptgoUy/dN2et/B3QGnmuHPl0Jj+wurX6hupTwOuoUFcR
         cPXBiWUQwyEYFqkBjL7M9/NNt+F9cJeI0Q3qkucARo1t6JQ5GUEOkfg9WW1XsE7S7/Tt
         Vhqz8zJQFq0uv5Uz1sUS2O1jNZZuqIv0zg+CGQAwsZ3isSfyp8jPn8CwTDA/wMIkk3RF
         5GZg6arpdTrA5LYmozbLROXYjmsgDO2mB+Bc8R4vwjdn1ckQQ0fsaxkqpw1E6mhtb/9r
         kYww==
X-Gm-Message-State: AOJu0YwMiz/i5xJpiuqc6Ad6GvrvIkQF/eurC83ruelK/yEKNGvzSNsa
        s2AqWYuFoqZsZhv6AjxXETw4Aw==
X-Google-Smtp-Source: AGHT+IHCYocrm1n4yld0Gd8Vj3vGZcQMpjkWq5rvV/TBCHu6MN2SKOy6Ffa2J/O1CuQzRvjFk/JD+Q==
X-Received: by 2002:a17:903:4295:b0:1c6:2780:3adc with SMTP id ju21-20020a170903429500b001c627803adcmr1780065plb.24.1697533704140;
        Tue, 17 Oct 2023 02:08:24 -0700 (PDT)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id t7-20020a170902e84700b001bc21222e34sm995141plg.285.2023.10.17.02.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:08:23 -0700 (PDT)
From:   jeffxu@chromium.org
To:     akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Cc:     jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [RFC PATCH v2 5/8] mseal: Check seal flag for munmap(2)
Date:   Tue, 17 Oct 2023 09:08:12 +0000
Message-ID: <20231017090815.1067790-6-jeffxu@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231017090815.1067790-1-jeffxu@chromium.org>
References: <20231017090815.1067790-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

munmap(2) unmap VMAs in the given address range.
Sealing will prevent unintended munmap(2) call.

What this patch does:
When a munmap(2) is invoked, if one of its VMAs has MM_SEAL_MUNMAP
set from previous mseal(2) call, this munmap(2) will fail,
without any VMA modified.

This patch is based on following:
1. At syscall entry point: SYSCALL_DEFINE2(munmap, ...)
Pass checkSeals = MM_SEAL_MUNMAP into __vm_munmap(),
in turn, to do_vmi_munmap().

Of all the call paths that call into do_vmi_munmap(),
this is the only place where checkSeals = MM_SEAL_MUNMAP.
The rest has checkSeals = 0.

2. In do_vmi_munmap(), calls can_modify_mm() before any
update is made to VMAs.

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 include/linux/mm.h |  2 +-
 mm/mmap.c          | 21 +++++++++++++--------
 mm/mremap.c        |  5 +++--
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b09df8501987..f2f316522f2a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3279,7 +3279,7 @@ extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
 extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
-			 bool unlock);
+			 bool unlock, unsigned long checkSeals);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
diff --git a/mm/mmap.c b/mm/mmap.c
index 414ac31aa9fa..62d592f16f45 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2601,6 +2601,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * @len: The length of the range to munmap
  * @uf: The userfaultfd list_head
  * @unlock: set to true if the user wants to drop the mmap_lock on success
+ * @checkSeals: seal type to check.
  *
  * This function takes a @mas that is either pointing to the previous VMA or set
  * to MA_START and sets it up to remove the mapping(s).  The @len will be
@@ -2611,7 +2612,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
  */
 int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
-		  bool unlock)
+		  bool unlock, unsigned long checkSeals)
 {
 	unsigned long end;
 	struct vm_area_struct *vma;
@@ -2623,6 +2624,9 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (end == start)
 		return -EINVAL;
 
+	if (!can_modify_mm(mm, start, end, checkSeals))
+		return -EACCES;
+
 	 /* arch_unmap() might do unmaps itself.  */
 	arch_unmap(mm, start, end);
 
@@ -2650,7 +2654,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 {
 	VMA_ITERATOR(vmi, mm, start);
 
-	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
+	return do_vmi_munmap(&vmi, mm, start, len, uf, false, 0);
 }
 
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2684,7 +2688,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	/* Unmap any existing mapping in the area */
-	if (do_vmi_munmap(&vmi, mm, addr, len, uf, false))
+	if (do_vmi_munmap(&vmi, mm, addr, len, uf, false, 0))
 		return -ENOMEM;
 
 	/*
@@ -2909,7 +2913,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return error;
 }
 
-static int __vm_munmap(unsigned long start, size_t len, bool unlock)
+static int __vm_munmap(unsigned long start, size_t len, bool unlock,
+			unsigned long checkSeals)
 {
 	int ret;
 	struct mm_struct *mm = current->mm;
@@ -2919,7 +2924,7 @@ static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	ret = do_vmi_munmap(&vmi, mm, start, len, &uf, unlock);
+	ret = do_vmi_munmap(&vmi, mm, start, len, &uf, unlock, checkSeals);
 	if (ret || !unlock)
 		mmap_write_unlock(mm);
 
@@ -2929,14 +2934,14 @@ static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 
 int vm_munmap(unsigned long start, size_t len)
 {
-	return __vm_munmap(start, len, false);
+	return __vm_munmap(start, len, false, 0);
 }
 EXPORT_SYMBOL(vm_munmap);
 
 SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
 {
 	addr = untagged_addr(addr);
-	return __vm_munmap(addr, len, true);
+	return __vm_munmap(addr, len, true, MM_SEAL_MUNMAP);
 }
 
 
@@ -3168,7 +3173,7 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 	if (ret)
 		goto limits_failed;
 
-	ret = do_vmi_munmap(&vmi, mm, addr, len, &uf, 0);
+	ret = do_vmi_munmap(&vmi, mm, addr, len, &uf, 0, 0);
 	if (ret)
 		goto munmap_failed;
 
diff --git a/mm/mremap.c b/mm/mremap.c
index 056478c106ee..ac363937f8c4 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -715,7 +715,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	vma_iter_init(&vmi, mm, old_addr);
-	if (!do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false)) {
+	if (!do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false,
+				0)) {
 		/* OOM: unable to split vma, just get accounts right */
 		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
 			vm_acct_memory(old_len >> PAGE_SHIFT);
@@ -1009,7 +1010,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		}
 
 		ret = do_vmi_munmap(&vmi, mm, addr + new_len, old_len - new_len,
-				    &uf_unmap, true);
+				    &uf_unmap, true, 0);
 		if (ret)
 			goto out;
 
-- 
2.42.0.655.g421f12c284-goog

