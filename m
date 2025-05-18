Return-Path: <linux-kselftest+bounces-33262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB1AABAD3B
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFFC189BABA
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6271FDA7B;
	Sun, 18 May 2025 03:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H95DDen6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F4199E89;
	Sun, 18 May 2025 03:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538549; cv=fail; b=Tqus1UAtEZuEcFnQ7gIxUv5qlFYABFwjExqMYP5JzVmW5uOTyWLr1yLPw2iLt3lZq5wCrnATb886y/gvc0k4s5ic4iWpPrZUP7k8/EnfKAuan0//NvDDp7uyRRbr/tM/dVQTMmQKCbFanoyhs7iTABk8uVhMzOxkslGprW4diBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538549; c=relaxed/simple;
	bh=opF9KBL90yMIu85vzyv3CBOiSV3x3tzwfP7klSzoPVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNDPjiUA4wr78UlbuJfK3JB0hYvNO1pSoA2461OnEelFR2VNRwe4vhYjemrlSADUBv046xQmUTpumW7lcBpN2ghMhICrRBKKJJLXbY1rgVonnnE0wIHxHl3X7QsWGccAC4LdJhT+rmtcrEkrDZWc1a6omlcsQjPR6umgpn/pXvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H95DDen6; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGAhpxNefLyHWiIdiCkvnVwR/Uvvl1QxPH4VU0gKgsITagIOacEvR1/YyCKzVMTgt2NemRlnCVYzuwerxWZaJdx7tM2q+BTMguX3ZBWKUJ927nQmjo8jE/Xey8zZO52uHdlLU80Qo1Aq/Hl04r5C5cvjk62XZclfvVMpy9K23wr/i3LGc+hsvMWZOIwB2Bqzzfq+GdvQrenuqg4BEbi5+ZlCeT+DwW9rPoTB8xpwJH6vibb9heR5hacXi1SNL2xjswfOZCsEtV0YS8UoBhDehXumj8n1cm26CnMa8TxLQF2oYZgUCOEKA7v/LV1NLqEAdLsvBidwLCpNHphjrDxutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jQZyHlTYtc8LfzYqTalu+MpmbtO33Qfc0xyjufwWFw=;
 b=BF9OrEmp9eJsfGrps4VbAQUtoAFtPFjHgWKtyzQEEQLYuDef6TZ1CoQJangaMvG/YUUn0I7lHPvAwY4vr4KvFZV7Mxgsq6M1lxKbAJyUeRhlqbrEhmpl5MobQ++9AeuePixMz6EwKCiVGaZ6n+iLbkP6DUf3Kj3nBZGz+AI5V36TgKV2nUTaB2sdf6DreLXNX1zBD7f435vU8Eg9wc80nKC/Y3THQYUv1ZAevQhVTPjGo9zHjwPYnbu1jG/8mTbjOcwwBlpYC8u8ltSKBe6bFf5PTQcGo6KDgODsRbeG7XCtRGnaRfYQ3OTYF1htmEenKwBKJfFAKYHmo00ZuCXKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jQZyHlTYtc8LfzYqTalu+MpmbtO33Qfc0xyjufwWFw=;
 b=H95DDen6a8NCKfIfjoZdxeOy9hK67RSTBGzCdOesBZRKwrch6w17GC7mfDB6GFU6BwBknKsP7EwhwOi8f2s/3vbXwkIGTm8uvJngf4QfqNXuS0NoOHbLV/z5Tg/1TGctLfvEhaxjTQRFCCWUFHY9rr4kOVrxFTIKbXvUJJerD9Ub4UvlIBNzJ+jMcYtmtr3h8vHzhZFRajOA9axm4ucrB1A+lQ7eyomNDzdGi4k/9lU9ViCfBq80Rhu9fMrbBt5FScvGUFnwmxq5O0Pvz/7WVUHERVVsnS4jFbT8LmdSPRZn4YOtK7g0/m0OeUnqP9g4ytTkGFpTfjxPczqWafm9wQ==
Received: from SN7PR04CA0102.namprd04.prod.outlook.com (2603:10b6:806:122::17)
 by DS4PR12MB9587.namprd12.prod.outlook.com (2603:10b6:8:282::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:22:21 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::c2) by SN7PR04CA0102.outlook.office365.com
 (2603:10b6:806:122::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.27 via Frontend Transport; Sun,
 18 May 2025 03:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:06 -0700
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
Subject: [PATCH v5 07/29] iommufd/selftest: Support user_data in mock_viommu_alloc
Date: Sat, 17 May 2025 20:21:24 -0700
Message-ID: <699e84726009e3525e3660eccb15426ce3c82cd0.1747537752.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747537752.git.nicolinc@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|DS4PR12MB9587:EE_
X-MS-Office365-Filtering-Correlation-Id: 45458806-b7da-4075-6385-08dd95bb3370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4nmdBEYGfioQQlOMZmzZSte9Ym0PcitKlAhdAsJ/S3qbXyttzFwIOGO+qfFx?=
 =?us-ascii?Q?dexfOELqqkfhWsc7oBqtg+UIyem10D8rPzhKBCsGhyA+06ja1s3yphLQ/sj6?=
 =?us-ascii?Q?tFjDcIre+H/0H0BCaKWyiEFdn9IigFEfAIgk7Mrmeyxnz1lxhCJY70J/Qrk2?=
 =?us-ascii?Q?++6SSX/mRHmWfbFhhnnX0n/xu+HKAgPwVn8v9AX9hyo4ZVvy3dyPANcLa+WY?=
 =?us-ascii?Q?84ODZey+rY0JkXQyESZHQpYqLBl7Sp1dxEzXSGApSdf2sCldOxm33mcK5MvX?=
 =?us-ascii?Q?r2MjbwDqu6aRq25WlgE3EaxnpQX0p/wPTwCJv3ONMC5X+Sx2cCMBrsoFYbfi?=
 =?us-ascii?Q?I4KcIxPiGvVZ7B4KJ/Kv+BNwtDwBhL/OkJe4fxUt4QqXoAzr0vbM+1FlMFqF?=
 =?us-ascii?Q?j8SgVx7lSAWmvRB4j0DUxIcHIwqx2rpBR3vlBPUqU1UAScSq05CkRdM/JtZv?=
 =?us-ascii?Q?BHWzv9Mrq0rTntGwSG8n16NUcSaLIWaWMAVcxeBty7g73+AKlebWNobQ4fhH?=
 =?us-ascii?Q?j1+HSeYgvSVRRRs1HDv+oXvT5T672sOfOn+rzS3nVJWnDjpGJ5UBq6UMXFPx?=
 =?us-ascii?Q?8YVn458y/n85zsbNyb21nunth19ZXhoBDXSFx6TSAoYHLwCTzYOBa6I/h7Gt?=
 =?us-ascii?Q?9ZxfTCNtBcvpUFuBN7elDpoKHHm6bOL/aTOWM4G9C7Bw/UVho3HwpzoS5uCS?=
 =?us-ascii?Q?gsvr+yPssnyL32OpxaYJWq/5CiBS2yKTvXr9Kw9TRruKdcIWDxwPVFJGd8YW?=
 =?us-ascii?Q?J14vSZ4P3GQS0yyi7SGe3EFj4uoloLf5zDzh7KBy7rmtv+X0BtrrOZ8M4o4a?=
 =?us-ascii?Q?rnWMeWmGMhdKYDrg4DY9StHH0ZHFYzY0N1n9n2c706Xd3bDuvwupBtC7ShyB?=
 =?us-ascii?Q?PR/vHgK1jWICIwmB7BYRuH3FmQHNqCOxRjv/jCUrj9MFBPF78WgVbj05ZHtD?=
 =?us-ascii?Q?IQ5WgWY4rMC1OZXmqur0zbw0Ey5NtzU+pgNFjKX0ICPdbegzirbeMo5I22e8?=
 =?us-ascii?Q?6WncjWDqEIk7Nz2fI2yb2GUSD0Fs1L2ZbRJ8LLOwdoKxZay9MpPcwbprKc3T?=
 =?us-ascii?Q?Xo/+jXq799K4BaZ3i+zrR+vlc+xDKVGEeHzoWD1HSH5UXT2PWK/uYTCrhWkl?=
 =?us-ascii?Q?q5Itw8rRX5Uo4Ymkxc05xRQXjA8bjEXnR6zquNSpZo85BHpKxYiKCkPHnkgt?=
 =?us-ascii?Q?ADHqULhm8mmyFpqoB9mWfvzmiDk3MDAg3mU2G75k+XiBuN+pG4z7i5BOOUrk?=
 =?us-ascii?Q?F9rGge6RRDzMu0nK8kN/QYlHiUTIE9nLDMgj16kz01dL1xnBXXz1HEBwWhz4?=
 =?us-ascii?Q?HUN0w4+2A+DQNu2qwaxZpQxQS1xFrsxbDaKdHg0ihfOx+QZS7lrrh3rpdWOk?=
 =?us-ascii?Q?JrnlcbvCYSS2NcwP5i50Idp22WWaDkCNvuQHw39vfJ5Y1XP985H7TjHNSMrW?=
 =?us-ascii?Q?wW1DECB/cp1X7hdpGWl7yEu76u6AXBQuLP6Yh0nW1DZt8A3+Wp2jqW7nJ1TP?=
 =?us-ascii?Q?IUR2fd8hFFPBEmG/8Yj5mBWuWfYtmTqKivR0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:20.9371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45458806-b7da-4075-6385-08dd95bb3370
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9587

Add a simple user_data for an input-to-output loopback test.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 13 +++++++++++++
 drivers/iommu/iommufd/selftest.c     | 17 +++++++++++++++++
 2 files changed, 30 insertions(+)

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
index 3d56e2bddb0b..ea2e4c626ad5 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -740,16 +740,33 @@ mock_viommu_alloc(struct device *dev, struct iommu_domain *domain,
 {
 	struct mock_iommu_device *mock_iommu =
 		iommu_get_iommu_dev(dev, struct mock_iommu_device, iommu_dev);
+	struct iommu_viommu_selftest data;
 	struct mock_viommu *mock_viommu;
+	int rc;
 
 	if (viommu_type != IOMMU_VIOMMU_TYPE_SELFTEST)
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (user_data) {
+		rc = iommu_copy_struct_from_user(
+			&data, user_data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
+		if (rc)
+			return ERR_PTR(rc);
+	}
+
 	mock_viommu = iommufd_viommu_alloc(ucmd, struct mock_viommu, core,
 					   &mock_viommu_ops);
 	if (IS_ERR(mock_viommu))
 		return ERR_CAST(mock_viommu);
 
+	if (user_data) {
+		data.out_data = data.in_data;
+		rc = iommu_copy_struct_to_user(
+			user_data, &data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
+		if (rc)
+			return ERR_PTR(rc);
+	}
+
 	refcount_inc(&mock_iommu->users);
 	return &mock_viommu->core;
 }
-- 
2.43.0


