Return-Path: <linux-kselftest+bounces-24026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2EDA047DB
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28706163415
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05EC1F8AE7;
	Tue,  7 Jan 2025 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c/Be5Fyr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB31F76DE;
	Tue,  7 Jan 2025 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269891; cv=fail; b=IbTRxsKmPDQq80hKNInG5L5pJjDd2vJrOYzDYHNI7DjZ3XdT6X0ApjZSfSxqG2wbpJaf2LsT7X+E5G4i0MYnDAzuOfGwU9lIo9lFw0nhvktHdt3/tjOQMDC5oKMCVuBzLtigrtKx53ORhF1yZta79vBNDtpqPPKUdgPNADIQLrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269891; c=relaxed/simple;
	bh=V0sjKf0avw8e+1y+FG/b9VwoOJNSFILawDksm031/sw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAj7hjfxoegJVWHkEDZfDolUe73VmHD206u95Xtb6mlFA6lA25B8sjlDC7W2ZKZN5T8kSA6MpHZlUwNAI5uIA1KK8LwyDHXyBXVxnKfWBB9jld1fndaQTkQveNvV6a2NUL+JZJc7B6Z6UolLAbi/0T2huqBel5o0YD68E+iE6bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c/Be5Fyr; arc=fail smtp.client-ip=40.107.95.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1U7XtY5DQYbh+AFB+zhllGhoK9XCz7sPdP1XSYFxFvROY9paWER9xtPQmiV2XA9JfKf0GlcUzE5aFbVHCipd+9+LP3gusEBz3q4vojLnwVUPYE9TJtBGfX+T8mGZZyTLvDdgG0orHdrpZaLH2bOiMGLGhaEwbn5688sBk24F2FoOOzyUhajJMgV7d8eOFXZPOhjUiSH/tlMBE0q1nGegn3Ol8TtAyNZT9Ks2Q/uh0WEhg8v0eorILeEahJN0Ho2WlktL6OLPiQzWpWSPhB2U+9GENMqDoPQJTtYtEIg2l127SFRU9QeTlpUgTmct5qMT/mANT34nx8itVrxC+TUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qec6YL77/jkxX2YV1NOAbvOY28hyb313lbUXvtSbt+o=;
 b=ejkGnI/5XlIJQjYGwaDnBJRHZY8LVs2b3JQaDQ1kXUjk0pcw3CFnDv2lxs0TBZRHBvW605UIg2NIJvrKoyzUpjNSisbmjJ3ogVvuttLhGqzmpPsk0/shpVqK3TTWj9VIbMD77xohirLa88ik3aEL3P5vE/cgIt+goNZBkFapGmpDmgo1CogrnwqQCPDzXycK3OqBj6FQSyWVUOaIHtohJzwJXPrIpxJAKmAO705Vdp93/Q9rx5iwSY3S83cIaZ5pOfuiCULJgfDe+2M9ygSHrekNSPEuTTZaEiA6Xd7IUKH4CTU9ild1mk1BxhAeLq5CPrOe/ukfoWVnjESF1IxJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qec6YL77/jkxX2YV1NOAbvOY28hyb313lbUXvtSbt+o=;
 b=c/Be5FyriYV9O4cKY3PvsPx5/h93JMcKBft0eSjP1qpwqlQl91rxClX9XiVGEd+o58POg9FivQaXVJxlFZbsJEb9qDLMOKj9PujABkFsTwP54bLo+YIPqJ/Yd31KzA67n8qRhtqscAdJJt+ogT7fNETZmRIso4GKcP2TTd4ddbIbo1ocVpJgWS2IQoI08Psz8xF2/nIR+yCcpRgFuVyjo/VJBoxWmyKqV5iKqGdsAdxAF+UvLHx9eHjvCI4h3RsN+cnlsRuoczJbPIqJrTkTFCBv2ITC/pTEPWSi5ez38rjueQHL8babHfdMLxxXiFkCOVq+zvJ114Hy+eizqTor8A==
Received: from BN9PR03CA0316.namprd03.prod.outlook.com (2603:10b6:408:112::21)
 by BL4PR12MB9507.namprd12.prod.outlook.com (2603:10b6:208:58d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 17:11:17 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:112:cafe::7b) by BN9PR03CA0316.outlook.office365.com
 (2603:10b6:408:112::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 17:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 17:11:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:11:02 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:11:01 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 09:10:59 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v5 13/14] iommu/arm-smmu-v3: Introduce struct arm_smmu_vmaster
Date: Tue, 7 Jan 2025 09:10:16 -0800
Message-ID: <115d6015219e5850ea49dc9f1247f9c3eb515770.1736237481.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736237481.git.nicolinc@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|BL4PR12MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: 234386dc-8652-43fd-a97a-08dd2f3e4cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mgxuxP8SdVEkLICi4zqEfPl3Gvc7xzVhBYjtSTHdlXRqZIAlIymId1RcUQ3y?=
 =?us-ascii?Q?GdMtudbzZkgNCZYoUKfhQRkJSZGtaiE8GJTENhb3zzxGA916MKMExr138EOP?=
 =?us-ascii?Q?HsO25N4OsUd15dzGsSP2mn1PND73yoRAdY2HR4FFWPsfBoaV4wMUuSe1dQG8?=
 =?us-ascii?Q?+p+O0lLbYwotnwXzLqegrrSbBshri7Wq02lsj0T6ZL49Aht+HPhPymGGxGY9?=
 =?us-ascii?Q?b4BU6RURrZfanMNC17C3nfyFqfQBfy5ddHaEQUhdP/E1wpWo7tBMN4OaOBCk?=
 =?us-ascii?Q?2zPHK41mz8sE6M38YDbb2og3E011fqN1Zi4Jqnh/Qe6NHnpelSVulHZFivpm?=
 =?us-ascii?Q?dRWnEKCw9K4GEainv6Ay4IQo/+/aUzU+iSr+fv0sjJbfqdjGx6fFILvIWkow?=
 =?us-ascii?Q?UvNVoau3UWjb9bgCLiF7XZs3ho8DHpaMC2NbJO9f3JZccm9RwCqoU3sm7GUK?=
 =?us-ascii?Q?BpSHeNDIou2Da4QyKP58xS7z6lA2NHvMpmuG4FdPSFytzRSVCIbGEd7aTdAn?=
 =?us-ascii?Q?QuREh8GJ9+m4WuWrDMUf7gIoN8Rw9CRM0mOVvLAihMtXvIUt33nYP/XUx/bp?=
 =?us-ascii?Q?Kw3o69sB7TOEh/26QQyMZkbH/RlcmL+cR+xBmLy6aOXl2ad6zXBjyyb/qAUI?=
 =?us-ascii?Q?GZIQzbErk4avu7H4dm3KuWlcFcAPczFeuu3SPIXru2OHpVAz/Jkr6YKIDiqa?=
 =?us-ascii?Q?3iRqZHAzULIOmm/HJetN05X9/sr9yclVpziwiXq7S5PztkpAyR9VZiiNQ0uT?=
 =?us-ascii?Q?WA5FxErjJYsmxZS1i81zfu0/bspRalBX28Z7dctvfGwwm5HH25dmfhgUHTbe?=
 =?us-ascii?Q?vrtjjU4eJUS+XEVdp4NyrXKfESMCepn8vJkAX8FzUlKW9hRm+R2ZI9ESWceJ?=
 =?us-ascii?Q?LSBBT9LwaN0yJxV7Q3Zt/Nm4SqXgkPGYN3hnt3nqTxVUmFxGrPon9NknFRAz?=
 =?us-ascii?Q?b6tzxFzi3kjVKoo6iV0HoWAU7HQFp5MhZEvQq/9KV2gWhSwnK0BRCCDyOLwQ?=
 =?us-ascii?Q?moiA7wssY1Fk8D0N7lbvFO5SzWc0RsTRn0C3PYLRu+3UXJviMhQkBNk65iGj?=
 =?us-ascii?Q?tCidon2v6EISsEUx0NGhPgvoRt7R3KtfNY8572j3ElhHzJN9cb9U5P6gU+lp?=
 =?us-ascii?Q?9sNVgcomQxOMzNyx3Hfsd7WYCLWOVttOaj+FAaRcrRbveUi6VEmVuPoe8Vhn?=
 =?us-ascii?Q?+2ox7QTZNgfq5LhkKItIyIkOi3U3YOQb3L7qw/P2XllE643JtX4PiC6SCmD/?=
 =?us-ascii?Q?c5XZWzTjMuj1yZj92fphp7Tsh+KLElPphKTXGsCZGUbAt0hvkz+cmz/+j3DE?=
 =?us-ascii?Q?iPhbI5KZDO3VinvxVhVkiO2MdWnnj6KGEuUNl7JXh6VlJgIXSw3TnAKPfbIo?=
 =?us-ascii?Q?6lchBYhioQA0rAGBQLbMaeKjHU/E/GnrKZmewDrdedyfZzuxO3xm+/suYlfH?=
 =?us-ascii?Q?mA+9i+YQ+CJCqd2C9CTcjBUvjkAD9B+pZnrgGHPduucR8x9C+r0S5WYWnNup?=
 =?us-ascii?Q?k1qFy0BxH4+4el8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:11:17.5308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 234386dc-8652-43fd-a97a-08dd2f3e4cac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9507

Use it to store all vSMMU-related data. The vsid (Virtual Stream ID) will
be the first use case. Then, add a rw_semaphore to protect it.

Also add a pair of arm_smmu_attach_prepare/commit_vmaster helpers to set
or unset the master->vmaster point. Put these helpers inside the existing
arm_smmu_attach_prepare/commit(). Note that identity and blocked ops don't
call arm_smmu_attach_prepare/commit(), thus simply call the new helpers at
the top, so a device attaching to an identity/blocked domain can unset the
master->vmaster when the device is moving away from a nested domain.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 23 +++++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 49 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 32 +++++++++++-
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bd9d7c85576a..4435ad7db776 100644
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
@@ -824,6 +829,8 @@ struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
 	struct arm_smmu_stream		*streams;
+	struct arm_smmu_vmaster		*vmaster;
+	struct rw_semaphore		vmaster_rwsem;
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
@@ -972,6 +979,7 @@ struct arm_smmu_attach_state {
 	bool disable_ats;
 	ioasid_t ssid;
 	/* Resulting state */
+	struct arm_smmu_vmaster *vmaster;
 	bool ats_enabled;
 };
 
@@ -1055,9 +1063,24 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
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
index c7cc613050d9..2b6253ef0e8f 100644
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
index ea76f25c0661..686c171dd273 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2802,6 +2802,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	struct arm_smmu_domain *smmu_domain =
 		to_smmu_domain_devices(new_domain);
 	unsigned long flags;
+	int ret;
 
 	/*
 	 * arm_smmu_share_asid() must not see two domains pointing to the same
@@ -2831,9 +2832,15 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
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
@@ -2860,6 +2867,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			spin_unlock_irqrestore(&smmu_domain->devices_lock,
 					       flags);
 			kfree(master_domain);
+			kfree(state->vmaster);
 			return -EINVAL;
 		}
 
@@ -2892,6 +2900,8 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 
 	lockdep_assert_held(&arm_smmu_asid_lock);
 
+	arm_smmu_attach_commit_vmaster(state);
+
 	if (state->ats_enabled && !master->ats_enabled) {
 		arm_smmu_enable_ats(master);
 	} else if (state->ats_enabled && master->ats_enabled) {
@@ -3158,8 +3168,17 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
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
@@ -3178,7 +3197,17 @@ static struct iommu_domain arm_smmu_identity_domain = {
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
@@ -3428,6 +3457,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	master->dev = dev;
 	master->smmu = smmu;
+	init_rwsem(&master->vmaster_rwsem);
 	dev_iommu_priv_set(dev, master);
 
 	ret = arm_smmu_insert_master(smmu, master);
-- 
2.43.0


