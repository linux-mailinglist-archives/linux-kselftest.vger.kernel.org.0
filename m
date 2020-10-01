Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F228827FF4C
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 14:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbgJAMh3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Oct 2020 08:37:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:41838 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731888AbgJAMhD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Oct 2020 08:37:03 -0400
IronPort-SDR: 2L4krIeGB3ZHiPgq4h34mqZRPRlzKkGLlegbuECLAHfKTrw3vW5DBqV31M7C6bO00bHYvLQxPl
 GvAuxUWwXIpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="162787553"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="162787553"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 05:37:02 -0700
IronPort-SDR: r6/xZHaIjdd2ngKSwqFRcGl5UAH2GkwYEJbWKAdZ1Gz6ciEvoGuwnw4xxxzharOfXRCUJjcjfn
 ZIHNJmXDbcxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="385509890"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 01 Oct 2020 05:36:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E3A1B327; Thu,  1 Oct 2020 15:36:51 +0300 (EEST)
Date:   Thu, 1 Oct 2020 15:36:51 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@google.com, joelaf@google.com,
        lokeshgidra@google.com, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jia He <justin.he@arm.com>, Zhenyu Ye <yezhenyu2@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ram Pai <linuxram@us.ibm.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Brian Geffon <bgeffon@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: Speedup mremap on 1GB or larger regions
Message-ID: <20201001123651.arcr5gqtia2myt22@black.fi.intel.com>
References: <20200930222130.4175584-1-kaleshsingh@google.com>
 <20200930222130.4175584-4-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200930222130.4175584-4-kaleshsingh@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 30, 2020 at 10:21:20PM +0000, Kalesh Singh wrote:
> Android needs to move large memory regions for garbage collection.
> Optimize mremap for >= 1GB-sized regions by moving at the PUD/PGD
> level if the source and destination addresses are PUD-aligned.
> For CONFIG_PGTABLE_LEVELS == 3, moving at the PUD level in effect moves
> PGD entries, since the PUD entry is “folded back” onto the PGD entry.
> Add HAVE_MOVE_PUD so that architectures where moving at the PUD level
> isn't supported/tested can turn this off by not selecting the config.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  arch/Kconfig                     |   7 +
>  arch/arm64/include/asm/pgtable.h |   1 +
>  mm/mremap.c                      | 211 ++++++++++++++++++++++++++-----
>  3 files changed, 189 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index af14a567b493..5eabaa00bf9b 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -602,6 +602,13 @@ config HAVE_IRQ_TIME_ACCOUNTING
>  	  Archs need to ensure they use a high enough resolution clock to
>  	  support irq time accounting and then call enable_sched_clock_irqtime().
>  
> +config HAVE_MOVE_PUD
> +	bool
> +	help
> +	  Architectures that select this are able to move page tables at the
> +	  PUD level. If there are only 3 page table levels, the move effectively
> +	  happens at the PGD level.
> +
>  config HAVE_MOVE_PMD
>  	bool
>  	help
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index d5d3fbe73953..8848125e3024 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -415,6 +415,7 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
>  #define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
>  
>  #define set_pmd_at(mm, addr, pmdp, pmd)	set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd))
> +#define set_pud_at(mm, addr, pudp, pud)	set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud))
>  
>  #define __p4d_to_phys(p4d)	__pte_to_phys(p4d_pte(p4d))
>  #define __phys_to_p4d_val(phys)	__phys_to_pte_val(phys)

This doesn't belong to the patch.

> diff --git a/mm/mremap.c b/mm/mremap.c
> index 138abbae4f75..a5a1440bd366 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -249,14 +249,167 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>  
>  	return true;
>  }
> +#else
> +static inline bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> +		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
> +{
> +	return false;
> +}
>  #endif
>  
> +#ifdef CONFIG_HAVE_MOVE_PUD
> +static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
> +{
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +
> +	pgd = pgd_offset(mm, addr);
> +	if (pgd_none_or_clear_bad(pgd))
> +		return NULL;
> +
> +	p4d = p4d_offset(pgd, addr);
> +	if (p4d_none_or_clear_bad(p4d))
> +		return NULL;
> +
> +	pud = pud_offset(p4d, addr);
> +	if (pud_none_or_clear_bad(pud))
> +		return NULL;
> +
> +	return pud;
> +}
> +
> +static pud_t *alloc_new_pud(struct mm_struct *mm, struct vm_area_struct *vma,
> +			    unsigned long addr)
> +{
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +
> +	pgd = pgd_offset(mm, addr);
> +	p4d = p4d_alloc(mm, pgd, addr);
> +	if (!p4d)
> +		return NULL;
> +	pud = pud_alloc(mm, p4d, addr);
> +	if (!pud)
> +		return NULL;
> +
> +	return pud;
> +}
> +
> +static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
> +		  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
> +{
> +	spinlock_t *old_ptl, *new_ptl;
> +	struct mm_struct *mm = vma->vm_mm;
> +	pud_t pud;
> +
> +	/*
> +	 * The destination pud shouldn't be established, free_pgtables()
> +	 * should have released it.
> +	 */
> +	if (WARN_ON_ONCE(!pud_none(*new_pud)))
> +		return false;
> +
> +	/*
> +	 * We don't have to worry about the ordering of src and dst
> +	 * ptlocks because exclusive mmap_lock prevents deadlock.
> +	 */
> +	old_ptl = pud_lock(vma->vm_mm, old_pud);
> +	new_ptl = pud_lockptr(mm, new_pud);
> +	if (new_ptl != old_ptl)
> +		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> +
> +	/* Clear the pud */
> +	pud = *old_pud;
> +	pud_clear(old_pud);
> +
> +	VM_BUG_ON(!pud_none(*new_pud));
> +
> +	/* Set the new pud */
> +	set_pud_at(mm, new_addr, new_pud, pud);
> +	flush_tlb_range(vma, old_addr, old_addr + PUD_SIZE);
> +	if (new_ptl != old_ptl)
> +		spin_unlock(new_ptl);
> +	spin_unlock(old_ptl);
> +
> +	return true;
> +}
> +#else
> +static inline bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
> +		  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
> +{
> +	return false;
> +}
> +#endif
> +
> +enum pgt_entry {
> +	NORMAL_PMD,
> +	HPAGE_PMD,
> +	NORMAL_PUD,
> +};
> +
> +/*
> + * Returns an extent of the corresponding size for the pgt_entry specified if valid.
> + * Else returns a smaller extent bounded by the end of the source and destination
> + * pgt_entry. Returns 0 if an invalid pgt_entry is specified.
> + */
> +static unsigned long get_extent(enum pgt_entry entry, unsigned long old_addr,
> +			unsigned long old_end, unsigned long new_addr)
> +{
> +	unsigned long next, extent, mask, size;
> +
> +	if (entry == NORMAL_PMD || entry == HPAGE_PMD) {
> +		mask = PMD_MASK;
> +		size = PMD_SIZE;
> +	} else if (entry == NORMAL_PUD) {
> +		mask = PUD_MASK;
> +		size = PUD_SIZE;
> +	} else
> +		return 0;
> +
> +	next = (old_addr + size) & mask;
> +	/* even if next overflowed, extent below will be ok */
> +	extent = (next > old_end) ? old_end - old_addr : next - old_addr;
> +	next = (new_addr + size) & mask;
> +	if (extent > next - new_addr)
> +		extent = next - new_addr;
> +	return extent;
> +}
> +
> +/*
> + * Attempts to speedup the move by moving entry at the level corresponding to
> + * pgt_entry. Returns true if the move was successful, else false.
> + */
> +static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
> +			unsigned long old_addr, unsigned long new_addr, void *old_entry,
> +			void *new_entry, bool need_rmap_locks)
> +{
> +	bool moved = false;
> +
> +	/* See comment in move_ptes() */
> +	if (need_rmap_locks)
> +		take_rmap_locks(vma);
> +	if (entry == NORMAL_PMD)
> +		moved =  move_normal_pmd(vma, old_addr, new_addr, old_entry, new_entry);
> +	else if (entry == NORMAL_PUD)
> +		moved =  move_normal_pud(vma, old_addr, new_addr, old_entry, new_entry);
> +	else if (entry == HPAGE_PMD)
> +		moved =  move_huge_pmd(vma, old_addr, new_addr, old_entry, new_entry);
> +	else
> +		WARN_ON_ONCE(1);

BUILD_BUG() should work.

And why not use switch() instead of ifs.

> +	if (need_rmap_locks)
> +		drop_rmap_locks(vma);
> +
> +	return moved;
> +}
> +
>  unsigned long move_page_tables(struct vm_area_struct *vma,
>  		unsigned long old_addr, struct vm_area_struct *new_vma,
>  		unsigned long new_addr, unsigned long len,
>  		bool need_rmap_locks)
>  {
> -	unsigned long extent, next, old_end;
> +	unsigned long extent, old_end;
>  	struct mmu_notifier_range range;
>  	pmd_t *old_pmd, *new_pmd;
>  
> @@ -269,14 +422,27 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  
>  	for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
>  		cond_resched();
> -		next = (old_addr + PMD_SIZE) & PMD_MASK;
> -		/* even if next overflowed, extent below will be ok */
> -		extent = next - old_addr;
> -		if (extent > old_end - old_addr)
> -			extent = old_end - old_addr;
> -		next = (new_addr + PMD_SIZE) & PMD_MASK;
> -		if (extent > next - new_addr)
> -			extent = next - new_addr;
> +#ifdef CONFIG_HAVE_MOVE_PUD
> +		/*
> +		 * If extent is PUD-sized try to speed up the move by moving at the
> +		 * PUD level if possible.
> +		 */
> +		extent = get_extent(NORMAL_PUD, old_addr, old_end, new_addr);
> +		if (extent == PUD_SIZE) {
> +			pud_t *old_pud, *new_pud;
> +
> +			old_pud = get_old_pud(vma->vm_mm, old_addr);
> +			if (!old_pud)
> +				continue;
> +			new_pud = alloc_new_pud(vma->vm_mm, vma, new_addr);
> +			if (!new_pud)
> +				break;
> +			if (move_pgt_entry(NORMAL_PUD, vma, old_addr, new_addr,
> +					   old_pud, new_pud, need_rmap_locks))
> +				continue;
> +		}
> +#endif
> +		extent = get_extent(NORMAL_PMD, old_addr, old_end, new_addr);
>  		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
>  		if (!old_pmd)
>  			continue;
> @@ -284,18 +450,10 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  		if (!new_pmd)
>  			break;
>  		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) || pmd_devmap(*old_pmd)) {
> -			if (extent == HPAGE_PMD_SIZE) {
> -				bool moved;
> -				/* See comment in move_ptes() */
> -				if (need_rmap_locks)
> -					take_rmap_locks(vma);
> -				moved = move_huge_pmd(vma, old_addr, new_addr,
> -						      old_pmd, new_pmd);
> -				if (need_rmap_locks)
> -					drop_rmap_locks(vma);
> -				if (moved)
> -					continue;
> -			}
> +			if (extent == HPAGE_PMD_SIZE &&
> +			    move_pgt_entry(HPAGE_PMD, vma, old_addr, new_addr, old_pmd,
> +					   new_pmd, need_rmap_locks))
> +				continue;
>  			split_huge_pmd(vma, old_pmd, old_addr);
>  			if (pmd_trans_unstable(old_pmd))
>  				continue;
> @@ -305,15 +463,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  			 * If the extent is PMD-sized, try to speed the move by
>  			 * moving at the PMD level if possible.
>  			 */
> -			bool moved;
> -
> -			if (need_rmap_locks)
> -				take_rmap_locks(vma);
> -			moved = move_normal_pmd(vma, old_addr, new_addr,
> -						old_pmd, new_pmd);
> -			if (need_rmap_locks)
> -				drop_rmap_locks(vma);
> -			if (moved)
> +			if (move_pgt_entry(NORMAL_PMD, vma, old_addr, new_addr, old_pmd,
> +					   new_pmd, need_rmap_locks))
>  				continue;
>  #endif
>  		}
> -- 
> 2.28.0.709.gb0816b6eb0-goog
> 

-- 
 Kirill A. Shutemov
