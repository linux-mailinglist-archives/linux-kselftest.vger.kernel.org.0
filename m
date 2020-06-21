Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57468202DAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 01:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgFUXe4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Jun 2020 19:34:56 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19274 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFUXez (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Jun 2020 19:34:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eefee720000>; Sun, 21 Jun 2020 16:34:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 21 Jun 2020 16:34:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 21 Jun 2020 16:34:54 -0700
Received: from [10.2.170.235] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 21 Jun
 2020 23:34:45 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     <nouveau@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 13/16] mm: support THP migration to device private memory
Date:   Sun, 21 Jun 2020 19:20:57 -0400
X-Mailer: MailMate (1.13.1r5690)
Message-ID: <F1872509-3B1F-4A8A-BFF5-E4D44E451920@nvidia.com>
In-Reply-To: <20200619215649.32297-14-rcampbell@nvidia.com>
References: <20200619215649.32297-1-rcampbell@nvidia.com>
 <20200619215649.32297-14-rcampbell@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_E60B1D31-2014-4BE8-B1A9-114D2F6A082A_=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592782450; bh=1p9z53uWBQuQIuhlfDi5txoa8nYbELRQXcJBreYtaAo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=IgfnFc00G53xBZqFLRuyLnRkxeihO5qCC6Gm1msgcat2Qtex9tXaHWfekwGMtiPBg
         V43Y6kxXVSrXmz+2ZVWX6No5YxsjAGAhGiU3IY91FCJzjvRFhObJE8CVC9ntP6Dgn+
         ddP2C44CAhUgA7x1eazvVfi6BHukESWIGjI1Sx3gc+xhg+u/H05rIsEbYz21XisU4G
         iWk6UK7/QJwm3eQ8ReUmK4r/ZLjd8Yal9EZXmmM43RWHa+XXXv9DBWmhhVHXOB1Unz
         Y+joLroY65HPy7pV7BJ3JNnYop2oz55bnEQWeMCs97kH/kj9qd6ryGc2vRqYq8dYDY
         7iYZOE0Nc1AIA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_E60B1D31-2014-4BE8-B1A9-114D2F6A082A_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 19 Jun 2020, at 17:56, Ralph Campbell wrote:

> Support transparent huge page migration to ZONE_DEVICE private memory.
> A new flag (MIGRATE_PFN_COMPOUND) is added to the input PFN array to
> indicate the huge page was fully mapped by the CPU.
> Export prep_compound_page() so that device drivers can create huge
> device private pages after calling memremap_pages().
>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  include/linux/migrate.h |   1 +
>  include/linux/mm.h      |   1 +
>  mm/huge_memory.c        |  30 ++++--
>  mm/internal.h           |   1 -
>  mm/memory.c             |  10 +-
>  mm/memremap.c           |   9 +-
>  mm/migrate.c            | 226 ++++++++++++++++++++++++++++++++--------=

>  mm/page_alloc.c         |   1 +
>  8 files changed, 226 insertions(+), 53 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 3e546cbf03dd..f6a64965c8bd 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -166,6 +166,7 @@ static inline int migrate_misplaced_transhuge_page(=
struct mm_struct *mm,
>  #define MIGRATE_PFN_MIGRATE	(1UL << 1)
>  #define MIGRATE_PFN_LOCKED	(1UL << 2)
>  #define MIGRATE_PFN_WRITE	(1UL << 3)
> +#define MIGRATE_PFN_COMPOUND	(1UL << 4)
>  #define MIGRATE_PFN_SHIFT	6
>
>  static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index dc7b87310c10..020b9dd3cddb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -932,6 +932,7 @@ static inline unsigned int page_shift(struct page *=
page)
>  }
>
>  void free_compound_page(struct page *page);
> +void prep_compound_page(struct page *page, unsigned int order);
>
>  #ifdef CONFIG_MMU
>  /*
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 78c84bee7e29..25d95f7b1e98 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1663,23 +1663,35 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct=
 vm_area_struct *vma,
>  	} else {
>  		struct page *page =3D NULL;
>  		int flush_needed =3D 1;
> +		bool is_anon =3D false;
>
>  		if (pmd_present(orig_pmd)) {
>  			page =3D pmd_page(orig_pmd);
> +			is_anon =3D PageAnon(page);
>  			page_remove_rmap(page, true);
>  			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
>  			VM_BUG_ON_PAGE(!PageHead(page), page);
>  		} else if (thp_migration_supported()) {
>  			swp_entry_t entry;
>
> -			VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
>  			entry =3D pmd_to_swp_entry(orig_pmd);
> -			page =3D pfn_to_page(swp_offset(entry));
> +			if (is_device_private_entry(entry)) {
> +				page =3D device_private_entry_to_page(entry);
> +				is_anon =3D PageAnon(page);
> +				page_remove_rmap(page, true);
> +				VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
> +				VM_BUG_ON_PAGE(!PageHead(page), page);
> +				put_page(page);

Why do you hide this code behind thp_migration_supported()? It seems that=
 you just need
pmd swap entry not pmd migration entry. Also the condition is not consist=
ent with the code
in __handle_mm_fault(), in which you handle is_device_private_entry() dir=
ectly without
checking thp_migration_support().

Do we need to support split_huge_pmd() if a page is migrated to device? A=
ny new code
needed in split_huge_pmd()?



> +			} else {
> +				VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
> +				page =3D pfn_to_page(swp_offset(entry));
> +				is_anon =3D PageAnon(page);
> +			}
>  			flush_needed =3D 0;
>  		} else
>  			WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!")=
;
>
> -		if (PageAnon(page)) {
> +		if (is_anon) {
>  			zap_deposited_table(tlb->mm, pmd);
>  			add_mm_counter(tlb->mm, MM_ANONPAGES, -HPAGE_PMD_NR);
>  		} else {
> @@ -1778,8 +1790,8 @@ bool move_huge_pmd(struct vm_area_struct *vma, un=
signed long old_addr,
>  /*
>   * Returns
>   *  - 0 if PMD could not be locked
> - *  - 1 if PMD was locked but protections unchange and TLB flush unnec=
essary
> - *  - HPAGE_PMD_NR is protections changed and TLB flush necessary
> + *  - 1 if PMD was locked but protections unchanged and TLB flush unne=
cessary
> + *  - HPAGE_PMD_NR if protections changed and TLB flush necessary
>   */
>  int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  		unsigned long addr, pgprot_t newprot, unsigned long cp_flags)
> @@ -2689,7 +2701,7 @@ int split_huge_page_to_list(struct page *page, st=
ruct list_head *list)
>  	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
>  		if (!list_empty(page_deferred_list(head))) {
>  			ds_queue->split_queue_len--;
> -			list_del(page_deferred_list(head));
> +			list_del_init(page_deferred_list(head));
>  		}
>  		spin_unlock(&ds_queue->split_queue_lock);
>  		if (mapping) {
> @@ -2743,7 +2755,7 @@ void free_transhuge_page(struct page *page)
>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	if (!list_empty(page_deferred_list(page))) {
>  		ds_queue->split_queue_len--;
> -		list_del(page_deferred_list(page));
> +		list_del_init(page_deferred_list(page));
>  	}
>  	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>  	free_compound_page(page);
> @@ -2963,6 +2975,10 @@ void remove_migration_pmd(struct page_vma_mapped=
_walk *pvmw, struct page *new)
>  		pmde =3D pmd_mksoft_dirty(pmde);
>  	if (is_write_migration_entry(entry))
>  		pmde =3D maybe_pmd_mkwrite(pmde, vma);
> +	if (unlikely(is_device_private_page(new))) {
> +		entry =3D make_device_private_entry(new, pmd_write(pmde));
> +		pmde =3D swp_entry_to_pmd(entry);
> +	}
>
>  	flush_cache_range(vma, mmun_start, mmun_start + HPAGE_PMD_SIZE);
>  	if (PageAnon(new))
> diff --git a/mm/internal.h b/mm/internal.h
> index 9886db20d94f..58f051a14dae 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -196,7 +196,6 @@ extern void __putback_isolated_page(struct page *pa=
ge, unsigned int order,
>  extern void memblock_free_pages(struct page *page, unsigned long pfn,
>  					unsigned int order);
>  extern void __free_pages_core(struct page *page, unsigned int order);
> -extern void prep_compound_page(struct page *page, unsigned int order);=

>  extern void post_alloc_hook(struct page *page, unsigned int order,
>  					gfp_t gfp_flags);
>  extern int user_min_free_kbytes;
> diff --git a/mm/memory.c b/mm/memory.c
> index dc7f3543b1fd..4e03d1a2ead5 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4322,9 +4322,15 @@ static vm_fault_t __handle_mm_fault(struct vm_ar=
ea_struct *vma,
>
>  		barrier();
>  		if (unlikely(is_swap_pmd(orig_pmd))) {
> +			swp_entry_t entry =3D pmd_to_swp_entry(orig_pmd);
> +
> +			if (is_device_private_entry(entry)) {
> +				vmf.page =3D device_private_entry_to_page(entry);
> +				return vmf.page->pgmap->ops->migrate_to_ram(&vmf);
> +			}
>  			VM_BUG_ON(thp_migration_supported() &&
> -					  !is_pmd_migration_entry(orig_pmd));
> -			if (is_pmd_migration_entry(orig_pmd))
> +					  !is_migration_entry(entry));
> +			if (is_migration_entry(entry))
>  				pmd_migration_entry_wait(mm, vmf.pmd);
>  			return 0;
>  		}
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 03e38b7a38f1..4231054188b4 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -132,8 +132,13 @@ void memunmap_pages(struct dev_pagemap *pgmap)
>  	int nid;
>
>  	dev_pagemap_kill(pgmap);
> -	for_each_device_pfn(pfn, pgmap)
> -		put_page(pfn_to_page(pfn));
> +	for_each_device_pfn(pfn, pgmap) {
> +		struct page *page =3D pfn_to_page(pfn);
> +		unsigned int order =3D compound_order(page);
> +
> +		put_page(page);
> +		pfn +=3D (1U << order) - 1;
> +	}
>  	dev_pagemap_cleanup(pgmap);
>
>  	/* make sure to access a memmap that was actually initialized */
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 87c52e0ee580..1536677cefc9 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -51,6 +51,7 @@
>  #include <linux/oom.h>
>
>  #include <asm/tlbflush.h>
> +#include <asm/pgalloc.h>
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/migrate.h>
> @@ -2185,6 +2186,8 @@ static int migrate_vma_collect_hole(unsigned long=
 start,
>
>  	for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
>  		migrate->src[migrate->npages] =3D flags;
> +		if ((addr & ~PMD_MASK) =3D=3D 0 && (end & ~PMD_MASK) =3D=3D 0)
> +			migrate->src[migrate->npages] |=3D MIGRATE_PFN_COMPOUND;
>  		migrate->dst[migrate->npages] =3D 0;
>  		migrate->npages++;
>  		migrate->cpages++;
> @@ -2219,48 +2222,87 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,=

>  	unsigned long addr =3D start, unmapped =3D 0;
>  	spinlock_t *ptl;
>  	pte_t *ptep;
> +	pmd_t pmd;
>
>  again:
> -	if (pmd_none(*pmdp))
> +	pmd =3D READ_ONCE(*pmdp);
> +	if (pmd_none(pmd))
>  		return migrate_vma_collect_hole(start, end, -1, walk);
>
> -	if (pmd_trans_huge(*pmdp)) {
> +	if (pmd_trans_huge(pmd) || !pmd_present(pmd)) {
>  		struct page *page;
> +		unsigned long write =3D 0;
> +		int ret;
>
>  		ptl =3D pmd_lock(mm, pmdp);
> -		if (unlikely(!pmd_trans_huge(*pmdp))) {
> -			spin_unlock(ptl);
> -			goto again;
> -		}
> +		if (pmd_trans_huge(*pmdp)) {
> +			page =3D pmd_page(*pmdp);
> +			if (is_huge_zero_page(page)) {
> +				spin_unlock(ptl);
> +				return migrate_vma_collect_hole(start, end, -1,
> +								walk);
> +			}
> +			if (pmd_write(*pmdp))
> +				write =3D MIGRATE_PFN_WRITE;
> +		} else if (!pmd_present(*pmdp)) {
> +			swp_entry_t entry =3D pmd_to_swp_entry(*pmdp);
>
> -		page =3D pmd_page(*pmdp);
> -		if (is_huge_zero_page(page)) {
> -			spin_unlock(ptl);
> -			split_huge_pmd(vma, pmdp, addr);
> -			if (pmd_trans_unstable(pmdp))
> +			if (!is_device_private_entry(entry)) {
> +				spin_unlock(ptl);
>  				return migrate_vma_collect_skip(start, end,
>  								walk);
> +			}
> +			page =3D device_private_entry_to_page(entry);
> +			if (is_write_device_private_entry(entry))
> +				write =3D MIGRATE_PFN_WRITE;
>  		} else {
> -			int ret;
> +			spin_unlock(ptl);
> +			goto again;
> +		}
>
> -			get_page(page);
> +		get_page(page);
> +		if (unlikely(!trylock_page(page))) {
>  			spin_unlock(ptl);
> -			if (unlikely(!trylock_page(page)))
> -				return migrate_vma_collect_skip(start, end,
> -								walk);
> -			ret =3D split_huge_page(page);
> -			unlock_page(page);
>  			put_page(page);
> -			if (ret)
> -				return migrate_vma_collect_skip(start, end,
> -								walk);
> -			if (pmd_none(*pmdp))
> -				return migrate_vma_collect_hole(start, end, -1,
> -								walk);
> +			return migrate_vma_collect_skip(start, end, walk);
> +		}
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +		if ((start & HPAGE_PMD_MASK) =3D=3D start &&
> +		    start + HPAGE_PMD_SIZE =3D=3D end) {
> +			struct page_vma_mapped_walk vmw =3D {
> +				.vma =3D vma,
> +				.address =3D start,
> +				.pmd =3D pmdp,
> +				.ptl =3D ptl,
> +			};
> +
> +			migrate->src[migrate->npages] =3D write |
> +				migrate_pfn(page_to_pfn(page)) |
> +				MIGRATE_PFN_MIGRATE | MIGRATE_PFN_LOCKED |
> +				MIGRATE_PFN_COMPOUND;
> +			migrate->dst[migrate->npages] =3D 0;
> +			migrate->npages++;
> +			migrate->cpages++;
> +			migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
> +
> +			/* Note that this also removes the page from the rmap. */
> +			set_pmd_migration_entry(&vmw, page);
> +			spin_unlock(ptl);
> +
> +			return 0;
>  		}
> +#endif
> +		spin_unlock(ptl);
> +		ret =3D split_huge_page(page);
> +		unlock_page(page);
> +		put_page(page);
> +		if (ret)
> +			return migrate_vma_collect_skip(start, end, walk);
> +		if (pmd_none(*pmdp))
> +			return migrate_vma_collect_hole(start, end, -1, walk);
>  	}
>
> -	if (unlikely(pmd_bad(*pmdp)))
> +	if (unlikely(pmd_bad(pmd) || pmd_devmap(pmd)))
>  		return migrate_vma_collect_skip(start, end, walk);
>
>  	ptep =3D pte_offset_map_lock(mm, pmdp, addr, &ptl);
> @@ -2310,8 +2352,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			mpfn |=3D pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
>  		}
>
> -		/* FIXME support THP */
> -		if (!page || !page->mapping || PageTransCompound(page)) {
> +		if (!page || !page->mapping) {
>  			mpfn =3D 0;
>  			goto next;
>  		}
> @@ -2420,14 +2461,6 @@ static bool migrate_vma_check_page(struct page *=
page)
>  	 */
>  	int extra =3D 1;
>
> -	/*
> -	 * FIXME support THP (transparent huge page), it is bit more complex =
to
> -	 * check them than regular pages, because they can be mapped with a p=
md
> -	 * or with a pte (split pte mapping).
> -	 */
> -	if (PageCompound(page))
> -		return false;
> -
>  	/* Page from ZONE_DEVICE have one extra reference */
>  	if (is_zone_device_page(page)) {
>  		/*
> @@ -2726,13 +2759,115 @@ int migrate_vma_setup(struct migrate_vma *args=
)
>  }
>  EXPORT_SYMBOL(migrate_vma_setup);
>
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +/*
> + * This code closely follows:
> + * do_huge_pmd_anonymous_page()
> + *   __do_huge_pmd_anonymous_page()
> + * except that the page being inserted is likely to be a device privat=
e page
> + * instead of an allocated or zero page.
> + */
> +static int insert_huge_pmd_anonymous_page(struct vm_area_struct *vma,
> +					  unsigned long haddr,
> +					  struct page *page,
> +					  unsigned long *src,
> +					  unsigned long *dst,
> +					  pmd_t *pmdp)
> +{
> +	struct mm_struct *mm =3D vma->vm_mm;
> +	unsigned int i;
> +	spinlock_t *ptl;
> +	bool flush =3D false;
> +	pgtable_t pgtable;
> +	gfp_t gfp;
> +	pmd_t entry;
> +
> +	if (WARN_ON_ONCE(compound_order(page) !=3D HPAGE_PMD_ORDER))
> +		goto abort;
> +
> +	if (unlikely(anon_vma_prepare(vma)))
> +		goto abort;
> +
> +	prep_transhuge_page(page);
> +
> +	gfp =3D GFP_TRANSHUGE_LIGHT;
> +	if (mem_cgroup_charge(page, mm, gfp))
> +		goto abort;
> +
> +	pgtable =3D pte_alloc_one(mm);
> +	if (unlikely(!pgtable))
> +		goto abort;
> +
> +	__SetPageUptodate(page);
> +
> +	if (is_zone_device_page(page)) {
> +		if (!is_device_private_page(page))
> +			goto pgtable_abort;
> +		entry =3D swp_entry_to_pmd(make_device_private_entry(page,
> +						vma->vm_flags & VM_WRITE));
> +	} else {
> +		entry =3D mk_huge_pmd(page, vma->vm_page_prot);
> +		entry =3D maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
> +	}
> +
> +	ptl =3D pmd_lock(mm, pmdp);
> +
> +	if (check_stable_address_space(mm))
> +		goto unlock_abort;
> +
> +	/*
> +	 * Check for userfaultfd but do not deliver the fault. Instead,
> +	 * just back off.
> +	 */
> +	if (userfaultfd_missing(vma))
> +		goto unlock_abort;
> +
> +	if (pmd_present(*pmdp)) {
> +		if (!is_huge_zero_pmd(*pmdp))
> +			goto unlock_abort;
> +		flush =3D true;
> +	} else if (!pmd_none(*pmdp))
> +		goto unlock_abort;
> +
> +	get_page(page);
> +	page_add_new_anon_rmap(page, vma, haddr, true);
> +	if (!is_device_private_page(page))
> +		lru_cache_add_active_or_unevictable(page, vma);
> +	if (flush) {
> +		pte_free(mm, pgtable);
> +		flush_cache_range(vma, haddr, haddr + HPAGE_PMD_SIZE);
> +		pmdp_invalidate(vma, haddr, pmdp);
> +	} else {
> +		pgtable_trans_huge_deposit(mm, pmdp, pgtable);
> +		mm_inc_nr_ptes(mm);
> +	}
> +	set_pmd_at(mm, haddr, pmdp, entry);
> +	update_mmu_cache_pmd(vma, haddr, pmdp);
> +	add_mm_counter(mm, MM_ANONPAGES, HPAGE_PMD_NR);
> +	spin_unlock(ptl);
> +	count_vm_event(THP_FAULT_ALLOC);
> +	count_memcg_event_mm(mm, THP_FAULT_ALLOC);
> +
> +	return 0;
> +
> +unlock_abort:
> +	spin_unlock(ptl);
> +pgtable_abort:
> +	pte_free(mm, pgtable);
> +abort:
> +	for (i =3D 0; i < HPAGE_PMD_NR; i++)
> +		src[i] &=3D ~MIGRATE_PFN_MIGRATE;
> +	return -EINVAL;
> +}
> +#endif
> +
>  /*
>   * This code closely matches the code in:
>   *   __handle_mm_fault()
>   *     handle_pte_fault()
>   *       do_anonymous_page()
> - * to map in an anonymous zero page but the struct page will be a ZONE=
_DEVICE
> - * private page.
> + * to map in an anonymous zero page except the struct page is already =
allocated
> + * and will likely be a ZONE_DEVICE private page.
>   */
>  static void migrate_vma_insert_page(struct migrate_vma *migrate,
>  				    unsigned long addr,
> @@ -2766,7 +2901,16 @@ static void migrate_vma_insert_page(struct migra=
te_vma *migrate,
>  	if (!pmdp)
>  		goto abort;
>
> -	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp))
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +	if (*dst & MIGRATE_PFN_COMPOUND) {
> +		int ret =3D insert_huge_pmd_anonymous_page(vma, addr, page, src,
> +							 dst, pmdp);
> +		if (ret)
> +			goto abort;
> +		return;
> +	}
> +#endif
> +	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp) || pmd_bad(*pmdp))
>  		goto abort;
>
>  	/*
> @@ -2804,7 +2948,8 @@ static void migrate_vma_insert_page(struct migrat=
e_vma *migrate,
>
>  			swp_entry =3D make_device_private_entry(page, vma->vm_flags & VM_WR=
ITE);
>  			entry =3D swp_entry_to_pte(swp_entry);
> -		}
> +		} else
> +			goto abort;
>  	} else {
>  		entry =3D mk_pte(page, vma->vm_page_prot);
>  		if (vma->vm_flags & VM_WRITE)
> @@ -2833,10 +2978,10 @@ static void migrate_vma_insert_page(struct migr=
ate_vma *migrate,
>  		goto unlock_abort;
>
>  	inc_mm_counter(mm, MM_ANONPAGES);
> +	get_page(page);
>  	page_add_new_anon_rmap(page, vma, addr, false);
>  	if (!is_zone_device_page(page))
>  		lru_cache_add_active_or_unevictable(page, vma);
> -	get_page(page);
>
>  	if (flush) {
>  		flush_cache_page(vma, addr, pte_pfn(*ptep));
> @@ -2850,7 +2995,6 @@ static void migrate_vma_insert_page(struct migrat=
e_vma *migrate,
>  	}
>
>  	pte_unmap_unlock(ptep, ptl);
> -	*src =3D MIGRATE_PFN_MIGRATE;
>  	return;
>
>  unlock_abort:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 48eb0f1410d4..a852ed2f204c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -686,6 +686,7 @@ void prep_compound_page(struct page *page, unsigned=
 int order)
>  	if (hpage_pincount_available(page))
>  		atomic_set(compound_pincount_ptr(page), 0);
>  }
> +EXPORT_SYMBOL_GPL(prep_compound_page);
>
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  unsigned int _debug_guardpage_minorder;
> -- =

> 2.20.1


--
Best Regards,
Yan Zi

--=_MailMate_E60B1D31-2014-4BE8-B1A9-114D2F6A082A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBAgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl7v61kPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK178QAK3/TuzpnC18wSRNKROfJvwUG56jirCskGBm
MRD7CPZnNnBdfGg1faaddLLnHpl26d1Vgvjn+xiNV9pbeKDewOcqwF/sfKwSiXCd
Z7Z6So6fBKQUJVwwJ1LoO5DPHBiqs8cfIF9K3mtBskON0Ed+97N6tcSICWciX2eY
yqznsXtp7C6uGaaym1eq9yrnP7dvHMSbJkNL2r7Sz7iTdkTgLadgOqkRQ4h1Tvw7
Vl1BeEGvk2wbuT4XTG8j//2po786mFuJ4WCtm+K9VLfTSzFPafHTpcSan92cNkdE
Rn6/SNQajDn8fsvhP0/3cliEApSpMoVBK3R1tA90X9a7yWYwNx3NZFY5Qbwzpqnh
sWH5y5bFgUDWWfHdcm65X+JKWi+YQ+GxwBi42uYvbC4yQbGqBcarCtwhsr7g2KdO
XR7Z7ryyXAbmPirN2P+J2nCSxXUPEiMhwayHw7wwN//+n+qwgcCAvqGqBCL1d15w
hxnOINYkXJRw8KNQ6Fm2DW9tYb60XP7RAoLkFsYO+660l3RPmLS0sD8gokiWN1Be
lMkb+KLUEes1FMSeLy/TAQCmhCH2nh27a25LQpFY/NXSzPi28caTFa/JY2JD+3Mp
aWWq/pU7hyHltFpIc24bDgGzhQV00S2zU2BIHOa+BOeMPvbP7/7hPx2LAEA6k4si
PSNTKEHs
=Osz7
-----END PGP SIGNATURE-----

--=_MailMate_E60B1D31-2014-4BE8-B1A9-114D2F6A082A_=--
