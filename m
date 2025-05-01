Return-Path: <linux-kselftest+bounces-32134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40CCAA6736
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4524C6639
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D72F28031D;
	Thu,  1 May 2025 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DeN3/2bV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261BF2741B2;
	Thu,  1 May 2025 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140571; cv=fail; b=GUXhrUdMAELE4m90HJr8rTJnPj2SG6mGMRX7Hl+ElNOCnTE+S7MjzA4Wex5kLKABI/r0Ys6b9cpPXGmIoRE9XuWY1ca+y7ksM7FMVhw2jkM/uEliu0RiwEvXruq6h56SofBtf1mqKjSUixDLw6JbghSbcqn1hP8QuTXjJoRNsvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140571; c=relaxed/simple;
	bh=WEvvMuzWk1rRHkJO51weeyCTxyJ/4JVlAk8/EoHNCew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaP8sCnE1kDHZGt6ELNarCCNCTl3W6f2ci1OBq/FRVqFDx6Yw4AIAGaR0rtmfAppuI2wuoK2ZvfvZfn3L/gldOiK/pFJXneXLPLX3OPgh3UsdDHNxHnkgzMWvKFXnsMnoPiHHLo/OkGie6O1PNGe+Ui/yDNFG6Slx+DfL/LtXbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DeN3/2bV; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdrtnF4FvHYbo0FPIQfo0JEUURaZEQjO0CcZ9YKiM5OTamahYA27V5fGccALYwvRtG7/LZVZY4R655WUn0Jit221D/bObDsVhaBsqmFkJcegj49mq+efCzbOhPoOg1p8Q3gg9u64lRWRwy6zwsCAPnwtN0uEtS6tneR/6L1lNWLvclCx/EPXjmz1zMvbi6E83Cb4vin973jPGeyRWhzTOKUTr6P9eKemb05axPN/6NQa2xjB1ZxXNddK8hcQbDTgQSMqbX/JYZ7jRSpztnQuZnLMJXk3yvMKMf+ySFJjIhwBR2F2FW0NSiERdyENAsVf6VpVrDtenAwC7PtRw/NjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DruHZ3iepKcAf+LrePtJHN4EJt2ZcdyBqN033353rA8=;
 b=eYw7AFM2DFNJZyu95sz9L/KM4Yse+EaXPh4NmEHTZlMKqO2vw4CLHJ7NUgk5s9PyBPXOF0SSYzVgv2YYrmdn6btURvDzpsSVLx9TkxwseZUgohH4nQET5RVcHiSXNh1DMrIPfH9I7bQOp0Yb2OtBc0rA8mGUgVNtjUG7q3+JW2wc6OJUt76/poOZD8NOpJiNXBed9C9OvttuaMtY7PCpNifmNuD9LmBvIXxF/92aFIcA1pTGjpgb9ibmfQQ4xDbimsmjj2GxzbAOJs09SagoC4Gp30C8lvgcMD25luwQ4YnZ8y3uzkwKlSXUmYle+/lOf9hiYsnCNT9YBu30v5hLAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DruHZ3iepKcAf+LrePtJHN4EJt2ZcdyBqN033353rA8=;
 b=DeN3/2bVmtMs3TNtVRNDKnm3qjY5kRzx0VsOpj4FmPaAsHIU1MyzQZ0f+ys9cgF5UDsuXRST2+6ZQjw517CZTpX3Wb9rSCUMu5Pd+cfBcnM277nar/HYP8k6f2A1JUZ8SZ+jpPWxjaiNAYHCCafTusesTtpDiQqnlXjEhUV0ioPeseaCryV1hEabPiVa3xYP7RvBdjWwzY3OnhmnBcuvGjXI9iaV6MnXA3QUogJVvoVqJHSsPQq6kHrEDB7W6phU8y+ZfiouErmw4/pI4MPshHbhzZacBEjExZzNcfNLQyvaULV6HcFeMNHCwCPVHGQatBCjzttLM0fV/XBHbzvCyA==
Received: from CH2PR02CA0019.namprd02.prod.outlook.com (2603:10b6:610:4e::29)
 by SJ0PR12MB6808.namprd12.prod.outlook.com (2603:10b6:a03:47a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 1 May
 2025 23:02:43 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::1c) by CH2PR02CA0019.outlook.office365.com
 (2603:10b6:610:4e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Thu,
 1 May 2025 23:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:43 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:02:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:02:29 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:02:27 -0700
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
Subject: [PATCH v3 23/23] iommu/tegra241-cmdqv: Add IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support
Date: Thu, 1 May 2025 16:01:29 -0700
Message-ID: <359be8b10c75d2831f557d21affbbd49148c88a2.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SJ0PR12MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 61930f20-8d18-4b3f-8acd-08dd890447e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gw6iOSThdzCv8cee7l1wNA5Oc9+7NHJFi9p54wSpjvAFhI5Z4h6bgD7elRhL?=
 =?us-ascii?Q?oY+TupiM8Wurjja5zhT97r1HRPC1MjIJUYuYp+5HE7od9JnU+FHJcAxmbkIb?=
 =?us-ascii?Q?b62UsWMazD//FxTMK+q+xIrSr9U31d+sWCMzzMg1jBs8c6ky3DLeFKDyBC1T?=
 =?us-ascii?Q?pmIQchNds8uSXVPEBJ3yHvMDEwuifKcI65rKUCrckqo79IqWcSWckulZyLgp?=
 =?us-ascii?Q?ECY3wEOjLllnfpxUIlhlYEbk9CgUw91eyR+MtSaqcknZX3ZeClhS+LSeRJ4r?=
 =?us-ascii?Q?bX7SlFdXXWWV8RZrrDy4h125SAmV+FyLcLGnTxSxowUekhmRxXGBHXYhyFaM?=
 =?us-ascii?Q?zJkuwgEbjVczHPbhTF+3fAEvTGHQCPzWRYYzW+bd92aRhEOwIIUKZkI6Pc97?=
 =?us-ascii?Q?OZ/68Ve19RYurLGRG5Ptz3R3Wtk9W4CleEI/vlarjYxNnTqR0wM5sBDvfw0U?=
 =?us-ascii?Q?pTERRf4ISQx3fo29bhaz1psh5Q1viT1jdzSRkJKbaWEhJv4NS6TNPiMEKXJD?=
 =?us-ascii?Q?V5QQ0y++nBImJK4W/p1J7f8HUB9impnC2Js2aKU0NnRH9CPZCpBNcVtQLXG4?=
 =?us-ascii?Q?wlPfG5I/ZTnc1sRNbPiEjxMu+8Yc8bXfv9Paxy8E7P1DGzDxprggPdCcYG2i?=
 =?us-ascii?Q?rVkR88QGnG2JF0d5cXbWLqPJmXPIcAz6b+5zP15ApfyPxv78xJe/rgyA4Xz2?=
 =?us-ascii?Q?fJjLNXEsHYszOxnGrUAdyBN2s+GH9c2QWoHB6p+kUmp6XgFPAW1nLBuSzPjN?=
 =?us-ascii?Q?dSjD3WqWJkT/6zfb9sqbPrw/Msa5id6EHvra/lsiTXp59HjCnhxFOf24CAOB?=
 =?us-ascii?Q?KC1EtRwS4OpbSSOKHMorZ1XC5aOk9MhC5AxlEcHfM1kx8Ktbtm4iP5QdiLjp?=
 =?us-ascii?Q?h5xTUEv1DlxtZmxk6ALEKX6TwX9n8EEjiyI4vdrpZO1yLqvgJ1tbADJ1VCU9?=
 =?us-ascii?Q?9tb5GfYWb47H7FWt6WLx9+pcprW9osp7A8gqMDdEirN5BVPwX1qQV8h/ZoeC?=
 =?us-ascii?Q?v8UikeukMuO6dzRrsITKdr/YOAcGb1u6zKjgou+Fohynxq4BkrQ2AzOo3GxH?=
 =?us-ascii?Q?qiboGmUyVTo4i0fVjKp9OH3LtJTH74anAsQmWfidzEJELmSh3T6jB72dgRE8?=
 =?us-ascii?Q?64F+8u0DFIysZhvK8womv80y86Kizy7+LySsKiVgHYp7xQe2j6TnwjntPCGp?=
 =?us-ascii?Q?6aRDTcskoyIQ5DU+65szKHgma8Iwi/0v4IOfZjtBrpXRYKQXzj/rCgvqDO1f?=
 =?us-ascii?Q?4pMv0rHjeXPLHauWpTVUm7F4TsRxAq++Utd2hUZ1jFr39qPkBhls9VDfuHQp?=
 =?us-ascii?Q?cSUf91CFL0Pf3QP2x1KJKv4YAN4EpvqC/wW60Uh2jlUQ89UVsaq9CJbNOXf8?=
 =?us-ascii?Q?2pDu6mTfTvk/6CxichslfdMlwVVU6lYdcmkk4UiNzyMsZ+55p0RgPuHVsgeu?=
 =?us-ascii?Q?hlqDiVk65pjnJC5D4zDZiufBC6zPCfM+3BimWU4O9MMhti5tE563Q60Kx5mj?=
 =?us-ascii?Q?C9rRw2ueSbRjhj8au56/U8IM9zIkvvcsFH8E?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:43.4273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61930f20-8d18-4b3f-8acd-08dd890447e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6808

Add a new vEVENTQ type for VINTFs that are assigned to the user space.
Simply report the two 64-bit LVCMDQ_ERR_MAPs register values.

Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h                  | 15 +++++++++++++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 22 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index e5400453a82e..6f269e3c48d5 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1114,10 +1114,12 @@ struct iommufd_vevent_header {
  * enum iommu_veventq_type - Virtual Event Queue Type
  * @IOMMU_VEVENTQ_TYPE_DEFAULT: Reserved for future use
  * @IOMMU_VEVENTQ_TYPE_ARM_SMMUV3: ARM SMMUv3 Virtual Event Queue
+ * @IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension IRQ
  */
 enum iommu_veventq_type {
 	IOMMU_VEVENTQ_TYPE_DEFAULT = 0,
 	IOMMU_VEVENTQ_TYPE_ARM_SMMUV3 = 1,
+	IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV = 2,
 };
 
 /**
@@ -1141,6 +1143,19 @@ struct iommu_vevent_arm_smmuv3 {
 	__aligned_le64 evt[4];
 };
 
+/**
+ * struct iommu_vevent_tegra241_cmdqv - Tegra241 CMDQV IRQ
+ *                                      (IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV)
+ * @lvcmdq_err_map: 128-bit logical vcmdq error map, little-endian.
+ *                  (Refer to register LVCMDQ_ERR_MAPs per VINTF )
+ *
+ * The 128-bit register value from HW exclusively reflect the error bits for a
+ * Virtual Interface represented by a vIOMMU object. Read and report directly.
+ */
+struct iommu_vevent_tegra241_cmdqv {
+	__aligned_le64 lvcmdq_err_map[2];
+};
+
 /**
  * struct iommu_veventq_alloc - ioctl(IOMMU_VEVENTQ_ALLOC)
  * @size: sizeof(struct iommu_veventq_alloc)
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 6bbc85886f79..df0497d571a9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -292,6 +292,20 @@ static inline int vcmdq_write_config(struct tegra241_vcmdq *vcmdq, u32 regval)
 
 /* ISR Functions */
 
+static void tegra241_vintf_user_handle_error(struct tegra241_vintf *vintf)
+{
+	struct iommufd_viommu *viommu = &vintf->vsmmu.core;
+	struct iommu_vevent_tegra241_cmdqv vevent_data;
+	int i;
+
+	for (i = 0; i < LVCMDQ_ERR_MAP_NUM_64; i++)
+		vevent_data.lvcmdq_err_map[i] =
+			readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(i)));
+
+	iommufd_viommu_report_event(viommu, IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
+				    &vevent_data, sizeof(vevent_data));
+}
+
 static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
 {
 	int i;
@@ -337,6 +351,14 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 		vintf_map &= ~BIT_ULL(0);
 	}
 
+	/* Handle other user VINTFs and their LVCMDQs */
+	while (vintf_map) {
+		unsigned long idx = __ffs64(vintf_map);
+
+		tegra241_vintf_user_handle_error(cmdqv->vintfs[idx]);
+		vintf_map &= ~BIT_ULL(idx);
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
2.43.0


