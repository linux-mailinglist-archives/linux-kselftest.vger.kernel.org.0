Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6032947CA06
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 00:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbhLUX7W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 18:59:22 -0500
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:43427
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235321AbhLUX7V (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 18:59:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dsx7VYB+E+0Lh0cSnjdAMxLTG81SnC35G9PtSpfEQ01rFyOHwL+S8dxv53J66EuBkdjA7uZ1W9owB18Dk2AOUM1MDooZQmKkszVJwSWp4Z+8TzdVi1YBlWGisQKaWRiF63AnbDmJZ+bCTRtC2X/uTwtsqvVjofHYxByS9uF6K6vHWf/gafztCB9nfmSxNsUgJ68qOYWz3Q4umX8hRmKlJvjtJcps2YU3Q61r3W2KfBVdQkwVh3A6E/BbeSP6AwFg7ZYzWlPGvN7/vbz97CdVFit/fS1058u8MyzTXkY2JtkrCE29Hkf9SUJhzXkzKTIVZ6zvl8mRIEY2ZqL9uTluRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA6wYVMFphtSVcS2+vxOuDY35YExa/RTGOoEOHPPoNo=;
 b=QObid9yLxVa/xfQ+RX0WDhOnOMxnWeBYe0pV226QiPPfyA3DSKIj6z9xVmznIHkdxyYHkwwSWpRwakr6SxNdEANNYY5sswSSGNCEAikUctdUEVrMhkk5599Et+RUROVfGCGWzHVdXpndvhMOUuPnH1ocALCTFYx9PnNDfYiIPf3bbfvzGwgJZDtd847eHLuzUV1bXoHzNTIqh1hhErhBxDYn2yvrd09++Jlbm1WdaNeKm3tGcLzJeb+jj7sjK1FLMaCXrP82dh1ogjnwrNkxszsz87C5CjM1/dnMokXT1+zJsAG9XTjGP0TH9om/yes+pV8jUfKKYF+DHyFklOU1GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA6wYVMFphtSVcS2+vxOuDY35YExa/RTGOoEOHPPoNo=;
 b=la81dBGUtGtGdzR/O6I8V0iYckZgf1fNSWbm03yi1gcUeRj0WR33eLu5Igju1jE7gdVlGHZqA8o9jyCNOyTcbU2HrC6+sXVYgFk7GxIHIIx5wF4b1H1BfjjeqqQqqbtPqiTCPpVO7GTXqAzIgiXtGbSPqAjudE1W5Kd7AMy9+q1ZB1gge17NvR7mXqTU7JNVD9/Zt0Heqs26dz+VC0VIxC0GxPAqFl8x3bkqxuubI28BmChnrSge1nGGbortMjK4/qbPAV0FA8uDnyczwUcdySA2rUzBLw8W++3olQ8OIE332T1sAaXG5aO7hG3P/Ng1g0+/TzvMFEKf32FOEoYV8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 23:59:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4823.018; Tue, 21 Dec 2021
 23:59:19 +0000
Date:   Tue, 21 Dec 2021 19:59:16 -0400
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
Message-ID: <20211221235916.GI1432915@nvidia.com>
References: <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
X-ClientProxiedBy: YT1PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e83d047b-b57f-4bbd-08e3-08d9c4dde709
X-MS-TrafficTypeDiagnostic: BL1PR12MB5206:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52061441A6A471C909A3B0CCC27C9@BL1PR12MB5206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9vUnoNffTUTNIDJ5v1U18uizPrOhR2IsGnojDvkdtxVdTMiZ31m1jwt8YTrQaUT9014KZu0owl14FCT8m+5G6XWRH0h2LvHGbIyrCBSBu3RIvr6ZqMKCahdmseZCtHzKvobc5PcGHcFOdHjkW2sNkSBhWUOeAh8+5ftjdPQZ2pD+fu/+I74C+TlpqNcNQUyZYSUY3Dt7pr8JTgwARLyJEopJZW7IhyZHqGB9c/wfCU3AaGozv/8RwE88YncymKLtehAaEICz3Y3faqyoR/s4gYKNMe5FWYwveQEiLhyqCMz4qvk9GlcmchZO2HYiexy4VRguQJNJbD0NFW6d4YvWZgz60fK6XGStyzc/vao+OXIuoSgJaEEgwzjYUFZ3FaNE+r/r4Zu4jG6moVHZCIRdYdGDoHuPyAWwBMF9pX//5htKGvYxVBqRHiBs754aKyksWISSxTdYsutOErFCbHXz7hEd/oH6Hg4CQDPFN5Nd/8GNeapxYoYTD8i+2MaRzTM5GHFb5pT4dIRNzmwjGbNOU5SrCnZH5p+8Upst9Eb4kN6jT3hCnlqgVhe8aRNW14mWFtbHT9vPRggFNnpicghxsRYpgQhaJRc+U4XDVnH2bjpPQeEr65aVT9TqIp8Pv8yyC253LuFs2rI/RCvYC4TgrOaE8YgKs0nmwceu7I0LyP1MU9xvr28qal6fZGdwQMwMTn1JQAtYUp6uOnh5XWxLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(38100700002)(1076003)(5660300002)(6666004)(54906003)(6916009)(36756003)(33656002)(2616005)(86362001)(2906002)(6512007)(66946007)(66476007)(6486002)(6506007)(8676002)(186003)(316002)(8936002)(7416002)(26005)(66556008)(508600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WH/mUTbBGcSvgWJCFwF4CDQEhBC9Plh+NbS6pCTWrsjTx8OAN2zzmIc7x1rE?=
 =?us-ascii?Q?QWYuRsPdau3y3sXlzBgnGXkg+JX2P02uN4RHlYC1UsycSl1Ds+R/wv1/GfYF?=
 =?us-ascii?Q?ppmhD02418oCdCmKTl6SOX3AMq9fR6dJNh6pU1ZQChcAzebAHc5qNwnJiX6A?=
 =?us-ascii?Q?kpAnBmT1G1q4spLjnmbweMIkOf11Q6jseQIeMVi7YSKCHPEv1KQDN49mklX1?=
 =?us-ascii?Q?dNwgt5lPb2a4MbYT7A0smRMaSyKVNUktnk7UdypTYbMTDMFFTwtgbB2AQskC?=
 =?us-ascii?Q?alXem0qtX0fWv1PXl3i8GmsXMEGU2H3MMZoj0LHYiFszFWBLRvemu1jGYEEp?=
 =?us-ascii?Q?37eK1h+k0cYtxzCuK9b1QWOF0Z0cPQtw3ZU3sSznozzHgHZJTQ3EynApkVrK?=
 =?us-ascii?Q?RC/fjvQOCepTSDdTIMJns1Qfe917Z8LEKGMhvZ9tBPJN6Bq3BRiVXOQ/z2Ua?=
 =?us-ascii?Q?ImYe2eKrUWdzMniPydgi7/3VXSBI9XFz5kKjQeBPLH1fgHAw6GvBe3kWV4aG?=
 =?us-ascii?Q?D1F7aVEoDqxNxLBTQS8hE+jv1R99nbGH25Azm9JBB26Fm02XIeOTBQ0qJDAP?=
 =?us-ascii?Q?4YTukt3CRjQn8KYG1BCY8QH8p7UNo5eUO6/NjUTJcimzA3/KjxMOb0MVYM3V?=
 =?us-ascii?Q?BBZ5k8gD8Lo48MVoEvH6R31wcOcKbBkpH7axk+kM9lUkSpE/nJqPwD31qdJI?=
 =?us-ascii?Q?yrHr3vGZRrsycB9EtkYr86NzBGJH34a0OzNbEwXnWScGmSt26AbsfDiJk131?=
 =?us-ascii?Q?RhIhRE7dC/e4VwfnEFRxhRdmi/0YX0a6m01mJKj04/VDvQmlb07bxULekkwh?=
 =?us-ascii?Q?nPSaLQClyJ9/SBpq0Y5mURAufCbtG5jMiL7OCFlsDuu4Lf+ibbHjjiqk+riA?=
 =?us-ascii?Q?ldX/CeP5reIibjPe/PbT8MRA9EFEkYuaQ+iSL2EdpbnxHSlY9ndX+/dwU/Yi?=
 =?us-ascii?Q?BJrEqCgOwzJHN86n+IrBA3fuvucn33KLzNCsT74qwARBIWHQDZTjd917dm2U?=
 =?us-ascii?Q?u46VsIBkumo5EMxaHwZF2UoqFneLwOIbtelv0gxk687qLqfhnOEEovHMHJ39?=
 =?us-ascii?Q?7GfMUJgahBkSagIGaPkN53HbngKKRFUTqgjKdj1L8g0Op/4gQOdL9ljuYzVK?=
 =?us-ascii?Q?FCh7AyFHp7npj+XgiR7WeMsny3FYvw8RcrqCAnmlUdNACTeFPjcUUevxEvgS?=
 =?us-ascii?Q?hjj5I1InnEhjCalb34WgDd7bBqeT6jgv18NupZkM0//SBdvbdhi2mzkmaa/D?=
 =?us-ascii?Q?8KrNkLP65+WdnGY/DFySqKPNvf8MQrx0brGiVJgJJzgl2kNaTXHqs/+rHlUq?=
 =?us-ascii?Q?VTDL1hqjAFJe6tQf9L/TMqILQO+LdUb9b9e9VOLExYWiK45uXxMsDo+0w6Bl?=
 =?us-ascii?Q?9q6tNRlUbNYZJhwdKSuG7m7aOfj1Q5lER63YVYu49NuVfYlVna5vWd8A6kRM?=
 =?us-ascii?Q?hJkMTO9F4trb7j48ZfP1yfLWMT1DA4n1k109tAQbY1933/S7BDAbffhKoVAj?=
 =?us-ascii?Q?Zj2Gw4oBGNt0bJTkFrfJ22LKSZhvvTXl6knb9woXO9HswbdRg/PkD1AQGm93?=
 =?us-ascii?Q?sFxRW+Iv02kzeerIGAM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83d047b-b57f-4bbd-08e3-08d9c4dde709
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 23:59:19.5393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymD70s8/pD8rQRwalllXwFpk4hi4V5Xg+W4MEn+Prfi1yRBKXILdUePrdtOoZAI1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 21, 2021 at 06:40:30PM +0100, David Hildenbrand wrote:

> What adds complexity to correctly maintain the "exclusive" state are at
> least:
> * KSM (might be harder, have to think about it)

I know little about it, but isn't KSM like fork where it is trying to
WP pages with the intention of copying them? Shouldn't KSM completely
reject WP'ing a page that is under any kind of writable GUP?

Jason
