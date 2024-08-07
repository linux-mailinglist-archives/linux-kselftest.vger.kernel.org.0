Return-Path: <linux-kselftest+bounces-14966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C79D94B109
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151B5280DC3
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB3F155C94;
	Wed,  7 Aug 2024 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VMEU5SVR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45ED1553AF;
	Wed,  7 Aug 2024 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061508; cv=fail; b=p4bz51EhSYU8memL1KvALdugfpk5fAZECuf8+SmyiuWptiy3cHv2CNGEF/plGf4gfnDmWCCpACpNE43T8ztehslDooF0nalVeYj//sPXgVCka3zEy1z8pgciH6OMw3IGEOlV7WEjOQc3xx0Z15GaLvGJaQ3JKuGrRPw+AFaWEnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061508; c=relaxed/simple;
	bh=dwWojiJEcTvtNBqyMaEDKauatx45Ald/0aFEGpLrDRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQEi4k704+6BkNKnnpCQkqNxgo1+iEsidbA66w3Nr5+3ud6RrATJcRfhHz2qHyUKISM/1+2HuybMmDrOHYuDBv5UK8/P+JRkHx2LEZBES4Qc4xTIWM4tZaKHHIjgrevQyBJmyr4P2mC8nQgWVU3DfftrX0/KIz6INFprpcZIfGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VMEU5SVR; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdzxAQbLMpYLq7pqbFr6A5RqL6q2MviqjFRj8dUtgx75uOIrEHUbm3CsP8tgAhT6xvRnRBJb4OUK00dyojAK+NLi9RYpoKy6JQfT1DKnbYx1WlnWRmp3o3dKqgOrAqtX9RDciwazGLmKX5+EYJ33mMgeAXxSl/Oww2Lf0EzFNkMMQXDdYtvTZWwgXE+eXLjz26AkR2E5ZFkKAsfmSsiysBPYB9Rps1JFOCpTPv4/QJyAvGFq5sxxfcrNjB7axQGii7B2JEH+F/bQ3G07ioVy8WiJyA3aO+qkLiducgIITTCL/B1SIaVGZh3FD3iEhmFwiP3cz9DePL7z1MxzTMTIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+ua6Q4EfhYRYs9OsVqGyVK82T6xIpPjP8Sk3Payhy8=;
 b=tRi8oXxqzZ6rr9bOCm+OUpdm6ZdO4np3NOnnmOzSv1e6ymuihBgsTQ9rflzRoatXXdNG8cEJjE4zxgoKJZW0TuMAojkqBJX/QXw4+06JgeGdVveRmJHFDkYmHh9x3zIurkZxFuwSndx3hayOvajZtfuCbuOzC9pGfb2qt5SM6I7FLIvTTYm5AXMmEsi1MMp5PxE3eZy2rxmU2+fpBzjJbHNxWS38oHJ5cckGGVVm9CD5rcHOWBByII9dReHTbeoxb69SnOjWbcDyF7Yg40TV/4vS3EmPR28kTXmdZBZYIS4iFqM+e9+QCgycMbTwn2RBIbOvUtIWpJBGPVM3q+BQlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+ua6Q4EfhYRYs9OsVqGyVK82T6xIpPjP8Sk3Payhy8=;
 b=VMEU5SVRnPOMrWmYGOwX72qT7yYljxxbj/aKvulJHA/+kyiZgx7uPhjlZabyaeBVZEkzsG+UuZOxdK6aoI9JRkeM+A8T4yZ/E0cneMm/69qcSu6yk6SrFyDsz6PXffuggZCShpCxLIeHj2mrQRvmZMV/x0W6fELN9gfiadXpeB6dQx3t3zzLKL52RTtNi2X0VNpxnuuI2aInc2dHaNweB/u9mTf0WNiW0Z6R7HSVGB2x87gsYVnAChppSdHx/7U/qo+vOlVrw2b2YnH6oIjGQVkRxSEV5BXM3OlI2BmVb7meHH6JA51EswsZQ+NsFeGhTYRsk3ILqrNm65JsPdovTw==
Received: from CH2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:610:54::40)
 by MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 20:11:43 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::ad) by CH2PR11CA0030.outlook.office365.com
 (2603:10b6:610:54::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 20:11:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:26 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 15/16] iommu/arm-smmu-v3: Add viommu cache invalidation support
Date: Wed, 7 Aug 2024 13:10:56 -0700
Message-ID: <729dfd0808f85d88fd3ef8bcea0168cc1d2c0d59.1723061378.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723061377.git.nicolinc@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: c7221624-5538-41c0-485c-08dcb71d27c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Eq4r0vO6XRN8qxzVWpimOCAe7fcxEPEgPke7v+VRLx8AVuDbQmvP6DJgFbT?=
 =?us-ascii?Q?J4Es42tPKy7JAS5dvhnIqo0eobGa571KKS71Qp/TGvuNr/sZH8eRsA7tghCG?=
 =?us-ascii?Q?+oMVVQauAE7yqDcUZgTMM+Bo6cQtKJiJbywwCHbVPpem5MwZ0YVo2y/1wJPv?=
 =?us-ascii?Q?3LvkXFu3GDlfBVfWYJ+A1UZkrkGh01xkOTSBkUU1FZndWM1lxF8jKvS+DDuh?=
 =?us-ascii?Q?vgbCuQRlDmmsVR1hSalqenCZFb2hlZY4mMlkc0oXOGAyupjUretIIFd5egNY?=
 =?us-ascii?Q?Jzja22o496QvYrc8BBFgFwFVlaGZgIvtynCV5y0XjcdCYRh46+LBnC53oGPG?=
 =?us-ascii?Q?rzRMyUGNFN9QGr3OtcbPtZUOdonSudqro/htqBfbgzz7J0J5+S0z+E2dikd0?=
 =?us-ascii?Q?U8A0dhbFK5Yq2OeDw3L0JQq1szhS1Y3T6c/qAaFzAtJPO8gpgyLdsZhQ+OQ3?=
 =?us-ascii?Q?iyntPUBe51/65HXLHSqCr+cPbDlW6qFTP/mKPiJNS1/Wh0++vv3FdtpqpOZQ?=
 =?us-ascii?Q?gTWzCSIPOR1utPCV48k7zu8AsSPRSbe7QfN0SH9byeDlI+3C4PFIXR/uLFFq?=
 =?us-ascii?Q?ZlEX3WxaVsHPg8GUDFTCSBOqK+fyhAIdMzCptrfch1e0qzGilSxcsFfFgBWa?=
 =?us-ascii?Q?VvJtCRnLuMIhPrG5UGgsOvz7C91S2s30MhrVF8swVVfuVqLd64dkn8K1K5Y8?=
 =?us-ascii?Q?Yzc/Ths0bT61arOpcmObm1xEG4b+EfbtASKGdQsmPsEbZHxE81fzaCXIWkBW?=
 =?us-ascii?Q?tIOEl6EQz8IYOWVbaFgUlPvrBUFyoht2qpvpGDiUOcTsET+tqt9x8REndtKK?=
 =?us-ascii?Q?sSBCjGrD11eaAsWSplnh+RyW8e3cEeSDXZhraf0rAcvKbETKwqqD+49H1tlZ?=
 =?us-ascii?Q?kSVjSVtJe0aJAUVV8sao8wZahbAg6wu2yQtDRhznLtSbpY/gLLWSRqY4RyTj?=
 =?us-ascii?Q?3+A8cqw5LwEDlsobHiOL5PreT6vNvAIBeTLVgg0JpYOwSRnqgLRcoaGA7w+p?=
 =?us-ascii?Q?1lKZ3+f/X5HQoPwo9MnonfmuOccG5Fj7Js0NRzZLWTwXyg1aDcMP9LlpWVnD?=
 =?us-ascii?Q?iauMtwmAuDcyjEELsfhlX2zPF5Cx+IpBECnl3sbzbW/eg7be16ozUW+LV75h?=
 =?us-ascii?Q?nwvFs4l+Ck1+c/a1fTWJD6SPK3GJ+bqhAAlwlCtB9Kr5OpXze3sR3B25R2nj?=
 =?us-ascii?Q?y68vYtBEQtRabTJ/lGYs1Vi4U5iJ/b4lnwi3qGGvq5WuHvvfVSiB2JG5GNaQ?=
 =?us-ascii?Q?LmB4vWwqrFtz9z3JBjjB5nZup1K9O5QzElh2Ez4EtRu0a/Nr6LSx2u7CO/JR?=
 =?us-ascii?Q?vLTjXspQlMuGQYytQ3fdgpSJqCs04YeEt7y4LHOqRdeJoNYh6OShdm8c24gP?=
 =?us-ascii?Q?8xwnmzAehToFJPjRvdoQmiplJnZQHwsimvquT1s5mRi2eVAvxfe5IzTHiAA1?=
 =?us-ascii?Q?6BPAwIpztgzO91NsoVyn5Gcgtu8nwvHU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:42.7289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7221624-5538-41c0-485c-08dcb71d27c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899

Add an arm_smmu_viommu_cache_invalidate() function for user space to issue
cache invalidation commands via viommu.

The viommu invalidation takes the same native format of a 128-bit command,
as the hwpt invalidation. Thus, reuse the same driver data structure, but
make it wider to accept CMDQ_OP_ATC_INV and CMDQ_OP_CFGI_CD{_ALL}.

Scan the commands against the supported ist and fix the VMIDs and SIDs.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 54 +++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 include/uapi/linux/iommufd.h                | 20 ++++++++
 3 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ec76377d505c..be4f849f1a48 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3219,15 +3219,32 @@ static void arm_smmu_domain_nested_free(struct iommu_domain *domain)
 	kfree(container_of(domain, struct arm_smmu_nested_domain, domain));
 }
 
+static int arm_smmu_convert_viommu_vdev_id(struct iommufd_viommu *viommu,
+					   u32 vdev_id, u32 *sid)
+{
+	struct arm_smmu_master *master;
+	struct device *dev;
+
+	dev = iommufd_viommu_find_device(viommu, vdev_id);
+	if (!dev)
+		return -EIO;
+	master = dev_iommu_priv_get(dev);
+
+	if (sid)
+		*sid = master->streams[0].id;
+	return 0;
+}
+
 /*
  * Convert, in place, the raw invalidation command into an internal format that
  * can be passed to arm_smmu_cmdq_issue_cmdlist(). Internally commands are
  * stored in CPU endian.
  *
- * Enforce the VMID on the command.
+ * Enforce the VMID or the SID on the command.
  */
 static int
 arm_smmu_convert_user_cmd(struct arm_smmu_domain *s2_parent,
+			  struct iommufd_viommu *viommu,
 			  struct iommu_hwpt_arm_smmuv3_invalidate *cmd)
 {
 	u16 vmid = s2_parent->s2_cfg.vmid;
@@ -3249,6 +3266,19 @@ arm_smmu_convert_user_cmd(struct arm_smmu_domain *s2_parent,
 		cmd->cmd[0] &= ~CMDQ_TLBI_0_VMID;
 		cmd->cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vmid);
 		break;
+	case CMDQ_OP_ATC_INV:
+	case CMDQ_OP_CFGI_CD:
+	case CMDQ_OP_CFGI_CD_ALL:
+		if (viommu) {
+			u32 sid, vsid = FIELD_GET(CMDQ_CFGI_0_SID, cmd->cmd[0]);
+
+			if (arm_smmu_convert_viommu_vdev_id(viommu, vsid, &sid))
+				return -EIO;
+			cmd->cmd[0] &= ~CMDQ_CFGI_0_SID;
+			cmd->cmd[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, sid);
+			break;
+		}
+		fallthrough;
 	default:
 		return -EIO;
 	}
@@ -3256,8 +3286,11 @@ arm_smmu_convert_user_cmd(struct arm_smmu_domain *s2_parent,
 }
 
 static int __arm_smmu_cache_invalidate_user(struct arm_smmu_domain *s2_parent,
+					    struct iommufd_viommu *viommu,
 					    struct iommu_user_data_array *array)
 {
+	unsigned int type = viommu ? IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3 :
+				     IOMMU_HWPT_INVALIDATE_DATA_ARM_SMMUV3;
 	struct arm_smmu_device *smmu = s2_parent->smmu;
 	struct iommu_hwpt_arm_smmuv3_invalidate *last_batch;
 	struct iommu_hwpt_arm_smmuv3_invalidate *cmds;
@@ -3273,14 +3306,13 @@ static int __arm_smmu_cache_invalidate_user(struct arm_smmu_domain *s2_parent,
 
 	static_assert(sizeof(*cmds) == 2 * sizeof(u64));
 	ret = iommu_copy_struct_from_full_user_array(
-		cmds, sizeof(*cmds), array,
-		IOMMU_HWPT_INVALIDATE_DATA_ARM_SMMUV3);
+		cmds, sizeof(*cmds), array, type);
 	if (ret)
 		goto out;
 
 	last_batch = cmds;
 	while (cur != end) {
-		ret = arm_smmu_convert_user_cmd(s2_parent, cur);
+		ret = arm_smmu_convert_user_cmd(s2_parent, viommu, cur);
 		if (ret)
 			goto out;
 
@@ -3310,7 +3342,7 @@ static int arm_smmu_cache_invalidate_user(struct iommu_domain *domain,
 		container_of(domain, struct arm_smmu_nested_domain, domain);
 
 	return __arm_smmu_cache_invalidate_user(
-			nested_domain->s2_parent, array);
+			nested_domain->s2_parent, NULL, array);
 }
 
 static struct iommu_domain *
@@ -3812,6 +3844,15 @@ static int arm_smmu_def_domain_type(struct device *dev)
 	return 0;
 }
 
+static int arm_smmu_viommu_cache_invalidate(struct iommufd_viommu *viommu,
+					    struct iommu_user_data_array *array)
+{
+	struct iommu_domain *domain = iommufd_viommu_to_parent_domain(viommu);
+
+	return __arm_smmu_cache_invalidate_user(
+			to_smmu_domain(domain), viommu, array);
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
@@ -3842,6 +3883,9 @@ static struct iommu_ops arm_smmu_ops = {
 		.iotlb_sync		= arm_smmu_iotlb_sync,
 		.iova_to_phys		= arm_smmu_iova_to_phys,
 		.free			= arm_smmu_domain_free_paging,
+		.default_viommu_ops = &(const struct iommufd_viommu_ops) {
+			.cache_invalidate = arm_smmu_viommu_cache_invalidate,
+		}
 	}
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3f7442f0167e..a3fb08e0a195 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -10,6 +10,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <linux/kernel.h>
 #include <linux/mmzone.h>
 #include <linux/sizes.h>
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 998b3f2cd2b5..416b9a18e6bb 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -956,6 +956,26 @@ enum iommu_viommu_invalidate_data_type {
 	IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
 };
 
+/**
+ * struct iommu_viommu_arm_smmuv3_invalidate - ARM SMMUv3 cahce invalidation
+ *         (IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3)
+ * @cmd: 128-bit cache invalidation command that runs in SMMU CMDQ.
+ *       Must be little-endian.
+ *
+ * Supported command list:
+ *     CMDQ_OP_TLBI_NSNH_ALL
+ *     CMDQ_OP_TLBI_NH_VA
+ *     CMDQ_OP_TLBI_NH_VAA
+ *     CMDQ_OP_TLBI_NH_ALL
+ *     CMDQ_OP_TLBI_NH_ASID
+ *     CMDQ_OP_ATC_INV
+ *     CMDQ_OP_CFGI_CD
+ *     CMDQ_OP_CFGI_CD_ALL
+ *
+ * -EIO will be returned if the command is not supported.
+ */
+#define iommu_viommu_arm_smmuv3_invalidate iommu_hwpt_arm_smmuv3_invalidate
+
 /**
  * struct iommu_viommu_invalidate - ioctl(IOMMU_VIOMMU_INVALIDATE)
  * @size: sizeof(struct iommu_viommu_invalidate)
-- 
2.43.0


