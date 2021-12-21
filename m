Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF4547C176
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 15:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhLUO2Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 09:28:16 -0500
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:4993
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232258AbhLUO2Q (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 09:28:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7C/4XJZZrl5nYkGAYhblUMDzBZgrhabLbfTJRfs03nRFtpUhF7auqbjcNcRrq3ojO4ZE/J64elKDUY+UBnh2uoN4XqhfOGfGY7iSkNwXPXVpqK/a2TaFqNjCxsXzEDj9qNeu4sfk4trztOCJF+Z8Eyo8bUG0gSyeoDAbgCE85LmYLtBHD7OJQDWmLgtATKBW5L8/4thj6V9wkPtj9oqpHTFamz/1bB0LvuWYDJs6AKl4dh3bPu7Xws//q6BMtWuAotscXgYeiDvFzX6UKCzIylFXAlKrYYHsolkc3UBNxp3JAkMvzH0NQUFxnEI6t2z+9vAux4vsUZdrGBs5eGWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dezp2gh7jjkmOBEOZ0vpRiTlvbGGt/pCn1wUlfguWYg=;
 b=OOAK+QvFz4UpK3yOOm3QdS84wC2BseeomOb6tde9roqP291kJyjcOJZHDoyc1S21/jaYHjPKR91Bs9oAyZfxO7xQwhWhhMRToU7qmvpxe3WKNN2m5WtXA6tozLznq+xjFIAz3UmrFvt4hvtLrthp9SOuJJWxnBRGfXOEhFcIqkByJ+WHG2IWXwlxXG1tS2okCix/lMw5oHsdeRzrI6MG1zhD90aECz8sJipiBkeY32LV3YHVh+OL1IE43GGFf8s6cFNmOhGZIqswK8qlEqK5X5ztZHtW+e9pNkBDZ7weIAgUrNmjAqpiEgAFbLaaXntl3v3RdEQPxjFTUcIx6L7v3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dezp2gh7jjkmOBEOZ0vpRiTlvbGGt/pCn1wUlfguWYg=;
 b=GgiXLDN5KDdsqHFnPhTEM9MarATh13yNm8R5hT49iKMqgE3nPefhqzVref/tGFNOdSyQIV4i92OCIPG8yXWASUOLXbWLlrS/TALdkGTb41QKnZZ9phqQeQzBHsfOnnBUxK3E//Iyv68aygfze3dyyxT5u/D/Nm+YCveqp8ClSthsu/klJgFR1wy7SqXmPnH5N6aseH+Jquty5faaSB/U7UlPZRubmQuBQ60K8BafE7z9p2HHp+3J6ibVvwYPds0MLL+x81uKpFcOjmV4OtOKYSqfrcIFqC/+Al8k2hTQsiFCXI4MDov7nTC7lMkHyYWitY61G5wVmp8dHoaR8xyMFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 14:28:14 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4823.017; Tue, 21 Dec 2021
 14:28:13 +0000
Date:   Tue, 21 Dec 2021 10:28:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Message-ID: <20211221142812.GD1432915@nvidia.com>
References: <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
X-ClientProxiedBy: CH2PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:610:52::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af7b0afc-2575-47ba-87f5-08d9c48e1f0e
X-MS-TrafficTypeDiagnostic: BL0PR12MB5508:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55084B2349BA2C7524522AB1C27C9@BL0PR12MB5508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wO+E4DI8kqZtssocWdkV146972o0m16srgQjrs0YIV9GeuRB11qC7EzwKNEKMk6sSZ9aBsqREdAnnD1Z3U2QpTH6NMkVk2H+UF8ZUzkum9zafdSAzWSQsOYrokqPQl8fwq5lUqBuMqpU8Y8am05ta+scAcwNEPKPOjUj3+7weQUp25ByxR0TpDO+T7InH0hRWnKl7gbXAo1XYSDMrctzZvFpV+pKQU5671sO3DSlvrxFJcnZ5RvwfZu+q1gtOK0JfzDa7j2gYHRIB3uefZATSqfmiwH3dVOhTqOJthdkv4iQf8UAW++hFB+5SROhU0yyGQ0Rnu8p5PRV3n+fKKhfC3Bojch86Jk07nff4R66DA95za/BJy9wVxY/EQ4Y/C1yOLbXByEJoBHk3xRjTi8x01L78wSZPaT/fkHu2toQi5gihSsH8sibpEw2BqP6EY8DEBG/yzak8SbN1oh+aH2ngjpFUudevZ8G6XVLdfIyZMMd9RmLvCdhnOz6kiDCVVQ0542OFvOH45kgkpiOfB7Ckwm6ojhsWv2FPDWxIEIkfmTyquPWUUvqfnAnjmvOeRhmMp7cXzh6Zu6ZAV+P7QZgjgCl0uANSBCDCjVtGe8w3SV37yxKj5NmnBsTod6dJ2wqFGNkEZeMXOxIyTGIps9mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(6512007)(7416002)(2906002)(1076003)(8676002)(86362001)(508600001)(38100700002)(6916009)(36756003)(83380400001)(4326008)(186003)(316002)(54906003)(2616005)(66556008)(66476007)(33656002)(6486002)(66946007)(8936002)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H8/tE3MKdIFZhFn7MSi09e0Ypqwr7IKxpWbi0HF09TvY5OSciK/+JLXnjX9z?=
 =?us-ascii?Q?KRoLD8kwUBPtisMWvFtyCTlYifvHztqIkNrlo3Q8nMZNsRX0m3okjO3rbcKA?=
 =?us-ascii?Q?eeXpvs3yxIfVAuDPcJS16mOeZYv3eTKZCtvjfArxgpOUWBZOCcrXbMhderDN?=
 =?us-ascii?Q?Xv2K7FiNDY1ibG5P2UebFM0HWrOgDHGvMt06nGhNQVDcPz20NRnfA174pl7D?=
 =?us-ascii?Q?6VhQGYjY8vV9cq9jxKGDUaXlRd0XwRKWj256pcnDjfNY6IXkNyLs7BbwJfL8?=
 =?us-ascii?Q?otSxwRyqnC01EkYZv5nPZD21/izXfUafZcEbp9VK644kYktzuhRwPfakMYD+?=
 =?us-ascii?Q?vJ3JirMPdTJS9lLLGgG1S5YgzD2ZDK7fWymbm2AqBi+xjUhHYUS6gY2ceEaA?=
 =?us-ascii?Q?hqJyGm1Gvovr3JtZovw6h3cLoB0H0c4gn1sh8gCllxhczChvZZKY9eBlFiUf?=
 =?us-ascii?Q?S6QPZqjtZgR4Q/NYTJ62tkGEdGWSuPKY/j2aB08FfaXn++pmqiDi+QLHkVOl?=
 =?us-ascii?Q?572nsQ5Jkvmr69LKwDAeNayy88d7km/noajsSroRTyw27AvrOdCI9ZRZ+AT4?=
 =?us-ascii?Q?em0XLxwPeXFiOk/BpbztsQ9iCOAQmFePv+M+Ir+VAyXsss1IwQwI9qkuT1F5?=
 =?us-ascii?Q?2+3G1/Idlbd0acUiGO0E2Kg4HM0alQ28iG3xJa7w6ztMFjKBGoltE0k/y5ke?=
 =?us-ascii?Q?ck/5FvyN9R7zJQXsXrWfFOgtI2G5lA3yA2CAg/BYjubu/4g7ZjJYU82vZEOL?=
 =?us-ascii?Q?UKsyQ+Zeokb3o8sJrmLnfTBI4xsHx8gGJU1D6VhsP3NW11kXvaVqkIkjbxpM?=
 =?us-ascii?Q?GsfrFBGRl2D8WyFB8pkYcstqPgXYJk2PoVQkWOTOmeanHtiozOO+aKKDROlu?=
 =?us-ascii?Q?IFYXsqRhLkt2JqYe+MNA0RKMU+jlnvFN8E5KlnOH7pc/bL+TsGNveQmLhfTp?=
 =?us-ascii?Q?j/czblip8ARYxtCffh7uefDwFFkeJbLjkmiTOTC982R849/k7oOgkrLIS6lb?=
 =?us-ascii?Q?8qwg2Ki87ob2NcDhXMza1U4TDyhVyhDW7FEO82sIzRv1/fov2+Ir+8fQ/SLp?=
 =?us-ascii?Q?Alvmj79Wsc0Y34PkSzX2loGFjlun6JP/nedgzlSHB+i2TRMnjpr4NcNH5aMl?=
 =?us-ascii?Q?XYUgiun+7Tz7RZsriY6YuYdictQonzUHA1VjCmMgfj7VK8/vp8Xl5cfG23pP?=
 =?us-ascii?Q?yzHOII/qcZxqz2/e0FL7QRQ2Zc8UDR+rV2ZjQ4ScgdGQ77jf6dz5QCjJMdgA?=
 =?us-ascii?Q?Ej3oVNydAQc9mZ/VoVU9LO1Z2xLxx53/MbXD5vT0CaVBdmBlR4S3OWhxM63l?=
 =?us-ascii?Q?y3VAezLbqySziryjTE2XzlQVfO7GuVVrVE63CIhznRNXL8NV/zltoBP+dO40?=
 =?us-ascii?Q?ltev6JomWo0zVqkvv3RikUy4lJTpdLjHEJBcJ6cNQcfBjLsQdrWNalrzyqli?=
 =?us-ascii?Q?4dCL9+x1WniVqWqSxAtVbs77xD5QxwjQHATxm+/T41gPeNeorm+wdHJhRRWw?=
 =?us-ascii?Q?cvzOc/j0CZm+KmTBANVDfoVEnNpV7yZkLN1WRCSWT73XoTrBcOlRtLk1Kn+e?=
 =?us-ascii?Q?Q6Js0XeDfDBlkxuuNJk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7b0afc-2575-47ba-87f5-08d9c48e1f0e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 14:28:13.8206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrwfRejtg/ABjKrgBgJzUmG9YwWFt+uLWW8QIHBD4fKp+XVs0ZPsEdM9BzZbayLE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5508
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 21, 2021 at 09:58:32AM +0100, David Hildenbrand wrote:
> > I'm having a hard time imagining how gup_fast can maintain any sort of
> > bit - it lacks all forms of locks so how can we do an atomic test and
> > set between two pieces of data?
> 
> And exactly that is to be figured out.
> 
> Note that I am trying to make also any kind of R/O pins on an anonymous
> page work as expected as well, to fix any kind of GUP after fork() and
> GUP before fork(). So taking a R/O pin on an !PageAnonExclusive() page
> similarly has to make sure that the page is exclusive -- even if it's
> mapped R/O (!).

Why? AFAIK we don't have bugs here. If the page is RO and has an
elevated refcount it cannot be 'PageAnonExclusive' and so any place
that wants to drop the WP just cannot. What is the issue?

> BUT, it would mean that whenever we fork() and there is one additional
> reference on a page (even if it's from the swapcache), we would slow
> down fork() even if there was never any GUP. This would apply to any
> process out there that does a fork() ...

You mean because we'd copy?

Is this common? Linus' prior email was talking as though swap is so
rare we should't optimize for it?
 
> So the idea is to mark a page only exclusive as soon as someone needs
> the page to be exclusive and stay exclusive (-> e.g., GUP with FOLL_PIN
> or selected FOLL_GET like O_DIRECT). This can happen in my current
> approach using two ways:
> 
> (1) Set the bit when we know we are the only users
> 
> We can set PageAnonExclusive() in case *we sync against fork* and the
> page cannot get unmapped (pt lock) when:
> * The page is mapped writable
> * The page is mapped readable and page_count == 1

I'm still not sure I see that all this complexity is netting a gain?
 
> If we cannot set the page exclusive, we have to trigger a page fault.
> 
> (2) During pagefaults when FOLL_FAULT_UNSHARE is set.

Why do we need FOLL_FAULT_UNSHARE ? AFAICT that was part of this
series because of mapcount, once the hugetlb COW is fixed to use
refcount properly, as Linus showed, the bugs this was trying to fix go
away.

And as discussed before it is OK if READ gup becomes incoherent, that
is its defined semantic.

> The above should work fairly reliable with GUP. But indeed,
> gup-fast-only is the problem. I'm still investigating what kind of
> lightweight synchronization we could do against fork() such that we
> wouldn't try setting a page PageAnonExclusive() while fork()
> concurrently shares the page.
> 
> We could eventually use the page lock and do a try_lock(), both in
> fork() and in gup-fast-only. fork() would only clear the bit if the
> try_lock() succeeded. gup-fast-only would only be able to set the bit
> and not fallback to the slow path if try_lock() succeeded.

I suspect that is worse than just having fork clear the bit and leave
GUP as-is. try lock is an atomic, clearing PageAnonExclusive does not
need to be atomic, it is protected by the PTL.
 
> > Then on the WP sides.. Obviously we clear the bit when applying a WP
> > for copy. So all the bad GUP cases are halted now, as with a cleared
> > bit and a != 1 refcount COW must happen.

> But we really want to avoid degrading fork() for everybody that doesn't
> do heavy GUP ...

fork() already has to dirty the struct page cache line for refcount,
setting a flag seems minor at that point? At least we shouldn't
discard this nice understandable approach without a measurement....

Remember fork is already incring mapcount so if we kill mapcount it is
a win for fork to replace the mapcount atomic with a non-atomic flag.

> > AFAIK the only places that can break this are places putting struct
> > page memory into special PTEs. Which is horrific and is just bugs, but
> > I think I've seen it from time to time :(
> 
> As we only care about anon pages, I think that doesn't apply. At least
> that's what I hope.

You are optimistic :)

Jason
