Return-Path: <linux-kselftest+bounces-20738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749519B138A
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9861A1C21F9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD3021C2FA;
	Fri, 25 Oct 2024 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E4eUZsv5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25F6214409;
	Fri, 25 Oct 2024 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900271; cv=fail; b=duJrifPN7AykqbrblD7/kCuagl3kYzhUynJFE079lpLjwRvgKRsXy37c7betkoid+pxPtn+hxlCZYrmT3ObrmdizcwN218NA1kYxgrp5TEDPqinDGYzy1zinGW3iuaN4w4mLdBSctfn3QfiAxnq1XH/OTqYQJSxbQb+MhTo02PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900271; c=relaxed/simple;
	bh=42LeZJ3xvFmYgLbihdsh81s1wMRtIgrr4/9tlzTCBIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZ4wV4fHu7J69k1oLxhEAaoUJR2oPzkLtMP0zstfIKhjfZrP9GdiaRTAuGGhWSwJoNfTpukiEINNyPPZo51rymPjrue8oYR6TWEUfEq8KsjQAVCIiE1JPp4IIMt/dxO3bM+Os0PvO8ubuYWTZNTrFrFinbS3Boc6ZdXgVXBKI+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E4eUZsv5; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EP/MbRAMz5EG4tc5IRYiyITbZlDEaDLjwSAhsFChlvxWr28GLVOGwFMghztZLfMBJcqfohgJdvRVPFhog9hYwE6b/SlUzQEnXNoywZFiamiff7xH2PXI0Gl/5BEWSgzIeKy13Kw9I6wun2F8HUHthq83GEsfz2kcgebRduFnfjQpxsiMkMtKw3eu+4XZLCqEJRqMpffT6XgXuSpmFQU11tljeeQMQtfuhW/B4qEuaW7aRjSDkcK7441PKm+bCgnly9DNznyonjIfiajqd0Ok57wk/RP5kbnW2mDtbdybREPiUS43M8NsbU4WoxgyTXR8/kC2IZa6QOih2a6bJUPAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvlBSYEvWCG0hAnIUYc10bbXD8NGghhkWHcflXNXcto=;
 b=QH+nWpHH6b9GImCh9EUE68IJ/Q7lxGG4J1GlB5CpubKbntdAjG80RWOdD4ntAx1vaqzopU9NeJGCI8nrqyelj5fp1nMD6XlQuG1/yHgW70KPAs5RjCh2zN3MOKuWkcKUbUK4Wzq+1wCs4QcU0srtj9PtVPJGBTB/5Seiv2RqYyDNI9FJzuBMTNlRBVbHTVkVTAvBMIAV3b5ODZGIE2CEcuHRrQTVqi5EBAv5TFgL7bwbXVLylteijcuWWEnaf/ZkzmvDqs+0ml7Cdtn3kn0IBQ0METKazbe1nZiuymAY2c32mfvDn6ji+B1iy7WANyhp+G44iLOJdupCcfX/NGfipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvlBSYEvWCG0hAnIUYc10bbXD8NGghhkWHcflXNXcto=;
 b=E4eUZsv51JungpLM2GZZztmIb9hCivFZwCdp+iK/9SSPSNjA3gSUiraLNsi/532FieYehYOTGO+DeYdHJwcuyuveLEGHLlMwJhlbkGL6Jxu3LjDRmm7+nqKYUBgQVeqBLoqDAADEbz5sbW5vjT9NeLLLK3P5eV4R6467gMYwKZ4VRF14y3Mg19ZAaV7UkZMGnYQKjn1dI8FqKW1LtkxM0qygDP+/XNPAbvNvwlNPfN5xfEIQwfk3TB0g6AoYkntFSA/MYYkwrjyW5OvUwMSlF0BBMhIywoG3RwC/N0JWm8/ebpJZpxu+lUsZ1vVCf6YOOebGBeeftzDCHLMIRGUzdg==
Received: from BYAPR05CA0100.namprd05.prod.outlook.com (2603:10b6:a03:e0::41)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Fri, 25 Oct
 2024 23:51:05 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::38) by BYAPR05CA0100.outlook.office365.com
 (2603:10b6:a03:e0::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.8 via Frontend
 Transport; Fri, 25 Oct 2024 23:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:51:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:57 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v5 07/13] iommufd/viommu: Add iommufd_viommu_find_dev helper
Date: Fri, 25 Oct 2024 16:50:36 -0700
Message-ID: <384f7b4333a1f75da09e390902b8f82be21a0dd3.1729897278.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897278.git.nicolinc@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 006ed9b0-b188-461b-0c50-08dcf54fe412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PzRHX/1AQIgXyKxvdKk4NPzmvDwk5JqMazn8tAaXnNEgTY9tikJf80s4bo4X?=
 =?us-ascii?Q?VC1m6BeNJQkFmV+AZRu0RTZZGoX9l9WWAc3/5pE9iCBH1Xpkv+3rJePaVybo?=
 =?us-ascii?Q?3nRNayvkn1FwIZxgEqpqlkK5iJDKpTqfA4501bm47pxQnQqSYoleaDSaVa16?=
 =?us-ascii?Q?WzNaN+m0geQmpppJHVOqvXHTnau0mMoJjs74scbRqsczYl7P6uvzf6GFAYN/?=
 =?us-ascii?Q?dWNqfxO5DDod2yqxFXhREYmZcu+PADeKw3eA+Nn2DdzXurobcyeGbjs+0QKx?=
 =?us-ascii?Q?mDNlB5cjo2d5ZjD+3f/byUfHlkKxNVO+ymaoQSZIoxN7n1JeVp3CKEnaVGCd?=
 =?us-ascii?Q?b451Adkfc56X50EoeSvio7019fi7iZeujB8XnH3l0tUQSNzD3qY/cwtuo9Ps?=
 =?us-ascii?Q?PLt0FsrDHuR6/PnyWv1EQQQcKvfTuU4S63unQyH8UpqQyAnFTS8cNfbyrIbf?=
 =?us-ascii?Q?6ep0sGX2pWc7bSIB5nUNMsX5td3Nw3XkGhCFXxkrJxLyJSMXurG5wTLePJ75?=
 =?us-ascii?Q?emskMWBrb6XwrnwW1+vMMZBhC0F4B9Enn1pwa3vf93pT36WK9yyGvh9H6ciR?=
 =?us-ascii?Q?f6/iaIOUE8RBteQTlUQfRWC3UDS7RatPM5uS9Rr5M0qrqMlPgBp/fstU+x38?=
 =?us-ascii?Q?XGyDnd1qNysHe8JVfL7xOnEI9dFb00poTnRenoxkAWFD/BZJ7gCEqF5d42DJ?=
 =?us-ascii?Q?QvH8ju2jIgdGNp28m6BE3WZggYWD+vm1R7qW+DrqBsEJjUv6tTzvvjS3XrDk?=
 =?us-ascii?Q?nPubuUdTxaWtTbTiHteU5EvG21cY43jYDm9XSWiFlGCbD4kSyKUh+14P2p8A?=
 =?us-ascii?Q?AOWTb2bD+W9zxC4Q8hBLCuvckj120vzJqaUX1jJ+Vk5hodt2++KbYMmASjwY?=
 =?us-ascii?Q?WbWkkU9WA1P8sp2uHp3Hyo5d5BJAdZfC+s/k9NNC9khTLIl5LxDYVdoXvQdC?=
 =?us-ascii?Q?w2Qsbt2micKNa6C3ET5FScRwSaHxvV04/Uc+M3HmqtgVUJqnEnGb5Ak3AaTG?=
 =?us-ascii?Q?8Tah73dLgOF/aG121a9Xr4K1bM+2Lxf/kZ8mAPcKOKh/+hfvRuEwYm8PO53m?=
 =?us-ascii?Q?AdJSc0nGzhh/WRh8cm2BKXIhroaPMJL9TPrxPfTQLLI81hFbmF3+Qnn41wQ4?=
 =?us-ascii?Q?wEx9Krss9XOcmOUba08PXXTUOIlr7c2PLqxiqyOkBAN/cqRGxRmLaq55NCBO?=
 =?us-ascii?Q?ojOWFsOjsqHkLyHVs9HmsJ8tzShkxkUaR7V+SzYKTmbSzQ+1JWNmFw33G6ND?=
 =?us-ascii?Q?+YKleJUBrFdgKyKeB0ZNpkEHYhu6t5NaHBzgfI8qEvvWZvfVHTCmMZPVDdeJ?=
 =?us-ascii?Q?IWhRfpgKiraQ8u0vM9QjUfTbDx9oh4dYOTNevALzqS/CVCBoNLvtwTIejr4k?=
 =?us-ascii?Q?r+KDYQJdHRFQsWEPOi2KdxCg1nluRjcgMsPyI7P7vF8EL5hUdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:51:05.7064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 006ed9b0-b188-461b-0c50-08dcf54fe412
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731

This avoids a bigger trouble of exposing struct iommufd_device and struct
iommufd_vdevice in the public header.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        |  8 ++++++++
 drivers/iommu/iommufd/driver.c | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 0287a6d00192..dc174d02132b 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -184,6 +184,8 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type);
+struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
+				       unsigned long vdev_id);
 #else /* !CONFIG_IOMMUFD_DRIVER */
 static inline struct iommufd_object *
 _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
@@ -191,6 +193,12 @@ _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+static inline struct device *
+iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMUFD_DRIVER */
 
 /*
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index c0876d3f91c7..3604443f82a1 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -36,3 +36,16 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_object_alloc, IOMMUFD);
+
+/* Caller should xa_lock(&viommu->vdevs) to protect the return value */
+struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
+				       unsigned long vdev_id)
+{
+	struct iommufd_vdevice *vdev;
+
+	lockdep_is_held(&viommu->vdevs.xa_lock);
+
+	vdev = xa_load(&viommu->vdevs, vdev_id);
+	return vdev ? vdev->idev->dev : NULL;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_dev, IOMMUFD);
-- 
2.43.0


