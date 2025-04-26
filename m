Return-Path: <linux-kselftest+bounces-31694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8272BA9D809
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 08:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08F227A644B
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 06:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6309217F27;
	Sat, 26 Apr 2025 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C4kxJ++O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C6216E26;
	Sat, 26 Apr 2025 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647204; cv=fail; b=ITQ3+aiFk6vib53ELFDLZU7+HDWGYojOl6uaj2frj9yHyLZhE1WBvcWR2c+L1lbrMKG5jeVPnVtEW4RBqxX/VECRKSg7uSA7XtUOI70UpLkAotHtYiBUP/dN+SC3VMuTr2q1QUjL1KJtxstcfT273MtMU1+LItnX9JIf5R4evWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647204; c=relaxed/simple;
	bh=+cjxPdFc4ENpVvDl8Rh66LRaa6zss/O8nWdo6aafFwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syIGW3FZsxGUVLxYKxPSyf9xsbL+t0+Xp3sA81qS8CmioAShoWPHFQKS7z7Vb+Ify2X8VicZkUfzt2iZq3cg440lbAht0WG074LTsFD95Jf8MjTQ629lPuqAE+DwCtvWoqcNSYB2EE2qRBG9PHH4wagYDXXooWPJWJ6OaU5+zbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C4kxJ++O; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LY6mOBxFs/FtnuLsE0KkpLxDdO3nMtMxCp4xuQKGpbw5jstJPJWFid5LgiJIq8Gke9jmi4a+oZZ3UTdlcBdHwxuYMi+c4aH/KDEo8ZE+Ph1uv7Tkgf+OyUERTgE0LYLICP3PeIhx1liQcc04NQCXOgOuDKBeOEhjd0Vlq7RUSGCWSlnhfECZMa7fqngIvGuCwdHpF/OV2DWbYvyPDjzOfPSnb+1YlRRMGQrbPNsRo0c6TzOx/BSgEUHNyIOsC2wN7FrXwge1H+PYq53UK9HSnEmeUIrvgGAYiTZGDnpVkt0pHfOV/gF2oUpWcp2tRaDZBOir8WsgGlfbWygUPaWd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGcajfbHCbmVXy3JS+iEZ55UiuPK6ITXBG+esXhDb9k=;
 b=TiqbUgtWR8zP3KaS7eWU5tFAxaLHluX+bxv81Rf8zPMVhNHqoQ4gPbbIr8h5EMFarLRJp5DDqTgnP3FNjlRPfpAZMF0GZ3uAp/36WG1XMp1dyM+zweLoCdSuOLHesOtWbiwMt00DLMBebVlnNYG/Oc18v+lrmX/3zyo215yXOzuHSSJecfeZYwV9JLwDlq+iUlG3P7TZk9Debdkx9QyrtsSpkdf76CAz698bw88f/jAGTO4ePwuYnWS2UQwULsEUokfioOGfxUbofdrNOgYn5ZcpgBFJB3kf20l6KNcAoYntR58W0yP1NMZchHd/aNjChPrFdeFQA7fqE46RiFJBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGcajfbHCbmVXy3JS+iEZ55UiuPK6ITXBG+esXhDb9k=;
 b=C4kxJ++OHo4CAxt8Dn0BPtcYgfdPx+66KX2Cuk+UIqntLCUgwP0Z5T00hHXLNi3lVnHW6h+pCCQ3hxnxiPD3O2hLVzy0Zk7S4uOTxatCNIDBgEv4NTanmYBwn2hJN43/bML8V7AMNEhstM7PX14qoX3Da80rLEDr4fbGhfpH4iavxgPRg1SZ5JgHytbBBAoctpHl/0Z8vaUxYdPaiy2srh+PecxUwkjVOu072znTBbNdva8IDYQBnkQrnsq9NNQS5oP1lB3cdI01Ybdrb9KxAbi/tSAEF5oTW+JhDk+PMyHGT9EUQCZZeU3b0KifY3KIJL7jtAFnu4t2m98y1N5c/A==
Received: from MW4PR03CA0135.namprd03.prod.outlook.com (2603:10b6:303:8c::20)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 05:59:53 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::23) by MW4PR03CA0135.outlook.office365.com
 (2603:10b6:303:8c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Sat,
 26 Apr 2025 05:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:59:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:59:38 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:59:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:59:34 -0700
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
Subject: [PATCH v2 21/22] iommu/tegra241-cmdqv: Add user-space use support
Date: Fri, 25 Apr 2025 22:58:16 -0700
Message-ID: <b81b2332f793a9ffccc528d821f2ed3ac051f9e0.1745646960.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745646960.git.nicolinc@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 898473e5-34b0-4b65-8f53-08dd84878ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kiKLZRX9pDTc+UCfQfgsMs5F89W1IouWB9xi4mGMpkV/3qzenwBhaIO7dAkd?=
 =?us-ascii?Q?wv1u1kfRhcvZ0EeHaJrDaGwEJcxLBBdOgGxnDRpqz5+489uaPJCuWKxiXA1q?=
 =?us-ascii?Q?gIvK2aujdyS08rzCPEqOIljFiBlHOvVTJh8OTNUK0V9fISjNzP2qs+MCZ4c/?=
 =?us-ascii?Q?YW+jJQ0e7VJD+8/CToStzkm4qN022BsjmYhf7Sjaz7F9U8D55e8ztuEuINP6?=
 =?us-ascii?Q?4LNDhTyht0mW8btJv33kJ/euQ3/7hnjXZewIyuGjVgOJUETRVxJNAxju44Jz?=
 =?us-ascii?Q?pKd3QHEGS4tVY6MX7jdTHGSKyBQyixu2akaLjNlG9dkZd+m4jiLe5zUhKLYy?=
 =?us-ascii?Q?oZhiThevfnMW5i8jTyF6Y14wKtTS8qLMPxnNDJMSHz1UdxhROxVtCm4mQuU7?=
 =?us-ascii?Q?DfBTrzuCcWJAnZw8SxHI+5rDa9DtGgnNvU8ueuREPP/r3cyFFlgLWF18LRjA?=
 =?us-ascii?Q?nPNvxjlg/prAnky7F5xAylWRPSQIvTRvIyK3asIpMlM//XQNGo0SIm/0tCsT?=
 =?us-ascii?Q?WKvXKgiTpVzXDTEtHOnetEh6XLN+8HfebEM9h5viAdLW/kQfsgSiF9tezhtr?=
 =?us-ascii?Q?+A/SV6zqeOkWBcuuEw7QC+xGl9bIYAHdX6bR5wijK7cRYMjN31FAMrfhgiuT?=
 =?us-ascii?Q?5RyD/SPmpnW4tSs/UTyYIPTv+qrnjNQL4aTnM5551rrXMjCSfKnv9joOhDLp?=
 =?us-ascii?Q?C0KRFyTZ+v9Sc9+dRsBFyz35vv/4gBeU+6TncNM6ry8phk4Iq+uCcNvWDsqL?=
 =?us-ascii?Q?jes8NBJ+kBFaaZFX7dJlopXrgIXf2Vb8OYBme+nIk+m5n6qXj7tbGtmsoCDu?=
 =?us-ascii?Q?wYYCb5t18gsM7mXmgQdbEonf+949PFWaSgugMz8/CNGerT4rj1YzcbXSA4R+?=
 =?us-ascii?Q?7ij1ynRi63JxFqzuGYV2RQnA4ApHIbZ9xsUhXdvsUmX3a2BbvENVN7QSEksv?=
 =?us-ascii?Q?Qqi+3FU1KmFGKVbOS53oq+1TdfM2N9NhCgYzN8oelhvpCr/tGTILvrb8FtB6?=
 =?us-ascii?Q?OtfF0i0tYFfYHcFJ23ivYwOUAImcTCesErlxOBn9dyguW6CA87OHWobOKxh6?=
 =?us-ascii?Q?RVb8keeVeL37hZm1e0vn3rV9Hs6RsmO4M5qhZ3U08R9+20KkeFqRZ72PjOHJ?=
 =?us-ascii?Q?Sf9h6RQkn1CukI2z9ZMEt2/yKnKYbqG7IoTa7a+5tYJyKjWDFqBUhcwHRm9j?=
 =?us-ascii?Q?unPn2lpoWj9Axfxk0GKhQsMm/n8GfJfp3YrQQP9x3e5xzREq3ik9gw04iSrr?=
 =?us-ascii?Q?eHVMxzoRyz8AxUYmyKl1ZY6wJ2cA/k9kQffpMdxre47/G0/hnRkdA7piGJVQ?=
 =?us-ascii?Q?xw37lHkNYtgGC2pKufeLdao/u0zXjLQ4C94gDjWNfnI6OXkZjYW17CxbDVzA?=
 =?us-ascii?Q?qky6no6jlKBh5E0IdcSrZRtpPoJlmd9hqA3dJ51m/Z1+ZXJr/zmMValhdajU?=
 =?us-ascii?Q?bb+Zy2kE1B6J/HTVzMntcksKIWtmkIKqVL7ghSArEO0UfPqfbGYaotTLOnal?=
 =?us-ascii?Q?yiMMV7iR1p5eZG9FX5VoiZjcMSwlxcC9+dRD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:59:52.5627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 898473e5-34b0-4b65-8f53-08dd84878ff3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903

The CMDQV HW supports a user-space use for virtualization cases. It allows
the VM to issue guest-level TLBI or ATC_INV commands directly to the queue
and executes them without a VMEXIT, as HW will replace the VMID field in a
TLBI command and the SID field in an ATC_INV command with the preset VMID
and SID.

This is built upon the vIOMMU infrastructure by allowing VMM to allocate a
VINTF (as a vIOMMU object) and assign VCMDQs (vCMDQ objects) to the VINTF.

So firstly, replace the standard vSMMU model with the VINTF implementation
but reuse the standard cache_invalidate op (for unsupported commands) and
the standard alloc_domain_nested op (for standard nested STE).

Each VINTF has two 64KB MMIO pages (128B per logical vCMDQ):
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
 include/uapi/linux/iommufd.h                  |  49 ++-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |   6 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 374 +++++++++++++++++-
 4 files changed, 435 insertions(+), 9 deletions(-)

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
index b2614f0f1547..d69e7c1d39ea 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -549,12 +549,25 @@ struct iommu_hw_info_vtd {
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
+ *          Bits[07:04] - Log2 of the total number of vCMDQs per vIOMMU
+ *          Bits[03:00] - Version number for the CMDQ-V HW
  * @idr: Implemented features for ARM SMMU Non-secure programming interface
  * @iidr: Information about the implementation and implementer of ARM SMMU,
  *        and architecture version supported
@@ -952,10 +965,28 @@ struct iommu_fault_alloc {
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
+ * access to the VINTF page0 in order to control its virtual comamnd queues.
+ */
+struct iommu_viommu_tegra241_cmdqv {
+	__aligned_u64 out_vintf_page0_pgoff;
+	__aligned_u64 out_vintf_page0_pgsz;
 };
 
 /**
@@ -1152,9 +1183,23 @@ struct iommu_veventq_alloc {
 /**
  * enum iommu_vcmdq_type - Virtual Command Queue Type
  * @IOMMU_VCMDQ_TYPE_DEFAULT: Reserved for future use
+ * @IOMMU_VCMDQ_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension for SMMUv3
  */
 enum iommu_vcmdq_type {
 	IOMMU_VCMDQ_TYPE_DEFAULT = 0,
+	/*
+	 * TEGRA241_CMDQV requirements (otherwise it will fail)
+	 * - alloc starts from the lowest @index=0 in ascending order
+	 * - destroy starts from the last allocated @index in descending order
+	 * - @addr must be aligned to @length in bytes and be mmapped in IOAS
+	 * - @length must be a power of 2, with a minimum 32 bytes and a maximum
+	 *   1 ^ idr[1].CMDQS x 16 bytes (do GET_HW_INFO call to read idr[1] in
+	 *   struct iommu_hw_info_arm_smmuv3)
+	 * - suggest to back the queue memory with contiguous physical pages or
+	 *   a single huge page with alignment of the queue size, limit vSMMU's
+	 *   IDR1.CMDQS to the huge page size divided by 16 bytes
+	 */
+	IOMMU_VCMDQ_TYPE_TEGRA241_CMDQV = 1,
 };
 
 /**
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 63861c60b615..40246cd04656 100644
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
index 869c90b660c1..88e2b6506b3a 100644
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
+ * @core: Embedded iommufd_vcmdq structure
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
+	struct iommufd_vcmdq core;
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
+ * @id: Slot index in the VINTF
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
 
@@ -380,6 +420,12 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
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
@@ -390,7 +436,7 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 	tegra241_vcmdq_hw_deinit(vcmdq);
 
 	/* Configure and enable VCMDQ */
-	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
+	_tegra241_vcmdq_hw_init(vcmdq);
 
 	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
 	if (ret) {
@@ -420,6 +466,7 @@ static void tegra241_vcmdq_unmap_lvcmdq(struct tegra241_vcmdq *vcmdq)
 static void tegra241_vintf_hw_deinit(struct tegra241_vintf *vintf)
 {
 	u16 lidx = vintf->cmdqv->num_lvcmdqs_per_vintf;
+	int sidx;
 
 	/* HW requires to unmap LVCMDQs in descending order */
 	while (lidx--) {
@@ -429,6 +476,10 @@ static void tegra241_vintf_hw_deinit(struct tegra241_vintf *vintf)
 		}
 	}
 	vintf_write_config(vintf, 0);
+	for (sidx = 0; sidx < vintf->cmdqv->num_sids_per_vintf; sidx++) {
+		writel_relaxed(0, REG_VINTF(vintf, SID_REPLACE(sidx)));
+		writel_relaxed(0, REG_VINTF(vintf, SID_MATCH(sidx)));
+	}
 }
 
 /* Map a global VCMDQ to the pre-assigned LVCMDQ */
@@ -457,7 +508,8 @@ static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
 	 * whether enabling it here or not, as !HYP_OWN cmdq HWs only support a
 	 * restricted set of supported commands.
 	 */
-	regval = FIELD_PREP(VINTF_HYP_OWN, hyp_own);
+	regval = FIELD_PREP(VINTF_HYP_OWN, hyp_own) |
+		 FIELD_PREP(VINTF_VMID, vintf->vsmmu.vmid);
 	writel(regval, REG_VINTF(vintf, CONFIG));
 
 	ret = vintf_write_config(vintf, regval | VINTF_EN);
@@ -584,7 +636,9 @@ static void tegra241_vintf_free_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
 
 	dev_dbg(vintf->cmdqv->dev,
 		"%sdeallocated\n", lvcmdq_error_header(vcmdq, header, 64));
-	kfree(vcmdq);
+	/* Guest-owned VCMDQ is free-ed with vcmdq by iommufd core */
+	if (vcmdq->vintf->hyp_own)
+		kfree(vcmdq);
 }
 
 static struct tegra241_vcmdq *
@@ -623,6 +677,9 @@ tegra241_vintf_alloc_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
 
 static void tegra241_cmdqv_deinit_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
 {
+	if (cmdqv->vintfs[idx]->immap_id)
+		iommufd_ctx_free_mmap(cmdqv->vintfs[idx]->vsmmu.core.ictx,
+				      cmdqv->vintfs[idx]->immap_id);
 	kfree(cmdqv->vintfs[idx]->lvcmdqs);
 	ida_free(&cmdqv->vintf_ids, idx);
 	cmdqv->vintfs[idx] = NULL;
@@ -671,7 +728,11 @@ static void tegra241_cmdqv_remove_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
 
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
@@ -699,10 +760,32 @@ static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
 	put_device(cmdqv->dev); /* smmu->impl_dev */
 }
 
+static struct arm_vsmmu *
+tegra241_cmdqv_vsmmu_alloc(struct arm_smmu_device *smmu,
+			   struct arm_smmu_domain *smmu_domain,
+			   struct iommufd_ctx *ictx, unsigned int viommu_type,
+			   const struct iommu_user_data *user_data);
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
+			   ilog2(cmdqv->num_sids_per_vintf));
+	return IOMMU_HW_INFO_ARM_SMMUV3_HAS_TEGRA241_CMDQV;
+}
+
 static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
 	.device_reset = tegra241_cmdqv_hw_reset,
 	.device_remove = tegra241_cmdqv_remove,
+	.vsmmu_alloc = tegra241_cmdqv_vsmmu_alloc,
+	.hw_info = tegra241_cmdqv_hw_info,
 };
 
 /* Probe Functions */
@@ -844,6 +927,7 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->irq = irq;
 	cmdqv->base = base;
 	cmdqv->dev = smmu->impl_dev;
+	cmdqv->base_phys = res->start;
 
 	if (cmdqv->irq > 0) {
 		ret = request_threaded_irq(irq, NULL, tegra241_cmdqv_isr,
@@ -860,6 +944,8 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->num_vintfs = 1 << FIELD_GET(CMDQV_NUM_VINTF_LOG2, regval);
 	cmdqv->num_vcmdqs = 1 << FIELD_GET(CMDQV_NUM_VCMDQ_LOG2, regval);
 	cmdqv->num_lvcmdqs_per_vintf = cmdqv->num_vcmdqs / cmdqv->num_vintfs;
+	cmdqv->num_sids_per_vintf =
+		1 << FIELD_GET(CMDQV_NUM_SID_PER_VM_LOG2, regval);
 
 	cmdqv->vintfs =
 		kcalloc(cmdqv->num_vintfs, sizeof(*cmdqv->vintfs), GFP_KERNEL);
@@ -913,3 +999,283 @@ struct arm_smmu_device *tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
 	put_device(smmu->impl_dev);
 	return ERR_PTR(-ENODEV);
 }
+
+/* User-space vIOMMU and vCMDQ Functions */
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
+static struct iommufd_vcmdq *
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
+	if (type != IOMMU_VCMDQ_TYPE_TEGRA241_CMDQV)
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
+	 *   [ 32, 1 ^ (idr[1].CMDQS + CMDQ_ENT_SZ_SHIFT) ]
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
+	vcmdq = iommufd_vcmdq_alloc(viommu, struct tegra241_vcmdq, core);
+	if (!vcmdq)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * HW requires to unmap LVCMDQs in descending order, so destroy() must
+	 * follow this rule. Set a dependency on its previous LVCMDQ so iommufd
+	 * core will help enforce it.
+	 */
+	if (prev) {
+		ret = iommufd_vcmdq_depend(vcmdq, prev, core);
+		if (ret)
+			goto free_vcmdq;
+	}
+	vcmdq->prev = prev;
+
+	ret = tegra241_vintf_init_lvcmdq(vintf, index, vcmdq);
+	if (ret)
+		goto free_vcmdq;
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
+		goto free_vcmdq;
+	vintf->lvcmdqs[index] = vcmdq;
+
+	return &vcmdq->core;
+free_vcmdq:
+	iommufd_struct_destroy(viommu->ictx, vcmdq, core);
+	return ERR_PTR(ret);
+}
+
+static void tegra241_vintf_destroy_lvcmdq_user(struct iommufd_vcmdq *core)
+{
+	struct tegra241_vcmdq *vcmdq = core_to_vcmdq(core);
+
+	tegra241_vcmdq_hw_deinit(vcmdq);
+	tegra241_vcmdq_unmap_lvcmdq(vcmdq);
+	tegra241_vintf_free_lvcmdq(vcmdq->vintf, vcmdq->lidx);
+	if (vcmdq->prev)
+		iommufd_vcmdq_undepend(vcmdq, vcmdq->prev, core);
+
+	/* IOMMUFD core frees the memory of vcmdq and vcmdq */
+}
+
+static void tegra241_cmdqv_destroy_vintf_user(struct iommufd_viommu *viommu)
+{
+	struct tegra241_vintf *vintf = viommu_to_vintf(viommu);
+
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
+		iommufd_struct_destroy(viommu->ictx, vsid, core);
+		return ERR_PTR(sidx);
+	}
+
+	writel_relaxed(stream->id, REG_VINTF(vintf, SID_REPLACE(sidx)));
+	writel_relaxed(dev_id << 1 | 0x1, REG_VINTF(vintf, SID_MATCH(sidx)));
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
+	writel_relaxed(0, REG_VINTF(vintf, SID_REPLACE(vsid->idx)));
+	writel_relaxed(0, REG_VINTF(vintf, SID_MATCH(vsid->idx)));
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
+	.vcmdq_alloc = tegra241_vintf_alloc_lvcmdq_user,
+	.vcmdq_destroy = tegra241_vintf_destroy_lvcmdq_user,
+};
+
+static struct arm_vsmmu *
+tegra241_cmdqv_vsmmu_alloc(struct arm_smmu_device *smmu,
+			   struct arm_smmu_domain *s2_parent,
+			   struct iommufd_ctx *ictx, unsigned int viommu_type,
+			   const struct iommu_user_data *user_data)
+{
+	struct tegra241_cmdqv *cmdqv =
+		container_of(smmu, struct tegra241_cmdqv, smmu);
+	struct iommu_viommu_tegra241_cmdqv data;
+	struct tegra241_vintf *vintf;
+	phys_addr_t page0_base;
+	int ret;
+
+	if (viommu_type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV)
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
+	ret = iommufd_ctx_alloc_mmap(ictx, page0_base, SZ_64K,
+				     &vintf->immap_id);
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
+	iommufd_ctx_free_mmap(ictx, vintf->immap_id);
+hw_deinit_vintf:
+	tegra241_vintf_hw_deinit(vintf);
+deinit_vintf:
+	tegra241_cmdqv_deinit_vintf(cmdqv, vintf->idx);
+free_vintf:
+	iommufd_struct_destroy(ictx, vintf, vsmmu.core);
+	return ERR_PTR(ret);
+}
-- 
2.43.0


