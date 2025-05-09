Return-Path: <linux-kselftest+bounces-32699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC28AB0827
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2EF1BA2A3F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3777238C29;
	Fri,  9 May 2025 03:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IExDjvDp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0923C23373D;
	Fri,  9 May 2025 03:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759798; cv=fail; b=kBu53kYfsx27brUC/rZWeO8aBts6vM/ST3bY4dBpPq4yy0z2eHMIi5x8bc/rgUhKz/45UeYS+GBR/U+1ixHVRVOEMnYiLbgBCNkVzBfsL+xnKuJVWyaDMK7/f92/Ro43vZzeuSGaQ105Z1x544Q8jdpHypx2gqf50G6niad29rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759798; c=relaxed/simple;
	bh=FznnIvHR/NCSVSd2l31WKODQu4YmPmFERUkUUf+uaQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iav5shumLkA4PxjpP92HzG/odsG3hyvmtnAQZ9aVOutY/gH67wrO2ZXm3Zjs8gIuzIk/Ugog6db7fUksHzQbVNSns8eWGfDRPgPeD3Liw7tKkoGXCJAqQmICTZQVLKPZkmrUe+eitIZa/4SSx3OMbG8Ri7yGJloYrczIJIINfmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IExDjvDp; arc=fail smtp.client-ip=40.107.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhS5nivM87/oqFze5qRE0nBIFK+RiWj0c4ojNE5JFJtx7OxMW6SwGStHYZGzfGJLX7opsqXZVTscILLPMXGnMNz7m2f8u/ws3CWkCciIfKIlq3IGGf0gzLLn+KGCkPRVArMGc4gSpzyWzzMk6Nv/W1S7wy9iVMw/cekLmIndGD8TjsgmAZbXc18OGgyRd+BL3R+aPX2ANBv566a9LwMwbZZceUfDLRygMCzOVT0K+vrDKYntXoou05haNjcVYO6rG2gT/b3lC7FKLB7MLW6+xdukUagFCZ/NZUc3PLPs3JdNSjFyylazPuv8Vw45SDh8XkF79a7ix6UWed7TUYvckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6APJmLaezdJ+/awjyB2MB1TMj3/uXeB438YQ0yzJAs=;
 b=JQvgRuh6vVgRp5thYJbdW9iLwfTBSwJ+nyZkSvotBIzh3vIxA6oxuH4jDZrNjIBSgewFzoLtzJBNQlH0nchGCsWhc86Leg/nNyNSozrn1kCHC6WJ6m9VQhxEfah0qm1T5PfJ9je47agxKrPsviGpMn7OFFLqjh6xtABHGROLPeb7d7RwiNDXv9Op/QOxA8EIghllCQ02veR7dqOLWek+hIcQgdxA87Vj5Bq7LIlig4giwMGA53sS6Vw/GJf1qTGq14ESvo04ESG/nBHUq/4LgCCsTyDNpKb5tfoN4BVW88414vkx6/5cqRt6AH+3qOqs7zsX0YT6HxZ29C/ZQJiOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6APJmLaezdJ+/awjyB2MB1TMj3/uXeB438YQ0yzJAs=;
 b=IExDjvDpfs54/FUZ6A7C1872WppBO8HOV+11IFmqgnG6z9GgLZvF1MNSfuJMoElBSo2jiF1XczUTYzUt8TI+dBHSq45erDv7jRO0icMaeZnB2Olk+79FQjIDt03BRyfFYDt/1x5T9Lpi1D5R3GHKqcljKlTxTQMSlx7cIAKpjRULowWnn8HVwEfKdcYeLFjqcMluQAF5tZxDobttz0JJzD7Ty76xUYpgXrYB1WHn7oqhE+/RMjcdH5iKwKUUCpK/+6RF84934waVe33+AZ8R/6ZfOtWmzBuqaieRhI8P5dnzJv6knQt2rPjijXj/MOfCydzN75Ief7rIfqgfPSL4pA==
Received: from MW2PR2101CA0003.namprd21.prod.outlook.com (2603:10b6:302:1::16)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 03:03:08 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::b8) by MW2PR2101CA0003.outlook.office365.com
 (2603:10b6:302:1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.5 via Frontend Transport; Fri, 9
 May 2025 03:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:00 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:02:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:02:57 -0700
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
Subject: [PATCH v4 01/23] iommufd/viommu: Add driver-allocated vDEVICE support
Date: Thu, 8 May 2025 20:02:22 -0700
Message-ID: <cceddd59f04599e120e4620ed001f5d16fb66ce1.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 20080d63-c3c1-4bda-2cef-08dd8ea6067d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qBpP/CzUKW7xoiq9GWdHVBVsNPWQWP1IOOZCHOFIN7y9i5NHEWy9C19c5GLu?=
 =?us-ascii?Q?0Ze1NS7EXjNsoyXilYxO4CrJ7jpbKwFx6Cr6RM1KagWBPL/09MIy429k95V5?=
 =?us-ascii?Q?MNs4p8Qk4a6OPw/SfGRt/TBmKuexm6esr0l3Xfdf+9oAe5oYaW363tiGKcY/?=
 =?us-ascii?Q?f2kLCt6F6AtKJuRRJchqDiM4+uCgV8xueuySIOoZNumVNS1MrO35FQtZ0ouJ?=
 =?us-ascii?Q?AlQq5JP7nKIUP4yh5FPR8L5quj84y4MXcyp8qfViRIRu/cpnAFFtp09Z1ykL?=
 =?us-ascii?Q?Ejfhkm2gheTuVotp1Kzk4YtZBEar1c7F/k8Oz8k0S88YOwBq3c3l7C58I2hS?=
 =?us-ascii?Q?LP9th4IrdpncFp2531RJQdpYPSIUKO7TUWauOAWHV7sV5rAiXVY2UuekcMZr?=
 =?us-ascii?Q?pQRNQ+3gbHF9eSauCnUWjHb9H/g1eCvTMTehGY1idcBIkqTboQ8X7dVmiVCF?=
 =?us-ascii?Q?USXuHXSqST33/4rQAoWCGilv1dy6qHwcwPOGipPrck/gWcuReMmrgaWMgOzq?=
 =?us-ascii?Q?LN2gM0w/ZEimiPTN4CI352yNvwOt5x0bINxRhke2T0vHYYe6AWwEXrJIdBSz?=
 =?us-ascii?Q?WHbD2lVQjeL/ua4upPQDsdmkncZuTiWtSFAJrvTNL4A5B2bWLDpmaOgwSsG/?=
 =?us-ascii?Q?VqkZwF6swJWwz+j5wDPZzYUR0fhVm+kKANnsn1O2Us4LcFA1GJ7zTtf/3deD?=
 =?us-ascii?Q?6/hPd3WvOJGdaR8fZk+Uw8kpNOHSCKWFAEKGR3T3T0kSbXHiWCpx6ua0n5mj?=
 =?us-ascii?Q?8dXwkuLNaZNavEJh1ABJmrKj4mPI1rFt+fHjx9kYX+xpVfr0bm66GUhurLgH?=
 =?us-ascii?Q?cRYAGeax8Ru4BQgnEGG8R7LVOh8b8DmY0z7g43BjOglD/8utpSAmkG7fYQAr?=
 =?us-ascii?Q?9oP9d9LGC3mlRbx7GKvSzq/d+dCSsywY5YrxZ+T2eophPF+iUDtGiFryUyiq?=
 =?us-ascii?Q?FdBxJoM/ir98MCvNd2ARInhkrdb2hGI48RZWRuNNOfGt/6S81/0tUhUvtWAt?=
 =?us-ascii?Q?LzH0szR9LWCW/f0866cw0Xir3c/VvjxBIDuNG6GQXUnWAzCuASR7boT4iHDf?=
 =?us-ascii?Q?0rvVjL/y5JBdR+JHdsfqPYl3dVjxmdKPg+9UO+lPfQFX3Hkt8HO2aA1iIpRX?=
 =?us-ascii?Q?Yjw2l/VSm6at0SVmWN7U9gl2Tq2SKiyeLBYbZ2BvCbJBkZqdG98J41Ctd0Kj?=
 =?us-ascii?Q?UTgQAEoworLStmtuPcnO3Jr9UjjpdrY3ftbFOYPoIxoHZmsr4sk2bOjXU0NU?=
 =?us-ascii?Q?r6B9jkuzFXLyCaam/xl7Sdv/EVQyPkgoA8n76aOjP5ytdxeTg1Amse+IIwM7?=
 =?us-ascii?Q?ZsuiFI3tlB3hjEBaedqY93Zw+6CPL7mAuQyAak6PHE1pWYookYZ6jEsWfR8W?=
 =?us-ascii?Q?6yBygFzJ5QjKZq96Vuma/U476/LypkKuSQMEouiaes1o5pKhUmoQ1Fzium2x?=
 =?us-ascii?Q?eP82AMniD+CdeLeRMDDDO6/iUsPFk2xfEtsigafNKPTAoZkjoKHBdDYhBfzk?=
 =?us-ascii?Q?fbVOLCCIuOR+Yfy3iR+MgXoPEbXy3VnMoXJs?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:08.0024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20080d63-c3c1-4bda-2cef-08dd8ea6067d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405

To allow IOMMU drivers to allocate own vDEVICE structures, move the struct
iommufd_vdevice to the public header and provide a pair of viommu ops.

The iommufd_vdevice_alloc_ioctl will prioritize the callback function from
the viommu ops, i.e. a driver-allocated vDEVICE.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  8 ------
 include/linux/iommufd.h                 | 38 +++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu.c          |  9 +++++-
 3 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 80e8c76d25f2..5c69ac05c029 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -607,14 +607,6 @@ void iommufd_viommu_destroy(struct iommufd_object *obj);
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
index 34b6e6ca4bfa..422eda95d19e 100644
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
@@ -120,6 +128,15 @@ struct iommufd_viommu {
  *                    array->entry_num to report the number of handled requests.
  *                    The data structure of the array entry must be defined in
  *                    include/uapi/linux/iommufd.h
+ * @vdevice_alloc: Allocate a vDEVICE object and init its driver-level structure
+ *                 or HW procedure. Note that the core-level structure is filled
+ *                 by the iommufd core after calling this op. @virt_id carries a
+ *                 per-vIOMMU virtual ID (refer to struct iommu_vdevice_alloc in
+ *                 include/uapi/linux/iommufd.h) for the driver to initialize HW
+ *                 for an attached physical device.
+ * @vdevice_destroy: Clean up all driver-specific parts of an iommufd_vdevice.
+ *                   The memory of the vDEVICE will be free-ed by iommufd core
+ *                   after calling this op
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
@@ -128,6 +145,10 @@ struct iommufd_viommu_ops {
 		const struct iommu_user_data *user_data);
 	int (*cache_invalidate)(struct iommufd_viommu *viommu,
 				struct iommu_user_data_array *array);
+	struct iommufd_vdevice *(*vdevice_alloc)(struct iommufd_viommu *viommu,
+						 struct device *dev,
+						 u64 virt_id);
+	void (*vdevice_destroy)(struct iommufd_vdevice *vdev);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -245,4 +266,21 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 			ret->member.ops = viommu_ops;                          \
 		ret;                                                           \
 	})
+
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
+		if (!IS_ERR(ret)) {                                            \
+			ret->member.viommu = viommu;                           \
+			ret->member.ictx = viommu->ictx;                       \
+		}                                                              \
+		ret;                                                           \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 01df2b985f02..d4c7c5072e42 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -90,6 +90,9 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
 
+	if (viommu->ops && viommu->ops->vdevice_destroy)
+		viommu->ops->vdevice_destroy(vdev);
+
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
@@ -124,7 +127,11 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
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


