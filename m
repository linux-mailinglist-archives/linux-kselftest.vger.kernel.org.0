Return-Path: <linux-kselftest+bounces-22792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEC19E2ECC
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 23:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAB6283989
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 22:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D27209F4C;
	Tue,  3 Dec 2024 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dL8WGlEb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38420B80D;
	Tue,  3 Dec 2024 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263871; cv=fail; b=fEmIFZzQq6dsEw4ix9pi4Ke0x1LNhaqNn4kqOaoaLx1HfinEgwtfNzt7laz3IyZjxdAroPa0H9PRJWDcj4r0WjEVmvQ1aYTnKfXUwQyd6s2XIBNoV63OcZGbbtp7ihFMVwBbLqcN95eTu5+FcbqVN8VuHC92nMWXFRZd+OrV3QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263871; c=relaxed/simple;
	bh=d0frarIvCH2PG7/y25pQo3IFmYbQgUAYn2Z33Qy8g9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5OxVEYnEMeZ4SX5DpgF5JuRBho+r9R7Sm8ZgnMRSfJJSwxU3fSk6HGWCyJzy6YE2dN8AwWeZBl4kMeCTVrnUVLQ+Hgo7eRf9XGHBa/sBKUYWsZwYu7TTT52z5dwolC/y4uAEraGeqRvEI6DDnVRhJkvzFJxzemsAho7sH0ZQ20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dL8WGlEb; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDltauFoFeMK7A3aouCITQrIr49GtEfjm6DTSwnaTv5FDYIN8XZNK6LAlA6TrLGCBZR/wK/gagpVjk+VCuoAD6yXaBCQK4qI2tGUyFkGPHQKKoKh4KBHsDiApEQRBwAir9qnIRXjawNGFyIsYlqh5wOj0FsnPVtg4/oujAS7YNcdsMhoj4xnUJGF1SldCZJhdmDTvQTFpj7UcHnFEoc0Wd4PPqXGeNWlDiV/cNyeK/thnGLxG5Y4hul8OsTPv+rb7nc+YlET1TWqXBGY8t1d8lNbUE9MgvD3K1ZGmPSCSIEfY0/Ti0iWFujDeLIGEu/hzanj1MYp9husdIQ9V0zbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zT0PTvzRbDQtEOSkdxKi1c32LipXwiqoOOCSCseAG+g=;
 b=qjz36ffJWE3cP/9fE69D6VFg32mSlLN+Xc1zkfqY4wORYnoLw+iVLgwrNz71RpI8KKDdfBEj+uDNrzIp2PuBL+WKtoNJF/mUBt1yQa6Lq22B3zYpgnOcYWa3ArEGpXz70tfoI45QHpGNP17w9UgShEtQ7pMYENNaF99BfQ5t8Nk/YP38XOW9PekYS9zNWuE3FSC260QWg7POaDcAlLX0rK+eeJUh/1ToGFTtcZKSiOrbk16d2bVHUYMc90xeWdSpWvCk7/hARjNxHsPYprYgVtfNOSjvxWJGKib0zpg5tcwVPRDk1tHEV5+5xtH5Pv8yCOigZqtKNNDkU83ytGmBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT0PTvzRbDQtEOSkdxKi1c32LipXwiqoOOCSCseAG+g=;
 b=dL8WGlEbwM8Felz/5qvOr/cAp5D2r1koJJZgCWgMyvtq8wjBEdZHrEnVKfA4O/oQ8A87PXLjiSCBjGbLEGUvMl9+ST0hCLttY40LVcTEuSO9W47b70+soTpuYOdXuSg91kqh/bIxLEBwNIcLVt80o9jUhDxpzUiLDDSAIGEygtpK+SzonR1x9/3KMg6LZ1sx+LLfR8TacdNM72BK7ZBqm05oaLpUb6q02QvO5e8peXsm1/g5cCdOp9qUGGilfCFXYkNwsOYvFXqLPrSQccWAENTthI4SO2MCqqFCqhXVkeyI0Wkx01p+vbiqKzv5VkEcA3Z6fz3hxism60StyJ/T1A==
Received: from SJ0PR13CA0032.namprd13.prod.outlook.com (2603:10b6:a03:2c2::7)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 22:10:57 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::2f) by SJ0PR13CA0032.outlook.office365.com
 (2603:10b6:a03:2c2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7 via Frontend Transport; Tue, 3
 Dec 2024 22:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 22:10:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 14:10:37 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 14:10:36 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 14:10:35 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 03/13] iommufd: Rename IOMMUFD_OBJ_FAULT to IOMMUFD_OBJ_EVENTQ_IOPF
Date: Tue, 3 Dec 2024 14:10:08 -0800
Message-ID: <2e2dc5c9cd8013147d4a8ee0d6c9d59c9ebe1954.1733263737.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733263737.git.nicolinc@nvidia.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: d972f7db-97e6-4da3-4e57-08dd13e75cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UG4YzuWK6j6DwWBDmMlX9QqxQvAi2RsuRA7b872Lx14CwNJbdEWJREvqiWtZ?=
 =?us-ascii?Q?N4g9IjMvUoMnbBF3TAVH8ZT998F6KGRaui9fdo7X3Kiqr+9OG0FREG0LyHzS?=
 =?us-ascii?Q?o8OGrQCcVK8PNf3vztdU6s0/WjABbUkklf1SImneiRohDLpsghqweBcysBuQ?=
 =?us-ascii?Q?XMLrwQXm0rolrXj2YjHvaycc2Sp2OyWK/Iw0HbigdMeF6pt9T3ER2ndX/m5Z?=
 =?us-ascii?Q?L00gz7bPbLAcQ99PrSY1JKYCs1sloye4DmxquBolAykLx82Njp4CImzTUj/B?=
 =?us-ascii?Q?OI8I85DB9gdL2yWLFnPkNQrgtSsK9iQ45Yb3UIj2/7Joyqs1DU2pYZo2/GBi?=
 =?us-ascii?Q?aHL7x1wE3CscjZFrnglL8kGDeJFFpCzsjGpUS8mazaJrbXPSn5LNK8MQWRNi?=
 =?us-ascii?Q?i9T18ayA6Iqrd+NnSAyfV/vYI9aFRCUCfcQkPewHuky2pbjmTVdNHg7v38CL?=
 =?us-ascii?Q?CGU2mxxRNODg120XJT0wzYydx0KkozNVxOgo0/HHX8MnTlMcdZCN2fewWMPD?=
 =?us-ascii?Q?OilEtPcMVgQkt8DSLZ/LBesXBdQRNuqVuCTjwPAzjkvc7UDEFcF+M5lejZtV?=
 =?us-ascii?Q?xoMjs4muzTG8V8cHjuSmrTzcELpOi1lUHEqpc1VdOOKVtz+Wzez+hk/mq9Md?=
 =?us-ascii?Q?S3JPQGSjdjnbBdc0vlJI3/uM3RJjXdhh8WS1rFg8n3QnEeGPLZ+50JaSrMTe?=
 =?us-ascii?Q?HryBbmg9GPd3bGtXU60MINBi61xYnLSpwK5mDhVo1GQQNFefvcua+msRVe89?=
 =?us-ascii?Q?pzxi6DiWTnRlH5mFITRXgRIRcxWF4siQL5asN2DrhqHho0+lsmMnpeaK8NBj?=
 =?us-ascii?Q?+irpl6xlzCP9kO9+1dtY0xthwhbBGZ2d+AMmfvrVFx3a+wA29UAO471peS7b?=
 =?us-ascii?Q?hcpdkkCvsBACugc8BWGAVo2iz8IaAXG9bmSRViQjsGHfd+++p2+4cMMbtud3?=
 =?us-ascii?Q?FlDImHr5XUgVLrWPH8ha09nmBmj2zwcKB90eRdDXgcnf4qLgXYcQUZa41MJ1?=
 =?us-ascii?Q?24CxEPYshJ6uUj59vy1UvT9p0pdAbL4jXZgy7pE0N/AlI6C6kTLdyDgBUJm7?=
 =?us-ascii?Q?cAkUI/k9d4V6P3kFP5pC+2kR88RXTKdmoRli+3ijgAiJDx41q8EQu7xEOZoh?=
 =?us-ascii?Q?voo7w/uqF/pBG2B6+h85pIkG5N0S10AhSjZKYIdj4kwdfxquF40jjWp5KBQb?=
 =?us-ascii?Q?j6nhCb8h5XgJaq4Bw+5lK65k/fhz9jht5YmnJ62LRoe4iVt81lD1J6fJHXGD?=
 =?us-ascii?Q?BcuC+wVZSfwgL9457PVkSqmE+M1FfFO7xYFavY3UIUpINcsJpQsVcazUfB+I?=
 =?us-ascii?Q?b9wu1mEf0CDRS2cLnOtKoNC+kO//Yvi1sThu9nD3/DlMo6xpVR/oI+QWCz9E?=
 =?us-ascii?Q?mlYCxGIGvUgTItQePO5vwLG+ak6mPuCDr+0LENbumkeR3ttO7KvVegs6YJNU?=
 =?us-ascii?Q?o0h4UAMji6AlmOtro6KHveSNxCJMtibf?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 22:10:57.0212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d972f7db-97e6-4da3-4e57-08dd13e75cb7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506

The fault object was designed exclusively for hwpt's IO page faults (PRI).
But its implementation can actually be reused for other purposes too, such
as hardware IRQ and event injections to user space.

Meanwhile, a fault object holds a list of faults. So it's more accurate to
call it a "fault queue". Combining the reusing idea above, a "fault queue"
can further rephrase to an "Event Queue for IOPF".

Rename the struct iommufd_fault to struct iommufd_eventq_iopf that holds a
common Event Queue struct, similar to hwpt_paging holding a common hwpt.

Roll out a minimal level of renamings to all the related functions.

Add a common iommufd_eventq_ops and iommufd_eventq_init to prepare for an
IOMMUFD_OBJ_EVENTQ_VIRQ. Also, add missing xa_destroy and mutex_destroy in
iommufd_fault_destroy().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  87 ++++++----
 include/linux/iommufd.h                 |   2 +-
 drivers/iommu/iommufd/fault.c           | 221 ++++++++++++++----------
 drivers/iommu/iommufd/hw_pagetable.c    |  12 +-
 drivers/iommu/iommufd/main.c            |   8 +-
 5 files changed, 195 insertions(+), 135 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8b378705ee71..1c9a101cc435 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -18,6 +18,8 @@ struct iommu_domain;
 struct iommu_group;
 struct iommu_option;
 struct iommufd_device;
+struct iommufd_eventq;
+struct iommufd_eventq_iopf;
 
 struct iommufd_ctx {
 	struct file *file;
@@ -275,7 +277,7 @@ int iommufd_check_iova_range(struct io_pagetable *iopt,
 struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
 	struct iommu_domain *domain;
-	struct iommufd_fault *fault;
+	struct iommufd_eventq_iopf *fault;
 };
 
 struct iommufd_hwpt_paging {
@@ -433,32 +435,35 @@ void iopt_remove_access(struct io_pagetable *iopt,
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
+			size_t count, loff_t *ppos);
+	ssize_t (*write)(struct iommufd_eventq *eventq, const char __user *buf,
+			 size_t count, loff_t *ppos);
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
 
@@ -470,38 +475,54 @@ struct iommufd_attach_handle {
 /* Convert an iommu attach handle to iommufd handle. */
 #define to_iommufd_handle(hdl)	container_of(hdl, struct iommufd_attach_handle, handle)
 
-static inline struct iommufd_fault *
-iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
+/*
+ * An iommufd_eventq_iopf object represents a queue to deliver I/O page faults
+ * to the user space. These objects are created/destroyed by the user space and
+ * associated with hardware page table objects during page-table allocation.
+ */
+struct iommufd_eventq_iopf {
+	struct iommufd_eventq common;
+	struct xarray response;
+};
+
+static inline struct iommufd_eventq_iopf *
+to_eventq_iopf(struct iommufd_eventq *eventq)
+{
+	return container_of(eventq, struct iommufd_eventq_iopf, common);
+}
+
+static inline struct iommufd_eventq_iopf *
+iommufd_get_eventq_iopf(struct iommufd_ucmd *ucmd, u32 id)
 {
 	return container_of(iommufd_get_object(ucmd->ictx, id,
-					       IOMMUFD_OBJ_FAULT),
-			    struct iommufd_fault, obj);
+					       IOMMUFD_OBJ_EVENTQ_IOPF),
+			    struct iommufd_eventq_iopf, common.obj);
 }
 
-int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
-void iommufd_fault_destroy(struct iommufd_object *obj);
+int iommufd_eventq_iopf_alloc(struct iommufd_ucmd *ucmd);
+void iommufd_eventq_iopf_destroy(struct iommufd_object *obj);
 
-static inline int iommufd_fault_iopf_handler(struct iopf_group *group)
+static inline int iommufd_eventq_iopf_handler(struct iopf_group *group)
 {
 	struct iommufd_hw_pagetable *hwpt =
 		group->attach_handle->domain->fault_data;
 
-	return iommufd_fault_notify(hwpt->fault, &group->node);
+	return iommufd_eventq_notify(&hwpt->fault->common, &group->node);
 }
 
-int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
-				    struct iommufd_device *idev);
-void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_device *idev);
-int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
-				     struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_hw_pagetable *old);
+int iommufd_eventq_iopf_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+					  struct iommufd_device *idev);
+void iommufd_eventq_iopf_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
+					   struct iommufd_device *idev);
+int iommufd_eventq_iopf_domain_replace_dev(struct iommufd_device *idev,
+					   struct iommufd_hw_pagetable *hwpt,
+					   struct iommufd_hw_pagetable *old);
 
 static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 					     struct iommufd_device *idev)
 {
 	if (hwpt->fault)
-		return iommufd_fault_domain_attach_dev(hwpt, idev);
+		return iommufd_eventq_iopf_domain_attach_dev(hwpt, idev);
 
 	return iommu_attach_group(hwpt->domain, idev->igroup->group);
 }
@@ -510,7 +531,7 @@ static inline void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 					      struct iommufd_device *idev)
 {
 	if (hwpt->fault) {
-		iommufd_fault_domain_detach_dev(hwpt, idev);
+		iommufd_eventq_iopf_domain_detach_dev(hwpt, idev);
 		return;
 	}
 
@@ -522,7 +543,7 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 					      struct iommufd_hw_pagetable *old)
 {
 	if (old->fault || hwpt->fault)
-		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
+		return iommufd_eventq_iopf_domain_replace_dev(idev, hwpt, old);
 
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 11110c749200..7ad105ab8090 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -31,7 +31,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_HWPT_NESTED,
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
-	IOMMUFD_OBJ_FAULT,
+	IOMMUFD_OBJ_EVENTQ_IOPF,
 	IOMMUFD_OBJ_VIOMMU,
 	IOMMUFD_OBJ_VDEVICE,
 #ifdef CONFIG_IOMMUFD_TEST
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 5694b04a48bd..3674961a45c2 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -17,7 +17,9 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
-static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
+/* IOMMUFD_OBJ_EVENTQ_IOPF Functions */
+
+static int iommufd_eventq_iopf_enable(struct iommufd_device *idev)
 {
 	struct device *dev = idev->dev;
 	int ret;
@@ -50,7 +52,7 @@ static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
 	return ret;
 }
 
-static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
+static void iommufd_eventq_iopf_disable(struct iommufd_device *idev)
 {
 	mutex_lock(&idev->iopf_lock);
 	if (!WARN_ON(idev->iopf_enabled == 0)) {
@@ -60,8 +62,8 @@ static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
 	mutex_unlock(&idev->iopf_lock);
 }
 
-static int __fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_device *idev)
+static int __eventq_iopf_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+					   struct iommufd_device *idev)
 {
 	struct iommufd_attach_handle *handle;
 	int ret;
@@ -79,37 +81,38 @@ static int __fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 	return ret;
 }
 
-int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
-				    struct iommufd_device *idev)
+int iommufd_eventq_iopf_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+					  struct iommufd_device *idev)
 {
 	int ret;
 
 	if (!hwpt->fault)
 		return -EINVAL;
 
-	ret = iommufd_fault_iopf_enable(idev);
+	ret = iommufd_eventq_iopf_enable(idev);
 	if (ret)
 		return ret;
 
-	ret = __fault_domain_attach_dev(hwpt, idev);
+	ret = __eventq_iopf_domain_attach_dev(hwpt, idev);
 	if (ret)
-		iommufd_fault_iopf_disable(idev);
+		iommufd_eventq_iopf_disable(idev);
 
 	return ret;
 }
 
-static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
-					 struct iommufd_attach_handle *handle)
+static void
+iommufd_eventq_iopf_auto_response(struct iommufd_hw_pagetable *hwpt,
+				  struct iommufd_attach_handle *handle)
 {
-	struct iommufd_fault *fault = hwpt->fault;
+	struct iommufd_eventq_iopf *fault = hwpt->fault;
 	struct iopf_group *group, *next;
 	unsigned long index;
 
 	if (!fault)
 		return;
 
-	mutex_lock(&fault->mutex);
-	list_for_each_entry_safe(group, next, &fault->deliver, node) {
+	mutex_lock(&fault->common.mutex);
+	list_for_each_entry_safe(group, next, &fault->common.deliver, node) {
 		if (group->attach_handle != &handle->handle)
 			continue;
 		list_del(&group->node);
@@ -124,7 +127,7 @@ static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
 	}
-	mutex_unlock(&fault->mutex);
+	mutex_unlock(&fault->common.mutex);
 }
 
 static struct iommufd_attach_handle *
@@ -139,21 +142,21 @@ iommufd_device_get_attach_handle(struct iommufd_device *idev)
 	return to_iommufd_handle(handle);
 }
 
-void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_device *idev)
+void iommufd_eventq_iopf_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
+					   struct iommufd_device *idev)
 {
 	struct iommufd_attach_handle *handle;
 
 	handle = iommufd_device_get_attach_handle(idev);
 	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
-	iommufd_auto_response_faults(hwpt, handle);
-	iommufd_fault_iopf_disable(idev);
+	iommufd_eventq_iopf_auto_response(hwpt, handle);
+	iommufd_eventq_iopf_disable(idev);
 	kfree(handle);
 }
 
-static int __fault_domain_replace_dev(struct iommufd_device *idev,
-				      struct iommufd_hw_pagetable *hwpt,
-				      struct iommufd_hw_pagetable *old)
+static int __eventq_iopf_domain_replace_dev(struct iommufd_device *idev,
+					    struct iommufd_hw_pagetable *hwpt,
+					    struct iommufd_hw_pagetable *old)
 {
 	struct iommufd_attach_handle *handle, *curr = NULL;
 	int ret;
@@ -175,43 +178,44 @@ static int __fault_domain_replace_dev(struct iommufd_device *idev,
 	}
 
 	if (!ret && curr) {
-		iommufd_auto_response_faults(old, curr);
+		iommufd_eventq_iopf_auto_response(old, curr);
 		kfree(curr);
 	}
 
 	return ret;
 }
 
-int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
-				     struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_hw_pagetable *old)
+int iommufd_eventq_iopf_domain_replace_dev(struct iommufd_device *idev,
+					   struct iommufd_hw_pagetable *hwpt,
+					   struct iommufd_hw_pagetable *old)
 {
 	bool iopf_off = !hwpt->fault && old->fault;
 	bool iopf_on = hwpt->fault && !old->fault;
 	int ret;
 
 	if (iopf_on) {
-		ret = iommufd_fault_iopf_enable(idev);
+		ret = iommufd_eventq_iopf_enable(idev);
 		if (ret)
 			return ret;
 	}
 
-	ret = __fault_domain_replace_dev(idev, hwpt, old);
+	ret = __eventq_iopf_domain_replace_dev(idev, hwpt, old);
 	if (ret) {
 		if (iopf_on)
-			iommufd_fault_iopf_disable(idev);
+			iommufd_eventq_iopf_disable(idev);
 		return ret;
 	}
 
 	if (iopf_off)
-		iommufd_fault_iopf_disable(idev);
+		iommufd_eventq_iopf_disable(idev);
 
 	return 0;
 }
 
-void iommufd_fault_destroy(struct iommufd_object *obj)
+void iommufd_eventq_iopf_destroy(struct iommufd_object *obj)
 {
-	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
+	struct iommufd_eventq *eventq =
+		container_of(obj, struct iommufd_eventq, obj);
 	struct iopf_group *group, *next;
 
 	/*
@@ -220,17 +224,19 @@ void iommufd_fault_destroy(struct iommufd_object *obj)
 	 * accessing this pointer. Therefore, acquiring the mutex here
 	 * is unnecessary.
 	 */
-	list_for_each_entry_safe(group, next, &fault->deliver, node) {
+	list_for_each_entry_safe(group, next, &eventq->deliver, node) {
 		list_del(&group->node);
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
 	}
+	xa_destroy(&to_eventq_iopf(eventq)->response);
+	mutex_destroy(&eventq->mutex);
 }
 
-static void iommufd_compose_fault_message(struct iommu_fault *fault,
-					  struct iommu_hwpt_pgfault *hwpt_fault,
-					  struct iommufd_device *idev,
-					  u32 cookie)
+static void iommufd_compose_iopf_message(struct iommu_fault *fault,
+					 struct iommu_hwpt_pgfault *hwpt_fault,
+					 struct iommufd_device *idev,
+					 u32 cookie)
 {
 	hwpt_fault->flags = fault->prm.flags;
 	hwpt_fault->dev_id = idev->obj.id;
@@ -242,11 +248,12 @@ static void iommufd_compose_fault_message(struct iommu_fault *fault,
 	hwpt_fault->cookie = cookie;
 }
 
-static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
-				       size_t count, loff_t *ppos)
+static ssize_t iommufd_eventq_iopf_fops_read(struct iommufd_eventq *eventq,
+					     char __user *buf, size_t count,
+					     loff_t *ppos)
 {
+	struct iommufd_eventq_iopf *fault = to_eventq_iopf(eventq);
 	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
-	struct iommufd_fault *fault = filep->private_data;
 	struct iommu_hwpt_pgfault data;
 	struct iommufd_device *idev;
 	struct iopf_group *group;
@@ -257,10 +264,10 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
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
@@ -272,9 +279,8 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 
 		idev = to_iommufd_handle(group->attach_handle)->idev;
 		list_for_each_entry(iopf, &group->faults, list) {
-			iommufd_compose_fault_message(&iopf->fault,
-						      &data, idev,
-						      group->cookie);
+			iommufd_compose_iopf_message(&iopf->fault, &data, idev,
+						     group->cookie);
 			if (copy_to_user(buf + done, &data, fault_size)) {
 				xa_erase(&fault->response, group->cookie);
 				rc = -EFAULT;
@@ -285,16 +291,17 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 
 		list_del(&group->node);
 	}
-	mutex_unlock(&fault->mutex);
+	mutex_unlock(&eventq->mutex);
 
 	return done == 0 ? rc : done;
 }
 
-static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t iommufd_eventq_iopf_fops_write(struct iommufd_eventq *eventq,
+					      const char __user *buf,
+					      size_t count, loff_t *ppos)
 {
 	size_t response_size = sizeof(struct iommu_hwpt_page_response);
-	struct iommufd_fault *fault = filep->private_data;
+	struct iommufd_eventq_iopf *fault = to_eventq_iopf(eventq);
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
@@ -329,62 +336,92 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 		iopf_free_group(group);
 		done += response_size;
 	}
-	mutex_unlock(&fault->mutex);
+	mutex_unlock(&eventq->mutex);
 
 	return done == 0 ? rc : done;
 }
 
-static __poll_t iommufd_fault_fops_poll(struct file *filep,
-					struct poll_table_struct *wait)
+static const struct iommufd_eventq_ops iommufd_eventq_iopf_ops = {
+	.read = &iommufd_eventq_iopf_fops_read,
+	.write = &iommufd_eventq_iopf_fops_write,
+};
+
+/* Common Event Queue Functions */
+
+static ssize_t iommufd_eventq_fops_read(struct file *filep, char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct iommufd_eventq *eventq = filep->private_data;
+
+	if (!eventq->ops || !eventq->ops->read)
+		return -EOPNOTSUPP;
+	return eventq->ops->read(eventq, buf, count, ppos);
+}
+
+static ssize_t iommufd_eventq_fops_write(struct file *filep,
+					 const char __user *buf, size_t count,
+					 loff_t *ppos)
+{
+	struct iommufd_eventq *eventq = filep->private_data;
+
+	if (!eventq->ops || !eventq->ops->write)
+		return -EOPNOTSUPP;
+	return eventq->ops->write(eventq, buf, count, ppos);
+}
+
+static __poll_t iommufd_eventq_fops_poll(struct file *filep,
+					 struct poll_table_struct *wait)
 {
-	struct iommufd_fault *fault = filep->private_data;
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
 
-	fault->ictx = ictx;
-	mutex_init(&fault->mutex);
-	INIT_LIST_HEAD(&fault->deliver);
-	init_waitqueue_head(&fault->wait_queue);
+	eventq->ops = ops;
+	eventq->ictx = ictx;
+	mutex_init(&eventq->mutex);
+	INIT_LIST_HEAD(&eventq->deliver);
+	init_waitqueue_head(&eventq->wait_queue);
 
-	filep = anon_inode_getfile(name, &iommufd_fault_fops, fault, O_RDWR);
+	filep = anon_inode_getfile(name, &iommufd_eventq_fops, eventq, O_RDWR);
 	if (IS_ERR(filep))
 		return PTR_ERR(filep);
 
-	fault->filep = filep;
-	iommufd_ctx_get(fault->ictx);
-	refcount_inc(&fault->obj.users);
+	eventq->filep = filep;
+	iommufd_ctx_get(eventq->ictx);
+	refcount_inc(&eventq->obj.users);
 
 	fdno = get_unused_fd_flags(O_CLOEXEC);
 	if (fdno < 0)
@@ -392,44 +429,46 @@ static int iommufd_fault_init(struct iommufd_fault *fault, char *name,
 	return fdno;
 }
 
-int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
+int iommufd_eventq_iopf_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_fault_alloc *cmd = ucmd->cmd;
-	struct iommufd_fault *fault;
+	struct iommufd_eventq_iopf *eventq_iopf;
 	int fdno;
 	int rc;
 
 	if (cmd->flags)
 		return -EOPNOTSUPP;
 
-	fault = iommufd_object_alloc(ucmd->ictx, fault, IOMMUFD_OBJ_FAULT);
-	if (IS_ERR(fault))
-		return PTR_ERR(fault);
+	eventq_iopf = __iommufd_object_alloc(
+		ucmd->ictx, eventq_iopf, IOMMUFD_OBJ_EVENTQ_IOPF, common.obj);
+	if (IS_ERR(eventq_iopf))
+		return PTR_ERR(eventq_iopf);
 
-	xa_init_flags(&fault->response, XA_FLAGS_ALLOC1);
+	xa_init_flags(&eventq_iopf->response, XA_FLAGS_ALLOC1);
 
-	fdno = iommufd_fault_init(fault, "[iommufd-pgfault]", ucmd->ictx);
+	fdno = iommufd_eventq_init(&eventq_iopf->common, "[iommufd-pgfault]",
+				   ucmd->ictx, &iommufd_eventq_iopf_ops);
 	if (fdno < 0) {
 		rc = fdno;
 		goto out_abort;
 	}
 
-	cmd->out_fault_id = fault->obj.id;
+	cmd->out_fault_id = eventq_iopf->common.obj.id;
 	cmd->out_fault_fd = fdno;
 
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
 		goto out_put_fdno;
-	iommufd_object_finalize(ucmd->ictx, &fault->obj);
+	iommufd_object_finalize(ucmd->ictx, &eventq_iopf->common.obj);
 
-	fd_install(fdno, fault->filep);
+	fd_install(fdno, eventq_iopf->common.filep);
 
 	return 0;
 out_put_fdno:
 	put_unused_fd(fdno);
-	fput(fault->filep);
+	fput(eventq_iopf->common.filep);
 out_abort:
-	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->obj);
+	iommufd_object_abort_and_destroy(ucmd->ictx, &eventq_iopf->common.obj);
 
 	return rc;
 }
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index ce03c3804651..a89d9018f96b 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -14,7 +14,7 @@ static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
 		iommu_domain_free(hwpt->domain);
 
 	if (hwpt->fault)
-		refcount_dec(&hwpt->fault->obj.users);
+		refcount_dec(&hwpt->fault->common.obj.users);
 }
 
 void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
@@ -393,18 +393,18 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	}
 
 	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
-		struct iommufd_fault *fault;
+		struct iommufd_eventq_iopf *fault;
 
-		fault = iommufd_get_fault(ucmd, cmd->fault_id);
+		fault = iommufd_get_eventq_iopf(ucmd, cmd->fault_id);
 		if (IS_ERR(fault)) {
 			rc = PTR_ERR(fault);
 			goto out_hwpt;
 		}
 		hwpt->fault = fault;
-		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
+		hwpt->domain->iopf_handler = iommufd_eventq_iopf_handler;
 		hwpt->domain->fault_data = hwpt;
-		refcount_inc(&fault->obj.users);
-		iommufd_put_object(ucmd->ictx, &fault->obj);
+		refcount_inc(&fault->common.obj.users);
+		iommufd_put_object(ucmd->ictx, &fault->common.obj);
 	}
 
 	cmd->out_hwpt_id = hwpt->obj.id;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 0a96cc8f27da..539c24ada6d0 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -333,8 +333,8 @@ struct iommufd_ioctl_op {
 	}
 static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
-	IOCTL_OP(IOMMU_FAULT_QUEUE_ALLOC, iommufd_fault_alloc, struct iommu_fault_alloc,
-		 out_fault_fd),
+	IOCTL_OP(IOMMU_FAULT_QUEUE_ALLOC, iommufd_eventq_iopf_alloc,
+		 struct iommu_fault_alloc, out_fault_fd),
 	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
@@ -501,8 +501,8 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 		.destroy = iommufd_hwpt_nested_destroy,
 		.abort = iommufd_hwpt_nested_abort,
 	},
-	[IOMMUFD_OBJ_FAULT] = {
-		.destroy = iommufd_fault_destroy,
+	[IOMMUFD_OBJ_EVENTQ_IOPF] = {
+		.destroy = iommufd_eventq_iopf_destroy,
 	},
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,
-- 
2.43.0


