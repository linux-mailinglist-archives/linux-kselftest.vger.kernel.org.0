Return-Path: <linux-kselftest+bounces-23884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B04BA00E73
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 20:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF213A24E7
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 19:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA96145B03;
	Fri,  3 Jan 2025 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cZD66dEJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAFF43173;
	Fri,  3 Jan 2025 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735933460; cv=fail; b=e66njva+bpy9yE7NOM+QNJY7cmQlO8afIPF4vr3KAZEuocQ3JA41+FvDwAiaNdOcYAWi+S3unDEnf6APxtkqyvnAFJN4HQrV0I4tNklDewJ1VsnNfG3ZWlaN9MqFjiDHbfZoQ6H9ZKdtrk+E2J+u+WQAVs9AGwgU4bnNMyadiaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735933460; c=relaxed/simple;
	bh=3EazgmbdVH1EOjYm1k77WSdK+QXXriYnsuYUZ9SiQOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkQMXd5y3G/mN41PIpZI8auHJclTu27LyR3onIlMs1gul6jtxA98D5L1cbX4NzW/ZumvRgRhQ/+TmRbHKHtAhhRNf7EEUAebDyRZF+dqND45G8ytjESSsTj43CMTVs+5zeKmNjp6MY/nXbE2aUMd7Jv8UV8BtnsTzRX8dPDtbJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cZD66dEJ; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULlC7sfsz8CpjYtxl1J+T2vCHGFUnTfhr4gfu4rIgG7XdGeSoTVJcos3HtyOPfMHRlE5DOkwN4l1Fmo3CGa8Tu2L4C11WD1laIe0irb8w607e3pKcHVd2WB8z1ztzfLstd+krn3YUYauk+p3PByFFI2pBfYcZ62Fn9ZKxdKopkItH3LWRpkkZSJgLGL5kbpYSuSNDiC+jWxrEUuhiGVEMn167URJVr1/s1B1usQ6CS3S7Cjb1YqJkJ1VG2ZUgXi1J+AgnOjrT+314jOgxETZjxm9KDIWprrXTky/xPwEy5ajERuY0lPD9aeIXNXBLmsRJ78JERqgXHlI2CzgJBTzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svpw6cbmK6TJVd0yqb1Xbssedvh8RF6/Z//fCfm6jcs=;
 b=ikar0hS1ZCCxmHZ/KWultxUfMq1tYlFxfoJ8Tg/7rmGt7RdfGwpSvpIrJSdOIEUkIaQXHs6r2/+9m7omjoTvHPbLc7azdE8ObKoBgGaHJbIK4mOH9ieL16ycpBQZOm2ebyMSxHHBefkCBNO4cTcO464bF5wylUsO7JSLLTBoYvDqcpMOGfpbYgdxlBD9FJiigUUrDpY1AO9DMNC6SbiWmN4tM1gjqJrhXqqlVoLvNSkSu9toYYZQmU9erG7VC6zMMoVC9vVgp1tgW4eob/ISpRKLMKUoANu/sV2rje3Q5iXSGO3iBEBIQZABmPN7SKL89PJdJepmHHx2iVvFhgQcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svpw6cbmK6TJVd0yqb1Xbssedvh8RF6/Z//fCfm6jcs=;
 b=cZD66dEJSiiV/p8xE9JzuHVCvp3KZhH3pw5jUm9gPZ+OF+T0/X4uiWGnTWVsMnGPy43dCz9IUpSIqUTphGefdCQXMXJBi0+UjJ9ZfzY79XIHL3a1M4eCDCSQtht49myVMYLeLmIPYELDJLfOqRkYSShGKkg7XkX2SYUAT6R6Dth6yzA93GIjNIwIgJAhGpkFKxUjKqeSrVaZhqaLjyhcIVT9tuB/QA1CAvn3MAHQjUXOVycX+UbUD2rB2YFTTazq+LG/IJsbQFzv67VWSB64L5FYznGKJeNtwjOTDy1FgBkM5CAfMUHf3wsgVLnliO68boGcALBKHSBiltK1eaEjNQ==
Received: from CH0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:610:b3::29)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 19:44:11 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::ae) by CH0PR03CA0054.outlook.office365.com
 (2603:10b6:610:b3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 19:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Fri, 3 Jan 2025 19:44:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:01 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:01 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 Jan 2025 11:43:59 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v4 01/14] iommufd: Keep IOCTL list in an alphabetical order
Date: Fri, 3 Jan 2025 11:43:24 -0800
Message-ID: <32abff935ee97fb0be3f675a2a61b535492e242c.1735933254.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1735933254.git.nicolinc@nvidia.com>
References: <cover.1735933254.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 701f2ae2-4c0e-4dae-2893-08dd2c2efee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QBxeT1YwZldEPsieHoMpDtluaNNkDOUJERiOkvjAoULcPA85W0oyye8GWJpa?=
 =?us-ascii?Q?K71EjjIS2QVG6SEF92sqmXWmvwgCYTktOzwl09PAXuuovtFWSZ8+x0VpJNfN?=
 =?us-ascii?Q?s+Y64RPzGjJkxHv5XdnvaLklnwsfjqaP9WVTJkrDxRaaOjeW0+gv0XhDk4Gp?=
 =?us-ascii?Q?FKAjHMCvbPQbFhqD6D+pCOhHlnnYhzi+DJEyJuiaVkxYE+ZGw5jRfY0bsLT5?=
 =?us-ascii?Q?nDE8Sa8kqTwykjLfA/bIkN6rFEucEeE2xiVLWnXKmo5/R4rAVfQgxEi3tLJk?=
 =?us-ascii?Q?mrGPx3Dat5uSSqKO8Hii+zygOKVyPf6WHgdGFvggMUctpl48B+ZUkyTafTW1?=
 =?us-ascii?Q?mDvvG13pzN0WW4AgD2i8NlQkeRiJrqc5sPpbZEGTZu2ntuwuJvyRdUrFNtg5?=
 =?us-ascii?Q?gPE8L7qlBWOoYhOxq8vjInM0KOZJqm8Lzi4MYiVbgv1PllgOTnOkINJdAwUK?=
 =?us-ascii?Q?9Dx+dKlaofTQeQjtBMC2ncm4DKDoOCcUsctRbByJmUvdnqo7ijKikrnKfgt/?=
 =?us-ascii?Q?jndsbjhZb9Zv3ilmBw1DO0UuQm+Z3guUlpfi1NzB7mz1EwKqVzNtYu5cMjOT?=
 =?us-ascii?Q?xRZkrmWob+5jNsNNCFO67FxD//l5lFaOThHRF76lgTQRIXDvFBMkrEd9pc8n?=
 =?us-ascii?Q?u0jMFk4z4LiiVRIlrfL3YOFRKndH8LNzrJe0ku7zZL6vOOgrpOYVfqC9NwPL?=
 =?us-ascii?Q?qGfPHP98YYcNYMSq6XnfalURbOJRS+0DbkdOIe58tjTfQh03JOjzuJukCHxx?=
 =?us-ascii?Q?qf0/oOoZi6u23MT6n3ReCNRiqB4JUkIrtG6j+cnCT4E6VDlss1VFO1iMsYXE?=
 =?us-ascii?Q?i7mfC+GjFtAC8fPVYzDGKJ0gn6qiLs5MvXN6/NLWLGK8JvFwx/QgtCDVUpO9?=
 =?us-ascii?Q?7uj3S6lwtketo01yvkwZ9YWYmaQsCP2X7s8KOs59ZhIsS7pR3Z6aAnnrCC42?=
 =?us-ascii?Q?NFW4yCuBKUAfsl9vX9T3eyNDCICEWAnfiUFK1qMYujP1CgAa4HsEuXbZyxxh?=
 =?us-ascii?Q?VMe/6Donf+OTBDjPOX6sM20FyhPL6H7VdtkFXBJyWGETm6P+H8thaC4IvgmQ?=
 =?us-ascii?Q?GZifajpLLhuIH4JEjJP/ztSELW7Lf3y8f+43p4NQoglGuag/euQrlyewUKCM?=
 =?us-ascii?Q?nXnf9jwfnwfQzL/+VDdbnLHUTGyoD88GDEo2irGK3sM+rXtAQmPPHTHkjJaQ?=
 =?us-ascii?Q?vr6XnTZ31cTCFHY0wcgA6IxaA04iUkGkG0YQFVvsl2Vt9BhZiN+qGgU1mjn1?=
 =?us-ascii?Q?oKFTFcB6PzxTdI1Om5v4bYNdUDFlO1H/aAQAEnkX6ekiGUDM3frBhnUzxfNH?=
 =?us-ascii?Q?Pc8QvH3sfi+R0cRFj4l3m6gx5sx+mnpdA3YB/S7IorsBSQfQ99YeAmaP1rNF?=
 =?us-ascii?Q?TLrLyZw28pZymZjT3ro8tGSgDgVBVEvy5RClxorPEbCHd6+IjtsRrl8t92h5?=
 =?us-ascii?Q?4/NZcC7TlJM3eKfwdD5FPSQ1q86l1nZR/iSCzrF5ZlmMkqhhcd5k/GU80wAN?=
 =?us-ascii?Q?S/WbmHa6t2dluxE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 19:44:11.1842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 701f2ae2-4c0e-4dae-2893-08dd2c2efee6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562

Move VDEVICE upward to keep the order. Also run clang-format for the same
coding style at line wrappings. No functional change.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/main.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 97c5e3567d33..49be19305d98 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -307,9 +307,9 @@ union ucmd_buffer {
 	struct iommu_ioas_map map;
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
+	struct iommu_vdevice_alloc vdev;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
-	struct iommu_vdevice_alloc vdev;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -333,8 +333,8 @@ struct iommufd_ioctl_op {
 	}
 static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
-	IOCTL_OP(IOMMU_FAULT_QUEUE_ALLOC, iommufd_fault_alloc, struct iommu_fault_alloc,
-		 out_fault_fd),
+	IOCTL_OP(IOMMU_FAULT_QUEUE_ALLOC, iommufd_fault_alloc,
+		 struct iommu_fault_alloc, out_fault_fd),
 	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
@@ -355,20 +355,18 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 src_iova),
 	IOCTL_OP(IOMMU_IOAS_IOVA_RANGES, iommufd_ioas_iova_ranges,
 		 struct iommu_ioas_iova_ranges, out_iova_alignment),
-	IOCTL_OP(IOMMU_IOAS_MAP, iommufd_ioas_map, struct iommu_ioas_map,
-		 iova),
+	IOCTL_OP(IOMMU_IOAS_MAP, iommufd_ioas_map, struct iommu_ioas_map, iova),
 	IOCTL_OP(IOMMU_IOAS_MAP_FILE, iommufd_ioas_map_file,
 		 struct iommu_ioas_map_file, iova),
 	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct iommu_ioas_unmap,
 		 length),
-	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option,
-		 val64),
+	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option, val64),
+	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
+		 struct iommu_vdevice_alloc, virt_id),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
-	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
-		 struct iommu_vdevice_alloc, virt_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
-- 
2.43.0


