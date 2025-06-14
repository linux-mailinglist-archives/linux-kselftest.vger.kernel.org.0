Return-Path: <linux-kselftest+bounces-34999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9BDAD9AF2
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136811BC0468
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4CB233727;
	Sat, 14 Jun 2025 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JwdhaL7M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7A522D9F7;
	Sat, 14 Jun 2025 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885359; cv=fail; b=jKLXEhR9WDBaJCSwq0PLcbvim6SaVPSxvR7QrNAubTOcGhm41AQBOxv+4y0vNhNdgDrTcDdWBLedvTmGOBy3y6R0JTEjH0UQmCS2B7ktNqh2TsOHdt+rh03MSpTMZ85Zww0khkBUfbnQkbaAOw+KSmMDhm+Yne+4e5dZ4bOiSsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885359; c=relaxed/simple;
	bh=+uK2P4l/Nn8YbEUAgGImF1oImu/1IUfTVdUVtpGoVy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEdIrH/r15qMER1c0T09Ta6UVDKi4D5PSOCwx5tbyEAEtM4CO/eYDw3+al1LH+w0GQIkiAlhAthjDji/bhrsxC48cHTtXjOd3fNIbb8ixxG889Q8yGhFPHPMNta2pDrWmJ+tcA8no7T1z16K0ODEnJM9iKJhKd/zSPz9OMrV8Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JwdhaL7M; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUNEl4XNdkGp80bPoixicKYwwuOVhXVJTjTQDC7QA/3C0JgaqCIjTbkBnlxGKNJwJqT8KrjQsJt9vUhd/yt8AwQ1GV/7osuZQmigQ4+hK/ZQjr/vvbpRyy/cXPfpPynGNKzoaevPa1f+IHySMvokhrz8JBJhRxCFfxShwQXY+Dp9MxHQfuGML/JtNESLpcUt5ncAmtmDGrwczmMJEZ+E0wuqFIgxKXNjrgeiJsFx42+xIDFtHlIfc08tiu0v1UP9V4/2G0Nz10lc/3xKjj1XFMPWqqIMqdaaSLU4FsufGyZJt0OSm1UAbGpxg/0VcqMpJZbgag+6h34RiLJZAs0hiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ETVyAEu+mCnw7Aoo8sghtHkONxhtFSL8TYuVFAPM7A=;
 b=Uzhypl0Yvn0g8qmvNDHwX1OnW6yKs4MKoobd85o1B0z6IXcsgkSvT4eKrniJFOD5RwlWCtcHmMbcIv1TKE5yK/n4iMzX2OkldwAvIeR/YTupnPSfIFeJ7CK/o3vHH8ziw1EOMJskTIXFNVLGgeJmhBPM1WasApg0CUcoaCKxaVJsqomAAZJkyGMQBWhUzrcJ6XqFujy5m26RUBHAjyqS4P9DLhWHnEZxcMdtTKuuUSjlimif20nugqfx+bju5C8NvWIYKff1AQOwuDVTBYFRdocWMNW/Z+Ma5zHnakVUZlO2owu77BYDZBi8PzZFxoTNrVXmMBlCSs02sZNpu1Ujkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ETVyAEu+mCnw7Aoo8sghtHkONxhtFSL8TYuVFAPM7A=;
 b=JwdhaL7MCgP+qgc6ncx9qSXjOY3WQaj0M50Sv1W8eozrLyx4Tq1l+pAd58WjWfpPvanNjgc6ud6QTx09Fe/UUZ5JBtWrOObFCDEaUlkbWmLOlegXxS8xC7Cxq1InsgDOpoV0eyKctlYM0Fx7yHsw2XY7glcVdlqPzGo0iFk/+piy3H/FfntYh4yVQaeJqmleK3EF7XySSgUUbeVeLycNYVOQZN/0Rub9KWUH+pESTEkd1xybGYD01hO1LZwUlKLZwIVuXBsIWpec32cUshDGI0w/JApSH6rykXImWqsnvLK0McCzX/aP7RKnd5MkMgAjELLWzSXirMgi5nLRZZm/rw==
Received: from BL1PR13CA0387.namprd13.prod.outlook.com (2603:10b6:208:2c0::32)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.22; Sat, 14 Jun 2025 07:15:53 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2c0:cafe::54) by BL1PR13CA0387.outlook.office365.com
 (2603:10b6:208:2c0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.18 via Frontend Transport; Sat,
 14 Jun 2025 07:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:41 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:39 -0700
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
Subject: [PATCH v6 22/25] iommu/tegra241-cmdqv: Simplify deinit flow in tegra241_cmdqv_remove_vintf()
Date: Sat, 14 Jun 2025 00:14:47 -0700
Message-ID: <2a4e9a40715109ef66957e79e7d021e505cf069a.1749884998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749884998.git.nicolinc@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe1cd43-a7ba-4ac5-7852-08ddab134c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0qOnL3+xaNUrsHmhMv4ROi+As0n4lYUEvFXPwTRP0+12YsXy3H5UAiPcBWCx?=
 =?us-ascii?Q?FolIMwrGIhwi42jQ3CA3VkbLeIivcMTaNs9rXI2gQNWAZSUExrfdCxjpq55N?=
 =?us-ascii?Q?SpLSqSLOVaUeGHPxDIAuk0X9XKVzevWhTNEDldPpD4+QMP/lXIztqcLv9wl3?=
 =?us-ascii?Q?9QrVWD+Ne+YIRiVPtxh1YLVNozhfxuHFvCLPDHX5Tlp7poWgQYV+nSsQYsjJ?=
 =?us-ascii?Q?zsY15goSTF/o40lFaTNdeCVFhEZ9gOZ8kWnCCCPyH6W4Vmbx2DRJ+0gKaDcU?=
 =?us-ascii?Q?S0YGxVtdf+DP7F9uOGeXffw71HqDxGIVqRpzzgY1CPLF1iyJJlW/kb+8Gp8s?=
 =?us-ascii?Q?YpN8D3ZwWxR+nTy5VPDynGCMslEGY9JqaEby3Acx2QQHIUk6F+R5i9e4s7ru?=
 =?us-ascii?Q?UMSOXnv13VCuxYJ4Y1Apm9WK99SLpjpfetHGP80NrP3kCIsqX0guRs2JHqsh?=
 =?us-ascii?Q?BPZnnbsNvIRcEw3WJJcywDW4JRrsF0i6qQQxODE4ZUIlcsPKbXXqFKETn9QL?=
 =?us-ascii?Q?6MUk76I1RhvE/7lpcJuzO4aub+Bn3UF4VZPrDG/OT0LtX64DeyPgy67xV+RO?=
 =?us-ascii?Q?jyCyQoiDMRe3wROce3zZI1nz1wXJwRBxLAEBVwXgdWCJW8jDIc7GSn1ICYFf?=
 =?us-ascii?Q?qxow2qjQ025J/jYrR0ncM6osg0+P/sdgdJ/J6ZqvmnSlIBJaeAGa6EDrIP4D?=
 =?us-ascii?Q?XhArgk/9s8EY1xtGiIGkhgyID7T/zilDTgqUTYSUIWBLDZ6NFF9vfvutzd3N?=
 =?us-ascii?Q?AytpDixcM4Gi0Zem6OP2Lj1wNql5+NTg1JZSHOHEpdIvprBPpkWi5tEw++P8?=
 =?us-ascii?Q?plqqzHMoMbMJrrIK09zctuaZ+CPspBxOSSSB7yagtXoVij+vzzafGBl6FBWl?=
 =?us-ascii?Q?2QCotkSKddvHJo8CVkU7iWsv3m0diy53vUW7EKOeQPF++SOq0EEWJVGoTLIC?=
 =?us-ascii?Q?ixlGBC9wluqO8fXY6S8RwnQ/UdUhudjLQu+4KrGw1f0B+bjpVkvGF/g79d7e?=
 =?us-ascii?Q?lQl29QoGlGwDRLD5+6bzPhqMgF+gbBDnGcwzdv7idyo/d7sVpORkRhaRSBeJ?=
 =?us-ascii?Q?VlEJFJr8NjQr0n/Adj4Xwt6jzs8+o89LQgDuMyDpQ1EcI27C5Mc/MeGZrc9e?=
 =?us-ascii?Q?nEim+fA+eMIs5+rffAbKA3R3RSJKz7umnhdNHLI0XMGUv2HWf/OlEUPIHEej?=
 =?us-ascii?Q?PKqkmk6fFjgbZVQQT7uPva1+Sz9hGpDxhaM2Nfaa/wSWUrspuUcdE1DFiJgt?=
 =?us-ascii?Q?0QO7rqMksOu6ctbgIQJpei9we3CPe1gH47fuk7c+FkseKj9CuKydcoX3zyiz?=
 =?us-ascii?Q?sFnZbUPPOPaRkZO3lZp33ZRjOllEiFj9o5tFkQaazZHZwyTVZuniz3XybVDg?=
 =?us-ascii?Q?n+LzAlcn1nAqwV2vEB6EsbpNRgbx8GIvrsknzdxDCqRCLvkXBxFHXBlHyGcv?=
 =?us-ascii?Q?RWj+HulbProjWPfh4hGDyVLsG85lstCCyWheq2FeBnXJaG628lEgFuO39ZJC?=
 =?us-ascii?Q?gaIP1he2onBi1/t37vOqPigXnqamq5Ool5Un?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:52.7005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe1cd43-a7ba-4ac5-7852-08ddab134c48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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


