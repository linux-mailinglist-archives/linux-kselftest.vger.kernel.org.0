Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6D67CABBC
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 16:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjJPOjM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjJPOjI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 10:39:08 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CE1FA
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 07:39:06 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5aa7172bafdso1836746a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697467146; x=1698071946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/gIGzcs1doxA1NJxoF7qbwpya/fXwG7eIiuzPMtoy8=;
        b=P1sBQgC1gJNrrGRM4CrWNJlPdNasSiTHvM5bN43pz/yphaaDMjeQ651fmF0OUs8xsh
         M7VBM4hmTSXDzYQXrrW5mqdAAAT3GWGUOanEHLz5vlaq564GBB4izqHEAlMnlcabQ346
         GoK5g6IUO5/D9Kq3hYnYob2tZ0UwmUOv4+MkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697467146; x=1698071946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/gIGzcs1doxA1NJxoF7qbwpya/fXwG7eIiuzPMtoy8=;
        b=XFrK9Z8YBNLqTR9L6eN5xwJYw8cnCuN7TX/kSILjhWcDmd8cPIut/SjTBv073J52pT
         1mdj0spmss/m8tah3Z3Q9Aaejccntk/4aPrkoNw5sgbfs5JLjsZfVxGYzThyLFCrY6Sz
         Dso2EHzfAlG5+y2XTl8wJ2uT/U/l6J/afQnvsbpy93iShGp2M0WOy0rMaN+nWao4A2GS
         behd5sLusgRkv9vC3zUA/4VmQxo7bqn7WD4T4xCFZ/9nz70NaWTROdQvzGTarhIp5xBn
         MUd+4gsI5+KTte/POgLcxBBUeVmsvjrDhsDfg8NWjod/rMmeSnbM5f9dzZL2PdGM6dqO
         GeIA==
X-Gm-Message-State: AOJu0Yy0XjY9Resw4aFXKcbX1wnI0+YyjsExN07iR/u3P4c/DLfgotfE
        wqQAcigJvLG0QmWRRjLnIFrDww==
X-Google-Smtp-Source: AGHT+IGJ+u/+BP/wEz8Z/WX19EscYJm5hsgzyBNr8KRyM+S3cXUOr85FAH7+MHGwT0v4RcdPcoyC1A==
X-Received: by 2002:a05:6a20:3c89:b0:173:3ef3:236a with SMTP id b9-20020a056a203c8900b001733ef3236amr14858732pzj.21.1697467145854;
        Mon, 16 Oct 2023 07:39:05 -0700 (PDT)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id jw10-20020a170903278a00b001c5fa48b9a0sm8574385plb.33.2023.10.16.07.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 07:39:05 -0700 (PDT)
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
Subject: [RFC PATCH v1 7/8] mseal mmap
Date:   Mon, 16 Oct 2023 14:38:26 +0000
Message-ID: <20231016143828.647848-8-jeffxu@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016143828.647848-1-jeffxu@chromium.org>
References: <20231016143828.647848-1-jeffxu@chromium.org>
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

check seal for mmap(2)

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 fs/aio.c           |  5 +++--
 include/linux/mm.h |  5 ++++-
 ipc/shm.c          |  3 ++-
 mm/internal.h      |  4 ++--
 mm/mmap.c          | 13 +++++++++----
 mm/nommu.c         |  6 ++++--
 mm/util.c          |  8 +++++---
 7 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index b3174da80ff6..81040126dd45 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -557,8 +557,9 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	}
 
 	ctx->mmap_base = do_mmap(ctx->aio_ring_file, 0, ctx->mmap_size,
-				 PROT_READ | PROT_WRITE,
-				 MAP_SHARED, 0, &unused, NULL);
+				PROT_READ | PROT_WRITE, MAP_SHARED, 0, &unused,
+				NULL, ON_BEHALF_OF_KERNEL);
+
 	mmap_write_unlock(mm);
 	if (IS_ERR((void *)ctx->mmap_base)) {
 		ctx->mmap_size = 0;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 95b793eb3a80..ffa2eb9bd475 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3289,9 +3289,12 @@ extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned lo
 extern unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 	struct list_head *uf);
+
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
-	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
+	unsigned long pgoff, unsigned long *populate, struct list_head *uf,
+	enum caller_origin called);
+
 extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
 			 bool unlock, enum caller_origin called);
diff --git a/ipc/shm.c b/ipc/shm.c
index 60e45e7045d4..14aebeefe155 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1662,7 +1662,8 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 			goto invalid;
 	}
 
-	addr = do_mmap(file, addr, size, prot, flags, 0, &populate, NULL);
+	addr = do_mmap(file, addr, size, prot, flags, 0, &populate, NULL,
+			ON_BEHALF_OF_KERNEL);
 	*raddr = addr;
 	err = 0;
 	if (IS_ERR_VALUE(addr))
diff --git a/mm/internal.h b/mm/internal.h
index d1d4bf4e63c0..4361eaf3d1c6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -800,8 +800,8 @@ extern u64 hwpoison_filter_memcg;
 extern u32 hwpoison_filter_enable;
 
 extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
-        unsigned long, unsigned long,
-        unsigned long, unsigned long);
+	unsigned long, unsigned long, unsigned long, unsigned long,
+	enum caller_origin called);
 
 extern void set_pageblock_order(void);
 unsigned long reclaim_pages(struct list_head *folio_list);
diff --git a/mm/mmap.c b/mm/mmap.c
index f4bfcc5d2c10..a42fe27a7d04 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1197,7 +1197,8 @@ static inline bool file_mmap_ok(struct file *file, struct inode *inode,
 unsigned long do_mmap(struct file *file, unsigned long addr,
 			unsigned long len, unsigned long prot,
 			unsigned long flags, unsigned long pgoff,
-			unsigned long *populate, struct list_head *uf)
+			unsigned long *populate, struct list_head *uf,
+			enum caller_origin called)
 {
 	struct mm_struct *mm = current->mm;
 	vm_flags_t vm_flags;
@@ -1365,6 +1366,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_NORESERVE;
 	}
 
+	if (!can_modify_mm(mm, addr, addr + len, MM_ACTION_MMAP, called))
+		return -EACCES;
+
 	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf);
 	if (!IS_ERR_VALUE(addr) &&
 	    ((vm_flags & VM_LOCKED) ||
@@ -1411,7 +1415,8 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 			return PTR_ERR(file);
 	}
 
-	retval = vm_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	retval = vm_mmap_pgoff(file, addr, len, prot, flags, pgoff,
+				ON_BEHALF_OF_USERSPACE);
 out_fput:
 	if (file)
 		fput(file);
@@ -3017,8 +3022,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 		flags |= MAP_LOCKED;
 
 	file = get_file(vma->vm_file);
-	ret = do_mmap(vma->vm_file, start, size,
-			prot, flags, pgoff, &populate, NULL);
+	ret = do_mmap(vma->vm_file, start, size, prot, flags, pgoff,
+			&populate, NULL, ON_BEHALF_OF_KERNEL);
 	fput(file);
 out:
 	mmap_write_unlock(mm);
diff --git a/mm/nommu.c b/mm/nommu.c
index 8dba41cfc44d..8c11de5dd8e6 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1018,7 +1018,8 @@ unsigned long do_mmap(struct file *file,
 			unsigned long flags,
 			unsigned long pgoff,
 			unsigned long *populate,
-			struct list_head *uf)
+			struct list_head *uf,
+			enum caller_origin called)
 {
 	struct vm_area_struct *vma;
 	struct vm_region *region;
@@ -1262,7 +1263,8 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 			goto out;
 	}
 
-	retval = vm_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	retval = vm_mmap_pgoff(file, addr, len, prot, flags, pgoff,
+				ON_BEHALF_OF_USERSPACE);
 
 	if (file)
 		fput(file);
diff --git a/mm/util.c b/mm/util.c
index 4ed8b9b5273c..aaf37c3af517 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -532,7 +532,8 @@ EXPORT_SYMBOL_GPL(account_locked_vm);
 
 unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
-	unsigned long flag, unsigned long pgoff)
+	unsigned long flag, unsigned long pgoff,
+	enum caller_origin called)
 {
 	unsigned long ret;
 	struct mm_struct *mm = current->mm;
@@ -544,7 +545,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 		if (mmap_write_lock_killable(mm))
 			return -EINTR;
 		ret = do_mmap(file, addr, len, prot, flag, pgoff, &populate,
-			      &uf);
+			      &uf, called);
 		mmap_write_unlock(mm);
 		userfaultfd_unmap_complete(mm, &uf);
 		if (populate)
@@ -562,7 +563,8 @@ unsigned long vm_mmap(struct file *file, unsigned long addr,
 	if (unlikely(offset_in_page(offset)))
 		return -EINVAL;
 
-	return vm_mmap_pgoff(file, addr, len, prot, flag, offset >> PAGE_SHIFT);
+	return vm_mmap_pgoff(file, addr, len, prot, flag, offset >> PAGE_SHIFT,
+				ON_BEHALF_OF_KERNEL);
 }
 EXPORT_SYMBOL(vm_mmap);
 
-- 
2.42.0.609.gbb76f46606-goog

