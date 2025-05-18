Return-Path: <linux-kselftest+bounces-33274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FD6ABAD6D
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D7E3BFAE3
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A800229B15;
	Sun, 18 May 2025 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eVm96p4t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9803B225A24;
	Sun, 18 May 2025 03:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538574; cv=fail; b=OW8XH9QcIO/pfsn/N9P9Zo94z078VwOKUstWf0Y7e+JBGCzf7kBUSWMw54wfn2peS6qdLUJJS++JMgwS2s9HFXFCupzMl8Mpbiu6/RdI9aNxLj3ThaGxN3ZyyU6DbUootew59TNUQTbQi17vqyVMvIdFQ1gaR2xxXN9mv8BSS94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538574; c=relaxed/simple;
	bh=63pTV0vFOxzClwBDRMTBf7TQ9Y8poHhRx2LCWbLit4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkAJ62l72P4oGRUBod1XG7VoIWmSKlYhxDIkXRg76bWEXefh/AYyk5ZOsKncqfNgwkgqciAus+Ij0/WQi7Qj5ekE0YlIxLP+eNLRySMfJEGEZLM9HYxlnn/L3C92tvpXklJCdONrnQoeTg3+RL0YTVwhPdzjNU+nWNMIJfuDxm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eVm96p4t; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KK7Q1ZHrGrwNON83YyEaP56SHF/dNdVEj+/3VJpyzTUYsMQ9frZQix9l8l67qRmXvBtd7LhPlcL31+0KzKg88xEPOkhhRIZ0Zt6ru+kJWzJT3nZ4mXcl5/qNX3qOMdWjFJfbF8HsDv5W6p0D+H7HZsd/I6aRTpbvhtWoFlhngxCkJOCDkPLh2LeEb9UWqoB6jtc/yl+Vfv1TPksEbAUPF0kOg0oTeg4tjngI2RIihKY1B57w76H+sIIZLtn1XhQOqm6sijoeOlUFw2Nvm3eZHxdCTvq64EjgOVutHNsOi/xaAvBQ/dwalWd2p7YU4521crGfGsCZtXeV0rQTfxQ4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VlIt7Qw25nI6KZmFj3XvryC7cNK8QDk4MMKenh3U0M=;
 b=zKPeW/ualHrLCoRgWQRJp5JTkRRcCIgrDvwjP65irblwrHsh02fDZONpQ2Vp0Wco21dMLb7FE6dgXBvLTj1IssM4tTZ/m/VPfXHCNGi7sDxqI/eL5JQpXs33wMobV/dpDGqJM08WEA2uO1C+ISf+fX/nUBEbx3qmTwDcZfpzmc4AS8pl+c9kJawLD0ekgNbDdM/F6zm7c4dBG0+oYsPkDysHcdwOKCQkVDUyG467gMUERAm+VDPdu9CXhHf+lNNX6v1UjIuhEVmtnYPEZUK4uPHGA+s1OkFtS7V17vt17M1cPJqj8/DDyX+j1LrbKmaSnR/kFVXceyh4UaIkNNrKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VlIt7Qw25nI6KZmFj3XvryC7cNK8QDk4MMKenh3U0M=;
 b=eVm96p4tjWCyvPzFiU1baKFaCfghd0wIxuNloMdZNsVUjaESVHgtw6rgqtJCG+CpqmM/vVZpCr9zUxEIVaPJ3hrZF01w7jp6uc4yAVTMiyxSKdp9rGhA6hc9YnNAvmav1xrz62fWQE84LG3jUpW3RLC/H0GPTZ730gJXJuNlY+wgdJcoU5e0ncJ9YOOf2HWL7MN3E9zDoD8K1szZByueHLzqtjTy5J9j57LuB/Am6FdyLJuqp1N85IbZc7LPD/NveGltYdoQayMb2bLGOEB9m5Ljvnw6ssDTrunqunA6L0/6MCrHBtyYCAaq56scjiPRHaF4NHIUzWERQRdcIZBEqw==
Received: from DM6PR12CA0003.namprd12.prod.outlook.com (2603:10b6:5:1c0::16)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Sun, 18 May
 2025 03:22:48 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::f5) by DM6PR12CA0003.outlook.office365.com
 (2603:10b6:5:1c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Sun,
 18 May 2025 03:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:48 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:37 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:35 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:33 -0700
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
Subject: [PATCH v5 21/29] iommufd: Allow an input data_type via iommu_hw_info
Date: Sat, 17 May 2025 20:21:38 -0700
Message-ID: <a5781101aea86e223ab23e88062a82c95ee3c411.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 964bd8a4-78e1-446e-bed1-08dd95bb43bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Ye9l7834CCJWVSOsXenLjTxn2mSHRhD/pgo8sX9DnUbBojMz5nWzzaA9S16?=
 =?us-ascii?Q?2ECSKmlKJ5C3/FqaTQTYu66YlYEc92HTf+0VgKj+UTS5srU6rtnogIVmvimW?=
 =?us-ascii?Q?G9/p2xo2EYJwi8O900/H5efUDcXtpx3vDFCNitLdFFXFPAvlr0DvWHXSgE29?=
 =?us-ascii?Q?P7eG83/HTG4vhxFD5MxcUOC2Y9IS2soQ3Xl7IzjrwsetMSs7o9KiWmvn+8RB?=
 =?us-ascii?Q?nNBBNZeWVUtAYna7lq76uS1YfCXWcIkAyCt0YBXIhaK02XkBXtt/T6FbF/e+?=
 =?us-ascii?Q?Oumn0msO5Y2HA6tXh7u7zWRummBIt2YQGYNCoT2t2xrMeMduq7fuYbke7Yl0?=
 =?us-ascii?Q?p3likC3RXoQrRNT9ya9R4MaGqh/FG1ASSrHWBlBjg1OnFk1MMT/8cgC1iqEv?=
 =?us-ascii?Q?GdSKHWjaQDwG+PCbDj0z7r45im+94z8axHZYSw3fyFT/jYtPNEmQ05MbCth9?=
 =?us-ascii?Q?CPqoywBRCDGrLqckpd0r91zRPlRD405cAsCBEIUNVyTipT64p/1Rmt3IZIt+?=
 =?us-ascii?Q?XVn+uVEb0A1JSWwIl3EGixBKlpbPevCClkx46OY7OOuJe96gd2ISl61XLF58?=
 =?us-ascii?Q?kvw/XEmlLquSJzLWhTxl9IHB/65iVejn+AGwrD7zErWIhEzmb5whap4m5SgG?=
 =?us-ascii?Q?1LYwbBxsR8dkVHLxFfuGh1n26LXvxkNc6tRg8VXCntXegrwIXAZIpi4Rv4Ch?=
 =?us-ascii?Q?z+thk2kqWe1wajiGMu+ZP77b+Y4eHpvfAdZBJmBk2fe+6O/8J7UmLYbd9/6N?=
 =?us-ascii?Q?gipKl/A6FA4p0hxwhnLUTyUEZP1KWj84orJA3SSncnfyngCoMewdhlZuFVJP?=
 =?us-ascii?Q?FWkheWqLN/wEgbg1mGfEpHcJeakkOGb0nthgM/Y+r/vPhjYyws6y/xJDZym9?=
 =?us-ascii?Q?ygbiQQeyG6XPmn4w+0QxdYA2H9lq/XSGgoaq/eZp0xIJ6lUSMQhBBDO+w18P?=
 =?us-ascii?Q?LkIF1u1y/gUJJ5MjnhqHCIyOwcT/iG6fZth68qGKx7g5ZnJHghzE2G8F2fv8?=
 =?us-ascii?Q?wsYQyhebTrMWnIPWWyx5yehIaiorngPmtaLNewAwEO3J04/XsWVjjtT3lXu3?=
 =?us-ascii?Q?V4UYv2Cohg/+rlVtEeQbOhHQkq1PTQi5GUI9Huy5HsHLBuT71ueTOMyKCW/d?=
 =?us-ascii?Q?M36FM65FBCFZQXmeaGDXhIbSEKPLVdDxh7R+XGICrCHU8OnMqXBcA1i0EHlm?=
 =?us-ascii?Q?q7is1Uz/JFdPOujYCK/aObr0bY/WbFDS9n4Yk36nLenC/MnZeRrgsGf8C5aE?=
 =?us-ascii?Q?WSCIItqeaMftndm8QjqwVhqlyz+Gn6yTisfaSi68Rc/gVKOmIKr/B+znsZd6?=
 =?us-ascii?Q?vYUJ6W5vyAfJYPa+h2Z/KStsNdYU3F7Sax/9L+KISV4A5OQn7uy9rMuqIHA1?=
 =?us-ascii?Q?qZet+PMFNpKM8F08i8ctraHm6l4HMQ66J7GJ/zMPdmJseF3NxZAfcp+WhZ9R?=
 =?us-ascii?Q?kO2AQh1gqmDWlTS15WLXG57WGjk/dqUzyinkXoLiYJN9IHE3qQAUc4U0zSs9?=
 =?us-ascii?Q?F6Br0cjr5LAJJEcaPq15nz/BYonZvdQu4sFV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:48.1992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 964bd8a4-78e1-446e-bed1-08dd95bb43bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774

The iommu_hw_info can output via the out_data_type field the vendor data
type from a driver, but this only allows driver to report one data type.

Now, with SMMUv3 having a Tegra241 CMDQV implementation, it has two sets
of types and data structs to report.

One way to support that is to use the same type field bidirectionally.

Rename "out_data_type" to simply "data_type", to allow an input for user
space to request for a specific type and to get the corresponding data.

For backward compatibility, since the ioctl handler has never checked an
input value, add a new IOMMU_HW_INFO_FLAG_INPUT_TYPE to switch between
the old output-only field and the new bidirectional field.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h   | 22 +++++++++++++++++-----
 drivers/iommu/iommufd/device.c | 16 +++++++++-------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1fc546acb231..7bcd3912180a 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -628,6 +628,15 @@ enum iommufd_hw_capabilities {
 	IOMMU_HW_CAP_PCI_PASID_PRIV = 1 << 2,
 };
 
+/**
+ * enum iommufd_hw_info_flags - Flags for iommu_hw_info
+ * @IOMMU_HW_INFO_FLAG_INPUT_TYPE: If set, @data_type carries an input type for
+ *                                 user space to request for a specific info
+ */
+enum iommufd_hw_info_flags {
+	IOMMU_HW_INFO_FLAG_INPUT_TYPE = 1 << 0,
+};
+
 /**
  * struct iommu_hw_info - ioctl(IOMMU_GET_HW_INFO)
  * @size: sizeof(struct iommu_hw_info)
@@ -637,8 +646,11 @@ enum iommufd_hw_capabilities {
  *            data that kernel supports
  * @data_uptr: User pointer to a user-space buffer used by the kernel to fill
  *             the iommu type specific hardware information data
- * @out_data_type: Output the iommu hardware info type as defined in the enum
- *                 iommu_hw_info_type.
+ * @data_type: Output the iommu hardware info type as defined in the enum
+ *             iommu_hw_info_type. If IOMMU_HW_INFO_FLAG_INPUT_TYPE is set, an
+ *             input type via @data_type will be valid, requesting for the info
+ *             data to the given type. Otherwise, any input value carried via
+ *             @data_type will be seen as IOMMU_HW_INFO_TYPE_DEFAULT
  * @out_capabilities: Output the generic iommu capability info type as defined
  *                    in the enum iommu_hw_capabilities.
  * @out_max_pasid_log2: Output the width of PASIDs. 0 means no PASID support.
@@ -657,8 +669,8 @@ enum iommufd_hw_capabilities {
  * user buffer is larger than the data that kernel has. Otherwise, kernel only
  * fills the buffer using the given length in @data_len. If the ioctl succeeds,
  * @data_len will be updated to the length that kernel actually supports,
- * @out_data_type will be filled to decode the data filled in the buffer
- * pointed by @data_uptr. Input @data_len == zero is allowed.
+ * @data_type will be filled to decode the data filled in the buffer pointed by
+ * @data_uptr. Input @data_len == zero is allowed.
  */
 struct iommu_hw_info {
 	__u32 size;
@@ -666,7 +678,7 @@ struct iommu_hw_info {
 	__u32 dev_id;
 	__u32 data_len;
 	__aligned_u64 data_uptr;
-	__u32 out_data_type;
+	__u32 data_type;
 	__u8 out_max_pasid_log2;
 	__u8 __reserved[3];
 	__aligned_u64 out_capabilities;
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 50337183eb1c..68e8b8e36907 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1352,6 +1352,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_rw, "IOMMUFD");
 
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 {
+	const u32 SUPPORTED_FLAGS = IOMMU_HW_INFO_FLAG_INPUT_TYPE;
 	struct iommu_hw_info *cmd = ucmd->cmd;
 	void __user *user_ptr = u64_to_user_ptr(cmd->data_uptr);
 	const struct iommu_ops *ops;
@@ -1361,12 +1362,14 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	void *data;
 	int rc;
 
-	if (cmd->flags || cmd->__reserved[0] || cmd->__reserved[1] ||
-	    cmd->__reserved[2])
+	if (cmd->flags & ~SUPPORTED_FLAGS)
+		return -EOPNOTSUPP;
+	if (cmd->__reserved[0] || cmd->__reserved[1] || cmd->__reserved[2])
 		return -EOPNOTSUPP;
 
 	/* Clear the type field since drivers don't support a random input */
-	cmd->out_data_type = IOMMU_HW_INFO_TYPE_DEFAULT;
+	if (!(cmd->flags & IOMMU_HW_INFO_FLAG_INPUT_TYPE))
+		cmd->data_type = IOMMU_HW_INFO_TYPE_DEFAULT;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
 	if (IS_ERR(idev))
@@ -1374,7 +1377,7 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 
 	ops = dev_iommu_ops(idev->dev);
 	if (ops->hw_info) {
-		data = ops->hw_info(idev->dev, &data_len, &cmd->out_data_type);
+		data = ops->hw_info(idev->dev, &data_len, &cmd->data_type);
 		if (IS_ERR(data)) {
 			rc = PTR_ERR(data);
 			goto out_put;
@@ -1384,13 +1387,12 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 		 * drivers that have hw_info callback should have a unique
 		 * iommu_hw_info_type.
 		 */
-		if (WARN_ON_ONCE(cmd->out_data_type ==
-				 IOMMU_HW_INFO_TYPE_NONE)) {
+		if (WARN_ON_ONCE(cmd->data_type == IOMMU_HW_INFO_TYPE_NONE)) {
 			rc = -ENODEV;
 			goto out_free;
 		}
 	} else {
-		cmd->out_data_type = IOMMU_HW_INFO_TYPE_NONE;
+		cmd->data_type = IOMMU_HW_INFO_TYPE_NONE;
 		data_len = 0;
 		data = NULL;
 	}
-- 
2.43.0


