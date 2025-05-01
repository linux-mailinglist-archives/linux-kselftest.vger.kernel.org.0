Return-Path: <linux-kselftest+bounces-32128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3D1AA6721
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B9B172605
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB4B27CCEA;
	Thu,  1 May 2025 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="smalUEzq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC25327CB0A;
	Thu,  1 May 2025 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140555; cv=fail; b=JDD4Uz5Ac4S7Eew8cOchHP8ZwdMuC9b2XBMHokFV3Re28AHhRLvfoLSLXSvPJClsTz9y5DqCwGyhZ8IuU2rmhdTyiyxCYRrpninQhpUvkzUl+sLxrafJywBvUZHhAn5Teh5IzKsKC4L6cGdToTe4OEaMZh18nZhcwPJlewiw6os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140555; c=relaxed/simple;
	bh=/gs2kaYBxBcB5VXdwQLiLFviabAYHSn5e6sebsEt1y0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnTkmUIVieIoYHFPu1DElwk4atpVaPKJsPavNjtTAmp6hi6vB3ApOmH8MRCEaRwdX8kr4CsP4DCE8uod7rlix9/VcXoRna92l+8HOtRoHqcMhvtI1IFgre10wGizD8nFIUUHiEx44fk+Xg9b5Uzw7EGWiYbhF4qQfbJz2wV1NOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=smalUEzq; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jny9lL0r8swip6kJ5GG+lfOWNZpvo2Q0S02LY/I1p/WRRyo5fs9utK9cGTus4mfSifQ16UJkqKGcSZDmZQozoF0byKrfsOecxxT2o24+0Wb2cZ+YvqF07XpvoTiEtrl0Pog6xN5vfC+4BM2rfqk8OAvFjG23Kih1EwgFMtSV3xzuoZmuXUzVlyl1jBY77OMkRlelZi9ssr0R9a4K/PNVNfzkRRoH4fyVKjpsZbAlb04wnGTixA9vDpiesVITqgse0CmGyS+RcuyZg3TkZPapvP0CYAcrJHLmYfD2WSUyWmWwnesVnU/m8hJ6gxlsb3uQv+OqWvewhkY+sNfzrj+5yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+RQR3IJbHeeE1lL3T/6+RO9Y9EMS3q9xEaDtjU2VUs=;
 b=G1wzBxoWuNv2WUXMskNfhPBcjQ9WYAMwZlrn/Ns+m7C1vxNqRxZ5Yw/9h2jiMbNhI3IfKh8TDMAXuBW9UpG84mUeMQSASe9hehqT1S6zQkSvKUIi3KTICwLPTusee4mpI5t/GNgcTUuCMDKA16/ovAO0UHo6v57FGfgSjbXqwFdWWEIQC5CewtmORY1gS18O/dR2WN4VbeFG5Vv4KSVBmdFBODC43wpNGikvpKdzGQP/V+DOxiDwGOT5SN3qStZdi45MF/lL2Zi9GLapeOnVwqT91Fbe5cv1COHF78QTQ+C/9qr/x1h6EfBKCZ9UqFwRPvC1H4xWBMtyjloCFO1agw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+RQR3IJbHeeE1lL3T/6+RO9Y9EMS3q9xEaDtjU2VUs=;
 b=smalUEzq872Kfmx5Quk9QBJWECXSTy/AU1hYRKQiBczk8NgWeKu760IR7RRohypBm3MKw3IvD3bj2vS+hSDNX8/oBBSOCnCyoi+DSbGjcIr4KHBimB1AEi3Na5DZ96yv0PM+PgZgMciL4r8770AJVe0AvY00EurNBhCq/vbdnh8zzBmHit0mDFV/A2Z+o7XGiOfaC3SV0fxVv4IZfr/9yzwPjojQNfXVUBVSY39BdCywHFG8VsW7JyfF0Lxo+wKva9idjRMuDovytAyNnYq74uv1ZVWaRlVBwEDuo5yMu85ScLOWyq59Cs+Qh+HhOKfie/QUrZ56yXJRah746umImw==
Received: from CH0PR04CA0051.namprd04.prod.outlook.com (2603:10b6:610:77::26)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 1 May
 2025 23:02:30 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::f6) by CH0PR04CA0051.outlook.office365.com
 (2603:10b6:610:77::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Thu,
 1 May 2025 23:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:02:16 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:02:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:02:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v3 17/23] iommu/arm-smmu-v3-iommufd: Add vsmmu_alloc impl op
Date: Thu, 1 May 2025 16:01:23 -0700
Message-ID: <4998a6ad7fbdf813468751fee1113e2daa874551.1746139811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746139811.git.nicolinc@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: a875b748-0cce-4ca9-00df-08dd8904400c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vUv9G3UhkZsfefVUBbsAMIbNP5BLRpWmk3TIn3+ZoC1SPunkKKiZbcSJacaV?=
 =?us-ascii?Q?k/pQhbYI1wuRwVcG6ZCCPDSDDYbq7acOF4ExhsY0LPQ294US6pAsElGOYrKA?=
 =?us-ascii?Q?6i92FukRrSEUVz8xqsK5es0aY5ZVSGhI21iD+N6ajrKV/X1fiAwPRfPP8Gr2?=
 =?us-ascii?Q?xaNLh6kftprSI66kH1d9xsOYCJKRz11gQK+dm6syGXEsE8N6o46sj25iGOdh?=
 =?us-ascii?Q?2I5Ct/8pTVWC3kATYPeLPqkkR1zE9jGxnwC4VNIhVF3GnMUZUGibB37GATan?=
 =?us-ascii?Q?WvNrOaNR3V9wVbUGf4EnoeCYdFDLgFznE9KFyzQDEk8dHVMN68XTWyaW4XsF?=
 =?us-ascii?Q?p/p4SSNfRnh+u3LYogc46pD5MNBKOVXcWs6o7z3U5AetgXOiFjl0qp4H8SPC?=
 =?us-ascii?Q?brogKBlyQLtJs4zCS9X9m9bDNmV5liLlTW5ffztoEIN7+iY7YQFSS0EBkxFy?=
 =?us-ascii?Q?aRNXntAOo+XR1M1Pcaayr9a6z+r8nQ8sNpgU2AwjLrxpueLD8olmup+RsAIp?=
 =?us-ascii?Q?Bld7pw/vq1qeH36nEuVHS1q4uixouTA9l9zNIWQy7BTFoMGcds1Y6xzUo021?=
 =?us-ascii?Q?WgsLj0+wXW+oNV4r9/k9V50nnq+YgyHJ0qdk3g0pI+TyoW4HXFlsWr4FVvdf?=
 =?us-ascii?Q?1sfsFIt5DriZvPuFhTHbaphR2FrDVUkMrm1a0KJvDCftTIhqr5FdQWbcP/kr?=
 =?us-ascii?Q?nqzvSeCtDClImqkI4/zEkpUErSJWqdhpkoK0HbeZ/oPRsXJ0Z9HwEJDvwHKQ?=
 =?us-ascii?Q?RTkmn9TcRClkeTj0mRC0I0CUxpS9ZFT4amhN8zR8AXuzD6xD9WgYgN9/XGBd?=
 =?us-ascii?Q?yaPrFaybe+jfAuTzyPhTWumGdfmv03mxwbEPODAHMc2Dk7RWZZqkqVKeZM6c?=
 =?us-ascii?Q?aOksmsTV3YwaS/Wus3CjOIvukcQmwDRT16Ds7ezEXvm58MGhzRGgkcCn6wuE?=
 =?us-ascii?Q?iVYa5ijxqMZ/HactKdOooYJpHzGqbKs3k1NLqvpO99maUvTle6x5vZ5Q0pGD?=
 =?us-ascii?Q?QfnwKx3kJfW4re1UIYyerHcdMym8rBOEomuFi2hfTxW6hyuSHFi9xPdCbORc?=
 =?us-ascii?Q?fSEfYM+mTchfihRxHq1a6elvuA8ca/cSn+bvXxXN1kI+n2iV5/vNu3lHsPgL?=
 =?us-ascii?Q?P6niH0Py5KU5kDr+EQEphWxnYTgtUEWniS2D+FddLH6bnqhwRBwxZqiDEL+t?=
 =?us-ascii?Q?UZ6g8Tbg8vRwEega/hMVUiwgtPmWp1SGlZTVnMt0haam23tlr0vypQOv60pc?=
 =?us-ascii?Q?SFWt71t1tvOqKg1s1eZHUECTi3ZCzerz8WxRjFZumiK4AWjV8Pt4H6HV/a5N?=
 =?us-ascii?Q?Y60KDfMt7M6eVgp0UGiiGt4Neq86jiPdwA4OUvqJOKWIa/gkNecHKH8D7Y6H?=
 =?us-ascii?Q?jEzAmqRX2J/1EA1kCHB2bbFOjr81vuARBGfDtA8wWeZD05ifpkAtBANzIQmj?=
 =?us-ascii?Q?627Yj4dehF6x22+uLjdU6VBmTHI9KoSFKUZn7XmdP379h9UKuGo/4CAYC0it?=
 =?us-ascii?Q?geMnVSp+xR8PYcq2hnY8M4IcHOf4HcO9icmw?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:30.2380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a875b748-0cce-4ca9-00df-08dd8904400c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307

An impl driver might want to allocate its own type of vIOMMU object or the
standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3 by setting up its own SW/HW bits, as
the tegra241-cmdqv driver will add IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.

Add a vsmmu_alloc op and prioritize it in arm_vsmmu_alloc().

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  6 ++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 17 +++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6b8f0d20dac3..a5835af72417 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -16,6 +16,7 @@
 #include <linux/sizes.h>
 
 struct arm_smmu_device;
+struct arm_smmu_domain;
 
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
@@ -720,6 +721,11 @@ struct arm_smmu_impl_ops {
 	int (*init_structures)(struct arm_smmu_device *smmu);
 	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
 		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
+	struct arm_vsmmu *(*vsmmu_alloc)(
+		struct arm_smmu_device *smmu,
+		struct arm_smmu_domain *smmu_domain, struct iommufd_ctx *ictx,
+		unsigned int viommu_type,
+		const struct iommu_user_data *user_data);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 66855cae775e..b316d1df043f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -392,10 +392,7 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 		iommu_get_iommu_dev(dev, struct arm_smmu_device, iommu);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_domain *s2_parent = to_smmu_domain(parent);
-	struct arm_vsmmu *vsmmu;
-
-	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
-		return ERR_PTR(-EOPNOTSUPP);
+	struct arm_vsmmu *vsmmu = ERR_PTR(-EOPNOTSUPP);
 
 	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
 		return ERR_PTR(-EOPNOTSUPP);
@@ -423,8 +420,16 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
-				     &arm_vsmmu_ops);
+	/* Prioritize the impl that may support IOMMU_VIOMMU_TYPE_ARM_SMMUV3 */
+	if (master->smmu->impl_ops && master->smmu->impl_ops->vsmmu_alloc)
+		vsmmu = master->smmu->impl_ops->vsmmu_alloc(
+			master->smmu, s2_parent, ictx, viommu_type, user_data);
+	if (PTR_ERR(vsmmu) == -EOPNOTSUPP) {
+		/* Otherwise, allocate an IOMMU_VIOMMU_TYPE_ARM_SMMUV3 here */
+		if (viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
+			vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu,
+						     core, &arm_vsmmu_ops);
+	}
 	if (IS_ERR(vsmmu))
 		return ERR_CAST(vsmmu);
 
-- 
2.43.0


