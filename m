Return-Path: <linux-kselftest+bounces-20747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B802F9B139C
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE641C21CCA
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EF121FD81;
	Fri, 25 Oct 2024 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TKgU2cLb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0B216E03;
	Fri, 25 Oct 2024 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900284; cv=fail; b=H9ZTRph8xaOFPNLdUSki/4G2Pb+uAUnVvf/9MpAS7geyAjmeyuY/rH0XlRMaE+pg8o8SO+cSajJnvmpgsudyPsAS5R2tDp7na2q4tT0mFFZ7E61wkWBR6PRETsdHQTwEx3+CmsBSNDei1t8UQIUG2IqZGdLHkD3UQVxp8G67yEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900284; c=relaxed/simple;
	bh=Eu6XWs3rpVlKBng75kJOpigKxUqnkduMIJWjkbUFCxM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ff1Xf+mwtZzNxtRaOkxyMBgg8aIC78nrdjZr1tTjbeBrzp8+W5R47JDmRnV0Vr2ufmcd4CFL68sBz9DVYVzZqBdMIAnOg8wEPoivQDTKT+mB8eBefF2YKC3JjlB+XGrNENDY2RqMzKneIvFZ9PC7lhwHxbHomlMVI3tcXutFbmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TKgU2cLb; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGsRQDCXcqAcsHeYQiEVn4lMGF4V7zOn/yo8hWIkwKF+YmFI4mXF/eq7nJQ1/pK4Zy5s5lr7K8c0hBXUHqgKLUQmEDxBq8n3A8VvSqT8y+j5dclTv4IHMq5GRHQKWnBFg+t8Dxy5vQM+IE5H/s9sj6zhbAlahXf2olHkWMTxaSJWY6gUtTX13ch3+bReY7rBNmpkYIdS1T0M3Ns5Dmhj5XPAGEaP1gHpjFEzUwGG7hofmiQrNBHoNCnAp/aN3tDojxm6VMk98vqoPP5oXjqFm8f8L7j9ZK5c4/YVM5PL3uiAwpBhARMe1nIVM5xxk4ZyHI+1qSafW2LMXjI512zIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klNgxq4doYeESjjSjmv1yXG01PlVRtxfKFAm5gKvwXk=;
 b=SfZfASiaaEzcflWO5lQtio4CdT0Tv1SJwP1ZOhhfBSoh+OJ3tptFGVUwL5bxK6ZEdyCgikFksCCwa1psde4VPF544b8cCAzePPM7Wl8l7lBv0lx7hr6YlRLi/HklHLtMN6MNswisxtpyXU4Ciu7saOAFTsdlhOW2WhE+u6quNc6Urfw5Wrr3VQqCZL20sY8eFE1KJC4IOpJE0qIfXroDqh2mKuOSqdBeT0asILlBv2HNTRoqv+qyYisyf1HFRa2OxW51mAfvAoz1qOQetZL9aQNcl/1AYYi1VYWD682OmAi3vumhgaMUYReIajt1zmgQzdfdnPjUc8tEkXsWKwmD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klNgxq4doYeESjjSjmv1yXG01PlVRtxfKFAm5gKvwXk=;
 b=TKgU2cLbN+Bhq3lwvJDtVmUoh9KhZc1kvMN43644bBYoV2wmIgpc9wzz9PxbKqOXBSmH0GMKCTMshl0n0JrxCvA9KJZrFXU0sbiCxlFGt3F2UC/wWy7wbv54cVSu9C8cQBYY1jaV7H1V61cr4E7foWRemLhI4AraVx3CggUN0O0uxatKkZsjC081OZVQh191td2o0RNN+zORp+HYUSWA17+uhoHoaPfuNSzx3IzIRtKQ6debPmLgh01hnMk7AiX609mMmUz2lJC02YK8McEwKSxnhrPpSpcp2pjbQoLGYx68Gn5WzNlBePj68b61KElsEHi02s/lIXoWLkeB3q+Ogg==
Received: from BYAPR02CA0025.namprd02.prod.outlook.com (2603:10b6:a02:ee::38)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 23:51:18 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::77) by BYAPR02CA0025.outlook.office365.com
 (2603:10b6:a02:ee::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 23:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:51:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:51:05 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:51:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:51:03 -0700
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
Subject: [PATCH v5 12/13] iommu/arm-smmu-v3: Add arm_vsmmu_cache_invalidate
Date: Fri, 25 Oct 2024 16:50:41 -0700
Message-ID: <16cb47d80cfd37028f6d32231a785a3c486239f5.1729897278.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897278.git.nicolinc@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de8bf90-2e41-458d-f040-08dcf54feb57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?olA5H4JYP0ZDO2FZwfdhD90RqJPnfSzBOH0rPYDSgDEsAyeS12T0qO7bbxZs?=
 =?us-ascii?Q?icWQULFJkuDRi8KGyxeDDlL6FWid0G1GKFglEKusbKE/vJtu4yIgOb9wu+T8?=
 =?us-ascii?Q?reH/5EiifOKH0fqAVRkuyymz1n5o+p8bYZMVBOOIvMvY2dqf2Ap6zO+Lyz1Z?=
 =?us-ascii?Q?U1EyPhRW7rTAgEA7e3HZupQH/vcP399wzB0oyBywBolnn6jg26+k5//q0JTG?=
 =?us-ascii?Q?dwmLSH5alC4LU6svLoVvHFv3eHztZEcAfLYpHm8Hcrxv3NAdBV0Lw+XwbWGO?=
 =?us-ascii?Q?GP0x9rFdtJNoK1SiJ8mSXx5notKvZCBaHS3RGFKETMvogeRGdGWwnPfZqOJR?=
 =?us-ascii?Q?agmGmZ4HE9e9QDjRtd1dtom70bO/s89IQueKUp0ggf1QR/B50zQuftFtUkFA?=
 =?us-ascii?Q?2HB5d+8Tjp19fukpMXQhkYYXUSuEHqHcYheKmiGBs82mq06n13ll8vexQ1rD?=
 =?us-ascii?Q?dvW7j21ww9Vi/PGKbNqav3TbMU+YIsRTMbUgOO/TMho4TYn4sVkY//2d5BlB?=
 =?us-ascii?Q?AWVeZkGnrzowl+2ih98kvm2vYyWuHRDUtjczXW7ah3v1/KltOw5DK9vNg7Pc?=
 =?us-ascii?Q?wk4bZtF8dbBzv1xQ/R6E1OBmUIyNciwQgmM8hGrMQk3spDV4yK3XaShQj4ci?=
 =?us-ascii?Q?XfyFc34itfIY218ie/+b5CIzCFi6jZds84kCCsnBA2eMWY2ufsKEqWkNktpn?=
 =?us-ascii?Q?XHkUqjA3GzJRl3VoPGW83OMPhC2CTWU5Unz71bMe12DWGLyeXyH0rBveLolK?=
 =?us-ascii?Q?p02eJa79rBdMVXN9QqUT0mKD6KMMQJztNWQ2XQasF8iqr3n6QeMZ5yBTM6Rz?=
 =?us-ascii?Q?t54gSuPZGzG4+JFRz4h2GjsJTxclVIpr/Jms9NknRtARav33RHZVPxLVqhPO?=
 =?us-ascii?Q?uMcg7lV1bOa9FAzOk+sj12E3BpM7emlKJvfmtR/b8JcwXCpQvzExatsarWQJ?=
 =?us-ascii?Q?P4lxSFhBXbdqQeaF6CPXMPjzEGd+bswKhlz+dMNDFe7CfrHSEjTtP+8yfDgw?=
 =?us-ascii?Q?3ugAbd3kUfADrmZ0MVDjEZoxMoljLz/IPab75NzXMthiTDcGRVVN4+1nF2PU?=
 =?us-ascii?Q?e4gH5xBTR7ELTAJEd9cBGMws17MYrNsCZ6aMyt8jYjf56L/PRmj8L8vAqpqG?=
 =?us-ascii?Q?VBu7Xon6eDyMLSYz0JxcD6sVwyeP4r+KmYGmlYtZreTgPZThxLJJpa179faf?=
 =?us-ascii?Q?s5iEO6cg7KAa/+dML3eUhtuWBBGGnMM5oiAVGcOvFi5rAjR6iCn35pQLrzSE?=
 =?us-ascii?Q?fkiQKWIj6UNV/j+GzSLcZzaD3BNkllfM1lg0x96U67z3xe6hhrZ9gXsV3abZ?=
 =?us-ascii?Q?xCkthLkKsFAGK5apPsN/8lGkw/5sApb5949LnhatVfo9WkqiQmlJrLd+BngB?=
 =?us-ascii?Q?s5RKLGAZtSAz+ahrct4R12YOSQ3SFQPwzBGq4/c2QZ3jvPTFiQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:51:17.8460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de8bf90-2e41-458d-f040-08dcf54feb57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095

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
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 130 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   6 +-
 4 files changed, 162 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5a025d310dbe..8bd740f537ee 100644
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
index c2c5f49fdf17..8e66e2fde1dd 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -686,9 +686,11 @@ struct iommu_hwpt_get_dirty_bitmap {
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
@@ -727,6 +729,28 @@ struct iommu_hwpt_vtd_s1_invalidate {
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
index abb6d2868376..2479074db820 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -184,9 +184,131 @@ arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu,
 	return &nested_domain->domain;
 }
 
+static int arm_vsmmu_vsid_to_sid(struct arm_vsmmu *vsmmu, u32 vsid, u32 *sid)
+{
+	struct arm_smmu_master *master;
+	struct device *dev;
+	int ret = 0;
+
+	xa_lock(&vsmmu->core.vdevs);
+	dev = iommufd_viommu_find_dev(&vsmmu->core, (unsigned long)vsid);
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
+/* This is basically iommu_viommu_arm_smmuv3_invalidate in u64 for conversion */
+struct arm_vsmmu_invalidation_cmd {
+	u64 cmd[2];
+};
+
+/*
+ * Convert, in place, the raw invalidation command into an internal format that
+ * can be passed to arm_smmu_cmdq_issue_cmdlist(). Internally commands are
+ * stored in CPU endian.
+ *
+ * Enforce the VMID or SID on the command.
+ */
+static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
+				      struct arm_vsmmu_invalidation_cmd *cmd)
+{
+	/* Commands are le64 stored in u64 */
+	cmd->cmd[0] = le64_to_cpu((__force __le64)cmd->cmd[0]);
+	cmd->cmd[1] = le64_to_cpu((__force __le64)cmd->cmd[1]);
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
+	case CMDQ_OP_CFGI_CD_ALL: {
+		u32 sid, vsid = FIELD_GET(CMDQ_CFGI_0_SID, cmd->cmd[0]);
+
+		if (arm_vsmmu_vsid_to_sid(vsmmu, vsid, &sid))
+			return -EIO;
+		cmd->cmd[0] &= ~CMDQ_CFGI_0_SID;
+		cmd->cmd[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, sid);
+		break;
+	}
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
+	struct arm_smmu_device *smmu = vsmmu->smmu;
+	struct arm_vsmmu_invalidation_cmd *last;
+	struct arm_vsmmu_invalidation_cmd *cmds;
+	struct arm_vsmmu_invalidation_cmd *cur;
+	struct arm_vsmmu_invalidation_cmd *end;
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
 
 static const struct iommufd_viommu_ops arm_vsmmu_ops = {
 	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
+	.cache_invalidate = arm_vsmmu_cache_invalidate,
 };
 
 struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
@@ -206,6 +328,14 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	/*
+	 * FORCE_SYNC is not set with FEAT_NESTING. Some study of the exact HW
+	 * defect is needed to determine if arm_vsmmu_cache_invalidate() needs
+	 * any change to remove this.
+	 */
+	if (WARN_ON(smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	/*
 	 * Must support some way to prevent the VM from bypassing the cache
 	 * because VFIO currently does not do any cache maintenance.
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8215c49d3bac..d1abfb42d828 100644
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


