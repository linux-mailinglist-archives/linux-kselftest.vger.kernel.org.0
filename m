Return-Path: <linux-kselftest+bounces-27025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E551A3CEBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 02:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64AA3174492
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 01:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE061BD014;
	Thu, 20 Feb 2025 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V/Kq6p2W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD131B423C;
	Thu, 20 Feb 2025 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015170; cv=fail; b=lu22U4FnBegnDv09wgp3y/28l8ecMtj0ZHs7DvCzOyxnbhY8GGpbH3VjvCQf7TRB3QK/P88jWahWfp17dLd3U0fUShNIAJdBM2djuC+evdeFycmTuJfzhvREooICXgk3wf+9u5n8gjPJX93ST8e9mQz1DFzEgO4CSRv0f4PnYsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015170; c=relaxed/simple;
	bh=S1N40ijNpT1M52Ue+nckB7YlDAu6mkzfcDCSlZSdh9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2k6NmAcVlVD4bOIwkMxtCqiIbYup0un4xr8INFVN1QLsg83RwbsK1E1u54QIMlYIn/aESDB2oGat7NcQLU6CAnSZS7MUe6CVhQACtaMgK/BiSxXy5CtJsWhosy9hYWDapHUvS5XZZGapYdtjMVIsXdr0DuaN4ZlUjNVsMQSTt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V/Kq6p2W; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GR4o5bO5B80QyWGeau2fLSxNg7Sy5gRhYbz5O5QfDOOc4DWRGbdHsz3Kf1/zOZR0HgBqxNxJOgj22/PASif0/N2Gs3wIP+TQLNx/lxoQsFFE6dI6Z/19Tq94ksIznCu6eNA/4xXYfe+h6S9OnDiznFNjVhGAj6JlfB5JFQ3TVHX6syRo8oS50gkd5ohYRxZ/nUY2nJ7Bvsa23SbedsPCT/abWwzo/oGAgWwhUlwumsshGVbpYYqtRva+4qKkcrSCC0i5kVfBlNLa2p5u6GYxd4EWrYBbIk7cLHKtLClVk9xcyIsFJFqaZbrLvayp2xbHHJcQzB2n6sc+P4nwwhkCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hltEhC/Ni2tofAujAiDplwnRbpxA/bRs0TC1SQz9kPU=;
 b=M4TknsT6pF/OiNfbd7a9Nr2CiBvhljdkYeHIKfNPK7EpSZCMG0aGbm0nghJ4ivaHidcQ4zl4YVSje7K7KABaaYSchYUoQX6NePCuxf/PXpbb6BNM7sde1wZTGMNMhiM5bWAmRXA7aDK/3a0vA7lcpyoGFxcfvQPZu1kuuu6WizVdiMnYlxuWRFswototAqVJVnyGiYRQaB1AFwnvLiDErxe+mA11p+NjhHnrM5LZN4GUuntucYraNHH+m7gVcr84oy/Z0kO3C4MtZ9Slczy/8Xzkeb5tMrAfdn5o3LjFvsL3nI6oJbRPWncL/iQ1sMiFU83vGjmVO2/3X8uMFYqDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hltEhC/Ni2tofAujAiDplwnRbpxA/bRs0TC1SQz9kPU=;
 b=V/Kq6p2Wkg6goXDhtTt594jkmYy+TLN9moYbsYzwKh5ZJ8KFz/rqPNa9QczBGCGn5fa84Oxn6uMXueTigD9mGkSv5enCpjGKmF7o1JHA2fm5gHyR9Pq0jUCU2Xh64RxpcLToM+bpBnDkQTTMSn7yG0efTrCvAlGZVT8ejAqDMQYeGi71OnlL9BidIbhKGTKZSf9FNrJsfUamxLfMVkLYbGIGA1b2YAIpqG4WUhnzjs5hMEIZpu1vhqrwej2TQFz4QBYDn/0F4Vp34fiWobAiHaxtYQYZSIRhscU/vE0SxMhe3a/9f9dHqFpVQ5xAL7UypU7XFxosn/A1rgRwBmQjxw==
Received: from BN9P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::9)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 01:32:41 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::82) by BN9P220CA0004.outlook.office365.com
 (2603:10b6:408:13e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Thu,
 20 Feb 2025 01:32:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 01:32:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 17:32:29 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 17:32:28 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Feb 2025 17:32:27 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v2 3/7] iommu: Make iommu_dma_prepare_msi() into a generic operation
Date: Wed, 19 Feb 2025 17:31:38 -0800
Message-ID: <4ca696150d2baee03af27c4ddefdb7b0b0280e7b.1740014950.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: f6cb1a29-c367-4b61-3875-08dd514e7790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3+apWHS3GC2fCsCKl35P0kXw2LcF+Abf4IPeWzaKwB7ou59i6eoDK6lWv1Xl?=
 =?us-ascii?Q?E0NpowA1rCa9kPxljzRmblt79VrKjNuvgTuifwaNq75JgRvMvk/PmOjb5MYN?=
 =?us-ascii?Q?wx15YHzGjCYFC2slWBUnpobBDX1ZSyS+Dde/xZ0mnTvs8oYioJhOJahZX+6x?=
 =?us-ascii?Q?nUb3bEA7XmFG3TVRwktO2yAoW1Qrv+LsPOJ4nHju7KBjaYMi6kNnXvDudsrz?=
 =?us-ascii?Q?phSsWd5n1HdE2Wql7skch5OS3ABfsQ7IBsdKCstpKiFab01AXI63yXLvx3hD?=
 =?us-ascii?Q?+bEG2kosyZLHLdJpQeeXNjyGU63QqE8yYGlK2z6nM3emrbbEFCUCS6hbiwnz?=
 =?us-ascii?Q?bB5mTRhOMfUHDSDyIQlekb61B8HLBdxgBy5LypsrItJ6XMY/cJYVxhFSaRXx?=
 =?us-ascii?Q?OUZieNi6VRuWBxuDW40z5Kl2EXJh3ZI6zklruDlKH/fs82+rxTH4CA1jEj+S?=
 =?us-ascii?Q?VHRJlaIe024jwqpRoj5ynJVVKSehuTPJ7I46Ntcw4Zw3oVgLauhtCQ9D3gBW?=
 =?us-ascii?Q?TiB57o4Wmwbja7H/G9QFrFZV5VL4JNqREXnmX+4hes+1AFs3C5yDhweZxr87?=
 =?us-ascii?Q?aOd1AJ0SysPg3TcR3zQmRCav867jk+5LlWWzUBBfEHwKei0NKsNntd1HCtjE?=
 =?us-ascii?Q?SlAoctDzz6bhOZRq7Qt2GyTj7jPQeLdWEMX1SCCdW1gxuvdssJwgCDx94lJr?=
 =?us-ascii?Q?CEGe1ejyKd0QKk9NJGeWVlg8L6Tg/xlKXCEWoyXqFoBeCNquammdWglZQXzd?=
 =?us-ascii?Q?zUFhhASxdth6kEb0d7SyLWV0RdRyOMU3sXG1ZXIBVnPyzgh5HxABB0zoguys?=
 =?us-ascii?Q?KfXk/CVr3xBCVtAErIOByoKz8TuXTonttsQRifJ4b8DJI3bbUTG3lyxoRucE?=
 =?us-ascii?Q?nc+boEb8Dbe38sGdFphJp/AR1LH3Y5II+HaFScf4XWtY0lfMzfyt1Z6h6VNX?=
 =?us-ascii?Q?hAxi0EkGCsxc/oDiF5OXfafncIe0G0rpZXU9kLRe1fnljgjOjEphDyP02RBh?=
 =?us-ascii?Q?iOdpY1FpzI6VnHwoZdz4v5jE0A6MjtHrYwiyLx5mpQCdpRBEbZtcDr/ekBfO?=
 =?us-ascii?Q?S+rdyJdNITx7HmrPiqZsaogbc+mSXki58X2BypJMG2WZyk5Bu4BtxWZNSiTt?=
 =?us-ascii?Q?HkNxDNoh5Ckd/ECglaObHolDfBkxp+xQPw1uCmwnIJGYBxueryitYd3M+Tbu?=
 =?us-ascii?Q?TpA/cbEXvQipwwztzh+RXKupczxLPwg2dc+Mb1Cf4XqZYuLA2/HeW2u9wQtz?=
 =?us-ascii?Q?bSpW4Q2hAiSJB8Itsc7FPhs8OfYsrKP068TNVG71q59uqCMMyQNO5tVObwyd?=
 =?us-ascii?Q?z+axwHPsp87Ei+0CQ8p2XyiMbvMLvIa1INdHd2nrwOJfjn6h1/CRB+lspr/E?=
 =?us-ascii?Q?mMbeVYboJzI/oZfNX93M7h/Ec1/+v6L0z/3LlpplSAHW5TI2O2AAc/mpFW+6?=
 =?us-ascii?Q?CGqaiamoCUOMPv4PefGvPXBCz6lPeqbR0RSyhLrxaV6YumHmTcjMwhr3jZ1D?=
 =?us-ascii?Q?ZUBs2/uJnjvm13I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:32:40.9686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cb1a29-c367-4b61-3875-08dd514e7790
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972

From: Jason Gunthorpe <jgg@nvidia.com>

SW_MSI supports IOMMU to translate an MSI message before the MSI message
is delivered to the interrupt controller. On such systems, an iommu_domain
must have a translation for the MSI message for interrupts to work.

The IRQ subsystem will call into IOMMU to request that a physical page be
set up to receive MSI messages, and the IOMMU then sets an IOVA that maps
to that physical page. Ultimately the IOVA is programmed into the device
via the msi_msg.

Generalize this by allowing iommu_domain owners to provide implementations
of this mapping. Add a function pointer in struct iommu_domain to allow a
domain owner to provide its own implementation.

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


