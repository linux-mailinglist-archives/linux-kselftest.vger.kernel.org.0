Return-Path: <linux-kselftest+bounces-33263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821ADABAD3F
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDBE3BD3C5
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC57A1FF1B5;
	Sun, 18 May 2025 03:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iJSdEWr0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E512C544;
	Sun, 18 May 2025 03:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538550; cv=fail; b=pm/NZHmnfBZmu77+52fvA/ZX4WPjf8KYfwCbH6AdMXcWBcgd4O0p6t/sKcZbfX6mYI9YNBhSDJtUlYE7qv5Rmzo9yMSJ5ZugntUSrjo9+yovYnn/LnC3V772Z0gfTVTWFAkSIYK9gf2320ru+rLNJfXp9sMqvMXBF77t0x53GJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538550; c=relaxed/simple;
	bh=kPqJ4BUKfL++pQ91hcaO95E2R8rUiqztiQXXHNSLwR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=my+GwlZ2dF4LaT+DXoSsnlsMLiz1d/XODPUmG8W8B9sqmqOI1V9WKBZPhvTbsSvPEbufdYO7N30YQhaU29A+QOitgs0imN4w+zpEbkQhcT9VNA4kkpV1CMvb3T6rduBAfG+tK0/3s0KsmU9I20+ah34LA7VnYar5CD870vrXpi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iJSdEWr0; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8GcvjEmYAO6/W0zJfNS+Iwr9ABCpjxJWlifEDtMg0Z4l8kL/NqbloNBA3DDAZXGhR2Z2hMTsmSrIN8EYbzKNV2oO72eWIDcGb50Kst1orBi6tU1OQyXS543DY5A3OvORn4d4+ONFB7XAZlcyUPpGh6NwzcD3u8ABEfDXrtULamTrayvj3wb+y580LLjJw4PFyk+DI4JCIMMVgN/1fOxX3eoOMFxJEkx5zQdQEy/oHbREsgc1M3wvjLVpJpodtf3ML0uDJTT5VDgtujrSIjaDnDOORnbPwipH1aW8W2mqRCPJQC1ZJHBsdkPoyB9FgzIjBsrk+v2d8e/3s2y8TKBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YFmUpAGT6PXInGcsxu8AkBldyfLgBUue95u/c3yrgU=;
 b=r//OgdG024gztNZyQRlMXjRYc13cDyahouD9t0894aKiDucyW+QfX0MnwsUYqi8wwQQl9PReqriWA7Mb1pIgdtrlHTZQgbXfqu5x1RIo/C8KNVgJ1TRRWHA0eELaHqI73KlpyKwoHlYzNsKxndLwp5JCpxZSqfApIByI7f0rMtD0q+eeSgyA2C6r5/Q3nuQdm+tZf41MeM1HwfWCB6kE5mrGOGvtSp9BdjbtlHoYREZGMeTIGKgecnXmmwmwgaBvDIRKylYAPchVglrAM2OIc6zLs9bwNoLAFVC75uhvLnwhdRPbmxWl4ThVRQMtAiHnYqDmlH4zmD80dUv1bSglsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YFmUpAGT6PXInGcsxu8AkBldyfLgBUue95u/c3yrgU=;
 b=iJSdEWr0NXbDj3/h42YbLaI4pyFL+/PZTYWBvrZcC5KkqMpvBd4FpmWT+VauzIBDpOHGj4CdqA3VO6eyooSzQQIpuy3YNapAxKHh1CnGoWLoQkMNoEnauHVe+TKKdbCcsMDGKGZSyG9rR6Ef6p9CAiwSnpKgwLkrmlIGeme5z0EtQm8bB30MW7Oe5Bz0BT4p0Y3dznK4FLN00xLXUqUQWoNOiqR2lqniVSwjrtIL9LQEqhOeE5yTv2Nb2U4srS7f3hc/mKuHBSxbe+txksF/Voat7Pqlha91ehJvO8CVsRaKoX7dIrrh0jxeXSGUoZapMOFsYl5El9d+96sFF33bXw==
Received: from DS7PR03CA0313.namprd03.prod.outlook.com (2603:10b6:8:2b::18) by
 PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Sun, 18 May
 2025 03:22:23 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::82) by DS7PR03CA0313.outlook.office365.com
 (2603:10b6:8:2b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Sun,
 18 May 2025 03:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:12 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:10 -0700
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
Subject: [PATCH v5 09/29] iommufd: Do not unmap an owned iopt_area
Date: Sat, 17 May 2025 20:21:26 -0700
Message-ID: <3ddc8c678406772a8358a265912bb1c064f4c796.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe3d187-2434-4586-ee96-08dd95bb34ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+xBfzUiwZVzn/NvyXVEZty9xa1mHykIcB5aogZXpxWIGbLcIOyg7umzNY52r?=
 =?us-ascii?Q?XUIa5B+BGGAnxpuy9AhoYPiBR+bzGaXLgFShwhKqD3d0uJyPghMZCE7f20kU?=
 =?us-ascii?Q?NMm7bWnM6zhFQlTq0BgyIl/U0rr4mnL9CgweZqmu95wX38Ha6oeAvBZ4DREN?=
 =?us-ascii?Q?3mSTCKD8DRFsblZuFW1/ZbTC9dtrm5XX5rOb8UoSOEPlR3tJmSHfsmMHNm5r?=
 =?us-ascii?Q?ImBsapqC3TvR4ZTBQWXn3ojCAPwKJzohuaiwEq+ctNmIXzxNHkDiAuKH8W1K?=
 =?us-ascii?Q?b8xFn+ql/4L6KyxvRcHmV1e1NBWqVrURCmWwHFVCVdGzLFcZZNHQEfIeA0oo?=
 =?us-ascii?Q?Yu4UGJpQn+t9rSBDdf4bhh9MfhlkAHbLAJfIdeOQ5GwDC32gSKWFvgbJMCtr?=
 =?us-ascii?Q?Gq4/smzLNRFQCi45iAMitb2Fy21+KhG1ift7oEKg8lm7WUZEhitm57fqz1kG?=
 =?us-ascii?Q?+4kNIZJj644lKhF6u6/RiIwJ3Bnt9awCUjX2Ca2SV8Njfel5iAoeL4LwfJz/?=
 =?us-ascii?Q?9I+qkgOOvq2/dl9I4cCwoPfERHXxa7q88veREK6S300q5283ZS4qZczR8uO+?=
 =?us-ascii?Q?ccM83PDNWUgHsd7R7w3Auv17ieryHKE42aKQHWYktvh7LxePA7OZ2Ea2fL6A?=
 =?us-ascii?Q?HmCYd8POFYq93zvOiWwUnElEeEgoaVgmy9xPMgby+KhQg1MG5uvcowpsL4fO?=
 =?us-ascii?Q?Ek5nwauhPWQc7uw2zaNzo4JB/xCYgnGuPFFU06fZpKyEIubDS5cZ+uawJ4s0?=
 =?us-ascii?Q?G2z2jPjSlW2zX4tPUR2xpXNw7IUFj+FYFtMg+hKXgeSJrCWyHCnjfs5E2ate?=
 =?us-ascii?Q?FxEDDJcSzr3N/wCo3ETsMCg5qSzX+d0mJ+v4xMVd24birm+dpALM82UCDD16?=
 =?us-ascii?Q?s6wl8QSKYs05cqDqTZp9kloFomHz+AJnZwA/59W6Bjq22lP31DmpLooAp/ub?=
 =?us-ascii?Q?RKE949geXsAs7cPxn6+yZCPetU0SnSyofbBJiMY0rpUty1Qbl8lWHG4j5B87?=
 =?us-ascii?Q?6DAWr/w4cNBm1Dsar86J6+UtA7E6gMP+W086zH0V/d9mwYFYJSbaMsGH6zqI?=
 =?us-ascii?Q?fVxl6CCNL8MLt/kdN+EofYLQBdp0e5R7WD2V8H5hJRSW2GNWGRqDYJKapOWA?=
 =?us-ascii?Q?iqTXVO+yZm750a37VueN93OQqRlbEvEX1ptrX5kjRdSpqDm6XAdtPLOC3/TY?=
 =?us-ascii?Q?SUfg/DEfHSfudk+D6Q6rVlzIQm9LHGlJ8rlGZvbaTwFz3MQJR3yXZ3bU7bWa?=
 =?us-ascii?Q?SdLBXOaBrnzvnrPGovUTN0orIcc3sb5NT3UlwtL+oHWL9fAqqCOxDKbOAzbz?=
 =?us-ascii?Q?ppUTe4swdcWCNzbfR8U5jU+dopAoMoQZH/TCb+7LVMwxjDoCZW/q6zwxOxeH?=
 =?us-ascii?Q?XuPBTgeeTHX/IqA9aHw9zbfbk7719Y/d8+PmObeyzBuVPxG2EnkyEOczA0Y3?=
 =?us-ascii?Q?N64qaz2yppvUco9hDpiieUz7vvQeT1J8FyS6k2upGcUnC3tThT/Gsyj05i2I?=
 =?us-ascii?Q?spubRvl25nZFee9/x0dj8M/tKlj6fEO+Kq2k?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:23.4742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe3d187-2434-4586-ee96-08dd95bb34ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422

Do not allow to unmap an iopt_area that is owned by an object, giving this
owner a choice to lock the mapping in the iopt.

It will be used by vIOMMU's HW QUEUE structure that must prevent the queue
memory from being unmapped in the nesting parent IO page table, until user
space destroys the HW QUEUE object first.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.h |  7 ++++---
 drivers/iommu/iommufd/device.c       |  8 +++++---
 drivers/iommu/iommufd/io_pagetable.c |  6 ++++++
 drivers/iommu/iommufd/pages.c        | 12 ++++++++++--
 4 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index c115a51d9384..2f2a47a2f9ee 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -48,6 +48,7 @@ struct iopt_area {
 	int iommu_prot;
 	bool prevent_access : 1;
 	unsigned int num_accesses;
+	unsigned int num_owners;
 };
 
 struct iopt_allowed {
@@ -235,12 +236,11 @@ int iopt_pages_fill_xarray(struct iopt_pages *pages, unsigned long start,
 			   unsigned long last, struct page **out_pages);
 void iopt_pages_unfill_xarray(struct iopt_pages *pages, unsigned long start,
 			      unsigned long last);
-
 int iopt_area_add_access(struct iopt_area *area, unsigned long start,
 			 unsigned long last, struct page **out_pages,
-			 unsigned int flags);
+			 unsigned int flags, bool is_owner);
 void iopt_area_remove_access(struct iopt_area *area, unsigned long start,
-			     unsigned long last);
+			     unsigned long last, bool is_owner);
 int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
 			 void *data, unsigned long length, unsigned int flags);
 
@@ -250,6 +250,7 @@ int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
  */
 struct iopt_pages_access {
 	struct interval_tree_node node;
+	unsigned int owners;
 	unsigned int users;
 };
 
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 16c17ae1f5f2..2b1ed5c8dc5b 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1265,7 +1265,8 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
 			area, iopt_area_iova_to_index(area, iter.cur_iova),
 			iopt_area_iova_to_index(
 				area,
-				min(last_iova, iopt_area_last_iova(area))));
+				min(last_iova, iopt_area_last_iova(area))),
+			false);
 	WARN_ON(!iopt_area_contig_done(&iter));
 	up_read(&iopt->iova_rwsem);
 	mutex_unlock(&access->ioas_lock);
@@ -1356,7 +1357,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 		}
 
 		rc = iopt_area_add_access(area, index, last_index, out_pages,
-					  flags);
+					  flags, false);
 		if (rc)
 			goto err_remove;
 		out_pages += last_index - index + 1;
@@ -1379,7 +1380,8 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 				iopt_area_iova_to_index(area, iter.cur_iova),
 				iopt_area_iova_to_index(
 					area, min(last_iova,
-						  iopt_area_last_iova(area))));
+						  iopt_area_last_iova(area))),
+				false);
 	}
 	up_read(&iopt->iova_rwsem);
 	mutex_unlock(&access->ioas_lock);
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 13d010f19ed1..51efebb1c6ed 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -719,6 +719,12 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 			goto out_unlock_iova;
 		}
 
+		/* The area is held by an object that has not been destroyed */
+		if (area->num_owners) {
+			rc = -EBUSY;
+			goto out_unlock_iova;
+		}
+
 		if (area_first < start || area_last > last) {
 			rc = -ENOENT;
 			goto out_unlock_iova;
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index cbdde642d2af..4793b4de5fca 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -2111,7 +2111,7 @@ iopt_pages_get_exact_access(struct iopt_pages *pages, unsigned long index,
  */
 int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
 			 unsigned long last_index, struct page **out_pages,
-			 unsigned int flags)
+			 unsigned int flags, bool is_owner)
 {
 	struct iopt_pages *pages = area->pages;
 	struct iopt_pages_access *access;
@@ -2124,6 +2124,8 @@ int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
 	access = iopt_pages_get_exact_access(pages, start_index, last_index);
 	if (access) {
 		area->num_accesses++;
+		if (is_owner)
+			area->num_owners++;
 		access->users++;
 		iopt_pages_fill_from_xarray(pages, start_index, last_index,
 					    out_pages);
@@ -2145,6 +2147,8 @@ int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
 	access->node.last = last_index;
 	access->users = 1;
 	area->num_accesses++;
+	if (is_owner)
+		area->num_owners++;
 	interval_tree_insert(&access->node, &pages->access_itree);
 	mutex_unlock(&pages->mutex);
 	return 0;
@@ -2166,7 +2170,7 @@ int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
  * must stop using the PFNs before calling this.
  */
 void iopt_area_remove_access(struct iopt_area *area, unsigned long start_index,
-			     unsigned long last_index)
+			     unsigned long last_index, bool is_owner)
 {
 	struct iopt_pages *pages = area->pages;
 	struct iopt_pages_access *access;
@@ -2177,6 +2181,10 @@ void iopt_area_remove_access(struct iopt_area *area, unsigned long start_index,
 		goto out_unlock;
 
 	WARN_ON(area->num_accesses == 0 || access->users == 0);
+	if (is_owner) {
+		WARN_ON(area->num_owners == 0);
+		area->num_owners--;
+	}
 	area->num_accesses--;
 	access->users--;
 	if (access->users)
-- 
2.43.0


