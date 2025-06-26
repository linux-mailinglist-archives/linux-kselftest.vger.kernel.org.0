Return-Path: <linux-kselftest+bounces-35914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A96AAEA6F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 131277B62ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8072FE32D;
	Thu, 26 Jun 2025 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OtQDuCwv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6A62FCFC5;
	Thu, 26 Jun 2025 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966569; cv=fail; b=GtkpILmCbJjoZEVBDfiYI5edIUlTu2K+T76Nyw70njYKdBhMg4pXz2gsqJzl9PIX/1MsmondXAmiU8MkzBxrs+rWG/G47QclOwapXjuh3Csvra5GpCs2PeeVLbgxPZGwD7SsG5h/tQFCL0ufpbmEAKJkiHuvUnShWladx2eo0Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966569; c=relaxed/simple;
	bh=L4WhD333foKQXuf6pXznljCRFUPLWNe/CVofF7qD8t4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zvh43opkNcISemg25uHs9rj7A/wh+Pqz5Bn+8yvD47DBue4eb2weHBZCwO0TaYSRLMAPclxDrHu3dk4jpMe4xeKl3qT8ZxScOBVWfXmGhBpRavKlPcoaqimMPhyIVNLaUMKVyYIjCZ7nRRCh4Po6GUlODT5BfgcKTwbrowJd3FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OtQDuCwv; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffdqKfYX0W0974+QafmpL25TWh2zs/mVyDCEKqBMar6dfVeb579SUy5Qi8cj6vzWTnyOJoyQmX1SHdFdv6WrGrDFw9KBIvrEnGe1uVcHXjav9h76mftKfowFf5f3vw+s3LJmvwuToL5kvLqgSFKJ3+xxNKHcRSWZWcnwTGKsov3Ev2ILvvJkKL74piucfPEwCijG0XKL4s5CM+RS4MP4Uw9/hS0Nk4DFoNNyAxbCE+Re2fy3xRG2KXjBxkYlbuAEjHhnS7MdCuQusduFh6nnmCrx0K0Gv8IVrEjSizccAZjYII4mqqDKwFsdO/bqd9Ma8zoJHDoPQqK96DSNgI/NSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXhtZuBITYJAAQtoJsMb0Y25UN4HB1vdWQYG8L55F1M=;
 b=e3ZRoe2e+GI1nLCtkvwLu74ljLKzFbT03T73MBnXYpRlgq9IjkHE1pzjRzQru5p6h9fT+vQkt+4hOUurKiUujiGopWcLAGvo44+U/jj0XdrKFD38Jcg4PklDwETit8JZpWuTmQfe+N+to2E2t1Qod6v0HrYvEhvvilexZCn2kgWDLq3cn6IruP5KeDpVnJ/BFMT/QWKZlE0rCNpOWWgFge2/pTKmCxTHZncuJTLQPK/ojUiIoCArejUn1oupIOOPEHxLCyouyGmayyi0QAvDEVKiDjQZqscLIQgCY7OU6d4jPK2GvRjerEMk052e464rAOBx0aGaedoCug4IFM5L5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXhtZuBITYJAAQtoJsMb0Y25UN4HB1vdWQYG8L55F1M=;
 b=OtQDuCwvXH2+zNaXDOzqvnm9kfX221554c1+XqTFQ8gguH3HRehGr0b81VDDO/EcQ3q/Iu1WM2i+vK/JUYsVGF/gQcDqqPihSVMjaJ3rMFCRW+hfhXZli7+IJSWFcYBvFDA5CbnZx6a/Y4DcfWuv/Z/iPU6A6FSA+m0r3LdPp3D5gM7wyrQrxaU/epgiQU3mEj0QH0HOL5xHFlXCPXZHHB9xlB/WQJKvI9XW0TV778/mzESZ3STKWY2XoPHW2AYQIp/lS1VoTzBIsfRPeAq6ijDjaKgZs1odA9Ki48tIaPlBsrDmlL7HEI98+4u0Qz5HDywr5MV4yt8OTTmd7fqO7Q==
Received: from MW4PR04CA0145.namprd04.prod.outlook.com (2603:10b6:303:84::30)
 by BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Thu, 26 Jun
 2025 19:36:03 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::1d) by MW4PR04CA0145.outlook.office365.com
 (2603:10b6:303:84::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Thu,
 26 Jun 2025 19:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:36:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:45 -0700
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
Subject: [PATCH v7 28/28] iommu/tegra241-cmdqv: Add IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support
Date: Thu, 26 Jun 2025 12:34:59 -0700
Message-ID: <bac7b4f97258bb32536042c534cc08d4988c26a4.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|BL1PR12MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: faffc84c-6cf9-4f19-02bb-08ddb4e8afe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x3f3Oeax8amHZOz4KMknuqeBNVzqC7hzaV/KM+fLTZTtdZEUkFjtMAEFwYFs?=
 =?us-ascii?Q?MbDDSY8Gwl6aLBFBdFPBOw+vhxub6CqqqnKXmN3To/5u8OYbSU28ZkIbxsJZ?=
 =?us-ascii?Q?X/TuXXvkmUj9HR99VcPZHCLlXKkM+UJGWDM9bZfUgkrcW+FRZRUVjpMZyVcN?=
 =?us-ascii?Q?Npptm/WrCyJ5RGbrQMZCa09v177lVqNAPsfjARTJ4Jqnn/LQDdVNRp28xNr7?=
 =?us-ascii?Q?ReJQMtbec7ymZWNEnDNDTY+1+qyGXPSlOSpDREobgPywzMGXkIL7TWfp+tXY?=
 =?us-ascii?Q?WrAt5LAyX5gzSPl90d5uTiYP8aohPFWwdoRLy/bC05XxigmBBU6pY+lE2VEp?=
 =?us-ascii?Q?sv/LXHD1jW1Cc2P02On5o0U0ZFmW0vltAIQSzaD+DXl6JFjQtxn2UGylN/Pi?=
 =?us-ascii?Q?L0pneqL0fHw6iSuzuMUI3iHW0Jr9rBJ+yT6U+wuZAe9Wjvg+1RyrKhCZfgxA?=
 =?us-ascii?Q?p29e1bclaRps214IQfwzQ7JaB8pdNc3haVTCa0LrucD5FLbgITgTOWJ0Ssvh?=
 =?us-ascii?Q?3XePxOmhHsy9ZkiiQLRgUhIveQHortunfwp0bReR8774Yz3Vf2QH0lS4IHQ0?=
 =?us-ascii?Q?0XBGrCJkWyvnfROVylhwGxKEzFUzFPSE+mGcJ0NGmkvJ/np163w8UBrS6Ih3?=
 =?us-ascii?Q?Ya48Xg6B4gdKnBe4WFa+cysA/QNVVuzN9eN7bQ/fckDB0LxGEHZ5f7qUw/hW?=
 =?us-ascii?Q?505E48OY5xfhSmAVBooshTDcEipaDjtE/vJx6M1rEPItu/PBvzrGw1N50CIX?=
 =?us-ascii?Q?NMowhanszXSqa6cNoifAfOBG8hZW6fDGkzKGP1jKprNW8mdMaFfRkqYvgfnk?=
 =?us-ascii?Q?bCJmJocbnye25nN0yOOFMQfb0hImupgA26QU5xHC5yX7JwSD66w1+uuibu4M?=
 =?us-ascii?Q?p3Qij0XiSJUMxGo2jEFiHMIyGVMLRUNC/10kRTOW3006VAOa2TnQCXz6DFl7?=
 =?us-ascii?Q?necQVqW0vHuVMheMMNPNo4pVekZlI90DzF1r+EXeLloA+e7+xJffcf4PU2SP?=
 =?us-ascii?Q?giIFZ9hgwjHV6HRXVop6CJgbJUSURiUM4Wexu7978l6RjeeZ8oSHEP9fy78x?=
 =?us-ascii?Q?XDXKEgVQR7cyLjqjAApfQolyeko75rzoMVj94P9Al0bgqGK7LaG3aBbjZm2N?=
 =?us-ascii?Q?tAJkwqjleZ1VkJ+R3YFgy56cwoSCCA4am4Xg+TmFvkweE7X3/L6pOx0SXKBl?=
 =?us-ascii?Q?M8SFVgA9qk93OgMZwaaZrGis1VLqWBKaqFCC8cAlByhl3aUH7qXb2kETPt/+?=
 =?us-ascii?Q?62X+hbtPAmHTtdmyLlH3Y9DNwN6tduB9YwtS5iq8wOuEIyM0mYxRBN7kE2IX?=
 =?us-ascii?Q?sz4CDWAqIWaU91X+yaFzqAm8Huo+M8MT/gMWvRINL54FFDlpxfX3he0D6FTW?=
 =?us-ascii?Q?vUeJ/QnpJ39lKjnF+XyB/eNbaabGkhusTRrPalwMD6J96loN9QolOoMpzA+V?=
 =?us-ascii?Q?fq+IJz+LwV5TS5FqgViOAZfbjCdIpqHhpyS4Fhi6D7wnybH8iSDvaHIB9S7j?=
 =?us-ascii?Q?+m5DNJDqw8MB1wSd9hi/O818t89Vo8ivvDJQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:36:03.2662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faffc84c-6cf9-4f19-02bb-08ddb4e8afe4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922

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
index e073b64553d5..d57a3bea948c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -295,6 +295,20 @@ static inline int vcmdq_write_config(struct tegra241_vcmdq *vcmdq, u32 regval)
 
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
@@ -340,6 +354,14 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
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


