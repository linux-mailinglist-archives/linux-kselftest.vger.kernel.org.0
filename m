Return-Path: <linux-kselftest+bounces-35905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF06AEA6CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9FC7A7892
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12D02FA625;
	Thu, 26 Jun 2025 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OvfTB8Bj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E097A2F94B4;
	Thu, 26 Jun 2025 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966560; cv=fail; b=PwnBLV5UQDW54QGP5rPMRzPOZaHWUrzOVpv8O7t8izb8/qWA8HBwQ9ex3f//QpWRNUFWYIe9b0qnacw1mi/YX1itIr4mxotqKVJP8D608zdnaqI1EKIZxC9Ge8RJ6BSj/CF2WiR3cq1Qm0A9YGpzx/7d+FvjQk1LCIQ9A2Vixcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966560; c=relaxed/simple;
	bh=d1HVQTFIwhLoj+wbZCtBuvC0p8iPvdGayYLEqVW4LPc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/oeXyrSCevYxZ+uxAVmJwzDZyg7ssqeDwRxO477HLGSIMx4eB8rdM7XvkxqD6XUz6bVdkopYtut+98C2z0cgqG/N6NWibGrRBwX+j/pmbQ3UCOpFGfm4CZ9ULJ2oimIgOGX77AVjYykwi1/A45PGoCEkXLDYoax+LEnkbwy9Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OvfTB8Bj; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ipel7yuFGOTbavgyIwIsKOSHbJHzroWUFddfnxWFZKz2xlZ8kEjZry5gbwM+Z9R8hQsOgqQCGfkQ0vRCeXAu0fTL/XRLyXw/yMAuSyH0mBHrs0rl1OAG3v1XIg7wZp2JBQGxfcAAmPCMOw0nmrKgxyXGi4PsOsligxSi1rIiFlafx8DK9NnRe6K/AamAan3wwtzcWqxsxPWeK8gdhMdrO3wheede+NJfKxyLrxyW1hCwaQN+6WtZepyOkB138CxMuCjM22z8UQ+V5L0WEeJrq8YlcpHoL/G1cuMzJA45S4ZIhIDKn457+O+AibkSCUKpY14tnoevFQiSBzTHh4JRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3TciHsKTvBhjS4hFo75V4fZoVc8nmVlWujJDERua8U=;
 b=I4kHiMEWdmGXkFF+5yaeRZ44k2wEJUKwvMm9iiECfVO1eVHPlFr3BmvgSbB2ei3QQW+diOwz9K81VmX3lN+H863pfGfpDJDrulD9HdEg5tF+gkKWvu1kHBnaIY1aLqPqNzgLuS0UairifOXmoLprbsWemo7Np/OMLB/buFlhShNFScplU1vDble1fZHFMAuo4+Z5b2AxQ++A94esW/ihoKhhUamYWP3EIiDW1KUlj48+6u1MFNBo8JBEagPlL9PcLT2pvoP/wO3r4RQUILdNeFjVXUoF9NUslmY63OdDVLG0ERNgqPd0lrSb3HSAuxVIgVyJbVQlllbt5V6pj5E+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3TciHsKTvBhjS4hFo75V4fZoVc8nmVlWujJDERua8U=;
 b=OvfTB8BjCIvhVdUFeYxmM/YhOYxJ12DwlrKi0sUjhFg/wHwirtU0rdX6/B66eZ6f8BWhgBmUm1n0NpnBda7sTNdQShjzkwHI/E9/7OoAyGE8JrOlH47OpdExian0ptwZ8qjB3oaSeLf0LP7wKF7GEINg71lAHuinZ819sIbYC5y3raTe5MN/hMgLP4AN4olwyoQxEjchIlPBuHWq4xvyYj7UHYVW/DmPKEIvN9SM6FyrOm39gqIeld7kPbIXBAwNP6AJAHtnomG/NqzJn+i8FO0GZg6nT+ex2IS+UQ8va0NHRohpJ/xhYD90+/vtUpW/MRuHK7IK9viZoQT/OC3WhQ==
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 26 Jun
 2025 19:35:49 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::b4) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Thu,
 26 Jun 2025 19:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:29 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:29 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:27 -0700
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
Subject: [PATCH v7 16/28] iommufd: Add mmap interface
Date: Thu, 26 Jun 2025 12:34:47 -0700
Message-ID: <8838cf37c8019df5f5625c5c8dc6399d2fde0bc6.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 498d0a6e-9346-46bf-61d8-08ddb4e8a7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MgPAmtyMXCb6HFwLmy7UpuCmWtBBv0nAEOZG9THEji7r1NXpGPYCoVVVYeF4?=
 =?us-ascii?Q?c1OL1q3zaNMivblgloQfjS8mArr2nVw5gjf8lo/553wr6qA6/gsbEijC2q2c?=
 =?us-ascii?Q?k2jAdgTNZhWcx0q6X4Qe/YVlBkDPLvPb6sC5egF2DHIlyQrJeQmW3jHF/1Yt?=
 =?us-ascii?Q?twn0YT6nuqZQJha8QtDa1vCKOUNKJSsrHVggiFtwRYH8T7SYDOdoAivaYab/?=
 =?us-ascii?Q?YIBIAh2dBY2fGy9ckzX9Ce3pg7Jfog72/LfBHq6DUxEOaW8RbkbDWdjNvQUr?=
 =?us-ascii?Q?XJaGj+OogbsuwawMZAhHp/Bu9XKUEKXZuEFchx7gV1OJhZ2j2KgQjJ8U4CVn?=
 =?us-ascii?Q?uV3z67TfQSGH1Nlc/VzNQnswOagxyUEYqZGwaGJw6wS9GAJWx4wFBpyrX/a1?=
 =?us-ascii?Q?7W/jM/3sjjNTvFPWIZyOd+RnDzmOKnUT3xdtB4jasCKpLzYCDfYE7Z4HMtTa?=
 =?us-ascii?Q?z43IZbNlANYSDWKc79HpXuzpd9A6ahYesqP27/SxserRF4mIPKEQ5TeaaGf+?=
 =?us-ascii?Q?btLWKhIfQpGoSJKNzGW4rSw5cGwDskRkhiFU9l6AuyFkYTiBXCYCxJdTxHqv?=
 =?us-ascii?Q?iil+A30HrRaeBzu23r0NkGEucCCLxo48u0i29JSCcseFS3qKdPtwHEv3MoWa?=
 =?us-ascii?Q?krT1Lj7zzr3PbS/D6iqVuyO/iTwvFRpm4M5YjIBehSlNJhJHyS3TPAJUxstz?=
 =?us-ascii?Q?ShcW2PR1HeEIHsi9ESXM24tyrks15jqf5ogP8xhc+y8xB9JWRwCOeS9xVZ6a?=
 =?us-ascii?Q?8RNLhR+kags0FFvmHLkagmmDABXVfKA1PLmae13OowYI01v2zEpxMC3iDa5x?=
 =?us-ascii?Q?4RQZGVLWZCC2ZPeVaoBrDS2AcoEinV8MeQwaxMq0KhDOHUdYN/Yzb0SFVhlv?=
 =?us-ascii?Q?3OoMmf+EpMpsDUvrmOfYy4qCZKltJKVfEAGo45Vr+jiVYQmXIWTbNzzZXtjA?=
 =?us-ascii?Q?C1npoSZ/1hLrU+bJAD1FihhMSRV0sINEg9bZPiWk/pIIGF6xdyEs6aPAwqLD?=
 =?us-ascii?Q?5UlRnH+RTFgxRaXcwlwZunbxxP0stBY/UFTqwQSbgNdMD6PN6qiaUfgz9Cck?=
 =?us-ascii?Q?OCX9ywy+c7aFEircHozgjnQk/DCxHA2Y/U2H0u1fXOXs9h65OPsbYjh7oT1F?=
 =?us-ascii?Q?EJ0dG3Kfevqk4+ucZusA2gc21yTloUgfLFviviXh06+hn4rnruPSSF8IgdRh?=
 =?us-ascii?Q?8TJk16HSjoMRIhDJhVTsaYJWCz03tOph1kzkzwqH9HFnccoz2pxodm7fiRsP?=
 =?us-ascii?Q?CbGk5kpQyL7WGh1bI/+/2halOeQb+Bls9UBT6qwkk1Ecz4HWzPXI0B3T5XNe?=
 =?us-ascii?Q?MstplOJqwHkXovO1YvHinc6qR8N5/m6u3E7NP0K89ATFveu/mG6wxngV9H9f?=
 =?us-ascii?Q?tXzXTy0KzVsEbGs2LBc0zsHH80lw0xozW/mn/tGO9S13OpbbTf0uEemdESuE?=
 =?us-ascii?Q?G84lV9x+kDResvD2gDn/MqtANsDlTkPG8KpdxRCb2mmiKL3jKo5fWkQYYeMC?=
 =?us-ascii?Q?voJHoSaGivY41AKVqS7ezCNmpI0MFNCW4bWf?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:49.7835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 498d0a6e-9346-46bf-61d8-08ddb4e8a7db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188

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
 drivers/iommu/iommufd/driver.c          | 51 ++++++++++++++++++++
 drivers/iommu/iommufd/main.c            | 63 +++++++++++++++++++++++++
 4 files changed, 170 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 936387bcd0d0..ebac6a4b3538 100644
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
index 563bdd30a8bb..7ab9e3e928b3 100644
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
index e578ef32d30c..2c9af93217f1 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -31,6 +31,57 @@ void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
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
+	rc = mtree_alloc_range(&ictx->mt_mmap, &startp, immap, immap->length, 0,
+			       PHYS_ADDR_MAX, GFP_KERNEL);
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
+	immap = mtree_erase(&ictx->mt_mmap, offset >> PAGE_SHIFT);
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


