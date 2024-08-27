Return-Path: <linux-kselftest+bounces-16434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372DE9614EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3172851AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3781D362C;
	Tue, 27 Aug 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LrFihceh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83051D3194;
	Tue, 27 Aug 2024 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778126; cv=fail; b=CZ6ZWIPwR4yDHh4z47lOTC95UUYRAMFCrOcXLDEIQ9YHNvJqLfCHXDibItHdsVr+Mk0sWbL0bO8DdxMzwC+rvndsOggLc4r7ci4fWC/bHS/K3357aBOMl277vCMg6FtAd4vi9JiOFEtKjSvlOyoOIde4sp6EVQTbQmyYnzFIZkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778126; c=relaxed/simple;
	bh=77Rg+XUUaI4Cyc/+2/ci1D9prOW2G7RCj5IFElQKb9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3YfvGL9h7Lm66ubnHPzTlhRh+c6ejkD2KPQveQjV2s2vdGS0CF5scXN220BuvEwLtYR1XzIMVsm4xmw54iZMovjErJ8TPLlO1yosFVJGwxKEHMImh8RAGiPO1bu04dkFrrrwLU7ARpddvos7EWV5eRWQly7m2o1MqJ2XF1G5+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LrFihceh; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3Jexg4pTjX1leCF1a5u8Rwf1S2Az6naUjKERq63PaqAWWn+YjeuWf1uNNnDkJLDHmQM//ydpJj6M/5eXLc9s4b+XcpRm2WC52C1Nb0ZyjZldXg63A3BS9U8hw1kGDWKU1fC9UfS/+PKPsFbOmcLnERK2MB68sKeTtLMFc4p695HDwLy7bjswDlvE73udbwAC+aeYel56XPILWUyO3iE4TX5Q6k1lKbn2He93JoFgWlTMMcG01j4mxLOFacuMs37jtMhhH6JhxkYnhyLKqL/cZUXPPlffQN9M6w8O7+7/hXWDgEG9/Y5b5Cl4aGJ2LSGu65aoEB52bsv3X2xgLCa9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IV/muEQnoo8rlQRVDk2+Mw6tAvwItl8MKO6PgGjBUTE=;
 b=IKY4Buzgqe1rdJp0QQKjAAQbBYrD2gxjqgc9tIxpb+/A8VcTKOhP70SpGxyPVFDRO+f1Pscla7SSrlCg6RovYMgRVChEUDbgj8pRQ8+mx0MG9BHZ9PAKdi6dsssAvyspnF4svZiDaz+TFFm0hKE220QQS8OiCM4yN3Iy3nCNNiu4M+kFaYasQ45SwbrVsR5lwiagQWDQoBm9H3cynzVykg2+HQFXPVoIbvY4LrE+3J36kn7NtbV599Baqx+rIZ8gftw8r6y3ajRehKPMxBiOJDcpfFI/zU4AUxqmS35S4fyqZQKsYObsOBlP87CANjxvIsz56b6PhHBL4njZh+EhpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV/muEQnoo8rlQRVDk2+Mw6tAvwItl8MKO6PgGjBUTE=;
 b=LrFihcehP4drJkAXLcUXJr8ZXARPRQLzdMOAUluSkaic2zLZhqMZ1ujwZ5/BNbrajRnwWi6lCvRZHXF/s9TNH42GoyhUDJyBJ0h6S8nmrJaA7agamAu2EqlQ2acirs0+wI0Fhh2Iuq5n7k/QxogMHwtkwpOAbS1N4VZUv8d7fb/H9Gv7qWU3/t65lpWf0muoDMOIHE6UkrontW2DhBaztS2qQqRA6P2Eac5CWcgF+KX+/nbVuyzKcQLoYJLl27N00SnUwD6OZY6fpMZnj4gQyvKoGvftGwPWyybNnHJ6rgC157ONteKGdBJGFFaHbJeq8Ov1vJFnDGOAMLhT8CpGZw==
Received: from PH7P220CA0104.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::26)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:01:58 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::28) by PH7P220CA0104.outlook.office365.com
 (2603:10b6:510:32d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 17:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 27 Aug 2024 17:01:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:44 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 11/19] iommu: Add iommu_copy_struct_from_full_user_array helper
Date: Tue, 27 Aug 2024 09:59:48 -0700
Message-ID: <8cd72612c5c8a3a03df0c7af9749b76bc16bb3d0.1724776335.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724776335.git.nicolinc@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 2756f5b2-8c92-409c-4ab3-08dcc6b9f5d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NDUYnIxlrFtykjyU+DWPuC2wBn0qpEUNkGIJXKzpRTgYUxK7XHVWQJZGFgNq?=
 =?us-ascii?Q?sxwTXXd8dTTcUDDS5Drph3w/eoCrzIn1TDakBtGCLfLYGRfQLRueaig1MPKw?=
 =?us-ascii?Q?QqVV8Pw9dEOtoTP340VmoQ0fsDZXX+JlnwRRcxzaxLsb/G6cSDK3qfLkxyhI?=
 =?us-ascii?Q?3+ctcQBb6tDDM7rEBa2wi1cUFBdYTjvylHjEt08WnZr7sKg6SZk7+ccz6bV2?=
 =?us-ascii?Q?tL6JYZTP/eBDKHKWRJwBNrbO8huvoklxotimTpNfjwWC+Lw5qsPq5WF7Ro8o?=
 =?us-ascii?Q?8qo4vECTvFXVTReOE8ZXPqKb5Ic52QvAgHY5GoO4ipNKgilZktaAuJ4N7fy/?=
 =?us-ascii?Q?mKYYdKNiD8rtu9HYlzdtXhFlj5TF4S7Ud5GtURrth6rND78X9IiD9A4knvCk?=
 =?us-ascii?Q?B8yBEuD1mmj5w5Jj8414kTiLHgAsubjZfYXWle4F4dgSe5A8q7PhiAb+vxDU?=
 =?us-ascii?Q?9mOmATH8W8cz67Eav7qTWNM7xVql4FXhgno/cdcg0Oi64UT3zb8TzZIr0knH?=
 =?us-ascii?Q?o9CX9DJFeCo4reRs2ilUNznE9v9MRI+KPg31B5eV5fGQuQ44V5Vet5MV3p7N?=
 =?us-ascii?Q?aBWtQiLD600CiJjGKCInUpwVB+OFXQMQVWiWoVk2NXnQho8bTnJDbyRh3Mkp?=
 =?us-ascii?Q?vHcFDjyLD05QN1uk3EggVxl4PbwuqmqlbTM8UoHKvYo1IY2/KyWfl1NBgQH3?=
 =?us-ascii?Q?YRi7nbJTyoCyT0OxnxUiUFjhgztGl98RpymYA9p7skopCFKuTJMyDmBLRepL?=
 =?us-ascii?Q?Vqv96jOE91hkrGmIG0EIdVZl2iy9ypWTel7muI6qTAb+MOhE7/CFav1iBh1C?=
 =?us-ascii?Q?Szabo4zXoItMYn4muGnsSt40Pm47BxFTNuCet3WO+XX2pAEeiaJMVUBr96Yw?=
 =?us-ascii?Q?C5wuak0aGC9s5JMP5kp5ZBNqLBQmbLRrg2hLYYXARAK1gd6UBYM0SHdPEaxP?=
 =?us-ascii?Q?Kk6f3neAxoiOVAzTCAgjHn9/GfSuVasA+PmJarWIlAWsZ5m/C4fXnike5zuj?=
 =?us-ascii?Q?eRgOJif0gUyTtPADxFtKD7xCpWcIHcsiefHfqWGoDtmIDKlV3OPia5NxWlrl?=
 =?us-ascii?Q?o4Olse+z071c3EmTTli4/5zgQWVkiL9DPt88BDaGTwD1lSOasUvLHjY9ELSb?=
 =?us-ascii?Q?R3L0NXzGWgrL5Rah8jLofhK9whk8zanE6deUThjEwWBkrWJCwKVcp/VYtcgO?=
 =?us-ascii?Q?919pkjHqhb0va6qvEJDuiGO/Pe2BPgMLfHDuzyOSLPSY9SnVUBRO8KrAJfRN?=
 =?us-ascii?Q?Zj0Fdv2gWzl7bgXTf4JNxw4Eofgbkj9oxeb8Y4YXOeuF91w0NtqAIyHQDg8Q?=
 =?us-ascii?Q?xYh1EwAKH2s5knvfMH3P855qWwM7zvf1+Dq6RkF6ZXqn7zj9YWH3uCO1MlLm?=
 =?us-ascii?Q?jis9F+t6BmjC0QE+kq6ZgSOSW/k1T9bfjVbPjso2GpOnk32sSCCUbooP268X?=
 =?us-ascii?Q?bX48lOkQuaU+PU3LTn8PS3xcuEoMoEqQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:01:57.4566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2756f5b2-8c92-409c-4ab3-08dcc6b9f5d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514

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
index 8c1034cc3f7e..556b6d6cf2a8 100644
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


