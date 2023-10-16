Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D427CABB8
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 16:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjJPOjH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 10:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjJPOjG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 10:39:06 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539ADD9
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 07:39:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b44befac59so2085182b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 07:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697467144; x=1698071944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToXeatSf9Mfv/4ML/0TPcwOvX/byGqXHxsHhNXC33wk=;
        b=fkq+43Z4+iLQm5AqikeaX/UZZ8GiW/Cd653QDxtTz214LLDzQ5UWDJ/k/YHc7HdxHC
         jk97fPVkshRr4rlDTJOZrgJqy0AQjBfWTBKIGIRx66uyB5o4qfGbO9SNug1zULuIb7aN
         wtbCsY14EMtdfpJq3NCd8oYoGA5q2iTPRx27Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697467144; x=1698071944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToXeatSf9Mfv/4ML/0TPcwOvX/byGqXHxsHhNXC33wk=;
        b=RkW007bPui7GD8QMt9qvpa28nDwa7+WJ+qzPLX8K0E80ZrxITa/7/x5DVFz8VpHvID
         5DfAO2yWl3g75VkG4uJqdQhN0/ZJTSIM/Qpj6G/b21V+K9fDK30sksZCQK363+y086sc
         RpKsCpFPBdLVvnKwHnPBz+ZRHOLY9tLhh9qHMcauF1bGpDkieVRhQ+V4bGLuzjwuc3t6
         iyCCAliSm4t9p1X+UFSsXvOpNbkSjVGm9lddBUKm3f990NC9gvzaRnLBvQNd9e0Xp6zb
         MUoZKzIW5CVqWMhKMTJ0H5SG+WTY/WLA49+jGx/ee/UvHBbgvv6nO6UVMWuVNpzxQCxd
         5Wfg==
X-Gm-Message-State: AOJu0Yx2kvsWB1WX5DXcDVgPCAT5aaZkFpo8OZufOMeeUxgVGRAm6Tob
        PiFkBE+Ip6wFU3e1HcOaguMAZg==
X-Google-Smtp-Source: AGHT+IGTMvdTkJGIXeUoXD08iW19uI3xY7OaVN1hUVre2xWAlvcHGioIeC96pEHSOxAKKy9n0wApCA==
X-Received: by 2002:a05:6a20:1614:b0:133:1d62:dcbd with SMTP id l20-20020a056a20161400b001331d62dcbdmr10851831pzj.28.1697467143679;
        Mon, 16 Oct 2023 07:39:03 -0700 (PDT)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id j18-20020aa79292000000b006875df4773fsm18206313pfa.163.2023.10.16.07.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 07:39:03 -0700 (PDT)
From:   jeffxu@chromium.org
To:     akpm@linux-foundation.org, keescook@chromium.org,
        sroettger@google.com
Cc:     jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, surenb@google.com,
        alex.sierra@amd.com, apopple@nvidia.com,
        aneesh.kumar@linux.ibm.com, axelrasmussen@google.com,
        ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com,
        dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com,
        joey.gouly@arm.com, corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        lstoakes@gmail.com, willy@infradead.org, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [RFC PATCH v1 5/8] mseal munmap
Date:   Mon, 16 Oct 2023 14:38:24 +0000
Message-ID: <20231016143828.647848-6-jeffxu@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016143828.647848-1-jeffxu@chromium.org>
References: <20231016143828.647848-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

check seal for munmap(2).

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 include/linux/mm.h |  2 +-
 mm/mmap.c          | 22 ++++++++++++++--------
 mm/mremap.c        |  5 +++--
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index aafdb68950f8..95b793eb3a80 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3294,7 +3294,7 @@ extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
 extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
-			 bool unlock);
+			 bool unlock, enum caller_origin called);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
diff --git a/mm/mmap.c b/mm/mmap.c
index 9b6c477e713e..f4bfcc5d2c10 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2601,6 +2601,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * @len: The length of the range to munmap
  * @uf: The userfaultfd list_head
  * @unlock: set to true if the user wants to drop the mmap_lock on success
+ * @called: caller origin
  *
  * This function takes a @mas that is either pointing to the previous VMA or set
  * to MA_START and sets it up to remove the mapping(s).  The @len will be
@@ -2611,7 +2612,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
  */
 int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
-		  bool unlock)
+		  bool unlock, enum caller_origin called)
 {
 	unsigned long end;
 	struct vm_area_struct *vma;
@@ -2623,6 +2624,9 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (end == start)
 		return -EINVAL;
 
+	if (!can_modify_mm(mm, start, end, MM_ACTION_MUNMAP, called))
+		return -EACCES;
+
 	 /* arch_unmap() might do unmaps itself.  */
 	arch_unmap(mm, start, end);
 
@@ -2650,7 +2654,8 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 {
 	VMA_ITERATOR(vmi, mm, start);
 
-	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
+	return do_vmi_munmap(&vmi, mm, start, len, uf, false,
+				ON_BEHALF_OF_KERNEL);
 }
 
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2684,7 +2689,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	/* Unmap any existing mapping in the area */
-	if (do_vmi_munmap(&vmi, mm, addr, len, uf, false))
+	if (do_vmi_munmap(&vmi, mm, addr, len, uf, false, ON_BEHALF_OF_KERNEL))
 		return -ENOMEM;
 
 	/*
@@ -2909,7 +2914,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return error;
 }
 
-static int __vm_munmap(unsigned long start, size_t len, bool unlock)
+static int __vm_munmap(unsigned long start, size_t len, bool unlock,
+			enum caller_origin called)
 {
 	int ret;
 	struct mm_struct *mm = current->mm;
@@ -2919,7 +2925,7 @@ static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	ret = do_vmi_munmap(&vmi, mm, start, len, &uf, unlock);
+	ret = do_vmi_munmap(&vmi, mm, start, len, &uf, unlock, called);
 	if (ret || !unlock)
 		mmap_write_unlock(mm);
 
@@ -2929,14 +2935,14 @@ static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 
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
 
 
@@ -3168,7 +3174,7 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 	if (ret)
 		goto limits_failed;
 
-	ret = do_vmi_munmap(&vmi, mm, addr, len, &uf, 0);
+	ret = do_vmi_munmap(&vmi, mm, addr, len, &uf, 0, ON_BEHALF_OF_KERNEL);
 	if (ret)
 		goto munmap_failed;
 
diff --git a/mm/mremap.c b/mm/mremap.c
index 056478c106ee..e43f9ceaa29d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -715,7 +715,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	vma_iter_init(&vmi, mm, old_addr);
-	if (!do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false)) {
+	if (!do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false,
+				ON_BEHALF_OF_KERNEL)) {
 		/* OOM: unable to split vma, just get accounts right */
 		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
 			vm_acct_memory(old_len >> PAGE_SHIFT);
@@ -1009,7 +1010,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		}
 
 		ret = do_vmi_munmap(&vmi, mm, addr + new_len, old_len - new_len,
-				    &uf_unmap, true);
+				    &uf_unmap, true, ON_BEHALF_OF_KERNEL);
 		if (ret)
 			goto out;
 
-- 
2.42.0.609.gbb76f46606-goog

