Return-Path: <linux-kselftest+bounces-32117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38789AA66F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03391C0054E
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F067275869;
	Thu,  1 May 2025 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mlTOcG0i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392722609EC;
	Thu,  1 May 2025 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140526; cv=fail; b=tbmnj9kKy3ZIWD7uBDdWIBbOBYCZ1Gy8ix3O3ddPPA6gq0/sj3KQLDLwDcoqVgPAgBtMrzGhgR1QpqvkLxHlXmsoDiwRLhlnh0QUEWAN7PPdQfZBZ+qnhOHPyvIqiTv7YG9RrHbCqQlwpVfR1vqphjFZ+C486g810uMWW2OOquk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140526; c=relaxed/simple;
	bh=vj4/Gd/nh2dcwbnJxGcT6GVWVIQyaPPrEzTkcJwpiTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpf7WqjufSNbBDFXqfWZEyTJXAVgo4QGbiljZf0EhKkmuKKwwDhRwiBN3GoI431Wcyj6pKagbBX7SbE1zsp1NOaMcHH1E4PNHXnkCLkaQJ8VSJCr73+0+QumAVXTcnjHjLWo1/zRx9fEPAh3oFdQjVGx5BzJhkDDndrxx6m/G10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mlTOcG0i; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyC7GZaLGY9Tp06aZ5/mmKhxIGNNUkmezT3prygaG9O5tErryk0mI/NDBkVnwc56W4V0XtRSVbQ8cnlEP9WIURSBPUrcLD/8pN7QjkJHjnJy3B6jO14wKcLd0UALDu69WswCShUp95/+DHbdw04w8it+4U+RDQmo4/EQCCBKEpUQBoIdVtLOpla7bhQ4P5uh1d9tCTZIVEq3PnJvaWgaB+SyBdFWhL6m3l6XO0BKkzrKkK+HflnIg7ORPPf6jUW9u/ejJ2exljVV+FNX8vb3mbqh0M/BYu4iOLAl0Nny9FQTsuxXNVGh0SUieCH+8ITZPFHGUPgRxRJEOzDJx6rHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnwT+JGKorDXJSzlburW0oB/5SMlM+2g5CIL12JFevk=;
 b=bXl3QZaMmuQcXX3LksZ6xtRNTnOW7FUXNF62GgiteAu9NCWGLOOEalTl8wIxdPsASpwG25El7DQXDAVC5Yi2AFQ/4P0wXQzyAfvQ9/OHsXk8z/x9v2fSHelvHCUOOTcZGN8yRYbV4wlgDuLqM8eBOUprhHHGkVHZcp4vWRV/NwGK8RbBZGkXjolbYhjyJo40YCKhyn0T4wnrRd/cApY4FfgiymVB0J3SxnwhrggRCxs2PQRmPofnZePqMc1t6eSOuPYzJPuZBMVWiEIzAii14gLHeRUqc9oSN0Hz9scHdzQT0SxkxjgxhYL7H46ad2LK+qlAp7xB3Uxdh+wHwtgAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnwT+JGKorDXJSzlburW0oB/5SMlM+2g5CIL12JFevk=;
 b=mlTOcG0iBquSKhxyfPp+KEh0ej13VP+F/ZaL3jplqSB4G79qBUChd+Womxk/aJkCV6cdNfCseFvFDdettSnEL7PtCUModFcR9rXwkEF8h09r7dRReYz2YcOgnuSIle4hlF461x9Lyjocsgsqt5NIgrsYD4NT2TOldJLw/3/O4ENoCSRkUeAHkp5PJ3CvVugTkBm3YslVZmYUXfJQegAHLOkJ9h8Yn4s3EMAPfCY7v6LYICpINwGv/kMeiEhjAAxFum08LbZOqIkRrkRWlNB/B1GIQn9al0PKWouzTRdTLmy3dUz9RGon93XYpp+LZ1yAoqAzmPkNOaSp7awn9mr9Gg==
Received: from CH2PR07CA0031.namprd07.prod.outlook.com (2603:10b6:610:20::44)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 23:02:00 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::c5) by CH2PR07CA0031.outlook.office365.com
 (2603:10b6:610:20::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Thu,
 1 May 2025 23:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:01:49 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:01:49 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:01:47 -0700
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
Subject: [PATCH v3 06/23] iommufd/driver: Add iommufd_struct_destroy to revert iommufd_viommu_alloc
Date: Thu, 1 May 2025 16:01:12 -0700
Message-ID: <bc575f7416f4130d97cba8053b1b39da1c25f926.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f846de4-838e-445a-6537-08dd89042e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9c3g+ppjo/BAsf1s+26Q7CBnVmEmMXDOsjjkQ6bAWWgKhNFQPaYG0xnLPga6?=
 =?us-ascii?Q?fL9fLqWutlj7f9CrwvxB0fAi4+jWr2v+ZJo4Kfl6Tb07BdMChdgD7S8TrmFB?=
 =?us-ascii?Q?R4fD98VX8nDnN1t5UvOUfdEEVWkdyDRGSLwpRoAdJFk28ciQt/7soyP5wKfx?=
 =?us-ascii?Q?QgV9oPiOr5EtfSb9nP1vyhiBk/Yr9FsvNEoB+//IOFcfuEY7il1Sv/5+1YDH?=
 =?us-ascii?Q?fzOLTzoaWuXF3mxBp4IR4YUekWEX9dot3lIB9OUt+ufeJooSYvZYuRse8rfq?=
 =?us-ascii?Q?6wT9Kya8fZHIGqv7fG3de9uHjlmXUZYWwi5aPaBu4k1ZZbwzSKvvtobWgJiR?=
 =?us-ascii?Q?vFViSP0+L3ijpmDuhR+8Cy2GEy+Eqfy5IPvPFD4JEquYTI9PBmNblKHuD9EB?=
 =?us-ascii?Q?85W5Tq9GJNDoRJQt2yoXBE0t+t1uhf834D78ICGZIguJenpmFwJtxMvgUONv?=
 =?us-ascii?Q?3DFm93Y9mdT6BSpVrXxsa0s2AmTUk7D/HPZUqtt+9YV547Fi59dJm9tUoF1w?=
 =?us-ascii?Q?Bs+WI0MyqtreAY00QaQvZxTLohMAGgjV9NwFVXozRrr5Qyu33TMAkQJS4exN?=
 =?us-ascii?Q?xbvNrhzFXE0CxG4K26mlZDYWWv+9/jI7a19xiPixJtNdj/bWx1jMn2nTF7Y0?=
 =?us-ascii?Q?eklJhJkFPmpddzvQ80MmNvfcKVB4Q4LxvXa4/n9HdKtR24CPZz2nHAqc58YH?=
 =?us-ascii?Q?kNr6lJEGAsHNluOBB5/x5YhC8UNvoaczxCrxiExnMBP5AApsSPr58zxwjFY/?=
 =?us-ascii?Q?NSQumtBzBE8klVwVv9FE0wLYpslm1cpmRn+arfqdv3qAFJVYzzbYo9X2WTrl?=
 =?us-ascii?Q?9/BlEdQGAb7bP4WG/TWCf70w17tOZDBWGUZzRwzGraSinJXE/AjLdILlrgP+?=
 =?us-ascii?Q?lw4uedqXSsJS4bXM0CCkehaTbC+9YlZAmppXI7GvrkyEXfOpOaWAcf837bJt?=
 =?us-ascii?Q?xNDRfO7pD1fVsJccEWAWh8XbhGaLQD3nmk+5CCutBEoCIwp3ingBOTpkAUOM?=
 =?us-ascii?Q?YKgYPj/gbFN8rRQKHoxK3v6bHOCenc14WnOSiMhFuRvnbKpO9oMnqUC/vvTF?=
 =?us-ascii?Q?OFtvp0jAI9e31BtlHtNvwGqaW7Gz7+KA5d82o2J0FB0fBvmejzAupVf3EHSS?=
 =?us-ascii?Q?DtPygiEVBxAg6Fc7XsFLd2Ttr70U5z2RpTVup4dw34aRhms1FUX1rfNMu2jP?=
 =?us-ascii?Q?/K79TwpuEX+6vq1hNgLYnlx3dTg564NK+13kGjUy/ep+4/2tareU2fKPOqON?=
 =?us-ascii?Q?5cuL/4WNtbS7i1vtLjG3X2bqhT9cFJBD7h2oyon0Xo1HUGUCeGpc0QDOBW75?=
 =?us-ascii?Q?/t5Zkt+f/IeP4udeIDOhUbxilPxtTVs5I6EOknNtltWCGaUHUI2mtN+vV3Zn?=
 =?us-ascii?Q?7p3HbWNAdrh7eI4sQii9wFBUjfr4Pi2iz5K5a2xAOX6+ill/GqHM70c90JSg?=
 =?us-ascii?Q?5Djw05H2npNGAcw+LOxm3dQsL1hjBtdiVuccd9MetthuNxLMMvkZCk8iSrso?=
 =?us-ascii?Q?nrZOdtj2ztGYBABqdRTmrDY14tmLHpxwgxJu?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:00.1260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f846de4-838e-445a-6537-08dd89042e15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

An IOMMU driver that allocated a vIOMMU may want to revert the allocation,
if it encounters an internal error after the allocation. So, there needs a
destroy helper for drivers to use. For instance:

static my_viommu_alloc()
{
	...
	my_viommu = iommufd_viommu_alloc(viomm, struct my_viommu, core);
	...
	ret = init_my_viommu();
	if (ret) {
		/* Need to destroy the my_viommu->core */
		return ERR_PTR(ret);
	}
	return &my_viommu->core;
}

Move iommufd_object_abort() to the driver.c file and the public header, to
introduce common iommufd_struct_destroy() helper that will abort all kinds
of driver structures, not confined to iommufd_viommu but also the new ones
being added in the future.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 -
 include/linux/iommufd.h                 | 16 ++++++++++++++++
 drivers/iommu/iommufd/driver.c          | 14 ++++++++++++++
 drivers/iommu/iommufd/main.c            | 13 -------------
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 5c69ac05c029..8d96aa514033 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -180,7 +180,6 @@ static inline void iommufd_put_object(struct iommufd_ctx *ictx,
 		wake_up_interruptible_all(&ictx->destroy_wait);
 }
 
-void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
 void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
 				      struct iommufd_object *obj);
 void iommufd_object_finalize(struct iommufd_ctx *ictx,
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index dc6535e848df..f6f333eaaae3 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -213,6 +213,7 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type);
+void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -228,6 +229,11 @@ _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline void iommufd_object_abort(struct iommufd_ctx *ictx,
+					struct iommufd_object *obj)
+{
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
@@ -285,4 +291,14 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		}                                                              \
 		ret;                                                           \
 	})
+
+/* Helper for IOMMU driver to destroy structures created by allocators above */
+#define iommufd_struct_destroy(drv_struct, member)                             \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_object,               \
+					  drv_struct->member.obj));            \
+		static_assert(offsetof(typeof(*drv_struct), member.obj) == 0); \
+		iommufd_object_abort(drv_struct->member.ictx,                  \
+				     &drv_struct->member.obj);                 \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 922cd1fe7ec2..7980a09761c2 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -36,6 +36,20 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_object_alloc, "IOMMUFD");
 
+/* Undo _iommufd_object_alloc() if iommufd_object_finalize() was not called */
+void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
+{
+	XA_STATE(xas, &ictx->objects, obj->id);
+	void *old;
+
+	xa_lock(&ictx->objects);
+	old = xas_store(&xas, NULL);
+	xa_unlock(&ictx->objects);
+	WARN_ON(old != XA_ZERO_ENTRY);
+	kfree(obj);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_object_abort, "IOMMUFD");
+
 /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3df468f64e7d..2b9ee9b4a424 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -51,19 +51,6 @@ void iommufd_object_finalize(struct iommufd_ctx *ictx,
 	WARN_ON(old != XA_ZERO_ENTRY);
 }
 
-/* Undo _iommufd_object_alloc() if iommufd_object_finalize() was not called */
-void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
-{
-	XA_STATE(xas, &ictx->objects, obj->id);
-	void *old;
-
-	xa_lock(&ictx->objects);
-	old = xas_store(&xas, NULL);
-	xa_unlock(&ictx->objects);
-	WARN_ON(old != XA_ZERO_ENTRY);
-	kfree(obj);
-}
-
 /*
  * Abort an object that has been fully initialized and needs destroy, but has
  * not been finalized.
-- 
2.43.0


