Return-Path: <linux-kselftest+bounces-34992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A97DFAD9AD9
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB33F3B97B3
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1453C217707;
	Sat, 14 Jun 2025 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O+8wS/j+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09D214801;
	Sat, 14 Jun 2025 07:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885349; cv=fail; b=cBJEO5atu86T1u1sC1O545Do2CiVEIm8sYcSfkC7CZAWw3iWFw2V8+ZtjZw+/VIWHmokM1emJ9KvlHQlVSSiwITZi8gfEcTLwitFgsANblKeouc6V8Y33oGsMb62aqBgqZX5ceND2mjq9BOj5rwKNEv7SPquXC8MFIf8CDcBe6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885349; c=relaxed/simple;
	bh=Fjlnd0TXhEdGMYd02o35oQ2CzIfOOi/JGRbcFE8mHdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edK6m9s6e3h90mUN6AaPAoqpK2bXH7WAc6gDHJV0naogFUAotjBGC3GRs8Tp2PAmiYiL/DunnKjIOao0UKx9GLE/MbuwZPvsh9WF7HJT2ZiGF6B1Msj5IwPi/gol5yhResI9V2J1oy1SL9lO5GEJVg/zt8PDJv0NYEb0uT7FGZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O+8wS/j+; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEIXagK7W8nx1V/rr5zpxOF3vpygrQnjTeMjyeq5BoqhehTFoCHckLgqjoecuSQir+NfR0qUj/7wwPkkO8fg0ul4utiJkY1gzKplWdmKzEcYlgrXpQx9AY2zkXqD/DbNbYAWyYCvFGsp3yvFpkRDj5Rh+i1zT5fvRMqyS86vTdw2yWtS90Qn3z34foFScFKn+70RsO05wXZj2T36fbLMWOaJPBV0+jysP+ZJLWBBZC2jrEVJVpSMSFeSExD+9E4peqyHZNzD8aHL0cJ46OeKqHZnpqM9XpMu25vxS3ch9Nqa2gMBV2Oy8wq+C1ckKznBYLhhGA4Oo6l640QJmC0cbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5OSFxz/6ptQkYSK+f6ydXmX9tDUDXDlTr0rjD+0Qrk=;
 b=dhcYfIOoGrghcAZSZlyCfl3H+dLfwEVj1Rj/xCVrnR8RtoGJQEDHDjbzYj/Im2Pn8HU8zo7xV6pmm+HzbuLJCIz5Qhz4mCIKAR0JX9w5VbJXsBEYoy1PgYUA4YQWJP5+YiwBNJLRazq6eCWK3vOQueBpABnCVWvzy9v3u6gGxMjIYmJPgZ1/v4IJWAOBP4B+6dichZFuIbH9+wCWlaFkGoit9GfwbjcKtnxOUSxFJkUoB9+amP7pL3O+H8YUMEiWsBJSId2bXkoNtgyZN1Q8xXELkmnNkOKr4SFGHBHMyqixPjSFb80KCodujQWfZ6xhWulEryrX//DGX+0lX4b93Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5OSFxz/6ptQkYSK+f6ydXmX9tDUDXDlTr0rjD+0Qrk=;
 b=O+8wS/j+jmuQPHqV3dg7uGA04Del+ZMbnselAKU/w0FXgrNcqEyr7/dVR5TllBypebNDlX2dXNEMA38gEUeWQpFfiAxdhHeSOSYE6bMVOKcCXxrFowdv2ba/ORvUO5iQpQCA2DtDef7sIGtdTHaGgJM1Zy9jE7UdZrjJZBjNOc196zqFB6pnRCQBT7iye2za0dxjMVKRnNOxYtmk/OYhBMlsJTAC7gdvL4YSo9Lc7pBIvxDYbc04zyTFYfBKm+7nPH4hppyAl9Iqx/Fk+RE52YaALU352JdgWV+eS3nRdfwusvlsejdH+J2yqsIwNgzSeGs8zDshCGXhKvmJQaZMHg==
Received: from BN9PR03CA0668.namprd03.prod.outlook.com (2603:10b6:408:10e::13)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Sat, 14 Jun
 2025 07:15:37 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::ae) by BN9PR03CA0668.outlook.office365.com
 (2603:10b6:408:10e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Sat,
 14 Jun 2025 07:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:22 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:22 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:20 -0700
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
Subject: [PATCH v6 13/25] iommufd: Add mmap interface
Date: Sat, 14 Jun 2025 00:14:38 -0700
Message-ID: <c9929e0c9ec6f3f6348cd0c399d6fdfa9f35f973.1749884998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749884998.git.nicolinc@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab0b2fb-24af-41bc-b209-08ddab1342dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WkCJs1mA+j8AL6YfrrFvU8KKip2diXCumG7qV2fBTzTfFUo6Kt3n36noBrFi?=
 =?us-ascii?Q?EW20A6gMr9bf1WucrJgbCjXquinGZkOlWBHPStORrMxx0ac6TbzJ6sehOq6o?=
 =?us-ascii?Q?XVCJGtbArPHXoO+W+0KygMIo3UTne0Ww8eQCGkFGCBVKpXDrA/7LhX8Sk3gL?=
 =?us-ascii?Q?D+YvyQUuRdhX7vqYuW3NKonY9C0YCUZbD4uAULIyiOI8XD7eZtSrV7Kr3Mr3?=
 =?us-ascii?Q?vwkDpBp5KYSXKR9TSjHAuLsSHr6wwk0zJUvtkKkX7HDm5MQMw/cz6fbIW7Xd?=
 =?us-ascii?Q?3Zf9qT+PAElS4xlg8M0+kfsNUf28FqYHr90O05h8xIGaL3tLpxQKLX2JvT/h?=
 =?us-ascii?Q?sKQgl35seeQ9Cn0WvYmXb90bKZKbmwvUVSfKXAyKKFKNYZxUjrzzLty34Qgy?=
 =?us-ascii?Q?q6UFbvNL7YaMvzh1hwsRqo/OVDuaVqhwl9kOkcbb522+Emfrc7nb2pGnmkEe?=
 =?us-ascii?Q?gdIAoS3cQSQC+KeoVdgzaD3Iw3sQlhKeopkXaGecvwypYk2vwBdgMkyPDQff?=
 =?us-ascii?Q?EswqNOee3rhrEGAc+BHnnu7kh9bwMfvnfHf+Kln/worYR1De+QpO8ydLvVZm?=
 =?us-ascii?Q?cLYaHy9N+BGnr+YsxsPIWDOJbmVGET294C9PByZvQhcFEYIdSN0iDMv2ZqXQ?=
 =?us-ascii?Q?pY6Kqil8DYwrecQxaFHnfNGVDEInq7qPhhIT6s0j9byq8yCJZY5VO0WIx/4d?=
 =?us-ascii?Q?80ZKhY6fR4Ub1x+50XrrpeGfzsSAFCUAP4InAuOFls1fVMnLuJzf+wDnJxGb?=
 =?us-ascii?Q?sz4YHQ1C48gZjRQ9pTUFtsPGOT2DUi1l3lakNm1cpXmVP6RqIROnwiyd+46P?=
 =?us-ascii?Q?OAseaUEEQMBxrdjGDBYK+Yy7Fdx4MG6mdKNAuS56fiiUvAqAlkjGrQNo+SxE?=
 =?us-ascii?Q?uTGH6yQLPzvsgiG7uyiSPkOA1tlDwM2N9o4jfUGL0oth2H1NGAxVfbTmW/3S?=
 =?us-ascii?Q?kCQh1H498sby1HvNA1QipnVEwM5qIGmemimhiLpp7/+NbAlOmGXhpEjgHcfO?=
 =?us-ascii?Q?JzXeOI/ECwN3YY1NpgTPtn88dpNp735KaAL9lkOP63JH+7qHUxsrAtzhlF3T?=
 =?us-ascii?Q?f3Vl38ps+rRrkMtLYyah64tTSuMIVKWIR0E0dWGDAB88Vasie5NfTHk2Mr44?=
 =?us-ascii?Q?P8/GJ6VCzFvwQ2k1IN16XczEosz+u5Yp71s+aAAiGZeXJrPnAbFja7E8iuHY?=
 =?us-ascii?Q?BuXNOp21F7mZZvD54xYxlYmDjNsTZiB/Y3qrmntHTA+TTcUbOUj4jtapB3Z6?=
 =?us-ascii?Q?EQqJOIeDOfd3TgpMFlCcwT/XycvmFhXKdQfLevr2EcNnNbRhuotftq+537/t?=
 =?us-ascii?Q?xd0YI/FnXozQWuMJnYNKhoAhRwhv2F5RZMac5GmRGgLb5A+UKorifw4rbIRb?=
 =?us-ascii?Q?OZEbUOoRa9yAxGGqmCcUxxa6g0YVG4aL/1WdFrbwqbXcwXffvDn8n8JZetQQ?=
 =?us-ascii?Q?VybzWk4+xHzVeZLEAE6Ljchbzpu7T1RtVG5vhWL6GE0K7agGWjg9l2TxpM4U?=
 =?us-ascii?Q?DxhobxHgGY/o2ayXQ8nNfpkp38fgLSOmy6/J?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:36.8969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab0b2fb-24af-41bc-b209-08ddab1342dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317

For vIOMMU passing through HW resources to user space (VMs), allowing a VM
to control the passed through HW directly by accessing hardware registers,
add an mmap infrastructure to map the physical MMIO pages to user space.

Maintain a maple tree per ictx as a translation table managing mmappable
regions, from an allocated for-user mmap offset to an iommufd_mmap struct,
where it stores the real PFN range for an io_remap_pfn_range call.

Keep track of the lifecycle of the mmappable region by taking refcount of
its owner, so as to enforce user space to unmap the region first before it
can destroy its owner object.

To allow an IOMMU driver to add and delete mmappable regions onto/from the
maple tree, add iommufd_viommu_alloc/destroy_mmap helpers.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 14 ++++++
 include/linux/iommufd.h                 | 42 ++++++++++++++++
 drivers/iommu/iommufd/driver.c          | 51 ++++++++++++++++++++
 drivers/iommu/iommufd/main.c            | 64 +++++++++++++++++++++++++
 4 files changed, 171 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 1bb1c0764bc2..e8192f79fe42 100644
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
+	/* Allocated start position in mt_mmap tree */
+	unsigned long startp;
+
+	/* Physical range for io_remap_pfn_range() */
+	unsigned long mmio_pfn;
+	unsigned long num_pfns;
+};
+
 /*
  * The IOVA to PFN map. The map automatically copies the PFNs into multiple
  * domains and permits sharing of PFNs between io_pagetable instances. This
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index acf0e8f0c630..0da9bc8f94f3 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -251,6 +251,11 @@ int _iommufd_object_depend(struct iommufd_object *obj_dependent,
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
@@ -271,6 +276,20 @@ _iommufd_object_undepend(struct iommufd_object *obj_dependent,
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
@@ -338,4 +357,27 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
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
index 70b7917da0cb..8220b61d8c8d 100644
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
+	immap->num_pfns = length >> PAGE_SHIFT;
+	immap->mmio_pfn = mmio_addr >> PAGE_SHIFT;
+
+	rc = mtree_alloc_range(&ictx->mt_mmap, &startp, immap, immap->num_pfns,
+			       0, U32_MAX >> PAGE_SHIFT, GFP_KERNEL);
+	if (rc < 0) {
+		kfree(immap);
+		return rc;
+	}
+
+	immap->startp = startp;
+	/* mmap() syscall will right-shift the offset in vma->vm_pgoff */
+	*offset = startp << PAGE_SHIFT;
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
index 4e8dbbfac890..339a269ebbc8 100644
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
@@ -479,11 +480,74 @@ static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
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
+	/* vma->vm_pgoff carries an index to an mtree entry (immap) */
+	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
+	if (!immap)
+		return -ENXIO;
+	/*
+	 * mtree_load() returns the immap for any contained pgoff, only allow
+	 * the immap thing to be mapped
+	 */
+	if (vma->vm_pgoff != immap->startp)
+		return -ENXIO;
+	if (length != immap->num_pfns << PAGE_SHIFT)
+		return -ENXIO;
+
+	vma->vm_pgoff = 0;
+	vma->vm_private_data = immap;
+	vma->vm_ops = &iommufd_vma_ops;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	rc = io_remap_pfn_range(vma, vma->vm_start, immap->mmio_pfn, length,
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


