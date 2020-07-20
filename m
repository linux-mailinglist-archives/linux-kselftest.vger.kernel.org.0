Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7E4226E67
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jul 2020 20:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgGTSgw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jul 2020 14:36:52 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:17673 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgGTSgv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jul 2020 14:36:51 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f15e43f0000>; Tue, 21 Jul 2020 02:36:47 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 20 Jul 2020 11:36:47 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 20 Jul 2020 11:36:47 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 18:36:47 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 20 Jul 2020 18:36:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY8/sjq9c9J8KbuHCvZOw2MHWSJEs/rvmrLFS9UAjyU0h5rWGqtM+P6kQfcrsgLXDK13kbliL9201NfCFr7ZY/qXy6/+UhY38MXU3LrA2Ojyhlag8O3JHokd6MALba/0kWfr13A97U5H84zMlNfrM5mojRevuaMgs3wKeTYx6Cb5eJnMZoZs8mfJV/o2qLtQSGJpvrHeQauxeUR8tI1x/TJAcax/3jK/QM6szmWWxe8BPJzomalqEV4uONLzE8rh/IIIEfsQ+uYAMu+MBIy+ep9bjDze80LNBrAuObV7tB5iK4FgBzBDoeLxJd/RVjsEn66jziNXksMd97DUX/Zv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRJMNpLw9h0OX+dwUH71xKj7w54MkBUWfISG60qBweI=;
 b=EgUlD6hJEZwHxv1Vrd4Egka+gmXgNTgQy0Bov2cyHUeprEbDA3O/5fHNZrf68/avKdCnqL6PnfFWQX+WZexMsp6Gsia+zRr4GmxlCaqXs0JaSa34IA2Vu/Hvbe61IHaAYIZ7XeBNJ2Z5ZhVesyRkctMfBjK7H+cdh+45gHhvG/RII8s0oUPbmz1OQZzKVZl/TnknJcv9XCRw0UzQUGRo2Qual3equfmT7pW87SYKNp0417whG0fCH6nSTJkw5I+Yvvv0wE4FSSkAfXDuw9bfKeVdp1prMVtjvMpYsdSRPF1zRLQAlDmfqBBBmIarvJgNPOJ/v3XaB+H9xVpXUNbEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Mon, 20 Jul
 2020 18:36:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 18:36:45 +0000
Date:   Mon, 20 Jul 2020 15:36:43 -0300
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
Subject: Re: [PATCH v2 2/5] mm/migrate: add a direction parameter to
 migrate_vma
Message-ID: <20200720183643.GA3028737@nvidia.com>
References: <20200713172149.2310-1-rcampbell@nvidia.com>
 <20200713172149.2310-3-rcampbell@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200713172149.2310-3-rcampbell@nvidia.com>
X-ClientProxiedBy: MN2PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:c0::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:c0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.14 via Frontend Transport; Mon, 20 Jul 2020 18:36:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1jxaeZ-00CiAW-3f; Mon, 20 Jul 2020 15:36:43 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c808207f-a1af-4cf4-510b-08d82cdbda24
X-MS-TrafficTypeDiagnostic: DM6PR12MB4500:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB450021D2A4FAE4168D3A7B19C27B0@DM6PR12MB4500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xgt2rZXayLO6UrkgewBx1TR9+l+I2PISPyZyIPvTuwEgYCdH8MDjv5q+dY1SsV5nICCABnIcvdffPuK8RJbnu8Eg4Tgyq+DA+i98xbmTQKp3mHIHnZm0ijE7PJ/kKx1Q2vPuGyjYYRezrD/Wj4IKDdHUHio9NhIkx/7RBr3xcJ1pSq+dPQMQQ3gsqsY7WkJLKSQ/jFNzSDoE1Hp1mH6SXWnyz0eF/9NgoHDwGwX1QQZdK1gPUmubmDdeZVsYEzJmyHXwhFHsvUHu38Hb919gU4i6ED1Ze0PFUhObuSA6heSxLTB42V/prP4Q8mGO1ytS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(66476007)(86362001)(66946007)(478600001)(426003)(26005)(8676002)(8936002)(1076003)(7416002)(66556008)(4326008)(6636002)(83380400001)(36756003)(37006003)(5660300002)(316002)(6862004)(2616005)(33656002)(2906002)(9786002)(54906003)(186003)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Ciy3jYTXftI+6cFABjqu4GWifZFfJxyZPIuoKpLxL/mYixyr5856X/EG/8odG5Y32iPTZqfmZydiY9uD5JkCZeVu8DvW9fALWmGqz2HEhAmIxCkMd9VPkBBLd6kYsp10/aam7zV2NTXOeQGrTbQtFcEc13Voqw7mSFsCx3mW3V4bhTBRG26K+ysagWKzWVvDR+TOFR60VC9CoqsHTheBuZJtQi6UN0J/jyXefca9mQuqaosmlaVfQcf9coe8DMlHJ7TH6qqOvVq8L9WufqN81SlG3eoe4IEBTiJ276Z7dZJb6vmwHkwrKseKgjtQPSXoFEOlp2uN5UcJAITwNT/8IfuawSfBUAkH4wQOzdZK35mZ7TTd35C4wvrAiKZ4HNN0k20bNQsTu3Nx9lU2LU04OY7CtGV3jRcbe/97+tEoBRDJ3e2n8UjP00eIePrMcasOJqsb2Ni1KjJHmZMeXl+7f12dH4YLGpYOc23+1VJuwuk=
X-MS-Exchange-CrossTenant-Network-Message-Id: c808207f-a1af-4cf4-510b-08d82cdbda24
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 18:36:45.0634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0NeGE4Aqqjmhdr4cAGLvEVnsm9qsLhU6gFOgW21ylE5/0lFvOwHFmSH8q/0gpbi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595270207; bh=iRJMNpLw9h0OX+dwUH71xKj7w54MkBUWfISG60qBweI=;
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
        b=T6tcbHgYb6OfYKE8kuO+G3hA7tPnEnYgCWyNxzDwmVjCv+PrPkFcDiYy8U3OR9W46
         6R54uQMFIv0Q+CYVbjNMWxOHZSPwM3N/uHKnGmmVlIgKP6AIlVI5Rl9efogOgemh9N
         c/OatjkYkf/NYN51WYidvl3lOJ5QLMMpRp7WYbMWcRh2N32hiKWzTn1lCzFZtgSjN9
         SNTwzaxPbJxlaPWbcC2nkKoimyPixEQvgl3CNLsZweU669H64bKGru3yPblzcQJXLK
         dKl9CY5dHjFpqKhhnxYXcir0m0/qSkfm7A173VOFQxkr1BVcjgpHq/vYar0tIdE7sz
         RyotlBAPn/mOQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 13, 2020 at 10:21:46AM -0700, Ralph Campbell wrote:
> The src_owner field in struct migrate_vma is being used for two purposes,
> it implies the direction of the migration and it identifies device private
> pages owned by the caller. Split this into separate parameters so the
> src_owner field can be used just to identify device private pages owned
> by the caller of migrate_vma_setup().
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Reviewed-by: Bharata B Rao <bharata@linux.ibm.com>
>  arch/powerpc/kvm/book3s_hv_uvmem.c     |  2 ++
>  drivers/gpu/drm/nouveau/nouveau_dmem.c |  2 ++
>  include/linux/migrate.h                | 12 +++++++++---
>  lib/test_hmm.c                         |  2 ++
>  mm/migrate.c                           |  5 +++--
>  5 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
> index 09d8119024db..acbf14cd2d72 100644
> +++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
> @@ -400,6 +400,7 @@ kvmppc_svm_page_in(struct vm_area_struct *vma, unsigned long start,
>  	mig.end = end;
>  	mig.src = &src_pfn;
>  	mig.dst = &dst_pfn;
> +	mig.dir = MIGRATE_VMA_FROM_SYSTEM;
>  
>  	/*
>  	 * We come here with mmap_lock write lock held just for
> @@ -578,6 +579,7 @@ kvmppc_svm_page_out(struct vm_area_struct *vma, unsigned long start,
>  	mig.src = &src_pfn;
>  	mig.dst = &dst_pfn;
>  	mig.src_owner = &kvmppc_uvmem_pgmap;
> +	mig.dir = MIGRATE_VMA_FROM_DEVICE_PRIVATE;
>  
>  	mutex_lock(&kvm->arch.uvmem_lock);
>  	/* The requested page is already paged-out, nothing to do */
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index e5c230d9ae24..e5c83b8ee82e 100644
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -183,6 +183,7 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
>  		.src		= &src,
>  		.dst		= &dst,
>  		.src_owner	= drm->dev,
> +		.dir		= MIGRATE_VMA_FROM_DEVICE_PRIVATE,
>  	};
>  
>  	/*
> @@ -615,6 +616,7 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
>  	struct migrate_vma args = {
>  		.vma		= vma,
>  		.start		= start,
> +		.dir		= MIGRATE_VMA_FROM_SYSTEM,
>  	};
>  	unsigned long i;
>  	u64 *pfns;
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 3e546cbf03dd..620f2235d7d4 100644
> +++ b/include/linux/migrate.h
> @@ -180,6 +180,11 @@ static inline unsigned long migrate_pfn(unsigned long pfn)
>  	return (pfn << MIGRATE_PFN_SHIFT) | MIGRATE_PFN_VALID;
>  }
>  
> +enum migrate_vma_direction {
> +	MIGRATE_VMA_FROM_SYSTEM,
> +	MIGRATE_VMA_FROM_DEVICE_PRIVATE,
> +};

I would have guessed this is more natural as _FROM_DEVICE_ and
TO_DEVICE_ ?

All the callers of this API are device drivers managing their
DEVICE_PRIVATE, right?

Jason
