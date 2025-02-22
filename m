Return-Path: <linux-kselftest+bounces-27269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243DEA409AF
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 16:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15EFA422E16
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 15:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E9A2066C8;
	Sat, 22 Feb 2025 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aJ3VCK6T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9DD1CDA3F;
	Sat, 22 Feb 2025 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239688; cv=fail; b=aGk6yqgvXkKEuOnMCCCsmzyun5Tg9Ddu5fAN5I/9sv8wQA56pUlotFbErqMJevi4G5otBzaVoHla9+MPvQrTQW2Ac2vDIJj6SEOfk95oLxFF3//1cRVXb9WpmKvLEkuKQk/zu0RHY8T+RZATplZZWkGCJ0QNosAk7J27i7GXh/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239688; c=relaxed/simple;
	bh=39IPkdoCZawziROlG3zFClLexU6UBk3J3x6yt3NPQiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=of46x1Dk5i+KGBr9eqQnAeOyvrsZmH6KZ4PgOlTXlz3b6prNVxmOQn5JI2mtLKuVqGNj5XbxnFzy6Mw8SXsJFJpXx2D/vzY/xVkKFOWRP2F+0mRXVVXsm58CRZvqxhTceSZVDxIFXCYuLWVpO6HTTVHf0p1jNyN0vMHetTxt0Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aJ3VCK6T; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMHMvh8caj7tHFM87LAMSmWR1n+f5kI2vujXjw3v3NwuvM/iATr/QvfE0sjsgcFlaLFDAmKvcEyktnx3aa09z0e2upjMB8NRm46iQMFWHzrdrBBISQOsGyDB6IvsvkP0YQ7P4azRx/RgHvY4/Uv7azxmLIk7HsZPAHlehtczbnVI9XRufXTCOAXSkq+uxiLzm7CAhyl21n+ncCeN8ENdjRqUNcu4aM1kbIlUe21LgJlOkMrCqwHj6QXdw4ShOzJb3PDb31Y9Q1l7ed2Yk9FfU6rWONLmT9QuMddVpED87SNIb2hjfP5/PGusOjMSbWu8qzOWf3LTSsnpqHZOjzCsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WsfzoRpBlq7Lc5qCBX33KPwTU3L8nevg8VpC6E4Xxo=;
 b=apajjLPLj2cfxBNYRKVuhFzSaga+1fmE3UCyAjhEo4CStfv+NrZBB2cLb9s8A2okOgSn11aGdlyOga0fGps6eivjFboaBQBHvUMFLakpxBlO/uUcBiBhDq+CM7iLSTSip16s0YpvlVQkuwD0JjKU57WaCLnJBsvz/gl6b1NnE+4WMDfdF5hHni3NSEr7yp9CLUOm+1AQAuQNcy8QV5bV4PxvPE4RaJ4f+hUNDuxy+Qg9YOR7MTcy8dAIDvrlRS1rjAFMyY8Nuj6ybXeRtLY8kkiquAZ/jpFAd52DlCjd6LsQ6acRbRgLi3BcEjfnV26QPMMAaIQPpPMWdQandrIhew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WsfzoRpBlq7Lc5qCBX33KPwTU3L8nevg8VpC6E4Xxo=;
 b=aJ3VCK6TNtI67PIPo9VhOZgJuo6ZuNJ8XWT3AzIQiSlIFdHqpZ+POxzsQR4HnT9omgTVnHDyyR7MRgo6XkoKT6H0ahisCtg1SXe58so+YgsaNSHSuZVsOECTWCFp67dTZqGrWATPlBb2b27u5oE1isfnvYMFJPcrfcX4mZUEV34bqyW1ghYYNg5hlH6ZIcWGy5fO2DVowJedZbVP15NsfSmXCoEb4QYrzxZOpygxJR+WwafOcQhIRPzVLUOgwYlPdMM/51IDhnnaDNMUnXeVmLiBFHhNAz5rYZ8quDwN6JgtKT83cPjaspRf61hpaqjUV7PBgWq7Hv3bQ3NbHaHFVA==
Received: from PH7PR17CA0014.namprd17.prod.outlook.com (2603:10b6:510:324::29)
 by CH0PR12MB8486.namprd12.prod.outlook.com (2603:10b6:610:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sat, 22 Feb
 2025 15:54:37 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::94) by PH7PR17CA0014.outlook.office365.com
 (2603:10b6:510:324::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Sat,
 22 Feb 2025 15:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 15:54:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 07:54:20 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Feb
 2025 07:54:19 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 22 Feb 2025 07:54:18 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v7 03/14] iommufd: Abstract an iommufd_eventq from iommufd_fault
Date: Sat, 22 Feb 2025 07:54:00 -0800
Message-ID: <d5c6ae6cffcfefd9a7b0d6a34e00d4f1963b353c.1740238876.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740238876.git.nicolinc@nvidia.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|CH0PR12MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 977f8858-c0fb-4546-3061-08dd5359354a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZYD0zgckb+Lqz2sNfHuJEgl0dN28DG36wnicJWMjvCi3VoBNT+pVbzuCmZUO?=
 =?us-ascii?Q?sz8ipJSA3/rMwKvra9cu2xVyDVdaVV2GTT4WyvYZnpRyJHMsqo+d7QzxXxNd?=
 =?us-ascii?Q?Kphoef8jgFELPqBweQBOllIVlEnBgG0rpTHLPeIee2DzyWPg8zRh4XUIXHet?=
 =?us-ascii?Q?hryLdHiG2uTWCjc01OM0hba2oZUFhpYJdbFHyksZ/9maFBRuWPn/QpUCMu8+?=
 =?us-ascii?Q?htfBMsCM/hgAcoqQ4J7TlDib1+FGxNHLJ3JpsVgGcwU7Qr90xjDa7mytBj7h?=
 =?us-ascii?Q?kxRrA3yjsTrH1UF4NgHlqugUuSglMWuFuvqcwus7dPnqcwRX1/hvf9+eeKF9?=
 =?us-ascii?Q?YXnLomfAUSHwzOTkZn3EaTqdcR7aNw1xipW/Tez2tyhc24PjO1IbgaQRi8qP?=
 =?us-ascii?Q?Bb02tcGUPdK+j/RRZf1gVNl3RoY/TEpw12l21Bxd2eko1KFBOI0YpXmB6m3h?=
 =?us-ascii?Q?TEC7MLepr1fWvfOJMQHbdTHbpXYBLKkugr+A8HaTBGw6woFTulGjdhzH920K?=
 =?us-ascii?Q?RedxRIIifBxOpVj0/rospjsz9CbI0ALmMMWR33nm/2qWdfl0xNe8wOIScz1O?=
 =?us-ascii?Q?CW1LExNSh9hY7faljMRlphZ7kxn/Cu7408Lffi4lMDCCHB9urGEMBz3/3t0T?=
 =?us-ascii?Q?Jb8wCzQ/kc+ouy48mLDcRwc8Z1KZ0Qfq/z5bp/d1oWyjmefGuTW0hoAAzTxq?=
 =?us-ascii?Q?Ko3Q7p04ePwnwvqvQxicKEQTlNhPPyCVTfk8smW1RyIK4TejE1pftfs87/At?=
 =?us-ascii?Q?tHfMO9ZHHh71+dVzaqgdptVfzaiM2JzEik94861Fd6iw0eAfFXaQevpjkJEz?=
 =?us-ascii?Q?NkaoLW95iZujGCigYtIgbZwfVrJkU5iUrOZkp+LuY+9e4z8IdhbXaifyeE16?=
 =?us-ascii?Q?DLE9Ta7tfxNmxnvSfjnQjiokFfZIdmjopiwmetfD2Szxtnmn5cgJabjKcLFh?=
 =?us-ascii?Q?F6J0RtgWRcKogCKHPTH3YWIBlnrKSbm4KqSnS1o8ATsKB4xURmvtVjHILm7T?=
 =?us-ascii?Q?J0HwHNlVVxmJCLPI1uCTPSYD2/Wa4tyK1FO1dnY33cvVWH8irbhwE5iiVq4h?=
 =?us-ascii?Q?WAdMNtvIFUItBMquAmQhAGeYZMLMoKjora2T/VT75HGV7j8o0rHNClBJKAnl?=
 =?us-ascii?Q?XQ/xPMVSmsC0YUN3KP9wCtWT0g3W2dfDm3I3NZqqmeD+EnaqN8vEPX0qjRqS?=
 =?us-ascii?Q?i82U6CbVTrGV8pocNoiCOw9NLiGozmQnS9X6KdQvTNHff72lYEvhSQq5v43v?=
 =?us-ascii?Q?3qMl18nJ29yYh6PWS3qrClKYD/Hliw2buVhckghCR5vLPnDad152eT7yO2RO?=
 =?us-ascii?Q?jmIUG8vOcGxr1ExaFpdcsAJcEK+j5v5cCMCFvnzCOAKBIPfHZTqDPhkLsqxS?=
 =?us-ascii?Q?AzVJDL+UCQaawEURQZSbOkSjFnVU3bfJttTbS5fal2y1ad7ufRdbV7hl6qv4?=
 =?us-ascii?Q?VD4e18X0CGiXQXUUIyBDlPURAZHszHgwcCYtSU8CsFEkEUtgFmm174vYU5hz?=
 =?us-ascii?Q?tRJGrpX4tRjGm4M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 15:54:36.6477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 977f8858-c0fb-4546-3061-08dd5359354a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8486

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
index 7de6e914232e..006425e7f609 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -14,7 +14,7 @@ static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
 		iommu_domain_free(hwpt->domain);
 
 	if (hwpt->fault)
-		refcount_dec(&hwpt->fault->obj.users);
+		refcount_dec(&hwpt->fault->common.obj.users);
 }
 
 void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
@@ -409,8 +409,8 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
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


