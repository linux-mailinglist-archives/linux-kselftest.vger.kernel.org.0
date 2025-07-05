Return-Path: <linux-kselftest+bounces-36613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3425AF9D28
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C674A48A0
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6089319CC02;
	Sat,  5 Jul 2025 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P0c9galQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2614716CD33;
	Sat,  5 Jul 2025 01:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678051; cv=fail; b=hn/HBgmLWhCCx2C5L9UVqC9QodfwdnweXXQFK+GuGp4uPeDC9Eafn71Mp1sqsHN2d+MrNSdK/Ta9XNgDsMdub+oVteaM3CGmI3+T9AywdNKZjeociDWQbxEe6X7HJvTz1Z6Bes4ZPZwLNzw/tRM1ZYz+/5UGtjs6et8JXpegLM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678051; c=relaxed/simple;
	bh=nJKm0QS9BWJE+JBw9k5eE5eZAkLDeHaLECx/29H8xbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMTX9oYU6UKHH04zNDeYnstFMd7raLe5nf18QBcRk0S1ZdYxRPAS7xkMuD3WtVTM3PpwhPIa/9cR0nOpix2DHuqPla3ajiz7eiDEme0sOUtRxbErLklMTExrguGftDBy8QrBeUGJLuN0HDvQO3lJ1WWiFk9e2ZQ6nimXIPvONqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P0c9galQ; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/FypPZp7LH3WSvRaQETOn7WUCj4ohSB0wmDm5Gs9fzTvtm/HQvSzpAw2+7n/7BRUmBAAUZpCro1cHYRx/cM1Z394sh9bgMPw9N0FPiOWOWHE65zYIe+fWlLnlVkij+BvwttanpCfN6PO/YCQpDgyvTAY/2sKNa9XaqE60tdWzENti5y57Or+/2dMGRSD/4HJtDPZ7k/hLye9b17FrZ9V4vvFZmLX9ofAXBbz1ZyP4xKMgA//onF8wcYtMKEXFd6We0LaJ6o/Ils4jkz9ODgN4d/KTKaUE+xzbmblq4fsnfriHdgoQE4mTed+vMv9SELkm93URzz61gAHuLRkK3UOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30m8au6V9OAekCzf4Jfhm4oIKOya7STtwhrPVoNu1Js=;
 b=FQyotPQW85lmwRGH+cjDrRnmn7zKqz9cjpO6T0NSzNijgEGdwhbJGNXBOCGGNgzVwkiEvUM8VuGjggwjtL08fjrXa3PwQRvgxwUQDFpt1/pqgq1KouKq3QuvdoEmkEZSExiIeWLDioqGO4wl9rdN8MnPqInAzz1A1M8tFv5Fv094JjRwgt/4fk7FwBjhEIV89Dq7pw/hF45idob9qUxyJ11y35GgYNJT49+Ue4ejyrknF+K9PfxcCuTz3qrxg2SS5dcIz/IGhbInpDvaZVvLY3y3Y7Ujzkm2HSzQN2WqQRH7RPaZd5oBOTgFP2gyGZo8dXkxHm/esNpoMSHZO8VIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30m8au6V9OAekCzf4Jfhm4oIKOya7STtwhrPVoNu1Js=;
 b=P0c9galQTG5fxghp25W4iM4762ziXoMIXVyMG5BezcIL2Usu8BJDY9q1iheOKiQo+GgsFJ7gun4mF/2pAz4u+bWpxRhT9Ov0R2qGn5PF6cFRspENfUwsKS3c088oADQrbKKp5g7t7j/fQtuizzwfNO2essiazFwaArgJKcema3Ifw/tNjf6P+WJLH/lUdQr6nCU5K0s2OCG8SrEoxtFQXizbjhRtGN/OmkvNhyu/aANIcd0ckh+4X4IOQCxizOEOyjyRmMT15K/eBqjUBNjCuDihkCiM2GBrvFQvDAGEZ3ujgrspAw6uFUI5329x0BO9t25/FK70lqMC70vByBedfw==
Received: from MN2PR15CA0062.namprd15.prod.outlook.com (2603:10b6:208:237::31)
 by CH1PPF2C6B99E0C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::609) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Sat, 5 Jul
 2025 01:14:04 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::1) by MN2PR15CA0062.outlook.office365.com
 (2603:10b6:208:237::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Sat,
 5 Jul 2025 01:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:13:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:13:58 -0700
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
Subject: [PATCH v8 03/29] iommufd/viommu: Explicitly define vdev->virt_id
Date: Fri, 4 Jul 2025 18:13:19 -0700
Message-ID: <146f91d9e1974cfdbbed3418373645295ce0cca1.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|CH1PPF2C6B99E0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 6331a2b6-e0f3-487f-1e65-08ddbb613b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uxxLG7LpirPYhStZjSFb1dIzzXNlS4ynSM7AAr4/uzTLYJL12QzBadYFFgGR?=
 =?us-ascii?Q?yhSxze4XwAzM8xOGCKlbkiukPJJLb4Ul/jL3QMMpNB6D56v5pv6dO68ywBOX?=
 =?us-ascii?Q?hU9EpByn4ExZm+0/btr9cmlknWUp8p7oPVNU0eE1On26PzY1xoqKGXEA8tXZ?=
 =?us-ascii?Q?cYxvM7tJMuEOFVrli4imp4u7q4UEzkf6CDTbjFXiG2kKnPRN5HmCF/+ghjPf?=
 =?us-ascii?Q?jNBx6otyM48hALwlu3LBDEER0PyBdkRBJgLdH+I5vjAsFNhS45kT+XKNYdFD?=
 =?us-ascii?Q?gMHKaZPdyi3meC+hSl5yZuXJhUBOJcNQiwJtnT4BMyHjFUiyvlD3aomHx1Z0?=
 =?us-ascii?Q?BuD42tllMRjeUohqvro++31YnvbuNa1fAO9Di5og5ZIgD4IsHf9HlW5X271F?=
 =?us-ascii?Q?hwnBven4hNUFyDAYnHjO1PrDb8SRdvECM3JqoCgFwjYTO5KjHP+Np5Wv76xa?=
 =?us-ascii?Q?28phOzBBlrl4p6ojxLo3Vf9uI1F4ww36vNdUm0K4uzWBSoiZ9uLCtTYmIflt?=
 =?us-ascii?Q?4CfosK4olYCpUuW3XDiLDeOLIK82FHV+UqRkxl6QRMa9Fdjch9mRdDZNWE2n?=
 =?us-ascii?Q?pmAz1+MBl+gnxN1G9RyjlHcwgfoLisaq1ekAcVRhXRbv8i2011X1Tjt2wEW8?=
 =?us-ascii?Q?z8eTz6d1k9AzOwYB6XAp10vzf4rccwqWp14rkBJ3aFERXAaxa1Dye5R53qDE?=
 =?us-ascii?Q?IBd7k7b3zUJBKSa3l8nj1B2a7JBC6aYin2GyNa37VcEnoi3+6yaP3kmI+0tG?=
 =?us-ascii?Q?JhltmOwE5STDPfRlGqjP9hOZtzgVYD3JRub+Kh6FTsCkdYcZ88oB0wPQ25pa?=
 =?us-ascii?Q?sDS2ggBbOUrt4VVFDfkbIkYrjZZC9Myn4jy16Tpo+B2fnajxbHi7bYTph3dE?=
 =?us-ascii?Q?5fvYOSnXz88l8Ou6GaclLLGERrSD/5Xr0Wizmn7R7STnEx3FvIjDeLCcgbpu?=
 =?us-ascii?Q?0w26TrOugmkQHiXp5mIgEyF6X764mjjwkNkIuN5OjufziQOXJ6zolOWQM9zO?=
 =?us-ascii?Q?mYfeOBcbOnPTmqTFZe8/1VDbMtOA7nAuzvaP8+YIFGuYzmuhVS/lMOoab9nt?=
 =?us-ascii?Q?Lmb6OyVgtFx03R8AdjiBVBpgGHZOn1ipbUbQp79+zuIGIDh+KH8LN5RdyM3S?=
 =?us-ascii?Q?SvmDCVpzbCqQY0e2oevx4yqq4uyiK9W81kBnZlXNzywgbEI3tLGdAtbrxKul?=
 =?us-ascii?Q?gQ1MaS/XJRzS690vFRl63PaCwS/ZTHErY+PJl2fpBjdkF2A/qBOF4ATzOSvc?=
 =?us-ascii?Q?2Ed7El/q2u1v38y9LvXsxv8Xo+DUODuIg9FD0rEI9vpOzBsOE2Duh0IeRICK?=
 =?us-ascii?Q?0bSa4OtqzqkjvY6baglvnejd54ZoZa1YZetNGeZgqiFuQS8EAdfjESknj4cp?=
 =?us-ascii?Q?zoTJsQ6GZbccShYi653iN8tZDtAjLM3gQY59zMD9Wl/3SrFrHGN4drvsFx+N?=
 =?us-ascii?Q?n6TCKly0IjzvT8xyLMgLSxiUD777NT3hEl7yLus5igbIET4LXu4Edc4Xn40R?=
 =?us-ascii?Q?rx4TwP0KAqpgDB5zlorbC//UnQQKudw8w7K8?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:03.4859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6331a2b6-e0f3-487f-1e65-08ddbb613b3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2C6B99E0C

The "id" is too genernal to get its meaning easily. Rename it explicitly to
"virt_id" and update the kdocs for readability. No functional changes.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 7 ++++++-
 drivers/iommu/iommufd/driver.c          | 2 +-
 drivers/iommu/iommufd/viommu.c          | 4 ++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 4f5e8cd99c96..320635a177b7 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -634,7 +634,12 @@ struct iommufd_vdevice {
 	struct iommufd_object obj;
 	struct iommufd_viommu *viommu;
 	struct device *dev;
-	u64 id; /* per-vIOMMU virtual ID */
+
+	/*
+	 * Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID of
+	 * AMD IOMMU, and vRID of Intel VT-d
+	 */
+	u64 virt_id;
 };
 
 #ifdef CONFIG_IOMMUFD_TEST
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 2fee399a148e..887719016804 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -30,7 +30,7 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 	xa_lock(&viommu->vdevs);
 	xa_for_each(&viommu->vdevs, index, vdev) {
 		if (vdev->dev == dev) {
-			*vdev_id = vdev->id;
+			*vdev_id = vdev->virt_id;
 			rc = 0;
 			break;
 		}
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 25ac08fbb52a..bc8796e6684e 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -111,7 +111,7 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 	struct iommufd_viommu *viommu = vdev->viommu;
 
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
-	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
+	xa_cmpxchg(&viommu->vdevs, vdev->virt_id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
 	put_device(vdev->dev);
 }
@@ -150,7 +150,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
-	vdev->id = virt_id;
+	vdev->virt_id = virt_id;
 	vdev->dev = idev->dev;
 	get_device(idev->dev);
 	vdev->viommu = viommu;
-- 
2.43.0


