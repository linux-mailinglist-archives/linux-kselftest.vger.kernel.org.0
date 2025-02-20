Return-Path: <linux-kselftest+bounces-27028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B894A3CEC2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 02:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C241917ADC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 01:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EE91CAA90;
	Thu, 20 Feb 2025 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aQ8o5QbZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D621E29D0D;
	Thu, 20 Feb 2025 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015178; cv=fail; b=cljXYtXXJdjsxknETUa2ZsW/u7WH7LbQUe/EGIJim3wnABNv0D2PmkHTUv8K4Bj9I1pCyfPT4QYKKw35Sn7ekcic4S209nNbAKX89WmpqhqC1s9sZvJmWKD+3UgYOKqX3+AyQFX+6vEBAoGJig3LwNFc+NREwXBMjDFNZ/xAd8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015178; c=relaxed/simple;
	bh=OCYqNLyzeChV4IhhFd7fO9VummYpI+vCs39EBZP/UVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGELEMVEnIRmoQa6j+DA+TsFUWqsClWpaK+x8NKXkNQWSLWUYeqXAraXDtX4G5UIQx4jahGcVl2Wno/bX2BDLsrUxqSFhiwrfKqPbZe+/mushBW7nc4iIsoEFznI+p3flZBI4mWQzX/Lyl0RSoz/hXrXVYj+DICVA1Pg216jpKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aQ8o5QbZ; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rc1R4iVYTNfGCc2jJAEOaxmhQbFDGUw+9q4JEf3KwoSTjUJrPzY7vI1/uTwbSeC+TlYTGaD//MZRAJroqhhdHp5jLj8gbTlQn85Fw5CqLYFMBf4IfvFBsQwK+k6ZhtAEGb5Hyw5j+H8x/o4dzn7k6kspZakWEnAIIabro7mqMozSPem8Z1m9bBK1AsDuD6kDva5Go9ltxiIFk4maPyWvLgSOV+YDLy1PjZIa3N3mmOVfyJY3o8wrDdSop4w/BzMatpH+uKsEM4zwTKRUoeKBx631hs8L2joB+zdCfz2Y5Yb84/QSH0WWCsWh/Amlr/n0BoZkP6DybrW7jK0hNKuypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oz8m4Gpcy5mqerFBk3wReYJjDjKSdmcV+m2qwUhRbOs=;
 b=HX2sO6iIRLeqbuJHRYD3cWI13uefI08d4GOtq6teqK8kXq4k8afaP1H2Yj0gBXcQE/dDfl7a4kNs+3z2hnnjuPamb1GyrA6V6NB6FOSLd6I6IYdy1C+ES/5t6x/y/FWVR+ByH6o9xp/rc4L7Y/YJNhBl2eiPvC8jXL/6iMoeQEwhUypoZwS/5bN6XIzx9Ps1DiXzjOgPzVvz/A3sPMM8I9uKBVEB4Q09pNgg2Tz0fbu+KhLZrKDwP5LLwPmy3td3znPr8CY1QIbpS7rIUwrEGc4kBGXl6NW5nO5kwMC1Ow9kaLuC9yH5n9Ad/eFQyiYsrzTE7KOTbMz1e4xhraG7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oz8m4Gpcy5mqerFBk3wReYJjDjKSdmcV+m2qwUhRbOs=;
 b=aQ8o5QbZ0dnCLjlZae+b2FbHAzVOfU2e+DT+QOiFVkTxRRjtoWtarhJfsdMxXdfMuNPrioopPACXPMPFgPmwANz2ZX0vdL/xv5A4k/kAKWiBh2BzNH8e5IvbB/KFbi5f5/j2vS2a7QNgNOsydspdZgbyPYwI+WdWh/sJj0LsK36Kivf8exyccrI7w2Karc4DCmOAXebpANG/0sB3xeFRjCUmVa2uDRPQOwdvT/8wDBSUt9i07ry2DsIk/TEnfeQJ/E4ric7GvjwbJXKSF1e6E0R3fSkFd18rKeAsp12AkuB6cgkph/iYSVuQX4nOZh7BnzUxGo7betgbK/kH4551cw==
Received: from MN2PR19CA0011.namprd19.prod.outlook.com (2603:10b6:208:178::24)
 by DS7PR12MB9504.namprd12.prod.outlook.com (2603:10b6:8:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.22; Thu, 20 Feb
 2025 01:32:46 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:178:cafe::a2) by MN2PR19CA0011.outlook.office365.com
 (2603:10b6:208:178::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 01:32:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 01:32:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 17:32:33 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 17:32:32 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Feb 2025 17:32:31 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v2 6/7] iommufd: Implement sw_msi support natively
Date: Wed, 19 Feb 2025 17:31:41 -0800
Message-ID: <e13d23eeacd67c0a692fc468c85b483f4dd51c57.1740014950.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740014950.git.nicolinc@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DS7PR12MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: ab77cdc0-c4f0-4489-cbbc-08dd514e7a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bf1drCbB9u5bGoLaBKZga4pGSPzoKy/yeVdUVKPYC5s8Q1IzvyGL2Fa5BYm9?=
 =?us-ascii?Q?BEVjiCFsNuVXWbdf/q8ZukDkYSfN7+etQLR20DpzKC4r6LLvaFZ2Nkc40ql6?=
 =?us-ascii?Q?Z2Vw0WISKYuZcMQAS8CY30fx94RBf2mHbljdbtLpu7WCqL8gm4HTjYnY2hOY?=
 =?us-ascii?Q?Jo6RIsRXuimUq8PZ42FXtEmVNr9S1/LQ/eKeBLd+YQLqYmtKiv4KyBgtT/Rm?=
 =?us-ascii?Q?IKfrQvrUMEdSmU2vcohmgZ5acwJmkQHqTb9RPazBIDUq/WG5vhVlri/U9cF4?=
 =?us-ascii?Q?FAXEm+8KphQ7NJ+mLZ/k1p98XcbrCCXrI/F7+y9jg00DqpOzlOBEkuXVOb0U?=
 =?us-ascii?Q?/gLEKac76D3eL7eSqD2LOJFuBsx6ihLiO4OF/hDgzXISfhdstvf9QFMTsFwU?=
 =?us-ascii?Q?2W3rfi0pihrwPuzK9QAyD71r9fhaISvfTVEKrTWK48gesfgSZL7slhaeb91Q?=
 =?us-ascii?Q?Xbhv7th3HrzQ8aMwAm/KHLwyZ2EpS89l9+kGt1CEyy8vMIezgu//GKm4P4cp?=
 =?us-ascii?Q?cmlIy40muVmQTyWC0kWFzUjqy3VYqaXpgg+9FJzBgeVnhpY596y/9wZTnDM6?=
 =?us-ascii?Q?KQyqoyPzvCkBPkNVZ8pbTAX4feH1jcuyHAZJ8T5t2GpvDpjUfSBnbSFPr9lk?=
 =?us-ascii?Q?G7rORGaiIVZJvuy5q12EanyARGkScGNx2h5nAHbOoT8/hPmazjjOTQnZpoRh?=
 =?us-ascii?Q?5ntIASztN4DU/Tp0svcMmW0yf5d9cdUmOMkJkTMBdJtAHA1PGj3WcrVvmR6V?=
 =?us-ascii?Q?Qgx2r8CNcmbe+Lbrq8VTMLLI8jlaI5oGOUfPRnYJk6WNGfqMGCIMXcJSIxfr?=
 =?us-ascii?Q?2xR0Rh2CyWl/AU4xlwxEPeUjijTNbj3Yvj1ou/uIeJHrFfPUv2i1ty0GMuqi?=
 =?us-ascii?Q?TvJASfs6k8LWJUcTF+Zt4QouQSL9ePpdj0o+xUZDPRJy6qHJyxfz+Bnb47vl?=
 =?us-ascii?Q?ZaWhfIkIfTrxj4N/5AsLxA13Cc1IK63zdB4j37gjNu3uOD/MNQ3UDj055o6o?=
 =?us-ascii?Q?9s4aj9XSxxV9PZn4KHL3r7HlUibttUWXeQFZLRHwZ9gqbgVvYBs2BeMwMubD?=
 =?us-ascii?Q?DhghL3E38gfLvbDimRhMudmt4fqw0h8mtzV+qtuvDnfv1k9zDVHiCk+DQAyE?=
 =?us-ascii?Q?8FHEn27z0UY4jZ0oTRagUKo8eVx+z+tH/aTDl44J2Pt4aDBgFizgtYXPZVHo?=
 =?us-ascii?Q?Jk1vWHVsXXq+X+vNyjVYF7DJ2FlCwyHYhG75hpYHnbhfSTS9isrg1P9+TD6t?=
 =?us-ascii?Q?OSNI+yWexYFfhwaCzOQ1hupXALwimswwPD7XAMMPCRm4L9gYD4fw/n0ESD1R?=
 =?us-ascii?Q?3rzPXDHyaNa/6cfQaZdd5tzPxLPfzGfHRUutKf9r7XTXw2eqqsDD7ITU3STo?=
 =?us-ascii?Q?kxnjoDEGE1fLuz22SjSZ6Fe+Hv1TRnewmz3c6rgbql3VwUvI1hBKH6q0ZLH4?=
 =?us-ascii?Q?SRfNV1TTIlmk83y7j7Mq/Sqflhq7IzxmujxWBYWhH3fusvEv0JJIPnXWf+Mq?=
 =?us-ascii?Q?tSBOTpC+k0Q2tXg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:32:45.6723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab77cdc0-c4f0-4489-cbbc-08dd514e7a56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9504

From: Jason Gunthorpe <jgg@nvidia.com>

iommufd has a model where the iommu_domain can be changed while the VFIO
device is attached. In this case, the MSI should continue to work. This
corner case has not worked because the dma-iommu implementation of sw_msi
is tied to a single domain.

Implement the sw_msi mapping directly and use a global per-fd table to
associate assigned IOVA to the MSI pages. This allows the MSI pages to
be loaded into a domain before it is attached ensuring that MSI is not
disrupted.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  23 +++-
 drivers/iommu/iommufd/device.c          | 160 ++++++++++++++++++++----
 drivers/iommu/iommufd/hw_pagetable.c    |   3 +
 drivers/iommu/iommufd/main.c            |   9 ++
 4 files changed, 172 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8e0e3ab64747..246297452a44 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -19,6 +19,22 @@ struct iommu_group;
 struct iommu_option;
 struct iommufd_device;
 
+struct iommufd_sw_msi_map {
+	struct list_head sw_msi_item;
+	phys_addr_t sw_msi_start;
+	phys_addr_t msi_addr;
+	unsigned int pgoff;
+	unsigned int id;
+};
+
+/* Bitmap of struct iommufd_sw_msi_map::id */
+struct iommufd_sw_msi_maps {
+	DECLARE_BITMAP(bitmap, 64);
+};
+
+int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		   phys_addr_t msi_addr);
+
 struct iommufd_ctx {
 	struct file *file;
 	struct xarray objects;
@@ -26,6 +42,10 @@ struct iommufd_ctx {
 	wait_queue_head_t destroy_wait;
 	struct rw_semaphore ioas_creation_lock;
 
+	struct mutex sw_msi_lock;
+	struct list_head sw_msi_list;
+	unsigned int sw_msi_id;
+
 	u8 account_mode;
 	/* Compatibility with VFIO no iommu */
 	u8 no_iommu_mode;
@@ -283,10 +303,10 @@ struct iommufd_hwpt_paging {
 	struct iommufd_ioas *ioas;
 	bool auto_domain : 1;
 	bool enforce_cache_coherency : 1;
-	bool msi_cookie : 1;
 	bool nest_parent : 1;
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
+	struct iommufd_sw_msi_maps present_sw_msi;
 };
 
 struct iommufd_hwpt_nested {
@@ -383,6 +403,7 @@ struct iommufd_group {
 	struct iommu_group *group;
 	struct iommufd_hw_pagetable *hwpt;
 	struct list_head device_list;
+	struct iommufd_sw_msi_maps required_sw_msi;
 	phys_addr_t sw_msi_start;
 };
 
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 0786290b4056..d03c7f9e9530 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -5,6 +5,7 @@
 #include <linux/iommufd.h>
 #include <linux/slab.h>
 #include <uapi/linux/iommufd.h>
+#include <linux/msi.h>
 
 #include "../iommu-priv.h"
 #include "io_pagetable.h"
@@ -293,36 +294,151 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
 
+/*
+ * Get a iommufd_sw_msi_map for the msi physical address requested by the irq
+ * layer. The mapping to IOVA is global to the iommufd file descriptor, every
+ * domain that is attached to a device using the same MSI parameters will use
+ * the same IOVA.
+ */
+static struct iommufd_sw_msi_map *
+iommufd_sw_msi_get_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
+		       phys_addr_t sw_msi_start)
+{
+	struct iommufd_sw_msi_map *cur;
+	unsigned int max_pgoff = 0;
+
+	lockdep_assert_held(&ictx->sw_msi_lock);
+
+	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
+		if (cur->sw_msi_start != sw_msi_start)
+			continue;
+		max_pgoff = max(max_pgoff, cur->pgoff + 1);
+		if (cur->msi_addr == msi_addr)
+			return cur;
+	}
+
+	if (ictx->sw_msi_id >=
+	    BITS_PER_BYTE * sizeof_field(struct iommufd_sw_msi_maps, bitmap))
+		return ERR_PTR(-EOVERFLOW);
+
+	cur = kzalloc(sizeof(*cur), GFP_KERNEL);
+	if (!cur)
+		cur = ERR_PTR(-ENOMEM);
+	cur->sw_msi_start = sw_msi_start;
+	cur->msi_addr = msi_addr;
+	cur->pgoff = max_pgoff;
+	cur->id = ictx->sw_msi_id++;
+	list_add_tail(&cur->sw_msi_item, &ictx->sw_msi_list);
+	return cur;
+}
+
+static int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
+				  struct iommufd_hwpt_paging *hwpt_paging,
+				  struct iommufd_sw_msi_map *msi_map)
+{
+	unsigned long iova;
+
+	lockdep_assert_held(&ictx->sw_msi_lock);
+
+	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
+	if (!test_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap)) {
+		int rc;
+
+		rc = iommu_map(hwpt_paging->common.domain, iova,
+			       msi_map->msi_addr, PAGE_SIZE,
+			       IOMMU_WRITE | IOMMU_READ | IOMMU_MMIO,
+			       GFP_KERNEL_ACCOUNT);
+		if (rc)
+			return rc;
+		__set_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap);
+	}
+	return 0;
+}
+
+/*
+ * Called by the irq code if the platform translates the MSI address through the
+ * IOMMU. msi_addr is the physical address of the MSI page. iommufd will
+ * allocate a fd global iova for the physical page that is the same on all
+ * domains and devices.
+ */
+#ifdef CONFIG_IRQ_MSI_IOMMU
+int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		   phys_addr_t msi_addr)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommu_attach_handle *raw_handle;
+	struct iommufd_attach_handle *handle;
+	struct iommufd_sw_msi_map *msi_map;
+	struct iommufd_ctx *ictx;
+	unsigned long iova;
+	int rc;
+
+	/*
+	 * It is safe to call iommu_attach_handle_get() here because the iommu
+	 * core code invokes this under the group mutex which also prevents any
+	 * change of the attach handle for the duration of this function.
+	 */
+	iommu_group_mutex_assert(dev);
+
+	raw_handle =
+		iommu_attach_handle_get(dev->iommu_group, IOMMU_NO_PASID, 0);
+	if (IS_ERR(raw_handle))
+		return 0;
+	hwpt_paging = find_hwpt_paging(domain->iommufd_hwpt);
+
+	handle = to_iommufd_handle(raw_handle);
+	/* No IOMMU_RESV_SW_MSI means no change to the msi_msg */
+	if (handle->idev->igroup->sw_msi_start == PHYS_ADDR_MAX)
+		return 0;
+
+	ictx = handle->idev->ictx;
+	guard(mutex)(&ictx->sw_msi_lock);
+	/*
+	 * The input msi_addr is the exact byte offset of the MSI doorbell, we
+	 * assume the caller has checked that it is contained with a MMIO region
+	 * that is secure to map at PAGE_SIZE.
+	 */
+	msi_map = iommufd_sw_msi_get_map(handle->idev->ictx,
+					 msi_addr & PAGE_MASK,
+					 handle->idev->igroup->sw_msi_start);
+	if (IS_ERR(msi_map))
+		return PTR_ERR(msi_map);
+
+	rc = iommufd_sw_msi_install(ictx, hwpt_paging, msi_map);
+	if (rc)
+		return rc;
+	__set_bit(msi_map->id, handle->idev->igroup->required_sw_msi.bitmap);
+
+	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
+	msi_desc_set_iommu_msi_iova(desc, iova, PAGE_SHIFT);
+	return 0;
+}
+#endif
+
 static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 				   struct iommufd_hwpt_paging *hwpt_paging)
 {
-	phys_addr_t sw_msi_start = igroup->sw_msi_start;
-	int rc;
+	struct iommufd_ctx *ictx = igroup->ictx;
+	struct iommufd_sw_msi_map *cur;
+
+	if (igroup->sw_msi_start == PHYS_ADDR_MAX)
+		return 0;
 
 	/*
-	 * If the IOMMU driver gives a IOMMU_RESV_SW_MSI then it is asking us to
-	 * call iommu_get_msi_cookie() on its behalf. This is necessary to setup
-	 * the MSI window so iommu_dma_prepare_msi() can install pages into our
-	 * domain after request_irq(). If it is not done interrupts will not
-	 * work on this domain.
-	 *
-	 * FIXME: This is conceptually broken for iommufd since we want to allow
-	 * userspace to change the domains, eg switch from an identity IOAS to a
-	 * DMA IOAS. There is currently no way to create a MSI window that
-	 * matches what the IRQ layer actually expects in a newly created
-	 * domain.
+	 * Install all the MSI pages the device has been using into the domain
 	 */
-	if (sw_msi_start != PHYS_ADDR_MAX && !hwpt_paging->msi_cookie) {
-		rc = iommu_get_msi_cookie(hwpt_paging->common.domain,
-					  sw_msi_start);
+	guard(mutex)(&ictx->sw_msi_lock);
+	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
+		int rc;
+
+		if (cur->sw_msi_start != igroup->sw_msi_start ||
+		    !test_bit(cur->id, igroup->required_sw_msi.bitmap))
+			continue;
+
+		rc = iommufd_sw_msi_install(ictx, hwpt_paging, cur);
 		if (rc)
 			return rc;
-
-		/*
-		 * iommu_get_msi_cookie() can only be called once per domain,
-		 * it returns -EBUSY on later calls.
-		 */
-		hwpt_paging->msi_cookie = true;
 	}
 	return 0;
 }
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 2641d50f46cf..7de6e914232e 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -156,6 +156,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			goto out_abort;
 		}
 	}
+	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	/*
 	 * Set the coherency mode before we do iopt_table_add_domain() as some
@@ -251,6 +252,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 		goto out_abort;
 	}
 	hwpt->domain->owner = ops;
+	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
 		rc = -EINVAL;
@@ -307,6 +309,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 		goto out_abort;
 	}
 	hwpt->domain->owner = viommu->iommu_dev->ops;
+	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
 		rc = -EINVAL;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index ccf616462a1c..b6fa9fd11bc1 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -227,6 +227,8 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 	xa_init(&ictx->groups);
 	ictx->file = filp;
 	init_waitqueue_head(&ictx->destroy_wait);
+	mutex_init(&ictx->sw_msi_lock);
+	INIT_LIST_HEAD(&ictx->sw_msi_list);
 	filp->private_data = ictx;
 	return 0;
 }
@@ -234,6 +236,8 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 static int iommufd_fops_release(struct inode *inode, struct file *filp)
 {
 	struct iommufd_ctx *ictx = filp->private_data;
+	struct iommufd_sw_msi_map *next;
+	struct iommufd_sw_msi_map *cur;
 	struct iommufd_object *obj;
 
 	/*
@@ -262,6 +266,11 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 			break;
 	}
 	WARN_ON(!xa_empty(&ictx->groups));
+
+	mutex_destroy(&ictx->sw_msi_lock);
+	list_for_each_entry_safe(cur, next, &ictx->sw_msi_list, sw_msi_item)
+		kfree(cur);
+
 	kfree(ictx);
 	return 0;
 }
-- 
2.43.0


