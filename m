Return-Path: <linux-kselftest+bounces-24015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD5DA047B7
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883333A1367
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEEF1F5421;
	Tue,  7 Jan 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QxpVDa5c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E681F4727;
	Tue,  7 Jan 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269860; cv=fail; b=oc3CsMy3bz9VXbhG6mQgC7v/Hi16H5Jjn7yIH5Nzwce956cqdAYj1SlKC8saLdAHFLaV3oa4at9LyQ8y6//0WVW2hwTtwg+B/88eWm7peJtw2pbHF8ygjL9Dd1HWX/oLWW/H9gt9phQS5CtDekuXbC829yMxyPVeCPHg0N4MZDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269860; c=relaxed/simple;
	bh=OH60dkGKLrPZTsyM32TkRG9bdeE+9Y2aVMBi8nHorlY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eupQonZQTvjI68scEeuJuxQqo2YU3r3n4rNZD3ymjPPOBNdnHlMLB9/UcKl+io9luURduFay+5yrHM0OktFWIiLFvyK+iyKs3K3AsNl4YX0iHg+N+nCO85kjaC6X40arbmRR/zo1ngT9miZb8cpNbWEos5pyP/QVfFupLVkL2tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QxpVDa5c; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D53cqb2HjO0IuVY+TzjyYRewTWZUQeYEIwbDRkBGgZSHIQDAGa6E01Reu0oQov3MRUW/mNG8YW2xoL8XLgnm9LbDS/dPtY8MA2+NhAynrVA5WIqEqMS02RZyPYWSGsAYHjBK5umX7ifSugLiF0V2ywOVoiMn9LFuGiRjNy5QLzy3O/hOP78h8gy0vwETuSYKYFtgvCsBpqzIHZ5Q7XhyvAdBv/mL1YbLCfYOFdvLTTI2a+PvyPOnkmhSQcKHSnPt15IcJnov7eyrel/6vFmMWnf+VKbKP45vCLzhoEzB1oBTEJp+OD2QsFk+MpqEtDXLkck18FRWI94SZMW+OVWNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vY7vxx+Vn8PB9+jCIIbHTRj05Uptls2AQ6Dl8+kiok=;
 b=mZUM0Q3JP4n+O3matepahHgGcHMv2pGsNqt74QZEBWrIUYJ+yVfncv48N8Bi9+rqCOiRVRMsqx03HnH0BjCRFbKgu74hNDKw6+bfNi8MGZcdo3+iLVzhBe8nXfbwU1tGBvEb7Rb2AHgxk8H1yw4rl1mKjnpBcNxSa0kQWUTwiRdHigB1lcEDJox/ufZFjCsNBkOyphs8M5pfCMGjj1d5eloAn1a6CeojgMsW+5Riden6OiSST+t8b32yX444Wrh7vKpEQDVwillwvLfMXr86tZZzj4ciynN1NortEnor5++d0HVibr9WngZN1Wv+5fVB5N84E0Z799Lc0BdmqIiyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vY7vxx+Vn8PB9+jCIIbHTRj05Uptls2AQ6Dl8+kiok=;
 b=QxpVDa5cX4MxVeG5MG1A1E1DJcSeB5ERORShUSWqHrZgPnQcr2PU2lXzV1BiPpoYkPqx1icvrmN4f2x7hwIr4Ja81HxffAJ6bR9liW8g//z7ZsGXiKu/ciJb3igmGYwUjFmSULvyT0T5WGTADWJiWpHhor+9hnnMpNmzXLYMBppozsoj21pHo8HthEsFsWM0HzhpF+FLzXtR+Oa6T95UIybVJuW3wxB3PNVww2HHo4usb7EBRJRkrOZ6s/ioY6fEeq7knknktea0EKK1n3CDmS+oh/q81cc8CnY8eSG5OBFpBFBkJC7sEQbk92ALTkivaud7K9XceobVcvBPSISf+Q==
Received: from BL1PR13CA0008.namprd13.prod.outlook.com (2603:10b6:208:256::13)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 17:10:45 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::a6) by BL1PR13CA0008.outlook.office365.com
 (2603:10b6:208:256::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 17:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 17:10:45 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:28 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:28 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 09:10:25 -0800
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
Subject: [PATCH v5 01/14] iommufd: Keep OBJ/IOCTL lists in an alphabetical order
Date: Tue, 7 Jan 2025 09:10:04 -0800
Message-ID: <c5e6d6e0a0bb7abc92ad26937fde19c9426bee96.1736237481.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736237481.git.nicolinc@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: a62e0670-fce5-4232-4e22-08dd2f3e3985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wqc0Znuy4VBhZnt2DzkTuI0zVnFC8EuKTWWart0rbYhYmZuSy1hOMnK7mC14?=
 =?us-ascii?Q?QTwEGB8IC09h512/AVcFOdt0xFl+vW+Kf+sHfC9WXEpUqdV0jb0Wj9S+p9Oo?=
 =?us-ascii?Q?oYo17FloYQr9hcKZ/3UGPI/q4XyhVWlkTzuQ7dzxKe/89F8BN7T0b9G0r1XC?=
 =?us-ascii?Q?ixBY7YEi5eGdGEx9RS9NWkZJwJtFEUNWu/YFUexnkixtGKG75aWfvAGIQEyy?=
 =?us-ascii?Q?eK4Z+ul5XO2HHi/j1qNzL9ESzPwuSJGQz1oLbDp2JjDfzhKZKbfZtjaXxpnw?=
 =?us-ascii?Q?w5fTgu4jBe87BXQMQHSWIJqy26IKxaXUOhBpdLCssszor/BOMcCd8pQQfwcw?=
 =?us-ascii?Q?XZgEe4jlleN3gECvienxJXVnOsW19RQbscU5G/1dmhVdjUgkq2uRlU11Z9wn?=
 =?us-ascii?Q?ZD4EtUNrg79iaLqFXVh9vQ6MP3jr/72WG/H5taR4syWS/hrkDQwAAapVTsA/?=
 =?us-ascii?Q?JaQ1+GXYgA41HAiMIAE6U4J9CRqQa+gSZXCgfT0qnTu3gLuyryJ2ULrC7ugf?=
 =?us-ascii?Q?u/1jvj0m9YS3eFCPBe5GUVc1T70vRuBfy+UpyLCxhjQUZ7I5Uxi8qgpze1RU?=
 =?us-ascii?Q?zbTVNmAGr7gi3JC3XaBvD2DIf3OQYuTdko4SDQofcbM/QgBKxaLgOBSyHfU6?=
 =?us-ascii?Q?m5RmGCWsW7/FzBSqf+ObT6ZCUMuWe6hX9XeDaLtD18phHMXGp01A1LQkTEpq?=
 =?us-ascii?Q?6hIutnUzV05wa7DYne13DaMjCY2aYoQ+GF5Gt4F9dtRRQeH78DkqKDk6l/c7?=
 =?us-ascii?Q?L+IFblL2ROWd+bK02CQsCQjzzfQ5+pfRkDNOMOYjIz8KzkjHbprLGRZRijC4?=
 =?us-ascii?Q?D3BWc9rRhgVMK5DdudKjyTzaeD/jmfFhb/h340AeVKI3/SPKXL0yoThPrMnT?=
 =?us-ascii?Q?sndZ133rL8Zw2wltpfpcxmd1KSYZl8eGEyhSGpNdlNXwhEvPrP6/RGuOb3Qc?=
 =?us-ascii?Q?QWx+NOo9HG9PMih3SqrRqMZr1taRuCz1Qn5KOAWKRTzEw3WMgbSLatCNsA0o?=
 =?us-ascii?Q?sxjK1Rmn4X0GTfVbswK1yyFhV8QcWShKEIS5QkeDHOhH5PH7vESDUxcBC2lS?=
 =?us-ascii?Q?7HCitXTSiunudXc0ZVBCuKH8ethnlnG/cNTAF3B7WXSKPUvV8eyQI8K7a6gU?=
 =?us-ascii?Q?8jIscvpktZKLy4Zu/VBJqIXlPYvyMAN+fSKZMONhSq+7kaEQl3uwUk2haG5D?=
 =?us-ascii?Q?THlQvNYoNBHRVN1yMq9pFzZwH5JVK9Grs74pRNOwc1gY3ymccNjpKNRtuWwm?=
 =?us-ascii?Q?t2n/X9Kucxe28i3rOycQfnboc+0/EhH8//vVNXdNZpDqaS/e5HgogMJUPQ6I?=
 =?us-ascii?Q?8mTQ/6YolIqoNEbGD0+8D/oQX5bvZhlxsVO4hgNUC5LBHYupPxeXcQwmnQwp?=
 =?us-ascii?Q?wxxrVxywpyaWO0sv5MSjbjKv3/3t05FKGeHZI7HlWQwj2NP5qcKc8WHRWCB5?=
 =?us-ascii?Q?fC4FWqWqESJTj3j8ApNQXVC3t+ENWWRULpecODG2DZvtsmOTHWJZZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:10:45.3962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a62e0670-fce5-4232-4e22-08dd2f3e3985
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697

Reorder the existing OBJ/IOCTL lists.

Also run clang-format for the same coding style at line wrappings.

No functional change.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/main.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 97c5e3567d33..a11e9cfd790f 100644
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
@@ -490,8 +488,8 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_DEVICE] = {
 		.destroy = iommufd_device_destroy,
 	},
-	[IOMMUFD_OBJ_IOAS] = {
-		.destroy = iommufd_ioas_destroy,
+	[IOMMUFD_OBJ_FAULT] = {
+		.destroy = iommufd_fault_destroy,
 	},
 	[IOMMUFD_OBJ_HWPT_PAGING] = {
 		.destroy = iommufd_hwpt_paging_destroy,
@@ -501,15 +499,15 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 		.destroy = iommufd_hwpt_nested_destroy,
 		.abort = iommufd_hwpt_nested_abort,
 	},
-	[IOMMUFD_OBJ_FAULT] = {
-		.destroy = iommufd_fault_destroy,
-	},
-	[IOMMUFD_OBJ_VIOMMU] = {
-		.destroy = iommufd_viommu_destroy,
+	[IOMMUFD_OBJ_IOAS] = {
+		.destroy = iommufd_ioas_destroy,
 	},
 	[IOMMUFD_OBJ_VDEVICE] = {
 		.destroy = iommufd_vdevice_destroy,
 	},
+	[IOMMUFD_OBJ_VIOMMU] = {
+		.destroy = iommufd_viommu_destroy,
+	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
 		.destroy = iommufd_selftest_destroy,
-- 
2.43.0


