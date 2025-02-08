Return-Path: <linux-kselftest+bounces-26083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C09E2A2D4FC
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 10:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A63527A4FA5
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 09:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E0F1ACEC2;
	Sat,  8 Feb 2025 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KGLIrns0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F56193409;
	Sat,  8 Feb 2025 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005405; cv=fail; b=Rh2MRpjyBNI9Tua5vbk3Zf/mWOdlVeH+xDCd+wVVmAHIIDi2fzazEUA47UtVhjsR32PJ03aYCbiEI/4KdjIhK53+F0JCrlLlQjZP3BHKIGa4gAHJy1D7e6jaAA1MlsFPBGrFiRX2pbsIRXwDdpNCn8pFC4L5fk6LGNIU/mGqyXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005405; c=relaxed/simple;
	bh=BNdbbSbv9OrtS2hCSH3nybgZ+lBq0j3404HiKupaoMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afGEcm1hONKnrOzE1ykQtJOHclce27nwJavix/jguaWeEjp7mibdCxC5xYQu4+DoWxNfWaUwOKBhxF7T8UyrofVLmnzhD5sNaFgDXio5jYFQza9DAFR2DmSNUDtgmt7XBQaAIU5ISQuUuj0rJ6mJAbZAUXZQpOqZZgNuyPXO5e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KGLIrns0; arc=fail smtp.client-ip=40.107.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vP3qInvAqh328CWEomHFRSmq1WQ6pf7T1Ml7xtlVu8SLmPZiVuipWCbn1ddgPstxuWMpl2RDFYDsdvrg1PZJApEvBphjVPXj30lJEYgjDmeJGPCXqMoDZ8ZXcdKWhi66zGIlesO+ATdf4tbp9RP6BpSlJXCH9RqeBLZJLvU72FZ5zoYFuQ3grAVqbvv0iLAwPuS7zqMgQrMPfecLfZe3xaYKZCep1869vi/oCbWMmBeVbrzvRdwCAkjjiTcF9YFc99MJzwdxoiYAJcqeclzOj3W+0+5HZFtZkMn9Jr587PepK19d0ZYTgqaTPHkQe1Ev9mdXnU/e/j+Wap/qkWoPWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrA4NV8KSAp6zZlWHeyC2D5XulxCay2sDL5iQTDGCvg=;
 b=M2zci6KS4kDcF+jGGbSLbfTqAdX1pAybXpRs6h/eH8S20+02XqFe1zzYQgd5lhdYzMN5ZvKUORO7QH2gmB4VqT5ASmzNTdHezrZ6eFdlPTmwEa1ZkVqIk/IztFCKgQqXd4SloKQhr2kQn+TDhxxKgvso3k0xNSefLwKFWJ0baDpQoGUp6U4vY7//ctBWFo6VbXm6wQH9j71BP31u21Z9xHUh57LvMwafFgRudXXmNYfZj9zJQezpsZ6w6JKEyRFpyL8bWY/VhKsEfP+pGi9X09sfy8eoLBNdip/fmiF0yOgDMGc8YFBOvpzdTbLDYZE4Y6DNRSPbPNKaN/ZnCEj5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrA4NV8KSAp6zZlWHeyC2D5XulxCay2sDL5iQTDGCvg=;
 b=KGLIrns051f4TtYJaf1MbnoQnomnP6IiJzN1s0BtGJ7XH7M2rZ+J0AVIAute5/wUciP2USkQyihGzxU8CIIichhFddInsU7JQVKFYKoSN/7p3Wp8o3Kj8qNd2wndtmdtjAcpdYX+sQYaeGbvC03wRz7GZ9GmNViXnl7iyjjhz3sTV6Sqja9ls4p+caL0IOFOxT2T75VSqYDG/PvmNCBIhqoGnHDCdk9tsJtx59DOhNjNAd38mapN2ntcYrLdc+gDPTucoe28P1PRAzAFZ99VMydLEkvR4aCJi/W/qaoJLG6/oWHwpncKwdmxQbIU1v25KBVenaOcPhV9bfZPEF9PLg==
Received: from BY3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:39a::28)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Sat, 8 Feb
 2025 09:03:19 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::d6) by BY3PR03CA0023.outlook.office365.com
 (2603:10b6:a03:39a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Sat,
 8 Feb 2025 09:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 09:03:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 8 Feb 2025
 01:03:09 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 8 Feb
 2025 01:03:09 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 8 Feb 2025 01:03:08 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v1 02/13] genirq/msi: Rename iommu_dma_compose_msi_msg() to msi_msg_set_addr()
Date: Sat, 8 Feb 2025 01:02:35 -0800
Message-ID: <0cfaefcc104e29aeb031f316537249d8d53ef7fa.1739005085.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: b01a3f0c-5187-4d92-910d-08dd481f6e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zr6YnRjXSyaAPik6bbxt9b6SIG7ixQ4++CWb4ZMIoSrXkc9X44WBE/Z2fW0P?=
 =?us-ascii?Q?FODnbsdNX2N5wl75aw5+9o9zUzUAFT4skEOiGN3xBea6jcgt5MbnihDJCDoC?=
 =?us-ascii?Q?DjQRrKKImRsNsh2eoTqtfGW0pAWrJdPKhMFgAxeQxTU+a327L9l8ARRYonbO?=
 =?us-ascii?Q?HdXiTJWzCR0WnoDQhtPfm7oK5EMCIGFLmQVfnMD0eOwsVktx12VmdOddb+pX?=
 =?us-ascii?Q?WgIc3JPLYPGX1/wTbPB4ZLN5qWlGD4xjuXnl5BZK8Hs6z6EVwOauj/ggRiFY?=
 =?us-ascii?Q?r27hTB7CXtMpjdv3/S5wtU3Y/Vj3GcAw0qLCfTqiyVnx84eOc42Nk5PISskl?=
 =?us-ascii?Q?/Y2flSFpP09C4hwF5VRQe2coLPRzMcMTir24M8eRGRVxfi4wnjOAgaC0fCW+?=
 =?us-ascii?Q?NR/aOV/FvX9nQehy1B9s6Qc571ZNeM6g5GA0AvkujrW8lwPsyHbZ6mdQIu1F?=
 =?us-ascii?Q?bXmJvJ4aiJc+eVRtmoX2P/0G7FeZdkc5Eh67vYMPdmaiinViBYmTMJUa4Rhw?=
 =?us-ascii?Q?t2gz+Q9eI/UJ+1GVhejLMMnBUDpYV1ceYZ4FwLXNknGCJpHiMrNQ7RDhS7nV?=
 =?us-ascii?Q?DD3z3yjzozdxBT7OKEyL2zPQuAjUuYyMskdEZLrKjhWVS6dYHI1P0Cg49BG5?=
 =?us-ascii?Q?LhBw02TrUpkbfHTIGH8srUhWARn7hjce4iPAWxpM2kJt8iWSZvUtISAlBnyq?=
 =?us-ascii?Q?mSvu2370OXWzSNCtBDbKXEt1QGfMqEeujgmsVWwQVsiczKo8HtNGFSzTF+WG?=
 =?us-ascii?Q?Z0xFTEj6TY+934b8Vjk/jtleGCCWuHqnzAp22T1GP8ZeyXbV2LepCs3aTZ4y?=
 =?us-ascii?Q?vdP87qIEasmJD6hr+kwmh41npyvNzQUCQbOx4RKahvOB69M+CHI9MUlMTEI6?=
 =?us-ascii?Q?IuBwXumgZYtsvBZAqbsW8plk1KE6cxDywSRmDEJowwsW+PPsD2W36hAMrMsp?=
 =?us-ascii?Q?IiokIcoTswnkMxaMU0/WZ7kqhdUxuc3lq0diifB4EwcBx4t5ZgmPz8pUH9Ao?=
 =?us-ascii?Q?dLneLaIKQ0OZZaNbLJaNDswcDEmXWEcYVbeLKmpxyKFrR/qv0NMtX9PqGck8?=
 =?us-ascii?Q?Gw4qay1gpMbMVvbRWirGm9+nsflg91PbpYqNOeRPkR8n4yD00VHZJ9o5LiqC?=
 =?us-ascii?Q?nCNEzPxDE/OcALOunIaSNgGwK2XxlZ3o2Px57JlofLzOrir8pdNxS6c05S/w?=
 =?us-ascii?Q?LHUkSs0/Qo3sCngsfgsQNOW2zrMTv9kqGKpRZjDCrLSW450PFtP0l1BrAJU/?=
 =?us-ascii?Q?zEuYJnEufPFtEFChJtut2eFjG0erur0RK5uRH94CV7yVFjhRUsCRsQEpnbAQ?=
 =?us-ascii?Q?Xmie0c2x3HYz2NKS4JTs2RnH7+QrOQO54WORS2sRhAAu7tZDEdKrg5KvNlHQ?=
 =?us-ascii?Q?xFBv2OlO56xAxXTUNwZaXItoWNxqhaOyYLOqynZlokTW8vXMcPOuBRxdQmRi?=
 =?us-ascii?Q?/d4n6WKTZsIf2lep6iNrCOoU9DUHEGvuyrjofQ6EmFWTqjjIQRTZEEEZU7BO?=
 =?us-ascii?Q?zQzAZQYlVtwLkFI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 09:03:18.7908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b01a3f0c-5187-4d92-910d-08dd481f6e5b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294

From: Jason Gunthorpe <jgg@nvidia.com>

The new function is used to take in a u64 MSI address and store it in the
msi_msg. If the iommu has provided an alternative address then that is
replaced instead.

All callers have a tidy u64 already so this also consolidates the repeated
low/high code into a small helper.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/msi.h               | 18 ++++++++----------
 drivers/irqchip/irq-gic-v2m.c     |  5 +----
 drivers/irqchip/irq-gic-v3-its.c  | 13 +++----------
 drivers/irqchip/irq-gic-v3-mbi.c  | 12 ++++--------
 drivers/irqchip/irq-ls-scfg-msi.c |  5 ++---
 5 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 74c6a823f157..2514116fa5dd 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -300,13 +300,8 @@ static inline void msi_desc_set_iommu_msi_iova(struct msi_desc *desc,
 #endif
 }
 
-/**
- * iommu_dma_compose_msi_msg() - Apply translation to an MSI message
- * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
- * @msg: MSI message containing target physical address
- */
-static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
-					     struct msi_msg *msg)
+static inline void msi_msg_set_addr(struct msi_desc *desc, struct msi_msg *msg,
+				    u64 msi_addr)
 {
 #ifdef CONFIG_IRQ_MSI_IOMMU
 	if (desc->iommu_msi_page_shift) {
@@ -314,11 +309,14 @@ static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 			       << desc->iommu_msi_page_shift;
 
 		msg->address_hi = upper_32_bits(msi_iova);
-		msg->address_lo = lower_32_bits(msi_iova) |
-				  (msg->address_lo &
-				   ((1 << desc->iommu_msi_page_shift) - 1));
+		msg->address_lo =
+			lower_32_bits(msi_iova) |
+			(msi_addr & ((1 << desc->iommu_msi_page_shift) - 1));
+		return;
 	}
 #endif
+	msg->address_hi = upper_32_bits(msi_addr);
+	msg->address_lo = lower_32_bits(msi_addr);
 }
 
 int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
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


