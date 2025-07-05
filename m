Return-Path: <linux-kselftest+bounces-36637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9196EAF9D89
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A41B5A43BE
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F0825392A;
	Sat,  5 Jul 2025 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kEcOgcFr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C31F23B61C;
	Sat,  5 Jul 2025 01:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678099; cv=fail; b=rrf7aLuCWVzhAkMdmyGk+q8p4FoHObmm8w+WR4MlBRSw3LoOrL+MCSOgjHeao0HyKqFsQJNCDq9BrUhfJ50wjENDuAqlizWX/ygeYseZB6nzd/1wbInQxfJzwICarvXINklAOC/8pxKvsi/l2i9ugVUrIr74i3H0F9Vdlcgiy1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678099; c=relaxed/simple;
	bh=SNuR/syJ6d94pWeRNgVQvkZpx4Ugaa0sfqGC6UsZS5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWIsGJBkMQ9VZmk+X856s3zi7fGuCUgTEMhoLd4Pr3YRN5TwB/sGSc8kae0bRE4/ypHZ/1gnajcoP8BjttmDzEF4Y3deowIQhBXx24zg+8xj+7dX7XzCCA1NEmH9DyyhgVJI/jh+BQpWYFagbSNz0TbQNJgQiVrFtizi38donrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kEcOgcFr; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zux9y4ZOaEchqnVhY69oUhEqgzgjPYeOuSrCbZ1gZal09a0sDd8PIidOp0nLIWZ8QqE8pKq9nA8W1rCBABTCdbLJsse5Jixov5mDw76suJZvDYfv6TwDQMxMItyz05MoKkxtoSiU4oshn9JN78ECvWy66Nqa8kOh/cfCfPrC7k+MGw5YwhdYgtHrHbYHBHJqUGGDeB27652DKYoNjT66hfiA8gUJhcKeA2hIPgz6kOWHv0AuF1HnLguVsEqypRg0UVIvbkfCeU6JGX3dkb3bhqPimJBHLY2GVQtTiA+QjkhRtRUj5Tn0lrPm6TVP0KWzPy/HQW7hI7QCkngzjqbLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yG4YicJuyOLO3kZqwyH0YHYzughxDEpZvc3rLH9H90=;
 b=y/BDDTWYAE0gNh8F6RuhcqVyvcF8AfNGFgtHZ7fl02H5A3H4RyMiMtfRm6P2BSVm/+9I7aKTAodOAgX5z6DBuIjiAXOuwMstiGvRhjpppPkMUnWNTZEZFw0aLyJL4UWja0sFZh4G5f6bvzqXoiFT8CKTF6Nm/0hAl/uX7n46Yi9aodNu+AEE6FDBYro9xU4j3C/q/DlhvwW+s9nBT01gG7Is3n32SP9PQJ7g74LqsR8EQHisW/ahohFzvoc49xJEDOKg2euUoI+Hzd4h/I2DeEuvSugmmmPaHrLCahuwD2jYPaUV2bm/4ytKwtMGfckEfBeNH0PrDWl41PZln/kBGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yG4YicJuyOLO3kZqwyH0YHYzughxDEpZvc3rLH9H90=;
 b=kEcOgcFrw1aarNkIYneFW0OcFx4XEm26JcB3032QEizYZXnM64XkxofGtIW1hxan590aw9YVX4xcdq2sFI+ifFHce+PADAqV0Dqq5SakYdIk9863TScfbTMVUtvRz2WOx8I112uleNKquzQJ3gj4aE0j7l7pQPnGXXRAR41XSAaWjdcqC2RxAX495DmWTbb8wXZeNxP0M0LtFhKRuF3rV689Br8HsFsKgfa679Gv0I6rOqWFjOeXZDU9icr7SzF6YeWf+yJhPOdVxo60HWSAFhGLcgyzGnAeot61Yx/VHciGI7VnmWXMtbAygTlXEQ4WAsMgiN1ArXQ/VHxQPhL6Gg==
Received: from BN9P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::30)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Sat, 5 Jul
 2025 01:14:53 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::4b) by BN9P220CA0025.outlook.office365.com
 (2603:10b6:408:13e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Sat,
 5 Jul 2025 01:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:39 -0700
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
Subject: [PATCH v8 29/29] iommu/tegra241-cmdqv: Add IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support
Date: Fri, 4 Jul 2025 18:13:45 -0700
Message-ID: <4481e959d0b74cb7a15f4e32b830e86a7ee4e221.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e2b17d-78da-4cc2-3007-08ddbb61588f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nzhA5bFmUyW7jTW8Le+ouTodTO5o4xPZwnJuDlQNWffgn+/ExXgOwWOXRH4J?=
 =?us-ascii?Q?Rby1TTVJq4+VuO3APN3E7W/CR4GUQr6GZTWPolO5eTlrdfU9TqZzqT6osacV?=
 =?us-ascii?Q?XAL1JGt8UKb6N5lsyjiz6hlzCfkEjrwhgp4kVkTstRLUCd4eaG41DJl6pgAq?=
 =?us-ascii?Q?j3eaN/7ETdZ+Iw8HI3AZSMohOCNFdgJxuzvcoVQXrj59JBpqAkt6pATLzDbz?=
 =?us-ascii?Q?R4del9cpInjd/szvWNGjoKqp9+ipzU+eo9NHG1hGCqSPh4fNnPjWa6GxNmLo?=
 =?us-ascii?Q?L30IwK4buDgccseOuqaoHJohoyoMJsyh4t+1W4QQA1nDoeROM+tL185UKHAJ?=
 =?us-ascii?Q?JTNkkJRpQhj0sdB3ny/QnMz/tkUaTBnFk4mRATx4kSUmvKPerIhRjBs1b0Vh?=
 =?us-ascii?Q?BiOTulHEtDPQCYRkjKeTAMGKImAvVxSM/vQNogambkzffr+0vjNcgkTUBFUA?=
 =?us-ascii?Q?6IBV2xcjhwjFcp/gU8qDkf/R2EE74mb3tyTKh2sLUiHA4OqXyRcw5P+DT4Uq?=
 =?us-ascii?Q?gJIfgLM0Z5JmfRT9MAqMD0nWVpYENVWMzPID02+kRUElm8yCn/7YXMKXrPt4?=
 =?us-ascii?Q?s12x4ROCMGxQ4XkYtacgDVzmAlJJG5MS+JI3PSI5g5/BcofQTjVv9bKsEIa5?=
 =?us-ascii?Q?Ma4qRjXfNX1mLOcUxiBvMfZmvClEO/iyb9lM8RBb19rTL9sDHQ9YD9ePrq9w?=
 =?us-ascii?Q?rrnUw3JvTfV8DDol/HXTkhCZjEUjl3mZKgBF/kbmyvtRL2+JNtOkEvhj0csK?=
 =?us-ascii?Q?HmgcdBRpoAZk19R1Ieq5VUs3JMxkRs8L8TMLYauDaqzKZQkyLXgwQB6IY4Uj?=
 =?us-ascii?Q?db7wAC2eQ2jLHqaoVUtAl28a6mqVdYqxPyKdQ0pNKgUxlamDQCEDJ/ymEFQf?=
 =?us-ascii?Q?JQcpdjnDiHo3usd/LzDxsxa8yjByFTsiGOvPPIJpuAGL1WQOJ1+pPOTgmLB2?=
 =?us-ascii?Q?wtHOKgsVqSuzSGUz7b3y05HrMfXg5pNy9BRSSBJbS0SjboLynS1qCQQdvmXB?=
 =?us-ascii?Q?o7cnHMBpLYWm76S49iXPDmimkDg35pBd+pEqmXpHXSWKClpUEmZ0whZAs2hu?=
 =?us-ascii?Q?MVBOEJoM6exXwqvdfrZ9xBPMwBdzCcN+E1sLDTm04NJokKqqHeHxFf+whbY5?=
 =?us-ascii?Q?dNElzk7U9mz1eTIaaYb3O0eJS7MNmm/0Ag2mtAD9mmtPDBmZzRcwnqQLe0nY?=
 =?us-ascii?Q?jc2bTPOlW4L6OFTlkfWa6+31vt2JlwGHB5PlQodZy/6oFLbReO9/8p0omoSu?=
 =?us-ascii?Q?D/vRSlLF6KZ5B67EqtOKIznY2dviJXMYwL5v1/SfHY1ymuTuNrR3tGtkl91R?=
 =?us-ascii?Q?0ZlN1wu1GKVXOxyFAw72yUBui9e5hJRJzCN9dxDPInw5XrOmNEcwtzZRbkRF?=
 =?us-ascii?Q?nJMZsIiqwaaU2muYR5MO7NN/9vgdYFwzEIoQ3NWRbSi5NNBPmzznvizoAIC4?=
 =?us-ascii?Q?KSr4HPrAm/ux88f7lUv7pwBi2e+6bOvhxnJTRVbLdTvKkKyxyhy3LKIcO4Lc?=
 =?us-ascii?Q?EOFFAg7mRy0RCh3Id03nscISu/Hju3YLQuRk?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:52.7322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e2b17d-78da-4cc2-3007-08ddbb61588f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055

Add a new vEVENTQ type for VINTFs that are assigned to the user space.
Simply report the two 64-bit LVCMDQ_ERR_MAPs register values.

Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h                  | 15 +++++++++++++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 22 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 4e81610390c7..111ea81f91a2 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1145,10 +1145,12 @@ struct iommufd_vevent_header {
  * enum iommu_veventq_type - Virtual Event Queue Type
  * @IOMMU_VEVENTQ_TYPE_DEFAULT: Reserved for future use
  * @IOMMU_VEVENTQ_TYPE_ARM_SMMUV3: ARM SMMUv3 Virtual Event Queue
+ * @IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension IRQ
  */
 enum iommu_veventq_type {
 	IOMMU_VEVENTQ_TYPE_DEFAULT = 0,
 	IOMMU_VEVENTQ_TYPE_ARM_SMMUV3 = 1,
+	IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV = 2,
 };
 
 /**
@@ -1172,6 +1174,19 @@ struct iommu_vevent_arm_smmuv3 {
 	__aligned_le64 evt[4];
 };
 
+/**
+ * struct iommu_vevent_tegra241_cmdqv - Tegra241 CMDQV IRQ
+ *                                      (IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV)
+ * @lvcmdq_err_map: 128-bit logical vcmdq error map, little-endian.
+ *                  (Refer to register LVCMDQ_ERR_MAPs per VINTF )
+ *
+ * The 128-bit register value from HW exclusively reflect the error bits for a
+ * Virtual Interface represented by a vIOMMU object. Read and report directly.
+ */
+struct iommu_vevent_tegra241_cmdqv {
+	__aligned_le64 lvcmdq_err_map[2];
+};
+
 /**
  * struct iommu_veventq_alloc - ioctl(IOMMU_VEVENTQ_ALLOC)
  * @size: sizeof(struct iommu_veventq_alloc)
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 3eeb8444fadf..d5d43a1c7708 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -295,6 +295,20 @@ static inline int vcmdq_write_config(struct tegra241_vcmdq *vcmdq, u32 regval)
 
 /* ISR Functions */
 
+static void tegra241_vintf_user_handle_error(struct tegra241_vintf *vintf)
+{
+	struct iommufd_viommu *viommu = &vintf->vsmmu.core;
+	struct iommu_vevent_tegra241_cmdqv vevent_data;
+	int i;
+
+	for (i = 0; i < LVCMDQ_ERR_MAP_NUM_64; i++)
+		vevent_data.lvcmdq_err_map[i] =
+			readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(i)));
+
+	iommufd_viommu_report_event(viommu, IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
+				    &vevent_data, sizeof(vevent_data));
+}
+
 static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
 {
 	int i;
@@ -340,6 +354,14 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 		vintf_map &= ~BIT_ULL(0);
 	}
 
+	/* Handle other user VINTFs and their LVCMDQs */
+	while (vintf_map) {
+		unsigned long idx = __ffs64(vintf_map);
+
+		tegra241_vintf_user_handle_error(cmdqv->vintfs[idx]);
+		vintf_map &= ~BIT_ULL(idx);
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
2.43.0


