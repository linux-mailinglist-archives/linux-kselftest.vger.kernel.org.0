Return-Path: <linux-kselftest+bounces-20742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F899B1391
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637CC1F23272
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B2E21CDB0;
	Fri, 25 Oct 2024 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WC3ZNhRj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912421C2E7;
	Fri, 25 Oct 2024 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900273; cv=fail; b=QWg5sEXm/2TCs5W/ruqwYmwEVXPD6wGB4xLJlLonhbW8tAZ78uYkOoSLRc5excDNZlkK7iB8aBDAwd85DnU8A69AhqwjCAZq0scnlB7bmbEoW0rr0/FhjJTQ32WGJhUdpHioxn5VrCjOJe1++LymxeYp6C17bJ+B0gBKOPhwm0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900273; c=relaxed/simple;
	bh=9ULRXjb1t90r69U4kVFtxEzZ0bUWoxzjiqhBoNawn4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gifn/hj/Z+K1Nxvgh3ucKl+gyVQFpEI5kAd9Z4EnGQGsuUfdP6YokL4ptP1bi93Rq9gCkYf8vmcbtH0bF4CLvHHk8mDYJiaIAh47MV1a6/OZuIDsvDyYD8OLn/fkYgQzWVsQeKzeqa50SFWZ3R7JgAbI30rwbPjhyDJp8iywHTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WC3ZNhRj; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNqk48yiD0fGrVRtbqXFjDeK4ToGc6fwLG4f+ZEF4ruBiA9F0j4JUf9ukXtxWE0M0nxM+t4lrWG941nCuxfKbomh2nRqeZ4gyPy/J9bOp+1FhzMeMI/ptkFobnydC6c8MJjkdn+mVReBi3yFvGrkUDPRAzFnSFVGa5po/KkgMptEpKQ0ShktqRXEiG8VPkR1UQGstvsfkVv4NvjHOef5+V3h/SOjQU3hRGClEUbvoJw8GpXxWy0OtQM2FieqVkeiyrwLBdsKrcW22F4QQjVGZSDxQMTD/klNhbj00dkv3FwU6qnoNkB+ToVMvx+1EQNN9J8PFZkgMtKNQV5Dy9FIkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmItsekwfeO802HIZU+t5OAf0G2DRhEQ1I8e0cO9Lcg=;
 b=HV02MMKvCIigrfNZrDHocRE+1RRzPDvS7TroPyikf9ztaB+5pNUSYxjBqPORb7cKuWsZFt3uLla/BB0T+iCinMrQqo23XPWReiQcPEWAsKv6rbnPk4QxfgaCXCsxTc6sZmA79iEOji057aN1GnxENIOaK1S+vVv3VPw+JcB/wfc2DJNYGk7uHZSfO+Vakrt8U6ze6uY9rc45wahIBPFIqViqeHETFLpZWjrdYFEos7JC+zHalQ3IAhbiSltpW5RhMR7fCmBp8uZSuz5Btz/AtE3/FdzFCDbreo7mWR9ev7PL1WJSZTHgQ5/3uObnmuBF9i2fVfKwmZw44Yh+8+y65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmItsekwfeO802HIZU+t5OAf0G2DRhEQ1I8e0cO9Lcg=;
 b=WC3ZNhRjnHp5YSAsJ6hB1Y1S6x7xM1xOqa5/oKXyan6c0INyVFEQXpd595JFACgO6Cu4GuMyFUQQqnDnvVK8Rz4KKztUFgGnIKDDYVLZOajgU3FRd7hBqFAdk30xnJu7Tv4U/Au1sn/BzdpWtU/ZhJEF85ZXH9/ySZyl1KienACopLcUIwDKTOHDoiTNV/1NoVNiNT76L15FPiuwllVAHq7kjipz8hz+6XScCpTvUZGnxSXpsMobJoAx9heo5/UXGUihAcLLvyO479Mb3aDCQr2qpqtaCL+5cPa25eT7FmE1KJhVizzZKoUX/TCrVy+xzzqO69AWsFG2WNzVrMajWg==
Received: from BYAPR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:e0::46)
 by DM3PR12MB9286.namprd12.prod.outlook.com (2603:10b6:8:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 23:51:05 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::2f) by BYAPR05CA0105.outlook.office365.com
 (2603:10b6:a03:e0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.8 via Frontend
 Transport; Fri, 25 Oct 2024 23:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:51:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:55 -0700
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
Subject: [PATCH v5 06/13] iommu: Add iommu_copy_struct_from_full_user_array helper
Date: Fri, 25 Oct 2024 16:50:35 -0700
Message-ID: <d22517338a5c2bbd4c1bd5569f4409412206e100.1729897278.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897278.git.nicolinc@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|DM3PR12MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: c41ae62f-8913-4f9c-6040-08dcf54fe3a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ChXZONn76KBOjkwoLR5vTSqntVxZQW2paeEF1wk+QUyAvO/l1034OpnrN+Qt?=
 =?us-ascii?Q?JOcg8OD5fjh14H0dHYdVY7Mz/N1NpZLSX6MhKVwaWWB1Kvl7jP2HxzIWrs8j?=
 =?us-ascii?Q?Xnzxgr9D7837fdPs1LXSttYHTPQNDmLyAjxedpKoNvIQcffaPpfWZYuf/m0b?=
 =?us-ascii?Q?8az/McJiUwzUdAglNbxYQU3EMt77QxVaVhrdtJ22f4USRiZx9KrP4IIvwHJ4?=
 =?us-ascii?Q?XlK7IAXBQ8qOh5tURq6lrzw217eU3vBgsClufAgGjRQOVYi83XOYqKWRUesg?=
 =?us-ascii?Q?XtxKKFb4d17L4JAp47eKNH9ELHwzQ0wfR9XhxxR3xL4JSYw5lW8LRxSKYb5v?=
 =?us-ascii?Q?/ARPGulEu8oJQAr2Qxv25r7OREflmwqoZ+NKJnsDKQOxfpghpiPvNIvOHck4?=
 =?us-ascii?Q?mSdnyVJlczQoC+BSDYPltR/xYm4d5N0/VeHJU8wKGnkY44CPyHaFPxq0WZqB?=
 =?us-ascii?Q?5/vAEIdvkSCH1ev7oLhdOzXbShF7F3YRylWkhL++ih5eS6vppMxNRIgq72KU?=
 =?us-ascii?Q?yeJq4H/0hXDDZTtcuIU2OhzZzAMswBO5hCnIuhaL0OT3hBTeA1EGFuPhWuVU?=
 =?us-ascii?Q?1mg++eQTwMDl9fuDg/JYO4Y9wJDCH+T7wrcyJkz+DOqdgwn0bi4d3xWxpRFl?=
 =?us-ascii?Q?CbcjLpJwHjURm7x0OfQnvLcbukFPriDNq5gAa5dtkYOcnw5TBWj97wPNaFPe?=
 =?us-ascii?Q?gi/oHqCWZoNjdy9jHdtHoLFVdzcqGaOfVi//CpvrfG3i9ZhCLKZqnB4dFyKI?=
 =?us-ascii?Q?Xoa2WFrZH6tQh46iCXGbvPBIdTMx3AhouVC4BIarjxkncwDFsVPww/D/U6FR?=
 =?us-ascii?Q?hacB7Zcf94UCkM4eYyZGUbgHaaDh1+tCyYPkMmLSFIyE7Mki1ju3KSyXuAdl?=
 =?us-ascii?Q?ZH7yjjkcqk0o5jlXwupeoS8X/xz0eib2VkxwBNJogRBIdkGLCWzjSlT3aedN?=
 =?us-ascii?Q?kutoqZysls9cmz7RLCs0TnVL5wacnj0VDreywmN0FjHFednELyHGDJXu1Ozb?=
 =?us-ascii?Q?nZapkJI2aFnojiTGVLFjSmq8ILnQN5DVg6C7lb94GtSzcWmxYHLswUrooFin?=
 =?us-ascii?Q?kPWP9lRkmlOhcGNQ4jyPcj78tFWMmFW7ha0Isxh1XlT8Gw1stbeodJvgaPXj?=
 =?us-ascii?Q?b5VQmMK+tCmxJLTg5f2OUMWYTDlP30KmKFYn4Dc6U1s6sYuvTPGd0i8yWiWJ?=
 =?us-ascii?Q?3jKUFe7lZpLRGsr2Sir9w6hgMPb4MMFu/PTdTVtCL8BDaoqundsvgzLVviq1?=
 =?us-ascii?Q?R/tX2HM+avK5mQm8H6QdSxrSdG7lUTYIoU+ktM47LF/7L0SAOGRCG2O86EWE?=
 =?us-ascii?Q?bmdyiwlqfLyrwKLhFop+Qprf60aOjltn1aaJtK/UFDlHxHUg75GTX8MFpc8M?=
 =?us-ascii?Q?HaQgbhail44z6OWv25ptreWry5qBJB1rNIPDhGtO105yoxZU2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:51:04.9721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c41ae62f-8913-4f9c-6040-08dcf54fe3a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9286

From: Jason Gunthorpe <jgg@nvidia.com>

The iommu_copy_struct_from_user_array helper can be used to copy a single
entry from a user array which might not be efficient if the array is big.

Add a new iommu_copy_struct_from_full_user_array to copy the entire user
array at once. Update the existing iommu_copy_struct_from_user_array kdoc
accordingly.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 48 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 14f24b5cd16f..3c3d5d0849d7 100644
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


