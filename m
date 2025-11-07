Return-Path: <linux-kselftest+bounces-45144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 104E0C41492
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 19:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B923AB495
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 18:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E3F33B6CF;
	Fri,  7 Nov 2025 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RJJ1uBJB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010046.outbound.protection.outlook.com [40.93.198.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB2339704;
	Fri,  7 Nov 2025 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540254; cv=fail; b=j3EK3FpJ82PdxDsvCRvh0Hf2ZLlVXq+IzgrrfXjp+2JTLShpmKM6WSk70TLM+5HcM+gnwa8tTB2IoC0aUUULVOlPWdOepYErZD2RHs1c1UEOXkHW31joCmA9TaMbKzxLDYKflrMApBsxaILst7asAURxaj/zDzo4JIIlF4Sl4mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540254; c=relaxed/simple;
	bh=JNx+fuKCIZm2zU2eebyjzEwU8J252MLZ/EhtcZ8fOaw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCaQ65O8tMXnns70MV6pb3hcm9/3cmBp4W81K2ZQdM0pGyVq3j1qu5WGdZFlI8xLfI6ZHNTatEOt+4kr/l3LC7PVrE5242HbxSNKIBlifvYBjI4IdmBc1qfE/pHejdT3Ghc0WK2ICEBfRVdoAsM8eWpR0Tu7XcEfuOnVH1K7GWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RJJ1uBJB; arc=fail smtp.client-ip=40.93.198.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwMHxPIamM2hdHJWLZsJDh6ocRAngDliIgluG1VXmRwhj8mOMlM+8XGmDhKh48w86RPHYXeqqcgTvLiTLMZUDUagOVftnrzcoaWIlY6L5xeq4R5wSvT1XuJ+9bnCr9FTi/3PXKLzsR35c2QWZD/LvDFOIskVNO6kAEHUJMgVP69/0+y1WOYG2Q3xXQILATabJnNTZm7F6MhFI+2Cr9WMc7qCtG8mwqdtDi9n0dwCpeQoGJRZB4vlPB+5tR4HvGHpBqUuYZmo2Z9OxqT1nbF/z8S7BClyp49jDVAeneCWJ+wkZ/kwukjsCOBpFLT9rxNhT/1ei0P49p3m99vem4njXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EijLTAgbzGD1tZGlQC/q6aW2CBGYpMQ2FcplgY5THjg=;
 b=UF+VHoa6bjYOJvPCYsvjXsUl0XXKRkuLw6OB2flmZFo4hbVK3QIn7QPsYAp90lYQ6jZx2sb2/gaY8IFtJKyy9yhPAWdRtORRO9kONRWq6veywozEb1hT31wD6VDEyZHjkzv/wtD61rI4FUnMOMZfscCacDLXRjk3PWYfMgBHhdhck05d1CCB6FqxprBnBUDnIwMtDnjy7KYtyQiBQLXr8yNnhH+2NOeiLZa3uZQ6BkaH4m0I558hbcroCl5B9k2OPprKpUyUO8eASpBTIQmWI4yb5tYSloLX2pBEb2rDn3AGaXCvR5Khs684o+tbv95+DhAjFtIVeHBbJi5SPSNM4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EijLTAgbzGD1tZGlQC/q6aW2CBGYpMQ2FcplgY5THjg=;
 b=RJJ1uBJBxbOAnFzbRhDku8aJbDi5EYiY4QK8N8g7/eOpoqGDVfZvvA1MOUa+ZoqmD6Sbp1L6hVF0Y7odlTFfixBj4NndXkO81df1sZYeWnHxhI93BuYD50bZg7+180+vp8JbCWQp0F8fqc9vd/50llnFKgvBA/asjbufwvgq0sUrk26ffoWMHhHD9x0GVpJvbKteIbB1jWDZ6IWvh0YrQwTazWJ5sVRS+3uIhBmWF8gDcQP1LFKr/cLwpdmGcvj01IH9LFPyZ1UEed+tGzuZI0t9SKGzQ1Bpff/4OCFT9SjB1ZbUpzpiyzs/sN/dILbhgaEcPxZChHBWu+Ft7mbL+g==
Received: from SN7PR04CA0216.namprd04.prod.outlook.com (2603:10b6:806:127::11)
 by SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 18:30:49 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::4) by SN7PR04CA0216.outlook.office365.com
 (2603:10b6:806:127::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 18:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 18:30:47 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 10:30:26 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 10:30:25 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 7 Nov 2025 10:30:24 -0800
Date: Fri, 7 Nov 2025 10:30:23 -0800
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
Subject: Re: [PATCH 3/9] iommufd: Do not map/unmap revoked DMABUFs
Message-ID: <aQ46v1p6BgzLOOQD@Asurada-Nvidia>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <3-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a156704-2480-4dca-057d-08de1e2bc579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oRqXdV9Il7LHMRFd10i6UNhvYD5M0lcXJl9ZrZfQRhBkHp8yuMALNrMQQxD7?=
 =?us-ascii?Q?e5SUweui9Ls0+QDJw862EJsQ6sv6lQkzc6HAATuK0imohy2qplEyvsrb7u41?=
 =?us-ascii?Q?1uf8xaCv/JvwDRZXc4jen2MzZW2kYUx6U+I2K/vw6wcbm88QCaTMe4jfjEva?=
 =?us-ascii?Q?erUxd7kq18mKFouZ9iOYZ77FwioSIHNx96RISIdL1jcANIzcnkYJFeuethI2?=
 =?us-ascii?Q?fLscr+vvaJ8rTxyHFTXTbVohYZ4lFVsJxesv6lOvr0Dfv2NBl1iMj+AgEFIC?=
 =?us-ascii?Q?Rz8e08Pwh00Nt8Smsr6BB8OaFTL4zGiIhIJyusem92AwHSDXFBFDYL+EvBkx?=
 =?us-ascii?Q?eqHrzr3OPBb7W7wDGlr/rR2ha0xf5bZZmYAZm5qZBVojALVdB1pTsOzDQK3i?=
 =?us-ascii?Q?gNzDoaSXkY/u/gsLJL7vIBs8u9v9fSgOHaq4Tnnme7pQrJGvfguXPieo4wy/?=
 =?us-ascii?Q?1cBhZtUmAPcngysQhUZvsp2YTdRwGKkCoBou4OYEorGvRNkF0RgxY4+7iIQm?=
 =?us-ascii?Q?nKlko3dUnP/h7TwOpSkQbNZm9EKXTYoKL4fo3xL+fDLpJV9WrJHSIi0aEUSO?=
 =?us-ascii?Q?IOR8tEKuVUpUbnkXfPM2dTPU456uASSIA0KIrUJ1d98CU3UXe9gc7rGgL+c8?=
 =?us-ascii?Q?qsbdh7IBiwWYniLj9A7L8ze39Y+YjSpqEMnchaBfc/pJyHCS53e8WSGZ8sZk?=
 =?us-ascii?Q?8l6lkV9SzEoj8Ft7/47V+MeJEdHwlM3MdnlqYjBsQ47pY2iPNR+MP21pewvJ?=
 =?us-ascii?Q?61/nKAk02nzaUyXK6MAfK0f1qeERQf7VlTVfLUCET/QUeF4+q6WpnnOlB1p4?=
 =?us-ascii?Q?luQTtMRc3WYwKmiz6ag9Oo9gaCrnBLVXal/2yeUX1e9v0h4HRhOSGoa6oQEo?=
 =?us-ascii?Q?dRDrxp9gW12MXgudpuwvDXIBvbBSPQeVeIBbhM7riOzfw4mqCwXgz7P8DCc9?=
 =?us-ascii?Q?XR44ozJIlpUYh+Vzy9tZ8iVYjpF2uhgt9gQgRz+gQapPRGOPaBIhjL9RcKdD?=
 =?us-ascii?Q?Oiy3tEah2F2WSyqxYsnueXVeSfl2U6lj/KOa7lOSGoxGRlKW/Ki0hgSHl0wM?=
 =?us-ascii?Q?lnjArJGBonTXUvIJ288qASfcNIikuQWPaHibWSUR0tDG9kMwmMt303RRSHYV?=
 =?us-ascii?Q?C6YjE/PxRy7UijMYieCkBUgevUQSJdJVdxObmwEZdMMhfUn+WHIVUONz0Z8j?=
 =?us-ascii?Q?agyn/ybouoLhyvWDCM1kYhHNGjt4dSQl7n+nYa5XFgLYU6ULPzY++Aa+cO4/?=
 =?us-ascii?Q?WGm11EGfoT8rdog+24/1EGfZRcaAlGVu6Pp9M/5Gd/z1FhfL/C/uhkbYS82o?=
 =?us-ascii?Q?n90KMMJHy/yoA6TwaQamDPOOo2NJsLklS4z3sjzCGIDUF8rGIsQlBE4phI98?=
 =?us-ascii?Q?5aswJBv2v01fXHrXzXLr5nXBjM3/RsE2XQqKeWCzcCa4xc17MHPdJHMZe/qQ?=
 =?us-ascii?Q?QVCBL2BrHKpPCyoOAdR6+o/ef6Ti5UluS3YhpxNzgubUtjwboZPMiC941bAR?=
 =?us-ascii?Q?V2HCWq4kjSD1NOzjTgsKHlsB/Rjsw5GicqBAfha2bYCEP8RCfhn2GPsDU01x?=
 =?us-ascii?Q?QKj8+wtzMzCRSXfzrc0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 18:30:47.7159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a156704-2480-4dca-057d-08de1e2bc579
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147

On Fri, Nov 07, 2025 at 12:49:35PM -0400, Jason Gunthorpe wrote:
> Once a DMABUF is revoked the domain will be unmapped under the pages
> mutex. Double unmapping will trigger a WARN, and mapping while revoked
> will fail.
> 
> Check for revoked DMABUFs along all the map and unmap paths to resolve
> this. Ensure that map/unmap is always done under the pages mutex so it is
> synchronized with the revoke notifier.
> 
> If a revoke happens between allocating the iopt_pages and the population
> to a domain then the population will succeed, and leave things unmapped as
> though revoke had happened immediately after.
> 
> Currently there is no way to repopulate the domains. Userspace is expected
> to know if it is going to do something that would trigger revoke (eg if it
> is about to do a FLR) then it should go and remove the DMABUF mappings
> before and put the back after. The revoke is only to protect the kernel
> from mis-behaving userspace.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

