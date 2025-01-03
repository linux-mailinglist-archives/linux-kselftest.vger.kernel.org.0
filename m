Return-Path: <linux-kselftest+bounces-23897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55D2A00E9A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 20:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BBA3A20E7
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 19:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59F81C4A38;
	Fri,  3 Jan 2025 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P69UNVUu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83221B6CEA;
	Fri,  3 Jan 2025 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735933501; cv=fail; b=ReDcGYukQ8i1FatIxw1DphoPgE8FCsUzLupSL0n8Kn0v+ouvB496tBUXEVV8HTWJYIcO8gMh96NGy7r5AbH9dOPZyq3QXXtSsDMs3clHzI3FDGw/gBy3+p/UGZglI5WSICfhU+VAuUUv4eWQeuToX0YMPpaTA3bMcRfUtTz1TWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735933501; c=relaxed/simple;
	bh=P4PJ3Mkhsdwlo7oZ4P/w1mJyEJogOcSCOx4hBtG75ak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ek9HFl0ZbCdrBGPZvWBAPEbDxQJgpP+OkqHmuAD1zyfazlOHc1QM8mGVwsFtoaZHr1vVxHLD+OLkpd5/lSkUukR/b1SjKj097Go7lwrxzD6wh3q+52+sRLHmQLOUAPFPTgCNWz6l4c59FkvFTxshNWyWZNs0ALGGwCleAb6StKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P69UNVUu; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bG/SKfmaFWqCgtUjtkjKAXhPgUOiyWyvphJ/z0oGDz94wQDWDAkHdeIztvgJjLZ6KJ6ISFeYsK8VfQdQq9VLaXJgdkHhjgdwDpJkVOH8/6gRKYNsiwi+9I6fpjNK+UiSMph6XksE8/fdhEQw9FKLnumwfEvZdrjEpVt9WhyoGwUM3r8sYq8Xnyv2BLUWeSLb3XAfPyssKwX0Yyp8HjLOUNXPkBiIPsBqtZvim0G094SaEpweBQpvkQfQawYGalxhvizB7+WpPcta1Bcv8v/OAfxdMS0J+60dpFZT80RD1hBikyZPEtewn/C1Wrun82atW9kagY/iGv/eRrDDsOGLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5CgU9hUH5ic/+yCiu7ISm+Skm6bwlui7GXf5KgZNnk=;
 b=TWFVntSNfvvn8LxV9rMycMXrw3XKLNSv20She3/AKmyYL8J+aHKfucc2ErLoeGkNZuay24TGm784OmUNTTcDmTCZvveLJZGshJOrZqahxn2T6t904IzNh5+PhRxjjc8pSYRkNYwESV4BIGMAAR4p/9ObXsUCmVJyMofvGrzNk8rvLtgetKIwHuGqjUHF4XXFY7J4JDTwZHvKuscB+/3gAK4dxZjx6UN9FWE1tM6k/SaEwQC0qYQECD9/FJisk1UxBubghg2cdlIxWobTJIr5Kag9Mpy0fy4IgtJ16ey9L1xoaBkEqLvxwTf58OzsPz1J4mt5B8pE4cQNr5rzg0Znmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5CgU9hUH5ic/+yCiu7ISm+Skm6bwlui7GXf5KgZNnk=;
 b=P69UNVUuEkzw8c88uTR26s/nCI3/3bLICdamNJA7fyLWFBh092Pklfnb3dtWhn02JZO3FeyVBquGxR5pQEvm39yuNcKOH6APPfqmsEKCaXrZRfXVrAhmAiqX/f0Y7ulevnQBNPu2PCKLlmnwsmDf+t0/7OAadhDbcTVQCRr+JCeHktSOQNy5hPqxJbRugzpFNinm1Ui/hJQ1ZQHTxIvvSYxMFo0yOv00o1vWb6Unrxzdh/2RHKfD+yGliQzos3EYfDNyLuOMtJ3M4ZGEegO5Dta9yYzFRkLSwOjBk1wzsgQ2K8/itNlrbc5N5+KB7GeBuNee2+nLFOvo+eaLiEQYJA==
Received: from BN9PR03CA0742.namprd03.prod.outlook.com (2603:10b6:408:110::27)
 by SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 19:44:52 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:110:cafe::cf) by BN9PR03CA0742.outlook.office365.com
 (2603:10b6:408:110::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Fri,
 3 Jan 2025 19:44:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Fri, 3 Jan 2025 19:44:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:35 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:35 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 Jan 2025 11:44:32 -0800
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
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v4 14/14] iommu/arm-smmu-v3: Report events that belong to devices attached to vIOMMU
Date: Fri, 3 Jan 2025 11:43:37 -0800
Message-ID: <69a46c72e43ed086840be462eef731167d90a9d8.1735933254.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1735933254.git.nicolinc@nvidia.com>
References: <cover.1735933254.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d7d69b-1786-4f0a-d4b8-08dd2c2f1716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7S1o1ic8wlyjoo9st7m6Qxc4C85sKk6u104buP3bsMQR36Dk7eT0jP1XsQwY?=
 =?us-ascii?Q?B8HDUk95mJtQDF4jJ/5D2GyuvIVDxoLwWt1xGnt4UM6P7sctdmOnDDztfj8W?=
 =?us-ascii?Q?oOLVG1DiMrVQo4Vag3DJEwMXx6klfJ/rZBghB6IOxAT54Kqc8GOBFQd6VhFz?=
 =?us-ascii?Q?7MMHW4O7igOBPbt2ab9m7ONq474wCGbqZNdZH0y0vn3XXlDv3slmUZ6M7vjw?=
 =?us-ascii?Q?baowRd9jdpckibVtr+8uTLUHxZPVFY32rSzzIPrEZWEEbwLoxnOaPrVt6ylu?=
 =?us-ascii?Q?I01Zm9h+zgW7JHgWcWOijJwWfijK486hU+thz23x2xQabRGKr/6JFhpszBJs?=
 =?us-ascii?Q?wYwMZ3goQu0LEJywoCx8g7nG/1An4SfkhsdO5UxGC1eiuXw2oBhIW5UWHw+S?=
 =?us-ascii?Q?pwJSS7JOkOu3x97Lgqp644Skj0dDyOQYMLzp84rIsZNEWm/4pY8O178wQ4+u?=
 =?us-ascii?Q?LjcowSbB4Pafpcc3NxEJjyPk0DArebdFeHVgIWVJdjpuiDSJmylFXmAqZNmO?=
 =?us-ascii?Q?WyaiaxNNmGLjQrn8M1gnjZZNOvb31LgxLSr+WTrHuQzCQ2Rw9NtJPV4xACkq?=
 =?us-ascii?Q?78LOIY7XYVMZXH5DS/oFonoT5eUpsu+g67L77TVV0tXXsiZ4G4SqLbTArnIz?=
 =?us-ascii?Q?vYtuHsk0Gavr+yT1GAkXb21l3RZ+65jXxAQ896e+hU3QGzXnn8rrjYlE7lRc?=
 =?us-ascii?Q?W8qbCbtqZChIQnyatb/rCxT3Mh8y3kf66P7DFDNnulMV+MiVyoDuzcDtAa7m?=
 =?us-ascii?Q?Is0a2qf0fLO+5xOmn4icD1AXB8G1yY8z30SKdvn5s0m4QHG3rUUusdj56XR7?=
 =?us-ascii?Q?JGKnvZjM5y8oB16wDQ+xFMU6wn98mJvLtwB6LU1jqreV4cqe/yBk/sThZYZ5?=
 =?us-ascii?Q?9n9/8dskyzQsnM7yoW9K5Gl0sIZwNzF/XuMOkIwyIAdac+FrMqPuOWOo7jkG?=
 =?us-ascii?Q?Lc5dit7mWZMDcu0IHzjrA+lqSqrEOzQH/PjeHD9jRgp/8YvPLH1a2u4JawWs?=
 =?us-ascii?Q?JlVEFH+oiyoxifOLWvOOirbBeqmy1qTRtV/4Dh8gzy0Y3VLJ7A2s7sSAzOXp?=
 =?us-ascii?Q?4qLlE0JB2083jE6ox/c0ajmv/CASvo96Y4VUpTQBHCLV+uN3SalAX/U9j44F?=
 =?us-ascii?Q?NwS8hI5IuYOQab13S3O3nb0Trh6CKPgD6RqFGG8eXdZOwy/ERmACM/WJeGWY?=
 =?us-ascii?Q?LpUroJmhuJ9CDXnVT1Y8XquZE1FXVyZ28mjd3yo32Ced3+ZLI+vWHwQdYkAo?=
 =?us-ascii?Q?JV1jr+hSuBWnteNzZmT/DxYtPvZS2R+GdKgyWlz+Ro/KjicYiSSEtQnz4z8b?=
 =?us-ascii?Q?Z96V2VO3didP5z6If9wfnUTl00aRLUA2xT/ysp+i0+GFTR0CVxHLbN3R138g?=
 =?us-ascii?Q?8tLMfn61aVc4RTburHhUFKPLYucsCnaCEnXE9cLXcTe1MsBwuK/nrSHN57Fr?=
 =?us-ascii?Q?tSHT4sjG4mV38L4eUMKBDWAozkhkh+Qk+N17R+3MbfWyxA5rKL5EEQITK+Mx?=
 =?us-ascii?Q?bCDJsD4VRgZHS9U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 19:44:51.6904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d7d69b-1786-4f0a-d4b8-08dd2c2f1716
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059

Aside from the IOPF framework, iommufd provides an additional pathway to
report hardware events, via the vEVENTQ of vIOMMU infrastructure.

Define an iommu_vevent_arm_smmuv3 uAPI structure, and report stage-1 events
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
index 0a08aa82e7cc..55e3d5a14cca 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1016,9 +1016,24 @@ struct iommu_ioas_change_process {
 /**
  * enum iommu_veventq_type - Virtual Event Queue Type
  * @IOMMU_VEVENTQ_TYPE_DEFAULT: Reserved for future use
+ * @IOMMU_VEVENTQ_TYPE_ARM_SMMUV3: ARM SMMUv3 Virtual Event Queue
  */
 enum iommu_veventq_type {
 	IOMMU_VEVENTQ_TYPE_DEFAULT = 0,
+	IOMMU_VEVENTQ_TYPE_ARM_SMMUV3 = 1,
+};
+
+/**
+ * struct iommu_vevent_arm_smmuv3 - ARM SMMUv3 Virtual Event
+ *                                  (IOMMU_VEVENTQ_TYPE_ARM_SMMUV3)
+ * @evt: 256-bit ARM SMMUv3 Event record, little-endian.
+ *       (Refer to "7.3 Event records" in SMMUv3 HW Spec)
+ *
+ * StreamID field reports a virtual device ID. To receive a virtual event for a
+ * device, a vDEVICE must be allocated via IOMMU_VDEVICE_ALLOC.
+ */
+struct iommu_vevent_arm_smmuv3 {
+	__aligned_le64 evt[4];
 };
 
 /**
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 2b6253ef0e8f..f88fd2f5cae8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -447,4 +447,20 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	return &vsmmu->core;
 }
 
+int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
+{
+	struct iommu_vevent_arm_smmuv3 vevt =
+		*(struct iommu_vevent_arm_smmuv3 *)evt;
+
+	vevt.evt[0] &= ~EVTQ_0_SID;
+	vevt.evt[0] |= FIELD_PREP(EVTQ_0_SID, vmaster->vsid);
+
+	vevt.evt[0] = cpu_to_le64(vevt.evt[0]);
+	vevt.evt[1] = cpu_to_le64(vevt.evt[1]);
+
+	return iommufd_viommu_report_event(&vmaster->vsmmu->core,
+					   IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &vevt,
+					   sizeof(vevt));
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


