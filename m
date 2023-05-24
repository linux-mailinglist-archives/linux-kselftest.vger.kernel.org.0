Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1684570ED1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 07:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239434AbjEXFbs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 01:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239412AbjEXFbo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 01:31:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B012189;
        Tue, 23 May 2023 22:31:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSo1zVbNvrJihSbd/Znmj1tPW2zjMOQLyVRQSC6Kz7PvOKHU+LEOVVDr2GhwKjup5aRVjX+6pz3nTGqHvcdBnEfM4vMJekA+BQgfHcM9NnGbUUhTZS8vixOZbNwE5Q3Hhb5FhWXNdrV4jsftJ7zmYm90tpQ8/m+BUqtLTa2aY7SSxwWUXM/1sOvjhFeDd8AU7saCWnXe7NJt/MEEI5kX0Bd0jew77b7m/G2hwzul0Vm6s4n5qh+6TIO1K+gI4GVYMWVBDedgNQxOYUZefMkLI5EQ/QrI7sRNUZ9mgcWTVycKMTTQ2ATeBDbQqj02oZR943Yt0WTZnOJcDGWil78PIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKVZLKkgUfTiOjA/DvVMJ+hEy/vV9vB9NiXivpr/CE0=;
 b=aVl85vdueBVfBcAs8C1FUDtZowcaxCpKMBLkS6lskEIiQKFcADdSK/8BYsOAWKkLESdpOKMguS/0/6n7UYqqap+QqyY1mk36Z/VCfJuw6dPSlq6DJW/e6q1HP6dIh1GxDbpAbKo6eLqUSkwwCLrl5QKd7AFKJT6l/EctXCRjXvtscF4U9rwOfXqiXBzByJdpBBRHK1ZnoeqrvmW1pbi8Fl/2pIIQWGrmr1+H1057msx4A0NBxF61OhLI001Yi8YhJ+TuED4A8cIOOy9TXvAgBXglg5HAQ1Hx5tbxE17aaX8pPGTUfHZmsrRZ/DgflKbS0yVNrGAI5tjGV85v1qJo1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKVZLKkgUfTiOjA/DvVMJ+hEy/vV9vB9NiXivpr/CE0=;
 b=iwE1XZ0c0O6fEE1PHE1/MOpcOezyJg+mR7p5gUiUIZGxJ79r3GrTAOngdt6FecFcmle+BiG/p+JmLVTV463DY8N+/jJBMhsHuQaJd2CuHEQmFZyTyLD0P9RUOqh2+Cx3k5w396LamiXz0qgMofrHcDWHUu+AnwEq5fA7qJBEM3ASO+8fA/TdOPMt8WaW0NM7tqG+Zx8dC82WWFMA+1F7hMxn40amICFcz2NGK2QjLxnup9Sjc0oTu8gsGxdJ+lHTJPJywRu9jUO2qAt3T+cijA+j5ZFNbg0u4xopJp3uVQqT7GAJqOtxW4ubE11rINdymxZLfc99ixrBPzleGmSCYA==
Received: from DM6PR21CA0015.namprd21.prod.outlook.com (2603:10b6:5:174::25)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 05:31:38 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::f6) by DM6PR21CA0015.outlook.office365.com
 (2603:10b6:5:174::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.6 via Frontend
 Transport; Wed, 24 May 2023 05:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.30 via Frontend Transport; Wed, 24 May 2023 05:31:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 23 May 2023
 22:31:24 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 23 May
 2023 22:31:23 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 23 May 2023 22:31:22 -0700
Date:   Tue, 23 May 2023 22:31:21 -0700
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
Message-ID: <ZG2hKZCEcpH8BR0E@Asurada-Nvidia>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-5-yi.l.liu@intel.com>
 <BN9PR11MB527662C871DD8351E9F507D18C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGfJXFls5uNi3ziH@Asurada-Nvidia>
 <BN9PR11MB5276AEDAFCAFF0884DD5D6DD8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276AEDAFCAFF0884DD5D6DD8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT056:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da97601-d999-4690-a48c-08db5c182590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88MEgsIKiCYIDXJsQeg7Vr1lRq+Q6fOGbGIyYnni0T6IfX34EQw2qa4UtahdlM67q2ZYYeyzy7Mjg2boNAbVylIqmCyQzwujdsNJAZq4FNc4KNqIPbFA4xavKIkm6vTaqXDTuDeo/IZ0yUnjRqAGZhYLAAX83r9axr1jvQLGFyhWkB1g6Yj6HvQ4sdr+nPpRWwC40DGTb9m4c8Vng7qdi83WRVc1H3cn/jkJtwOXnoceWJNucUlj9lnPXcz2lWIb5hL1iThFtsIuTc2oWWGITRXnNiB/V3SSP1W9BzsvSKuJqojgBYeGUTsa3Ob4Ru77tYLSujy9iCpevCTVRT/iR5zODsB2BoLXnamnN6qB8BrQv8Wws9w7KA6W1GnRbdVqfDNDIpO04bq6xYR1kJ35KDWuhesZ7GIPnR7KQpZAEJQKFVAQ7O/Kw2RkKFWgned3MnHXaM+fDV0ssZVoDjWi0waIC6UEeNR9TGNn7n/nGqWMZEHqwp07NdjAgW3uR84+0upH+Jrlki3OlGyhtYQhVzr1LzmtQhLz/mwvyT5gHJ1nSx9myKgAK1INd05zJ5pOK8YbFYEVAvDzlrYLcAQDET+cS2NAdILEMG8qjKWxwZi4aRYzxE/8GKtudIAGztrsUzqc+Lr2qIDt5nyZAzM4r1Ycgo/htFfJBi7upTGUeUy2JCuE6EcS6ftu0KMvF+o0kXtVAC1Ox/Tx9Szvxawlb3GzjAV0uLB5R7pH2HER7X4+/uMoE9bPU8aiDv+fHnginYpFWI8fRpKYs6W8ecmE+Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(55016003)(40460700003)(26005)(7636003)(356005)(186003)(9686003)(7416002)(47076005)(36860700001)(83380400001)(426003)(2906002)(336012)(40480700001)(41300700001)(316002)(54906003)(82310400005)(33716001)(478600001)(70206006)(70586007)(6916009)(4326008)(86362001)(8936002)(8676002)(5660300002)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 05:31:38.0701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da97601-d999-4690-a48c-08db5c182590
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 24, 2023 at 05:11:43AM +0000, Tian, Kevin wrote:
 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, May 20, 2023 3:09 AM
> >
> > On Fri, May 19, 2023 at 09:06:20AM +0000, Tian, Kevin wrote:
> >
> > > > @@ -73,14 +77,22 @@ int iommufd_hw_pagetable_enforce_cc(struct
> > > > iommufd_hw_pagetable *hwpt)
> > > >   */
> > > >  struct iommufd_hw_pagetable *
> > > >  iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct
> > > > iommufd_ioas *ioas,
> > > > -                        struct iommufd_device *idev, bool
> > > > immediate_attach)
> > > > +                        struct iommufd_device *idev,
> > > > +                        struct iommufd_hw_pagetable *parent,
> > > > +                        union iommu_domain_user_data *user_data,
> > > > +                        bool immediate_attach)
> > > >  {
> > > >       const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> > > > +     struct iommu_domain *parent_domain = NULL;
> > > >       struct iommufd_hw_pagetable *hwpt;
> > > > +     bool type_unmanaged, type_nested;
> > > >       int rc;
> > > >
> > > >       lockdep_assert_held(&ioas->mutex);
> > > >
> > > > +     if ((user_data || parent) && !ops->domain_alloc_user)
> > > > +             return ERR_PTR(-EOPNOTSUPP);
> > >
> > > Do we allow specifying parent w/o user_data?
> >
> > I don't think so. Perhaps we should do a double check:
> >
> > +     if (!!user_data ^ !!parent)
> > +             return ERR_PTR(-EINVAL);
> 
> I think we allow creating a s2 hwpt with user_data so it
> should be:
> 
>         if (parent && !user_data)
>                 return ERR_PTR(-INVAL);

Oh, yes. I forgot about that :)

> > > > @@ -99,6 +117,15 @@ iommufd_hw_pagetable_alloc(struct
> > iommufd_ctx
> > > > *ictx, struct iommufd_ioas *ioas,
> > > >               goto out_abort;
> > > >       }
> > > >
> > > > +     /* It must be either NESTED or UNMANAGED, depending on
> > > > parent_domain */
> > > > +       type_nested = hwpt->domain->type == IOMMU_DOMAIN_NESTED;
> > > > +       type_unmanaged = hwpt->domain->type ==
> > > > IOMMU_DOMAIN_UNMANAGED;
> > >
> > > no need of one-time used variables. Just put the conditions directly
> > > in WARN_ON.
> >
> > It is to improve the readability. Otherwise, we'd have:
> >
> >       if (WARN_ON((parent_domain &&
> >                    hwpt->domain->type != IOMMU_DOMAIN_NESTED) ||
> >                   (!parent_domain &&
> >                    hwpt->domain->type !=
> > IOMMU_DOMAIN_UNMANAGED)))
> 
> IMHO this is already very clear w/o defining additional variables. 😊

Okay. I think we can revert this back and drop the two type_*.

Thanks
Nic

