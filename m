Return-Path: <linux-kselftest+bounces-36636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C00BAF9D80
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB9B1C84853
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D375423BF8F;
	Sat,  5 Jul 2025 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BRV8FajA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B726238C04;
	Sat,  5 Jul 2025 01:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678097; cv=fail; b=r5kaERRX2KbhlqnRzXUmWuancA6oIQhqtK/N4oJnRfv4KeXZVjm7JyM8H76GjRjK82QA8UrydVfgKjKkg/7RVw+ELQy3+jkrJG38flKUvpCeYBW3Ky7snehEFTW+FiL128Ixjdrk/sfPLrw/AyXsAripb6kC8MC5uCwbL6F2NCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678097; c=relaxed/simple;
	bh=9DnGLYBy4wrXz/3vA45rGd/ZGZA8hH8YF7Ya1HjoHkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDDmwVV25yIIPYB9JF4m+ZWsPwMVIPyqy3G0aY7D/X2U9Ayd07ra94RIyhNTKX9RmgPSB+R2U8HAyQb5qAFev0UNprRrVDPzho0tXaZzCyrLWXgFKHHlh6rujU3tTojcpBZVqn/3VW1pdOoG0eWLrz/9Gy5FgSPI2VSW5PeP2Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BRV8FajA; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tg9C1m3+St91vmnzq7hV1POuhUdhvxIUYvs4jmhL0zyXUnFWM1Xf7WpWrMHa8BkpdtB3qa9PpWb7yRwxKmQ5doLFY5cEmemqexH2RVUoOBYniIcPB49Fwm57QVst/DgOD+ejBCOUAnhz/mWaYqR+KjG0qN7zVsCLbdPF9ompTLUYv8l9HbpKoM7fP8fXno9EB3leQGOqMF5tR4FC9qZif+BKBCF7CNH8iRtXqkAnD9Mv7dGilmRz4sbn5rwHSrqhFmM163G/h3nyM+UVk5asoZJ/F9b+1ZQECc+apKkMft2gKFZwktI3Ts1qlBDt1hsCb3/15oPXo/1goWrwBddIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNtLBykjmKVt6+bOc/ObcMrS33TvDorE+BX3BcDi7Dw=;
 b=RjHk68FD8bH3/7fLKBSLY1qbvnCy1g9ZssJZI7pRpcRYt7A+X/a0SDDWeQatNGwo+yRia7sIwJAPEvAQ7qQZ/bKqmnD0u2P+/Iomdh2PLnpAS5FRkyJNGlKYlwvsVPFtvggCBAnbjA9ki7PeT4gXalfZ9AMyFQvjkeOfcxNX401aqu12uZ1nsre3Gdu3qIsRYkdJi5S6hzm07NBqzzyXTUPpV6mFUY+oKBJAPOrEPft20/CYa4hW9NuNxmDotJxBDDtZi4MWo9LlMqlPhe9Rm3lAqGIK24HdNRNMDU1OvGmKJ28eZdEgBnIBeESLYMdUVQOLM1ScpGI6bUqxCLiicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNtLBykjmKVt6+bOc/ObcMrS33TvDorE+BX3BcDi7Dw=;
 b=BRV8FajAwiFVno+vdmFnWg42PfmUAuigrkB6/xor2ZRvmRtk7Nv4JIl7MBbkRbOVdxaQgxru/FI8kwnX0pm9M6waEimdMbYfPBZ4ETM/RuSsxPfdsPbWeoSHi+jiWoUX9XdqqTa5uKZcclG11QFgOQKC9s4mYdFG8h1vMNlm2cItLE3Pbt4fkoq8Dha0PBR5TVSgyd8AIpKITDU0CPe6R9G8FP1vKrv98KoWqIGXKsuBR8ZO+FJ9rwaTEQVf+AgZzM8qDm8TF/ux6v01CdsCKG5OddnTPkeKdvMYWfYJeQvxZFRzMlDQYkudAPh5b7IciNouD1FVsymbprxp5b6jcw==
Received: from SJ0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:33a::8)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Sat, 5 Jul
 2025 01:14:49 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::cd) by SJ0PR03CA0003.outlook.office365.com
 (2603:10b6:a03:33a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Sat,
 5 Jul 2025 01:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Sat, 5 Jul 2025 01:14:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:36 -0700
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
Subject: [PATCH v8 27/29] iommu/tegra241-cmdqv: Do not statically map LVCMDQs
Date: Fri, 4 Jul 2025 18:13:43 -0700
Message-ID: <b1c3ea64403cfeb4c09ecda80b38e19f8a478017.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 34927e83-3aa0-418b-a7b6-08ddbb615604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mx57ljjCRz98tcUckr3ESiGVb/0QxgWXrMS7nBkFkhTP/F1QDyMaJIYEe9gA?=
 =?us-ascii?Q?/+hFxz4Bj0VVHODRQKUMcyJFcwGiXW0POqoBQHkiAfS0TK+USdIkXh2a0R4V?=
 =?us-ascii?Q?1wChxwHeTo2uHcv1QRDqT0V8cD20Dn8MzqF6hX6BTu7dYbehubvBFP/auUiD?=
 =?us-ascii?Q?Et287x0h00rHDZJCoYvMV4lljKCmw/wkhyNb2JCzQnt/Jjn1/h6pZzl/NHhV?=
 =?us-ascii?Q?K1PEZq4xEFXCmoU9S9aWG4UvyP6hSal3ZeYfzLpXVoS4ADv91M7EncPGXJqk?=
 =?us-ascii?Q?PdqX9vlsZ0YDE9zh/6pBA1/J27MzMcPnhhljyNuCQKXTf/qarRJalKPnAsUk?=
 =?us-ascii?Q?crIvnFTWsWmo/tFESQg7oG4rthbiPk0VMQvhBlmoIHX6O4TNMea1tTQc9Uy7?=
 =?us-ascii?Q?HiazwSkcClILrfMAQitetsnjZRuUvaAMelKcy0ACPCBc/ku1iSTKWysI2UYu?=
 =?us-ascii?Q?ukWO7gOraXumJXqcUHSK6opaQ6cKqCUVZFg0GnrG4qL1zqhOgz7sFybNpfQR?=
 =?us-ascii?Q?JIZO9DLO2eYKlPU9rPLjTfDfpiFH1c2PzM/ZZdJ69T02+gqPjK57rfGlHV1N?=
 =?us-ascii?Q?jO2fAgAGC+ChJfLDZEYenMF2MovnpMwq9pQtLQ+r+v5yTFvUdJsQ4XOeTEq9?=
 =?us-ascii?Q?sFN6h3bRA2mmABYfbcHCMAsqCTa7MvNgFOnQj4Rf4GW1EflNa+FM/IAgNs0Z?=
 =?us-ascii?Q?593e3aa82BvUnIuguIVlJT/Fu1SbhLFEpEvF3h+n1M9PMbBVbr7ih9sjMfZO?=
 =?us-ascii?Q?UtnPJgWadoUlz8WsArGsLtMYw/Kc2UISrn7y2xANgaiBNMejLKJrSBkTwp4A?=
 =?us-ascii?Q?9FoCTq6vk929nY4TH7RgTooZ/VTOcTYZ2fdNdrGeqJgNN1GUGa5vD/GZqGSW?=
 =?us-ascii?Q?U1royvLJ2Po0r+hcYKs1/IT98mOpuR1kO0yNZ+YEDxAkwSIggMmyv6QoqmgQ?=
 =?us-ascii?Q?vl4TpKbze7zQpfMg1hKAnCXsNyWWs36cZx9zncmqSMttr7sGqGHLzOP0X+xi?=
 =?us-ascii?Q?2Y1nEHPziTejZjn8/mkiP+ZwDrM58pohPn5LQAPSPHNNlpS0sIDwL1RTf2xr?=
 =?us-ascii?Q?qfQSyVJRO4OdI7+iGEna59XSuMwMmyNrUFDNeD3vZYMQ3UlmUDxwiJ/DSoMr?=
 =?us-ascii?Q?4PpnFT+a1MjDvAOeNdUs7K/nNj5UF47ZVFc4ntSjTPuEELWZTX9G0HCxB23a?=
 =?us-ascii?Q?NUI49idLB0iZSfoxC5Blv7RfGc47lGXAKZVmFPqy2J58FpPwHaGfILsQ4PGg?=
 =?us-ascii?Q?Irm1HCyMgLFvtDueULRdREnYLd7zMrn85/PdDLaPZ26UeK1zH1H344xghcS/?=
 =?us-ascii?Q?ML/4IBLbt/SF7y+PFdsXBhsEuVb8yg0EAqgVNl5gEavjeWP+35QXbA9dUwpu?=
 =?us-ascii?Q?f8C2gn7Q6ekpDiff1ODYEwMXopfTZCF5jFxSnnxzC1EBZUYs46z1KGw9GGNB?=
 =?us-ascii?Q?6GUoTZQBiVuXJq0VM088suQmnyxpbBaqa7nnFIQ09YKDoftHwMxVFDpV88Dh?=
 =?us-ascii?Q?2reyczQo5TxQh4mhjdIePmIp8tIDCAflyVrf?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:48.4769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34927e83-3aa0-418b-a7b6-08ddbb615604
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710

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


