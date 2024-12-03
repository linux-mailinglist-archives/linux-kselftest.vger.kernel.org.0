Return-Path: <linux-kselftest+bounces-22794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F909E2EE2
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 23:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995BB1661B1
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 22:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACFA20B80D;
	Tue,  3 Dec 2024 22:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l1/8nYza"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971020D51C;
	Tue,  3 Dec 2024 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263883; cv=fail; b=E8ivG5EZrFHKpaqQ+9txpx4FW/ARB0CoSDM9zL/f3jMz0p7iRO6nVYYhHbK2i4DCPCX71F3xtmo3EOYkL/WftJGxmFR70ow7YKdO1E87TvRSENdxhSM7k2I4IQhE6IHiCFCCxrHdZWDhrGlgVa9HyVlcbNC9EVGQdb4Ql6iMxDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263883; c=relaxed/simple;
	bh=2YOGpI2zpDLTw2qjz9zdnCzDs/iG5x0EiAjNyKMms70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6qZEZOIB1zJy3PrSbBsOAzmxrcDluf9rFfP+aiXFujY4uGaYmx7ej4CCA5snuVigX8Czvn1OQHsuWC5yOhbxttlEezDts2jvS+15Fofsk1R/ecs0Qlsfvilp2apg9wSkaiN03tVZ+Pt4N6Xl4qyecW3/WL05G0DRlKQU3va2cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l1/8nYza; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOLIR+GctDBqHWosc3m5u+xj1aKUjHWeHdDtoKy/WaQn86dPcRMDe9rHiXyqfj1HDz9pDNvi+w4tNVLrXM/DB+cOBawY0tdGtOU7QTMyc4DOGr9YU5a+jlxf0w3wuXv4hg4uZjNW499dJGdN8aVuEUDwSkxXzvMNs3qb/vX80WdDJaDEAm6GaLVkr6CQ0h55ReUANixodw7kNIe97SK6CTGJoZiRlydeJ/N0HuCnNn3NzxGZF90mpv3CB0MDS2FGfQX4DboxZQxsVjGhJtnnQdismPeIxadTw9huIzbtGOz1SFP4B/zuGAGtl+4XgKFpX+iHo9dqUU65IMpa5hmLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSbcYsAxYmf6k1AkDUXyPnnb77Nj5Kh7FPmP8GN3YFw=;
 b=ObVyCQt64R8nNgzc/jjeM82nc30h+txrnTdah+2X5+W1/01g2/Mx+nz+n4vupStKvINrZhtWFb4BBkRYrJYnrbo2pVBvmISYxcDOsQGwGvXaH3eIfUixLK7SumfkScN7R59wbdaW9d7HtJ3vYmZCY5ZI1TJWaH7SxXoloIM/i6G8n0IkXNgiuuPweA4jQICJeiAgCrJvfTwEPyUS8h34xrVYJoxDJyTLoiHBvp1pD0l9RbC1Fx5OiCciXqS8Ckkm2G4R0JknWuocmUNgZ6Jw3sj0SzubiofRUsPcnUg7vBJ/NOF/5mRmeBreGWa/wFBJcZJd+XnmzE/HzmH3kVeeGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSbcYsAxYmf6k1AkDUXyPnnb77Nj5Kh7FPmP8GN3YFw=;
 b=l1/8nYzapD3U37CY/pOHhwpoq3F9StSOSO6654c/ZoMO1tesTIvlx3kpFPyGisRMKYn/p0KQNJ7LBL4/W0BoDJTOTF/IYTdMHeT+h8Lf0Sf1fjceicTkbNYoXssZGOV8i1ZYU/ybqxUwfYfJZwOqrm9JlClamxNGj5qtgEWcqbK2nPACmlm3guZoH1LTE3ZF7eryNc3hpPRMbeXddknIJqABYOulb4cpdaXAwxz8+Wg2ptziyBysbqvasj/5GK7jxdkHHgsAfvv7c5EFixbKJLkR7Y2sp/hvi2l7/SAUCzIcMpij3HjoZng5+i984+OWlifrLlsTRhnX66ZXLHn/bw==
Received: from MW4PR03CA0310.namprd03.prod.outlook.com (2603:10b6:303:dd::15)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 22:11:07 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::98) by MW4PR03CA0310.outlook.office365.com
 (2603:10b6:303:dd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 22:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 22:11:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 14:10:49 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 14:10:49 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 14:10:48 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 12/13] iommu/arm-smmu-v3: Introduce struct arm_smmu_vmaster
Date: Tue, 3 Dec 2024 14:10:17 -0800
Message-ID: <6270c905fc8537ffc51f6f2ab2db0601c9f08a8d.1733263737.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733263737.git.nicolinc@nvidia.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: eb341530-a642-4640-f842-08dd13e762cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DM8LjERzKgXdcbVLjZIMRXffWRvm1MvsKlQSROduad6Z+HbBNn5vJr4I5tGp?=
 =?us-ascii?Q?nYolroWwtIeLdQsnU4s0yyonaeATMe9O6Wp4mRusa14HASRYKjOqSHdU1IGs?=
 =?us-ascii?Q?YQV2DJLjlzY/VRVxrfinBalt1KCIz+vGcE9zFK2O2cwrWAETTES3ERenkjRi?=
 =?us-ascii?Q?4XKQHW7750QTn+3AyFyvhfdpc3MMFGb/uQ4M7jnq6ONaXhjRLZDAt1xYoOAq?=
 =?us-ascii?Q?OlVxRsUCXrSFSWoyEb3wIid6Hj1YT3ICMGn1SLCTIXEDkjuklO2d3RH9f+Ye?=
 =?us-ascii?Q?2BHteMKV4YnyNVUX9iSqiL4B539npYHPBAa6iPsVCiHgqdiYuhMyFAVOFD4s?=
 =?us-ascii?Q?G9KaWxCCTA9o5doJLsTIeQ/rde6hi2Pk41uDiDUiTqUBuJYVE01xU8q4KoD7?=
 =?us-ascii?Q?rfGQ2S8e8eIuXobqelhqlAr+ntIwuQD1UaaBYGYzzHpOmdBkTJmxveNw8UdR?=
 =?us-ascii?Q?hNttt6pvsxU2BFE8Szkj6tLyNJzUA24Yy47Q/+NB1X9fK/upzB43MyTg2D4d?=
 =?us-ascii?Q?vSGq+I4LA25wdPsDBtkb6ZXZKLWma+0RWvf5C9RCizL6J0Cu4tL5dLs6srKZ?=
 =?us-ascii?Q?/dKr5wzuLBmxX6ANNYt1nnX0m1OS3viar1riMV+ZbLh79ZrJWkMSUdPTxkcb?=
 =?us-ascii?Q?2skpPQQNvgPY5/DX8v17jqq0W03YmDdMsdQqjknHg1LVzy06YBdpSDKwIbDv?=
 =?us-ascii?Q?Y9pFIZykcGLwL0w0oNpAaQ4ZCnQ5gENPK/VnqvaYdIJT9aWut7TaATDLoOY6?=
 =?us-ascii?Q?FsOdDM935TBKjSaAAjDa2OsuBXIDkxz2tAJO83cMOCX7xK0gJJyqzLqa4wZa?=
 =?us-ascii?Q?TG6l7RygytTAg2gtnbZigJbUiwsX/SPQ6CIwyG/VjnzuchwE1ocQuxyYkGFb?=
 =?us-ascii?Q?C2Ul7QLmW6GMWIx1kZpgdxJnAFVtXNLd8HuYC/3glnPQBquDffGolmq65LSq?=
 =?us-ascii?Q?VvAFaEcQHS2DViCwbDUfnGSvSaAhT/aIOQOgorVQzoVDLuysgClQTBo22i6H?=
 =?us-ascii?Q?Jo6suhxjPOJm9THXUrhTQyDdNqeQrD3ecHqn0xLRkElm9Dd3PpOZqHX+tBt0?=
 =?us-ascii?Q?tujnXN9fulOZMQyoQb1++ifkyq5CNTBEbKwM8bSJgjqU8Ebs3nxf+epPosLx?=
 =?us-ascii?Q?x9bGT76iiXG8+vf2FpAflgn55qdJ8FAZJKPCrJ7PMrNKMkmmMjrWIxExDktC?=
 =?us-ascii?Q?eCUdBXXUvMcIdi0tgaxMDy671Zc/2hqUuXSaSDoVN8bdnxpPVaXwPzMp3RgP?=
 =?us-ascii?Q?TDjryHAhxWJva2X5+pjcz/5ZfAmYRLaLWeL26Vq8MEtIaVygHkk7cejXsX87?=
 =?us-ascii?Q?6KRaTiP6+fP9lA6j3h9mDbb1KRiItQ9WJAwhVaL5ISFLooNsd/ujRvWXeV+X?=
 =?us-ascii?Q?4WsKMuWqaXEdez0fIMnehe1fOIkZdDTtZEUjU5SkBhGFF/pLPoi3MqQebyWI?=
 =?us-ascii?Q?JAebSibb+XyBoYKzFk/zp1QiIYliUyRi?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 22:11:07.2360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb341530-a642-4640-f842-08dd13e762cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939

Use it to store all vSMMU-related data. The vsid (Virtual Stream ID) will
be the first use case. Then, add a rw_semaphore to protect it.

Also add a pair of arm_smmu_attach_prepare/commit_vmaster helpers and put
them in the existing arm_smmu_attach_prepare/commit(). Note that identity
and blocked ops don't call arm_smmu_attach_prepare/commit(), thus simply
call the new helpers at the top.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 23 +++++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 49 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 32 +++++++++++-
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 0107d3f333a1..ec7cff33a0b1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -789,11 +789,18 @@ struct arm_smmu_stream {
 	struct rb_node			node;
 };
 
+struct arm_smmu_vmaster {
+	struct arm_vsmmu		*vsmmu;
+	unsigned long			vsid;
+};
+
 /* SMMU private data for each master */
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
 	struct arm_smmu_stream		*streams;
+	struct arm_smmu_vmaster		*vmaster;
+	struct rw_semaphore		vmaster_rwsem;
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
@@ -943,6 +950,7 @@ struct arm_smmu_attach_state {
 	bool disable_ats;
 	ioasid_t ssid;
 	/* Resulting state */
+	struct arm_smmu_vmaster *vmaster;
 	bool ats_enabled;
 };
 
@@ -1026,9 +1034,24 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 				       struct iommu_domain *parent,
 				       struct iommufd_ctx *ictx,
 				       unsigned int viommu_type);
+int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
+				    struct iommu_domain *domain);
+void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
 #else
 #define arm_smmu_hw_info NULL
 #define arm_vsmmu_alloc NULL
+
+static inline int
+arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
+				struct iommu_domain *domain)
+{
+	return 0; /* NOP */
+}
+
+static inline void
+arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
+{
+}
 #endif /* CONFIG_ARM_SMMU_V3_IOMMUFD */
 
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 6cc14d82399f..3a77eca949e6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -85,6 +85,55 @@ static void arm_smmu_make_nested_domain_ste(
 	}
 }
 
+int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
+				    struct iommu_domain *domain)
+{
+	struct arm_smmu_nested_domain *nested_domain;
+	struct arm_smmu_vmaster *vmaster;
+	unsigned long vsid;
+	unsigned int cfg;
+
+	iommu_group_mutex_assert(state->master->dev);
+
+	if (domain->type != IOMMU_DOMAIN_NESTED)
+		return 0;
+	nested_domain = to_smmu_nested_domain(domain);
+
+	/* Skip ABORT/BYPASS or invalid vSTE */
+	cfg = FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(nested_domain->ste[0]));
+	if (cfg == STRTAB_STE_0_CFG_ABORT || cfg == STRTAB_STE_0_CFG_BYPASS)
+		return 0;
+	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
+		return 0;
+
+	vsid = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
+					  state->master->dev);
+	/* Fail the attach if vSID is not correct set by the user space */
+	if (!vsid)
+		return -ENOENT;
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
+	down_write(&master->vmaster_rwsem);
+	if (state->vmaster != master->vmaster) {
+		kfree(master->vmaster);
+		master->vmaster = state->vmaster;
+	}
+	up_write(&master->vmaster_rwsem);
+}
+
 static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 				      struct device *dev)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e4ebd9e12ad4..6a6113b36360 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2730,6 +2730,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	struct arm_smmu_domain *smmu_domain =
 		to_smmu_domain_devices(new_domain);
 	unsigned long flags;
+	int ret;
 
 	/*
 	 * arm_smmu_share_asid() must not see two domains pointing to the same
@@ -2754,9 +2755,15 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	}
 
 	if (smmu_domain) {
+		ret = arm_smmu_attach_prepare_vmaster(state, new_domain);
+		if (ret)
+			return ret;
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
@@ -2783,6 +2790,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			spin_unlock_irqrestore(&smmu_domain->devices_lock,
 					       flags);
 			kfree(master_domain);
+			kfree(state->vmaster);
 			return -EINVAL;
 		}
 
@@ -2815,6 +2823,8 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 
 	lockdep_assert_held(&arm_smmu_asid_lock);
 
+	arm_smmu_attach_commit_vmaster(state);
+
 	if (state->ats_enabled && !master->ats_enabled) {
 		arm_smmu_enable_ats(master);
 	} else if (state->ats_enabled && master->ats_enabled) {
@@ -3094,8 +3104,17 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 					struct device *dev)
 {
+	int ret;
 	struct arm_smmu_ste ste;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_attach_state state = {
+		.master = master,
+	};
+
+	ret = arm_smmu_attach_prepare_vmaster(&state, domain);
+	if (ret)
+		return ret;
+	arm_smmu_attach_commit_vmaster(&state);
 
 	arm_smmu_make_bypass_ste(master->smmu, &ste);
 	arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
@@ -3114,7 +3133,17 @@ static struct iommu_domain arm_smmu_identity_domain = {
 static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
 					struct device *dev)
 {
+	int ret;
 	struct arm_smmu_ste ste;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_attach_state state = {
+		.master = master,
+	};
+
+	ret = arm_smmu_attach_prepare_vmaster(&state, domain);
+	if (ret)
+		return ret;
+	arm_smmu_attach_commit_vmaster(&state);
 
 	arm_smmu_make_abort_ste(&ste);
 	arm_smmu_attach_dev_ste(domain, dev, &ste,
@@ -3345,6 +3374,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	master->dev = dev;
 	master->smmu = smmu;
+	init_rwsem(&master->vmaster_rwsem);
 	dev_iommu_priv_set(dev, master);
 
 	ret = arm_smmu_insert_master(smmu, master);
-- 
2.43.0


