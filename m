Return-Path: <linux-kselftest+bounces-23486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AFC9F5E16
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 06:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA81163843
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 05:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C031607B7;
	Wed, 18 Dec 2024 05:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N2f9Ql1x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CC215A85E;
	Wed, 18 Dec 2024 05:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498112; cv=fail; b=ak04B3dcSlZWYaDygzJ9cFGi2ore/wg232QFd5ymDlqNZwzOKtmMMkfY1EnxD1UIi+tiGCEGpvvOdvrlOip5JM1+qam7cS3E81mrVy/UqWFsS7n86oaXaT3TaLmTM9iY0+H0nujuiVXpAvWS4uDfSH+mB/Zedkn7T61U/7PQ7iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498112; c=relaxed/simple;
	bh=9zfHfv9qYXFhixYUvLZ5cv/upbKRHmWpjr6+Fpf9RnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eb4fRlwJcrO9t0YJMpYAiByFl+S6XYzZrBB5e3BdsoIzzpZemAOwRZ9BKuGNCKZrLEZGjyzvkZ+6YMuh/fWI8B9j6jZ0vE/byEvaT8M5xTjAZzMCahdsVoI/VqyPUgN4pD9IfTCvBrcsvJGbBkHBLBvbITerfVcnw/2yRZfOHxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N2f9Ql1x; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feo2q/iVhH9Fo9ZHtsMO0xibJSILU+SuMweScsFRbc9FCyF/DVq0L+wlXWD9EnZXAi6ABrjazXVEt11UkqI7pMS3MAUk1UzX+4x47k0tD2LPquoOMNE94BkfWmnc/Uq7C8NHpiWjNr8UX5u9mVK1nBfLIg3c171yMlNMjTY0/R/jWKbVfOjmUSrdCqJAyuPMTrmAI9Lqji+xMxF4V59PtaTTtBVJRs1o4liRjgFBSLDjGuyhdjRdD5spIcXSlqRGHLkQhUti+8LsJzyGwqY3lCn+2ETcWfSVRq+UdoSvilfRUXgaQzoKNv9LfgN/NRgAY873wr2F/KtypE0OZ1/Fcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UU/m8jc+VBPO4dxABpAE6DfwfroiKR17aVZtNpiDJGk=;
 b=c0I06kXaWg2zqJT0oEHlzo0+HvAIRfhpHnAXmUROEU0+r+4UM3BxBVX+dfJav45iazGGhOrPf6LfRlK8Gu9K92wmfFJEFb0Zgp7yIUT46vtQqcjPwBW41vgqGVdkqzTEKDasuR9Xv73gVg5cV5u1VQLTBtBnuu5iDxAGcdbtG4F50IAKvVAfsshgWPl7k143ZRi2P+DmiCTB48n/7kL7yGxfj9x+yCXEfsXEGKgGZhskSFLrdftUpEqOS866olAa/S7NLPqXhCc0WWGSVf2HE7Jq6z8MwxxcqF+CxXkwBSwhG+C8mo58ugxhvkYYEXF/dMbanbmRIk65jGJYDJaEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UU/m8jc+VBPO4dxABpAE6DfwfroiKR17aVZtNpiDJGk=;
 b=N2f9Ql1xOkMhB5JrTtAyybireFK5RG6MBH/YrCthXwB8dc9PGYikI+Vi3yA9mR0UYq7FmOpvEb55EXixPR1DR/S47mWnEst4laE8mXJDr97JiERkao5hqJzE+jBUEFtLj/JhLDZ10pk+9Vov0y3JnogWKIS3ngo3b8okNPcoNWpMLPIt0WPr/XGDZphjXwb52UBg8gb2M8CfS1qXJcMl14210mw3H8GW8Mlyx2h9LCT1RMicjpLjFYvwodU+NaH62yfF2hM61FRPOILYkB4X0ZVyFh3TOx0upmqeTyue1s2ptxDppcTInFuLDWm6h6w5/txe5Nd2w5yQC4HJCSpsOQ==
Received: from SJ0PR05CA0073.namprd05.prod.outlook.com (2603:10b6:a03:332::18)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.23; Wed, 18 Dec
 2024 05:01:46 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::8e) by SJ0PR05CA0073.outlook.office365.com
 (2603:10b6:a03:332::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.11 via Frontend Transport; Wed,
 18 Dec 2024 05:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 05:01:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:34 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:34 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Dec 2024 21:01:33 -0800
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
Subject: [PATCH v3 08/14] iommufd/viommu: Add iommufd_viommu_report_irq helper
Date: Tue, 17 Dec 2024 21:00:21 -0800
Message-ID: <3d2298e45c9d5e433cb2c65a17c6d3bbe570918f.1734477608.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 9716673e-6e8b-43d4-ae4a-08dd1f21128f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nVe6PEgImGf29pM7hG/ubDtsnSoImZbbVB36L6DyV6BL/9iniVP3iNVzklIK?=
 =?us-ascii?Q?Xc13ZF2nVY+MYFF1RfpRF3lj2K5tHJIXKIgnNt2t8Paq8wHvxW/VWIgH1hYB?=
 =?us-ascii?Q?LM0QkMQBmqpMbvvNEpgV97d+JbqD3mibIR+cov2n/PkrrZn/ua/mV7AjELs4?=
 =?us-ascii?Q?loNKrUDHl45zFMCaI+5+2MnbEOdVmByehcvOojhcAe/AMxe52TCw6k80Z3+T?=
 =?us-ascii?Q?iit965OW5Ou/03ZOeGdm8VNyj9Z4+PtWWHkBK6tDJNDFR8Y7tDiNln0DSzaE?=
 =?us-ascii?Q?fxD7Za3TWUtgFGlIXqio5wO0e5/SN+I6kLGgy6izJI4njRJ3c5RY7fdqbETn?=
 =?us-ascii?Q?ia14O4MxV16kv5O4akjSSktSnltsz0a0LFI9LALlkEDd34jeCYHOq9FAGr5y?=
 =?us-ascii?Q?mSabAxaVOV8Bur/KLzl6BZXg7bzlXhuvrcSu11DmaGw2Pf71cHObVcbh6Yil?=
 =?us-ascii?Q?6LwfQwDCVfAwptix9qpAcgnA+nz+Eh76k6ifBynTRLyB5Juhkm33R+eyBe15?=
 =?us-ascii?Q?uUsQhu3SrMZSCMeK10XScK7xjDs/fwEY/luQdVCsC6D0n2lMhyQvDav/f3nU?=
 =?us-ascii?Q?a/yPS5o676Qa0QiZmgzkqFut056AsKVG8eD4YcrGWmfM8BdWF7v7v7OpwBrr?=
 =?us-ascii?Q?3JauTBf3zfaBE3h92cVuPQYeMfOL/eul707D5E6b27FDvrm0cA9dvN1FzdSD?=
 =?us-ascii?Q?4+sOMWrwLh5ixUUyXHg4S+lORwQfCpl4ZDExgrZlf7h4PNSJrmmRlhv15o4A?=
 =?us-ascii?Q?lezZ6Xm2T8M1Le5cOyzC/Cl6PKhGFBZW5T/uOkMUcmsICiu3Vt7g6FBfrm2o?=
 =?us-ascii?Q?NR2vA9crM7fssXaP/zpcDPh9wpHxH8eg+TVUL7WDE4wOk7Z4CrvKvcscaRb3?=
 =?us-ascii?Q?XP0K8W2cQJJloHJ5UbAR7D4w+arilwWCBkUEjBWn/FKSGlnxH4coORgTFumC?=
 =?us-ascii?Q?MH640Tn7ZKvfEuG/ANeSmeZBsxpXBP0CXIYfxqSWag/ocQPSEc2jNbKBCt7f?=
 =?us-ascii?Q?r5qEVeEfzEgfmvd1Gjkh7VHpNM0yARzxFNVtUYbbWng6Y3PlL4Z7BqYiSE5c?=
 =?us-ascii?Q?oj9IOZbd9vBnzfbBYhTL0o5rGYUst3V9AyShD5Co8ohvPNcRhalnK1fNpNI0?=
 =?us-ascii?Q?BCpxqai/ctGbZY+kr9GssS5WEnTpHrL4C83GauzbnzqmGHsp8EqJrREl5m5R?=
 =?us-ascii?Q?LEvgJJgP8zfVdE+LWrO3RvBW7sVnaZBzp/QmYj2CzencK7YHxqvwX3Vdx9YE?=
 =?us-ascii?Q?s5Z7e8Db7kOHl9S9BD9bquoTO91hCJDGpKkjXOFzMykvfKZDAYW+WegAjb7B?=
 =?us-ascii?Q?0Dr9mHMtz6sf8I72d3wd7urFLICMLW9MSxACPEMjNHZnQMzAEdOmSvGWiHen?=
 =?us-ascii?Q?3ELC0WDGs6AVVDdyOMXl4TXS8kRSnm9bmWylpulm0qXohi+SgHwN+F8OKYJo?=
 =?us-ascii?Q?fjmQGATeDqyL0DepXnLSE9SQH14w4Wag1cV3Xfr7sXCNg1+F0WjDkK+I5LbL?=
 =?us-ascii?Q?n+Ssz+7GTrMOU+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 05:01:46.0703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9716673e-6e8b-43d4-ae4a-08dd1f21128f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141

Similar to iommu_report_device_fault, this allows IOMMU drivers to report,
from threaded IRQ handlers to user space hypervisors, IRQs or events that
belong to a vIOMMU.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        |  9 +++++++++
 drivers/iommu/iommufd/driver.c | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index ac1f1897d290..c5909125775a 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -192,6 +192,8 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 unsigned long iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 					 struct device *dev);
+int iommufd_viommu_report_irq(struct iommufd_viommu *viommu, unsigned int type,
+			      void *irq_ptr, size_t irq_len);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE */
 static inline struct iommufd_object *
 _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
@@ -211,6 +213,13 @@ iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu, struct device *dev)
 {
 	return 0;
 }
+
+static inline int iommufd_viommu_report_irq(struct iommufd_viommu *viommu,
+					    unsigned int type, void *irq_ptr,
+					    size_t irq_len)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_IOMMUFD_DRIVER_CORE */
 
 /*
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index e5d7397c0a6c..2ab793f27f72 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -69,5 +69,42 @@ unsigned long iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_get_vdev_id, "IOMMUFD");
 
+/* Typically called in driver's threaded IRQ handler */
+int iommufd_viommu_report_irq(struct iommufd_viommu *viommu, unsigned int type,
+			      void *irq_ptr, size_t irq_len)
+{
+	struct iommufd_virq_header *header;
+	struct iommufd_virq *virq;
+	int rc = 0;
+
+	if (!viommu)
+		return -ENODEV;
+	if (WARN_ON_ONCE(!irq_len || !irq_ptr))
+		return -EINVAL;
+
+	down_read(&viommu->virqs_rwsem);
+
+	virq = iommufd_viommu_find_virq(viommu, type);
+	if (!virq) {
+		rc = -EOPNOTSUPP;
+		goto out_unlock_virqs;
+	}
+
+	header = kzalloc(sizeof(*header) + irq_len, GFP_KERNEL);
+	if (!header) {
+		rc = -ENOMEM;
+		goto out_unlock_virqs;
+	}
+	header->irq_data = (void *)header + sizeof(*header);
+	memcpy(header->irq_data, irq_ptr, irq_len);
+	header->irq_len = irq_len;
+
+	iommufd_virq_handler(virq, header);
+out_unlock_virqs:
+	up_read(&viommu->virqs_rwsem);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_viommu_report_irq, "IOMMUFD");
+
 MODULE_DESCRIPTION("iommufd code shared with builtin modules");
 MODULE_LICENSE("GPL");
-- 
2.43.0


