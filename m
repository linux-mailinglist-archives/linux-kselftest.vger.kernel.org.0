Return-Path: <linux-kselftest+bounces-21477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F309BD68F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77436282F3A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BDD216447;
	Tue,  5 Nov 2024 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m7ebJnwB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C258216435;
	Tue,  5 Nov 2024 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837112; cv=fail; b=bmg/mJXO0J/5MRJHJoYCBOeTTAu17N7+XL6cdgUqow+6B0jggBBUhLYtzJeLdHw+TEx3Geow9W+Lphr9n9fOmaiFzkzB9fCZK6dLY4o0GeV3YJ9Mh512e3wW1gl3gnDMIR2EZQez1LU7k0JxV6HlgQx+W9zEJbKJ8ifrZcqMsyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837112; c=relaxed/simple;
	bh=5gPEZtyyDhyM2EjvMAHDyzSrnjeQcuInTegKAjl6Qic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYhCc/7x63ynqFiP+REw/3RXvK1vZWDa3pXcLd/JJc9SMDcMsme3xcKuCFEHFftUYA3V5/nqct7a9SJEnNDhEU1wGK7BARKRsFxyl5CMzkk6br64Li+7yzvKOFNOYmqmBaZzMteDonbEFqmgXcU8iUE6e++aUxERR+GDu+JoiVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m7ebJnwB; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2WnVVg4kWT2rBjubfKYv1jJBKoEHLKrTJpMLo7g3upW9lUTHCbNwNZb/HHKwSreoy9aCNxXW+oazYzHBnGleQczsydeEuIC5LWt7JJzjCtB/vOenZp0WhTfjk/IdZt/rfmPqC+bAKBZXSHNGAaXd9T/SFSYzTr17ZLicN7bzOpAt3NpjuyHlGlHlC+Ow2/Zrk+eMUA/SEJ+Ou336ywCQzZp8RTWwuy5T3bm5ODnY9/rbb2VNL/65xmrHGmCWVulnyWlDqHwziYShMQtq12BWE0qApAjOmMMiaHcIPksgPykV61bmmplJjjgjaJwFPfWxdwj/7Y5P+VNgTXOzuHQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Gd0uG/1jtFeNxS3+PkXSFAp4PEfyqYU+G9occHIIPY=;
 b=zLLgXIdJmGbMqCDHKKzwaNasWmZwTJZdHzWwYUYmISxU4XpovlQQ29J1r7s5En5Zz/Dde1E6u3uFrQ7LK9McoaTGB/yjJUCHdrWUXswpCDkoEtasVVieGGduvUJQ/wudzzA5sjE2Q96oPI6qphj72Ah7iBI3K9lo98i2djbV9qiMuA2FhbKsxiRKxUn5HJj8n1pXYiQH34J97Wd7masFeY4QeTn6MYb5gJl+4+17uBegey1RRMkOn1WAjlTw337b+HMej6lOkvs+7wMEv/g7NM9/k+kMZP/maypGkrW76UTuLv5fEzgKYSaLSL0GF9Tlp4ToKads646u3LFvo2WxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Gd0uG/1jtFeNxS3+PkXSFAp4PEfyqYU+G9occHIIPY=;
 b=m7ebJnwBj7O8FyMjYKHeqwzhr19hQPkIfz5aRenfGhzD6oCvWeJUEX38B2WsKZlkB1JwKLFFFzcRE56JaVRMWGfAdxMevHKGnfP7uvSALMhb3kiGEn0cRveoyb4xsFAjbaAH5HXyUy1kSxffcZ/GKCmwYLvxx8v9rKcxs37vGo8Tc3bw5FHFcpeTnH0WZzJTi5HRpcN+ZQJIVQAQ4ltOMEAK9wB1VdLrtTy5yWnO0BecjHyaJ061QXg9y0jnoSMuP0eT86nNxObAdjsInvzVQ15vF6I6mJJQWEKgnukXwK9eexoqTASvLoMXJOchESPO0WreRUtesd1+z4bNAvQgnw==
Received: from BN9P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::33)
 by SJ2PR12MB8718.namprd12.prod.outlook.com (2603:10b6:a03:540::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 5 Nov
 2024 20:05:06 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::47) by BN9P222CA0028.outlook.office365.com
 (2603:10b6:408:10c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 20:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:50 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:50 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:04:48 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: [PATCH v7 07/13] iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
Date: Tue, 5 Nov 2024 12:04:23 -0800
Message-ID: <a0f24f32bfada8b448d17587adcaedeeb50a67ed.1730836219.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730836219.git.nicolinc@nvidia.com>
References: <cover.1730836219.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|SJ2PR12MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: cd402134-4741-4eed-473a-08dcfdd52474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KhOAhdfdo8sOPK21sjWErSj+sdTB/a6dBuwVvc32QMhRBwVLM/1PeR+MHuol?=
 =?us-ascii?Q?+z34+efBkfpYpy//6k4sWhhtymEl2hPJ9ayM40YZw/YYZyszy31bjJHNnR0/?=
 =?us-ascii?Q?5es35g2Obzc1wUWnoQ2ODa5mw0FrtJHOgD4E13XXwiKggNth9kcT75pZA9GV?=
 =?us-ascii?Q?9LblY9RDpN1TeyfqVYiYxwLNN7OYcRZHRDBBpO4KUoOmZmTx05udJeiJ132M?=
 =?us-ascii?Q?9QXR1NL9+0MEolMiA/P/KwYfXqZ93u0KTuS035gytETGddjmIgGnx51odp+P?=
 =?us-ascii?Q?Gp4EC0SSudSA3E+4WLGZhKyBza1hIdlxYjpRmkZZoMDwCpvQf/mDpCDx0bIQ?=
 =?us-ascii?Q?EvJLFzDqMS7w5tdHpjepBaUKZkT31PDilw9pkg4Ivxhm0ydN096FgHoEzuYB?=
 =?us-ascii?Q?WD48xgXtunuibDtJP02kNALNwZN9uY62fNbd5jl5RkC0mX1MiISBS1N7fWlw?=
 =?us-ascii?Q?yQUHDBzaZdIhrsVcgdVEVn6RZrbDPB8oBPUrZp+FZ99dIFuyzITI8mOFQ3sx?=
 =?us-ascii?Q?YRhxWqy1on8d2C8U77gqsYUj2xId4Coz9XFve4NIRMHFuKL6TzEP7ciVvxQR?=
 =?us-ascii?Q?Z29DOiJb1QQCYRDnhKtni1mi8zjdKlGdmyUWV7nvLTS9WBIKIDam5ZVod8x8?=
 =?us-ascii?Q?z4EIXegsA9i/eknhKKKyDSvn/TmlIir5w78xy6Crk/b/dJ/NETM/AsUK8fFo?=
 =?us-ascii?Q?Uf9U8ARNMBpozAAghF/sne+BkI9uNAteVQ7/+DDjOTxFEwz4SGaQeyzslc8Y?=
 =?us-ascii?Q?sy4ZqXzTgzD08EfSlf0T80n8rBU5wpNTGoD2wLak8E71jLlx4vTCc0KVNJUe?=
 =?us-ascii?Q?DDgo46GITZwnbtUEaln9JI2BCu8G8lSzQH446lPrSW3rpSUWTVGeXvyGlegc?=
 =?us-ascii?Q?0vUfnNr9OMmBHfiGlmMUJ7HJGVMrYL7w7C8YCdEObnOKn6FPGTtgkRrL7Vud?=
 =?us-ascii?Q?eX3aFLGKcLHOvtv6twDjxvH8Sc4vS+C0lJa9aIasJQlraYyPkAF58imDC11r?=
 =?us-ascii?Q?ikUuIMJfSo0ww0GsLdUnSunQWOuH/BAws59KtkbzQwpxHucguEhlL/mw2pXv?=
 =?us-ascii?Q?qst5xtiVRVkRiCJzo/PA76I7JyUPkXq3K6p24QO+jlk4wjYUVBe8frcidlfL?=
 =?us-ascii?Q?GCN1p+MrKYcjiV6KqZwi5KX+F7zMOgEM/mxs3zYPn+ey6jYYjmVNMXhKc5hz?=
 =?us-ascii?Q?d8ZRaHCiWjoArLdwuKoDG/l/b9Odt1wBDaI2qnCFa2mz+GkG993EkTOhxApH?=
 =?us-ascii?Q?SE0b5QPOp8SaO93ormdaR1REr7cx/n7FrrKFhorBs5gpWNDxTI5nOEwlii7Z?=
 =?us-ascii?Q?khoCbBq0jpD6Ey4ekN1HQb9lRnh65RKKfQsXeVUY9aga6taNU/YNfpKdPcuA?=
 =?us-ascii?Q?jioOqGCedxvmLbM1WlanXSpjiNj0lOH10JY44GwIfSlBO4XGyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:05.9198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd402134-4741-4eed-473a-08dcfdd52474
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8718

Now a vIOMMU holds a shareable nesting parent HWPT. So, it can act like
that nesting parent HWPT to allocate a nested HWPT.

Support that in the IOMMU_HWPT_ALLOC ioctl handler, and update its kdoc.

Also, add an iommufd_viommu_alloc_hwpt_nested helper to allocate a nested
HWPT for a vIOMMU object. Since a vIOMMU object holds the parent hwpt's
refcount already, increase the refcount of the vIOMMU only.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 include/uapi/linux/iommufd.h            | 14 +++--
 drivers/iommu/iommufd/hw_pagetable.c    | 73 ++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index a8104d9d4cef..e8f5ef550cc9 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -290,6 +290,7 @@ struct iommufd_hwpt_paging {
 struct iommufd_hwpt_nested {
 	struct iommufd_hw_pagetable common;
 	struct iommufd_hwpt_paging *parent;
+	struct iommufd_viommu *viommu;
 };
 
 static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 302844136b02..a498d4838f9a 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -435,7 +435,7 @@ enum iommu_hwpt_data_type {
  * @size: sizeof(struct iommu_hwpt_alloc)
  * @flags: Combination of enum iommufd_hwpt_alloc_flags
  * @dev_id: The device to allocate this HWPT for
- * @pt_id: The IOAS or HWPT to connect this HWPT to
+ * @pt_id: The IOAS or HWPT or vIOMMU to connect this HWPT to
  * @out_hwpt_id: The ID of the new HWPT
  * @__reserved: Must be 0
  * @data_type: One of enum iommu_hwpt_data_type
@@ -454,11 +454,13 @@ enum iommu_hwpt_data_type {
  * IOMMU_HWPT_DATA_NONE. The HWPT can be allocated as a parent HWPT for a
  * nesting configuration by passing IOMMU_HWPT_ALLOC_NEST_PARENT via @flags.
  *
- * A user-managed nested HWPT will be created from a given parent HWPT via
- * @pt_id, in which the parent HWPT must be allocated previously via the
- * same ioctl from a given IOAS (@pt_id). In this case, the @data_type
- * must be set to a pre-defined type corresponding to an I/O page table
- * type supported by the underlying IOMMU hardware.
+ * A user-managed nested HWPT will be created from a given vIOMMU (wrapping a
+ * parent HWPT) or a parent HWPT via @pt_id, in which the parent HWPT must be
+ * allocated previously via the same ioctl from a given IOAS (@pt_id). In this
+ * case, the @data_type must be set to a pre-defined type corresponding to an
+ * I/O page table type supported by the underlying IOMMU hardware. The device
+ * via @dev_id and the vIOMMU via @pt_id must be associated to the same IOMMU
+ * instance.
  *
  * If the @data_type is set to IOMMU_HWPT_DATA_NONE, @data_len and
  * @data_uptr should be zero. Otherwise, both @data_len and @data_uptr
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index d06bf6e6c19f..982bf4a35a2b 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -57,7 +57,10 @@ void iommufd_hwpt_nested_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_hwpt_nested, common.obj);
 
 	__iommufd_hwpt_destroy(&hwpt_nested->common);
-	refcount_dec(&hwpt_nested->parent->common.obj.users);
+	if (hwpt_nested->viommu)
+		refcount_dec(&hwpt_nested->viommu->obj.users);
+	else
+		refcount_dec(&hwpt_nested->parent->common.obj.users);
 }
 
 void iommufd_hwpt_nested_abort(struct iommufd_object *obj)
@@ -260,6 +263,58 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	return ERR_PTR(rc);
 }
 
+/**
+ * iommufd_viommu_alloc_hwpt_nested() - Get a hwpt_nested for a vIOMMU
+ * @viommu: vIOMMU ojbect to associate the hwpt_nested/domain with
+ * @flags: Flags from userspace
+ * @user_data: user_data pointer. Must be valid
+ *
+ * Allocate a new IOMMU_DOMAIN_NESTED for a vIOMMU and return it as a NESTED
+ * hw_pagetable.
+ */
+static struct iommufd_hwpt_nested *
+iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
+				 const struct iommu_user_data *user_data)
+{
+	struct iommufd_hwpt_nested *hwpt_nested;
+	struct iommufd_hw_pagetable *hwpt;
+	int rc;
+
+	if (!user_data->len)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (!viommu->ops || !viommu->ops->alloc_domain_nested)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	hwpt_nested = __iommufd_object_alloc(
+		viommu->ictx, hwpt_nested, IOMMUFD_OBJ_HWPT_NESTED, common.obj);
+	if (IS_ERR(hwpt_nested))
+		return ERR_CAST(hwpt_nested);
+	hwpt = &hwpt_nested->common;
+
+	hwpt_nested->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+	hwpt_nested->parent = viommu->hwpt;
+
+	hwpt->domain =
+		viommu->ops->alloc_domain_nested(viommu, flags, user_data);
+	if (IS_ERR(hwpt->domain)) {
+		rc = PTR_ERR(hwpt->domain);
+		hwpt->domain = NULL;
+		goto out_abort;
+	}
+	hwpt->domain->owner = viommu->iommu_dev->ops;
+
+	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
+		rc = -EINVAL;
+		goto out_abort;
+	}
+	return hwpt_nested;
+
+out_abort:
+	iommufd_object_abort_and_destroy(viommu->ictx, &hwpt->obj);
+	return ERR_PTR(rc);
+}
+
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
@@ -316,6 +371,22 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 			goto out_unlock;
 		}
 		hwpt = &hwpt_nested->common;
+	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
+		struct iommufd_hwpt_nested *hwpt_nested;
+		struct iommufd_viommu *viommu;
+
+		viommu = container_of(pt_obj, struct iommufd_viommu, obj);
+		if (viommu->iommu_dev != __iommu_get_iommu_dev(idev->dev)) {
+			rc = -EINVAL;
+			goto out_unlock;
+		}
+		hwpt_nested = iommufd_viommu_alloc_hwpt_nested(
+			viommu, cmd->flags, &user_data);
+		if (IS_ERR(hwpt_nested)) {
+			rc = PTR_ERR(hwpt_nested);
+			goto out_unlock;
+		}
+		hwpt = &hwpt_nested->common;
 	} else {
 		rc = -EINVAL;
 		goto out_put_pt;
-- 
2.43.0


