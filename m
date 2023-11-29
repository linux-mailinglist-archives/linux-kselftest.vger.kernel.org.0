Return-Path: <linux-kselftest+bounces-788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E447FCC2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 02:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3F85B21395
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 01:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3471850;
	Wed, 29 Nov 2023 01:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rug1vOIc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B771727;
	Tue, 28 Nov 2023 17:09:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eve9OURn+hvFXpmyFbc2arotiKecZZ6fsybHNeWtcbkYpZi8gRgL+paBOmeW7YtTzhgJlUfDsqGmTnZQEMdq80v0yVt7zJ0hraRqTahXS71cPp43WkHnAdZudMua5GCLR5GeOuHXjzYZtA4ZHNYNGZvfsVFejtoN2t3JU/51Alx8HKgQC1b7KsCKj6lJNG2Wj2S2E2OXPbisqy0TgJ23rNjKOwor2wLkxw57+jB/ksnTD3rVSF8VNlnmysKiou19CLJt7zaW8B207BVyrh1VrJUStIwV9upAOVDbr/YTu9fYigU3+8gzol6VXOS+VIGvjND3gwUfzwGYnDkE+aB8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VcbSpZNwbf+MqsbiooakwKrVz1RyM9P0afEb+C70bI=;
 b=ioqWFn+UxVve8p/Ib7iU5VWHbsJmi6drd0NlAHAYxKlDrp/89kvrYUp0fmIA0iJi7qlfNkWXvIhRI5VokzDuxeGAaVUuXkMAmjK9zXNIwW4j9nLJoxDPnU5Rv05hBAc5ecu+wrT/sHfgTKISPPTBXE30zGZaiv/JDuqczCWNesTrcR+gfMbq1wIjtdi2K6R+szFX3/b11pb+lco/8suSskz/v4J3eis9JGSQojkMWBEboop+9x6G2vBe92Vg3yEjq5VS+J+kqqDNEMVBbJHiU4I8KEBI/Fi1xCBKilbPnLujvtZ9y8HTQ33q8WC3tR1cE9ZDkLYyhrEu6z3ShArwHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VcbSpZNwbf+MqsbiooakwKrVz1RyM9P0afEb+C70bI=;
 b=rug1vOIckXhUfGItjv5g9lTR8E2cDwU+qCAE1GShacNybvBcVSS9YwVtXS2J86ks1mU2I2NVCPNJ7REz+xEHQS1BIJjijshxp7q8RCG3dOZ/mzKGye9zNBFox3jh14TZz+mPTl8JILcVjyVBBvWG7zkbCJA/vUdqsakZMrVDpwqefLWIt9KHd3fjWBFQWSkiJxSYkfY/6ZxdbDBF/B12SWXDxIGHrZpLaQqUhLqBL57dauQElbHsr3xfF5abvl6b8PBs2rlF+mS84lzbDcEBexxOuYdp9xduCYdjtSGtA+CXlEDUt0HSLnkFN5eQOOH8cEBx9HkqvSsLBb6IIP5uqA==
Received: from SJ0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:33b::22)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 01:09:19 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::16) by SJ0PR05CA0017.outlook.office365.com
 (2603:10b6:a03:33b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 01:09:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 01:09:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 17:09:10 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 28 Nov 2023 17:09:09 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 28 Nov 2023 17:09:08 -0800
Date: Tue, 28 Nov 2023 17:09:07 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
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
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <ZWaPM4p7yjJ0sEKk@Asurada-Nvidia>
References: <fa736836-e136-4ed4-a6af-8ea2f0e7c0dd@intel.com>
 <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
 <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWaLCSAMIOXTlghk@Asurada-Nvidia>
 <20231129005715.GS436702@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231129005715.GS436702@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f7232a-6f4d-47e6-31ef-08dbf077d018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3PvO6Gt7U02z31q3flqnIVRg23R607lv378JqE2I93Z14rUvFyRezFZnmkOI+GIU6WX7nMbOXWNUGsnOEE3HE9GbjzMG5Kw610hzhCNFfD9SarSZB4uwMCOYpN+wDddz98t0ZBLPQBeOVQXtOpEuq/CJNa1Nq6Q3bNZhhwxBtSdxnsOWY2Mn3n8UR8GelaADaqPRXXiMqUK5tX9EyxTb7G+5Ui40wor22x7WwZ5cTUrj/JNNmdfiBA2u7TJMpxb5nxOESKShGoO15h1FstsMr/xqkSoATIsHkr8/a9HW0I0jubCMYaXs+dsIrEjEWIs/VlC6ogkZsEqzsq03dGYcnkNts67f14i6+2p/s2UbgGQJ9Z3mLkz4wQmeOIc0cjV39Sg6I4Ru92vebZRQ9urVbhfQ0kDaInf1WQDX9VJQqVCiv7lHahdkFex+xLHwTmNNvStBWE884kZcbhr3usdbb1uDXZrnPCwCGUDOszc/KSa829zVJqrbTVfN8n9Ajv3daN5MYFN0Hd5ENuqf/FhBLW6ML4ZgdYjcu3K7k9hGt8WjLZB4Y03zwJ4mse+BKV6KfQsPxHaKY1KxuA35ox/D8GIl2KQIUX6hXDHw7jv4/AqMjWLqLNEXciX0aiawM6kBy/vIpsf5t+w/3Un4b79A2vX+ttHCmVh4wtTwr7R/tGLiAL9DjrKtyQ1tMaxY2tE50XJWCpFmIwwRNeVQGdCbwoeaIyHaZEp2QvXVx87vNZwNMNgsVzuz60iL9KHDqcNN
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(36840700001)(46966006)(40470700004)(316002)(6636002)(336012)(426003)(9686003)(86362001)(26005)(70206006)(70586007)(47076005)(478600001)(36860700001)(83380400001)(82740400003)(7636003)(356005)(40460700003)(54906003)(7416002)(5660300002)(2906002)(55016003)(6862004)(41300700001)(33716001)(4326008)(8676002)(8936002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 01:09:18.5296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f7232a-6f4d-47e6-31ef-08dbf077d018
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846

On Tue, Nov 28, 2023 at 08:57:15PM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 28, 2023 at 04:51:21PM -0800, Nicolin Chen wrote:
> > > > I also thought about making this out_driver_error_code per HW.
> > > > Yet, an error can be either per array or per entry/quest. The
> > > > array-related error should be reported in the array structure
> > > > that is a core uAPI, v.s. the per-HW entry structure. Though
> > > > we could still report an array error in the entry structure
> > > > at the first entry (or indexed by "array->entry_num")?
> > > >
> > > 
> > > why would there be an array error? array is just a software
> > > entity containing actual HW invalidation cmds. If there is
> > > any error with the array itself it should be reported via
> > > ioctl errno.
> > 
> > User array reading is a software operation, but kernel array
> > reading is a hardware operation that can raise an error when
> > the memory location to the array is incorrect or so.
> 
> Well, we shouldn't get into a situation like that.. By the time the HW
> got the address it should be valid.

Oh, that's true. I was trying to say that out_driver_error_code
was to mimic such a queue validation for user space if an error
happens to the array.

> > With that being said, I think errno (-EIO) could do the job,
> > as you suggested too.
> 
> Do we have any idea what HW failures can be generated by the commands
> this will execture? IIRC I don't remember seeing any smmu specific
> codes related to invalid invalidation? Everything is a valid input?

"7.1 Command queue errors" has the info.

Thanks
Nic

