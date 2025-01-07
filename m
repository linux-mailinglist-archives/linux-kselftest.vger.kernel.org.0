Return-Path: <linux-kselftest+bounces-24014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B895A047B4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DE43A04E9
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325871F4E48;
	Tue,  7 Jan 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KP88pLDF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CA61F2C41;
	Tue,  7 Jan 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269859; cv=fail; b=TahdfLhNtF5hn82YByW90wqFxyBIn4ieLXVD043W2A2i5wv/XCUbRw9+UlA71KIX335fClQSpmuHqdo3BeNOqVksXIFzdlw2kCaUqmAkMT0AcGXWfQJsTnzm9/oE1eUaxjWrHxwaLttQppIqWKYJ5FnKLLtEw2izC0YDiR83JPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269859; c=relaxed/simple;
	bh=o9Pyv0mKP4z2lyTIgX1VvX0yuILY67DG+HNR4/xva9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHGxwpyupiLUGo3Z8pvqFxX1FoBxY36l3FMH4/+6dzlCThhmNQI9bzDzlSD2GCkufHpdGYBNhdxpUA3JOyY6eH3WgbWToqSuJrnHLaRyMM5gEJ/T5+D0161t7hvf4M6LhKsoexnsiCu9PZaLcObDaCbP+WIw4wauI67p8POhu+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KP88pLDF; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiU/pHlveGp3/Vn+vpiAV8yx2QBXXyLpPqJzE+i+PpS1BGLO6o4JZ19Y6HmJOZ+J6i5sdm680y13rf1Lv6MY5B4yYKJ46kcjhmL3MU41JwedrDSjGcOffPF4vBG8Hpg2GuQdraKchEylH6iPgqPe1jI0usSYsQpaIxmLdsCiWltDn5xV4pfcBzDrsTB+K70TYXPAf2LOQzQmNHLF1/Td7CZq2nwHAYi9qL3AxzCy3ISLK4PoECcW0SxwTvjopvX8oQ8XhLOXaLO7PsbdQke2IzW94SYC9Etiu+zeAA/T6/HdB9uvX7dxyVBDRgkLCllUiBREeHnzJg9hjfEWr4L3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07+ogLYIaTskzPijN/RbveIYZKxErYwRT1XyX+bN7xo=;
 b=J4T3WLYJLoDbHSW90QOftxi3xcLHr7EjZQJSnw78mmZ8BYt+eYbJaYcLy52w6k8mnI1CtjdB2jz9l9tP2Vp8g5E+zz2h/SMA9uFkZ9IZ2Af9sxJFl2mI2BHZBNk2Rs8iNmDDKN/iSAtt58dus4w8i3yiDaVAN1vF2LnLg5kGZc4bEOSX58W6e5sPVbOVLJOzN9tciaOtxpe9JLw13OnTAY8iEg+D6hYiU9XkMPWqZP8DiWYfWui5/9xb/mC3VBTDNnWQebHOuyMF8o1SNglaijzPN79ffMoq84W1mPD+oHN8EbocV+l7rVVRFmcdLPqhorgR5TS2fa3yu/YBaWvMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07+ogLYIaTskzPijN/RbveIYZKxErYwRT1XyX+bN7xo=;
 b=KP88pLDFdZBeQmEDWIgoc4dLiGohERLoPJQrHneVketl4Y5/3yoaDADm7NVkcdmJKV5B2rArcmAgZ+76Vem2DfQpapNCScmZyBy8v/i4ah9g05hRyV6lQGbijcNfkMJcDfTcd1JuSdXRBojgcyRRLbSA+ZCaHw1gio5gKxjU7gdpc5olLD0Y03Vl8evKgSh2zldGFfmAi4iBrgaque6T0ne2/D+atGYP0d0gX+G38WrhgJH2cflhn+FxshE4x3Ei6kVTgVeB+5eiCybNJiRKn4ai7XU7M6Xn5gg5AU88OysV8FfDiJwzCPLr5adNmAWbqf8hnvD8onRzSsmX2lNGow==
Received: from BL1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:256::12)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 17:10:50 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::14) by BL1PR13CA0007.outlook.office365.com
 (2603:10b6:208:256::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 17:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 17:10:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:34 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:33 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 09:10:31 -0800
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
Subject: [PATCH v5 03/14] iommufd/fault: Move iommufd_fault_iopf_handler() to header
Date: Tue, 7 Jan 2025 09:10:06 -0800
Message-ID: <6e4f3917e2bcf871b958c0d9f69dd3a182ee8ce7.1736237481.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736237481.git.nicolinc@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fdcc7f6-101e-4fc1-41bd-08dd2f3e3c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U1G5tTq1U7rvXroiohw/G6khePh3jRBlh5o1D2EoVjH7UM4MT8xNFZtYDu7p?=
 =?us-ascii?Q?SHYpw8wxkF6NnETM5Gr3PnJn8fU9N10J4Z7SEPd+hxLaCpGZ8sXK+jUJGJ9y?=
 =?us-ascii?Q?3WAbQFP+aZTk9evaSSxrjdUwNPjFml+yHL+kqh9dMko0LoaKv+UM7/EsC6tT?=
 =?us-ascii?Q?dmNdOY22smowA7BVsla8htOZLwOvQ2m+tO2yn87ldPq2qqvR3B8cdgCwhGlR?=
 =?us-ascii?Q?OGY9Rdd3y5R4SYYikcc/g5WzRj66bxAZnlfVCTuA4QpwQsx4MxDNfS2u0X0R?=
 =?us-ascii?Q?YTGdOicok9R/FOpvIfvKt2yC/bxs9A8HcLMr26BHMsYGUP2VhgICb/YZjk59?=
 =?us-ascii?Q?kZCcP25w0Q11CKSJxT21GR/RQMD2AEbui2Zi4H1XEowvyDvR4aP8wxj4vYJy?=
 =?us-ascii?Q?ljSqC64uW/eCYTlcmFoZUF7GTmdoQqrM0nfq5D94V8cNPwvlcLM7AWvkC9T/?=
 =?us-ascii?Q?RJCvVTnv4cxp8saPqIxsyM9ewvaffpgrwm2PrKzmW/sfGPRiwyZYyDm6b05V?=
 =?us-ascii?Q?todnMCH77POkJQpJIFi/tfcIJZevuzhnmET7huygkadnlqLsMKiZAAU9FBFC?=
 =?us-ascii?Q?06ULEPLy18rOk0MDatnzx/ypWNKnFo16gpzyXCgOyaSyCRzuJH2FlyVR8JDz?=
 =?us-ascii?Q?+93SP+EzoxoeIlF4mAAfa+pNRJgLyyt/Kdzva71fRuKtQE0mv3eN7LVGfsW+?=
 =?us-ascii?Q?CDTScrNdaApd3lnkdcUIShGspR21UKcRNL/RVOgICRw2fNV4ZxT77F+DHqZm?=
 =?us-ascii?Q?z6iR0rocJ8U+Oi8DMBw4a9Qz1YbrO8n1WkNxgzQSWJDYoC3PIQVJ7xWlGCTI?=
 =?us-ascii?Q?qWN382WFVT5tOAXo4TJKCOlTHX9upYQOUferJZ9toJj5hYOSmH6o2UZDIRJg?=
 =?us-ascii?Q?MjaFLxjp3u5UZAipSEWLDt57xjIYA4jMeNBk78UAVFAWzNMXJnjWgitimLMb?=
 =?us-ascii?Q?leW+GyXjqtSBX6eVxfYky8Sy5omdo5dLWJuHUD4nxo6Bjo6CW4ru02CAKLke?=
 =?us-ascii?Q?hDvDOX8FEXWaoktCeq/mbTKaoOHJBtPUB+GejXO95frK0rh20yV9umn6GpJU?=
 =?us-ascii?Q?IaZXPZQg0TmFWJLd8qc8xWAZ9mVFKAqyecrtfuxW6ZnhUuDwiT09tWQlPkWc?=
 =?us-ascii?Q?Gjpk7xsKFfF1pF9YdNzBix6UvHndc8XzSoAAlByZ6S4SVqfDWIyebNYxgIN1?=
 =?us-ascii?Q?1/0RD/2vI2O4Ch2rXcT/jxvvj4rCH8naY9/vFGexI38s7ea4GaLWU/gRZCcI?=
 =?us-ascii?Q?ecrWaqM3dQNdu+904BGGWmwL2oBKrW6jQ0OwLD3Im1zw+Rbyed4JvUtIUzlG?=
 =?us-ascii?Q?8XeWo7v6J5/B0aEdImwZrHK6go9vACYfZHf2JKDMLx7XSL9IBR2rfvXAc2+V?=
 =?us-ascii?Q?fCU02BLVDwfBaEmbqa4kP6A3vH0j9elcC0RXFmHOqLaL03950NOjacsElL1K?=
 =?us-ascii?Q?NWWiycNx4tXQd9FtbKZ6BIOLGSdnIJApjc/a3gJLebf0+dk6tkTCrQ6T2oA+?=
 =?us-ascii?Q?jD/AaG/QAYcNXC8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:10:49.9743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdcc7f6-101e-4fc1-41bd-08dd2f3e3c42
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

The new vEVENTQ object will need a similar function for drivers to report
the vIOMMU related events. Split the common part out to a smaller helper,
and place it in the header so that CONFIG_IOMMUFD_DRIVER_CORE can include
that in the driver.c file for drivers to use.

Then keep iommufd_fault_iopf_handler() in the header too, since it's quite
simple after all.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 20 +++++++++++++++++++-
 drivers/iommu/iommufd/fault.c           | 17 -----------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index b6d706cf2c66..8b378705ee71 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -451,6 +451,17 @@ struct iommufd_fault {
 	struct wait_queue_head wait_queue;
 };
 
+static inline int iommufd_fault_notify(struct iommufd_fault *fault,
+				       struct list_head *new_fault)
+{
+	mutex_lock(&fault->mutex);
+	list_add_tail(new_fault, &fault->deliver);
+	mutex_unlock(&fault->mutex);
+
+	wake_up_interruptible(&fault->wait_queue);
+	return 0;
+}
+
 struct iommufd_attach_handle {
 	struct iommu_attach_handle handle;
 	struct iommufd_device *idev;
@@ -469,7 +480,14 @@ iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
 
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
 void iommufd_fault_destroy(struct iommufd_object *obj);
-int iommufd_fault_iopf_handler(struct iopf_group *group);
+
+static inline int iommufd_fault_iopf_handler(struct iopf_group *group)
+{
+	struct iommufd_hw_pagetable *hwpt =
+		group->attach_handle->domain->fault_data;
+
+	return iommufd_fault_notify(hwpt->fault, &group->node);
+}
 
 int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 				    struct iommufd_device *idev);
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 1d1095fc8224..d188994e4e84 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -433,20 +433,3 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 
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
-- 
2.43.0


