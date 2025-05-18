Return-Path: <linux-kselftest+bounces-33270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DC6ABAD5A
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97402189911A
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F1A21D581;
	Sun, 18 May 2025 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OoW0KmOq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A5021D3C6;
	Sun, 18 May 2025 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538567; cv=fail; b=fSFE8Y7oq2xNEnuwXNuskUbqfcy6/KG6xxmUVoPo8y8OaC2e9neG5Zk424tg7Gvbnd7yPgqOm9PMiN/TLyoCucC5I7g9xWOtSYX8Q0nkOqhQ0AtX7uc1EqXapl2y6RTCao0OaPyFPPX0J8Nt5ylnhrl8m5ERMGzV6y+lwsdjbFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538567; c=relaxed/simple;
	bh=azyR0THSuzBpqlR2ihLimI5bwcVWUryvBycMPwHc1kk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyJooVz0RpJpo/FfmO5Ia9fT1GQiOzQXv8w6Lxngv5ZCIwttenlVmCDUSczXLMGKbZPN7uYtbGLwn5YO22LnmHKxtlf4Sx53lI03DdrEnX1DzhLeTYvnhj6t/MYj4qrwNzL1f5fuoMeJAGGo8tlNupN3RU95mzs6tFN8eVbHsCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OoW0KmOq; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PilsnrZrCxQ3vzmN47THKMuNEWvUMBuB6esLmX/+LXH8EDy9yBltze2mkYyCh8xc/I5VbbN5PApD3S8NmNSa3mPhtZBWC/T34NEUOSXtpl8AKxixErNSJ+77mRWG/ATC7WNp+Rieo5QMkFqFRDLnFG/Oxn6g7rNEmORldOpZ/UmYFYrS9YTIEhUsL5C+7B3rdbYorau/4JJpcYQbXjualn8ifISreO+2c6i38IRVcZf0zi9NLPiI3N2r+R6KwghloA2SF6XPjvTSZ2QcqkqV9sSPnd8MADONxZoFyyiTfSDt3U/qwjjxNH7iQJQKwbHUJ68LMVSTKDPj3QULtf6mxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRhINPUlzXyGpfttH9eSoXGHfcvfNOMesBkU3QHa78I=;
 b=R8B9pPlC0no8idY71Uzn2x8fnBIEpDASWsSS6tBoSDrwWd3V9V3DD+cqIErtgqQFrnkO1DnMixZVoGkLtX80ku98H2pvExIHaVH0d/+wKAacGIcLuLwSRqjXbQhRR+fT/Sk6Mh8MTIyo0mmcrs+jEv7pwaI+MfQSnSPFOQu7B0ewhpbO1AHvwF1V/khD4Nzgzju6sj3ReDMaDPO2iIE9E43YukP2hTxQSODl/JCWimBg8TmpzR/5bEQgmRgEDZ2d/9ewPvKjQ7MB6JBH8ylJUF6aAeVjor+Tqs2kvwt3j2ObDXHNeOftXOYpqCSH2DEBSO5dPbcVO3CwnMex3fB72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRhINPUlzXyGpfttH9eSoXGHfcvfNOMesBkU3QHa78I=;
 b=OoW0KmOqlFZv7Q42r0x0/68nFULqj/Jz+R4uMUCfAQWWeZR/L0X3eL2SPkfgAUXxfgjVaiEMD/gnzE6jv4yPIWkadOgcOw853PcGIjTs7Q4IftjpQ5jLMpsfqsf5uUDyxwxATzqYIUjdivsErmEXJjOHfCzKqZRIGuA+IAx7VsIrL8VQ3VcgyWpX+iG29NMi95k2rHMJVjCw4kVYR+fhHEtrV9k4scHFrrVZzsP59VkZgOe92fBCJRjRXXk7nR8wG7Jc22x4VZ2beWcKawa+BpKDXwQ4S4cHoM5Yru2WM9i5obrB+ilVSJjdClJoTbN8i7l1WcQAnwg4W8MUjioBdg==
Received: from SA0PR11CA0118.namprd11.prod.outlook.com (2603:10b6:806:d1::33)
 by BL3PR12MB9051.namprd12.prod.outlook.com (2603:10b6:208:3ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Sun, 18 May
 2025 03:22:40 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:d1:cafe::b4) by SA0PR11CA0118.outlook.office365.com
 (2603:10b6:806:d1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Sun,
 18 May 2025 03:22:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:29 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:27 -0700
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
Subject: [PATCH v5 18/29] iommufd/selftest: Add coverage for the new mmap interface
Date: Sat, 17 May 2025 20:21:35 -0700
Message-ID: <febb20414e7fa9c54132a3b8aff79a6d15c95ba0.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|BL3PR12MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e55c0d-7f8f-46aa-56b0-08dd95bb3ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1xr3HQhxtBnvFGt/1zEshVv8g5WlpiHuWB47Z9B3AS6he4wHiZaFgIa/Ggys?=
 =?us-ascii?Q?aOvIr+Dp+4pDnLfflDVv4mxrbm65Pn2f+j6vgeyy8n6trBezM8fpfuR/p6d6?=
 =?us-ascii?Q?ylxpiRJhffTuVVC3qJzglmHSMk5gK8w2QFmTveuo87gBsaFt12DyGpGVK8NA?=
 =?us-ascii?Q?7Sp4qZsoXuSfXt+FySCISGtE7n69L6Bv3UDPZ6LFd1vexZ/41Ez1vlvhp60k?=
 =?us-ascii?Q?NNBheWykyaGQn44nOUX8Wt0pKkskoFVbtkI5LqQDuAu0RGlzljwle1XEwNoL?=
 =?us-ascii?Q?TeWDNpGyNAndSf8OK1DI1bBDQEu48uwem7FnE7SHg4FOPh083qI+kQIc527A?=
 =?us-ascii?Q?3QMXhdJr5UcX+L2GwyBi8MyWHv5Dp2+lxGCVymuvDNWUqFBgCMO1lXdQnG0N?=
 =?us-ascii?Q?ZWxOE75Sp3QaCYpKGaSLesjOIsHqV0Q/j27cV7FL0YYrXBffU0ZBqgVmQMS2?=
 =?us-ascii?Q?EPeC1jDEQIv/G/smQJIiIAu55g3rVP28kVeQbGCryzTgu1fqo2a+hJeufyH+?=
 =?us-ascii?Q?EkFSMW12NHPh8xvdGBkw3JsWTbCz869VutqqKJvs//e1NiJCfYzb33sQ1cvU?=
 =?us-ascii?Q?3wHxfnSNT6fytHg6iVe/gA8g6itQ8vCxkhKaIk0/TLb2hMyMlI3LVwlLHXQI?=
 =?us-ascii?Q?fcwdM/B9H+1nMadjsdg0BkbHv9eKrE3x9toSPu17O7S2REQcykYLvg9x3H2j?=
 =?us-ascii?Q?CHSLAMUlWAQtxl+sGEwxF6KdWrGtPY4O4gB7R8C4vdnSdRfc0q21bulHMlkQ?=
 =?us-ascii?Q?eY9KN2NyTlHcNiDlU8BQ/HA2cnmO78FtdvPDksoAgXjF5z+loPta3NkYOWBE?=
 =?us-ascii?Q?xlCv05y6HgNyaQ5vVgngoaYZkSs6p1XZlW9Oj9dA0Fg0dtfq7AlcAw4go/Og?=
 =?us-ascii?Q?q5P1YxtW1x5A9aUhGnHkqtXgEkdqiE0kDhecGOcluXw5/yDIYpW+9OY13ub1?=
 =?us-ascii?Q?Rec4V4EjzPUvMkqkrX53RZ2JHuJ39q1reH6WcSjwfktY42y3ww2njCTTvENZ?=
 =?us-ascii?Q?brixw50JpTuPjQnUMm+e6vEPj6Ntivuqn6/zJdE8pe6eoO4AAdUWONUpZzi9?=
 =?us-ascii?Q?mjBCfg0knDcZAUAPtzxkLCmFnwvKbrqw9PUatp20K3sCzWrFthN9fCpK/qxI?=
 =?us-ascii?Q?IzL8BaYlBQgHQePHF+9WeAPt1OxKt548zQ/REeiuN058lhliLKnlq0J9RLsK?=
 =?us-ascii?Q?tFPBDzznmrVs3s6UOoR9yowTkwLuPd4RyHjZ2PVHFbYBJEO/uKlST9HzP6nW?=
 =?us-ascii?Q?aPsUGwbz/qpGUdSDi3RVXS68f7jonGhPBU++9Pual6miryqIzpVQ2waXOBxW?=
 =?us-ascii?Q?sDS9dm9HtL4DUsPOKsQO9iL5HtP01pLJtqpvUccxWfsrRT9GVjmGMR1ErzYn?=
 =?us-ascii?Q?/f7t2LqXy/o3lWf0aYerj6lu5wK5UN5lMl146of4oUKq4hMeD/DKBnfoJU7Z?=
 =?us-ascii?Q?XNzdHdFm4Cu7zrTqkfmh1ytgBTa8uEaOIBDX6DdFfYcbfPajHUsIxqyGZ6yC?=
 =?us-ascii?Q?aJi78/0piLQ9nYYwmjXc0sL7Mp0gl7zx9e78?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:40.0022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e55c0d-7f8f-46aa-56b0-08dd95bb3ecd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9051

Extend the loopback test to a new mmap page.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  4 +++
 tools/testing/selftests/iommu/iommufd_utils.h |  4 +++
 drivers/iommu/iommufd/selftest.c              | 34 ++++++++++++++++++-
 tools/testing/selftests/iommu/iommufd.c       | 22 ++++++++++++
 4 files changed, 63 insertions(+), 1 deletion(-)

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
index eca1a66fefed..45276c137cee 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -149,6 +149,9 @@ struct mock_viommu {
 	struct iommufd_viommu core;
 	struct mock_iommu_domain *s2_parent;
 	struct mock_hw_queue *hw_queue[IOMMU_TEST_HW_QUEUE_MAX];
+
+	unsigned long mmap_offset;
+	u32 *page; /* Mmap page to test u32 type of in_data */
 };
 
 static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
@@ -647,9 +650,14 @@ static void mock_viommu_destroy(struct iommufd_viommu *viommu)
 {
 	struct mock_iommu_device *mock_iommu = container_of(
 		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
+	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
 
 	if (refcount_dec_and_test(&mock_iommu->users))
 		complete(&mock_iommu->complete);
+	if (mock_viommu->mmap_offset)
+		iommufd_viommu_destroy_mmap(mock_viommu, core,
+					    mock_viommu->mmap_offset);
+	free_page((unsigned long)mock_viommu->page);
 
 	/* iommufd core frees mock_viommu and viommu */
 }
@@ -829,15 +837,39 @@ mock_viommu_alloc(struct device *dev, struct iommu_domain *domain,
 		return ERR_CAST(mock_viommu);
 
 	if (user_data) {
+		/* Allocate two pages */
+		mock_viommu->page =
+			(u32 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
+		if (!mock_viommu->page)
+			return ERR_PTR(-ENOMEM);
+
+		rc = iommufd_viommu_alloc_mmap(mock_viommu, core,
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
-			return ERR_PTR(rc);
+			goto err_destroy_mmap;
 	}
 
 	refcount_inc(&mock_iommu->users);
 	return &mock_viommu->core;
+
+err_destroy_mmap:
+	iommufd_viommu_destroy_mmap(mock_viommu, core,
+				    mock_viommu->mmap_offset);
+err_free_page:
+	free_page((unsigned long)mock_viommu->page);
+	return ERR_PTR(rc);
 }
 
 static const struct iommu_ops mock_ops = {
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index fabec1b551c6..2b3274015832 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2799,12 +2799,34 @@ TEST_F(iommufd_viommu, viommu_alloc_with_data)
 	struct iommu_viommu_selftest data = {
 		.in_data = 0xbeef,
 	};
+	uint32_t *test;
 
 	if (self->device_id) {
 		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
 				      IOMMU_VIOMMU_TYPE_SELFTEST, &data,
 				      sizeof(data), &self->viommu_id);
 		ASSERT_EQ(data.out_data, data.in_data);
+
+		/* Negative mmap tests -- offset and length cannot be changed */
+		test_err_mmap(ENXIO, data.out_mmap_length,
+			      data.out_mmap_offset + PAGE_SIZE);
+		test_err_mmap(ENXIO, data.out_mmap_length,
+			      data.out_mmap_offset + PAGE_SIZE * 2);
+		test_err_mmap(ENXIO, data.out_mmap_length / 2,
+			      data.out_mmap_offset);
+		test_err_mmap(ENXIO, data.out_mmap_length * 2,
+			      data.out_mmap_offset);
+
+		/* Now do a correct mmap for a loopback test */
+		test = mmap(NULL, data.out_mmap_length, PROT_READ | PROT_WRITE,
+			    MAP_SHARED, self->fd, data.out_mmap_offset);
+		ASSERT_NE(MAP_FAILED, test);
+		ASSERT_EQ(data.in_data, *test);
+
+		/* The owner of the mmap region should be blocked */
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, self->viommu_id));
+		munmap(test, data.out_mmap_length);
 	}
 }
 
-- 
2.43.0


