Return-Path: <linux-kselftest+bounces-23898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0E2A00EA0
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 20:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526CD3A36CF
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 19:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC301C549E;
	Fri,  3 Jan 2025 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DkwONgI7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BB01C4A02;
	Fri,  3 Jan 2025 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735933504; cv=fail; b=rxG4LHa2yyLHDtxEnuTUJ5rpQKIcU2gyfw0BG9nxkmjOcR6ljzGDTEXNP9swHvxHIBG6Ck+1TM54UHSm5RCvinl0BDRFOm256OI+rjsBCv7345qkEH1VcMB9mHeiMc/+rPrhAyLyxW9lcBwPE+e/tGJyHTD8S22/e2z+mLJd0YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735933504; c=relaxed/simple;
	bh=V0sjKf0avw8e+1y+FG/b9VwoOJNSFILawDksm031/sw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsaUiMl9Uuj873JbdinPnuF9cOP9iWGZV0g53Jpw0khldYIWg4NoB/2wfjhrQCLmlNE5XaTk/BPesC3U4dS5kyXo29Ve6D8xomjEcoOfEokNh63zXlzRxKNG56Dpa/GcLgV9/3wVsJOgFFbZx2f46NkjZAq40MqLHILlo4JRlik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DkwONgI7; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1m07moqcaWCTV7P5TsgeRpHUx6LsYNOMmyKAbB2eGbMOQ9pvUVhKJHTBbwOqZL+qgpX04FVdU8k5OcAsmhXA778ZyaCf6bkEP0VcfVj8HR4S99QI8UbLvKCHWcPo31pZbovUfY0KxoNrwHr4IOl9l8xYSNV2NFeSlFHuziNfbXhRSVFdDMPu+XwbBpnwcyxBodOEuEfWEG3Eu84x0ISrnSI6SESjYr4aCj/9QD06+ReTGgTq9ApOMh//yWAMj48GSTt8Be+JZj3CaSJQNEPiko4eJd/eIFe7zEfrbhKs1i0mz165eiqjVydbc6lFo9CLroQW+zII/WL+ih/zbjTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qec6YL77/jkxX2YV1NOAbvOY28hyb313lbUXvtSbt+o=;
 b=bJwcjSCY8FD904Dqal/0h8DQe8R90Ixf7gvJ+lYTHTKlUIh0ZUxlS3R8iBVXCac3DbIdG/PjPAW617Z8W90aA249217fcZAj1Z16L45Z2u8m2Tw3jpO+dosc5yMakVB89CoiC4cMwhDg3MNc6E7RBr3k0OgYnE0iLZ30uVrk1vpNIrNrp0PDATqqj7S7lM8I8M0/XBAV4LQcJ46q4nXQfvCKNENv4hAY4zK2UwzZ/BaqnGVs+FwSPnYwAmAxGxZStzfglfV3qfyuuy5J+cBzAHcv73GdWnq9SngHjIQDrG6D5uSSXXyrxP0OkZpb8GehsdlKvFEWV3BXepnTxWV1vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qec6YL77/jkxX2YV1NOAbvOY28hyb313lbUXvtSbt+o=;
 b=DkwONgI7CR6zwHJJAraupgHkOgMJ3YhqKguAp50D2MKBivoK0jGiMZ5hjAFn5Y417FSiVGSr3UkVqj11s5UU7UZOZqTGxGlOtM+Elww7rp7KC36yD3imRDu/791nzh5s2xokoojgBKGe1XIErvslmtem53yrZ5aWql4jeeSC/UA/Bgkc30kZ5eV4mB+xQWP7CMeUzeP+ydduYqTsbQTLYdnvwr5ZgZcFD+urDPBQfaHV0hEQ8ZjCqQy9bsK2CK99qZ+MfrVGLAphXzyU6kXIGn954lM5Bn7VySgsvijJHC9bZXW9sqA3SfGOrc60W4vHSTCtfrgjL9qJQZg07ViSFw==
Received: from BN9PR03CA0739.namprd03.prod.outlook.com (2603:10b6:408:110::24)
 by PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 19:44:50 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:110:cafe::65) by BN9PR03CA0739.outlook.office365.com
 (2603:10b6:408:110::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.12 via Frontend Transport; Fri,
 3 Jan 2025 19:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Fri, 3 Jan 2025 19:44:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:32 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:32 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 Jan 2025 11:44:30 -0800
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
Subject: [PATCH v4 13/14] iommu/arm-smmu-v3: Introduce struct arm_smmu_vmaster
Date: Fri, 3 Jan 2025 11:43:36 -0800
Message-ID: <81bb9842db7b9637c3174974d2068baf3e515e70.1735933254.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1735933254.git.nicolinc@nvidia.com>
References: <cover.1735933254.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: acc14493-1cbc-4cb2-1f7b-08dd2c2f15dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Za5faOi331N2y8tgs0nAEgHL+hnsjjiptfK07G2hvub5Vpeoj06ruKLRB7VK?=
 =?us-ascii?Q?Ki9xIBb3nq7gJ/rlhT59HAJ0rhHilDe4ntqjgkk6R6zxYbU9CBvowiDzVqYr?=
 =?us-ascii?Q?cVBFsjTWArJN55p2YkM1rTcst+Btk3/OiYg626thkGCuvxl6HNryu5QraKxg?=
 =?us-ascii?Q?yyXDJDUogLzuKpop5vUuOy+0OX60uOuT4iWrZ0/sd/JE99jH8S4hjLS4KfmM?=
 =?us-ascii?Q?hLa1TK7vy6sHCNeY7bxx69/bdgPQY3hBPAj+BObyynnsb4GtX8rj9gL99CxU?=
 =?us-ascii?Q?uGzrWlO1L6M0BHnDTG5ikTAiUPaTucdZFG66PcgkEO6+XXVJ9sLf5prGVIBL?=
 =?us-ascii?Q?H/bdV/ucOl+nOZpVD1ZMJnXwToiKhsQMMARONCkEjBA48PeCA6sJabvcuDPH?=
 =?us-ascii?Q?rNKuipIf5rVXaTuX8KZ+jotdfJpWcNWvMsNhKRIxJ/zhSZ4q9hqCNXTdu3gb?=
 =?us-ascii?Q?FUToMogqMxwhTpwVMyRwfu1ACgfwHsRACiYCIxTfjc1jrBeKvDAUiQWOtLwI?=
 =?us-ascii?Q?o5Mi+ODjnShk65ag8ud+KXjR+oALCmr6Lc0EACD2POWcNJXvTAE2Swxh0AUd?=
 =?us-ascii?Q?d68JY9pKtceRt8ryI82poO6fy+/x6BS9zAoIdMy6wIR4z4pRaPt5/RygqRke?=
 =?us-ascii?Q?ctsrqxA7C2zbm9eGR1Vo2rwMBww1GWyvqyY7JEBlrzSuA3EeKDJbwRpz3A8D?=
 =?us-ascii?Q?0cf/49gm0DaMB5eU/gbnXTRLFB2DGU6xoexi39RoQLsCfAqFRvMMI+ROZhQD?=
 =?us-ascii?Q?sZWcZSQ0uQO1+BNS7bi8eo6f1rBMPwJwCtknThIrSrTnGFa/7lrXQESyu1lc?=
 =?us-ascii?Q?tm22UOnwGSCEBCFAsC8MKXvDxiDcsK7B6yqnYUVkvbkg7RPJ51p693xp+a1N?=
 =?us-ascii?Q?5E4/yeGTmHlApk3IMg+RqY4o9GaIk0lRtsHIA0FBJ5sgPjCWap8t4+/5uwyv?=
 =?us-ascii?Q?y9kFngIRLftIZYm2iC6cJW1nXUAVruExT8Z1atJJWlLg9W4gQni6sMH7ji3G?=
 =?us-ascii?Q?sWVF0Gz+E5r0+dUkv507uoXEGDCCKSfK5P2nnkXXZtHLk/M3odNGBXXW84J1?=
 =?us-ascii?Q?dirGzdmTY5TTXqcNuysu4bUv1py8wSHMoaqrranGsf4XofdaqsESSmCrcQNq?=
 =?us-ascii?Q?E0o9qUpOEpQhZgS+FgLAofZzLLwDsP7JGNvH0kfFAKj500VmeT0sq/dNBEOL?=
 =?us-ascii?Q?d1/OhzB5eXt/evz1GUb1Mr0uHMyEi9Bwq9Fl2UG+FGb9D2PeisGmzL4M4E7P?=
 =?us-ascii?Q?WlXU0vuGMIFxZadaCJa1C9/rUtK+pH6QigpwTbWroPezMW7quVie7oCF7LCo?=
 =?us-ascii?Q?bIa49VmULl/F4ZWY1Gpz5+AH7YuxFFw77Po8yDuC2tdCMmQNHd3++jApA33r?=
 =?us-ascii?Q?cKL0jFeN8Am9Bg8wTOlPUsWRnHuZpdlb929eImYUEL72o99t5q9qaHkbBSYz?=
 =?us-ascii?Q?zsLN2ld2SMplwERaCyLEzjS+pujtZC4KpU+2juQGwFwpRvSkbf4mGKXfiZVO?=
 =?us-ascii?Q?NzMeCIk1NzFgHf0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 19:44:49.6123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acc14493-1cbc-4cb2-1f7b-08dd2c2f15dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279

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


