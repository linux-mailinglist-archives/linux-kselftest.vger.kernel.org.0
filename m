Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110C871027F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 03:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjEYBmw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 21:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjEYBmv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 21:42:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556F0183;
        Wed, 24 May 2023 18:42:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWrxX+EvnSE6YoLNpRZq0/yUZqKkPNjVTNY9hVGZNAPD/snXxbASUyfDH2GvAIaTO8tNHWSTEj2JZpZsrtgCbeEIUef7kl18FT7FMYsCCptGtIYHsgYjkWrWHV76uRK3RUroWoosTGMsDzRxKMCcexOrmGrArC3OZvLAE7OyGO+9jJV2mGkJ7viNm6I+Jlp6Hdqm/LBb2+DIbM/v2m1RzrNYlgYw3d+8q199klqXD27BzmvSpcQGbwh/3x87QLbVLVS+WbAlbMgKH88uCiTPOT4MiZOU7ETubTVAkobW9JyVCynGI8cbn3YGWAUJ9VINzLVP8w7AfA0ip1hlYNnAfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8g8JyXKqeW/uXBF8+vZSR2TfQuYTkw+qxu/MiCZm59w=;
 b=fEKCJQHPdF104ng0PXeDYCiDPabU4snOrwuQq0DekfGeb7WA74shqUykdxq+hflrh1AN7QGd1rFciLvh5DQsg8hHgrufmKc/4JDhYZZGlLbOYRDxn06JvQ+mCnjGp95s2CMsgVLcKPW8V6UCShJzLL+BIHrHulhFjdLi5uKcpHMDRWa2NleP9Nu530Mdk6CPR8j9WYEM3OPpRLWWyp7smGi8GjvNcl732ff7mHrbUgz9BJXuYXW9QUrpYuVsvnmmdpq8N51CG28/S1nnldCrjxTOpBduQ/cMUea4TTQ872RptkwGN8qQV30cKS5J0MSco6TCc4h1XQIYHCm/rf6VUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8g8JyXKqeW/uXBF8+vZSR2TfQuYTkw+qxu/MiCZm59w=;
 b=NRV6WMmmHs687II5W7pqo5Bo9BPqw/C4QxI6NAH0qrgzi/x4tT2M6DxO0/4P9Gz8GlS506fPx4Iu3aZn7CT1adRhqpKmVO0VV9IsuLc2ArZ1xDRoHz0sRc7Wns1c3TX7L1k1MRhH8zt+aBarsNSFUttHkPLHO+dly8xlsvM4GzDQzEfT7FsPxTYR+ff5wNVMoAdLnVXoc8U5zb0H8PG7HV7tXJJlewH9VVTjoCmeXbMcaH/sWoBJiVeptbFNnpherHBWKLtvKONHRQjjSUft56QPnm/8CFSWCMkGMFLS+yMU5WOQ1No/RGXFEtqG+LPrbEgmFKSpfqmItsJOIts9tA==
Received: from SJ0PR03CA0252.namprd03.prod.outlook.com (2603:10b6:a03:3a0::17)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 01:41:47 +0000
Received: from CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:3a0:cafe::ae) by SJ0PR03CA0252.outlook.office365.com
 (2603:10b6:a03:3a0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Thu, 25 May 2023 01:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT086.mail.protection.outlook.com (10.13.175.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.30 via Frontend Transport; Thu, 25 May 2023 01:41:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 24 May 2023
 18:41:43 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 24 May 2023 18:41:43 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 24 May 2023 18:41:42 -0700
Date:   Wed, 24 May 2023 18:41:41 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v2 01/11] iommu: Add new iommu op to create domains owned
 by userspace
Message-ID: <ZG681VohNlw2vvLD@Asurada-Nvidia>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-2-yi.l.liu@intel.com>
 <BL1PR11MB5271B553140BB729AF4389AB8C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZGfDrRDI50oGih2r@Asurada-Nvidia>
 <BN9PR11MB52766A760580E6FBB995A33F8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZG2fVj41GgosR1dk@Asurada-Nvidia>
 <BN9PR11MB5276F1410A11ED631CE6824F8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F1410A11ED631CE6824F8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT086:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a430cdf-f3fa-45de-c925-08db5cc13408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iiFTWjWSac8PV3jH6fpHaqQub5IgmKRty2os+i53fKq4sW2MUuqPIigZCYmiBaa2f56xa60F+E/kp4v6NtM9W2T26YpSKTjRh3/4orvOoxCanmdlV6xpWZXC3+R9VIRn5Qkha8grerq1SXQEbWYR+et1S+5ZcDOpzLi5nLJY0qYZzacxmVAVFB6AiTfHOqECzCGmB2CY8YActAw4yDx9uazddB4oBcRSJeunjOtazsnAw5RqUNG+yIIlgAdPt2xqQJ6icl/a72CFTOJ+lbfXLHhfLdlcBjoAiOKVwxjvRle7aN2hRys/PEdwqsawOQi07oh9BLcHvB8w/IkkuPwNnvcUjVjIzr88DXSRx9HmOWWsWQq7x01IV8skvIxdl7ndI+A8RGrQKxlByIi0lKuH9rUBDh7QMI1FAHe2Hpcb4Znf4r5Yd1w6aLcK/L4INdUwec0vgy3cFoMJXuANj7ITYwU8Gn0hS6QBv9bJfPgcWDk16HivO0UfHeDlQ9T224BBEWn21R63EmfCX0I/JdNHCRva4AkeTnYMSZatE25GmrKDEhrTMo7t/ZC7ny5OVdg8kszA/V93aYNWXGmB+Z4JyAelX0bXd68iuhMRxoJ4eT37zgRSkQLuLj3aA69PSXRAGRjNRfUT62NxBkJCLhSUL9Vi2AIvOcGHrYet7fqih9ar+mFSU0bYuSl4c5TaJUCV/KrgBBC3RQbddE9jsClRxTHGtewop3GM0ql/odQgn5VJtgUcCv4kf0TTI3ScI2yF
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(54906003)(26005)(9686003)(186003)(70586007)(70206006)(6916009)(4326008)(82740400003)(356005)(5660300002)(82310400005)(426003)(336012)(41300700001)(36860700001)(33716001)(40480700001)(86362001)(55016003)(2906002)(8676002)(8936002)(7636003)(7416002)(47076005)(316002)(83380400001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 01:41:47.3241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a430cdf-f3fa-45de-c925-08db5cc13408
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 24, 2023 at 07:48:46AM +0000, Tian, Kevin wrote:

> > > > > >   *           after use. Return the data buffer if success, or ERR_PTR on
> > > > > >   *           failure.
> > > > > >   * @domain_alloc: allocate iommu domain
> > > > > > + * @domain_alloc_user: allocate user iommu domain
> > > > > > + * @domain_alloc_user_data_len: return the required length of the
> > user
> > > > > > data
> > > > > > + *                              to allocate a specific type user iommu domain.
> > > > > > + *                              @hwpt_type is defined as enum
> > iommu_hwpt_type
> > > > > > + *                              in include/uapi/linux/iommufd.h. The returned
> > > > > > + *                              length is the corresponding sizeof driver data
> > > > > > + *                              structures in include/uapi/linux/iommufd.h.
> > > > > > + *                              -EOPNOTSUPP would be returned if the input
> > > > > > + *                              @hwpt_type is not supported by the driver.
> > > > >
> > > > > Can this be merged with earlier @hw_info callback? That will already
> > > > > report a list of supported hwpt types. is there a problem to further
> > > > > describe the data length for each type in that interface?
> > > >
> > > > Yi and I had a last minute talk before he sent this version
> > > > actually... This version of hw_info no longer reports a list
> > > > of supported hwpt types. We previously did that in a bitmap,
> > > > but we found that a bitmap will not be sufficient eventually
> > > > if there are more than 64 hwpt_types.
> > > >
> > > > And this domain_alloc_user_data_len might not be necessary,
> > > > because in this version the IOMMUFD core doesn't really care
> > > > about the actual data_len since it copies the data into the
> > > > ucmd_buffer, i.e. we would probably only need a bool op like
> > > > "hwpt_type_is_supported".
> > > >
> > >
> > > Or just pass to the @domain_alloc_user ops which should fail
> > > if the type is not supported?
> >
> > The domain_alloc_user returns NULL, which then would be turned
> > into an ENOMEM error code. It might be confusing from the user
> > space perspective. Having an op at least allows the user space
> > to realize that something is wrong with the input structure?
> >
> 
> this is a new callback. any reason why it cannot be defined to
> allow returning ERR_PTR?

Upon a quick check, I think we could. Though it'd be slightly
mismatched with the domain_alloc op, it should be fine since
iommufd is likely to be the only caller.

So, I think we can just take the approach letting user space
try a hwpt_type and see if the ioctl would fail with -EINVAL.

Thanks
Nic
