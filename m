Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D516A231278
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jul 2020 21:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgG1TWk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jul 2020 15:22:40 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9023 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgG1TWk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jul 2020 15:22:40 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f207ad30000>; Tue, 28 Jul 2020 12:21:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 28 Jul 2020 12:22:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 28 Jul 2020 12:22:39 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jul
 2020 19:22:39 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 28 Jul 2020 19:22:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoO1d3DIh7z501b14K819h+Tp++qMgQ4Q+BA5A8AoHLDDl1NS2Uqj1GMFTITGizXuz4Gar7hTuAlUz6igLzcDJWTcbRpgGWrTAzePLOl1mw2cvUDM4OTD9heIQU1WHdidNnACfmw67vhig2pqXueT9iBWIUOE8vqRQaDmUPCI5Mu9BUX7HsXkgFPct+4DAM5sIKYIPaFLCD7AqebMiozbQtm591I6DmEYb7LLT2Dg+NF8WziXt6bEG+k5+nqccYPG1W4Nl/XOyvUyhchSrgd4fkVe1Hdbyx1fklahKlNKSV7Vz/x3QZYwKm/tmLNiKfYmDliNGC3o5MToh7Xca1Ucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCsQK30MC+KPFhuIX2bn2gQg6QTFzEoklBLmT8M8pJQ=;
 b=I0jrEZ15dSbcnywr71mNmMY/CqoICsQgrK4M0UzmdV6a4klE40hPIFD3T9aX1kckLfpez5ZaS6RSN7NaZJ7xFiq/gQG7alUYHvtIIJHjYf+HSS89aLvDig96ykwIVowGBzh5LDPuzSBFL0UFJEd/nL5hsW74s2brh4wE0ldgHL2gqL5a4xC7IjlWk6T/W+LL+1eYIKx6ouK0OBsDJgTwxzM0LkjivL4ZYxgl/ly6JJ1sM2f1szm9VEj3RtVL6e+4OCqNJ/O6m4pp+aWY2Y7Jb/816gqF1CCT08Ut/iGpie5Vvhq7C0NepZ/2oCvUTsnlzgw6puT/ND3F4JfvNrty4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 28 Jul
 2020 19:22:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 19:22:38 +0000
Date:   Tue, 28 Jul 2020 16:22:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <kvm-ppc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH v4 0/6] mm/migrate: avoid device private invalidations
Message-ID: <20200728192236.GA160260@nvidia.com>
References: <20200723223004.9586-1-rcampbell@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200723223004.9586-1-rcampbell@nvidia.com>
X-ClientProxiedBy: MN2PR19CA0025.namprd19.prod.outlook.com
 (2603:10b6:208:178::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0025.namprd19.prod.outlook.com (2603:10b6:208:178::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Tue, 28 Jul 2020 19:22:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k0VBM-000fiC-W4; Tue, 28 Jul 2020 16:22:37 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fbdfff5-948b-405c-d249-08d8332b96ee
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB340351CEA0362F9595A1049AC2730@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WJ7fn2YLcPN3sDYR4801kDZmXn40UmJP4E6MBNgS+GJJDXH23FmAw2oaeB/NH4RneKtxxeHSCLo/7aVl07/AFay3WoKYYLOkgDYN5jCav7pRsN18Bs5FWWzdGlUblzBYVEPKzU0pamajRM6n5HNfsaYKAk1B6WxVGeVggN+M64JZHDevz6w+VVM29i+fIwqM7bXPaV3eHws0A3AetGvRxdMoNc7gwhYN/UPKzX2sQNuMLix9rqZqa2jJkPuc9+sHiK4/5KJv6OBqyGMEFo7mdXoA9JlLkS1ocjNXOqkZ4JvrRln7zrIXLmPRi/RYaZ40/mh4KEUPTb26RM3UpTU98vozJoaySz0dgFGoxLTfPQTMpU6Sk1QQPBefkL4GFo3ul9Y/NbuMNQP4j4B/jBjbnn96YB6BMS5VGWWNRo8FzioXp4E5K0FWPhxx3pwRgTd9vtKjK22PKu95vLhhUJVxMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(7416002)(2906002)(33656002)(1076003)(83380400001)(5660300002)(478600001)(6636002)(37006003)(54906003)(966005)(8936002)(66946007)(26005)(66476007)(186003)(9786002)(316002)(4326008)(36756003)(426003)(8676002)(6862004)(2616005)(66556008)(86362001)(9746002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: osZagDZOsJ3nqUF0uhm5FxoYab2bMulBn2Iye0wgJSbxfcEJ8+GKeaEUSIqbINCxj9UvhCocIYf8kGdMrc3T9vV+wKwDd2S5qh/V90fQkLwR23sawKgHJwsnWdsCeNXKGgxAoDTD3dl5CnxwekVoXArFh4XatIiQK7LDI6axt5HVE8DZ0O2ZGR42CInnhbjFKF5vhBVAcxrbnhu9Ce+N+52JLMfHC9AH4zLPDZP0RTJ5VB6fJG19dBZsymS/gS7OnZ/ELQRsCIm2f7THtDMUtOJJigFS72RBZzNcScZ2G5UQmDZWqJPi+SIdfnoFENlChgf0EISrGIQ8Qp+Sna/5OKadHQGVtOIiBiffVmE+sHHMU7NCdR1mJ5NGz5edXJ+fiYLMNwcYR2ukMTuorLst/4eF6oDyiRrjWaZTG5VR9ZY52boRF1Z81htDnjMaj/OuV2cWXdAHv9PM6MLS/NNCt5BFR2aDE11LnWenfGPmnvY=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbdfff5-948b-405c-d249-08d8332b96ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 19:22:38.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TWuf7+1Jt6enjHI7IKW12ex+FwRsGVxXM91iS+lvwjUq/UIonQXM82FGO+r+5b6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595964115; bh=JCsQK30MC+KPFhuIX2bn2gQg6QTFzEoklBLmT8M8pJQ=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=LOlvx0c15P4DaY67cjAr8xv+XU5CUTwOIUA5VzLsAqgZUMrtXUqLcuM4mjC8SRn/3
         THVUZGrXBPogYkXvvVSkl+he2grPHFp3q5z/3eWNidyirpi1Rl6P6fE6kVaC0zoSom
         2bZ77FuaMhPU2T61bUuh5QTdZj3wp6bv9ErsA3L737y1oZ8EU/Qc93Cn/iZDpEi2rE
         lhlVATKtASPIGkfZG++1TsdyJNgZotGP9EugT9X3mMqOm/1wB/s7nohzlVG71Gk7aK
         9nIWr35TPD4pipIvo3vX72yhoDuRPyy03KGCZRZaBSpjndRirjwvELA/Cy5r5MGV3g
         LoYBG0Pm71SMg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 23, 2020 at 03:29:58PM -0700, Ralph Campbell wrote:
> The goal for this series is to avoid device private memory TLB
> invalidations when migrating a range of addresses from system
> memory to device private memory and some of those pages have already
> been migrated. The approach taken is to introduce a new mmu notifier
> invalidation event type and use that in the device driver to skip
> invalidation callbacks from migrate_vma_setup(). The device driver is
> also then expected to handle device MMU invalidations as part of the
> migrate_vma_setup(), migrate_vma_pages(), migrate_vma_finalize() process.
> Note that this is opt-in. A device driver can simply invalidate its MMU
> in the mmu notifier callback and not handle MMU invalidations in the
> migration sequence.
> 
> This series is based on Jason Gunthorpe's HMM tree (linux-5.8.0-rc4).
> 
> Also, this replaces the need for the following two patches I sent:
> ("mm: fix migrate_vma_setup() src_owner and normal pages")
> https://lore.kernel.org/linux-mm/20200622222008.9971-1-rcampbell@nvidia.com
> ("nouveau: fix mixed normal and device private page migration")
> https://lore.kernel.org/lkml/20200622233854.10889-3-rcampbell@nvidia.com
> 
> Changes in v4:
> Added reviewed-by from Bharata B Rao.
> Removed dead code checking for source device private page in lib/test_hmm.c
>   dmirror_migrate_alloc_and_copy() since the source filter flag guarantees
>   that.
> Added patch 6 to remove a redundant invalidation in migrate_vma_pages().
> 
> Changes in v3:
> Changed the direction field "dir" to a "flags" field and renamed
>   src_owner to pgmap_owner.
> Fixed a locking issue in nouveau for the migration invalidation.
> Added a HMM selftest test case to exercise the HMM test driver
>   invalidation changes.
> Removed reviewed-by Bharata B Rao since this version is moderately
>   changed.
> 
> Changes in v2:
> Rebase to Jason Gunthorpe's HMM tree.
> Added reviewed-by from Bharata B Rao.
> Rename the mmu_notifier_range::data field to migrate_pgmap_owner as
>   suggested by Jason Gunthorpe.
> 
> Ralph Campbell (6):
>   nouveau: fix storing invalid ptes
>   mm/migrate: add a flags parameter to migrate_vma
>   mm/notifier: add migration invalidation type
>   nouveau/svm: use the new migration invalidation
>   mm/hmm/test: use the new migration invalidation

Applied to the hmm tree with the modification I noted, I think all the
comments in the past versions were addressed. I will accumulate more
Reviews if any come.

>   mm/migrate: remove range invalidation in migrate_vma_pages()

Let's have some discussion on this new patch please, at least I don't
follow it yet.

Thanks,
Jason
