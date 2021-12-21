Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB96F47C9E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 00:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhLUXyH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 18:54:07 -0500
Received: from mail-dm3nam07on2087.outbound.protection.outlook.com ([40.107.95.87]:52609
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231741AbhLUXyG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 18:54:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlCQjdAiChmef1/Blgx3R1xuN2EhZfI+jjshJC9y+1FWObbA2Mpk5xvtwk54bGCTnthhziOWe8nQdDEil3NeC92O6M4o4of0LeBgg8kG1pUxpdnNCGyJsNrZVpD7edMa0Lf+nsBEKmsAn/1IzH3pImNxHk8HsI3jqVdoBb1d+/bWo5ynMfHYw+oEzbBJLjaBRUeuCv41QSx7eSAqY1OLMRVv5Qy4PdGOAPuFn+G1IGsny0OERB6xfo9h8d9wkKft0lTuQZIgRSjAl8E74Hhmb/+oWZ4Ac7kHIADAAHENnjAjwcGzC9O7kO2fCcdXF8PFolfctL9IClneWstziC01dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyl4G633Zm5hCeZEnA+QxlhuOzFrkualro5Q+GrAJlI=;
 b=NsFaEAbyDX5p3NbqlvCSXWJcnvANXwAp94AsPsbLp+voEwLmvvzq6mXVv59LBs9dDrk224QwF8uWdX5sDlnMyOxRFqptPVk4gt1Jmvl767lVsQe9E3U3u+kaH/Fe3EVaiMm6Om3eEdqF1Br1OYqYs3PNKUZEFnYn8ZpfEOynDVr8Xk2BDropE6JO9WfTQezwyLgLBcc9g9dMB6FqlTCHwmg8mNICnLdsy+lvdHUvpX4wBbSIuJnmSLHytGofqnJAnDNPhESmtE1W337O0D+gakh5CZm1AHeNRsT1MghCSh5Qrp1R8OYzUdOTWYWBMSrc5/HoDJqU9lN2WtBaFSlxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyl4G633Zm5hCeZEnA+QxlhuOzFrkualro5Q+GrAJlI=;
 b=gx6O0KHEzz9nhixfbRpb/Bww+FOMmHS9kN0VELWkkZ2GboKmc7/N6xlDQiqKU/G17YLuzOUeNJuZrIglpZ8KAYSbcl6XMvNDaSPPGKptQkFzXS1SGEWiP4zhjPH51TUnYTzUpfo89UcN4JoiN238GW2au8+kyE6ab8PqGOoddEt86fzyj1lQJj6LgPWvHFKrICnsFWiMb9IzFpHAyoDIF9g8e59yZsYRikiU3DJtBFLkmu3D5HC7RfCfdGRo6L5i1tZCJbSCFwgVSl4giovr1Q++y/68PMxEy7RUMdwGjfFlMFVv9+OXQXou0wg2QUyXe9bfH6regyIjatxHHKEaVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Tue, 21 Dec
 2021 23:54:04 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4823.018; Tue, 21 Dec 2021
 23:54:04 +0000
Date:   Tue, 21 Dec 2021 19:54:02 -0400
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
Message-ID: <20211221235402.GH1432915@nvidia.com>
References: <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <20211221142812.GD1432915@nvidia.com>
 <303f21d3-42b4-2f11-3f22-28f89f819080@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <303f21d3-42b4-2f11-3f22-28f89f819080@redhat.com>
X-ClientProxiedBy: YT3PR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4a7129c-bb8d-4d26-be8a-08d9c4dd2b06
X-MS-TrafficTypeDiagnostic: BL1PR12MB5317:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5317BC514A450790AB2744C9C27C9@BL1PR12MB5317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gtqRSrZGqOfZ0qYZLeVPPVFd5cNclOELG5PsHOO99qhCRfbXfrq8NRRXWs+PomBSxR3Rb46oAPJuwjr4+1AckLWcRMr/bY4ghjN54VrfFg25+HLLw/AnBiSuufS8zEizxY7SaQpCc8GO9DnNBHVw7Onpj3c+DbyCtYb/bWB06OQSkrXEADKs3I7DiiDLoBf3KH84EAyDRc1OgrQZRnad6VhPDSwfq4K4VXftexEyeTBQYf4Mg1Zptd7TXwERhie0FQ24tmAhw5GBA2Ote3DnXLGjTf8kj3pQqhmhYy5CVYYWOlAgWX7/jKcez5WUNv+3fPDA+ua/y9i80LHJ51uLGnuDAtCPNlssOHf293zkYw4pdt83M6DpQCk2mbW2qkbgjEmr/z4fldreWFGf5Mz9Pg+NCIXNWhUHusVYodqNdP77s9Oucar1EZoPDFCpMsiiaX+w3UhTsWppoSpMxjq5hdjEne6sDEvv++r2Q7yyaaH/zmhy9taJczFcqLJdYTRqTxe0Y87Vy0MHRQlrX+sYNVDgHgSjp/LFanPPlUNKZR3/27LtlhGJsx0rHUZNsEXJUpFBo2Npoz78jC3n+4lhj3woh9mydbT2UvqCxBi1DWj6V+94nKUFwPJF3ypbmXnHu5f7XTP1qXLjfuaTZIcDiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(316002)(186003)(66476007)(2616005)(508600001)(6512007)(66556008)(4326008)(1076003)(6916009)(7416002)(8676002)(38100700002)(2906002)(8936002)(83380400001)(6506007)(6486002)(33656002)(26005)(86362001)(66946007)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UZtGtGFdRD1opsZntRxR/dRzraq68v7it6jk6cYL1MFHL38v5cf8l+eo5Vfn?=
 =?us-ascii?Q?xz5Fd5+s1URRNXD1TGL7P8BSN4wroSYSNlM7/SdgLH2kiGOnW1LauTkiCqyx?=
 =?us-ascii?Q?hU3waRh4eTBPwn5WNGI1v1zZUR+UlpLb4/mOIYUTpXSTQ+oe5/t/jl/QsY1R?=
 =?us-ascii?Q?2uHwMPUcB3r98JqAFMG5XRNl02M/Jzx09vvbz57/cwQdO4FtFDdspJzfp54a?=
 =?us-ascii?Q?mkeuuqJ/mMks/vEkOH007Nr8f1ZiljyABDuoya90RMpX56RT/bHEewwl9xjs?=
 =?us-ascii?Q?7MhwyWdse91753HjVkYDifZ7sEA9cDlnjjH1SiWj9LvmsDVoX9h5RW8knGEu?=
 =?us-ascii?Q?0pG2MgsNxVE+T1qw4AbjHs9BTOU9pR4LCXYZVLOquInCl8VfRmiTOLFmy9Um?=
 =?us-ascii?Q?JOkxHNBz3gVxIvku/1tWeU9kaZ5TSH3x6mBErNUiIKvc2M3sPNCP35U5Y4E5?=
 =?us-ascii?Q?/YBNVEMnovMt74GKgxUou/0QER2An3IxEWEwqJp/5fwWFZj47DxuBTpbsE2B?=
 =?us-ascii?Q?NGkKHRWmB8swG7ZBD4AOJY27Cdfa2yn62lqdXQEso95VSMdVTUtXzCfAou6b?=
 =?us-ascii?Q?WlPSCYuliRlEvm1jk09J7r4cchcuUXgGPSvCyIJcxk/9ws0T/FPrlpGSl08r?=
 =?us-ascii?Q?wARTNk9XaKSdxyLwbqTimH/OKn6uj5/osD0NHqIa/V9hGUFFlHxE09XIxxhh?=
 =?us-ascii?Q?aAX+CcmWUqwgmf9DSxDwaq/miIdEsFt8pFxD5PkqxV5gf5NXTTRdtEIK5OBY?=
 =?us-ascii?Q?4SS60jXicHtLxT1IJcsXMQ2H7Kbx4LnzXMgQaKzqLbYYROvJwVpvScpxRBf0?=
 =?us-ascii?Q?+gcOdgZgXy3C+vdTpShTbbBeiydAMkfBk2LQp8ghfJxLUVzxuWWPRDV5otba?=
 =?us-ascii?Q?ym8WW4ecIK1+Afe1Y7HbvLIBQarBXiAwX4/GgGnpi07Pe4GHOCa3gP25Aiht?=
 =?us-ascii?Q?kvyO8iv8NYlddKnB9wYmY1E0goOiq2/IkRXBUNC+KsvyAnQkyqtYzxKLo7RZ?=
 =?us-ascii?Q?JMYhKHMNIIdBV++SaMeCpjKgH6IJsXiPddfEF+hm2appYr5GVOiQ9LMjv0Tc?=
 =?us-ascii?Q?72hK8BGyj6dRhmjQyEfKnFf8+CluW9IHF79gc7/qN8MB9gY65CCoY1IuPVUn?=
 =?us-ascii?Q?lbKdDoXYtgCEqImUDXP5a2RWKP4j9Hw80doH8UOKUpHI063bnfMDIxXjY/MW?=
 =?us-ascii?Q?o9TZSBgYPPLNIN7TsHaPk6kto47dEE2mHJIkynIT4zXi7Wb54HrhYvUoc5U+?=
 =?us-ascii?Q?j+lVscmsW1z4+qZBHgcdrYgSZLB1dUkvgivgMHhSQgl5U6m6h8+6MsIBoPdJ?=
 =?us-ascii?Q?ZLYrvcKYuyO7lD6qejMMlzRWEG1mxc7MhEX7f12BW26t94sIEaPJOti/RE81?=
 =?us-ascii?Q?LiDEQrLagIgFDhZYCcunetU2bd/T9gLOWa3h76clLGotpYflyhh8yHe6Z5H1?=
 =?us-ascii?Q?dB1iOX0uCNYcdVs36sIUzOUBCn6GDLHjF3LRxeIRqSgmqpYGk+VhMGVjXb7B?=
 =?us-ascii?Q?twg41VtEtCCn3zUsAbER13F0Gxy+ujZ53pqBZeOIi/ENTa9iut+4fPEzuYA5?=
 =?us-ascii?Q?BBrCq/U5PJO2dwzC2i0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a7129c-bb8d-4d26-be8a-08d9c4dd2b06
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 23:54:04.3796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHTDgmv6epXip+BUB+b/K17BQ2e2KqLvhvM+WbpP2trGYj3ONoWZutCEZKVAruTT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 21, 2021 at 04:19:33PM +0100, David Hildenbrand wrote:

> >> Note that I am trying to make also any kind of R/O pins on an anonymous
> >> page work as expected as well, to fix any kind of GUP after fork() and
> >> GUP before fork(). So taking a R/O pin on an !PageAnonExclusive() page
> >> similarly has to make sure that the page is exclusive -- even if it's
> >> mapped R/O (!).
> > 
> > Why? AFAIK we don't have bugs here. If the page is RO and has an
> > elevated refcount it cannot be 'PageAnonExclusive' and so any place
> > that wants to drop the WP just cannot. What is the issue?

> But what I think you actually mean is if we want to get R/O pins
> right.

What I ment was a page that is GUP'd RO, is not PageAnonExclusive and
has an elevated refcount. Those cannot be transformed to
PageAnonExclusive, or re-used during COW, but also they don't have
problems today. Either places are like O_DIRECT read and are tolerant
of a false COW, or they are broken like VFIO and should be using
FOLL_FORCE|FOLL_WRITE, which turns them into a WRITE and then we know
they get PageAnonExclusive.

So, the swap issue is fixed directly with PageAnonExclusive and no
change to READ GUP is required, at least in your #1 scenario, AFAICT..

> There are 2 models, leaving FOLL_FAULT_UNSHARE out of the picture for now:
> 
> 1) Whenever mapping an anonymous page R/W (after COW, during ordinary
> fault, on swapin), we mark the page exclusive. We must never lose the
> PageAnonExclusive bit, not during migration, not during swapout.

I prefer this one as well.

It allows us to keep Linus's simple logic that refcount == 1 means
always safe to re-use, no matter what.

And refcount != 1 goes on to consider the additional bit to decide
what to do. The simple bit really means 'we know this page has one PTE
so ignore the refcount for COW reuse decisions'.

> fork() will process the bit for each and every process, even if there
> was no GUP, and will copy if there are additional references.

Yes, just like it does today already for mapcount.

> 2) Whenever GUP wants to pin/ref a page, we try marking it exclusive. We
> can lose the PageAnonExclusive bit during migration and swapout, because
> that can only happen when there are no additional references.

I haven't thought of a way this is achievable.

At least not without destroying GUP fast..

Idea #2 is really a "this page is GUP'd" flag with some sneaky logic
to clear it.  That comes along with all the races too because as an
idea it is fundamentally about GUP which runs without locks.

Jason
