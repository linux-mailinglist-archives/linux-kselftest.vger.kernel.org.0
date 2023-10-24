Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E9D7D5A4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 20:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjJXSTl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 14:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjJXSTl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 14:19:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D578C4;
        Tue, 24 Oct 2023 11:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKAvC5KdVpksLMa6hgRPAtOSFHLDgN0BgQJfRF+Da14Wm79gL9wpbiVbpv7jvQsLtdYY0qYmxqCfQOu8lhblYfylGgDamjzfBT1yNz1iTXqo00I/KK/HttsEapBESGcPdaToCY0Og+kUM0SLp9MAnPpzNLkPnfsn1bjLIhnCul+bjPUF5qfrqtvrJv7djBvT6y56coUBSXeQhUTK7bTi1K7QWW4dwp1YqeOVg4niI5GJh80uJF8BjprqgBF4v5zL4Q3yilS0fHMiOeEKcgoeLMkONP5RmmSsh2aIeT4Z8xNdmlOwcGrGKlch4e1M4e8Xqyr8SDxW6m2kBYfkoLvy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHP1DuFzszR2uGAg2rLjrWtNNKmOic2Pu2oOV0T++Qo=;
 b=hikzTEM6Nfv5RJLCUqgU4w9CRel3HUvhEWTG9tnNTqlBxpuTeUCrZySelNQJWp5UHDbgdIu20mJ1n7hBmj17USdKCZi2I0iUv4OopXuiLPixWrFrB5WrEmv0ymuz9ZCYWJ8Yfh11kKAbROHzs/SXfu+ml9V2i1QNv8E3G94R6l8APmVIgo3O+9eSX5S0Rmpbvx6cObNQy6LAsWyzKJ/WbBtT0SdxFZm7te1MkVrg5p99qw4pDTRxesGpAiqpmIJh+Pcd9YuTbmFg+GzzjrTm1O4khIIxKm3FOtgQMujFVRfo1YKX5ytgH9Cjp9jD0AsdGLEnVUDQbVEvJuCi38z70Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHP1DuFzszR2uGAg2rLjrWtNNKmOic2Pu2oOV0T++Qo=;
 b=pZJ9XNpJSTPCw5m7xAaSfAlvhUN7P36LT+vceXxvIiMojX9CaFa7vrPsoaaMvzuAYW736/bRkqdPGPyLCe4FlCy3Q+3bSBoQ1Ca+fmz+9Im1FzwwoFiK2JlCL42ezs6kqYLL8y7VK+T/J8p78KgGJl6Pbmxxkej4jLwUV71yLF/o/4GrtrW4owEj01ibUbnsXP4a7opMHzYjMxf+wdfe+xwmBUF176/cgWudJJbAj0TsoQjqmnRbnn8Vz5CUy17T+3KD0hRbsjdJjt1v/yWc8dg9wD344eB6liWsD0SUB/FYMyAmW9krnpbuZkJ/pnZdnwiT/D0zIsYkn2Q/GuO6Gg==
Received: from DM6PR06CA0060.namprd06.prod.outlook.com (2603:10b6:5:54::37) by
 SA0PR12MB4541.namprd12.prod.outlook.com (2603:10b6:806:9e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.31; Tue, 24 Oct 2023 18:19:34 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::e2) by DM6PR06CA0060.outlook.office365.com
 (2603:10b6:5:54::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Tue, 24 Oct 2023 18:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 18:19:33 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 24 Oct
 2023 11:19:26 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 24 Oct 2023 11:19:25 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 24 Oct 2023 11:19:24 -0700
Date:   Tue, 24 Oct 2023 11:19:23 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <alex.williamson@redhat.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
        <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
        <yi.y.sun@linux.intel.com>, <peterx@redhat.com>,
        <jasowang@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
        <lulu@redhat.com>, <suravee.suthikulpanit@amd.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>,
        <joao.m.martins@oracle.com>
Subject: Re: [PATCH v6 07/10] iommufd: Add a nested HW pagetable object
Message-ID: <ZTgKqwYdH27b8MUB@Asurada-Nvidia>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-8-yi.l.liu@intel.com>
 <20231024171810.GO3952@nvidia.com>
 <ZTf+zWJE2qlgkf1M@Asurada-Nvidia>
 <20231024173139.GR3952@nvidia.com>
 <ZTgEApUgriFj1dKa@Asurada-Nvidia>
 <20231024180049.GV3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231024180049.GV3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SA0PR12MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc04033-3b5f-4211-3ec3-08dbd4bdc5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWOLddj/wKnB9pECsOdml2w9LF/F5HgvjnyXH6LXukEadbhOJMF2kDqloVvIQqAtDG7LFlSqs0rfkCzJAh16tJS17c+a/3fZVwgvJ+nXrjTNUGcjV9UJO52lyLxLtLwMMOdM46/wxKhCDE3mEfQPcxKI4qLFLpOWIFznzVZm+cYda5/6+p8BCbibYZzRz/7RVjcsj+RAsxRpZK0F2FVPCKn9+7Wr612cwqkL4btV3sSDL6oym/rgvlAeyg5UGdHQBs7ofh5u/astjDPJPf9QxY5vJvMdB0to+cR4f87sUpYiPUGf3tDLNssrko0ToUJiG/biU1zJnvk31k+f8qaOdgFS8eNqM0vw15klWANBcfhdHbD/f4wO53QbsZ7kRsGFmEyQ1kurvaWn3Xe1x0vYVC/nkP2mNy/DRvTb3rN665KWsiA6c0crKpn2lNYA41mSBMHD+Vremi7tMQVk0BbTAVulDmJa+tWF5+kB8mWxVrOPlXWyTBF9yhU5JZqurOE+J23vhqNeEZMdJYn/o6gvodrb2VxJGSZGXzVEn9zF/cGr5yPozO4MVI0t2Ne7ZiuFsxSQ23MzyKfFMFFWIXjsx/E3AL3Qh3YQzaRZhAV6teP5bhts5US81jPz0WlcNkcw78474ZjjaTPmq/mlt7zBdjJrjIpfhYD+m5+0/wFBYaAhqf2JBpSVj/S4Eru1JrynKle9LpqpHsOSWSX7yMVAp6cRBRgbcY+SbHqP2odKDBYg77UEqC3xdrVXooRUWAWqC1P30cVcE554cu6LWsQ3y+dvosdWjbiE31GBo8ko7C0=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799009)(36840700001)(40470700004)(46966006)(66899024)(83380400001)(55016003)(40460700003)(8936002)(40480700001)(70586007)(70206006)(110136005)(86362001)(41300700001)(5660300002)(966005)(6636002)(9686003)(316002)(54906003)(478600001)(4326008)(8676002)(7416002)(36860700001)(2906002)(426003)(356005)(7636003)(336012)(26005)(82740400003)(47076005)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 18:19:33.6596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc04033-3b5f-4211-3ec3-08dbd4bdc5ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4541
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 24, 2023 at 03:00:49PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 24, 2023 at 10:50:58AM -0700, Nicolin Chen wrote:
> 
> > > The point is for the user_data to always be available, the driver
> > > needs to check it if it is passed.
> > > 
> > > This should all be plumbed to allow drivers to also customize their
> > > paging domains too.
> > 
> > We don't have a use case of customizing the paging domains.
> > And our selftest isn't covering this path. Nor the case is
> > supported by the uAPI:
> 
> But this is the design, it is why everything is setup like this - we
> didn't create a new op to allocate nesting domains, we made a flexible
> user allocator.
> 
> > 458- * A kernel-managed HWPT will be created with the mappings from the given
> > 459- * IOAS via the @pt_id. The @data_type for this allocation must be set to
> > 460: * IOMMU_HWPT_DATA_NONE. The HWPT can be allocated as a parent HWPT for a
> > 461- * nesting configuration by passing IOMMU_HWPT_ALLOC_NEST_PARENT via @flags.
> > 462- *
> 
> Yes, that is the reality today. If someone comes to use the more
> complete interface they need to fix that comment..

Ack.

> > Also, if we do passing in the data, we'd need to...
>  
> > 280-static struct iommu_domain *
> > 281-mock_domain_alloc_user(struct device *dev, u32 flags,
> > 282-		       struct iommu_domain *parent,
> > 283:		       const struct iommu_user_data *user_data)
> > 284-{
> > 285-	struct mock_iommu_domain *mock_parent;
> > 286-	struct iommu_hwpt_selftest user_cfg;
> > 287-	int rc;
> > 288-
> > 289:	if (!user_data) {	/* must be mock_domain */
> >
> > ...change this to if (!parent)...
> 
> Yes, this logic is not ideal. The parent is the request for nesting,
> not user_data. user_data is the generic creation parameters, which are
> not supported outside nesting
>  
> Like this:
> 
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -286,14 +286,12 @@ mock_domain_alloc_user(struct device *dev, u32 flags,
>         int rc;
>  
>         /* must be mock_domain */
> -       if (!user_data) {
> +       if (!parent) {
>                 struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
>                 bool has_dirty_flag = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>                 bool no_dirty_ops = mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY;
>  
> -               if (parent)
> -                       return ERR_PTR(-EINVAL);
> -               if (has_dirty_flag && no_dirty_ops)
> +               if (user_data || (has_dirty_flag && no_dirty_ops))
>                         return ERR_PTR(-EOPNOTSUPP);
>                 return __mock_domain_alloc_paging(IOMMU_DOMAIN_UNMANAGED,
>                                                   has_dirty_flag);

Yea.. Then the vt-d driver needs a similar change too (@Yi) as I
found it almost doing the same:
https://lore.kernel.org/linux-iommu/20231024151412.50046-8-yi.l.liu@intel.com/

Thanks
Nic
