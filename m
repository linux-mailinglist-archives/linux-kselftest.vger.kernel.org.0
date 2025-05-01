Return-Path: <linux-kselftest+bounces-32131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56705AA6728
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE6A1BC445B
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4168E27E7DD;
	Thu,  1 May 2025 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DvrzL24V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8605E27057C;
	Thu,  1 May 2025 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140564; cv=fail; b=RvY2Nf0Ib86TMC1TVRFc/eFpey5g+1y0qGj5uzoh3lp7AMTbt0m+jAhAmhxqE24RvoUO5hrvGQe+iO+81THAWbiYpNRw+0Ij786j8cGNYhBOhBsJacwuXA3FWkU9K3UEJVQWN3b1Ee/+NuKZrh5bEPt4a6qwMU48/eQEJxrmicw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140564; c=relaxed/simple;
	bh=h/TJtMK+QaU20NZlaQRxNLR+WBub2ZUTg3gTBrv7Tic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qG7z5slJXp+Dmrjb/Fl2lb0w8B6HzzsnblBTenXLdRpK03FKRf3hoGKYzwitBanf58uF8awdIdXAoPe2YXxZv8B2t92rnMQL9jcV2TkuoPsTUUODVBW90HvMjLBTHt3AQXvh/M3/9s+3/Jlf8pTRk5k0YYHVFrzZOF61RzeRy1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DvrzL24V; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBNPRriArHksgqe5ysFrP6AyWK0ssCUmrCtdP57Y3Hf3S8bpHAfAswKtuOM2MFjmESiUDHK2uCNGmmD6UxSdyEnF+cA9alAGZq/sxBWwPThQztM+rA2FG/7dPeATQmHV3+lFeOYH9iFQz7hbdMtzqYGE27KA5BWFbYHeH4NLMFXe/SntMGuQTOO8IpPVL9+fhSBUpV/uJsvSkQvLqI6jGTXTwBY0iAc2KFNewQ9GWTGK3AG1P8GKjuj6enRIE/s3Smk6YzyAslWoUwLctgsfTuIsdlsWNgzWA2dYm+Lp2ruvvobWKNssM2Dv+V7BwsGnLsK1z4rSvBQWfSMdEKmwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HddP0HhF4xzgeFJWHv4I6iAgtw4GC2FHhJ1cnTJYrkg=;
 b=Joa7GqUI+MLEfbNgVvcfdNliIbHRuUg01oHBYzT/zaMnclDtHvZczdzz181kgB2InaLvf8kVCCO8DRXuHKGebP7c6KdAFHUzsN4bG8NJGgX8qNy1YMVqzv2hoHHn4Z4fMSsGEg1NNVGBaN2q+KEuUqhtR5AiI+3L08BEPRrK7qe5SLHqB3DqoBAs52QG6Gjad9EcT47hmt9ywMmZxYX3rjHZh2TCXEenmLfAbCGoKm/BVFJLfWG+xdjPXD7cqZNPw74fFKik8k0R2fV/aR5mYk/t0ZTbKo5H8h9AjM/hFxrgKUiyfMjHgq2z/ax2rMTjv8cU3PqrMKa6LkF+lh24wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HddP0HhF4xzgeFJWHv4I6iAgtw4GC2FHhJ1cnTJYrkg=;
 b=DvrzL24VEVXjc4FL8lQzKEx1Zvf3WGXKjGPAM1QlHZhrYh3RrK2exV+42lzMjyv9qXT1l/LtK5XRHI2N4WZjJ8E3Qxpy7YLVF1laEQsbIK1NaWsykdirT/C1w88dgZ5bubbgG1OSfUuh510qt3669+nJ0CMVzyllCKQahqkjAgebEHkDR7glqJnuEmBZl9rplRQxcL/X+9OOCkoE7RgFGfzk64RjggHMm86yLhz4aLDpKykxiBq0V+9+dCD8aczgHz70SYdRrE1PuEhayg4sAidrLblDAPzXk300e34nmuev5F84VOaI0sBa6VlN4e+5kV6WQYT1FyCnIOPAEUsxkg==
Received: from CH5P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::10)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Thu, 1 May
 2025 23:02:39 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::5e) by CH5P222CA0021.outlook.office365.com
 (2603:10b6:610:1ee::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Thu,
 1 May 2025 23:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:02:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:02:22 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:02:20 -0700
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
Subject: [PATCH v3 20/23] iommu/tegra241-cmdqv: Simplify deinit flow in tegra241_cmdqv_remove_vintf()
Date: Thu, 1 May 2025 16:01:26 -0700
Message-ID: <e3ec1ae08d70edd511f902f2d0b6219ce07fdb6c.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fc52f0-c7e7-42aa-5c49-08dd8904453e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?naeKYECZPWWbWhBYe9F2l79ftEPCSay9vdXUorGvhzwsP+JUCmrLFnyNNIZ0?=
 =?us-ascii?Q?IYuz+KPYEGfcgzj5GMqLh2PLhPOFYc6HS6eUbjsbfjA/gFkMKJBmMh+dEZA2?=
 =?us-ascii?Q?5+Ijqc2S3w8TzsAiqAljU6APL52poP6RjE3GNeen+5WrD72StW0TqM9IQE6i?=
 =?us-ascii?Q?hzM9IQ52/U2vWVH0v02KxOmYktaEhg3uqR/STIDQHdV9bxEcXsEOoViLBbnb?=
 =?us-ascii?Q?1qXVExF8lFkROfh3i0hZSerZ3S3JB8tmV7qTtDx9/6lp+W10bwbGy5Jh3PHs?=
 =?us-ascii?Q?RSPJB4vreQy3a3EzUsNfY28T+tbgu8aVj6PE50DPs4HnJqIhs/3GrDyYkpyS?=
 =?us-ascii?Q?fUJOMtINE5eptHwQ6GcHee026AgCis5waZXuIlkJZaaqLHzDMfTu55/YZ4qx?=
 =?us-ascii?Q?T8gAWZ4HMF2Rtny24VShjLBUKgaEV3QnDbu+qdfW+w/5TA1Wfdw6aQ0OoGrZ?=
 =?us-ascii?Q?TMD/KNisfgtOboZfji0brYVwo6zPBIYwHhrezKRaxIxfcqk6TQ0UZs5zBtk5?=
 =?us-ascii?Q?xQAZXjU3+BCzqn5WOaIiMX73892tT4rn7SocMOGmP/wGNgvWC5wuzTEvwdER?=
 =?us-ascii?Q?WJLeNqX/70/XsYmdaY0An+/b5TSUi49N6dZbH/wFGTKaBy85jYCxx/CR2diK?=
 =?us-ascii?Q?uqEJ5hWBra76ITRHy4CSLzLI2NukX2CPxz9Yny9dTFstW/deTz774TtnTAqA?=
 =?us-ascii?Q?pSwIwq9RlTgmDWjmDIGMMcNo473Hg4qUmwOouefUcYpWfPAlXih64LeNWJfB?=
 =?us-ascii?Q?HpBPse8cD0u5vPCpqEsKhh6NDxtQieMUDb6zQrUNUy3xQ676iuh+lILZWFoX?=
 =?us-ascii?Q?TUAYqRHR8U2eMr78PT9X5MX46AN3zQXDou8VcDMzPvyf+K6JCfrsxBoTO9rh?=
 =?us-ascii?Q?y68Tseq2YF0LljNejkrjMO4y4focsbtYzPMGhFiizmuBbqsAnDrUYd6G58+8?=
 =?us-ascii?Q?pwKcTP6FHWXR1t5vIVywYxQaOWGMonPTFMeVMJQ8vDB7zPzLq3mW1LMYJkho?=
 =?us-ascii?Q?vEtvUcxKK93DQdlu+AJjo+tpXPI3TSXutYkJZq6RSU8L5Tr+DbVNUNIMo0Un?=
 =?us-ascii?Q?ZvbtevihJXVn7tCaIWBE2/1tXf8S+XaoSLF/VEIm631Eh84qAfCyp31RW0Yh?=
 =?us-ascii?Q?GtAz+LVv3/vJgxUDUkvWgfnctmvlqGpd8ZLPU8fS5WL+pDzXVSvIS4yVMxq1?=
 =?us-ascii?Q?cnoyeFgeRchfm3FaElg2lGwnF7Hqc4wnbiKuQ497OqRyuiAAaqVGzbE4pWNQ?=
 =?us-ascii?Q?UdfF/6tchazzchgzp385U87kVPuFJTHwUkUrBSyFUkTDAEzu98+rRg/dboK3?=
 =?us-ascii?Q?xw8ZgJlDIl1+m0IppjoCZmEGfIKxsseqZ0gr7nOTuXtu18K96qCSpIf7AFKg?=
 =?us-ascii?Q?TYJXr0dngMQKaL9yErooUYO+O+EVjBNlaR5eGFsMNJCA2AZLcLmTKUZpu5BZ?=
 =?us-ascii?Q?ktjHg2/1qHY9mBuLNcKmm+Vewz+Jwmz65Jw0Ljr6Q4aAlz0WDHDfgNeQtn64?=
 =?us-ascii?Q?Uaa/5HQAv4EwdhmCBGrvdb7eSS4Z8vghBMLx?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:38.9562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fc52f0-c7e7-42aa-5c49-08dd8904453e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234

The current flow of tegra241_cmdqv_remove_vintf() is:
 1. For each LVCMDQ, tegra241_vintf_remove_lvcmdq():
    a. Disable the LVCMDQ HW
    b. Release the LVCMDQ SW resource
 2. For current VINTF, tegra241_vintf_hw_deinit():
    c. Disable all LVCMDQ HWs
    d. Disable VINTF HW

Obviously, the step 1.a and the step 2.c are redundant.

Since tegra241_vintf_hw_deinit() disables all of its LVCMDQ HWs, it could
simplify the flow in tegra241_cmdqv_remove_vintf() by calling that first:
 1. For current VINTF, tegra241_vintf_hw_deinit():
    a. Disable all LVCMDQ HWs
    b. Disable VINTF HW
 2. Release all LVCMDQ SW resources

Drop tegra241_vintf_remove_lvcmdq(), and move tegra241_vintf_free_lvcmdq()
as the new step 2.

Acked-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index ba029f7d24ce..8d418c131b1b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -628,24 +628,17 @@ static int tegra241_cmdqv_init_vintf(struct tegra241_cmdqv *cmdqv, u16 max_idx,
 
 /* Remove Helpers */
 
-static void tegra241_vintf_remove_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
-{
-	tegra241_vcmdq_hw_deinit(vintf->lvcmdqs[lidx]);
-	tegra241_vintf_free_lvcmdq(vintf, lidx);
-}
-
 static void tegra241_cmdqv_remove_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
 {
 	struct tegra241_vintf *vintf = cmdqv->vintfs[idx];
 	u16 lidx;
 
+	tegra241_vintf_hw_deinit(vintf);
+
 	/* Remove LVCMDQ resources */
 	for (lidx = 0; lidx < vintf->cmdqv->num_lvcmdqs_per_vintf; lidx++)
 		if (vintf->lvcmdqs[lidx])
-			tegra241_vintf_remove_lvcmdq(vintf, lidx);
-
-	/* Remove VINTF resources */
-	tegra241_vintf_hw_deinit(vintf);
+			tegra241_vintf_free_lvcmdq(vintf, lidx);
 
 	dev_dbg(cmdqv->dev, "VINTF%u: deallocated\n", vintf->idx);
 	tegra241_cmdqv_deinit_vintf(cmdqv, idx);
-- 
2.43.0


