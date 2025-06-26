Return-Path: <linux-kselftest+bounces-35898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C118DAEA6B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48C51C2889A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15762F3C12;
	Thu, 26 Jun 2025 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rtDHYXbZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C132F0C62;
	Thu, 26 Jun 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966544; cv=fail; b=JEdIJeg5lMz91VJh9qx9E0mwSuqRpqybZngUMc7Xnz27XKsNctZ5ZcVcIRWh73vFaEcqLp9vRjtULZHlVlUe2aw4j1cA8GBAbTDRaEIZgO1yp9o2vPojUng0GNLLM7KfUajwVcth2R/ZnQk/Eg4qKBg7oliBbfAP4JslCF4QTqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966544; c=relaxed/simple;
	bh=cCLvTfbMBlJ8l03DPVxam4GekbNodgZ2UKwBJHaJgps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biukaD5rmPm5ZactqWfOhx8v4kH+a48bmXdW8WbgyFe6VvP/TLT+7krPrmCWAD3LHIIbGIq75Txp6gZB5MqR834eiIzR/TkLrqiJFjE6aWpYHi7b+PB/TG0xG1BUWR4y8hY9Jp6qTJqwRrseTBvmFw+ianPx767xpsU4MxN9zEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rtDHYXbZ; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jl8I8ww667PzZSs9Ye7P09PlZdsA6lfOTcbBhp6gyQ5hF3C1FdwUxtGGnOu/EwwqDC7Tal+/29Rku4kHzK6zAa9RHEZP3vYP+UfKLQKxeJ7kngZDJR9qKf30MWwpDF3cGfO+QUihD3a3LS12dwhOqd/hd6zp4IcPET2V0ZU00Alh/pjRrITY0wfDla/ZiuAILxeweHTi5624blsAA0FPwWgRDMZbGT8I9lNHovzEdnHngW0WesvObhnIJL0dhRjbRl39JpsU/cXgowQwzpzCtZIbAhUMDoLdJw5c3m8481wC1wt+oPgeN+UmxdcD5OVkN+dCdYsOlCFPtJvh5YdmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNbDi7OI0FcH4lAdvay1ikhroQhRs4W+k/Xp24dkFY4=;
 b=IVq+BNuZ5kVaosKVjKiWcKDQbdH794bzG5Lpp/ISW0fsoB05/YI4Fri4clfk5LnDYnurr/bV2Na//E08ncpyLwWE+bp73yN3GQ+C3GAqxgkcSwq//4dlehl3dAq5r8kbm9Gpxdro6vMMiTqdov/ZnAmFmuwVluHum4TqwYwE8zGpChlWa95L4H3u3fnZUFnHcYJcxraeI7nbLRWQHtWQhVMvrSECBVswRcL8TrQ5/YH9GA9Y4LH8tpJA8lJ4Fcc6fEZTLGljyxLXAXIZ+kfeXwTwVvfj0nMPljej4cAR9OM2GZR5kR2iUz50gWzx/1UjLYxYs/PiYHSpLlmIhfbTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNbDi7OI0FcH4lAdvay1ikhroQhRs4W+k/Xp24dkFY4=;
 b=rtDHYXbZfE8EGx1aToYKVoValhcxPOKOYpPcD1ZfcnhTqoxBPJZH2Fc1MKNUffkKwLXpqeE8YJV/1TvMYkrO0eLFueqNKIUklBFys7VUoeai4ye5JiO/Ad4epIsXY8A6LqWP2dPHqQ8UJ43IfevesCV2OzwwYbG+hdG88NE9Sxmj5THMTOvCYUB/iPbbqcy2sI4RgYsPx5AFtZklQ/7GZCfgC00wxn32cSjY7LCMgleE8+bXiSVErzXuENsXDwMhl0tc141rjmWu2pNwgwjTdTX/IDd3sfZjBdwOY/FQ3hi3+xtLi4F57cDTdfJEE9lhEZUwaBkQxlxLWbTog9PmDw==
Received: from BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::16)
 by LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 26 Jun
 2025 19:35:38 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::76) by BY1P220CA0008.outlook.office365.com
 (2603:10b6:a03:59d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 19:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:19 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:18 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v7 09/28] iommufd/access: Add internal APIs for HW queue to use
Date: Thu, 26 Jun 2025 12:34:40 -0700
Message-ID: <77c6f6ddbcb32c83487d0ee58993726bb92671ed.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|LV3PR12MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: d8691325-5cd6-4ec7-ecad-08ddb4e8a103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NeTYIoDB5P4MpBw1urMD0QStamEWtP5BGlVMj1GTzweidJTYV7AGtQKUJfB1?=
 =?us-ascii?Q?nQ9I/ydbhD0uhCmVwwmpfe4igSgl+4pz9EJ1I0vIj7am6IagAJAQTQR9xLbz?=
 =?us-ascii?Q?wFSXu52y0CcNFiWFZ9wLan4iFD743vOMjJluqsNgYr6n9qOuzJJ1s8liPxXr?=
 =?us-ascii?Q?kBkLxOwyLhmxpEkPCfrgmIcv4vc5JUO09Q6aPMZzqFDFbEOENa1VR5v8cIoZ?=
 =?us-ascii?Q?ezsWS0L8++kgIn1WP2gD8NUhnnIESH5R5RhbsCgO6snz5lQna7H/TJWGKIhL?=
 =?us-ascii?Q?2hbLUMPVo+1ZPy9dPVD3IEr7de3b7MhNZfThhWb8ZFcJHTtz5zH2aEK3LyvK?=
 =?us-ascii?Q?HufGZJLpC66s2ETyZVNAvhY31XvEvJA2qtcCXXOmmfGbCuqCtwNMTznIeWRn?=
 =?us-ascii?Q?HL4egCuU+TNFAVIbYntdydRx47r1JAEh7NB/XqtCN49oc0mg3aZHf0MZsEAf?=
 =?us-ascii?Q?BsZj0t02PGoRzjlCGXtzv7jzYtGKutLvC8HSdVHtzB6ogROOkh/RBC/VeC5p?=
 =?us-ascii?Q?+nxnKxYfJB7dWzYcXeajN+m/4pNZdN81hqy/DjnbY6nxyU+8i0GSk+XARhsj?=
 =?us-ascii?Q?TMW8toVVB4kOzUd567QLW76kFytTgrtnDPfjqt3lWFpPQS+qqzNOJoDOmNsC?=
 =?us-ascii?Q?1ha6Q2OyZcdeNW4hdk6zMYXbV0au0ZwKhtWMZ8GHc2qMDOErYlQHY/j69t75?=
 =?us-ascii?Q?2sScRXY4x855XcE41C62/qSwfPl5VmBXDMMAzpuguxLPx6uXbSWP55lDBGg7?=
 =?us-ascii?Q?aYmhUqeQGwVdJmnzQuDItjaNmS5M+LUaKwKQWyOXEII2Bn250tm6G0EqGeWT?=
 =?us-ascii?Q?pqBOak3YD4mReDbUbNgIpq41j2K6jovkBmIiZL7ZPcx+tEwAy66zXLUgX0YO?=
 =?us-ascii?Q?bVftyZxSWjqvo9WtzK5En9mIbbfNsa/NaewNr/Stb9oMkeNJA7ss+zIW7nZs?=
 =?us-ascii?Q?c7yUnxDLgIznhQSsbKZd1jihrjkDebxGKqEl+j1hgbZNBtqr36NDtjmiAUNI?=
 =?us-ascii?Q?Aw2VHeijaniBDA2xiDWmaRUQv91MlgD58nzoqIAtG+6cvQGxzwd8alRoU4K9?=
 =?us-ascii?Q?sKpjGpimkX6UBsbmWVmcf4CBeK0A1kNie7yDLfCnAlJOLR7yeKjUDoYs/7No?=
 =?us-ascii?Q?WAjnmsqBHM84dnLry5l0yS/tmZoehReBnwXOt3HdHi0hBgVifwv0hioTDjaf?=
 =?us-ascii?Q?0F/JRBhgfjPbKN6MXZBhG1hrjmFo5DWbR9pAbh5aTcwv+rz9k4fsDUyozAjS?=
 =?us-ascii?Q?4kbCY+5Gj6faUWKVAwW88o65lODEMxHMNlDh/hucjTppxIGfzN/PS+qJwGhB?=
 =?us-ascii?Q?jhnrRkYUFukX5cgUgjNpxdWJnOeMOGdseFA/sLDR/K5Dk0ypbNOQBoJOf/jy?=
 =?us-ascii?Q?R9Jj+8jeJhB3qGbfeK+MDTFgnEnRfAzENLaJUOJSfPf1JAAZVu2ZecVoSWYW?=
 =?us-ascii?Q?t/F+I4e39lLvm2o6Rubc6wVJRGNJWbUvq+VPuylZRX/SBTgdBJpDOjjlxSbw?=
 =?us-ascii?Q?17Ii+ipzvnQpgBG1E+T7sV/5MMUrO8/H69MU?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:38.2561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8691325-5cd6-4ec7-ecad-08ddb4e8a103
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330

The new HW queue object, as an internal iommufd object, wants to reuse the
struct iommufd_access to pin some iova range in the iopt.

However, an access generally takes the refcount of an ictx. So, in such an
internal case, a deadlock could happen when the release of the ictx has to
wait for the release of the access first when releasing a hw_queue object,
which could wait for the release of the ictx that is refcounted:
    ictx --releases--> hw_queue --releases--> access
      ^                                         |
      |_________________releases________________v

To address this, add a set of lightweight internal APIs to unlink the ictx
and the access, i.e. no ictx refcounting by the access:
    ictx --releases--> hw_queue --releases--> access

Then, there's no point in setting the access->ictx. So simply define !ictx
as an flag for an internal use and add an inline helper.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 23 ++++++++++
 drivers/iommu/iommufd/device.c          | 59 +++++++++++++++++++++----
 2 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 09f895638f68..9d1f55deb9ca 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -484,6 +484,29 @@ void iopt_remove_access(struct io_pagetable *iopt,
 			struct iommufd_access *access, u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
+/* iommufd_access for internal use */
+static inline bool iommufd_access_is_internal(struct iommufd_access *access)
+{
+	return !access->ictx;
+}
+
+struct iommufd_access *iommufd_access_create_internal(struct iommufd_ctx *ictx);
+
+static inline void
+iommufd_access_destroy_internal(struct iommufd_ctx *ictx,
+				struct iommufd_access *access)
+{
+	iommufd_object_destroy_user(ictx, &access->obj);
+}
+
+int iommufd_access_attach_internal(struct iommufd_access *access,
+				   struct iommufd_ioas *ioas);
+
+static inline void iommufd_access_detach_internal(struct iommufd_access *access)
+{
+	iommufd_access_detach(access);
+}
+
 struct iommufd_eventq {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e9b6ca47095c..07a4ff753c12 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1084,7 +1084,39 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
 	if (access->ioas)
 		WARN_ON(iommufd_access_change_ioas(access, NULL));
 	mutex_unlock(&access->ioas_lock);
-	iommufd_ctx_put(access->ictx);
+	if (!iommufd_access_is_internal(access))
+		iommufd_ctx_put(access->ictx);
+}
+
+static struct iommufd_access *__iommufd_access_create(struct iommufd_ctx *ictx)
+{
+	struct iommufd_access *access;
+
+	/*
+	 * There is no uAPI for the access object, but to keep things symmetric
+	 * use the object infrastructure anyhow.
+	 */
+	access = iommufd_object_alloc(ictx, access, IOMMUFD_OBJ_ACCESS);
+	if (IS_ERR(access))
+		return access;
+
+	/* The calling driver is a user until iommufd_access_destroy() */
+	refcount_inc(&access->obj.users);
+	mutex_init(&access->ioas_lock);
+	return access;
+}
+
+struct iommufd_access *iommufd_access_create_internal(struct iommufd_ctx *ictx)
+{
+	struct iommufd_access *access;
+
+	access = __iommufd_access_create(ictx);
+	if (IS_ERR(access))
+		return access;
+	access->iova_alignment = PAGE_SIZE;
+
+	iommufd_object_finalize(ictx, &access->obj);
+	return access;
 }
 
 /**
@@ -1106,11 +1138,7 @@ iommufd_access_create(struct iommufd_ctx *ictx,
 {
 	struct iommufd_access *access;
 
-	/*
-	 * There is no uAPI for the access object, but to keep things symmetric
-	 * use the object infrastructure anyhow.
-	 */
-	access = iommufd_object_alloc(ictx, access, IOMMUFD_OBJ_ACCESS);
+	access = __iommufd_access_create(ictx);
 	if (IS_ERR(access))
 		return access;
 
@@ -1122,13 +1150,10 @@ iommufd_access_create(struct iommufd_ctx *ictx,
 	else
 		access->iova_alignment = 1;
 
-	/* The calling driver is a user until iommufd_access_destroy() */
-	refcount_inc(&access->obj.users);
 	access->ictx = ictx;
 	iommufd_ctx_get(ictx);
 	iommufd_object_finalize(ictx, &access->obj);
 	*id = access->obj.id;
-	mutex_init(&access->ioas_lock);
 	return access;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_create, "IOMMUFD");
@@ -1173,6 +1198,22 @@ int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_attach, "IOMMUFD");
 
+int iommufd_access_attach_internal(struct iommufd_access *access,
+				   struct iommufd_ioas *ioas)
+{
+	int rc;
+
+	mutex_lock(&access->ioas_lock);
+	if (WARN_ON(access->ioas)) {
+		mutex_unlock(&access->ioas_lock);
+		return -EINVAL;
+	}
+
+	rc = iommufd_access_change_ioas(access, ioas);
+	mutex_unlock(&access->ioas_lock);
+	return rc;
+}
+
 int iommufd_access_replace(struct iommufd_access *access, u32 ioas_id)
 {
 	int rc;
-- 
2.43.0


