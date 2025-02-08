Return-Path: <linux-kselftest+bounces-26093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDC2A2D511
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 10:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23203AB371
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 09:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053471D6DB8;
	Sat,  8 Feb 2025 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M3K2BLqW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438C61AE005;
	Sat,  8 Feb 2025 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005423; cv=fail; b=A71zAgmfbBlQzIfrmgsao5FTK/69EsBeOYkIsPbV1ZvAtd5kAMVcoBRP/K5RovFXwzHjY8w1MDN23UqEm2yqfd1Jez1rlByuOHYIMV6tRfCmsbld01gKi56fInSryWfiRqapGwecil2ZhQkNqARkxeUhFzVC6VPtSYIb4XsuAuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005423; c=relaxed/simple;
	bh=e7cETpO7ypDGOqDDDPcNpjaNIer7uyJTPTs7Jyk2VVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2KfQyOGMAA2CVIvHE4/PrS9ZIC0+ivxkQ6/Js1yiCXcvaCCMYmuIv2gBvVK1F4nw9trUjWn6Rbr0bVl/6UlpU+ysPGB9Ue0vtl1NWyna255F1YnIvPlFMpWxNxnWjZDuZ5utrwCD6HPl9jpeqxhLey/dz3dWejBNGlgd0vYMqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M3K2BLqW; arc=fail smtp.client-ip=40.107.102.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsyphMFMNuy9d2v8qsZBT7nIfMQAYJAWQVGTq/njq9XfgohuetDq3+jh1DoBPocwysuaH8CSb4ZaJac2/ZwYWXzG2YzykiHgRJMkb46514JOGrzSGBGqPQEtqwaJMRxvxvhUuIPXHN9K+y0fIGxXPw3DBdWp4nIayPp+yt4I6p8r10FSSxY1f+jT905Yij6N5vltri372WzeuIvcW8vmEmss4odICKyTe5IDzPJOnH86U1B8VZhj27s6BBxLugtpYJpBpmrTFPLLlD2N2FLGpzC7ZZakk13ZpofUIGIpf3tbobYJTq4bxN91ubDr5d/nJ1vpVSiWQjPVpjV+8L5gtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75j6z8d7awpg/9zZQerCAsdb2+7Bs9ccRLOecVKM6cY=;
 b=uSvVENiw2Z00zc5IkDnDd/6Hc7vuD0jPEAo7HS4ZCU8x0pgfBeqxnAi+ed+woTxU7fwaNRubsm3+vsgHTsywC/n/uEUfzvLOaMpFdEcQ2uuurYwQ/VlwNWzs5C59lr41UkD3WoZc8jLHhv4smZ4+ToN5c9eqh4qUqmPStep0w9U3eASHa/05Rh271pxvgCbJU9FCP5UaOio8+YLp42+l+k+FcuqmrdGQmBOrTwXaD7Dn6FUWSwY0wD72pVE56JaHVhdki4pTgq++hB1cv2/t7dPzSqnGZpI/TeEPL9tRPpfZADf+m2k1M0vk4UJbzD0DKqVDIWueSufDoE4xtU5nMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75j6z8d7awpg/9zZQerCAsdb2+7Bs9ccRLOecVKM6cY=;
 b=M3K2BLqWfZp3Tc6s2kMb3EFP4MZbsFCqupCa2Sd8IFp51K/WqwnFOeeGFndsDwk96PbhlY+JO04T+9EZkaazIb/uEcEy8J+1Sr1qEOHsRZKp8W0CI4kDNCF1YhJkW3mEx/pnij81U8qrVVKB3/Y7q3YTvd0+HsFKuHA+o37pKI/rMw/qKzUVwfNBndPpM5zjrp4irVgUxsAG9dAOz7YJ6E0xp0fzvH9waQMQ8UN6dk16nI5IXPWsv1m1ACdNtT2N2Sko+fRPKO03YrXp+JCfhjAfuag/Vt3MCHbHTj5HokN6mpKvOmGlKMnMkd9WNHVWzy7iVXOHEcGx+kla15PVEQ==
Received: from MN2PR18CA0009.namprd18.prod.outlook.com (2603:10b6:208:23c::14)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Sat, 8 Feb
 2025 09:03:32 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::4e) by MN2PR18CA0009.outlook.office365.com
 (2603:10b6:208:23c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.29 via Frontend Transport; Sat,
 8 Feb 2025 09:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 09:03:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 8 Feb 2025
 01:03:17 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 8 Feb
 2025 01:03:17 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 8 Feb 2025 01:03:16 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v1 09/13] iommufd: Pass in idev to iopt_table_enforce_dev_resv_regions
Date: Sat, 8 Feb 2025 01:02:42 -0800
Message-ID: <ee3e7827ffe8691dae09f7604161b5bc6d6393bc.1739005085.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 023d1201-4c79-4ccd-4ab8-08dd481f75eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PtKyFKWFV60Fgo8kZAaM1Qn08j4mjsrpde9xr9+bTrEXUDCon6UXLUZ8S6Ej?=
 =?us-ascii?Q?ATqyGdOuIHPOLjdsW1AyRfZ0pgMiV9WJY57iKlrg/mqMdhiBTG1sxSLsilkv?=
 =?us-ascii?Q?lWlVcAACFVOMmC9qHCAk1fCZl1NT2wpY3CkmgwYYQhEelQD7plgLsbKoZKJL?=
 =?us-ascii?Q?Y8ukXymfaU5deyuakLV1Z1fJ+v8RuBIGyDE0u1NRoRC79evSJX1JzBcfk5nq?=
 =?us-ascii?Q?zKu7eQeXWNUKkVNQ6VP+yXtO4IgHR7b0MUhKRUc/GW4U+2MrtJbpVWzmtHWL?=
 =?us-ascii?Q?evtbHUTxq/cfAp1v0ddevlhcnhV1UE+//AAkqa3i/fC11hGPJKEXEzuPjv6X?=
 =?us-ascii?Q?Kpm0wPftjYbrOCC2QzzdaLFLSxIojhAcTGaJKThKrrGHiM5C7Eby9F4LrUoi?=
 =?us-ascii?Q?qIVxR3tPpdhm9usL9jGz+Wm2Q8E9SPe2eAV0KD7BSMJTRtyXpM07Do2myJSa?=
 =?us-ascii?Q?ngch3JzmGg+bwGrq+7ktCqXaqFsR39xtENLmHT47K/I57OHXnudj5JOG6psx?=
 =?us-ascii?Q?mIbe4NgLdSflYOMC4fdY1hyIOpuIW0KNYm/VKZaAZC1JCzD6c1cH0WxuN1xM?=
 =?us-ascii?Q?0zti10l1pykG/cO51LIsvph2aeeComZ4gFyIkwKgwoYPCFyTgwtxhh1zXfK8?=
 =?us-ascii?Q?wIzN+lJEn51ehlmCrIIMzenUxqNEkUA029gJnwTy98KvFy8i3xuGLO7nwzhb?=
 =?us-ascii?Q?eUbjjg4OEyeQnfTWtGB0IBxp2g3F5NNWsq/6jD/bDYna3Nqc5jKNpcxRJ+Py?=
 =?us-ascii?Q?iQia7fJUlNdVn46r2f6Ymi2LbCWLKlXY5tccOawSVXb2o5f4Dz5pGIVudvSV?=
 =?us-ascii?Q?4RMUE/C/hLuJhsznwODoXLcUoNfZ25YflgxQXpg+mW+r/kUWMU8nCxeCSfAP?=
 =?us-ascii?Q?+NGbJwIop2hcQ57B8g9NbSQIYRXr0PQ6hwOgR2YDRO+nRVvYFGqW46ZIEMVG?=
 =?us-ascii?Q?2GfVLMzyce//jo6BXqokq5nhM72R7QKW/o73kqX0noPwrsCqDtufXmIVg5TY?=
 =?us-ascii?Q?kWdFWCsr0w9qaicbpH4+V+Q33e8ZU73zfJYwyj4aWE+kExXXjomMJ5WYc2i5?=
 =?us-ascii?Q?m5pfeDck1zeMM3EqsD0jAaGcKF+LEpvl22hq8Bh0puHr0syYDnw7x25M0Ftg?=
 =?us-ascii?Q?9ujsBuLFVp23WY0qu73fgR/5IgpdWKkk/FbxiNYjoeJtyGFPLTaqwDO/tvJ8?=
 =?us-ascii?Q?jO4PnXsHx7LYu7aJ3dTtfxzdqz7JFQc1N/bwnln8fozpKAQTsh2p3iwdFUsu?=
 =?us-ascii?Q?AiqEUH2O8ngjF3U67sWSqgLcFm3soh/aVqN990Dz2yKhm1NCmG5ACezZViKY?=
 =?us-ascii?Q?cAt2o9KdMYL/jfyEJ9at6DFNNpEr+ml6cRHXwckjlhBrbKH8CI08rc/PwhDz?=
 =?us-ascii?Q?/aXs54qtrfQuVeZwHHbvOb0JFhUERmvsP/5MRkOeqrhHT7c+iLj88gK3nwMI?=
 =?us-ascii?Q?z3FJKMNen402G3z/3/hoG4UOloKn9OTJ+3FiOa8q6f4iYdygFmGeCXNtYI2T?=
 =?us-ascii?Q?qXI9L1XdnURT0aY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 09:03:31.3831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 023d1201-4c79-4ccd-4ab8-08dd481f75eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231

The iopt_table_enforce_dev_resv_regions needs to access the sw_msi_start
and sw_msi_size stored in the idev, set by user space. So, pass in idev
pointer instead.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 2 +-
 drivers/iommu/iommufd/device.c          | 5 ++---
 drivers/iommu/iommufd/io_pagetable.c    | 3 ++-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index c0df549c7d34..7a9cc6e61152 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -115,7 +115,7 @@ int iopt_table_add_domain(struct io_pagetable *iopt,
 void iopt_table_remove_domain(struct io_pagetable *iopt,
 			      struct iommu_domain *domain);
 int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
-					struct device *dev,
+					struct iommufd_device *idev,
 					phys_addr_t *sw_msi_start);
 int iopt_set_allow_iova(struct io_pagetable *iopt,
 			struct rb_root_cached *allowed_iova);
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 882cc51a3feb..5ecd96c04e89 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -452,8 +452,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 	lockdep_assert_held(&idev->igroup->lock);
 
-	rc = iopt_table_enforce_dev_resv_regions(&hwpt_paging->ioas->iopt,
-						 idev->dev,
+	rc = iopt_table_enforce_dev_resv_regions(&hwpt_paging->ioas->iopt, idev,
 						 &idev->sw_msi_start);
 	if (rc)
 		return rc;
@@ -664,7 +663,7 @@ iommufd_device_do_replace_reserved_iova(struct iommufd_device *idev,
 	if (!old_hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas) {
 		list_for_each_entry(cur, &igroup->device_list, group_item) {
 			rc = iopt_table_enforce_dev_resv_regions(
-				&hwpt_paging->ioas->iopt, cur->dev, NULL);
+				&hwpt_paging->ioas->iopt, cur, NULL);
 			if (rc)
 				goto err_unresv;
 		}
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 8a790e597e12..441da0314a54 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1423,9 +1423,10 @@ void iopt_remove_access(struct io_pagetable *iopt,
 
 /* Narrow the valid_iova_itree to include reserved ranges from a device. */
 int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
-					struct device *dev,
+					struct iommufd_device *idev,
 					phys_addr_t *sw_msi_start)
 {
+	struct device *dev = idev->dev;
 	struct iommu_resv_region *resv;
 	LIST_HEAD(resv_regions);
 	unsigned int num_hw_msi = 0;
-- 
2.43.0


