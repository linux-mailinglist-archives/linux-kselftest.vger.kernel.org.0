Return-Path: <linux-kselftest+bounces-31679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F7BA9D7D4
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 08:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE489C49BC
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 05:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EC31F2361;
	Sat, 26 Apr 2025 05:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="STRFNJ4+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21631C4A20;
	Sat, 26 Apr 2025 05:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647150; cv=fail; b=PFjBjRGIh7wGndHJwGa/B60a8tARwAbMHIH5nhZoK83/uPM2VEtx4tAH1WJ7jqi1JKe3xst6bZPjG8SXVG68n89SWSr1Ew+pDPbKStz4Z0BX8F0AW0gbhlSrzUab1M/9h6p/7ox2Z6UEkKn7drw610uNdklplvLeifjOcLK09l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647150; c=relaxed/simple;
	bh=ih5xQfYNVNLcqyz7LAcUCbSseJwrZqm5wf+4Z/3I6d0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANkjY6Bk8C/HhRkhuhswK1/Q8bMjllraZrS7qRQdMprTQCBsOvVP7lvqx4r5D9ImVYULYqNgX8drC+XqM3Ctt8FAZRgHkG2g8UqZE45aEOHYAELz2wnPLDUR/zlOubRnV1qUWVCJ5F9g36FK8wl7ogf+TT/DYgUljuwFXIDFaWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=STRFNJ4+; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPCQpS3PmkIOMkHmmqaInmf93KufxOGhd9v2sdPTOBZxTMQzdpQLvjBFCX0X34EOSb8G2LjCAq+z3TVqH791qBcINkGz4WyuyOpPwVI0NkQAdIvPBr7Gnkd26aaQN1jKhMNvy8DenIN+EVGTBZVDQdEb821k5TqyBDjl0Hk6SqiFlZ4T191XZcHU/fbzaj9BrkR74+m4VfPJXdT2QNmbdtTeeoHe9dmNPCtaP0y+N26mjtq1909MxgaslP3w6ZwvsP//sTMLCdKn/Ou1fjGAWxCpzRnm+2kK3NA/6cuVZeWVRHAm5ialxiO1LilHme1732r0IZ5bL+ESHa/nhMgMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnlwdjnjsoFem4jnATOTWF4QhoR+5Xsj/mAgs7LBGBA=;
 b=Z12pjuei/okcKjbbVnABmmJU+qi/iJnFPEV2KUOjnF3b+JGBhnPRimDeepamv9+bN2fr9yedUcnhjmZ9zp7E4WQ6JA8TKTyBDDKQxqpB+FrnX1z6AzrSdOowwuA1NKTDW6UbQQ7fIZIJX1Mkv+8NTYRPJyf+Ua+GynlhVRHhnDuAPaXwXi3ga9Vo6ZJqv5wQD6Xh0yHTHDWF9QqytPnpiTgpAt6LGbK87egECYcJTE6Q7JuV+j8Y7qQxAS8Zq7rlz5XjfIoE1VEC3aRgp10WZ+J+4VKnEHomqEEVxLDuPuh7yR7clxJOycuKqjgUD237v8e6REZNOlxH8phHAR2kpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnlwdjnjsoFem4jnATOTWF4QhoR+5Xsj/mAgs7LBGBA=;
 b=STRFNJ4+K/IjGQ4sP0Wis3zMYO+2GF1G4HqDU4TTluhDkdukscab3CoM924uel3hhtZgF45erftmAeukQgrv7hm6osnIQ0W/HIHVDnBNLKnO0f5VCGpa48Guv1uCYVYdJMNRSJujTCv4NbLPm+HiuH/1rnwdgybV1oIJ0abGmZH4h4RsBdSbd98Kqj1TAd3Z6PMWAwGYTGzpcRRHgU+gBjFU7FQRZMAzfd+PniXahAChzXVVmGlFh1DCZl9OpTcmVfkuYwYTB2vJRoipDVYjv/DJR6YZHvEh1oVlcdXNje+X2YuYxZjMee2k/jA0KMSZx9DUjDXkfy66vrtKjHDdIw==
Received: from SA9PR13CA0048.namprd13.prod.outlook.com (2603:10b6:806:22::23)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Sat, 26 Apr
 2025 05:59:01 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::8d) by SA9PR13CA0048.outlook.office365.com
 (2603:10b6:806:22::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Sat,
 26 Apr 2025 05:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:59:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:58:54 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:58:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:58:51 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v2 07/22] iommufd/selftest: Add covearge for viommu data
Date: Fri, 25 Apr 2025 22:58:02 -0700
Message-ID: <acb47bf56f1b03df9f6fca26f511529354be3caa.1745646960.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745646960.git.nicolinc@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|PH7PR12MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: c6bd631c-e276-49c5-5b02-08dd8487712e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uv9XcJsRy1UtNmfd8KlVZsPOJbU3xpCtD4O4wEUeYC+41AO7VuUonkB4kyhi?=
 =?us-ascii?Q?wiuQ9W6k7owwBtXamByDofUoKjPYXA/S/vSBj0vVgr6VhgY7376zfyHXydfi?=
 =?us-ascii?Q?uAUo2eimLt4YKxdhQBhT9sRJ+oC06luKOB3Uut6HvoIju+MZIXEu9Wm5vmfe?=
 =?us-ascii?Q?soUhV0tivUpYH15DZ8OeREMbL+61kS42wmxRXmBT3PLFBAfvyaJqv38mkW5g?=
 =?us-ascii?Q?Y5KY85dx9ONvrxdszHlHCozWNjGo7mdR/1muZEKv5KzTcblzkltvsUpqKI9H?=
 =?us-ascii?Q?piWvbcRG48G9AUo0vvvauIgg4i3YZ/+0VBn/INdq0fp1qsUrvwb45kBRp6qN?=
 =?us-ascii?Q?tRFvVJxP2eF3klm7kCwc6p0Jeg52qikl4gh75P3y6MhB5Ou3DOOIC2OfU1fF?=
 =?us-ascii?Q?+sJYfuOizYgDRoSjKgFoDMc7pAcjyO/81XASSCs/T9BpmSjGFnhEAk8mUDuH?=
 =?us-ascii?Q?4cDtLorhM8mHUcqf1h7ZO5FkiFm1oH5Pn1K+ZJ5erXiqyFAxG/GXMNa+Lp5S?=
 =?us-ascii?Q?4QnAGRaRS9oJLRE6xiifvmHYeIDB9MgRCPNgCygoTitHQlV/RXh1TInuGhoi?=
 =?us-ascii?Q?fOyhnRG4toAZ2p96YgIUPBZwtU0LgdsBst6z8I4az2cJohY71Qe+a/AjB2L5?=
 =?us-ascii?Q?Phg/90vLJxU3MVod2jxUdZlmd/iP3VjIp5Wd3X2FnXm4HupxlV2pFdNXgYvB?=
 =?us-ascii?Q?KNBzLbxhiXFmnkEB3GahMtJhFQKsYDgdh8db+nULpORUYWG7AP699zJZqJig?=
 =?us-ascii?Q?pZZ7UktteKhiLSNROhwoQ+bQrmcjuQ1R4pHDfOIKlqzhCjfc7H4QqVZopFPv?=
 =?us-ascii?Q?bF7x8JCt4X+bInb2VyKhN+YY/FCkZmxShakvXuDQeCwKOC5FQ5TPdYXnJ2/q?=
 =?us-ascii?Q?O8+71ZrGJD3V31qXvMCD+71Ti6P4sTCumU9IHD9m8qsu0nLEjHYzjO9Rz9DW?=
 =?us-ascii?Q?PzrYwiwx7Mn+KQhoYT32S7h83c+NKq5qGCfos0Grj8ukU1+ziO51NW5jOFgg?=
 =?us-ascii?Q?m2utyk6QWoIQQGmnmITKGPpSNi3ddfg3wCD0BScqSzsZIw+Yo5JTcC1ZssFm?=
 =?us-ascii?Q?2EdF0MbDhHOezpnX6DlD+tgEbOGstWh68nfheSODe+VlF8deGylOqSdBjvVz?=
 =?us-ascii?Q?IfVMJgKBjbf7tZltpTHHtncgx150GN6IJmDCrwQ+k66NJJth1uhnCckzXH40?=
 =?us-ascii?Q?z0vXH4KCUC5H32Smb+KUG0KY6EDz/Vw0+wovbFxc9qB2zPPGt1C/KZx9N6nr?=
 =?us-ascii?Q?UIEccrTZ54gqpHDCGL79WrEZ6iPniGP9LYclOSqp/zmioRkY/Mp+W5n03EMx?=
 =?us-ascii?Q?JQLtT65LN4vCq/VHplskzua9ncTI2qfgehxG+ZNetMCNXVK8j0j+suWGdGYY?=
 =?us-ascii?Q?N8UBdxLxfl3gThxLgPjiAn7bY6+KZTmPEVsITNh8eQIsKuio9tfbD2/Xclqs?=
 =?us-ascii?Q?EqsgblKoGS9ylGyM38XXbfzD1BhHU/557A8K7ZDU5XnC9v3s2AnLzHbSuPV3?=
 =?us-ascii?Q?PKf3m+jbG8FbBUDoA54y0wjro+lK61zZ0hZK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:59:00.9230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bd631c-e276-49c5-5b02-08dd8487712e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928

Extend the existing test_cmd/err_viommu_alloc helpers to accept optional
user data. And add a TEST_F for a loopback test.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 21 +++++++++-----
 tools/testing/selftests/iommu/iommufd.c       | 29 +++++++++++++++----
 .../selftests/iommu/iommufd_fail_nth.c        |  5 ++--
 3 files changed, 39 insertions(+), 16 deletions(-)

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
index 1a8e85afe9aa..8ebbb7fda02d 100644
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
+		assert(data.out_data == data.in_data);
+	}
+}
+
 TEST_F(iommufd_viommu, vdevice_alloc)
 {
 	uint32_t viommu_id = self->viommu_id;
@@ -3105,7 +3122,7 @@ TEST_F(iommufd_device_pasid, pasid_attach)
 
 	/* Allocate a regular nested hwpt based on viommu */
 	test_cmd_viommu_alloc(self->device_id, parent_hwpt_id,
-			      IOMMU_VIOMMU_TYPE_SELFTEST,
+			      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
 			      &viommu_id);
 	test_cmd_hwpt_alloc_nested(self->device_id, viommu_id,
 				   IOMMU_HWPT_ALLOC_PASID,
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


