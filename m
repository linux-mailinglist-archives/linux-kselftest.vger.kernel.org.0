Return-Path: <linux-kselftest+bounces-45593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8258C5A8AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 00:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E9D3A2931
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 23:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D54632860B;
	Thu, 13 Nov 2025 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gbxz8mt5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BBD32861D;
	Thu, 13 Nov 2025 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076392; cv=fail; b=lmkOB3VqTRVOM7RU+Zf5x0sFMzkRhTFziK2Pls2kIfa1l/3j5QZD9FRnWaRsejcIpo0L534VWyOfwuOt6Dt9YC0QXmg4uT0K56AtcVkFwJuqDUMieAvw8a8XjMvoYr+hb5U9hR3bCN36LMb9A/XtN3qvh+Wou/9hR2cRaM2/DOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076392; c=relaxed/simple;
	bh=0ALABqKux71lTrvXsaP8kKFDi5zvrLkC9m3lU8dOT2k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9IesGsuUvVSx3bxlROWWCZkODMkeXre9wWuuMHb3/6uhQ6zN2wc2CsaH9H3ttvURMaz5kxwhhvOZY3UmUMMpW5DySXl3gN8FM93uESznhst6IxVNxTSLsGO2LyvdWukaMkHrf6+MPRmlddEQ6kN0Yndqc5Oe9700CiT0wjDwo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gbxz8mt5; arc=fail smtp.client-ip=52.101.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avY5lCGxd9Ag6iPSu7zP80R9zHI9L/FiAfgn0BNRaWF+fbZ13BHCBRLN2AGLu7Zd0FMQ562ngIi8YbR4lEvaYdFKomL56rqYp5VJj6h/rTxd9zOZJs3Mj38GUJ/NKcM/oMBQArDR4yA5w6zyr6ub/+hRKZrmE2KiS1HjwDzOxOy0pYC5SQXac8GAGPF9f/BVeQIAKvBzUDspMNOSsFRPLVH+aN5pKVqv4EB+pFDglbTUVx4e27O85MkPPkwfuTSXlXTLyAiW9PqqMghgbo5EU+ywCK+JS6ayMpyKx8LXtdgtmpvGy7RQ25KZ8p2uFeSxLE73gmOsKSTHf6VsZirvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5yD3B6CM6REeG59S7jRZj/+5X2tCoLL9EFQIFi/kWs=;
 b=a0v8c2c6ZfRmZZm04NleY4QM3hptheb9SU+5nxn8LbeUPJe5z0CD1mGjT+GZC9iXYhuPQpalQ1o2oSNuAwTK2vOyYSJKe6H3NrsILROKCNerifUthz4q70NU2F7mx2DrcVpOujaj2i3Up5AfpHbzD/7v7vSlpZ17KfpL0pt18fS3p9idqcb6sFU+FsWJ8KgAepVH3s2dzoDLQJ4JEayZeeA8dMJsAYUTL5RXpVerJrZvaRtsgg+G/Ts08eCx4/JztLvD1UiGOsCQ15k+ZeggfAw9Vb97joj1xw00ye5Vb4TLOktbjiLnW7KNcvnU9eoeOu0BpM8dpi41SXaCehsjtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5yD3B6CM6REeG59S7jRZj/+5X2tCoLL9EFQIFi/kWs=;
 b=Gbxz8mt5p88j12DU6a9dzd6WLaknfLpBTJ9u6eIFmtGwYiFa0P0SgA1qdm5FtyqvBSU/FjF7/WfqfStv2kOwtxBTwwv0I3jc2rfPnk93AMVOSCCsh7h3FLRAN3YR7xEGUuJza4aum16ikiNLAxNZP2146Wem2VMXFVZXSX3RfEfFmLEFMnN2f5WJS7aq11nGAbLn/PYn7v/JyT4osRNmmna0xEiBRP8lZ7dLEMEPq73nTL9cLYzqIChvJdnS9WxTfIt2mHRYw/Hvx+K+tnNixaiJ+eIaNOFCcTm7Qw321YgcEwhbVnzmyJbEi5Aq2P+8iG/84huIRE4kFIUy2dwNqw==
Received: from DS7PR03CA0186.namprd03.prod.outlook.com (2603:10b6:5:3b6::11)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 23:26:26 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::94) by DS7PR03CA0186.outlook.office365.com
 (2603:10b6:5:3b6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 23:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 23:26:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 15:26:05 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 15:26:05 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 15:26:03 -0800
Date: Thu, 13 Nov 2025 15:26:02 -0800
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
Subject: Re: [PATCH 4/9] iommufd: Allow a DMABUF to be revoked
Message-ID: <aRZpCqQcSgqTWYvT@Asurada-Nvidia>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <4-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 73145002-edf2-409f-ebe0-08de230c1081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pPTHy2j+2qq1M0b0jC3lPucLtN+HcoQbwOqtFIHoOKuYGH5EenGSOaCz/rUp?=
 =?us-ascii?Q?dOZ5p5XFIHhbcph+8m4iTwpjNrB3LPTq00XeLgDjDwXwraWwfVhrXEM2paWZ?=
 =?us-ascii?Q?9BLPCH9V10s+u1K64LnAMNyEj9opIa0/tLjKmt3id6mqW8N6QMwtQJQcMZlB?=
 =?us-ascii?Q?d62TmSvPTgXKZqAgI1gxekG6Cgh5ffbIxm5bgoLX8i/mWtuZ/rcR6Z+5SvvK?=
 =?us-ascii?Q?ST8TKaODGwAkW2oX8KbQ0UL8p7UCsQ09YPrLlrFzx8BObheqKoSb4nOxrqj5?=
 =?us-ascii?Q?YtdNoylVDEDpVvW5g8rd77GX3xEIhnTuk3hF3mhENMSn5AlO75X240QgrNSd?=
 =?us-ascii?Q?sNi1ohfCQwjJXnH8ExF2T4SWcPw3/VlolXx5i4sGAIpwe7375mstBqnfnY/Q?=
 =?us-ascii?Q?csRnd8e4LBQtkXPYY6HnFhG/pcsjDL31bdDsQzdsbHi1dNlLBSYR+IifTvYx?=
 =?us-ascii?Q?/MJjX8kd919nVCVVUpWF9VhHqGuP5CeMu0t2HBEbyWuNCu6nnFRQVtXgp/1W?=
 =?us-ascii?Q?6k3n+cGjjAPfs/rXy6KcoXweefogQZrNY7FieeAcRD1ISUaKhkCncifHKShy?=
 =?us-ascii?Q?bzTZY82sjMl3SvXnbM8ij4AZP1JBaHjzykPWjWS/4/yHYl3mNG6mZXqYzKv7?=
 =?us-ascii?Q?UgFLSx45lsNHVtpX9AzTpiBm3jLuts3T592377GZtzxHuwMxYz8pUPiuRSTh?=
 =?us-ascii?Q?EwhuVwN2P3ZUdPA7NMLG63OWaBnyEFbaaJ+yo4Z50te5RQ+K99sFN2nO/cGW?=
 =?us-ascii?Q?EtD6zEbi+xj4D8Juvk2VdoMN8wHiXbYtUWCTQ8PB+7VM3929C7eWE69d2vws?=
 =?us-ascii?Q?2TQqc5ZQBVgbKSMwORsmDXU58AmvSg+2JmA76VhCKPnV3udDdCGEAIiK4r/b?=
 =?us-ascii?Q?ymfBapu4TNvL9adLpwu6Q4J3Q8sULUGgYMMMqanXlCQvPZagGAVFzf/sKC6H?=
 =?us-ascii?Q?1YlNcgU4jNyZ3s+XIudXalBT9luFxIsFmFWd4xXH02hhI3NG07g2BmOuNxHj?=
 =?us-ascii?Q?lg0A8jHNd3ctJoJLSNPqRXeeJOC4kKJ2p9i7QSjIRWOT+2sVmY/PV2t/U1Vf?=
 =?us-ascii?Q?iuFyK0DLGqASimQYfRwc7E4cAmcRpkSJMRCHmZi37PM72LnB+fIRTjl+4o9C?=
 =?us-ascii?Q?jUYOXSXE7vREzwwldFVknnqhQAr37P33M82QahY0FwAAhNFnjNexeleU4zoM?=
 =?us-ascii?Q?xfCskmdInNqmBdr+iVcHzAm4pHLAJPk0mSOc06euxmno1t4UFx9xMP2vSnmj?=
 =?us-ascii?Q?2lVSDOgZcdfAzraDgzKpuPOUKGOzaF2K/TOJy4VcgqAghQSNq1j/63yqsciX?=
 =?us-ascii?Q?g2q+4817GsCU2TxbQaEHKzWz8wf5FX984UtnSVYbCKauQurOcP+H7nhYQP9h?=
 =?us-ascii?Q?EJFgOdRRjmWxBvkMgqfn31bPqLUF51Hvd/UvrzQaNwuVDN0+hCdb4dn8J86u?=
 =?us-ascii?Q?FdzieiwEPUa8QtDMzvcFadp1AMTf39TpP1elk9xY4uexiz83SkzJfgasAddj?=
 =?us-ascii?Q?yyWLIF5l+qM58dMew2nxwJSObrEjKzgWp40kLv/TcT6anx9zrv0i82cS7Omc?=
 =?us-ascii?Q?MDiWJBOhlyJm5f0ELk4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 23:26:25.5417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73145002-edf2-409f-ebe0-08de230c1081
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104

On Fri, Nov 07, 2025 at 12:49:36PM -0400, Jason Gunthorpe wrote:
> When connected to VFIO, the only DMABUF exporter that is accepted, the
> move_notify callback will be made when VFIO wants to remove access to the
> MMIO. This is being called revoke.
> 
> Wire up revoke to go through all the iommu_domain's that have mapped the
> DMABUF and unmap them.
> 
> The locking here is unpleasant, since the existing locking scheme was
> designed to come from the iopt through the area to the pages we cannot use
> pages as starting point for the locking. There is no way to obtain the
> domains_rwsem before obtaining the pages mutex to reliably use the
> existing domains_itree.
> 
> Solve this problem by adding a new tracking structure just for DMABUF
> revoke. Record a linked list of areas and domains inside the pages
> mutex. Clean the entries on the list during revoke. The map/unmaps are now
> all done under a pages mutex while updating the tracking linked list so
> nothing can get out of sync. Only one lock is required for revoke
> processing.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

