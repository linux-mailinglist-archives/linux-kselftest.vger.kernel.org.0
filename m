Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93062B0BCE
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 18:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgKLR51 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 12:57:27 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4023 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgKLR50 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 12:57:26 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad778a0000>; Thu, 12 Nov 2020 09:57:30 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 17:57:25 +0000
Subject: Re: [RFC PATCH 3/6] mm: page_owner: add support for splitting to any
 order in split page_owner.
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
 <20201111204008.21332-4-zi.yan@sent.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <9e8f5412-d79a-7679-da96-35efa5b50684@nvidia.com>
Date:   Thu, 12 Nov 2020 09:57:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201111204008.21332-4-zi.yan@sent.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605203850; bh=mGWXjXjx6nN4VCp4b3nS3EQf9h38cnzx5dq9EA3WeRo=;
        h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=KKaPViKLEpaxImwh9/hwdwCh/ORv7USH1okXMX3AuC+H+qvx61QWR+bV+mySBUt6D
         YW3HQ6BgzrdOt9ytKlLgSa3IbmO0o9AQXMcShGr2ApKVdxZaZl33S2bnYbOapQ/osI
         jtYXAHHWXcWg3xxeWwJuGNs8l+ZbakULWkBHemFdE3Thcbt+jwAymZhjEzvLofbabh
         29lMmf6M12wXUNFtnMnh8z43KMTrjfPU/YjzGjsDzuCArSQspTw4xg5n7KQJ9FXvJJ
         3F1eZqbSsMq5uTlFwEfqJZbLAyixj8N7kMoscdpt2IFr3cRlqvKT+zclr8xu4pLRYq
         LTG4kwIHgh3uw==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/11/20 12:40 PM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It adds a new_order parameter to set new page order in page owner.
> It prepares for upcoming changes to support split huge page to any lower
> order.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Except for a minor fix below, you can add:
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   include/linux/page_owner.h | 7 ++++---
>   mm/huge_memory.c           | 2 +-
>   mm/page_alloc.c            | 2 +-
>   mm/page_owner.c            | 6 +++---
>   4 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
> index 3468794f83d2..215cbb159568 100644
> --- a/include/linux/page_owner.h
> +++ b/include/linux/page_owner.h
> @@ -31,10 +31,11 @@ static inline void set_page_owner(struct page *page,
>   		__set_page_owner(page, order, gfp_mask);
>   }
>   
> -static inline void split_page_owner(struct page *page, unsigned int nr)
> +static inline void split_page_owner(struct page *page, unsigned int nr,
> +			unsigned int new_order)
>   {
>   	if (static_branch_unlikely(&page_owner_inited))
> -		__split_page_owner(page, nr);
> +		__split_page_owner(page, nr, new_order);
>   }
>   static inline void copy_page_owner(struct page *oldpage, struct page *newpage)
>   {
> @@ -60,7 +61,7 @@ static inline void set_page_owner(struct page *page,
>   {
>   }
>   static inline void split_page_owner(struct page *page,
> -			unsigned int order)
> +			unsigned int nr, unsigned int new_order)
>   {
>   }
>   static inline void copy_page_owner(struct page *oldpage, struct page *newpage)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f599f5b9bf7f..8b7d771ee962 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2459,7 +2459,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   
>   	ClearPageCompound(head);
>   
> -	split_page_owner(head, nr);
> +	split_page_owner(head, nr, 1);

Shouldn't this be 0, not 1?
(new_order not new_nr).

>   	/* See comment in __split_huge_page_tail() */
>   	if (PageAnon(head)) {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d77220615fd5..a9eead0e091a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3284,7 +3284,7 @@ void split_page(struct page *page, unsigned int order)
>   
>   	for (i = 1; i < (1 << order); i++)
>   		set_page_refcounted(page + i);
> -	split_page_owner(page, 1 << order);
> +	split_page_owner(page, 1 << order, 1);

Ditto, 0.

>   }
>   EXPORT_SYMBOL_GPL(split_page);

> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index b735a8eafcdb..2b7f7e9056dc 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -204,7 +204,7 @@ void __set_page_owner_migrate_reason(struct page *page, int reason)
>   	page_owner->last_migrate_reason = reason;
>   }
>   
> -void __split_page_owner(struct page *page, unsigned int nr)
> +void __split_page_owner(struct page *page, unsigned int nr, unsigned int new_order)
>   {
>   	int i;
>   	struct page_ext *page_ext = lookup_page_ext(page);
> @@ -213,9 +213,9 @@ void __split_page_owner(struct page *page, unsigned int nr)
>   	if (unlikely(!page_ext))
>   		return;
>   
> -	for (i = 0; i < nr; i++) {
> +	for (i = 0; i < nr; i += (1 << new_order)) {
>   		page_owner = get_page_owner(page_ext);
> -		page_owner->order = 0;
> +		page_owner->order = new_order;
>   		page_ext = page_ext_next(page_ext);
>   	}
>   }
> 
