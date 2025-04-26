Return-Path: <linux-kselftest+bounces-31692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F13A9D803
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 08:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8004A1870
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 06:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E671E8327;
	Sat, 26 Apr 2025 05:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mUzAJ5Pc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C651210184;
	Sat, 26 Apr 2025 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647190; cv=fail; b=AKzLFmObNCGvtwmankZyRzIgq/pxqJM6qhdIzLiyS9t13KBlMBxrSbGfjqXs+VmLN8OBkDEJ0oXMFlTLpZRJ3KtWHYNvKXG/cLwF1Jvy/NXmYWUn246K1dD4oUrm5xa+oHyPY8Bwpslf1lZBlQeYvssgplFRF+XyeMFBL6XS7+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647190; c=relaxed/simple;
	bh=6LSQYQcvhzwtCsu96D4u/EX4Qtno4E04eEVHcfCvWVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gY5ps4wNpSJQdZ+V7UkH8ux7TJRSEtZChKPGeKvwoqE5ltfO5JX9+OK+G4juSmdfTUJbAWpvUC4A+REycsJDj/kp8h2Zm/CUjqcycOhM+koN629FPUetLW/+fXOG1zUf5QL7F9laEtl0ESNro1+zxzDUKoHFAsf56/hdZGktNsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mUzAJ5Pc; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uD/7ng2Wy4GLDiHF7L88zW1ph1f3UTB39RJ7mKWPekx78ahe5nUykyIVRG5ZN5VRSID7X46KZSX+GtHbRCFoesCSdRf7lKeDzg0z9AL2dwmTen4w9nCgrV780ZRFDadmJsFKHl0EFP1n393N0782TUTFxOxpax+9HN0LLIj0Mh0tq5CYv9tDP3UxVpMlfzz7EEQ1y02JoOYDEMuXNTjnQaTK/s9+JFENjo5O78oqmxOmaNvCJ3ek5Jg52lZxL/Bh00LR6sLh+yxCk2kRaIv4JwNH9+yJoj9g36HtR2eyo/ojgV94n6xmMSw8O6qiuBcUqSFWYVPGuXRDAZFbL9f3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7KNBTbrifmbbvUx72GCKdl5cmj/mb49BmF431bILgU=;
 b=drA/LECrkOjwsinKzBoGQqsFHDin6YtUiXK7O/z92Lrhfp9j8qmhwuGx1kco0Vwfn/ffI7WU1YDPyPogy1WpmFJzhFUIqcivEwAnCzSQ4aZGNDcG+LBsAWmcyMMfLRlkqjPEK4boKWJu/9GJDEdVXi6EQzdPa5bNoQ13UmC8EgojtXvq0Nkl3cpvWn/TyOZj6P4KJn3VrJujFnJ8xo+EColfIg/61Axi4w1ZxkTr5FXg0Hw2DWORfGc3BEtn0v0LwCajdlIPBfOC4wyGp26EEDprNAlDOQpp7hKYngkVdMzuSGzhCIaUz3fQlM5m4r53MypWdRpUl/ohAIyMwU5CXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7KNBTbrifmbbvUx72GCKdl5cmj/mb49BmF431bILgU=;
 b=mUzAJ5PcjZG8OJcZr0d1BzqH929K8GN/eHF73DpDW6YeEZz1kbztITrWMpr6dln+Apb+u+Arsce5JbLj7q+2GzwEq9WXd/Ipt7onDRV52BgPJycog8RbxAQkGG9n1jJRuMjCAEjHwQ9izebBhBtRG9M/r7ige4FSe+cUkubxhxzsGU0j1Hs1GE2xPwkkKyo8hbozUjm09xH/c1bQ9aDYGR0qrgbgzzsFYcvj2qP1LeFh3xO6QVVp46oVXhaMW97/5vlo5ckYaD7yqDYfB1XgbegqVsx+tOcO0r2TJHxsSkMGGA4bhTrARZzN8O3NdAZYbISfaJRrC6XJQcvCeRQDyQ==
Received: from SN6PR08CA0030.namprd08.prod.outlook.com (2603:10b6:805:66::43)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 05:59:44 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::8a) by SN6PR08CA0030.outlook.office365.com
 (2603:10b6:805:66::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.34 via Frontend Transport; Sat,
 26 Apr 2025 05:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:59:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:59:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:59:34 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:59:31 -0700
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
Subject: [PATCH v2 20/22] iommu/tegra241-cmdqv: Do not statically map LVCMDQs
Date: Fri, 25 Apr 2025 22:58:15 -0700
Message-ID: <3981a819a4714b21d11d5c6de561a2d0c6411947.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 182e4067-b063-4403-f8cc-08dd84878ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DKVAvjcFkrfMZzNoBcsH8lk04ks+xKPmUXs5tj3Je9BvGU13Waca9CN995LT?=
 =?us-ascii?Q?vmf+KsPiWRD+AYqPoE4Rmads1qIERsee0qlE+2shuD8Cw4/d3yhoJshBLXZG?=
 =?us-ascii?Q?yJzJNczk8tlDQZc2zd0rlyaz1CAmiiBV26mQo6v4qha6YoHl4Y6tonsJQUW5?=
 =?us-ascii?Q?6DWTfM8Aszj0f6JBDMXKtNrNjAYLvYr4Oe5iykrvvWDt6f3K1UL1IEbOeN97?=
 =?us-ascii?Q?OiVp5DeQ7UPTEq/79Dl4SGvwcPrvVmQVlVeMWPpceewLxmeMD5YPPy6t14X9?=
 =?us-ascii?Q?PqVWOG6YK8MPT47h7hJzx9vaarGC9Th8RQTnhA3Fn/p47B3YTTU0FNTzgA7K?=
 =?us-ascii?Q?QRNRZ37QeRrMUmRjbrpgor9tUekwZ6a48+4AMqdkoxS3x3KYTCsqiIhcvbQW?=
 =?us-ascii?Q?n8JXNgK67zmH1Bmyh6VpREER89UioKJl/6ifE/mQXr/HlNOkpK8PL+x5IM+V?=
 =?us-ascii?Q?dJnRbC1Z4lEB0CnYFA/PIotns+5mFNUV5bpbZZrsuY2K9JEOiUnSQmxhyTKw?=
 =?us-ascii?Q?h03OUbhBvNIry08jL81MHKgIX3/UDDlZOXh8vlETCSDD2eewLa1sN421vthi?=
 =?us-ascii?Q?Sdnx9M9q6XjWxolBr/vS2n8UZnxNHCk3tEqE+Msz6QZtf/lCuNc1lXaZ34fR?=
 =?us-ascii?Q?P9Kv5N/Tz0jaak8gQ8dQOFrc4nSYv2z4oUJ7QTkAbVVdCznBPGzAUGDHITGL?=
 =?us-ascii?Q?YfcypeY4KCJEoPPub/OvwqrGMYTaM+iGW3LiHeUNj0//wAvpXfRYN0IIIeyY?=
 =?us-ascii?Q?w2gbYOkEhagd/GkmT2c2rH0S8WXgCy+J6ARcbQziTaJepK2hsfeD89tQEdCI?=
 =?us-ascii?Q?cDI+KdiYjVOzG5Oy6WOXAHX/dHS0PJgYMD1iAbC2uExp/7IBoyDoebLGpKv5?=
 =?us-ascii?Q?1CEDeowT4vvruxLOS0974RE9+2dpMVSSSHPOROxukEi0Uu5k1Hh4e7FWLhRa?=
 =?us-ascii?Q?56vCopKY3PVRxhhrkCHmtQ9BDB9SN2ikRoYnx5Up2ZDx8Dgd3yLfyJacp7KR?=
 =?us-ascii?Q?TSAj0RUo15ZrzqfyjkwBamoWSJwVW0F5ZYhVDwU7IDzZBHCBcXFYvD48n54y?=
 =?us-ascii?Q?lW9XMlsBENWP1gO3pw+3npBydsP2hhSZjF0owRnfa0d8cVNkJZQdUQuru85V?=
 =?us-ascii?Q?dGXqUM94xNDyyNZID8uJGONecD600B/0bBRPrd763OfEYjJYujzVukHp3XAD?=
 =?us-ascii?Q?tZBjszyIRduJy4a7Te68YUxmUKmlCZR6PBY5zphOnnktDdd8BifYjbtZ6QNd?=
 =?us-ascii?Q?mAgxNfifVQ7ECjavXlKRHuFmZqJ9Z9kUMn0WlSpmABhBz7wR2YKSt0PFrYOY?=
 =?us-ascii?Q?StRUpga6zDhDn9SdJ0bbJ7e1Uh3Ni52QbVBZxHmb/GcrZxQV0IM0Y44mZ67S?=
 =?us-ascii?Q?QWvm8x2veUVJBffZWzJM8/1i72pxpcfToUcf0I4q/Nk3NkEl9hEz8Am2lYg3?=
 =?us-ascii?Q?gOA2UtLcYfTop7sa2DaEy0Z/S6VdQGmNZehffg+VYkvxZrHb95NPoW+yC5CC?=
 =?us-ascii?Q?FigB7giXbOFw9ATO8G878BwZoxX2zQLs0DMq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:59:43.7639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 182e4067-b063-4403-f8cc-08dd84878ab4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488

To simplify the mappings from global VCMDQs to VINTFs' LVCMDQs, the design
chose to do static allocations and mappings in the global reset function.

However, with the user-owned VINTF support, it exposes a security concern:
if user space VM only wants one LVCMDQ for a VINTF, statically mapping two
LVCMDQs creates a hidden VCMDQ that user space could DoS attack by writing
ramdon stuff to overwhelm the kernel with unhandleable IRQs.

Thus, to support the user-owned VINTF feature, a LVCMDQ mapping has to be
done dynamically.

HW allows pre-assigning global VCMDQs in the CMDQ_ALLOC registers, without
finalizing the mappings by keeping CMDQV_CMDQ_ALLOCATED=0. So, add a pair
of map/unmap helper that simply sets/clears that bit.

Delay the LVCMDQ mappings to tegra241_vintf_hw_init(), and the unmappings
to tegra241_vintf_hw_deinit().

However, the dynamic LVCMDQ mapping/unmapping can complicate the timing of
calling tegra241_vcmdq_hw_init/deinit(), which write LVCMDQ address space,
i.e. requiring LVCMDQ to be mapped. Highlight that with a note to the top
of either of them.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 37 +++++++++++++++++--
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 8d418c131b1b..869c90b660c1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -351,6 +351,7 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
 
 /* HW Reset Functions */
 
+/* This function is for LVCMDQ, so @vcmdq must not be unmapped yet */
 static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 {
 	char header[64], *h = lvcmdq_error_header(vcmdq, header, 64);
@@ -379,6 +380,7 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 	dev_dbg(vcmdq->cmdqv->dev, "%sdeinited\n", h);
 }
 
+/* This function is for LVCMDQ, so @vcmdq must be mapped prior */
 static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 {
 	char header[64], *h = lvcmdq_error_header(vcmdq, header, 64);
@@ -404,16 +406,42 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 	return 0;
 }
 
+/* Unmap a global VCMDQ from the pre-assigned LVCMDQ */
+static void tegra241_vcmdq_unmap_lvcmdq(struct tegra241_vcmdq *vcmdq)
+{
+	u32 regval = readl(REG_CMDQV(vcmdq->cmdqv, CMDQ_ALLOC(vcmdq->idx)));
+	char header[64], *h = lvcmdq_error_header(vcmdq, header, 64);
+
+	writel(regval & ~CMDQV_CMDQ_ALLOCATED,
+	       REG_CMDQV(vcmdq->cmdqv, CMDQ_ALLOC(vcmdq->idx)));
+	dev_dbg(vcmdq->cmdqv->dev, "%sunmapped\n", h);
+}
+
 static void tegra241_vintf_hw_deinit(struct tegra241_vintf *vintf)
 {
-	u16 lidx;
+	u16 lidx = vintf->cmdqv->num_lvcmdqs_per_vintf;
 
-	for (lidx = 0; lidx < vintf->cmdqv->num_lvcmdqs_per_vintf; lidx++)
-		if (vintf->lvcmdqs && vintf->lvcmdqs[lidx])
+	/* HW requires to unmap LVCMDQs in descending order */
+	while (lidx--) {
+		if (vintf->lvcmdqs && vintf->lvcmdqs[lidx]) {
 			tegra241_vcmdq_hw_deinit(vintf->lvcmdqs[lidx]);
+			tegra241_vcmdq_unmap_lvcmdq(vintf->lvcmdqs[lidx]);
+		}
+	}
 	vintf_write_config(vintf, 0);
 }
 
+/* Map a global VCMDQ to the pre-assigned LVCMDQ */
+static void tegra241_vcmdq_map_lvcmdq(struct tegra241_vcmdq *vcmdq)
+{
+	u32 regval = readl(REG_CMDQV(vcmdq->cmdqv, CMDQ_ALLOC(vcmdq->idx)));
+	char header[64], *h = lvcmdq_error_header(vcmdq, header, 64);
+
+	writel(regval | CMDQV_CMDQ_ALLOCATED,
+	       REG_CMDQV(vcmdq->cmdqv, CMDQ_ALLOC(vcmdq->idx)));
+	dev_dbg(vcmdq->cmdqv->dev, "%smapped\n", h);
+}
+
 static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
 {
 	u32 regval;
@@ -441,8 +469,10 @@ static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
 	 */
 	vintf->hyp_own = !!(VINTF_HYP_OWN & readl(REG_VINTF(vintf, CONFIG)));
 
+	/* HW requires to map LVCMDQs in ascending order */
 	for (lidx = 0; lidx < vintf->cmdqv->num_lvcmdqs_per_vintf; lidx++) {
 		if (vintf->lvcmdqs && vintf->lvcmdqs[lidx]) {
+			tegra241_vcmdq_map_lvcmdq(vintf->lvcmdqs[lidx]);
 			ret = tegra241_vcmdq_hw_init(vintf->lvcmdqs[lidx]);
 			if (ret) {
 				tegra241_vintf_hw_deinit(vintf);
@@ -476,7 +506,6 @@ static int tegra241_cmdqv_hw_reset(struct arm_smmu_device *smmu)
 		for (lidx = 0; lidx < cmdqv->num_lvcmdqs_per_vintf; lidx++) {
 			regval  = FIELD_PREP(CMDQV_CMDQ_ALLOC_VINTF, idx);
 			regval |= FIELD_PREP(CMDQV_CMDQ_ALLOC_LVCMDQ, lidx);
-			regval |= CMDQV_CMDQ_ALLOCATED;
 			writel_relaxed(regval,
 				       REG_CMDQV(cmdqv, CMDQ_ALLOC(qidx++)));
 		}
-- 
2.43.0


