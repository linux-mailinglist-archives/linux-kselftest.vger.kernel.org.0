Return-Path: <linux-kselftest+bounces-20732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CBA9B137E
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98BB1F22BE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D9921A4A3;
	Fri, 25 Oct 2024 23:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SHOB8Um0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C2321893A;
	Fri, 25 Oct 2024 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900243; cv=fail; b=mY5W0C6myCO8/so/FgIBSuKLHW/XzsaBc+A1MgwmA2K/xdZ/JAJnsayxzho1X22vbC+e2DGoq+krrNXjdVpmFfClw+SLUbIOIKXtnimuQptaP1YqbzUDsdh4K594rapwyklbDNiKZkOyXQjysBE5Ah7ApF87jVTcDXNuyzYAmYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900243; c=relaxed/simple;
	bh=FoToAzzI96LgruF5OnGqawAM2EHHG35CVppQR+JOwnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsmXY2PnQ0LBgfQsic0SKzcwv1a9L6mCiE/4Y6PcfhbaIIoXvIwfnWdWkvwiLWF4n4vKVgX5pax57Dtqsc7tlQ0wWiMMjdckf7gs5pQx/1PcW6X5WCcmjRx1OIpvZQi459k3ZiWS8xPKGkBChYQLQkEDZqMLnkpYAvNnrRbAxX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SHOB8Um0; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHDTmth2Z1kDMlQwC/WAyTNtwKIo2cTcYisNPHXre6rc+rxpXhGP4Y+ciwl8Xu0rMYKny6yfgOgQlEx+/dQH6fYs3b/FP571hZlGmPr2HCrvGKwAeeQ+Oev/Ce0htUk2n9IUc8ejiZlG8X0sbCgMpH0IK5l/YuH+DunTJBinv2vLeVKVfilmt96OVwU5qmoa3PZEeERziEidYG8kfcGFUGurKT/RwM+Ulbu39rakg2tHMrR+FwJ65fUNJB8ptP3h4A1jHu7TLMPh0kTxLQqn4LgVU19cZFgN3hH+Y9XFcGhxlljDUJVO4iU85XWeYqKpA+QQlLRg1Gdh5EDXgCoOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdXT2sx14oBAL1lSvLuC4y48nYSOpsbnF/vl3UQYpDU=;
 b=wRiKPNst3k36+92otHwsXftKxiFE6Vx0lVJhsqR/myYUFPQnS9Ro7O7EZPwY7aSDN10DzJTwCQ1tRyhbktf73E/wmVcT2MkvvBmTfhPhURaeUjSlx0t2mRgoKys58yXSGU7WIsZkPZk6Bd9DPTa8aLgpTzIOLOGCqdgWI6VzWD8BGad9VDEQu5Yc0o3EuevTJYoBnY6rFOIgI3MIRXTTvBqHjckq/xDyy7eeXJ4UgZS1tuZyCTuN10OxLr9xhqn/baWgHHJQuhspfJMq2G5m+5OCxTshJNDvy0JVDlNFtO2bFzt6I9ByKDRk0708RD6uozO8KKQs0SVMd2lvWG1CaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdXT2sx14oBAL1lSvLuC4y48nYSOpsbnF/vl3UQYpDU=;
 b=SHOB8Um0P7FCtXX37AsN46xcZYotRGW1IgJWAvnmU/tgS1X6KVMLydgkdMJcpeSP/T0pIVrPVVCS9dxgNHjgEePvpULXP/dt5LC/dL+AoV8e+DGFO5imj8RHupdkEmwKxC+ETzf3/djBpb+P8L2aHM+wKBqnCY1cD85W6qeWGfnIwMpnZQMAiPxzWcg4HvF3qjt2F3LH0aOJ2oXQE7SXeFJHY4J4x52/Drr5AQX4Bud1qsP2yCU5nUPMbVJIOMNajAxgSQux909xjVrdDGhnkYFjTK87qz0ONNauNEjVQTIaKucGJBCGJn0Yn1K4zxB0E7dQjJyfx7VmZyAdmqkDsA==
Received: from MW4PR03CA0049.namprd03.prod.outlook.com (2603:10b6:303:8e::24)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Fri, 25 Oct
 2024 23:50:35 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::a0) by MW4PR03CA0049.outlook.office365.com
 (2603:10b6:303:8e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 23:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:50:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:20 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:19 -0700
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
Subject: [PATCH v5 13/13] iommu/arm-smmu-v3: Add IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support
Date: Fri, 25 Oct 2024 16:49:53 -0700
Message-ID: <20c85597e5d579e020f027da4fc36275adcc91bf.1729897352.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897352.git.nicolinc@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb9b7f2-281c-47a7-73dc-08dcf54fd1f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dp5pn2ykzMoaSgMhsxOi1e6GAFTPc4QBYIVN/9Nk4oR6j20qpaRDhopGYQyA?=
 =?us-ascii?Q?pgXW4qNUey9/QPR2KZNdcgyP3IHPqHozZE3T30fv1gQMl1u7lwXmpmLvdu8C?=
 =?us-ascii?Q?wgIU/O6yYGoGRk5Ax72rsysWPa1i0vhH+GzMjnesqyyphWI7APTTyn6giwyW?=
 =?us-ascii?Q?mJsy0ihfpKa6zvd1sJJcBg1BE1IBjPCh13u0h4qT6SeSczJUoPJl6Kkj1BF3?=
 =?us-ascii?Q?r5AOnjuNQdHYTbFI2jPohTuS23Vsta35ngFWYxbjbV96a7wQu4fxqySw+CnI?=
 =?us-ascii?Q?hZ3AOOWQhMOB0wtgvrJAQcJiccpYkLn2QgMF3osHhT1te3ZSMMkajNUaP0B5?=
 =?us-ascii?Q?WlkW3pVesmhwdmJzkzi/9psA09h0MO31fX3eaTLF/nulND+CiH2opx6DS3zl?=
 =?us-ascii?Q?cGtjB6+m7WHvQj+LcTUDXy12+2ICNRL1tAzkfn5GfkuQMuPTc2E3+D19Lgwv?=
 =?us-ascii?Q?7ZOI3K9dkZM60iqN0C+fRB2f8OzWarNwcGAfcM04rrLonqiZBcIVRZVlCwXS?=
 =?us-ascii?Q?vPuqRYBlUzhYuw+IrQo7daWnd5XlpCD28BucD9THgqFXSc3Kf+V0GW7AhYnx?=
 =?us-ascii?Q?LzprWa4o/0qgK/7KHdgw9ot96qlDae1fcH7ZMzi3bW5CGPMc0pbjofX/MDbk?=
 =?us-ascii?Q?yrq+KZrI3+wusXb0+fRkJrtfqrDymeDRvxW1HxydgkHqgwAIY8SFH9lGWp+W?=
 =?us-ascii?Q?I6h32ZoqToS5Kdu7Yv1iYmow2gzuqzP4hul2FcqHzbrRZdsgoT8s+L7nJwmb?=
 =?us-ascii?Q?S+HBSB3QvVRORZEjSevetIdCVilzo3tYOvcdgdvd1tQDyzU3NzvYK1Jy6flU?=
 =?us-ascii?Q?SzKYc1MIQK80p4/BseP1chiJ5duKmbdA/PxM6hsRE+3k1yT7aFOzbJdjdJxW?=
 =?us-ascii?Q?X7ItOhfwEfNSP/8X41hMSGhXcx47USo0AzBOCbwYGfNM2c514fJrvDYRRy2v?=
 =?us-ascii?Q?RBqNbn8UlW44kx0QxfK9VzrtnZ/4jg4Jds8UcCjVf08HqLngBXpm5FmEEa5s?=
 =?us-ascii?Q?Zifnm8Cs4Wol7YTgeg8OkpiSEG47joldB7OSh27gpC14cij2zTUQ0Js7wWVw?=
 =?us-ascii?Q?jvS3FT0c9n7MEDfaJ+dT8QBU4K62x+2NLSpUCiiI78pE+3BQfrA6JMepXcVv?=
 =?us-ascii?Q?0Dgjj+kOn0W3wtlZm3hZP3YBRQFpWlMra/BWen0j9p1oONJDvjit+Ayz3oa5?=
 =?us-ascii?Q?uLvbc3NZhonAnJRJjEaN4v0XD+POejhWz6PJpawniJRwumP0RbvYIFwYF5b0?=
 =?us-ascii?Q?BuUM66Ex3NSn7HO2/kMd1dnYfzhJFOAWlbSfMmkvZNoqVG5RtXRnr0I3GK5w?=
 =?us-ascii?Q?pTFysNLmXPiEEJP37ycaf6aeKs88eNWI9cZVTeLkRsF/Clfk1M6jDwGSnXoi?=
 =?us-ascii?Q?6aof0vo/r8i5+RWIPvYZKoYPhZb2OTdyKCoeVnkjG0e576vGIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:50:35.3029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb9b7f2-281c-47a7-73dc-08dcf54fd1f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198

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
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 80 ++++++++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  9 +--
 4 files changed, 71 insertions(+), 46 deletions(-)

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
index 717659b9fdce..56c742106a45 100644
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
index 44e1b9bef850..abb6d2868376 100644
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
+arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu,
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
@@ -196,9 +177,52 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 
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
+	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
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
+	vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
+				     &arm_vsmmu_ops);
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
index 0d79a1bd9049..8215c49d3bac 100644
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


