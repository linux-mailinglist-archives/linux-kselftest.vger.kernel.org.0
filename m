Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5422B2A79
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Nov 2020 02:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgKNBiU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Nov 2020 20:38:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24734 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbgKNBiT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Nov 2020 20:38:19 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AE1T3rf024963;
        Fri, 13 Nov 2020 17:38:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=bp9FKhbwhFogovsA7LJMsBNWPmTIgbYL4J7FTfX239E=;
 b=Yr6QvcCoT2SeFPwIIoIsqGm7tHQ09EtlSy/C/Z94q4RZ/AJe3RzeEGBc3q+02c+szFz0
 kgKJgniTBLsOUVdL898cfm2QIt//EUVGBpo8HE7wjoO1p6Jz9vcOK6lw3z5FGGDTTcfp
 eI3mAw1K+WapnpdPdKdE1N2owELpb5R9N1A= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34seqpekcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 Nov 2020 17:38:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 13 Nov 2020 17:38:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJO7KM69pLbcE2lDmjFQ/MLpHCUKWR0r0NLaIhyplkrdY6M1uJKnmQCaAvJOK9Htlu2y/XxLMFqllPWpa+OyYsNiIIkAQX+ySEw+uCyHgadoRVyZy8CVJExB/JbR2W4AvYOGoF9b/brwAuxPidFujTM6r9iAwy0r36USQJF0zUeA1bL21rq3xrmymCpfBQH4kBaydgfEzVHghZBA2JvtdUoPxA1Z/NPWpdz5WP2+gnLYPxjMjdyJtsLwZcE55SJIjq4oFQKca6dgZAMqWaYLxp8Tqb5VKNvLgF+3MlW7wX4ya3QfvQarrhmsKT8+HFTPQba+pBepmGT6j6egxVwZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp9FKhbwhFogovsA7LJMsBNWPmTIgbYL4J7FTfX239E=;
 b=U6Gp1kM+ApemS3h9cx6eQY0Pot9/9uVGqxxOWhKdcYkhBJYDYJYwHP4Zg43vrZCFU8FUG2rFfzlw0+C1gocZIDET9L/pRemmjjT9rMJK8pnsNOeEDx6zNOuhz5zm1kj9jx6WDes9SutBjrRKHSUpFkFJ6FePxpvEtPdODQsydwUuLMxyYsEQAaicCmQQE1dFRZj6vAi7TdUFyLEiwRr7KKWbjneEg9qhoF0vePBcHHYPeYwBus+mqwjenqAC9dAWkxXrbLMAi+up3hiQT4ckG63kagJp6Sxk6iKu1sSZBb/QZttTlsIai+ENTIiOIIVRpvjFhfSQdvGVqBovdCjViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp9FKhbwhFogovsA7LJMsBNWPmTIgbYL4J7FTfX239E=;
 b=DO6TxYfr6rAd8U5/LFYt16cZmHGZ8OV2wPhS3PW+nqZWTIdRQdAxsHXLR8FTRvi8uRlU0JRRdf32r/oM0QrlqtxBPzUjGNEPv77WC4lwBzWuWeil9xTOibcB2R1qMm6KvN25MokAjbFVBelHCmeWa96HVUtvmdH//v9JlyUH4XY=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3683.namprd15.prod.outlook.com (2603:10b6:a03:1b3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Sat, 14 Nov
 2020 01:38:06 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3564.025; Sat, 14 Nov 2020
 01:38:06 +0000
Date:   Fri, 13 Nov 2020 17:38:01 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Zi Yan <ziy@nvidia.com>
CC:     Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
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
Message-ID: <20201114013801.GA3069806@carbon.dhcp.thefacebook.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-4-zi.yan@sent.com>
 <20201114001505.GA3047204@carbon.dhcp.thefacebook.com>
 <F55878E8-22B1-443E-9CC8-E97B3DAA7EA4@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F55878E8-22B1-443E-9CC8-E97B3DAA7EA4@nvidia.com>
X-Originating-IP: [2620:10d:c090:400::5:38ca]
X-ClientProxiedBy: MWHPR1201CA0007.namprd12.prod.outlook.com
 (2603:10b6:301:4a::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:38ca) by MWHPR1201CA0007.namprd12.prod.outlook.com (2603:10b6:301:4a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend Transport; Sat, 14 Nov 2020 01:38:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77cd4d70-56ac-4b76-47fc-08d8883def4e
X-MS-TrafficTypeDiagnostic: BY5PR15MB3683:
X-Microsoft-Antispam-PRVS: <BY5PR15MB36839BDB867CC85FE046094ABEE50@BY5PR15MB3683.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqkfyoUQSqn5l4BZJqpPfMRK9y/+Vj8K1ByJFb7CE+twHZGI6tXjadtwiJR7NPjeFmh0cXrIA88gMoHs8KGXn2bpE/n8GLsPpbt5wR7ioJqHxw+aQcIylD5zmqYNY5fW7gMxm3ezqkekz9uAt3jxCWnmMHr/qHviyHPzqpsUJlFBY9MIckGvkwiYv7LrHml6BU/ecKpPShaLFYPGq0yQW27J7P5ex4uP4dQfwjIraajSYF5btgcqVe2n6h0/IkVydi41y2vNIY7lwvctK5iKVH+mMGYMVxIhbk8IgBtBQ5WMGcSljmYwcGW7XqDa8GndcTxaLWTPIPRRoopTdYTtTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(4326008)(9686003)(5660300002)(1076003)(478600001)(6666004)(55016002)(33656002)(86362001)(316002)(7696005)(2906002)(8676002)(186003)(83380400001)(16526019)(6916009)(8936002)(66556008)(54906003)(53546011)(66476007)(66946007)(7416002)(52116002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ZXoEEgY2mlIf87XJ8ylbOds78Y8Dvcd4kaHhajo6utsdMomvVC4Ggu7eNmslxxNh1YCpw3yEvdUxRtVoeKynI6+TIuvjFxV9Yf9BfLlh7Dukh49UE3JsKXaNAFpqaG6j8NtcTCbFQelfTbU3n/vBUpQTS1RvaPvpeigPzJ1XvMlMjg8kw2tnFC/gKPOvET4ezRytX43P739fP4ZWOYKbHZkHqLtb77rNKu2STQQvlqhN3K0P5Ao12EKGRE4YjWLUSPo5WvIw5VRTA2sjNjiahU3zDExfdFLqOxNRzIK/xr38ORcdwVQDICH28eU+yz1ApWwB79YDxZ0mXOF7KgwIZ7qJnKxx6IFaC4pOvu/E5sgLx7S9ITNVO/goiKCRugGNf0J4wmu4k6N+DNRrdLKeMB644x5iTdy+ceO1xKpAP2GQsPmZxUY0vFlfnCrnZO/Dl/Yng1+byvp6Y18mbe6JnSu2i/qBcT3yuyHA8c5VRaJu030d9OkG1tOD88Pt6IYs99lijIo9//lhqcMPnCJorcc4hdMxyRnZwQ4Bk4bimtzO1nhUWW8T+Ra1CVq/j4bs4VrMDotO3snj8uFXDidM3kjZCkZ0lGfzR4FaPn6Tmm3cLvuCPA9zF7JlJl1OGDlThursxrIPCKwqIAFzZ/SRVMhn+TA5KZkUz9wEWUXhUYU=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cd4d70-56ac-4b76-47fc-08d8883def4e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2020 01:38:06.5070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFNCPOk6RsZrApGt92OGZR6SAbHEltDTmYkMCowEITPlXr9YX9zF+Sa7ia+jmXJp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3683
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_21:2020-11-13,2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 mlxscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011140007
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 13, 2020 at 08:08:58PM -0500, Zi Yan wrote:
> On 13 Nov 2020, at 19:15, Roman Gushchin wrote:
> 
> > On Wed, Nov 11, 2020 at 03:40:05PM -0500, Zi Yan wrote:
> > > From: Zi Yan <ziy@nvidia.com>
> > > 
> > > It adds a new_order parameter to set new page order in page owner.
> > > It prepares for upcoming changes to support split huge page to any
> > > lower
> > > order.
> > > 
> > > Signed-off-by: Zi Yan <ziy@nvidia.com>
> > > ---
> > >  include/linux/page_owner.h | 7 ++++---
> > >  mm/huge_memory.c           | 2 +-
> > >  mm/page_alloc.c            | 2 +-
> > >  mm/page_owner.c            | 6 +++---
> > >  4 files changed, 9 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
> > > index 3468794f83d2..215cbb159568 100644
> > > --- a/include/linux/page_owner.h
> > > +++ b/include/linux/page_owner.h
> > > @@ -31,10 +31,11 @@ static inline void set_page_owner(struct page
> > > *page,
> > >  		__set_page_owner(page, order, gfp_mask);
> > >  }
> > > 
> > > -static inline void split_page_owner(struct page *page, unsigned int
> > > nr)
> > > +static inline void split_page_owner(struct page *page, unsigned int
> > > nr,
> > > +			unsigned int new_order)
> > >  {
> > >  	if (static_branch_unlikely(&page_owner_inited))
> > > -		__split_page_owner(page, nr);
> > > +		__split_page_owner(page, nr, new_order);
> > >  }
> > >  static inline void copy_page_owner(struct page *oldpage, struct
> > > page *newpage)
> > >  {
> > > @@ -60,7 +61,7 @@ static inline void set_page_owner(struct page
> > > *page,
> > >  {
> > >  }
> > >  static inline void split_page_owner(struct page *page,
> > > -			unsigned int order)
> > > +			unsigned int nr, unsigned int new_order)
> > 
> > With the addition of the new argument it's a bit hard to understand
> > what the function is supposed to do. It seems like nr ==
> > page_order(page),
> > is it right? Maybe we can pass old_order and new_order? Or just the page
> > and the new order?
> 
> Yeah, it is a bit confusing. Please see more below.
> 
> > 
> > >  {
> > >  }
> > >  static inline void copy_page_owner(struct page *oldpage, struct
> > > page *newpage)
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index f599f5b9bf7f..8b7d771ee962 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -2459,7 +2459,7 @@ static void __split_huge_page(struct page
> > > *page, struct list_head *list,
> > > 
> > >  	ClearPageCompound(head);
> > > 
> > > -	split_page_owner(head, nr);
> > > +	split_page_owner(head, nr, 1);
> > > 
> > >  	/* See comment in __split_huge_page_tail() */
> > >  	if (PageAnon(head)) {
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index d77220615fd5..a9eead0e091a 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -3284,7 +3284,7 @@ void split_page(struct page *page, unsigned
> > > int order)
> > > 
> > >  	for (i = 1; i < (1 << order); i++)
> > >  		set_page_refcounted(page + i);
> > > -	split_page_owner(page, 1 << order);
> > > +	split_page_owner(page, 1 << order, 1);
> > >  }
> > >  EXPORT_SYMBOL_GPL(split_page);
> > > 
> > > diff --git a/mm/page_owner.c b/mm/page_owner.c
> > > index b735a8eafcdb..2b7f7e9056dc 100644
> > > --- a/mm/page_owner.c
> > > +++ b/mm/page_owner.c
> > > @@ -204,7 +204,7 @@ void __set_page_owner_migrate_reason(struct page
> > > *page, int reason)
> > >  	page_owner->last_migrate_reason = reason;
> > >  }
> > > 
> > > -void __split_page_owner(struct page *page, unsigned int nr)
> > > +void __split_page_owner(struct page *page, unsigned int nr,
> > > unsigned int new_order)
> > >  {
> > >  	int i;
> > >  	struct page_ext *page_ext = lookup_page_ext(page);
> > > @@ -213,9 +213,9 @@ void __split_page_owner(struct page *page,
> > > unsigned int nr)
> > >  	if (unlikely(!page_ext))
> > >  		return;
> > > 
> > > -	for (i = 0; i < nr; i++) {
> > > +	for (i = 0; i < nr; i += (1 << new_order)) {
> > >  		page_owner = get_page_owner(page_ext);
> > > -		page_owner->order = 0;
> > > +		page_owner->order = new_order;
> > >  		page_ext = page_ext_next(page_ext);
> > 
> > I believe there cannot be any leftovers because nr is always a power of
> > 2.
> > Is it true? Converting nr argument to order (if it's possible) will make
> > it obvious.
> 
> Right. nr = thp_nr_pages(head), which is a power of 2. There would not be
> any
> leftover.
> 
> Matthew recently converted split_page_owner to take nr instead of order.[1]
> But I am not
> sure why, since it seems to me that two call sites (__split_huge_page in
> mm/huge_memory.c and split_page in mm/page_alloc.c) can pass the order
> information.

Yeah, I'm not sure why too. Maybe Matthew has some input here?
You can also pass new_nr, but IMO orders look so much better here.

Thanks!
