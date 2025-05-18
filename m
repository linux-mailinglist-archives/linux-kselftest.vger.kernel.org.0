Return-Path: <linux-kselftest+bounces-33283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1CEABAD98
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5EE3AA5F2
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1551235BE2;
	Sun, 18 May 2025 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EacazVw5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C104D2356A8;
	Sun, 18 May 2025 03:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538589; cv=fail; b=At1AVTWCL+2uzP4wdk6tiG1Qv0pTd4inPcwbowB7h5iVtdLq17H2eUJSjK8SKyRwmYotJTeuMq5f0WoH/q5NHi3r60rwTQFLU9G7cgArOa+pxQaHajM/p8T1UZBfP3PhFDbJxGDxcwqN3z1kxiiwtmGWXesIT0ButF/YXxdWSpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538589; c=relaxed/simple;
	bh=OsaKsDLycBboxyoS4lyB4PAepfQDClNOcQUfq3micME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuVUMgVbl5giBfzgJfOdDkMRjdWTS9Ycj7vfNuyub9UCBfsayISicjq0/llZu1lZHhBja7IfXabDUbJxuhcMdsnmpV5D4/ZcuF17jTv6Oho+WPZGUzX5yX9xeUOdrtBlN4CUQ5FgDijAjOt2YlAB7gBr/XylUAYtKMu4l+nA6sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EacazVw5; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5ZCp0JLOdCWkU7LTeoFBNN+DlzkZrFIWIBM8XmJYTg7KkortoABlO/T3GCLJI3/AtqLp/8gFDS3gIL4DrUSLYkG5ULNrkF4U7rs4JQ9FnXjs8f8dQnfIwxI+IuRoSxT/LQj7xAisqMzY8J83xnthIdzd8YLmMowdui0VWfabgeoVQjYbqvYxAKS9a5vS9/h437t2NOOCeX6vR+j2k68BmTantX5G+s8u+xYwUrycOEcwJEeBKNcugUpGBMg4M7hCIX8U2RoTSx0DuaXKWiNNebXKh3A9ECaCRVJ75yvNZaiXjqnhAl/gfhq0yK/ZPxht3h/f8LWbojYlssZVoxo4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCVQnNn/745Nk52MXXojme9dEVmynyA3GcvqDGOOOp0=;
 b=AqRV2Syur4wZUsn8VBYC5REg1pHSPVe90NkXiY6ji6dKz1v3BkuwfShNMYlvnXfxptApFxIMzZX1UotPX7K2vBqrkEEnlZbw1DmN1KtU+v+UMAxNf3bG7vy9t3kBvox7hzmOS2VqZvK98QvBzp/AVnV1341Gyo6NvZCtrcR30bqrLhn9PnxejrNwMBgxQWxH0A/qPz/4tkLA22tgfEx60Q8voSU2cXEfh3Aaw2zHu5xfzmZvjAD5/iOc8L0Q5Lm28D9W7U2liqVQWCaohEUApesZ/kDc6c/FjpUP26bqdrto4DgHuZiwy9Tf1H8AsT2y4MC+dB6M5WTG4A+rCyWmGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCVQnNn/745Nk52MXXojme9dEVmynyA3GcvqDGOOOp0=;
 b=EacazVw51FluZIazMbFeMkzjU8qig93fEeAYGULSCjMoSIHNwZyBNAVM8ux880W6IbXSIqUGVAeKtdNZ02pHyx3toZ0Zcwk81gfE62D8ilxjLWxoRyOT6Lk68PTKkg2HES28GyMtHM9ueKj8P5ssBAKSQuPY2O8JGY9QzHZFVQhJ9yq7f7j3hmXPFZDRtfR2VEdsfVR6vJwg+NcOBnPKar767Sn/oTKoIk0pm2KBru42lErmAx+KSUm8uEK81WRl6IOdJLnkdOVp94PnK/RH1D7bpnhi3raD2252biwgFjPy2mJmu+lc1Fa4QbxrgM9xZD+Le3+B0j0A/r1pbdTaAw==
Received: from BN9PR03CA0286.namprd03.prod.outlook.com (2603:10b6:408:f5::21)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Sun, 18 May 2025 03:22:59 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::fd) by BN9PR03CA0286.outlook.office365.com
 (2603:10b6:408:f5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.27 via Frontend Transport; Sun,
 18 May 2025 03:22:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:46 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:45 -0700
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
Subject: [PATCH v5 27/29] iommu/tegra241-cmdqv: Do not statically map LVCMDQs
Date: Sat, 17 May 2025 20:21:44 -0700
Message-ID: <77e69ccee770b2b053a8cc6f15258926579e171c.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b85be6-5619-4f10-501e-08dd95bb4a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4D7B6BUOy+LjMjkAu0NMHllSuwX4XuwjGXSkyWbttaB/AWgd/UH3oWi8BtoE?=
 =?us-ascii?Q?fVK8L+j+czOdzk9z7dkQrbjSaaj1G6roMRY+V39zqai5IY8/+40viyKCEf09?=
 =?us-ascii?Q?kG+MptK9e+fYgz+a9nKGr3Mmo/xrrlX0tuwQfjxBQjFZxdYKLp6i9CXdWVmS?=
 =?us-ascii?Q?psVUYytpcFhyA7zEau96N1o3UDPn8WzxIP2MLYs7nYkx0Ca3P8MFtxEWTdkn?=
 =?us-ascii?Q?v9nGnX4G4R4hAsiV94t9ab08CzPbM1k5GoFw6neYrdUBdyV+2I9f3CXadMwg?=
 =?us-ascii?Q?ieebgxtKrs6XfR8xrA/Vb2c3duTURu2ekFV0wZ6Zd/7O6rmM8mPtwjy+5q1z?=
 =?us-ascii?Q?LizKyoQi/OOTbCSVDQpP+5FQ/qEsPjSTzfw1fsiMA9zRHxA8YF6eOZSe1XkS?=
 =?us-ascii?Q?8aZ1gzCzFwwYOdbr12KDHbVdvLi/V8cjgm2cIvYu+q54i6rGV0oHK52hxbBA?=
 =?us-ascii?Q?8I7T0/66sWRFgV7NKFJ8/yPwM3nLkE2jPWt3strrOmCOCoC3d2RBA5ygcVZ7?=
 =?us-ascii?Q?Zn7vuh0m2tps7rj/mO3HHpLgVEHoNsqQdySWTBd5GOjp9AaG8ZeInT4gYfUE?=
 =?us-ascii?Q?QKmIlDFCJCZPOOd7apv6MipDUYOF3WWdrQRV8XiLYLeFnxLUrXOgNQMjpXAk?=
 =?us-ascii?Q?rtTNqxArmcjEUJYFvfG4/sEA36R5T/avY8ao/5Lb8idXRKxhbpXtOEUfxxrq?=
 =?us-ascii?Q?AM4HR0Zcz5kbLRDChYwi157+rS3njE6P8gED131F8ebNIGZ0u8OLaDpCbyGe?=
 =?us-ascii?Q?KmPMgSXecNlZBlfCtfnJXgiyzTMJuB/zZaLvxMeBpk1fiVOdlJkYrJ6zyrXo?=
 =?us-ascii?Q?9j7STS3nlUhjQKOdZEHRLfAHFq+ZRDVS92cpfxXPZ20fk+578HlygNVxXRFM?=
 =?us-ascii?Q?ImMZJL3k/mzJDFiTp3n7ybMU4lMuVql4ZOBdnBWAffMfX0rGk7qy7j8qsOqr?=
 =?us-ascii?Q?pqF13lEjsP/zVoEvr4A5lgRSzpeu6CpzVqLxdZlQiNr8midcQf/rIjWGTA8/?=
 =?us-ascii?Q?qtQ39xyXRnQM92IhvcQJWtJD7a/3lASeexuzW5XK/u/41IHmuaF7EREhg7xM?=
 =?us-ascii?Q?dk05yNocy77If4HxjsFLXlMDwGbEJ2hnuLHDFrgo7wCkFxsD3tKLPnTFRNTy?=
 =?us-ascii?Q?hEeY0nlj/6dTbD9yzO714uSP3a579EjS9a1bE4i4ZpIbi2/+tJ46vc4sISXZ?=
 =?us-ascii?Q?oeX1QFK82kxhGw00MkGHzmuLTn947i/26Vg1QAlMtzu/Lxv+ufNOg4GndhJr?=
 =?us-ascii?Q?5c0fWZG+PSI7iXQB2/8ZgHfyZDHPmaichMM3mK3WeztzQrMX5l9k7cPff4lf?=
 =?us-ascii?Q?jUbnkFFxJ5a4dM1urXAuChcNCiFTprDfOQhgoe0rykgP/JSXHEIv2JTKgJG3?=
 =?us-ascii?Q?06yEzrqztYrpdgBWoUPiJ5SafOGODHZRF4GJtb1EYOjywq1onsfoSpkYsvlW?=
 =?us-ascii?Q?BahEAWgVbbZs0aQe5ti/Uow/cDGxeCSeOyss/suYlHyZ8trWSWNyhLdtqE6v?=
 =?us-ascii?Q?ycpAouq4QSg0M0lA2/kNVcYklmLzuOsoSxAZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:59.2265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b85be6-5619-4f10-501e-08dd95bb4a4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096

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


