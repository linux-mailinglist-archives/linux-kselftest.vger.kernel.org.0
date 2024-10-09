Return-Path: <linux-kselftest+bounces-19380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A8899720B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4448B26C8A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761E91E5707;
	Wed,  9 Oct 2024 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UK4+gB5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C651E47C4;
	Wed,  9 Oct 2024 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491963; cv=fail; b=tiqsnXf8yg3PipRq2P+P7pzf8Qg1k5TBzrXabYDsa671jULyZKFwZmyAGYyERn9RkhJ8jgIvXW4APmuo1LiP19Z1JkmRwsEOMENdgpM3V8b/8gnErW7lAbKLTATLac0g6qNh3EyJ/WWZ/uMYsgShQtQ9pch0B9V3BjYOGEIlK5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491963; c=relaxed/simple;
	bh=JleL/WDwSYri+YNplvD/myrHJ4OrPX62j01wKk/l598=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEFeJvldJ05+WfEJ8u6DPxNrkm+gZLfDIa9z3PXOaNtFYwFDpMW+n1tGKOQakEu50iRUfnZbJLWmS9tktJx1EUbu6Nn2PIPr+1tRLYZDU29tp9BrXFboHelZ6FplHuKf+MvtnfYT1jGTgUcjehHbWrGsS/atWX/bPHVb0J0+4Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UK4+gB5I; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvrS+iG2v82VUkTmprdialp9EXIbCS8w4/ez4HxBvKp9MQx0eyD9oyfJwP0Q8Z6czhyijsYq3HjmuAoq8Cf9JiD+NS5CfY+IR7yIzynbyk46RvwDbnspE6+GIG8gcFMkZw2xNyEAfrvVhQAgYikM9jtNWnpYFWbcK0wseCqfyY0r/JTpSrq+kSg6IqbOmHihEHvf5ZAE1ESwKULwNl9t72PxGJGBVO4cXumPXPIDQqV6YCrTnCtZBddtkl5GNfOjg40R6ThkGaHzOZsT/3Fb5BDhQwBlzEZCfEGzgjRKVTJERT8po2sBr5CSHr6qFVwalnQkVkI/GwoppwdnrK2/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5W6GPvTFiR9C5kTo46PFn3r++s62U7OGDx4eFcBIAQ=;
 b=aMa9wFU9I6o42uSt32TUyQpTDZIw37RLKka5EVlA+FP7G2B0YBQNHJ2WJVvLLqTbqJ8ljitbAFwUAlWTKvBzUj4Jt/h1b5aDjn5H/QBsX4H/lMaBuZPwinfnx2irzJ//Oan0P79Ve3inZw0CGoDhWQGC8varUQDfccq+zI6qR2zVNVHXbahLan3HBOsTabUKQppUo8seVzdGGThUUEh3pG9sIfXaqx53Jyq4hnVsyM562jdptuSIBCYtcUjVRQNZ8U6PMrMP+VFezHC7rBKWYdOENKtvgwILxUeLEKTBgUpeqGzh5CToQtr9wGMYbRiMmfg3MJNNUPX2rrOnCbHlGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5W6GPvTFiR9C5kTo46PFn3r++s62U7OGDx4eFcBIAQ=;
 b=UK4+gB5IDRK8dp77bjjuyfwrja2NvkDRyZxV4T9i8WX3cMqyvinQd7vt3S8uOT2ClhuoaYhXOdh2wln1RjZ2ge+aOi0+Hlr++m9uRNHELElGjk8xs/R/LWgoo9h7v74GDD5MJk1mYboDHPJtEwinVHCvON0ursssYdFGB/SLzarOAE0ONwAVPJUcrkJMS0s4tOMTglOcGOpuNdkJ3QqEc6oN92Zkw5bpBj4I2ymrwIqWAb3ak5b+dZaFazKELzmbcjZcy7TcN8eDljjqA3DH3GNrqBQdyKI5memull8cquJ3Wg7jlx3tS/Pm/yxa6UZANjxRQSd9Ie92ay8VAz5Q6A==
Received: from DS7P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::14) by
 MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Wed, 9 Oct 2024 16:39:13 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::8c) by DS7P220CA0007.outlook.office365.com
 (2603:10b6:8:1ca::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:39:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:39:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:39:05 -0700
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
Subject: [PATCH v3 08/16] iommu: Add iommu_copy_struct_from_full_user_array helper
Date: Wed, 9 Oct 2024 09:38:20 -0700
Message-ID: <e9be6497346eb490eea3ea2932f272f734e1f0bf.1728491532.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491532.git.nicolinc@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: c6188e38-f4cd-4ca8-73b0-08dce880e81f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HGAFqYDaK7ZO6Z+fJKC/4CnKViWSzIsKx/opY87fclkkwyf9fP48FL0W8ENB?=
 =?us-ascii?Q?ff/67UNb6x0vWMPijJ3ggGxPWQQtRAuPEjJlBKmkeyoRuoJ6Ygj+yhceWOcA?=
 =?us-ascii?Q?9ZVN2CM3i5yh7rgkAsrolnqgwnN90sdIg/7pu8yW7b32WK1r0WtptWXTwvr8?=
 =?us-ascii?Q?AwocrWibaqVMk5Pptw5IiBfhGuUZt1SXb5eWXYOvydq96FpWlb7eg1Z+Ls8u?=
 =?us-ascii?Q?L0ybQ1yrDHzvnGQONRuUxWu6mXNgVn8CFx/mbk1azdy1Dop1VigKbGh4lLv6?=
 =?us-ascii?Q?spZKa+wWEmOGBe3KabqEhqZof+IpSVnGImE/O7s94oIVpqgafnoTPSMEFoFG?=
 =?us-ascii?Q?VApHxjfKnkY5U2SETuGgUZUgGHLwIcDqeD53Lyn7RDuTQAXT4XuNhFpQNMCU?=
 =?us-ascii?Q?o5eoPx8b4Hwj5hhnuj+MLZomtvHxdgoJ83bfS5Sds3fT5H6oll7saHNI2zMA?=
 =?us-ascii?Q?BEUvV8wg6bLM5Hwe2+fM+fZVy5IeXFbni4atmdS4D05uIImc7T0Drl5YZ+S6?=
 =?us-ascii?Q?QAZ1/rpqF6YiX9ylt0oTWnrlMbNON+QsXxStWHSv9jLEOTeqqlpHM9E29NXM?=
 =?us-ascii?Q?pAb/bPquyY3uNfIpjpNnQow3ro4NJit1nB3zFLsLiqnj6HNSqA1If8rc8ImN?=
 =?us-ascii?Q?J2mqSq1znQVt85bG1Uhurb2ilba7/NIhVo2rZIzcNCIrkwGiu3S7A/dXWxtR?=
 =?us-ascii?Q?stW4QsjlHPtFAtVSSC85XBbomOog+Fc8MxYj/92RGfMNYIPVmAqqp+jdFxWg?=
 =?us-ascii?Q?XaxreMQ+gzm6RMfisNGo5ZV4iik+ZFXxENbqQ4VXn0vrmWxYRs3FqcHUESfa?=
 =?us-ascii?Q?RGF+tjYTvGkNJ8at4sa186medla+ZfxdVFeGZwX4zwm7BSsyrq5aeVWXS+Nf?=
 =?us-ascii?Q?5RSvn4YM5Gh2I24sts+7jxinLa6R+AoPv9AIqYpw0XktK3s1dWnJoacAGJvu?=
 =?us-ascii?Q?j2zbU7KjKLK26H9t/IGChf6qscu5o8vYQ0WoFluOoACkA1bKjkmmDxgU16wT?=
 =?us-ascii?Q?SsXDimmj8T85BANlUAQBHdmiOtoBrx2Txezx9YvVONwNCuB5LUpIUmdD+ApH?=
 =?us-ascii?Q?TmWHSfxBGhS3WNGrXJh+XvjCqoRKfSqOVd6PjiGlHeV6yUm3WNsXZc3gJrkI?=
 =?us-ascii?Q?l0La7JeGJS+pt6D57abJtTj5fw3eFjVlrsjs8g/DTpoarjfpqL7Y8OYL7G6K?=
 =?us-ascii?Q?r8xsgGTTXnblGfET22KZ23C7CBqH1OHhERXHUZKRKijvPtIt8K8tF4iywdvq?=
 =?us-ascii?Q?2NCzAOemkJFnPUuTLQqd1Mo+N856ay+cFDtKK58jkC25OxrnIILyI/6H86tZ?=
 =?us-ascii?Q?oqsNuANsu1VLr+TNig0ipUmZwINcDbfAyTa7xd9s3WqSRj0PMNCXgUpgmNs1?=
 =?us-ascii?Q?z1fOtdm+tZnnSzb3PI4OaZkR8prs?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:12.6194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6188e38-f4cd-4ca8-73b0-08dce880e81f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048

From: Jason Gunthorpe <jgg@nvidia.com>

The iommu_copy_struct_from_user_array helper can be used to copy a single
entry from a user array which might not be efficient if the array is big.

Add a new iommu_copy_struct_from_full_user_array to copy the entire user
array at once. Update the existing iommu_copy_struct_from_user_array kdoc
accordingly.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 49 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1de2aebc4d92..c980fd0e2174 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -494,7 +494,9 @@ static inline int __iommu_copy_struct_from_user_array(
  * @index: Index to the location in the array to copy user data from
  * @min_last: The last member of the data structure @kdst points in the
  *            initial version.
- * Return 0 for success, otherwise -error.
+ *
+ * Copy a single entry from a user array. Return 0 for success, otherwise
+ * -error.
  */
 #define iommu_copy_struct_from_user_array(kdst, user_array, data_type, index, \
 					  min_last)                           \
@@ -502,6 +504,51 @@ static inline int __iommu_copy_struct_from_user_array(
 		kdst, user_array, data_type, index, sizeof(*(kdst)),          \
 		offsetofend(typeof(*(kdst)), min_last))
 
+
+/**
+ * iommu_copy_struct_from_full_user_array - Copy iommu driver specific user
+ *         space data from an iommu_user_data_array
+ * @kdst: Pointer to an iommu driver specific user data that is defined in
+ *        include/uapi/linux/iommufd.h
+ * @kdst_entry_size: sizeof(*kdst)
+ * @user_array: Pointer to a struct iommu_user_data_array for a user space
+ *              array
+ * @data_type: The data type of the @kdst. Must match with @user_array->type
+ *
+ * Copy the entire user array. kdst must have room for kdst_entry_size *
+ * user_array->entry_num bytes. Return 0 for success, otherwise -error.
+ */
+static inline int
+iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
+				       struct iommu_user_data_array *user_array,
+				       unsigned int data_type)
+{
+	unsigned int i;
+	int ret;
+
+	if (user_array->type != data_type)
+		return -EINVAL;
+	if (!user_array->entry_num)
+		return -EINVAL;
+	if (likely(user_array->entry_len == kdst_entry_size)) {
+		if (copy_from_user(kdst, user_array->uptr,
+				   user_array->entry_num *
+					   user_array->entry_len))
+			return -EFAULT;
+	}
+
+	/* Copy item by item */
+	for (i = 0; i != user_array->entry_num; i++) {
+		ret = copy_struct_from_user(
+			kdst + kdst_entry_size * i, kdst_entry_size,
+			user_array->uptr + user_array->entry_len * i,
+			user_array->entry_len);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
-- 
2.43.0


