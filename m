Return-Path: <linux-kselftest+bounces-31673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13838A9D7BA
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 07:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE449C302A
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 05:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91AE1C1AB4;
	Sat, 26 Apr 2025 05:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L4dbhwqn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39ED1B423E;
	Sat, 26 Apr 2025 05:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647127; cv=fail; b=Qom0Ld8oOF+m5Ossij35W/wOCawjhkoDAhU4/UtDckuZWZT4g1Q2iKoRNTfrFOemsHGCNfRpViZoVQMwtRuPxUKr1RQRrQdnhMShyeWCx55h7fc8em0kU3n9ZJikpLxKlXU3RvYHR7f5a3CautlJxDVdFeQRmqpiHtw0sHcgR7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647127; c=relaxed/simple;
	bh=JqQvCSxPpe4DEXKLCud2o8eVkR2y/9XQJZ0gt6GpgMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/98agFAM1atBBGW7Ms1dNuVzMlh89lRORh2KjGApvn23WzYfveXcQCFct6eiK9o2tLlY8FQCACzADIyHMfjOyHkC6eOlXVzg6vvhZ0FUufkg/9TyFpCOGowsPdwKWqWM8RkdtWj8wnJ5rHngdID/8+BGfyzoS/C+LhB0IgASJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L4dbhwqn; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fjgww7xBZ6t6HGD6oT+nFdD8p9UZ8DvYkO88m/ajcX72jWOjX863kmsWa8HNk0swKsAydkzdOFqgeYq822fwDAxYtYKstwrOSU9LVx210PIHZl0pXSAu+YuR3Gf46mtxOTGxl4bULG+XwmJIcfMaxejrs8zFDo9do/QPdnb0KXkM9398KbwNwyUILWhGSvLcrmhmn9+owLcKIudA9d/iimwzIDJZPixRWZGBvwfbQyVs4eHFn00e5XYSJ4pj/FnhNwEtRF2y4ku9bQdBT9TYY/PdhfRF8jhWb8C78+jT0oOvZpTAOX21QYsBRoT/+CWTWC6GOBkimjSxnL20dydkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gj6dGnxvjESLxfj0q4qEyjVFSdUq1qiIEBAfCZXCSG4=;
 b=C8g7VV7DNjIj6k1NdFYLuuQe1Wuv/DJ/EeJagFyyxNAUOtZmL58iJp8TX/1h/UzdDYlbnfdFr/jS002cwBgmgr0f9GCu+IeE+nQ0ceAhDsPeFFeOD1bNry+J7LEIS/V6zNm+Odd/+Ch7kb3OW2YXXH3o5u/okGSUAeEgj9+DovXgpU71Ct/15J3wp8xA1D0w+n1DsoSO2iz/OsHkwjvOLLNpQ3bhaBXtWuzV4RDnwDWeyKE332mHcQlLHQAHGIqWCDFJQq1V4/f92cTiYseGTtto3XAxf0KHqqDDRBsG8ya0j9zTtRad5u4gyTeZw2wbGVfUbwzdVDsqNmF3DAULnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gj6dGnxvjESLxfj0q4qEyjVFSdUq1qiIEBAfCZXCSG4=;
 b=L4dbhwqnTntUlFeXIHNS3GN0oFOju5sn1zTFkn1a+/gS8WME4v0fV15Ld+xEBmayZg/tjceBbOl94M9c903Ttjcjb0STBAUTzNu7u55SvlTsAb15flvKmJpCJnuXH0ZXK02EVAzKDWRcxkhMSXKeiaqbIXID5Frq5gzPy5xN1XtGP8lQjB0KahoZdg9Z2c4H9D1V1Fc+LflpS257wFIEr8DqUqgXvrMRmQ12tTgnQ/7Wu0Nz/gDfY8W7XsG43vExBCHtUQHEYmxMEzbkvj4MSHO/zhazwF04JSa2vGhw8AtYHslCnItzHH4S0KcZZ+Q8wx2KbzbphBxRFkMtbqlc9w==
Received: from DM6PR21CA0029.namprd21.prod.outlook.com (2603:10b6:5:174::39)
 by CH3PR12MB9098.namprd12.prod.outlook.com (2603:10b6:610:19e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 05:58:41 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::b0) by DM6PR21CA0029.outlook.office365.com
 (2603:10b6:5:174::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.11 via Frontend Transport; Sat,
 26 Apr 2025 05:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:58:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:58:39 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:58:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:58:36 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v2 02/22] iommu: Pass in a driver-level user data structure to viommu_alloc op
Date: Fri, 25 Apr 2025 22:57:57 -0700
Message-ID: <f985e2802a50b5867c9d4d3182ae7b4944a989c5.1745646960.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745646960.git.nicolinc@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CH3PR12MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: dfce5b10-50f6-414d-deb6-08dd848765bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DTLFqtiVN4Riu6CrlDMTA66PFnbRr7/ip8Tcj1V8enKa4Rd/V9rHJq2XTsEG?=
 =?us-ascii?Q?BXFkJCBmwkhTNU4zXHMGpuyEsaUGIM4RRJvTAo+ywPjp0OvQYgW6wgPKxpFA?=
 =?us-ascii?Q?FHzqqAHSiAvkHMoxXJ52+r6WAOGQd71glEvqJVHUyTajHboNKe4PLFIjpgcJ?=
 =?us-ascii?Q?ONqnZUBMW1X+jHrSFLbJ+6pRINMyok6A7pO6GxfYqDcIDoM4+jtQKSm7lB9G?=
 =?us-ascii?Q?yt8mD+5asCEiTve1juesGreLtkHtya/f7UzQL2iLTzXS09HXFm+vx3h36ABw?=
 =?us-ascii?Q?ozRuxoKDbp1HhdTudJnFYVRU8Y08c3HoAoCsz3qOVz026UaNJ209YEfheZlJ?=
 =?us-ascii?Q?b/0OuSqC3rqHoCuHDvopV4uwn+F4Q4qzATOFB/HL43Y+RYDEtF/3s49yyC+X?=
 =?us-ascii?Q?9WNqEEjEh/QykMup+8kwoWsKyMsgZc8/1CN3a6365X9hYoufcTJGXNLn65qr?=
 =?us-ascii?Q?q/paOddxvQo5vt7i53dLbjdbuZUblYIMEpH+5WyaUElHZmnZqpPCv6O2Clf6?=
 =?us-ascii?Q?DNVhbDW1zKR2VP3tB+pQMi/q0WAHTxMyryZX/ImFuPp7i98Useg+RRd80NuD?=
 =?us-ascii?Q?yU9IMy6wBq7Ynmk5asO95s5d0ol0u9hSDhVutoGRdSrDPWESYiZ8QNgcvHLk?=
 =?us-ascii?Q?Z8n/VbVVxsahlvKBo+PXwwo0dO1WxPvxFtnoQ8/KftoMWdtLc7tNumb5UV4o?=
 =?us-ascii?Q?MdVQFCe+Hvbm2B5qsXhL4eDnNEIJbv+GTKzWV16mhpn6/qfBxY5+jyrCxaFH?=
 =?us-ascii?Q?KV/MannX/NxBbKAbT6+60M4UtzfKgEIvcf42eswlWrwQjCI3bVwHHiRht2Ls?=
 =?us-ascii?Q?zuTjyAVHDMizKr5ExHAhwkmFg7ID3kyNX4HmMt/BI3PuuUbs/DRkSakTByQJ?=
 =?us-ascii?Q?BvHT5TK7fb5qc9B8zWx9bIkBXLLH1nD2egu35sVwbULHlocVCHN8lvlu4uy0?=
 =?us-ascii?Q?7X+1kO/N094smsBfEzbRtD+gy+0X9e8iUI3dIDhguXO7G0y0WvoaI3rw1GkM?=
 =?us-ascii?Q?4RMvb2opbF/ZDq0aAmI6tkkfOzEGiNXfiILeIeELwn5y9Zq66stM6hSkFycL?=
 =?us-ascii?Q?ZWMdtdaS/EAEulv1ozDKhIznKNuolF0vHU9TTkI+xHuwnVPWk/fayqyTr8k3?=
 =?us-ascii?Q?6DDSiwVmGpf7CuEcA5neysJV5rZL5FHu+dnBVDgqSc25+ApuTrzzEFdRozRM?=
 =?us-ascii?Q?XFig6oSjrR1dpexLvuQcUm0fzsC0VVp7N1YxmVgAKkIYOObfQ2BVR9Xbkjwf?=
 =?us-ascii?Q?NwYjFI0/DqQfKX/COZFjc9Hu2j1AhnfjXTqYZdkNogY1esNvVMkBf05dzUlf?=
 =?us-ascii?Q?mawLNNJyuNLsSU5IhoZZp/QrrNO0BSU8qUwjXS9Cf34H15gKvlawiGY6RhOo?=
 =?us-ascii?Q?c6B5YEfLkMezeToqc5oJ5AdkfEk3sMYDGcBBdbNWynHxl0PbdATj7XIpZ3Vn?=
 =?us-ascii?Q?gGZmHZ+qOQIgNb9AMiJZ7Y+WtNy7wz+syY5jqOiNX0uwvxnjG0curMQ1Xr/y?=
 =?us-ascii?Q?WMeVKl11KA0v/9HGFHTnJpChl8QsQTtt17Zz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:58:41.7596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfce5b10-50f6-414d-deb6-08dd848765bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9098

The new type of vIOMMU for tegra241-cmdqv needs to pass in a driver-level
data structure from user space via iommufd, so add a user_data to the op.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 3 ++-
 include/linux/iommu.h                               | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ++-
 drivers/iommu/iommufd/selftest.c                    | 8 ++++----
 drivers/iommu/iommufd/viommu.c                      | 2 +-
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dd1ad56ce863..6b8f0d20dac3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1062,7 +1062,8 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type);
 struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 				       struct iommu_domain *parent,
 				       struct iommufd_ctx *ictx,
-				       unsigned int viommu_type);
+				       unsigned int viommu_type,
+				       const struct iommu_user_data *user_data);
 int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct arm_smmu_nested_domain *nested_domain);
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3a8d35d41fda..ba7add27e9a0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -662,7 +662,8 @@ struct iommu_ops {
 
 	struct iommufd_viommu *(*viommu_alloc)(
 		struct device *dev, struct iommu_domain *parent_domain,
-		struct iommufd_ctx *ictx, unsigned int viommu_type);
+		struct iommufd_ctx *ictx, unsigned int viommu_type,
+		const struct iommu_user_data *user_data);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index e4fd8d522af8..66855cae775e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -385,7 +385,8 @@ static const struct iommufd_viommu_ops arm_vsmmu_ops = {
 struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 				       struct iommu_domain *parent,
 				       struct iommufd_ctx *ictx,
-				       unsigned int viommu_type)
+				       unsigned int viommu_type,
+				       const struct iommu_user_data *user_data)
 {
 	struct arm_smmu_device *smmu =
 		iommu_get_iommu_dev(dev, struct arm_smmu_device, iommu);
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 18d9a216eb30..8b8ba4fb91cd 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -733,10 +733,10 @@ static struct iommufd_viommu_ops mock_viommu_ops = {
 	.cache_invalidate = mock_viommu_cache_invalidate,
 };
 
-static struct iommufd_viommu *mock_viommu_alloc(struct device *dev,
-						struct iommu_domain *domain,
-						struct iommufd_ctx *ictx,
-						unsigned int viommu_type)
+static struct iommufd_viommu *
+mock_viommu_alloc(struct device *dev, struct iommu_domain *domain,
+		  struct iommufd_ctx *ictx, unsigned int viommu_type,
+		  const struct iommu_user_data *user_data)
 {
 	struct mock_iommu_device *mock_iommu =
 		iommu_get_iommu_dev(dev, struct mock_iommu_device, iommu_dev);
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index d4c7c5072e42..fffa57063c60 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -48,7 +48,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	}
 
 	viommu = ops->viommu_alloc(idev->dev, hwpt_paging->common.domain,
-				   ucmd->ictx, cmd->type);
+				   ucmd->ictx, cmd->type, NULL);
 	if (IS_ERR(viommu)) {
 		rc = PTR_ERR(viommu);
 		goto out_put_hwpt;
-- 
2.43.0


