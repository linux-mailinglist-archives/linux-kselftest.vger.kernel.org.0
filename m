Return-Path: <linux-kselftest+bounces-34994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9AAAD9ADB
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDD0189FF20
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC56D218E91;
	Sat, 14 Jun 2025 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iNunRqSe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CC1215787;
	Sat, 14 Jun 2025 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885349; cv=fail; b=ko85iMG4L2g5AIwUGJ/o/j7nB6J0sekj2m5FQ8EZDVdpPkLGnl0vGh72ihBCeuo4VISrNO4Pm1/Yxfl5KEuFex3Q8mD9m0HXd8sdp6fTGVKwQ/Rdj9PQfk9g/OLRGWu8kpQUpv5un0T/rErFcVoa4i9MxuVi3+/zfXgyCmLKtD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885349; c=relaxed/simple;
	bh=7p8NsnnBiPvOHc5u8LuclZGcYuE5B8AKKStOcKUWtWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZpI56diAf+MfgwBvrjPYopAZKv3Gd3v1g8YS0yLP3HY478nfInIkuW9FbmX/JCMjDZhyWA9JqXbP72Gx+rZ0cmMy5eao92KB1lQpzgkFkSucG4xthkSd0jqxPFIJdksyNJq6Qh/ue118Ca7q/avrbC+hzrhRwN0fVMZNMgmMMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iNunRqSe; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPb+wTgohYcH47ydz1rSfxK2/M5MyCqZ6JnCeNTq0xsIi3r5uPtLlZ9wQ9tNFSYr5c3sRCL155tRqHdI04+AVPYJkw47AUl6n0PPncUAt4W8XXi1VHLfmfmzm+ap0KDYpZ+DXmiL6TVKcicVhgBEyzp80GM+qYPw84T0EjfpkgEStegBZ70zN3oCgfU2rpqyk/9F/ZFjkxWT0NRZdj/+eTT4jcvsq9j+8kk+wNjev50Yg5m0M33O/86O1u7TDBbSJFgSOoZlqjwKx+JihpN1sGHRlDLeYEtZjzmHChO3Coe/ebLo8lZ64U70s9cdQSt1YLmnsVp/oSuvLpBcOeFQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85sA8dMj/0WAHoXIeN2wzE8iGr9YVkyY3q4SlsD94fQ=;
 b=uIqyh93nao43zGPHnsW9H3tpn0NXVkAP4n+dEh3dl2Y2XwBWe7eFqMFg0ahqLb15VTAwSfkSHbTXzbNS4VWa3rpJYyxKbVPuxSOCVynZ9VaK3KFWx4LjYoUMIeT+JK20/GSKU+9uCxUcpckSyXkNMAJVlAq01B575YvY5A5gJE/9joBaGqqF/kuQ74ss53RlrEDdkMuqm+Cpb9/qilrquqA+cGhxQfpnl6j/YBOjPjaun275FGRunihZouKqaZAFjVKkhxvRWQTmTMvK1Xb/6PNPm9Pp0UmkLynbpk755IR28hj1ett+mC/xOg5xrl1w+NEEuzu5ig41QxVP3ojzlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85sA8dMj/0WAHoXIeN2wzE8iGr9YVkyY3q4SlsD94fQ=;
 b=iNunRqSe7CYoU5EaVp0uaSZIZ69k7yPFjtkA2UWSsaKr/PVgyPQtIyT1CU8xeutOogdqrtXtcdoBMf9lQSAr5hfVn9kiksXc62Xp7ujph/CF6ZNXz/eY71lM7qvhgwfipsWTCQlM5Z71heKvHygfP0atW4KcL5JXahPAohdqmtgKEFhMSn18AQaEcQMtaT6aUxPKceSuGEuajJkg5RzjApyeFLL8f2MOKos8driRrin9YhtZ3V/jgh48nyxA5ePcTC6czzos7LqLPCFbJsxrwUieCuq3rmIAp8nG6Wn2E3cKj8Cs2dK5P7hmgGLbcpWS7gj2gNVwIqS6W1fVUHnQow==
Received: from BL1PR13CA0247.namprd13.prod.outlook.com (2603:10b6:208:2ba::12)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.23; Sat, 14 Jun 2025 07:15:44 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::2c) by BL1PR13CA0247.outlook.office365.com
 (2603:10b6:208:2ba::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Sat,
 14 Jun 2025 07:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:30 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:28 -0700
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
Subject: [PATCH v6 17/25] iommufd: Allow an input data_type via iommu_hw_info
Date: Sat, 14 Jun 2025 00:14:42 -0700
Message-ID: <8e1d8432fb7e11f0ed514bc96690ece1f5e47fdd.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b7684d-cdc7-4476-595a-08ddab134750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qejEp0Ykv+x2DHyaUrlMV6v2Hu2Uc/oa+ElEy0vVnPB31pHOkBGdG5Qrpl6j?=
 =?us-ascii?Q?cz2wl+eMB3tqlihOYpts1oCkHevbQHhMFYTIS8FjZAojS1BVLCjw+PVeb2Nz?=
 =?us-ascii?Q?FNTDgvg7fA9fbbSHQfGI7q2hQR+j4C1kwjD55L7x6uAen55YJLliSXR4H+ap?=
 =?us-ascii?Q?p9d0z6BlUdIsq9Seu8+vkC9H72y6dKlZKiKMItar09it3zIvJ4k6dETK7Ydf?=
 =?us-ascii?Q?nJqk9nja3BHMIaWug5LTetc9VHGnh0a5OlmPwgXRKGKN7xYKVM/2Eqsop9fm?=
 =?us-ascii?Q?r3Vk/lk3kc3jJAtvoC3paYgT1lPOdGho+8gwqAardEOvLEXsrljBOVpp+QKL?=
 =?us-ascii?Q?p0Vw5uCWYtCQK0Pppzfk1C4ETO45dJsCzZ42eLaEwjSFOpKa9rM0LUSoh3LK?=
 =?us-ascii?Q?d+qIIJNnKkLoQ1h1A2e+nRvdtyAIJqNEc+c2x71gM/ZSnEN1b+T4YHf35ReZ?=
 =?us-ascii?Q?O/PqPtV0/xQYfmtDNjx0yE6tgZJ4ezrNS+v2BVKNFiyQyTBiRLzL3EFo+13O?=
 =?us-ascii?Q?GZd9+cYF2iRk93mmmukUBZuhFm8g/ZCaEuNnOn5fKli5HoqdSCb0NFl2plNJ?=
 =?us-ascii?Q?gotEmaZPSbJWJ/9XRB2rQuLT+sjLxyodoKoyeuGStQSRAzso+mA85v6qNBay?=
 =?us-ascii?Q?wdnh+Yx1HhpIRoxHEATOCY3LMyVqp5LyOZuyXfKw1sq07sNRzYTLZWAmnxxH?=
 =?us-ascii?Q?t7mDic9/6GSzDoeKU6GAWru34cBUW2SYjWtJw4HIUhvqbjQZokWWdAIup/sX?=
 =?us-ascii?Q?MtK9VGC/hTPuOxs9vHKolsr10UTmjCLBGCzA2TCQgLpMF5uu24qmCMgfr/Lz?=
 =?us-ascii?Q?IVYmxztoWXKo/ME8cm36imqyEjC4InIm9VPiqt3PVTBPM6losV601cnS8483?=
 =?us-ascii?Q?a7Zfzw1PR86oBhbB/a3CMBdf9Z/Tqc+FuEGo9WNmOKxrO9W2PEBHNedm0xqM?=
 =?us-ascii?Q?2o9odBKXikIGo+tYCPozX/izrNVcGjeS+uGiwxxkldDjfLUVKO/qiJyYIjM4?=
 =?us-ascii?Q?dZRyS/dqN1UjkiO7HAlkSOKEM61Xz8unO26OC0LMeLEduLzzZWXohqyzcKWD?=
 =?us-ascii?Q?VJRaNigFDgg6nbnE5pGOE338i+QUX60uzX69GF0qVO10pwkYJRq+EQiHw5Kn?=
 =?us-ascii?Q?NWSwvdb8YOI1wF3fCHufYePLKJnHkDc3ATZZ4aCo3TlZrK7Ezgh5WxsDSnLH?=
 =?us-ascii?Q?dwpvt/yFkWNFPsyxoqdG+ZNMwzSjdO3MNz6NeH1KHjehh75CHeBCZGlPa+yw?=
 =?us-ascii?Q?+EhV8XWsNfFoVBG1gZQlnS3OAbDjX37GmV6TA9fF6N+6pyDJKTfGV281I2aJ?=
 =?us-ascii?Q?1mjt5VYGA+M5iFMzn5z8zdMLixNXYry/y6cF1sFQnmJL4I4uA3W29NHjlL56?=
 =?us-ascii?Q?F4ULz2LGZ8QiccLO8KLQqJbO2tXC2OnFcywCBMqRn2cKi7ZMgSwBQipr2hjq?=
 =?us-ascii?Q?kKpbt1WsULrOwtLGMskQZeuAtJ4N71sBbs+I5KlXlmoQRnNnEXUY8Gn5dAZa?=
 =?us-ascii?Q?w/0vtPPBq9Pirq4m5fFaqvXbIfzl3kSVBAbN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:44.3642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b7684d-cdc7-4476-595a-08ddab134750
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304

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
index 50f6c27fde32..adef195b7a1d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1500,6 +1500,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_rw, "IOMMUFD");
 
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 {
+	const u32 SUPPORTED_FLAGS = IOMMU_HW_INFO_FLAG_INPUT_TYPE;
 	struct iommu_hw_info *cmd = ucmd->cmd;
 	void __user *user_ptr = u64_to_user_ptr(cmd->data_uptr);
 	const struct iommu_ops *ops;
@@ -1509,12 +1510,14 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
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


