Return-Path: <linux-kselftest+bounces-1762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7944F80FB2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 00:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C2FB20F21
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 23:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B4C64CDB;
	Tue, 12 Dec 2023 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SVnvx4Kv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F71EA
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 15:17:18 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-5908a63a83fso3281132eaf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 15:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702423038; x=1703027838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hi31AjxJtNZjlJknX0J3BHnj/VEX2GCu7NwkPG/5ME=;
        b=SVnvx4Kv7VfUbtzFewZaPKducGIyowYGkR4SRcsDB29q2C800rgrYLWJMuNJmy1VGP
         qtFqp6amVjfGe8Q0UKjLhnvZPIrJ7BGyRFe9K+J4uAc7y3+KhuzC/qushJhxYiFiChP5
         mDu6LxxYTM7gBfvxZFkXJU7A8YZm8+3Z3TKQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423038; x=1703027838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hi31AjxJtNZjlJknX0J3BHnj/VEX2GCu7NwkPG/5ME=;
        b=G6IxLUfGZSrSIwcnffo516XqNWMWjPHwKqEdb78xaEF06+flwf3K67E1EbgFxSoCR3
         WXLnh/z5ViVzoaQPYENAQeKXPFMqluhlji409XedHRA+qN3r1q+re5wDfrEltELO0WI8
         6PUhqzCwZGh5JrIzZJ75zvgdJFPiBsufqye9eg6fBpy5qYXe193U37NblxhdF+6Ckq6P
         5ZdndQ9GiVeuVXjFC4KyyEMVQ7QaN3NGdCL81QS1JsET1MiGSsUuPzDbeImojxIYR+Kb
         Ag1OHf59d/X432276dKy/GxQxqPV1q9rtYuyZh7lq3E8oivHceuXo/Kubj4zvmLciWUU
         ptAQ==
X-Gm-Message-State: AOJu0Yz0Ude7JlbsOvrdIiS1O5G+gT9cZ7uYjV42Q2LtJ0mRPtCMzYQS
	7eQ8Nc6Qt9WTYLzZ23+F42PYvw==
X-Google-Smtp-Source: AGHT+IHQHtOqaKUE81zeaJCn2q6SFy9/JngG9UEh+z5j67n5lmwKX/FrsIt4S5/AHC8z+ShhO7V8gw==
X-Received: by 2002:a05:6358:9394:b0:170:5200:e1b2 with SMTP id h20-20020a056358939400b001705200e1b2mr7564052rwb.4.1702423037735;
        Tue, 12 Dec 2023 15:17:17 -0800 (PST)
Received: from localhost (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.gmail.com with UTF8SMTPSA id w5-20020a056a0014c500b006ce2e77ec4csm8687959pfu.193.2023.12.12.15.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 15:17:17 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pedro.falcato@gmail.com,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	deraadt@openbsd.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v3 07/11] mseal: make sealed VMA mergeable.
Date: Tue, 12 Dec 2023 23:17:01 +0000
Message-ID: <20231212231706.2680890-8-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231212231706.2680890-1-jeffxu@chromium.org>
References: <20231212231706.2680890-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add merge/split handling for mlock/madvice/mprotect/mmap case.
Make sealed VMA mergeable with adjacent VMAs.

This is so that we don't run out of VMAs, i.e. there is a max
number of VMA per process.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Suggested-by: Jann Horn <jannh@google.com>
---
 fs/userfaultfd.c   |  8 +++++---
 include/linux/mm.h | 31 +++++++++++++------------------
 mm/madvise.c       |  2 +-
 mm/mempolicy.c     |  2 +-
 mm/mlock.c         |  2 +-
 mm/mmap.c          | 44 +++++++++++++++++++++-----------------------
 mm/mprotect.c      |  2 +-
 mm/mremap.c        |  2 +-
 mm/mseal.c         | 23 ++++++++++++++++++-----
 9 files changed, 62 insertions(+), 54 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 56eaae9dac1a..8ebee7c1c6cf 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -926,7 +926,8 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 				 new_flags, vma->anon_vma,
 				 vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
-				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
+				 NULL_VM_UFFD_CTX, anon_vma_name(vma),
+				vma_seals(vma));
 		if (prev) {
 			vma = prev;
 		} else {
@@ -1483,7 +1484,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 				 vma->anon_vma, vma->vm_file, pgoff,
 				 vma_policy(vma),
 				 ((struct vm_userfaultfd_ctx){ ctx }),
-				 anon_vma_name(vma));
+				 anon_vma_name(vma), vma_seals(vma));
 		if (prev) {
 			/* vma_merge() invalidated the mas */
 			vma = prev;
@@ -1668,7 +1669,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, pgoff,
 				 vma_policy(vma),
-				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
+				 NULL_VM_UFFD_CTX, anon_vma_name(vma),
+				vma_seals(vma));
 		if (prev) {
 			vma = prev;
 			goto next;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5d3ee79f1438..1f162bb5b38d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3243,7 +3243,7 @@ extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
 	unsigned long end, unsigned long vm_flags, struct anon_vma *,
 	struct file *, pgoff_t, struct mempolicy *, struct vm_userfaultfd_ctx,
-	struct anon_vma_name *);
+	struct anon_vma_name *, unsigned long vm_seals);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
 extern int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
 		       unsigned long addr, int new_below);
@@ -3327,19 +3327,6 @@ static inline void mm_populate(unsigned long addr, unsigned long len) {}
 #endif
 
 #ifdef CONFIG_MSEAL
-static inline bool check_vma_seals_mergeable(unsigned long vm_seals)
-{
-	/*
-	 * Set sealed VMA not mergeable with another VMA for now.
-	 * This will be changed in later commit to make sealed
-	 * VMA also mergeable.
-	 */
-	if (vm_seals & MM_SEAL_ALL)
-		return false;
-
-	return true;
-}
-
 /*
  * return the valid sealing (after mask).
  */
@@ -3353,6 +3340,14 @@ static inline void update_vma_seals(struct vm_area_struct *vma, unsigned long vm
 	vma->vm_seals |= vm_seals;
 }
 
+static inline bool check_vma_seals_mergeable(unsigned long vm_seals1, unsigned long vm_seals2)
+{
+	if ((vm_seals1 & MM_SEAL_ALL) != (vm_seals2 & MM_SEAL_ALL))
+		return false;
+
+	return true;
+}
+
 extern bool can_modify_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end, unsigned long checkSeals);
 
@@ -3390,14 +3385,14 @@ static inline int check_mmap_seals(unsigned long prot, unsigned long *vm_seals)
 	return 0;
 }
 #else
-static inline bool check_vma_seals_mergeable(unsigned long vm_seals1)
+static inline unsigned long vma_seals(struct vm_area_struct *vma)
 {
-	return true;
+	return 0;
 }
 
-static inline unsigned long vma_seals(struct vm_area_struct *vma)
+static inline bool check_vma_seals_mergeable(unsigned long vm_seals1, unsigned long vm_seals2)
 {
-	return 0;
+	return true;
 }
 
 static inline bool can_modify_mm(struct mm_struct *mm, unsigned long start,
diff --git a/mm/madvise.c b/mm/madvise.c
index 4dded5d27e7e..e2d219a4b6ef 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -152,7 +152,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 	*prev = vma_merge(&vmi, mm, *prev, start, end, new_flags,
 			  vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			  vma->vm_userfaultfd_ctx, anon_name);
+			  vma->vm_userfaultfd_ctx, anon_name, vma_seals(vma));
 	if (*prev) {
 		vma = *prev;
 		goto success;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e52e3a0b8f2e..e70b69c64564 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -836,7 +836,7 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	pgoff = vma->vm_pgoff + ((vmstart - vma->vm_start) >> PAGE_SHIFT);
 	merged = vma_merge(vmi, vma->vm_mm, *prev, vmstart, vmend, vma->vm_flags,
 			 vma->anon_vma, vma->vm_file, pgoff, new_pol,
-			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+			 vma->vm_userfaultfd_ctx, anon_vma_name(vma), vma_seals(vma));
 	if (merged) {
 		*prev = merged;
 		return vma_replace_policy(merged, new_pol);
diff --git a/mm/mlock.c b/mm/mlock.c
index 06bdfab83b58..b537a2cbd337 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -428,7 +428,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 	*prev = vma_merge(vmi, mm, *prev, start, end, newflags,
 			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+			vma->vm_userfaultfd_ctx, anon_vma_name(vma), vma_seals(vma));
 	if (*prev) {
 		vma = *prev;
 		goto success;
diff --git a/mm/mmap.c b/mm/mmap.c
index 3e1bf5a131b0..6da8d83f2e66 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -720,7 +720,8 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 static inline bool is_mergeable_vma(struct vm_area_struct *vma,
 		struct file *file, unsigned long vm_flags,
 		struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name, bool may_remove_vma)
+		struct anon_vma_name *anon_name, bool may_remove_vma,
+		unsigned long vm_seals)
 {
 	/*
 	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
@@ -740,7 +741,7 @@ static inline bool is_mergeable_vma(struct vm_area_struct *vma,
 		return false;
 	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
 		return false;
-	if (!check_vma_seals_mergeable(vma_seals(vma)))
+	if (!check_vma_seals_mergeable(vma_seals(vma), vm_seals))
 		return false;
 
 	return true;
@@ -776,9 +777,10 @@ static bool
 can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
 		struct anon_vma *anon_vma, struct file *file,
 		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name)
+		struct anon_vma_name *anon_name, unsigned long vm_seals)
 {
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, true) &&
+	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx,
+		anon_name, true, vm_seals) &&
 	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
 		if (vma->vm_pgoff == vm_pgoff)
 			return true;
@@ -799,9 +801,10 @@ static bool
 can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
 		struct anon_vma *anon_vma, struct file *file,
 		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name)
+		struct anon_vma_name *anon_name, unsigned long vm_seals)
 {
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, false) &&
+	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx,
+		anon_name, false, vm_seals) &&
 	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
 		pgoff_t vm_pglen;
 		vm_pglen = vma_pages(vma);
@@ -869,7 +872,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			struct anon_vma *anon_vma, struct file *file,
 			pgoff_t pgoff, struct mempolicy *policy,
 			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-			struct anon_vma_name *anon_name)
+			struct anon_vma_name *anon_name, unsigned long vm_seals)
 {
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
@@ -908,7 +911,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		/* Can we merge the predecessor? */
 		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
 		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
-					   pgoff, vm_userfaultfd_ctx, anon_name)) {
+			pgoff, vm_userfaultfd_ctx, anon_name, vm_seals)) {
 			merge_prev = true;
 			vma_prev(vmi);
 		}
@@ -917,7 +920,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	/* Can we merge the successor? */
 	if (next && mpol_equal(policy, vma_policy(next)) &&
 	    can_vma_merge_before(next, vm_flags, anon_vma, file, pgoff+pglen,
-				 vm_userfaultfd_ctx, anon_name)) {
+			vm_userfaultfd_ctx, anon_name, vm_seals)) {
 		merge_next = true;
 	}
 
@@ -2727,13 +2730,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	next = vma_next(&vmi);
 	prev = vma_prev(&vmi);
-	/*
-	 * For now, sealed VMA doesn't merge with other VMA,
-	 * Will change this in later commit when we make sealed VMA
-	 * also mergeable.
-	 */
-	if ((vm_flags & VM_SPECIAL) ||
-		(vm_seals & MM_SEAL_ALL)) {
+
+	if (vm_flags & VM_SPECIAL) {
 		if (prev)
 			vma_iter_next_range(&vmi);
 		goto cannot_expand;
@@ -2743,7 +2741,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Check next */
 	if (next && next->vm_start == end && !vma_policy(next) &&
 	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
-				 NULL_VM_UFFD_CTX, NULL)) {
+			NULL_VM_UFFD_CTX, NULL, vm_seals)) {
 		merge_end = next->vm_end;
 		vma = next;
 		vm_pgoff = next->vm_pgoff - pglen;
@@ -2752,9 +2750,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Check prev */
 	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
 	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
-				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
+			pgoff, vma->vm_userfaultfd_ctx, NULL, vm_seals) :
 		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
-				       NULL_VM_UFFD_CTX, NULL))) {
+			NULL_VM_UFFD_CTX, NULL, vm_seals))) {
 		merge_start = prev->vm_start;
 		vma = prev;
 		vm_pgoff = prev->vm_pgoff;
@@ -2822,7 +2820,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			merge = vma_merge(&vmi, mm, prev, vma->vm_start,
 				    vma->vm_end, vma->vm_flags, NULL,
 				    vma->vm_file, vma->vm_pgoff, NULL,
-				    NULL_VM_UFFD_CTX, NULL);
+				    NULL_VM_UFFD_CTX, NULL, vma_seals(vma));
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -3130,14 +3128,14 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
-
 	/*
 	 * Expand the existing vma if possible; Note that singular lists do not
 	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
 	if (vma && vma->vm_end == addr && !vma_policy(vma) &&
 	    can_vma_merge_after(vma, flags, NULL, NULL,
-				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
+			addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL,
+			vma_seals(vma))) {
 		vma_iter_config(vmi, vma->vm_start, addr + len);
 		if (vma_iter_prealloc(vmi, vma))
 			goto unacct_fail;
@@ -3380,7 +3378,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 
 	new_vma = vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+			    vma->vm_userfaultfd_ctx, anon_vma_name(vma), vma_seals(vma));
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 1527188b1e92..a4c90e71607b 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -632,7 +632,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 	*pprev = vma_merge(vmi, mm, *pprev, start, end, newflags,
 			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+			   vma->vm_userfaultfd_ctx, anon_vma_name(vma), vma_seals(vma));
 	if (*pprev) {
 		vma = *pprev;
 		VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);
diff --git a/mm/mremap.c b/mm/mremap.c
index ff7429bfbbe1..357efd6b48b9 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1098,7 +1098,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 			vma = vma_merge(&vmi, mm, vma, extension_start,
 				extension_end, vma->vm_flags, vma->anon_vma,
 				vma->vm_file, extension_pgoff, vma_policy(vma),
-				vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+				vma->vm_userfaultfd_ctx, anon_vma_name(vma), vma_seals(vma));
 			if (!vma) {
 				vm_unacct_memory(pages);
 				ret = -ENOMEM;
diff --git a/mm/mseal.c b/mm/mseal.c
index d12aa628ebdc..3b90dce7d20e 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -7,8 +7,10 @@
  *  Author: Jeff Xu <jeffxu@chromium.org>
  */
 
+#include <linux/mempolicy.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/syscalls.h>
 #include <linux/sched.h>
 #include "internal.h"
@@ -81,14 +83,25 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct **prev, unsigned long start,
 		unsigned long end, unsigned long addtypes)
 {
+	pgoff_t pgoff;
 	int ret = 0;
+	unsigned long newtypes =  vma_seals(vma) | addtypes;
+
+	if (newtypes != vma_seals(vma)) {
+		/*
+		 * Attempt to merge with prev and next vma.
+		 */
+		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
+		*prev = vma_merge(vmi, vma->vm_mm, *prev, start, end, vma->vm_flags,
+				vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
+				vma->vm_userfaultfd_ctx, anon_vma_name(vma), newtypes);
+		if (*prev) {
+			vma = *prev;
+			goto out;
+		}
 
-	if (addtypes & ~(vma_seals(vma))) {
 		/*
 		 * Handle split at start and end.
-		 * For now sealed VMA doesn't merge with other VMAs.
-		 * This will be updated in later commit to make
-		 * sealed VMA also mergeable.
 		 */
 		if (start != vma->vm_start) {
 			ret = split_vma(vmi, vma, start, 1);
@@ -102,7 +115,7 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 				goto out;
 		}
 
-		vma->vm_seals |= addtypes;
+		vma->vm_seals = newtypes;
 	}
 
 out:
-- 
2.43.0.472.g3155946c3a-goog


