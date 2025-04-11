Return-Path: <linux-kselftest+bounces-30516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EB5A85471
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52EEE9C0FD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 06:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F698285402;
	Fri, 11 Apr 2025 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mr7I7bIq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C50283CBB;
	Fri, 11 Apr 2025 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353535; cv=fail; b=XYV6wCKZz5CIIi6M2M0ApxPSeC23S/tRNYCTmhgE9HTGiQH+f9twfuheANHCF115Dls127lVys3APDzJdsN2vg/CeCygr1B1fzaoEKgI6z8bk5P0rCP/Opsa0IQqZKUptF4PD0DYIq8CT2oS4vnZ3K0NNMkVNS3xMAq8LN1ZmKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353535; c=relaxed/simple;
	bh=X+eUEKocwoHX/IuaXrMMLRw2a4ZVXayE/cSv1/bh/zw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVYdJikuNXQb+fmA55gVjdOTdPsx/BN9z10Bl/LPse0qDZRndwcvoaFXSDfuwRDYSTMRm273/DgiFkZmZOSYpIaRNa5CAM0ymzN8MpAu218Xx+bGIiggj+rRdxGK23rcRdKcGEdUz55Un30cA+xzLzfp3gGbPoEFk9PO4Wyjm7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mr7I7bIq; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWKe5M0t6v1veGHZttwh7safgskQIl3Hlasi0iJXP2yLa7PByhOGZJCMpwjz5xrsDD7lYQjRPjdJ2XuEGcDUpMJxVD8e5tUvCwPwPoi0I80axMQ9mGgB4mmyJi8id23TmaxwEo33R8Nig/o4VRQTEcGl3IrAf1u9WyDu3By/DzkBiK5OiOOP/nBKfQ5rBthejtbyujo3f1t21xAimGO52xmEiNH1h6Wun4gxPb3t57MOyOX5ORvRwan3QamaIM4NVqc95/hi54CvKeXbbfEzvtFXFtJMNrliWRvVDESc2bFKdBifYDI8uhTmTqRzB0szqghNjQPMTRFS4KwL6Mkbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=concBdNiyvs4c5xn8sAxndmrEeIA0PFYQNUF9Eo4uCM=;
 b=EVb6dJ8vgNtixQ4qQhaSYbJie9UWDnrAbxLiwA1R+9Q6uH+guvAuokdhXYRB5Hux5NJPlN+39IpMlNPOhb0GSLJF7tS4Jj0745x3O7ZTP2pmK4VsIjFti2suuJ/fGw9a0VoSwW3thUqhmXl8ljJTiMh6DtXq4WJUv1Bw+jKWKn4HhZtipmn4KfK6rzDaDglGv/XO/2WEbUL1fT+xN/8NhaTJoHNB9RmEDjZJiL7xoBWzJCBjSyKoV6shpUZ9LW6G/Wdn90yDHDUyssAoNXmev9CarckEmFq80A9FtaEs1fw+gyGrfTn6UY8/8IfQfgMS8Cje7Uem9iWZru829/iy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=concBdNiyvs4c5xn8sAxndmrEeIA0PFYQNUF9Eo4uCM=;
 b=Mr7I7bIqquRIx50oXg71KjkAk/7tksBH+p0hYUtksgkj6ZpAl2eNjWFzKeOCidbLHxG7YVASaovYFU+ip6oRilDEC+fCHLUQulvD66iVtitOpO6py/UtlV8l9LnNR7UnXNsi7CiVP29dKdcdbCgHaebeEmccYFzXofAkQPEbBLUzLbnlgDeFxwfz0KEpY8xRPUPgQDWiXrN6Rv+Iz2yeoTIeUsqAfLnxcbld+SzIsIukBDoldAFnUj7iqiQqhwhhL8FtpIx1FWB96k7TsWNjegGSaj1mfFhxScQAv6YDJzg2KizKUcOKc7DyGNLs3U+vGGjByJsYh9cgAhg/ME0qyw==
Received: from DM6PR08CA0051.namprd08.prod.outlook.com (2603:10b6:5:1e0::25)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 06:38:44 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:1e0:cafe::dc) by DM6PR08CA0051.outlook.office365.com
 (2603:10b6:5:1e0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 06:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 06:38:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 23:38:26 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 23:38:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 23:38:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<praan@google.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <jsnitsel@redhat.com>, <mshavit@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH v1 11/16] iommufd/selftest: Add coverage for the new mmap interface
Date: Thu, 10 Apr 2025 23:37:50 -0700
Message-ID: <7a1f10281adcbc4c59d2b3f1c3e3f7c9ca5477c6.1744353300.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744353300.git.nicolinc@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 615cabd5-1bda-4a23-80a4-08dd78c38155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D/JQmeYoKizuE/NwXv4+BMdkKucr8l8767eJg+Hc8RHAP7LnR70LI59cZYFh?=
 =?us-ascii?Q?IAtlQc4NtT30MEbqo+D/Kmr2Y7HncY4X6KqizJFDiRjH97dHyHIZuCP20fNp?=
 =?us-ascii?Q?b6bpRApjzKSwqOAK1n/Oh5j/B2DweIrboolXcRrM4mkoTvI95EkyvB6rlWcB?=
 =?us-ascii?Q?5PtP+6lackkOee1cCdW7A8gQOk+zhgJjHp6x9v/vX0dZYjSAy5eo+Dm9HWA3?=
 =?us-ascii?Q?1dDnprIZK2n2sisUOBfUqHNVh6LyfZz6YWg4vCZ5w9+40tjw7gzg9ST9bIYb?=
 =?us-ascii?Q?f6T1ck2tBp4DS27Ht1XsubKPFY3+YIwag1eliBxYek9BRTyUGqSkgLs7+R0k?=
 =?us-ascii?Q?/jX+dqtc4PxrLxvxeFpHzZXOqGhaZXXInMN6tpKAJ10wbIIGvfIi1pA+Xe3y?=
 =?us-ascii?Q?7AZAZ2ElSRQI5Psu9vGJ9MGMwmQHJvuYvDhO1j2LKlX+9ule9JYqw3mv0+at?=
 =?us-ascii?Q?uQZvMW2xrc2zYoy5U0pGz0PKQ22uR6lkk9babIF3pRvqvzEKDL3V3DQEDzQI?=
 =?us-ascii?Q?wNHpvO9IbRuzzvjtnNwhlImPYbPX7IEPrZIwzJIxGPY6+we7c83Kgo8WlOnS?=
 =?us-ascii?Q?xV3hNuYEfuTKx9s00EL+N27QUwVXefp8c5FDXju44kHrefP6WmN6CUPO2+gb?=
 =?us-ascii?Q?NqLip+0nil2lsqkZ/OkcjTD4isesI/R4G+hvBfz+CFlX9+4TsHJr4iCocIEi?=
 =?us-ascii?Q?WoJLVR5T3YUetgikba5dzBkR4Mnv/TkHN7uxQtxuRMz2FyZTJVlRQyH/i5KP?=
 =?us-ascii?Q?NzUqBUuj2b0jcs0py+JRVCxXAXH1XVo82t1nk2P02GjJ0og+NEHMr/91KPCn?=
 =?us-ascii?Q?QoD+9jpA722NBrGtZbIG2M4Xeelomz5AH3rQ5AbtFohqyUaA+o3iwyrIAaIH?=
 =?us-ascii?Q?WPesiLNb6fLkh8+2JgmBEL/hICFnDJ2mAFy/g/pEUNYJeH754StonDjDAMKJ?=
 =?us-ascii?Q?dV9SuORTBUzQHFhS1UBDr6HLBr5w0aQI/BVfA0fbPE9mysr2TLBdJQTB+bul?=
 =?us-ascii?Q?Wr2+qK+R0x9DYaNDrkZU+QAuED0vr3Wz43ZSs6+Fuq/iKxA4PRPykoD6mw4j?=
 =?us-ascii?Q?d04+/8k4qNqYHWpdd6fohn5/BEFQ5Vjy/UYB+Ph2K6ed5nkVJPKk/VVKuzwP?=
 =?us-ascii?Q?uAbHL7apUCj33HRIeuEOqFvr5PYVmB596bdCEKnjM01VXlTfmMeXtRZolZSK?=
 =?us-ascii?Q?Qr1LcVmtypyszOLJTLfUu0QjuoLDMYABMdiHrQERrK0c5RJV90PRRvj6f1nw?=
 =?us-ascii?Q?WFdu47hu5e433B+7g3en8GdFqlXKB/WU6HbvDnffD7RaLWXkr1iW237d9n7w?=
 =?us-ascii?Q?oDXlsKYWbaJ8iCXffTUPgCFglKNxNFhWqKUgFxY69OAh+gzT1++3aW78rkLz?=
 =?us-ascii?Q?R+TVtal9cOjLGauXSLB5JYotGPIph+RpRRPn2VVFO83iyHDYUFiSBT9jUCHO?=
 =?us-ascii?Q?rI9TgKA9eMG0ekkp2okkCmiiztEL6DrwNvwRAbtrnM+LJF5frqorldExBjyc?=
 =?us-ascii?Q?uGQ5GQZh447PtBjfN8B46z97ScvP9Vr7pxJ5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:38:43.8892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 615cabd5-1bda-4a23-80a4-08dd78c38155
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494

Extend the loopback test to a new mmap page.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h    |  4 +++
 drivers/iommu/iommufd/selftest.c        | 47 ++++++++++++++++++++-----
 tools/testing/selftests/iommu/iommufd.c |  5 +++
 3 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index fbf9ecb35a13..4e4be0b73391 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -232,12 +232,16 @@ struct iommu_hwpt_invalidate_selftest {
  *                                (IOMMU_VIOMMU_TYPE_SELFTEST)
  * @in_data: Input random data from user space
  * @out_data: Output data (matching @in_data) to user space
+ * @out_mmap_pgoff: The offset argument for mmap syscall
+ * @out_mmap_pgsz: Maximum page size for mmap syscall
  *
  * Simply set @out_data=@in_data for a loopback test
  */
 struct iommu_viommu_selftest {
 	__u32 in_data;
 	__u32 out_data;
+	__aligned_u64 out_mmap_pgoff;
+	__aligned_u64 out_mmap_pgsz;
 };
 
 /* Should not be equal to any defined value in enum iommu_viommu_invalidate_data_type */
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index b04bd2fbc53d..4e6374f4fad2 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -148,6 +148,9 @@ to_mock_nested(struct iommu_domain *domain)
 struct mock_viommu {
 	struct iommufd_viommu core;
 	struct mock_iommu_domain *s2_parent;
+
+	unsigned long mmap_pgoff;
+	u32 *page; /* Mmap page to test u32 type of in_data */
 };
 
 static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
@@ -632,9 +635,12 @@ static void mock_viommu_destroy(struct iommufd_viommu *viommu)
 {
 	struct mock_iommu_device *mock_iommu = container_of(
 		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
+	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
 
 	if (refcount_dec_and_test(&mock_iommu->users))
 		complete(&mock_iommu->complete);
+	iommufd_ctx_free_mmap(viommu->ictx, mock_viommu->mmap_pgoff);
+	free_page((unsigned long)mock_viommu->page);
 
 	/* iommufd core frees mock_viommu and viommu */
 }
@@ -748,8 +754,9 @@ mock_viommu_alloc(struct device *dev, struct iommu_domain *domain,
 		return ERR_PTR(-EOPNOTSUPP);
 
 	if (user_data) {
-		rc = iommu_copy_struct_from_user(
-			&data, user_data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
+		rc = iommu_copy_struct_from_user(&data, user_data,
+						 IOMMU_VIOMMU_TYPE_SELFTEST,
+						 out_mmap_pgsz);
 		if (rc)
 			return ERR_PTR(rc);
 	}
@@ -760,17 +767,41 @@ mock_viommu_alloc(struct device *dev, struct iommu_domain *domain,
 		return ERR_CAST(mock_viommu);
 
 	if (user_data) {
-		data.out_data = data.in_data;
-		rc = iommu_copy_struct_to_user(
-			user_data, &data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
-		if (rc) {
-			iommufd_struct_destroy(ictx, mock_viommu, core);
-			return ERR_PTR(rc);
+		mock_viommu->page =
+			(u32 *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+		if (!mock_viommu->page) {
+			rc = -ENOMEM;
+			goto err_destroy_struct;
 		}
+
+		rc = iommufd_ctx_alloc_mmap(ictx, __pa(mock_viommu->page),
+					    PAGE_SIZE, false,
+					    &mock_viommu->mmap_pgoff);
+		if (rc)
+			goto err_free_page;
+
+		/* For loopback tests on both the page and out_data */
+		*mock_viommu->page = data.in_data;
+		data.out_data = data.in_data;
+		data.out_mmap_pgsz = PAGE_SIZE;
+		data.out_mmap_pgoff = mock_viommu->mmap_pgoff;
+		rc = iommu_copy_struct_to_user(user_data, &data,
+					       IOMMU_VIOMMU_TYPE_SELFTEST,
+					       out_mmap_pgsz);
+		if (rc)
+			goto err_free_mmap;
 	}
 
 	refcount_inc(&mock_iommu->users);
 	return &mock_viommu->core;
+
+err_free_mmap:
+	iommufd_ctx_free_mmap(ictx, mock_viommu->mmap_pgoff);
+err_free_page:
+	free_page((unsigned long)mock_viommu->page);
+err_destroy_struct:
+	iommufd_struct_destroy(ictx, mock_viommu, core);
+	return ERR_PTR(rc);
 }
 
 static const struct iommu_ops mock_ops = {
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 8ebbb7fda02d..4aa6411e9a76 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2799,12 +2799,17 @@ TEST_F(iommufd_viommu, viommu_alloc_with_data)
 	struct iommu_viommu_selftest data = {
 		.in_data = 0xbeef,
 	};
+	uint32_t *test;
 
 	if (self->device_id) {
 		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
 				      IOMMU_VIOMMU_TYPE_SELFTEST, &data,
 				      sizeof(data), &self->viommu_id);
 		assert(data.out_data == data.in_data);
+		test = mmap(NULL, data.out_mmap_pgsz, PROT_READ | PROT_WRITE,
+			    MAP_SHARED, self->fd, data.out_mmap_pgoff);
+		assert(test && *test == data.in_data);
+		munmap(test, data.out_mmap_pgsz);
 	}
 }
 
-- 
2.43.0


