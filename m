Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50854E3065
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 20:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352390AbiCUTES (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 15:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346596AbiCUTES (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 15:04:18 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501B36BDC6;
        Mon, 21 Mar 2022 12:02:52 -0700 (PDT)
Date:   Mon, 21 Mar 2022 12:02:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1647889365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HecCqCfvIXy+CaH5mhi+OWHYhER0SlCGtdaZnxXs1SA=;
        b=nWgFSKfQJh8DZT2IfGheY+NaAAu143FVLKzNVNnB22JK/XrLw8mUVyUGIlfkbrtapR0PRU
        GqZdYPBekJz6XfxE4emm1VhGrpHvq2PQ2AVpNXBqjTHmD8N90tdroqNDx6W1+ZV8HM7Ode
        C2Mf3p7NoI+C9MMsbntY0JYik5B+NUQ=
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
Subject: Re: [RFC PATCH 2/5] mm: page_owner: add support for splitting to any
 order in split page_owner.
Message-ID: <YjjLzvT2if2JDbGE@carbon.dhcp.thefacebook.com>
References: <20220321142128.2471199-1-zi.yan@sent.com>
 <20220321142128.2471199-3-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321142128.2471199-3-zi.yan@sent.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 21, 2022 at 10:21:25AM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It adds a new_order parameter to set new page order in page owner and
> uses old_order instead of nr to make the parameters look consistent.
> It prepares for upcoming changes to support split huge page to any
> lower order.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/page_owner.h | 12 +++++++-----
>  mm/huge_memory.c           |  3 ++-
>  mm/page_alloc.c            |  2 +-
>  mm/page_owner.c            | 13 +++++++------
>  4 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
> index 119a0c9d2a8b..16050cc89274 100644
> --- a/include/linux/page_owner.h
> +++ b/include/linux/page_owner.h
> @@ -11,7 +11,8 @@ extern struct page_ext_operations page_owner_ops;
>  extern void __reset_page_owner(struct page *page, unsigned short order);
>  extern void __set_page_owner(struct page *page,
>  			unsigned short order, gfp_t gfp_mask);
> -extern void __split_page_owner(struct page *page, unsigned int nr);
> +extern void __split_page_owner(struct page *page, unsigned short old_order,
> +			unsigned short new_order);

Unsigned short here,

>  extern void __folio_copy_owner(struct folio *newfolio, struct folio *old);
>  extern void __set_page_owner_migrate_reason(struct page *page, int reason);
>  extern void __dump_page_owner(const struct page *page);
> @@ -31,10 +32,11 @@ static inline void set_page_owner(struct page *page,
>  		__set_page_owner(page, order, gfp_mask);
>  }
>  
> -static inline void split_page_owner(struct page *page, unsigned int nr)
> +static inline void split_page_owner(struct page *page, unsigned int old_order,
> +			unsigned int new_order)

but unsigned int here.

>  {
>  	if (static_branch_unlikely(&page_owner_inited))
> -		__split_page_owner(page, nr);
> +		__split_page_owner(page, old_order, new_order);
>  }
>  static inline void folio_copy_owner(struct folio *newfolio, struct folio *old)
>  {
> @@ -56,11 +58,11 @@ static inline void reset_page_owner(struct page *page, unsigned short order)
>  {
>  }
>  static inline void set_page_owner(struct page *page,
> -			unsigned int order, gfp_t gfp_mask)
> +			unsigned short order, gfp_t gfp_mask)
>  {
>  }
>  static inline void split_page_owner(struct page *page,
> -			unsigned short order)
> +			unsigned short old_order, unsigned short new_order)
>  {
>  }
>  static inline void folio_copy_owner(struct folio *newfolio, struct folio *folio)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 640040c386f0..fcfa46af6c4c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2367,6 +2367,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	struct lruvec *lruvec;
>  	struct address_space *swap_cache = NULL;
>  	unsigned long offset = 0;
> +	unsigned int order = thp_order(head);
>  	unsigned int nr = thp_nr_pages(head);
>  	int i;
>  
> @@ -2408,7 +2409,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	unlock_page_lruvec(lruvec);
>  	/* Caller disabled irqs, so they are still disabled here */
>  
> -	split_page_owner(head, nr);
> +	split_page_owner(head, order, 0);
>  
>  	/* See comment in __split_huge_page_tail() */
>  	if (PageAnon(head)) {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d982919b9e51..9cac40c26c58 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3514,7 +3514,7 @@ void split_page(struct page *page, unsigned int order)
>  
>  	for (i = 1; i < (1 << order); i++)
>  		set_page_refcounted(page + i);
> -	split_page_owner(page, 1 << order);
> +	split_page_owner(page, order, 0);
>  	split_page_memcg(page, 1 << order, 0);
>  }
>  EXPORT_SYMBOL_GPL(split_page);
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 0a9588506571..52013c846d19 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -202,19 +202,20 @@ void __set_page_owner_migrate_reason(struct page *page, int reason)
>  	page_owner->last_migrate_reason = reason;
>  }
>  
> -void __split_page_owner(struct page *page, unsigned int nr)
> +void __split_page_owner(struct page *page, unsigned short old_order,
> +			unsigned short new_order)

And short again here. Please, make it consistent.

Other than that, looks good to me. Please, feel free to add
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
after fixing the type inconsistency.

Thank you!
