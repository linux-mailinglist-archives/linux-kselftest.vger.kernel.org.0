Return-Path: <linux-kselftest+bounces-21164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFDF9B6F2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942F41F26658
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41023228052;
	Wed, 30 Oct 2024 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tYAutUch"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCE3228037;
	Wed, 30 Oct 2024 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324107; cv=fail; b=PvV9E02geUv/D395yzRtK4er86V9KLeqN8cByrFli2LS3dzNKwCz6J9M9XOBRx6/7uuMWqRS2tBQUNKysnTzymXJoQC5Z50TaEupu4meh4+xM2zf6q5FGsySrtfY6tE8ygmPm2dAdNYHWGjki7tVrI45B/rNyZrKmbCxOeHAVp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324107; c=relaxed/simple;
	bh=7sPB15V/w4wInnTmw0ej6hMvg40uSiSj5vrqQcGoylU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXgDdabno99Z0soear8HNl1J3vCpwBMOdD0JFsx83B8F/ZnURaGRVwZLQFddTIeGWA1XPPiFEoikPC9fN1utMZPB59PJV3wLcOiCWCTabeSFr5vYd0KxCVlLipVhm/grYrhWuzird5LlqPmrSAYI8YceL3B52GvHi20NmtyDpg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tYAutUch; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiYwDhdwmEME0V1zcq5TjwAMKi58h+JkULsyijucYAJm9jqWKnzMQLMRRJhitY/m+I1vseiccXICiD4053O4NpghPYOeQfA1oOAestBssMSA1GZ2uJMcv2qQuAH2ittWbBHeO9spySsOmctoJO18R1S0R3a+6j+xyWp8HBJ/u08WZ4n2Z3Jbu7wSORjD/4aRY2qwK90tX5+sAPDZ72q8M633L5+SwSf2NfkUIHptnK47IjtwhHJMXGWUUacxIP5+UqOl6uNqN3JguHhmwd77o4d3LVW4XlkLpTm3F7QTuklpyJLVZvtML0RZSE6Fzy+o8DqC+2mrRAM1XyOCeWjOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2m6/F+JKpnHyzJ1kxenJ++GEDw1KOY8ocDrGh1wzehw=;
 b=h2kh1xp6dwYnrEUUsmurTRRrKvyHF/fPm3ofaJV4682CP5uUAXOnS95pSBzlH9SbaBhf9Ij7CGDulUUEnbmbTOa+6kcVWNquyk7k3cwvz9DiUdNquv/clxFNn88KUkyRilkXPQoeETv+PECV+aJuuoGPTjWwIkx1CYRa9hEzqFxXfXYvBYa2sUsa01X/vKvXtv4tdblJecwG/ZFQnOlKfPOy+PTku4TM+dqVp9q7rtmmj3ehsKGvkC7YM8NRZo6Brc+9CEdtYNhwK0w7bqTR2HhOW27PweDQHIf8BT87ANqkzd1Koyt3MxHKKym11z1DA6W+ezXiHNFPpyFAxh9PQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m6/F+JKpnHyzJ1kxenJ++GEDw1KOY8ocDrGh1wzehw=;
 b=tYAutUchnyfVXMC8bX/wLYDqrYNSV1syxNn+jbSCmBv72Rqx1X7XALJwduBUY8XTPbVn5aDpIxtUxk6s2wepqBGP5qgo237i8qtmVwS+fIIse/l1ejmXnU69w9OuS3L+w8z90U3nN/bxajd/1lTvY1yTuQ9aSU+sGxErhU9vrAMPkBHGlVBxDy2HQg2hyxkGm+Zn7zQokgNwdFa6EzaeZE/bQweoKrzfb1z/KIXAfvJF7lj6bth3YuIiJoOWYQ+B6UEvR4Le6p4Flz5ftfm9QVeErrry+LlNmKqEh6XUcG1P2GN5RLQbHbdCKTK0NtfwwaA/VcM7hd+f0XOheNlk7g==
Received: from CH0PR13CA0060.namprd13.prod.outlook.com (2603:10b6:610:b2::35)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 21:35:01 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::63) by CH0PR13CA0060.outlook.office365.com
 (2603:10b6:610:b2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.8 via Frontend
 Transport; Wed, 30 Oct 2024 21:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:35:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:34:57 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 30 Oct 2024 14:34:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:34:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: [PATCH v6 01/13] iommufd: Move struct iommufd_object to public iommufd header
Date: Wed, 30 Oct 2024 14:34:27 -0700
Message-ID: <54a43b0768089d690104530754f499ca05ce0074.1730313237.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730313237.git.nicolinc@nvidia.com>
References: <cover.1730313237.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: f9262d02-6e63-4bb1-eceb-08dcf92ab5ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ii6SAf6zRhjKtQ0ey4+MPL4/W6hbqbEe23hb71HhOFWAvUWczTmVzvSbA6R?=
 =?us-ascii?Q?c0cONHr0rXeY8bmOlpcdCvj0VeuraChWnxh0wHNlqkte388kISNV0t4YF8DB?=
 =?us-ascii?Q?/obuUyQ4as0GPBlWajkO9oOMgha3VxpeFjw53ZxcvtDw1BcSIbKh7WOVHVvz?=
 =?us-ascii?Q?ZxbUlFJ4p0BhMqZd1vX4SyCp1tIv4mJY8VyyL25bD/BS2EluGsuL5K9YUdLz?=
 =?us-ascii?Q?JDpE57gDrPgX0RKCdo7IzybssaFCm1WPR2uv/FAu45ciuDpBaBJUBYAn19CN?=
 =?us-ascii?Q?bU82Ws9tl+FEFS31tG7K5p+wAXYrg9yX7R/YocLihY4WJnofSmDJvEkgtBgO?=
 =?us-ascii?Q?fAtzsisRgnYIg5IrARb2kW7si+RvfPpt0C6su6VLDvYMWYkZplKc2xOynUGM?=
 =?us-ascii?Q?uxoLhIwFF/YMj0KJ3neNvjFm3CKdRK86B6yZ3Pocu6R0cVHvRGgxKpckBjq1?=
 =?us-ascii?Q?Br8l22+1eaTgScEY3IxJ/v66PT2uacSKiSsqRDATern+JuT3g4QTvTgn4uE5?=
 =?us-ascii?Q?3WjN8cWfoT0xV3Jl7BUmEMo+ATyj5SpSsmJezEG7ea3vIHx3dmLgyTp2ulu2?=
 =?us-ascii?Q?qaQnyChkiSZZ36J6zhDkqySeXc6d9yXy28ECLcdDyR/TIHKL81Js982WLVjq?=
 =?us-ascii?Q?GaZ0Jb5UcDakPv0nXbmWbxaXKPZ3WU11sBCl9giKF/9VU2+oek6nudeA2WmT?=
 =?us-ascii?Q?HeGiX0l+Veu1W7FYo5MZh8C9i1tOpGz11C82DRZX3YmuufiR/i/c+tMEK1M3?=
 =?us-ascii?Q?3vEYBLGH6fpPnJtgAt6M3/NX16U+WT1hiq6bX3HZKjTHSgkycoybXpT257bN?=
 =?us-ascii?Q?bTpXEwVzcJ9f/EP2dR+oOmZunS2lb4ZK4vmQCoIowtBJOY11ooMyOFSWOqAs?=
 =?us-ascii?Q?FU00ISZTyJl0rGDdFll3Wg5zZ0tEbw2fs+zgJe2s7LZIZfNJftR6G2wZEWfX?=
 =?us-ascii?Q?OVBrigA/OxISPG0OMnzpUcTITnJcZwINxZH5sJRptZczdP6ArCi/s7MuFqos?=
 =?us-ascii?Q?OyhzLNdyBU1IfX3i/hfcpwi4dpFKFLjUdF/Y6Zg8ROyjsCPPUeFMc6kdSz6o?=
 =?us-ascii?Q?m+D9bgBM5KWCpycx+SkrKSbBXk5MpUfnA5OgK5UUujV07QcGVqOz2zDNqEjr?=
 =?us-ascii?Q?mNt/ztvgZC1zBgdY5fopxCWNGvICP3VWhIoFiL9vIAwsWXgRURBqdvILZZZS?=
 =?us-ascii?Q?+STv4smO28MR+cEnbHIfwTmUS/M1+qlf2C68EJQjKfSxhI7BJQJ/SGgVjc7g?=
 =?us-ascii?Q?YOPgIMs7US2qQJ8c37MK/wE19VXSRed3e0mMfRqbCGCcJdrOwdSKeRCGO7iX?=
 =?us-ascii?Q?5QDyHrjColWjcwc/FtMO+uELr4SbmQbcdMC0q3DQAfdsvWmAi2sE1hR5Bbg6?=
 =?us-ascii?Q?wP14A9OppM5jdLiWuugNmI8rN/cP+Du+xTYCOAFM+tD4dzF5Sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:35:01.0313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9262d02-6e63-4bb1-eceb-08dcf92ab5ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282

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
index 8f3c21a664bd..94cfcab7e9de 100644
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
@@ -126,29 +126,6 @@ static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
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


