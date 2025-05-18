Return-Path: <linux-kselftest+bounces-33264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D19ABAD43
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025373BD74B
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8608F20012C;
	Sun, 18 May 2025 03:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ujexCyjE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B559D1FF1C8;
	Sun, 18 May 2025 03:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538552; cv=fail; b=EkBeAT/0/JJJXwKiNcQw684SpvIiryjrpTCBjUvzUChLnZeJTWVyK2RLCfes/AhLhfU63YtRKFzvhUaBXqJWh5HmDdPcgUBF100iB5miiRCZtSUN1cRzfcE95XqKQJPV8yUBi8bvhl/L5r4rfN0MMwbIMk8ZEjXnpbu0LBx7MKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538552; c=relaxed/simple;
	bh=UHfAA2RbMieMKmU7qlmbZmXfwmfdwQ26hvEHbqjs7+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgJoZ+DVhR5JAD+s/Zry1l2ok/3h7zN0fmUUMbVyLXDghRqzr4RKEI9yttU04jS0Q6ZzkKBvlb8mE+tw30ed3DLiaaBc3hIXyzSHabMMaaajoeenZdm5ILa6UfQsCLD2n9/ITXn/T0pkOD5WFwqsjIUX7CU5dS5uxsDjqbGRqns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ujexCyjE; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsI44ayAXqtHk8ksqoJeZ73mTgroSvUuF757f3Ko3LaIxTtVZZZ7t9kSVOOYlF+MfqHK+ZnJCLKfmGBXZygMZnqOGvrpUDe6HbLdbvZ1v3n7xwXwExsXCzyan8bA4QZTxO5R4itvMHGrr/Z9UO83HG79IE9GuBjNTQdMDzQmAve95jm9FGLOSWp3S6771igzA2khQqKbp31T89w16kBdYPlh2PEEEdf7PrusRmt2fb14lfU0Tf9A0X2MhREeBLmCgeua60lZBjAEMkh2SkXrymKKM96h69W42cE4CS5KN+fazZknSs5NQNWFOLPDrSY9H/eWTwwGkgalEaSs0b2SeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvEh6Lc+j8gmh2qUaGAI7oEkwXQCTLpjuw1DJxYLP2k=;
 b=l0+9lT9DPOSTOGwXPL0vhv7kGWeSwdNm99eJGVx+47UBr45fv0rJRfOJFYuBEvJQlMWGLu2ZfO6QuTMoO3D73dIhszzpEdBGxfXUQVZ7gxD4aFyYyiIqDrT5Kszxt4HACIyPNzqfTJb0eetGnN02O67Kmaaw2QcuYz+AKF6k8hq+jNwz4SjCRWr/lZjyAzHXxkj5ZfyPE0jzAG7hESRelpfRHvfd9jRW66yVJibhHlurj4qRnEY6CC2G5gAo8d704hf2zke60WVDl6bjFUv2vetMxAO59lCPVXXWuWQZKt9mHEDd80TPL53t3/x8La2lB1K7KbC1sWgEtzAH2lS4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvEh6Lc+j8gmh2qUaGAI7oEkwXQCTLpjuw1DJxYLP2k=;
 b=ujexCyjECFkaQPHr0uAvBFV0+61Zv5Zn2oad5MvtOWEmJ3elshyn6KZdzgZ/Ddh4HrrnlzyL/Nv8hQRGct3LJMjBgRW2f4miKUVAYq7uVLQdvS+UAw6WB5X4A+oeZAdsbTVyX5utOGZqSqax6NFC4UJiN2lYUeg40ipbQ8cyB6k/bh8zfMzizDC+kO9NwnEdUk3yjbwwrp8Vy+Prx2d04qccG6+RPWuslFkEIi6gP4d1uEyl/iW5X/ISyGgFtHvdqReh42lFrZIYNXq/ohSFqFpn/b/daubkQX+Yu2ESTCRbBznBI8nqnYZ2UOg90HJ23knQB82bocjAb3grNuA+Yw==
Received: from DS7PR03CA0291.namprd03.prod.outlook.com (2603:10b6:5:3ad::26)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Sun, 18 May
 2025 03:22:26 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::2d) by DS7PR03CA0291.outlook.office365.com
 (2603:10b6:5:3ad::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.25 via Frontend Transport; Sun,
 18 May 2025 03:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:13 -0700
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
Subject: [PATCH v5 11/29] iommufd/driver: Let iommufd_viommu_alloc helper save ictx to viommu->ictx
Date: Sat, 17 May 2025 20:21:28 -0700
Message-ID: <c19f83dba1708cea09911853d3a3040dc95d828d.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6d7555-e76c-41fe-d1c7-08dd95bb369e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RnPfHHxfPSe4wu9CxcNo7O75ybBAP24DsfAxBVwA4QBdXPRsmizTV5IyMokI?=
 =?us-ascii?Q?SI9mjgDrs1HxKKKGevKSZ2wx7N+YMpTHt7H1rjDOWHABvhJoi584ayq/sTmu?=
 =?us-ascii?Q?mec7yfbZ06JlCFCaLIyb0XZw92IjmKmvrMsA9hsnRaANK+J/p5Oe+e1Wjmt+?=
 =?us-ascii?Q?Fk/Carmrig7Zgc02AMBdxX60QbWCqq4Ylr+kmqJoCuMxJZgu0fbHoroVdafu?=
 =?us-ascii?Q?bP9npnYew+PpadbP/42NUFdE9fyV++3dJbMDZmLCA9e+r8nX0cIuCnrIroN0?=
 =?us-ascii?Q?GU1gpFH/G9YaPPdRX5RjGVdzC1GfKuGcDwZzETavC95rhXRSq41TIBH4VgWV?=
 =?us-ascii?Q?Yi7ghrlGpXZg7kGTU1HJH/IBc0QVaYommumhWUyGDW/loInTq028x1sJyMMF?=
 =?us-ascii?Q?dfwqOS1zy7NKxSb2dWY+1fPJhstu8cVNOuiBKgvXXsr3EAwnue2wxxodRozN?=
 =?us-ascii?Q?hkWWLbB4UKDyATca505kyO3vKQ9gXat8lt2iyejW1z9u4S4jA9eg7HPPJ7rg?=
 =?us-ascii?Q?kv95ROwhfcmECcUrVS7cAamvVcmXLdksJAdXo5GqrBjVkfNEM7iCeBVJBumg?=
 =?us-ascii?Q?9ATDocynT6MXyNLVDvEHTuA2xkNGwnwr6M+5xNwH/6S7wxJFNRU4nEeaC3f8?=
 =?us-ascii?Q?bZcSp1JJ4MnG+AGYB2lVu27dRfufQcBgFcYtktOBDM3hFOnX9VA9qzMTynYq?=
 =?us-ascii?Q?+FY80YdAtMvJqZ8Wr5dJQ8TMXvYhxih1bssSNBtfTglhKbMS2A2QI6ElIoCl?=
 =?us-ascii?Q?iiRQMW4iF1SaVR4GI12RkjpcUApqZ5YfVUcmfaYiINvfaWB8BV6UDq14VSCA?=
 =?us-ascii?Q?51Qqj2Vbr/VNZU5q1QuyU74QU4xT4BvJPZmMcvcAKQ2FvXw+ukmL/9rzRIHj?=
 =?us-ascii?Q?QWGyVeIfM5z+D+SBmHWiJ3bec6btMQdjnXluPcMKcANtpfbPzo9XU+/tKHUQ?=
 =?us-ascii?Q?R0wzqMSaGPNMbGmT8pZ4C4gvdqEVIXAP5MnBkbuACJfIbc5eLcIznATEufSy?=
 =?us-ascii?Q?JazVBP2hyIYB+QeGMtMpGRjt5PLvZ46NEcaLBohfMbCYROQX66O+YIOVF7Bl?=
 =?us-ascii?Q?y+nWFmUNkf0I01vocAZfLVQRgO6ZPf9MIFbZDz5ZOEn7nYJLxfAw6tMpNx/m?=
 =?us-ascii?Q?/hApwKtWDW3P6QbOv/TZ3LTp+l9TItx0VtQyuoBVWhECwL7QQ41KpN86pLL6?=
 =?us-ascii?Q?cxlWjIKb5xh0EJRtRswVxQuWORcr0QjwLyVF76HfWnGUQhIj3xYxWlqTuoNR?=
 =?us-ascii?Q?QDg0ELG/luRloK/Z6jjzz+nkP9BDIBc7UE/CLDISusJ+fs/uir7351hHPzVB?=
 =?us-ascii?Q?q7+kGTqnXlaQd4xPGa4t9Xx6GQ8OFhYB/YSCY4LNjEuo597QXxvvhJG1NqZM?=
 =?us-ascii?Q?B8GLhQ3KxKNaj8q3fKDqdxagrDkIZXRSjCAu+uZRVJPdKBv2ECIOd2e6E/nk?=
 =?us-ascii?Q?pSRO9WmHxvsIZsPVfadZsCNPJh0QrT0A8qc/r6nIrkOpRTyOBj87jNwKrLbt?=
 =?us-ascii?Q?NWcMygrlgx2CriDJYhOdVLHzPJXaR/nJobZc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:26.2770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6d7555-e76c-41fe-d1c7-08dd95bb369e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159

When an IOMMU driver calls iommufd_viommu_alloc(), it must pass in an ictx
pointer as the underlying _iommufd_object_alloc() helper function requires
that to allocate a new object. However, neither the iommufd_viommu_alloc()
nor its underlying _iommufd_object_alloc() saves the ictx in the allocated
viommu object, although viommu could hold an ictx pointer.

When the IOMMU driver wants to use another iommufd function passing in the
allocated viommu, it could have avoided passing in the ictx pointer again,
if viommu->ictx is valid.

Save ictx to viommu->ictx in the iommufd_viommu_alloc(), in order to ease
a new vIOMMU-based helper that would then get the ictx from viommu->ictx.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  8 --------
 include/linux/iommufd.h                 | 12 +++++++++++-
 drivers/iommu/iommufd/viommu.c          |  7 ++++++-
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index cef3e0e0bbb2..44286216ac5a 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -136,14 +136,6 @@ int iopt_pin_pages(struct io_pagetable *iopt, unsigned long iova,
 void iopt_unpin_pages(struct io_pagetable *iopt, unsigned long iova,
 		      unsigned long length, bool is_owner);
 
-struct iommufd_ucmd {
-	struct iommufd_ctx *ictx;
-	void __user *ubuffer;
-	u32 user_size;
-	void *cmd;
-	struct iommufd_object *new_obj;
-};
-
 int iommufd_vfio_ioctl(struct iommufd_ctx *ictx, unsigned int cmd,
 		       unsigned long arg);
 
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index d74c97feb9b5..a07466333c48 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -52,6 +52,14 @@ struct iommufd_object {
 	unsigned int id;
 };
 
+struct iommufd_ucmd {
+	struct iommufd_ctx *ictx;
+	void __user *ubuffer;
+	u32 user_size;
+	void *cmd;
+	struct iommufd_object *new_obj;
+};
+
 #define __iommufd_object_alloc_ucmd(ucmd, ptr, type, obj)                      \
 	container_of(_iommufd_object_alloc_ucmd(                               \
 			     ucmd,                                             \
@@ -262,8 +270,10 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 									       \
 		ret = (drv_struct *)__iommufd_object_alloc_ucmd(               \
 			ucmd, ret, IOMMUFD_OBJ_VIOMMU, member.obj);            \
-		if (!IS_ERR(ret))                                              \
+		if (!IS_ERR(ret)) {                                            \
 			ret->member.ops = viommu_ops;                          \
+			ret->member.ictx = ucmd->ictx;                         \
+		}                                                              \
 		ret;                                                           \
 	})
 #endif
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 2b30627d1d8e..662f5c1b1935 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -60,9 +60,14 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_hwpt;
 	}
 
+	/* The iommufd_viommu_alloc helper saves ucmd->ictx in viommu->ictx */
+	if (WARN_ON_ONCE(viommu->ictx != ucmd->ictx)) {
+		rc = -EINVAL;
+		goto out_put_hwpt;
+	}
+
 	xa_init(&viommu->vdevs);
 	viommu->type = cmd->type;
-	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
 	refcount_inc(&viommu->hwpt->common.obj.users);
 	INIT_LIST_HEAD(&viommu->veventqs);
-- 
2.43.0


