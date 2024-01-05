Return-Path: <linux-kselftest+bounces-2664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F0D8256F4
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 16:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6181C22CC4
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F442E64B;
	Fri,  5 Jan 2024 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cu2qzQ4t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486A2E642;
	Fri,  5 Jan 2024 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJJYA3POnJ6J7G6JPf9i8i2SPQnT6eN+lN4/5nxb6J9bqDiu5IukbKFQwBS6742e4sAE0z3zLcPaIm9SeDhPF07VP5Nzgp50gKL7GzIKryPes6mYIKOAU8Fcb2XHciLqTL3/jUoa9QBwiV8rP4CNxB7S1gOSScXwjUwvKFmATq36aVpcTt15OvKW11A99e1hvRwFckS1zp+Yh3rbwpOh/K6HfobHSlKUUsSZuULZFejXlVwhrzmyY6j/w/an1Fy17vvIRhwSKlHe7f4ZUXvDa2qX1JmuoWwXsnzQBfNstAWduP0yNYXVlQX2ad78au0qgYYfxylEV2kylbNbwI7bzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IpAacOxgtoJvDLntX6k1o8pC41AY4xAfAQ9HdqEXRE=;
 b=Fxif74kkTFRrwkclpqn3sphr9zl4dSjpxbcJd1uxFiLsZczWBU3LxXNoxIc8iqdBHypZYPiHodFRe6P+hTL/5Y3v1P/9FIVzVqwlTMTZwGa3rAylvP6JHmk1AohMcq2KJEp/yx5bRqywoFbpJhCQmxrUUThoHN3Vh9kb+f+drXfXtDre47uTaaHUa39Vqd25R9V7vvIuMyKswIq72gEpOf8RMUWKqn2vAm24cyDUs5EpwBTSjNYCBpmdRssfkA2a1LdaKzQEmjHQD6xwdxipJkH3K0mnc8+7ycnKVtQUAbv71YoSvDcTGxLqE/R6WhehSs5PZdtiZsbuvYAJlGIkYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IpAacOxgtoJvDLntX6k1o8pC41AY4xAfAQ9HdqEXRE=;
 b=Cu2qzQ4tJOT86/h0SRrWedr+6EOAsW6jg5mfHqE1Dvzc25N53H0U5rO89WNuI2133asgCaEcNCYGvyRPIGyckb2J9e5Bs4ONHEYpGZhmh7zY4LlF1CqGtlciu5ccMwXgHJHaRdtQGBCiXup1w7TYYkIW5ADlYVp5XAOYndjdkNHxk56ZqrLVSLnlaA3Gd1jWtFkdaFm/Nf9Hct+gAlv50SEAT4RBJuyKjvJ5bSfpTZsuYAR7QoAGd/H0TkPORfC8uNWIMy+4fUvlFP+uJnhYKdAmdwGelwwUathSOrdnUGz9RcweXZJDGTZ8asbDsb1H7sAFyWeiGMu7CVAQIIJfPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4854.namprd12.prod.outlook.com (2603:10b6:a03:1d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 15:46:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 15:46:13 +0000
Date: Fri, 5 Jan 2024 11:46:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
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
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Zeng, Xin" <xin.zeng@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Message-ID: <20240105154612.GD50406@nvidia.com>
References: <20240102233849.GK50406@nvidia.com>
 <c59a780d-4030-4815-a34b-fb2e2f902ab3@intel.com>
 <20240103160108.GP50406@nvidia.com>
 <ZZWP7iBqUtbTRb3s@Asurada-Nvidia>
 <20240103165848.GR50406@nvidia.com>
 <ZZWUD+lCw3mRc/15@Asurada-Nvidia>
 <20240103175202.GT50406@nvidia.com>
 <ZZXBGw9dJyvb/5r5@Asurada-Nvidia>
 <20240104000204.GV50406@nvidia.com>
 <ZZeyAC3c8LJz7nsQ@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZeyAC3c8LJz7nsQ@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:208:2be::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4854:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d7a2e25-0663-41e8-5a7e-08dc0e05720c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oPnz02jo8jaRTFKOdzFBHX//EvRAIy1nxw8QjYzH5iye0ZTy6tOP0Frt94KUv6iSNj8eLe4njkhx6x6YI3eI2wxx0kkKI48C7ps94sgb4SBHFid2HAILuGcLXezWmXsQnRz97+sOLEdV3kun/1+ToXdvbkCLe3N/UJ6mOk2Xt3sqHJiPw0kWMXWKjzJN+rd0zaCEDOyoCDEf3r7VA//HG6soAcGrGA+Yf91DxJLPmDRMqxEq/AQQahU6B3f5cQ5AvRKArYG8NqBY8CitW3uv8FrSj2vCwNHhScj7tc5Vhrxd2PRIiICgmq9wvq4yUobJTgWNj4624268VPC8YrZhqlKWWZP5I9qgEh8GOiK/W6Y5AZv0sX+D4g+FLEI2E2vh9gPIKnUDc7lHvHRYTYybpnBCz+lDhKtcpbVPd9FBJwceQ9ErSbq4hxG1jeFS8aoxyGBMfLhdmYbFMMB3HxJF2Ew/X1cXhN62dQK/ctJFSOqUFwr9tjpAFKAuXuocjuvourSXZv1W9/dNJ2SeueB+Cfug7ZpALEyI1yu+MW+i7iH5apSrEy11eivXY8lPz/q2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(36756003)(86362001)(26005)(6512007)(2616005)(6506007)(316002)(54906003)(37006003)(478600001)(6486002)(8936002)(8676002)(66946007)(66476007)(66556008)(6636002)(4326008)(6862004)(83380400001)(1076003)(33656002)(41300700001)(7416002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ABZF2m/r/rsmD60u/4ttbFQRdH1+i+tlCyxb7KvcIU7wFX49FgQQQs+21aPh?=
 =?us-ascii?Q?aPDVMpWS3PUIsDDr+hZNHHAWt8kn3sMwuoZyVHft4kMge5ufSG2revPhX3Jc?=
 =?us-ascii?Q?18C7ojGBFpBNp5CYBbRXaX4jaSlvV/1VH02Xja25QoaLzOhbPV9M7/vI/Q1K?=
 =?us-ascii?Q?BTGEtn5gRML9eODl90ZgIatbzN88F8eCAgrN/gwt7nfgoBy0aJpBf2i9nyvH?=
 =?us-ascii?Q?klYrK0rYSIG45NNIllJ608RoDxmceB+emDhDtmGCPAZAaQRDCc0yz6bm3Zbw?=
 =?us-ascii?Q?91IChdFr6udxkZAXPuv2VeIOxQrehq+bdwm4Ca9finv84I2aULMBgdSoDuAM?=
 =?us-ascii?Q?473Yn3Dvmh27BrCxKbbF5lXxFqMkVD52ez6AFQ0qBHn9uApzhCSAZZcCpS0e?=
 =?us-ascii?Q?idgND2JOTjD33wp1L7gfn8g0zQBzgKJWEHiWr+ijn7sRhG02GaznaNPMHVnl?=
 =?us-ascii?Q?jSk9UzPx6jdGITJ4HT4mNiBL1kZxlr6aBn89JgXIz1LGprSC94avPU81EiyB?=
 =?us-ascii?Q?JgvFfurDbB3T8IoNDvaYTEx4p+Tr669xYys6UJwLlvdoutm7vBzRSFk9d5XR?=
 =?us-ascii?Q?gpcIt03Zmsw7dGgcDRob7DOl4PQZgnGK3q32ECJdTa67D0qSqlNn01rawJdJ?=
 =?us-ascii?Q?Y06mDcEQa6SagRt+lOSst8HTU389HYHKB82S7QtLK9z0c2Kqa3tQF22buPk9?=
 =?us-ascii?Q?vVdOvS2bh+/MPIjfOGRZ6LFRDGTB689dUcv5PuflF11eJfxuSBJp8BOXr6cx?=
 =?us-ascii?Q?DY+ybCxTelnRAQHrxW9/ykaD59ZfiLaqzC85pLlaJUEpwaEt06yYS7XWkol3?=
 =?us-ascii?Q?IIBePzp5FDXyglgR4OxdHrjGPeG2gVH/tTV4XP272lIWj3Y7R1romKm+qhmX?=
 =?us-ascii?Q?5vP3bL1+2OeJqz3zZ0lhtsgq6uiJtSb0iuvT8boYRFESMwuFo2kmTQUAp1vX?=
 =?us-ascii?Q?1fMTQNBq4TjScn5/9cpLOYBMHiM3VI2rmEXuMk3qp9rg903rUpX8BmEMbQyF?=
 =?us-ascii?Q?6VgXRuu56pyt4cG2OyBoPTkFf5NhNbC48E0qCcljMSwtbELhZ2zFoOecc9Fk?=
 =?us-ascii?Q?hWDYNEFmIcV9r4Jygw0HN42tpEFmeW38sv/2wjlsK3xiaPDhY3svHQysy6Ky?=
 =?us-ascii?Q?krG8y6y2WDWm1uBfL7NtCdWRFq/tjTBWcoBdeVH0tfCY7vKofAE0kcwRHS2L?=
 =?us-ascii?Q?t+fiW4rrCpOxm2FJqlsjmEl02jdRFMeDQl/LvwRQkNQsoYk7Zj/iMZM255mW?=
 =?us-ascii?Q?8lTFKZcX/jFS2HhfB5xqLQWuo6ctUZlP4ypoALrsLISrBBmATEG2XEwqbASw?=
 =?us-ascii?Q?pB6oAUxl9LJFHoahRAwmIgRMS2yN4aHU7vstktQMzD/EVGOholG0kVy2dEh5?=
 =?us-ascii?Q?7bN/4PIBu4RpNfijatZOzNEOplAnl0MiXzhZHj0Qof9qXUQqOnoJHPFucAjL?=
 =?us-ascii?Q?yH4J3FhklzFO6EFoVvXmSHuYzXmOYrrpSXh/wH40cRdFcSTRBEm/rxR+rwaW?=
 =?us-ascii?Q?64X4Cd3CaDbl6CtwZbusYc8Ev8q9vC7Rsmmy1xOA4WS9tWlOIHsSQg9KEnqP?=
 =?us-ascii?Q?uShalUcT2W7AYemdBcc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7a2e25-0663-41e8-5a7e-08dc0e05720c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 15:46:13.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8UJXeC2QnK2jrzD9LuxaRB3l/MfnST5c/BpifOZMTVEohmX6oBz6dDIfoPhnHrU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4854

On Thu, Jan 04, 2024 at 11:38:40PM -0800, Nicolin Chen wrote:
> On Wed, Jan 03, 2024 at 08:02:04PM -0400, Jason Gunthorpe wrote:
> > On Wed, Jan 03, 2024 at 12:18:35PM -0800, Nicolin Chen wrote:
> > > > The driver would have to create it and there would be some driver
> > > > specific enclosing struct to go with it
> > > > 
> > > > Perhaps device_ids goes in the driver specific struct, I don't know.
> > > 
> > > +struct iommufd_viommu {
> > > +	struct iommufd_object obj;
> > > +	struct iommufd_ctx *ictx;
> > > +	struct iommu_device *iommu_dev;
> > > +	struct iommufd_hwpt_paging *hwpt;	/* maybe unneeded */
> > > +
> > > +	int vmid;
> > > +
> > > +	union iommu_driver_user_data {
> > > +		struct iommu_driver_user_vtd;
> > > +		struct iommu_driver_user_arm_smmuv3;
> > > +		struct iommu_driver_user_amd_viommu;
> > > +	};
> > 
> > Not like that, in the usual container_of way
> 
> How about this:
> 
> // iommu.h
> @@ -490,6 +490,16 @@ struct iommu_ops {
> +       /* User space instance allocation and freeing by the iommu driver */
> +       struct iommu_device_user *(*iommu_alloc_user)(struct iommu_device *iommu);

struct iommufd_viommu *iommu_alloc_viommu(struct device *dev);

> +/**
> + * struct iommu_device_user - IOMMU core representation of one IOMMU virtual
> + *                            instance
> + * @iommu_dev: Underlying IOMMU hardware instance
> + * @id: Virtual instance ID, e.g. a vmid
> + */
> +struct iommu_device_user {
> +       struct iommu_device *iommu_dev;
> +       struct xarray virtual_ids;
> +       u32 id;
> +};
> 
> // iommufd_private.h
> +struct iommufd_viommu {
> +       struct iommufd_object obj;
> +       struct iommufd_ctx *ictx;
> +       struct iommu_device *iommu_dev;
> +       struct iommu_device_user *iommu_user;
> +       struct iommufd_hwpt_paging *hwpt;
> +};

And you probably don't need two structs, just combine them together

And don't repeat the iommu_domain misdesign, there should be some
helper to init (or maybe allocate and init) the core structure along
with the driver part.

> The set/unset_dev_id ops probably need a type argument if there
> can be a multi-xarray case, then the virtual_ids xarray should
> be moved to the driver private structure too?

Yeah, probably. No need to add things that are not used right now, but
it does make some sense that the driver could control the
datastructure used for mapping. eg AMD has a HW backed datastructure
so they may not need an xarray.

> Also, a 64-bit virtual id in the uAPI was suggested previously.
> But xarray is limited to a 32-bit index? Should we compromise
> the uAPI to 32-bit or is there an alternative for a 64-bit id
> lookup?

You can use 64 bits in the uapi and forbid values that are too
large. xarry uses an unsigned long for the index so it is 64 bit on
64 bit systems.

Jason

