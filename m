Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC33E2B29D0
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Nov 2020 01:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKNAXf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Nov 2020 19:23:35 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47178 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgKNAXf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Nov 2020 19:23:35 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AE093f2023194;
        Fri, 13 Nov 2020 16:23:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=JRr+/gbsmT2o2VyuKpGbFjLHYB/f6BruHRA6EpPFkFo=;
 b=bGQw/mgBg3x53Gt4raD9kLapqzq40+0f1P1v/Jf6aprvOLkW7bnr3YVBeOkTfYQWvfe8
 VMJOZWtyJgpfBJ5A1xoOsOOc9KbxG33t5Yp1Vz0bXD9hba4fzPi3el0mgYRWn81BGXL8
 ns6y6zKuRwtKA4qpVFcEhUmAiPdEQSj0mv4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34seqpebgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 Nov 2020 16:23:26 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 13 Nov 2020 16:23:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TADs9EpZ8hdyMMSTJ0ypCeqMMIxf4gtv8JW8nLYWXObghb4HPLZsYz1aSU5zW4BUL3GGVotmDFFQzS6Gt92cP6pD8MPSyjkJG9OE80c9Se2J/L4r+hgAyqSD/V7oFJDB8UPqxOQ7MdIdim3fBzSW/EknAJdoNKmyBMWSx4UOdySOGGnF6OPOAYr7AxPT9FVWYzp30mEbRGDVUnevMnuKBLdDII9isnzwapOYQfUHMTG+5+8b/+by3BCzfj2ic7aaHxh0giInCrjfaSLuQDG/L6oShlLNSB/0oXInEHTi/MidZnc+EbHYUy2xly7uGBtkRnUxEt/ViayqlNUBxmWfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRr+/gbsmT2o2VyuKpGbFjLHYB/f6BruHRA6EpPFkFo=;
 b=Bb5a9RnQFCdDglB8fBHEvQvX9c1CwUfJLxlpnIT6wQq5VJJl6f+dSjJbxoOWn0fmbz4FbA9UhQGP0xeXSa7W78RCVqbfHo2mTwLvkNstjGFygYEdqJu0LQpxfO/wZhH3LmbVeyj+3PQCuf0WcyiPz55ELJPLjkDk7ulrkfVGMKO2DoHdlm1nFNUCQFLWObpLR71y56Dv4RXtrxGGMt4+Jz2/AVoO9voSfOVDCcOWzcPkGgiKi7M4j1rXd2GF6Pc8eqDM+Htil1bhZKog0wu3N6p4tHNb1KmNKKaPKVDjkqRmW9VrCa26xVvQ9Wl9SCBp1BFvOXe0VM5mS1jR2fvPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRr+/gbsmT2o2VyuKpGbFjLHYB/f6BruHRA6EpPFkFo=;
 b=TqgFkcUSWaowhnIdczL/nOe5rAWHkRBkXgfY6otDvWUmQ0zZcbAV5hzEA59Eqc4kWVGxu8Bwit/Uj2EVLcjc8moQWUIQY3dj7eDZ63LlwK7pJwfOh6eE4zsAzjM4Wfo3gfXk26k7CIJOUTKWlv8gW2tOO1UtE+LldaMbjC0vyGc=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2984.namprd15.prod.outlook.com (2603:10b6:a03:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sat, 14 Nov
 2020 00:23:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3564.025; Sat, 14 Nov 2020
 00:23:24 +0000
Date:   Fri, 13 Nov 2020 16:23:19 -0800
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
Subject: Re: [RFC PATCH 2/6] mm: memcg: make memcg huge page split support
 any order split.
Message-ID: <20201114002319.GB3047204@carbon.dhcp.thefacebook.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-3-zi.yan@sent.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111204008.21332-3-zi.yan@sent.com>
X-Originating-IP: [2620:10d:c090:400::5:93fd]
X-ClientProxiedBy: MW4PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:303:b6::8) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:93fd) by MW4PR03CA0063.namprd03.prod.outlook.com (2603:10b6:303:b6::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Sat, 14 Nov 2020 00:23:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4b385f6-3298-4d28-7f03-08d888337fb8
X-MS-TrafficTypeDiagnostic: BYAPR15MB2984:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2984DDD66FAD8DBF4F3D62FABEE50@BYAPR15MB2984.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DI/WTFXH4vYtfYjBeXeL0VQ78u0hRs3SDVt7OjtR70Eq98E6Jc65mxyuxx5Fu/WScTYm6Yf/nddVg3v780Yx9B/W+CPEgk7/37lnskihKXmZjOX66ZzwnioUGjcSpkOn+c7LZZb+b6PrLyoo9bqMq5jDJM+wuySDS7+6L/RkRx4FsO0zNJCY9i82jauiteYV7p2AEO97OMYRb6PTCmBmNrpR9dAg9gG0W2mhHR2lnH6Kvg7dIgtraWAVEJbN4lyyvU4jTJHKmAetieWfMfDd5UG1ip9G0voUlM5taLhb8D4GqNrc6fa//a2vIyqEEC1Zmyst6flcmQZ/WPxOR5LVczGva9NdaygG1XOhD9OlFRfcM8H6oeFE4qI+9si3TOFm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(376002)(396003)(39860400002)(1076003)(316002)(33656002)(8936002)(6506007)(54906003)(6666004)(16526019)(66556008)(6916009)(2906002)(478600001)(186003)(86362001)(7696005)(66476007)(8676002)(52116002)(55016002)(4326008)(5660300002)(7416002)(83380400001)(9686003)(66946007)(14583001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: wLv/gJhpGHO0w7Z6urrIOHdoRFqZk5s+YW6gTumO3LlcTmNCz/LC8f+phiN2m03OgLZ9euCykebRheq8MGobidR2bZ7hXBtOi6/2aCOuHPRaC1+EC3//6ZaXjZmOtEWPR6m+rHUalqvEkwTkKxTdaYE+xJ0P71JMNLQd6m7b1O19MPejXgv/jwf6VwrrJcQXDsE1p4JmqaGTZHcbhtSKkkWyAxELwYNuqU3T2czBFonqPbb74YcFLkLH3opVPi2LAJFE+A9yeUMPmZlJ6avcqOBzins+uWGvgGzOjpGjhnug4Fyh9VucGTqDF3NAMuNRJphgD6ePwiQdfQwI0FlJd2K8xt32VRjfaMCJFpJ6uCjGadzLtJo5m7lAUSkPtTLMy18VKPwOb7KDfWybazULiFFHSvB885lT8LpPUZ6hCcIQlj+rnzhK/PDrkosBA2e+TrBnAM+B9ICRLw0LYuy/cMEudPPOT+JqY0SHXeZ17C/M24dZwJemm7NETCjX9WTkH/7H8qTARixY4UZVNiyFJpJ4zaLZvXBmNTXgo4hNfa0B+9mhAvtud+QT6Vern6A+w/WDPYIDz1HjEf3el60Sj/KU18cgiCyHbJaKS4B0aIOYllYVIotLCIVIjNOPcCW7w4aAHXs90wXkspeJRMwSk8HfqkvwNsRGpLxdWYOUWr8=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b385f6-3298-4d28-7f03-08d888337fb8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2020 00:23:24.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGcYEONBnfj8hT+cEGt2dM6M68yq5ocdniYNnJtP+kISB749daOjpZQPylRyi9j8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2984
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_21:2020-11-13,2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 mlxscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011140000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 11, 2020 at 03:40:04PM -0500, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It reads thp_nr_pages and splits to provided new_nr. It prepares for
> upcoming changes to support split huge page to any lower order.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/memcontrol.h | 5 +++--
>  mm/huge_memory.c           | 2 +-
>  mm/memcontrol.c            | 4 ++--
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0f4dd7829fb2..b3bac79ceed6 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1105,7 +1105,7 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -void mem_cgroup_split_huge_fixup(struct page *head);
> +void mem_cgroup_split_huge_fixup(struct page *head, unsigned int new_nr);
>  #endif
>  
>  #else /* CONFIG_MEMCG */
> @@ -1451,7 +1451,8 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  	return 0;
>  }
>  
> -static inline void mem_cgroup_split_huge_fixup(struct page *head)
> +static inline void mem_cgroup_split_huge_fixup(struct page *head,
> +					       unsigned int new_nr)
>  {
>  }
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c4fead5ead31..f599f5b9bf7f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2429,7 +2429,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	lruvec = mem_cgroup_page_lruvec(head, pgdat);
>  
>  	/* complete memcg works before add pages to LRU */
> -	mem_cgroup_split_huge_fixup(head);
> +	mem_cgroup_split_huge_fixup(head, 1);
>  
>  	if (PageAnon(head) && PageSwapCache(head)) {
>  		swp_entry_t entry = { .val = page_private(head) };
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 33f632689cee..e9705ba6bbcc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3247,7 +3247,7 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
>   * Because tail pages are not marked as "used", set it. We're under
>   * pgdat->lru_lock and migration entries setup in all page mappings.
>   */
> -void mem_cgroup_split_huge_fixup(struct page *head)
> +void mem_cgroup_split_huge_fixup(struct page *head, unsigned int new_nr)

I'd go with unsigned int new_order, then it's obvious that we can split
the original page without any leftovers.

Other than that the patch looks good!
Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

>  {
>  	struct mem_cgroup *memcg = page_memcg(head);
>  	int i;
> @@ -3255,7 +3255,7 @@ void mem_cgroup_split_huge_fixup(struct page *head)
>  	if (mem_cgroup_disabled())
>  		return;
>  
> -	for (i = 1; i < thp_nr_pages(head); i++) {
> +	for (i = new_nr; i < thp_nr_pages(head); i += new_nr) {
>  		css_get(&memcg->css);
>  		head[i].memcg_data = (unsigned long)memcg;
>  	}
> -- 
> 2.28.0
> 
