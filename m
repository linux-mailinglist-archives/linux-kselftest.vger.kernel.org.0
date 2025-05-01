Return-Path: <linux-kselftest+bounces-32118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB419AA66EB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493CC4A104F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83969277028;
	Thu,  1 May 2025 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BDQKg52b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA743265CCF;
	Thu,  1 May 2025 23:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140528; cv=fail; b=lzRoMJg4mr8fDitQ0Osw35w5LuE7LcFtK7mS1NbSXawf6tacHrybW3gNPjRay7XHsdkxrEWD8F4j+aCjPjXqvD1iHhL/IkBHQSdl/l+mKu+D0ZejkuraP6Ott+pBigBuhc/pV8ZDB8ySEsSlnmBjXHF6nxFCfuk0iSydEm3PHUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140528; c=relaxed/simple;
	bh=8xffzRa9VnmoUmzBon2uEOrG6G51T4j8TBEnKiVrqJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyMT4LE7ClLbt0SAJ4pWjI/R9WaRpqtBTg8l/qaRT6ZvwLrdL8hwJ6qn14lAk1apha5MEW54eVe/RDiEO4dgLPB649vUCWsMwp68Gz6lpzKqWVK6wWv35sD1KnWXjfJjYzQrvT5JeO4SnnnhSs3Iv0MTass8obtStWz1mANwymw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BDQKg52b; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9NpZGnbSY7mQCdmvlyl1cihzdfwqBtSp9f18QEeDZYGSTWYEvQ7VsdLpIPgZwIIM6WGFGmGuHiw8ChHPIjziNyozrQqFqecR5wqCVSwUt3m1icECW7SbJicKLCMGk1IaAY7oO2CTpNa/S6lBvJyoVzNDzovUis20kfVg6SDPfMelimksm5GNU2TiE4IGGWz2+9y8g2Ogt8JHcGtItr8zHOedFJ5ZCPgqWkIeV5ROq0AmkgiNkbYsInx05mIlxFIjgnxII6RxGgL42OGo7a1TTBsymT2pgjeS+7w09QHsb2S+A8ZC9+AYtlyp4cVRmRWSQefic19kEBmJCfuhQ2ZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JzjpwTivsLNcX5B3CPY1/1i15yDxNbMqo2IM1DCtjk=;
 b=hMYuRLiqKmGlA5OI2MT1bMN2l8tLSzru+iHGHghbLa7R1Bk+Gkf9N8EG67mPScnO8Fq4uPcJhY69oTYZ/8cX5vLdKjaF1w7d5qcZNtSl3Vcp5fMhXil/xh2kV9+cQj393L8RV2yVwa0Qef0drOtMr4lYlPsukVLsbxbxXPgitNMnhDCekBF0a0jivVAOBvaubiBtOq2QudL9ieDn5NT1odnA/X9ov6Z+w/HMj+0JaryLz/zUqu4/l4yJ05YfRZnGIxH6X4HySjQTJTuwSsWLr9m0QjRJDGAObZjimUK+GKBZkaiMPxmeqrnmzVnyMkukjuU7PGSl5P4DLlwT1veKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JzjpwTivsLNcX5B3CPY1/1i15yDxNbMqo2IM1DCtjk=;
 b=BDQKg52bzQcd2rmDVaoKJTXc1bgmWnUzlEDOrsMWLOPgP/T7RzhKckqYv/RQIIsrPxamc2/YgRmjbkv7c2yhTIGpPbXs+kRowHSMiCkkIcD+Hmr/F93yyC134ndK9Sly2Yw4hF/HftakM8aeFw88avdhUwHT1ZBEObMHkxGKsugJy0otlsitUVoFVumCqMi7q86GvwcY41tSHVy97DqaNYjeWuofStCUrcfS9pjweQI+xGphx5GHMIeRCFdVNJrdlNrpNC2ZlTE08O7rkDKiEJ69PU6y+rtivACkBrQ05nCorogLQraWEHV4aegsZiFrRbrDk63QuOf5tjtxUcWS3A==
Received: from SN7PR04CA0214.namprd04.prod.outlook.com (2603:10b6:806:127::9)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 1 May
 2025 23:02:02 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::82) by SN7PR04CA0214.outlook.office365.com
 (2603:10b6:806:127::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Thu,
 1 May 2025 23:02:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:01:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:01:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:01:49 -0700
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
Subject: [PATCH v3 07/23] iommufd/selftest: Support user_data in mock_viommu_alloc
Date: Thu, 1 May 2025 16:01:13 -0700
Message-ID: <56ad0296de1722682f8441711345aa07889af6fe.1746139811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746139811.git.nicolinc@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: 30cf6bbe-7b98-4745-7ead-08dd89042edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?856j5PdPxuqZUuIQoru2mfFHd9xAMPGQPVPsz91tfBt8360rUBqsJP+mI1Lf?=
 =?us-ascii?Q?0LbGka4FHpw+lqQTy9IgS0a4G9lAiw0Cel2rSw5XVPg0loNFy3pvzdWvUVZB?=
 =?us-ascii?Q?rNNtOh+oau3fRgpe8dIjA0kEMZD6UEi/8Radk4qABOOoUkHLgSj9PHQK1mhA?=
 =?us-ascii?Q?it7E2Pugr3jgqM3J4VQlnyxSdL5630lVwIsgOjoe66bkcoEb8Oeykc1+V6GC?=
 =?us-ascii?Q?Cc6fo6HGDf+IgJq0qfEJ5Ko8BoATxRMn1UO9MitLCUjgd89xvqk3f8swsdtI?=
 =?us-ascii?Q?rX2C3zVy3lPhT4Fu+vcy+Uo8eSaWYfBv+BA9zBL37bEyaz/tC+Vol4H13ZfQ?=
 =?us-ascii?Q?z/2vps+T8O/1DVAEeb3t1g+28/jnWl7ffgWfcHpV3X5GZ0CCdn2W8cbCqThX?=
 =?us-ascii?Q?e3NSj0elNYrgJCH0mpxLl+h7W95cRBBqXNxfB4MBd8cE6NUtu93ckWMrrJrA?=
 =?us-ascii?Q?0MEhIG3CE1zR/D53luHoV/nqysWGIiQhsr4U/76V4F8HcCEhWB1+ZgFAwGVM?=
 =?us-ascii?Q?lEDEk9TrYwNjEiC3/tHnSrjpK7OQ2/C4Li+Xzq2EtxmNkpRHyEkQNPLUr4Jk?=
 =?us-ascii?Q?KKH0ZAR4exE/kT3v4qEGkFVtdxTWYptrwm0QsTP3oi22zBuEd4P1i8phOQSU?=
 =?us-ascii?Q?cV+zShU4g4733CLJUfaPj9QrhHZDkNAJcENwBvXgHYx+EPM+DlrikR+rpnKj?=
 =?us-ascii?Q?sH4molIwZO1s1vvPFWsp9+oY/B/mkgDm3+sScUpE2932dL8HNV7Hq8IHhENI?=
 =?us-ascii?Q?SeQoijqxdKXfL0gdM1cozsq3Ai9NECQv7wVbwnf5n5ErSADBRbSLxnEswa5m?=
 =?us-ascii?Q?rEr4ytocph/d4Yjio0OALBjBWN7op50mNZvF+x6sTXFwGCVwNr4ychEG9JzT?=
 =?us-ascii?Q?IcvKsz74NeJqVtZLx/io6NhXd6M/mF5Mzsov6QdTMD5/i/6SSf/sQnYSbFBJ?=
 =?us-ascii?Q?PEZ34ttmMjMlFgrVRmuvHbfe22Y/wk/wZobAfZgXbexxF6xtb1h8QZcm7MxY?=
 =?us-ascii?Q?TbrOJEVY6xvPm/D+eNRXVO+DssJYtXtWwXcyTTJTBFrp7BfC44/PcqGNJOhy?=
 =?us-ascii?Q?zx9CmUTBu3RkFJzVw7lL1LjX8iUv2DMxjYgv/S8IimcsMhjUAGk1Vf/Qy2Uu?=
 =?us-ascii?Q?7bz8nMLPBOkntUcIRvYFT/J0fzrG4xFEzUUYRdNrtLuZMaeY7rwQtd6ku9O3?=
 =?us-ascii?Q?3FW43Pko7oLOCDTumFDkeSi3eennaxQE+tPHXLAu42zWFk+98w30vVU4P2XN?=
 =?us-ascii?Q?bG94dt20QpgnX9c5A8Iyt9/tJNW1Elmtx77J3mksCva0bzGR1v6L2x+RA1ea?=
 =?us-ascii?Q?TxEyeaW3nYtUs31iGv38c6NtMf7+Uyk4GYdgzNaByIHjxR2B/gvO/UOxIqdJ?=
 =?us-ascii?Q?jaHin93qSnz+FfVhYjT5inaye59io/6Yl6I9n+F/T/tiyjVYfXE1RpsIVxZJ?=
 =?us-ascii?Q?dIIsAjXtwaAOU735+KQEDvsgZ240LjI/thIjz+XLIvcYKuYzu7HZ5rj0prmy?=
 =?us-ascii?Q?GWRDVSay3d1czKUudmQWWwfabpm5J11C4ZJz?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:01.4446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cf6bbe-7b98-4745-7ead-08dd89042edf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224

Add a simple user_data for an input-to-output loopback test.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 13 +++++++++++++
 drivers/iommu/iommufd/selftest.c     | 19 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 1cd7e8394129..fbf9ecb35a13 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -227,6 +227,19 @@ struct iommu_hwpt_invalidate_selftest {
 
 #define IOMMU_VIOMMU_TYPE_SELFTEST 0xdeadbeef
 
+/**
+ * struct iommu_viommu_selftest - vIOMMU data for Mock driver
+ *                                (IOMMU_VIOMMU_TYPE_SELFTEST)
+ * @in_data: Input random data from user space
+ * @out_data: Output data (matching @in_data) to user space
+ *
+ * Simply set @out_data=@in_data for a loopback test
+ */
+struct iommu_viommu_selftest {
+	__u32 in_data;
+	__u32 out_data;
+};
+
 /* Should not be equal to any defined value in enum iommu_viommu_invalidate_data_type */
 #define IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST 0xdeadbeef
 #define IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST_INVALID 0xdadbeef
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 8b8ba4fb91cd..033345f81df9 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -740,16 +740,35 @@ mock_viommu_alloc(struct device *dev, struct iommu_domain *domain,
 {
 	struct mock_iommu_device *mock_iommu =
 		iommu_get_iommu_dev(dev, struct mock_iommu_device, iommu_dev);
+	struct iommu_viommu_selftest data;
 	struct mock_viommu *mock_viommu;
+	int rc;
 
 	if (viommu_type != IOMMU_VIOMMU_TYPE_SELFTEST)
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (user_data) {
+		rc = iommu_copy_struct_from_user(
+			&data, user_data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
+		if (rc)
+			return ERR_PTR(rc);
+	}
+
 	mock_viommu = iommufd_viommu_alloc(ictx, struct mock_viommu, core,
 					   &mock_viommu_ops);
 	if (IS_ERR(mock_viommu))
 		return ERR_CAST(mock_viommu);
 
+	if (user_data) {
+		data.out_data = data.in_data;
+		rc = iommu_copy_struct_to_user(
+			user_data, &data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
+		if (rc) {
+			iommufd_struct_destroy(mock_viommu, core);
+			return ERR_PTR(rc);
+		}
+	}
+
 	refcount_inc(&mock_iommu->users);
 	return &mock_viommu->core;
 }
-- 
2.43.0


