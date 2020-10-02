Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2633E281851
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 18:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgJBQve (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 12:51:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:57183 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBQve (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 12:51:34 -0400
IronPort-SDR: uXWUPTeplvAhL9fO2SlZHGFTV5CkMlIEtf4mnwuuNbyP3+zTwR15JWfS0eXL3fHtSMKzRkZzDg
 4U5lMZdmHHEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="224639590"
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="224639590"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 09:51:33 -0700
IronPort-SDR: yvtbQGiK/PZqLm5hqom03yovdzgn5+wCDJC2WQEmgg1UirLhpGLEjadaxnAQ8I4DvK+i6u4daH
 UJEh24J9Otrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="325867819"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 02 Oct 2020 09:51:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id CBBF5CB; Fri,  2 Oct 2020 19:51:22 +0300 (EEST)
Date:   Fri, 2 Oct 2020 19:51:22 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@google.com, joelaf@google.com,
        lokeshgidra@google.com, kernel-team@android.com,
        kernel test robot <lkp@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jia He <justin.he@arm.com>, Zhenyu Ye <yezhenyu2@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        Brian Geffon <bgeffon@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/6] mm: Speedup mremap on 1GB or larger regions
Message-ID: <20201002165122.bm427a4ealmmmtqc@black.fi.intel.com>
References: <20201002162101.665549-1-kaleshsingh@google.com>
 <20201002162101.665549-4-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201002162101.665549-4-kaleshsingh@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 02, 2020 at 04:20:48PM +0000, Kalesh Singh wrote:
> Android needs to move large memory regions for garbage collection.
> The GC requires moving physical pages of multi-gigabyte heap
> using mremap. During this move, the application threads have to
> be paused for correctness. It is critical to keep this pause as
> short as possible to avoid jitters during user interaction.
> 
> Optimize mremap for >= 1GB-sized regions by moving at the PUD/PGD
> level if the source and destination addresses are PUD-aligned.
> For CONFIG_PGTABLE_LEVELS == 3, moving at the PUD level in effect moves
> PGD entries, since the PUD entry is “folded back” onto the PGD entry.
> Add HAVE_MOVE_PUD so that architectures where moving at the PUD level
> isn't supported/tested can turn this off by not selecting the config.
> 
> Fix build test error from v1 of this series reported by
> kernel test robot in [1].
> 
> [1] https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/CKPGL4FH4NG7TGH2CVYX2UX76L25BTA3/
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> Changes in v2:
>   - Update commit message with description of Android GC's use case.
>   - Move set_pud_at() to a separate patch.
>   - Use switch() instead of ifs in move_pgt_entry()
>   - Fix build test error reported by kernel test robot on x86_64 in [1].
>     Guard move_huge_pmd() with IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE),
>     since this section doesn't get optimized out in the kernel test
>     robot's build test when HAVE_MOVE_PUD is enabled.
>   - Keep WARN_ON_ONCE(1) instead of BUILD_BUG() for the aforementioned
>     reason.

Okay, but IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) on the caller side would
do the trick, I believe.

> 
>  arch/Kconfig |   7 ++
>  mm/mremap.c  | 220 ++++++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 197 insertions(+), 30 deletions(-)
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
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 138abbae4f75..c1d6ab667d70 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -249,14 +249,176 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
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

Looks like a code duplication.

Could you move these two helpers out of #ifdef CONFIG_HAVE_MOVE_PUD and
make get_old_pmd() and alloc_new_pmd() use them?

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

Em. Who would ever specify invalid pgt_entry? It's bug.
Again, switch()?

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
> +
> +	switch (entry) {
> +	case NORMAL_PMD:
> +		moved =  move_normal_pmd(vma, old_addr, new_addr, old_entry, new_entry);

Nit: here and below, double space after '='. Why?

> +		break;
> +	case NORMAL_PUD:
> +		moved =  move_normal_pud(vma, old_addr, new_addr, old_entry, new_entry);
> +		break;
> +	case HPAGE_PMD:
> +		moved =  IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> +			move_huge_pmd(vma, old_addr, new_addr, old_entry, new_entry);
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		break;
> +	}
> +
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
> @@ -269,14 +431,27 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
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

Any chance  if (IS_ENABLED(CONFIG_HAVE_MOVE_PUD)) would work here?

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
> @@ -284,18 +459,10 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
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
> @@ -305,15 +472,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
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
> 2.28.0.806.g8561365e88-goog
> 

-- 
 Kirill A. Shutemov
