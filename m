Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0AC2B114F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 23:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgKLWU5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 17:20:57 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11230 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKLWU5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 17:20:57 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fadb5430001>; Thu, 12 Nov 2020 14:20:51 -0800
Received: from [10.2.174.128] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 22:20:53 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     <linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 4/6] mm: thp: add support for split huge page to any
 lower order pages.
Date:   Thu, 12 Nov 2020 17:20:50 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <18B08769-FE06-4516-8426-86EB8A4AE4E5@nvidia.com>
In-Reply-To: <9b480b89-6a05-bdb7-c6ff-4518c008595a@nvidia.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-5-zi.yan@sent.com>
 <9b480b89-6a05-bdb7-c6ff-4518c008595a@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_88A2E356-CD37-40FF-A366-C9B000BAB81C_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605219651; bh=Nmpd1Jnpp9GWTLQdKEV42enp9iIY+k4NX7roQElHFLg=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=Cbk7p2Ie4TW4iZrLk1/aVQexklIs3W4hGf82e6/5ssctxRQsNBsQKb4rx289qlIXA
         gb+4QoGzQ3cujWVRAGm8/mAMldnZ4KkYaCHDMdFZSal2tW9hHQwuI6c80nevuQ+VIz
         OhPPlUMpcFxQovfUN6R7TPVPfYe5yENkm2dDjRQwql9lGZt4nSYeAzPPrJ8o6SBmEI
         32Ag5KwMvPN469Mhsbv9A8nELJKa+InMOeDn7ZJrMixQYSzu9PHas8XZ3O8SUWfzWt
         7SUiL+PxDsw1rHwIuoDmtcviZ8ZdSHfe/Ebn7x+lCGpl6fcrVk/dZRMBV4nqmEkzYL
         PBXHf//b4rXVQ==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_88A2E356-CD37-40FF-A366-C9B000BAB81C_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 12 Nov 2020, at 17:01, Ralph Campbell wrote:

> On 11/11/20 12:40 PM, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> To split a THP to any lower order pages, we need to reform THPs on
>> subpages at given order and add page refcount based on the new page
>> order. Also we need to reinitialize page_deferred_list after removing
>> the page from the split_queue, otherwise a subsequent split will see
>> list corruption when checking the page_deferred_list again.
>>
>> It has many uses, like minimizing the number of pages after
>> truncating a pagecache THP. For anonymous THPs, we can only split them=

>> to order-0 like before until we add support for any size anonymous THP=
s.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   include/linux/huge_mm.h |  8 +++++
>>   mm/huge_memory.c        | 78 +++++++++++++++++++++++++++++----------=
--
>>   mm/swap.c               |  1 -
>>   3 files changed, 63 insertions(+), 24 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 60a907a19f7d..9819cd9b4619 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -189,6 +189,8 @@ bool is_transparent_hugepage(struct page *page);
>>    bool can_split_huge_page(struct page *page, int *pextra_pins);
>>   int split_huge_page_to_list(struct page *page, struct list_head *lis=
t);
>> +int split_huge_page_to_list_to_order(struct page *page, struct list_h=
ead *list,
>> +		unsigned int new_order);
>>   static inline int split_huge_page(struct page *page)
>>   {
>>   	return split_huge_page_to_list(page, NULL);
>> @@ -396,6 +398,12 @@ split_huge_page_to_list(struct page *page, struct=
 list_head *list)
>>   {
>>   	return 0;
>>   }
>> +static inline int
>> +split_huge_page_to_order_to_list(struct page *page, struct list_head =
*list,
>> +		unsigned int new_order)
>> +{
>> +	return 0;
>> +}
>>   static inline int split_huge_page(struct page *page)
>>   {
>>   	return 0;
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 8b7d771ee962..88f50da40c9b 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2327,11 +2327,14 @@ void vma_adjust_trans_huge(struct vm_area_stru=
ct *vma,
>>   static void unmap_page(struct page *page)
>>   {
>>   	enum ttu_flags ttu_flags =3D TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS |=

>> -		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
>> +		TTU_RMAP_LOCKED;
>>   	bool unmap_success;
>>    	VM_BUG_ON_PAGE(!PageHead(page), page);
>>  +	if (thp_order(page) >=3D HPAGE_PMD_ORDER)
>> +		ttu_flags |=3D TTU_SPLIT_HUGE_PMD;
>> +
>>   	if (PageAnon(page))
>>   		ttu_flags |=3D TTU_SPLIT_FREEZE;
>>  @@ -2339,21 +2342,22 @@ static void unmap_page(struct page *page)
>>   	VM_BUG_ON_PAGE(!unmap_success, page);
>>   }
>>  -static void remap_page(struct page *page, unsigned int nr)
>> +static void remap_page(struct page *page, unsigned int nr, unsigned i=
nt new_nr)
>>   {
>>   	int i;
>
> Use unsigned int i?
> Maybe a blank line here and the {}'s around if/else aren't needed.
>
>> -	if (PageTransHuge(page)) {
>> +	if (thp_nr_pages(page) =3D=3D nr) {
>>   		remove_migration_ptes(page, page, true);
>>   	} else {
>> -		for (i =3D 0; i < nr; i++)
>> +		for (i =3D 0; i < nr; i +=3D new_nr)
>>   			remove_migration_ptes(page + i, page + i, true);
>>   	}
>>   }
>>    static void __split_huge_page_tail(struct page *head, int tail,
>> -		struct lruvec *lruvec, struct list_head *list)
>> +		struct lruvec *lruvec, struct list_head *list, unsigned int new_ord=
er)
>>   {
>>   	struct page *page_tail =3D head + tail;
>> +	unsigned long compound_head_flag =3D new_order ? (1L << PG_head) : 0=
;
>>    	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) !=3D -1, page_ta=
il);
>>  @@ -2377,6 +2381,7 @@ static void __split_huge_page_tail(struct page =
*head, int tail,
>>   #ifdef CONFIG_64BIT
>>   			 (1L << PG_arch_2) |
>>   #endif
>> +			 compound_head_flag |
>>   			 (1L << PG_dirty)));
>>    	/* ->mapping in first tail page is compound_mapcount */
>> @@ -2395,10 +2400,15 @@ static void __split_huge_page_tail(struct page=
 *head, int tail,
>>   	 * which needs correct compound_head().
>>   	 */
>>   	clear_compound_head(page_tail);
>> +	if (new_order) {
>> +		prep_compound_page(page_tail, new_order);
>> +		thp_prep(page_tail);
>> +	}
>>    	/* Finally unfreeze refcount. Additional reference from page cache=
=2E */
>> -	page_ref_unfreeze(page_tail, 1 + (!PageAnon(head) ||
>> -					  PageSwapCache(head)));
>> +	page_ref_unfreeze(page_tail, 1 + ((!PageAnon(head) ||
>> +					   PageSwapCache(head)) ?
>> +						thp_nr_pages(page_tail) : 0));
>>    	if (page_is_young(head))
>>   		set_page_young(page_tail);
>> @@ -2416,7 +2426,7 @@ static void __split_huge_page_tail(struct page *=
head, int tail,
>>   }
>>    static void __split_huge_page(struct page *page, struct list_head *=
list,
>> -		pgoff_t end, unsigned long flags)
>> +		pgoff_t end, unsigned long flags, unsigned int new_order)
>>   {
>>   	struct page *head =3D compound_head(page);
>>   	pg_data_t *pgdat =3D page_pgdat(head);
>> @@ -2424,12 +2434,13 @@ static void __split_huge_page(struct page *pag=
e, struct list_head *list,
>>   	struct address_space *swap_cache =3D NULL;
>>   	unsigned long offset =3D 0;
>>   	unsigned int nr =3D thp_nr_pages(head);
>> +	unsigned int new_nr =3D 1 << new_order;
>>   	int i;
>>    	lruvec =3D mem_cgroup_page_lruvec(head, pgdat);
>>    	/* complete memcg works before add pages to LRU */
>> -	mem_cgroup_split_huge_fixup(head, 1);
>> +	mem_cgroup_split_huge_fixup(head, new_nr);
>>    	if (PageAnon(head) && PageSwapCache(head)) {
>>   		swp_entry_t entry =3D { .val =3D page_private(head) };
>> @@ -2439,14 +2450,14 @@ static void __split_huge_page(struct page *pag=
e, struct list_head *list,
>>   		xa_lock(&swap_cache->i_pages);
>>   	}
>>  -	for (i =3D nr - 1; i >=3D 1; i--) {
>> -		__split_huge_page_tail(head, i, lruvec, list);
>> +	for (i =3D nr - new_nr; i >=3D new_nr; i -=3D new_nr) {
>> +		__split_huge_page_tail(head, i, lruvec, list, new_order);
>>   		/* Some pages can be beyond i_size: drop them from page cache */
>>   		if (head[i].index >=3D end) {
>>   			ClearPageDirty(head + i);
>>   			__delete_from_page_cache(head + i, NULL);
>>   			if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
>> -				shmem_uncharge(head->mapping->host, 1);
>> +				shmem_uncharge(head->mapping->host, new_nr);
>>   			put_page(head + i);
>>   		} else if (!PageAnon(page)) {
>>   			__xa_store(&head->mapping->i_pages, head[i].index,
>> @@ -2457,28 +2468,31 @@ static void __split_huge_page(struct page *pag=
e, struct list_head *list,
>>   		}
>>   	}
>>  -	ClearPageCompound(head);
>> +	if (!new_order)
>> +		ClearPageCompound(head);
>> +	else
>> +		set_compound_order(head, new_order);
>>  -	split_page_owner(head, nr, 1);
>> +	split_page_owner(head, nr, new_nr);
>
> This needs to be "new_order" instead of "new_nr".
>
>>   	/* See comment in __split_huge_page_tail() */
>>   	if (PageAnon(head)) {
>>   		/* Additional pin to swap cache */
>>   		if (PageSwapCache(head)) {
>> -			page_ref_add(head, 2);
>> +			page_ref_add(head, 1 + new_nr);
>>   			xa_unlock(&swap_cache->i_pages);
>>   		} else {
>>   			page_ref_inc(head);
>>   		}
>>   	} else {
>>   		/* Additional pin to page cache */
>> -		page_ref_add(head, 2);
>> +		page_ref_add(head, 1 + new_nr);
>>   		xa_unlock(&head->mapping->i_pages);
>>   	}
>>    	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>>  -	remap_page(head, nr);
>> +	remap_page(head, nr, new_nr);
>>    	if (PageSwapCache(head)) {
>>   		swp_entry_t entry =3D { .val =3D page_private(head) };
>> @@ -2486,7 +2500,7 @@ static void __split_huge_page(struct page *page,=
 struct list_head *list,
>>   		split_swap_cluster(entry);
>>   	}
>>  -	for (i =3D 0; i < nr; i++) {
>> +	for (i =3D 0; i < nr; i +=3D new_nr) {
>>   		struct page *subpage =3D head + i;
>>   		if (subpage =3D=3D page)
>>   			continue;
>> @@ -2620,21 +2634,39 @@ bool can_split_huge_page(struct page *page, in=
t *pextra_pins)
>>    * us.
>>    */
>>   int split_huge_page_to_list(struct page *page, struct list_head *lis=
t)
>> +{
>> +	return split_huge_page_to_list_to_order(page, list, 0);
>> +}
>> +
>> +int split_huge_page_to_list_to_order(struct page *page, struct list_h=
ead *list,
>> +				     unsigned int new_order)
>>   {
>>   	struct page *head =3D compound_head(page);
>>   	struct pglist_data *pgdata =3D NODE_DATA(page_to_nid(head));
>>   	struct deferred_split *ds_queue =3D get_deferred_split_queue(head);=

>> -	XA_STATE(xas, &head->mapping->i_pages, head->index);
>> +	/* reset xarray order to new order after split */
>> +	XA_STATE_ORDER(xas, &head->mapping->i_pages, head->index, new_order)=
;
>>   	struct anon_vma *anon_vma =3D NULL;
>>   	struct address_space *mapping =3D NULL;
>>   	int count, mapcount, extra_pins, ret;
>>   	unsigned long flags;
>>   	pgoff_t end;
>>  +	VM_BUG_ON(thp_order(head) <=3D new_order);
>>   	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
>>   	VM_BUG_ON_PAGE(!PageLocked(head), head);
>>   	VM_BUG_ON_PAGE(!PageCompound(head), head);
>>  +	if (new_order =3D=3D 1) {
>> +		WARN_ONCE(1, "Cannot split THP to order-1 (no order-1 THPs)");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (PageAnon(head) && new_order) {
>> +		WARN_ONCE(1, "Split anonymous THP to non-zero order not support");
>> +		return -EINVAL;
>> +	}
>> +
>>   	if (PageWriteback(head))
>>   		return -EBUSY;
>>  @@ -2720,18 +2752,18 @@ int split_huge_page_to_list(struct page *page=
, struct list_head *list)
>>   	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
>>   		if (!list_empty(page_deferred_list(head))) {
>>   			ds_queue->split_queue_len--;
>> -			list_del(page_deferred_list(head));
>> +			list_del_init(page_deferred_list(head));
>>   		}
>>   		spin_unlock(&ds_queue->split_queue_lock);
>>   		if (mapping) {
>>   			if (PageSwapBacked(head))
>>   				__dec_lruvec_page_state(head, NR_SHMEM_THPS);
>> -			else
>> +			else if (!new_order)
>>   				__mod_lruvec_page_state(head, NR_FILE_THPS,
>>   						-thp_nr_pages(head));
>>   		}
>>  -		__split_huge_page(page, list, end, flags);
>> +		__split_huge_page(page, list, end, flags, new_order);
>>   		ret =3D 0;
>>   	} else {
>>   		if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
>> @@ -2746,7 +2778,7 @@ int split_huge_page_to_list(struct page *page, s=
truct list_head *list)
>>   fail:		if (mapping)
>>   			xas_unlock(&xas);
>>   		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
>> -		remap_page(head, thp_nr_pages(head));
>> +		remap_page(head, thp_nr_pages(head), 0);
>
> Shouldn't this be "1" instead of zero?
> remap_page() takes new_nr.
>
>>   		ret =3D -EBUSY;
>>   	}
>>  diff --git a/mm/swap.c b/mm/swap.c
>> index 14c3bac607a6..6c33e6165597 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -983,7 +983,6 @@ void lru_add_page_tail(struct page *page, struct p=
age *page_tail,
>>   		       struct lruvec *lruvec, struct list_head *list)
>>   {
>>   	VM_BUG_ON_PAGE(!PageHead(page), page);
>> -	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
>>   	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
>>   	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
>>

Thanks for catching all these. Will fix them in the next version.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_88A2E356-CD37-40FF-A366-C9B000BAB81C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+ttUIPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKyzwP/jcoZGgGFjVCy7i3bmIjVvya/CI8wlSHu2iW
8TPnmRzsPleqKia+dJ8DF0EpFDvz7XHBauiNkLfeIjNgInPh55iwIbUCMZgf8rSx
cv3YWOoEJTrqRIc6XxaslaLK1zk6wrMwK57dJ3iDedfK1mZCKidtvYjOuxboJgqK
eQk2Yx9g5jDNjKe+wG/x1Y/clLoKpLY9hnDd5OoPs0bNTNvkhoGoz0WEuOExB3wX
lhamVQUPD35dO3cnCTttAIYqXzpWq6JkYwVgVT5d+Zt0KneH6NPh41vw7gecG4m4
zneoIxjtNrIyGeGHBI02sW2Z8BRMC89Sbx8HMVSETZ0EApA/AUU1DTtINy6jrBso
HAcFQLwIFh5U8ePhpczAe7uWIsWAtAnLtyVIHpCQIg+efpdxc28DsofQYfVPuYAG
kaicqfxEPQqlRACHdgYbl97Uej4Rs4yTvoZC/OB4TKdbdCPD213UHPjpQ0lNxzJ5
pyi2Yt3jO6qWbYt9Y4CxOvZjuIOIAoMyH51B6mlt4sCF+Sr3y0NV57flNvfMLrDL
ss9lw7arlC1ZdsoYMY+aWUxiwcrw1//MIO1+SQt/mW2Tp6fCylMbNArb42AlVbQl
QCT5Awkfuw0XFlXfxSDChuYuzKV65ek3kS6e/v6RRjaGIfDYrr2bHqfta3mk5Wjj
pz/2ruON
=617+
-----END PGP SIGNATURE-----

--=_MailMate_88A2E356-CD37-40FF-A366-C9B000BAB81C_=--
