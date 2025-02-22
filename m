Return-Path: <linux-kselftest+bounces-27278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB88CA409C4
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 16:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B871E70432D
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 15:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB33F20D519;
	Sat, 22 Feb 2025 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eDTfdZ7M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DCA20CCF4;
	Sat, 22 Feb 2025 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239700; cv=fail; b=nIFBtJHH7Zkww8r1zg10aZdYpb7DtKhqTHdyJs14OL5HqAcWrSi86Dv4WeWwemOP8jLKvjRyrHMNtaSxCNDecStXOhH4X8McOSnblzRGVSu2qKlWTkgJIP5/INCx8kysK3qZZ7dvQvg6bPZK31dx9T/cL53UpGkmLILEnSKT7KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239700; c=relaxed/simple;
	bh=1pxnHPoBJ14AYx2x5nf1rpQZJDgD/CaqSiEnUcK+MGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ex3fDzzpEDJQy27nFR03PuKwNiX3bjGti375+GYUsbFEO6OiiiEsLwqI+PoHPZWK0+czGphZPTvO8DW1FEYTF8F8lUiFC9b4AQNAuoFABfcMJGuix6KcyW1m7x6lSaY/rlBU7A7W7V7hedN9NssdgrZXeKN7+wI66KQ4JRmu4ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eDTfdZ7M; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqGwX/0Lony2UBQQLKZE6XwkYyMTzm+DLKfOisf1SMnAMQE0g0gdLCWUZ2aCNIxCwQsQbVvQ8B9xAya8j5FTC6COJ/E539qnE8r1uoEmhpqHfUfWUsebiI1ufiIOVagu5pi0K0NlHz5cwhjLP8TEnQKsr234Rlu3NmdC1I11HGfd+eQBU8tX1UeNKnSCt6+KWcx+n7d0+c65nbH5IlBaPnIPy9CyZTUlqnFCYzWoXNUosh5Krh3UFGhzpxByjEvG9p6Vzxfjhae6wJ8E6qSkRXSOJmfuZ+IL4t0WYcciDQgndh9jo0fx6gAno9xT8wWpbVdqzEN0qVDyvCTuyI0j/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrtTbc5CQziED69p9FmcpuzNc3Jz+cizNlIOb2T2l/g=;
 b=YFo5OTR5NG3s4uAPrbzsjkBAuYT/7HNIp5vu2g5uw6GwXkdjV4cxruizh2lcZHrT6lS84FP2z0YH/9AagejSl2EMOUMNX9RriFDzzs8TY/vOKKp9JB7C+wbrfKoJr8ZjMhlnaMCQGS178vzBX/6IQ6/lCsEKFs7T0eu790yc6DhA386udVfN1JPXDFA7VrSh1iY08ygzT8SpK6lWjyZ3BVCGf3JvYnFa+lMaiK9guDxbuT5LcNIVxub3pOd8Ltc3Hwa/r8ePhi3UvtTQ01bfo2fC48XqkHnvOce9a6Op7BJkknY/3i0Hdm8Iijmuc7DHXdtzIZ2Iiw3R6vq6od9Zqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrtTbc5CQziED69p9FmcpuzNc3Jz+cizNlIOb2T2l/g=;
 b=eDTfdZ7MZ+4rfjnfl6NUcN6HGp12EZAjE0qf4OEwkq6Iw9ezPdFB9DVw+dAG8IL/UEnGm0LCRXUKRwyeKkoXtxf+7EN5FJXIsokFSCCIJoZVT1l05LN+YrcHsY6vQURgFSlCuS74f6IKYuApzEDaS6DMZ0DcIQAbjysbC+BV52UuSLiyo6yM92wi0Tl0FMhy1ybOPFbDtlktRBNAYEFajw/PDt7qk7oruytfVELv+xKdb+TVvgfbneYhwCxaM66uFGHizioXpfzbDyQRswW3NftO234wFksl0B9WWflQknN2d3xb+9Y3sGZ+4IdHt+c6hfXmdWFREh8NN43L6DiFpA==
Received: from CH2PR15CA0025.namprd15.prod.outlook.com (2603:10b6:610:51::35)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 15:54:49 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::7f) by CH2PR15CA0025.outlook.office365.com
 (2603:10b6:610:51::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Sat,
 22 Feb 2025 15:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 15:54:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 07:54:37 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Feb
 2025 07:54:36 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 22 Feb 2025 07:54:35 -0800
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
Subject: [PATCH v7 13/14] iommu/arm-smmu-v3: Report events that belong to devices attached to vIOMMU
Date: Sat, 22 Feb 2025 07:54:10 -0800
Message-ID: <b1930038cf828dc13c080e2b46b3003a8c98ef24.1740238876.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b83a5fd-a0a6-4e49-2062-08dd53593cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bMwEKbcRY7Vqzc7vhC6pw1/QeZ4s/NWuZgDlyO7UoIn1MqYRhQWc/TG/jNvQ?=
 =?us-ascii?Q?Kk5ECSw2ssuhWFNh3jz7Mjl7w3yRt8deaYF8QTSNnDbj+qnaTqOGN7l2byYF?=
 =?us-ascii?Q?OsLiIXFHH+e2BHEkyzB93Ll9E5kCDL1RwJVNHMWph+wLi3ahRavxRk6ndcva?=
 =?us-ascii?Q?i69BRSsftK5S+kgbeZmNUGQBmOkvc+TaAvsUXncwg5i7YsL2b99oDtT+tMMQ?=
 =?us-ascii?Q?R2JX9sHyOSj9n9bxyDbQdGNRi5DS0xD8PozeXMVnqcFDQQS7AaHph91QsjmJ?=
 =?us-ascii?Q?UyNB8UPT/kKD5vCIgE4dyOSWJ4R0v8B0SJN7nouM1yscLNpvCMV1Qa5ABQB/?=
 =?us-ascii?Q?3yH59HUvfwqDrvqS9npbTRXj2fj/08womxUTaQopVjX90mb3e6LgY707hnpD?=
 =?us-ascii?Q?tKQDEB0q3xyvGW3IsdiVtxtrdmXj9lpkrvtAitVLPucQbRT1L9OIRQUioQ69?=
 =?us-ascii?Q?zG+v3QJjIGdm7mnGnn2ZB+nfzUVOGj6HK/jlm38oUwWYTn7cCnXlwKMLijIh?=
 =?us-ascii?Q?OF0dbS6fSq4CEUKLe0B75q6OKVxQSzmvkqypLKOAQR7buGlfZBJIX8MHlWwz?=
 =?us-ascii?Q?lgcssjoi/bX4Xuz3nwuixd9XPQ+Mu7FHaKTplosSgximP6E2HRjiZif9rGHR?=
 =?us-ascii?Q?0M43ACO9OcTusAXvr1gFZi5upkNH1Vfm6aY5L8uX44emrf2E1X3BUwiiSmj2?=
 =?us-ascii?Q?FOedElLbtXAOUg/kLOvp76jjQtlrILYi68qXGzCZe9rB0vFIxWby1N1H6OlG?=
 =?us-ascii?Q?zbu9KqNBiXlZwZ2jcYVtXG/BYN6UIlKm1GaHDhE8gDvJBj6F8pAFct2kiPmu?=
 =?us-ascii?Q?zAcPA4Su/IKrBCCvC66T4MQ6UgwI0pys/4lN5pQEs2+Q0euEJ57Rco8B5qwF?=
 =?us-ascii?Q?3af4zNn0a8Y9nj+I0rt79XLWz42PCGu0ndcTqF0zbEhZl/liJ5cM348lv/4c?=
 =?us-ascii?Q?ZZwGejd8MaoXEt6j7TVKbSHfB1+0bsTZww/FIQVDeo5zt47a16Zaq5hUwCls?=
 =?us-ascii?Q?bxoHp2gMHJjMaI+ukVmmt7F94ESP5F774xV9bJ7dqIsxNgKU+Nv6DY7fdBYy?=
 =?us-ascii?Q?1D64JWYsLL9EkNBiaftk76K8S/hcDFZ7+TMah9GWGb9dsUZ58acGG1UEKwr3?=
 =?us-ascii?Q?RnCpXI5KVXZ112VPxzbrlKkgcj/EdSrGvl0m391Wi4q88upidAsPyulGLY/N?=
 =?us-ascii?Q?oJZOT3ua91LhUZckTtqy5rHr9WmMtu3Om0/V3EoV4BrtH5adX8DCnGhOGGzN?=
 =?us-ascii?Q?4N72MdK870eJ95kMI6VAo1nfPMF2JPhRVyGcL0EAk1nIDdUnGKJKbdHUdtzC?=
 =?us-ascii?Q?0xc3ZqcA3JJA7RAAYVKJ9xq8RHo3/vQlwCMbdtORv54FQbPLA1MNLHsF0uEs?=
 =?us-ascii?Q?uG91J+yOQqS0ld1XMYfCYS9WH76j1m/aUWY7m3PU/csBlNuHxgSXwe6c4wsm?=
 =?us-ascii?Q?vBYTRrEa1AoG7+GFXZePihGpnTtuh1MfGTST3Hb7HVqsUt3MM4P5PEmvldh/?=
 =?us-ascii?Q?AFGKcXJ4Mz+PlvU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 15:54:49.0966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b83a5fd-a0a6-4e49-2062-08dd53593cb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052

Aside from the IOPF framework, iommufd provides an additional pathway to
report hardware events, via the vEVENTQ of vIOMMU infrastructure.

Define an iommu_vevent_arm_smmuv3 uAPI structure, and report stage-1 events
in the threaded IRQ handler. Also, add another four event record types that
can be forwarded to a VM.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 +++
 include/uapi/linux/iommufd.h                  | 23 +++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 17 ++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 60 +++++++++++--------
 4 files changed, 82 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 85352504343b..c8574969e700 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1067,6 +1067,7 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct iommu_domain *domain);
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
 void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master);
+int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt);
 #else
 #define arm_smmu_hw_info NULL
 #define arm_vsmmu_alloc NULL
@@ -1085,6 +1086,12 @@ arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
 static inline void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
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
index 2ade4839880d..5fc7e27804b7 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1054,9 +1054,32 @@ struct iommufd_vevent_header {
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
+ *       Reported event records: (Refer to "7.3 Event records" in SMMUv3 HW Spec)
+ *       - 0x04 C_BAD_STE
+ *       - 0x06 F_STREAM_DISABLED
+ *       - 0x08 C_BAD_SUBSTREAMID
+ *       - 0x0a C_BAD_CD
+ *       - 0x10 F_TRANSLATION
+ *       - 0x11 F_ADDR_SIZE
+ *       - 0x12 F_ACCESS
+ *       - 0x13 F_PERMISSION
+ *
+ * StreamID field reports a virtual device ID. To receive a virtual event for a
+ * device, a vDEVICE must be allocated via IOMMU_VDEVICE_ALLOC.
+ */
+struct iommu_vevent_arm_smmuv3 {
+	__aligned_le64 evt[4];
 };
 
 /**
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 364d8469a480..42c7daf4c8c7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -445,4 +445,21 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	return &vsmmu->core;
 }
 
+int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
+{
+	struct iommu_vevent_arm_smmuv3 vevt;
+	int i;
+
+	lockdep_assert_held(&vmaster->vsmmu->smmu->streams_mutex);
+
+	vevt.evt[0] = cpu_to_le64((evt[0] & ~EVTQ_0_SID) |
+				  FIELD_PREP(EVTQ_0_SID, vmaster->vsid));
+	for (i = 1; i < EVTQ_ENT_DWORDS; i++)
+		vevt.evt[i] = cpu_to_le64(evt[i]);
+
+	return iommufd_viommu_report_event(&vmaster->vsmmu->core,
+					   IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &vevt,
+					   sizeof(vevt));
+}
+
 MODULE_IMPORT_NS("IOMMUFD");
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9e50bcee69d1..fdf8bba14303 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1813,8 +1813,8 @@ static void arm_smmu_decode_event(struct arm_smmu_device *smmu, u64 *raw,
 	mutex_unlock(&smmu->streams_mutex);
 }
 
-static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
-			       struct arm_smmu_event *event)
+static int arm_smmu_handle_event(struct arm_smmu_device *smmu, u64 *evt,
+				 struct arm_smmu_event *event)
 {
 	int ret = 0;
 	u32 perm = 0;
@@ -1823,6 +1823,10 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
 	struct iommu_fault *flt = &fault_evt.fault;
 
 	switch (event->id) {
+	case EVT_ID_BAD_STE_CONFIG:
+	case EVT_ID_STREAM_DISABLED_FAULT:
+	case EVT_ID_BAD_SUBSTREAMID_CONFIG:
+	case EVT_ID_BAD_CD_CONFIG:
 	case EVT_ID_TRANSLATION_FAULT:
 	case EVT_ID_ADDR_SIZE_FAULT:
 	case EVT_ID_ACCESS_FAULT:
@@ -1832,31 +1836,30 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
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
@@ -1866,7 +1869,14 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
 		goto out_unlock;
 	}
 
-	ret = iommu_report_device_fault(master->dev, &fault_evt);
+	if (event->stall) {
+		ret = iommu_report_device_fault(master->dev, &fault_evt);
+	} else {
+		if (master->vmaster && !event->s2)
+			ret = arm_vmaster_report_event(master->vmaster, evt);
+		else
+			ret = -EFAULT; /* Unhandled events should be pinned */
+	}
 out_unlock:
 	mutex_unlock(&smmu->streams_mutex);
 	return ret;
@@ -1944,7 +1954,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			arm_smmu_decode_event(smmu, evt, &event);
-			if (arm_smmu_handle_event(smmu, &event))
+			if (arm_smmu_handle_event(smmu, evt, &event))
 				arm_smmu_dump_event(smmu, evt, &event, &rs);
 
 			put_device(event.dev);
-- 
2.43.0


