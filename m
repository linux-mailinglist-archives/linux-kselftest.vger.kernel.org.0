Return-Path: <linux-kselftest+bounces-20336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8039A94A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834591F23832
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D9C1CFB6;
	Tue, 22 Oct 2024 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oD3jqmF7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69A14A18;
	Tue, 22 Oct 2024 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556422; cv=fail; b=SjAj4b4X45/thMag1EdJswHCQemTJNBm+Wnh6AomkxKWyYed/rGVoVH6u6KfC+spkexd/ZQEcdLQ8slc8L5BlLnofde9xb+I8uEko5X3B+SlI9WdXe/aaVgzZSoJ19URonFRAkEr7lRDXIGgolBTUrXNkHByXgAqNACjNNY13rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556422; c=relaxed/simple;
	bh=z67RZ/1Qpw88A5yOnrP4tXY2nkV9jbGx5ncLE0sIC2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDoMcKykz1oLvS7j4TBEMK5RNQC30eV6GLRJiKob7/FvrZ4s7b7lTO1wXDC5wIiX3DAaOEtLkj8h6QgrOSAXzjqVKT+xEzlkZIBc9QiUBMm78h8OhRyCkyV1MZbRyJC/xp4dXb7SdvuIfKLSuexpIZ7BNMDAGBVT9uIMNk5Apxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oD3jqmF7; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqM1T5Q6oNtRMzu67sSxpp/iQrX3RHxaoHjGTtUl3UJRWYUdD9LUkKsfKY5Xs4NfQCMyo14rOQldyrJSOxqYF9rD7aVZi98vwJolSODiVOgEB6uLQOFCnfzekstW/SsOrzIZ84fLyhzwHFUQby0dScuuuqo00H1rr3LpYOzUAzvL2b+QNST9ypfk8Lnbj8l9/cubYtINpG7Xh1momGg9vvGTDEOulRTR3y0cy6BWBhipjoU89SVs7192ZihUxihlA30UnabJFbXnwmHfZY12j/9TKVRyq0p52rNqCq+Km1JawgBj0EjGt3JPUmFH5SkZSgdjYVSEKmC4NwwFejm48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+EkijV/Aru8LUJiN5jaZmLE0ssCHKJJ2dO4w4rK4Is=;
 b=UtHzNosE/Cvv1z9flnkg8LvsR21eXm4g67MxSmNklkoFi5sfnnb8TXU4brzdGHvsAZ9s4Lipi5l2hXcEoyGeANxo77WUbxewbuXyyMrtCzd3w/nqyhkFKuhKWvRHapH05n03E6TNt7wmEsasu5VvvNjCG85Crwwv43OedVLpurUMXjkyFMtLgKxYDDKEG9UH8aJDpi/8lVapxsZ6NXNWIJ7wz7RT/l3bfqk1L21h9s2k1Vil1ekor9yJLbqqmTY6zc48K4nwztT5UYwQfmlCCFQM5oJHVui7wFMoxMXM3PiDXk1/exPALWGAyreoYxHs47rs162LkyYkNrPN3+NO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+EkijV/Aru8LUJiN5jaZmLE0ssCHKJJ2dO4w4rK4Is=;
 b=oD3jqmF7RDzoIi1QU4zNrdeiBrFYHxTFrHJHApsCzbmBfwKbMm7iu2HOPpWu0L51/UaMJBJDcGBqxrrmwLaLsc6+iMhZbL1YgPi0Q2lQa+oclB7OeUUAwre9re3gfGMrJPdhO6f3juuKsdPX9hw6rynnY6TE+T4JnIC2gu5zYQI2JzNgYalYyfDwDeO9smGLnsyut9Os7ZdKGLPVx5qk95qnP/aJ8uv/rXbP+ul7H3qefhP1Ta+aj72EK0DdVejE+GcDIiZQA3KAynUhnDdOPlIOUEsWxZgJW9o15j1jbpZhLj0tKmmbLsTEtzAS1gs0aiGmRyP+tN5jltsZiHO+qQ==
Received: from BN0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:408:e6::6)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 00:20:15 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::40) by BN0PR03CA0001.outlook.office365.com
 (2603:10b6:408:e6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:01 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:00 -0700
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
Subject: [PATCH v4 01/11] iommufd: Move struct iommufd_object to public iommufd header
Date: Mon, 21 Oct 2024 17:19:23 -0700
Message-ID: <1452c535a2e6a6c61f38fa752132db7e88b55770.1729553811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729553811.git.nicolinc@nvidia.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: e59aa6a1-d663-4e67-de90-08dcf22f4d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hpIUxeYF5jwicsz0KhY1nomIP3+SlR/jn0VMNDYDOIOmxiGws2GGB8XEd+M+?=
 =?us-ascii?Q?u6v4JMMzfvzCIKlc861mcesuGn52XBE0na9/ONQPG/vXG3XqNfT1VmY50yX2?=
 =?us-ascii?Q?gR8GMUwmMtAPgEmLhl+Gg15t1D8huJLa2DznLobz7KUAvMs431gE9nTqch2a?=
 =?us-ascii?Q?bYaYUj+1McR7QROqRxPl5vtWic31yHMRhGSvMAtGf8pVx0gZh/ht5SoZQdgP?=
 =?us-ascii?Q?s8TkUcSK+FNrvwjcUZ1h+D6UvPHFF6AjwNfVmfI3rbfGFRVZZ1EV6xe4hQnd?=
 =?us-ascii?Q?J8P2To5M6CCLXCR6fO0OHbwTXKOrp7o/FbNOfTyQ6FwV+n3WrSPyOx+05nye?=
 =?us-ascii?Q?xB+LD4zv8W9V6xoMYg2iMgCISJMBaFv2LxWLzlrc4J65CDyDJd195P/lLcJk?=
 =?us-ascii?Q?bLD1YLvqwETwQqoIfeXSIsf8CSZxDcO/c5CiFE77FI0iQtgvEP7KLO5uG3XL?=
 =?us-ascii?Q?3Y+XqxpMVEvQETngdA8SSm32AKqMWDXObzykQdoclli/KefHmEXWh4C1T6wl?=
 =?us-ascii?Q?vvj//T8VusJh3rLM5thHDhKzezRBRFp4zv2Fd8ISDO/5J/9BbRL7+HEhlScT?=
 =?us-ascii?Q?pO4XCszrVXZzapM7iuJ6A2tXBnB1Tn1FDOLAIPbsL09eMftHkS6e4GbtRAXd?=
 =?us-ascii?Q?xZ2PcfML6S0IOF7Kh8M7K1Eyg6Pxv2uQty4ruwYlW0mQ+MANa8i0ov3YHTNv?=
 =?us-ascii?Q?o3eyCvBbgBj5xkcqZkvDuuMW7W1a/3MhdcotnJ/J622DEdatHpspcEapyVCK?=
 =?us-ascii?Q?w1XUUU0e/baD21pEoj+9IMZw0L6GvUsBWWMJKZI/nMQzNEZUHOrv3GWGCIii?=
 =?us-ascii?Q?yOoSsYUp4FQ+BUueTqnipNf96C4R52uAIXd0zUfVu4X2e8oews3lZWvc+aNk?=
 =?us-ascii?Q?v5xr+iRQ1jNmsO/NlsJPQO38mlmlRCG8IEaRHVPg0irKgTSmH9ucjohA78gC?=
 =?us-ascii?Q?iKzJMvI4YrXR2uP4sgXS9Ml5b9tvKI7EWCyoZuELl7I3qyIHa7Z0aVpZSCun?=
 =?us-ascii?Q?3hd0zU88jmXqtRokD+ftirnQ9NRuyv8L8A4cJKmxoRm4W4gdumn/HbuXHVbs?=
 =?us-ascii?Q?DIBreXG77W5tf6PjkCkwazwdzirm1c7BlwHxZWqYs9exnqKvrLXnOVsn3v7r?=
 =?us-ascii?Q?SNmP3qNgEDt6GzZ+7dbmhdGQiKmLGB08KwicElT85niYfxwKXUX0uwIdht1a?=
 =?us-ascii?Q?sbKSkbAPHSAXfsaxXP2KngdNwmAKMFUCsPG9msk0IhRjBltS3TidDkLVu4Cz?=
 =?us-ascii?Q?lbTB3zra7kMp/r44jXFyJLfq7skAwhBPnQuq9E7MF9NEtmH3pYJmOWORUXe9?=
 =?us-ascii?Q?ppYGC7EE0i55n+YmJzqh+8x6XXrDox9f69uOryU1+0IQn6mseTyk8UyjqosC?=
 =?us-ascii?Q?fkjFkRvOOBekyD0p0zmrTLcFjju3ODE+UtYMYVpze4iKAbBhAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:14.7351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e59aa6a1-d663-4e67-de90-08dcf22f4d05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319

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


