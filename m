Return-Path: <linux-kselftest+bounces-25012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AA9A1A5DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 15:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CA216934C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DAF21147C;
	Thu, 23 Jan 2025 14:38:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EDF20F09D;
	Thu, 23 Jan 2025 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737643133; cv=none; b=b7R5OH+S+6WGeefPxmUMx3CBjG59R/9ACoR6hS9cYbPcoemkOQMcZ4Zx4czb4U25Ywgnk/ABlcBx2fRphrxJaWF9BlE3dpwkFAcs7GyGNlc+hkvWuMcMosdAIjvbrObCRL6pq8SZZNez/XoJk7Qo/j3RLVCri1JmbtVqlWYqQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737643133; c=relaxed/simple;
	bh=2qCEZ0Q9CvPTKNm9nYPanBAaN7ySShjxUg3ZlMLDolU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IX9QiURtt7es4UUzEyS3vpsVIAZKR6tHukYrLMRosLJ8KbO8RTBBGE8T5qZStKtvL07Jgs7JNcwcbEl7wqO97cLaagnOdMXMCeEqzK5+/QDddhj6hc6R0z7UhJGye/+NfUIC/BX9PWc8DSn66K2EhlSM3dpp0q36Q1sWDwjXZt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 184AB1063;
	Thu, 23 Jan 2025 06:39:18 -0800 (PST)
Received: from [10.1.33.169] (XHFQ2J9959.cambridge.arm.com [10.1.33.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 209FC3F694;
	Thu, 23 Jan 2025 06:38:48 -0800 (PST)
Message-ID: <850479be-000a-45a7-9669-491d4200a988@arm.com>
Date: Thu, 23 Jan 2025 14:38:46 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: Clear uffd-wp PTE/PMD state on mremap()
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20250107144755.1871363-1-ryan.roberts@arm.com>
 <20250107144755.1871363-2-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250107144755.1871363-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I think there might be a bug in this after all...


On 07/01/2025 14:47, Ryan Roberts wrote:
> When mremap()ing a memory region previously registered with userfaultfd
> as write-protected but without UFFD_FEATURE_EVENT_REMAP, an
> inconsistency in flag clearing leads to a mismatch between the vma flags
> (which have uffd-wp cleared) and the pte/pmd flags (which do not have
> uffd-wp cleared). This mismatch causes a subsequent mprotect(PROT_WRITE)
> to trigger a warning in page_table_check_pte_flags() due to setting the
> pte to writable while uffd-wp is still set.
> 
> Fix this by always explicitly clearing the uffd-wp pte/pmd flags on any
> such mremap() so that the values are consistent with the existing
> clearing of VM_UFFD_WP. Be careful to clear the logical flag regardless
> of its physical form; a PTE bit, a swap PTE bit, or a PTE marker. Cover
> PTE, huge PMD and hugetlb paths.
> 
> Co-developed-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Closes: https://lore.kernel.org/linux-mm/810b44a8-d2ae-4107-b665-5a42eae2d948@arm.com/
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Cc: stable@vger.kernel.org
> ---
>  include/linux/userfaultfd_k.h | 12 ++++++++++++
>  mm/huge_memory.c              | 12 ++++++++++++
>  mm/hugetlb.c                  | 14 +++++++++++++-
>  mm/mremap.c                   | 32 +++++++++++++++++++++++++++++++-
>  4 files changed, 68 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index cb40f1a1d081..75342022d144 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -247,6 +247,13 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
>  	    vma_is_shmem(vma);
>  }
>  
> +static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
> +{
> +	struct userfaultfd_ctx *uffd_ctx = vma->vm_userfaultfd_ctx.ctx;
> +
> +	return uffd_ctx && (uffd_ctx->features & UFFD_FEATURE_EVENT_REMAP) == 0;
> +}
> +
>  extern int dup_userfaultfd(struct vm_area_struct *, struct list_head *);
>  extern void dup_userfaultfd_complete(struct list_head *);
>  void dup_userfaultfd_fail(struct list_head *);
> @@ -402,6 +409,11 @@ static inline bool userfaultfd_wp_async(struct vm_area_struct *vma)
>  	return false;
>  }
>  
> +static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_USERFAULTFD */
>  
>  static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c89aed1510f1..2654a9548749 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2212,6 +2212,16 @@ static pmd_t move_soft_dirty_pmd(pmd_t pmd)
>  	return pmd;
>  }
>  
> +static pmd_t clear_uffd_wp_pmd(pmd_t pmd)
> +{
> +	if (pmd_present(pmd))
> +		pmd = pmd_clear_uffd_wp(pmd);
> +	else if (is_swap_pmd(pmd))
> +		pmd = pmd_swp_clear_uffd_wp(pmd);
> +
> +	return pmd;
> +}
> +
>  bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>  		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
>  {
> @@ -2250,6 +2260,8 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>  			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
>  		}
>  		pmd = move_soft_dirty_pmd(pmd);
> +		if (vma_has_uffd_without_event_remap(vma))
> +			pmd = clear_uffd_wp_pmd(pmd);
>  		set_pmd_at(mm, new_addr, new_pmd, pmd);
>  		if (force_flush)
>  			flush_pmd_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 354eec6f7e84..cdbc55d5384f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5454,6 +5454,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
>  			  unsigned long new_addr, pte_t *src_pte, pte_t *dst_pte,
>  			  unsigned long sz)
>  {
> +	bool need_clear_uffd_wp = vma_has_uffd_without_event_remap(vma);
>  	struct hstate *h = hstate_vma(vma);
>  	struct mm_struct *mm = vma->vm_mm;
>  	spinlock_t *src_ptl, *dst_ptl;
> @@ -5470,7 +5471,18 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
>  		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>  
>  	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
> -	set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
> +
> +	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
> +		huge_pte_clear(mm, new_addr, dst_pte, sz);

This is checking if the source huge_pte is a uffd-wp marker and clearing the
destination if so. The destination could have previously held arbitrary valid
mappings, I guess?

But huge_pte_clear() does not call page_table_check_pte_clear(). So any previous
valid mapping will not have it's page_table_check ref count decremented?

I think it should be replaced with:
		huge_ptep_get_and_clear(mm, new_addr, dst_pte);

Since there is no huge_ptep_clear().

The tests I wrote are always mremapping into PROT_NONE space so they don't hit
this condition. If people agree this is a bug, I'll send out a fix.

Thanks,
Ryan

> +	else {
> +		if (need_clear_uffd_wp) {
> +			if (pte_present(pte))
> +				pte = huge_pte_clear_uffd_wp(pte);
> +			else if (is_swap_pte(pte))
> +				pte = pte_swp_clear_uffd_wp(pte);
> +		}
> +		set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
> +	}
>  
>  	if (src_ptl != dst_ptl)
>  		spin_unlock(src_ptl);
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 60473413836b..cff7f552f909 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -138,6 +138,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
>  		struct vm_area_struct *new_vma, pmd_t *new_pmd,
>  		unsigned long new_addr, bool need_rmap_locks)
>  {
> +	bool need_clear_uffd_wp = vma_has_uffd_without_event_remap(vma);
>  	struct mm_struct *mm = vma->vm_mm;
>  	pte_t *old_pte, *new_pte, pte;
>  	pmd_t dummy_pmdval;
> @@ -216,7 +217,18 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
>  			force_flush = true;
>  		pte = move_pte(pte, old_addr, new_addr);
>  		pte = move_soft_dirty_pte(pte);
> -		set_pte_at(mm, new_addr, new_pte, pte);
> +
> +		if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
> +			pte_clear(mm, new_addr, new_pte);
> +		else {
> +			if (need_clear_uffd_wp) {
> +				if (pte_present(pte))
> +					pte = pte_clear_uffd_wp(pte);
> +				else if (is_swap_pte(pte))
> +					pte = pte_swp_clear_uffd_wp(pte);
> +			}
> +			set_pte_at(mm, new_addr, new_pte, pte);
> +		}
>  	}
>  
>  	arch_leave_lazy_mmu_mode();
> @@ -278,6 +290,15 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>  	if (WARN_ON_ONCE(!pmd_none(*new_pmd)))
>  		return false;
>  
> +	/* If this pmd belongs to a uffd vma with remap events disabled, we need
> +	 * to ensure that the uffd-wp state is cleared from all pgtables. This
> +	 * means recursing into lower page tables in move_page_tables(), and we
> +	 * can reuse the existing code if we simply treat the entry as "not
> +	 * moved".
> +	 */
> +	if (vma_has_uffd_without_event_remap(vma))
> +		return false;
> +
>  	/*
>  	 * We don't have to worry about the ordering of src and dst
>  	 * ptlocks because exclusive mmap_lock prevents deadlock.
> @@ -333,6 +354,15 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
>  	if (WARN_ON_ONCE(!pud_none(*new_pud)))
>  		return false;
>  
> +	/* If this pud belongs to a uffd vma with remap events disabled, we need
> +	 * to ensure that the uffd-wp state is cleared from all pgtables. This
> +	 * means recursing into lower page tables in move_page_tables(), and we
> +	 * can reuse the existing code if we simply treat the entry as "not
> +	 * moved".
> +	 */
> +	if (vma_has_uffd_without_event_remap(vma))
> +		return false;
> +
>  	/*
>  	 * We don't have to worry about the ordering of src and dst
>  	 * ptlocks because exclusive mmap_lock prevents deadlock.


