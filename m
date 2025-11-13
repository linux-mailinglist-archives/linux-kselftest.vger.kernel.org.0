Return-Path: <linux-kselftest+bounces-45594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA17C5A8C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 00:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 7F7AB20843
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 23:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EF6329377;
	Thu, 13 Nov 2025 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CtkifwCj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC262328B55;
	Thu, 13 Nov 2025 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076544; cv=fail; b=MDsCvEWK3Nn+QDsEeJ217xOygM/VifqWGp4LSURJ38XvWFYFnze6c+XPgR1Uywj9TExqNSq1/f0O8UWOo/wg8IxpfQgnYCFl5oIfXxdbYdPIVJhB8qHTCgmBQBQN4tX9rdYd2PnuKFG484MvLDgMaS0e8L7ewfgA4VpgGC2J/p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076544; c=relaxed/simple;
	bh=3xCt7NBw5VJCjX8U8s3WQndogEyhFMbeUhivJEweqvQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIgVwaO9//5DbI//R4KZuWgpiM40eff41ac/Db5JcFrzxjQO/1h2i5kb/fu/pA8RmMvPv1TqBsvDp82A9xUYVHITTULXQtlgusg4bUPf97iWN5P8ETnDbQfR24w1z9TqCYkLw2Zg51mfQ6X8bK8oxNwyOm6S85wJ5tY4BD6gHIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CtkifwCj; arc=fail smtp.client-ip=52.101.85.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3FsTNDy1CckLk2d62tMZp8PacgqqlTIwHk7MFi+qQBS9JLwZlZNxXTUcFHmxmYTHeJZAz0k/4pgbiN1Q4wDdVt6uxf88jkGUlzOXGS0TlcXV6opikaqIVNe9oniXkGtn4xiLoUuMEG/641B/46MJ0Q6wM7GkXK6QFua8mBKZnPZOhLG7uQbkb8iUgE2may6ZildP8aDTbVSY9nwFNPsihGe1IP7XGIhQwQDhjDyGoMfYlfhZ4SLzf4Ht57AUUIkaB4LnYQv2nUGrjxJCnxOyRFvEoThZS3YrOUER+ZRpDYipt8HpuZhyYdOUT4w4dVw6YKdbyvU1Rs8yKva2CB+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WmMZWL8CXvh2Bb/VvJrY0DIjLzzelgHlIEeavOKrhw=;
 b=WVXI1Kqv/g5Gy0k9mrO7RNv9vGbbNZaV7X/+fgV+G5+vrVkCc5hjbdGiUQrxr8AtdzHgeExkh3VP3HjCtVYjwdYGIAXQvWzQJrBUMDRpInYEyDZTnxEtl2fdAfAOKWyO9slvTyQrzbKyE9Vzg6Z5Pq5+b2OwHwR7CPYg04OxV/WEPcD+slKkALxkzJ5JSPS9JAd/+n4f/KtXvNd2Ex9C4UIRfIaXL13hBe2ie4/lyl3hXpBjASk7WJ1NDL3qHRcNMgfsR4rPIGJjcObMEYUYnNSw8lucsCaK3Jz4AVUn5gqF3FmQzaO+xXFndxH7R37DphRVZDz3UTtO5Pe/kmPdkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WmMZWL8CXvh2Bb/VvJrY0DIjLzzelgHlIEeavOKrhw=;
 b=CtkifwCjBv+YEjyXJoniq6JQE1dqEf8NF0AY1mvstGI6gVXg+2mim7AWosqd0F+GcfMD1NIsYl3tQyNDIUAXhOZEwOe0mkippynbQfZa6yCoEh48VWtqhIg7TUrUg2OjDJyQ1O2WIi3dDHlMnXgngX8ToPLfYROUy1sk2Rx0V+M+5Be+2jios+FYP8NmjzKVOwQpNnxikUg2QYttLzzK4YL/1HwGYs3edH85p+CAbPFngTV9QVb6cRnaCBzryHgjyRN5rGlnD54uSVRolSWY+5ks/WzZm1WTy2zaGFhoLeAmjGmnDi8wwB0x7wTzXWODPRDdfMKdhwNZFUo/inAnEA==
Received: from PH8P221CA0063.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::15)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 23:28:59 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:349:cafe::97) by PH8P221CA0063.outlook.office365.com
 (2603:10b6:510:349::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 23:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 23:28:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 15:28:45 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 15:28:44 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 15:28:43 -0800
Date: Thu, 13 Nov 2025 15:28:41 -0800
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
Subject: Re: [PATCH 5/9] iommufd: Allow MMIO pages in a batch
Message-ID: <aRZpqbBHUYKNwRJT@Asurada-Nvidia>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <5-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: d25a23e7-4b13-41df-fc73-08de230c6b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Xj7sPplIyhjLSsmg/znM4V43WSyaJilkD5r84qZG9RFh66PqWLTU2wQNhJt?=
 =?us-ascii?Q?JE/I8Zj/GWRpHn2Eml9TF/mwUlfp49jab/Uh39/pT9bwQTe/DJlT6XHuGQdY?=
 =?us-ascii?Q?59rgSUTFCTT0G6bWKKo1NW6upW61p3o0ss9bSRr6TArtUPx1pHmy23GI/wkq?=
 =?us-ascii?Q?0CqvUPZziraKAhVW8/gK3Hsr15OBvWkxQD/vYYhvefngVdF7njRVTUJNsMmY?=
 =?us-ascii?Q?OR8QuU04LFiyGGEcE4Ub85vWxr4lddj3KAcBClYoRJ5N00ITfAK2ncvpMu/6?=
 =?us-ascii?Q?03pGmTDAm1rP4Zw7l76r/UBOBkVS+2DCFjwNDk1yGPXbGVKjNYSj8O7+67um?=
 =?us-ascii?Q?QvgVsrmmRImWsW/l1Bc06TF+CCKifplMF2BavC+D1LkvcG5FLQOhwN6hViqL?=
 =?us-ascii?Q?hChokEO8Gxg/2jXYQiPkruG2jYXtIdZcuM+na0WBDIDNGDGyoEXDWp3itV1B?=
 =?us-ascii?Q?J7nJgHmSTGkxTzFguhRiHDQvKpTUEL9+62DkE1m+TLI/MkJV/YZTrKURjVwx?=
 =?us-ascii?Q?gRY1NjpRRzAIx9i+zZmFxgmKAMS+sWiEibwTM+3evrMDPWt2gZIPrPZgM2II?=
 =?us-ascii?Q?9VYDu/R8JQq0ahUjuS2FPdAn7GD2AJCohUab35nHV4Qo3rBVzUx/tJCJsB1m?=
 =?us-ascii?Q?SGXm0zGsF7fIzSQc+KMbMqg2XWxt4hgI0ONUr9xIgA5gVYcBVp/0+X1C3lf2?=
 =?us-ascii?Q?ANrFIDQ3qbl0ln6123fQNwFVzjAKT2qqawrFmxk5Dal40CG687JuX4hq+mUQ?=
 =?us-ascii?Q?fz2gpQBrvQtJNh5zVIKYvCXEbTYvLVvyDJuxH/84/SpMlKJx5GY322UqpReS?=
 =?us-ascii?Q?pg4WU2Ie4jtZityaHs2Aeau5MeoNt+Sll8Ip/eaej5ZMTx97zdDA3Oz0BXjZ?=
 =?us-ascii?Q?oE5cd+pNcsgG5/54eaaef1u6Q7l00bNuPeA6aArzy2CIQxHzx10gzHDTJHM/?=
 =?us-ascii?Q?w+NbkTqhCLnueCVbhsrgT46fLEElOhdPESxUVP8FHfBZdJAKs3B3vIBGK6EL?=
 =?us-ascii?Q?5blFsEGl+xnJzQiCMBkcLqtitE2VX96EkiJpjedG2IYy9p0R/7tTpPthyV+n?=
 =?us-ascii?Q?vRCpw2el/cXJ1cGd/4tKm2gbGFKLGXVPTngioUpF5OWbgd/0AboK/0+Lbd45?=
 =?us-ascii?Q?tf6cSOATWPDSyYxstGXjoiyNO6dxA+P0zt+5BtOF11UI8n8n4APSo9rZu3E9?=
 =?us-ascii?Q?if01QK/KZcOVySNesXZaZ80W4dBFQ/aXcljIwvwV1p8LrH97TpVP2RusyOBT?=
 =?us-ascii?Q?25615mR1B/idJLywnsWFhZsD4fYwK1fQHfcnN972dNwdshaHADcaH8d2y6/V?=
 =?us-ascii?Q?J4YjdLC4cdnYEja2IiFaXG8vC7Y+KVuGsfblNo1w6FotQiV/gNbLvVq7YTyL?=
 =?us-ascii?Q?RB0CUn1vHL+FnxuDMOKavRMttyheomnrAYXTm7iKLhxASFNieuCV2OVLc5go?=
 =?us-ascii?Q?1fNLNgNMOsiDng0xiagu4Sd4hWtw6kzMgE2gElWwPhm6BpdMYoV8adODyx3j?=
 =?us-ascii?Q?/44CnRpsNbLT70N99Oppj3GXVV8qZrtwj3NjpKjKu+AwmFHsGYL3jGW/vDMd?=
 =?us-ascii?Q?doRPXRKkyS3BmtTxD/s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 23:28:57.8172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d25a23e7-4b13-41df-fc73-08de230c6b41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261

On Fri, Nov 07, 2025 at 12:49:37PM -0400, Jason Gunthorpe wrote:
> Addresses intended for MMIO should be propagated through to the iommu with
> the IOMMU_MMIO flag set.
> 
> Keep track in the batch if all the pfns are cachable or mmio and flush the
> batch out of it ever needs to be changed. Switch to IOMMU_MMIO if the
> batch is MMIO when mapping the iommu.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

