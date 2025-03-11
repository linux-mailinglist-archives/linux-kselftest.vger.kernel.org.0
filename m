Return-Path: <linux-kselftest+bounces-28776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338C0A5CFCF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1B317754F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19170266587;
	Tue, 11 Mar 2025 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AysAqTrO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F826657D;
	Tue, 11 Mar 2025 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722352; cv=fail; b=itlP9bwHy/5K38bkbI6lnyou72th/on8cCWfdLIOglUpEk6AbHyr2xUQ2+qdkiL9ksBxCYUU7Y0cs+taovwERwrIrm6XCor0LPfDYGGt5uE6YFioRS6USYbRYstf7O0LRiv8fMpjDobnPFMEfj2DSvHqEg906zN3aRPhupn8qSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722352; c=relaxed/simple;
	bh=y6pvKa1lIcYkyuOMO2CuVtdtI1j+W+3HV2GI28RpQjs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jb853Y4bDt+1AY7lHFYRAwPqvgfE2UKK+DmXqsJxHJ+6BcOW/8vJTJHwafTHwV4t5LZgHtbeNvvfLqGy7/ILmdvnLMfRbnbhL8GBi5N4ySlcegnsM6PmMHYpC9+kMsGehxZyAD7zhs9nwQKTy8YpSCGvARQlbhKioloviTQFcIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AysAqTrO; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4Umbz8qaCfKrpvkla/7AeQVHY5sy9wSsgrmaEcuGL4wtpMab7D7b2S6WSRl942MXa31vEDCJw54asP6QTTlSUrXlZw9egcvwo5l16TphCawTXcbfw+IU6vGVLNHWawGay0qbK7aXJSJW4Gb5skDezcuc3OTOTwIURpp9xZ1g8PQ6yXsn46kpKKBCtxEyFYCWpSTW+fq989q9XgbI/EI9HRqivleKUvyfo1qB5s/XHS99l8l9AJvGp0ve4CTG93ipATXAjBdj7YO5qu8CowMjBvt5eUs2lgiqMHN85KoFpll+hkXTtnX5iuTLcmfCWRh74KT/WXQUI4mFHtAbAF5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVNd/MbVcQzHn0QWumP0mPqpPV9YnWSXUZh9kSp7GI8=;
 b=RfGqkh/E7PnkSS83FtdHagGCtsjNBi/qJ3bspv+TZLDwUmhfZ9j2LGdNEAczKa7UxzxcK6oCvNc1JUdPTCmI8w7ivgxdKNprSaxemI8hl8zjv2OQ7jhpQb2IAfio0saqCDS6qhSTyBOsAgCl9nNd3LdNxlIBWh57SLsoZNCuyXcRrfHyN2uid7Dvki5LwOXbnlBQy8hKxAA+vqcM6Tr6CmpKZ4aASQNzZpCaf7BHRll2SJIphwUDY67peo8a4aTPxKX5q5OVaKqYUQJExYo9V8tM8vUEsTBC4/zLkv4v01o34YVRJqHfOjgF4iSiyNYb1bRN3WHPtNGHmPGwiWKjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVNd/MbVcQzHn0QWumP0mPqpPV9YnWSXUZh9kSp7GI8=;
 b=AysAqTrOja+32Meo/GbiQIHFbgoL03ivVaR8YSa0qMNDsgF2zOsUlZtuyvMg/ToCdLdZWdYOgteZZkMvcLcFz5NPfS654GQ9kbfoSkDDHj3h2JIbSTEQv+RR9TjujNWWfDWckWPsjMYWceOdAUOhSOEUBhkqNXEa7PcpQtllWzogCwNSpby/cTle8KymoDZqsruWGWn5Hosq5OG0HknWAgkE1QybsdFnrwUQmzAzg++3ZTsOuA71a5uV56hTPHgmT5+qRVBkJO899t6G2a0mFUc41lZZ5q3xtxPT8e8OJ4ZxRwJwjI44YB9NBBtK8QKI/uwO3+LFI+k0t2VjGbK2Ew==
Received: from BY5PR17CA0069.namprd17.prod.outlook.com (2603:10b6:a03:167::46)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 19:45:45 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::8b) by BY5PR17CA0069.outlook.office365.com
 (2603:10b6:a03:167::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 19:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 19:45:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 12:45:32 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 12:45:32 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 12:45:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v9 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations
Date: Tue, 11 Mar 2025 12:44:32 -0700
Message-ID: <8ed12feef67fc65273d0f5925f401a81f56acebe.1741719725.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741719725.git.nicolinc@nvidia.com>
References: <cover.1741719725.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a27367-55e3-47b4-8852-08dd60d550db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2tlGGtGixm98BIekoLd2Ap3Nje4PH2YI0A4d+eiFJsWn3I2W3fHHd1Z2/o7P?=
 =?us-ascii?Q?M3Lb3NjcO+05aBv/Fv16dSRA7ehSCmSXBweV97znfujW+nxJxe5Kvi30I088?=
 =?us-ascii?Q?h2HqXWtPQe3X7ez6M4kj25kt25plgLxa8k2FG2ezZXOMci0bB+s7f49J6toD?=
 =?us-ascii?Q?cmhOojFBAJV5IxZfmzfQorpjn+im9s1ImNutNCUifUa4HDmFG+aTgqdwXyz2?=
 =?us-ascii?Q?kFb0EPopu9ajYBdCa44B4mSmIHxUmXmffpQezfA8ya1jri89lIBD/Us8MsK1?=
 =?us-ascii?Q?yW1iwQrF3ddiAbcII3ge+tw7Hpqjzj8N8oxaE/WOtU+efzIqhi3HInuLFhXV?=
 =?us-ascii?Q?L382l8SSG+a5ezIPSuKzin1GR3dAx/6CZjyEDbJWyQlz73v9DGnllGQyHKKW?=
 =?us-ascii?Q?sNCaX+JsHZjyAvwDWS8PDHBn2rFQPFcrQcDYAGagFS7SfIk/COHB8qZedFjO?=
 =?us-ascii?Q?a+7oFTuEf/c1beiKX+mz5vQK1grWCDpqjWgYZITY/hvZ4mZAEHySUJ8R4FDh?=
 =?us-ascii?Q?oBQ3N1Q8MGlsYjPecYIgdxs/5NYMaGoG/Y53BeP6Jtsk8969u2+rEyQPxqZk?=
 =?us-ascii?Q?/7nI4fW9rAXJ2hl8GcpVRHMMXaLHwTzkhY/+G07irsK/c1/ta47o3jW1t1Io?=
 =?us-ascii?Q?CtCTv/IEXAhVMhtN3VqSyI41dvawYQUUtBso61oYVLEYl2wvZ84mqUP2dHmX?=
 =?us-ascii?Q?8qzUjw+WUHac6lZqAKEQGYEb8GxAmtGqR41RTLY2gdCdoH8I8PRWQpiRHk+K?=
 =?us-ascii?Q?TgRgm2j1kamN8OE9N1QzgcKpvTxsjYZj28gxM/oEt1gJwxAKX4+tW5n595Sl?=
 =?us-ascii?Q?IW/YmOcdzQyecI3uDmRslss1VYAks+FnOmyOHjW85iktJ6P0XTYHYQhLf28R?=
 =?us-ascii?Q?caEGoGrTFbEsaqUUrBH2E7VCriFnho3WrwtKmx84MEsKlVE8cZDv5+qXBl5g?=
 =?us-ascii?Q?deoVXrXp51EnPV9Ft2aclVvDiNznkxIlwuN9bNbhlblFB7r3YnUEYUAo/W9l?=
 =?us-ascii?Q?XRKcjjl368GSxGU84d/SIWbB6RjOsQmM8p3RF1FbCrG/fWbS1oNg+5NE88Im?=
 =?us-ascii?Q?ond+M9/B0bo90tI8piDlNJa1UexJF8cQgz62X0XVYwTtQBYN55KGPIktseR+?=
 =?us-ascii?Q?CURx+r1Xks58Mq9LZpS20te/z7IPubCYj16UJy9rHzjJSqS3Qmnx4Or6enFf?=
 =?us-ascii?Q?Y+YbEjcExrBNamTd1XMblAxRkQyfRdxSOpLgyrpOi840GTggc7a2vFWyt4PW?=
 =?us-ascii?Q?8PBHT1xQ2S9nCJ4gaiiFX9MSp7OLGD7dcPYWpkob4NBIDpaIXxv7TZRu8z4V?=
 =?us-ascii?Q?sqn8kUOw9pI98FDBY0/UyFKhFu1PdWwGEanSNYJhkE5AjJ9RTydZlXu6+mNV?=
 =?us-ascii?Q?bLFvpJTwQ/ZYitJTufXKFKny8KSLIa94CBLJS3OoYHoiZmy8aLU6fMGrdI3S?=
 =?us-ascii?Q?UOxMOUHuQKWjTx6PMiy2shkXXfvTnkCHlrGTPvOUoO2o+niD22LolJgMMbKW?=
 =?us-ascii?Q?IVuCP84y4pxL/4A=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 19:45:45.6718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a27367-55e3-47b4-8852-08dd60d550db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613

There is a DoS concern on the shared hardware event queue among devices
passed through to VMs, that too many translation failures that belong to
VMs could overflow the shared hardware event queue if those VMs or their
VMMs don't handle/recover the devices properly.

The MEV bit in the STE allows to configure the SMMU HW to merge similar
event records, though there is no guarantee. Set it in a nested STE for
DoS mitigations.

In the future, we might want to enable the MEV for non-nested cases too
such as domain->type == IOMMU_DOMAIN_UNMANAGED or even IOMMU_DOMAIN_DMA.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index df06076a1698..dd1ad56ce863 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -266,6 +266,7 @@ static inline u32 arm_smmu_strtab_l2_idx(u32 sid)
 #define STRTAB_STE_1_S1COR		GENMASK_ULL(5, 4)
 #define STRTAB_STE_1_S1CSH		GENMASK_ULL(7, 6)
 
+#define STRTAB_STE_1_MEV		(1UL << 19)
 #define STRTAB_STE_1_S2FWB		(1UL << 25)
 #define STRTAB_STE_1_S1STALLD		(1UL << 27)
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 65adfed56969..e4fd8d522af8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -43,6 +43,8 @@ static void arm_smmu_make_nested_cd_table_ste(
 	target->data[0] |= nested_domain->ste[0] &
 			   ~cpu_to_le64(STRTAB_STE_0_CFG);
 	target->data[1] |= nested_domain->ste[1];
+	/* Merge events for DoS mitigations on eventq */
+	target->data[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
 }
 
 /*
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5fa817a8f5f1..b4c21aaed126 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1052,7 +1052,7 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 			cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |
 				    STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |
 				    STRTAB_STE_1_S1STALLD | STRTAB_STE_1_STRW |
-				    STRTAB_STE_1_EATS);
+				    STRTAB_STE_1_EATS | STRTAB_STE_1_MEV);
 		used_bits[2] |= cpu_to_le64(STRTAB_STE_2_S2VMID);
 
 		/*
@@ -1068,7 +1068,7 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 	if (cfg & BIT(1)) {
 		used_bits[1] |=
 			cpu_to_le64(STRTAB_STE_1_S2FWB | STRTAB_STE_1_EATS |
-				    STRTAB_STE_1_SHCFG);
+				    STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV);
 		used_bits[2] |=
 			cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
 				    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
-- 
2.43.0


