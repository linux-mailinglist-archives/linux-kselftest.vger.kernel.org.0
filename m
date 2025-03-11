Return-Path: <linux-kselftest+bounces-28777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760A2A5CFD2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA58217396E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D37266597;
	Tue, 11 Mar 2025 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iPERSWnQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E0626658E;
	Tue, 11 Mar 2025 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722354; cv=fail; b=uTMDgzZ3cU8rRPq8prQA0/1v4lDWDtwunaAbTGk9bgLypwSkg9J4DUgAqLAUtH1XorirKwFf71oG+KYCSAszTGC90A8+wZ3sXZU9s7+1G5QQHmPIbcqFk/YFTDrZXuvUTS4AqYS3yngzp/ivbL5UB7gTvnyaXimf3kWmvprpRmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722354; c=relaxed/simple;
	bh=xI8xWRHnOfI9codLmeqhcs41jhFYzFCoSa1pEsa1jfw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Np/zOuDk2LoCq4cy5eoRFrNnJ5aehzHke8MJn755xFIHNL02o530m3m6DztZDQhxPxYD/mk0VK7wTdkaqhQgdt5Hzphc3dtg4EuvwJoWHwK6623Dnq6oxQXGmPATSjkQVNFAEcSwGHpSudH7EBgz0cYBCIl9+E3HSSRJhw51Cd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iPERSWnQ; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+4Ybv4KizyKZCgv5iPCax09bDxiH0Vjeex2SEG5too5ohSxRXQzbJdTzZ3MTT8BQnZNCH6nVQJB5mlYkoxX47CojLu1V50WdelGE52BqdFqzkoOG6v8mIMWUxbnhe5k340/3IC5mv42MgKaLFyFr2gaxX2x12/LaYZjoysYEGGXw6WgsQoCt0iW7jnDOH0kBdmxViPFtKH3vaQSTt/112VtLzSWixP+GM3mPH3Ty0i4vxquV4nJNdO4A6aF9s9iJqVZd7gJBfAQvKvUpfpZK/nBkh7Fvv0oyirFEyP1fLxBzBpBg9UokopyFqs+pvlCbp1bnaLAsb4Tuqp0YPXm7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxiS32odSr0DkjElkJMQNekMxcZtMgE+1qiaDaWeSuk=;
 b=mpJyfd5GaiLn6gvdn5zd4G/I5pQ2kU9PYQyupM+AguJuh9+kwWIrNzXRgfaIebcvkDVFAJOKnAtU7RLb+CaP6AL4YNuPaR4t1/REpHCMReqQfygS3kaieQjCG0nbLi+s2RUTHQOJMYlECgbXblJQNSA6g3gSwhM75QNNr/8OVyDw/5VZbSiB6Di78hGj/joPbudfBbI4xhmUrSedphKl0LQNCVp7Y0CGfIGEEmDYhLEsc4IXoAiS0UnUQA8IWf2padIA2KsGv33fJH6Ta5CXo7HKVhqUTyO0OJwnF46fG8DwAdUtGSFVdq8KEpqRb0iw/emhHqb5BBy0L37MIBHRJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxiS32odSr0DkjElkJMQNekMxcZtMgE+1qiaDaWeSuk=;
 b=iPERSWnQVMw8+/U8r3R920GfdFhruNFucznZGwSEoV6M4HZ7r67cRNT9YsWr87h1Or+JYcivz/FsNhcRMh/AUWx8deAYwlkKCvIzDGVQ++YJLYsIlNJfA2jykFdR8YfpJ5zqfGmZnaz45U+YXfPiISvrZpsEb6OLcMbfoqHFWsGB0EVDP0J6Gv1dckEOrSkigneN93B6kAajRhpOXcMrdWV5UdruJuuBf+uWuMnxio6H3Jcb1vvdRH6C+r9V1yq8Gb10BMS7tbIuTJYmZgJk1to9+blAfqmZ3XXHiIdQ2DinSHoxCamJsFzRbTdI+92U/FrEfccZm0T1GYBYYDXtwA==
Received: from SJ0PR13CA0124.namprd13.prod.outlook.com (2603:10b6:a03:2c6::9)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 19:45:43 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::84) by SJ0PR13CA0124.outlook.office365.com
 (2603:10b6:a03:2c6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.18 via Frontend Transport; Tue,
 11 Mar 2025 19:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 19:45:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 12:45:30 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 12:45:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 12:45:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v9 13/14] iommu/arm-smmu-v3: Report events that belong to devices attached to vIOMMU
Date: Tue, 11 Mar 2025 12:44:31 -0700
Message-ID: <5cf6719682fdfdabffdb08374cdf31ad2466d75a.1741719725.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741719725.git.nicolinc@nvidia.com>
References: <cover.1741719725.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e45fcd9-ed4a-4156-ec5f-08dd60d54edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GffSZLlkOoi7G5wNC4brBcZqRJVhTUix0y8rrmR3Vq2zStur7fvmFNQ3WFqq?=
 =?us-ascii?Q?Rc6vEk21V2v2yksXw9iG6Xsn49gLQ/fW/Y40lwELC5xcHIWQsJMmGmuOw8F7?=
 =?us-ascii?Q?lnUBq6qcS9ghHnZ0IB8cUtbGLS549dh6zIt4VUJKisugv8+IuYs2WLs9VW2h?=
 =?us-ascii?Q?tutxORFbqVTkSO/RccquCpdzcYixxRRBffP523Ex/J9kmy6SXGAIkgPpS9RE?=
 =?us-ascii?Q?ltDUEUPFGDXLGpRqsvJ9a9wPTzhrVm2xsFNFg0+Ih6qOLT3RvLvzaHcTl/Vs?=
 =?us-ascii?Q?USxMHHN4ds3NXjU9/BlhX3gM60pJvakFBwRTwWo6SmpJVM1Xx+jiLGQ08XS6?=
 =?us-ascii?Q?Qjm23E0q8/6kjddteGU21SFX21NHKNE/CVgaOhaodB5xSpfIzZOrJ612WDUG?=
 =?us-ascii?Q?jh9iIshXq0MywRNffzNJlhgGSqNFGmV+/rmJL3ZKtfxEXzKiUID6sid/oon9?=
 =?us-ascii?Q?iCufesg+4qOYooqD2rzoFiPNuce5yCyhtLig7rOATdUudojtNnHRYZVvj1IA?=
 =?us-ascii?Q?LGUZenvPGKhN0j5shrTfVOV4PB2uLywSCgZLPrrDXspSugzne1NVX3vD0Y4F?=
 =?us-ascii?Q?2lIr85VslFAE00p+fw+coDOr3RCI5I3LARZTQNcrZTSo1npRwghwxHs6F9/l?=
 =?us-ascii?Q?KNPdQCqPVpgKB5fCpFXyouQp3E6HVfOdw0vNmex67Zr7YqxksYeI9Jb3F7tf?=
 =?us-ascii?Q?wwN1EvfKCJVbBV/gSur5saIfKEvKROL7foYtjqDSL0HLPr97Q/bjFa8DKiNL?=
 =?us-ascii?Q?YciDC34q83TChNmg1YLVT/iUvomajrmaONHBty3V78NFXVWgoX3ObNGdIH5s?=
 =?us-ascii?Q?ygGaF7q/QBJK/2SPyRU02PpN2+WaX+SIHOYKu0R61o8Gyy8fmX4+7J55igvk?=
 =?us-ascii?Q?TiQmD8qGOa57E+bK5YfUd3up1tfyFUUHTN8MxUmJ2gH6ty9x1V6c/4QLQ9Cz?=
 =?us-ascii?Q?3UUAXJ2xG3UC/+6K69KmcWcWb14Yk7NkpjMzUtB/unRBKRhWerP89b7M9nSH?=
 =?us-ascii?Q?92xfjy7XGXIilFIqMxS7uSkxeixAZnj4dHi9iGLBqlDbEoc/wTz1Po6ulwR4?=
 =?us-ascii?Q?p8B9EDYqmq3X7Qp6oUGySGiNl60E7ZPy7Z6t1jF94BcrBt3z03WKtavXCt+B?=
 =?us-ascii?Q?rhkBLf5DRfw3aMxMNEsazQqP/DAhYIef8b59xkenxOH772kBQaWNtujEk73Z?=
 =?us-ascii?Q?bHw9K5X1udHMlQSBWpQ840fpJNcbfZmzSmJGU+911og4wO8bO2hNJPA8bkhL?=
 =?us-ascii?Q?CTsHE/zLTf9EDUMUYzCWJxYwQYfNlbnveJT+HBFgL2VHREUKsuvAUe9DdsN4?=
 =?us-ascii?Q?3YngM+p3G3Jt81U0S9Cbtv7S9u41a0Ii1c+4dUlZwsuhBOmSLikqZG0qanVx?=
 =?us-ascii?Q?e83G4Usa7MudgaDP6WdRn/ykC0HA6u89QXO5BWp6vXSAyQiY7tm0Z7i5BBsI?=
 =?us-ascii?Q?uoY+3+aoaLLkqYk96Xt1vZGKKMH93fPz6n1/AH1soxmMTOHP+hP3qU57fQ2E?=
 =?us-ascii?Q?fRzz3erhuZve3F4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 19:45:42.3724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e45fcd9-ed4a-4156-ec5f-08dd60d54edc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800

Aside from the IOPF framework, iommufd provides an additional pathway to
report hardware events, via the vEVENTQ of vIOMMU infrastructure.

Define an iommu_vevent_arm_smmuv3 uAPI structure, and report stage-1 events
in the threaded IRQ handler. Also, add another four event record types that
can be forwarded to a VM.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 +++
 include/uapi/linux/iommufd.h                  | 23 ++++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 17 ++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 58 +++++++++++--------
 4 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 557b300a3a0f..df06076a1698 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1066,6 +1066,7 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct arm_smmu_nested_domain *nested_domain);
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
 void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master);
+int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt);
 #else
 #define arm_smmu_hw_info NULL
 #define arm_vsmmu_alloc NULL
@@ -1086,6 +1087,12 @@ static inline void
 arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
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
index dfc80e1a8e2e..65adfed56969 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -433,4 +433,21 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
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
index 964d2cf27d3d..5fa817a8f5f1 100644
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
@@ -1866,7 +1869,12 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
 		goto out_unlock;
 	}
 
-	ret = iommu_report_device_fault(master->dev, &fault_evt);
+	if (event->stall)
+		ret = iommu_report_device_fault(master->dev, &fault_evt);
+	else if (master->vmaster && !event->s2)
+		ret = arm_vmaster_report_event(master->vmaster, evt);
+	else
+		ret = -EOPNOTSUPP; /* Unhandled events should be pinned */
 out_unlock:
 	mutex_unlock(&smmu->streams_mutex);
 	return ret;
@@ -1944,7 +1952,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			arm_smmu_decode_event(smmu, evt, &event);
-			if (arm_smmu_handle_event(smmu, &event))
+			if (arm_smmu_handle_event(smmu, evt, &event))
 				arm_smmu_dump_event(smmu, evt, &event, &rs);
 
 			put_device(event.dev);
-- 
2.43.0


