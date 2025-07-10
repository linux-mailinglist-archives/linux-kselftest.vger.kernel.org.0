Return-Path: <linux-kselftest+bounces-36916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C22D7AFF8EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8C07BBD0F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0028BA9D;
	Thu, 10 Jul 2025 06:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="elcY0ABF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB628B7DF;
	Thu, 10 Jul 2025 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127234; cv=fail; b=sEMMU1pNgf0ENaldny/YcZw9wq5RVafNFrLeYiLWdLdNUYE5RvOY1LLz+CXyzVr3SkPi4msBhYet6YxXBf1wVZm0JqD7S35NIz7xM3HnuZSwWc6gSNC3sKsgEfTn7eZS2JVif3oB59kN3elLB6DAbwN7k1jTbL4uIad41lZVVI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127234; c=relaxed/simple;
	bh=J5HL1Th0vveSm5dklbe+HuJr2wyotXUGO7tk61u8DM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nuLvhfEJzWnbDr52DT2GrIWFg+XfM/7AXu846ZaBi2jq8zKxVZxNvAO6m6JuYtl8lE+KCY6TzsPB4xUZm8OK1p4CiNXq3az+hhAn6lE6X35SrJz9jKPDMPZ79qx3wJc4Qc1u0gxs+XZvENyucK++lOgfX1mmbR7vP4/6puywckk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=elcY0ABF; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4/aONOOqNrh0yFPWqOS3r2ptaRfuNEv5PZ2PM0v1sMakxozFsrKmJMklbW9zwQo3juU6IK8cabKELeUyQqX3a8DofurrFYNxSzQtmGgTfEIkIrHidr1MAQE32tXDiuzu2GSBwcgEdvwYhyvB0t7G7sBZMAqobZF/eP4YL+WB4Z353n1+/9IvIuMZVQsvnU/BNbaq6v5I/hBzAYaJYkAA4vSJ/XRlTvVxDHSxIoQ/Bf/dAHr9KPKYfJQ9WcfWaD95vXjuGfv91vB30rJLxUUfiKB8wryxaTXirAqOXJk9h+YhnDy5Kku8BopGy35EKkMKc6YTybEILFU1pd0ekh4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEwkn196grwHSTrTpdQSB5H/jEkkNVE/IRDq1mwKt/Q=;
 b=TZB51XlLlFdETFc5zrP/0EcDrSQGeIcBmEuRMhrc0q/QreMUJAs9r+dOyPtc/sl88Qn8kGcAIFDDMKNuEw9ffDFByIEP5Q5ZprcQ8s1TTZ3b9tz1Skh0y+Cr4VbR8mWXtYnjzQMuZTzLKyAp9jTcYkSpQ7t3kOdVvQlysXoUCrB4psE9IaKyuC7bB3huYhKmKdjYM0VFyTqIXgT84J+goJ3dxG/3P2aQv/gEL+dRwdTkDcfQoFHfO1huPzDoFQiE1H8rzniJQ7B2xbsQw/dnpsrKI01ipusP8tqylzvnwqZddKmAE8kArEBQjGUL6gpi8TFyJCzfFEQuz3z05vQ7Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEwkn196grwHSTrTpdQSB5H/jEkkNVE/IRDq1mwKt/Q=;
 b=elcY0ABFk1ekB5Iaw2g4OANaNp9T+F3K10epiGH9Nw7xnFCtEiholRUQE19lr9TY3OtbY8+dkkCBspWREJ7Pgm06RkgBbTMWvxzNG9nqqslZpuGBoYqUlO9uY2GTnB+vPIunangpVihOTp/Gh6E3anZm8lxv+fwrsE2kUeiyxRRbw4VnlSQkz0akKpiBNXGdqECEGMG2wDq2J3P8dG9we40QKMbEr0HQodnw7/2dCCaBDnweB1/rrFKttuoCU5CcTEdQKFB+PeHOWkhDNz2yaQPv6DvHQNjQkZ6ItjVqXmxVDIITGI7gXBjfduG+feWAtUtyUj7EonTKjg8N9WZaQQ==
Received: from CH2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:610:50::37)
 by CY1PR12MB9627.namprd12.prod.outlook.com (2603:10b6:930:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 10 Jul
 2025 06:00:27 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::8a) by CH2PR16CA0027.outlook.office365.com
 (2603:10b6:610:50::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:27 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v9 12/29] iommufd/viommu: Add driver-defined vDEVICE support
Date: Wed, 9 Jul 2025 22:59:04 -0700
Message-ID: <1e751c01da7863c669314d8e27fdb89eabcf5605.1752126748.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752126748.git.nicolinc@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|CY1PR12MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0ffd00-7fb2-444b-dda3-08ddbf7711c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U4qyjacwM5QkqMVxLJolF2q1mdfdjz5/eJJIV6xxzS/eyOd+ptQSv0zYZ+fy?=
 =?us-ascii?Q?XcUgdjwo4CIZginmyBC+OZraIERggPx1XezRdQrWmnqH8n5TuA9BSWkMRqFF?=
 =?us-ascii?Q?tMcvclVpGR952OnA2uCBoqbU8U3y6t3hAbhcdekPhARDBjd9q9pt06gnbTM4?=
 =?us-ascii?Q?ogkISi4QQDLFn/8U9I1Tisj/kPT43tKoMS0+ECWxrFNBZtLT0QXYdBqpa5I4?=
 =?us-ascii?Q?sX17huZjPPe05i+7DAIJULMiTcKpzwZJcVUyHaWGOZdTiCndPXDgY7AQTKdt?=
 =?us-ascii?Q?12NVKff5h8By5Ja22YO6sSKu62IDmCgmGit1Rytq2tOy4x68cvV4VyJsBjEJ?=
 =?us-ascii?Q?1sBmPrQT3bCHaUbpl6aSiepZBVC5a3UfqWQxgie6uA70eUGYa8tFh/lMymaE?=
 =?us-ascii?Q?p1QB/SylWbptiVtgQc3Y18dosivxiV9GSf33BWtHi26Qae8LUKADQJypm/eK?=
 =?us-ascii?Q?XeSnSmkNEj+vS3Gu5znCi2n7J/MZ8s251ldkrkp6G1aDfRX1/id7mAYu3p9f?=
 =?us-ascii?Q?YJx3DsiSGKpzlyI0LMVtbgjcoLoxFHY6uw0vxqIG1iY0LhHCgPgHR/wAgfds?=
 =?us-ascii?Q?lml5+mTNB45qvrqR4eUYNcdHcmDw/Z35TheGIdd7TXfQWp+BbBCgJdEflWiO?=
 =?us-ascii?Q?gSm4M1HvWcAgfNjo0pOESjXyh+L+bM1DBFC5EyHxBTTP3FVjJgkcp9oTfLEh?=
 =?us-ascii?Q?tEUve54avfFJmtzGKukqx9AU+Gbc56loZRjG+aeK+w0Qa81oOMruiJzk/rUS?=
 =?us-ascii?Q?3bjvU7THPghCQvW5KLLgXbuin5T7HefbO/GEmPvkF++zNzFiGNrXLU5TRzFk?=
 =?us-ascii?Q?qpA+OEShEaBY1wIJXjYXbrpvJL2IdyFobYEbXa/8AKFRh/UvUv8BzwgUp6BK?=
 =?us-ascii?Q?d0nHj/6Vh1jYdKAMjWNHIN4LTTnAjEYA+AgfNURoIXkAmm2fO1YWWEIm8W2y?=
 =?us-ascii?Q?285s4TOy1wsXki1+NS0UtZM4EnZRvLHnoDpwVvkciwdrfjucmBw/pX5fLtQj?=
 =?us-ascii?Q?wogNlYm8er0+/GQn6Tzv0iFexjrEB+hZf4pBhTg66yXR8oaDM1ABYNSc1uw9?=
 =?us-ascii?Q?9qxWgSu5BOmjpGGkhWJavbPiyTfBgIhsaFGhtW8LGpQPg/vVIKdDYgotIbsT?=
 =?us-ascii?Q?cNJs5pSW8uJ8lW1Fy5oKlTesGJe1NHTS4Y8sGmv+Cw9X/kdBfCfuwQegnoh8?=
 =?us-ascii?Q?dWJh0wdvS9kSr4pX1n79xr7npSg9hcrlSjfBRELx+i/sgyWdlWFgdfSm1b7z?=
 =?us-ascii?Q?+hxiAAFIjzJuFnE/8+O7+R3kaBvWemVUNG0b5kOfe6jTCdXAWckR7G6poaOb?=
 =?us-ascii?Q?8s4VRIQ8HkLo89awPX95VUI5SVV/8zaG1oyQr4MHUaf9n64c6mNUuf3HJHEW?=
 =?us-ascii?Q?sMf4OIywOY2yz9VGYPPRAEyySL2H4dSH2elFwQqtBO6r3dH/QysDe+a6/Jke?=
 =?us-ascii?Q?BoQMfj9Nz4swZl3K69DyUzGGEKMLN9OFBYM5bU5fb/1tIU4+k5oN+tCUTFJc?=
 =?us-ascii?Q?S2BQMnIvbLRy1TcHA3KaS+hyAg0ttK5Jk8KY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:27.4725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0ffd00-7fb2-444b-dda3-08ddbf7711c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9627

NVIDIA VCMDQ driver will have a driver-defined vDEVICE structure and do
some HW configurations with that.

To allow IOMMU drivers to define their own vDEVICE structures, move the
struct iommufd_vdevice to the public header and provide a pair of viommu
ops, similar to get_viommu_size and viommu_init.

Doing this, however, creates a new window between the vDEVICE allocation
and its driver-level initialization, during which an abort could happen
but it can't invoke a driver destroy function from the struct viommu_ops
since the driver structure isn't initialized yet. vIOMMU object doesn't
have this problem, since its destroy op is set via the viommu_ops by the
driver viommu_init function. Thus, vDEVICE should do something similar:
add a destroy function pointer inside the struct iommufd_vdevice instead
of the struct iommufd_viommu_ops.

Note that there is unlikely a use case for a type dependent vDEVICE, so
a static vdevice_size is probably enough for the near term instead of a
get_vdevice_size function op.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 12 ----------
 include/linux/iommufd.h                 | 31 +++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu.c          | 26 ++++++++++++++++++++-
 3 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9fdbf5f21f2e..06b8c2e2d9e6 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -653,18 +653,6 @@ void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
 
-struct iommufd_vdevice {
-	struct iommufd_object obj;
-	struct iommufd_viommu *viommu;
-	struct device *dev;
-
-	/*
-	 * Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID of
-	 * AMD IOMMU, and vRID of Intel VT-d
-	 */
-	u64 virt_id;
-};
-
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 2d1bf2f97ee3..bdd10a85eeef 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -104,6 +104,21 @@ struct iommufd_viommu {
 	enum iommu_viommu_type type;
 };
 
+struct iommufd_vdevice {
+	struct iommufd_object obj;
+	struct iommufd_viommu *viommu;
+	struct device *dev;
+
+	/*
+	 * Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID of
+	 * AMD IOMMU, and vRID of Intel VT-d
+	 */
+	u64 virt_id;
+
+	/* Clean up all driver-specific parts of an iommufd_vdevice */
+	void (*destroy)(struct iommufd_vdevice *vdev);
+};
+
 /**
  * struct iommufd_viommu_ops - vIOMMU specific operations
  * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
@@ -120,6 +135,14 @@ struct iommufd_viommu {
  *                    array->entry_num to report the number of handled requests.
  *                    The data structure of the array entry must be defined in
  *                    include/uapi/linux/iommufd.h
+ * @vdevice_size: Size of the driver-defined vDEVICE structure per this vIOMMU
+ * @vdevice_init: Initialize the driver-level structure of a vDEVICE object, or
+ *                related HW procedure. @vdev is already initialized by iommufd
+ *                core: vdev->dev and vdev->viommu pointers; vdev->id carries a
+ *                per-vIOMMU virtual ID (refer to struct iommu_vdevice_alloc in
+ *                include/uapi/linux/iommufd.h)
+ *                If driver has a deinit function to revert what vdevice_init op
+ *                does, it should set it to the @vdev->destroy function pointer
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
@@ -128,6 +151,8 @@ struct iommufd_viommu_ops {
 		const struct iommu_user_data *user_data);
 	int (*cache_invalidate)(struct iommufd_viommu *viommu,
 				struct iommu_user_data_array *array);
+	const size_t vdevice_size;
+	int (*vdevice_init)(struct iommufd_vdevice *vdev);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -224,4 +249,10 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 	 BUILD_BUG_ON_ZERO(offsetof(drv_struct, member)) +                     \
 	 BUILD_BUG_ON_ZERO(!__same_type(struct iommufd_viommu,                 \
 					((drv_struct *)NULL)->member)))
+
+#define VDEVICE_STRUCT_SIZE(drv_struct, member)                                \
+	(sizeof(drv_struct) +                                                  \
+	 BUILD_BUG_ON_ZERO(offsetof(drv_struct, member)) +                     \
+	 BUILD_BUG_ON_ZERO(!__same_type(struct iommufd_vdevice,                \
+					((drv_struct *)NULL)->member)))
 #endif
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index c0365849f849..081ee6697a11 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -116,6 +116,8 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
 
+	if (vdev->destroy)
+		vdev->destroy(vdev);
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->virt_id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
@@ -126,6 +128,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_vdevice_alloc *cmd = ucmd->cmd;
 	struct iommufd_vdevice *vdev, *curr;
+	size_t vdev_size = sizeof(*vdev);
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
 	u64 virt_id = cmd->virt_id;
@@ -150,7 +153,22 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
-	vdev = iommufd_object_alloc_ucmd(ucmd, vdev, IOMMUFD_OBJ_VDEVICE);
+	if (viommu->ops && viommu->ops->vdevice_size) {
+		/*
+		 * It is a driver bug for:
+		 * - ops->vdevice_size smaller than the core structure size
+		 * - not implementing a pairing ops->vdevice_init op
+		 */
+		if (WARN_ON_ONCE(viommu->ops->vdevice_size < vdev_size ||
+				 !viommu->ops->vdevice_init)) {
+			rc = -EOPNOTSUPP;
+			goto out_put_idev;
+		}
+		vdev_size = viommu->ops->vdevice_size;
+	}
+
+	vdev = (struct iommufd_vdevice *)_iommufd_object_alloc_ucmd(
+		ucmd, vdev_size, IOMMUFD_OBJ_VDEVICE);
 	if (IS_ERR(vdev)) {
 		rc = PTR_ERR(vdev);
 		goto out_put_idev;
@@ -168,6 +186,12 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
+	if (viommu->ops && viommu->ops->vdevice_init) {
+		rc = viommu->ops->vdevice_init(vdev);
+		if (rc)
+			goto out_put_idev;
+	}
+
 	cmd->out_vdevice_id = vdev->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
-- 
2.43.0


