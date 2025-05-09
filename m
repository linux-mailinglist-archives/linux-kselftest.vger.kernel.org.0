Return-Path: <linux-kselftest+bounces-32722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B9BAB088B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C003D506489
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E6E2522AA;
	Fri,  9 May 2025 03:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C7drwkE+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581AB2405E7;
	Fri,  9 May 2025 03:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759852; cv=fail; b=c/Nqfw7B49QVHtvgvnApEHXoapC28RNU2QGrQhA05iv1qU4MsZ7zFNnETlK8VM9gAnYxsBwMVq7H2WxpT2o92oTTC47i6vRSIMAxSRmKkswuL9hsHC84YVZ2uLcdtoYZItnYjDLuJm+hg2XajjJeSbMrwTGQkCBkHfrhc/uE+Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759852; c=relaxed/simple;
	bh=Q3tisgA+bQi7gk/jBlLWviUzS9/xYmJyDRFBlrfidto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7tNN8IBYi9qnYqIEKijQqDuZ9fxfGQzSRHmpzO25uGm1NjnHPDlTTGF4M/jKYe2bFSia3iZ1qIdx3MjmJ5Zh/CPcPvIbfTclG4HNVzeVng8Bjth+QUh6lGEx3TP2SgwJPLoBFseSopjNpTggq8/tcwHmc8uc98eY7XtL6GsGsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C7drwkE+; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgRC5ue1swk62OqTgvNkbqoRqiq33sBydKXWHbwYk1lFOFlcr85Mr1WYt8l50HSDjG9vRWoZGKfNFS/1so8fCMtcK4YIePkynCwgwX0+F0j2MShipNCt+9bnX+PPBPAY70Ez4HK4oWUDVnFs6dxz4uumaPv8+xILc0whQtJm8Hoql/9bVFcyt4Ixw34HcHZYGhBu7bpZCCwMfyyFT6psjYcRh2D80N4dPnQbk/Jp2b+/m9WVaDNHNY9mS2aw6MDCgoHrf4OPHOat5drVlL6U2Ovc0oKzSgIbJGRTovFU8ehLzpOjfcR8PbufuzxgYmTYTD9X1yerE5M/paCUH1vpEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfIZw/tYLxAyN8jEl3YNlSzQmUhuvkCr0HIb1NrwwOk=;
 b=zAxyoTllYZEGlrkl6wmw1Xk22zifT5FTULjU6kohWAtg0APGrQUDsXQ1NrWqdB1FLkVgU3jNHLBrhZ6MfDxQnV/elOtaUZzyfLeSGPF99F5woO/ztyqiK/ZDJCR4p04NycF7I7VfWRyuIGyPs33l4Rn0Mp7IuKOpmaGGdbBK+Qih7YjYUTZo0weCPxEd0m/b48l7UHGDXvZqdKUENbTkcOLIEQB5p/wsFDon/iilfdprdtBCBrdUsl6TmnbZysbA82C1amHjfpODxGG9cLMnWtnOGFTlzY9nusWxTO2eGRtza4yTYxhlrPbaiTU8E+jt6d5pTRHgvFF49ipDOPjMhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfIZw/tYLxAyN8jEl3YNlSzQmUhuvkCr0HIb1NrwwOk=;
 b=C7drwkE+S/8uxXzAfUlKoy5h2jtIXlznN55r5FqFVsD4jhWH3odxwwNxgkpLBnZVYAoOQ7R+a32U/LIeANq1IwyI6MqzmkIANEroq/w23HE0u8BVhx0+UmcpvA526DZBmU+jB6En/bbFHNZm/C8/2x7hvgt44v9cZT0fhwK6D0VBOz88HUEGc5Db03p69lMuGeo/rTZ0BkMTJxHMZ6lQwZabp+zD1jQFYFe+gJuOnovlINxWufFqtklGhMfJBl8R0M/RNUH1fRDjwKSotydgds6Q0PSrtHBaKZGBGlu0upteHig678PErLJSBb64z5OQ1XDMYp1YwfFQ/7pJ0QTJaA==
Received: from SN7P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::28)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Fri, 9 May
 2025 03:03:59 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:123:cafe::bc) by SN7P220CA0023.outlook.office365.com
 (2603:10b6:806:123::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Fri,
 9 May 2025 03:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:59 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:50 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:49 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:47 -0700
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
Subject: [PATCH v4 22/23] iommu/tegra241-cmdqv: Add user-space use support
Date: Thu, 8 May 2025 20:02:43 -0700
Message-ID: <a06e91b8bb4a2966dbe7fc3349502d38c3ba38cb.1746757630.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746757630.git.nicolinc@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: d8cd4b0c-6904-4ea2-1c71-08dd8ea624ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HkaodfbhwLaohOet7OUsS0+WYKH4ynivPVxsME60r+MVl7bxV1Sodo1JhUbT?=
 =?us-ascii?Q?IFReqwss3VCs+NIGcZ1uc9SJcE7a5mkWHb0c3ioEDQ7RMbxkp03gNMwGvZXv?=
 =?us-ascii?Q?2ZvN64TE8Gz2wZmWpy1INJotO4tRPSeNNkCUQ3wnS7NnEyPZeRrJxiaR7HRJ?=
 =?us-ascii?Q?A3aK8TR9qCG3ZDt9y3mjYfgbLK5oGdAdlQ/wdlXG3cL7pbQJgZDm8sbjl2N6?=
 =?us-ascii?Q?ybtWU2GRX4XZUcVSEBx4v9e7gv7oXGjB6Bcxegq1ifyHSaOgm6SgmwajGsGu?=
 =?us-ascii?Q?7IvNR/Mmsc2Zxy6iIVmjrA3rOuDKheVmM4y5Wu9q8jjucPz6HGdXZuubZnn7?=
 =?us-ascii?Q?MzQ3K9c5Mxpog2pYKxlJqJd5q/vHNZwORnN1zZ4XnBEROdIwAdds2p7U6loN?=
 =?us-ascii?Q?p9l5JqTUrbYwfDID+7x8lRobycOK4JpJHVRAQfSK+SnqDyFM5s6cQEdbZn+d?=
 =?us-ascii?Q?PI07lmWmUa+nwy4+N/oFm3ETcVjGyzEBoPSahEuNoT+WtERcwkBFomqmcWT6?=
 =?us-ascii?Q?iqs8QhbeE937VJ2Ej40C/5zKuDLr49KOHAMQSm0Y8S/kTsKNK0MQYnyAwB9z?=
 =?us-ascii?Q?HoGFxN/gxsig6blptTdZ3Z9lAldG6EQFC/JvsYscP3ygTPEcpgFfg8jtnlT3?=
 =?us-ascii?Q?0M5CU4U18WqJ2fb858LDQS97rG/KWHwC+IZDB7jwc6pnjfNRzt9VFFlVY1Kw?=
 =?us-ascii?Q?eKmfUXMsrz+mCQbobOsgLshVDMh07EDhAy9Q0WTe+p6SVt5XQ5rfIDUYa2dg?=
 =?us-ascii?Q?rTYl+74zF0aSKWWUGo43B+Tctlb8sfAtVO5zmolU6l24YJLASRfvfGwkHLZz?=
 =?us-ascii?Q?Iob2/Ur6v6GpoubgPZmWzzhxQwvXM30x97gaHQiaiRApfinh8x1g1HTblwka?=
 =?us-ascii?Q?1emAbIHurJdwRpvbar7SK7BNKtrCPD8wNi9uoBv4Xc9/JSM0Ue5g9q7PrHr3?=
 =?us-ascii?Q?TYbiR8nLGZzjKXd1FkL47K8RbweRAcDclt/kTP5xcNzLNJlek26EUwhnxVAy?=
 =?us-ascii?Q?QIrnYsn6n6cbOTIn6S6jzFqN7NYy4R9oPfljAcwPTeof+e3Nzyg/C+H7Bsai?=
 =?us-ascii?Q?fn5ifNqPy4JkhE2zEQM4vD1PeN9FXDdAdoCs9I1aTxqqnCKn1p0TrwhsD6qV?=
 =?us-ascii?Q?lNauehfYSB7mXInt2NuxwsdTHXfsAAwe73iT935c+8xGN63akKsb/lccBxEw?=
 =?us-ascii?Q?rexsgFTzJfiItflV0+GLXJVPIW/y/hvyRJt6Q3ieTcHDYwK20mea/co0/rS9?=
 =?us-ascii?Q?77hEgyvJhk415FIKH7znbXzLCJ+a2Pb+utG066Naua4VWI24Q2p5WNOtbveM?=
 =?us-ascii?Q?TYUcFEVO/2K8+VfmNTZPqXsL8u4xTq2edQ2SS3OP7V7f9sQu64H3XnAOOQ3l?=
 =?us-ascii?Q?s5x0G+UkV3cbAUwW/OVfRRUsNRP6HR6K4naBDA4Lr8SEDkZXlAgeX3kMILML?=
 =?us-ascii?Q?xiV5UOIek3HKvWKD8QgX3cLBDAInqBlL3XtOWpZ84FCpvxIyc2T6V76nhuK9?=
 =?us-ascii?Q?WD0RLYb2FYyNpIAw2a4/KKQKizOHIZsqRpH1?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:59.0358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cd4b0c-6904-4ea2-1c71-08dd8ea624ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5

The CMDQV HW supports a user-space use for virtualization cases. It allows
the VM to issue guest-level TLBI or ATC_INV commands directly to the queue
and executes them without a VMEXIT, as HW will replace the VMID field in a
TLBI command and the SID field in an ATC_INV command with the preset VMID
and SID.

This is built upon the vIOMMU infrastructure by allowing VMM to allocate a
VINTF (as a vIOMMU object) and assign VCMDQs (HW QUEUE objs) to the VINTF.

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
 include/uapi/linux/iommufd.h                  |  51 ++-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |   6 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 413 +++++++++++++++++-
 4 files changed, 476 insertions(+), 9 deletions(-)

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
index 28ab42a85268..a8a97f43ecc4 100644
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
+ * @out_vintf_mmap_offset: mmap offset argument for VINTF's page0
+ * @out_vintf_mmap_length: mmap length argument for VINTF's page0
+ *
+ * Both @out_vintf_mmap_offset and @out_vintf_mmap_length are reported by kernel
+ * for user space to mmap the VINTF page0 from the host physical address space
+ * to the guest physical address space so that a guest kernel can directly R/W
+ * access to the VINTF page0 in order to control its virtual command queues.
+ */
+struct iommu_viommu_tegra241_cmdqv {
+	__aligned_u64 out_vintf_mmap_offset;
+	__aligned_u64 out_vintf_mmap_length;
 };
 
 /**
@@ -1152,9 +1184,24 @@ struct iommu_veventq_alloc {
 /**
  * enum iommu_hw_queue_type - HW Queue Type
  * @IOMMU_HW_QUEUE_TYPE_DEFAULT: Reserved for future use
+ * @IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension for
+ *                                      ARM SMMUv3
  */
 enum iommu_hw_queue_type {
 	IOMMU_HW_QUEUE_TYPE_DEFAULT = 0,
+	/*
+	 * TEGRA241_CMDQV requirements (otherwise, allocation will fail)
+	 * - alloc starts from the lowest @index=0 in ascending order
+	 * - destroy starts from the last allocated @index in descending order
+	 * - @base_addr must be aligned to @length in bytes and mapped in IOAS
+	 * - @length must be a power of 2, with a minimum 32 bytes and a maximum
+	 *   2 ^ idr[1].CMDQS * 16 bytes (use GET_HW_INFO call to read idr[1]
+	 *   from struct iommu_hw_info_arm_smmuv3)
+	 * - suggest to back the queue memory with contiguous physical pages or
+	 *   a single huge page with alignment of the queue size, limit vSMMU's
+	 *   IDR1.CMDQS to the huge page size divided by 16 bytes
+	 */
+	IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV = 1,
 };
 
 /**
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 8ea9a022e444..e88adf00ec40 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -227,7 +227,7 @@ static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg,
 	return 0;
 }
 
-static struct iommu_domain *
+struct iommu_domain *
 arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 			      const struct iommu_user_data *user_data)
 {
@@ -338,8 +338,8 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
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
index 869c90b660c1..4f3ecc265d6f 100644
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
+ * @core: Embedded iommufd_hw_queue structure
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
+	struct iommufd_hw_queue core;
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
+#define hw_queue_to_vcmdq(v) container_of(v, struct tegra241_vcmdq, core)
 
 /**
  * struct tegra241_vintf - Virtual Interface
+ * @vsmmu: Embedded arm_vsmmu structure
  * @idx: Global index in the CMDQV
  * @enabled: Enable status
  * @hyp_own: Owned by hypervisor (in-kernel)
  * @cmdqv: Parent CMDQV pointer
  * @lvcmdqs: List of logical VCMDQ pointers
  * @base: MMIO base address
+ * @mmap_offset: Offset argument for mmap() syscall
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
+	unsigned long mmap_offset;
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
+	 * It does not hurt to insert another CMD_SYNC, taking advantage of the
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
+	/* Guest-owned VCMDQ is free-ed with hw_queue by iommufd core */
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
@@ -699,10 +782,34 @@ static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
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
+	/* One VINTF per VM is enough */
+	*impl |= FIELD_PREP(CMDQV_NUM_VINTF_LOG2, ilog2(1));
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
@@ -844,6 +951,7 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->irq = irq;
 	cmdqv->base = base;
 	cmdqv->dev = smmu->impl_dev;
+	cmdqv->base_phys = res->start;
 
 	if (cmdqv->irq > 0) {
 		ret = request_threaded_irq(irq, NULL, tegra241_cmdqv_isr,
@@ -860,6 +968,8 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->num_vintfs = 1 << FIELD_GET(CMDQV_NUM_VINTF_LOG2, regval);
 	cmdqv->num_vcmdqs = 1 << FIELD_GET(CMDQV_NUM_VCMDQ_LOG2, regval);
 	cmdqv->num_lvcmdqs_per_vintf = cmdqv->num_vcmdqs / cmdqv->num_vintfs;
+	cmdqv->num_sids_per_vintf =
+		1 << FIELD_GET(CMDQV_NUM_SID_PER_VM_LOG2, regval);
 
 	cmdqv->vintfs =
 		kcalloc(cmdqv->num_vintfs, sizeof(*cmdqv->vintfs), GFP_KERNEL);
@@ -913,3 +1023,298 @@ struct arm_smmu_device *tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
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
+static struct iommufd_hw_queue *
+tegra241_vintf_alloc_lvcmdq_user(struct iommufd_viommu *viommu,
+				 unsigned int type, u32 lidx, u64 base_addr,
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
+	if (type != IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (lidx >= cmdqv->num_lvcmdqs_per_vintf)
+		return ERR_PTR(-EINVAL);
+	if (vintf->lvcmdqs[lidx])
+		return ERR_PTR(-EEXIST);
+
+	/*
+	 * HW requires to map LVCMDQs in ascending order, so reject if the
+	 * previous lvcmdqs is not allocated yet.
+	 */
+	if (lidx) {
+		prev = vintf->lvcmdqs[lidx - 1];
+		if (!prev)
+			return ERR_PTR(-EIO);
+	}
+
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
+	/* @base_addr must be aligned to @length */
+	if (base_addr & ~VCMDQ_ADDR || base_addr & (length - 1))
+		return ERR_PTR(-EINVAL);
+
+	/* @base_addr must be mapped in the s2_parent domain */
+	q_base = arm_smmu_domain_ipa_to_pa(vintf->vsmmu.s2_parent, base_addr);
+	if (!q_base)
+		return ERR_PTR(-ENXIO);
+
+	vcmdq = iommufd_hw_queue_alloc(viommu, struct tegra241_vcmdq, core);
+	if (!vcmdq)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * HW requires to unmap LVCMDQs in descending order, so destroy() must
+	 * follow this rule. Set a dependency on its previous LVCMDQ so iommufd
+	 * core will help enforce it.
+	 */
+	if (prev) {
+		ret = iommufd_hw_queue_depend(vcmdq, prev, core);
+		if (ret)
+			goto free_vcmdq;
+	}
+	vcmdq->prev = prev;
+
+	ret = tegra241_vintf_init_lvcmdq(vintf, lidx, vcmdq);
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
+	vintf->lvcmdqs[lidx] = vcmdq;
+
+	return &vcmdq->core;
+
+unmap_lvcmdq:
+	tegra241_vcmdq_unmap_lvcmdq(vcmdq);
+	tegra241_vintf_deinit_lvcmdq(vintf, lidx);
+undepend_vcmdq:
+	if (vcmdq->prev)
+		iommufd_hw_queue_undepend(vcmdq, vcmdq->prev, core);
+free_vcmdq:
+	iommufd_struct_destroy(vcmdq, core);
+	return ERR_PTR(ret);
+}
+
+static void
+tegra241_vintf_destroy_lvcmdq_user(struct iommufd_hw_queue *hw_queue)
+{
+	struct tegra241_vcmdq *vcmdq = hw_queue_to_vcmdq(hw_queue);
+
+	tegra241_vcmdq_hw_deinit(vcmdq);
+	tegra241_vcmdq_unmap_lvcmdq(vcmdq);
+	tegra241_vintf_free_lvcmdq(vcmdq->vintf, vcmdq->lidx);
+	if (vcmdq->prev)
+		iommufd_hw_queue_undepend(vcmdq, vcmdq->prev, core);
+
+	/* IOMMUFD core frees the memory of vcmdq and hw_queue */
+}
+
+static void tegra241_cmdqv_destroy_vintf_user(struct iommufd_viommu *viommu)
+{
+	struct tegra241_vintf *vintf = viommu_to_vintf(viommu);
+
+	if (vintf->mmap_offset)
+		iommufd_viommu_destroy_mmap(vintf, vsmmu.core,
+					    vintf->mmap_offset);
+	tegra241_cmdqv_remove_vintf(vintf->cmdqv, vintf->idx);
+
+	/* IOMMUFD core frees the memory of vintf and viommu */
+}
+
+static struct iommufd_vdevice *
+tegra241_vintf_alloc_vdevice(struct iommufd_viommu *viommu, struct device *dev,
+			     u64 virt_sid)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct tegra241_vintf *vintf = viommu_to_vintf(viommu);
+	struct arm_smmu_stream *stream = &master->streams[0];
+	struct tegra241_vintf_sid *vsid;
+	int sidx;
+
+	if (virt_sid > UINT_MAX)
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
+	writel(virt_sid << 1 | 0x1, REG_VINTF(vintf, SID_MATCH(sidx)));
+	dev_dbg(vintf->cmdqv->dev,
+		"VINTF%u: allocated SID_REPLACE%d for pSID=%x, vSID=%x\n",
+		vintf->idx, sidx, stream->id, (u32)virt_sid);
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
+	.hw_queue_alloc = tegra241_vintf_alloc_lvcmdq_user,
+	.hw_queue_destroy = tegra241_vintf_destroy_lvcmdq_user,
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
+					  out_vintf_mmap_length);
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
+					&vintf->mmap_offset);
+	if (ret)
+		goto hw_deinit_vintf;
+
+	data.out_vintf_mmap_length = SZ_64K;
+	data.out_vintf_mmap_offset = vintf->mmap_offset;
+	ret = iommu_copy_struct_to_user(user_data, &data,
+					IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
+					out_vintf_mmap_length);
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
+	iommufd_viommu_destroy_mmap(vintf, vsmmu.core, vintf->mmap_offset);
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


