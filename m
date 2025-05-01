Return-Path: <linux-kselftest+bounces-32132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 892A6AA6737
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBC33A8E4B
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0C127F75A;
	Thu,  1 May 2025 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KIOozoVH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F2427EC69;
	Thu,  1 May 2025 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140568; cv=fail; b=pRr9N1EtWojlDG99N0uepzV/yDE7/85+A3Uvld8x8QcFP97/JFW67A50chS7C1CJGderbnrOT3O8yDDFg3uUYinTtGlEeAy4bO5nb5Du/+cjES2+P8WJ4m+Qss+xG/6pndT3p4CMn4Bguug6GyV8poGLDddo3AgEWvXJWSevuF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140568; c=relaxed/simple;
	bh=l3rd5anfUKoVXw5XJFoGuDEam0aik2aAGJF4VzktPP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlLdKglY1M8zFVQ44A/4B2Umu9tJ8s34O0PwoV4gXxLlP6iAITAoA0/ObbWS4qBGHeOnpja45TJIuPQ2QQf6zMB5iBtSsahcGjWl/XEbygil7KMwzDWqRYjf8ABxDojhxhixJX2c4epF9CtD4zWPRHH58icSo4mVW+GtzJqqXL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KIOozoVH; arc=fail smtp.client-ip=40.107.95.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgNwizvhuAzCyW39fiY/ENHymnhUAJjQgg9aEdAbxjYx6anBjsFur4wrnfp9LNxtvofVDIX+mXxuBWPsXr+FHpb0B08M/0nIq1dcPDNMk0dCh/Cv0bHoQRJBGjhjRhTNBBiMeG5IWLMUePTzJWdZHfyeUoRysL1AiaDlfsbbSODtrLNHeYKeQn4a/j9D1arf+U1buw3Q7PwyoD1Jhox5DpzhIe/xyC1y4zF9PUQZaqyAJ7b+9BNYkF302+rngJPEIIvwWoeAhQMb//NHOjRcm01Y8iG0g3+g9mZLAshawcgzOOfOj4vBX/98Jjr2MXsTRu11sARq7mG3AjFlhbZ9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtZ2mFoQ9hZw+sCYX1rCAZ+SM5r81951jUIc5O1KorE=;
 b=BSqAtxf5KGRv0tvDlsonmqHLc9ExudW3xxDR6gSarqv247f2R/yEAlIM7qOv11V/L3zWZSlxgTUPObt1o4BkYZVMQfNwpNaebwNkdSgVqTO18uGhxtHB3tHSU0R+BmGHH7kEpHpHV0tI1H2N1eeEeLdKHVJy1VLcsV6m+hbp1Q7VqZQtrt2XytJbbH2/RB8rSg6EFWQ9QsyMd5tIChUQCl29pGWasrCr22BIK7ZEDRtirPEPTeliAxOE6W4M8ANB7xyxAfAxMXP4r90T6DphFKZsuGSGCNr0XomKt1BTx757Gl2kp3J808RS+OjfcDz8mfd1l2OZRZcosFN0xu1BSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtZ2mFoQ9hZw+sCYX1rCAZ+SM5r81951jUIc5O1KorE=;
 b=KIOozoVHUTHY9Eg/LHCnut5XN5ZSfVXx8ubbRLzaRwGORsAb91O84FQ5riFTl7ml+G48ZLHPms+dEzM2GiSfRpmkigLczB7l1nF4ySLZeA2VAGooVPK/a08W9HkGAR80/RspeGqgHP2qwzqneIDzge5YwjOFxqFSxI1L20uErHt7BckG+RRmWqXEu8SujrScO620iM5Az4LmaVoQSMqcMzrH6oMbheIcnII0XwdPxKaU9n9xKZqAnCysUFtFBwluJjOwdM8+3YgfIMA/0hDD5bgObZI80dYefvDiAgUM0pWtm1WhBM7DKIBTuRgrd8OlE0DNL29spVta1FudwAf1QA==
Received: from CH2PR02CA0016.namprd02.prod.outlook.com (2603:10b6:610:4e::26)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 1 May
 2025 23:02:41 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::18) by CH2PR02CA0016.outlook.office365.com
 (2603:10b6:610:4e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 1 May 2025 23:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:02:25 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:02:25 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:02:23 -0700
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
Subject: [PATCH v3 21/23] iommu/tegra241-cmdqv: Do not statically map LVCMDQs
Date: Thu, 1 May 2025 16:01:27 -0700
Message-ID: <c55bbd0e137b4525ceb233fcc842a7a7c863217a.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ee6425-b2f8-45d8-647d-08dd890446a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cP0LgRnkGTXgG+oJk1AH7lBOqvzc9LTI+QpTceBN/oDoNLtm1PJLsjQjY3xB?=
 =?us-ascii?Q?FJH2Omepn/CxfrwV8mBQ3mi10c52EdqaK3lMVunUJ77E3406oeZI0Roa9N5x?=
 =?us-ascii?Q?izVcQzD3PEEcMpNztobf0BPp7tLZNlIXqF5Pm6LRjP2EPdQZLM3fEEg4tSPT?=
 =?us-ascii?Q?XcM4IUAsJRJH8rejkva18D1AgCjArPcTmsjIXr228Z7UZS0pSruXj5p1UHBa?=
 =?us-ascii?Q?O/vdWnu3QjM17hOYpHNcu4dZm5EoQ0Z7tog5wYlG+bonz2DFKD94pB+Ja8xB?=
 =?us-ascii?Q?5njNnoqxyx8j0DTY8YKQ+aotFsLiofQa53AZ7QEBJYD4jiEzHSFVq2FslM6E?=
 =?us-ascii?Q?LgI8aTlcIQRuM16wcsJt7w3RF9ENjl3ts4KcfVTNj8oDp+E+ccbC13yOPT94?=
 =?us-ascii?Q?XfBWFlzs9NsKXdJraWMfI7T3eSrqR8yNivjF1O6VSIZoMmZsrOl2r0avnFuR?=
 =?us-ascii?Q?LtemCFZSpv7203m+p4ymea5VacQ4jG+01VufXjmbtYKt4FqRh+r4aod9VK7j?=
 =?us-ascii?Q?pXU0Ctd1TZQeBw4jt0MvrCf52u0vChT6HD0jchTxWXUJBg/GVbab8ITq6Z93?=
 =?us-ascii?Q?pBqlXQPQQFP/giqJyRQkNLvfqKJpDpTcYV/8r5sFnPX0nTq82nsrAATSfP2S?=
 =?us-ascii?Q?0KRcRQ4p2mOuH2eMq+4DzC+YbSlAHywycO6nmAxC7NZH+M5j8qByH/pL9so4?=
 =?us-ascii?Q?Q/VkMMPaKUnRbEAscw5WRgYU+e1xO2CgoBJJFx4yi1he7jQAZ7lcvLzZWzRM?=
 =?us-ascii?Q?xsQtJJ9Vro0x4obOtY2Wz2yjCGnMTQSV/gSoY9LgP72owGfJjj/Gn26m0143?=
 =?us-ascii?Q?TqU34geLqvu6jpYwc9hXntN9zOIvQrCFmVnrbTRG2g4xYo4Ds/NbfuoRtOuh?=
 =?us-ascii?Q?XSJqPT5QswFNfQl9qViX4VYPwedKRLPMn3Gy/UzYHzPMP/S/FQ1km11iNrHu?=
 =?us-ascii?Q?WxonNcjZy1Mz5MfvU4L/VgoRcCtVdZdwVOgqpxYU9ZFgBHMhTfwH+s2srsvA?=
 =?us-ascii?Q?FG4PggGrIjXqjJ8+wobVZiW5KUi1Zu/ZYLi1bTjYYmXSLrTSVXnIjLD+80Gn?=
 =?us-ascii?Q?L+iOk7qS/rEoxu5Dud1JZS+yyjWiJq7P4weaPi4r6dBZf6NNRwohRIPPCdR6?=
 =?us-ascii?Q?ru5wNBEgHktWN1Nrhb78so5PQtdIp/I9JQSfxs4Ak3wQ8hN5eF9uZEgmUKhV?=
 =?us-ascii?Q?YRaGp6KbkPApre/kbLTX+6WzU/L9Uc3TDzkTSvQXzq0sl6h0UYD/I6Cz8WvE?=
 =?us-ascii?Q?eRueAF67koohbGHb7PHvR4Dwf7dR3dIDEOyLoIl/Fh93LxNjuzfOGCmfCOsu?=
 =?us-ascii?Q?pGqxUSVdZ0g+PbL8xsjKAwBd/jyqfvaQfNfrAHGtXM52KcN0w/Xb9MGnleYf?=
 =?us-ascii?Q?U7qXH8nfpuZw+1hUVkiKWYQQkxnR84qRtgIUCzRkPRSvcSY6ib6BmxIHUtFN?=
 =?us-ascii?Q?BfrWmPKAtAhULsXuLrdBADGKz/qwt4cTcwLKh0AJCTFzlx4Mwki4x+3wo2Nv?=
 =?us-ascii?Q?Ss/Z8xPx5+2hLWBNDctxOGh22Fqm/SfvmzuQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:41.3144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ee6425-b2f8-45d8-647d-08dd890446a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173

To simplify the mappings from global VCMDQs to VINTFs' LVCMDQs, the design
chose to do static allocations and mappings in the global reset function.

However, with the user-owned VINTF support, it exposes a security concern:
if user space VM only wants one LVCMDQ for a VINTF, statically mapping two
or more LVCMDQs creates a hidden VCMDQ that user space could DoS attack by
writing random stuff to overwhelm the kernel with unhandleable IRQs.

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

Acked-by: Pranjal Shrivastava <praan@google.com>
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


