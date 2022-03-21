Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D2C4E330B
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 23:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiCUWrG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 18:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiCUWqy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 18:46:54 -0400
X-Greylist: delayed 12509 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Mar 2022 15:25:49 PDT
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4A73997D2;
        Mon, 21 Mar 2022 15:25:49 -0700 (PDT)
Date:   Mon, 21 Mar 2022 15:18:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1647901086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kU2x6mfxHzd6oubiXMPH3ZgCSjbnudyOXlm9XSlrpLM=;
        b=q9fAZ1jelJXKmSIUHYreNIYyOIgRUWEHYCOoJks6gKZ/rK6ys/DA1Z3pIsq0JybH2/qWEl
        Hd+fLeYrj5aD28WaSFkNAKcb/IY1B/KhjN+wK+uOy5DpsJIDyKXyxzX2qmnF92mvp1dUs/
        5LSgYePfnBr066kks/l/Oimb4uVMhy8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] mm: thp: split huge page to any lower order
 pages.
Message-ID: <Yjj5mADYABiZSxGB@carbon.dhcp.thefacebook.com>
References: <20220321142128.2471199-1-zi.yan@sent.com>
 <20220321142128.2471199-4-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321142128.2471199-4-zi.yan@sent.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 21, 2022 at 10:21:26AM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> To split a THP to any lower order pages, we need to reform THPs on
> subpages at given order and add page refcount based on the new page
> order. Also we need to reinitialize page_deferred_list after removing
> the page from the split_queue, otherwise a subsequent split will see
> list corruption when checking the page_deferred_list again.
> 
> It has many uses, like minimizing the number of pages after
> truncating a pagecache THP. For anonymous THPs, we can only split them
> to order-0 like before until we add support for any size anonymous THPs.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Overall the patch looks good to me, please, feel free to add
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
to the next version.

Couple of small nits below:

> ---
>  include/linux/huge_mm.h |   8 +++
>  mm/huge_memory.c        | 111 ++++++++++++++++++++++++++++++----------
>  2 files changed, 91 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2999190adc22..c7153cd7e9e4 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -186,6 +186,8 @@ void free_transhuge_page(struct page *page);
>  
>  bool can_split_folio(struct folio *folio, int *pextra_pins);
>  int split_huge_page_to_list(struct page *page, struct list_head *list);
> +int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> +		unsigned int new_order);

Do we really need both? Maybe add the new_order argument to the existing function?
It seems like there are not so many call sites.

>  static inline int split_huge_page(struct page *page)
>  {
>  	return split_huge_page_to_list(page, NULL);
> @@ -355,6 +357,12 @@ split_huge_page_to_list(struct page *page, struct list_head *list)
>  {
>  	return 0;
>  }
> +static inline int
> +split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> +		unsigned int new_order)
> +{
> +	return 0;
> +}
>  static inline int split_huge_page(struct page *page)
>  {
>  	return 0;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index fcfa46af6c4c..3617aa3ad0b1 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2236,11 +2236,13 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
>  static void unmap_page(struct page *page)
>  {
>  	struct folio *folio = page_folio(page);
> -	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
> -		TTU_SYNC;
> +	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SYNC;
>  
>  	VM_BUG_ON_PAGE(!PageHead(page), page);
>  
> +	if (folio_order(folio) >= HPAGE_PMD_ORDER)
> +		ttu_flags |= TTU_SPLIT_HUGE_PMD;
> +
>  	/*
>  	 * Anon pages need migration entries to preserve them, but file
>  	 * pages can simply be left unmapped, then faulted back on demand.
> @@ -2254,9 +2256,9 @@ static void unmap_page(struct page *page)
>  	VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
>  }
>  
> -static void remap_page(struct folio *folio, unsigned long nr)
> +static void remap_page(struct folio *folio, unsigned short nr)
>  {
> -	int i = 0;
> +	unsigned int i;
>  
>  	/* If unmap_page() uses try_to_migrate() on file, remove this check */
>  	if (!folio_test_anon(folio))
> @@ -2274,7 +2276,6 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
>  		struct lruvec *lruvec, struct list_head *list)
>  {
>  	VM_BUG_ON_PAGE(!PageHead(head), head);
> -	VM_BUG_ON_PAGE(PageCompound(tail), head);
>  	VM_BUG_ON_PAGE(PageLRU(tail), head);
>  	lockdep_assert_held(&lruvec->lru_lock);
>  
> @@ -2295,9 +2296,10 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
>  }
>  
>  static void __split_huge_page_tail(struct page *head, int tail,
> -		struct lruvec *lruvec, struct list_head *list)
> +		struct lruvec *lruvec, struct list_head *list, unsigned int new_order)
>  {
>  	struct page *page_tail = head + tail;
> +	unsigned long compound_head_flag = new_order ? (1L << PG_head) : 0;
>  
>  	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
>  
> @@ -2321,6 +2323,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
>  #ifdef CONFIG_64BIT
>  			 (1L << PG_arch_2) |
>  #endif
> +			 compound_head_flag |
>  			 (1L << PG_dirty)));
>  
>  	/* ->mapping in first tail page is compound_mapcount */
> @@ -2329,7 +2332,10 @@ static void __split_huge_page_tail(struct page *head, int tail,
>  	page_tail->mapping = head->mapping;
>  	page_tail->index = head->index + tail;
>  
> -	/* Page flags must be visible before we make the page non-compound. */
> +	/*
> +	 * Page flags must be visible before we make the page non-compound or
> +	 * a compound page in new_order.
> +	 */
>  	smp_wmb();
>  
>  	/*
> @@ -2339,10 +2345,15 @@ static void __split_huge_page_tail(struct page *head, int tail,
>  	 * which needs correct compound_head().
>  	 */
>  	clear_compound_head(page_tail);
> +	if (new_order) {
> +		prep_compound_page(page_tail, new_order);
> +		prep_transhuge_page(page_tail);
> +	}
>  
>  	/* Finally unfreeze refcount. Additional reference from page cache. */
> -	page_ref_unfreeze(page_tail, 1 + (!PageAnon(head) ||
> -					  PageSwapCache(head)));
> +	page_ref_unfreeze(page_tail, 1 + ((!PageAnon(head) ||
> +					   PageSwapCache(head)) ?
> +						thp_nr_pages(page_tail) : 0));
>  
>  	if (page_is_young(head))
>  		set_page_young(page_tail);
> @@ -2360,7 +2371,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
>  }
>  
>  static void __split_huge_page(struct page *page, struct list_head *list,
> -		pgoff_t end)
> +		pgoff_t end, unsigned int new_order)
>  {
>  	struct folio *folio = page_folio(page);
>  	struct page *head = &folio->page;
> @@ -2369,10 +2380,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	unsigned long offset = 0;
>  	unsigned int order = thp_order(head);
>  	unsigned int nr = thp_nr_pages(head);
> +	unsigned int new_nr = 1 << new_order;
>  	int i;
>  
>  	/* complete memcg works before add pages to LRU */
> -	split_page_memcg(head, nr, 0);
> +	split_page_memcg(head, nr, new_order);
>  
>  	if (PageAnon(head) && PageSwapCache(head)) {
>  		swp_entry_t entry = { .val = page_private(head) };
> @@ -2387,42 +2399,50 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  
>  	ClearPageHasHWPoisoned(head);
>  
> -	for (i = nr - 1; i >= 1; i--) {
> -		__split_huge_page_tail(head, i, lruvec, list);
> +	for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
> +		__split_huge_page_tail(head, i, lruvec, list, new_order);
>  		/* Some pages can be beyond EOF: drop them from page cache */
>  		if (head[i].index >= end) {
>  			ClearPageDirty(head + i);
>  			__delete_from_page_cache(head + i, NULL);
>  			if (shmem_mapping(head->mapping))
> -				shmem_uncharge(head->mapping->host, 1);
> +				shmem_uncharge(head->mapping->host, new_nr);
>  			put_page(head + i);
>  		} else if (!PageAnon(page)) {
>  			__xa_store(&head->mapping->i_pages, head[i].index,
>  					head + i, 0);
>  		} else if (swap_cache) {
> +			/*
> +			 * split anonymous THPs (including swapped out ones) to
> +			 * non-zero order not supported
> +			 */
> +			VM_BUG_ON(new_order);
>  			__xa_store(&swap_cache->i_pages, offset + i,
>  					head + i, 0);
>  		}
>  	}
>  
> -	ClearPageCompound(head);
> +	if (!new_order)
> +		ClearPageCompound(head);
> +	else
> +		set_compound_order(head, new_order);
>  	unlock_page_lruvec(lruvec);
>  	/* Caller disabled irqs, so they are still disabled here */
>  
> -	split_page_owner(head, order, 0);
> +	split_page_owner(head, order, new_order);
>  
>  	/* See comment in __split_huge_page_tail() */
>  	if (PageAnon(head)) {
>  		/* Additional pin to swap cache */
>  		if (PageSwapCache(head)) {
> -			page_ref_add(head, 2);
> +			page_ref_add(head, 1 + new_nr);
>  			xa_unlock(&swap_cache->i_pages);
>  		} else {
>  			page_ref_inc(head);
>  		}
>  	} else {
>  		/* Additional pin to page cache */
> -		page_ref_add(head, 2);
> +		page_ref_add(head, 1 + new_nr);
>  		xa_unlock(&head->mapping->i_pages);
>  	}
>  	local_irq_enable();
> @@ -2435,7 +2455,14 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  		split_swap_cluster(entry);
>  	}
>  
> -	for (i = 0; i < nr; i++) {
> +	/*
> +	 * set page to its compound_head when split to THPs, so that GUP pin and
> +	 * PG_locked are transferred to the right after-split page
> +	 */
> +	if (new_order)
> +		page = compound_head(page);
> +
> +	for (i = 0; i < nr; i += new_nr) {
>  		struct page *subpage = head + i;
>  		if (subpage == page)
>  			continue;
> @@ -2472,36 +2499,60 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
>   * This function splits huge page into normal pages. @page can point to any
>   * subpage of huge page to split. Split doesn't change the position of @page.
>   *
> + * See split_huge_page_to_list_to_order() for more details.
> + *
> + * Returns 0 if the hugepage is split successfully.
> + * Returns -EBUSY if the page is pinned or if anon_vma disappeared from under
> + * us.
> + */
> +int split_huge_page_to_list(struct page *page, struct list_head *list)
> +{
> +	return split_huge_page_to_list_to_order(page, list, 0);
> +}
> +
> +/*
> + * This function splits huge page into pages in @new_order. @page can point to
> + * any subpage of huge page to split. Split doesn't change the position of
> + * @page.
> + *
>   * Only caller must hold pin on the @page, otherwise split fails with -EBUSY.
>   * The huge page must be locked.
>   *
>   * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
>   *
> - * Both head page and tail pages will inherit mapping, flags, and so on from
> - * the hugepage.
> + * Pages in new_order will inherit mapping, flags, and so on from the hugepage.
>   *
> - * GUP pin and PG_locked transferred to @page. Rest subpages can be freed if
> - * they are not mapped.
> + * GUP pin and PG_locked transferred to @page or the compound page @page belongs
> + * to. Rest subpages can be freed if they are not mapped.
>   *
>   * Returns 0 if the hugepage is split successfully.
>   * Returns -EBUSY if the page is pinned or if anon_vma disappeared from under
>   * us.
>   */
> -int split_huge_page_to_list(struct page *page, struct list_head *list)
> +int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> +				     unsigned int new_order)
>  {
>  	struct folio *folio = page_folio(page);
>  	struct page *head = &folio->page;
>  	struct deferred_split *ds_queue = get_deferred_split_queue(head);
> -	XA_STATE(xas, &head->mapping->i_pages, head->index);
> +	/* reset xarray order to new order after split */
> +	XA_STATE_ORDER(xas, &head->mapping->i_pages, head->index, new_order);
>  	struct anon_vma *anon_vma = NULL;
>  	struct address_space *mapping = NULL;
>  	int extra_pins, ret;
>  	pgoff_t end;
>  
> +	VM_BUG_ON(thp_order(head) <= new_order);
>  	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
>  	VM_BUG_ON_PAGE(!PageLocked(head), head);
>  	VM_BUG_ON_PAGE(!PageCompound(head), head);
>  
> +	/* Cannot split THP to order-1 (no order-1 THPs) */
> +	VM_BUG_ON(new_order == 1);
> +
> +	/* Split anonymous THP to non-zero order not support */
> +	VM_BUG_ON(PageAnon(head) && new_order);
> +
>  	if (PageWriteback(head))
>  		return -EBUSY;
>  
> @@ -2582,7 +2633,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  	if (page_ref_freeze(head, 1 + extra_pins)) {
>  		if (!list_empty(page_deferred_list(head))) {
>  			ds_queue->split_queue_len--;
> -			list_del(page_deferred_list(head));
> +			list_del_init(page_deferred_list(head));

Can you, please, add the comment from the changelog here as well?

Thanks!
