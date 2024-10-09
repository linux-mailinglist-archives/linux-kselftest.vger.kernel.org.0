Return-Path: <linux-kselftest+bounces-19373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A74729971F9
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC981C23577
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C541E2613;
	Wed,  9 Oct 2024 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SdNEsAvB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317D1E22E4;
	Wed,  9 Oct 2024 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491954; cv=fail; b=NA6D2TdcudHFXDbnkrXsHxJN/RDr8Cmy65Wh2JGVq3BCTIt9Xugqt2EcagLFgU6BOUvJRcv3dyrbNmoP8pMoxMzCxUh7pnSDzAGgfSbB9WtTjuXrskwhhA74WBIpslu3tH20NZVWldf9t1Tdhz+JzSkaywxfJx3NWldsAhYBmxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491954; c=relaxed/simple;
	bh=+bKO9AsWiYbhLowknGGOe7Yk4xhUt/EVgSRUGwd8Qf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnA8s+ncl2gPCJkCMLP/jzAXXaUmAxYXyPEqdgaNAywcA2zd5Nt4STvxTMKXrvW4WzTjqQlhYXi8eYY1qlPB2giJ4Mi9tTQ/v2kg900F6vLp8JbWv+pB5iRnxauUXBbT96Q2AXdpKnGnvRP498Y9oRfx1Y0JDSCsCDo9TM+0dvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SdNEsAvB; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkiPdGbo6BA7Xxyw4VmuZUTaoKAs7UQZe6YxxTSMaIUu2RCfkQdzxifBVuIV2ko2Ap/HFM5vTBu7ypvNvzOxiTaKSHZu439f5aHCHA7QryynQpoAFdy40N92lIOdJVyV3OrkkFrdcxuoMp0w6uP/669rSyhIWkCmtogwFc7w3/kLZBSxgf9jXrfP/tpRF+v/9KPAUxJMoo1hqOrwB3UpVByZGiRcMXqb83JvkZMa034xKYXHLmMRNlqcmnDlSbMozrBvh2m2JF7wBnYzuW47mloq7CmD0d0ooTgnT0Q166MmiZBXxkGhad3+zFlYDnzf/Ujg9n98yDr++2qRqiUvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DelhEmlnyMPfXXgn2PlMEYi6TuNVLiyt/1iWyZikR8w=;
 b=dG6g1+ZFPVmp+cZP/WF79vnWsfXL3+W8RUYgiSEVqSIBoDum/rQ8MJ80JfIGrt30MdwwJUHOW8v+90rURItyBWDFKEWieAezLQZWIH1nJ04QI7wz687fWG/Ulf1IN1FyVX3j+Oyob7gsc5d+7V7dl+37H0Uwvjd3pEZwpiM/LzR3Sehl4AX5LoeMIxMpo3uyH7ajbr6k4CgKAITGhLP1bbkVByiVrerYokHPZBYAbWHx1Ej8nxNXNg5mIR2vGUKCiiRULDpv6xOOxGHiEXBywAgtxCOSnmiiMysbTvnqvymfw/tklbEuMUc2VltjFQJVgoipeanZ3CSubbLrw9UVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DelhEmlnyMPfXXgn2PlMEYi6TuNVLiyt/1iWyZikR8w=;
 b=SdNEsAvBX1v2GnvLAVBsNOlYkgACmQCxTDvWSzej7EQhC4nNMmwxcFVEvSTSZ0H3AYYD7LAwU3PI7rEnV3O2vsv3gkypN3EuDpujjMDk1RbVqZWBLzYMRPlL27IYSCVCGdbRpGp7ExcHKH63n/V+NawKO/NVacZGEdj/FCEXL/5Ezyx8lloiuiw5NHA27/KZAGendwlGXuLCIFe2Pt7YfR2AW+BHJ/0TVxX6XgAUsWEvlj4XnEnb6wkOoDwTzgvOS/6A9WDqlWeKxeZ8sPBAtZEWbNBHvAg+kpwPHpEJORRfxrhcBytz3ACWr9bDB81YZlRDvYGUKyiUWE25+fCyxw==
Received: from DS7P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::14) by
 DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.18; Wed, 9 Oct 2024 16:39:05 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::e1) by DS7P220CA0007.outlook.office365.com
 (2603:10b6:8:1ca::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:38:58 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:38:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:38:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v3 02/16] iommufd/viommu: Add a default_viommu_ops for IOMMU_VIOMMU_TYPE_DEFAULT
Date: Wed, 9 Oct 2024 09:38:14 -0700
Message-ID: <b7acc7b61f1ffa156d5922a17e3974f41adb964b.1728491532.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491532.git.nicolinc@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f46474-795c-48f4-9034-08dce880e3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bAnycWOBSR4K8bXxQ/Y25uwvnTBzP6IfroeClhTW18uM6FqMBld4/gW5iRle?=
 =?us-ascii?Q?O3TUn3Iyf8oW5v/0P6/54pLTSW3r+s2A6+AyvMoCLfwrRU25mdDvH9p8KLs3?=
 =?us-ascii?Q?Mrs+uDtywz3VGbj6i2+UsDy3KrAPMnoE9tUbY5kewXl+eXWa6wNUX5oN0maX?=
 =?us-ascii?Q?F2FSGXgpRCHBvARCukfpbt4m5JOCankilmJdN4fx9M+weTJOKJjRssDuywhC?=
 =?us-ascii?Q?/H0kRFVX7MOwX61jWsK9ix2bjDYiSakRGH89xnwkQ6Gb4QjhPxrDeqDh/IPp?=
 =?us-ascii?Q?hb1qIgobM+ALHZzwLGVaKD4xSLxuupWpE3MvbcqHdAB3rN5kzIdigT2XqrY8?=
 =?us-ascii?Q?SUciFIppP8IK4eYEFAp979MohgjhsuXhnEPMdCZh0p9VfpAyojJOXa4AKRAt?=
 =?us-ascii?Q?lWIGYEe26rV/7uEoDroSHLUGF3Xlu1wrDlY0FFdoxNRClHrwIWY2vWQjVy2M?=
 =?us-ascii?Q?nAZz/QqDwq5yg8c1EeAd6P4xHpEjT7IkMKW9caWid+wrWF7mv3x4Oj1Y5xf6?=
 =?us-ascii?Q?8Thu+UNc0IvB1CO0OUnArcgpBWYEjw4/OycyOxVfWVBVadb/4yItSXM0OLI6?=
 =?us-ascii?Q?Nxwkp4GuavXoKBK9N6a/bC2y8iiA2HwR8kwsGfIQHLnKVDUYJGubvzBrKAYi?=
 =?us-ascii?Q?1l4xzKXLdNBzoN+OsP3EdlQ0mPEke9xBJX/nyK7Ka6/QRxsOezg11GtkbwCq?=
 =?us-ascii?Q?a+rHKtGlKU8pj9nDY0lbWfCDpucUL2nDx3uMPo6Wa6DPdmnu8O4HabBtuOVR?=
 =?us-ascii?Q?CH7rJLyHOdUo/KTRklgFrj1YHEHD99eVxEytTGRkDZucemMmc6edmKz2Uoch?=
 =?us-ascii?Q?nIqn7OaL/dZFq/GPbnMcrseJEQtrWurA2a2Goziw8o0WhBwjr0XhEffBqTLh?=
 =?us-ascii?Q?R9QMIPC+R5soN/jA+EYO7g/Gb9jKC3e6JvgG7o0WOripcWof6qNJ7RSOuhak?=
 =?us-ascii?Q?5Gy5AGL4X/TAHI9cV3TMYntemsUs/xjlx8J9podLkcfjWQKEpeyBEAEb5fZ7?=
 =?us-ascii?Q?345RNfCWCbQNZFKSd14bg0h6VjLf9qjxWp2/6miYaXbe/sFG0dzWN5N5M/GE?=
 =?us-ascii?Q?k/7UxO3Si4LjGFgJvQ8nBqd9hWpD+P8kuP+1yiCeY5jWeeFRacfDUrRv5WSN?=
 =?us-ascii?Q?HKV/AeM6gz4nxsCoplam3Vx5w8Z8fNpS13xDBxyIcM2EIlXpuVP3pRuKZ384?=
 =?us-ascii?Q?oEdW+IHxG2NTR6yFolsBMSG3kJTTdCwJoFSv21qcJwEVTLgvQkJKoj+R2QO8?=
 =?us-ascii?Q?WCjQQsSICTyM/av7XfJtT+Z7yqDE6p7bKeuAf1OPhSoeHgYIp5cnVnuJSYh8?=
 =?us-ascii?Q?2Oshe5YB+Mq8L/et+Yz2tLhVv1F913V3oyP7tWlMsEMLeNK2xDTghPYYt4SZ?=
 =?us-ascii?Q?4nXI7ZzQwMXGC5+1Gj9bgz3Tu2ZS?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:05.5881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f46474-795c-48f4-9034-08dce880e3ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422

An IOMMU_VIOMMU_TYPE_DEFAULT doesn't need a free() op since the core can
free everything in the destroy(). Now with the new vDEVICE structure, it
might want to allocate its own vDEVICEs.

Add a default_viommu_ops for driver to hook ops for default vIOMMUs.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h          | 4 ++++
 drivers/iommu/iommufd/viommu.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9105478bdbcd..1de2aebc4d92 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -44,6 +44,7 @@ struct iommu_dma_cookie;
 struct iommu_fault_param;
 struct iommufd_ctx;
 struct iommufd_viommu;
+struct iommufd_viommu_ops;
 
 #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
 #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
@@ -551,6 +552,8 @@ static inline int __iommu_copy_struct_from_user_array(
  *                It is suggested to call iommufd_viommu_alloc() helper for
  *                a bundled allocation of the core and the driver structures,
  *                using the given @ictx pointer.
+ * @default_viommu_ops: Driver can choose to use a default core-allocated vIOMMU
+ *                      object by providing a default_viommu_ops.
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @owner: Driver module providing these ops
  * @identity_domain: An always available, always attachable identity
@@ -605,6 +608,7 @@ struct iommu_ops {
 					       struct iommu_domain *domain,
 					       struct iommufd_ctx *ictx,
 					       unsigned int viommu_type);
+	const struct iommufd_viommu_ops *default_viommu_ops;
 
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 3a903baeee6a..f512dfb535fd 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -44,7 +44,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 
 	if (cmd->type == IOMMU_VIOMMU_TYPE_DEFAULT) {
 		viommu = __iommufd_viommu_alloc(ucmd->ictx, sizeof(*viommu),
-						NULL);
+						ops->default_viommu_ops);
 	} else {
 		if (!ops->viommu_alloc) {
 			rc = -EOPNOTSUPP;
-- 
2.43.0


