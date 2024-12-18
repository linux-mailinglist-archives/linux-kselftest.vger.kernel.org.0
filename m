Return-Path: <linux-kselftest+bounces-23481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D1F9F5E01
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 06:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007E9188FED3
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 05:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9578D14F9FB;
	Wed, 18 Dec 2024 05:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vx9d4tI9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB3D155336;
	Wed, 18 Dec 2024 05:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498105; cv=fail; b=NPLg7FT/oIPMP/oib0hEIWJzIpFfYJd6AUiIFu8PD/Br7N6Z2ac+gOHKb2ggeDefJtAt/Jxe7nrveUvI5SN7P+wKnwuecqODXtt2LviJZRigKRV9fnv+riUlFIX6QE1x+u4mQNCPs9FwDlI1MFphV7fD3tGpprRJQoCVSSJnR8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498105; c=relaxed/simple;
	bh=rg+ZeCkOjA84EPVyrpsvVDPXj8BeGKuchjdhiCyaT54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKZZDtwcozZrL2u0sufmSDngWDZcAtS+mAkrbllN48QLM41kp+qvX7xj/+kw120vKxrzR73WBuZY9NOnsXqXkyVHUGgaMR2GY01CaQWQZUJ7L7qGzkwrN0H0lBp3/pbg3li695prp/IqWBI1vXI3PiaaUvTsNHRpBcQ90YWtSso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vx9d4tI9; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYEtKoT1Z8hSljf8+7uB/xBqX6guroLuZRXKPN7Lb3tqd0m3ZevgTTiOA3DQNEuCsA/asVqIDGx6WwuiAMeQxUlm0s++3zyXNWJJ2KoGXAjRzYes1ETUpsP0hNZLOFjgbcxuPZCQ8Osl8yIjR1F/kXibvovO78aI2SxvCAQlizz+LjDehsNeh02mcZryMNOfkgqZkoXtexIEFP/ilqRl7eV9qdBE3Pkb9ETOzzYoAVuo3XBnoTy1RieRH9mTR8tSahGjxUHnSe6ujonebmh1n0aTw0QeeEgo7euua6Zw2qCZp+yx75d+hXGY9GM8xgYiLORYzhbrmEYePNmwQX74GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/HqBObKRzPkC1KJoiqG5GsXDouR6FvYVBrDkmeKS4c=;
 b=pmRDHn2qWgOLRmK5eyTW3uDfnH8+M6eScwRsTW7wrSONjp05aXm7BZym925K0FXmtIK7Dr1j/VXR6aSzlO4ak4hiKarZToNZC6hNRbgNidTvOyRJDcTuuVePWGtp8QSNKR5+Fhe7vhgII4HMAOxS5M7vesCMbDr9uGuEBRyBjENK+FXiuVuqnny5LZV0Qe8krVVhookvuCy2IwfRZrSWzWMPAVNoreH9nJd+FBvlGMIXO0t5d33nQk0HimsHs9nlq87vR1WBWG81eOci3yTw8nbJ6lYlDrJp/g4aGmw3ZzDCFDU34Ptc17k7UiWDbFl6RRCwgecttmfz6uvn6dPzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/HqBObKRzPkC1KJoiqG5GsXDouR6FvYVBrDkmeKS4c=;
 b=Vx9d4tI9d5fKAJtZkwCi2LMXVGiDPh6Pb33f/5SQTJqTispl+5Ni0c0mqDtuX73yvPhDwrEmkMEBAR1do2GqARlitKx3R4hd6SloNS58sF/qDc7hHD+rNf3RoKTHzOTs0rxOE/tr6flJIyNAJD6auEYnd+JyFguQLgLtJUsQNA1/fdQxdalIUjqZ6KQB7KeeXK6MEoWJbB2Bw1iqtJoag39sgQWCpcnuTkrV0uXP9o7eEuNEmmWOlv6NQnp+9jWL+eDUs8ybQ+Ofr1tRvoI9WhRZDhUNsCwBrNLphEOVwObFxdpdVgVd497u7uLedc4xEJQfVJNLAfLTlzy+o6Kg9A==
Received: from MW4PR03CA0339.namprd03.prod.outlook.com (2603:10b6:303:dc::14)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 18 Dec
 2024 05:01:38 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:303:dc:cafe::1d) by MW4PR03CA0339.outlook.office365.com
 (2603:10b6:303:dc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Wed,
 18 Dec 2024 05:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 05:01:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:23 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:23 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Dec 2024 21:01:21 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v3 02/14] iommufd/fault: Add an iommufd_fault_init() helper
Date: Tue, 17 Dec 2024 21:00:15 -0800
Message-ID: <d2e570487d95771ff0a48c143c6f62e2626dd5a9.1734477608.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734477608.git.nicolinc@nvidia.com>
References: <cover.1734477608.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d05773-7160-4949-bc11-08dd1f210d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DkagrOpamEB5RViCypCB8R4ozWU+AibSwtLMMjJ5MxNcIweJ6UM2qCV5Kj3U?=
 =?us-ascii?Q?vyvtYD/BCsoi4jpH4eWAH0aTHTRU2BqPzR0Ze1Ib+InRueK49t7ZwJd+i4dv?=
 =?us-ascii?Q?QokNOrtC3Kiox19c1V1dNcQUZ+9VxBE7eOagFsDoyL1TLkU02vdWdXpH7D/o?=
 =?us-ascii?Q?/VFIryvFiU3fcnbTLPwpk70IkwID21fDxHod1J7qLa2yYFb2Sg5UFBTN+nrq?=
 =?us-ascii?Q?Wa/MsEvWK+sl9grfDuqITaKwl3ETcOlKrilrQheVF8ByBfenRvcIe9UEI+Mx?=
 =?us-ascii?Q?gxBTEpwt8tDd+/W+CiY29W2LSWKTTJpwxA8zKeNVwyzC0fhDqlWXlr1nZ8QW?=
 =?us-ascii?Q?f71thzGIFZF8UNhHmQa5ZsnEQgctZwypBNFsJZSdjw9x7peJaKYlL2zt/QPO?=
 =?us-ascii?Q?IR1p+8K0qmT9qqLiqlZC/kfiMdnWvNI283brzl7gwQj9+JP6H2fOhi3n1Xmm?=
 =?us-ascii?Q?c55g7anodYm+c1GdenFoQIz7N5nGUUzKKBO8MQLMurtfuk/XAmJ1RtHu8pd0?=
 =?us-ascii?Q?t99zsuMI/sX6nw4LMZidC4R3TBC63sBt3G4RvjsiIwmfUdF3KyVF+BWmrWFn?=
 =?us-ascii?Q?EZA+bWp7KWTmI/FN/GctFUsPlQiPdCgMsaMXQoOIoYcVXlyOlM9swMMb+CdH?=
 =?us-ascii?Q?NVOcuV7vXGOJnREz4qVN0vHzV2b0KI75g09/tpU/gMrZYTypW4yHOIANAR1J?=
 =?us-ascii?Q?PF2RQuAVQC3GKM34tccEeOpAEKqkAoOHuanFQzjfnsV+aPcOFAEBrlW/jCb1?=
 =?us-ascii?Q?/SCYtHR7W2HOrc3eQSpQQY6ONWhsxAbJRfqa5oesrUJ0PiCC4IynGAx2CKrX?=
 =?us-ascii?Q?QdXkPKcQEMZWO2YRN9luJScAfjqNm7t+IhRGxV/xbUYUv0nzNtScQ/OfYrL6?=
 =?us-ascii?Q?McSO2UtNkrKnT1XMxQp8i+kInBFHlO+zeKeicJyMhUzaFHkxA6WXag7Su0sh?=
 =?us-ascii?Q?xkWBb0EDL25D9O1wx5udUQneLXToKskTQZEAJfVfWzvXP/w9LfOk0XsJlXkr?=
 =?us-ascii?Q?PyiSM597E89MLFH5HM3+WIDdorjCyCEDjNo+3uoowtjw0WsXcOrtKXTVgGv5?=
 =?us-ascii?Q?8zW7yKYGF4jqiUk/R1csuoGPUPwjk1f61U9uXMs2FmCBS7e3XoKQfCxKFaqH?=
 =?us-ascii?Q?FM8ZxrkWDUKZRkJjfGXlmi/FNztAWohcOpAY1NZfClgUuzX6lKL77H4mEB6o?=
 =?us-ascii?Q?4NXgPk87i5ND3U3JoKszMOzpJat3jaLMu7rUnBcADavWm2/yfJN8eeWHhyZq?=
 =?us-ascii?Q?IZuHpIX4h9YwIkB64n09AX/t9pVxgzBN+0N37aaTKMJyBSShgbAZ8BWLKnU6?=
 =?us-ascii?Q?OFeE1Y7HgjAzHp+8/TbF1cXMtXVttavBYURkJmt2pFxfs1+ey/Bl8bCWPDqv?=
 =?us-ascii?Q?ugHYg45GDoGCSYGkbgn3UfA1A6gpKaw9kydwbRX6VgCTHCTME3eT7He7GLBI?=
 =?us-ascii?Q?sy2QrkWXcwA84gEI95FrWfgpAAuFBAQeLP4J6wDfFmabli/TA3Kvpn6O1LZW?=
 =?us-ascii?Q?UAe7SokpcMCWd7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 05:01:37.6755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d05773-7160-4949-bc11-08dd1f210d8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759

The infrastructure of a fault object will be shared with a new vIRQ object
in a following change. Add a helper for a vIRQ allocator to call it too.

Reorder the iommufd_ctx_get and refcount_inc to keep them symmetrical with
the iommufd_fault_fops_release().

Since the new vIRQ object doesn't need "response", leave the xa_init_flags
in its original location.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/fault.c | 48 ++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 1fe804e28a86..1d1095fc8224 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -367,11 +367,35 @@ static const struct file_operations iommufd_fault_fops = {
 	.release	= iommufd_fault_fops_release,
 };
 
+static int iommufd_fault_init(struct iommufd_fault *fault, char *name,
+			      struct iommufd_ctx *ictx)
+{
+	struct file *filep;
+	int fdno;
+
+	mutex_init(&fault->mutex);
+	INIT_LIST_HEAD(&fault->deliver);
+	init_waitqueue_head(&fault->wait_queue);
+
+	filep = anon_inode_getfile(name, &iommufd_fault_fops, fault, O_RDWR);
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
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_fault_alloc *cmd = ucmd->cmd;
 	struct iommufd_fault *fault;
-	struct file *filep;
 	int fdno;
 	int rc;
 
@@ -382,27 +406,12 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	if (IS_ERR(fault))
 		return PTR_ERR(fault);
 
-	fault->ictx = ucmd->ictx;
-	INIT_LIST_HEAD(&fault->deliver);
 	xa_init_flags(&fault->response, XA_FLAGS_ALLOC1);
-	mutex_init(&fault->mutex);
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
+	fdno = iommufd_fault_init(fault, "[iommufd-pgfault]", ucmd->ictx);
 	if (fdno < 0) {
 		rc = fdno;
-		goto out_fput;
+		goto out_abort;
 	}
 
 	cmd->out_fault_id = fault->obj.id;
@@ -418,8 +427,7 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
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


