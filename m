Return-Path: <linux-kselftest+bounces-36625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83276AF9D5C
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F42B587C13
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A2A217716;
	Sat,  5 Jul 2025 01:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mKplzH0i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009F318C332;
	Sat,  5 Jul 2025 01:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678077; cv=fail; b=SI1lwQfTzdHpvb06h1tCTji5Uz/CVobJ8XK45pPeHYJk/KP6FKdw1f78frf3P4vlaaPI+FIoWLQ6hmW+dhwN+e2aHnkxrk+ZXyoENCd3yBveyGvRbuWzhc8MzdDd2aBFUOpUNDOsDQYyFxNMTSlgi2z2LV23WOHIJwRUHF4uxbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678077; c=relaxed/simple;
	bh=Jmj56LA9Lc5y8O5AEPt0ugXHDnhiEpbjXvvJou1nfpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yv/vG1V6l2WVXflrJbryODjWaSumvccmeKyxDAHJKlFwXAIMQtgjvdfNM8HPGS4x8bjapTWm4vdqIOlgidMHqIImW8B+JCMWp9/ht9+ShOwbeR5uy4DjNIsCN81xzAStRgF3h8xuJAGVRFSFRpdd+EqY/x9xaTgFTY3DkxyIH5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mKplzH0i; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbTwh+FZf5sFx9RPYJ04DA+emeFJKcSr8skt5GsPjAmUUg0/o+RrHyo0dI55T6vuj9PO8VBmPh3x4CHEfllLqCQcsr679PNYwp+MnrRtrwBKg5whqvj68c2dyQxPde2CA/GU7pTz0PFbxx8+LvFCyXsx7DefyIT5rJ0phkdbSSH4l6PtGqeDFTDCxR6R2j1mIeTgN2U9XCYiCwwaMzvmLSeoetbqAF/zRabfJYTYllKptYQt7C74pKCzvFhNca/in3hW/waTVk3Q9dqYOsUEtCqhER0GOplbHIh6ZYvjBjYOIcmMHfyBA2bkWuYS+8MWSKE3YXURG2Hz/6ahw5VDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQ6M0Gs+QDWoYwXJGODrAO+OjNUtfwBxMpxvtKaRSm8=;
 b=gzLpsas7OnVWvHjSr30ORNkXkRxI7sbJZViAWjqb9UkVqVVZ7YZxTzJMfikQfgGF1laOPPVY5mXJX1vl1ixu1z2rP86Gw5Nwjw5+cvOFfXtgIUUB0AV8M34CktNSqSOd26F9UisfiF41srXptjDhEMu+A0eZ3aQ8uEJuTVr5euMdIUurrI8FY10LOZFwtxk7icfYGoHKVUGfPlLNAg4Q2vR9J/yrF8/vigVzCmcTfzxlmZRiS7F395aGRkaoSkmrqqEZXv4dJEpN6LLK/2shQT++pJDv4vTj0FFjK+5xwSgfRhxIObh+ASvjjnWbDA81oLwiQ/xPcH699T0TLehlyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQ6M0Gs+QDWoYwXJGODrAO+OjNUtfwBxMpxvtKaRSm8=;
 b=mKplzH0i4/AOJOSUuBV3ijqV36aHOjniYkBH5G/WWK4u+EACt3tAciswXDAnvuwOz4GFBATISk81HfbiTKcCJMLfxzKlL6mg9Mur9qxlnIBa5omzu76/grqoELv3uJlTCJz8enWw08iavMtWad2PZPR11j9EJPc1MQzco5xXW/HJpxawf3A/qb6SrXihNjELZ1MmOVGwNUsuhuAWvJBB//2DmsMStkHTBM2xlRBd5nMEt2yfLpPrvIOOPUFbWwrZ4Iro/KkrqMJ+oqi6IfGG9kKGrSlo1tizyNXUIWUkAV0O6lrJUZLR5pMpcRku8RAgYVRE82uOhKFZVyphi8pC5Q==
Received: from BN9P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::7)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Sat, 5 Jul
 2025 01:14:30 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::46) by BN9P220CA0002.outlook.office365.com
 (2603:10b6:408:13e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Sat,
 5 Jul 2025 01:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:20 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:18 -0700
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
Subject: [PATCH v8 16/29] iommufd/selftest: Add coverage for IOMMUFD_CMD_HW_QUEUE_ALLOC
Date: Fri, 4 Jul 2025 18:13:32 -0700
Message-ID: <bc058b87bee19c9fa0f39f0a88424a3408fbc275.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: 2356591f-161f-4aa3-e150-08ddbb614afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hJ06hP3f7hzMpXq+gptDV3tzkSX3qtiEobzr7S9Br0JKV5P91zUgwY43uii5?=
 =?us-ascii?Q?iJtCkyFK/kTXp82SabImTMoA+fCmrlQCdd9AH6X+/gqhwPfSWq9qsolWljUR?=
 =?us-ascii?Q?D3ygqhR/F3XCI+v03M7E89hZIngbu53kprWd/J2jrxe0ACohTEEKF22fbZ86?=
 =?us-ascii?Q?/VyUUCrj1m4Jhm2RA/5Zn58HcH3SB003PCn5y9KXN4W2J0enWOek5b3RD7qo?=
 =?us-ascii?Q?eptnCpAulFbS4JRuLjzu6c0wezFITwog7Q0sWFenOT1s60t3UtOysosh1Nda?=
 =?us-ascii?Q?+CLqz22tD5xMoxDW1TufOb65z7bpv5CObjpuLOopGEZ+jYwmYyQE3M87QfKV?=
 =?us-ascii?Q?Kb0DgwWF2BKeY77KqUeX0n+f8lhQ/72AOqNtYcdw7Oug2XvM8q74zVuopE3i?=
 =?us-ascii?Q?HU2BaWQuU10nxhln0ONgS9kE81w7gm3WVj6EDIa62WztaDCyJIAMte5PAQCu?=
 =?us-ascii?Q?7sJgOt8n8lBAFgJ0vkzuG9Fj2m5GdM+hpbh4OIcO/v/DE0NuYOzIexaRTxbe?=
 =?us-ascii?Q?g0y6jwF6026hZyYcvQyq7E3sXji8IC5TJnVoSPVAi1l4GzwNAkt1UxzMxSwH?=
 =?us-ascii?Q?Fw0Q8rPdV4AWPJXzh9PWZ22aLJOt1fSgYiaGwgO2GhOE/pzXroJ3x3ZOmGN8?=
 =?us-ascii?Q?oX6ibiTz+VjubgNPwiaUObxvFA8TRU01X2QO+7odgCW5XXMWvRK7+hILCpNd?=
 =?us-ascii?Q?IsP7Wcyks51PMDypw5Y22fdUGgPTFSWuVkQVyjPFf5Wj8sJeXrTqxVc2e3x0?=
 =?us-ascii?Q?JsgAJb4pROkj0IrV/k3ZhAxBJeNQJeQmQ4CYQ7YGlz1f2BphES9mjjh01/ql?=
 =?us-ascii?Q?xFZLXSN0H43Y2bOSKnEzGWCOmDDFWx3qe6jCk4dJoVioklxuSTiRE93Nri8f?=
 =?us-ascii?Q?Jijgnn6nnvg1AMDPYw7Fq7/GE114FmyJu/mfa3+nV78mzT7mxo32rsBUBEJL?=
 =?us-ascii?Q?oWnaiHG9xnQCjwUXQrUAESp6BGZHck2DoBU+GlPjjW2NfLvV8pWh7srrBOk+?=
 =?us-ascii?Q?p9B4t5R4aepslf71PeUKqrV+9861yTa31aSRx0+e4N5decBuI+/LqYBT2OL2?=
 =?us-ascii?Q?lSvC8IYGNKqSVwPVoynCEHcWSgxr7ZVfKs25NEdC9gVlNCgzdfgTbEc3c47Y?=
 =?us-ascii?Q?oO2SJhKLKiop9HEAmsN7I0yc2njXzJzfDjO+KrrS/Iu7K2uPsUO3qSu6M4Zx?=
 =?us-ascii?Q?MPEGPuMwu2rptlcxgiozD0V48MtdZvDK35Y+RGoHmzrBASQpGJPQFhUAsU0y?=
 =?us-ascii?Q?Coe4WKpc7UfpRM+skAn9Med0paT4Q9iLiMhMnaNYSUp44HD5OQL+GaIFSSrL?=
 =?us-ascii?Q?Nddo3Hf76BLCC0xXIey0oTs/3pxtZ0qUcVusaFsT9wGWeGzy/ncvVvlB2V32?=
 =?us-ascii?Q?8OS04An7Bji2Vf+RRpOLqarMc6dP7egQDb/2pSrrtvfo2AOln1YNt0r4vIOQ?=
 =?us-ascii?Q?ZWwX94z+ztfzyGkYLef9LExZMG3JSFVq9O1fthsj1dVddw3adERRwkvlF4H4?=
 =?us-ascii?Q?GNZCOWj56tDVuBDY8dNrJLs64RYbPIR2AGGB?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:29.8883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2356591f-161f-4aa3-e150-08ddbb614afc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381

Some simple tests for IOMMUFD_CMD_HW_QUEUE_ALLOC infrastructure covering
the new iommufd_hw_queue_depend/undepend() helpers.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  3 +
 tools/testing/selftests/iommu/iommufd_utils.h | 31 ++++++
 drivers/iommu/iommufd/selftest.c              | 97 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 58 +++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  6 ++
 5 files changed, 195 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index fbf9ecb35a13..51cd744a354f 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -265,4 +265,7 @@ struct iommu_viommu_event_selftest {
 	__u32 virt_id;
 };
 
+#define IOMMU_HW_QUEUE_TYPE_SELFTEST 0xdeadbeef
+#define IOMMU_TEST_HW_QUEUE_MAX 2
+
 #endif
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index a5d4cbd089ba..9a556f99d992 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -956,6 +956,37 @@ static int _test_cmd_vdevice_alloc(int fd, __u32 viommu_id, __u32 idev_id,
 		     _test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id,   \
 					     virt_id, vdev_id))
 
+static int _test_cmd_hw_queue_alloc(int fd, __u32 viommu_id, __u32 type,
+				    __u32 idx, __u64 base_addr, __u64 length,
+				    __u32 *hw_queue_id)
+{
+	struct iommu_hw_queue_alloc cmd = {
+		.size = sizeof(cmd),
+		.viommu_id = viommu_id,
+		.type = type,
+		.index = idx,
+		.nesting_parent_iova = base_addr,
+		.length = length,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_HW_QUEUE_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (hw_queue_id)
+		*hw_queue_id = cmd.out_hw_queue_id;
+	return 0;
+}
+
+#define test_cmd_hw_queue_alloc(viommu_id, type, idx, base_addr, len, out_qid) \
+	ASSERT_EQ(0, _test_cmd_hw_queue_alloc(self->fd, viommu_id, type, idx,  \
+					      base_addr, len, out_qid))
+#define test_err_hw_queue_alloc(_errno, viommu_id, type, idx, base_addr, len, \
+				out_qid)                                      \
+	EXPECT_ERRNO(_errno,                                                  \
+		     _test_cmd_hw_queue_alloc(self->fd, viommu_id, type, idx, \
+					      base_addr, len, out_qid))
+
 static int _test_cmd_veventq_alloc(int fd, __u32 viommu_id, __u32 type,
 				   __u32 *veventq_id, __u32 *veventq_fd)
 {
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 38066dfeb2e7..2189e9b119ee 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -150,6 +150,8 @@ to_mock_nested(struct iommu_domain *domain)
 struct mock_viommu {
 	struct iommufd_viommu core;
 	struct mock_iommu_domain *s2_parent;
+	struct mock_hw_queue *hw_queue[IOMMU_TEST_HW_QUEUE_MAX];
+	struct mutex queue_mutex;
 };
 
 static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
@@ -157,6 +159,19 @@ static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
 	return container_of(viommu, struct mock_viommu, core);
 }
 
+struct mock_hw_queue {
+	struct iommufd_hw_queue core;
+	struct mock_viommu *mock_viommu;
+	struct mock_hw_queue *prev;
+	u16 index;
+};
+
+static inline struct mock_hw_queue *
+to_mock_hw_queue(struct iommufd_hw_queue *hw_queue)
+{
+	return container_of(hw_queue, struct mock_hw_queue, core);
+}
+
 enum selftest_obj_type {
 	TYPE_IDEV,
 };
@@ -670,9 +685,11 @@ static void mock_viommu_destroy(struct iommufd_viommu *viommu)
 {
 	struct mock_iommu_device *mock_iommu = container_of(
 		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
+	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
 
 	if (refcount_dec_and_test(&mock_iommu->users))
 		complete(&mock_iommu->complete);
+	mutex_destroy(&mock_viommu->queue_mutex);
 
 	/* iommufd core frees mock_viommu and viommu */
 }
@@ -764,10 +781,86 @@ static int mock_viommu_cache_invalidate(struct iommufd_viommu *viommu,
 	return rc;
 }
 
+static size_t mock_viommu_get_hw_queue_size(struct iommufd_viommu *viommu,
+					    enum iommu_hw_queue_type queue_type)
+{
+	if (queue_type != IOMMU_HW_QUEUE_TYPE_SELFTEST)
+		return 0;
+	return HW_QUEUE_STRUCT_SIZE(struct mock_hw_queue, core);
+}
+
+static void mock_hw_queue_destroy(struct iommufd_hw_queue *hw_queue)
+{
+	struct mock_hw_queue *mock_hw_queue = to_mock_hw_queue(hw_queue);
+	struct mock_viommu *mock_viommu = mock_hw_queue->mock_viommu;
+
+	mutex_lock(&mock_viommu->queue_mutex);
+	mock_viommu->hw_queue[mock_hw_queue->index] = NULL;
+	if (mock_hw_queue->prev)
+		iommufd_hw_queue_undepend(mock_hw_queue, mock_hw_queue->prev,
+					  core);
+	mutex_unlock(&mock_viommu->queue_mutex);
+}
+
+/* Test iommufd_hw_queue_depend/undepend() */
+static int mock_hw_queue_init_phys(struct iommufd_hw_queue *hw_queue, u32 index,
+				   phys_addr_t base_addr_pa)
+{
+	struct mock_viommu *mock_viommu = to_mock_viommu(hw_queue->viommu);
+	struct mock_hw_queue *mock_hw_queue = to_mock_hw_queue(hw_queue);
+	struct mock_hw_queue *prev = NULL;
+	int rc = 0;
+
+	if (index >= IOMMU_TEST_HW_QUEUE_MAX)
+		return -EINVAL;
+
+	mutex_lock(&mock_viommu->queue_mutex);
+
+	if (mock_viommu->hw_queue[index]) {
+		rc = -EEXIST;
+		goto unlock;
+	}
+
+	if (index) {
+		prev = mock_viommu->hw_queue[index - 1];
+		if (!prev) {
+			rc = -EIO;
+			goto unlock;
+		}
+	}
+
+	/*
+	 * Test to catch a kernel bug if the core converted the physical address
+	 * incorrectly. Let mock_domain_iova_to_phys() WARN_ON if it fails.
+	 */
+	if (base_addr_pa != iommu_iova_to_phys(&mock_viommu->s2_parent->domain,
+					       hw_queue->base_addr)) {
+		rc = -EFAULT;
+		goto unlock;
+	}
+
+	if (prev) {
+		rc = iommufd_hw_queue_depend(mock_hw_queue, prev, core);
+		if (rc)
+			goto unlock;
+	}
+
+	mock_hw_queue->prev = prev;
+	mock_hw_queue->mock_viommu = mock_viommu;
+	mock_viommu->hw_queue[index] = mock_hw_queue;
+
+	hw_queue->destroy = &mock_hw_queue_destroy;
+unlock:
+	mutex_unlock(&mock_viommu->queue_mutex);
+	return rc;
+}
+
 static struct iommufd_viommu_ops mock_viommu_ops = {
 	.destroy = mock_viommu_destroy,
 	.alloc_domain_nested = mock_viommu_alloc_domain_nested,
 	.cache_invalidate = mock_viommu_cache_invalidate,
+	.get_hw_queue_size = mock_viommu_get_hw_queue_size,
+	.hw_queue_init_phys = mock_hw_queue_init_phys,
 };
 
 static size_t mock_get_viommu_size(struct device *dev,
@@ -784,6 +877,7 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 {
 	struct mock_iommu_device *mock_iommu = container_of(
 		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
+	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
 	struct iommu_viommu_selftest data;
 	int rc;
 
@@ -801,6 +895,9 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 	}
 
 	refcount_inc(&mock_iommu->users);
+	mutex_init(&mock_viommu->queue_mutex);
+	mock_viommu->s2_parent = to_mock_domain(parent_domain);
+
 	viommu->ops = &mock_viommu_ops;
 	return 0;
 }
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index a9dfcce5e1b2..6b88c250b505 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3032,6 +3032,64 @@ TEST_F(iommufd_viommu, vdevice_cache)
 	}
 }
 
+TEST_F(iommufd_viommu, hw_queue)
+{
+	__u64 iova = MOCK_APERTURE_START, iova2;
+	uint32_t viommu_id = self->viommu_id;
+	uint32_t hw_queue_id[2];
+
+	if (!viommu_id)
+		SKIP(return, "Skipping test for variant no_viommu");
+
+	/* Fail IOMMU_HW_QUEUE_TYPE_DEFAULT */
+	test_err_hw_queue_alloc(EOPNOTSUPP, viommu_id,
+				IOMMU_HW_QUEUE_TYPE_DEFAULT, 0, iova, PAGE_SIZE,
+				&hw_queue_id[0]);
+	/* Fail queue addr and length */
+	test_err_hw_queue_alloc(EINVAL, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+				0, iova, 0, &hw_queue_id[0]);
+	test_err_hw_queue_alloc(EOVERFLOW, viommu_id,
+				IOMMU_HW_QUEUE_TYPE_SELFTEST, 0, ~(uint64_t)0,
+				PAGE_SIZE, &hw_queue_id[0]);
+	/* Fail missing iova */
+	test_err_hw_queue_alloc(ENOENT, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+				0, iova, PAGE_SIZE, &hw_queue_id[0]);
+
+	/* Map iova */
+	test_ioctl_ioas_map(buffer, PAGE_SIZE, &iova);
+	test_ioctl_ioas_map(buffer + PAGE_SIZE, PAGE_SIZE, &iova2);
+
+	/* Fail index=1 and =MAX; must start from index=0 */
+	test_err_hw_queue_alloc(EIO, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST, 1,
+				iova, PAGE_SIZE, &hw_queue_id[0]);
+	test_err_hw_queue_alloc(EINVAL, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+				IOMMU_TEST_HW_QUEUE_MAX, iova, PAGE_SIZE,
+				&hw_queue_id[0]);
+
+	/* Allocate index=0, declare ownership of the iova */
+	test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST, 0,
+				iova, PAGE_SIZE, &hw_queue_id[0]);
+	/* Fail duplicate */
+	test_err_hw_queue_alloc(EEXIST, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+				0, iova, PAGE_SIZE, &hw_queue_id[0]);
+	/* Fail unmap, due to iova ownership */
+	test_err_ioctl_ioas_unmap(EBUSY, iova, PAGE_SIZE);
+	/* The 2nd page is not pinned, so it can be unmmap */
+	test_ioctl_ioas_unmap(iova + PAGE_SIZE, PAGE_SIZE);
+
+	/* Allocate index=1 */
+	test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST, 1,
+				iova, PAGE_SIZE, &hw_queue_id[1]);
+	/* Fail to destroy, due to dependency */
+	EXPECT_ERRNO(EBUSY, _test_ioctl_destroy(self->fd, hw_queue_id[0]));
+
+	/* Destroy in descending order */
+	test_ioctl_destroy(hw_queue_id[1]);
+	test_ioctl_destroy(hw_queue_id[0]);
+	/* Now it can unmap the first page */
+	test_ioctl_ioas_unmap(iova, PAGE_SIZE);
+}
+
 FIXTURE(iommufd_device_pasid)
 {
 	int fd;
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index f7ccf1822108..41c685bbd252 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -634,6 +634,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t idev_id;
 	uint32_t hwpt_id;
 	uint32_t viommu_id;
+	uint32_t hw_queue_id;
 	uint32_t vdev_id;
 	__u64 iova;
 
@@ -696,6 +697,11 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	if (_test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id, 0, &vdev_id))
 		return -1;
 
+	if (_test_cmd_hw_queue_alloc(self->fd, viommu_id,
+				     IOMMU_HW_QUEUE_TYPE_SELFTEST, 0, iova,
+				     PAGE_SIZE, &hw_queue_id))
+		return -1;
+
 	if (_test_ioctl_fault_alloc(self->fd, &fault_id, &fault_fd))
 		return -1;
 	close(fault_fd);
-- 
2.43.0


