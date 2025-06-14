Return-Path: <linux-kselftest+bounces-34984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DE1AD9AB9
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E75E3B0F3D
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD47202C46;
	Sat, 14 Jun 2025 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hd8/wHCX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623DD1F3B87;
	Sat, 14 Jun 2025 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885333; cv=fail; b=TitztOQeNdi/Xv2942N2A4yRAOr/LueqAnx4XFrUPB/Wf6NDwLwjc3D/UEk3hWFRBcwySK/m1hscteulhMxl3E9NgoFXdDSrtPBoF/4LhlYar0ChSV4K89mr0KWDtLqeAPbtiFh7GMh97/SSZvF/3ujtTvYP6yhAOpwJyO1sLKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885333; c=relaxed/simple;
	bh=uwgXVlvTBeRsekOWuc+qva3x4QhrK5jLcef+3FUX03E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pE8Pr8yzGcI/M19GoAgbr3Ow5+zm+gxzobYn5lz/MzYbhp+z71ZD2Qb3rtYzbXS5svistLitbSK+ak+Hck+2TmcqA/0r2XwXMV71H8sPbdJDhR3RKfu1HKtJo0x+OCm5UdCtsIz4eFzE8CReho4dVQo5jN3y+mueHyZeRFbewMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hd8/wHCX; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOy0MO/Ot0iI+xoTKyMG8V4HYG3EZcPUfHxGXv0fnNWxSov32IWYgxCNQmCrKkxGFvszsic0DrqShKTnOJ9tSAXzqm/fz+8B364+BtpASWlr4eRqY6yxQxceVgYDSB/ujBon/E5FdvPURprZ2xVVsgEtcMjQtNkMD/f6VBVEdzNh36zegUxo/9ccv0KycXDFYOklsG1nCHHIjKdt/0EMosO0zlrstn8GwycaISOb41ZycdIbaHFid1CRLwIB5AMi/qCkKcu0LFfCTqweG4MfpTulWYJfvrMe7jT2u2YjCqmDNeGZkFpWWXX74if0QNVjKrFArnDElu/7jPlfOy+P1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHjvM8DlQVDZ4xjfSjo88fxasRxXV5TGCCQ05oS/kDs=;
 b=wUYOietedKgYugnvr0rzmGXPKft6nMNNfmOpc1h2EJ/6MnKsr4NX9U7V/PnhxFOZ26q2Qb4jBmtou5ACiiNC49PYarnO+P6t5WM8fB7xe8gtfazjXzgb8wlRwbMkettL3JOTN4mew+kqzKLGdV3rQoLmf025hw9HTRbxsIGOjqB+vJg1imLH0fv+RR2W6B3TvTe4MbNRpdPhSk40kceAuu7vMY9r1zpfKTlgmSBoN8QXhgkPKibgOe9INFevZFvyC3VVihn4jrN/jMkKOgWnJNAxVA82MTIhesdRjTuQa3D7bAULkvqbuLo2NuYsGDCXoHYSCRmpNjiPt498ES3c1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHjvM8DlQVDZ4xjfSjo88fxasRxXV5TGCCQ05oS/kDs=;
 b=Hd8/wHCXVGmUYECil9vg0vBJE9bQuUwKMj2IElO8l+r46WwHek5p7BdMC0OfVstgq6xXrG/rwZ3H+L0VjfbFoHZRbLEsWXg1pbxN1OXVBtEgaEsuwNHWhknYcZO3wV9exqQ+Opj2SRAGi2l/sOcC/r8vA9ST1kIkjfS8ImnSg60ggBkTsRrArKta+8dapU0nlfRhEyDNXmGXHKdcgH23jRFDo0jUAygcQ6nSxpiCdEzEnV/7ae57K5ZZAtPK2hqqVpcPlPqaHJ32BYJDS2XSOCI71m/UHsZa32tdAxhSSs7/MUjZqxKT9HZ3ZSYWK029pVhA3XF+ree7rMpkg47OFw==
Received: from BN9PR03CA0679.namprd03.prod.outlook.com (2603:10b6:408:10e::24)
 by SA1PR12MB8698.namprd12.prod.outlook.com (2603:10b6:806:38b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Sat, 14 Jun
 2025 07:15:27 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::d2) by BN9PR03CA0679.outlook.office365.com
 (2603:10b6:408:10e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Sat,
 14 Jun 2025 07:15:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v6 07/25] iommufd/access: Add internal APIs for HW queue to use
Date: Sat, 14 Jun 2025 00:14:32 -0700
Message-ID: <64145b184a0fa7c9b60532c9b475a51625edb77c.1749884998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749884998.git.nicolinc@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SA1PR12MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cf03a1-2855-4655-8e18-08ddab133ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6VOAg18qPhxXqVu86Pm9YPSvwa7/YsTcLQiUMbMeujME442J3wtr7IrwYSeH?=
 =?us-ascii?Q?kfTdoS/oCORjkmL8x+jn5MMlAJAX7/flKsnnK2iot4IWrnMM5e798WOR/52Z?=
 =?us-ascii?Q?1ZDyqlBvWQaHWJxMKa2+AG87ERnNlQzB8FhsXtVK/89oZCkwYFuJB5aB1hwp?=
 =?us-ascii?Q?NnDTmHEFuc2jbJW5VEyTqOhZaNp3p2hjcT75iTfnPSzyYp4od8KyfKj95cAu?=
 =?us-ascii?Q?Bj8/10FhGsONemGYwFQ4zQNVyeQkzHUiT7WGDXtvXeRNWXUM2vGa8Iy8ozEl?=
 =?us-ascii?Q?MqFizejTtb0+0XajEzysCxA3FfVEgUGnMpij9zn17WZqGFdqTpolliksoUNG?=
 =?us-ascii?Q?DcpHWdk7FJPgn1Pj742ovpZslh68LZEB+KspXSc/pMRFxDcdXE0rx3M49LK3?=
 =?us-ascii?Q?QHLXmwMCTRuBSTnXsvsyLWub7z6p4xYPzVYZBKW/pfPAiCf/d+PyWUR4jYuP?=
 =?us-ascii?Q?PPGmiIoIcrjMu2V2a44UT60QZgXG0QqS9h8OHCr2X70Cmi7KftfW1g4w1wtv?=
 =?us-ascii?Q?TCFg+axjJZBHBFVQztrgDuFcwS/ekvjaYEvoYJgHVaWeBxQcaW8CIonTdh6D?=
 =?us-ascii?Q?hdL6VLZ0TaZafCIr1qDANIS1N5EKMQWggi9h1YddbayfWUDAbo6MHNpjHHpr?=
 =?us-ascii?Q?e30HTwbqmHAm+z4jSVWQxc7Jy69wrbN4EOFZqGOgI3pINt8WAC7wod4i8Qwm?=
 =?us-ascii?Q?NtEsfifCgxVI0CTFVTExDt+HEfsqafCXr6qEyKx+M9bZPejNIsxNjJ6W6GqZ?=
 =?us-ascii?Q?fNtCQjPYxiTuyvpTPEFWBY4LDzgYJT+RxzhkumafBgbNGf9xc/Bbsz7YTSJx?=
 =?us-ascii?Q?70GzKewMI+Wu3f1NarMWukAM0z9jpJVh4zIF27emkWpYw9FMsXqREqfxVedO?=
 =?us-ascii?Q?EFO64pZ8WJkKafThWwPRxbEvTBt4B4srQMHTOTSyQcoJ2JH45A5XzLFJnzZl?=
 =?us-ascii?Q?PB7zE7yHdF7nWwTtZxJhfBna+NGjM5RAGgFAZiN2Lin/ewt7cZ8jXHYEkITQ?=
 =?us-ascii?Q?GxrBLsau3FrE+vAMqDHDQBN4ZoGQit4Iwl8AGukB3xKpRoc7vQXkr0vRsHTi?=
 =?us-ascii?Q?53Yv7vZgiqCfdsIiVJst7bTO2FEAwT5tpJs5sqqW7Im3XXfLtobgEGC1KvAI?=
 =?us-ascii?Q?JgZ1+z4P/ZsIJPJD6B7m85eZxFMdlclmoWAMI0tKnRUmBSv/wGqPEKn1k2SR?=
 =?us-ascii?Q?yotGSGtIWdazUz7adb4+KI6UKceHyOPN4yPdNOlZV1hWrwmdWe25vShqxSTY?=
 =?us-ascii?Q?A4rAa+m0EUm5UevoxvkWzqtLm6HCY0haPU5YvdeqGMpIaBuPtecE/Psx0tb0?=
 =?us-ascii?Q?sWVXMtI/FpswUC3DVXaoTEchieoFrG0ivKeLCq1UqRt/JZlcpdxRACaoxmBa?=
 =?us-ascii?Q?Gx99xXyYM3I7pXI912te7R+nlnL5Cff89pNDBHkp1JzNpUpZk5gxOTYP1p3T?=
 =?us-ascii?Q?Om6CztVQE0LsUhuBqa/M2vhiolWQ7d+65WZCTK0lG3k71Bree/11Lr7Da2Qq?=
 =?us-ascii?Q?yY7tf1bDAd/SgOPsYkcM7AzfU/xbBd0AZyFw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:26.8830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cf03a1-2855-4655-8e18-08ddab133ce4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8698

Now, access->ops can be NULL, to support an internal use case for the new
HW queue object. Since an access object in this case will be allocated by
an inernal iommufd object, the refcount on the ictx should be skipped, so
as not to deadlock the release of the ictx as it would otherwise wait for
the release of the access first during the release of the internal object
that could wait for the release of ictx:
    ictx --releases--> hw_queue --releases--> access
      ^                                         |
      |_________________releases________________v

Add a set of lightweight internal APIs to unlink access and ictx:
    ictx --releases--> hw_queue --releases--> access

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  8 ++++
 drivers/iommu/iommufd/device.c          | 59 +++++++++++++++++++++----
 2 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 4a375a8c9216..468717d5e5bc 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -484,6 +484,14 @@ void iopt_remove_access(struct io_pagetable *iopt,
 			struct iommufd_access *access, u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
+/* iommufd_access for internal use */
+struct iommufd_access *iommufd_access_create_internal(struct iommufd_ctx *ictx);
+#define iommufd_access_destroy_internal(ictx, access) \
+	iommufd_object_destroy_user(ictx, &(access)->obj)
+int iommufd_access_attach_internal(struct iommufd_access *access,
+				   struct iommufd_ioas *ioas);
+#define iommufd_access_detach_internal(access) iommufd_access_detach(access)
+
 struct iommufd_eventq {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 9293722b9cff..ad33f1e41a24 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1084,7 +1084,39 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
 	if (access->ioas)
 		WARN_ON(iommufd_access_change_ioas(access, NULL));
 	mutex_unlock(&access->ioas_lock);
-	iommufd_ctx_put(access->ictx);
+	if (access->ops)
+		iommufd_ctx_put(access->ictx);
+}
+
+static struct iommufd_access *__iommufd_access_create(struct iommufd_ctx *ictx)
+{
+	struct iommufd_access *access;
+
+	/*
+	 * There is no uAPI for the access object, but to keep things symmetric
+	 * use the object infrastructure anyhow.
+	 */
+	access = iommufd_object_alloc(ictx, access, IOMMUFD_OBJ_ACCESS);
+	if (IS_ERR(access))
+		return access;
+
+	/* The calling driver is a user until iommufd_access_destroy() */
+	refcount_inc(&access->obj.users);
+	mutex_init(&access->ioas_lock);
+	return access;
+}
+
+struct iommufd_access *iommufd_access_create_internal(struct iommufd_ctx *ictx)
+{
+	struct iommufd_access *access;
+
+	access = __iommufd_access_create(ictx);
+	if (IS_ERR(access))
+		return access;
+	access->iova_alignment = PAGE_SIZE;
+
+	iommufd_object_finalize(ictx, &access->obj);
+	return access;
 }
 
 /**
@@ -1106,11 +1138,7 @@ iommufd_access_create(struct iommufd_ctx *ictx,
 {
 	struct iommufd_access *access;
 
-	/*
-	 * There is no uAPI for the access object, but to keep things symmetric
-	 * use the object infrastructure anyhow.
-	 */
-	access = iommufd_object_alloc(ictx, access, IOMMUFD_OBJ_ACCESS);
+	access = __iommufd_access_create(ictx);
 	if (IS_ERR(access))
 		return access;
 
@@ -1122,13 +1150,10 @@ iommufd_access_create(struct iommufd_ctx *ictx,
 	else
 		access->iova_alignment = 1;
 
-	/* The calling driver is a user until iommufd_access_destroy() */
-	refcount_inc(&access->obj.users);
 	access->ictx = ictx;
 	iommufd_ctx_get(ictx);
 	iommufd_object_finalize(ictx, &access->obj);
 	*id = access->obj.id;
-	mutex_init(&access->ioas_lock);
 	return access;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_create, "IOMMUFD");
@@ -1173,6 +1198,22 @@ int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_attach, "IOMMUFD");
 
+int iommufd_access_attach_internal(struct iommufd_access *access,
+				   struct iommufd_ioas *ioas)
+{
+	int rc;
+
+	mutex_lock(&access->ioas_lock);
+	if (WARN_ON(access->ioas)) {
+		mutex_unlock(&access->ioas_lock);
+		return -EINVAL;
+	}
+
+	rc = iommufd_access_change_ioas(access, ioas);
+	mutex_unlock(&access->ioas_lock);
+	return rc;
+}
+
 int iommufd_access_replace(struct iommufd_access *access, u32 ioas_id)
 {
 	int rc;
-- 
2.43.0


