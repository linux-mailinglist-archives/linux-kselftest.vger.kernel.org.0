Return-Path: <linux-kselftest+bounces-27499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FD6A4483A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19DE16AFAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D52319DF77;
	Tue, 25 Feb 2025 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HvbmxwOr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E719C546;
	Tue, 25 Feb 2025 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504380; cv=fail; b=YNHv8O/oNnMCL028Dx4sDER+JLCOg8aDFM1WVt7eo4hJAfTKh7GHNNBUdRMZC0ZF92QloZx/oNuLv8Ta1mSBUSiyUDTSQ+2alD3Vq6QNS78qI59td5D2ZY4KCvjAPDbN44efcuk8F052nuveOOx1XZ7vPFIL/8qM3nRWpe53les=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504380; c=relaxed/simple;
	bh=jwmbXWsKHQeOJR3HOFPWBzPFUrQyMWI4MhPF2noMiLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blywltp5xDuI2vt//wCD7aMjFMAHoGiMWd97jrONWpKbDHUksUJfWNq8aZtux2AzdLeHcBmpieLD7h/Gsbixx7XN6uyTlA/TxDc8J8D2yRwI5tFH9UIsuiVfd2Pnw0P+g/VrJ7pd71RV4sIGJcaABR7KQudw5krlRRy3cIKO+FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HvbmxwOr; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8WbMckLENCyH+JAL4r90CHrcIyy64AuXNLvRuQiDVrIKOS1Cl3dIWd73IEXO6Nz85aTl/hJ6PGDJNzNMe8mlI24bLm2epPqVDfLmlUIdThGk7/cLxBtFTxQIdYomAwrfDQW+Y7KeOhDdWTqh+AgPBx1xpk6FxlnmU4yBXrNQhIBCH5m9wRnFXNbELoCu9RG7KhSxQUfx5ml6KcfrMP28T/cz6MiofoY+Qek0ij2uRv/K4YM913GKUZ3zyU4s299QyHGxtfiO1G+1QoHoIZAk3MBR6HpVItB/qdk6ZctRPR9x4mmFu6zVh7/BFujbwSyqXw7+rVdiVCa12ZUZ7MkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udh1PVsxB2jdZQ8I8XJZCTTBX3qW8VMd7f89xgxZ7Xo=;
 b=cBIQlzK6WoucMnHqTucQWAUfvqtmFHOb81j3jAx3WYTrTXG9uQKDaqFebi0fE7fT80o96aPXPfTxQr1NFBj2F24BXAZS1tgjvcI9oFgslbIji5mfaI91mY+v67XJoFORkJR1iVPZzez/TIH21wGrBLfs36Iy1quoDl2XUdRmEKdmD0GYX6WFFHNrVDAWshgMfGkPAfp20iy+q8ySpcaPy1DRrw8wG12bwZsxoNDtouPUrrAj5W29oIfWtmQIgGiGY6zpjGoR0zWypFg7mh+wo65eFoh8zg3VYehOqENhuQad/cndTcXAWShg+8tb8GkTfOANu1KrU5SV3O5TE0ojNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udh1PVsxB2jdZQ8I8XJZCTTBX3qW8VMd7f89xgxZ7Xo=;
 b=HvbmxwOrC5QCWZUpzDow7SDtqXSm4f8o9X2SezxDqAe7Zyi1gi9fHBpG0j/m3tY06Ylz1Rc41xWIY0zvKteRfmK22Xo7ptqs43B1pOqHhnNVMfU8VKbucCgsDyY3Qrexzqqq9mGCePt0+smqSdZktNq2HvfbnyepnPeTAxWNhyYID87VuLwX+EUFc2YmsOCBmkQHF2kXDDH+usKVzTNF4nwRUA3IDtLVWGyM6OWzzT/d/E56eAY0c9KzxtLFf8W488pzxNhyZgnhUAPLMw1IXCCAqJiY+H1ASi2y/OJtimzTfKJCuVOf/+8YB0JJRICEPt9GPaf9LlMO0GGIJhU3/w==
Received: from DM6PR07CA0101.namprd07.prod.outlook.com (2603:10b6:5:337::34)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 17:26:11 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::3) by DM6PR07CA0101.outlook.office365.com
 (2603:10b6:5:337::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Tue,
 25 Feb 2025 17:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 17:26:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 09:25:57 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 09:25:56 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Feb 2025 09:25:55 -0800
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
Subject: [PATCH v8 02/14] iommufd/fault: Add an iommufd_fault_init() helper
Date: Tue, 25 Feb 2025 09:25:30 -0800
Message-ID: <d50b3fccb584bf249fb50ec578cc0ff8d28c9d32.1740504232.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a285a3-e0c0-4c9a-18ce-08dd55c17f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DBu1m0JBDVbkSDRRQ1l7EvFjxfRscBI05ywn2iLtLWXD7ckjr0pvEAHLXW6V?=
 =?us-ascii?Q?J8yNG0zEdLERfwOgYAYfeY67YrH0KHska8HHOv6HxB0Y3VmIJS0mixO9TVw4?=
 =?us-ascii?Q?/9pSJpSwe6aSv2wVo+DbVzDJ1ucYyRX0Jmi7B2ct/B/8PWYzTeyCrY6wb9uS?=
 =?us-ascii?Q?VscnaOWhFtA/aqggX85hh/IrpEVJxuWAefM53azOvQTrcs445rambEvLwBh0?=
 =?us-ascii?Q?BBbV/MGb1wRNsJXyhWwlP3dduXLwCLOSbOP41lpN55dUfZ5b2nhaqbwgjS7P?=
 =?us-ascii?Q?Loa0BpX5t/aJGEae559gaQ7LQ4P1GTD1Bq2A4NuM66ghfKFjcE7y+gAZMV/X?=
 =?us-ascii?Q?IOl19hw27QRueVnSADj6S0OafnssHha3wWuR8Sqm+hNeevsXqMbx1xra14C6?=
 =?us-ascii?Q?GoMcZM+njls/sx+62Uh6TAn5i2zmtcBECs9IGLZCzcUeBqVf/jwoUqnwx8tc?=
 =?us-ascii?Q?ajHRK+CTZWmyxgYi9q9IykuFDVKGZ+W0rbmIzsk/IDwSPrmW8DwukmZwaqcD?=
 =?us-ascii?Q?DI13RGX9I8iQVCmnEIObwsu11tUJXp7ujtX9y8fx3QORrFjg1HZrtUps3b/T?=
 =?us-ascii?Q?Jjc0FSpPuLWMIbDAGkVJaaXCtKYexiIxgLXEn8SeosFFMQ8MrFWqNIY2gCuO?=
 =?us-ascii?Q?4CLZEFc5zlsp3lZ4xeUQ5pBixR3HJZLhuBZBI/bhHXNEFxaI6w4PJgOfMlsq?=
 =?us-ascii?Q?DK3fHfqTnueA0RT8x4VcTDHEw9tcvv5/jTFYlFiuEEtXG4SBG4RUrDVi0ZRt?=
 =?us-ascii?Q?IDH+G57MM7tC+lMrwJbm3l3CDFy5WXlw3yzgcMe+f3rILPsD90vKkRLU/mFW?=
 =?us-ascii?Q?hKKWp5s1WuEL5w9+NnwKaczG9kXy1uphjx89tdS1BI15HfCkyPkoT/1S7Hq8?=
 =?us-ascii?Q?7H+Gq+ATzsSp3m2KCJCZGtatS/DcV/39R1rdZneSyh9VbhcU5Lt1MnGldUlF?=
 =?us-ascii?Q?equInVW/7tqecdh4uOLlWWaGZmfkan13pvArlOmJDcHuNJNyVo70Y9FObZIz?=
 =?us-ascii?Q?7TUAekaMOaZIPp/giHmpUpmjRBG69cduQMfW7utt3m704EUAKMePWVi+fcLz?=
 =?us-ascii?Q?2er1WPq9p90Ue6XTeg3kIgVPlexm7cRpT0L8nHBeZMCcAz0ca6R+BLPj1DzZ?=
 =?us-ascii?Q?vsnLFwR2N9TLv7HRmxwaOzQYJYYJ2PzsQqyCcj/z8YkFJN38mO/Ha+W1uH9K?=
 =?us-ascii?Q?sp2NzGLE7LMDCHMAlxQDB8fYmGGgziFM0MFdhYy3NBPCA1oh/Pi90gM8HvNW?=
 =?us-ascii?Q?BB0gXNdU7lc7u0C6R9oLzNIg7NopgkkvNDmrfyI0iFHnqMc3Sqf1cj9MTZYf?=
 =?us-ascii?Q?l7ygSCMfBgp23d25ub3TO8O6T5YCOQZIL0MAhyDVEwYLRmBIL/FOyomvZvML?=
 =?us-ascii?Q?V5lSi4qiXs0BY4efGa2nAT+c/KK9nMM2/l5W+OV6iKKwXAuY4aEbNdjetMYG?=
 =?us-ascii?Q?x1rVi99J0LXYoBwKwgePDjahJWXvDzOWEoBHrGKaysLVN68aQx3oJZTpZyAR?=
 =?us-ascii?Q?9maJ2HR/Sv4PauI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:26:11.0542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a285a3-e0c0-4c9a-18ce-08dd55c17f78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442

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


