Return-Path: <linux-kselftest+bounces-35000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D0DAD9AF5
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102C03A59E8
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4294323CF12;
	Sat, 14 Jun 2025 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OzlqokNU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469623505E;
	Sat, 14 Jun 2025 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885364; cv=fail; b=ZTZFWJW4NEAXuTHTAv5uRyxemMRntZUoItOsilC7jNsEOr3pkYzLCu4ngrXH/3H6xbOI8pbC7HEFsz5rctBNjxWe9Csd3q0aObo0MNxGP/5Eq+MKCD1HuE+BSFi3Wl7d18NDEY2zadt1lLmKwHjNehLHyVg2IsAzEcc4Dpq1kRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885364; c=relaxed/simple;
	bh=OsaKsDLycBboxyoS4lyB4PAepfQDClNOcQUfq3micME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bP3ekCz/v0LiW8JV5FT+8TifvDdkpIpm6yuwfu35VFwHsvdjt3HKuC4EbiBtMVV9P70s3aRzZBn3b40x2MWEFlc9L+HbutBlQK1hjKUCp/Oh9JqyGdhu4vJTdaJrwIdbdfnxyjh4A6s0Dk0sBIEHe3C8FlzsfYgEDA/I5Xbm29M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OzlqokNU; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceGk8XmVWsPFJ+CHUwkGvBpY+h8KRAue4kysX75VBzDiFBuXb/Q+zyj7McXz/MDY92bIEosaEodjJBats5bJjfzQKVMj5oqEBeR4q6n04BpAI/H5qY3YNsA8BIYQzl0wl18wRwkrKETq9oYPsnOcRx3onp7tAmEqyQzJdYeexH8gFC/9ybDgXOTwJRzbdsow/5tdY4lTJEsGM91JdQNKNwSw/CqiQbQ5IF6MoW7uRblyU4ItchmhFEzcPqQo3TvS/+m+3WiDDhG5Y+8pYWfcNru1dDbqXJBqewTSiGFf/NlY2b4lExKSsYUhYJJO3i9S6cyEFjatrh9MMjO8K+A+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCVQnNn/745Nk52MXXojme9dEVmynyA3GcvqDGOOOp0=;
 b=xzGZsElo+7ZLsy9kbu4JXytGxVGZjCqbOjazsi+GRHobvx+pW2RQHGGIRpa3Z2/a9dgJSiJassD8WcR9T9KfYa4YWid4cweWY/RgEnnTzB+CLBd/dzfCbEw2lr+uxUHvIOfuMLNyKNQpj8RAYO1QYvGg8onrYYJUD+h5xppvxHjMepykYYP0RKB5No5YjSY3UPfUSGeeXUpPqX91YKPSLG6PylZQQtTXjbDUR13fz1ptBao1szQ9KV9/nIb+2M06Pc9fX7u7mMy7IUMhtjFll/Svl2c7rtE+UB99cLzIcE0llKmy9ZAAA2zjkG6mR372+02dzy6Q0BUXbyi5NTU8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCVQnNn/745Nk52MXXojme9dEVmynyA3GcvqDGOOOp0=;
 b=OzlqokNU2l7xyWqMyIMYOhRUJ1TsvyheaVtbvgvVuny0qUvWAFhaxU8YHFv3FWVnPZB5X308KzMvSbT2MYnt7dW8DYAmSlYSU50raiHwCovdfkCbyA6A5Aj2jlcaet20nYzVM+1bAvGpHjZ7MQ6SRP7byQPsw+QtU52f6ctRpFITTGMdHGQIWwIXb3qCdQ8thqWxAT+yshWOwyyjHYLLezW0EABo/LfMfpfkoLk6Y/98f0JBUDcGxkSk2lFTlHoDz9xZP/Jfd+Cug5FxC83gmlVRpK7VlYsnbww6ljRhNjfzlQqgW94uCyx2eIhXBEzd6e+SF7T33BeyjfvVE6YoRg==
Received: from BL1P223CA0035.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::19)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.21; Sat, 14 Jun
 2025 07:15:56 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:5b6:cafe::14) by BL1P223CA0035.outlook.office365.com
 (2603:10b6:208:5b6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.27 via Frontend Transport; Sat,
 14 Jun 2025 07:15:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:43 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:41 -0700
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
Subject: [PATCH v6 23/25] iommu/tegra241-cmdqv: Do not statically map LVCMDQs
Date: Sat, 14 Jun 2025 00:14:48 -0700
Message-ID: <c10eec6d48fd25579755973d28ba4a79a21bf721.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b3bfcf-3703-4851-8d61-08ddab134e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JH43Koy+KkGmJ2DIxRCc1isxfo4EopuNGgeeo7zisoP50n51dF8jfLbhOyg9?=
 =?us-ascii?Q?UuGubJFvDfDafOLp63yso302n01cnwQhc7RjrYs2YqQa8PS3v9EX0PbximB5?=
 =?us-ascii?Q?IoiqflBuQjdBzBvl3gJm6AMIqvCUWoCYYwK4YyZkn+sZKhZ2YOvwdbxsAOtm?=
 =?us-ascii?Q?WM2C8mlxWBUSYmdo72o6yyTJJNW1DlDbeDgdrU6kwno27EoT43Om4Q5JLMM3?=
 =?us-ascii?Q?NCyzyzIoPgpihVXYDofFQwiy9pL6Yh+R4FVNk1f+0WZikoMlim0cV8FvlX1J?=
 =?us-ascii?Q?M2/5Xdu3VWXn4j5pN6MElxxs45eeaZhKxHXC6GFqYO+M9jJl3WsEfQadvVYu?=
 =?us-ascii?Q?CraZm5eUyac4OYuv2SO7VT7NSTNx6cq9K2N2+j0p3zm/s7OvZc29yKzZGBMe?=
 =?us-ascii?Q?o0dg0NpyfTR3WrDIwXDa8o9J+inqgPzybpU2E92iv4u8S0J98gC8v/+XXPx0?=
 =?us-ascii?Q?bpBPkfx2yWjGLTWD5AfwwZ+TmrjKJdopB7is613I4iDr7Qdnj12ywtzunJLo?=
 =?us-ascii?Q?8eRb7DMr7isev/37YXGpqkjvakbAXjMfANoLsm9G1pbbAyXa2hddpoy9F8Mf?=
 =?us-ascii?Q?O1YgFt8oet+2FTvF4tIQyPIljqFKx9HpHfQgJri1QnVTuf4bpFOTiWxu9Fm4?=
 =?us-ascii?Q?I/irflQdHkOIMNmumBOpnxw2kgVR9AmWO70HBCqm5z9qLtuq12SCrSC/Vmdz?=
 =?us-ascii?Q?WsXVfyWro6pRZNjo22eLeECJ2xH36WbjVMxPFSaELpJAQuXlUjCcmxGJEzy8?=
 =?us-ascii?Q?A4zcxzYnJeaH9oNveFOF0HkaCzadQX8LYZJMow59K5WH69aqdLWqlwUTprHl?=
 =?us-ascii?Q?FNWjUCQ+/0zaYX0XsZjLVpH0C9/z/NmRZVnZwBrOiAGcwdpZ5ARFpQgfTtuM?=
 =?us-ascii?Q?d8hMOZxpFUW1/9Oj6y61dF5cd+njczBYr9QQKMi+5vyjSdoh8uX48LPl3ESV?=
 =?us-ascii?Q?oWY2Wg0JpbWLvhMDn48jxULZ+TDskzj1vz0tqm2Pc2huG/sOI64ggS9t58jc?=
 =?us-ascii?Q?X68iWFnCFq142YDey9gQlg+ZXRYou+ebosBvAi+fkSvBBgGrDTweBOY+Spit?=
 =?us-ascii?Q?/snfjZmKVZK/sPvBRsJNpM8cT2XdNN7Wv+zTkaJM8O3hZaGFouEWFBEraRYo?=
 =?us-ascii?Q?6+XSY1I+eappsnxhzmwI12VO2Kl7KhUrpfr+eNZk5Ge3WZtGZzh4WNOcOHhA?=
 =?us-ascii?Q?Upxxu+9uvE/iCUhSX3QcxQh0CIToEmgcKvd0A5w+S5IzokxbGdeHoJUBqMNu?=
 =?us-ascii?Q?wcAz+fD/pTfIsJwuTIQK3OhCmq7cwBuvV7d3RO24M3PINHj+Wo2P0jYfOB0Y?=
 =?us-ascii?Q?TrWyA/6AmKCY35+Z+rgs7d+pLc3CmqhtBclVRi4g531sSV0PwQPc+XvdjDoP?=
 =?us-ascii?Q?SfqIT1p/WGFXk8DhLHQTyt30W/qudRdZQjCjySgDIMpNjTiaym7faSju91kR?=
 =?us-ascii?Q?WI9cyHmJ4A5QoqhgH1JTqf1Z9AsbOVNBaKnaDoykpGo2tecXlJ6eM/s98Vlu?=
 =?us-ascii?Q?o8S+3Gu4dmkHPz6SGoeoB2ask2BBju93BFfX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:55.8096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b3bfcf-3703-4851-8d61-08ddab134e21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590

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


