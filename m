Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEC92B2A27
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Nov 2020 01:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgKNAxG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Nov 2020 19:53:06 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40928 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgKNAxF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Nov 2020 19:53:05 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AE0pjDk007982;
        Fri, 13 Nov 2020 16:52:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Ky1+bqTc5fCMh4rnMC2UQ8OlnhFItalNO6VL/LO/9bY=;
 b=DUFpOMc8sk3PxjBkNwJ6lCCSzy2vXWhf20+/wd97LeUsUzVxGdpPxg5TJtLowAgdP7Cj
 DYHiUX3Why+GpWgCG8v7d8+SzDDOS4I/4Ce+7uR9ncK7/wilC2KFq3AoV4BssHBngad4
 0lkkKWvPnuEAYB5PZqxvQW3LaYS3aZLlKaY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34s7dt1a15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 Nov 2020 16:52:56 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 13 Nov 2020 16:52:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnGRWAJIvPT7yubTrc+i1SIbm2c7eFMbj5KftM00YZBb3D3TlA65kkmkbs/quKuSu3lCR/7OmA35FddhE35AQgm8Wugg76wgFDGoXog2X7TI1+IIXLOxUkscTiVA19ybVwqcguePvrYcC4vp4P5L6dwXXqkRBWHkOQfL/z+phv/8KjJ10y8y8CTUd3Q4+hsQtZZheTlv8yY6Ip/lz+ScHTEmh+JzJxfXAf130z1PzkbQSFZDvpsLELoj8tuw9qtBE3CSNUu65S007cIco07Xyz1DKT6zt7T877yQ3KyCNHg2mGTAQGlnjXcMFoGXM9UirOlL4xg8qffxRsvYrUqc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky1+bqTc5fCMh4rnMC2UQ8OlnhFItalNO6VL/LO/9bY=;
 b=VAHDQqmxtKhtolNK2YYYG+J3yZjH4lBTmplXjRddypLPmy8bewZgK0FWFaaesc2ASVwOVsLEpDM2e5zVEqPTKf/09ibPDLSrPUIoaudKabdnfxnQCUSnduoEmwtGKYTDD2RajuJCq7FnhrQlFRVY2akv3rdHEMq1S2YO/zSFaBwAULZc3/ioH0zgBzt9ixDL9TuVb1dXxYA2QYAavNbEMMGSMxEt1GeQ8qqjSzI4YDSWVMW0/Szttp+hyuFRL21zZe+NnQknf9PZtHHFJjAc45A7/dbkeAiAPuD+iGBPS88wRBju1jsgo7zDqC9wflmj5YUtm/LJxedzzQ86z2WPsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky1+bqTc5fCMh4rnMC2UQ8OlnhFItalNO6VL/LO/9bY=;
 b=JVpsfHeIU1nTNW2qJ32omEz3NRfDNbxEjI/q+bHMuLx9+daJr4Fh+pVH5BXxTXKnEJueYtKN0EflF8szErp/Hp78XvJNpmdYGADaXpiN8/wzVZF4bsk3eFGz/dgLJ68Nl3UM2T5FmzWGEap2X1vDSlcP9bZ1rAFgyRaNkXK0HoA=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3522.namprd15.prod.outlook.com (2603:10b6:a03:1b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Sat, 14 Nov
 2020 00:52:54 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3564.025; Sat, 14 Nov 2020
 00:52:54 +0000
Date:   Fri, 13 Nov 2020 16:52:49 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Zi Yan <ziy@nvidia.com>
CC:     <linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 4/6] mm: thp: add support for split huge page to any
 lower order pages.
Message-ID: <20201114005249.GC3047204@carbon.dhcp.thefacebook.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-5-zi.yan@sent.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111204008.21332-5-zi.yan@sent.com>
X-Originating-IP: [2620:10d:c090:400::5:a33]
X-ClientProxiedBy: MW2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:907::31)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a33) by MW2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:907::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend Transport; Sat, 14 Nov 2020 00:52:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd6e7738-b6e4-4e9f-7e42-08d888379ecd
X-MS-TrafficTypeDiagnostic: BY5PR15MB3522:
X-Microsoft-Antispam-PRVS: <BY5PR15MB35228366629B1C77B0623FE7BEE50@BY5PR15MB3522.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmJl0i3cRRuhgWQgsz0wQ+OheKPoqj7GhF0JF3xxtsPBXH29QjRRtvgl+E73VWgJG1tyHrtKOJpusBNUPgMmWkjrSdlBFzEvxKtaO3TsakotJlOqpz0pcB9o10tF3fAwvFHatJVEyCTn/H9OS8A/3bf57U6eocYmJ6aIhc9CI62cSAUu4mo7++4ksIx3jrJgNJvzo/a/pX2/eP7k/fDMSIajxnDgf4/tJMv0MbRz+eZ3/Yv8uAlFkNI27Ua0EEhcXmCZTuK2y4eJFnQQg9qFr1FM6w3eK7Z554OesFFkbEeOWEB7TGJFSBsEWdOATXwSuCrFob+RGzqPdZD5+1skGvk+04PvT5fbv/gHPl43+ueRSH8hhivm/yLXmObWGWMt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(396003)(366004)(478600001)(4326008)(55016002)(6666004)(1076003)(86362001)(9686003)(7696005)(66556008)(52116002)(5660300002)(66476007)(6916009)(66946007)(83380400001)(2906002)(8676002)(33656002)(186003)(8936002)(6506007)(54906003)(7416002)(16526019)(316002)(14583001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Ur3CpYcFAlKcf66yYLvZaipT2deGnDkrrc5tIqRpOVY6GrgLqBWkJyLqiJ5VsDvpeOzrjbETFijuT28ADFu4oquxNHLzyVHm8NxGaT9k4Hidl99ao+3XgHVC4KHJNK4dnLMqcGQ5AJyPSNEPyTq6bAFesWnmFx0xtmhhsxfC5x5FCJY3uMLtw4DxahGC4JkFiUIDzyQsHqEuRbcYbWHQ4PVIxfVcgu39UUrl1vJCkiEHWXEOLjlqq38wZ29yq16n/l1FVP1mPsORQjMI/9+3/uhJ4k1YPrWyReVTI8dNiJiABw2F+IBZUmiSQVV1Cj3pXbkbfJtYyPQEFpCpjCbmMoJrxY6wtwkoU1HM0/vrHh3Uvx8JNGT63L5TZydoprtoJUC4Ar+Y3S/jxE1ontwW4yDAEQwlt7xMUpjAB4TAWmlf6Y2DTX0GyxNLKlsjmt5Nt/jq0UhrQjlKSM30LSLZ8xSbJsaGayukNauZ6+HaiB74bkoSke66S23t1b3S6dX+c/7AThk60VoMIpBIMbFWBMsd4qPZ9XcE3jFx4U2yFNarF1AWkwSOLbFc+LqTgcArRyHBw1ntC2K2vBAGmeNDS/Gxdrxr37dbgOKFytOQHDKXMl23rLduVbgOEafv3+NALsU2MsP3g6yUV2cCU55NgU7FiXtQtzJU2chGSdKuEi4=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6e7738-b6e4-4e9f-7e42-08d888379ecd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2020 00:52:54.4849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jXtdfJ/3YPGlO9FOKnBRB5p5zRDVkGmAk4uLIl8BEv1l4WthKpiq1iS9QKfQ9y+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3522
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_21:2020-11-13,2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 suspectscore=1 spamscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011140002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 11, 2020 at 03:40:06PM -0500, Zi Yan wrote:
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
>  include/linux/huge_mm.h |  8 +++++
>  mm/huge_memory.c        | 78 +++++++++++++++++++++++++++++------------
>  mm/swap.c               |  1 -
>  3 files changed, 63 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 60a907a19f7d..9819cd9b4619 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -189,6 +189,8 @@ bool is_transparent_hugepage(struct page *page);
>  
>  bool can_split_huge_page(struct page *page, int *pextra_pins);
>  int split_huge_page_to_list(struct page *page, struct list_head *list);
> +int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> +		unsigned int new_order);
>  static inline int split_huge_page(struct page *page)
>  {
>  	return split_huge_page_to_list(page, NULL);
> @@ -396,6 +398,12 @@ split_huge_page_to_list(struct page *page, struct list_head *list)
>  {
>  	return 0;
>  }
> +static inline int
> +split_huge_page_to_order_to_list(struct page *page, struct list_head *list,
> +		unsigned int new_order)

It was
int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
		unsigned int new_order);
above.


> +{
> +	return 0;
> +}
>  static inline int split_huge_page(struct page *page)
>  {
>  	return 0;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8b7d771ee962..88f50da40c9b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2327,11 +2327,14 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
>  static void unmap_page(struct page *page)
>  {
>  	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS |
> -		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
> +		TTU_RMAP_LOCKED;
>  	bool unmap_success;
>  
>  	VM_BUG_ON_PAGE(!PageHead(page), page);
>  
> +	if (thp_order(page) >= HPAGE_PMD_ORDER)
> +		ttu_flags |= TTU_SPLIT_HUGE_PMD;
> +
>  	if (PageAnon(page))
>  		ttu_flags |= TTU_SPLIT_FREEZE;
>  
> @@ -2339,21 +2342,22 @@ static void unmap_page(struct page *page)
>  	VM_BUG_ON_PAGE(!unmap_success, page);
>  }
>  
> -static void remap_page(struct page *page, unsigned int nr)
> +static void remap_page(struct page *page, unsigned int nr, unsigned int new_nr)
>  {
>  	int i;
> -	if (PageTransHuge(page)) {
> +	if (thp_nr_pages(page) == nr) {
>  		remove_migration_ptes(page, page, true);
>  	} else {
> -		for (i = 0; i < nr; i++)
> +		for (i = 0; i < nr; i += new_nr)
>  			remove_migration_ptes(page + i, page + i, true);
>  	}
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
> @@ -2377,6 +2381,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
>  #ifdef CONFIG_64BIT
>  			 (1L << PG_arch_2) |
>  #endif
> +			 compound_head_flag |
>  			 (1L << PG_dirty)));
>  
>  	/* ->mapping in first tail page is compound_mapcount */
> @@ -2395,10 +2400,15 @@ static void __split_huge_page_tail(struct page *head, int tail,
>  	 * which needs correct compound_head().
>  	 */
>  	clear_compound_head(page_tail);
> +	if (new_order) {
> +		prep_compound_page(page_tail, new_order);
> +		thp_prep(page_tail);
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
> @@ -2416,7 +2426,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
>  }
>  
>  static void __split_huge_page(struct page *page, struct list_head *list,
> -		pgoff_t end, unsigned long flags)
> +		pgoff_t end, unsigned long flags, unsigned int new_order)
>  {
>  	struct page *head = compound_head(page);
>  	pg_data_t *pgdat = page_pgdat(head);
> @@ -2424,12 +2434,13 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	struct address_space *swap_cache = NULL;
>  	unsigned long offset = 0;
>  	unsigned int nr = thp_nr_pages(head);
> +	unsigned int new_nr = 1 << new_order;
>  	int i;
>  
>  	lruvec = mem_cgroup_page_lruvec(head, pgdat);
>  
>  	/* complete memcg works before add pages to LRU */
> -	mem_cgroup_split_huge_fixup(head, 1);
> +	mem_cgroup_split_huge_fixup(head, new_nr);
>  
>  	if (PageAnon(head) && PageSwapCache(head)) {
>  		swp_entry_t entry = { .val = page_private(head) };
> @@ -2439,14 +2450,14 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  		xa_lock(&swap_cache->i_pages);
>  	}
>  
> -	for (i = nr - 1; i >= 1; i--) {
> -		__split_huge_page_tail(head, i, lruvec, list);
> +	for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
> +		__split_huge_page_tail(head, i, lruvec, list, new_order);
>  		/* Some pages can be beyond i_size: drop them from page cache */
>  		if (head[i].index >= end) {
>  			ClearPageDirty(head + i);
>  			__delete_from_page_cache(head + i, NULL);
>  			if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
> -				shmem_uncharge(head->mapping->host, 1);
> +				shmem_uncharge(head->mapping->host, new_nr);
>  			put_page(head + i);
>  		} else if (!PageAnon(page)) {
>  			__xa_store(&head->mapping->i_pages, head[i].index,
> @@ -2457,28 +2468,31 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  		}
>  	}
>  
> -	ClearPageCompound(head);
> +	if (!new_order)
> +		ClearPageCompound(head);
> +	else
> +		set_compound_order(head, new_order);
>  
> -	split_page_owner(head, nr, 1);
> +	split_page_owner(head, nr, new_nr);
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
>  
>  	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>  
> -	remap_page(head, nr);
> +	remap_page(head, nr, new_nr);
>  
>  	if (PageSwapCache(head)) {
>  		swp_entry_t entry = { .val = page_private(head) };
> @@ -2486,7 +2500,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  		split_swap_cluster(entry);
>  	}
>  
> -	for (i = 0; i < nr; i++) {
> +	for (i = 0; i < nr; i += new_nr) {
>  		struct page *subpage = head + i;
>  		if (subpage == page)
>  			continue;
> @@ -2620,21 +2634,39 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
>   * us.
>   */
>  int split_huge_page_to_list(struct page *page, struct list_head *list)
> +{
> +	return split_huge_page_to_list_to_order(page, list, 0);
> +}
> +
> +int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> +				     unsigned int new_order)
>  {
>  	struct page *head = compound_head(page);
>  	struct pglist_data *pgdata = NODE_DATA(page_to_nid(head));
>  	struct deferred_split *ds_queue = get_deferred_split_queue(head);
> -	XA_STATE(xas, &head->mapping->i_pages, head->index);
> +	/* reset xarray order to new order after split */
> +	XA_STATE_ORDER(xas, &head->mapping->i_pages, head->index, new_order);
>  	struct anon_vma *anon_vma = NULL;
>  	struct address_space *mapping = NULL;
>  	int count, mapcount, extra_pins, ret;
>  	unsigned long flags;
>  	pgoff_t end;
>  
> +	VM_BUG_ON(thp_order(head) <= new_order);
>  	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
>  	VM_BUG_ON_PAGE(!PageLocked(head), head);
>  	VM_BUG_ON_PAGE(!PageCompound(head), head);
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

I'd convert those into VM_BUG_ON()'s. Unlikely they will be hit at arbitrary moments
by random users.

Thanks!
