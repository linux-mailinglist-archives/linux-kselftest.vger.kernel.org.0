Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA106B37AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 08:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjCJHqg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 02:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCJHqJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 02:46:09 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4714F3666;
        Thu,  9 Mar 2023 23:45:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlVayWDFneWKrkpcPinjRrwgp3JXLXmrWmZODPLRIElhCrCQItP1xK0ekRwf0y+B9iiz3zxV5WL81qU8NNbG/7DN6+obZrBebHg91mTj7T+0p4jJL2PXk/3vgNYDA1RX1CPQmw2E7PfwJBoRkPk8cCaLuPePRHF+LSXGoNlKVnZuCZFE6t10dN8ZXSqA8GyuhJF4Ak7qjxht0xXdmeEP8MY2h7Z2TR7zeEvKGhhi9M06LYzvapiNCCgRhm9t53ZojaPoNiB0pDG+0WULsaV5nrHLKdxMh1qCP0sEsu5tGjxveBTB17f/xje61XE1T6ng/WJZKoBf74fd8L/m6xVxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acYj37/N/6xhwiCDhiNkEw/UkveQOPubMQHq0d4nzx8=;
 b=eaK2ijE/fimhUOd/57kOuda1eVN2y1j7u7lLecoa2NJSTxG9OsaNaSZdDsPUPMzMmDltv5h0+WEzRiFYBGHRWwPIOK+YERJzgv/EDxAS+jW3pjvLIteOEILmxRuumGTHwueRwUXkTDNsgRevFMXRGVqNCE/KgrgF+Lt+54W5uCPcVqFSDyFzJHd6WRPIfsbtu3CXRECP8QTc5ph4siWCSnj6Jo2ffJQqFnGl4ByVMDQ3BuJV/cz/ilQLJlThLjPrq091Ig4WoTP6cyUsjJNWR6ngWHxDKn4ny0zRxxYgZcQJKO+ypUL7W+2DAp4mPqD1o8Hxd9+LMwh4LpsrZbb+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acYj37/N/6xhwiCDhiNkEw/UkveQOPubMQHq0d4nzx8=;
 b=ceUO5D1FK3T63nXsQFbPJIfabaTNOHVc61PMTWD0nR3sL7mVXwn51fxX1/BY0TNsmczN1boAOo/rmGCm8yNTSlUq2zOwiPI6SKAnLgwyfGpcSL1JQ1VA8AbXCNzzeVKhUMwgQtw4sRwwAaWdSKkuHsyeDXpjJ/bnBxjdHchR/7w3aIOYa2jsYmU/SeLcEa09nkJeUWYDaQFGaR1DsTSgEelHmJUx4CK4RhZmm2qD5OOea6nz3kJdTmRX0Rn2PMdGYBkbGGr3aD+2CZeULOb6axKDOoTCnvYAktlt+H0pWx553aKK/HhC1sJfytV6kpdr3wUkq8Z4KSJfdRDegvcLjA==
Received: from BL1P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::29)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Fri, 10 Mar
 2023 07:45:23 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:208:2c4:cafe::7c) by BL1P223CA0024.outlook.office365.com
 (2603:10b6:208:2c4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 07:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.17 via Frontend Transport; Fri, 10 Mar 2023 07:45:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 23:45:08 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 9 Mar 2023
 23:45:08 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 9 Mar 2023 23:45:07 -0800
Date:   Thu, 9 Mar 2023 23:45:05 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 08/12] iommufd/device: Report supported hwpt_types
Message-ID: <ZArgAXMUpNjDfFgZ@Asurada-Nvidia>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-9-yi.l.liu@intel.com>
 <f0076d6a-d764-b018-7442-08a6293f9553@linux.intel.com>
 <ZArXyj3iiPa95aCu@Asurada-Nvidia>
 <DS0PR11MB752928ECB7D395C601F14246C3BA9@DS0PR11MB7529.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DS0PR11MB752928ECB7D395C601F14246C3BA9@DS0PR11MB7529.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5ac482-369d-48c1-f86d-08db213b678f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pec43Qjf4gwf4dcRHFdy8zTOXgiSHyxtldeghF/bfvOEmY3+2YK0XkO6a48ewwLd/s0Aqeyk2MnHB727/inINZPRreugmVwiRChz28xn0spZ+Tmu+zlYO8G+9zN8JZbum/brtx0SKW2snlTA5RkbzFUiqn6K0eFAOgvIxeyyM8LEkf0KnE93yZwpRTme0prXXWkOvhAiNwfeck+f4xPe2HPzZ6R3NsQPWe6M2R2LRQyEdBGJN5+VpCXtR3y5AW2h3CvdtSHQuS8lj5RTi2gHZjmhXvQVptGa9wItvO7x0YPy1tWzBH5I5IjMbFzW2BMvuTHKvwF/ZyXmpYyxaoE/SM95ccj3SCQYNFiubs0mF4UtZk3JQwldzXs3UAQAkRorZ4jbcYRY4C5tWYvBVRKnH7DaonAW6ZLwcCxU+UUc2P+MEu/2k/u/8SoBfj0PkNgnD8U7emcKnVHsUC7mbK4qYByc6TKMRORQUxv4Q2V1mG0Wcz3JiELNPgf9vmr0+Rj0VCSLElyVzXTRGHoZOe/2U+Zl6VQ+IkyqAu9eDAnDY6qT1pT5aHzYVGbozUv7fxzCSLsd0q9U9T7QyUrZkkDeFmDck92/e47GRPgC+SpGHEfrV6tdHwpB1tQgo3CQPVvmquqlqIod70jVkRx34hmn1RfNiS7FKptt52rq2IW6+wdRsdBqxjDWO6Vqne+IKEY3O0Lh3GGyk2tQE5c9qtoUQYOudb4G1o1gh79CCGZtv7ciO6cv/7bjT/tsrhS312MZsN/QhrP99XqyVHboCqVw3S62gxXvhdG7iRxg5Ni/Xu8=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199018)(46966006)(40470700004)(36840700001)(70586007)(70206006)(36860700001)(316002)(47076005)(41300700001)(83380400001)(8676002)(6916009)(33716001)(426003)(82740400003)(54906003)(7636003)(4326008)(186003)(336012)(8936002)(82310400005)(356005)(2906002)(9686003)(5660300002)(40460700003)(478600001)(7416002)(53546011)(86362001)(55016003)(40480700001)(966005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 07:45:22.5301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5ac482-369d-48c1-f86d-08db213b678f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 10, 2023 at 07:39:00AM +0000, Liu, Yi L wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, March 10, 2023 3:10 PM
> >
> > On Fri, Mar 10, 2023 at 11:30:04AM +0800, Baolu Lu wrote:
> > > External email: Use caution opening links or attachments
> > >
> > >
> > > On 3/9/23 4:09 PM, Yi Liu wrote:
> > > > This provides a way for userspace to probe the supported hwpt data
> > > > types by kernel. Currently, kernel only supports
> > IOMMU_HWPT_TYPE_DEFAULT,
> > > > new types would be added per vendor drivers' extension.
> > > >
> > > > Userspace that wants to allocate hw_pagetable with user data should
> > check
> > > > this. While for the allocation without user data, no need for it. It is
> > > > supported by default.
> > > >
> > > > Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> > > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > > ---
> > > >   drivers/iommu/iommufd/device.c          |  1 +
> > > >   drivers/iommu/iommufd/hw_pagetable.c    | 18 +++++++++++++++---
> > > >   drivers/iommu/iommufd/iommufd_private.h |  2 ++
> > > >   drivers/iommu/iommufd/main.c            |  2 +-
> > > >   include/uapi/linux/iommufd.h            |  8 ++++++++
> > > >   5 files changed, 27 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/iommu/iommufd/device.c
> > b/drivers/iommu/iommufd/device.c
> > > > index 19cd6df46c6a..0328071dcac1 100644
> > > > --- a/drivers/iommu/iommufd/device.c
> > > > +++ b/drivers/iommu/iommufd/device.c
> > > > @@ -322,6 +322,7 @@ int iommufd_device_get_hw_info(struct
> > iommufd_ucmd *ucmd)
> > > >
> > > >       cmd->out_data_type = ops->driver_type;
> > > >       cmd->data_len = length;
> > > > +     cmd->out_hwpt_type_bitmap =
> > iommufd_hwpt_type_bitmaps[ops->driver_type];
> > > >
> > > >       rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> > > >
> > > > diff --git a/drivers/iommu/iommufd/hw_pagetable.c
> > b/drivers/iommu/iommufd/hw_pagetable.c
> > > > index 67facca98de1..160712256c64 100644
> > > > --- a/drivers/iommu/iommufd/hw_pagetable.c
> > > > +++ b/drivers/iommu/iommufd/hw_pagetable.c
> > > > @@ -173,6 +173,14 @@ static const size_t
> > iommufd_hwpt_alloc_data_size[] = {
> > > >       [IOMMU_HWPT_TYPE_DEFAULT] = 0,
> > > >   };
> > > >
> > > > +/*
> > > > + * bitmaps of supported hwpt types of by underlying iommu, indexed
> > > > + * by ops->driver_type which is one of enum iommu_hw_info_type.
> > > > + */
> > > > +const u64 iommufd_hwpt_type_bitmaps[] =  {
> > > > +     [IOMMU_HW_INFO_TYPE_DEFAULT] =
> > BIT_ULL(IOMMU_HWPT_TYPE_DEFAULT),
> > > > +};
> > >
> > > I am a bit confused here. Why do you need this array? What I read is
> > > that you want to convert ops->driver_type to a bit position in
> > > cmd->out_hwpt_type_bitmap.
> > >
> > > Am I getting it right?
> > >
> > > If so, why not just
> > >        cmd->out_hwpt_type_bitmap = BIT_ULL(ops->driver_type);
> > >
> > > ?
> 
> The reason is for future extensions. If future usages need different types
> of user data to allocate hwpt,  it can define a new type and corresponding
> data structure. Such new usages may be using new vendor-specific page
> tables or vendor-agnostic usages like Re-use of the KVM page table in
> the IOMMU mentioned by IOMMUFD basic series.
> 
> https://lore.kernel.org/kvm/0-v6-a196d26f289e+11787-iommufd_jgg@nvidia.com/
> 
> > A driver_type would be IOMMUFD_HW_INFO_TYPExx. What's inside the
> > BIT_ULL is IOMMUFD_HWPT_TYPE_*. It seems to get a bit confusing
> > after several rounds of renaming though. And they do seem to be
> > a bit of duplications at the actual values, at least for now.
> 
> For now, vendor drivers only have one stage-1 page table format.
> But in the future, it may change per new page table format
> introduction and new usage.

Yea, that's what I thought too. Yet, I am wondering a bit if
it'd be better to have an ops->hwpt_type in the drivers, v.s.
maintaining a potentially big chunk of the array here.

Thanks
Nic
