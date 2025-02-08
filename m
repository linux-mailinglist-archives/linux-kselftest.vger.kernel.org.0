Return-Path: <linux-kselftest+bounces-26087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B18A2D503
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 10:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7FE3AB2CA
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 09:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9C41B425D;
	Sat,  8 Feb 2025 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZRiRAp0a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFDD1B392B;
	Sat,  8 Feb 2025 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005411; cv=fail; b=ez3WyMlWGAdPIwuODAI6TlQoC8S9qor7UZp4P9XntnrOOJmIHLcTjBz+X2KpipoIduk2ijorLg9yXEkZnwdWw8Z8TkBSOfpqOssScNAecIC8cHh0ZW1NKDQpwFjBKKRVbHAjnLVwfPALRHanXKl7v6+1itYVIlPKw3j97UnLrM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005411; c=relaxed/simple;
	bh=FH5cO3TlTKdlJvgP61RUSDinkmoieeQWPaMbkeP3ySU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzrSTWVNgPfPGg1P6TIT6ikEh1g5RRrhKgM7dRxFXdAUOt1bJK9MUVgmg497Yzl617P2GkH+qcx+0prO2W+ghaRXxMQcSvUlWnPEZdRd+4KvBjDv2zUb3DY48K0ApNSiVKV79EMfzHedeAYof7UCesxw/zeX2ybjRRUMS2t35iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZRiRAp0a; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7dngDY7He20QKs+aarohaiu9aDmTHzt26YiBemMc65kCuqKdws10fINaHCwGnuCHRxIbm1UxTKtTush1a0zOs4LMf2Mekh2iG/2jCUjF1008Uc3p/ymb21ZfbJTUi+bywzYvROgrqE+YbZgKoR6ZE3Ojpn87BU6S+1CIYP2fE8J5OqBg5qdMOfmF1sddkfeWDHdu1i/mSyK97DtFYW/GISA3GcGqOCF6p0DAz6HJmG3R0Gv6IcyFcI0514nMmVqOOg4u5eyFjHqts/OZw5tSWa+MGqT9GFVjuDgF0vck7QIyUt46JGvVV9vd3uKjxSY0KNsFLGMTJHh4JDxiz6Fkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BylEi3IBeX07Xkt/7Wf4jk4pj4k7Cs2MVsV1KX0ROhE=;
 b=Zi4nHgwCPQhtBNCK4vEo9HJYT+kDIVzrl4rNlb7gGBWyObUsAluWUuLwuREt6nmNl4wOY/sFI6r7YBWnEQvQnpSkk9o04e3esxJR4MRAHKzgPkTS2bNquQ9GkHE4ML8i+7dY8ryvf7FHVtAWzXoKz88Xt+qScjGDtG0ll9IR4QDknDliZ/kHgEg6a1S4/9zDzzLoOed9xe4PKdcntBanbyOJa2gXqcUhnUBJFzywjiOPSubuQRww/qCHfcJSQRqnOaeYwUAXCiMixQ7VIqHjjdhBg0yyEMHIqYZZmtjp0QkLVsFG28fIC4XGb5dkiGuAdzjPo68zPLnBq9xUgbtb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BylEi3IBeX07Xkt/7Wf4jk4pj4k7Cs2MVsV1KX0ROhE=;
 b=ZRiRAp0aEEBRdQAWiX8VX5LwgVCmfbU9MPjhs14wQDsJ9oP3oRMFKQC/nk8aIoXi1KD0+7rE3+8EmrATaekFmjVkziTMbfnahwTt1G/fUgKJcVGhHEuVOT1e54qWibFMf62pSAGizG8JA56xSX4WsHoYu5CEXt+zgh3P7xjPxGw24sISiHZizZ85zDivHfrf7V2gmW/nt95bstA/wUID3KqNQg/8l799pcS8QXumj153olhXLVbhnESEl08Xuh2V1Tn2o1b2Rp0WvTMB+V0afSHgjKzzQti5cPm5HpBZJ2iSxKfih6o3I4PXuFPWeUq1yV4AjG1yCtPgU4uDBlRhFA==
Received: from DS7PR05CA0029.namprd05.prod.outlook.com (2603:10b6:5:3b9::34)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Sat, 8 Feb
 2025 09:03:25 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::26) by DS7PR05CA0029.outlook.office365.com
 (2603:10b6:5:3b9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.7 via Frontend Transport; Sat, 8
 Feb 2025 09:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 09:03:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 8 Feb 2025
 01:03:16 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 8 Feb
 2025 01:03:16 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 8 Feb 2025 01:03:15 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v1 08/13] iommufd/device: Move sw_msi_start from igroup to idev
Date: Sat, 8 Feb 2025 01:02:41 -0800
Message-ID: <550f103125805461491b87bb6018293ce9b888b7.1739005085.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739005085.git.nicolinc@nvidia.com>
References: <cover.1739005085.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 7becb780-40c6-4aae-b877-08dd481f7238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dazrNFqHJz3s2OiRFawSJn/IdLhO9NL4MW3zrTmIHdr4x9SMUedm/ld+8PkM?=
 =?us-ascii?Q?qmlEIyrmj187cJjnh7WH49Kusio+3MOu17YOv+zKkDFFODF4g6xrpJGGvqDL?=
 =?us-ascii?Q?PU3mmATdv+gpDbBq1uJUpD6DHHpKhaXohA/3XwnuVqvPzMItVJVYqrEXzICF?=
 =?us-ascii?Q?kPtQq1MxWqokT6aQzUugxTyUSh5PEe6qQXBIFJ9AjA172tnkG3kJDLlgLA7Y?=
 =?us-ascii?Q?gs34HDVaqH0LdPjfxtx00TSNpavHIPHnzUZlWKtlsUWZ77beFU9trkJLp8ux?=
 =?us-ascii?Q?t3MHbQpKpvYpbLasLAdg9IvTqxOroqiGcibS5Z6qwZBxqAZroNnEbEZmF8Rd?=
 =?us-ascii?Q?31dgd9so+hEzkNVsrK8GU5jr9KdFW/T2KaXIhg47xjLH9IPiQxuqsvlTS2Ie?=
 =?us-ascii?Q?IyPI8QaPfoAlOGKaN/7BRO+Cz0UxsUYG6avCVE4GUIctDONckEGBS0ihKZMA?=
 =?us-ascii?Q?3v4qFBYcpkoR3OjfUNF/8BlqAhku5gLlbfHcKV4NMqZxDJ/SLsq+KGGta3CC?=
 =?us-ascii?Q?KgKYk5zA6YAsFcBz/GEO32d5SV6hCD0wlEJiuckbC0mslOGF88peKawZ2z+E?=
 =?us-ascii?Q?kxeShvYCleLkHcpbVK6XZJwfsINrMEKrJfyO8UROybVb2cX9lEO8NxIqocYI?=
 =?us-ascii?Q?miMyhJuyqMZ+ouQ21kWt1mLwJknuGLV/gkPAoo3F9AP3QVORFKQGJbloWX6L?=
 =?us-ascii?Q?/7vaA//K83ti3vkS57NxEO36FqhOhlobjGMAsGU7WXdo5DsXWCE6gzadOANU?=
 =?us-ascii?Q?P2kWZJKTj77j3lipU4QC/aaQUAfNN5F6wlGi63KLXRUrfMUWOEkXxc1rSf/7?=
 =?us-ascii?Q?8fzW41TTA24OKPAp1QPvtwSh4RD4KyK31L+5ekCsBZZxaG9vencLKOHEZx5I?=
 =?us-ascii?Q?PA9iJtw6Vf2SFGureIpz2ZQf8xd8jxTS09FgqDYJQl5aVMpquFC7LDn8kZE/?=
 =?us-ascii?Q?XZYB5SO576NIEDRX3xuMNQn4egXu3hWATrUltUE0x10z3LsgeMevbtD2wS8l?=
 =?us-ascii?Q?oqQFRLRy0s/zjVyVLvBFJ8AX2aswkG4Y1DNzlt7/ySWXk4If5ivU4nRWm6Ud?=
 =?us-ascii?Q?ZGDBeYw69se4LR/mchiYIkh7JL3UIsvh+fPYVefHxEjkSxRqBkCh+sCs1dEI?=
 =?us-ascii?Q?SSPJ/7iZDAkeQ02XE9GY3bm3p2fYGE9sZXg0rvN2FUrniIma7cBrSmlt7ltZ?=
 =?us-ascii?Q?ahB5kGUp6WzKrXwdiQGeXXA3yJENWCuSLko9Gx80d3r06CjYDavLkiTsRU3V?=
 =?us-ascii?Q?TjjB1Yz52myp3kueVvycK31SwprA4iC+PsYv4+KjuM6a8467Te80LfhooD0J?=
 =?us-ascii?Q?XEk3Pef8f4TPecjQ588uuwy18QhH+Rx8ugnKkz5KEusQx0JFS0IG5LIkebQz?=
 =?us-ascii?Q?821LpU3vO/f8QIy5de829fGEwmzsLibY8CQ+KyQhAbHc8HX0gNmsq/6u5tHz?=
 =?us-ascii?Q?grniRwQYK5xowupchDd9bh866draQZgg43d+iNtxVv/JbFlNzxzITYmbzLpI?=
 =?us-ascii?Q?IQm94aoTe6E+Ws8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 09:03:25.2421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7becb780-40c6-4aae-b877-08dd481f7238
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893

The sw_msi_start was set from the per-device reserved region, so storing
it in the iommufd_device structure makes sense too. This will also ease
a following patch adding a SET_OPTION uAPI to set per-idev sw_msi args.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  2 +-
 drivers/iommu/iommufd/device.c          | 31 +++++++++++++------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 246297452a44..c0df549c7d34 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -404,7 +404,6 @@ struct iommufd_group {
 	struct iommufd_hw_pagetable *hwpt;
 	struct list_head device_list;
 	struct iommufd_sw_msi_maps required_sw_msi;
-	phys_addr_t sw_msi_start;
 };
 
 /*
@@ -423,6 +422,7 @@ struct iommufd_device {
 	/* protect iopf_enabled counter */
 	struct mutex iopf_lock;
 	unsigned int iopf_enabled;
+	phys_addr_t sw_msi_start;
 };
 
 static inline struct iommufd_device *
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e435ba13a8a5..882cc51a3feb 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -91,7 +91,6 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
 	INIT_LIST_HEAD(&new_igroup->device_list);
-	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
 
@@ -217,6 +216,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	/* igroup refcount moves into iommufd_device */
 	idev->igroup = igroup;
 	mutex_init(&idev->iopf_lock);
+	idev->sw_msi_start = PHYS_ADDR_MAX;
 
 	/*
 	 * If the caller fails after this success it must call
@@ -390,7 +390,7 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	hwpt_paging = find_hwpt_paging(domain->iommufd_hwpt);
 
 	/* No IOMMU_RESV_SW_MSI means no change to the msi_msg */
-	if (handle->idev->igroup->sw_msi_start == PHYS_ADDR_MAX)
+	if (handle->idev->sw_msi_start == PHYS_ADDR_MAX)
 		return 0;
 
 	ictx = handle->idev->ictx;
@@ -402,7 +402,7 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	 */
 	msi_map = iommufd_sw_msi_get_map(handle->idev->ictx,
 					 msi_addr & PAGE_MASK,
-					 handle->idev->igroup->sw_msi_start);
+					 handle->idev->sw_msi_start);
 	if (IS_ERR(msi_map))
 		return PTR_ERR(msi_map);
 
@@ -417,13 +417,13 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 }
 #endif
 
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
@@ -433,8 +433,8 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
 		int rc;
 
-		if (cur->sw_msi_start != igroup->sw_msi_start ||
-		    !test_bit(cur->id, igroup->required_sw_msi.bitmap))
+		if (cur->sw_msi_start != idev->sw_msi_start ||
+		    !test_bit(cur->id, idev->igroup->required_sw_msi.bitmap))
 			continue;
 
 		rc = iommufd_sw_msi_install(ictx, hwpt_paging, cur);
@@ -454,12 +454,12 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt_paging->ioas->iopt,
 						 idev->dev,
-						 &idev->igroup->sw_msi_start);
+						 &idev->sw_msi_start);
 	if (rc)
 		return rc;
 
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommufd_group_setup_msi(idev->igroup, hwpt_paging);
+		rc = iommufd_device_setup_msi(idev, hwpt_paging);
 		if (rc) {
 			iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt,
 						  idev->dev);
@@ -650,9 +650,10 @@ iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
 }
 
 static int
-iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
-				       struct iommufd_hwpt_paging *hwpt_paging)
+iommufd_device_do_replace_reserved_iova(struct iommufd_device *idev,
+					struct iommufd_hwpt_paging *hwpt_paging)
 {
+	struct iommufd_group *igroup = idev->igroup;
 	struct iommufd_hwpt_paging *old_hwpt_paging;
 	struct iommufd_device *cur;
 	int rc;
@@ -669,7 +670,7 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 		}
 	}
 
-	rc = iommufd_group_setup_msi(igroup, hwpt_paging);
+	rc = iommufd_device_setup_msi(idev, hwpt_paging);
 	if (rc)
 		goto err_unresv;
 	return 0;
@@ -704,7 +705,7 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 
 	old_hwpt = igroup->hwpt;
 	if (hwpt_paging) {
-		rc = iommufd_group_do_replace_reserved_iova(igroup, hwpt_paging);
+		rc = iommufd_device_do_replace_reserved_iova(idev, hwpt_paging);
 		if (rc)
 			goto err_unlock;
 	}
-- 
2.43.0


