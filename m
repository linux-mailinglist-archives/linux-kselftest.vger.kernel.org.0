Return-Path: <linux-kselftest+bounces-22793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA069E2F31
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 23:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A575B45B0E
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 22:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE0920D50E;
	Tue,  3 Dec 2024 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tod0JHaR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104220D4FD;
	Tue,  3 Dec 2024 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263876; cv=fail; b=Imc/eJpoHDUCteEo/YDyAdaR9XsBfAdoOCoXcvS+FCUh3i9bedJQNritmLEDkH3JkguSY4uDa+ZKODyjKIJm1OkE2zy5SFwuUXckOB9gEt/bWWTubf+9e0Lo3yWpWHJNevv7hHBiV42cSVA3W1HY0mf/c8Cv4Xe7bFCDzb2iWS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263876; c=relaxed/simple;
	bh=dM/Oiuffb6SURuwzhkmcpnELT8Af3ANEFEL/zv9CI0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzqtyYK1eqDhv9Z+ndUwOTxHr2c85Dc17qxyTIBz2EBGvZNtJQ0eZKsx9iPbs8o6PQTqmS2yqrr3T5o2ebHVRXkglbasxHEqzh41hoJ8d0GvzOgv8QxZEYvG1gAYl6P6eFME39B04vKGKlu0ja6R3I7RSah3dCLGGIbFhxfdmdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tod0JHaR; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPmLxLuwntDQMZ54vt15eMcgm8SL9bsbeQWEDquAQ6QJahINz7NPoUqAgD2Soxw4JxkxVHI1rkmxM+JD6WZXJpmFOxxSTDyJkk3K+037kL/AEw6AIh0r4jp9BPJdj6TwS2ROjpqXVMN9jOmI45XnpRf0H35QAsH6CpzXr9FqKs+5349MSgiaUkclx/Tp7sWPmmq29p4/R/L5ckMO2btN5C1KYjfmldpnHPWgchNbCiXNoCQVn+qihgCCCE+bR7+WnTcYY0hGmcGuNBsuipTi0de0v2M0epog1pkk1QUchS1JTuGkQXC7BnViVOJ/z/YRQVaV3GRb8lAJB1KQ7f8EWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sm1eAjZ3ZaNk6wZqnM9eK6VbYs3VE3XEVaXuWvdxwEs=;
 b=QdQ2k6rOHY5rCkNujOQfEN4ejNgfIkKBIavjQuU2Mwk/RFQUeZoRuFjc6wa7tL8/E1vNcsqRsfFGk6dEoz3ucLgGxu0FP86XOaMAQOsDEbk1KfdGeoq2q5eaOcqxGwPhdQ6bA31P/KuTZtImC1NkERKiQ34+KT92T0VyBUi9FNBel7lPr27vbO3MLMY3UliD83RTi3w1SdzpQuMp5I6GlIKjst39dxJZmor0SoXnvGrUkXsYyG9nxG0v2Oo40Bbd1Sz9/7tZPxLWom1FUGI1GEjZw9Q2v/tPblQyBj2Dqq3bYLTT+UzJLBLWCHxlI6rTw+lnSaHiQ9IzvVtMA9C4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sm1eAjZ3ZaNk6wZqnM9eK6VbYs3VE3XEVaXuWvdxwEs=;
 b=Tod0JHaRs6+elv3LnllHhMb4oP7nhXDIEC0SUfESjMJSTbEeuqIWsjFAUJoCtFOZG35nVEvKcv45xiuu81mantCWmP/52GOgP0qh7XNUO9rFWwXo6yyjAQrm2VwWRlyPW/++yHef+oCOF8BaflEJ8Uc3ieTKFGczdxXfD/5JKGB6xVKV+gHcsuj9dlKnb8hp5+GydGOPmipDY4Kre7nTfNykdAX4f0DqsW8tjf19YBilbZhB2cS6sQsdNGGeknUuLzICBDmOtnOKyR3BxfBPual/cCW0Nduw2mqJ4OFVQKtxwTAFuTc0xf1SZauw9aVkWIU6876dxgzCz2+/nxFy6w==
Received: from MW4PR03CA0315.namprd03.prod.outlook.com (2603:10b6:303:dd::20)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 22:11:08 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::49) by MW4PR03CA0315.outlook.office365.com
 (2603:10b6:303:dd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 22:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 22:11:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 14:10:50 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 14:10:50 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 14:10:49 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 13/13] iommu/arm-smmu-v3: Report IRQs that belong to devices attached to vIOMMU
Date: Tue, 3 Dec 2024 14:10:18 -0800
Message-ID: <d335936fdeccfcf785589800b7e5d9b1b26a766d.1733263737.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733263737.git.nicolinc@nvidia.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: d65dd2f3-5871-48a6-b8db-08dd13e7632f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DMYnNgn16M/Zj6hyLLqw5/z+WQTLnfFFnXAJopquRDTnGxHgE6VMgcGuZjJy?=
 =?us-ascii?Q?ag2q9lrNey7WFPglrw0FkgDkqfWOGU1dvKpKvpdrG2Wup1L7KcMYCnJG4utL?=
 =?us-ascii?Q?NTnrXqv7lGpRezugXIMnlD55sv7FMfO2dMG2h/Pl1X9wIAXbOBcrmuxPXCS2?=
 =?us-ascii?Q?dLeLQ9SriXdRIE00jfAM/WyNcs6yLUS8PWw7rSUpNue09QYkSpQ44vMjPj8J?=
 =?us-ascii?Q?kPTVUjmbcydGRSwkOh2kTBSkShv2DadUsUMswHK11nuER0f1PxwVY1vg5/Mf?=
 =?us-ascii?Q?Z4iZ6aHh8Mj0DLKR+aChCKexEnrHawyedfCzIWq7rzglBznJHpqsqf4/XeGg?=
 =?us-ascii?Q?gGAk1dxPjB9STCOkihB9ODSu7dM+5MOCZyLPcLOto1ukRsUV9JMhYAbq4PU6?=
 =?us-ascii?Q?AU3NQv1l093JrP/U5A8lrQGoHPewCO2s4ixMM64UfTE+YYY+3HBk5CchtB6G?=
 =?us-ascii?Q?q5rlW4CDOXvk9N/hl8QfMMK2RjtXPeEx9GVpHG/K9+GAZFJd/BofiwvSzSl3?=
 =?us-ascii?Q?2Jt0xKZftexhOPOmlLu346gr1HCf3sa7IeT/QPILLpT8/oxHKWzSxASKSUQ+?=
 =?us-ascii?Q?6ErFyj/c8VIBaOphRWYgQiEupwItTKy9ByiTiZRSe/Q2o4cREPufGvapUZLa?=
 =?us-ascii?Q?4LAswbfWI40SrRFcMq/8hw7eV0Bhe9ZfFa9onLThOTZvCYEBmUpnJ0gTR03l?=
 =?us-ascii?Q?1M7nbTqEhaaJoXNwkrM89acaRalHpKyZ8QxhIj6w11a2CSSUjMcPkioDqa+d?=
 =?us-ascii?Q?T4I2VBe44U9XtO4FUBocu/zhaWPb0+CEMBIzvK7PbTiFw5nqBro4BY7+OkDl?=
 =?us-ascii?Q?ajs0zreYuMbj7/Yx4OnFCaEYm2BalelZIuQtyn4ToBNF5akqPGpXd6jk01DN?=
 =?us-ascii?Q?WUwVwP6COu7exWPEzGvnDETTS+YFawwzvAPD8syf400OkeRJY/MmG/Efhgh7?=
 =?us-ascii?Q?PMBKW2W8zo8Zp6ysmFvCgVv7lGpx1Ogi27EKaFDtT2LAd7NwabibHcCgpQGm?=
 =?us-ascii?Q?v/YCufucGVpeTWGG+8vGxxx4P2465WkdvXCfK0T8LOSgtY5IpVQ7iQM8/bUG?=
 =?us-ascii?Q?nP3/MlIa9Vw6ddn0uZnP81LKWQo7aaPJQYIpHAkNl2oDXB6hBhiCOlu6VZ9G?=
 =?us-ascii?Q?GgrJv324P5Gs796Hnpwa8VN68f/E3jXNE4wrrzEekO4CjjtfN3gZG65CjC8w?=
 =?us-ascii?Q?df3vCP1GH70PXSQF1klN6ZCeLuNu51cyoAl3bZA7mgpdY28SsbSTRMV05j53?=
 =?us-ascii?Q?RyaCj5LAJR2a3dpjMs6ugs1AJAn30CZyQQBkI4495+q2uG6BSpt4woBIaa+U?=
 =?us-ascii?Q?+iUClO4QrYCqxXIopYqx/vv66kjTfkgWXXq6bAW0AOz/OJTerrD0yEGuz1xb?=
 =?us-ascii?Q?0R6o1DQ2Hd6b4wEgg1iYn1gtOqFuQkj54BaxFeWYYRlCjEWF2826fPITd1HO?=
 =?us-ascii?Q?1Kh420tLW8txnqVk+BOZ0c7jhFFwucPQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 22:11:07.8610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d65dd2f3-5871-48a6-b8db-08dd13e7632f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368

Aside from the IOPF framework, iommufd provides an additional pathway to
report a hardware event or IRQ, via the vIRQ of vIOMMU infrastructure.

Define an iommu_virq_arm_smmuv3 uAPI structure, and report stage-1 faults
in the threaded IRQ handler.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 +++
 include/uapi/linux/iommufd.h                  | 14 +++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 16 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 62 ++++++++++---------
 4 files changed, 71 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ec7cff33a0b1..05915f141eb8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1037,6 +1037,7 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct iommu_domain *domain);
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
+int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt);
 #else
 #define arm_smmu_hw_info NULL
 #define arm_vsmmu_alloc NULL
@@ -1052,6 +1053,12 @@ static inline void
 arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
 {
 }
+
+static inline int
+arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_ARM_SMMU_V3_IOMMUFD */
 
 #endif /* _ARM_SMMU_V3_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index d9319f5b7c69..164920d7f0ab 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1016,9 +1016,23 @@ struct iommu_ioas_change_process {
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
+ *
+ * StreamID field reports a virtual device ID. To receive a virtual IRQ for a
+ * device, a vDEVICE must be allocated via IOMMU_VDEVICE_ALLOC.
+ */
+struct iommu_virq_arm_smmuv3 {
+	__aligned_le64 evt[4];
 };
 
 /**
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 3a77eca949e6..e3ef77e0bffd 100644
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
 MODULE_IMPORT_NS(IOMMUFD);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6a6113b36360..215c2d811eb7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1779,33 +1779,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 		return -EOPNOTSUPP;
 	}
 
-	if (!(evt[1] & EVTQ_1_STALL))
-		return -EOPNOTSUPP;
-
-	if (evt[1] & EVTQ_1_RnW)
-		perm |= IOMMU_FAULT_PERM_READ;
-	else
-		perm |= IOMMU_FAULT_PERM_WRITE;
-
-	if (evt[1] & EVTQ_1_InD)
-		perm |= IOMMU_FAULT_PERM_EXEC;
-
-	if (evt[1] & EVTQ_1_PnU)
-		perm |= IOMMU_FAULT_PERM_PRIV;
-
-	flt->type = IOMMU_FAULT_PAGE_REQ;
-	flt->prm = (struct iommu_fault_page_request) {
-		.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
-		.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
-		.perm = perm,
-		.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
-	};
-
-	if (ssid_valid) {
-		flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
-		flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
-	}
-
 	mutex_lock(&smmu->streams_mutex);
 	master = arm_smmu_find_master(smmu, sid);
 	if (!master) {
@@ -1813,7 +1786,40 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 		goto out_unlock;
 	}
 
-	ret = iommu_report_device_fault(master->dev, &fault_evt);
+	down_read(&master->vmaster_rwsem);
+	if (evt[1] & EVTQ_1_STALL) {
+		if (evt[1] & EVTQ_1_RnW)
+			perm |= IOMMU_FAULT_PERM_READ;
+		else
+			perm |= IOMMU_FAULT_PERM_WRITE;
+
+		if (evt[1] & EVTQ_1_InD)
+			perm |= IOMMU_FAULT_PERM_EXEC;
+
+		if (evt[1] & EVTQ_1_PnU)
+			perm |= IOMMU_FAULT_PERM_PRIV;
+
+		flt->type = IOMMU_FAULT_PAGE_REQ;
+		flt->prm = (struct iommu_fault_page_request){
+			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
+			.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
+			.perm = perm,
+			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
+		};
+
+		if (ssid_valid) {
+			flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+			flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
+		}
+
+		ret = iommu_report_device_fault(master->dev, &fault_evt);
+	} else if (master->vmaster && !(evt[1] & EVTQ_1_S2)) {
+		ret = arm_vmaster_report_event(master->vmaster, evt);
+	} else {
+		/* Unhandled events should be pinned */
+		ret = -EFAULT;
+	}
+	up_read(&master->vmaster_rwsem);
 out_unlock:
 	mutex_unlock(&smmu->streams_mutex);
 	return ret;
-- 
2.43.0


