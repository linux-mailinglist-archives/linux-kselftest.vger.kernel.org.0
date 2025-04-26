Return-Path: <linux-kselftest+bounces-31678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AE5A9D7CF
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 08:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6DF1BC2A3E
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 06:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9A91EFFB4;
	Sat, 26 Apr 2025 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y0hxNT3Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D3C1C54A2;
	Sat, 26 Apr 2025 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647149; cv=fail; b=KDSnvE9bDNmPj/HFl6dZqB63XQaSS8H7vQVZWRL50SwbAIN9n6eAUsK7dBkBKUk+zr/2qnzQ5Gc5wuZqRPIIaIZkekw7c7DmxZf29Z/11r9swBoHPWIkNeLvOl+2FHCBfhViVVtvLe9Czgo0TU5AId74M4wm9W1/CFbDHV47hE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647149; c=relaxed/simple;
	bh=+0uRN3R/mzCTmXuqInq4Go5cgXmd5Co0AryALVglaDc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdnDp6tJntl5vwZ71ks+s/j6Db5LvBpwK0m7ibvZ8z/CXN/MyDgHrwMMKu3gxBFhwdpWbFzaxV6LHnz+etiNRF9ksQ2N11ZL9W/Byn+dR1pzQPy8Vlyd8jLkASzRvgFjeWSIXtxNi3S0DzhxvLViqrj1nXcpd/IxC1NuMd0SNh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y0hxNT3Y; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZuKNaaO7XaAdpTPKv6/YUhxLYndz/Ik0HHaEluoOsdKwXcw1GnpTGAoPCJCgNo3EarpF0jHdMAytVAIeAiH9/ph6KBopANhnu2OpEHoY+wLvKPvZ2juhusEBfGJy8q+AY4UdumflMdxmf5yg+ntvQmoWkrIou7bxqhWgLjdvcL5kp4frTZxBAFASoxacn1CjAwhXPtt373VUNSNMchreN46AIuBxYGa/y38iI5cStjJ+meDj7fs+AyV7pxbyy36WfxeFbuUJIr7iq7jjiSY/YbjDDqmNqq0XivIy4FADIfNdm7533KQXGXHuarMlS+3+GogYfM2nH22yedmmqeiPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rb4dE93GBXOPqFQyMkv7i7yt20JqCEkXJ1wa1LFTUs=;
 b=tizs2ksfWs1MnP0moys+suWyx81MLBZ7NKBVAY4W/ud/78GKPe1muJ7zReK8bUdAz7Bt4eXHjPfXuVAaQ8383gDRWy+XaSfbgJDwtCyl9rlvq/KBxDQhrN1PWt7KulFkBGtVBf65o+YNvM40RKsypveWjPWhXSmguOR0cxm7cKFaasYG0bHXgpgOQ68/EqPn0jRhKv1JFsEGsXtpjqlL9MOWsfWpsenvb88ie9+e91v+ed866mZYfAjn8fsQl0aKUh82nTEKI2GX5QTfwd1D9BuOuBnQxxaOYccrhzW1dwnqb7UJ289xNI8A54peYElN0AdQkOEZVFD65l066UpWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rb4dE93GBXOPqFQyMkv7i7yt20JqCEkXJ1wa1LFTUs=;
 b=Y0hxNT3YZIITS4eLQoWZ4OOpjOHDHbEzdcNIIn17nTJRtZaJ+qBfLP4YzC4jllKetOgO3X2eLFYMczc4H1kMIKUSArPiEZfrqp9R3FsFX10IwQfng1YDR6wXwPwEHvyA2o84OGHv1oj1fM84isEN007Orcsy6ruossZdurQoe8Or5A2XslUt3fMLJyla7f8mMo1tG67CYjQWEKYDVNYiABnNmW6vP3mVPfJEN/KCLonWNRICV1H3a6Fq/LZxnkFYt5qFiQ/sTfNOztj2WoHGcmzErKSvzLnP39K0uwDcviTVYHV0bhtsdroH6y0lErSA0k/fXZm5365G9lWyv0NLcA==
Received: from PH7P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::30)
 by IA0PPF7646FEBB5.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 05:59:04 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::ce) by PH7P220CA0013.outlook.office365.com
 (2603:10b6:510:326::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Sat,
 26 Apr 2025 05:59:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:59:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:58:51 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:58:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:58:48 -0700
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
Subject: [PATCH v2 06/22] iommufd/selftest: Support user_data in mock_viommu_alloc
Date: Fri, 25 Apr 2025 22:58:01 -0700
Message-ID: <786cd49df9fb437790b7dba53165e4316747913b.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|IA0PPF7646FEBB5:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd5e06d-414d-4a45-1a03-08dd84877280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Qy26+KpgI3uUmPLcGXyApxbWPFa+Hs945mnpZeqEGA7lLzIc76wBk9fwYA1?=
 =?us-ascii?Q?1W2Q2xgHDLW+GeTSD8KAAfQjcbLAttWd/4vujdvPJD8qofqmdM324/PJHpBy?=
 =?us-ascii?Q?IyiNfAI75KD+IF65Y65XsqVfSZZWR1M8sl4ORomQ2OpYWqKlNo4KKI0q8fiG?=
 =?us-ascii?Q?5NHzQTMqpWJot2JlkskYfx0Q9/k9/o/C6NuuLgTghpIp07jnt1KeWC/fW9RT?=
 =?us-ascii?Q?i/63rU5rDd9YzY9OnJKw3bYQtCI6ewrAKvNw5aBRnNy5UrA6QoQN7Fkd33IG?=
 =?us-ascii?Q?Sd5t6jlJKX/x0do3vxiCY5neIPep2+vRENfRj7CbaTsHg7QHY1iaiMJuFMS+?=
 =?us-ascii?Q?DJ/9fevQ/ekEYsEjvT5COvogWm6DnD0Fw80AXmzbFLv9Dmpf9sNjEnEyDHVu?=
 =?us-ascii?Q?Ct+1/QIkI4fS5UTlFW05R7ec9xA66wIviIm87gmN88QlwbiI5qFCe7FtU7xo?=
 =?us-ascii?Q?LpyEnsnTYoAgqwzQGdsH0qNi2/qKagA8/bqmnpRDAlu6WaaS/q/WptES+o+6?=
 =?us-ascii?Q?s+B88rVdOmiBgK4r8U58p/IyRnoTn6t6IrUktsmUaMo9Erb/a/jpatzQOm9L?=
 =?us-ascii?Q?LWTCYYKVIMZs8XkFIRuDVaYaHNOr4xsQ0QVDmKgBqd7ZhODjlBflwVW5Tk5i?=
 =?us-ascii?Q?HT/bpzAYpL85nHeVwY6kp16jfJBhA5VK+ZwJhC0sZAStSLxi4jz4U6WEE31D?=
 =?us-ascii?Q?Z92Nn0NY5ud5uhwJc7WoujiaKLvELB7c0bp1e0PJtDf23hzB4PS5OFY42CcF?=
 =?us-ascii?Q?30YkV5jGPfLvRtlzuwMoCA2SpBzM8+p8iI9Z+ufYwjtkTGtPE9Q6pCNueo2f?=
 =?us-ascii?Q?Ju1hPCbnMV8FhBbFtQ4AVbAFpvMsNDKrLim4gLy0TXPknmHPPXh/KkvQSPyD?=
 =?us-ascii?Q?GGLDaNsR9FHsRUZ7JndpY/tSMyyiuyB8LanioS8XMh40yWy7Al0Qb/CphX4z?=
 =?us-ascii?Q?wIAP+lh+mJ9FIAg6YW3Rk2VHZNKEEYkTqf3JCR38Z8qiKJPeegIv+5XFVLQ3?=
 =?us-ascii?Q?DpmvIU3cI7xtCzMx4D1aWmUogQThHoDNlBkHombCzE2rg4rF97S4PEeUZaMT?=
 =?us-ascii?Q?lWX+CMlBtYt4Hbaw8JyMlJSaE7rB8O9IPuz8SpMq+ooLtYqJPNxhyCWzpGcq?=
 =?us-ascii?Q?hKzfnpgcHV9eNoMqifb95Kv9QNYggXqrvwg1yAbEH29PVkq/MbtoaxlPZ1DU?=
 =?us-ascii?Q?5UYqgaSbDdM7TzMM3VXMjmZ75KuwvRxx0UYR7agWzrKQuEC4MO23cmj/MVYK?=
 =?us-ascii?Q?J22mcvNQ2BC66G2kanl1FZPepn6wFmnLmWeFqZtyXqEmMMWx5bvHYfE9MY8W?=
 =?us-ascii?Q?Vc1fOkTbMk+Mtw/3aZmKveYXZa3ZbTw5exo28n2oY+De2YMqwlGELQcxTnJt?=
 =?us-ascii?Q?1+xSCL4Wr3KJTPkhJGzvGnBpipPzH4cYG0OAA+bvo7q2Uoy65y8iFjjQi/yF?=
 =?us-ascii?Q?fiduMIdJzeP1EC6/x8q58u6huqyhTJBk4XkLNVfDLXqhDen49SF51XcLopW8?=
 =?us-ascii?Q?Fxsx4XcAG/fSw1uhdzbR2GEip9pFkQXTT6a7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:59:03.1365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd5e06d-414d-4a45-1a03-08dd84877280
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7646FEBB5

Add a simple user_data for an input-to-output loopback test.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 13 +++++++++++++
 drivers/iommu/iommufd/selftest.c     | 19 +++++++++++++++++++
 2 files changed, 32 insertions(+)

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
index 8b8ba4fb91cd..b04bd2fbc53d 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -740,16 +740,35 @@ mock_viommu_alloc(struct device *dev, struct iommu_domain *domain,
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
 	mock_viommu = iommufd_viommu_alloc(ictx, struct mock_viommu, core,
 					   &mock_viommu_ops);
 	if (IS_ERR(mock_viommu))
 		return ERR_CAST(mock_viommu);
 
+	if (user_data) {
+		data.out_data = data.in_data;
+		rc = iommu_copy_struct_to_user(
+			user_data, &data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
+		if (rc) {
+			iommufd_struct_destroy(ictx, mock_viommu, core);
+			return ERR_PTR(rc);
+		}
+	}
+
 	refcount_inc(&mock_iommu->users);
 	return &mock_viommu->core;
 }
-- 
2.43.0


