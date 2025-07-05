Return-Path: <linux-kselftest+bounces-36631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CDCAF9D66
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AFBC1CA1540
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57B1221FD2;
	Sat,  5 Jul 2025 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nkdlUIxr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D933A21CC62;
	Sat,  5 Jul 2025 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678088; cv=fail; b=E7RIm3EyEf85EMUMvkXqKPt18LMvUZAbduvqtdnuFIO4UwMnJMHnmeVCsawp4aENyD5GQgrCjMwfZyUW+nW1jWCZ6azJy8xRlUPE/A3GqdEiIzjLZrYR2q3JKQElxSDkmy6B/DU1dvIdYOjFExbWyUUoy7oh2LKZWS4Nz1Blrcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678088; c=relaxed/simple;
	bh=L/Y7wwIvPmt2hcqI7UeV3dFO9HXaanU6HB1Vn965G8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zu6w9UnMKrKLHi/MGULGHNPF3+Q77GryNAaoYEWUuH5b03EkJek03P9kQ1IKWXt81GdOEuUpXqIznDDhGAfj+g4NkhURkJVwJ7CLAcUDVl+WEs2Zqp+BP7LzOY1zazCktdHCMYNiHsPOJwajP9PdrwNdQQ0H8F5jmvC3G8e4gXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nkdlUIxr; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjF8DwbhTXsvYomkVWc8aqn4SFTZSMbCVtxsjURM7pYvAr3ZjvU7L6AaFhebcYlVBMjCuIc85IgA+0XikFnZsQgCe18tdMpw1uRMdI7Tdrmnfe+GiTgTsBwWVeOIxVFYfY7Y4Ruw2UaNTkl0VJngzhicjZbjYdG8JxvLbGe92NmV1UhIphmOjA1jgH3X0u1odfmtbcgNZpNL38vijIcan5QKA2ldnBBWdenOpsFPlgiUpwsGP3iVm9lctCAKYy2DYvZpqfBY9HIxa19XhFVuyGdfM2pPj4lVA7P46w+V+FfzZB95jBZj/r65ugoQe8wDLeRQ5xKSSHBLCzMBY/2Gow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1V5AQjmmsK5hL0iMgoOJSM6TUZTNMgyem8EQFASaZc=;
 b=RDsazSlFO6hLr8zDIXHrxH3yQm++fDLiF7Jpj6aJapjltpU6lsOtOzkxgOiqZ591nDYrduSkzMMynOHIRyeLoi9MkcnjmD/M9m4pTS5GyCaGYUVyTMK6ekPTyk5jyqSgY8R9WPLrSrl5EZyWYmQIuvnEuS0oZaQhc7dQqOdlphZZJZNt5as2RE18UMRFHHqdy/2GjyCkOTdsMNlpwxyQPG08TagCUMbNEkMTbXMSj3IYHT9A6Yxnt39M/iR7ef7w+xe9WxgVDsOMgJu26MLx8Z26LF5Io4RVcwVfnLCj4sdcwE/Z2Y9Wx5jOSFLMrC2piky6ESrE2rWQYeBxOZBJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1V5AQjmmsK5hL0iMgoOJSM6TUZTNMgyem8EQFASaZc=;
 b=nkdlUIxr4BbH4y5/qyKXesd2znaW2Og6PmCXJog5CpLmarzw0cKBWWtHWCvdks/iarOegm3yaMoCoe7Z2IIt/96GEMvSWDKEd8T9ZZuXuNhkv10yFhoHBWyyHuLZCg8QwDdzXWfBGRf6Fd4Wt8CA0PS7CoVmVYYwrY83ntxJugsXw1iXjOTbvj/UUDMvX0NCkDFXGFmbe93oqyi6aiVLCvN7IsfmWcbqHWIRFifwHtKj4zJQwIt8dMgr/uCMBowiN18ol9t15K6etMHPZ/UI2B37MHQzKHYnNBQt/jJ5ociglUFipo9pNXpE8JX2ol5WdavSIGoIqBwMq4HCv094OQ==
Received: from SJ0PR05CA0148.namprd05.prod.outlook.com (2603:10b6:a03:33d::33)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Sat, 5 Jul
 2025 01:14:43 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::5) by SJ0PR05CA0148.outlook.office365.com
 (2603:10b6:a03:33d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.16 via Frontend Transport; Sat,
 5 Jul 2025 01:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:42 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:28 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:28 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:26 -0700
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
Subject: [PATCH v8 21/29] iommufd: Allow an input data_type via iommu_hw_info
Date: Fri, 4 Jul 2025 18:13:37 -0700
Message-ID: <39a97049854980238304131c83a0cbd2e84a689c.1751677708.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751677708.git.nicolinc@nvidia.com>
References: <cover.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: ce72388e-43ee-4970-d7ce-08ddbb61527e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yd/99UIJkfaiu9ZODR4oTcLGmYdD3cFWubvnoJBinbHxLyIX9DFY+WPTqFWN?=
 =?us-ascii?Q?hmfDWtFFo7z8YRdKAdx4gxJjjEjSjQJzoG3RnEQDG66Ni6V3LBdn1zaTJVBW?=
 =?us-ascii?Q?3d8z1y4GWbC02FYMpRHkSdSKI+FwmjqCopC4ih9JcVcFN/ZjwM8AGxPqLqT6?=
 =?us-ascii?Q?rT+P9HzJQkThyvkxBmLlfUoSXH44F4cjO/gTf92hbq2CDtZapmO0sShVJqK9?=
 =?us-ascii?Q?LS7a7K8ogGF/2OYXguAyJ9zkIJ23grSALUrodwfHB7WrYPAltT2/n5X15xGa?=
 =?us-ascii?Q?nzSAvUVoe+CslwB8NqZSGKFayuVfl8r14Sh3cWEEeT8j8EFjwAzypP9khPws?=
 =?us-ascii?Q?iYrMYWH2GacbOnDaIJDlwit3/6rWMYpcnt2BjXfRa/5RNi1kK4C5qZ+2vN4M?=
 =?us-ascii?Q?LwpCoDwQS3+ksIJOREB/Q3DiA4pGst7S6tkL6KsRjsZHtsgw8K9Leek5yf8G?=
 =?us-ascii?Q?ibbO4Ro6J2SwIeH4rmkPczN/hlgHnqY/UcJZJqk8fLIBfZu3j2RZG6wXyDKD?=
 =?us-ascii?Q?GQuMvNvZgArzFlKQGm/1lPq8PX4FTx8AtQBAqwrvUujfQUJh+jYifRZf4UYh?=
 =?us-ascii?Q?gqn1MEvNL5JNwde2NDCHDHmlTVStA02kj2lHiJZ9TmyWHrPqrTllyeaGdIue?=
 =?us-ascii?Q?xxyz906r5M0nm+jNYXyADuQ/g2OmYYEdD2KH2KFanXmZfnXwSlOelyrD4LXK?=
 =?us-ascii?Q?pUQZzE/JPki4dDCzVqeV3otywh8g4iE1wGUqhMnDaRA1fFsEMugfsOxqvCwp?=
 =?us-ascii?Q?cH6gVQV5OLh51bZNHHfe9jQ8H47skmdOImts4/YxLR6rIPoZPgrYvBKHQevo?=
 =?us-ascii?Q?WvrMrGrlY0zz+QN7ItbwysPKIhTwsccPQi9q7Z9hgpyihVSe5Ma294qr5LBq?=
 =?us-ascii?Q?wps7JmwCNFXy1hGFV+9pONiIax8yVrYUdAeUnXOeCUxRiebfEuSRvZ0KZaMx?=
 =?us-ascii?Q?oJW+gzYWlA+O9XC0Jvxk8rjNHRSjkMH6PIidxdN7LZ8N8P82D6urNbhWUedP?=
 =?us-ascii?Q?HjYCpQJ+wJ0hC5Lx5jV9atMCh8a1VTgOMle82ivR8QnghPwCAnRCT1Tew41O?=
 =?us-ascii?Q?DsalXLEM51CHBOUzP1uK9aDNjZZmsXXHfeUsDEVLZJriOXe+WNYV7ytz/exy?=
 =?us-ascii?Q?A9ZLz0ieT5pfCz0stTDTD+SXJtUsWBp2TMEb/xeQobyAPjm1Bq/1A0mdazaX?=
 =?us-ascii?Q?L3wMYNbonYc2Z90MrEMBcFM8D4qd5ZACk4wyMXMEY3MVCxoVNq93JGAZ5JOG?=
 =?us-ascii?Q?LsRm1u+AuwkcPxoTBlVvSfX2lE+4gkdvJXeSifHb8Z1yhtSmdpTIYjIeujne?=
 =?us-ascii?Q?qftg58x0AfiIflLSRGk9GxFKpGM97V+FYKRJ3C44VWNiiCI4gNBKK3waXDi0?=
 =?us-ascii?Q?N80/S/sSMzhP9DbxRXvegyYHmlU7zFKHfXRnfZ/JPJwPUIS2lSwIY/n/uU2V?=
 =?us-ascii?Q?UrxzNAQpxf8FS2glGz+wV9gPUQStTM7VaV6oX5HeIbXwkJOHZoWLWVuMuo1X?=
 =?us-ascii?Q?63I4+bvuckRT6JgCimtlbePH5Lk/ZrH+Hw3M?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:42.5784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce72388e-43ee-4970-d7ce-08ddbb61527e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076

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
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h   | 20 +++++++++++++++++++-
 drivers/iommu/iommufd/device.c |  9 ++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index fe4b8f9a3403..d6a3376d5608 100644
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
index 14955dc43892..e2ba21c43ad2 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1499,6 +1499,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_rw, "IOMMUFD");
 
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 {
+	const u32 SUPPORTED_FLAGS = IOMMU_HW_INFO_FLAG_INPUT_TYPE;
 	struct iommu_hw_info *cmd = ucmd->cmd;
 	void __user *user_ptr = u64_to_user_ptr(cmd->data_uptr);
 	const struct iommu_ops *ops;
@@ -1508,12 +1509,14 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
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


