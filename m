Return-Path: <linux-kselftest+bounces-31675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEF2A9D7C2
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 07:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BD81BC0F7C
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 05:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB321D63CD;
	Sat, 26 Apr 2025 05:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KR84F+g/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D5D1C862D;
	Sat, 26 Apr 2025 05:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647138; cv=fail; b=Z94u8uRXLXJvRDoG27CAuA+wRk51ytQaSMoOA0Ds5Uy+titCXdlRqpJqH22fU5SWGRQdzDZemWeeboXT+tgxL6e0dyEtkLKC8RgPh9AC66Hv0Ulvx5KasreISc4viIoGaHC9JTY9mMZd6OtaYSZdMQCY/sDUpDB771Yc52t2Nas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647138; c=relaxed/simple;
	bh=TH6WUcx4J2s+IZ4dzGu4yclCX9r1opWsI+tCvHflbc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTbmt/lEX2oF89i6hnbGzRdLufeXJ1JKBoRJunz+qgSqNpUF+gxl7u67dBexMkz1ry4ORUJ7Y0od1ArpQMUgDRtjJV/85UpT0MdGd/fDWrfb2Zk8lpmBESxecFmKjtBu3n0fBdKJYP94JqpnMhQKEXzghfDxmroI2nJhYHqpl1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KR84F+g/; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrxsjouQ+tuPGuJAmvL0jwu7zim5u28mBiDQqGsLzdiJ/ghBTBup+u5ZYzZpC1qSgIS4ylARKqdeHhOxehfsAWNKw3yUy74LzsYo4QTu3x8u3Uya1NDVjd9pJI0vapewrwb09KkIBrE9W92HVrnAKOy5FDrGkVmwgBjzy+cik69WK40oOTslSl3kGJ5WApCK0CxoxqP8jDmBM6VzQrR2MjMmRAvrl6PtgdxbWw6JhLjZ6DtiSPQ8ZuCMlTcPLvTgV5cJp/fi6ZOJfh5aNEWuBLdzQGd5nnN4q/2NinZWNf5HD6cKVn4WBc/QEsTobWZzy9KgoOxEFVAeHQI79aAIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUd8PrYTjUFXobNBBq3VmdIPZE89rVGX3cDWZ+uKJk4=;
 b=WaqK7jn38avX8wcf+2ynZvp9ZpfVNuY+8NbIAQB3sjVAG4WkAkSmGzPMqeRVbZynohGa9bxePew1AfYrrqwAnYoJv7dLARcT3GTnGNoBiWoxxJH+hJ1VG8wIrCcVM1N+zvAlmrZAg3+Kbl2NkbRRgtWN3QzkZPQNmJ2Elb7ptEiWSB6+LQcc24RsDQaCQfMTBC6vJaQb86eYz/7bcpphiOd1TscFuLt/EGdH09MjM1x45gujCNH79LAYNjQe2FCs3c3IuOFlVHBtQ4Dj1bnfI1H7pjM7amWJ/+sjsXZMtvPF/VX6ST8i/o1iXJmNYpnvMDE+5OLVu+rdfkTRH0RMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUd8PrYTjUFXobNBBq3VmdIPZE89rVGX3cDWZ+uKJk4=;
 b=KR84F+g/b8z8WHV0gxHJZTFXgWs14U3vKAueBQtUhRbLZTuecIhn2Nfbs4o76Bxtx5KDXJduCCiewxfNSKC+58G/fwVRlNRS9219QjPqwP6RBtKLVOOglPU9FNtvEV+sQGEGsy5HxIuhV2uEMnPtCxMfW74U++JHh8I2qT4sNodhOCqK+zfYkhFroD9ub7KRgmaMY5w/pvGzEVKAofX85R+mcGTigZX26Rg7E+xhKdfsiKWWullb7TaxGdgeA4bmL6eHKPMRoDkd+wK8JeXSHUkI5wuErEGq+3D1FuJuxRKfw779D33x2me1qVm0+ocX2oBPOgHsz9FkfFpOf80C0g==
Received: from MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::34)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Sat, 26 Apr
 2025 05:58:48 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::83) by MW4P222CA0029.outlook.office365.com
 (2603:10b6:303:114::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Sat,
 26 Apr 2025 05:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:58:47 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:58:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:58:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:58:33 -0700
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
Subject: [PATCH v2 01/22] iommufd/viommu: Add driver-allocated vDEVICE support
Date: Fri, 25 Apr 2025 22:57:56 -0700
Message-ID: <14781558dbc291e515b5e249535e3c08290a6792.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dceebbe-9968-4ea3-96ad-08dd848768f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g/jH40qQAaVP401P1wjPCoufahHMisRyxLg1lcm3ADNtZ7qMOfcLcZHmrOZT?=
 =?us-ascii?Q?GWgA3l6rmld6AO3pwVvSXjfOL4/1ZnYM3NocgPMBcIAS6v92a2NiGjrGPNaS?=
 =?us-ascii?Q?pvPA7sPUz2ErRXFe1dFGGaKOxHcivKEpXBQ9nTJ1j5FSw/4aJfnfgz0V+jca?=
 =?us-ascii?Q?L9xCvVf+jvQZLvHOYzcaYC2brpS0jyPdcNiypgssEMlSobyJFjbufR1RwRlz?=
 =?us-ascii?Q?RE2VQXAhNx0Ps/JCJXazHZudqdT538WrfcOwzE7x5aCh2q3OrPHYfEfi+UyE?=
 =?us-ascii?Q?GT8ERW2KQuswjHtb1+xbkU0g3XT91T40yr2Dl9bZx2r1PHAYKj011isaMQgi?=
 =?us-ascii?Q?gVzAHRDQq6JBMNWi8qb1+dixT/j1uyg/JJCBbCpjv6YBs7pqTo7xI+76HwMQ?=
 =?us-ascii?Q?2DN+pnk66p4EPKv5Aa0ibefT8IIihdWyQ4mN6pj4WaUrW9y+FoSAaLiznSO1?=
 =?us-ascii?Q?FdzIfi/p0hFLas+mvc74hlv5orMBbtByGX1rNqFQv4kVYrbp2nsYSmYuhXOR?=
 =?us-ascii?Q?qUpX0nLUZNkVz4Hd+/PalUW0cmebnM0XLThEypUllZh50ZLUgfZobkM9z71z?=
 =?us-ascii?Q?ND66mRjKz/HZsTwW2yGR84Lck9uCd7h/tWw3QsffmiqJVCQ4ZHIB/tvE0lIV?=
 =?us-ascii?Q?nnTdX30hkemCz4ZpI/2qXhEny4OKRcMU67IMm35dGe42B9R1XLCjbW53a2eg?=
 =?us-ascii?Q?YHhjbyr+DcFX3aT2t70cw7ZpJIh6q8EQCwo6OP5arLbdCPzoaJ3wQfhDyB2G?=
 =?us-ascii?Q?LmGCZk2O4W5Pq53o6wa3q9QsqfgEuo8DY8z0x+hYWFvKJjJt/MuU2yVSSaKB?=
 =?us-ascii?Q?Y5YFV0FhOkvm5228DbRML+yrnADRuXYFLwujgZWCWrdz5hgbOE5jlqyRZwqY?=
 =?us-ascii?Q?DjipABx1NuZtcViZppo167uxIYa0Kvf7plfZYwElYVg+JWkikvKU5gyxmEtC?=
 =?us-ascii?Q?9JQM5RCU/EjAckQMJdXa0kTcn/DfrocpLGkHHodWot6bzwbfJQ4nE4E5poDw?=
 =?us-ascii?Q?xYkY9aQNFvAWWnv7aI0SAQ3iwPorp8gZgh5ViltLYOCKor65tg/BkvZINM4y?=
 =?us-ascii?Q?Hf9lXNYip6sCHpuT0cG2r9k4EVYZeCh8Wih66IfstE1Wd7wXp8CV79TgqtKn?=
 =?us-ascii?Q?V4P02BBahem/ZYB6bC0AQScQDU9oHcGlWOKx5ITowRrPuEJXgtPG+C0rHMkE?=
 =?us-ascii?Q?jY7xR83F5vRSzQm6AY/igQoFTved/vjlpXsltINxDZGxZuapcEZY3hHcKZ4D?=
 =?us-ascii?Q?+K+uOH51RoQrbVhGyGGdMJL0QbjAXnj+gUjClW+VhLwvQmaT0By2FXNh0BBn?=
 =?us-ascii?Q?jkQL32iOXb1uzRcaxUTZZqxlGDC+tHkLG1q+hhiuc4ttTEYEG8uptKCZvTc1?=
 =?us-ascii?Q?7uEfcXLBZPgPkzBk8rymJxXd5oPk+QvXF3gWSF2vYH06Y3hGA6aYMilSLVpA?=
 =?us-ascii?Q?H3TgJ9SC7rLn75lcArWSwN/LxFz5PfLjUipG/2uVegsNuyb69DUVhT9Ibj7h?=
 =?us-ascii?Q?7UH4y8PAJ/AQuCgCAhiHi1DvnqzLCAjJAbeP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:58:47.1554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dceebbe-9968-4ea3-96ad-08dd848768f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555

To allow IOMMU drivers to allocate own vDEVICE structures, move the struct
iommufd_vdevice to the public header and provide a pair of viommu ops.

The iommufd_vdevice_alloc_ioctl will prioritize the callback function from
the viommu ops, i.e. a driver-allocated vDEVICE.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  8 ------
 include/linux/iommufd.h                 | 34 +++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu.c          |  9 ++++++-
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 80e8c76d25f2..5c69ac05c029 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -607,14 +607,6 @@ void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
 
-struct iommufd_vdevice {
-	struct iommufd_object obj;
-	struct iommufd_ctx *ictx;
-	struct iommufd_viommu *viommu;
-	struct device *dev;
-	u64 id; /* per-vIOMMU virtual ID */
-};
-
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 34b6e6ca4bfa..83e5c4dff121 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -104,6 +104,14 @@ struct iommufd_viommu {
 	unsigned int type;
 };
 
+struct iommufd_vdevice {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_viommu *viommu;
+	struct device *dev;
+	u64 id; /* per-vIOMMU virtual ID */
+};
+
 /**
  * struct iommufd_viommu_ops - vIOMMU specific operations
  * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
@@ -120,6 +128,13 @@ struct iommufd_viommu {
  *                    array->entry_num to report the number of handled requests.
  *                    The data structure of the array entry must be defined in
  *                    include/uapi/linux/iommufd.h
+ * @vdevice_alloc: Allocate a vDEVICE object and init its driver-level structure
+ *                 or HW procedure. Note that the core-level structure is filled
+ *                 by the iommufd core after calling this op. @virt_id carries a
+ *                 per-vIOMMU virtual ID for the driver to initialize its HW.
+ * @vdevice_destroy: Clean up all driver-specific parts of an iommufd_vdevice.
+ *                   The memory of the vDEVICE will be free-ed by iommufd core
+ *                   after calling this op
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
@@ -128,6 +143,10 @@ struct iommufd_viommu_ops {
 		const struct iommu_user_data *user_data);
 	int (*cache_invalidate)(struct iommufd_viommu *viommu,
 				struct iommu_user_data_array *array);
+	struct iommufd_vdevice *(*vdevice_alloc)(struct iommufd_viommu *viommu,
+						 struct device *dev,
+						 u64 virt_id);
+	void (*vdevice_destroy)(struct iommufd_vdevice *vdev);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -245,4 +264,19 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 			ret->member.ops = viommu_ops;                          \
 		ret;                                                           \
 	})
+
+#define iommufd_vdevice_alloc(viommu, drv_struct, member)                      \
+	({                                                                     \
+		drv_struct *ret;                                               \
+									       \
+		static_assert(__same_type(struct iommufd_viommu, *viommu));    \
+		static_assert(__same_type(struct iommufd_vdevice,              \
+					  ((drv_struct *)NULL)->member));      \
+		static_assert(offsetof(drv_struct, member.obj) == 0);          \
+		ret = (drv_struct *)_iommufd_object_alloc(                     \
+			viommu->ictx, sizeof(drv_struct), IOMMUFD_OBJ_VDEVICE);\
+		if (!IS_ERR(ret))                                              \
+			ret->member.viommu = viommu;                           \
+		ret;                                                           \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 01df2b985f02..d4c7c5072e42 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -90,6 +90,9 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
 
+	if (viommu->ops && viommu->ops->vdevice_destroy)
+		viommu->ops->vdevice_destroy(vdev);
+
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
@@ -124,7 +127,11 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
-	vdev = iommufd_object_alloc(ucmd->ictx, vdev, IOMMUFD_OBJ_VDEVICE);
+	if (viommu->ops && viommu->ops->vdevice_alloc)
+		vdev = viommu->ops->vdevice_alloc(viommu, idev->dev, virt_id);
+	else
+		vdev = iommufd_object_alloc(ucmd->ictx, vdev,
+					    IOMMUFD_OBJ_VDEVICE);
 	if (IS_ERR(vdev)) {
 		rc = PTR_ERR(vdev);
 		goto out_put_idev;
-- 
2.43.0


