Return-Path: <linux-kselftest+bounces-14743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A558A9464FF
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 23:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328E71F2126F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 21:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744291311A1;
	Fri,  2 Aug 2024 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KbY2VhOp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CE91304BA;
	Fri,  2 Aug 2024 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633864; cv=fail; b=nzagPcAPK35kJdGjhfJ66Z6wnhqjR0ZkjD0ivCXSMJXQT5prCsJUCpDc7wOBQPUXi74BVaj5hMMe8lBpcY2H5m0AMLEl6TuyYKOeJpjaxcYBZkSPVnMyleqUnTwMdueAqfP7pZ0URAYLIa7JmvOI0N28qdzeSRrrn0LNT9TYuj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633864; c=relaxed/simple;
	bh=6uA00BK2lf+Z1ga6tKxs2EdKKCLkYre2/i5yDGFhhw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoAAy1SdZpmseLiDdMTaMFhmHUVAhhL/s6EikIKNWBmjpkMNjxgFi1k5EA/dN1EWUl1q9YFw8JOdZrfZnlg3m2bpWXGCQjndBTLHILOR6mQFC+jYGFDXKe0PpelGNZIhNaJmYd6f/QzWowA62ol6RFtefffT3bGA1cAGwzAwc2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KbY2VhOp; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK7LDstZAJG9xFQUlyK/XkS4a+Nsb6t8NDH0srQOea8HASZZOkjjvk684iJQoTmRQip8TVdLouYHdZyjLn9HTopDT21VONyljyWcs+WNYShyMLSJuuoN9NPh3lZMZYQAs3d7TxzUH/dxnuilhnJk1flrCgNglHSw0gIwbq2haKlCCxmEp15lIpH/L7e6ZXQEZL7aaBMYSozqDHHbExSDLtK//8+EMpSWERR/c8R7Z3xxJ/+8jPopw6bCt9htPnfpc1yxOSkW2Kado+hEbXkfzkYu3qmJyn+0Afo+f1N982uptEhDrH7wEbzircV/TCCVZmYFb6DPm1sD2Q9l6BiZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D20G2M+aQVUdKCMe81xyHdP4RUwPObZi/qMHmlpzZLI=;
 b=ZC2Quot1ErymglTInZLKke48wui9MyPG1BalBQTSvmwqfb9vgQ3ICPF+u0t0mcpIKt8Fd4MN8LeHZowEfER9/QhGxcQZqnLzzNHECrJT84GYTbjXuN1uWM73O8VRnzpsK2bF7EbbjiI/pC37seerG14tH7lnAt0Y4wR8OHLsA731v+U1sHoTnIWP9/LDj+L1f9uhNmrrx+mvO45B6a1aice9CSDCj9I51KFlE+7UWyGOHx19ZlKbQr3+r5MhlQLEbF425CoMmb7HhW6dUhL4DCpEymAYwnohJyIxxMMsB2zzUm/MYsiHnc7IlZGGr8ZC4EK2Qcv2ib5so29blXFX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D20G2M+aQVUdKCMe81xyHdP4RUwPObZi/qMHmlpzZLI=;
 b=KbY2VhOpk0sPtwvb8Q0E68eB3kkUzaoYeVsSys1pnOuEFFKegKwqCgD0d1KyVjguo3CXtmrdNukmXjGgxBCZR0LoGk691wY7aL9tUxfjbtNiyRPW/wWgwBdF1s/2PT/yX88YH4Duj6csP6bgdfX2V2ZIHxpNrRqubFGvCuXXvSPH9CzIKK3bfM6w32MAjFVZHL1FNl9uVAcYIBzpoIM76PysQxRCnTzOFGdMd3qjW59z1t0KN+aC0fbpgNJ/v+igl35fTMDOGpX4YngZiK4YsPhJed1FnixS22KiLuaT6kX53N76iiDrcXFqvRQib0VkinKyr1cJulhGpoYQ/tseLQ==
Received: from SJ0PR03CA0170.namprd03.prod.outlook.com (2603:10b6:a03:338::25)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Fri, 2 Aug 2024 21:24:18 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::e1) by SJ0PR03CA0170.outlook.office365.com
 (2603:10b6:a03:338::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Fri, 2 Aug 2024 21:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 21:24:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 14:24:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 14:24:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 14:24:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH 2/3] iommu/dma: Support MSIs through nested domains
Date: Fri, 2 Aug 2024 14:23:47 -0700
Message-ID: <b1b8ff9c716f22f524be0313ad12e5c6d10f5bd4.1722633199.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722633199.git.nicolinc@nvidia.com>
References: <cover.1722633199.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: aa4f4f54-2082-423e-8790-08dcb3397737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H2/VEkasjSedopH/eBbEQ7qMsMBWPBisH+AdLhUzWTqMOkrnVKfFRWLKLyYT?=
 =?us-ascii?Q?p7SVFX3Urwsnj9+/1fPSgbU6e2/qdj1HeqHtZdCNfGINgRirJdgjqpv/oP6G?=
 =?us-ascii?Q?bKD6Kv5DZIvwIrONMGT1wH0OMcffe1La7dwFpKsDjXro9pJSLLQtyobR47yI?=
 =?us-ascii?Q?AzdEl4buFkDd09UGYTvTGKRZxUZNFNPDG78dyvdSUyzM1Cyd7PK7IGNVcjM7?=
 =?us-ascii?Q?T5DaxhcCK7xyPP4yX4Gs21cN5Zgh+Fy9DsvqxNsz0xNokpBLCT4LbkSUUmVR?=
 =?us-ascii?Q?m2nf8IMZanxl9ETEGiIj2HaQV4ItVmvKX1Pv2jCP1DcT36sPfc7RAbIo3qFe?=
 =?us-ascii?Q?XCsu17OqtC59eKbGNQCfaY4fugu3i1Lk0O5zc7RkWGhuDybRxriaM002D3M6?=
 =?us-ascii?Q?Iuo7tzWyD3vUtFIaKF54Eq+zx3KogC+ZX2Xf0WtrcSOsAI8difb5H83Etb02?=
 =?us-ascii?Q?HyYjN7QBH4idb3lRQrb6dS9FVVTMP8K3x+3k2X2PsDATowLh/sAxkQhExfan?=
 =?us-ascii?Q?ZOoB2QowFgtFhGc27KeK/3ZyqWta6V0ATaqYFTOsSDnXqr2WoDsfqAfdD+aV?=
 =?us-ascii?Q?RCCjn9LhIil6NpzCayw0QPylDNDKzBNDBcDwEKF74XonsiEsJZynkPqxpalN?=
 =?us-ascii?Q?rr+t5nbRnCkJXK+p5+NwpIMU3kJhHVXIQXxP/Qj0pHLcoPrrBH7lmSiGWo6z?=
 =?us-ascii?Q?aGDc3z36A3s7D1hNxb7vMIRPS2UJIPFxrNFYVdH8T+auUqq7hpNxUhOxfggS?=
 =?us-ascii?Q?fwPpAc1xDBJiBH7hBVpDCK3sdINvylsnJW7EKhWHYgWqLU+OoYIHSV+NQA6P?=
 =?us-ascii?Q?d8ftqeXuh7D7WnFcxtjJL7I/zas9UVkCOacECkIiPhMSxxGOb37PN6T46fsT?=
 =?us-ascii?Q?FLFg6x7b0JtiWK6M0+nqIXMtnekVEEvxHZy5tGEQioO0yuuVFU0yvAPgdZzc?=
 =?us-ascii?Q?gBykSwzyhrwAzZ8KG+jVrL/koEff5JOTJd50WqRMm25DnuXPORBbBfMT6IZ5?=
 =?us-ascii?Q?cPvmQKobOlGhG7CAR0Cpl9VbMQV4yYhfIjTy02KXz7PZIKLovwsdEJ9ptJWG?=
 =?us-ascii?Q?8bBVg93wqUHrsh6KHHThNyflPdq41ZlpaB7geitikTT60DFrN9k1re4zkpIx?=
 =?us-ascii?Q?WoiUN5SeXVPaFYXkHyhdlMLlhoAUtIwZsYXqSZOP3aqIbcsWIgLHND0aQruv?=
 =?us-ascii?Q?t9DmcoccRWlKQjNZzDN5vw8Zgg1P5SX5iGDWr0rFl2iylrvJ7CF23IhMev2J?=
 =?us-ascii?Q?cMM5piavqbE7IG8/tbMkFRs8UlWeqaqi3xKO5CPZDzAE5WGsvfrg68ZoHIPD?=
 =?us-ascii?Q?rr1ffrIWxr4j3th8M3E4BWxrnVlW9ouAoLuWHAUKR/CfyOYfhpF+dQxCwLiI?=
 =?us-ascii?Q?jnvUB3kKwW/CNHTKCQ2JGTXtGDW/GYSB+gd6ellrLvoXqrKs1PZnhURqfys3?=
 =?us-ascii?Q?uJqBfnE8dEb1kDCJLFyaPJeQ1pYm5oYw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 21:24:17.2840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4f4f54-2082-423e-8790-08dcb3397737
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910

From: Robin Murphy <robin.murphy@arm.com>

Currently, iommu-dma is the only place outside of IOMMUFD and drivers
which might need to be aware of the stage 2 domain encapsulated within
a nested domain. This would be in the legacy-VFIO-style case where we're
using host-managed MSIs with an identity mapping at stage 1, where it is
the underlying stage 2 domain which owns an MSI cookie and holds the
corresponding dynamic mappings. Hook up the new op to resolve what we
need from a nested domain.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 18 ++++++++++++++++--
 include/linux/iommu.h     |  4 ++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7b1dfa0665df6..05e04934a5f81 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1799,6 +1799,20 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return NULL;
 }
 
+/*
+ * Nested domains may not have an MSI cookie or accept mappings, but they may
+ * be related to a domain which does, so we let them tell us what they need.
+ */
+static struct iommu_domain *iommu_dma_get_msi_mapping_domain(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (domain && domain->type == IOMMU_DOMAIN_NESTED &&
+	    domain->ops->get_msi_mapping_domain)
+		domain = domain->ops->get_msi_mapping_domain(domain);
+	return domain;
+}
+
 /**
  * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
  * @desc: MSI descriptor, will store the MSI page
@@ -1809,7 +1823,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 {
 	struct device *dev = msi_desc_to_dev(desc);
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_dma_get_msi_mapping_domain(dev);
 	struct iommu_dma_msi_page *msi_page;
 	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
 
@@ -1842,7 +1856,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct device *dev = msi_desc_to_dev(desc);
-	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	const struct iommu_domain *domain = iommu_dma_get_msi_mapping_domain(dev);
 	const struct iommu_dma_msi_page *msi_page;
 
 	msi_page = msi_desc_get_iommu_cookie(desc);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4d47f2c333118..69ed76f9c3ec4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -638,6 +638,8 @@ struct iommu_ops {
  * @enable_nesting: Enable nesting
  * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
  * @free: Release the domain after use.
+ * @get_msi_mapping_domain: Return the related iommu_domain that should hold the
+ *                          MSI cookie and accept mapping(s).
  */
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
@@ -668,6 +670,8 @@ struct iommu_domain_ops {
 				  unsigned long quirks);
 
 	void (*free)(struct iommu_domain *domain);
+	struct iommu_domain *
+		(*get_msi_mapping_domain)(struct iommu_domain *domain);
 };
 
 /**
-- 
2.43.0


