Return-Path: <linux-kselftest+bounces-32703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD16AB0839
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B817A16A310
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E115123F43C;
	Fri,  9 May 2025 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V8QhmOFT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B9238C20;
	Fri,  9 May 2025 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759806; cv=fail; b=pjYYHbfL1AysUNEtjfMK1o+VULXrAe2BQ4Os5limKKEcdaqMnkzcx20ea4vHEPc8uv4aIW9vMBZx7EY7tHViUv65jkkOBE91gMyybtYF3/QUSwKtIpd/BeH6HldZOmCBbDCQ2w3Qyyzg+fTXns33anEmAiZHUDxGjltzAVNvfVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759806; c=relaxed/simple;
	bh=rOdBOSUUI80MSbDuqwUfdUOc06NYTahg9AMa6OAn0AU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=St0viXxpuCsf2nwsH276wcsa4YYOoKUGhWl56fGkv6e+jLYh2eCFiAosJZHuVwZFJoIVqpUmFNzVzpucpOAYHCKYmo0L6R14W+kfofxtu4IFU+qwPvafufArOsm5B2qiw+5ykNcUx7ZQFmvzq6k2haczX5JrHZ9RH1lLsa8yPEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V8QhmOFT; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzXvFZd7rl2L8qjIZ95CctbxtQyn6SrWCi6Mh4JvS82QhAaA4LZe99Tq2ZKbJkYobQ/IDj7EwO+KI7d45ATcyUIbv68kVuWScs3l3dLDap+wvumPkH2lOEGONFuMjAQW433kYiKp2AdE/0yC1YPwY40BrTV9ISYwaXsKt9E+C8t1RAAe/DPr+tspkvxBuc0MmzQQaIAOzb2t/WwHBDCfZUfLeD/KrEQkhDr4MtGZxRnCyaCvpcproXjjHfQuqTJc8fbdoON/0iuJmG4dsgQGl1b0PhwomBQeytDRXP1GaFtEo7A+82Jo2NaTd2x7L0M/yXCgXCVpSBObahPGcXnkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f7W7Nx9qrnR6kKD9W+a4b4GYDpel/XON84uBebcqjk=;
 b=LY6s94hawCFvCvHzhYgwST6adXIEfNRDmuzi/5u0EjnvTvrzvySbHqbk4ruG2GGEAbD1KveB0CoisNvhFNVglAUr6V1G17/VeBKd1k4UFXvqQB74PPz1gX65uTJhW4jARF9s8ofKfeOV9MDIFZfNQ1CBAGgH7aQpN1YUNM+KO2P2ykGBJwbdmlCLvi8AN78oa9PayT7vQ6mCJnx6K4SJkTPZKFsT7u8ACDOdVjcQLRbKnGQwMcnK/88S/J6GuRtuQddsawaYrTgKtxlmG23XDm09ZAG9DGhsS7134Mk36VdNO+RatMWWpgowDM3piMx+wxWkMho5cVbYo9Bbv8/a6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f7W7Nx9qrnR6kKD9W+a4b4GYDpel/XON84uBebcqjk=;
 b=V8QhmOFT5XhdVn1yOx1RLLu54uy2vXaTfciBau5rgKKCLwFq6m99ZHTe+GgvwID6zPwF5h3Cg2EQ1ewyIEaYdpqYAzmJ6dKXrEjh/To8QrHAmjhV1j6Os0bjGbORdPSufDa0yzEJAWH4kJ217KG8HRDQR8veRhpr+p+B+tz7AEXjAv4TVeNfgCAmgcdnDQHnLAB1cAkS3Lew8/1rw24jP2hMNKT1FugPobBItuEwQzZsYmxgWXjpRCdzUWxsH3xs/WkNIrWJRVMTKxqn9wjyTKCk/uvl+whuL2NuAgQ1oN0XWermEmWQdkObBgp34Uk2qDuRWRnekBABVbK6Z6eaGQ==
Received: from MW4PR03CA0305.namprd03.prod.outlook.com (2603:10b6:303:dd::10)
 by CY8PR12MB8298.namprd12.prod.outlook.com (2603:10b6:930:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 03:03:16 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::e7) by MW4PR03CA0305.outlook.office365.com
 (2603:10b6:303:dd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.26 via Frontend Transport; Fri,
 9 May 2025 03:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:07 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:04 -0700
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
Subject: [PATCH v4 04/23] iommu: Add iommu_copy_struct_to_user helper
Date: Thu, 8 May 2025 20:02:25 -0700
Message-ID: <0ad7b2ae8f0d692923dcc9d8fe3feb85017df520.1746757630.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746757630.git.nicolinc@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|CY8PR12MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e82439b-3417-41c8-153e-08dd8ea60b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fZnLEbC1MPkLeNdPKJny2EAVfCsxSsHLtouKwHApl9tCjijJ5Yt4h6M4SpNH?=
 =?us-ascii?Q?tBVTQ9ig0BEKCK7l/aAvs46ppY2dJS0Pf/IRZKwd3aiqsT0Kx+EYPpCq6GAi?=
 =?us-ascii?Q?5Ay52TEUcfWOZN6wsi9hk8GGKqr8B7PrrZCTnZfKyOngOc8gw1BDlLR50NnV?=
 =?us-ascii?Q?kQUzQ9jWOE1SaZgM70Yqkb1e7chbzt6/IhmulFa+RwJJhn5x2s6UxnKAy/TT?=
 =?us-ascii?Q?7jXtqf+3YOGBKG1FC9ePbL9ooPllXPnJpkDIwXSv+7zYHuza9QlKu31+SX+R?=
 =?us-ascii?Q?+K3cG6iQ3VYG3tu+UFThk9ko6tap6t2vCfkBiTyxvy4BspJF2mItpYf70Xr7?=
 =?us-ascii?Q?q859dQS8suG8m1n3F5SzoTWXzRhPo+pfgSASlYKUDgjIZGlg4hQTIoE/uj98?=
 =?us-ascii?Q?g7WDu7No4oqC+CxyplfDwZ5u+9ijidBZEqZJmRgiI7TwG/pzOSElHbnql7hm?=
 =?us-ascii?Q?rfywQz/yYjkWpZrUuSkB/icWWFeasjdP06A+Aq8cWVB2S6okeBBtFp8BbECR?=
 =?us-ascii?Q?KPDRjQOedItAkZ1raLKffNzUWvvRL7i4+bqW6jC3qX26qcSHzM24+QLghJ8F?=
 =?us-ascii?Q?THpyZ8OHfn/45lSx8nWLon5AC4JQDnjRrHEAaYqMeGRNttSdi5Chti16BA0I?=
 =?us-ascii?Q?AUMz+xW3LI89slohD4/W/SFpWVYRGhHNhOVTl027FWjzfAirhqyMsW/5F2YV?=
 =?us-ascii?Q?Zt1x4cQX11zfRafy1nbI1QG4yqzsG1FDIxQzLJFQBF7d31W2rY8SbJ7OmZV9?=
 =?us-ascii?Q?YqspEgkrCFOixoqR30ePZfuhq1qsCRCTdv9tbQwK8VvnuygHJZ8+Z1bHXMj4?=
 =?us-ascii?Q?XDj0EWVcUYXkdpGUt/2p0ETdkFsNGuNRDgHzRRz8gy0PS0E5hSP2WxWBlM4u?=
 =?us-ascii?Q?KF7TKpWQGCijWty9MFg9FeP27YPTJW4XX4nCyUdbmq+cR7zBHPInRaLDPvKv?=
 =?us-ascii?Q?WaiJHvCBYmf4IboCHy+o3kEagofLhY9qYMhwLkY09Bh45sKj6LFGEROBpgZd?=
 =?us-ascii?Q?/keDKnVSA0NmfNrwgERdCuKGWQndi2IWeb2dmidSVIRen42059ejYqXTW03i?=
 =?us-ascii?Q?IVBDYE6c6e+09we4jA+6GVQ5zBKbhxXLARk2R+rjGeN+LNyvfNuEcohb8RwF?=
 =?us-ascii?Q?bYUvXpKH1uAnWPbuiPROTKb39Y5w95wh5lkwzw6mafVbgC0uXKQzdl6j4f8u?=
 =?us-ascii?Q?6eGUFNdOA6Gvcah7vZngr4MP3M5yc5UGNlXWx6/i12W4grY7XQ8MD7YP7sl7?=
 =?us-ascii?Q?9qT60TeJvlAotCM2OfhkuTpNcXKJd96Cj28ggRufUZEKNJTAZLKcRWLm9pGG?=
 =?us-ascii?Q?TI/aul7tXDUxLbyKW5Fpe10iEfKLN8ym6+/wfLjLa88J93Av6YWId1sTnHcE?=
 =?us-ascii?Q?wy5Asy48n4SPpxRxWJP73vm2h0qNqm3exhrHHmuABBrf7wmblW1fE48XgJYG?=
 =?us-ascii?Q?sczjpcl0+PaBq9TOjc+Opwa/MPTwUSyGRtIdjkKfcQxmZxkgfqBJEmDYsxrV?=
 =?us-ascii?Q?CAZc75ikdn8BpLqckn2MQPumb0ozU9Xil+Qg?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:16.4122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e82439b-3417-41c8-153e-08dd8ea60b7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298

Similar to the iommu_copy_struct_from_user helper receiving data from the
user space, add an iommu_copy_struct_to_user helper to report output data
back to the user space data pointer.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ba7add27e9a0..02e9d5904836 100644
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
+ * @data_type: The data type of the @src_data. Must match with @dst_data.type
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
+	if (WARN_ON(!dst_data || !src_data))
+		return -EINVAL;
+	if (dst_data->type != data_type)
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
+ * @min_last: The last member of the data structure @ksrc points in the initial
+ *            version.
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


