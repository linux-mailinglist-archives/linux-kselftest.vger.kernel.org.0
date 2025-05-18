Return-Path: <linux-kselftest+bounces-33282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E7FABAD94
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A9058121F
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404682356B1;
	Sun, 18 May 2025 03:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J0wczJG+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658021E25EB;
	Sun, 18 May 2025 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538588; cv=fail; b=gHPrsoiiluV1cWWIXWsS3+otnVYz1tQl+Bme4bA/fXJPaeVUafgBkdOTEjCKfJxD8r/gWofB8KnIG35xalEqQr7PIF/IH2LqqDqznTfqQEZ4CYGcd5tDfNLLpb6t65ybMuJ824zQ87FWoKkgDTNbrBJqnJ7SItmCjEuViX90xw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538588; c=relaxed/simple;
	bh=aWFtJ0Ppy3n/C7lqUKOoU00RSVIFUfFYHXa2n0oYfHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6MQG5klJgqyGrLlbO92KNaR4YcI4q1W/I0T+Rg1L2/3a5RQ4qm6M3Qvy3WoCqc7jxXB7bmI8FgK/qAilPVr1lqjhxfoxYmhPXIDju+31jHwQtoJK4qip/BSRhAhhN38nnsk/gb3oiihm6piLvesn4K5xIc5siVmTnLkWseTYdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J0wczJG+; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IY+PFqnNl7iaFHSSgpzjEoNPv2rr9c2Boe2oz7CC1OWdAfczlY2f0JolILv3ts97C4QzdGUJYvqC+Zcjww0Jb9Fkz/soA5T0IL0Iu4q83/kitCvth7UgSmxRrU/EGY4f/bF7nz0y1mHdip6bvGj5z7yMiObYyE9G+SKAiwx1f2kWl66e6az7K6NIVWEV0Df860HG6QxvUFRBBpPnmTmcPy5CEbARMMFSP7CNBBQ+praH7MJDH0/1lFtCVAehGU6LzBD3Mjb5dTxxkuCQ2gczJKUarz7uDnGcBLNQ6fA/P1eDbAXJPsiWbUF6MGHOGh+AgVu+wo5tou8w1n3nIJGt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpGNCxW/Q1zzQxTA/clgdipHxKMbZyVJ8knnVFrJKEI=;
 b=SE1BcqytayW4Efe5INOhxtMVkCJkgQTgQofRl495DF7qslePqiXEqc+dicVGwm6WaeLmzLDkx7dYqC14UwS7twziX0fl2nY1iYcwgLsumuxlOBgpxGNITbDeCC2+RAYfLiRpmjuPGwrn8RRRj93jbRLD8NTgsPphqEB3HgUDn65n4VaLJwGtnUslMl9NBe4RwtwLILL/zLRXxCDyufkTWo9qWCqgLMKjgnjjVQEe3DmCrhZtiw7QgHA1beY7NHMbHMXhhAbalxIQklYDd8SBArhuIVlYeFB36gHZz6jPFH3IiMyINJx2wNC2A9aJMxUBpRW0KUv4JSlCpKBmNhkxIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpGNCxW/Q1zzQxTA/clgdipHxKMbZyVJ8knnVFrJKEI=;
 b=J0wczJG+Qb4XUunyHX+Y91kCT0Bgjw8as4FM9o1rPMn7mysveaCnCg1n9lNebZgg7J1SjOCldARSvODqIULCJ0qVFhLO1EtzeodEKomG9tFqtpFJDMwYAMaoDSRwsXlGmyOuM0I5u5PdtWTNfTPwqcxJtG5mvbEpCmeOdM1n+ZScu+l2On+q8pxThRuT9j/svXyJ5vyJW0bj9xu5oEkbpkb6sOupz/kO0pf0iParUhqAhemZudJwHX6m3Hd8HuAW8M0A6cjDfDUxSF6n5ipPN4M7wSkobmiwORHeZg1BXeu/xPYfe4GPKcA9HaX7FJSvzxXgi/aW98B/SYj314WFQg==
Received: from BN9PR03CA0286.namprd03.prod.outlook.com (2603:10b6:408:f5::21)
 by CH1PR12MB9720.namprd12.prod.outlook.com (2603:10b6:610:2b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:23:02 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::fd) by BN9PR03CA0286.outlook.office365.com
 (2603:10b6:408:f5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.27 via Frontend Transport; Sun,
 18 May 2025 03:23:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:23:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:51 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:49 -0700
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
Subject: [PATCH v5 29/29] iommu/tegra241-cmdqv: Add IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support
Date: Sat, 17 May 2025 20:21:46 -0700
Message-ID: <97202a556153921ef3c0ab2b85622326f762bd8f.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CH1PR12MB9720:EE_
X-MS-Office365-Filtering-Correlation-Id: 571934c3-3e12-4d57-9dac-08dd95bb4bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sE0edpS+DEhsT7aVHEZgeYiDkOvXTq0JttFxx46RV16MO18sbfR+rHprvann?=
 =?us-ascii?Q?m/OWovErc876wIM7XedOcQFk8Fvs8U22+dPO9/FSNEgCq6vEBLuEWCb+cWCs?=
 =?us-ascii?Q?3uo6UF29FZ7eAW576KJTxiKsRnhk3V73v4MbKucV+Kmst7PGLBx5ncULBzXB?=
 =?us-ascii?Q?ZmjQ2lKwtOznwb/hSvb5vVkjinN7E7Wlx8cnuWDdxQSZ+FtqXTfVk4bZE9xW?=
 =?us-ascii?Q?ooB3KOThWKEdAHLq9KQYCo1HOKKg23hZP1hMj0ccFo2Sr+9gFsUSTV8IR3/b?=
 =?us-ascii?Q?DZG1zwLjlEcSfvCf7pf4a46GxMtri7ksI2DzTVLu1vXRGLZSjdG5reg85Zkf?=
 =?us-ascii?Q?i2aoDrrWv74iJjbQasuyF2F69Vo1dHCKc56vW7YP+oTSNILlep5rsptqcUuF?=
 =?us-ascii?Q?xL3OawNaC6b0PSnRV+Xd98ERTioyNiGovmZRX+ZBb/P+OA+qgV7qhpvLzKkb?=
 =?us-ascii?Q?MFgnTlMT2LgmONKCN4mczSOS/aBZwwBZxfnlhIIkZ31JuYfCNmqfaBnerUrP?=
 =?us-ascii?Q?jp853dmDrJ97ANBos+7cPIqvxUxNtYzmaVJ0c38D6/K4PRtSqMyCYp8LAGs7?=
 =?us-ascii?Q?VRF2lrPXPf8YsJVIx9s5/OGY3D/ijOQ8t49KiXreAdVciLZGqRjlXDw6z7b3?=
 =?us-ascii?Q?XZlZLZMJDZIXD2VtstcHvTT6aG7h1h+gN66M5NriBU8Dy/8pIRzxf5gkvpD2?=
 =?us-ascii?Q?Ix9UpKgBvgfSUnSb/JwMb+BZVjIbiFj2RCT25gaSIxzsQWo92/j6tW0DKy9O?=
 =?us-ascii?Q?qc2QTnI8ywjn8gVzsBeG+Vsw4Tx67EfLL15sIKcw5WbbM/INU8MblWtDZxAb?=
 =?us-ascii?Q?0l2M80gHuf44phRtwhLtYUIhDu9A0rxj5GekBq17Ctf2bMJ+RHD11yX4BsfR?=
 =?us-ascii?Q?JnOaIEVXzf1vHI0OH7ceS+oRCogc8T3Zf9iss0wZCqId9bOsEB7qp0z0D21U?=
 =?us-ascii?Q?UUbp9SaugCOtf54pWPAK0luK80JOpbCTK3YXa47tuMrQSSLhPnzKXEHGNVav?=
 =?us-ascii?Q?KX2Nt4WtsRBxKQJokhxo/SrD/uHnqQeBfLwu5uVmbMkOvlsNN+0Axv4yW77O?=
 =?us-ascii?Q?MwDCeFsvHuw+O/RzpJ0hCIhU0hBL50zCqjLadzuYW9pWnAlW08X7NWKDLV8d?=
 =?us-ascii?Q?cg3upSReupia35q/SkiEnhO2HbOuM/xiSOflpkLkgkuFFQ6PoP1PH0ZwsU0P?=
 =?us-ascii?Q?XnvFHWV3iW5Oa69fSntTnhV0QXscGyVWVOoNe6MnUUfkNkddVYCv+eJ8lfyt?=
 =?us-ascii?Q?OUijbmpcuMmvednIfevu062Q77aaViOL6maZ0l9Nd2jYupn5/3tQ2oDhNt7g?=
 =?us-ascii?Q?6Z90LtjlkgbpL9QL/AStBIkXYUfW55uXlRUs1ut+mR3eqC7OSRIjpUOvzf21?=
 =?us-ascii?Q?oA51RvQApbHlLzRIggoh9Vmmfxpsd/IQclxa2sjNRrjzkE6qsnlllIAIVIrx?=
 =?us-ascii?Q?FddAyCRTSLGhmauGPDG4jnhu0j/oIKhEacEGw7BCn7w3wIQDLRWdwva+BLcB?=
 =?us-ascii?Q?s7yyt9rXjmOqNAABMnmWBvhfkpeZJqxO9im1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:23:01.7535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 571934c3-3e12-4d57-9dac-08dd95bb4bcb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9720

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
index 8a9090cc938f..2080594db39b 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1139,10 +1139,12 @@ struct iommufd_vevent_header {
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
@@ -1166,6 +1168,19 @@ struct iommu_vevent_arm_smmuv3 {
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
index 49f07f61673c..7f3b7887478b 100644
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


