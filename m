Return-Path: <linux-kselftest+bounces-27276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED99A409B6
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 16:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7C2700723
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1809920C037;
	Sat, 22 Feb 2025 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q0WCw7Re"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B29820B7EE;
	Sat, 22 Feb 2025 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239697; cv=fail; b=c7QNF969nGATNfxYQK7KBIKVg6rpdd4p8E0+E09oWrhOgH1Ys3aBhHug9K+Gcu6uUsGjmEpPrnmf0bj7yJ+3PDkEGUWLLxPAYC86cYNdWDH383vR0CxEjAsEdO4RQ+8CN3gdhkvU8j5Af/ZYtMLG9xZbuH6oFt7PwjHQvxz7P/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239697; c=relaxed/simple;
	bh=bC7jnA0GQgQBdr2wDvP7KrRtON4oviHEA94DhpxkHLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmWoitVL/4r3AIUbz253w6lzHiCJkL52/H6LAYM0J3dgMYW1zL2qQtiS8LzcrgchgdaCKGoLmg8tl0xL6VieuTrtYdoqp3ZFWxi53zub/KwTVarYNwpWF710GqXfBIrs3uhie+d4TN8ki786lWQWpz1FCjWIk9D5RLbaH6lQjY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q0WCw7Re; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrOuQaZ9tIev4IJcTHZxxpTxlyMwLDMf+txoyWY+PCgoBk8kbPmo0cZmnpl1AeVaY1/dwPkCkl057W/YGQgydB+rxuGlr3+26IzIK5Q9fWE6KDYrDbVBznuswoYEwf5JUWEQFhGYF4n59ge/67TSL8WKLBF6t+KHNzerVz2fufQ2UReHaehvMi4Cpsqsx0wiDExPzg7fs4FIsyfLDPGbEQAdgTCM2gQ5ByjbJGBTIaYA0JlNHHSoKipMNVhNNMljuLTwIrR0d3Q4My4YcandoVkFrGo0jCdX1oBorV0c5N9GdSNLG2MEnjBLFiQhHa35gpmDBSiRK1///9yZRyD0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4XC1t9uE9d98oCKXv3ySINEv8fP+ET7TRg95FMhJXE=;
 b=l17GvPHb1Qu7xj+aO2yWsfCDAyKVhZu3+VFLVCLiYtiGSRByuIelShK4jtkvN+16bStK65hdguyRgJ6gnd2LA1e8C8mwyAl+h6hi4g8lbnTeJ9hOTyyaMfMvM9SnOq8FGDIn9w3EURBqnE98/NCzqwDAd23ch5dgGbpg6f0nevp0HM/D9QY97iaarYZ8cyRz2Nw6QA0RZJTCpw6HmOxDyrkqDQVKhOpnMATQjri86D3TL40PH7110SbzvJmc/jFUT7SENJvShTGWvXS1vQK9MtvXgQh+PRgtB1h8EAnO9ZxaiFgzvQ+XRsCgZzsoo23w5wma9rVVIEadGJsXI8wTzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4XC1t9uE9d98oCKXv3ySINEv8fP+ET7TRg95FMhJXE=;
 b=q0WCw7ReutA8tUDu958zUvakean67JcTzxIk3S2U5EkqmlzGYeG5qb8lviFEf02CfhEfrHD2elB0KC1SeavzAEfI0tCjc1bNF2D6y7h6yTS+eIiLYe/m0xMLFt+9k/4QyKDDhLHXGdEMzU5MVqnjVu4OsHNPiANqW27u2U0Ak53mgH6nT+g9/gYM1i/8A6L57hkqGogkinGxjlvaHbfJeEA7RhzbQZqYY1lxSpoRRusJHFF9LpUI7if2VjGXOW9TUraNBScX8vbPHQpclKI4PTs7Uks7rafQ4qN46gNB/UD05yCv5bOVyASg9lMgAQmVSPE5YeVtfPrgfRPSIrxFHg==
Received: from DM6PR17CA0024.namprd17.prod.outlook.com (2603:10b6:5:1b3::37)
 by SJ2PR12MB8883.namprd12.prod.outlook.com (2603:10b6:a03:538::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sat, 22 Feb
 2025 15:54:46 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::ba) by DM6PR17CA0024.outlook.office365.com
 (2603:10b6:5:1b3::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Sat,
 22 Feb 2025 15:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 15:54:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 07:54:35 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Feb
 2025 07:54:35 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 22 Feb 2025 07:54:33 -0800
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
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v7 12/14] iommu/arm-smmu-v3: Introduce struct arm_smmu_vmaster
Date: Sat, 22 Feb 2025 07:54:09 -0800
Message-ID: <be799951a817557ac093ac3e18d02a631306aa35.1740238876.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740238876.git.nicolinc@nvidia.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|SJ2PR12MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f45937e-c91a-45b1-7974-08dd53593b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fLNbZW7bUKcMjhq2HHsaUnbXxCE4HBvw3Bt8RjwluH65Xaa3sC/sV8XdyZLq?=
 =?us-ascii?Q?MJw7eTKdTct7daOoEttIYfK3iocUio3+d3C2Y4kA7zA7SkriYGSM3XX/1FO3?=
 =?us-ascii?Q?3Llu3X3Fmkrmg+E39DhGblPdYcnbR4VTc615kIYktIroTSRoWyVtbpFeiVnk?=
 =?us-ascii?Q?A86w8UTvqAS6J63QC1HuYO/6T21+1Mo6144GaiN7m/Wg/ZkVrHlZ8bpVZKQJ?=
 =?us-ascii?Q?Xh9YwA9IDjl3kgtb5kZQxAhSdpfnc3SdQRm50SbbsF13AvAI3BEUs1lz97/y?=
 =?us-ascii?Q?PVzVA1RQPfZbW5ZqiteJwTJgvr0e5riLwx7rDKf+HUC33wnknIRKbc2JCP90?=
 =?us-ascii?Q?8PAKPRAD4Ml0J6yxZKY6DY6qgQHIm3zvGPGXGubFIVaHXaWfG1CpMZhz5nCN?=
 =?us-ascii?Q?b0PMIPmtPq1hX0xar1CvDvgqjB4z5PO9LLY0ApA4cH43MTt1DtQvJGd1rZHd?=
 =?us-ascii?Q?0e+eAYUGrgXoywXvgLwO+xwwXE21g49IOSddt4iSESwoUHEaL+s2JxUuJLzd?=
 =?us-ascii?Q?hnTUzniUwNu3/QqaZ5Etc2DyaabiE4LL3AD7T70vL73+QzzV3pHO1fiy5cWU?=
 =?us-ascii?Q?vN164wJm+FpBRCZ4/NzCqlMG7U+C/ZGUyiTZq5Ti50fIs2J/YZ0Srfw5CRw4?=
 =?us-ascii?Q?c5xW3e9Xfjh2l9RzXnG26kK+tQBH+2raADcdlnaIjGEPyMiKBL6yjf0yAnOH?=
 =?us-ascii?Q?PZFDQcsiaUp+f8+hESOwefDOyB9gDGPMsRs8pMmvNK83a1L7z8Lj5dALyegP?=
 =?us-ascii?Q?rUqiwzwWl3hc/EBv0V8GpjzAS1E6CsDi1AEnnYSmiRKC/lemVSHb378cBsJX?=
 =?us-ascii?Q?hK2/B8a5M6cCJraqKbaN+LtfYZ4YmExEszAHVfzN/lpTUmD32nF69e8p5EPs?=
 =?us-ascii?Q?jiwh5PZCj/1Xmt810i8vUAmgPrFLsV1I+KgMoSmOXBGDkRr3Am9/hZifRo/7?=
 =?us-ascii?Q?YvIp4kC3wU6sKG5wbu0DtUjh7V98F1XR5F4gVQ6SHRjQNkDc0k79vEzTMb+4?=
 =?us-ascii?Q?U6l8gKtbUHd29xEW0v1OfzMaLAH3oJV3OdbIpCUbw76M/QHu4ohXm0qNbRok?=
 =?us-ascii?Q?9QS/VlpgVY/K7eAVl+sNJXsQTTopZXJJA20VJUnpHvJOsZcUYTvPl7RyGuSE?=
 =?us-ascii?Q?QChme1Jsc998nsOzcbYhMfbh0FUuzqFPqs1Oa4kkJEUsBcfK8RSf41na2ank?=
 =?us-ascii?Q?ASmu6XJZ3ZaCZ+hl5OD48YhHnk+cqsrofI51XAFt1bNLNN5IfAfEojp3VMGG?=
 =?us-ascii?Q?YbAkmR2mS0erxLIXC+/jRlgYsF3Y66rDgK05DZa3AxRr54TeBlTP1eFOx8mn?=
 =?us-ascii?Q?NKFgeQFmjyZ9kdtC3VqqUjYVws8uPQ4fTXIJRJ8VL7lc+k3/t5bkDbqHMkEv?=
 =?us-ascii?Q?OnleRZbta7xRmb2cExvoa+g9TpLIZYybJqNyNN0XMTbNuskyvJc2B5F0eLm3?=
 =?us-ascii?Q?9bwEeNdhIF8oFD+1JhRzEFWU5G11NSG9koWFAVbHx2nPSY7gdRr7y8Cckmqa?=
 =?us-ascii?Q?xmHBV+JXopcWS1M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 15:54:46.3071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f45937e-c91a-45b1-7974-08dd53593b0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8883

Use it to store all vSMMU-related data. The vsid (Virtual Stream ID) will
be the first use case. Since the vsid reader will be the eventq handler
that already holds a streams_mutex, reuse that to fenche the vmaster too.

Also add a pair of arm_smmu_attach_prepare/commit_vmaster helpers to set
or unset the master->vmaster point. Put these helpers inside the existing
arm_smmu_attach_prepare/commit().

For identity/blocked ops that don't call arm_smmu_attach_prepare/commit(),
add a simpler arm_smmu_master_clear_vmaster helper to unset the vmaster.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 27 ++++++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 53 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 15 +++++-
 3 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bd9d7c85576a..85352504343b 100644
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
+	/* Locked by smmu->streams_mutex */
+	struct arm_smmu_vmaster		*vmaster;
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
 
@@ -1055,9 +1063,28 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 				       struct iommu_domain *parent,
 				       struct iommufd_ctx *ictx,
 				       unsigned int viommu_type);
+int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
+				    struct iommu_domain *domain);
+void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
+void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master);
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
+static inline void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
+{
+}
 #endif /* CONFIG_ARM_SMMU_V3_IOMMUFD */
 
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 5aa2e7af58b4..364d8469a480 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -85,6 +85,59 @@ static void arm_smmu_make_nested_domain_ste(
 	}
 }
 
+int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
+				    struct iommu_domain *domain)
+{
+	struct arm_smmu_nested_domain *nested_domain;
+	struct arm_smmu_vmaster *vmaster;
+	unsigned long vsid;
+	int ret;
+
+	iommu_group_mutex_assert(state->master->dev);
+
+	if (domain->type != IOMMU_DOMAIN_NESTED)
+		return 0;
+	nested_domain = to_smmu_nested_domain(domain);
+
+	/* Skip invalid vSTE */
+	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
+		return 0;
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
+	if (state->vmaster != master->vmaster) {
+		kfree(master->vmaster);
+		master->vmaster = state->vmaster;
+	}
+	mutex_unlock(&master->smmu->streams_mutex);
+}
+
+void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
+{
+	mutex_lock(&master->smmu->streams_mutex);
+	kfree(master->vmaster);
+	master->vmaster = NULL;
+	mutex_unlock(&master->smmu->streams_mutex);
+}
+
 static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 				      struct device *dev)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 358072b4e293..9e50bcee69d1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2803,6 +2803,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	struct arm_smmu_domain *smmu_domain =
 		to_smmu_domain_devices(new_domain);
 	unsigned long flags;
+	int ret;
 
 	/*
 	 * arm_smmu_share_asid() must not see two domains pointing to the same
@@ -2832,9 +2833,15 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
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
@@ -2861,6 +2868,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			spin_unlock_irqrestore(&smmu_domain->devices_lock,
 					       flags);
 			kfree(master_domain);
+			kfree(state->vmaster);
 			return -EINVAL;
 		}
 
@@ -2893,6 +2901,8 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 
 	lockdep_assert_held(&arm_smmu_asid_lock);
 
+	arm_smmu_attach_commit_vmaster(state);
+
 	if (state->ats_enabled && !master->ats_enabled) {
 		arm_smmu_enable_ats(master);
 	} else if (state->ats_enabled && master->ats_enabled) {
@@ -3162,6 +3172,7 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 	struct arm_smmu_ste ste;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
+	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_bypass_ste(master->smmu, &ste);
 	arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
 	return 0;
@@ -3180,7 +3191,9 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
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


