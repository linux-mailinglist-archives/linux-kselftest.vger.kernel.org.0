Return-Path: <linux-kselftest+bounces-36923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CC0AFF8F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF1317AA35
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F11428D8F4;
	Thu, 10 Jul 2025 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CJdjyBTI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1228CF52;
	Thu, 10 Jul 2025 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127247; cv=fail; b=jNJrn5PJT7yJHU/wM3Iiz00/y2oJIGqWZ6V6KSw/zAhucgaX9mK4JepGaO3lS670QXMYaM+hWY9ZiXF1FmuTCuCUN+ThOD9GavFGb4ILVb0Vmh0D6+K3E5L6g0Lkm7olbSAGvB5r1iGDw1MLiGSIIse584TS65SWh40ct67GUeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127247; c=relaxed/simple;
	bh=neDMfPsXIjp6S0jMuW5n0V6THXx5/0oIxrsI8TzNMKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b45H3Wgbo1rA4phS5ik+oolDpyY/eEJdK6sfKgpvXdRSHOKSssOCQztHBlsvd7YE6zH9p6353Tgb7jHdaGE32Twa160gHpPoZO7MBJxGztqPGxITsWpaO4jAA5c599/g08uBH3npXmFx77tQeEaeN19AJi9IYGwBgoAC1c6U1b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CJdjyBTI; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXJKp50+sPPzQvq25om8dmuo73cI+2ZVOu5eg32+Hyee47hf5IyEh+Ys2ibQJzqR2cf13FSAphdTc/dN2RYk8Vd9m6/trz4N1CiV0P5dzzzzcomK8SR5ZG370dXvg6hmvU6Nz9j57Dmenrc2f6XrtrVFkiRQBi8Hn8rNqDI/qxYzbGtb03GPL0TsySmbPMiWVSkF28qrRMkXP4bf6VSZk7/DdsNBRYo7Hm8e7erKZbMFl+guMTXs6DTQYHmjhuF+QWtfDwdG8BlYjo4RL/72CD9JXlb/P73k77JMA8DCJ0XtZrKX8Dh0DJD8PvGMjTP+fZ+Cy7zTbXVI2obmwQHnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OV4o+LTTrln/1MtERPHH786zVJqe1aBupkXIIA+8Z/w=;
 b=HvkNo+m7i9Ua+ON5tqlHxX5xqKoREAIuXIeiuzOPkVRLFdC47d24T34zYSccEMqdp62/qoxJHEgNgfoWt4FCs/l4ahyVSSwjNDAcf7rKi8X6hoEVqLE2LmyLthtEDjGpTZ4SK3HWAADpLaVCI7KJIf2rAciuseVPVUxnOwfHPUJeN06DRlylaRhPiH4HoYksRJK+xMKXravs+/t3/RYbpMY0IveXxD4aK+EFohwTK1JIwnuk/InTRd2iKCNJDpB/VApJEjGIcYg1RnVpCZ/TvmMZlXl/nL9Jp8mxSYtbFjKPlvI+4crf6nyIBBNYgFRYO0DQPu59HVyqwoVDssdq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV4o+LTTrln/1MtERPHH786zVJqe1aBupkXIIA+8Z/w=;
 b=CJdjyBTIb/8pqTPiQPNcP27M002bbTQNyb6KxWjOJJJavAG2g73CxO+R4auX8eRMagt5V5GGQyHT5B8/BymxiGm5p2M2yllxEcJ7UVyW4at6aaiF4O+Lu9Suyr+UWhm0pvjf6bmMmidqqY1CVLSNtrh2rvkI5YDn+sjC0WZx2///hS7JSwsd5IWAyVkr1X0jYMhcawFnmqm87Ee/lRqVNEFaXn9WFwwrXhOfxxaENGN0e9EfgzTcV3CbNOw/wX1RBFrmfipv86WT0elixM3+XUwFTiVbKwZNjrCbV4lqS3mgebZFlNn3c51vCiDitBYjWS6pER81+YHstCRi773Mhg==
Received: from BN0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:408:e6::32)
 by SA5PPF8ECEC29A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 06:00:41 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::dd) by BN0PR03CA0027.outlook.office365.com
 (2603:10b6:408:e6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.24 via Frontend Transport; Thu,
 10 Jul 2025 06:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:19 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:19 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v9 18/29] iommufd/selftest: Add coverage for the new mmap interface
Date: Wed, 9 Jul 2025 22:59:10 -0700
Message-ID: <b02b1220c955c3cf9ea5dd9fe9349ab1b4f8e20b.1752126748.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752126748.git.nicolinc@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|SA5PPF8ECEC29A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 6359984b-4c1a-4c18-801a-08ddbf77193e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GKjIDhv0pWtBQ4WaVzwkekb+LgNRs4gKGVoGunfw/dAl+Zh43sGG1BklALeU?=
 =?us-ascii?Q?s4BE0CesyNfUVNn/h/X+lBzuR23yGKVBr1BQx+mlI2ZP0X1nNQsEzsWu92Ob?=
 =?us-ascii?Q?XGHWm32na/oHcAkzMId9mmospofFPlsO5nf5hMQXsasz474YOMbsDYhpCufb?=
 =?us-ascii?Q?/XOL72j7sJUVNa8CqQOiLh8bsm3k6/zDAbWW0FMdZsAmxOH9DtNUF+Y98W/x?=
 =?us-ascii?Q?nGtdDvLZOyn61c4jnxNfkSkQcghVo0A1S5i08H/TnF+GF/BjWm1haIp7LcYx?=
 =?us-ascii?Q?iFcONlqAC89PwmJ/h9fyl3bcrxCpSAS60LJWQzM9Ty/NS4YaI5DoGMxYDR6i?=
 =?us-ascii?Q?MfoPJzUcEzZy0ZR8Iqtm1uoJdcUBFjnPw9l+EAGxxiZaNOV61DeRgY/qhb79?=
 =?us-ascii?Q?fn1Lw24k/2G5/reya3RsU7CDOD6iUjfDnSUFZhxzeH4Oholu3vQ6YkJQfXnT?=
 =?us-ascii?Q?5yFyY1vgEcS0BqU/LAaioqX1z2OxtvKQJXqxdwR3sNZaM6vvuQupuRCuer4V?=
 =?us-ascii?Q?QmhCiimW6PcgkTMBm3BuUKN24BqGdMdUYmOVnMaMiX8T3S0e+758p28Opqri?=
 =?us-ascii?Q?ONljEORcNvhzCf1QLsVkKxlvLbxCcqpZXDwBWtLNmvrCHQYfJwT5D3ATXP6J?=
 =?us-ascii?Q?PKGt00Md0CNx+Kxm/chHs4oO9fX1nEFg8X+cRrMn+6ILBNbkb2FnunHHgsKV?=
 =?us-ascii?Q?AOdGEkJZqTiyw5Ae6U11zAwfoSCBzfpkpyDWV53Mw2zoiIupjfhLot1sfXLt?=
 =?us-ascii?Q?eCQq18HtrfnFlNoEFccwJfNqSY66/taPdUNsZNWX3YOBeljKhBQzwThplv0D?=
 =?us-ascii?Q?lcBadMdYqVjdu4/eGQnmXnTU0OF5Y8WjRREvkSAOiRtdgIvc7au9g0+3F1Uj?=
 =?us-ascii?Q?dbYgYcRSnXcBlSaGOF2Ojby5BKSmmKMDcqegn4REqQqhD9zMT36dXfxrtssN?=
 =?us-ascii?Q?XsX1p3/k6XMeewxcoAt2BRNclYTtGn/QXxMF11eewVh8b1DDAccgmWbjbZvy?=
 =?us-ascii?Q?OBUnBAADUtXHI1TAh+lWPPmO+YDyulDYYqzgsz+NnSgfybbPL30IcHlWLy3M?=
 =?us-ascii?Q?GpJFEQJIrKYw57FGeGgkfttL8zWc4QYTJSkJe4ZxqS4Z0QvKT8RunE84+PJ+?=
 =?us-ascii?Q?o4b5t3dy5b3dmMW008FLQyXNGRJQ8w7fe8KdNSzfpibomVP/xuP9SzPdVzwc?=
 =?us-ascii?Q?5P+xCY66ZDyiEsHZRExqIXVsq3NKwm4dZ5lPxzRz8J0OeyQrm/oOhxSwBj1X?=
 =?us-ascii?Q?HohosqlrBEHyLToepoOStyoJM5gNJa6gwBPqtbUijEk4TbCTBqHUhYr3Ck+U?=
 =?us-ascii?Q?DPgnTO0/HS1N3wAIyuy0NYiugiVrimxiapk7cg+jUXVk5OWRfvKZc4RyRTg0?=
 =?us-ascii?Q?z5poh8Ym2whrrQY3MkAMyrjyh6xsB+Gw3lDyJpch8mIehUxBCQ8o9oTZ1MOH?=
 =?us-ascii?Q?SiR5kmakEGr+/faParXn4zOc24gZWFEFbV8Ep2J4iUs7S7/HJJpcgg9TYVJp?=
 =?us-ascii?Q?VtRrEXD2gnKjyiVgYbeJDTu8mip7ZPZItsa0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:40.0213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6359984b-4c1a-4c18-801a-08ddbf77193e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8ECEC29A9

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
index 73426de77675..0b21c095ca5e 100644
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


