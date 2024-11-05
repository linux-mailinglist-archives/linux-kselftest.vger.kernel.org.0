Return-Path: <linux-kselftest+bounces-21487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66FC9BD6AB
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620D61F20FFD
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269ED217325;
	Tue,  5 Nov 2024 20:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tU8+Cq9I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602F02161E3;
	Tue,  5 Nov 2024 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837161; cv=fail; b=ppC082iFPp1H5oMPuqXwcAv/QjZGG3/EdbNyrlgRrsWB3IlOSFpPGrbMIZRzLgHMrdgRt0TtuSU+7obvfUud3a/UMkgjZm7AZJ2Iz77d0OKX7SsK5yxl80SOajiBXkCaGgdcS63TozTGHfqFBI4WvuIqaVXKt22LIueUFVjwHXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837161; c=relaxed/simple;
	bh=WU1FfckvKXu/I9QPixaA/fpPYv6FeIstAYkYT4ZMRaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJEj1TZ/yO35MD8Hu2xmXUzt9Y3yYAn5SmA/2egg0nuWz96PcIwLqtgBpedqGM5oUl7Co1ReW4+f53BXhJ4OrDMjnpteaq3zOsq1VXL0+rqllbziUfzFoXt82wYpZ/xjUXBucguCBMtiD8HT5R0ugWC8AJMDhhrJA3JH+gR4xkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tU8+Cq9I; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWHlMKvKVgv6zvCleZoJLbrLflSt8cNC32Vqd/MpF2b4eDbpOSeUG6vmk8LPkKI2aWwbqQM2g7yKXz4LQukDAJ/XXmJsIqM+qH1xnZv928uXdAByfg39S+xozoNypbinb+qnbX1uMIo9WwgTq2TnenkETslskBcDv1XSMkbkWGpkq7ei/gNmzWyJMIn5wtkCU+zUi+TrdzAP+Y5HdJZcvkAYx2yRnbYtFumVrwd6pblWHQ/6XgQxwrfOzyGhv7j1Nh/1D+AkAaoR76TAwJUodX6btCp5V3JcqsalUqc8yZQjFLfv2fbOsZHRhxGYdo0Q1QcpthRRG+R4MpVHU63Jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK5n2qGnOlWnO8OwDrE5jKwuT/lkRBEz55vtIE7KElg=;
 b=Y6wrRFCgJvQvGXj2LwCgBilMHnsapSvlaCtI5sP0FPAsofJop8UAR6u8r+08Doj9pFpBYvjUcrmwLywD7IRj9jOTwoTLCt/eim8VZQj7nvqYxGLxNl8vzm3FZrHC200aVTXPd/i0qV/AZZ8HogjQ8JaUEr/UhmG+FSzSD/kHsae3j72ojlvFeRfxjVEYyxlQ5fiBcNrmiLJxbqgq0Av2Z6pQEX8NNl2qhJOlWueo5yGTP+1WlWirve8cugL7nx4eLRwDj/sbkwU2aLUhv6mqdrEYJjQfwEHewSbGD61J8yrI3lliiVRlOJzSuyoGs4SEtZLAeBNT7nFg8SsNszgQ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK5n2qGnOlWnO8OwDrE5jKwuT/lkRBEz55vtIE7KElg=;
 b=tU8+Cq9IcwdOlRvuwmiw9kGUivhoa7MkedJptOT1Alim0lhLr2yGfaQRw55WsdE4amG6WPf7xycZXZt6laIl9Z98gZVU4uv4GyByEZUwaGAa2f1qSlYJkpdWPrjYg0suJBP0jcbgylKDzKRKv+rlp3CMAdGcDb0sta2cf+9tXwCY4meCOq82Oa1sKBykwNSkArWA92d0in2VZ2OgHcYyefiNiyodzdwu1Wue1w0S8Jd81upFTCT83XhJBBzz+GLLfqts84nvq6HCh+oo6BftsQfg0g6ZkBMr1+wORq8lM2L/Xla8/oN2HAFxY69itz6xsTITYhKQLP5UwmkdXOPlMg==
Received: from BN9PR03CA0599.namprd03.prod.outlook.com (2603:10b6:408:10d::34)
 by MW4PR12MB6897.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:05:52 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::59) by BN9PR03CA0599.outlook.office365.com
 (2603:10b6:408:10d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.32 via Frontend
 Transport; Tue, 5 Nov 2024 20:05:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:51 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:32 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:31 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:05:30 -0800
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
Subject: [PATCH v7 03/10] iommu/viommu: Add cache_invalidate to iommufd_viommu_ops
Date: Tue, 5 Nov 2024 12:05:11 -0800
Message-ID: <90138505850fa6b165135e78a87b4cc7022869a4.1730836308.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730836308.git.nicolinc@nvidia.com>
References: <cover.1730836308.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|MW4PR12MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: e7af19e7-953b-4b33-f67f-08dcfdd53fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mY7TJxSCdlWOPytaxh/TKTJl6Uo+4oCChmKhBLh8SGhztNZnwCJvbDVe2Z4l?=
 =?us-ascii?Q?g6DQbARLBUrWXXzmalMkJu2xJLAHBeLEB5y83B8O/cGGl5sgI2FrOdRxb0qP?=
 =?us-ascii?Q?vDtizGRf7uLNP+rUAMgl9TqY5Vrf+DYFs4I/5Zx+q2O4RcEA7FW4wAGRvlOA?=
 =?us-ascii?Q?DVJ1wAlpss3sT55vgJeHM3plEasoAJDz8/yODO0DSsFVMjOhvfYNlQtaVaa7?=
 =?us-ascii?Q?hI/XUf1ZfCf4uk/tYel/EufnsSOQaG5OXeTkgjhTRkFZP52J5vsd0HIyx/pd?=
 =?us-ascii?Q?3GUmc4f8aOgvEe3a9NmuLKHjQcB7ZM6EnQvE82lmjOV5QRcvA61Y3LRPJreH?=
 =?us-ascii?Q?uohZZ9LkDSxN1tFuNGD+OHS13s5yJFd9LsNF4XdGa89Q92QWlMrz3hQJsrUO?=
 =?us-ascii?Q?GKol23aXUVnEBt5nN95baD24555L1WUc8TmbpKYYlWxxIH193H+xaHNZT/Vn?=
 =?us-ascii?Q?kBvIeRNTSEHA0QrcDLnrjR1Y+b58ntJnaJKcHDUsi4wnttDsyWW7PhzkEs5L?=
 =?us-ascii?Q?8p2ebRw/Nw2vWD7jpCSV+ci03s9POoeqZBbrdY97pnh4hwluOz33uuqE9AYR?=
 =?us-ascii?Q?Vta3/LwxC5nsZiXKZC0pvv8yFdbSLcjs8wpOaaHF2JDIwT0PWynWO15LLoHe?=
 =?us-ascii?Q?bPuHFsx4YQHebyyzocgxOrhFD9A/QwyO7SNcksL/qdEC5K2vJc8swZYKG5UY?=
 =?us-ascii?Q?iCCzikDWXriBE3CWphQDuW4GFAu/8ypLK0PIBQh+/dTjYjjf2yD7b+rWQyCG?=
 =?us-ascii?Q?i0PLzvNFDi2oMwWX8IulEG0F6Z7Kgg5IrNcID9icTSr9JCNKCwqQD0N04i76?=
 =?us-ascii?Q?+5IjbCIW6R5EhPuX8ioTpdNwzUFKBML08IlwgM0/3wEgbNYo/GQI5OKUswSk?=
 =?us-ascii?Q?2tZsTUUCo+0zwDKtFp0pQhdPWbDF25OoEWEOTRHF3dsXlIXeWXHZcnbeKc4b?=
 =?us-ascii?Q?fEM/p/erImHkddcjllinozLQIB6oo64znr3gr5RCpwsdygZOR+JGVwInKH1b?=
 =?us-ascii?Q?hBko1Efk7iwnwie4J7i+V/u2UGNHO07hau4gbDqBR7NgtmW6EQmQxn3Dx9iB?=
 =?us-ascii?Q?9m5hP4xlKNMT3vbwy83op8GF3fkxJ3J3ATH2l1mR9R+E87FJMZ7+2SOLjahj?=
 =?us-ascii?Q?jkcdryD4BFlKMmWqDn6AUnwKirZ9Ao5NdPrFd5VG0ioAnpCEGQ9j/b9rioBb?=
 =?us-ascii?Q?4dOiI+dahj/luBqbcB2HcyMgYP1OHdKJFfviJ34VQOGl20eMzhb6KPEdostP?=
 =?us-ascii?Q?vpy/G7xpKlxBK/H9EBX7BABdkEgvw7dT5INuOBeqyuX6GE5OzJ9uQF3VHecV?=
 =?us-ascii?Q?n1sCxWI+V5C3twvENQFEmG4efdmPrXw1aGTExbY7PfesFIE1L2s4d4+IEXCE?=
 =?us-ascii?Q?ISHzLuBBmfSDj2ghL7c7HeFxHUJOQUQK1Pi4YrE64gRsWBC8qQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:51.6674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7af19e7-953b-4b33-f67f-08dcfdd53fbf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6897

This per-vIOMMU cache_invalidate op is like the cache_invalidate_user op
in struct iommu_domain_ops, but wider, supporting device cache (e.g. PCI
ATC invaldiations).

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 71fa1e343023..2bc735ff9511 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -16,6 +16,7 @@ struct device;
 struct file;
 struct iommu_group;
 struct iommu_user_data;
+struct iommu_user_data_array;
 struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
@@ -105,12 +106,21 @@ struct iommufd_viommu {
  *                       must be defined in include/uapi/linux/iommufd.h.
  *                       It must fully initialize the new iommu_domain before
  *                       returning. Upon failure, ERR_PTR must be returned.
+ * @cache_invalidate: Flush hardware cache used by a vIOMMU. It can be used for
+ *                    any IOMMU hardware specific cache: TLB and device cache.
+ *                    The @array passes in the cache invalidation requests, in
+ *                    form of a driver data structure. A driver must update the
+ *                    array->entry_num to report the number of handled requests.
+ *                    The data structure of the array entry must be defined in
+ *                    include/uapi/linux/iommufd.h
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
 	struct iommu_domain *(*alloc_domain_nested)(
 		struct iommufd_viommu *viommu, u32 flags,
 		const struct iommu_user_data *user_data);
+	int (*cache_invalidate)(struct iommufd_viommu *viommu,
+				struct iommu_user_data_array *array);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
-- 
2.43.0


