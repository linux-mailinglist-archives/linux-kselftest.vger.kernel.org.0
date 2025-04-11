Return-Path: <linux-kselftest+bounces-30518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F375BA85476
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBDD9A817D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 06:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2905428C5BB;
	Fri, 11 Apr 2025 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ndaWOxvG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990E284B31;
	Fri, 11 Apr 2025 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353536; cv=fail; b=rDQ3rLEc9ji0VFtiwHPDZySrId+o2VKcE+5yvlnwlhqzUfc/zwcMQHZy3x/BEqUZp0hGq21suxeEgm6mvhs/haTNAepHdUTfpzCAJa6SsDxw2eXRiZZYGVEnOxpmHucb5BBgds/XKac1GP60vxlUv4phfEo/j8RIPSSxl/2eXDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353536; c=relaxed/simple;
	bh=z5NlAzJduXkp9xNEguVIes9KOrYrZzvndk/bad211h0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqChwCYw4wcsaoky2goyCb1oAKoUHwkDHZa1An2W3m45WABBO2GAWLrgyvjkkP6M2skhU1xfgMuSZQAfXnFANzwvSX1DgFxSqKIhBDFW0lbvsZ0Y7uGup3P3+lHoEo/5lnpEpopX3OOBOUmtBRmFu3Zg6wOGZlRTD+zggcykRPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ndaWOxvG; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P66FW+6BxeY+Uokqi034ex0BAAaJ/Dy9GkN9k+vwM0jaXzBArqLGvl7sf0fD5DX15lGYmF3qj5fdNj8X8fGF9Wixh2nzSGYEIOvzNJgcKZXd/M8t0OrDB1mw7XCyl6ueh9jpcJ02FB01dP/z08jS0I5dO0inVclJlUsWRqSZzM/V76/4+wA8GamAgw9NIXur/HBNGwMemsKv8NSyTsUJnDzcpQA8CHLwgNvqXH/zTcvu4iWZos50Ay9ID0QtzGVF+0eTMES6KvjZGUp6sJIITxISBcMmq7X1KnNMdQ7a6kwq0XOg4GLvXPcoiPh3qwqg6qbkcPIo4cpBN5/FeUFDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zX8or8fX3h6C8PAcX3PF1BzAeeE7wh0vN68L27cCOmk=;
 b=opYiG3p2YSGSZqOuJecyyzDsiyQbLgWizxV3+P0fA2eb0aP3KIUtfhhJvfxSYu6aZC++R6dLA8Wa/uZfTeg4RyOzznGEZYQGcbyAOTFoINKiVtaBYaUoAFtbpigncedTI8e3Wu/PLpEg3yqc0XQQVx7kStU2RZk5mEZ3uczqzyZAx++9gFcaiKmNmQrOKluWSyLlKh/HiXKuPvI2MMD7+6hn3woCYgIFIai1d4xm9Sj1sPnBlRbH/P6/DWdseebUgpsZCkWEORXIZsWDg4Y3w0WwYupEl4xBa5edfkPiKpu+GNnp2keNYQCx+Efkz+aseuAHpi+y682dT64JXGih/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX8or8fX3h6C8PAcX3PF1BzAeeE7wh0vN68L27cCOmk=;
 b=ndaWOxvGRn0yZTxHIhclVHXPgLbvJL/+OwYW9lnUynwxmiNVGvhhTFPnR4q8c1pXZ/ljprKn7NjrBAJ+uOW6+93xYS+qrWXibDx2RP4scHkCk+C5TzdsBLbg+Iln99fj5ZDmpfUcS0s03qqVBWnYXVd/a3+kantxwHVoTr0HV5H9rN26dCHpy4d/lfTE4Ib1olc37Nofo6BeSQWV4Tt7mZyYCVFYOLzetZ5TmhWgRraltHo0JNwOlB+HmQ9jpZ3Mk3KyTqAoU8+GK5YXNZWIuqZyS68UztLCh5TCfAAWmWVV1lk3DrjkSQ4HmjTzUWw9wUKw7mkDB0C892U9JfEcww==
Received: from BYAPR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:40::29)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 06:38:44 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::65) by BYAPR04CA0016.outlook.office365.com
 (2603:10b6:a03:40::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Fri,
 11 Apr 2025 06:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 06:38:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 23:38:33 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 23:38:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 23:38:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<praan@google.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <jsnitsel@redhat.com>, <mshavit@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH v1 15/16] iommu/tegra241-cmdqv: Add user-space use support
Date: Thu, 10 Apr 2025 23:37:54 -0700
Message-ID: <30c7aff68c35040ee637629cb9fc2b6e7f83f76c.1744353300.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744353300.git.nicolinc@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ca90fa-b875-45f1-6526-08dd78c3816a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rcwDLX7Fyb/V6yQUvbXj/CHWRyhts+ZEO9Pe3zcaLfeBOhre26ZT+g6MBmT0?=
 =?us-ascii?Q?DCuTC6FpKVxkd3/naYn3ZSB4UBV24TvYTqNFbe+rki5OCLDyrLir5cbu5qHH?=
 =?us-ascii?Q?TOVDPw66Wbb1fiZ2vWspeTrA39HJoBrftZkDNvIt2bsVuqO2oebhi0chRfop?=
 =?us-ascii?Q?1IcpIiSmZyrtiDI+ySTHGLQ+rWlgoMDd3Rxq9yXtgThen1hXgJQCiXFVaG9L?=
 =?us-ascii?Q?VYtxNIi2OnAbo1bIL5Z2Q9BbGDAsh7nd+pKSAp1bQkZgy0i+NZPwsrqRD2DM?=
 =?us-ascii?Q?w8n8g/GK5u5jboeGsnkV9aFPjl2tGcHSgS1tp6hUuNoZwSwnvPYTKDxUE3ES?=
 =?us-ascii?Q?AS3A/TBrA7ZWkrKzs+bbdQ/V13T9rc8aZ7Ey4UAik+ODp+tK/yL/b2dVNJOK?=
 =?us-ascii?Q?h/TwKoHp2eToTwxsCHtFwNyfo0yapMCQs8/pQr1oGlm6UYKPL/N2C/hYyx9n?=
 =?us-ascii?Q?y8TdktptFdvE4HUCJF/hHHahpC99p5rkZl47g/U+/og7qcaZuUT2MruLSQ97?=
 =?us-ascii?Q?cDnSJOKe+gQxSOdQn3i/H2LttIRGlrw51EPuIxR4eNh51MWKxuWTD8xAKWXC?=
 =?us-ascii?Q?emerWYZX+6o/91Jzc1r1xB5y73qf/gJXgdd+bXt7QdSLv8Uqp4Rig8HtSGfI?=
 =?us-ascii?Q?u/LViN9gI8SM5/zjThZzaC6i3VBm5xqvXZIseD6YsATQVNHrBkHVk2sNfcAl?=
 =?us-ascii?Q?sZG6HtMBoOw+PEL65HVP/B676rNsdgzZ63o4I8DlB6KzYRyR3tEN9rZWQGtO?=
 =?us-ascii?Q?XzmUB2Zsk5jTXsz3sF7ycyP9yWTlSXbyON4aIryUGVBPJB/KPSro85srIROb?=
 =?us-ascii?Q?MXXsonujPTnsqvsHMrhpSBXzF97v8OtfAQCp+o5AbPuU2+++W3WWz/cJMsEm?=
 =?us-ascii?Q?hsF1WtsXkjZPqD42L6l7w3+DYys1mfz8IUB8XWX/8KsCRctIoKbknQraui1y?=
 =?us-ascii?Q?lsms6tcDBUaRga8qSyij6w6mr17NDRBcXxeaz176wQ0Hwp1opaUptl1sP2Jg?=
 =?us-ascii?Q?XggDwdSUnrG2FOjQfe+nu03/fnS2I7V7b4yIDcUbuAQQAN1TPYWiuZwFw28Q?=
 =?us-ascii?Q?6rOojqHyDg6Ta3FXU8R71iZep1d5d+ojISCHvL7aTaVbu8oMhgldZD5eI65P?=
 =?us-ascii?Q?65Q1qEKqsvMSYHsJxoiObJ2Zh9NnUgCkv8Cdxc1aym86Pe2lNNk5+K7G8XPj?=
 =?us-ascii?Q?6wRkMuoNxC/+wLxwLVY2VZFKSIFbndG5JIqgFIzm8DA9atYmFfCUidpnBY2v?=
 =?us-ascii?Q?i+sxEUEV2ano5iyuq3RQNSdfO67BDG7kPMgZDAnvWWMCKqC6D7zq9xOBkmMa?=
 =?us-ascii?Q?XCVoVWu19U73IhLP89AzlxcDS2HOAz8L0bnFLK6gWOY71bX3RyaBYCovrNDi?=
 =?us-ascii?Q?TTv2Hwrzwxg27Pvp6OE+KarYeGzL72rpbNo5wowSDcdi6ZG5ka9lIRLb/1HI?=
 =?us-ascii?Q?tY5t83Ma4zOnh7BiYzTlxnHHDcEdqrmNKK/I+/2PCx5XTipD9FcFv5FrbOQp?=
 =?us-ascii?Q?p2cXBtfCR6ZJqwWUbHs3g81Q/qoW7d5PdrAU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:38:44.1355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ca90fa-b875-45f1-6526-08dd78c3816a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407

Add the support via vIOMMU infrastructure for virtualization use case.

This basically allows VMM to allocate VINTFs (as a vIOMMU object) and
assign VCMDQs (vCMDQ objects) to it. A VINTF's MMIO page0 can be mmap'd
to user space for VM to access directly without VMEXIT and corresponding
hypercall.

As an initial version, the number of VCMDQs per VINTF is fixed to two.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  15 +
 include/uapi/linux/iommufd.h                  |  34 ++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |   6 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 322 +++++++++++++++++-
 4 files changed, 370 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a5835af72417..84f8dfdd9638 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -999,6 +999,14 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
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
@@ -1075,9 +1083,16 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
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
index 428f1e9e6239..ce20f038b56b 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -952,10 +952,28 @@ struct iommu_fault_alloc {
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
@@ -1152,9 +1170,25 @@ struct iommu_veventq_alloc {
 /**
  * enum iommu_vcmdq_type - Virtual Queue Type
  * @IOMMU_VCMDQ_TYPE_DEFAULT: Reserved for future use
+ * @IOMMU_VCMDQ_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension for SMMUv3
  */
 enum iommu_vcmdq_data_type {
 	IOMMU_VCMDQ_TYPE_DEFAULT = 0,
+	IOMMU_VCMDQ_TYPE_TEGRA241_CMDQV = 1,
+};
+
+/**
+ * struct iommu_vqueue_tegra241_cmdqv - NVIDIA Tegra241's Virtual Command Queue
+ *                                      for its CMDQV Extension for ARM SMMUv3
+ *                                      (IOMMU_VCMDQ_TYPE_TEGRA241_CMDQV)
+ * @vcmdq_id: logical ID of a virtual command queue in the vIOMMU instance
+ * @vcmdq_log2size: (1 << @vcmdq_log2size) will be the size of the vcmdq
+ * @vcmdq_base: guest physical address (IPA) to the vcmdq base address
+ */
+struct iommu_vcmdq_tegra241_cmdqv {
+	__u32 vcmdq_id;
+	__u32 vcmdq_log2size;
+	__aligned_u64 vcmdq_base;
 };
 
 /**
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index aa8653af50f2..162872d82cd4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -216,7 +216,7 @@ static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg,
 	return 0;
 }
 
-static struct iommu_domain *
+struct iommu_domain *
 arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 			      const struct iommu_user_data *user_data)
 {
@@ -327,8 +327,8 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
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
index ba029f7d24ce..b778739f845a 100644
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
 
@@ -26,6 +28,7 @@
 #define  CMDQV_EN			BIT(0)
 
 #define TEGRA241_CMDQV_PARAM		0x0004
+#define  CMDQV_NUM_SID_PER_VM_LOG2	GENMASK(15, 12)
 #define  CMDQV_NUM_VINTF_LOG2		GENMASK(11, 8)
 #define  CMDQV_NUM_VCMDQ_LOG2		GENMASK(7, 4)
 
@@ -53,6 +56,9 @@
 #define  VINTF_STATUS			GENMASK(3, 1)
 #define  VINTF_ENABLED			BIT(0)
 
+#define TEGRA241_VINTF_SID_MATCH(s)	(0x0040 + 0x4*(s))
+#define TEGRA241_VINTF_SID_REPLACE(s)	(0x0080 + 0x4*(s))
+
 #define TEGRA241_VINTF_LVCMDQ_ERR_MAP_64(m) \
 					(0x00C0 + 0x8*(m))
 #define  LVCMDQ_ERR_MAP_NUM_64		2
@@ -114,6 +120,7 @@ MODULE_PARM_DESC(bypass_vcmdq,
 
 /**
  * struct tegra241_vcmdq - Virtual Command Queue
+ * @core: Embedded iommufd_vcmdq structure
  * @idx: Global index in the CMDQV
  * @lidx: Local index in the VINTF
  * @enabled: Enable status
@@ -124,6 +131,8 @@ MODULE_PARM_DESC(bypass_vcmdq,
  * @page1: MMIO Page1 base address
  */
 struct tegra241_vcmdq {
+	struct iommufd_vcmdq core;
+
 	u16 idx;
 	u16 lidx;
 
@@ -136,18 +145,26 @@ struct tegra241_vcmdq {
 	void __iomem *page0;
 	void __iomem *page1;
 };
+#define core_to_vcmdq(v) container_of(v, struct tegra241_vcmdq, core)
 
 /**
  * struct tegra241_vintf - Virtual Interface
+ * @vsmmue: Embedded arm_vsmmu structure
  * @idx: Global index in the CMDQV
+ * @vmid: VMID for configuration
  * @enabled: Enable status
  * @hyp_own: Owned by hypervisor (in-kernel)
  * @cmdqv: Parent CMDQV pointer
  * @lvcmdqs: List of logical VCMDQ pointers
  * @base: MMIO base address
+ * @s2_domain: Stage-2 SMMU domain
+ * @sid_slots: Stream ID Slot allocator
  */
 struct tegra241_vintf {
+	struct arm_vsmmu vsmmu;
+
 	u16 idx;
+	u16 vmid;
 
 	bool enabled;
 	bool hyp_own;
@@ -156,6 +173,25 @@ struct tegra241_vintf {
 	struct tegra241_vcmdq **lvcmdqs;
 
 	void __iomem *base;
+	struct arm_smmu_domain *s2_domain;
+	unsigned long mmap_pgoff;
+
+	struct ida sid_slots;
+};
+#define viommu_to_vintf(v) container_of(v, struct tegra241_vintf, vsmmu.core)
+
+/**
+ * struct tegra241_vintf_slot - Virtual Interface Stream ID Slot
+ * @core: Embedded iommufd_vdevice structure
+ * @vintf: Parent VINTF pointer
+ * @sid: Physical Stream ID
+ * @id: Slot index in the VINTF
+ */
+struct tegra241_vintf_slot {
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
 
@@ -379,6 +419,11 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 	dev_dbg(vcmdq->cmdqv->dev, "%sdeinited\n", h);
 }
 
+static void _tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
+{
+	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
+}
+
 static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 {
 	char header[64], *h = lvcmdq_error_header(vcmdq, header, 64);
@@ -388,7 +433,7 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 	tegra241_vcmdq_hw_deinit(vcmdq);
 
 	/* Configure and enable VCMDQ */
-	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
+	_tegra241_vcmdq_hw_init(vcmdq);
 
 	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
 	if (ret) {
@@ -407,11 +452,16 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 static void tegra241_vintf_hw_deinit(struct tegra241_vintf *vintf)
 {
 	u16 lidx;
+	int slot;
 
 	for (lidx = 0; lidx < vintf->cmdqv->num_lvcmdqs_per_vintf; lidx++)
 		if (vintf->lvcmdqs && vintf->lvcmdqs[lidx])
 			tegra241_vcmdq_hw_deinit(vintf->lvcmdqs[lidx]);
 	vintf_write_config(vintf, 0);
+	for (slot = 0; slot < vintf->cmdqv->num_sids_per_vintf; slot++) {
+		writel_relaxed(0, REG_VINTF(vintf, SID_REPLACE(slot)));
+		writel_relaxed(0, REG_VINTF(vintf, SID_MATCH(slot)));
+	}
 }
 
 static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
@@ -429,7 +479,8 @@ static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
 	 * whether enabling it here or not, as !HYP_OWN cmdq HWs only support a
 	 * restricted set of supported commands.
 	 */
-	regval = FIELD_PREP(VINTF_HYP_OWN, hyp_own);
+	regval = FIELD_PREP(VINTF_HYP_OWN, hyp_own) |
+		 FIELD_PREP(VINTF_VMID, vintf->vmid);
 	writel(regval, REG_VINTF(vintf, CONFIG));
 
 	ret = vintf_write_config(vintf, regval | VINTF_EN);
@@ -555,7 +606,9 @@ static void tegra241_vintf_free_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
 
 	dev_dbg(vintf->cmdqv->dev,
 		"%sdeallocated\n", lvcmdq_error_header(vcmdq, header, 64));
-	kfree(vcmdq);
+	/* Guest-owned VCMDQ is free-ed with vcmdq by iommufd core */
+	if (vcmdq->vintf->hyp_own)
+		kfree(vcmdq);
 }
 
 static struct tegra241_vcmdq *
@@ -594,6 +647,9 @@ tegra241_vintf_alloc_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
 
 static void tegra241_cmdqv_deinit_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
 {
+	if (cmdqv->vintfs[idx]->mmap_pgoff)
+		iommufd_ctx_free_mmap(cmdqv->vintfs[idx]->vsmmu.core.ictx,
+				      cmdqv->vintfs[idx]->mmap_pgoff);
 	kfree(cmdqv->vintfs[idx]->lvcmdqs);
 	ida_free(&cmdqv->vintf_ids, idx);
 	cmdqv->vintfs[idx] = NULL;
@@ -649,7 +705,11 @@ static void tegra241_cmdqv_remove_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
 
 	dev_dbg(cmdqv->dev, "VINTF%u: deallocated\n", vintf->idx);
 	tegra241_cmdqv_deinit_vintf(cmdqv, idx);
-	kfree(vintf);
+	if (!vintf->hyp_own)
+		ida_destroy(&vintf->sid_slots);
+	/* Guest-owned VINTF is free-ed with viommu by iommufd core */
+	if (vintf->hyp_own)
+		kfree(vintf);
 }
 
 static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
@@ -677,10 +737,17 @@ static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
 	put_device(cmdqv->dev); /* smmu->impl_dev */
 }
 
+static struct arm_vsmmu *
+tegra241_cmdqv_vsmmu_alloc(struct arm_smmu_device *smmu,
+			   struct arm_smmu_domain *smmu_domain,
+			   struct iommufd_ctx *ictx, unsigned int viommu_type,
+			   const struct iommu_user_data *user_data);
+
 static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
 	.device_reset = tegra241_cmdqv_hw_reset,
 	.device_remove = tegra241_cmdqv_remove,
+	.vsmmu_alloc = tegra241_cmdqv_vsmmu_alloc,
 };
 
 /* Probe Functions */
@@ -822,6 +889,7 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->irq = irq;
 	cmdqv->base = base;
 	cmdqv->dev = smmu->impl_dev;
+	cmdqv->base_phys = res->start;
 
 	if (cmdqv->irq > 0) {
 		ret = request_threaded_irq(irq, NULL, tegra241_cmdqv_isr,
@@ -838,6 +906,8 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->num_vintfs = 1 << FIELD_GET(CMDQV_NUM_VINTF_LOG2, regval);
 	cmdqv->num_vcmdqs = 1 << FIELD_GET(CMDQV_NUM_VCMDQ_LOG2, regval);
 	cmdqv->num_lvcmdqs_per_vintf = cmdqv->num_vcmdqs / cmdqv->num_vintfs;
+	cmdqv->num_sids_per_vintf =
+		1 << FIELD_GET(CMDQV_NUM_SID_PER_VM_LOG2, regval);
 
 	cmdqv->vintfs =
 		kcalloc(cmdqv->num_vintfs, sizeof(*cmdqv->vintfs), GFP_KERNEL);
@@ -891,3 +961,247 @@ struct arm_smmu_device *tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
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
+tegra241_cmdqv_vcmdq_alloc(struct iommufd_viommu *viommu,
+			   const struct iommu_user_data *user_data)
+{
+	struct tegra241_vintf *vintf = viommu_to_vintf(viommu);
+	struct tegra241_cmdqv *cmdqv = vintf->cmdqv;
+	struct iommu_vcmdq_tegra241_cmdqv arg;
+	struct tegra241_vcmdq *vcmdq;
+	phys_addr_t q_base;
+	char header[64];
+	int ret;
+
+	ret = iommu_copy_struct_from_user(
+		&arg, user_data, IOMMU_VCMDQ_TYPE_TEGRA241_CMDQV, vcmdq_base);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!arg.vcmdq_base || arg.vcmdq_base & ~VCMDQ_ADDR)
+		return ERR_PTR(-EINVAL);
+	if (!arg.vcmdq_log2size || arg.vcmdq_log2size > VCMDQ_LOG2SIZE)
+		return ERR_PTR(-EINVAL);
+	if (arg.vcmdq_id >= cmdqv->num_lvcmdqs_per_vintf)
+		return ERR_PTR(-EINVAL);
+	q_base = arm_smmu_domain_ipa_to_pa(vintf->s2_domain, arg.vcmdq_base);
+	if (!q_base)
+		return ERR_PTR(-EINVAL);
+
+	if (vintf->lvcmdqs[arg.vcmdq_id]) {
+		vcmdq = vintf->lvcmdqs[arg.vcmdq_id];
+
+		/* deinit the previous setting as a reset, before re-init */
+		tegra241_vcmdq_hw_deinit(vcmdq);
+
+		vcmdq->cmdq.q.q_base = q_base & VCMDQ_ADDR;
+		vcmdq->cmdq.q.q_base |= arg.vcmdq_log2size;
+		tegra241_vcmdq_hw_init_user(vcmdq);
+
+		return &vcmdq->core;
+	}
+
+	vcmdq = iommufd_vcmdq_alloc(viommu, struct tegra241_vcmdq, core);
+	if (!vcmdq)
+		return ERR_PTR(-ENOMEM);
+
+	ret = tegra241_vintf_init_lvcmdq(vintf, arg.vcmdq_id, vcmdq);
+	if (ret)
+		goto free_vcmdq;
+	dev_dbg(cmdqv->dev, "%sallocated\n",
+		lvcmdq_error_header(vcmdq, header, 64));
+
+	vcmdq->cmdq.q.q_base = q_base & VCMDQ_ADDR;
+	vcmdq->cmdq.q.q_base |= arg.vcmdq_log2size;
+
+	ret = tegra241_vcmdq_hw_init_user(vcmdq);
+	if (ret)
+		goto free_vcmdq;
+	vintf->lvcmdqs[arg.vcmdq_id] = vcmdq;
+
+	return &vcmdq->core;
+free_vcmdq:
+	iommufd_struct_destroy(viommu->ictx, vcmdq, core);
+	return ERR_PTR(ret);
+}
+
+static void tegra241_cmdqv_vcmdq_free(struct iommufd_vcmdq *core)
+{
+	struct tegra241_vcmdq *vcmdq = core_to_vcmdq(core);
+
+	tegra241_vintf_remove_lvcmdq(vcmdq->vintf, vcmdq->lidx);
+
+	/* IOMMUFD core frees the memory of vcmdq and vcmdq */
+}
+
+static void tegra241_cmdqv_viommu_destroy(struct iommufd_viommu *viommu)
+{
+	struct tegra241_vintf *vintf = viommu_to_vintf(viommu);
+
+	tegra241_cmdqv_remove_vintf(vintf->cmdqv, vintf->idx);
+
+	/* IOMMUFD core frees the memory of vintf and viommu */
+}
+
+static struct iommufd_vdevice *
+tegra241_cmdqv_vdevice_alloc(struct iommufd_viommu *viommu, struct device *dev,
+			     u64 dev_id)
+{
+	struct tegra241_vintf *vintf = viommu_to_vintf(viommu);
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_stream *stream = &master->streams[0];
+	struct tegra241_vintf_slot *slot;
+	int idx;
+
+	if (dev_id > UINT_MAX)
+		return ERR_PTR(-EINVAL);
+
+	slot = iommufd_vdevice_alloc(viommu, struct tegra241_vintf_slot, core);
+	if (!slot)
+		return ERR_PTR(-ENOMEM);
+
+	WARN_ON_ONCE(master->num_streams != 1);
+
+	/* Find an empty slot of SID_MATCH and SID_REPLACE */
+	idx = ida_alloc_max(&vintf->sid_slots,
+			    vintf->cmdqv->num_sids_per_vintf - 1, GFP_KERNEL);
+	if (idx < 0) {
+		iommufd_struct_destroy(viommu->ictx, slot, core);
+		return ERR_PTR(idx);
+	}
+
+	writel_relaxed(stream->id, REG_VINTF(vintf, SID_REPLACE(idx)));
+	writel_relaxed(dev_id << 1 | 0x1, REG_VINTF(vintf, SID_MATCH(idx)));
+	dev_dbg(vintf->cmdqv->dev,
+		"VINTF%u: allocated a slot (%d) for pSID=%x, vSID=%x\n",
+		vintf->idx, idx, stream->id, (u32)dev_id);
+
+	slot->idx = idx;
+	slot->vintf = vintf;
+	slot->sid = stream->id;
+
+	return &slot->core;
+}
+
+static void tegra241_cmdqv_vdevice_destroy(struct iommufd_vdevice *vdev)
+{
+	struct tegra241_vintf_slot *slot =
+		container_of(vdev, struct tegra241_vintf_slot, core);
+	struct tegra241_vintf *vintf = slot->vintf;
+
+	writel_relaxed(0, REG_VINTF(vintf, SID_REPLACE(slot->idx)));
+	writel_relaxed(0, REG_VINTF(vintf, SID_MATCH(slot->idx)));
+	ida_free(&vintf->sid_slots, slot->idx);
+	dev_dbg(vintf->cmdqv->dev,
+		"VINTF%u: deallocated a slot (%d) for pSID=%x\n", vintf->idx,
+		slot->idx, slot->sid);
+
+	/* IOMMUFD core frees the memory of slot and vdev */
+}
+
+static struct iommufd_viommu_ops tegra241_cmdqv_viommu_ops = {
+	.destroy = tegra241_cmdqv_viommu_destroy,
+	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
+	.cache_invalidate = arm_vsmmu_cache_invalidate,
+	.vdevice_alloc = tegra241_cmdqv_vdevice_alloc,
+	.vdevice_destroy = tegra241_cmdqv_vdevice_destroy,
+	.vcmdq_alloc = tegra241_cmdqv_vcmdq_alloc,
+	.vcmdq_free = tegra241_cmdqv_vcmdq_free,
+};
+
+static struct arm_vsmmu *
+tegra241_cmdqv_vsmmu_alloc(struct arm_smmu_device *smmu,
+			   struct arm_smmu_domain *smmu_domain,
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
+	if (!smmu_domain || smmu_domain->stage != ARM_SMMU_DOMAIN_S2)
+		return ERR_PTR(-EINVAL);
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
+	vintf->s2_domain = smmu_domain;
+	vintf->vmid = smmu_domain->s2_cfg.vmid;
+
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
+	ret = iommufd_ctx_alloc_mmap(ictx, page0_base, SZ_64K, true,
+				     &vintf->mmap_pgoff);
+	if (ret)
+		goto hw_deinit_vintf;
+
+	data.out_vintf_page0_pgsz = SZ_64K;
+	data.out_vintf_page0_pgoff = vintf->mmap_pgoff;
+	ret = iommu_copy_struct_to_user(user_data, &data,
+					IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
+					out_vintf_page0_pgsz);
+	if (ret)
+		goto hw_deinit_vintf;
+
+	ida_init(&vintf->sid_slots);
+
+	dev_dbg(cmdqv->dev, "VINTF%u: allocated with vmid (%d)\n", vintf->idx,
+		vintf->vmid);
+
+	return &vintf->vsmmu;
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


