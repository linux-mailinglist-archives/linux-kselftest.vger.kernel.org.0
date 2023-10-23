Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213C97D2771
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 02:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjJWASQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Oct 2023 20:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJWASO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Oct 2023 20:18:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D78DC;
        Sun, 22 Oct 2023 17:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKiNWAAwM5U1qqEu1KyiXbQ2Z2rhRCSeuyGXlZSSmT8/q4taGFObnoJjG8pJZNamKghu/GCuFMIN3onWv0LvsZXcCTPLcYdii2GF4dTzu7kR30sy7pDmey4ntmEPqM2sc0vHTqPPFLqxP5fdU55KXdMRLCBDyMf5S5sD2cZ8vr+r2QvdZy1b3LmPKihdl0REHhDzSO8T3rXCk/ccGb1F+rFMGsipDNCPRiBiWw07rbMpQnEP0ratJ7yH77qVHmABehB67iX0uxrjC7Vahk1Ids69x86ZJ9GPbWJLCzkpBTumWy6YgDnbAemHR2TWCUwmL885l3hK6vkNez6e2MhbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c9+A4oYI7HqE1XgBgBzhelXS4DN2/kC/dQ5UeZgvhs=;
 b=KA6xAnvWtixahQyP9Mif5mLEF9GxLBVi7wecUvGhTQAoyVSKQhmXA0eMT9sL8SckZd0XBKT3Xcvjff2X3o18lhk2+Tag5mEoB5xPKrtkoFfbgc1lhGjQ5b7tPY0IpVjX9rfle/KZ/DU/ulsqueYmYqO5YGAbIXlMVsnbGgudse8qhHRDh/kFunZa92pO6XsP7Jngew43iq8XxNteQ5pJexKzkgt5vfddME+k0SiJaX3FgnxnaLJT4SjRCZWGRHekEcm5nrghgASFyIPXu1lFluiW0F8IBmVlwfjL58z8zYD27NHYcaOEwwfv8KQgmxknLvPYLJbOzxEGGLVX/JtCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c9+A4oYI7HqE1XgBgBzhelXS4DN2/kC/dQ5UeZgvhs=;
 b=E7ZNo6LW2agmA7j9IRjYjmYA4R8q8MPz+lnluFWEPtBN5idbFLU0HNP+yQthSn7QioABwZjJnyTZItnMrt4tDlD/k+wAeaqy+twUDVEMSoMusifTRDiJpmKrQJdfNdOt+LHho6ryPrFV39oPhhtQh3CrBBhbiirvCLqXuBKMrSk4CCtD1Hv7QS8lh9s5jomAsCgCOag7wSdCoyTDPi04HEyBJi+63WYCw9CP8wDO3tdOeztSDTkaVnr4KVN2NhQoj9Q4ts3lqBQWtsH5/2FYW7OZ7J3QGvIsruXJMteYP7qDvxYC8gz5A81HhdQ1y0DkrRz3jcqnBv3yJ6RSMRaqXA==
Received: from DS7PR03CA0159.namprd03.prod.outlook.com (2603:10b6:5:3b2::14)
 by DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 00:18:07 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::4b) by DS7PR03CA0159.outlook.office365.com
 (2603:10b6:5:3b2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 00:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 00:18:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 22 Oct
 2023 17:18:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 22 Oct 2023 17:18:05 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sun, 22 Oct 2023 17:18:04 -0700
Date:   Sun, 22 Oct 2023 17:18:03 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Message-ID: <ZTWabb6AbOTFNgaw@Asurada-Nvidia>
References: <BN9PR11MB5276FDC375685CE04A7AD93B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231017155301.GH3952@nvidia.com>
 <ZS7nb+mKanGFXhZY@Asurada-Nvidia>
 <20231018165113.GB3952@nvidia.com>
 <BN9PR11MB5276B9994AD06E91E07B7EF08CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231019235350.GY3952@nvidia.com>
 <BN9PR11MB5276A64DA68586AEFB6561148CDBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231020135501.GG3952@nvidia.com>
 <ZTLOAQK/KcjAJb3y@Asurada-Nvidia>
 <20231021163804.GL3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231021163804.GL3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de6bdf0-d408-4b6a-a13c-08dbd35d8827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T6XmP+jioJGCuN6dQpU8ffmuEYHoUbYaO6RG/bupssSU5ljegl0ocwBIIPC2GSpTfZYOO1kBNnBAMCb0nkMwV8goao4sydXt2RG4nv1eFLpttxP3iBZDSCPMUqw/ApsvteAbEiutaU65hWtCucttWqdRRyZ3DlnGXBmkgJO0NVIFQSjLXnwtOf5G6Zao+j1VDyf/2Li4GyiN5w/h8P8IOW0bwcdn9eCE0Lteh/4ALWdSKvDtMVON2hrpMYwGmpZ7CCvwuvZxDr0zrWX431iIcEJn6j88Yb8xXWMX8q54G1Rlwai3obx9nRBwbV4dVaB7uyOc0yu+upY55JasQvIOJrjaV0D/73mnbfgCTtaUR8Q+J5GfQycE62EjCNX4q8GN6qgwP8rVRKmNnP8HGV31Otzs4UR8TClx6xVpujel0sbdvo1a+uGD9kiqsNdcxA/PVQKLTGatXV9n/u7kGQGT/JyYA1zlNna9fLcjn7S0cLUZDksZTYVfWjY46RBUdWUftHCbBaNOQThUdjqOh/7fX1NWP6LT6QyMWAIYg+prb0CwpLV3usUKOgcs7zVr8VyFbG79qPLx2bA3HmW+mB9Y0nlAorotnQgyONRiQmqEiWVX/oai/qKFJ3Q5H5Jl1t+uX7cQOp/CfU5KkBYjPvS5jO7RUzsZmNwJup3JXRSibcCZZjiVWQVoZVOr082w7zlNqgzRmWhMpd5lvEyfMjNhCyCIMPGdzL/60rh7UrIUDi7myk7P51OyXuys4mAe8OooA4uPPQ0V8EvnsusdH1uVXDAqAPPdCtR63XDnyzUSWS4=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39850400004)(376002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(2906002)(55016003)(86362001)(40460700003)(4326008)(966005)(5660300002)(6636002)(110136005)(70586007)(70206006)(54906003)(316002)(8936002)(478600001)(41300700001)(83380400001)(356005)(8676002)(40480700001)(7416002)(47076005)(36860700001)(82740400003)(336012)(9686003)(426003)(7636003)(26005)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 00:18:07.1212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de6bdf0-d408-4b6a-a13c-08dbd35d8827
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 21, 2023 at 01:38:04PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 20, 2023 at 11:59:13AM -0700, Nicolin Chen wrote:
> > On Fri, Oct 20, 2023 at 10:55:01AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Oct 20, 2023 at 02:43:58AM +0000, Tian, Kevin wrote:
> > > 
> > > > What we want to prevent is attaching a non-CC device to a CC domain
> > > > or upgrade a non-CC domain to CC since in both case the non-CC
> > > > device will be broken due to incompatible page table format.
> > > 
> > > [..]
> > > 
> > > > Who cares about such consistency? sure the result is different due to order:
> > > > 
> > > > 1) creating hwpt for dev1 (non-CC) then later attaching hwpt to
> > > >     dev2 (CC) will succeed;
> > > > 
> > > > 2) creating hwpt for dev2 (CC) then later attaching hwpt to
> > > >     dev1 (non-CC) will fail then the user should create a new hwpt
> > > >     for dev1;
> > > 
> > > AH... So really what the Intel driver wants is not upgrade to CC but
> > > *downgrade* from CC.
> > > 
> > > non-CC is the type that is universally applicable, so if we come
> > > across a non-CC capable device the proper/optimal thing is to degrade
> > > the HWPT and re-use it, not allocate a new HWPT.
> > > 
> > > So the whole thing is upside down.
> > > 
> > > As changing the IOPTEs in flight seems hard, and I don't want to see
> > > the Intel driver get slowed down to accomodate this, I think you are
> > > right to say this should be a creation time property only.
> > > 
> > > I still think userspace should be able to select it so it can minimize
> > > the number of HWPTs required.
> > > 
> > > > But the user shouldn't assume such explicit consistency since it's not
> > > > defined in our uAPI. All we defined is that the attaching may
> > > > fail due to incompatibility for whatever reason then the user can
> > > > always try creating a new hwpt for the to-be-attached device. From
> > > > this regard I don't see providing consistency of result is
> > > > necessary. 😊
> > > 
> > > Anyhow, OK, lets add a comment summarizing your points and remove the
> > > cc upgrade at attach time (sorry Nicolin/Yi!)
> > 
> > Ack. I will send a small removal series. I assume it should CC
> > stable tree also? 
> 
> No, it seems more like tidying that fixing a functional issue, do I
> misunderstand?

Hmm. Maybe the misunderstanding is mine -- Kevin was asking if
it was already a bug and you answered yes:
https://lore.kernel.org/linux-iommu/20231016115736.GP3952@nvidia.com/

If this shouldn't be a bug fix, I could just merge them into a
single tidying patch and add the comments you suggested below.

> > And where should we add this comment? Kdoc of
> > the alloc uAPI?
> 
> Maybe right in front of the only enforce_cc op callback?

OK. How about this? Might be a bit verbose though:
	/*
	 * enforce_cache_coherenc must be determined during the HWPT allocation.
	 * Note that a HWPT (non-CC) created for a device (non-CC) can be later
	 * reused by another device (either non-CC or CC). However, A HWPT (CC)
	 * created for a device (CC) cannot be reused by another device (non-CC)
	 * but only devices (CC). Instead user space in this case would need to
	 * allocate a separate HWPT (non-CC).
	 */

Thanks
Nic
