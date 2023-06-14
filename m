Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8567A710803
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbjEYI4L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 04:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbjEYI4G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 04:56:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F351AB;
        Thu, 25 May 2023 01:56:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [119.155.11.156])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 579306605835;
        Thu, 25 May 2023 09:55:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685004958;
        bh=ASuObf951FBmPiBZe6iz+mHNPr0QWgYjLe0VPPMA4TU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TCuPvIEtUI8pllX/XuXcyBA4oindN9es4EcwzwrzuQRFSAoYwFNjj5sY22CGucCRI
         G2o8pxOkhM48DVsgdsHV2qj9hvkMDxEhaeuQpZcwLf9KfnAJVGVTk1lQBZ75CWzrGU
         z7MGYRZCAcOeuFYw4ZV9opq7SioPrF4smGTJr8H4POlMsESslxOeFIIB3pawZ9RhVW
         vqhIxQkZVfo3U+iQtkRjMVUjeBNlxijRMjFmp+b2fR3H4V/zCeVGXaWfYke6npeV5G
         EQqq37mx3lL6v+y75AVGwKo/Pob2bsHObdxgMPyNdvG4o7dHdDNK/yTJix8Xz3J8nB
         WH0Ad6lHLOGwg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: [PATCH v16 2/5] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
Date:   Thu, 25 May 2023 13:55:14 +0500
Message-Id: <20230525085517.281529-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525085517.281529-1-usama.anjum@collabora.com>
References: <20230525085517.281529-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
the info about page table entries. The following operations are supported
in this ioctl:
- Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
  file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
  (PAGE_IS_SWAPPED).
- Find pages which have been written-to and/or write protect the pages
  (atomic PM_SCAN_OP_GET + PM_SCAN_OP_WP)

This IOCTL can be extended to get information about more PTE bits.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in v16:
- Fixed a corner case where kernel writes beyond user buffer by one
  element
- Bring back exclusive PM_SCAN_OP_WP
- Cosmetic changes

Changes in v15:
- Build fix:
  - Use generic tlb flush function in pagemap_scan_pmd_entry() instead of
    using x86 specific flush function in do_pagemap_scan()
  - Remove #ifdef from pagemap_scan_hugetlb_entry()
  - Use mm instead of undefined vma->vm_mm

Changes in v14:
- Fix build error caused by #ifdef added at last minute in some configs

Changes in v13:
- Review updates
- mmap_read_lock_killable() instead of mmap_read_lock()
- Replace uffd_wp_range() with helpers which increases performance
  drastically for OP_WP operations by reducing the number of tlb
  flushing etc
- Add MMU_NOTIFY_PROTECTION_VMA notification for the memory range

Changes in v12:
- Add hugetlb support to cover all memory types
- Merge "userfaultfd: Define dummy uffd_wp_range()" with this patch
- Review updates to the code

Changes in v11:
- Find written pages in a better way
- Fix a corner case (thanks Paul)
- Improve the code/comments
- remove ENGAGE_WP + ! GET operation
- shorten the commit message in favour of moving documentation to
  pagemap.rst

Changes in v10:
- move changes in tools/include/uapi/linux/fs.h to separate patch
- update commit message

Change in v8:
- Correct is_pte_uffd_wp()
- Improve readability and error checks
- Remove some un-needed code

Changes in v7:
- Rebase on top of latest next
- Fix some corner cases
- Base soft-dirty on the uffd wp async
- Update the terminologies
- Optimize the memory usage inside the ioctl

Changes in v6:
- Rename variables and update comments
- Make IOCTL independent of soft_dirty config
- Change masks and bitmap type to _u64
- Improve code quality

Changes in v5:
- Remove tlb flushing even for clear operation

Changes in v4:
- Update the interface and implementation

Changes in v3:
- Tighten the user-kernel interface by using explicit types and add more
  error checking

Changes in v2:
- Convert the interface from syscall to ioctl
- Remove pidfd support as it doesn't make sense in ioctl
---
 fs/proc/task_mmu.c      | 503 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fs.h |  53 +++++
 2 files changed, 556 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 38b19a757281..cc31c37e6789 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -19,6 +19,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/uaccess.h>
 #include <linux/pkeys.h>
+#include <linux/minmax.h>
 
 #include <asm/elf.h>
 #include <asm/tlb.h>
@@ -1767,11 +1768,513 @@ static int pagemap_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+#define PM_SCAN_FOUND_MAX_PAGES	(1)
+#define PM_SCAN_BITS_ALL	(PAGE_IS_WRITTEN | PAGE_IS_FILE |	\
+				 PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
+#define PM_SCAN_OPS		(PM_SCAN_OP_GET | PM_SCAN_OP_WP)
+#define IS_PM_SCAN_GET(flags)	(flags & PM_SCAN_OP_GET)
+#define IS_PM_SCAN_WP(flags)	(flags & PM_SCAN_OP_WP)
+#define PM_SCAN_BITMAP(wt, file, present, swap)	\
+	((wt) | ((file) << 1) | ((present) << 2) | ((swap) << 3))
+
+struct pagemap_scan_private {
+	struct page_region *vec, cur;
+	unsigned long vec_len, vec_index, max_pages, found_pages, flags;
+	unsigned long required_mask, anyof_mask, excluded_mask, return_mask;
+};
+
+static inline bool is_pte_uffd_wp(pte_t pte)
+{
+	return (pte_present(pte) && pte_uffd_wp(pte)) ||
+	       pte_swp_uffd_wp_any(pte);
+}
+
+static inline void make_uffd_wp_pte(struct vm_area_struct *vma,
+				    unsigned long addr, pte_t *pte)
+{
+	pte_t ptent = *pte;
+
+	if (pte_present(ptent)) {
+		pte_t old_pte;
+
+		old_pte = ptep_modify_prot_start(vma, addr, pte);
+		ptent = pte_mkuffd_wp(ptent);
+		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
+	} else if (is_swap_pte(ptent)) {
+		ptent = pte_swp_mkuffd_wp(ptent);
+		set_pte_at(vma->vm_mm, addr, pte, ptent);
+	}
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline bool is_pmd_uffd_wp(pmd_t pmd)
+{
+	return (pmd_present(pmd) && pmd_uffd_wp(pmd)) ||
+	       (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd));
+}
+
+static inline void make_uffd_wp_pmd(struct vm_area_struct *vma,
+				    unsigned long addr, pmd_t *pmdp)
+{
+	pmd_t old, pmd = *pmdp;
+
+	if (pmd_present(pmd)) {
+		old = pmdp_invalidate_ad(vma, addr, pmdp);
+		pmd = pmd_mkuffd_wp(old);
+		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
+	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
+		pmd = pmd_swp_mkuffd_wp(pmd);
+		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
+	}
+}
+#endif
+
+#ifdef CONFIG_HUGETLB_PAGE
+static inline bool is_huge_pte_uffd_wp(pte_t pte)
+{
+	return ((pte_present(pte) && huge_pte_uffd_wp(pte)) ||
+	       pte_swp_uffd_wp_any(pte));
+}
+
+static inline void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t *ptep,
+					 pte_t ptent)
+{
+	pte_t old_pte;
+
+	if (!huge_pte_none(ptent)) {
+		old_pte = huge_ptep_modify_prot_start(vma, addr, ptep);
+		ptent = huge_pte_mkuffd_wp(old_pte);
+		ptep_modify_prot_commit(vma, addr, ptep, old_pte, ptent);
+	} else {
+		set_huge_pte_at(vma->vm_mm, addr, ptep,
+				make_pte_marker(PTE_MARKER_UFFD_WP));
+	}
+}
+#endif
+
+static inline bool pagemap_scan_check_page_written(struct pagemap_scan_private *p)
+{
+	return (p->required_mask | p->anyof_mask | p->excluded_mask) &
+	       PAGE_IS_WRITTEN;
+}
+
+static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
+				  struct mm_walk *walk)
+{
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+
+	if (pagemap_scan_check_page_written(p) && (!userfaultfd_wp(vma) ||
+	    !userfaultfd_wp_async(vma)))
+		return -EPERM;
+
+	if (vma->vm_flags & VM_PFNMAP)
+		return 1;
+
+	return 0;
+}
+
+static int pagemap_scan_output(bool wt, bool file, bool pres, bool swap,
+			       struct pagemap_scan_private *p,
+			       unsigned long addr, unsigned int n_pages)
+{
+	unsigned long bitmap = PM_SCAN_BITMAP(wt, file, pres, swap);
+	struct page_region *cur = &p->cur;
+
+	if (!n_pages)
+		return -EINVAL;
+
+	if ((p->required_mask & bitmap) != p->required_mask)
+		return 0;
+	if (p->anyof_mask && !(p->anyof_mask & bitmap))
+		return 0;
+	if (p->excluded_mask & bitmap)
+		return 0;
+
+	bitmap &= p->return_mask;
+	if (!bitmap)
+		return 0;
+
+	if (cur->bitmap == bitmap &&
+	    cur->start + cur->len * PAGE_SIZE == addr) {
+		cur->len += n_pages;
+		p->found_pages += n_pages;
+	} else {
+		/*
+		 * All data is copied to cur first. When more data is found, we
+		 * push cur to vec and copy new data to cur. The vec_index
+		 * represents the current index of vec array. We add 1 to the
+		 * vec_index while performing checks to account for data in cur.
+		 */
+		if (cur->len && (p->vec_index + 1) >= p->vec_len)
+			return -ENOSPC;
+
+		if (cur->len) {
+			memcpy(&p->vec[p->vec_index], cur, sizeof(*p->vec));
+			p->vec_index++;
+		}
+
+		cur->start = addr;
+		cur->len = n_pages;
+		cur->bitmap = bitmap;
+		p->found_pages += n_pages;
+	}
+
+	if (p->max_pages && (p->found_pages == p->max_pages))
+		return PM_SCAN_FOUND_MAX_PAGES;
+
+	return 0;
+}
+
+static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
+				  unsigned long end, struct mm_walk *walk)
+{
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	unsigned long addr = end;
+	pte_t *pte, *orig_pte;
+	spinlock_t *ptl;
+	bool is_written;
+	int ret = 0;
+
+	arch_enter_lazy_mmu_mode();
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	ptl = pmd_trans_huge_lock(pmd, vma);
+	if (ptl) {
+		unsigned long n_pages = (end - start)/PAGE_SIZE;
+
+		if (p->max_pages && n_pages > p->max_pages - p->found_pages)
+			n_pages = p->max_pages - p->found_pages;
+
+		is_written = !is_pmd_uffd_wp(*pmd);
+
+		/*
+		 * Break huge page into small pages if the WP operation need to
+		 * be performed is on a portion of the huge page.
+		 */
+		if (is_written && IS_PM_SCAN_WP(p->flags) &&
+		    n_pages < HPAGE_SIZE/PAGE_SIZE) {
+			spin_unlock(ptl);
+
+			split_huge_pmd(vma, pmd, start);
+			goto process_smaller_pages;
+		}
+
+		if (IS_PM_SCAN_GET(p->flags))
+			ret = pagemap_scan_output(is_written, vma->vm_file,
+						  pmd_present(*pmd),
+						  is_swap_pmd(*pmd),
+						  p, start, n_pages);
+
+		if (ret >= 0 && is_written && IS_PM_SCAN_WP(p->flags))
+			make_uffd_wp_pmd(vma, addr, pmd);
+
+		if (IS_PM_SCAN_WP(p->flags))
+			flush_tlb_range(vma, start, end);
+
+		spin_unlock(ptl);
+
+		arch_leave_lazy_mmu_mode();
+		return ret;
+	}
+
+process_smaller_pages:
+	if (pmd_trans_unstable(pmd)) {
+		arch_leave_lazy_mmu_mode();
+		return 0;
+	}
+#endif
+
+	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
+	for (addr = start; addr < end && !ret; pte++, addr += PAGE_SIZE) {
+		is_written = !is_pte_uffd_wp(*pte);
+
+		if (IS_PM_SCAN_GET(p->flags))
+			ret = pagemap_scan_output(is_written, vma->vm_file,
+						  pte_present(*pte),
+						  is_swap_pte(*pte),
+						  p, addr, 1);
+
+		if (ret >= 0 && is_written && IS_PM_SCAN_WP(p->flags))
+			make_uffd_wp_pte(vma, addr, pte);
+	}
+
+	if (IS_PM_SCAN_WP(p->flags))
+		flush_tlb_range(vma, start, addr);
+
+	pte_unmap_unlock(orig_pte, ptl);
+	arch_leave_lazy_mmu_mode();
+
+	cond_resched();
+	return ret;
+}
+
+#ifdef CONFIG_HUGETLB_PAGE
+static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
+				      unsigned long start, unsigned long end,
+				      struct mm_walk *walk)
+{
+	unsigned long n_pages = (end - start)/PAGE_SIZE;
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	struct hstate *h = hstate_vma(vma);
+	spinlock_t *ptl;
+	bool is_written;
+	int ret = 0;
+	pte_t pte;
+
+	arch_enter_lazy_mmu_mode();
+
+	if (p->max_pages && n_pages > p->max_pages - p->found_pages)
+		n_pages = p->max_pages - p->found_pages;
+
+	if (IS_PM_SCAN_WP(p->flags)) {
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+		ptl = huge_pte_lock(h, vma->vm_mm, ptep);
+	}
+
+	pte = huge_ptep_get(ptep);
+	is_written = !is_huge_pte_uffd_wp(pte);
+
+	/*
+	 * Partial hugetlb page clear isn't supported
+	 */
+	if (is_written && IS_PM_SCAN_WP(p->flags) &&
+	    n_pages < HPAGE_SIZE/PAGE_SIZE) {
+		ret = -EPERM;
+		goto unlock_and_return;
+	}
+
+	if (IS_PM_SCAN_GET(p->flags)) {
+		ret = pagemap_scan_output(is_written, vma->vm_file,
+					  pte_present(pte), is_swap_pte(pte),
+					  p, start, n_pages);
+		if (ret < 0)
+			goto unlock_and_return;
+	}
+
+	if (is_written && IS_PM_SCAN_WP(p->flags)) {
+		make_uffd_wp_huge_pte(vma, start, ptep, pte);
+		flush_hugetlb_tlb_range(vma, start, end);
+	}
+
+unlock_and_return:
+	if (IS_PM_SCAN_WP(p->flags)) {
+		spin_unlock(ptl);
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
+
+	arch_leave_lazy_mmu_mode();
+
+	return ret;
+}
+#else
+#define pagemap_scan_hugetlb_entry NULL
+#endif
+
+static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
+				 int depth, struct mm_walk *walk)
+{
+	unsigned long n_pages = (end - addr)/PAGE_SIZE;
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	int ret = 0;
+
+	if (!vma || !IS_PM_SCAN_GET(p->flags))
+		return 0;
+
+	if (p->max_pages && n_pages > p->max_pages - p->found_pages)
+		n_pages = p->max_pages - p->found_pages;
+
+	ret = pagemap_scan_output(false, vma->vm_file, false, false, p, addr,
+				  n_pages);
+
+	return ret;
+}
+
+static const struct mm_walk_ops pagemap_scan_ops = {
+	.test_walk = pagemap_scan_test_walk,
+	.pmd_entry = pagemap_scan_pmd_entry,
+	.pte_hole = pagemap_scan_pte_hole,
+	.hugetlb_entry = pagemap_scan_hugetlb_entry,
+};
+
+static int pagemap_scan_args_valid(struct pm_scan_arg *arg, unsigned long start,
+				   struct page_region __user *vec)
+{
+	/* Detect illegal size, flags, len and masks */
+	if (arg->size != sizeof(struct pm_scan_arg))
+		return -EINVAL;
+	if (arg->flags & ~PM_SCAN_OPS)
+		return -EINVAL;
+	if (!arg->len)
+		return -EINVAL;
+	if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask |
+	     arg->return_mask) & ~PM_SCAN_BITS_ALL)
+		return -EINVAL;
+	if (!arg->required_mask && !arg->anyof_mask &&
+	    !arg->excluded_mask)
+		return -EINVAL;
+	if (!arg->return_mask)
+		return -EINVAL;
+
+	/* Validate memory range */
+	if (!IS_ALIGNED(start, PAGE_SIZE))
+		return -EINVAL;
+	if (!access_ok((void __user *)start, arg->len))
+		return -EFAULT;
+
+	if (IS_PM_SCAN_GET(arg->flags)) {
+		if (!arg->vec)
+			return -EINVAL;
+		if (arg->vec_len == 0)
+			return -EINVAL;
+	}
+
+	if (IS_PM_SCAN_WP(arg->flags)) {
+		if (!IS_PM_SCAN_GET(arg->flags) && arg->max_pages)
+			return -EINVAL;
+
+		if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask) &
+		    ~PAGE_IS_WRITTEN)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static long do_pagemap_scan(struct mm_struct *mm,
+			    struct pm_scan_arg __user *uarg)
+{
+	unsigned long start, end, walk_start, walk_end;
+	unsigned long empty_slots, vec_index = 0;
+	struct mmu_notifier_range range;
+	struct page_region __user *vec;
+	struct pagemap_scan_private p;
+	struct pm_scan_arg arg;
+	int ret = 0;
+
+	if (copy_from_user(&arg, uarg, sizeof(arg)))
+		return -EFAULT;
+
+	start = untagged_addr((unsigned long)arg.start);
+	vec = (struct page_region *)untagged_addr((unsigned long)arg.vec);
+
+	ret = pagemap_scan_args_valid(&arg, start, vec);
+	if (ret)
+		return ret;
+
+	end = start + arg.len;
+	p.max_pages = arg.max_pages;
+	p.found_pages = 0;
+	p.flags = arg.flags;
+	p.required_mask = arg.required_mask;
+	p.anyof_mask = arg.anyof_mask;
+	p.excluded_mask = arg.excluded_mask;
+	p.return_mask = arg.return_mask;
+	p.cur.start = p.cur.len = p.cur.bitmap = 0;
+	p.vec = NULL;
+	p.vec_len = PAGEMAP_WALK_SIZE >> PAGE_SHIFT;
+
+	/*
+	 * Allocate smaller buffer to get output from inside the page walk
+	 * functions and walk page range in PAGEMAP_WALK_SIZE size chunks. As
+	 * we want to return output to user in compact form where no two
+	 * consecutive regions should be continuous and have the same flags.
+	 * So store the latest element in p.cur between different walks and
+	 * store the p.cur at the end of the walk to the user buffer.
+	 */
+	if (IS_PM_SCAN_GET(p.flags)) {
+		p.vec = kmalloc_array(p.vec_len, sizeof(*p.vec), GFP_KERNEL);
+		if (!p.vec)
+			return -ENOMEM;
+	}
+
+	if (IS_PM_SCAN_WP(p.flags)) {
+		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
+					mm, start, end);
+		mmu_notifier_invalidate_range_start(&range);
+	}
+
+	walk_start = walk_end = start;
+	while (walk_end < end && !ret) {
+		if (IS_PM_SCAN_GET(p.flags)) {
+			p.vec_index = 0;
+
+			empty_slots = arg.vec_len - vec_index;
+			p.vec_len = min(p.vec_len, empty_slots);
+		}
+
+		walk_end = (walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK;
+		if (walk_end > end)
+			walk_end = end;
+
+		ret = mmap_read_lock_killable(mm);
+		if (ret)
+			goto free_data;
+		ret = walk_page_range(mm, walk_start, walk_end,
+				      &pagemap_scan_ops, &p);
+		mmap_read_unlock(mm);
+
+		if (ret && ret != -ENOSPC && ret != PM_SCAN_FOUND_MAX_PAGES)
+			goto free_data;
+
+		walk_start = walk_end;
+		if (IS_PM_SCAN_GET(p.flags) && p.vec_index) {
+			if (copy_to_user(&vec[vec_index], p.vec,
+					 p.vec_index * sizeof(*p.vec))) {
+				/*
+				 * Return error even though the OP succeeded
+				 */
+				ret = -EFAULT;
+				goto free_data;
+			}
+			vec_index += p.vec_index;
+		}
+	}
+
+	if (IS_PM_SCAN_WP(p.flags))
+		mmu_notifier_invalidate_range_end(&range);
+
+	if (IS_PM_SCAN_GET(p.flags) && p.cur.len) {
+		if (copy_to_user(&vec[vec_index], &p.cur, sizeof(*p.vec))) {
+			ret = -EFAULT;
+			goto free_data;
+		}
+		vec_index++;
+	}
+
+	ret = vec_index;
+
+free_data:
+	kfree(p.vec);
+	return ret;
+}
+
+static long do_pagemap_cmd(struct file *file, unsigned int cmd,
+			   unsigned long arg)
+{
+	struct pm_scan_arg __user *uarg = (struct pm_scan_arg __user *)arg;
+	struct mm_struct *mm = file->private_data;
+
+	switch (cmd) {
+	case PAGEMAP_SCAN:
+		return do_pagemap_scan(mm, uarg);
+
+	default:
+		return -EINVAL;
+	}
+}
+
 const struct file_operations proc_pagemap_operations = {
 	.llseek		= mem_lseek, /* borrow this */
 	.read		= pagemap_read,
 	.open		= pagemap_open,
 	.release	= pagemap_release,
+	.unlocked_ioctl = do_pagemap_cmd,
+	.compat_ioctl	= do_pagemap_cmd,
 };
 #endif /* CONFIG_PROC_PAGE_MONITOR */
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index b7b56871029c..47879c38ce2f 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -305,4 +305,57 @@ typedef int __bitwise __kernel_rwf_t;
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND)
 
+/* Pagemap ioctl */
+#define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
+
+/* Bits are set in the bitmap of the page_region and masks in pm_scan_args */
+#define PAGE_IS_WRITTEN		(1 << 0)
+#define PAGE_IS_FILE		(1 << 1)
+#define PAGE_IS_PRESENT		(1 << 2)
+#define PAGE_IS_SWAPPED		(1 << 3)
+
+/*
+ * struct page_region - Page region with bitmap flags
+ * @start:	Start of the region
+ * @len:	Length of the region in pages
+ * bitmap:	Bits sets for the region
+ */
+struct page_region {
+	__u64 start;
+	__u64 len;
+	__u64 bitmap;
+};
+
+/*
+ * struct pm_scan_arg - Pagemap ioctl argument
+ * @size:		Size of the structure
+ * @flags:		Flags for the IOCTL
+ * @start:		Starting address of the region
+ * @len:		Length of the region (All the pages in this length are included)
+ * @vec:		Address of page_region struct array for output
+ * @vec_len:		Length of the page_region struct array
+ * @max_pages:		Optional max return pages
+ * @required_mask:	Required mask - All of these bits have to be set in the PTE
+ * @anyof_mask:		Any mask - Any of these bits are set in the PTE
+ * @excluded_mask:	Exclude mask - None of these bits are set in the PTE
+ * @return_mask:	Bits that are to be reported in page_region
+ */
+struct pm_scan_arg {
+	__u64 size;
+	__u64 flags;
+	__u64 start;
+	__u64 len;
+	__u64 vec;
+	__u64 vec_len;
+	__u64 max_pages;
+	__u64 required_mask;
+	__u64 anyof_mask;
+	__u64 excluded_mask;
+	__u64 return_mask;
+};
+
+/* Supported flags */
+#define PM_SCAN_OP_GET	(1 << 0)
+#define PM_SCAN_OP_WP	(1 << 1)
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.39.2

