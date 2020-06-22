Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FD82036F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 14:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgFVMjz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 08:39:55 -0400
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:35809
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbgFVMjy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 08:39:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AP0fIm8eIL6gBjbXpBT2M1dc0zOUDdqi8tBmcGBJTKOM4RJxGyEPdmBL+X8ODzJdV3IShu1wH2GgrOM7zPAtUkL/yfDw7DowuheyVpF6ZeHt1C0IU/ryN4xtOK3zVZFCUnKuG0tRBPhl3ni7DyWBD956kVif0EjzOt2pd8z+PlbzKjhwbVdvAF3SKqaWBk7TRQpUlIO+paxcErBmxQEVkLKZbIFMEnXiriihLcpIO1cTOIZZo1wkDXmMvG4OW0xNlwxvfvtL+QijZZT7OS+ZImMURBM1d72iDH6r8+Dyl9rsvuMcn0LsZC29KtmyH8T4ypBqsTDrbfMBw4JnSOb9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1K3W9D2CAIdaMZ2eJJRaCFYV5/wZE+UtaAcLp9SRgs=;
 b=T9EEnKTezHSS1HLgHSzQnTrwJhI/gEafwyffNFvEAgSn9xwFfnZotJ4xXxmnlVs52qH/eqlIsBUA4H1b2zuaoeTP0CPayKTRQPNnayHPbY0ZfwIM2JufHbIm9cEfp49wM+6vvFDXO6SZIhMrjPrp+Kidfdx/TAKJGzVCtEx6NHgq+UwCOJExkxsuBB/D7scTcz5WQpEB2+i8wS0Jfi7UZyFr94z5eU3Wnh4mEVNZLeS6cl565jUpI1gBbthcyfZSKMV2a/qWzkA8gWq2CXjhmWPmfn4NyLJEyJDRFBW29hKH3cP33NSXc8sziB0pQFnS3UyJ3KevnZgmLvZDRwQjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1K3W9D2CAIdaMZ2eJJRaCFYV5/wZE+UtaAcLp9SRgs=;
 b=pOaARyiZTEmm72NN0IdoN3cfSQp5FIJ1SGJv/d1SRevkRsh8Ni070O+5nwkdvkwM3QaQQvL1lBP5bV5fdjyIpyBKTp7FmyRAMWVoO1PJCT3vtwDIeVFglUivOZfKxmV/QoJa0ziSvdRBFQOGEH1bJKVoLtJmJ4Kiztp99sUMldM=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB4702.eurprd05.prod.outlook.com (2603:10a6:802:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.25; Mon, 22 Jun
 2020 12:39:50 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 12:39:50 +0000
Date:   Mon, 22 Jun 2020 09:39:47 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 00/16] mm/hmm/nouveau: THP mapping and migration
Message-ID: <20200622123947.GC2590509@mellanox.com>
References: <20200619215649.32297-1-rcampbell@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619215649.32297-1-rcampbell@nvidia.com>
X-ClientProxiedBy: BL0PR01CA0031.prod.exchangelabs.com (2603:10b6:208:71::44)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR01CA0031.prod.exchangelabs.com (2603:10b6:208:71::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 12:39:50 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jnLjn-00Bt6R-52; Mon, 22 Jun 2020 09:39:47 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 751cebd9-7b35-46be-0431-08d816a95b0a
X-MS-TrafficTypeDiagnostic: VI1PR05MB4702:
X-Microsoft-Antispam-PRVS: <VI1PR05MB470271E4FEB6E385D7F352E4CF970@VI1PR05MB4702.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMHw3hZKMymfaINzJj5CBQbB3lHLKD46VbCUtqy53Q69xeSoFrISsbudZYm57hKL9HTQ2aqcIF/xfOa/FUUzMRf1xqfNVpWhzzFzCC8Y3H8SKYuYThujhsTqUEbMAsyApFS0NAqn27AEC9b/g1IxXXtQ8MsiWJ8BrhtJhZ/WFz3vmNXBPmvidh4CmFzVmjzXhuighDOD15Fj6fiPd9zWPx3ekdsBnzLBPW7p/aZiCYNJWwMnXFrRMkShLdH5alaODiJ9a3i6xajnJzKgxdzxP1hqDSYpCpnXRRDjTHMexH5qIlPaTJdu8JFhRosCuiIOysewn81ExFVDOQA9JUhkJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(8936002)(6916009)(186003)(26005)(1076003)(316002)(426003)(4326008)(8676002)(54906003)(83380400001)(2906002)(33656002)(5660300002)(9746002)(9786002)(36756003)(86362001)(2616005)(66476007)(66946007)(66556008)(478600001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tLNNxONQZO6jW+hpHfyZgIH4ekJEEY76iBbMYz/8FNO3wxQPzfWFq3Odq7G4TWT6ABx+FHBvHZwmz8kx3UjhKDksB7vj94wbWU+LQDYv0V5WvLaMkJQsXGFSj3jgmu7hDEXxHrbgpdUW5i93VB3NguMA1Oa4MKTWBVD8jNQNkdG3X/X8EP3XTWb4LgFI58kENa4x4U6n/zUmPWQvERH971WippoG425mD9tdpWq4Qo5C3n5urcpRbQurRf2Sj1MURdQfEwb10irvDYfWPCdshUbE3q6gLfPsJrOHez+yAa4MJ2J3wTZBNXjbbdvV/0zycr4BL5Drtu25Dx62pSSuqMnOC39+AVXTYMPIlqTdkuT+pmNmjbuAPnAiPG6ouIWKI/Ngt/m+ZDclKT1Zw5GJ0DOW66kV5Uiu8BuQzWygmNy016o7AQ8Gjy9qcA6Ud3PA39PjkQc+DEXPdvBkHvPXO5OWwC/i8tM0ja7JpaZPGP8=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751cebd9-7b35-46be-0431-08d816a95b0a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 12:39:50.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLiVITWOJzttNzWnX+aFlNoYNmvhsxk0rQ5aLv4lUo/rd3WlD+tL/RYu4y/qiU7gmFVLwyBOB+qC4ZS5L4BP1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4702
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 19, 2020 at 02:56:33PM -0700, Ralph Campbell wrote:
> These patches apply to linux-5.8.0-rc1. Patches 1-3 should probably go
> into 5.8, the others can be queued for 5.9. Patches 4-6 improve the HMM
> self tests. Patch 7-8 prepare nouveau for the meat of this series which
> adds support and testing for compound page mapping of system memory
> (patches 9-11) and compound page migration to device private memory
> (patches 12-16). Since these changes are split across mm core, nouveau,
> and testing, I'm guessing Jason Gunthorpe's HMM tree would be appropriate.

You need to break this up into parts that go where they need to
go. Nouveau rc changes should go to DRM or some series needs to
explain the linkage

> Ralph Campbell (16):
>   mm: fix migrate_vma_setup() src_owner and normal pages
>   nouveau: fix migrate page regression
>   nouveau: fix mixed normal and device private page migration
>   mm/hmm: fix test timeout on slower machines
>   mm/hmm/test: remove redundant page table invalidate
>   mm/hmm: test mixed normal and device private migrations
>   nouveau: make nvkm_vmm_ctor() and nvkm_mmu_ptp_get() static
>   nouveau/hmm: fault one page at a time
>   mm/hmm: add output flag for compound page mapping
>   nouveau/hmm: support mapping large sysmem pages
>   hmm: add tests for HMM_PFN_COMPOUND flag
>   mm/hmm: optimize migrate_vma_setup() for holes

Order things so it is hmm, test, noeveau

>   mm: support THP migration to device private memory
>   mm/thp: add THP allocation helper
>   mm/hmm/test: add self tests for THP migration
>   nouveau: support THP migration to private memory

This is another series, you should split it even if it has to go
through the hmm tree

Jason
