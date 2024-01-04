Return-Path: <linux-kselftest+bounces-2629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A1B823967
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 01:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85207282520
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 00:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1FE15CB;
	Thu,  4 Jan 2024 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qlaC8OrB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A41F927;
	Thu,  4 Jan 2024 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqHiD7AGXFh9YYSx9fewgGJx7HJCQhcLxx7TuOpsGIQyWMcRaeqQPLgT1RpOAGLAEcZLHeWGMqbVLiExJhC0gFYqAZEWk3P7jUawK0TUfiiLXGS8Dfz9uDHZgVYRE+PorFrN1+ZeK9vW3Il5oRx4uA/vNuTOIZIqcoL1a8T6tNgBj92CPMmV7NrJvLqz1CQ7rQ6eDNb85Ndfe8TfjtKXMKXlS1NW8C3Y3ui9oJK3JP9UStVUcXZjSniUrCH6pKpoxyMFqrPkuCV7It3nJlJuHqzymPl+Mkb1zlTofqpcdLUwvCkro7JR9ko7xa7obJ7fHCQTXeKLUV9+YzAEzWBLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0nqVUuOQcrMn5KMDE1zBncnqxD5viOFhFu9MdqZuJA=;
 b=SVdObVkG1QLq3p+erRldGbxQRzIy6V4XCpfJSWtQusMapt9vEB30HRAWR8aru/oLTJ8HbVekDReC99q6rsxCfEX/ilVyxRkNXr8ij+3lIY01W8yrAjSkNIXmoec0sbjWcpw6lVH19o7ChSHAXuBPIbSiC3GXy5IiN+BxnSbm8g7IZweo8Px32WCaCXXBdNpIYT5i1BvtpJfYaaydyRCFeiGDxwbOySOKUz+2lwaFn/eHNiecJe163p/cw+zOE46gjncyX7t51BlFAi3mPkB3Q3SIfXyrJ+DTdJv8KvREDfiGqqwfoW8V8vJN2IdJuUGFWDGw/bg0MBWnNWb5f9sdow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0nqVUuOQcrMn5KMDE1zBncnqxD5viOFhFu9MdqZuJA=;
 b=qlaC8OrBTo5mJtXyWbghPidFcZwuAT1yLvUMRINsc2LxfoxdqB3V29VUb4dpCq2dotL+tZt3Gi7uOcHcFDg3E/vcjt3P/FKq8Xd2i/7mlmwfspwfGSv/XObcforn/MEqgRTZAm1ytkhsAeCE899hAYjrPjVRVx6Vdj8AiwGz/0gwmHFKa6Pmreh80t60C4w/unqdZ8Cgzk77HBE9E+0+9Q2Fi/KIgORbYJ2W40wS0pJveas8c9xs9ait3PRq44c1EWK/hoiUtKSrD6dzmi7Eh8NtRewyi/xsE61bMr6eSE0q/35tG03p5W1W0T7kCZEdkZO7UWwktzGQLMB7elwbjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5235.namprd12.prod.outlook.com (2603:10b6:610:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.27; Thu, 4 Jan
 2024 00:02:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 00:02:05 +0000
Date: Wed, 3 Jan 2024 20:02:04 -0400
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
Message-ID: <20240104000204.GV50406@nvidia.com>
References: <ZXvI2IiXwwuHRE8V@Asurada-Nvidia>
 <7c398efc-8a2f-479d-bcff-ded8cc1ef3d0@intel.com>
 <20240102233849.GK50406@nvidia.com>
 <c59a780d-4030-4815-a34b-fb2e2f902ab3@intel.com>
 <20240103160108.GP50406@nvidia.com>
 <ZZWP7iBqUtbTRb3s@Asurada-Nvidia>
 <20240103165848.GR50406@nvidia.com>
 <ZZWUD+lCw3mRc/15@Asurada-Nvidia>
 <20240103175202.GT50406@nvidia.com>
 <ZZXBGw9dJyvb/5r5@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZXBGw9dJyvb/5r5@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0332.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5235:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cb97a2-c129-457a-3a3c-08dc0cb862a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6W7hV+bWHIis00f+LIDuEDawzjkcFgfBotOZp5y20OvMD7hyudPUgCzcWzdpyKcOaOcHD5az+77Q4Y42X7LlqDXjy9d6G7dMLt5+1FiQLkrfPH2KFLmSaR5jcvY/5gygA23ohCutYhE1Y/JYLEVvvwqJ/aSdK1LP8NPPIFbneZyrPzZQxHnbJ+AuLeDQZ1P2rQml5E80kQH7dEYPZ6YQnKKnE1BowFVZ0fjvBjYWDtP55dnO4Ptib8qGxz5tGXzCobLNH5TdO81rx8uPZn/CHJ4i6JtyUTJnRt/HW+6rcItvvQeV+ScOdIWUHjBalStV2rbhGrvykeykXT9G+swyNdl8Xcl6fDH3rMZjj3QldphZiZkX2KN6iJimFh7nKsZOnHqHbavcItYuGHdRpSQR6OOFX3Rv8IxHsuc7G81ynNEQh+VLFHelA4uenhY1MbrwE713xlP4VbDDV6j8TaukHLM5C/cxCHdKEbQy/ttAewMe5Lapm+HzwKmCtJg4QeoKxQ5AV099aFDDXDKXncwAuQaQIDV8KSDUjA2yfQjhGfUhQ9WWfFsLwLkTjrKdlGSI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(8676002)(478600001)(8936002)(54906003)(37006003)(33656002)(41300700001)(1076003)(26005)(6512007)(5660300002)(6506007)(4326008)(6862004)(6486002)(6636002)(66476007)(66556008)(66946007)(316002)(2616005)(4744005)(7416002)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cx1kRKyQHbZtz+0IG/RqU3Nc3Y24q4ZUt0cyZ1Qv5BUy/b97mtLa1Ri7NTYm?=
 =?us-ascii?Q?kpvPQmOsyAnx6Kya/grPeRHrOdbcD5bFx2EmsMNSi7cW8seoG0Uil8FrRsg0?=
 =?us-ascii?Q?q3B+AyflOXRwp3fn5lE1oQ+HdXV6qD61y5MyTfr3QdMCOJbu07iLAH1whs7v?=
 =?us-ascii?Q?VxPe7fCQaUAKJ+VF/LXlvuaIl7ksyLNn86dsGQQfZcg0coWXHSHIXCkyAeXz?=
 =?us-ascii?Q?iwIYEzoUlTJ39o7CAKNZDvhX+namX4U4xFwGnstwSDNfDFb747X52l5Ty8i7?=
 =?us-ascii?Q?luu0p3HzjcPc1w1UG4sFqnvEPfIBbu6Jp1i8i38dY6gdnVzi5LxFNQbwOF4q?=
 =?us-ascii?Q?iqCV5fGgfV0HzOcY0vDz+SWrymgiw8rLR707uDm4No5epgkZCv9w990A5jwb?=
 =?us-ascii?Q?UjJBlGv+zkupUOhik9cRp5DgUdjMoVitxti5z2VKHTVzickjwpVFol/w4pVS?=
 =?us-ascii?Q?8YRWM6aynuOj0rTzp5slWsa8Ie1wxj+MTWniJ+BHMT+eMKC0f5441WK2OIik?=
 =?us-ascii?Q?3JLQ3ukuQTplrC4oUwrBxhropPFNCJaAxPXO/TaguP3G1rvBE6pp+vjPt/MP?=
 =?us-ascii?Q?lOZcXf8NjQ6Ezjvh/YjmMxEdUD0m/lEY06fWJyNYpqJVziAIPlaL7FaUHE32?=
 =?us-ascii?Q?4LO0lutDbjhsIKq2HIP4Lrd0M2sLIdlHCYQc5zWKRhXZrmMzcDpBTGl2yMFW?=
 =?us-ascii?Q?6s0j9NDSpJAyF6IVuwYoL0AOfQQmdwza2gAOl11syyV/bknelcyJjnN3+B6p?=
 =?us-ascii?Q?DcFlAqHU2b8S57CtRvht8vMYreukCidHSTobI5hquvsv3dib969x8bD/3RDZ?=
 =?us-ascii?Q?N+9IcDUzsDt6R0QIyjt0wXqcCV1TrwxpdEl7/wxDcpdBj8KZ3Ukx9lslzqQP?=
 =?us-ascii?Q?lR0FP2iqzljRF3xH9KF8v5a5lsUMdxEE9YlenGPgXVysb8KGAIglgK+BFpv3?=
 =?us-ascii?Q?i//zvGvebWX490tx6k+pgywH9HuF0FF+tFmle72FVyltIcHO2bYEiKUVkW+i?=
 =?us-ascii?Q?z1lO5qOUCuRSb6SawryLEjrnKTlho9m3nysImC8yjJfDTgIda8k7okSkE36F?=
 =?us-ascii?Q?0Vnt6nvzAV9hv50RYOdweL/7LI0HxU98m11GW1ylSrrT6Lra2TCHqJaIhYLA?=
 =?us-ascii?Q?bJYd4mF2SwyNhyuPCmRDhJGPia4As+CEFcS820i806g97nN8fRHMmoujTWz7?=
 =?us-ascii?Q?6XviSNDtyiWIkfzltO4wfkldLMEcoF2XQ2QrziZB5DWYLjyGwRPAal9m/9iY?=
 =?us-ascii?Q?YwMqGIRSZN8jLPEn58I9B29fscjfBjzqcp1LBeP2UiGHdABX9/kzCs6XplwV?=
 =?us-ascii?Q?WReh3tzfoA/qj+P5MuL8CP1zIzTsGx9lKCUg5PR93lkSjQ0cLJLgRK6ecDjO?=
 =?us-ascii?Q?FS0AubCIHUIVitJa9Tr3rTlo8rKf/GGbh971nI1BPw8rP54AD5owIlrgVfu1?=
 =?us-ascii?Q?/FWm5kHu+BZ1TI2omMbf/ws1lqaqDAL6Ogylw7+ksoqLiHxNGS1gUJZMwpuQ?=
 =?us-ascii?Q?h2v67npldb+tO4Osh7Qcu9QLN8is/YV1UMkBF8RyHqFeuakIfmiMgWUkUHY8?=
 =?us-ascii?Q?ku0em0LW05PBHuuJcfVIa1bybdcvT1DE/6tf5o0x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cb97a2-c129-457a-3a3c-08dc0cb862a4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 00:02:05.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlxy1eeinsdx7uSxbkt+DNpKUsdoOPMhUuYH2mz+K7gOspW+eNqKv8FJIvsottq4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5235

On Wed, Jan 03, 2024 at 12:18:35PM -0800, Nicolin Chen wrote:
> > The driver would have to create it and there would be some driver
> > specific enclosing struct to go with it
> > 
> > Perhaps device_ids goes in the driver specific struct, I don't know.
> 
> +struct iommufd_viommu {
> +	struct iommufd_object obj;
> +	struct iommufd_ctx *ictx;
> +	struct iommu_device *iommu_dev;
> +	struct iommufd_hwpt_paging *hwpt;	/* maybe unneeded */
> +
> +	int vmid;
> +
> +	union iommu_driver_user_data {
> +		struct iommu_driver_user_vtd;
> +		struct iommu_driver_user_arm_smmuv3;
> +		struct iommu_driver_user_amd_viommu;
> +	};

Not like that, in the usual container_of way

Jason

