Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C77521BE0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jul 2020 21:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgGJTqx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 15:46:53 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:21890 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbgGJTqw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 15:46:52 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f08c5a90001>; Sat, 11 Jul 2020 03:46:49 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Jul 2020 12:46:49 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 10 Jul 2020 12:46:49 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jul
 2020 19:46:49 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 10 Jul 2020 19:46:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhtFuL/eDFdu539TWWzQXczpvdqh1d5USJRaHEpCaRQjGGYTloN633WXjL6IMEI4CMw4pOmEzlBJnefDZkkksfFjSBAwZo1tHs+IiAM0hdv8lWMUCqwxf6MDjLbaQGMZFl5HD+j/eBUbkaAmwli/YYaASj6hzmrLR1FUycQRXaGpeOzrY5KmsH7m3iI+b0PV2+dPd8XxtvuHFdIZBR1FcchGE7UNXsabV1taWGpmbDHVjdKElvLYHGe2Rm+ahvlJtCUlhCpGiXqjtHmQ13ijD2KrutJSGQQkO8HerrsG5iYge34mkJ6oQX438qsSRef7XZy1S0oJYKeKx3Bc6tbBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gucwkIyCDXSu0JYyH7fyHyQvwX/jC87Co5KXwFQFprQ=;
 b=fQNGRjcxdTghhLaZ2HG/2VxIfDTWur1PnY2+KIwtB53Hg5OxVQO9lHsiA19/2p73IItRWedQeH7ASJgaklycmIQ0yESqgmqJ7ghKXXelTm1JeK5EtQqzXbQQylrDy1/2njeHhpEJP8xQa9Eyks9EgoePiXqmfXsA7pVsf+ep1PMlAP2B1O1Xc5x0jQ5MrYoAOVHrR/DmLAnrq1DiUahIKVqDndyyf1pwqS9CmZrnICf/+06mWBGqG4rrkGSQQrJQl2OWcj7jCRNLkguVnpvZ7n9P/pL0iFy6i6NFuTLRj8OJaRI+zUcrH7QzEbNymndNljLcwxaIw5px5Z3Gzw2cWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3513.namprd12.prod.outlook.com (2603:10b6:5:18a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 10 Jul
 2020 19:46:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 19:46:46 +0000
Date:   Fri, 10 Jul 2020 16:39:39 -0300
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
Subject: Re: [PATCH 3/5] mm/notifier: add migration invalidation type
Message-ID: <20200710193939.GA2129070@nvidia.com>
References: <20200706222347.32290-1-rcampbell@nvidia.com>
 <20200706222347.32290-4-rcampbell@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200706222347.32290-4-rcampbell@nvidia.com>
X-ClientProxiedBy: MN2PR01CA0050.prod.exchangelabs.com (2603:10b6:208:23f::19)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0050.prod.exchangelabs.com (2603:10b6:208:23f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 19:46:46 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jtyrz-008w3l-9i; Fri, 10 Jul 2020 16:39:39 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 447da61e-e281-45e4-795c-08d82509fa80
X-MS-TrafficTypeDiagnostic: DM6PR12MB3513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3513D79D91250B7BF05F574CC2650@DM6PR12MB3513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 046060344D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72DVomoZXYAFEx9df9CWCBMiQUGi+zQYLI6Oz1gY3UFMHDspyLHJXvvk46dCiQrz3EBEQ90PQpvXCgO3Urdcq8VG0PhrXj9CkIIRsraNLJfb3rz3DFqRUweyL7WWdBF6wwBksaQQ2NuWXCUM2M+UnU93oLWSNQgbvxPhyF9/tUxNYVAhWQnbssQtu4noyzmG2QYel1JmdYlKYKiLtxJRN4/5l16ReLviBVIH7UwJGPe7QR82jlAS1BW5CZYEcBGeOfoZKeQcH2lPbjXfIKy8+m37hOvy4z13qvfX/8p6bizoO4Rqf+NmmOVGElDroS6UzxiFRbU57MCuYoFft2b32A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(83380400001)(2906002)(4326008)(1076003)(33656002)(316002)(66556008)(66476007)(54906003)(66946007)(5660300002)(37006003)(186003)(6862004)(26005)(9786002)(9746002)(478600001)(7416002)(8936002)(8676002)(36756003)(2616005)(426003)(6636002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QRKCsBNsZB/WaEPiyRj/hLbOxKlruZ0Ln+l9TvVj2Zid8qcDmDUH0mmEJht1fBu0iUbHkFoIAJJXyIhshzLjtm6+P9o4H9ofq5HfowDHDp4Spo0q/oHdPTDgZzRNYvPicjQf+yFrBlDy3IPnP607v71bR9Sj0xRK4ggMk9JkUW3i8C9CCGLjy0ednDFctetjGLsm0TvR+PY2xomL6FQ3XHGpp7M53q8ngrX3ATMZUKCxorEZytIO+hVuYbAyR7CoqF5NGZ4isSkhz6hF0SDeJQvPagH2nlqm5fgIzlQSwn5JYRc9KsbGw+DoYKcP86P+nwIEbsBw0vMD+msq5W2u12FuCDiSXvpeZ+9NBXS0p/IJsqr6bfZAvLFBbVyuEgjxWLa2dgmUefcIAL4b3PqRiyzLbjtsqAPFy75PfgIM4yvxxHo42qcqoOK8chi8QNyU5yX8EAMbh3QuBX0FvT37hFDG7YqD87vpzVutOCqkxIc=
X-MS-Exchange-CrossTenant-Network-Message-Id: 447da61e-e281-45e4-795c-08d82509fa80
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 19:46:46.3160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqLHHSB48fwLvB+on+tdn+7acp53ZJdwQ5wzP7iHOBfnZeXUFGV1bHxUJ+EGKgZl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3513
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594410409; bh=gucwkIyCDXSu0JYyH7fyHyQvwX/jC87Co5KXwFQFprQ=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
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
        b=k2XWTDeT0LOaHg9fhgse4ppB2GkIgdGak5lf6v00KqGegXT5WQmuwo4gf4UWPeF0f
         N8ppOPHMePputfzjOqGblonB+e6r0myoyBMYRg5+fi6owMiCWeRT4RH0pv5448XkQ0
         nUnRV606oddNuu3LjCN0Q2MMXD7WiuvXJ3y7au7dhG3OfCwbh0cg+68RF155CuHnTN
         ZMtNc71M43S7cULQaJoDw+RDhbacpdvgWVdWguCsp71yLUgfylkCLQl8SeKySNBxuZ
         qtC7YYdVexCadRNL0Q1/4EO+DyA6Pyb+xYlp3xMkkE0j2YcBvlXZUuwZQJZUK30LTZ
         e2JXr3Bn1fC0w==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 06, 2020 at 03:23:45PM -0700, Ralph Campbell wrote:
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
> index fc68f3570e19..bd0b34dbe4de 100644
> +++ b/include/linux/mmu_notifier.h
> @@ -38,6 +38,10 @@ struct mmu_interval_notifier;
>   *
>   * @MMU_NOTIFY_RELEASE: used during mmu_interval_notifier invalidate to signal
>   * that the mm refcount is zero and the range is no longer accessible.
> + *
> + * @MMU_NOTIFY_MIGRATE: used during migrate_vma_collect() invalidate to signal
> + * a device driver to possibly ignore the invalidation if the src_own
> + * field matches.
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
> +	void *data;
>  };

This generic member usually ends up a bit ugly, can we do a tagged
union instead?

union
{
     void *migrate_pgmap_owner;
};

and probably drop the union until we actually need two things here.

Jason
