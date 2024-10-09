Return-Path: <linux-kselftest+bounces-19363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B8C9971E5
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB621F21DFB
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B0E19D098;
	Wed,  9 Oct 2024 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JebU7lX+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9F1A2554;
	Wed,  9 Oct 2024 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491941; cv=fail; b=L6MagAZJwCM5xmUU/p4kHZfvgRH6fQJtNbivdmlH1/S4nP/xUloMkeIJEdoq7e9tm3fy0dbNzBsBCuhij6VvYAm4KhL8pywK/jRCbz7c/wvh94nJiOGw5n40Kz38mNN1xGLo7QfPeqjXMDnL4mRjVao4lxwHK2vOJbnRA1GZXtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491941; c=relaxed/simple;
	bh=9cmF2GIZnkuckUwXIe/6ZUSA7xPcRfShiAABcerXDrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqkueRdw5Z52DMZhn/fsQJwxqB++5yySuHUPPxw1n+smgIrauDfL/Ug9s74S2Du925Rk0m+9es7GYtJRNMzqbw2sPxIVzvJVYKA+ELMDvuRQR0ViijDo/I+a+vTKI07nYCYhOmX4WEkIt2eN/vk1RWpVb3wKC1TpDbYO4xCRQZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JebU7lX+; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pErKY2qc29AsYLV1/5U7gfi24qPQ/mt9K/FjX4vZxJ2rcA2qwoxKdbn64+MIeJi4jnGjKsDwLKxwOBYWzwyOTGsvf8yLgwMi61c+YZt5p3P9YBWJ1WUHWqNlD4o+jp4ZLKKRGx8nqv/2BgBVixMisVSENtwX0+Iw4E/tV0qsqbBzrMdzWOt8BSOIYEY/VAOXdM7CKhjXWcRnkAjJd96LUZOp4VpcEXJXXeXpup6QF3uD87J69hbQ5QwphIiv4hW8vuSPHhXWmTMkOZNP6Nz1gzid6ija4Dr//qvaUd7vTFqyphDNmGprMu4yKoFBHFJgtni+i7Q6bZ7iacfvHadmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRke0kQkqsrccmcWScj2DUzADwLkGpQ8YcQrRjbTI+A=;
 b=GHDkkU6ND7oY90s8bR0oK0HGMeGN9IzOzg/AYH9x9q9zHQVqpOtlp5x1vJ5Ce4i1ixzxEu63k4xE9iXqLh94t/sE2mf6w6SqLzu7CcWKKQqSRGFPFrTPvqa9XD6bpL0JdLcxaUe/M2tLDiRJ/kS4LKtPqPkwn+zD49NqbwS26buRzdbQrfjTbU59LePqE3Mn9PYm0nG1l1ywACVZqG+kskWObuFBJm9B0aqypeueCOY7NUNUlMntZd7qx93g8Usazsp28g6uhXuX8qoJEhKaqHucnUgBXpch+WaIxaxe6/9G6/DC0gqirFbS4dXw3ZeNzquOXeCUxMO3SGoDaPQhlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRke0kQkqsrccmcWScj2DUzADwLkGpQ8YcQrRjbTI+A=;
 b=JebU7lX+jcPKOXbbkxRJ8JCj9SbY3+ARsdXxa3QJJ4jdhkA0juDKFyM4vewdbz77X49FljqjGQvlX/+XS00LaIdbnLv6Z6wu5ur23xIMs3CAK359H5qXy4jMdmrg3yCjKpUzTuy8PguNqg5lz2ZfUy+Bba14uEDKRuGA2A6SLbHs+BEfLftHXTdGpGliyT1GPcFxazr8NEuGTp68BweU3NzNb5lW61pV6kG6vBe7HLlBZoDGVGgBb4/a7aDcm3FQ29v1bClxFoAJqnFwrXNROmcT9/W/pLgo5QGICfKvYxSdUp8QUKzI0yIrg6Gd5g93wGl0wl1+ej9bOPC2VzT+mg==
Received: from SN6PR08CA0016.namprd08.prod.outlook.com (2603:10b6:805:66::29)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 16:38:48 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::e) by SN6PR08CA0016.outlook.office365.com
 (2603:10b6:805:66::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:38:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:38:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:38:41 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:38:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:38:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v3 01/11] iommufd: Move struct iommufd_object to public iommufd header
Date: Wed, 9 Oct 2024 09:38:01 -0700
Message-ID: <9277a0c4058e49f821f8219d1ba4179b74aafbd9.1728491453.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491453.git.nicolinc@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: a40144fe-3a43-4b22-60a5-08dce880d9b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+OOB0H2igzsQhzQMigz7MTqjvqdMX+TpNPvQoSgl0GzP9Q7SzXt1btGYNXdl?=
 =?us-ascii?Q?vIbczLACXp8LU8EXSbkGOODmUdkqgosQQP4abLoS4Ad+lCM2PABQntMUwmY8?=
 =?us-ascii?Q?d770BDXHM4gOjVIsk21BftRiqZ94A67PLKjELBF3g1o0jAioTnuN1MPL3OvX?=
 =?us-ascii?Q?lV+TxC41Z5BrY4lg6jzfl/y7Y4VXf106Gn5ogLlyiichGwg1tTa4H0rZJBDT?=
 =?us-ascii?Q?PcguSpK+H9jQ35ugw0fFiADewzq7NqJ2jNDFRfHD3rErQsILsaOqUmIQHpkN?=
 =?us-ascii?Q?y+JlorFN16BGUxWCRzMTrXOAibbSwgZVfCf5an+5jxP3kuqhKKLsCbk24cJY?=
 =?us-ascii?Q?YFLKBWjOTLcR/ocg/sf5VoDlbd7qTQp9Yb9i2eii0QdZnuMza8n4mTLtdIPk?=
 =?us-ascii?Q?LfnK6Bay1ywKxTvXuo10UGqr/CxxyLoCZljk8ffTMQEwPUDfzLpfIVvvEK5E?=
 =?us-ascii?Q?ukaSqOfr1/aYV35xX4j65P76um82jU3Qa31Dlwh6UjTmqgIkBea8gynxBpRV?=
 =?us-ascii?Q?Qn8ny+J+2NQH3628myUE9lSzb1BYmd3nS1W/GQVqu5/cNMLLWfpGJ/RWvnLm?=
 =?us-ascii?Q?jIwi0c2ttIm0boi00kux40f1x75IKVJifqs2iqeLsmiAhFxwzw+HEUgXqlPE?=
 =?us-ascii?Q?CgDvLcsv4QVVgsh7gDx1H9UxDnBKRZdwiSvx5Yz0GRqzrbNVYM/lGMYNyfj3?=
 =?us-ascii?Q?1VhFhomwfQJ54ygzNZecs5jwe01+6UiAGTwgl4/tpOxrrd+fVSpM2UwzIejg?=
 =?us-ascii?Q?jm4mIeZ4+2gW3Z0k5dV2yvdNf+RHbcbJZhk95uqcV4paaq1Ho3XfmlwKTKt0?=
 =?us-ascii?Q?LAP5FhpKsNKKaNti6Wsf0uxD3f+rWJR10kRc4kN8JMfTrmr9FkDyWSBNdK6C?=
 =?us-ascii?Q?xG0iDz/uElGPJNKLEJFPud4OTNtItdbU3+S5WadF1k9fMr6T+4szvsR+gka3?=
 =?us-ascii?Q?I3b2nUnWdyNJNYGEi0twPUYL8uncJpzQKtClsNba2spsdr8clBXowGcxAyIz?=
 =?us-ascii?Q?JaIHlu6YlKi3Eer1Pl26xH5EmPz/yPAD76aVNY08cS9IGJKsAElucBgeaJXa?=
 =?us-ascii?Q?UY62yUnDkBIl5DoBr927lCuthPxgPuKAyV6v8PkvV3ct4Y1B5exTsKWKmYYw?=
 =?us-ascii?Q?Q/ySZVHZrVyJ6uOggSaUUCCc1WnOZCMoCUEG8k12gFrgj49jYF1b+Bp++utJ?=
 =?us-ascii?Q?IxrchJXiKwbxrlOkjyT8UrLDfKXwtXbvAAJoakoMgAOJGVLoNhktPHmM3CUI?=
 =?us-ascii?Q?ilUiUnG+stflz+C7G3b7WEG50nmT4l9wmb9b3LUiQbuu68EuEjoPTgJmm4Yl?=
 =?us-ascii?Q?D4L2plxDdxhOKdKqJM786/VMKrBzM4wN/gL1IiBvygrnykapfxbdFuYcPUxJ?=
 =?us-ascii?Q?/JJJTYprXeZpCcLMF7BLAU3iSLDl?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:38:48.4871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a40144fe-3a43-4b22-60a5-08dce880d9b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629

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

It has to expose struct iommufd_object from core-level private header to
the public iommufd header.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 10 +---------
 include/linux/iommufd.h                 |  9 +++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index f1d865e6fab6..7221f81ae211 100644
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
@@ -137,14 +137,6 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_MAX,
 };
 
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
index 30f832a60ccb..6b9d46981870 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -8,6 +8,7 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/refcount.h>
 #include <linux/types.h>
 
 struct device;
@@ -18,6 +19,14 @@ struct iommufd_ctx;
 struct iommufd_device;
 struct page;
 
+/* Base struct for all objects with a userspace ID handle. */
+struct iommufd_object {
+	refcount_t shortterm_users;
+	refcount_t users;
+	unsigned int type; /* enum iommufd_object_type in iommufd_private.h */
+	unsigned int id;
+};
+
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 					   struct device *dev, u32 *id);
 void iommufd_device_unbind(struct iommufd_device *idev);
-- 
2.43.0


