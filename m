Return-Path: <linux-kselftest+bounces-45596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D49C5AA83
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 00:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181583BF013
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 23:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8F9328B50;
	Thu, 13 Nov 2025 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pe8FqAMF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010043.outbound.protection.outlook.com [40.93.198.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2609C2E6127;
	Thu, 13 Nov 2025 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763077208; cv=fail; b=q3a4oUdQRn19oihkMrX1HX7cZktfjseaR2zZzp1zLtTJUCe+9oktYrkFseV7zMK2nEn2y7qgGp1pw3iNzx0FCwYYhkgxElX90jgbbH0mwlXsgMRj9KDwh0xvgtqjvUexud7rxStXO8fzJFu33a3U0fzCwum7hh+68+7yM6hw0Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763077208; c=relaxed/simple;
	bh=s7QNuOn3+3l3QzV8aPOhoZmkIpdhHeTEkPisGex+L0Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jar8z7MPBfZh3+KabaZ0aLuipLk5xbUr+s3WjLBKKIUDBdx2wbwWJ3/bJd5rnE0VoYCEMKMLd8U3roE/Q9CvHIOupWV3NhW+4nOGuhmUR6Utc7j3F+tk3oUiLXLNHwiCKrhCcciUNCz6PaFzRUhVtcqOSOhPnLxRth0UupEsU8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pe8FqAMF; arc=fail smtp.client-ip=40.93.198.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNck+hVSfhPWQH2GGbcBwkIf1JXt+dZoCfCeXjxajucbrID2sFivwinxJNGMFsQXCA1zRjcoAb8Nj0fZjHYjSuitGLvdorX02q85wBbpWyhPrsX4sfDz+gqc+a43I4ZLcWcc/aPwZ0n1rMBQPDbkfSyTPnYevizgRc5b4sHKtCBiXXvjgunz/jVELTeVjb7Rfa78i6wVvg7U3IR7ux/aFyMZ/G9rjVrYLF30ttBAuqYSOh4inNUwLQptNkGrIUJHmzNm4Q2peWt1KxbjIIzwx29nLrJePUeDBE0n0g7HCmlRovmw174NgKHnFO3Llz/klmK5nfTEsjX9q1+CCXfcIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eO92hLuyDoP9P3o/yiwXYsE/DVzHsz1TagtVXhGQVVo=;
 b=PVQAKGZfV4sYXPSqLXVRddEcRQwciYB5KeskvvizdzhvPwmrEvsCA27fMqHJEUWzjNIhaoaZ95tH4UO4kPU+Lh+muPS8r/CbnmE1L8Z3ZYkROhN5o0J4FSiTdieGVCope72Y79hZxh614UQC9l0mF0j/t3+yMg0gsVyDnrVLkbUmL+DRbEjBrjMcqCgQWZxUv0GpH2EXqZz6sbn1BNtKs4tIEJAonTlK1Rld5e8wa3vHWXo77LBCx1sDNulT4O/p4tERA6paioyV/XglIOTn5iMj77QMtLcVFz2MxFlZoOyPjDsb5mdu5RuNRGlH/3KAa+rAEqYhPRNrvK0GPgRWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eO92hLuyDoP9P3o/yiwXYsE/DVzHsz1TagtVXhGQVVo=;
 b=Pe8FqAMFgaTO1YlVsi9wGXJK+xJO48v5wzuAwZhLqqcgA1hTkWDlTfmx+A3Hu1YS2tqbekt9C348VmITpLWbc1YjRUSP0UOShn7MZUeXfvcJ5HQKchGeeYeDHUvH6wOqvVD4UdK2th0uxFb+3IUSLLVzd7hghWBmimnK6ea2OUAXPDSDStXXRVcq6EE1RpcTcinAq+SMaX3/AZGeqrLkKRZkDA0gyyVp1G6ZOclvOvVKXDVdHH/X1eGvU4u+jiMo0p4136toAluh6mRFLNBm3BEAcGTKzns96iuNufasO2+Vv6EhNjnvRCGl29tvTYrALtn5ubYq+YaKdVaM+nIPuw==
Received: from SJ0PR13CA0227.namprd13.prod.outlook.com (2603:10b6:a03:2c1::22)
 by DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 23:40:03 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::7f) by SJ0PR13CA0227.outlook.office365.com
 (2603:10b6:a03:2c1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.6 via Frontend Transport; Thu,
 13 Nov 2025 23:40:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 23:40:02 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 15:39:49 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 15:39:49 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 15:39:47 -0800
Date: Thu, 13 Nov 2025 15:39:46 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Alex Williamson <alex@shazbot.org>, Christian =?iso-8859-1?Q?K=F6nig?=
	<christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>,
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, <kvm@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-kselftest@vger.kernel.org>,
	<linux-media@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Shuah
 Khan" <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Will Deacon
	<will@kernel.org>, Krishnakant Jaju <kjaju@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Matt Ochs <mochs@nvidia.com>, <patches@lists.linux.dev>,
	Simona Vetter <simona.vetter@ffwll.ch>, Vivek Kasireddy
	<vivek.kasireddy@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 6/9] iommufd: Have pfn_reader process DMABUF iopt_pages
Message-ID: <aRZsQvvEfAD2vpcW@Asurada-Nvidia>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <6-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DM4PR12MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 325659a1-81fc-4829-8f4f-08de230df785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lMRhnaA5Bl9dpfQwFiGQ6C++A1RoVxuwl22LkxrAGaDmvB6Bfsyvm4faqaTC?=
 =?us-ascii?Q?fKNHoiE0kcRMQY94fsap8/BdUASQ7ZNYSy0YeIsCSCvswhKZbJIj/7CksTiy?=
 =?us-ascii?Q?iU42caMvFFtvIyLMgciHej8TgPV10lPAB9R0j4X/Y9WI1vgGULIjerXA8xgn?=
 =?us-ascii?Q?etwbKgzrFk3MJwxVVdehr2PcUYBKLgTBVEmd9ya4nYCOD/quIwyoEez8+ImL?=
 =?us-ascii?Q?0kWlUHfmKEMyGJ5Ksfz4rPcvEu48l+fzi+wZB3LxA7SnC7ohyRRHJTj3t+VK?=
 =?us-ascii?Q?kTTOCNViJD+xSh6YgDcTePgjAOTxu+TyRWfyRYf1i4bivpp7emUAd+o3j7pl?=
 =?us-ascii?Q?sYMdh4LwjWGDxYRx7fIdEswdrGrGAVHV57WN2y7mKpkSx1HLimeNpXSZ76dB?=
 =?us-ascii?Q?m1Ui41dOtVdyE6QPexvNlHpvBZMDVKPXDcS3CJ/ajMEFk4CVeBKBvEz6CXbR?=
 =?us-ascii?Q?24/rEpEOm7U+OeEn9Eh3I9BCgi/KGFoYBZYn1Bl5YWl03x1nsfNFdDeObPk5?=
 =?us-ascii?Q?QaLKU9EnWzA1YzedpzYSlHKhOD9YUcEoIu9bkAUqmHQNvEIvW6I85S04odbV?=
 =?us-ascii?Q?T5KwLwAaxworPHp0u8JHEE8k+H9gBBvPqbl7RBabZ7TM+Qf5e0Jsrsg3lQzo?=
 =?us-ascii?Q?Zo/EyKe7zRoT+JGoACnvj3MAMsY67Dr1um77DZxrvFUdyQjHFVpVP8g5nQVy?=
 =?us-ascii?Q?peaNIK3FwLIBI7WwhGdXw6RnhGLuJ61SH3P0gaprne5KpwHLsdgqTv0EJHBf?=
 =?us-ascii?Q?ImAClyFtfPHxc+uka03zxPZ2GK2NZn3MFqYXmfgOAwD907Q/TGAe3H3c8PIq?=
 =?us-ascii?Q?QM8DjfK47LQzvL6N06mL3cSnSwbaSuNebloxllGZZdG6whW/paFfFc4ZCLd5?=
 =?us-ascii?Q?iBfFK8Fcrm18WcxntE2NAUNyPj3YhCZ/zPjNyjvs7rvxZvmA2J51leYsfCYc?=
 =?us-ascii?Q?z/6VGwd1glIHQvBTkoiO3mYLImjA8MnltffrQA1ByzbiId+L7I2ewaTwXPaX?=
 =?us-ascii?Q?GPbVJvz+0pilidyHfwMwaWkwCvT0ntkOhoeZ9F7XtcEselv2G+S6EZ8NuFRS?=
 =?us-ascii?Q?Z1D9s6j05/F2YusUmxHStsvlnHri5EdLT/974J+yRKd4ULDvdI3ePAG4gKYz?=
 =?us-ascii?Q?JH1MaQnACskA3Whi4IDZDWh+zxe6IwP7os7wFPTMbCUZHYJy8jSlmO/9os2K?=
 =?us-ascii?Q?DB6KX440y1klR0QjxwyIhIoCBKH64mAAdhrH7IfnrwpLyHuKUskgi68fGkvo?=
 =?us-ascii?Q?9p88fTKckZmA32kTIGrECCy+XEFDAU+53QBH52zKVtzdDuFU1BQXSjNdgPAO?=
 =?us-ascii?Q?5IGogt0mdWjcJ2xHbXVQ2Flg040aU27P0I76z8/VIwCu+fQvEy6uEzddw25X?=
 =?us-ascii?Q?ZmMEfaOQm4lWkmHn8PGDm5BiyQ/d7FWbdr/1HVmfSMpL99brmR8/VePRNEpH?=
 =?us-ascii?Q?gswr2CWVg3Mjoquk+cxHXI4AMupUZIs/f/YiaMzo0mpg9XRMErT1W/Vr5/5w?=
 =?us-ascii?Q?KUOthJ/HuEDbbj3zcmL52iI0QdGWAqEB/E5oHBVU1cd/ZVuAaNmEU8zA4805?=
 =?us-ascii?Q?TRB/CUEfg23A1OfBEvs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 23:40:02.7112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 325659a1-81fc-4829-8f4f-08de230df785
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6087

On Fri, Nov 07, 2025 at 12:49:38PM -0400, Jason Gunthorpe wrote:
> Make another sub implementation of pfn_reader for DMABUF. This version
> will fill the batch using the struct phys_vec recorded during the
> attachment.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> @@ -1687,6 +1737,12 @@ static void __iopt_area_unfill_domain(struct iopt_area *area,
>  
>  	lockdep_assert_held(&pages->mutex);
>  
> +	if (iopt_is_dmabuf(pages)) {
> +		iopt_area_unmap_domain_range(area, domain, start_index,
> +					     last_index);
> +		return;
> +	}

Should it be:
	if (iopt_is_dmabuf(pages) && !iopt_dmabuf_revoked(pages)) {
?

Nicolin

