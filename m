Return-Path: <linux-kselftest+bounces-35906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D96AEA6D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 488A57A880D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62542FA65F;
	Thu, 26 Jun 2025 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F/m4WP3k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A72FA62E;
	Thu, 26 Jun 2025 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966561; cv=fail; b=kYZjbNAgvp5imBjhUnF0pZJMXNJxkuFFqALKztsh273K+CFPZ11aV/81T9RQ1MBqD14wNokiO34oX07nwehRNfdt7o34Tv2lGrafYVVi4FFJjV9FJL8kIcvnnR7vXhFZux8pTuSr4VttK9HIQ4kPJWE1qNSqaSRn8G+kjjOpIOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966561; c=relaxed/simple;
	bh=ff8FBg4IGHAvNAOUB2w8/64wa188fODL/ifcBHgDvO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LP41O51uT66eaKAkYEjS+YnWJEoUyOUjnKKNo4dbSWIvFi4BiatL1HDJInIXDIcLKdp98nOHbTD1cBI1rV/OXJEQcDgXg6Yy4VtU2Qxe2J5lqsfBJtVqLs3seZTIPZ/UnTaRBlFKL0WLotnPpOFo2X8a/gGjzl9ydKhvbJFRia0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F/m4WP3k; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUiuqNMSG9DLbtt6z4VdQr4aSf3/9h5TLizB0E8dpIyjDw53fO4rAIYOJTAL3Yir8l+VWvdx+d4S+nMEmvesdPWf4rf2POLCo8XICMBOqSIGgDDyLAebRJyEBaahcLJCuHs4QQRWNEcJEwbJvD7UidJx3eh/NHiNjfPUSLs9hAgWu2EJgEYH64aIQQ/JSpMh/FDM0i86HF7jbFRzrGOTZGDwe45LpP8hqMz9woHAn2+FCsHa3ai+szkE4LrpCFP8SS9LSjwiTbUjuJAhEnNkBHbb0rgD/yRZ++W67P3pUyJHW3HIe5nCZ3Ppuqc9FzHkSmslkm8lib+c1pOa2Ok40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nx/n61o9LdYp7ykDLWBgSRVgmqT5UX+0MV6IY3XsmLE=;
 b=R5eUK5aPk668ph/xZRTBlK7zOPA08UbRchec6E889yzgVOvy08mov1Fj1tqQzGwBvdRSOnNHfENkMkWqUWpGe6jKuSF60SqwprtGoHOwsUJPSVqIOIlic4vWEPUsF3WxZFkdUx8aN9Tp/UrCDhw8OjMqZNcl1MzUtkJWZxvmR80tLydPS8quMwFOZdri28mOiWQ2NgnZbIlIQDWD5eGAWceZMD7gQw07rGNR6/sHAjvxqSv2ULfOVomd0bTLl55R2IDFwQXYQ93owSo26XHpRhcI5/Fg49jAO7NF/4hvOSN+a722ssB0hTgB7bSx441ELsIluWyD7apMKEhin1lrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx/n61o9LdYp7ykDLWBgSRVgmqT5UX+0MV6IY3XsmLE=;
 b=F/m4WP3kEIuXz6BbKNw7KZwBuZ6BJUaGnI71EHZf+GC32mY8LIVnLdBjTOMGP9rw0WfODvwPohx1wFhO4FtTTUfzANn+b4tiHBlavLevf8cyumqaPCx/CyXnoILJ6NE+V9zZgrYORKFGruDbCwGH02r7zvH1f87GGiH+je78v6CavHrkmaCI+ac4a5INiiPXzhE/+PTWERmDEI8SbVQ5sxPbPf1oSQ8pz5Z5RaF2qR553U0gEWWzZLPnqwNdqzDRWVI4vjs+Gd+33Yc9smnmIG8l15ABH2KNtHs9pr6xPdTrUv/Ou4c9wcyBM3NEugYflqo5DCymMhp3bmNnO7q9Uw==
Received: from BN0PR04CA0129.namprd04.prod.outlook.com (2603:10b6:408:ed::14)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.34; Thu, 26 Jun
 2025 19:35:54 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::84) by BN0PR04CA0129.outlook.office365.com
 (2603:10b6:408:ed::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 19:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:35 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:34 -0700
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
Subject: [PATCH v7 20/28] iommufd: Allow an input data_type via iommu_hw_info
Date: Thu, 26 Jun 2025 12:34:51 -0700
Message-ID: <ebbcdf1437bd1f96aa76e9132eba3c68472403c3.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5c61dc-9d1b-4834-09f3-08ddb4e8aa72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OkmflBsqIaEJ/leDUz3bdiqLLct12g8JHF/KBkiZTUSXmYRzy1Ka5FdK92+P?=
 =?us-ascii?Q?Pk211oWOV4Djzt8JMCSl4Ai2RC28OzRZ8EoWLVSfoLpK2hjrJmcZ6/VBQvG2?=
 =?us-ascii?Q?ohjxXeLNT68aujAZH7tQMx9hL/q5WWDqp4JbfY5WNzoTA+v1zF/J3p0PhQyx?=
 =?us-ascii?Q?zBWjSXGuLBqDCN/sxOCANGBr/B+S+5aFYBCyNfRLoQGkvotFfDeocoyIxPez?=
 =?us-ascii?Q?S0uQVYWFOrSEcKHvW+JES4Fc89ilb9yBzge1+4oKsKk2OGZc4jUAjCkouybk?=
 =?us-ascii?Q?BbsUeBwtwM6FeknZFBloTMNlBm9AN2RqVUBOSEefBCHNNIa9nkigjWcV0aPr?=
 =?us-ascii?Q?EyEeH9C7wmibUlZGZ8IAAlJ+SNMzjcTmYsx7Kb0ic0w7u6/oH52iQqnTtDMi?=
 =?us-ascii?Q?F61GsoCapvSfwZDiiG68JKypIHwJvgWm0WPEm5vm93DArPdfW0DeS1qPBBzZ?=
 =?us-ascii?Q?fcoApHkiMM/jW0kglmfD3doF2M2BUOoHjj0LsQ5+aBmJeNOIaLwJO+WATjo1?=
 =?us-ascii?Q?EI8gipFJFja05Del84D1xqG5F5PgWQyK21Rt2HVUgEMmPNeRXdJupJHdmsaM?=
 =?us-ascii?Q?SuVH5/1i86dMx/k9ysPExsJq2kpamYvawJY0rVvHCprrFijyHStHwueiPCQA?=
 =?us-ascii?Q?hSOzK3dDsIWIhfNlQi+0FpUbL2ILp4ijaKk123fho1u9+HQbRCeoj1dPIfMq?=
 =?us-ascii?Q?JxrhCoj2KgpsP3keKll2NNOeLH61fmFUUryleSSSOTXEqfIW3q2d/Bf0hzsc?=
 =?us-ascii?Q?jRzam8446gGw172jIbBlmKbyUXgjHeYjZtE3Bt0+ssxbTtNs616oDDw3+rYc?=
 =?us-ascii?Q?EYRVokM+6m5JoMOUwlbrhYSuPVqyWNnpAJP/K1t6k28CxEViYO4my6gbint4?=
 =?us-ascii?Q?huDwdBouZHe0S3lTJQPIxO4n384HRCTGoT14TMNHmKbNfTIqYEaly1AsFhIb?=
 =?us-ascii?Q?LL4F/LkydTgwI4Dc1JhfTH0W7PvXFuI58Orr5iutbtBePJjKSA4HNzfuhiH0?=
 =?us-ascii?Q?XxKRk0S/7/fo1y6kcuty3F9lPp+VG/CVWNZ1hM65kW8b+Zh8CHKcg2Vn/bdA?=
 =?us-ascii?Q?FIc7nQp24yZ9GmZ1q1N/b3VMJWgrnJlWMiPLIBW/LLnkkQ/aqWHp9e9v2iIB?=
 =?us-ascii?Q?7Ghq1yxU/5V/dowBgmChrv+gf9TS/6IVNH8ZlO917/7dXRe+IgfdNBrMc/Cu?=
 =?us-ascii?Q?13/mvXr0xK4j7NuNFwAdv1bhScJx7doH/7vlCHajAuYxWauv6zW+tQXrqzyZ?=
 =?us-ascii?Q?x31nPw3GxhlDhOWZx4fNEB2E/MWJzMb//vHKEBhO+m28d/lEHi/iWVr0OuN3?=
 =?us-ascii?Q?/FDdUuwDQY4WrVqUwAgE9tuo0ZoGwECDHtVzKYv4qn8rbG85rqxdwFSIPHLF?=
 =?us-ascii?Q?nNVIzoREivxfsLFOvqXfsHbLcnqyoVlqdf5KgV0M7v173mViYuSDm/93DifL?=
 =?us-ascii?Q?c4oKEv/yxHkyrET8mSEHgfXgd3aKfffNnDocF5W9eWKspfi/o6J3ukcuTaGu?=
 =?us-ascii?Q?tZ7fM9AeJNamfwIki0yBDNIKgoeqZRFGXQE8?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:53.9690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5c61dc-9d1b-4834-09f3-08ddb4e8aa72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089

The iommu_hw_info can output via the out_data_type field the vendor data
type from a driver, but this only allows driver to report one data type.

Now, with SMMUv3 having a Tegra241 CMDQV implementation, it has two sets
of types and data structs to report.

One way to support that is to use the same type field bidirectionally.

Reuse the same field by adding an "in_data_type", allowing user space to
request for a specific type and to get the corresponding data.

For backward compatibility, since the ioctl handler has never checked an
input value, add an IOMMU_HW_INFO_FLAG_INPUT_TYPE to switch between the
old output-only field and the new bidirectional field.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h   | 20 +++++++++++++++++++-
 drivers/iommu/iommufd/device.c |  9 ++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 6ad361ff9b06..6ae9d2102154 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -628,6 +628,15 @@ enum iommufd_hw_capabilities {
 	IOMMU_HW_CAP_PCI_PASID_PRIV = 1 << 2,
 };
 
+/**
+ * enum iommufd_hw_info_flags - Flags for iommu_hw_info
+ * @IOMMU_HW_INFO_FLAG_INPUT_TYPE: If set, @in_data_type carries an input type
+ *                                 for user space to request for a specific info
+ */
+enum iommufd_hw_info_flags {
+	IOMMU_HW_INFO_FLAG_INPUT_TYPE = 1 << 0,
+};
+
 /**
  * struct iommu_hw_info - ioctl(IOMMU_GET_HW_INFO)
  * @size: sizeof(struct iommu_hw_info)
@@ -637,6 +646,12 @@ enum iommufd_hw_capabilities {
  *            data that kernel supports
  * @data_uptr: User pointer to a user-space buffer used by the kernel to fill
  *             the iommu type specific hardware information data
+ * @in_data_type: This shares the same field with @out_data_type, making it be
+ *                a bidirectional field. When IOMMU_HW_INFO_FLAG_INPUT_TYPE is
+ *                set, an input type carried via this @in_data_type field will
+ *                be valid, requesting for the info data to the given type. If
+ *                IOMMU_HW_INFO_FLAG_INPUT_TYPE is unset, any input value will
+ *                be seen as IOMMU_HW_INFO_TYPE_DEFAULT
  * @out_data_type: Output the iommu hardware info type as defined in the enum
  *                 iommu_hw_info_type.
  * @out_capabilities: Output the generic iommu capability info type as defined
@@ -666,7 +681,10 @@ struct iommu_hw_info {
 	__u32 dev_id;
 	__u32 data_len;
 	__aligned_u64 data_uptr;
-	__u32 out_data_type;
+	union {
+		__u32 in_data_type;
+		__u32 out_data_type;
+	};
 	__u8 out_max_pasid_log2;
 	__u8 __reserved[3];
 	__aligned_u64 out_capabilities;
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 64a51993e6a1..cbd86aabdd1c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1506,6 +1506,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_rw, "IOMMUFD");
 
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 {
+	const u32 SUPPORTED_FLAGS = IOMMU_HW_INFO_FLAG_INPUT_TYPE;
 	struct iommu_hw_info *cmd = ucmd->cmd;
 	void __user *user_ptr = u64_to_user_ptr(cmd->data_uptr);
 	const struct iommu_ops *ops;
@@ -1515,12 +1516,14 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
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
+		cmd->in_data_type = IOMMU_HW_INFO_TYPE_DEFAULT;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
 	if (IS_ERR(idev))
-- 
2.43.0


