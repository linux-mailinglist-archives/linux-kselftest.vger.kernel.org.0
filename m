Return-Path: <linux-kselftest+bounces-27506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAFEA4483D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B522C1890345
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759C421148B;
	Tue, 25 Feb 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qmP4HRJG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88121018A;
	Tue, 25 Feb 2025 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504395; cv=fail; b=ZWfQtNt3h4EHdg7/fo9ImIg00tl+qizzSPV51YT4ksvqMkd+69+w2tNDrDTX+7K+2anZvKP3fB+f3ODeGLK0ucRr15J0kHwxPCWHpCOI2irri3xwDg7XhePnaoVP6CMYLMc9o76ePTaDBQOEjoLgt8zlkNFXyIe7aBTLTlFwxVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504395; c=relaxed/simple;
	bh=iecy4fIFlsJi6mG0vyn2Kzx2uCT5cKHBhUEZhmYTA0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWYGSTTk9EvARfcFsJihyOrYsyrzEfqj8h3zWHeJkZXdLXz5I9jv/AuvsgQscdiwRvZ1Qb93skP0nPQKdlvj4VYB9Dhgn4Z4SCL/BokZqh3nr0qiqrnei8cMi4r6yL6Kicb5Qrk9ykelYlExCwsJ4lxRHcgjrgqXl01DuJXC/n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qmP4HRJG; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNP5RJP54QT47aYT0FBB1g8zL06op/WtzRfBL+AjDv3YqURI6mO3aay5eobPK4FdWBVei8xkesxBGvaPAYqYxdU/pyL/dFqiRN4dXcVc+/4TuJxOvTZ3HYGG2uIhNUSuRV8NfJbYRHbaG8rCfKThpHUexT8KVwX0mGYAIbkurkacgbfl0/kuAEFYhpDk+oleEMlRH4iKvfpSgWJlla5DQXK/cVtDWSvf6mdAwbjPzkYSIzgPoG4xvgekXAOXsggXj53HeypRrhvPPsAm7bZulHqlr74nSHzm8MaBGiPJYp9xcsLF8OLKrN7wBT6vek6TIVSVF3Ilplcfq5fLxey+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvhDhdq8BqMWYZAy8VZpGH4FR6q5dbcFBgzSx7Z7lc0=;
 b=NkMNVop6uCAgosouY5Ol4BKk+vDMpnPY9Kx3HFa12hRlc6fBm9GvLZcYIGvYpWwzLREzxSsMHBvrgZJXeXg/c8usm9wU9VgcedOUBiDu9M1UrQRX+3YmA48/X6gabTxfDbjiFTvJRHYgx8194bFzTUaUkaD6KUaFniQh+FuKjh7FINtRByTNEFng7sCUS3oOcqI8t0n4MIqoRtpndZhcB372aany+nRYp2B0suh2pdPWaM6SMOjO2+A6Og/543sMtG91eiMOMUMNXBJfBrVdMCso++5Z8k356lj+xLouFZXt0I867e/oyPsu5w/0+K1IG27WtRlmoR6VQx2XDNBBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvhDhdq8BqMWYZAy8VZpGH4FR6q5dbcFBgzSx7Z7lc0=;
 b=qmP4HRJGOsz1h6VUiU+n0UkD0LI2xbrxS/lpcn8dEPOLN+a++JHtC2QbqMp1g9uPcp22FzXXwg6NakSbsw6PspDlm2L1B9sCor5Wb54SZb9uBaa7OxSvJ7DMh+3QRcK+OtlxVHd2GVkIT2ERzpyFkgay+k2CyGYy84v+zZkxp+KF6XrSEACEvmlFtXNbGS3LyhSFNx/VuleEsd6r7NEjVgNMGSgCP5sYVVPWQxkzKSslvX+BgMglyTVbrC7gyq6Heepf5Ba0DyHCQ28Ac5qsun4LXHmYNM7uMSXEjECv2jl1+OxYR4vOyukdZCXu5DoEpvYeGjVQrY4fbz3teKLhmA==
Received: from BL1PR13CA0342.namprd13.prod.outlook.com (2603:10b6:208:2c6::17)
 by CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 17:26:29 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::10) by BL1PR13CA0342.outlook.office365.com
 (2603:10b6:208:2c6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Tue,
 25 Feb 2025 17:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 17:26:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 09:26:02 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 09:26:02 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Feb 2025 09:26:01 -0800
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
Subject: [PATCH v8 06/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id helper
Date: Tue, 25 Feb 2025 09:25:34 -0800
Message-ID: <e23275eae6cefdfdbbdc8e31193a4c62a0cf2872.1740504232.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: c43b835a-b02a-449e-cd11-08dd55c18a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gO2Se/yk0iswOoUJHYSKCpj00RtIUddn1guzmgCFHvmVXPhVo0OPFD2VZBlF?=
 =?us-ascii?Q?6dc/gmXmjrDAF99fQw97CUxayLCGhFrCUsZna7iHYRbPmzbA8bFwQycGuUWR?=
 =?us-ascii?Q?Q0s83ZXczel/X16iA8LYxFdQWxPf48aG4tznsGF6QQ3/kCm6G0G43yVa55xE?=
 =?us-ascii?Q?qR8H4BCcnwaxDkp+v3I0S9+zqfHJ1IIls0U29Lt3I3oQiUDpMMM6K48cAhxf?=
 =?us-ascii?Q?WIt0Hp8q/7fQ0/uLq0FNlJQT9jnY8Yf9TQTfL3nFR595QUDxI59zQZ0aTln0?=
 =?us-ascii?Q?/1pxf8nHRAI44PlP5I07oZeUYHOFQUPXU4DrFh0NlnPz4JJWAGvGIwUjT9+B?=
 =?us-ascii?Q?4FOnrGLmV7hj7hydKjKj4/psK/bO5hIUJ80Xt/s4iTRwIn8CSzPF3EXBZ4yx?=
 =?us-ascii?Q?9KmRi6AvCTMtQVrXykX52RidV3gJpmT8MwfIF+r7p6Eod0cvp9jKz4+CcrO+?=
 =?us-ascii?Q?MsDp54RSpAPjR+IClSnGmg6x4AYZOh511ZptDvD0tiCK5w4FBqBp7Yyj6lfp?=
 =?us-ascii?Q?oJvi9gDDwISBdKwy+GsEp/z/S+snYbTu53dddkgGZU583DwhIkABOXvTi9rf?=
 =?us-ascii?Q?I0+X4nNsSmgcadzwYnG+KX3hj7Am0SyvXMpdTGSxYfDATdC++xgPgcchlORe?=
 =?us-ascii?Q?GoC0+Psr+3knX2bO96ptLe/Rh8irfdPp+EIu+9uKfqPmCYvTD20eCYIN80gD?=
 =?us-ascii?Q?fmc9GBj3oPWiDZILE5FTwEX3sG37VkPlZc/vIldqOLicndcjXvw8dTjbjJn8?=
 =?us-ascii?Q?trvBziadvTh/OZu+J1lZpZvIL48HvWY6VOfgguIlzMOfS7ZwIccZv6A/G9Ns?=
 =?us-ascii?Q?NSTJUgDHYQlemzWRKK03a4HvmVtYjqc+BZVHj/BVTkkP5DYQE6AK0B0tE3Sk?=
 =?us-ascii?Q?zbS9hrgZ5fha9V9jsfgozh/jzwEyWFchHvmKjIJBLfskb9d0eKW0Z1KpMOEZ?=
 =?us-ascii?Q?0zfBFcLY6POO4/GFjDm+HNwyi2qzMQvPJfnaQrT29YNO4O8OIxRtA61maEGm?=
 =?us-ascii?Q?H5X1HkJhUjT67fOy8ZzqieR4L/Y/UX63pVqmYYmYO/bIIJ5Q0gMqSmvMrZr0?=
 =?us-ascii?Q?KAJk0noPHVjunfbs6N7R31zT7AOSEkNCzPYcL8qX//yhIN+fKAm7LWH46Yue?=
 =?us-ascii?Q?DrcqHLRgZEoFJBOIo06+MTU6IgRQaYwx58p9UBp5hURD829OG/mj5HLhKTw6?=
 =?us-ascii?Q?ByNB3HHSrgSq9LSHUDbNeSpmsaF66XksY2wY1yaIGaJMvKrrw19SJY2z/Tor?=
 =?us-ascii?Q?3WHvaUvfugYmctZKfobSxZRsYB4zvyL7cm0pUTtFnadg8yK218FPPMru9rBP?=
 =?us-ascii?Q?MviHcgrDCOXZXdrEc1GVE8VGz14Saj5g4JTqvRvCWW3euQtebiTO8mnEFC+h?=
 =?us-ascii?Q?Bp/L6h1yAmvRiuX1J3N75JKe03evR13QgDaP7VVUeGIRZxlnl3KQ9gCNkUGo?=
 =?us-ascii?Q?0Xs66huly0uu45h2ffgM+2su6cZ6KtdrOaENVVEUp8r0H22Rf31NLs9MDeNZ?=
 =?us-ascii?Q?SgHXCIenyO4e/FI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:26:29.1432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c43b835a-b02a-449e-cd11-08dd55c18a49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B

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


