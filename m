Return-Path: <linux-kselftest+bounces-36630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC486AF9D6D
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC7416884C
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D513E221FBB;
	Sat,  5 Jul 2025 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ACvOUePU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40E021CC51;
	Sat,  5 Jul 2025 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678088; cv=fail; b=nKnE250DbbytE+OlVeGKW/58t4jZ38j538u+ySjFPPThtLzOCigdtXibMoStchwH01j9Id1W7ZewuDNyjH6nbRN0tJ76rZ7PiilgKM+6rKJ6aKQZHQ0VULWmBAig4+VCTBkwj9w3lVnOPd6hm5LsuFtYjbm0dBddmuhaEosI8Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678088; c=relaxed/simple;
	bh=aOQV7q5Rh+wOKG7a2JXRyReyFSc6WjZwicPo/YTohyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6mdv4IAyc7kJYew71IPetsk2yLmwhKnp19O67DArv16dMjFWZg9/uUNdip6nrTUGjQN7eGfoM0tY78gMrZzyQWiShD7DOolfhJRgr3LNqMBrR6IqzLI1x64jtp9e77MQxSHhNaVPosblD/z5Iywni7qvFt/ORzFm5aYJqO8xac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ACvOUePU; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWA/+gd8UIPOtZnhjsK5/1owMIZoPpjqxxBTUtZ8YrLpQ2GvyZcf/VlNk/ZFff1Jn90Oa7Qi6uak3NzkyJOI8TClEiw3Rmcdk9ck/de97K0Ya9dQR5UPdVnn7pPioUlBbOPD328c5Mkuhi6BFRf5hdVA6MK8YL6LCKwTCCvz5Acnblth+n1kgk19GnG8EmKKTkS/rRI4EPsZPv01wvwL372RAIpCxqu6UE3PTtYiTFdt2PkEM17psbkzSoUlEYL8psNl8SZe6Ydp+MfSIpTnwy0SEvgu+30c3lQiKyYeHXJtBN/gQqy5oQOHth4z+jYvgL5yW6iXjFmI0AH9aSnT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGQv4nX3+fVhV2cw+RUxw8zCOhYFEiT5kmRO1XEu5Xk=;
 b=Mfnmmz35yos5XNEg9W6BZXAcmEooHuybK3q6NCCI06JU05R+Fc3IGCebwtyltaJ237X4QrVkaJZq2sLYjFHHlhBCcQR3ayTysHgzLwAYB4QYJOvDXa5sRFnY6BYYAsrHFsN3eTKSVJ2l7mEp3m9Xhb8ANtIgzlHkItNn0eZxZ/bKkJ/lv94l0HE8sCGUvm+nsZzCpWPQL4cuos8aF7ursrSL5rRyoTm4U/3EpjMLl6skrCGOR5BHtkkPMOm2XeVL8QOLO4tQyEjgplapKRAMXcojx64UbfGmw4U/6u4y4UiZLKCU1RmlrWeEUezHdnj85BMaVLCJgw1aT4tEprnzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGQv4nX3+fVhV2cw+RUxw8zCOhYFEiT5kmRO1XEu5Xk=;
 b=ACvOUePU0JADX1X68rINMVQkRzifAdm4y6LqITDsCretNjyzH5nZuVWKsJ9lg+j38P6h4qcXU4RWFsixV2dAtodXTZ3pQRNRIQXBh5ai1/hqW9+OGXYPLt3Mwx7z0VRNduK9av4iSWbGSnwLHkaXtPRBn181aYmyBkgs+BRkTktyawb3eY6yjJkDdt66PywmYLe5wXiDHgMOwsKDngxKQEZZVb6PzOoYxgVd4D4dpnN3sG4qz0VLsEMFo5ysBs43R+EVUH/c5SZDWLgV/BrDu7P6MmxBa5wgLVQZCM/GfE6qa1mLMUdiLPHZEqLuDpInjzxoBSq93Bj6rAe53xdFWA==
Received: from BN9P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::25)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Sat, 5 Jul
 2025 01:14:42 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::ea) by BN9P220CA0020.outlook.office365.com
 (2603:10b6:408:13e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Sat,
 5 Jul 2025 01:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:31 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:31 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:30 -0700
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
Subject: [PATCH v8 23/29] iommu/arm-smmu-v3-iommufd: Add vsmmu_size/type and vsmmu_init impl ops
Date: Fri, 4 Jul 2025 18:13:39 -0700
Message-ID: <215ea3fd9beb2e2fb0454133024d171e376e7e62.1751677708.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751677708.git.nicolinc@nvidia.com>
References: <cover.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0bb4c1-b082-40da-6d71-08ddbb61527b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FB5MtJjC5oBu2J3UjUsc99sQXkM+Y3wG/40HwjROWvGA9rQPzNIGse93CuWT?=
 =?us-ascii?Q?7zsKuBHzgdOfHCj4lOqvqveyq8j41dj0BTMtELha0zZJCTdRIl0at2v0T537?=
 =?us-ascii?Q?o9rE2ZliAM5LECuJr/u/guqIDAL7t3V3gDBqh+VH3f76W9mhVCvWivmEkjiQ?=
 =?us-ascii?Q?G1QnGcCmDt6sJ3cI3wO4H8iVzfOFmToIhB0asqT4wYSg1JBXFHuu6Prhhzw+?=
 =?us-ascii?Q?tH8hoSheIOELlVxVV0zgWOz19T1uYkG7hw7QzS2c6cmL5vRUCjIaHXlRzsfq?=
 =?us-ascii?Q?yBJuU7Q2W3zbC7w/vuilcss6k65S5KLt/UuwB/PCLP4GWs3fpuNrHtn46Fbu?=
 =?us-ascii?Q?iCpIqOhPuD5lFBKGxr65W+qhIqUVdOkVQ9f6H4bjbdd7Lk2CMp5AkRbjmgqN?=
 =?us-ascii?Q?Q1c+lBtSGUw+WbeEjzsYs9MbsT9I9rGtK4md9MF+DHkV4jNJu7MSQ9W3brla?=
 =?us-ascii?Q?pItimctfQGNCDafmvwoGGrlMbxjIKuh5wbnseOsbzTwmf5wCnJCmR1xhIq90?=
 =?us-ascii?Q?eSDuK3jKE0YxfmFE0136uh0m6JbJ4uAjCYCHDfS2YXD9lEehq6Fe//Fu+3NL?=
 =?us-ascii?Q?I2uuJErisPsmttijvTvdGIj1Iys33irMWtemOGHBzpzG5JMk43dMloabCHsb?=
 =?us-ascii?Q?OZ1H1pipPBKC92ChAYEJ46oOCzbPuRP4Armv4lNQYkIFA3AjIV5o17H6UyZj?=
 =?us-ascii?Q?AM8rEggvYXaclGePspy5KO+E5odzxl1SaocMwzW/dGjrHAMIctPkAvsg8JCg?=
 =?us-ascii?Q?1juH23q0Zs5aRyE6CEay4wDg/MJFWXALJAqJWwH25AFjn9l8fM0clzanbLE8?=
 =?us-ascii?Q?s8qWrbF8lC5r1n83IgPaZOUkQPDK8x9K2V8O6KgaKmcct3B/RS1KqoLap6T7?=
 =?us-ascii?Q?sDTparwPJ9bR4m6bf3UgZV4VW9KxT6B9fATO8KKnX6FFRHYP0vW1/heKAUPR?=
 =?us-ascii?Q?5tYqyB/2a4pWA1KOfH8tTUjYDwC/soYIGQRYlTWVKd+KChgeZsJ49HAK6val?=
 =?us-ascii?Q?8PdQ1hl27ZXPTycTdjgUPfPsRKXY0y0HECVZdVctNkFJKnwx3rtZ+3JMxd3W?=
 =?us-ascii?Q?GcDl3KEMtaJ0rXozm+5z5UT47V2TEu2Z/M5yJ+BG2TsTzEbYGkkKvTiB8TeA?=
 =?us-ascii?Q?v1FOrKj01zQvKeltyAPXmZLsFyXCwZVZN0jIh7RTJiotAqmPKPfsQ4G5zn0r?=
 =?us-ascii?Q?NSyK7Rts1f5wKCWliHMPJjfMNXUMmyW3zAjje/9egse82cvkIhxHkzl9ETXi?=
 =?us-ascii?Q?ZeY3kOp8ohvdaBMTUS2yqIe5wZKywqIJm4Do69rgOwRErFjqA+zWlvRirEKg?=
 =?us-ascii?Q?XqEyRLYSKmK/QC7UGcyCaEhhTIpu20NiOgg07JWY2seqNzcEYgtLnebTO2sG?=
 =?us-ascii?Q?oX8IJkctXkIwedBdmm2Bs2AWardpZbpVpCaiOBx6uHU3jo7+w0Qheq+kccZU?=
 =?us-ascii?Q?VIWqvueTy5qbYtsBWa7AM7cor4vm3bhW5uMAC5a+uqt4cHUwUAu+RwcjhWkk?=
 =?us-ascii?Q?OyQLPUdqIJtXFPpFJEeEBpj2Y+cbFg2xF1kn?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:42.4665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0bb4c1-b082-40da-6d71-08ddbb61527b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326

An impl driver might want to allocate its own type of vIOMMU object or the
standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3 by setting up its own SW/HW bits, as
the tegra241-cmdqv driver will add IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.

Add vsmmu_size/type and vsmmu_init to struct arm_smmu_impl_ops. Prioritize
them in arm_smmu_get_viommu_size() and arm_vsmmu_init().

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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
index eb9fe1f6311a..2ab1c6cf4aac 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -416,6 +416,10 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
 		return 0;
 
+	if (smmu->impl_ops && smmu->impl_ops->vsmmu_size &&
+	    viommu_type == smmu->impl_ops->vsmmu_type)
+		return smmu->impl_ops->vsmmu_size;
+
 	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
 		return 0;
 
@@ -439,6 +443,10 @@ int arm_vsmmu_init(struct iommufd_viommu *viommu,
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


