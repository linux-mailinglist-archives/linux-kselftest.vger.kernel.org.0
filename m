Return-Path: <linux-kselftest+bounces-30505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25B1A85443
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2FF9A77AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 06:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CABE27E1CB;
	Fri, 11 Apr 2025 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a5MZzJUG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA58727E1BC;
	Fri, 11 Apr 2025 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353511; cv=fail; b=HPPm/IHUMPa5cIekFd+agG6DwSTUA5wK+1RnaJc8q2hQ6DApFmsU1Ix3WqgIKwjEWBiBk66MbvSp5Pgw9NolvE2gdcTl1+xPypEZaz2J64C4p65N4tH/H+z7Tls+JC4+H8jVp3sHwXPvoXGyjX96x3P7OL5+7tPXMZchoLbxFX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353511; c=relaxed/simple;
	bh=bA7WVwAvkM5GoOFzZ/pwEodTcZTcyGwE7QKpeWqEGg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHDlexVCr/cwbOcrmeHI2qwU9SczQ5ESRBc4EmOCKrykR4j4GsK/mnLN3OjzzuI4zUSg2hAcoCyE4bRczv/rzZx1CVMVZ59yJxtbTa2Ekcy7E4OQCmfz3QpMWoCeBugCCUzXKd70vhHctiZQ47K8HYekujQye+K3r1/XD0f5PiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a5MZzJUG; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGAtqYujJpnpCUdjZjlnIm4HMq1+pjeDES3EC/yEv32bcF4jOpuumuHJjZkxOislgqIWaB/WqJupVVmtnGxGspC2KL5pZz/iVZouXzJwhFTFrgQk+IZQE21AH1CUFdIjYLp3LLCT8C9Mueu/EvOfguyusHtGvZ9zYrZC7gaVupKCjrTcmVCX/xduVw+zjpw5GotKg5qlLve1lB26JIQc+V0w5WVrLUg85ohcvNIVBgGk6iQMeZ8D3xM/hfHochqW9yKkXYpwfMgfm6nx2ccfRZ7CQZXd5wugwY8fVCYlJNDsR0CvsLANrSOpfdrhjD8LQpqRnfa1TPtSdtWeRNZxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIUAcSh50+u6HMWq1Ss0qHFLFwR1VH1NDftUeNfRcMk=;
 b=Ec8v1oqBGUIuKiCkAvIx3q3tbGakcRSfnlq5a7Lgk2VfSiISXGQKGo4d7YFI3KDtTup7CKqXJoNIYIPp0JC8yzrD93nc6EVXu8Oehav8Fk9pTIgLFpBf2cRVvcO5OyuoLJZlCPLHD3Wbb6EuKfRLQNic2t8MOTTaYXnVc+dSIENri+IR9SLunufnQ5/7iRykVEz189cEPFxeAgvC0zB+GxzJn8zFwf/eqc6v4xIpYGsxCRD/QqGrGMps5f90QksmVH8l5JYvdbKouoTZK201SnmV73wEu8JJt4B9y6tQLQc5vnupQ+S8Z0UFbT6PdTJt/uNrHE7oS59H9lNFFcDQUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIUAcSh50+u6HMWq1Ss0qHFLFwR1VH1NDftUeNfRcMk=;
 b=a5MZzJUGobEWX+KOSzHfM6CVG0EQfv7emgPtWSysS1MZOR0L25MnlcoY5V4sX1NJNEQ0JW4u6NYhayI+wbvosrOILBV2doWtT5HWQEBi014m3ZTH0YXUFY+b3ePsWdhczJN/16jbFsW4hN1ldNiprhbHycDtr074R1M6p2Cmbngv2mXIsAUoSr4ebd5nA+GbLyLLYaeAOemtPrAOGyFvqN2PPgHPtLcG3uIVQ4bIAAtjaxIODPFlhTEmKkBDhKO/T95wgaGIiOb4lHLrNF3sM4RrwKGa2/PknLYJ7hnkdZTKaFINPQdGDrCx22u91h6gN2ep96z34RBS7BDwbs4izA==
Received: from PH5P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::15)
 by MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Fri, 11 Apr
 2025 06:38:26 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:34b:cafe::2b) by PH5P222CA0011.outlook.office365.com
 (2603:10b6:510:34b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Fri,
 11 Apr 2025 06:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 06:38:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 23:38:11 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 23:38:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 23:38:09 -0700
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
Subject: [PATCH v1 03/16] iommu: Add iommu_copy_struct_to_user helper
Date: Thu, 10 Apr 2025 23:37:42 -0700
Message-ID: <65b51f57d08069c9da909586faf4e73d247a54f5.1744353300.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f80ea3-898e-42cd-9ba0-08dd78c37665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?49i3GHqthLAI9Ug0/Pf4Mq/Dl39rZVeskEKV/rbsj0PcJJ4dFMUmlvPbTegv?=
 =?us-ascii?Q?4fRkIrcNCP3gdGJvS6hWTa7Hme0cNaE6zzhJ7N2/23CpbxQTTBWYKbrui4AS?=
 =?us-ascii?Q?Dafu/Hxrw+jnFdUD/nuceTZEJmIkpn1HnWH7KsUfqG5843LUrVlQEsrtmnAZ?=
 =?us-ascii?Q?jfr8loZPvb1J1P3m+RonKc3fUQEHqJmOXnGDcjnScU+do87UklozrKC1G6DJ?=
 =?us-ascii?Q?6u2XVM4E5PgFTWXObZl9D1wDX5s2NeP8GWf4Em6PGY0ovl0J8I6YbLUJeiGD?=
 =?us-ascii?Q?XqLWaKiOwiHEE7LDZ+kXny955J0WF25mGcQAKJFy1de/RBzCRu7X7RToT+wL?=
 =?us-ascii?Q?QFd6KaejqGP+UoW7uIE/0jAr91sKntRBW++oTN8Y+fdw2JrCSVsqZlfeEkJb?=
 =?us-ascii?Q?PH0NBKkS+LuP0DWWN77mjY0N/UNkGhAMTwwhlM5rL2Rmll6tawrmQp0jU2Xx?=
 =?us-ascii?Q?tx5iWSz3Wmyg1zRLI3oNjd01p8mq7hntJ1qjoCTzn7ItY3KtP5nmt0Dt9oDq?=
 =?us-ascii?Q?Rpt6oQ6nWoP7g58KT3l2eOHH2hVI3kxQDitVL2NiHDa68Q800VVYufb1mwez?=
 =?us-ascii?Q?OvNEg8DsshAC0lfcda+f4Hsfl/R42DDWG1lV3XRYNhdr2bnIYB4kY2obBmMP?=
 =?us-ascii?Q?IAyzfwd/lM4l+TDqnPfsRklY2afJufu3siMEvcqOL+fTNGbo7tWGbvUlxZZG?=
 =?us-ascii?Q?64i+M/D5Ce/T7djZxXdu8qiBDtfJD2rAem42+j5OTDYbuUtZA9gb10HDPv1+?=
 =?us-ascii?Q?xAwzjFPmmqA6J+hh0yvdmLKIK+AOPri8NpAdIRgzekJcxqlKOZKxCq/e9Y7y?=
 =?us-ascii?Q?JhW4pe0okmpEt5VRXRdIbYcKoBG3dGzggVBArMqfvb9F3fXnbuHFYMxRkdza?=
 =?us-ascii?Q?uNUlMzXVZR7a7m8n9c2l1SFoFTl1fMs6uWgYpMrbO5qL8vQyVbYHptm//ipN?=
 =?us-ascii?Q?gYGwMRviOeSBXQSyYVPSOzHg2RNacFbYFyy1nTTvZziinMtBhB1tsItbZyf5?=
 =?us-ascii?Q?5LwyvsRrtIYE8+UFys1g/DyaZyw85f2uPSff42OBLd97tAFHykTFpYzlsoUN?=
 =?us-ascii?Q?49pkQSSETvGLr0hZLrg5bXPHZm/1exuwEGhLQ1hMPJ4D9+iaURFwspK4vY0I?=
 =?us-ascii?Q?4vkD53qOMT96CqoGcmSnouBAyfVvduq5qlqrZLVfrPYsxES3ZtorLeTiUw7a?=
 =?us-ascii?Q?cKvwaSWfAmm1Z3r/jDFx3vy22z/K/bw0DEDo8yb/gOreQ19f4hQ0eVQEnfzs?=
 =?us-ascii?Q?885w1X6lp6PRHkH0tI3570I84qSnHaNj2MVv2ZfRjATuyeKBmG3d5xK22Fe3?=
 =?us-ascii?Q?Wtkh+9HyUuoopeL3goTf7H5NGM0towGHOOJBsz2ac8df29ja3Fj5q6vL90aR?=
 =?us-ascii?Q?gEH9k7IFnBvYLaC0ty/4+4HiOqpMYoCzmfhz8JlAZfKkEpFzUzIsEtlNJilR?=
 =?us-ascii?Q?EWBdjGhkwcPL1nJT8b3UsT6FNsXsSEA5NCXc6YhIlhLJch5Y4rJg1SKBZzV9?=
 =?us-ascii?Q?mycT4n4p5//xzhpYXeyeWcGCZxKpYY0oRfoD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:38:25.5242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f80ea3-898e-42cd-9ba0-08dd78c37665
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952

Similar to the iommu_copy_struct_from_user helper receiving data from the
user space, add an iommu_copy_struct_to_user helper to report output data
back to the user space data pointer.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ebde19aa3c28..ffb00054da33 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -562,6 +562,46 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
 	return 0;
 }
 
+/**
+ * __iommu_copy_struct_to_user - Report iommu driver specific user space data
+ * @dst_data: Pointer to a struct iommu_user_data for user space data location
+ * @src_data: Pointer to an iommu driver specific user data that is defined in
+ *            include/uapi/linux/iommufd.h
+ * @data_type: The data type of the @dst_data. Must match with @src_data.type
+ * @data_len: Length of current user data structure, i.e. sizeof(struct _src)
+ * @min_len: Initial length of user data structure for backward compatibility.
+ *           This should be offsetofend using the last member in the user data
+ *           struct that was initially added to include/uapi/linux/iommufd.h
+ */
+static inline int
+__iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
+			    void *src_data, unsigned int data_type,
+			    size_t data_len, size_t min_len)
+{
+	if (dst_data->type != data_type)
+		return -EINVAL;
+	if (WARN_ON(!dst_data || !src_data))
+		return -EINVAL;
+	if (dst_data->len < min_len || data_len < dst_data->len)
+		return -EINVAL;
+	return copy_struct_to_user(dst_data->uptr, dst_data->len, src_data,
+				   data_len, NULL);
+}
+
+/**
+ * iommu_copy_struct_to_user - Report iommu driver specific user space data
+ * @user_data: Pointer to a struct iommu_user_data for user space data location
+ * @ksrc: Pointer to an iommu driver specific user data that is defined in
+ *        include/uapi/linux/iommufd.h
+ * @data_type: The data type of the @ksrc. Must match with @user_data->type
+ * @min_last: The last memember of the data structure @ksrc points in the
+ *            initial version.
+ * Return 0 for success, otherwise -error.
+ */
+#define iommu_copy_struct_to_user(user_data, ksrc, data_type, min_last)        \
+	__iommu_copy_struct_to_user(user_data, ksrc, data_type, sizeof(*ksrc), \
+				    offsetofend(typeof(*ksrc), min_last))
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
-- 
2.43.0


