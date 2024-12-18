Return-Path: <linux-kselftest+bounces-23491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB6E9F5E26
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 06:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C34F07A3728
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 05:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D5D194A74;
	Wed, 18 Dec 2024 05:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DU2xp/5Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49519004B;
	Wed, 18 Dec 2024 05:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498125; cv=fail; b=uulzt2nGTKNgxiDl68eq0hHhI6oQkvOZyQ9Cc6ZcI7pNEBp7Yfu9/KFjzrX98zX4dyaoX3WeBWegqcY502qHp5CjNKcfoYXoxNIxFhTRVvcPJN5rXVGiP0tU1tgGlUcH7ejVsatE5KNQyQeLGwerlIEZSjZSyTVOkUxE/c4/ADo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498125; c=relaxed/simple;
	bh=V0sjKf0avw8e+1y+FG/b9VwoOJNSFILawDksm031/sw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9z4py7mqIzlkPCz7QNeCzaeBgzyOVk2vZIFESbudmDIlP9s9drPcLBzhC2d2eCfqEMR4kmDvubiYqJTAOJt+ZNwFOkQLFjvEMoJD8SXn7a90DTdJqHzjDF+pgUu2OZlRjyyGDXn9rEv0tCPJd6VERKbjFYSj0j+E+tnemMtImo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DU2xp/5Y; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7fjdoIsXwW9eU69RIf5Y2Daka+FKhEAlQrM6tGnkmKSZGQ2lwkUxsxY0tmO91seI41iYQ8V7W63zCcuqVRECX4kHUzAvcKcXqYuan9NIG0DWfem2Y5LUJkB9lJbe1d6XZU+HbIFhMSzU3OR1TQWw1BqgMnlTsQuCsGO6gHXeIUEoVv049k3C/Rp/OB4CmqIPuU3giItdU0QZbMDpcX+OnQaRCuq96ywlDjLZoJMjs//sAN588IEFigVfO2FgAYdA5hv8gw+wEIjQuUbYa8t7Ew/X0ntYyqE0CMd0wGhGE6vnMaNT5xALtCrtwjFngnwvC+I+TqGNrA5VXos9AKOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qec6YL77/jkxX2YV1NOAbvOY28hyb313lbUXvtSbt+o=;
 b=m1zpgPT3A2xtXrYnGfYpTE1EFybb16VmjBTd0kbUt3EQoMBkiPJBtGaOGs6z4wl5fs3TccqEmbv7XT9A1fJjYkVVNUFuBFzL/zGh7HkW8TSGZqsPGByMpGwFYWw+D6EaYHtyJtQFcJ8T4woCYx4P+I0ohfdUL4xCdBAP61ceA3Ql14LwkXEseePZte+blhuvQyeOX+LN+T4xyTq8+GgmxW5tp19I9xhHbrUvICgiNrzJdYoKDtO7ob6gmKYxQ5NHzfFSFR/52tFrw5ynS83nA1Djsrb3eW6Sk1vdlJP+mTckrrdE9oKFlcKQy7/Vpafzn+hllG+BmKmK71HQVRt5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qec6YL77/jkxX2YV1NOAbvOY28hyb313lbUXvtSbt+o=;
 b=DU2xp/5Ye2k6teWkaV+PSsH/o+g/uFZqDFiNkqWpfEuDBY9GC4TNdvSD98gUDIsM9ONm+bgHgN43RkrCpurBkQLBGdaYivxGtYy+rLkpPi337HfID7K04PZyBnrts6Ptu9SeK9bSc27F8y8wqebwFyNSd16APPMRAzdja2hWcJsxQTkmdt7BHvMQd1ESWhEU/r+LKIWuU/krCrbSDPsVCnA0nRkurKri1NQfw/i/TFSqqAVlnW6aYPDEqg3tzAyRsXjUyLUhdgq9o2GRMpv9F4SkpBMWRcJoRhKujSOuEd6qY1vz1giBS+nznn1LRKBkZw3atEDvDW4tBejzTDV0wA==
Received: from MW4PR03CA0072.namprd03.prod.outlook.com (2603:10b6:303:b6::17)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 05:01:59 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:303:b6:cafe::6a) by MW4PR03CA0072.outlook.office365.com
 (2603:10b6:303:b6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Wed,
 18 Dec 2024 05:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 05:01:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:44 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:44 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Dec 2024 21:01:42 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v3 13/14] iommu/arm-smmu-v3: Introduce struct arm_smmu_vmaster
Date: Tue, 17 Dec 2024 21:00:26 -0800
Message-ID: <7cb77321246cd7266068c8f2047d00c53bd245ef.1734477608.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734477608.git.nicolinc@nvidia.com>
References: <cover.1734477608.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa05012-1dec-4f82-4b8d-08dd1f211a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NNO4MtCeD1uJjYqUzHC1TZSaw5ZgNV0ZLfKMMIeAEl1+6jnQeE3H6zm7W6H7?=
 =?us-ascii?Q?ATfmt5fsZ7cKbrCw3n+bcyA32zGMTDIvGNtX+CpJG9JRBFvvcpxpSmhBpYsc?=
 =?us-ascii?Q?EiTHHgrHsbIIjNxmvy0tPA4Z5wIpztEicAlUu2emLXJxUsSoz3jIWBNo9vui?=
 =?us-ascii?Q?G5mIlPcitosorRp9Wy/lqecLtbXw+Ib59Ne09joEgVmDEipZeTciodYG7SSC?=
 =?us-ascii?Q?wcSSf04aBlMaZKSfC5tyMhUpIYP8ajQr0gTUVJ1AcNFE4QCR6mwsBj672x0X?=
 =?us-ascii?Q?LwxehfedGRn4Mg7oAMa5gR9mQlztuy31rKJ4jwMdygx0sod16fpH2cz+4Dv+?=
 =?us-ascii?Q?3Y4cByegNDWUKN3H96mxJNxQpsVd721KDk8oqoC9ZxEtPtVutNmbwlJq8Tk/?=
 =?us-ascii?Q?/1dZzAI6L8l3ryK44TvYuprmvgNNQHQtAnNFnJNVDvt7d49iqRaDEKVrPHs1?=
 =?us-ascii?Q?/Jwz/inrOVA+kTVFlfE3oTKHFaIekCiR+JPHcZVlGOWevSVKeTWZG6ri7XFm?=
 =?us-ascii?Q?0C8REvHZ96OMHkrTG6D8NsnTBpSgRn1aWT3U4ksM1f74NGJ5FKS/YuVY6t3S?=
 =?us-ascii?Q?sNorxb+AxLYKEsHZssC5fwgSBpgAeL8i0DCvXsd5umJoDdaJ6jCpmxy6i06m?=
 =?us-ascii?Q?Ra6Ao5nbqKUiagZHZW1gdmIawAXHzeygi0mgDJK9DntA/M3rZJUvksfHUB4g?=
 =?us-ascii?Q?kgHzbo/8XqXENi9UEF3KbQzeI3vT4thO/uMZUYNdnxoxfJ+oleDGBncoPjGH?=
 =?us-ascii?Q?tseUjfPr9IQRHLsIL4jvUD/OJ6cdgNXVnOLwbaQMAYqGBk5G4kUjs9pcJ/bX?=
 =?us-ascii?Q?AulWAwcvxFUxmW+vy3DCysn3QZEELupk49JbsI1urz32YTVzQ0GUl8hjBYu6?=
 =?us-ascii?Q?eB6xTkMqwE+x4FQils21nlEAuM3L76yN5NWmm2TjOA1p5TM3MsZ33KgW7B0z?=
 =?us-ascii?Q?3so6qn1pJQYk2RHwbMLN9MmKAmLmxCuKfa1Lh+VS9omPrqNnqBEYpTc6g8CF?=
 =?us-ascii?Q?FqQ70mfDBoNEBjx90ZCsGMfGAZ5Eb424QnnmT4qnUa7qtMKlVj57SaH8apTW?=
 =?us-ascii?Q?ZYoeGowgTFLDEWWJv6bDe8VDVG2KeDXRq1kHRDyYZDoBgC8JDuncFgvyewZm?=
 =?us-ascii?Q?S8wx0FlWDmDJvsm468+XvqU/ti1vl8LTkWd9bKvXrSFm/GDFzeWpm5zO8Bjs?=
 =?us-ascii?Q?Sh0SAyKYt6lYk+0IszV/LAd1+qfHlqh1OKfisUFACEh906D2R8BGpVATUJoB?=
 =?us-ascii?Q?uQceNBgM9VJvdxfhjopBlzmzn6z0oAQbtmp0rn/WQi+iD/cVSwUNhf3lsTBt?=
 =?us-ascii?Q?POmWA0iJBSFXlSCckA3HO9+c3e8CLV//85YIhS3DHIpyt+0gNZDvN6bltrkV?=
 =?us-ascii?Q?Pr7AVt4wItREDaYCB2tdsu5DrsM4q7t1MoDu+6oHSZKqbuE0PN7UIaF6Au9+?=
 =?us-ascii?Q?VFhczkmA+6TcHOZTNcx1IMtDq7lwVS1f7/C94/ETEZPuhWX4JuAxgHOpSKN4?=
 =?us-ascii?Q?oi2BGnrTADBgAN4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 05:01:59.3847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa05012-1dec-4f82-4b8d-08dd1f211a7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106

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


