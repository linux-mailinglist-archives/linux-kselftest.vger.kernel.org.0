Return-Path: <linux-kselftest+bounces-35904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0988AEA6CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B43C1890774
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EDB2F94BE;
	Thu, 26 Jun 2025 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RjDu/ol+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56B2F9496;
	Thu, 26 Jun 2025 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966558; cv=fail; b=ai+OdYfBMUBbbSHmqJmksvCK3VF1CQNfEHIbSDKtGaw6dpTlq7c+A4F8Xlq5eeVvQHbRqZLUbdqKOYiJIRl5Z/eR7PqD+j20qs1IJgcHuUeVC3KgpiD5g0k0fcKxRl5lI6yFCIWRc6y0vo+yKlTlHCKfmybAY3aoEhj8Qr240l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966558; c=relaxed/simple;
	bh=OW9oXtIynsoIWJQFUy3o3JVqcAmIDvuvQxAUacdqmfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0VqyHcuzjAvENBklNJjyIffgptaso8O0h/qiAtZ89tno2NNCWiJy9RVVJcFGAkszWjbBrPQdgTjePQAov2Z0p7cGD0WWldAQTIC4SFv11/wF8zdidj9Wo3FFylxBq+J5ii42B5QwUGrXqmaGndpBHZi3ciYB3UKIKZrVHddhqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RjDu/ol+; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0eZbrZkkYLFI5ES63/5zfeOqVOqqnIJxRxkheHryLrcCEVpe1XoFLYfQBOqGtpL7ouB6p8M9Z4Oq4ujpfuefTvJc+azidwgydnn53pvqIKKN3ITzPxkH+wGR9Lvubj2ymQB9XdTipkjmD8QynHsm6p1seJwGGdNhnmOOPuB0qf65F54nUSoMeoCIFGEFQPtx6gDuHkHojmVRZ8tX2rHE+CA4Nl2zcCKZuhcneK7xuI00M9e3+pc7zt5WVfpOsHDpIPRttqDYC5sq1sVlvv6bk44uqmzdBA9+YU73FOCs/YYzcOYIBy3MmfJTTdqL6lYJ7rJ8ZhGiOhn0077zrvtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAFkmWxZVRs1EQaCCHrXgOc6oEdjWjoDuIkat81mUNQ=;
 b=pHIxseohbB1rhZ5yGY+2aIg0TXxfivVNIZhSAvqEu53BLXEdRP/geX/0cp151MpTRgLeDaT7J8d++FdLVqEfOvEjeZ+7Qk5nJcQt0ChHfCmZ/l6jtojjwsVAa+XKLWF1CRtLYGcLXtUS6P+asytbYW2H26WmhZfETuqp0v8PAZrHcbmcj4OWSYsdva5UZG5M0TlzgFjpIh5oEzkYGjqCvlc4ANgQBaX4mEc8oMXV+IaoXe/vJq+iy+GYMF0Ff+4yJZwlTJoKx9FIX/6LLousYZmQQcVF/7Hn97/WQCOks3pMFXYr1rZwCI5uKihnBiiGbv8azwhNwyhyW8IlxGoY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAFkmWxZVRs1EQaCCHrXgOc6oEdjWjoDuIkat81mUNQ=;
 b=RjDu/ol+3gX8PyOPcs+3wMV4vLZrKutIG5gI3ScJSKDVLPsqmxQeGl7gDmt7YQFDG6COg5y1yw/m/or2ppzdrf7rLw2fmNWnCyn9K/ynEMDNRVY3rog7tL36SlfY6YjcNWOBAzBz9buowMEg3ViJSBcR9Y5ojmr12jmVzDmxj+Fo+00a6YkqvAke2Di1UKVxu3HT5J96WpCW20zIISkahQ5T4uUHBv4c6QWIiJRkf983fo07OImp/1PvpUVXQQdMtdC9DyQwOKEg6c3F2lgGcZdkSBhork4L1BhMpjZiUwwt+GEvWKVbWzPrgZ0TqnKCe/M8wLf9hddhg3loGJx28g==
Received: from BYAPR03CA0004.namprd03.prod.outlook.com (2603:10b6:a02:a8::17)
 by PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 19:35:52 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::2d) by BYAPR03CA0004.outlook.office365.com
 (2603:10b6:a02:a8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Thu,
 26 Jun 2025 19:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:31 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:29 -0700
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
Subject: [PATCH v7 17/28] iommufd/selftest: Add coverage for the new mmap interface
Date: Thu, 26 Jun 2025 12:34:48 -0700
Message-ID: <b509a479e18b1f9a16f64747b571ba7ca7926a64.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|PH7PR12MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: c81cc4a8-cb80-4eed-366f-08ddb4e8a92c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zEEpSZbgW0Y/pM+uDjQverrS+cI5qENX49UE+O+QDhBKQpyqV+D2ADQUPESx?=
 =?us-ascii?Q?RJNORlHAOOJby4tCfmqlZsMHX3Jw0a3m5oCIvdaGR/t7ow7b5jQJXU1DEu5H?=
 =?us-ascii?Q?twaIoU+LVLZmgwbiVPKYzqZHe8h7P6hmbxAZ/TnPyE9TDgbE5iaZce6bginm?=
 =?us-ascii?Q?sB9A0lRnQDO7t7celAmUS5yp9gEnRD72DGY1fkJytDehGTWPqDIaElX2ISFq?=
 =?us-ascii?Q?8ifrfsaH6WRcxD2XbgZyIl34q+ZbT36KJJ/VBN26r6a05rY+OLW/2YD1mJ8E?=
 =?us-ascii?Q?v9VZJB+fjlryWPwF0l3s8rq3vwRR+VWKUh0+irKFlyJEIdZnCClWbkJyQeXF?=
 =?us-ascii?Q?0QxD3H5+smGVFN2DuwWE9VzjosVYAJlev5TkVWtz5d84wWSILVEXvnQf5s5s?=
 =?us-ascii?Q?96L+Te+oF8GfLVdraM6tdlUHCRSgEp4SRG9pkQLKn0dQFyExWN18/Sp+WDKp?=
 =?us-ascii?Q?nJhIvqfZLMLHONqMy47W+P0yS8lKGJOMdyc2keGunXzy4DgbIroFZLGubLfM?=
 =?us-ascii?Q?A513HOsn6MY3RpRyQRc+AAzRpKBs1RpWts3WoYrN9CHr6eZn+/KRPaj9NGYf?=
 =?us-ascii?Q?BQ5Zu0ds80MAe3ykBVYcd5W3phgSn2ElsoMmzGABoOOtcxKy8j1yCAAYUCOG?=
 =?us-ascii?Q?trVPDQ6kEIzbGcZgoKx3qBUolQmxWZdTypOmbh8nAtwlghISX5tmaK5qDh2b?=
 =?us-ascii?Q?VQr+5tDx9cM87Ok457ozKet16Zf2gP/3qyNiaSZjOvLNOtV3rCQ+uIrVgHk/?=
 =?us-ascii?Q?y0xa4e3oL08ew28x6wd80909P9FanVkXQ6fIOXhX3rpeQUeMmnTRKDvzwbcH?=
 =?us-ascii?Q?fPhZaobNtYwiXQvDIJ9u1nliZ7adGxK7jrcbVXO1WU7QMOsyJe4BPf9KgZSc?=
 =?us-ascii?Q?6ZU4JkosocSw83De4OyACEWtiG8KcP+PuAOGBhJE7d4AjAvzkpNhFwmoh+AZ?=
 =?us-ascii?Q?7tldiH06y9HcVjs1Qc8yMueSjClK3fDqnlSAjAxHtUdXCOFMofUO+XyfrsDI?=
 =?us-ascii?Q?G00glpac/t61+LZyCO0odPs3AJmyNV7a6N2O+vOMbr8T9vLQCBXEtwEQ0hUf?=
 =?us-ascii?Q?xbeQx6SfuNgggoa5666ymkaEJgOG3RsXcQmX49HoiRe8QFQ4rJOfVsKyLu0Z?=
 =?us-ascii?Q?jDey9b3Q6ytdCXJiKbZcwqlysLkV5tIqhNBldLnqxdXgcoT8FjJKFLIfhU7M?=
 =?us-ascii?Q?yuOnTNIRWQBqlMQBELfqMoi6T+ixPtbFuTWf6Qk7TQbeASLChW3RHCfy0zmE?=
 =?us-ascii?Q?APseEnZBJFJ8rMmam4wm5HP9YYJvkXGJynDPNw4PCpMF7RwymNeZwpWez826?=
 =?us-ascii?Q?ZPFY72zbRv36IW2tKRWRUzJAESG59p4Kd0Ac6Gzgko9cGRqUds0chYt6GvIl?=
 =?us-ascii?Q?rPBTgfGl9luWqOLWeng4XlEo9iXr0Ed4/xGJlZSdahNIWZRJ5l7RcsPn2LBC?=
 =?us-ascii?Q?S2co/GoLkrsEV8UiDZWtv7dII3ODiZrEZ/WpCaYSP3PsMOZgRMkUiGLiLnWL?=
 =?us-ascii?Q?dX9NK68/N5GDkzpMxWDP4BcDS5tr+BGfxskf?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:51.9438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c81cc4a8-cb80-4eed-366f-08ddb4e8a92c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588

Extend the loopback test to a new mmap page.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  4 +++
 tools/testing/selftests/iommu/iommufd_utils.h |  4 +++
 drivers/iommu/iommufd/selftest.c              | 33 ++++++++++++++++++-
 tools/testing/selftests/iommu/iommufd.c       | 22 +++++++++++++
 4 files changed, 62 insertions(+), 1 deletion(-)

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
index 0da72a2388e9..235504ee05e3 100644
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


