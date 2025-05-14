Return-Path: <linux-kselftest+bounces-32962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EBCAB75B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 21:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CF83B126F
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 19:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB9728D840;
	Wed, 14 May 2025 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y4836qgO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234D91420DD;
	Wed, 14 May 2025 19:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747250517; cv=fail; b=rl1r9Kv9f/QRXgKgslzvm1E9g+LY8HCPzIppklkew8g6SYHrI4v1up2SsBPUJkrUBGh3XDCHYXPQ0py4uEMUbxzjQSxSAh0oxmTYf41yyGYJnLd6OKAlDWOMGeOpcwnIsoxTEuKCzgFcO7GZAvBRfyVyUDlVHCfp0WJNplS7Kgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747250517; c=relaxed/simple;
	bh=5pYgFN63fLOiz/ZoZ/fI/ThqtCmaHxlFABFiM1km1gk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOm7eTLbMpM3k5zNY88zrqjw/TFQKSmrUK9bgbkwbPee8IO+7DGaH9bt6PHEfsDYgvIHk8jAukyq6RToT376C0iVSKEpUVoUkejmBYuuyfkRx6CLq1crGYQPO8uQAINB0UUw/TFmfY1lfIk69zzfyVuZ+vsNZx7ugPNieQeTSOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y4836qgO; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+j1+69MVjlzwdyGhPijla77bXxxIT270QrwoOliP9NH63NOzHjtFFZhcZbkOEPIfg4aJPSrheR9qGLDC7kYaHl+97tEjv5CNdzx8hGf06IO6llR+qq06zoEEPQTPrI+hbLNvvGT6i2fhq35RzblVnqmaYyUpUqWbCEXvR9YUL7vpJTHyEVM7zHzQpk0UELUHCq3Cftq5CPozzCl3qhwprCtaPe+gobyRoRtNvbffmV40a0pHFUwjaQCOaSubyAYG+k9CB1YtIfGy9rO1keyxzdb00NNGBUfF84YHrQqV30VTg9xLtidN6MfvO37zrRi/dWgIKhZuFug0DlMrU45jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlUQ7ww5romtO3zpOEtoUdPbNKeBCexbThMXmYa1M80=;
 b=XLmnKLSVzasouTlyrZagkExqYMcflXFZunidsRdQ04pcILH0ZgjvGhSX3YW5xH/aqRoGVEpAxB46e49QQ1OoxvlEAK+kuqk4b3CK7KW/Rmg50dt5srCeMxmoNk8MLZFFMdxHU+8XP+RObhDQCS9BdqRPYzGUnY2woZ/zYrcuTdj5YBzS/hHR4MVlbv935HfafragIlXtM+U51sF7y+Y0XE+oF46CEwLMfLuwtBPtpLS43PRP0iJzCwW10HTHCzgXo6X5feFWJBRaTGLWgs6F7gk9GY709T9iTTHY5epEFmckH7rzXCVHCykPQBfOQLVhAJrKGIvtYhflV6tg9yi54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlUQ7ww5romtO3zpOEtoUdPbNKeBCexbThMXmYa1M80=;
 b=Y4836qgOjAk6H6ReXtCa3DFi4uHNclsRvgT7ajUOs3GcKLdg6Z7TvqiRHS9JC7xU702Xl+EuJfteg8ydKiQoPI6DyejoJqQ6Nc+f4gn96E/kga4jEZ4OPiucVlF6PnGLWg3n0h+qpcQgZVJWD+yB/cpfSbPqMJA6+aLF06PTMrcmJiqg7X+AVkCeG4Te/O4yjNj+j17XCRcZV4CBOR4FfO8yxaEeFB4z4wp/lQI37iEIUtE+jBAR/2+W0PFk+YOLhJnqWbVKbHAD8tGnO8v/RLcCKuG2cyRM/m+hJ5DlU231U24tn/Ddeg1MdeEMVwBr2kP2m6Ha+RR8Jv8ZS0Xw0Q==
Received: from SN7PR04CA0183.namprd04.prod.outlook.com (2603:10b6:806:126::8)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 19:21:52 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::f0) by SN7PR04CA0183.outlook.office365.com
 (2603:10b6:806:126::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Wed,
 14 May 2025 19:21:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 19:21:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 May
 2025 12:21:40 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 12:21:39 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 14 May 2025 12:21:38 -0700
Date: Wed, 14 May 2025 12:21:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v4 06/23] iommufd/driver: Add iommufd_struct_destroy to
 revert iommufd_viommu_alloc
Message-ID: <aCTtQXQ61LLbHk6U@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <fd387a4e4efda1905e270d28986e4563dfee52d5.1746757630.git.nicolinc@nvidia.com>
 <20250514182600.GF382960@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514182600.GF382960@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fef8514-9d52-4e1f-de71-08dd931c946b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1YwI4wero+cSlo4TbMwOjCUrIkBM2k1TtDwzLSOKLR/fMRC5XOitgtr7TMBn?=
 =?us-ascii?Q?Gfr5FnNZW4v4hZl2VzKn4dltcSy8PiWWGDMyDERYVbjvjkeo+XAWVGyePEvz?=
 =?us-ascii?Q?rwpQZD2JUsdaSi2IDbGF0aeeWTDM42hpodpfXQF5PIYd1nRZJIZ4OyC2ixcU?=
 =?us-ascii?Q?pXM2PV1K5VTCHRu+cNELaz3OZuVjFDzzrpuHMZapZuU+ZsgRSbVu6pho0VP8?=
 =?us-ascii?Q?nMIwi4c1wwOygCneLBME1I4E0907q1aMtSVD2uKYysdHYIOx57Lg0NHXbfSw?=
 =?us-ascii?Q?/mNjb6bZXOzBCD7qrcQkzySul9j9M9yREFqc6My2KP04+TI+K+2+2earHoy6?=
 =?us-ascii?Q?pV4N8pFTEx2vYjR3oWtA58/5zRAjvMoJmvghAVjluKUBO4LG5VCdqxzH6O/G?=
 =?us-ascii?Q?W9sLM8H2fxbDx+DygtJSkDSfRMOIzaXpSN9/NA2pQKJaWWdgAcBWk449TFWT?=
 =?us-ascii?Q?nD8ZEQsipSeUjUN7MumB+s6ZU06gp6EjAKu/olwYlCLjiUOHKSLgfEnMOneu?=
 =?us-ascii?Q?H39qwGuCEsIzju4Mk9BdPh7y6Mc2CY5NP261w1vUdWuTK2qbeR983r/bKryn?=
 =?us-ascii?Q?9egYy7+BIpc+MZNaOYF8JDwulakY75hIUlxrFozF6yVbp7/buHkss1vfjQIk?=
 =?us-ascii?Q?olEjeZlPOz1QttVe+NxP4YR5ZbSaIL0VLrXTjFvd6BvWIC+oK/E7JWxYDP0T?=
 =?us-ascii?Q?vCE7lQlzaBG2ZXUFBWInLkQ5FHkjyAWWclSYhZMMRxwBUE71Fq/TOyuMqOKe?=
 =?us-ascii?Q?b78A2Rki4MawUAwNw1lY8gNEeUfkl82mP+gSdAOnm1XuWLQ6OjUXc1tmxH/+?=
 =?us-ascii?Q?u373jbExTWBVGen2DI9FzJghtnqsWtsrLcF6awPg8x+eHRS7TDyfj5TS4gWZ?=
 =?us-ascii?Q?vxxx6rRu55tPmiPPEU1nYX+VjQQZYhUADysdd18cNVCn1JQ3se05XidbEF14?=
 =?us-ascii?Q?MpYEZZ09GZnYiJVU4fj0n+wdDLyCEhCG0mPjyv7TWcB4fvXeoWzQXzwAmtfb?=
 =?us-ascii?Q?e+42ByurHtSCZEvE9gnfaIuMGv56reudttUN+QDIHGqUF9pQ7Y6sAjvLIxzb?=
 =?us-ascii?Q?AwyQRNElEomDoqlQ85XwVkfXqyGZWieqQf23ZuSgs0hl/HrsZ0KsyyrIoE+S?=
 =?us-ascii?Q?gDC1bNO3GgzdyVmzTyuppL/+8AM51gLSxNxza0yMYdVUeHATQSpaqRK9286R?=
 =?us-ascii?Q?65l8x4N2DnQF7L7dKgBOCjhPIia3YIuQw5r+QYGh0KrueCk1ajYSAOyOem4l?=
 =?us-ascii?Q?phsEwOdAoacmyVBVmAa3Wxwqb7XGWAwLope8W3VenypY6AEuroo7SSmUJmoO?=
 =?us-ascii?Q?AnfBN+8TuXrhLLhBRSZMNDbyfsbnMNpPkzM/LHnqrQmjhKybFzHW9k5Zp/Ce?=
 =?us-ascii?Q?nla+3lHcqrUkUg87aFFoHR+RIBKSGY5SYsV+FjnY9TZFrD6TJAFbsnxxPCvu?=
 =?us-ascii?Q?bM32spWHJP9BLqZGLyBHIpuIWSYSfWA+zU8R0APxg8LgpT/55rjkfahe0hzt?=
 =?us-ascii?Q?BJLU+fwrI6ggvhhrhIi2PuRG+tIaFTmcLTKn?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 19:21:51.2137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fef8514-9d52-4e1f-de71-08dd931c946b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981

On Wed, May 14, 2025 at 03:26:00PM -0300, Jason Gunthorpe wrote:
> On Thu, May 08, 2025 at 08:02:27PM -0700, Nicolin Chen wrote:
> > An IOMMU driver that allocated a vIOMMU may want to revert the allocation,
> > if it encounters an internal error after the allocation. So, there needs a
> > destroy helper for drivers to use. For instance:
> > 
> > static my_viommu_alloc()
> > {
> > 	...
> > 	my_viommu = iommufd_viommu_alloc(viomm, struct my_viommu, core);
> > 	...
> > 	ret = init_my_viommu();
> > 	if (ret) {
> > 		/* Need to destroy the my_viommu->core */
> > 		return ERR_PTR(ret);
> > 	}
> > 	return &my_viommu->core;
> > }
> > 
> > Move iommufd_object_abort() to the driver.c file and the public header, to
> > introduce common iommufd_struct_destroy() helper that will abort all kinds
> > of driver structures, not confined to iommufd_viommu but also the new ones
> > being added in the future.
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/iommufd/iommufd_private.h |  1 -
> >  include/linux/iommufd.h                 | 16 ++++++++++++++++
> >  drivers/iommu/iommufd/driver.c          | 14 ++++++++++++++
> >  drivers/iommu/iommufd/main.c            | 13 -------------
> >  4 files changed, 30 insertions(+), 14 deletions(-)
> 
> One idea that struck me when I was looking at this was to copy the
> technique from rdma.
> 
> When an object is allocated we keep track of it in the struct
> iommufd_ucmd.
> 
> Then when the command is over the core code either aborts or finalizes
> the objects in the iommufd_ucmd. This way you don't have to expose
> abort and related to drivers.

I see! Do you want this to apply to the all objects or just driver
allocated ones?

We would need a bigger preparatory series to roll out that to all
the allocators, and need to be careful at the existing abort() that
intertwines with other steps like an unlock().

Thanks
Nicolin

