Return-Path: <linux-kselftest+bounces-15296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F04951514
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 09:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C651C24301
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 07:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA02C13CFAD;
	Wed, 14 Aug 2024 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hYlcTzK9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BB13C9B3
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723619677; cv=none; b=QOXaaJioSVHT6BGenYVWH33eGrvitoaW0bZJ8v7B8FMR4+HUsP0FDH/j+qkiKCMN6PT6BJSGjjJUC27z9FmeZiChl27MSfE2owlqqAaFVVs/drwqHOYmtrYvTZzOLSyAeuay8V3l/ojusVJdF21vLsc+eNGFcNdQ+yhrlmBAGkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723619677; c=relaxed/simple;
	bh=jH2VLByoCj65CKES9JuT0zu4kckdjVLERAHfZHiVcds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJvUq86yvFVfGfyL+yMDdMvCBhF10/0MCRj2fUSTwi50a9eu+re+7+4CqaL+jtlI9tiJxhv1IVzwym/vUwYQeJv+iZ3XWiOn9551Lo1S9JbcnJB4YP5wClFMuuxR2RIajKQHPnFWNiwbpxV2FOxZOOynDHLLtoxan/5WV40Bu0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hYlcTzK9; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-268eec6c7c1so4365171fac.3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 00:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723619675; x=1724224475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPWWQwyyMYzOiADy+Um6ftzlEsZpYIENXIqV4xwjKPk=;
        b=hYlcTzK9R2h12sw/AU7fpQD/UxgPjMBUzSbgt8OC0zHz5l2HQZ5U9QHtfHJ8e/5Oj0
         6tujrpSGveXK6oY4Kg1akq2E6LPAmkNG3nruktKFhF/qizSAGxt2Dz3cl6VAODQfNhtz
         Qx2TXncCh6+tKbVQbdEw6V14LRXz9x+tSgS9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723619675; x=1724224475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPWWQwyyMYzOiADy+Um6ftzlEsZpYIENXIqV4xwjKPk=;
        b=CTFuSKbzYxZu7YYCA3i0kxMv/1UYYrH5OdlxhRq55F2cba2ZiywI3UOi9zQM4O1j92
         qMEByISIwXiwlvJNlGuQ/w/FD1wONTWtzss5YWjTkT13OYkr3zYspvMWZdUncGX+dEss
         0Sk3XR3ymoNVnOEmpvJzqj6NlykneD1AuySVqv0T7tE0uVXj4bReJG2bBw8LxjBt561E
         5VcS21l8hZ+yaB4LWfiWDnX8TVzd/ixh9/dsL84/DDU6UTxOwN18Gpn/Fpcm6B/ZM6DA
         ZuQGdjoipINmD0Sq+58Neu6lASYC3IkzgzQE3mzpu/KDqD1+tmM0zXAc7Bi352wLMbI8
         4kKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1fjQXzUd7Zz0b/PhzC4GJJMQL9OyxD6NJMFOMqunCliNoyRilfMvZtxx3QQ8UMIFkNqsev0j46/icMpMQv/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZT6TZmhcs4KSlzVkEzXEkrAONKdC2/vTQtnHsgFIz0obHcJlY
	+FNDWq7ZKtYA35gsseevcCYglF2NS0I6+6tKIQGVdXoOajkKA9tNTrDXKoMzQA==
X-Google-Smtp-Source: AGHT+IE6JfJPxPtoC8Uw6welRiHqjOl4qLH95nS8kNG0C9/2C8BlFRDSZOxp1j99zGbCvMk19tkN6A==
X-Received: by 2002:a05:6871:520d:b0:261:7b0:9d66 with SMTP id 586e51a60fabf-26fe5c8313fmr1892557fac.50.1723619674941;
        Wed, 14 Aug 2024 00:14:34 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-710e5873086sm6727529b3a.20.2024.08.14.00.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 00:14:34 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	willy@infradead.org,
	torvalds@linux-foundation.org,
	Liam.Howlett@oracle.com,
	pedro.falcato@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	jeffxu@google.com,
	lorenzo.stoakes@oracle.com,
	mpe@ellerman.id.au,
	oliver.sang@intel.com,
	vbabka@suse.cz,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1 2/2] mseal: refactor mremap to remove can_modify_mm
Date: Wed, 14 Aug 2024 07:14:24 +0000
Message-ID: <20240814071424.2655666-3-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240814071424.2655666-1-jeffxu@chromium.org>
References: <20240814071424.2655666-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

mremap doesn't allow relocate, expand, shrink across VMA boundaries,
refactor the code to check src address range before doing anything on
the destination.

This also allow we remove can_modify_mm from mremap, since
the src address must be single VMA, use can_modify_vma instead.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/internal.h | 24 ++++++++++++++++
 mm/mremap.c   | 77 +++++++++++++++++++++++++--------------------------
 mm/mseal.c    | 17 ------------
 3 files changed, 61 insertions(+), 57 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b4d86436565b..53f0bbbc6449 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1501,6 +1501,24 @@ bool can_modify_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end);
 bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
 		unsigned long end, int behavior);
+
+static inline bool vma_is_sealed(struct vm_area_struct *vma)
+{
+	return (vma->vm_flags & VM_SEALED);
+}
+
+/*
+ * check if a vma is sealed for modification.
+ * return true, if modification is allowed.
+ */
+static inline bool can_modify_vma(struct vm_area_struct *vma)
+{
+	if (unlikely(vma_is_sealed(vma)))
+		return false;
+
+	return true;
+}
+
 #else
 static inline int can_do_mseal(unsigned long flags)
 {
@@ -1518,6 +1536,12 @@ static inline bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
 {
 	return true;
 }
+
+static inline bool can_modify_vma(struct vm_area_struct *vma)
+{
+	return true;
+}
+
 #endif
 
 #ifdef CONFIG_SHRINKER_DEBUG
diff --git a/mm/mremap.c b/mm/mremap.c
index e7ae140fc640..3c5bb671a280 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -904,28 +904,7 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 
 	/*
 	 * In mremap_to().
-	 * Move a VMA to another location, check if src addr is sealed.
-	 *
-	 * Place can_modify_mm here because mremap_to()
-	 * does its own checking for address range, and we only
-	 * check the sealing after passing those checks.
-	 *
-	 * can_modify_mm assumes we have acquired the lock on MM.
 	 */
-	if (unlikely(!can_modify_mm(mm, addr, addr + old_len)))
-		return -EPERM;
-
-	if (flags & MREMAP_FIXED) {
-		/*
-		 * In mremap_to().
-		 * VMA is moved to dst address, and munmap dst first.
-		 * do_munmap will check if dst is sealed.
-		 */
-		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
-		if (ret)
-			goto out;
-	}
-
 	if (old_len > new_len) {
 		ret = do_munmap(mm, addr+new_len, old_len - new_len, uf_unmap);
 		if (ret)
@@ -939,6 +918,26 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 		goto out;
 	}
 
+	/*
+	 * Since we can't remap across vma boundaries,
+	 * check single vma instead of src address range.
+	 */
+	if (unlikely(!can_modify_vma(vma))) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	if (flags & MREMAP_FIXED) {
+		/*
+		 * In mremap_to().
+		 * VMA is moved to dst address, and munmap dst first.
+		 * do_munmap will check if dst is sealed.
+		 */
+		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
+		if (ret)
+			goto out;
+	}
+
 	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
 	if (flags & MREMAP_DONTUNMAP &&
 		!may_expand_vm(mm, vma->vm_flags, old_len >> PAGE_SHIFT)) {
@@ -1079,19 +1078,6 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
-	/*
-	 * Below is shrink/expand case (not mremap_to())
-	 * Check if src address is sealed, if so, reject.
-	 * In other words, prevent shrinking or expanding a sealed VMA.
-	 *
-	 * Place can_modify_mm here so we can keep the logic related to
-	 * shrink/expand together.
-	 */
-	if (unlikely(!can_modify_mm(mm, addr, addr + old_len))) {
-		ret = -EPERM;
-		goto out;
-	}
-
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
@@ -1107,7 +1093,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		}
 
 		ret = do_vmi_munmap(&vmi, mm, addr + new_len, old_len - new_len,
-				    &uf_unmap, true);
+				&uf_unmap, true);
 		if (ret)
 			goto out;
 
@@ -1124,6 +1110,15 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
+	/*
+	 * Since we can't remap across vma boundaries,
+	 * check single vma instead of src address range.
+	 */
+	if (unlikely(!can_modify_vma(vma))) {
+		ret = -EPERM;
+		goto out;
+	}
+
 	/* old_len exactly to the end of the area..
 	 */
 	if (old_len == vma->vm_end - addr) {
@@ -1132,9 +1127,10 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		/* can we just expand the current mapping? */
 		if (vma_expandable(vma, delta)) {
 			long pages = delta >> PAGE_SHIFT;
-			VMA_ITERATOR(vmi, mm, vma->vm_end);
 			long charged = 0;
 
+			VMA_ITERATOR(vmi, mm, vma->vm_end);
+
 			if (vma->vm_flags & VM_ACCOUNT) {
 				if (security_vm_enough_memory_mm(mm, pages)) {
 					ret = -ENOMEM;
@@ -1177,20 +1173,21 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	ret = -ENOMEM;
 	if (flags & MREMAP_MAYMOVE) {
 		unsigned long map_flags = 0;
+
 		if (vma->vm_flags & VM_MAYSHARE)
 			map_flags |= MAP_SHARED;
 
 		new_addr = get_unmapped_area(vma->vm_file, 0, new_len,
-					vma->vm_pgoff +
-					((addr - vma->vm_start) >> PAGE_SHIFT),
-					map_flags);
+				vma->vm_pgoff +
+				((addr - vma->vm_start) >> PAGE_SHIFT),
+				map_flags);
 		if (IS_ERR_VALUE(new_addr)) {
 			ret = new_addr;
 			goto out;
 		}
 
 		ret = move_vma(vma, addr, old_len, new_len, new_addr,
-			       &locked, flags, &uf, &uf_unmap);
+				&locked, flags, &uf, &uf_unmap);
 	}
 out:
 	if (offset_in_page(ret))
diff --git a/mm/mseal.c b/mm/mseal.c
index bf783bba8ed0..4591ae8d29c2 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -16,28 +16,11 @@
 #include <linux/sched.h>
 #include "internal.h"
 
-static inline bool vma_is_sealed(struct vm_area_struct *vma)
-{
-	return (vma->vm_flags & VM_SEALED);
-}
-
 static inline void set_vma_sealed(struct vm_area_struct *vma)
 {
 	vm_flags_set(vma, VM_SEALED);
 }
 
-/*
- * check if a vma is sealed for modification.
- * return true, if modification is allowed.
- */
-static bool can_modify_vma(struct vm_area_struct *vma)
-{
-	if (unlikely(vma_is_sealed(vma)))
-		return false;
-
-	return true;
-}
-
 static bool is_madv_discard(int behavior)
 {
 	return	behavior &
-- 
2.46.0.76.ge559c4bf1a-goog


