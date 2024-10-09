Return-Path: <linux-kselftest+bounces-19387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8626B99721B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5B9282507
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9899C1E9096;
	Wed,  9 Oct 2024 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="omHmj42J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7881D1E9087;
	Wed,  9 Oct 2024 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491978; cv=fail; b=gDqx0vNXmpclLZ05wPmGqRzjge0Gh5SkfPTgJKF+qL4Hqaidqm0h7IW5WTWrzAV5wZH7jKjhRr5RZed71jqK/arEkUJG/n+wWfIFKLX7WUCy7hOiM3sfmRzYNlRA9z/t4Q/K86VW8h6x7mYSIttTjgKN59FaGIrRc992aS2u8Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491978; c=relaxed/simple;
	bh=Ls0Tn8QRfGRJ8J9TvRXrDZwd+HbX7IeRQ6tt6toigFY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mY3tMLb83uPWn3s5cfUoucii4XuNWTDUUIB9UxLD24xH/MiEpi3JWAxyJRhmg0h3Dc2oVM+v7E95xhQ4JFx3sBsW7TSXD3qxImd72GKxzS2x1GarBUtPLix9BXguhVDLyvTMz4zgRE7oQCaCvs7AkDpE6oupPDj7hC1WgrVOy2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=omHmj42J; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXmRqyQ1h11lqqeSYcMgE/Q7Y0qXltEipEkjH1GyZv2lqzPKYuD6e3lMyqNeQZ84/VB7+8vC1hBXi8uiwf3yJZok6EdFfvhsrfmVEiN/XpxiZYBbOFMcHJinnh3V6LdU9Vzdxub4fV08D536s1hscSoelsboBhUTvB4p7NUy9igoai55m30Q1UaHrcSGNc3MC7heAyzHeenykgzBFrb/C5RUa2fiWW+L41unm32EG2nJEgglikvR8BbZ0LKaZlf0FQUCIHt8jAW8WfoXVxlckLlUMksv53jgSMDUD2d8oQuzpgDsd7+OP/0QhrwuPB+aLkrFdRSrQD1BCuhEBYF9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xr5DrQg+G8cc8Z6dXFXieKIV4iiNu6QvzVxFa7fDZHI=;
 b=qZ6kJ7qgeRjGr1sYJMpnPxclVMkJF+Kwi6avYL4CLHyDQElL9Ft0fAdCqs2Hypa8XYeIEejTAmFMdB546Jur/TEnHDrhR9dLVewhsHCyFE30taHtvFILT2UKnS5V+4XrXeMvTs4+ysSLNzUfYX83MNUn0vttiVOBG4ZgR+su71ERX6plmgSw1QUE150LVEkit70MVPUZy16VbGnw/aS+Qj425pLVTYW0pjeLp+rxZOAZUskbe080zT2Xs7ybUIK6DI9V9ALvPM0OSR3GiDpJjb2IVqwUZ7LVln0N96pkAz83m4TyjZW0Wh/b2uHU0yke27D5Tl8/K84Unvuuucn+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xr5DrQg+G8cc8Z6dXFXieKIV4iiNu6QvzVxFa7fDZHI=;
 b=omHmj42JfieeE+yv2daKJ07i8S63yv4TBc6kHz9A1daXdExg7d/UBJlfvfK4PvZ0v4CTfh0O7zVuzZuWlgXnThwlU9hDdjW2WwAzSmoTSATQjp6jzgSffdG5ZLd+axW917VxpAqiUpIz/2s3NCEEIJa5FlTGrlFJDMyxhaKjRy46tZKaVy59LQSWZ7L/1XDScd3VEnBgFzZ4UaHTQiDb29Awk3V64W68JtqSh/gLcW2STDKJ3wbyvLr5UbzUURngP5iQ2FTy6ebPiuCF0jv6EGsyaY70dU91LFIASraeZMg7o+Rt8n3YA1gu0EQ5Sb6gAbqQzy6+zuciqKy3/WFSkw==
Received: from SN6PR01CA0026.prod.exchangelabs.com (2603:10b6:805:b6::39) by
 DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Wed, 9 Oct 2024 16:39:25 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:805:b6:cafe::72) by SN6PR01CA0026.outlook.office365.com
 (2603:10b6:805:b6::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:39:15 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:39:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:39:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v3 14/16] iommu/arm-smmu-v3: Add arm_vsmmu_cache_invalidate
Date: Wed, 9 Oct 2024 09:38:26 -0700
Message-ID: <d714a9d107696194cc63e5f6c2b6bf5877b37f68.1728491532.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491532.git.nicolinc@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a3db6f-b132-40b4-fa31-08dce880efce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FuhbHLYqiUVQtBmDjd82dpZ0I8Lu0fGConN5xnj0bmKTW0z0SShQpJ7DunDA?=
 =?us-ascii?Q?hw+QmtA8Kfd1arKzmhRKbWWXwg7Zq7r69VCMtUZ6KFJm4du4TWu00ZkrkuKO?=
 =?us-ascii?Q?bkI6moI7hzyeCwU8G6aikBUWDU0Ot1kedPd56HHgvY0RX144EB8dDqCmLyYE?=
 =?us-ascii?Q?olanNgSE8HWq7ySO8EJuBbGWfTcCSJ7k26wGIkDeisVw7UgxXH9Sc2W5D1pC?=
 =?us-ascii?Q?L/NLb4tjm/stZCm8bgHif8z6WB+IMW/DHWYATg8XpwYnLv83URW+CbsFeN17?=
 =?us-ascii?Q?SQV9Kl6Gp1RIGU7XCWEo1X5LYZILSWWX/VQXckFgQxCtY5V/Z6x+w893zdOY?=
 =?us-ascii?Q?cp5L+XI6LTY1BL470tCRyVhUJg0jzK1K3MFbWNO6a1y0Ad5VBZZqfx7UzW5G?=
 =?us-ascii?Q?ZG+fOkShJLjUMy+EUF8xK5hGPOQK1caYJjkpsL8/vewOh+hWhcx3Cx8Jb4Pl?=
 =?us-ascii?Q?MbyVStlH287P8xheC71PVuKIO/vIWYECG1NLr+dCjn1d/6p17HfQn13fRdqG?=
 =?us-ascii?Q?IRlBiDFtgdANjaK3JqVt4gxS+wXiPx5zbGfSNvNqSkoIQUjPG79AZo26uFK2?=
 =?us-ascii?Q?+snfX3C3SuiOugxdXHLuIfJ2cD02t5BTppYTeZq1H1E/FT/MTthBLGYe8hYs?=
 =?us-ascii?Q?XW9odFDkR77ra0U8uz9XX6Xm3AEwysEIj+2fI66zSgZCPRbUkT/dbZcSAhhP?=
 =?us-ascii?Q?K0Y2eWVKTj/B2Dvzw2oQ0ku6LtLG8RsBb8OPjFeZPKBv7KKeH1vsMGFLVQvk?=
 =?us-ascii?Q?Gf6User6GMGlNUZIbHxJVXglwrkdZg+5ipj82o58tYipwhXRRe5Dwd1xDzey?=
 =?us-ascii?Q?UxAzBqh/j0/SZFqU3Y/MvQ0YLDSjzKafqscgxYaCSThrPOdubbCclpQWt7gx?=
 =?us-ascii?Q?cnVzcW8gcx5+ur5ndHbGUH0dLNH6dnHjLij4kR3WMZtcp9MJdqtwAp4J3plD?=
 =?us-ascii?Q?mXxtfaQo+ch4eaZtYta6B2ZxzJ7TFESRkYvZuWLpn7vpyD6SrnFZjGOZjQ6C?=
 =?us-ascii?Q?t/JKgJu57BLxugopTYlV3Lw+oswmiPnhTrsH5hRdio4XcB7/AHc4utoY2ied?=
 =?us-ascii?Q?YjiiALFNKwbV5D+JfkOQTegEkeyn8tn3Ke+oesxj6WePcEVXmPKrD1Wdl7Gp?=
 =?us-ascii?Q?RcmSWHu+odB6cwrHRlZnLX7i0zGM6zVd+ICIw3it5MWuEyXm3uzDEUyARAUd?=
 =?us-ascii?Q?e5Lm6EypwFgeSaPHG8LcBtHdK3CwS8aGF1+3KzV+uIlkWfQ1R9r61+TDISrt?=
 =?us-ascii?Q?5QzBJdw6IGhglN83pTM3ERDY5dvpDf1BDi9hGdWDM9WdFLn0HVmDjv4C58aG?=
 =?us-ascii?Q?Hx+kScLTwhMIUT/QwMwGQsgXQWd9yjJUMM7pxFcFg3KC8kyz1D5xpEVoAXE2?=
 =?us-ascii?Q?0Mze280XDd7l3lmonEp9Vt8iUaq1?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:25.5294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a3db6f-b132-40b4-fa31-08dce880efce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993

Implement the vIOMMU's cache_invalidate op for user space to invalidate the
IOTLB entries, Device ATS and CD entries that are still cached by hardware.

Add struct iommu_viommu_arm_smmuv3_invalidate defining invalidation entries
that are simply in the native format of a 128-bit TLBI command. Scan those
commands against the permitted command list and fix their VMID/SID fields.

Co-developed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   5 +
 include/uapi/linux/iommufd.h                  |  24 ++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 131 +++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   6 +-
 4 files changed, 162 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 844d1dfdea55..000af931a30c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -529,6 +529,7 @@ struct arm_smmu_cmdq_ent {
 		#define CMDQ_OP_TLBI_NH_ALL     0x10
 		#define CMDQ_OP_TLBI_NH_ASID	0x11
 		#define CMDQ_OP_TLBI_NH_VA	0x12
+		#define CMDQ_OP_TLBI_NH_VAA	0x13
 		#define CMDQ_OP_TLBI_EL2_ALL	0x20
 		#define CMDQ_OP_TLBI_EL2_ASID	0x21
 		#define CMDQ_OP_TLBI_EL2_VA	0x22
@@ -949,6 +950,10 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state);
 void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 				  const struct arm_smmu_ste *target);
 
+int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
+				bool sync);
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index cd9e135ef563..d9e510ce67cf 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -684,9 +684,11 @@ struct iommu_hwpt_get_dirty_bitmap {
  * enum iommu_hwpt_invalidate_data_type - IOMMU HWPT Cache Invalidation
  *                                        Data Type
  * @IOMMU_HWPT_INVALIDATE_DATA_VTD_S1: Invalidation data for VTD_S1
+ * @IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3: Invalidation data for ARM SMMUv3
  */
 enum iommu_hwpt_invalidate_data_type {
 	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1 = 0,
+	IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3 = 1,
 };
 
 /**
@@ -725,6 +727,28 @@ struct iommu_hwpt_vtd_s1_invalidate {
 	__u32 __reserved;
 };
 
+/**
+ * struct iommu_viommu_arm_smmuv3_invalidate - ARM SMMUv3 cahce invalidation
+ *         (IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3)
+ * @cmd: 128-bit cache invalidation command that runs in SMMU CMDQ.
+ *       Must be little-endian.
+ *
+ * Supported command list only when passing in a vIOMMU via @hwpt_id:
+ *     CMDQ_OP_TLBI_NSNH_ALL
+ *     CMDQ_OP_TLBI_NH_VA
+ *     CMDQ_OP_TLBI_NH_VAA
+ *     CMDQ_OP_TLBI_NH_ALL
+ *     CMDQ_OP_TLBI_NH_ASID
+ *     CMDQ_OP_ATC_INV
+ *     CMDQ_OP_CFGI_CD
+ *     CMDQ_OP_CFGI_CD_ALL
+ *
+ * -EIO will be returned if the command is not supported.
+ */
+struct iommu_viommu_arm_smmuv3_invalidate {
+	__aligned_le64 cmd[2];
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 5e235fca8f13..1b82579eb252 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -191,6 +191,14 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 	if (smmu_parent->smmu != master->smmu)
 		return ERR_PTR(-EINVAL);
 
+	/*
+	 * FORCE_SYNC is not set with FEAT_NESTING. Some study of the exact HW
+	 * defect is needed to determine if arm_vsmmu_cache_invalidate() needs
+	 * any change to remove this.
+	 */
+	if (WARN_ON(master->smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	ret = iommu_copy_struct_from_user(&arg, user_data,
 					  IOMMU_HWPT_DATA_ARM_SMMUV3, ste);
 	if (ret)
@@ -213,6 +221,127 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 	return &nested_domain->domain;
 }
 
+static int arm_vsmmu_vsid_to_sid(struct arm_vsmmu *vsmmu, u32 vsid, u32 *sid)
+{
+	XA_STATE(xas, &vsmmu->core.vdevs, (unsigned long)vsid);
+	struct arm_smmu_master *master;
+	struct device *dev;
+	int ret = 0;
+
+	xa_lock(&vsmmu->core.vdevs);
+	dev = vdev_to_dev(xas_load(&xas));
+	if (!dev) {
+		ret = -EIO;
+		goto unlock;
+	}
+	master = dev_iommu_priv_get(dev);
+
+	/* At this moment, iommufd only supports PCI device that has one SID */
+	if (sid)
+		*sid = master->streams[0].id;
+unlock:
+	xa_unlock(&vsmmu->core.vdevs);
+	return ret;
+}
+
+/*
+ * Convert, in place, the raw invalidation command into an internal format that
+ * can be passed to arm_smmu_cmdq_issue_cmdlist(). Internally commands are
+ * stored in CPU endian.
+ *
+ * Enforce the VMID or SID on the command.
+ */
+static int
+arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
+			   struct iommu_viommu_arm_smmuv3_invalidate *cmd)
+{
+	cmd->cmd[0] = le64_to_cpu(cmd->cmd[0]);
+	cmd->cmd[1] = le64_to_cpu(cmd->cmd[1]);
+
+	switch (cmd->cmd[0] & CMDQ_0_OP) {
+	case CMDQ_OP_TLBI_NSNH_ALL:
+		/* Convert to NH_ALL */
+		cmd->cmd[0] = CMDQ_OP_TLBI_NH_ALL |
+			      FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
+		cmd->cmd[1] = 0;
+		break;
+	case CMDQ_OP_TLBI_NH_VA:
+	case CMDQ_OP_TLBI_NH_VAA:
+	case CMDQ_OP_TLBI_NH_ALL:
+	case CMDQ_OP_TLBI_NH_ASID:
+		cmd->cmd[0] &= ~CMDQ_TLBI_0_VMID;
+		cmd->cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
+		break;
+	case CMDQ_OP_ATC_INV:
+	case CMDQ_OP_CFGI_CD:
+	case CMDQ_OP_CFGI_CD_ALL:
+		u32 sid, vsid = FIELD_GET(CMDQ_CFGI_0_SID, cmd->cmd[0]);
+
+		if (arm_vsmmu_vsid_to_sid(vsmmu, vsid, &sid))
+			return -EIO;
+		cmd->cmd[0] &= ~CMDQ_CFGI_0_SID;
+		cmd->cmd[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, sid);
+		break;
+	default:
+		return -EIO;
+	}
+	return 0;
+}
+
+static int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
+				      struct iommu_user_data_array *array)
+{
+	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
+	struct iommu_viommu_arm_smmuv3_invalidate *last;
+	struct iommu_viommu_arm_smmuv3_invalidate *cmds;
+	struct iommu_viommu_arm_smmuv3_invalidate *cur;
+	struct iommu_viommu_arm_smmuv3_invalidate *end;
+	struct arm_smmu_device *smmu = vsmmu->smmu;
+	int ret;
+
+	cmds = kcalloc(array->entry_num, sizeof(*cmds), GFP_KERNEL);
+	if (!cmds)
+		return -ENOMEM;
+	cur = cmds;
+	end = cmds + array->entry_num;
+
+	static_assert(sizeof(*cmds) == 2 * sizeof(u64));
+	ret = iommu_copy_struct_from_full_user_array(
+		cmds, sizeof(*cmds), array,
+		IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3);
+	if (ret)
+		goto out;
+
+	last = cmds;
+	while (cur != end) {
+		ret = arm_vsmmu_convert_user_cmd(vsmmu, cur);
+		if (ret)
+			goto out;
+
+		/* FIXME work in blocks of CMDQ_BATCH_ENTRIES and copy each block? */
+		cur++;
+		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1)
+			continue;
+
+		/* FIXME always uses the main cmdq rather than trying to group by type */
+		ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, last->cmd,
+						  cur - last, true);
+		if (ret) {
+			cur--;
+			goto out;
+		}
+		last = cur;
+	}
+out:
+	array->entry_num = cur - cmds;
+	kfree(cmds);
+	return ret;
+}
+
+const struct iommufd_viommu_ops arm_vsmmu_ops = {
+	.cache_invalidate = arm_vsmmu_cache_invalidate,
+};
+
 struct iommufd_viommu *
 arm_vsmmu_alloc(struct iommu_device *iommu_dev, struct iommu_domain *parent,
 		struct iommufd_ctx *ictx, unsigned int viommu_type)
@@ -225,7 +354,7 @@ arm_vsmmu_alloc(struct iommu_device *iommu_dev, struct iommu_domain *parent,
 	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	vsmmu = iommufd_viommu_alloc(ictx, arm_vsmmu, core, NULL);
+	vsmmu = iommufd_viommu_alloc(ictx, arm_vsmmu, core, &arm_vsmmu_ops);
 	if (IS_ERR(vsmmu))
 		return ERR_CAST(vsmmu);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6a23e6dcd5cf..a2bbd140e232 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -766,9 +766,9 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
  *   insert their own list of commands then all of the commands from one
  *   CPU will appear before any of the commands from the other CPU.
  */
-static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
-				       struct arm_smmu_cmdq *cmdq,
-				       u64 *cmds, int n, bool sync)
+int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
+				bool sync)
 {
 	u64 cmd_sync[CMDQ_ENT_DWORDS];
 	u32 prod;
-- 
2.43.0


