Return-Path: <linux-kselftest+bounces-14961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC2694B101
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07391C21B06
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEAA14F118;
	Wed,  7 Aug 2024 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="maYo0tmR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494814A08D;
	Wed,  7 Aug 2024 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061501; cv=fail; b=F7tf00pK6uGW4ooTgKAwNljDqPzG59x6YyIkREOdtJdEJOJFtfVv/CYyXQknq4egtiFNmDE4WYM/tZiU3iOCfuRSJQFu0XYwiW4PUv4wKbaXy+BBVhckRxBXP/N2j/1/o58qWJWv6N+OKSoOaavIVT5Yme4n8ts0Gb/GZ2SJXa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061501; c=relaxed/simple;
	bh=BoE6lZ7dQq7iDoks0bCyzzEBtAbrMHUAWE+5RIThZbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XivcOCNvk/4dT4ByFs7kn2XnuLbyoeG9Xow0Q3+hwPmu/mTdux6isrGPxdrIS6HKN2Ukrmqk/DDV5jPA3jbxns9xhu5JfAkp8RpyfOsS1T3TST0gZ09gzr4Do4uwzgPWoxfiBo9okMDOA1hyKM9lWDv4ooFpnNG/W89bCQKee0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=maYo0tmR; arc=fail smtp.client-ip=40.107.96.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTZQ+fSrteauweUHoWhHb8HgD0W2VSAb3GPiiBq4rab7gGI5CPF97FNH5BcMDNPKI86B5qFADWncwr5mRxRbLKcvRip5yPR+mAhB0M6xdZ//2B5cE1EiN9pisD0OMdKigrRT01n0vs5x2LKUm1gca8XTQzEw17N0jwBzjgUu+SVNsxbZM0v/5KAt/zpL9obd2LeQMGtZfrvnkwSupkObqhX7cDuBTaIieJhmy5m9cHE6eki21pkJcgD09aDDXS783u7wQgaMuqZZ/tJWNvSg9appQxwFI6lNuNJdz6axZm0ZTE0FH8OndXnInnGLRzogSOgtWj0TNxN2k3/XwWQzmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLRuaC84Ka4PZPe9pc/TLQKq1Vc4xsd2IGKYVfwh890=;
 b=kxUyLkflVva6xDSxd/7hfdskOTLyW3di/EPeIs8a1JQ+CMl4d/NzUvXMzHL7gDKwfdELNTYbkjDSl25LGulQS8zBJChePXO9Ld9qG3mbSztPM6lHnd/+znwfsPxrMDxGUxYQZhUKkw/uosigJbL5cOKh+AtLi0g7ueKGSChmIZEX2D/GBYrTC8Grv8pM2jJovi/WIONTYBKQbxPa7Ts75OZWY+szFHN/cIEVdgaibmTwVQJ2lGYdwYXJZXObigdXNTMQZNwcoT7nCRgIvQLNOxc7sz6eQiWhNzHFy1MntirO+g7ol1AYZOO1s4JZJUN6+lccyCzm01Y3VGeGl0fh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLRuaC84Ka4PZPe9pc/TLQKq1Vc4xsd2IGKYVfwh890=;
 b=maYo0tmRU2jRbKA4Shey5aTsovZwOGnICa3KUZ8WIH2VrA3yaI7Cj4rgxkxDZggRMM9f5svJ1Ld73zCJF5NLLmwH/7kq9P8iHohrPVeVgO1xbQUslvj9tWkKab9mS47DR+kV8E20WV9/9dF3RLZousShsOV7zhsMubnB7bmReIU/rcZnBYcHQbkP0sm02PjohErKtcT1RzYaFkSCZZs88Fp8AIwyQ2tBeZw/4Vby0kI6rkC1evdbDjgLr/C7lh8eqpaEr0arJvnaOO7GawoimvHyNbkMjCf1vAOVW0EQw14GCb95hITrA48ydy91qiyzB/4gmdpVfncEzT6f3CH5ow==
Received: from CH5P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::11)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 20:11:35 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::ff) by CH5P223CA0010.outlook.office365.com
 (2603:10b6:610:1f3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 20:11:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:18 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:17 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 09/16] iommufd/viommu: Make iommufd_viommu_find_device a public API
Date: Wed, 7 Aug 2024 13:10:50 -0700
Message-ID: <eae828f3190b89d0a1026ae9e97747210cf96bbc.1723061378.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723061377.git.nicolinc@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8d0108-e3f3-4da5-ac27-08dcb71d22d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4VcmKDVCswUZFBFqX8+RMqE5Sl22XDjaZmhxW4XuzDZBPwkTRh7QM5EyG9iA?=
 =?us-ascii?Q?6Rd2XeCNWU/wm18e7rhIRZZcCtFf83YD2ngeYSHRkHI19Wotd6lc9GRNbYTh?=
 =?us-ascii?Q?4LO2iPR+2PZ+r1IF/lXfhJvFhLcBqqiaqeSN3R6I49XzGJvmVrVn/kf4go4L?=
 =?us-ascii?Q?Yhk9UwgbX1u7rBTmdkC2tQjWj8WRfFszeDdj4NeOtIoDL7zN6gdJZ77qjmEU?=
 =?us-ascii?Q?m/Fqx7cwIjULtELDoKJWxpI07Q4iwc/hmdN5uq68vgo6aKv4YxvKLudCo2AJ?=
 =?us-ascii?Q?4nBX36NwPmLdogNNgRrx9tCV0sFQz5jrxSoVplLpDASAi9Wbl/LEGqBTxNu1?=
 =?us-ascii?Q?DnXUL2seiLzJ4Gzav+9DVQNz/LzK6JUgpIeRM4D97EkbYURvhI/yV/l0Bddx?=
 =?us-ascii?Q?7U9xBtaDOvhs5CnxMpS68cgNdT2eVSrkUtfJnahkjAgdPIaJmjhvkosiIPII?=
 =?us-ascii?Q?ARWRkNRfIgqr6M7dIOtt+sjYZSP0SvMHJVcUhD4sG9dtINzr1Ym6ME+EYlsm?=
 =?us-ascii?Q?r/z+i5eRjgN4qLd7Wt+tVkmDlIS2lEN6lM5RoWOBsU7ZugB1X33auiswXnHh?=
 =?us-ascii?Q?TL1BSbgInES+MCRTq8vZiJIJbH/NGMzFvFwqz0qO51NI7FAfJgu/jBNI8lbC?=
 =?us-ascii?Q?1Ynbb1lWRlzfzPdYT1lAkuDAhZ/5Y4L+aQtUzWI8zAu9HjPcftFVFyWmoXuR?=
 =?us-ascii?Q?+FjE+DvlEjORjyI+bSMot38JQEAjudp/GRUIygv9VkkTuhvaYeNt93jTrnes?=
 =?us-ascii?Q?4DUq5J6Gr64gGN4GBahRHSZ2mos9jReBmkQ29Ica5gkp+QZdCd/xZjgEyOdM?=
 =?us-ascii?Q?jSRjoW3mft/fWvrHY3/3EkXoabfVkVukAx1Ja/ocVx6dsi6BRAIy7B8sbM/p?=
 =?us-ascii?Q?9lG+FJFa0lJvCvrPIqOgUfqYhBQRq68IxSd+pZ5ec1SzAo9v4olqvaA/7LQ5?=
 =?us-ascii?Q?lqubI02J5QX5WZCeY41eWTN8WH+tcB4f4Wkbt1O3p6MyAEp7f5p9ZkfN5PyQ?=
 =?us-ascii?Q?UQ39SouHxSrJErtAw6DkG0kDOkqgTswcLGog3fSY4BcfGltOL+SqoXTQhHnl?=
 =?us-ascii?Q?D49+vRes7vBbG5Q5X8bM366AFTAixZc8AvytJEB6+rj7mD03/SBzV+yDThsn?=
 =?us-ascii?Q?D2dM4ZsDgfuLnOKOEd1+wAaRYbGhP8xhhfFM1rjHKHk5H12vCUrTIhcNL4Aj?=
 =?us-ascii?Q?BdX3GN0x4jlgD8VsUdJ5zYh4EnJUTEVaFEdIlES2saFkToP1rk78/Caw5qi4?=
 =?us-ascii?Q?+FhIDd+wNfpno7pWpQuJ37z2cw/Q8HlNyW7uKOhe7Mr43J+cgvMDjnlnuy1q?=
 =?us-ascii?Q?ygAPrx3KHCAMUDyY5xpCNhA/m3qDVbvDei4sXdNN5zT/32MHCYC21AOqvYP8?=
 =?us-ascii?Q?TV6aYo7DrHHNoLxjnMfq/TyLcTIGBEeJvOLXtpTnyUPnJME3eVrmbV4NgRRN?=
 =?us-ascii?Q?k3QwS2S6RdhagmT9T8ZYRbI1/LVDyNJR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:34.4240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8d0108-e3f3-4da5-ac27-08dcb71d22d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731

Now, an IOMMU driver can use viommu to invalidate a device cache via the
viommu_cache_invalidate op. Very likely, this would require the driver to
lookup a virtual device ID for a physical device (or just its ID). Since
the core already has a helper, make it public.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/viommu.c | 2 +-
 include/linux/iommufd.h        | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index ada9f968b9f6..2304f199b033 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -148,7 +148,7 @@ int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
-static struct device *
+struct device *
 iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id)
 {
 	struct iommufd_vdev_id *vdev_id;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 7da5140fa1b0..e0d7a53acbd5 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -89,6 +89,8 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 int iommufd_vfio_compat_ioas_get_id(struct iommufd_ctx *ictx, u32 *out_ioas_id);
 int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx);
 int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
+struct device *
+iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id);
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -129,5 +131,11 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline struct device *
+iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMUFD */
 #endif
-- 
2.43.0


