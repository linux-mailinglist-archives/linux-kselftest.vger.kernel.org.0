Return-Path: <linux-kselftest+bounces-33258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC84ABAD28
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407F73BCFF8
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490881D5170;
	Sun, 18 May 2025 03:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kqHUx/ze"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E7C19E967;
	Sun, 18 May 2025 03:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538537; cv=fail; b=p2eeNcJlo3M5xksC8mzRMahKyMCwrQmPaiWmiP99NhmoirLJ5wlXUPUbLEcrMDTweeGt/nSpQwwukz/P7pw5+3+yjV36gzsOAzXBv7/1STsudIJ55rfstkpFf3jMz3Qvb4Lblsn3T9B5G8M4+FKBoObbXlbRbKP2nvqSIYC69A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538537; c=relaxed/simple;
	bh=Oe/JdbZaypP0h+CEaLN3JbZzxNlUFuSXYkMYvldweNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t540PTn7V0uQeUV5bItklm7mz1QCYTYPPNx6VOJZ1kuhgdica/pLJXwBg6Ggu5qgdAfaRbLRNxp4CvEnK3bTIk7Js3TjvznFKUcSlbOJHgNm5jymqLMWSoaExKlrlTFgAh4/EyN5s1pmxFqtAG1HwGSdkCQUvX6C0L/UpyRoAV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kqHUx/ze; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYDd2hbgadCkqHfWfGNMflAIU2/C63cQVD+P31wVkUeOsP5/B2NFTYNA3RtanGFSlz/cfShoiWOoqiJMKoGT+gkcWl4TPHa+YrW2QN/xiyZ3Po8pWnOFcF2mmLaIdWdWVGAh22uUeZzTcuR0Bk74me0teQQidiEPZGlX+HT2OoGLLBeBUhXupzZx0H8+wl6LlRtSA3WaBhZtuQ8jhs76ktnagHUgP2llbILI985442R9YlsxtsU/jb9EU1vnzpour+vMlQ5CvRnHQGV5VitxH0RUCaSBel3/UjJgangloXmusmCK2IEdsJvPrkLFjNrUvPDkc7pUFltREY3txz1/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdctZXusSeRo/0JzP5Ku+y4S6F0TRPiy0MwB0oLAw+k=;
 b=gZexE482RJAMtRebBgxy4Id3/bucSte96Zqg3U9sMWWKbP9gs+FLeffsPgDPg5T4AgbuzWT55FdMmA2HBR8WSOJLYo2fLJckA+8RAoBL6LGhOCy7lCcSKmb3Yq5eQwff6m8OqQpqH9dp4FZZTL3xx6KecsDYpnQ74T2mu1lQBKKnS64SL3hR9IqNhnMYgGJz069RfVEPl9eX8wlL2DdERMLArdp8nEEu32kG9TgUW4TBVlYyuLzEqsO9sFc5V1Nrh5+n5hpvwqXjaZXnYETvzi3k7m4jTcAw7emvKAlLEpBgUpkjOPwNG+xJzOgDRYo6nJHO5gFYguDo0K48IQpa8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdctZXusSeRo/0JzP5Ku+y4S6F0TRPiy0MwB0oLAw+k=;
 b=kqHUx/zekrRxOwoX0fsA111ahMJ3W2JrksXFEK92bgCJ9nfF5zX9HpMmd/nQ12w5wfaud5leoGe/0cxwJYBA69Mm3WRZhUel0n5POKvkWIVpWDNPQ7IqpU3hEop7XCTWCVthkLJCz6sI/5Y01dJbsEfK8t3tzwDCiPhYjNJ5iNrXxkJFs8AJ3pN0cuV/U9ceHYpdZADeZUPBJmJMVUHjzSDbB/uAFPmJiofJU6tzfjVAYelIFYKK8mnZ6y3PWtJIPKux62IueAGBOWDRnGqgFKdyByQtTyZKFEq5ww6RsP2HQrQfd3l7tbHXLGHnDwvWtgL2TRZXz5Ll05xeMHGmEw==
Received: from SN6PR08CA0026.namprd08.prod.outlook.com (2603:10b6:805:66::39)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:22:07 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::1) by SN6PR08CA0026.outlook.office365.com
 (2603:10b6:805:66::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Sun,
 18 May 2025 03:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:21:56 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:21:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:21:54 -0700
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
Subject: [PATCH v5 01/29] iommufd: Apply obvious cosmetic fixes
Date: Sat, 17 May 2025 20:21:18 -0700
Message-ID: <af4d5f74f9e4f1298624f230a7f6e430a9866acd.1747537752.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747537752.git.nicolinc@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d61e7c4-4d01-4e1f-7218-08dd95bb2b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2vivHB45PxpDhJwgXFg3VLUpLBSLmKNBcfGvCQdY6WOR0/vWXCD5t5BuHq+W?=
 =?us-ascii?Q?vgu93Q0cs9grTRFmOJSvi4MmRnFuRS9174m3fLZR0LK6bBEXgtz4gMegiG19?=
 =?us-ascii?Q?MJkYRblED3WlnZsnDAKwR7mDA/hmZqb52SCR49v/jP75rdd9aZCrezXQmZuL?=
 =?us-ascii?Q?QkAxgc1eTcpilDwbNwST83AhH5n5BvX0uMqsLJLtwBjhUvTmK4YMNXrfZFhm?=
 =?us-ascii?Q?B9XMisIPDdE5uW23APIUiJiYb9WFlzPfr8SmZABciOEb+HhxDHA6H9N6uHXK?=
 =?us-ascii?Q?scKejQsxHc3qrZz76/29IPVYdhIJ4opg8ZJywykWYGRubVnAJ1tkX9xdKiIL?=
 =?us-ascii?Q?3uw/MiYUXlF6UWigSvIyPRDP4HisFW/JSQq6YGd6KQmyStWAcgG/d+h4gl/L?=
 =?us-ascii?Q?tw6lZtTPmEbhq3zdiWrJ9lUQayGArT+aHE9XJmle6/6HqYfh1OWbd6MhRcpp?=
 =?us-ascii?Q?gJAVK9+LuGQKeunpLkey9FSwqO0KCz7gSykFEwFoDUY47mw8rQYwIvjIPT0m?=
 =?us-ascii?Q?GXhLkajygjCgcQG1T7EbpaG9t+W/6CObhRaDkn0SuKdfD8hE6nieaCy3VDts?=
 =?us-ascii?Q?JvxycrbyE+Y7D7yfQOJVoaTt9Ns41GLpDeFYVKvG32nq5ze0iOXM7jaCZl1z?=
 =?us-ascii?Q?4e2gEox3BCigr1EAh80Sr4OdbMOujopc2Huer0aTdXAUgqxQweA5W/1MjATk?=
 =?us-ascii?Q?fdJyOWFhAmF/JhhLUc65IAbc+mPw8RYju7nh2czECxZiXsxjy1KEsVR9mSnY?=
 =?us-ascii?Q?GD7ov2Y/5xNqswNqsfurIwP7H4YulhsbeYtmfeuUhzASFPK5H7GcBJwMNRKJ?=
 =?us-ascii?Q?i0+QLZd/ffELyIeGIFK3FguVr4LT6f/6+3TC9sRTUgRDDqvIcCGuAhTqaVQy?=
 =?us-ascii?Q?FvFQNp5uvUkDdilgBtjIQWiIAcVkiL27bCQbL2tCfQ2d8fMzqaggmd54RllH?=
 =?us-ascii?Q?XsnN31LNWqLFFej5UhW4hbMQIz6FSgw7c88ll3kgeRsbqr90Fz76htK86U8V?=
 =?us-ascii?Q?S24UW7eJ/hQhAc4wA3CB6Kjya8jW/9IHzaUnHtOX8RXv/3vybelCLBP18Ad/?=
 =?us-ascii?Q?+n+d72Eo3VoxoFucw+7OFFUNJlLvrRJewveOhSHlDucMrIgjeThtwWoKDfg7?=
 =?us-ascii?Q?NRAVaEtwRSCYbMutrC8cgg9BhhF1rE+cFHEvMg6gZ/HwUuT0I65Nnuu5YhcX?=
 =?us-ascii?Q?8LrpUDC+a5GgXqBiIFbStgK20uNsa0yRs/mYIntdcqHXi0Upt8jYYYUphhEU?=
 =?us-ascii?Q?PZ6/c6Puw0nwNNWEQjmHBo0LB70vGHwUN6Tx6kjhT8uPduafAZcQPD+YqTwW?=
 =?us-ascii?Q?Lf5L9VDIEviAYqHuwXVGksUnAQar6V2pI+vKncYK1sgTajwo/N3kgPb55NTx?=
 =?us-ascii?Q?BX8CrvQJar2VPrF69LAj0JDhvAkMfPuyS2O+vlkFDQP4s/VKkKpGHUj3X7Gd?=
 =?us-ascii?Q?HwIJzAwgOJ8p/yireo0GxKIq9Y23KIOlLouYgHuqWaODDyEBpbps0emQmThG?=
 =?us-ascii?Q?4yEZUIE71UTdybFlQEb+KAuMu+u8VM0gXFmI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:07.4174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d61e7c4-4d01-4e1f-7218-08dd95bb2b60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681

Run clang-format but exclude those not so obvious ones, which leaves us:
 - Align indentations
 - Add missing spaces
 - Remove unnecessary spaces
 - Remove unnecessary line wrappings

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.h    |  2 +-
 drivers/iommu/iommufd/iommufd_private.h |  6 ++----
 include/linux/iommufd.h                 |  5 +++--
 drivers/iommu/iommufd/device.c          |  3 +--
 drivers/iommu/iommufd/hw_pagetable.c    |  6 ++----
 drivers/iommu/iommufd/io_pagetable.c    |  3 +--
 drivers/iommu/iommufd/iova_bitmap.c     |  1 -
 drivers/iommu/iommufd/main.c            |  6 ++----
 drivers/iommu/iommufd/pages.c           |  9 ++++-----
 drivers/iommu/iommufd/selftest.c        | 24 +++++++++++-------------
 10 files changed, 27 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 10c928a9a463..c115a51d9384 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -240,7 +240,7 @@ int iopt_area_add_access(struct iopt_area *area, unsigned long start,
 			 unsigned long last, struct page **out_pages,
 			 unsigned int flags);
 void iopt_area_remove_access(struct iopt_area *area, unsigned long start,
-			    unsigned long last);
+			     unsigned long last);
 int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
 			 void *data, unsigned long length, unsigned int flags);
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 80e8c76d25f2..10899e2cd34a 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -266,8 +266,7 @@ struct iommufd_ioas {
 static inline struct iommufd_ioas *iommufd_get_ioas(struct iommufd_ctx *ictx,
 						    u32 id)
 {
-	return container_of(iommufd_get_object(ictx, id,
-					       IOMMUFD_OBJ_IOAS),
+	return container_of(iommufd_get_object(ictx, id, IOMMUFD_OBJ_IOAS),
 			    struct iommufd_ioas, obj);
 }
 
@@ -455,8 +454,7 @@ struct iommufd_access {
 
 int iopt_add_access(struct io_pagetable *iopt, struct iommufd_access *access);
 void iopt_remove_access(struct io_pagetable *iopt,
-			struct iommufd_access *access,
-			u32 iopt_access_list_id);
+			struct iommufd_access *access, u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
 struct iommufd_eventq {
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 34b6e6ca4bfa..498c9a768506 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -171,8 +171,9 @@ static inline void iommufd_access_unpin_pages(struct iommufd_access *access,
 {
 }
 
-static inline int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
-		      void *data, size_t len, unsigned int flags)
+static inline int iommufd_access_rw(struct iommufd_access *access,
+				    unsigned long iova, void *data, size_t len,
+				    unsigned int flags)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2111bad72c72..16c17ae1f5f2 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -473,8 +473,7 @@ iommufd_device_get_attach_handle(struct iommufd_device *idev, ioasid_t pasid)
 
 	lockdep_assert_held(&idev->igroup->lock);
 
-	handle =
-		iommu_attach_handle_get(idev->igroup->group, pasid, 0);
+	handle = iommu_attach_handle_get(idev->igroup->group, pasid, 0);
 	if (IS_ERR(handle))
 		return NULL;
 	return to_iommufd_handle(handle);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 487779470261..8565a6f596b2 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -309,10 +309,8 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	refcount_inc(&viommu->obj.users);
 	hwpt_nested->parent = viommu->hwpt;
 
-	hwpt->domain =
-		viommu->ops->alloc_domain_nested(viommu,
-				flags & ~IOMMU_HWPT_FAULT_ID_VALID,
-				user_data);
+	hwpt->domain = viommu->ops->alloc_domain_nested(
+		viommu, flags & ~IOMMU_HWPT_FAULT_ID_VALID, user_data);
 	if (IS_ERR(hwpt->domain)) {
 		rc = PTR_ERR(hwpt->domain);
 		hwpt->domain = NULL;
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 8a790e597e12..13d010f19ed1 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1410,8 +1410,7 @@ int iopt_add_access(struct io_pagetable *iopt, struct iommufd_access *access)
 }
 
 void iopt_remove_access(struct io_pagetable *iopt,
-			struct iommufd_access *access,
-			u32 iopt_access_list_id)
+			struct iommufd_access *access, u32 iopt_access_list_id)
 {
 	down_write(&iopt->domains_rwsem);
 	down_write(&iopt->iova_rwsem);
diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index 39a86a4a1d3a..4514575818fc 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -407,7 +407,6 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
 
 update_indexes:
 	if (unlikely(!iova_bitmap_mapped_range(mapped, iova, length))) {
-
 		/*
 		 * The attempt to advance the base index to @iova
 		 * may fail if it's out of bounds, or pinning the pages
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3df468f64e7d..347c56ef44d8 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -102,9 +102,8 @@ static int iommufd_object_dec_wait_shortterm(struct iommufd_ctx *ictx,
 		return 0;
 
 	if (wait_event_timeout(ictx->destroy_wait,
-				refcount_read(&to_destroy->shortterm_users) ==
-					0,
-				msecs_to_jiffies(60000)))
+			       refcount_read(&to_destroy->shortterm_users) == 0,
+			       msecs_to_jiffies(60000)))
 		return 0;
 
 	pr_crit("Time out waiting for iommufd object to become free\n");
@@ -539,7 +538,6 @@ static struct miscdevice iommu_misc_dev = {
 	.mode = 0660,
 };
 
-
 static struct miscdevice vfio_misc_dev = {
 	.minor = VFIO_MINOR,
 	.name = "vfio",
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 3427749bc5ce..cbdde642d2af 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1287,8 +1287,7 @@ static int pfn_reader_first(struct pfn_reader *pfns, struct iopt_pages *pages,
 }
 
 static struct iopt_pages *iopt_alloc_pages(unsigned long start_byte,
-					   unsigned long length,
-					   bool writable)
+					   unsigned long length, bool writable)
 {
 	struct iopt_pages *pages;
 
@@ -1328,7 +1327,7 @@ struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
 	struct iopt_pages *pages;
 	unsigned long end;
 	void __user *uptr_down =
-		(void __user *) ALIGN_DOWN((uintptr_t)uptr, PAGE_SIZE);
+		(void __user *)ALIGN_DOWN((uintptr_t)uptr, PAGE_SIZE);
 
 	if (check_add_overflow((unsigned long)uptr, length, &end))
 		return ERR_PTR(-EOVERFLOW);
@@ -2111,8 +2110,8 @@ iopt_pages_get_exact_access(struct iopt_pages *pages, unsigned long index,
  * This should be undone through a matching call to iopt_area_remove_access()
  */
 int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
-			  unsigned long last_index, struct page **out_pages,
-			  unsigned int flags)
+			 unsigned long last_index, struct page **out_pages,
+			 unsigned int flags)
 {
 	struct iopt_pages *pages = area->pages;
 	struct iopt_pages_access *access;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 18d9a216eb30..8cd98a72767d 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1179,9 +1179,8 @@ static int iommufd_test_md_check_refs(struct iommufd_ucmd *ucmd,
 	return 0;
 }
 
-static int iommufd_test_md_check_iotlb(struct iommufd_ucmd *ucmd,
-				       u32 mockpt_id, unsigned int iotlb_id,
-				       u32 iotlb)
+static int iommufd_test_md_check_iotlb(struct iommufd_ucmd *ucmd, u32 mockpt_id,
+				       unsigned int iotlb_id, u32 iotlb)
 {
 	struct mock_iommu_domain_nested *mock_nested;
 	struct iommufd_hw_pagetable *hwpt;
@@ -1454,7 +1453,7 @@ static int iommufd_test_access_pages(struct iommufd_ucmd *ucmd,
 	int rc;
 
 	/* Prevent syzkaller from triggering a WARN_ON in kvzalloc() */
-	if (length > 16*1024*1024)
+	if (length > 16 * 1024 * 1024)
 		return -ENOMEM;
 
 	if (flags & ~(MOCK_FLAGS_ACCESS_WRITE | MOCK_FLAGS_ACCESS_SYZ))
@@ -1471,7 +1470,7 @@ static int iommufd_test_access_pages(struct iommufd_ucmd *ucmd,
 
 	if (flags & MOCK_FLAGS_ACCESS_SYZ)
 		iova = iommufd_test_syz_conv_iova(staccess->access,
-					&cmd->access_pages.iova);
+						  &cmd->access_pages.iova);
 
 	npages = (ALIGN(iova + length, PAGE_SIZE) -
 		  ALIGN_DOWN(iova, PAGE_SIZE)) /
@@ -1547,7 +1546,7 @@ static int iommufd_test_access_rw(struct iommufd_ucmd *ucmd,
 	int rc;
 
 	/* Prevent syzkaller from triggering a WARN_ON in kvzalloc() */
-	if (length > 16*1024*1024)
+	if (length > 16 * 1024 * 1024)
 		return -ENOMEM;
 
 	if (flags & ~(MOCK_ACCESS_RW_WRITE | MOCK_ACCESS_RW_SLOW_PATH |
@@ -1573,7 +1572,7 @@ static int iommufd_test_access_rw(struct iommufd_ucmd *ucmd,
 
 	if (flags & MOCK_FLAGS_ACCESS_SYZ)
 		iova = iommufd_test_syz_conv_iova(staccess->access,
-				&cmd->access_rw.iova);
+						  &cmd->access_rw.iova);
 
 	rc = iommufd_access_rw(staccess->access, iova, tmp, length, flags);
 	if (rc)
@@ -1628,7 +1627,7 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 		goto out_put;
 	}
 
-	if (copy_from_user(tmp, uptr,DIV_ROUND_UP(max, BITS_PER_BYTE))) {
+	if (copy_from_user(tmp, uptr, DIV_ROUND_UP(max, BITS_PER_BYTE))) {
 		rc = -EFAULT;
 		goto out_free;
 	}
@@ -1664,7 +1663,7 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
 				     struct iommu_test_cmd *cmd)
 {
-	struct iopf_fault event = { };
+	struct iopf_fault event = {};
 	struct iommufd_device *idev;
 
 	idev = iommufd_get_device(ucmd, cmd->trigger_iopf.dev_id);
@@ -1795,8 +1794,7 @@ static int iommufd_test_pasid_attach(struct iommufd_ucmd *ucmd,
 
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
-		iommufd_device_detach(sobj->idev.idev,
-				      cmd->pasid_attach.pasid);
+		iommufd_device_detach(sobj->idev.idev, cmd->pasid_attach.pasid);
 
 out_sobj:
 	iommufd_put_object(ucmd->ictx, &sobj->obj);
@@ -1967,8 +1965,8 @@ int __init iommufd_test_init(void)
 		goto err_bus;
 
 	rc = iommu_device_register_bus(&mock_iommu.iommu_dev, &mock_ops,
-				  &iommufd_mock_bus_type.bus,
-				  &iommufd_mock_bus_type.nb);
+				       &iommufd_mock_bus_type.bus,
+				       &iommufd_mock_bus_type.nb);
 	if (rc)
 		goto err_sysfs;
 
-- 
2.43.0


