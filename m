Return-Path: <linux-kselftest+bounces-23887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452E7A00E7D
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 20:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088E13A434C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CBC1B87FC;
	Fri,  3 Jan 2025 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ts/nmwc0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE61B415A;
	Fri,  3 Jan 2025 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735933475; cv=fail; b=bfGfBiMD0TCNC25AR0cZWS4emaOBmjaIqaNSV3VZSY0u3Mk6pO9xJV6+ubRCqMSYcOicz83UjZYH5zqSC7Vh4bmTtj5Gw0z8qZmtPy64MUqE//3y2Y+Hh/MIPWPWiyuR21p5j/mQ4Y0aVyweK6yf39VfO32cc9QsgR61274y580=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735933475; c=relaxed/simple;
	bh=ueqoEOm5RiST0zIp+i6rxDOGe0jaAm8A5azqK5c9SnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eq97wjIPIOviuN2TvbBVMySmyT8aqy6HyKg0HIKbkqZXKisCSYJ8ZbDxoiRCEv7myLLtqGPX2+oJs+eJ7PuedXDX2fitxlJqTK8kdSeRF6LdB9slITfaK01H7EQ2yPlSSgSyVtEDUxibRazvv0o6i83YEh0M5WlSTkO9hmvjvHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ts/nmwc0; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezUkuroa2j01/QiF2j+m+39wMS7loOovUyysuMtkS4bHUGdRCFXRA6mdfP/EVkuKfT/53TNNxcRpuR0mSdet1ou5wq/nS8E1gAzP7QojCkpkHAswi/FTR3PS0ITyWY9nr6pt6wk0Bw8RRLkZKhdM7VSIIUatkfEikoIIW9GMc95kGW/YXMfkurFCJwGxnv150LY4jJyDNFNUkM/yhJbDtp5SygviSk6ICrtScDgTgIc7pUX3BS+dDk6VBXZ/A8Xd+Psz3hitILbZmyBOqRs6rjF7eO0vPqGmtyRhfHC3UfL0HTGcTjRJRGv7t+p2rCn/iNqKIM4AYbhO8xXM/sBFJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+LZ9DTi+hXK1XNyDsq/ydPO+gFKzeDHi5j6GDyNjCw=;
 b=YM8sbYtquyiKOL2nf5ytzcBImNdtdWwtQNFkRKTDL6JmkNBbgF/VPZS2B/8j3MRCl1GTG1ilgvL+wW2uYPiKU49hBbp4bDuA62iGrMhjk0EB4Za0qVlN/M6OGDYx6lFPZ6SPvQQ49AuSsDEuQkrIZELbNkKtAztz3aQsvW2xrzI0pjcc57mjosB5LdRsqEOZZCRDztE6q/Qy+BM20dkcF6NRh9/pGQs1sQl39LsgvhhyGB4QTChMJW39Xk4sECowELJ+QKL5u3ANf6iLtejzYX5TG2I6qj18fgEYjxv41ZtOb7mI/6qbvIlmFOV0UkGHkDxXg/LO5HtmMINdZDis8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+LZ9DTi+hXK1XNyDsq/ydPO+gFKzeDHi5j6GDyNjCw=;
 b=Ts/nmwc0k+pM0leG+Z8FHsaGEjaT7cEInT+xHxpKDAhlYnEZN5lbH6TSzNfx6bYwtfycioDaeSaFIcmJhl2YSRFgQM1E2FeDaw2bdo6daWnkDOQfL8LFGeRZeUM7nOUDn13Vn/51bu1ZL3MF3oxqwe0VqhDNwDEORZC3LQdDeM8/L1CmlSwGGubPh23RXydgIzoHbBB1IMhPb91F+1Y3I55WoyS5xW7I9z48b93UDFS5Hw1pmpaNj2zVJlgPTpK3m/HNQf/QGRCIYRF+Yoq2f2hTa0YR1jPIwkErIFfaEX8kPoeyy3y7xdnouZlbGR9G5DvzW0XxUzVvlG5fLCp3yQ==
Received: from BLAPR03CA0092.namprd03.prod.outlook.com (2603:10b6:208:32a::7)
 by IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 19:44:24 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:32a:cafe::13) by BLAPR03CA0092.outlook.office365.com
 (2603:10b6:208:32a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 19:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.0 via Frontend Transport; Fri, 3 Jan 2025 19:44:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:07 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:06 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 Jan 2025 11:44:04 -0800
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
Subject: [PATCH v4 03/14] iommufd/fault: Move iommufd_fault_iopf_handler() to header
Date: Fri, 3 Jan 2025 11:43:26 -0800
Message-ID: <92a5599bddd915c049fabf4832ec8b0f0c1471c6.1735933254.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1735933254.git.nicolinc@nvidia.com>
References: <cover.1735933254.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: bef94e04-ee1d-4c43-9cab-08dd2c2f06c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cvZzrQsHTEAY6R/+m0Jf/OHC9iHMHXbCQyGn+4YOL1CFnjblCT5TpX25b/lU?=
 =?us-ascii?Q?x0/4hKjOOA06XfZuRVL4v0E8qrTsx8Ov6NTASPDKqoQhnOaYquxI/6xWKAnd?=
 =?us-ascii?Q?inqf/kEcif0jjC9SuTFm6frVva/IqJ3fzau4rlUpyhSNXwUJItFv+YhEgT5B?=
 =?us-ascii?Q?lH1jEQWm1eV3oYdQRQX8WsUMaHSBnxSHWYpp85BFuVRmJ+acXnsxMTFUoTXf?=
 =?us-ascii?Q?qWYFGJwvRJHOs2OxWftrW8k/UpAvpY+NRcoQPdzw0Fjl6wJs9YPTakfcpx8A?=
 =?us-ascii?Q?1tJilF4xWb2m5sesHXKXYrXuAOA6DGueanulV/5NnuCLRZ+UvtKt4XTzpaLk?=
 =?us-ascii?Q?bKh/5jRo5163eC4EK6n/G8vt6BE4GJjOwzJMhVTBi6qrp2HgVXzVOR+wLgyZ?=
 =?us-ascii?Q?HRnbck0cMkP+kM/kx+SnjyW2YOPTPP69LgliBMJ4PcJM3lPzK1VCumor9I5x?=
 =?us-ascii?Q?gDM1Yb7kBAplhm4tdUbhtNHQVsgtm8lWCV44xNmrEmS7a9FmK8+Wi8FhmOOh?=
 =?us-ascii?Q?bRfdxbZ/iZGu0uYpLpNXqJYcGH2WADefQfK0gh9isRuZoRtd0UyxXaqQ/S7b?=
 =?us-ascii?Q?H6CUIc7C+spVnN2BIQzEX35kiFyIxvJTR/VdBvcJ3g3nVZsrVSlntMam54JW?=
 =?us-ascii?Q?nf0MlvNFRB6Vam1kQfsNTodEKi4Gk6PKPAFsG5pBjXl9y7+z2iAwGpBwCVMi?=
 =?us-ascii?Q?XAz5hAc+82sBGx0jzaIAERgPmU8Wh+51RGcLZo/NtzjOE5Y1JiV/wQg8FQ4t?=
 =?us-ascii?Q?f0F9uzTQd52gXkYKbKwWs+BHS2cyXOGdCcHuirKC6fePXEDNTRmYRrvMGTxT?=
 =?us-ascii?Q?SGJuWJzGs4lT7Iis8Q2aF2XDkPqWO3y0HC38wzHu/GLIOQqLiFyFtT4d4Vk0?=
 =?us-ascii?Q?O/k5LLCqmLxQ10uslZTgxqbmmzos0Vn5h+ktGc7tXRhbMuJr4HwTNj4o//gJ?=
 =?us-ascii?Q?pJ1HPX4fcbg1PBAmNVFIAQbjkVThl63uJThr9BC1vrn0WCawfuI7Bzl9hMiU?=
 =?us-ascii?Q?ujARiI9BS9rowmci5hsczCB6jiYChKgc8tb+3bKW42udl4NTL3au3AdC8YKc?=
 =?us-ascii?Q?VZfX6aue9SKT76pd/4u2/WNE5hUTm0ClJQiFPiAK9hd94tiNQvui5c/Ve/Gl?=
 =?us-ascii?Q?pdg16L80wz41cQRlM/BSPuJVN2YkxHkkEQWoYCm3JZPRpdl+gK1r7GIXGYgO?=
 =?us-ascii?Q?rMj/17EVkfaWzyNLfx4kAGAa5ATJEi8I4otu1ofvvgIjMORd41jlNZOWu81T?=
 =?us-ascii?Q?xZw/89c+E+SvUhMj80Ymeudl7j5QpTqWWsnA8qCf3r6qrHOWQ1TVkcKSwPvc?=
 =?us-ascii?Q?K7oZCnJ998LSt0v/djWNboYgzgzhqeWe/intiEkkXYMV4JUMXm0AjUMV3bx5?=
 =?us-ascii?Q?gLTAkxvF//zE8LF/XlMf7xN/EdhmIdqEHOcJT4t7nSIE83q/xwaGJm1YWn1W?=
 =?us-ascii?Q?osNj4KXjH/WdBSl4H2AhAG7H+9NychKTXprd/5ccivgxP0KaGWf3bnpvdB/R?=
 =?us-ascii?Q?goFpyF01i3WeFYE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 19:44:24.3146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bef94e04-ee1d-4c43-9cab-08dd2c2f06c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839

The new vEVENTQ object will need a similar function for drivers to report
the vIOMMU related events. Split the common part out to a smaller helper,
and place it in the header so that CONFIG_IOMMUFD_DRIVER_CORE can include
that in the driver.c file for drivers to use.

Then keep iommufd_fault_iopf_handler() in the header too, since it's quite
simple after all.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 20 +++++++++++++++++++-
 drivers/iommu/iommufd/fault.c           | 17 -----------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index b6d706cf2c66..8b378705ee71 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -451,6 +451,17 @@ struct iommufd_fault {
 	struct wait_queue_head wait_queue;
 };
 
+static inline int iommufd_fault_notify(struct iommufd_fault *fault,
+				       struct list_head *new_fault)
+{
+	mutex_lock(&fault->mutex);
+	list_add_tail(new_fault, &fault->deliver);
+	mutex_unlock(&fault->mutex);
+
+	wake_up_interruptible(&fault->wait_queue);
+	return 0;
+}
+
 struct iommufd_attach_handle {
 	struct iommu_attach_handle handle;
 	struct iommufd_device *idev;
@@ -469,7 +480,14 @@ iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
 
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
 void iommufd_fault_destroy(struct iommufd_object *obj);
-int iommufd_fault_iopf_handler(struct iopf_group *group);
+
+static inline int iommufd_fault_iopf_handler(struct iopf_group *group)
+{
+	struct iommufd_hw_pagetable *hwpt =
+		group->attach_handle->domain->fault_data;
+
+	return iommufd_fault_notify(hwpt->fault, &group->node);
+}
 
 int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 				    struct iommufd_device *idev);
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 1d1095fc8224..d188994e4e84 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -433,20 +433,3 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 
 	return rc;
 }
-
-int iommufd_fault_iopf_handler(struct iopf_group *group)
-{
-	struct iommufd_hw_pagetable *hwpt;
-	struct iommufd_fault *fault;
-
-	hwpt = group->attach_handle->domain->fault_data;
-	fault = hwpt->fault;
-
-	mutex_lock(&fault->mutex);
-	list_add_tail(&group->node, &fault->deliver);
-	mutex_unlock(&fault->mutex);
-
-	wake_up_interruptible(&fault->wait_queue);
-
-	return 0;
-}
-- 
2.43.0


