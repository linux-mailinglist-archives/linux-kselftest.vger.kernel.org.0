Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1742B0BD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 18:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgKLR6h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 12:58:37 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15531 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgKLR6g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 12:58:36 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad77c60003>; Thu, 12 Nov 2020 09:58:30 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 17:58:32 +0000
Subject: Re: [RFC PATCH 2/6] mm: memcg: make memcg huge page split support any
 order split.
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
 <20201111204008.21332-3-zi.yan@sent.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <021b000f-dfc9-59fc-77e4-fdeaee1c108e@nvidia.com>
Date:   Thu, 12 Nov 2020 09:58:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201111204008.21332-3-zi.yan@sent.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605203910; bh=mo4zzPeTclJa4REBjpKyto1Jte0H5cbXgM268bgYOOs=;
        h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=G/Xrg7dGj13QYBvaEftMU91cOiZYbAaF91IuPDmZVpPev8LYULjmPLQDCJL9aM3y3
         pzFuuRabki4JyNuwkXb9UUOCG3UVE153K88EMJ9/18qVEtQP2ucEmLHJA4FBK3Ju8k
         RFEH6Y34H9UDHZlHiupOyfBf5g/sZkgitnulKEThOTW2zn36iJVOo7VLlgsK0KU8HP
         vQwO0ZO+Ds2ZkoDbeqSGkU837eolrtQMu8VOsuv5yaB75+74Ons24GdE1kxPBdAWb4
         J2MKjfzKYuoHsnNcZdkCcmfwHIKTQu6ep2HbC/IkdoxD8BNdtJ+S2Dvad1SecgFLYl
         D+AXAu2SzSrCA==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/11/20 12:40 PM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It reads thp_nr_pages and splits to provided new_nr. It prepares for
> upcoming changes to support split huge page to any lower order.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Looks OK to me.
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   include/linux/memcontrol.h | 5 +++--
>   mm/huge_memory.c           | 2 +-
>   mm/memcontrol.c            | 4 ++--
>   3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0f4dd7829fb2..b3bac79ceed6 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1105,7 +1105,7 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>   }
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -void mem_cgroup_split_huge_fixup(struct page *head);
> +void mem_cgroup_split_huge_fixup(struct page *head, unsigned int new_nr);
>   #endif
>   
>   #else /* CONFIG_MEMCG */
> @@ -1451,7 +1451,8 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>   	return 0;
>   }
>   
> -static inline void mem_cgroup_split_huge_fixup(struct page *head)
> +static inline void mem_cgroup_split_huge_fixup(struct page *head,
> +					       unsigned int new_nr)
>   {
>   }
>   
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c4fead5ead31..f599f5b9bf7f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2429,7 +2429,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   	lruvec = mem_cgroup_page_lruvec(head, pgdat);
>   
>   	/* complete memcg works before add pages to LRU */
> -	mem_cgroup_split_huge_fixup(head);
> +	mem_cgroup_split_huge_fixup(head, 1);
>   
>   	if (PageAnon(head) && PageSwapCache(head)) {
>   		swp_entry_t entry = { .val = page_private(head) };
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 33f632689cee..e9705ba6bbcc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3247,7 +3247,7 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
>    * Because tail pages are not marked as "used", set it. We're under
>    * pgdat->lru_lock and migration entries setup in all page mappings.
>    */
> -void mem_cgroup_split_huge_fixup(struct page *head)
> +void mem_cgroup_split_huge_fixup(struct page *head, unsigned int new_nr)
>   {
>   	struct mem_cgroup *memcg = page_memcg(head);
>   	int i;
> @@ -3255,7 +3255,7 @@ void mem_cgroup_split_huge_fixup(struct page *head)
>   	if (mem_cgroup_disabled())
>   		return;
>   
> -	for (i = 1; i < thp_nr_pages(head); i++) {
> +	for (i = new_nr; i < thp_nr_pages(head); i += new_nr) {
>   		css_get(&memcg->css);
>   		head[i].memcg_data = (unsigned long)memcg;
>   	}
> 
