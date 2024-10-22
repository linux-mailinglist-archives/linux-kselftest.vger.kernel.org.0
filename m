Return-Path: <linux-kselftest+bounces-20350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B287D9A94C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E951C231D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C59154BF5;
	Tue, 22 Oct 2024 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FDEcprWg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9214B092;
	Tue, 22 Oct 2024 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556455; cv=fail; b=NDkHvO54l55xxhhPUBITIN+bNdqeAaOUC7YywYp1IqvErI9EIpdrwLfL7iEQ1XO3VKsmcf7X8MQD67fRnddXeqChFfgf9NviCEf1QTkQGOqjtV4e25dY+a8D17aeSgEWF0E2oNUPZk5wVD1Xf0kZYMzSJNgOHFa0HdJjkKV2bIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556455; c=relaxed/simple;
	bh=5Bm/IcgDc4ztDWZIoEgo0e5UQgYmwUrSy6olnCq/Uho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyoRe5II3VKOfGR2LFMKIbQs07RN4Hfoffw6le9r7lvCSPFqEcUn9pPhD8a0NkvJ5u2Lu2Npma4ck6EL1OFqoyeOBZQQkm+ESFia+dk3TByioeMlTmEFmAc5C2fkbig1Fy1hQcrRJjy2VMnsbDyNg5QTjr5s+hgS7oUdWcVfBX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FDEcprWg; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zyu/pfh25Y4umLO4+JDt80zUeuzwqEH/GX2cNdrlo3tp0zDeWgWtyXcDpkug8uIkI7ypfb8ubsWouNgm66qZLTjX7DbFnQbIYObXmfN+5nGjl1NwG5ld+6Eh05lRmCPnSrcpIZR/Vx66n5edMSUo/ciVcT4i/qB/KnIAVdtsZ1Qe8Lp9Ck/Wr5fHrrvKvIOrYuxUlspB3UND28IA2I1M1HWVvyV2whVsdyz5FpygKpX/hBRe+dLeewsYL/sE/GYaA6CFv8fPlreT3kgyGKxnA5BOoL38erQHY6pl6VtdCGKaXM2zYVDGGwwsbb7/bHpkNlR3WkyCRUvxj9CIU/KytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwJx/BRKIugP0909wpkxhc1D5mIIylULj6NO49deMv8=;
 b=yzsQcABHFzNjfjpNSSSf4Qs6h6DVVstrucUa4stU5RG2RW8n4gAbNpQM20OEzNNU4x9Y4H/PXRoX3qQdg8/NbCztc8ssD3cR1N03Wljmpx1hJ6MT+Z8aODjrpMoTEJXuO5+Zk/DVKJ9Oy7yfJl8CVIjVQrF0bwmFf6vsG6xP9z3hcUzLQXd/cNx9YStr2h5Laby+Ojqk2H5z827Ydz2ii6Ko0uJT27zhyQ4hIx9U9QfAd+2i0qZt1kkemAxvwmwHgMJwJP+vcw/aokP0jkuu8NWba7A66ir8nLTRtM6TaIAc2VZeufeUBlGPT/w/DsHk0yN9zLshsDJqkJa4kJhAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwJx/BRKIugP0909wpkxhc1D5mIIylULj6NO49deMv8=;
 b=FDEcprWgMgJJ8lxL+Tg3Z5ZkfR6lAucEXJT0VWr9Zu/2gphsit5jHobpr9Y8IDmr4N9oLlYs/K8weVXJxNtUonV+1xe+WWFrC18XDTj2ZbDigdkwnkr+NMVTRq1Q4+A8iVmjXyjNahgGCDslneDDSHiIty1ZfTC1UKejc5Od4+F4wX3LUnZGdZkB1vbJ/35QkhZ39TvO7r+raBV3suiInRnUcwzTdkWc869MG+hrGGEYnzYC/EhPxJBhcxVmoscPrm8I26t6a7gpisAc2tt3/GLSf8qKitQQaEtbv+ajAQVz0fTYFbR96T4HnnyKq5CpvZerkq3hmu7QIfroW4miPw==
Received: from BL1P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::9)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 00:20:50 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::9c) by BL1P222CA0004.outlook.office365.com
 (2603:10b6:208:2c7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:33 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:32 -0700
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
Subject: [PATCH v4 04/14] iommu/viommu: Add cache_invalidate to iommufd_viommu_ops
Date: Mon, 21 Oct 2024 17:20:13 -0700
Message-ID: <a15812f3a4beb7ae4b9a04538298128bcc42e4f2.1729555967.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 12973697-3588-41c1-3f97-08dcf22f61c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cEAcHqlbAeFURTt0faU58GpjP2aK7FwQI7UuHmNDPVbD1Tgpk9Cai4v2L5av?=
 =?us-ascii?Q?T6AJeH/PSmkGezm012ET3A0dxEdileMNoLLJj9RWRxOLgCo0nnER+KY6bHtO?=
 =?us-ascii?Q?EbwCeCVOnXyFDfa+w6PrNNoziXWsnZs6m6zbWgHjv9BVMVQEnA9kbm76RlTg?=
 =?us-ascii?Q?xWYrf1BkPS8ppdz7HupkfMjT+S4DqMQwLXx0SplxCek8qRlXCgdAdinvz3xF?=
 =?us-ascii?Q?sqhH6MEqS4l+ba/lYFQF3hJ+8ui3lwhUqv1h9pvfowqcEaZ5T3SRft3Z7I+B?=
 =?us-ascii?Q?SgB4FCzTbUN3aPTdOmKWnz/rz2yJzmU/Mo217FbIfQ1aeVlaCLAB23kW079X?=
 =?us-ascii?Q?SW9ZgLcIFygBfLZ9Yyl1nxQ8GDLRE+UybZyd1o1Pv2BvBYuIKhAnLee0u1At?=
 =?us-ascii?Q?Qny9WtiqxediELTRVFPJQWyAAKY062Kchcie8X/DLr6pDvGZp0WXXiVIQXHr?=
 =?us-ascii?Q?vQWPXx1yyunBICuaAOEck8H1PwofcDU//KFLYLVdsXryb6nWQgxwonxGxL3v?=
 =?us-ascii?Q?AhNagWlfCB86YJgSALRwMKpznou3uK831uGAhPY/22Zj7jF6gcyrphiUtkbc?=
 =?us-ascii?Q?ujIr+XBe4bNGM/u4MKuwGrRhmgHTlN2mVLmfdzyBTUyMq2MOFvgFyZoTbxDr?=
 =?us-ascii?Q?8CB9mCAg5R94pl98D0n1MBhe7LAfQPXPMX9m5uinm6tPm4vcBUmQYYsLSz2/?=
 =?us-ascii?Q?enO6KKwxcZ1Pnsnyoct/IzESvgOXHeIqGFLkkdsAEfCazaBbl966SGNIbFmo?=
 =?us-ascii?Q?w1+3HWA27S0GUYuuIlPKymcqRGxbeav8d7yUTA+jZ4j1PfPYzMXVEkf9W3Wp?=
 =?us-ascii?Q?39yIZ8zphAkc5ptrNZ1+gU7mWNVUTKsExbDuEMQaskU2AuAV/CEWPl1q0TeT?=
 =?us-ascii?Q?QF/JIpmamODaO+EiD+YUG7GigEcNsRv9C5iMabKNMziKByL3t6683A8bPlye?=
 =?us-ascii?Q?Fum17Ltnb2mS7ue+ra+N4Zg0M3fR15dQzMRf0iCP28w34EUX7sjJs/9r/nb5?=
 =?us-ascii?Q?tH/PlxX6Q9yYB+vkbPhl4G2E6OQlcp+0anmxnrFTT/glBJeB4MKDo7s2NQdc?=
 =?us-ascii?Q?0sFdohWzWfi/TbIcKcmPpM++UzOXBYABRnofJorEE76fopCgG29YWHGL5HvY?=
 =?us-ascii?Q?dCbowtvXTfrg3SH/c0iOntTR2SYkiieB2NOPEJdRfayYChzMUouT48SAVhEw?=
 =?us-ascii?Q?vpKCzOz6EQWTnO9915mKrd/HX+U7M/qrfepu+CBp8r1EdWqyiLFBjzfTzZce?=
 =?us-ascii?Q?Uom8+Zcz5Ig9/djJ51XZHXr9VeLG8tsmITOt896VkQuAOYQJ1pRq4tuY1ASV?=
 =?us-ascii?Q?ZHagdqoVgHGeXxefg1GT7o07ZPkIAYY7cIJIzSPBPMZBOSn2MkX8nzBU3mon?=
 =?us-ascii?Q?9WPg+57fm3ZqZSySckj/eoPB29M/iq/MJ1QPnhXc69EVeIDwIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:49.5503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12973697-3588-41c1-3f97-08dcf22f61c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836

This per-vIOMMU cache_invalidate op is like the cache_invalidate_user op
in struct iommu_domain_ops, but wider, supporting device cache (e.g. PCI
ATC invaldiations).

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 821816e3b1fd..559f274a26ea 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -15,6 +15,7 @@ struct device;
 struct file;
 struct iommu_group;
 struct iommu_user_data;
+struct iommu_user_data_array;
 struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
@@ -121,6 +122,13 @@ struct iommufd_vdevice {
  * @vdevice_free: Free a driver-managed iommufd_vdevice to de-init its structure
  *                or HW procedure. The memory of the vdevice will be free-ed by
  *                iommufd core.
+ * @cache_invalidate: Flush hardware cache used by a vIOMMU. It can be used for
+ *                    any IOMMU hardware specific cache: TLB and device cache.
+ *                    The @array passes in the cache invalidation requests, in
+ *                    form of a driver data structure. A driver must update the
+ *                    array->entry_num to report the number of handled requests.
+ *                    The data structure of the array entry must be defined in
+ *                    include/uapi/linux/iommufd.h
  */
 struct iommufd_viommu_ops {
 	void (*free)(struct iommufd_viommu *viommu);
@@ -130,6 +138,8 @@ struct iommufd_viommu_ops {
 	struct iommufd_vdevice *(*vdevice_alloc)(struct iommufd_viommu *viommu,
 						 struct device *dev, u64 id);
 	void (*vdevice_free)(struct iommufd_vdevice *vdev);
+	int (*cache_invalidate)(struct iommufd_viommu *viommu,
+				struct iommu_user_data_array *array);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
-- 
2.43.0


