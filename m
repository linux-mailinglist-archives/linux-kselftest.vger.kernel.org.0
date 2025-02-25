Return-Path: <linux-kselftest+bounces-27510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A39A44853
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED6419C3B3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A086214A86;
	Tue, 25 Feb 2025 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GsS0oH1d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6B2139D3;
	Tue, 25 Feb 2025 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504405; cv=fail; b=bspUW4qFwbnZvz0J8ZaUKs4nwfltFBJpbK2WL0GIILc2AfdAY9mQH/VtgCF1jgTCldZB9UytSizEomdNt1qCdVVCPjvPVVepMz5Hl+8khArkMdMtD9vp5JEfWTQjJBTi4ZqgOOBPmbFL/U5tqeQwuIkiFqreVNRaBoSbnSboBiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504405; c=relaxed/simple;
	bh=cgInUe35cBgvIE4sw8nivpBdUIUU+w0MeFCroJ3fJIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTp0pO4wVicLS7qoWk19CT9mmjipzi9jSE7jG8Wrz/k5M2k0UCFOU6vg06vR0JauoWDqDnIaFbMmEQMvrZ1kN1q4RFPdcWC8MaXXHXW5vONCkUZu8aZVcQGh24FUWNAZPbP2s1vdthnmwKMT4m7u46sJdePan5WD6HuP97UK+Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GsS0oH1d; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBv+diO7hraGBPBOvXphsPBOoTipSIMYUIC9BmzMfi7QK+vGm/naa3IEJ5w8ngeyDJ/hV2inTnhXC9+hoYmKiFquu8YAqI9wEA6BmN6Ny6b15ypG4RCkDYO99kRf7pUE4mLzqub9ghOxGuzPEG4cUaWAhW4iQ3lbKhOa3bpv2lZknlGim8Mqsb22m2y8N5pgujUK++oDRCkDzb07bObT6GRCNpspY6J3ne/CDVRYIi/bMJRznnW4ONFmeEy0UQaH/poXp3gJv6khuYdVECF3vmlmbzJBhbptg2A1VN+7VfShNiM6/o5kEdy/I1cuWzhM4BIOQ8+7Lqeh4AfNUIDwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/zP9+ZDIHhvoSltwO3MofaBc1N//2OzhSQVlOKkmc0=;
 b=wv4ya+ah1APAcZhLgIDSns4ffglZvt8meVwMjXNw1bUGVNxl3y1W0nxi05JjBGMfyNly3/5+e62ZrcP9QMkKacbYVnrk4Ey3/4QF+fPP7lVTZcWLNYYv+vHEVilTUg0+YaMPZg34ZjYEAEgsaYDKe8521mspFET4Or+AhH4mcj8VVotT1yqNgn752JzOzhWkN22t+c4m/f5M83FLuEdsg1Y+7XUg3KxDEJ21umWIQ13JjHL5rTbKJapZ5PxsPkvf5tQLFjyJZ0S5P1cyLLzzpd8Ju7p7nlyfDn6BaPOox0EP85/xkjbQmDq18phDljNFqSyPsDyadMru/kU/jllg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/zP9+ZDIHhvoSltwO3MofaBc1N//2OzhSQVlOKkmc0=;
 b=GsS0oH1d+jJWJHMxyc42Ec4XwtZzB0jTh55NqiDPvJeJEjrZfQmXps1IUImrNofju3+oVkDokuZYnf3mgLgW8TBy7acFVAjj6awGQVuoucKlWaB027I81+qXxvKb+SSeGznbbAW7F2fsSFSxlx29vG52AfPhCKkPbLA8Z3SIzIK6MtxvFdLQKJa4sm1QCd8SazD/tRMrqIJ2F/UfKftT6YJ3zLKdRcwqMEkpBeKz9DM+6AHWs7TqNIQahcbgntH0QMYgk7PFwXcU67aX4GXLxQHTdCVSZgkv/EfHMpJUeETeOTb0lfTvmqrjm9c0xZG52e7Y9FrSQeJ+RyAxG7Jo0Q==
Received: from BN1PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:e0::26)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 17:26:36 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::76) by BN1PR10CA0021.outlook.office365.com
 (2603:10b6:408:e0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Tue,
 25 Feb 2025 17:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 17:26:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 09:26:12 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 09:26:11 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Feb 2025 09:26:10 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v8 13/14] iommu/arm-smmu-v3: Report events that belong to devices attached to vIOMMU
Date: Tue, 25 Feb 2025 09:25:41 -0800
Message-ID: <7f6813dc2b62f5f396ac3172dc2a7d9bf3b47536.1740504232.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740504232.git.nicolinc@nvidia.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: cd689844-5399-49a5-9cd9-08dd55c18e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MJrUKJPCQRX8yclc8VJE/938I66yZSz6AjZ0mnxbv+lGgg+nAUBI3MGyngBX?=
 =?us-ascii?Q?0XfL/LUiZW1+WMFSs5OM9oLHkhUBCqhGQuxhYgAq3XK8tHWfYBiPpIhhzjIc?=
 =?us-ascii?Q?Dv4neq9NL45Xy2Qh4LTvsdMT/2+BwjKu0mbI/0XXdueIYVGRS2jDRSP6XrOC?=
 =?us-ascii?Q?10HA9wVMe7C5iJiE90MhL0r1rngDiZNiXB/oCN/d/BkxusBg2Y/vQvdbpmDk?=
 =?us-ascii?Q?+jxIvQnjaLm2T8jGxdamqLGUn7zDtON7fBInK6Be42XrhEedg8v7Hmu21b/g?=
 =?us-ascii?Q?ACevAJnozSy8uc9/f6jvaE9yOqfnNwwg+Y1La/1MNhs60by0PcLiHMGpl5dp?=
 =?us-ascii?Q?9o0jeZ+JjuLIrzIhUcnayOMKZ+lUGjD8RdaZv5BP3pksrszvin/8Wj5jbbc5?=
 =?us-ascii?Q?sZjF4wJnM1ucG5p1ONpW/hQHSgxkC14Tw29/2p6FF22hI4N2pa/dV2iIoAX5?=
 =?us-ascii?Q?vSztKkdxmoJUbl5wL1PTX5hRVirw3kUX/urvOgPTTdFfxmj3yo1K5u/5Rsfq?=
 =?us-ascii?Q?DHnjMzD9Pq644b8hkh2BjwbqEQdVXIFyj4P0OPOYFdSm+404tL4kztMBpfz4?=
 =?us-ascii?Q?CwGtgnJCfxcPKz+9yCv/1ucgK4kXGHYykLfkBfUm0YWjItp3Pfi45XhnitUx?=
 =?us-ascii?Q?/7ad3rQyJhKmhtAmIQZc45aTLVTe2pL5J5ifLA3nKVJP0lsksSC53zNA9iLN?=
 =?us-ascii?Q?YVo3tN81H7i+Vwqa8lGH+Y+5TPpnP6SQ06b1uR+JUGr/PNwEn3zOMEzWUolR?=
 =?us-ascii?Q?zQKkYLOiX7XXOMY83LTWiejJvmnm3Q+RHkGf+q+U53C38cfPI6fMLcq7u9Gd?=
 =?us-ascii?Q?YeHiArVYfJlxXgZ2YYroIe3R5Hy0ZDaODzWs1xy3pEHGS1YOuF6A88r+MTwf?=
 =?us-ascii?Q?6VtOqSEYEi+COO6cH/IOfYmOWRQ+YFdtr0Yojv+VGb78PE6dRYzQvoeBxkab?=
 =?us-ascii?Q?FYXq/rnGWHksR3wU6PyRF29GgHf1yGkWXANjfcya5XhFm2FjgAzEBb1jed2E?=
 =?us-ascii?Q?F/4aFDWGt+SDuBHU01FgI7hP4jiz9DcLpX3WwndlC04s2PjS/08MzC2DVnj7?=
 =?us-ascii?Q?JG+3cy2gwVF9rWVH9ODRV59d2qzkRIWz5YiLpGYEA/rQ4UtrQpytRI0jFFBK?=
 =?us-ascii?Q?P8G8MKH6nP61n2gz5Q+TEYn8/1VwxfE5kDX15GF1pqo36iUbp/KMjadcqX7B?=
 =?us-ascii?Q?HY9ZVaJiDBsCQHKNeZpVvcbRloxQ9p9ccXfEH771aEek4pGzwAVN5pKa6Zf3?=
 =?us-ascii?Q?fzjIpaMlR1cs++2vWEEnTeAALsxb9+dRcKulTpouednsInToIU+9qiAs8tcR?=
 =?us-ascii?Q?zpEF+831dBCOSKjW/6ABjpewFdw4MGIp9TX+4ffoOKCnI13ABlUWuNWytF4j?=
 =?us-ascii?Q?t0Pewerw6YY72KG1HHTbjm3Up6YMqR9LjDSiZQup7cOh3xTk05oDdJTiA1Dy?=
 =?us-ascii?Q?gQG2UNCd+UdKKt4lBzW13bCwSrr6rWthT1kBuvVTeOOWRi4y81Y4x8El3rAM?=
 =?us-ascii?Q?vg/7RxSKN3c4P1A=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:26:36.0873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd689844-5399-49a5-9cd9-08dd55c18e68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324

Aside from the IOPF framework, iommufd provides an additional pathway to
report hardware events, via the vEVENTQ of vIOMMU infrastructure.

Define an iommu_vevent_arm_smmuv3 uAPI structure, and report stage-1 events
in the threaded IRQ handler. Also, add another four event record types that
can be forwarded to a VM.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastavat <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 +++
 include/uapi/linux/iommufd.h                  | 23 +++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 17 ++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 60 +++++++++++--------
 4 files changed, 82 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 36961a3579f2..f3c5c49bf131 100644
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
index 6b712b1ab429..649e3aa39a48 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -437,4 +437,21 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
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
index 964d2cf27d3d..22aa5c8d1e9d 100644
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
+			ret = -EOPNOTSUPP; /* Unhandled events should be pinned */
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


