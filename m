Return-Path: <linux-kselftest+bounces-17311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AC296E165
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 19:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4401D1F25085
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F8156665;
	Thu,  5 Sep 2024 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e6IyvDfi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29AF79DC;
	Thu,  5 Sep 2024 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559062; cv=fail; b=t9gShlVs2wNUCnstad4u5n3q+IOIfUYwWceafpQjQfsoDEXBh8BgiLnJaBUlu3DpMORB0+GakP1GUVPOgOlYYl8zB3hLlvEMYiuWEgnBinrSVSyzMUspYyyJE0vOv7ve7AfyWKNg2NjOWfbOB7MlHgXjBD0/VhzpQLQBt+7mXIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559062; c=relaxed/simple;
	bh=PrRIwE7QCQpIX5qm4mXJS/KZfU4YmVp1FARJrcEWgTc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poUY/BvcjF2gB8men7XjbAayC3qukX/REX9pt8SbueGPDI8MSoWFt1pYF2X9UkKrNhywdLXQ/8RcI4RKqj1PvJ1POL8HeoftBTfHamPVopXCAheuPr2WVYCXb/VTUplHNcbPcT8q1J/a5AekOfcO9bfOZpd80mk/i4NVEJ1Wl/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e6IyvDfi; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7IlxpTHNobRAlLAkUFunDi0Aj7/MMaL0PTugG9OgHi0eLpCd6TWfR6Nn5QrpitRjT0GtKkvcEp4jEEiApyRS84ySuaW/u7dQdibLIwZkW1W4F41mrxDg4IX0Q5wfY5dS9grwMh9fijMf75zTKy6tE2cUvjDRUQtl8a7cABUXs/OaePwQGLb1Ja3Rw36a5wY9vVRLjBZrIx1VDJb2ykBX3lO1kXPJRBZGen/TImRhi4Qgxp9vMUaLjmAJLwO3jAjSRGAsBHjNNr8BscYWyQCt1ol/KW5QMRyo7ZWuji4QHuWGUMM1NSTQeGvaNJJwYXN/ybO1n0zmDrVYr/zQ/8x/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sw08j36ADd93mE04ujhL4cQh4uBvuZMEglz8tOv07bA=;
 b=WBhBp7GiykuojqJlCuCo3Z9/olrf2pDmGFYhcfaJ+2QXiiMCS8r5SS02VuAqaKX3BFgVleEhiAlUxz34q1jKtjcrE0eSo1f0s+pqdsDBbwuGR/kK3jFjat2+5Mx3tOye8RMp12GC5euUWg9ihzDAxykVww8UkJSGmcYMK4Hq9+us2lbR3GVc+6XyCpwUUJi/W980mZ0L10CZG/aFfo40HYvOJi+XCUxpr13/pO5xSL3ZOpLuQ4kR58ftks1rtDe6VH+ZT69uzMI9N9yj81tgCFQFldhE0MqwA6VHPpsZwIP50y6f3iQT9zHVO2BmYaAeVOQ0SOAnYsFqRb2ofbqfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sw08j36ADd93mE04ujhL4cQh4uBvuZMEglz8tOv07bA=;
 b=e6IyvDfiZjdBe0ZGCnYekcFEcyOzattrIemZLbLYL7IyVD5MTVhW0TxIBikFmWSKlv9ikdQOZgyOom79xcN3OnjbOheiAduLuyfPBS/O68lH9e+n3iVaZmb4K0ekQtdroiT4UeUiGwlkMEL4xAEMejuShnRPdbb7m8gkTc4lBWWn582WrVC5k92OcOvofJl/1hNLt5d7VT8HBi8fuLJ8cIznH2O/xNLDDJervuHRc5Th0cuMMQjP7zpg5byEqRcgRPQRyXaU6SqAdcN98ZH+b4LGc6uyxhPhBheFr5Csdce8G/Vb0cM9KMa0Yt0NJb38S1vxWHfYJnCCff0IpXkyrw==
Received: from DS7P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::10) by
 MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Thu, 5 Sep 2024 17:57:35 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::57) by DS7P220CA0006.outlook.office365.com
 (2603:10b6:8:1ca::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Thu, 5 Sep 2024 17:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 17:57:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 10:57:17 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 10:57:17 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Sep 2024 10:57:00 -0700
Date: Thu, 5 Sep 2024 10:56:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 16/19] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <Ztnw5iAxUNB0lukP@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <3548bfff43a0e1c072b77fc37a1a8a6c930bcec9.1724776335.git.nicolinc@nvidia.com>
 <20240905162317.GU1358970@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240905162317.GU1358970@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 336383ff-0d59-4282-b07b-08dccdd4388f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H/FitNwXLd1AyQF59YEPvogOfudfu++f56M272o+TehUO+GP69ztbisS/M2K?=
 =?us-ascii?Q?pSq7U5yJ9x77k9vf9Y1+AhaNtMuzv8Org0AwH9e/ZNeYT0Lmd0ux9koDJrKd?=
 =?us-ascii?Q?qb8smtOqLQntt9dol7/7BsuS9JWFPjYXqAIhjYG7ygUY5lCYr6d2Y0nivISP?=
 =?us-ascii?Q?7++iW2qH4vYOr+eTTO/GE0nJVgodneXKg2mUrWlm6fgPQF0bOdUHFJkW3Xa1?=
 =?us-ascii?Q?sYdiTkCNPQnOJyHMECLOiPvfaFg3V/s8r/mvPBzgqY+QLr0ZCd6CTi0ykefC?=
 =?us-ascii?Q?cp1hP7htvKQtSON3mHdb0HG+KoX8XQ7co/QDdDWvxd8kMaODdU5SV6T7hijr?=
 =?us-ascii?Q?0RBH8IxX1VjJdWnLdXc382dXb1um8mjI6hbCAOq6lfCtwEfbFjjAg3XV9YuL?=
 =?us-ascii?Q?64Lzmuu27EERjOzvUstnlRnGX/juszlTjhOPMBTfbjf/DQGM+R2Pobbsl3Ax?=
 =?us-ascii?Q?7OsUR8+DhAJqu8Pbs+bXfXFet98Hpey1BppHZRCPf2xBfxRJiaRU1LJQYtBx?=
 =?us-ascii?Q?rrjBZwfeBczVc2BYH2HDJfA+mOdYadcijiBe9W0uHTydNKt+LTE/dXhbxbpo?=
 =?us-ascii?Q?NnoU+X4tXeCU9hIDVDqPdz7Ioz451DGINzWaTh50SlAAfC0RVUnSB5SCxxz9?=
 =?us-ascii?Q?PR+xlBV9k+PErHJaA0VmvdltNx8s0QGnKOi2gQ/L35CMl9aJsaetwfsd4BLE?=
 =?us-ascii?Q?Jhen5nzAVa+wCkeL7uGNNWIRiU+t/JY+c0Ltqdo9oKDQqdaNDHuPcEb1GBBn?=
 =?us-ascii?Q?/5D8qGcl39oUPzkIfITdfg9vxubeLED+SJfh1yV71ZtxhBFBDB6Zjf0LRdWN?=
 =?us-ascii?Q?XXI6sD6qZcvs1MHZU35g39iumw+LbAr7aOVUuvhzotid6d3MGOH7eJlsSY1v?=
 =?us-ascii?Q?CvvUvPYulcF5vGrJ6B7DASn9klWNsvFspnPRV+GNzczHu/qZu3xadlg3Xerj?=
 =?us-ascii?Q?9gFhLGa6+AuA0L0XE0uzXpC1XIxDGj4l0kWGI83Tkw2H0onM+Oy6900uCE2Q?=
 =?us-ascii?Q?iFQiBsss2ca08gfQBl9NfrBm9Tb95B8eznX8vrij1RgeZmcQbtmoih4IwEj6?=
 =?us-ascii?Q?zZtvNT0U4vfinxuxpiKuVe3h6CAN7gPdu4qyhVyTODSqOaADNlnsqAnRTzBt?=
 =?us-ascii?Q?Bcb4aoWY4GNdkfyKdOQrnejS/9Vaj+CPW4MmTiCsqRmESzs4c8wMDDtfEXrR?=
 =?us-ascii?Q?ONgd5IEtX5A6AEqzN6PON0JiurG0IjhGJ0dvvEWHpcLfFTELhzMe4rH1SzJF?=
 =?us-ascii?Q?lwg+yg4uZDhBUvU2lv86SHyvy32SfwKZKAG1Rtlg3SHNmpoBJRj5kIQQtg3R?=
 =?us-ascii?Q?vdL+lERuugmXZbf8o+2EtYFu7YaXqn9TVSIEVWbFt3i7oGJuxy6nhn2nn5Nr?=
 =?us-ascii?Q?g1hJ2feHfiAo3BxSYhqtgFWlkRTIzpnUClqTqVxhoX07hKbSEQXzds8d/VfS?=
 =?us-ascii?Q?lf7S9atW6E9mwN4DGhwkHpUg44EUfnSd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 17:57:34.3907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 336383ff-0d59-4282-b07b-08dccdd4388f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373

On Thu, Sep 05, 2024 at 01:23:17PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 27, 2024 at 09:59:53AM -0700, Nicolin Chen wrote:
> 
> >  static const struct iommu_domain_ops arm_smmu_nested_ops = {
> >  	.get_msi_mapping_domain	= arm_smmu_get_msi_mapping_domain,
> >  	.attach_dev = arm_smmu_attach_dev_nested,
> >  	.free = arm_smmu_domain_nested_free,
> > +	.cache_invalidate_user	= arm_smmu_cache_invalidate_user,
> >  };
> 
> I think we should drop this op. The original intention was to do
> things in parts to split up the patches, but it turns out this is
> functionally useless so lets not even expose it to userspace.
> 
> So the patch can maybe be split differently and combined with the next
> patch

Ack. I will see what I can do to submit it cleanly.

Thanks
Nicolin

