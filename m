Return-Path: <linux-kselftest+bounces-36635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4290AF9D78
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28141884B90
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1242264CB;
	Sat,  5 Jul 2025 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iVA0vD4J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB9198E91;
	Sat,  5 Jul 2025 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678093; cv=fail; b=AFkIgntPtGQ4hE6ti/W0KLlvg0oiZAmkzk3VbeQFIj+3q9/UMZG+8nyQqFRHeXpz/K2WxElgEbOQgXQcw+tVo221a9lRZXg+i9fmrzGAJECYNkZhmJeHMjEDJqD7EoM2FjL4AEs0bKWFSF1bZ6k5zP7m5tt2YRx18cl0enXZmPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678093; c=relaxed/simple;
	bh=+uK2P4l/Nn8YbEUAgGImF1oImu/1IUfTVdUVtpGoVy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BaNyMnhbiRg+0QdIbzYr//C6WkVaF7NpmV6fOCTn73J10MYpT/8FAG//1q7f2fRXtIUbHNSCxUi69iMsYYUfV4/BTjNzYjKNkSaNPodvshakjoMMqBqCOgyvg6Q+k1INgZafGvnHTGYWbkvGQqVu2ptgHH0wE3A+XLfiK5BypTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iVA0vD4J; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKFE4oU4hALvl2MAtmyWe26mzRcnaD1uNFe8n+UgSe0dUx1tI7hyYWvj5D3EWH7gAmOgW6yQNTyIi3uv1QjxMHCM9oRzAgSVncfPFW2mBivoVOG/OUQugNnwhy9DdZ6mN8LbjLnKPVVgQchtVn/u3CNZ6f90FWzJPeJfJWGD3NPmPkgu4oBAJbhkXCXw2XETIlND/2ORHu9bLVqWg4N0u67QzMUbCv/s6pbyEIAeBrV2kmGiDlVhsFj+FIjT22LMFjGWJkW5n7CplHW7UXAj1e4i3Rm4vQv2ATk0PrbDyJ54XUlxi5cvS4kfGX/Pod+nM5UqRb3ps2bzUOv3MO5LGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ETVyAEu+mCnw7Aoo8sghtHkONxhtFSL8TYuVFAPM7A=;
 b=sDDPdkmK1HQ60K5+eevYWgdS+DTI9QVQnn6kDa+8bizzwVknehwuM+oR/Se2Rl49Fti80DxZV5FHU48FGBUCl0NHyk2TQzNc02S4bAj9gdMyLvcR/tzyQmeh8cfYV9iBUySM7k5tmMiTX5oOXSweXHWjqB0oODQWR782XQp9T+qqxWTjVGbFxVxVVCTvXahTj1OOKKQlUPFsCz7OEG5j4HKJ5/e4Sx2G8ygCYuXRsj+9k3AHpvFsL3ZKPCh+Twmn7Grxizd0ovcH0Kpzj0AG0pD04ZyLtGoRoBDSoFTVD8/a4EweVggIIxtWrbubstD/ithuH+2vI+aK0DKsHA1zVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ETVyAEu+mCnw7Aoo8sghtHkONxhtFSL8TYuVFAPM7A=;
 b=iVA0vD4JpIoAZIVa3xQJt3zILi95LXtG5RzVyEgCR2NDZ83IXMmdNMW1kDV8nphjNxh1sfZe1AKm+jl/yAhofIwB3dwu6nMelz6MibcS/PfjHuTdY4dwHAFmltvGApcUPydktzULByBU0pDq+o2xg6gtTC9DpBDAE1T8BPRDOHrl0NiYicrZI7W+GoNKf8l6uZm5JLFCVikPJmRBjGoNqmFUsqk94JFMca+PCpggVZsUFZXNBmzsCSd7cTJLQK0dgvnu7tsz9C7Cl3aMZA15IA5tj4ApEx+3D5X33YehXbEMXMSYgabCcV4DWuKxZ5MDyWFAI7FCnwHFAP6/+Y/JOQ==
Received: from SJ0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:33a::24)
 by SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Sat, 5 Jul
 2025 01:14:47 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::5d) by SJ0PR03CA0019.outlook.office365.com
 (2603:10b6:a03:33a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Sat,
 5 Jul 2025 01:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Sat, 5 Jul 2025 01:14:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:34 -0700
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
Subject: [PATCH v8 26/29] iommu/tegra241-cmdqv: Simplify deinit flow in tegra241_cmdqv_remove_vintf()
Date: Fri, 4 Jul 2025 18:13:42 -0700
Message-ID: <95460e3eb25002c79308139725d689591d4bd2c6.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SA1PR12MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: ce293252-2120-43bc-3e36-08ddbb6154ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y/okHwNsaPSX04xkqgDutdWEq91TTaJoOZ+3U4jPXJmhIEBbFKPT0hmIl/Zk?=
 =?us-ascii?Q?faRvJnaG16xv+siomactThL4i8TqZd1afqPI97L3zvWXWvte79Op1FH4x3Wq?=
 =?us-ascii?Q?Gg2G5EnIu6y0fpXrksDXk9hTRTb8/p+GuYiHCPPq7KNq3pM5qvRnXBdhFmX+?=
 =?us-ascii?Q?A0y1E9fVTiowfFm6kg9CRcx3SouDFg6ZjiT3JfkKGJpsxTWCYYnEXRcSd0hV?=
 =?us-ascii?Q?YG93itgP8n9rFzCOCRs+uMAtT/TVnCb6JbutPB+EUN14FWMA+bgDfkkUuHc5?=
 =?us-ascii?Q?M/uMc39juu1ifvQwvpTm/tqAOTbMG3LYRQCyy/XT2sl4bkFLww3gXOeapY0/?=
 =?us-ascii?Q?mTtRHVxB6A5IYfN5lkW9X41PweNF5MAy/CmPRly7r/tutDNhrnT9W2I6k0ut?=
 =?us-ascii?Q?if/c1M21Wcpi5YlENXqHrYQ2XknL1E7W2eZ+IeB8+qG9RxxkPztJY82Vxrun?=
 =?us-ascii?Q?leiR+Q1HOvLe4F/QJdzeE3/Zeu4P3Hp9Wdv4TbD+BbdKplgzs5HYxyWSzIUi?=
 =?us-ascii?Q?3NZPlwUwnCxQbl6JGr7UwtYt7zM8zSw9n1WJlNPhqjaa2czH15kCW3U+7aOf?=
 =?us-ascii?Q?Pw06CMlQQypwCpPm/p1f6BREKwOMnEdSc08mgZxpkOspj18kzWtdyP+H3WYX?=
 =?us-ascii?Q?10bpOH0i1paCW7W+Zu2OfP+HCdFQqcvxLQNZRvjYvH9Mkj+/Hz/HZTYMLrW1?=
 =?us-ascii?Q?VwQpiU09pNm5KQIMJvNTgWaQ/CzTTyrp+eJttjFBPSpFguYcZpnYL6ncUZEh?=
 =?us-ascii?Q?TSNRaiYfIQJtcwb8RIXigE4XuT7+mZa3RmxDk7To1+KlOTEf4eVBDTJ9HfIB?=
 =?us-ascii?Q?G9lAC1+H2Xawffciapp5Lh77Qn37YDWwNUQBhGExSqVYzhptkiVKtep/GGYk?=
 =?us-ascii?Q?bhU6qyJSMVNn+v9sfgevVuRk6JtxEMCN0KS/6awlQYVW2f8c/70Ki0rqjw89?=
 =?us-ascii?Q?+hno9bUSQpgdh0XVmXW5bpNkubZz28GeurhIZrVUTI7LpTJn/o6DFNTp3sRH?=
 =?us-ascii?Q?tT1GE2cKmk3an1cfFbcqL5N+3Wd/NNraXn32beiUmPYz5koB7Y6YttqyAI5c?=
 =?us-ascii?Q?k2cgylj+RsFK6Xcwd+0wHvURpnqJiMU3eH5IeNdQPMj12BCR1JdNsN3m7w2r?=
 =?us-ascii?Q?VVt/UDhNsWXoGtXl00821RTuUs3DA7IZdGaibmc8iUG0ifWKpoAQ96NoFMK4?=
 =?us-ascii?Q?aNEwvmHVP7tYhOYBj1Ipxr1dEl4vRhr9Q/D61sukAXpzo0N2H+itaMPdgK/y?=
 =?us-ascii?Q?fAT0hl70Wrnee9QPnNFdLYslGJKYfIX0vq5Giu/B69UNvqSTpIWCr8XLCA/V?=
 =?us-ascii?Q?2CBjQGt3bVt0FoUjki8nj4YhaIApOmc0U2hUrVVfeN+bedgMY8vnL7eBwAFB?=
 =?us-ascii?Q?/0v8rG1qaONl2ANE1+grQ6wJVLVGxsyt2iAmzU3Pf3l2Mu9+lNLU9E9kaMvA?=
 =?us-ascii?Q?aiHqRXPZqJdHsSDGALrW5TqVKdPxDHtjoF587rfB6XaCf9P6qJS0GnzyKBQo?=
 =?us-ascii?Q?9gmZRrZiyzt2yIc3oin/mGQksQKysz847wmT?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:46.6680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce293252-2120-43bc-3e36-08ddbb6154ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119

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


