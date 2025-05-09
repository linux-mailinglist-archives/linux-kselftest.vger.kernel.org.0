Return-Path: <linux-kselftest+bounces-32708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E743AAB084D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 195E77BE34A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE152459C8;
	Fri,  9 May 2025 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UXuKbgJE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA8C23AE95;
	Fri,  9 May 2025 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759823; cv=fail; b=Hr9GP4eIEvXCtTrB1gJ8904N89aSNbFhzhOs9e8Wkt+f4gMYmYxp+F+scFQLt0F5fHEhnh/QZVMuOxWu6BAgrUXuRX5oQbl1MInTIvWwGZI62MgwfsGMxN6RNcCQJvADqXCha9Z1u0TLmcBrQEU14mha1N+xwWg+Fb8xW/msBk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759823; c=relaxed/simple;
	bh=NySwh5T/ADz5G3BUd0Djtx8BMadP2YJnLWuf7scq7U0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnNMNY4F/gUHM5biThT+/nqL3quiaweyryY4vOAc1zSN+xxyxb5rxSB1nKlsDFn+a2fxf87cCKSvqUJNzZXT0LE4XDS1iOnM7WvynX0G6onq17YH0YesfohnXf/Glbn5g69QwgbEljDe/TtGvo+OloR+5McvzZgI4CRuqyJi34M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UXuKbgJE; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJyDhqwHdhdXbhqmSPnlNK8OIICZ3AyWBidCqY8Gw/ItDnox7kAod+Ro1QRYXv1/0Fp9BRpr8hohEDTJYPG+cIvHXYtstk0WI/yaxwyuagj72pEgWCLhkxy/+TeSvVeeb5LhwxH2wCeoOzGFLeHzGATpwiCs42YXHCFWyY7FRuRg/JZzWl6+aXouP2gVSFIGqxrY9vkkAbMYLPu4SYCr9bN4zWtP4eVUFnL3tIK5H+LiXy9PU3WG4+y0ji7arFxFaisppsqjBiSidy2vO4un4oYGSlZKY7DPQ9PVyxZzk5m7ek8qPBTeq0n7pp20cOXk+Q75mIWuH6ehd1XuqHxr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrzYijHPslaBsQWASjN0cv/ix8LMvYSahSMK+snF6Gs=;
 b=bNLW5HTabCZ/lMEGlLIsQNbaV8GmG71z50T3HwtnaTwagK+v60NefXzgVUDe9G3wog9Vgk11TVa+djyML/1GLvFYHMVSzlZJ/W917GgIOhbqmYggHxxrGEBt8YKhNTIH6xtqjBYka2qmaULxxe7eqkjpjebnBNtPI2esjclMfJpj+4rZ7I1zdrL3nyZiARPYuU0ynOiQByT+6B5jjayo8IgP9zQ1n9fHpm2S/5tQ6g0H5ptFN7SAkv7UcesB3Nk4q+9E1HeGmJ1E2xaHmaWBJXLt3XvYvQoVTfOy3x93QLO4iQ4fUKhAL5CFiOGX6EWc0SSWVjIaYkqvLfG+0/5eIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrzYijHPslaBsQWASjN0cv/ix8LMvYSahSMK+snF6Gs=;
 b=UXuKbgJE/QGcHGBpj4XtdRSlqdH0bOtmoOCg8C26AfOhW0nmkkHON9fktLWoLCfeCdRgkqv6lZfV9PuqKye8kt0VcPyF/6ZXgAo0rn+DLzkr46VzM/+OXVLuAjJYRLwR1Au7WXW8PDoZnZU1Qcaue0kupQ7b7ZvfDX0UWZf+cuWwTB/FxF1ryFcxCqEppBCu0HmTB+2w99gHrDKchyU+zpyeuPLNbv0kKeJ+eVHpTkA0SApsL6m5gjDupuiyBPvlfiB6h9bYXhkoV9czFb3uJHzoCq1AIlowlIDcoISfBKxIj5HFqYB85L6WavIhOhuU4QWFsEyJapbGZAzYlHBBnA==
Received: from SN7P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::6)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 03:03:34 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:123:cafe::35) by SN7P220CA0001.outlook.office365.com
 (2603:10b6:806:123::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Fri,
 9 May 2025 03:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:24 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:21 -0700
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
Subject: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl
Date: Thu, 8 May 2025 20:02:32 -0700
Message-ID: <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746757630.git.nicolinc@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|CY8PR12MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c83606-0cc6-4a99-07ec-08dd8ea615c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aUbcpsr1h/jM6WyjZ0EJhXryepvl22gE9CfXKL+Xt9Q5YkslNADXQJrpBqWg?=
 =?us-ascii?Q?7ckwmkWxlYvhn/MVlbuR0PdEL/Ms1xHA5Fkp5w7/g1YPzGp0RaCl/FJjf+oO?=
 =?us-ascii?Q?ontFJ1JVhg42v2a/tXAwBnhjmutLp6exWPHByMMjq1O747lusedwo/I9W2E5?=
 =?us-ascii?Q?KVpzol85ZPm7SKU1/lEuzXS8Ro+JW/jlffMCAiM02RP9sXCqm+1X5srvz9bx?=
 =?us-ascii?Q?2SoxjbKUbzrO/Jcq4t2doyjonRjkFqsBElSfTGE/MPJKEDK+YcwqXRYyXMj7?=
 =?us-ascii?Q?veh4sO7C83NyDHYX0D50lwvf0SPpy7aR7MJgGIW/0Si28NnLnUbTikR4e9gm?=
 =?us-ascii?Q?fBSwr9ae7JkXZWsNnV27aX9ffBxTXhXa69I/4khYF3RPKcSQt5pmxY16WA3B?=
 =?us-ascii?Q?y3yf1MvBhv937yACJLymIvtd1/l8KJ4qoR+RajcUt0ArEqD6I+UCIfamELJx?=
 =?us-ascii?Q?fqnJ5WUXkH+fE+7AfwXsMNhK+eslqTPJWsDTwr5TJvPG4F4cjr84qU3olwBr?=
 =?us-ascii?Q?MSU8tEDiWz6Q9diuNSaJX/HQpnR6/YBiRLNJ2zDSGfZvgto6O8tqh7FRKsiw?=
 =?us-ascii?Q?Bf683YIAjPmu/o5yKX2jSa1X65BKhcexU9OgHchZP4UiT7fhoR8/yKXf7gwk?=
 =?us-ascii?Q?F7bszgGAmBsluvY8LbcPICpjmClyRQlTTqXCm2lByFfhX3NA2nN+EucDDc9G?=
 =?us-ascii?Q?Zxm0EAsVOK5YYkzwINUqZJ9Dc8+duCYizq4ZaeqmfNefeVNYbW3iRHrkL5Kh?=
 =?us-ascii?Q?3/uywBIXvvwfdzOpvMBOkhb0QuixRXWREJREzSRp66dgqdlFXXSVCBHghBmy?=
 =?us-ascii?Q?4+AZY8IwDlwUO8oW5ZVbmAuQluumu6iLQm3ItIRP3EkBxUdz8AvoXCw7QD98?=
 =?us-ascii?Q?YARLwE96c82mhlyVs9mHnPamttDKLWbPYdV1eEpxbc3KntkrCuI/l7EQIyNQ?=
 =?us-ascii?Q?hR3wr5TpZYr/7WirlKVraf2io9mP2uuBBmSqthTvWAvXCJQVJMK6XP+PwYiY?=
 =?us-ascii?Q?62dznQj++xymkf2Mrd6qDUWyvbF++/UZaiPlXLSECFqAYBpZjj37VXdzGuCd?=
 =?us-ascii?Q?VTy8NILukFPo9BDhIH/1TqWhRjxKOSnN3ATg6Uw+lkX+S/vqPvxuJHYdlksc?=
 =?us-ascii?Q?560FppqOS/h4Yklp8oZRfzJFp9QT/dGKBJ3YPIWZS5wj7W7v2Vc5rp8tK0fG?=
 =?us-ascii?Q?HEW4tRt4lR//XpItzqdCYvo7nmqGic2BsrsRkYD0yXRueU79LYwxyqcGtmWX?=
 =?us-ascii?Q?yDrhSVZlbfKchcmUu1VIyz9rbP7gEcW5WYCQeVbg/C0hkw0zOG27UlFZ09UK?=
 =?us-ascii?Q?1cl5b/X2sH171UO3VdPJN4kFaowtyJeH/1bSlVsO3FYgMRyKDrxIatZBTbID?=
 =?us-ascii?Q?GlLxYz8TBGOM4EYtWiS2IVPRjjvOtOo71PwwklPiGfgkLvLu5yDo+84H2bhC?=
 =?us-ascii?Q?P3JJyxCLH5clAaft+YWN+YX5CEFKC+UHKcdrnLnICic2NRWzcVPR6RLjQxds?=
 =?us-ascii?Q?ezcGMkMquwRMmK2SE/j7vuU1z3wTeHjMobCL?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:33.5804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c83606-0cc6-4a99-07ec-08dd8ea615c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290

Introduce a new IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl for user space to allocate
a HW QUEUE object for a vIOMMU specific HW-accelerated queue, e.g.:
 - NVIDIA's Virtual Command Queue
 - AMD vIOMMU's Command Buffer, Event Log Buffer, and PPR Log Buffer

This is a vIOMMU based ioctl. Simply increase the refcount of the vIOMMU.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |   2 +
 include/uapi/linux/iommufd.h            |  42 ++++++++++
 drivers/iommu/iommufd/main.c            |   6 ++
 drivers/iommu/iommufd/viommu.c          | 104 ++++++++++++++++++++++++
 4 files changed, 154 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 79160b039bc7..36a4e060982f 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -611,6 +611,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
+int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_hw_queue_destroy(struct iommufd_object *obj);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index cc90299a08d9..001e2deb5a2d 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -56,6 +56,7 @@ enum {
 	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
+	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
 };
 
 /**
@@ -1147,4 +1148,45 @@ struct iommu_veventq_alloc {
 	__u32 __reserved;
 };
 #define IOMMU_VEVENTQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VEVENTQ_ALLOC)
+
+/**
+ * enum iommu_hw_queue_type - HW Queue Type
+ * @IOMMU_HW_QUEUE_TYPE_DEFAULT: Reserved for future use
+ */
+enum iommu_hw_queue_type {
+	IOMMU_HW_QUEUE_TYPE_DEFAULT = 0,
+};
+
+/**
+ * struct iommu_hw_queue_alloc - ioctl(IOMMU_HW_QUEUE_ALLOC)
+ * @size: sizeof(struct iommu_hw_queue_alloc)
+ * @flags: Must be 0
+ * @viommu_id: Virtual IOMMU ID to associate the HW queue with
+ * @type: One of enum iommu_hw_queue_type
+ * @index: The logical index to the HW queue per virtual IOMMU for a multi-queue
+ *         model
+ * @out_hw_queue_id: The ID of the new HW queue
+ * @base_addr: Base address of the queue memory in guest physical address space
+ * @length: Length of the queue memory in the guest physical address space
+ *
+ * Allocate a HW queue object for a vIOMMU-specific HW-accelerated queue, which
+ * allows HW to access a guest queue memory described by @base_addr and @length.
+ * Upon success, the underlying physical pages of the guest queue memory will be
+ * pinned to prevent VMM from unmapping them in the IOAS until the HW queue gets
+ * destroyed.
+ *
+ * A vIOMMU can allocate multiple queues, but it must use a different @index to
+ * separate each allocation, e.g. HW queue0, HW queue1, ...
+ */
+struct iommu_hw_queue_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 viommu_id;
+	__u32 type;
+	__u32 index;
+	__u32 out_hw_queue_id;
+	__aligned_u64 base_addr;
+	__aligned_u64 length;
+};
+#define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 2b9ee9b4a424..10410e2f710a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -292,6 +292,7 @@ union ucmd_buffer {
 	struct iommu_destroy destroy;
 	struct iommu_fault_alloc fault;
 	struct iommu_hw_info info;
+	struct iommu_hw_queue_alloc hw_queue;
 	struct iommu_hwpt_alloc hwpt;
 	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
 	struct iommu_hwpt_invalidate cache;
@@ -334,6 +335,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 struct iommu_fault_alloc, out_fault_fd),
 	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
 		 __reserved),
+	IOCTL_OP(IOMMU_HW_QUEUE_ALLOC, iommufd_hw_queue_alloc_ioctl,
+		 struct iommu_hw_queue_alloc, length),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_GET_DIRTY_BITMAP, iommufd_hwpt_get_dirty_bitmap,
@@ -490,6 +493,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_FAULT] = {
 		.destroy = iommufd_fault_destroy,
 	},
+	[IOMMUFD_OBJ_HW_QUEUE] = {
+		.destroy = iommufd_hw_queue_destroy,
+	},
 	[IOMMUFD_OBJ_HWPT_PAGING] = {
 		.destroy = iommufd_hwpt_paging_destroy,
 		.abort = iommufd_hwpt_paging_abort,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index a65153458a26..ef41aec0b5bf 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -170,3 +170,107 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
 }
+
+void iommufd_hw_queue_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_hw_queue *hw_queue =
+		container_of(obj, struct iommufd_hw_queue, obj);
+	struct iommufd_viommu *viommu = hw_queue->viommu;
+
+	if (viommu->ops->hw_queue_destroy)
+		viommu->ops->hw_queue_destroy(hw_queue);
+	iopt_unpin_pages(&viommu->hwpt->ioas->iopt, hw_queue->base_addr,
+			 hw_queue->length);
+	refcount_dec(&viommu->obj.users);
+}
+
+int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hw_queue_alloc *cmd = ucmd->cmd;
+	struct iommufd_hw_queue *hw_queue;
+	struct iommufd_hwpt_paging *hwpt;
+	struct iommufd_viommu *viommu;
+	struct page **pages;
+	int max_npages, i;
+	u64 end;
+	int rc;
+
+	if (cmd->flags || cmd->type == IOMMU_HW_QUEUE_TYPE_DEFAULT)
+		return -EOPNOTSUPP;
+	if (!cmd->base_addr || !cmd->length)
+		return -EINVAL;
+	if (check_add_overflow(cmd->base_addr, cmd->length - 1, &end))
+		return -EOVERFLOW;
+
+	max_npages = DIV_ROUND_UP(cmd->length, PAGE_SIZE);
+	pages = kcalloc(max_npages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu)) {
+		rc = PTR_ERR(viommu);
+		goto out_free;
+	}
+	hwpt = viommu->hwpt;
+
+	if (!viommu->ops || !viommu->ops->hw_queue_alloc) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
+	/* Quick test on the base address */
+	if (!iommu_iova_to_phys(hwpt->common.domain, cmd->base_addr)) {
+		rc = -ENXIO;
+		goto out_put_viommu;
+	}
+
+	/*
+	 * The underlying physical pages must be pinned to prevent them from
+	 * being unmapped (via IOMMUFD_CMD_IOAS_UNMAP) during the life cycle
+	 * of the HW QUEUE object.
+	 */
+	rc = iopt_pin_pages(&hwpt->ioas->iopt, cmd->base_addr, cmd->length,
+			    pages, 0);
+	if (rc)
+		goto out_put_viommu;
+
+	if (viommu->ops->flags & IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA) {
+		/* Validate if the underlying physical pages are contiguous */
+		for (i = 1; i < max_npages && pages[i]; i++) {
+			if (page_to_pfn(pages[i]) ==
+			    page_to_pfn(pages[i - 1]) + 1)
+				continue;
+			rc = -EFAULT;
+			goto out_unpin;
+		}
+	}
+
+	hw_queue = viommu->ops->hw_queue_alloc(viommu, cmd->type, cmd->index,
+					       cmd->base_addr, cmd->length);
+	if (IS_ERR(hw_queue)) {
+		rc = PTR_ERR(hw_queue);
+		goto out_unpin;
+	}
+
+	hw_queue->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+	hw_queue->ictx = ucmd->ictx;
+	hw_queue->length = cmd->length;
+	hw_queue->base_addr = cmd->base_addr;
+	cmd->out_hw_queue_id = hw_queue->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		iommufd_object_abort_and_destroy(ucmd->ictx, &hw_queue->obj);
+	else
+		iommufd_object_finalize(ucmd->ictx, &hw_queue->obj);
+	goto out_put_viommu;
+
+out_unpin:
+	iopt_unpin_pages(&hwpt->ioas->iopt, cmd->base_addr, cmd->length);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+out_free:
+	kfree(pages);
+	return rc;
+}
-- 
2.43.0


