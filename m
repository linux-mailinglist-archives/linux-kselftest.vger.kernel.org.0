Return-Path: <linux-kselftest+bounces-36632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B3FAF9D76
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E17E5A12F7
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C672264C5;
	Sat,  5 Jul 2025 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rB5t7Mmx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A82222A7;
	Sat,  5 Jul 2025 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678090; cv=fail; b=feGduOZf+D5ETwyX08iOtoWkg5qrtjgkRaldOa/UhvvzP8UGMXqaFEHYakMiTvZxlsZM7JYUPhByX5rx8hHgmfGyBDrSl3G+TPib/8KMVyxHd6oZMp0VbCCXDf4IVOpbkhCZG9yMA2/K2N3oSlrCVYe0xYcAxoyPOkpxIsTKD/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678090; c=relaxed/simple;
	bh=jmUeLc7xFPAk6l1zr+fhbpg1PsO0RWmwmRP72WT0tx8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIsedk5udnRbnXXpYdjcY6+s8xHnUy1yYLFpBoA+1iw0Yu8I7xyzD1LG1oY3K49OGc83GTi+RSCTvFlZlw8mIJUezLxpqA0Ud1SynDVw/gSZXy76Ik2+JhvUcp/Fe/S2nm5oW5WBKKA2ENLgnnXD91gRHVY2f8AcJ7bjPoS3FfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rB5t7Mmx; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6d6Q4bjWkbU9ZoWp5E5g6cY7rjMi4ZchZvOaFgBdCJrLuhSx9SfqqtxZNOctp9xKd1FWpjDIm9fvrVcxIyHsu0EvTyQ5MFcf4gAdvZn0bJWkjHHPSGapHTeLU90Nts7LR2i59rfQKI3pQUrXP08L1SL2sTNX8HkXq2pN59rYHjiWgSFi203Zjk9viDMDv20RLuEGDOo5QKBAP/cvTY7a5uMfVXJDj6b7dCCOt8AObZj0hDfpJlff62/ErHNpxIvaThdSXwhitnDYxuD0qkfKK4O5NcfKj5ShNzOF++77/XOVYZmPL/LOpX3bIQC7hZjlOfDxtx1ssxu7feDwu7H0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iZvm6X0I1nJjkEyfpx8plUh1NufFGTTluN++/etNy8=;
 b=DlJhw0CKngBYnlxuGL/jPc0EDfGXkNQWoI7P05obX59j6y/+yqhKfLNNw0Gb6AMJDo4uj3sITD9G2xh1IOO7T0Yr0Q3SITuul8aDM/dq/ojCZbR2p2MeOBawa3tlSp85OGQilK1dttvTu0Qokg+IF/PPzZkKdDnVHX29F9ySmDbLOEOLei1HmwmlS/tSPr4C5FOAtaGs70jkAdyXMrXJg7Tv9LiH2j4RZrOfgSmT7vtslk7w0eugt37UKfVntHvaVB8K8soFay49bL6rX3bzzre+D9XRD/gc+BQUWjAe/ZVQBsEFprrA0KlxHcV9OtpCe9Mja3V1HySMUKAKftbqwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iZvm6X0I1nJjkEyfpx8plUh1NufFGTTluN++/etNy8=;
 b=rB5t7MmxwfaYTvDEYFFXsxrLSABV5O/41oDyz2ipIKIDr9annrb2lmD5XOeckwuB3uilDvjhV7oi/TKP5Ctya/c7jAL552oB2RmePh3PjMLqh4uIpDz2/31fcTzD3BlsLKoTnJU61Cii7mrtsWkYbbgfvXk37vmr8+QTcHrKSRMUTgJalOcO/UBhuhJtx8WevnRc03pZiQzz8UuhYHuwRh4OlokkviLEGOKuar6/r9wyOBK4zgwV1yk/qu0iuvdNyi+h7BCvQursWdJSxZwuCMH3G056zfRn60qLqkyYzgYtvmGGqy4tyagjOeo6SEZGCLdwpYSaUwwJoSM+XV0VtA==
Received: from SJ0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:33a::6)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Sat, 5 Jul
 2025 01:14:44 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::87) by SJ0PR03CA0001.outlook.office365.com
 (2603:10b6:a03:33a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Sat,
 5 Jul 2025 01:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Sat, 5 Jul 2025 01:14:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:29 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:28 -0700
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
Subject: [PATCH v8 22/29] iommufd/selftest: Update hw_info coverage for an input data_type
Date: Fri, 4 Jul 2025 18:13:38 -0700
Message-ID: <b77f1724b62c58a947a89d339dbe29555b8f1e61.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ee2681-24b2-4033-b176-08ddbb615396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wiz5Ib/Lsx9sDfnjDAMF0U84bzTw0Dw80sD44RkJuwvpYsUYtYZLlbKNyDIY?=
 =?us-ascii?Q?YnYSP1rJwrJpTRVALQ91lGsDluEH1KvxOaVEo/Z4c3qhQS3sttLYZ1utaBSv?=
 =?us-ascii?Q?sxvt3hkw+E4LqaeUGISZ0t9sfc5td8iVkuyRPi8CzmeQCRHvG3ToINbBDZfU?=
 =?us-ascii?Q?Dz2HrAvfIfSBZVrgkNxHLwfeoe2ItQYJuV4KFJRtd0WHUUQavDpO1Hq4clVh?=
 =?us-ascii?Q?9ahJzVy4cxWbcnPHDfomtnGjxq3gHL652GrQvWbJjT7QrB4w9nf6AV8kL9AS?=
 =?us-ascii?Q?LNLesF4GalXG76oMpHMzSdkDv+Wiq1szkmddUo9WEtypZlpB/9JLCxvvRlYs?=
 =?us-ascii?Q?jY+7o8BWleulHaZm5aDzmLd3HT4w7AJ+uC9auN8EFPLE76ynPeOTarSw7xgC?=
 =?us-ascii?Q?VKtOFsJcrAbPzA8JNHrpVkvjdiUJR1x7XszjfNp6czE0YzDJaTUf66zM8TVa?=
 =?us-ascii?Q?yTCMizvDxtitqrbhf3CUd2rS+g95d/oFBp36IU0vO4y+aPRN9XrzrB6i2gE+?=
 =?us-ascii?Q?ItK/cjoQypYmgEYnCCqzdKTjSDsuXQBtqDH41VglVZCae/wEXZ9YGZsjdH9J?=
 =?us-ascii?Q?OJWAjLxn6B018ES4L7pUCzUKUVD/++w8pImVYs9Vi+Q/gwxtHTblLkCtmqjH?=
 =?us-ascii?Q?skNdMjeRkzNd04Hy18y6Vpib/I0C6lVJhVDnXESPidq/dl4TPiVPhgVVeP4M?=
 =?us-ascii?Q?dycUn2p/vK866lzyKyWNZEhjGNHi33StkU20+qCgclypzyngrw1I9ImgiirA?=
 =?us-ascii?Q?BymVk0tu7p+Eu/3tHSF5YWXRny36pqx/X6hNFkuabF+GWc7xobs/iU0ABCIg?=
 =?us-ascii?Q?dy/6QcgvfZcm39bjXxL2/DMOR3emKmpRLM1XWCt1sTvPrpQkj1URw1ERV2a3?=
 =?us-ascii?Q?tfBUKNBP+JFMwcrc34/lUqiU0taUApBgdsMDy+2ttLKdBn5XYeyVi8lgRtlW?=
 =?us-ascii?Q?dzPiDCeq7hHcec0lPyUXwk/nTcNO4GrbqHdJGgIsxKy/6JgOQKB7OBQHowaj?=
 =?us-ascii?Q?qxRMaTStq6PRv4m10kXblgmqh+W4yFMel0gVp5LWpBohDBhuSinG9uvcwosw?=
 =?us-ascii?Q?6GEuALbTywNbYMIHNZN95uwzujkeMHem64HoNaKY8JSFdLH8OeBB2kqvWUsF?=
 =?us-ascii?Q?pgjlbYSt64xWZw2XnA3ZfxV9G1J3TIcGNxLjIqkWdpVFKUoUmWx2dOLGRXen?=
 =?us-ascii?Q?k5K1AID7aNYGXdCBIVbYk1qjUO2H2+mUEc/tvLgL6ZobHJNX/6lfXEmMaUJK?=
 =?us-ascii?Q?CdSOhRX2J/fn+QYoG2SSLHIP7st3BAnxTgxs1h07dOcPcb20gE5k5AdhyRpG?=
 =?us-ascii?Q?fOpUOGV2VfdVkjmpEzdzXehRcsWZiS1RAIRd76p53hThNTD8hDEsBfIgRgQI?=
 =?us-ascii?Q?Gp7cbOZ52Gfbfl7U4lN9xtFy1MfSDof3bxwNQrG3YQj6nwk+L12c2ysdllBn?=
 =?us-ascii?Q?1AySQUtuZOVW5+Dx4WhpCuPnQuS1WcwnAJ7aZvyA81N5cS2ArfKGvb5074mC?=
 =?us-ascii?Q?NNhelgKWuYaOhRkwo6+eP4g6NODraQROBw1T?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:44.4064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ee2681-24b2-4033-b176-08ddbb615396
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635

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
index 8b85f6fc8cd0..9d5b852d5e19 100644
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


