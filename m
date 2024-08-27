Return-Path: <linux-kselftest+bounces-16444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56321961505
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B62B1C22E69
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90991D2780;
	Tue, 27 Aug 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K1SxQe2M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4F11D0DD4;
	Tue, 27 Aug 2024 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778168; cv=fail; b=CoQFBQic/C7tv7baAPAVpWpMf1KO1IgeR836FOKzdaDHZJe1ykPCd+IOT5Thn1JV1MymEFeVMNTUSL7wfZpOtVhWUgpV3Ebl6lZ5v9WYmrfvCdlKxkqrF6i5CkNFvc52PcS48G+YL9I3MSRcxUvueGUQS+8ckv8lzYhlWg6WM48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778168; c=relaxed/simple;
	bh=0zPDc0eXstWfn9WnSKwB1/jEflYiX+/xVqK3nT+7tck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cotWKhFHPTFDLA46L/yujC8K2K5kZMGh9JE+USd9CBlgKkTayZwGkPNP56iXVftWI3LVpORJ0FGKSTrHMETqclh4sRDtNpVCb1f96K94oqp7Bah/ybMVXv3h7ec+PojUs3Yv4vEtf+5K8ICNiApNzMplT7zQjDCHtBLG+SMZqmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K1SxQe2M; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9yjb6Kv+b3T23S9+h2Q0hlM+qCqImNQ5OUb+2c81b5PXfD1g2b8pw49OckzLxqrh7DkVFpeWFV/XZf9UwUIYbCBkRn1pe9fTEEpBbBQUMUkQ+mzaCWb3yzxarYDROD2M/NwLWFMz4CYQ85W1aSTGiSsd0/nciOSpUWQKZ2LK4zgblX7yMMG1ZuyU2i5bxUoQENDBanjVQX43FsXBdZJLPjFIx9gzbjFFAeA9/ScM6WuyOI2BLf9gjLF3EWNd82nFVftG3gG2RNGJTk88eOTPxj2269qt+qFKBxRJphT1j0ZRIMnVJGjD4IromyCpIqF1FQHYe3v7FHXF3t866hezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6R5S4Ae2wJoBk0qVZvDuyvm4tQyhiwaQ+mUvlc4Nh7g=;
 b=k2jDb9amIho6mOgXJoDcwlVE3pad5JcmMazOTbktEzu5Ifp62O8t6q717HfgFDg3L+1DhJvtB6iMWOPFjcvggYx8US+HbAkZ4blne5Y2/c2ngHiKFvUy83yixDAnqjK3Laf5RWd70Cy63BNp3GQEOJ0eFuiFLdK75gFlmVnUB03Pab27MD1HcbUCYbFflg7m7vouChL+8C5xlI36qMs9cn4L2m9x+XkWkTD/HO+Ogzb9dkpTRy7wCo4+a+LaKlcE6PW4pOsImjWpV249/HeQWq5QExtMJoCuboo5qswYyM4OYlacQjxuGmISDD7eEMK9Dhb9sJGmtRe3/rdNO/zaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6R5S4Ae2wJoBk0qVZvDuyvm4tQyhiwaQ+mUvlc4Nh7g=;
 b=K1SxQe2MmYBBanrqfFxD7cEOWmcxhlUQ5zPRXHpXwSasmpI7RUAZArEGwhtqHd+fSbSMMCfvK4g/+54ejoV5mL84zYjQU7/2A6uNoUblenjAHJ9BKbz1SC77MOAW6nlTzyi7+BWziMwGO8k54psjCtOHUUnG1JV1RMsAAkE8sRFHlyhB/1On3xbuMT8gBuNrzrRptS4cgj0shZmbXSCiVea9UraM6nWwUe45UpctgAKum0M5kMHSNj9Httr8CKcVPVrgjAZWzKLfgQR/Gfns/kmH2y3pzJbMyFz63VlUK3q0Z5AFQF4MEKJDsEySTu/IR7ACn5/QpicC9ATpx1GeHg==
Received: from PH7PR02CA0004.namprd02.prod.outlook.com (2603:10b6:510:33d::7)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 17:02:40 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:510:33d:cafe::fd) by PH7PR02CA0004.outlook.office365.com
 (2603:10b6:510:33d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:02:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:22 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:22 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:02:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v1 01/10] iommufd: Rename IOMMUFD_OBJ_FAULT to IOMMUFD_OBJ_EVENT_IOPF
Date: Tue, 27 Aug 2024 10:02:03 -0700
Message-ID: <546f9750aed1787fa2f39efbb13e47779a34963f.1724777091.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724777091.git.nicolinc@nvidia.com>
References: <cover.1724777091.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 637430da-b1fe-4b93-bada-08dcc6ba0d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CiaKp9k36vGGdnmK0D7H4paoCpXZyt7rGOk5I1qVN5lexdCC/KECA+Fu/ePH?=
 =?us-ascii?Q?WCyReuaOMl+Vs2AbSoi4PHe+LIR6ok7yHx3L9AHYBQ5zN5dL12v7hYlW/SSL?=
 =?us-ascii?Q?fOapkiGXslkXRjIvpjRVAYt4aNp4Fox2s4YSFvVvig3IABv0JCLEoaF4E77r?=
 =?us-ascii?Q?pL/VaSo7STmunQ0YYd3Sp8/ZNBTMe/14ynxG/MFaUKMNpL4c5WjhzuqN4TT+?=
 =?us-ascii?Q?DDnw/u42shog1IpthuUrRHWCOnPWL++6bWAg9UV4AANqkdsLfDwvzfCFmPDr?=
 =?us-ascii?Q?qCLcuS8rMvXCFnA2gwYiqF3RpmN5Cl005wAguQJ2UmtbKcK0+Vv40ZNps86h?=
 =?us-ascii?Q?DL2eREZRnHJQkf3lZAtwj+jitjozVTqYNNdw53NVhYvPAsHhyv+5yVLlPFvO?=
 =?us-ascii?Q?4tTSkdb/hA/BH5dSKjIr5rOZ7oR9tew9c88d01IlJxxfo/Yjts8YER0hp5+p?=
 =?us-ascii?Q?htgvBX5WKSPI2FHrSLv8G1yPXDEEPklIP99phdu68oGAlq7Uy1Z6o68vQeKk?=
 =?us-ascii?Q?y+AAtdl8jdoY68xF3BwFWziIrg0zHrnD0d8vIBGAAm9ZzvjQ+usQfVB2KpxG?=
 =?us-ascii?Q?5QO5eJORhcBDAYb9/D6KeRBbLoENQQVapyMjQpfoEMZMxMSj5sO58FXxDEKZ?=
 =?us-ascii?Q?llTjUBTSHpg8lp8uESyqsi0iTON8OrDoog0tuMIo7xj1VcwH33AwVhzhzoPL?=
 =?us-ascii?Q?Q0LWFuz1hZtHFTL1pi1CjSLthzFGMJqI3gmsKlfscdpD2jXmfnPplH0WVBQP?=
 =?us-ascii?Q?8p9pKJQ+3rD8f3czHLlaTHVi1l/f0FlOJRrTgoSysdO5kKgLwWkkR47OfPmg?=
 =?us-ascii?Q?L2+08Ogoy5n+J2fSb2s22o3c2djRazlP/rHNmZAhlZ1xF/hrenS+PJSlTRk8?=
 =?us-ascii?Q?OTHnw/JCiQEmLFHWsI/1Fla2oixvDdkJWVLah0jt99o7d0LKDwEuLs0D87st?=
 =?us-ascii?Q?OYX3zwZatOlwDp3w6ST9P+/jX8Y6098Eyav+dvk6Ui5gBGchiMhd8rDhx2BW?=
 =?us-ascii?Q?WW3icacOVE9e/CjIMtr3Yj6V1Yur3a/3viP9k7zL0j3BRadKlbG1tsgL6h98?=
 =?us-ascii?Q?62igB/+/VrW5ZrwhybvPBd2O3igm+JmhG3/iLRx6+bcuwtlcRQxiq0jDi1nR?=
 =?us-ascii?Q?SjIdQEUh3kURcJzrg+8ZXYQzcspNiwr9thyjVtoQNK0p9GY3KVeNrxLUqKSp?=
 =?us-ascii?Q?pP4nKtccrc3l9CEnyQx0ECNOKuSmDtUQeC1I7E0TC3POsihx8I2vTZi2KVDc?=
 =?us-ascii?Q?Y3UFUMnQPmCdAj+5R7UihAmQJiTDs2X2FPgZIX/fZzFmtUMvZc3NBZNQ/xGJ?=
 =?us-ascii?Q?07Rm5BGaPF1zOQ2ZSg+pLT8NOKE5VKsOYyrXRJNqfjYHrYyptGhpxZ7+hbFc?=
 =?us-ascii?Q?5aHlLmdApHRjey2SsIpC3/jSIqp+gT3mnOaAosGJE2EltdPTBv38VAUXIJf4?=
 =?us-ascii?Q?Fl3tF3FsfpipVGJCM6I7vQ8rX5zHkNBQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:37.1093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 637430da-b1fe-4b93-bada-08dcc6ba0d82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101

A fault object was designed exclusively for hwpt's IO page faults. But the
implementation of the object could actually be used for other purposes too
such as hardware IRQ and event.

Define a common event structure. Embed it into another iommufd_event_iopf,
similar to hwpt_paging holding a common hwpt.

Roll out a minimal level of renamings and abstractions. Add a common event
ops to prepare for IOMMUFD_OBJ_EVENT_VIRQ. Also move event handlers to the
header, which will be called by a viommu_api module for IOMMUFD_DRIVER.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/fault.c           | 270 +++++++++++++-----------
 drivers/iommu/iommufd/hw_pagetable.c    |  12 +-
 drivers/iommu/iommufd/iommufd_private.h |  87 +++++---
 drivers/iommu/iommufd/main.c            |   8 +-
 4 files changed, 224 insertions(+), 153 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index df03411c8728..8fea142e1ac2 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -16,7 +16,9 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
-static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
+/* IOMMUFD_OBJ_EVENT_IOPF Functions */
+
+static int iommufd_event_iopf_enable(struct iommufd_device *idev)
 {
 	struct device *dev = idev->dev;
 	int ret;
@@ -45,7 +47,7 @@ static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
 	return ret;
 }
 
-static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
+static void iommufd_event_iopf_disable(struct iommufd_device *idev)
 {
 	mutex_lock(&idev->iopf_lock);
 	if (!WARN_ON(idev->iopf_enabled == 0)) {
@@ -55,8 +57,8 @@ static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
 	mutex_unlock(&idev->iopf_lock);
 }
 
-static int __fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_device *idev)
+static int __event_iopf_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+					  struct iommufd_device *idev)
 {
 	struct iommufd_attach_handle *handle;
 	int ret;
@@ -74,37 +76,37 @@ static int __fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 	return ret;
 }
 
-int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
-				    struct iommufd_device *idev)
+int iommufd_event_iopf_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+					 struct iommufd_device *idev)
 {
 	int ret;
 
 	if (!hwpt->fault)
 		return -EINVAL;
 
-	ret = iommufd_fault_iopf_enable(idev);
+	ret = iommufd_event_iopf_enable(idev);
 	if (ret)
 		return ret;
 
-	ret = __fault_domain_attach_dev(hwpt, idev);
+	ret = __event_iopf_domain_attach_dev(hwpt, idev);
 	if (ret)
-		iommufd_fault_iopf_disable(idev);
+		iommufd_event_iopf_disable(idev);
 
 	return ret;
 }
 
-static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
-					 struct iommufd_attach_handle *handle)
+static void iommufd_event_iopf_auto_response(struct iommufd_hw_pagetable *hwpt,
+					     struct iommufd_attach_handle *handle)
 {
-	struct iommufd_fault *fault = hwpt->fault;
+	struct iommufd_event_iopf *fault = hwpt->fault;
 	struct iopf_group *group, *next;
 	unsigned long index;
 
 	if (!fault)
 		return;
 
-	mutex_lock(&fault->mutex);
-	list_for_each_entry_safe(group, next, &fault->deliver, node) {
+	mutex_lock(&fault->common.mutex);
+	list_for_each_entry_safe(group, next, &fault->common.deliver, node) {
 		if (group->attach_handle != &handle->handle)
 			continue;
 		list_del(&group->node);
@@ -119,7 +121,7 @@ static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
 	}
-	mutex_unlock(&fault->mutex);
+	mutex_unlock(&fault->common.mutex);
 }
 
 static struct iommufd_attach_handle *
@@ -134,21 +136,21 @@ iommufd_device_get_attach_handle(struct iommufd_device *idev)
 	return to_iommufd_handle(handle);
 }
 
-void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_device *idev)
+void iommufd_event_iopf_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
+					  struct iommufd_device *idev)
 {
 	struct iommufd_attach_handle *handle;
 
 	handle = iommufd_device_get_attach_handle(idev);
 	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
-	iommufd_auto_response_faults(hwpt, handle);
-	iommufd_fault_iopf_disable(idev);
+	iommufd_event_iopf_auto_response(hwpt, handle);
+	iommufd_event_iopf_disable(idev);
 	kfree(handle);
 }
 
-static int __fault_domain_replace_dev(struct iommufd_device *idev,
-				      struct iommufd_hw_pagetable *hwpt,
-				      struct iommufd_hw_pagetable *old)
+static int __event_iopf_domain_replace_dev(struct iommufd_device *idev,
+					   struct iommufd_hw_pagetable *hwpt,
+					   struct iommufd_hw_pagetable *old)
 {
 	struct iommufd_attach_handle *handle, *curr = NULL;
 	int ret;
@@ -171,43 +173,44 @@ static int __fault_domain_replace_dev(struct iommufd_device *idev,
 	}
 
 	if (!ret && curr) {
-		iommufd_auto_response_faults(old, curr);
+		iommufd_event_iopf_auto_response(old, curr);
 		kfree(curr);
 	}
 
 	return ret;
 }
 
-int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
-				     struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_hw_pagetable *old)
+int iommufd_event_iopf_domain_replace_dev(struct iommufd_device *idev,
+					  struct iommufd_hw_pagetable *hwpt,
+					  struct iommufd_hw_pagetable *old)
 {
 	bool iopf_off = !hwpt->fault && old->fault;
 	bool iopf_on = hwpt->fault && !old->fault;
 	int ret;
 
 	if (iopf_on) {
-		ret = iommufd_fault_iopf_enable(idev);
+		ret = iommufd_event_iopf_enable(idev);
 		if (ret)
 			return ret;
 	}
 
-	ret = __fault_domain_replace_dev(idev, hwpt, old);
+	ret = __event_iopf_domain_replace_dev(idev, hwpt, old);
 	if (ret) {
 		if (iopf_on)
-			iommufd_fault_iopf_disable(idev);
+			iommufd_event_iopf_disable(idev);
 		return ret;
 	}
 
 	if (iopf_off)
-		iommufd_fault_iopf_disable(idev);
+		iommufd_event_iopf_disable(idev);
 
 	return 0;
 }
 
-void iommufd_fault_destroy(struct iommufd_object *obj)
+void iommufd_event_iopf_destroy(struct iommufd_object *obj)
 {
-	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
+	struct iommufd_event *event =
+		container_of(obj, struct iommufd_event, obj);
 	struct iopf_group *group, *next;
 
 	/*
@@ -216,17 +219,17 @@ void iommufd_fault_destroy(struct iommufd_object *obj)
 	 * accessing this pointer. Therefore, acquiring the mutex here
 	 * is unnecessary.
 	 */
-	list_for_each_entry_safe(group, next, &fault->deliver, node) {
+	list_for_each_entry_safe(group, next, &event->deliver, node) {
 		list_del(&group->node);
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
 	}
 }
 
-static void iommufd_compose_fault_message(struct iommu_fault *fault,
-					  struct iommu_hwpt_pgfault *hwpt_fault,
-					  struct iommufd_device *idev,
-					  u32 cookie)
+static void iommufd_compose_iopf_message(struct iommu_fault *fault,
+					 struct iommu_hwpt_pgfault *hwpt_fault,
+					 struct iommufd_device *idev,
+					 u32 cookie)
 {
 	hwpt_fault->flags = fault->prm.flags;
 	hwpt_fault->dev_id = idev->obj.id;
@@ -238,11 +241,12 @@ static void iommufd_compose_fault_message(struct iommu_fault *fault,
 	hwpt_fault->cookie = cookie;
 }
 
-static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
-				       size_t count, loff_t *ppos)
+static ssize_t iommufd_event_iopf_fops_read(struct iommufd_event *event,
+					    char __user *buf, size_t count,
+					    loff_t *ppos)
 {
+	struct iommufd_event_iopf *fault = to_event_iopf(event);
 	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
-	struct iommufd_fault *fault = filep->private_data;
 	struct iommu_hwpt_pgfault data;
 	struct iommufd_device *idev;
 	struct iopf_group *group;
@@ -253,9 +257,9 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 	if (*ppos || count % fault_size)
 		return -ESPIPE;
 
-	mutex_lock(&fault->mutex);
-	while (!list_empty(&fault->deliver) && count > done) {
-		group = list_first_entry(&fault->deliver,
+	mutex_lock(&event->mutex);
+	while (!list_empty(&event->deliver) && count > done) {
+		group = list_first_entry(&event->deliver,
 					 struct iopf_group, node);
 
 		if (group->fault_count * fault_size > count - done)
@@ -268,9 +272,8 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 
 		idev = to_iommufd_handle(group->attach_handle)->idev;
 		list_for_each_entry(iopf, &group->faults, list) {
-			iommufd_compose_fault_message(&iopf->fault,
-						      &data, idev,
-						      group->cookie);
+			iommufd_compose_iopf_message(&iopf->fault, &data,
+						     idev, group->cookie);
 			if (copy_to_user(buf + done, &data, fault_size)) {
 				xa_erase(&fault->response, group->cookie);
 				rc = -EFAULT;
@@ -281,16 +284,17 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 
 		list_del(&group->node);
 	}
-	mutex_unlock(&fault->mutex);
+	mutex_unlock(&event->mutex);
 
 	return done == 0 ? rc : done;
 }
 
-static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t iommufd_event_iopf_fops_write(struct iommufd_event *event,
+					     const char __user *buf,
+					     size_t count, loff_t *ppos)
 {
 	size_t response_size = sizeof(struct iommu_hwpt_page_response);
-	struct iommufd_fault *fault = filep->private_data;
+	struct iommufd_event_iopf *fault = to_event_iopf(event);
 	struct iommu_hwpt_page_response response;
 	struct iopf_group *group;
 	size_t done = 0;
@@ -299,7 +303,7 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 	if (*ppos || count % response_size)
 		return -ESPIPE;
 
-	mutex_lock(&fault->mutex);
+	mutex_lock(&event->mutex);
 	while (count > done) {
 		rc = copy_from_user(&response, buf + done, response_size);
 		if (rc)
@@ -325,119 +329,149 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 		iopf_free_group(group);
 		done += response_size;
 	}
-	mutex_unlock(&fault->mutex);
+	mutex_unlock(&event->mutex);
 
 	return done == 0 ? rc : done;
 }
 
-static __poll_t iommufd_fault_fops_poll(struct file *filep,
+static const struct iommufd_event_ops iommufd_event_iopf_ops = {
+	.read = &iommufd_event_iopf_fops_read,
+	.write = &iommufd_event_iopf_fops_write,
+};
+
+/* Common Event Functions */
+
+static ssize_t iommufd_event_fops_read(struct file *filep, char __user *buf,
+				       size_t count, loff_t *ppos)
+{
+	struct iommufd_event *event = filep->private_data;
+
+	if (!event->ops || !event->ops->read)
+		return -EOPNOTSUPP;
+	return event->ops->read(event, buf, count, ppos);
+}
+
+static ssize_t iommufd_event_fops_write(struct file *filep,
+					const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct iommufd_event *event = filep->private_data;
+
+	if (!event->ops || !event->ops->write)
+		return -EOPNOTSUPP;
+	return event->ops->write(event, buf, count, ppos);
+}
+
+static __poll_t iommufd_event_fops_poll(struct file *filep,
 					struct poll_table_struct *wait)
 {
-	struct iommufd_fault *fault = filep->private_data;
+	struct iommufd_event *event = filep->private_data;
 	__poll_t pollflags = EPOLLOUT;
 
-	poll_wait(filep, &fault->wait_queue, wait);
-	mutex_lock(&fault->mutex);
-	if (!list_empty(&fault->deliver))
+	poll_wait(filep, &event->wait_queue, wait);
+	mutex_lock(&event->mutex);
+	if (!list_empty(&event->deliver))
 		pollflags |= EPOLLIN | EPOLLRDNORM;
-	mutex_unlock(&fault->mutex);
+	mutex_unlock(&event->mutex);
 
 	return pollflags;
 }
 
-static int iommufd_fault_fops_release(struct inode *inode, struct file *filep)
+static void iommufd_event_deinit(struct iommufd_event *event)
 {
-	struct iommufd_fault *fault = filep->private_data;
+	refcount_dec(&event->obj.users);
+	iommufd_ctx_put(event->ictx);
+	mutex_destroy(&event->mutex);
+}
 
-	refcount_dec(&fault->obj.users);
-	iommufd_ctx_put(fault->ictx);
+static int iommufd_event_fops_release(struct inode *inode, struct file *filep)
+{
+	iommufd_event_deinit((struct iommufd_event *)filep->private_data);
 	return 0;
 }
 
-static const struct file_operations iommufd_fault_fops = {
+static const struct file_operations iommufd_event_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nonseekable_open,
-	.read		= iommufd_fault_fops_read,
-	.write		= iommufd_fault_fops_write,
-	.poll		= iommufd_fault_fops_poll,
-	.release	= iommufd_fault_fops_release,
+	.read		= iommufd_event_fops_read,
+	.write		= iommufd_event_fops_write,
+	.poll		= iommufd_event_fops_poll,
+	.release	= iommufd_event_fops_release,
 	.llseek		= no_llseek,
 };
 
-int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
+static int iommufd_event_init(struct iommufd_event *event, char *name,
+			      struct iommufd_ctx *ictx, int *out_fdno,
+			      const struct iommufd_event_ops *ops)
 {
-	struct iommu_fault_alloc *cmd = ucmd->cmd;
-	struct iommufd_fault *fault;
 	struct file *filep;
 	int fdno;
+
+	event->ops = ops;
+	event->ictx = ictx;
+	INIT_LIST_HEAD(&event->deliver);
+	mutex_init(&event->mutex);
+	init_waitqueue_head(&event->wait_queue);
+
+	filep = anon_inode_getfile(name, &iommufd_event_fops,
+				   event, O_RDWR);
+	if (IS_ERR(filep))
+		return PTR_ERR(filep);
+
+	refcount_inc(&event->obj.users);
+	iommufd_ctx_get(event->ictx);
+	event->filep = filep;
+
+	fdno = get_unused_fd_flags(O_CLOEXEC);
+	if (fdno < 0) {
+		fput(filep);
+		iommufd_event_deinit(event);
+		return fdno;
+	}
+	if (out_fdno)
+		*out_fdno = fdno;
+	return 0;
+}
+
+int iommufd_event_iopf_alloc(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_fault_alloc *cmd = ucmd->cmd;
+	struct iommufd_event_iopf *event_iopf;
+	int fdno;
 	int rc;
 
 	if (cmd->flags)
 		return -EOPNOTSUPP;
 
-	fault = iommufd_object_alloc(ucmd->ictx, fault, IOMMUFD_OBJ_FAULT);
-	if (IS_ERR(fault))
-		return PTR_ERR(fault);
+	event_iopf = __iommufd_object_alloc(ucmd->ictx, event_iopf,
+					    IOMMUFD_OBJ_EVENT_IOPF, common.obj);
+	if (IS_ERR(event_iopf))
+		return PTR_ERR(event_iopf);
 
-	fault->ictx = ucmd->ictx;
-	INIT_LIST_HEAD(&fault->deliver);
-	xa_init_flags(&fault->response, XA_FLAGS_ALLOC1);
-	mutex_init(&fault->mutex);
-	init_waitqueue_head(&fault->wait_queue);
+	xa_init_flags(&event_iopf->response, XA_FLAGS_ALLOC1);
 
-	filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
-				   fault, O_RDWR);
-	if (IS_ERR(filep)) {
-		rc = PTR_ERR(filep);
+	rc = iommufd_event_init(&event_iopf->common, "[iommufd-pgfault]",
+				ucmd->ictx, &fdno, &iommufd_event_iopf_ops);
+	if (rc)
 		goto out_abort;
-	}
-
-	refcount_inc(&fault->obj.users);
-	iommufd_ctx_get(fault->ictx);
-	fault->filep = filep;
 
-	fdno = get_unused_fd_flags(O_CLOEXEC);
-	if (fdno < 0) {
-		rc = fdno;
-		goto out_fput;
-	}
-
-	cmd->out_fault_id = fault->obj.id;
+	cmd->out_fault_id = event_iopf->common.obj.id;
 	cmd->out_fault_fd = fdno;
 
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
 		goto out_put_fdno;
-	iommufd_object_finalize(ucmd->ictx, &fault->obj);
+	iommufd_object_finalize(ucmd->ictx, &event_iopf->common.obj);
 
-	fd_install(fdno, fault->filep);
+	fd_install(fdno, event_iopf->common.filep);
 
 	return 0;
 out_put_fdno:
 	put_unused_fd(fdno);
-out_fput:
-	fput(filep);
-	refcount_dec(&fault->obj.users);
-	iommufd_ctx_put(fault->ictx);
+	fput(event_iopf->common.filep);
+	iommufd_event_deinit(&event_iopf->common);
 out_abort:
-	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->obj);
+	iommufd_object_abort_and_destroy(ucmd->ictx, &event_iopf->common.obj);
 
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
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 6aaec1b32abc..ca5c003a02da 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -14,7 +14,7 @@ static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
 		iommu_domain_free(hwpt->domain);
 
 	if (hwpt->fault)
-		refcount_dec(&hwpt->fault->obj.users);
+		refcount_dec(&hwpt->fault->common.obj.users);
 }
 
 void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
@@ -342,18 +342,18 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	}
 
 	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
-		struct iommufd_fault *fault;
+		struct iommufd_event_iopf *fault;
 
-		fault = iommufd_get_fault(ucmd, cmd->fault_id);
+		fault = iommufd_get_event_iopf(ucmd, cmd->fault_id);
 		if (IS_ERR(fault)) {
 			rc = PTR_ERR(fault);
 			goto out_hwpt;
 		}
 		hwpt->fault = fault;
-		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
+		hwpt->domain->iopf_handler = iommufd_event_iopf_handler;
 		hwpt->domain->fault_data = hwpt;
-		refcount_inc(&fault->obj.users);
-		iommufd_put_object(ucmd->ictx, &fault->obj);
+		refcount_inc(&fault->common.obj.users);
+		iommufd_put_object(ucmd->ictx, &fault->common.obj);
 	}
 
 	cmd->out_hwpt_id = hwpt->obj.id;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 7831b0ca6528..c22d72c981c7 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -19,6 +19,7 @@ struct iommu_domain;
 struct iommu_group;
 struct iommu_option;
 struct iommufd_device;
+struct iommufd_event;
 
 struct iommufd_ctx {
 	struct file *file;
@@ -131,7 +132,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_HWPT_NESTED,
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
-	IOMMUFD_OBJ_FAULT,
+	IOMMUFD_OBJ_EVENT_IOPF,
 	IOMMUFD_OBJ_VIOMMU,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
@@ -297,7 +298,7 @@ int iommufd_check_iova_range(struct io_pagetable *iopt,
 struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
 	struct iommu_domain *domain;
-	struct iommufd_fault *fault;
+	struct iommufd_event_iopf *fault;
 };
 
 struct iommufd_hwpt_paging {
@@ -456,24 +457,42 @@ void iopt_remove_access(struct io_pagetable *iopt,
 			u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
+struct iommufd_event_ops {
+	ssize_t (*read)(struct iommufd_event *event, char __user *buf,
+			size_t count, loff_t *ppos);
+	ssize_t (*write)(struct iommufd_event *event, const char __user *buf,
+			size_t count, loff_t *ppos);
+};
+
 /*
- * An iommufd_fault object represents an interface to deliver I/O page faults
- * to the user space. These objects are created/destroyed by the user space and
- * associated with hardware page table objects during page-table allocation.
+ * An iommufd_event object represents an interface to deliver IOMMU events
+ * to the user space. These objects are created/destroyed by the user space.
  */
-struct iommufd_fault {
+struct iommufd_event {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct file *filep;
 
-	/* The lists of outstanding faults protected by below mutex. */
+	const struct iommufd_event_ops *ops;
+
+	/* The lists of outstanding events protected by below mutex. */
 	struct mutex mutex;
 	struct list_head deliver;
-	struct xarray response;
 
 	struct wait_queue_head wait_queue;
 };
 
+static inline int iommufd_event_notify(struct iommufd_event *event,
+				       struct list_head *node)
+{
+	mutex_lock(&event->mutex);
+	list_add_tail(node, &event->deliver);
+	mutex_unlock(&event->mutex);
+
+	wake_up_interruptible(&event->wait_queue);
+	return 0;
+}
+
 struct iommufd_attach_handle {
 	struct iommu_attach_handle handle;
 	struct iommufd_device *idev;
@@ -482,31 +501,49 @@ struct iommufd_attach_handle {
 /* Convert an iommu attach handle to iommufd handle. */
 #define to_iommufd_handle(hdl)	container_of(hdl, struct iommufd_attach_handle, handle)
 
-static inline struct iommufd_fault *
-iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
+struct iommufd_event_iopf {
+	struct iommufd_event common;
+	struct xarray response;
+};
+
+static inline struct iommufd_event_iopf *
+to_event_iopf(struct iommufd_event *event)
+{
+	return container_of(event, struct iommufd_event_iopf, common);
+}
+
+static inline struct iommufd_event_iopf *
+iommufd_get_event_iopf(struct iommufd_ucmd *ucmd, u32 id)
 {
 	return container_of(iommufd_get_object(ucmd->ictx, id,
-					       IOMMUFD_OBJ_FAULT),
-			    struct iommufd_fault, obj);
+					       IOMMUFD_OBJ_EVENT_IOPF),
+			    struct iommufd_event_iopf, common.obj);
 }
 
-int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
-void iommufd_fault_destroy(struct iommufd_object *obj);
-int iommufd_fault_iopf_handler(struct iopf_group *group);
+int iommufd_event_iopf_alloc(struct iommufd_ucmd *ucmd);
+void iommufd_event_iopf_destroy(struct iommufd_object *obj);
+
+static inline int iommufd_event_iopf_handler(struct iopf_group *group)
+{
+	struct iommufd_hw_pagetable *hwpt =
+		group->attach_handle->domain->fault_data;
+
+	return iommufd_event_notify(&hwpt->fault->common, &group->node);
+}
 
-int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
-				    struct iommufd_device *idev);
-void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_device *idev);
-int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
-				     struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_hw_pagetable *old);
+int iommufd_event_iopf_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+					 struct iommufd_device *idev);
+void iommufd_event_iopf_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
+					  struct iommufd_device *idev);
+int iommufd_event_iopf_domain_replace_dev(struct iommufd_device *idev,
+					  struct iommufd_hw_pagetable *hwpt,
+					  struct iommufd_hw_pagetable *old);
 
 static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 					     struct iommufd_device *idev)
 {
 	if (hwpt->fault)
-		return iommufd_fault_domain_attach_dev(hwpt, idev);
+		return iommufd_event_iopf_domain_attach_dev(hwpt, idev);
 
 	return iommu_attach_group(hwpt->domain, idev->igroup->group);
 }
@@ -515,7 +552,7 @@ static inline void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 					      struct iommufd_device *idev)
 {
 	if (hwpt->fault)
-		iommufd_fault_domain_detach_dev(hwpt, idev);
+		iommufd_event_iopf_domain_detach_dev(hwpt, idev);
 
 	iommu_detach_group(hwpt->domain, idev->igroup->group);
 }
@@ -525,7 +562,7 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 					      struct iommufd_hw_pagetable *old)
 {
 	if (old->fault || hwpt->fault)
-		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
+		return iommufd_event_iopf_domain_replace_dev(idev, hwpt, old);
 
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 199ad90fa36b..015f492afab1 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -359,8 +359,8 @@ struct iommufd_ioctl_op {
 	}
 static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
-	IOCTL_OP(IOMMU_FAULT_QUEUE_ALLOC, iommufd_fault_alloc, struct iommu_fault_alloc,
-		 out_fault_fd),
+	IOCTL_OP(IOMMU_FAULT_QUEUE_ALLOC, iommufd_event_iopf_alloc,
+		 struct iommu_fault_alloc, out_fault_fd),
 	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
@@ -525,8 +525,8 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 		.destroy = iommufd_hwpt_nested_destroy,
 		.abort = iommufd_hwpt_nested_abort,
 	},
-	[IOMMUFD_OBJ_FAULT] = {
-		.destroy = iommufd_fault_destroy,
+	[IOMMUFD_OBJ_EVENT_IOPF] = {
+		.destroy = iommufd_event_iopf_destroy,
 	},
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,
-- 
2.43.0


