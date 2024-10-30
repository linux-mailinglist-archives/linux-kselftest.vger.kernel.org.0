Return-Path: <linux-kselftest+bounces-21167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A7D9B6F3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8DB1C224A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878FE2281DA;
	Wed, 30 Oct 2024 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ke20CTNG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9E228B64;
	Wed, 30 Oct 2024 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324120; cv=fail; b=fDxyoojh6WGiotnkH7J2vMmU6LoXsb0aPtRKGcx66/Pmkhy7Z4JpUjyC+mLUyKie10AVxcOieSGITrYtZmy5UeePSbtpHd7pmcwPYpEuRfmA1a3JuA0/P42SyBs2DrmhE+sVkBQxjIS41WqktvvZoAVvunSyQY/Vw8A+55LW9Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324120; c=relaxed/simple;
	bh=t97PcZI+7XE90w0tbKnApVt2sZ/ixCrFm9pYuL6ycFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItqYYN0gl+shkgV5WM3wMVlg7yLlYhRpHUXhVPV0LAQFofdxaM6rbp/iQnbmu8UoCL5DKvNcUbOURHYsFj0UAZoYhNHIZKf114AjzSA0xGmEwGzoNTaxFmT9C9I+r8Vy5p4uVsXWFENLOYAMO7grjsyCglehvbSJAl9puDMRebw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ke20CTNG; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8NhMiGsxqfWWbzbV8iUumdt0vvqbpu9jIU8QG2RbmJwjVVNpq/CnUVkIy54IlZP3jAxnjp9rz5Jc9sjkdltCBjLETYsHV7xJCgqaxz60lkYV8479ERyD37hNxAMa5ltgFpqA2VxZf6JPNX9z980RL6FjJ+uOCL/dCDU5lNcJsydn5qZ3llqIqDfnZLh74WF7HbICLoNRhv3bxVurr/MEUFzJ6vg2DzLARcLvmV868BBI+hmpOzCwEX5cy2T/tUrQAvAj8KhCUOP2+O/n3aEVcVXy8uH3FMg//28vj2YgR7eOiO7EwuqZmIPBQE984Di1bd7co0mxz+HO0m+zKRhMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7yhxB3ToBGOWp/P8r6NtWeZuBj1bQjK7yQRPxEllrI=;
 b=btVzy+jTMXP6RAJ4TYHu2LnxbAqhWUtxrGWogtD6dfYatzoNF/hSPV31crh+UESPE4dk3WK21iOd5qnZtDFB6zHca1RzN0pK3lvIU7QRXWqXLLshDji6qiWSlNtZHq/A62xsTFC58paPw+zYJArnOFKhByq/DClx3jl2vaiaIvClKfSOHOEauaPS6UPkUZfYcqFdZHXPostSi8zHYzoKKIs45JnZTFJpFrrRxSq3qn8mvL7gK1tW+H6AnMsXkSUVknpa6EdWC91OzSYrpm/7kxFNPCjVk/iWnoVlo3d5vnRk7eflEGVbDtOAGbq1aaJ1pGo1BmI1MgDQCLP3aAdNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7yhxB3ToBGOWp/P8r6NtWeZuBj1bQjK7yQRPxEllrI=;
 b=Ke20CTNG0RpJU7/g4VeH4RzKP3/QCunT+MF1waNmYPmedQ+03S685H8LtXD33Nswu6cRTdhfxR+KCq2X6dO1/+ZYwN0w/ip0+ip40WguSSnVybYqEU3fd4koBgB3E1+mN3evIgGQZfmQ7B5k/oqro/THX9Qq4XIO/xd3kkkUj8Y0vimt9GJhOFK0S3kLIPg+xHBmZ+EFYTPfyoS31LttA+dh5afSGTNN5n9YsH4UsFUTuSRcDdhDy/wDlrpfQKO44HPa0k7cucaOdNvosZ+5oWa0dqVxGpH7weXmAm9iw89O4vkEpFiZyq4nP4wUcua8CaFzYEAF0oHmEkDVKrb5xA==
Received: from SN4PR0501CA0009.namprd05.prod.outlook.com
 (2603:10b6:803:40::22) by LV8PR12MB9183.namprd12.prod.outlook.com
 (2603:10b6:408:193::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 21:35:13 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:803:40:cafe::2c) by SN4PR0501CA0009.outlook.office365.com
 (2603:10b6:803:40::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 21:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:35:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:05 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 30 Oct 2024 14:35:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:03 -0700
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
Subject: [PATCH v6 06/13] iommufd: Add alloc_domain_nested op to iommufd_viommu_ops
Date: Wed, 30 Oct 2024 14:34:32 -0700
Message-ID: <475a4c7bcf8af86ed00259bc29bbfdbb42c66b7f.1730313237.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730313237.git.nicolinc@nvidia.com>
References: <cover.1730313237.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af5444b-bd4a-4f25-b790-08dcf92abd1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0nPwqRTcbnXpnWcuw2qzzF6uMSfCNPhlmpCCThFEc4KxWk5P7yYF3OeXT71C?=
 =?us-ascii?Q?Girp7bq8zNNskEG6A59ygOc31crnzVjvox9r6Nyto9yxn7xH9mnk26i72Bi/?=
 =?us-ascii?Q?xX0Vy+JzcJm2i5ecP/J60gPys+dmQGgrH3CuAABQGLYkyi3tOcg8NneXYraJ?=
 =?us-ascii?Q?d54wt+yer8X3buuWJSgvFQf6vJTGc3fdNmrFE9fPCzTayTObpubYivnoGu6R?=
 =?us-ascii?Q?z+11pK42YZ3X/JgU/lUv9I1oKQAEQfv2kkben4oHu8giJM4758wtqIq2xzT8?=
 =?us-ascii?Q?mfPlIcALVjPmVz8lgRJ7nzFn22Z7IM2jppmrcYntgfSaZ/YQOKsTJ3BQolZO?=
 =?us-ascii?Q?t0F4qXbIqrcnPlR9lw0K3FRuEhHcLMyoXjFUdfQvr5xv3eqqKXDCfWMapQOv?=
 =?us-ascii?Q?fsqoIDnRBy8CV0J4woFUlS0zDbbAXyL8uphjZFhZIVUG5Yhqp1V0PzZBqKJu?=
 =?us-ascii?Q?iaAWJIA6q7PYymB+NyKldwoczHJuoo9qqoDN0SZbn0m2Cpg/8Xl48Of9mtU0?=
 =?us-ascii?Q?5wHyrLCmeYyqbYu9zerVmDajhHOGExH9griA8BnTKJIjSyT25lzQmuQkLBJ8?=
 =?us-ascii?Q?oopBK6rnSZykOhD/f1+34eYLq3ZAYysixoKqa4uyiX+Pd2Xcs/swsDdhr7Ie?=
 =?us-ascii?Q?o4hf77XW8KQ6T6MvgrbJDg2N5MG+eGVbXlY21l2G4UKeT37LHUAVCZse+OeP?=
 =?us-ascii?Q?sTvyZ6BgvNlNLPKzJkxg2H/8OASRRPh8M/R0WhtUBF9RvNQhq6IGbtwni4WM?=
 =?us-ascii?Q?vjfUsxa+bBgiaP2LzsxOhRikzrbcHyHIFfoQS7YY0w2jN8M0cSZrSC9HMbWd?=
 =?us-ascii?Q?c14yqPkMN0+fmRvfzuozAVuuIVmC4IOPtIJuErfLB3jcBj/U0KJYG49KIQbk?=
 =?us-ascii?Q?/7ok/JR8jJKdbUd5FlRmod6CBxqhXxItq2gKGliN/Xxemxc/XggDr+Llpqnb?=
 =?us-ascii?Q?9JMI82/X8cXtb9Az4rsUh2M5DXkO3lrDoVw+5Z6Z8fAmtugEFT8ck40P/ZeR?=
 =?us-ascii?Q?o6csX9ZE5Ehwibwcs5o4Hv0EfKw7DAM6+3R/T0qmUsPCPkqnB+HCfM/yHG38?=
 =?us-ascii?Q?2Xtioknhz3Zj5PK/Us0Qaa3qP6QySO71SwCgKOcPQLFrbHxfd8jb8+7MCP9z?=
 =?us-ascii?Q?lT7YxZ1un80V428w6vt0uc/i86O69jf1LpueyKHjOutQHsk/yr0+8q1D2gn+?=
 =?us-ascii?Q?oYpiPdHx4XN5NF2QFxsmmjk9pzWUGSFBRTbMEegHgq394hNpgFJ0g4h9GZkF?=
 =?us-ascii?Q?VmvuxuvJC3HiUJMlzs55YufjezlrHiXaf7Hvaksxywjw3nocUxpaHBBx/o1p?=
 =?us-ascii?Q?0TqAappahlXyfiHFQOPUVIOMElT3tDctMKt3Rt2qWEpJVsT3ltZ1jP+xTvUa?=
 =?us-ascii?Q?a69Ze5FEF3QrWYB1EStqC5goQLQXFxqWFJ5yaKHS+p+Lr9Imbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:35:13.5080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af5444b-bd4a-4f25-b790-08dcf92abd1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183

Allow IOMMU driver to use a vIOMMU object that holds a nesting parent
hwpt/domain to allocate a nested domain.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 457e763e8b63..f03c75410938 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -14,6 +14,7 @@
 struct device;
 struct file;
 struct iommu_group;
+struct iommu_user_data;
 struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
@@ -95,9 +96,17 @@ struct iommufd_viommu {
  * struct iommufd_viommu_ops - vIOMMU specific operations
  * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
  *           of the vIOMMU will be free-ed by iommufd core after calling this op
+ * @alloc_domain_nested: Allocate a IOMMU_DOMAIN_NESTED on a vIOMMU that holds a
+ *                       nesting parent domain (IOMMU_DOMAIN_PAGING). @user_data
+ *                       must be defined in include/uapi/linux/iommufd.h.
+ *                       It must fully initialize the new iommu_domain before
+ *                       returning. Upon failure, ERR_PTR must be returned.
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
+	struct iommu_domain *(*alloc_domain_nested)(
+		struct iommufd_viommu *viommu, u32 flags,
+		const struct iommu_user_data *user_data);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
-- 
2.43.0


