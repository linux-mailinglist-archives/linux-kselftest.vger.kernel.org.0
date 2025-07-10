Return-Path: <linux-kselftest+bounces-36920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD39AFF8F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26891173408
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2019B28C86E;
	Thu, 10 Jul 2025 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UFveVDxs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5CA28C5BA;
	Thu, 10 Jul 2025 06:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127245; cv=fail; b=SwN9hfLniykw/gWpKF9yca1KZ38sCp6TC+hFx6uiDQHAjLRvQNIPDBKSJ3YLwda6DZxDKwvhD6ojyh0OikJ6BjYzr5TXXHTn1jpCOSirKpH8UP9WFFUv3Aj0EBB8rDt9VWsYc4mjMLWG8xKBGFbnWCcfk4IFsPsSrdVbPCrIw2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127245; c=relaxed/simple;
	bh=9xdXsdfhAiqjlLsEPZkBkqSuzkjkMnB6PRIEDgnla2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chEx/zq4BR3PPxS3sbDMhjbpGnhopTKfYrSS5ZitKCO2oMPxwQ1GpnbcPx5Mzj7bguYfwlDT4jjt9rqUxFvXPH3IBsISO4fFPm2Nq1i5eRdhmHmzmY5SwGukbEcwIXxY9Bp0F39stMXLQvHWwDf5eFlqI7eB7RTqUxW/P+VvZpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UFveVDxs; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWfP5P4RRcoCX50/IPyZDAsn0ffvpaqT/uDQbotsZNkhWOXmG/6QzaZX4zSlnISb1nVnq8zEmKFie9uJGn//Dyz41KKSdrfeSMkcgFbPXssB/hOLAxbnP7fFZnm9/p/ULn1C+65NdOtUYaPBAoYYv1WEhqizq2N3kbLMIIQQEjxBR8N8kxAj+NLGW72oD1Y+CdYfQkrs+KyfFZwAveyFDZL8sk+nwMq+Sf245Z6kJ2CJnNKor62W/S+YCarSMlBCZmryuMq15Hznlt0Kr8dHcJUrDj0wAyEfWI95S6SEyXSVlpZPs7ctUoX4wTgSbrqHBQcvUUt0AKy7OWVZznWjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeqSlaD3+fR4iaCN7vg1ThmFgf8ZAP8ay1h2s8w2L5w=;
 b=aI6LksPubWNehps/BZHQaPtmxzplg82ct4YBWfqNedWG6Ksq231zAkTcqafPq02mOSroh/EXogMV32PKM9Sd3hUDa9SrYOd0URvwHcWBLpx8//dXEnuHUnRkKi9fKpZ7yBubshmlNMBTUbosdCBQGacP85iIg5Ree7FtHhawZUf39w62grjoqeIOobr2T0NCi+RCAuBfof7IvqjeD3z4F7owLULC4trUH2oy8PlbL/C27jCrzUFk0cj6S4Bd9DVNxwEVV0zpSwfWAeYARHBh8ayPuwkceOGTDLoQPhxY2ZKbgJFP707k7bC2vCRTcBIu34qZjafV1z2qp7mA0N5wtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeqSlaD3+fR4iaCN7vg1ThmFgf8ZAP8ay1h2s8w2L5w=;
 b=UFveVDxszODADRLrBbnHr+dg4fYJqIr9UQL3XCKzedkAqxscCvW8CA7rliHaAUG7MKYZwFNtKUOH3EAaoLK7JvCUOxAzQQFY4ycid01FL88V+jshm/F5aPYkt4koYReRYRulPvfuTaok22A1+MuycwOSA9gHdEnphbuCUdg6+6+CEyLNnuvp7D9Nbao7Li0Wy8gHVXkL1ZFWA9NrEEfqXSVJG4AfsbVlS+DkRwZpG4L1q2kMa/Mc1KR9VZA8AC+mKvszWPFn1+oHOMISnHbMNiEcNUd0hw1ymO6pJ36U7BkQHuBKDYo8Dsbs7B6vraofHZSS9ZNB4IfdEI2PXjjQyg==
Received: from BN0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:408:e6::28)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 06:00:37 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::52) by BN0PR03CA0023.outlook.office365.com
 (2603:10b6:408:e6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 06:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:18 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:17 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:16 -0700
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
Subject: [PATCH v9 17/29] iommufd: Add mmap interface
Date: Wed, 9 Jul 2025 22:59:09 -0700
Message-ID: <9a888a326b12aa5fe940083eae1156304e210fe0.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: ad48bf13-f471-4e33-bf0e-08ddbf77179e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ckkQ6Y9R1asQP33FjIyN+wl2I+MxV7ZkNms2uSvw5me+T25HiqzWV8GkOeRV?=
 =?us-ascii?Q?FIluW2YmdjeZBlN3texGAfwMElggEDgweQeFJlcWCmXHNEW463tGI51p/eIg?=
 =?us-ascii?Q?Vu/S0Iw/jF/jikqvFx9mJpzjTej1bsrvl81Y0DYjx3Il9l/uqlnUe/FIa5jA?=
 =?us-ascii?Q?dc/qUsXYyu3cw1q8P/yT1+EXPfdg7990k+ViZHxIt9aLbnZZ9fnCrttQYG29?=
 =?us-ascii?Q?wJaiFgCGB97JkaSOZCpekYSzojYs91K71AlHtlQzmco7mP0UH/5HVmIHzT7i?=
 =?us-ascii?Q?krJnqYfwWlIawG7IZ6p/GMYOS2oa08REx4wRD+NRcwkLb/0kLFJO/Jn0yxYQ?=
 =?us-ascii?Q?ljPk3MC7S4V/j/M4Cb6MG5MjC+uyqG7u/34tFa8XgUP9WGzyghmON73uEAms?=
 =?us-ascii?Q?tWrMA58++Q+KfBBFiyqdKcHAm7zmG5/i24FWQk+LUHJcwgXSLYkf9XWv5B8j?=
 =?us-ascii?Q?aW4rCzjuezMgUlTieqIyMJR9wlBsibtDfoma/uuPJHxMJSdeDvaCQ5sj47L5?=
 =?us-ascii?Q?7YEQqns7qUq2bGix+G2Y3X9v0dopQdN/pwHjJJA/4VBizdfruwuj1IAC0aSJ?=
 =?us-ascii?Q?r2DTLKxUtLeq26S0NvK5SfAW59uxt1x4/nOownx/sNI/scdZbQVueBNY0gqS?=
 =?us-ascii?Q?l2SUSdb88Ip3+n8jXg2DxF7BPKE+AlNqO+kjfzIhPvt5x4oPHFS9HKEJ3QSr?=
 =?us-ascii?Q?N4KEZvq+Iuw37OzF2w1dvMw8RbntALmyOD90/Ee47m7Rc9YdnIkHeKhLLXK4?=
 =?us-ascii?Q?B6ZGgh6tnSdRGm/xUxrBfSt7N5C6VnnIJfybqh+FfOWvRXQkTSpFqv4X7xGt?=
 =?us-ascii?Q?NKr1ZssBMnL6SUQdfOxBCGIO5GAw5KIWHNDQW1XYyH/BILBCNjiMQtV5NxvJ?=
 =?us-ascii?Q?c/G1LsCR/kpoqc5c91ogHdpgpCfVM59kpn7/Ot/8vBuYQ+KnEbM7PdRyPmvm?=
 =?us-ascii?Q?4YwjaDG9m2wJhXAxEUortxWX1J+Aj4Sa6KodFz+RtIHwiKGvFnUxXeMGpa7q?=
 =?us-ascii?Q?sSjxqsmxEEbmps5OgDaQpIqhZl7DaCc2KTaIq6MsYj9ZAcdR6oWy2mN4+J6w?=
 =?us-ascii?Q?K5oGOcV+CCcG7g5gQprUUtX1SaEqM18THujJ4V0pRSCPAiCOy6adbfi3pAVv?=
 =?us-ascii?Q?ra8fwE+yhkP5Orb110+TYjCmy7c6jlMHJBefcxSUJIGLxG0uTaCsqXaXcsZ7?=
 =?us-ascii?Q?X023U6EduU1ZfOpPCc059xdJPhJyAcgvGeExlA2H0nlulgURjIU5mh0TdSXF?=
 =?us-ascii?Q?36N1rRzrBZxWtZXzpNeFwHXLx6AxAPNYIGVejdIvSdDngWF9+gewoIkBaNow?=
 =?us-ascii?Q?s9iqH8147ww56tCL2RjysjoGIGKVTUZE70UwwaE4hA2Sv5BqK3hKQdb6DFOZ?=
 =?us-ascii?Q?9xEt9+fNTY2IeET21bHz8pEPW8evdhaG2VoVlSm6x2HgPojShghgz5O08O12?=
 =?us-ascii?Q?HBE9YtvMOWxBFy/0+hdTLsEEJSevJKkbVGso3Ix+DNzXGF8JJU7Sr8ITHfMU?=
 =?us-ascii?Q?WExN6yOOgywyS6SWvmL+qlaEp3m5Y6WR8FgJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:37.3358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad48bf13-f471-4e33-bf0e-08ddbf77179e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521

For vIOMMU passing through HW resources to user space (VMs), allowing a VM
to control the passed through HW directly by accessing hardware registers,
add an mmap infrastructure to map the physical MMIO pages to user space.

Maintain a maple tree per ictx as a translation table managing mmappable
regions, from an allocated for-user mmap offset to an iommufd_mmap struct,
where it stores the real physical address range for io_remap_pfn_range().

Keep track of the lifecycle of the mmappable region by taking refcount of
its owner, so as to enforce user space to unmap the region first before it
can destroy its owner object.

To allow an IOMMU driver to add and delete mmappable regions onto/from the
maple tree, add iommufd_viommu_alloc/destroy_mmap helpers.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 14 ++++++
 include/linux/iommufd.h                 | 42 +++++++++++++++++
 drivers/iommu/iommufd/driver.c          | 52 ++++++++++++++++++++
 drivers/iommu/iommufd/main.c            | 63 +++++++++++++++++++++++++
 4 files changed, 171 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index dcd609573244..cd14163abdd1 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -7,6 +7,7 @@
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <linux/iova_bitmap.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/uaccess.h>
 #include <linux/xarray.h>
@@ -44,6 +45,7 @@ struct iommufd_ctx {
 	struct xarray groups;
 	wait_queue_head_t destroy_wait;
 	struct rw_semaphore ioas_creation_lock;
+	struct maple_tree mt_mmap;
 
 	struct mutex sw_msi_lock;
 	struct list_head sw_msi_list;
@@ -55,6 +57,18 @@ struct iommufd_ctx {
 	struct iommufd_ioas *vfio_ioas;
 };
 
+/* Entry for iommufd_ctx::mt_mmap */
+struct iommufd_mmap {
+	struct iommufd_object *owner;
+
+	/* Page-shifted start position in mt_mmap to validate vma->vm_pgoff */
+	unsigned long vm_pgoff;
+
+	/* Physical range for io_remap_pfn_range() */
+	phys_addr_t mmio_addr;
+	size_t length;
+};
+
 /*
  * The IOVA to PFN map. The map automatically copies the PFNs into multiple
  * domains and permits sharing of PFNs between io_pagetable instances. This
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index fa23439fa483..e3a0cd47384d 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -255,6 +255,11 @@ int _iommufd_object_depend(struct iommufd_object *obj_dependent,
 			   struct iommufd_object *obj_depended);
 void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
 			      struct iommufd_object *obj_depended);
+int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
+			phys_addr_t mmio_addr, size_t length,
+			unsigned long *offset);
+void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
+			   struct iommufd_object *owner, unsigned long offset);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -275,6 +280,20 @@ _iommufd_object_undepend(struct iommufd_object *obj_dependent,
 {
 }
 
+static inline int _iommufd_alloc_mmap(struct iommufd_ctx *ictx,
+				      struct iommufd_object *owner,
+				      phys_addr_t mmio_addr, size_t length,
+				      unsigned long *offset)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
+					 struct iommufd_object *owner,
+					 unsigned long offset)
+{
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
@@ -342,4 +361,27 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		_iommufd_object_undepend(&dependent->member.obj,               \
 					 &depended->member.obj);               \
 	})
+
+/*
+ * Helpers for IOMMU driver to alloc/destroy an mmapable area for a structure.
+ *
+ * To support an mmappable MMIO region, kernel driver must first register it to
+ * iommufd core to allocate an @offset, during a driver-structure initialization
+ * (e.g. viommu_init op). Then, it should report to user space this @offset and
+ * the @length of the MMIO region for mmap syscall.
+ */
+static inline int iommufd_viommu_alloc_mmap(struct iommufd_viommu *viommu,
+					    phys_addr_t mmio_addr,
+					    size_t length,
+					    unsigned long *offset)
+{
+	return _iommufd_alloc_mmap(viommu->ictx, &viommu->obj, mmio_addr,
+				   length, offset);
+}
+
+static inline void iommufd_viommu_destroy_mmap(struct iommufd_viommu *viommu,
+					       unsigned long offset)
+{
+	_iommufd_destroy_mmap(viommu->ictx, &viommu->obj, offset);
+}
 #endif
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index e578ef32d30c..153e4720ee18 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -31,6 +31,58 @@ void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_object_undepend, "IOMMUFD");
 
+/*
+ * Allocate an @offset to return to user space to use for an mmap() syscall
+ *
+ * Driver should use a per-structure helper in include/linux/iommufd.h
+ */
+int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
+			phys_addr_t mmio_addr, size_t length,
+			unsigned long *offset)
+{
+	struct iommufd_mmap *immap;
+	unsigned long startp;
+	int rc;
+
+	if (!PAGE_ALIGNED(mmio_addr))
+		return -EINVAL;
+	if (!length || !PAGE_ALIGNED(length))
+		return -EINVAL;
+
+	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
+	if (!immap)
+		return -ENOMEM;
+	immap->owner = owner;
+	immap->length = length;
+	immap->mmio_addr = mmio_addr;
+
+	/* Skip the first page to ease caller identifying the returned offset */
+	rc = mtree_alloc_range(&ictx->mt_mmap, &startp, immap, immap->length,
+			       PAGE_SIZE, PHYS_ADDR_MAX, GFP_KERNEL);
+	if (rc < 0) {
+		kfree(immap);
+		return rc;
+	}
+
+	/* mmap() syscall will right-shift the offset in vma->vm_pgoff too */
+	immap->vm_pgoff = startp >> PAGE_SHIFT;
+	*offset = startp;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_alloc_mmap, "IOMMUFD");
+
+/* Driver should use a per-structure helper in include/linux/iommufd.h */
+void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
+			   struct iommufd_object *owner, unsigned long offset)
+{
+	struct iommufd_mmap *immap;
+
+	immap = mtree_erase(&ictx->mt_mmap, offset);
+	WARN_ON_ONCE(!immap || immap->owner != owner);
+	kfree(immap);
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_destroy_mmap, "IOMMUFD");
+
 /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 4e8dbbfac890..0fb81a905cb1 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -275,6 +275,7 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
 	xa_init(&ictx->groups);
 	ictx->file = filp;
+	mt_init_flags(&ictx->mt_mmap, MT_FLAGS_ALLOC_RANGE);
 	init_waitqueue_head(&ictx->destroy_wait);
 	mutex_init(&ictx->sw_msi_lock);
 	INIT_LIST_HEAD(&ictx->sw_msi_list);
@@ -479,11 +480,73 @@ static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
 	return ret;
 }
 
+static void iommufd_fops_vma_open(struct vm_area_struct *vma)
+{
+	struct iommufd_mmap *immap = vma->vm_private_data;
+
+	refcount_inc(&immap->owner->users);
+}
+
+static void iommufd_fops_vma_close(struct vm_area_struct *vma)
+{
+	struct iommufd_mmap *immap = vma->vm_private_data;
+
+	refcount_dec(&immap->owner->users);
+}
+
+static const struct vm_operations_struct iommufd_vma_ops = {
+	.open = iommufd_fops_vma_open,
+	.close = iommufd_fops_vma_close,
+};
+
+/* The vm_pgoff must be pre-allocated from mt_mmap, and given to user space */
+static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct iommufd_ctx *ictx = filp->private_data;
+	size_t length = vma->vm_end - vma->vm_start;
+	struct iommufd_mmap *immap;
+	int rc;
+
+	if (!PAGE_ALIGNED(length))
+		return -EINVAL;
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+	if (vma->vm_flags & VM_EXEC)
+		return -EPERM;
+
+	/* vma->vm_pgoff carries a page-shifted start position to an immap */
+	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff << PAGE_SHIFT);
+	if (!immap)
+		return -ENXIO;
+	/*
+	 * mtree_load() returns the immap for any contained mmio_addr, so only
+	 * allow the exact immap thing to be mapped
+	 */
+	if (vma->vm_pgoff != immap->vm_pgoff || length != immap->length)
+		return -ENXIO;
+
+	vma->vm_pgoff = 0;
+	vma->vm_private_data = immap;
+	vma->vm_ops = &iommufd_vma_ops;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	rc = io_remap_pfn_range(vma, vma->vm_start,
+				immap->mmio_addr >> PAGE_SHIFT, length,
+				vma->vm_page_prot);
+	if (rc)
+		return rc;
+
+	/* vm_ops.open won't be called for mmap itself. */
+	refcount_inc(&immap->owner->users);
+	return rc;
+}
+
 static const struct file_operations iommufd_fops = {
 	.owner = THIS_MODULE,
 	.open = iommufd_fops_open,
 	.release = iommufd_fops_release,
 	.unlocked_ioctl = iommufd_fops_ioctl,
+	.mmap = iommufd_fops_mmap,
 };
 
 /**
-- 
2.43.0


