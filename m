Return-Path: <linux-kselftest+bounces-36924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE8FAFF91A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24F07BCE6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C7D28F523;
	Thu, 10 Jul 2025 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZM3eWLag"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67928DF41;
	Thu, 10 Jul 2025 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127249; cv=fail; b=kqNosTZplvBD1PKBiPfuQ2q2ahQR3KQEQDRpJiNpGwdLmMTi+8XJNzCSGuwGhZ2Gy6RGeJO43t9s4+aUzCbvlWUzqufk1ZYgD+qAa/Vzx9SQX8J8Ki4J0hlHKU3R174iHhf9E3obitUKBfMyIt2baALKwkPZ9EhIGvavwowZVJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127249; c=relaxed/simple;
	bh=L/Y7wwIvPmt2hcqI7UeV3dFO9HXaanU6HB1Vn965G8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G673TFjsKEPasePRoGJUnXSuh48FRz/tTrYFx9Mf5rquxpJ4FGdD5c3wYJAt1zeL/QGd5rhcbOeneQuWiQVBuOklL8PiHKoDy1eW8g8j9Nhtf2avrsDEStrMHGg3kiNkNBnttx5WBY/HURitt5j+81GZamqj4VQdN79ZWq4xp/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZM3eWLag; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8apSiVplsTlQuxjDAhgdHCvAx1qEmRe8GZpzim1VwFx5pKclMVW2wn6hZmCPvvpnQtj3+BN64d5wdCJh+48qiFyol4AInf550kSPfjd6h7GjIy3X4A41IKvoQ46R3Q0IQfy+jX8qSO7f4X4xQXz0sH0d7XDS9adBz46VA55rc4lxpEqXETa7F5a34KiAHAaMmIUx0bQEfDtu72dZjKsLMtzL5nzI74NIPzVTMmKDowICpoSGGMpyekG8a6tyl+ozCAo7e0c5u/xDvpH9749jxnZHujkQEi0+Tb2mSPhd+LeQlpazpkJe6hshREd0+mMmi5Qgd8zzfn5+8UI/rQEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1V5AQjmmsK5hL0iMgoOJSM6TUZTNMgyem8EQFASaZc=;
 b=G3q+cXsW1/+Agd/qY5q0pwbAmQh0/4T/k9M+DI/jn+bYDNYlMnMC67bFlFlCD39+MGynAFeJ1jpR8FjVdKUC3Hb0NwqpMS5/rXwfmalShmLzkcC69jBidAqDfT7q6vfjMJZ6/cA7LAM5W6dMvncpeMgMx9UL8Mb7MSn3iwhu7y1urNJ7qTv6/DuJ09TxPneAFeLL7AI2YR45KhQooJHbhia4jGaeOeNSSt8z0v9K7duZQofRSahQ9HI3CcQUOIYRoZex+ywom/BBVOTRx4vPMUemYHK8Koy+SGSxNRWEWfb2FtAd6kqr7zpTeDOL48623fUCQrEyjErmDZ3Mp/NDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1V5AQjmmsK5hL0iMgoOJSM6TUZTNMgyem8EQFASaZc=;
 b=ZM3eWLagK0YWiwsqCIdDqBYozQu9vLGPlG0lZlGfA31kxLc5EF0uTk/DdIca24z2ojU+Y3p5MsIO11qvxmT2sXBc6zoyjJ7gP10MGcPgb8DRoYXh3blWU0Ae36K/+FiRZKRv+EtJZwXrkZnqA0e5ctDsdhxFND8VnfmfxqZ76wyvOH53dQYhJn7TrxxXErSr+UtKGlH+lgHrLbf/R22XDeL7Iqz75w9L6v0tj4y1G3nvCW+UJAu4U7MhqvN0+kdwmbO3hYIS1JRisyjX+cHppW6HNFZp/fdl7w1OstgjdIq2rfoahAtattTbXonr8mP2Zh4HTgoGT/m30fSCVKaN6A==
Received: from CH2PR14CA0032.namprd14.prod.outlook.com (2603:10b6:610:56::12)
 by SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 06:00:44 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::f8) by CH2PR14CA0032.outlook.office365.com
 (2603:10b6:610:56::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.24 via Frontend Transport; Thu,
 10 Jul 2025 06:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:25 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:25 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v9 21/29] iommufd: Allow an input data_type via iommu_hw_info
Date: Wed, 9 Jul 2025 22:59:13 -0700
Message-ID: <887378a7167e1786d9d13cde0c36263ed61823d7.1752126748.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752126748.git.nicolinc@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SJ2PR12MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: 502f66b5-c8bc-40a7-a9b5-08ddbf771bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6O9pQy/PmfkmBnQPRuEoPyMO/N1AWiblFBM/Lh7ytTrKE8NRUE+bgqd5cp7T?=
 =?us-ascii?Q?6aH3rUXky0bcsXv3XYm8LB6f+5vOIArCffhMZdumyDfeQfXPh3wdbHWIkr1B?=
 =?us-ascii?Q?MdZpZbi5INP35ikZq/LaPP2JrNxeggqaPC0TY1iYDOMp2TAgUWlk1kxaRMIb?=
 =?us-ascii?Q?7hfERdlCYr+mn/U1OB2tOZ91vuymQdK5XTAHJep8KNkPICNvZOGBzSpF8rRd?=
 =?us-ascii?Q?FHMtC3hoV3Y27NWQIf2jMxj8erak3Yt+FnE5bgbPqUx0r3WCYsmnS27SzOKK?=
 =?us-ascii?Q?lSy7TUcnCA9Teck3W0Rj0n6b0K8Tbc0An37JgeBHd+TQaKIDxbZWm0pt5fIZ?=
 =?us-ascii?Q?8J8CLzhRKbrDo6qs9ajIXGLud0d49BFIdls7zEe2rDjGd9Vq/l3yI6GneRJW?=
 =?us-ascii?Q?9ic2mYTUwhRsug5ZYE01qQesC16nsyNzt2u/fUUSz6Hfp9FB6y3ZF54KYP58?=
 =?us-ascii?Q?x9LPFtuob+7PfnKg4iKQhfp0XY80UFNgSh2A6W1S66QP5UDGj6nqKZI9toyg?=
 =?us-ascii?Q?01/WHtPL72JgLD4DDkWPXfDGACxq4Y/6w7JhzaE9TYTdaOXwKq99j+G0JJko?=
 =?us-ascii?Q?LpXWkbtC6WiZsWx8nKiSKOLx9JNU7c4RaS4WQqwiQ24EGl/rLqL3sFfm0prh?=
 =?us-ascii?Q?dxVxln2EVEv6PfwRrP8t1sw7Z9xA83ge5O4P78cthfSfJ4DBMCDB/+0LNDp0?=
 =?us-ascii?Q?sB2LnAZTqRFXxvj8CV16R1ysyfutqTRHL1g8/0A7BtuqTSH/HUxjWeREztqQ?=
 =?us-ascii?Q?Q13CHHDA2efiJhsOH8UDZs2MbynCjCv14T5Ou/iUoemGOvQ6ZH9sNAfAGt7H?=
 =?us-ascii?Q?J0iy7YkdF3lszPqFDEwWFTDo10oxG1b5zPIP7q7VM6bZjuACg7cBYfAymINC?=
 =?us-ascii?Q?k143l5VoOMu0G0FCyArol4g+mdXU6YJUgl32kxZcqkqEnXfzO0ZinVE3lrhs?=
 =?us-ascii?Q?qkmaXYSdOG7Kg0AnFAUJH+dURnEfW8kpLl5A7NpqPKUIykLWiMDnM9tD6xSR?=
 =?us-ascii?Q?Dz+mF/T+urcM3TVbWbiy17BAgr0Od8S4sWnnDrJgKNcEOunVUCwXfZF6lcum?=
 =?us-ascii?Q?W4EltUpmLsnuZCNzmhn3lXN7Xjoz9pbt4twh0l/pESfGfip9jU4P/s/pLhrD?=
 =?us-ascii?Q?PXfKctyDLfBJcE5EY4UNNs+HD8zPMQFPsDa/q+Ap2Tbo0xaas9qTfBXw0HDU?=
 =?us-ascii?Q?ZENNJ/3Hzf2yRoWlrJSn2XVNPN8Ot5Vq5xnJ7oCe1kjootiRnPof1fnJKh27?=
 =?us-ascii?Q?gPkK/WOcZQsZELTRG2PyVcCgZ4B3cvNIVOdndSFK0X7XezSZCm0/X+gsSYDA?=
 =?us-ascii?Q?H49+80yQc2gtBaFHYFTzSJzqsuwtp9KQo+GBpUwX/RGcDBSB51iH+jghl8O8?=
 =?us-ascii?Q?dva9xoLA8xgZdK+VeI9P3cIB34tqnr8DVV53qdnm65nnhYQ9wyon+Pr/gOHe?=
 =?us-ascii?Q?Wf0DquU7tpfXbFp5KR3CtAspOr73P1hUDV9AYLqUMiCwpuIGFVb1s99Ah0JA?=
 =?us-ascii?Q?9/gszP18eXynelMr3gPo/MIX0abQuDP9Srrk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:44.2985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 502f66b5-c8bc-40a7-a9b5-08ddbf771bcb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650

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


