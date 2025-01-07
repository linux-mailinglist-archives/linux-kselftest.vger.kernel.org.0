Return-Path: <linux-kselftest+bounces-24020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C74DA047C7
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DDA1887151
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190DC1F76C0;
	Tue,  7 Jan 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZBIMRPaE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009841F708E;
	Tue,  7 Jan 2025 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269878; cv=fail; b=uHsK/gCTP5LtqPmxCv9jVg85EMpEJpXie4l631RGQdEWFX5A1R8i5/EG1Q18GbLT85H6t5z7jzxf3Rsz84B3SFJ3Kx5ZPdp8YRCSZLvaKl/aMyRVauW3xcy///1IKK5nvrbaECaBEFGp3mz3ThibLJcsydN/7wvT1FDmVjs3rFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269878; c=relaxed/simple;
	bh=uMaTUL3LBU4YCxLdZevYRFP4N9ALZ8o+pnxiXPsxUZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eO/oBpC3DoS621J7hC28Pz2j8+Pn2M/iU3OLTUx0bzo9jd4TWNsCqEH4GqPA+lSYVDx2iy8paMV37Er/TjGTx/jBoCc8wis59mybLzmArVlOI170oyeoNEm8RZUnLRpe+mMgW7SvOaJx1l7ca/VjHh9OLH4knf90Xvs9BW5y04A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZBIMRPaE; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrjoSqLE7pB2FO4+wy6KyclEOdHqRYZLZbtB5iDgn+jpIZdYS7mvcaG25Wmz1su6OMfXAb1RwHLS9cduaVhk9fGSMVHMKpRZnKBwk3M6U/6FvBNDWXVwrU0hczy0rrRJsYGE5Xze28Rd0yL3pCTrdJNARlhOzGQR5Lrqhdg3oHkVACeWwCYzCV5ZKwSGMA3LqnkSnp3EjAoI+R+2hhAOMpAo26HT7vNiG/as0wOKAIAY+DXQ1DjZ3XmGknWs82pctbZvPtXOMLavDSk4fTvJZcWYNfpkIG4c9uQ0scFZyZnm8LhUEW3fYKJJWgLFrsTRKz71ggK61gLZbEpojtN11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+s3Zq509Qux3LkEi5VFqIBrMZa2wNiJ+9xw+edgq9M=;
 b=QExkZv7hTGJEUSyxNurs8cKCTFhT+QDcX3qgYWE3SbUiXR0HvvCvYNeNC0gpgdfZJ4AL1PyyCN1hdQo+3cwFqpL8BhLPlUfNG/9ljUGW2FkzVveo3m8jgKhx8ljzBP3l9UwGCA4TG+20aq8YLUtUG+g10fITMq41HQdQ2OGygOpo2qy5morvC5qYYemu8VsLjNMsWD0fxatm+EX4PuzkcxCZnYxERY2phXZE7Z0GjFR9t7xUYgRB5/Kdr7Jhe6zylEz3MMQuH5b5osP/NQh6GmzoHUNPQZBmy6Qk1XkqtQbT/xha8OjaQZGXbgdNUya0q/PTVXDi7VT3yNSmTEMbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+s3Zq509Qux3LkEi5VFqIBrMZa2wNiJ+9xw+edgq9M=;
 b=ZBIMRPaEyh/1JRX0+4o9FCNhRT9gGoI3KipIM8e/ef+yeIrjLLtXoJV8tCUheiOMc8IU3tpWqc/4dtUcU+ts8ajfBCpDpfbcttBn+ZkLJFERY0C5LajjQoJkhHZmumFF5+mH/PFqbL/C7gwzw9dpqdCy0nGuW4zI540iK5aijUGCwWVC5SW6/qTYOKDCaLZRrKmczsLOQUlt8KNHAVeICWrPgrTc/JHxBCTOdGZhjyvHboWtXauGHLzvw46vUvZPKx8m/RJME2y/b4D40E1pOfbWNpH0qFuvLk2c/Zyh3sy6E7zU8DrUaYwswU6OOFK46u6ZYPxJhdEU6fLa5bHo3A==
Received: from BL1P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::7)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 17:11:07 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:208:2c7:cafe::5c) by BL1P222CA0002.outlook.office365.com
 (2603:10b6:208:2c7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 17:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 17:11:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:48 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:47 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 09:10:45 -0800
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
Subject: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event helper
Date: Tue, 7 Jan 2025 09:10:11 -0800
Message-ID: <b9b4f3df990934cb80b2f5e1e49e555e50c1c857.1736237481.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: 221cac00-e146-46c3-bb00-08dd2f3e4676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bUJ3EVVOhvX3IcCVlEdUwTCnGZQGFr/T2b7iB/dXYF3Wzt5zDn4WSqBUwymk?=
 =?us-ascii?Q?jqL/gpXeiKUVXKBddMi/aREV8QGmMmslMJbH5bHURfqmkQeUidBZVEZVF/bj?=
 =?us-ascii?Q?UjjSP4AZAH5TEOf0UTjuLQqlKOLNvd/F3ADiD1sT8xWqgA/MybTJGdq3Azcj?=
 =?us-ascii?Q?wjHTsPDDiX14Ey3hpr0nBImUqtl2UZNWL/ulyQYyn6MB1xSfNqVBM11d2ZcS?=
 =?us-ascii?Q?1UacsuAxxq8gYOPXN/ULBINcGuwnBrCYeLo32Unn/po5EepxhEGDosqxBj1u?=
 =?us-ascii?Q?bo7PUlp2LljGkQn7q1gmKwa869ujP9/e1PF2VAWTQQvDwQOsdY3C0vTWzQrG?=
 =?us-ascii?Q?odpAW9XcAtaP48ciGARe7TUoiqNaX92K0H1hcEzu8TrCsUy6MWl4F//ZvYDo?=
 =?us-ascii?Q?A3hAJZEpsZz2Eaef+QbZdCXF4yJUGsMBAOYfyfGI4uwBhaIu9EnOJGJrvdbb?=
 =?us-ascii?Q?e4ko/fwAfX0tIhg41NJVPhV2PTgXztyxlHN9dPt40yN8QIPbNSYZFuOu3mDy?=
 =?us-ascii?Q?3tgJa8f9y2HZlV2TWKfe/gv5OT7NrFVWe6iRqts0HCo3CjRrgfTlfnIkeb0i?=
 =?us-ascii?Q?g8ZPNfSL3Tn2HTZjtkRS5XZkIfTby3YlsNMtpzJFH6MCqQm1CkCMEyUW7+CI?=
 =?us-ascii?Q?C4e8sncY6kf4LL3dzoc/brxUKit4+pelQ+9gi/DN77GghTjCL/+YutUv8lxM?=
 =?us-ascii?Q?4G9BisGf0CWdvgCkivnt6Rok+wXDroqdzGX8I8wxUQhQhS5SshYSonnTayBW?=
 =?us-ascii?Q?LDGI0f0e+x66PNykUp8MDkucrdWtcRnTWkusidvyD8fVKU2hwZHDU1S5jTdT?=
 =?us-ascii?Q?d8uVvN38rh2Rjz2cm4gpP7R+sPI+kFBdkbURzSj8RKcWVxaoZyKBf/YEVvy3?=
 =?us-ascii?Q?jvmPPi1FVpEaB65jhVTFvjC7mV7F1I6DzHuktBdxDbaxHwOcdNI5vSw6cYof?=
 =?us-ascii?Q?qqAft7mTCaKBy1hy32pa1T2vpSNbtZ5srfqyl7dQtqhvdDDsXlgSqiWN5z2g?=
 =?us-ascii?Q?BdlaoCIdwmsxtPK9xN8xmee/updmuA8w1iJQRFdokxn8rCVxZ+BAYtdnFpKj?=
 =?us-ascii?Q?aopsHEdy8wxAbwXYZ04n6AQsMTp/FTTi2HgLUnA+CNQm31y/Jb1vNxthxtup?=
 =?us-ascii?Q?L7G/0wzQeYnWLzQunWZihZ1hP+2yW9vaq6W1QTbVpPax19z+a8fOu1IFuote?=
 =?us-ascii?Q?kDf1mIzu0W5r4/1r+F1nHiIZ1Q/KzVZ1xCAiWuckdVWKZ7urbUH7Jiqz/vpn?=
 =?us-ascii?Q?USQCRy8gDh99rHnxsoAnKiVtv/Xe6jJ2IOAydySOyrF2rjkrMPkoPoCHW8Ue?=
 =?us-ascii?Q?JP2leeYl67uC/xaaVK7oibP74uemQrxda4xl+3bR6bic9YWC7O1E0MNWzJNR?=
 =?us-ascii?Q?ep5y4UU2m/DlHbI2Om5yeoGQ5oF//qegURDGLFpRzIH/KeY4PyiUG/yIiqCi?=
 =?us-ascii?Q?dTxl1IGaNgp+UIbM5OdWXkysLsJnn3LpUrFl5dbYvlKWnPkTWh8fu+vvo1sh?=
 =?us-ascii?Q?WUmoORslpM+Epg4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:11:07.1111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 221cac00-e146-46c3-bb00-08dd2f3e4676
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

Similar to iommu_report_device_fault, this allows IOMMU drivers to report
vIOMMU events from threaded IRQ handlers to user space hypervisors.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        | 11 +++++++++
 drivers/iommu/iommufd/driver.c | 43 ++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index a6dd9f8edcf3..55e71dca3664 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -11,6 +11,7 @@
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
+#include <uapi/linux/iommufd.h>
 
 struct device;
 struct file;
@@ -194,6 +195,9 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 unsigned long iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 					 struct device *dev);
+int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
+				enum iommu_veventq_type type, void *event_data,
+				size_t data_len);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE */
 static inline struct iommufd_object *
 _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
@@ -213,6 +217,13 @@ iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu, struct device *dev)
 {
 	return 0;
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
index e5d7397c0a6c..b03ceb016bee 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -69,5 +69,48 @@ unsigned long iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
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
+	if (!viommu)
+		return -ENODEV;
+	if (WARN_ON_ONCE(!viommu->ops || !viommu->ops->supports_veventq ||
+			 !viommu->ops->supports_veventq(type)))
+		return -EOPNOTSUPP;
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
+	vevent = kmalloc(struct_size(vevent, event_data, data_len), GFP_KERNEL);
+	if (!vevent) {
+		rc = -ENOMEM;
+		goto out_unlock_veventqs;
+	}
+	memcpy(vevent->event_data, event_data, data_len);
+	vevent->data_len = data_len;
+
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


