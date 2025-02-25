Return-Path: <linux-kselftest+bounces-27509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD8A448D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0688852C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812E42144C0;
	Tue, 25 Feb 2025 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ulacjx3h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A4C2139B0;
	Tue, 25 Feb 2025 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504404; cv=fail; b=TYzOd0l/HeMfF4roTu0t5OuHipus+SCLlV6Y69nThgs2fdMEVea0KVHzGO2xfqmM91v0nGwBd89G9NnDJzNCgDC4Pe88ZmHENkTjw2VLz0EytCOkYk/Tvw+0Zncde/7NUv7X+o8skSQzLEqXIijtpqWnIM9Z+jNvrdfYEWlaN4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504404; c=relaxed/simple;
	bh=/X+09Vsc4VNJQvbEU9KMf9p8UYEDL0uvP9TGQnPsgpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaUq2SdxO/VqzXt5gM1lDWip+foNpwu1csV8YZo0Isv7U6yAJ854OwGwvkSBNLacRbvBcPkrSiuxSUXy/5vY2FkdUQJBEY1ec9rjxKcdFn0J7H+s1kuWh9PbOnJ9rQilwHyqVs6oBvZ21SjBWQcQtN5j7W4kyJyvU/YqBuIxeAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ulacjx3h; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1YsB4tDe7hDZA9sXA7KRibo71Bz9cvsWSCbhfYiBMu49XzYH3JJ67ZdDxTKPgYE54bVpEx/05i8nyjRCIpo3NVtVXTfXao63URP4bKHZTNR/NLQOOVJLAXFXqNj7Xien1OKs0jh3QOw+E4/gRCpSxOyHXfDiLkweoxwjWgYcvRDNfObrY+26N0JwwPyHAJ3KdrT9UA31SR89DYp4gVEsVTIn+0m4XQsNtJ6bNs95KDYUOc+lpZOMamwvsyFXY7iv3ZAAbYfpoDd5q5fyL/dNmoZ/EejDb/H7sUG/47d+oBdP3nKBj+BEymqGXXXPBA09QOeZouYdqbFmCGC7d8GXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsmRbpLmY8d02Z/q83YM8QZLbPFpQKH3bXuv1IOmY+0=;
 b=dKALfzKOOaxS4ZUmMyA1C+F0RQ+IPpCOIgNYXExk13v1qFZKOUilwojU1r173qTODPrqqzAhcNUynszb+hohfdYVjL7XkCotOO9Dw1PTxOEQspi3SRot+UxFt8/J3O2F+e1AmKyVFgg0xADr4JyP/9WPUmxmY5CrNS7mQn6k4LkAPIGybo5egrW+1lZ/Ffmlge5iHq/YEXLTM87FJCwdvmHwNBdOxClgmetVJCgkDAf++Lhxc++WXPSAsyj/wA69gvMx/RHD6dnsDWkofWOGPDCbz6KpmF0EEbqgRWODLygiR+4C/FoC8YFdFbIHthOqZaE0uOPwbEc+a17X759MjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsmRbpLmY8d02Z/q83YM8QZLbPFpQKH3bXuv1IOmY+0=;
 b=Ulacjx3hdLJqx6BErkNpPlNxSHOxrt2Jj0NW6k/HBkIhtXWSsjK1hEBHhtyFgWNTeNK02gmTFsmGGeNpKn231jZ4tsHIOcBKiuUCpTOQjBK+IUwMx9T/apupOvqyTl/vbmeDFDoNHMDmSugR27zgwIx2fZ1gSzarNaWkinW+eAH6boFSgjdecFgTsfLJdOkXH1Y1SRwr1HzPdfzgkuF4qSen0AlAj/JVHUVaR5s0zQ5YSX1GpxnpLzaDnw8ix98fxBHE1avJPvbxeRa2a36abTtxCpIUOMk3YasK+t5n61zQyqAieoTK+b/8/wHYRRKg2XVKPAyxNo5hpJhwseK9rQ==
Received: from MN0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:208:530::21)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 17:26:37 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::82) by MN0PR02CA0001.outlook.office365.com
 (2603:10b6:208:530::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 17:26:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 17:26:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 09:26:13 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 09:26:13 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Feb 2025 09:26:12 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v8 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations
Date: Tue, 25 Feb 2025 09:25:42 -0800
Message-ID: <f465dd9defdc0fc748c2fa2cfc829e37778a4ced.1740504232.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740504232.git.nicolinc@nvidia.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c1617d-7199-403d-96b8-08dd55c18f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yUzymq6KwZ4CeU0CioFDIa4pjQ0RLEAKzqh8xyn6Co0MMOl0vQqUOeFUZ98a?=
 =?us-ascii?Q?fdrnlx8qT4v8JbD4yETGt5x/3ykL4AiQBfDEmu7yEiq4I5RvKQ17gfIGUVZ8?=
 =?us-ascii?Q?v459zat4oBnv1uLQ87IveN5ZZg9y74iLLISKcAGEUR42cgz5BrEjM5HOh8Y2?=
 =?us-ascii?Q?7+yJlytsnciLKqqE7O7g/zqX+8qghBQQ8Wxo826/XCba2CXa/WoAnlwUjvJ+?=
 =?us-ascii?Q?L70FmQOXUbrglBjaesWIEwCGdxugLiIo/WzO7UmMhdDpHlASJA7ZqUbGwyOf?=
 =?us-ascii?Q?Pgtd81dTvRqWbS/4uQk84Rdjws+MOy9Kg8aIbZdb2oNZ/9gksIC+r5CwMiox?=
 =?us-ascii?Q?8+KNnvpiQ43Dd+MkRnq4Yc0TnTIzA155MRrXkHCws06fdnh/IARj3P5o2nAN?=
 =?us-ascii?Q?iOPSXUdBFONymh8hVBgAHfjT3qzd1BI2d4XB7ZhwSJxxEfWf7cVPi2tT4Byr?=
 =?us-ascii?Q?k1CrSblu/qTY3HefIpHsm5ICPwVmnTIAZ7tQWxMOs9b+E2R2XfMWnpC0Ieva?=
 =?us-ascii?Q?INyFSaIWMRFtGxbT46bxdyh6hdK9CCsJfmx2M2JsioFmxcHTwXs+PnDvmk5Y?=
 =?us-ascii?Q?sAU+iSC41dGmn8bcRRDCR50DoYvQWQEAOn9UiUXsOZ5JBNXVpXlEgn3VjGgL?=
 =?us-ascii?Q?bF8Vgig2xeRC6sem0ijOI1NXGgqVXBzlYdTkfTZFGmQwU+MjbWbr4jf+qz7F?=
 =?us-ascii?Q?MHRcC/iDI0I4p6EOe2e3R/P0yMzr+QfcuVf37A417dbCk4I0Urza+9flqLIm?=
 =?us-ascii?Q?AavJVlERr/ktXC4yvOGuYJQHzwayiK8fhYQhDPz2nw0Ck4UmFZDWHW3uyVSY?=
 =?us-ascii?Q?r2Wu2n9PcnaodAeOEZVxEI2mbf0xNxBFy5+n2Wzz/s85b8OUfX5aeXIqHnBV?=
 =?us-ascii?Q?3s9pio0qXPRosOp92c8Ccnj/vfaa76tlmr/lHM5WMJO2ucrKzzrdaTev6hro?=
 =?us-ascii?Q?ZiSUNu7eHuSisgomyJdw+taK8zYdh5gQa/1tsHhRFN9A1u56U4Gqabg+a34o?=
 =?us-ascii?Q?TGFixmF6Ub9eTevcDGj+pTACaw4tGb95u0v9oK7pOgVCIWCZmuUbB5BgOlIh?=
 =?us-ascii?Q?eALKWUdGNB6FckXDyL63m9t3rmdM2eUe/640fm9MXsPjwB291RONocbbQDPi?=
 =?us-ascii?Q?J1UShTKMCrBGOz1CsfZfCK3eQQ88teiJBTp+cfNYmbeFwrc5hbSYIS+IS7Tm?=
 =?us-ascii?Q?t0WsiEjHPznozJjTT0k7mnKGcirEPFm7XQBpR7o3P1OLduAeevo7qoixl2ai?=
 =?us-ascii?Q?dNO+Pd7u4De+0Pvxpu8u05/nhbTPS9hIr13FhFzh3flIkZ3tWGXm5of4BwQS?=
 =?us-ascii?Q?ZLfT+yCTuHRFpnSmf+TItYX1QYGygsSDS+Q+2kovXXTXdM9WwSa407cMnWX+?=
 =?us-ascii?Q?hngBCNLcQ1eyQm6+lCJZhHFqkOhwyFrqX4GXoOzrXk37S+17HkGTajjAQHqZ?=
 =?us-ascii?Q?4peSr15XUagPglQP5PAP8ehGnN0pJDgO9Yjdxs0zfevHBPmWmHRwfadYIBql?=
 =?us-ascii?Q?iLcmpR7GrOXEsAQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:26:37.2839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c1617d-7199-403d-96b8-08dd55c18f21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407

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
Reviewed-by: Pranjal Shrivastavat <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index f3c5c49bf131..bc4f536f72ce 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -266,6 +266,7 @@ static inline u32 arm_smmu_strtab_l2_idx(u32 sid)
 #define STRTAB_STE_1_S1COR		GENMASK_ULL(5, 4)
 #define STRTAB_STE_1_S1CSH		GENMASK_ULL(7, 6)
 
+#define STRTAB_STE_1_MEV		(1UL << 19)
 #define STRTAB_STE_1_S2FWB		(1UL << 25)
 #define STRTAB_STE_1_S1STALLD		(1UL << 27)
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 649e3aa39a48..8e8ea3702ce5 100644
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
index 22aa5c8d1e9d..3fcb1089a7c7 100644
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


