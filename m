Return-Path: <linux-kselftest+bounces-27270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C037AA409B3
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 16:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794E01720A7
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A441207A2D;
	Sat, 22 Feb 2025 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mobNaWDB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F511422D8;
	Sat, 22 Feb 2025 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239690; cv=fail; b=mAIKf2fHYUC9k0Aj2ucTd/Q50cFOFlsRucDXrfA8udPwlMLhjyclGeEsUxkNOe7lY3IY8hRNLkwwbrnvqsJbrgU59Sr9fGi4kAvZuplKc3Hiydtv2PhN/8l6SicwxL8M9XQ5T3FcoSAsoABe31zo3k5mR4e5TTdDNx9dWlTdsjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239690; c=relaxed/simple;
	bh=iecy4fIFlsJi6mG0vyn2Kzx2uCT5cKHBhUEZhmYTA0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQGHPcXlq3bnaqUWA7ODzurIZJktK4Odk9OJWBa5n6d2/guvvJvqH4x9UF4YFE+kTEqVbze6o7+ZOGJ/yeK/gVq4ZSZCDr0TsJ8m9xsTgx2Mi1j8fmn2b0etW+tWwGI4xxANdcSgSg+Fygm3HcYfDTCiI86d9NYWzygUW49Z/jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mobNaWDB; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpGKA2HsrXKlWhCwEA2PPjW/vaARYiyEQhZQHsPE9Tq7HPS/D7G9Lmfoanlhi6M+z6Qd/9CMrEtm/3A/aOkpACcZJW0yTib3ye78Hzys7ImBuq6qhKKJr0/1d11/O9kvUqka4exhjPZ2B2hPz8lAtLqDxqHltO7gVHdqvZXAgolUsJJZgRzko0CKFmDRJNirDPu1/e//3tFVH/Ex503vZXtVXSvrgEgA07EQj924t0u35pW71Nz0WO8Owldn8tWa2t2zhJI7HoIhCdaELTFIStyxPVYqVd+9Q1U5xqFk6e8K4XyTwKgDvTNS6XYDMuId0ACtsBBTAGPxGv9wrAk2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvhDhdq8BqMWYZAy8VZpGH4FR6q5dbcFBgzSx7Z7lc0=;
 b=Ye8ZKapU3uZ4FzLjiamvIngLQ867RtSdRmTv9kfmPTF60i2Wym15eS9UKxLR2W76iuEnOfZpn0SY0RRjpzgE71N3JYuh/F2CSSAdRz22d3f9QP7bbyaZnNhjY2qfjvJjM6qJD+Gky/psRt7UDkXF+34PmV/avkQqf2znQ+8TFuZax5oB9hLgc3b7etTIEEiij9uqpmjYxALqEB+f2pESr2inN2LhaKYrt/XeisijkQ1YXltQgUnLW3q7PTFbwz+e5YsJ7bTOYDboAmZlFoiqtmuEk9gR1H9hMgnt6sn6sd4SxFyrUtrDQrP/z4t+4dezhAihiYnXlkmrnCowBTWrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvhDhdq8BqMWYZAy8VZpGH4FR6q5dbcFBgzSx7Z7lc0=;
 b=mobNaWDBJOmhRa0Ccr1DS1g8AHXfZ5R5vUcXMhx4iKu8NGYv0tAZwMa7d4x0xVL6y3t9wnlZ/HnCBfl6A74Aj1pnI3GtL/pSzfvLCSpGP1hu4iKWptZfbMWmmcVp/q4ocz7KzQWQpCqJiThD7/OBcRqI94MREqbfQ+ESURYpIewI8Hj/Byc7qG30GVzZPw8eY9Ne8brX3G5yuBl2BI6RcN7gBMOeUdBfC4AaSdqSS4LplSpluwp2C3qDxXwVfkQoVFhUAcjLN1/5x0hScGl0udZump/ve8S8AF5r4+lQfkNFW73IUdN+/GAmMEdCONNBcEUEBMd7VeN0j6Sn4QkIWw==
Received: from PH7P220CA0135.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::35)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sat, 22 Feb
 2025 15:54:40 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::de) by PH7P220CA0135.outlook.office365.com
 (2603:10b6:510:327::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Sat,
 22 Feb 2025 15:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 15:54:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 07:54:25 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Feb
 2025 07:54:24 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 22 Feb 2025 07:54:23 -0800
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
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v7 06/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id helper
Date: Sat, 22 Feb 2025 07:54:03 -0800
Message-ID: <7101a2607f98650e105a038a7a80cd8b4d52506b.1740238876.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740238876.git.nicolinc@nvidia.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1d6152-9968-4e2a-90bd-08dd53593745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Da+G3WlaNFfq9/h8tGrd6AhOCmQRq3ZXE1Eaz4b89XZTVfcbZqjXdSDsD9XV?=
 =?us-ascii?Q?eTtvURo0y7oN43thgszdSWNeITICTy+UD95SaHt3gl407guaHMcB9sGrg8Mw?=
 =?us-ascii?Q?rQ6EKZGN213qImsrriw2cwidZvhj7Qit5uwga9n9gXfRX0mfpGUVr96R5g+V?=
 =?us-ascii?Q?7bLcH+eaw9a1YToho/K4e3xMtg+dHRmVLd5JgiYeuNP6JGTr1O49uuFeIRQK?=
 =?us-ascii?Q?dDgIvTkXczyXgUdL6dEEmPe77kZDacyufcMSmx0ysRtX8SeO9deShMxqi1Y0?=
 =?us-ascii?Q?Gw2LuGg9e+CNdY1FjJ8LhBqCqqtF4Xao05s1rFnswUhzgaHZL8eia2eTET+5?=
 =?us-ascii?Q?mmSkwS+9u9qGN5j7+fzcTLGamy3fwj19cL/VYjVcoowcdpARPNbTjlBVRhgw?=
 =?us-ascii?Q?vmDiRwISH60H47W4wo73L+NwrGmpT0pROYPioX2Arpn6cxUlPD7gxHrPN4Eg?=
 =?us-ascii?Q?CnOSaKaOZ98tHrggROAjqgl6rIA0yly0wFkV6cZgvjkZdN/Lgat56ARWB6NJ?=
 =?us-ascii?Q?OrUx992q7O2w1m829K9qqp8LLE2xiEz8Uz0TLhWR82D1y27sqULDXmQJJDKW?=
 =?us-ascii?Q?lCIb3mSTfkkKJZ4kLCrtOwcacQog1P7JDM2gJ53kgo+A/eVTutY/mPgvcLKX?=
 =?us-ascii?Q?XQO5MFZv40lsmyC04sgGdaMz28ANH6kxryRgWplQmNDVNaR8i6P86cecn7cC?=
 =?us-ascii?Q?Osjly82Lo1cqzvgEHc9eVC+/yzX6xU/5CVTo0rByFvOZpYM0utVYtBrYREG9?=
 =?us-ascii?Q?2QMGb2AyU854I1eS0p2DH3qa9gCI3jsjWcJ9OtcW1frKQ8McXDdwHxWBMXcj?=
 =?us-ascii?Q?g2XUm65wlBS/SsPoxchExtpKCAamW10UflxSDSSDOlDPrIbeHFwiUCRQJ6qJ?=
 =?us-ascii?Q?5OkfWTtQk16V51hpkg8bbxiyP+gxF1habRVV+vNKhj60FuTf1DHwOBrcAbDb?=
 =?us-ascii?Q?0iahrRT6SQGauizwoq+01+lAYF2wPEa83MsxKDMh+GQnrmN5Do0OZX2Aqrto?=
 =?us-ascii?Q?QPm/MQ0NoBdN+i0JgiaveixvX2viijuTJc+FHvK9JUifQV4TOhVIsRS6TQbv?=
 =?us-ascii?Q?Ae0+ugGtD56uzAg1n9FCXXvcOZE9r6UbRkrN+tUCmStkI3lbp4Z9NMLdpyeV?=
 =?us-ascii?Q?T7KkFV/6ETeLx0z0/DYS265fYYQDTFIWX7yi0LDPT9tvtmiSafJG4R1lcTSa?=
 =?us-ascii?Q?HQCSmqDKx4inPDcfufra2JKMn5lUhLjZcUaPvnVk7sOjwn8JF5pgf5h1u6BJ?=
 =?us-ascii?Q?+0bc3CEoDxy1X47h9pjGtT5Cwl8I6fBp8gAmn7BiFpKjADtNiiA5wFcw/IoV?=
 =?us-ascii?Q?bU0wKXuldDiqvpvjEGhejmBXKy+GgkhCLqMhetXwCijS1j3q7vIwxSL7ND5r?=
 =?us-ascii?Q?gR3VAAoF9W+ukkezvsCThv/5I32gGjNtqr9AvP4CCtSRFlvFRG0u/E3AA7RK?=
 =?us-ascii?Q?MUq+vwa7VNmNa2ZuFCy0ZAX3uwWtSlqE7O/RtfpiWz08WbrWqB9hGBQNyBQd?=
 =?us-ascii?Q?OH/ERPAJUeMVryg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 15:54:39.9885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1d6152-9968-4e2a-90bd-08dd53593745
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942

This is a reverse search v.s. iommufd_viommu_find_dev, as drivers may want
to convert a struct device pointer (physical) to its virtual device ID for
an event injection to the user space VM.

Again, this avoids exposing more core structures to the drivers, than the
iommufd_viommu alone.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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
index 2d98b04ff1cb..f132b98fb899 100644
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
+			*vdev_id = vdev->id;
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


