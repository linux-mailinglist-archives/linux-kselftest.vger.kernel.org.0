Return-Path: <linux-kselftest+bounces-35896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 676D1AEA6AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD193AD5DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB882F2C76;
	Thu, 26 Jun 2025 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mf1+rV9U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818BE2F272A;
	Thu, 26 Jun 2025 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966541; cv=fail; b=NyAy0Sy5EY+/GJ6ZvuV0OWNoRKMJ7WHKJqMcV/gF+pXq762+bQf9Cqltal0yT1X6fMtD7Jj9dL/u3kTXOTOjirYZ90THJtr3WRJdanz36qWqV5ZY2eal8shfQewu7sXoJskYjQc19Nlg0KZhNNeUqNtV/3WReIXlDQcBTzw+Rok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966541; c=relaxed/simple;
	bh=xtgOta9W+ACqgtXngaPajMS9RIw88Si3sBl21lue4Bc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvOoziQMnLkxeX341Xa03Yk/X3ckUTRuW73T8LTdahIx7x4ivUSqy3ViTKvmmlvE71XNNPfH0MCHcsDbQJWW1mY2orvHcqyCkoUNrtBf8gYGEnH4nKZftOh6KIwEPgmturqng6BgU3Rb8L1c3+2gYzWxsaF3KbPyuE+3bSiTxP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mf1+rV9U; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4V5c3FHJ/wGl14PS+efc2AN4cZE77z4rWAita8Lz3Nlg42W6xsEY8JY4q8W4rxYjD05kLRhlhax5KXje+EnmPHGd3aytpAD/sN7RGCrC8JjCWh5FyLWJ0TOIpyQtE9S/IyR63MMUTTTAGCJXumebo1kLeLjxcrIranHO0TaYvJK2t+Npe+SnMwzOuL4bTkPGkyWY6Z3SSxDPu2QOlO/QeObhgj0HeoY1CObcaPBzhJz57Ye8mgoMcCMwjP4jN5Ybf+MwAeoZekx6SOn0/Qp6dCXfDlD8gldDiAbx5Rhchak7nSM5EsOb1+VIdSQJqz9ZJSxGXsYbfICtopA7hFWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPX5OLpcfsjCdI3t+nTw3w4HEXttKkhit5rWu1qXvCQ=;
 b=IMEqvUgGhKrbNyQKMuJxXhkOIscM56HXy7iqwiIoIIvJYHBvO6SmoD0J7mChuiMLLMJT/Vf2n8kXoiohHBvLmXW5GCVgyIk1VbIhjcS+2okl2lLSx+YAA4ap5QlWI7RlfzEJnHQwZjWP+9N5Qoi7NK06SXM3gV2e1LWzOodqyFs75CO6UBU+k2dsEemImweHxYL1MyhOUhDl89t98Q6ksGM34ZIPgjeIj6K/UAQzJqp5ZnT2cAH504fn6BQHHAqLhH30Uwm8VxBhQlNtJ5uq/eBVG3k9h7Llxu3mMKiCDFSFvVG3YR4xB4Dq1zTUfEELiibYxrwZiMQdufhvDBS9/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPX5OLpcfsjCdI3t+nTw3w4HEXttKkhit5rWu1qXvCQ=;
 b=Mf1+rV9UhOF714SFsxLGnrrxrYKYDE0KyucTTnaq4jC5pec2V5nvsEO2uOREXCvRITZNkhHRotpJ2MT7Ho29xbsJ9wL90tar7Kur74LnWoAR5u2Jvqfo+ZGaTB6NhxDqv5AaWR8utri31MIAvU3HkkMNiPAGP84ZaEFyyuPorXiHHRDboSds03nAWFxM5F/aJAS9bbMjBoSParxQXmSOZsZLBXzvgUHOe+mJxRdvcMqFvMfPRGqzdsq83daLAtyrYREWsXZzljX+jr7fuafbBcoRylTYy2bF62Fo+mOOidiHcBae9FyrfoYc51zYEClH35488ud2EQb7uxD0feIZPA==
Received: from LV3P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::35)
 by SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 26 Jun
 2025 19:35:31 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::ba) by LV3P220CA0025.outlook.office365.com
 (2603:10b6:408:234::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 19:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:16 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:14 -0700
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
Subject: [PATCH v7 07/28] iommufd/selftest: Support user_data in mock_viommu_alloc
Date: Thu, 26 Jun 2025 12:34:38 -0700
Message-ID: <c99b5d4bc76d0c36955641ee795df1e32a46202d.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SA1PR12MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9b4153-cac4-40f0-f358-08ddb4e89d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rcih9c8KdFoBe+JDfNw8InCm++XhEW+HoGWnmDg1OSHwXLYOCVnI+SVwBGD9?=
 =?us-ascii?Q?pTrwagq80KlFgtJUqeIcyUk2s3f2tHkfpnykGlCplT6Q1vAbb1MNcoJ54x8V?=
 =?us-ascii?Q?aZZq4vXXP9hqcFypaC7t4gn0cIHVi+PdX1zn99h13GCT3qhGrWXjED9sjRbq?=
 =?us-ascii?Q?r0VXwMCU3y4vT63klCWp7Dr9KRlXbvKfxGdd5JPNoWXl+P4g5MiS+kzSUcJI?=
 =?us-ascii?Q?6BetX+6NslwtxM+x+7CvDvSRmxIrLTWeDceXwoxBxuAFjP3C2iJ6gFtLbE3f?=
 =?us-ascii?Q?fy5WRKZ0SebT06xuuocqU247NX9bCqmzwuuYn0IDQu/EF5w2rDN+/f8t2XTS?=
 =?us-ascii?Q?lFeuBi3ecg5CmV9+nik/+iITSTK3RJXvk0Z7DHJF4eiOZDzcYBJcqxu9goJP?=
 =?us-ascii?Q?ZPW/u2GIFL+xUd4J/5YaieBZ1UWGGcfAbyTkXTcdxJHPZISzWwBXFclHi6Hb?=
 =?us-ascii?Q?NRGNPPrThqLeiuHaLicBTz2u+JhDP7PNg/Z9zin1O6SgsjHk3pShWkQ6d1k4?=
 =?us-ascii?Q?Wu2cSrt77mf82WK1EK3+ZI+rqN0IsUtOiikxPYwwiX5k/bwPj/BfoIs7Elqb?=
 =?us-ascii?Q?aXfhoacS3Q6c9FJqAe/vJvy9Fgi659MsIOJgd9jmVPkBUkM0DmDFYVRzqK+6?=
 =?us-ascii?Q?ZgXSd1GR/k1QgcNHsrTl6uzrmxVHvZZFJTcka0E1uHKCfZFuZJCqlOoA50/7?=
 =?us-ascii?Q?H5ZxsX1WtoRW9rJPL7B5cMmu1CQ5LHO8F0GmVIYGQCC2PxSgzHB6PGBYeAtb?=
 =?us-ascii?Q?kwGNHd93r8Hl4CljpcC5Gu5aBxifFw8B2BvEstp1Z6mcX6gKu4rSubGYQSYs?=
 =?us-ascii?Q?GtvckB9ZEBew4C82EwRT4kKvp+YbUU7mfH7adVxqCLvffbh62vP+1MlJ5Gpe?=
 =?us-ascii?Q?rdvn0IwJhY7giaJfkveYZsHd5MwKMHkU0CL1ZopR9ihTcV4QJ9TOQCuS+xxB?=
 =?us-ascii?Q?3jK6PJixICRihE+M2Wg/oqUOSdjUF610uV/xu6OGAj8YlF9wkrwqXmfoOPGb?=
 =?us-ascii?Q?9NbOEHuv2nkiMIlB+/iWgVC+SzuCWJCZPNauuryE+7Z7iGox7nIUW6W2m5qd?=
 =?us-ascii?Q?rg/tFw7LD5X0QGBPP6WG8YiUrkgbpSRF6/YWBhJOzYXgMAZV4AxwIHcGjt8i?=
 =?us-ascii?Q?GRIdg38eLgSlSfBT6F/WUGlyC6Q9b/P5HIBQDzm4bMGahjJvGL7p2QB18azb?=
 =?us-ascii?Q?H3RBW0Eu4sX7yPlce0SDUv50IOrR3qe3xTi7ozq6wBpyS3jkFensNR20CT/O?=
 =?us-ascii?Q?oIxUXIAknbqR0LfxmBDpKn/axjUHixGhPCFEDy/ZqlIk2W/0+ZXJ0IKKBp/B?=
 =?us-ascii?Q?6XQ12KM+ts0ipoYrMARQMp8UFNQU3C+cibKaVSt3j9KFEKM5TiVDEcJOrmS5?=
 =?us-ascii?Q?YqhANjurUAkdnj7L8vwGYdcEJNNQnr0lMDNpFzUpDLL/B5T7Qs6CBaBsYaqC?=
 =?us-ascii?Q?43kirr8AVVXZLNVPv5cqyOc0epSddZD2pY/wI5Qj/u57jOuf79ZkRzkjuMiO?=
 =?us-ascii?Q?peGXZcJi+y377x/fO03d7NkiAeOOIErhTrP4?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:31.4146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9b4153-cac4-40f0-f358-08ddb4e89d01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9491

Add a simple user_data for an input-to-output loopback test.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 13 +++++++++++++
 drivers/iommu/iommufd/selftest.c     | 15 +++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 1cd7e8394129..fbf9ecb35a13 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -227,6 +227,19 @@ struct iommu_hwpt_invalidate_selftest {
 
 #define IOMMU_VIOMMU_TYPE_SELFTEST 0xdeadbeef
 
+/**
+ * struct iommu_viommu_selftest - vIOMMU data for Mock driver
+ *                                (IOMMU_VIOMMU_TYPE_SELFTEST)
+ * @in_data: Input random data from user space
+ * @out_data: Output data (matching @in_data) to user space
+ *
+ * Simply set @out_data=@in_data for a loopback test
+ */
+struct iommu_viommu_selftest {
+	__u32 in_data;
+	__u32 out_data;
+};
+
 /* Should not be equal to any defined value in enum iommu_viommu_invalidate_data_type */
 #define IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST 0xdeadbeef
 #define IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST_INVALID 0xdadbeef
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 0d896a89ace7..38066dfeb2e7 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -784,6 +784,21 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 {
 	struct mock_iommu_device *mock_iommu = container_of(
 		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
+	struct iommu_viommu_selftest data;
+	int rc;
+
+	if (user_data) {
+		rc = iommu_copy_struct_from_user(
+			&data, user_data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
+		if (rc)
+			return rc;
+
+		data.out_data = data.in_data;
+		rc = iommu_copy_struct_to_user(
+			user_data, &data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
+		if (rc)
+			return rc;
+	}
 
 	refcount_inc(&mock_iommu->users);
 	viommu->ops = &mock_viommu_ops;
-- 
2.43.0


