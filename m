Return-Path: <linux-kselftest+bounces-35912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C839DAEA6FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119CA5A0FE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B4A2FD89F;
	Thu, 26 Jun 2025 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JyGXaQct"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208E2FCFEF;
	Thu, 26 Jun 2025 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966568; cv=fail; b=WCFu47kiPxxaIKrfnYPo1iLjR1D7qONJTspr+forMmrFb/8lNu8jbvX05c6tZBC6TjogKRrtkmo+oc1GdzgXfSt2uAghMz6e+2SZFYY1W8S/en0ddOcE/YmyzQJUk54OXvsviggRSTnwyRsMsgGpMpNDeAxdWD9GT6sp3aZrN1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966568; c=relaxed/simple;
	bh=9DnGLYBy4wrXz/3vA45rGd/ZGZA8hH8YF7Ya1HjoHkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hme1UgHwq5W/5566WKLS/MAqEHPfBEwLfP59D9cXe6OnEtTeJJShbwJqWcYFc6CEFvfZmkPR3a/GOaAVB5Ph9ld4nDpxOzgSaonTK0WcoZcTwY9bfAwveKPaCiuiqipt+oTxR89tCoB175uhaM67gpMbxS9Z/9HTAKl70D/tW4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JyGXaQct; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOkKLpc/bl4eH6kr9YnOy6xn1IxpqO012Kn6mZZRWnKrQZsoQ1EHDRqz9KnkLs17ultD2GwvdL9RIamofLwNnhDzaj1vsM+nTAZZP5UxB7sDhXBAm7jcIOvkOBCUmj06YEJx/S9P5xkddWSfTmauWNATTBBZbsorJeqRwQ4ZAEmip4UxCDz3dqi5SuArG04uM2fRRQkzTStavCbt77Yevnyv0pjKpooWmAgYvdwOYmBwxNoVXum7/H77qKWAgvpaUvyRSS6gwxurdMVPOa2Y7GcYcQrzA7W8U9kCmX4/ibZfa6KYUlP5bkg2BBdVfjqiOVBlQH51jGWqxrpJT9Kiuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNtLBykjmKVt6+bOc/ObcMrS33TvDorE+BX3BcDi7Dw=;
 b=rMoehiMDKxZUB4O69gAELu+ZTtclSGjzfmGsEKmT/4LROZR2i9cFnMa56NWhHpg56tmXsoVNep4aAFHoaXhMEXKaImoCEzG6RxIUov1VJQOmWo/84IiK1EboCnPu+xFL814tdbwZsqoOp/B7m3DNWFPuL3t0MiI+7/yM8PbTdm3U9Stnigyq0aAtaOoT3lighxYGiYBX27WoBMDTuaEz7cTNvQAgtpgC67D0V4SnH7yr4EmdibEVznPTAbuEh1+HvSvA61ErkAVBJQOjT72GRBaQ7vFnP/CDN12vZSyK3gC3sNLYIZqXE3+F7QtHtcYjrrrABDmBSVDBjq+/NTfIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNtLBykjmKVt6+bOc/ObcMrS33TvDorE+BX3BcDi7Dw=;
 b=JyGXaQctgnmZtEMCGgY1EipAt9ChvF+vIUhoa0CWp+cvnj6c+0UkrRoPdh1zCcCzCTfjtNepQj0P4O+9SoYq3a6FDNu1UAidqSt/gi05EozIEzCMrEGmpZ2oNobPCtTqzDVJSs1sGoyGFl6yJvdj2+P1PVSnGL8z3JZR4CbHv9D+opHKuz9ZlwhoLS4p/ysnG++3OOWIsSevqpImNJkd2f3aUAGfvoSNvM8G+BzLNK4BKf0TRRI0z5QJL/o2FFL2SODVPaBM75UPMhpSE2gU1mi7E4DIrZtWHfSvJZ6vorZ/p0MUykjpflwHZdkFV/1T1cdqG0qF6tAMnlUsal7R8A==
Received: from BN0PR10CA0029.namprd10.prod.outlook.com (2603:10b6:408:143::7)
 by DS0PR12MB8441.namprd12.prod.outlook.com (2603:10b6:8:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 26 Jun
 2025 19:36:02 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::ec) by BN0PR10CA0029.outlook.office365.com
 (2603:10b6:408:143::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 19:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:36:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:44 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:42 -0700
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
Subject: [PATCH v7 26/28] iommu/tegra241-cmdqv: Do not statically map LVCMDQs
Date: Thu, 26 Jun 2025 12:34:57 -0700
Message-ID: <0c7d7b934809b2e6217bd9c2b703b335dd2bb6f7.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|DS0PR12MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 47fe4c06-c3af-474f-e39f-08ddb4e8af67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TriZ3SGt2nsETPO7TGm/ELz96zefshAblt3zepBYqk2xyw8cPDXyMZyDTkEV?=
 =?us-ascii?Q?D10DwmPJQCMZsG/fDxO1Xx1D5WpJgirjFPSZNAivmKF8ogkFZZHEJOuyUn6X?=
 =?us-ascii?Q?0hUQmujADhaWySlB6nmBI6AjtqUecveqUUkPdnGJkXQhAOkX9RSPlii//wPA?=
 =?us-ascii?Q?6jTlPxzHFdNFPfqqD/AHNAUlJaGOey35svW9zjOw+f4dUrLTj0W/K4vRJKd6?=
 =?us-ascii?Q?bNBFm+nDAmitf2FkIXWeONVpveyeyh1NEvyHOqWFZWJP6DE+Reu3lYx56aEI?=
 =?us-ascii?Q?c1HeAAjQubLr3VTfW6B3rkxJy4x/T35T2aDb6V0hyw1qW2CjkN4vakIKnpWV?=
 =?us-ascii?Q?iN7YHdmEXnq+dAy3a18hq8eY4e8NbQPdsYvC6Gp8flE/EvHRB7v8LL5dhto7?=
 =?us-ascii?Q?ZCO50m+nPdAESA+SB2evYP6H6ufgAlKX/3zs8OKhRtsdmSEO1uUoaWYaXwS0?=
 =?us-ascii?Q?wgfa7TuX92g7kZ/wCR5wIUHNvGjpHLT3YS6EaIZ8tepbS3HFSYtzFvZSYLrF?=
 =?us-ascii?Q?/2jHCo9jdGrDXmaGwx4EQ17JbTrQmak6jH4QA2jNXwWUOPZhGFsXUy1tumCt?=
 =?us-ascii?Q?wPKNopWPF2eITNcHo8//W+y1iQoKzxq4QzeuOolb7B8SXpUu0Aed/pWH4LpL?=
 =?us-ascii?Q?st3hbFgGvNQDBMeUKQp6ktgJZgJTebiLxIkYOodB5/T1qVe2n9TuQftUIuwP?=
 =?us-ascii?Q?cOtqkMP5bTRrJn+1GkWyeNrujlY3sc+g6B8XXPCN9WL8xooFTozvDyTgnLL2?=
 =?us-ascii?Q?zr1FQFQB4LbJ5xMNRY3PY0vo2x/RuKiVeP+FNxpzsrjnDsv0sRQ17OmLx6Xa?=
 =?us-ascii?Q?ZGgRVeSRcS/oaYsMfZll8AOU1p9Bx+BX40msQZ6cQNT60FxOAkYdD4MVnmY7?=
 =?us-ascii?Q?KNC86tuMrJfYnUVW+Bd6pzEpkz/uGhgCY/NI+XvFHbDF3pDsxEWgO8wFXIZQ?=
 =?us-ascii?Q?rfARcYtdzngsRNxcwJ6FZK9abPBQo5J5HP5MIkTm4QYONMzDHOxAbPIu/MiJ?=
 =?us-ascii?Q?eIVovOlZyu9D+pjKgLI/be6lUUK1vSZaHcAsFrFAMIu0zi2cwH2STcxRg9wG?=
 =?us-ascii?Q?nurX9AKIbXwAKD9YDrDQMjE+p+Zfw2ziljljCvrCWG4zVVmGvsMBhSqWBFEM?=
 =?us-ascii?Q?Kp4nyEXemk7sg3VKrzh6f+Al1t/Gb2+StnVgEJdGJ6FZBPz7um44BDFbNVg7?=
 =?us-ascii?Q?FglWNb6LNOa7Z0P6pGPCxOMuYLHasYk2yaEWYXovnJeUR9lDAN/gNIF9Ifqo?=
 =?us-ascii?Q?u0y4fMkYAhY7/jhSqi83WLOE3b8FTOItdKdMsgVkXgiLDanSlaQiotSlw9hd?=
 =?us-ascii?Q?MwMJbRNSQp9eQPkjVz8Gf1MggYMq4272GA7HMvYseWdKQrPkaZDusQqszFar?=
 =?us-ascii?Q?imrwJz7C9tuChdMx2CfRxpgW6gs+q19S33r2peEgQ6AnFSZ8YEUTCmxrZ7ea?=
 =?us-ascii?Q?ySAI4yb8mlR3ksh4gDdsFoy++MArwY4pByqJNjWf4O2YKpqlYwEYHsDXM404?=
 =?us-ascii?Q?EvkqeOIYb1fIqPO8ANWIWPLtlUYZdfXxX3cS?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:36:02.3005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fe4c06-c3af-474f-e39f-08ddb4e8af67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8441

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

For kernel-owned VINTF0, move LVCMDQ mappings to tegra241_vintf_hw_init(),
and the unmappings to tegra241_vintf_hw_deinit().

For user-owned VINTFs that will be added, the mappings/unmappings will be
on demand upon an LVCMDQ allocation from the user space.

However, the dynamic LVCMDQ mapping/unmapping can complicate the timing of
calling tegra241_vcmdq_hw_init/deinit(), which write LVCMDQ address space,
i.e. requiring LVCMDQ to be mapped. Highlight that with a note to the top
of either of them.

Acked-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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


