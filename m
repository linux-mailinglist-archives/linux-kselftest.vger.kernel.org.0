Return-Path: <linux-kselftest+bounces-43146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A519EBDBEA4
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 02:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03CA74E845A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 00:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1FD1E0E08;
	Wed, 15 Oct 2025 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tp20m2p8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010064.outbound.protection.outlook.com [52.101.193.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A118DB2A;
	Wed, 15 Oct 2025 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760488281; cv=fail; b=uBZ16poBNaPiw15MKZt2eLWT0kI6sV9E+UEJW/iW4ewSZmJswktfPaKmhCOTSWkjJp+gfo3Cq1u0N1Bx6eDhf7M/bNg6OR+DTM0ejCf3c3uLs9FqmY3W/422cMEDrY89vr52j5F4wxkB7wa+VPR5oUy1GskbwIESpZl18UGwY1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760488281; c=relaxed/simple;
	bh=Wjhl0SP3wsA1BjYqRLpmDrTFEolSnDSqXcsaqwCa/m0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFvfjulbWv76Hgsi2Yr6hL8hP8Of3auC+muf14Mpv9AvNJO+OyMIXNjpT3vnCpaxycmml1YURQyH4pZ0YyG9Ug1qEADprlww02nSAF9kGIEMXpoZZaJw3OiOXCNMU0TiqUvRbFCowjHh3S+W6l6mkeBh67y6htrhEoC+weGvSJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tp20m2p8; arc=fail smtp.client-ip=52.101.193.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f05L0zKO1ZXV9POv9xtxkUm6HPkoRUSQOz2kaL1gd3yWoAL7YEyhb1dMaloiZSZKqiqC2lWdFHncvkFP8BiaJ8qgtD0b623DMVz6mJibARpbl6EnH4h+HVV4FU9NyKD/dHNl09xXAnt2Uf1SBPaXUhuKHKxioytTf1v+8ZLL15M6cUVPgi/krQISPaVbs6cwaLiDPK46RlVkoX8tEt4pXbX2hewpcnWBfY8naDwPT1QyyhPVmeizLNhndJEHXyZPLOcGZSiE3nfLdwo5zujbfklK08RBxwCVSW54Z8TdQVHfeY/OWEaWyu2StbuIKm689OaCu6wYdfZBxB5EOXRThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KOQ4My7VzJiA7KMadZI+EKh8bm6WBVJoosytlD12KY=;
 b=UOV1Smgu1xHQgIothqATQBf3INK9JOmum7SbMcWlWJRV7wrSMB1uJiQMKFEu7He3R3IHFO36D0nPfNQ4z4mGpXFeRx0J9SkQ1yiyTEJ9YPLUhYXfeLq8DIu4zeNRfcCZRnkSaRLz/c1SMqJalijq1pT8UIDwxRWp0YF1X92He8cd9OOaTd5ecj4DIEKyyMFzRBakcghZacwo8NPKZ/rKUeK6+kRrqu11mfQ5fKI00apQ5VwvXtE3h1fG51UvNxtdiuS/ekWZQu7LylMzVKa+5gWuNdJ5CRWW9LeEuBbPUoidpyzWtR3Ns4GmpEHusHF1bHA+qHGHYqx4JKjFUOhAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KOQ4My7VzJiA7KMadZI+EKh8bm6WBVJoosytlD12KY=;
 b=Tp20m2p8EwpUtAHwuqc4l/RDay7RJVlHqw+SrNm/hFzwOwEdGzn1iCkZZWXkPzHVTeSU9ci/UpmATsom67FHp9p5juIsWHPqjbk+kPuNnD28cg1XNu4Iu0D5NpV1siKmr41kKrZHTFWdjidWJyQ0bHdhdHvoPxmL+x46mgyTFWN2Opps8bsSHjhefpfpVrQJpAYtl17vKeXC7fuQkFo+1OgaLl7gLOaLNQhzxrUG4LigK+2UWyur2Rgw1xO7cnvPDY3J7u/Z+qRn7QIRNsQdGIH80+y6svzSsZT6mX/OG7SGR+JNQ9jXFSClSsntr2zPJ1s9EidWy2HYVKZwF55IYQ==
Received: from BYAPR03CA0002.namprd03.prod.outlook.com (2603:10b6:a02:a8::15)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 00:31:17 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a02:a8:cafe::42) by BYAPR03CA0002.outlook.office365.com
 (2603:10b6:a02:a8::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Wed,
 15 Oct 2025 00:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 00:31:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 14 Oct
 2025 17:31:07 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 17:31:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 17:31:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <shyamsaini@linux.microsoft.com>
Subject: [PATCH v2 2/7] iommufd: Pass in idev to iopt_table_enforce_dev_resv_regions
Date: Tue, 14 Oct 2025 17:29:34 -0700
Message-ID: <3b472e5f2b3c69ef2ff3aaf1d41532400aa5cf28.1760487869.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760487869.git.nicolinc@nvidia.com>
References: <cover.1760487869.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6b6e3f-4f16-43df-539a-08de0b822769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3YUAZFr4ApYvt0dD4X/VWnjM9OrZM8dmdEj6xB4HyV+x10gaXSV7FNKhMz2O?=
 =?us-ascii?Q?Id154JzmC4SebFqtKwScPljM3tsb4Zv3pZl4dByY116zb/k8refJLUYor9WS?=
 =?us-ascii?Q?BBtJUOuh3ZVPjZGCLwl0YaSqOjc5lBUjyycvWPF29q7jmC6I3ZSpiMEQZL2S?=
 =?us-ascii?Q?MD6WnZDEkM9UkCdx0llnVNIMx26UaYjNQpqaKFuayHRYN6rTGNIHi6cOjjB9?=
 =?us-ascii?Q?NyHNad8X0gHWFRm0/x9B6HuPrxF4jXnCY6RzLiw/hg0FA1sPKCPGluDlUxkp?=
 =?us-ascii?Q?H0w4sm14AgTWxusaSPD5EFsjd4IKQBAghsqWWErAkfsQ9RQvyfPtwDX3/JE6?=
 =?us-ascii?Q?pic3/O5psSYpKeBpPq2V/dEAWjpFBbpkmJUuqgkc5rCNe3Q3L5j8cTBEAUbH?=
 =?us-ascii?Q?jmeHQyphdWyUNuG8VfgRQDJZ7qLPWPALqINBHFx/jTyFIYx0eAiR9aXOoe2y?=
 =?us-ascii?Q?I5QBBZj5dtoXZ+zNIzANZFVb6CcofVLRnSlqSR3dvIgNL73YdDy3F9O8aVgZ?=
 =?us-ascii?Q?2e1nXkNEzeQJuihLM1+mD5ux2WPqjnT0smU36hDke60pXqa569WMJh/7+ciw?=
 =?us-ascii?Q?/wwj9L22q7ZgryFJ4kblxr3/OqOYPcKc9l36NC8d7VhFe14oKlevc/KHU3Qe?=
 =?us-ascii?Q?ca7FCOOX2PsRCkwhU+/8+lTj10JVVvfe77GWHwG05LcPGk9u1fg1lylAtQg1?=
 =?us-ascii?Q?UEe9FkyjacrIWi6JLQrXbwf4E/TomixarZWxMMiV/CMQ9nT5/auBlYRB62oH?=
 =?us-ascii?Q?BGrkli1hTq4Onr7mFNQEEoPMz6fB77dvzyNCLQQBBtiMV0aZ/Fnsyi8Mxz2S?=
 =?us-ascii?Q?84YOXMUXbx2EauVxJKb04UlD998dXOxmkAU8cYH1UzOyhdD3/wS2kw5UVEzZ?=
 =?us-ascii?Q?9grEeE1h8a8/tIJUnOwfIVcwid01ATeXP2DuQHv7FbolfdSZ+2JLnSWV+Vv8?=
 =?us-ascii?Q?epcYcdGoMfwa4kGMWPeglWzZccPtp3asRQXYaGcCK7v9EtkxGus4k+z7T49J?=
 =?us-ascii?Q?QpvresGoDHKM9/v5XGr7SJ/JLYMw2U/mwiqna8gS9kFWIRM/c6EDwfsPHFMr?=
 =?us-ascii?Q?9a3iyTfvRm2UkU0tn1L1+jvN799wV07ZvjohvlkI+Kxdg7J89StvFfqXlNJQ?=
 =?us-ascii?Q?br8GuCrx7OGANftPUYX6Bt/zf8rKHUB8mK8yhpCowPWLgSLbfVP1Zf0PVZOy?=
 =?us-ascii?Q?37K5hzr6RtfzR6I2JzVzLHdzTtlitnaxsmdIQX6YghGB2kup3pA0DELDbn95?=
 =?us-ascii?Q?4g9hxJvKYwgtyvU3Qvu2bHyBBNH6PwcXldxcZl1r0cB9psYzb9yWFLtO1psA?=
 =?us-ascii?Q?TlwgCSSFxsEKZdNyXtcU/BCaPYiHPtG07YPwEczwGQssOYFI8BK6sT7ApEIM?=
 =?us-ascii?Q?02AmbboIABvemHX7dwW8+yBCXXcZGjkxDPJ/hx5xIo8bpqf0LPtVpBNnq7bt?=
 =?us-ascii?Q?xidARzuU672OvbYVOL6andHQ3ZIX3BODfF3OkqQD132gravjSQJXzeckm/CV?=
 =?us-ascii?Q?eeEGfW8jbXun/ZtYXNglW6UrTJlJwN3JcNMUhYV/s4NPxh/F1YVGzXuCnmxp?=
 =?us-ascii?Q?S0Z2aT+5FZq4Scrav34=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 00:31:16.7598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6b6e3f-4f16-43df-539a-08de0b822769
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708

The per-device sw_msi window, defined by sw_msi_start and a size, is from
the IOMMU driver where a static IOMMU_RESV_SW_MSI region is defined.

But soon user space will be allowed to configure the sw_msi window, via a
new SET_OPTION uAPI.

On the other hand, the iopt_table_enforce_dev_resv_regions() will need to
access the sw_msi_start and sw_msi_size stored in the idev struct.

So, pass in idev pointer instead to prepare for the new uAPI.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 2 +-
 drivers/iommu/iommufd/device.c          | 5 ++---
 drivers/iommu/iommufd/io_pagetable.c    | 3 ++-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 73e5cddad24e9..cc758610b9f7c 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -132,7 +132,7 @@ int iopt_table_add_domain(struct io_pagetable *iopt,
 void iopt_table_remove_domain(struct io_pagetable *iopt,
 			      struct iommu_domain *domain);
 int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
-					struct device *dev,
+					struct iommufd_device *idev,
 					phys_addr_t *sw_msi_start);
 int iopt_set_allow_iova(struct io_pagetable *iopt,
 			struct rb_root_cached *allowed_iova);
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index ea7ed32bbaede..2a816533dc10e 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -418,8 +418,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 	lockdep_assert_held(&igroup->lock);
 
-	rc = iopt_table_enforce_dev_resv_regions(&hwpt_paging->ioas->iopt,
-						 idev->dev,
+	rc = iopt_table_enforce_dev_resv_regions(&hwpt_paging->ioas->iopt, idev,
 						 &idev->sw_msi_start);
 	if (rc)
 		return rc;
@@ -762,7 +761,7 @@ iommufd_device_do_replace_reserved_iova(struct iommufd_device *idev,
 	if (!old_hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas) {
 		xa_for_each(&attach->device_array, index, cur) {
 			rc = iopt_table_enforce_dev_resv_regions(
-				&hwpt_paging->ioas->iopt, cur->dev, NULL);
+				&hwpt_paging->ioas->iopt, cur, NULL);
 			if (rc)
 				goto err_unresv;
 		}
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index c0360c450880b..dee0aa3e7cb4a 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1440,9 +1440,10 @@ void iopt_remove_access(struct io_pagetable *iopt,
 
 /* Narrow the valid_iova_itree to include reserved ranges from a device. */
 int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
-					struct device *dev,
+					struct iommufd_device *idev,
 					phys_addr_t *sw_msi_start)
 {
+	struct device *dev = idev->dev;
 	struct iommu_resv_region *resv;
 	LIST_HEAD(resv_regions);
 	unsigned int num_hw_msi = 0;
-- 
2.43.0


