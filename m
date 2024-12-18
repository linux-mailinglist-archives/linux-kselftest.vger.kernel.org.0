Return-Path: <linux-kselftest+bounces-23483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 334649F5E06
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 06:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21F4188FF21
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 05:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D299C156C74;
	Wed, 18 Dec 2024 05:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sIoOPBhv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240AF156238;
	Wed, 18 Dec 2024 05:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498107; cv=fail; b=F2nxeClxVdioqX1kDGinFm4fY3aoX1q7PYwu6CqltNKXtmvWQFRQltt61ndXdujHYrEhRgfIJSwX55TCKkSXpRFFlnyY6rtx55rlS+C70jneCynhJe7d/jgvj3gp0sU0W8wQdDXeqk2OE+to9RCkvHUEDMDNm6H4zPl3bLYbMm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498107; c=relaxed/simple;
	bh=HgR9pU/WYVnlKuA56Ld27vYEISxXQMA9ljs3drkM3dI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amLoSZMBSv0CXeRV1gKU6YC/QWiuIFPbmuPIfiQ56Mi4An8aphjnGEQ7ykdhJP16wqkxOxf/RewlDUMWEu0vB++zFFDRNsJdFXRhEt1AqsjOZI6pxgQh4OesClpFBgOLAq2kdx+MI+AV/hJowz80x58QU8rYNdfbrA+gV04ZeO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sIoOPBhv; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb/00ag6hfSsUfkz5XXwsA2QJ6Uj6uBfcVf5ZtC7gkwByK+CSWVt1i2k+z68rfc1QXPhheOAYQygIpoyxrr+UOJkGea4YsELGUipZfGmZOE8zJJ6/rdlBDXX0Tddy5YHLVSejmDIcM0SSxLWEiWlOhIsu2DvVoYZb4pY87C3mOS9+D/b1TTw5pL1ba/0kuyecax0T0xTmQENsA/eFSw+4K4VQ3mjRM3GZLjsp94yI0MZDr/PsW7oOChNisZs+lqpxAu/ed9DbiMb5MGyMR4Z8lVCD1scU+EmFyCT03WzAb+DailtrkSSv7Hb3tf+zkJPTBXfaXZNbzRvDUs2u8IC/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixi5UWHGVXrm7JunzOhhOYqV4e1PUcbjLjBcYtc6OZE=;
 b=fVHbxu3jeVpsphwck7OCH7Q6lgz52z3gbb27kZrmn2e1fI5IWcTgnbhuQTKKGK3Z7wUJXN78+BZ8Cf2K/utaW+ffHNAAuNt+Z0KyW7aEdaQn4ltjb8tbCJdJjJ6DF493gPe14nI3CMYBBqpPgb5M/fPMVe5UX6h5IEb05Hwo+nlpB4Y3wvUoIqj7rvyxpNYBbZr1S+WzsOhpWwdvOSJQGXy6o9yEsRwpGEiHPMZlFDApDLxMsjMsIijDuNcEktJ7ULzCDFfnhq/e74s38j5yk6XOSxIXXZoYDaJ2cD5Rj6jYRiww9Vl4ogft9h7II9JI7IeOYnP+W+0Ur5/pzpemDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixi5UWHGVXrm7JunzOhhOYqV4e1PUcbjLjBcYtc6OZE=;
 b=sIoOPBhv+w92a3criA6lJgT9AhR2o4WZh9/CfFhEZGHHgEQ+Ta3t27GYXqIFNbVUBebJErXQ/dxPFhHVsMhXrNCjcry0PFYEa/CtKXrNy0PlZlyXeCs8DXW7fQBl50kbeQEGAINKxLgCVxdDVGDYtc+0ryOVkDzmL/PtRmwpdeC6Tf08TJQ0oMJ4KcxHm0cnuun3xb1vonrmebT75S2DT0zGzX6bqLp/xGIwB7uvLROYhW6+bRyvpxqtIh3wOQKn+PfSe28wgPl24APvSnnHk/2ne2iRHZLuc4pU4drUm5sKpjIRMbCPKXAY1Qk2WlL6xE28vdzO4yf8UuSTBObnqQ==
Received: from SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::24)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 05:01:42 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::60) by SJ0P220CA0012.outlook.office365.com
 (2603:10b6:a03:41b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 05:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 05:01:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:29 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:29 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Dec 2024 21:01:27 -0800
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
Subject: [PATCH v3 05/14] iommufd: Rename fault.c to eventq.c
Date: Tue, 17 Dec 2024 21:00:18 -0800
Message-ID: <e1b19408b6dd865c4b7629924e6f62fa61f1f75a.1734477608.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734477608.git.nicolinc@nvidia.com>
References: <cover.1734477608.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: f28e831c-6e78-4b7e-53fb-08dd1f21104f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uw1QevKF/++snSJ8rz+hLotPmlPp1JURY+irzOavY+4kxcxoJliMe8s5g8Yd?=
 =?us-ascii?Q?arP3v91U2cqQYf2mNmqKmN7EQ+7y1szzPs1OtQ3fbj+FYYB1T6M7h2a769O+?=
 =?us-ascii?Q?l9G+Jd4D6eq07ay+QXqG0eZlUlbEWh9LNayvHZjQMdPOvoihigfI7U9pB3lf?=
 =?us-ascii?Q?Kz3TS9yDd2VcSV950RtHPmJldRAX3ZflIy/++2iEVslUb68CsrUPxCx7TREM?=
 =?us-ascii?Q?fXgUoi3IU0C6hR9RLrOvzd1ximav2EYYTnZgchzUA9JzPsA2SGreW0XGKQrj?=
 =?us-ascii?Q?gEs5mjCzDQ81LqEziYVgNor5j6a18j9mffOVoP3LmDxOIAdk3TJlH14mxQ4e?=
 =?us-ascii?Q?6tyk1/p+PCRPxa5WxY76MApSxqX1sHBsLx2IxPw6bf4ab/uXqmm0t3uOBvdN?=
 =?us-ascii?Q?NiawIIzJf8cBafPS/xg5Hm4MQqlLymJiBqLkNVMHfGFI5Xia0KFEQskmdtc1?=
 =?us-ascii?Q?8OI64jr6T/argu/rcLBHA8qEJwtz54hrAxqDRKfWLs8enBiL/jjdcAc02h27?=
 =?us-ascii?Q?Ss+gLMjvulsli3qkSf488SbgHZfaIcL5C3kyGD8U7SHkuvPlXwm35bB368CF?=
 =?us-ascii?Q?vpr2G4NYlDt4mVGxf/AiImEkVySSbbKrqdkgMUjJLjywklJjXZtnY2R9CQS0?=
 =?us-ascii?Q?SZtsU6F0lkT74uIiAMurLSXxnGBH4xKYxNNxgzlrb7qa8c7IxWOyetlFlAWt?=
 =?us-ascii?Q?N+75J4ezOi3msJAtCuHGy8C4HNATf5SscZyobSwGzg0Uw99SWA3Kb705eMsL?=
 =?us-ascii?Q?6nYhbfTvkHPBYXkONnHDuKsyJ2he4hIXYuQAi3OAPtqJ3ug9n+WU/GXJiPg5?=
 =?us-ascii?Q?DY0EnT3bZ5Bzzc3LOmqT13oNp0loIHSBISYLyA+DHGM3cckeQkTsnlM5dxVC?=
 =?us-ascii?Q?H0Iv4xzqNG58PSCrqZcMN8Ve2bFTDz0AEimsH/ZzfIjAXEfkulajpTOFeqQS?=
 =?us-ascii?Q?ozyfwqkRBRY8zSEa0y3VV5vjaukFwJbJOgkT/9LB+IV/wydVesOtlqYXhYyd?=
 =?us-ascii?Q?AzDFvG0BWy6sYoUnvotCqZ5WD4uIcyrF1yfupDfU1SvwdN6Oj0jvDaYECoMF?=
 =?us-ascii?Q?EtDL5c0WyoF6/lpn1ynjmu8W8Ecg+KMtnCtUb5rL5PukjeeXRvhmVfYVrFd9?=
 =?us-ascii?Q?3IsqjnEAcVb+2cBrBPY2fy5tiOL3mC8Kz5ylrl5eCxwnNrunp5lKoyoyEb7c?=
 =?us-ascii?Q?WUf0ahLDQZW1V24s8D4Xd5r7ZKeC4/UipKTQeok+vncA6lsX/Yzcdw3l38sb?=
 =?us-ascii?Q?sLcIJr/X99bQKGLVDTsD+JrZyfOoOR+ouu1IneHt6KU8HUoFU740bxHuG6Q5?=
 =?us-ascii?Q?DRlTnZc/Vx/QpDfJ5xFQHRRexnO2GnmDUz0WQRjfjiWkUKWaNFSl2uEH+/cT?=
 =?us-ascii?Q?GwLAXUYGV5YntnX9xk4WNmPfkVwJJfdkwRAECE557y6X2BlQjGcgUmEZVvJ4?=
 =?us-ascii?Q?HYe8KHEBdDbkFfWRq/SObAblN/s5iwjEv/gb/j9YjiibnLMZ2mtfLzfYBWyZ?=
 =?us-ascii?Q?j3iOT/dlRp3TWjk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 05:01:42.3088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f28e831c-6e78-4b7e-53fb-08dd1f21104f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279

Rename the file, aligning with the new eventq object.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile              | 2 +-
 drivers/iommu/iommufd/{fault.c => eventq.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/iommu/iommufd/{fault.c => eventq.c} (100%)

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index cb784da6cddc..71d692c9a8f4 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 iommufd-y := \
 	device.o \
-	fault.o \
+	eventq.o \
 	hw_pagetable.o \
 	io_pagetable.o \
 	ioas.o \
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/eventq.c
similarity index 100%
rename from drivers/iommu/iommufd/fault.c
rename to drivers/iommu/iommufd/eventq.c
-- 
2.43.0


