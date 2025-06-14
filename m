Return-Path: <linux-kselftest+bounces-34978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C512AD9A9C
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725843B970C
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED381F30AD;
	Sat, 14 Jun 2025 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ewoNi4Md"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5231D618C;
	Sat, 14 Jun 2025 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885316; cv=fail; b=S7xyYN7uxZGywZC7q9VIsD9D+ZVgpfX+nWAdyLHBE4+s+7vE3zGJK4e+ELsEOxdxd5ZPRInj2G+tfamsSEAYYbmcCsyWkSDWHU7xfi6zgPpck0xSLWTYvqzhw8a6mFcwGWePDmOAny3hyeEugs4siiR9NYLGTk2OQVxKTLv0lHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885316; c=relaxed/simple;
	bh=KK6IfRpUBqOcjXOuRpR7a4VGO+5y2s0ajQmSXyx/Q/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wk2wKiFE/qqFI39iUVOdsWUW3mKhStnzB0mf1hMhFKBIJ8afLUPUSQTt1ty4b+O8lAFghL8XY17gZbVb5ArR19GUBHDXK9Zo7z6tx4RraTlCuDTu81pdwpILPV08ovsPM7RdEnra7kIl3ZXUySiI8U1alT9k5JL4xxYQEUaMyEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ewoNi4Md; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xxuv+0hQoqHdCtn865zPfeAQId1veSd/G0nu+U2WmCH1vcRLY22DRicO/9TBvsaK7N3UuugMDIW55AvjSuqeOI9j1b/JrXHS2INwfBNWmbwtlPIbCYQBCtAWrQY6ri03b4im8M10339G6xeZrM3MxUUQF4WK8c+lyl5FOisIFmeYINQMQ7EzWdoXt5OhXZNlNb1KvL1wSnNVAYoAtYRaM8csTSbxZigLOWA7xeOzaBl+wy9RFk01QiqbSSP+rRl6wZWV/guq04UkaI75m0IXlkmNNTEuMYJaaAEmVfVyd4ENHlH/YlFIee9OO+WEkSwW/TpEmnZzgX2fbTP2GlS8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTO9tHGQt1vfO28WLxwpR6gBNM99nDTNWwg3ql0Zsmk=;
 b=bNRjCLGQSGLA6hxFbL+zpFd+5Wx6vnGZjCRbtIzPQJWYdkubbISNeB00Hs78XsLSBJ9LmtUvxGPCoCF2kqTW3ZeiFS87QWIprhNxDq/U3TGliakIrbTpwpxI2i40bSBCC922aMhQNLQ7Iny76fvn5MkqxNF4XoKZpOvA5FTnhYQ26TYZYiNR9ysCCMzKRInZ/B8uKk82GhNyyFJp1NE25ur8QwbxzdD5VDPdaUQDHkXBdDLSqoY2lpT2tPNsUnLJ/UyfRTaJAlfacpSqRg07DBYoH5h0ARJDmpdwYVL5Fb1kLw30Q1Iy4t+ZmeRM3WFIfOy8OAEYNrVSr4C8iD47Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTO9tHGQt1vfO28WLxwpR6gBNM99nDTNWwg3ql0Zsmk=;
 b=ewoNi4MdqXaI0NdKxrCcv1KU9PlL+1009gVFEpH1kLpK+CeyTz8sJWpqvDV8cSYkreIJNDy+w9oiXnh5JR4jttItEnrQBpWpt/l0VquO78QyVe/L5gRL8KYxvykz+E1JyHbm4fY8i/aImh0upRvCLD9KpFIH/r/x/tZ2LskYLUn5hhnPgXSWslqXntdLLX6pe3OAMjBTxgx4nsgVzsdliV36/fRAGHhFC66irzoSEpEFB9ucOp33xZR3jlD10LUz/e3yiFT/Vam55chqJT9fd3UF7J9Ef6LfWTvAgU8URZXa/T7SwMuo0pQ0yKjwx+8/u0a0IJ9NsEygQ3evRm54OA==
Received: from BL1PR13CA0256.namprd13.prod.outlook.com (2603:10b6:208:2ba::21)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Sat, 14 Jun
 2025 07:15:10 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::86) by BL1PR13CA0256.outlook.office365.com
 (2603:10b6:208:2ba::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Sat,
 14 Jun 2025 07:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:14:59 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:14:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:14:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v6 02/25] iommu: Pass in a driver-level user data structure to viommu_init op
Date: Sat, 14 Jun 2025 00:14:27 -0700
Message-ID: <b3c5ef74addd6c3893a31baf48aa97b975bb2661.1749884998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749884998.git.nicolinc@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: d8658e12-58da-4e79-2a26-08ddab1332e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TDyN1mv+kNLe3Tv+LJE/MgFMoKqJ+P8jDiXj/PhBMP+EK0HOtbWpFsJbHSXL?=
 =?us-ascii?Q?etCNj5LM/iqrc8Piw/lgyWfF47RjPL3BD7VTf12IINtr8CiGp7YBD0A3KL9L?=
 =?us-ascii?Q?rX75IhooKwXUu6MOpCC6kLjILIot+mIWfGL8Q2r+Y2y2jSfJVBS78VcINUmm?=
 =?us-ascii?Q?3mD9xvkBu7IH1ECiMlKRZFuYxkXcY51tGkA7RPuu9W/xYaBLY5W+KbfyCDWb?=
 =?us-ascii?Q?QGjCXqPRX7CVt4NFKnuCBGtLUCIY7EqsFAInwitU/JrqLsRe1o+R8bSLNOX8?=
 =?us-ascii?Q?5eFVCQOrHct3mvpEmkLQdXlUuVos5mjMaJXuq5gPM3kXyd5UQQeeUhcDUn20?=
 =?us-ascii?Q?Q/H/vMjqriwqOzuL7gefj7qtm+NGaS5sPETTsi1pncHQz3GjJVb+ccRNRUbV?=
 =?us-ascii?Q?JOL4iZgpw/0JLiJh6jzxeAQVzmmJ4JSJZGYFy7Q0zBQTnBa//eZBoGFtekzr?=
 =?us-ascii?Q?6RRtc2kaEltl5u08zjXP8+a2i1cs2SQ4k2R3yFjBdmZPI9paUbRdj4i16gYS?=
 =?us-ascii?Q?e7+zlsZhDKAsz0AiYtMmh/U+oVTMYWJlDeckSGcEL18rnA/iqYA16Z7wA/kR?=
 =?us-ascii?Q?xXw6eZYZc+LFeLw/8O0+I+2E7sCb4N0Eo2E/miCvaDouqvadjlTP1MhdOTiY?=
 =?us-ascii?Q?mzCYVAvZ75ejbBIi8TfRrm5RBiYfOK5oW0SYlM6uydwYqgI1rRmQtpJ/nhpa?=
 =?us-ascii?Q?5flVZCc0EjvZ9L9hX+RgOgU+AX4g5yStZ58xPoj5kmUsZ6dK6+06wbmwxvqU?=
 =?us-ascii?Q?Xsg4FgSHn5tFuBL3Fovf0YQMbEwNS+NFwsA7AFnMjVHxaanzJkmxS3f3AQM0?=
 =?us-ascii?Q?fpHK+DSSt8bh4whyOselIbDas0R1WYeYIDh7qQ5EVAGN9Fkw6X9CXoB6CRK2?=
 =?us-ascii?Q?oH/9/mURmZTpudYiOyOpgqbgu7Aq8v8jZc619wRW9MMPw+gQ3MZ5u/DckOCH?=
 =?us-ascii?Q?RDS5lpNU75IJvkk053LuXTkQCEbjdQC6Re1vB8/NJGp1xrCg8A+NSE2AruYK?=
 =?us-ascii?Q?LY1z7y7vSXlgmO8f1sc8d1oIub/8d8YY0MVSxCuQuxqtMMJV3tVhJgy1XcOJ?=
 =?us-ascii?Q?cCghL8dJpq7ysgURTaBGPvFaH7VBc3WSUi3NtE1eIPtcL2pCdsDv3LFuhY7U?=
 =?us-ascii?Q?mBsJEAfE+/1CUaAFuEYZn7vDVIOhnAxCuCfMw54+Bb9O+sy2jycpmzFxpx+q?=
 =?us-ascii?Q?79SscgdLehkA8zGDnq9bDqVbPpurNomatYr1iVXQxctoQdHQ3JAkm7Uwl3Rf?=
 =?us-ascii?Q?padWvXbg4V6BCaIaoaD33v9b66wW7vHzAf++e+2MQMLY3bvGlDmwIOFn8IEo?=
 =?us-ascii?Q?LlefoMKWY2LVtb9STz3eKxaPcjh7tRfeDJBmiwmtODADw0yLCyKiu6Fj03FM?=
 =?us-ascii?Q?Nq8URsBI6r+5N2Y9l9Z3mXBCPNa7uBzQ7uF2rrdlKx7oT7TFMU4KZtRcx1SL?=
 =?us-ascii?Q?dK8YL3O6dC7EF+JWX/VsHumDSy25KyXSBDsuKE+b+61jO9qDjKq6g9aO5Fc0?=
 =?us-ascii?Q?MwwYPUhGhlx5Vp6z8DOfUpgH+jb5ZLaXp5/Z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:10.1152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8658e12-58da-4e79-2a26-08ddab1332e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669

The new type of vIOMMU for tegra241-cmdqv allows user space VM to use one
of its virtual command queue HW resources exclusively. This requires user
space to mmap the corresponding MMIO page from kernel space for direct HW
control.

To forward the mmap info (offset and length), iommufd should add a driver
specific data structure to the IOMMUFD_CMD_VIOMMU_ALLOC ioctl, for driver
to output the info during the vIOMMU initialization back to user space.

Similar to the existing ioctls and their IOMMU handlers, add a user_data
to viommu_init op to bridge between iommufd and drivers.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 3 ++-
 include/linux/iommu.h                               | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ++-
 drivers/iommu/iommufd/selftest.c                    | 3 ++-
 drivers/iommu/iommufd/viommu.c                      | 2 +-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bb39af84e6b0..7eed5c8c72dd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1037,7 +1037,8 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type);
 size_t arm_smmu_get_viommu_size(struct device *dev,
 				enum iommu_viommu_type viommu_type);
 int arm_vsmmu_init(struct iommufd_viommu *viommu,
-		   struct iommu_domain *parent_domain);
+		   struct iommu_domain *parent_domain,
+		   const struct iommu_user_data *user_data);
 int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct arm_smmu_nested_domain *nested_domain);
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 36a43c6d8fdc..c712669f3055 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -700,7 +700,8 @@ struct iommu_ops {
 	size_t (*get_viommu_size)(struct device *dev,
 				  enum iommu_viommu_type viommu_type);
 	int (*viommu_init)(struct iommufd_viommu *viommu,
-			   struct iommu_domain *parent_domain);
+			   struct iommu_domain *parent_domain,
+			   const struct iommu_user_data *user_data);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 9f59c95a254c..78d9597d7b86 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -418,7 +418,8 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
 }
 
 int arm_vsmmu_init(struct iommufd_viommu *viommu,
-		   struct iommu_domain *parent_domain)
+		   struct iommu_domain *parent_domain,
+		   const struct iommu_user_data *user_data)
 {
 	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
 	struct arm_smmu_device *smmu =
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 74ca955a766e..e09fa859c359 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -778,7 +778,8 @@ static size_t mock_get_viommu_size(struct device *dev,
 }
 
 static int mock_viommu_init(struct iommufd_viommu *viommu,
-			    struct iommu_domain *parent_domain)
+			    struct iommu_domain *parent_domain,
+			    const struct iommu_user_data *user_data)
 {
 	struct mock_iommu_device *mock_iommu = container_of(
 		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 25ac08fbb52a..d1f80a03e3dc 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -84,7 +84,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	 */
 	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
 
-	rc = ops->viommu_init(viommu, hwpt_paging->common.domain);
+	rc = ops->viommu_init(viommu, hwpt_paging->common.domain, NULL);
 	if (rc)
 		goto out_put_hwpt;
 
-- 
2.43.0


