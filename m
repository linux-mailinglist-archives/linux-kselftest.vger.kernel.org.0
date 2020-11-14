Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28EC2B2A44
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Nov 2020 02:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKNBAQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Nov 2020 20:00:16 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16640 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKNBAQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Nov 2020 20:00:16 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5faf2c24000c>; Fri, 13 Nov 2020 17:00:20 -0800
Received: from [10.2.162.52] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 14 Nov
 2020 01:00:12 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Roman Gushchin <guro@fb.com>
CC:     <linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 4/6] mm: thp: add support for split huge page to any
 lower order pages.
Date:   Fri, 13 Nov 2020 20:00:10 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <F1A21578-E5CA-44E4-958B-C3D481200111@nvidia.com>
In-Reply-To: <20201114005249.GC3047204@carbon.dhcp.thefacebook.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-5-zi.yan@sent.com>
 <20201114005249.GC3047204@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_63B93A24-0490-4581-80CA-48FD21CAB638_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605315620; bh=9W1ShmiLwqqf77+63FBPoUbeXXOqRhHqWZ+R0tLEwhk=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=bhExGZFwehAuKj7qh7CdYrsPNhE9dxt6fYcwgny/TbY7wEQaXkUp8mnwwLhyol7FI
         MkcHET/Oa7mbTRQky6RcFyo9zePtpuzwFOFfRyTArtU6Jfik7o5fIyj8rsQsRNQ97U
         WtQpEKldWLnRAXfMclC2TCEVlOvSaaaSY7/B2RNOQLZ0FeXjpDRADsHOqVhTrCBUR+
         vKvYLSoBrpAtHQCUEXG0jnbgP2fNSPrkfJfWxz0nwj6jk2NN/uR+vsq/o1c00evRLz
         Ji2U1AanE/PMKM1ML4lwhiinlaXJQcyI9MHuuBoeNaVME7B7dIU0jjXyH93bJfhwGu
         hoWJBlybeqqeA==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_63B93A24-0490-4581-80CA-48FD21CAB638_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 13 Nov 2020, at 19:52, Roman Gushchin wrote:

> On Wed, Nov 11, 2020 at 03:40:06PM -0500, Zi Yan wrote:
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
>>  include/linux/huge_mm.h |  8 +++++
>>  mm/huge_memory.c        | 78 +++++++++++++++++++++++++++++-----------=
-
>>  mm/swap.c               |  1 -
>>  3 files changed, 63 insertions(+), 24 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 60a907a19f7d..9819cd9b4619 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -189,6 +189,8 @@ bool is_transparent_hugepage(struct page *page);
>>
>>  bool can_split_huge_page(struct page *page, int *pextra_pins);
>>  int split_huge_page_to_list(struct page *page, struct list_head *list=
);
>> +int split_huge_page_to_list_to_order(struct page *page, struct list_h=
ead *list,
>> +		unsigned int new_order);
>>  static inline int split_huge_page(struct page *page)
>>  {
>>  	return split_huge_page_to_list(page, NULL);
>> @@ -396,6 +398,12 @@ split_huge_page_to_list(struct page *page, struct=
 list_head *list)
>>  {
>>  	return 0;
>>  }
>> +static inline int
>> +split_huge_page_to_order_to_list(struct page *page, struct list_head =
*list,
>> +		unsigned int new_order)
>
> It was
> int split_huge_page_to_list_to_order(struct page *page, struct list_hea=
d *list,
> 		unsigned int new_order);
> above.

Right. It should be split_huge_page_to_list_to_order. Will fix it.

>
>> +{
>> +	return 0;
>> +}
>>  static inline int split_huge_page(struct page *page)
>>  {
>>  	return 0;
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 8b7d771ee962..88f50da40c9b 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2327,11 +2327,14 @@ void vma_adjust_trans_huge(struct vm_area_stru=
ct *vma,
>>  static void unmap_page(struct page *page)
>>  {
>>  	enum ttu_flags ttu_flags =3D TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS |
>> -		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
>> +		TTU_RMAP_LOCKED;
>>  	bool unmap_success;
>>
>>  	VM_BUG_ON_PAGE(!PageHead(page), page);
>>
>> +	if (thp_order(page) >=3D HPAGE_PMD_ORDER)
>> +		ttu_flags |=3D TTU_SPLIT_HUGE_PMD;
>> +
>>  	if (PageAnon(page))
>>  		ttu_flags |=3D TTU_SPLIT_FREEZE;
>>
>> @@ -2339,21 +2342,22 @@ static void unmap_page(struct page *page)
>>  	VM_BUG_ON_PAGE(!unmap_success, page);
>>  }
>>
>> -static void remap_page(struct page *page, unsigned int nr)
>> +static void remap_page(struct page *page, unsigned int nr, unsigned i=
nt new_nr)
>>  {
>>  	int i;
>> -	if (PageTransHuge(page)) {
>> +	if (thp_nr_pages(page) =3D=3D nr) {
>>  		remove_migration_ptes(page, page, true);
>>  	} else {
>> -		for (i =3D 0; i < nr; i++)
>> +		for (i =3D 0; i < nr; i +=3D new_nr)
>>  			remove_migration_ptes(page + i, page + i, true);
>>  	}
>>  }
>>
>>  static void __split_huge_page_tail(struct page *head, int tail,
>> -		struct lruvec *lruvec, struct list_head *list)
>> +		struct lruvec *lruvec, struct list_head *list, unsigned int new_ord=
er)
>>  {
>>  	struct page *page_tail =3D head + tail;
>> +	unsigned long compound_head_flag =3D new_order ? (1L << PG_head) : 0=
;
>>
>>  	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) !=3D -1, page_tail=
);
>>
>> @@ -2377,6 +2381,7 @@ static void __split_huge_page_tail(struct page *=
head, int tail,
>>  #ifdef CONFIG_64BIT
>>  			 (1L << PG_arch_2) |
>>  #endif
>> +			 compound_head_flag |
>>  			 (1L << PG_dirty)));
>>
>>  	/* ->mapping in first tail page is compound_mapcount */
>> @@ -2395,10 +2400,15 @@ static void __split_huge_page_tail(struct page=
 *head, int tail,
>>  	 * which needs correct compound_head().
>>  	 */
>>  	clear_compound_head(page_tail);
>> +	if (new_order) {
>> +		prep_compound_page(page_tail, new_order);
>> +		thp_prep(page_tail);
>> +	}
>>
>>  	/* Finally unfreeze refcount. Additional reference from page cache. =
*/
>> -	page_ref_unfreeze(page_tail, 1 + (!PageAnon(head) ||
>> -					  PageSwapCache(head)));
>> +	page_ref_unfreeze(page_tail, 1 + ((!PageAnon(head) ||
>> +					   PageSwapCache(head)) ?
>> +						thp_nr_pages(page_tail) : 0));
>>
>>  	if (page_is_young(head))
>>  		set_page_young(page_tail);
>> @@ -2416,7 +2426,7 @@ static void __split_huge_page_tail(struct page *=
head, int tail,
>>  }
>>
>>  static void __split_huge_page(struct page *page, struct list_head *li=
st,
>> -		pgoff_t end, unsigned long flags)
>> +		pgoff_t end, unsigned long flags, unsigned int new_order)
>>  {
>>  	struct page *head =3D compound_head(page);
>>  	pg_data_t *pgdat =3D page_pgdat(head);
>> @@ -2424,12 +2434,13 @@ static void __split_huge_page(struct page *pag=
e, struct list_head *list,
>>  	struct address_space *swap_cache =3D NULL;
>>  	unsigned long offset =3D 0;
>>  	unsigned int nr =3D thp_nr_pages(head);
>> +	unsigned int new_nr =3D 1 << new_order;
>>  	int i;
>>
>>  	lruvec =3D mem_cgroup_page_lruvec(head, pgdat);
>>
>>  	/* complete memcg works before add pages to LRU */
>> -	mem_cgroup_split_huge_fixup(head, 1);
>> +	mem_cgroup_split_huge_fixup(head, new_nr);
>>
>>  	if (PageAnon(head) && PageSwapCache(head)) {
>>  		swp_entry_t entry =3D { .val =3D page_private(head) };
>> @@ -2439,14 +2450,14 @@ static void __split_huge_page(struct page *pag=
e, struct list_head *list,
>>  		xa_lock(&swap_cache->i_pages);
>>  	}
>>
>> -	for (i =3D nr - 1; i >=3D 1; i--) {
>> -		__split_huge_page_tail(head, i, lruvec, list);
>> +	for (i =3D nr - new_nr; i >=3D new_nr; i -=3D new_nr) {
>> +		__split_huge_page_tail(head, i, lruvec, list, new_order);
>>  		/* Some pages can be beyond i_size: drop them from page cache */
>>  		if (head[i].index >=3D end) {
>>  			ClearPageDirty(head + i);
>>  			__delete_from_page_cache(head + i, NULL);
>>  			if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
>> -				shmem_uncharge(head->mapping->host, 1);
>> +				shmem_uncharge(head->mapping->host, new_nr);
>>  			put_page(head + i);
>>  		} else if (!PageAnon(page)) {
>>  			__xa_store(&head->mapping->i_pages, head[i].index,
>> @@ -2457,28 +2468,31 @@ static void __split_huge_page(struct page *pag=
e, struct list_head *list,
>>  		}
>>  	}
>>
>> -	ClearPageCompound(head);
>> +	if (!new_order)
>> +		ClearPageCompound(head);
>> +	else
>> +		set_compound_order(head, new_order);
>>
>> -	split_page_owner(head, nr, 1);
>> +	split_page_owner(head, nr, new_nr);
>>
>>  	/* See comment in __split_huge_page_tail() */
>>  	if (PageAnon(head)) {
>>  		/* Additional pin to swap cache */
>>  		if (PageSwapCache(head)) {
>> -			page_ref_add(head, 2);
>> +			page_ref_add(head, 1 + new_nr);
>>  			xa_unlock(&swap_cache->i_pages);
>>  		} else {
>>  			page_ref_inc(head);
>>  		}
>>  	} else {
>>  		/* Additional pin to page cache */
>> -		page_ref_add(head, 2);
>> +		page_ref_add(head, 1 + new_nr);
>>  		xa_unlock(&head->mapping->i_pages);
>>  	}
>>
>>  	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>>
>> -	remap_page(head, nr);
>> +	remap_page(head, nr, new_nr);
>>
>>  	if (PageSwapCache(head)) {
>>  		swp_entry_t entry =3D { .val =3D page_private(head) };
>> @@ -2486,7 +2500,7 @@ static void __split_huge_page(struct page *page,=
 struct list_head *list,
>>  		split_swap_cluster(entry);
>>  	}
>>
>> -	for (i =3D 0; i < nr; i++) {
>> +	for (i =3D 0; i < nr; i +=3D new_nr) {
>>  		struct page *subpage =3D head + i;
>>  		if (subpage =3D=3D page)
>>  			continue;
>> @@ -2620,21 +2634,39 @@ bool can_split_huge_page(struct page *page, in=
t *pextra_pins)
>>   * us.
>>   */
>>  int split_huge_page_to_list(struct page *page, struct list_head *list=
)
>> +{
>> +	return split_huge_page_to_list_to_order(page, list, 0);
>> +}
>> +
>> +int split_huge_page_to_list_to_order(struct page *page, struct list_h=
ead *list,
>> +				     unsigned int new_order)
>>  {
>>  	struct page *head =3D compound_head(page);
>>  	struct pglist_data *pgdata =3D NODE_DATA(page_to_nid(head));
>>  	struct deferred_split *ds_queue =3D get_deferred_split_queue(head);
>> -	XA_STATE(xas, &head->mapping->i_pages, head->index);
>> +	/* reset xarray order to new order after split */
>> +	XA_STATE_ORDER(xas, &head->mapping->i_pages, head->index, new_order)=
;
>>  	struct anon_vma *anon_vma =3D NULL;
>>  	struct address_space *mapping =3D NULL;
>>  	int count, mapcount, extra_pins, ret;
>>  	unsigned long flags;
>>  	pgoff_t end;
>>
>> +	VM_BUG_ON(thp_order(head) <=3D new_order);
>>  	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
>>  	VM_BUG_ON_PAGE(!PageLocked(head), head);
>>  	VM_BUG_ON_PAGE(!PageCompound(head), head);
>>
>> +	if (new_order =3D=3D 1) {
>> +		WARN_ONCE(1, "Cannot split THP to order-1 (no order-1 THPs)");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (PageAnon(head) && new_order) {
>> +		WARN_ONCE(1, "Split anonymous THP to non-zero order not support");
>> +		return -EINVAL;
>> +	}
>
> I'd convert those into VM_BUG_ON()'s. Unlikely they will be hit at arbi=
trary moments
> by random users.

Sure. Will change them.

Thanks.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_63B93A24-0490-4581-80CA-48FD21CAB638_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+vLBoPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKyvYQAJ2uTszK5yRSvTWoXJs6Gx4wBgLwxy27vHtr
LA3q7AwWZ3Xff+AP7Dr5Km1nf+yg/U/25LU4Z/kAFGv2kGxKEAk0ZdRzHru//ToF
JQqAHB4z1z8gXzSVp8VwyFyGWhlyvvUjT603uUcIvU+mCKEznQ5NjDTSwe+37VUI
HhdpTxT/wciLzuOeM5iO2Ij0ULSnE0A+P+74m3NlkYxlIg37o83h6bgRoH2iQ53u
DYIgPRZqGcBlzj3e4u6o5IVOqgxMzCG9WEtmJX/4lOGYcwMFlAfqbYjHWfi8EkFr
fw3LNjFX74/mw04o+y5kpAulkZtPCBSzO5QicvJuXgzTdN7v5kBXCR8zhHMBSuoh
/998FIksOhqQwgTRQkEYQ1rikrntDwi3MtCXxzYlvlmTAy/yVcSXVIorhj8POlRp
6EaByPElltjQ87JfSkEkOKXJBBOXT0RadK7jb9AP0HyYKJDN1SzpQyRvU/I4xWPh
15I5AF1id/Rjeevr0ijxYwEW6M4eQvnrp22xQAzQB7/VvxZfFTpGAy1RvBU7ra5c
ypUPXpgnf1PBcKKBhMCeoZ1yMWxjt44inS3NlqVlDayTYX44qN7iq4/dh6t+yP2W
+GuYuymVG+IpAzVlUujBA4sqYflrjKEbLKr0NSfTPy4Vd0ZzPy8XDIMBfOGCKWTq
UqLERM7G
=gMU2
-----END PGP SIGNATURE-----

--=_MailMate_63B93A24-0490-4581-80CA-48FD21CAB638_=--
