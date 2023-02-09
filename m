Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EFE6909D2
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 14:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjBIN0W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 08:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBIN0V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 08:26:21 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC1355E49;
        Thu,  9 Feb 2023 05:26:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW7yXaz8qfEOOd09DpfOjmhph4jPXyKzFUqwgfRai+ksuPcu5rTcslqYYaEtJyjdpyaVMFjaa+S/mxBlcZL9RKE9HovG3tgXZcU+ZilPYaoqf7ZYfmJz2GqNh4H4/OnqgXwdGmxxdZFkQX6DpxbASSALDjHJOm7qV39oMVntJmHmXmKfVTUQrHhQPFDY35X/n+aL+cb7ry5MIC+QHEdIkq4jk/GJ/Umj/ADOlXcgBTpJAKrlqjSGcsmvTYjm1d3QhtNdatOTSGfNTAd0GmK3vPvQRQAtkJtckdrourCw1jhFklbT1rZ7+l+I3azi0PeG/S6ItWXogAFoYX4j++FlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlFEk4M58ZmpFLMQT0u5Obg9U3cCiZiD5e8JSdpaPvA=;
 b=FuSVP9Ubyi0NwjCu39pwsDPNCQjIb309VfCbYOs/4mQINjC4XyuKWEa1PsdXu3hPQVSPf3AvMbZPMU1iQO65ySISTgLJgkAT72gpPzIIFMNXHJCjg1sWvSOWHQmNeUzsQCENeRUhNmvdKCZ2RqzGyH07KlITgTWjXrVxlXmpou7d6fbIz8Om8TLOAEMhtZRUB35+2JmSn7DMX1T19ju0+uTt9QlGy2EQoihVB0zWIztdtRjeHQDjzg9utkCzu4o9fvoUxbHbAgrlJpSKFni5CtgN7RyvLwMoACRUE4tGeZyEgJwk5DpuiLv1+UIdWSqg49UTU8qN6m2cfuZ8Ozqrnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlFEk4M58ZmpFLMQT0u5Obg9U3cCiZiD5e8JSdpaPvA=;
 b=LWHSchg2y+KYFzYaiM4mkGRMhLKdfhvDefXEw2mLrN11sPPQc18DABt8xXT0AY529JRQUe46S+g2HzyaQb1IUDzf7nMN1wwnEBixJJEvfrHuvhY58mnX3aHRYqxE4NQobC/ZP17KgLlnlTvgxhdtWxBA8D/A/jAeUcNiHRuBZ/4Ak/18/WyS5n6kmwyV8tYrl0nMN5hTpGyu5Y/1C9Hr12dyMX7AfDsl94b9RA+U59P1u4FHmsyH5cLH83YXCz1BMwPU6xoV9kTifGaVB1vWsz3wF4k+pptrzgw6vQE43WKdPMPUC5zzmCwOOIMnAbvTtqPmcdF10PkgrPqrJqYVHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 13:26:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 13:26:16 +0000
Date:   Thu, 9 Feb 2023 09:26:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 10/10] vfio: Do not allow !ops->dma_unmap in
 vfio_pin/unpin_pages()
Message-ID: <Y+T0d9ox3KnqMDIL@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <59e5eeac675172ab1cb07236a3eb3e166553fe71.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB527687E27FC35CD842E4EA7B8CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527687E27FC35CD842E4EA7B8CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR01CA0030.prod.exchangelabs.com (2603:10b6:208:10c::43)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 1167d5da-d2f6-4ceb-6c40-08db0aa138d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: unhE9zQL6NP3IRHJCWHMWh2rWOmF0Et340qlhEBVxxLkwpV0Y/W0dzgnGHlSLOcXZru83dAZ6aeoVvjIU9L8DmrK/lpWF4yxMQmTEqw2OKdPeIXDcslqlwJbrkntjjS213W5Lj3D0SQ3I7pvbIHINzcj+SzFnl9EUOKZzSUHn19SzUPEWl1GmJp7fUCEhssealM4rVYhuxuje3YrVdczps0mUbUwnocMfHwJ7fxYFqeX+ByhtPem9alNPxhlasAQDZLiINSeGVeVRdFBZJQ9m+6wRZh/d0ev/1bvFN9F3BItkud7sABUkWUw9K0GqJ5Ksx5IRdfA9wm3gx+ibrpcnCDEbeiZyZ4R9+Q/tIxcujPvn703WG8HU1a55qQS5BIeb2pX+6yyISn/9L2B6B0FoNWo78PTruoVNaPIaLRIqFV9LDIvtAkCVj6/daDgV1j5Jx5xsuIrxXMlRjvx/m0uzYRKOB6S3AKfpBxWxX0xRevnpL7w3fCe2CMoVLU3uW4PMi+0Gi0nMd3FWE750rHh7TJBGRMrssH2gdif/HDr1v3EsfSIAJkV9SH0pT9aJHgxFhQveTRBurcj7DwjP5sptUxhdMGDOS3ta22f/tU+8zVeJtJkXQCtN/inLCyQarkp1C+GQgcVxQetUB0NeQMgvC6Nfnu5YfMxtAIindnJQ4kiZ0llViUp+tzk36X5M+3J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199018)(54906003)(86362001)(26005)(186003)(6512007)(83380400001)(36756003)(2616005)(66556008)(7416002)(5660300002)(4326008)(6916009)(8676002)(8936002)(478600001)(41300700001)(66946007)(66476007)(6486002)(6506007)(2906002)(38100700002)(316002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dYtuwKH9Kkwu49JJtXeiAnaiF8CI1qjOf3Jzc9JeD780YtreRxEuBri02FYq?=
 =?us-ascii?Q?88wpYy7xvKaFHJT7V1/tjqrHMJI2UJK7D3oF7vMfZtojDJZWbsKzJFxhZyaE?=
 =?us-ascii?Q?RN7QI4FYiyVRH3/VjqyW0rt3V+s2nIHY9kfHLddS8XbMdsN7z0J2s44ZcZaA?=
 =?us-ascii?Q?bRktCyMY1HxemlUx22LhznCVaERkSPtfHMuwiNWn/ASaLB22ZMfeBsSoIJdg?=
 =?us-ascii?Q?WREMuk/qrauhb8LDmkob5aZhdLemZNj1L6Lj8M40vRjKvApXFsrcUlJOHTYC?=
 =?us-ascii?Q?wq2XKmm97PBCsZsY5lZ6SgB33RjrNFBM8DF7kl/54Pw1ZRwqgJqIM1sZH6BD?=
 =?us-ascii?Q?T8Xhq/43n0IO2mrlxmujFg5nRu0GcPuy6iIzRelxqtUS1cwJ+11BrdEkw0Y+?=
 =?us-ascii?Q?yii2Sb4GdlfA4kE3ljusoqXnbZFbJW7tLLAUuZJI7oVG5zs7w/3kklmWnFXU?=
 =?us-ascii?Q?3+4d27013AlKKJ0GnoffPSNnOU5ufo+/B/JSeOqMUbR2bP+LVsqKzJAU6Bkm?=
 =?us-ascii?Q?5pnYD9gbyV8Znf60pyjwjn+kcjPzD7GYp50McD+Lw3NHeWeNUomRpS8BzPav?=
 =?us-ascii?Q?PNSnSqXO22aQuwE7VI6VRv7Jxxh5jiuTo3WDE/GUmwT6xc5bEZwb/CVpkWlg?=
 =?us-ascii?Q?TBtEsJhwqjRpCjTZHl+CBLg8ffFmp2WkxlTA5vmQYsvoyeiqqxGP+1UokCfx?=
 =?us-ascii?Q?dQnnVQjze/b3rMKnbPWedQWt/CvlbMxsFjiokUmlIfwwT0sM6mtyB3lrwlTd?=
 =?us-ascii?Q?IIoc8EHwpSNKMrq5MkW1WutmqlBaCHYYHNQW28d0qBs0y6ROcCoZt2WhhEcd?=
 =?us-ascii?Q?S7IvFfInp7CjOl1l6RZQT6ndLW2/ki4/XIwK+T75VBur1OS0dtF9FxnATXGF?=
 =?us-ascii?Q?BkKF9oGpfUO7nICGafA1ZOkO1A0fWEqh2KeUH9/kDRIZWJ7AMgZ8RuR5Iol+?=
 =?us-ascii?Q?oXFFPPI0SMt2cGd9NLWzbZ6zJzxDd23f8bzVK2lyo1ryLcklHtReQGLIIvtw?=
 =?us-ascii?Q?1E+bp1PEcR4JhPh7xiYcMcWFBLQtFCbFvR9jGuIU2TyGHKq9MR62ZWAWsH90?=
 =?us-ascii?Q?/S6SPpUOKCor5IEIHPLyADMKsPwxao4UK/clID6L4IKAmRCvlXlAUngjtpai?=
 =?us-ascii?Q?v6k1mrjTVAe5+ggCnucjsnUnTAHEaVQUzaKvvzR4lZZ2m/WlCliyLw9Yku2w?=
 =?us-ascii?Q?GZ0jygtHFCNQsAvLyJf6zAEVlgc20dq1xjUQy6gIPrDqxLura4BwSw509Tu2?=
 =?us-ascii?Q?GkxxBkozO3YHUnXbB1kJZA/6Bx6WLaqAatGvju5dwQ/DvlpOyiVY9DA1TOTb?=
 =?us-ascii?Q?RbLWd5y0jl5bro4s6QDaHMXhWluZJwa+nYzIvq0cRt12NMDp34ZCk0ifwZSq?=
 =?us-ascii?Q?R8f89ZelKEbWtRHglJ4WJCpwRWL0pkhkoftKxUSWw6dkRdnYf7sFqSLvnCaE?=
 =?us-ascii?Q?SVAPgbrKOmnDrIXdQ8k+AjJvCbuJAlsB/9RgW/u+PFfVmfiCl6/qLtq73pAs?=
 =?us-ascii?Q?aKclEagUEvLbkHm3uPVYwU6Z6NQVYR8BTOeGWzHJMjBpjMD8AGaJYNJVum1J?=
 =?us-ascii?Q?KCGM+ybroyq8LYOqxI3IraN+ghq6ec0s6lC6+Pet?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1167d5da-d2f6-4ceb-6c40-08db0aa138d0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 13:26:16.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYydmCKUWg1zYwasMInjqKmD6GaRA9HKTVZew8JCcx2+u5opeNhHlN8e1AI8AymM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 04:10:04AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, February 8, 2023 5:18 AM
> > 
> > A driver that doesn't implement ops->dma_unmap shouldn't be allowed to
> > do
> > vfio_pin/unpin_pages(), though it can use vfio_dma_rw() to access an iova
> > range. Deny !ops->dma_unmap cases in vfio_pin/unpin_pages().
> > 
> > Suggested-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/vfio/vfio_main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> > index 8559c3dfb335..c7f3251ad6e5 100644
> > --- a/drivers/vfio/vfio_main.c
> > +++ b/drivers/vfio/vfio_main.c
> > @@ -1543,6 +1543,8 @@ int vfio_pin_pages(struct vfio_device *device,
> > dma_addr_t iova,
> > 
> >  		if (iova > ULONG_MAX)
> >  			return -EINVAL;
> > +		if (!device->ops->dma_unmap)
> > +			return -EINVAL;
> >  		/*
> >  		 * VFIO ignores the sub page offset, npages is from the start
> > of
> >  		 * a PAGE_SIZE chunk of IOVA. The caller is expected to
> > recover
> > @@ -1580,6 +1582,8 @@ void vfio_unpin_pages(struct vfio_device *device,
> > dma_addr_t iova, int npage)
> >  	if (device->iommufd_access) {
> >  		if (WARN_ON(iova > ULONG_MAX))
> >  			return;
> > +		if (!device->ops->dma_unmap)
> > +			return;
> 
> IMHO this restriction applies to both iommufd and legacy container.

Yeah that makes sense

Jason
