Return-Path: <linux-kselftest+bounces-14967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D868694B10C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080C91C21A4E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B8C155CBD;
	Wed,  7 Aug 2024 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ByPIq/rn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE01155A25;
	Wed,  7 Aug 2024 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061509; cv=fail; b=mTBYnBIeZrPrPur9t9C0siGlDnTClkp5kljwEqA3A1nUU+2qNIUP4KuPnKVXgeJOcefazXiLOqAZnc5FWRSXu4FyJgj80bJuvAQBgQw5PVRx9W5N5XSz8Ha0BBm4t1EcS5QxrsK5AgofKCIQgNSSlwOXhixofx5J6Cmwp10KeLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061509; c=relaxed/simple;
	bh=RABeES3Bq9f3MW3PqkuWihF7yq16StQDUlM3T7U4C+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+sbZ0kYiBZSJjEcPqi8PBGZvJqccIolkYqubyJx45e1K0CUCW/xRLenQ/gI6ba2sVgsaIx+0InfuXgnaJMccFch/S4K91uPS8VO+Hsz7k+3ZErsI5au24e6sReEhR1GPmyCtWoq7e4CYIjgdRCsdkcf3ke8N42t1PsP/WuFAhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ByPIq/rn; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ao1Smp2Y2MhFTLluuO8GwLT1pr0NwOL4YbPgpvdiKE7pX1NGVFkRqkLCjOlnksixBYwUMsgQp+jDYvHabUY5GuzsP3fTG124PJivXjp+1QpjYJ9JA86zvP8nw5gmr8YxkwktYGbUu9EeQobMZvxJE5oQDJZNzBWFeWQ5EInoFG5EPIxRBC1SkoFX+U4zQgeDeDyFLVBCNQJSIrGU1leuF3ejkeGtQE0oNhR9m+CnGT1dypwQuxsWVVVKan+/OoekRdhrNRXrh7nHh3FyN9vAhODcpYznDoC+iB4NW9LKYMZXdzmWWsdfN/wSkIZ4wZMuX7OvjLugOy9/vdhLGI3DgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAMVu4DFsuu/fqBPno6W61KUtQwiq8UyhtoUcscWChk=;
 b=uidfEiinAidcJSRhohLcyEycNza9cTRhMicttFCCT/bBamYrVLnMgvnDVp+YTPB98ve1xzZcQKSoWz8dlp4TO65DihsKMA4T04GYWXlkxgg4mlSHVqi5eiarSVqjfyIEKWJpvio3wwJyscPPbrc7oVvbmpZoW6VB0oqsPH9kRPjqjxYZ6aqqsY2j0NQP15MiIcshqKfukXXAt/Yzmk7LP52Uz1moz5ps06rHGF7+sYaYxbzDhpjaJngC/GZu1vtJwqdFdf/JMceuaiDYG0t5WPaQPX4teqNPheQvzUevzQXIfwtVncGbPs3FlI7nHJ/SWc7Q80r7UQ59mQ3p3lRphw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAMVu4DFsuu/fqBPno6W61KUtQwiq8UyhtoUcscWChk=;
 b=ByPIq/rnC6e0AB4bqMf9aww5VIqc/QOEXnRzxztC0InC9Zxp0tbiJ8d/z54HRC09B0EBNzRZLJvwdeCd+I0sCeTfWq2qK0AWBr0BR0sFZwa850pxFvpvSnfmTmpHjlhHztluUvVWeOKXRvOphWZdeTjWWSowdVR+BuiN/NdQAuoldgnjq9bDLPbeM0tiqrrFXnOUZXk8KGVmxdNpAcFJjjfjeXzol65ywfPTdSyNAAp//WrEz8q3d3j95Wi2xV2S13fZlFYOuhXI+iK7wpE2CA8ATUtbUTCGqGhT647tcwmMHcxVRnmlueyF+JVzC5m5pqksnOaLuOr3Zypkiubqbw==
Received: from CH2PR02CA0026.namprd02.prod.outlook.com (2603:10b6:610:4e::36)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 7 Aug
 2024 20:11:44 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::4a) by CH2PR02CA0026.outlook.office365.com
 (2603:10b6:610:4e::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 20:11:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:28 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:27 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 16/16] iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED
Date: Wed, 7 Aug 2024 13:10:57 -0700
Message-ID: <442b3d5d2b15182f5cc100346183f8c710b7e909.1723061378.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723061377.git.nicolinc@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: f6351630-0dae-4498-5ae5-08dcb71d2871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a0lBqDPwfbuVGhoNWwBklzZOK/GRb1n4WsDDDlUqObC4lbm+d+/i7nTkV7rC?=
 =?us-ascii?Q?41g5fM4ghvgyLxSvonlp6KEMNnrEb7o1dyP287TjiBpfOkxiBbEinO6EcAMC?=
 =?us-ascii?Q?SGoWSoTEJmVQBYhxz6zkau0aEWqlJgklos+q70t/g5VBl3xlSbHXpx6GGcdg?=
 =?us-ascii?Q?cA5tEun4ucBG7cSntbPoXW0sTQwT4B2lGlaS/fefIN6KNSRPiWDZLvadEfb0?=
 =?us-ascii?Q?EgbgEfbp6BNp5SjpQcQujAgf7e/74afgSnF475TwhKvqqnfkaTrMc0LAqCse?=
 =?us-ascii?Q?5MP8ejHPRGkMEEGxf+C72klE6pYLCGpRl1ZXn4haGVO0S8YLi1dppjgRacag?=
 =?us-ascii?Q?Etz2XjTufma/lrOihLP2VU2XJJ3S5AIrIA2s33yhNZXtMjFuhWk5/8/xgRiG?=
 =?us-ascii?Q?qv+soUQJC1xWo3xgMpzMvd2nAznOgg5Zfy5Ps/YxB0kuVbk5TYH2dgoy+8yx?=
 =?us-ascii?Q?9xKsyQxcy9N4RZjy9N3zN6C/w4U4rESCB/d30TpzlX7V07z4A92M3aY//PTL?=
 =?us-ascii?Q?11t2DLt5SOOCgmXP6BW9LnRX+Ka1gRUSX7lJwNyX9vTRc/yZ/pyOwfc5pzcg?=
 =?us-ascii?Q?962f6FKeKYUG3BldIsfH9SEiT8mod1/Ch9IJo/OQTZdMSOMdK+S+RqCflAAs?=
 =?us-ascii?Q?a8SNm/AlKY+xfoUsch0oARA+cDxGezJ3pNP5RWjiujaee3E9Du6qZCN299xK?=
 =?us-ascii?Q?5SkaYhLbWmiBQSq4hD7+etDV/xNnIqfvOQSyqcBWIiF/DkWEslgyj2YAqTUz?=
 =?us-ascii?Q?ZBk/t49rAERS3Q9aONYmrEILwMRb5B8ZmZZl2MR91kDu10/7reCC96wwqb2x?=
 =?us-ascii?Q?RJwlkPJBu7DOeSs/I9wj/dAN887NHcZ8393deI1mFsW+iMxyELI86YBehS85?=
 =?us-ascii?Q?9W58cKP2bpuXAhfZjOg/E1cMyJJfY5yXbXQulUGWscnwarcDWXpKeVS/sAsq?=
 =?us-ascii?Q?xAYvTAh2xF9Z2TTkKW0LRCdCffu2GHmzNW3d5L3LHjxw5oiKdZhXg+7XOUGC?=
 =?us-ascii?Q?NJrK7E7jYCsbj4+P0tVaSjoznMcK/On7MILpIEU+jN7bD+lyKPbckGzeJ1GY?=
 =?us-ascii?Q?GeliPyiIrFlab/NHNkZH2fdcphyO3KGgHMDcsw+nmDlQ99oOmEBdwXZWQZDf?=
 =?us-ascii?Q?nFoVXXT1cLqrIbj4UiPUtv+ZqleWqlObZ+UkRdKZUeqSBeIxMDOnDI/yDTPE?=
 =?us-ascii?Q?qJ3wlZsp8OhWpYRB7W/fF4W6SItalOrseAtK/n9TIMl7TF6YGmAbHNQleS+C?=
 =?us-ascii?Q?mTry2smY+OSZGh1Vp5QCqQeezK0sK8ymNGTOusNnFOizNhjqEsF2RTqLE4Ra?=
 =?us-ascii?Q?Otk1pskXUSYdlT8vNs7r5e2sJ8TWq9l+TcHQX4k2vUFknuHIfUwwzmjgKx6N?=
 =?us-ascii?Q?bjbuFEImUw5UjTYg+iVZ/VR1TOdzU5vy72DiEwb4w33CPmJ7RpheYufGNLjB?=
 =?us-ascii?Q?N0qUnhq/zIE3MfsWa/RG1QP25NHaX7kw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:43.8657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6351630-0dae-4498-5ae5-08dcb71d2871
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

From: Jason Gunthorpe <jgg@nvidia.com>

Now, ATC invalidation can be done with the VIOMMU invalidation op. A guest
owned IOMMU_DOMAIN_NESTED can do an ATS too. Allow it to pass in the EATS
field via the vSTE words.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 ++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index be4f849f1a48..ce84f0c04022 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3189,8 +3189,6 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 		.master = master,
 		.old_domain = iommu_get_domain_for_dev(dev),
 		.ssid = IOMMU_NO_PASID,
-		/* Currently invalidation of ATC is not supported */
-		.disable_ats = true,
 	};
 	struct arm_smmu_ste ste;
 	int ret;
@@ -3200,6 +3198,15 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 		return -EINVAL;
 
 	mutex_lock(&arm_smmu_asid_lock);
+	/*
+	 * The VM has to control the actual ATS state at the PCI device because
+	 * we forward the invalidations directly from the VM. If the VM doesn't
+	 * think ATS is on it will not generate ATC flushes and the ATC will
+	 * become incoherent. Since we can't access the actual virtual PCI ATS
+	 * config bit here base this off the EATS value in the STE. If the EATS
+	 * is set then the VM must generate ATC flushes.
+	 */
+	state.disable_ats = !nested_domain->enable_ats;
 	ret = arm_smmu_attach_prepare(&state, domain);
 	if (ret) {
 		mutex_unlock(&arm_smmu_asid_lock);
@@ -3420,8 +3427,9 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 	    cfg != STRTAB_STE_0_CFG_S1_TRANS)
 		return ERR_PTR(-EIO);
 
+	/* Only Full ATS or ATS UR is supported */
 	eats = FIELD_GET(STRTAB_STE_1_EATS, le64_to_cpu(arg.ste[1]));
-	if (eats != STRTAB_STE_1_EATS_ABT)
+	if (eats != STRTAB_STE_1_EATS_ABT && eats != STRTAB_STE_1_EATS_TRANS)
 		return ERR_PTR(-EIO);
 
 	if (cfg != STRTAB_STE_0_CFG_S1_TRANS)
@@ -3434,6 +3442,7 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 	nested_domain->domain.type = IOMMU_DOMAIN_NESTED;
 	nested_domain->domain.ops = &arm_smmu_nested_ops;
 	nested_domain->s2_parent = smmu_parent;
+	nested_domain->enable_ats = eats == STRTAB_STE_1_EATS_TRANS;
 	nested_domain->ste[0] = arg.ste[0];
 	nested_domain->ste[1] = arg.ste[1] & ~cpu_to_le64(STRTAB_STE_1_EATS);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a3fb08e0a195..65f90b00e16d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -811,6 +811,7 @@ struct arm_smmu_domain {
 struct arm_smmu_nested_domain {
 	struct iommu_domain domain;
 	struct arm_smmu_domain *s2_parent;
+	u8 enable_ats : 1;
 
 	__le64 ste[2];
 };
-- 
2.43.0


