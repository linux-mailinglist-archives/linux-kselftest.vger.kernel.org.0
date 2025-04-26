Return-Path: <linux-kselftest+bounces-31674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E1AA9D7BE
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 07:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC8B1BC1C2E
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 05:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9041C8619;
	Sat, 26 Apr 2025 05:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zu1KwKoc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18A1C68A6;
	Sat, 26 Apr 2025 05:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647133; cv=fail; b=LNBDsQ7S3qkrcEuOHE2uYIG680FLEpL8DRmamYyZvqhME9Y1JUUlkM72yjNKwilfTSn8rCl+I6rUgAoJSF8QaTb9sIJUn6+skxiHWXMdtgkdjLgIJLSFC8c8oLNA8j7fT4pG0wUxmjwrchNQHJujnj6Z9hhdf7rCMvLFyBQR7ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647133; c=relaxed/simple;
	bh=U3m2exHnYjh560qFV6psTZmtEG6FmvnO6BTHETPB1J8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrOyTbDbIRChd1KxJvpoX8u0PmfAh50id4IOSELu/6N5Q22asu2zSyF3MdkuHBuIrw5ura/GzGsb9NmaplCOXBqnenXPVTT+8syUmzulBJkWOhu8XpAc7zTradWda1ROpk3nLKJLWgvF8eCdQhVa6xefkK9yaRXbCww04fEamkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zu1KwKoc; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMWYwN+g1gyB9Y+962rezwfrQSmswR0yXCFUHWgsR5JhfWaTYh/BkzMy84/d2+95l5a0qOnQexTs0LpmTmtKjH2/ypstM0n5Ammyiugvrqa8LjlQ3uk3NDki1U+SpPW3u9r4fXNGg1TR9d6FAGml78zABMd10W/mjRQEHEJ9qS/j+saOFAg+vQmQviFBamQ3ngG+zlweg+yiFT0Y40tG2EQncNEhG1MPbdnd3jq5V/jRVOuSB6oB2/ms9vCe5RWMHhN6OjuXlcie8rB5fjpfh9ZRbAuHz+WD9F+qP2S0402zJ8Sd6wUYh8vJAGxaaDUBUgXYkhSSoQeQY9rzP7ug4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ey4O4hFrCtKMuOZHN0khqyZYluH+/muh1vOYBQ7uhVo=;
 b=uJ1rmkYdovHhaS27u2DGffG+/BI9Pv0V2X3E+sn4VYAjYiexEDuONEiFoA/thMUAV1WZi14+ZinLCkEvoWcrl+AEj2f3Hj6ZtH7RRQSeC0aJ2ro/kJ2emjbAjfrlasE2SFpxwbG+8glwrHL0+X53SWiwZAk7lrVmjf8+MschNFLjMgy1Ey0le4tUB8036ZaWrJ0B6StS8fUt2VYlsHsuw2ApmAcgZGuYkipip1vLg1+BlH6OQvVTV8FZdkVCuMu6Yhh9Yxl/nM8R4lnfJi6nuiWdJwYt1DtClTyLQfVGjeQoosOFMwoZ1GUsJnn7KnivFFYF1XyolEbsluk/j15xrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey4O4hFrCtKMuOZHN0khqyZYluH+/muh1vOYBQ7uhVo=;
 b=Zu1KwKocEOhrtnb/U99xN85bHjWqB6E3hEKFA/c8PZezT4uXCvXRo8ONLTCadVLpA+2TyO8dvG2eR09dNtye+K+qy9dQfDjc3nn2BZSQqAF+VNfO45uLeoVKRqjlYE08A8ho+li5xEAkJ4PBO9KdbmFVFOJqF+hnlr0k1eC4GFvKmunlVMByIz3rpOAjMNoOFWyzOVzDD/BqVC4uGqsib+5Mvyj7LFERj6D2Bn2sZsbC4wjxLa46HwxKGzZp7YCqaqZdv7gnBpkH26ajCgiioixTvSBNXngmKnmssVsOCvxbh2nNI8eILWflzGPK8tHnAHTYUhiS/3YuYrK+Ed2hYA==
Received: from DM6PR21CA0028.namprd21.prod.outlook.com (2603:10b6:5:174::38)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 05:58:45 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::73) by DM6PR21CA0028.outlook.office365.com
 (2603:10b6:5:174::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8678.12 via Frontend Transport; Sat,
 26 Apr 2025 05:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:58:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:58:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:58:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:58:39 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v2 03/22] iommufd/viommu: Allow driver-specific user data for a vIOMMU object
Date: Fri, 25 Apr 2025 22:57:58 -0700
Message-ID: <7031ae5ab6f625e73dbd51b074c2ff8a9923c731.1745646960.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745646960.git.nicolinc@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d0b24f-aac6-45f8-17a0-08dd8487679f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L3G2OaYf5FzXyzPehmCFgFqFyaR3Wyy9Ae5M2EHMnA3A2Y9UvHViP+nJXFA2?=
 =?us-ascii?Q?6wAnKB/0Zfog0wVlYuJkPCrINuVR3HZfnzEBO40jQrH9uceD4unAQ6ltpq29?=
 =?us-ascii?Q?WPZXEHBRn1a2PteK+DRACmKCsqH2BgtL13WeitRQwOdCXiiC8qNeE4dQZZGL?=
 =?us-ascii?Q?hqkn8duQz2d/9chA64QPVvNetVaQh/zq/KfMAC+bDtlYrgfWTqGEY9PyTOj4?=
 =?us-ascii?Q?w+BP+vSsbzebhM3RTYlBdyjsiQ2j6L4V4DlR+koqdaNHZHbFEZL2NoIbps/s?=
 =?us-ascii?Q?tFJlfkLTXakiDS07kLGUy9JkwYoVj9CxgthqtkM9eL2AOMJ9pOuan7M9O4jn?=
 =?us-ascii?Q?wQXLBcNjFWztThNOjdRcR5NILbJDoqE7xCVEHl6dTNFTYpp5brBsAs4MkDOM?=
 =?us-ascii?Q?t4TAtprbJjxGjPpub0NK3CYctQj43N/bLviyfFZzc1rYEzJ4Trw3gxE3x437?=
 =?us-ascii?Q?GMFzLejXD8gujWrYVx8iJ8HNjAIaQTf1YL7U/NiPM2+KOQ7440YBSIJRt/5w?=
 =?us-ascii?Q?YqiaPwTTU4GmUAqUAIkWksCdMYA2b7ZZEoFA/sBfadqUU2MCZFbtqOHPkq0n?=
 =?us-ascii?Q?jOhOVVVRj4cAWc/g/GIUKKj9bhputJABJaEU8BgR5nyeGUXQz6C2rITSkg5L?=
 =?us-ascii?Q?S+oatf5j6vrddLjZNZ2Sdqg42X3vcGPui5DWZ91j2ms7XQVOcUzKvefwirv1?=
 =?us-ascii?Q?N9hFpge2jFmVU3F3fJ4CoLhn2j/5clOnmrCEoNc6tD25wT7Mco6O0IBGaCgJ?=
 =?us-ascii?Q?i+kHrsupKiktHVWRlOvvsdarZ8WuMqPxiNgdWQ0Zbv0HmbzU9M51wOtY1X1+?=
 =?us-ascii?Q?xQqdqA+rxvtpZd2tIObYs8O9i99qxKc8kw6YYIWS9kbm5VoHiEUwDP/V5uIX?=
 =?us-ascii?Q?wdcm1JCFJOC40KlDHPWq21P7sknaVBN7m7L6QVHjp177M6yfLQlfuo+bSfVG?=
 =?us-ascii?Q?g4ay7KLzUIKBVJZh/oi9TKSVImUQiCSibqHZeWg+jCFP0iybY3ly5+/9outt?=
 =?us-ascii?Q?plJSGVo2eTbhnxpT0V9Uc8sljJw4O95uwkQeZtmy03ODzJ4t3ErHij+YFaC+?=
 =?us-ascii?Q?7UWQHDwVyrd+ggRIg888WwCne7wabFV/2R8fzT8nF5/W97KGfk3aEMY7ASbR?=
 =?us-ascii?Q?qxK5clgaaQftBPgXUDbpijdgNGvhLY4BLp4wqzO+9OBXoPmhdmFmfrVMz0Zr?=
 =?us-ascii?Q?yfQM/Knlg9J+oPC8/KGAM1EZA/2K1B1zUYRZAScAJiITqlhhk30SHupLN/mg?=
 =?us-ascii?Q?e5N9GkkjouR3Sx1P5wLdawa6p/ju2X2EKA2JB/weRkTf4jRgYzrZ2dZbj6Ac?=
 =?us-ascii?Q?U77wbIIKzQh1LGtSQ2ySFUmn2Up6tEVf6jC1oAX39e4HMtsKraV0isYTBWc/?=
 =?us-ascii?Q?Ip8lu4v9RqHrgsyrPK1xvvxrzcgYD3wu6CpqPlvk/kGfsyjU7OXIPb3560bS?=
 =?us-ascii?Q?9QCdoeONnsRMtYUUwPVxIYXDjJZ+knwT9i9fZ4CqPtdMh56QqbGiel1sd1B6?=
 =?us-ascii?Q?FtGwM9/bBs16OoKmdnc91FghDNc/I224qULD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:58:44.8846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d0b24f-aac6-45f8-17a0-08dd8487679f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357

The new type of vIOMMU for tegra241-cmdqv driver needs a driver-specific
user data. So, add data_len/uptr to the iommu_viommu_alloc uAPI and pass
it in via the viommu_alloc iommu op.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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
index fffa57063c60..a65153458a26 100644
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


