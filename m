Return-Path: <linux-kselftest+bounces-25020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A80A1A7B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 17:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004193A9436
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 16:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBD820E717;
	Thu, 23 Jan 2025 16:17:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB95328B6;
	Thu, 23 Jan 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737649074; cv=none; b=gyz5CyDAXt9JTnzmlL4oMODmmBrKz5LOCV+zqxBMx0aE7eFb4p2AhPcC9N9c8NInrVEipwKx+yiKCJXgGJdPvtrgM6jUe/PJIfhCrR9ZK7EZH6YUA4L8ILrRgH5hkGvEsMDu/EtwyS8cFfldZKkhtNvJhqrn8xrIyRDggGeGKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737649074; c=relaxed/simple;
	bh=masMIEniTZPeVnhoxedNAqD6HzLr+m/CrOIgdJSywoc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ubUH8Tuiy8PNuk6A1LcWF3fXUgoyq4SXqpoiGmc3RbSniopxu71nhfsck4mO5ZlBrFS5JZM/Dg8JzDOAI2flrGztTchXFu8irotKdKN63M5s3r/EDWyL1QydcWWIZ50S3AAgy0HEh/W8ab3D1igF2aVlQjosw9/l3z/ZStJyjGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77F841063;
	Thu, 23 Jan 2025 08:18:13 -0800 (PST)
Received: from [10.1.33.169] (XHFQ2J9959.cambridge.arm.com [10.1.33.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 862883F5A1;
	Thu, 23 Jan 2025 08:17:43 -0800 (PST)
Message-ID: <d6654c11-234f-4331-a7a1-397ee31398ec@arm.com>
Date: Thu, 23 Jan 2025 16:17:42 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: Clear uffd-wp PTE/PMD state on mremap()
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
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
 <850479be-000a-45a7-9669-491d4200a988@arm.com>
In-Reply-To: <850479be-000a-45a7-9669-491d4200a988@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/01/2025 14:38, Ryan Roberts wrote:
> I think there might be a bug in this after all...
> 
> 
> On 07/01/2025 14:47, Ryan Roberts wrote:
>> When mremap()ing a memory region previously registered with userfaultfd
>> as write-protected but without UFFD_FEATURE_EVENT_REMAP, an
>> inconsistency in flag clearing leads to a mismatch between the vma flags
>> (which have uffd-wp cleared) and the pte/pmd flags (which do not have
>> uffd-wp cleared). This mismatch causes a subsequent mprotect(PROT_WRITE)
>> to trigger a warning in page_table_check_pte_flags() due to setting the
>> pte to writable while uffd-wp is still set.
>>
>> Fix this by always explicitly clearing the uffd-wp pte/pmd flags on any
>> such mremap() so that the values are consistent with the existing
>> clearing of VM_UFFD_WP. Be careful to clear the logical flag regardless
>> of its physical form; a PTE bit, a swap PTE bit, or a PTE marker. Cover
>> PTE, huge PMD and hugetlb paths.
>>
>> Co-developed-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
>> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Closes: https://lore.kernel.org/linux-mm/810b44a8-d2ae-4107-b665-5a42eae2d948@arm.com/
>> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
>> Cc: stable@vger.kernel.org
>> ---
>>  include/linux/userfaultfd_k.h | 12 ++++++++++++
>>  mm/huge_memory.c              | 12 ++++++++++++
>>  mm/hugetlb.c                  | 14 +++++++++++++-
>>  mm/mremap.c                   | 32 +++++++++++++++++++++++++++++++-
>>  4 files changed, 68 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
>> index cb40f1a1d081..75342022d144 100644
>> --- a/include/linux/userfaultfd_k.h
>> +++ b/include/linux/userfaultfd_k.h
>> @@ -247,6 +247,13 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
>>  	    vma_is_shmem(vma);
>>  }
>>  
>> +static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
>> +{
>> +	struct userfaultfd_ctx *uffd_ctx = vma->vm_userfaultfd_ctx.ctx;
>> +
>> +	return uffd_ctx && (uffd_ctx->features & UFFD_FEATURE_EVENT_REMAP) == 0;
>> +}
>> +
>>  extern int dup_userfaultfd(struct vm_area_struct *, struct list_head *);
>>  extern void dup_userfaultfd_complete(struct list_head *);
>>  void dup_userfaultfd_fail(struct list_head *);
>> @@ -402,6 +409,11 @@ static inline bool userfaultfd_wp_async(struct vm_area_struct *vma)
>>  	return false;
>>  }
>>  
>> +static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
>> +{
>> +	return false;
>> +}
>> +
>>  #endif /* CONFIG_USERFAULTFD */
>>  
>>  static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index c89aed1510f1..2654a9548749 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2212,6 +2212,16 @@ static pmd_t move_soft_dirty_pmd(pmd_t pmd)
>>  	return pmd;
>>  }
>>  
>> +static pmd_t clear_uffd_wp_pmd(pmd_t pmd)
>> +{
>> +	if (pmd_present(pmd))
>> +		pmd = pmd_clear_uffd_wp(pmd);
>> +	else if (is_swap_pmd(pmd))
>> +		pmd = pmd_swp_clear_uffd_wp(pmd);
>> +
>> +	return pmd;
>> +}
>> +
>>  bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>>  		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
>>  {
>> @@ -2250,6 +2260,8 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>>  			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
>>  		}
>>  		pmd = move_soft_dirty_pmd(pmd);
>> +		if (vma_has_uffd_without_event_remap(vma))
>> +			pmd = clear_uffd_wp_pmd(pmd);
>>  		set_pmd_at(mm, new_addr, new_pmd, pmd);
>>  		if (force_flush)
>>  			flush_pmd_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 354eec6f7e84..cdbc55d5384f 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -5454,6 +5454,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
>>  			  unsigned long new_addr, pte_t *src_pte, pte_t *dst_pte,
>>  			  unsigned long sz)
>>  {
>> +	bool need_clear_uffd_wp = vma_has_uffd_without_event_remap(vma);
>>  	struct hstate *h = hstate_vma(vma);
>>  	struct mm_struct *mm = vma->vm_mm;
>>  	spinlock_t *src_ptl, *dst_ptl;
>> @@ -5470,7 +5471,18 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
>>  		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>>  
>>  	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
>> -	set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
>> +
>> +	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
>> +		huge_pte_clear(mm, new_addr, dst_pte, sz);
> 
> This is checking if the source huge_pte is a uffd-wp marker and clearing the
> destination if so. The destination could have previously held arbitrary valid
> mappings, I guess?
> 
> But huge_pte_clear() does not call page_table_check_pte_clear(). So any previous
> valid mapping will not have it's page_table_check ref count decremented?
> 
> I think it should be replaced with:
> 		huge_ptep_get_and_clear(mm, new_addr, dst_pte);
> 
> Since there is no huge_ptep_clear().
> 
> The tests I wrote are always mremapping into PROT_NONE space so they don't hit
> this condition. If people agree this is a bug, I'll send out a fix.

OK I'm deep in the rabbit hole now; Could anyone clarify the specs for
huge_pte_clear() and huge_ptep_get_and_clear()? Specifically, I believe:

  - huge_pte_clear() can only be called for not-present huge_ptes, because the
only way to set a huge_pte is via set_huge_pte_at() and that will always execute
the page_table_check_*_set() functions for present huge_ptes. So clearing a
present huge_pte using huge_pte_clear(), which does not call
page_table_check_*_clear(), would cause counter imbalance. It looks like
existing generic-code callers of huge_pte_clear() only do it for non-present
huge_ptes.

  - huge_ptep_get_and_clear() can be used to get-and-clear both present and
non-present huge_ptes? There is a single call site in generic-code where this
could be called for a non-present huge_pte: move_huge_pte() (and it was there
prior to my change). BUT, it looks like the arm64 implementation of
huge_ptep_get_and_clear() is not safe to call if the pte being cleared is
non-present:

pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
			      unsigned long addr, pte_t *ptep)
{
	int ncontig;
	size_t pgsize;
	pte_t orig_pte = __ptep_get(ptep);

	if (!pte_cont(orig_pte))
		return __ptep_get_and_clear(mm, addr, ptep);

	ncontig = find_num_contig(mm, addr, ptep, &pgsize);

	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
}

pte_cont() assumes the pte is present, otherwise it's sampling a random bit that
doesn't have the meaning it thinks it has. It is currently relying on that to
determine the size of the huge_pte.

So either arm64 has a bug or move_huge_pte() has a bug. If
huge_ptep_get_and_clear() needs to work for non-present huge_ptes, we will need
to pass the huge_pte size into this function. I don't think there is another way
to resolve this.

Thanks,
Ryan



> 
> Thanks,
> Ryan
> 

