Return-Path: <linux-kselftest+bounces-45598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C993EC5AB51
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 01:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD3484E2C3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 00:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A8E1E505;
	Fri, 14 Nov 2025 00:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VlNjfRHX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16958B661;
	Fri, 14 Nov 2025 00:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763078732; cv=fail; b=VWRbHhK2uzERubtCbtajbHglWqXrs5Kr+wREm2ip8oDUKiknwA1ELWI+t68S4i80F5/g8Vi5q7yOgqqUxBojY6DnjaktL7RsuSmj/zOtVRYw8X+HTtS6t+MJM6CGN3KzOtBw71sJ1WwkiXYro4+4PrWcLaSQ9MMJX+91IvBlCv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763078732; c=relaxed/simple;
	bh=YuclyO8WJ2nR9OzM8MvdAd477kFWuITrnztsKeAttGA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXgRHMBgYTHjRme5nfTG+WE/6WluLyrVsHLRLXNi1ypOe5UgSg14aHp6LBU6jTGtoWMdX9pQmJPCuI30DVcnVHsJE9zY9Wpg/KvwoB4xQXRF6ISFv9J3p8huyzp5fjbUQWU19YWZgGi2egNiS6yeVfrDTI0CBHGtsSJsGQHJeWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VlNjfRHX; arc=fail smtp.client-ip=52.101.43.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrK/DpYsnkwiA6JRszCGWApt32Kt4tVGHesyjzGH63nLi56qhuY1zYfczCLOOEyA4O8V9vGHGFEiiHSh3q/c5QzZvLwm3PoXp94HxtgkP5ti8HFTPwAk6GZj1Asswyb8ygmzYuTxjPFve0Xnl+OiJEvYCHPr4qK9j7cGNJdfPiKQ/kF5YoC42O2Y6u4BfYseBNc/YO6vXoOrBMW/3N1hCQv/VwLgJyMEqvmZCR6GOh/Zgp7WcEspgeRNKnhoS6HAKpwZY0U4eEqwwbbdZeHtMnA3O+J5rm2U7yriuSfrEhQP+VGhFDYztknLdnlAwOcvLQ4XW8uwVJ2nygf2BOSn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xft5WB/dm/CZ5/r1VwDLpvhLZXvhyLKsZK91gUJcaNU=;
 b=G3g7y8UaIVMf+eSYpu6iJlwv/91LWkCrsqDnm/XgZY3S87vqBRZ1ilD3BNUPtHyRMqM9zsPNXLpy4v2URvoXhKQu0mHulWmygpI3XGCOBdFJ6ryl+L5v40ae0DA/nFW53rL7cyzlTivVwn6E3Y+UZazDMD0TWdhTTK1xEgsgF6zokSe74ELe8+RQs74NXG2YuK2QIdNubrOudl8JNWQ3esVGsFh0Hztzql+ACGIgW12ftKZquuvrZyDha8BYxXiNwvq50jlISkwVx+33cl/4y2OE+A6iACmipo7nZCbgmfyJa8joMTIMOpQN1v9+CtubQ0HcY10awXM3r4upHjweGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xft5WB/dm/CZ5/r1VwDLpvhLZXvhyLKsZK91gUJcaNU=;
 b=VlNjfRHXvI0WsKCJKgoy0n/IogMun1fBO3t1mlYE8jjg4u1nIMWpWMCdlZNqiOBfJgPaABIZ2HGqFhMYb/cD5qx21ZMBPWyDtGK8tNGKeIaXqkKktz8vugkTWvivb/fygOLEoWGzCk6NrcZ7SHy4lCZ//LIUIaIW54MBmNj3UvhLK36lh5bgX5nCpAQ5Lpjerm2xnQMXz3WJJnuoqbwXtc1yLzN3Xu6GhEnV9aWsWnqmbxl301mvBgeQKjFaGLZNSIzsHAAOyn6GMwPrcWI6kIqYgK/DIOyLVecKaGi0CXqvG+KWorOmyXHDIxLnRE2YUjCqculrrPnVW8wuuc+wyA==
Received: from DS7PR03CA0324.namprd03.prod.outlook.com (2603:10b6:8:2b::24) by
 PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 00:05:26 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::fb) by DS7PR03CA0324.outlook.office365.com
 (2603:10b6:8:2b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Fri,
 14 Nov 2025 00:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:05:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 16:05:11 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Nov 2025 16:05:11 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 16:05:10 -0800
Date: Thu, 13 Nov 2025 16:05:09 -0800
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
Subject: Re: [PATCH 8/9] iommufd: Accept a DMABUF through IOMMU_IOAS_MAP_FILE
Message-ID: <aRZyNaLxrwSKKMXG@Asurada-Nvidia>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <8-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 4675b071-4623-4d6c-c575-08de231182ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LtozZYBcn3bPMjfcX8IKraT0qndzO4vzEhVvrk8zlYM84p+Qc7MVoIAzpGDZ?=
 =?us-ascii?Q?0ewSXOTwuqUS25flq5lPJDqMiJkbb1E0+1cS/gOdExd9Jg6t9EBbpA662jpq?=
 =?us-ascii?Q?aZXzYV0dOyv5+XAp6WVxLUqUBzdfHwqipOB3x+NEluVTEDhw10ObmlC2b1xx?=
 =?us-ascii?Q?8pOG+HZOLumB+R5avSolmnLL+9gvpNeXtEF1nKMOnI/CZNSIq22E2Dsyf02t?=
 =?us-ascii?Q?WiTEzsYNM3PvO0vsJt0+OjaZARGev0mxxMxm3SLAN2bt2ZkojwqdzZEBnJf5?=
 =?us-ascii?Q?9zmbvR2b3ksDvib/OObDPFHVd/YLSkfRtCuONVD1QiYXT3JN6Krnelf25UA/?=
 =?us-ascii?Q?4PM6l9AlJmRkhoPIC0SrwERnBoROIOE7WAamXcl5vRoHfpZiS7+pdHbS5hmY?=
 =?us-ascii?Q?prEJ5YvD5aMw4MGSXIt59fzyC87Kk7UGP58XqK3IbcMD4irvYf6xEjKgI4Uv?=
 =?us-ascii?Q?v/5Z05gJRCKrsopjDUqmme2Rk/TwuHckulnjzLXczbIRtnXDClyckQGRSbqr?=
 =?us-ascii?Q?ahVyHgtsejNawJyBastVHiv/PkOJKLYPaeQRlOAxIzPB64XyYYn1/Nl5W4oa?=
 =?us-ascii?Q?Yf7begaPUlEYOTfDgsweXIKh3AsS43wkW4NEQjfU6aet6lS7bxX2fPg3sAxs?=
 =?us-ascii?Q?mJajR4KqBnqTypJLXJiuH51MIC+hLXLJD61T+kLAIV3YBKLqH5dcbeitKn9a?=
 =?us-ascii?Q?RubnNE8Mkicc3G9F9NozvukZblq5kXtLhAGJZSJxm0z6lZJS9/5zASf+TADu?=
 =?us-ascii?Q?7TxnrbgsGfRgku9yFnwQcgHG/nKQY+X8KTO98ehrzYMEhbxjS4Dho20C47tb?=
 =?us-ascii?Q?H4PUPXdsqqSGDGMou4NSnWm7bJkyQpzHNrvhOp6vGqS6nw8wHS5wV9/d4ePa?=
 =?us-ascii?Q?XoVAtZ34mn3dyapco/10iAyh8A1pi285Nx7twHj/cqx7F5LlGyhB6BWBTCUG?=
 =?us-ascii?Q?h/2mEa1YChBdRAsxC/TmSn6AKv96dw5AbvDMj72K7ePWNyioe3TQ+Rk7+XWj?=
 =?us-ascii?Q?uapCoRzdlMVa1JWo0W1gxyd7eZCwtUPnKopFZJwHWIqzvSu4r7YGKq5EdTa4?=
 =?us-ascii?Q?Ji2Prhrk/oBkF8VB8jzb6iXsRshEjf7deQmH6FcbKWr90GzbwdPX95kH4q2B?=
 =?us-ascii?Q?ZocXZXfoJiiWVkk1ppgMkqmrddoCM9yZWK0i6RD4p5Y3neG0f4jWhF+4aGDK?=
 =?us-ascii?Q?VLqewZvlRp6rDq8SnKMb1RpePM8P0/zSp17zhulz8TmMzsrF3fmH2Nj15NP2?=
 =?us-ascii?Q?2d0mMmkcigEece/c7uvvmnJjq3gDtIwH9HrG3zJ0HftbhKhqKmZRNpYyHhQQ?=
 =?us-ascii?Q?/VXERQlifT5daCQuBTma0NEnLG2KfDTIvNI0ZHRBJGZa04xq4yCl4TdgamsD?=
 =?us-ascii?Q?FFfVkVQvHGComrN8cqGzdlVrySz5u0cNt51Th3QSokdd7atA7ApinrgO5KMx?=
 =?us-ascii?Q?LzW7/hFZqZbwGJx0CQrf4baGNyt46+D2SVnZjSOtn+ABn+oJlXcSzsqCZgDv?=
 =?us-ascii?Q?OoajfcrPu7vZPCDtXQVs7aRxNdi42DmYxS/CUYtBNCvF0koX1LVJrsE1oqMy?=
 =?us-ascii?Q?XDunSgf4aP1S/Y+0m28=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:05:24.7721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4675b071-4623-4d6c-c575-08de231182ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794

On Fri, Nov 07, 2025 at 12:49:40PM -0400, Jason Gunthorpe wrote:
> Finally call iopt_alloc_dmabuf_pages() if the user passed in a DMABUF
> through IOMMU_IOAS_MAP_FILE. This makes the feature visible to userspace.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With a nit:

> -struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
> +struct iopt_pages *iopt_alloc_file_pages(struct file *file,
> +					 unsigned long start_byte,
> +					 unsigned long start,
>  					 unsigned long length, bool writable);

Passing in start_byte looks like a cleanup to me, aligning with
what iopt_map_common() has.

Since we are doing this cleanup, maybe we could follow the same
sequence: xxx, start, length, start_byte, writable?

Thanks
Nicolin

