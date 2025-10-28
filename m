Return-Path: <linux-kselftest+bounces-44238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 031C7C17053
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7B8F4F2F87
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 21:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30823587AE;
	Tue, 28 Oct 2025 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ohtce29t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74C3587A0
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686770; cv=none; b=ccZA0qaf87kE5duwsvqh03oCeKIqJaHCnDjieKUTOkKWX3p9kynsNaVC73HUzXiXYt9W4S4xGXeBx5iehYeZjVJb7xYfJPPQjx3mDJOV4t3/qr9L1i7EObwWcavGZKNSBpskDK/Gpdrw1ipRZD5A3TzO6iflqLAY0hON+qXdoYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686770; c=relaxed/simple;
	bh=+EWx4uvI5aKiKqAICfkF4nr+f0n8a/MZOXwEmyXI4/Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rk03txSucikb52OuXS2einHRG0eIZ9Xnhhp2w7TbMH2Nnozwi2mQAG3RyV3XCtlNdJzLlbtHrX1bM4lVcbbiRlGdCI/gC552m1yW5vLPOUIpxNtcJJF/9UgfqZtnNoFH+DViUxR1m6GTuFRNsIZ0VLxADn/O2KxQaZ6OK0WX1mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ohtce29t; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-780e1e71180so90252517b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 14:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686767; x=1762291567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NTt8bEnNQStSUEFXw6O1ENJZuyS/zqyLXHsHqP8M9Hk=;
        b=Ohtce29tqwIyRcyhO0BLQE2coYLhHpN0qKEFAgBY19AMluIW4NUQa2dlSmXVOuJIvl
         YbsJUbRVPvSWLkUxlANcqjDFVqKw5KJhZq0AUsMouq3piOQc2TtOyD6Xhn9KFNwsdGou
         Jpnnh1Rkn5kJWxn8AA5NlSr7LSgC+PJFFyi0efH7e13p/o62KrOhIMlCXGGWUxdcZxQe
         Ss+llnzOSEZJbfLZwPXPvBAPX960tLmZn+cEpakXUZdkR47+AKnB8VaeLitsa4lO0e+u
         skpSpMBU/hkbjP2a9G/xNbSLmsyFFGAhi8EzzOQvznyUikO0vY3vuB49FinHIGGakvKu
         jfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686767; x=1762291567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTt8bEnNQStSUEFXw6O1ENJZuyS/zqyLXHsHqP8M9Hk=;
        b=v5r6ZYNaYybYXP3OQgzHV2k+8/gKzO/Kjy6xYkXr1unHJG3QBsDMaTMDLo709HrXH1
         wUcqijWjX6Ni/zMeGy2mVBIGfH2VfEWC/KSCkVGX2dmq0lA0K536lZGetSmoyJjMNIkV
         V2fhNlOkTxGHP13Fd3xq/KTDjHrBJBpD7CaastvFNrONinASep81milOiA5c0E1AHJxl
         mjQ+xFEHzXhYi0Gpx3fW68D6ykeN8V7dMl9OgJfP5NuYHI1lGzFY5+wsB05lT0EonUqC
         +i2ZfzSdUjuikuWvfN7/ukMd6Cm1GjgoEM+oO8tnYxZog0QVCQ5eb/ENEfeD6tyvzg+Z
         POPA==
X-Forwarded-Encrypted: i=1; AJvYcCWYGcCFN7tDS9gkQ+KaxhPW4y/TM1/zUnIWPlUXa/j3RNHqPvCl7kCC9hRmhh72ckkwcart9BGj1pe9rJKUO1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTRaNGjzDh6GK2+Z/ntwpVpME9FwUMycT3/CfMbLjRRReLzIi
	Z/6aa5epidcU3JPK0ZEYmpIt//WD1DRnNhpSwj7guPOXccO++v/LGernMrp/LO1FeccJHVUd+zO
	i+WCdRqxFzaijjKYiZJaItZrlHA==
X-Google-Smtp-Source: AGHT+IFrlEdqDQbSkrVhtqgCvEVtlsqYzUqdtjztFgSuD/p7jE/0v1060C3RmU11+7JIA5Kg3L/dQa4wsNzkHR6+tw==
X-Received: from yxfj13.prod.google.com ([2002:a05:690e:4cd:b0:63f:2d9a:654e])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:6912:0:b0:63c:f349:cb97 with SMTP id 956f58d0204a3-63f76db2d1bmr604043d50.41.1761686767005;
 Tue, 28 Oct 2025 14:26:07 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:24:34 -0700
In-Reply-To: <20251028212528.681081-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212528.681081-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212528.681081-4-kaleshsingh@google.com>
Subject: [PATCH v4 3/5] mm: Introduce max_vma_count() to abstract the max map
 count sysctl
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: rostedt@goodmis.org, hughd@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce a new helper function, max_vma_count(), to act as the
canonical accessor for the maximum VMA count limit.

The global variable sysctl_max_map_count is used in multiple files to
check the VMA limit. This direct usage exposes an implementation detail
and makes the code harder to read and maintain.

This patch abstracts the global variable behind the more aptly named
max_vma_count() function. As a result, the sysctl_max_map_count
variable can now be made static to mm/mmap.c, improving encapsulation.

All call sites are converted to use the new helper, making the limit
checks more readable.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v4:
 - Introduce max_vma_count() to abstract the max map count sysctl,
   replacing the previously proposed vma_count_remaining() helper
    -- since this remaining count can now be negative as some cases
    are allowed to exceed the limit.
 - Convert all callers to use the new helper.

Changes in v3:
 - Move vma_count_remaining() out of #if CONFIG_SYSCTL to fix build 
   failure
 - Use READ_ONCE() for sysclt_max_map_count, per David, Lorenzo
 - Remove use of ternary op in vma_count_remaining, per Lorenzo
 - Rebase on mm-new to fix conflicts in vma_internal.h and
   mm/internal.h

 include/linux/mm.h               |  2 --
 mm/internal.h                    |  3 +++
 mm/mmap.c                        |  9 ++++++++-
 mm/mremap.c                      |  7 ++++---
 mm/nommu.c                       |  2 +-
 mm/util.c                        |  1 -
 mm/vma.c                         | 10 +++++-----
 tools/testing/vma/vma_internal.h |  6 ++++++
 8 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index aada935c4950..5db9d95043f6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -205,8 +205,6 @@ static inline void __mm_zero_struct_page(struct page *page)
 #define MAPCOUNT_ELF_CORE_MARGIN	(5)
 #define DEFAULT_MAX_MAP_COUNT	(USHRT_MAX - MAPCOUNT_ELF_CORE_MARGIN)
 
-extern int sysctl_max_map_count;
-
 extern unsigned long sysctl_user_reserve_kbytes;
 extern unsigned long sysctl_admin_reserve_kbytes;
 
diff --git a/mm/internal.h b/mm/internal.h
index 116a1ba85e66..eba30ff7c8dc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1702,4 +1702,7 @@ static inline int io_remap_pfn_range_complete(struct vm_area_struct *vma,
 	return remap_pfn_range_complete(vma, addr, pfn, size, prot);
 }
 
+/* mmap.c */
+int max_vma_count(void);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index 78843a2fae42..5a967a307099 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -383,7 +383,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * sysctl_max_map_count limit by one. This behavior is preserved to
 	 * avoid breaking existing applications.
 	 */
-	if (mm->map_count > sysctl_max_map_count)
+	if (max_vma_count() - mm->map_count < 0)
 		return -ENOMEM;
 
 	/*
@@ -1504,6 +1504,13 @@ struct vm_area_struct *_install_special_mapping(
 					&special_mapping_vmops);
 }
 
+static int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
+
+int max_vma_count(void)
+{
+	return READ_ONCE(sysctl_max_map_count);
+}
+
 #ifdef CONFIG_SYSCTL
 #if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
 		defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
diff --git a/mm/mremap.c b/mm/mremap.c
index a7f531c17b79..02c38fd957e4 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1040,7 +1040,7 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	 * We'd prefer to avoid failure later on in do_munmap:
 	 * which may split one vma into three before unmapping.
 	 */
-	if (current->mm->map_count >= sysctl_max_map_count - 3)
+	if (max_vma_count() - current->mm->map_count < 4)
 		return -ENOMEM;
 
 	if (vma->vm_ops && vma->vm_ops->may_split) {
@@ -1811,9 +1811,10 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	 * split in 3 before unmapping it.
 	 * That means 2 more maps (1 for each) to the ones we already hold.
 	 * Check whether current map count plus 2 still leads us to 4 maps below
-	 * the threshold, otherwise return -ENOMEM here to be more safe.
+	 * the threshold. In other words, is the current map count + 6 at or
+	 * below the threshold? Otherwise return -ENOMEM here to be more safe.
 	 */
-	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
+	if (max_vma_count() - current->mm->map_count < 6)
 		return -ENOMEM;
 
 	return 0;
diff --git a/mm/nommu.c b/mm/nommu.c
index c3a23b082adb..ae2b20cc324a 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1317,7 +1317,7 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		return -ENOMEM;
 
 	mm = vma->vm_mm;
-	if (mm->map_count >= sysctl_max_map_count)
+	if (max_vma_count() - mm->map_count < 1)
 		return -ENOMEM;
 
 	region = kmem_cache_alloc(vm_region_jar, GFP_KERNEL);
diff --git a/mm/util.c b/mm/util.c
index 97cae40c0209..eb1bcfc1d48d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -752,7 +752,6 @@ EXPORT_SYMBOL(folio_mc_copy);
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
 static int sysctl_overcommit_ratio __read_mostly = 50;
 static unsigned long sysctl_overcommit_kbytes __read_mostly;
-int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
 unsigned long sysctl_user_reserve_kbytes __read_mostly = 1UL << 17; /* 128MB */
 unsigned long sysctl_admin_reserve_kbytes __read_mostly = 1UL << 13; /* 8MB */
 
diff --git a/mm/vma.c b/mm/vma.c
index d0bb3127280e..768d216beed3 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -493,8 +493,8 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 }
 
 /*
- * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
- * has already been checked or doesn't make sense to fail.
+ * __split_vma() bypasses max_vma_count() checks. We use this where
+ * it has already been checked or doesn't make sense to fail.
  * VMA Iterator will point to the original VMA.
  */
 static __must_check int
@@ -594,7 +594,7 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		     unsigned long addr, int new_below)
 {
-	if (vma->vm_mm->map_count >= sysctl_max_map_count)
+	if (max_vma_count() - vma->vm_mm->map_count < 1)
 		return -ENOMEM;
 
 	return __split_vma(vmi, vma, addr, new_below);
@@ -1347,7 +1347,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		 * its limit temporarily, to help free resources as expected.
 		 */
 		if (vms->end < vms->vma->vm_end &&
-		    vms->vma->vm_mm->map_count >= sysctl_max_map_count) {
+		    max_vma_count() - vms->vma->vm_mm->map_count < 1) {
 			error = -ENOMEM;
 			goto map_count_exceeded;
 		}
@@ -2819,7 +2819,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * typically extends the existing brk VMA rather than creating a new one.
 	 * See also the comment in do_mmap().
 	 */
-	if (mm->map_count > sysctl_max_map_count)
+	if (max_vma_count() - mm->map_count < 0)
 		return -ENOMEM;
 
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index d873667704e8..41d354a699c5 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1491,4 +1491,10 @@ static inline int do_munmap(struct mm_struct *, unsigned long, size_t,
 	return 0;
 }
 
+/* Helper to get max vma count */
+static int max_vma_count(void)
+{
+	return sysctl_max_map_count;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.51.1.851.g4ebd6896fd-goog


