Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B1A7CBE8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 11:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbjJQJIp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 05:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjJQJI2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 05:08:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAF7B0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:08:26 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c0ecb9a075so35841655ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697533706; x=1698138506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4l+64vDxS/g2eoGFpPCE9LGtKZAVDbLXZ7/tGX4pxw=;
        b=m8yHCrg7o8r/tDjSKF4frFq9pxrYkckaZV6S1FbfJbvZad0/pHcUoVlyRkm+JI3eOV
         4oxBs2Lzplx0L3c+HVCR1FnYTS7adD5tvCWt+KFCU6psnsjKEygnoowJUXg6gCnDEltG
         SGkqQk+yswiMDGy2ilS2eNZE24YvsE+gAM9Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533706; x=1698138506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4l+64vDxS/g2eoGFpPCE9LGtKZAVDbLXZ7/tGX4pxw=;
        b=Qp3QxX70dh6YeItMu/OOyC5wXb+aPkUsuvSCQXg9oPuKWwb2ywz1GgSRhzCxwCiKLq
         4TxI67I78u+C+lk/2SdbnMcbPVYe1qBkQR0dNxPvTWKAk/C3kzbJtG+X1lyb+V35n+uU
         FB9h8wnbzeLC5IAySurYnAubOPRRvoh9+7HuSQSmukxJ4R759y8qHrjx0TWJk62AkCAU
         pCskY1EF59ko/6/To7kgER9G+2cmyslptY73lwXCbDUlTlUWoTrQ2Y/xGopBj2jnnnIK
         6AiBVVvqA+oq1s/4/J3Ufl5EuTNmytPlKgCCnlnG214Ldgm62IGjqWEIyVmaKJmtQvF4
         21qg==
X-Gm-Message-State: AOJu0Yw5XA6iLEHCPudAqDYS98XqBWAQgDru/yNT61lwaXrvg6rERuIB
        q88FKGk3U/eSMtxbzznpAnM0Ug==
X-Google-Smtp-Source: AGHT+IH3ijh2spAMvSfaaAyElvlHfpC0/idOO3bXawN0BNxN5uSfUsaSC/pvKljbIONUXHU4GOlTmA==
X-Received: by 2002:a17:902:da83:b0:1b2:4852:9a5f with SMTP id j3-20020a170902da8300b001b248529a5fmr1721130plx.54.1697533706010;
        Tue, 17 Oct 2023 02:08:26 -0700 (PDT)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id k13-20020a170902760d00b001acae9734c0sm986537pll.266.2023.10.17.02.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:08:25 -0700 (PDT)
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
Subject: [RFC PATCH v2 7/8] mseal:Check seal flag for mmap(2)
Date:   Tue, 17 Oct 2023 09:08:14 +0000
Message-ID: <20231017090815.1067790-8-jeffxu@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231017090815.1067790-1-jeffxu@chromium.org>
References: <20231017090815.1067790-1-jeffxu@chromium.org>
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

mmap(2) can change a protection of existing VMAs.
Sealing will prevent unintended mmap(2) call.

What this patch does:
When a mmap(2) is invoked, if one of its VMAs has MM_SEAL_MMAP set
from previous mseal(2) call, the mmap(2) will fail, without any
VMAs modified.

The patch is based on following:
There are two cases: with MMU, NO MMU.

For MMU case:
1. ksys_mmap_pgoff() currently are called in 2 places:
SYSCALL_DEFINE1(old_mmap, ...)
SYSCALL_DEFINE6(mmap_pgoff,...)
Since both are syscall entry point, omit adding
checkSeals in the signature of ksys_mmap_pgoff().

2. ksys_mmap_pgoff() calls vm_mmap_pgoff() with
checkSeals = MM_SEAL_MMAP, in turn, checkSeals flag is
passed into do_mmap(),
Note: Of all the call paths that goes into do_mmap(),
ksys_mmap_pgoff() is the only place where
checkSeals = MM_SEAL_MMAP. The rest has checkSeals = 0.

3. In do_mmap(), call can_modify_mm() before any update
is maded to the VMAs.

For NON-MMU case:
Set checkSeals = 0 for all cases.

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 fs/aio.c           |  5 +++--
 include/linux/mm.h |  5 ++++-
 ipc/shm.c          |  3 ++-
 mm/internal.h      |  4 ++--
 mm/mmap.c          | 22 ++++++++++++++++++----
 mm/nommu.c         |  6 ++++--
 mm/util.c          |  8 +++++---
 7 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index b3174da80ff6..7f4863d0082d 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -557,8 +557,9 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	}
 
 	ctx->mmap_base = do_mmap(ctx->aio_ring_file, 0, ctx->mmap_size,
-				 PROT_READ | PROT_WRITE,
-				 MAP_SHARED, 0, &unused, NULL);
+				PROT_READ | PROT_WRITE, MAP_SHARED, 0, &unused,
+				NULL, 0);
+
 	mmap_write_unlock(mm);
 	if (IS_ERR((void *)ctx->mmap_base)) {
 		ctx->mmap_size = 0;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f2f316522f2a..9f496c9f2970 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3274,9 +3274,12 @@ extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned lo
 extern unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 	struct list_head *uf);
+
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
-	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
+	unsigned long pgoff, unsigned long *populate, struct list_head *uf,
+	unsigned long checkSeals);
+
 extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
 			 bool unlock, unsigned long checkSeals);
diff --git a/ipc/shm.c b/ipc/shm.c
index 60e45e7045d4..3660f522ecba 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1662,7 +1662,8 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 			goto invalid;
 	}
 
-	addr = do_mmap(file, addr, size, prot, flags, 0, &populate, NULL);
+	addr = do_mmap(file, addr, size, prot, flags, 0, &populate, NULL,
+			0);
 	*raddr = addr;
 	err = 0;
 	if (IS_ERR_VALUE(addr))
diff --git a/mm/internal.h b/mm/internal.h
index d1d4bf4e63c0..2c074d8c6abd 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -800,8 +800,8 @@ extern u64 hwpoison_filter_memcg;
 extern u32 hwpoison_filter_enable;
 
 extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
-        unsigned long, unsigned long,
-        unsigned long, unsigned long);
+	unsigned long, unsigned long, unsigned long, unsigned long,
+	unsigned long checkSeals);
 
 extern void set_pageblock_order(void);
 unsigned long reclaim_pages(struct list_head *folio_list);
diff --git a/mm/mmap.c b/mm/mmap.c
index 62d592f16f45..edcadd2bb394 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1197,7 +1197,8 @@ static inline bool file_mmap_ok(struct file *file, struct inode *inode,
 unsigned long do_mmap(struct file *file, unsigned long addr,
 			unsigned long len, unsigned long prot,
 			unsigned long flags, unsigned long pgoff,
-			unsigned long *populate, struct list_head *uf)
+			unsigned long *populate, struct list_head *uf,
+			unsigned long checkSeals)
 {
 	struct mm_struct *mm = current->mm;
 	vm_flags_t vm_flags;
@@ -1365,6 +1366,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_NORESERVE;
 	}
 
+	if (!can_modify_mm(mm, addr, addr + len, MM_SEAL_MMAP))
+		return -EACCES;
+
 	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf);
 	if (!IS_ERR_VALUE(addr) &&
 	    ((vm_flags & VM_LOCKED) ||
@@ -1411,7 +1415,17 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 			return PTR_ERR(file);
 	}
 
-	retval = vm_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	/*
+	 * vm_mmap_pgoff() currently called from two places:
+	 * SYSCALL_DEFINE1(old_mmap, ...)
+	 * SYSCALL_DEFINE6(mmap_pgoff,...)
+	 * and not in any other places.
+	 * Therefore, omit changing the signature of vm_mmap_pgoff()
+	 * Otherwise, we might need to add checkSeals and pass it
+	 * from all callers of vm_mmap_pgoff().
+	 */
+	retval = vm_mmap_pgoff(file, addr, len, prot, flags, pgoff,
+				MM_SEAL_MMAP);
 out_fput:
 	if (file)
 		fput(file);
@@ -3016,8 +3030,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 		flags |= MAP_LOCKED;
 
 	file = get_file(vma->vm_file);
-	ret = do_mmap(vma->vm_file, start, size,
-			prot, flags, pgoff, &populate, NULL);
+	ret = do_mmap(vma->vm_file, start, size, prot, flags, pgoff,
+			&populate, NULL, 0);
 	fput(file);
 out:
 	mmap_write_unlock(mm);
diff --git a/mm/nommu.c b/mm/nommu.c
index 8dba41cfc44d..dc83651ee777 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1018,7 +1018,8 @@ unsigned long do_mmap(struct file *file,
 			unsigned long flags,
 			unsigned long pgoff,
 			unsigned long *populate,
-			struct list_head *uf)
+			struct list_head *uf,
+			unsigned long checkSeals)
 {
 	struct vm_area_struct *vma;
 	struct vm_region *region;
@@ -1262,7 +1263,8 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 			goto out;
 	}
 
-	retval = vm_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	retval = vm_mmap_pgoff(file, addr, len, prot, flags, pgoff,
+				0);
 
 	if (file)
 		fput(file);
diff --git a/mm/util.c b/mm/util.c
index 4ed8b9b5273c..ca9d8c69267c 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -532,7 +532,8 @@ EXPORT_SYMBOL_GPL(account_locked_vm);
 
 unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
-	unsigned long flag, unsigned long pgoff)
+	unsigned long flag, unsigned long pgoff,
+	unsigned long checkseals)
 {
 	unsigned long ret;
 	struct mm_struct *mm = current->mm;
@@ -544,7 +545,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 		if (mmap_write_lock_killable(mm))
 			return -EINTR;
 		ret = do_mmap(file, addr, len, prot, flag, pgoff, &populate,
-			      &uf);
+			      &uf, checkseals);
 		mmap_write_unlock(mm);
 		userfaultfd_unmap_complete(mm, &uf);
 		if (populate)
@@ -562,7 +563,8 @@ unsigned long vm_mmap(struct file *file, unsigned long addr,
 	if (unlikely(offset_in_page(offset)))
 		return -EINVAL;
 
-	return vm_mmap_pgoff(file, addr, len, prot, flag, offset >> PAGE_SHIFT);
+	return vm_mmap_pgoff(file, addr, len, prot, flag, offset >> PAGE_SHIFT,
+				0);
 }
 EXPORT_SYMBOL(vm_mmap);
 
-- 
2.42.0.655.g421f12c284-goog

