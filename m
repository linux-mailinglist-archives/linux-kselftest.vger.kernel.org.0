Return-Path: <linux-kselftest+bounces-30509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A33D3A85448
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92EC619E62EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 06:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CC427F4F0;
	Fri, 11 Apr 2025 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eefr5Rma"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016A127F4DE;
	Fri, 11 Apr 2025 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353520; cv=fail; b=tdLWSjgzGM4Dy7cIf4r8SqXZw0gXQ+DdsqqNNpQwzvSFDPEmBAnvMtJDjt2dItgVcw0aBhDJP3YHR1jqu3tEWcQLbu1vZ0XpfGOfbX3o/LVzCtzQT5jIZJIUkRX/gnm3N9uoe9ybx11dFV0AYLDDRUjnPzfXxHxw7niG3taTW+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353520; c=relaxed/simple;
	bh=ieBZ4Y4IAR9ZDI41GNv6SZB5JjPSp1HOG/W4coBE/ks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgLTdRTP4HuU1jxn8cUaBfv01rKdIhrEsS4rEhzeouZptw/76ShKIcGKoayg+njAaZ1vBSklJh98oUj8DfFk/jEVZd4Nj3Sq3Bbjrk3HTgkBvXNairjAVJKqXCl7CycpmxbGfYzF1A7CRDtixPwpVFIDoCGHfVf630zR783ylvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eefr5Rma; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXIR9MGACSEjLHTILBXFo2QxluaWvEZqdWRXccFmM1h6g/jLyIJ8cRKYxynEI7JP0DrFJAY2qDlZcD2jZuE9Y71+D/0oAwr23pbCNqnh3Dc/yPL9v5efM7aybwt7+0jvRL0w4JW3TRfvbFN6hAcuVSvbOYwJEfIlv95afAJIHVFz2EInJulgluJR4dYhC0p0xLe8wRr8HddKkvPDDG0kl3xB7PL3cwWeJgRjurIGD8P994AmV3ymbH6GdLZyFSB9kGKrqBB8P5wyqMGH47+UbHxrq0yGPI8u237os/XB/KN6McMlPvKjuXk0LmVzU+6z5sZMCioNxPbwZ1WwuaQyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpWuHYUCFh63JX4JU3CbKfP+qbz8EPDO3osmJauhaNM=;
 b=BslGrh0GRkgSw7QB+fFg1+AogCU7bu7EF9x/8WzWRy/eYTmTUzYyvbflQCoKI8Q3UdWxtQ1mlzX28CNIT5SVt3zXi7FF2rSIwlCWNDTMjnRdfL62a6+btBs60wRlUaVdpHFzkNgNx8ljTKClEFSc6c8ESpApTnCTf8Yd1xM/y4VYPdUs5htMgh+CbFo92utt0n4t1uVBdq/GE9xFNkwlwE4UpggxZxVjZy7K63Rl1HxAP42cr2wDmcyRNlyRKVu5IqPELlRfnYyZX/O/Wq4kY35O+YkNdBfkHGgzgmsXL0HVvK1WOeaHNWU2IIeypNyqHau3+aEKXyPoapNtvm0/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpWuHYUCFh63JX4JU3CbKfP+qbz8EPDO3osmJauhaNM=;
 b=eefr5RmaXvb002nLPIqZr6dVPxOVJK0qD26SY2CBcMYtVmVM1L0WMDa8iE9WUdosFZ3s/JAqgOrHmRLNc/YfZ8m/tyP2+smplRwCJgHtwV+lR023Rfnv0Y8TGS3mc33LcrsC3RVUKfjQOJii4hKReU+7JUnRrqfqjB/aLf8FeFXa8p2jLcgSJ8Rz6LDfV1omMJpCv0GpYcnyNsHdoj3IVdZLe9BbLK7JewepItonjHK44572nSa4m/71mHXxXaY5JqMfRTrUFMvGBGZvS9HkIeTCA+Sl++kJNgMM+pGb0G/I04SeObh8w1iZyMMYTkR2xN7KgaA6gcqcypI8psjimA==
Received: from PH5P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::7)
 by IA1PR12MB8465.namprd12.prod.outlook.com (2603:10b6:208:457::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 06:38:34 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:34b:cafe::c5) by PH5P222CA0004.outlook.office365.com
 (2603:10b6:510:34b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 06:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 06:38:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 23:38:19 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 23:38:18 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 23:38:17 -0700
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
Subject: [PATCH v1 07/16] iommufd/viommu: Add driver-allocated vDEVICE support
Date: Thu, 10 Apr 2025 23:37:46 -0700
Message-ID: <349fa2c4c291488bb5bae6e4a8bc0dcbd0c51fd4.1744353300.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|IA1PR12MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f51a681-7ad6-4313-4f78-08dd78c37b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sKEIAfeq5zdN3mxppL3L17PuanyJ+WzpyNkb/TeFEwwYcLvvBn7EqSLG/Yho?=
 =?us-ascii?Q?ThLWtFIT8Mr468//5seYP2ZLEhwsG9EbDmzhR/o72Hi+bin0zJckalEUVYP9?=
 =?us-ascii?Q?Ee8I87PKlewOS/Xs0RMmQcyp71CCqo51ggF/8EpUFB1EncQhYg7J81JJ8Qmp?=
 =?us-ascii?Q?dOZ8Zb4ipirDhOPfJUtrdeO0ZzrQye7wOY8JsMVEnHsui8pwGTIYA3UbtMfT?=
 =?us-ascii?Q?mcpCAWwjL3oZDOR6MTZQ4cBvz0BEY8p8w01L2naHxVb0cAyj4HTAiq5pPeat?=
 =?us-ascii?Q?otroq8fGKTA5J6YcaXSVkI3dnsrgjdLukdxXr/h+U/wPzqI/wGNKiRcpVdA+?=
 =?us-ascii?Q?eT7/OYgMQaNSoJUqPdOudkYdQBREgPnWkwYPwd3bdb+1atkR5uuVyBDFQ0zd?=
 =?us-ascii?Q?qfK2H6/tcnsTH1x+bfg8LNQdv6Xiy6zEqvjitBsBmsekqI9XHxUDej8lT2Q0?=
 =?us-ascii?Q?dOb5rkA9EvRHBOs0kXRnUk1kpoU+p6H3ET1xHmsweHnAAsn5VLu68xNnt/wy?=
 =?us-ascii?Q?JwAhBJlVDC0agkngHRdOoAUghL3FMy8mUQv13YN6+9D7HlSZoWN2PjIoUxU5?=
 =?us-ascii?Q?6s5iv7xHvKrvjMrXSVjsZaDpiSVaRB9TN1caW4+HzdbGGMzP0MdAZE0+mu5d?=
 =?us-ascii?Q?SZ3F6/iN6UQN/rr6gMIWPup2EAIvGh889X2zZlDZS7OR/yuzVoBTePTJ7Op3?=
 =?us-ascii?Q?D57vn6y1Dg/rGIn85uPomFSb0uoUgMhcgL+ee4op8HpdHYEOK+kPiTFV6/0f?=
 =?us-ascii?Q?2qUN2Bu6g94lKUbYQ/GQCrBTt41hkfo5oHZRwZ/KBL8daP37uVCf+CC1StLm?=
 =?us-ascii?Q?AxLvrP2C3vZkk/N40DyNrbLWwHpl0OJJVWZU86QK+ACDeFeJ0GWxmKJ6WcxJ?=
 =?us-ascii?Q?o1AzPW8J7Ev1gPm3KobGSbx2nVUKWu6BtX7zijzLtFPZlK+ybMmtT2MgJtU/?=
 =?us-ascii?Q?Z3S6UzlC+0ArJHGhfg0BqYlrnev190I8kAwvm+jibCy5tLcLVOe6ADrXi66a?=
 =?us-ascii?Q?bgZ2VjU111C3WhQdLyOuUY8U+g7p0jRbhmYOvPyM+hgWzt9RASY1ep2IZ+Hq?=
 =?us-ascii?Q?VP/KnHG7d2MeOQFFhivV4ZnCp6K3CHuzGc/n6o9DEMd72CPlsR8KgXKyIg0D?=
 =?us-ascii?Q?5BK5KcvkLZtqDSOPhrf8zQIlQo28SPuhD0S7sKMxfjEtT8SuRAeEn4NheK+3?=
 =?us-ascii?Q?pOs1nEOvXMU2E8U1R3lTpFv0r7GV2zLARJfr6SST+smO8NBy7lq/CVSuIfeu?=
 =?us-ascii?Q?tGZZ9rFn8rBdpNsQ3x2Z1RfgAV57m4LN8CEr+MerCP+K0oTwoPo4qJMMUZIl?=
 =?us-ascii?Q?gVEYTsuxG4JkLgivCTH7vneLOZHKV/9g4cerlk50h6vGXscmYBsbPsqCnFsd?=
 =?us-ascii?Q?Ta2hJVEXMQfg+KYvnN/taAPbq7UHfsfx6Vwplcqf4T7wLH/bUxVKy93exKAl?=
 =?us-ascii?Q?b5m3C+x0ADmusKgqt6j02n3yWnqrVQGfYD0Ofpf1GHto/qerla+xRR3DgtCK?=
 =?us-ascii?Q?m7h7cX0aSlMRbxEquhceenTKg86y+0nccTnU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:38:33.3366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f51a681-7ad6-4313-4f78-08dd78c37b0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8465

To allow IOMMU drivers to allocate own vDEVICE structures, move the struct
iommufd_vdevice to the public header and provide a pair of viommu ops.

The iommufd_vdevice_alloc_ioctl will prioritize the callback function from
the viommu ops, i.e. a driver-allocated vDEVICE.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  8 -------
 include/linux/iommufd.h                 | 32 +++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu.c          |  9 ++++++-
 3 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 51f1b3938023..8d96aa514033 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -606,14 +606,6 @@ void iommufd_viommu_destroy(struct iommufd_object *obj);
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
index 999498ddab75..df7a25117e3b 100644
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
@@ -120,6 +128,12 @@ struct iommufd_viommu {
  *                    array->entry_num to report the number of handled requests.
  *                    The data structure of the array entry must be defined in
  *                    include/uapi/linux/iommufd.h
+ * @vdevice_alloc: Allocate a vDEVICE object and init its driver-level structure
+ *                 or HW procedure. Note that the core-level structure is filled
+ *                 by the iommufd core after calling this op
+ * @vdevice_destroy: Clean up all driver-specific parts of an iommufd_vdevice. The
+ *                   memory of the vDEVICE will be free-ed by iommufd core after
+ *                   calling this op
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
@@ -128,6 +142,9 @@ struct iommufd_viommu_ops {
 		const struct iommu_user_data *user_data);
 	int (*cache_invalidate)(struct iommufd_viommu *viommu,
 				struct iommu_user_data_array *array);
+	struct iommufd_vdevice *(*vdevice_alloc)(struct iommufd_viommu *viommu,
+						 struct device *dev, u64 id);
+	void (*vdevice_destroy)(struct iommufd_vdevice *vdev);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -252,6 +269,21 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		ret;                                                           \
 	})
 
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
+
 /* Helper for IOMMU driver to destroy structures created by allocators above */
 #define iommufd_struct_destroy(ictx, drv_struct, member)                       \
 	({                                                                     \
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 3d4d325adeaa..a65153458a26 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -96,6 +96,9 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
 
+	if (viommu->ops && viommu->ops->vdevice_destroy)
+		viommu->ops->vdevice_destroy(vdev);
+
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
@@ -130,7 +133,11 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
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


