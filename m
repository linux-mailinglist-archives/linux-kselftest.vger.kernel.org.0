Return-Path: <linux-kselftest+bounces-36626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E34AF9D5F
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AB6587BDE
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A46321882B;
	Sat,  5 Jul 2025 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BMCxh61a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD9D2163B2;
	Sat,  5 Jul 2025 01:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678082; cv=fail; b=IGVhxiFdLkjtmVZq89/7i7W7UB+t5A/zklbIy/HBYqfxTCYdRLfm2TLbvMbyV9oF+eYB0hqaPc3ZvZra9XbhizjTpgGkQPw1b+SesDkTlhMScgXn23IgPvFznmpNBVa5i6jTEpEs2qTvwgVZOl2mPWyjItei7m02giyPI5LP2oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678082; c=relaxed/simple;
	bh=9xdXsdfhAiqjlLsEPZkBkqSuzkjkMnB6PRIEDgnla2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cviQAG6fTzKfb/3Hd1okq9wrJAqxjt4IJPhAfPnWlDsbqJamLPdY2a0S1eq4gLJEL9GlCI5ooEd5X4+1/YN1NOoHDcKSpYG0m3NxS7lTREfeltT4HaefhMtYAHq7EKx78y1mPbPXK7gGADXG3j4BxrSaoc93b9CV21b5cPy6+3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BMCxh61a; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJ+jlQOeC7KAqOm5PbmgozUVzBlveEjFe+KKvGXcD+gPAAdAdzuxJ+6mE+HiZCbp5XqBhMLAdB8Gx3ulYzYc+ls/I8jU8qOEqj+zH9U03LmY2hnXvpZiwfa027rz8qli/EMuTzllZWn6Adu3oXCK5osmG9GdYVCZZazSEJcNse8uEHKW0cGV2mNLPoxB74LFFWFNmztkWa49sdOv5myjJBUbvl3nHza+w/t4WDpi1f+qw3lqFj3eTv65JfpSK8bLxz2GC1m2y+x96ZTsJMsB4yl4qrNBblxnV9RMXDwhX1OTTYW1r6qr2w/WQEnQSkTUzvoB7UCx4QWJ+6gmGrN74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeqSlaD3+fR4iaCN7vg1ThmFgf8ZAP8ay1h2s8w2L5w=;
 b=Iro3QkZ5sSk2h/eYcOx76rlpYdiKTC8knF42YuA/3MAl1rVmm9Av5MuXDZKxxFps6gNM7pFtdB6ONCL59s1RAM/m74Nut/ypz+uT3uNK87mf+Oe1+cvM0ymppaqEAZPFk8czvu1vnMuX6HKXnz04OPsaAqNA7ohgu3XN3H/ZyJavoM6F5tS4/UfdcBm+qzG19N5hxS66BVyBhGUn1jo2R2ZcJcr1KkQic/tsTP5wip5IE2Gkh8Fovn8E7ujKphbD+ejBs0WagL231oyS6Q52gJIBuchlZr5RxccFKwt7XstWFn1HUimxzn5Xg+44pzEMKemzYoleZXluZKVDd2aRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeqSlaD3+fR4iaCN7vg1ThmFgf8ZAP8ay1h2s8w2L5w=;
 b=BMCxh61a8FFIYWZt7I0CGElM0mHwnv+X+oWV5DdhzodVpsCTJ7X+O6MiJx6FPqYsHAEqyZTUAHNAGNe9qwqxCUxriZl4/cFySt4FCE9v6pfCQ6u4MZuKTLyILgmK00N7ZD3mpqApmMHDt1jflnkJu1naRdvdaqra/1O+8ftycyy6B7S1eZqA1b6oR26gdw8lbSZYt8HqRXo/WabWrMtbA+fwzxvcB5k/vuw1kYnGIm8Je9kNd6jkLKMrokBgMvx+yvVXFgRgam8AFuxu7D8Oimm4+EYSh0V839YjMgJl6pxeWfpfw1ho7nKCLJ9WDKLuzSBJxK26ZgWN9flaG2i7nw==
Received: from BN9P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::12)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Sat, 5 Jul
 2025 01:14:33 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::83) by BN9P220CA0007.outlook.office365.com
 (2603:10b6:408:13e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Sat,
 5 Jul 2025 01:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:21 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:20 -0700
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
Subject: [PATCH v8 17/29] iommufd: Add mmap interface
Date: Fri, 4 Jul 2025 18:13:33 -0700
Message-ID: <0531de75092d321548c719a45a73454b2805c0bb.1751677708.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751677708.git.nicolinc@nvidia.com>
References: <cover.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 3889b59a-e436-45b5-6aea-08ddbb614cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bt6oxScN05w4DNI7GFbLv4S2s4colq3BXJ0iidIg8sXLA2YGwjkN+S30o0TO?=
 =?us-ascii?Q?OzjQkLwA5qcjKj/GZHLmtCcoNW10kDrxkkWB5U2NwiwdFzLHndzfYQlJIuec?=
 =?us-ascii?Q?4SHCjErK0Kb/u/Hk2wSyZNz6YMeqra2bbi6RNcaHr9tsr1fNyDiH2Eb8h9nc?=
 =?us-ascii?Q?KrXyGm6U71OPNTi/1LC3IH5aAFqtycw7t8Su6KcuuadR5m9vkpy2QX7Wp/II?=
 =?us-ascii?Q?yNnXWNqm5wovc8OajUmJGAM/2DL8Zqi2V61Cl8jcjuyNiDBjVBKWnwu2ZQfx?=
 =?us-ascii?Q?aHR6GUKvnmBac5wbMt6y/+1dqGlBJk8K1ZwDujnScs+cJR4dfRc3U/yEOFyE?=
 =?us-ascii?Q?xkMOY5FSQJ70YS1qPko/OGqyw2Ywgp5+k06oHroymF/5DPwROBsG1mFcDOYb?=
 =?us-ascii?Q?2SR7BdpoR8tD78o0GFDqBHTQKKzIFXwAPEYrgWB9XzV9JB5jj6kDV5Pw8bpC?=
 =?us-ascii?Q?BIXAKTId+0qVQRSDCsh8eF0FP99leQCo+2sYU93ZgMjuwdhBwAJqb7XjHQ8M?=
 =?us-ascii?Q?sXan2ixRbxSelG8xuJO+jTRcWt0IdZ3BueU3SBUAZvMBH37cB6sGDFid7r5Z?=
 =?us-ascii?Q?/h9dgN5SgUhKmwNHFz3okLP8GQx6gXkTb5CLXQs2KJezJVmXrAWwoIDklyDl?=
 =?us-ascii?Q?enXaK1NDbjyRY7AyN+foCJOVNwYorTJoJPM0QOGgm9PMQCht2nNXHu2ttDdJ?=
 =?us-ascii?Q?WM7fAakGu8BU6fqDQw7RRkTUGqQnEJioO6IzCwBgsLXDVbomBSC1/sfenlPT?=
 =?us-ascii?Q?/UDmfcQNJOJO4jhiBDC1ClCQcQcqXGzqfU9K44K/8mpxXeHf2JsSj+S3CFlp?=
 =?us-ascii?Q?I54Jrx6JXimGGtVY9BM6PCBOECuXD9Jk837UWtU+gokhRuXoe9kwrMadEems?=
 =?us-ascii?Q?zemQWvgmyQbv+p7ThLRAoavrs5kWPDKpN1ECQ3XGGVJQTZAwYcKAsO3X1VW9?=
 =?us-ascii?Q?IjoImEDoEsGf1CtFEJGrvrt1DaWTGvn+ZAShOHSgGM9P9Zkqf6+tnut5pal/?=
 =?us-ascii?Q?P1jb+yVUCTvoyg4ZkyYmt3dKCTPtDF/+39ee+BEt+d5UPH9ltjo9xhgaMO5c?=
 =?us-ascii?Q?W0fgHXoK9tUZgjeVadoOD03T+Tm6m2GEVAY047z0o2bOFOXv18UkEbkvvqxS?=
 =?us-ascii?Q?LoNAGrwH7x/uePX1R+veQHspvq+IKzXJzoUOx4AwzM7YLegTfBFd3UMDHXes?=
 =?us-ascii?Q?jnGJZtWbDLjktjrdP8Vp0sE1uo7TBTNDPp2hLGVERjHWKqy6kWmAMLbE85iz?=
 =?us-ascii?Q?ofzMcTeb7Fn/Qyq0ify22TaVQ9hc9xcY43zrzLLecvDNh9LvJ3rE3kEHTNgA?=
 =?us-ascii?Q?nvBmizbDIq+YKOTArQHUidEKqTDD/sFhvgBi/EjAwL4wgijqQ6wRcMnMAqRA?=
 =?us-ascii?Q?OAiwn/O4sTc4HpxRTwENxIUv+xgE270fH6ZsK9laeatePK4OnJIBs/nbL7ul?=
 =?us-ascii?Q?erdnLgnd+nKIs3yoWzSJUJsmXJLhrU2XjRR+xx+gpTUS0skbGixgM/UTQ1+6?=
 =?us-ascii?Q?a1lUEbK02Caif6isFA7j1S+ily6oKI0gvKO8?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:32.7946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3889b59a-e436-45b5-6aea-08ddbb614cae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115

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


