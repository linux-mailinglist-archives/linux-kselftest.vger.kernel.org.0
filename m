Return-Path: <linux-kselftest+bounces-34982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D20FBAD9AAD
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBF93BA207
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBD71FDE39;
	Sat, 14 Jun 2025 07:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HrVDjWbA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFB35FDA7;
	Sat, 14 Jun 2025 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885327; cv=fail; b=EEjkIgYa4OdTebkm062JOxJobh8nYeBEXRDyqLgdW2JLICyxo3BO+AcrOgO8KfbBSvkKgSQ0QTwOjHrWcjF2cz0FRmu1sm1v51Kt8uoEKLwZ7d5eH0KefoleAbQkw/VuSlkHozFdp9KlKbrrMByvZfILGtFbpfgcRrZ7egoJuUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885327; c=relaxed/simple;
	bh=UG5HZwyqA8WM6b+RJk0ftQq5gc21Eu58pJRV1u8S9kY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emGnsEMCxZoOCME2jb0hR8ka7gHQgfRGqK/J3TxMz8CEnSNdzNXKyaLbauxOUuFPXt87242MLi6vn1pwVtEJylbf6luuquVNx7KCn+VpFCb4ZeWTiIPN+rtbyxuW+nkU1SNhC18SAsdXVr4NYxeFJBVhn4xqSX0gpmCfaJqpN8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HrVDjWbA; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lpye7l5qzjcSvKXJ3MPB/U2ELJXrNvrNLUJ1Drv1F6Xv0INOTF2+1R4Kvf3DcTVis+7JoyYcWEhsvt49OPD1oGmhWV64QcaZw0eDDi/V4SZE30x07DP6pmDyCmaeAKvikmCkVZWlfkmWXrIK4DVuVnByrV/CQvP+Ww6yeSq2faI2nDtKKylRof16adka4jVfIwD6sCIRUB+NHQYH36GojfMuN4bSowtzZcDpoRUnFOCMvwv9rjQ6E9/rhUCfiMnyS9+ybMemhYUG9UGBxp5yMhprJADXQzOOmXUnLSbiQ4g3kcGsDwdFxPotbvX7Jqgk+x5O8B8/NQMHxpS41RWUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5GleiIACVsae32T7Z8cMfQLMmYhdsNmrJhP4lHynJA=;
 b=WMMbPK0gUps03ilTJFi0pjVTCQOUwxhgkYMjBz05fEmiuuodOPqagMTlteze7eA4/sdM+eFLXWA65C/Bbhve33EbhZoyPSYMR6+pDXuEeg5l8Tvf8BUcuZCXxn9i2/7TsV6fK+vksa/Ypxw0XWzFTIN559IuIWESV2s4++XR6UR97e66UUDPzWmNbLZKDwwUH7XYYj5hU51WQ/WAHyuIuGQATcdLYiZT2Yd08ekCnR6znu3C8b0hBWnojXB2JoxsXL6cTXODKsmyODqgGNlfOUkE7FC/aRR2suoPmC3KijJa+KSqyLFIPcc+ARGgFYiIZJK+W9YAhdXp78rtIqvldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5GleiIACVsae32T7Z8cMfQLMmYhdsNmrJhP4lHynJA=;
 b=HrVDjWbA6uRHwop2kyoTiEiuZnf/roHd32yr2g+NYyboOSOIG7FaAcqPw78PJX1nebSsrNxSplWo7z+Sgsoe4TE35Fi6iVqHeDaNN9/gYDATudtqX65h48qUTSz9rcuFi4k4aTvmhuakqtCVDtKX2NpLGEJD2Pau9WKZQGwmV8/+Za/d7J0oatKXrDMunwGOdYUhg533likdObJI56qnWBCLKI45YWkc2iFuJmkqUyef20iRgFo/yy9hVVOMrn+cymso3YuvAWp31372b6rafcZquHl73lK/v19voRHygocBu+19POpywY9JPbiu8DQt/6LpDMWoz+rPqE49J74tYg==
Received: from SJ0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:33b::28)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Sat, 14 Jun
 2025 07:15:19 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::cc) by SJ0PR05CA0023.outlook.office365.com
 (2603:10b6:a03:33b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.16 via Frontend Transport; Sat,
 14 Jun 2025 07:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:03 -0700
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
Subject: [PATCH v6 05/25] iommufd/selftest: Add coverage for viommu data
Date: Sat, 14 Jun 2025 00:14:30 -0700
Message-ID: <aee1595910a4868f5b7ff1ceba0e5a0821f91ede.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|SA0PR12MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: 58023b79-7b44-4039-d2fe-08ddab13387d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eTNT3rcbKsf3llq8dYGQSgMcl/Jrx2pqqb3U4m/Wb84XMKS2NFCWEuvTqqrP?=
 =?us-ascii?Q?P2+p84jUGVrqSg6IwPSI237yATuOCectYb/A2itAVyMRtme5Ikd3At+ZLaaP?=
 =?us-ascii?Q?Nx09gOK0PJURiHbQvfrjZSO5pIXDrb/d5whC32Th/2MHl/gJ1ovZHmCmFAJk?=
 =?us-ascii?Q?MgkfllbaOKLuLe80fsV2+cJJOo7/G47ICXJKL/17Z7FikGUJ+2Jk9miPg92u?=
 =?us-ascii?Q?z3rjQld+rssY6ansdVgGyX76YRzxriwE6MgYikO1ShdnTS2EhuFGyXpPr4J5?=
 =?us-ascii?Q?urVadlXL5w3YqBpLg6bjwTZv6zh6rsHGWDOTFr1uOppWw9O7cYU7gyxUpgrT?=
 =?us-ascii?Q?mFCvdRpWKaqqN5Yx2BglFkNxuFICowd7c/NkvqSWBUzV6sk5HdyPmW94fGcO?=
 =?us-ascii?Q?dkKyhFQWTCXgl2/n26i7mrsnzdvxqOVEQHBEl055ntOQ+xa4wyhqu6waxXqW?=
 =?us-ascii?Q?5MyjJElQv5+Eg6wcW63B/LLxZkr/nkGLtIh7fcio+U9oo7M8ZNqwhQub71gP?=
 =?us-ascii?Q?qG8Zy5aD6/phLzKWjyBytS4BMTUjvrHBvjr1PFqwvwpRTME1MGmJG3lbSk/U?=
 =?us-ascii?Q?Oe/7KiTVm3P48wG0jpZQcpzAmrqWbs52kpB0kwMWsRdhC7fjdLxexANFLtSY?=
 =?us-ascii?Q?3Fx+Jq1bvh8xCT23Sr3YFnffNajlPG9fSGkmCx70drh73S3X9rDx1HsVQLh8?=
 =?us-ascii?Q?ukFbTU2b1Over/G3h7ppyFjco8+Vi3iLZsGeKf96it/vaArsctBEIuF4eDNK?=
 =?us-ascii?Q?+tkq/g11vqYblUmitmr+9wLmwnQpCJWwVROZeVhLMfSJr7GM8+R2CPz5sak1?=
 =?us-ascii?Q?a4tCo/U5A0g1/SyrM5KV2jiuayRox0wLa/p3/zH35s9OYXM4bfrX3EfYsxCE?=
 =?us-ascii?Q?No8jW9Ush4OpU0fJ56DH9TmHyXcWFiqLj7LCSFfFzlLMWx4FIdMHGp3CCvfn?=
 =?us-ascii?Q?i/8y04oVGESCDChtjAje0Lzw/HG2kNNlfjkGdlWUih/75nIXIs44fiNhcdoj?=
 =?us-ascii?Q?anftCs/wVg42LGHYCAhXK8qBOYdHl46AKEa35YrCnSB3GGQorGknvmzwP1XF?=
 =?us-ascii?Q?243CVvFqEdlTnA5WqOABDuvO9GojzA4Dx3JyPdCaBB9RUD3+R2z0c6ZsSj9G?=
 =?us-ascii?Q?S0b9IPZS0hExhHvvWVHzvhQYpmomRUZsh13lIDGfMfDn4cq6DROUGqYTSkbj?=
 =?us-ascii?Q?g7DkELTMLbF81cmOQOhXM3ogJHfuyk6CqC6r8gr+rMQWZZfAPWABySSmnNLq?=
 =?us-ascii?Q?opm9E73c1AnlC0Hkrp6MqVrCDQNvDt71ilHhTZTH+QawqrVE1dtC3V7yfRQo?=
 =?us-ascii?Q?wTd0zwDVLJf0Lrg5fetRasorcBI5+Dstg9a14rT7SJkeLcanRHbmC1KWgXjs?=
 =?us-ascii?Q?Bvw+bPQ/oh42CwDbH7KTBBRJ0ffFfVDXPB985UrA4mGqw64jfDacoeF0VX27?=
 =?us-ascii?Q?oNvTyAumyoKxzC+Pakr+gTulcYlHuZs1v/zUIR5pCQw+KvmS5ElSbgciGQIx?=
 =?us-ascii?Q?5H5XiDAkW/ibqCYOHx3e0IxYCuUa/jGCSx4Q?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:19.6062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58023b79-7b44-4039-d2fe-08ddab13387d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447

Extend the existing test_cmd/err_viommu_alloc helpers to accept optional
user data. And add a TEST_F for a loopback test.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 21 ++++++++-----
 tools/testing/selftests/iommu/iommufd.c       | 30 ++++++++++++++-----
 .../selftests/iommu/iommufd_fail_nth.c        |  5 ++--
 3 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 72f6636e5d90..a5d4cbd089ba 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -897,7 +897,8 @@ static int _test_cmd_trigger_iopf(int fd, __u32 device_id, __u32 pasid,
 					    pasid, fault_fd))
 
 static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
-				  __u32 type, __u32 flags, __u32 *viommu_id)
+				  __u32 flags, __u32 type, void *data,
+				  __u32 data_len, __u32 *viommu_id)
 {
 	struct iommu_viommu_alloc cmd = {
 		.size = sizeof(cmd),
@@ -905,6 +906,8 @@ static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
 		.type = type,
 		.dev_id = device_id,
 		.hwpt_id = hwpt_id,
+		.data_uptr = (uint64_t)data,
+		.data_len = data_len,
 	};
 	int ret;
 
@@ -916,13 +919,15 @@ static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
 	return 0;
 }
 
-#define test_cmd_viommu_alloc(device_id, hwpt_id, type, viommu_id)        \
-	ASSERT_EQ(0, _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id, \
-					    type, 0, viommu_id))
-#define test_err_viommu_alloc(_errno, device_id, hwpt_id, type, viommu_id) \
-	EXPECT_ERRNO(_errno,                                               \
-		     _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id,  \
-					    type, 0, viommu_id))
+#define test_cmd_viommu_alloc(device_id, hwpt_id, type, data, data_len,      \
+			      viommu_id)                                     \
+	ASSERT_EQ(0, _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id, 0, \
+					    type, data, data_len, viommu_id))
+#define test_err_viommu_alloc(_errno, device_id, hwpt_id, type, data,        \
+			      data_len, viommu_id)                           \
+	EXPECT_ERRNO(_errno,                                                 \
+		     _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id, 0, \
+					    type, data, data_len, viommu_id))
 
 static int _test_cmd_vdevice_alloc(int fd, __u32 viommu_id, __u32 idev_id,
 				   __u64 virt_id, __u32 *vdev_id)
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 1a8e85afe9aa..f22388dfacad 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2688,7 +2688,7 @@ FIXTURE_SETUP(iommufd_viommu)
 
 		/* Allocate a vIOMMU taking refcount of the parent hwpt */
 		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
-				      IOMMU_VIOMMU_TYPE_SELFTEST,
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
 				      &self->viommu_id);
 
 		/* Allocate a regular nested hwpt */
@@ -2727,24 +2727,27 @@ TEST_F(iommufd_viommu, viommu_negative_tests)
 	if (self->device_id) {
 		/* Negative test -- invalid hwpt (hwpt_id=0) */
 		test_err_viommu_alloc(ENOENT, device_id, 0,
-				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
+				      NULL);
 
 		/* Negative test -- not a nesting parent hwpt */
 		test_cmd_hwpt_alloc(device_id, ioas_id, 0, &hwpt_id);
 		test_err_viommu_alloc(EINVAL, device_id, hwpt_id,
-				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
+				      NULL);
 		test_ioctl_destroy(hwpt_id);
 
 		/* Negative test -- unsupported viommu type */
 		test_err_viommu_alloc(EOPNOTSUPP, device_id, self->hwpt_id,
-				      0xdead, NULL);
+				      0xdead, NULL, 0, NULL);
 		EXPECT_ERRNO(EBUSY,
 			     _test_ioctl_destroy(self->fd, self->hwpt_id));
 		EXPECT_ERRNO(EBUSY,
 			     _test_ioctl_destroy(self->fd, self->viommu_id));
 	} else {
 		test_err_viommu_alloc(ENOENT, self->device_id, self->hwpt_id,
-				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
+				      NULL);
 	}
 }
 
@@ -2791,6 +2794,20 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
 	}
 }
 
+TEST_F(iommufd_viommu, viommu_alloc_with_data)
+{
+	struct iommu_viommu_selftest data = {
+		.in_data = 0xbeef,
+	};
+
+	if (self->device_id) {
+		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
+				      IOMMU_VIOMMU_TYPE_SELFTEST, &data,
+				      sizeof(data), &self->viommu_id);
+		ASSERT_EQ(data.out_data, data.in_data);
+	}
+}
+
 TEST_F(iommufd_viommu, vdevice_alloc)
 {
 	uint32_t viommu_id = self->viommu_id;
@@ -3105,8 +3122,7 @@ TEST_F(iommufd_device_pasid, pasid_attach)
 
 	/* Allocate a regular nested hwpt based on viommu */
 	test_cmd_viommu_alloc(self->device_id, parent_hwpt_id,
-			      IOMMU_VIOMMU_TYPE_SELFTEST,
-			      &viommu_id);
+			      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0, &viommu_id);
 	test_cmd_hwpt_alloc_nested(self->device_id, viommu_id,
 				   IOMMU_HWPT_ALLOC_PASID,
 				   &nested_hwpt_id[2],
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index e11ec4b121fc..f7ccf1822108 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -688,8 +688,9 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 				 IOMMU_HWPT_DATA_NONE, 0, 0))
 		return -1;
 
-	if (_test_cmd_viommu_alloc(self->fd, idev_id, hwpt_id,
-				   IOMMU_VIOMMU_TYPE_SELFTEST, 0, &viommu_id))
+	if (_test_cmd_viommu_alloc(self->fd, idev_id, hwpt_id, 0,
+				   IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
+				   &viommu_id))
 		return -1;
 
 	if (_test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id, 0, &vdev_id))
-- 
2.43.0


