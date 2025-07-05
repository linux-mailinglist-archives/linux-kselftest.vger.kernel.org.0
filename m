Return-Path: <linux-kselftest+bounces-36616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DA1AF9D30
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54AE1CA037B
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8068E1D5165;
	Sat,  5 Jul 2025 01:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UsP99rUj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE9C1459FA;
	Sat,  5 Jul 2025 01:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678061; cv=fail; b=kcKHk++CfaobZRu2Lg2CsJr2IMdFdJBWLSXgeLMlSoiCkeiVh4Z9kR6JJMBMkpgg3wzl7Zj5LoTCDvW+/SZHCLwLt5nT4anw7vpoAg1TuzmWL9lFrmFTJe7FRjOJ/6nelatuIeCtfYa9ak5msa6RoaZYYEtYnucn6teaOtQS0Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678061; c=relaxed/simple;
	bh=Gs6L85xPXFwBPVIRqczrWicbRBlk0UdwTSjY1zd6nBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlWiNlLOIpsyxtqcO8lTOUyaRtQ0iBUkKHi5HVhFJOr8QDl1fUQBHtNcLN52+YWjms7qmVOkakbUj29YcqAdCF8b8xbTnv4nr38ZBf8S4sl85ThQ0CMVYGcwo6loz6rTSaH0n7rxrxvo/7zxEpSogoikCBIMQu0O0VVP3AZ+53w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UsP99rUj; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pp5wcFO2DXrdq/O2TniGZREcEgA7VQ0Aa5FdHWNogiIsV99poby8z7cPN8D5yJCxkB8UAj5RagPOWybzgLe7IqocFfGZ4qb0QuuTWuGT7V7FUI8zacj8OsVeeageBslpac7lbWTek1jnixJoW9hu50ziUldO93LvqjGJGfGic4nm8L+roR0gQ2lNBfXX4bHN7IWRC6FzbEJD8uHP9R1Oqm+utO57PdIVmdqanfiuCuCeyW2VGIw4jbIWpHNDfXaFNy4DGTa+BPYIeonZga5Ztc18BZfTq+wFdlWf6hby/HoHUh4c7RLzS3qv7E1MJxmEbZQsOGsFO18eN5YPkGszcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHXMNVTokTe5Im/JWCAf1EDv2Um9HBH7NAM+Oa7IpoA=;
 b=BpQHM+uGzL7hnbBFjtB0Tog83huFaYE16bYAn71LPXVGBSSmBNe7/ED90hzABW8Rm3tcbQpsc8uYRZh0Y0jwAm2yEIEoXP4oHB9lqB5SLLIJSYVWAdJWcqGQuJ+sbEvRJqAkfIktsWNMc5R+uKsTYvoKARaMbN7WEHQlA8aEIojY/jdCZciVgaCzZOmvQbfSHwZYV5ORcuFJBbYbWHY8X34oWhlOvjFznNJOzfkME72hzJLX9Qhmi33OZSDwOaby2bkpBp+ng8n6Ic5cohvQj1ZZDpckVO6EqRDUlj64GvpikHoO9Bt4y63zstp44HBRlOBXN+5PbHfeVqJ9c+3UWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHXMNVTokTe5Im/JWCAf1EDv2Um9HBH7NAM+Oa7IpoA=;
 b=UsP99rUjkBuHH634NjkkphDFvh1AJKVRltFG60Sl+IXWFKYtnc4B5MnTym4Cdi5wBu7NK0xjYWH5Krg22o14uhRjNz6+B0PQPFMYKsqooV0xFahuhkfcwXKe9d6iOR/mgmjNt8w6fjCBtBh94fGXJs7M0JCXnqU0zkZNeqx1uLCF7iAODlEnMjRY9z3SpAAg2lzZNcHXcCc5Hma1pdfjEyjR4yy3raq/6iGpMquQRlWIFOEJwXl5DrMo+8g1cZcJnwjdHoqqFHxDnjNlKle3ZB3SZ59t0AVHEyKHMfoS9tTsRaZ1m6GwTxd3y5qnTEM25ybEen1N2bTi5ln3/Cx9BQ==
Received: from SJ0PR05CA0127.namprd05.prod.outlook.com (2603:10b6:a03:33d::12)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Sat, 5 Jul
 2025 01:14:15 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::41) by SJ0PR05CA0127.outlook.office365.com
 (2603:10b6:a03:33d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.12 via Frontend Transport; Sat,
 5 Jul 2025 01:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:03 -0700
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
Subject: [PATCH v8 06/29] iommu: Pass in a driver-level user data structure to viommu_init op
Date: Fri, 4 Jul 2025 18:13:22 -0700
Message-ID: <e34fe51299545789f7e97f193969a2688e708eef.1751677708.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751677708.git.nicolinc@nvidia.com>
References: <cover.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: a59bfd91-5e2b-41ea-e793-08ddbb614188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GLveNr2RiJ9uVT3sidfezsMF7Uj2Hh0DkBrW2P1K5fioAZTUO8gJDxyLF08k?=
 =?us-ascii?Q?o4V7t9tCJDUE9ZlrdVWAdbZ4s9wUi4z1xgrsiGJPkwbWbecUKZ5zEk+rXcq9?=
 =?us-ascii?Q?lNsklrRWiL31t3PdoNWm20V6ZHwjsOXCe3urJy6RaVKcQEL/i0ViZ6HPCKk2?=
 =?us-ascii?Q?cY5nVIzrDfxFa6JMXtxJdq5fMCkO2ubZryABfPk/M7hBxOgIqW1hNRPJwNC4?=
 =?us-ascii?Q?wFjD/VxtB46AjNBwvC77UfL5lxakUVXfbR9YN0hxapLOe/PcJPDyCxbumHGd?=
 =?us-ascii?Q?ZiCh9zm0JBQu7/ZxK+ccOmyQ42IdLvDvf3a64PkOI8+QUBnA7xelT6XVL9+/?=
 =?us-ascii?Q?3/8GVBiqno5rIJCDH9t6syxR7QvN7UtioMNGwzvpQpy6MNl4IuRoj/CRpu/8?=
 =?us-ascii?Q?6hWJ0nVC0GmMvCXppWsMLRLvy7NuHbkC3PHm9EWcPktGvh4HiaedfoaGbAnk?=
 =?us-ascii?Q?4pSofqGPFzgE8jw8dtKDjuRwEVn7myKTTPQsPKRtPtiok1B7lwrkSuHvcqQk?=
 =?us-ascii?Q?DpdEeoN7ri50ySfmpFDv8SSFLAOFKPwX/xKpGIuP35U0hlBNj1lRyvLyszqE?=
 =?us-ascii?Q?iCIjs+c90Qsu2qyk/RcMctNO5DemXKgYrBX1QiiejltltZD+sYR4XSLPiy6/?=
 =?us-ascii?Q?GjNu/nBU/FRQzWEDvOuLszE/B9jdSCaobyJSSp8TX6zcATa2rvBWOmOjd+3r?=
 =?us-ascii?Q?ufvQJ+2cbwSwM78A+cXwAll4VRsG+6rPEhZSnXsRTQhYv6NYCGzTYY2XyPCu?=
 =?us-ascii?Q?lyif2+yrKZ/XOtArsTU7kJsr0hiTkWWgMMp3aemPe+vu+1nhWgpiaEXOVDQo?=
 =?us-ascii?Q?3AD2obkzVz/fbVjT6flC8iOOAIusqYLGBy+cIY43XvsW+YVupjpfstfs9grF?=
 =?us-ascii?Q?GSEiaVZ6+WUhQbcKfGFdytY0IbXbpVtVlNlS1Uz2/6kZqJMZHK52NG/ccJFI?=
 =?us-ascii?Q?AzLBcNy9TjbbIh9g4lT/oK0o6KvqA9x8j9UC9c+ZxxW1+QcDdrYdEXc+opf9?=
 =?us-ascii?Q?jyb9d3xcuZ32If2+WChj8D/T9HEIAnyuMCsf5ifnKsOKyw+4ZZP4KXL0PdAw?=
 =?us-ascii?Q?yTjjALDcMKqbnSPG9PVZyh2wcbzBAkMhGSzRMNOaTY2kYECeD59oxu2/1PGf?=
 =?us-ascii?Q?xlerDrNUzMy5iwqdeCixNroOXDoupDWYKPvAl3qZKz6WhohtUXmyDmQoBmdG?=
 =?us-ascii?Q?NOBJtzFo+RySTCIvN1gAgAUAx/H6JLqej1WOlDU1MSnD3KOGnvgeiqaS9hPr?=
 =?us-ascii?Q?r8IYHFzzaeE2cZX0OjUo8K5dTCt/i3I0XijgiomrYFE/BIJLzAgHSa6c7d4c?=
 =?us-ascii?Q?0orS2mcgoa3hUB8/9oV+kjuFSRDw7VSoZKvLk3cwAAQ6/IDnzsbvApE/4Rin?=
 =?us-ascii?Q?Lvlcsdq+u463Vtg9tr89OxR93kZoXgin0IezL9bFnBf4FlHqAgm345morZey?=
 =?us-ascii?Q?9nSSBMBR0B8SKjAuRn6/1kFk0iqWGvi+cfHDUAqNrbSZY1KPQj54CiqGhJPU?=
 =?us-ascii?Q?vDN6I6HnlDDITvXQS3bvx28irzT1cEyuJ2Bt?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:14.1232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59bfd91-5e2b-41ea-e793-08ddbb614188
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765

The new type of vIOMMU for tegra241-cmdqv allows user space VM to use one
of its virtual command queue HW resources exclusively. This requires user
space to mmap the corresponding MMIO page from kernel space for direct HW
control.

To forward the mmap info (offset and length), iommufd should add a driver
specific data structure to the IOMMUFD_CMD_VIOMMU_ALLOC ioctl, for driver
to output the info during the vIOMMU initialization back to user space.

Similar to the existing ioctls and their IOMMU handlers, add a user_data
to viommu_init op to bridge between iommufd and drivers.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 3 ++-
 include/linux/iommu.h                               | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ++-
 drivers/iommu/iommufd/selftest.c                    | 3 ++-
 drivers/iommu/iommufd/viommu.c                      | 2 +-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bb39af84e6b0..7eed5c8c72dd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1037,7 +1037,8 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type);
 size_t arm_smmu_get_viommu_size(struct device *dev,
 				enum iommu_viommu_type viommu_type);
 int arm_vsmmu_init(struct iommufd_viommu *viommu,
-		   struct iommu_domain *parent_domain);
+		   struct iommu_domain *parent_domain,
+		   const struct iommu_user_data *user_data);
 int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct arm_smmu_nested_domain *nested_domain);
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fd7319706684..e06a0fbe4bc7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -700,7 +700,8 @@ struct iommu_ops {
 	size_t (*get_viommu_size)(struct device *dev,
 				  enum iommu_viommu_type viommu_type);
 	int (*viommu_init)(struct iommufd_viommu *viommu,
-			   struct iommu_domain *parent_domain);
+			   struct iommu_domain *parent_domain,
+			   const struct iommu_user_data *user_data);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 69bbe39e28de..170d69162848 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -419,7 +419,8 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
 }
 
 int arm_vsmmu_init(struct iommufd_viommu *viommu,
-		   struct iommu_domain *parent_domain)
+		   struct iommu_domain *parent_domain,
+		   const struct iommu_user_data *user_data)
 {
 	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
 	struct arm_smmu_device *smmu =
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 7a9abe3f47d5..0d896a89ace7 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -779,7 +779,8 @@ static size_t mock_get_viommu_size(struct device *dev,
 }
 
 static int mock_viommu_init(struct iommufd_viommu *viommu,
-			    struct iommu_domain *parent_domain)
+			    struct iommu_domain *parent_domain,
+			    const struct iommu_user_data *user_data)
 {
 	struct mock_iommu_device *mock_iommu = container_of(
 		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index bc8796e6684e..2009a421efae 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -84,7 +84,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	 */
 	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
 
-	rc = ops->viommu_init(viommu, hwpt_paging->common.domain);
+	rc = ops->viommu_init(viommu, hwpt_paging->common.domain, NULL);
 	if (rc)
 		goto out_put_hwpt;
 
-- 
2.43.0


