Return-Path: <linux-kselftest+bounces-30504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AA4A85441
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6E39A625D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 06:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115EB27E1AF;
	Fri, 11 Apr 2025 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kc6Gw5qo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED7D27E1AE;
	Fri, 11 Apr 2025 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353509; cv=fail; b=eLc3c1D/vSe5ArRuTPEQWOBwrq1H7pXkJhx5S8XRRLE5IzJ/JDs0A1aB/fwZC1mA3VtzSe1izfii3nIFxZKMz3IbrYw4n4w2dScqipFOCZyZHFkaOZxybBZ/d9ALfrgPfOtoHMOQ/tF9zDEFrj737ppW6PS8JsCDg0sYAQC24KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353509; c=relaxed/simple;
	bh=E3xUjL5SaomcbIfWTT1XRwyMbMCPya5yeEGAYlyqriU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcxqgGI+NWGG2V9HzdNqLTnHo/Z9cNBsakX8M6WVmNcm5pS9ViraphJ90yW58eWbKZXYbk3FsuU5gOxvD/fqY0QWMvUp98RGv3cso0jWIt3zUTGcEoUhBShDrZc99VJJuV2rasUysS/0ZKdZCX9Je7ILdDZaz5/3Bg5KztdIc0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kc6Gw5qo; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUFONY3ErQSFVF35w2CWpE7wHUUJnrdEG/Bf+Cq5y7MDgM2ay+Qekf8dJxcDlhb5qTQ62LPqAjuXF1WyENKicaCkhsylP+z/2tLZvTh6PZv6adpN1kp+y0NA5NfssJAX/KtJ5TDCqWS9WfGv7fPWHJUxFLByCNuJ12+nLTAemQdyzeq/SC2ZlM6Kuf5VStUjGTxRLv3NCIMtGF8MwWaewFe0YsS02vpK3gLYmg0Y7NSa7od4zzcH/Xl8JdoHknVj1dc2NIvpxSsT5eWodVRQn4i5njJhm+WGeKOj2UKfpzQxyUwO25S+4gANRL5P1QBHsXWZrGX1PtbP5oyHB79nFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAEJs93SC7bB4T5SXHDyQvp/q2UJcl2xzAJBmjYN8/k=;
 b=jbkmHYZeb+H7344i2lAE/a5g0mZZh97wZgh+2Cp41DtBCi8VOSaax5fpfWmJWj05xvCjxvwObTQUxlc8oTdyXRXr8DNH8Q65t1WKxoHzurLWM7RRQMwz+mqLfY+6LJ34oTDLOBRayu/FMoA+rHFJ1f2fGUnPqGL8HlflzCZg1c8zLy7n4Ysn0hpwFUOHV7UCB0MXjugINiDuaMQ2UK/khIKCkBJObWaRmWEEiPW8UFYzqNPlhSkEvPcs11QuoC3cF4vrdVxHcjhv5ZO8oqA6KZMXFkiFZdCHxugIhRCKCs27A/6lVoWJOPaOxHGxr1Qi4NteX2O9iG0XgZxUCFemBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAEJs93SC7bB4T5SXHDyQvp/q2UJcl2xzAJBmjYN8/k=;
 b=Kc6Gw5qojBdoiNAyDr22NK36TeDmHkaaz5N04e0q+Xy9sQac4R+YM8IyNS4OOnrjdgoKm+iERZvGqwmv8t3u0jOerEge+oAQwgJV44vUYAOh9ujvG5K5b6l/J7kDesY9uAe2tR1Z+bWFOlDOc9hg3lKU/JXYsaLYBFzcBBy7qrfi8prvvJIfCclKLgGF1FC8pG38+0q4AJsWJrA1XUSPwyXPxOJ2QGksPXdOPCgyHXXyVZUVd/IPfEvxG06vxMYHF5IanXKct7ISGijJ0OzF4QDya7F0imTuFZUxcgIo2rgiHqm9JafShwdaN+UH27yE1Mcjzr4TsXHQAwPg3JWSqA==
Received: from BYAPR04CA0008.namprd04.prod.outlook.com (2603:10b6:a03:40::21)
 by SN7PR12MB8602.namprd12.prod.outlook.com (2603:10b6:806:26d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Fri, 11 Apr
 2025 06:38:20 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::79) by BYAPR04CA0008.outlook.office365.com
 (2603:10b6:a03:40::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 06:38:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 06:38:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 23:38:09 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 23:38:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 23:38:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<praan@google.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <jsnitsel@redhat.com>, <mshavit@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH v1 02/16] iommufd/viommu: Allow driver-specific user data for a vIOMMU object
Date: Thu, 10 Apr 2025 23:37:41 -0700
Message-ID: <d357a5d8ec08f5be0182506533f32a500fa3f0dd.1744353300.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744353300.git.nicolinc@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|SN7PR12MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c59669f-ecaa-4650-7e8e-08dd78c37355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QAHRFspvsqrzck3pQ7ufmwc3vXzZWQViRBSjhBC7cXQk/GX4tJX4+uVor94S?=
 =?us-ascii?Q?Tud4dDmf05momDTIdghqHk3z6u5QSP851zU3WbHVcU64u8SBQR+Mu3T9wPmm?=
 =?us-ascii?Q?NQXz4wft52MgYxei90NMZv/zmLh6QxrUZshTQNlYXlWJ3A1SrMotal1JQegA?=
 =?us-ascii?Q?xsNNI6BG9eRCByjzsxWJzuQ0tpCmuV2/spGmKeN87/ZskAevl6kITlwK42xE?=
 =?us-ascii?Q?Tq4QD/2TIoFjc1R5MNOg3BR/y3qT3u4XMlwk36ojhCygeIcEdswOqWGkaVlu?=
 =?us-ascii?Q?vkfc7wst+Ac8kCVjVGjbkZ8m578zUMu1TD5vxLfwMinVJLuk3BFl/HwCotBN?=
 =?us-ascii?Q?KN/Fek9MaD7FQVFdDKUsD2yVS0HzbPk4X4T6XK20eJeih/mdgYjpvkz4WyOF?=
 =?us-ascii?Q?yrM7XDEuaLN/pc9qB60jkJSIxqqUCP8v8YtQjApIho0m3HqXdBPP6Xhv9SCe?=
 =?us-ascii?Q?cmrZAopgewQrltY3XQQ+gUpAT/UU+M+BxHQ2zO1xAi/1Y8biVLxQTqzrgbIC?=
 =?us-ascii?Q?m09DQlwzM1j8nQ+wF521o/FOEQZWGkLvav0EiwLX2Gyq9hAm6vaG9ShMlVb5?=
 =?us-ascii?Q?9iJ0R5vuHGaCARhmWweLSOp4paBBW4Hu4fIP6sAxo4GgYENZ7Zw4x980MTF+?=
 =?us-ascii?Q?PHG1/rnJz1wcx1F1lUH22r9/d4aPpPJ6fZWNB9nJDaVcISKeB2okamT+ZKsW?=
 =?us-ascii?Q?8dl/4PwElHvVIWH5RFptAhR8CszCtewXMcS/68MgTeYYpYFDdzRRqlZJcFzc?=
 =?us-ascii?Q?DfN0uTq+Ki8nG9aYmVpVPE2ojHiqtVacwGRXixgss04QnErjFufZLBYMKD0s?=
 =?us-ascii?Q?oop21C6bqIQLxFNVHF14H726pkZsuLurdHMpgzR1W9VYKU/kE6uXGxhnzrVW?=
 =?us-ascii?Q?kFZaT0H9OgSQJAhWcjR/thON6+lH6/LCNL8Sh0SAXvKf1CpQMZ4ntf/+efwr?=
 =?us-ascii?Q?VIDM02cmKL1LsKLhYcxRNRXW85YO1tDvBeg/TSE/zJfgB4B4u4Ua0o7JmZKs?=
 =?us-ascii?Q?edUmUWxnvQHkG8UgV1utJh4oPbBzB6zxgtuh2wyvM5CsH0qBiU26G96D/G9Q?=
 =?us-ascii?Q?PnItiJKwfaIMcbImAUKDSr1NAOH/62dntWwDiRE83TR0QaF/wv78Z7J4VtoQ?=
 =?us-ascii?Q?udhZhrMaM4Cg2AhHr6vLzv9xajP9GZP8B6wkYScrjcDsj+svTCQ5DavFba5L?=
 =?us-ascii?Q?m2qWFH1aUPZumTA2p8qcMIXv6cN0wgEAW8c2+gTNSD/eePSPeG3T/qoIt+BU?=
 =?us-ascii?Q?I8B6/wZe1bLvBpKHLVREcBnRIWFi9GsNsX186t/6qWOIXoLgq0LhwiUbMx5e?=
 =?us-ascii?Q?lKET8oRmkfIB1EG3P/ofuG3djBrKBL02mBNLnVgBhxZVRzR4S0aoM5wXvbmN?=
 =?us-ascii?Q?7mZh/f5TtGwn84ZbVilm4GMuGhbJ2pJ3A0inYbfJhiUq+4yKp4SzLf6QwmU8?=
 =?us-ascii?Q?54ieT/IxEnOc1z2ciXQ7pbUAhs35kqWz80R92stJF4m9qIyWdNyjfZg4G7lq?=
 =?us-ascii?Q?R/drNzIRekgzZukzGXrrVc6VUtbl6hrSFz6X?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:38:20.5104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c59669f-ecaa-4650-7e8e-08dd78c37355
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8602

The new type of vIOMMU for tegra241-cmdqv driver needs a driver-specific
user data. So, add data_len/uptr to the iommu_viommu_alloc uAPI and pass
it in via the viommu_alloc iommu op.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h   | 6 ++++++
 drivers/iommu/iommufd/viommu.c | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index f29b6c44655e..cc90299a08d9 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -965,6 +965,9 @@ enum iommu_viommu_type {
  * @dev_id: The device's physical IOMMU will be used to back the virtual IOMMU
  * @hwpt_id: ID of a nesting parent HWPT to associate to
  * @out_viommu_id: Output virtual IOMMU ID for the allocated object
+ * @data_len: Length of the type specific data
+ * @__reserved: Must be 0
+ * @data_uptr: User pointer to an array of driver-specific virtual IOMMU data
  *
  * Allocate a virtual IOMMU object, representing the underlying physical IOMMU's
  * virtualization support that is a security-isolated slice of the real IOMMU HW
@@ -985,6 +988,9 @@ struct iommu_viommu_alloc {
 	__u32 dev_id;
 	__u32 hwpt_id;
 	__u32 out_viommu_id;
+	__u32 data_len;
+	__u32 __reserved;
+	__aligned_u64 data_uptr;
 };
 #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
 
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index b861ca49d723..3d4d325adeaa 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -17,6 +17,11 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_viommu_alloc *cmd = ucmd->cmd;
+	const struct iommu_user_data user_data = {
+		.type = cmd->type,
+		.uptr = u64_to_user_ptr(cmd->data_uptr),
+		.len = cmd->data_len,
+	};
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
@@ -48,7 +53,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	}
 
 	viommu = ops->viommu_alloc(idev->dev, hwpt_paging->common.domain,
-				   ucmd->ictx, cmd->type, NULL);
+				   ucmd->ictx, cmd->type,
+				   user_data.len ? &user_data : NULL);
 	if (IS_ERR(viommu)) {
 		rc = PTR_ERR(viommu);
 		goto out_put_hwpt;
-- 
2.43.0


