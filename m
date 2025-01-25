Return-Path: <linux-kselftest+bounces-25153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E52A1BFD6
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 01:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82D118901A8
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 00:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643B4155C87;
	Sat, 25 Jan 2025 00:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QEihLI/4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFB914D28C;
	Sat, 25 Jan 2025 00:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765092; cv=fail; b=D6MCGZp2zrlj5DY3McagBHBXwT85lufNC01OxDZQO1vfI5J46hxcS0cQOS7omDS5JmnpqocnzabGfLbaDrf1n3R2zDozWDOjmXk1Fr4KTWBCCFkPFUHPUXTvEBoZ98dujeAR8UmPlgWfa+CfuL41Yx7cseo5qRYseBKMkn6H3kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765092; c=relaxed/simple;
	bh=JWMVS5jfHh4pOPW0KPune3VwmKvmWRE0u3fb6MQIuYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsEtQoSqxIXSBsraBLZRRZ2h5BJxEfRzJREknTnJlfGTsszkfvultMXVR2ANjcT6J+XIQx240dVHyTQpsEKOi+AoKmKRf2DVcuwcO7tYd6YiiTH+DlaZfEg9+0mBVgdnDiDLBGT6uj1nAlLzm+JmuoLFdoq6+we0Oi63s90FCxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QEihLI/4; arc=fail smtp.client-ip=40.107.102.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1SBc2AcdCaYxOFcBx274EqbLOCIp+VRehdmxHiGf0P9nBBGG6pnsU3amqycbHKXUKHbaADptyy00+BBj+5sfwutGAeWhu4oB4FCrKOIFvnAaY9pYdN4UPL9aUDglXc+WeTB1i/o+KFxk2I5QI4QgjfCx5PzzYkv5i8GHGqXufElqRXr1qJ9xNUO0C4/QI23Gu9qgFAp6EobDMsCe3Pr3rSWVwsm47VIg0TVrlP2+suQSTbVPa8Mc0BJIgkcdFxoALa4x5F2HmS1REdLW8+IV88ZPv7WfRvHgMD8wi5DMxecSIZJ5MRDEkFpSm58+SGa2xCEb8KLGtr1mDwHWmAM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z33hiIVjzITDLyv3p1EoxttLpNxcG91reH9dqnWPbxg=;
 b=lT3lMu6M1VhJcKX0+xyPvfkJKgPfVaB4z7e8xMzIKsiXep3P8YtcuTANeTzIU8wUyiIG9OaokU8w0eYzJRteOHSDmi5RSY0TyIM2927Gh/xsE7gFh4Qi6eZkGBrbzm4hC4XJ4bIxPtIhXu/jp7pI0L6DpZvjtm+wSc7QGqVtt0ZzstNkmj610/vMdfmZGS4Rle5SSquyvESMIa0k603kq1N2iiPk2w8YD6PTfCp3pzeMi+gx3Nf+eYPoWNpn7n0mMTZ4wGKLVoKCsU8HmX1tSORQiITXx9mGwwVCBlsE+ndigroohItLUep9MAbab0YFKuazwj0p42FufSjgLMY0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z33hiIVjzITDLyv3p1EoxttLpNxcG91reH9dqnWPbxg=;
 b=QEihLI/4Ey+bX3ls04fUm5qWvK9Jgohnh4Dji99i4rFrW+68joQOy7CmldT72ycfAfye6vbq0kDmKBddrSAieLlAtplq5gWBBWy0Y7+sWqYcvrfR7d+4vFW29Wyw7EQ1se5eXeAcbiy56tfGJeeYhqYsOazdijwZkeC4GH1qgvbFTcaPEZsaODw8ff5JfQseX5gDCrvUpNcIZHCbccpJfjpUx2DTib83P4qDbF1d4cV73VMNucqx0G243Ej+fRTh/yPHJs6Es83zifdEiV3syTBG//XDj9rpCgfAdjyQM1q5XOtmgj0e0rAh+fbAD1/YS7Y7Yg0mk7iZwpwjXz5Nrw==
Received: from BLAPR03CA0122.namprd03.prod.outlook.com (2603:10b6:208:32e::7)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Sat, 25 Jan
 2025 00:31:23 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:32e:cafe::6a) by BLAPR03CA0122.outlook.office365.com
 (2603:10b6:208:32e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Sat,
 25 Jan 2025 00:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sat, 25 Jan 2025 00:31:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 16:31:09 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 24 Jan 2025 16:31:08 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 24 Jan 2025 16:31:07 -0800
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
Subject: [PATCH v6 12/14] iommu/arm-smmu-v3: Introduce struct arm_smmu_vmaster
Date: Fri, 24 Jan 2025 16:30:41 -0800
Message-ID: <d68ca2f38f28c50a3109bc5a84716ca79bc3d7f3.1737754129.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737754129.git.nicolinc@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MW3PR12MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: 011ef2d6-e4c1-4650-f42d-08dd3cd79899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TXpO3EkSLh0PmYCjEXlZaCzfvgujYnU44SGkClBLagzk/FJtBPIpJU7KAxu0?=
 =?us-ascii?Q?o9NJkpo4XMAyDtUNed8dAp7sv9nqqohUN3Kxhq5PANLRV9v8wTbNN/BaKVsN?=
 =?us-ascii?Q?PWSMvIG3nQn77cHKvaoW0WN3FeBC8YViZ1aAVDGL3cP+xn6eqdfkyPDWCHT0?=
 =?us-ascii?Q?upwPErrEy2Aa079x9Hv6++1CQQBe6/r7e/bnBCgLvASikASqw1JDMa78BK2G?=
 =?us-ascii?Q?q4Y7UY75c8CZ8/VUOVRxHe2UEPNcXBYvv2Jaa3omLqav8s+hVRWWCHn5qCJH?=
 =?us-ascii?Q?DxGB/3n/QuGzEknkQuJMU078N2ST19Ia33iP4Nt52Zm6xkYtw2B0VYGLlaR2?=
 =?us-ascii?Q?4kzLR7GlYZEtZVWTiin0/ELo6fIBG2FMB3Roa47G072dY91eYOvnnwMY+tsw?=
 =?us-ascii?Q?OmKTWGHlLcZ6iDpwM2F2WpYGMpwhGjHzBhulTPNZvk6yzZVugtAEIJdsfEgR?=
 =?us-ascii?Q?bEQKC/KH/2SEeeDLdofWeBQ4rOB10LA5AxxCRVDk94unvNeEdWssvRSySHLU?=
 =?us-ascii?Q?KcxnCzgM07syh0YHsOBvlDrGUKYgTr+Wa6LiZRnzmtRqCxFqqakk7uDpayTx?=
 =?us-ascii?Q?Fcl64c45cGvBVkRGUnjf2kYsNxDoi8Wqej2MZKGW2C1ytUgBE/sP1xa6SPpQ?=
 =?us-ascii?Q?cuo3PjbVru2+ndUWQ0/iKWA9j2aNVviIHCV//K3ZOe8b79xuAB46qCpwAuTc?=
 =?us-ascii?Q?5ak57XJVt8wYXzEwsPcd4IpT+McIk89iaAsCwFxa2qC7wB32zAQwDI3IPGs4?=
 =?us-ascii?Q?S3ULsVdxSzgO2KNRwGIUWFYDRc0ZvNCHj3RHnzBetpy5Z3GDRT1e8qlWxf9g?=
 =?us-ascii?Q?bXWGQxH5qUVOJGYBAPqIqisidUtVuFAuUs9JrE7qzQ5QlRsWuGpXBMSKMHxX?=
 =?us-ascii?Q?z/ivG8X2VFzLNpWG9L4teGWgHHQpx+GdQTN300vZiyaR0aS5RPDbKi1cFadd?=
 =?us-ascii?Q?9pxaWymQ2mwCvfDLv3UT24lFLtz8O6nR1jZ3zXLjBI4CB/+dqfbPoDA2vr0W?=
 =?us-ascii?Q?xu0zCbplkZL++68X0nDsjIkpGJEl5iB5j2TNILhKK8sDl3jpDKWPI2eU4pb1?=
 =?us-ascii?Q?6qoyhlmDTYkruWRsgA6hJoet2YVyYgm1BdcJw1wVttqcHyzT/sJ0jx75cq4g?=
 =?us-ascii?Q?RXEs2NFHjyLG1Ge+hXxyc7xQRYfwz1lIwbpCV04KLW8AGJJi26FtnILcVg5k?=
 =?us-ascii?Q?GK6vud/cJHIifuIQr7Pq5EqYYZAuZIEbYxWCBvUy0z0aW/gpzjsMHe/YjjCu?=
 =?us-ascii?Q?loEAgpAuHDb/YtavE/Ci9wydHaYIf+DQ8SOGZ1QxZLNpqkmI8nUR1l5VD7mR?=
 =?us-ascii?Q?odlb38pxkxa+nwiLeJU7wCjQVdkz8MPGVzdGlkGVwh8lQj7g/lfmslhJUtdj?=
 =?us-ascii?Q?KXRz+A3klHcM2pzB220DEGJVwoC3Vy+AbDPeiLNCP6bXmcteRThEsjn9evNg?=
 =?us-ascii?Q?hdoDR907KkKVfbv5849y0ZXuH41xmxSlT5L0Nv86DX0U3lg6OVnf3FivJK/z?=
 =?us-ascii?Q?HLhomCX12PM6qXY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 00:31:23.0464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 011ef2d6-e4c1-4650-f42d-08dd3cd79899
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 23 ++++++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 45 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 32 ++++++++++++-
 3 files changed, 99 insertions(+), 1 deletion(-)

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
index c7cc613050d9..98138088fd16 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -85,6 +85,51 @@ static void arm_smmu_make_nested_domain_ste(
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


