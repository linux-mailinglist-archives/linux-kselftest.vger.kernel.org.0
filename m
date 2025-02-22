Return-Path: <linux-kselftest+bounces-27279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3436DA409C8
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 16:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1841898E66
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2552D20E00F;
	Sat, 22 Feb 2025 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B9NGFFQd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78920D502;
	Sat, 22 Feb 2025 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239702; cv=fail; b=C0If91sbssvf/eHqwAv5qN2lDvA3SepmdoR3NQDkTX8V2q5/grR+2hbaFdwRBtN03+YzN74vaPnz35yFAC0jxlBe+nHjYDKO1kZfaj9u0sbIM1uGLK+XBOzqSGf7ihCR3/mYfeNrgXjII6DfhmFv455mToXJ2AEtj20mqFRVIoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239702; c=relaxed/simple;
	bh=j8fFNDpqD8HnlwDuBPrmm73rYwiTw9liGwRRkfBYLC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPqsASW0SvnFoT3IXhv96KVTLZtMiwJYMKhIPfDSU5QlxzBSdjF7oHWFC5OtHID5q/AI3z4/7gTV1VI5G7GfIHQgHqEizG7kaDudOBn9WO1iIgXx/x7OywNLiW5viMOq4DxeoCftQ7rAMV18Bft/iMC0LGswsQcuNvqefPgdw14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B9NGFFQd; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8bqMXoz7QCYD3FdqB6og1rqEWBOpLFmN9LwEDoEGfFiAmNTwMgwieXShNsjXvovp+7fK+He4mp0aO/LfntzlnBLhAnynstUtjuIJy/JCk2mpGHXtw/vCJgPR0dcZVr2yhXDrK6OVCAk3bfzcuvUsDyj+CyfPV+Ux9fOeUL1QSm9gA8Y9ffwZYbslKqO7sT+TqwJQ2Iuwe7sYnzDys4e4H+h3BfnwZmLnbuOk38Wd8kaHT/DVfLIwqwfbIuEGPp5SoVS697pgkzXfAOTrtMNA/75VdGgmVwSBQNOb39cQKNYTPP7u8Dfoj7LIZ4CZQod2fiOOTuBrw04SXcAbgqpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6bDDOzqFTlkM2Q60CEGPKJd0jk/eguA9n4lHVkCc+M=;
 b=BiZKy1+ch/z1ZB8gLOB0U4gtwdWOMWvyM6423JS2lB95M3nqrBdWI8AmjX58Pt6YkOvegIjBDgVcANM14hgtoSR39XQoTan6sok8aXDDiuTBbDJptjtOJSpWFi4nXc6tvpCCWLfttpwp+GbTylo+K3ME3n0S+sp8smMLTC5/iEc3063hRJr+5CZm9qLyjmz+JOaV4Flwv+ikdNYGLtxPbvVt6qIJ+ADFXURXnVhYRTLuwmHupMZvSpUImF7b7FYD70ybIWb//CshmoUY72jR20OPvQLVfYLnJiVPS7CmeMIogMZCqvMv+iWMPaGqt+H8EcmwlHpwifD1eu4pgODCww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6bDDOzqFTlkM2Q60CEGPKJd0jk/eguA9n4lHVkCc+M=;
 b=B9NGFFQdwHK7Uui/b5Kt9zx6sRif4p4OIdS5Uet4kEKR1BfcnZ3e7g8fEiHUTwGrPaZnzp4OP/nlzuja9jAJWT8lrq68vyX9Ide9Us762Q3eIaZrvzfl46yyLcRxGe47ZxxSY1zgIUkY3vg7YZoRLd07vcM7jgoHIt2rUXYHTfgyC0gxBGa7fAeSM6QmCQmROVO7VnakwxLfcNXW00ZSQYOvixa5+wXpsrNvGQVZXVC5f1SGeeaCHm4r7ZzQ9tfgo22iI/2UcoEydkovuQ+i1vu6dSpY3vus3/cTD/evPkwjyXRak8/CqFpsajQz6147VJEXUJB8ptY6fDsdGWCoPw==
Received: from CH2PR15CA0009.namprd15.prod.outlook.com (2603:10b6:610:51::19)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 15:54:51 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::4e) by CH2PR15CA0009.outlook.office365.com
 (2603:10b6:610:51::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Sat,
 22 Feb 2025 15:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 15:54:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 07:54:38 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Feb
 2025 07:54:38 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 22 Feb 2025 07:54:37 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v7 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations
Date: Sat, 22 Feb 2025 07:54:11 -0800
Message-ID: <2b088fe8d2c7e692426b0d1f58d4f2c12ecb907e.1740238876.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740238876.git.nicolinc@nvidia.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: d62eb277-7878-4031-3ad7-08dd53593dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ijEeJmY41RSf2/DQvpq8qGhaLVtxEjve1OXm4heuogP9Pbo4FdEgLQcx6nAQ?=
 =?us-ascii?Q?lZOYx/k2lB6RDHR2z55+oc+RTYW1FmjYYTfnvL8m4S4nnuJGIoSZeyMeUiYm?=
 =?us-ascii?Q?jbru3F63jTYfRGfq2+bkv8o51OjyABrqMOmVHzbLvzQs+r/mmWp6FeU1Uewh?=
 =?us-ascii?Q?emsTlskjfK2SOpbQP2DH03A8ALjP+37ZV06bSrYhlV9Ygxa31QuURex7lbDP?=
 =?us-ascii?Q?qcDjccMFrGbp49/mULWrgVWHq7K/SOKKDxaIsgoOyF8IBY6lFmWy2qFETyAo?=
 =?us-ascii?Q?UPx2OMpjYQxTGATkxCobwYu2nTMSlN1SN+qZbiHDqv9I2jLnl2nYRQC7LcGz?=
 =?us-ascii?Q?lbKvsicxvWnKflSfFUEa7yAjoKde6Cfe0R1MaBwp86zcvHe/u3TVK7zGhtU/?=
 =?us-ascii?Q?KdB0w1nx4qJoRXbEzN91rsqeOxKPvEzvHH7WCRWUacTx1jYDQ0dGJa2GBliI?=
 =?us-ascii?Q?OhXc1MEwRT5lsDaoivZDOI9u4O1k5bDa0hjdVxepWAshSQI8CNl6Y3thegxl?=
 =?us-ascii?Q?KjECrwDxqYbL+KrYmdcWomd3lVvOsTy+9eVGHxLxFOOp3uiPBRYqi0Qv261+?=
 =?us-ascii?Q?p3Ou8z2LSp8Sj8R93Up4O3+HoC1HvgfjzQlHzPmeQuR1pXWykSXkeOPvcOKS?=
 =?us-ascii?Q?ZMVVckCXP+m6yQd+YMp3ibGeu2wuDRPEm52CrIOR46xnRvPmi1eqnnTqCCRe?=
 =?us-ascii?Q?DajclzExeXPIW0+Ee1MRBwFqalYrdAvQ545L+T+aE/fjN6Vy12GhCwVrqqqE?=
 =?us-ascii?Q?vayvyRBWx+elYG2qC9dBnVFIm6I+Rz4UftjAABa9wJZp2UFBKN8yZWkjAuWN?=
 =?us-ascii?Q?f1C8v+JWY1P7MPhLSN0WKOl+V3gapiTrTeJrupbi+fGnJqezeqSqFsjOtH81?=
 =?us-ascii?Q?iFDeMQ3JbmpoCmh/rj1f0csRXfzX7MVnJNTMZE8/mLxsFRg/Jo1H8ZznanWW?=
 =?us-ascii?Q?0uGgq1kbYQuX89/Y9Q01TjIJWfHWYJhijPR/SFWiEJ0VgTtvo6cW+5bAMGRg?=
 =?us-ascii?Q?4WzwFtxSINCbbonxDD+RkxN+LpI5uoVIld0jeuCqbUAXB+1VK7JwObKF4mny?=
 =?us-ascii?Q?pu8soLpU7KhtO29ZT953HerKaGyA2I6vL/ID3bozInaaKrb/ky+TYN5LjbpB?=
 =?us-ascii?Q?sXv/lukhgThFpz6LWwKZKoxIJ7QrfT5BBagIwNC/AusUVjexujL+apFNJzC9?=
 =?us-ascii?Q?wDDZmF5CCCNDoRWsYGovB6rV9WLexL6llT2kdKUo5Q+DEwLAFEC4YIz0wJOc?=
 =?us-ascii?Q?Y5wi6sN/EI7Ff2hqLDgH7Qe88NQM1bPGH++lnAPLaqrPrMHmE9OxeG6qeOlG?=
 =?us-ascii?Q?jVQiIv/8skA0svD+Jeh6jK3HstKn2XUoulZ26K3Q0ML+h+nk65z4d/KsLbPM?=
 =?us-ascii?Q?kTjTOgZnzsD0kIfNfrkXeVK10tEbEZlQJcMGGhtbEAtoSM03VXgmp1CX96CF?=
 =?us-ascii?Q?ZD/aItIomV1jGLMNb2DzNPEu7V5YPkgILx/gnTMXhElnrUJtCcqRwkxakLUR?=
 =?us-ascii?Q?eAgtqjUNDWTVCCY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 15:54:50.9716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d62eb277-7878-4031-3ad7-08dd53593dd6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131

There is a DoS concern on the shared hardware event queue among devices
passed through to VMs, that too many translation failures that belong to
VMs could overflow the shared hardware event queue if those VMs or their
VMMs don't handle/recover the devices properly.

The MEV bit in the STE allows to configure the SMMU HW to merge similar
event records, though there is no guarantee. Set it in a nested STE for
DoS mitigations.

In the future, we might want to enable the MEV for non-nested cases too
such as domain->type == IOMMU_DOMAIN_UNMANAGED or even IOMMU_DOMAIN_DMA.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c8574969e700..a90e115d43bc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -266,6 +266,7 @@ static inline u32 arm_smmu_strtab_l2_idx(u32 sid)
 #define STRTAB_STE_1_S1COR		GENMASK_ULL(5, 4)
 #define STRTAB_STE_1_S1CSH		GENMASK_ULL(7, 6)
 
+#define STRTAB_STE_1_MEV		(1UL << 19)
 #define STRTAB_STE_1_S2FWB		(1UL << 25)
 #define STRTAB_STE_1_S1STALLD		(1UL << 27)
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 42c7daf4c8c7..4a2580b53b60 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -43,6 +43,8 @@ static void arm_smmu_make_nested_cd_table_ste(
 	target->data[0] |= nested_domain->ste[0] &
 			   ~cpu_to_le64(STRTAB_STE_0_CFG);
 	target->data[1] |= nested_domain->ste[1];
+	/* Merge events for DoS mitigations on eventq */
+	target->data[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
 }
 
 /*
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index fdf8bba14303..0a0bc73fa287 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1052,7 +1052,7 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 			cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |
 				    STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |
 				    STRTAB_STE_1_S1STALLD | STRTAB_STE_1_STRW |
-				    STRTAB_STE_1_EATS);
+				    STRTAB_STE_1_EATS | STRTAB_STE_1_MEV);
 		used_bits[2] |= cpu_to_le64(STRTAB_STE_2_S2VMID);
 
 		/*
@@ -1068,7 +1068,7 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 	if (cfg & BIT(1)) {
 		used_bits[1] |=
 			cpu_to_le64(STRTAB_STE_1_S2FWB | STRTAB_STE_1_EATS |
-				    STRTAB_STE_1_SHCFG);
+				    STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV);
 		used_bits[2] |=
 			cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
 				    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
-- 
2.43.0


