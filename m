Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC102B29BB
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Nov 2020 01:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKNAPf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Nov 2020 19:15:35 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63390 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbgKNAPb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Nov 2020 19:15:31 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AE0D7hk010840;
        Fri, 13 Nov 2020 16:15:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=2wFkXqJpjzE1kLSTo406/xl725+Y8i76x0UASV8LcK0=;
 b=jPwov3r1v26cQEO8Eqii0sWe620faDx9pq10WuWqzERRhNMHFes9GHTgPBIyx8lSIxsI
 NqUl3Xs1pV44yJueKA5cfms9VtHsRK5oqfT4h+Ix2nJDfN2dmsVBXmZ4urONsFiHwLuP
 YPC4KPIsDZf6+rpGCyprgfE2vchZ5K2UTos= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34sdenxqmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 Nov 2020 16:15:12 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 13 Nov 2020 16:15:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcVjjOYR3b+Htb7fh9zz8fTgb5neVPhr48DRk2uJLt7Qg/Vkm68m8psbZRdOz4De26zAWPVZxxlI6Rd0L1hapKFlg2eAXGT/nyoihmc1Q/Z07/9TBcOUffovCBYP10RGvepYn0i9CboiPA8AyRCElGk7zODHO7ir+BG9pLf0I7Si+emfKN5OMKUfZ/vYyW4guTdbggrO3gAtrTcrD4752psNTNJAiyRXv9ChpBSU5ka7i+K42U+SlbIgLZatvZ+aiVbK4LMcs3S/qKGhXz4EPvRqnR2MeN3JRRzvtPNZ/8Ox8lmjKUVoCnhneVgU3+P4hICeaLTwfaA7XmqPMLQuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wFkXqJpjzE1kLSTo406/xl725+Y8i76x0UASV8LcK0=;
 b=ikY2JmtkaBwlQ/iu7DaRxtP3G6HA7FHw2/u/x2mKeufybCKfKVrOU5b3Oqmu/Ktg6q/7o3/2ixSHnsDVaBm3yRmHrgfUqJC9ziUuhOSknwYKYLTNzl5FUer78S39YoTbj+eCdz744TOgKp1iPtJdXhWu43mIseRoAy0Wc57+mrO6UjJOL8lI3AZwvDAGgPghV7ZxktyewQoE9/k8zq/QcBo481ChdJFA/fFO33l08VObGoRUdK2s50pRibteaiXt4pfM4eTcEb9Qf+bc72dUVJU1p0xFRurlxw/oPnTp5dRuOCMECUKCbaoCaNCppoYGfXA4ifrbvMqP4kUdtxSfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wFkXqJpjzE1kLSTo406/xl725+Y8i76x0UASV8LcK0=;
 b=ZGCICE2AeiH4/Uf4PtKXKVAJMKXaQtpGbkxiFffgL0GuzlVP4aGTvxSFFHwpfg9Kqu4If+nreVeEsfVVKj7eA5JgjWypZ3WsiatUmPw5TSfly0uLn7pIYyqFTErXldf/zNQFFhZNz4TcNxU1RRWywjBMN22Q4KoAV8sLhcqnKoU=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2982.namprd15.prod.outlook.com (2603:10b6:a03:f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sat, 14 Nov
 2020 00:15:10 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3564.025; Sat, 14 Nov 2020
 00:15:10 +0000
Date:   Fri, 13 Nov 2020 16:15:05 -0800
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
Subject: Re: [RFC PATCH 3/6] mm: page_owner: add support for splitting to any
 order in split page_owner.
Message-ID: <20201114001505.GA3047204@carbon.dhcp.thefacebook.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-4-zi.yan@sent.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111204008.21332-4-zi.yan@sent.com>
X-Originating-IP: [2620:10d:c090:400::5:f0ce]
X-ClientProxiedBy: MWHPR1701CA0007.namprd17.prod.outlook.com
 (2603:10b6:301:14::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:f0ce) by MWHPR1701CA0007.namprd17.prod.outlook.com (2603:10b6:301:14::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Sat, 14 Nov 2020 00:15:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d6ec300-cbb4-46c8-10e8-08d888325928
X-MS-TrafficTypeDiagnostic: BYAPR15MB2982:
X-Microsoft-Antispam-PRVS: <BYAPR15MB29823FCF038628A8607F98D4BEE50@BYAPR15MB2982.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxpb9jXZctvIQ6X9/t4qwvt6tfw0G/s7hR0O0lIlhvr+Hl0k12JAxxPGX1laHu+pw/T/52KY44D2R+I6MZxdc8dZJ8KYwvHZhwzwzr3lFvLXp6gaElFSHXcVlh8SDwLPHiDvh6ax18vYLP69EgMqkOWVMzhY3q4IqNRHaoDs/FUiuulvSvNEvzpeGKAMf0Rtq6i/AzqMrzWxCb/FcpC3fiGdMEc7TV5ciH2pjl1Wtsv6F3uue+OeSZmP74/f4NhfYjzEcppuJZr8chy4WFZsq3ADJpuL97oayDwyLWxqgoBXcaTqG0dv7B3GYu2neChnTLfr5xtrEVSZ5fGf5OiZFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(136003)(366004)(396003)(2906002)(86362001)(8936002)(316002)(5660300002)(66476007)(66556008)(6666004)(83380400001)(8676002)(66946007)(33656002)(7696005)(6916009)(4326008)(52116002)(186003)(16526019)(7416002)(54906003)(55016002)(6506007)(9686003)(1076003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: r9qLdex/ybBLoQUJvLHd5qLxKTohvanOQ9SzWRESot1YQzPPQWTtQw1QETEwM5o6lGZ4NhcV0M6ZY5y2LUMvDXAub3KdwwxIZUq66CNoEbuTYK9y5GsWW5W6MZDMJObNyktQAi82adHdgbAScotosFAgo/AMHYHWN08gK6PlgmYn/JCBYuIX+LLAhK8BpQlj/MoWZFoP9HR2OYWVM1OxfPY26Qs3usZse7xFoO+Hdn+/NoGnX2+xRwJPwM4neJNHoThAjSj52G8PUwyOOCP1+GsS3EaN8jFqPUBJgJZ4lWaFKE+vqdufb+zT0eLTrZX3jEyPYpAz1k7CqXLc5xrxSK6j9p4PbgCtNkTWAs4U57T4MTpaKuIMlzW1LI9Pi8MsnPJDTtzxPumoiYqcX7009jEuPxxZiz49jNCPOVojdjb6bwoziZoN/QgqFhP4T4StY7DKKdsCTBA58UAZ/3Ph+h5tfAAlCsPyHOGvZTllvCQjJyrfnleaJsBzfStuIzI/QBAq5rtD3/9Y97rE4pMA21NEZYTEYRB3vZgY+kvEgwC1vWXCblkebpO78m7B2nTMUJ5TgSplqci+jI9GBdqLrkzRzB2IVOQezHzN/Q6PPiOErpTkkHCh8wL+qCMsuVvFZUAgAFK0KJEzUVMp53hvgEgzMNabmkGX2At5xNIJjNE=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6ec300-cbb4-46c8-10e8-08d888325928
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2020 00:15:10.4002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4l1DeJChNBYQE5uUzIRYg9sayqHdIN4Xk09XTXyqOmzQh1H8umoFKL3YvjMO8/7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2982
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_21:2020-11-13,2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 suspectscore=1
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011140000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 11, 2020 at 03:40:05PM -0500, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It adds a new_order parameter to set new page order in page owner.
> It prepares for upcoming changes to support split huge page to any lower
> order.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/page_owner.h | 7 ++++---
>  mm/huge_memory.c           | 2 +-
>  mm/page_alloc.c            | 2 +-
>  mm/page_owner.c            | 6 +++---
>  4 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
> index 3468794f83d2..215cbb159568 100644
> --- a/include/linux/page_owner.h
> +++ b/include/linux/page_owner.h
> @@ -31,10 +31,11 @@ static inline void set_page_owner(struct page *page,
>  		__set_page_owner(page, order, gfp_mask);
>  }
>  
> -static inline void split_page_owner(struct page *page, unsigned int nr)
> +static inline void split_page_owner(struct page *page, unsigned int nr,
> +			unsigned int new_order)
>  {
>  	if (static_branch_unlikely(&page_owner_inited))
> -		__split_page_owner(page, nr);
> +		__split_page_owner(page, nr, new_order);
>  }
>  static inline void copy_page_owner(struct page *oldpage, struct page *newpage)
>  {
> @@ -60,7 +61,7 @@ static inline void set_page_owner(struct page *page,
>  {
>  }
>  static inline void split_page_owner(struct page *page,
> -			unsigned int order)
> +			unsigned int nr, unsigned int new_order)

With the addition of the new argument it's a bit hard to understand
what the function is supposed to do. It seems like nr == page_order(page),
is it right? Maybe we can pass old_order and new_order? Or just the page
and the new order?

>  {
>  }
>  static inline void copy_page_owner(struct page *oldpage, struct page *newpage)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f599f5b9bf7f..8b7d771ee962 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2459,7 +2459,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  
>  	ClearPageCompound(head);
>  
> -	split_page_owner(head, nr);
> +	split_page_owner(head, nr, 1);
>  
>  	/* See comment in __split_huge_page_tail() */
>  	if (PageAnon(head)) {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d77220615fd5..a9eead0e091a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3284,7 +3284,7 @@ void split_page(struct page *page, unsigned int order)
>  
>  	for (i = 1; i < (1 << order); i++)
>  		set_page_refcounted(page + i);
> -	split_page_owner(page, 1 << order);
> +	split_page_owner(page, 1 << order, 1);
>  }
>  EXPORT_SYMBOL_GPL(split_page);
>  
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index b735a8eafcdb..2b7f7e9056dc 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -204,7 +204,7 @@ void __set_page_owner_migrate_reason(struct page *page, int reason)
>  	page_owner->last_migrate_reason = reason;
>  }
>  
> -void __split_page_owner(struct page *page, unsigned int nr)
> +void __split_page_owner(struct page *page, unsigned int nr, unsigned int new_order)
>  {
>  	int i;
>  	struct page_ext *page_ext = lookup_page_ext(page);
> @@ -213,9 +213,9 @@ void __split_page_owner(struct page *page, unsigned int nr)
>  	if (unlikely(!page_ext))
>  		return;
>  
> -	for (i = 0; i < nr; i++) {
> +	for (i = 0; i < nr; i += (1 << new_order)) {
>  		page_owner = get_page_owner(page_ext);
> -		page_owner->order = 0;
> +		page_owner->order = new_order;
>  		page_ext = page_ext_next(page_ext);

I believe there cannot be any leftovers because nr is always a power of 2.
Is it true? Converting nr argument to order (if it's possible) will make it obvious.

Other than that the patch looks good to me.

Thanks!
