Return-Path: <linux-kselftest+bounces-27023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 741F7A3CEB9
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 02:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF91A7A5294
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 01:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC4C17580;
	Thu, 20 Feb 2025 01:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D1/Mwj/K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036E210FD;
	Thu, 20 Feb 2025 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015163; cv=fail; b=DPuXULEKxMTGSDMO36bTJEW7qP3lAfojoFh8CmzX01vpJeFi7remM5ouaWiilm0Dgm7Rlfxh6dF6a2tF0iNlbuXLZUllHa3LZbRsAOHYLVZ1sPMiC3hVAmTMRfCKikQMImGdFFgbqL7W6Cg4TqvhwMpkbDOb8cnNgCgXg/CPc58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015163; c=relaxed/simple;
	bh=S2SdK0MTte0Cb6mmJqrvA8ZVY2SB9SKSYB76I1X+DSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T87eEELLV7PkIwsF+pMNLGC62utjiPDTfaWJ6ok5H3FTURooCxteZK2RL0pRwaw56+BP9GPCLBCTfI9Oit70wn+2pEGK+pxq29mJDBRa7ZzM3jE5lA0HEjJQBMpakEv5/f4TKxXYgOOFC6R3MRlt1F0mFY5aICGQjPXD/bSgYKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D1/Mwj/K; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wx/0n5l1YGnyl7TAWvca5ktddeSyDC+h6q9D10L9IQ93155cR6fGqgmduUhL7LHc5HfQu8CHCIwYYNSqC+OdCWT7XLysARne3jSiRdqe5ROwXdnNw8Cw8HtSC5CGClvPDI/ytHPljOiuUGhImNkEv9gIlhVUOjwnexdd12a7scbH9173O9XPMiuka5HoC6CEP2NE5UmM5JkztYTZgYNs83ZG6tChwiep16194eG4dcsckZHL3juhfI/Z4nfKs96y4szk8YJZa/p3nMIRdUYXQlVl1kxVYXucrxzrLqA7acsi1PgF9GT2OrrcyuujxgI83eIBttf46o0CCMlebakZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cloKWW9jMzqlnw9LE3IZ2506cu6X3dyLx5BhynAxX/c=;
 b=XvRCRT5Mu/5Wm986cjQEjRtt62sw7koDmvoNp1+TmInxhvGPzWhWKYIkaCrNC9zZAU5gqREi41IzZN75jhQ0Yg9k5PcHM0dzsEDMBhQkzos8HMYn/maEUzxdh2phFj4RjzaVJaCgbJX0r0gKAl9q+vx3Hfv9DEgkupuXHZ7Rch6qIXVXBk4uMN+WrxvO8aEYdZzRjShp4wT8bEjl+xiJYuJ/y0pzdKkDGSLfnMVxsNaFmLXprP74zAk14tkl+Z03eafFJyQ2NdPoCTSv5B2XXUE8Bku8NY0iBOYEUqYwc0hRAGcjNVSfilC7jqqpTpVmIXJUDopUQEHZo/M/WRar8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cloKWW9jMzqlnw9LE3IZ2506cu6X3dyLx5BhynAxX/c=;
 b=D1/Mwj/K3uWbjSQ6Qmy/eilM1XTI6m51CtXLIt094fWdUSq18EXH1YMRO5APJNyF0bX+Al3ep8dL2c9y1ntUTcICxSLaM7iRwwXAEjXMv0BVfiqnBmT1Is8FbE4BDT62TIH/gP42o4qf9+HrSugXDY9HmmGz5vaWoACx7WTQAtCrY9uR5saFctO7g9kKxx0kFPH48EDJis7obLzoT/uW3DXQ6BTwUjtDlUSDD2zFJm9Vwwo1CSoXwbmZrCtjLdmSr2W9bZMVPXldPXnll14i2gRjj+nA1dq6F3ehfKB2gz3cSv9w2ELBZHhYLCR9yzZEdf8rTSrjkPJi6sHXDI5cGQ==
Received: from MW4PR04CA0250.namprd04.prod.outlook.com (2603:10b6:303:88::15)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 01:32:36 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::2b) by MW4PR04CA0250.outlook.office365.com
 (2603:10b6:303:88::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 01:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 01:32:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 17:32:26 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 17:32:26 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Feb 2025 17:32:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v2 1/7] genirq/msi: Store the IOMMU IOVA directly in msi_desc instead of iommu_cookie
Date: Wed, 19 Feb 2025 17:31:36 -0800
Message-ID: <a4f2cd76b9dc1833ee6c1cf325cba57def22231c.1740014950.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 478b3099-a180-4944-777b-08dd514e74e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Px9zYt4NjgSSbqHFQV3NlNAhDwX1npA4UWQmVuyOWjNwtx5Q7oeRQa/JseY?=
 =?us-ascii?Q?GOcC3NybH2K99zvIu3rpeUW1BebUs1CD6uYSMN/Q6seLAOCQUKwPxzae2+Ga?=
 =?us-ascii?Q?C/2dZJRspmvC/iXRF1UdhvWVOdkgYAcoBA9E3CPPHR1fJLS21FTaus63rrfO?=
 =?us-ascii?Q?avYPRYVdvA338XWh9sTz7CR1hbz/oaM0tvLn9aCabMTIkDdEjQb/2ied7KaJ?=
 =?us-ascii?Q?7xwsdzQYOp72TTHVI2++mYxnokmcIrDc1LwBQzst/H+FyOkGTzl3wBRkrlU4?=
 =?us-ascii?Q?0lL66uXAivBPUBLA3dNyRfiMVhLtkKlhn8nn4zmAbU27QRbhdBI+p3jW+40W?=
 =?us-ascii?Q?0PK1LRB4Vqqm0Oj9sbMUjhR/H445UCaUPppQOiVbfEwNb4URqxi4hCQDvgir?=
 =?us-ascii?Q?uBQ2Sey1K/3kBDgZH4KNtYmdSctEbNZgm4ZBE322DR+GYqBhzBl87LRFH+ZY?=
 =?us-ascii?Q?6UJIXtm1JkydRm7BnJGSiiJp/VmuppTDRsYxcPfm0r13iBEflteSX7U0eZU4?=
 =?us-ascii?Q?zAcCnjsi76JUHDy3gra6J+L/jrAdekSSza9mes56SE30iVQ98squNqE/hdmB?=
 =?us-ascii?Q?QqrS3FjocVyON+2VXtu4x0bGn5ubIfx/TqEvUzhSY4Bcdqcrxmr1jeff8UHi?=
 =?us-ascii?Q?LE5Slrmg9hfXY5YqhZYEYddyWUi8X3RbKtLzf3Q9KMtMpIVtuDDnlZn+HXbp?=
 =?us-ascii?Q?PL0ZPAx5VY5mg7VO6dFXKy7E5F+KBz6qXXK9BrmauS4h9iFOx/speEXmunkX?=
 =?us-ascii?Q?nkXgqjdDEfDIm1+H8f8YnUwLMhRQ6FfTgF2xKR8YPi9DnGeyaLvISFRw4sPg?=
 =?us-ascii?Q?MAPpp3/y0nwBtEvpgI+fwS1BM40RAiPeZXErkZOOyVM5Utu3gJAPcX/MopN3?=
 =?us-ascii?Q?P4jebBYc1y3slB24y2nQAo0Yc/yE2oNBdaia69FJegkyokMIsvh/V65kJzkE?=
 =?us-ascii?Q?xNDmIE5pVB/4Yd/ZSQ4zjTNa/BhAiKYDttYPOpV4Kn4VnjH8Yme/aPDUbKOj?=
 =?us-ascii?Q?JwrttF55tDmz503/BvVDiio04eLoqVn5GDUlvnfoZxI/DCfzcG7dlh0GmsIY?=
 =?us-ascii?Q?Fq9DqQuSGueEBqInP0DVLytZXeYRUrtRPotkhR3VdPBC7v7JyrG5VnPmQnAI?=
 =?us-ascii?Q?VjW32crI3vDXKB6rjlvq/vHRO8GY1oPn21oBUgrzap7q+1Tgq2y8XYas2Q6Q?=
 =?us-ascii?Q?zHzPn/d3Y9dAhNGSPj124tTieGghx3oIb4DslD3yLI/PZq+Yt63Zamc/xQq7?=
 =?us-ascii?Q?gVUx50i84VsCoWEET4c1kTYOCR6AhEESjZ6bZ0Uz5oy4DVC3RfL7AqqY2/Q2?=
 =?us-ascii?Q?+we+TtdcI4dm0Q1+XbIhhpycZVsWrvMav9lkGti3aj20448raKujofqA4s7b?=
 =?us-ascii?Q?fHx7ftMl2gxxt4WUDeGDIQZpcc/G4/Q9yYABtZLFFAoSRsBri54dKr56lLmC?=
 =?us-ascii?Q?eV0j6nyY3M3xR3uO4h6rc45E4Pb5NP3xlQYAHNYXQmJVG5b21dEJAfHWFQWJ?=
 =?us-ascii?Q?OEKq8DQe0nFpEpg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:32:36.5994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 478b3099-a180-4944-777b-08dd514e74e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958

From: Jason Gunthorpe <jgg@nvidia.com>

The IOMMU translation for MSI message addresses has been a 2-step process,
separated in time:

 1) iommu_dma_prepare_msi(): A cookie pointer containing the IOVA address
    is stored in the MSI descriptor when an MSI interrupt is allocated.

 2) iommu_dma_compose_msi_msg(): this cookie pointer is used to compute a
    translated message address.

This has an inherent lifetime problem for the pointer stored in the cookie
that must remain valid between the two steps. However, there is no locking
at the irq layer that helps protect the lifetime. Today, this works under
the assumption that the iommu domain is not changed while MSI interrupts
being programmed. This is true for normal DMA API users within the kernel,
as the iommu domain is attached before the driver is probed and cannot be
changed while a driver is attached.

Classic VFIO type1 also prevented changing the iommu domain while VFIO was
running as it does not support changing the "container" after starting up.

However, iommufd has improved this so that the iommu domain can be changed
during VFIO operation. This potentially allows userspace to directly race
VFIO_DEVICE_ATTACH_IOMMUFD_PT (which calls iommu_attach_group()) and
VFIO_DEVICE_SET_IRQS (which calls into iommu_dma_compose_msi_msg()).

This potentially causes both the cookie pointer and the unlocked call to
iommu_get_domain_for_dev() on the MSI translation path to become UAFs.

Fix the MSI cookie UAF by removing the cookie pointer. The translated IOVA
address is already known during iommu_dma_prepare_msi() and cannot change.
Thus, it can simply be stored as an integer in the MSI descriptor.

A following patch will fix the other UAF in iommu_get_domain_for_dev(), by
using the IOMMU group mutex.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/msi.h       | 33 ++++++++++++---------------------
 drivers/iommu/dma-iommu.c | 28 +++++++++++++---------------
 2 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index b10093c4d00e..fc4f3774c3af 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -166,6 +166,10 @@ struct msi_desc_data {
  * @dev:	Pointer to the device which uses this descriptor
  * @msg:	The last set MSI message cached for reuse
  * @affinity:	Optional pointer to a cpu affinity mask for this descriptor
+ * @iommu_msi_iova: Optional shifted IOVA from the IOMMU to override the msi_addr.
+ *                  Only used if iommu_msi_shift != 0
+ * @iommu_msi_shift: Indicates how many bits of the original address should be
+ *                   preserved when using iommu_msi_iova.
  * @sysfs_attr:	Pointer to sysfs device attribute
  *
  * @write_msi_msg:	Callback that may be called when the MSI message
@@ -184,7 +188,8 @@ struct msi_desc {
 	struct msi_msg			msg;
 	struct irq_affinity_desc	*affinity;
 #ifdef CONFIG_IRQ_MSI_IOMMU
-	const void			*iommu_cookie;
+	u64				iommu_msi_iova : 58;
+	u64				iommu_msi_shift : 6;
 #endif
 #ifdef CONFIG_SYSFS
 	struct device_attribute		*sysfs_attrs;
@@ -285,28 +290,14 @@ struct msi_desc *msi_next_desc(struct device *dev, unsigned int domid,
 
 #define msi_desc_to_dev(desc)		((desc)->dev)
 
-#ifdef CONFIG_IRQ_MSI_IOMMU
-static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
-{
-	return desc->iommu_cookie;
-}
-
-static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
-					     const void *iommu_cookie)
-{
-	desc->iommu_cookie = iommu_cookie;
-}
-#else
-static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
+static inline void msi_desc_set_iommu_msi_iova(struct msi_desc *desc, u64 msi_iova,
+					       unsigned int msi_shift)
 {
-	return NULL;
-}
-
-static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
-					     const void *iommu_cookie)
-{
-}
+#ifdef CONFIG_IRQ_MSI_IOMMU
+	desc->iommu_msi_iova = msi_iova >> msi_shift;
+	desc->iommu_msi_shift = msi_shift;
 #endif
+}
 
 int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
 			       struct msi_desc *init_desc);
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2a9fa0c8cc00..0f0caf59023c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1815,7 +1815,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
 
 	if (!domain || !domain->iova_cookie) {
-		desc->iommu_cookie = NULL;
+		msi_desc_set_iommu_msi_iova(desc, 0, 0);
 		return 0;
 	}
 
@@ -1827,11 +1827,12 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	mutex_lock(&msi_prepare_lock);
 	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
 	mutex_unlock(&msi_prepare_lock);
-
-	msi_desc_set_iommu_cookie(desc, msi_page);
-
 	if (!msi_page)
 		return -ENOMEM;
+
+	msi_desc_set_iommu_msi_iova(
+		desc, msi_page->iova,
+		ilog2(cookie_msi_granule(domain->iova_cookie)));
 	return 0;
 }
 
@@ -1842,18 +1843,15 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
  */
 void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
-	struct device *dev = msi_desc_to_dev(desc);
-	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	const struct iommu_dma_msi_page *msi_page;
+#ifdef CONFIG_IRQ_MSI_IOMMU
+	if (desc->iommu_msi_shift) {
+		u64 msi_iova = desc->iommu_msi_iova << desc->iommu_msi_shift;
 
-	msi_page = msi_desc_get_iommu_cookie(desc);
-
-	if (!domain || !domain->iova_cookie || WARN_ON(!msi_page))
-		return;
-
-	msg->address_hi = upper_32_bits(msi_page->iova);
-	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
-	msg->address_lo += lower_32_bits(msi_page->iova);
+		msg->address_hi = upper_32_bits(msi_iova);
+		msg->address_lo = lower_32_bits(msi_iova) |
+				  (msg->address_lo & ((1 << desc->iommu_msi_shift) - 1));
+	}
+#endif
 }
 
 static int iommu_dma_init(void)
-- 
2.43.0


