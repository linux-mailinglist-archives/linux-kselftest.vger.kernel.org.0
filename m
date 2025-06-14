Return-Path: <linux-kselftest+bounces-34998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56885AD9AEB
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587343AFA41
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390C522F74A;
	Sat, 14 Jun 2025 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TUet7c8y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845971F5827;
	Sat, 14 Jun 2025 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885358; cv=fail; b=JeQdEzPttxPMtLg8B7PcOpL5JeEVc34Bv4dAaT8EG28hN2QpL+osqs4qRi+ijEWy09+lPo4fZOMnwnCGJOjLVXh+fhk+wQrCssGKwbYYlFwSJhKH7clZx3HXy7qePnfqdf2BCqm5Bs5PkcwwKoGpZu7yb7ro34+J0BHktYczels=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885358; c=relaxed/simple;
	bh=n+rkcx64+hyQPhN4PzUHpRdGvLv5cs5pE7v92ObJA5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjZcTTCsqFwuNFQqeb0TZkVrjubxajG3a6BRqpdVTDIw2cvp8/33knps4HBOg/n9kdIHJGs/TUJRIfMjseFhbro7TNjYXONurWEP/ngMxEf4mjidFDwS/8W3LUWduSM3D7LmAP1MIkT+TGIv0r1BFnOcfYzsmSqUwySlzEjpvk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TUet7c8y; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0Rj5C2bur8NSiP6a2/zDIPLZBw33Lt6bLX86QrnoZyQrpqXPW9lpUoC6dAY0X4x2lItt0Aqph0cyv9qscNQxlLfosPZCAZz94/JFiP/PqHc1sIlaOPsVr3aFi5UMOZ5DsMecXDj6XKhXcvog8cJQzXFDv6NhdquVZJ6XYi/3Rg1Cm+ADY+gOeMKTj/If4xDVsZDL9M7Pd4hANTl7czwsgDbT7QX9i5BRJ2DadniJ3Uuve5j43l4wAp1hE1vFnzgqU/fQ6Y93mAgOMkwvv5T7YwUymKIvkWZ+N0kKUpDAqgkdOyvOU1qPC8nPRSJZkwNY87J8ve/4rQPLY7BrSg9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOZQSg6s1XFxdh6WUtP7ofdJND5RNxHt/jz2yshHVds=;
 b=aDUh0gNUZZ+gfP9MB6nxejvSl8NhRw7tv8Um3NMh82CsUJ/ad/u2H4XrYGRDFTUaAnEPjgayPQp+DCLZmt5P8iTK8txLgubRkK/MKvICNRbN7TjygjcJgB+1YVl+fEDIdLol+AkpBLMdbc3u5CtvHhxn6IQln6nKQa3LTQC4ciTHXGN+YYohPGiQkjwwa5Qd3OyZn1Byv+bd8ED640vR8V6V7uJH45yJCoqGPBiaqLqbnDadaiRC/1d55+7H9LtLigJCMNN9QcD+FZuMk5G1+S/KyzJskA4HG2CzTtugWaTQEMDEj49NKQ2pM8SwrcvEsXezw+HwihbdzfsbMp4vyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOZQSg6s1XFxdh6WUtP7ofdJND5RNxHt/jz2yshHVds=;
 b=TUet7c8yIxYFsoNGLrz1vKT+Q8c57RXD0fDax/IKlxFgr+LBkb80UrL1KniIaeeUBhg575VCI8cAb9NK/V3fHylC8yMbNMFiKoFYenTYwbodY6EGkzZ8kMNsEIAOBAG5vxsjPzsas7uSJcE14LdGAphPp+KVHFAbNVO7qhzo7AW5DIW+uVchoQ/vo1oyojLaZJiMWqS/IcRcwVBUb95Ce2EFod3+XNrvBOb4aRARgxGGMYyxX2E0JWnmeKYGykNM7uyzjg1BR2Ibj6PIMISvp43N/okHDU/ySJwVFq12hmtA1rpAk10co46YYEc/kYowqbh2SUtfUtl5RTmhcY+ZLQ==
Received: from BN9PR03CA0603.namprd03.prod.outlook.com (2603:10b6:408:106::8)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Sat, 14 Jun
 2025 07:15:48 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:106:cafe::27) by BN9PR03CA0603.outlook.office365.com
 (2603:10b6:408:106::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Sat,
 14 Jun 2025 07:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:35 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:34 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:32 -0700
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
Subject: [PATCH v6 19/25] iommu/arm-smmu-v3-iommufd: Add vsmmu_size/type and vsmmu_init impl ops
Date: Sat, 14 Jun 2025 00:14:44 -0700
Message-ID: <fec2ae84501938503d892ebe80ae332604c57b6c.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: a162a9dd-5e1c-4e94-c7ec-08ddab13497f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tMWtcaoWvvT72LEocU0ay8+WFoqSq6bSFEYSFhobtWpQ5dZOr3joNier8f8o?=
 =?us-ascii?Q?n9ozVc1EGRXVddJOhTy1GfseL6USagmEeekytKq3I/RbcyUtLCHW7QgyOTa6?=
 =?us-ascii?Q?DTk5Ve1CCexKSkL3zDFyO7GV61uu/faoWZq7qJ23HNMor/hd5H8D4FjCum99?=
 =?us-ascii?Q?VGy0ogMSsi1qhjZeFygaf4gRaZRVg6ClbbXEoWsgCFoFY6FD58PjpkfhE9yl?=
 =?us-ascii?Q?/bQDrkozw6C+nImd2B2GKpcBiG4RbyVEacqEjy3l1fa5uuGYiliQ27LeAo7z?=
 =?us-ascii?Q?9gP5GMcrMvMU+Yr7XmA12/FWetDTN3q7+xmi0dC342/LCElJadZQ8i0C8OuV?=
 =?us-ascii?Q?ze/wGlEX4/wUDhdAiD78TRTDkVRPZXiAZX5+TsQgV3RS4YyUZ9l3R60QJZy9?=
 =?us-ascii?Q?UxfmWuSgO3/v27qxblvcMY9dcaNMeTy7GGSyaa8MkVBC9KH3oh6wF/FBod5Z?=
 =?us-ascii?Q?6RYwkffJuTzr1l8zynRcGhTCzZf94+eAnsgShLLlVk0y6mSTDqmqEJvHd/WD?=
 =?us-ascii?Q?MOd1mBZ4/zrfYxgkYlsjM4z1TTWgMfqurZo6dT8sVqFz+v5TPcqSSuRY1eDx?=
 =?us-ascii?Q?5cDuR7tRNxScVty4m/0aTWXea/P58R1ODEcf7ApcyG2uj16A/2SggXRDKP77?=
 =?us-ascii?Q?NFMu5YkwOt04UtEH8xl9U2f8RsXD6wNHvgkpsdhRqDWTvB3HN62ITMXV/2sW?=
 =?us-ascii?Q?y1RRSKuA9B6prTZWqRNOe4v/e4Feyje9cwJ0xlTOln8OmQ0lDI0Nk19dqOzR?=
 =?us-ascii?Q?GM1FnixkI8ACbe6wmzHa6KieERu/bNDSXdo/xxOgivprbKu0ebLvKFy4g9FN?=
 =?us-ascii?Q?eKXiCHoUOxOqN4kpFVu40ScdvxFf6/nUvHfgZeMQHIfsUFjAQPTPoeBV+iLB?=
 =?us-ascii?Q?RDS2x2WQC+7aBxrRW1Npv2ojreMlQM9iSfDlXWlpaWOEj7LtTGSo5xpIb/yE?=
 =?us-ascii?Q?b+0wEe0INjBIGu7uFLabAPwkVU9Y3kDRaJ3+q41ZkQuPMX6eLX2qjLmOx5uI?=
 =?us-ascii?Q?V2KKVr4nJDw3Ibag+xoQ7/BpovNZsHMHDnFQ1h2YkhTdLW2QMXTXEddv57Uf?=
 =?us-ascii?Q?3Cq/DOMyewJWTI9cpstK34KsjDnyRjFAaA+T+z8yUsx4Y+ZZfY7IiT/vSKXP?=
 =?us-ascii?Q?qIJkIQRTYquZSPSZ1U3NNem6aJzUqJTIAEhc75kQqby2cmD0VYXWuhByuQGf?=
 =?us-ascii?Q?wbZmfiW8HFeODe+UoMj4P/kFgqBzsy8RiF+GD66rnimA0FO3trusTJkKHXES?=
 =?us-ascii?Q?v0JTX+HzT4Qx0TMhEQvhDeXy27Ctrnq9IXFppqzrjx5yar4/rSv/WrcLRYJ5?=
 =?us-ascii?Q?ggGho6RsZVUn01ECqYjxMkGxiiUn8gfQMZqp0iMLrGpX8XKnGe9P+0Mlito4?=
 =?us-ascii?Q?cF8R14thXe6j/j/FGheRcelquTYnUQcCf2ORYnYVNxXBKwmi7EtucVyRcwyO?=
 =?us-ascii?Q?Gv2JUYF72cvvIRLfsAHEF6V3WyrC6jW8QMu7i1SoivSEGKhRVDgnjLeTg6qz?=
 =?us-ascii?Q?GtmNEM2XAHGuCQrJ9C55ywHshia9UYTYXeMT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:48.0355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a162a9dd-5e1c-4e94-c7ec-08ddab13497f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066

An impl driver might want to allocate its own type of vIOMMU object or the
standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3 by setting up its own SW/HW bits, as
the tegra241-cmdqv driver will add IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.

Add vsmmu_size/type and vsmmu_init to struct arm_smmu_impl_ops. Prioritize
them in arm_smmu_get_viommu_size() and arm_vsmmu_init().

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 5 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 7eed5c8c72dd..07589350b2a1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -16,6 +16,7 @@
 #include <linux/sizes.h>
 
 struct arm_smmu_device;
+struct arm_vsmmu;
 
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
@@ -720,6 +721,10 @@ struct arm_smmu_impl_ops {
 	int (*init_structures)(struct arm_smmu_device *smmu);
 	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
 		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
+	const size_t vsmmu_size;
+	const enum iommu_viommu_type vsmmu_type;
+	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
+			  const struct iommu_user_data *user_data);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index c14f7e6b4dae..445365ae19e0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -415,6 +415,10 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
 		return 0;
 
+	if (smmu->impl_ops && smmu->impl_ops->vsmmu_size &&
+	    viommu_type == smmu->impl_ops->vsmmu_type)
+		return smmu->impl_ops->vsmmu_size;
+
 	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
 		return 0;
 
@@ -438,6 +442,10 @@ int arm_vsmmu_init(struct iommufd_viommu *viommu,
 	/* FIXME Move VMID allocation from the S2 domain allocation to here */
 	vsmmu->vmid = s2_parent->s2_cfg.vmid;
 
+	if (smmu->impl_ops && smmu->impl_ops->vsmmu_init &&
+	    viommu->type == smmu->impl_ops->vsmmu_type)
+		return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
+
 	viommu->ops = &arm_vsmmu_ops;
 	return 0;
 }
-- 
2.43.0


