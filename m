Return-Path: <linux-kselftest+bounces-31685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F49FA9D7EB
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 08:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64761189A623
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 06:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86CE2045B7;
	Sat, 26 Apr 2025 05:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VBIQJbln"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F345D1C861A;
	Sat, 26 Apr 2025 05:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647170; cv=fail; b=aFjmZjeXyYPr9CX5vy3QjbqG47Y7VRabzceOnWIY0a9Q3qCGA+1Bcg1exNTiglK8WW98qJch5p3ogdU8fOyjvg4xVMWyeJCTMXZAz+WBc15LsgIFekvgbi6OzCELXq+zmsJobF/LXjGTmwIfLkhLkgKJOlLZ5rZZcDSLiUdemIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647170; c=relaxed/simple;
	bh=SlQxpoikpnP3p/zP2RDkpRWZ5KDCSiuINtqEGiPoHn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4KEHh8u27/aAQ2j9krBk99AOLDhefJ0xEEjZ3kyyArUZZCgg6889oXhoTHRQ7zYP1S6//KUK/RRE1n5VLZg9cTFzrWuWLyrPh3uiWSBoguphPyF57iiQor6/nHYv6lg0enGDgLWfbjiJ0dQVs9SJ7tOpxG8o48IY/s1YlRsKMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VBIQJbln; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=typ8Ujvc7n0DLLI8At2xkVBSAgE+xdiKlq0m+5/MDgfiMs1dQC8X4dtXyRqXoiiVyDv69KaUy/UP6WxZBgbSPEK0ntAZuuavL8eG55LTFH/V5h9ssN1UBlVGtzj8XNPdMjl5D9FvcvpoVvx4Zi8qTDWoIeZeMXagne+ZQxwFlg1JkqxCLQEdYPz5CG0A+FOi12b0az0EZSoIeGXH+0p5qJ5/r2DTanrYr62TevEYJbrk/UhOSjL6Kf0kZNauY3Y1gtejv4TuC+lGbXSnu51UendfKqF3+9W5qNrh48z8s+GYkkrwErYbf7M2AqkXwSTzaHswzuZDm/4uc8YNrlEXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7o+Icq6NFSPCMteeGg35xrq27GSlDAwoo/tZvrKVER0=;
 b=VDOPMWcNDPYWZ6F5k1qHhcr/QLwWc9UZ3vLKU0WNJfrpm9icPhAoK9IBtBTeo9L2V2wcodHuZpskY4yUBKNcx7Rh7DF13aRsUtuUr1Mm7J5sAeZgFHaxW4H3AsK3wiDK0UG+FKXsBzQyuQc+W0CdPQFtolQwQCqZgaL/jt6DkICby84ziv+B+Fz7NZmfLTXWJRRJ0td6DUVipUMw3DBnmjNQtfuyeeoifOT20DsoRcfB+sWncjrx+skH1PmdcBiibgMr7SIdUzQp95k0TExThk77ECwm3MTLG7+uYTN3Hm7RHRbex+lb6B8xdWi+dOqh8KsPbpa06KQHDoVT/bLR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7o+Icq6NFSPCMteeGg35xrq27GSlDAwoo/tZvrKVER0=;
 b=VBIQJblnxR0uCbJbmlINgGmuAL0UIjFitqu5bmaixyhW/dFpql2bQXc7PRH8OJ/Q2Y6wTG2IiZabY1ktY2YqRp9Vxp/feF22+t9hhdKRsevriNl3NvpSp+H0MuDREHHoYInNH0xaNOavq1ciMaBplXqYKzd+m3U7PGxp245aQWjUPDfoF27aLwSbHhIvY6SByKNnuLMWji/KuDQNjuciU567g7GxLUYGj2V1OeRH5GIaw8R8DPHGgPLRv5qWOE31MN8AqRUX3MzA0D8MwzycNwXDMhtjFHs+tTFARaAHQjPDZXKd7mAegAXdMK8GVmqDQt676fg3CS/eiLruhDoM5A==
Received: from SA9P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::11)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Sat, 26 Apr
 2025 05:59:23 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::fc) by SA9P223CA0006.outlook.office365.com
 (2603:10b6:806:26::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Sat,
 26 Apr 2025 05:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:59:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:59:13 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:59:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:59:10 -0700
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
Subject: [PATCH v2 13/22] iommufd: Add mmap interface
Date: Fri, 25 Apr 2025 22:58:08 -0700
Message-ID: <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dcbe6a9-ca8e-4476-a58f-08dd84877e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cCkcbIqy1IEFPA7pEzeZ2NFl4xjTZjETuvSdcMgiYwZoNRtltH4lnHkGp+Hv?=
 =?us-ascii?Q?RwtxKeHtAVkwCaIbNGNc833J5dpFsB0QwcoVSicSAoDZ3yBzPj/zl8B4uv2z?=
 =?us-ascii?Q?rC+Q+l0q8hHVWnpDilIKLRoKc55xBbc5ZYj+ISy0UQIg159Yt1hfKwkZd1Gy?=
 =?us-ascii?Q?alKbkzXGJ8hDi/DYyPfnXJRkirx9SH9UxDJHd5fTF6Hv96e12+Rgh48sCwAg?=
 =?us-ascii?Q?VXXjiiA32hFpENtfPtfUq1Ri57mOzZLw2E7y4p4E0S77MCPiG864yvcMhbsk?=
 =?us-ascii?Q?cItwW3RolTfjkRXTQ2YyFdGb14GifHFSMU3nSZXVqXHJFG8A8AmNHERsS+rW?=
 =?us-ascii?Q?BFnAkFVZBBN9aW0iQ4nJ87XrcyJByvmVedqPKyz1K55d5bAaQYm2iZMJnQLZ?=
 =?us-ascii?Q?IFAgeOGMlwPAulga8RfsKLFVeoCyhlngs5XddvPiDSv93Q+9xp7UTL64Me/X?=
 =?us-ascii?Q?By0hQzA+D+V5N5an9qA1tvMgU4gmEt0PF108lum4gPgXxNG6Ci6qGuMIKFx0?=
 =?us-ascii?Q?tnh5QcYgsJPy/n91m3n2O4dUaa3XjMuDOCWwksiVnT4VqpQmZRMHQuTS5Hb8?=
 =?us-ascii?Q?zr8XMeAel2ZkyKPUnA2bQYvQGjKJgQdnpezhKEPsmiZCp1an6+NTVxO7gCE4?=
 =?us-ascii?Q?XDf1XDjRtYPdtl4udeL0u2UyBtciq/huk/N5sReULfmjVl9JbgCKxXYOZngi?=
 =?us-ascii?Q?TF/VZPWYp7oFQESs2124Y7bZ5z1R7O2Qprb/toTj3W0hZy4nxI5TpAwgdcKA?=
 =?us-ascii?Q?Xg1bqGXBlJAxsFMssk8HY51y6VbL3mEWcMEj3vPmZz3jwjfDpHHcfmQVqYCo?=
 =?us-ascii?Q?AdMItT6ZYTwDYmlPjy/DnpvnKc9L4EnC618Gs46L9UB3fH2hbWau4dmzrTJ0?=
 =?us-ascii?Q?NkJjwGyvY1DKO26bOS3mY2cPnomIs1w+kO/YvLqS7ckLphAJRbg0+5TW+bgN?=
 =?us-ascii?Q?htPS4ml7S/gNJHplLJvqakXg+4VfXGRphrHaI6+XyZ5ioUPHxvmACemu9Ngk?=
 =?us-ascii?Q?jRZOXFMYVuHfgVmLrB2LexzcekKOVzg5PFlZvBS/0hohyudTBGNVg54AhO5f?=
 =?us-ascii?Q?L082Yi2QYpqOCgh7XCjrjgz1ZxRHaKrnj1i4RHmVG0XEOj4VMAWvQAslo7Em?=
 =?us-ascii?Q?e9i4iXKaD8O9oqX6xA9z7drdGS0BW8OU24GGfkcqTQ683/6pTP76b+zjxrLc?=
 =?us-ascii?Q?nj2sQ1ixA99PlHyAGxaMmDOvzF3hrDD3PXb25JZXFxEtXeISR4VrU4XZrmUn?=
 =?us-ascii?Q?jy6bJ/QqkfKwmtua8oAabQu42Jzip7MVkhKlxzF4x9cFpytiIpX+M3io454y?=
 =?us-ascii?Q?aIi+5ZWoH7l5MoDF8wGkQuEzFxTTPPBOX5u+KFVH3qYwqD5q84UJB19fG2lN?=
 =?us-ascii?Q?aMp3J13jv3ZS7Z1uCEhEuRVRvAwHE7xtiyV9zLRQzSLROSJRzqth5mqvn1FA?=
 =?us-ascii?Q?nFPOVZMaAZ5iapKcRl8/kqSgHMmA8qsbGdUoNEUi7ENCY6ZRZUvwd3RhwD46?=
 =?us-ascii?Q?zkHkyne/dglQ8PGpMkfYxdCRZGz5Ep2UrrdV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:59:22.5069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcbe6a9-ca8e-4476-a58f-08dd84877e04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079

For vIOMMU passing through HW resources to user space (VMs), add an mmap
infrastructure to map a region of hardware MMIO pages.

Maintain an mt_mmap per ictx for validations. To allow IOMMU drivers to
add and delete mmappable regions to/from the mt_mmap, add a pair of new
helpers: iommufd_ctx_alloc_mmap() and iommufd_ctx_free_mmap().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  8 +++++
 include/linux/iommufd.h                 | 15 ++++++++++
 drivers/iommu/iommufd/driver.c          | 39 +++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            | 39 +++++++++++++++++++++++++
 4 files changed, 101 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index b974c207ae8a..db5b62ec4abb 100644
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
@@ -55,6 +57,12 @@ struct iommufd_ctx {
 	struct iommufd_ioas *vfio_ioas;
 };
 
+/* Entry for iommufd_ctx::mt_mmap */
+struct iommufd_mmap {
+	unsigned long pfn_start;
+	unsigned long pfn_end;
+};
+
 /*
  * The IOVA to PFN map. The map automatically copies the PFNs into multiple
  * domains and permits sharing of PFNs between io_pagetable instances. This
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 5dff154e8ce1..d63e2d91be0d 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -236,6 +236,9 @@ int iommufd_object_depend(struct iommufd_object *obj_dependent,
 			  struct iommufd_object *obj_depended);
 void iommufd_object_undepend(struct iommufd_object *obj_dependent,
 			     struct iommufd_object *obj_depended);
+int iommufd_ctx_alloc_mmap(struct iommufd_ctx *ictx, phys_addr_t base,
+			   size_t size, unsigned long *immap_id);
+void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx, unsigned long immap_id);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -262,11 +265,23 @@ static inline int iommufd_object_depend(struct iommufd_object *obj_dependent,
 	return -EOPNOTSUPP;
 }
 
+static inline int iommufd_ctx_alloc_mmap(struct iommufd_ctx *ictx,
+					 phys_addr_t base, size_t size,
+					 unsigned long *immap_id)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void iommufd_object_undepend(struct iommufd_object *obj_dependent,
 					   struct iommufd_object *obj_depended)
 {
 }
 
+static inline void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx,
+					 unsigned long immap_id)
+{
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index fb7f8fe40f95..c55336c580dc 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -78,6 +78,45 @@ void iommufd_object_undepend(struct iommufd_object *obj_dependent,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_object_undepend, "IOMMUFD");
 
+/* Driver should report the output @immap_id to user space for mmap() syscall */
+int iommufd_ctx_alloc_mmap(struct iommufd_ctx *ictx, phys_addr_t base,
+			   size_t size, unsigned long *immap_id)
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
+
+	rc = mtree_alloc_range(&ictx->mt_mmap, immap_id, immap, sizeof(immap),
+			       0, LONG_MAX >> PAGE_SHIFT, GFP_KERNEL);
+	if (rc < 0) {
+		kfree(immap);
+		return rc;
+	}
+
+	/* mmap() syscall will right-shift the immap_id to vma->vm_pgoff */
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
index ac51d5cfaa61..4b46ea47164d 100644
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
@@ -410,11 +411,49 @@ static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
 	return ret;
 }
 
+/*
+ * Kernel driver must first do iommufd_ctx_alloc_mmap() to register an mmappable
+ * MMIO region to the iommufd core to receive an "immap_id". Then, driver should
+ * report to user space this immap_id and the size of the registered MMIO region
+ * for @vm_pgoff and @size of an mmap() call, via an IOMMU_VIOMMU_ALLOC ioctl in
+ * the output fields of its driver-type data structure.
+ *
+ * Note the @size is allowed to be smaller than the registered size as a partial
+ * mmap starting from the registered base address.
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
+	/* vm_pgoff carries an index (immap_id) to an mtree entry (immap) */
+	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
+	if (!immap)
+		return -ENXIO;
+	if (size >> PAGE_SHIFT > immap->pfn_end - immap->pfn_start + 1)
+		return -ENXIO;
+
+	vma->vm_pgoff = 0;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP | VM_IO);
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


