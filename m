Return-Path: <linux-kselftest+bounces-31688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56120A9D805
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 08:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B499C7364
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 06:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565F01C861A;
	Sat, 26 Apr 2025 05:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s6VPDKyw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BFF1DC98B;
	Sat, 26 Apr 2025 05:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647177; cv=fail; b=QagQr0wHZo8bWk/D6YSlNL3x9+ESP13AK4hKfaBFoaCzrmCnSCvkAHrY41caPP/zfYRW6g+pVFnykp5+1EbPsncMnkSt063FAWzKXZdwuOg+LA9t+JiC4i1jQAghnorLsSOlABZWecfaZJMhoqS6YiZvnJTGYYLP+QTUfO0AZTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647177; c=relaxed/simple;
	bh=GsTbRTGIWvSU597Taj2SmuBWXWQMhjQdgaPDzdbvh+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smhSksEgXPeZmo8Sgc5U/ZzBYiiK3GpIXAp0NRqCa8LsN2ufnrL9qBmA9yShPcXwFZWpcmpY8sjxmAj7QqXHU1MZK6J7jtIPC2yKGAbFPCqKgPw9ScnxM87O7595ags9vG6IwNvzGOObmisJGRk1QnAR6ZmiFU7S43MsWtjGe+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s6VPDKyw; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7UZ1cP/I7X1euSsbuMTcLdW0Pwod60KxNkFj3uNXCYiEfQqWooZa7ODawA3jy/YgkED5bJ50MVkuLUbhSlLByMGxPBpG7xH+c6/gwmDHD8HvBl2C3+sVGd0e2mUKeZhOGx8FcLJtBusYl5eCORt1ZiGHItp9FwrIM47RMm6ARHJ8Wm5OWB5LE4srxt++pHhWIXnk7Nnq063iBz1SDK6FxcHTDDSv/QXJi238Sd1l/dVnyOQNSRLxxhxdYJYF2uAt1BCzhlqFCFRaLxiOoq5qYP/oXrL8CbnHSRtMHWHb5qnFfhODkPPq/eljQztBlD3nPwn4QTZfwodepz0B0g3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WFgE6BGB5TVTM+GdtHH8n3K2bCUI96Pon7lwq/VsBs=;
 b=pVAIQ4s+5s1uyTXsdsecz9Mg5nykteLq8AjOkzAWCy/kqXpOp1zFFoxf/FoPdZkgGPrve4d+1sb6Z2dPhz0HCAYQ2083pKFYxEnE0W8BxqaZWSjHXCWZ7j/jIjXs3QMWPm50SwpO4PhiYUVaMz3D0D3LdzYwRm1pE2D9ItsOQeW8POLokAHH2R/xSUlKBuRxZYfqdk3ROVEjvOY2FnNcYtyG96nc9Dfqs+DU9ayCVCQMRVRxjZNuECBKsrGu47znGENx7381EPa6c4BD4AYvAj4CKQGXzw2Ee/YA6+0APuSz+4DMx1decTR8D8U/AAoiCJE8rIFQ5Ur52QFDVRfZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WFgE6BGB5TVTM+GdtHH8n3K2bCUI96Pon7lwq/VsBs=;
 b=s6VPDKywujZCnoTmgdIAeBmZSz2q4nmJ0I7YfXL+vMvjL8WvsV3XnSSnsHoxrcOzHmS4nGCeUa4YHmRzXYt1TInsw3i4czmqozPjKYPtdPH/hdwGnG5Db5JEROduXQik6Wv0wwA8a6SgHQeykpqNLhmi5p+HdGzm77zn6MxgMgwfZyE25AMme8WvXYP+iC6hpbqJKXSNr46cPxGnCHCGmLJtuKBQ3QL2D0bPAU8jFGqAZ1fHuVpOBV7YOLMoEHftLM4rQSqMIYpI935CccgantPxROQtYemf1I06vvHdzjzoYpZS31iFlbVnGMpTx50rIbtMrV9b6tyQitN/AoVe/w==
Received: from SA1P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::8)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Sat, 26 Apr
 2025 05:59:30 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::97) by SA1P222CA0016.outlook.office365.com
 (2603:10b6:806:22c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Sat,
 26 Apr 2025 05:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:59:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:59:22 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:59:21 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:59:19 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v2 16/22] iommu/arm-smmu-v3-iommufd: Add vsmmu_alloc impl op
Date: Fri, 25 Apr 2025 22:58:11 -0700
Message-ID: <73b1fc34b07f2ac42d542dd996c7119ae5f8939c.1745646960.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745646960.git.nicolinc@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|MN0PR12MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c90e26-9933-408e-feef-08dd84878283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lrQrawd9gpqSnbfVzkZCSQyvZQqnGW7WZppOAGxax2x9c//LfFBQ/Nwms1m2?=
 =?us-ascii?Q?ol7y6osF0NiZUdeiB+9h5OP+2vFm5BHXtiGnd1cARXXSg7pHOeKhrjKpdUqu?=
 =?us-ascii?Q?hk+xGDqR1glFQwa1CkjAPPv1erwainfO5WV1fwU/KHeBLLgbBxmJejGldMeh?=
 =?us-ascii?Q?vL3JS+OD0Rh/eOy12jo4M7sSwHXK5vqCjWUrQCSCVCuww0O4Kq1CI+hAYvV1?=
 =?us-ascii?Q?6e/255C0s3xpUscn+DT6pFdUwGS07iJ9mDBWqwxB2EK4s3a4GMuQGE1RAjWS?=
 =?us-ascii?Q?wHw12i6Qx+CE9O1WKMUpSjO1Bsn9u4KXkL7J+ZJ7/275iBPCGPbazf+FG3fM?=
 =?us-ascii?Q?bhahxkJsKCgLE1zrv6sk7b/vt0+nIB7Vbxwn8POUWdv5NiNThRs7J/HGxqdo?=
 =?us-ascii?Q?zCJMAwKtq1cXfjlEwZP4fcl6nNR230giAsD7oLXTa+82dn3rUOlg9MH/4tCn?=
 =?us-ascii?Q?bFqp1r30GUSTrGxaqzo8iyn+WJ/D1u4O0UTMfDHkH5BOl/IpswgHeXkE6L0x?=
 =?us-ascii?Q?3Yp4l12D/ziYKYaEDKzwUDxEJHniaJmq8YG6SmWnLHwtxZGBkthlQhYLWpKT?=
 =?us-ascii?Q?q0r4QHo+5JIEb9135iqlUUBno4q7IM/4m+pcOQpXiYhBrTf0oot4n4vLVaG7?=
 =?us-ascii?Q?0eYNHevLrefiJyOeJmI4YUmPgkLD9A2NRfSl5MVI8RQuQs6tsVVnUNqpIlyw?=
 =?us-ascii?Q?6cppP2VEmm8pWNAbkH6yyq8p0nYzhaTA3jqNuE58yZ6Vy4ZEUIgtzyy0BjDq?=
 =?us-ascii?Q?TKaQMdeh31VvOdiVAynvYv9FEHyU3RbfNQbp/VIlm6QErHcpgyyNEeEKJiMA?=
 =?us-ascii?Q?k3vbZx0HWLM3bowQzScwEBrcmxRuo5a6auYjPUNXxFhcmzACkdV8unrMNa1D?=
 =?us-ascii?Q?f1Vu5gUzy0QOmgdfrE+uBQFzwIQP9/XRh2XeVAsJSOvXaj9jf9+E9mgsd62G?=
 =?us-ascii?Q?vHeIbpbCpQknZbCYlRGhnAnpSlJhXeV1WLqbEGJlJhsmEupufTbc6d/YHD/l?=
 =?us-ascii?Q?VsvkV1JgyIV0a3tlGk0GOTaHsjC42jHFxayNvv/8zgTTmEX/W+zxWDQFCYSU?=
 =?us-ascii?Q?YEQGSo3umYZsln9fEuy8K17LLPlUtLbyJpveA3QDg85iuEeF9oXKFgAnQ5KH?=
 =?us-ascii?Q?OlyQ3fC2FwSc+w/3UoqAQwQlOF+qSL8nuNz5NzcFunzz6039ommAuO9VqttC?=
 =?us-ascii?Q?pIzKwSoxrfiGsjJwLhzKgK5YRVeLlfsw0fA0SqHdxPUQcs3uJFteoVkiWRte?=
 =?us-ascii?Q?w2PLmOLM0jHZWJjsmZH7VJqjayIQ8cYJ/IjJC3iLtcFkbY1HmNCiDmpL8YXN?=
 =?us-ascii?Q?AnMFMlmspIuNS9XvUqx8WyG+/h/RTlPBAFroiDK6vw3oo074DHDexvM93zMY?=
 =?us-ascii?Q?bBvf20spWu6ITzb73m3lTRTZ81q+pOHn4izm4Qc5GZ5wwHR03dyd5F2ft1ea?=
 =?us-ascii?Q?XdIA2DkzMQ4+/2Q35KHnXiXXXGS30CR+Qc0apDC3u9v6zROq1j/C1Rb2tDdg?=
 =?us-ascii?Q?VBf+Er8TtV9I6YIDiL82gTDMhL5VJFHp22Yj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:59:30.0212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c90e26-9933-408e-feef-08dd84878283
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317

An impl driver might support its own vIOMMU object, as tegra241-cmdqv will
add IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.

Add a vsmmu_alloc op to give impl a try, upon failure fallback to standard
vsmmu allocation for IOMMU_VIOMMU_TYPE_ARM_SMMUV3.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  6 ++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 17 +++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6b8f0d20dac3..a5835af72417 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -16,6 +16,7 @@
 #include <linux/sizes.h>
 
 struct arm_smmu_device;
+struct arm_smmu_domain;
 
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
@@ -720,6 +721,11 @@ struct arm_smmu_impl_ops {
 	int (*init_structures)(struct arm_smmu_device *smmu);
 	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
 		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
+	struct arm_vsmmu *(*vsmmu_alloc)(
+		struct arm_smmu_device *smmu,
+		struct arm_smmu_domain *smmu_domain, struct iommufd_ctx *ictx,
+		unsigned int viommu_type,
+		const struct iommu_user_data *user_data);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 66855cae775e..a8a78131702d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -392,10 +392,7 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 		iommu_get_iommu_dev(dev, struct arm_smmu_device, iommu);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_domain *s2_parent = to_smmu_domain(parent);
-	struct arm_vsmmu *vsmmu;
-
-	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
-		return ERR_PTR(-EOPNOTSUPP);
+	struct arm_vsmmu *vsmmu = ERR_PTR(-EOPNOTSUPP);
 
 	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
 		return ERR_PTR(-EOPNOTSUPP);
@@ -423,8 +420,16 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
-				     &arm_vsmmu_ops);
+	if (master->smmu->impl_ops && master->smmu->impl_ops->vsmmu_alloc)
+		vsmmu = master->smmu->impl_ops->vsmmu_alloc(
+			master->smmu, s2_parent, ictx, viommu_type, user_data);
+	if (PTR_ERR(vsmmu) == -EOPNOTSUPP) {
+		if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
+			return ERR_PTR(-EOPNOTSUPP);
+		/* Fallback to standard SMMUv3 type if viommu_type matches */
+		vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
+					     &arm_vsmmu_ops);
+	}
 	if (IS_ERR(vsmmu))
 		return ERR_CAST(vsmmu);
 
-- 
2.43.0


