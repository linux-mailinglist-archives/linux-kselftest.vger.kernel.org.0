Return-Path: <linux-kselftest+bounces-25141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E02A1BFB4
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 01:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728B53A24A8
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 00:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606C8FC0E;
	Sat, 25 Jan 2025 00:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QFc5qWUf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09F522A;
	Sat, 25 Jan 2025 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765075; cv=fail; b=NgTf5xUbRPDG6jvtX82j4VGirhYRfxRbxe1v6L973dn38q/fFCUgoq7pbKBLWAKo04hgmw8z62hC4tCSQn+qE3yP1kcZnjG+3vMK4Eqy5PRZQL0/uuc7ICSWlAcWBFQ5J9ceewh/0TzKMIXpDZESl2hMCr5azeQMPbSDvOxRooI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765075; c=relaxed/simple;
	bh=KLLa4zKHoZLXfKs0SkGs6aXpEvs3ifZGsQn8Oo8v6yA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMLzVMleNPEx04TVt8Sen2Btb96PF51zJidFgEXCB6TF9Maa9Hb8NAJIeBio9wS8Frc5wVFGbKNyq/bmnvCZAaox/9TqthEbiHOvyxpUFrMaSAELzfp4mTT4IsIL00Ah/tDZtDto6orrdp1ir1w2lIlFSjpQXJUqERVg6Gji9gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QFc5qWUf; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RE5ghEtrWU/0vKPV6jvhG+myBk4dvvW95O0t1hVjMAto4qo4YBRDbC5hoWQSBm6gMs2VXHQSPuCVAC3sCbZeOG+M/PiWeqLVM3FvlqZw3yzoTNMP17wdYcwwe4Th9XHI0WFgCgST9hGC2pUTLS+xNwXQkOtiQFaUUv+2S8nl94ch9cmbvWiNpQPPiKIuO41NN2nfMO34j9yDa5C6pH+bNSZTxzSctspQ6LvCx2z0n6MGIvPK0OHfiRYXNtctKQw7sER6BfNISCI+CshKZ4DX3W7OgoEYbZtOz9/idncE4rsyALccwaYLzBQGSKiuZztMmRfotIidgJgAmorU/UnVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fltRdQ8ypYk8vDK8FdOht0/NVhdChHkqNFH87SV1g0=;
 b=wx6yvofqW90zKC2FDuFW/K/uzzvHCtCn9kNpdCbWsF1kQP/UTGEHsF+U+vEoR8sh3Vcfm69FPFomTtN9k8/99wTWrMt0qkPx+WB+v8BlUV/RpOa8/mM5eWQty622fZm2uSfUTdHGD9tCuT9iq17IQqu6M2owT04V8PIfRQJ3JHPip0yvM+isNRJ36Qpz9jCCZsYS+QRL/8BSnXePGX6gzIKNbBKyvs6+EVwZbDQdHxBDLCWWhY+F7oC9elKVtXzD19ET03kE8+m1cqC1tyNcBqMsL9hpmcOMT6wJQRPDht4JZCoAttmKnI1U+/9zrLhr/YXn64NnHdc8sPNE9FgUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fltRdQ8ypYk8vDK8FdOht0/NVhdChHkqNFH87SV1g0=;
 b=QFc5qWUfHbjk7BShGtjX32gwBcUNfIQg7ZvjMvns2Z2xII6JV0IbqsGOznHxIlmx9moDxMq9xCVIPrsuNfr9RR3gCNtaEOniF1y49F+gD9ZamSoz+s4Sx5a+JRZMyJndmnVuxW6c9ltFXjPrK+lrnyCNY6CipnE/JAiXcpTpMXCVE9qf55JB1mC7qSfr9oanSo0e0ou+qEbenj+7Z9xEQbglJFtJsQ7LoO+jWd1aAu6T6Z7k4WlnFNLCmRHH4u5UyVctP6VunCXWdTjs/dOGV53azwEnaPEsIbqla0PXXozjpo/7zDOWhRGQ/pCsGdUzPbbRAp2qAo5/EfvM3Rp+6w==
Received: from MN2PR05CA0041.namprd05.prod.outlook.com (2603:10b6:208:236::10)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sat, 25 Jan
 2025 00:31:08 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:236:cafe::5d) by MN2PR05CA0041.outlook.office365.com
 (2603:10b6:208:236::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.11 via Frontend Transport; Sat,
 25 Jan 2025 00:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sat, 25 Jan 2025 00:31:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 16:30:56 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 24 Jan 2025 16:30:56 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 24 Jan 2025 16:30:55 -0800
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
Subject: [PATCH v6 03/14] iommufd: Abstract an iommufd_eventq from iommufd_fault
Date: Fri, 24 Jan 2025 16:30:32 -0800
Message-ID: <8427398787e81b81d0dc6df5661032b2301c06f1.1737754129.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737754129.git.nicolinc@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: f11b665c-b00a-4b0f-07b6-08dd3cd78fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kCzw7QSIFiZAWu69kcMrE9XiJPx4eNAzvfHqw4cEJGnyZYheQiKges06IqpA?=
 =?us-ascii?Q?XljMj2SwbwNXVfBWY8aaW4ztTdtBK+BYy9cVZhemNIt7ctzD174GfSFD3a58?=
 =?us-ascii?Q?VBakpQtTnXWb1Um2nrjD8eHF3EE4zOToKjM2EhL4uZgNdac3N0jHfswK4MMr?=
 =?us-ascii?Q?RgC6clObaoSSuawtnfYi6ZQkPUMTo0eCEYxcrs1ogpA7YyQYqkQEOOGnG9uJ?=
 =?us-ascii?Q?JNs5nOF20KnFGtR1hTocr1VP4VT9P1QvxaXLQbgxH+uSlCkCLyGlDJW4TnTb?=
 =?us-ascii?Q?2lGXTLxiAdCtdDwDsbRURFqpsbpr8gZyvTLTHhJMdv5ivPlhu0Hx5a+jiPut?=
 =?us-ascii?Q?9MLvzWce8P7/11N8nzgcF0WwE108nOpMi0BGaGZQWQth2CHNRKjuP/rrjjYD?=
 =?us-ascii?Q?0oo3WQbYW+jHHK/5sMedgxNztA7lu3/7KWeG9K5rYrO5K0TrJEjazWE3rRAO?=
 =?us-ascii?Q?p4SL1b5401gZSOUvj7OSjT9T6I+qb5dEOmENODHYPaDNqN82XfVTIeCV24yd?=
 =?us-ascii?Q?0m+WQV2bUKQZEYB0ldU06RvSzhMyrzXFtfKH+Ikt2dxT2m7nrsc6iu2SC7aG?=
 =?us-ascii?Q?3dptZQEWl81CfnW5f1XjtgHZoINhAO8A9wGMcQBh0RHaRUVIzVNWWZJLDtVX?=
 =?us-ascii?Q?J9ftOfYOLBt6/9I/zfg0OslpOlRaR2TPHPSEzFkva9kH8ZIXY1xuJoNjJHdy?=
 =?us-ascii?Q?8iGaMWxBpvv+4Wgp2WY+WVPD+3B0HkJEYPiP4qEl/odpi7lNDySxnI1jtwXo?=
 =?us-ascii?Q?eLC3atxLZRdcu6iaTduXwQhx6/smer9q1ieGpsCZ4kG/hVxxrg7H+cBKN/8e?=
 =?us-ascii?Q?eMH0H2ZU7+g55VLcMnl3wa6eCxFtiqj93XzecDd85pkGajXfRYC3EyU9aTWC?=
 =?us-ascii?Q?QCJxvLekFhoqPYUqquHwzci3BjpiZuHqqmF8CDG4IZEuDvt1F0v8Qsp5fkLD?=
 =?us-ascii?Q?ndC6jCCO4sE7Nz67FvgmOiuWUi1PUqXmOs8X8h81tF7Gl7w0n2UGbXhPt5nl?=
 =?us-ascii?Q?5djUprT0oevMDW08WNAc3CHbcitNYuucz1qRE80oPAKEc1ZAQkF1x28LNKJe?=
 =?us-ascii?Q?4wc+lx/4iBo4Wl63+ouWs156E0YLvDtT6EpiXEVMtue9GJygCHX2+dt/Tif9?=
 =?us-ascii?Q?yVEZ/h/eNP/KJO032P5qOwwDpCF8oYRozYY7yjAkiR95ywofxaSdf7Mux19S?=
 =?us-ascii?Q?abKh/rYks+dJzQP7HcYfOy6BhwPLKMBYsMbtaw3aSj+PYtHl97PA92TLtEU6?=
 =?us-ascii?Q?kHLcGbO1n65iN3SwQ0X5fkL0My+KE/JScPtE3/HGi51moO8k3iUR4PNA+b1V?=
 =?us-ascii?Q?M+u9oaPmW83on3ZH3VTUO7tHjOvtCdrW9PdpRfno57Q4YbGcTo32aZ+y3K1Q?=
 =?us-ascii?Q?TZtqfFGBeOwtcQzajVkYRhHlXkNzUmHT7H30aSuOcu8rIXkJWDLZ070HKTNs?=
 =?us-ascii?Q?Q8OSsvfopTFB/y78XCPMgXTI2/UAMme5ss49+WILahizI5yUn/xYZJSA1MQB?=
 =?us-ascii?Q?XIPb2g2UOOySsU0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 00:31:08.0195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f11b665c-b00a-4b0f-07b6-08dd3cd78fa5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940

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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  28 ++++--
 drivers/iommu/iommufd/fault.c           | 111 +++++++++++++-----------
 drivers/iommu/iommufd/hw_pagetable.c    |   6 +-
 3 files changed, 82 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 034df9b256f4..ee365c85dda9 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -433,20 +433,13 @@ void iopt_remove_access(struct io_pagetable *iopt,
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
@@ -459,12 +452,29 @@ struct iommufd_attach_handle {
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
index 08d940204169..0da39c3dfcdb 100644
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
@@ -111,13 +113,13 @@ static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
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
@@ -219,7 +221,9 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 
 void iommufd_fault_destroy(struct iommufd_object *obj)
 {
-	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
+	struct iommufd_eventq *eventq =
+		container_of(obj, struct iommufd_eventq, obj);
+	struct iommufd_fault *fault = eventq_to_fault(eventq);
 	struct iopf_group *group, *next;
 	unsigned long index;
 
@@ -229,7 +233,7 @@ void iommufd_fault_destroy(struct iommufd_object *obj)
 	 * accessing this pointer. Therefore, acquiring the mutex here
 	 * is unnecessary.
 	 */
-	list_for_each_entry_safe(group, next, &fault->deliver, node) {
+	list_for_each_entry_safe(group, next, &fault->common.deliver, node) {
 		list_del(&group->node);
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
@@ -262,15 +266,15 @@ static void iommufd_compose_fault_message(struct iommu_fault *fault,
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
 
@@ -278,16 +282,17 @@ iommufd_fault_deliver_fetch(struct iommufd_fault *fault)
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
@@ -336,7 +341,8 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 					size_t count, loff_t *ppos)
 {
 	size_t response_size = sizeof(struct iommu_hwpt_page_response);
-	struct iommufd_fault *fault = filep->private_data;
+	struct iommufd_eventq *eventq = filep->private_data;
+	struct iommufd_fault *fault = eventq_to_fault(eventq);
 	struct iommu_hwpt_page_response response;
 	struct iopf_group *group;
 	size_t done = 0;
@@ -376,59 +382,61 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
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
@@ -437,7 +445,7 @@ static int iommufd_fault_init(struct iommufd_fault *fault, char *name,
 }
 
 static const struct file_operations iommufd_fault_fops =
-	INIT_FAULT_FOPS(iommufd_fault_fops_read, iommufd_fault_fops_write);
+	INIT_EVENTQ_FOPS(iommufd_fault_fops_read, iommufd_fault_fops_write);
 
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 {
@@ -449,36 +457,37 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
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
@@ -491,11 +500,11 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 	hwpt = group->attach_handle->domain->fault_data;
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


