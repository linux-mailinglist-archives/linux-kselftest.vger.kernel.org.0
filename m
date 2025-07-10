Return-Path: <linux-kselftest+bounces-36898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EF5AFF728
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 04:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB4D562035
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 02:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E3627FD70;
	Thu, 10 Jul 2025 02:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MrDvXrnt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC227FB28;
	Thu, 10 Jul 2025 02:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116271; cv=fail; b=VgOD9M2qZv0YuvvvFFE3+AOaiQbzi0MJZ0xxZfi4lz6ytKHkq0JJlqvR/IiUnETHTJ3TL4dHB4hVqSCNFd620AQ3zT4hqAlNg8+rIMoi5wZrcL/fiR55yLY4gZYO2pxmVTKY+PXnV7l8iTP8uRhvsGat+fKmvh0+YE5hT8gRMuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116271; c=relaxed/simple;
	bh=UsUYpoj2XyOPi3GquuWQuSROt96LKd2e34cYxTb4LHQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D//wsW5T4IHv5INRVCCEUwzvdSvbMhyzFmEzexJGBrPmlGZivqma9E7ipji2EyWfRmZNcVHSZ9iWDFeAZwfNBH+cg5ilhadw5ksj5yS4fLowIyonBYbCuEXm4Kg8mYCjXRT7w7De2nxpLK7KGHY9i/LYT+LY4tR/AfBoMZla224=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MrDvXrnt; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKS32HAFmtqm4vCAbl/cplf5gAyqYVmcX4Gugx/pE7v3szeJSbQNw7cEc82FlBVYV8sdxMhnrYamugdKDZUIfN6m9pEzdrN42ALIgv5FFNN9XGQx2INEar8VKDvMX+czVfqY4thIRV9/NAmEuvB9YwNt0l0sVznMd3OllOG8/P+W4iswW55LsMEXUAcrH+DbfKrinfl0h/4FloQxuTabxQRljL46LAyCDWZWnFrGsnOFFvJ0kr2pXTb3dDzawygAfqy+/+JILSfvVghClIhSi8MO0p53tz+2QD1v1axkOKR3IsmZBiuG15gtf2zCmdW4QBdgNQndEbnDBOO+OT4BTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAnjUy1E6CvEOxfWvkVSiKMqa2xpHS2Nnyz5+PInGA0=;
 b=bc59YPZ44Yv3hbHkC4DI2YvYx/aaaGxb+eOg57gEbhlBBRiogbUWm6e1s+c5Qk/jYp6aLtBHnyGS2AgZY2u2Af7MFqJPG9UDDXKSGmBlxU13ZNnib9kkdEndWrkyXlEP5wRb1lcsah5agWUWLikRVqvZcf9oxsZ9XvyFlr3eTSrQgcU9EMFeTcMhZiVSQ8eU2XIsz8/a2zTS9rj/hC1XF7B7yW1DVdBKlm6B80ciLIm0UJdtWMiLYbZRqyJAJP4WwxJ8ytyOzBRwaShUXMq0H6jg8dCoV+rJ2435I9HtkaNaUfxXXBvsEqjURyxSTJubcimJMTSAhwLCl37GiEnNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAnjUy1E6CvEOxfWvkVSiKMqa2xpHS2Nnyz5+PInGA0=;
 b=MrDvXrntXn5ng9VLIhG56L92MIfDnPDL+XuRuY7/eUNE+L9WkhLaDGrR4LiFBJQIiUfjkdJoDvLk/GD1vASmqhVG6LjtZ6VJqu84knd5wLG85tzV+FcQevJ28/Titzgu+j/fzVvOjh8GTOBevbHKjlLj39qsWGYWqesGPqagMLh8LA9WZwgj8pbvSp/GSNOFaYlEiIs93IdiA4UZ4dWmlKeSL1Eaj06yrdmK2vsfOk5kWniVgJgEZFpSNr8AHwJfZJTElejLk4NNHLEHPIAYtADhpcatUtVOmasozjVQeHqUWoBjeMgVDqliCQLbhT3yua2e9E4U566Djig0u77+yg==
Received: from PH8PR21CA0004.namprd21.prod.outlook.com (2603:10b6:510:2ce::11)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 02:57:45 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::12) by PH8PR21CA0004.outlook.office365.com
 (2603:10b6:510:2ce::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.5 via Frontend Transport; Thu,
 10 Jul 2025 02:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 02:57:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 19:57:37 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Jul 2025 19:57:37 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 19:57:36 -0700
Date: Wed, 9 Jul 2025 19:57:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v8 04/29] iommu: Use enum iommu_hw_info_type for type in
 hw_info op
Message-ID: <aG8sHjkIwWtum85Q@Asurada-Nvidia>
References: <cover.1751677708.git.nicolinc@nvidia.com>
 <64a4c22755d828a80a80d30f6903f4003b62ba5c.1751677708.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64a4c22755d828a80a80d30f6903f4003b62ba5c.1751677708.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ee4213-c1dc-4c86-088c-08ddbf5d8b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Dnhxl7GMCpE/sDlTGZDIlTVXmoYkvyCE5FOZV3fCaun9g9r9QLJFaku4zIj?=
 =?us-ascii?Q?1jFuEFFtjT34mtmz498s0hSOBT4w6Gp45SLP/dsKE1VmOdc6Gk8F04dHK7Ge?=
 =?us-ascii?Q?cZOtQ4lV+IIZYVsRf1zBj/P0mXl8tKNI8qtDfSnpBEsR4TJqHOna9JNni3Dy?=
 =?us-ascii?Q?ItKCe+J72CC/FqENAiGc3jg3yrquJ1OHjv4AggRrSW61RwGCeFm9weiH2SiN?=
 =?us-ascii?Q?qeif4AQVPPfDI38l49/X5LfVSNVtHFXz6hRlZX+kKkMsTDo+Dd7hwu95cEII?=
 =?us-ascii?Q?csoWr1lS7jPZNjFM97oVUXIiq1WjBwQe+13B8RNpt/5FXQRNZKqG8EG1FoPE?=
 =?us-ascii?Q?7IsPRYV8pGgshJebcYRegFKKnFtLApGibxoWT+VIW90HKQZOrTPrwrFFIl4S?=
 =?us-ascii?Q?3SuexGqOZ3fLGdpr4roZWv8XminSU52WDUWQYfYqaPdLgaWYn+dwcoFQone6?=
 =?us-ascii?Q?VlQgFy90hplApmHriKDprSOacb4gXN+XFKx21QAP0dzjpO374jlRwC9HC1ay?=
 =?us-ascii?Q?QzFn1NhQQ7/PHYzJ5eXI63anNI44qrn40Yr+8Pgk2W2HH2jJCSR1y/p7WBx4?=
 =?us-ascii?Q?MpXwWinl4TCOc462+uIDs1FKIevAVTbDd6KOOkVpMrSngo2Nw6Eo41WAUiAf?=
 =?us-ascii?Q?rI6yiSbftL1ce7r6cBsvbg+jyBkBPIw9F+nrzgxS7bQDv7JB0qoXrX6qmQH6?=
 =?us-ascii?Q?P1Pmm7h+0rM9KS0JNqdZSacqC2jPNUF5xR95JFf3tnZmg5/GPp+Li8sTEUJd?=
 =?us-ascii?Q?gdNSwidAsjL9aQDQd8DPGs+qcFjix5+0BTpTLiwJXNCiuAEGS/hQ3jJsKUGO?=
 =?us-ascii?Q?eGbUWZZrQlNZkFN5fpu5diai9u4DhCUy/OiCuM4Fq+q9atXjyinA/RsAhimG?=
 =?us-ascii?Q?651TeMPN+cdIETNlkz19h1RqAmq59dsE1RNQRJhhMpnGNdU24/AlxAvHC0rf?=
 =?us-ascii?Q?oNoeq9S68Ad+Bc5bM0/vKV93sw31qPYqHc14XwnOu2dhx3DJ0+296Qo9l+9F?=
 =?us-ascii?Q?mJW64jVPHtCJ1G5vPYz8dg/TfUhLGLjUz0ImH3tvZoO8wZnPIeeUXfDhDzbR?=
 =?us-ascii?Q?X+ifGSUNm7EGaBnGgMWws1mP3gkfzq1MTMkrqqr6eu6uXBSoaViWr5ucWJOj?=
 =?us-ascii?Q?3jl19veE7L9AUAjfljhFK6v7luNI1q46eHp5bqdFKTJeEJfXoRx7Jld8RpF9?=
 =?us-ascii?Q?+eiwiv6o/n8Rm7wfeEJkt2TN2bx7AMq6Stod0IVGu5k5mwfh6imK1jfne7hc?=
 =?us-ascii?Q?c8lwNIrqNnIT+e/CYBcp+GQJQnDMwEFOWqMRFFDmkdFqQTpYl13HowIwPYQG?=
 =?us-ascii?Q?w9peZF9ndWXgCGWn1LygM9NW596sytZjCrD50K0i4/+fhhWka50tfsuGuLNQ?=
 =?us-ascii?Q?k5uhZC0VW1igypH+hxB8oeAcKLrwAQByDIKHUJNF8x+Qh/PIH0mQwyNkvfv0?=
 =?us-ascii?Q?ucKFomBfEvF9o+ztp/I7QUCl1yALcQIkmJrQMC7q3ETajeI83A09E/kJdV/K?=
 =?us-ascii?Q?nv+LIr0/Ex8GqYDgw3TVJcpBmBsiKidciyDc?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 02:57:44.6616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ee4213-c1dc-4c86-088c-08ddbf5d8b60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834

On Fri, Jul 04, 2025 at 06:13:20PM -0700, Nicolin Chen wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 9f59c95a254c..69bbe39e28de 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -7,7 +7,8 @@
>  
>  #include "arm-smmu-v3.h"
>  
> -void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
> +void *arm_smmu_hw_info(struct device *dev, u32 *length,
> +		       enum iommu_hw_info_type *type)

I found that this needed to update the header as well.

Fixing in v9..

Thanks
Nicolin

