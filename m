Return-Path: <linux-kselftest+bounces-32126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C13AA6715
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A2787B8A85
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE60D265CCB;
	Thu,  1 May 2025 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o5+tY7Q3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151427BF7E;
	Thu,  1 May 2025 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140550; cv=fail; b=mg4UdiCHnMq6url0qaCauye6/l98yrkl2n/EQm4zyIAPRRlcH8KLAO+N3duVXgcE+kn5G/TekFjW2K12G5vbq/ZXCd/yiyXDs0kPJbzFncTpOXuB2mccVmpfkFSDK+aygjQeomCPNdrE8JQYalULUOx3irol9LyhCn54iFD9hGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140550; c=relaxed/simple;
	bh=GWlxM6zT/BA64j5M+X7mOcB9xG5d4I1K0AFBG2Pbk0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/Ubv1fTFOlctL2hLLNlGvVnRYK/KFDB31b/qW/YGXfW2F3TKqlTzYAxMRv7oDC30zLK27LOLhcz5owwJICv0KVj1dwbcnTcv4MhTjpcU2IgjrHE7ql3I9IxiFGR8cQzgE0beFxR9WlXBqsF/QigxMhqOKHRwGCPtBDGv/TR51w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o5+tY7Q3; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTT/cp6ffuwMYH6hDKMaJgsR2n2HycYsRBMtmrC4ogE/h0nU2EiAJZMo4zCjZqIjOG+zNPH7arTt7dR5YdH14ajJcVL/37PzxPZSrDUf8mEP0ZtuJfZotB15Rqs4kLnthY62BkEP8aOJw3iQlwpnBH9X1q3H3PBA15Fig+xzTIhJDS0fbSESG2iVT32nQBHtxpUx5LuDogEXzQ/OrXJlxSZCzTg11f+n4yAcZ7iiXHqiWqHWaIw7lQ2E2SfqhgGgcpnwuU/n5Pzh7n1vj9M4Z1Rtl2DzbLWbOKOziQFGyKcLQ7qtWRNxzQy90JHY+irxKFy4iHkJXrtCYjU57ibIoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ky+JXqh+AmC8+Oemio4ybcH2Q/0Qbv5QYO3ncIc6P1s=;
 b=hTuiIkAuZpSMar4CQRMuwLzyIjIqDloBD0GKvJ6DoCRXc5Q7bSxag2tYMoCBP4+YblwInQYxOwKYdY/aJ+1QsPyKuFvUfAudn+hEAlguG3XVg5/1DFt5e+u6aSdmIhZbs8T6Tmx5fxQlL0C6qzorr9lB1RzerlD3tVnyPOIUYCr9OPn9KpS/zCUs/soQUFRbhP6IcJskdqw831YSJBBDQl3iid/Qnzwr84mtIBF+hodGQUy8k0zET+Ia8D4xBWjFrKkX3W1NsIc2k0Rf64ew5F4h5Qh+NehV3wUw+Dd0H6Sqlqbm1dl2szp6GGRzaAKwhPcrjPdyZ6ixPKKtUiAV7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky+JXqh+AmC8+Oemio4ybcH2Q/0Qbv5QYO3ncIc6P1s=;
 b=o5+tY7Q3+kQGCwaU3fphTphEzGldRlPXukBNP2yMh8loy5vbq8uvSUYzT18HoumW8RFuJYoTHW5tYs92AZS0n2wF935e8WF/sIpn6a1hMWJTqP2Y+OZH+q1/oeOpaqhWJmj9KEVqZn1U6eK3RZuWWYWgR272eYfU/q8WLeHkSdTG4yor7WnLUT7rG2hXjWULM/8q6VXaS4d/gP4U3lt4fCKcqruJAvjYPjX1CHsckXYcI8aCkhzF7CDWMFJ6fXlTwZSQbS1k7vyKldDq3glWnVr+i4lttEJFPALffCaVRftCPsHOBT+FZ2yRq9vEk9Vrp96m6DjBYopUNC2wOiI85Q==
Received: from SN7PR04CA0215.namprd04.prod.outlook.com (2603:10b6:806:127::10)
 by MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 1 May
 2025 23:02:22 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::77) by SN7PR04CA0215.outlook.office365.com
 (2603:10b6:806:127::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Thu,
 1 May 2025 23:02:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:02:11 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:02:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:02:08 -0700
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
Subject: [PATCH v3 15/23] iommufd/selftest: Add coverage for the new mmap interface
Date: Thu, 1 May 2025 16:01:21 -0700
Message-ID: <0535d69b9856ae42d47185f121ef81547f612c78.1746139811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746139811.git.nicolinc@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|MW6PR12MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be1bde2-65ef-48c1-db7a-08dd89043b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q52dNsQhUxom42l83g6tT6cyWHmIVc/VLKNHNvpxH2aZSf/wkAbCEB2t1dwX?=
 =?us-ascii?Q?GERk7PWLoEVtkcNQeULAeX/q9GjyZ+/MrMgdeRduwe9UYpovdysPcNoVBAYk?=
 =?us-ascii?Q?Bv0pUhIepwRZG11FRnxXGRTYO/RF6Vx10YZ+5JE+OSAfynsX3fBfokyyHYw+?=
 =?us-ascii?Q?/1mEwbRNyGWdxO8C1oJ3g2RKqZ1Slt4nj+QSKK/z80Vvu/qA5HdaX6NDHutU?=
 =?us-ascii?Q?DGPm9nAXWS0BLIr/+dmTmAAQBNXJZ79FLRggwaQ42Z3+UmfuVtx6GlwIVXmv?=
 =?us-ascii?Q?w2p2JUqkUTPVd68CtHuDzkqfKXvlzK/kpUguvQx8nRkrqjEgyOEMiFBAArfD?=
 =?us-ascii?Q?SQiMmso2rrZl19FVrssjX5ir7S+9g27A2Fa+cssxHx18j0mEAhn4+whynAg6?=
 =?us-ascii?Q?Z2o93IRRi2Osbye8InefZqumYtNKV5KDoC3iycyH7acUy8Um5x2u2yEeZl4e?=
 =?us-ascii?Q?k5+KicR9OMyeIqLlQ2PX9sFTIuO0f/T/UVUqstJLzpLaPa77Zf/o/KF2++GR?=
 =?us-ascii?Q?NDh1k1X2lQAq4NyL0A0wo5NsWJfowihRQLWomyzwTldujQlyuDHYVRUH5Kvr?=
 =?us-ascii?Q?/34dnWVvLdsADOef7gxRJW/QNCAKxV+RQGVSW8tfzbuB4XkI+ZuVWgkiiOcK?=
 =?us-ascii?Q?G7xKJzE/1ci2SkPkRzqg0WKtr96zNCG6eD+m+uLUz99mxIjONZZDl1Nu+Cs7?=
 =?us-ascii?Q?BJg/zk2lHm6OaJdCxrMiXkSNjDb+QcMcNAJV16j9bLhM/imPerJvb5cz6xs8?=
 =?us-ascii?Q?o6zoSgI/xLuhqhlSfTgGFlkilsPLdMPlOOYfCpKoBn53JiXdyhNVtBaLScA6?=
 =?us-ascii?Q?y8Px3aI6EcbI/iGV86VWW1o+KMbnG4x7YSlFgSgohC/GzwXnEzVMRWLQ56BI?=
 =?us-ascii?Q?yihOP2NEBgMc9Ih0QEGqSa5w71lBIwRcTBblNT9IDzx1JRtiLm1owXFt9ZrC?=
 =?us-ascii?Q?T9Q2EcC4Pzb3o8NmBElqDH4J3fclIV2HfoF0H4gNwRWMLswUg5cy4LSr+wKy?=
 =?us-ascii?Q?5uLGyZi9zCEwQTfwB60vP9bFgLbk8RFCh0RjANXz0TVBnT0DUbwUj2cldWyb?=
 =?us-ascii?Q?wipLZJBykEwLi44l3SuUS0344ceru6pLZZvmaw8PooSBpRxBrSPW1OIa08rI?=
 =?us-ascii?Q?3scN/scueG9U5fyPQc6L0YMgZYEM458tXWyXQbcpfJf2xDl8NwN2tuPSxLDX?=
 =?us-ascii?Q?yAfM7C0HOxoLGy+acQCSvIm6WHPSt5YfOGWmfHmdKI5jYkX8EGbFw2UHcNLy?=
 =?us-ascii?Q?Zhoh+FtE/GTEMU8a2D1YQkCQdkKox26RQO7oKbvhK+PuOaO2CtpD6z7BloeZ?=
 =?us-ascii?Q?0z+032YhAiOnbDOIrV3b/amRzFsHEil8VI8u44kJMMQlW4i10prPJ5SxRqke?=
 =?us-ascii?Q?Sv4/owXVASaIyFovQTCDAWoHD95ny37X81/54O/dQbj004u+FDWZ6v2JbWuQ?=
 =?us-ascii?Q?Qvf0FQ2stVwI2snQvLSTLU3lKcWFVXMRZM9q9snGZJ2jxnTwm22jfydFGde1?=
 =?us-ascii?Q?dzOeZVMfMOoMd1wpSjPYz77ekNaN6LAAQ4pZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:22.1724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be1bde2-65ef-48c1-db7a-08dd89043b3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7072

Extend the loopback test to a new mmap page.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h    |  4 +++
 drivers/iommu/iommufd/selftest.c        | 40 ++++++++++++++++++++++---
 tools/testing/selftests/iommu/iommufd.c |  7 +++++
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 5c5d425243bb..29eb34cbdb3e 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -232,12 +232,16 @@ struct iommu_hwpt_invalidate_selftest {
  *                                (IOMMU_VIOMMU_TYPE_SELFTEST)
  * @in_data: Input random data from user space
  * @out_data: Output data (matching @in_data) to user space
+ * @out_mmap_pgoff: The offset argument for mmap syscall
+ * @out_mmap_pgsz: Maximum page size for mmap syscall
  *
  * Simply set @out_data=@in_data for a loopback test
  */
 struct iommu_viommu_selftest {
 	__u32 in_data;
 	__u32 out_data;
+	__aligned_u64 out_mmap_pgoff;
+	__aligned_u64 out_mmap_pgsz;
 };
 
 /* Should not be equal to any defined value in enum iommu_viommu_invalidate_data_type */
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 58ce1f6e50ba..04b57b1f2f10 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -149,6 +149,9 @@ struct mock_viommu {
 	struct iommufd_viommu core;
 	struct mock_iommu_domain *s2_parent;
 	struct mock_vqueue *mock_vqueue[IOMMU_TEST_VQUEUE_MAX];
+
+	unsigned long mmap_pgoff;
+	u32 *page; /* Mmap page to test u32 type of in_data */
 };
 
 static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
@@ -645,9 +648,14 @@ static void mock_viommu_destroy(struct iommufd_viommu *viommu)
 {
 	struct mock_iommu_device *mock_iommu = container_of(
 		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
+	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
 
 	if (refcount_dec_and_test(&mock_iommu->users))
 		complete(&mock_iommu->complete);
+	if (mock_viommu->mmap_pgoff)
+		iommufd_viommu_destroy_mmap(mock_viommu, core,
+					    mock_viommu->mmap_pgoff);
+	free_page((unsigned long)mock_viommu->page);
 
 	/* iommufd core frees mock_viommu and viommu */
 }
@@ -827,17 +835,41 @@ mock_viommu_alloc(struct device *dev, struct iommu_domain *domain,
 		return ERR_CAST(mock_viommu);
 
 	if (user_data) {
+		mock_viommu->page =
+			(u32 *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+		if (!mock_viommu->page) {
+			rc = -ENOMEM;
+			goto err_destroy_struct;
+		}
+
+		rc = iommufd_viommu_alloc_mmap(mock_viommu, core,
+					       __pa(mock_viommu->page),
+					       PAGE_SIZE,
+					       &mock_viommu->mmap_pgoff);
+		if (rc)
+			goto err_free_page;
+
+		/* For loopback tests on both the page and out_data */
+		*mock_viommu->page = data.in_data;
 		data.out_data = data.in_data;
+		data.out_mmap_pgsz = PAGE_SIZE;
+		data.out_mmap_pgoff = mock_viommu->mmap_pgoff;
 		rc = iommu_copy_struct_to_user(
 			user_data, &data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
-		if (rc) {
-			iommufd_struct_destroy(mock_viommu, core);
-			return ERR_PTR(rc);
-		}
+		if (rc)
+			goto err_destroy_mmap;
 	}
 
 	refcount_inc(&mock_iommu->users);
 	return &mock_viommu->core;
+
+err_destroy_mmap:
+	iommufd_viommu_destroy_mmap(mock_viommu, core, mock_viommu->mmap_pgoff);
+err_free_page:
+	free_page((unsigned long)mock_viommu->page);
+err_destroy_struct:
+	iommufd_struct_destroy(mock_viommu, core);
+	return ERR_PTR(rc);
 }
 
 static const struct iommu_ops mock_ops = {
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 5e81ccafd155..15c4fe99e598 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2799,12 +2799,19 @@ TEST_F(iommufd_viommu, viommu_alloc_with_data)
 	struct iommu_viommu_selftest data = {
 		.in_data = 0xbeef,
 	};
+	uint32_t *test;
 
 	if (self->device_id) {
 		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
 				      IOMMU_VIOMMU_TYPE_SELFTEST, &data,
 				      sizeof(data), &self->viommu_id);
 		assert(data.out_data == data.in_data);
+		test = mmap(NULL, data.out_mmap_pgsz, PROT_READ | PROT_WRITE,
+			    MAP_SHARED, self->fd, data.out_mmap_pgoff);
+		assert(test && *test == data.in_data);
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, self->viommu_id));
+		munmap(test, data.out_mmap_pgsz);
 	}
 }
 
-- 
2.43.0


