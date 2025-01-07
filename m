Return-Path: <linux-kselftest+bounces-24016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B91BA047B9
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDE93A1953
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE861F5439;
	Tue,  7 Jan 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rIo3s/mc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142A1F4721;
	Tue,  7 Jan 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269860; cv=fail; b=qDvinOdVweqYD8Nej6adMX9q3QKHcwXj78KVz6tMjFU7IWHMgZhD83ucYTPqgqEEWolYLrumtYW0LFBPJZ/Iloz5axNFCQf23AaFa5jUzAVxLF8/3sNxeLc8Nk1HXxa7sHpsoh9QRjDLaJ2sAVzawlGke3/Xu9c+JHnoL8ZfTII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269860; c=relaxed/simple;
	bh=o8tl3uDZQyAAC3FDN06M+EnLMsOr7zyjOsx+BHizObs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1oHgM6sFIXaTbCBBCUtGBEItHY7IL8/jPmLxDr8XFOA5RlMlq8SParau7YWw0W1noHq8T+FtiODaqUnX4iA/3rdGGM6I3JpIyznVyiWOCDY7R1nZ7bKxMmu0IjMbZXCOrNEuk2LKMGHBPM/sQ8xQcfs1FQvmafHe2BrBvmZsJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rIo3s/mc; arc=fail smtp.client-ip=40.107.101.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCtE2zOENW2ExjbJ2GuqbgU3H88Emhb/c8jID2H78I6e1iZurFVn+Mi/l+mgfV0ohFmyUZmKz4oQrimWTmKSkMPCPreDzt3kEn4IeOP5fin8VwvRO46z6myRSzjg2PcFRezJrAqhshz/FJxwZCXOzXlMK0AKmDyIl5MaPczN9f3d4k6K80YUtxkrouzmjd8uoCECaNkge9TdOJzwKjUc8oYoR1w2MMHxqOcRYFJTGdHEZotpG8j92bdWiXYV5CM7ZSArnCCK5xd/KnZgwlhamaT5Smi3MPtuYmAmr/vR+48TnpSgKRvVp3v1WMkL7uQr/Oll14dqLsTX6Gh45chjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqkcjShfS6Dy8gOwjTbeRHzenjQvP1jkdsMcdEpsLbY=;
 b=hspifUDXAwNexJmJbS4IijgPlEmyJZseTcyIuNiCGRe2uj0X17o7CP3B2/jJ+Y2AQL2pyZZ8KViUYP4UTbgT1LlBKunPLuN1XWBFEpU8YdgqX7ptYMYEQ8c07mkz8pIXF1LDc7adl+llbjq4UZXob2rLbj7nx+RUGsAd+HACe0MDbVlY4jYOE8JUlJlEqJwZubquVkKmYft7LlrQ8fRSfzjBE1AYZ9G2SXkh5cJsxqvHV8GuOiKe3C7GH/zrgSU1ofe8wubCKOQ/uHVlfpjqItBg55eo55HatQxcctxfoQzonGcCDjI40Y3/TuemFm+TbTpc6hSI8C8Ve6RM+ISUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqkcjShfS6Dy8gOwjTbeRHzenjQvP1jkdsMcdEpsLbY=;
 b=rIo3s/mcqTyhrSLqH+qhqn9TFc7mgr9eO15CNtMITtEwHAi1tC++CsfwnaJCIcv2gdYiSsEhJlrBa5EEugrDKZnEPxoMP444CaEQVLurAWEZIAGWK0f9HbzALWboUxZubWTvIDSY0yaQlQ+vq25Ko0CZoQj0o4ymj3zxH9YE/TNzTwILih/pfXX6WvBGgHETo5q5MPez0Vc277bJRCnr7QFTVyTR27elepZ+QX8TmURE1JosuD0cDkVAZzMhgyc2f3Gf8euHx8PGvXq2bXiCzGyeYOe2h/dyVIV8WApnYJJ4SlilQNYH3Z73iB+RoqwmV397UkFZ1v73aUnu7/WfvQ==
Received: from BL1PR13CA0029.namprd13.prod.outlook.com (2603:10b6:208:256::34)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 17:10:52 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::1f) by BL1PR13CA0029.outlook.office365.com
 (2603:10b6:208:256::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 17:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 17:10:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:37 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:36 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 09:10:34 -0800
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
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v5 04/14] iommufd: Abstract an iommufd_eventq from iommufd_fault
Date: Tue, 7 Jan 2025 09:10:07 -0800
Message-ID: <a6490048ab3df78f648e3ef0d217a90b7213d47c.1736237481.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736237481.git.nicolinc@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfc6c73-ba35-4479-2f42-08dd2f3e3dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lA5JuPylyPznI+/JkHVbDlsh1X7cpUcxPoqdO1ucpvv+GghrEG6a24/AQJQn?=
 =?us-ascii?Q?hUhObR867dD0xXjBkPblzfR3TxaDIjQd4xnNdmRlFo7Pd9YNMuVrTk8leJZl?=
 =?us-ascii?Q?+rVPLGLTkiw0JjOHBVae8MVxFYl316XdKHUhvIorValXwqdu8wIV/lSkWEcu?=
 =?us-ascii?Q?dB13P08Ec6YpZX+CQ+nEqZkOpBlyjGYZyDpnx+7odrsJryOIdrAahrBz4XPb?=
 =?us-ascii?Q?U/G9KoGzDSE0NLuf65MFSDsyJSLS8fAkP4FR0k4oe/32P8WqNzLNfoTXDpNH?=
 =?us-ascii?Q?ZgygvVwTld7BMsUjyw8CPEVPhVKgdS94RA4NKcgLNL2SZUno6wHh7p8TKQ7d?=
 =?us-ascii?Q?4vmXwQilqzsng/tCzAPZTpNJaFIrKC+MWTy9cRpI3rfwFP5tDdVJ63bp6fRH?=
 =?us-ascii?Q?vYAafuKYelFNKCfeE4sabCCev7wAK5jStMXzBRaZvGnlzE8E9NDnLcXAvWeL?=
 =?us-ascii?Q?FoJ9wBdWjhW+HLDqy4PujmEWaEm3q61fqEf3eeNDZnBu02CEAEi5lDZuZiNU?=
 =?us-ascii?Q?Rr8i0Prs6dNOkdOBhLpp8Nmz4+F0HgfFRAzYkdizJhT5VWu1QkCrE4npEty4?=
 =?us-ascii?Q?/QY53oHWf08VJlluSj21LGsXZKQdkTgympF4JCCv1eoDM7fZnArTqQZy+I22?=
 =?us-ascii?Q?gsoXugVyih6roCBIHtdPMS5ShmUpxyeB9Pz7D2HUcbEMIx/Y9wokiyD2uXHk?=
 =?us-ascii?Q?Ph7R3PaAwD/adLOgMlzaNGNNz1B54D4TyqCBm/+TMqAMITtUyKnZF2uSCMwS?=
 =?us-ascii?Q?5D7Mv9KPqg56wRqz6LJr14PWcRetRe+h1ITmzyhyWqaUk0umlQqAGXPN8djZ?=
 =?us-ascii?Q?QHT4bYuIkO48t13t+HHRQ4HUy3FW74nCD4MW6qYckbOYQNOMlI5WRpa86Aq7?=
 =?us-ascii?Q?BY7msXrkUYNQL5dnNmMl7pay+ohKhTuBmOZimDtk/c6xm8jfNKF0QZJN9LOi?=
 =?us-ascii?Q?T1pBwzMG5j7P4jEZ7K9WemN6Kpgax5t0LNjSW6pWPt9MH0hW8KJ8N3KaZjhB?=
 =?us-ascii?Q?ma/B6/gHCpUh0UcpJuCtshvJeqk3LMF+89iBT+vxK2J/RS524vyf7aHT4Ag0?=
 =?us-ascii?Q?3zRATVCbegt3d0BI8KoH1FYyG/X/edNxAkm0FgsfzKaGYwyiFTKv22rmkKOn?=
 =?us-ascii?Q?sCLtujmcB/2aVLvNtIMu5QseyjlPbmJpKhuR4PHtJ/uQNe+1IBL+Z95z5IRk?=
 =?us-ascii?Q?dIUplrgxzONqL1sssa7WkueECNeEb+9G/oDVknEiiN2NQebktxTS9S5nZ3Xp?=
 =?us-ascii?Q?XmozQs34Pk3mygaBe6sav3ir5rerT/oo1zULgUWCnA2aLbwPMdl/4jy+c0s4?=
 =?us-ascii?Q?JO6or4pev2Plq3qiQ/zVvkwBfLHkMGihyP9KzRj/hFS7cWgk+KnXPpagvYMb?=
 =?us-ascii?Q?y4wnantuaqnmParEFBjwb/58dUGqdK2hbQ1SI+savMvrvYXI8vXavnz0FRIE?=
 =?us-ascii?Q?oli3yYiEmlSWYRXIxTq6E6m4X4HcbwqWf5XW8uodyYZ2Sb8gbOtnRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:10:52.6306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfc6c73-ba35-4479-2f42-08dd2f3e3dd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240

The fault object was designed exclusively for hwpt's IO page faults (PRI).
But its queue implementation can be reused for other purposes too, such as
hardware IRQ and event injections to user space.

Meanwhile, a fault object holds a list of faults. So it's more accurate to
call it a "fault queue". Combining the reusing idea above, abstract a new
iommufd_eventq as a common structure embedded into struct iommufd_fault,
similar to hwpt_paging holding a common hwpt.

Add a common iommufd_eventq_ops and iommufd_eventq_init to prepare for an
IOMMUFD_OBJ_VEVENTQ (vIOMMU Event Queue).

Also, add missing xa_destroy and mutex_destroy in iommufd_fault_destroy().

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
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


