Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC09226E72
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jul 2020 20:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGTSl2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jul 2020 14:41:28 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:38630
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbgGTSl1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jul 2020 14:41:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHsnoVvu7PLcJmW2Lfn5m7JU64aSAPHYhvYP3ePrt0iHm2latfCwIYLM18lROJfCy8+jwmdPFIO5cskbgSVm8JGhF7Y82xWDb5aGkFthaaUw6VAgDi5BYgW4ulok1gg+91RxO3HKFWpziQlmEJGpjLN+mGeueuXNhJxS1TivEqBVdva+m8jUovW0L9Q92Ig92Ef5aMSsh7Hi+c98Ok/1LQSwm36ZgNJQyrELdM/hsS7c9pyNSlvK6+qsBKJ244AdsxEK1+wcBg+1monizGhLqWRzWZAGvm2D7t2W6O6XZq0yQO2UpUtkXtAs8Aq41d1V+k6jyo/N3ltG3trl7r0Cmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuV7D4oY0U/teMa4pKvUrVJF+FasoeCpfCzJWQiXqV8=;
 b=Lb/wffJEYbJ88IMhQPdf65IWG8/sQsIamN5Gd7cNQValGrW0x7X/KwunMCbx9axDgELhstzZE7piu1EffYOoEYuafK4IP5x7A8WCNpB8NCFwbCUgEWMlfleDMwwPw8E/HMdPAHwd4ihyMu+meLOU5G6mhEOfoTIFKB06jZ1A2Vq0vDBzoHllKr//SuTflR0Bi9ZESC53yO2otqLkWAWHQlZwYS3J9AX9wF4MsGdiV3GRKL6wRV9lfux/WOGlY3hkfdHtqkm/W6SuS8RnPEOdrc+GsNERvPZPvvsE2qErjJf+jLobWuSvoCHCXx0sHJXTXtFMYAOCrBtWExwkcHn6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuV7D4oY0U/teMa4pKvUrVJF+FasoeCpfCzJWQiXqV8=;
 b=jgf+V4CaWpgyzvQ/Yu+u1pJiSc57kdIxjDm0eiCgZtL03EOEGytMlAoRyLpVTtTeenb6eeL6jWf4SvDluD+iGTHASoEi7rir0jOR+0EH+mR4Kl5YZGTk4A3ZyazbSf8DACvFvcxYiKgToEtiO+FF3EeX3MO8bi3IL4NzIwyEyuQ=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6350.eurprd05.prod.outlook.com (2603:10a6:803:fb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 18:41:23 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::252e:52c7:170b:35d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::252e:52c7:170b:35d%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 18:41:23 +0000
Date:   Mon, 20 Jul 2020 15:41:19 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, kvm-ppc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH v2 0/5] mm/migrate: avoid device private invalidations
Message-ID: <20200720184119.GT2021248@mellanox.com>
References: <20200713172149.2310-1-rcampbell@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713172149.2310-1-rcampbell@nvidia.com>
X-ClientProxiedBy: BL0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:91::19) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:91::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.16 via Frontend Transport; Mon, 20 Jul 2020 18:41:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@mellanox.com>)      id 1jxaj1-00CiGB-BZ; Mon, 20 Jul 2020 15:41:19 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 99bc6b03-5179-433b-cc0e-08d82cdc8011
X-MS-TrafficTypeDiagnostic: VI1PR05MB6350:
X-Microsoft-Antispam-PRVS: <VI1PR05MB6350C98982D47F75BF5AE999CF7B0@VI1PR05MB6350.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTmna6L+SxuOgqjzIazPQi31+1L9vYtXgG1x0o9oyNXw3s2WnT7Mp23RygbC2PhWt0kYpTEfPEIC+RuKLW7k/+An5YUX5fBnVQEHskS8nFJSgDr3VI8gqNWc/AdzNHx+90BIad2NdbwwGiVKyHcToyISK1GsswBFNYCsU2n/Jd9W4wAj8X0H0apiy3PiTExzjJEbZjA4Tec17FEpBBtTkjU4wm4FhrtJTbShEq5zxC/qxWY2RvejeoedPw1xp3ueh5cU0Ciq8u0G2U8fRNecWr5JFMrxZsYCX1qWOsmA5nR1ZsbRWCHlM0cEsZxjumSgO4kkgHbIgg63+fGXZSpPbjRYzvtXILwZ8RGk3UMwM3bR4EmZeLbuGw5ZwNTdkqqvOe1kZqVKq7kD2uWN8wgofA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(316002)(5660300002)(83380400001)(4326008)(36756003)(2616005)(54906003)(186003)(2906002)(9786002)(9746002)(6916009)(33656002)(478600001)(966005)(66556008)(86362001)(66946007)(66476007)(8676002)(8936002)(1076003)(7416002)(426003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +qpNMs4w2GiR4zLiQU32mOzLviyYudflbdZziPSUD2aOAqPcOi7htZPWAwjt1iC73dbtu3DjIEx/4+uE6uBOjOV77LNTQMM1PyKsVSl1pZm3uXZMQ5T8pm/Mw/HDAq606SzuhlJsNRksV2wqw9dxFUb5eYzAuJzLp/HXcvzb53UWlctIVEwqCi3TrgQGFyDKiF0hvuMQP8SPmnY3Poha5XNM7xyzvfQtYUeH3ndfZfKgs/bUQwxNrZODUiN5lT7CgHXDkqifc4pBRjPFW3ZUtR7U3NJTH39HRQzRzquQKfkE5PkPBDPigd6O7k1CgmAwBVsaFjtl0q/D2tNBxwg3kvfvReL8cmXNxJmjYz0lkumCuLEgYWiAODsboB95otQ3AcPWeHHT15ISh3vIarRGLSyv+h6RMw7BYgAXTb+eM9gWGSmeHVxw7pPNswPvC7N+D1MjNgaIB6mGCUJhmMutcDk9IIU384v1XaXCZK44p3s=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bc6b03-5179-433b-cc0e-08d82cdc8011
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB4141.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 18:41:22.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+HedT6gQz7+ofvOqFHshDGG32ybmROra3iabtkFqGt2b3d8/SOuvEXN7kN7sKIRwsDvklXc8m3/10pXhdt/TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6350
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 13, 2020 at 10:21:44AM -0700, Ralph Campbell wrote:
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
> Changes in v2:
> Rebase to Jason Gunthorpe's HMM tree.
> Added reviewed-by from Bharata B Rao.
> Rename the mmu_notifier_range::data field to migrate_pgmap_owner as
>   suggested by Jason Gunthorpe.

I didn't see anything stand out in this at this point, did you intend
this to go to the HMM tree?

Thanks,
Jason
