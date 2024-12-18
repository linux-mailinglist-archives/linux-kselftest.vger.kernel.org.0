Return-Path: <linux-kselftest+bounces-23492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CD29F5E28
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 06:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B06E7A29DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 05:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459AD197A67;
	Wed, 18 Dec 2024 05:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XHL1VRqH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA7E155352;
	Wed, 18 Dec 2024 05:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498130; cv=fail; b=TKOcj7JJE/IehKzCj61c/MppNzFeM9ERXklfbUB/lF4LvGvy+RH9+5ITF8nRNZ/HDSb2yWl97aHfDC1CAv+BSAWFiPXsEb6x0X5+HG8BF0qhYwHUz5rNKYvS+witgvOwH3vQOzmc4zNTEEWUGjqDNhJ4vDWPO4RrRJi7MCO2yIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498130; c=relaxed/simple;
	bh=eU1n9NCayLMV+VEDK/E2LTBjBH/grPHIqAqqINsxps0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4Dj27MBFFPR/mfG7O/yAW+iG3QWMDyx0+CNYZJCHcgGdeJTk7VfDZSqGvMuiuMRFeWGzUfgw1OZBKX07MuGh9RaXEzdKi+Tr98KkE+hfro7HM5ThhKYeFksy7xABMPRuuQIbC/pjrsR4fYFvPTnmNpQQfFD9iP9zGWuHF+JrJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XHL1VRqH; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzaJrpI0CjlTad8p6XdOj2K5aVBgoLazqcCPzBB14i2b4M9eCOn7B8tkzNJGgANp1y6GEZULnhO+PqCH8rh/gVJR/fY4+lkodKxMIFymsizqy3rgOyYoOeKipoPfm5vaUKfsY6kQz50exO4TC9Bgvh2IQ0iIJmXQnmfRQuYIwP96wl47k/GxX3a43uLxV8FoBQfiOk3ftV6xaynxlbmU3a+18IZMGpLyFAOuWffWJr4LGXdiUfl8cci3ggS7X4Zv+vM0mRAq8zSHQ6Xrfs2SjwJj7QixRfw2XmLVV7zvtzqnXKiOUlpXUmFlcQvn5Lm8imdogmLPlp3HjgvvzhUeTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5zzWi3mVj5DoWpZDHpcEFmnkgKtA0AYrKhvfd4alNA=;
 b=htB0CgHFeeGV/gqXNrvVglbl+vD61iLuScz/0SvH5ZDFTTIKc5mrS2E/DKb2sQiuK+0RwWajCLCV/7jgSTW4A/TRgpX7eP+Kp6OiM8wA6zi1jzSR2DnUDZ1CfTF4B4VQDxNHio+pvO53vyPvA+cR9HfEO8HsBVT1S1Yoj14pKTmAFslXIzCGKKiGE82nCMHTQGAA2tT/1QAK/TYiL4bzj95Y2owXEadEvCMXhhx1XThzfoSY5DBKam4NYmB8j0vz/Co+/oNyQ7slHVzqmNRkehv0YvIoQeTg9wHb5hWbOHtXAs5fBI65SIsqiv0Nd39Tq2myhTYLwKliznpkeDGS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5zzWi3mVj5DoWpZDHpcEFmnkgKtA0AYrKhvfd4alNA=;
 b=XHL1VRqHoADT2g3Ck+S64XX/lArvD0Vty2L2FK8AU0NbX7hUq7nwAdT+2q98kzKSgiCT6dyqLe1rBN716s2XAZxpHKQ3E1iOKF65oSR8H9ekzZYcC6tRdyNmcpMKnoYbz/NiwlQTLBjKg9aKOh4EWj3SZACJYJfM+yQ13GcTPJ6OdR1FUx6G3FPjz9askushMC1sZ1l/h6KpmMqK6j4m5/LMlaJspQJaMzobx3npiwu3YAcUd5J/Xt1LitI3T6YpmLeWG+/fR4xhucKl16XlKgNKaDbW0H9RAvVRaWMZ1yfJWlGExuxY/NEPNVFPuoVO5ddq5cqbnRQX0ShGx069wQ==
Received: from BYAPR06CA0053.namprd06.prod.outlook.com (2603:10b6:a03:14b::30)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Wed, 18 Dec
 2024 05:02:01 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:14b:cafe::a3) by BYAPR06CA0053.outlook.office365.com
 (2603:10b6:a03:14b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 05:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 05:02:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:46 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:46 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Dec 2024 21:01:44 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v3 14/14] iommu/arm-smmu-v3: Report IRQs that belong to devices attached to vIOMMU
Date: Tue, 17 Dec 2024 21:00:27 -0800
Message-ID: <18cf51aa592840e9cd92a9ea1a157607db1a681a.1734477608.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734477608.git.nicolinc@nvidia.com>
References: <cover.1734477608.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|PH8PR12MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f0bc75-0fcd-4150-f528-08dd1f211b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?egeGMase95i2qH+dd69NNN32OZGRBoyn+RGgjZmZ5N84FSKmReTMR91wwJmO?=
 =?us-ascii?Q?DmT9iIRikIsBOTWdx+jeTiZ0vng+KFaMl+6rRWFkwetTci/eOs/7Do3cx8ZK?=
 =?us-ascii?Q?JRf5/XDxEbaxwUzazUE3U4ZXP2g2M7f9s03AGos2c3W2gvnZuDbpfkbcA1IT?=
 =?us-ascii?Q?nG3bVS5iUhDNHpNCNFg/RW/g8pjil21pBb1M/HQgR9VMx33u5rs5l6/I1u8q?=
 =?us-ascii?Q?sTMLAJuckk+Fl/zdZFV0PxMYWT8OlT2ZDg6OIzVEL+ccqocXUHRq88z8trUz?=
 =?us-ascii?Q?lcq8t01YbVYFoENv0EuGyt5UhbdGRKKprbUAaYEHCLQQvNS5ErrZ+3J8Pn6v?=
 =?us-ascii?Q?wsbLjVauNnZbNMeE2kjW9Gr8GGNsoGS6tXjfBkcwGC2kP5gsvFyqMiW4dqRi?=
 =?us-ascii?Q?53lWSYdxIwQusHcMbGE67K8A2OTEDoOddQYdS10dTNILtu8rLEaO5cL/5+LX?=
 =?us-ascii?Q?yJ0M8MVpAV1ToqDUvA6wCpFnVuKJJZLN968qANBW9X2MEHg/LeY3YcJYQlNW?=
 =?us-ascii?Q?Xf9u+l7YMSzyQECksiQRUer/XweukwMBuGMXLE2sOF0wNxFvoHLYhfKcGymg?=
 =?us-ascii?Q?Pj2TBt1sqI0qldHZp0RvaSRjd0TxhEIi2IyzL2g0uTQ0LPwh+mBJKDFnTEhr?=
 =?us-ascii?Q?EaQUOSJ50MwsPdyeV53foS6OsbN7SEVT6a6UdnDFcLnzNerrn3blA8FvXp3M?=
 =?us-ascii?Q?YB7FjwB37IVeclNpgcDhnODCYrPWxZ4DrISEToYeM4f9X5eO4lar+BvXeS+7?=
 =?us-ascii?Q?rTuUP3qp438mhDiic4w4lRYnkkQ9XAmNEWdHmCC6FFNDC8PVLv37hqF3rPUg?=
 =?us-ascii?Q?3BcHlDvkG4kBDdUUJvajxD9kr2k7ZbqmvJMZ4TV+7Gi5jy2NZkpvu1cIFyAM?=
 =?us-ascii?Q?UOrIKYJtbNCHYgD+ZE0cPoZBZVUhVp5/WefOoPMrQ84O55H1c1O4IIF/4tZj?=
 =?us-ascii?Q?KZCsEjulajVepSy+Xtd4RD/Rp8zp/EC+P8EtggUhDL4Sv8/CvVUSmoGkI50q?=
 =?us-ascii?Q?s9gTWn2BlQTOevMlhibnG4Fc1KLZycF2XMeBkFzSojg3BEeXn8kNcKa891QL?=
 =?us-ascii?Q?PXAetWlm50bEfv+5vtOAVpzPLX6wHIDI0j8LzR1t90Md+XvysgOk2rqq8bFR?=
 =?us-ascii?Q?YJNRdoqFJm10GwPmyDg1uW1iELCCVYlSeN++V+gK3PHVZFyHh9h0wzg4A4lC?=
 =?us-ascii?Q?6lDpSr3Pe2ypJLLbixjr5iZzp75Cm9ulXRau0jIcanLNmaLM9CRZLWvFIf+s?=
 =?us-ascii?Q?uDp/xK8KWhT4Mo3zsM5PgY1+WRiC6+n+0xPdzDnN7L/F/ceJ2To7Ip+Wc9Tx?=
 =?us-ascii?Q?1vkly8H1Qi7Um7uY1gf6s+qgBVr9sSpxx5t2Cx/G0zyANWl41I/tneNupF2x?=
 =?us-ascii?Q?lrnp4xHNK+eg0eltVthl9XWKhhtEYrZ1WGLFMdaNCIYOw7eOzLoeP+O/dR2t?=
 =?us-ascii?Q?4izyA8+3v5l7FhoaN/L9ztbKU+F+7cSduBziEn9+hmdV84As1Uk3RPzII16r?=
 =?us-ascii?Q?tzL4TkXW+c+9bFM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 05:02:01.2725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f0bc75-0fcd-4150-f528-08dd1f211b9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110

Aside from the IOPF framework, iommufd provides an additional pathway to
report a hardware event or IRQ, via the vIRQ of vIOMMU infrastructure.

Define an iommu_virq_arm_smmuv3 uAPI structure, and report stage-1 faults
in the threaded IRQ handler.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 +++
 include/uapi/linux/iommufd.h                  | 15 +++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 16 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 58 +++++++++++--------
 4 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4435ad7db776..d24c3d8ee397 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1066,6 +1066,7 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct iommu_domain *domain);
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
+int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt);
 #else
 #define arm_smmu_hw_info NULL
 #define arm_vsmmu_alloc NULL
@@ -1081,6 +1082,12 @@ static inline void
 arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
 {
 }
+
+static inline int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster,
+					   u64 *evt)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_ARM_SMMU_V3_IOMMUFD */
 
 #endif /* _ARM_SMMU_V3_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index cdf2dba28d4a..579529ff6fa7 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1016,9 +1016,24 @@ struct iommu_ioas_change_process {
 /**
  * enum iommu_virq_type - Virtual IRQ Type
  * @IOMMU_VIRQ_TYPE_NONE: INVALID type
+ * @IOMMU_VIRQ_TYPE_ARM_SMMUV3: ARM SMMUv3 Virtual Event
  */
 enum iommu_virq_type {
 	IOMMU_VIRQ_TYPE_NONE = 0,
+	IOMMU_VIRQ_TYPE_ARM_SMMUV3 = 1,
+};
+
+/**
+ * struct iommu_virq_arm_smmuv3 - ARM SMMUv3 Virtual IRQ
+ *                                (IOMMU_VIRQ_TYPE_ARM_SMMUV3)
+ * @evt: 256-bit ARM SMMUv3 Event record, little-endian.
+ *       (Refer to "7.3 Event records" in SMMUv3 HW Spec)
+ *
+ * StreamID field reports a virtual device ID. To receive a virtual IRQ for a
+ * device, a vDEVICE must be allocated via IOMMU_VDEVICE_ALLOC.
+ */
+struct iommu_virq_arm_smmuv3 {
+	__aligned_le64 evt[4];
 };
 
 /**
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 2b6253ef0e8f..e85456c7ff52 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -447,4 +447,20 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	return &vsmmu->core;
 }
 
+int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
+{
+	struct iommu_virq_arm_smmuv3 virq_data =
+		*(struct iommu_virq_arm_smmuv3 *)evt;
+
+	virq_data.evt[0] &= ~EVTQ_0_SID;
+	virq_data.evt[0] |= FIELD_PREP(EVTQ_0_SID, vmaster->vsid);
+
+	virq_data.evt[0] = cpu_to_le64(virq_data.evt[0]);
+	virq_data.evt[1] = cpu_to_le64(virq_data.evt[1]);
+
+	return iommufd_viommu_report_irq(&vmaster->vsmmu->core,
+					 IOMMU_VIRQ_TYPE_ARM_SMMUV3, &virq_data,
+					 sizeof(virq_data));
+}
+
 MODULE_IMPORT_NS("IOMMUFD");
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 686c171dd273..59fbc342a095 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1812,8 +1812,8 @@ static void arm_smmu_decode_event(struct arm_smmu_device *smmu, u64 *raw,
 	mutex_unlock(&smmu->streams_mutex);
 }
 
-static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
-			       struct arm_smmu_event *event)
+static int arm_smmu_handle_event(struct arm_smmu_device *smmu, u64 *evt,
+				 struct arm_smmu_event *event)
 {
 	int ret = 0;
 	u32 perm = 0;
@@ -1831,31 +1831,30 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
 		return -EOPNOTSUPP;
 	}
 
-	if (!event->stall)
-		return -EOPNOTSUPP;
-
-	if (event->read)
-		perm |= IOMMU_FAULT_PERM_READ;
-	else
-		perm |= IOMMU_FAULT_PERM_WRITE;
+	if (event->stall) {
+		if (event->read)
+			perm |= IOMMU_FAULT_PERM_READ;
+		else
+			perm |= IOMMU_FAULT_PERM_WRITE;
 
-	if (event->instruction)
-		perm |= IOMMU_FAULT_PERM_EXEC;
+		if (event->instruction)
+			perm |= IOMMU_FAULT_PERM_EXEC;
 
-	if (event->privileged)
-		perm |= IOMMU_FAULT_PERM_PRIV;
+		if (event->privileged)
+			perm |= IOMMU_FAULT_PERM_PRIV;
 
-	flt->type = IOMMU_FAULT_PAGE_REQ;
-	flt->prm = (struct iommu_fault_page_request) {
-		.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
-		.grpid = event->stag,
-		.perm = perm,
-		.addr = event->iova,
-	};
+		flt->type = IOMMU_FAULT_PAGE_REQ;
+		flt->prm = (struct iommu_fault_page_request){
+			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
+			.grpid = event->stag,
+			.perm = perm,
+			.addr = event->iova,
+		};
 
-	if (event->ssv) {
-		flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
-		flt->prm.pasid = event->ssid;
+		if (event->ssv) {
+			flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+			flt->prm.pasid = event->ssid;
+		}
 	}
 
 	mutex_lock(&smmu->streams_mutex);
@@ -1865,7 +1864,16 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
 		goto out_unlock;
 	}
 
-	ret = iommu_report_device_fault(master->dev, &fault_evt);
+	if (event->stall) {
+		ret = iommu_report_device_fault(master->dev, &fault_evt);
+	} else {
+		down_read(&master->vmaster_rwsem);
+		if (master->vmaster && !event->s2)
+			ret = arm_vmaster_report_event(master->vmaster, evt);
+		else
+			ret = -EFAULT; /* Unhandled events should be pinned */
+		up_read(&master->vmaster_rwsem);
+	}
 out_unlock:
 	mutex_unlock(&smmu->streams_mutex);
 	return ret;
@@ -1943,7 +1951,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			arm_smmu_decode_event(smmu, evt, &event);
-			if (arm_smmu_handle_event(smmu, &event))
+			if (arm_smmu_handle_event(smmu, evt, &event))
 				arm_smmu_dump_event(smmu, evt, &event, &rs);
 
 			put_device(event.dev);
-- 
2.43.0


