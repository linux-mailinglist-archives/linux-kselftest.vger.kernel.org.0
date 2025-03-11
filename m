Return-Path: <linux-kselftest+bounces-28767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3772BA5CFB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6410189E6C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D12E264A7B;
	Tue, 11 Mar 2025 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FsP4jUgD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F0C264638;
	Tue, 11 Mar 2025 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722337; cv=fail; b=he3Trj5bQsDTysE92riqxRz08C5YUCjBoqhhx6QpJP/i5lOAOEqnbuCaR25dAJLxzRU1c+WRGJVfM+h04f5vP283/wSujDgak+4tuuBscexZYaB8X/QjRb/FA2oRmKYRKKjrBWKHg+KucH098RZBnRYq2iobaTfBxwlhIMj0zpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722337; c=relaxed/simple;
	bh=xWBSgKXfCZJspqtK8RXUTQ64g0V0TrCaPdQGOyyV6wU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RT21rSclW13IkMfoZyjb6Ma/lt7WGs5r8fQSpE/W3y0VS6jHyDq2X9KY41cOgBDdJn4lrks1GcCqjZEEtTuT4Sd9HSKG2v8aSIclIwAbNej/t2ysEr237i8/MszIXdMt/4gywbhhvZqNJc4hMqUHWxtjRHvaOvHXUEYSEekBVxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FsP4jUgD; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcVBYG6Swkoegq5oOj9zhjmOMGs/yiokTuLiYwBnKfTnSOwy9FCuQdgZAnsKBH3OCSV/24r6DcVoA84/PWE9v93CkMADVDRH3+mCwPAecB3LaOpmaA8EQ02Ji8c9Ku+kUYWb88GcLvWJihU8piGbgB3T2e3NLx1AcJ1iDb55tZRqInL1ndXbCnjv02I4xo7ppQaTVZ82JiufW+bkPp2oACgKS4qkHxp82RoXgoa94rzKScikypKcTLI51V4Sokqglk1859nGhDw1/l/LsyDxDhg67k8Wap5JKpKruvbQap5vZRmqYTq337Slm8o9Viqg7s8so5rSdpD/6zbjxQQDsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9u0SFMN96KsPXoxMU/7TYYEUCxKd75WWRmS+1LzAEAM=;
 b=UsP0K7bSmXvs+mLQGC5oVUJale5doOmruRpdeQOWCl4UOsYUj/Wq3aL06acZEW9Yv++xJ8897iwGd1TAMOMwvIw/xMRWpypoFodaatvpiHUepPkIvWJ2OWuov9+SjSLkXE3mGiD5yDlc5B66mbcmpgbw0C9xEhfaP6fxwx35NdvVqqG5S9FVsBe2+obmezCzBXgwJd5ttER/QsF3LpFXT1q4URUAmHaQ3kjCHhpujW0S7qlNitb/7H26wWImMZwWxXnlyH/RB7b5SYBMRlfGNpPEti+mpEHE2eOcnO/6EI7sv3dXPPVjX/k4aT0+iDNdx9wpbRh+QnABpUW0Z6/OIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u0SFMN96KsPXoxMU/7TYYEUCxKd75WWRmS+1LzAEAM=;
 b=FsP4jUgDxYCPNEFe0/F7AuoKnrR/3ZFJCou9i42k6L3U3dhHM2f3uiuMA9M65zJ0IhAJLgSlicEhpOzoDghhQVRVRRUt2cSY2mBXiQnBQEIumifbDKBx5RblDTVmCG0C9kor9nho6pv4Za6xhMDrY5G2GTJ7lJsGsW2rP+X/rqMcEjE9cEllely892WeLypl8BrsKCwZAkAKBjbSWxSA1RG6KzOpqouZppUNbK4db4YcAi0G6XQMP9ppMx06sYfj0YFL/WY217MN1fnhUKn8s8vNLyTgd6aGsiMJzb3icolNGuJjhyM4mRf6Bw6RerYtvJXTrWwVID3pS/h5Hd8tmQ==
Received: from BY5PR17CA0065.namprd17.prod.outlook.com (2603:10b6:a03:167::42)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 19:45:28 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::9a) by BY5PR17CA0065.outlook.office365.com
 (2603:10b6:a03:167::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 19:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 19:45:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 12:45:12 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 12:45:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 12:45:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v9 03/14] iommufd: Abstract an iommufd_eventq from iommufd_fault
Date: Tue, 11 Mar 2025 12:44:21 -0700
Message-ID: <e7336a857954209aabb466e0694aab323da95d90.1741719725.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741719725.git.nicolinc@nvidia.com>
References: <cover.1741719725.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 4983cc9b-86d0-4b3a-7c0e-08dd60d54649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LzSPTqydposMEJpIBgli4fEBKFgCO0leESzjkT/7/o3PMJJCfB1wnGoWp8lD?=
 =?us-ascii?Q?pMP5iwRjv93xK73BeGt+OF3W4t6vvhsiC/Dwj3OfeOxqfCIncgHzBTIEPmjO?=
 =?us-ascii?Q?tDrwF6wg8mi3YVtpd/Fdvf0UlCneKMP6IWi68qSpTMRbxnJB1wb1q77RyZkO?=
 =?us-ascii?Q?QBQXEe0lP21Gyel0JNqnqN/Avg4O2VP9zi+BL87zoKoJ/4UMsOl8DAEqhYko?=
 =?us-ascii?Q?+35gjq5xv4rcrkVxCmxi+7XczC112sQmyPpEnu+IQFfgRBkQk9pNp8HVmZRp?=
 =?us-ascii?Q?vL9Zkwxes6rynNgqZlyqvPsAOCbTH1DjDOGRODdOa1BrNhOe7aR2ZfPwEQTf?=
 =?us-ascii?Q?La0xaZBzzHpWf3/nfsGgpoQKzGww0VOQ7PjgvsrSQ5IjtVoALohiQQm45WXJ?=
 =?us-ascii?Q?Od6nigFpCRjcOBppiVIRfy+Hriag1cKG4zlP2qLC/4zjB+8YY9UR3yUjHwnG?=
 =?us-ascii?Q?3+lDos5f5K5UQxsM4aLzZI4AMsRVHm87eBCOLMX0Bc5KA4hc9Q1zyvjPnlTG?=
 =?us-ascii?Q?DHm6ldp7bYRXfLymXV6lF48Vn/X+2t7+riJJ8J0rkWHhx93fXzULP+ekCFLS?=
 =?us-ascii?Q?c6Du0WGdir87LBRy94p1Ike7aXAY/7NL0O01j4Fql8uY5AfUq+t3zkNS9VO4?=
 =?us-ascii?Q?LV4UR33vVFRi1GYCPQ0JeNO+aKiUPIHUcX91q5D43fioqvKhNCi0RgsnEZHn?=
 =?us-ascii?Q?ZnV9fvxZtHk/GJZY4ZhYlpZCi79WRTkqJFtblyaxCE4oipsa0cqW5X//XvSV?=
 =?us-ascii?Q?Tloh20LDvsRnenEjL0xCQ+C78NoxpvK2ot/cfYv0VDYrGqNaNFEMWW+ubv54?=
 =?us-ascii?Q?EGC/hf6Vx+k/NDecRkB+5Q8UTEBBwr/9KvbkWBalW5LuOQ9LATkvEPYo2RM+?=
 =?us-ascii?Q?huRoY5KXRv3G4wO8jmNROemUmu/OjtpY9rcjmKL37EKd9F26Wm3NCeuZq/C6?=
 =?us-ascii?Q?QQFtYlenkKenIIyxBO6C5F86ukLHkIgtmTPFpUZtgrvsCz1H4MMSFwLusClZ?=
 =?us-ascii?Q?EQDsdtbAH6jCju0tgQRkbxhHRPFszhzaBtv08seSXixWKPUtNXsvIod02kE+?=
 =?us-ascii?Q?sjJtcG64wWx9tsU/unzmc3oMJUCS5dKSJrEeCKKnGAG43BQo8Jn9xJHkGExx?=
 =?us-ascii?Q?CNPCmfJihRQWbX7fOdkqxNgJR3IzJ77h8qqEiyXR3Kb7zk752NKFnxntvOdw?=
 =?us-ascii?Q?I97KwpFB1HYUCIIZZ4EteD1MS2o0qiq6YBIyzjmYHeY1O5o4Um/3vjDQd6Jt?=
 =?us-ascii?Q?JVCqYxRQLR0rIS/y4r70w7Hw+fueRoPg98f4Zn3lC+k7vOV2aM6aWf74AkLp?=
 =?us-ascii?Q?OhLVNj9Vig7eHfAW3b8GXmg88y64bJfzz/ZODVjtlPuQa+BQML7GJNPTEdlX?=
 =?us-ascii?Q?TOqASn6inViWOGGembIWpWUmo1KMrGDDv99jOnSp7iG6QYAi2TfpSg7oXwvO?=
 =?us-ascii?Q?gEN3UTsfynoxFsTNrd6++p2yjY8E24/XvZ3RWtKqfi+y98AGCq0O63IpSzvd?=
 =?us-ascii?Q?/FZ4qiD5pOgzgCM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 19:45:27.9531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4983cc9b-86d0-4b3a-7c0e-08dd60d54649
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233

The fault object was designed exclusively for hwpt's IO page faults (PRI).
But its queue implementation can be reused for other purposes too, such as
hardware IRQ and event injections to user space.

Meanwhile, a fault object holds a list of faults. So it's more accurate to
call it a "fault queue". Combining the reusing idea above, abstract a new
iommufd_eventq as a common structure embedded into struct iommufd_fault,
similar to hwpt_paging holding a common hwpt.

Add a common iommufd_eventq_ops and iommufd_eventq_init to prepare for an
IOMMUFD_OBJ_VEVENTQ (vIOMMU Event Queue).

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  28 ++++--
 drivers/iommu/iommufd/fault.c           | 111 +++++++++++++-----------
 drivers/iommu/iommufd/hw_pagetable.c    |   6 +-
 3 files changed, 82 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 1c58f5fe17b4..44fb30af10b0 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -454,20 +454,13 @@ void iopt_remove_access(struct io_pagetable *iopt,
 			u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
-/*
- * An iommufd_fault object represents an interface to deliver I/O page faults
- * to the user space. These objects are created/destroyed by the user space and
- * associated with hardware page table objects during page-table allocation.
- */
-struct iommufd_fault {
+struct iommufd_eventq {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct file *filep;
 
 	spinlock_t lock; /* protects the deliver list */
 	struct list_head deliver;
-	struct mutex mutex; /* serializes response flows */
-	struct xarray response;
 
 	struct wait_queue_head wait_queue;
 };
@@ -480,12 +473,29 @@ struct iommufd_attach_handle {
 /* Convert an iommu attach handle to iommufd handle. */
 #define to_iommufd_handle(hdl)	container_of(hdl, struct iommufd_attach_handle, handle)
 
+/*
+ * An iommufd_fault object represents an interface to deliver I/O page faults
+ * to the user space. These objects are created/destroyed by the user space and
+ * associated with hardware page table objects during page-table allocation.
+ */
+struct iommufd_fault {
+	struct iommufd_eventq common;
+	struct mutex mutex; /* serializes response flows */
+	struct xarray response;
+};
+
+static inline struct iommufd_fault *
+eventq_to_fault(struct iommufd_eventq *eventq)
+{
+	return container_of(eventq, struct iommufd_fault, common);
+}
+
 static inline struct iommufd_fault *
 iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
 {
 	return container_of(iommufd_get_object(ucmd->ictx, id,
 					       IOMMUFD_OBJ_FAULT),
-			    struct iommufd_fault, obj);
+			    struct iommufd_fault, common.obj);
 }
 
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 5d8de98732b6..f8e60e5879d1 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -17,6 +17,8 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
+/* IOMMUFD_OBJ_FAULT Functions */
+
 int iommufd_fault_iopf_enable(struct iommufd_device *idev)
 {
 	struct device *dev = idev->dev;
@@ -73,13 +75,13 @@ void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 	INIT_LIST_HEAD(&free_list);
 
 	mutex_lock(&fault->mutex);
-	spin_lock(&fault->lock);
-	list_for_each_entry_safe(group, next, &fault->deliver, node) {
+	spin_lock(&fault->common.lock);
+	list_for_each_entry_safe(group, next, &fault->common.deliver, node) {
 		if (group->attach_handle != &handle->handle)
 			continue;
 		list_move(&group->node, &free_list);
 	}
-	spin_unlock(&fault->lock);
+	spin_unlock(&fault->common.lock);
 
 	list_for_each_entry_safe(group, next, &free_list, node) {
 		list_del(&group->node);
@@ -99,7 +101,9 @@ void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 
 void iommufd_fault_destroy(struct iommufd_object *obj)
 {
-	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
+	struct iommufd_eventq *eventq =
+		container_of(obj, struct iommufd_eventq, obj);
+	struct iommufd_fault *fault = eventq_to_fault(eventq);
 	struct iopf_group *group, *next;
 	unsigned long index;
 
@@ -109,7 +113,7 @@ void iommufd_fault_destroy(struct iommufd_object *obj)
 	 * accessing this pointer. Therefore, acquiring the mutex here
 	 * is unnecessary.
 	 */
-	list_for_each_entry_safe(group, next, &fault->deliver, node) {
+	list_for_each_entry_safe(group, next, &fault->common.deliver, node) {
 		list_del(&group->node);
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
@@ -142,15 +146,15 @@ static void iommufd_compose_fault_message(struct iommu_fault *fault,
 static struct iopf_group *
 iommufd_fault_deliver_fetch(struct iommufd_fault *fault)
 {
-	struct list_head *list = &fault->deliver;
+	struct list_head *list = &fault->common.deliver;
 	struct iopf_group *group = NULL;
 
-	spin_lock(&fault->lock);
+	spin_lock(&fault->common.lock);
 	if (!list_empty(list)) {
 		group = list_first_entry(list, struct iopf_group, node);
 		list_del(&group->node);
 	}
-	spin_unlock(&fault->lock);
+	spin_unlock(&fault->common.lock);
 	return group;
 }
 
@@ -158,16 +162,17 @@ iommufd_fault_deliver_fetch(struct iommufd_fault *fault)
 static void iommufd_fault_deliver_restore(struct iommufd_fault *fault,
 					  struct iopf_group *group)
 {
-	spin_lock(&fault->lock);
-	list_add(&group->node, &fault->deliver);
-	spin_unlock(&fault->lock);
+	spin_lock(&fault->common.lock);
+	list_add(&group->node, &fault->common.deliver);
+	spin_unlock(&fault->common.lock);
 }
 
 static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 				       size_t count, loff_t *ppos)
 {
 	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
-	struct iommufd_fault *fault = filep->private_data;
+	struct iommufd_eventq *eventq = filep->private_data;
+	struct iommufd_fault *fault = eventq_to_fault(eventq);
 	struct iommu_hwpt_pgfault data = {};
 	struct iommufd_device *idev;
 	struct iopf_group *group;
@@ -216,7 +221,8 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 					size_t count, loff_t *ppos)
 {
 	size_t response_size = sizeof(struct iommu_hwpt_page_response);
-	struct iommufd_fault *fault = filep->private_data;
+	struct iommufd_eventq *eventq = filep->private_data;
+	struct iommufd_fault *fault = eventq_to_fault(eventq);
 	struct iommu_hwpt_page_response response;
 	struct iopf_group *group;
 	size_t done = 0;
@@ -256,59 +262,61 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 	return done == 0 ? rc : done;
 }
 
-static __poll_t iommufd_fault_fops_poll(struct file *filep,
-					struct poll_table_struct *wait)
+/* Common Event Queue Functions */
+
+static __poll_t iommufd_eventq_fops_poll(struct file *filep,
+					 struct poll_table_struct *wait)
 {
-	struct iommufd_fault *fault = filep->private_data;
+	struct iommufd_eventq *eventq = filep->private_data;
 	__poll_t pollflags = EPOLLOUT;
 
-	poll_wait(filep, &fault->wait_queue, wait);
-	spin_lock(&fault->lock);
-	if (!list_empty(&fault->deliver))
+	poll_wait(filep, &eventq->wait_queue, wait);
+	spin_lock(&eventq->lock);
+	if (!list_empty(&eventq->deliver))
 		pollflags |= EPOLLIN | EPOLLRDNORM;
-	spin_unlock(&fault->lock);
+	spin_unlock(&eventq->lock);
 
 	return pollflags;
 }
 
-static int iommufd_fault_fops_release(struct inode *inode, struct file *filep)
+static int iommufd_eventq_fops_release(struct inode *inode, struct file *filep)
 {
-	struct iommufd_fault *fault = filep->private_data;
+	struct iommufd_eventq *eventq = filep->private_data;
 
-	refcount_dec(&fault->obj.users);
-	iommufd_ctx_put(fault->ictx);
+	refcount_dec(&eventq->obj.users);
+	iommufd_ctx_put(eventq->ictx);
 	return 0;
 }
 
-#define INIT_FAULT_FOPS(read_op, write_op)                                     \
+#define INIT_EVENTQ_FOPS(read_op, write_op)                                    \
 	((const struct file_operations){                                       \
 		.owner = THIS_MODULE,                                          \
 		.open = nonseekable_open,                                      \
 		.read = read_op,                                               \
 		.write = write_op,                                             \
-		.poll = iommufd_fault_fops_poll,                               \
-		.release = iommufd_fault_fops_release,                         \
+		.poll = iommufd_eventq_fops_poll,                              \
+		.release = iommufd_eventq_fops_release,                        \
 	})
 
-static int iommufd_fault_init(struct iommufd_fault *fault, char *name,
-			      struct iommufd_ctx *ictx,
-			      const struct file_operations *fops)
+static int iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
+			       struct iommufd_ctx *ictx,
+			       const struct file_operations *fops)
 {
 	struct file *filep;
 	int fdno;
 
-	spin_lock_init(&fault->lock);
-	INIT_LIST_HEAD(&fault->deliver);
-	init_waitqueue_head(&fault->wait_queue);
+	spin_lock_init(&eventq->lock);
+	INIT_LIST_HEAD(&eventq->deliver);
+	init_waitqueue_head(&eventq->wait_queue);
 
-	filep = anon_inode_getfile(name, fops, fault, O_RDWR);
+	filep = anon_inode_getfile(name, fops, eventq, O_RDWR);
 	if (IS_ERR(filep))
 		return PTR_ERR(filep);
 
-	fault->ictx = ictx;
-	iommufd_ctx_get(fault->ictx);
-	fault->filep = filep;
-	refcount_inc(&fault->obj.users);
+	eventq->ictx = ictx;
+	iommufd_ctx_get(eventq->ictx);
+	eventq->filep = filep;
+	refcount_inc(&eventq->obj.users);
 
 	fdno = get_unused_fd_flags(O_CLOEXEC);
 	if (fdno < 0)
@@ -317,7 +325,7 @@ static int iommufd_fault_init(struct iommufd_fault *fault, char *name,
 }
 
 static const struct file_operations iommufd_fault_fops =
-	INIT_FAULT_FOPS(iommufd_fault_fops_read, iommufd_fault_fops_write);
+	INIT_EVENTQ_FOPS(iommufd_fault_fops_read, iommufd_fault_fops_write);
 
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 {
@@ -329,36 +337,37 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	if (cmd->flags)
 		return -EOPNOTSUPP;
 
-	fault = iommufd_object_alloc(ucmd->ictx, fault, IOMMUFD_OBJ_FAULT);
+	fault = __iommufd_object_alloc(ucmd->ictx, fault, IOMMUFD_OBJ_FAULT,
+				       common.obj);
 	if (IS_ERR(fault))
 		return PTR_ERR(fault);
 
 	xa_init_flags(&fault->response, XA_FLAGS_ALLOC1);
 	mutex_init(&fault->mutex);
 
-	fdno = iommufd_fault_init(fault, "[iommufd-pgfault]", ucmd->ictx,
-				  &iommufd_fault_fops);
+	fdno = iommufd_eventq_init(&fault->common, "[iommufd-pgfault]",
+				   ucmd->ictx, &iommufd_fault_fops);
 	if (fdno < 0) {
 		rc = fdno;
 		goto out_abort;
 	}
 
-	cmd->out_fault_id = fault->obj.id;
+	cmd->out_fault_id = fault->common.obj.id;
 	cmd->out_fault_fd = fdno;
 
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
 		goto out_put_fdno;
-	iommufd_object_finalize(ucmd->ictx, &fault->obj);
+	iommufd_object_finalize(ucmd->ictx, &fault->common.obj);
 
-	fd_install(fdno, fault->filep);
+	fd_install(fdno, fault->common.filep);
 
 	return 0;
 out_put_fdno:
 	put_unused_fd(fdno);
-	fput(fault->filep);
+	fput(fault->common.filep);
 out_abort:
-	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->obj);
+	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->common.obj);
 
 	return rc;
 }
@@ -371,11 +380,11 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 	hwpt = group->attach_handle->domain->iommufd_hwpt;
 	fault = hwpt->fault;
 
-	spin_lock(&fault->lock);
-	list_add_tail(&group->node, &fault->deliver);
-	spin_unlock(&fault->lock);
+	spin_lock(&fault->common.lock);
+	list_add_tail(&group->node, &fault->common.deliver);
+	spin_unlock(&fault->common.lock);
 
-	wake_up_interruptible(&fault->wait_queue);
+	wake_up_interruptible(&fault->common.wait_queue);
 
 	return 0;
 }
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 268315b1d8bc..ee40235f9285 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -14,7 +14,7 @@ static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
 		iommu_domain_free(hwpt->domain);
 
 	if (hwpt->fault)
-		refcount_dec(&hwpt->fault->obj.users);
+		refcount_dec(&hwpt->fault->common.obj.users);
 }
 
 void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
@@ -412,8 +412,8 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		}
 		hwpt->fault = fault;
 		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
-		refcount_inc(&fault->obj.users);
-		iommufd_put_object(ucmd->ictx, &fault->obj);
+		refcount_inc(&fault->common.obj.users);
+		iommufd_put_object(ucmd->ictx, &fault->common.obj);
 	}
 	hwpt->domain->iommufd_hwpt = hwpt;
 
-- 
2.43.0


