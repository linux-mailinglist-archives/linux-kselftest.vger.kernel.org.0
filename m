Return-Path: <linux-kselftest+bounces-28778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F615A5CFD4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07DD93A4FEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7811A266B41;
	Tue, 11 Mar 2025 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d8PTKQ+H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9497266592;
	Tue, 11 Mar 2025 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722355; cv=fail; b=kHZPLpFkgU5V5TY3v8QCHDcyM4GASx+eH85xlSoXCPphl6FpAM32Hz3+k32IEg2CeQ0SYBiD/F/cdClOrxl3g3PEkO1P5alIz0nV6ttNB0qSq7eRHuWGVLRU82XlGk5R8fY7j4VvInlP2Kj2/5Zo+C1DPsX2TBqdcaHBZ2a1GcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722355; c=relaxed/simple;
	bh=Pl2F3xdxorqSr+Z85/KzZbQih59Jdh5sneY71t8JNqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtBNh3KCEs36VdIDZC63yqlSGibLnVrofO4bRO3e/rDdhgAll0hSsq7Ch2D2dJhWNzbaqWKIo4tuze1rK5BAYotg7MjvHrDBVCnUDeFIC4tH6LBSX4flJUdeBfaTr1PvmiKIZVm1L3KeUjB1trWMKcfkTPxO1I21PQshKwCLQzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d8PTKQ+H; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KexefREn3OesYwADFfh0HxLH+jHcQ/E+DnXNFIJ9vizM4/TBRdLMPaIgU2fL78I95egfwjjhldlkQZJXmbGszV5eYh6bxetDIq29pfxBW8s1DIEIp9gikxiFSLcHCSfOgjv7q4LtrPcGPrmddnndhLO8Th60K/4p8LZnl4EaPoAwqof+NXH+0qmuv3aEDbLNLuERHTVVTw/Sj8MWzM+2bZTu5eugcSYONFnmBwk7LOB0AYPlWEmgFocR9zSp4GrpOSLfa+/yB0lLHskshcAazIcz3FvnzAZW6JFW/lVvkHoOeT0wai8tgnKQfrUOSDFBDDhqHXAqrTg4yh0m8r/+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXnPb7xzoI1MkmsbOMb2d4AxNW4+IokT3SWXdgTaR6I=;
 b=Ud+7kevElWzrO9VBIVW6BKfWT6YxWjyI/mY+9FDv/Pgw31XldJDiLR9DWwKTPiNMu2lZTMSnpNVJwgaeeRvSWZpiZN/vlA/C7SKmudWKs3IFaqlle+ZL++dUjAwT6xMDAayGSZjJWOv4E4bJGLg1n3sIwYISpsFjPP++v/ZtP/zMzbI+9VnuKo8l3F5DGQtuABywo7MFG/d8coezgmiz/apnn+lOcIt+ttg5c+b6qUD1/R3FFA7GUhtSQB97ahA7tzeGRlyGNvOY064Rk5PLD3zgYLjUsfvBLMvPhBdh+hNqsJVNhwHg+w2yaDaA/+y7ID1HOnt2lkTMFp3Q8WwVyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXnPb7xzoI1MkmsbOMb2d4AxNW4+IokT3SWXdgTaR6I=;
 b=d8PTKQ+HLQxYvYzeXEng50+GB1xE9FDjqvWjQnRa7sg9M9MiP9CP/CUxLBKEwtNM8XRDIF2tLHO55NozYCPJE3YaEGh0rZI34HmZ9DDFqxl+S7yQceyEYm8Bf2xOto2OVkg9ofsIb+3ge0hhp0FYd7K0USWNQ/YxUPz6ocT2F6+ByecSokCDo03JYzu/GfReCM0Imy8jyLdfOFCTSY2DSc15bLKQBpo3ys3QE3EoJqk0ZbsAUelQuKPy2yNKxtV+WWv0EdOyyJ0cBjMeNSlbng4R5X+a5t2LcSKwrfYb75DCR6ys7NukBuOgqUNkbdmHXGdSxahaH1NVKZE4qBTICw==
Received: from BN1PR10CA0007.namprd10.prod.outlook.com (2603:10b6:408:e0::12)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 19:45:44 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::cd) by BN1PR10CA0007.outlook.office365.com
 (2603:10b6:408:e0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 19:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 19:45:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 12:45:28 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 12:45:28 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 12:45:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v9 12/14] iommu/arm-smmu-v3: Introduce struct arm_smmu_vmaster
Date: Tue, 11 Mar 2025 12:44:30 -0700
Message-ID: <a7f282e1a531279e25f06c651e95d56f6b120886.1741719725.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741719725.git.nicolinc@nvidia.com>
References: <cover.1741719725.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1c6479-3f28-479f-30f4-08dd60d54fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mZzSURo3txD+F/vdEYdhlUOXJXaPVaIb3/EXtBRfpKqSGS0UoybQClLPt4kU?=
 =?us-ascii?Q?Uva5Pv4bwUtcI3+4U29w7prNAerVrlfIfxgNhR5eaRV4OOHFPA4tVa306w1p?=
 =?us-ascii?Q?VciEYFS7ecsnDs2CqNmPeFbZ8jy2Hld92Vwlap7WDvCWr5j/uTps3zemVqlY?=
 =?us-ascii?Q?WaWJ3kshsqWKX029bJ81zF+0FGqwFx987p2mXOojhMuPEoOVTIOSq75O9ret?=
 =?us-ascii?Q?4FkzC3nJBJKbZHvqzzjLg8l7+sCwerytnC/w7HOEugGR/RwtgBsEZV/FXM95?=
 =?us-ascii?Q?YVuL9jbabWNGFzJMlFTcpEz+KwpiJsh35cjYIyMcWyFDYdRpJs/WFw0tQouF?=
 =?us-ascii?Q?jdwbm8VYUSidg81wdZ8Uplx3scj11gOsPar4cYZdPHrkMmXM56zZpNh4iPoj?=
 =?us-ascii?Q?i/AnGJQ/wk2Xb1HEH8RnecZ1dt5ykcST5+r/8mx4LlAWk71uCiLXlPZhfqW/?=
 =?us-ascii?Q?vSq7I+7JO0ovNHGh9tc6rHGRQrp+88T8rwE4A9uUNlzwqOxxdYTyRL1K7He0?=
 =?us-ascii?Q?GQLqPV3t8+G3YZv7AYZX43z4pK1VHdlz4laGeEWl/OT+Ri7L//q13O6t3VfO?=
 =?us-ascii?Q?mPU75Biwpg2jCnGWRDb7CY6TC2u8pfxItZ6Bfo9Clb3ksQ0NAJI+du4uOk+h?=
 =?us-ascii?Q?m0yAZjg3wID9aMBkvyVmiifkZ1GcHBGiNSv0eYZJohcBuPr7tYbncO573luT?=
 =?us-ascii?Q?o1ORS6cVKS9VJ+dP8dYzmvd7EqvolpYzukF8xnnlNtHirGjQklLGACIqQKmG?=
 =?us-ascii?Q?BJjGr8qZOTTEzIi/+H1VWV7BFBPPjveavtbVLx+ahXvsnihgxvgH/EvBWKPs?=
 =?us-ascii?Q?X1AZDIj7ddEqFWPBCwzj/FySOeQTfOzXZu1w1tOfsYqmFB7WZIqxeF5Bxa58?=
 =?us-ascii?Q?GFilOhbDlzdN4+SCmtE6wV1LG/ztgxlZ0SATyNWq4r6T9bicL8CLbsHFILgT?=
 =?us-ascii?Q?ZnjUMUlmBxgDcSdd0RjkQkuiuSVrM/IWOwm4gYw5RMXn6ODPoSRgtCeDvKeJ?=
 =?us-ascii?Q?pfhTfuArNXbyT6bQJo6SkD5Wm7ojhpCJhLQSESXsFwO6LGbKZeYkql2fzSvD?=
 =?us-ascii?Q?2Wlz5+R9XHu/shC7HrretJ2gVnbKtYf7Yk0ZT5GXW+9UiahFOqi9ZfkJjyFq?=
 =?us-ascii?Q?eRDg8T4WsiiCfMjyzeS5rVQXqIghIvy23GjcXjao7L0bkyz9rQdpD12BmUXq?=
 =?us-ascii?Q?SGs0K8BPPd5uXM7gDrpgSNC3ehU1cNLjx7/jWfvVQFWoBcTXMvvdf4lshB2R?=
 =?us-ascii?Q?cdnv+5NsTrr8POuhTjkM7qPnABoS+JGw05HyBpKInTAZjB0zmIdiRoJtktM9?=
 =?us-ascii?Q?M4yS0cyQmyVE77iGdFpNixjmUA3VWH9Y5Hp+/G10sPPHuioVi07B/rJsDxZ/?=
 =?us-ascii?Q?Cip660OZTxqSC16l6BigUZM1+59PBDJf6I/2/jeTqkEdzSwo8gtG+CGw6khx?=
 =?us-ascii?Q?kM5MV/gMvhMbwBTk6vc621a8RkQKLbd2iDfONcLXB6DE51vumdv11xU/TWXU?=
 =?us-ascii?Q?Xnl6y3tSqqokKLU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 19:45:43.9364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1c6479-3f28-479f-30f4-08dd60d54fe8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840

Use it to store all vSMMU-related data. The vsid (Virtual Stream ID) will
be the first use case. Since the vsid reader will be the eventq handler
that already holds a streams_mutex, reuse that to fence the vmaster too.

Also add a pair of arm_smmu_attach_prepare/commit_vmaster helpers to set
or unset the master->vmaster pointer. Put the helpers inside the existing
arm_smmu_attach_prepare/commit().

For identity/blocked ops that don't call arm_smmu_attach_prepare/commit(),
add a simpler arm_smmu_master_clear_vmaster helper to unset the vmaster.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 28 +++++++++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 41 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 18 +++++++-
 3 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bd9d7c85576a..557b300a3a0f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -799,6 +799,11 @@ struct arm_smmu_stream {
 	struct rb_node			node;
 };
 
+struct arm_smmu_vmaster {
+	struct arm_vsmmu		*vsmmu;
+	unsigned long			vsid;
+};
+
 struct arm_smmu_event {
 	u8				stall : 1,
 					ssv : 1,
@@ -824,6 +829,7 @@ struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
 	struct arm_smmu_stream		*streams;
+	struct arm_smmu_vmaster		*vmaster; /* use smmu->streams_mutex */
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
@@ -972,6 +978,7 @@ struct arm_smmu_attach_state {
 	bool disable_ats;
 	ioasid_t ssid;
 	/* Resulting state */
+	struct arm_smmu_vmaster *vmaster;
 	bool ats_enabled;
 };
 
@@ -1055,9 +1062,30 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 				       struct iommu_domain *parent,
 				       struct iommufd_ctx *ictx,
 				       unsigned int viommu_type);
+int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
+				    struct arm_smmu_nested_domain *nested_domain);
+void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
+void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master);
 #else
 #define arm_smmu_hw_info NULL
 #define arm_vsmmu_alloc NULL
+
+static inline int
+arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
+				struct arm_smmu_nested_domain *nested_domain)
+{
+	return 0;
+}
+
+static inline void
+arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
+{
+}
+
+static inline void
+arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
+{
+}
 #endif /* CONFIG_ARM_SMMU_V3_IOMMUFD */
 
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 5aa2e7af58b4..dfc80e1a8e2e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -85,6 +85,47 @@ static void arm_smmu_make_nested_domain_ste(
 	}
 }
 
+int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
+				    struct arm_smmu_nested_domain *nested_domain)
+{
+	struct arm_smmu_vmaster *vmaster;
+	unsigned long vsid;
+	int ret;
+
+	iommu_group_mutex_assert(state->master->dev);
+
+	ret = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
+					 state->master->dev, &vsid);
+	if (ret)
+		return ret;
+
+	vmaster = kzalloc(sizeof(*vmaster), GFP_KERNEL);
+	if (!vmaster)
+		return -ENOMEM;
+	vmaster->vsmmu = nested_domain->vsmmu;
+	vmaster->vsid = vsid;
+	state->vmaster = vmaster;
+
+	return 0;
+}
+
+void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
+{
+	struct arm_smmu_master *master = state->master;
+
+	mutex_lock(&master->smmu->streams_mutex);
+	kfree(master->vmaster);
+	master->vmaster = state->vmaster;
+	mutex_unlock(&master->smmu->streams_mutex);
+}
+
+void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
+{
+	struct arm_smmu_attach_state state = { .master = master };
+
+	arm_smmu_attach_commit_vmaster(&state);
+}
+
 static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 				      struct device *dev)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 358072b4e293..964d2cf27d3d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2803,6 +2803,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	struct arm_smmu_domain *smmu_domain =
 		to_smmu_domain_devices(new_domain);
 	unsigned long flags;
+	int ret;
 
 	/*
 	 * arm_smmu_share_asid() must not see two domains pointing to the same
@@ -2832,9 +2833,18 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	}
 
 	if (smmu_domain) {
+		if (new_domain->type == IOMMU_DOMAIN_NESTED) {
+			ret = arm_smmu_attach_prepare_vmaster(
+				state, to_smmu_nested_domain(new_domain));
+			if (ret)
+				return ret;
+		}
+
 		master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
-		if (!master_domain)
+		if (!master_domain) {
+			kfree(state->vmaster);
 			return -ENOMEM;
+		}
 		master_domain->master = master;
 		master_domain->ssid = state->ssid;
 		if (new_domain->type == IOMMU_DOMAIN_NESTED)
@@ -2861,6 +2871,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			spin_unlock_irqrestore(&smmu_domain->devices_lock,
 					       flags);
 			kfree(master_domain);
+			kfree(state->vmaster);
 			return -EINVAL;
 		}
 
@@ -2893,6 +2904,8 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 
 	lockdep_assert_held(&arm_smmu_asid_lock);
 
+	arm_smmu_attach_commit_vmaster(state);
+
 	if (state->ats_enabled && !master->ats_enabled) {
 		arm_smmu_enable_ats(master);
 	} else if (state->ats_enabled && master->ats_enabled) {
@@ -3162,6 +3175,7 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 	struct arm_smmu_ste ste;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
+	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_bypass_ste(master->smmu, &ste);
 	arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
 	return 0;
@@ -3180,7 +3194,9 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
 					struct device *dev)
 {
 	struct arm_smmu_ste ste;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
+	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_abort_ste(&ste);
 	arm_smmu_attach_dev_ste(domain, dev, &ste,
 				STRTAB_STE_1_S1DSS_TERMINATE);
-- 
2.43.0


