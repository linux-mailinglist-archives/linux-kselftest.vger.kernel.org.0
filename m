Return-Path: <linux-kselftest+bounces-32712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FC8AB0857
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A186F9E3908
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4DC247291;
	Fri,  9 May 2025 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LV5dZ+LY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607CB24634F;
	Fri,  9 May 2025 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759826; cv=fail; b=kMinD1xlUUh9Ce87mxHlUmgW4Iyb9/cB9Gm5Tjf/WaNYIC5zTHnazJB7jOTTOY+gT2dxx2P0HeSuqccPBXRS0ZkK3VzMtGH6+vZ21uvxUxSJPEqxdRZ8LhShgXUvvfw3rx25OuCtGioJ80SEEvRtDEAN1vLgkNmqpyYhCe9g2Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759826; c=relaxed/simple;
	bh=d01tFx4oS5s/oC1OjIcDilJ0kBNmKqZ/rNgiPlPuO08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meaXFBbRmFAVY8yKPjxGIEp4Eos7wz6xl52s9EJigw3LqLXAKvZ1Ou20ECRq2sn+puze+hFCvu7P0zE8xpq8+vv8qUxwIxChp5QgM8hcjiCiRWyiVOHHz2uQ3rNmgv6fZVfrwn7m54jYRT4375d95/RBY/mBdaYykz32lkRx/QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LV5dZ+LY; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XF0yCXYF5hBK4mPX+JgK1JIs84VntxVB8sP4sufjGIaOoUGl1MTHJ2CmUSnK31zJI5SiTuB67ruXQO5kMFtkPnnzQ8BvOfeyI83sEsGzAmnDuSSxP8fEo72FocvMa29HMI4T5al4UQ1Z5mzuTmK0ZLqA05Y40rgPE530lF2TSkXJ2afPcuhCAFPebcJII4CdMlnpZ3J81ZANDGzOeFMfwZSM2LC0Jh4gkIsnOxei7OkFQmpVUabjtHKOmG91kX/xqAZAEdbf3D/KiqDcaxcQiWd4p6dKhit9XGeVnhJ9W3Gq7wMRElkZrzHyyOoOYMgHX4OoRnTdzGYqrkQ0DmNbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg77chMdIo55vjB/RY+6R/7hjNB0NiMcE5/bCd+24mY=;
 b=OU8BmeqSeEmOfDUitorUJtYbGNao+ReL9gIGijeqUF1KqCs0b9dfGpVAqH1nLSpCLQf4tcSyDO0Cox7kxWryr2BOxmSZRmIC9Dl2QvlgwGJ/HM/UHWl1u/uiSCHFoG2/Qo/CZGmzIOTyDZfl8kim8Hf1AlrzV93HUJHXWbUxLLUKjfnxfnX6WUo0T5tGXTV+vSHF44SaqDv9FSOkXIH30GdoDBvFKsJd+BK8qLp9Ic67VxBsz4wLtEb7r/wRrcB4FX++xXC5h3iR70FpStUdIs6AH0lNjMmDLMxQ0pUVKGfIcCoe61/lbmjqlQ+kwjTpugKGXMemn57JalR/iLb3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg77chMdIo55vjB/RY+6R/7hjNB0NiMcE5/bCd+24mY=;
 b=LV5dZ+LY9dv0jXcrIIoKHlfriu49i5f+H38lmME2fjjSw1dOgqaqqJwdeanmjtqIfZfxDW6T9INTp/VxmyXof++uyHnKX0QJYKMF0yJWkG0c5xeezWe4Boh2uZZ05jryVC0nA6Lsp0hwi3FqJQqCqIx8iT1gWPeiijK7kPfzNujkkR9L0KpArtdiFiq8uG/FkZ4l7uFwOLR13GaTxqZJwQE7PP6C+WNYbecL4OOx2vZcVHOfkGrSpGGlnl+IR6/eqwxFKP1ZMDNdryXeHIQBfXbE3R2wtOSJ/tAZOpun63PHnK3+Kq3XwYRyXxWsWYie/I7Oa4keqAi4ZxYaDgyumA==
Received: from SJ0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:a03:39f::13)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 9 May
 2025 03:03:35 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::42) by SJ0PR03CA0218.outlook.office365.com
 (2603:10b6:a03:39f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Fri,
 9 May 2025 03:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:26 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:25 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:24 -0700
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
Subject: [PATCH v4 12/23] iommufd/driver: Add iommufd_hw_queue_depend/undepend() helpers
Date: Thu, 8 May 2025 20:02:33 -0700
Message-ID: <3ee7d54d5368ac59822da214000fb25273de0508.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: ab128791-f6a8-409a-e9df-08dd8ea6168c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tA/YvznPxxlgXan8adQ7snk981eXvzg1AnFFgiUJsGRfKPPeJq+JSyaWBRK9?=
 =?us-ascii?Q?IEMALZpimaaREF/CEO+1I+vurexe9Ny/u9r/enHpDEj2sJlfRBsT8VeFSe2l?=
 =?us-ascii?Q?fomkqS2oQ/G4CJB/h5K5vtCGGjNRl9wQYKPjoAUGJs9SFe/1Z2SvgimTNHTy?=
 =?us-ascii?Q?03GXspBQU7DYf7kChiRLKy4X2QuiQNwaoluZXAeo2+D6ZKCzHe0CtFEjzwbU?=
 =?us-ascii?Q?lTMzX1NxzGXTUuTqrdzFthRVot1VhhJPu8pfwSifnAlwjxzyI2Jxb+ioZWnK?=
 =?us-ascii?Q?MGmtPXChz38OoL3Khd587NvmnEgFPOcluYAxIFL/lToypr8Ow6lG6yrsLaWQ?=
 =?us-ascii?Q?/z9w/Jyjd8LVTQRzaWLSjCTzfEJd6HphlyRkCBQ+GPHZ/PyXnyWWXFlaCKB/?=
 =?us-ascii?Q?UdKg7IQPrmGRnzhA0BQBtphrXudGno0OsL5xQivrj3XUzGx2d4cB9lZtXBa6?=
 =?us-ascii?Q?n440KTzO+EE0fC3e8Bwuc+3V5VK/IT2vhVc832DSKJGWmYIar5onHwbCFcpe?=
 =?us-ascii?Q?fLgYB3Mw7tz8MH1J7iAZCneFtmyk+fyAQhnFGtJrL3rfvcXMd95EiLbAWROJ?=
 =?us-ascii?Q?3b9grENleiCfQvTXd5IZzUpyy7T71hxxgYh2c6Yb8Uu43twzMSFur5PLM86b?=
 =?us-ascii?Q?AoFxdkBH1/fR1rVR9mA7F4AV6BE3uM5AhnNH+cYzosoiwNa5VozWU9CahuHy?=
 =?us-ascii?Q?GI0fk0MiKmGW+kbSaafNwqRaSikdtP0Wo6YecIjz4WKXYGrfXMfqpJZoPKkw?=
 =?us-ascii?Q?26eUfX3l9vzmJvjLC4nsv+HHiKiCM+cYVd5enBp4o9uPpPTvVr8p1yPOYA/7?=
 =?us-ascii?Q?3qO64Mw6HVzOMGDQeycfTcqbbKRoc4D4uTNc78r4eD8QFocXKXohGbOPS8F4?=
 =?us-ascii?Q?XBL84JbjHi+OnUKyTKOXAozm/wyB7ZU2yrb/v5YKAKWYQ3UyiJ11RrEwEt0s?=
 =?us-ascii?Q?fwmjf/vRm9tC/KwTCjXjLIy+LrDKDPqzzvUmaKgTFaEdN3ri3+c7QPN6xqwz?=
 =?us-ascii?Q?dcBnIpGKyctgdJgeuv7QBZe3MrwtFd7LmknBVZDW1uK/lnF4ulwyEo2catIG?=
 =?us-ascii?Q?F1K8BhgUv1IpP+vf9y6D19088+QwNPdDYvn5F01pVwLJoUcwp90v78UCHIHP?=
 =?us-ascii?Q?LJPapfGcCKwc3Fkk9M5/aOGcN3O5MZrHEYf3GpWR3RJpbq0jhzkhOG7cQK4R?=
 =?us-ascii?Q?6AQbb704/KO+uTfs0RveUCCARfutk/dXNVAXNOALwmFoc+d2a18JurnpfTsX?=
 =?us-ascii?Q?hxYMHbugKNF8LIvto2xlpbRmuokKazUU+LAf3ixmfgChktOmpeJjjeyYUxdt?=
 =?us-ascii?Q?v6Q6D4KhjeUvrBbZf28DaVNzsw0KSbnDSkg0Q1gGaibC4dv2Jdiub81poXLg?=
 =?us-ascii?Q?S5Vys2KBgQNeNd66Y479BbK/mQDAI0UkpyLs06zvuY0F/w9ZzZBSMVolOn1p?=
 =?us-ascii?Q?kPnVhkt0fSBYG31ZAbUEcfueZIU38NTUfPunUIL+KdLMQ5BUXeZhecDnriB4?=
 =?us-ascii?Q?bzj7i05JNIioGBzabU48nRzIMFF1WjqVAJ2L?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:34.9764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab128791-f6a8-409a-e9df-08dd8ea6168c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175

NVIDIA Virtual Command Queue is one of the iommufd users exposing vIOMMU
features to user space VMs. Its hardware has a strict rule when mapping
and unmapping multiple global CMDQVs to/from a VM-owned VINTF, requiring
mappings in ascending order and unmappings in descending order.

The tegra241-cmdqv driver can apply the rule for a mapping in the LVCMDQ
allocation handler. However, it can't do the same for an unmapping since
user space could start random destroy calls breaking the rule, while the
destroy op in the driver level can't reject a destroy call as it returns
void.

Add iommufd_hw_queue_depend/undepend for-driver helpers, allowing LVCMDQ
allocator to refcount_inc() a sibling LVCMDQ object and LVCMDQ destroyer
to refcount_dec(), so that iommufd core will help block a random destroy
call that breaks the rule.

This is a bit of compromise, because a driver might end up with abusing
the API that deadlocks the objects. So restrict the API to a dependency
between two driver-allocated objects of the same type, as iommufd would
unlikely build any core-level dependency in this case. And encourage to
use the macro version that currently supports the HW QUEUE objects only.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        | 44 ++++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/driver.c | 28 ++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 0b5bea7286b8..ddca0d2835df 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -241,6 +241,10 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type);
 void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
+int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+			   struct iommufd_object *obj_depended);
+void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
+			      struct iommufd_object *obj_depended);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -261,6 +265,18 @@ static inline void iommufd_object_abort(struct iommufd_ctx *ictx,
 {
 }
 
+static inline int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+					 struct iommufd_object *obj_depended)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void
+_iommufd_object_undepend(struct iommufd_object *obj_dependent,
+			 struct iommufd_object *obj_depended)
+{
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
@@ -346,4 +362,32 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		iommufd_object_abort(drv_struct->member.ictx,                  \
 				     &drv_struct->member.obj);                 \
 	})
+
+/*
+ * Helpers for IOMMU driver to build/destroy a dependency between two sibling
+ * structures created by one of the allocators above
+ */
+#define iommufd_hw_queue_depend(dependent, depended, member)                   \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_hw_queue,             \
+					  dependent->member));                 \
+		static_assert(offsetof(typeof(*dependent), member.obj) == 0);  \
+		static_assert(__same_type(struct iommufd_hw_queue,             \
+					  depended->member));                  \
+		static_assert(offsetof(typeof(*depended), member.obj) == 0);   \
+		_iommufd_object_depend(&dependent->member.obj,                 \
+				       &depended->member.obj);                 \
+	})
+
+#define iommufd_hw_queue_undepend(dependent, depended, member)                 \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_hw_queue,             \
+					  dependent->member));                 \
+		static_assert(offsetof(typeof(*dependent), member.obj) == 0);  \
+		static_assert(__same_type(struct iommufd_hw_queue,             \
+					  depended->member));                  \
+		static_assert(offsetof(typeof(*depended), member.obj) == 0);   \
+		_iommufd_object_undepend(&dependent->member.obj,               \
+					 &depended->member.obj);               \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 7980a09761c2..0bcf0438d255 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -50,6 +50,34 @@ void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_object_abort, "IOMMUFD");
 
+/* Driver should use a per-structure helper in include/linux/iommufd.h */
+int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+			   struct iommufd_object *obj_depended)
+{
+	/* Reject self dependency that dead locks */
+	if (obj_dependent == obj_depended)
+		return -EINVAL;
+	/* Only support dependency between two objects of the same type */
+	if (obj_dependent->type != obj_depended->type)
+		return -EINVAL;
+
+	refcount_inc(&obj_depended->users);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_object_depend, "IOMMUFD");
+
+/* Driver should use a per-structure helper in include/linux/iommufd.h */
+void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
+			      struct iommufd_object *obj_depended)
+{
+	if (WARN_ON_ONCE(obj_dependent == obj_depended ||
+			 obj_dependent->type != obj_depended->type))
+		return;
+
+	refcount_dec(&obj_depended->users);
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_object_undepend, "IOMMUFD");
+
 /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id)
-- 
2.43.0


