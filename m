Return-Path: <linux-kselftest+bounces-36619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA44AF9D40
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9B15878BE
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFC015624D;
	Sat,  5 Jul 2025 01:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rccDOKdM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A58E1DC998;
	Sat,  5 Jul 2025 01:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678064; cv=fail; b=HWz81pwNWuwm8l2Ydur+9BzWqFq6Te/qUnatln9Pe2vw0+VA6WOt467ix1JZOmkTYl9d+ooBPbZBvhA4V7ZG2HsrIUuzWY+8HRqpgGT6J7Eyjj0uw3dve/BrMUk9YfugS4MAVUl5jQ+czXxDvDNCYlCG26QBrgl7hOKQYiFiGpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678064; c=relaxed/simple;
	bh=aB6x2cTkammXxTwzxaIZkocB4xgvJzt0D5BTHso0Jgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJ9naOKMy8eY9Zawfg91L43jAYQLpuYKBF5FOUUK6LWSm1pglA5iavALwmRhEmX/H3GdQEa08A9Z7MkYPk6XHyvHecQBB6jlul+9V72BTCAVAdLh7JArA0RKUFg5S0l2Y/MvOBFPnuiwVxvMJAoQxvuvEIqgOmCJvvHORNsOtm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rccDOKdM; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwG8tEenXMyFtge9qe9dAP3G3y09TimJMQL6ku58y5sy2rF3OqxPywUMJwKqayvwBFd6o6igQSz2NUPL0CQyfh8ns1lNqDkJlJDMOLurnI1mzpyVKb2cieATW7bfSoY9HLACBeG10BPdPW89uUoTk8+YMRK6uJouFqveQLHvJIqrzGo56KNkA0VJ2cqWgj1a1rKlEzUA4u7j+IAXgQf3IIOJLGzscl7Ltf7jFWtCSxJYh85//bJip0cSboHATuoEuEY7dYsBsnrt4PoqeBw+kS2dvVnHh1ABip61Xq41TWsF4hbRw2DgXPCgR86Lw6opNf/dW1zlNmBV9ziHFKGK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LQZ4o5THKUYZ174sLtrAPZYklS36tvZS1bH0HtCo4E=;
 b=sCIkbCZmbwOkopby4yiU61J3LXmSrOCzSV69yIlesulPXEf+D0Mzi+vDY6xjqY2AM4WdWxMlqTl3VxV+M7cWIh65b0d4R0g6FckY8UnqBpfeGdDeBZ20lY4/eHCZ8amOJVa7R7dhNWbtcsOLI5txTWd915gWOz3kbcXOjItT8284p7PF/kr5OZEf6byuWnEYnZBnqBg4VJ1624G4kZ8pK0Ml9FPMvDT5AkHwpKTOqiNrK5uTJpHVhUzqgKE1pSSAqAgNEwIqNYKAqcrx7jL7FDlgkx66zvBlk/WdgDj+Seu151xYEV941RRBJfzYeXynEHuAoObwibyrC7ngw8w06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LQZ4o5THKUYZ174sLtrAPZYklS36tvZS1bH0HtCo4E=;
 b=rccDOKdMkEp0Ko1qDcanqVi6sZLCYxq7Ux/ggTO/pwKRQ+oQx9xwo4IiihXkQmXbBero9Er1nQcqaiXYdR0tB/Hxh4/zInOAPVdn3swL8AS7ltxRFT3a+H67IJsxm8UEgktx6B9vf3V2lVUorChJjDNs9rusF4XNdYj8rdzgxT6fchWcsPsg3qzzRR/DVGFgxjJ8nP5duRoL/f9aOibQghhijqESXGuGOtmDJ/x6KFYsJ2M8fgJ6pZMO+9n/uUWQYda4dOSFoFztC1CEZBqidEK8w73nnJ+z3D+5OQHYA5PYOk74OEGFuh3OqpdKzbIufTN0O4ehQmnHYSFakyMFnQ==
Received: from SJ0PR05CA0123.namprd05.prod.outlook.com (2603:10b6:a03:33d::8)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Sat, 5 Jul
 2025 01:14:16 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::96) by SJ0PR05CA0123.outlook.office365.com
 (2603:10b6:a03:33d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.16 via Frontend Transport; Sat,
 5 Jul 2025 01:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:04 -0700
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
Subject: [PATCH v8 07/29] iommufd/viommu: Allow driver-specific user data for a vIOMMU object
Date: Fri, 4 Jul 2025 18:13:23 -0700
Message-ID: <66d83efac4c8b69fdd7f5b922aa1191ed2cfb4e1.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 0997dfe8-a53f-4e9d-871e-08ddbb6142cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M5HEH1Z5TwE8TqXhzHr1mSMaOSJ3Qz9jQHVlgPoOomoNfYs70xi8JRyE1dln?=
 =?us-ascii?Q?gJ+QbRJwgmKZYYMx3VyoasVTAybGCloWFL8QTNqBYu4TxRxNIxwIIMuiMJOp?=
 =?us-ascii?Q?uXGnXx6UrQ/ue+mIga1XgNaAgMeFPku2i7IIk+dEUA0kLOPEDwPEh9n9feAv?=
 =?us-ascii?Q?DKuU/l1p4JqC2lxMGn8YXhcIT4yRznOC3qG7msinjbTKP2wZ7bmlpkuchCaX?=
 =?us-ascii?Q?lfiu6aj7vqlGmN+n3Jun3MDfkr2T5AhyXE8IujBQlJI/AwXfk/emEV2HPvmt?=
 =?us-ascii?Q?6pySS4SaDFXdfSIQiIvvdZs/ucZnShSRB4T4/y4pKaIISG5KlOuCD1gT+J9e?=
 =?us-ascii?Q?RCOTW7oHqzu0grCPO14sggeGwMS0Emetcq+zGSyQYrvTgNaL7AI2UjSz3PNk?=
 =?us-ascii?Q?NxTSpqp1jgKIDsJF1IrVUZEAfhYe51t7gRDu9kQDRu6KVbhol3gqtQHW+o+u?=
 =?us-ascii?Q?vNbIBbo1EZVoQx6iUIOYxweUikguGmRofVgiNIZ3KvAHwswssqXxDxxJv/rv?=
 =?us-ascii?Q?ImsC2TfOoFbW1l7gIfMlUdwrN1eZizGRtcr+EjJmvsQ1sgZSalMIQaZTJeNw?=
 =?us-ascii?Q?8LGrkCrwS1foHmcJom8IjWuVi2bgbJ0ScomOBgiz98M+dfXtyzg8CYKEUh8c?=
 =?us-ascii?Q?dO8/Jdz+3yMtwjw4v3uwalhINZBXtN7lfK/WdUKRFHJcRN6KYpL3ssb+uwxN?=
 =?us-ascii?Q?2m6SyDh/Q1y3c/iv0mHNHkeH4hOprX14WgtgyM3k2FdPwR3OO3+AGugwTvP7?=
 =?us-ascii?Q?bT9yj4fp8KKDmSsCNOqX1wXdKAvTt5/PVG/OD7YzkPzfWsdd8mEtCFv9bC/u?=
 =?us-ascii?Q?/XbiVAQOLgY0w3LAhCaner1YDD42PdHxZw6o2IVezGRCzwmsDwN1zFVNK3oK?=
 =?us-ascii?Q?OkwurOtrZ1rOXXu02BUzbkQhk2nEvhEvafm+94OpcOHhSUfo4iUrjVnUCvp0?=
 =?us-ascii?Q?EJdpNEnljYUlrXe3Qk1dObkKFBqB2Xcg+uxQku31FQ6tUHLpDPzELUglijv1?=
 =?us-ascii?Q?QooCiTLDysbwVf5ROhHSDYnk+K1XQQeJ8nQXKnpPeQ59JKUMBqZd2pf+6Nxl?=
 =?us-ascii?Q?+HL4apFfGwfJrWVr3mjW/MZn6HU5oyc7XAsW5vL5SeVavCbzCeYwt0PFQCBk?=
 =?us-ascii?Q?H1L9M8MZmrmbF69hYzqGMbJG3U9t6XcsTgLNFI0b9nmbIVWYPokRjwVW69zg?=
 =?us-ascii?Q?58Z7XAPZ89VtJKOsZGUQ2iqyp2x0C8jnocD5B8cQxOLruz0+B4QenhsV6xZD?=
 =?us-ascii?Q?CWxueMxA3zo4IgUi1Ph7rmzzhY/QvG3eBkte/EEGuvW7EqfmemptcVgrzhhp?=
 =?us-ascii?Q?qpxneya2XCElSfjTUoXOzEQJ/QHl4Zl/hQpIDUaHK30jT0InAmMee2JlLZN1?=
 =?us-ascii?Q?r5GrKVfW41tqYt19xqnigaowHhOCb5eO7NESfOzz4hkkKIdSdR/mgk3pfp83?=
 =?us-ascii?Q?LVS92srrbdxyjK1I1lC36qy4HhpVKx6V6fItul/AgzIz7MZw2a70LROgY0BS?=
 =?us-ascii?Q?nSYykvjVmxBQmMac9gy25AbqVbtPVJ8Fzao3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:16.2093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0997dfe8-a53f-4e9d-871e-08ddbb6142cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739

The new type of vIOMMU for tegra241-cmdqv driver needs a driver-specific
user data. So, add data_len/uptr to the iommu_viommu_alloc uAPI and pass
it in via the viommu_init iommu op.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Pranjal Shrivastava <praan@google.com>
Acked-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h   | 6 ++++++
 drivers/iommu/iommufd/viommu.c | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 4bc05e4621c1..04eee77335cf 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -965,6 +965,9 @@ enum iommu_viommu_type {
  * @dev_id: The device's physical IOMMU will be used to back the virtual IOMMU
  * @hwpt_id: ID of a nesting parent HWPT to associate to
  * @out_viommu_id: Output virtual IOMMU ID for the allocated object
+ * @data_len: Length of the type specific data
+ * @__reserved: Must be 0
+ * @data_uptr: User pointer to a driver-specific virtual IOMMU data
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
index 2009a421efae..c0365849f849 100644
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
@@ -84,7 +89,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	 */
 	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
 
-	rc = ops->viommu_init(viommu, hwpt_paging->common.domain, NULL);
+	rc = ops->viommu_init(viommu, hwpt_paging->common.domain,
+			      user_data.len ? &user_data : NULL);
 	if (rc)
 		goto out_put_hwpt;
 
-- 
2.43.0


