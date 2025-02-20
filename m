Return-Path: <linux-kselftest+bounces-27029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FACDA3CEBE
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 02:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FCB189B07F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 01:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0847F1CB51B;
	Thu, 20 Feb 2025 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kReTsOIh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DD418E025;
	Thu, 20 Feb 2025 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015178; cv=fail; b=OCQvWu2dca7d2hMZd2pgtmpOqLIYrwmALrl94lqJRFeuTwkn2IpwTkBdH44IX7yKlxS2ozuNtOy+qOF8qkyUjhJAzQnidF9Y5nPV96lL+0PyS1UJC2rUS4ZnG9uutBh6c9g4YGPeKljHuI9X1YueAS8WI/u0pwiDZi6KnVoYZvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015178; c=relaxed/simple;
	bh=KBjRZJF27eSDna1biA1vwhv4sWUgJnuALrFID341rXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RX9+FVKJ6kEoK8R+rgjYcx/fAF7UY7RDE5cdptLDkLIAGVAyzeWzVe4NAE7zbqxWmouzp7CXF/pRELDvdoB1NUylZZ+/SmaGmx7vzbnttDuYhemjc7DrAg1FKN1pJytcMW5z9sxDseQwniZnSa+lujcWqSXqNgwNF6L2F/p3e3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kReTsOIh; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQyBHV2vTTXbAAvIu7BNa+WlmnxCRiIVFdq8ojRwwdcRtZMJEWt4/aJP80rGm0mPwqYfqjy1hIWA49dmnebfOSd16bgF8Mr+vJJQXfJLZ+n1dI2yMvJT1A50qB7I7C72tfTs663cgThJ4XvqFGpPeVIAV6lDVSLZqEW/Iukr42H/4ydLkNxK6JkqUhSjxBBswChz9lVSFlGQeHzNs1VuStxngMB5LNrzeTwsbxHy9oDlWJuy/prwiw6f7UVlTbzGANhVX+uioNaEwQ4dILxeeGfGO7787HuNqSUFkPvf+cMvIiZV3JUYe51Zg7ht/8lKqXg59qKupDRkX4JXnTfYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl0IOoxBe6+f0DNQfO/apREWAVhDS9iJmpX/KIbe3jc=;
 b=UHmgfDB33K6a2neLMk7WOe45smYN02olisHvPSeX92MJTnmCxWQ10Ot6VdN06zeEnaZ0+OJUaDn77kXCqO8hExYLMa1SFihl2FV2Hy1HKDu4lbEwalRA/7oAiuXtKqIjUVVEfAIFSmP7DWt35PsSjpUfpkStiWDxJXVVhZ2EKymoKxZOzM++CvrOr5lxIZ6DfNlkOEgE+UMkSj2uFOts7Hd+EasYM/Ka6oFThcjqN65oDZgpwio+vCYX+FD/FMs3BWVaRpyBMhIwpxR3lJTysjgE+5oL9Gb/W0+oxx8niTVfLoUeIZs6RQ3aHxQppQagjlf9kD/44BKk4sqJkVRlgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl0IOoxBe6+f0DNQfO/apREWAVhDS9iJmpX/KIbe3jc=;
 b=kReTsOIhVNKb8mdkp6B2xuhOjuNhGxj3zCBj3YyCEBmya3rvdfU3PO4b5JC5YPyYgZ2zIUYOU7zpi1AhqT01naGgybHm63JBfl8ZhcDwafbQsc2pGp3YiqXL/EDaDi0kuDGnSA2jnXUqX08uAKTwpbCZRSb9Dq7Rb4dhXyE9uxu7CbVcRnI4+Y+rPTPh1qqts+YRKxUUF7Dpr3vvIhJJ3QmBDhNOzGf1bRQ9Xbw3YpjrrIXaIIELV2oGLdVzC72ivfF5RoVwAdcQoYmAfDBU0cZfOYPzu1qMqI0vBjQxS4v4ik8J0pi3D+JdSJcPQfWLVblKvgBxLANFEbbqNF9tNg==
Received: from BN9P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::32)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 01:32:40 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::d7) by BN9P220CA0027.outlook.office365.com
 (2603:10b6:408:13e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 01:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 01:32:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 17:32:27 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 17:32:27 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Feb 2025 17:32:26 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v2 2/7] genirq/msi: Refactor iommu_dma_compose_msi_msg()
Date: Wed, 19 Feb 2025 17:31:37 -0800
Message-ID: <eda62a9bafa825e9cdabd7ddc61ad5a21c32af24.1740014950.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c1b070-43c1-4135-2f26-08dd514e76a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ew87cpujUM2W2zmAGB0KXf9RNRSsmuOKRWyXSguOx5D6XFYP8e8asXQM5/1I?=
 =?us-ascii?Q?+SE0/F35vcb/R0BBn4vhOyVJY6+be2HKC2vKsfak4B3thF1nH8SipPtpJ6OC?=
 =?us-ascii?Q?c24NwsLw5huoelVOh/KsLzcDVijIfPE5YFu4kQ9/c0TKI0fcTYj6tGvEUMRq?=
 =?us-ascii?Q?2KY4zl/F9bWmu8AhJLpMAJzCh0ef9Juxh0ReE7AaKVyFfpxF5HZQIt+5kRD3?=
 =?us-ascii?Q?ob1zDtLmmqy6rupnyN3wFsI2p8ublL/GNyFG2faQp9Sq8RZ9xZFeTwuEf2+k?=
 =?us-ascii?Q?QlGKbUbJZg+ZySct9eiSGKpgOdCsBonYltay3dd/OmtqCkvLCtgNiq0PCmWY?=
 =?us-ascii?Q?kwtbWW1eeVXEwkfhaXYfEChZykZHexGvGVGqGp3XjzzAkIh9vB6iUEQA0Q8/?=
 =?us-ascii?Q?P2ivqm5YxG5M68ZlXjEqDIA9x4diJHuY/fNDszFCYg5fHiaRyRWsA/7R31NQ?=
 =?us-ascii?Q?wa1i941ORXDHeVj/9/XcJo/Y55DRsHn/8/97GaVz1aQ+K1IDddV7E4VU5w94?=
 =?us-ascii?Q?aKpaVTBpDXgxR+ZPv8xXgM+jt301yNwdQeXLPCJyQwy+2U3qSxBn6RT8DzRG?=
 =?us-ascii?Q?kaAYxNrEbPFS5+jnY9f1/yXxp2kUTs7sPq4riE+KZhPMxPggoHwmzV3r1tzt?=
 =?us-ascii?Q?Ua9vb6L3WVkRUoeuTacb8Khw6N+nMX6QT9P6y7cDvwVx+XMfZNuewLeQaKVQ?=
 =?us-ascii?Q?FSKqspLQWTE+zhM4uPKS+fe+bWtVoW1ETcoakovmn5B5ddWLvkmGog3RZsYj?=
 =?us-ascii?Q?DY5uMPi7df+CxUJ2pxwBzM8hFuiNe+i9mh6BiyNZJ1MX8nQ0UtOzMo8mjZ9C?=
 =?us-ascii?Q?FJy05e1g/8rW5P3U6J84OvxQHZmc7vavEouohP3WpbRMIL1o7tEwdzYJQX30?=
 =?us-ascii?Q?zBORAY7jIZsSMdnc8D0EHuCdM/25PwvRGQObQKNy5oNixS4DP7uJv4Udly3L?=
 =?us-ascii?Q?B6J3JfsJuExWNoZCEovw+sIaaicxXjNJ1J4jSX0kuII1riGSAbrGemIAe+aP?=
 =?us-ascii?Q?X0zbGWT2K7K9gyumVel3MciKpsLShEz8OjsWMxGkyalcPqy5aSFdCKFv60ty?=
 =?us-ascii?Q?iH2mN4nzGycBKqGI/4abOdPiL5sac/IaMakSv8EC6ZRLAfW8sW64WJ+ArPON?=
 =?us-ascii?Q?TNVFecKmLhuxNKDX0G18w10mhVUscQZjoWmA0FrvjMcKeS2ipYSG8xEqav3X?=
 =?us-ascii?Q?XvXTdy/wgXGjHvWMqTVncL8tMQLUC8bMYqwhyT9C50cQUAXRqjbTOoYwkZmy?=
 =?us-ascii?Q?tkm0auyYuYtyjIT+opXOnfI3e1a++Qg1ldsiCC+YlYpIprnnpdGckxyfB76y?=
 =?us-ascii?Q?xIWyFr/zLZ56h5s17rKBPgWSFy0Rk20cLWzWnKbtOFVXnHRWo3bESXD0ne/z?=
 =?us-ascii?Q?zwqhXuT9vlUy77ppFj2E+X2FDCuBWFzdWPWM7R+vHYrPz1cH8jUSZvBML7Cd?=
 =?us-ascii?Q?2Jf3u5jd08mN6ua1U6Coakx9njwZSUfuFJUhgg4Kr0hVv1T2TCfSnLeKEf9I?=
 =?us-ascii?Q?1MzQH5oqcSCbdBQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:32:39.4217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c1b070-43c1-4135-2f26-08dd514e76a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140

From: Jason Gunthorpe <jgg@nvidia.com>

The two-step process to translate the MSI address involves two functions,
iommu_dma_prepare_msi() and iommu_dma_compose_msi_msg().

Previously iommu_dma_compose_msi_msg() needed to be in the iommu layer as
it had to dereference the opaque cookie pointer. Now, the previous patch
changed the cookie pointer into an integer so there is no longer any need
for the iommu layer to be involved.

Further, the call sites of iommu_dma_compose_msi_msg() all follow the same
pattern of setting an MSI message address_hi/lo to non-translated and then
immediately calling iommu_dma_compose_msi_msg().

Refactor iommu_dma_compose_msi_msg() into msi_msg_set_addr() that directly
accepts the u64 version of the address and simplifies all the callers.

Move the new helper to linux/msi.h since it has nothing to do with iommu.

Aside from refactoring, this logically prepares for the next patch, which
allows multiple implementation options for iommu_dma_prepare_msi(). So, it
does not make sense to have the iommu_dma_compose_msi_msg() in dma-iommu.c
as it no longer provides the only iommu_dma_prepare_msi() implementation.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h             |  6 ------
 include/linux/msi.h               | 28 ++++++++++++++++++++++++++++
 drivers/iommu/dma-iommu.c         | 18 ------------------
 drivers/irqchip/irq-gic-v2m.c     |  5 +----
 drivers/irqchip/irq-gic-v3-its.c  | 13 +++----------
 drivers/irqchip/irq-gic-v3-mbi.c  | 12 ++++--------
 drivers/irqchip/irq-ls-scfg-msi.c |  5 ++---
 7 files changed, 38 insertions(+), 49 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 38c65e92ecd0..caee952febd4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1508,7 +1508,6 @@ static inline void iommu_debugfs_setup(void) {}
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 
 int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
-void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg);
 
 #else /* CONFIG_IOMMU_DMA */
 
@@ -1524,11 +1523,6 @@ static inline int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_a
 {
 	return 0;
 }
-
-static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
-{
-}
-
 #endif	/* CONFIG_IOMMU_DMA */
 
 /*
diff --git a/include/linux/msi.h b/include/linux/msi.h
index fc4f3774c3af..8d97b890faec 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -299,6 +299,34 @@ static inline void msi_desc_set_iommu_msi_iova(struct msi_desc *desc, u64 msi_io
 #endif
 }
 
+/**
+ * msi_msg_set_addr() - Set MSI address in an MSI message
+ *
+ * @desc:	MSI descriptor that may carry an IOVA base address for MSI via @iommu_msi_iova/shift
+ * @msg:	Target MSI message to set its address_hi and address_lo
+ * @msi_addr:	Physical address to set the MSI message
+ *
+ * Notes:
+ *  - Override @msi_addr using the IOVA base address in the @desc if @iommu_msi_shift is set
+ *  - Otherwise, simply set @msi_addr to @msg
+ */
+static inline void msi_msg_set_addr(struct msi_desc *desc, struct msi_msg *msg,
+				    phys_addr_t msi_addr)
+{
+#ifdef CONFIG_IRQ_MSI_IOMMU
+	if (desc->iommu_msi_shift) {
+		u64 msi_iova = desc->iommu_msi_iova << desc->iommu_msi_shift;
+
+		msg->address_hi = upper_32_bits(msi_iova);
+		msg->address_lo = lower_32_bits(msi_iova) |
+				  (msi_addr & ((1 << desc->iommu_msi_shift) - 1));
+		return;
+	}
+#endif
+	msg->address_hi = upper_32_bits(msi_addr);
+	msg->address_lo = lower_32_bits(msi_addr);
+}
+
 int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
 			       struct msi_desc *init_desc);
 /**
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0f0caf59023c..bf91e014d179 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1836,24 +1836,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	return 0;
 }
 
-/**
- * iommu_dma_compose_msi_msg() - Apply translation to an MSI message
- * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
- * @msg: MSI message containing target physical address
- */
-void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
-{
-#ifdef CONFIG_IRQ_MSI_IOMMU
-	if (desc->iommu_msi_shift) {
-		u64 msi_iova = desc->iommu_msi_iova << desc->iommu_msi_shift;
-
-		msg->address_hi = upper_32_bits(msi_iova);
-		msg->address_lo = lower_32_bits(msi_iova) |
-				  (msg->address_lo & ((1 << desc->iommu_msi_shift) - 1));
-	}
-#endif
-}
-
 static int iommu_dma_init(void)
 {
 	if (is_kdump_kernel())
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index be35c5349986..57e0470e0d13 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -87,9 +87,6 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	struct v2m_data *v2m = irq_data_get_irq_chip_data(data);
 	phys_addr_t addr = gicv2m_get_msi_addr(v2m, data->hwirq);
 
-	msg->address_hi = upper_32_bits(addr);
-	msg->address_lo = lower_32_bits(addr);
-
 	if (v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY)
 		msg->data = 0;
 	else
@@ -97,7 +94,7 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	if (v2m->flags & GICV2M_NEEDS_SPI_OFFSET)
 		msg->data -= v2m->spi_offset;
 
-	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
+	msi_msg_set_addr(irq_data_get_msi_desc(data), msg, addr);
 }
 
 static struct irq_chip gicv2m_irq_chip = {
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 8c3ec5734f1e..ce0bf70b9eaf 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1809,17 +1809,10 @@ static u64 its_irq_get_msi_base(struct its_device *its_dev)
 static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
-	struct its_node *its;
-	u64 addr;
-
-	its = its_dev->its;
-	addr = its->get_msi_base(its_dev);
-
-	msg->address_lo		= lower_32_bits(addr);
-	msg->address_hi		= upper_32_bits(addr);
-	msg->data		= its_get_event_id(d);
 
-	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(d), msg);
+	msg->data = its_get_event_id(d);
+	msi_msg_set_addr(irq_data_get_msi_desc(d), msg,
+			 its_dev->its->get_msi_base(its_dev));
 }
 
 static int its_irq_set_irqchip_state(struct irq_data *d,
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index 3fe870f8ee17..a6510128611e 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -147,22 +147,18 @@ static const struct irq_domain_ops mbi_domain_ops = {
 
 static void mbi_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	msg[0].address_hi = upper_32_bits(mbi_phys_base + GICD_SETSPI_NSR);
-	msg[0].address_lo = lower_32_bits(mbi_phys_base + GICD_SETSPI_NSR);
 	msg[0].data = data->parent_data->hwirq;
-
-	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
+	msi_msg_set_addr(irq_data_get_msi_desc(data), &msg[0],
+			 mbi_phys_base + GICD_SETSPI_NSR);
 }
 
 static void mbi_compose_mbi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	mbi_compose_msi_msg(data, msg);
 
-	msg[1].address_hi = upper_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
-	msg[1].address_lo = lower_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
 	msg[1].data = data->parent_data->hwirq;
-
-	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), &msg[1]);
+	msi_msg_set_addr(irq_data_get_msi_desc(data), &msg[1],
+			 mbi_phys_base + GICD_CLRSPI_NSR);
 }
 
 static bool mbi_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index c0e1aafe468c..3cb80796cc7c 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -87,8 +87,6 @@ static void ls_scfg_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct ls_scfg_msi *msi_data = irq_data_get_irq_chip_data(data);
 
-	msg->address_hi = upper_32_bits(msi_data->msiir_addr);
-	msg->address_lo = lower_32_bits(msi_data->msiir_addr);
 	msg->data = data->hwirq;
 
 	if (msi_affinity_flag) {
@@ -98,7 +96,8 @@ static void ls_scfg_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 		msg->data |= cpumask_first(mask);
 	}
 
-	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
+	msi_msg_set_addr(irq_data_get_msi_desc(data), msg,
+			 msi_data->msiir_addr);
 }
 
 static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
-- 
2.43.0


