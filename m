Return-Path: <linux-kselftest+bounces-36932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A67BEAFF91E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5AFF5A13CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484DB29AB1C;
	Thu, 10 Jul 2025 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rw6GuJrb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F882877FF;
	Thu, 10 Jul 2025 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127263; cv=fail; b=s02a+N98lFAhv3tJwBUtgvWUHzLVbB3iWBV3Ef2oAzbvARgA9IgYoIur5d6+iHsuzZnZCMPedy9Vl/7w1ZPVirhc18izQ68BKXrMnF9UN+CbXo68P3e1xI6EXd52Csx+DAx9NvG0pVbx7RoraNZuDf6+w0MkuJbouzyPHeC7yFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127263; c=relaxed/simple;
	bh=9DnGLYBy4wrXz/3vA45rGd/ZGZA8hH8YF7Ya1HjoHkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5VX5h6kX5pRVD26DAeR9NjoRZMrChNZ7kUVFgE5TickMogh5W7loebiW1mKkXH08CwcMLC8u3OhrHaXYx/T/eFoPinYENDE8eNo0zXpV4pUcKoRhT9BGqcpZP2C8BWVK9j2e6zBn/fGkRKmmq9XHfGc3zCIWO5nGoW5Y1VpdbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rw6GuJrb; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLZSTrAhQAT+kQiANF6QmkaiB1nERjbmougpKGbwNJeZpLS8xy3oztBcsPbVUItgbF4DAZay5kXJjpc5K8WTG3iASHOcHlFU8V1purJaS+Id3T0Y/BUrBuksokfZ3g1lrqDg5wWlLx/2ZHJA5IO94cM1trgV+o5oMD1onaYBx1xAFMuB/a/LHXcEuLfZibmKd5h9/6UKiOKmlaLYfgWSMP0ulA7x5iy6CVDqXRNyiMhM6Q0uFigQvJcFsc/TtB8jww3zXWTKGuP8g1Ch5G2Bu1WmuMaMyM9BMu/aNfjl2d50O96VLO5PeqT6uDzphFrYFK+bBTBrmcQZiwkP28bXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNtLBykjmKVt6+bOc/ObcMrS33TvDorE+BX3BcDi7Dw=;
 b=etyFmaJcoCi20XvVqvbkcwajjgs5b8r5hdG9tupMT21XEunCMoCjgXcD+Z9Bc0puIlajj7VAO+YzYOALSWPaTNx4IbB4ESuS9aT5wnRebqKiIuC4Sxf/K62qpFY4V/CIt0CMJBEY05O3oicOm5CwekgqborN9V5dNZhtmr/kuWh8tTPGECZWk3kZGKEDO9L96ssGtVx7HzV5hfMxb/Yd7dN+hu0wnK8h3Zmk+dw+r7EOPcZ53EzWx6xk34oN1W8xKAipG3l9fX8W2/Cra4H9qOAdJhOYc4BQCQfjOrinGK1nGd8IAiItM7vpr+tPo7Z2TxlYSxiALk7SsCEkcuRu4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNtLBykjmKVt6+bOc/ObcMrS33TvDorE+BX3BcDi7Dw=;
 b=Rw6GuJrbV2dXtj2viP6N/nrJvi8aauUQo4gVwc0Aw+PPmisHC7poRLAwHdwKGCfUbXS/ZrFChtnapmgz0xyJdZmQVpIoUASBwtFKudGoV+IUcH2/RgG+fUz9wGIFT1G+KBV/stsXkSM9lMZMgOvwEF3l4w9l6iakkkLKPee06CpdG11uS1tdjyJbZkCPEXJS54tanyeUH1pv282sMEduuFE4hO5LUw5t9ALF22MHVz4kT1NBiQPXKtSd6p+iUcIcoSx5eHjL9RXzvSQix33cPs7iAOpEYcr8m8UGUz7REGKQgw+DdQrAEUCDSxo77wutn28l8IcTI/XjrBnELk4s1g==
Received: from MN2PR15CA0018.namprd15.prod.outlook.com (2603:10b6:208:1b4::31)
 by DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 06:00:58 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::89) by MN2PR15CA0018.outlook.office365.com
 (2603:10b6:208:1b4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:37 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:35 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v9 27/29] iommu/tegra241-cmdqv: Do not statically map LVCMDQs
Date: Wed, 9 Jul 2025 22:59:19 -0700
Message-ID: <be115a8f75537632daf5995b3e583d8a76553fba.1752126748.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752126748.git.nicolinc@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da18181-12c8-4a76-0f2d-08ddbf772434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wgiiq8ewBJC0tSNvg0jldor7oA4j3EMLoNGi5sM9GYrCl38JxROiZ2bZcTGH?=
 =?us-ascii?Q?1D57tGQE3oPp0nbbcg2L1BvPsTFixP0DTS0jlbeG1wSKjShAwndr3RbdQu3N?=
 =?us-ascii?Q?1hxlq5enqBfGlBj/zeai0CYc4vrZRdGiJPfg1wTj4UjiehKTgFEtuIgQ7glA?=
 =?us-ascii?Q?FqFuhaQp2jatPim0fvKOdOuPzvhVZ1oMm8EPdNFF8m0taG5H335WT/9SEnuO?=
 =?us-ascii?Q?ww6M1oC1JYIkKY3dQsNTlxZ9R0snWmv2pmE/G4JmT5e0XoQC1j6z+ZovnujD?=
 =?us-ascii?Q?9vw/aYe3oDVfEEvsoCbRwuz9wDd91JSVbxy6gNRLUglhVy3BgU1ojfEKbKm1?=
 =?us-ascii?Q?TS7PR/8aXXnvHJ7wz0wmXDjwa7wLPWPlmmIEvJ54dVnzEop4kjde747IjqUl?=
 =?us-ascii?Q?m5DNXZUCPDoKCzzRxzl+f+rHvJ0VuB/2lL672nJANK7dfPFwjoXw3wZmkgto?=
 =?us-ascii?Q?ZWC917V8d6pJociH1ZYUv9clIpH3shoPqCZcK2yvaDGtcquMgdk4ujCGSW9A?=
 =?us-ascii?Q?5Bt7A5GYa5/E81Q7+UFkWwUhi3npdmXrID1kEBkwsmkoZUrbBHdkFkH+ecNt?=
 =?us-ascii?Q?ij4xj8MjeexYIIq9OCelXr9YxjNJ80t4Ln9jcR+Xp6azCD05TmKZ4fpNDp1c?=
 =?us-ascii?Q?5/7gq2jQZ6UnTIv6tSVH1R9RENufA2hLXKEPnG8EQNJddvvdDld9ob13kbRB?=
 =?us-ascii?Q?eIOzBhEQPKERVgSohgyadmsCALW9DDfJz2WiDiXL1L8CpXpcKLfEtMBwYPB2?=
 =?us-ascii?Q?hBNK5M3KrmQPtDaekrYyIv/t2/KxhyIx2k5H/hqICZPi32O7EAQ28h/9hFwT?=
 =?us-ascii?Q?OPz1fqnma5mCa2W5L4DoU3gT1zJn2dwql7MAi1pCOCTsuGw11CJsrfWPClG0?=
 =?us-ascii?Q?IWB3veGrDUzcdLS97D+9wsOPYbH/q2tPon5TBLxuvWIqjMAnwd5wV5R4oVV/?=
 =?us-ascii?Q?SoWVyICeelJsWrj6q//001Qzcnl/mGM2afMGJahE9S5Aj0xwyZS1UFxIS4ZR?=
 =?us-ascii?Q?xy1b1DlsFUesz0Bb0pGIqV5neUzdRrEX8fqEQsdx9WrceJyzv0ZaY0D/jrZf?=
 =?us-ascii?Q?y4tTafotr6sZ0en3iKhiTAH1ZxFRNudHgx1XhfBr1v2eQCjoF91Ex7jJYfZJ?=
 =?us-ascii?Q?YBz6scOQZ27pwTxq/QYH4fvrDOgKUQiqaPxTayKZTEjJ4UKKFyfd2pu4g80S?=
 =?us-ascii?Q?DqI1sj4yWNQy6Iqvxd9WhiwvCKq81yxSrAmkctAk0el1Ct7OTI8LWAPAMQy5?=
 =?us-ascii?Q?077qfkqxcy5/vztq5aXhaL9wHzZdwPsETl0Y8r2NaxdfAm0KEjhESFABF+61?=
 =?us-ascii?Q?HBpmsLQhrzEkNzNKVsqD9L9hipLKKAJ5jI2k+9etpxlW8+FpJHwGn3vqD1Zg?=
 =?us-ascii?Q?6V5of5ceik22tWEAf+kVUUbqJkyGfxhvQVYccdPF/X6F4haep5GNpimLZ4ap?=
 =?us-ascii?Q?HBIESGzvp7GwW8NyYWbBjEDi1TDN4acIHoF1t8PjO1/5MYI8tk1x1L+x7UZ7?=
 =?us-ascii?Q?6vxthNxNQxkfQxaG6odWqA1GMmM8h4xgOI9h?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:58.4090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da18181-12c8-4a76-0f2d-08ddbf772434
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418

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


