Return-Path: <linux-kselftest+bounces-23627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2034C9F87E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 23:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2A916A3CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 22:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D8D1C07CB;
	Thu, 19 Dec 2024 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CloL2Oqy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEB86337;
	Thu, 19 Dec 2024 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734647535; cv=fail; b=d4Sj2GodUumdVcrMdWpMLkEdUDNQihjQvBso+zpbZby2LMifxSIGdKdSengO/ChIFTmIGowNjqG2bjS8KWkJFwtOcxkeyPnChm662hmmzpi151qv4zsu8KIvrs5Elx5VOoPlxCy9pInJwrvzADzGf2b285128aDNOMSrYFJP7MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734647535; c=relaxed/simple;
	bh=cBx1b6LWcDGDBXtlleSZL8sVVkDZvQTARqftYzBlGI0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2OtND/lET5ntK52dhtOCFnOIVrvHfjCCtiElv7v0zFFSi9aGc/mZUoeTn0NZ/LvE/8OOPFv6xepKW+FeaKtsOzfERgY+VXoh/TIQjTt0ee/WwR+KKhJ+0EkINoCGbcqtIJAq7TCWvP+7ZSfUGUsSuxI7w0ksJ77KUuJ5kG0oJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CloL2Oqy; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwzoCe8mnJUTMXjQsoUizrJLILQMvuvlMSkjJJWbWJXEDVNLonpdWKx6odyT5ppcQewBOvz500NTcKhSn5Jayof1pxZKsKJYXSM0nBA+T8b0BeWFl3UNisa/dSq3iGJprTrOnSZx0JyIdvBSf1jPmokC2v5xy4QmXZyC0mQMJ0lSw6ncGo0qrzKs2kbamcGanIOPS9q59u3nZ1bieSecfFtqR1bb7nFeVslg7FSNtgx0KD4ZWB/8PJCHzptt/5NkyrJZUf+eNikdri4uzbSIyF5YuPv7w3wyq8qAJ15zn4x8gvUq1z97A6u5GGPccoZyHLlFz3CXEFQ0iZZGwM4yzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1Hyaz7Dh9fSpEzpXbCt0ThRzwJVyvl/2jhnPWAJgqY=;
 b=fcuvRLpSgeFmKn0tGt+GzKpDjPqMSdnk+Qi1+9zlgkmZdZU7XDNN/rsalq5XCffGafJoJP/ExLkVbQNgmcXs8cvO918uFVJZURMtuP5ZReYjxdxctkjrHei+yAwuwqjEwKbvnwEzZjudYiU6ugNNRSlBnNCafUJVdvPjhEp3n9aeHpA+b6T+ziiAhgookf9Ng59MDl8c3Z28UZslyzBYeLPcbEdEy4YcpAa4FcxJbd0qvD21/LLTzLZLFI1xK+J5UNLoQqCXFfDWoFDP/ZCQIgJx2Phw1EPTx6K5mtEk1OtoAsfFO4GqM4bestsDbBhQfKXYQmuCUSF0gfDJNXcNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1Hyaz7Dh9fSpEzpXbCt0ThRzwJVyvl/2jhnPWAJgqY=;
 b=CloL2OqyPAu0jhKJ9JYaLUAEwrF+Gac6BEnAB9cGVEZQuhkuBnO6F4o+3dt30JW9ZA7c/3Eds9by3IAWAKY/Br8WHQ0DQ3nIY210exPZevLOmDHlZOTioJqWWb0tsJEFmnc/1t+x80A0OKJ2k/qaiyUbmFarmdxUvN/t833ITp6GXNec9rM/1MWQi0A/zm0vvDqF96FkL/bss6rnKZaLIPl3Lt2OfxgO04CI9uwlh7QFkTJOmRMOtyg//XsincRwLi9SjDc9+MuyLHKwwDatFnfWZb7Eh8FUXzx8g+zmdF6aydhdRpgfy3EzIuFlJM7hj0ajuG5UvfHgWfDPiqDn1g==
Received: from CH0PR03CA0088.namprd03.prod.outlook.com (2603:10b6:610:cc::33)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 22:32:11 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::5c) by CH0PR03CA0088.outlook.office365.com
 (2603:10b6:610:cc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Thu,
 19 Dec 2024 22:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 22:32:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 14:31:59 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 19 Dec 2024 14:31:58 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 19 Dec 2024 14:31:57 -0800
Date: Thu, 19 Dec 2024 14:31:55 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v3 06/14] iommufd: Add IOMMUFD_OBJ_VIRQ and
 IOMMUFD_CMD_VIRQ_ALLOC
Message-ID: <Z2Se2/IVKgXSXH5M@Asurada-Nvidia>
References: <cover.1734477608.git.nicolinc@nvidia.com>
 <dc1252de7ff06c944cb7d91c91b4f61c25182f91.1734477608.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dc1252de7ff06c944cb7d91c91b4f61c25182f91.1734477608.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c61e0ae-73e4-490b-8eb8-08dd207cfa98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OW0ZnTbF9sl1mgnnzSPpjQRHITD5G1gxh3RCD5+DCi2ggLYln6J8tXLIgj5T?=
 =?us-ascii?Q?YxrmuS1d6wchdev7XWmjXQ0kFIX3kMFnk8fSjjp4qDe+99EeeeYeYinAO9Is?=
 =?us-ascii?Q?U8LeRRxaKHIRtGV1FuZhS6hC03kEYkN3dv+e5z5QWYHvK+wrHRPd6Qt6qESM?=
 =?us-ascii?Q?nWPZzeaelycKahZAU5HApW/AXNOW+9BsRTTZgZwB+XAQyvG5ExN5xCqcydS3?=
 =?us-ascii?Q?csfuhIlg3gQQJo81JvBh2ity6nynzBI+wUJ2cBDAguO09OFp+DydBPyq/zDW?=
 =?us-ascii?Q?q8JB7c75BCHcNeiE5PyElGbm4Eu9aZ44yMZlOphZBGm+Y7Wh6YIMruTtrFQb?=
 =?us-ascii?Q?2UwI2hC7z7MONktb+lm+kfR5agfp9Hlfnwo+2xhXxBs8uQ3OR8nsEgBz6k+b?=
 =?us-ascii?Q?pLLmlZtJemeWrkNzJRfV5gu9JruDol+caLK6gtfHiIl7MfRhxaewVBoNosli?=
 =?us-ascii?Q?dlSaD1FO5lWsPuOgWMW+oay6lx6XHWj1St0iOxC3t3oqAMTqXKbJyKIABesm?=
 =?us-ascii?Q?HmlfUUXM6rrWXLJSvp4vCM7sRge3WiYmlUV5lGU45pHHIT8Y0FzK3aA+PF/l?=
 =?us-ascii?Q?xN0suTbASKkfraaG9bw0G9NFrt+rnZqUaUIeBChPddkYZzghQGbZybkFeUV0?=
 =?us-ascii?Q?xM7Tr9RcwhgVGr65LDWqook9OHrxotEBvWsw9LhO5W+BQ4DzTpZ9Rdx0srwb?=
 =?us-ascii?Q?MOXz9x+BMOjixv2Nyja9JYis7CI/8JneLc1OL8gU+KMxrpIqfm/h8lwVvDp6?=
 =?us-ascii?Q?Yw/mBKawJDBpngbNxCN0nR/GZ0CusdVVulyppJAms+WWCs0um6Xmc4ZVeUzy?=
 =?us-ascii?Q?cgpJ4LhisNsjVbWmXCb3YjVY6MfgzC8peGJ76U3hZxppqgA22N56vuE5p6dp?=
 =?us-ascii?Q?7RwRrAjZ2aq7o+Y0wSEv6BQqYqM4M6MpjfRt5vsOg6XQo/hQj5zfH31ve8zu?=
 =?us-ascii?Q?4UXwOz241PKM5FPDkCuBYOpw03FUJ5TKWoY345HkWiTx/NAr83PnrlWWXjmF?=
 =?us-ascii?Q?BCNFwipa8Xp6uc7vH2ffcHtgGD8//645AE1G/6CycPbKFGtO8olM7by5db4E?=
 =?us-ascii?Q?LtEh5zU8wjIHjpo5UGbVeteobqiE8aqk9pzhOMZcgdGACmruxvSZjCs9Qa+c?=
 =?us-ascii?Q?DT4UGpKkw5iDiv1Wel9WnuBD5MRxXS++cbCD97KA7k+4B0V53e0r9i1puPm3?=
 =?us-ascii?Q?teR9HgMZQZpCKtM3qDgFqvlHfTdxf25bo8Bb28OO15tWQhxzZ5AGVgHQKodJ?=
 =?us-ascii?Q?HP/rJQuY974xbNkQHuybUCqbFCAEvxFRGhI4QgeTuO7pwzfOV9Tac7InCfhV?=
 =?us-ascii?Q?jzecZ0+zDF7pSKFYs0dYVyAe1C3MlQJ74lgY0/MzQShkSpgFOOu6EQ6bF1k/?=
 =?us-ascii?Q?odvzXB2V8PoYQqxYgBqR5wqFrOioyh8+v9e7PSRENF6Kr+gRGrvPd/C3am44?=
 =?us-ascii?Q?hPeZ5mJaAMuxqswfCSDKQgFh8BDQj2nAICtww57lWq6E2lwD2yVfnsZbdHb/?=
 =?us-ascii?Q?FFgWXRK7Zdue5XQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 22:32:10.7407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c61e0ae-73e4-490b-8eb8-08dd207cfa98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189

On Tue, Dec 17, 2024 at 09:00:19PM -0800, Nicolin Chen wrote:
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index cfbdf7b0e3c1..9d15978ef882 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -367,6 +367,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>  		 __reserved),
>  	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>  		 struct iommu_viommu_alloc, out_viommu_id),
> +	IOCTL_OP(IOMMU_VIRQ_ALLOC, iommufd_virq_alloc, struct iommu_virq_alloc,
> +		 out_virq_fd),

This is missing the "struct iommu_virq_alloc" in union ucmd_buffer.
Will include in v4.

Nicolin

