Return-Path: <linux-kselftest+bounces-20351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2983A9A94C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983141F23CAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4E715534E;
	Tue, 22 Oct 2024 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JiE9qEGK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01FA14AD29;
	Tue, 22 Oct 2024 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556456; cv=fail; b=DVYxs300xbyyOZKlFW7eqeFJkSboY6Y1H1qeyLbGjf6Eab9K/JhkRIqQV3xAb8iu+d38dr4gZZLyPkn1n5aJWuLKTmHcrHkze+c0WO+w+VArOdcDr5uU7mqXAOMElZxWAXDgiqf9uu/Oau7JPcoyAkIGZa7yE+LOYhqG4g7GhXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556456; c=relaxed/simple;
	bh=omfSvWzp4qePHaBHAZrdADyzYl8qXH7jjg0zRwNsiT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnIxY2e1v+dHQIWxtESmFxJBAT8WrVA4XQjOjga3sk25/kBM+kVL0lk1T8ItkLTYoRy4Lu9VnECMP99DR49ifiJlzTuRk5UwpOZBizJ83EAXXQMsWIj9B4GvF9ZbEDQUxdMLz528INxoT5MGh9cWBOtR9wDGu35Aj0zEGZ9E2xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JiE9qEGK; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKssdHYEs+oiOwtbC520cG0uSpBM9lj97XSNBD+qD37YIYbkD5Y69/Rns8GPL0Gt11wWS02e1vtqDK072AugQ+ShO1fKrEka5EYr+vPJUgXpIjBFzq9mfUjmq2FfrDaFS3KLjvlH/IGQfwRWntxC6Scp6x2Wdu3NwyFXddCkGzF8yhIAfozV6zNbix2CKr68Yk6JHyZHo7I3w9/HHrIBcfHzeRQmrT54clx0EgjjESrTSG5x30FVjD5atn7cDexa1hILbQBqY0HPrIKz3/wlSvIiTPipZg2sscmG9GqT+lX6B6ActYjYy9YCIlmC0BxakV3ixWeMEnxnt3HUHmx8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpzJshqiXUbC/zySfzNKtT53NsqVtoktTFDKXYdsd/4=;
 b=fXsVXC5LL+12onXFgYxBA4cA/ZFW/0pQrW1Tvw2f/H8p3XOuWwqmenSqsddeDdJGeSEexgwn8Lo380DhSYXTqjqca4MR4v/jL0baI+5dGVpXS80xFBf2K6JjiRKp5JPJ/R/oYWl3lxawoKQaCI7NZK0iGghjJN9OVSSLdvisdjBoy74/cXl3F90Mq5nRHklQUEuo7VHgS5aimx74NRCDiJiFOkdyV+8aHYNokkAc6LFL9pQ3mXieR+dNuNFJp5v9L/ElFZttrrNr8MKwIi4FBP5WQPA1+y+yWzdWlsmMPdmfDBTR/cJdpBNAOUbAbHytEl67CxHYpGHFLYg6o0S1aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpzJshqiXUbC/zySfzNKtT53NsqVtoktTFDKXYdsd/4=;
 b=JiE9qEGKlgerXTnZUvYcE2YUPzBrQlZcM3cARmHz/vOkR/pzY10SXSU7hbnoH9XnA6lOIVZcRM1xeKcUf8WztKeuNlFi3ztQzuLXhnqTbrE+jB8viU3eOrPP5MQnSCB64sesfdnYl4J3CvbPpYLFO+HkhhD3SxyB8uH62Q8ZiZvW54J4G7Kh1yYClHINcg1vlfKft1Pvrg6FdpOzbAvbQf+UgTEHTw4KL21iuQmxpkubrV4K5lqSD43RvA6laFcT5HV53AwnUw+SfoL4wOtZeFW/6oGm31LzXb4LD5SfpZb2BbR4zSAnbbx4eCWOM6+QgP2v8gvI1i1O176EMveAPw==
Received: from BN0PR08CA0023.namprd08.prod.outlook.com (2603:10b6:408:142::17)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 22 Oct
 2024 00:20:47 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::c3) by BN0PR08CA0023.outlook.office365.com
 (2603:10b6:408:142::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:31 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:29 -0700
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
Subject: [PATCH v4 02/14] iommufd/viommu: Add IOMMU_VDEVICE_ALLOC ioctl
Date: Mon, 21 Oct 2024 17:20:11 -0700
Message-ID: <2404ee8d2bd97e7b8c4c45b24cf52b157fb0b635.1729555967.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729555967.git.nicolinc@nvidia.com>
References: <cover.1729555967.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7727a2-b212-4986-c8eb-08dcf22f603f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DWkdvm+UBv2Hb3vWZRBTT82Y6HpkM4639gE6tvd2tvuc7YzNVKA53mE4/oKt?=
 =?us-ascii?Q?w0g2W6NF3T0Tw2Eav9SPLkxVmxBs/9bv9NzCE9Upxv+hcA88fjMVdAa3N/MU?=
 =?us-ascii?Q?xSUPqGTPv6GGmUpqLsgwasHM/ANn0n6Z9cBIKikMw8PWv1307JpX2ZrCrqIY?=
 =?us-ascii?Q?m1a25VNngXrw6nF0p5BQD/fTcawg7cQDS40FdjazaOmABSOq9E8Y6PsjAYtA?=
 =?us-ascii?Q?aHLCB7qwDApj6RHB0ehjpBev/Uo0noikA2g84j/0n7jSqTKCvKlaevC749rj?=
 =?us-ascii?Q?gPzpVsBqqiuYmC5DZf3+aDm+JqB1NdbrYyu+wLG+viz5XIApQSS0TKYD7Tot?=
 =?us-ascii?Q?NaieQ7YyJ0hlbJp18RnpmCbXMSQHWq7OZUGmKXvWjH9aCo2XeYcxFvpsGlWT?=
 =?us-ascii?Q?nxGmB+12iAenixGkdFFni4m6xkFuK1eunqEMawsGxosGS7748GCsTPRPP5qG?=
 =?us-ascii?Q?1pwz21tqP5DqnE8sXmpfpPzWFyC2QWpP5XTcPWim0Pwl6JznAYuWIRZ6LDBW?=
 =?us-ascii?Q?DRPoQ+7CR5eQpsjGG3/CebN3Bm3ZqgszGEIX2bRqc+ENLtpU3Q3P4cuww/YW?=
 =?us-ascii?Q?cYpF3hZRXj6fgu/PieeZZQM/KjVfJ83cq2SzRqTf5in38IqW3s+BKwySXfMF?=
 =?us-ascii?Q?DMlP9I46FQ1+rWVmGOuWTPshAqz9QFIYVEZgrY/mNIt62zkfvje11/HElUOS?=
 =?us-ascii?Q?u1MhcrPmq6D6updKRrOvT9soIUpgKQoTY4g0P4d2dmNFB7Ndjvndb8A8tvG0?=
 =?us-ascii?Q?Z9kQtz+dcMq2yfApYSx9BzV6r9JBdP4e5XUHNZVosBSIE5nn6etLZs8OOwx6?=
 =?us-ascii?Q?FjXnYAPM53/no3k0g5g5og8eDO7qYL0hu9ggZCDEGQN+VsNQFTCBZvrIJYo0?=
 =?us-ascii?Q?2hczn3qMejILC1SH+dRMgN8M51iAhHzXHjuNdVkaoqrDY/2JRxzhe5aoTVW5?=
 =?us-ascii?Q?PW4Xgy8Erjz9UMzZkNbnoM4eLMWWtFIrHSOHfsbxj3NIYCrYe9ZFAYqALWLN?=
 =?us-ascii?Q?Mc28ZoP/CXahRIqiOKmRhKvmcuhOSqTF7ttBQZYwrgOWJYjbvtHUc/r2jNhj?=
 =?us-ascii?Q?JLQJfE6asf+w2EjgblBxC/drPZO/eUxiMt2QavfLwXz6WnsLsyZaLmqKX7eC?=
 =?us-ascii?Q?IHjuLBPh7dK+Nwd9zDOIAQV/Rvz3sagoJqfR+GiFaVo4liNR3WJhdJddr8b5?=
 =?us-ascii?Q?vgS21OFCuMpXrResRAJpeOFe304e4xjwDhLiYfGZThSPj453LmiKspNt2uWK?=
 =?us-ascii?Q?Pe7oi6ek35wmGkX22HvOGW25KfR86UN7wKRhZ21az8xAHPrxsY/eLFE1qhVd?=
 =?us-ascii?Q?v7Qau1LYNaaNIbha+zps9u8ZlJSx6fv6a+ypJcaZsArnZzSoFe0FiqvB9yBo?=
 =?us-ascii?Q?CAdYa91Ngk7FP1QrO0f59NtXpIbaEb1/NX2D9jKKVh4PZbyvQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:46.9914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7727a2-b212-4986-c8eb-08dcf22f603f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551

Introduce a new ioctl to allocate a vDEVICE object. Since a vDEVICE object
is a connection of an iommufd_iommufd object and an iommufd_viommu object,
require both as the ioctl inputs and take refcounts in the ioctl handler.

Add to the vIOMMU object a "vdevs" xarray, indexed by a per-vIOMMU virtual
device ID, which can be:
 - Virtual StreamID on a nested ARM SMMUv3, an index to a Stream Table
 - Virtual DeviceID on a nested AMD IOMMU, an index to a Device Table
 - Virtual ID on a nested Intel VT-D IOMMU, an index to a Context Table

Then, let the idev structure hold the allocated vdev pointer with a proper
locking protection.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  12 +++
 include/linux/iommufd.h                 |   2 +
 include/uapi/linux/iommufd.h            |  26 ++++++
 drivers/iommu/iommufd/device.c          |  11 +++
 drivers/iommu/iommufd/main.c            |   7 ++
 drivers/iommu/iommufd/viommu.c          | 108 ++++++++++++++++++++++++
 6 files changed, 166 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8c9ab35eaea5..05587c60d0d3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -391,6 +391,7 @@ struct iommufd_device {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_group *igroup;
+	struct iommufd_vdevice *vdev;
 	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
@@ -505,8 +506,19 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
 
+static inline struct iommufd_viommu *
+iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_VIOMMU),
+			    struct iommufd_viommu, obj);
+}
+
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
+int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_vdevice_destroy(struct iommufd_object *obj);
+void iommufd_vdevice_abort(struct iommufd_object *obj);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 5d61a1d2947a..821816e3b1fd 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -90,6 +90,8 @@ struct iommufd_viommu {
 
 	const struct iommufd_viommu_ops *ops;
 
+	struct xarray vdevs;
+
 	unsigned int type;
 };
 
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 09c1b4ba46d8..407747785f6a 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -52,6 +52,7 @@ enum {
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x8f,
+	IOMMUFD_CMD_VDEVICE_ALLOC = 0x90,
 };
 
 /**
@@ -896,4 +897,29 @@ struct iommu_viommu_alloc {
 	__u32 out_viommu_id;
 };
 #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
+
+/**
+ * struct iommu_vdevice_alloc - ioctl(IOMMU_VDEVICE_ALLOC)
+ * @size: sizeof(struct iommu_vdevice_alloc)
+ * @viommu_id: vIOMMU ID to associate with the virtual device
+ * @dev_id: The pyhsical device to allocate a virtual instance on the vIOMMU
+ * @__reserved: Must be 0
+ * @virt_id: Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID
+ *           of AMD IOMMU, and vID of a nested Intel VT-d to a Context Table.
+ * @out_vdevice_id: Output virtual instance ID for the allocated object
+ * @__reserved2: Must be 0
+ *
+ * Allocate a virtual device instance (for a physical device) against a vIOMMU.
+ * This instance holds the device's information (related to its vIOMMU) in a VM.
+ */
+struct iommu_vdevice_alloc {
+	__u32 size;
+	__u32 viommu_id;
+	__u32 dev_id;
+	__u32 __reserved;
+	__aligned_u64 virt_id;
+	__u32 out_vdevice_id;
+	__u32 __reserved2;
+};
+#define IOMMU_VDEVICE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 5fd3dd420290..e50113305a9c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -277,6 +277,17 @@ EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, IOMMUFD);
  */
 void iommufd_device_unbind(struct iommufd_device *idev)
 {
+	u32 vdev_id = 0;
+
+	/* idev->vdev object should be destroyed prior, yet just in case.. */
+	mutex_lock(&idev->igroup->lock);
+	if (idev->vdev)
+		vdev_id = idev->vdev->obj.id;
+	mutex_unlock(&idev->igroup->lock);
+	/* Relying on xa_lock against a race with iommufd_destroy() */
+	if (vdev_id)
+		iommufd_object_remove(idev->ictx, NULL, vdev_id, 0);
+
 	iommufd_object_destroy_user(idev->ictx, &idev->obj);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index ab5ee325d809..696ac9e0e74b 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -322,6 +322,7 @@ union ucmd_buffer {
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_vdevice_alloc vdev;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -375,6 +376,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
+		 struct iommu_vdevice_alloc, __reserved2),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -513,6 +516,10 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,
 	},
+	[IOMMUFD_OBJ_VDEVICE] = {
+		.destroy = iommufd_vdevice_destroy,
+		.abort = iommufd_vdevice_abort,
+	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
 		.destroy = iommufd_selftest_destroy,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index e612f3d539b7..77ea41f36b0f 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -12,6 +12,7 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 	if (viommu->ops && viommu->ops->free)
 		viommu->ops->free(viommu);
 	refcount_dec(&viommu->hwpt->common.obj.users);
+	xa_destroy(&viommu->vdevs);
 }
 
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
@@ -66,6 +67,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	/* Assume physical IOMMUs are unpluggable (the most likely case) */
 	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
 
+	xa_init(&viommu->vdevs);
 	refcount_inc(&viommu->hwpt->common.obj.users);
 
 	cmd->out_viommu_id = viommu->obj.id;
@@ -83,3 +85,109 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+void iommufd_vdevice_abort(struct iommufd_object *obj)
+{
+	struct iommufd_vdevice *old,
+		*vdev = container_of(obj, struct iommufd_vdevice, obj);
+	struct iommufd_viommu *viommu = vdev->viommu;
+	struct iommufd_device *idev = vdev->idev;
+
+	lockdep_assert_held(&idev->igroup->lock);
+
+	if (viommu->ops && viommu->ops->vdevice_free)
+		viommu->ops->vdevice_free(vdev);
+
+	old = xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
+	if (old)
+		WARN_ON(old != vdev);
+
+	refcount_dec(&viommu->obj.users);
+	refcount_dec(&idev->obj.users);
+	idev->vdev = NULL;
+}
+
+void iommufd_vdevice_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_vdevice *vdev =
+		container_of(obj, struct iommufd_vdevice, obj);
+
+	mutex_lock(&vdev->idev->igroup->lock);
+	iommufd_vdevice_abort(obj);
+	mutex_unlock(&vdev->idev->igroup->lock);
+}
+
+int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_vdevice_alloc *cmd = ucmd->cmd;
+	struct iommufd_vdevice *vdev, *curr;
+	struct iommufd_viommu *viommu;
+	struct iommufd_device *idev;
+	u64 virt_id = cmd->virt_id;
+	int rc = 0;
+
+	if (virt_id > ULONG_MAX)
+		return -EINVAL;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev)) {
+		rc = PTR_ERR(idev);
+		goto out_put_viommu;
+	}
+
+	mutex_lock(&idev->igroup->lock);
+	if (idev->vdev) {
+		rc = -EEXIST;
+		goto out_unlock_igroup;
+	}
+
+	if (viommu->ops && viommu->ops->vdevice_alloc)
+		vdev = viommu->ops->vdevice_alloc(viommu, idev->dev, virt_id);
+	else
+		vdev = iommufd_object_alloc(ucmd->ictx, vdev,
+					    IOMMUFD_OBJ_VDEVICE);
+	if (IS_ERR(vdev)) {
+		rc = PTR_ERR(vdev);
+		goto out_unlock_igroup;
+	}
+
+	rc = iommufd_verify_unfinalized_object(ucmd->ictx, &vdev->obj);
+	if (rc) {
+		kfree(vdev);
+		goto out_unlock_igroup;
+	}
+
+	vdev->idev = idev;
+	vdev->id = virt_id;
+	vdev->viommu = viommu;
+
+	idev->vdev = vdev;
+	refcount_inc(&idev->obj.users);
+	refcount_inc(&viommu->obj.users);
+
+	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
+	if (curr) {
+		rc = xa_err(curr) ?: -EBUSY;
+		goto out_abort;
+	}
+
+	cmd->out_vdevice_id = vdev->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_abort;
+	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
+	goto out_unlock_igroup;
+
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
+out_unlock_igroup:
+	mutex_unlock(&idev->igroup->lock);
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
-- 
2.43.0


