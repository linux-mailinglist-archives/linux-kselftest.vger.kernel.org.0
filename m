Return-Path: <linux-kselftest+bounces-33275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B4EABAD66
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A077ADD3B
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3B922AE48;
	Sun, 18 May 2025 03:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XGjruzYm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEA2225792;
	Sun, 18 May 2025 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538574; cv=fail; b=dX5p/a819Z1U26P6Vz+LSCvSaxBWRzLCFE4TmbINbimUtDt9hOjtrKXpOWLHyZEu5fXL27GERxZQOOshyKBm0LN7cO8ctMxpl4RztlkhWOVavgJ6urUbfCmXjp0YFOqgMhz5TtUTnU/sqN+1eXFZ9Gb5zDLyfhIOh9doM4t0Qpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538574; c=relaxed/simple;
	bh=xH0pCpWFt+IfcRmKvhLWWli0L+t4TVojzYywUj4/jjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DV9VkEMkKLtfPPbqC+tKZ5B0izVW6VtVH4xVXK+M045Ilycpv5JwwFH5KG749mXA7XMnAC6alJw50f44cQ2ilEOX0xuoRa4dX5PhjmnlSOEgYeOFg4R+3eCwf8xkvR/Lf4toGGgIjzqyEav7ycTfXPhw/Betpm10tGGvw7v7mwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XGjruzYm; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1FAsiuc8g2ZWgnRS3g8MMF9tdv2GICBWv80Oo3DXVbQy0d0aXJy/sQrTXUc/C0tP2gvZZ6PO5Uv6PdaYaKhmwOgHKqZ14X4xxL8BgLI+mKbYm6ZjXYXq4NKiUVXF4usUj4AdUO9W9qySqnW7q+xGhnOgKpXEUi2cxXHzr0R/DywGhFbI5+Tt+Vnzm91swnLSzlOzxLrb1JmEaBjP9V4Ka2lbf1Ij1UUB265zdDD7/lV6UN5OIpS9v/GLzQbWgZ/F9dGGjlB8dhVQoWSvpBCXF4MjFB/Z3k6H8zB4K6GnDDsDshGE6qgQnFceLkiVqZJf3j98ehjMaDGMjhh4RdEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAErJHsigqHvvSowoG4g92P8d35iDhTJq9ELHQlRXD0=;
 b=A70bNHzMakzQ+7v1cC5WtDKS4rKObKZlCVYd2A0eR8ftNdxHH1L0QP52qDtB7NbLifGEF/JuNu07Lz73HA3dMQbbngHvVkZtXG/QScM7/Fi7u1nT/RIksxQiuDhawMbRizs/FRTjDQ2S7o5a6Y6Yw3ZQ5bOmKmpUK6yNdsmZGFZNkAIS3mZMuR2A8fQds5/NomLVI+kn/dYXaaateUgnz7jct4FgSNsFO59JVteQhAdp1XIK+6dsPI0xLnrbQDJYUcezS7TDjqOHp47pPlqMcAhCDHP0uEBVoroVdq6tJmk7814rHOsYx3jJt/c5Y2qd2XEyp3QMlhx70/f18/HQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAErJHsigqHvvSowoG4g92P8d35iDhTJq9ELHQlRXD0=;
 b=XGjruzYmWp218KrQT0uD3yLLUg/WP5cnBinD3hlnWd0VI3n7jPWT/D7tNGMli6EL1BDWGfK2uom/pc8FCmJOGHPqLZouyB0TNgWtQ09QyNzIjLcH+A352aabWyHuaISXBBmA+nO+uXuuBpLM/1hsd210nNM59f0LEaAFRF+Gdnjl8QyRMrpTxbPtPgoyGO/K/TCzpIlTNdMX0fgDr5y2lLzEF91V0RoK1agYaoKEv1f60GukdFkxKlM2QONftW7IRjPSju+mKe30J4+pXVjWtXXvw8I5x+7/0iH26Bwx+c7TQjehSIFVhH+h+7J2AjBbYaZn2IlBEyLZyJgxyhpXpw==
Received: from SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26)
 by CH2PR12MB9542.namprd12.prod.outlook.com (2603:10b6:610:27d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:22:48 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::55) by SA9PR10CA0021.outlook.office365.com
 (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Sun,
 18 May 2025 03:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:47 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:37 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:31 -0700
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
Subject: [PATCH v5 20/29] iommu: Allow an input type in hw_info op
Date: Sat, 17 May 2025 20:21:37 -0700
Message-ID: <d75b14f77997836603650bb12437ccaf50afd2a6.1747537752.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747537752.git.nicolinc@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|CH2PR12MB9542:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e96027-b17b-472c-370c-08dd95bb4389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?96UdjM9CngzH7AUX967+LUd80nKjmZ+l4FpKnINA2nqTMSTtaHaG2JD+3d7T?=
 =?us-ascii?Q?1R0y59n1KQ1G1xwUtpw2NoQ03gyaInM2arM1fVadD6yEdfgcxgUVcpl97HMv?=
 =?us-ascii?Q?LCZumCg5vkmFjWIG3YBFpylLTOzmFj7OCaAj6A6jLoLBMQHVVqTFnEt47t3F?=
 =?us-ascii?Q?0VbuxT53jpYcVFJDj8PbQ8P363t/C7AdhgUYuYL55N56CYV5GDBIDnf6WyCB?=
 =?us-ascii?Q?Jzu8lbmnZinV0Z0GDGE0JSRMOPMM4LbM4ncAprqWsKhXYChtMFqZN9N7GQ71?=
 =?us-ascii?Q?C2HB4dvP4akY/+/JbAZ8Xkb+6TP0nqrvu0Jl77Cf7FNBmF0BYqOWAI/psHVa?=
 =?us-ascii?Q?SRTichGetAu2TmiR20oq0fhJBEuFxLmpT0bSsPgbqbiQcqNcXdUyAk9UTyvV?=
 =?us-ascii?Q?KOf4GGB2pewpkqoc0cTSN16P02S9nScLijN+vIDf1ucLjY4vUPrjGE7TKmwC?=
 =?us-ascii?Q?O6NJ3oK8Gsw7rjly4n1g1Qx2H8srjhZbB5xalSSZWIrCEIW87zLhUgjdzfUW?=
 =?us-ascii?Q?EU/clc3z0vtvzzXsVt2/pH3vQbYpVKQNfCNVuaZcv99DjmBqXq1XdqFMDXc5?=
 =?us-ascii?Q?CbsU2iVxFFNfhyYMFo0Pcw2sW2iwgdlOO5VkwB1kuYe8cKKfRDtk+602iDJx?=
 =?us-ascii?Q?vTXxqg9F66+wSF5A4zgEqLgk8ZNo5BLSpAjpNomR4MlseUGbgHmjlmoqDal5?=
 =?us-ascii?Q?xEx8GYzP4RrQrx83XS7Wsucd3kjHiqKKSWZ1r6fU/kXxMxV7RS2XxicBiJeH?=
 =?us-ascii?Q?3Qt40efClsEP5Yugn6OjAqDp97NSY/ALuUtsil0ZWjgk5ny088e0lhd4juIa?=
 =?us-ascii?Q?tFFqFMtXQTpfkT0imqeh+2sGDHxq1tekRu08HbKpfQ9XXVA/YnLY0N0PSVnq?=
 =?us-ascii?Q?jFFbIfrrW5lADCsi8FKXc6OOMuUC89aHJLFmJOD7HZC25mS+U2gmDviw/22Z?=
 =?us-ascii?Q?/k64n789sz+uTd3oCd7Z7JINvl8UObfhNpxMT9xtFItH9U+mRqmQvFgWixJY?=
 =?us-ascii?Q?gRQikjBt4MB0DxR6Tg6MMtu1REA4v/d7A8EsuMjCpxHZyUC0vqq5avrU3du/?=
 =?us-ascii?Q?1LyDrsyNhTLQ1Hz4EY3jaCbI6dOHOHzX3Sk7BrIspUFNJrAf7pXorRvoKUpQ?=
 =?us-ascii?Q?DdjmQB0ykkAMDdMwYfWpiuINFAQyF505wP/3zDdkXhnoIjKAi+CRA1ffom+h?=
 =?us-ascii?Q?puwwIXc4PxFc0SGfht99C1zjPC8gXKqrAwTYTOm0Wq4mB1DWFizfNv0ePmdW?=
 =?us-ascii?Q?7PT0KGVphR2Rkgj6gx6JomCdrXmzJS22FpmkhTK39pQr+skm2lCy7rLqyg02?=
 =?us-ascii?Q?PzHfjZk3jYcKDfVQ2p8hKDePV0MX66sAMwWqo9Y2nsCyloBEJSXqAV4h5dwQ?=
 =?us-ascii?Q?2Dh32rqP8wKcqOtbA9kAeMsyGukdSFzPS6NKFFYiQSbEd+D4fPaWk8Tac1uL?=
 =?us-ascii?Q?aTpBS3du3t7mAnDy9a26Ay0pIiaU+bNN+otzOUlyspSrPSvdqlQgsV+dgwxr?=
 =?us-ascii?Q?sawh/HdO88j3FtGpCriFfrfGYnyTXjREhQJ0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:47.9423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e96027-b17b-472c-370c-08dd95bb4389
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9542

The hw_info uAPI will support a bidirectional data_type field that can be
used as an input field for user space to request for a specific info data.

To prepare for the uAPI update, change the iommu layer first:
 - Add a new IOMMU_HW_INFO_TYPE_DEFAULT as an input, for which driver can
   output its only (or firstly) supported type
 - Update the kdoc accordingly
 - Roll out the type validation in the existing drivers

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h                               | 6 ++++--
 include/uapi/linux/iommufd.h                        | 4 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 4 ++++
 drivers/iommu/intel/iommu.c                         | 4 ++++
 drivers/iommu/iommufd/device.c                      | 3 +++
 drivers/iommu/iommufd/selftest.c                    | 4 ++++
 6 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4c54dd8f94e4..01a19b68a0ea 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -607,8 +607,10 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
  * @capable: check capability
  * @hw_info: report iommu hardware information. The data buffer returned by this
  *           op is allocated in the iommu driver and freed by the caller after
- *           use. The information type is one of enum iommu_hw_info_type defined
- *           in include/uapi/linux/iommufd.h.
+ *           use. @type can input a requested type and output a supported type,
+ *           either of which must be defined in enum iommu_hw_info_type in
+ *           include/uapi/linux/iommufd.h. Driver should reject an unsupported
+ *           data @type input
  * @domain_alloc: allocate and return an iommu domain if success. Otherwise
  *                NULL is returned. The domain is not fully initialized until
  *                the caller iommu_domain_alloc() returns.
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index aeed0127553e..1fc546acb231 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -593,13 +593,15 @@ struct iommu_hw_info_arm_smmuv3 {
 
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
- * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not report hardware
+ * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
  *                           info
+ * @IOMMU_HW_INFO_TYPE_DEFAULT: Input to request for a default type
  * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
  * @IOMMU_HW_INFO_TYPE_ARM_SMMUV3: ARM SMMUv3 iommu info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE = 0,
+	IOMMU_HW_INFO_TYPE_DEFAULT = 0,
 	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
 };
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index adef56db4028..61a3f9134a9b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -14,6 +14,10 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
 	u32 __iomem *base_idr;
 	unsigned int i;
 
+	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
+	    *type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cb0b993bebb4..8ad8714ece5e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4149,6 +4149,10 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
 	struct intel_iommu *iommu = info->iommu;
 	struct iommu_hw_info_vtd *vtd;
 
+	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
+	    *type != IOMMU_HW_INFO_TYPE_INTEL_VTD)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	vtd = kzalloc(sizeof(*vtd), GFP_KERNEL);
 	if (!vtd)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 0f2bda9e9d84..50337183eb1c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1365,6 +1365,9 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	    cmd->__reserved[2])
 		return -EOPNOTSUPP;
 
+	/* Clear the type field since drivers don't support a random input */
+	cmd->out_data_type = IOMMU_HW_INFO_TYPE_DEFAULT;
+
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 45276c137cee..299a8e1e7f6c 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -290,6 +290,10 @@ static void *mock_domain_hw_info(struct device *dev, u32 *length, u32 *type)
 {
 	struct iommu_test_hw_info *info;
 
+	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
+	    *type != IOMMU_HW_INFO_TYPE_SELFTEST)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0


