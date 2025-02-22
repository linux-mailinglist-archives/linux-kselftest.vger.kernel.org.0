Return-Path: <linux-kselftest+bounces-27271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A29E4A409BB
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 16:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27141888AEB
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319022080C6;
	Sat, 22 Feb 2025 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kmM+TMuU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1931E491B;
	Sat, 22 Feb 2025 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239692; cv=fail; b=SWlA+Wo0OSite0hKqsRfYA3E6uPfcGAA5zB9vSkRKS2R6tjKPqtW28cGlV1mnrgNZ9lr2yN2PtVMgUyd9lBy3Cbt7QjMCiIcTCaADgzgmDa2oEJ638frb9eXRpscQPbQylJPlhrRbwmnsa6BNcfY22QEdxiKNhugxHtKPEoTHts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239692; c=relaxed/simple;
	bh=jNXRGUMFtljfkwjSiuX5v0VH8S/GXRVYFqeNnY/A/W0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lg0ocaEvQETfb6loHDcEQN0y7r69FjGLnM3EXcFRtRRyCbqYqGdlWQINTZG05sNl6ptLDl9QtOeuy851L7RJLEf+5ai8w2DfFnNy9Yb7T6IQNKlNt7NFwXnxRX6nk8JZ1xKKo2a0+kIJVhesMPlBXXopzWCf95AzNSjI75cGEw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kmM+TMuU; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9cg9xiWJgmYKTjjoIVYFlwDSHlpDqicqymYedb3Mas8sNt0q8r7Org1d3dqnTQlBK9f5J2fXS1JyO7r1MJlUT2Z+IWoOujMdIbKCOUes0uld6lBnZb+DCt/Ed2FFuU0+PHAaAufW1hUrUZHVL5jNnnQ1eZ12rKzwRjKFIOER890hqfKlgqBf+v55lpZvG1NLb4ZapI87nAi3K9AvnzyXMF1QTx0tj6rSxgZAfNOwpQYXX3BXAFG+ULQmE6GrTNdvAulaUOM4lHKYZnA+olEwf4T0x07sJcz3pCKTzJK+J/S3jnuidmnJWlEF+Zrkq3lPHELx2hHVlTGxd+cjXQLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Bj49m+yz1gTE0D4kxDXYsIZHvm2UdsEYbs02SBXhG0=;
 b=xXf3U/k3eKBxAmwBM56QeAHHfGZLLHah35UM1KL6sNMXtbU/sS/TI+8g19yIlhXKUdk0T64oBWqmam8WtsqXnxwoXG8vGIBwC7cPCnjQoYAX6xiQxtQpTh0Yslnzby8a0z1BM9cMCbE3iGLIq1UDRm62sXLSrFU8N8NS7PmDEZNnZXWLr4knjFrJ4UMk7lr48zhwnI/J8HL2EXtEF3OOZg7i36Qa6oLXNz3NBOpD49V/VClM1k2q/isxM9QVOoTfSE22XFNSSay0nphxrU1iw1lCZf41n2Iy7WXev82OAeyb7Rj2yQoGYOoY8HNca4ayHMmeyEwX2SEh/9s4x/+aeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Bj49m+yz1gTE0D4kxDXYsIZHvm2UdsEYbs02SBXhG0=;
 b=kmM+TMuUIirgzQPebAI5JnHZX2Uj/g20c0AEpcsmYoeIr6zsOJdk6tppau8GJmvlxflsRY3UMIiTso9PZyiE9iOgcpLddZhpRtD5qyYIDDwMcg52uRRcHmT26yMeaFTvqVOOjXsta5oG07T2cGCJzZ44Qu5JfO0Zv+k7KuLVnFT9ooAseNLT+ZxdYwjKCz230Cy6v4AXc8tei7jbO8G6R8kqsXxYToMNl/Hl3OHen7Q1OkkR4u00kFq1Lgdg0f1dTCdNXr5+vWckwsLfYJhGwwg7FX4IXev7oiq4T/UJCBXhhDeqN+MbUC0v9HIzJ/GSz/bKPQ5wLERKqPQvGtFeoQ==
Received: from PH7P220CA0146.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::32)
 by SJ2PR12MB7919.namprd12.prod.outlook.com (2603:10b6:a03:4cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Sat, 22 Feb
 2025 15:54:39 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::45) by PH7P220CA0146.outlook.office365.com
 (2603:10b6:510:327::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Sat,
 22 Feb 2025 15:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 15:54:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 07:54:23 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Feb
 2025 07:54:23 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 22 Feb 2025 07:54:21 -0800
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
Subject: [PATCH v7 05/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC
Date: Sat, 22 Feb 2025 07:54:02 -0800
Message-ID: <69b6beab203b3546c066fee5e0c9ebe0ee1988de.1740238876.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SJ2PR12MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: d7664148-185d-420c-4a03-08dd5359369c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q9bezmqV2wgzU72+epFoZKm8QEkd7864wqbJLXKxrhFMsVBjahPbbR1TatzD?=
 =?us-ascii?Q?ViaHT4yeFwwinqOw38b+JLcQxF7XtT/EaY/0aKmeDIX8PPNBLrl/6v/ppBgT?=
 =?us-ascii?Q?6g4Phbz868L7HgjGXlbWIuFxAaFiXvfA3B3XLjwHAPqKtP1Joz01JxFqymZU?=
 =?us-ascii?Q?+9crxz7CSntutw4DoONLIexjMoeeXo0hg8MT2pMVyximr49KWGnHs0/W13uW?=
 =?us-ascii?Q?ldic3i4ltLyJ1t1JFR1+vznAWX1P8KVtKB9WQQkh7xyA6nGUeqbSZr0hdhdF?=
 =?us-ascii?Q?sfdaFvI8XyPWDERzqJsA+Hw8iI/rN49/Ay6oQEaOHA7/6lbN7e0aX86kE0Lk?=
 =?us-ascii?Q?+6ANLN+y2WrCz6B6ne7JiEZiRdQzqoQf+2fZdWky51mZelidezJ+uIb/BolQ?=
 =?us-ascii?Q?qxtxtlU+Js7Y6J47zfpOI47G0sHRv+oJ7wL6VC76y16yq3LQQyg42AZDKqCn?=
 =?us-ascii?Q?IfiQrCdHPsUb7c+9yIt/9/UwyQzZO6c8YQv1uC2bCfe2tFp/hBDkMMia9UU/?=
 =?us-ascii?Q?UG9biadh0X0Y6/WJSo0+S+xqEnufmDM3XU6iTirbtVMsDhzTRyWqGwK7n5C+?=
 =?us-ascii?Q?Jk75t9UhJcoKUR6tQLi3Vz8TJoK2YLAhSVxrRoQj3SYxxTyK1cS3f72m0FM/?=
 =?us-ascii?Q?QrPAUAzXXEj2bvC6BOkDdmVLQg+SZsYPzifAwJAQdRlE+4Qgmw2Fihzpt1eO?=
 =?us-ascii?Q?qHnfwVj0YhGMZugJwjVf/SfEJlqP1SYnnDenzsBPShE8VPEKVvJS0cEaIi98?=
 =?us-ascii?Q?IhedNQ0WfTJtQCQzeDAPnBiRA6A6DlEkpJhh7qgv/iwaB0ozGFPFxVamPw81?=
 =?us-ascii?Q?kzKo1hi/rY47tR77B4+N++zGRywfNvIhKf9ZzBQEufcfokqFOh3JFDdh5Nyc?=
 =?us-ascii?Q?sKQNBKbfVk8HPXcWCpIzFiLyfby+p6/azD6/1SUDr02udd2rqZs5iRwoQU1Y?=
 =?us-ascii?Q?sMFiBx4xw+s8W1DaVmH0SX2+8C1U2rkjP7UwrBe7/VK3ALdSbRmcdhNV/5x4?=
 =?us-ascii?Q?NC5fPTGwsV4pPF8BFnhfbu/UY7tQbw9ukFeIx2NmHwsxzzuzancYB4H6Z8Yu?=
 =?us-ascii?Q?B3iJp7ACZ0Vrni4S2g7SCiGGrhatFiiRecCMHFkC8wcP3R+sPPAj/XsVR1JL?=
 =?us-ascii?Q?mDNAf67+CDpodlwsVY1NQOze0LY7D+26L3uH1X22CV2xuFxh2jZWsGakC8i2?=
 =?us-ascii?Q?wni9jsBn6WukqNe/QLEYlgdf/MM4S6+igKlWAPcYRCF66fTqoGkthlPTropI?=
 =?us-ascii?Q?hFEA7tT/f6NXGp7fhtBewoAXjykjF4T1u89RwpKxaYdBbm95heEZr3QXkp9p?=
 =?us-ascii?Q?6SQGgj51EKS5mI7RMoVxmEL3iFd5ypfOLWvBMllvdYCy0vn+FEqpIJMK0hbe?=
 =?us-ascii?Q?IT9/rPaa9p/jpNmiT+CiuonuDPY6m+KSGMTej/aL5FEN52iKtXn1sA/pTbpM?=
 =?us-ascii?Q?WPJnbp4+NolNSsl/5jQb5QyPStwuF8qc4NkgwT4VUagmZ8HYW2DtpICgwbpc?=
 =?us-ascii?Q?GWYHVZB3HLImfAY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 15:54:38.8322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7664148-185d-420c-4a03-08dd5359369c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7919

Introduce a new IOMMUFD_OBJ_VEVENTQ object for vIOMMU Event Queue that
provides user space (VMM) another FD to read the vIOMMU Events.

Allow a vIOMMU object to allocate vEVENTQs, with a condition that each
vIOMMU can only have one single vEVENTQ per type.

Add iommufd_veventq_alloc() with iommufd_veventq_ops for the new ioctl.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  82 ++++++++++
 include/linux/iommufd.h                 |   3 +
 include/uapi/linux/iommufd.h            |  82 ++++++++++
 drivers/iommu/iommufd/eventq.c          | 209 +++++++++++++++++++++++-
 drivers/iommu/iommufd/main.c            |   7 +
 drivers/iommu/iommufd/viommu.c          |   2 +
 6 files changed, 384 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 44fb30af10b0..8cda9c4672eb 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -507,6 +507,74 @@ void iommufd_fault_iopf_disable(struct iommufd_device *idev);
 void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 				  struct iommufd_attach_handle *handle);
 
+/* An iommufd_vevent represents a vIOMMU event in an iommufd_veventq */
+struct iommufd_vevent {
+	struct iommufd_vevent_header header;
+	struct list_head node; /* for iommufd_eventq::deliver */
+	ssize_t data_len;
+	u64 event_data[] __counted_by(data_len);
+};
+
+#define vevent_for_lost_events_header(vevent) \
+	(vevent->header.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)
+
+/*
+ * An iommufd_veventq object represents an interface to deliver vIOMMU events to
+ * the user space. It is created/destroyed by the user space and associated with
+ * a vIOMMU object during the allocations.
+ */
+struct iommufd_veventq {
+	struct iommufd_eventq common;
+	struct iommufd_viommu *viommu;
+	struct list_head node; /* for iommufd_viommu::veventqs */
+	struct iommufd_vevent lost_events_header;
+
+	unsigned int type;
+	unsigned int depth;
+
+	/* Use common.lock for protection */
+	u32 num_events;
+	u32 sequence;
+};
+
+static inline struct iommufd_veventq *
+eventq_to_veventq(struct iommufd_eventq *eventq)
+{
+	return container_of(eventq, struct iommufd_veventq, common);
+}
+
+static inline struct iommufd_veventq *
+iommufd_get_veventq(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_VEVENTQ),
+			    struct iommufd_veventq, common.obj);
+}
+
+int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd);
+void iommufd_veventq_destroy(struct iommufd_object *obj);
+void iommufd_veventq_abort(struct iommufd_object *obj);
+
+static inline void iommufd_vevent_handler(struct iommufd_veventq *veventq,
+					  struct iommufd_vevent *vevent)
+{
+	struct iommufd_eventq *eventq = &veventq->common;
+
+	lockdep_assert_held(&eventq->lock);
+
+	/*
+	 * Remove the lost_events_header and add the new node at the same time.
+	 * Note the new node can be lost_events_header, for a sequence update.
+	 */
+	if (list_is_last(&veventq->lost_events_header.node, &eventq->deliver))
+		list_del(&veventq->lost_events_header.node);
+	list_add_tail(&vevent->node, &eventq->deliver);
+	vevent->header.sequence = veventq->sequence;
+	veventq->sequence = (veventq->sequence + 1) & INT_MAX;
+
+	wake_up_interruptible(&eventq->wait_queue);
+}
+
 static inline struct iommufd_viommu *
 iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
 {
@@ -515,6 +583,20 @@ iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
 			    struct iommufd_viommu, obj);
 }
 
+static inline struct iommufd_veventq *
+iommufd_viommu_find_veventq(struct iommufd_viommu *viommu, u32 type)
+{
+	struct iommufd_veventq *veventq, *next;
+
+	lockdep_assert_held(&viommu->veventqs_rwsem);
+
+	list_for_each_entry_safe(veventq, next, &viommu->veventqs, node) {
+		if (veventq->type == type)
+			return veventq;
+	}
+	return NULL;
+}
+
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 11110c749200..8948b1836940 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -34,6 +34,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_FAULT,
 	IOMMUFD_OBJ_VIOMMU,
 	IOMMUFD_OBJ_VDEVICE,
+	IOMMUFD_OBJ_VEVENTQ,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -93,6 +94,8 @@ struct iommufd_viommu {
 	const struct iommufd_viommu_ops *ops;
 
 	struct xarray vdevs;
+	struct list_head veventqs;
+	struct rw_semaphore veventqs_rwsem;
 
 	unsigned int type;
 };
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 78747b24bd0f..2ade4839880d 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -55,6 +55,7 @@ enum {
 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x90,
 	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
+	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 };
 
 /**
@@ -1014,4 +1015,85 @@ struct iommu_ioas_change_process {
 #define IOMMU_IOAS_CHANGE_PROCESS \
 	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_CHANGE_PROCESS)
 
+/**
+ * enum iommu_veventq_flag - flag for struct iommufd_vevent_header
+ * @IOMMU_VEVENTQ_FLAG_OVERFLOW: vEVENTQ has lost vEVENTs
+ */
+enum iommu_veventq_flag {
+	IOMMU_VEVENTQ_FLAG_LOST_EVENTS = (1U << 0),
+};
+
+/**
+ * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ Status
+ * @flags: Combination of enum iommu_veventq_flag
+ * @sequence: The sequence index of a vEVENT in the vEVENTQ, with a range of
+ *            [0, INT_MAX] where the following index of INT_MAX is 0
+ *
+ * Each iommufd_vevent_header reports a sequence index of the following vEVENT:
+ *  -------------------------------------------------------------------------
+ * | header0 {sequence=0} | data0 | header1 {sequence=1} | data1 |...| dataN |
+ *  -------------------------------------------------------------------------
+ * And this sequence index is expected to be monotonic to the sequence index of
+ * the previous vEVENT. If two adjacent sequence indexes has a delta larger than
+ * 1, it means that delta - 1 number of vEVENTs has lost, e.g. two lost vEVENTs:
+ *  -------------------------------------------------------------------------
+ * | ... | header3 {sequence=3} | data3 | header6 {sequence=6} | data6 | ... |
+ *  -------------------------------------------------------------------------
+ * If a vEVENT lost at the tail of the vEVENTQ and there is no following vEVENT
+ * providing the next sequence index, an IOMMU_VEVENTQ_FLAG_LOST_EVENTS header
+ * would be added to the tail, and no data would follow this header:
+ *  ---------------------------------------------------------------------------
+ * |..| header3 {sequence=3} | data3 | header4 {flags=LOST_EVENTS, sequence=4} |
+ *  ---------------------------------------------------------------------------
+ */
+struct iommufd_vevent_header {
+	__u32 flags;
+	__u32 sequence;
+};
+
+/**
+ * enum iommu_veventq_type - Virtual Event Queue Type
+ * @IOMMU_VEVENTQ_TYPE_DEFAULT: Reserved for future use
+ */
+enum iommu_veventq_type {
+	IOMMU_VEVENTQ_TYPE_DEFAULT = 0,
+};
+
+/**
+ * struct iommu_veventq_alloc - ioctl(IOMMU_VEVENTQ_ALLOC)
+ * @size: sizeof(struct iommu_veventq_alloc)
+ * @flags: Must be 0
+ * @viommu: virtual IOMMU ID to associate the vEVENTQ with
+ * @type: Type of the vEVENTQ. Must be defined in enum iommu_veventq_type
+ * @veventq_depth: Maximum number of events in the vEVENTQ
+ * @out_veventq_id: The ID of the new vEVENTQ
+ * @out_veventq_fd: The fd of the new vEVENTQ. User space must close the
+ *                  successfully returned fd after using it
+ * @__reserved: Must be 0
+ *
+ * Explicitly allocate a virtual event queue interface for a vIOMMU. A vIOMMU
+ * can have multiple FDs for different types, but is confined to one per @type.
+ * User space should open the @out_veventq_fd to read vEVENTs out of a vEVENTQ,
+ * if there are vEVENTs available. A vEVENTQ will lose events due to overflow,
+ * if the number of the vEVENTs hits @veventq_depth.
+ *
+ * Each vEVENT in a vEVENTQ encloses a struct iommufd_vevent_header followed by
+ * a type-specific data structure, in a normal case:
+ *  -------------------------------------------------------------
+ * || header0 | data0 | header1 | data1 | ... | headerN | dataN ||
+ *  -------------------------------------------------------------
+ * unless a tailing IOMMU_VEVENTQ_FLAG_LOST_EVENTS header is logged (refer to
+ * struct iommufd_vevent_header).
+ */
+struct iommu_veventq_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 viommu_id;
+	__u32 type;
+	__u32 veventq_depth;
+	__u32 out_veventq_id;
+	__u32 out_veventq_fd;
+	__u32 __reserved;
+};
+#define IOMMU_VEVENTQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VEVENTQ_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index f8e60e5879d1..4c43ace8c725 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -262,13 +262,148 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 	return done == 0 ? rc : done;
 }
 
+/* IOMMUFD_OBJ_VEVENTQ Functions */
+
+void iommufd_veventq_abort(struct iommufd_object *obj)
+{
+	struct iommufd_eventq *eventq =
+		container_of(obj, struct iommufd_eventq, obj);
+	struct iommufd_veventq *veventq = eventq_to_veventq(eventq);
+	struct iommufd_viommu *viommu = veventq->viommu;
+	struct iommufd_vevent *cur, *next;
+
+	lockdep_assert_held_write(&viommu->veventqs_rwsem);
+
+	list_for_each_entry_safe(cur, next, &eventq->deliver, node) {
+		list_del(&cur->node);
+		if (cur != &veventq->lost_events_header)
+			kfree(cur);
+	}
+
+	refcount_dec(&viommu->obj.users);
+	list_del(&veventq->node);
+}
+
+void iommufd_veventq_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_veventq *veventq = eventq_to_veventq(
+		container_of(obj, struct iommufd_eventq, obj));
+
+	down_write(&veventq->viommu->veventqs_rwsem);
+	iommufd_veventq_abort(obj);
+	up_write(&veventq->viommu->veventqs_rwsem);
+}
+
+static struct iommufd_vevent *
+iommufd_veventq_deliver_fetch(struct iommufd_veventq *veventq)
+{
+	struct iommufd_eventq *eventq = &veventq->common;
+	struct list_head *list = &eventq->deliver;
+	struct iommufd_vevent *vevent = NULL;
+
+	spin_lock(&eventq->lock);
+	if (!list_empty(list)) {
+		struct iommufd_vevent *next;
+
+		next = list_first_entry(list, struct iommufd_vevent, node);
+		/* Make a copy of the lost_events_header for copy_to_user */
+		if (next == &veventq->lost_events_header) {
+			vevent = kzalloc(sizeof(*vevent), GFP_ATOMIC);
+			if (!vevent)
+				goto out_unlock;
+		}
+		list_del(&next->node);
+		if (vevent)
+			memcpy(vevent, next, sizeof(*vevent));
+		else
+			vevent = next;
+	}
+out_unlock:
+	spin_unlock(&eventq->lock);
+	return vevent;
+}
+
+static void iommufd_veventq_deliver_restore(struct iommufd_veventq *veventq,
+					    struct iommufd_vevent *vevent)
+{
+	struct iommufd_eventq *eventq = &veventq->common;
+	struct list_head *list = &eventq->deliver;
+
+	spin_lock(&eventq->lock);
+	if (vevent_for_lost_events_header(vevent)) {
+		/* Remove the copy of the lost_events_header */
+		kfree(vevent);
+		vevent = NULL;
+		/* An empty list needs the lost_events_header back */
+		if (list_empty(list))
+			vevent = &veventq->lost_events_header;
+	}
+	if (vevent)
+		list_add(&vevent->node, list);
+	spin_unlock(&eventq->lock);
+}
+
+static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
+					 size_t count, loff_t *ppos)
+{
+	struct iommufd_eventq *eventq = filep->private_data;
+	struct iommufd_veventq *veventq = eventq_to_veventq(eventq);
+	struct iommufd_vevent_header *hdr;
+	struct iommufd_vevent *cur;
+	size_t done = 0;
+	int rc = 0;
+
+	if (*ppos)
+		return -ESPIPE;
+
+	while ((cur = iommufd_veventq_deliver_fetch(veventq))) {
+		/* Validate the remaining bytes against the header size */
+		if (done >= count || sizeof(*hdr) > count - done) {
+			iommufd_veventq_deliver_restore(veventq, cur);
+			break;
+		}
+		hdr = &cur->header;
+
+		/* If being a normal vEVENT, validate against the full size */
+		if (!vevent_for_lost_events_header(cur) &&
+		    sizeof(hdr) + cur->data_len > count - done) {
+			iommufd_veventq_deliver_restore(veventq, cur);
+			break;
+		}
+
+		if (copy_to_user(buf + done, hdr, sizeof(*hdr))) {
+			iommufd_veventq_deliver_restore(veventq, cur);
+			rc = -EFAULT;
+			break;
+		}
+		done += sizeof(*hdr);
+
+		if (cur->data_len &&
+		    copy_to_user(buf + done, cur->event_data, cur->data_len)) {
+			iommufd_veventq_deliver_restore(veventq, cur);
+			rc = -EFAULT;
+			break;
+		}
+		spin_lock(&eventq->lock);
+		veventq->num_events--;
+		spin_unlock(&eventq->lock);
+		done += cur->data_len;
+		kfree(cur);
+	}
+
+	return done == 0 ? rc : done;
+}
+
 /* Common Event Queue Functions */
 
 static __poll_t iommufd_eventq_fops_poll(struct file *filep,
 					 struct poll_table_struct *wait)
 {
 	struct iommufd_eventq *eventq = filep->private_data;
-	__poll_t pollflags = EPOLLOUT;
+	__poll_t pollflags = 0;
+
+	if (eventq->obj.type == IOMMUFD_OBJ_FAULT)
+		pollflags |= EPOLLOUT;
 
 	poll_wait(filep, &eventq->wait_queue, wait);
 	spin_lock(&eventq->lock);
@@ -388,3 +523,75 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 
 	return 0;
 }
+
+static const struct file_operations iommufd_veventq_fops =
+	INIT_EVENTQ_FOPS(iommufd_veventq_fops_read, NULL);
+
+int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_veventq_alloc *cmd = ucmd->cmd;
+	struct iommufd_veventq *veventq;
+	struct iommufd_viommu *viommu;
+	int fdno;
+	int rc;
+
+	if (cmd->flags || cmd->__reserved ||
+	    cmd->type == IOMMU_VEVENTQ_TYPE_DEFAULT)
+		return -EOPNOTSUPP;
+	if (!cmd->veventq_depth)
+		return -EINVAL;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	down_write(&viommu->veventqs_rwsem);
+
+	if (iommufd_viommu_find_veventq(viommu, cmd->type)) {
+		rc = -EEXIST;
+		goto out_unlock_veventqs;
+	}
+
+	veventq = __iommufd_object_alloc(ucmd->ictx, veventq,
+					 IOMMUFD_OBJ_VEVENTQ, common.obj);
+	if (IS_ERR(veventq)) {
+		rc = PTR_ERR(veventq);
+		goto out_unlock_veventqs;
+	}
+
+	veventq->type = cmd->type;
+	veventq->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+	veventq->depth = cmd->veventq_depth;
+	list_add_tail(&veventq->node, &viommu->veventqs);
+	veventq->lost_events_header.header.flags =
+		IOMMU_VEVENTQ_FLAG_LOST_EVENTS;
+
+	fdno = iommufd_eventq_init(&veventq->common, "[iommufd-viommu-event]",
+				   ucmd->ictx, &iommufd_veventq_fops);
+	if (fdno < 0) {
+		rc = fdno;
+		goto out_abort;
+	}
+
+	cmd->out_veventq_id = veventq->common.obj.id;
+	cmd->out_veventq_fd = fdno;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_put_fdno;
+
+	iommufd_object_finalize(ucmd->ictx, &veventq->common.obj);
+	fd_install(fdno, veventq->common.filep);
+	goto out_unlock_veventqs;
+
+out_put_fdno:
+	put_unused_fd(fdno);
+	fput(veventq->common.filep);
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &veventq->common.obj);
+out_unlock_veventqs:
+	up_write(&viommu->veventqs_rwsem);
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index b6fa9fd11bc1..3df468f64e7d 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -317,6 +317,7 @@ union ucmd_buffer {
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
 	struct iommu_vdevice_alloc vdev;
+	struct iommu_veventq_alloc veventq;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
 #ifdef CONFIG_IOMMUFD_TEST
@@ -372,6 +373,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option, val64),
 	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
 		 struct iommu_vdevice_alloc, virt_id),
+	IOCTL_OP(IOMMU_VEVENTQ_ALLOC, iommufd_veventq_alloc,
+		 struct iommu_veventq_alloc, out_veventq_fd),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
@@ -514,6 +517,10 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_VDEVICE] = {
 		.destroy = iommufd_vdevice_destroy,
 	},
+	[IOMMUFD_OBJ_VEVENTQ] = {
+		.destroy = iommufd_veventq_destroy,
+		.abort = iommufd_veventq_abort,
+	},
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,
 	},
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 69b88e8c7c26..01df2b985f02 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -59,6 +59,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
 	refcount_inc(&viommu->hwpt->common.obj.users);
+	INIT_LIST_HEAD(&viommu->veventqs);
+	init_rwsem(&viommu->veventqs_rwsem);
 	/*
 	 * It is the most likely case that a physical IOMMU is unpluggable. A
 	 * pluggable IOMMU instance (if exists) is responsible for refcounting
-- 
2.43.0


