Return-Path: <linux-kselftest+bounces-34977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E64F2AD9A97
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0C9189BBB9
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFADD1E500C;
	Sat, 14 Jun 2025 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oz9/57Y7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35751142E67;
	Sat, 14 Jun 2025 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885314; cv=fail; b=qsvlXSnXN+XHSxIl3OdMRQ2whwSKFGlnBvHX8QBh/5gkqtHIU5B1XnWkMhFLgYO8mEExhZLtOo7seYxmT63BAKx59KiJnQSl9n2UbG7r4i4RqDbOh+aDGlMcsszyzw2dEuikScdVO0p2fSYzGv0Wvg0hBQCugA6I9axBCbJWEAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885314; c=relaxed/simple;
	bh=46uso/ius/40pq+uRBk5AGZ6R4r9+3R2O0odjQsYJdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9OfJSDnrRetrZv3dSiqNjeizpGkXXS2J+I17DBWTQp2WM9M0sFo2tH9fTBlIoKqMZd+Jp68U3Ye1x6sk4JF80gM1mrL/BtFzziQYqKH/xRzgyeSJ98iMlUq8GialQxFYcb9I7/EL7slLWedEDcyInsWs9tNRgvjc6bW7dI+j80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oz9/57Y7; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2ShUNOx4HQj2QVFc0ZHZbhZkU2nmxGT/UfU66j4aatMXKQFu57t0Sj7ocT5SbeT/OEev8sRs3RPYQkE7b3z26ar8vePEUu7u/z0a/0tPmkSblCJYW1FNbKT66dAq7E/SYoduq1OCqYQIBunYUP53M2rCGbtdg+O4dq+Wo7o76kVcLd9uh262j00sF1HWipThiarEgrK9iWGJxU/8nn8pobJD/s7YlHgPN5egK5ihFV6tSVMXQCT7/V6T4OXC+rmEOLdT90YZckG4wRtglz3bvEfQjAzck6ZfnUlVecRw8/rtZ+CW+tl/mWnHn5htuWDk4WxeLV73xtfpo4xaZkNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyToRfTFW9rmOaY+RN8l8tu0oh4F/0yijMIbuQNZFdI=;
 b=bIQ3FYmrhYD/E9/A5aHQo75C1snjKASoWe9+Z3sZAOnn8ZlTld35Bed+KofZPl/Ye9ad0aIwDeK+BxQz1qQMJJlxtbaCPa5l2xA1rB/T2z1wEoaH37tZRpAAJ0Dud7mm1Yw9k9tJRF2EZlt23aonpxiGv7r9IflUrn7ShVf9G0sQLCxETpJCBu7ZZ6y9dG37gD0fTSsB9t3dhv9X1n9MQoXDu1EZ4wKrUgCQrjSL3isdoO+ogrbLs9gVH+86kXlVfbFUH+k/5CVnMLbDpOQzMDHqVxqLsOogadEjWE4xegJXJPKdkkKous3YAmK/9MHtD8RRG6kX9HzccqMnwb66ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyToRfTFW9rmOaY+RN8l8tu0oh4F/0yijMIbuQNZFdI=;
 b=oz9/57Y77wvaHNH3nxTuEzdYNAUOYTYmXJnj4v19YDVQx0bdPkWYWVhfC0HEvfzfON0asrykuCvpDbMlqzT9RSrv3JmPcnaIhB33VMqZLzbs9UYKpD1PUgtO9rOhRZR8QAxbUuSqFIspaBdurND/A4VAARI8fmuWxxr9eBCeUrqDYRmHB2B3uIuwiHzd2t2RSDsbfYgNiinjyPSYicLeWeuNQ9gIPt26VKG6JA5GwYNNQhQMhdba2EKX3aCz+J5tVFdV8L5i0OUqKyeXxHBDE5HEc+8EV+4Lls7LddrUrSInq2PCcrueUFI8OKZVUmKNtClIr+sZd3QD2X42/3vzWw==
Received: from SJ0PR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:33b::18)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Sat, 14 Jun
 2025 07:15:08 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::37) by SJ0PR05CA0013.outlook.office365.com
 (2603:10b6:a03:33b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.16 via Frontend Transport; Sat,
 14 Jun 2025 07:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:14:57 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:14:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:14:55 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v6 01/25] iommu: Add iommu_copy_struct_to_user helper
Date: Sat, 14 Jun 2025 00:14:26 -0700
Message-ID: <7428b583d360eec09e4fd11029638426bbcd98f1.1749884998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749884998.git.nicolinc@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed6fccd-6309-4bd2-59e6-08ddab13315e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q39Ke7AwlA0F5To3T/hjTMbrKsCL8XVPT6F+EhN/HuARPDDWP59rs1KMTevC?=
 =?us-ascii?Q?HrCD0EhHpzIB282swyX0tAn/b+ZhyWyE2v3353KZcJF0468fhJQo4if6x6sE?=
 =?us-ascii?Q?0L5Tn0RnjSqwkCVpH/Nm1LpF3ericVRM8zqSiWyNy6crZAgV9ZZ7vhAKxN3U?=
 =?us-ascii?Q?PlJouI5uFgSHQaKGbF88URSxfdmVdChV8s9c9jp1jtnLrVR3At1RaF6aU3U8?=
 =?us-ascii?Q?tkDDEhSOirwEBfook1LYMdRNPHOTXQLVdsoaUADWan8l5tQLjlFZPyYyKyvK?=
 =?us-ascii?Q?bcPePb0V/PIvVGWCs0UGejpn0UkuCsZsv7f6WHA+Az5Bn6DvSIPszgqqv505?=
 =?us-ascii?Q?U1k9V/xCoK9FjIyYQQQC8XUYH1YJr0zFBYubxnUa4SWd2RDQM2STX76fj0me?=
 =?us-ascii?Q?x25lwgqnVAkmNwJxd3OgfXIJ95L/QNF2y8IbopQRv+GhjaRqQWwgKwTy6fRF?=
 =?us-ascii?Q?CODxa+59l+3Iuinnor+vbsxHwWmnbG7xoSQlJgtEAc4l9jhEL2KklKfomwAS?=
 =?us-ascii?Q?K2OEWreTR9cI4ajXeNhVVXj6KcCGkhikVBuQrRGgSpw0nfUfvCQKmrVSUdz1?=
 =?us-ascii?Q?ejsy+nVGP9N+R3go4toJyyRIZAgTYpibHu9VdPYrLXTxeKOjttK6rYbm45CK?=
 =?us-ascii?Q?o2pM9hqkVgkDUDbFE6/PjGOQutHnz+A2KfaTF5faMCX9WBOyHXw0I+9Iw5Xq?=
 =?us-ascii?Q?b7gsjqA1gLcHrYHoplwx6nP4gzMY2vxI19udTICC8Papvo+7pSSKRGl9wUK+?=
 =?us-ascii?Q?7szhK6WFnDO3TmP4yUrD526tQkpGemvryr+XXf6c/N0DdyyI9J0ZYmnhrn+a?=
 =?us-ascii?Q?At50Zv94YAzUzvZtPFaegebGY04Iy7mNBBv7uXIrD/x1uR6yuPKkRwdPxdfi?=
 =?us-ascii?Q?u0PLt1MuVrI6N1cRTKA5LFi6ExcnPsSiFyZ2nW4WkY0eifmlwYKhzP3C6j/O?=
 =?us-ascii?Q?l/pyic1j6EVjxBRDB9YHSHrUyPd8QYKHn0ad225MKMgS8n8AFJW3IlRL5FLw?=
 =?us-ascii?Q?4MOaosVAfUamDdRqjjJ7ayWdkqCiGYXUDSRaOBGRr/uK0xTcu8h9OOmPCPxb?=
 =?us-ascii?Q?EsGnaORQ7sHCfTN7glC0OOgSQJ1X+JrQpimdvjMSEThoo8XodXVsExz1PH42?=
 =?us-ascii?Q?5H56oLPfvx5OKgB4EsKwjmqVcoAw0I+0zOXxmcG0/fkumrEoSZ7F4FlPy7MK?=
 =?us-ascii?Q?C8i0QbtiEIbjlh3buDUCnf1Q/MD6Z05F5jGR/KAQkYHpSWWNtu0vp8V80Mgh?=
 =?us-ascii?Q?4GL8a94ipFj6aPntRWLQPOA80gS56RWc+50EmysuSCSmUDhmhInbFF3e4PX3?=
 =?us-ascii?Q?zJCMQhHQwgGAZdC3k09xXmmuti3B8rE/9+m3BX/2DLwXtTKJLz3JHJWQWk7y?=
 =?us-ascii?Q?SCgi19M6vP5btAB9UBwQtP8YZCqfLhvCBnWSA5S02TizGiHQNRJxmSp3NLeF?=
 =?us-ascii?Q?GRxrAwQzqclJaiA7OmXI+zJN3BkxMBMDKk8lYrCTQo4k1g7Eigjm3xgVyT9t?=
 =?us-ascii?Q?KW5iZI0sqpjEzadQMnQ4Sa43e1z8RQvan/pX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:07.6506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed6fccd-6309-4bd2-59e6-08ddab13315e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478

Similar to the iommu_copy_struct_from_user helper receiving data from the
user space, add an iommu_copy_struct_to_user helper to report output data
back to the user space data pointer.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 04548b18df28..36a43c6d8fdc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -558,6 +558,46 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
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


