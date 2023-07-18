Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C137475766B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 10:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjGRISu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 04:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGRISr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 04:18:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A33E7;
        Tue, 18 Jul 2023 01:18:43 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.184.252])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D5ABB6606F57;
        Tue, 18 Jul 2023 09:18:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689668322;
        bh=GXEFGsC9SUGK5m98awHTNhzDO+f2wnzuuFO+W/trtiM=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=W6Amq6SJzgITAcbMOnARj16Z44YPtUvRxjDHpFe6P5NLuW8vak1ZvUdWQOgbsYby0
         hxil9JBXc2l9fSIXUIruSCxxXgcwlEPuteCUEPBSMCpi3YlJ9sCmjFAKiy2LLWjCM8
         1gr75YCmkUXDCSArd6NHlISPEwsDeO601Pm3FgDqEWueRVEh3HuPYUy9q0Tck3fT0t
         9jeZsy1/XT3Sayi9zXx4UiPawuDytySzZTrcB3s1FEaxImGYvAQwaOIZzh0MC6qwKF
         nXmRUxByC9AmDbjL+2o9jNeV8aHY1QWQDwih9nxV2qcKJK3lLtnOzNfoYp6qnS1lqs
         ayIzB6/MFSR+g==
Message-ID: <c379c99f-2466-6056-4dd6-90d0a202c13c@collabora.com>
Date:   Tue, 18 Jul 2023 13:18:20 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v25 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Andrei Vagin <avagin@gmail.com>
References: <20230713101415.108875-1-usama.anjum@collabora.com>
 <20230713101415.108875-3-usama.anjum@collabora.com>
 <CANaxB-zMhhi+kHZ+3w9yzogo6fKjR=swBkuA-s88Qs5oeLRAYQ@mail.gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CANaxB-zMhhi+kHZ+3w9yzogo6fKjR=swBkuA-s88Qs5oeLRAYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/17/23 10:26 PM, Andrei Vagin wrote:
> On Thu, Jul 13, 2023 at 3:14 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
>> the info about page table entries. The following operations are supported
>> in this ioctl:
>> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
>>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT), swapped
>>   (PAGE_IS_SWAPPED) or page has pfn zero (PAGE_IS_PFNZERO).
>> - Find pages which have been written-to and/or write protect the pages
>>   (atomic PM_SCAN_OP_GET + PM_SCAN_OP_WP)
>>
>> This IOCTL can be extended to get information about more PTE bits. The
>> entire address range passed by user [start, end) is scanned until either
>> the user provided buffer is full or max_pages have been found.
>>
> 
> Reviewed-by: Andrei Vagin <avagin@gmail.com>
Thank you.

> 
> Here are a few inline comments.
> 
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes in v25:
>> - Do proper filtering on hole as well (hole got missed earlier)
>>
>> Changes in v24:
>> - Place WP markers in case of hole as well
>>
>> Changes in v23:
>> - Set vec_buf_index to 0 only when vec_buf_index is set
>> - Return -EFAULT instead of -EINVAL if vec is NULL
>> - Correctly return the walk ending address to the page granularity
>>
>> Changes in v22:
>> - Interface change to return walk ending address to user:
>>   - Replace [start start + len) with [start, end)
>>   - Return the ending address of the address walk in start
>>
>> Changes in v21:
>> - Abort walk instead of returning error if WP is to be performed on
>>   partial hugetlb
>> - Changed the data types of some variables in pagemap_scan_private to
>>   long
>>
>> Changes in v20:
>> - Correct PAGE_IS_FILE and add PAGE_IS_PFNZERO
>>
>> Changes in v19:
>> - Interface changes such as renaming, return mask and WP can be used
>>   with any flags specified in masks
>> - Internal code changes
>>
>> Changes in v18:
>> - Rebased on top of next-20230613
>>   - ptep_get() updates
>>   - remove pmd_trans_unstable() and add ACTION_AGAIN
>> - Review updates (Micheal)
>>
>> Changes in v17:
>> - Rebased on next-20230606
>> - Made make_uffd_wp_*_pte() better and minor changes
>>
>> Changes in v16:
>> - Fixed a corner case where kernel writes beyond user buffer by one
>>   element
>> - Bring back exclusive PM_SCAN_OP_WP
>> - Cosmetic changes
>>
>> Changes in v15:
>> - Build fix:
>>   - Use generic tlb flush function in pagemap_scan_pmd_entry() instead of
>>     using x86 specific flush function in do_pagemap_scan()
>>   - Remove #ifdef from pagemap_scan_hugetlb_entry()
>>   - Use mm instead of undefined vma->vm_mm
>>
>> Changes in v14:
>> - Fix build error caused by #ifdef added at last minute in some configs
>>
>> Changes in v13:
>> - Review updates
>> - mmap_read_lock_killable() instead of mmap_read_lock()
>> - Replace uffd_wp_range() with helpers which increases performance
>>   drastically for OP_WP operations by reducing the number of tlb
>>   flushing etc
>> - Add MMU_NOTIFY_PROTECTION_VMA notification for the memory range
>>
>> Changes in v12:
>> - Add hugetlb support to cover all memory types
>> - Merge "userfaultfd: Define dummy uffd_wp_range()" with this patch
>> - Review updates to the code
>>
>> Changes in v11:
>> - Find written pages in a better way
>> - Fix a corner case (thanks Paul)
>> - Improve the code/comments
>> - remove ENGAGE_WP + ! GET operation
>> - shorten the commit message in favour of moving documentation to
>>   pagemap.rst
>>
>> Changes in v10:
>> - move changes in tools/include/uapi/linux/fs.h to separate patch
>> - update commit message
>>
>> Change in v8:
>> - Correct is_pte_uffd_wp()
>> - Improve readability and error checks
>> - Remove some un-needed code
>>
>> Changes in v7:
>> - Rebase on top of latest next
>> - Fix some corner cases
>> - Base soft-dirty on the uffd wp async
>> - Update the terminologies
>> - Optimize the memory usage inside the ioctl
>> ---
>>  fs/proc/task_mmu.c      | 591 ++++++++++++++++++++++++++++++++++++++++
>>  include/linux/hugetlb.h |   1 +
>>  include/uapi/linux/fs.h |  55 ++++
>>  mm/hugetlb.c            |   2 +-
>>  4 files changed, 648 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index cfab855fe7e9..596fdfdc4387 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/shmem_fs.h>
>>  #include <linux/uaccess.h>
>>  #include <linux/pkeys.h>
>> +#include <linux/minmax.h>
>>
>>  #include <asm/elf.h>
>>  #include <asm/tlb.h>
>> @@ -1768,11 +1769,601 @@ static int pagemap_release(struct inode *inode, struct file *file)
>>         return 0;
>>  }
>>
>> +#define PM_SCAN_REQUIRE_UFFD   (1ULL << 63)
>> +
>> +#define PM_SCAN_FOUND_MAX_PAGES        (1)
>> +#define PM_SCAN_END_WALK       (-256)
> 
> I would add a comment to explain why one is negative and another one
> is positive.
Sure. I'll add.

> 
>> +
>> +#define PM_SCAN_BITS_ALL       (PAGE_IS_WRITTEN | PAGE_IS_FILE |       \
>> +                                PAGE_IS_PRESENT | PAGE_IS_SWAPPED |    \
>> +                                PAGE_IS_PFNZERO)
>> +#define PM_SCAN_OPS            (PM_SCAN_OP_GET | PM_SCAN_OP_WP)
>> +#define IS_PM_SCAN_GET(flags)  (flags & PM_SCAN_OP_GET)
>> +#define IS_PM_SCAN_WP(flags)   (flags & PM_SCAN_OP_WP)
>> +
>> +#define PM_SCAN_FLAGS(wt, file, present, swap, pfnzero)        \
>> +       ((wt) | ((file) << 1) | ((present) << 2) |      \
>> +        ((swap) << 3) | ((pfnzero) << 4))
> 
> it is better to use PAGE_IS_* constants here
#define PAGE_IS_PFNZERO		(1 << 4)
PAGE_IS_PFNZERO macro cannot be used here.

> 
>> +
>> +struct pagemap_scan_private {
>> +       struct page_region *vec_buf, cur_buf;
>> +       unsigned long vec_buf_len, vec_buf_index, max_pages, found_pages;
>> +       unsigned long long flags, required_mask, anyof_mask, excluded_mask, return_mask, end_addr;
> 
> end_addr has to be unsigned long.
Sure.

> 
>> +};
>> +
>> +static inline bool is_pte_uffd_wp(pte_t pte)
>> +{
>> +       return (pte_present(pte) && pte_uffd_wp(pte)) ||
>> +              pte_swp_uffd_wp_any(pte);
>> +}
>> +
>> +static inline void make_uffd_wp_pte(struct vm_area_struct *vma,
>> +                                   unsigned long addr, pte_t *pte)
>> +{
>> +       pte_t ptent = ptep_get(pte);
>> +
>> +       if (pte_present(ptent)) {
>> +               pte_t old_pte;
>> +
>> +               old_pte = ptep_modify_prot_start(vma, addr, pte);
>> +               ptent = pte_mkuffd_wp(ptent);
>> +               ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
>> +       } else if (is_swap_pte(ptent)) {
>> +               ptent = pte_swp_mkuffd_wp(ptent);
>> +               set_pte_at(vma->vm_mm, addr, pte, ptent);
>> +       } else {
>> +               set_pte_at(vma->vm_mm, addr, pte,
>> +                          make_pte_marker(PTE_MARKER_UFFD_WP));
>> +       }
>> +}
>> +
>> +static inline bool pagemap_scan_is_file(struct vm_area_struct *vma, pte_t ptent,
>> +                                       unsigned long addr)
>> +{
>> +       struct page *page = NULL;
>> +       swp_entry_t entry;
>> +
>> +       if (pte_present(ptent)) {
>> +               page = vm_normal_page(vma, addr, ptent);
>> +       } else {
>> +               entry = pte_to_swp_entry(ptent);
>> +               if (is_pfn_swap_entry(entry))
>> +                       page = pfn_swap_entry_to_page(entry);
>> +       }
>> +
>> +       if (page && !PageAnon(page))
>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +static inline bool is_pmd_uffd_wp(pmd_t pmd)
>> +{
>> +       return (pmd_present(pmd) && pmd_uffd_wp(pmd)) ||
>> +              (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd));
>> +}
>> +
>> +static inline void make_uffd_wp_pmd(struct vm_area_struct *vma,
>> +                                   unsigned long addr, pmd_t *pmdp)
>> +{
>> +       pmd_t old, pmd = *pmdp;
>> +
>> +       if (pmd_present(pmd)) {
>> +               old = pmdp_invalidate_ad(vma, addr, pmdp);
>> +               pmd = pmd_mkuffd_wp(old);
>> +               set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
>> +       } else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
>> +               pmd = pmd_swp_mkuffd_wp(pmd);
>> +               set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
>> +       }
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_HUGETLB_PAGE
>> +static inline bool is_huge_pte_uffd_wp(pte_t pte)
>> +{
>> +       return (pte_present(pte) && huge_pte_uffd_wp(pte)) ||
>> +              pte_swp_uffd_wp_any(pte);
>> +}
>> +
>> +static inline void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
>> +                                        unsigned long addr, pte_t *ptep,
>> +                                        pte_t ptent)
>> +{
>> +       if (is_hugetlb_entry_hwpoisoned(ptent) || is_pte_marker(ptent))
>> +               return;
>> +
>> +       if (is_hugetlb_entry_migration(ptent))
>> +               set_huge_pte_at(vma->vm_mm, addr, ptep,
>> +                               pte_swp_mkuffd_wp(ptent));
>> +       else if (!huge_pte_none(ptent))
>> +               huge_ptep_modify_prot_commit(vma, addr, ptep, ptent,
>> +                                            huge_pte_mkuffd_wp(ptent));
>> +       else
>> +               set_huge_pte_at(vma->vm_mm, addr, ptep,
>> +                               make_pte_marker(PTE_MARKER_UFFD_WP));
>> +}
>> +
>> +static inline bool pagemap_scan_is_huge_file(pte_t pte)
>> +{
>> +       if (pte_present(pte) && (!PageAnon(pte_page(pte))))
>> +               return true;
>> +
>> +       return false;
>> +}
>> +#endif
>> +
>> +static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
>> +                                 struct mm_walk *walk)
>> +{
>> +       struct pagemap_scan_private *p = walk->private;
>> +       struct vm_area_struct *vma = walk->vma;
>> +
>> +       if ((p->flags & PM_SCAN_REQUIRE_UFFD) && (!userfaultfd_wp_async(vma) ||
>> +           !userfaultfd_wp_use_markers(vma)))
>> +               return -EPERM;
>> +
>> +       if (vma->vm_flags & VM_PFNMAP)
>> +               return 1;
>> +
>> +       return 0;
>> +}
>> +
>> +static int pagemap_scan_output(unsigned long bitmap,
>> +                              struct pagemap_scan_private *p,
>> +                              unsigned long addr, unsigned int n_pages)
>> +{
>> +       struct page_region *cur_buf = &p->cur_buf;
>> +
>> +       bitmap &= p->return_mask;
>> +
>> +       if (cur_buf->flags == bitmap &&
>> +           cur_buf->start + cur_buf->len * PAGE_SIZE == addr) {
>> +               cur_buf->len += n_pages;
>> +               p->found_pages += n_pages;
>> +       } else {
>> +               if (cur_buf->len) {
>> +                       if (p->vec_buf_index >= p->vec_buf_len) {
>> +                               p->end_addr = addr;
>> +                               return PM_SCAN_END_WALK;
>> +                       }
>> +
>> +                       memcpy(&p->vec_buf[p->vec_buf_index], cur_buf,
>> +                              sizeof(*p->vec_buf));
>> +                       p->vec_buf_index++;
>> +               }
>> +
>> +               cur_buf->start = addr;
>> +               cur_buf->len = n_pages;
>> +               cur_buf->flags = bitmap;
>> +               p->found_pages += n_pages;
>> +       }
>> +
>> +       if (p->found_pages == p->max_pages) {
>> +               p->end_addr = addr + n_pages * PAGE_SIZE;
>> +               return PM_SCAN_FOUND_MAX_PAGES;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static bool pagemap_scan_is_interesting_page(unsigned long bitmap,
>> +                                            struct pagemap_scan_private *p)
>> +{
>> +       if ((p->required_mask & bitmap) != p->required_mask)
>> +               return false;
>> +       if (p->anyof_mask && !(p->anyof_mask & bitmap))
>> +               return false;
>> +       if (p->excluded_mask & bitmap)
>> +               return false;
>> +
>> +       return true;
>> +}
>> +
>> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>> +                                 unsigned long end, struct mm_walk *walk)
>> +{
>> +       bool is_written, flush = false, interesting = true;
>> +       struct pagemap_scan_private *p = walk->private;
>> +       struct vm_area_struct *vma = walk->vma;
>> +       unsigned long bitmap, addr = end;
>> +       pte_t *pte, *orig_pte, ptent;
>> +       spinlock_t *ptl;
>> +       int ret = 0;
>> +
>> +       arch_enter_lazy_mmu_mode();
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +       ptl = pmd_trans_huge_lock(pmd, vma);
>> +       if (ptl) {
>> +               unsigned long n_pages = (end - start)/PAGE_SIZE;
>> +
>> +               if (n_pages > p->max_pages - p->found_pages)
>> +                       n_pages = p->max_pages - p->found_pages;
>> +
>> +               is_written = !is_pmd_uffd_wp(*pmd);
>> +
>> +               bitmap = PM_SCAN_FLAGS(is_written, false,
>> +                                      pmd_present(*pmd), is_swap_pmd(*pmd),
>> +                                      pmd_present(*pmd) && is_zero_pfn(pmd_pfn(*pmd)));
>> +
>> +               if (IS_PM_SCAN_GET(p->flags))
>> +                       interesting = pagemap_scan_is_interesting_page(bitmap, p);
>> +
>> +               if (interesting) {
>> +                       /*
>> +                        * Break huge page into small pages if the WP operation
>> +                        * need to be performed is on a portion of the huge page.
>> +                        */
>> +                       if (is_written && IS_PM_SCAN_WP(p->flags) &&
>> +                           n_pages < HPAGE_SIZE/PAGE_SIZE) {
>> +                               spin_unlock(ptl);
>> +
>> +                               split_huge_pmd(vma, pmd, start);
>> +                               goto process_smaller_pages;
>> +                       }
>> +
>> +                       if (IS_PM_SCAN_GET(p->flags))
>> +                               ret = pagemap_scan_output(bitmap, p, start, n_pages);
>> +
>> +                       if (IS_PM_SCAN_WP(p->flags) && is_written && ret >= 0) {
>> +                               make_uffd_wp_pmd(vma, start, pmd);
>> +                               flush_tlb_range(vma, start, end);
>> +                       }
>> +               }
>> +
>> +               spin_unlock(ptl);
>> +               arch_leave_lazy_mmu_mode();
>> +
>> +               return ret;
>> +       }
>> +
>> +process_smaller_pages:
>> +#endif
>> +
>> +       orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
>> +       if (!pte) {
>> +               walk->action = ACTION_AGAIN;
>> +               return 0;
>> +       }
>> +
>> +       for (addr = start; addr < end && !ret; pte++, addr += PAGE_SIZE) {
>> +               ptent = ptep_get(pte);
>> +               is_written = !is_pte_uffd_wp(ptent);
>> +
>> +               bitmap = PM_SCAN_FLAGS(is_written, pagemap_scan_is_file(vma, ptent, addr),
>> +                                      pte_present(ptent), is_swap_pte(ptent),
>> +                                      pte_present(ptent) && is_zero_pfn(pte_pfn(ptent)));
>> +
>> +               if (IS_PM_SCAN_GET(p->flags)) {
>> +                       interesting = pagemap_scan_is_interesting_page(bitmap, p);
>> +                       if (interesting)
>> +                               ret = pagemap_scan_output(bitmap, p, addr, 1);
>> +               }
>> +
>> +               if (IS_PM_SCAN_WP(p->flags) && is_written && interesting &&
>> +                   ret >= 0) {
>> +                       make_uffd_wp_pte(vma, addr, pte);
>> +                       flush = true;
>> +               }
>> +       }
>> +
>> +       if (flush)
>> +               flush_tlb_range(vma, start, addr);
>> +
>> +       pte_unmap_unlock(orig_pte, ptl);
>> +       arch_leave_lazy_mmu_mode();
>> +
>> +       cond_resched();
>> +       return ret;
>> +}
>> +
>> +#ifdef CONFIG_HUGETLB_PAGE
>> +static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
>> +                                     unsigned long start, unsigned long end,
>> +                                     struct mm_walk *walk)
>> +{
>> +       unsigned long n_pages = (end - start)/PAGE_SIZE;
>> +       struct pagemap_scan_private *p = walk->private;
>> +       struct vm_area_struct *vma = walk->vma;
>> +       bool is_written, interesting = true;
>> +       struct hstate *h = hstate_vma(vma);
>> +       unsigned long bitmap;
>> +       spinlock_t *ptl;
>> +       int ret = 0;
>> +       pte_t ptent;
>> +
>> +       if (IS_PM_SCAN_WP(p->flags) && n_pages < HPAGE_SIZE/PAGE_SIZE) {
>> +               p->end_addr = start;
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (n_pages > p->max_pages - p->found_pages)
>> +               n_pages = p->max_pages - p->found_pages;
>> +
>> +       if (IS_PM_SCAN_WP(p->flags)) {
>> +               i_mmap_lock_write(vma->vm_file->f_mapping);
>> +               ptl = huge_pte_lock(h, vma->vm_mm, ptep);
>> +       }
>> +
>> +       ptent = huge_ptep_get(ptep);
>> +       is_written = !is_huge_pte_uffd_wp(ptent);
>> +
>> +       bitmap = PM_SCAN_FLAGS(is_written, pagemap_scan_is_huge_file(ptent),
>> +                              pte_present(ptent), is_swap_pte(ptent),
>> +                              pte_present(ptent) && is_zero_pfn(pte_pfn(ptent)));
>> +
>> +       if (IS_PM_SCAN_GET(p->flags))
>> +               interesting = pagemap_scan_is_interesting_page(bitmap, p);
>> +
>> +       if (interesting) {
>> +               /*
>> +                * Partial hugetlb page clear isn't supported
>> +                */
>> +               if (is_written && IS_PM_SCAN_WP(p->flags) &&
>> +                   n_pages < HPAGE_SIZE/PAGE_SIZE) {
>> +                       ret = PM_SCAN_END_WALK;
>> +                       p->end_addr = start;
>> +                       goto unlock_and_return;
>> +               }
>> +
>> +               if (IS_PM_SCAN_GET(p->flags))
>> +                       ret = pagemap_scan_output(bitmap, p, start, n_pages);
>> +
>> +               if (IS_PM_SCAN_WP(p->flags) && is_written && ret >= 0) {
>> +                       make_uffd_wp_huge_pte(vma, start, ptep, ptent);
>> +                       flush_hugetlb_tlb_range(vma, start, end);
>> +               }
>> +       }
>> +
>> +unlock_and_return:
>> +       if (IS_PM_SCAN_WP(p->flags)) {
>> +               spin_unlock(ptl);
>> +               i_mmap_unlock_write(vma->vm_file->f_mapping);
>> +       }
>> +
>> +       return ret;
>> +}
>> +#else
>> +#define pagemap_scan_hugetlb_entry NULL
>> +#endif
>> +
>> +static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
>> +                                int depth, struct mm_walk *walk)
>> +{
>> +       unsigned long n_pages = (end - addr)/PAGE_SIZE;
>> +       struct pagemap_scan_private *p = walk->private;
>> +       struct vm_area_struct *vma = walk->vma;
>> +       bool interesting = true;
>> +       unsigned long bitmap;
>> +       int ret = 0;
>> +
>> +       if (!vma)
>> +               return 0;
>> +
>> +       bitmap = PM_SCAN_FLAGS(false, false, false, false, false);
>> +
>> +       if (IS_PM_SCAN_GET(p->flags))
>> +               interesting = pagemap_scan_is_interesting_page(bitmap, p);
>> +
>> +       if (interesting) {
>> +               if (IS_PM_SCAN_GET(p->flags)) {
>> +                       if (n_pages > p->max_pages - p->found_pages)
>> +                               n_pages = p->max_pages - p->found_pages;
>> +
>> +                       ret = pagemap_scan_output(bitmap, p, addr, n_pages);
>> +               }
>> +
>> +               if (IS_PM_SCAN_WP(p->flags) && !ret &&
>> +                   uffd_wp_range(vma, addr, end - addr, true) < 0)
> 
> Why do we need to call uffd_wp_range for holes? Should we call
> flush_tlb_range after it?
> 
>> +                       ret = -EINVAL;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static const struct mm_walk_ops pagemap_scan_ops = {
>> +       .test_walk = pagemap_scan_test_walk,
>> +       .pmd_entry = pagemap_scan_pmd_entry,
>> +       .pte_hole = pagemap_scan_pte_hole,
>> +       .hugetlb_entry = pagemap_scan_hugetlb_entry,
>> +};
>> +
>> +static int pagemap_scan_args_valid(struct pm_scan_arg *arg, unsigned long start,
>> +                                  unsigned long end, struct page_region __user *vec)
>> +{
>> +       /* Detect illegal size, flags, len and masks */
>> +       if (arg->size != sizeof(struct pm_scan_arg))
>> +               return -EINVAL;
>> +       if (!arg->flags)
>> +               return -EINVAL;
>> +       if (arg->flags & ~PM_SCAN_OPS)
>> +               return -EINVAL;
>> +       if (!(end - start))
>> +               return -EINVAL;
>> +       if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask |
>> +            arg->return_mask) & ~PM_SCAN_BITS_ALL)
>> +               return -EINVAL;
>> +       if (!arg->required_mask && !arg->anyof_mask &&
>> +           !arg->excluded_mask)
>> +               return -EINVAL;
>> +       if (!arg->return_mask)
>> +               return -EINVAL;
>> +
>> +       /* Validate memory range */
>> +       if (!IS_ALIGNED(start, PAGE_SIZE))
>> +               return -EINVAL;
>> +       if (!access_ok((void __user *)start, end - start))
>> +               return -EFAULT;
>> +
>> +       if (IS_PM_SCAN_GET(arg->flags)) {
>> +               if (arg->vec_len == 0)
>> +                       return -EINVAL;
>> +               if (!vec)
>> +                       return -EFAULT;
>> +               if (!access_ok((void __user *)vec,
>> +                              arg->vec_len * sizeof(struct page_region)))
>> +                       return -EFAULT;
>> +       }
>> +
>> +       if (IS_PM_SCAN_WP(arg->flags) && !IS_PM_SCAN_GET(arg->flags) &&
>> +           arg->max_pages)
>> +               return -EINVAL;
>> +
>> +       return 0;
>> +}
>> +
>> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long __arg)
>> +{
>> +       struct pm_scan_arg __user *uarg = (struct pm_scan_arg __user *)__arg;
>> +       unsigned long long start, end, walk_start, walk_end;
>> +       unsigned long empty_slots, vec_index = 0;
>> +       struct mmu_notifier_range range;
>> +       struct page_region __user *vec;
>> +       struct pagemap_scan_private p;
>> +       struct pm_scan_arg arg;
>> +       int ret = 0;
>> +
>> +       if (copy_from_user(&arg, uarg, sizeof(arg)))
>> +               return -EFAULT;
>> +
>> +       start = untagged_addr((unsigned long)arg.start);
>> +       end = untagged_addr((unsigned long)arg.end);
>> +       vec = (struct page_region __user *)untagged_addr((unsigned long)arg.vec);
>> +
>> +       ret = pagemap_scan_args_valid(&arg, start, end, vec);
>> +       if (ret)
>> +               return ret;
>> +
>> +       p.max_pages = (arg.max_pages) ? arg.max_pages : ULONG_MAX;
>> +       p.found_pages = 0;
>> +       p.required_mask = arg.required_mask;
>> +       p.anyof_mask = arg.anyof_mask;
>> +       p.excluded_mask = arg.excluded_mask;
>> +       p.return_mask = arg.return_mask;
>> +       p.flags = arg.flags;
>> +       p.flags |= ((p.required_mask | p.anyof_mask | p.excluded_mask) &
>> +                   PAGE_IS_WRITTEN) ? PM_SCAN_REQUIRE_UFFD : 0;
>> +       p.cur_buf.start = p.cur_buf.len = p.cur_buf.flags = 0;
>> +       p.vec_buf = NULL;
>> +       p.vec_buf_len = PAGEMAP_WALK_SIZE >> PAGE_SHIFT;
>> +       p.vec_buf_index = 0;
>> +       p.end_addr = 0;
>> +
>> +       /*
>> +        * Allocate smaller buffer to get output from inside the page walk
>> +        * functions and walk page range in PAGEMAP_WALK_SIZE size chunks. As
>> +        * we want to return output to user in compact form where no two
>> +        * consecutive regions should be continuous and have the same flags.
>> +        * So store the latest element in p.cur_buf between different walks and
>> +        * store the p.cur_buf at the end of the walk to the user buffer.
>> +        */
>> +       if (IS_PM_SCAN_GET(p.flags)) {
>> +               p.vec_buf = kmalloc_array(p.vec_buf_len, sizeof(*p.vec_buf),
>> +                                         GFP_KERNEL);
>> +               if (!p.vec_buf)
>> +                       return -ENOMEM;
>> +       }
>> +
>> +       /*
>> +        * Protection change for the range is going to happen.
>> +        */
>> +       if (IS_PM_SCAN_WP(p.flags)) {
>> +               mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
>> +                                       mm, start, end);
>> +               mmu_notifier_invalidate_range_start(&range);
>> +       }
>> +
>> +       walk_start = walk_end = start;
>> +       while (walk_end < end && !ret) {
>> +               if (IS_PM_SCAN_GET(p.flags)) {
>> +                       /*
>> +                        * All data is copied to cur_buf first. When more data
>> +                        * is found, we push cur_buf to vec_buf and copy new
>> +                        * data to cur_buf. Subtract 1 from length as the
>> +                        * index of cur_buf isn't counted in length.
>> +                        */
>> +                       empty_slots = arg.vec_len - vec_index;
>> +                       p.vec_buf_len = min(p.vec_buf_len, empty_slots - 1);
>> +               }
>> +
> 
> I still don't understand why we don't want/need to check for pending signals.
We haven't added it as other existing code such as mincore() and
pagemap_read() don't have it either. Also mmap_read_lock_killable would
return error if there is some critical single pending.

> 
>> +               ret = mmap_read_lock_killable(mm);
>> +               if (ret)
>> +                       goto out;
>> +
>> +               walk_end = min((walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK, end);
>> +
>> +               ret = walk_page_range(mm, walk_start, walk_end,
>> +                                     &pagemap_scan_ops, &p);
>> +               mmap_read_unlock(mm);
>> +
>> +               if (ret == PM_SCAN_FOUND_MAX_PAGES || ret == PM_SCAN_END_WALK)
>> +                       arg.start = p.end_addr;
> 
> nit: this check can be moved out of the loop.
No, ret could get replaced by error if copy_to_user() fails. So we have to
do this before that.

> 
>> +
>> +               if (ret && ret != PM_SCAN_FOUND_MAX_PAGES &&
>> +                   ret != PM_SCAN_END_WALK)
>> +                       goto out;
>> +
>> +               if (p.vec_buf_index) {
>> +                       if (copy_to_user(&vec[vec_index], p.vec_buf,
>> +                                        p.vec_buf_index * sizeof(*p.vec_buf))) {
>> +                               /*
>> +                                * Return error even though the OP succeeded
>> +                                */
>> +                               ret = -EFAULT;
>> +                               goto out;
>> +                       }
>> +                       vec_index += p.vec_buf_index;
>> +                       p.vec_buf_index = 0;
>> +               }
>> +               walk_start = walk_end;
>> +       }
>> +
>> +       if (p.cur_buf.len) {
>> +               if (copy_to_user(&vec[vec_index], &p.cur_buf, sizeof(p.cur_buf))) {
>> +                       ret = -EFAULT;
>> +                       goto out;
>> +               }
>> +               vec_index++;
>> +       }
>> +
>> +       ret = vec_index;
>> +
>> +out:
>> +       if (!p.end_addr)
>> +               arg.start = walk_start;
>> +       if (copy_to_user(&uarg->start, &arg.start, sizeof(arg.start)))
>> +               ret = -EFAULT;
>> +
>> +       if (IS_PM_SCAN_WP(p.flags))
>> +               mmu_notifier_invalidate_range_end(&range);
>> +
>> +       kfree(p.vec_buf);
>> +       return ret;
>> +}
>> +
>> +static long do_pagemap_cmd(struct file *file, unsigned int cmd,
>> +                          unsigned long arg)
>> +{
>> +       struct mm_struct *mm = file->private_data;
>> +
>> +       switch (cmd) {
>> +       case PAGEMAP_SCAN:
>> +               return do_pagemap_scan(mm, arg);
>> +
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +}
>> +
>>  const struct file_operations proc_pagemap_operations = {
>>         .llseek         = mem_lseek, /* borrow this */
>>         .read           = pagemap_read,
>>         .open           = pagemap_open,
>>         .release        = pagemap_release,
>> +       .unlocked_ioctl = do_pagemap_cmd,
>> +       .compat_ioctl   = do_pagemap_cmd,
>>  };
>>  #endif /* CONFIG_PROC_PAGE_MONITOR */
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 623e98d62df3..c44e7bde0339 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -259,6 +259,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>>                 unsigned long cp_flags);
>>
>>  bool is_hugetlb_entry_migration(pte_t pte);
>> +bool is_hugetlb_entry_hwpoisoned(pte_t pte);
>>  void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
>>
>>  #else /* !CONFIG_HUGETLB_PAGE */
>> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
>> index b7b56871029c..ac684d99e68f 100644
>> --- a/include/uapi/linux/fs.h
>> +++ b/include/uapi/linux/fs.h
>> @@ -305,4 +305,59 @@ typedef int __bitwise __kernel_rwf_t;
>>  #define RWF_SUPPORTED  (RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
>>                          RWF_APPEND)
>>
>> +/* Pagemap ioctl */
>> +#define PAGEMAP_SCAN   _IOWR('f', 16, struct pm_scan_arg)
>> +
>> +/* Bits are set in flags of the page_region and masks in pm_scan_args */
>> +#define PAGE_IS_WRITTEN                (1 << 0)
>> +#define PAGE_IS_FILE           (1 << 1)
>> +#define PAGE_IS_PRESENT                (1 << 2)
>> +#define PAGE_IS_SWAPPED                (1 << 3)
>> +#define PAGE_IS_PFNZERO                (1 << 4)
>> +
>> +/*
>> + * struct page_region - Page region with flags
>> + * @start:     Start of the region
>> + * @len:       Length of the region in pages
>> + * @bitmap:    Bits sets for the region
>> + */
>> +struct page_region {
>> +       __u64 start;
>> +       __u64 len;
>> +       __u64 flags;
>> +};
>> +
>> +/*
>> + * struct pm_scan_arg - Pagemap ioctl argument
>> + * @size:              Size of the structure
>> + * @flags:             Flags for the IOCTL
>> + * @start:             Starting address of the region
>> + *                     (Ending address of the walk is also returned in it)
>> + * @end:               Ending address of the region
>> + * @vec:               Address of page_region struct array for output
>> + * @vec_len:           Length of the page_region struct array
>> + * @max_pages:         Optional max return pages
>> + * @required_mask:     Required mask - All of these bits have to be set in the PTE
>> + * @anyof_mask:                Any mask - Any of these bits are set in the PTE
>> + * @excluded_mask:     Exclude mask - None of these bits are set in the PTE
>> + * @return_mask:       Bits that are to be reported in page_region
>> + */
>> +struct pm_scan_arg {
>> +       __u64 size;
>> +       __u64 flags;
>> +       __u64 start;
>> +       __u64 end;
>> +       __u64 vec;
>> +       __u64 vec_len;
>> +       __u64 max_pages;
>> +       __u64 required_mask;
>> +       __u64 anyof_mask;
>> +       __u64 excluded_mask;
>> +       __u64 return_mask;
>> +};
>> +
>> +/* Supported flags */
>> +#define PM_SCAN_OP_GET (1 << 0)
>> +#define PM_SCAN_OP_WP  (1 << 1)
>> +
>>  #endif /* _UAPI_LINUX_FS_H */
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index ee88a2a6649f..f7cefdcb114c 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -4981,7 +4981,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
>>                 return false;
>>  }
>>
>> -static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
>> +bool is_hugetlb_entry_hwpoisoned(pte_t pte)
>>  {
>>         swp_entry_t swp;
>>
>> --
>> 2.39.2
>>

-- 
BR,
Muhammad Usama Anjum
