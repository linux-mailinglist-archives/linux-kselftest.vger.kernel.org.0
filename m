Return-Path: <linux-kselftest+bounces-31690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E2DA9D7FE
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 08:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6DF189A9E7
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 06:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4406212B07;
	Sat, 26 Apr 2025 05:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RHLucO5V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F86210184;
	Sat, 26 Apr 2025 05:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647183; cv=fail; b=a9ByCmt9NKKytOdBEnoSDIk0fVqJiKOzo8j0cKN/m3E/n813wK4gNAUCNi8ZwV3udlIXBi2gIqcMuuZb8qj9OAdXfWINQjXbI9pbKlXF670BiMZJYSPDE5KvGL/3UJANSJ/Jf+pKAxwFxgUV0pgnrLuBdX5aiRtsceVy4sj2yKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647183; c=relaxed/simple;
	bh=RJhY1vDri2f221cQinUaDRP/8QQFVcBglQOoeF2nE/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XlI0ZZodnGupe66XjRKN4K/C3HPKQ4nxw40RsAlmJeZQ4DFboW1pZMkgZjgrNvj8XxYmeE4kJq9GYkz1OUOVBZWfTaTQ9tgEykN8M4kyuL/WBMEEmNmxUEJsaRVQ3iGmIFcmYQC563WRae7rSIvsaKt7yYPjQQta2h2hAh40+gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RHLucO5V; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvsTejTuHhu3tll1e6cCNQSEf8STwN+fV0jKGo2c+rWwMx8aTuws8diT+VlyyLgUjE89kxCtT92gLwLBDFFcpgU7Ud+cRv0TkbIbIYXEUTqTmxeeBFtIDaIeXuT4vDU/dctaxmHMiT1yqrwmgCVwqkjEneU7RAjuJwIqlSzzSjMpBlcgg455Mt4pY8gMF0WZZ2v9x1xdjR4VDs1NwbJTM17w7ESuI+0NuInU+RbX8LJmP4t+8qwKe+a/Lj32FXEwZsNbbe1nuun9MJZib4PgSXG9YDTG8tQ/zCWD/hXkzjVDJTwDQfYuO7uH460bG7ZwV1dBqvLfyNsHYT89Tjjn1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0WZRoOLKxeCDsQ4GsjTSh9MDeplqg4FoVejZpMkDZo=;
 b=zFhQIkV4/5r3K6GZG/V7IQa8F8G21Nzk9IILDsn7nrEYgtIssYfyc/3nq7RQj6eLR5aS6ZmN2OIe+emmvl/B8ZpTttvh4YKSSPhkwnOSMBN0jCRTBb3nyf8bPC6e1zVCPD3A0s/1BtOkxG1eQSi3TjoK7UPKthxyos29GxcgtZlOOy8lVjYUEANKQLszolP/LQebbAahxcpYM7bfkr9/U2QoX8j4HaLmbo8Xz4ebSJnqderqUawWOzX1x7BvB04QUhEMdrOLYRusgQH8KLIcFAaRxrOxfb6KRCQAsG+UPVlfQYuWg5vgJ8R2sfVdmZDEN76V9XLIsGVrAoRBoEtUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0WZRoOLKxeCDsQ4GsjTSh9MDeplqg4FoVejZpMkDZo=;
 b=RHLucO5VTU60ftOb6bboL/C+kPObrWWd6gBktfEEg8bosll64kPb+Yb3SVVdWutw7ETcLUT7E6dMfqPoFJ0W25fSgGA8tuggJhLKcLhF5toHGWawW1yh75YeqU04LOhI0vHdodZ9dK3/AhMULOjoO0t/bh9khsXoJwl8sVeRKYPxu2IahZEnD+6jZcLcDlcmJ42JuCeHVUaOJZ84BAKsjAuY1eNrNvv7aaUekPMztnuamjccsMEckuE+btwq66kSvlVO8NCmsgTLRbwfFp/lwcT/EfIwvYwvStEBspB+kqXJo3q8s82FuN4hUHKqSUXDD0qttTFurNSwGX4vTeCdrg==
Received: from SA9PR13CA0044.namprd13.prod.outlook.com (2603:10b6:806:22::19)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 05:59:37 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::8e) by SA9PR13CA0044.outlook.office365.com
 (2603:10b6:806:22::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Sat,
 26 Apr 2025 05:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:59:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:59:31 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:59:31 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:59:28 -0700
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
Subject: [PATCH v2 19/22] iommu/tegra241-cmdqv: Simplify deinit flow in tegra241_cmdqv_remove_vintf()
Date: Fri, 25 Apr 2025 22:58:14 -0700
Message-ID: <7c180fb751def39cbc8634b08b65c3f26ad73833.1745646960.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745646960.git.nicolinc@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|SN7PR12MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 618c233c-b7a7-42fd-c129-08dd848786bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?76JKnOPs9EYaUnACeglQvLhAvLnPTElfwzkq6wUySO62p/R1no/rcbSD7I6c?=
 =?us-ascii?Q?KHwpfz31qS4uBo2AGTp+EoIfy9Mf/m2pr5CquKkNblRq5nOHALtSLDEoqmlW?=
 =?us-ascii?Q?liyXzOSAPadVfW8C+2zNsoDthUr1bjvBa0j9s1UrBaG6ppkI2qh55ivgcoqX?=
 =?us-ascii?Q?Afp4CniPqlJoESy2tyQUnK4p7+zEE1AW4fAti1+SWJv7sBpqEeN1uK8VzboL?=
 =?us-ascii?Q?MR9Uo6xWuFWLdfPhinQ9lwHE3ZEUJweJHpijYzpsaMRrEBW6NtEDpHChuIDx?=
 =?us-ascii?Q?xljOVItO2tjbQbuXImDC9+6p+QU2D68kzf6MHtPOjGfQqwbc4g6eKxaN1LDC?=
 =?us-ascii?Q?HPdw4rDR0u2au4U0gsLZtVv3pDHb1ecQZgeA4F0yeOpBvmVUscohF0DU8mtR?=
 =?us-ascii?Q?9PWH79fbMcqLL8ClBMCenJ1/X9BOAYuGBAqjUZ/cbpKd2g0E/Gm5DylKHyMs?=
 =?us-ascii?Q?IW2Cwr7JMtvL9te3t61GF0jZ5j8wZXEbSI43QL5TLOi4R/LhludbTgTR1GDV?=
 =?us-ascii?Q?cLozEmZ8o+Waob34DoaVHgor/7LqBzr9ScbhAVP+dVEx2C3SOVMxhFG/pcYu?=
 =?us-ascii?Q?sj7UJlJtgj89jKFxotyuLcG2HotYgdxZvU/yRB1OHdbs0I2Jo3OGnedUxPrH?=
 =?us-ascii?Q?91U0h/7JpYmmFNBDzstDB37nlugN+X8SBfsXG1G/6kPXd8r/MI7jCt511Sn9?=
 =?us-ascii?Q?1LUfqZcL0MuCAbM/kNr8DpxCEci6TYX6BdT13dVRL+12xDOLKswAQggkrfsV?=
 =?us-ascii?Q?1qZLcmgK//eQXiHdeU2cpXZovL8HIrg4ofphRZMMAyt3gqkxFAC5nPZV4u4Z?=
 =?us-ascii?Q?SnFWRSYhKynmc+xtLywva1xwFxVvz3E+XA9+KReXCkyO9lvFlR4kaibI3tYG?=
 =?us-ascii?Q?9K0fGg/vao7C3bOXQq+IdLkH8XhwMD6U1NU2TAGCl6KKS/X+EJTHoQCo0oqo?=
 =?us-ascii?Q?752yDy7RB8j0A+doSDyCVjbB79DyI/XvwqwShUTsIUVwJ/cg6Jhn7AjR4v2a?=
 =?us-ascii?Q?JrL3VHngNcp33aY6z57V5kIy/J9wJ/IrhbGCR7VRASKL6ueROE7+5PmaKn+z?=
 =?us-ascii?Q?u1VmLC3fmIGRMx3lkXkVUD5OoEO6R2xDYuxbkaFRUUD/LOpLBBN7HMACtzCm?=
 =?us-ascii?Q?a08uPlvgWCepw789t670AWiH0iz/z40mVOxUNgP8hAw26zEqcdj2r8GDObbc?=
 =?us-ascii?Q?0qomdM8pcieo97dz4x3VNqAae3PEXjDJLjexrRT3Axd5w6jjmSxewnDLVKxp?=
 =?us-ascii?Q?PrSi5Kh8KSX5Fi/aCcMX73fxxQGo8fR2Sv/0ziig94+rozd0zxthaXT63tSv?=
 =?us-ascii?Q?wgQBEcLR6Sp2QjNowc700NAxBL+2E5E/jnDcBv8eJmyr0WcYYnrLZW6S7iCf?=
 =?us-ascii?Q?7ZwWKG3YHeak30KbXUELewfa1sxRLnuhdizg9EmjumJ+x/QogBz3ExYscsUf?=
 =?us-ascii?Q?iYXdHre7K0ZIez6ADowXCIZ61uEqJ5yXlp338cJ8oy4XqphHLwNGxBBizQfR?=
 =?us-ascii?Q?VkoRpeGpSHKj/aA4X2tn8ik/zNegm08iibBH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:59:37.0950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 618c233c-b7a7-42fd-c129-08dd848786bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790

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


