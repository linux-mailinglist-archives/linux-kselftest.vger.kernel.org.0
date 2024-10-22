Return-Path: <linux-kselftest+bounces-20364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E2A9A97FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 06:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D371C22896
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 04:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3EA126C02;
	Tue, 22 Oct 2024 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r5yAv0kO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C1811EB;
	Tue, 22 Oct 2024 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729572028; cv=fail; b=DTV/cajs5pN79j+KAYD32qg0mFgDDPxvcKgeuqIdy91T7bXWze9eZwgQhVIgIc95pfhW/SqysLmlKovud5QT+GrARc2/a2vGEzCNKeaWDsv3+u1tB07Yzgg7k3Ti2Zur5jKHlf18h8Zn2BANF0zsiPUxQUv9AaijigkEOBPOUQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729572028; c=relaxed/simple;
	bh=8UZ2yfEBcs7nl7UJRlpuYYnmy86NZvbHVEjFvS0oD6w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsRuXyjOBYBLnq4hhPp7oegdDleSC9zw99DDG5TO91uSOvKKN0CVy2OmAPvM1krQ10K52nZtytMB9aj6EdfqHruhBJ+A4LhmHkf7LUSs1EeN81i8Ot+opkK+mUtvmDU25I1wWkl/PUmB9ZZILcZGPUGZnPCg8eq8zozvHI+2N9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r5yAv0kO; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6AHIAtjw4qZU7m3cknyfhR+he2cvNCy7Z3+oLkFgcK2lfFQ1PUGIKi+WcqhbAFGbe4W5wuomCC0CFyT0KjVdoCV1t1+4I2i6enyxcFvpyWlkzm+Vp5MTJHe9qruufo9RIjp0KmRXNDtWlV81t9xnWBXlew5PAFTA9eiFAAoOgpvt+JJQVb++d/BzqU9Mnk3uPcbLOxVzeJk+iWdg9bMfwR4Ul1DQuJ7K5aVsGbiKNYbJjD6bueE/rJEk6tw1ClSLHl4LmZu9+d0+YxnRvLUZKs36/uvTyFR/ad9oIwpspNgFivwecc9Lz4CW4RHs14HL2bl8sDyunw+Qw6fAjNT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1262cMGtRhZ3563nSrc/oO9okLNC4TdigHoMTQqtAsc=;
 b=cIjlIJ+K+kDnVrT98pFUdgfxeunxUxwDPAYl8iSTFaOiofJoVl/IsD0Wo+BxE+LtjqBbJVpF+I6tMPLHqa6LGF64XZ096Or5y+Ui1SI82iFIkDUTm/Hb247fEwpydqRNYS3jT5fMA8JxAlpKYdiaN5xLYhvnjpeYFIzA/KvqaLdApkdwUX0rd5A5J8nakZ4w/VnGUM3p7mrUdJAVhlFnam3YKyPc3UXm+g+cns4TE3l/1EXzmmGKA6Z5u8Z9LPuafdbEWv3UAr38ftm+T4Hp+FFt076NMpwdom6sycLCfcffbtSQwhbBCTKbbXM8K5pLSTWCBOUr+MlI7GnvTswXow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1262cMGtRhZ3563nSrc/oO9okLNC4TdigHoMTQqtAsc=;
 b=r5yAv0kORYav34i2GzMX0iAFe5M4bNkJyF2fAgDlKri4Vn8Ubmq+lHxc28ZbvZNWyfyyClJZeqy4SHAyrzDxPNrjez8HwedZ5U9+3Y/poHYzyfyQpqqYhZ5C8Ks8tQtl6QEFSdtgRZm2g4xPGstUhZIHR70vMaTX02X8rHM6cPGmHimlIv8s0vTGqQoaMvDpX5VXxKT/yPCv/+6GolKHHoDiMQhY60ug1fvVLz5HIajEb+y0Dvk39NzpGQbZ0LRhtGHKCoyGs6unLQthPmelCgvkpfmJKHTNT67qB1meXafFUk7554/VpFhe7T8fMTV+j6nrRxtaXJ5qPEKFUQzl4A==
Received: from MW3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:303:2b::33)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 04:40:23 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::e7) by MW3PR05CA0028.outlook.office365.com
 (2603:10b6:303:2b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 04:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 04:40:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 21:40:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 21:40:07 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 21:40:06 -0700
Date: Mon, 21 Oct 2024 21:40:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kselftest@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v4 02/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Message-ID: <ZxcspVGPBmABjUPu@nvidia.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <74fec8c38a7d568bd88beba9082b4a5a4bc2046f.1729553811.git.nicolinc@nvidia.com>
 <b2c75705-2998-4e51-90f4-00b8bab785f5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b2c75705-2998-4e51-90f4-00b8bab785f5@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a21a9a-696f-41b2-d5c8-08dcf253a3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LgGvZM/eEGLBZiWcK0u7bxndzp6qTebqMCJIxiLLlDH6f0FkYuwWrcDiDmek?=
 =?us-ascii?Q?e5hOWodyWQPbRN5TOrlmPzozRk1fcX3ej2ESxINu59GuENGNR5od8VAUwO41?=
 =?us-ascii?Q?s9nIvKLPsY24OSG1XwA4eQjP1IG/QZSlPgh6eGiKUDX0sssoiqsZQE4fubWu?=
 =?us-ascii?Q?CY5xAJNYCZDMyBqBat7A4TlKQ+3VbXgQJpzSTdk1XMEdkKXmkK/qgWvbtuiv?=
 =?us-ascii?Q?LXzU3cglP9eZx4rUi0i5T6YEeO+haKGPrI9J36AwET3iYXyqh4Xz+Cp1P6d9?=
 =?us-ascii?Q?fT02QaIEC9tQPXt2FFNThgB9jM2Q7F/ALYoggJbkkPPh8quSHW3ipCMMD6V4?=
 =?us-ascii?Q?CeQHh8zinisBeeejizHODi+hrtMeXw+NE1lpCyQOqB79PtxzsAJe0dLS5uzZ?=
 =?us-ascii?Q?yFd3r1QIVLIr6WE8Bpe1K27R9XqY6DGwJ1yG3AA9ybdfzmYp/rS9sxmJvMOj?=
 =?us-ascii?Q?JmdBKyfZbEMWx2YR+jw2qL/l/wCbPePp4NqnRdK29q5g/EqxHqxGJ2x5ZQW1?=
 =?us-ascii?Q?527VfAvjwnNJuBmv8a67+OW+gbLjhKhAvuQmio6672qekfp/Bawn6Ci+lTol?=
 =?us-ascii?Q?+f8CGXgul6r33A4UO4+NpHE4OihdTDOug3Z5YwF5WMK0aJFq8Ga11B+L+05i?=
 =?us-ascii?Q?LxAC6fLx4oQB5yztv0YzRH47Ki/l8T2faAZ2Eg5hvfDdC88pIOcb0SrDc9cs?=
 =?us-ascii?Q?I81CUTsg3tOcVkT+Khb62CtN2qEYCz1iYPa+zw656DcK08vFxi+TKLaF8iDM?=
 =?us-ascii?Q?6NSowPnqKVr9+VxfHAdhLvhvfeHbO3hJVfqDsjVsi1hRGgQir4niShy5cXFJ?=
 =?us-ascii?Q?2UTMobk3OoG7hK6gmouIax7B+esH6c6NJr2BvTkvw9w+7Wd1CwCTy4ms/5yA?=
 =?us-ascii?Q?Axohc662oZNHpTMZzwHwUJF3EWJCfGYOYN6cTE8YYw6gfxjBB1r1GVWr1dJD?=
 =?us-ascii?Q?1yHLFUYHhGfFMXyAXIjrkvdTmgF6p/EgJo+hBONHs9bDyMvZAZOcYimom6fb?=
 =?us-ascii?Q?hUy0NVPcKG39BbjVXrNwQwS0oZErBSiSQ/I2aLidhdv6Qy7hyjqRx34y6Zu7?=
 =?us-ascii?Q?q9z13ROzCmkMf2JWVVOcGM0E+V3MlruvUhPl6paEfNpk5tHH1DNLt1wO8iS9?=
 =?us-ascii?Q?4XuGoFwM4UcMkWpJZHsLN/ZuEU9I+u+A9FWdQ8XJ3rbwR/R9hOJje+6HM6To?=
 =?us-ascii?Q?4hxdilwe5RJjidNwGPADOPZDJvYaL62RgVWZ2gDII0h2rFcHm+kb0RlkwLOU?=
 =?us-ascii?Q?h4RXTc71oOZjMjMzISgk+gqCwBDMvPMH2I2rVhFgydhTkCgcx4SS5sRTAOeI?=
 =?us-ascii?Q?Zm5MaEZwuj29YJ6VUbfvd8FE3mbtRRKaf7LziHritSd/2t9oAxUAzdn/wBaR?=
 =?us-ascii?Q?Ly+hu4cQOSZp8Foj2D7L4x5YQmWm5ewWGY8fdeyee7yduJi2AQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 04:40:22.0088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a21a9a-696f-41b2-d5c8-08dcf253a3ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979

On Tue, Oct 22, 2024 at 10:28:30AM +0800, Baolu Lu wrote:
> On 2024/10/22 8:19, Nicolin Chen wrote:
> > + * @viommu_alloc: Allocate an iommufd_viommu on a physical IOMMU instance behind
> > + *                the @dev, as the set of virtualization resources shared/passed
> > + *                to user space IOMMU instance. And associate it with a nesting
> > + *                @parent_domain. The @viommu_type must be defined in the header
> > + *                include/uapi/linux/iommufd.h
> > + *                It is suggested to call iommufd_viommu_alloc() helper for
> > + *                a bundled allocation of the core and the driver structures,
> > + *                using the given @ictx pointer.
> >    * @pgsize_bitmap: bitmap of all possible supported page sizes
> >    * @owner: Driver module providing these ops
> >    * @identity_domain: An always available, always attachable identity
> > @@ -591,6 +601,10 @@ struct iommu_ops {
> >       void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid,
> >                                struct iommu_domain *domain);
> > 
> > +     struct iommufd_viommu *(*viommu_alloc)(
> > +             struct device *dev, struct iommu_domain *parent_domain,
> > +             struct iommufd_ctx *ictx, unsigned int viommu_type);
> 
> Is the vIOMMU object limited to a parent domain?

Yes, for each vIOMMU (a slice of physical IOMMU per VM), one S2
parent domain is enough. Typically, it has the mappings between
gPAs and hPAs. If its format/compatibility allows, this single
parent domain can be shared with other vIOMMUs.

Thanks
Nicolin

