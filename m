Return-Path: <linux-kselftest+bounces-25145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FA5A1BFBC
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 01:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD6E189016B
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 00:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACA23FBA5;
	Sat, 25 Jan 2025 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mCL3jWE0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE192C187;
	Sat, 25 Jan 2025 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765081; cv=fail; b=UL5vj6H9kuFmPDz/+xphUtn86REbN2RujgYDkNqxmer+bZfGnC6NeFmijCIlRHaTtSv/nEKIlmZuEQAJzRcaoZgWxca0fktSSHVaoG9VhU7E7BdrduYXiXcmx1529uzL2x5VFc1d1PNPkyAo4AL1nXFFduyrjkFvN9lgf41nEKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765081; c=relaxed/simple;
	bh=9zSoB2eufFSl15Go1DfhZpHZPgd5ca3IXD9rz1UZufU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbMt7HsT5PK2ZfVBUXCjp0p3g4cazRMg9DqaLEWS84LMk4bipdOrXsed+zujzTaNrZFjzA1h2IeqrcdLFyiH9UoJfS1S5bkpZ05gjK+aCVlYU2ljLljIq4u7aK5u6Tlc3CzLxQT9oIDKz7GdzineM4a5FFazzbo4ICeDlNRn+IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mCL3jWE0; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIY7Dw9NGgAec9cnS4mCI3oAEcxj35Sma5EoRNGE+Qnj7LEurlawcUaVxfdfbd1YVuUW3dfwZGmqq5SMqioU66DTMgdTtJkhWHoxxh/XjcRDuZpSkCH0VstJ2WwhbF/ypSLohSX7E7GgJXc3sOLlJa/YMQnY+S0kigjMHjwEOunHjOyKqLaH9xZoya71mFVZXTH72u4/nMaCsbZ0IFT9+20NA/g3SaKfr/lAt2Cu7AQp5CRf21lx7n7YdZ9Dj246lwv7f4Sgy6CJ8J75xl0jJhdV3xsMRTs6qGaV32tTdmzdo1e2Ck5TMP9qX9CCEfFZDSZNceV2qy6M9on1wQGQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCKCI0clBzhbwowoftXjIXcxrk8wiLXReTpYiTryBRk=;
 b=gKzAuUpYYBGCDMOLPGvtH4YnLGtug8KrVW7w4VT4slAmUza8RMAG0/uV4F7N7BfGvSlRAXomqUCFBYdlz4qfPiIw4EFYkfwR2eT7RK67jhPRIO5vsuXMFad7QVqggWztGz3ihKzirhs5yYPa/7tr3JiEgUUdc9CGFXcbeNrnhrr55feZU1aX6+vRhmU9JmpjkKZYXgx7KaakONCxCkuaxAbIfoZut867eVOTUflLGB083fSg4H9Qt8PZ+C6swDisHfLcAAEt9kEbyrQkV/AqtU5siTXo4EQlBYCUXR8c51nHzWSWBo0pObErYP7NcNcLQEKu5sfVlq/1aV1JgRTlHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCKCI0clBzhbwowoftXjIXcxrk8wiLXReTpYiTryBRk=;
 b=mCL3jWE01+8psnOKaCnmBU/ZoSxZ7FGPvN0Wjtx/Z+N/v0DET7/dX00geqTlLmnexQmNfGSABqX0yR4KFCgl5mcMtfFAZ5fN8OkyxfHfzDv08xKc0JxIbEAjsnWi+xnNcn6Ev1X5AN5fyR+UxcZQbGgmQ3Zwk+ACe1MWOVcc9tVZSLZm8kg49wxGWdy9QJkpdx+x59AfpVkNXQYgbR0Rdiu84lVDf4O1FcSNRj8bw7F9VdhRLJQ8ofDk0t6Yxrx/OTkDFPfWS5dOhB779QYTiS2XrDLVSfACOUp3WkjGUDpIumLej8FFLjYJ+XGoksyrH37LRrQ35L4IwQWISx/TjA==
Received: from IA1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::14)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Sat, 25 Jan
 2025 00:31:12 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:461:cafe::b5) by IA1P220CA0008.outlook.office365.com
 (2603:10b6:208:461::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.19 via Frontend Transport; Sat,
 25 Jan 2025 00:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sat, 25 Jan 2025 00:31:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 16:31:00 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 24 Jan 2025 16:31:00 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 24 Jan 2025 16:30:59 -0800
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
Subject: [PATCH v6 06/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id helper
Date: Fri, 24 Jan 2025 16:30:35 -0800
Message-ID: <313a27d92bd63e9571bf0f053eabfc3bfe4bfbae.1737754129.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: 46df477d-9e09-458c-7749-08dd3cd7925b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lGoKMMS6t2iaiHdVQjKNSXDgLAsvLD2nYUSVdQG5AGik/iGJ1bt0skHzrEhu?=
 =?us-ascii?Q?djc0GAlqJ1CXD8/tDqgDxK2Gq9zDtm74lcmUq7r+VDNO0WYDXira+5Jfdxc7?=
 =?us-ascii?Q?1utUEbg1C2yzHXd61pcnxJSqdD8ItFrwTO2EwiLPTvu7p67SWvV9Zr/IW/BF?=
 =?us-ascii?Q?FxxX4XCSH5PMnnkQAnNIczAKOYY/sryGwiYoyJWDNarnrm5VooM0LWtfuYS8?=
 =?us-ascii?Q?j2cmaQBNWRBQGPZ7Y3bCg5/3syG35IhYa+WYOzIpzmHMik2I5c7tvBbSsPdj?=
 =?us-ascii?Q?VD8i8Jtvt6p84EvMxaG77PxeTuXTYxNXrxppmm6Cm32bsd8R8XNjmhlRrSmX?=
 =?us-ascii?Q?DpZtA03dcl7ARuLRtR0OjPy+HiXaYYAie4ywroSmbEpbv6RkfSL1UhFp4idF?=
 =?us-ascii?Q?lweYidAHAbESeEctcDOG5EUZ4SQ7nccrq7vqqGfPhwct6XhTh9NrfyhuDVdT?=
 =?us-ascii?Q?QrTxiZRuyDMjREd57tlyFIUpjcq1CwQ76Z5/16k5motzpeS4KPvF9in5blXc?=
 =?us-ascii?Q?AJHLHBy1pGy0oYekeeBicA109ztf6pY62UqVWSVnnmA4/VGiGOHAAIfR+JHE?=
 =?us-ascii?Q?h18EEIX35q7jI+tKoVa0533d/yoJEJxjPjJq6gW1w4yHw0nYDM6CB9qrWcb/?=
 =?us-ascii?Q?ULnVKtKS2Igq8gixDAU2iwgxLJSz802Is929+1txcrGEV2S0sWK4jaq6aIB9?=
 =?us-ascii?Q?uGv7V/OPEamVg1VcfsTzWyff3WMf6wOke+Tf3dj1tNAATb5GTwKHGlXsqUVy?=
 =?us-ascii?Q?+FWP6B9NqqtWsPHeDEd+QY610jDrhadvxp4AEQtoKJJ/nx/pXPqHMZEWZVkV?=
 =?us-ascii?Q?97TGcim/yGcNxsrDWSiWi2lTbq+Th7aFNhtLMvJ6KFmjBCwtj2P1fBUrGxcM?=
 =?us-ascii?Q?flpA3AUDCl7KTHNIN/B6mv4FEObjQOwH9e3dUuvHRBeChHBMYIIjb8vOSQ+a?=
 =?us-ascii?Q?PedELVbYHEdDYxgjce/pCDICXRHBzd4Z4FX3MaM+2WritRaf5fA9OIve9zqQ?=
 =?us-ascii?Q?DieA0g4OUsvtiLeEbb/jzMl6C66dj9PNMaCvAvIYe0wbH9GnT9Sa6+LvEx29?=
 =?us-ascii?Q?wo7dGAkYn8A691096ugUO1s+AtJp3muNyKpcjAf+Wr6xAwpCU/Zlfd4z3C9r?=
 =?us-ascii?Q?hy+icgsiAtApq34yvQpLQSSqLs23SncN/ANsaV/X62Fa/CW4qhJHuzDYtc+a?=
 =?us-ascii?Q?RZDAITFMDRByV6U0kAc6JzT13BBTjfSmIrQYTFeNtHUTa0Ij85W8M+dpiMO2?=
 =?us-ascii?Q?mCvSl/CuIAf+dXWkxEgF82OA1pil33Pj/Kav+Ugm6V1sgOe29ES9T1RQI3HU?=
 =?us-ascii?Q?idoVw/nB275qY9a27r9I+QJWYEI7XiczQ/fe3m2Wrj2wEYIB52PLu/2hE4LM?=
 =?us-ascii?Q?Dl0jT3tnNLITgHC1MlZ1CCk4sHgzPrjAvkGM0wsWj83a0pLLpdXbo7VXFYId?=
 =?us-ascii?Q?8LPMXYnfRBwu255koeddsyksicsjZNfpFjznmJQM3BMG+gYmXSHlw2NirnJf?=
 =?us-ascii?Q?rrzfVi+tjVKqUf0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 00:31:12.5706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46df477d-9e09-458c-7749-08dd3cd7925b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120

This is a reverse search v.s. iommufd_viommu_find_dev, as drivers may want
to convert a struct device pointer (physical) to its virtual device ID for
an event injection to the user space VM.

Again, this avoids exposing more core structures to the drivers, than the
iommufd_viommu alone.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        |  9 +++++++++
 drivers/iommu/iommufd/driver.c | 24 ++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 8948b1836940..05cb393aff0a 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -190,6 +190,8 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     enum iommufd_object_type type);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
+int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
+			       struct device *dev, unsigned long *vdev_id);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE */
 static inline struct iommufd_object *
 _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
@@ -203,6 +205,13 @@ iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
 	return NULL;
 }
+
+static inline int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
+					     struct device *dev,
+					     unsigned long *vdev_id)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_IOMMUFD_DRIVER_CORE */
 
 /*
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 2d98b04ff1cb..185c4fde8987 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -49,5 +49,29 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_dev, "IOMMUFD");
 
+/* Return -ENOENT if device is not associated to the vIOMMU */
+int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
+			       struct device *dev, unsigned long *vdev_id)
+{
+	struct iommufd_vdevice *vdev;
+	unsigned long index;
+	int rc = -ENOENT;
+
+	if (WARN_ON_ONCE(!vdev_id))
+		return -EINVAL;
+
+	xa_lock(&viommu->vdevs);
+	xa_for_each(&viommu->vdevs, index, vdev) {
+		if (vdev->dev == dev) {
+			*vdev_id = (unsigned long)vdev->id;
+			rc = 0;
+			break;
+		}
+	}
+	xa_unlock(&viommu->vdevs);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_viommu_get_vdev_id, "IOMMUFD");
+
 MODULE_DESCRIPTION("iommufd code shared with builtin modules");
 MODULE_LICENSE("GPL");
-- 
2.43.0


