Return-Path: <linux-kselftest+bounces-26695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A30A367EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 23:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD7F3AF242
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 22:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BE51FC10E;
	Fri, 14 Feb 2025 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qy+tUyoP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19551FBEAF
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Feb 2025 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739570404; cv=none; b=o/orL6A5XKOdoTKhfTdElT/NGtqUNvrPI3iF7+F3A4ufqNpP3rvM/fjIIobdnpbxMeHcRk2JHqJYlSTRORqXMj6Jv90f+iEdCclcNwIASmeLe0QRWtWgNw1QiGledz/NsXoXWxHYBT4BHekPY8Lx/Uqv88J9Rq7tux7lvZMjlRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739570404; c=relaxed/simple;
	bh=aK6nlOumBwwBE8fp0+hFXtCE3Vt5FrP5EL6BMMIp2bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9eQgd6H4QnXgtyWWlbQ6j7V17ccnch8cWd19CsxHZ36hfAnPyVMMqeXDiQGj9laFwpx8yTATXtEma3Ua9s3oiqbWXkmYkwaFRZ1q2VqEWNVQRAAfrTgMgnQpf37UhmdzVxaSuOKTXpY8kHxh0AwPmfc+MmCfHcrsjG+kbwQ88Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qy+tUyoP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739570399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1UXxy6mQxDzeF30KOcZxZ8FOown0bDjggxUSAN6E34g=;
	b=Qy+tUyoPndDQOJq4/SsN4ve/u+xMGU8mwj/80/se+wan+ZudgikKW072+MaUAkP2dUpZCb
	NLyXPOb1YNK9pzy/yAYGF9PQNlJ6YiVGzVsBlqsqGg3Ut2DYW60s9Vs5q9cASDhyWdpXX4
	+sHnvqKOH26sMWd4W3xixtr8VRjFE58=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-mPzaDPNqO4mOd8IZe3DqSg-1; Fri, 14 Feb 2025 16:59:55 -0500
X-MC-Unique: mPzaDPNqO4mOd8IZe3DqSg-1
X-Mimecast-MFC-AGG-ID: mPzaDPNqO4mOd8IZe3DqSg_1739570393
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-439640a1a8dso11718425e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Feb 2025 13:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739570393; x=1740175193;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1UXxy6mQxDzeF30KOcZxZ8FOown0bDjggxUSAN6E34g=;
        b=UoLQfoyKaqkWxd+6Iy2y/DvhsdhLdt5lmlnLI0vdkzBS8+/TZDNXtj1JIrVz9gxbqC
         omA1S+sqtZXZTOZc4XEya5HORyFBZJ+quTBstmNFpeuf/YpxBcxNN848ItI7msiE1pcV
         yFE/oQtwzdWM9YmsMAaf/InXbd2P2gstM/EhVICSk4dplJxVtrDx7rciNzHtwrUPleSb
         r3+fwTKfV0EKb1R4oZblUjYPALHl9I8lXbtw4hVwVbSHnFqjU3Y0NP35Gb8XIGI6iKiT
         8qtDC6p7uHpaZDOqGq9hCm7Y2h9s1efLaasgyNNV/MthUSSfU8clEOuakVRjVz/ndDuz
         Kj1A==
X-Forwarded-Encrypted: i=1; AJvYcCUskT5R/CB5xp50JhnA1jINnbelcPQN9kSQIO4bhzUz3xiCuhqIvAIjFYBGv7qpJl4FPBMItjyLRNk1txG3jRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydL5O5vB/In+5g4xkwZUOsqZLOX9CKtzCfyTnsBBZ0u1yhToPb
	uGNJkmXkTNVPmXT78lJONkw8UFdR60JaaaFpAGHwjhDdEUxwsz2iCDnRfsW5IqkRh58+WuKMzXJ
	t4tVcyWGkh0TUddqdbM1ubsiXlBlO7acUbLnm0gwtphsBwaus0vMZiWY+fSGAER4MBA==
X-Gm-Gg: ASbGncu+cAJQjl8i4Las31D+YO0257A/ZoKSb3SKvUy7YsfiouX4wllr3vjWsNhoMYf
	1b40hKlp9rBCw4orFnbzKFmG4WN6X8pzfHqEKOvs01HB0I+oS+HxlEG6T/l/Q/YbFBabMuVZFAR
	ZTaiMiFJFIEMhpAAeV/xe17Ds0on+QyYMdo4RZZj3AUjc/vDzVKXkxoHSIJz1GHoSwb8ZIrGb92
	JqyP2GFDeTw9TLUmNJWPVsxToBkDS10D+pic6jj6mieXZyFEA/L0EQMmWgUkdTyPHs7r/okv74t
	soAI6G4i1QpfaWMlpry2htTTxwj6PLwJHNWcZAXyuWmAlnaeNks4TY+YhdKQExmYrfHiBdhUIK5
	3fFcCrnx+tt/j44lNFIcXozn6XIOn8c0y
X-Received: by 2002:a05:600c:1c97:b0:439:403a:6b77 with SMTP id 5b1f17b1804b1-4396e6c944dmr11952325e9.10.1739570393131;
        Fri, 14 Feb 2025 13:59:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2oEBu1OS6oJJ34rUUqc1BPOBx9m8tNT2xQLLSgNg9HQNPbmC+/jnLVSFbyq6TTxeC5btulw==
X-Received: by 2002:a05:600c:1c97:b0:439:403a:6b77 with SMTP id 5b1f17b1804b1-4396e6c944dmr11952055e9.10.1739570392683;
        Fri, 14 Feb 2025 13:59:52 -0800 (PST)
Received: from ?IPV6:2003:d8:2f22:1000:d72d:fd5f:4118:c70b? (p200300d82f221000d72dfd5f4118c70b.dip0.t-ipconnect.de. [2003:d8:2f22:1000:d72d:fd5f:4118:c70b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06da56sm85991305e9.23.2025.02.14.13.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 13:59:51 -0800 (PST)
Message-ID: <db77d017-4a1e-4a47-9064-e335cb0313af@redhat.com>
Date: Fri, 14 Feb 2025 22:59:50 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250211155034.268962-1-ziy@nvidia.com>
 <20250211155034.268962-3-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250211155034.268962-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.02.25 16:50, Zi Yan wrote:
> This is a preparation patch, both added functions are not used yet.
> 
> The added __split_unmapped_folio() is able to split a folio with
> its mapping removed in two manners: 1) uniform split (the existing way),
> and 2) buddy allocator like split.
> 
> The added __split_folio_to_order() can split a folio into any lower order.
> For uniform split, __split_unmapped_folio() calls it once to split
> the given folio to the new order. For buddy allocator split,
> __split_unmapped_folio() calls it (folio_order - new_order) times
> and each time splits the folio containing the given page to one lower
> order.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/huge_memory.c | 349 ++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 348 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a0277f4154c2..12d3f515c408 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3262,7 +3262,6 @@ static void remap_page(struct folio *folio, unsigned long nr, int flags)
>   static void lru_add_page_tail(struct folio *folio, struct page *tail,
>   		struct lruvec *lruvec, struct list_head *list)
>   {
> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>   	VM_BUG_ON_FOLIO(PageLRU(tail), folio);
>   	lockdep_assert_held(&lruvec->lru_lock);
>   
> @@ -3506,6 +3505,354 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
>   					caller_pins;
>   }
>   
> +/*
> + * It splits @folio into @new_order folios and copies the @folio metadata to
> + * all the resulting folios.
> + */
> +static int __split_folio_to_order(struct folio *folio, int new_order)
> +{
> +	int curr_order = folio_order(folio);
> +	long nr_pages = folio_nr_pages(folio);
> +	long new_nr_pages = 1 << new_order;
> +	long index;
> +
> +	if (curr_order <= new_order)
> +		return -EINVAL;
> +
> +	/*
> +	 * Skip the first new_nr_pages, since the new folio from them have all
> +	 * the flags from the original folio.
> +	 */
> +	for (index = new_nr_pages; index < nr_pages; index += new_nr_pages) {
> +		struct page *head = &folio->page;
> +		struct page *new_head = head + index;
> +
> +		/*
> +		 * Careful: new_folio is not a "real" folio before we cleared PageTail.
> +		 * Don't pass it around before clear_compound_head().
> +		 */
> +		struct folio *new_folio = (struct folio *)new_head;
> +
> +		VM_BUG_ON_PAGE(atomic_read(&new_head->_mapcount) != -1, new_head);
> +
> +		/*
> +		 * Clone page flags before unfreezing refcount.
> +		 *
> +		 * After successful get_page_unless_zero() might follow flags change,
> +		 * for example lock_page() which set PG_waiters.
> +		 *
> +		 * Note that for mapped sub-pages of an anonymous THP,
> +		 * PG_anon_exclusive has been cleared in unmap_folio() and is stored in
> +		 * the migration entry instead from where remap_page() will restore it.
> +		 * We can still have PG_anon_exclusive set on effectively unmapped and
> +		 * unreferenced sub-pages of an anonymous THP: we can simply drop
> +		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
> +		 */
> +		new_head->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
> +		new_head->flags |= (head->flags &
> +				((1L << PG_referenced) |
> +				 (1L << PG_swapbacked) |
> +				 (1L << PG_swapcache) |
> +				 (1L << PG_mlocked) |
> +				 (1L << PG_uptodate) |
> +				 (1L << PG_active) |
> +				 (1L << PG_workingset) |
> +				 (1L << PG_locked) |
> +				 (1L << PG_unevictable) |
> +#ifdef CONFIG_ARCH_USES_PG_ARCH_2
> +				 (1L << PG_arch_2) |
> +#endif
> +#ifdef CONFIG_ARCH_USES_PG_ARCH_3
> +				 (1L << PG_arch_3) |
> +#endif
> +				 (1L << PG_dirty) |
> +				 LRU_GEN_MASK | LRU_REFS_MASK));
> +
> +		/* ->mapping in first and second tail page is replaced by other uses */
> +		VM_BUG_ON_PAGE(new_nr_pages > 2 && new_head->mapping != TAIL_MAPPING,
> +			       new_head);
> +		new_head->mapping = head->mapping;
> +		new_head->index = head->index + index;
> +
> +		/*
> +		 * page->private should not be set in tail pages. Fix up and warn once
> +		 * if private is unexpectedly set.
> +		 */
> +		if (unlikely(new_head->private)) {
> +			VM_WARN_ON_ONCE_PAGE(true, new_head);
> +			new_head->private = 0;
> +		}
> +
> +		if (folio_test_swapcache(folio))
> +			new_folio->swap.val = folio->swap.val + index;
> +
> +		/* Page flags must be visible before we make the page non-compound. */
> +		smp_wmb();
> +
> +		/*
> +		 * Clear PageTail before unfreezing page refcount.
> +		 *
> +		 * After successful get_page_unless_zero() might follow put_page()
> +		 * which needs correct compound_head().
> +		 */
> +		clear_compound_head(new_head);
> +		if (new_order) {
> +			prep_compound_page(new_head, new_order);
> +			folio_set_large_rmappable(new_folio);
> +
> +			folio_set_order(folio, new_order);
> +		}
> +
> +		if (folio_test_young(folio))
> +			folio_set_young(new_folio);
> +		if (folio_test_idle(folio))
> +			folio_set_idle(new_folio);
> +
> +		folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
> +	}
> +
> +	if (!new_order)
> +		ClearPageCompound(&folio->page);
> +
> +	return 0;
> +}
> +
> +/*
> + * It splits an unmapped @folio to lower order smaller folios in two ways.
> + * @folio: the to-be-split folio
> + * @new_order: the smallest order of the after split folios (since buddy
> + *             allocator like split generates folios with orders from @folio's
> + *             order - 1 to new_order).
> + * @page: in buddy allocator like split, the folio containing @page will be
> + *        split until its order becomes @new_order.
> + * @list: the after split folios will be added to @list if it is not NULL,
> + *        otherwise to LRU lists.
> + * @end: the end of the file @folio maps to. -1 if @folio is anonymous memory.
> + * @xas: xa_state pointing to folio->mapping->i_pages and locked by caller
> + * @mapping: @folio->mapping
> + * @uniform_split: if the split is uniform or not (buddy allocator like split)
> + *
> + *
> + * 1. uniform split: the given @folio into multiple @new_order small folios,
> + *    where all small folios have the same order. This is done when
> + *    uniform_split is true.
> + * 2. buddy allocator like (non-uniform) split: the given @folio is split into
> + *    half and one of the half (containing the given page) is split into half
> + *    until the given @page's order becomes @new_order. This is done when
> + *    uniform_split is false.
> + *
> + * The high level flow for these two methods are:
> + * 1. uniform split: a single __split_folio_to_order() is called to split the
> + *    @folio into @new_order, then we traverse all the resulting folios one by
> + *    one in PFN ascending order and perform stats, unfreeze, adding to list,
> + *    and file mapping index operations.
> + * 2. non-uniform split: in general, folio_order - @new_order calls to
> + *    __split_folio_to_order() are made in a for loop to split the @folio
> + *    to one lower order at a time. The resulting small folios are processed
> + *    like what is done during the traversal in 1, except the one containing
> + *    @page, which is split in next for loop.
> + *
> + * After splitting, the caller's folio reference will be transferred to the
> + * folio containing @page. The other folios may be freed if they are not mapped.
> + *
> + * In terms of locking, after splitting,
> + * 1. uniform split leaves @page (or the folio contains it) locked;
> + * 2. buddy allocator like (non-uniform) split leaves @folio locked.
> + *
> + *
> + * For !uniform_split, when -ENOMEM is returned, the original folio might be
> + * split. The caller needs to check the input folio.
> + */
> +static int __split_unmapped_folio(struct folio *folio, int new_order,
> +		struct page *page, struct list_head *list, pgoff_t end,
> +		struct xa_state *xas, struct address_space *mapping,
> +		bool uniform_split)
> +{
> +	struct lruvec *lruvec;
> +	struct address_space *swap_cache = NULL;
> +	struct folio *origin_folio = folio;
> +	struct folio *next_folio = folio_next(folio);
> +	struct folio *new_folio;
> +	struct folio *next;
> +	int order = folio_order(folio);
> +	int split_order;
> +	int start_order = uniform_split ? new_order : order - 1;
> +	int nr_dropped = 0;
> +	int ret = 0;
> +	bool stop_split = false;
> +
> +	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
> +		/* a swapcache folio can only be uniformly split to order-0 */
> +		if (!uniform_split || new_order != 0)
> +			return -EINVAL;
> +
> +		swap_cache = swap_address_space(folio->swap);
> +		xa_lock(&swap_cache->i_pages);
> +	}
> +
> +	if (folio_test_anon(folio))
> +		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> +
> +	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> +	lruvec = folio_lruvec_lock(folio);
> +
> +	folio_clear_has_hwpoisoned(folio);
> +
> +	/*
> +	 * split to new_order one order at a time. For uniform split,
> +	 * folio is split to new_order directly.
> +	 */
> +	for (split_order = start_order;
> +	     split_order >= new_order && !stop_split;
> +	     split_order--) {
> +		int old_order = folio_order(folio);
> +		struct folio *release;
> +		struct folio *end_folio = folio_next(folio);
> +		int status;
> +
> +		/* order-1 anonymous folio is not supported */
> +		if (folio_test_anon(folio) && split_order == 1)
> +			continue;
> +		if (uniform_split && split_order != new_order)
> +			continue;
> +
> +		if (mapping) {
> +			/*
> +			 * uniform split has xas_split_alloc() called before
> +			 * irq is disabled to allocate enough memory, whereas
> +			 * non-uniform split can handle ENOMEM.
> +			 */
> +			if (uniform_split)
> +				xas_split(xas, folio, old_order);
> +			else {
> +				xas_set_order(xas, folio->index, split_order);
> +				xas_try_split(xas, folio, old_order,
> +						GFP_NOWAIT);
> +				if (xas_error(xas)) {
> +					ret = xas_error(xas);
> +					stop_split = true;
> +					goto after_split;
> +				}
> +			}
> +		}
> +
> +		/* complete memcg works before add pages to LRU */
> +		split_page_memcg(&folio->page, old_order, split_order);
> +		split_page_owner(&folio->page, old_order, split_order);
> +		pgalloc_tag_split(folio, old_order, split_order);
> +
> +		status = __split_folio_to_order(folio, split_order);
> +

Stumbling over that code (sorry for the late reply ... ).

That looks weird. We split memcg/owner/pgalloc ... and then figure out 
in __split_folio_to_order() that we don't want to ... split?

Should that all be moved into __split_folio_to_order() and performed 
only when we really want to split?

-- 
Cheers,

David / dhildenb


