Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BC3226E6C
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jul 2020 20:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgGTSka (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jul 2020 14:40:30 -0400
Received: from mail-vi1eur05on2044.outbound.protection.outlook.com ([40.107.21.44]:15680
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbgGTSka (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jul 2020 14:40:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxRpbaa2GqJvMF97PiL9CfA/CHfmqksF9zuJxHyArhv1PtDGDCndiMJVhW7/2ckvoJ501KXGqyv7nvWSDUx6/v0BYcRy1/iB1q8nZDNvNqvEPg77rUqGbrrkD26WvAwzm+YKZO5sU3//gmSmc04iEBl9p6lud/HBDBPotsOMkmRQxLHjcja++t5F5IfsYzfjp7+etWLZ+4RRO+gCX0HuRJn0BYJmZqhm5dL7rS88I+faYIIzENAsJG3hLFYbj4TH3d6a0ItxY5ChNIDXHVw7y+ESbnrsKzcu7QROwLsmqQgMX4B71W0kKT9iHD3zdm/snEtNwcG7AnPq5YqM1VyLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npWLCLv/r6IgBRYyM/CL6ujudwIX7pp4cvV158l6ikk=;
 b=Xi7q/KQFH5tkjHU5hPArUQslEzznxySEcEvtX3+ncLiBjqoPzKiUHD289SUJ75c/NLjAfwauApdbSHTcVVsbbV8O/J30JYsx1AuYpvAKsgVaTqzKYkZEVf5KZL/W6dVh36HHRqytaSq1mB/eDy8ZvgnnzlD63Lo8Wu9Xcmq4SXY+ceQNGfxtjXiULksjRgcwDyle/YpDjwM4f7wI+BFWlqLHaBqq/VXN2SvN1R5NM1NXEHqxW9lmgxa4jc4f2bLvoV3cEmNGkE9ZJKcvyK57cL3X1qHazLNoUvibm2V74GmoYMjIus1C/yanPy8wBAnfDcHaD3vAB8LGPWqFj94zuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npWLCLv/r6IgBRYyM/CL6ujudwIX7pp4cvV158l6ikk=;
 b=WsgWAICM/6SMvMlJxSYRUC42u6uB+iq7gPw18bIB4OZy/j1znUE3tZ9l0nrSr1Bek7Vg7LBdBumaaEm4WQGpw40UvuFjpK2moOGZ0ltbbBAFm6Hu1N1O6ktGH+1Tk+r9tK2OM7f8uxq1dBG/SX1eQ0cPdx693XP3w9Zg7M6dcRw=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6143.eurprd05.prod.outlook.com (2603:10a6:803:ed::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 18:40:24 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::252e:52c7:170b:35d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::252e:52c7:170b:35d%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 18:40:24 +0000
Date:   Mon, 20 Jul 2020 15:40:20 -0300
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
Subject: Re: [PATCH v2 3/5] mm/notifier: add migration invalidation type
Message-ID: <20200720184020.GS2021248@mellanox.com>
References: <20200713172149.2310-1-rcampbell@nvidia.com>
 <20200713172149.2310-4-rcampbell@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713172149.2310-4-rcampbell@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:207:3c::23) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:207:3c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend Transport; Mon, 20 Jul 2020 18:40:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@mellanox.com>)      id 1jxai4-00CiFI-K5; Mon, 20 Jul 2020 15:40:20 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92c303b8-c85d-4ba3-a5f3-08d82cdc5d56
X-MS-TrafficTypeDiagnostic: VI1PR05MB6143:
X-Microsoft-Antispam-PRVS: <VI1PR05MB6143FCE5995166741DA1C983CF7B0@VI1PR05MB6143.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBCYsUaeVOm0QrH/Y3PseZ+10cLYXOcbqvbTX5EZ8bR9sODEbzYcaOjsZUwvoMQSR05klVSiYXJQ3IMDMN+ZIiOMCcY19YX7+ZMqlnNfxu6B7Nul3p0XS/KhoK+v74ERQJkl0pnVMUAXWQt6/Rxm7oYEJlhoBgXH3v+wNvV/fhyDV0mcV8GLVUzEcTaJXKW7dQ9bqzWbsvAfseeu8CWFteteGSSqJHO648yK8dh7BAEWxjbVCA0GqG8ySTawadFnS2iGn/lSzRWyNCkXZ7becAJWvO3SXEllz3asgl8PlVAKXiePmXcWgpx2ypx3dHaoLR3G4EE0ywDCMx5qZIoWXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(2616005)(426003)(86362001)(4326008)(36756003)(66556008)(1076003)(7416002)(66476007)(66946007)(186003)(8936002)(26005)(316002)(9746002)(8676002)(2906002)(33656002)(6916009)(478600001)(5660300002)(9786002)(54906003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WkkM8ahQ828K78k4gLxlcnpSQQxy0nmdFrhKS5xoMJNrYNNYVGaZv8GBD8B2B0cMENiR+1w+8U0DVraY9BTqjtINrGHHf9oKnfYxHrl/gGLl3o0n6wmi/gnNgmWw1VgMYcHBmj9VmxF77/kOaUBg04Z3nVhF+Dsd4D9AOi6yYK2Qf9zdTf0BBevXBsU4KlqBITGeQQm6Jms0mNFDT6xuOCxLu3jkV7oFfbNZEMbrtWWnCj2XQ/xC5FY4vY4AAWTzzpSxcevZ+tzP5qC2IeamkbHdp0RDxbE9JQqX985O8szLKJPfC+2SjfFF+5CrwVlnnV2KfDAEK+LTx0/+de2yetMx6dm3GDkrriyr+M2pZc89pt20bUpwCGsSr5ss8VhsHBUx8PP+vO1/xMZZVyr5sq88Wo6mOaXSGK+hSy0gm4KB+VTFMkmMkNr7SDvBKhJTiPPexZebjQUu9gGJ4gMzRUUh8V31HYKCYtp+xm/2NIo=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c303b8-c85d-4ba3-a5f3-08d82cdc5d56
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB4141.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 18:40:24.5380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjDU8XZID2ZkY9KchkhTfbNRpeYoC398mUAyhX5h9QzaM9141xI3vVk0CabRT0uiP7V/ZI4se3s+JF+11jBCkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6143
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 13, 2020 at 10:21:47AM -0700, Ralph Campbell wrote:
> Currently migrate_vma_setup() calls mmu_notifier_invalidate_range_start()
> which flushes all device private page mappings whether or not a page
> is being migrated to/from device private memory. In order to not disrupt
> device mappings that are not being migrated, shift the responsibility
> for clearing device private mappings to the device driver and leave
> CPU page table unmapping handled by migrate_vma_setup(). To support
> this, the caller of migrate_vma_setup() should always set struct
> migrate_vma::src_owner to a non NULL value that matches the device
> private page->pgmap->owner. This value is then passed to the struct
> mmu_notifier_range with a new event type which the driver's invalidation
> function can use to avoid device MMU invalidations.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>  include/linux/mmu_notifier.h | 7 +++++++
>  mm/migrate.c                 | 8 +++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index fc68f3570e19..1921fcf6be5b 100644
> +++ b/include/linux/mmu_notifier.h
> @@ -38,6 +38,10 @@ struct mmu_interval_notifier;
>   *
>   * @MMU_NOTIFY_RELEASE: used during mmu_interval_notifier invalidate to signal
>   * that the mm refcount is zero and the range is no longer accessible.
> + *
> + * @MMU_NOTIFY_MIGRATE: used during migrate_vma_collect() invalidate to signal
> + * a device driver to possibly ignore the invalidation if the
> + * migrate_pgmap_owner field matches the driver's device private pgmap owner.
>   */
>  enum mmu_notifier_event {
>  	MMU_NOTIFY_UNMAP = 0,
> @@ -46,6 +50,7 @@ enum mmu_notifier_event {
>  	MMU_NOTIFY_PROTECTION_PAGE,
>  	MMU_NOTIFY_SOFT_DIRTY,
>  	MMU_NOTIFY_RELEASE,
> +	MMU_NOTIFY_MIGRATE,
>  };
>  
>  #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
> @@ -264,6 +269,7 @@ struct mmu_notifier_range {
>  	unsigned long end;
>  	unsigned flags;
>  	enum mmu_notifier_event event;
> +	void *migrate_pgmap_owner;
>  };
>  
>  static inline int mm_has_notifiers(struct mm_struct *mm)
> @@ -513,6 +519,7 @@ static inline void mmu_notifier_range_init(struct mmu_notifier_range *range,
>  	range->start = start;
>  	range->end = end;
>  	range->flags = flags;
> +	range->migrate_pgmap_owner = NULL;
>  }
>  
>  #define ptep_clear_flush_young_notify(__vma, __address, __ptep)		\
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 2bbc5c4c672e..9b3dcb81be5f 100644
> +++ b/mm/migrate.c
> @@ -2391,8 +2391,14 @@ static void migrate_vma_collect(struct migrate_vma *migrate)
>  {
>  	struct mmu_notifier_range range;
>  
> -	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL,
> +	/*
> +	 * Note that the src_owner is passed to the mmu notifier callback so
> +	 * that the registered device driver can skip invalidating device
> +	 * private page mappings that won't be migrated.
> +	 */
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_MIGRATE, 0, migrate->vma,
>  			migrate->vma->vm_mm, migrate->start, migrate->end);

So the idea is that src_owner is always set to the pgmap owner when
working with DEVICE_PRIVATE?

But then the comment in the prior patch should be fixed:

@@ -199,11 +204,12 @@  struct migrate_vma {
 
 	/*
 	 * Set to the owner value also stored in page->pgmap->owner for
+	 * migrating device private memory. The direction also needs to
+	 * be set to MIGRATE_VMA_FROM_DEVICE_PRIVATE.

To say the caller must always provide src_owner.

And that field should probably be renamed at this point, as there is
nothing "src" about it. It is just the pgmap_owner of the
DEVICE_PRIVATE pages the TO/FROM DEVICE migration is working on.

Jason
