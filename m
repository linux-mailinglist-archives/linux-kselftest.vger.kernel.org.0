Return-Path: <linux-kselftest+bounces-15439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4009539C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 20:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545911F24BCD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0E76F2E8;
	Thu, 15 Aug 2024 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ozTcYWJi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1838D52F70;
	Thu, 15 Aug 2024 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745655; cv=fail; b=RObSX2qszoP7rMTWaE3W3EznB4JIgt9XTHJnYMaOcNelXms94huQ3QYbnu23qfjBmEDS6JKFFWH4bKs4/OC8yVBJlD8/xPO+vzoGKos+4t2DyGUiOnBa5Japxbl/hh6LckvlWh5bmL4LYKBrbAQomw2X55z8rCf0V5MXuxHFfMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745655; c=relaxed/simple;
	bh=z2i8F2mj2rTcjOk/yJElnn3SzOt+0/R3oQDCNAXuu20=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOM3uCVSg5qDPtHVtXd/byqhaaKbzGpdwvTM01JHloQ2vq0Cr0OZExztBd61l8/+UVahHNWeATejRHjT3ZJCp7tJNnOji88ntcDrFbozxJl+E4HWNs/8VGfFCN/T+frfqquPDkGTE+TLF3hITq4/bFl+PIH2mechW+0Mo8DaVv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ozTcYWJi; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5GFHvOBVrTe8f3lLboTscybQ2U8TlxhDDc/hmAuSqsGSQicB/L8Enq9jGSMbmyQRP/VMMOG3MRzlpuCo4QnsdqHV7V0jSAqKnfE/CD2S2+Rv7bLABjRS7MwwqSRVIALHaSNp/l5JROCpzHVAp+4U+LtYyb24QosHOcjfK5Y87Z3AfiWAF6Y8gP5/W6VoeNMLEPADHsIOKvJQUQ1KRG76RHxkst3agRnPRwSU9GgUQBHR2FqNjNwNVW0k75bb4OFKvbxoWSSoRJxuZR115qv180X8sGeQewAqhb91rFknrUteKVjgstW7AxvvY+amKiOI2MRjpFphzlYOmMpE//pMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5oKJrje8LH8NwvehnGUpKbMcWj3kmAdLgB4XHmt60w=;
 b=ANAZoYdBRDZlV4s8Rgq7OXHSV0EbXMO9tbRMps824WSNkPaaiWNCdNMGfAzvSb86qE+XY0ItMBusRI/u90vTIRvxxZToYMZOym4JXxv93R/qis1ycPYrD0i6PhS/ABlPwuHP34VgZyzedPtl1SthCzXrW6d0RISlU/KPM5j/+c9Q8TrnX5BjG4/ImUeSu5CmMLghPWvaz2pSdXvbDANJdhFELIsSCq76EQCtF3CvlVyFQetiNYQwkGkLZj9cru381E24kVNa0jgmzliKEmURolH1+hfYCBBLqoa3nTTJVBDCSta28yU4bkvCQtCOD7kDTP5FPgmfjM033/w4uAgokQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5oKJrje8LH8NwvehnGUpKbMcWj3kmAdLgB4XHmt60w=;
 b=ozTcYWJis+RR2nX5BRIu5Grn/l0u4CZsJiiU3Fcbq6A49l+8zdYdO/mXLa/CcdfvODHRiGXld3TSNgpCorOQXNc7Bk/u8tFdJEMmNc3rgSTAoDk/SKXwLPT79iDjlzZFP46XVMt2zR3nSivKT6r2YQoloOnWrMsKPoCG3lb0CoG3irl2Esxq6a8YUE2hK2qOhZR9rYNyhVHRdmwzQsL3KYXI7otIEcInPIr57o9rg6tnSG2xkMiP7A7O2NnbOKv3PrfMybuJLhXzRnq7Mx00I1ieuKM5W7yHaersaBgkTMJHfAHOzDriYRQry4x4pvLgxE/aCMEkTdCa9d+AKK6+/Q==
Received: from BL0PR0102CA0034.prod.exchangelabs.com (2603:10b6:207:18::47) by
 SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Thu, 15 Aug 2024 18:14:10 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::db) by BL0PR0102CA0034.outlook.office365.com
 (2603:10b6:207:18::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20 via Frontend
 Transport; Thu, 15 Aug 2024 18:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 18:14:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 11:12:08 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 15 Aug 2024 11:12:07 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 11:12:07 -0700
Date: Thu, 15 Aug 2024 11:12:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<will@kernel.org>, <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iommufd: Reorder include files
Message-ID: <Zr5E9jlQ0HJt0BGE@Asurada-Nvidia>
References: <cover.1722644866.git.nicolinc@nvidia.com>
 <7524b037cc05afe19db3c18f863253e1d1554fa2.1722644866.git.nicolinc@nvidia.com>
 <20240815175140.GM2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240815175140.GM2032816@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SA0PR12MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0ba3e2-d50f-444e-5ad7-08dcbd560f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f2HSaGKF8Qa2pxu8BlMRrkhu8v6upJSc24xp4O49C0Qz/7Uwv6zwgRf1DPxN?=
 =?us-ascii?Q?zt7TRQpHYfMbfnq/wcXwEbJHlx8tTfmupuHcrG42+NJLF43iuqJDFiOrxJEw?=
 =?us-ascii?Q?HWeb2zYEeEcaiv12PZuKkUBkq6X2pMhZveQi8QDyo3ecMZA4WLRIAqJ2sXAl?=
 =?us-ascii?Q?7G0ZHo4sdzvyZUsGdUARk3CCaD+Ecra3mVgwrbpkFyiI2A1PyKYVE+lMBSSk?=
 =?us-ascii?Q?aOvFHDN/a5GJWxJsPehOqZtfaIIPfrcFO+n5ktHxLEPJmjWIWrhEE20jnv2r?=
 =?us-ascii?Q?URXLtACp/KJtERuwmTY/+pbCZNdNfd0QUJ+s1AmWPiX0bx68m37fXjlBB3ob?=
 =?us-ascii?Q?vybFV7A3a/Cx8+mYsE3UQaAobrtAfBffeu6fZ9D8HKH9qU6mgRb0PBeifh+K?=
 =?us-ascii?Q?FRgjPAujDnXxuuF+RM3zOHaQDCoTMknXfpmrd7KG6fdgucdrbWQtw0ZWm6d+?=
 =?us-ascii?Q?LjRqu9AI9FSFm14x63ZMwcEJQb2xH11QsMtzt7GNea0OHvxLNEAppmjWGy4F?=
 =?us-ascii?Q?INtAvfBCWDg02sEnFvDbbmv24P0yhsn8n3VS4te6mixyVHzsC2B/mFkmlU/7?=
 =?us-ascii?Q?yOcYlHmyre/aV6FIwxL2gIZli0sV1793PLgPVH7xiFemyVBnZ7q6ipKjoGpT?=
 =?us-ascii?Q?QO0wGwXOCm7sFLTOk8xt3IXjIjmUS9gBd5YXTBY8L5B2hVTMmSbzLI10Mwup?=
 =?us-ascii?Q?RJKvd+uqNBn1Gyrmirt/D8X+PyS9aepo8Odx5BmgeMksPPAreJsfAMGtTof5?=
 =?us-ascii?Q?VBPbwdEPhJK3/jE/SuP3sJkuMFwgb9aU8VBK0G+WStMNlOgy53kJebYDnurC?=
 =?us-ascii?Q?teUsREze3VELEOOaxK7uewjco+mZO8Zw3JpO7kPE/vMngTYEgeShwucpxL29?=
 =?us-ascii?Q?tmfQCmqhI5zLAvG/rPHHev5qUSqdA6nBiGMV7iYw3TB4AnGbbWp1I4va5Exq?=
 =?us-ascii?Q?uoJdvW4ej8/5KlgVd+xT84RZO262/B48h9iiglwRkvVR6eKayEr9S3IetJS9?=
 =?us-ascii?Q?tkIbicA+D2MFkbLGYKfhrZSWxSSfVCHyYt0PA9B91sCm/amyJXr5wSPbpLu3?=
 =?us-ascii?Q?CLzcsofghxzgoY7CLCwXP+gt33o2+dI9nz3gSPbPyoVYfrXO0zsKei38y0pi?=
 =?us-ascii?Q?vv5MXzVP1D6Py/GrRpbKNARnVPUfJ/GnGZAuN3yV6VIIzSS75tHUpEzCkUp6?=
 =?us-ascii?Q?U8tVt23Fv/NPXJ/A4s3hGUjrYOwnhxH0o1HKhNNAYfwwR7l0l2JMsJ6VgUAN?=
 =?us-ascii?Q?4DYircQ8bLsKo0HbyXaUAhRFs1sTGC7MAS03w7bO1ASZwnnnCZ+uW8kD1t+C?=
 =?us-ascii?Q?++ic+5Ls/RtcwzygRLLxUx1X5qRiB0DjFzHyeEs7YMxp+vUzfKx2yMiUFkCx?=
 =?us-ascii?Q?OKJdwFDRMpM4H1uslfeTmQX4TI5cp9SBcHDLRRoURb9YYAov/de+mTZThYIv?=
 =?us-ascii?Q?+mV6nJ2ZFGqP2A4nxk4hEpPJAIRS8aoU?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 18:14:09.9866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0ba3e2-d50f-444e-5ad7-08dcbd560f58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073

On Thu, Aug 15, 2024 at 02:51:40PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 02, 2024 at 05:32:02PM -0700, Nicolin Chen wrote:
> > Reorder include files to alphabetic order to simplify maintenance, and
> > separate local headers and global headers with a blank line.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/iommufd/device.c          |  4 ++--
> >  drivers/iommu/iommufd/fault.c           |  4 ++--
> >  drivers/iommu/iommufd/io_pagetable.c    |  8 ++++----
> >  drivers/iommu/iommufd/io_pagetable.h    |  2 +-
> >  drivers/iommu/iommufd/ioas.c            |  2 +-
> >  drivers/iommu/iommufd/iommufd_private.h |  9 +++++----
> >  drivers/iommu/iommufd/iommufd_test.h    |  2 +-
> >  drivers/iommu/iommufd/iova_bitmap.c     |  2 +-
> >  drivers/iommu/iommufd/main.c            |  8 ++++----
> >  drivers/iommu/iommufd/pages.c           | 10 +++++-----
> >  drivers/iommu/iommufd/selftest.c        |  8 ++++----
> >  include/linux/iommufd.h                 |  4 ++--
> >  include/uapi/linux/iommufd.h            |  2 +-
> >  13 files changed, 33 insertions(+), 32 deletions(-)
> 
> I picked this on up to iommufd for-next

Thanks! Was hoping for that.

> When you get an answer if we can do something else for the MSI lets
> reconsider that patch, also the 3rd one has a kbuild failure.

Yea, let's hold the other patches in this series. I will submit
another selftest patch, after we have an alternative solution.

Nicolin

