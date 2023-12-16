Return-Path: <linux-kselftest+bounces-2101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D146815B1F
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Dec 2023 19:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C311F23307
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Dec 2023 18:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679152FE0E;
	Sat, 16 Dec 2023 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gf7w9z0u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF1431A62;
	Sat, 16 Dec 2023 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfo+YR03zVnKp+rgGUdJGRmVr8qAxIH86+7wxfmR84jtXAPVentBG0oq64MNeH7aoJ8+D2sVn+Q3z6FcWtGIYAtJ4E4dATCTG3zfPB6HkvIfU+smz8S1VZP08Bw9L7oqjL6jcEh/qn50vwdbvM40BHZDZjYupN8dAHjzCEM4m1hNwphRpibzQACmkijW6tnidrkJgkdEzjHIrnTKzh2+X6aR1woT2iXbNiEA5Kc3n4am9WfaqTPDd7vY1o0M4WfmVXziaaezP68vOT7WXL6AU24y4v4dpO+E/5U8WxKRSGAirkI0AUJg5qrzz21r3DOX8Q35cRZjiD4X0p24sUPKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dvIvxPCkxLE8UfxG6vaNV3Kf3NfnJ9QDIEbXJZry7Q=;
 b=SEXOTzgUGsrMVyfCv+3uGukezgJk99K1iQVoJlWZVPu+jYQXJ+DpWQYr9QN4PBTpJDaSSXMPKd8Q2NPvkGVTqF+t7Cdh8L3oMBKTh8jJY7ZxqdI8okWN4K88DydzYl+aKhzZ1P2yPmZfjhJaMwHDKA+NlHPZ7K7xLFQ4o/rYyTtdFLOB3W/iS8+uLHc4g/gPGz1DCZVtvUHiLNMUmrvkFj/jSRb+6e+HDC9fTj2QIz6wAB9uKJtgXfcfG2aEWJUfNDi1wq8K61tyQUNSiDeU1eYxZ2L5JeuT4oSUGIu8QwM69IciX53jXJqVZ6xqzH0/jqJhOx/A6u3V5U8HDARmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dvIvxPCkxLE8UfxG6vaNV3Kf3NfnJ9QDIEbXJZry7Q=;
 b=Gf7w9z0ulmEQjP/hWHHigANkLjl3SyOX2P35jVkrj8S5TAVseh+V7oJkhCxWjVgy1A/d17hjmd03oit3cUzST/rUFSfLUjuhG/2g8tC0KjbZNWwUjUEpRhfc+TCJlKUBLVqPKD0otBRd5yap5lWdRx2U6X15WRYSXVIoLodh5PgEX3cQ/Wt/YcfsQQcQIhOmWMXwY1cCA+WLFImGmyilqTh9rdKtGIS54zY//WQZ+DfONoA+LAJIYSwW7hMLB+80lzoWYfI63nWY6vBEwIwtt0ugxweu42foRkLqJDSDM0A9Q+ZwNxN8EIht3GOyHDYgU1XNRHlc4kPNb23GGaxLGQ==
Received: from SA9P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::24)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33; Sat, 16 Dec
 2023 18:49:25 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::1d) by SA9P223CA0019.outlook.office365.com
 (2603:10b6:806:26::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36 via Frontend
 Transport; Sat, 16 Dec 2023 18:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Sat, 16 Dec 2023 18:49:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 16 Dec
 2023 10:49:12 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 16 Dec
 2023 10:49:11 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sat, 16 Dec 2023 10:49:10 -0800
Date: Sat, 16 Dec 2023 10:49:08 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Message-ID: <ZX3xJH8LPr8noBvt@Asurada-Nvidia>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <BN9PR11MB5276D14D2A7FF60B41A6A7B48C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXu5whlIGfiq16wF@Asurada-Nvidia>
 <BN9PR11MB52766D7F774510E0181CC89B8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXvI2IiXwwuHRE8V@Asurada-Nvidia>
 <7c398efc-8a2f-479d-bcff-ded8cc1ef3d0@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7c398efc-8a2f-479d-bcff-ded8cc1ef3d0@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9ff39c-5ca6-4dd2-2270-08dbfe67b948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MDhCP4aGGvIzdBfBC7eYEitz9g5EanYlbIK1QjA9LRLOEdBQ12i+r/3o/VXXfic8eUb3zy+MIEmvTMOxhHXVvA3qYybpFIXTQAlXzA0Rc5HH9KbdKdBLquxInd+82kkvlvAwOQbd/M6umW3QY0QIi6Dn/Vwb539GV644sLLgd7XJg/LnMrOPEe8cfWDQWr0HB+DuuTtryi999/vkLZVvILdmr8/g27jovNmI9cFOxYulw/Vg+n3HrEx/cAapCC0jBkoq2+kXWCnKAJBbG3M9aJr+XiYC65ziGuthO+dD29QwJ0ulVahKcBrfGKbgkzeht0qCrpAQem2eHO+RLPbeWY5GqxXwkhMpDGTGEf1t9ZEIM5I9aiO3fYiT1dD8i2ClgwRfE11q0dGd46OsyzHCY08ChWczuCrAp3rVBLy/ZXgdNiYB9rtlnpjhQGcxtK+cVMx9zIeRWhCzttEYeBOE+qKMVgP/7LgczcuP59/2M7qZAYqzt41smBhqafshkHiXau3sYjt35Ee/I0mYut6xVtz9rIu0PZ+UAMHk3o+oYncpV8unbCA/2ozIchIKJaWIesCn6xCrxWNeP+1NqRSssXYURa7f4Nh/JHu8R8R6ghhgTkXMJleFKLyMScZhsxk2MS1+0GFRYwXMe60BOD+gqKUB7iUErtf3UdjhMYwACp1wP+7c8YHE2pyfO+mBliMcHHUIj2qgNn2D1dzEPWLap3Nd8VTVkcR9rk4jJLbr8CmWkSgzwGrUedHX1Ukfo66V
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(40480700001)(55016003)(40460700003)(426003)(336012)(26005)(2906002)(7416002)(70206006)(70586007)(4326008)(316002)(6916009)(54906003)(82740400003)(53546011)(5660300002)(9686003)(83380400001)(36860700001)(41300700001)(8676002)(8936002)(478600001)(356005)(86362001)(47076005)(33716001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 18:49:24.5406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9ff39c-5ca6-4dd2-2270-08dbfe67b948
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428

On Fri, Dec 15, 2023 at 12:01:19PM +0800, Yi Liu wrote:
> On 2023/12/15 11:32, Nicolin Chen wrote:
> > On Fri, Dec 15, 2023 at 03:04:44AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Friday, December 15, 2023 10:28 AM
> > > > On Fri, Dec 15, 2023 at 01:50:07AM +0000, Tian, Kevin wrote:
> > > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > > Sent: Thursday, December 14, 2023 7:27 PM
> > > > > > 
> > > > > > On 2023/11/17 21:18, Yi Liu wrote:
> > > > > and for this error reporting case what we actually require is the
> > > > > reverse map i.e. pRID->vRID. Not sure whether we can leverage the
> > > > > same RID mapping uAPI as for ARM/AMD but ignore viommu_id
> > > > > and then store vRID under device_domain_info. a bit tricky on
> > > > > life cycle management and also incompatible with SIOV...
> > > > 
> > > > One thing that I am not very clear here: since both vRID and dev_id
> > > > are given by the VMM, shouldn't it already know the mapping if the
> > > > point is to translate (pRID->)dev_id->vRID?
> > > > 
> > > 
> > > it's true for current Qemu.
> > > 
> > > but there is plan to support Qemu accepting a fd passed by Libvirt.
> > > In that case Qemu even doesn't see the sysfs path hence is not
> > > aware of pRID. otherwise yes we could leave the translation to
> > > VMM instead.
> > 
> > I think I misread Yi's narrative: dev_id is a working approach
> > for VMM to convert to a vRID, while he is asking for a better
> > alternative :)
> 
> In concept, dev_id works, but in reality we have problem to get a dev_id
> for a given device in intel iommu driver, hence I'm asking for help here. :)

Yea, I got that.

Would it be possible for us to postpone this error report in the
vtd driver?

Jason is taking vacation, so he'll unlikely be very active until
the new year, although he would probably spare some time taking
the cache_invalidate series once it's mature.

If the final solution is to use pRID<->vRID mappings for vtd too,
we'd likely need the viommu/dev_set_virtual_id series that I am
still working on, which certainly won't make it to this cycle.

Thanks
Nic

