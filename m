Return-Path: <linux-kselftest+bounces-36629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C5EAF9D64
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682351CA12EB
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1552206B8;
	Sat,  5 Jul 2025 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Eaxb3MAf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4317B21A92F;
	Sat,  5 Jul 2025 01:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678087; cv=fail; b=MaL+jMgLhfEnoizz+xror3yMonYhkqVAOuY2cTY4fTJ7xv2HSxoLZVrRbFmgoUQDXY2P7Io898o+MzSC/f46OO+W79PqRKKGREvVzKQZ+ye5WADdjaUhj6XN0TGVhedtC9OTWh1F7WuUPxMS9N9VXqI3H1omcls+RouGAAC7dpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678087; c=relaxed/simple;
	bh=EdOM9QHRlAcrqCN3Mzn+4QLLSjbZswnwF0LSFVvbtzc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rM/RlzPILCBmHd/nnf2PwAMjwgJIOHXuESDg8dMBLHrJHjDszbgKiPdf8eOtPZIWCYPPva8CPpK/gMaz+wakJpFtd+o1XJklNoG3etEr0L/RMrDzQUoaP0rZBZc7A8ocpH1BWTe5jMIISfcm3mLo9cyEysNV1HhWIyAfaiUMjkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Eaxb3MAf; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2jlF8Q0XZF2Our0ya4aobGDqmrILhysu2rNpHQavHm0r7qwj6yOdmu9O8IOhh0iqxYQ50lVQrk5wxQatRmagh513SysTGjpP438eN2byve/1KAPZ5PoBRhA7Zei+zCT01EgRND65I9jf0llUc2Lxv5lLKwLEocuPjH7EtfqUpJV489wqjTsx90qTnpEbkYEeQW9M71YT8x99sbmgb/goGECPIO1nwwNS4v1l2JKzSLDqYz/NnI5EkgHu5atYsCqnaTJEUomqD05D5iBg/DJvadVqhniI4MwfjHf5BnJeIpKONg3iFwcxxHW4WujuoT4vdVlNKzyQVOE5fVtSAvCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifkQ+IrGRBEdFrMzYf/bTiOMG5HMPEEbl0c0nAcuDI8=;
 b=gIzsR2BE83c3Lze/emLLQ5Ms2WeU5xoriDA04EzVcuAf06+ON2y3CIf5UsWYivgXiriaRcIILhF+LQs/EvjdozcokNFiVwJaWsdz+0LIY+KiyE6Cfiw4Uy0Lv9LdiiQaFJISX2Y3EguFiWf30Fkb1W05e/tYvQ1ViE4vzVvITl7TIKi4SyFuRNHrhLQiZ8TvD5SSsMBjCXehM0Q8n/0L9oRM93LfV3u8pH/JUhWjigxcbhXxYcbL1aBm929PHnSnMVE3JXwJHUgVTKb8tJO3suKRrvzDB2RVC8sCEf2kuIbKfwOtkpAZumQP0sB8QKjGSi1lUufX3DVeHoSNgZSn3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifkQ+IrGRBEdFrMzYf/bTiOMG5HMPEEbl0c0nAcuDI8=;
 b=Eaxb3MAfi+Xd4B84Gy0QTC4yhrD9MQoiIT3iDlU+yxcWkbAmzxAiyfq+EI6pQ5ziPrVgEr6vNqd0S1t0xZRuAsI+viD8Hdw6HDvZSXSkrABn4WkoT8ijd5g8AXY+sc+CICBxbtVEnRo0ULXLdPDLXzm48tr0c6GY4XqkMJzoXZgT7LzJQf7svKl23kLqLpCt/u3P6weNDz4zyclEBk+3QAvYd394KBrvqkb/KIE4CJXCr82ku/RZFPQPfzmIGp8QJZUyitJJSvutMUXYjUxuNqlCMGTWT06qEtMEngrMOIUL4DDzJRrVAB3T7pfU/Ig0WT2VVOAMmeaqfZ775LvJLg==
Received: from SJ0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:a03:331::10)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Sat, 5 Jul
 2025 01:14:39 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::43) by SJ0PR03CA0065.outlook.office365.com
 (2603:10b6:a03:331::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Sat,
 5 Jul 2025 01:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:22 -0700
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
Subject: [PATCH v8 18/29] iommufd/selftest: Add coverage for the new mmap interface
Date: Fri, 4 Jul 2025 18:13:34 -0700
Message-ID: <33765a9adeb770c5377ed5cca4c6c77240c0fe6c.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c90965-b08c-43cc-277e-08ddbb615084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?daEhEHC7F9+F2d4+NXGOQdxefsaAy9I7CgxzPaxL6Pq1qhABtpFhvtargNhe?=
 =?us-ascii?Q?l3Q2NjM6YUjiuDWe78hBeZpXHGjbjYT40k1D/xKjP7nS9l78/RHxehrkZ3rp?=
 =?us-ascii?Q?SSqJnpY+EgVyMO9fMkXUQvMnCYfPbts4bKN2hmrId5KTeM0X3Qbr6Dz0y1HE?=
 =?us-ascii?Q?nRZeF9w3Q3khEzoJZBdzJvQn2G7H6KGaPLdwaAiHpQ7ORb3iFa5bk3fmjJcR?=
 =?us-ascii?Q?Uq3eOqamcRUhKPyRPHk4K2fO+tUfJYLQpaIAU/BuhIqRLd1zdjU54U5X07A+?=
 =?us-ascii?Q?veP+/rGC1f8YT73ZmL+aNJq7Q8At996hLiPC69YVVSH53v96VWlwCCTxJMEK?=
 =?us-ascii?Q?fVq+Nwsi/o9kOIv8sxi6xrRvFao5AUGRA9n1BG6gFJ9rZLKTTy/o2GFVAWCn?=
 =?us-ascii?Q?l1jWQTr0vnefgjAnR10EUaSr88NakOLoORMVVwfJ9iTaEqYlfId5cRmsvo+K?=
 =?us-ascii?Q?zkxcz6ExDhd8uHY0oqwrzielk8vRglBdMPu4iV/J3UENZP+BGGPgLwgZZtuk?=
 =?us-ascii?Q?kZA8URO78eAosFoCyjkP5nc6fFQsKrdddTzmoS1xcrtRwVr/73ZJ9BtfmkDN?=
 =?us-ascii?Q?zVTgoUUwFEbSvV0nVVv+Zige4b+XLAWMCAWehJ1w8/kd5KJ8M/ZcVeHvh3i1?=
 =?us-ascii?Q?8TgewoEHxudglvAvneyAisj0fOiEwXv5LBnb5H/mK39vR6zPSIJX59MIoPCc?=
 =?us-ascii?Q?PKVVQlmhWNmjAEL8B72AL6euv6sSC9E8c9P+J1nrhMRr1WD+ThqAUcsJnSYN?=
 =?us-ascii?Q?WOEuXRyeG/2LM7VjZD7Bwpqw+r5vBxGGhtUGLYorYlen0+lmIfykqseBPagw?=
 =?us-ascii?Q?3a6DduobU5snpEy6ENnC0xeE5+HOa4MTdIrjHWYsaowOBB2I0nUAnwWlSwk3?=
 =?us-ascii?Q?PKdF8quy5ZNWLy/If/fdEuZNs2q+q1K0ijsquhVfTFnNDAOUHL1T2K3m6EdK?=
 =?us-ascii?Q?6w6EUc9KZ18/KGIOxFlgBwKLlkhUUfdplo15aIzcPyS7X8WqFspRkPi/0FZX?=
 =?us-ascii?Q?pfPqdtTHdWKiATCJJt7ErBl0HklFvV3ogA3G5FOVziXcMRgg6HxW1InSRTMA?=
 =?us-ascii?Q?kK5+spnwQk4RD8nwJlg9N5sug14g1SX4U2lyeJbs2ptIMD+Fv+zcr/CLgfrL?=
 =?us-ascii?Q?BzO4KvotJtckwSxTXrHO9n8x6Tcub9ebkWDwbSp58YYljB+U1ZI8TPcQQUsb?=
 =?us-ascii?Q?/dZOQ5oIGemb3rDsntW+BnOlmgVmt76CtAqVDOx871RUnwIE2scPY0C1xRep?=
 =?us-ascii?Q?nFgcIsOPccmrlxM/Li2vkg9/t2Ul9mJvUIdsQNVbFgXpmzeq/AQoGc9wwx9r?=
 =?us-ascii?Q?L+iNjp7ZfILHRtlLGfnLGPRWc3Jf6qoeifrjeHpLeKB9lMLYLk27DiRTOV35?=
 =?us-ascii?Q?L5kZSE7sIuiRvI9f/3Df0XCxBcQp9M3BrISvJs44dlPiwLx/KXQg+RPJeDAV?=
 =?us-ascii?Q?C2t/GOcazGMwJCJvAwfIeCGHiyjOnYth6bdqGktBFQPeYNivL4Y3EFsxIhqS?=
 =?us-ascii?Q?cZTp2ZTFfkHaBqK66Jp+28s4nMnGdM4v0jgy?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:39.2787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c90965-b08c-43cc-277e-08ddbb615084
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114

Extend the loopback test to a new mmap page.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  4 +++
 tools/testing/selftests/iommu/iommufd_utils.h |  4 +++
 drivers/iommu/iommufd/selftest.c              | 33 ++++++++++++++++++-
 tools/testing/selftests/iommu/iommufd.c       | 19 +++++++++++
 4 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 51cd744a354f..8fc618b2bcf9 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -232,12 +232,16 @@ struct iommu_hwpt_invalidate_selftest {
  *                                (IOMMU_VIOMMU_TYPE_SELFTEST)
  * @in_data: Input random data from user space
  * @out_data: Output data (matching @in_data) to user space
+ * @out_mmap_offset: The offset argument for mmap syscall
+ * @out_mmap_length: The length argument for mmap syscall
  *
  * Simply set @out_data=@in_data for a loopback test
  */
 struct iommu_viommu_selftest {
 	__u32 in_data;
 	__u32 out_data;
+	__aligned_u64 out_mmap_offset;
+	__aligned_u64 out_mmap_length;
 };
 
 /* Should not be equal to any defined value in enum iommu_viommu_invalidate_data_type */
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 9a556f99d992..4a1b2bade018 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -56,6 +56,10 @@ static unsigned long PAGE_SIZE;
 #define offsetofend(TYPE, MEMBER) \
 	(offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
 
+#define test_err_mmap(_errno, length, offset)                                 \
+	EXPECT_ERRNO(_errno, (long)mmap(NULL, length, PROT_READ | PROT_WRITE, \
+					MAP_SHARED, self->fd, offset))
+
 static inline void *memfd_mmap(size_t length, int prot, int flags, int *mfd_p)
 {
 	int mfd_flags = (flags & MAP_HUGETLB) ? MFD_HUGETLB : 0;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 2189e9b119ee..8b2c44b32530 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -152,6 +152,9 @@ struct mock_viommu {
 	struct mock_iommu_domain *s2_parent;
 	struct mock_hw_queue *hw_queue[IOMMU_TEST_HW_QUEUE_MAX];
 	struct mutex queue_mutex;
+
+	unsigned long mmap_offset;
+	u32 *page; /* Mmap page to test u32 type of in_data */
 };
 
 static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
@@ -689,6 +692,10 @@ static void mock_viommu_destroy(struct iommufd_viommu *viommu)
 
 	if (refcount_dec_and_test(&mock_iommu->users))
 		complete(&mock_iommu->complete);
+	if (mock_viommu->mmap_offset)
+		iommufd_viommu_destroy_mmap(&mock_viommu->core,
+					    mock_viommu->mmap_offset);
+	free_page((unsigned long)mock_viommu->page);
 	mutex_destroy(&mock_viommu->queue_mutex);
 
 	/* iommufd core frees mock_viommu and viommu */
@@ -887,11 +894,28 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 		if (rc)
 			return rc;
 
+		/* Allocate two pages */
+		mock_viommu->page =
+			(u32 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
+		if (!mock_viommu->page)
+			return -ENOMEM;
+
+		rc = iommufd_viommu_alloc_mmap(&mock_viommu->core,
+					       __pa(mock_viommu->page),
+					       PAGE_SIZE * 2,
+					       &mock_viommu->mmap_offset);
+		if (rc)
+			goto err_free_page;
+
+		/* For loopback tests on both the page and out_data */
+		*mock_viommu->page = data.in_data;
 		data.out_data = data.in_data;
+		data.out_mmap_length = PAGE_SIZE * 2;
+		data.out_mmap_offset = mock_viommu->mmap_offset;
 		rc = iommu_copy_struct_to_user(
 			user_data, &data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
 		if (rc)
-			return rc;
+			goto err_destroy_mmap;
 	}
 
 	refcount_inc(&mock_iommu->users);
@@ -900,6 +924,13 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 
 	viommu->ops = &mock_viommu_ops;
 	return 0;
+
+err_destroy_mmap:
+	iommufd_viommu_destroy_mmap(&mock_viommu->core,
+				    mock_viommu->mmap_offset);
+err_free_page:
+	free_page((unsigned long)mock_viommu->page);
+	return rc;
 }
 
 static const struct iommu_ops mock_ops = {
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 6b88c250b505..8b85f6fc8cd0 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2799,6 +2799,7 @@ TEST_F(iommufd_viommu, viommu_alloc_with_data)
 	struct iommu_viommu_selftest data = {
 		.in_data = 0xbeef,
 	};
+	uint32_t *test;
 
 	if (!self->device_id)
 		SKIP(return, "Skipping test for variant no_viommu");
@@ -2807,6 +2808,24 @@ TEST_F(iommufd_viommu, viommu_alloc_with_data)
 			      IOMMU_VIOMMU_TYPE_SELFTEST, &data, sizeof(data),
 			      &self->viommu_id);
 	ASSERT_EQ(data.out_data, data.in_data);
+
+	/* Negative mmap tests -- offset and length cannot be changed */
+	test_err_mmap(ENXIO, data.out_mmap_length,
+		      data.out_mmap_offset + PAGE_SIZE);
+	test_err_mmap(ENXIO, data.out_mmap_length,
+		      data.out_mmap_offset + PAGE_SIZE * 2);
+	test_err_mmap(ENXIO, data.out_mmap_length / 2, data.out_mmap_offset);
+	test_err_mmap(ENXIO, data.out_mmap_length * 2, data.out_mmap_offset);
+
+	/* Now do a correct mmap for a loopback test */
+	test = mmap(NULL, data.out_mmap_length, PROT_READ | PROT_WRITE,
+		    MAP_SHARED, self->fd, data.out_mmap_offset);
+	ASSERT_NE(MAP_FAILED, test);
+	ASSERT_EQ(data.in_data, *test);
+
+	/* The owner of the mmap region should be blocked */
+	EXPECT_ERRNO(EBUSY, _test_ioctl_destroy(self->fd, self->viommu_id));
+	munmap(test, data.out_mmap_length);
 }
 
 TEST_F(iommufd_viommu, vdevice_alloc)
-- 
2.43.0


