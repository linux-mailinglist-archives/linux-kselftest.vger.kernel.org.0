Return-Path: <linux-kselftest+bounces-25144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B24A1BFC0
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 01:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97E03AF0FF
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 00:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C76E376F1;
	Sat, 25 Jan 2025 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G1WUL/5G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78762AE96;
	Sat, 25 Jan 2025 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765080; cv=fail; b=IvKXCjoZePPvR4WYwPXDQ1avhx1Xjzh1vE+ioKKeC4J1Iwn8BLUqilmM7ClKK4v4tUyRvhek9PnQd16ixR5mjt27SceC8enJGGGx7kfB3vFRSYvnj3WgPGnsQz4QYiZ6RbLbPUi5U8yYyKjbSJoBMXZyPP+dp02/nQb0s7slwIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765080; c=relaxed/simple;
	bh=b8F8EY3aFUYGD8qOrg8bXFKqgSFs0RJPoEnOZAs0aXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etsYku18TVFONpj0Eypy8Vr85PuQpOS8dei/RPLgafjjcIl3dxR20WO23bVTx5BUzZhTQrp0ep3mvXDhq+GV5Pz/JLuj2OXT7HBwz0qv9QNcrpMk8Qjpe2JbmCa4tDQXK1r1IDxk5UBbqfpJG3aFHYY9kzZ+tyAojQ9mBw6nr/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G1WUL/5G; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1zq2lnIXvcTQj5jCOYB41vwMMFjKhv02mODwS3RtQQ+ucTQO4db7h7CnJ8FSRd0QCgNifDHwFfDOFElytN18/VEFznd+/kPMJLAXgHzMN+t+QqjKYG5tgC2e64RTlHs3B9QnUQlKTvvnHXMW+P1OnanlbhNueqLpMKkRwZGsS/rzqziTrNhE0muzE9f7Mbqf8EPLPP9HNhXQ80c8Z+Vjnt6R5Vvil+PkSQGwzU/9+/xXsGG0cxjn5mWes6eXoLmSEFiLfu0iDPUW9PtoJPDE4q28zC0Yf9sCi2Cul4defXCAts92jpSf0M4xGiA0D5YEOkZ/Izb2sze0IfpRjZT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQG3gznx5Mzxjhuo+4c7RCLADsfguPT9Dl7K+ZDtOtU=;
 b=I6v9QpI2KO49UCb0ygwMc7Mj78Sv4Qj+zibY4CCNP+U/PDaJVroVp/9+e7/4LZcXHH3kGsVJq0xFMB01OnvSCXQg9IcT6HLbOIlDIFsMjSIqEfNjqb68+vD747RhkxF6XBxiwYDcI4QsGmUcVsDJu872XXhVxL90Dlil4gmcTrynQqSLshAMQTxfoSebjxXXHUtF8EHwJg4CuceporlI1XQf+Qj18RDTE7O3MPZP8slfqNMMNzU+ZYvcNxNPYKU1gFWdwVEAVcIAsBg4vH2Zxs0d3BMsf7hckms9QNZZTvQzN9k4+aXGC+L7z1pq+W2zm/wdtdQmAngIF+AnRKh9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQG3gznx5Mzxjhuo+4c7RCLADsfguPT9Dl7K+ZDtOtU=;
 b=G1WUL/5GtE2aaIYnxD6xln0csoXhSoYIrnpJRYU/t6DS+3aEXIjkDmehiRx/3RtDa3qIqUUmutb/lkjPLLWm/EP3or99TC7Ws8XvpHcWd8S/Rpn78hBzhYC68hfQRvFQTHDzeyNEy5zwJjd9To8mproD6VCss7NAIwJ8p++Oc2ft6+TJGIysFzrnk3fLNWFJvhPdHbSQ56EDzfjb+DJzmmn0Ygap1dxranMFiIonsxwuwZaE8GyAl0Eq+4OqNOpILEwrcHIR5jVlOsS8v1XEZkw9qLdsLgeKzUe9PTmBTG3iu/ViJUbq9oM0zL6MhtirGSUu32wplNP2G8AjwtL7vg==
Received: from BLAPR03CA0136.namprd03.prod.outlook.com (2603:10b6:208:32e::21)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sat, 25 Jan
 2025 00:31:14 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:32e:cafe::e2) by BLAPR03CA0136.outlook.office365.com
 (2603:10b6:208:32e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.20 via Frontend Transport; Sat,
 25 Jan 2025 00:31:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sat, 25 Jan 2025 00:31:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 16:31:02 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 24 Jan 2025 16:31:01 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 24 Jan 2025 16:31:00 -0800
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
Subject: [PATCH v6 07/14] iommufd/viommu: Add iommufd_viommu_report_event helper
Date: Fri, 24 Jan 2025 16:30:36 -0800
Message-ID: <3d952137a7935608f9cc6b05bd561a58a0c5da16.1737754129.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f88ebd-6fda-48a1-a6f5-08dd3cd7933c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I7RUF3UAxXcyANlWTheVfbrygrDj8JheQ3ipLSpWhJLdsNFMhHxMuIaCusBB?=
 =?us-ascii?Q?Nxq4fG2kfg/kXdwrhqLhWYLf79wdAFbgWLgAC76hhMgzOJDR3DyaaSIa4bnh?=
 =?us-ascii?Q?PTqCKNrBETAs2QUbspsQk477BvSnwfyJ5gUfQYKjQU/Jub2JvGHhpDJowMtt?=
 =?us-ascii?Q?xKA5yXwo4S/VbhooXnUCd/vsOHGIN4d0AqE6SxsFOKZFu/bWYC3tt++o9KEB?=
 =?us-ascii?Q?5x66ZF2uuyS5T91pmjPyI3leCNjGkAmNtiaujUfRmYNrnEoZ1DyNL9YJtu0r?=
 =?us-ascii?Q?g6pP0xhPQiw5Yj3e/r4gud/5GQ/1Q7XEQgncwu5/62JMjf9UCvFdL3FCeob5?=
 =?us-ascii?Q?X5EiUfdmyzBBTln1K0D3JY5H+9z2zjxgujaw14kiIbYHAlfnGkDnpxo/nwvB?=
 =?us-ascii?Q?NUz1m0cEiM9qFGeYDLm4rOGMAg6eTmG1rrDe8qHUXhJzMwQLCjY0rVydRl5H?=
 =?us-ascii?Q?1ku4kJGeYrnrCljZjRfTmcJ/Xa8jRmoSvzj3osb2TXit2vpabu00vtyXI0xS?=
 =?us-ascii?Q?FAAJ5+bG3pXXBMqQWXZy3Nd5T2Pl+mDtq1nSqgS/wcH7D1lgV8LzVU4NxGOU?=
 =?us-ascii?Q?HVHKTavN957JMzehNDXIL73DwnEl4mRN/OxrP4qq2O4IqIu/YTQUL54mRH8I?=
 =?us-ascii?Q?PzR6lXOowbstMefFFUUgl74YGfDHrnhP+y0mbwknG6dh//spLFVFu2Pe5IVE?=
 =?us-ascii?Q?Un9XA+oK9mPdG2ht+cX2coOn8wtBubu8g/Rmrec0qut4DuOOoj7Sr41MyKdD?=
 =?us-ascii?Q?opSfCtpGTu8mFUfWbqLrar05mRNhgsKQzaL8si8mmEEdXJCTso7r9CwGxT5r?=
 =?us-ascii?Q?oC7dAM9SfJTYtF0wRku2F2wrw2FAeKRUU7aOZHS/rsm8oN2FtLcBphjIFDN5?=
 =?us-ascii?Q?mDav3f8YoXfIgnKCarzGaqnvWxzIoM9OCa3n7oa+wSL9xuXrmUV8EgWspiru?=
 =?us-ascii?Q?cSeiq7tvvg65/4Js9+AbgHcl9s1fdBpyUoUI1DlGJ8ZlAbiZpa4uDOtW+cja?=
 =?us-ascii?Q?QjxPvzEpYg9AqHgLV59bJBs+ixa48X0Xl9CUE7NmrFH8EC4nhUvznw9Xh1lk?=
 =?us-ascii?Q?G1jXnlqe0vKMX3rd+WHKIuqwRvWmfSOC5f/3MRe5yO1XsC8r2wtLR4fHVLzN?=
 =?us-ascii?Q?9a2xEYmi8TFD7m4rMK2CmpvfekQ2EFDTnpZ4BWU0cNrHC7ZYDZ/JCDxWrk69?=
 =?us-ascii?Q?enPzAiz3xscq+mpQBBaouy1rwDjFMQ83Zc5+knW6O9GLjtbTz+7O/7Q0rbO3?=
 =?us-ascii?Q?PIScwV28u7Jwcrja6L8PODDvMSUl6ycPxLyt8GARwItXQMj8Y5hciphIyq5m?=
 =?us-ascii?Q?NCSwcjhnzXr2MfFoGll52TkKVWyxAQD6+Yv3DLSXZQ9f8LBKvUok4RMszZWN?=
 =?us-ascii?Q?3kR2zTCnBPRdbHJLjsNtVxBowPq83JbU+rbg1qaiBJHzBA9WJPwNo0dh/GuC?=
 =?us-ascii?Q?b3jKQSx9W1nJVr8+LdGddgQ1ta0Tk/FNhZcmTzUOk4MOPrwnF1Vkn5637Sfu?=
 =?us-ascii?Q?pupwE/qo1x0uWwo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 00:31:14.0308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f88ebd-6fda-48a1-a6f5-08dd3cd7933c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149

Similar to iommu_report_device_fault, this allows IOMMU drivers to report
vIOMMU events from threaded IRQ handlers to user space hypervisors.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        | 11 +++++++++
 drivers/iommu/iommufd/driver.c | 45 ++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 05cb393aff0a..60eff9272551 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -11,6 +11,7 @@
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
+#include <uapi/linux/iommufd.h>
 
 struct device;
 struct file;
@@ -192,6 +193,9 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 			       struct device *dev, unsigned long *vdev_id);
+int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
+				enum iommu_veventq_type type, void *event_data,
+				size_t data_len);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE */
 static inline struct iommufd_object *
 _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
@@ -212,6 +216,13 @@ static inline int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 {
 	return -ENOENT;
 }
+
+static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
+					      enum iommu_veventq_type type,
+					      void *event_data, size_t data_len)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_IOMMUFD_DRIVER_CORE */
 
 /*
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 185c4fde8987..9e52ce66204c 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -73,5 +73,50 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_get_vdev_id, "IOMMUFD");
 
+/*
+ * Typically called in driver's threaded IRQ handler.
+ * The @type and @event_data must be defined in include/uapi/linux/iommufd.h
+ */
+int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
+				enum iommu_veventq_type type, void *event_data,
+				size_t data_len)
+{
+	struct iommufd_veventq *veventq;
+	struct iommufd_vevent *vevent;
+	int rc = 0;
+
+	if (WARN_ON_ONCE(!data_len || !event_data))
+		return -EINVAL;
+
+	down_read(&viommu->veventqs_rwsem);
+
+	veventq = iommufd_viommu_find_veventq(viommu, type);
+	if (!veventq) {
+		rc = -EOPNOTSUPP;
+		goto out_unlock_veventqs;
+	}
+
+	if (atomic_read(&veventq->num_events) == veventq->depth) {
+		vevent = &veventq->overflow;
+		goto out_set_header;
+	}
+
+	vevent = kmalloc(struct_size(vevent, event_data, data_len), GFP_KERNEL);
+	if (!vevent) {
+		rc = -ENOMEM;
+		goto out_unlock_veventqs;
+	}
+	memcpy(vevent->event_data, event_data, data_len);
+	vevent->data_len = data_len;
+	atomic_inc(&veventq->num_events);
+
+out_set_header:
+	iommufd_vevent_handler(veventq, vevent);
+out_unlock_veventqs:
+	up_read(&viommu->veventqs_rwsem);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_viommu_report_event, "IOMMUFD");
+
 MODULE_DESCRIPTION("iommufd code shared with builtin modules");
 MODULE_LICENSE("GPL");
-- 
2.43.0


