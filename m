Return-Path: <linux-kselftest+bounces-35001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A99AD9AF9
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7006516ED29
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95917246BB4;
	Sat, 14 Jun 2025 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oPfpJCYl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0B2241674;
	Sat, 14 Jun 2025 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885367; cv=fail; b=U2hcuXAl+Cg3fG2lYPQLhbKFj9P1XGzqJKwF0ltILxSC/cbKHIdrOXtXTzJ0/V2tT9+sU89/J4pQjMGRO/R8+Jb7RPmM+wpq/mB+2XcKI7pcbI5s6hZOqt72XhiYfbh0Y+a3N+grKuDkfWgIv07ERQCGckJxC9MG0Vh2WWm3su4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885367; c=relaxed/simple;
	bh=gRLw0cJE+VEV7nV2K3jp28dfRu7beppzK1rx7d+susk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9BhpuIX9S1k5AFaJ+dlgHGQagzdipYEWLez0zaAZM/619kebs7A0SkOnTHCa92MXMVEiv9EhFeWcorXVlvwnP5BYHR9Sam6P7UoI3zg+nXKzFJtBVyaICJRteQ6Fur8ZfqtGULFdv433MohbQZLCvIPXU2Ul15lE5CVgiV+OxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oPfpJCYl; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AB+Wm2MSj2B4RHtVPcfp0VS1J+ePrxUU8IGJvNtm9CoLsRP4qrZjs/rImeoYWQ2L5LWNlVow9qSeBP+5BTewrzy2sud4Luv85dOgy0ndUZKHI7ejAx/BUx6yngV2h8JPXiq//Mdya/xofUMLaS+rY0KU+jbrr7enkmeK5LLI5kLD4XlQ2568cUY5cPWJjXC8XnXkIFvsXLyVO1nUzsX7u0jqnEPJimHxUFatoDKYnVIOOZSJkg69CiOUuBLBlhx3lLh0MMbuyfJqe1odMm8MLC1Ze9Vu4O8r9GLfYUVyNnHXtXG1dREHKv+BWWcmLmwNnhpl/RzDhmPBngU6FtmkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qUPndBHX/DhgeFzfajcvPFX/HRcvZo+v9JzNaViI3Q=;
 b=V2xSVJS1+lDOMNZBik0lBTOWTisDxkpsGP5zuFMJ+2PKNGvLPRh8qOgLJW446WZGe1S59FEraZ3SzlEJwxZOQT2PpPqXL/oDSypNiGkmV92jYIb/katKu6VFAck0ULY2uksvXJbDiZlbob9rZVxvKfXt4cUhF5bIHszN343ygwnBnKm9n6gGrqSVbiMJBm6/phWh3cGsbqrstX+BLNpkXn6zSr65Ai8vXYGiflwzD5YdfGP2IQ4VjmlAd5uauIz9PTvAe6YOcYd8ddw0AM1XtjUgTfbOBQzXjMk9cN8uOwBUCbuovJpVEvAkULa4KwfD/N/bQa0QWPNUX0BHt1AIaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qUPndBHX/DhgeFzfajcvPFX/HRcvZo+v9JzNaViI3Q=;
 b=oPfpJCYlw6FqrFIIKArbO6bYNJ734Eehb3L1TnwJZSHpNbETnhO+jZtV73uLgfV9KMHZ6WzvOMhoJ8S/t/lDwQ7hkhnZlf619LVBAy87ZXsXA4FDiQSxILqBwX2ZcUnQziELY1UYGDELbTnE9HSnwsV7Nnc6zt5PhX5QZSWPuqB+sAGkXtn3bCIe2AsTW9Kcqh5kIbZjMIuTuyzmaOyErUoWv/Q9VFxYQrLgXgQ88akRyiWafcnYPHnrfLpq70XNE9DPLlUOLMJTtedDO5LnhpD1CKsxzVJwFDafByUzWwtkSTIWFdJ1qsAAL20HiT4YsgaS4fOx9FULwXZvij8aPg==
Received: from BL1P223CA0031.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::6)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Sat, 14 Jun
 2025 07:15:59 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:5b6:cafe::2) by BL1P223CA0031.outlook.office365.com
 (2603:10b6:208:5b6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.28 via Frontend Transport; Sat,
 14 Jun 2025 07:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:47 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:45 -0700
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
Subject: [PATCH v6 25/25] iommu/tegra241-cmdqv: Add IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support
Date: Sat, 14 Jun 2025 00:14:50 -0700
Message-ID: <35c3f8f83d6bf5544d3982619ff1d7919b67fc07.1749884998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749884998.git.nicolinc@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: e10c548c-a8df-40bf-4edb-08ddab135026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AR9/hexqZ+bAQdMiEUeFDcILiecVX3DO/EJLZn9EcuCH0OSjeIprXOH+sXL7?=
 =?us-ascii?Q?0gtXVTET+Z8gzr2bvxIGADpx79++GvSqeKDymxHQi/EBoFne0mE+H3so0Q0D?=
 =?us-ascii?Q?sT7Nqs+XPVXfC7Ic6kAYc4KweQZGoo2gqB8/WsrJtbQSalCWxJDDwuievCd5?=
 =?us-ascii?Q?O7DcpdBsjtVazgJbd6LFcVnhWO7U2QNHXCH0tLs8Q7ybu5aP7OHJkJ5/Ca6l?=
 =?us-ascii?Q?rjsvkbzgVCXwOQN8R55wj2JoUCU3s9AFhD0n174/8oL3YLK6xgI8f3caSW0Y?=
 =?us-ascii?Q?gXs1yoKgc19gd+934Gvao1LROFU8Bub8QETUdzcJZFsGbg+7EapNjBZVTSwS?=
 =?us-ascii?Q?SbmWcwyCJa3Q0o6ZL6yCJmeJBMQRg1kgE5JYFwvNFszcP21QBzhKkjIaaniA?=
 =?us-ascii?Q?ynKS/3mv8vmGdgpLOip1pUmv65QRWYyeyUTvKC9+zBQ4DggxB2KsZzMpKUXG?=
 =?us-ascii?Q?/ZZ8BxVRLoJfSl7Rnreaxit9RhK3NpSL+FI8gCxPDjieidUPpnyg6lNN9ltu?=
 =?us-ascii?Q?b582Ijg/e8IiTvaEYBPNPNoMLVR0QPzXBbBKXc+2NZMoZnL982gSQPGGsdEP?=
 =?us-ascii?Q?S1dZfRctebUKGAk+bFI46QICDcXRcih88IQTHDL2CG2wYuAHkz84iC/WnFmA?=
 =?us-ascii?Q?phLvbSumqRiSuPYQZBRDxx7G4E9UFJ2Q7nEbmiRTy4+k1gTNwcPlr6YRFOas?=
 =?us-ascii?Q?3zwdJbvz8XP9KJfd440K2jebGpnu4yGgnFEZZgf+6/boZlsPyeSJB+HP7YMK?=
 =?us-ascii?Q?SHSqcwRaEBj64ZwPVC9CS+IiTbCTBXPjOXD/zref2SgMBCGGaKQ4l7C0g6MP?=
 =?us-ascii?Q?HUI0i87y3u4vrnpio+bF1q1cNZ7ytPrS+JchyYFD1O8v7UcS+clQHBgaMzmv?=
 =?us-ascii?Q?N7o0CVvjAIEMe9HWfeREC5ia0CrXAcwJyWZShaX2iY8pYOcQ7e2f6dXhE+ja?=
 =?us-ascii?Q?CPO0Rt7O4bI3g7rGyHewhKdWbGcYkLa+Me26IJHp5JZKxAQYE1WxM+i+b9oe?=
 =?us-ascii?Q?5rZ3MSP7f9S4qke9Nmm8QBIOQTZjGnXeif662xXj6WLkWgVAoro3hySOMtEP?=
 =?us-ascii?Q?pcWQE2sF9VwyCn/lOHAZBCLcz5iRKyCRI14P6w4xZQmLLgLjme/UQ4Eec8w2?=
 =?us-ascii?Q?kZ8ypYqRROL7k3CzTUGPck+FerLpT2WP0DjkxragdnhX8T2S1Ksbaq7VzoEJ?=
 =?us-ascii?Q?4J07qCBPrzXojIXckxfkz0BvQ2lTzSrQgMElE0bI8C6/c7VgTV7/mkUeXJ3n?=
 =?us-ascii?Q?9HUwFG044L6bVjO3N0xTcNkR2g1M+zV5HqMkGoiL0L03UqUQ4CsxORakygWD?=
 =?us-ascii?Q?39tZ9LN45pHnxX0LDBfzHJVbWSv4xTzSC30uNvWibg+uW1EDR5NDF0JnocbL?=
 =?us-ascii?Q?v0tC4kKlatkIsATndQP0erx1oLWtujCk7e/oUpGdRpXVvZnWCuVKLezQGF4D?=
 =?us-ascii?Q?p2JH3Q9wzoeRkd2cVmXc0OWxrSA9UgcpLLAjUNcm+wB3/+C4kJTa5n70AtGZ?=
 =?us-ascii?Q?9GmhtKs9i1gztTYRQ9//sG8n2oLFX5O8Ww9X?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:59.1833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e10c548c-a8df-40bf-4edb-08ddab135026
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018

Add a new vEVENTQ type for VINTFs that are assigned to the user space.
Simply report the two 64-bit LVCMDQ_ERR_MAPs register values.

Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h                  | 15 +++++++++++++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 22 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1c9e486113e3..a2840beefa8c 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1145,10 +1145,12 @@ struct iommufd_vevent_header {
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
@@ -1172,6 +1174,19 @@ struct iommu_vevent_arm_smmuv3 {
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
index ab9c80b4f2e8..c231bdcd5d31 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -294,6 +294,20 @@ static inline int vcmdq_write_config(struct tegra241_vcmdq *vcmdq, u32 regval)
 
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
@@ -339,6 +353,14 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
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


