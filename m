Return-Path: <linux-kselftest+bounces-33261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D141ABAD37
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9208C189BBB0
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BFF1F4CAF;
	Sun, 18 May 2025 03:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BGCihio+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AC31E231D;
	Sun, 18 May 2025 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538541; cv=fail; b=mBpKVpFVU6/Awkznb4nV18DGvMB7/ZT803NMeFLKm+CAhy7PAWTKs2XimzOLIQ/Uy8YlvheZebUUQAiTJ//NLeEvW9WOCPnrWxN3lfJe0duI2XN1jLh5pE/9v7ivnL/9VlveAIeStmIBikyt4WKl/pGacEsjgtyVetS17MTNuW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538541; c=relaxed/simple;
	bh=4Qdj7dcrUhQdBmsp0ZxPM+rvxqYqayik8fWg4Lx1dyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0t/2CC5n5J7UGhjR0tRc6xdol9s/UfPo+zvIs/hJC6tYle1EWyksXlaW8wqadLSqQds7Gc0eR4QTbS0D1tuP2fMUXy0ST6wO9CNLhHqsicYbOCq0agHWF1sS1d4T92wabyDwwjmPEKCqvN7SeME62a7ZH9W22FEdHbzk0hpvwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BGCihio+; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKaRDGvfWFYInMpVrL0dViso9fMbYCPYn+Dc6VEQAogWYIOo8eRBWoob6cSWQeI1D8uvbN5Ewj/WQeGFd9PIpdUo8Fsl5jfSY2aCLmJDpBYOOeL3g21d0jQdKgAy6ssD3ekQg4PetJ7is474VI/RlYb7NKvvpj/6iteYE+cWSHEXfJydoibGdo4qWgKsNMjw74bBGER2093fk6+zP6fVgrns2H+CjDBq/HhDyLsN7WhC2MgcsFK2E7Uy5vwWhObzwCjFwlynoPyEeW02lcqIcQG8X+zA0HnxCRvDvzj3XLzhhm3x7SHnvjG4v/Fv2CU+EwEKOW8LDo6DTbAQS5QJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSIBF7QlYQbzgnBnW/+kCu0Q9rN+aj/55AVMCJGWhuY=;
 b=tXerTuPScEIHov5HBUO1bK3IKKnHdRjxvPRv7x9lvr286dq7Y0ibCQguEw1lo9j47ZV07Cx0XutiKWWZf9xeZIXln1EUGF7XxrPAgoZ3WJ0zMiQrHlZJNUObjqGqkbJXlQZQRsPtPtL5P4mkdTG52H+u5FmGjHFHqh+oEduVunPZc/tYgVnglfj85OZdvaBxletTWSAwDr31BNDv77bak43RQp0/InJxrFgEFNw/6I8EC30TFt7Xg8ZKfbMOMFkx7uKD/3UEyXPCM8TsykiSVF7Ziv80PDgYPnsWT0rUOoO0eYYhRZIZs+fdMM1ll8YkNX7WQjG9mn7WdSjmrpM6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSIBF7QlYQbzgnBnW/+kCu0Q9rN+aj/55AVMCJGWhuY=;
 b=BGCihio+9Cz1K30lYZRwM4eeNJPGPl5o1RNb6nbm6/X6IbAgbAxlWNTInM61Shqzt/3pfqpTnqY3mQn9Jvhn7kBSCJYHti72sEwGnhqdEVHFly87sNuvy9d5A1oFHm1gM2IC4uSON2HLYuYeewUOzOq0t3CB5igQvorx4SnT8JTN7CT6AxO+1Z0vIEwGSHOmbM3N6dvO6bbb0cn7COEWhwXSG1HgGzgdJYfdxM11vHVOvdhUkSecYOAR1aNx57/00jCu3kQpDNU2hsRbux4j6ViQefxZ27T41F90SKx3ttJjIVSb8cJBb8mIW5lFwZjc+lty3rsl9v8D632ykhFoXg==
Received: from SN6PR08CA0026.namprd08.prod.outlook.com (2603:10b6:805:66::39)
 by CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Sun, 18 May
 2025 03:22:14 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::ef) by SN6PR08CA0026.outlook.office365.com
 (2603:10b6:805:66::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Sun,
 18 May 2025 03:22:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:04 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:02 -0700
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
Subject: [PATCH v5 05/29] iommu: Pass in a driver-level user data structure to viommu_alloc op
Date: Sat, 17 May 2025 20:21:22 -0700
Message-ID: <b17cfe6289bd8bfdb1f265b17361a18374d9d4ed.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e3ce71-ac20-49c2-65e9-08dd95bb2f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qIFcNdnYHHTtVwfhHv+ZIaM8XKR0H48hRhLW2d5bNQqZNRr3uNFkrc2dtjts?=
 =?us-ascii?Q?tzSLyvH0WQGEq8V7SdX143NIYfmEjRowoJ3jc5AiGD1gnImLnB6Xi2YJmEl8?=
 =?us-ascii?Q?d9N0eZBIiV1MircqWO1Pg6cXZDCKBm5cv9aPhOtS30oy8WRheJFm+5atVY1O?=
 =?us-ascii?Q?vA2DD6iYx07Rx4WK5/S59wsoD4SwcjEtgfzu0Dekek/Vrk+ly/JgJYN9DREO?=
 =?us-ascii?Q?7nkUYxWw4RoGUKH6krZCo+dbZQDNUGrjHyaq4qlmljzd9zNg/JHebyxFIpuz?=
 =?us-ascii?Q?v2m0eWa47UDCKmKWMXUQyaDnPSJlc2iuwVM6nQUSWP+L41GysTeCyV5+ZwiR?=
 =?us-ascii?Q?VSKGCri/D8Pwpth1Ci1U4HCymvSm3T8LtGUZfja2fYq7Ezp2HHLm7WsJVzwz?=
 =?us-ascii?Q?yg29LQdpyq/iFdq0xl346SuLMCnyDediy1iP/AyYOJCnEdF/b86KQChzhCcf?=
 =?us-ascii?Q?KK2nIJpASzowksFEJr8Ew/lkfEV41Jxaps3hCsoFcEM64SyzDFVFVroWXq5l?=
 =?us-ascii?Q?2AUbFrmeWysaH16ehH1cf1mJGWZPvvBTvmgKV+pyx/5cO4m7KOZUO00VEb/x?=
 =?us-ascii?Q?YT3biBNBFKULwGHp5rmCjNAPTkEtLiYsCjyschWFNgLhGHutMweWNRC+MAes?=
 =?us-ascii?Q?JqLFz8FwyQdvMSCDneyneeVwL9DzzmitQ5lN4hiO2i3gFnZqUPOJQxevYayL?=
 =?us-ascii?Q?wEyjOVwXL0FSMGwsVLEMeDBbrG2mRWagx24qRJA16F0QPGgWKcYHQMPXA4K+?=
 =?us-ascii?Q?lJKDMwdsfULhZ9wfyaKAXrCmW/7emaIST2CIzVAT1hmHDZoCp+l2PO9zH6q3?=
 =?us-ascii?Q?zDE6TBGvlIfSW017G2OUJntAPBO7KpKkSq6JMq4rnwbessN2hCzK9sFdhgs6?=
 =?us-ascii?Q?k8RpkYuXVWetMuKdvr5okaNzz/25ozt/VsJ+3EBEWI8VMliyNzbDvDYpWpP4?=
 =?us-ascii?Q?Q8UUIndn6nPJ6f7qzMqfNFAbWe6cJRPd+osKzpRVV1f/LSzb+8QfdIOwy5v+?=
 =?us-ascii?Q?Hov1tnn90UqSO2QJzRJbOzRcVuiOXuiHvAMAvqKusc+rZNCiDYmw0bVfwHG0?=
 =?us-ascii?Q?tATaBTUfemhps3Im5VNe249CoHnt3yVypOP3CugasPXgf45KZ2WXOX8wvM5j?=
 =?us-ascii?Q?LX7vh03ixohFZFEvduAVloEdGMQwi/G35ZO5uW0xEst7nqpFYTQeP0NllHvh?=
 =?us-ascii?Q?BOBI3fYZ4hCmEeGRN9WL1KdtgmPCBinMTE4UGl2kok7VYCp0PtDcFppCt5tW?=
 =?us-ascii?Q?NOTT/LKzon5mC8pi3/p6RO08tE7NWvF7SJvDJ636cu429GztPwtMfrrrQnLF?=
 =?us-ascii?Q?Ee1L/zYjwb6CgzMxHV/iySiVCwITTuxuJXphgwpbB2ehCHlxysfMeSOKAx1o?=
 =?us-ascii?Q?Ynw7XZwGKWrN2OzZ+Bkumq3i/T31QflHLBT5fTu3L966UkO98OAN78Q28NCS?=
 =?us-ascii?Q?ptwSTH2DtRC2rYV6PzeEBAe1uSmTQnVy79BUVFXQz7wKXz7yb2Lg7zEaXBlr?=
 =?us-ascii?Q?V+H3i9CcxeNpXQZ2Z9Y6ICHqxbvwhZk9lrMG?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:14.0614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e3ce71-ac20-49c2-65e9-08dd95bb2f57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387

The new type of vIOMMU for tegra241-cmdqv allows user space VM to use one
of its virtual command queue HW resources exclusively. This requires user
space to mmap the corresponding MMIO page from kernel space for direct HW
control.

To forward the mmap info (offset and length), iommufd should add a driver
specific data structure to the IOMMUFD_CMD_VIOMMU_ALLOC ioctl, for driver
to output the info during the allocation back to user space.

Similar to the existing ioctls and their IOMMU handlers, add a user_data
to viommu_alloc op to bridge between iommufd and drivers.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 3 ++-
 include/linux/iommu.h                               | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ++-
 drivers/iommu/iommufd/selftest.c                    | 8 ++++----
 drivers/iommu/iommufd/viommu.c                      | 2 +-
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4f9aacad0091..cb93eff4d9ab 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1062,7 +1062,8 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type);
 struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 				       struct iommu_domain *parent,
 				       struct iommufd_ucmd *ucmd,
-				       unsigned int viommu_type);
+				       unsigned int viommu_type,
+				       const struct iommu_user_data *user_data);
 int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct arm_smmu_nested_domain *nested_domain);
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5f9c4eaaaaff..4c54dd8f94e4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -702,7 +702,8 @@ struct iommu_ops {
 
 	struct iommufd_viommu *(*viommu_alloc)(
 		struct device *dev, struct iommu_domain *parent_domain,
-		struct iommufd_ucmd *ucmd, unsigned int viommu_type);
+		struct iommufd_ucmd *ucmd, unsigned int viommu_type,
+		const struct iommu_user_data *user_data);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 5d50bd8f4c2c..adef56db4028 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -385,7 +385,8 @@ static const struct iommufd_viommu_ops arm_vsmmu_ops = {
 struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 				       struct iommu_domain *parent,
 				       struct iommufd_ucmd *ucmd,
-				       unsigned int viommu_type)
+				       unsigned int viommu_type,
+				       const struct iommu_user_data *user_data)
 {
 	struct arm_smmu_device *smmu =
 		iommu_get_iommu_dev(dev, struct arm_smmu_device, iommu);
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 4b021dc50758..3d56e2bddb0b 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -733,10 +733,10 @@ static struct iommufd_viommu_ops mock_viommu_ops = {
 	.cache_invalidate = mock_viommu_cache_invalidate,
 };
 
-static struct iommufd_viommu *mock_viommu_alloc(struct device *dev,
-						struct iommu_domain *domain,
-						struct iommufd_ucmd *ucmd,
-						unsigned int viommu_type)
+static struct iommufd_viommu *
+mock_viommu_alloc(struct device *dev, struct iommu_domain *domain,
+		  struct iommufd_ucmd *ucmd, unsigned int viommu_type,
+		  const struct iommu_user_data *user_data)
 {
 	struct mock_iommu_device *mock_iommu =
 		iommu_get_iommu_dev(dev, struct mock_iommu_device, iommu_dev);
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 6d874d6a4c00..b50b50ec87da 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -48,7 +48,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	}
 
 	viommu = ops->viommu_alloc(idev->dev, hwpt_paging->common.domain, ucmd,
-				   cmd->type);
+				   cmd->type, NULL);
 	if (IS_ERR(viommu)) {
 		rc = PTR_ERR(viommu);
 		goto out_put_hwpt;
-- 
2.43.0


