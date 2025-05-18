Return-Path: <linux-kselftest+bounces-33281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C68ABAD90
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB18580ED4
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157323507B;
	Sun, 18 May 2025 03:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UA/COMNn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA40233D86;
	Sun, 18 May 2025 03:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538586; cv=fail; b=c9gNXiTt+61j+8fTJf/hSWwr/fpZvp/qdLhZ9z6JQDcSdwhVfEFNnz0zrSZ2QGvgcMfMhF9ic/hVVoltLeG9J5dPMmZARYnkAjHHICsSBWOjQbVLfT37lrQh9U9vWIDGnUzTVZAM0ZYdKdyLMCghJqasAQ3dPeeXbxL5psRVuYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538586; c=relaxed/simple;
	bh=+uK2P4l/Nn8YbEUAgGImF1oImu/1IUfTVdUVtpGoVy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ej7VkkLu1NbmQRs9mV+LAdk8XU6jucTZiVgPTZB1DdLd+pt3dsma9a8CKkiye2EXB9m7K1ZgjbGOJbTEraMT0rN+P+QJliPiKmZmRbC5ChPinIYXzJq54a5ZggMLG1vTURLjonWlh0+JHCUWdAxCfPsbMvlRMv/HWyzIF3ZBvFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UA/COMNn; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPKbY2kQMkGV6yDheB+Imy+V3iORcvI2yxO0eMYbs/vL2jE+V06QN9TyVo7baV1A3KTyc1eR9yECiyoZXe9BK+pYFLScKLQd1Sl0PjrXy7oC5WzVgKour3K0zXkQULRPcHKBTTZT60axo4h5Ge5Rml1vd9MrEVbExKvty9AXYnILnMOQddGKjIEfnPMOS/4U0KDQMht40QYxweL+XTy/wKJDIkfegndHAYi7BR8N28A4k5Jd4JO73/V+E/lYMCg7q9woax55CYxveoFlLyf8EiYa/0gMFkMiNwMJAJzvNL3+3RkfKC2NaR5ws7WM2j2r2Im9OPhCF8y76+oUeuCvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ETVyAEu+mCnw7Aoo8sghtHkONxhtFSL8TYuVFAPM7A=;
 b=tEj3vthB3+FZPOYCVs4mdqNT6NN0UtushrY9f0L7kscbXnYHvUehtVfnJUIjOhHuIonVwhryytF9p79hneeWNJb1I0nU28NSzj/r8bVtkAneAqW1hRrb1XpisRqac2U3dJJHioTAl3RwWBgvX3qXZSw5LHMhKDCHw9CMBJYhy54Jitxaz3CF6/FwMun26Y2KB/Rxx/7tSzFOi0jtcSBUzmvHPQ2MN6k9JNOcZOmVQFThCQVt5RsWDfJUl4pElbZmzTDNr8jGmnnqM5A7n4ELNQaEVbjIWKNp6qUJFHoW2tCs89Gs4oTiVVhC2N0fiiecrAFIg+53Cf8xvtX7igzR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ETVyAEu+mCnw7Aoo8sghtHkONxhtFSL8TYuVFAPM7A=;
 b=UA/COMNnSSkZsXISzRRdb1w7ENQTVA8Bds0Pv8Bb0a20Dp6Ove54/GPRfjijTgq4p4Qhed8Mshfd/xwobE++Ty0Sq8yhTTyz+NqgvvwdbfKv5FWHq3fLSaKtGgVfycpiqK9QmIGwEN3IzrQ0E5t9nL4B9n0nwqhweqbtqP1VEnIOWveI8hljVlOnhpELErcar8IIQXHR7pVJElw7ZBAYaTB0ICorcyTiRltw6HYXjW6UD21TGwhaBDIIN1z1JsRgSztEnzIqRuqTkM6F3APcLM3sxUNtcwXQ5/mudCojFdzKxGyfz/6WohI3+HoMe/7M5TspSoRnCwxQER3ygs2vrQ==
Received: from BL1P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::6)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:22:58 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::2a) by BL1P221CA0012.outlook.office365.com
 (2603:10b6:208:2c5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Sun,
 18 May 2025 03:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:45 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:43 -0700
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
Subject: [PATCH v5 26/29] iommu/tegra241-cmdqv: Simplify deinit flow in tegra241_cmdqv_remove_vintf()
Date: Sat, 17 May 2025 20:21:43 -0700
Message-ID: <bb100f7e5b93efba91e852b23f4f94fe3e9fc91d.1747537752.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747537752.git.nicolinc@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d50371-9361-4db6-6f52-08dd95bb4966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7161VvS8Jafh3mmnexTDciULIV6L2tlzeLcBP7Riv8JYrJAozjFAVsJ7rSRM?=
 =?us-ascii?Q?fLaMySCp6PKsSkLgXKW6iVt36j9+GzvyiniJrrv2FjNPaD/0gUQLKoujeAU0?=
 =?us-ascii?Q?hgfLCaxnexAhDgpfBxrujqnjU5mhRysi1HgQZy1hps3ZxBHP7YdzbaizLgd4?=
 =?us-ascii?Q?7+eahTjLSulqY5HG41R1dXBEpD1ASQpOmd9BmA8cj2A+PtXA0seKbOaEAbeW?=
 =?us-ascii?Q?jVXea7pQ8yXjkcsCAwxckh4jt/5jYLB5d9/ZfGxXFKf2a3K4eZrnQdsRdbQO?=
 =?us-ascii?Q?D5HjJMVx1GpSRlP0D+g9lxXPJqqDsO5AZ26P/wQmzhZzPokklFkm5fIbNnXb?=
 =?us-ascii?Q?/x2prEirnYQYxqkYsjMIvAtz1SqLLuEQhB17JHIxTImrDPLuVf3xrlQUBj/+?=
 =?us-ascii?Q?A9GC8HQ0WcJwzfuSzq7kRrbZExulYdAQU14xhbTPAE/stL89/EEDT24+Eh3Z?=
 =?us-ascii?Q?vxuxoDmbKO4vromDJ4IUGpRE9wrDJr0fQ4u/OLoSf+UL2j/AucS/9e/r5Wks?=
 =?us-ascii?Q?mLPmu/JZyarq8m4/5voasMXCVkettz+E/kumqqE9BTTYWm9R0gF1L93Hw6dp?=
 =?us-ascii?Q?T8QM8qvNli9ZAWJW9TSUKH3rdTnLYWMdDynIqzyApQvk7+TD2nenuRA6LuXF?=
 =?us-ascii?Q?kR+547hOkYeP9RMNllSnttzdTk+z8XX0mSW9QUadp6/UD4JJRYh261DnGfTW?=
 =?us-ascii?Q?4wTfG4v/PYFoEGYxrESpRSdnC7sYKTI1viXVT0+TDJfug7W+b2UtvDKz24so?=
 =?us-ascii?Q?Is7VvH2/0EI8bXrg0eVFQbvtap9DkPJplQjiWzxuU068JBP8FQXLNC0j5hrb?=
 =?us-ascii?Q?rIJ+AXJEx82y8mUm9Hh3A7XlUpeB3nDIhA3Yg4bDVWrIlg3P2ixSssQ+TJnT?=
 =?us-ascii?Q?/0Y/QT2n/L+V+jC1Eef6BaS89zQJsRngESs8jT//Ay9dxDLG43LfE9o+D1Lc?=
 =?us-ascii?Q?e+T7Y77q/TvymPWc5+fpw8QvB8/TQEg4iPQh7p5MNSZp4RbcuCHyvWm3W8bw?=
 =?us-ascii?Q?IFaN/ndoHEofIChGOZykCKgkvkWVmoT5CtwR5tmLVxOq7xrOoX9HUBjcRkif?=
 =?us-ascii?Q?p+98rybqfqG7Ywk4cv0y/+i/6XfVu2S5KLafUKjxwa+WqiVXpYAIfa6zsSXr?=
 =?us-ascii?Q?DO6ysVxiU4fM5CUYqW4NgW1T9s0L/H3022XSb684Ymmw6PQirMg2fDr0RvPr?=
 =?us-ascii?Q?70/Or1JVQD8YR5aVKDvCr5PUT4rHuv46Dj1LqN7QhSAdtHvscRMYlCJYxqUi?=
 =?us-ascii?Q?HC4SHrA/8zct4cpNo5Qfk8iBIWTl0psBqpEuMihe0WhYyZyX/WAX6Z6ftIEF?=
 =?us-ascii?Q?vbBGPL8mbfnjwJax8cMtC0MlnK+O4nLxGxANyml35CiJsx+05pZzj7EIAZZB?=
 =?us-ascii?Q?oA98dp0sHw8XN52nlwWC/DGojhJP2iQoSNv5nwdbdaoTsyor7lQJ/auPPwty?=
 =?us-ascii?Q?eyWrTooILL/zNJl//wZFw2i06YgizYVsz3HBh5WWvSisfFBVIzzHzWD+C3yg?=
 =?us-ascii?Q?IZDmK6TnoE6jreE692QpSzxBW8rtrLVdcgGT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:57.7340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d50371-9361-4db6-6f52-08dd95bb4966
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181

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


