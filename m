Return-Path: <linux-kselftest+bounces-24025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FADA047D8
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649881889016
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22E51F8AC7;
	Tue,  7 Jan 2025 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZcAMuiHx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278821F8686;
	Tue,  7 Jan 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269889; cv=fail; b=DIkl9uPUTnOt4mTqNxlYw3bw6gDDmlhm82c4/x3iUttuoONeJ9xNgvUGbBHoLX6TDhbL+LfTVAF6kxNO5VS1oav80JDObfUaicO+BmmsLUPFGv30eAGjbKfd4qmFRfvND5SexWHkpEtNXb75jePGq6sbjxgx3tfk3L89Vl8an/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269889; c=relaxed/simple;
	bh=2Ml/mx3dkrJUUmsD/Rj5IaOMykB9XHByRhw5qglBjZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beAOT5yI9W9mWFmOpaHu5RaCQkRHBq0xwFrDU8XB+cHTVsCbnfM8pTR9kOJUcSDlH2v54tF8B7QFOteHhyL2d3BIm/MwX/scb3aFiDZ/OiWoAB90ZIAJU7EriRBR6iToQ8VM4ZynoawDJmzVUGp30wX1ISHlPl9SwbNGSqqHnXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZcAMuiHx; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9Zzr7WLir031R8dB8xu1fGKgK9jQEQRO4f/LkEYnj8TmD6R9KfJMzIc4nOP/vF9NG3tvk+XcqJvrrjl5Madmelxj0yYhkxIi2v9n6J/Zlx1tewfdCM2iSB4unrhLxltRmdiNs3xZEoUOeQ8/K9CWbRxSVFsRTmASq7KK8XabgIyel1CY9fEEq5B7w4YDKjDAVekVfjU2PtBit6nDDnMv4LttYWHjs2ETh3A5zRhtTo7H28Oadtru/yUlRY1JM+rPF/gbDsh5N35d8Rpe9s4GGm2Kt53lCGMcPlinE3p6hOlHbIJ81cCWJKl61tnkjZg96CSp9BHyGohoU0xeGGFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2U5LYuqF/2RTpLwPXGEPwhWzWDJuS5pEs5qrvMXX+uM=;
 b=h80bz/mMx7pZrlfdIQLABph2duhOzhAKdS6v/Q5IDHh6Hmolti8B6bQT9Rg+9c/1HZrpH1HH4C3pnfzQ9KuxiHl+NIS/rMD9F11FxzxagRQ6bbNutmpyWiLrNwvvARarPsftoAoBTy3ifUhg+n3thQR5HIf8h+U1Mn4ki5pAO15J4R0FLD44FZR4k5SOy3zGcEscmSl+o1WDS60Lx6bYuSCVEbAGPVKFiA5HLjkZNbQHMY+KrTvyIAb82az3t0Z5/gWCxG41cbukFjWS0016wc1Rgq7Gd+Q1MtYxYmDPeCqMZniTmh85CfQnPgxoRgy+dFp4/o7IbuVKyqw/Vm6MgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2U5LYuqF/2RTpLwPXGEPwhWzWDJuS5pEs5qrvMXX+uM=;
 b=ZcAMuiHxrNptoRpx5OsqgVWDjk//yJnCB2wWVQ0Jz9MYKdZYsf/IS0TRpebU5Xg+YWYDnPUUbIcn2W6OMiH2tGDpTYrv6Br+4+WW/0p6Q8jboCwvZVnyXKCpLbyGOxRJrIdMXwFkvc3XZpYEK8tx3Xw+LlMThyog/H3S8WTwn4U26rPxSdGvlzYMS73prbJVEkKiwy5mCrDnywb7ZaFXzOtjpsvBjCQpcN+rTGigvqJNm/apG4fJqnlVAWXzwS799nhg2BlvfQMx7U7hEZBJTl7nWsV5I/bmqj9p5YliK8FsgtxcQw0BLYyxcvwRgxSJSPd20agXKU3qn6NbuWMThw==
Received: from SA0PR11CA0150.namprd11.prod.outlook.com (2603:10b6:806:131::35)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 17:11:19 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::2b) by SA0PR11CA0150.outlook.office365.com
 (2603:10b6:806:131::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 17:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 17:11:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:11:05 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:11:04 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 09:11:02 -0800
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
Subject: [PATCH v5 14/14] iommu/arm-smmu-v3: Report events that belong to devices attached to vIOMMU
Date: Tue, 7 Jan 2025 09:10:17 -0800
Message-ID: <03c01be90e53f743a91b6c1376c408404b891867.1736237481.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736237481.git.nicolinc@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5af8b8-3556-43ab-396c-08dd2f3e4d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jz/VwiI2hPfA3lFcdyLTlzXOCajJNAbcUnxtL6WwxWkJGuqnLkOBOfM4cP6/?=
 =?us-ascii?Q?hDFvWZCnYJqUkprLHH8/fQpSw7IehcRoJnXqqvvYT2/gh0dj/DWliCYYrkTT?=
 =?us-ascii?Q?ey3/iEUrB9DbzOyM9wkudy+7GArbQa8rXrkZ7CL/Et2xOnenzvIXZSmpADR+?=
 =?us-ascii?Q?fTt5zsgVM8Kp3OG3q+ZmuJ0Udmpix8zjZQRzWE98nbGAThfoQgwOk4GYOe/X?=
 =?us-ascii?Q?56sugw+yCu0jgseDyw0VP4MSHyoX1LIHDtc2Cr40c+OoMyziOO7TOTW6hrTl?=
 =?us-ascii?Q?vki5IoDNHWtTKOapVF/PEdOxfqyCBS5z04OS2GDAl0Gh/S4r5KRnvylagUPe?=
 =?us-ascii?Q?org+Nh4upo/VLqERoPg3QPjvrI/fBDls0l/nmFyHnYlnnfbRwQ7GIuuO8d5q?=
 =?us-ascii?Q?zpGAcwd2Z8j3sQ1BywK4I9PUx/JPw2tLaLZFy4j0PXrJWpPOyQVnLvVSgEI3?=
 =?us-ascii?Q?XSZb+YGqWv3InSW2LDK0KNStM5JkIyaAedSnc8aIMxLT9/D0XjUD6wJCK1u4?=
 =?us-ascii?Q?B0AUtpW0dpKdwHA67R/C0c97c7D9XUFqIBkxf08VFZC+bHSRSBjvbTyh0JXI?=
 =?us-ascii?Q?UShlSzjCDz5Tb1b/I1csVfbIehAfYnlWNC+lADY8Bb8jCoM9y59TkPOx/MMM?=
 =?us-ascii?Q?ruxrJcfPJObSoMxbuYt4+jSi3wKuEDya117xBFEfHVHPP3cbYDukgNfK0swJ?=
 =?us-ascii?Q?lP/59q5XRwM6z6E5CupW/2fKjFbF7HBv37WOl7GxUrKZmEgA/e0PfZD+O+wM?=
 =?us-ascii?Q?BpTQiUYOtDNQZ47Q0dpp9hseek2jEuxbVPGCxYixQyYoti93hD34/7X2492q?=
 =?us-ascii?Q?0KDNUgiMcMSI/9i9guakzPM7tm+pgTnmdtDKMagRSDSt7uPixXOEDVMxnYt6?=
 =?us-ascii?Q?FOAJ8htlVF43rqPLadlzhp24MSOUJeyc04nQFv8D9KUylGU7UYBOyGgMMI+Z?=
 =?us-ascii?Q?muY660h0MmaU7PTJ9XixNE/rEz57lvOYAMWT3cRb6ZqraHZbJ0xCeZtIJx4l?=
 =?us-ascii?Q?zo4G5/CFaUJcupBUFGITf1oYSZ10zl18kku2l0XSuRtVfFRR9ELdNmpslplU?=
 =?us-ascii?Q?23D7mJQp47svcuYJ2VW1/FIHqXvwpBvZjZqG6xjSFZHWMcWsxLLfCxyy4xhE?=
 =?us-ascii?Q?DilOr1nZGh5P/VrRLrQtdMgf54dwbudmWD2JDTSnpqjGAaJz9nBsURAo8M1q?=
 =?us-ascii?Q?GCiNF+9cDzGx3wImteCZZlrNcYy9NIsCcS03UO0m1rsyBQvM5ha32Xhql5ik?=
 =?us-ascii?Q?VxZmtjVnxsrhGkq1gzak36mfScWE4eRPx+bQ+q2cXTCYCi935quLP/n5Z1ac?=
 =?us-ascii?Q?za/MlKiM3wnAJ8LDkKf+jx7WNjuaSk9/pbP9EfH14QiSae2IV8Y2r6QozC5k?=
 =?us-ascii?Q?6LyC4JfjQk/C8KU0CzlBMyaovt6txScm//GnfdtWSqrvFL9+rpooBV8IiqEO?=
 =?us-ascii?Q?qXa26rAbPSdUnSR7lcKrseb0bAGizj00OcgaQkTbMCjI2toNOyz0biC0/GZy?=
 =?us-ascii?Q?efBwSUGGr07TVzM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:11:18.8643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5af8b8-3556-43ab-396c-08dd2f3e4d6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367

Aside from the IOPF framework, iommufd provides an additional pathway to
report hardware events, via the vEVENTQ of vIOMMU infrastructure.

Define an iommu_vevent_arm_smmuv3 uAPI structure, and report stage-1 events
in the threaded IRQ handler.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 +++
 include/uapi/linux/iommufd.h                  | 15 +++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 22 +++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 58 +++++++++++--------
 4 files changed, 77 insertions(+), 25 deletions(-)

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
index 2b6253ef0e8f..82b4513e56f3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -389,9 +389,15 @@ static int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 	return ret;
 }
 
+static bool arm_vsmmu_supports_veventq(unsigned int type)
+{
+	return type == IOMMU_VEVENTQ_TYPE_ARM_SMMUV3;
+}
+
 static const struct iommufd_viommu_ops arm_vsmmu_ops = {
 	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
 	.cache_invalidate = arm_vsmmu_cache_invalidate,
+	.supports_veventq = arm_vsmmu_supports_veventq,
 };
 
 struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
@@ -447,4 +453,20 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
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


