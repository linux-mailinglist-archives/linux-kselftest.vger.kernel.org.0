Return-Path: <linux-kselftest+bounces-30511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9917AA8544C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3517B3729
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 06:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F31280A4C;
	Fri, 11 Apr 2025 06:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QXxXAohm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6503027F4E8;
	Fri, 11 Apr 2025 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353523; cv=fail; b=Tc02fIyxvjRjeiq1mEZYhbCm0kl3uqZyNqMVtBjvuSeuj3IbA535MeOkbMw9Tx5dOouCvW9LsXqw5NSPsqNa7tPla+Jr1OlSVtmcrUkNNWg/R2ANk07mgfXlQ8Nou4u1WIclTUhDrQh/RZAcn02iKadOERg50ze0fGSIbWvMhPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353523; c=relaxed/simple;
	bh=XCbYZHI5uFUj/CvZdhl4I0JX605Iaz3twPRj1zFLfes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RX+TVJXATrqgUzQjJQhGgCNt/7R4U0ncvcFM5OOdevfsezoAoHzIpjw3rP+fHWtumamh7CqM0PhehgpqcWyhTEbPavxxcNYn1zGmm1Fr5qVjEglwbXy0NBIg1kAsxnTBwA+5+p/NLps9vGzP8OOYGqgYq8P8cKwrX5frf5SAEY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QXxXAohm; arc=fail smtp.client-ip=40.107.96.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+NtqnwUQqWjuRMUs60FM4n5NL5hvp/iNl+9A8Ub1wNZCl6g1/inSmnSm/GqWgPF6DT9dGvYUzg52I3y1NtODaY+255z3FXLLbEYNIEJoLFHhi/AgzYm9eHF//YP2pQ51fbMC34lmxNYzsge/IBErGtl7zrlDyXfGi46T12ssB367Dw/tOs1xvcN23yxb6VwPmxkfbvUPleGoa+vtZvRgzo5kFJWm81KypDt07k7t2Dn5MerQ5sxU6/zu5roFMrlMOGxWehH4lZQmJz6qvbsEYmXpQ9gMXrnWN47SISEt9cPFKFqIX/Ve8A3ZOSerVJ9+6eWwgu4+oA9Zv5miaudPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wiv4jNCKkK/XFndUVZMB069pW6FTkLz/CLTzAqn3G4Q=;
 b=kZk+yGwUFeHzQBIMfnY2Dpqwpe4XBskgzRda0yNbTVxq1rrrvrFL9UfW9kLKlBe3kUyR7dNesvgEYiVChYl+h5s7s+DqxJt4pyB/eXBIXEgilonRGB41qpsu21C4685RZcbUdW9z80Ov6DMtbtTMz++3zfci72Fieo1gGuNaWpZhRcBYLusv8VuKjxeejLWZ/gVvp1hUPOsNZUaKFr+t5kd5euQTk4c5s+2/iLBjdDN/Q46xn4xQtEFeoKrxekNH5u1OWrziUv/gBkcJ99nXyvmwxBRDfx+DZoeuVpyVJjIbHGKGq3feyQcPynhbfEAcGvsTULzcsseqeV/JFQELew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wiv4jNCKkK/XFndUVZMB069pW6FTkLz/CLTzAqn3G4Q=;
 b=QXxXAohm+Q4UEAjPILTO/KwGaY6vU2FVcUBv7OcK5U3UUz3B7S+mSrqG7+LSwilDGSRXVY1y+ZVpHhAp+aSiIA1RPnwW8C2QvcNu0QrN6JCgpwaiHbPikaSbm94ZkwXGgS5ppaulvzyweaKwJeHFK6SRJFMKizIy4AEG/C+C1Pc6sB4zPiPO7nuP0GpsOet/R+04XKcoUjz1mEgbG+NSd1IXp0jHVbhXD+rW6z6TVt7aZd3jkoQqWSaF6vPjkEMcxLNUz3guKHK3juNYS8ua/O3li+DiNA/mR36aLAY25nVNIFMD/1aZkHOPXz32/YukReCwTdUAiSjc9e4rt6E4cQ==
Received: from SJ0PR13CA0091.namprd13.prod.outlook.com (2603:10b6:a03:2c5::6)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 06:38:32 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::ce) by SJ0PR13CA0091.outlook.office365.com
 (2603:10b6:a03:2c5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Fri,
 11 Apr 2025 06:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 06:38:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 23:38:24 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 23:38:24 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 23:38:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<praan@google.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <jsnitsel@redhat.com>, <mshavit@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH v1 10/16] iommufd: Add mmap interface
Date: Thu, 10 Apr 2025 23:37:49 -0700
Message-ID: <c332a8701959c098f747dd8e8fa083ceda2bf2c3.1744353300.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744353300.git.nicolinc@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 03687d44-0c60-4581-ec93-08dd78c37a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NVEP8leBgfWEYXVa6IGHCTSFOappH5bCdPFRqoOjHPiP0kNR0xSHyIjIsqih?=
 =?us-ascii?Q?O9fOX/htyg53vCZPwhsXa1O/Ov+wQDoV9HSOJGc+VdlwKT7dOVODcmlFlLgc?=
 =?us-ascii?Q?oPbVDi5ZZJvfnSRvJyiVAAXicjukIGtCuxBGmd3siLcH9se0+OFEq3bZmmcc?=
 =?us-ascii?Q?Nqv3D6aNRh1jolTcrWtBC9Mey1fwlCpK3gS0kK0xuOq6EnVaGxHSY0YIcGcG?=
 =?us-ascii?Q?VFyGZp0U+reB0PdJ7ISk5w60Rbjlb1YErpIYoK1q1DrnI+BMkKajEj+dpnjS?=
 =?us-ascii?Q?8oQuQxHv1nIlY88ASaYlJAiUmpk52nU5xXO/H+qh/S10fDjjSK371JVTWrGe?=
 =?us-ascii?Q?gjnn8NUiRYqvH5jPkpfee33v3Gst1xtnFUlAO9s8Y7KrfS7mEh3nDjSSkH6J?=
 =?us-ascii?Q?P8d2u9eDzlEstuOsku9xwlbdaso0pep4RVTq0NZIMtvZoVXjK1LtPBfWfxU+?=
 =?us-ascii?Q?oeJ2bSKG6pae2y0AkzJEw41IivanOA2c3qhcj0AE05SXYERaDYEcbIqTCOfS?=
 =?us-ascii?Q?8c2UMHV+61hpp5B8nLkwqgGauokDF5P3/2BbfV12eCFCQ8UddnKANQ90OcqY?=
 =?us-ascii?Q?ru5hJMMecDtloOBXVnA1EzpUCPCavQcF5vTXwR/Lyoj8PvrW97wqgWzOK29M?=
 =?us-ascii?Q?Xh8RwlFHqzJsaQF/j32GkhXZ0e9zgU5WW6XTQPCiCcB1qutUdzdfXO56w58p?=
 =?us-ascii?Q?xuh9aW+NtmYQCRJZ0PCQwtxNMIb16C+tiDbs+Glkz4H3BFBVIvwVSlJ9oVSb?=
 =?us-ascii?Q?n3JVhyJFFD/3qF6aMF8NTrqW2Ip20Fe0GHiBLAGJs77od0xXTeaao5ziWCSB?=
 =?us-ascii?Q?BZuGlhFYjhf5SS53ecmwxLzv2aB0/Aho/a7tuTs8ei3E0kESt0T8Eb4ecMFR?=
 =?us-ascii?Q?gVMgh4gMX6ELnF6r1dZW/R0UX9aLfsOZsIW8+6hWotdI3rWW4ppcGo68HdUP?=
 =?us-ascii?Q?9czjs6L2TLhu26C78yCC+t1VWhkHYaXkveFM0fG60F7x6ZXJtW6AMMdTIs7Y?=
 =?us-ascii?Q?pwmWD3xFr7/Eoslne1RQME/hYhN/Dwj8xMBKdHJvS4djZmanU4DA4k1xzQXU?=
 =?us-ascii?Q?hgVBJB81CJR1kGsCCDE3JJyPrQ0sZHGl11jJQoiSwyAz09vXNKeZvRK38dTB?=
 =?us-ascii?Q?9ck/UxlVMVoWPZ1c6KrCjMdWyiJ2ofOIlICGMyNfR814zaZUYXCb23MAk367?=
 =?us-ascii?Q?VUbL08vGhfSTAs1zFdbgMWjtrbzYtiWa+rZ47cmMaA+3xKop77zaNT6QkI8a?=
 =?us-ascii?Q?Y2pVmtm8zlfao4Vg7TSzSQCz5u9Hb8T61kXiAN0B2xwNvbxC1JIAfUadbwdI?=
 =?us-ascii?Q?X1Hx41SRYyepd0M7lNJFU/7jz4t4qvK5dbQN6qK7l5bm/i5KNrk5lRUNM04j?=
 =?us-ascii?Q?uWRChsdcqMoqMyby6mZxLns3k/WADf0MD9jx8lYViaR9RzqhpIceb/3ZdaWX?=
 =?us-ascii?Q?2ssOm4QxWqjkleX/QDhQ4S/Gn22Anlh+HD4TfKUFsBIqfCPeO7igAFd6GT3r?=
 =?us-ascii?Q?iP7H2cAQSQjajMwwf75Ger8c0TrC/jg8X26g?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:38:32.5981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03687d44-0c60-4581-ec93-08dd78c37a89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241

For vIOMMU passing through HW resources to user space (VMs), add an mmap
infrastructure to map a region of hardware MMIO pages. The addr and size
should be given previously via a prior IOMMU_VIOMMU_ALLOC ioctl in some
output fields of the structure.

Maintain an mt_mmap per ictx for validations. And give IOMMU drivers a
pair of helpers to add and delete mmap regions onto the mt_mmap.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  9 ++++++
 include/linux/iommufd.h                 | 15 ++++++++++
 drivers/iommu/iommufd/driver.c          | 40 +++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            | 35 ++++++++++++++++++++++
 4 files changed, 99 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index da35ffcc212b..5be0248966aa 100644
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
@@ -55,6 +57,13 @@ struct iommufd_ctx {
 	struct iommufd_ioas *vfio_ioas;
 };
 
+/* Entry for iommufd_ctx::mt_mmap */
+struct iommufd_mmap {
+	unsigned long pfn_start;
+	unsigned long pfn_end;
+	bool is_io;
+};
+
 /*
  * The IOVA to PFN map. The map automatically copies the PFNs into multiple
  * domains and permits sharing of PFNs between io_pagetable instances. This
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 4118eaece1a5..e9394e20c4dd 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -226,6 +226,9 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type);
 void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
+int iommufd_ctx_alloc_mmap(struct iommufd_ctx *ictx, phys_addr_t base,
+			   size_t size, bool is_io, unsigned long *immap_id);
+void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx, unsigned long immap_id);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -246,6 +249,18 @@ static inline void iommufd_object_abort(struct iommufd_ctx *ictx,
 {
 }
 
+static inline int iommufd_ctx_alloc_mmap(struct iommufd_ctx *ictx,
+					 phys_addr_t base, size_t size,
+					 bool is_io, unsigned long *immap_id)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx,
+					 unsigned long immap_id)
+{
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 7980a09761c2..abe0bdc1e9a3 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -50,6 +50,46 @@ void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_object_abort, "IOMMUFD");
 
+/* Driver should report the immap_id to user space for mmap() syscalls */
+int iommufd_ctx_alloc_mmap(struct iommufd_ctx *ictx, phys_addr_t base,
+			   size_t size, bool is_io, unsigned long *immap_id)
+{
+	struct iommufd_mmap *immap;
+	int rc;
+
+	if (WARN_ON_ONCE(!immap_id))
+		return -EINVAL;
+	if (base & ~PAGE_MASK)
+		return -EINVAL;
+	if (!size || size & ~PAGE_MASK)
+		return -EINVAL;
+
+	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
+	if (!immap)
+		return -ENOMEM;
+	immap->pfn_start = base >> PAGE_SHIFT;
+	immap->pfn_end = immap->pfn_start + (size >> PAGE_SHIFT) - 1;
+	immap->is_io = is_io;
+
+	rc = mtree_alloc_range(&ictx->mt_mmap, immap_id, immap, sizeof(immap),
+			       0, LONG_MAX >> PAGE_SHIFT, GFP_KERNEL);
+	if (rc < 0) {
+		kfree(immap);
+		return rc;
+	}
+
+	/* mmap() syscall would right-shift the immap_id to vma->vm_pgoff */
+	*immap_id <<= PAGE_SHIFT;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_ctx_alloc_mmap, "IOMMUFD");
+
+void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx, unsigned long immap_id)
+{
+	kfree(mtree_erase(&ictx->mt_mmap, immap_id >> PAGE_SHIFT));
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_ctx_free_mmap, "IOMMUFD");
+
 /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 27473aff150f..d3101c76fcb8 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -213,6 +213,7 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
 	xa_init(&ictx->groups);
 	ictx->file = filp;
+	mt_init_flags(&ictx->mt_mmap, MT_FLAGS_ALLOC_RANGE);
 	init_waitqueue_head(&ictx->destroy_wait);
 	mutex_init(&ictx->sw_msi_lock);
 	INIT_LIST_HEAD(&ictx->sw_msi_list);
@@ -410,11 +411,45 @@ static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
 	return ret;
 }
 
+/*
+ * The pfn and size carried in @vma from the user space mmap call should be
+ * previously given to user space via a prior ioctl output.
+ */
+static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct iommufd_ctx *ictx = filp->private_data;
+	size_t size = vma->vm_end - vma->vm_start;
+	struct iommufd_mmap *immap;
+
+	if (size & ~PAGE_MASK)
+		return -EINVAL;
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+	if (vma->vm_flags & VM_EXEC)
+		return -EPERM;
+
+	/* vm_pgoff carries an index of an mtree entry/immap */
+	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
+	if (!immap)
+		return -EINVAL;
+	if (size >> PAGE_SHIFT > immap->pfn_end - immap->pfn_start + 1)
+		return -EINVAL;
+
+	vma->vm_pgoff = 0;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
+	if (immap->is_io)
+		vm_flags_set(vma, VM_IO);
+	return remap_pfn_range(vma, vma->vm_start, immap->pfn_start, size,
+			       vma->vm_page_prot);
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


