Return-Path: <linux-kselftest+bounces-33284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C603DABAD86
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3FF189CB8F
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12330236A70;
	Sun, 18 May 2025 03:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t2iG3Xcf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB671E2858;
	Sun, 18 May 2025 03:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538592; cv=fail; b=SRuMjSEpxrTYpt4JMWQ1VM52R9yHbpXPu+Kspwojt2kt08H3bPoGNBEFzWGY1//BqkpI8HiNC/0ohqLp7xwc8A2utdmiw1G5aSomoxyA0L9741MGIGY4C5h4w1Uy4ZYYr8X9dp2AE13Au3dLTATYTsS1SCiWYjrfVPM6qoLgJho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538592; c=relaxed/simple;
	bh=COeZtVVKj4/5ah/D0mKoEt5Q3NUNhSWO849Fr2GLFqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIEEU8iWwJ6gZruE0lf7AZ64Nm5rqLo6ouLt4wL4EBUE00bwX20YM0FcZCwq1Z1RBRVIgIU53FMUZKxQ/9PagKzFuwYl1TQ77jYsYXh9ENFP0yU36NKvBeQ4/BkWcklZM8ZbQQmYd1rpoFU+/vTAV1li062mXALRzMjI45/SZEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t2iG3Xcf; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D03SMwhWYp4OMUkU3LsjgI19j8iPpPSZDFp4hKpj5oflOsCG2YQVq+VC/gUojanzw6ql7gdfxRtAhO7YfdwxrRfsTAJZ9J5fb8yptPz72nB5SD3/bMhgTAr6kwSvti67GreT/uiOgzw2ykPa8BsQ71myp72FzBrKCSG2v613C5K3YnlXBwvfyv8FYei+ldbEgdoiwGAgxmFcuriU9dsTEEwKHeExdVZCLPq6+tGIeQaEs4+xJ6zm26nLpTwPJ4Fsj/K+WqRQVfpP3c6oNxhVqLdn28LIyzXDWYlEBx4q30RYTDLyTfTWhuL8MovPlKtLkHDkR8LSzKRSRx/psOZt6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHwx4TPpioI/et3gOUkzZJgV6IoEnL4Hu1urthuXulk=;
 b=Pf12gygo8xKDns2KreIMLhzOMRUWVeqDlBldGdUMPE9zSew1atct4/THpgUSbPyXn5RPRBOcJgC6uFMOy6UlxCb6JWK+bbL6iO9yjgcEWStJsAfgkETO/oMsWTk/KDw2UhhRPVAPcEpy+uYgE4ttpGqYA2tR5nNTXlEZi+2aDU+ylbVdOKZOcUWwvwFszGI2ivYXJ+P9gsmqsCXBvagWU+RY+IfbJTtf9STfvvTXyoADYGyX1R7Dc/MLtvW5A4dP0e61NAHI0t7z295oiUtrXiUN9Nif/l9faZny+huopjyMjLidItVlkq6rhnWT4bdBZFUtot1xXhDHxg9FhUJbVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHwx4TPpioI/et3gOUkzZJgV6IoEnL4Hu1urthuXulk=;
 b=t2iG3XcfM0vl1YOfSBpbiSdH2u/xKR/omTLaTiqQ/slT5ho8vESIglceA9L5npCk+d9rEF4H2obWO6n1l64gRoyKwNjdoTmxIiHdUfowHp20EG40fQsE7aAqBjVl3/Toe6ZzQDvYaeXlRRNRGmhAFGy6xscQU5pOH9e+uJskZQDUNShkMqXz2WAoQjG+Fg6bS596Q+agKT1GmHXoxKqTNFJ+wpWqDmz6xS6Jt/9Vltd1m4zEQdRLpCCXObrm9CvNEy9ypk/H5LXdKNom8lXQPMEuOt7tn/B5ePkkBgtlWDj0EiTbidcMrqDz0tuQBMmY3kqnV2aRTwYB0pZ97gxHJQ==
Received: from DS7PR03CA0281.namprd03.prod.outlook.com (2603:10b6:5:3ad::16)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Sun, 18 May
 2025 03:22:58 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::48) by DS7PR03CA0281.outlook.office365.com
 (2603:10b6:5:3ad::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Sun,
 18 May 2025 03:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:49 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:47 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v5 28/29] iommu/tegra241-cmdqv: Add user-space use support
Date: Sat, 17 May 2025 20:21:45 -0700
Message-ID: <4a84673ef6fe040f1b551d059be466c2c7bdf2af.1747537752.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747537752.git.nicolinc@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f00e2d-d540-42a7-f8e8-08dd95bb49ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NN25eOpIqu73tBKRdLEXiOuKtnzk30jk2+cDvu4Yxr9ps098/yrnDmW0phIA?=
 =?us-ascii?Q?peNCH1MdJ0njSBP6DQ061TgXH+hnqT+HRh4F8Bf7x7kEzFncFjCnVEhDPSml?=
 =?us-ascii?Q?SRpp4o87B7Fui/0re5se0DaXuPhkusZ7m/kQzNLQLrQDXjdIuBXXliPG/fnS?=
 =?us-ascii?Q?aMGzQYig+l4gBhUh5oacvHb11p8FnvlJsHihz7dpav/JOWIZWJOlxAjAFuYP?=
 =?us-ascii?Q?LU+YvULNvRL8HTMUp4dfZ7sqhnn2QpiFbj1VCkro3VL9qNql0n6bRyGPiDoi?=
 =?us-ascii?Q?sROc2tmZFn+FXYN8ynBOLr5oyux/7GCcxMb/Hz69U8O0g4RKIiyEwfKSO0ft?=
 =?us-ascii?Q?3cx+2vKWkS5hdBfgiJltZLDFG7MePxuO8eKqdjCI5ecQePe3HKItPfDUNEd+?=
 =?us-ascii?Q?YaTerVy+phngeYaEU59ZDZkYi70iYynAfGyJ6pGX6eAna0uPwjlAo3hHSxH3?=
 =?us-ascii?Q?rRWtlFHAv1onfNTTXSDkOq0RkUtEo6+2FTw9bYryXM8YZ4GBkzY1i4UM6xOp?=
 =?us-ascii?Q?0FZd+yrSagVmjkfPcucW7G/kpmdKirAxnBegD1Q0J/PUcOx3oYrk3xbJXBho?=
 =?us-ascii?Q?8DBvzVFhj0IfpDDXAbyujJyKjWUDVRTLT80F7JqLNlu1Vgh5alJImFTl3Yk1?=
 =?us-ascii?Q?qeGCEB05AU5GTeGK3D1yD6lUqd37/FqFJsA1xKkWBxEPLbyCTqrln7oDdE19?=
 =?us-ascii?Q?wGBpndwKoiFuYJvdIwUVpwr2X0RbJ1rGU4dnJs5inCk/t2hV5ABwUwp0mD7F?=
 =?us-ascii?Q?I9gLxuusR0mnn/XC1yUsANdVmfDdmE8UBvi2ctctwyxwo8yr3taKUgPa0F1a?=
 =?us-ascii?Q?2+lyc6T22YCDH9QDZelaE+i45PM7/wu62FjYaih7vJ9u1ZUiwh+HewZ2bLjs?=
 =?us-ascii?Q?eewJkWFs6oeQCBRU2fxkYr3+oDCDNwN+esgAZlfzNejmBWDQ7JsyWWVxIm0Z?=
 =?us-ascii?Q?znOYI4BlM0ay9fj/BLp/evCFWiZjRx3gA8LYh+VkZ0OBxmv2jzuU2HeDtntM?=
 =?us-ascii?Q?hiFbuIm9qLdeeTYmjGa8ebUlXEgGmC7bqs+Aet2QVAXpOgaBjA6iOOdjttbL?=
 =?us-ascii?Q?BQR8sJR7ksw+NT8GSKFwyhftWrsvVW10mxFSNyPN0tEiqz29U7oGCy33PZJb?=
 =?us-ascii?Q?ToasjqN8plVS8pBiEyZ47EF76jmmcH4MgxJ0b/wAWSVixban91GhZV2v+9QV?=
 =?us-ascii?Q?G3jUTXXbaGC3wvqD6dewS+2oqgtCVMm386tTBO6vAzmA1ZJ0JejrkHDmusPV?=
 =?us-ascii?Q?0BJBCyOoUILZ2+fmESulH7Uq4VL7dUE1i8GOp9sOnJMRsNdLKtu5daMiN3sQ?=
 =?us-ascii?Q?fCFFlVKx7U9f65iOdVlVwuaLYIyAFbdGEZkFdzqr2B4FQphDDtBbcluo6+hT?=
 =?us-ascii?Q?gVw3vPh2TJJU7i9GIzF1ngyZD1lnZGUpfqiqo6037938v/kkuobFMfZ9NAhM?=
 =?us-ascii?Q?3uXvWfxpkNvPSOUb9J9w7YJMxbiL+h97JoA4z2uYlW9R4k03gq6BBbOemUXr?=
 =?us-ascii?Q?h7WbCJqsGdDFBdOE/fcQKQ59axVv2qjptdQ/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:58.6857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f00e2d-d540-42a7-f8e8-08dd95bb49ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705

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
 include/uapi/linux/iommufd.h                  |  58 +++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |   6 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 419 +++++++++++++++++-
 4 files changed, 491 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 8328c8cc1899..187c47370652 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1001,6 +1001,14 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
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
@@ -1077,9 +1085,16 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
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
index 7bcd3912180a..8a9090cc938f 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -591,6 +591,27 @@ struct iommu_hw_info_arm_smmuv3 {
 	__u32 aidr;
 };
 
+/**
+ * iommu_hw_info_tegra241_cmdqv - NVIDIA Tegra241 CMDQV Hardware Information
+ *                                (IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV)
+ * @flags: Must be 0
+ * @version: Version number for the CMDQ-V HW for PARAM bits[03:00]
+ * @log2vcmdqs: Log2 of the total number of VCMDQs for PARAM bits[07:04]
+ * @log2vsids: Log2 of the total number of SID replacements for PARAM bits[15:12]
+ * @__reserved: Must be 0
+ *
+ * VMM can use these fields directly in its emulated global PARAM register. Note
+ * that only one Virtual Interface (VINTF) should be exposed to a VM, i.e. PARAM
+ * bits[11:08] should be set to 0 for log2 of the total number of VINTFs.
+ */
+struct iommu_hw_info_tegra241_cmdqv {
+	__u32 flags;
+	__u8 version;
+	__u8 log2vcmdqs;
+	__u8 log2vsids;
+	__u8 __reserved;
+};
+
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
@@ -598,12 +619,15 @@ struct iommu_hw_info_arm_smmuv3 {
  * @IOMMU_HW_INFO_TYPE_DEFAULT: Input to request for a default type
  * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
  * @IOMMU_HW_INFO_TYPE_ARM_SMMUV3: ARM SMMUv3 iommu info type
+ * @IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
+ *                                     SMMUv3) info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE = 0,
 	IOMMU_HW_INFO_TYPE_DEFAULT = 0,
 	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
+	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV = 3,
 };
 
 /**
@@ -966,10 +990,29 @@ struct iommu_fault_alloc {
  * enum iommu_viommu_type - Virtual IOMMU Type
  * @IOMMU_VIOMMU_TYPE_DEFAULT: Reserved for future use
  * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
+ * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
+ *                                    SMMUv3) Virtual Interface (VINTF)
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
@@ -1166,9 +1209,24 @@ struct iommu_veventq_alloc {
 /**
  * enum iommu_hw_queue_type - HW Queue Type
  * @IOMMU_HW_QUEUE_TYPE_DEFAULT: Reserved for future use
+ * @IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
+ *                                      SMMUv3) Virtual Command Queue (VCMDQ)
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
+	 *   a single huge page with alignment of the queue size, and limit the
+	 *   emulated vSMMU's IDR1.CMDQS to log2(huge page size / 16 bytes)
+	 */
+	IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV = 1,
 };
 
 /**
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 837f15e2d40f..4917e5b6f562 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -224,7 +224,7 @@ static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg,
 	return 0;
 }
 
-static struct iommu_domain *
+struct iommu_domain *
 arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 			      const struct iommu_user_data *user_data)
 {
@@ -335,8 +335,8 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
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
index 869c90b660c1..49f07f61673c 100644
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
@@ -699,10 +782,44 @@ static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
 	put_device(cmdqv->dev); /* smmu->impl_dev */
 }
 
+static struct arm_vsmmu *
+tegra241_cmdqv_alloc_vintf_user(struct arm_smmu_device *smmu,
+				struct arm_smmu_domain *smmu_domain,
+				struct iommufd_ucmd *ucmd, unsigned int type,
+				const struct iommu_user_data *user_data);
+
+static void *tegra241_cmdqv_hw_info(struct arm_smmu_device *smmu, u32 *length,
+				    u32 *type)
+{
+	struct tegra241_cmdqv *cmdqv =
+		container_of(smmu, struct tegra241_cmdqv, smmu);
+	struct iommu_hw_info_tegra241_cmdqv *info;
+	u32 regval;
+
+	if (*type != IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	regval = readl_relaxed(REG_CMDQV(cmdqv, PARAM));
+	info->log2vcmdqs = ilog2(cmdqv->num_lvcmdqs_per_vintf);
+	info->log2vsids = ilog2(cmdqv->num_sids_per_vintf);
+	info->version = FIELD_GET(CMDQV_VER, regval);
+
+	*length = sizeof(*info);
+	*type = IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV;
+	return info;
+}
+
 static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
+	.supported_vsmmu_type = IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
 	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
 	.device_reset = tegra241_cmdqv_hw_reset,
 	.device_remove = tegra241_cmdqv_remove,
+	.vsmmu_alloc = tegra241_cmdqv_alloc_vintf_user,
+	.hw_info = tegra241_cmdqv_hw_info,
 };
 
 /* Probe Functions */
@@ -844,6 +961,7 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->irq = irq;
 	cmdqv->base = base;
 	cmdqv->dev = smmu->impl_dev;
+	cmdqv->base_phys = res->start;
 
 	if (cmdqv->irq > 0) {
 		ret = request_threaded_irq(irq, NULL, tegra241_cmdqv_isr,
@@ -860,6 +978,8 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->num_vintfs = 1 << FIELD_GET(CMDQV_NUM_VINTF_LOG2, regval);
 	cmdqv->num_vcmdqs = 1 << FIELD_GET(CMDQV_NUM_VCMDQ_LOG2, regval);
 	cmdqv->num_lvcmdqs_per_vintf = cmdqv->num_vcmdqs / cmdqv->num_vintfs;
+	cmdqv->num_sids_per_vintf =
+		1 << FIELD_GET(CMDQV_NUM_SID_PER_VM_LOG2, regval);
 
 	cmdqv->vintfs =
 		kcalloc(cmdqv->num_vintfs, sizeof(*cmdqv->vintfs), GFP_KERNEL);
@@ -913,3 +1033,294 @@ struct arm_smmu_device *tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
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
+static struct iommufd_hw_queue *tegra241_vintf_alloc_lvcmdq_user(
+	struct iommufd_ucmd *ucmd, struct iommufd_viommu *viommu,
+	unsigned int type, u32 lidx, u64 base_addr, size_t length)
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
+	vcmdq = iommufd_hw_queue_alloc(ucmd, viommu, struct tegra241_vcmdq,
+				       core);
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
+			return ERR_PTR(ret);
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
+
+	return &vcmdq->core;
+
+unmap_lvcmdq:
+	tegra241_vcmdq_unmap_lvcmdq(vcmdq);
+	tegra241_vintf_deinit_lvcmdq(vintf, lidx);
+undepend_vcmdq:
+	if (vcmdq->prev)
+		iommufd_hw_queue_undepend(vcmdq, vcmdq->prev, core);
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
+tegra241_vintf_alloc_vsid(struct iommufd_ucmd *ucmd,
+			  struct iommufd_viommu *viommu, struct device *dev,
+			  u64 virt_sid)
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
+	vsid = iommufd_vdevice_alloc(ucmd, viommu, struct tegra241_vintf_sid,
+				     core);
+	if (!vsid)
+		return ERR_PTR(-ENOMEM);
+
+	WARN_ON_ONCE(master->num_streams != 1);
+
+	/* Find an empty pair of SID_REPLACE and SID_MATCH */
+	sidx = ida_alloc_max(&vintf->sids, vintf->cmdqv->num_sids_per_vintf - 1,
+			     GFP_KERNEL);
+	if (sidx < 0)
+		return ERR_PTR(sidx);
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
+static void tegra241_vintf_destroy_vsid(struct iommufd_vdevice *vdev)
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
+	.flags = IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA,
+	.destroy = tegra241_cmdqv_destroy_vintf_user,
+	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
+	.cache_invalidate = arm_vsmmu_cache_invalidate,
+	.vdevice_alloc = tegra241_vintf_alloc_vsid,
+	.vdevice_destroy = tegra241_vintf_destroy_vsid,
+	.hw_queue_alloc = tegra241_vintf_alloc_lvcmdq_user,
+	.hw_queue_destroy = tegra241_vintf_destroy_lvcmdq_user,
+};
+
+static struct arm_vsmmu *
+tegra241_cmdqv_alloc_vintf_user(struct arm_smmu_device *smmu,
+				struct arm_smmu_domain *s2_parent,
+				struct iommufd_ucmd *ucmd, unsigned int type,
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
+	vintf = iommufd_viommu_alloc(ucmd, struct tegra241_vintf, vsmmu.core,
+				     &tegra241_cmdqv_viommu_ops);
+	if (!vintf)
+		return ERR_PTR(-ENOMEM);
+
+	ret = tegra241_cmdqv_init_vintf(cmdqv, cmdqv->num_vintfs - 1, vintf);
+	if (ret < 0) {
+		dev_err(cmdqv->dev, "no more available vintf\n");
+		return ERR_PTR(ret);
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
+	return ERR_PTR(ret);
+}
-- 
2.43.0


