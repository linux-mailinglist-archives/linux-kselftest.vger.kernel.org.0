Return-Path: <linux-kselftest+bounces-24285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9463A0A080
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 04:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE6F7A45D0
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 03:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E2B176AC8;
	Sat, 11 Jan 2025 03:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZW7hAnev"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4811632F3;
	Sat, 11 Jan 2025 03:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736566383; cv=fail; b=RCutQYvk124yvnkSZ3HOl+yGSBqbRYUiNGMigeClDZj/Ls1i23APgw/N+SGXokrUZXRxqonpcotr60hPotZRXijZYNwmc9YUozVFkjJugDWHG/gXZAXD9VM06aY06UFYGpBUgzOFBhta8oLNhYDGwNWw/kZVBLKv1eALawsuRAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736566383; c=relaxed/simple;
	bh=jeXPlcyvTRoecCGFjAFa0oma+ZkzGgCf4uTtSQ6FfcY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2gNl0yS5K3OUZZtRPyG0kMa3fn5n/thENSu5VE94skGKFPmr9bluxjPaBUabcUENiQigT+ajI3lu6470RSrMsT48fcR3Pv09tei+sUFxIcfID2GhNie21BDsrsLgD/zcM1ONLZkHAUocvZ96W11LIL2nlSsuCYwYSiVpzMarTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZW7hAnev; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hX8x28AtExhuusdPKt7y2vwXC5UCk48eGLGsaenUvX54XiTJ3P211N2dpaaX8XYZ+t2LaC64IHuO4IpDbvwTHyxgNd6c15UnHvYM6XtJLb507CAPXTqtta5gjSL91iqW+k1tiuAE9qkkcJ5Ptj/tERZe+WfrQp5B0ioL3kcp7DIgKncKc3+TnqNfHlniTANJ1aVRSeTw4hWn3tcHz/vdKcGqW3nxKxT/j4DZVP5OjVORsaeRD8tyvt6sHaUpgHk4b5LOLt9/ptBSYuBfmwD9oDmLeysI0cdAS9SPsgPgHzMF85NGQk1Gxh1e6JyLCAG14hLLmgD2m8ac/svd/0ye9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4RXdO9T98VZAmJ7QRc8WBzWDSTzCpkvFNJ3X7tk0DU=;
 b=lJWDivaFNZz4HX8X0pUxlmjWbBYSbPxOlLvJwun/ljywAeA5ma/d1In4WBf6Co2QVPyQrcWHNf+oJgfk425tZZcOGkY3w+UQi/g/LRgBiR/uT7kfvEzEruMKcTXgAdMsYUfE7Kdy83doM18EqIlS1xO/oUU7RC3H3WZ3FSL2/e6N68JX2Wr8Yd8ITLNRpDF9k6KfUlETIYUWmgzIEVbit4dsSlM6Pd3blLO603vK2tGcip8u2nc+7tm5WhW7Dw70mEGAABe8orzz2oi2Dn5t5I0yd4IWRuKeGmD5PCHBhIf0qECpErqQbIzQ/qFFJTIHye1gBo14RHvEHckOkOWcDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4RXdO9T98VZAmJ7QRc8WBzWDSTzCpkvFNJ3X7tk0DU=;
 b=ZW7hAnevBtVDUfhQhHMyiY3AB0672VzY/Jp9TcJkcHpWnYjLD6Sd6l/pOoYBYSRwR1gHNIE3Vq1VTInrlTxZHA0JB6b7w0E4nyXOUrFwggPpX5agDajNn4QVB/YSsN8IeOD2SRKw82m2EcU2EivMVzo0QkHv3pMBBrN30b7BYYyn3gTzWt23KNvsbOxeGWqc9caIchHEOgLPVjtMxgULKaEFHm18GdFreqGUT1DqKdMnxc1v7VEyUoGvvUvj3yfHcWLIQEyryRO1HZM2xM49YjFwPxetTn8MBWt8LpnOAYsoSmUUZZBLkvdyOMPXwSKlp1hAByJOEn2CT13rejP4lA==
Received: from CH5PR03CA0016.namprd03.prod.outlook.com (2603:10b6:610:1f1::28)
 by BL3PR12MB9051.namprd12.prod.outlook.com (2603:10b6:208:3ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Sat, 11 Jan
 2025 03:32:58 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::33) by CH5PR03CA0016.outlook.office365.com
 (2603:10b6:610:1f1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.13 via Frontend Transport; Sat,
 11 Jan 2025 03:32:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Sat, 11 Jan 2025 03:32:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 19:32:57 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 19:32:56 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 19:32:54 -0800
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
Subject: [PATCH RFCv2 04/13] irqchip: Have CONFIG_IRQ_MSI_IOMMU be selected by the irqchips that need it
Date: Fri, 10 Jan 2025 19:32:20 -0800
Message-ID: <a371fbe1c68e891a38f9cc8eadf2e93d4921e246.1736550979.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|BL3PR12MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: acd96c8b-7246-4f73-1a4e-08dd31f0a493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vKA8YrTmgMJgbg2N9uPhirJCVK2Lj00HnaQWrdP9kDX2YScZ5b6I1bBUYrxP?=
 =?us-ascii?Q?ixsEt0ryAFVqvHkjbDv7nmj0+guR/1Z7b3DVLZhakmY6E13C/4Gtvv277A6k?=
 =?us-ascii?Q?g9dwHGAypNcd4XjH3kERBx42L3w1rBuych87n54PloTfc1EqSMkDX+W/CFho?=
 =?us-ascii?Q?q7WCJbxNiBrA0UFgcguunnrm+qdyLRGVjxN5otHtH8r7m+u6hdAUogs/4VUI?=
 =?us-ascii?Q?Oh8fBmbUlUxXLGt1uzsPTTzVaTGuv0VEt01JeAn9XLGH90LDCZQp/ql93EvN?=
 =?us-ascii?Q?991qZOpl+Rx9JgW34Nc+bGLp/iH+0IHB+SlRi2mZn0jngX9aapZ8J63tmAia?=
 =?us-ascii?Q?d5lR4bbPx9jR7KtcHdfZziJpXbU3AObIJzp/k+oJlRyfktzLR8di6wmastn/?=
 =?us-ascii?Q?We8aFm89yPR4xgWXqpuP2LW6PaK3Wf5QoyWCSTl1RSClWRcMXn4+RuYCl8eB?=
 =?us-ascii?Q?yLEUdtlChkMmAeCkDsl1zn3udrDC4HJbUCIT3RRi/HX3oxP+V4JR5tTswUwc?=
 =?us-ascii?Q?QRHuDcw2NL+0ZQvwfsAF0AIzqBWhA5iNNNb8BieuzzWKqqyR829Ouycn5O9V?=
 =?us-ascii?Q?eD0IXdLhy1Db2Atr9hG/AR7eWtWBUmo20AxWcx6HGhA/ulWHN8AFBEhGfKKC?=
 =?us-ascii?Q?862sTM4ym8RdQLzXWPxs/D4+8FmxyrAQJ5NyfonXBWOo7Y+LoKR69Y7YfeCs?=
 =?us-ascii?Q?nBXmq4zbvifA7vln9kcIJ0ljMZPGFtflnce00ZaS+i0IafGwzrp6b5oWXJ24?=
 =?us-ascii?Q?TB8vcqu9B3LXsACgotVeCvy3r92Co7kQ3ZS0tpR4b3ZZJJyZues2TrbDMHcr?=
 =?us-ascii?Q?/1CsD87/P9Y7xJseFzreoB09MwPulf3zkDEPUsIoNdsd+6OslIvgLe5y0MmV?=
 =?us-ascii?Q?U0yKldRshfySubgzoiTkVfqkwGuDadRWN6tvbWWPpNtXr5ye/iaVzlZRG72p?=
 =?us-ascii?Q?pWmFhWHUTCOZZFwY51zwigrqsJl1mmClvbImxMArUJQE00xBSqoUePBMzeO8?=
 =?us-ascii?Q?9lzqhraIhDM5gZwkUcpXv2ossE47orbP6jlWnEjubkzsg2YFYp6tSZWJOK7b?=
 =?us-ascii?Q?TZMCWAcskxivMqSqgPh3tuKlUCgmWnh0Cyjqlbp4xCLGKbkR7fe/dCu0Ei38?=
 =?us-ascii?Q?6HyFO1hwT44ovm6DE2Np0VAt5DP1kn4m3w5JN9eR7/DaDr4LaRr9PRbkVXqH?=
 =?us-ascii?Q?S9UYW/1XmHyyQA4tXfD19YcrvwTxvA+vdYOA7P55d9eTmYr5zrG/hNo8tLWi?=
 =?us-ascii?Q?W9hHFPMvPpgPHOqYxfTFS2xgeZo4gBt/U0LP7ocl0oY125LH3EUpHyqIwuPw?=
 =?us-ascii?Q?wWIuO9OIRhP8lz8OrePOf/jqOTkwifxXhB4tn36fsK4SE9ZYB3ATDUonuULq?=
 =?us-ascii?Q?hexTs6xrwCWEfnpTgKl0aYJWRugzoL3G24vVFlr07KOE7uWFvnQ8+AnjMzzf?=
 =?us-ascii?Q?P+8EXGTjP7/USfXQXEZLm7GlasOglyFPnkZb16CHX8+SQ8YroK1XVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:32:57.8400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acd96c8b-7246-4f73-1a4e-08dd31f0a493
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9051

From: Jason Gunthorpe <jgg@nvidia.com>

Currently IRQ_MSI_IOMMU is selected if DMA_IOMMU is available to provide
an implementation for iommu_dma_prepare/compose_msi_msg(). However it
makes more sense for the irqchips that call prepare/compose to select it
and that will trigger all the additional code and data to be compiled into
the kernel.

If IRQ_MSI_IOMMU is selected with no IOMMU side implementation then
prepare/compose will be NOP stubs.

If IRQ_MSI_IOMMU is not selected by an irqchip then the related code on
the iommu side is compiled out.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/Kconfig   | 1 -
 drivers/irqchip/Kconfig | 4 ++++
 kernel/irq/Kconfig      | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 47c46e4b739e..b9a4f0521d71 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -154,7 +154,6 @@ config IOMMU_DMA
 	select DMA_OPS_HELPERS
 	select IOMMU_API
 	select IOMMU_IOVA
-	select IRQ_MSI_IOMMU
 	select NEED_SG_DMA_LENGTH
 	select NEED_SG_DMA_FLAGS if SWIOTLB
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 9bee02db1643..758cbbf907aa 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -28,6 +28,7 @@ config ARM_GIC_V2M
 	select ARM_GIC
 	select IRQ_MSI_LIB
 	select PCI_MSI
+	select IRQ_MSI_IOMMU
 
 config GIC_NON_BANKED
 	bool
@@ -38,12 +39,14 @@ config ARM_GIC_V3
 	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 	select HAVE_ARM_SMCCC_DISCOVERY
+	select IRQ_MSI_IOMMU
 
 config ARM_GIC_V3_ITS
 	bool
 	select GENERIC_MSI_IRQ
 	select IRQ_MSI_LIB
 	default ARM_GIC_V3
+	select IRQ_MSI_IOMMU
 
 config ARM_GIC_V3_ITS_FSL_MC
 	bool
@@ -407,6 +410,7 @@ config LS_EXTIRQ
 
 config LS_SCFG_MSI
 	def_bool y if SOC_LS1021A || ARCH_LAYERSCAPE
+	select IRQ_MSI_IOMMU
 	depends on PCI_MSI
 
 config PARTITION_PERCPU
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 529adb1f5859..045b37073d4a 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -96,6 +96,7 @@ config GENERIC_MSI_IRQ
 	bool
 	select IRQ_DOMAIN_HIERARCHY
 
+# irqchip drivers should select this if they call iommu_dma_prepare_msi()
 config IRQ_MSI_IOMMU
 	bool
 
-- 
2.43.0


