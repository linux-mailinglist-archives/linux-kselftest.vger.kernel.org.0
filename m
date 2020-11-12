Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF542B10CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 23:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgKLWBc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 17:01:32 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9331 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgKLWBb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 17:01:31 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fadb0b50000>; Thu, 12 Nov 2020 14:01:25 -0800
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 22:01:27 +0000
Subject: Re: [RFC PATCH 4/6] mm: thp: add support for split huge page to any
 lower order pages.
To:     Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-5-zi.yan@sent.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <9b480b89-6a05-bdb7-c6ff-4518c008595a@nvidia.com>
Date:   Thu, 12 Nov 2020 14:01:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201111204008.21332-5-zi.yan@sent.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605218485; bh=MMTaC+DcUdwTYUH/7pUYvKJt2P76ewqnDoA1fCSqu7M=;
        h=Subject:To:CC:References:From:X-Nvconfidentiality:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=DwQJh9X2TZieuWwXnFmr+kemO5EfKi5cefBbp8Hx7VNFU4cSWxXsKARdf1qphJlwM
         MB3FumDGxnIIeVsoBaO2qcNAvcnmVvl4lazXz8SzxZMs4qzx1W6uGDdoLQic/gvh9M
         9QSyu3mc2V3FuW/JQCaSEaB/54CEb8zvsjy/VftoR9+59AFDK7+D3PkkY7vSZ7gWG8
         8tQ3vYjof9gnkd5ahsWoau0f24CJffsJqdHXugPySHXAl+Gc+6/LSqujlziBqefBsD
         Hf6RCkBXq51JQtrf55nyZ2uM5BHKlRvCJtgHGiXvD2DBmGMzkWRNLntq1eH1Sn0QMG
         TP9dbiNeYTIQg==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/11/20 12:40 PM, Zi Yan wrote:
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
> ---
>   include/linux/huge_mm.h |  8 +++++
>   mm/huge_memory.c        | 78 +++++++++++++++++++++++++++++------------
>   mm/swap.c               |  1 -
>   3 files changed, 63 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 60a907a19f7d..9819cd9b4619 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -189,6 +189,8 @@ bool is_transparent_hugepage(struct page *page);
>   
>   bool can_split_huge_page(struct page *page, int *pextra_pins);
>   int split_huge_page_to_list(struct page *page, struct list_head *list);
> +int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> +		unsigned int new_order);
>   static inline int split_huge_page(struct page *page)
>   {
>   	return split_huge_page_to_list(page, NULL);
> @@ -396,6 +398,12 @@ split_huge_page_to_list(struct page *page, struct list_head *list)
>   {
>   	return 0;
>   }
> +static inline int
> +split_huge_page_to_order_to_list(struct page *page, struct list_head *list,
> +		unsigned int new_order)
> +{
> +	return 0;
> +}
>   static inline int split_huge_page(struct page *page)
>   {
>   	return 0;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8b7d771ee962..88f50da40c9b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2327,11 +2327,14 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
>   static void unmap_page(struct page *page)
>   {
>   	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS |
> -		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
> +		TTU_RMAP_LOCKED;
>   	bool unmap_success;
>   
>   	VM_BUG_ON_PAGE(!PageHead(page), page);
>   
> +	if (thp_order(page) >= HPAGE_PMD_ORDER)
> +		ttu_flags |= TTU_SPLIT_HUGE_PMD;
> +
>   	if (PageAnon(page))
>   		ttu_flags |= TTU_SPLIT_FREEZE;
>   
> @@ -2339,21 +2342,22 @@ static void unmap_page(struct page *page)
>   	VM_BUG_ON_PAGE(!unmap_success, page);
>   }
>   
> -static void remap_page(struct page *page, unsigned int nr)
> +static void remap_page(struct page *page, unsigned int nr, unsigned int new_nr)
>   {
>   	int i;

Use unsigned int i?
Maybe a blank line here and the {}'s around if/else aren't needed.

> -	if (PageTransHuge(page)) {
> +	if (thp_nr_pages(page) == nr) {
>   		remove_migration_ptes(page, page, true);
>   	} else {
> -		for (i = 0; i < nr; i++)
> +		for (i = 0; i < nr; i += new_nr)
>   			remove_migration_ptes(page + i, page + i, true);
>   	}
>   }
>   
>   static void __split_huge_page_tail(struct page *head, int tail,
> -		struct lruvec *lruvec, struct list_head *list)
> +		struct lruvec *lruvec, struct list_head *list, unsigned int new_order)
>   {
>   	struct page *page_tail = head + tail;
> +	unsigned long compound_head_flag = new_order ? (1L << PG_head) : 0;
>   
>   	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
>   
> @@ -2377,6 +2381,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
>   #ifdef CONFIG_64BIT
>   			 (1L << PG_arch_2) |
>   #endif
> +			 compound_head_flag |
>   			 (1L << PG_dirty)));
>   
>   	/* ->mapping in first tail page is compound_mapcount */
> @@ -2395,10 +2400,15 @@ static void __split_huge_page_tail(struct page *head, int tail,
>   	 * which needs correct compound_head().
>   	 */
>   	clear_compound_head(page_tail);
> +	if (new_order) {
> +		prep_compound_page(page_tail, new_order);
> +		thp_prep(page_tail);
> +	}
>   
>   	/* Finally unfreeze refcount. Additional reference from page cache. */
> -	page_ref_unfreeze(page_tail, 1 + (!PageAnon(head) ||
> -					  PageSwapCache(head)));
> +	page_ref_unfreeze(page_tail, 1 + ((!PageAnon(head) ||
> +					   PageSwapCache(head)) ?
> +						thp_nr_pages(page_tail) : 0));
>   
>   	if (page_is_young(head))
>   		set_page_young(page_tail);
> @@ -2416,7 +2426,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
>   }
>   
>   static void __split_huge_page(struct page *page, struct list_head *list,
> -		pgoff_t end, unsigned long flags)
> +		pgoff_t end, unsigned long flags, unsigned int new_order)
>   {
>   	struct page *head = compound_head(page);
>   	pg_data_t *pgdat = page_pgdat(head);
> @@ -2424,12 +2434,13 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   	struct address_space *swap_cache = NULL;
>   	unsigned long offset = 0;
>   	unsigned int nr = thp_nr_pages(head);
> +	unsigned int new_nr = 1 << new_order;
>   	int i;
>   
>   	lruvec = mem_cgroup_page_lruvec(head, pgdat);
>   
>   	/* complete memcg works before add pages to LRU */
> -	mem_cgroup_split_huge_fixup(head, 1);
> +	mem_cgroup_split_huge_fixup(head, new_nr);
>   
>   	if (PageAnon(head) && PageSwapCache(head)) {
>   		swp_entry_t entry = { .val = page_private(head) };
> @@ -2439,14 +2450,14 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   		xa_lock(&swap_cache->i_pages);
>   	}
>   
> -	for (i = nr - 1; i >= 1; i--) {
> -		__split_huge_page_tail(head, i, lruvec, list);
> +	for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
> +		__split_huge_page_tail(head, i, lruvec, list, new_order);
>   		/* Some pages can be beyond i_size: drop them from page cache */
>   		if (head[i].index >= end) {
>   			ClearPageDirty(head + i);
>   			__delete_from_page_cache(head + i, NULL);
>   			if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
> -				shmem_uncharge(head->mapping->host, 1);
> +				shmem_uncharge(head->mapping->host, new_nr);
>   			put_page(head + i);
>   		} else if (!PageAnon(page)) {
>   			__xa_store(&head->mapping->i_pages, head[i].index,
> @@ -2457,28 +2468,31 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   		}
>   	}
>   
> -	ClearPageCompound(head);
> +	if (!new_order)
> +		ClearPageCompound(head);
> +	else
> +		set_compound_order(head, new_order);
>   
> -	split_page_owner(head, nr, 1);
> +	split_page_owner(head, nr, new_nr);

This needs to be "new_order" instead of "new_nr".

>   	/* See comment in __split_huge_page_tail() */
>   	if (PageAnon(head)) {
>   		/* Additional pin to swap cache */
>   		if (PageSwapCache(head)) {
> -			page_ref_add(head, 2);
> +			page_ref_add(head, 1 + new_nr);
>   			xa_unlock(&swap_cache->i_pages);
>   		} else {
>   			page_ref_inc(head);
>   		}
>   	} else {
>   		/* Additional pin to page cache */
> -		page_ref_add(head, 2);
> +		page_ref_add(head, 1 + new_nr);
>   		xa_unlock(&head->mapping->i_pages);
>   	}
>   
>   	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>   
> -	remap_page(head, nr);
> +	remap_page(head, nr, new_nr);
>   
>   	if (PageSwapCache(head)) {
>   		swp_entry_t entry = { .val = page_private(head) };
> @@ -2486,7 +2500,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   		split_swap_cluster(entry);
>   	}
>   
> -	for (i = 0; i < nr; i++) {
> +	for (i = 0; i < nr; i += new_nr) {
>   		struct page *subpage = head + i;
>   		if (subpage == page)
>   			continue;
> @@ -2620,21 +2634,39 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
>    * us.
>    */
>   int split_huge_page_to_list(struct page *page, struct list_head *list)
> +{
> +	return split_huge_page_to_list_to_order(page, list, 0);
> +}
> +
> +int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> +				     unsigned int new_order)
>   {
>   	struct page *head = compound_head(page);
>   	struct pglist_data *pgdata = NODE_DATA(page_to_nid(head));
>   	struct deferred_split *ds_queue = get_deferred_split_queue(head);
> -	XA_STATE(xas, &head->mapping->i_pages, head->index);
> +	/* reset xarray order to new order after split */
> +	XA_STATE_ORDER(xas, &head->mapping->i_pages, head->index, new_order);
>   	struct anon_vma *anon_vma = NULL;
>   	struct address_space *mapping = NULL;
>   	int count, mapcount, extra_pins, ret;
>   	unsigned long flags;
>   	pgoff_t end;
>   
> +	VM_BUG_ON(thp_order(head) <= new_order);
>   	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
>   	VM_BUG_ON_PAGE(!PageLocked(head), head);
>   	VM_BUG_ON_PAGE(!PageCompound(head), head);
>   
> +	if (new_order == 1) {
> +		WARN_ONCE(1, "Cannot split THP to order-1 (no order-1 THPs)");
> +		return -EINVAL;
> +	}
> +
> +	if (PageAnon(head) && new_order) {
> +		WARN_ONCE(1, "Split anonymous THP to non-zero order not support");
> +		return -EINVAL;
> +	}
> +
>   	if (PageWriteback(head))
>   		return -EBUSY;
>   
> @@ -2720,18 +2752,18 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>   	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
>   		if (!list_empty(page_deferred_list(head))) {
>   			ds_queue->split_queue_len--;
> -			list_del(page_deferred_list(head));
> +			list_del_init(page_deferred_list(head));
>   		}
>   		spin_unlock(&ds_queue->split_queue_lock);
>   		if (mapping) {
>   			if (PageSwapBacked(head))
>   				__dec_lruvec_page_state(head, NR_SHMEM_THPS);
> -			else
> +			else if (!new_order)
>   				__mod_lruvec_page_state(head, NR_FILE_THPS,
>   						-thp_nr_pages(head));
>   		}
>   
> -		__split_huge_page(page, list, end, flags);
> +		__split_huge_page(page, list, end, flags, new_order);
>   		ret = 0;
>   	} else {
>   		if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
> @@ -2746,7 +2778,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>   fail:		if (mapping)
>   			xas_unlock(&xas);
>   		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
> -		remap_page(head, thp_nr_pages(head));
> +		remap_page(head, thp_nr_pages(head), 0);

Shouldn't this be "1" instead of zero?
remap_page() takes new_nr.

>   		ret = -EBUSY;
>   	}
>   
> diff --git a/mm/swap.c b/mm/swap.c
> index 14c3bac607a6..6c33e6165597 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -983,7 +983,6 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
>   		       struct lruvec *lruvec, struct list_head *list)
>   {
>   	VM_BUG_ON_PAGE(!PageHead(page), page);
> -	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
>   	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
>   	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
>   
> 
