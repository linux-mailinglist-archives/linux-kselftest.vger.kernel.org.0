Return-Path: <linux-kselftest+bounces-36615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DC2AF9D2E
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6E71CA11CB
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90ED1C84D0;
	Sat,  5 Jul 2025 01:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="efv5J2zC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E38113E898;
	Sat,  5 Jul 2025 01:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678059; cv=fail; b=LadS97ZEIFQuTwNvNUCsscYkJ+mzmRSJR8sGxgGxHe2JphS5pkqHsMj+VKdPRgdJpF3fIEcnBkPkymPl8gGvvkeUXS1SeO+qU0PhE1/rzqIQexeZF/tm+Om+c2VWyCUVub4hl/E6w/pNGZPppXYus2j3eT3cQqiJNyfIaR7pwE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678059; c=relaxed/simple;
	bh=KzshrMhEsoU5S09YWbgc1XaHSWfP6tWCjFYQlU2fgak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhAW5a0R9U2sGX2KzWwKQf6nsi3w/e0L07xlmE+n1t10NC+3fgXdMnuKkid0iTCEgk94xBevG+dk8hYpVjXosZwwy/NEZiQSwvXGKdw6S86fCC+Tm38RvytzmKxsfNZpZCd+vIyI5jcqvkHaEW2xGtmsLoZc/sAPDRNR+ZJa0mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=efv5J2zC; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNbCaf8JaBrLiWQl9N33jWppZGhyuLRB9CXvYCMDB8E3UGJO6+QC6zzLXxQOX7sxsMNAahB/PCo/H3rl4J+r7erNy9vC6KI4/UuQ081TN6CS2gubBHZPj/dL9+z/gOceOmTJwMsVg+m+SgYDFvjb2CHZ33dwPwgaTMoemaWoeOM5S6quFn9C5iwA4TJNtHaC03uGE6iRp8O8rGKK2SVz+f3u8itfiMm9K+R2oBSSF6jyPaS11eyCjxogz7905AyI+OsHe1J7j10u34g54gYNT5PFPo5uhXdy3pFlESuJJlwBiPB/eTdR6PYkYOd8mH6uaXQ5N6BsLIEmZNlQHc+xyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOW7WhxvGzxeS052guEjBECCH6jxjGiDpOWUhZ5qMqo=;
 b=sqfmhbx3d1BTtFDBwSWH/z+GtYiuKZ4ma8eC8eooRAqhVIYHo7QwUL5YrRH6ji43Oyr8+NYX3Js0QGD7rVEkXO+Yvk0kii3lrOGyw7N7jst9hXCdVb8bCMXH6GPtZPa5ROG1zcIZh3drxAy6wSDFfErZJyovNoFUKIAwj0Ck3R+dzMU0FBfGvtyw9xVo3EFdJYIVasO1oQzXdeu+ok5cbSPQBn5pR0AvqssdOCGpYhbRxx5Lb4CSfl1MIyUkUGu1aJzKbZ+lruJ3bhOJnlEoJvqR1fwq8Xi1SAccQH12xW8rFaP2/I9YGetfjq54txBUyyj9tJ/xART6jeKiV2oS5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOW7WhxvGzxeS052guEjBECCH6jxjGiDpOWUhZ5qMqo=;
 b=efv5J2zCn/0gWznoRFcQOFWEBhR3T773X0OTBEQJ5LzxUM373f18Ikr7yMwvOaJLy6susOPqEXRi9scrf9p/Xf5EFEkbKVw3l5TdYwP8x4gUvPz7ul83n8MlD0zZ0zJIIqT9GufBkB1BV1e2rJ+V/8eCbYc5FhBK9w1nUUmoIYUVHA1WE7lKtomEUsQoaEao4pHqhNp6h24JKCOLVFO1rNStsu/SYSZ4Kac30k/CcPsomfLAucB9X9VySEigDXreaFv+QWki+5+dL6xhMJ2/PPgprMn52/DbhS68Z7/OiYLwSGFEycVl4LfcrY1WivspN7GNzgwOiZY+xpafZiNnOA==
Received: from BN9PR03CA0182.namprd03.prod.outlook.com (2603:10b6:408:f9::7)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Sat, 5 Jul
 2025 01:14:13 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::d8) by BN9PR03CA0182.outlook.office365.com
 (2603:10b6:408:f9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Sat,
 5 Jul 2025 01:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:07 -0700
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
Subject: [PATCH v8 09/29] iommufd/selftest: Add coverage for viommu data
Date: Fri, 4 Jul 2025 18:13:25 -0700
Message-ID: <8d44da656eb7b67959c3bc1c69dc28acce271ffd.1751677708.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751677708.git.nicolinc@nvidia.com>
References: <cover.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 639743df-1d21-4987-f263-08ddbb61412d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1kgKhkpt/OtH6ge+kAnV/fh9HPln5nnkBAodkybxBtJSR8d48QzjqIoD0DBV?=
 =?us-ascii?Q?WbC8qUOKiL9qfpWuf4xpMNGYH2lvxkA5sqUXqXjyoi4CsGg1Cpe4YbASqkf1?=
 =?us-ascii?Q?M66UTrX3VPQobowpiJqj9NvA/+7ginh2c7xuNeilFKn+CkKQf4Vhw4sXOzy/?=
 =?us-ascii?Q?AsMdmhEG7Qdy+uHbKg044kJt5Sucspw1cEQnrV6WFuxQrlMU8PAheDvNVAo5?=
 =?us-ascii?Q?ebIslFDp/orieVK8HcCJS4KhW3zjvBkNn2NBoW68Ry6+k+3ji4gpl7l90Xzb?=
 =?us-ascii?Q?GI6+t2Lx7mKDhTidO9QRz3gOm4woNaA/OJLQJmnFC2t8vNyKk9jnpL82exk0?=
 =?us-ascii?Q?sPwndGYGBwn7MWasfC4pRzKdtJLBURcENc2W0PSqaXIvxB7tdcLHS2dxJVnS?=
 =?us-ascii?Q?aQ6MwxhqfpBEp0WynRJanGv15owstxa8DjheCiOCFCGIDmJZabVe5YaFL/Fh?=
 =?us-ascii?Q?WkZbtKzIv3HEVR1M+eKZVkLBVeDMv0P7Z6VUOd5WNVx8nO2hxb6C7IVhVeQE?=
 =?us-ascii?Q?Nh1IANvOT76IXSRM3ik5fAHC3n9zJJtBt4bRQOD0lB61YtsI95D7uyzoOSl0?=
 =?us-ascii?Q?RJRdbgfyjO+afHdBUOmyNIY+4QryGcko7liRGy0MLOzHSSnmfFQEkcldd/l+?=
 =?us-ascii?Q?AL9KgvF0/u0f9XPxpvKwjHPEVDze4Il8RWDexgRIpEAh53PO7ho1lbu1fWjb?=
 =?us-ascii?Q?wdI4Iwm7tk0qctwoEuy2zCEqIkiLXf426LPnHFCSEm2hfqNqzDptoPYnL6Oj?=
 =?us-ascii?Q?73pU8rDwZnwib6LLqrD7efGuvtg9ivJfsmoX1tUtXl2pl2cHbx5aU+9SWCP5?=
 =?us-ascii?Q?29/UZTEnx0LHo7Ud0/8n9Jk84/GSBOCoGd0YE1WrS3uN+aw9ygOF2E+TnA2W?=
 =?us-ascii?Q?wbwalhYTmJap6ZRAgSx/4qwSn4b22vk+xHkZhXa6+G8zBGQ9tqn4R9cSUb1/?=
 =?us-ascii?Q?RnfQHzwSddhqnahEcdArWKn2XryKyIUOyL80+4DzwN/wu0wiFmFV6iWjz+na?=
 =?us-ascii?Q?SWp/KYF/NOw4fQ+XK/DNYTPnk3K/E9mjAGUDBU3bJMZr5jBmW1DzmA2VBoNj?=
 =?us-ascii?Q?j6Oqt52P6586wlFJUOVoZp3f++hnI7k3UPXVYj2rNrm2DBCs8tfPeqCGGRHT?=
 =?us-ascii?Q?sJaMrmk508g0sanldrxL5+oVc47WBPhekAust+D7kVf3JKMSNsm9jnvY9+Hp?=
 =?us-ascii?Q?N7IyvQvyunC+rdvufjrwMWXZTzk1LZmAqivO6fz5dBQE2znRaxx+Z3AG+s/M?=
 =?us-ascii?Q?lSZVWLRxRymycBEqUraL2nVjZgYBatNYyH5vvMa2IbmQIgLruOsiHsm1RVmC?=
 =?us-ascii?Q?omBZvg+yQ0YZzwPnQZCCYLOxahrb8Qi+obwi3h2lsjnPNTTRyXp1eUUe5wT+?=
 =?us-ascii?Q?dtfMOLMOi+QdRRzLvYRPHU5ODxOjFF68MyTThb1VD+wgAA/WrzQEO2wPQeg4?=
 =?us-ascii?Q?ei9kqZ8Nxe8DNToKC0JRmw+X5Oj2vFEeNQEgwPehEFMBod3qk5c0kk9tTAPH?=
 =?us-ascii?Q?GGTaAiDisE1NHaXfLvwC9BD1hyN+uDyArJvd?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:13.4516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 639743df-1d21-4987-f263-08ddbb61412d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF

Extend the existing test_cmd/err_viommu_alloc helpers to accept optional
user data. And add a TEST_F for a loopback test.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 21 ++++++++-----
 tools/testing/selftests/iommu/iommufd.c       | 31 ++++++++++++++-----
 .../selftests/iommu/iommufd_fail_nth.c        |  5 +--
 3 files changed, 40 insertions(+), 17 deletions(-)

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
index 1a8e85afe9aa..a9dfcce5e1b2 100644
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
 
@@ -2791,6 +2794,21 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
 	}
 }
 
+TEST_F(iommufd_viommu, viommu_alloc_with_data)
+{
+	struct iommu_viommu_selftest data = {
+		.in_data = 0xbeef,
+	};
+
+	if (!self->device_id)
+		SKIP(return, "Skipping test for variant no_viommu");
+
+	test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
+			      IOMMU_VIOMMU_TYPE_SELFTEST, &data, sizeof(data),
+			      &self->viommu_id);
+	ASSERT_EQ(data.out_data, data.in_data);
+}
+
 TEST_F(iommufd_viommu, vdevice_alloc)
 {
 	uint32_t viommu_id = self->viommu_id;
@@ -3105,8 +3123,7 @@ TEST_F(iommufd_device_pasid, pasid_attach)
 
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


