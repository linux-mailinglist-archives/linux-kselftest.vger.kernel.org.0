Return-Path: <linux-kselftest+bounces-20721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 830E49B1368
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EEF6B21723
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5E61DD0C9;
	Fri, 25 Oct 2024 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sz9Okylr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968721315D;
	Fri, 25 Oct 2024 23:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900217; cv=fail; b=T9H+n0KSpDxwROCrQ6rTwAIQsanT6NJ/PeYffI5FMrzWKDMGgLAEAHbXIgn/2G6Zt2KpREjUrDc8qjo85iNQK0RRvoyo0P9NvlvzdYNjNaUz/wkEPaClFwzfC5hOfvvVPF2ZBQeafYAurT8V9vsSVBQEcQ6+sO8VGrMnD4WO4oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900217; c=relaxed/simple;
	bh=BAhbnbd6nB3esg6BopLZar5nOFuqrjrnsJ3Onq0fnG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlrzalSkc3y2rduSlS6gCt9CsxHbOh+PQm85PD5e9Sx5rqx5nE76kAeR2eqKgPBdkk0m2WX5vDVAq0dOMqj9Fu8BDFjaZQPBUdh3sgm0+tn2nroCvGJ+KsbSZznYl1Q4bIB1OTKY7cLYpwr8qpRLf36y85Y9h2Cfe606lgIPj74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sz9Okylr; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eP2sTRn03l9Y587JpwdFpUBplzZG9y4kEGDRHiA9JSJR1UF3y7AmbeBb6DGJgzcO99rWDyJyLrvTr1U0Eg2ZUfIiPXmw///TZCV7upCoo3bSWgz3KxZZ5Vyyvc0sGHQGitoD/lNk8UrQOEPOvHDwGwtoR+FZEqiGj4FjClO+Kc1g30nKeH5XCNpbCHz9ZhIWpYAOJ2XoggqMg1L3di2WjZTgjWK+OYOZjwcqArDniD/u51GyqTX3S5155qbc3uGmnY9qoE96KunlwCPRg6bWdXbPthjQ/NcYbd9f1PTz1tycP4R7m5v52WWL7AcCIraPYB19PIBag5hmcSaCa9gosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjQW2xLESRVctQySoU3aGSicRuLiP/tNssRTrwY2PqQ=;
 b=ddlPO6EW2Q74/N32NkMWbxEApN8vTWCjI/8NCxT2JQ1PJ4T8B7n+l6GFAXhIy6PLUedAmimgFoKHMhbmYQggCbgoiXC9ik6jdNnbUuzFF7ric2p5c9qTSl8xSGJ8YNHP+ZH/KeHgODBFWbJ/zVq3u6uoKZHnGyJCM5jQaaLGqGUrOu8EL6ZkbHKn2EEjLZcTANp5R/GexNcsbBeI3F/tJtFHuNXHmLUCg4DTNuvvFI4j05YLIZ50i5Pt4scGYxagh7+D6MIjhIcvi/E910xJB9QRSQSRcaTQLLwdSjq1Eia50OQhbvwfZKC8nfKk1IFUTq5v+H4PB/rqbN3C7yGL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjQW2xLESRVctQySoU3aGSicRuLiP/tNssRTrwY2PqQ=;
 b=sz9OkylreKcZwfHWI34+8f5WZANgxU9UXWYb9VQc8JtFwGTs1chep4R/HBr+mg11CvTVhh2yzjrnDlunEIxFjRgUlZqWBFClpwth37MojVvJZxQJNQk5lu7hxs81GEqVe4KTIEdtFGtmb/J2/TkjC9W2aZceG2f+XwUvrWnuyL2naXa2z24FV1wmGDBGwXXVs5Mx/Z9r5zbh/rObVyePkw9GncU0L93SJdc8r9+v+qCmaiJMRezs6NDimDOqDp/qZ3kilPjZZ+p8vOhMr4Qau/OkMvhptWahJmdMdMPupB2e+SDyMjp1DG8PJK1QfjAYFWfUfAfK9tRpEsVyjwOCvg==
Received: from BYAPR05CA0102.namprd05.prod.outlook.com (2603:10b6:a03:e0::43)
 by PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 23:50:09 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::b3) by BYAPR05CA0102.outlook.office365.com
 (2603:10b6:a03:e0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.8 via Frontend
 Transport; Fri, 25 Oct 2024 23:50:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:50:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:04 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:02 -0700
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
Subject: [PATCH v5 01/13] iommufd: Move struct iommufd_object to public iommufd header
Date: Fri, 25 Oct 2024 16:49:41 -0700
Message-ID: <013538e31b680be3616068425d40578ba27ff3f6.1729897352.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897352.git.nicolinc@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 4720a013-7f35-4cb1-ea6d-08dcf54fc239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e7gQcr5+yN2Qo3HFk0IH/2nb3gCrJCAP4AIs2uIVLLpxzCKGrA1Y4fvfV7Ap?=
 =?us-ascii?Q?4DvsILg5MAl1OpYDEoQhabwm/ftN7HtEnoiititgwq6wfFiX5kd9PuGIBRYr?=
 =?us-ascii?Q?7zim2I4/ikz9Fc+m8pO837eGcZ3tiLSh9L8rYU9ijfvOHW/OywId8aE034jl?=
 =?us-ascii?Q?CckuuX0L4zaGxPwiBB0Ls+K2v9na6BeYwiTKLIQ+zitlPO6ZRmGfLcPiVzn+?=
 =?us-ascii?Q?7S48fIkk+jIEzFwwOQ3KXHI4flgBpsdg5DCiM54P/IxgtWMldsPKKlsC4Pyo?=
 =?us-ascii?Q?02v7D0T21H/Xi3I3qHFXpHbRoDdnKVjFoVooAxEGjhQVPbRyCb+PhnGIicwm?=
 =?us-ascii?Q?3mMSVwY9AEOjSZ9V1SB32BRXlBNllc0dYp7xPEccxnCtsdN4VWXk55BsSJt1?=
 =?us-ascii?Q?cwOq57QGBQl2EA6vFbon/pRU1wutihTXcCCyVJWwZWGHuKk89uaZMcnl8UHc?=
 =?us-ascii?Q?pXgmSpseKAP9FISiHVAMan3dW6NrpOTIhJfwNNh+M0kWxaq7XZ3swb8N3oum?=
 =?us-ascii?Q?2NAOvwageZiBVnF4tSt5iiK3RMbnyiEraVEMD3Jjk14v6VUeLxN4rvN3x7e0?=
 =?us-ascii?Q?uqqoEC4x3ZKryhCNQ1XudJp1gHmWYdkmcGqTN5HPargWSMoNVAtH/CSGCsVS?=
 =?us-ascii?Q?VhrI3a1B79TJl8VZWvPAe20fkj7U2JW3ehxAJLXDOnukg/Y6rFcEOpryPJ0V?=
 =?us-ascii?Q?MxSPoeXQM+WX4GLs6VXiXb6+OQbclrebEXi7uLWbksnbcJoMFIQPxTKgugAL?=
 =?us-ascii?Q?mWQLF2POnaMke0E2MZEIhR5z+2KBONWKzM450c6DU94YE7IommK6cx2c5Jk2?=
 =?us-ascii?Q?/HtJohfr7IPlJU5V4+Ds/yS21oTM5fJuHqnXUIeSjLZlebPyZ8hgCpAYSbeV?=
 =?us-ascii?Q?Txvc67QFYUOMePhbN4jgluG8TWwtQhwA/AhQ05S+8CJEnanRNbbieMe6Sx2F?=
 =?us-ascii?Q?Ay8mDlxegsbl5os8HWWDfAEYxLl4u1YDvR5Dckxt2f44jrfII5yET6fViedU?=
 =?us-ascii?Q?687VNif1a2OiAi+ajP3U0PB26Mdxsnsr7d/t6Qka8Ro484unSOwyK/+X63AY?=
 =?us-ascii?Q?j8BL2XmjntUWD8dv3JmsXqEaDtEKXSwbYh58dsMK/uNeGmoOre2RJ0Bz0nLc?=
 =?us-ascii?Q?P9fNHI5gAlrl2nk4V+J/OX0fIaj4spc7zeHrBy9JRliKn1ZToAurxbsZsiE+?=
 =?us-ascii?Q?1W4YXU/P6n/uVYDkZNmmOjPL9Q02sxW3iXI7UrLWX9GKDICBWmXmvCc4qE5d?=
 =?us-ascii?Q?0OoV1dHV7Ar4aG3/Y+j7G9qiAzNcvDzOLe6K41qgf3DDExP3lLT+IZclOi27?=
 =?us-ascii?Q?HPdomC2j57NPsfYE3KXqsQVZPgz1qQ+cU15TPnUhF1UG8wv3Ze3d0RoywFT2?=
 =?us-ascii?Q?CiLX9nLlTew0BdA3wjapo9efv8Px2MS77gpF4CCRn7txQz1kDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:50:08.9252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4720a013-7f35-4cb1-ea6d-08dcf54fc239
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472

Prepare for an embedded structure design for driver-level iommufd_viommu
objects:
    // include/linux/iommufd.h
    struct iommufd_viommu {
        struct iommufd_object obj;
        ....
    };

    // Some IOMMU driver
    struct iommu_driver_viommu {
        struct iommufd_viommu core;
        ....
    };

It has to expose struct iommufd_object and enum iommufd_object_type from
the core-level private header to the public iommufd header.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 25 +------------------------
 include/linux/iommufd.h                 | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index f1d865e6fab6..1bb8c0aaecd1 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -5,8 +5,8 @@
 #define __IOMMUFD_PRIVATE_H
 
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <linux/iova_bitmap.h>
-#include <linux/refcount.h>
 #include <linux/rwsem.h>
 #include <linux/uaccess.h>
 #include <linux/xarray.h>
@@ -122,29 +122,6 @@ static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
 	return 0;
 }
 
-enum iommufd_object_type {
-	IOMMUFD_OBJ_NONE,
-	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
-	IOMMUFD_OBJ_DEVICE,
-	IOMMUFD_OBJ_HWPT_PAGING,
-	IOMMUFD_OBJ_HWPT_NESTED,
-	IOMMUFD_OBJ_IOAS,
-	IOMMUFD_OBJ_ACCESS,
-	IOMMUFD_OBJ_FAULT,
-#ifdef CONFIG_IOMMUFD_TEST
-	IOMMUFD_OBJ_SELFTEST,
-#endif
-	IOMMUFD_OBJ_MAX,
-};
-
-/* Base struct for all objects with a userspace ID handle. */
-struct iommufd_object {
-	refcount_t shortterm_users;
-	refcount_t users;
-	enum iommufd_object_type type;
-	unsigned int id;
-};
-
 static inline bool iommufd_lock_obj(struct iommufd_object *obj)
 {
 	if (!refcount_inc_not_zero(&obj->users))
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 30f832a60ccb..22948dd03d67 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -8,6 +8,7 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/refcount.h>
 #include <linux/types.h>
 
 struct device;
@@ -18,6 +19,29 @@ struct iommufd_ctx;
 struct iommufd_device;
 struct page;
 
+enum iommufd_object_type {
+	IOMMUFD_OBJ_NONE,
+	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
+	IOMMUFD_OBJ_DEVICE,
+	IOMMUFD_OBJ_HWPT_PAGING,
+	IOMMUFD_OBJ_HWPT_NESTED,
+	IOMMUFD_OBJ_IOAS,
+	IOMMUFD_OBJ_ACCESS,
+	IOMMUFD_OBJ_FAULT,
+#ifdef CONFIG_IOMMUFD_TEST
+	IOMMUFD_OBJ_SELFTEST,
+#endif
+	IOMMUFD_OBJ_MAX,
+};
+
+/* Base struct for all objects with a userspace ID handle. */
+struct iommufd_object {
+	refcount_t shortterm_users;
+	refcount_t users;
+	enum iommufd_object_type type;
+	unsigned int id;
+};
+
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 					   struct device *dev, u32 *id);
 void iommufd_device_unbind(struct iommufd_device *idev);
-- 
2.43.0


