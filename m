Return-Path: <linux-kselftest+bounces-32122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 347D1AA6705
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC321BC30EF
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB0527A449;
	Thu,  1 May 2025 23:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WOVw4JcA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AD2798FF;
	Thu,  1 May 2025 23:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140541; cv=fail; b=CPGLnX0dkJiLMqc5Eh4C/Y9b9uQ9SA65VkQvZyFUGy66jUdRVxsxt2BtKCG4s0DTwtLwq5T4Oi+5sA4vDgD1zoE1twZHjmHaMxPtsoR3mXRhFqrAqhswnNfCNwCjZTk5hVsmO1JQdYUmGNIryVJnM16GQH/8G9+6WxbfOThgCr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140541; c=relaxed/simple;
	bh=FM2wT2aW803T9Ar1uwYJlD4e6HXtyG0hjsBcr2ZtfH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgaqgS07HnVGkGvHOiclr1mV+Bbvas8VyLQA/JzhCjFBVotJyrMK1iA6sUcu+YTtIiZyhDMSceA8QEh28BD2Npu8PsFOVVtHC2o9A8vdpQu85XkX/ivxzltWUrmXLwvEjYtDGR13frpY5YUTRzMSTn1qp/eX6Wf3GUaZA+nrGCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WOVw4JcA; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GX1NhAjpsXzyOjbwS5FCZ4DloTkj9+rcSg0dKz03H5l9aBNQfL9PKlj7FEuJVDDs1uVqCQ5cO9J6RpJKTd6D6jT2IuKCTF5Nvi0iTglFPsTnQqXCtlwwrPf32BbIWHf6oSBur7eUZ+3gjnTGZyCZ24RUqFTuCfqCZLAViA2Qy1UfUmu+xzC16BVahkNzRR6pDgv8m5lqWRn7qYdZaMTdnMicPqg0aUGgfDe1s4pR679jxl1LPYEtwNZgyMEMmgqyaxzV1k28Kg9NNYWZYpLUAm/n3N8NIOBKXbBPhSrSs/QmNVWyOaKIxEgSk4CNxyF7Hghq+QNwPxPfQIayJinmAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i22PT6xm5jurobpNnk6fQqJmbGvClNXBrIIyQoJmSHw=;
 b=Vt7ZoJD06Ox8hR/kHS8C1gSRvPR7OESk81nvwFOFNO0HvPUhTKkAa6h1Fkx17pq7OoPfEcceb4nc8Hkfx73JX/xtvEB9jwFn9Si4EamFRtG5L0JTxdtNmhmHtj9IBT1cPiMZYHrS8bgP/WVcg01fqmiv1KdVi9lIMAayRLDhKKKedd3IwrscauOPORIEZeXrw8xTvqXw3CELMVszdXAtHqt48Z+rlyIGTcZPi6EUu+FBdIHzdwtzjkDiwkULSdOw+wPKvJEmp2e9wyMJeMshXhwQrU1jMuRWZxNq/clhI3HYIGrcY0LJ7bK/4LMFnadivaTuFrO9QThojM3ClvpnCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i22PT6xm5jurobpNnk6fQqJmbGvClNXBrIIyQoJmSHw=;
 b=WOVw4JcAmbGDUBB2WB53EMhzaxrG0d5sozdHE/ufWBDyiDCthJaIvdjOQttZfXdDM8/oj8ulAAivfJxxRa1CXfMTNYcxTkOt3U0ePvTprjPMHqdd4/mKC63AnEe5c+uxDuxu01/Czp1Eip7oFq2W88uGR43NdqhPninc8B9kFHR/cPpFJROn6Gon2LCOu8YQmSbzzXNdQ2HQdCTlb7PYNSgrPJSGtu63Do+QqxW4RTnGmUV3D4EaJkjVcILFjUUbC0De9NPFhGeW8fJ8OBrUcGoO0VfRwvXFaIZbsRaj5PWK/bPPhrHFYVrPLqlU+r2lOMNL+fcH+JYbfPEF6ci6PQ==
Received: from SA1P222CA0076.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::19)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 23:02:08 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:2c1:cafe::90) by SA1P222CA0076.outlook.office365.com
 (2603:10b6:806:2c1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Thu,
 1 May 2025 23:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:01:59 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:01:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:01:56 -0700
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
Subject: [PATCH v3 10/23] iommufd/viommu: Introduce IOMMUFD_OBJ_VQUEUE and its related struct
Date: Thu, 1 May 2025 16:01:16 -0700
Message-ID: <b44dfbe2d933949f4d93a23fdae5b26af9d6f624.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5a83cc-92e4-4b11-0ac2-08dd89043260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OFdwCXX4zycADRIpZBqXB6eDmJ6Ob9Hw9ehjMToafJFGUoXl5afssLL/ICrF?=
 =?us-ascii?Q?fjXpYLT8nldNO87ZQy74JYFMa75S1BzEL6QsE/7NJJ8xeMjXBVWoukSzHyGF?=
 =?us-ascii?Q?HpxBkEBwf1DxkqdNrlok3Eh3sH99Ol3JyTl2EYZtc+lXtD4fjhM6le/1r877?=
 =?us-ascii?Q?0TPijh/7OugZbWYrFYLrShf308zJ3PCfi7U67rVTYY+WGMgXuEqRfbSCbqHE?=
 =?us-ascii?Q?05sECPj9KVCMj3ARaCBNrmczFWItXtskOvDwelZs6RtVhPZkMTXNBQs68EDK?=
 =?us-ascii?Q?6JXdDHcnGhJR9Om9dukSCx+QkamkPpLQl9QCf8do+Pntjt8G6F4MaGpMtmQ8?=
 =?us-ascii?Q?cjNxziKuxHOtqyv0/b8kNff5cXI0byYcwVp2PwcFSVTfVsGPvmy2uGREcY4o?=
 =?us-ascii?Q?O6JPvjQJtlu0zmF9r1ymG3VT66ywcY2/5oZRBsbg9FxdYomrZG2+EsjP/vUM?=
 =?us-ascii?Q?SMXOknh4QtGpZHoN1J5lossQtvteKMOnyx66nCHS56VrZl0je4RDQbIvVe6K?=
 =?us-ascii?Q?gd5giMojDcqv0XtPMTrnk+grHnx7xNMcNDUYU6lSSK8EldlXzGbQJ/Wq6m6c?=
 =?us-ascii?Q?hLr8xppQSvGzhcyTwabBpZks8k9y5ON6KvjE42BGoKkZSIeDV4wUQN592guN?=
 =?us-ascii?Q?sOSdXL3ae+1/ZkEvCkSXmhSo6CkbekLlqr5ARG4IH/ZyiAwUAVxCwKND+1/I?=
 =?us-ascii?Q?/WzGUhIy2kLMziGkY+Tg/+cYojSML0cbPei+5Nxjzp9T5CowtynIFpkfIuBu?=
 =?us-ascii?Q?Wr0oa7aNsqUQhJMZoDSJ3+6yJw/dB5K4de6CwIY9S8vfSFvBiy6D7NTkr2Gr?=
 =?us-ascii?Q?Z89dI/XTGegPIZncqAAygRiphsYNCkRVSxyCnNkyrS9dGmuKrtEF8TlTOgsi?=
 =?us-ascii?Q?dRbarDJ4R2XluumB8zqzrPX3MTgZPXSJFp6dEm+nL/KmWVyFCALhVeVBQnvV?=
 =?us-ascii?Q?R4+q4FLDZI6fxsuAgXKy1JrIRbGZ6LpBFjRP20KiXvhcIbmubOyKddMm8jmJ?=
 =?us-ascii?Q?/pysq/LTavT6A65e04DMae4GbiuErtmWNTffNNxhuEmzTiKTK45xA97kfwVY?=
 =?us-ascii?Q?B+OzU9uizUGqxgIiuAIdkWQnWptCr4zYtN/K64dMxlTr0oaa6Uk6jNNN294G?=
 =?us-ascii?Q?/BPdqyKK+uuwHMQ0sJrETxCOCTmyJt9fJViTf8HZ8aNOIvIGKX/zKo4mG5gN?=
 =?us-ascii?Q?xocCHsy/ZA28LH/vwU0WRda3CecWCzN4ZryNazvGmZ5SbMLZ20dL9OACaGdD?=
 =?us-ascii?Q?HrNaO43mJtzKRbSkFrd5ImozmZOAs3PPGRksTHBiqGg2hjyG+fhnaZ1LIdeV?=
 =?us-ascii?Q?RB5iruimtUEN4U3ZTQ+AL/dzJbPeRKzl1Cs9+okIIiI8UTdRoiu6UD4EfLEF?=
 =?us-ascii?Q?VRS5ZGI+M0mbZ+CRn6HVYKwXkmj0d0WqiL727n4Qud79jbKI4Yt7CE9Wd4v+?=
 =?us-ascii?Q?jBhVcY2+EyS1jyVx/hct5F70bu0kk1eYm/ykCjJel1EFsPhcQnsylGNAwhbf?=
 =?us-ascii?Q?zfKe2vl4n0LcxrL1h8BGgh/dNIaDYi+SYVW0?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:07.3277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5a83cc-92e4-4b11-0ac2-08dd89043260
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027

Add a new IOMMUFD_OBJ_VQUEUE with an iommufd_vqueue structure representing
a HW-accelerated queue type of physical IOMMU's passed to a user space VM.
This vQUEUE object, is a subset of vIOMMU resources of a physical IOMMU's,
such as:
 - NVIDIA's Virtual Command Queue
 - AMD vIOMMU's Command Buffer, Event Log Buffer, and PPR Log Buffer

Introduce a struct iommufd_vqueue and an allocator iommufd_vqueue_alloc().
Also, add a pair of viommu ops for iommufd to forward user space ioctls to
IOMMU drivers.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index f6f333eaaae3..676b54c5cf53 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -37,6 +37,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_VIOMMU,
 	IOMMUFD_OBJ_VDEVICE,
 	IOMMUFD_OBJ_VEVENTQ,
+	IOMMUFD_OBJ_VQUEUE,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -112,6 +113,14 @@ struct iommufd_vdevice {
 	u64 id; /* per-vIOMMU virtual ID */
 };
 
+struct iommufd_vqueue {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_viommu *viommu;
+	dma_addr_t addr; /* in guest physical address space */
+	size_t length;
+};
+
 /**
  * struct iommufd_viommu_ops - vIOMMU specific operations
  * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
@@ -137,6 +146,14 @@ struct iommufd_vdevice {
  * @vdevice_destroy: Clean up all driver-specific parts of an iommufd_vdevice.
  *                   The memory of the vDEVICE will be free-ed by iommufd core
  *                   after calling this op
+ * @vqueue_alloc: Allocate a vQUEUE object for a HW-accelerated queue given the
+ *                @type (must be defined in include/uapi/linux/iommufd.h) for a
+ *                @viommu. @index carries the logical vQUEUE ID per @viommu in a
+ *                guest VM; @addr carries the guest physical base address of the
+ *                queue memory; @length carries the size of the guest queue
+ * @vqueue_destroy: Clean up all driver-specific parts of an iommufd_vqueue. The
+ *                  memory of the iommufd_vqueue will be free-ed by iommufd core
+ *                  after calling this op
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
@@ -149,6 +166,10 @@ struct iommufd_viommu_ops {
 						 struct device *dev,
 						 u64 virt_id);
 	void (*vdevice_destroy)(struct iommufd_vdevice *vdev);
+	struct iommufd_vqueue *(*vqueue_alloc)(struct iommufd_viommu *viommu,
+					       unsigned int type, u32 index,
+					       dma_addr_t addr, size_t length);
+	void (*vqueue_destroy)(struct iommufd_vqueue *vqueue);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -292,6 +313,23 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		ret;                                                           \
 	})
 
+#define iommufd_vqueue_alloc(viommu, drv_struct, member)                       \
+	({                                                                     \
+		drv_struct *ret;                                               \
+									       \
+		static_assert(__same_type(struct iommufd_viommu, *viommu));    \
+		static_assert(__same_type(struct iommufd_vqueue,               \
+					  ((drv_struct *)NULL)->member));      \
+		static_assert(offsetof(drv_struct, member.obj) == 0);          \
+		ret = (drv_struct *)_iommufd_object_alloc(                     \
+			viommu->ictx, sizeof(drv_struct), IOMMUFD_OBJ_VQUEUE); \
+		if (!IS_ERR(ret)) {                                            \
+			ret->member.viommu = viommu;                           \
+			ret->member.ictx = viommu->ictx;                       \
+		}                                                              \
+		ret;                                                           \
+	})
+
 /* Helper for IOMMU driver to destroy structures created by allocators above */
 #define iommufd_struct_destroy(drv_struct, member)                             \
 	({                                                                     \
-- 
2.43.0


