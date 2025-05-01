Return-Path: <linux-kselftest+bounces-32113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C82AA66D9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2957C1BC34FB
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923E7267AF7;
	Thu,  1 May 2025 23:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FU9bKjom"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB068265CC9;
	Thu,  1 May 2025 23:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140517; cv=fail; b=T2u2yXsoLZ+4BGgYuW4bXRs5jDSx0S2lGhPL9iRnumZOHimK89EEUp0/wMH3grshJ2c0E5exRqzyC9pLJ/SzqsmddZyIxY5JIQoSvSo5fxQ4oagFeoLlPy60J4IpCZkylIP8cYlDfW9Gl8A00Aor0Hh27GaIfhyebc0IgkWloj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140517; c=relaxed/simple;
	bh=rOdBOSUUI80MSbDuqwUfdUOc06NYTahg9AMa6OAn0AU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ucslj5LF3aL3I5IDV2+Xx3CV4yn3RVbc/BbUEy47sRpdKKd76M/vLGx7z+OFy4gBIhktxL8hS29NuDNkgk5SbMQiOQxrTUqL7fpz488HiJ6r+5Y8Gl1Rdqdw1HuFnESS3A1PC25Qnd70AY0Bjslz7Erwxoesr2NphVczrlKxTZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FU9bKjom; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyzS3KTLNTiHIZKXtV/kjlfRnF4Gg/jMYt9tYoNUDweGJkRGrcTLOrGWjX1h1LND/qd6FGpWj6Syz0yOj9cchny8K6n8SFT4Bk83mIPgYOwEwNsiIxvOHb6ZFGxuf575BjgHzsW1Jq5XIYBfILg+7OpKWekAqQEvMRDE0K/nBliHrlk2jZ1kEp2BrNv4TI4GmRyyJ3RO5rdsVq96B0kxFHh1FiSwSSgVbN5674bwwFc+Ft0AnXhq70EtZs3ys/t2Zhw533Ib3xxST7MM4qryIhbmtBQ9/1TfWDE7IX6nz0QO/c+EIFV+beV/lE3MBox0HcelQ6/IHSenIbxqbtFI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f7W7Nx9qrnR6kKD9W+a4b4GYDpel/XON84uBebcqjk=;
 b=jMDdtVFDrbo1uPgpP2P/e1nlJNDKmQTlSthj3GlEdyA9vr1CEfGaVl0Y4Misyp/2TTmPUzJIcn/wejmBJywf2VwMh8Z4W4GArFhsgv9ddLUDriDFzEpcsOeNTHT/W+NiRUmwAdvdItWtkRgAQgTi9/yTU6vk+5zpjSMkvzjp298509pEGDJSk3O1zZhFQXqRiNKJy1I36jrGfWMEC9jjx8kSHeaHxrQ9mg2q9zRrRPHlRN+8W20gJvD1ez0rqj08u2nC2Q5sU5KSveUDn6oHctOSqa6QEMnduNekA5Hl67j6hzO7AT4jhqU60s1mJMnJ63tgEjMpTSdnEWRGCrQ95g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f7W7Nx9qrnR6kKD9W+a4b4GYDpel/XON84uBebcqjk=;
 b=FU9bKjomlDewdyswQgTixSURAf4lC8DTaKZd0hPtIDMhfg4KuijxoX/LerFFi/DVY6CZpb4deK5Pc6qqwsI5FkOCWhwtOxBCnZ+84MRHG8bDzOBWfrUli7Db7OC1rwvKLh44Wy02gGDa82RbMzjUBeFXfqB3VQvcy0f8LqdUuEJnk5LeEsSBaBJO56f/Vh1Cm5Pd5EqjRXtV3w6qV9s0O7MQksL5cuvt0/yIv0ILUtqMLeBMNb383cVHX6zf2Eh3y4xzqKMdSZWx+t+fC8rleHBPaSDNgyc8uvXl50vmuEhFNCspoIbRW+DMYqZIKNkgt5+vt+x2EDyagwVyINuCow==
Received: from SA1PR05CA0016.namprd05.prod.outlook.com (2603:10b6:806:2d2::25)
 by DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 1 May
 2025 23:01:52 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::f7) by SA1PR05CA0016.outlook.office365.com
 (2603:10b6:806:2d2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.23 via Frontend Transport; Thu,
 1 May 2025 23:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:01:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:01:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:01:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:01:42 -0700
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
Subject: [PATCH v3 04/23] iommu: Add iommu_copy_struct_to_user helper
Date: Thu, 1 May 2025 16:01:10 -0700
Message-ID: <6057dd1b91e7cdb1273a27b71e75853493a0afc7.1746139811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746139811.git.nicolinc@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|DS2PR12MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa42a0b-4652-4364-f5b1-08dd8904295f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2YFt+qbinFOFQc8eLCC7Ej3yFu4DpumuUcl5YASQ+vZCI1fympHEf6FHErtL?=
 =?us-ascii?Q?krua+n/2zGbQxMoc6u7vqSkSYzh3RwWiwzbrSJMLHHfw16ZnPUegSBUhpyDq?=
 =?us-ascii?Q?rx6X1+UjytwCoX1Ubr3m84WaHvP8+nhluuylX4/1Q4n2AcTuBathXtlybddK?=
 =?us-ascii?Q?kHDjMcjvZ4nS2YQ5e3fo7Wz7/Att+lLY+eL2uGxXZ2QlEHt9luw1irodZUn5?=
 =?us-ascii?Q?vcCJJsN10MXy/w82MbFuj2IzWGhQL0K7JFfndKtwmyQFORJChytEi4gVdplT?=
 =?us-ascii?Q?4Rvzdqj8ffzU/TEhPdccCfc7dXD6HADt7bfbVv8oOzZPMlkGIMTbO04hq8Ro?=
 =?us-ascii?Q?KMp2XG+ACEGh3rC4eeNf9yy/FE7CQPagdLGwQHeySP7MGkumB92c5rxFUvIS?=
 =?us-ascii?Q?nNNz+/pqgHaDxxKCBo0/zXBbSUaDdu1AGeX2rGJs/1d8pC4l50tf9OY1L0hR?=
 =?us-ascii?Q?U17Dw2jjw7yR3pNDUtMgFjznEEWJCZce7WavY1cV7yZGXLnSHqGLsLWBvdzi?=
 =?us-ascii?Q?8jGg20KgjDHez9YzjsUnYipNUvs/62mkE80EZBgieQ/zGwyXdNc0fXGgNpzA?=
 =?us-ascii?Q?xPKRytRNfuP0VD7zFmmw4q66qBb0Lq6QonUzfEmf3cProDN3nLHgAcNtriMw?=
 =?us-ascii?Q?xkWx3JxU/eLyV2y9/fp5W6tBFZlOxx+wE6uf6+M6SyLaBlM+ptW9FIVhBjYp?=
 =?us-ascii?Q?YcaqtxgJcCAHpjEzsBFfluIUkbDO+a5aYHip9keKtQLuM1h8nSEj+M0f/s4B?=
 =?us-ascii?Q?qnDgfuOGf8VwIRFrGLL04GTOjOICj4fl3cPdw1pqA9uxFKkBTjalSQl8WlMB?=
 =?us-ascii?Q?Bk3rbMr432/J0mUkcDeA+oiQNmdhiAQjNi4ckvw8aU8zHhxr7ZhmGb9OSshZ?=
 =?us-ascii?Q?lZ5AP45sriaeD/vCoxCybQDDO8ywvaVMfFNW5sAxFRuhqWYOMv+HQBJzcvuG?=
 =?us-ascii?Q?RLGMNhjHR57jG+DZXh3Us5nfBvKwSlo2N0AcThTZE/utXfmpwApNlOexfDLe?=
 =?us-ascii?Q?FQ4dKfxym82e+BxkSELgpb659ZE2MwjKeDQ/xEuQvSrym72xu5pYYrxtj0Lb?=
 =?us-ascii?Q?DWNP5sHjdFPcHYeiIQHEvtP5fVeLFAmrJ09hpaak/dNQskcHB0vxtD1AHMv9?=
 =?us-ascii?Q?SN44QYmpDDv5y7F4gnhtuICRxEzx+wZaADtgSVhlz9TKj8nKScRkNfFesEi3?=
 =?us-ascii?Q?XNeI2IdB62H4ADTe0q9CCvZKpyNjL5EqDJ31mxhE0oVDnP0LlnBT5az63EIv?=
 =?us-ascii?Q?Yrom1trKhp1XN4b08LV8dSNfQ1zdMkFMW8dcVjS4/XkYQxm6H922hYe5G39t?=
 =?us-ascii?Q?VOx+5ZhQByp8HB5kxowELQdOFMywhQ5T4Jr4kRJisJdMTjZWZ0QmrrL2R7yx?=
 =?us-ascii?Q?PODADIhfpfiOHb5klCYVavB6DtNzh8kqlL66sNn4Ye1yblKQsKw9bPU/E2Fd?=
 =?us-ascii?Q?OlU+nWRWiVqBCjoyqxuFpHqNAITwzDWfL2aNXyiI4uMj7zA2xgp3L32aFqHY?=
 =?us-ascii?Q?4ln0suLMa8FF6coTPh0VDgbPmZ4JrgeMEyu5?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:01:52.2171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa42a0b-4652-4364-f5b1-08dd8904295f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9568

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


