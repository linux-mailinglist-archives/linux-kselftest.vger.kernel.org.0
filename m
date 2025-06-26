Return-Path: <linux-kselftest+bounces-35891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E832AEA698
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414641C286BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3BA2F0E5F;
	Thu, 26 Jun 2025 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bt6y8EdX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B02F0E33;
	Thu, 26 Jun 2025 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966533; cv=fail; b=dIYhCE5eoAySzsgZ0N5XB01lZveD4F1y0RGFP8BINNvvliKlkHCXAHtu3+bYvL/pwhZGiSRVcrE/uASI/NRl8XPBGmKw8u12X+++QSWw998myuTB9ybjSUiImRLXQsLTXIGxOt59mOLintmbIlqsom7GB/fnBY4Y0Wf26qZP4i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966533; c=relaxed/simple;
	bh=Gs6L85xPXFwBPVIRqczrWicbRBlk0UdwTSjY1zd6nBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruyoxxMRvlp5r1qRKvU4JEKWKlCRQfy87I73benTPyvs9a9ULQdUXjkUkqz8mblmv/f7BYcKnHRcwhvNTwymm1hIN1G2yAY/rp6ISICh2qcnGfIz57ZfIsmCOKH4tbIIXBJUcIu/79nnJpWZ4L6KT7d1Yv/QilJuyZPsXZPK9ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bt6y8EdX; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqHObLhUSK/0A6mWJDxlRjKw9eiiSFtnkabBwxppFkOVman5HW41skSuZRtYIkzcTEOsF+Qr5ogHZCkgzA6pD1iyhgmn4rcgeW+GR3AODlrN9Tnd34x6KCdlbeaw7trqe9Yeww/R1zwIFVP6UKNwGdI8Krp60TVfG97auCyq1rdbL5He4xPvGFPkJX3FS/nMKzBceRj5VC1z2nDz0lfrbqPTz0Wn/RjyUDW2IBKySVad6iqEjeLaOFbLPvt1ES0VEJjGbSd3Zapl0phfmYflwzHHlqxkyVpKQGYBg/jYtR/Bd68uPB97n9S5SghEFgfdUFEQE6YmkPtgxxw95KGFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHXMNVTokTe5Im/JWCAf1EDv2Um9HBH7NAM+Oa7IpoA=;
 b=eqHCew0BMftUwTTErnuHHhRtitv+hCH5C34rx5POkyPQPC3Tqo9w4V1UA1FAEe66d5PyxQn7IQ9GO9+tOGO5GXXJ3ACBCnpwvCp+2KcUL1Za3HBT04Lf1/Fc4aHrP90V1pdnYosKbqRi0gksNiXs75b+Qx4ksqXWgVSJ08lsfstSORNx/WwQuCP0+n9+PwNvSpOiCcSS3U7Snlb2do3n3MSMenykJ5IXIjfGZYx+7jh8+rvI8lDTGSEX5UPVdvDRMW60e8b7NYdoJkWMgDGXRfRafeamRX1ATYvyKH7aKBNOYwzP4zJ1gCU6tpdjY7ph7dQ+1WNKJibkSFERjxrr+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHXMNVTokTe5Im/JWCAf1EDv2Um9HBH7NAM+Oa7IpoA=;
 b=bt6y8EdX/nkVFm/w4XZHQ0Pezxbak5uFcu0NJ4K2g81GpBVDLV0wFOYX5IXKMOnd/W64wL8nrGPos/SArZtPTmf6Ufd6Ar2dTqAhZJQlGMUpYFVbYFFj0d7Cv5gkI3FG6BCGc1+/DGAo8bzlNVgS+wgcf5NLk6ns5t5t0RKCWMvT0xRRlGbno66zRQIXaCeRQ7qGXr6lFij4F5YoH+62xSrDIEzhS7GI8H5ndqmMvWJAc/U7w7h+TwD8gpb/9/CwA2cECjfqbHFPIVvDgkHmGx62EFn5v0GOQKxXAmBVzaIMDdr34WZFcjYFfocUdPJFzb8EFANsBq0AZrl6f8vekw==
Received: from BN0PR02CA0038.namprd02.prod.outlook.com (2603:10b6:408:e5::13)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 26 Jun
 2025 19:35:29 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::47) by BN0PR02CA0038.outlook.office365.com
 (2603:10b6:408:e5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 19:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:12 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:11 -0700
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
Subject: [PATCH v7 05/28] iommu: Pass in a driver-level user data structure to viommu_init op
Date: Thu, 26 Jun 2025 12:34:36 -0700
Message-ID: <7a9338b6107f03e780de1a8260235f75b3f67b98.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 61fbeee3-3272-448d-91f4-08ddb4e89b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?32ASQLWFWyCpb6vdFucEaixdTSp7fkFOUIL74vg+kvtt88vTUKPUCdl0lkWW?=
 =?us-ascii?Q?AJ99HSteHV+BF0g8flU+5UFCMH2quxrcOD2U7B9Dwh3Xoj6tm1fIcIhUIEKw?=
 =?us-ascii?Q?wS9Ph5p54MQAe9axptYsM1/kc8Ce2Tk7/3Yy7vehURq3OYGiKqoNQBChbCID?=
 =?us-ascii?Q?GI9XSCK1SH7bMZDBEWRpkg7AkxcRKZP6GHpTdqK1ndQtBaowdIHxJ4fBBtgu?=
 =?us-ascii?Q?boImh7vbkN3lRyx4iTonrOZwIRU4VjiBiDjY9OgdCI/NiSzVewxzsjEfrzhq?=
 =?us-ascii?Q?85OMQjq/HVN8Wne7pHKzLcASytz7qVyxWf0uKMfu5TE/sVWRr+9qINYHlt8Z?=
 =?us-ascii?Q?5xV8ZRjwTg7Huv/WBp58kuCMnOcnzsZuHalbzA7mKlZ1KId50BlN981jeAPl?=
 =?us-ascii?Q?b5tDeW5aeCbk1lWtKqyW8goAzDh2KVZM8JbQuzqHonYt8sqYrs+rkzhfPieu?=
 =?us-ascii?Q?RS7S+zoCmbcuJbOHqJIOzo7eZEapiJ/HH7Ekk5GX5Ol6fagnjX7Bpoeg6AE/?=
 =?us-ascii?Q?Lh9TDzl0L6InTR0VEjJGS8Vh4idhVL7ZHyFGSqVKlaMcAL7qeqBvJeX49SyR?=
 =?us-ascii?Q?CM6EzP91SDU+AxT+zbNDkno3BSdb91g3j5EdqjzV/OL22KTQK3E4Hyq2TB0N?=
 =?us-ascii?Q?2t1rMIWFkh9eZsInj29aOoW6jrMQCYMZONUrKBP98w+dWpj5106gYltpYrPf?=
 =?us-ascii?Q?SJ8F3gtrWJgmvVJmeZcxgpFHkqQTZcopkbp+zhIESOTlGloQ2toEXjL1LPro?=
 =?us-ascii?Q?iDLzhOAsOMpV7/0nq2vnum8WB17PSQi1mHgS48I16uVGRyq/Vrv4Y0g4u9z5?=
 =?us-ascii?Q?OD7dHfJOR/zico7NGDRM870is97Nr6xxAaGI6FgIh3gVbqoqTRjOU35p3P+A?=
 =?us-ascii?Q?4hYQcIXBZX0NbCPXNX2zcv/dazMexESBm+DCIn+AUh+V+zJjuUnCvpKCIOxk?=
 =?us-ascii?Q?uTxcO03wq8NE4/Zmd4VUobnEn+a0PIWxU56poHUpnm9Cy+Hu0451tW9iv3jf?=
 =?us-ascii?Q?Q+ZuzO4P8azdMAf/bKrAorzCLi4hkRFLufTfzAU1eH65ZXhZB0NEBBMQy5Wo?=
 =?us-ascii?Q?QmX+0cGBPmDVrC2ms3PkFJKJrj515zQ44oKWNbk4wk4SUxtUbSncJAFe09Na?=
 =?us-ascii?Q?M9KMP3s9HwIFDldRez8mHFUZYqLxQREiorzV3GSata0hg5VchabSJKHhwMvu?=
 =?us-ascii?Q?jZEaCcPkfN57UyqZtAnYmHJODRKFE9eN57c8gn8wk6AwyPNkk3zsFd15CsBa?=
 =?us-ascii?Q?NchYz/iChmeiid0gMTe872URN4/ZAJRipsWujUgAyn0qL//HZ4PKhLFNHJf+?=
 =?us-ascii?Q?L4uINcK0KGkvfN/82tUD8JZcNpldUjwUupPas3JzaXxWtsJb3p2fUKd4V7K/?=
 =?us-ascii?Q?t42J5N3RzU5/zU/Wd7Odw2hET+Hoc2fCRzOfg/gwHNp5atislFDAnO241TZg?=
 =?us-ascii?Q?meJ3ayHAAJdn8qQjde31/FSXwGhr60VOf/PPQWC3J11wkrURbXAveSOUuN22?=
 =?us-ascii?Q?rdOYzWFXabo5bBCAIjWsqyVThHNgnQ1v965n?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:28.7379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fbeee3-3272-448d-91f4-08ddb4e89b67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064

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


