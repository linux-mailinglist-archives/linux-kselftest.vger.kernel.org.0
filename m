Return-Path: <linux-kselftest+bounces-34981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 655E9AD9AA7
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448AF189C2FA
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DDB1F91D6;
	Sat, 14 Jun 2025 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QZJ6RbGR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEFB1EA7CF;
	Sat, 14 Jun 2025 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885322; cv=fail; b=upz4L++xW5Z/7MN0pLiSsxz2SnYamV4jkXKQpcvNPRsyGplz3WfOOfrgHGJiJB37xnx36semvT++v0v36NIJZjKCxjN1/hoEhA7pDeAmiduxn3qB3fJG2ICXL0RBgWRqQ7ojJM8yQBTDOj3qap8gvnpNxQxGrAr0WCNFHToyZk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885322; c=relaxed/simple;
	bh=sF6j+1Glms2o2yJWb3oOkjQioL+SlE22/uNucd8QMAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sueJm/iyaSl//8C6zsl4dOANV8Z/cFf+5prkAl8kY2juEXNuvtdBF2WKViIN+ZL580rWE38/tqC1APOodndyCl9Q6LldMKpG0AoD71x0oijTYT7Osivdp95/cGE2KsGzK1mdwbob+ZgLwumpm3WSv+D0+f5sR4Q6bVCCmv4QBm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QZJ6RbGR; arc=fail smtp.client-ip=40.107.212.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZykenGYZ4tVNAfNF1vTn3S8kFqjPYNSMrMSp0J+7PRIW5W5NsUix1Bab12sSsBM3m/YDGlapcKwBRIR77pL0sXVBvbOptpGok9SGTBEM3UhMut6BGERfJROzIUe+/a+qF40JQUsnLI8xEHCwChar47b0KFHszUl1hXsloBPlNYFxTs26Nt+3nBruGsmHcE2IpFZeHPdeldNFglBptJ2qe0xFtW4ubKwFTYwTOZGoGnuiVkBE/M7WOhThBfrrYkjja7XkWFQngWEZWkMBpuP0lbRHgbn+ldVDcpzCs71o2Bv/91/SkqBqBVngrd9Q7Slmy8jxns10OzYMJqdu/ckVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrLCnGDeyswhvEa7RL81gCmRwB97ZDKJ75Fnx1D8mf8=;
 b=pt1908SpHB1ghaCQIjcsFXF+mzEqr720wUimZRfqt+r05Z6ZinOXg5myDwgIR/BwhwNG4XLgP77WedfraBFEEgxh8pdkaF1UYNnBD4gw14VOtww2MNqd/b0DTcIDzBiwOHr5/SMWWGuD6mUOlchMNbkilRh3oKiaqOQzD9L5t3YiFL/zptXYhKNXQgG1HyE/HPWZFkESj7/Q9/KPa3poIllkk/y46gkmIWcuiEoUlb+o3ROqeBFtuNL43XrGBhmfXOu2uKTaZyOD4gfk7qSe7Y6YFq8im7WWUn0NEf/ZaUIItNswXAPbu6DsvLlBg9dMmNvS83CKEUACykuiqLrccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrLCnGDeyswhvEa7RL81gCmRwB97ZDKJ75Fnx1D8mf8=;
 b=QZJ6RbGRgEFUTzoeZAOfx0zTObQ1VthVWu6llDQyIaepolv5uYK73Thk72QSCGk9mMHQwtHLBOLHRj4xUSX7/mmw9/iU1aVjjpoeorseaGHwM9mWbS8htaFd1HH3yetAjm/R/Bnu9+jX0fALP1VwHSAo327zMNHGVbbSV+F2h+AR3UA9NaXJ98Jgg3M+QHscqOH9zWdgIchcVzANxKz/ad6pJVlU2pEeM3KY+bfEizKQyeJAIivGLhU19na9c3teOvO1cVWgyFQuSXzG36rv9/zhcJ0YaVGFoup7A0D6BznwQTKgaof2u66fmRu/LKS8QPHDr1qayrtkFVoD5m3Y9A==
Received: from BN9PR03CA0685.namprd03.prod.outlook.com (2603:10b6:408:10e::30)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Sat, 14 Jun
 2025 07:15:16 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::13) by BN9PR03CA0685.outlook.office365.com
 (2603:10b6:408:10e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Sat,
 14 Jun 2025 07:15:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:04 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:01 -0700
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
Subject: [PATCH v6 04/25] iommufd/selftest: Support user_data in mock_viommu_alloc
Date: Sat, 14 Jun 2025 00:14:29 -0700
Message-ID: <276c060cd102c34fa19411df5a9ea637b071cf8b.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c9aa1a-e5ac-417c-647e-08ddab13369a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YWBXktiVLKy9kVMZXzBGK8Uk7OI70d8peXnmhoNRctdfbqd3GGeOLCOpwGGV?=
 =?us-ascii?Q?iPeJ99tnHfbCr6SL7PdHVo8fFeTcj6U6uzXvEvjlmcQ0cUqCHGL+R4dm0ljW?=
 =?us-ascii?Q?E5qVqZWQ8M7wVC+Ny+IQBz01vOvsF+keX1eHAk4nQTf2Vq8ucP7k1+v+EfqM?=
 =?us-ascii?Q?2qsHoM/WurBf+/Nic6TeiWdS962VM3Hr2NiLZPwr7uyChbaTubQeGJUGn1kq?=
 =?us-ascii?Q?BN1JAwAxn8s9IGMPyHFpitMvjpBDIAoinOyVGU+ClHvWneShm921MKslxSsF?=
 =?us-ascii?Q?lwJVuVMWRoy89NIpNabvc/oun6vwh1ghN5OS6XIW52DDalFRxGlLfr9LxJd2?=
 =?us-ascii?Q?n2QoqVCgrnz1L8pGpnBOUFWBRcyKeytnVD2ILUVHER/1ELfGhYXB5xE00Wrm?=
 =?us-ascii?Q?6fPMPSUnzHHP4f+XRIiDe4N8J+Uhwbx1xlYnQbhvyMPZNs3eD11v+t6aoHHn?=
 =?us-ascii?Q?TdQcEbsYEfLoYGo3bO+K0dco+t4PAC9h2/8sXSYDO/RgN/BOLpO1voRkR67F?=
 =?us-ascii?Q?hOYyx9uIEZnfccArcvyt2Dw3Zdgrx6WtqkyBhmMDyl/8ueGXHPtbDI/gJ6PG?=
 =?us-ascii?Q?D3Su/Dg0IdqD/HY0sNUDc9P2KpjaTj1uMNfTnpDfAwfzJn/kp6+q2I3AXWBV?=
 =?us-ascii?Q?KoYyKT8hAKhHA+Sd7rnMV7sJXtJ61B7R0jqHx6JT+eJddYW2dZ1jrZaHMCMN?=
 =?us-ascii?Q?YFLuN3KS3OZRzeL1WykDtnons8Zx+IpfwrZy+5+4/eaVi6SHTZUoqcf97+3x?=
 =?us-ascii?Q?a078KTt93zZ0aPfdCCgg/+YSYt0b6o4czZN/nQRSyxEH9KQInwtjdlBAAiWn?=
 =?us-ascii?Q?fclEcb7NLLIKJpHMolwyMgC5R645mnaHNldjW/AooOF7sh/ulFS63cQCX/i6?=
 =?us-ascii?Q?RuTzs+UBlsMrPj2cG6GgyxO0wP26MZ5jHAQoseioFQs1n9dCKaTONgWKTLco?=
 =?us-ascii?Q?FB3gdsSxv8pN/5aFfN9jL5w1DhlW45QviSsj3iCJfB8w1uyi+zqkDGDd2EiU?=
 =?us-ascii?Q?rrs4H9BAaC1eS2HTH1QTKcHnZS5gwJhgeGY9c4I2cIpkIcVU9wup8Dju+vVS?=
 =?us-ascii?Q?B7IRyDMK5wV5stRA7jwwQkYaW95dfyrFjPOZz97WDcLGK/thNHBXKCbNal3k?=
 =?us-ascii?Q?67yuBqBEAp09hrHfIY9iaU1ZiQfstazBrgqwFpYzf3/3VyF/c1N+xUGIZ3kh?=
 =?us-ascii?Q?f3lnNRsO+G7nLt/5dZlZctJuzAV7exAgRizLj3AyW4ZK6YL30m0BkStnP2M9?=
 =?us-ascii?Q?EcK5ZGpHYyWsz0L8c1bIKD4mcEx5z5Wm1DjoYTki3AtUM2/lpbfUmr04d7Ku?=
 =?us-ascii?Q?CnpWxN9F96URLXTROKMpOGHDQlfo3ZwW1y4sipsKBL1ZG6q0V0jb7CboPpD5?=
 =?us-ascii?Q?1/ZciPpmjkETRO7qdpm/Bd1/n1Ees8QAPg/+k6La1leSzteMRxuAm2IlzW9j?=
 =?us-ascii?Q?rHZ6pPF2R45ilblqtISXFsbqU+nHQQusVaDJgZ4bKPJUj8vAPOTuon5tM8Ua?=
 =?us-ascii?Q?ieRur1jXKdAFbyBo9vrlnbHCpIL+U4GL3f3U?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:16.3273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c9aa1a-e5ac-417c-647e-08ddab13369a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160

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
index e09fa859c359..6bd1816e0794 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -783,6 +783,21 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
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


