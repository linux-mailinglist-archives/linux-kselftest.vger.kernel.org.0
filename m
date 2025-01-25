Return-Path: <linux-kselftest+bounces-25143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5061A1BFBE
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 01:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB483AD44F
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 00:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B55E28DB3;
	Sat, 25 Jan 2025 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E18uoIgu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752F2C139;
	Sat, 25 Jan 2025 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765079; cv=fail; b=CS0AZ32jaBA2WB7Ck8h+8aOdFJQ5Kvvv2teHxRLDzJmxb4Q0kOJxnfZ+ILujT0DP/uGqMFsweqC8/KeC6vWqd+CPmOShTtRgrKZImR8JIpGdoZMa8/eCGu2+C+P6n/F2supAjXA/YnQvnx+nNqmZQehzMb0y+09Y7Qfz1vRS8eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765079; c=relaxed/simple;
	bh=h+amI/aLmOaGSKqljf41NH/f6Wqc3b//TD1uTJNKCgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PS1QSZMAOyfLb1DQ9Ma7FY+M6WmRdN+jsXljjk8GULBOngyUPJde9zcQLCbv4K6r5dK7YEYoI2xnLxuTjQbp9DYygiDwZNup5KNwkJGT4rEYagnJuqzvh4HqAtQUNSX9QVCNsJ7zzwUJ3NcCxxbvDHPhm9o7u2O2fJr8PngoS/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E18uoIgu; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaEVxYOHANua1RteL7iDDMdQalHE5Jzlr6cHi3waAdkk0r9qndHRct8S7OswgmnqTKMrAM47Z8fQQykeUcbY1seAAn7vOxp5S/VrE2wgq5S4dI382swRHkgprg86EZEHfQblv4T4Y+4xxPz5o8xWFvTOMsc5REtkJuBdg2nbJFPnDG1zrlF+VHAhmuTgjxEGWY8P2XsQkbWk16pEtoeMtyTGFPx4ndAFd8h78a5XEaRxCUc3YeBZSX/PJhBBzkX16p5bYNQWd2j5VTpbJBZOdljlqbluuanp6B1OCwjsCz7C8D+bJbt5pmPj6Z0XlBIl7y+YMFjlLfjxu496cLyf6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8X0WdoXakVWyQzjC1eKfKtyttVvqw7lVw7c3B8Pbgig=;
 b=fPxBzs6oTfJj5zyzQhXMTnCR26xSc/2GNf5ELhxYzR2RW7RzjW8+6kAv/piBENySN8YXI2/aLvHW4F7udRI7bi+TgmjzgrxYIe+2li9gcSXqRk9NqzVkqXTfax3TwcVPoQBao/pk3sd0k4wbuIhhPAp5iKbEzn/Rj5NjpsEdhShvLd+A+uq0QHpjt1mq5IA+VvVxUyZp0IfSfSJMMwibxctbGFNhUfHFkR9icdeB5S98q0XgvSyaS2udgnNbBUTPm/iD2GqUwrHXzitv8RG7BDT2TgF+Of924wwEJrchP9sSQuWBkgmjadNOSBKxsXD2q7Nhj06c5xudA4J2UgIS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X0WdoXakVWyQzjC1eKfKtyttVvqw7lVw7c3B8Pbgig=;
 b=E18uoIguujIuSitTx+No2kq55hzsYMU/yF6h8PntG90eByoBy1iWr/bY2nSfe7D60fEM8dX4IQJ0OaDqwwMeXEpo+RuqMcEsAhlr+nkjdRcCynBNVRymcUUPJuwwwncDV23oAO80tKykCl+PugQsaDFIa/m4Oh+cBFoA1/PsAl2pZpAHGhns4a1tLkG+yCZd3WsUF5ZhChjMUXpqq+jpECN/76iQmmZ1ppMgI2PGJnToZdnWH72Y7LyZAiG1260p+FNOizmQLTIJBmoQltAgw9xDC7HWA3k+mtWTBsggXJV7fLVLjTou97ISiiAtrvk7otABkqiP28gpp6M/f1Fc3Q==
Received: from BYAPR02CA0015.namprd02.prod.outlook.com (2603:10b6:a02:ee::28)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Sat, 25 Jan
 2025 00:31:08 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::c0) by BYAPR02CA0015.outlook.office365.com
 (2603:10b6:a02:ee::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Sat,
 25 Jan 2025 00:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sat, 25 Jan 2025 00:31:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 16:30:55 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 24 Jan 2025 16:30:55 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 24 Jan 2025 16:30:54 -0800
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
Subject: [PATCH v6 02/14] iommufd/fault: Add an iommufd_fault_init() helper
Date: Fri, 24 Jan 2025 16:30:31 -0800
Message-ID: <4faccae8dde11e27e07ae58fe658b871f09ee2c2.1737754129.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e20d08e-bfd9-4474-0252-08dd3cd78ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CYapeASZfWVHbb/lZKuCyI30FGUMuShnu2FTu5e5xh8GYIuRbMzqLhdh6dZY?=
 =?us-ascii?Q?iEKVosqpStu7BkKzC3LA71zBE5pTuKrsdWhWqCgreywgV/fURq9cqrXHL/Mp?=
 =?us-ascii?Q?C04X76choLqKpH1ktkm3tAzTccuHWqfNJOk/AjewnzwRt64+R0wYw8bgorPo?=
 =?us-ascii?Q?u+hajfSuvjgS1vDUlOdnzMFbG1l4XR6zWfyUmLJUJButX0/LIrFbzjpm/H5C?=
 =?us-ascii?Q?uxSbmQwHWhxnMJt5rIrLzHnVRKGnqUOWHjvQPsoud7GKMzA1bNPa2ZQelPP5?=
 =?us-ascii?Q?mJFfToP9/CCwMzD9rMdEN8EdZcY1fJz/qXZLBf0Fg0A4McKbTaY3gppTjG69?=
 =?us-ascii?Q?9iTHNteLRiD37L3HpZwm641AIOHSpdDD3EeTKLuirGmGV1YXZX4ypPj1l2cG?=
 =?us-ascii?Q?PLshimB5hrMrvN/icHoeuWJU0xl4h/CQCfMM1ehJo7CldiwBYNBvKqR1CcHV?=
 =?us-ascii?Q?/vf6p3O2YRQHvKgLmBLmgGEh0+vacsv9rl3rnYIzYzLmLmwu15DpqhYifmwX?=
 =?us-ascii?Q?mGFJP6AVGb/8MtPum6GtuJdgRT4oyNcL/gvBwWZufduXbLkK19fXuRvOjt3a?=
 =?us-ascii?Q?icCIJFoDibU7FtW2johuU4JxTjHMRG8jMriHXbdF0HMI7b9MhaUzxpu7vOUy?=
 =?us-ascii?Q?beO7RFdtSOIZ69Pn1pXwiGMfi7kV7O2yGXkI6clFNgcJatCBxVO76Z1hf40v?=
 =?us-ascii?Q?+ASxoAt9N4699z+sFDWLTtWr5iraGRDjJqIhU4sypS1ks53DEP1T8sC2oqkf?=
 =?us-ascii?Q?/LLnYFaxmqGbB51YhxIWMePpoEjroux4CdZUHsb6wxHn26AQWoTCpRAyKMG9?=
 =?us-ascii?Q?vQ3WQSspKtLPPRTZYFKU25QIx6iFnqgnx5BOoX+Jgx0cczaTpiH8skwLeXa4?=
 =?us-ascii?Q?lznk0YGmpY7HgaEjGUKt7x+6OITTNzDDFuvfo/1+4pNsKBrc2PPw63DtOXFR?=
 =?us-ascii?Q?+BfD/AtqcyrYRFIPgGKjIMIpuX07BTiNsgGQeNCkTgO5p+skA4qtqwbnPsEC?=
 =?us-ascii?Q?WL4vYSwfeoLrPA3RPaJcnx1mWtDHABpUobsmga6glBh8fVRnxVAH/lB1taNx?=
 =?us-ascii?Q?DOS/sv04Te9ywfVIGsQ4d8rvYopYDV7tBFhSACSZaRjf4Bp4CFVoVNgHaJ0Q?=
 =?us-ascii?Q?7HhVzSIU8ut9npzbKmDvT+B7BbWpD9EH18XVDgWPNRpBjKFdNTJvf3vmdSfm?=
 =?us-ascii?Q?qvvXplSZsjZbkgyj+yqdrMqB7wgyol2q39ew36x51iBjahuLBrZSKIqdbNGx?=
 =?us-ascii?Q?Dxy+qckGiiROYFxVDO0B1mLcfkxz3dUQFY15KZXDGi+ESDHMdccwHdZ0rFAC?=
 =?us-ascii?Q?U5bXqdAGHsQ0MkO0K6okpoySOOzXRxvOFablw2+KBeKb3KR/4KKcscbgFmEP?=
 =?us-ascii?Q?msY/ocVzVHJEyVi2qScDkjgKxwLjnK82OqDKasIzYiof5WaH6j0HbVUUb5X1?=
 =?us-ascii?Q?1DBbTHNAaDVZm06eMOlixxgt3UcceGDYlbMwLsWOjJJiuhdUhlWN3B46epKZ?=
 =?us-ascii?Q?m8S2/eFHWRNDJqI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 00:31:08.7025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e20d08e-bfd9-4474-0252-08dd3cd78ff3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660

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
index e89d27bb9548..08d940204169 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -400,20 +400,49 @@ static int iommufd_fault_fops_release(struct inode *inode, struct file *filep)
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
 
@@ -424,28 +453,14 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
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
@@ -461,8 +476,7 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
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


