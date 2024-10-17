Return-Path: <linux-kselftest+bounces-20027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAE29A2C7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E50F2823FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5E2219C85;
	Thu, 17 Oct 2024 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mXnnYUie"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118217DFE0;
	Thu, 17 Oct 2024 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190916; cv=fail; b=jNz0TBgRmVUTLPylg94lACWd4LnKhALC8U61621x/XBnvwP0d38SfVePYDLr7u7G68haeIVR063VHRexYLfnRJ1/hNvXcYsDGlldF2XbPreE4GDgMxA/xipSBCUEatowVgzN2D3zNQXZkm1R4hbjxTOI+qpX73TLbpr+SWanMT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190916; c=relaxed/simple;
	bh=OtUc+qkAXtlKbDx9f7JTaGLkbRbXvDNJU3CNX50J1mM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJrzha223mKwZi00PF9aat70o8Kv2OCT8y00Fc4GaxO6Jie6jtEOM6UZ5WXG8d4gHlhJGc+JL5JWWDr7KgcvZPY8Y5E6j3JDurMXzHeqhGWP8Z5GVEsR6YVmn2fLa/wUN28A0muB4YlCFZmPxVq9fU1FdO3yfpBQsgg66hL0TWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mXnnYUie; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwPrshUbKUvF4zkKmmXxINYCNIomOgoQ/AGlAcVBQH5M3XyPEw0cy+OEgGYsHWEMHWCBYnAjkgHUEyPnupD/ZzFj8N6FSyXXL+AKnoH/RdFNTWObiftpPa+kWJwtzT3uR4xtMW+aE2X61I8HYJw5ug6UxqQKNe9k6AXU/sl/xHjZklqOd5f60HMyVouEXtfI/G6aKDeS+p2vlxfEe3Vk4euBPl5bqTKHUxrfQvOIOdWcqdjBHg5kEIdT1XR8Tz1btDFDVkuN9OhjjcmFU9kTGkI1QsG/ftxQiQo0ztPppSBYUCRjb/MkencTM/7JyuDtv0floapt0ZQ9srGwOSRUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smtiuZowB9eFabJm/E7LgrjwzSYqD/7k3tYJKYiZT5I=;
 b=EuWhja/l/nvp/InpzVwKZK62sl+CEs/Y0dH+In1/igZUUQOycMG5l8lAcLcOQ2/Yp0bY63eLM2bfZed5f8aSGtHkdLGVdmCHeK1qqQpVp1mORcOsfsgsEctlRcvDfoMBB3zXvi+WcqirRxabeZhTxYtdGo7iR6umNUo7C/2pPIUKcU9bF6QjpiH4dtRGIzmqiElOTpmcqzv2YjfhZp/k0dv6wd6gh++4Lx283EW1UOaSZqf0siaHs4GdqHphzwubDFssovPKeeqR2aItDHJUu9C+nIFaRik/FD5AP1Hmn9Y4vhNYO0rDffMB9j6yoc/knyffW2BjyHmP1VXR96lPWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smtiuZowB9eFabJm/E7LgrjwzSYqD/7k3tYJKYiZT5I=;
 b=mXnnYUie2cTWbGuqAhBgBED0j/t1GgMUPlIQYcNM5KyIKP80PC3M7xcKxA+Vu5qYCZsTVRPP+NuDekCzEg67ryzL7XdwwebAisY1zHwpN8AXfyz2lotSTivC9FwKroYtp/I6QE2z2yK934+37ao9URD6cejypjclc8y8d4OJa0QwQsyg//c884RdIi88QRbvqNeKwH4okGubhJlNHCIBFrYsTfS5sXaqec3/lkUMZ9O9UU6LceoANaL+CqoXFxk7Gh8TVnwfo9ZGAomkJd+IX+b7RhF9TAlTtiA1NvdL/pUTcvt9Cfi9SPnqkBRzXOa6d4Ybj9X49P705Kb1cwJKrg==
Received: from SA0PR11CA0056.namprd11.prod.outlook.com (2603:10b6:806:d0::31)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 18:48:30 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::12) by SA0PR11CA0056.outlook.office365.com
 (2603:10b6:806:d0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 18:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 18:48:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 11:48:26 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Oct 2024 11:48:26 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Oct 2024 11:48:25 -0700
Date: Thu, 17 Oct 2024 11:48:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 11/11] iommu/arm-smmu-v3: Add
 IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support
Message-ID: <ZxFb+O5NX9fS4KFe@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <562f2bfae1661e6ff6abdb280faa0dd49df9fbdc.1728491453.git.nicolinc@nvidia.com>
 <20241017184015.GP3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241017184015.GP3559746@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf0ceac-a503-425c-1abe-08dceedc4b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?idzURIIiLrjSNXF7YXh9oYT6jX7An6jytHLCsMvulPHTHsUxngWVSOKv3Yv7?=
 =?us-ascii?Q?K3FiTOh0Ia9crVXlVdCuDg9iVwq0ibIxJTHopJYowXO/E09G2+1rVl4XJrBh?=
 =?us-ascii?Q?3ybzwIE8JK1msg/RlVWBi27r2Q2Vf6Egcl8ngWFoiZzVxlJpb3vlDUwIlWr1?=
 =?us-ascii?Q?qiCqsqGO8Vz/gBNIZZ3EivF5vr/Pz8fZkbjNDNywlJgkOpFpwQZX6VqVmKLC?=
 =?us-ascii?Q?AfE25fd6RlRQL4jtt/FkgNewwNrXif+XdM60BOQnkRRd8NNge0eRS4CX3MeL?=
 =?us-ascii?Q?hD2Cs7Z/gGhKJxR8fPI9nDzzGBj1hEdb2ELNdbU6+Ww2QGNxDbCQImDwvwaH?=
 =?us-ascii?Q?olYxhL96RVzNbMKsJnCUZC95eRJjJ+RHUPGHp1HGnMspvrJQQsT9KpuDBl4V?=
 =?us-ascii?Q?4568EB/J+1IvixaxAau0jNc46q8wtImyVjDNIr4xMrBTpMoR0s4NxvICbMuU?=
 =?us-ascii?Q?JZI97mukGZdVFC5qIi2gyuXEKv/VsgmP0ZLg8bn/oMr9sDW30dpJLKrFiQSs?=
 =?us-ascii?Q?+mRlFRITQxtYtHqi31DnNhf6ovgRSgw5lg2v+p/DeIVFdh85vLDLVUq2xaNP?=
 =?us-ascii?Q?uD60qPbaVLzwFiFtoRPB7WMRsccOWnvKduGk59cfjtEpffGVyda5WJDlF5dn?=
 =?us-ascii?Q?iRDAyYALwyVDB1fiojLGWJVWoPI1Lj/bPbn1ire+GwoDGQCBuLgnFeeB8eCd?=
 =?us-ascii?Q?FWlXKiX2jznlVUWNp85lwTfsLBjFWV/xot9VfEW8dbNYs+UHMtyjBHANz5Ky?=
 =?us-ascii?Q?o2zrNO3ygABY9jYW4VCiDRalajJ0BwHq0iy/l+mTuwqJkUV9Wx3awJgAnuk3?=
 =?us-ascii?Q?K064UXlBaiRYOnBXoD3nlB1MduoD5QtwQ96xDidfo8Rptx/kufFqWjfiPYqN?=
 =?us-ascii?Q?pt6YLUA8LsYRBtryDkD84wZPj0Pw3oQ2nuC4kUnTEWu0ttLJADtudqtNSfpB?=
 =?us-ascii?Q?0jq7DE3DFT18FoKmAAvsBBqT449iKJ8PrWG1RrXLd21BUvPm5YY5KLTRsTnQ?=
 =?us-ascii?Q?RBs4TTm0cR8WmKqQCEAB1Duo5cNa6U8WKZr5pFvEv3/kEVVcowdCcDrETEH5?=
 =?us-ascii?Q?zeAX1h8+i0wJN+GlS1ss+h7bWPLXf4mVwE6y/UJuaKD98MWFYbX2YhPpbp0u?=
 =?us-ascii?Q?g6/m+9IYHhodEKAj8LCqSOf0wiJ2N5h3ngl6DK8FOVWW84UPIF1GF0QXQ7xg?=
 =?us-ascii?Q?Q0fPf5v6UE9wtTiqc6h5t7fyP60Txt8ZXCTSH3y98VmcATH7h6Z0nUOE30lF?=
 =?us-ascii?Q?+UyWsECaIz0DshKBrLRBp58xOvF8+Or3ir9YU/+B0EOIOkGQmqUdrAOWFlOO?=
 =?us-ascii?Q?nd0OomPOwB6rDJJWr/0qveQbChpg4XuAHOUBMIXfKmnT5FitVDhvbRbl6ASe?=
 =?us-ascii?Q?UNP70x3OERrYcqMsaGA/XzybcQUVnceAFuUgATu+i+k/B7KCIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:48:30.3847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf0ceac-a503-425c-1abe-08dceedc4b68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449

On Thu, Oct 17, 2024 at 03:40:15PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 09, 2024 at 09:38:11AM -0700, Nicolin Chen wrote:
> > Add a new driver-type for ARM SMMUv3 to enum iommu_viommu_type. Implement
> > +static inline struct iommufd_viommu *
> > +arm_vsmmu_alloc(struct iommu_device *iommu_dev, struct iommu_domain *parent,
> > +		struct iommufd_ctx *ictx, unsigned int viommu_type)
> > +{
> > +	return ERR_PTR(-EOPNOTSUPP);
> > +}
> 
> Let's do #define NULL here instead so we don't get an op at all.

Ack.

> > +struct iommufd_viommu *
> > +arm_vsmmu_alloc(struct iommu_device *iommu_dev, struct iommu_domain *parent,
> > +		struct iommufd_ctx *ictx, unsigned int viommu_type)
> > +{
> > +	struct arm_smmu_device *smmu =
> > +		container_of(iommu_dev, struct arm_smmu_device, iommu);
> > +	struct arm_smmu_domain *s2_parent = to_smmu_domain(parent);
> > +	struct arm_vsmmu *vsmmu;
> > +
> > +	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> > +		return ERR_PTR(-EOPNOTSUPP);
> 
> So what happens if the user tries to create a default domain?
> 
> It skips this and just creates an normal viommu object
> 
> But then what? The driver needs to make sure it never casts that to a
> arm_vsmmu ? How?

So long as a driver doesn't provide iommu_ops->default_viommu_ops,
it should be fine. We may also block DEFAULT viommu allocations in
the core if the driver doesn't provide that default_viommu_ops.

Nicolin

