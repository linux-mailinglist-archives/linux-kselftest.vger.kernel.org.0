Return-Path: <linux-kselftest+bounces-35902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 487CFAEA6C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED27B567950
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D3C2F548F;
	Thu, 26 Jun 2025 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VuM/oLFG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB412F5466;
	Thu, 26 Jun 2025 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966553; cv=fail; b=AbLc6/JxcdFmO5+ezPnVHXJLN0+liIb1v7KUMADdtgMtCBAC/JitCmVUooZIYiU6OmIYeHJCwp4WXsTHnb6aCSWqQ5DW/mbNKprlbVNLo48JkpPi8kcXAHCKWrQmMrlA9A0o6B70GGqv77EgODT4pRYYLGqPG1kygj5aTUXgqAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966553; c=relaxed/simple;
	bh=O0jb30m+lZbh5COMvHdKXyH0RUFMaIPFBJEwpqhx/vQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHF2kqgIttrH7DiqJsC8j2cBn3wHCg/xi8F61ZblfY9SMqTMqwh5DfCGIm0/z/SMChDcJaVtDaEDEuTg1V1pCOeeMkYRdAM8QvmrTGGYujjo84uHYkXLacuIXa+BM+n2V72yTRBo8KH8osYsUMRXtnEQRiyQUNqRb7e6TLcj+HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VuM/oLFG; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeAr39JL4H10J9q4PqpKKPomgn/H6eyhsdy4OQFHIKhpdKOKFH0LCnF6pFHdWSprbnt3mc1bvIoSbyHaP8ELEPzUgdcqVB9lUAdZyV05lnnlfqiuU7tnsxHLDFNuqXcGZmgZpPkcghc9D+VhfPB2uY1OUEgE7HayTra7LtotWIyB+5nXIJMJ253iYwKLpaTnw/Um6he5wSKb9M7iZPFC2y280JPAS7EPyqNWV7OwZ/nH9upKHoh20e5pM6g7WeIJIIF4MtihyXFhQqbBHPp/fuxriJWVPIlW5+assnU1YpxZBsZP274QT8QgWpJiDunuPrCX8xmFGQYxF2CJ3a8CLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd3O7MT2ealrQOKKK5PJm0Hcxu/pR1Qfu2MdWd7jWKY=;
 b=HFqz7ewuYvZswgfbvr87xGCjn4baP/+8a8m9g7IY3iiSYo36MAHrs37C2zfdBU3iGdt3Lay2yawcgwimXqu8qr2CUIGTuDQh01TZ215kYSCZ8nUHA9OGmclQbIpNWwSJpfnCuYjnuuxq7yFchkLnTUlXe+w04TlR5nwqpn2UQwnlxWIcgdsScbAO/TbjWyz5NzojkedVHJWBBBWExkQb9Pep0azG7jKwb90SEeE1skqrrtq5Xr7GnUZQCr3PJZVWVqmI/9KATXI1tCKWRAJP+k6NJ2VyJT2jJa9IY+wFG9Tyw+NFYE+n6Lt39qBlAeaqjJI9I92ZEN7viK9ob561Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd3O7MT2ealrQOKKK5PJm0Hcxu/pR1Qfu2MdWd7jWKY=;
 b=VuM/oLFGHtE7N86+xtVc42X0QT7hGlStfsaYVEhLZezwDYhKZFDuutZD0UkangTr1WtPrzWUnl+FsenKu8rkSo2KpvNcIWulfR2dlm7Kml36Ff6Y8s7hZF7qcW7SZ92oIdWYEs0Is2MQlNPhCz/O+TESPiBwXOwD1Y6VUz6sC6/1J8H5TY58nd5grt9hIh+XeGEmg1HPr4R/MWU5sspYG7YlShr7zi9VcVwKtzZYLgESMfjjE9BOoSnBWGd8vHpASXjqb77gPeHbEpiIfoqt/t+Nf+uiux2MaOKyQXbzJ13fkgbcAbdPJ+8Nl9YPLsnPpTSg+ejlPhoKdP9+7gDK7w==
Received: from SJ0PR13CA0024.namprd13.prod.outlook.com (2603:10b6:a03:2c0::29)
 by DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.32; Thu, 26 Jun
 2025 19:35:48 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::a3) by SJ0PR13CA0024.outlook.office365.com
 (2603:10b6:a03:2c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.9 via Frontend Transport; Thu,
 26 Jun 2025 19:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:27 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:27 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:26 -0700
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
Subject: [PATCH v7 15/28] iommufd/selftest: Add coverage for IOMMUFD_CMD_HW_QUEUE_ALLOC
Date: Thu, 26 Jun 2025 12:34:46 -0700
Message-ID: <3264b6c1c827f704c3eb3b7582c19188813a34e4.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DS0PR12MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be708a2-d1b6-4c1d-cb25-08ddb4e8a6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YxKQtAr5YlRvcpq2XdsuInzxWXHIrliWJlnVjVfwQpZ/72DqtWqBbjFDsvje?=
 =?us-ascii?Q?zabC20rEAAGVGVf/NJt1/QDZBuN48mUYpO9pQjDlxk24mSG+H0sM7FQyqXdR?=
 =?us-ascii?Q?wFJkhFCIaT6FURQo+rZyeHWtvfbnZI1xOzQvBCFgibCuj7XiG4ZV4EQFi1rs?=
 =?us-ascii?Q?AtqIkujpJIVHQeQ/LrfUbrgqDJ0SL5rRno5RD2I8jvOMAEU0WWuQgzEgiNYd?=
 =?us-ascii?Q?aUspcCIIPBH5tklkkcStp9IPgzWhW1CpNJyCS8Ge4nwRlavPHHuJSBZDmaGD?=
 =?us-ascii?Q?Opb0AxeRwDUkv1IlJYgp2M27Funjba3JhG02m73FDW29Tc5DTgVnxLFhK8uO?=
 =?us-ascii?Q?xX2rQlOEbIaHBnYSxp0kc2/yzlvc/4R/nHq6JSRsIBg+kPPFBPUZ4Xr/ptB4?=
 =?us-ascii?Q?j2BfaVSkFeGVpS/PM2v2PKjYy0mY10+Fkh93ORul6wtGkTxRNX4F7+TzCOWG?=
 =?us-ascii?Q?RuIJUT/PvYcHGIRU/2Kg5456Mgg4k4BUyRYLO6mKqWV8lV0c+3mS/zAFj3bs?=
 =?us-ascii?Q?zONF9z6kRYPnugLapIvEXulX86xK7tFZhzMfKq6GtdRxR7ejoikQrgyEggMX?=
 =?us-ascii?Q?fbuqoFl66uTn3EAN9UKo8+licAXuWOnP5iGHL3RJCHscNakVwYZ5kLgJQ9mW?=
 =?us-ascii?Q?MM2P1nC8XZmW7cJ3mMj9y2Ggy8Zu3qx7Ty5Grq+IaDIHd1nqNyG3Vut9/e67?=
 =?us-ascii?Q?Oo8KqJ5aMHWhY245BMshVPT0UyPscacw4nnZ1S7IaSZl1t44vYsVqEqBWe/C?=
 =?us-ascii?Q?eQVdscM4BrKT/xpEW516gIkf3rtKby33HAE/+JgvkNs/kbMlCMgc//CvbCMp?=
 =?us-ascii?Q?Z/G//1UJloyk/rdF5Lf+wUzaQV0tv4l+ZauVqrtFoIhG/o93pZqIMvyvezIr?=
 =?us-ascii?Q?xER3bxU6qBn5/wj4zfPi2cumIDrthBjdydh1wjejTAgNeSnWwm14BT3QOLw/?=
 =?us-ascii?Q?Wzht+a+NiQMntpqcBmPuGixYXB9Uw3rZ9MgRqDqWoJCn9V9s1kqa85BYn/DM?=
 =?us-ascii?Q?ZLonuNmogu78SjYKtp9eW7b7jtGkpQKyNl+dB7ukSu6yIzC3LVRjtQ1xAR8+?=
 =?us-ascii?Q?9JoRcO2x1ciMaNWVgwL1+9VTFcYP+JtzhpniizgIy88iLjvrmMF6cp71CXra?=
 =?us-ascii?Q?WbIw1s4g82/WRqjyQoz87hTsDfFqBdJAc7+z8uu0IxlJlgq41UYiWIB2p4NR?=
 =?us-ascii?Q?dzPqiB65yfGXJ58lPtMK9EkmKfnO2RPqUokosuRW87rHddd91f6cyT+6BHJY?=
 =?us-ascii?Q?fYHvAYjw85out8HGLfVmYqv5QugxT+VacjLaakthbRcmE37GzJqVU45y8MY5?=
 =?us-ascii?Q?/zZo3dYJXxHCqrCdoIwfUji7XGF0HxfCMgs9j8/vjp6Nbkd2Wj8LsyxzOO/h?=
 =?us-ascii?Q?9nBBsk7rzCmqXrUDk/N0AyZHs8kVU/Rmd4azh5yT/uPqG65Oqulh1j9c+qc1?=
 =?us-ascii?Q?vYSOJe/duIdSptTXjB4yqvWnP0DX2p1jnCYOGrxHVc8Xz5si7pqegGw1W+yN?=
 =?us-ascii?Q?m7Mn8Nd5eBsqb2/E0jrRaEFzdYoAo1tVqgCA?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:47.9840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be708a2-d1b6-4c1d-cb25-08ddb4e8a6c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478

Some simple tests for IOMMUFD_CMD_HW_QUEUE_ALLOC infrastructure covering
the new iommufd_hw_queue_depend/undepend() helpers.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  3 +
 tools/testing/selftests/iommu/iommufd_utils.h | 31 ++++++
 drivers/iommu/iommufd/selftest.c              | 97 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 59 +++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  6 ++
 5 files changed, 196 insertions(+)

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
index f22388dfacad..0da72a2388e9 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3031,6 +3031,65 @@ TEST_F(iommufd_viommu, vdevice_cache)
 	}
 }
 
+TEST_F(iommufd_viommu, hw_queue)
+{
+	uint32_t viommu_id = self->viommu_id;
+	__u64 iova = MOCK_APERTURE_START;
+	uint32_t hw_queue_id[2];
+
+	if (viommu_id) {
+		/* Fail IOMMU_HW_QUEUE_TYPE_DEFAULT */
+		test_err_hw_queue_alloc(EOPNOTSUPP, viommu_id,
+					IOMMU_HW_QUEUE_TYPE_DEFAULT, 0, iova,
+					PAGE_SIZE, &hw_queue_id[0]);
+		/* Fail queue addr and length */
+		test_err_hw_queue_alloc(EINVAL, viommu_id,
+					IOMMU_HW_QUEUE_TYPE_SELFTEST, 0, iova,
+					0, &hw_queue_id[0]);
+		test_err_hw_queue_alloc(EOVERFLOW, viommu_id,
+					IOMMU_HW_QUEUE_TYPE_SELFTEST, 0,
+					~(uint64_t)0, PAGE_SIZE,
+					&hw_queue_id[0]);
+		/* Fail missing iova */
+		test_err_hw_queue_alloc(ENOENT, viommu_id,
+					IOMMU_HW_QUEUE_TYPE_SELFTEST, 0, iova,
+					PAGE_SIZE, &hw_queue_id[0]);
+
+		/* Map iova */
+		test_ioctl_ioas_map(buffer, PAGE_SIZE, &iova);
+
+		/* Fail index=1 and =MAX; must start from index=0 */
+		test_err_hw_queue_alloc(EIO, viommu_id,
+					IOMMU_HW_QUEUE_TYPE_SELFTEST, 1, iova,
+					PAGE_SIZE, &hw_queue_id[0]);
+		test_err_hw_queue_alloc(EINVAL, viommu_id,
+					IOMMU_HW_QUEUE_TYPE_SELFTEST,
+					IOMMU_TEST_HW_QUEUE_MAX, iova,
+					PAGE_SIZE, &hw_queue_id[0]);
+
+		/* Allocate index=0, declare ownership of the iova */
+		test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+					0, iova, PAGE_SIZE, &hw_queue_id[0]);
+		/* Fail duplicate */
+		test_err_hw_queue_alloc(EEXIST, viommu_id,
+					IOMMU_HW_QUEUE_TYPE_SELFTEST, 0, iova,
+					PAGE_SIZE, &hw_queue_id[0]);
+		/* Fail unmap, due to iova ownership */
+		test_err_ioctl_ioas_unmap(EBUSY, iova, PAGE_SIZE);
+
+		/* Allocate index=1 */
+		test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+					1, iova, PAGE_SIZE, &hw_queue_id[1]);
+		/* Fail to destroy, due to dependency */
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, hw_queue_id[0]));
+
+		/* Destroy in descending order */
+		test_ioctl_destroy(hw_queue_id[1]);
+		test_ioctl_destroy(hw_queue_id[0]);
+	}
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


