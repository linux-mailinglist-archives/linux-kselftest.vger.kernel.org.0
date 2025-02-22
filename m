Return-Path: <linux-kselftest+bounces-27268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBC1A409B0
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 16:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109DC189E7D4
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 15:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CE720125F;
	Sat, 22 Feb 2025 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JpylDs+n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008A2010E8;
	Sat, 22 Feb 2025 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239684; cv=fail; b=eWgr/eOvyaFuAI+fjpaYVhy8wwkyt4BwJPpbVehYjBUQFRlWztnE+Jiqvfp4VBOOBc8FUdv04svBSC+p21lAOi0uY6HAgtHX9gMw9dMILZ6OaKfBr+AYhJpiNlQMD65/5UGUx2WN6b9j8elQhW4kbiuT4xVtUlsBWzrkG0IzMQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239684; c=relaxed/simple;
	bh=jwmbXWsKHQeOJR3HOFPWBzPFUrQyMWI4MhPF2noMiLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihq6v+1QDVKhs1b5KIv8UatVGtBwt/At2smIRVLzdrbRj5wAD/43fOUcqkhPLzsPyukP1cQIGSWJCQGOMoLP48sHjfmS2C2fa02hYaxtQ+SrEjg4m4BtFIbd12fqKbSNzzfcgQpQvhjA1Kr6ZKDZpcQmw6D79tdZy6FTyrxhbog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JpylDs+n; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMbLL5sHMmYCgn0Alj75ZKDyV/ZFApryfVSbuKURZOp2KLX2JtaSmc3YidhDSI+znRDsV9VGD4fj3ruafisw5dmu5ppDFSd/W9mgX0nvctLlOhwfV9IdyQGIapk6zQl0IEVkwvv/rAGO3OltLz3dxu4Bgy0XwiM8qMMxA3vcmrjs2ifOMT/zUQDaRnUJL0T6mqOUcN12qhF0GUHFUr5TOZJfzkb8JyVyo7PWNTIUlceU/I4HAEx/szd96gUnCj1oklYuGZSfQnulC9eAXIZe0dtUA8IiHXXAB6CMeENY4YFPsCGkBPierD5vreuVPzA7NZCiBK4LHrLfFbdBRkCnJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udh1PVsxB2jdZQ8I8XJZCTTBX3qW8VMd7f89xgxZ7Xo=;
 b=MkMYX+QnS/LrOJHM55bb1of6Pmktbe5BuTw2s8N5ZA8MMghhfh8LvYjKaO3UO+abKFj5TJAHXUyqwA+HzF7gddz2XRzTJ0uXpz0Tw20oEBpHzagqS4R+s54kedhay+1o8Sf2EoaGp2QADUbiK7ASfj/EsR+SFlzIRJCW0fxObMBeLqIx3rbg1fcnd9PqV9bLbdkL6aMT+jljM63z1pWEVB27i7s1ezvgrm6IqDDe1sVIzDlFJalmt6Ek4YT3rD0OyY9JKIVpJDyHlxldj0919XzcbLhwm9QLBdd2QJ9ZLRwwEaNaBvRpw2RMo+LauXfWsNTsLnggneYuJJk6Wdqk7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udh1PVsxB2jdZQ8I8XJZCTTBX3qW8VMd7f89xgxZ7Xo=;
 b=JpylDs+n2U+S1xYM9vXXhMYHJ0hPLaU8oGW1AU9osRKiAaspT79FdsHj8kOz9aM3Wc1A/QFpUdNPHS/Ukj9Mp2rhcGjfRbw7smlZMET1S7emCgBoNAPdSdBCzfY6+YaXFxXU9t63a0aaQp2jCL2vnfGzSUljh+XfiLqpuCn4CDD+TC1vRUEi9ywCAMr4Zg+MYJKx3qnz2dt/vY5NwoIMYKLjSWB/o5Dy+WwFhmAdD/FRHXC0LKe7XRZ7cs+bbIa4WhoorUfmjivswmrr4/v1S0bXWgdEyPaTPUoUmpSM165QzEmQRbHYW+eg7kRPmgW4QHVkSqx4bavb3KsQs+8nDQ==
Received: from PH7PR17CA0014.namprd17.prod.outlook.com (2603:10b6:510:324::29)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 15:54:34 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::de) by PH7PR17CA0014.outlook.office365.com
 (2603:10b6:510:324::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Sat,
 22 Feb 2025 15:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 15:54:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 07:54:18 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Feb
 2025 07:54:17 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 22 Feb 2025 07:54:16 -0800
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
Subject: [PATCH v7 02/14] iommufd/fault: Add an iommufd_fault_init() helper
Date: Sat, 22 Feb 2025 07:53:59 -0800
Message-ID: <5907d5a780b83b033b99c4e3b2fda1f5b9f1830c.1740238876.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c99cde-34c4-4754-e0b8-08dd53593395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aXhoL6uRk5QCGrsuW8OR1T9hpnkAE/VPgkbU/J94zKMELhsVDcfBpQo6pvIf?=
 =?us-ascii?Q?BjBcUboufSF640puf2t8CFz71KZzxhfuPw2l8bZDV+SNzp21j2hJ7CBd+YtR?=
 =?us-ascii?Q?FkUY2OK7Q3Duj09UMzr2/PfLetVlTwlWrvh2k0dli/xX9ohu02GdYH4kwi4s?=
 =?us-ascii?Q?HcKtCsM3cRIzjcZ5z0zqQK+VLfj1FQbxZyBOrgcqrruJyx5L4W55N9mRrFT3?=
 =?us-ascii?Q?SHYzKpnn5QRJL3SYtggQPmQ9TQwOSr6eZ0zT9qx9crFMy4azPKeiP5b+rpjg?=
 =?us-ascii?Q?UzEnh9ns185svcSKkRwt8pdyKLYuALEY94S/nYDLXHoC4BKlX0Sa05KNKO3h?=
 =?us-ascii?Q?+mJ2pfsBQOAr1qUtonyfjZ/8xjr4q2NtFI7DPyrRJ9ay4/tnIMz3tXoF0Kbi?=
 =?us-ascii?Q?Q5fDCdZfTtcEMTUhUZXosRdDsc8XSDGQ3ULvVx5y43d/umKxV7f3jogBnZ7j?=
 =?us-ascii?Q?JQWXuILUfmQyGfn2Xf8RrK147FqIT2Jr7fHxmeMalwTuaCNQ3nbvfEOknZYs?=
 =?us-ascii?Q?sNMntksdBgKYrkQNaAuNi/Z16pV+N92JEoD+PnhqqY6QQQJQOqQW8KXklAGt?=
 =?us-ascii?Q?UMjYQ74fEJjgS2z8FsEzTgc0qJsaVpOzxVRgEgXCw4rznesQ3u/Im5EUzpq9?=
 =?us-ascii?Q?wVbaueX4rb8lrwNwRKD2FkDnIOIERH6N/Pu46oMWZ8tRge6Q5rBFt1A2WteM?=
 =?us-ascii?Q?CQMWyZMUjdoKDCm8tZk+YsFkvTabXfX0e0hCUnL+mX7ixur3watdFyY7k+hY?=
 =?us-ascii?Q?PvhJM7DpBP35K8+pMUuQ3Ea85Ec4L0WolyQKJfGBSvRA5EErLkiR3zbmSyg4?=
 =?us-ascii?Q?rgyB2yKegU8WOJTuWTa0BXUajsxu9xWmbo9xqjztQpA5jvjxW56GW5/rbJCg?=
 =?us-ascii?Q?DqWMeIiwk2Wfr/jYCWtDL373C0NwQPIW1MPIKbGUKjSn2KjPMOOOABfx3dwO?=
 =?us-ascii?Q?uwz0CmbORNW78Zvb3YOK/Sealu3kJJcxY4qkBDqPM/wUnDt8hqxFyyiarDBz?=
 =?us-ascii?Q?V+M68yvQlNgdLhzah3iy8VtNJXm2QJYk7o5FG8v33aRuVi1UpITZhj3r72Jh?=
 =?us-ascii?Q?9WzPqmKQG0497ZJy6+jK/tRa78eojC1XPFEEZzZGjC/JMOturU/tyzn+QMVf?=
 =?us-ascii?Q?VU7tvwid6KbavQolC2c/l0bQhfzYsgRfMDAZCKi0JyFYTVDRgy9Ni167O0i3?=
 =?us-ascii?Q?NX5nyVmuPAkwBzZdon4DS4QbgHvPt9/bdWqrFjE9I88t3JYZmOqbv/NudCiV?=
 =?us-ascii?Q?5frblD1cMHJgUfwEpNe8oFlpaHlN/etOKMThGfmz/bI5F3FbVxR94yWW2/V+?=
 =?us-ascii?Q?o6FIQ3QGCVncZ8kI9EVxVsXbj0SDH7R70L44M9x9QdvAcxckgGFiB37S2AQ0?=
 =?us-ascii?Q?6t5KPyk1wTPyMutJCsSTP58wgTfjkgikA3xG8AWojCLuIL5QDcV+5OMdo9Hm?=
 =?us-ascii?Q?N0psbma7Tdx+Yly6/gqTPmghMo20Km/mNRCtmi5TI3y6dxE9BR3IpxnONN5K?=
 =?us-ascii?Q?6ebUfPtOZh7k59M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 15:54:33.7727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c99cde-34c4-4754-e0b8-08dd53593395
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866

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


