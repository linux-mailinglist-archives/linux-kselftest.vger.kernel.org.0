Return-Path: <linux-kselftest+bounces-26086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 415ABA2D502
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 10:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD6F16A56E
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 09:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20481B4235;
	Sat,  8 Feb 2025 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="thtG0tOY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D521B21B2;
	Sat,  8 Feb 2025 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005410; cv=fail; b=St+LE6d/24y4An4TpFvupemCVoCugWTMZLYyUGvAWnJsU9Cgg7v+rqqd6rnn4uLclSEb2UM9k0YOsAQF6jZ7Qp8bSrzkyHN4HxhZsvU5ka9ySM3dLUbjWYUC4pTUtbdfE9y4eOQ1AIHmkzP+BxF5TwlYH8pGak7nHMHB+UeRW8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005410; c=relaxed/simple;
	bh=j/3lCswW8XRUuMz13KYbup7ioGDwHt+Ti1U4Zcevxr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iup4WKVrRf7XGf/zZljtHwXQGsO9DchokatRE1KT1HdjerakLT4etOBixEWeiUxI/PxB8pqtCSDiDbfYItHbelKm27/i3MRC/4vBQJpWJTc1MT71p6sL31tv0OT0v/arY/HC/0swU9z+irasEhRYgNGYPG1ovM4ahSwhwRfcsKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=thtG0tOY; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oB6doFU6sfNk65eAovo6i8pacQm5RAucXS3fUlvS89ayWkPgKHR57l89+g4kxW9nmYkXjoTHm31T6m85wpvwD91ZzjJo9e8x9X32ci/Lox0F+XV4qYQxCVLlBsGsZlYGU6dRlYtZwrj5iTK1J5CXG+KAnE9I26HuGtvQvkVBHhSlTOFTIuUk5r+QpRU1xI0n9P21Ozsz2Y0EJtKkWzgzG92Y4Qrgubzyo/YReVMHHz4SD82+0WYGbHoC90qke8OcgABRqwvyeUfQP24P9P1HJSRzBPQWR1UQv0eAntNXOH6EjE7Ovojg6DcZrJxP8LM4LIw2bCSWA1WMnkoWTd32XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhPOTuzja0Y6NxE5hxlX7yg52nGBhP1A/JjD9CRO/rc=;
 b=e3Tefk9cmaDAPh5lJKDY6UTmf1cA2CRed62sqVew5YZnsTPqizSwTCUh8SJf2Pm57k7XOR8HEbsiMXrAyMSWe/1XLPYqOUoJAwdD7XcetgeqMXLfyFi3HnuWfFFpgIh89biR/jAmraqyfboHVpJwq4aq2OxTvovJ2YIGwDXXzbHCN9f5ZuLivqn5+n7hZ4NlpoCx1JYIV0EIWUhNxZeqlkJWyQ9J5AMXXtVwxRNm3tBOGxG+CLWvwjudYXP5bi1E/yPGH3umNDeTFjtzj+L0zyccK5lbl6aYdczKvi/39h54mr7P/FcE1+89ru/bwWcW5juB35lQQcy/QFIDAi1F4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhPOTuzja0Y6NxE5hxlX7yg52nGBhP1A/JjD9CRO/rc=;
 b=thtG0tOYTCDeJByV/PGbVzyroDJDYGini2SgQjwCRihisZBnwrb4Sq0+nOY2UPcaHPc01GmoHopM9lbj8Ph9N10ME2MWy3hC607XJQzwIM+PpneJWRtnRqLYrrYZ7P5U13gXmBNRWFnAa0ixtCrf0j4P+cHgLXC9CiW2rAudQrdq+IaV6DL1HjZ4wW8hDR0pNyMPKg7lp6KKtdPBNSSuTOANgKAI7iy41MukcXyrbBw9pQj5jhhOBlGxiXNBeJ0TezOdRGrKfWmJkm8X8fsC+294CSRAR/QQZ4D0IUy8RoGE2eaHU4uA6YRpMqdAyBvVeN5dzd2qbm2TuN1IRXbodA==
Received: from BY3PR03CA0017.namprd03.prod.outlook.com (2603:10b6:a03:39a::22)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 09:03:22 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::a7) by BY3PR03CA0017.outlook.office365.com
 (2603:10b6:a03:39a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Sat,
 8 Feb 2025 09:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 09:03:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 8 Feb 2025
 01:03:10 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 8 Feb
 2025 01:03:10 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 8 Feb 2025 01:03:09 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v1 03/13] iommu: Make iommu_dma_prepare_msi() into a generic operation
Date: Sat, 8 Feb 2025 01:02:36 -0800
Message-ID: <432bc128b36b9dd57329b203bf46e01683a32f06.1739005085.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: c7501fcd-c58b-4dec-40d2-08dd481f7049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/B9tFG7sTFvukp4CLi/gJtCxArhdl4WaeZ5hdnvcZIbgCvte/tQoJ9BL825E?=
 =?us-ascii?Q?x5MPaEcvesiTbdyU8A9B0LbU8wZhv5AVLWGw1SBL/ugNseKc+w4LOTwJWzBZ?=
 =?us-ascii?Q?krHAKZt4rN7CMO9CL73YOOuewIrBGDqz0th5UHFQWwqRsQvxxlsSSJOYTDVv?=
 =?us-ascii?Q?eXPY5EPRkqF/02jHbaL/WrswEMOjl0oRQ2dIe7Sz/WmhCnN9iwj/8TezE1Pl?=
 =?us-ascii?Q?XPSFIYXdUYntN9vAXZEv568fC4LeuQ23LDDM+M8h9JwMOfaYsX9m4AyAyjNT?=
 =?us-ascii?Q?zK5fFqTp8XuNW9ni29+90sUfxTHJzCCQ1boXhlYMMzpF/0lmUX0+4JPytjDe?=
 =?us-ascii?Q?81PEOa2dWwmvAf9XkriUU5DG7lu2M4vKcWv20y9dopIyZxMeOHFflhiwSJOQ?=
 =?us-ascii?Q?RvhZiLN9Ccl8Zx1rdkNKldJQqZsGgayuv1uXfIm8EUD5ojw2ajpnFyoNmHDz?=
 =?us-ascii?Q?G/xEwkTlSv/u5aS62WkZSm5nmedAauBKQpU/JqSU9gAqktY3Fbm3hMgOBpuf?=
 =?us-ascii?Q?etCQHpp+L7tmCTvMSDYXnPhSd3/JosadJO8ik9thFtHhZtZ/fPYr1vXnSUeL?=
 =?us-ascii?Q?ydnFMzXsTXEb/8iJ2Dv40W1QkyRNSF95DDe4u0FBj4VoE8L5TLzeKdo8Fg/1?=
 =?us-ascii?Q?ONH7BuB/dBQJKWf6yH2nZDJxO7GWgnnpE5voPTmow7l/oCdLKu1nUiBJIEa0?=
 =?us-ascii?Q?p49S8mb8GaSutuNRtyA5BlbqEiTOhV/YCTLHEH/rkxzUSswb0Zae/nLFVlFv?=
 =?us-ascii?Q?lRDMF8vLPKJ8KTuznOB3Kj/wX5uexxrhcL0Yuh4FLSS4jSjYc3DT09DjI9Tx?=
 =?us-ascii?Q?dCAN593Rpyn8vAeGxJA39nsOhDqGoSaI1vpEaySGMUt03DtsO/2ouY47uV6Q?=
 =?us-ascii?Q?vzjQ0ljKCdxik1pvHodanoYINPtj4Tdmu9F7kYSfoP1QdYJbjAaMAdPRT39f?=
 =?us-ascii?Q?UBHj+jkSudGzwxIqi4VcPdsCC0GfXSdr6UPD+TmkUIxGRDzqqgaQbrZhF0SG?=
 =?us-ascii?Q?hn/NeBhOuPNAbzw7OlBmmTJIgziULvVfou5t1f0iU8Jg0ecWuAIKqiXDiWAd?=
 =?us-ascii?Q?1sI7UGEOMwdl8XCs67NgFL9VLN68DroV1TiECC6PioUvbzoN7vxUNWJEVKoJ?=
 =?us-ascii?Q?7knDx4yWle9rGngtYLmSDjgmWAakVc5mE9c6dUxJ2PP2KE7qh/BAvQCY+iob?=
 =?us-ascii?Q?gJNtDnJGwYUuEHkm12kxQDV93NT5QJC4rkWgOVmKNkJnFO6MU9pbcn3Hwz4x?=
 =?us-ascii?Q?5aPWKXjBCVUZMBI8YOLjnNXz08XFyT2xJICDXS5Op66A+7ncBU478VvT0mSa?=
 =?us-ascii?Q?K5Y73uqGNefbNUa3VbFTm6GJ9pJMiEdMZRF8rgh1IpXzy//gT7hmhi/GDSJT?=
 =?us-ascii?Q?OWVk67+w+FGiHF1JaObjVRnRYjcOwdyaHQRZxFA48YtzVFTReZNSLoTYd9eZ?=
 =?us-ascii?Q?D5uplDRFNYcIO6J1wN6H95Uzyl/rJ/DYSzMU/uxnKwUZsjzdqBlQB+L/6WUG?=
 =?us-ascii?Q?H9rauo07iHjHLpo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 09:03:22.0262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7501fcd-c58b-4dec-40d2-08dd481f7049
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545

From: Jason Gunthorpe <jgg@nvidia.com>

SW_MSI supports IOMMU to translate an MSI message before the MSI message
is delivered to the interrupt controller. On such systems the iommu_domain
must have a translation for the MSI message for interrupts to work.

The IRQ subsystem will call into IOMMU to request that a physical page be
setup to receive MSI message, and the IOMMU then sets an IOVA that maps to
that physical page. Ultimately the IOVA is programmed into the device via
the msi_msg.

Generalize this to allow the iommu_domain owner to provide its own
implementation of this mapping. Add a function pointer to struct
iommu_domain to allow the domain owner to provide an implementation.

Have dma-iommu supply its implementation for IOMMU_DOMAIN_DMA types during
the iommu_get_dma_cookie() path. For IOMMU_DOMAIN_UNMANAGED types used by
VFIO (and iommufd for now), have the same iommu_dma_sw_msi set as well in
the iommu_get_msi_cookie() path.

Hold the group mutex while in iommu_dma_prepare_msi() to ensure the domain
doesn't change or become freed while running. Races with IRQ operations
from VFIO and domain changes from iommufd are possible here.

Replace the msi_prepare_lock with a lockdep assertion for the group mutex
as documentation. For the dmau_iommu.c each iommu_domain is unique to a
group.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
[nicolinc: move iommu_domain_set_sw_msi() from iommu_dma_init_domain() to
 iommu_dma_init_domain(); add in iommu_put_dma_cookie() an sw_msi test]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h     | 44 ++++++++++++++++++++++++++-------------
 drivers/iommu/dma-iommu.c | 33 +++++++++++++----------------
 drivers/iommu/iommu.c     | 29 ++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 33 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index caee952febd4..761c5e186de9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -44,6 +44,8 @@ struct iommu_dma_cookie;
 struct iommu_fault_param;
 struct iommufd_ctx;
 struct iommufd_viommu;
+struct msi_desc;
+struct msi_msg;
 
 #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
 #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
@@ -216,6 +218,12 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
 	int (*iopf_handler)(struct iopf_group *group);
+
+#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
+	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
+		      phys_addr_t msi_addr);
+#endif
+
 	void *fault_data;
 	union {
 		struct {
@@ -234,6 +242,16 @@ struct iommu_domain {
 	};
 };
 
+static inline void iommu_domain_set_sw_msi(
+	struct iommu_domain *domain,
+	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
+		      phys_addr_t msi_addr))
+{
+#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
+	domain->sw_msi = sw_msi;
+#endif
+}
+
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
 {
 	return domain->type & __IOMMU_DOMAIN_DMA_API;
@@ -1470,6 +1488,18 @@ static inline ioasid_t iommu_alloc_global_pasid(struct device *dev)
 static inline void iommu_free_global_pasid(ioasid_t pasid) {}
 #endif /* CONFIG_IOMMU_API */
 
+#ifdef CONFIG_IRQ_MSI_IOMMU
+#ifdef CONFIG_IOMMU_API
+int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
+#else
+static inline int iommu_dma_prepare_msi(struct msi_desc *desc,
+					phys_addr_t msi_addr)
+{
+	return 0;
+}
+#endif /* CONFIG_IOMMU_API */
+#endif /* CONFIG_IRQ_MSI_IOMMU */
+
 #if IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_IOMMU_API)
 void iommu_group_mutex_assert(struct device *dev);
 #else
@@ -1503,26 +1533,12 @@ static inline void iommu_debugfs_setup(void) {}
 #endif
 
 #ifdef CONFIG_IOMMU_DMA
-#include <linux/msi.h>
-
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
-
-int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
-
 #else /* CONFIG_IOMMU_DMA */
-
-struct msi_desc;
-struct msi_msg;
-
 static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 {
 	return -ENODEV;
 }
-
-static inline int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
-{
-	return 0;
-}
 #endif	/* CONFIG_IOMMU_DMA */
 
 /*
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index bf91e014d179..3b58244e6344 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -24,6 +24,7 @@
 #include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/msi.h>
 #include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
@@ -102,6 +103,9 @@ static int __init iommu_dma_forcedac_setup(char *str)
 }
 early_param("iommu.forcedac", iommu_dma_forcedac_setup);
 
+static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+			    phys_addr_t msi_addr);
+
 /* Number of entries per flush queue */
 #define IOVA_DEFAULT_FQ_SIZE	256
 #define IOVA_SINGLE_FQ_SIZE	32768
@@ -398,6 +402,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 		return -ENOMEM;
 
 	mutex_init(&domain->iova_cookie->mutex);
+	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
 	return 0;
 }
 
@@ -429,6 +434,7 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 
 	cookie->msi_iova = base;
 	domain->iova_cookie = cookie;
+	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
 	return 0;
 }
 EXPORT_SYMBOL(iommu_get_msi_cookie);
@@ -443,6 +449,9 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi, *tmp;
 
+	if (domain->sw_msi != iommu_dma_sw_msi)
+		return;
+
 	if (!cookie)
 		return;
 
@@ -1800,33 +1809,19 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return NULL;
 }
 
-/**
- * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
- * @desc: MSI descriptor, will store the MSI page
- * @msi_addr: MSI target address to be mapped
- *
- * Return: 0 on success or negative error code if the mapping failed.
- */
-int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
+static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+			    phys_addr_t msi_addr)
 {
 	struct device *dev = msi_desc_to_dev(desc);
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct iommu_dma_msi_page *msi_page;
-	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
+	const struct iommu_dma_msi_page *msi_page;
 
-	if (!domain || !domain->iova_cookie) {
+	if (!domain->iova_cookie) {
 		msi_desc_set_iommu_msi_iova(desc, 0, 0);
 		return 0;
 	}
 
-	/*
-	 * In fact the whole prepare operation should already be serialised by
-	 * irq_domain_mutex further up the callchain, but that's pretty subtle
-	 * on its own, so consider this locking as failsafe documentation...
-	 */
-	mutex_lock(&msi_prepare_lock);
+	iommu_group_mutex_assert(dev);
 	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
-	mutex_unlock(&msi_prepare_lock);
 	if (!msi_page)
 		return -ENOMEM;
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 870c3cdbd0f6..022bf96a18c5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3596,3 +3596,32 @@ int iommu_replace_group_handle(struct iommu_group *group,
 	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
+
+#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
+/**
+ * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
+ * @desc: MSI descriptor, will store the MSI page
+ * @msi_addr: MSI target address to be mapped
+ *
+ * The implementation of sw_msi() should take msi_addr and map it to
+ * an IOVA in the domain and call msi_desc_set_iommu_msi_iova() with the
+ * mapping information.
+ *
+ * Return: 0 on success or negative error code if the mapping failed.
+ */
+int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct iommu_group *group = dev->iommu_group;
+	int ret = 0;
+
+	if (!group)
+		return 0;
+
+	mutex_lock(&group->mutex);
+	if (group->domain && group->domain->sw_msi)
+		ret = group->domain->sw_msi(group->domain, desc, msi_addr);
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+#endif /* CONFIG_IRQ_MSI_IOMMU */
-- 
2.43.0


