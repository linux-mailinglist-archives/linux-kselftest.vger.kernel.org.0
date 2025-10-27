Return-Path: <linux-kselftest+bounces-44130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F4233C0FAD5
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E9454F460B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B293164C5;
	Mon, 27 Oct 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cQR2TLZ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC01A5B8B;
	Mon, 27 Oct 2025 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586417; cv=fail; b=XnWXnNMXaV4RaaHwmp1OmNvRZ2+DoZsDYTJ74ZwXTztWLVVFLfoweZyU8tH034nVJcW2dKTsGrjvKV/yljcWwyVwumiwOZoPa6JTb0dXX5OGU1HdcPzYkkxc+JA0QJmKcj5lfRDuxAUP1J/QbljptW8AOwDELmtW2uVRDvlqk30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586417; c=relaxed/simple;
	bh=MatRBB3qrbaIFoANrRDlrY0O8fzetNc0kX7B5fTnW3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=orK9XRixxpS4b51IkO8RF8MFYFFXmOwGVbP9H0amgWjxGdx1+CXDWjiUBFw+sw+Oj68FuP4sfUIp6mbo2Z3DKB94jxHiZ+cP5aZSVJLckCdSqYw86yv61wwbmOnXS5ONRGKzpUIJkjVZEZuSeOE+7PUGnWgfn4GI1ePLewxR0GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cQR2TLZ/; arc=fail smtp.client-ip=52.101.56.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cX11qPvwHd4NxKWBGc55amAGA7NTovpb6ZYUrWu8pt4osLA4abQM2uwAVnFhKsPVsCOqubmIy0ClRw01mYBMa6mBsiTtvyZIsusPkC3v9X0zZ0VJZtqofWtki/8IMSnHmu4JP/2R58qluH4dHLN681XcLTnH8JV0hjfDg8dpjbSORTzvqND/Gb5aPndGFupNI54iv2bDS4ms5v+bZdseyUHXJ+wwo8BQCTkvvzsakyR0dGEFr9+a8m3RHNz0UZ60sQl9/7VTdrLByc1XpegfkpcBkjOwOooVHivcy5tQPw8agHccIiVGnRCJNrfeNqPpG4+p0bY0YR2wE6SqHt6Ybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZ/Lequ6IH1arknjA2znCEA9ZQ6l8pzszFwi1b4H/5w=;
 b=GmLj9YMJB98WSrHSke/vKqZ7WF38amoAR9qOGpVvNJKtthvbRZy7tgjyeQYjKTmtqo/Vc/DUTELRHnzHGoa9uzAw9RruqHoEOxVmsgjN7vzvzhIpA3FStWU3rSItj5hAs7KMi0bh+WlzXBZfPTsjEve7l+87aIeB1f1CXOQ5wwPEJaA+7dyXg3qHSmOoLBrRTGQP4C0dHGxok0tGEVmUR3Afi5yVt6Cgr8xPeq4m7qp1gg1El4cCbKKhCVtVT3MZl1XxyMk4UI1ODKFbsZWrf6OOxBlAUHlmtP37MJKPSTHJW6Gdhqs9vvUsKXGQIseofsVlRz4r7SzvWkBWGgwkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZ/Lequ6IH1arknjA2znCEA9ZQ6l8pzszFwi1b4H/5w=;
 b=cQR2TLZ/KW9P7FwbtORPUj0ayFh2DEmWzhwAeR/HVbHqxqFFv50BaKTKQ3KTDEaQMIuog1tA+jHbGEZ1vAyUD5DBuhrU1KfXrRj6nVCmJljJcOg6Ew3FeBLsPax16XQRF4Gr6X2Tuc2uJwASrG91aPPaVS1dfyMzFGkEWY0JC2Ob9g0UoQBA5m7LqdjfEODP/dHODGwaRj0tYdI+DzJqV5GxcrMi6p2USG+ELgpJfGVXVIu3Bny+GIhhMtKi2Mls9aH3hqauG9gMsyGq8EYntnhEJY/OI7J++0phCRRYzu7Dmkpt6I8WnsGVSQKRKG2KWRhEEOPyKfoQrHVzEJcNZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BN5PR12MB9539.namprd12.prod.outlook.com (2603:10b6:408:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:33:29 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 17:33:29 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 6/8] iommufd: Have iopt_map_file_pages convert the fd to a file
Date: Mon, 27 Oct 2025 14:31:05 -0300
Message-ID: <6-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:408:fb::28) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: 22856ce5-81d4-4c78-31d1-08de157ef167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JwKzNGxVBIdAWI7Pk1bJJ4AamdXnFgA9IfcscF/2FebrAPQ57sdW1iNrBY66?=
 =?us-ascii?Q?Mnepk0qPaL7FhfE25WAIAJGvxm7uJQtbR4p5Drhh8pG/aMkMnBU1XWrqz42L?=
 =?us-ascii?Q?Q5CzcSCjiDZSo/3I0HwtaleeQO+hkv2jaOfZ5j6PiJhQEKjZaoliTrfCEV6+?=
 =?us-ascii?Q?maCCX4Aq/Xs4b6GDr3U+AcMwMWQav2FHSL7WnDKQW5F965/Botz5FtqCGQ20?=
 =?us-ascii?Q?klJB5Dm8gWo047T2nygLeEFweGkMlsLR/2MIggDWxPmYIWdL+XJds6bz4KyK?=
 =?us-ascii?Q?uu6i3rXmrCgI9Si/T/hoJc+KoFEpmXjThkaZ3HqvocDF4DJIdPzzI3c9BE0L?=
 =?us-ascii?Q?uExdm93qhNJhRwRXrD/yd9ZSTSEa5CFie1sGO5N0sqTcC+OB9OHylpGGXXIw?=
 =?us-ascii?Q?NLN4JGVR//2VdrYDlZKn5R4dPFM0k2qq7w04w2FuNXMQVNRuxlYZAxvLgYge?=
 =?us-ascii?Q?Y8/8Z1zDl4KXnRar8fYJ00hWGqeAhqTPXx93FGbfWpcirH+aiGlpfNcbk7el?=
 =?us-ascii?Q?KCJwQlsAPIW/F0jdbNT0TPSCdqpJW+imll3mpClnuw0fbm86zf97sEv+Jy11?=
 =?us-ascii?Q?6evtuC24dYjaY7565U3VpatuKn6iKiRBFGKC00mvBbmpj4PWI+NUJ5m7SMdU?=
 =?us-ascii?Q?zko2CUuKNhUCqI6LHqbuIWaxcInD42ISbUL1GZsSR/OZYzwwsNJnhXWs2Oqc?=
 =?us-ascii?Q?EACKXRCeAkVKW/PKfHtKCdl0B3yrA72PqabaiuiARIF3liOt27BE54DKyAy2?=
 =?us-ascii?Q?b3lzFHKKmjJopeppzTGSPUQGji+0VWaZOwKpgn2kalxH4MSemRN4d9ymILqi?=
 =?us-ascii?Q?1ZDet9PXi71istYcS097NPaxrziE3socnTuXhT0qd4Vsz7DKeWIRRz1zBc0S?=
 =?us-ascii?Q?xxF6+mO9w+tWl/gq4u6WJPm39EF3BLgYmPjnnQF6LBf/AcyeJlyAFwa6UpUu?=
 =?us-ascii?Q?w3xJCoTiLlIZW/+67cjY3kNuABaRnI9IDmzEmVs2u/5k4R5GV/AFbu7tm4le?=
 =?us-ascii?Q?80JKF0XkOXE2IQ8aCHwgZ6BQ6WjcryYqm9YB54v7ppiPXXWE972ED+ivtbLL?=
 =?us-ascii?Q?UcIxZY6FCvdzjX3o7BWRhq1q2obdp7M1p0h7mZrLxax8FnF39i1nXY4yJzUT?=
 =?us-ascii?Q?tkRXPFQgsfWbzAGdaBogBleU272hW1xoGO3L3XNNCFuMyT3bzkYzmrtojv8K?=
 =?us-ascii?Q?99aCEZ4Bc2cywrsuXjIJ3dpTjQW59pBXWrsNrLdVpi/cT5C/BlioMk1jFTab?=
 =?us-ascii?Q?g1KRRG3bPI1jVokSb4ce8bHaNYKSHVyyYjFcVbGWAHPxarEtc+QOF2WDQI1i?=
 =?us-ascii?Q?r3tg+iyEu7nndAnrvk5MHe3wK0ywLSIMFopOPW56GUfaO/eCp9TyCitpdnLC?=
 =?us-ascii?Q?/kr+p3XPTw4iTlJ+Ew481pJ8ca7ZFaoA2rZE0A/elR2Wg7Oby8WH6HLFlkFk?=
 =?us-ascii?Q?5XyneYWFO3MSN0dnhicXT2yiVxyeBL+bfqeGFRB7i3uqqQIYWnGs0Gldt17y?=
 =?us-ascii?Q?03mVThlCuyA8cUg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YaZv1nJiP3KpZ3Y4rXmZ4Wl+2ly6mCWBkZ+rqvhGBEBndgzg1TU15CBiJDol?=
 =?us-ascii?Q?51U/gHMrne5K46E9LKnhjiIj3CeBvMtzutP98EOcukHL4Bzl6G6pfNVt4kOY?=
 =?us-ascii?Q?dfIxOfpx5XyL0FdpPDdNtXm6DrUSjPcfu8oX0ueO0DkQxUOUvx2Ldx76h7cr?=
 =?us-ascii?Q?0Emg+orgg5ZNRebxRKrFshN+uub67820jgQL/EkLs9OjiovSRdXG0Tk0ikqI?=
 =?us-ascii?Q?LpwhQetHdxQqleewkn5J72aSp3cHqI6ZKBFzvRjLgmqcJE5On28HDFKpFy0J?=
 =?us-ascii?Q?RoBtKTWSkBorAZNUDxmauuTOpdnN3X28QLfydspNl9FON28rjL1E44Z2Kb/H?=
 =?us-ascii?Q?FSE3bLXhl8wZKjRlavtBPs2b2z7YYmbHwo9/c/Q2IbEE8ldjut/seqffyemr?=
 =?us-ascii?Q?TIzO0zwwtvRTiLxuhzS+cyZapclppG5GkEXjguDWaC3gYPLSF0W6H7hI6v6F?=
 =?us-ascii?Q?MvDNG/q10frYUncz+q9pCS9a/997CF8go1uJ/DJ14Vhg59nMMBYuHP2iDZY+?=
 =?us-ascii?Q?k65DgOWLtKBZIIaqLvvWAM3YrYZ8g3Qm7Q7KL5hHEYCN7W3xsG6BW0Hklqe0?=
 =?us-ascii?Q?wKDbvkcLJbHywiIX+fdVUw0m+qLB5Xs8yyc1qht/f0Ju2l9+oR1A7xGJaau2?=
 =?us-ascii?Q?TPaPr8ApFuwRA8LEpGi8MZ3L2svfCDuoSpWG6DPsCZcmZQTplZw4jsERT/DS?=
 =?us-ascii?Q?W+RgLEKjUf8vW17cBPaqlH+8Zw71MN4VXKz4z66vhtRj/NYRHWIc5LhsAG7J?=
 =?us-ascii?Q?rKjD2RYuZ3UYpfv6wEyx7G8xY6A8EA14Bja+824Y97xwMU7kcbgrPHQYvfwI?=
 =?us-ascii?Q?E/TF+v47Nwqt3ONbQ/+pl5S3xTRbN0dkwV3mm9QFTPyclMPJUuj50rmS9Uzf?=
 =?us-ascii?Q?nxa8Pm1nY1UPS8GBRGCL0mkxwNKGpORYLiX2SVey0etydr7Cjwzl8GRcYWkg?=
 =?us-ascii?Q?4Tc65htd+ye9aIAgxk7AZtykhdf2sjOvi82j5sQLY8YmydfRx62lWvZxOGNL?=
 =?us-ascii?Q?YZ6juS7ypCCFZ6/DfuCfMrvvAmD/TJRoqO/8XvkR/AjjnJI0PXHXHoztihVa?=
 =?us-ascii?Q?c3nV7VPKVJdr7r+Qs5g+EW922s3oyuZ7U7Xr5pcl6l1jhKAgMu5zL8k8Kd2o?=
 =?us-ascii?Q?bPKKheR2TtLd9vuT1Bh8ty+wcPGb51XwRU0ZASdBBomRXMGTR9O0yHXL+p0z?=
 =?us-ascii?Q?bCMrArfY3mM4yGzt6KB9479AIEZz6RhvI1MhKoKZ+XHNMCkSfE0+d2Ocnj8e?=
 =?us-ascii?Q?v+oz+/BudgWZU2IEgc8vcrJJzg8ywvYJPeD8O5NWB/x7M57EqwM8uZ84w66g?=
 =?us-ascii?Q?roV1zJX3KevLQ1ACJakcm6FGnwQZ4e0w5DWEtSg50eoA7AwcUoRObzFkXUgf?=
 =?us-ascii?Q?VY3dAfdl5CX1BiCUGBb56U9MGV/Ma0mt+0bDwe9BM//OxY5y0Gpn0UWSLT/R?=
 =?us-ascii?Q?XE6aBrn2yRpaD/dqJfjm8Dfd1n4XuQPOh7f8qVulIglE8WDuXA7y022L/PA4?=
 =?us-ascii?Q?/3vLrAxrz2Sz/eIdozYmbXdGBSGaP8OupRXwLR8EMr6tU+WVEJj18qvNKM2Q?=
 =?us-ascii?Q?IjJNJIyHbnbdM7gqqRg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22856ce5-81d4-4c78-31d1-08de157ef167
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:33:29.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gBrzrEt6HU6RcyJpKW1sIg2zBt9Gb3xVffPtLMFWFi6XNcF6uacPc+EVWu10RO7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539

Since dmabuf only has APIs that work on a int fd and not a struct file *,
pass the fd deeper into the call chain so we can use the dmabuf APIs as
is.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c    | 15 +++++++++++----
 drivers/iommu/iommufd/ioas.c            |  8 +-------
 drivers/iommu/iommufd/iommufd_private.h |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index d0539bbd6771ea..0ab609509a81a4 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -10,6 +10,7 @@
  */
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/file.h>
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <linux/lockdep.h>
@@ -471,21 +472,27 @@ int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
  * @iopt: io_pagetable to act on
  * @iova: If IOPT_ALLOC_IOVA is set this is unused on input and contains
  *        the chosen iova on output. Otherwise is the iova to map to on input
- * @file: file to map
+ * @fd: fdno of a file to map
  * @start: map file starting at this byte offset
  * @length: Number of bytes to map
  * @iommu_prot: Combination of IOMMU_READ/WRITE/etc bits for the mapping
  * @flags: IOPT_ALLOC_IOVA or zero
  */
 int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
-			unsigned long *iova, struct file *file,
-			unsigned long start, unsigned long length,
-			int iommu_prot, unsigned int flags)
+			unsigned long *iova, int fd, unsigned long start,
+			unsigned long length, int iommu_prot,
+			unsigned int flags)
 {
 	struct iopt_pages *pages;
+	struct file *file;
+
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
 
 	pages = iopt_alloc_file_pages(file, start, length,
 				      iommu_prot & IOMMU_WRITE);
+	fput(file);
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);
 	return iopt_map_common(ictx, iopt, pages, iova, length,
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 1542c5fd10a85c..0dee38d7252df4 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -207,7 +207,6 @@ int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
 	unsigned long iova = cmd->iova;
 	struct iommufd_ioas *ioas;
 	unsigned int flags = 0;
-	struct file *file;
 	int rc;
 
 	if (cmd->flags &
@@ -229,11 +228,7 @@ int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
 	if (!(cmd->flags & IOMMU_IOAS_MAP_FIXED_IOVA))
 		flags = IOPT_ALLOC_IOVA;
 
-	file = fget(cmd->fd);
-	if (!file)
-		return -EBADF;
-
-	rc = iopt_map_file_pages(ucmd->ictx, &ioas->iopt, &iova, file,
+	rc = iopt_map_file_pages(ucmd->ictx, &ioas->iopt, &iova, cmd->fd,
 				 cmd->start, cmd->length,
 				 conv_iommu_prot(cmd->flags), flags);
 	if (rc)
@@ -243,7 +238,6 @@ int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 out_put:
 	iommufd_put_object(ucmd->ictx, &ioas->obj);
-	fput(file);
 	return rc;
 }
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 10ee3510312132..a2786fee7603f5 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -108,7 +108,7 @@ int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 			unsigned long length, int iommu_prot,
 			unsigned int flags);
 int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
-			unsigned long *iova, struct file *file,
+			unsigned long *iova, int fd,
 			unsigned long start, unsigned long length,
 			int iommu_prot, unsigned int flags);
 int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
-- 
2.43.0


