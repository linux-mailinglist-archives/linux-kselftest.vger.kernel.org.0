Return-Path: <linux-kselftest+bounces-32133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F0FAA673A
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7683189089D
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432F027FD7E;
	Thu,  1 May 2025 23:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sIqlApm3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F1D27E7F0;
	Thu,  1 May 2025 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140569; cv=fail; b=OofR7A1k3empYrynNoS+l5L9jwF22QyPSaZvLEI0QhmHu73pKt1pZI7dbWlIFsQkt/DjZTQaNf1P45H6SHTZaLvaTG9RjLlgQyW7dI4/AL4YyislTomzbO99pnHQayIGsw5a+oH2frqVUJc5sMImerMtc7xNlHhNBx7wCYQ5QCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140569; c=relaxed/simple;
	bh=XCVeOmkPsT3/ic1oqpKV/Wst0ITfg3wTedBeboJmBuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRclXEpSMU2XKcdo2R56cQJjuIelkfe1KGra+fN6VogYomHf5VGFlSDFFJ06LOZ4cxkySr41LfwmIXVo6TJd9E1dHFDr1lkKc+csk/gI6IlWyx3+V4NtpVLOlk1BbwJEl2SdzKnUtId1E8S/UhlWPtbz0Z/8k42qoWXrVGeRcxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sIqlApm3; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSCLL1j/AJH1s3FQ6ou2po6Jul/W3ZrCzRiPN56BhH99mS8MoRsS5qKq060FGLK4yMkgyEFBU1zlf1SSDVhSbJZQSLWNMy/QAJQEPFgASHQH4t+KEHxjIiORoG/MpUD78/ct86PoETs1iMRyUpNIdhYLmhOvpUrvc998Yb9EHCeGjSyJkeHDlYtreTSEWJNJk/E1zbeNzwdYn312ynvEuTYZV/EXHjFNszT6kNz+G5XGIjUm7SKGezXkpZ/MKslkzT7bzjfHBgRgkmm4fbPx426QkhpEd/H49JcuKFKDihF/gBKz28iP0jvVy37QA/zDxsElxmcUs6JZ0VulCOkWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFl6n7ATIE1GzsJDYu1U6Xvp27ThHDt955MIPvkONe4=;
 b=zTz5wf/nX+gGd0amv/CJ3YApInZEPsP3Klpd32Swuawck9FD5XETmgQca2ZGPxWB0hBmZZJDQlYq0Ulb2wam4MlJAZB6DxHMkswSxtx7822OhDgs+pjQ9AUxpjHtxigy1dBWMcMlnYXYxiP19QAI7yTc+tgYCQN1lmNZ9DXgBxw5wciDD1NvxmMHfktG9E8L5s/drqu1UwHcuIEKAX1sF10jlo6cu0ZLca1mtdC0fPC7W7Sds/22LyarMQKIBz119ADbmmNrZ2MDTzBlhItiinD6gH9h2qTdykeUXDEWoM8sB0EO5TNOVHYiKHIviXe04vVo3RLCbmkuibcq7cUXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFl6n7ATIE1GzsJDYu1U6Xvp27ThHDt955MIPvkONe4=;
 b=sIqlApm371qVzZfTj0Q2quhDUaLHQZSsyzSVZSM+4+2j95vbEpCwapM/O9RJPukRxbFaxYF6nRAaMOM2aD7Sx6VnZ4ceN6BbNnUA4lHAT+jbDztXRpj/AB69utAnAXrpftWRKjJ/ApaPmgqWv8+oWhgYVeqGOQpmUxXRu2yoZCk6X/5Y0mGCFHImY8HhnH9P4+D/OC6p1v0ECY3rsEXbKs3JNK9CeljyVq8igphTP1QcKTwxQ9WdEhhiXYCvy5K0/viebPOF5AmzIkFYS9g5AkOHE4FKHFsN9C5/tWF/Xm7LkVvAA0l6WbwgzTONrdWaBXSN2AsaxmmSbss9LZRKfQ==
Received: from SN7PR04CA0228.namprd04.prod.outlook.com (2603:10b6:806:127::23)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Thu, 1 May
 2025 23:02:36 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::39) by SN7PR04CA0228.outlook.office365.com
 (2603:10b6:806:127::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Thu,
 1 May 2025 23:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:02:28 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:02:27 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:02:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v3 22/23] iommu/tegra241-cmdqv: Add user-space use support
Date: Thu, 1 May 2025 16:01:28 -0700
Message-ID: <5a67688a9675e7787660a51774b3213094875028.1746139811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746139811.git.nicolinc@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: ed044e94-f4df-436d-bb64-08dd890443bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W6/3fZgYI0kgdCp34il9joLYmvtZCu1e3aIird2EJtEJZkLAXNABZB02dk+m?=
 =?us-ascii?Q?mIwn1gIej2aI48130dWJpGviOZA7ckWwTVM4EnrLSQnbWNVNXGCppUqqilT4?=
 =?us-ascii?Q?fVNuGBxayNhDRXPYiA16yOGjzRNJ3FSEVg1BpdNb83fO7NAyGIw6D9N0uIrO?=
 =?us-ascii?Q?v3C0f+7JQ3PJMUvpYADWztw9+hq5Ba/pOi1/cXy3hcRxU6XGBc19xkNPGn+d?=
 =?us-ascii?Q?r1hELGEf2qbpOrC+B09y28v6iK+XRbrZ3edwBctFjUHqHXfrlzdMamj7K0ZJ?=
 =?us-ascii?Q?/oLGYR+Bqu0/UTb82BviXgBTl7Mb0zYbda9iLzNNUAtEqupcnHRJ29kCr6K8?=
 =?us-ascii?Q?tfcEc0B79e32oVzKMo9wrzcyLUZyf2XY7qEXZi72Qhx7jmX0Wukhr31vzsBb?=
 =?us-ascii?Q?zGGnfjWMxPnEJmi7aVlpPGGpzy6yfXM3JWKDE8TmC6EOObjg0LVe3TJIikeo?=
 =?us-ascii?Q?7SxFormcp0XAGC5vEX6X9MpG2BLaONAZ+OjlW79q8nwQA+hwHWO3hhNqR+BI?=
 =?us-ascii?Q?FRBI69yhgvMjZLJmlfBZUUTHIbuXnOnwms7Hrfh0LxvBl/cLDiITB4LeNSgQ?=
 =?us-ascii?Q?sHJGKzEcNtLjTa4/xEYZtD6FvGemLiHGy12ywQW65JYrR3w/2h7JNA9SFBcv?=
 =?us-ascii?Q?PCgOP7mlvOccT6IwPov93EeP6P9kvrS6f2rsvY8YjE8J9MQSoRKyUUY44xDf?=
 =?us-ascii?Q?O+vYzir2noPdPvVxcDR3VJ6e2tkvoKrqWjyvkwAJjostHLxh/YiFdXB4RIKe?=
 =?us-ascii?Q?vmenDQ+CBxYfod0V3UnxfhTmrD2L9BX63JFXKLK5tCfMXlWF0eLFQ1z2p3jr?=
 =?us-ascii?Q?hwVdmH/MFIc70PfX5e+X+SXMmeJ2coL9EcncwbsZHIQNxqajBudmjmjbLf4u?=
 =?us-ascii?Q?uwkFBi6l0lz2k01F5RWdkl37aTyfUIt0a4rJbMfuBrRsFNPGXA7zIOoZdRkY?=
 =?us-ascii?Q?3fs9/GekfT2ikjaC7196a/jsXNwwdakqAFFNkCibD9MtZbveDtuS62p0OUwN?=
 =?us-ascii?Q?3B1pNhj1ssn2VqjechTCuOTXAIaxQYiJVw+uamreoYM/6PRN40fQy3V7NDid?=
 =?us-ascii?Q?kS0P53+DyDcrbhWDSd0aRVPOmeRhZ7GvvIkfb3rZPiAGg4Pzv6WKfytTq3o4?=
 =?us-ascii?Q?cQT//VIMOr/x+n+hgabH9ELZFjE+dgeuRMTGunMEvieoPQb4H63GnH8/mR02?=
 =?us-ascii?Q?cS3owBZ8+mbXn6tkBEa5tZLurxDlwso/xyPECI8bGFu6gKevq9kwfpfTEmdD?=
 =?us-ascii?Q?NOCPtmjucFpe+hky52WsUhf/Jup1KxDF8rS2EbXgviQFUhbYd464QDkofacM?=
 =?us-ascii?Q?q+ChuqFsUwZ4Wr8Pm02X/359Wmx9DSosp7/XzT5+sNojEM4lU4Vd0j5g9nEQ?=
 =?us-ascii?Q?sU21Cutr6kFUFU5mhTs+RPJ2POp4jpbfxrLrMTZ9INPC9X7R6e3ZRImrnRFx?=
 =?us-ascii?Q?zYowr76NlB7GgRiledVW9bhtD9+6zMsXdMUg8qX4130YYT4J25RajssISJge?=
 =?us-ascii?Q?a1SyeJrZLJLzS3vlGPzDbHSLfpcEsw8UjJOR?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:36.4712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed044e94-f4df-436d-bb64-08dd890443bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238

The CMDQV HW supports a user-space use for virtualization cases. It allows
the VM to issue guest-level TLBI or ATC_INV commands directly to the queue
and executes them without a VMEXIT, as HW will replace the VMID field in a
TLBI command and the SID field in an ATC_INV command with the preset VMID
and SID.

This is built upon the vIOMMU infrastructure by allowing VMM to allocate a
VINTF (as a vIOMMU object) and assign VCMDQs (vQUEUE objects) to the VINTF.

So firstly, replace the standard vSMMU model with the VINTF implementation
but reuse the standard cache_invalidate op (for unsupported commands) and
the standard alloc_domain_nested op (for standard nested STE).

Each VINTF has two 64KB MMIO pages (128B per logical VCMDQ):
 - Page0 (directly accessed by guest) has all the control and status bits.
 - Page1 (trapped by VMM) has guest-owned queue memory location/size info.

VMM should trap the emulated VINTF0's page1 of the guest VM for the guest-
level VCMDQ location/size info and forward that to the kernel to translate
to a physical memory location to program the VCMDQ HW during an allocation
call. Then, it should mmap the assigned VINTF's page0 to the VINTF0 page0
of the guest VM. This allows the guest OS to read and write the guest-own
VINTF's page0 for direct control of the VCMDQ HW.

For ATC invalidation commands that hold an SID, it requires all devices to
register their virtual SIDs to the SID_MATCH registers and their physical
SIDs to the pairing SID_REPLACE registers, so that HW can use those as a
lookup table to replace those virtual SIDs with the correct physical SIDs.
Thus, implement the driver-allocated vDEVICE op with a tegra241_vintf_sid
structure to allocate SID_REPLACE and to program the SIDs accordingly.

This enables the HW accelerated feature for NVIDIA Grace CPU. Compared to
the standard SMMUv3 operating in the nested translation mode trapping CMDQ
for TLBI and ATC_INV commands, this gives a huge performance improvement:
70% to 90% reductions of invalidation time were measured by various DMA
unmap tests running in a guest OS.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  15 +
 include/uapi/linux/iommufd.h                  |  50 ++-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |   6 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 404 +++++++++++++++++-
 4 files changed, 466 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bab7a9ce1283..d3f18a286447 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1000,6 +1000,14 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
 				bool sync);
 
+static inline phys_addr_t
+arm_smmu_domain_ipa_to_pa(struct arm_smmu_domain *smmu_domain, u64 ipa)
+{
+	if (WARN_ON_ONCE(smmu_domain->stage != ARM_SMMU_DOMAIN_S2))
+		return 0;
+	return iommu_iova_to_phys(&smmu_domain->domain, ipa);
+}
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
@@ -1076,9 +1084,16 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
 void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master);
 int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt);
+struct iommu_domain *
+arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
+			      const struct iommu_user_data *user_data);
+int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
+			       struct iommu_user_data_array *array);
 #else
 #define arm_smmu_hw_info NULL
 #define arm_vsmmu_alloc NULL
+#define arm_vsmmu_alloc_domain_nested NULL
+#define arm_vsmmu_cache_invalidate NULL
 
 static inline int
 arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index fd9089bfea01..e5400453a82e 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -549,12 +549,26 @@ struct iommu_hw_info_vtd {
 	__aligned_u64 ecap_reg;
 };
 
+/**
+ * enum iommu_hw_info_arm_smmuv3_flags - Flags for ARM SMMUv3 hw_info
+ * @IOMMU_HW_INFO_ARM_SMMUV3_HAS_TEGRA241_CMDQV: Tegra241 implementation with
+ *                                               CMDQV support; @impl is valid
+ */
+enum iommu_hw_info_arm_smmuv3_flags {
+	IOMMU_HW_INFO_ARM_SMMUV3_HAS_TEGRA241_CMDQV = 1 << 0,
+};
+
 /**
  * struct iommu_hw_info_arm_smmuv3 - ARM SMMUv3 hardware information
  *                                   (IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
  *
- * @flags: Must be set to 0
- * @impl: Must be 0
+ * @flags: Combination of enum iommu_hw_info_arm_smmuv3_flags
+ * @impl: Implementation-defined bits when the following flags are set:
+ *        - IOMMU_HW_INFO_ARM_SMMUV3_HAS_TEGRA241_CMDQV
+ *          Bits[15:12] - Log2 of the total number of SID replacements
+ *          Bits[11:08] - Log2 of the total number of VINTFs per vIOMMU
+ *          Bits[07:04] - Log2 of the total number of VCMDQs per vIOMMU
+ *          Bits[03:00] - Version number for the CMDQ-V HW
  * @idr: Implemented features for ARM SMMU Non-secure programming interface
  * @iidr: Information about the implementation and implementer of ARM SMMU,
  *        and architecture version supported
@@ -952,10 +966,28 @@ struct iommu_fault_alloc {
  * enum iommu_viommu_type - Virtual IOMMU Type
  * @IOMMU_VIOMMU_TYPE_DEFAULT: Reserved for future use
  * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
+ * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension for SMMUv3
  */
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
 	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
+	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
+};
+
+/**
+ * struct iommu_viommu_tegra241_cmdqv - NVIDIA Tegra241 CMDQV Virtual Interface
+ *                                      (IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV)
+ * @out_vintf_page0_pgoff: Offset of the VINTF page0 for mmap syscall
+ * @out_vintf_page0_pgsz: Size of the VINTF page0 for mmap syscall
+ *
+ * Both @out_vintf_page0_pgoff and @out_vintf_page0_pgsz are given by the kernel
+ * for user space to mmap the VINTF page0 from the host physical address space
+ * to the guest physical address space so that a guest kernel can directly R/W
+ * access to the VINTF page0 in order to control its virtual command queues.
+ */
+struct iommu_viommu_tegra241_cmdqv {
+	__aligned_u64 out_vintf_page0_pgoff;
+	__aligned_u64 out_vintf_page0_pgsz;
 };
 
 /**
@@ -1152,9 +1184,23 @@ struct iommu_veventq_alloc {
 /**
  * enum iommu_vqueue_type - Virtual Queue Type
  * @IOMMU_VQUEUE_TYPE_DEFAULT: Reserved for future use
+ * @IOMMU_VQUEUE_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension for SMMUv3
  */
 enum iommu_vqueue_type {
 	IOMMU_VQUEUE_TYPE_DEFAULT = 0,
+	/*
+	 * TEGRA241_CMDQV requirements (otherwise it will fail)
+	 * - alloc starts from the lowest @index=0 in ascending order
+	 * - destroy starts from the last allocated @index in descending order
+	 * - @addr must be aligned to @length in bytes and be mmapped in IOAS
+	 * - @length must be a power of 2, with a minimum 32 bytes and a maximum
+	 *   2 ^ idr[1].CMDQS * 16 bytes (use GET_HW_INFO call to read idr[1]
+	 *   from struct iommu_hw_info_arm_smmuv3)
+	 * - suggest to back the queue memory with contiguous physical pages or
+	 *   a single huge page with alignment of the queue size, limit vSMMU's
+	 *   IDR1.CMDQS to the huge page size divided by 16 bytes
+	 */
+	IOMMU_VQUEUE_TYPE_TEGRA241_CMDQV = 1,
 };
 
 /**
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index f8bf89a80eb6..1be3879e7f10 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -226,7 +226,7 @@ static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg,
 	return 0;
 }
 
-static struct iommu_domain *
+struct iommu_domain *
 arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 			      const struct iommu_user_data *user_data)
 {
@@ -337,8 +337,8 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
 	return 0;
 }
 
-static int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
-				      struct iommu_user_data_array *array)
+int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
+			       struct iommu_user_data_array *array)
 {
 	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
 	struct arm_smmu_device *smmu = vsmmu->smmu;
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 869c90b660c1..6bbc85886f79 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -8,7 +8,9 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <linux/iopoll.h>
+#include <uapi/linux/iommufd.h>
 
 #include <acpi/acpixf.h>
 
@@ -26,8 +28,10 @@
 #define  CMDQV_EN			BIT(0)
 
 #define TEGRA241_CMDQV_PARAM		0x0004
+#define  CMDQV_NUM_SID_PER_VM_LOG2	GENMASK(15, 12)
 #define  CMDQV_NUM_VINTF_LOG2		GENMASK(11, 8)
 #define  CMDQV_NUM_VCMDQ_LOG2		GENMASK(7, 4)
+#define  CMDQV_VER			GENMASK(3, 0)
 
 #define TEGRA241_CMDQV_STATUS		0x0008
 #define  CMDQV_ENABLED			BIT(0)
@@ -53,6 +57,9 @@
 #define  VINTF_STATUS			GENMASK(3, 1)
 #define  VINTF_ENABLED			BIT(0)
 
+#define TEGRA241_VINTF_SID_MATCH(s)	(0x0040 + 0x4*(s))
+#define TEGRA241_VINTF_SID_REPLACE(s)	(0x0080 + 0x4*(s))
+
 #define TEGRA241_VINTF_LVCMDQ_ERR_MAP_64(m) \
 					(0x00C0 + 0x8*(m))
 #define  LVCMDQ_ERR_MAP_NUM_64		2
@@ -114,16 +121,20 @@ MODULE_PARM_DESC(bypass_vcmdq,
 
 /**
  * struct tegra241_vcmdq - Virtual Command Queue
+ * @core: Embedded iommufd_vqueue structure
  * @idx: Global index in the CMDQV
  * @lidx: Local index in the VINTF
  * @enabled: Enable status
  * @cmdqv: Parent CMDQV pointer
  * @vintf: Parent VINTF pointer
+ * @prev: Previous LVCMDQ to depend on
  * @cmdq: Command Queue struct
  * @page0: MMIO Page0 base address
  * @page1: MMIO Page1 base address
  */
 struct tegra241_vcmdq {
+	struct iommufd_vqueue core;
+
 	u16 idx;
 	u16 lidx;
 
@@ -131,22 +142,29 @@ struct tegra241_vcmdq {
 
 	struct tegra241_cmdqv *cmdqv;
 	struct tegra241_vintf *vintf;
+	struct tegra241_vcmdq *prev;
 	struct arm_smmu_cmdq cmdq;
 
 	void __iomem *page0;
 	void __iomem *page1;
 };
+#define core_to_vcmdq(v) container_of(v, struct tegra241_vcmdq, core)
 
 /**
  * struct tegra241_vintf - Virtual Interface
+ * @vsmmu: Embedded arm_vsmmu structure
  * @idx: Global index in the CMDQV
  * @enabled: Enable status
  * @hyp_own: Owned by hypervisor (in-kernel)
  * @cmdqv: Parent CMDQV pointer
  * @lvcmdqs: List of logical VCMDQ pointers
  * @base: MMIO base address
+ * @immap_id: Allocated immap_id ID for mmap() call
+ * @sids: Stream ID replacement resources
  */
 struct tegra241_vintf {
+	struct arm_vsmmu vsmmu;
+
 	u16 idx;
 
 	bool enabled;
@@ -156,6 +174,24 @@ struct tegra241_vintf {
 	struct tegra241_vcmdq **lvcmdqs;
 
 	void __iomem *base;
+	unsigned long immap_id;
+
+	struct ida sids;
+};
+#define viommu_to_vintf(v) container_of(v, struct tegra241_vintf, vsmmu.core)
+
+/**
+ * struct tegra241_vintf_sid - Virtual Interface Stream ID Replacement
+ * @core: Embedded iommufd_vdevice structure, holding virtual Stream ID
+ * @vintf: Parent VINTF pointer
+ * @sid: Physical Stream ID
+ * @idx: Replacement index in the VINTF
+ */
+struct tegra241_vintf_sid {
+	struct iommufd_vdevice core;
+	struct tegra241_vintf *vintf;
+	u32 sid;
+	u8 idx;
 };
 
 /**
@@ -163,10 +199,12 @@ struct tegra241_vintf {
  * @smmu: SMMUv3 device
  * @dev: CMDQV device
  * @base: MMIO base address
+ * @base_phys: MMIO physical base address, for mmap
  * @irq: IRQ number
  * @num_vintfs: Total number of VINTFs
  * @num_vcmdqs: Total number of VCMDQs
  * @num_lvcmdqs_per_vintf: Number of logical VCMDQs per VINTF
+ * @num_sids_per_vintf: Total number of SID replacements per VINTF
  * @vintf_ids: VINTF id allocator
  * @vintfs: List of VINTFs
  */
@@ -175,12 +213,14 @@ struct tegra241_cmdqv {
 	struct device *dev;
 
 	void __iomem *base;
+	phys_addr_t base_phys;
 	int irq;
 
 	/* CMDQV Hardware Params */
 	u16 num_vintfs;
 	u16 num_vcmdqs;
 	u16 num_lvcmdqs_per_vintf;
+	u16 num_sids_per_vintf;
 
 	struct ida vintf_ids;
 
@@ -351,6 +391,29 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
 
 /* HW Reset Functions */
 
+/*
+ * When a guest-owned VCMDQ is disabled, if the guest did not enqueue a CMD_SYNC
+ * following an ATC_INV command at the end of the guest queue while this ATC_INV
+ * is timed out, the TIMEOUT will not be reported until this VCMDQ gets assigned
+ * to the next VM, which will be a false alarm potentially causing some unwanted
+ * behavior in the new VM. Thus, a guest-owned VCMDQ must flush the TIMEOUT when
+ * it gets disabled. This can be done by just issuing a CMD_SYNC to SMMU CMDQ.
+ */
+static void tegra241_vcmdq_hw_flush_timeout(struct tegra241_vcmdq *vcmdq)
+{
+	struct arm_smmu_device *smmu = &vcmdq->cmdqv->smmu;
+	u64 cmd_sync[CMDQ_ENT_DWORDS] = {};
+
+	cmd_sync[0] = FIELD_PREP(CMDQ_0_OP, CMDQ_OP_CMD_SYNC) |
+		      FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
+
+	/*
+	 * It does not hurt to insert another CMD_SYNC, taking adavantage of the
+	 * arm_smmu_cmdq_issue_cmdlist() that waits for the CMD_SYNC completion.
+	 */
+	arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, cmd_sync, 1, true);
+}
+
 /* This function is for LVCMDQ, so @vcmdq must not be unmapped yet */
 static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 {
@@ -364,6 +427,8 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 			readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR)),
 			readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, CONS)));
 	}
+	tegra241_vcmdq_hw_flush_timeout(vcmdq);
+
 	writel_relaxed(0, REG_VCMDQ_PAGE0(vcmdq, PROD));
 	writel_relaxed(0, REG_VCMDQ_PAGE0(vcmdq, CONS));
 	writeq_relaxed(0, REG_VCMDQ_PAGE1(vcmdq, BASE));
@@ -380,6 +445,12 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 	dev_dbg(vcmdq->cmdqv->dev, "%sdeinited\n", h);
 }
 
+/* This function is for LVCMDQ, so @vcmdq must be mapped prior */
+static void _tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
+{
+	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
+}
+
 /* This function is for LVCMDQ, so @vcmdq must be mapped prior */
 static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 {
@@ -390,7 +461,7 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 	tegra241_vcmdq_hw_deinit(vcmdq);
 
 	/* Configure and enable VCMDQ */
-	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
+	_tegra241_vcmdq_hw_init(vcmdq);
 
 	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
 	if (ret) {
@@ -420,6 +491,7 @@ static void tegra241_vcmdq_unmap_lvcmdq(struct tegra241_vcmdq *vcmdq)
 static void tegra241_vintf_hw_deinit(struct tegra241_vintf *vintf)
 {
 	u16 lidx = vintf->cmdqv->num_lvcmdqs_per_vintf;
+	int sidx;
 
 	/* HW requires to unmap LVCMDQs in descending order */
 	while (lidx--) {
@@ -429,6 +501,10 @@ static void tegra241_vintf_hw_deinit(struct tegra241_vintf *vintf)
 		}
 	}
 	vintf_write_config(vintf, 0);
+	for (sidx = 0; sidx < vintf->cmdqv->num_sids_per_vintf; sidx++) {
+		writel(0, REG_VINTF(vintf, SID_MATCH(sidx)));
+		writel(0, REG_VINTF(vintf, SID_REPLACE(sidx)));
+	}
 }
 
 /* Map a global VCMDQ to the pre-assigned LVCMDQ */
@@ -457,7 +533,8 @@ static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
 	 * whether enabling it here or not, as !HYP_OWN cmdq HWs only support a
 	 * restricted set of supported commands.
 	 */
-	regval = FIELD_PREP(VINTF_HYP_OWN, hyp_own);
+	regval = FIELD_PREP(VINTF_HYP_OWN, hyp_own) |
+		 FIELD_PREP(VINTF_VMID, vintf->vsmmu.vmid);
 	writel(regval, REG_VINTF(vintf, CONFIG));
 
 	ret = vintf_write_config(vintf, regval | VINTF_EN);
@@ -584,7 +661,9 @@ static void tegra241_vintf_free_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
 
 	dev_dbg(vintf->cmdqv->dev,
 		"%sdeallocated\n", lvcmdq_error_header(vcmdq, header, 64));
-	kfree(vcmdq);
+	/* Guest-owned VCMDQ is free-ed with vcmdq by iommufd core */
+	if (vcmdq->vintf->hyp_own)
+		kfree(vcmdq);
 }
 
 static struct tegra241_vcmdq *
@@ -671,7 +750,11 @@ static void tegra241_cmdqv_remove_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
 
 	dev_dbg(cmdqv->dev, "VINTF%u: deallocated\n", vintf->idx);
 	tegra241_cmdqv_deinit_vintf(cmdqv, idx);
-	kfree(vintf);
+	if (!vintf->hyp_own)
+		ida_destroy(&vintf->sids);
+	/* Guest-owned VINTF is free-ed with viommu by iommufd core */
+	if (vintf->hyp_own)
+		kfree(vintf);
 }
 
 static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
@@ -699,10 +782,32 @@ static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
 	put_device(cmdqv->dev); /* smmu->impl_dev */
 }
 
+static struct arm_vsmmu *
+tegra241_cmdqv_alloc_vintf_user(struct arm_smmu_device *smmu,
+				struct arm_smmu_domain *smmu_domain,
+				struct iommufd_ctx *ictx, unsigned int type,
+				const struct iommu_user_data *user_data);
+
+static u32 tegra241_cmdqv_hw_info(struct arm_smmu_device *smmu, u32 *impl)
+{
+	struct tegra241_cmdqv *cmdqv =
+		container_of(smmu, struct tegra241_cmdqv, smmu);
+	u32 regval = readl_relaxed(REG_CMDQV(cmdqv, PARAM));
+
+	*impl = FIELD_GET(CMDQV_VER, regval);
+	*impl |= FIELD_PREP(CMDQV_NUM_VCMDQ_LOG2,
+			    ilog2(cmdqv->num_lvcmdqs_per_vintf));
+	*impl |= FIELD_PREP(CMDQV_NUM_SID_PER_VM_LOG2,
+			    ilog2(cmdqv->num_sids_per_vintf));
+	return IOMMU_HW_INFO_ARM_SMMUV3_HAS_TEGRA241_CMDQV;
+}
+
 static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
 	.device_reset = tegra241_cmdqv_hw_reset,
 	.device_remove = tegra241_cmdqv_remove,
+	.vsmmu_alloc = tegra241_cmdqv_alloc_vintf_user,
+	.hw_info = tegra241_cmdqv_hw_info,
 };
 
 /* Probe Functions */
@@ -844,6 +949,7 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->irq = irq;
 	cmdqv->base = base;
 	cmdqv->dev = smmu->impl_dev;
+	cmdqv->base_phys = res->start;
 
 	if (cmdqv->irq > 0) {
 		ret = request_threaded_irq(irq, NULL, tegra241_cmdqv_isr,
@@ -860,6 +966,8 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->num_vintfs = 1 << FIELD_GET(CMDQV_NUM_VINTF_LOG2, regval);
 	cmdqv->num_vcmdqs = 1 << FIELD_GET(CMDQV_NUM_VCMDQ_LOG2, regval);
 	cmdqv->num_lvcmdqs_per_vintf = cmdqv->num_vcmdqs / cmdqv->num_vintfs;
+	cmdqv->num_sids_per_vintf =
+		1 << FIELD_GET(CMDQV_NUM_SID_PER_VM_LOG2, regval);
 
 	cmdqv->vintfs =
 		kcalloc(cmdqv->num_vintfs, sizeof(*cmdqv->vintfs), GFP_KERNEL);
@@ -913,3 +1021,291 @@ struct arm_smmu_device *tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
 	put_device(smmu->impl_dev);
 	return ERR_PTR(-ENODEV);
 }
+
+/* User space VINTF and VCMDQ Functions */
+
+static int tegra241_vcmdq_hw_init_user(struct tegra241_vcmdq *vcmdq)
+{
+	char header[64];
+
+	/* Configure the vcmdq only; User space does the enabling */
+	_tegra241_vcmdq_hw_init(vcmdq);
+
+	dev_dbg(vcmdq->cmdqv->dev, "%sinited at host PA 0x%llx size 0x%lx\n",
+		lvcmdq_error_header(vcmdq, header, 64),
+		vcmdq->cmdq.q.q_base & VCMDQ_ADDR,
+		1UL << (vcmdq->cmdq.q.q_base & VCMDQ_LOG2SIZE));
+	return 0;
+}
+
+static struct iommufd_vqueue *
+tegra241_vintf_alloc_lvcmdq_user(struct iommufd_viommu *viommu,
+				 unsigned int type, u32 index, dma_addr_t addr,
+				 size_t length)
+{
+	struct tegra241_vintf *vintf = viommu_to_vintf(viommu);
+	struct tegra241_cmdqv *cmdqv = vintf->cmdqv;
+	struct arm_smmu_device *smmu = &cmdqv->smmu;
+	struct tegra241_vcmdq *vcmdq, *prev = NULL;
+	u32 log2size, max_n_shift;
+	phys_addr_t q_base;
+	char header[64];
+	int ret;
+
+	if (type != IOMMU_VQUEUE_TYPE_TEGRA241_CMDQV)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (index >= cmdqv->num_lvcmdqs_per_vintf)
+		return ERR_PTR(-EINVAL);
+	if (vintf->lvcmdqs[index])
+		return ERR_PTR(-EEXIST);
+	/*
+	 * HW requires to map LVCMDQs in ascending order, so reject if the
+	 * previous lvcmdqs is not allocated yet.
+	 */
+	if (index) {
+		prev = vintf->lvcmdqs[index - 1];
+		if (!prev)
+			return ERR_PTR(-EIO);
+	}
+	/*
+	 * @length must be a power of 2, in range of
+	 *   [ 32, 2 ^ (idr[1].CMDQS + CMDQ_ENT_SZ_SHIFT) ]
+	 */
+	max_n_shift = FIELD_GET(IDR1_CMDQS,
+				readl_relaxed(smmu->base + ARM_SMMU_IDR1));
+	if (!is_power_of_2(length) || length < 32 ||
+	    length > (1 << (max_n_shift + CMDQ_ENT_SZ_SHIFT)))
+		return ERR_PTR(-EINVAL);
+	log2size = ilog2(length) - CMDQ_ENT_SZ_SHIFT;
+
+	/* @addr must be aligned to @length and be mapped in s2_parent domain */
+	if (addr & ~VCMDQ_ADDR || addr & (length - 1))
+		return ERR_PTR(-EINVAL);
+	q_base = arm_smmu_domain_ipa_to_pa(vintf->vsmmu.s2_parent, addr);
+	if (!q_base)
+		return ERR_PTR(-ENXIO);
+
+	vcmdq = iommufd_vqueue_alloc(viommu, struct tegra241_vcmdq, core);
+	if (!vcmdq)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * HW requires to unmap LVCMDQs in descending order, so destroy() must
+	 * follow this rule. Set a dependency on its previous LVCMDQ so iommufd
+	 * core will help enforce it.
+	 */
+	if (prev) {
+		ret = iommufd_vqueue_depend(vcmdq, prev, core);
+		if (ret)
+			goto free_vcmdq;
+	}
+	vcmdq->prev = prev;
+
+	ret = tegra241_vintf_init_lvcmdq(vintf, index, vcmdq);
+	if (ret)
+		goto undepend_vcmdq;
+
+	dev_dbg(cmdqv->dev, "%sallocated\n",
+		lvcmdq_error_header(vcmdq, header, 64));
+
+	tegra241_vcmdq_map_lvcmdq(vcmdq);
+
+	vcmdq->cmdq.q.q_base = q_base & VCMDQ_ADDR;
+	vcmdq->cmdq.q.q_base |= log2size;
+
+	ret = tegra241_vcmdq_hw_init_user(vcmdq);
+	if (ret)
+		goto unmap_lvcmdq;
+	vintf->lvcmdqs[index] = vcmdq;
+
+	return &vcmdq->core;
+
+unmap_lvcmdq:
+	tegra241_vcmdq_unmap_lvcmdq(vcmdq);
+undepend_vcmdq:
+	if (vcmdq->prev)
+		iommufd_vqueue_undepend(vcmdq, vcmdq->prev, core);
+free_vcmdq:
+	iommufd_struct_destroy(vcmdq, core);
+	return ERR_PTR(ret);
+}
+
+static void tegra241_vintf_destroy_lvcmdq_user(struct iommufd_vqueue *core)
+{
+	struct tegra241_vcmdq *vcmdq = core_to_vcmdq(core);
+
+	tegra241_vcmdq_hw_deinit(vcmdq);
+	tegra241_vcmdq_unmap_lvcmdq(vcmdq);
+	tegra241_vintf_free_lvcmdq(vcmdq->vintf, vcmdq->lidx);
+	if (vcmdq->prev)
+		iommufd_vqueue_undepend(vcmdq, vcmdq->prev, core);
+
+	/* IOMMUFD core frees the memory of vcmdq and vcmdq */
+}
+
+static void tegra241_cmdqv_destroy_vintf_user(struct iommufd_viommu *viommu)
+{
+	struct tegra241_vintf *vintf = viommu_to_vintf(viommu);
+
+	if (vintf->immap_id)
+		iommufd_viommu_destroy_mmap(vintf, vsmmu.core, vintf->immap_id);
+	tegra241_cmdqv_remove_vintf(vintf->cmdqv, vintf->idx);
+
+	/* IOMMUFD core frees the memory of vintf and viommu */
+}
+
+static struct iommufd_vdevice *
+tegra241_vintf_alloc_vdevice(struct iommufd_viommu *viommu, struct device *dev,
+			     u64 dev_id)
+{
+	struct tegra241_vintf *vintf = viommu_to_vintf(viommu);
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_stream *stream = &master->streams[0];
+	struct tegra241_vintf_sid *vsid;
+	int sidx;
+
+	if (dev_id > UINT_MAX)
+		return ERR_PTR(-EINVAL);
+
+	vsid = iommufd_vdevice_alloc(viommu, struct tegra241_vintf_sid, core);
+	if (!vsid)
+		return ERR_PTR(-ENOMEM);
+
+	WARN_ON_ONCE(master->num_streams != 1);
+
+	/* Find an empty pair of SID_REPLACE and SID_MATCH */
+	sidx = ida_alloc_max(&vintf->sids, vintf->cmdqv->num_sids_per_vintf - 1,
+			     GFP_KERNEL);
+	if (sidx < 0) {
+		iommufd_struct_destroy(vsid, core);
+		return ERR_PTR(sidx);
+	}
+
+	writel(stream->id, REG_VINTF(vintf, SID_REPLACE(sidx)));
+	writel(dev_id << 1 | 0x1, REG_VINTF(vintf, SID_MATCH(sidx)));
+	dev_dbg(vintf->cmdqv->dev,
+		"VINTF%u: allocated SID_REPLACE%d for pSID=%x, vSID=%x\n",
+		vintf->idx, sidx, stream->id, (u32)dev_id);
+
+	vsid->idx = sidx;
+	vsid->vintf = vintf;
+	vsid->sid = stream->id;
+
+	return &vsid->core;
+}
+
+static void tegra241_vintf_destroy_vdevice(struct iommufd_vdevice *vdev)
+{
+	struct tegra241_vintf_sid *vsid =
+		container_of(vdev, struct tegra241_vintf_sid, core);
+	struct tegra241_vintf *vintf = vsid->vintf;
+
+	writel(0, REG_VINTF(vintf, SID_MATCH(vsid->idx)));
+	writel(0, REG_VINTF(vintf, SID_REPLACE(vsid->idx)));
+	ida_free(&vintf->sids, vsid->idx);
+	dev_dbg(vintf->cmdqv->dev,
+		"VINTF%u: deallocated SID_REPLACE%d for pSID=%x\n", vintf->idx,
+		vsid->idx, vsid->sid);
+
+	/* IOMMUFD core frees the memory of vsid and vdev */
+}
+
+static struct iommufd_viommu_ops tegra241_cmdqv_viommu_ops = {
+	.destroy = tegra241_cmdqv_destroy_vintf_user,
+	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
+	.cache_invalidate = arm_vsmmu_cache_invalidate,
+	.vdevice_alloc = tegra241_vintf_alloc_vdevice,
+	.vdevice_destroy = tegra241_vintf_destroy_vdevice,
+	.vqueue_alloc = tegra241_vintf_alloc_lvcmdq_user,
+	.vqueue_destroy = tegra241_vintf_destroy_lvcmdq_user,
+};
+
+static struct arm_vsmmu *
+tegra241_cmdqv_alloc_vintf_user(struct arm_smmu_device *smmu,
+				struct arm_smmu_domain *s2_parent,
+				struct iommufd_ctx *ictx, unsigned int type,
+				const struct iommu_user_data *user_data)
+{
+	struct tegra241_cmdqv *cmdqv =
+		container_of(smmu, struct tegra241_cmdqv, smmu);
+	struct iommu_viommu_tegra241_cmdqv data;
+	struct tegra241_vintf *vintf;
+	phys_addr_t page0_base;
+	int ret;
+
+	if (type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (!user_data)
+		return ERR_PTR(-EINVAL);
+
+	ret = iommu_copy_struct_from_user(&data, user_data,
+					  IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
+					  out_vintf_page0_pgsz);
+	if (ret)
+		return ERR_PTR(ret);
+
+	vintf = iommufd_viommu_alloc(ictx, struct tegra241_vintf, vsmmu.core,
+				     &tegra241_cmdqv_viommu_ops);
+	if (!vintf)
+		return ERR_PTR(-ENOMEM);
+
+	ret = tegra241_cmdqv_init_vintf(cmdqv, cmdqv->num_vintfs - 1, vintf);
+	if (ret < 0) {
+		dev_err(cmdqv->dev, "no more available vintf\n");
+		goto free_vintf;
+	}
+
+	vintf->vsmmu.smmu = smmu;
+	vintf->vsmmu.s2_parent = s2_parent;
+	/* FIXME Move VMID allocation from the S2 domain allocation to here */
+	vintf->vsmmu.vmid = s2_parent->s2_cfg.vmid;
+
+	/*
+	 * Initialize the user-owned VINTF without a LVCMDQ, because it has to
+	 * wait for the allocation of a user-owned LVCMDQ, for security reason.
+	 * It is different than the kernel-owned VINTF0, which had pre-assigned
+	 * and pre-allocated global VCMDQs that would be mapped to the LVCMDQs
+	 * by the tegra241_vintf_hw_init() call.
+	 */
+	ret = tegra241_vintf_hw_init(vintf, false);
+	if (ret)
+		goto deinit_vintf;
+
+	vintf->lvcmdqs = kcalloc(cmdqv->num_lvcmdqs_per_vintf,
+				 sizeof(*vintf->lvcmdqs), GFP_KERNEL);
+	if (!vintf->lvcmdqs) {
+		ret = -ENOMEM;
+		goto hw_deinit_vintf;
+	}
+
+	page0_base = cmdqv->base_phys + TEGRA241_VINTFi_PAGE0(vintf->idx);
+	ret = iommufd_viommu_alloc_mmap(vintf, vsmmu.core, page0_base, SZ_64K,
+					&vintf->immap_id);
+	if (ret)
+		goto hw_deinit_vintf;
+
+	data.out_vintf_page0_pgsz = SZ_64K;
+	data.out_vintf_page0_pgoff = vintf->immap_id;
+	ret = iommu_copy_struct_to_user(user_data, &data,
+					IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
+					out_vintf_page0_pgsz);
+	if (ret)
+		goto free_mmap;
+
+	ida_init(&vintf->sids);
+
+	dev_dbg(cmdqv->dev, "VINTF%u: allocated with vmid (%d)\n", vintf->idx,
+		vintf->vsmmu.vmid);
+
+	return &vintf->vsmmu;
+
+free_mmap:
+	iommufd_viommu_destroy_mmap(vintf, vsmmu.core, vintf->immap_id);
+hw_deinit_vintf:
+	tegra241_vintf_hw_deinit(vintf);
+deinit_vintf:
+	tegra241_cmdqv_deinit_vintf(cmdqv, vintf->idx);
+free_vintf:
+	iommufd_struct_destroy(vintf, vsmmu.core);
+	return ERR_PTR(ret);
+}
-- 
2.43.0


