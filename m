Return-Path: <linux-kselftest+bounces-25152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3D3A1BFD1
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 01:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5C11886AE0
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 00:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8AA1547D8;
	Sat, 25 Jan 2025 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EL5M6w+I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83A17C2;
	Sat, 25 Jan 2025 00:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765091; cv=fail; b=BsPq+P8rgRkPP+yh2pJKM06/RagY3yKsD5vMViqILaMgGuUzNQvsWkF9lcl2S1FDryN8L8L+r+B+bZFVKvf+ICDrg1lODK9tI2ikHQjl0vaqyxSoTmeorvVXw+mPZ5QKU++LVP/9a9vaxBDQNAQyIfNbu6uw9L+RZDSPAjqwKAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765091; c=relaxed/simple;
	bh=UzNulkwCBjs9W9NgOeLuN364iBzi15WOMUn2EfhBf0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uh0fpgSjivA7GGMH2LOEPSO31Wezf69Jcf6+PAjOvZ5J6qDezXmKEv9zAAA1UIAY7fZgwaSDmZGtrdoT1JdliEjuRRtpfOUOA/rGqOMbJ6TBJA6s6WL8IxvIsMy09x9FjdB0sH5xEGt+5LW2U7lnMVz7lERugeP5lXYAsDk6JPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EL5M6w+I; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZhN01//hFqHkG3EPjq7WP9ouWJjO6p74Ft/RSApiz96dgJq49YR4r4Rhd/NLDRvtzia/HywKW9YQAv5e77C7paTiIVXQNWUtk46KEOQBI96/0Gxit2M69ppxJwmVrP4upuJm+EOdyoiC3/mHWim4hC0j9ZpBEzLYf3NcfYJE2wZDqsAFFfYlMosepkOVS/lFxPJ2d5PY5678LKwhzx042sTrD7hQ93caWwizUW5JcVlLnvBPmF0O2UvQTxS2arjVAt/A6mWXSXVPo578PRPvcQ9XlwtfwhY3PY4O7tzfo1LVfqtSnUaOGFNh6/6Jgp9+u70Q+EZEzSOgwUfEhaVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6B1qk0FhIAz7yoZNuejvkiVETda54KM8i2pXYDXu3Q=;
 b=SsaiPrDGLdZGU8TypWiWNHB/R/AnU10F2A+WHnyV4kTH3mGVi6wLKO0lIRty3zY0gvB8lEiOeHlu6zyURinS/+iTIkErqbe+QKDw3aKdiEJ8MouRCWFB8DpKOk+OgvuwWOX2+9Ge8hl6Ud3vHosPQU8HSADAlj8lTyPETmJFoN+a5znqVTVhlkY2eCO2k3pRvhEFZ5xBGvBn9JmvDDsxnZdVooL+cz59VpuXzGUIBKEyvU55mK3iUKr2Xb7/Eza2K0ofZPNGOanB/KGse+x4jshslWyiEDztm8tqCRj0whWXdI0xb6o5KjLgaLIqp360QnnxPzmy0SUbo5NceEVNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6B1qk0FhIAz7yoZNuejvkiVETda54KM8i2pXYDXu3Q=;
 b=EL5M6w+ImOQG77IpnGh7I70ffLffYqmyS/U+SspzZpHkxH+/nxr9K7/vx7WuoqESbSqqTU7nraUJxpS3VYNTCFevfnZNt1tjzN0d6BjzN9PmncAyoVNBuXFmhtaXkzk06Lgw33a24ueVv6Q3PGUIl51QtqvaoZl6mi8w75gDvh0erdgpaqwomypxhW5TvmdMxhCpiUJqNxR08CEFD4vh2vnGH9NeWUr+nls8CMkpYKcVJXSJwcle6XmWviT2sacuTtyglzcies3091qxsURns9pYdLaKkZRUDC5CJtfKhFqGU3/kXWW5Fp0EpC/OhSzHTIPTOLXxnq56R3U0H4sRtQ==
Received: from MW4PR04CA0274.namprd04.prod.outlook.com (2603:10b6:303:89::9)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Sat, 25 Jan
 2025 00:31:24 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::eb) by MW4PR04CA0274.outlook.office365.com
 (2603:10b6:303:89::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Sat,
 25 Jan 2025 00:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sat, 25 Jan 2025 00:31:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 16:31:12 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 24 Jan 2025 16:31:11 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 24 Jan 2025 16:31:10 -0800
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
Subject: [PATCH v6 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations
Date: Fri, 24 Jan 2025 16:30:43 -0800
Message-ID: <436ac2021bb3d75114ca0e45f25a6a8257489d3b.1737754129.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737754129.git.nicolinc@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a4fae67-985b-4771-d833-08dd3cd798fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mSTpPlMOIb2jOSEzWGqb2YHmEnt7rUDJCNsZiu5J44gpoa3tjbayvJjOvoxR?=
 =?us-ascii?Q?xIollgb6wSeRPRiOOef2yqoQYCwfOXFvMSiQ5wV75Zp6SnuEVrnNmXtZYSDc?=
 =?us-ascii?Q?2PA4rRe93d3JDbzYfPi0v+WAAB4ejtABtLFSDngUNjD/n7PhIOr4HYX9KfU5?=
 =?us-ascii?Q?wvXyi+N/Uy2RH9cmDzQ1tWVpCc/+PamLLKxIVVEf6LvKhlTizIKTXPTFc9wO?=
 =?us-ascii?Q?5RACLMTn+ctHs7paQl4y+vhGt0tauFnvZ/1Ux2Z4T9K3zUtPoD9SMSD67ACP?=
 =?us-ascii?Q?jaNLyCYN9NH7WJ6aUwPGRekoSWN7UHrLa6d9dTWoTdKKTXW987X7t3AP8ZkZ?=
 =?us-ascii?Q?XKys7WrDrLdENmt+x7BX8OXu3XsNqgpWgaOLUuidC53Dr66UNU2r1g0xcIiZ?=
 =?us-ascii?Q?G+kbSDIYfdirPyXgzCEP07jw9PNeDSFk1o1YNW5ZJTCyuMMjRr6Da2HKPCk3?=
 =?us-ascii?Q?3o4fbZBSJN2jt2vinxoAnnZdkp1IuM1CV/EQYeIP4KByb2sj2T/8s9ALMN0I?=
 =?us-ascii?Q?QdSi2XTJrVeYnFGbiQuYS3ZZWaRrlTQ9rIeyE8hm8NXWNvByfT4qQtSRi4Ze?=
 =?us-ascii?Q?RF7bFMgMhpfoO0CNRI4CjrjWsbMCrGruyPRgjMcimw0yApBhW5oDt3DInJS2?=
 =?us-ascii?Q?ZiAzUGkk/raP8AyTBaIifayM+fWFTrJKgQ2NQ+il1YXUJvwMVuL5mu3eCoDb?=
 =?us-ascii?Q?vGwLJmAxVm8XPb6rpK19j60BlweuCc54MidVrYvp2F/tcz5fPqP+zwCVgNXq?=
 =?us-ascii?Q?8CYprTw3EzFbVvo3inNlEK/WtqDd3ehE50JQ3AalRXPJIQ37KPvcTAFjAcfL?=
 =?us-ascii?Q?F6VNH2nsN9iEX0m/L9oEPmuM5fkyzxHDn6xaTcJ3c17l9/l3JaKla4VKEv+C?=
 =?us-ascii?Q?qAv/v++c0Dps/Zc2ieJ0gikFEZzPLCU91qt2qUcdrow8mQq14xVwxhLX6T1t?=
 =?us-ascii?Q?peZk5C/QvssE1II4qYw06u3p2gm4ozGccNQrInAR2qBXWnxtgXYpAMUYiq15?=
 =?us-ascii?Q?vtvCfW3Nu52NycX1Sk2BTf/SOZNaeVYiJeScDsIUg3RurVCBo0uFyV+2uxiY?=
 =?us-ascii?Q?uu+TF5RF9IWtD0ayNNsq1UUUyE4nrXvJmzBu//vJ6O+4MxnYxPUx7GB3AmPI?=
 =?us-ascii?Q?VAZ6x/NO8HgyIWdx7it5kupH0Xz+gm62QFfAGGTCSMNrbungdbcMHridsREF?=
 =?us-ascii?Q?8ins8uyUBx6Plz2Af4Nm/zsA836/agzFx7GOxBEk05v9/qBGh7QHuyl4dSXr?=
 =?us-ascii?Q?1+2/nrZYjtLTSQ2ej2YW9ou2kul50aEmK2iIajJBxDSGibmX1DuoBxpAXwra?=
 =?us-ascii?Q?lZ8xsl/YHrnzhtLOt0u3R2Je63/+ZrXwhDb40AIWXBeag8ftf3hr67zYzIm2?=
 =?us-ascii?Q?iXm6ZOw8mCdYsSGjJID+KRCGG+y8dWxazQallR5IeGDRFiCNrjKVgwwPPwDG?=
 =?us-ascii?Q?hj5IfeXt9zHGvbe8noI125R4YoAqoB2bjhUjsx4wz4Ug4cltPgw9Vvf1ROxv?=
 =?us-ascii?Q?DN4ZeSBINcnjdZQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 00:31:23.8599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4fae67-985b-4771-d833-08dd3cd798fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149

There is a DoS concern on the shared hardware event queue among devices
passed through to VMs, that too many translation failures that belong to
VMs could overflow the shared hardware event queue if those VMs or their
VMMs don't handle/recover the devices properly.

The MEV bit in the STE allows to configure the SMMU HW to merge similar
event records, though there is no guarantee. Set it in a nested STE for
DoS mitigations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d24c3d8ee397..7181001fc5d7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -266,6 +266,7 @@ static inline u32 arm_smmu_strtab_l2_idx(u32 sid)
 #define STRTAB_STE_1_S1COR		GENMASK_ULL(5, 4)
 #define STRTAB_STE_1_S1CSH		GENMASK_ULL(7, 6)
 
+#define STRTAB_STE_1_MEV		(1UL << 19)
 #define STRTAB_STE_1_S2FWB		(1UL << 25)
 #define STRTAB_STE_1_S1STALLD		(1UL << 27)
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index ceeed907a714..20a0e39d7caa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -43,6 +43,8 @@ static void arm_smmu_make_nested_cd_table_ste(
 	target->data[0] |= nested_domain->ste[0] &
 			   ~cpu_to_le64(STRTAB_STE_0_CFG);
 	target->data[1] |= nested_domain->ste[1];
+	/* Merge events for DoS mitigations on eventq */
+	target->data[1] |= STRTAB_STE_1_MEV;
 }
 
 /*
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 59fbc342a095..14e079cfb8b6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1051,7 +1051,7 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 			cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |
 				    STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |
 				    STRTAB_STE_1_S1STALLD | STRTAB_STE_1_STRW |
-				    STRTAB_STE_1_EATS);
+				    STRTAB_STE_1_EATS | STRTAB_STE_1_MEV);
 		used_bits[2] |= cpu_to_le64(STRTAB_STE_2_S2VMID);
 
 		/*
@@ -1067,7 +1067,7 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 	if (cfg & BIT(1)) {
 		used_bits[1] |=
 			cpu_to_le64(STRTAB_STE_1_S2FWB | STRTAB_STE_1_EATS |
-				    STRTAB_STE_1_SHCFG);
+				    STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV);
 		used_bits[2] |=
 			cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
 				    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
-- 
2.43.0


