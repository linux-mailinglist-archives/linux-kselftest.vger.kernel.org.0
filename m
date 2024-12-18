Return-Path: <linux-kselftest+bounces-23482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08F29F5E04
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 06:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91F167A227A
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 05:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EC515697B;
	Wed, 18 Dec 2024 05:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JpcywjoC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126415575F;
	Wed, 18 Dec 2024 05:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498107; cv=fail; b=ont/7tquSIeCZrUOJo4WXiEi4ejNdSWLFVF3RMrzQxPONjrFJHydfWQ6t1kRxZ2AhH1+S0CxF0KPBJg/w4spbsxVk5okZnSYQDYjsoMqkc2dvASVa0mdRbkO3736Tp5zem0pr1lHcBHh+8Rvy7cPYCkWecRh8NXwzKMDNGtwoaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498107; c=relaxed/simple;
	bh=3pWTHiJQCyp41GFhsYxVBVhrtnRCp2CXRKyWsH+YS10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1C77qtUxnBb4vyU4Yg8pNl5rVBlXq2KdsTsd6kX4HhqtfiSFw1uJmFrwV8sF1Fbt596vnw+SaMO2Pu2ExeXSolQIB+YDIevXjOUTVh4uU2zOIYe37m0jHqRKC6qSYtRuDUiD9TxN8urRQS0edF+LujnhoaNT8SxQqy3+sCHbhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JpcywjoC; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgddKeR0Yik4eZWXPIZKmvejVjiBJrAt3ERgSSr93UfhGHzaDEGtwWwj5knZ8wPxNtZla5G6YvAea0nmHFWblRHHPUJlJIjbjRkqn2lnzsHqQpLZ8los79ol82tJcgDS2gL2+CLINp5hMKTLwsFhUNvwTaN95hhOX4ME3UCshyB+dDw4cBayUyFzx/1K9MaaTsty8Grp254Q0G7vk7U4znGWnZooVh+7uPoff8ujZ2SHDZSpJsqv+T8gf0TGSKYN56gi7cMh4vdRhytLQzUv/q6sHRV48jAHA0kLTSb4piSW/0IXiNKsgBEOMHt3RW5oRiXZ4lIYqLbNbdbHUIU2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWUM+84qJzle9fe4DGsfw5mKL1e7aiEP3wNMBSVw/1U=;
 b=CPnPZDCK0V2USAwJMrKuJAr0dVIKrde8eADmnLuFXfv5DaTPZldVUmZ/+FH6mz3nQYuyMEdf1Q9a5k1t25gN5OtqFK0KHCDz3UWeSLaiDZ50BkWndNq0huI0aRbnGPF5vbx2Gr6lrRj8qPPRhizEpFXo0lcXj7St44YPxOWaCjgJBkQsQ83zj8brZfAT/OeEPf4uFjFipoejyfM/fByTuVCQQ7NQlwotwZ2dXTfoeQP/J79TYmssnk6beGD8gl+OCcEpY7xFUSbgvIeDyjicktWIvp7AKFFPEHpt8v/Zxc6v+TZtX5DW/K+/9Q0Y7M0/OkXNZz25JOQlsIUXOG2l9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWUM+84qJzle9fe4DGsfw5mKL1e7aiEP3wNMBSVw/1U=;
 b=JpcywjoCoDi6T8GI92mtHzaaf7b//gkiMopOIAa1TLhv9iV/FDrSg4pABmY1KI1lkXCGVwUcz7BwQcl8n0v+jnQ8WuEvzDxmxlrqSmgaIfkgjo3tQakOPLgGcudyvgHscIxPGT1K49iYWEYvBDWzhOSlWPnPnI80Xfl23yCaI8UFn+cvYGTP05M34Kr0NOun6QxXr8GHzHVcr1rst7p5cWK5OI1GMXwMbZzrbzxRcxuI1xpD6cp5FsvZykP2mj0bDBWpJs6aOzJm+RCeUtK+No68rJT1W2EKyfsxze/w/CaplnjsXW2VDi+4Lksn0UEcyyTatL2GQAYU0XvlAhMXiA==
Received: from DS7P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::11) by
 PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 05:01:38 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::a7) by DS7P222CA0009.outlook.office365.com
 (2603:10b6:8:2e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 05:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 05:01:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:27 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:27 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Dec 2024 21:01:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v3 04/14] iommufd: Abstract an iommufd_eventq from iommufd_fault
Date: Tue, 17 Dec 2024 21:00:17 -0800
Message-ID: <b6ad96bb6404069460871a2662e305241742e72c.1734477608.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734477608.git.nicolinc@nvidia.com>
References: <cover.1734477608.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH0PR12MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c98e172-5a3b-4a25-1b61-08dd1f210df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WUhoOnDAC2J/7fAErZozs9Xbgh1z4/rKZWULctuB3xiq6MNZ354T0U/0or4Y?=
 =?us-ascii?Q?epjHlIn+uXXbeHhGieoBNbscjvzy9PzfBeZprvQXKYqrDCzUWSrjMy9b4Fix?=
 =?us-ascii?Q?bJMPOHShDavNRDa5Gc3Xu1Nu4gMs/P1ri3/XIKgZYbZBDtlV492maP69HBS6?=
 =?us-ascii?Q?ms56ccXd62vI5RGEYpm+k2DOp+9MAGmUO9vTbqtKmXgi7B8Fg2z+evl9ct17?=
 =?us-ascii?Q?6jPhxti3Ee8Rf6Bj+i/jpjfoXTwCbRxnnBkELXWwHKFaMdXr2zo0zf4c/LZv?=
 =?us-ascii?Q?so5LY0inxgynwlCAXm8A8s2Upnhgc4mYhG96RJiXevd9MqYeXq871TNiRHaU?=
 =?us-ascii?Q?OICggFuhtH1ki0y69MUqYHK5Jsu7h8vcmXz67IrpnM9chSISyH6hcEHojv3e?=
 =?us-ascii?Q?q5oSZF/4+tVM8EyM/v7HdKfis32LUuVHVh8KkoTGraEWURQh7dzsN/IO265P?=
 =?us-ascii?Q?MapRS+0y1xekVPn6GG14tHXQnzNNa48VXxulMw0AQQb5+BAnCaQpIq7UMBoz?=
 =?us-ascii?Q?LFVp4t4tW31uv0aMtvR9AScLBTvCi4W1gv7G8xVqwnhrcmAGE86Kfgkg032l?=
 =?us-ascii?Q?7urjaxFST36Atk5JUvBHdVk1zxyT2uvChwpKmt6RCBbjmRahNELQvdkGHGcQ?=
 =?us-ascii?Q?N13DWQWFBM8cAO+u/cdUTXgB+MFcaW8Y/TXiSWJOr+84vB0Gu8AetXy7L1Z6?=
 =?us-ascii?Q?HIQBuwm8U/TYXpogZp2piSVDMl+2SyfLOZQWqMN6blfR7TyPHhfpwKPaHr5i?=
 =?us-ascii?Q?slQZoabTqywrAch+9+0vJn0p4FNPuiHanCYKO9TfhieITPJNNclpjPmArB2q?=
 =?us-ascii?Q?OjIP36tG6uAizPx99sdBHl2F5uTLsj1mCIVW5nwKiecDhgDG18M8+wVehlgm?=
 =?us-ascii?Q?8xxA2TuRlj2xWTKDgnNFzgSARj+WQsmjTX0Ac/f/QQpjVhF1/oGcKLiKXOe4?=
 =?us-ascii?Q?2rJOCvMubxD/iH6jsFBPnsXzq6p8ms7cuJGczoZ3sUp4UEUTeBTohdrs8fGZ?=
 =?us-ascii?Q?gmgkxpVFfFP7K114yQ3gsxQly2Eb7yAI/gvdU4K1lzkPIdFmTfwQSZ2QPXyx?=
 =?us-ascii?Q?t0731WaQ9jpiv5PoV8aKGF7Kp3lbEYJs9Hy28r2tHKg87YHNZfTVsR8loFfr?=
 =?us-ascii?Q?3Jlz/0M2YaU2k57iWcRODz53rfkBxcPf5jmiC2/S9l8M4cxkn6rJsaLLdUe8?=
 =?us-ascii?Q?Q3YhxWhaQrWe91TK4N+crzTdmbriDCKuLKQfQ0dW1vTLweT/X5eDofAHuwvV?=
 =?us-ascii?Q?c2dc3hs40PlPtWO5WvuE1CgiR8vVjL4O7cmO7Lr8V5oyBdBJRgTRTae1Yd4Z?=
 =?us-ascii?Q?om8ffaSD3u/hrWK4Jhlcd50oLfCVgVZKEACsTFznFI2Iate6nYUkYdGnUKkE?=
 =?us-ascii?Q?rNO7poa0teI/aOpODKzYov4wbFA8odLXxJsPiaybsN8ZlLBa7zV61XyIhPi9?=
 =?us-ascii?Q?yrLNSvSsGA2slJwwaahXL0fABlWxm7DIxzmgpFLdXSfEao6kciJ4TRKIjfzQ?=
 =?us-ascii?Q?ql75PNiZPOoW948=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 05:01:38.3555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c98e172-5a3b-4a25-1b61-08dd1f210df4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485

The fault object was designed exclusively for hwpt's IO page faults (PRI).
But its queue implementation can be reused for other purposes too, such as
hardware IRQ and event injections to user space.

Meanwhile, a fault object holds a list of faults. So it's more accurate to
call it a "fault queue". Combining the reusing idea above, abstract a new
iommufd_eventq as a common structure embedded into struct iommufd_fault,
similar to hwpt_paging holding a common hwpt.

Add a common iommufd_eventq_ops and iommufd_eventq_init to prepare for an
IOMMUFD_OBJ_VIRQ.

Also, add missing xa_destroy and mutex_destroy in iommufd_fault_destroy().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  52 ++++++---
 drivers/iommu/iommufd/fault.c           | 142 +++++++++++++++---------
 drivers/iommu/iommufd/hw_pagetable.c    |   6 +-
 3 files changed, 130 insertions(+), 70 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8b378705ee71..dfbc5cfbd164 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -18,6 +18,7 @@ struct iommu_domain;
 struct iommu_group;
 struct iommu_option;
 struct iommufd_device;
+struct iommufd_eventq;
 
 struct iommufd_ctx {
 	struct file *file;
@@ -433,32 +434,35 @@ void iopt_remove_access(struct io_pagetable *iopt,
 			u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
-/*
- * An iommufd_fault object represents an interface to deliver I/O page faults
- * to the user space. These objects are created/destroyed by the user space and
- * associated with hardware page table objects during page-table allocation.
- */
-struct iommufd_fault {
+struct iommufd_eventq_ops {
+	ssize_t (*read)(struct iommufd_eventq *eventq, char __user *buf,
+			size_t count, loff_t *ppos); /* Mandatory op */
+	ssize_t (*write)(struct iommufd_eventq *eventq, const char __user *buf,
+			 size_t count, loff_t *ppos); /* Optional op */
+};
+
+struct iommufd_eventq {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct file *filep;
 
-	/* The lists of outstanding faults protected by below mutex. */
+	const struct iommufd_eventq_ops *ops;
+
+	/* The lists of outstanding events protected by below mutex. */
 	struct mutex mutex;
 	struct list_head deliver;
-	struct xarray response;
 
 	struct wait_queue_head wait_queue;
 };
 
-static inline int iommufd_fault_notify(struct iommufd_fault *fault,
-				       struct list_head *new_fault)
+static inline int iommufd_eventq_notify(struct iommufd_eventq *eventq,
+					struct list_head *new_event)
 {
-	mutex_lock(&fault->mutex);
-	list_add_tail(new_fault, &fault->deliver);
-	mutex_unlock(&fault->mutex);
+	mutex_lock(&eventq->mutex);
+	list_add_tail(new_event, &eventq->deliver);
+	mutex_unlock(&eventq->mutex);
 
-	wake_up_interruptible(&fault->wait_queue);
+	wake_up_interruptible(&eventq->wait_queue);
 	return 0;
 }
 
@@ -470,12 +474,28 @@ struct iommufd_attach_handle {
 /* Convert an iommu attach handle to iommufd handle. */
 #define to_iommufd_handle(hdl)	container_of(hdl, struct iommufd_attach_handle, handle)
 
+/*
+ * An iommufd_fault object represents an interface to deliver I/O page faults
+ * to the user space. These objects are created/destroyed by the user space and
+ * associated with hardware page table objects during page-table allocation.
+ */
+struct iommufd_fault {
+	struct iommufd_eventq common;
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
@@ -486,7 +506,7 @@ static inline int iommufd_fault_iopf_handler(struct iopf_group *group)
 	struct iommufd_hw_pagetable *hwpt =
 		group->attach_handle->domain->fault_data;
 
-	return iommufd_fault_notify(hwpt->fault, &group->node);
+	return iommufd_eventq_notify(&hwpt->fault->common, &group->node);
 }
 
 int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index d188994e4e84..e386b6c3e6ab 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -17,6 +17,8 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
+/* IOMMUFD_OBJ_FAULT Functions */
+
 static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
 {
 	struct device *dev = idev->dev;
@@ -108,8 +110,8 @@ static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 	if (!fault)
 		return;
 
-	mutex_lock(&fault->mutex);
-	list_for_each_entry_safe(group, next, &fault->deliver, node) {
+	mutex_lock(&fault->common.mutex);
+	list_for_each_entry_safe(group, next, &fault->common.deliver, node) {
 		if (group->attach_handle != &handle->handle)
 			continue;
 		list_del(&group->node);
@@ -124,7 +126,7 @@ static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
 	}
-	mutex_unlock(&fault->mutex);
+	mutex_unlock(&fault->common.mutex);
 }
 
 static struct iommufd_attach_handle *
@@ -211,7 +213,8 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 
 void iommufd_fault_destroy(struct iommufd_object *obj)
 {
-	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
+	struct iommufd_eventq *eventq =
+		container_of(obj, struct iommufd_eventq, obj);
 	struct iopf_group *group, *next;
 
 	/*
@@ -220,11 +223,13 @@ void iommufd_fault_destroy(struct iommufd_object *obj)
 	 * accessing this pointer. Therefore, acquiring the mutex here
 	 * is unnecessary.
 	 */
-	list_for_each_entry_safe(group, next, &fault->deliver, node) {
+	list_for_each_entry_safe(group, next, &eventq->deliver, node) {
 		list_del(&group->node);
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
 	}
+	xa_destroy(&eventq_to_fault(eventq)->response);
+	mutex_destroy(&eventq->mutex);
 }
 
 static void iommufd_compose_fault_message(struct iommu_fault *fault,
@@ -242,11 +247,12 @@ static void iommufd_compose_fault_message(struct iommu_fault *fault,
 	hwpt_fault->cookie = cookie;
 }
 
-static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
-				       size_t count, loff_t *ppos)
+static ssize_t iommufd_fault_fops_read(struct iommufd_eventq *eventq,
+				       char __user *buf, size_t count,
+				       loff_t *ppos)
 {
 	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
-	struct iommufd_fault *fault = filep->private_data;
+	struct iommufd_fault *fault = eventq_to_fault(eventq);
 	struct iommu_hwpt_pgfault data;
 	struct iommufd_device *idev;
 	struct iopf_group *group;
@@ -257,10 +263,10 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 	if (*ppos || count % fault_size)
 		return -ESPIPE;
 
-	mutex_lock(&fault->mutex);
-	while (!list_empty(&fault->deliver) && count > done) {
-		group = list_first_entry(&fault->deliver,
-					 struct iopf_group, node);
+	mutex_lock(&eventq->mutex);
+	while (!list_empty(&eventq->deliver) && count > done) {
+		group = list_first_entry(&eventq->deliver, struct iopf_group,
+					 node);
 
 		if (group->fault_count * fault_size > count - done)
 			break;
@@ -285,16 +291,17 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 
 		list_del(&group->node);
 	}
-	mutex_unlock(&fault->mutex);
+	mutex_unlock(&eventq->mutex);
 
 	return done == 0 ? rc : done;
 }
 
-static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t iommufd_fault_fops_write(struct iommufd_eventq *eventq,
+					const char __user *buf, size_t count,
+					loff_t *ppos)
 {
 	size_t response_size = sizeof(struct iommu_hwpt_page_response);
-	struct iommufd_fault *fault = filep->private_data;
+	struct iommufd_fault *fault = eventq_to_fault(eventq);
 	struct iommu_hwpt_page_response response;
 	struct iopf_group *group;
 	size_t done = 0;
@@ -303,7 +310,7 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 	if (*ppos || count % response_size)
 		return -ESPIPE;
 
-	mutex_lock(&fault->mutex);
+	mutex_lock(&eventq->mutex);
 	while (count > done) {
 		rc = copy_from_user(&response, buf + done, response_size);
 		if (rc)
@@ -329,62 +336,93 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 		iopf_free_group(group);
 		done += response_size;
 	}
-	mutex_unlock(&fault->mutex);
+	mutex_unlock(&eventq->mutex);
 
 	return done == 0 ? rc : done;
 }
 
-static __poll_t iommufd_fault_fops_poll(struct file *filep,
-					struct poll_table_struct *wait)
+static const struct iommufd_eventq_ops iommufd_fault_ops = {
+	.read = &iommufd_fault_fops_read,
+	.write = &iommufd_fault_fops_write,
+};
+
+/* Common Event Queue Functions */
+
+static ssize_t iommufd_eventq_fops_read(struct file *filep, char __user *buf,
+					size_t count, loff_t *ppos)
 {
-	struct iommufd_fault *fault = filep->private_data;
+	struct iommufd_eventq *eventq = filep->private_data;
+
+	return eventq->ops->read(eventq, buf, count, ppos);
+}
+
+static ssize_t iommufd_eventq_fops_write(struct file *filep,
+					 const char __user *buf, size_t count,
+					 loff_t *ppos)
+{
+	struct iommufd_eventq *eventq = filep->private_data;
+
+	if (!eventq->ops->write)
+		return -EOPNOTSUPP;
+	return eventq->ops->write(eventq, buf, count, ppos);
+}
+
+static __poll_t iommufd_eventq_fops_poll(struct file *filep,
+					 struct poll_table_struct *wait)
+{
+	struct iommufd_eventq *eventq = filep->private_data;
 	__poll_t pollflags = EPOLLOUT;
 
-	poll_wait(filep, &fault->wait_queue, wait);
-	mutex_lock(&fault->mutex);
-	if (!list_empty(&fault->deliver))
+	poll_wait(filep, &eventq->wait_queue, wait);
+	mutex_lock(&eventq->mutex);
+	if (!list_empty(&eventq->deliver))
 		pollflags |= EPOLLIN | EPOLLRDNORM;
-	mutex_unlock(&fault->mutex);
+	mutex_unlock(&eventq->mutex);
 
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
 
-static const struct file_operations iommufd_fault_fops = {
+static const struct file_operations iommufd_eventq_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nonseekable_open,
-	.read		= iommufd_fault_fops_read,
-	.write		= iommufd_fault_fops_write,
-	.poll		= iommufd_fault_fops_poll,
-	.release	= iommufd_fault_fops_release,
+	.read		= iommufd_eventq_fops_read,
+	.write		= iommufd_eventq_fops_write,
+	.poll		= iommufd_eventq_fops_poll,
+	.release	= iommufd_eventq_fops_release,
 };
 
-static int iommufd_fault_init(struct iommufd_fault *fault, char *name,
-			      struct iommufd_ctx *ictx)
+static int iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
+			       struct iommufd_ctx *ictx,
+			       const struct iommufd_eventq_ops *ops)
 {
 	struct file *filep;
 	int fdno;
 
-	mutex_init(&fault->mutex);
-	INIT_LIST_HEAD(&fault->deliver);
-	init_waitqueue_head(&fault->wait_queue);
+	if (WARN_ON_ONCE(!ops || !ops->read))
+		return -EINVAL;
+
+	mutex_init(&eventq->mutex);
+	INIT_LIST_HEAD(&eventq->deliver);
+	init_waitqueue_head(&eventq->wait_queue);
 
-	filep = anon_inode_getfile(name, &iommufd_fault_fops, fault, O_RDWR);
+	filep = anon_inode_getfile(name, &iommufd_eventq_fops, eventq, O_RDWR);
 	if (IS_ERR(filep))
 		return PTR_ERR(filep);
 
-	fault->ictx = ictx;
-	iommufd_ctx_get(fault->ictx);
-	fault->filep = filep;
-	refcount_inc(&fault->obj.users);
+	eventq->ops = ops;
+	eventq->ictx = ictx;
+	iommufd_ctx_get(eventq->ictx);
+	refcount_inc(&eventq->obj.users);
+	eventq->filep = filep;
 
 	fdno = get_unused_fd_flags(O_CLOEXEC);
 	if (fdno < 0)
@@ -402,34 +440,36 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	if (cmd->flags)
 		return -EOPNOTSUPP;
 
-	fault = iommufd_object_alloc(ucmd->ictx, fault, IOMMUFD_OBJ_FAULT);
+	fault = __iommufd_object_alloc(ucmd->ictx, fault, IOMMUFD_OBJ_FAULT,
+				       common.obj);
 	if (IS_ERR(fault))
 		return PTR_ERR(fault);
 
 	xa_init_flags(&fault->response, XA_FLAGS_ALLOC1);
 
-	fdno = iommufd_fault_init(fault, "[iommufd-pgfault]", ucmd->ictx);
+	fdno = iommufd_eventq_init(&fault->common, "[iommufd-pgfault]",
+				   ucmd->ictx, &iommufd_fault_ops);
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
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index ce03c3804651..12a576f1f13d 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -14,7 +14,7 @@ static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
 		iommu_domain_free(hwpt->domain);
 
 	if (hwpt->fault)
-		refcount_dec(&hwpt->fault->obj.users);
+		refcount_dec(&hwpt->fault->common.obj.users);
 }
 
 void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
@@ -403,8 +403,8 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		hwpt->fault = fault;
 		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
 		hwpt->domain->fault_data = hwpt;
-		refcount_inc(&fault->obj.users);
-		iommufd_put_object(ucmd->ictx, &fault->obj);
+		refcount_inc(&fault->common.obj.users);
+		iommufd_put_object(ucmd->ictx, &fault->common.obj);
 	}
 
 	cmd->out_hwpt_id = hwpt->obj.id;
-- 
2.43.0


