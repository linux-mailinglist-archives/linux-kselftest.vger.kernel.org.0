Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9DC709FB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 21:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjESTKJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 15:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjESTKB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 15:10:01 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E8CE42;
        Fri, 19 May 2023 12:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPw0gFE94ENBzavq5XdL/NkbBOlqiyRrcMVftQMbhlkbxRpAzvn8aV+1JCe0WgvX2HXrhWZJLduTeWELzoy7nXUND7BtUilLiIsC4SmvgrpeDBc+KwUXo5cp33kxrf5mtZoy0CVCp1pp1qHFdkfL5grAnfbtQZuVgdGeLycKtGMDGs+Ttil4RbWNNvV9uRD0dd3f5mLvH5jpdWwhZA156EX71ORQwmvCC82rRWgpFMPpOlM1QaR/Pd8SX3e3chFUy/SWQsiA8f+5V+xbBQi0w9vfZIcM4uSr+x60g7gzAskIaFW6/oO930QF0HgzT6zUjuTOjFVW33IqZppeZk9zMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66SNvLgzEjThl+CVlNXl1s6psD3exT9yQbnFb+bM9es=;
 b=HqzSWoJdaGw7l9Y0K3Ao9wNp3hfAkXPPRWH+NLZDKLL34S0BrSWpAlGxswyyNT4JyR3cRWnCJSiOdl2+TuTsiAb9ViGLKbW0u4ebE9/YY1muyqQK8O4zMits/4+O1Hm2tTjddA/0Obi1gJFbfcl4DFSwFFCciOTkz5YjmEk+KKFk/2SvLtC63FHbX6JLGxSj1fLBujjOgxnMf7fiYugr2wdxsHxSpg6MOoohtdFULgoE5XXAHozMdljEp716z+mOAkPrn9NKITrkKMxsP0XGaem7Pjtv8xBkfoP8SVTbVi+VsnIARl4AFirfGIWe3WlNzkliF/XW0QNo2qlwmuv+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66SNvLgzEjThl+CVlNXl1s6psD3exT9yQbnFb+bM9es=;
 b=bti5ULFVujsq2t0jgD4cNw8Yd3dmTNlp1nvBlkbTGEkmo1uhh9sdMsaruQboVeXFvsNuSceYJLlU5gT/vMt1/0+z6ehRrJlBS7Q1lPmk7K8VgQyOE1tgWgg96md96E+6hGsZe5ChjvlrcRymAw18FKsF+802amsk+yVdQpgBTs186/WXWOSbZQOzjDsYGp+UHTRU7dndBebpwHTb8TGvEw/3pWOqVtpUZj+Er2fhY4r+g6pPOWCe2z/NoAdjEvBNjCTNAzK1ZD24XS9zNOFDJXXjsMWyb2jG5hrBm33h2wDqo9m/fJoCHLjwIBpZULgh0VSYAL4NF16AQjgN6o2HPg==
Received: from BN9PR03CA0895.namprd03.prod.outlook.com (2603:10b6:408:13c::30)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 19:09:32 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::81) by BN9PR03CA0895.outlook.office365.com
 (2603:10b6:408:13c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.20 via Frontend
 Transport; Fri, 19 May 2023 19:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 19:09:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 19 May 2023
 12:09:20 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 19 May
 2023 12:09:19 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 19 May 2023 12:09:18 -0700
Date:   Fri, 19 May 2023 12:09:16 -0700
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
Subject: Re: [PATCH v2 04/11] iommufd: Pass parent hwpt and user_data to
 iommufd_hw_pagetable_alloc()
Message-ID: <ZGfJXFls5uNi3ziH@Asurada-Nvidia>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-5-yi.l.liu@intel.com>
 <BN9PR11MB527662C871DD8351E9F507D18C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527662C871DD8351E9F507D18C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 67df9982-8b78-4826-fe00-08db589c941b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9/ZsXFYiVTmNjSWqcY+Rpi4mOYGOi2yxXKmGjUXPx/05CqDan2xhCHu/AirDzMAI8Jn4WBMfkqta0czdqdsH5OgR6PWjZeI/6F8vp1833O0u+uUVWoco2gMhUySdPeh7emkLDimj5LSFOlFWGqR89koYaEJO9wpGHjsSpCp7UdkGsV9CAbxhnl5HiLjBHzcd5LEAZ2MjfthQi4OXgnzUpGpWAWcRwrVQ1+6LbtY8U9Yg9A4RjvlojSNXUyjHSKQODjh6H/WftuxSlA++t3Byd3/r12auxRXNJ/m0X9euacGMlVpZL56hn961vTtU8kKRl4ckjaup6mKv1NXXQkC72qSf9E+vZkxJCt3vPmqXixDY+3FTp1Sn4b/LQ189aIPnokcHSbwO9+g5BpFgV2HwJWcfUazNcL9+THeZbwJ/adbtzsBrzP0/e+CJFdEWph8zKAuIXdVkpUJSXpURenJzJGjVNubDXOAhblvSHwqFA7pdbALlkHkYX0YqnkO/v6rV11vrdVXKtFOzRomXsE7M227vV2f9O91nL8VRMXOCmzTY8C2ZCzMT0TPv+Ua5/BA3sChOLKoenn/JsdDGAxMFw+bEjVZQXrGXFprliE7yIzgF8F42ubE9eiEGna8o9bbkgPjVBQgqmnYXkGLJehNEvYLMRGqb01sZpHukeljRToIDfEXYCwfKR3GhaRBCQ10zGj7vkAT9JlD6fMsYKA9ZwRuc8mUndCwNO1OxklMwmZi7x3PdbkKy0+EtEbn1ES0wW26pAFQjKuBZFJz0T7/HA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(70206006)(6916009)(70586007)(4326008)(82740400003)(54906003)(55016003)(8936002)(8676002)(40480700001)(478600001)(316002)(41300700001)(40460700003)(2906002)(86362001)(7636003)(356005)(26005)(9686003)(33716001)(47076005)(186003)(426003)(336012)(82310400005)(7416002)(36860700001)(83380400001)(5660300002)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 19:09:32.4187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67df9982-8b78-4826-fe00-08db589c941b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
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

On Fri, May 19, 2023 at 09:06:20AM +0000, Tian, Kevin wrote:

> > @@ -73,14 +77,22 @@ int iommufd_hw_pagetable_enforce_cc(struct
> > iommufd_hw_pagetable *hwpt)
> >   */
> >  struct iommufd_hw_pagetable *
> >  iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct
> > iommufd_ioas *ioas,
> > -                        struct iommufd_device *idev, bool
> > immediate_attach)
> > +                        struct iommufd_device *idev,
> > +                        struct iommufd_hw_pagetable *parent,
> > +                        union iommu_domain_user_data *user_data,
> > +                        bool immediate_attach)
> >  {
> >       const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> > +     struct iommu_domain *parent_domain = NULL;
> >       struct iommufd_hw_pagetable *hwpt;
> > +     bool type_unmanaged, type_nested;
> >       int rc;
> >
> >       lockdep_assert_held(&ioas->mutex);
> >
> > +     if ((user_data || parent) && !ops->domain_alloc_user)
> > +             return ERR_PTR(-EOPNOTSUPP);
> 
> Do we allow specifying parent w/o user_data?

I don't think so. Perhaps we should do a double check:

+	if (!!user_data ^ !!parent)
+		return ERR_PTR(-EINVAL);
+	if (user_data && !ops->domain_alloc_user)
+		return ERR_PTR(-EOPNOTSUPP);

> > @@ -99,6 +117,15 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx
> > *ictx, struct iommufd_ioas *ioas,
> >               goto out_abort;
> >       }
> >
> > +     /* It must be either NESTED or UNMANAGED, depending on
> > parent_domain */
> > +       type_nested = hwpt->domain->type == IOMMU_DOMAIN_NESTED;
> > +       type_unmanaged = hwpt->domain->type ==
> > IOMMU_DOMAIN_UNMANAGED;
> 
> no need of one-time used variables. Just put the conditions directly
> in WARN_ON.

It is to improve the readability. Otherwise, we'd have:

	if (WARN_ON((parent_domain &&
		     hwpt->domain->type != IOMMU_DOMAIN_NESTED) ||
		    (!parent_domain &&
		     hwpt->domain->type != IOMMU_DOMAIN_UNMANAGED)))

> > +       if (WARN_ON((parent_domain && !type_nested) ||
> > +                   (!parent_domain && !type_unmanaged))) {
> > +             rc = -EINVAL;
> > +             goto out_abort;
> > +     }
> > +
> 
> probably just WARN_ON_ONCE() to mark that driver has problem?

Yea. I think we could do that.

Thanks
Nic
