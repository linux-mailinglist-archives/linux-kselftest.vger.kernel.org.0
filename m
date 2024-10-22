Return-Path: <linux-kselftest+bounces-20354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5C09A94CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52E91F2137A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBD01DC19E;
	Tue, 22 Oct 2024 00:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="axaCwfjh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B28B15AD83;
	Tue, 22 Oct 2024 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556459; cv=fail; b=jq0EAeTNr8UScEsjBaOEgrS7SR6Fi7VZGwJkUr+O8YlZs9QCgPOTTlv38AnKXVv5AdnZfCr6PqTgfohUz6XXitAACTWKAlar8ckUYiwMfle7ekNFH0nHVCqgF75DA7gRNwVqmXTlbt7UG187ej3ecbSSG6YDxEAx3KQsSpUW+Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556459; c=relaxed/simple;
	bh=+rLACj1hFYySCkgft+EkXTWia1G0JNbpV300Ny3cUJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKKxLvovf/OCgfr+oP4rFDyGuYbT1bxECKdlp4fvYff2zc8m8gQnnl2tm0oLsxAMjsD/GW21+TlI6LLE53xbJ8EiEooTi9TX/w4GIqrxpvdh5A8uD+mTKUw9u3XiZ+IDTMhv7movaY3l83MwkInPZtuRYuds7erI71b5m1PDYvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=axaCwfjh; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=At0vMY0cLISXT0k/Kh/y/si4p7S7U1jlNB2T9vM6IAADfQRFtwRyJRm6WldRaqm/v6Ka7MCp+M5a/gXYRdrSd0UR4tdAC/XN+zWMimOb/1neh3DewV90OZyuc0vMW7tL+3rf+gQmGsPWj5dWGFv3KHbakPbOZpzFso/CClPFLP1LbFh9ALkhskQt7uF2+dwnp0gKIcsW+iq2aY6+j040IxK6osrwpLiuU5TX7R6d+zTEyFVQz+0MvQfC9ZH6WSQMBCuhKy1WBFAEROVC2TOt4Eho7hUGx1yFUW9B0CClX99QcOPLmmTNT/8gZW2fBQTb5yQLn1Gj5qXTEs25NwZxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FVq9UssPtzeq5kXsifl3eaATnk1YHonLysyDpGctPU=;
 b=tK0VPyILWuo9wjWUN+CTwaSCHvogaSWU6RM2auuU/Gx0+BnbIIIjuWNHmnnsKRbm7fkUqSPw8qt+C+dSdRRGrB2tq/YE/bALIxPzKljWhGwOVWqUhaNm2FlxkXCx0g/3p+2LZqAmWIZgOacrvBizBMxanN+mYdD/m+/mM/RveRST7cX0iZwkTO0rE5u6UzDpdq1BXaio8DERy5Z2oqYabis2UNI1Apz2xbPDqH0H/18qfryLLNaW4P0ii9xdCKsjthHyUHJ3ED9lLFJQeNKwo2TGTgnBsFy5hD9J0hk9ibi1q/PaXdej9ecbRhk4JKppklbiNbiI+foMXWH/+Q4dDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FVq9UssPtzeq5kXsifl3eaATnk1YHonLysyDpGctPU=;
 b=axaCwfjhbwVKgdPv76x9BmftIjS0j6NiLz5hKCT1WWNQJ+zDtz0w/azXdiysAdvTtXE2W+vK4fUTKs8VoZlgtorf3lm6ZBomjtlhHCnUoHSH8hqPAE9pZljT9dmi3eQ8COeSyv3DaGx6yrbitIWTW+4+qTxYSyhF7V75R6NVbkYdUI4Dbd/ziV+4lW7qt49eZEk4BiaEYnDKYtJ/CKj4f0xZB4ed4AvxKQOc9+uoEE7OrpLKfX59Vi+hGDZ81pqZAMCF7F/EentTixWcf5VmbtLmT2svYnEkRbVfAmJq+C+qJB4nHoxJgO2yjLvBq2xbJtGK4O12AEZHI0Cn2lbX/g==
Received: from BN0PR08CA0020.namprd08.prod.outlook.com (2603:10b6:408:142::8)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 00:20:53 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::bb) by BN0PR08CA0020.outlook.office365.com
 (2603:10b6:408:142::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:38 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v4 07/14] iommu: Add iommu_copy_struct_from_full_user_array helper
Date: Mon, 21 Oct 2024 17:20:16 -0700
Message-ID: <63579e493cd66965cc830906fd1f152d9467bace.1729555967.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729555967.git.nicolinc@nvidia.com>
References: <cover.1729555967.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1554a0-64c6-4fdf-1a62-08dcf22f63b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OZZYTlvh20Osohn8NRMQgWP5aExEJcZDrbogL3LOEmdGqO0zVQQUQOylm0Jd?=
 =?us-ascii?Q?kQyaXY4e6kv/jDMD1MoKCohSjlfZj/ZCItnFMOJ8kuWzZ80vCgSLWCMpsnE/?=
 =?us-ascii?Q?9cftAhOQlPvMolukwcD4qSOhqp91ZU1BqNEChI9H+5ncQc1M9iCV3NIaMl7J?=
 =?us-ascii?Q?KhmJ+56QMsEdFdlG0luKPBB2AneReOWWukkUUqbjNdp+sqzRmDNxdc/AeO1i?=
 =?us-ascii?Q?HqPhE5H4+I03JGVwh/UyVfsDAO/O5OvwnL41oJqAvKAxADKHUTIs+XvLFZlE?=
 =?us-ascii?Q?Gy21g4Xz1/ne/gp1/ZFzbwfTvDvujH/sde8mqTuC5BJ03eqRzhfPKZbfE/2p?=
 =?us-ascii?Q?pgGJdnauhhS7Ce3NDjPBZryw+bdZ6sDya1K5+OTPxwIbZw1p4aCLkuwOnFV2?=
 =?us-ascii?Q?C9K8As4PcqtC+iOk2IoOqv/7l84IcsoJ0cqszfsTtiubx15RM0McX6UsFtat?=
 =?us-ascii?Q?54Ue7AAct8zbQTBskx6h5blHQoLx6yBbDF7pMAV6Y8rllqhBWQ79qb7nkjL9?=
 =?us-ascii?Q?9wFQ9h8KrNL2Q14FlWqbwPNff7xesR9O3zUfQPBCwpA9OiyN3AETiv96xQaw?=
 =?us-ascii?Q?/fJM9d2lpOlBrsrU8Knh+yHUqwuOXniMKtRMGc5D0xEk1wjUiFXu3dIwTBlt?=
 =?us-ascii?Q?I3PfXNzWxPy37ASkQYRRXdxK/dHJbMiTZbTqBUP+e9MzhpstSv9dV6aBPNKn?=
 =?us-ascii?Q?9tXMmb3pUZzE5JRaEn2O6/iirKAXkNTFjU5MxrJWNJ6uuX+O8ATqTD+CiWWY?=
 =?us-ascii?Q?qR6FxdZDLnSwctYiGK1GE04O+auJxoSe3en69UujDN0QYnlwgdZB/CBRVHhd?=
 =?us-ascii?Q?F6SdtMwT7fgX+c0aqSdEV+169ySCwdEVOumk/moVfq6C4LvMbHtY+qAP+mdk?=
 =?us-ascii?Q?d8jbjgmpAfrWrfA1LyZXIp5Bj1aWhhLZ8QKvUVJouody9xerdrgMdYtHM3u8?=
 =?us-ascii?Q?vD0T/Iv19NQC7WBCE+HY29AfQTa2BGAaIZiqya6nemVex4XE7IeCDrTWPbU5?=
 =?us-ascii?Q?dmb0QRj+8GPY1OnoS0FA6bMbq/KbMlc38kDya+Y/ANVG0hz7FeCKCtnDCrbY?=
 =?us-ascii?Q?B1YG6xZfi18b1X+Lt+y8fiY9zvK6pNky53xWo/+RpWKJQvQ4ZFryXFh+38kA?=
 =?us-ascii?Q?XwLx3aDj/l6C8sh9hQSs0CNRDLIIZ712UE/0EXGwWP2W4tJ64gDCfcDQgOKE?=
 =?us-ascii?Q?tXTHUbx+YB6Fz6hTppiF0qwITful1JRzKD4CuOriCFahrMm3Kwn3PVYxxcbn?=
 =?us-ascii?Q?/Lm95adD94z2lykezL8XFPcMiJkJZYs+y3rquY/1Dm4Tqnrw55efG/Wd2V7C?=
 =?us-ascii?Q?rdch6Q4+VF8C6k21xoTeP3ay+31vc7IJArHp00ABnAFGQHGEF0CtwSizC+yl?=
 =?us-ascii?Q?XEL4mghRAaIpeDXgoHmVFMc0b0szt0oEuoLCSZyH/0SfsVMBmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:52.8196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1554a0-64c6-4fdf-1a62-08dcf22f63b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677

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
index 14f24b5cd16f..8105079ba5d9 100644
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
@@ -501,6 +503,51 @@ static inline int __iommu_copy_struct_from_user_array(
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


