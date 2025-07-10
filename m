Return-Path: <linux-kselftest+bounces-36926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C113DAFF928
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7A817BBFA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5070E291142;
	Thu, 10 Jul 2025 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lZWjY4C5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20DF28DB56;
	Thu, 10 Jul 2025 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127253; cv=fail; b=klQU0X4+skHKnKYMZ8r3RPYg6U4RS1i6EDvziwPTXsyRQmhUQwdWV0cMV+ovqZ4SsJIqSHV+Z+kOrF1HA4eAUr/LyaVR8AovX8m8XYKCeCRMW+tHEmiueAFdAkxoWd5XVXu+QsCBoMV7CtWHppKA0cK9GRAUcshQincIUF2xAyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127253; c=relaxed/simple;
	bh=+GdMHej0X5AEB0V5uPxtFLhXO6m1cWOOWJPcuVFot9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYvGkhzMQsJBcnGlUAYpY+4vteSIbF87SjjkANmul+A/OBSAafw2KMCCPFeyKblYoFxYVUdpzFh6fzyJDykmjN/DCXK/skVH1cbbcDdS63KVXiZFgfTf2HvR/5jeY4SAlwAgzxGmTp0p42dcuthJOx6/M2Tznz9u3ivlU0ruhA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lZWjY4C5; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEBx15aAUD6ldkHWnpZ4X75OXm4DxK+ngoxbngAaTnOxGC4+V0kqQnh2Unc9tiUc5w7DyuhZX6rSHi9GI8342Srh9JufrNaAiroNGwPFFaLdbP3JuJK07Ug8qq3kNonvg2nvLd5/qJrOfwV+ggk/T9xWVui1macCu09n1nqYYV1ACR4Zn8EqWdKT02A5RV1iOkc3M4qnKsGYEKNZB0Hp9X4g1/kRjooKmocfN279iCfYQI+EI1u6u8UP85DZP59IaD17uVpLa3eXl0dfRPetq402n46GWvj1/yV5vNy0ej3HyARMGhnMJipn6SEjTXKSBOg1lTSUjKARkO5ZSh/pIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkcDbU+o7rz2chpDOlJdgUJ3V7KpoLSApTwWZ5Xu46o=;
 b=lGvB1ptsscHFlFn+G2uX5qL1RW1D4eTyJgvF9GQ84f8q05AnpwDSYrYLanzylTpAJzPWZCKR17bm1LIQuz37TPEhlUsAZKQBPQgB93MU/PlFqMQyZ4jpKkOe3D4sUt+wosU/67Pb8OIdnd7Oj0oORDmH0aR/gDgEVTUkmkC7vt1/Ioe6+lbmv9fyRaBYyItYJRSLZ/h31d/iAuF892LsVUWCb4w+NQ1oYCE+7OUeMHBkmURP5LNrOoehi2M28hp5TyQIKL/nibnWnUMrFPci1Oul+4zvMZkWUB3nzp67rFgBwcdR8gr+1rAlRJgumEN7LrX8fjSPz2BJvSK9iDIRsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkcDbU+o7rz2chpDOlJdgUJ3V7KpoLSApTwWZ5Xu46o=;
 b=lZWjY4C5MmvTEcB6FQVaGVlAlxQ1uPt1G6TF4aLfuA6pXJimlxguZ6YYFcxOS1pzkrWhTtwhe3ItdHZ+E8MS3g2Zc0l6Erwef8Sbwc0NhFEghGDimQjJTmt1W4Ub2lSiZzTEvOsA1hPLJVFAtNtpKS5VIW4g0n/ny2VQHgLhgkyIP5XRjoGw9BkS3i7J3ZoHkw5abTre2Gy2R2VvHUCAplaqXF5bFTalFzM+YWmM8lP7hwVjDn7sLYVoT8geZVMvnmUgjy9qrAP0TVKcvO8dnmtZaY5vykZZ0nmCQ6J1Jejh1vk/Si3Kb8ubKzniZsr3HX6JsLMT2EiiU9WqnQ4vNw==
Received: from CH0PR04CA0055.namprd04.prod.outlook.com (2603:10b6:610:77::30)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 06:00:45 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::f8) by CH0PR04CA0055.outlook.office365.com
 (2603:10b6:610:77::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:45 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:27 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v9 22/29] iommufd/selftest: Update hw_info coverage for an input data_type
Date: Wed, 9 Jul 2025 22:59:14 -0700
Message-ID: <f01a1e50cd7366f217cbf192ad0b2b79e0eb89f0.1752126748.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752126748.git.nicolinc@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d47ff0-8353-40bd-d1cb-08ddbf771c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JT3pSFwKqRaPT1Vz5vDOGKhxx1m6fIKjIelT1o/Fna/zoB74v8icHPwq7pUm?=
 =?us-ascii?Q?ENM9xewcWmAMKvPHBHEPZtprdkOIAonirHWUqhcclNqnpBKdVZCY9qD8a0n4?=
 =?us-ascii?Q?jH+pXa1+xAPsMzspnKiwWzhv9VNqmbkDonZglLw/t9lCinhdZaMZ2LIPT+AL?=
 =?us-ascii?Q?8MU5Btet72dJXIOYu2iSjO1o6rR0FlkCucTEpltd4FEnjC9Ys5SAZYZf3eDh?=
 =?us-ascii?Q?j6ICGhlwu6AcHZXKjZbVh21hJlbEzpG7OlwK2+7Qaj8iT6IrgEsEvAi/zsOH?=
 =?us-ascii?Q?pZ9DLh5Dwgr5efugr9mUv/Ae3Y18cEuUT6o/l6ryuoGXlhqU4XrxMHatJIS7?=
 =?us-ascii?Q?P6PHuur6YfWzIbumyDXcYWwJbk69je+6+TjSuGZEd3ARq1Drk7CZCEXilOJc?=
 =?us-ascii?Q?XIdTQHkk+pFEKZImZ5r7mPYqSelvKHUcvjDvY8KIokNE8ZnT4mwcMk4H+fJz?=
 =?us-ascii?Q?rTt9ryDlIU5YiYRm2sGeCqhSWlL7BB27JpxFyayK1fGJej4hofUXtbM9VeRV?=
 =?us-ascii?Q?JRchdOtM4eqzb8w7/ct5RD1aUW5XlX2hNMdge4l34/ZPz8n1yN7Ik26MX6z8?=
 =?us-ascii?Q?jl5mfyiTiKvlVHmi+1D2Rk7kxgYsofwEavOsg4h/4OOQA6HVLcCIjALeYjDW?=
 =?us-ascii?Q?68051YebNZXZH8BDXGiXiUFU/QolP1c9d2KIERNUy9rbPRcIdxjoqh8Abbe5?=
 =?us-ascii?Q?dMjkzIpYKAV838Cx3R9XX/QFcuIvwP09eXgkw3QXtHTwoJGrjKD9YrSdfTBb?=
 =?us-ascii?Q?A4wrReXCvZeAQUlMMzWvvfaDjzm0LxWaJGev4vQBHeCgiCgS/n0RgV0ELNfD?=
 =?us-ascii?Q?sgQNx17zjugzDB4KkWo8048OlLvSvbCXdxI/vfm+rAtrY25X0ZCi7kKVuKa4?=
 =?us-ascii?Q?4aMHWMd0reJAG8TCzXAmoO8rgkU+RksXLkPmdeotXbm+I7ae2VfWdDPxoMPQ?=
 =?us-ascii?Q?E+3eAOwlVwsGEOhvFKpj2nrF5WhiNuU+VHOcnOFkplhvb6fexNoFdhqnAcVl?=
 =?us-ascii?Q?rSYlyVK2c9YKw5el9eGPKJRNf00PlSQQEu8UUivcnOvYh6qh+3agiKLx+bKU?=
 =?us-ascii?Q?xvJgZ+TZPzSBdd4U+twSDJDE0cffy+eRYwzBe98FyBwLUjX5KN2ZsBa7RJ1V?=
 =?us-ascii?Q?q/jyv0l8YFhDVYgK02Dk6Cw7lS/BlXk5OnRjhLA89d0Sey9+SOR7VF3K0dCJ?=
 =?us-ascii?Q?TH2VDRVB3RnFN62TMfnklOt829KkSWpiDWmWrQtwXbYwIpDK/E0KHqOjxIq4?=
 =?us-ascii?Q?Y39V65XRlZhznJY2EhX/AJ1jNVxLx19L+JZ3ATaLycbHduci1LVw7mcdjB51?=
 =?us-ascii?Q?JJ/iIae5sUha0HcEqeBUwVjoRvrf9lkiPKu4khHitrK4qplZVHxRU3DvGt8Z?=
 =?us-ascii?Q?ODVkz2sYnntQh9ev4sFSdXL3+vp/g1xrtFqtKKMoJ04Uecc5+Oqk/4tRtxUS?=
 =?us-ascii?Q?+fzjU371ocJcHhZXTIV4rKj8gacnMACnlOvrvBPmvaUesGkfbHUvloeCaBCr?=
 =?us-ascii?Q?FBwBe9/WcFIMjJqpIpim7fiVg9tPi96zhrBx?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:45.1386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d47ff0-8353-40bd-d1cb-08ddbf771c4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061

Test both IOMMU_HW_INFO_TYPE_DEFAULT and IOMMU_HW_INFO_TYPE_SELFTEST, and
add a negative test for an unsupported type.

Also drop the unused mask in test_cmd_get_hw_capabilities() as checkpatch
is complaining.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 33 +++++++++++--------
 tools/testing/selftests/iommu/iommufd.c       | 32 +++++++++++++-----
 .../selftests/iommu/iommufd_fail_nth.c        |  4 +--
 3 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 4a1b2bade018..5384852ce038 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -761,20 +761,24 @@ static void teardown_iommufd(int fd, struct __test_metadata *_metadata)
 #endif
 
 /* @data can be NULL */
-static int _test_cmd_get_hw_info(int fd, __u32 device_id, void *data,
-				 size_t data_len, uint32_t *capabilities,
-				 uint8_t *max_pasid)
+static int _test_cmd_get_hw_info(int fd, __u32 device_id, __u32 data_type,
+				 void *data, size_t data_len,
+				 uint32_t *capabilities, uint8_t *max_pasid)
 {
 	struct iommu_test_hw_info *info = (struct iommu_test_hw_info *)data;
 	struct iommu_hw_info cmd = {
 		.size = sizeof(cmd),
 		.dev_id = device_id,
 		.data_len = data_len,
+		.in_data_type = data_type,
 		.data_uptr = (uint64_t)data,
 		.out_capabilities = 0,
 	};
 	int ret;
 
+	if (data_type != IOMMU_HW_INFO_TYPE_DEFAULT)
+		cmd.flags |= IOMMU_HW_INFO_FLAG_INPUT_TYPE;
+
 	ret = ioctl(fd, IOMMU_GET_HW_INFO, &cmd);
 	if (ret)
 		return ret;
@@ -817,20 +821,23 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id, void *data,
 	return 0;
 }
 
-#define test_cmd_get_hw_info(device_id, data, data_len)               \
-	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id, data, \
-					   data_len, NULL, NULL))
+#define test_cmd_get_hw_info(device_id, data_type, data, data_len)         \
+	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id, data_type, \
+					   data, data_len, NULL, NULL))
 
-#define test_err_get_hw_info(_errno, device_id, data, data_len)               \
-	EXPECT_ERRNO(_errno, _test_cmd_get_hw_info(self->fd, device_id, data, \
-						   data_len, NULL, NULL))
+#define test_err_get_hw_info(_errno, device_id, data_type, data, data_len) \
+	EXPECT_ERRNO(_errno,                                               \
+		     _test_cmd_get_hw_info(self->fd, device_id, data_type, \
+					   data, data_len, NULL, NULL))
 
-#define test_cmd_get_hw_capabilities(device_id, caps, mask) \
-	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id, NULL, \
+#define test_cmd_get_hw_capabilities(device_id, caps)                        \
+	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id,              \
+					   IOMMU_HW_INFO_TYPE_DEFAULT, NULL, \
 					   0, &caps, NULL))
 
-#define test_cmd_get_hw_info_pasid(device_id, max_pasid)              \
-	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id, NULL, \
+#define test_cmd_get_hw_info_pasid(device_id, max_pasid)                     \
+	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id,              \
+					   IOMMU_HW_INFO_TYPE_DEFAULT, NULL, \
 					   0, NULL, max_pasid))
 
 static int _test_ioctl_fault_alloc(int fd, __u32 *fault_id, __u32 *fault_fd)
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 0b21c095ca5e..d59d48022a24 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -764,19 +764,34 @@ TEST_F(iommufd_ioas, get_hw_info)
 		uint8_t max_pasid = 0;
 
 		/* Provide a zero-size user_buffer */
-		test_cmd_get_hw_info(self->device_id, NULL, 0);
+		test_cmd_get_hw_info(self->device_id,
+				     IOMMU_HW_INFO_TYPE_DEFAULT, NULL, 0);
 		/* Provide a user_buffer with exact size */
-		test_cmd_get_hw_info(self->device_id, &buffer_exact, sizeof(buffer_exact));
+		test_cmd_get_hw_info(self->device_id,
+				     IOMMU_HW_INFO_TYPE_DEFAULT, &buffer_exact,
+				     sizeof(buffer_exact));
+
+		/* Request for a wrong data_type, and a correct one */
+		test_err_get_hw_info(EOPNOTSUPP, self->device_id,
+				     IOMMU_HW_INFO_TYPE_SELFTEST + 1,
+				     &buffer_exact, sizeof(buffer_exact));
+		test_cmd_get_hw_info(self->device_id,
+				     IOMMU_HW_INFO_TYPE_SELFTEST, &buffer_exact,
+				     sizeof(buffer_exact));
 		/*
 		 * Provide a user_buffer with size larger than the exact size to check if
 		 * kernel zero the trailing bytes.
 		 */
-		test_cmd_get_hw_info(self->device_id, &buffer_larger, sizeof(buffer_larger));
+		test_cmd_get_hw_info(self->device_id,
+				     IOMMU_HW_INFO_TYPE_DEFAULT, &buffer_larger,
+				     sizeof(buffer_larger));
 		/*
 		 * Provide a user_buffer with size smaller than the exact size to check if
 		 * the fields within the size range still gets updated.
 		 */
-		test_cmd_get_hw_info(self->device_id, &buffer_smaller, sizeof(buffer_smaller));
+		test_cmd_get_hw_info(self->device_id,
+				     IOMMU_HW_INFO_TYPE_DEFAULT,
+				     &buffer_smaller, sizeof(buffer_smaller));
 		test_cmd_get_hw_info_pasid(self->device_id, &max_pasid);
 		ASSERT_EQ(0, max_pasid);
 		if (variant->pasid_capable) {
@@ -786,9 +801,11 @@ TEST_F(iommufd_ioas, get_hw_info)
 		}
 	} else {
 		test_err_get_hw_info(ENOENT, self->device_id,
-				     &buffer_exact, sizeof(buffer_exact));
+				     IOMMU_HW_INFO_TYPE_DEFAULT, &buffer_exact,
+				     sizeof(buffer_exact));
 		test_err_get_hw_info(ENOENT, self->device_id,
-				     &buffer_larger, sizeof(buffer_larger));
+				     IOMMU_HW_INFO_TYPE_DEFAULT, &buffer_larger,
+				     sizeof(buffer_larger));
 	}
 }
 
@@ -2175,8 +2192,7 @@ TEST_F(iommufd_dirty_tracking, device_dirty_capability)
 
 	test_cmd_hwpt_alloc(self->idev_id, self->ioas_id, 0, &hwpt_id);
 	test_cmd_mock_domain(hwpt_id, &stddev_id, NULL, NULL);
-	test_cmd_get_hw_capabilities(self->idev_id, caps,
-				     IOMMU_HW_CAP_DIRTY_TRACKING);
+	test_cmd_get_hw_capabilities(self->idev_id, caps);
 	ASSERT_EQ(IOMMU_HW_CAP_DIRTY_TRACKING,
 		  caps & IOMMU_HW_CAP_DIRTY_TRACKING);
 
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 41c685bbd252..651fc9f13c08 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -667,8 +667,8 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 					&self->stdev_id, NULL, &idev_id))
 		return -1;
 
-	if (_test_cmd_get_hw_info(self->fd, idev_id, &info,
-				  sizeof(info), NULL, NULL))
+	if (_test_cmd_get_hw_info(self->fd, idev_id, IOMMU_HW_INFO_TYPE_DEFAULT,
+				  &info, sizeof(info), NULL, NULL))
 		return -1;
 
 	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0,
-- 
2.43.0


