Return-Path: <linux-kselftest+bounces-21184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADCE9B6F71
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF3C1F212C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15BD22EF12;
	Wed, 30 Oct 2024 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="umKwKYQO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE5522CC4C;
	Wed, 30 Oct 2024 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324181; cv=fail; b=FLxg28gjSo0aTFdSJCSgBJz4rbuCe85rdgl1HxXlOyeR5Gg9krILJmXjki5ROZ5+MJ+8izjcp56psApC3iRO8XE8ajWb5q8GcukE4DfTSWfi4EKinVXknzZti6sThbMN2f7vIe0qBVNx5mUXhdF0IrfvYlAz8svuwzgjo7DuoVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324181; c=relaxed/simple;
	bh=rOzUTu/+ugG/slijfeKNgpDA9QGg9GgKsIBf5Xl+BEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olJntNyPmKDmtG9e+RKrsNLYP8zYtYEoP53VGqKZSObCkRXQzsjZI3ulJW8czC2ccsisbeW2mUa52fJ4f3/3qHf8N/vMf5wNUa4HauInLrPKIp1VdfbIFd+AupVqyttpCr9p9Pjw7pkMMBlMesiyEU1Um/Gd30MlN2MlgUOYYYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=umKwKYQO; arc=fail smtp.client-ip=40.107.100.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFDPUmF5x0ZZFkWS21fP+Labioqc4MARpBZNPwBGKqf70lduEyYW4+zsrJzXpHkf0Lx66GQkOLinc336vG7wOC7aRXm/zxfTOQmSrcg2/m0EGjXTRkTd+WK5HGmdsOQi/p6xmowNYMBJConkHVqJQZ9kls0nwA0QyK7LxNPoxgPZ/xr/iV0hjONHPUCs7ajjDjqOu+kKkACmAyqMk8XFG8eCSq4cEQuN4G4goIQaOaKruACGxVP7Z2wD2Pr/+iGxtUXV7Tud0iMbvFjprnd/LNxM19oRXthqYDvSr6V1bZSlhM7ZWythzISwngjEGfG+w/lPGM8eR7NH8OdjcCwSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeQuhUr1KgbG6OUCypyfy7/jl/WTllDnooXKpolYohQ=;
 b=IJBufxHo+DYxpWk0H2xTRoebB+FWiuCsQztYC2WOIp+uSUB0i2zMczPj2OM3C4jt+EMXycZReJVf26+neE4iEsWBnlBXy4zvspki4y0N7jxp8maRu5ub3s8RMAkGW8rQ9+k6D2yzgCvebXTA2LNer/ES5VWm+OM89CvuZ90Y8oNVWIKEzcTkqGEegAsqGq3m0lcGGpqsXpwCF6M+M83q+Dmv6T9J6HRjGuq+MKyK3WXB91QVdAh7ufov/Z/79SXhJTudyOzHSgYfYX0Li99EFuTnpidatdkP5hg1QYlLTneyywQUnq6v7fbE7QeqxNjiKTrTYVRDQWCawUUaZ4Ufcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeQuhUr1KgbG6OUCypyfy7/jl/WTllDnooXKpolYohQ=;
 b=umKwKYQOmLmdOOWl2q61mjyDBCsNEmmp7YLaoyPOyvSDBKy8IHenonP9tAWZJiR/w9ze4Q20mm4SXHt5huMKeGaPcCXRusx/hoTIO8Yc4gcI5UZMJXCVHIESrt/i6BH3YuzBSvBGPiwCqadLnBuXMAxDXJxYkoYauURCgDEJRsSZ5VP83jEr+a8xgIECOnR+9UXSGFNP+XcihIS2dbZb1oXa3U7fXw+eDs2m4DizHLe1Y04JQjDHR2cJzCh4JHKRZLrgVQa7dYjrn0GZbWEhyFJdS6zG8MF8M7tGdHhiFB+u0FWqbk6HOYdcmd8zxC2taqSVVKw1KD4X72f8MHdypQ==
Received: from MW2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:907::43) by
 MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Wed, 30 Oct 2024 21:36:11 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::65) by MW2PR16CA0030.outlook.office365.com
 (2603:10b6:907::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.31 via Frontend
 Transport; Wed, 30 Oct 2024 21:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:36:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:47 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: [PATCH v6 05/10] iommu: Add iommu_copy_struct_from_full_user_array helper
Date: Wed, 30 Oct 2024 14:35:31 -0700
Message-ID: <1d7f468ff51f3cfb32e90cb29f5b8d4bb2cd2232.1730313494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730313494.git.nicolinc@nvidia.com>
References: <cover.1730313494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: dd77ceb7-7bb7-4e96-a8a9-08dcf92adf4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i/oEjG7xJ1M50KinpuudJzvQFEKRtmFB9devCQY00Kwigb0kaOjm3BgQH2Y7?=
 =?us-ascii?Q?ljlSs6n/IlBuOsJK1n61SOTO6oIRarDqnvPkE28D6omdywxySq1hOSNwzTHN?=
 =?us-ascii?Q?1C5vgnbBpr4mWfujYTJspKWpfVBeGaRRsYMvZbB7MbYzej/Hmr9zvTrpjrGs?=
 =?us-ascii?Q?9rO+95orG7RLG6Y/tjptZ8TIjq7l+BkUJHBXHWi3fbmIWBCW0zisOiK83AEi?=
 =?us-ascii?Q?2zOnaVZ1FBLsLdXYwlxQSYPxnEJOcgOFTesUtWXEZNhLyHWgf7GinZJBLtOk?=
 =?us-ascii?Q?jqoS+HJN8tY9uw+gN673dltepmNnBukYjjU5FTnyqZta2TEFZLq0P+Q1KAtn?=
 =?us-ascii?Q?SXpEWukqRk0iqFlIuf/LSe3KMsCRjZOTtcZ0zqzrwd6cd++EiqOgH3Bb/VVz?=
 =?us-ascii?Q?8JjTqbOSOsnSTeAOp81MREJ8fuJ36nkC+0NVP+XUpcf5d3yPP5btCd5Yg4Ja?=
 =?us-ascii?Q?zjQik4j+dIBBFcHa+VIDcKJT7sgqMnwgbmqkqQ3kyDGxvrO9EXz2zYIrqqTw?=
 =?us-ascii?Q?jaw5BqWDiB/lf6dgxgrF33GS3BEPnhSVy513M0KvlthPLophd2OtObFPD3iB?=
 =?us-ascii?Q?DkUG3RokgL26e/jOLMsCoW2M4D7Mh4hU/VkVfwduF6HsVtKwCaKm0I5JlEQl?=
 =?us-ascii?Q?uXPB3Wq4b/WMJvV5YKJdzG08szreIIyVSxJ/vXYXY3T4LdA0Yvz9UJEQSwHf?=
 =?us-ascii?Q?l0ygNJ82szdotAm3hRZ2sa01Q6rBaGCIPXE8dgiWxJb/uvS40dXMpub9Wn9U?=
 =?us-ascii?Q?PxlbhwiS5o+Le3dFt/sAtBI1WFcCivJL5ZjozYD9pmdf5piNzT/PVREgbo+y?=
 =?us-ascii?Q?+K4jSUjiBw94aZZ3EFqDBAzLm/hzCCskVZm/0+GkZUHf1lYWflGxaaf2AZa/?=
 =?us-ascii?Q?G12wzXE5qNxGBkx2eOUgjjlIYacoeHhi5oys2TXBPwf+Mt2yf24ApdXx/N6n?=
 =?us-ascii?Q?1E7lsdpoanpVTqb7OemlAml/URv6O6T8rsbIedlU6iTs0idInOplapDlvIfk?=
 =?us-ascii?Q?ORbxThU9ihuZTXW/Skp8hkTWRmrvINyLc4ENw9mMFijZ9kBpTD/4mdVRvLHJ?=
 =?us-ascii?Q?9D5evbLJXJ/v5XvilKz8OacCTZJF7dlgF8NK69fraLQyDcAgvPoHMEgH6xLe?=
 =?us-ascii?Q?zwex56SmMrYaFmZ4P7OFwAPFB4lvZ6V/iy+Ub1lfBk38mscklq3g0o6t9kRl?=
 =?us-ascii?Q?IEch8BSja48TpPOa55TA4MrE4e4M1QvTuJOVr+QmM38+uZ9/fSs3oAMVk8w6?=
 =?us-ascii?Q?w5HWZtQCuiQaWAELZXHMt23ywanq/BIvTYKUA5Ulju6Eo4qztBZGFdFozUDh?=
 =?us-ascii?Q?iUVM3vV8LjLYMh8lg+Kl/aHolEBEVWDWaJfTIADp1Nod3Jb/Kscy7vW5M1Jy?=
 =?us-ascii?Q?U8bCYqmoyRgF0jV1qn+PnCaI6WUWU965oF0ld3lFb9EKz2RsGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:36:10.9156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd77ceb7-7bb7-4e96-a8a9-08dcf92adf4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760

From: Jason Gunthorpe <jgg@nvidia.com>

The iommu_copy_struct_from_user_array helper can be used to copy a single
entry from a user array which might not be efficient if the array is big.

Add a new iommu_copy_struct_from_full_user_array to copy the entire user
array at once. Update the existing iommu_copy_struct_from_user_array kdoc
accordingly.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 48 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2574fc8abaf2..11de66237eaa 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -493,7 +493,9 @@ static inline int __iommu_copy_struct_from_user_array(
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
@@ -501,6 +503,50 @@ static inline int __iommu_copy_struct_from_user_array(
 		kdst, user_array, data_type, index, sizeof(*(kdst)),          \
 		offsetofend(typeof(*(kdst)), min_last))
 
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


