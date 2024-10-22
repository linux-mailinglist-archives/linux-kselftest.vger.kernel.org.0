Return-Path: <linux-kselftest+bounces-20346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A93449A94BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0991C213AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F14D14659C;
	Tue, 22 Oct 2024 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U/mr2qhO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F6813C9A6;
	Tue, 22 Oct 2024 00:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556440; cv=fail; b=pdClIiCnKPOk8QG5XGlzg9vetYXKMy916YYthJbAzw1c8kgmEbOibcyOF+trqRwWewF2FT6eVM0kY7akz6Zebro8O9BMA/jGvtCRZXdqMSoALhbfaL4dMRHywKQIR4wTXTv3aMpe9n51zT6dnNTq6thhEs3JeE90QIcpsqiSzRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556440; c=relaxed/simple;
	bh=D1zewypqefrSUjzrw6seFm6Ez+N+fww5CIhLxkto8dU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvPWv4GFoR0EhIDbka8+ln3Q7rNcEpS2SfaFG2c9+nVcPiRL6TsXU3M7Em4TiMWJBuSnkOw2+0i1lh/dM6hiaDdz22yhp2bJi4k2QBsuwm45I+x6Ks1UBZBPnxKSzKIa7x3SH1V9d/WTNIITvmhVxLYwVIE00EIQJDtlvYPze00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U/mr2qhO; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYqI4ahD3iCsXpvAZQLzIh1eGw8+pejD6kqv29Ksx6zmUf4pkUjENMBWBWBtrf7Bu2N9NuWfb7yowHLukSiTBdDhP6sUAAXmsjz72jTdk8AHxS/RCqFpfmLD3AtwIyvBr7GhOrnv7R+4VgPKDUxIKTw5CHYVxBAqE2ng3XArd8R9GpkSIuQNA+P51nOjhDji72TP8U253AQZ1TYoO04Mw6SQc8B4tQW/TpMo4T6id3F1OdUZwsgimJeNaz0e2qC7W1BLexruqm/F3w16XqAceSbhzDZu8zimwUgXMRMIUAB45nvBAElkHtjDlNUHQcCBBg73nAkbvjfjhinEHTPfpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PYa9vSbGvH7vEQ33iwiogecOJxQ0Z0Hkgn0098ZFTo=;
 b=AEASiNV4BMCdLlEPblVjueMojAbfNhRMZt6HneROURNrDIPFbclpLvS0B61on52n0r5L05MuIQHqn2gd80W+7gt2PGvFnSBmp7FsTb5ku275Rp/mgR3/ZrozUMahwD9YNXa259mgbnqBoiwen3r5r+ZM6eNW/HmPZs8TnTZbVBhGCURCJzooJqFXEW7mPDuIZIHucqCYd8IDuJQpK9dSrA1+LCFGrLg8VW1psKNH8MXuzcMAmokL0siOUV+aEsHnXQBdCdS0D7PLc76tphMV6XzuqWTu5Rbt3Bu0wIWk8eqjHsdhDRPQ+rGDvotEYcpZuOQzFDQkaEQMS3K5D5HzpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PYa9vSbGvH7vEQ33iwiogecOJxQ0Z0Hkgn0098ZFTo=;
 b=U/mr2qhOOnA7veskb0ps8oI4ODlpiJAVymtpPCxSa7ZDpLoECRXbenqSONrJ2H6SEnOfzPP56IN/iNE0Z6DQfwukMJoR+gwq6cPcFJQRqoOcIQYMKMnDgh48NDcBzwmINT3q/RXMOBpw+13hLa68giEWXa4dnkeLKwB+O2cP2Rm0hOquMQQQs2MaKCaLy6QwKEg9KIC6QylCX1OxxNfy+PVdZ4DmJ+JUG/yhIEd5lfD3sXDB04kMfeDNW+VakR12EUMZ2ktwjK7q3v2EdkF7SKPZqkJxzlZvGM6sjJ97ZvgEXJ8sYygWN3mpvTzXNHaGynyYIPDOH9BXOQk8E06P4w==
Received: from CH0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:610:b0::30)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Tue, 22 Oct 2024 00:20:32 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::86) by CH0PR03CA0025.outlook.office365.com
 (2603:10b6:610:b0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:16 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v4 11/11] iommu/arm-smmu-v3: Add IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support
Date: Mon, 21 Oct 2024 17:19:33 -0700
Message-ID: <2180fdf423d0f2fcc5c031687690100b12c2ba51.1729553811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729553811.git.nicolinc@nvidia.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: f825288c-75dd-409e-dd07-08dcf22f5759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+xWBkhnQKCM8cYW8/birDoG0OTXP1N8Kg3NN8kWTm9veASJoBc4T4pJL1QrL?=
 =?us-ascii?Q?GjaTr2AFrLp3PcGf9096jZ6Zc0+gTgt7xJldQQzvWaqYW3EEOZ8tVrHB+ErO?=
 =?us-ascii?Q?KzUPHQEcq0mrQkVJjia5EHPtYOdfSrtnYJWP1Q4uEyQCl31eM81QtRD0L1C+?=
 =?us-ascii?Q?rNb3hZ4foYEs6EjPakMwzg2me3OGBfg3sNsFMaeMMvkuI+lBeXB3Zh1j/eTS?=
 =?us-ascii?Q?SkMcpJoPSaXjqwpp2VbC+7ifXxeat4QcxCqds5m29LA/1VdBirw/r2dfBA0J?=
 =?us-ascii?Q?OeombE20J/dY0owgGLvIojph+ys3GFk6nbzHlLgrCWNvMY+JT1YpL/JKhQ9d?=
 =?us-ascii?Q?+7rJFzXAI4+Px95NSlniz8DA3IvTXEza7xLPcxC4C6wpj+qPW9gjNrs6wQoJ?=
 =?us-ascii?Q?Bwe4AWSWOf3QOfFWWFlQ3irm8O0rv9JwxLkiHn6Nyt2i7gpb7K1PcBGFTsQ7?=
 =?us-ascii?Q?N5nYxcFSEibEEXq2xMS7buEiH5dkJmULuZKuxkJx+Mf06rJQuRTHG8fFH64A?=
 =?us-ascii?Q?8QBiuWenHjqLKIO1UwLLbaHB7i2/DKj+LlBcfBUYcRsJcxcDZ/qHGTP+Aex+?=
 =?us-ascii?Q?BOB8muLABy+4C4JtDW7v6Uf1/zc+hVRKJpOd2pAWfgSfyrsh4tjewg0dO9zU?=
 =?us-ascii?Q?4J3TYye9kpK2jynJwbf4HH9P2idCrdPnOvUgsV99YQ64o3LQFSTKpYT18i4a?=
 =?us-ascii?Q?M+PJHLiejaaCMmBur7sOiBNhMls/idjRSlZOO8ArL5huf+kMmwHmFmlyd82O?=
 =?us-ascii?Q?ih+CDxp5TpQUgD/ZUHft8VE6smZuFcC7m9rLZg4xtOiBEeLWOyiVCcNPNX7x?=
 =?us-ascii?Q?st1xGmM7wfjC2aI1F3tWEpEL0MdKH1ok13bi8Ov44ELH9H2apD5XONdpYpHd?=
 =?us-ascii?Q?SNK87f7ddp1qoZryvpe9kQVEteeTf741uuxb+t3OvPaPachFwdtyjHmhWz/1?=
 =?us-ascii?Q?D1o84oQlulIwoIzVCsgZlnwtxzuwhv9VIfgws5Z1YFM4C/+mZgXp1WyYMYkM?=
 =?us-ascii?Q?pj4CJ+HMeeXChSS9RjAZ+h/GUv6WFcf5RUuwhjj7sBlXCifIp/AIT4D5v2GU?=
 =?us-ascii?Q?MyCJN4z6KU40ps4K68+n6v4KrafUwdkNNn/eCJnWdR6E+I94faH3z28Olelb?=
 =?us-ascii?Q?huPW70yA0iFFIqSlKa5JN19NGxnwsH2U33dRzXp69Q6pJVK59297BUUyJXyF?=
 =?us-ascii?Q?piVZuUmWLUiga7/5Lybr5HqEp6JJ5HqnJo/fklQx2ztrl6AQA/m4/oZyvfEP?=
 =?us-ascii?Q?9i0C40xivGmfgO7IfoOC+R4swhbvkSg3JEPqVUAIgHvOXWAYEfcrAaVBxJBW?=
 =?us-ascii?Q?6jcq0ss4/DPKMMdBpPXpE/y70mGngqAkR7Qe/ewHvju/ypO1RNueAPmJunn6?=
 =?us-ascii?Q?KaXMjWkHD4s+uTEELyol0xleMcKD1qLLxLSX2rIYbTY9qGbTSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:32.1253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f825288c-75dd-409e-dd07-08dcf22f5759
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373

Add a new driver-type for ARM SMMUv3 to enum iommu_viommu_type. Implement
an arm_vsmmu_alloc() with its viommu op arm_vsmmu_domain_alloc_nested(),
to replace arm_smmu_domain_alloc_nesting(). As an initial step, copy the
VMID from s2_parent. A later cleanup series is required to move the VMID
allocation out of the stage-2 domain allocation routine to this.

After that, replace nested_domain->s2_parent with nested_domain->vsmmu.

Note that the validatting conditions for a nested_domain allocation are
moved from arm_vsmmu_domain_alloc_nested to arm_vsmmu_alloc, since there
is no point in creating a vIOMMU (vsmmu) from the beginning if it would
not support a nested_domain.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 26 +++---
 include/uapi/linux/iommufd.h                  |  2 +
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 79 ++++++++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  9 +--
 4 files changed, 70 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 956c12637866..5a025d310dbe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -10,6 +10,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <linux/kernel.h>
 #include <linux/mmzone.h>
 #include <linux/sizes.h>
@@ -835,7 +836,7 @@ struct arm_smmu_domain {
 
 struct arm_smmu_nested_domain {
 	struct iommu_domain domain;
-	struct arm_smmu_domain *s2_parent;
+	struct arm_vsmmu *vsmmu;
 
 	__le64 ste[2];
 };
@@ -1005,21 +1006,22 @@ tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
 }
 #endif /* CONFIG_TEGRA241_CMDQV */
 
+struct arm_vsmmu {
+	struct iommufd_viommu core;
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_domain *s2_parent;
+	u16 vmid;
+};
+
 #if IS_ENABLED(CONFIG_ARM_SMMU_V3_IOMMUFD)
 void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type);
-struct iommu_domain *
-arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
-			      struct iommu_domain *parent,
-			      const struct iommu_user_data *user_data);
+struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
+				       struct iommu_domain *parent,
+				       struct iommufd_ctx *ictx,
+				       unsigned int viommu_type);
 #else
 #define arm_smmu_hw_info NULL
-static inline struct iommu_domain *
-arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
-			      struct iommu_domain *parent,
-			      const struct iommu_user_data *user_data)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
+#define arm_vsmmu_alloc NULL
 #endif /* CONFIG_ARM_SMMU_V3_IOMMUFD */
 
 #endif /* _ARM_SMMU_V3_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index f835ccf4a494..09c1b4ba46d8 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -859,9 +859,11 @@ struct iommu_fault_alloc {
 /**
  * enum iommu_viommu_type - Virtual IOMMU Type
  * @IOMMU_VIOMMU_TYPE_DEFAULT: Reserved for future use
+ * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
  */
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
+	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
 };
 
 /**
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 44e1b9bef850..70ad857a57b8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -34,7 +34,8 @@ static void arm_smmu_make_nested_cd_table_ste(
 	struct arm_smmu_ste *target, struct arm_smmu_master *master,
 	struct arm_smmu_nested_domain *nested_domain, bool ats_enabled)
 {
-	arm_smmu_make_s2_domain_ste(target, master, nested_domain->s2_parent,
+	arm_smmu_make_s2_domain_ste(target, master,
+				    nested_domain->vsmmu->s2_parent,
 				    ats_enabled);
 
 	target->data[0] = cpu_to_le64(STRTAB_STE_0_V |
@@ -75,7 +76,8 @@ static void arm_smmu_make_nested_domain_ste(
 		break;
 	case STRTAB_STE_0_CFG_BYPASS:
 		arm_smmu_make_s2_domain_ste(
-			target, master, nested_domain->s2_parent, ats_enabled);
+			target, master, nested_domain->vsmmu->s2_parent,
+			ats_enabled);
 		break;
 	case STRTAB_STE_0_CFG_ABORT:
 	default:
@@ -100,7 +102,7 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 	struct arm_smmu_ste ste;
 	int ret;
 
-	if (nested_domain->s2_parent->smmu != master->smmu)
+	if (nested_domain->vsmmu->smmu != master->smmu)
 		return -EINVAL;
 	if (arm_smmu_ssids_in_use(&master->cd_table))
 		return -EBUSY;
@@ -151,36 +153,15 @@ static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg)
 	return 0;
 }
 
-struct iommu_domain *
-arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
-			      struct iommu_domain *parent,
+static struct iommu_domain *
+arm_vsmmu_domain_alloc_nested(struct iommufd_viommu *viommu,
 			      const struct iommu_user_data *user_data)
 {
-	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
 	struct arm_smmu_nested_domain *nested_domain;
-	struct arm_smmu_domain *smmu_parent;
 	struct iommu_hwpt_arm_smmuv3 arg;
 	int ret;
 
-	if (flags || !(master->smmu->features & ARM_SMMU_FEAT_NESTING))
-		return ERR_PTR(-EOPNOTSUPP);
-
-	/*
-	 * Must support some way to prevent the VM from bypassing the cache
-	 * because VFIO currently does not do any cache maintenance.
-	 */
-	if (!arm_smmu_master_canwbs(master) &&
-	    !(master->smmu->features & ARM_SMMU_FEAT_S2FWB))
-		return ERR_PTR(-EOPNOTSUPP);
-
-	/*
-	 * The core code checks that parent was created with
-	 * IOMMU_HWPT_ALLOC_NEST_PARENT
-	 */
-	smmu_parent = to_smmu_domain(parent);
-	if (smmu_parent->smmu != master->smmu)
-		return ERR_PTR(-EINVAL);
-
 	ret = iommu_copy_struct_from_user(&arg, user_data,
 					  IOMMU_HWPT_DATA_ARM_SMMUV3, ste);
 	if (ret)
@@ -196,9 +177,51 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 
 	nested_domain->domain.type = IOMMU_DOMAIN_NESTED;
 	nested_domain->domain.ops = &arm_smmu_nested_ops;
-	nested_domain->s2_parent = smmu_parent;
+	nested_domain->vsmmu = vsmmu;
 	nested_domain->ste[0] = arg.ste[0];
 	nested_domain->ste[1] = arg.ste[1] & ~cpu_to_le64(STRTAB_STE_1_EATS);
 
 	return &nested_domain->domain;
 }
+
+
+static const struct iommufd_viommu_ops arm_vsmmu_ops = {
+	.domain_alloc_nested = arm_vsmmu_domain_alloc_nested,
+};
+
+struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
+				       struct iommu_domain *parent,
+				       struct iommufd_ctx *ictx,
+				       unsigned int viommu_type)
+{
+	struct arm_smmu_device *smmu =
+		iommu_get_iommu_dev(dev, struct arm_smmu_device, iommu);
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_domain *s2_parent = to_smmu_domain(parent);
+	struct arm_vsmmu *vsmmu;
+
+	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	/*
+	 * Must support some way to prevent the VM from bypassing the cache
+	 * because VFIO currently does not do any cache maintenance.
+	 */
+	if (!arm_smmu_master_canwbs(master) &&
+	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	vsmmu = iommufd_viommu_alloc(ictx, arm_vsmmu, core, &arm_vsmmu_ops);
+	if (IS_ERR(vsmmu))
+		return ERR_CAST(vsmmu);
+
+	vsmmu->smmu = smmu;
+	vsmmu->s2_parent = s2_parent;
+	/* FIXME Move VMID allocation from the S2 domain allocation to here */
+	vsmmu->vmid = s2_parent->s2_cfg.vmid;
+
+	return &vsmmu->core;
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c7cc98961019..de598d66b5c2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2661,7 +2661,7 @@ to_smmu_domain_devices(struct iommu_domain *domain)
 	    domain->type == IOMMU_DOMAIN_SVA)
 		return to_smmu_domain(domain);
 	if (domain->type == IOMMU_DOMAIN_NESTED)
-		return to_smmu_nested_domain(domain)->s2_parent;
+		return to_smmu_nested_domain(domain)->vsmmu->s2_parent;
 	return NULL;
 }
 
@@ -3126,13 +3126,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 	struct arm_smmu_domain *smmu_domain;
 	int ret;
 
-	if (parent)
-		return arm_smmu_domain_alloc_nesting(dev, flags, parent,
-						     user_data);
-
 	if (flags & ~PAGING_FLAGS)
 		return ERR_PTR(-EOPNOTSUPP);
-	if (user_data)
+	if (parent || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	smmu_domain = arm_smmu_domain_alloc();
@@ -3541,6 +3537,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
 	.page_response		= arm_smmu_page_response,
 	.def_domain_type	= arm_smmu_def_domain_type,
+	.viommu_alloc		= arm_vsmmu_alloc,
 	.user_pasid_table	= 1,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 	.owner			= THIS_MODULE,
-- 
2.43.0


