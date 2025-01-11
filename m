Return-Path: <linux-kselftest+bounces-24283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24462A0A07C
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 04:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220B4163A4F
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 03:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0566315C14B;
	Sat, 11 Jan 2025 03:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JIAEpN3N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC215534E;
	Sat, 11 Jan 2025 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736566380; cv=fail; b=ZUd/eCr4syivoCDD5Hg6+aJ6oN9qdkVB7FwFtXESFJna7WYprUVfVHBD6/YuZTI9la4q9aHaiF5mHAD4BvDxuHjgEPTePkOJ5aSeYjnpa2dg8nkLuffZaxneyJ9WFH3eFmLxH3SNAY0mJ4N5zRRjyho+GFhWvTLPMnAh5EuJoZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736566380; c=relaxed/simple;
	bh=OPenR7iq9PXWKmdGbCekpBSvlkDuJo+cuzyFr7kNCxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eov5S8fpZif3CdDMWcKzNs9+G9I4afgWKcF/E0pZL/g4Oiq1m1iYblysouFlWJd/Qbvd9NPa+ZjR2lnyefvloLo/PKBbYUwI7I71PiT8MvkVOZs6Ry+1hTKMz7bbxYynuecNbe7bNVDGPEX1UYAN3+KJAjnj92la3vxZCfvpYNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JIAEpN3N; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPVvCOy5SLU0a4eiazDCi15V7EmVV+1PPRCPAErBGV4Ej5y/zm6C6LqyuLAqtzH1ecrNMInu4smyy8LHrPfmnOnwDteon7uUXoYtiVXm7Ug+9soGe1geZSZ6J8lmGMBEvu8vB8P2RfJ77P4NKFzC/5vGhomkLGWzqxWHJ8V9N/8ds7ZVVvHyff+SrT+0OGDiGvk/0Zmdls/GvzJCPD1RGEFf+/cB2QukTkTKXZ+/DeaUZyFIJM+9wKVbbK8i99BBPgdHrCd5rtiQeV6EuVC1nroySKD8DodFheyP8ooIQy2rJxreaPxRjs3+ma3qgKoBc06qes+rxKPPUxniJVwE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoXekFxtbvtfkYYjQ86gBLmp2tdvWSiJ9hckxytv87I=;
 b=Ssy0n/AYCejr5Q+oPvKoEZ+gTMlAUTwyLbmWDUtRb6Xer7Kf0c400KrqxLOVQYIoE8+N7qTaPOOgnHtsf9+caX4dr5TgN2rrkvvdxh+B71nwehsF5vM9lNHvkRQ3CiaRb9jVKv+AP7CVe5PEZHKDLu2daGCsfVpJFa+dBNqkd6BaOB6zwU65kIz9uBaodFs0ckgDYLueqw1SIp0tk4C3YLq+Kzz/zFAlxxCyiyJ+x7srkihBEESw+hJvTdcMdZ3TiCcyD9bGjl+9lscq2hS7Ed3IcVUaFdAISLel3dzCdDQ1MV5OWox+vVAntl9KVpj/IJL7TXoBOrvnY5r+3Xi7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoXekFxtbvtfkYYjQ86gBLmp2tdvWSiJ9hckxytv87I=;
 b=JIAEpN3NybmygG0uOMPYUNC2CO9Aq7lJazBhZ4tB1kOBec//FVlM/dmJbwUXuaElm2GJ0zFpT6Y/OgRNRm2GOaB101O7PVXu3UW68obZoUclqJbS38ZAbd8KG8jFMGzHRQHRnUR0DRxHWRkY0/Ro3/jtcir/JL4Sve1DP5wvwQSJGAPpFlvvasSsN9SWNjM4qsC+JQiR/4H2PtYhVDBITNw08yoXVfobvxtTJzAsQ6mrUaTHPMGp7InftwFpuvfy2daWtzwzfJXL7A9/WsP4hpxF1HGnomVQdlhljkooaoG3tee6Ada8pNR1cBgFLP8OsCdXu0wr1ybrDalyvSFCvQ==
Received: from DM6PR11CA0065.namprd11.prod.outlook.com (2603:10b6:5:14c::42)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Sat, 11 Jan
 2025 03:32:52 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::70) by DM6PR11CA0065.outlook.office365.com
 (2603:10b6:5:14c::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Sat,
 11 Jan 2025 03:32:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Sat, 11 Jan 2025 03:32:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 19:32:52 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 19:32:51 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 19:32:49 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<alex.williamson@redhat.com>
CC: <joro@8bytes.org>, <shuah@kernel.org>, <reinette.chatre@intel.com>,
	<eric.auger@redhat.com>, <yebin10@huawei.com>, <apatel@ventanamicro.com>,
	<shivamurthy.shastri@linutronix.de>, <bhelgaas@google.com>,
	<anna-maria@linutronix.de>, <yury.norov@gmail.com>, <nipun.gupta@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>
Subject: [PATCH RFCv2 02/13] genirq/msi: Rename iommu_dma_compose_msi_msg() to msi_msg_set_msi_addr()
Date: Fri, 10 Jan 2025 19:32:18 -0800
Message-ID: <242034456c0bfcd7ecf75cb29d8e5c99db0675d6.1736550979.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736550979.git.nicolinc@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 229d0163-a0d3-4d97-53de-08dd31f0a186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PrOtRRaXbwLyEfxBH44VbUhqWRxIQMYi+Mtd5AyyejoJty/VSjeCPaZmCOBk?=
 =?us-ascii?Q?T5XvtJbe4O9Wbct5QI+Lig6owbA2JsITITUkKkDRBwkggKWouMsVWDdsz0h5?=
 =?us-ascii?Q?uCsMq1GKDMmbQ4/cxhha5ozmmoRySMwtB1ixJcsPzCExlnxCvn56MX2kGv3V?=
 =?us-ascii?Q?UyAAaFe3ja3NNNYoZI8e70Q9RhbLJ6vS5NAmFghARUO9rWjx7dQHfQv0KS+Q?=
 =?us-ascii?Q?8ViJAfmAkGDli0XKsGriFqy5sxYeDCK72kG5fLKdUzXvkh/82wYBl4YdqlKk?=
 =?us-ascii?Q?mVav6K7yzO5bOnhv8dcGuaOaLxIDZpm2gOACOudGZHfeibiQei/mJyV8hIbG?=
 =?us-ascii?Q?Yc02DebUuKVHoQW7qDcVr+zSg8cM5HqdqZumBedZ+GQDJBFd7ulMEN7tpwuW?=
 =?us-ascii?Q?mXDAcyOAH0jvTuJ4d8QTbQNv4BdYfahBzYkPbdT+un9IA2Dv5Fd5reTtGp4+?=
 =?us-ascii?Q?5xtQqLKDHSsbBB199lYH9dOBrW1Gu99McArmQG/jfvuMyM1ai/xTs5drfEyN?=
 =?us-ascii?Q?TAMJbdwxPApLm7INaLxVwd/bDarHU8la2gAcRZxDFqvrIIx6pQFa7UBG6poe?=
 =?us-ascii?Q?dTLsoDxha3VORhWkt5m9fBPUn5E4JL7zqzZijvQgWnAgNF5IFFMI8ZJ926sx?=
 =?us-ascii?Q?aTPsl/Dw8g48hM39NNkQOwUDXm06rhhTReeE8V6euQbEWbEorZCbZT8tizJF?=
 =?us-ascii?Q?wRYKyevTEGNq5Ys+bncS9NB5U9icT8qDYuG5gx6GAnOKHcB8A6SDNEyraxzz?=
 =?us-ascii?Q?Jku/sRtYpKizzq1Uqknwy/ZgXP1rnh2BczN/5yV99bqAw6nfQ80sI86kYiCe?=
 =?us-ascii?Q?PJj941bWfytr7fDEPhI9+dVDD9B6XqL9FOIfDDoFOvtpAFwu3niQTH16JaGV?=
 =?us-ascii?Q?K4ZTkpon2sY8ptzv0TQXq7SkSM8qOdZwQ4brC78MXTe9n/nAasXM5sOzVToS?=
 =?us-ascii?Q?AFG5cdvw7tXTLBhqhX90UpjtNAVle8/gMO9FAsfNgaRXTdykAVNsz0Qaw/vo?=
 =?us-ascii?Q?qtwdiQBCbPtMRr18rrErkXZ57jTyr+t8LWN0laiB89rIbSvI/a3cmm9jEVsc?=
 =?us-ascii?Q?tp4vPetMAJ53M5muWdxP1HJcLpjbt3lWwXCgdxUBrsw+O4JhpDFck6MCXdal?=
 =?us-ascii?Q?H38lHAxyXq10CMsJ5QFu4ZnEbwTBKpq4JrCUcEXiKhDxBeueAGgU1dCvMwiV?=
 =?us-ascii?Q?Hp6Pz4Jh8DXPs5TojkxEZlRKNW2ON0f2YmpsdlMG0f7GenmpLc38PSkhX+Ml?=
 =?us-ascii?Q?UdzTVsNCpsci5XYL0Cm86UobrX2AlMqxjuNQY/QOn+e1uLTd60nqGRmja7U4?=
 =?us-ascii?Q?mK67vPJ8zJ/NemZ7tIy+XrJiNFvMA+CMCSILwsxqrgN5r/GzV53HVgzVg5aB?=
 =?us-ascii?Q?vE79uou/a/qEaIvIgv3EkXzD55TqLy15ogHZS0dLgNJqNX5ql99yAWjJh922?=
 =?us-ascii?Q?pF3tj7gAFey7znj7SYBcovZ0VvdLZm1wwcAjTBNFKWeezVCbU7IvmltsQbSX?=
 =?us-ascii?Q?9JWiiNYUB1EfYGA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:32:52.7075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 229d0163-a0d3-4d97-53de-08dd31f0a186
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279

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
index d442b4a69d56..f6369748fc6e 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -296,13 +296,8 @@ static inline void msi_desc_set_iommu_msi_iova(struct msi_desc *desc,
 #endif
 }
 
-/**
- * iommu_dma_compose_msi_msg() - Apply translation to an MSI message
- * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
- * @msg: MSI message containing target physical address
- */
-static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
-					     struct msi_msg *msg)
+static inline void msi_msg_set_msi_addr(struct msi_desc *desc,
+					struct msi_msg *msg, u64 msi_addr)
 {
 #ifdef CONFIG_IRQ_MSI_IOMMU
 	if (desc->iommu_msi_page_shift) {
@@ -310,11 +305,14 @@ static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
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
index be35c5349986..6599c56873ad 100644
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
+	msi_msg_set_msi_addr(irq_data_get_msi_desc(data), msg, addr);
 }
 
 static struct irq_chip gicv2m_irq_chip = {
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 92244cfa0464..8c3ab7b471ca 100644
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
+	msi_msg_set_msi_addr(irq_data_get_msi_desc(d), msg,
+			     its_dev->its->get_msi_base(its_dev));
 }
 
 static int its_irq_set_irqchip_state(struct irq_data *d,
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index 3fe870f8ee17..513479da9ee3 100644
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
+	msi_msg_set_msi_addr(irq_data_get_msi_desc(data), &msg[0],
+			     mbi_phys_base + GICD_SETSPI_NSR);
 }
 
 static void mbi_compose_mbi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	mbi_compose_msi_msg(data, msg);
 
-	msg[1].address_hi = upper_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
-	msg[1].address_lo = lower_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
 	msg[1].data = data->parent_data->hwirq;
-
-	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), &msg[1]);
+	msi_msg_set_msi_addr(irq_data_get_msi_desc(data), &msg[1],
+			     mbi_phys_base + GICD_CLRSPI_NSR);
 }
 
 static bool mbi_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index c0e1aafe468c..2ac6d89b4cb4 100644
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
+	msi_msg_set_msi_addr(irq_data_get_msi_desc(data), msg,
+			     msi_data->msiir_addr);
 }
 
 static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
-- 
2.43.0


