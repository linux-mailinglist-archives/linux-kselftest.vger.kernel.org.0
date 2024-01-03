Return-Path: <linux-kselftest+bounces-2623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B718233DA
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 18:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7235D1C21993
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 17:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB4D1C2A3;
	Wed,  3 Jan 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uZliAbw1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD581C295;
	Wed,  3 Jan 2024 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5KKa6J0ctcjtPVxjQj/xDUb32zN7o7dUJScZDZ3lP3Ffx0JHYZEXCjy2B+2nqQiSixHZIlPponY5oV6HPtGTt6izG1g6AL2SLr7sqVGsTdz25SOmn4ePmlSuXDxnYSaVpIDCP0vDP+Nhsi1yN24EbpbkDwUodX4H6Ga61fgd7tH/Dt49XKU8ugkyh/6cfsWYcktsunTWR5JVCjddK74icYv8k+p9Wku5KhguDlkQeEJYR91jritMs7pp2BxXAGT/+MFlzISCKpkS0Y1tWlUsQ1PQYc0sIoxHtSwfsObia/16k8te6iQJ/RMrlhCEqqjDfp808xe69Z7PYhEDYJhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suPc+tBWeaNugrLcXXo1ZjAD+XZi7zwZ1E2Uyi3Wo3M=;
 b=C1JB3SzJTfLfS9cWe8SGX334hKVR6mDEq/HR2AmOsEkb0+gRN7hwIp/wzH5121g6oXPOUglLlefEh8FODPl6q1+GU/vNW3keOjgV7korRPv5mV3ViEOBTTGyBxIRFqMICf6PtMbJE+4Q+THtIlrsBl8yILlJilZEQoPS7EFsA45eSF3BR0dzIrWZdtcelX8FSAPChQuTXSM3Qhpf6t3lZgF8Fe72rhaOLm3VdRn8gwv8U0Sg/w4q8Fn0t7MZbAb1COnq0G2HUwyWYemBLTDSu9RG6icztuOk6EinAnCedNnJerZhLsOU+kYOxAIJW0+Pcd9rwdX0LZFjfMaiANlNIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suPc+tBWeaNugrLcXXo1ZjAD+XZi7zwZ1E2Uyi3Wo3M=;
 b=uZliAbw1szg8WDSrZIG2oTfW4ALuGDYcni1R5kboufIyFXFRE4jfEtLPauBoriqlfNFTFlVGbevCTthiZllek/FSAp+P0GSLFjFEguHdBiF3tt+kyNsknh/etDz09mUe0vUeNahWGCYjOY++8vOQ6BwVm8o82HSRlrCxRi97gmbTOQqc/lx9lBo08CDaRHEeV6lm6KFpwPaL00y4hg2nlPtZJAc4FiXqzfAXlRTqKJngtp4cCdkBAQEyoOMxf8uvYOzl/x32LslsI7oyyHXOhNDl5MCubLqAQ+n1ykBhcpf01e8t1NhFvMiT4pG8B8sXAKnJk1pz2sx/KV83Noohyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 17:52:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 17:52:02 +0000
Date: Wed, 3 Jan 2024 13:52:02 -0400
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
Message-ID: <20240103175202.GT50406@nvidia.com>
References: <ZXu5whlIGfiq16wF@Asurada-Nvidia>
 <BN9PR11MB52766D7F774510E0181CC89B8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXvI2IiXwwuHRE8V@Asurada-Nvidia>
 <7c398efc-8a2f-479d-bcff-ded8cc1ef3d0@intel.com>
 <20240102233849.GK50406@nvidia.com>
 <c59a780d-4030-4815-a34b-fb2e2f902ab3@intel.com>
 <20240103160108.GP50406@nvidia.com>
 <ZZWP7iBqUtbTRb3s@Asurada-Nvidia>
 <20240103165848.GR50406@nvidia.com>
 <ZZWUD+lCw3mRc/15@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZWUD+lCw3mRc/15@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR18CA0021.namprd18.prod.outlook.com
 (2603:10b6:208:23c::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: ececa460-de5d-4585-38db-08dc0c84b111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+3c2LA8o8wbTkXBW8S7ody/4kdrn1d9JZk5PakzPBv8l6koWxCCDN0rEuylcbD9+FrGJ7QTc3ZWQTt6oPqboSVRDsiWV//h/wHT31N4pEeHtf5BH/sqntduXLMLewp/7MlDopK/PbEV2KJ/uJyNvo1j2O0gEH5lPRagKoJYNP96Hrgv5Im6sP6bn3Q/xrndopyTDuuVZiPhxMaeyx2vuDdrsFyv7ChKk+NhsRm7w9dYFwhdAIIa2guRZU4Muvz8AR4ULFuVaLckEuiNhwE5LvCVn23QNBzc9sQiBLcZlcse53hCZLLFc0jUT8+bWoU6PrCyusmpJWG54qkpgqze1Es7wQRiBHYZULicxjHrTDC3cdBCgcwA9Te3ZhRx8O1Q2Rm95w7qUfu2QDDZO/VIppUZDUF4VvGCAFm0rCe/JG7GEJuDCcjC+BftdpdKo12ooqY2W2eDOSKzvIgqBns96JMlBT/6mEKaPHskVbfEq2ssPIaL9Ur+UV8qmoy/LmIwkRCGC8FXPRx5qI9loLIBEqXBV++iKW0hDIUUVka6BHc94dZ84GzftxiJDNFZomNlS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(4326008)(66476007)(66946007)(66556008)(6862004)(6486002)(8676002)(54906003)(6636002)(478600001)(316002)(8936002)(37006003)(83380400001)(6506007)(6512007)(1076003)(26005)(2616005)(7416002)(5660300002)(2906002)(41300700001)(33656002)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OZPLm9c/cLv964gmLrzEONBk2+JhCey2sBCNGeqxny7IE3PovwEUgOQwCJMk?=
 =?us-ascii?Q?zTnCVxCtuj3aIlTcMoxMTD6LruweyQJAQoxn37B8FuCWgmj+A6DdPHn18Ug5?=
 =?us-ascii?Q?QUaPbWEN5d2UmR4lgGW+ZJAimWdLqkA9Ikw1H+TdbePR3lkkuj6/5UKkBPP6?=
 =?us-ascii?Q?qaV3wT3XcMmNi2iWzOyRB6Rq0vKd0S4aUEha7CwoH1iCrNrfWj1dpNCMMdwU?=
 =?us-ascii?Q?osZgl+2a1vaxNq6cUJsvySmZWw9jzwUBsaNd4H0xoIDFUhKpGb6p7mHDqogl?=
 =?us-ascii?Q?bd6AlOL8yqoVMwD/iqJTbuXw1IUbMFzpfUU1zH48N7Xbyd6RbW80Qs1zwjXb?=
 =?us-ascii?Q?yVE5YMzACS2Ax7HhnWWtSdP3vyv6k7oXvynOMGTYvnqzAylOVkKub66tAwGl?=
 =?us-ascii?Q?2PFgJXtZkpAhGp0ckH43lEdYUegRwNp5yEFdX8TzqQJJWUF1zLavFaGZuyAF?=
 =?us-ascii?Q?lBmQeFygD9UY5G6B/6eVgrj244st4C3lj0flg4SLjSHgCaV9EYCNuQzVsDNV?=
 =?us-ascii?Q?W5JBiYLSsUKh/jQo0RtEQMFiOZwUGhiiVUUQu4pUYT08xwCngoiukVignUDr?=
 =?us-ascii?Q?2ksAGVUhamjWDkewdO2nuO3vOUIrNNd+3AMHAqPMEPIb7F8L/YBwUUw4wIj0?=
 =?us-ascii?Q?kf+iNbN9xHNZRef1MPjhvFl4nLyVl7yovwHPdUoR3s0epRg5YT+f5GtA84fW?=
 =?us-ascii?Q?kJ1igOwMmyNxO7j0pMZ/Le6uI1VoX1m389E8InlsjBj5vi5PlNqXseopXWYb?=
 =?us-ascii?Q?I43P+LkKrPcK+UxF1K1vE+AJ16ijbvCjMKrwgjCuXkL7ILdmgwIt7LTnfLfT?=
 =?us-ascii?Q?EYKAtf/vCMbsLR79oVe5iveXNR2Rlh6IPta4m+izFMy4k/pD/4ykI5SvwhQU?=
 =?us-ascii?Q?CgRUnHojcIgYzBV04hv6E4OtbmBh6epkA/3IT2PzBtX+Wr5FEjTGaafun5VR?=
 =?us-ascii?Q?QunUw2cUcrpdX/cZxkp/hcPhFdIQZQDiE5bjOCVOwZ4fXRLOfaFtAHPKVGwb?=
 =?us-ascii?Q?Pe9aKnpD60vs/02MG+04WAEdrKmVAcwzI8FKnWQq6oNETla4uCmR7Ia71mYH?=
 =?us-ascii?Q?Rf/Dtp8e9X5V2TjJ8ht5zrCfzTSLyMDxiKCeh7TsyzTCb/ePwGhQyp/S+SuA?=
 =?us-ascii?Q?oINth03uSSlp3DOdBwqRCoh38aTVE/3zNiBUk7bV7bnvPyRQlvlaRjegq6o/?=
 =?us-ascii?Q?AWtiM3194jl2jt4Gxoruzx7lRh0bJjSzE0Ev3YRIb/RoXI/zf7Djm/lI9mux?=
 =?us-ascii?Q?+5VWG1Rlba+KLcB0AmhlIgzr7Qo/lSxRUryWQwLIoi0pN193v0zQ8EOrAI8h?=
 =?us-ascii?Q?hUrico2uj7T59jkn9yyOPUTMDZwVjL9Nl1u1No597r2/ZcPIWcyX/KHr6Bvi?=
 =?us-ascii?Q?dfVp9OBmBofevxPzEtelarMXxUQoNvxAPyNavUIHptzEZSr9UGeIZCZtebxG?=
 =?us-ascii?Q?7vQKhcO6fgeY2r2sUbQUhAE43Tq1+wiXn3ym/TcaDYHXWvZvbGEdoCcF15T4?=
 =?us-ascii?Q?8hvUE7PAS/Bc5Srqu8ht7u8gt1YM6VCOFSAeDhVTgin7E1vjFYuSQGnj/ywz?=
 =?us-ascii?Q?NuUslN+Pz2iBtQNPi3Rc6XQy+3Z2mmoUmeuuJ1rl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ececa460-de5d-4585-38db-08dc0c84b111
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 17:52:02.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFoPtjlpt7n9Pc2gefnnXgoUHHIWZBMlp7aHpVXJMKoAg4YVzZoYzItdbXU0hmBH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355

On Wed, Jan 03, 2024 at 09:06:23AM -0800, Nicolin Chen wrote:
> On Wed, Jan 03, 2024 at 12:58:48PM -0400, Jason Gunthorpe wrote:
> > On Wed, Jan 03, 2024 at 08:48:46AM -0800, Nicolin Chen wrote:
> > > > You can pass the ctx to the invalidate op, it is already implied
> > > > because the passed iommu_domain is linked to a single iommufd ctx.
> > > 
> > > The device virtual id lookup API needs something similar, yet it
> > > likely needs a viommu pointer (or its id) instead? As the table
> > > is attached to a viommu while an ictx can have multiple viommus,
> > > right?
> > 
> > Yes, when we get to an API for that it will have to be some op
> > 'invalidate_viommu(..)' and it can get the necessary pointers.
> 
> OK! I will try that first.
> 
> > The viommu object will have to be some driver object like the
> > iommu_domain.
> 
> I drafted something like this, linking it to struct iommu_device:
> 
> +struct iommufd_viommu {
> +       struct iommufd_object obj;
> +       struct iommufd_ctx *ictx;
> +       struct iommu_device *iommu_dev;
> +       struct iommufd_hwpt_paging *hwpt;
> +       /* array of struct iommufd_device, indexed by device virtual id */
> +       struct xarray device_ids;
> +};

The driver would have to create it and there would be some driver
specific enclosing struct to go with it

Perhaps device_ids goes in the driver specific struct, I don't know.

Not sure it should have hwpt at all, probably vmid should come from
the driver specific struct in some driver specific way

Jason

