Return-Path: <linux-kselftest+bounces-27505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B20A4483B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DF9188FB0D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40136211460;
	Tue, 25 Feb 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NnC7NFLp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C49D20E020;
	Tue, 25 Feb 2025 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504395; cv=fail; b=EZ9mK7Jb2xpjK1t/TF88Da7xMbdQ9X5A6oAUN6LoLOCDpUccNhqmeGxyvRDQBpJPIHDjEN1HsxMcprK4gv3lS7TR7WnjxmGzpQfUR5IruZVAWns//VOzKK9IyZ6goDLzC7meVozOLYZKsRxty+6k1BKGqp+8wOeaiAQrBbpovv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504395; c=relaxed/simple;
	bh=39IPkdoCZawziROlG3zFClLexU6UBk3J3x6yt3NPQiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uE0eN5RiSeeNLsqhUynewXen0qHTjSoIlqiv1wjaSM8zJCNasU3HHwWBnuAdIZ3FDjLv//9JZUrrg26+KkmLuj102Ux0xhK4cehu/PMe40k+GtcmY1vxJJRmEgXhSNYLcf5o+817xJpA0Z8Tpfk4XZkFVXCLyi/jYoFNdtQZ8LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NnC7NFLp; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFjVn+giaD7YRbF50UREI2P2fmfjQC/hKUBsOhO0ea7CKSahCZJrEMStLxvmZhPNKvVDsP3AUa/Qv0u1r1GWvsVcshBA7UyR/99Mgknd91xkoWnNrVKjJLqdybFT+LRVhLLdROCpjWaHFajsxZeYQCTPobNZ3PfNOnG87qBRn+9qgUCNgCv1iQeFbDWgKhdq8UaDGiMkSvIzhbiLxo88/d3rsTgrXglMjI51Glba01HlWyheYNRmJO4nereXg7I2F5fSdL2aH+Ht0A/mVYy6fCaoffl4L9dHZEme5sTMwAxYgT2BcdlqGJtOYMUmufc/UUxYVAyxU8lAtqIJhc3Dbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WsfzoRpBlq7Lc5qCBX33KPwTU3L8nevg8VpC6E4Xxo=;
 b=eiv/SSkzoaCIFJIXQ2OWk8sIkmNaGtqblwqVEqiTknGUZt7rYqFibFlrfel3hD9mPDzbZjgo2Wvt23upABPLMykfZUD9QNchotg2DqlQAQHC8DnmUkebvKUpUsGL1gW9iTx0lTNl6S/K9FuYXNYygOzohL2QpoFYnrB4qVO2j+1pqkMbmOfO+oQ49fgW6UE2qtvRwHlCSt3vbrVIjRCT4DaT0AiAym+2b+7s9GqEaBnhJZ6RHgh3Y5b3KL2LU7wACCkr7XKkdQ+nKrD9fOAQDgcBMeZYIC5Sq81Zgay7rwTixy1Kx81Kv9uboiM1TctPwhZwwudR3f+9EBUZU+1vyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WsfzoRpBlq7Lc5qCBX33KPwTU3L8nevg8VpC6E4Xxo=;
 b=NnC7NFLp9YKQNDQRbT8DNCL2g01m7yjLJOHv59OVD08WIXYZdZKQrPs4VjltkwPagYcLZRVfWi1FmVVOpXwsDwOT1Rk/xvtuaox5gnQq/gYmWbQftrPkGCdv08vH3B/WDqod1aJoZxHm5w53J7ZHqlwkVAlheiaSoAloEqHU6/wZZZxn7rMcHEtFPuSFCAhyZg3UxM0REGJrEhyIaxDoAEekgTN+gZMqv4QIPjKqJzy/3MHPGKw4HgRa5Z1m7kCiOhKbE7czfzsZ/4h7+oAFqQymJc4L6bX6liDTC7wW3uw4o7jkcOipl4KuaD+WIQfk7NLr+GguKXDZWpN7VU+OUg==
Received: from BN9PR03CA0690.namprd03.prod.outlook.com (2603:10b6:408:10e::35)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 17:26:24 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::2c) by BN9PR03CA0690.outlook.office365.com
 (2603:10b6:408:10e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Tue,
 25 Feb 2025 17:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 17:26:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 09:25:58 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 09:25:58 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Feb 2025 09:25:57 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v8 03/14] iommufd: Abstract an iommufd_eventq from iommufd_fault
Date: Tue, 25 Feb 2025 09:25:31 -0800
Message-ID: <558b6af6f374c8b701e36e9168336d01dd05572c.1740504232.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740504232.git.nicolinc@nvidia.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 147b2357-0826-4d4d-7f41-08dd55c1878a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kk1lfZ1lKlKbyqqPUaIcHEymYXXCPepMWFFX+rrkjWfMlImPL+G4rJWeMgI6?=
 =?us-ascii?Q?8gUXkabuSIth96ktzWk2gg0AXAr1B2FxiRy+avIeGvmRYybkIBfSuFZlyu93?=
 =?us-ascii?Q?MUi29fkvgrm7UnevFQL9lqhRQL5t9lOu5Qbk5ckXgMm8VOMzxMgFei5xMYY2?=
 =?us-ascii?Q?3NWcXAtGAtXSGj/n5jyN1ZjwejMLG6U+Ez1BaV0yqj9MZ9IzCZjdxpE70on9?=
 =?us-ascii?Q?/eob4718K9whBH76Rhce+rC++YoyRAWlw5BDOl084vEHk2sTuRY3YFXc5hI7?=
 =?us-ascii?Q?oeyC5X4t7OUywtEbjBRTs18//6p+DEDYxQ+Eg0ATqHe3Q9CIWgi82kTAuSra?=
 =?us-ascii?Q?qBl3tf1LxI6xlQkkcjShDTIodNVSUvwUyb7RsH8Mvl48kBcTH30bLPid2ckJ?=
 =?us-ascii?Q?+tgvMV7eRLh2Zlt955l0fgM+FESqLUagrILuds9NEBmgNniMtwaO/OJ3Mrju?=
 =?us-ascii?Q?sRjO8oalTGwIDvnL9bcsrBK7vXF7ccahb/VyYh7RJLWeCELMCif8kh/AxnYm?=
 =?us-ascii?Q?P4tNGsFuWxdqwp3O1bDgPf1e88jhgBcb99ser3Izkj7ODD33SAVMkAoFQWxp?=
 =?us-ascii?Q?o1YomLe7xtvDNtxmkZCa9W5mVGLceUMqo18L4uQUULvxTnie4/IFAg7Jn1hB?=
 =?us-ascii?Q?lrsx25WuLdZtfs5onTMGkcXZ4X+jfzJyNhaojjNNOs1QXl3Ck9sOwAYxcGrI?=
 =?us-ascii?Q?iLFycU+AS0+1V6AXlR10xb2qDjf/izk8j56VfbOLvHrdnDSF9891ralwl5jo?=
 =?us-ascii?Q?L7vOnotRxGAejNMR1PvsYpuB2c/PNl5Z95dhydVpJVgun3Ol4tb6GsOBobOp?=
 =?us-ascii?Q?TmPvEoMyCHg7JZc4cDIZKH5wJhfMxa/9ccUF+RsbDWipWLnXKYeiNzUo6Cc1?=
 =?us-ascii?Q?AswZNFFvBISbDswYa3XVSm85r+o+IBRfAC46AL0fTp6fegW4ywTo7ph/KwXE?=
 =?us-ascii?Q?8cRC0StBNJksnFHnWaegccjpCSDYfB7uC7Q/dBDskh/tw+QgsQv+8Dx/BXIx?=
 =?us-ascii?Q?CelEuLaXe2319rcPycYWSFbhxPVq+KyEdozEd4AchRD6Kr087UyfD5aqPJPP?=
 =?us-ascii?Q?OqlDnXMCKER4ePLo/IqtZ206udAbvjzTnIBBVDMxp3nCbc+W2hYgavC4SbgE?=
 =?us-ascii?Q?vVDhealAJ4e0jGDZ/VaKWHKFZsrC/mVhHviHWFYDDrpZsq6yC9ZMLRkhCCw1?=
 =?us-ascii?Q?vvDR/i+d+wNSK4JdG3S4Gc9D8gBJq6at4AexhxzYfZkgKSOyfbTLLRMHIdi0?=
 =?us-ascii?Q?6+6NPdpN+XDS14b3bBeBd12EhO5u5MCDPJebU0CKgn0sl8UMFRz/0z60zYoH?=
 =?us-ascii?Q?IIwW8P6U35t4kRHGKJZSLuc84+UenexkcSnfpy+GY1M4SE44iJI7FZ3n1Sfe?=
 =?us-ascii?Q?Tsup+G9EER4F5MOknI/qo2KDlfiq0A1MxnXZy4ePaLjocNH4TBSnyWpIXCkv?=
 =?us-ascii?Q?d+RPSIbd1AWm9feayPmvSqhD9S19/KAxgAUWmiRTfXrYTBcqYlpoYojWl0sp?=
 =?us-ascii?Q?mFVv/apsFIGBLh0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:26:24.5496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 147b2357-0826-4d4d-7f41-08dd55c1878a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693

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


