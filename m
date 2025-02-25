Return-Path: <linux-kselftest+bounces-27507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CC2A448C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C9F867340
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4058621322E;
	Tue, 25 Feb 2025 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zae3Cw7T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F092116FF;
	Tue, 25 Feb 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504398; cv=fail; b=IhO7eONElS3MrLxV3mhdc3UKI2dKavWL8z5zMeoM2MzNN3Rp3SHHjYd3fBhcoam2sIcWANW/C6JxBPpGXChwLXY7y7xCPwoXE15RanN9kL7YsT/c9hYtZsP88z1eYTGafZhReNex4EDPTxs6WX1ZjH87IFPwGyj3FJ9YdvoMVS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504398; c=relaxed/simple;
	bh=eQWfMySKNCTUTxoIz0mf9YmYHsKUjPyxqOuygFPBCYs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=av2W6uObR+5r8i+NsFpy3S/T71loFyhTSoBRZdb1vl3pP+OR/ST5Nkri1bDLJBxPr0T7VR/560IimJBmcIiW5ftXuQ4waaGDrDyvuW1EaoBXpDdGrdW/LDfPo3VCH4nGYeblBdzBjVIMpc9hb8Vq6Yuk2CbI8z3HRRz4MEv0qTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zae3Cw7T; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aed14d3hyasIb95ZUmMHDFHsUU3pLQBiiOS8f3NUOjkdDkJJ8U8YxaFsYLuxOoDujzcegHVKllVj+U2T/gjlk1HW2Au/3h93GoOeCapPu+3Kb93e4qo4b/YMZD1XuS71o/ZxddakiuwZCBoaMEHzWLofX6Ud1oOsOj0psygqmv1Vu995b60p5gA5PGJs3X+R5uAZTPpTyf8xhG2T2oSwPUPwNGEuC01Yk1YSWP1cY+IQHKoziZKUoUd6ujTtz4BsgfrwZc2QRLVltupKsZNFLD7UGvlEtS/xq5nNP/i98yMG2GJ6caVb+WvzAtsQh03sEEVY0sXGrLWTDgFIxGc0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTZ/HF3UVdxjFI4T5WdFmZ/S49Ns4vmDqtnqXeARvXw=;
 b=u907VGo+9OkxVazTzcGXc4ckKNQ8EZRou0PE/fOFOkmJYW52u3s0M86/56Zj37bSNQhB8uUvW82hiSR6B4h7EPOFCMkgQaNnSJ78QEsdh5D0Wiu2gmWveGjrZR1Z0LC7ZtWXWF/ZAh+PxrXEdtqFM33G/19C+uuaYTnD+Ug5wyrnm/n5H0v6Q2+82ED9JiaBlekxcls+kKsZVERvpko3YoDE4N469oup46mcQbW28yQXYgmhUq1eA6sUDvM9g9uTazRwduijsaomKdRBUvsQ5n9sbt4MNgew/h3lW7Nqgi0vQv6guV05IyPJZ+ivxYEtafon94FnM84iMr3NDoDDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTZ/HF3UVdxjFI4T5WdFmZ/S49Ns4vmDqtnqXeARvXw=;
 b=Zae3Cw7TBm/K9X6E4Tru7RNlSy6bWKlvO8mq6hpUW1dPm/Bm780ixnF3KNZRsvDAQuhTZXNEd53azdZpvOPcrrcCN0NZmes6jQs4UYG0YuBJ+iMg029CLOTjrmxEtc0a0mKKcuSFdSNXRFR+oprgqcfcmB0tKInTqbCrYCYxZUsirIBKtguFy8mqI/9NiHNPTbvjpl4DLp+kjYDpIEHlkT98IFUvPZfDGtmZwDzyGit1ITDAEluvOU4b/zua+T1nCVVIM34Vlwd3Ocbt6d6aByr6CwePVvtFRnD/8JZ4VuB+vcUu4B7fP/4JJx0GIOcLbURfIweZcK7WBSmqgNcf/Q==
Received: from BL1PR13CA0334.namprd13.prod.outlook.com (2603:10b6:208:2c6::9)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Tue, 25 Feb 2025 17:26:31 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::8c) by BL1PR13CA0334.outlook.office365.com
 (2603:10b6:208:2c6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Tue,
 25 Feb 2025 17:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 17:26:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 09:26:04 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 09:26:03 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Feb 2025 09:26:02 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v8 07/14] iommufd/viommu: Add iommufd_viommu_report_event helper
Date: Tue, 25 Feb 2025 09:25:35 -0800
Message-ID: <15062685a6f33a7e3436d3253353b97abb8f7cf1.1740504232.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740504232.git.nicolinc@nvidia.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b42003-9231-4988-4b03-08dd55c18b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m7z6qDCiBBFhqtHYc2VGuNqRoLzKG64SRlcOg3QyUgIuLPuyxgtSx5whvELi?=
 =?us-ascii?Q?NfKVbq+cPYQJRvPk/fqmWTYhQSlKKXwBhXzxCNqHJOFGgXngvT3YASDKS2Zh?=
 =?us-ascii?Q?Xb+Izwj2nT0YALFq36Q2zc/0CzTZ/eF96P3OKtvLQl4QHtKYuOrRmsAAH2gL?=
 =?us-ascii?Q?m8UX1cUYHE5WQ5bYkWFwyWILkRoV+L0Ts2v36cVdIbMkR7HdYr875ximGqF7?=
 =?us-ascii?Q?Kt+29kPDc1dV24Vu1E7hLnDC/uwoNv5Hu60/MXswK90v73b8dz+w5vu3bwM4?=
 =?us-ascii?Q?BexzG2mOVqbkstoxkmRw/SC3+yTvMlW5JkSJTYXLRCKX+nZkl2AoBZSmfEgE?=
 =?us-ascii?Q?ARN7+sIKX58ik/KqQqboP69aPNuNRPOKJqquAPbgGRey4pg071eNoE6U5l/Y?=
 =?us-ascii?Q?hnStyNUsV9IX1V015azdMmi3YluwVHXHUm6qod4HLXyoIYUkTSYCxQQfCKxU?=
 =?us-ascii?Q?VFogNYxMTIq72NOF6SvIIL4YAtkUwtZEClLnD4yhub/UJWY4s1EkANizwDc/?=
 =?us-ascii?Q?v1HIzocQX88b9kh8QO9KdWRcIZEz//MzWFqhLUvqfUFcxDj0IrA+CpTpGZWn?=
 =?us-ascii?Q?ffZtGmLDCaFETmKucq68MWfvNad0vafm5wrnTUgXJUDgoLBYHtGDjEMW3gaQ?=
 =?us-ascii?Q?v+11ANodKS7BapZQJF7YpoW7jfbyL9chykYEuJ76xiq1YRalQ/w0AgmwbscY?=
 =?us-ascii?Q?jimxizuaCAUAj5mK3MMOilT7mHumiglfI+KdEdZDlQxoUwXdsnLrwgCwVmQG?=
 =?us-ascii?Q?IFfz4jwCuZlMPTkFOL+mtAva5MLX7eZCHduu+2tXT0EaFrZ2nCblGl8fP/Lx?=
 =?us-ascii?Q?DWvYlzLYuWydZmGgtLnbMFhx7wX4OTD1Mv49D7z6C8yAb8FHDGZUP5e0BEpO?=
 =?us-ascii?Q?NED1AokHAKcvafOWECsvPjVsMwkFHm+80TPJvgN0t4iEgrd7eLKx2dg8OMMB?=
 =?us-ascii?Q?X2PRnZc2ndMDK6IQrv1lpfRl1bniSG4QK9uux6wb5D49Tw49C5l4fF46nPZh?=
 =?us-ascii?Q?sRqarWBH0DrOfqiVU6SpiXSn9PIRm8JMLQEcFxaIAjWvLoobDDwgfxwIrnOY?=
 =?us-ascii?Q?oKKesMxucWNHl2zSm9zdlXPravTMhBowBXS7s6YFv8jbBv5aG26WaYePPQSm?=
 =?us-ascii?Q?l7IuKgV3JKjo+74xnH8/UvFkfnMm7VxlNOmgY6ZBkC4QbM9ep7iiCgcTN6Yw?=
 =?us-ascii?Q?LhSm+qQPb7QnP4jnfPnF7eqiNtiBKw63ydKkMtOGp4X9Ac8Aigc3TG0yXneX?=
 =?us-ascii?Q?pkcgNm8yAG1zH/5X/MTZPC9JlrL/Yci2jEM/Ucjedpztnkitfh8+i7ZlGs8t?=
 =?us-ascii?Q?K8jkKk9M8N9/UKIsmYzKraZMnd8H2c0fZ/btpsfPA+up6iiVe5R13u8OdkI7?=
 =?us-ascii?Q?nSBpYbx9FvNpgleutZnscN/1hURQ777PGnegD5oXZuBZVAQMo70dhiWckJvv?=
 =?us-ascii?Q?obVQE5GCa8Re/Q55uaTLbeTEUVTmFJfmNx9R0uuyHg8r/j+N8NAM7IfQkZ1R?=
 =?us-ascii?Q?hYz27JT/TiwBmGA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:26:30.9088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b42003-9231-4988-4b03-08dd55c18b4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416

Similar to iommu_report_device_fault, this allows IOMMU drivers to report
vIOMMU events from threaded IRQ handlers to user space hypervisors.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        | 11 ++++++++
 drivers/iommu/iommufd/driver.c | 48 ++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

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
index f132b98fb899..75b365561c16 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -73,5 +73,53 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
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
+	spin_lock(&veventq->common.lock);
+	if (veventq->num_events == veventq->depth) {
+		vevent = &veventq->lost_events_header;
+		goto out_set_header;
+	}
+
+	vevent = kmalloc(struct_size(vevent, event_data, data_len), GFP_ATOMIC);
+	if (!vevent) {
+		rc = -ENOMEM;
+		vevent = &veventq->lost_events_header;
+		goto out_set_header;
+	}
+	memcpy(vevent->event_data, event_data, data_len);
+	vevent->data_len = data_len;
+	veventq->num_events++;
+
+out_set_header:
+	iommufd_vevent_handler(veventq, vevent);
+	spin_unlock(&veventq->common.lock);
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


