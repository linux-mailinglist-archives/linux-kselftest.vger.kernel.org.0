Return-Path: <linux-kselftest+bounces-43147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DD5BDBEAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 02:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 696064E9556
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 00:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA22A1E991B;
	Wed, 15 Oct 2025 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RDjHCNEY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F13F1E230E;
	Wed, 15 Oct 2025 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760488283; cv=fail; b=MpuL/ckIylaju9QYB1NaM0QfAFtR5BYaeQB1ov2utvB56ouUTo93cw+UxDf5ast65a2ufLq7tXJzHH8OqLsIzuLY4WCdmjrwQBXrulXC+czjbsanGdzNV1dTAZp+iGiMtUEzQsGF+KmAoEDA0BjfKe/WJTHdXhRnOKBJq5885+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760488283; c=relaxed/simple;
	bh=P5kNj0bcYctiWe0ugoYX2UybiKcVEdTl0hzdjTJSmCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKTv7nHv5U0fNmohyi6QGSXmQkSTXoMLiapPQK6S1N7fctN5xtZJUBv6WG6wF9argdbx6iHETIrhS98MUuhzOv7OOP3F1VCSSwGbBjAcQKYqZ/9xbIs/YrCV3ImAuR8H1cU2Jl0ZMRfFnIQkwv5Seel7exCVIhpRYhFbfNjrDn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RDjHCNEY; arc=fail smtp.client-ip=52.101.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtRcJoC5AgbtZf3XrmomaFsor3dESDGBmZ0RzsKbN6K8nZI18DRPsqQ3CZVaV+T6lA0yZulqxxOHRocfXuvEPj5T5qxpc6+UjZ49ouUADmko6DM+BoZACwhv44e4NLKEAetYsl+I24waIi1V4GFOJxuXY0V5vMopBZr4wydq5st0xckU+DKKvwjZFp0Te01f1aSHIJ6jgSLKgMgb37fFtyC9yGMJ6X8aNeclSPK/OBmk7UzpYv4jnrjo8fRmFustxWsjA4ISkOxySIzrw5bnbNevkc2fm+TieeI4UmlKbJ7kNDWxDMgCLHQ1kkGN8wwBuv03Ne/3qqbcEl5pr97E8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9/CQYbUQYPXDV4LbJ4gno4dmyaVHDqgIXm0jmseops=;
 b=ZMtSB2sLWmeJaF4Sg6KD/DzYTvHO4SyySI9lpGuaVcId70PfWmMq9pDLrGdVmy0e63GL9Dot2airQfbJwUV9X0NqxRjETzccWeYwt3Qbx0KjCoMOkwYfx4APJE6rXZM7xn7T8gpsOT7CRoQxAeT7JnlfnQKTgi4BHReEqGxeDbmMGUwoPMlp2D/h4bPJLS+zpL/CeWYVM7TtevjlJ9YVFStH/aMxL8BRQBazQMpELAjrj5XN6tDaJnswr5/qQI2VBOO9yeyA1eNWUngcri+cZsrcCaLxZVmp51cOLrePzMjZnAu/bzFD2k2dWxgR1HcBmtUjfS4sC3uT30F1ZGr68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9/CQYbUQYPXDV4LbJ4gno4dmyaVHDqgIXm0jmseops=;
 b=RDjHCNEYELr8jR5UvjDGWi21HrQC0RERy86qpeTogNdoRJj6P43PKbtKPMvynZodgtdIcm1+vU7EMw4o0WYq2cmHseDGOcugWJdqjz3wRf02knBTZ28ClKtK8kG+qQl6F3Qb7t6bJmuPjt06ScZzsBfJypttvvY/+GlpCg77OZfNLoNi3oMrHwyKcGkz6c0nGCJo3Ac3GCRANeE23WnzxPC6IuKJYnDWxrgGTnL1L07WJxzi+/8cW/M43RN3sojRFA8LW6LyOYsxcVsxV9XXZ7+aMsVNKCoc1cR59Bud/ZwWNk5TqtBDlwJ6FeewJa0YWYhazLvrSDEeN+aQYdsgog==
Received: from CH0PR08CA0017.namprd08.prod.outlook.com (2603:10b6:610:33::22)
 by IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 00:31:17 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:33:cafe::df) by CH0PR08CA0017.outlook.office365.com
 (2603:10b6:610:33::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Wed,
 15 Oct 2025 00:31:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Wed, 15 Oct 2025 00:31:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 14 Oct
 2025 17:31:06 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 17:31:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 17:31:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <shyamsaini@linux.microsoft.com>
Subject: [PATCH v2 1/7] iommufd/device: Move sw_msi_start from igroup to idev
Date: Tue, 14 Oct 2025 17:29:33 -0700
Message-ID: <4cc8a000172572dba62f35f64f4bf0ebdba6d069.1760487869.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760487869.git.nicolinc@nvidia.com>
References: <cover.1760487869.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a76c98-f50c-4cad-4512-08de0b822805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xqes2luRoskFVkbyApASHRLrsJ+1HHobqZ9XNm5ofZke5q5PdGT7C/FTNsga?=
 =?us-ascii?Q?8u48UzPlyTDUfLGQTwVyN8or8oFpwFXkpejmHS7RlpGULsAXUpHhE4IUyvPW?=
 =?us-ascii?Q?AT+ncpaEESl9CXQ0SIvmRvi2i7+CMggdeEu34RYQGmSWcGtfh/T5/pE0BOGX?=
 =?us-ascii?Q?PyLbx20Q7jC/50NCCOgfdh95SDqiZ3jJaRMrBubWIeBFqPJy7EQBmNCZwbno?=
 =?us-ascii?Q?KyuaiO8EByMiHx0zAFEkMDHII0kcg/1kX6INaebRNSkkyqKn7St/a8WH8C/D?=
 =?us-ascii?Q?/XWooko/+fnbCWztuajr6cGmNHv/BBDdPcpXVHmOb/ZgmrPdUKyxdQbk4m6d?=
 =?us-ascii?Q?TF4VgxhHR62GqnK35yyfNB2LL1HHb7wpDxaqkqQN+vZ6dYURAB9fZzl8oCtr?=
 =?us-ascii?Q?WA73TnkKioqJ+x9PzgAtlhOeOKDue9JuwAEdLwGrXkZw4E3RRV3hVxbKrtIY?=
 =?us-ascii?Q?ALO2oLiovBwYuI9c8RhfI3tG3QZWl5elzt25mSY6W5qhQnBCB+8TkyQgdsTz?=
 =?us-ascii?Q?CkMB2YzgbVKJcueLw9hp1hUxydlECw2Y7qWfnItV0m6pGcx6WWbjLFJxunZF?=
 =?us-ascii?Q?8AY+P7/SJt83m4nHofiexWQ4opkr0mVW7D3juJl6pkoAchZLiZJldWVDdcIA?=
 =?us-ascii?Q?7az5gBg+f6C+A91hTj5FCXRh1qxNuXGEA+rUdNWP3pbr95K7jSIkBvsngfws?=
 =?us-ascii?Q?b58lXtWJaVO983cZJ1R3HFcInAK1QIls/j/XUic+Ps7XW02w80YGgiFobRhB?=
 =?us-ascii?Q?pkNcLevG9zBrdtGyXoNJYcUGiz+XvNFKomtZ9IxuF3ejikVT/ryIDCmoi++b?=
 =?us-ascii?Q?SyY+01ysAkfh3+m0UTrN/XSq7l10GiRwtWlf8JkTc/h/gLz7QMaof0Pw4FvF?=
 =?us-ascii?Q?DH604rkriCb6hnt18U3mv8DsMUXLkcJR2QDFxBL+FZ01YQf7ReWwQBDeWEpF?=
 =?us-ascii?Q?0i6FXMd9peQf9jxixMiDBRkocMccrsibpedel/QggXudl8OTVRh1R6aTSjrb?=
 =?us-ascii?Q?5ddaQixJP5M641UJ3kskcudVBcFb86EigheX8w/5ZQZnIww5NJsuJqINP3Fi?=
 =?us-ascii?Q?HkbJ/hnfLFUvXy9i8ue19TymuvsfHndkn49KS3MndVEJsiQCoNMpSX1/Gj6s?=
 =?us-ascii?Q?2FJ3p8ELBsm54j0KXq3+RPmYa9XIaRT9/bCNABbKwAAk3IxqDEFpsOVegdHa?=
 =?us-ascii?Q?O7N0l6hy8i579jRYzaG/DsrWC2DCjMDdioWVicMbB3j5BV8h7gEX4t0m6x1g?=
 =?us-ascii?Q?stSrvgWvXbmRbMd3XoLCrzM/2CmAEvq4yZWI9aQ64iJxfrBeNl9XXbxtYcH5?=
 =?us-ascii?Q?XlNwNMiFi82dY/DSUDBm88w+ZsmzwFg5J3wpsxh1I9XG1KB4p75SfoEW1I36?=
 =?us-ascii?Q?nXI141szT/276fY2UGemLMhO7UWvcZ70fBUfoXHro+9pYziyXNUrPDmT2VIT?=
 =?us-ascii?Q?0Hs/+rdHzH+OwLPIgx9N3kHu4+pT3dhURmU6mSizgRj8jTkMYqLdWAVdFQVk?=
 =?us-ascii?Q?0E8V95aDTKrN2nCpf2HW7z6kiXROUZCtZtSYi6k7tcKg2AiiEuV9gxVPUcr4?=
 =?us-ascii?Q?hUnZtsmVAs4C1Hy/3Pw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 00:31:17.6986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a76c98-f50c-4cad-4512-08de0b822805
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554

At the IOMMU driver layer the IOMMU_RESV_SW_MSI region is per device. So,
storing the sw_msi_start per idev makes sense.

And looking at the iommufd_sw_msi design:
 - The global ictx->sw_msi_list allocates an item for each different pair
   of sw_msi_start and msi_addr. And the allocation is per msi_desc, i.e.
   per idev.
 - Each allocated list item will be added to the igroup->required_sw_msi
   and the hwpt_paging->present_sw_msi.bitmap during a device attachment.

This makes it possible to move the sw_msi_start from struct iommufd_group
struct iommufd_device, giving a potential to support a new SET_OPTION uAPI
per idev for user space to configure the start_sw_msi for 2-stage mappings
of the MSI window.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  2 +-
 drivers/iommu/iommufd/device.c          | 31 +++++++++++++------------
 drivers/iommu/iommufd/driver.c          |  4 ++--
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 627f9b78483a0..73e5cddad24e9 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -472,7 +472,6 @@ struct iommufd_group {
 	struct iommu_group *group;
 	struct xarray pasid_attach;
 	struct iommufd_sw_msi_maps required_sw_msi;
-	phys_addr_t sw_msi_start;
 };
 
 /*
@@ -490,6 +489,7 @@ struct iommufd_device {
 	bool enforce_cache_coherency;
 	struct iommufd_vdevice *vdev;
 	bool destroying;
+	phys_addr_t sw_msi_start;
 };
 
 static inline struct iommufd_device *
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 4c842368289f0..ea7ed32bbaede 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -96,7 +96,6 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
 	xa_init(&new_igroup->pasid_attach);
-	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
 
@@ -272,6 +271,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	refcount_inc(&idev->obj.users);
 	/* igroup refcount moves into iommufd_device */
 	idev->igroup = igroup;
+	idev->sw_msi_start = PHYS_ADDR_MAX;
 
 	/*
 	 * If the caller fails after this success it must call
@@ -367,13 +367,13 @@ static unsigned int iommufd_group_device_num(struct iommufd_group *igroup,
 }
 
 #ifdef CONFIG_IRQ_MSI_IOMMU
-static int iommufd_group_setup_msi(struct iommufd_group *igroup,
-				   struct iommufd_hwpt_paging *hwpt_paging)
+static int iommufd_device_setup_msi(struct iommufd_device *idev,
+				    struct iommufd_hwpt_paging *hwpt_paging)
 {
-	struct iommufd_ctx *ictx = igroup->ictx;
+	struct iommufd_ctx *ictx = idev->ictx;
 	struct iommufd_sw_msi_map *cur;
 
-	if (igroup->sw_msi_start == PHYS_ADDR_MAX)
+	if (idev->sw_msi_start == PHYS_ADDR_MAX)
 		return 0;
 
 	/*
@@ -383,8 +383,8 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
 		int rc;
 
-		if (cur->sw_msi_start != igroup->sw_msi_start ||
-		    !test_bit(cur->id, igroup->required_sw_msi.bitmap))
+		if (cur->sw_msi_start != idev->sw_msi_start ||
+		    !test_bit(cur->id, idev->igroup->required_sw_msi.bitmap))
 			continue;
 
 		rc = iommufd_sw_msi_install(ictx, hwpt_paging, cur);
@@ -395,8 +395,8 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 }
 #else
 static inline int
-iommufd_group_setup_msi(struct iommufd_group *igroup,
-			struct iommufd_hwpt_paging *hwpt_paging)
+iommufd_device_setup_msi(struct iommufd_device *idev,
+			 struct iommufd_hwpt_paging *hwpt_paging)
 {
 	return 0;
 }
@@ -420,12 +420,12 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt_paging->ioas->iopt,
 						 idev->dev,
-						 &igroup->sw_msi_start);
+						 &idev->sw_msi_start);
 	if (rc)
 		return rc;
 
 	if (iommufd_group_first_attach(igroup, IOMMU_NO_PASID)) {
-		rc = iommufd_group_setup_msi(igroup, hwpt_paging);
+		rc = iommufd_device_setup_msi(idev, hwpt_paging);
 		if (rc) {
 			iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt,
 						  idev->dev);
@@ -745,9 +745,10 @@ iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
 }
 
 static int
-iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
-				       struct iommufd_hwpt_paging *hwpt_paging)
+iommufd_device_do_replace_reserved_iova(struct iommufd_device *idev,
+					struct iommufd_hwpt_paging *hwpt_paging)
 {
+	struct iommufd_group *igroup = idev->igroup;
 	struct iommufd_hwpt_paging *old_hwpt_paging;
 	struct iommufd_attach *attach;
 	struct iommufd_device *cur;
@@ -767,7 +768,7 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 		}
 	}
 
-	rc = iommufd_group_setup_msi(igroup, hwpt_paging);
+	rc = iommufd_device_setup_msi(idev, hwpt_paging);
 	if (rc)
 		goto err_unresv;
 	return 0;
@@ -813,7 +814,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	}
 
 	if (attach_resv) {
-		rc = iommufd_group_do_replace_reserved_iova(igroup, hwpt_paging);
+		rc = iommufd_device_do_replace_reserved_iova(idev, hwpt_paging);
 		if (rc)
 			goto err_unlock;
 	}
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 6f1010da221c9..35475937d069b 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -271,7 +271,7 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 
 	handle = to_iommufd_handle(raw_handle);
 	/* No IOMMU_RESV_SW_MSI means no change to the msi_msg */
-	if (handle->idev->igroup->sw_msi_start == PHYS_ADDR_MAX)
+	if (handle->idev->sw_msi_start == PHYS_ADDR_MAX)
 		return 0;
 
 	ictx = handle->idev->ictx;
@@ -283,7 +283,7 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	 */
 	msi_map = iommufd_sw_msi_get_map(handle->idev->ictx,
 					 msi_addr & PAGE_MASK,
-					 handle->idev->igroup->sw_msi_start);
+					 handle->idev->sw_msi_start);
 	if (IS_ERR(msi_map))
 		return PTR_ERR(msi_map);
 
-- 
2.43.0


