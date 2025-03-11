Return-Path: <linux-kselftest+bounces-28768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487F2A5CFB6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DEE189E7B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C76264A88;
	Tue, 11 Mar 2025 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ojOi+zqG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1891264A66;
	Tue, 11 Mar 2025 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722337; cv=fail; b=gLDE7V5vVjHCLAPD4w1jOYVHhVc2+O3hePCGId4hhqI+R0A5VO163oEDc8yiFBf13h0zYELAFRq7Mb4JRgJCOK4qk9bSDqnIOpahNztPZo2pFAs/5ynWLjra/caFZgvHbu7ONSAPj2vqJGpXpcY0B7Akgi6/dvzrsso9GDsV6OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722337; c=relaxed/simple;
	bh=jwmbXWsKHQeOJR3HOFPWBzPFUrQyMWI4MhPF2noMiLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFAved+jzvla2Moj3+nxW1sIKDze1coj7eF6MBFsjO6jYGmS8DAh3kK3ghTiKC3/pR0GJWMiXWKCddDeRKfxx47dQNfscYrIHeUAdqk8QIwn3iUoPAqF9sS+8bqPUrwhj9/qPIlOnqN0yUqN4zWVez17W+nv6PHRGrC9D9D4obM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ojOi+zqG; arc=fail smtp.client-ip=40.107.100.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Doj6d+5zOCq31hVnfsQlifonGls6KaUXQD/HEiPFZi2YtqE4K3oMeWRaOBFe3LMJfITOyp+FJYCZ143gSWehMYFZG2bqGGMzpB7ZHwSeiKA58ryMoz289by/hYJYgiNs7CT67q/V5E8qE1NDU+wD+Mr1uMXacVx9Ia3IvZuznEi4Z2M7rGBEjKasz3jrFUSYJu7sL1Ryevy7PHak2LbtXEk74CDrxRTHU/2J/To/Mr4PXN7b6GCtwMiGNHYtfGC3DqFW/+IWV6iH3EoMSuKs803A/4+128A+j0AkJmf7UIVDZ1HG+SKts0hItOxade2lNanXzG0ZNhCb9IaJBZLAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udh1PVsxB2jdZQ8I8XJZCTTBX3qW8VMd7f89xgxZ7Xo=;
 b=OGPZswpnHl3fPdiIBVeeR3o1ATXZMfmVszp9do9mH0Pq4wHOHHUdIj9C5v2cArEmPusgGvhMzpca4ek8fBlSorADp8TVrbQJ+z0ElbcDzU2peYKRsUtR5Be6QetycEujLGwZutb1tnWwZaHIf/lV3ZXvVCWjKYh6f8X4btcWPVFz/OfnR7jpri8NLZWfXXAsS3DdOxgImgJnL+Elh0u9ihAU8gPmSrAQYiSDCx/obMH1ndrfvEd7obZY2EkZiejU8WfjkoFQr0AoebF2xFtXMsaa0xTKx6KAZoUDSkWq5u7AZgP7eQ493NCEKfiMgLFkwp6dtaXYbzS116L7BLlB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udh1PVsxB2jdZQ8I8XJZCTTBX3qW8VMd7f89xgxZ7Xo=;
 b=ojOi+zqG9JPpfesZ7NqBLYWFTjounkT/PDGUBc39UJXSru6pweULlNjV7XgpubCG2+PghF5DInC2AVDtqiWfYnZfIW7CN8/S7JfpCkyo4TTC16YZl3+5gckKvgJyYlPwWyo7cT8B1YYUuOGxku1cBfs13Xy3rMmaE8h71pHQa+t12SxPCPEodeSpwTh0XebkIB8lE2sJaoGRXfKUTqKjc9RXtquyBl+ZPbuuiX5Wgu5BJ3bql/HhcgkfRe0Fnw/FpEq5EWv7Let+bxP31uIx7Ja2btWsxs+GgvksP847RT+/PUqMoSxLgYP8XYbi0MfrMbSOsaIAK6Bcl77WGIBMpA==
Received: from SJ0PR05CA0176.namprd05.prod.outlook.com (2603:10b6:a03:339::31)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 19:45:26 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::38) by SJ0PR05CA0176.outlook.office365.com
 (2603:10b6:a03:339::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20 via Frontend Transport; Tue,
 11 Mar 2025 19:45:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 19:45:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 12:45:10 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 12:45:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 12:45:08 -0700
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
Subject: [PATCH v9 02/14] iommufd/fault: Add an iommufd_fault_init() helper
Date: Tue, 11 Mar 2025 12:44:20 -0700
Message-ID: <a9522c521909baeb1bd843950b2490478f3d06e0.1741719725.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: bbae5dc0-c0b1-4fa4-2c9f-08dd60d54551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eZMEsrZ2ss3swJbxSd9G+ia5ad4l8bdZCICRq4HU/IVOy6u0Q4Bfh2RW+COK?=
 =?us-ascii?Q?hFeS0kn3u8XXhsZZd1perBez2qXQGf2QJ87tFZYHfezosL+WHFnsfk/brgeA?=
 =?us-ascii?Q?fFJHh9wi44CKLQ9g5CzjlS4CcKoSoXtp+/aomGF3rTpWiUYZ7RyppLLqzjeB?=
 =?us-ascii?Q?xNQJoBFyURCPP6nzTPVPqvLWczmXbus5WTu+8sTtqfqUpjXTr8/yIxqa65TX?=
 =?us-ascii?Q?7IB5UoQmd4xDdmNAQ0zE7co5S4nkKtmc6ULaMWI6ALSB7v10ChO1kkYLRnKj?=
 =?us-ascii?Q?g/xXeFFe1YhA1coO4fHVRJeLJjNJG6fNVxcYmveoyEP2fQXfFVSgrYT436Xd?=
 =?us-ascii?Q?MaYf+heuTmdsczdXWHUyzXumIEY/VFXSHGQFtn5QLtPIVL6/SA1+apbj2KhH?=
 =?us-ascii?Q?Igt1FKE2bmVmDYqcqxy0DL+ytgM4daqnnTHQ6H/Ia7QxiLR0INBt5E8fxXQd?=
 =?us-ascii?Q?yqjmqkaX+D6U9EP8jz6r+XIGUZXp6DZP/3SMxY/XBkajjdiAzJ0mZS7LrACU?=
 =?us-ascii?Q?auhzfnLb2nbYhcaIzNbapxR73r1bQHbvIr23yZIepVBcWAzRr4TBNROm4y1z?=
 =?us-ascii?Q?tv+O7YyBkGmi4nC82NB5bltj6dycs2o3vSQonlHYEFhw4sUJ3dYxpObto5s5?=
 =?us-ascii?Q?+HL2Sm/7eZ7dZ5Rw9+anqfy/P2GKYRhvMx+okiBnQWDZcTkjWSJf10VQ6xmo?=
 =?us-ascii?Q?yA72UfA5ogIJcdMDQ6l06ntjI4ydLhTFcQJRFZ4pKLIaOD2yfxuDS9byLlV3?=
 =?us-ascii?Q?M0XBhf/An5cF+ABlFbC9ctjKnhZ7Ca7RRRfOINqnYhTGpzE1FWW8ywdnoq+4?=
 =?us-ascii?Q?pSixDbZKUifV0owiaRx9AG4GcUccE81Bt7cwtOTkDRPyFdPQV7dHHSAR1VY8?=
 =?us-ascii?Q?2h2g+1lImiFrIRNfQM4yX6adLd8jVpkZfIJJ91IZ9Y5hCqNjpc61/MCctLEL?=
 =?us-ascii?Q?igBwySoBMKTL4iIp+FGZypcYdQVW83nAgj+5B5V0DVBwtC601ZHruZx1yjiD?=
 =?us-ascii?Q?Mm/q4pzi9LPxM3LVB8h/sFdaDNsRchzjzxmI/2+53RjgE4otypkIWQ0ubpAm?=
 =?us-ascii?Q?84FK2oYQZAg/Q6gEy0MlGKcS+HVEcbpa8SgLS4I7bAVlkjsqk3pOoHELjCFC?=
 =?us-ascii?Q?BPGUKK+L0iTCNZLDz1JE1zH0XAdTxuc91XhK3VbjtrTFXGw5bWpPn3zPptSU?=
 =?us-ascii?Q?w+PCYVoCgqPY98tYlRScr/fNA79oe9WCkgL3krHfFZnN0SjXu+nEk/Op4U48?=
 =?us-ascii?Q?V9GLvL6Rjc2t68zkFlxQZCdQMM3BcKi8fsBnWQqTHhnkZ7QYDVCVt37yq9t7?=
 =?us-ascii?Q?JgRF16TgmTRJhpZM5O6sFsg3JUsRSQ3yRNcbp4i4XkX97OVDh3/6j4vxfeCU?=
 =?us-ascii?Q?nIh94Qtsc8TQYFUE/WnDVIK/Q3tZT9mSc4HfphZAUDaq/V+iAbuRMlPfqxER?=
 =?us-ascii?Q?f90nwHZY2XoHwMOJzWpJigUCFanqjNAFdoaF1NzuFbyqiUWvINgGP37EjsCL?=
 =?us-ascii?Q?ywWzBbQ3qw6hgUs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 19:45:26.3101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbae5dc0-c0b1-4fa4-2c9f-08dd60d54551
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193

The infrastructure of a fault object will be shared with a new vEVENTQ
object in a following change. Add an iommufd_fault_init helper and an
INIT_EVENTQ_FOPS marco for a vEVENTQ allocator to use too.

Reorder the iommufd_ctx_get and refcount_inc, to keep them symmetrical
with the iommufd_fault_fops_release().

Since the new vEVENTQ doesn't need "response" and its "mutex", so keep
the xa_init_flags and mutex_init in their original locations.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/fault.c | 70 +++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 29e3a97c73c6..5d8de98732b6 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -280,20 +280,49 @@ static int iommufd_fault_fops_release(struct inode *inode, struct file *filep)
 	return 0;
 }
 
-static const struct file_operations iommufd_fault_fops = {
-	.owner		= THIS_MODULE,
-	.open		= nonseekable_open,
-	.read		= iommufd_fault_fops_read,
-	.write		= iommufd_fault_fops_write,
-	.poll		= iommufd_fault_fops_poll,
-	.release	= iommufd_fault_fops_release,
-};
+#define INIT_FAULT_FOPS(read_op, write_op)                                     \
+	((const struct file_operations){                                       \
+		.owner = THIS_MODULE,                                          \
+		.open = nonseekable_open,                                      \
+		.read = read_op,                                               \
+		.write = write_op,                                             \
+		.poll = iommufd_fault_fops_poll,                               \
+		.release = iommufd_fault_fops_release,                         \
+	})
+
+static int iommufd_fault_init(struct iommufd_fault *fault, char *name,
+			      struct iommufd_ctx *ictx,
+			      const struct file_operations *fops)
+{
+	struct file *filep;
+	int fdno;
+
+	spin_lock_init(&fault->lock);
+	INIT_LIST_HEAD(&fault->deliver);
+	init_waitqueue_head(&fault->wait_queue);
+
+	filep = anon_inode_getfile(name, fops, fault, O_RDWR);
+	if (IS_ERR(filep))
+		return PTR_ERR(filep);
+
+	fault->ictx = ictx;
+	iommufd_ctx_get(fault->ictx);
+	fault->filep = filep;
+	refcount_inc(&fault->obj.users);
+
+	fdno = get_unused_fd_flags(O_CLOEXEC);
+	if (fdno < 0)
+		fput(filep);
+	return fdno;
+}
+
+static const struct file_operations iommufd_fault_fops =
+	INIT_FAULT_FOPS(iommufd_fault_fops_read, iommufd_fault_fops_write);
 
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_fault_alloc *cmd = ucmd->cmd;
 	struct iommufd_fault *fault;
-	struct file *filep;
 	int fdno;
 	int rc;
 
@@ -304,28 +333,14 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	if (IS_ERR(fault))
 		return PTR_ERR(fault);
 
-	fault->ictx = ucmd->ictx;
-	INIT_LIST_HEAD(&fault->deliver);
 	xa_init_flags(&fault->response, XA_FLAGS_ALLOC1);
 	mutex_init(&fault->mutex);
-	spin_lock_init(&fault->lock);
-	init_waitqueue_head(&fault->wait_queue);
-
-	filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
-				   fault, O_RDWR);
-	if (IS_ERR(filep)) {
-		rc = PTR_ERR(filep);
-		goto out_abort;
-	}
 
-	refcount_inc(&fault->obj.users);
-	iommufd_ctx_get(fault->ictx);
-	fault->filep = filep;
-
-	fdno = get_unused_fd_flags(O_CLOEXEC);
+	fdno = iommufd_fault_init(fault, "[iommufd-pgfault]", ucmd->ictx,
+				  &iommufd_fault_fops);
 	if (fdno < 0) {
 		rc = fdno;
-		goto out_fput;
+		goto out_abort;
 	}
 
 	cmd->out_fault_id = fault->obj.id;
@@ -341,8 +356,7 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	return 0;
 out_put_fdno:
 	put_unused_fd(fdno);
-out_fput:
-	fput(filep);
+	fput(fault->filep);
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->obj);
 
-- 
2.43.0


