Return-Path: <linux-kselftest+bounces-786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC637FCC18
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 01:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEA1AB20F8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 00:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEFEEDD;
	Wed, 29 Nov 2023 00:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iagsTpx0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5245E19B4;
	Tue, 28 Nov 2023 16:55:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Em7gWuEyY82qkYodRtAawGy8qrNHWnheDfh5fNjIulghIqpQ4uJFda2e0jA6EHcMl/IrXBAYGGOh4qE8AIQFSO35zhRsNVU6hYWdjtds/RlpPViHJkY7lF4bXqc26CTYLXbObOZPxT6vnUxY/TcpRRKHysZbihcz95BETIugQFjJG9+ntJzS8Mzz1U2kDrb4e8KDi35EijWK5w5B2LsiVq2tu+CsDSS6GoRdX8fE3QwnHBYaBLT/24nWY6BuUU3urWIXxpM+Auxb56RipHjrcIaVIiBSqd4rDwwxWcNVxD3cCQEjdu0Cf6+R8Ekhilh8mN+oFMfwjaEh+5jpRc4g3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceVnp6wG1Zth2c/ljtO8i6Em+N/nRzHTmMHHuI0milA=;
 b=HEF4a7Wr7dXvIXznZ7atv8AMGYPui01fzPzbBhk1WSQ5bHA1FaG9hM5OtNvjWix2PxWEI/rQWia0vpwBiLVP3uy+QDhus/O555AlW24Bau7PohjQJwHzV5SWE/v7I0M2vS+XgwgBlimm0yQ/5wIISIU/82jAaJcNfK/vFkh24cqDRvFiX2SEYaEzaHlD91OF6tzkbjJytTE2mfVtkw+tryo15Q71OKFs3asiUCj0V4oCx8TPA2JuYTMqGUyO+UOhfuI+123CynnZ/a7vK51MFAVmRFbLgCIi0IfmvYwtiQCV66VubscCo7xvJvgTjegt8WJ1djVUUv1Vemz4/0Fk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceVnp6wG1Zth2c/ljtO8i6Em+N/nRzHTmMHHuI0milA=;
 b=iagsTpx007wYFbnz6303qC4/PmWBEVGgCs10I9CCMwiP984w/ydy3UVlX9swI+m/fHtKb8HVHvn46kaH8c4DODIp10zSwXHpsFTjMJEx6DDDzYQ7mZ38o6w5Gejq5b+1PaLCgRGW5tlE3EgS7bEB7Z9JFknjmFxDNgRpb2JeVRVOA9HUZqFYK1xs7sXf9HGFB9uSYjDizw7jiUCgVTp7Ab83ZBTgWdwhXwfRWVZ9BeldDDzPP/j3OZRfU/1SOofNfg0fnW61Nunyfk5MmAvILK7j4BIv+uG9acqu6AJDPWFuQRMZha7mAl1dgBXRVh6pZAIwmR6WFLAKYslVLgwRWQ==
Received: from MN2PR19CA0005.namprd19.prod.outlook.com (2603:10b6:208:178::18)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 00:55:04 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:178:cafe::18) by MN2PR19CA0005.outlook.office365.com
 (2603:10b6:208:178::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 00:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 00:55:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 16:54:50 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 16:54:49 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 28 Nov 2023 16:54:48 -0800
Date: Tue, 28 Nov 2023 16:54:46 -0800
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
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <ZWaL1qJKdYuNXBI/@Asurada-Nvidia>
References: <20231117130717.19875-3-yi.l.liu@intel.com>
 <BN9PR11MB5276D8406BF08B853329288C8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fa736836-e136-4ed4-a6af-8ea2f0e7c0dd@intel.com>
 <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
 <51640965-4196-4da1-88b4-cb0e406931f3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <51640965-4196-4da1-88b4-cb0e406931f3@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|MN2PR12MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3004ec-0c75-4624-989d-08dbf075d32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BvgkJ6KxjEiZlYq8DSJO32vbS1mf9CrWkG4cU4VPa8/SmVq9UIDjpo8O4hhYOdPfjMturIEW27FYdEVmwCImmfLvTjPpX6Fl8yO9MBu0j7hiDNchhgdex/Kf8Awb14r50TaDYCMhS3OUr9K6YnzZ4C2P8QZ6B8SprMYS7eBU3F5Xasm5dyOVTMBGDSYnClPzHKYAsxWGhIrcergk2x4unZWpdparc6/gJtdBxOf++h7G9OtqhORBHcc0rd2lvZjhSzQFBqAOESo4I77BhsRX15Ju8tA9Bzgr73H89wrQlxo92WnXx+6GdkKyvUJTLov9oB46rDn0bmeQSOdAIA7k5slr1eOhDwYAZK5A6EsVTtJD9CvYSh3tG7RHtwKCurrJamRRVdA5Pd+P3CJt/CPHs3Ze6XaK/Xe/L/ToBBannRAPYxIcKdQJqfSXI5AFnQ5vst+jrTn3twQbH7pjJxkihQD7+W/8BQlcpQEEve0Htb742x+7sh+/R2h9eP9jJSptot2yl1L+7CU1l928tFriWEjZS3NylLPh0bDfNd1zDZZnFVIQexH1yYRFhQNwNwzN0AgQN6NSTAq0dXbmfKxLmcQCrUFtzETJYNWLohYpDKHlrv7keZnwVBcKaaQQsRAWU9woPBuzbT7L0Cfsc0nkGW4e6fekznZh8mSn/A+3WDIeGULfK7mfm/rY4bIdm4Qe/NjhCSofxEmbRgZ+it8MJpu4Nnz9Q/CL25WodEl+167VQNCy9AYujc3H/PLMt/p9
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(54906003)(316002)(6916009)(8936002)(8676002)(4326008)(70206006)(70586007)(478600001)(41300700001)(7416002)(86362001)(5660300002)(2906002)(36860700001)(356005)(47076005)(7636003)(9686003)(53546011)(26005)(83380400001)(426003)(336012)(82740400003)(33716001)(55016003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 00:55:04.5715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3004ec-0c75-4624-989d-08dbf075d32b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271

On Tue, Nov 28, 2023 at 02:01:59PM +0800, Yi Liu wrote:
> On 2023/11/28 03:53, Nicolin Chen wrote:
> > On Fri, Nov 24, 2023 at 02:36:29AM +0000, Tian, Kevin wrote:
> > 
> > > > > > > > > > + * @out_driver_error_code: Report a driver speicifc error code
> > > > upon
> > > > > > > > failure.
> > > > > > > > > > + *                         It's optional, driver has a choice to fill it or
> > > > > > > > > > + *                         not.
> > > > > > > > > 
> > > > > > > > > Being optional how does the user tell whether the code is filled or
> > > > not?
> > > > > > 
> > > > > > Well, naming it "error_code" indicates zero means no error while
> > > > > > non-zero means something? An error return from this ioctl could
> > > > > > also tell the user space to look up for this driver error code,
> > > > > > if it ever cares.
> > > > > 
> > > > > probably over-thinking but I'm not sure whether zero is guaranteed to
> > > > > mean no error in all implementations...
> > > > 
> > > > Well, you are right. Usually HW conveniently raises a flag in a
> > > > register to indicate something wrong, yet it is probably unsafe
> > > > to say it definitely.
> > > > 
> > > 
> > > this reminds me one open. What about an implementation having
> > > a hierarchical error code layout e.g. one main error register with
> > > each bit representing an error category then multiple error code
> > > registers each for one error category? In this case probably
> > > a single out_driver_error_code cannot carry that raw information.
> > 
> > Hmm, good point.
> > 
> > > Instead the iommu driver may need to define a customized error
> > > code convention in uapi header which is converted from the
> > > raw error information.
> > > 
> > >  From this angle should we simply say that the error code definition
> > > must be included in the uapi header? If raw error information can
> > > be carried by this field then this hw can simply say that the error
> > > code format is same as the hw spec defines.
> > > 
> > > With that explicit information then the viommu can easily tell
> > > whether error code is filled or not based on its own convention.
> > 
> > That'd be to put this error_code field into the driver uAPI
> > structure right?
> 
> looks to be. Then it would be convenient to reserve a code for
> the case of no error (either no error happened or just not used)
> 
> > 
> > I also thought about making this out_driver_error_code per HW.
> > Yet, an error can be either per array or per entry/quest. The
> > array-related error should be reported in the array structure
> > that is a core uAPI, v.s. the per-HW entry structure. Though
> > we could still report an array error in the entry structure
> > at the first entry (or indexed by "array->entry_num")?
> 
> per-entry error code seems like to be a completion code. Each
> entry in the array can have a corresponding code (0 for succ,
> others for failure). do you already have such a need?

Yes, SMMU can report a PREFETCH error if reading an queue/array
itself fails, and a ILLCMD error if the command is illegal.

We can move the error field to driver specific entry structure.
On the other hand, if something about the array fails, we just
return -EIO.

Thanks
Nic

