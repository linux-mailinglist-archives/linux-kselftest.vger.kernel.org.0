Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B8E47B6A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 02:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhLUBDR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Dec 2021 20:03:17 -0500
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com ([40.107.223.66]:57793
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229551AbhLUBDQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Dec 2021 20:03:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTlusHoXCA9UAV+HuetCVEYf70wcD7UcCsl677vsPLWmc965/b1D35+gOFhNBIkY+O7OAQFBfNojCEcDbvGFRfNE60Q+O42Yu+tmBVPNAD09dX8b9xdhc9j5aSczq1s4+0Qn4PKMo/Rbi6wrkKUh1lS2RkV1dvNRY+UPItydeKFwz8Q/OHbSz0lk/8XWe4RlvHm3v1xN47+XYTrdwNwFFdK94g+iviEvLYW9mIxQVTCTs1pZL92fUxJBQvWpb+Ii6hh+TSH76isj+91jrcr0ohYyfAOdUmZz5LaySgqPn8vlIWIQZpbLauJs44w0QfrF/8xMjdI5guhmBcEvMsnCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6bs08ovUoHYBJ0M+mCPtD5lJuq7dITLrRQz8WlXE9I=;
 b=iSBKR42hcR7ZpMbgtvZ+5BKV7H1bhSSNLCdaWyHSC82RM/TL8487H1FuKwvXgV8K8ggR5K1872RS0pcOeuIJOiKhPFjGFlXkySGAeePLxDEvX9y0EFg+MeYD4+699dqKMVbISMAW8ss9XTrL0TSHsAp5AqJTHy6yX8el9zyS74oDN+Z8MZh7azsQTlizZmiYDE6q9PJVVnLrSRQvgIEqJwdlWpakNyZDTOCpEfF6YWWcul69prR5OikUg788DM5+WgebwgLXMv7mzjLus/aDhDya0Estb68r7NcGOEz5czy5D3KIA6IOHkx0kOGM/3ttv1MIJC+9u1Dp57o1kUVPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6bs08ovUoHYBJ0M+mCPtD5lJuq7dITLrRQz8WlXE9I=;
 b=b5OWRZQsspKAQ6hN8P7F9dEEV2GjqKsgYxhGqt2ImaccddsQ+kpCX9zu6pjx/AbDuna70kSdNtEOc4fhDcfmHNfRWrb/pipKgWmlhyxLrRgD+8lrS+oRfWbmPfEX2zmZZQdQaZBkJe4puHZ4R+c8lodwrf7ZSw70ppSMiNbc2ozZ6ppOM3cbkc/Ei1mv3e9n8HNJZOdocq0RmRcnk37Qs7iMAnstScs0aWXmOJW169OVsTNGvuM1IhOYWU05EI4Fg77urW0nIhjeI0geKLUOu77IxfcKY6EYio/kuafS2kXCfmy3YQdBjDqrmHJhuDYk3HEKhgf5e73hlbzEDC2KcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5303.namprd12.prod.outlook.com (2603:10b6:208:317::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 01:03:14 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%8]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 01:03:14 +0000
Date:   Mon, 20 Dec 2021 21:03:12 -0400
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
Message-ID: <20211221010312.GC1432915@nvidia.com>
References: <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
 <20211218184233.GB1432915@nvidia.com>
 <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
X-ClientProxiedBy: MN2PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:208:d4::44) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 613958bc-58f3-404a-1ffa-08d9c41daa58
X-MS-TrafficTypeDiagnostic: BL1PR12MB5303:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5303EAF6D05B516E10EB14D2C27C9@BL1PR12MB5303.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OupxmD7dCHWVMcRAAFUschA4btMHbyroxiDNPuV/LJ+McusAowA/Y+uyfEonYtn5DFLU/Y6loR19SHC4bvG/RyZ37zuv686UJHhaUuD/lm6tHUm5JbNZL2aO934DGfdwmpdvAeBUJM2MHrtVT5fTPLif7bC/dJOb4Qby5S+xJSrHxfoZa76Bv7mT1/GkEb9xXElyP4m3Yx93Fq/suJzylbxheJAgk/sz3VsL9WMi/4hT9NFu0lZ/6Xm6+EwJy3T0mRKOqRe6eWMfPXbdL2R0bYr2QRQoZUMkL8xVIvjT1BT1GRnJU+lQvl/CowPRsafR/Op/QsJDveIAQ4I3AUZ1fwlPYWuGCrrj+kB3FElah1oBBVPAzXdIwbccEzqTHNLyNCP5DGZYOpu3KVdTHNaV5f/5uZW5zpapSIsez991v7+FRsTvbPRBqFp5FhmexQ+RuugM8x9ySR/hYMuA9yy+jTmg4XZ3x/M3nzr8y9Ddic9eegKEn3sZNRKfZYfGcT5rPFsMZC0CEzP5XXDkrFbpaqlLrEUvMrIJy8yDzvCGAf+wak16eEnx1+M6uQLrXE3s9g2ZxKZ0VeKra4DCjO2ytzYWef2ztkWbLuRPzac25tUmVf8SPaR14YSSBS6LuiKowqBY1B+3+2aJMtT4TwvnPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(33656002)(5660300002)(6512007)(6486002)(36756003)(8676002)(186003)(26005)(2906002)(7416002)(508600001)(316002)(86362001)(54906003)(8936002)(66946007)(6506007)(2616005)(4326008)(66476007)(66556008)(6916009)(38100700002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sog1AC0GyQ1zmyBygL9LTYnum//ZeQeZzHeDbLuY/rtQWy9sx/iHF+rM5fXU?=
 =?us-ascii?Q?dhfiel2TeKg3x+q3JOXVyo/qOisvHBeHmhYceommwGnGfBOpVF+J7f8BvMkf?=
 =?us-ascii?Q?cbvXnncVWeBJFIG1bUnwlmbUyhF3HKNphZckYa3j9su5tNaVxZzNn875wumY?=
 =?us-ascii?Q?0BH5gO59Z9wOJilVaagVAFzUm3/0XymYGwNJonZqbN7Rl9r3dwOtZg1sQXv2?=
 =?us-ascii?Q?eZ7EbiFat/njX0wFAqX6UXsPzJVpVlHWi9k1JCCdtt+u8T2y/Y9QjX9/ezB9?=
 =?us-ascii?Q?Omtmv4e2Br2xzCCrTuxU7WQSL9Gu7kwKLWdNWpHzy8Z1hHAjnVrB0CVvY8ej?=
 =?us-ascii?Q?1SwGM6bKxDQhuGsQFdDPRK3jt8NhhKJ2pQDZSr6YGHLiv7oLa2hnxo50Dsq4?=
 =?us-ascii?Q?1I1dampnKLQbtCH8gLz/DU4Kkc3mGTSziKxbDQQHllTgApS9jkYVZOh4SPr/?=
 =?us-ascii?Q?sn0zIA0LGiiFP+jwIyb+2L92hkWLw3ZSrUJLFmHvdYaKGgo7jFLuv1i1eV+k?=
 =?us-ascii?Q?wEkwlG7qQ2or7ASjB9Cbw9ljHibVEtMuZziVirDFN1JnVcTbq7Ntb6/P6tVO?=
 =?us-ascii?Q?m78cBK1WwqvHW4ApcdE9W2jKk6cLYU2llCV2t0Zf464cFBfsq46IHi2w3x97?=
 =?us-ascii?Q?S54a9n1k4bJ9g/hb14+Q43QCobIfgmpQBWd65xnxaYFsvN6BH4XLTAi58uj+?=
 =?us-ascii?Q?kUfBIKZCmzNEwIftut6FLkMF1xiu9QLBNIfAmbn9MC3jthlYmefI7kxi03zX?=
 =?us-ascii?Q?yPe5FCRV2lNt/jCpNcAZB8no1LUZjVodtsOGqoN1iyJePSl9hzfWtoLPkM1k?=
 =?us-ascii?Q?nKett5Z+Yu3ITbhfgQLV+Ys5p8SpyhLJ+EbpLYacfXyzp67B0xHaHBA6shHP?=
 =?us-ascii?Q?hrbRg5sNSm8+1BJHJZZKGe7bGgWMbbLPb7irnsCTfBfLYZSXKTWP8JzANpdU?=
 =?us-ascii?Q?ZE2OoyQXn8gwaGNlP2NFTTI/UYhohSz+Xb3QokdqXdO+NmBqIZgvADPiywoa?=
 =?us-ascii?Q?EOWgohPfL56OagLasC3E1wBpAL8Hz4gheNoqRTNhlddAatpG2LBHYyNpUP5h?=
 =?us-ascii?Q?zFJPhCpA6wQ9TJMAqwRTjURwInbI60JG+DVOmwVFeG9YUBLKNCaqjH3Ch2s+?=
 =?us-ascii?Q?Q8uWXtVg60ktdE33wgkrjbV1TJJ+vtJS6Vll46ROP8piQhm53OkqM05Xv7s7?=
 =?us-ascii?Q?qzR4nidqlPEl/3Br6X3hZYA8a6Me4gSdmIwr00mrjZA8yum8EEHV289ndDzo?=
 =?us-ascii?Q?r3GmyMW276f6rhxAOfqx+38eNk9MZ0DlICr9QHPggvOxQhOAObA/p4kKMQce?=
 =?us-ascii?Q?KeXzJB7ANLmAARgHt8F72Fie2k8v85aECDSk+sg3DbLMDUYyjwNPwFRcCYvc?=
 =?us-ascii?Q?BPnDuMgZbR/IY4HVxLk3EdjgWmWmGoGy2PbUShw5QYMP1tvXNiogYEVJZ/NL?=
 =?us-ascii?Q?bMbgBN8go62hvjGh0e30zCCOFc+C5o3RXdcI7+k3ycHbPYx8FD7iir2rmZ5i?=
 =?us-ascii?Q?9Yu8SAQTnUO1jVWOc7fxxEk3n7fzGYptnBQmf7sJHRJl5Heamso6UQDh0Uc+?=
 =?us-ascii?Q?JqybZ83zJS1+pJhNVOk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613958bc-58f3-404a-1ffa-08d9c41daa58
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 01:03:14.4226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGJEynFzbbzFULNexZ7S0eLwKkXTOKrQUYjJclVvmR7nru6Cv7Jj3uKCuwrxQyNN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5303
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 19, 2021 at 06:59:51PM +0100, David Hildenbrand wrote:

> handler (COW or unshare). Outside of COW/Unshare code, the bit can only
> be set if page_count() == 1 and we sync against fork(). (and that's the
> problem for gup-fast-only that I'm investigating right now, because it
> would then always have to fallback to the slow variant if the bit isn't
> already set)

I'm having a hard time imagining how gup_fast can maintain any sort of
bit - it lacks all forms of locks so how can we do an atomic test and
set between two pieces of data?

I think the point of Linus's plan really is that the new bit is
derived from page_count, we get the set the new bit when we observe
page_count==1 in various situations and we clear the new bit whenever
we write protect with the intent to copy.

GUP doesn't interact with this bit. A writable page would still be the
second way you can say "you clearly have full ownership of the page',
so GUP just checks writability and bumps the refcount. The challenge
of GUP reamins to sanely sequence it with things that are doing WP.

The elevated GUP refcount prevents the page from getting the bit set
again, regardless of what happens to it.

Then on the WP sides.. Obviously we clear the bit when applying a WP
for copy. So all the bad GUP cases are halted now, as with a cleared
bit and a != 1 refcount COW must happen.

Then, it is also the case that most often a read-only page will have
this bit cleared, UFFWD WP being the exception.

UFFWD WP works fine as it will have the bit set in the cases we care
about and COW will not happen.

If the bit is not set then everything works as is today and you get
extra COWs. We still have to fix the things that are missing the extra
COWs to check the page ref to fix this.

It seems this new bit is acting as a 'COW disable', so, the accuracy
of COW vs GUP&speculative pagerefs now relies on setting the bit as
aggressively as possible when it is safe and cheap to do so.

If I got it right this is why it is not just mapcount reduced to 1
bit. It is quite different, even though "this VM owns the page
outright" sure sounds like "mapcount == 1"..

It seems like an interesting direction - the security properties seem
good as we only have to take care of sites applying WP to decide what
to do with the extra bit, and all places that set the bit to 1 do so
after testing refcount under various locks preventing PTE WP.

That just leave the THP splitting.. I suppose we get the PTL, then
compute the current value of the new bit based on refcount and diffuse
it to all tail pages, then update the PMD and release the PTL. Safe
against concurrent WP - don't need DoubleMap horrors because it isn't
a counter.

> Not set it stone, just an idea what I'm playing with right now ... and I
> have to tripple-check if
> * page is PTE mapped in the page table I'm walking
> * page_count() == 1
> Really means that "this is the only reference.". I do strongly believe
> so .. :)

AFAIK the only places that can break this are places putting struct
page memory into special PTEs. Which is horrific and is just bugs, but
I think I've seen it from time to time :(

ZONE_DEVICE is also messed up, of course, but that is just more
reasons ZONE_DEVICE refcounting needs fixing and you should ignore it.

Jason
